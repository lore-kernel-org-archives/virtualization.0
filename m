From: Avi Kivity <avi@qumranet.com>
Subject: Re: [PATCH 2/4] KVM: Introduce a callback routine for IOAPIC ack
 handling
Date: Thu, 17 Jul 2008 20:25:18 +0300
Message-ID: <487F807E.30909@qumranet.com>
References: <1214571305-20701-1-git-send-email-amit.shah@qumranet.com>	 <1214571305-20701-2-git-send-email-amit.shah@qumranet.com>	 <1214571305-20701-3-git-send-email-amit.shah@qumranet.com>	 <4871EB36.5030003@qumranet.com>	 <1215513283.31546.133.camel@cluwyn.haifa.ibm.com>	 <48761558.3070703@qumranet.com> <1216313795.31546.342.camel@cluwyn.haifa.ibm.com> <487F7E54.7030303@qumranet.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------040605070007030807060607"
Return-path: <kvm-owner@vger.kernel.org>
In-Reply-To: <487F7E54.7030303@qumranet.com>
Sender: kvm-owner@vger.kernel.org
To: Ben-Ami Yassour <benami@il.ibm.com>
Cc: Amit Shah <amit.shah@qumranet.com>, kvm@vger.kernel.org, Muli Ben-Yehuda <muli@il.ibm.com>, allen.m.kay@intel.com, chrisw@redhat.com, weidong.han@intel.com, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

This is a multi-part message in MIME format.
--------------040605070007030807060607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Avi Kivity wrote:
> Ben-Ami Yassour wrote:
>>>>         
>>> I did, and have something very similar queued.
>>>     
>>
>> The notification list might help simplify the assigned device code.
>> Are you planning to merge the patch you have queued, or should I use the
>> one that I sent you?
>>
>>   
>
> I'll dig mine up tomorrow and post it, so you can tell if it fits your 
> needs.
>

Since the chances of me remembering to do this tomorrow are slim, here 
it is.  Note that it hasn't been wired to the pic and ioapic yet, but 
that should be easy.  Hasn't been tested either.

-- 
I have a truly marvellous patch that fixes the bug which this
signature is too narrow to contain.


--------------040605070007030807060607
Content-Type: text/plain;
 name="ack-notifier-list.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ack-notifier-list.patch"

From ed7fe282c23ab47a5a306277ea1010039d094ea6 Mon Sep 17 00:00:00 2001
From: Avi Kivity <avi@qumranet.com>
Date: Mon, 7 Jul 2008 14:48:46 +0300
Subject: [PATCH] KVM: Add irq ack notifier list

This can be used by kvm subsystems that are interested in when interrupts
are acked, for example time drift compenstation.

Signed-off-by: Avi Kivity <avi@qumranet.com>

diff --git a/arch/x86/kvm/irq.c b/arch/x86/kvm/irq.c
index 0d9e552..9091195 100644
--- a/arch/x86/kvm/irq.c
+++ b/arch/x86/kvm/irq.c
@@ -111,3 +111,25 @@ void kvm_set_irq(struct kvm *kvm, int irq, int level)
 	kvm_ioapic_set_irq(kvm->arch.vioapic, irq, level);
 	kvm_pic_set_irq(pic_irqchip(kvm), irq, level);
 }
+
+void kvm_notify_acked_irq(struct kvm *kvm, unsigned gsi)
+{
+	struct kvm_irq_ack_notifier *kian;
+	struct hlist_node *n;
+
+	hlist_for_each_entry(kian, n, &kvm->arch.irq_ack_notifier_list, link)
+		if (kian->gsi == gsi)
+			kian->irq_acked(kian);
+}
+
+void kvm_register_irq_ack_notifier(struct kvm *kvm,
+				   struct kvm_irq_ack_notifier *kian)
+{
+	hlist_add_head(&kian->link, &kvm->arch.irq_ack_notifier_list);
+}
+
+void kvm_unregister_irq_ack_notifier(struct kvm *kvm,
+				     struct kvm_irq_ack_notifier *kian)
+{
+	hlist_del(&kian->link);
+}
diff --git a/arch/x86/kvm/irq.h b/arch/x86/kvm/irq.h
index 07ff2ae..95fe718 100644
--- a/arch/x86/kvm/irq.h
+++ b/arch/x86/kvm/irq.h
@@ -83,6 +83,11 @@ static inline int irqchip_in_kernel(struct kvm *kvm)
 void kvm_pic_reset(struct kvm_kpic_state *s);
 
 void kvm_set_irq(struct kvm *kvm, int irq, int level);
+void kvm_notify_acked_irq(struct kvm *kvm, unsigned gsi);
+void kvm_register_irq_ack_notifier(struct kvm *kvm,
+				   struct kvm_irq_ack_notifier *kian);
+void kvm_unregister_irq_ack_notifier(struct kvm *kvm,
+				     struct kvm_irq_ack_notifier *kian);
 
 void kvm_timer_intr_post(struct kvm_vcpu *vcpu, int vec);
 void kvm_inject_pending_timer_irqs(struct kvm_vcpu *vcpu);
diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c7bad53..a016900 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -3948,6 +3948,7 @@ struct  kvm *kvm_arch_create_vm(void)
 		return ERR_PTR(-ENOMEM);
 
 	INIT_LIST_HEAD(&kvm->arch.active_mmu_pages);
+	INIT_HLIST_HEAD(&kvm->arch.irq_ack_notifier_list);
 
 	return kvm;
 }
diff --git a/include/asm-x86/kvm_host.h b/include/asm-x86/kvm_host.h
index b893a85..73756e5 100644
--- a/include/asm-x86/kvm_host.h
+++ b/include/asm-x86/kvm_host.h
@@ -314,6 +314,12 @@ struct kvm_mem_alias {
 	gfn_t target_gfn;
 };
 
+struct kvm_irq_ack_notifier {
+	struct hlist_node link;
+	unsigned gsi;
+	void (*irq_acked)(struct kvm_irq_ack_notifier *kian);
+};
+
 struct kvm_arch{
 	int naliases;
 	struct kvm_mem_alias aliases[KVM_ALIAS_SLOTS];
@@ -329,6 +335,7 @@ struct kvm_arch{
 	struct kvm_pic *vpic;
 	struct kvm_ioapic *vioapic;
 	struct kvm_pit *vpit;
+	struct hlist_head irq_ack_notifier_list;
 
 	int round_robin_prev_vcpu;
 	unsigned int tss_addr;

--------------040605070007030807060607--
