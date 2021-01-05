Return-Path: <SRS0=5FLU=GI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DE46C433E0
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 13:06:23 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A813D22240
	for <virtualization@archiver.kernel.org>; Tue,  5 Jan 2021 13:06:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A813D22240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D33FB20377;
	Tue,  5 Jan 2021 13:06:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3uscrRND4rvm; Tue,  5 Jan 2021 13:06:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 3210820349;
	Tue,  5 Jan 2021 13:06:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 08FA9C0891;
	Tue,  5 Jan 2021 13:06:19 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B0FBC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 13:06:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6492585A81
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 13:06:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eso00zyeg7lF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 13:06:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 76934855FF
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Jan 2021 13:06:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609851975;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=85pKVnvSeYA5QLQD5EhADjq2rId3Mid5CE6/9bUvHYM=;
 b=Vz9njH/VJECLR18MB/8XKxE+nWBPtPopiPPEOA1Nr1rYZ4jGFCSiEjrr+q8V6JuvW7By0Z
 R7HIPp3C+cQNsMzbvLwkJzZt8FmvdsSwFXVYu5pU7Owp5jJVfILPUYTacP+TNXOG58qEae
 NA5jgaVYxYgyvkSMxt1kpmYgNIDGLQs=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-Ul9x6iLGPsWIqsbhxqwZ6g-1; Tue, 05 Jan 2021 08:06:11 -0500
X-MC-Unique: Ul9x6iLGPsWIqsbhxqwZ6g-1
Received: by mail-ej1-f69.google.com with SMTP id k3so7896679ejr.16
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Jan 2021 05:06:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=85pKVnvSeYA5QLQD5EhADjq2rId3Mid5CE6/9bUvHYM=;
 b=qMa3tnGpbSl+bLyUAwwFkIatlI1gTHsm5I00ckRMgXmiryLl0jRfXam2M4MjpPQDNn
 Kb06ytGkPImajXM6T+Keiju4Bb6W23KJliQMZLyFUf9xr/CwEwGDWKbKH0gZfMUV4ebL
 c+t1LvpcLHxCcy9+Xo2SJ44iWuAhyiOfxr/ep41d9kfiXKu64W7iy43QAFE1g7MJdFsC
 U2/FFhYmicFWJusxg8yueVLUrz0h0Ye2050xsjKAEB6DnX9S9eq68N8pIChyqQQy1+fx
 7MmHk+rO+oV3LtHn0oxtfDxxG6Wl++4IiZJhZ+cQgo2Tgs6HSLaiyJUagaWgnNs6ljEJ
 /1/A==
X-Gm-Message-State: AOAM531NTEP1cE/2mn1gcQqTV8P7bENBMpZlRBfz7WDaSWOc7O98xYhE
 V/1CAJqOLRZRFg1+lUnizrfpoVtYEb/1lNTFY4e9nA1sT+dJeXPjt1L7lbFeFxPlrjFzi6GDC11
 vuQVh+D12HVDi333e1Won/bKHT457rCZqertAcqgbWw==
X-Received: by 2002:a05:6402:3192:: with SMTP id
 di18mr74257293edb.332.1609851970496; 
 Tue, 05 Jan 2021 05:06:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzIXZH+i4vTIqBL+qL/InbxzIhFkuFWwsUFjB/084QZuJD1bxGWu2omuhWudF/kow2Btliw+A==
X-Received: by 2002:a05:6402:3192:: with SMTP id
 di18mr74257264edb.332.1609851970322; 
 Tue, 05 Jan 2021 05:06:10 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id p12sm22637661eds.39.2021.01.05.05.06.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Jan 2021 05:06:09 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Alexey Makhalov <amakhalov@vmware.com>
Subject: Re: [PATCH] x86/vmware: avoid TSC recalibration
In-Reply-To: <20210105004752.131069-1-amakhalov@vmware.com>
References: <20210105004752.131069-1-amakhalov@vmware.com>
Date: Tue, 05 Jan 2021 14:06:08 +0100
Message-ID: <87im8bildr.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: pv-drivers@vmware.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, mingo@redhat.com, bp@alien8.de,
 hpa@zytor.com, tglx@linutronix.de
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

Alexey Makhalov <amakhalov@vmware.com> writes:

> When TSC frequency is known (retrieved from hypervisor), we should skip
> TSC refined calibration by setting X86_FEATURE_TSC_KNOWN_FREQ.
>
> Signed-off-by: Alexey Makhalov <amakhalov@vmware.com>
> ---
>  arch/x86/kernel/cpu/vmware.c | 2 ++
>  1 file changed, 2 insertions(+)
>
> diff --git a/arch/x86/kernel/cpu/vmware.c b/arch/x86/kernel/cpu/vmware.c
> index c6ede3b3d302..83164110ccc5 100644
> --- a/arch/x86/kernel/cpu/vmware.c
> +++ b/arch/x86/kernel/cpu/vmware.c
> @@ -378,6 +378,8 @@ static void __init vmware_set_capabilities(void)
>  {
>  	setup_force_cpu_cap(X86_FEATURE_CONSTANT_TSC);
>  	setup_force_cpu_cap(X86_FEATURE_TSC_RELIABLE);
> +	if (vmware_tsc_khz)
> +		setup_force_cpu_cap(X86_FEATURE_TSC_KNOWN_FREQ);
>  	if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMCALL)
>  		setup_force_cpu_cap(X86_FEATURE_VMCALL);
>  	else if (vmware_hypercall_mode == CPUID_VMWARE_FEATURES_ECX_VMMCALL)

The same trick is being used in Xen/Jailhouse/KVM code already and
Hyper-V overwrites x86_platform.calibrate_tsc/x86_platform.calibrate_cpu
hooks to basically achive the same goal. Should we maybe introduce a
flag in 'struct hypervisor_x86' or something like that to unify all
this?

Just a suggestion.

-- 
Vitaly

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
