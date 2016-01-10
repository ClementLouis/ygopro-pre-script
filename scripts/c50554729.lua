--Amorphage Infection
--By: HelixReactor
function c50554729.initial_effect(c)
	--Activate
	local e1=Effect.CreateEffect(c)
	e1:SetType(EFFECT_TYPE_ACTIVATE)
	e1:SetCode(EVENT_FREE_CHAIN)
	c:RegisterEffect(e1)
	--Stats up
	local e2=Effect.CreateEffect(c)
	e2:SetType(EFFECT_TYPE_FIELD)
	e2:SetCode(EFFECT_UPDATE_ATTACK)
	e2:SetRange(LOCATION_SZONE)
	e2:SetTargetRange(LOCATION_MZONE,LOCATION_MZONE)
	e2:SetTarget(c50554729.stg)
	e2:SetValue(c50554729.value)
	c:RegisterEffect(e2)
	local e3=e2:Clone()
	e3:SetCode(EFFECT_UPDATE_DEFENCE)
	c:RegisterEffect(e3)
	--To Hand
	local e4=Effect.CreateEffect(c)
	e4:SetCategory(CATEGORY_SEARCH+CATEGORY_TOHAND)
	e4:SetType(EFFECT_TYPE_FIELD+EFFECT_TYPE_TRIGGER_O)
	e4:SetProperty(EFFECT_FLAG_DELAY+EFFECT_FLAG_DAMAGE_STEP)
	e4:SetCode(EVENT_RELEASE)
	e4:SetRange(LOCATION_SZONE)
	e4:SetCountLimit(1,50554729)
	e4:SetCondition(c50554729.thcon)
	e4:SetTarget(c50554729.thtg)
	e4:SetOperation(c50554729.thop)
	c:RegisterEffect(e4)
	local e5=e4:Clone()
	e5:SetCode(EVENT_DESTROYED)
	c:RegisterEffect(e5)
end
function c50554729.stg(e,c)
	return c:IsSetCard(0x1d1) 
end
function c50554729.stfilter(c)
	return c:IsFaceup() and c:IsSetCard(0x1d1) 
end
function c50554729.value(e,c)
	return Duel.GetMatchingGroupCount(c50554729.stfilter,c:GetControler(),LOCATION_ONFIELD,LOCATION_ONFIELD,nil)*100
end
function c50554729.confilter(c,tp)
	return c:IsType(TYPE_MONSTER) and c:IsReason(REASON_BATTLE+REASON_EFFECT+REASON_RELEASE)
		and c:IsPreviousLocation(LOCATION_MZONE+LOCATION_HAND) and c:GetPreviousControler()==tp
end
function c50554729.thcon(e,tp,eg,ep,ev,re,r,rp)
	return eg:IsExists(c50554729.confilter,1,nil,tp)
end
function c50554729.thfilter(c)
	return c:IsSetCard(0x1d1) and c:IsAbleToHand()
end
function c50554729.thtg(e,tp,eg,ep,ev,re,r,rp,chk)
	if chk==0 then return Duel.IsExistingMatchingCard(c50554729.thfilter,tp,LOCATION_DECK,0,1,nil) end
	Duel.SetOperationInfo(0,CATEGORY_TOHAND,nil,1,tp,LOCATION_DECK)
end
function c50554729.thop(e,tp,eg,ep,ev,re,r,rp)
	Duel.Hint(HINT_SELECTMSG,tp,HINTMSG_ATOHAND)
	local g=Duel.SelectMatchingCard(tp,c50554729.thfilter,tp,LOCATION_DECK,0,1,1,nil)
	if g:GetCount()>0 then
		Duel.SendtoHand(g,nil,REASON_EFFECT)
		Duel.ConfirmCards(1-tp,g)
	end
end