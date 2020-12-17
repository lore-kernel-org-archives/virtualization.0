Return-Path: <SRS0=dJY/=FV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CFEC4361B
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 18:04:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF9A922D72
	for <virtualization@archiver.kernel.org>; Thu, 17 Dec 2020 18:04:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF9A922D72
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 97CBD87834;
	Thu, 17 Dec 2020 18:04:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fIkWu+GsComx; Thu, 17 Dec 2020 18:04:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A2BC5876B4;
	Thu, 17 Dec 2020 18:04:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 80AECC0893;
	Thu, 17 Dec 2020 18:04:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 86E57C013B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 18:04:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 41C0387A8A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 18:04:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xTt4qqiPXJEv
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 18:04:11 +0000 (UTC)
X-Greylist: delayed 00:17:28 by SQLgrey-1.7.6
Received: from NAM04-DM6-obe.outbound.protection.outlook.com
 (mail-dm6nam08on2127.outbound.protection.outlook.com [40.107.102.127])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C43DC87A54
 for <virtualization@lists.linux-foundation.org>;
 Thu, 17 Dec 2020 18:04:10 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GcfSep0dkGQn3ohRtbDF4xJZawKRvdyJUcwji40pveLhisgfWxuMDyDp8RGjYtPc2MAhRwu6LfVK68z+4lqZvwZLyntLPYMayWpRW2mUG/qLXk2ydYsLgs6gPgxkj3+jt3IPyyV84y6eP//IiGpEERCF6mDk7KXELjqzju9k3qxxXFI9qpi6Z5d/2il5QrnzAx7leivcPrDaGFI3jpx6OrL9Ms6dCUMUDNEX56hsWgeF/QYTVLuNNstKC11VnXw3AESdYCaE21tJW9uulXUWvjOI2yfxpJUTz6syheXQyQZJaq63J1G0DhHV05kWsQwLTTgKITvYLNUbMFVRK3KbVw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPUvqVY/oR9yRE41vY4FRFh2McGy5ZpgCl1eY+7+Zio=;
 b=S1IkMLweI9kX7Jtwkq0gqcR0PEKvp9dQh18JB8CWM9b1KOkgGcohvkZYDpp2hGiG8lyxf4Eq0GFhZwtXo6kyzik73tpl1nqUJCZDfGtiigT2z2vcWbYFhP1kcKC0a7T7wtcQgl5J7E9c+eyEMPd0exyheyjbKFpbGiIN9HMISW7vo70fPEhwJTPZNIJkvP5KRp4lF0yrEyMeQhhpr0P0HGu6C/llkaY221IeTpLdKQ3jLeiyOVhVUlTUruynyE7IIiUig6TXTQJr4SBuWph/2p9UsZS119UwfB+FpDSu2xLvozPHpxJGk/GtZuo+TFcna3jj5JNlt2E99w4SU7GyDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BPUvqVY/oR9yRE41vY4FRFh2McGy5ZpgCl1eY+7+Zio=;
 b=FyRNgfWs/Pli5rsBwJHYWCbwTdc9OXDgR2AXqT5ifIuPDPfTVjvGp/o5K700//fBAlEdny1twUQRu/4AU2r4XHINq81MTN02L1FVtmjfEDKd4tadbDMOMt+kMqpQ0lSxlQv9cqfjOijeKpHKYhUgitWW2rym7zscwTZLxNGudew=
Received: from (2603:10b6:302:a::16) by
 MWHPR21MB0142.namprd21.prod.outlook.com (2603:10b6:300:78::12) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3700.6; Thu, 17 Dec 2020 17:31:51 +0000
Received: from MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922]) by MW2PR2101MB1052.namprd21.prod.outlook.com
 ([fe80::b8f6:e748:cdf2:1922%8]) with mapi id 15.20.3700.013; Thu, 17 Dec 2020
 17:31:51 +0000
To: Juergen Gross <jgross@suse.com>, "xen-devel@lists.xenproject.org"
 <xen-devel@lists.xenproject.org>, "x86@kernel.org" <x86@kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linux-hyperv@vger.kernel.org" <linux-hyperv@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, "kvm@vger.kernel.org"
 <kvm@vger.kernel.org>
Subject: RE: [PATCH v3 06/15] x86/paravirt: switch time pvops functions to use
 static_call()
Thread-Topic: [PATCH v3 06/15] x86/paravirt: switch time pvops functions to
 use static_call()
Thread-Index: AQHW1FgK985cvXh+pkSmuKOGNWS3nqn7ilNA
Date: Thu, 17 Dec 2020 17:31:50 +0000
Message-ID: <MW2PR2101MB1052877B5376112F1BAF3D93D7C49@MW2PR2101MB1052.namprd21.prod.outlook.com>
References: <20201217093133.1507-1-jgross@suse.com>
 <20201217093133.1507-7-jgross@suse.com>
In-Reply-To: <20201217093133.1507-7-jgross@suse.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2020-12-17T17:31:48Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=2f28ae99-1d93-43a6-b6b4-5233e0d4e0a9;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: suse.com; dkim=none (message not signed)
 header.d=none;suse.com; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: c4135d3c-37b9-435f-411d-08d8a2b1a3f9
x-ms-traffictypediagnostic: MWHPR21MB0142:
x-ms-exchange-transport-forked: True
x-ld-processed: 72f988bf-86f1-41af-91ab-2d7cd011db47,ExtAddr
x-microsoft-antispam-prvs: <MWHPR21MB0142C163DFC2F39C4763FC67D7C49@MWHPR21MB0142.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:989;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: IaLSeEbsG8rP8E8je3b9OZamJ+BskrPETAcRrYVlQI3Rt8aj7KtizwCjW57Zqz2Zx275n/W7MR0jQ85VCW7UNqLs8aKRkvDWfIMAnhCRY4zd5brm5wI9zIvlXELzQ/vrf/xdtYv6pMzXHSc5opt53rOneu7GAB8bPGy+lYpRZbHKCKoDB8vGBTFVgwIIt9765jFJHRtOsggQBtiel7KTr2NS4C7Y6L995UdLZQk38anh2bY71FjssNraL9InvIQsSywdXHZVKFB2EFsMO1cb9MWkI4MyEhqjmJ9OoqnSJ7SCCVZlYe2YLRUL67dN1rivbmaUgYpsZ8f5iFIiwopN0c7wOxBX2Ed/AEUZgurxcwZVqsEid25xsr++WVwMcRgSFoID+F/J5+2pVf9LMXWpNg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MW2PR2101MB1052.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(396003)(346002)(136003)(376002)(366004)(7696005)(110136005)(64756008)(33656002)(66446008)(66556008)(8676002)(55016002)(186003)(66946007)(5660300002)(66476007)(10290500003)(478600001)(8936002)(86362001)(2906002)(26005)(7416002)(316002)(82950400001)(6506007)(52536014)(7406005)(76116006)(9686003)(8990500004)(71200400001)(82960400001)(54906003)(4326008)(83380400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?R+Y9nc8b6UEA7w8KIpQ6o0v1/MFkvTl91lNvfEN6wXfr8U6qJFOo+foh2ADb?=
 =?us-ascii?Q?UCmkJiQx3AubR0XSzzMri+4BnswxO7qZwukUjjFCDbal5pJa4XNKR/KrMRTY?=
 =?us-ascii?Q?73EgN0zFfqKUUfGSv2plvip3GA/FEggH7nyvmDrfYR5mjoeEQL5+9/r+6Yf/?=
 =?us-ascii?Q?mlKXxd3dBVm2fJVMMmFMXY2bH2Q+3xp/p9kz8a1G8VGbUxE25U7CYixKFDfz?=
 =?us-ascii?Q?GkvWD3Gr6BjVSfILdz4jilitWQId+hgQ1YvkcLxzoIn4R3iV6AR5/R6YgSf3?=
 =?us-ascii?Q?Ta2H8b82IEpBWXydjLYty5qVvXM3avLKDJrvTjjEpC/2U1KK9ilwNwdD8mN3?=
 =?us-ascii?Q?QVGPQeoBDcFlbLnsMLeJG8RBOdwJDAcbgRXyu9J6b+K1qkmejj2REh2zppgl?=
 =?us-ascii?Q?Ex7wEM9NAWXJzBmo7FAEb26XrolYEmt5zijx1Re3vYysaaLTL2VMkEvk5omV?=
 =?us-ascii?Q?GG8Nu4JSYcsCzxcNoxzGxWnSfFOY2yN7poOIEsvuUNhURTcwn7donnhimYI3?=
 =?us-ascii?Q?cAhiQCpY/FtanBD9S/8RvG1bDhtIvI6BJJfSCkm6ollskdGVyRpWpgdd9xYa?=
 =?us-ascii?Q?tY5lydtjAdz4EJcofqRU4MPq8Lv/mlLej1R5tdOHWjDGZoAxThPakVq6Fljm?=
 =?us-ascii?Q?MmXrBZNlWOgDludtgKTJyBFvIgo1VeKXwuRQA5KsJzvxELD6Rp7Xe8Ryqqkg?=
 =?us-ascii?Q?jpWzHxRx0JBV+hYJNAELCQX9Sax4sRcmjMnORmDTdrRzleSl7MfujiV76vzU?=
 =?us-ascii?Q?3OXtfuDMhi0sNE/hFp5nAAFHlhF1wQMmTkhw7vAH5Xqmj7aiy6UpTE2Y0Vp5?=
 =?us-ascii?Q?tWrlj11qpKH4TJbL0nLJTgAQHLzhwqljt+ALjPmUZ9hXfx1fqLJZOpbozNFm?=
 =?us-ascii?Q?M8ba4+xJDh0cMDNH8H2zIgOGyNuHjHWkuKAtH/TowV1S+pcdNOJIp5o8BogS?=
 =?us-ascii?Q?HSz+K1CIixkIRgNda0mVSrBsTrTfqxagd8+2n3yEco0=3D?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MW2PR2101MB1052.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c4135d3c-37b9-435f-411d-08d8a2b1a3f9
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Dec 2020 17:31:51.0431 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: /Q5InnaJJLcy01EpA6UmZxFA1/22sr9BtTksbFiG3rnBWdxJ29Ds9dE6ZwmP4DBytRWwgdPYYjW15F4LEpR0acdS0Q0E8FQRsiq2pQ/kriE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR21MB0142
Cc: Juri Lelli <juri.lelli@redhat.com>, Wanpeng Li <wanpengli@tencent.com>,
 "VMware, Inc." <pv-drivers@vmware.com>, Ben Segall <bsegall@google.com>,
 "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>,
 Wei Liu <wei.liu@kernel.org>, Stefano Stabellini <sstabellini@kernel.org>,
 Stephen Hemminger <sthemmin@microsoft.com>, Joerg Roedel <joro@8bytes.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Mel Gorman <mgorman@suse.de>, Haiyang Zhang <haiyangz@microsoft.com>,
 Steven Rostedt <rostedt@goodmis.org>, Borislav Petkov <bp@alien8.de>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Boris Ostrovsky <boris.ostrovsky@oracle.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>, Jim Mattson <jmattson@google.com>,
 Sean Christopherson <seanjc@google.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Daniel Bristot de Oliveira <bristot@redhat.com>
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
From: Michael Kelley via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Michael Kelley <mikelley@microsoft.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

From: Juergen Gross <jgross@suse.com> Sent: Thursday, December 17, 2020 1:31 AM

> The time pvops functions are the only ones left which might be
> used in 32-bit mode and which return a 64-bit value.
> 
> Switch them to use the static_call() mechanism instead of pvops, as
> this allows quite some simplification of the pvops implementation.
> 
> Due to include hell this requires to split out the time interfaces
> into a new header file.
> 
> Signed-off-by: Juergen Gross <jgross@suse.com>
> ---
>  arch/x86/Kconfig                      |  1 +
>  arch/x86/include/asm/mshyperv.h       | 11 --------
>  arch/x86/include/asm/paravirt.h       | 14 ----------
>  arch/x86/include/asm/paravirt_time.h  | 38 +++++++++++++++++++++++++++
>  arch/x86/include/asm/paravirt_types.h |  6 -----
>  arch/x86/kernel/cpu/vmware.c          |  5 ++--
>  arch/x86/kernel/kvm.c                 |  3 ++-
>  arch/x86/kernel/kvmclock.c            |  3 ++-
>  arch/x86/kernel/paravirt.c            | 16 ++++++++---
>  arch/x86/kernel/tsc.c                 |  3 ++-
>  arch/x86/xen/time.c                   | 12 ++++-----
>  drivers/clocksource/hyperv_timer.c    |  5 ++--
>  drivers/xen/time.c                    |  3 ++-
>  kernel/sched/sched.h                  |  1 +
>  14 files changed, 71 insertions(+), 50 deletions(-)
>  create mode 100644 arch/x86/include/asm/paravirt_time.h
>

[snip]
 
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index ffc289992d1b..45942d420626 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -56,17 +56,6 @@ typedef int (*hyperv_fill_flush_list_func)(
>  #define hv_get_raw_timer() rdtsc_ordered()
>  #define hv_get_vector() HYPERVISOR_CALLBACK_VECTOR
> 
> -/*
> - * Reference to pv_ops must be inline so objtool
> - * detection of noinstr violations can work correctly.
> - */
> -static __always_inline void hv_setup_sched_clock(void *sched_clock)
> -{
> -#ifdef CONFIG_PARAVIRT
> -	pv_ops.time.sched_clock = sched_clock;
> -#endif
> -}
> -
>  void hyperv_vector_handler(struct pt_regs *regs);
> 
>  static inline void hv_enable_stimer0_percpu_irq(int irq) {}

[snip]

> diff --git a/drivers/clocksource/hyperv_timer.c b/drivers/clocksource/hyperv_timer.c
> index ba04cb381cd3..1ed79993fc50 100644
> --- a/drivers/clocksource/hyperv_timer.c
> +++ b/drivers/clocksource/hyperv_timer.c
> @@ -21,6 +21,7 @@
>  #include <clocksource/hyperv_timer.h>
>  #include <asm/hyperv-tlfs.h>
>  #include <asm/mshyperv.h>
> +#include <asm/paravirt_time.h>
> 
>  static struct clock_event_device __percpu *hv_clock_event;
>  static u64 hv_sched_clock_offset __ro_after_init;
> @@ -445,7 +446,7 @@ static bool __init hv_init_tsc_clocksource(void)
>  	clocksource_register_hz(&hyperv_cs_tsc, NSEC_PER_SEC/100);
> 
>  	hv_sched_clock_offset = hv_read_reference_counter();
> -	hv_setup_sched_clock(read_hv_sched_clock_tsc);
> +	paravirt_set_sched_clock(read_hv_sched_clock_tsc);
> 
>  	return true;
>  }
> @@ -470,6 +471,6 @@ void __init hv_init_clocksource(void)
>  	clocksource_register_hz(&hyperv_cs_msr, NSEC_PER_SEC/100);
> 
>  	hv_sched_clock_offset = hv_read_reference_counter();
> -	hv_setup_sched_clock(read_hv_sched_clock_msr);
> +	static_call_update(pv_sched_clock, read_hv_sched_clock_msr);
>  }
>  EXPORT_SYMBOL_GPL(hv_init_clocksource);

These Hyper-V changes are problematic as we want to keep hyperv_timer.c
architecture independent.  While only the code for x86/x64 is currently
accepted upstream, code for ARM64 support is in progress.   So we need
to use hv_setup_sched_clock() in hyperv_timer.c, and have the per-arch
implementation in mshyperv.h.

Michael
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
