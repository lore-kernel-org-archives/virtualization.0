Return-Path: <SRS0=oNZg=CQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23C56C433E2
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 13:16:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC99E21741
	for <virtualization@archiver.kernel.org>; Mon,  7 Sep 2020 13:16:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC99E21741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=8bytes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7EFA686720;
	Mon,  7 Sep 2020 13:16:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Us6ar42LDGrn; Mon,  7 Sep 2020 13:16:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2B5CC86752;
	Mon,  7 Sep 2020 13:16:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 200D3C0859;
	Mon,  7 Sep 2020 13:16:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEBB3C0051
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:16:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E850785F4B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:16:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z1ZP4AcSrWuc
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:16:45 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from theia.8bytes.org (8bytes.org [81.169.241.247])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id A21AB85E9F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Sep 2020 13:16:45 +0000 (UTC)
Received: from cap.home.8bytes.org (p549add56.dip0.t-ipconnect.de
 [84.154.221.86])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
 (No client certificate requested)
 by theia.8bytes.org (Postfix) with ESMTPSA id AF0E334A;
 Mon,  7 Sep 2020 15:16:42 +0200 (CEST)
From: Joerg Roedel <joro@8bytes.org>
To: x86@kernel.org
Subject: [PATCH v7 01/72] KVM: SVM: nested: Don't allocate VMCB structures on
 stack
Date: Mon,  7 Sep 2020 15:15:02 +0200
Message-Id: <20200907131613.12703-2-joro@8bytes.org>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200907131613.12703-1-joro@8bytes.org>
References: <20200907131613.12703-1-joro@8bytes.org>
MIME-Version: 1.0
Cc: Juergen Gross <jgross@suse.com>, Tom Lendacky <thomas.lendacky@amd.com>,
 Joerg Roedel <jroedel@suse.de>, Mike Stunes <mstunes@vmware.com>,
 Kees Cook <keescook@chromium.org>, kvm@vger.kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Cfir Cohen <cfir@google.com>,
 Joerg Roedel <joro@8bytes.org>, Dave Hansen <dave.hansen@linux.intel.com>,
 linux-kernel@vger.kernel.org,
 Sean Christopherson <sean.j.christopherson@intel.com>,
 virtualization@lists.linux-foundation.org,
 Martin Radev <martin.b.radev@gmail.com>,
 Masami Hiramatsu <mhiramat@kernel.org>, Andy Lutomirski <luto@kernel.org>,
 hpa@zytor.com, Erdem Aktas <erdemaktas@google.com>,
 David Rientjes <rientjes@google.com>, Dan Williams <dan.j.williams@intel.com>,
 Jiri Slaby <jslaby@suse.cz>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: Joerg Roedel <jroedel@suse.de>

Do not allocate a vmcb_control_area and a vmcb_save_area on the stack,
as these structures will become larger with future extenstions of
SVM and thus the svm_set_nested_state() function will become a too large
stack frame.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
---
 arch/x86/kvm/svm/nested.c | 47 +++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index fb68467e6049..28036629abf8 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1060,10 +1060,14 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	struct vmcb *hsave = svm->nested.hsave;
 	struct vmcb __user *user_vmcb = (struct vmcb __user *)
 		&user_kvm_nested_state->data.svm[0];
-	struct vmcb_control_area ctl;
-	struct vmcb_save_area save;
+	struct vmcb_control_area *ctl;
+	struct vmcb_save_area *save;
+	int ret;
 	u32 cr0;
 
+	BUILD_BUG_ON(sizeof(struct vmcb_control_area) + sizeof(struct vmcb_save_area) >
+		     KVM_STATE_NESTED_SVM_VMCB_SIZE);
+
 	if (kvm_state->format != KVM_STATE_NESTED_FORMAT_SVM)
 		return -EINVAL;
 
@@ -1095,13 +1099,22 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 		return -EINVAL;
 	if (kvm_state->size < sizeof(*kvm_state) + KVM_STATE_NESTED_SVM_VMCB_SIZE)
 		return -EINVAL;
-	if (copy_from_user(&ctl, &user_vmcb->control, sizeof(ctl)))
-		return -EFAULT;
-	if (copy_from_user(&save, &user_vmcb->save, sizeof(save)))
-		return -EFAULT;
 
-	if (!nested_vmcb_check_controls(&ctl))
-		return -EINVAL;
+	ret  = -ENOMEM;
+	ctl  = kzalloc(sizeof(*ctl),  GFP_KERNEL);
+	save = kzalloc(sizeof(*save), GFP_KERNEL);
+	if (!ctl || !save)
+		goto out_free;
+
+	ret = -EFAULT;
+	if (copy_from_user(ctl, &user_vmcb->control, sizeof(*ctl)))
+		goto out_free;
+	if (copy_from_user(save, &user_vmcb->save, sizeof(*save)))
+		goto out_free;
+
+	ret = -EINVAL;
+	if (!nested_vmcb_check_controls(ctl))
+		goto out_free;
 
 	/*
 	 * Processor state contains L2 state.  Check that it is
@@ -1109,15 +1122,15 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	 */
 	cr0 = kvm_read_cr0(vcpu);
         if (((cr0 & X86_CR0_CD) == 0) && (cr0 & X86_CR0_NW))
-                return -EINVAL;
+		goto out_free;
 
 	/*
 	 * Validate host state saved from before VMRUN (see
 	 * nested_svm_check_permissions).
 	 * TODO: validate reserved bits for all saved state.
 	 */
-	if (!(save.cr0 & X86_CR0_PG))
-		return -EINVAL;
+	if (!(save->cr0 & X86_CR0_PG))
+		goto out_free;
 
 	/*
 	 * All checks done, we can enter guest mode.  L1 control fields
@@ -1126,15 +1139,21 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	 * contains saved L1 state.
 	 */
 	copy_vmcb_control_area(&hsave->control, &svm->vmcb->control);
-	hsave->save = save;
+	hsave->save = *save;
 
 	svm->nested.vmcb = kvm_state->hdr.svm.vmcb_pa;
-	load_nested_vmcb_control(svm, &ctl);
+	load_nested_vmcb_control(svm, ctl);
 	nested_prepare_vmcb_control(svm);
 
 out_set_gif:
 	svm_set_gif(svm, !!(kvm_state->flags & KVM_STATE_NESTED_GIF_SET));
-	return 0;
+
+	ret = 0;
+out_free:
+	kfree(save);
+	kfree(ctl);
+
+	return ret;
 }
 
 struct kvm_x86_nested_ops svm_nested_ops = {
-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
