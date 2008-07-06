From: Ben-Ami Yassour <benami@il.ibm.com>
Subject: Re: [PATCH 1/4] KVM: Introduce kvm_set_irq to inject interrupts in
	guests
Date: Sun, 06 Jul 2008 16:50:51 +0300
Message-ID: <1215352251.31546.73.camel@cluwyn.haifa.ibm.com>
References: <1214571305-20701-1-git-send-email-amit.shah@qumranet.com>
	 <1214571305-20701-2-git-send-email-amit.shah@qumranet.com>
	 <486F5570.8010500@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <486F5570.8010500@qumranet.com>
Sender: kvm-owner@vger.kernel.org
To: Avi Kivity <avi@qumranet.com>
Cc: Amit Shah <amit.shah@qumranet.com>, kvm@vger.kernel.org, Muli Ben-Yehuda <muli@il.ibm.com>, allen.m.kay@intel.com, chrisw@redhat.com, weidong.han@intel.com, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Sat, 2008-07-05 at 14:05 +0300, Avi Kivity wrote:
> Amit Shah wrote:
> > This function injects an interrupt into the guest given the kvm str=
uct,
> > the (guest) irq number and the interrupt level.
> >
> > Signed-off-by: Amit Shah <amit.shah@qumranet.com>
> > ---
> >  arch/x86/kvm/irq.c |   11 +++++++++++
> >  arch/x86/kvm/irq.h |    2 ++
> >  2 files changed, 13 insertions(+), 0 deletions(-)
> >
> > diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
> > index 76d736b..0d9e552 100644
> > --- a/arch/x86/kvm/irq.c
> > +++ b/arch/x86/kvm/irq.c
> > @@ -100,3 +100,14 @@ void __kvm_migrate_timers(struct kvm_vcpu *vcp=
u)
> >  	__kvm_migrate_apic_timer(vcpu);
> >  	__kvm_migrate_pit_timer(vcpu);
> >  }
> > +
> > +/* This should be called with the kvm->lock mutex held */
> > +void kvm_set_irq(struct kvm *kvm, int irq, int level)
> > +{
> > +	/* Not possible to detect if the guest uses the PIC or the
> > +	 * IOAPIC.  So set the bit in both. The guest will ignore
> > +	 * writes to the unused one.
> > +	 */
> > +	kvm_ioapic_set_irq(kvm->arch.vioapic, irq, level);
> > +	kvm_pic_set_irq(pic_irqchip(kvm), irq, level);
> > +}
> >  =20
>=20
> pic supports only irqs 0-15.
>=20
> I guess instead of adding the check here, better move it into i8259.c=
=20
> and ioapic.c.
>=20
>=20

Do you mean something like the patch below?
( in the ioapic code there is already a check for the irq: =EF=BB=BFif =
(irq >=3D 0 && irq < IOAPIC_NUM_PINS) )

Thanks,
Ben

diff --git a/arch/x86/kvm/i8259.c b/arch/x86/kvm/i8259.c
index 3ba5e5c..c2c4884 100644
--- a/arch/x86/kvm/i8259.c
+++ b/arch/x86/kvm/i8259.c
@@ -130,8 +130,10 @@ void kvm_pic_set_irq(void *opaque, int irq, int le=
vel)
 {
 	struct kvm_pic *s =3D opaque;
=20
-	pic_set_irq1(&s->pics[irq >> 3], irq & 7, level);
-	pic_update_irq(s);
+	if (irq >=3D 0 && irq < PIC_NUM_PINS) {
+		pic_set_irq1(&s->pics[irq >> 3], irq & 7, level);
+		pic_update_irq(s);
+	}
 }
=20
 /*
diff --git a/arch/x86/kvm/irq.h b/arch/x86/kvm/irq.h
index bef9127..e9c7b3f 100644
--- a/arch/x86/kvm/irq.h
+++ b/arch/x86/kvm/irq.h
@@ -30,6 +30,8 @@
 #include "ioapic.h"
 #include "lapic.h"
=20
+#define PIC_NUM_PINS 15
+
 struct kvm;
 struct kvm_vcpu;
=20


