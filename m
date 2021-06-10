Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 068B3C48BCD
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 09:22:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A937761040
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 09:22:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A937761040
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 64292401C9;
	Thu, 10 Jun 2021 09:22:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OnP83orMXZ7B; Thu, 10 Jun 2021 09:22:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BAC3440395;
	Thu, 10 Jun 2021 09:22:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A606C000E;
	Thu, 10 Jun 2021 09:22:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D42CC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 09:22:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5B670405D2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 09:22:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oD3tzf8xUgSt
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 09:22:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 75E52405D3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 09:22:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623316933;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=A78UCyddoxVj3LRURmRZUmZxc6MPDgeQuh2wS7Aw9y0=;
 b=KC6cSR37ocY7suml0hd9rk3OBA3qzPaavYPgmagKK2dLRMSgus+W8GktMr/Gp6FRYVi8sH
 vfYGU//JAfXjnFEZSWdtcWFkMhoqIbQJ4rPMZkXPSPdqI8JBjI42Q0X1WeUuhABXHcVEm9
 4EqxF66ACC7yaxO5XkE0p0VTrgkBeuM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-267-6MMrfgBVNVWN9qknW8Wq8w-1; Thu, 10 Jun 2021 05:22:11 -0400
X-MC-Unique: 6MMrfgBVNVWN9qknW8Wq8w-1
Received: by mail-wr1-f70.google.com with SMTP id
 l13-20020adfe9cd0000b0290119a0645c8fso606884wrn.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 02:22:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=A78UCyddoxVj3LRURmRZUmZxc6MPDgeQuh2wS7Aw9y0=;
 b=R/CO9m4ZMz/VSi+GHodMiMqeXEVIZQZOdJyqY7gVL0AjK3C9oNwSLuQY1f5vYQBcMt
 +9Y/x3A+f6i1prPBaymndhFDnh8CmIrYGbGH0ursjlpnOm80rqbNJvmJHIjGj52OOI7q
 Mu9w5xNSzGXSuHWbdh2rWeCfxmIRFn0zVxrZBFOwfXaP7e8oAyV6zcQt5o/BBf6TDAn2
 BHfrSG5rV0AWdsK60uFaPjP9XsjG9+emsHvj0lz4d1wgSvFVtqXXPUeC7o79RsvAsXff
 vFh8NZnai0qV3Cqewt3NJnamNQaH5Jl97HH4+6M+wcFniLiev9iAIxJuccAD+8G9uk9e
 kynA==
X-Gm-Message-State: AOAM5313oWyb+h0VWMWkjNCln5J4di5vWU9SKZYyHpHcIsmj3QhWAnz2
 iYfnmRvYDoVZq88eU/5h6mcgOc1VzvLUs5Zb457OzjoatehUplR/n1mSSSLjXlnqdaXadfjAuKV
 oZBECx+eT0XJnoQ6K3FLhtbVa3m7D0V+KfoQ/MuHT1Q==
X-Received: by 2002:a05:6000:1365:: with SMTP id
 q5mr4296007wrz.53.1623316930268; 
 Thu, 10 Jun 2021 02:22:10 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyo0K8dEKKmGBNIzZTAkSjYM+nE1iWqCoR4BRg6JLPFlpIk8f9MQqIUP671DqB+hCjLUJSbuA==
X-Received: by 2002:a05:6000:1365:: with SMTP id
 q5mr4295985wrz.53.1623316930022; 
 Thu, 10 Jun 2021 02:22:10 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id l13sm2939323wrz.34.2021.06.10.02.22.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jun 2021 02:22:09 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Nuno Das Neves <nunodasneves@linux.microsoft.com>
Subject: Re: [PATCH 00/19] Microsoft Hypervisor root partition ioctl interface
In-Reply-To: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
References: <1622241819-21155-1-git-send-email-nunodasneves@linux.microsoft.com>
Date: Thu, 10 Jun 2021 11:22:08 +0200
Message-ID: <87bl8eyszj.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: wei.liu@kernel.org, linux-hyperv@vger.kernel.org,
 linux-kernel@vger.kernel.org, mikelley@microsoft.com, sunilmut@microsoft.com,
 virtualization@lists.linux-foundation.org, viremana@linux.microsoft.com,
 ligrassi@microsoft.com
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

Nuno Das Neves <nunodasneves@linux.microsoft.com> writes:

> This patch series provides a userspace interface for creating and running guest
> virtual machines while running on the Microsoft Hypervisor [0].
>
> Since managing guest machines can only be done when Linux is the root partition,
> this series depends on Wei Liu's patch series merged in 5.12:
> https://lore.kernel.org/linux-hyperv/20210203150435.27941-1-wei.liu@kernel.org/
>
> The first two patches provide some helpers for converting hypervisor status
> codes to linux error codes, and printing hypervisor status codes to dmesg for
> debugging.
>
> Hyper-V related headers asm-generic/hyperv-tlfs.h and x86/asm/hyperv-tlfs.h are
> split into uapi and non-uapi. The uapi versions contain structures used in both
> the ioctl interface and the kernel.
>
> The mshv API is introduced in drivers/hv/mshv_main.c. As each interface is
> introduced, documentation is added in Documentation/virt/mshv/api.rst.
> The API is file-desciptor based, like KVM. The entry point is /dev/mshv.
>
> /dev/mshv ioctls:
> MSHV_CHECK_EXTENSION
> MSHV_CREATE_PARTITION
>
> Partition (vm) ioctls:
> MSHV_MAP_GUEST_MEMORY, MSHV_UNMAP_GUEST_MEMORY
> MSHV_INSTALL_INTERCEPT
> MSHV_ASSERT_INTERRUPT
> MSHV_GET_PARTITION_PROPERTY, MSHV_SET_PARTITION_PROPERTY
> MSHV_CREATE_VP
>
> Vp (vcpu) ioctls:
> MSHV_GET_VP_REGISTERS, MSHV_SET_VP_REGISTERS
> MSHV_RUN_VP
> MSHV_GET_VP_STATE, MSHV_SET_VP_STATE
> MSHV_TRANSLATE_GVA
> mmap() (register page)
>
> [0] Hyper-V is more well-known, but it really refers to the whole stack
>     including the hypervisor and other components that run in Windows kernel
>     and userspace.
>
> Changes since RFC:
> 1. Moved code from virt/mshv to drivers/hv
> 2. Split hypercall helper functions and synic code to hv_call.c and hv_synic.c
> 3. MSHV_REQUEST_VERSION ioctl replaced with MSHV_CHECK_EXTENSION
> 3. Numerous suggestions, fixes, style changes, etc from Michael Kelley, Vitaly
>    Kuznetsov, Wei Liu, and Vineeth Pillai
> 4. Added patch to enable hypervisor enlightenments on partition creation
> 5. Added Wei Liu's patch for GVA to GPA translation
>

Thank you for addressing these!

One nitpick though: could you please run your next submission through
'scripts/checkpatch.pl'? It reports a number of issues here, mostly
minor but still worth addressing, i.e.:

$ scripts/checkpatch.pl *.patch
...
---------------------------------------------------------------
0002-asm-generic-hyperv-convert-hyperv-statuses-to-string.patch
---------------------------------------------------------------
ERROR: Macros with complex values should be enclosed in parentheses
#95: FILE: include/asm-generic/hyperv-tlfs.h:192:
+#define __HV_STATUS_DEF(OP) \
+	OP(HV_STATUS_SUCCESS,				0x0) \
...

ERROR: Macros with complex values should be enclosed in parentheses
#119: FILE: include/asm-generic/hyperv-tlfs.h:216:
+#define __HV_MAKE_HV_STATUS_ENUM(NAME, VAL) NAME = (VAL),

ERROR: Macros with multiple statements should be enclosed in a do - while loop
#120: FILE: include/asm-generic/hyperv-tlfs.h:217:
+#define __HV_MAKE_HV_STATUS_CASE(NAME, VAL) case (NAME): return (#NAME);

WARNING: Macros with flow control statements should be avoided
#120: FILE: include/asm-generic/hyperv-tlfs.h:217:
+#define __HV_MAKE_HV_STATUS_CASE(NAME, VAL) case (NAME): return (#NAME);

WARNING: macros should not use a trailing semicolon
#120: FILE: include/asm-generic/hyperv-tlfs.h:217:
+#define __HV_MAKE_HV_STATUS_CASE(NAME, VAL) case (NAME): return (#NAME);

total: 3 errors, 2 warnings, 108 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

0002-asm-generic-hyperv-convert-hyperv-statuses-to-string.patch has
style problems, please review.
...
-------------------------------------------
0004-drivers-hv-check-extension-ioctl.patch
-------------------------------------------
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#36: 
new file mode 100644

WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
#131: FILE: drivers/hv/mshv_main.c:52:
+	return -ENOTSUPP;

total: 0 errors, 2 warnings, 137 lines checked

...

WARNING: Improper SPDX comment style for 'drivers/hv/hv_call.c', please use '//' instead
#94: FILE: drivers/hv/hv_call.c:1:
+/* SPDX-License-Identifier: GPL-2.0-only */

WARNING: Missing or malformed SPDX-License-Identifier tag in line 1
#94: FILE: drivers/hv/hv_call.c:1:
+/* SPDX-License-Identifier: GPL-2.0-only */

ERROR: "(foo*)" should be "(foo *)"
#178: FILE: drivers/hv/hv_call.c:85:
+				*(u64*)&input);

ERROR: "(foo*)" should be "(foo *)"
#201: FILE: drivers/hv/hv_call.c:108:
+			*(u64*)&input);

ERROR: "(foo*)" should be "(foo *)"
#215: FILE: drivers/hv/hv_call.c:122:
+	status = hv_do_fast_hypercall8(HVCALL_DELETE_PARTITION, *(u64*)&input);

total: 3 errors, 3 warnings, 330 lines checked

...
------------------------------------------------
0008-drivers-hv-map-and-unmap-guest-memory.patch
------------------------------------------------
ERROR: code indent should use tabs where possible
#101: FILE: drivers/hv/hv_call.c:222:
+                                                    HV_MAP_GPA_DEPOSIT_PAGES);$

WARNING: please, no spaces at the start of a line
#101: FILE: drivers/hv/hv_call.c:222:
+                                                    HV_MAP_GPA_DEPOSIT_PAGES);$

ERROR: code indent should use tabs where possible
#469: FILE: include/asm-generic/hyperv-tlfs.h:895:
+        u32 padding;$

WARNING: please, no spaces at the start of a line
#469: FILE: include/asm-generic/hyperv-tlfs.h:895:
+        u32 padding;$

ERROR: code indent should use tabs where possible
#477: FILE: include/asm-generic/hyperv-tlfs.h:903:
+        u32 padding;$

WARNING: please, no spaces at the start of a line
#477: FILE: include/asm-generic/hyperv-tlfs.h:903:
+        u32 padding;$

total: 3 errors, 3 warnings, 487 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

0008-drivers-hv-map-and-unmap-guest-memory.patch has style problems, please review.
---------------------------------------
0009-drivers-hv-create-vcpu-ioctl.patch
---------------------------------------
WARNING: Missing a blank line after declarations
#76: FILE: drivers/hv/mshv_main.c:75:
+	struct mshv_vp *vp = filp->private_data;
+	mshv_partition_put(vp->partition);

ERROR: trailing whitespace
#180: FILE: drivers/hv/mshv_main.c:376:
+^I$

total: 1 errors, 1 warnings, 210 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

0009-drivers-hv-create-vcpu-ioctl.patch has style problems, please review.
-------------------------------------------------------
0010-drivers-hv-get-and-set-vcpu-registers-ioctls.patch
-------------------------------------------------------
WARNING: braces {} are not necessary for single statement blocks
#690: FILE: drivers/hv/hv_call.c:326:
+		for (i = 0; i < rep_count; ++i) {
+			input_page->names[i] = registers[i].name;
+		}

WARNING: braces {} are not necessary for single statement blocks
#704: FILE: drivers/hv/hv_call.c:340:
+		for (i = 0; i < completed; ++i) {
+			registers[i].value = output_page[i];
+		}

WARNING: braces {} are not necessary for single statement blocks
#859: FILE: drivers/hv/mshv_main.c:121:
+	if (!registers) {
+		return -ENOMEM;
+	}

total: 0 errors, 3 warnings, 965 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

0010-drivers-hv-get-and-set-vcpu-registers-ioctls.patch has style problems, please review.
---------------------------------------------------------------
0011-drivers-hv-set-up-synic-pages-for-intercept-messages.patch
---------------------------------------------------------------
WARNING: added, moved or deleted file(s), does MAINTAINERS need updating?
#274: 
new file mode 100644

ERROR: code indent should use tabs where possible
#310: FILE: drivers/hv/hv_synic.c:32:
+                             MEMREMAP_WB);$

WARNING: please, no spaces at the start of a line
#310: FILE: drivers/hv/hv_synic.c:32:
+                             MEMREMAP_WB);$

total: 1 errors, 2 warnings, 574 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile

0011-drivers-hv-set-up-synic-pages-for-intercept-messages.patch has style problems, please review.
------------------------------------------
0012-drivers-hv-run-vp-ioctl-and-isr.patch
------------------------------------------
WARNING: EXPORT_SYMBOL(foo); should immediately follow its function/variable
#86: FILE: arch/x86/kernel/cpu/mshyperv.c:77:
+EXPORT_SYMBOL_GPL(hv_remove_mshv_irq);

WARNING: consider using a completion
#410: FILE: drivers/hv/mshv_main.c:344:
+	sema_init(&vp->run.sem, 0);

total: 0 errors, 2 warnings, 435 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

0012-drivers-hv-run-vp-ioctl-and-isr.patch has style problems, please review.
---------------------------------------------
...
-------------------------------------------
0016-drivers-hv-mmap-vp-register-page.patch
-------------------------------------------
WARNING: Missing a blank line after declarations
#222: FILE: drivers/hv/mshv_main.c:441:
+	struct mshv_vp *vp = vmf->vma->vm_file->private_data;
+	vmf->page = vp->register_page;

total: 0 errors, 1 warnings, 257 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

0016-drivers-hv-mmap-vp-register-page.patch has style problems, please review.
-----------------------------------------------------------
0017-drivers-hv-get-and-set-partition-property-ioctls.patch
-----------------------------------------------------------
ERROR: code indent should use tabs where possible
#205: FILE: include/asm-generic/hyperv-tlfs.h:890:
+        u32 padding;$

WARNING: please, no spaces at the start of a line
#205: FILE: include/asm-generic/hyperv-tlfs.h:890:
+        u32 padding;$

ERROR: code indent should use tabs where possible
#215: FILE: include/asm-generic/hyperv-tlfs.h:900:
+        u32 padding;$

WARNING: please, no spaces at the start of a line
#215: FILE: include/asm-generic/hyperv-tlfs.h:900:
+        u32 padding;$

total: 2 errors, 2 warnings, 258 lines checked

NOTE: For some of the reported defects, checkpatch may be able to
      mechanically convert to the typical style using --fix or --fix-inplace.

NOTE: Whitespace errors detected.
      You may wish to use scripts/cleanpatch or scripts/cleanfile


-- 
Vitaly

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
