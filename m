Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52135C46467
	for <virtualization@archiver.kernel.org>; Mon, 16 Jan 2023 14:55:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AB7438145F;
	Mon, 16 Jan 2023 14:55:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AB7438145F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PughXJ7o
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6ueMt0xQalf3; Mon, 16 Jan 2023 14:55:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ED60B813D8;
	Mon, 16 Jan 2023 14:55:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ED60B813D8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C5A57C0032;
	Mon, 16 Jan 2023 14:55:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 393C2C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 14:55:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 06C4D60B9F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 14:55:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 06C4D60B9F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PughXJ7o
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F1DhbriWZxqy
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 14:55:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DFCCB60625
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DFCCB60625
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 14:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1673880930;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=g48LKw/EQzyimcflA0uDUwRnS8dI8OL8jQyceWm5H5M=;
 b=PughXJ7o8kHmymIdqGuvEVsMHz7v1jxsYtvLoBuvYizxxas0HaC5Exr2ubBjlyBlk6OM0f
 sJX8PSPTYIMofJ72fOBWZwRKA8y874Sii1J47x0B4Q4alYW1hjFbIeJTjMQmd7LUcmKymW
 Sd3wMNEjAWGyeMR8mmV3SAMKsmFhm4g=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-564-e2kGQkmuOry2_JDYz9GnMg-1; Mon, 16 Jan 2023 09:55:29 -0500
X-MC-Unique: e2kGQkmuOry2_JDYz9GnMg-1
Received: by mail-ej1-f70.google.com with SMTP id
 gn31-20020a1709070d1f00b0087024adbba2so2390589ejc.20
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Jan 2023 06:55:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=g48LKw/EQzyimcflA0uDUwRnS8dI8OL8jQyceWm5H5M=;
 b=20AptVQcL/hfb2eUK5Gk8ohy3AUPfpBrbQ0/GTChzct/0Ysf8agH4AvQ8/ySfVobsM
 Ko1JFA5cXoPdOkKUZz9MFeuVx6yQ05GT9fKEIqfW5Adr/eMn0bTY5DwtlqafQJJ/krqs
 XMuBNihC2puufAH7Dfm2iJk6447CWJvcK9UWvf3rFbq4295I33iDsqEvs/Y48zERnMWM
 f38J9l0haz3J0bGAkoprfuh1G2rMzahcv/MOX+vvlK47+CQIBKFIUXmYc9arzducF8oK
 A4mgmhEqyPQ0h7dPTKDLIXFHrCMe/HPeUtcSCZiAZ1plTMY7bPmJ+QeOa4trQtt0RcFZ
 xHRg==
X-Gm-Message-State: AFqh2kqrlkLTxIJ7YKUunwKK1/vDfDxXkHbdLTPDh59b0uqrAQ0qDFmq
 S+OjvUQ2oJVISWvyDiU7+BbC7xfOHnWf7csdy7c3nOc5Dxav0ObLBHvYVtbyTKSUwWJHGkz6p+v
 rE2lb6OnlZNYDgcOuOkB8GS8ePJAgkQWg8xDOSCRG+g==
X-Received: by 2002:a17:906:8478:b0:84d:373b:39da with SMTP id
 hx24-20020a170906847800b0084d373b39damr29113670ejc.40.1673880928387; 
 Mon, 16 Jan 2023 06:55:28 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsse3LgRug+Pp9ZoWtZxmVwLzZ7+mUuv4JYFK2PzosFJrEZ0QAORQ3jcyrTsWEYEH4Absw9GA==
X-Received: by 2002:a17:906:8478:b0:84d:373b:39da with SMTP id
 hx24-20020a170906847800b0084d373b39damr29113641ejc.40.1673880928211; 
 Mon, 16 Jan 2023 06:55:28 -0800 (PST)
Received: from imammedo.users.ipa.redhat.com (nat-pool-brq-t.redhat.com.
 [213.175.37.10]) by smtp.gmail.com with ESMTPSA id
 a3-20020aa7cf03000000b0049019b48373sm11543707edy.85.2023.01.16.06.55.26
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Jan 2023 06:55:27 -0800 (PST)
Date: Mon, 16 Jan 2023 15:55:26 +0100
From: Igor Mammedov <imammedo@redhat.com>
To: "Srivatsa S. Bhat" <srivatsa@csail.mit.edu>
Subject: Re: [PATCH v2] x86/hotplug: Do not put offline vCPUs in mwait idle
 state
Message-ID: <20230116155526.05d37ff9@imammedo.users.ipa.redhat.com>
In-Reply-To: <20230116060134.80259-1-srivatsa@csail.mit.edu>
References: <20230116060134.80259-1-srivatsa@csail.mit.edu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: x86@kernel.org, kvm@vger.kernel.org, Peter Zijlstra <peterz@infradead.org>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 virtualization@lists.linux-foundation.org, ganb@vmware.com, ankitja@vmware.com,
 namit@vmware.com, "H. Peter Anvin" <hpa@zytor.com>, "Rafael J.
 Wysocki" <rafael.j.wysocki@intel.com>,
 VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
 Ingo Molnar <mingo@redhat.com>, bordoloih@vmware.com,
 xen-devel@lists.xenproject.org, Wyes Karny <wyes.karny@amd.com>,
 Tom Lendacky <thomas.lendacky@amd.com>,
 "Paul E. McKenney" <paulmck@kernel.org>, keerthanak@vmware.com,
 Borislav Petkov <bp@alien8.de>, Thomas Gleixner <tglx@linutronix.de>,
 Juergen Gross <jgross@suse.com>, amakhalov@vmware.com,
 linux-kernel@vger.kernel.org, Lewis Caroll <lewis.carroll@amd.com>,
 blamoreaux@vmware.com
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

On Sun, 15 Jan 2023 22:01:34 -0800
"Srivatsa S. Bhat" <srivatsa@csail.mit.edu> wrote:

> From: "Srivatsa S. Bhat (VMware)" <srivatsa@csail.mit.edu>
> 
> Under hypervisors that support mwait passthrough, a vCPU in mwait
> CPU-idle state remains in guest context (instead of yielding to the
> hypervisor via VMEXIT), which helps speed up wakeups from idle.
> 
> However, this runs into problems with CPU hotplug, because the Linux
> CPU offline path prefers to put the vCPU-to-be-offlined in mwait
> state, whenever mwait is available. As a result, since a vCPU in mwait
> remains in guest context and does not yield to the hypervisor, an
> offline vCPU *appears* to be 100% busy as viewed from the host, which
> prevents the hypervisor from running other vCPUs or workloads on the
> corresponding pCPU. [ Note that such a vCPU is not actually busy
> spinning though; it remains in mwait idle state in the guest ].
>
> Fix this by preventing the use of mwait idle state in the vCPU offline
> play_dead() path for any hypervisor, even if mwait support is
> available.

if mwait is enabled, it's very likely guest to have cpuidle
enabled and using the same mwait as well. So exiting early from
 mwait_play_dead(), might just punt workflow down:
  native_play_dead()
        ...
        mwait_play_dead();
        if (cpuidle_play_dead())   <- possible mwait here                                              
                hlt_play_dead(); 

and it will end up in mwait again and only if that fails
it will go HLT route and maybe transition to VMM.

Instead of workaround on guest side,
shouldn't hypervisor force VMEXIT on being uplugged vCPU when it's
actually hot-unplugging vCPU? (ex: QEMU kicks vCPU out from guest
context when it is removing vCPU, among other things)

> Suggested-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> Signed-off-by: Srivatsa S. Bhat (VMware) <srivatsa@csail.mit.edu>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Borislav Petkov <bp@alien8.de>
> Cc: Dave Hansen <dave.hansen@linux.intel.com>
> Cc: "H. Peter Anvin" <hpa@zytor.com>
> Cc: "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>
> Cc: "Paul E. McKenney" <paulmck@kernel.org>
> Cc: Wyes Karny <wyes.karny@amd.com>
> Cc: Lewis Caroll <lewis.carroll@amd.com>
> Cc: Tom Lendacky <thomas.lendacky@amd.com>
> Cc: Alexey Makhalov <amakhalov@vmware.com>
> Cc: Juergen Gross <jgross@suse.com>
> Cc: x86@kernel.org
> Cc: VMware PV-Drivers Reviewers <pv-drivers@vmware.com>
> Cc: virtualization@lists.linux-foundation.org
> Cc: kvm@vger.kernel.org
> Cc: xen-devel@lists.xenproject.org
> ---
> 
> v1: https://lore.kernel.org/lkml/165843627080.142207.12667479241667142176.stgit@csail.mit.edu/
> 
>  arch/x86/kernel/smpboot.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/arch/x86/kernel/smpboot.c b/arch/x86/kernel/smpboot.c
> index 55cad72715d9..125a5d4bfded 100644
> --- a/arch/x86/kernel/smpboot.c
> +++ b/arch/x86/kernel/smpboot.c
> @@ -1763,6 +1763,15 @@ static inline void mwait_play_dead(void)
>  		return;
>  	if (!this_cpu_has(X86_FEATURE_CLFLUSH))
>  		return;
> +
> +	/*
> +	 * Do not use mwait in CPU offline play_dead if running under
> +	 * any hypervisor, to make sure that the offline vCPU actually
> +	 * yields to the hypervisor (which may not happen otherwise if
> +	 * the hypervisor supports mwait passthrough).
> +	 */
> +	if (this_cpu_has(X86_FEATURE_HYPERVISOR))
> +		return;
>  	if (__this_cpu_read(cpu_info.cpuid_level) < CPUID_MWAIT_LEAF)
>  		return;
>  

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
