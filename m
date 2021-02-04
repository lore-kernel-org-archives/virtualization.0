Return-Path: <SRS0=AmYR=HG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3375CC433DB
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 17:03:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C9AFE64F6A
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 17:03:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C9AFE64F6A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8E77E87216;
	Thu,  4 Feb 2021 17:03:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ml6NJNRIZtCn; Thu,  4 Feb 2021 17:03:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id EB53687215;
	Thu,  4 Feb 2021 17:03:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB73DC0174;
	Thu,  4 Feb 2021 17:03:35 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 56E68C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 17:03:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 2B544203F7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 17:03:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yU5baDtCtmV0
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 17:03:33 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam12on2133.outbound.protection.outlook.com [40.107.244.133])
 by silver.osuosl.org (Postfix) with ESMTPS id 4B4C627484
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 17:03:33 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JEzP+/u+2Jzmuk1KCJJFc142UJwhktiBwlHfaqArLYRWnCCn6fGP8Svj1QQOZOOtn15Lq9BBZ4P/cPJ0yehhAK3BPPjyTWKrWoO0A7lBuQ+SEOodWv8ntev6Ju0/lJN+zvlq5/NX9AxD1uu4bHz3E9GiioKaNasE/PjOBPxxt0C10o0W7zW5c6/kjVCbIbZoJoRrFcWVE60C7C6v9Sisq4MRIzFVHzNti94H+j+ft6xSQEma99Acg6ryLCHG3sZxrpZnV0Q8VhiWlxv+i1kuu3AtF4vD2cVoL83aeT8HCMSpNpmWzJFDEi4EN5jTpBhxIqkR7uqIn/8ZtneMuqVXOw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsKFOEscWusz7eTqR+XFEjwIyQLIJYlRhnuvXJAD0zM=;
 b=A9csnkX3HR8XT1SiS1f8jJntULL0erv2Em2Wl3SwuetVdYnOqG3uKcINgbhxASnnzxixHTVHOq+jqI1SAGcVwmmSl0x10lhbYBdJSdCwKdIkg4Kg1C3KvDrD4P4MbJ2pYCv3Ki21wYT+P+WaeStA2T7H4s7RB1kmJaqt8RnAgjB4FysYGrdPm3gKhRXqgGc4/vHc+bjI+Ay4vr/QKycb30c0FN7OU4I9uZiBowgR5T2DhYto4tZudxv9MvFcPplppMJMMOTgtGn6Ik6do9WJkQIRqxlzdOrWdUABnu25B7xAmZInV0S/8AH76NcGMcSefwcB3IM5erONAbdl1iP00g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jsKFOEscWusz7eTqR+XFEjwIyQLIJYlRhnuvXJAD0zM=;
 b=O+GrX7bsjY4DRjw2kbQv47/sy8FgzbUpppdEycG+VtE+XsiuB26nYLVMF8/+6TXy4xw7K+pqPeLlPySugziq4+wwpYYoEqvaKpbwRimH/5LCTyb6qIRMIcogloimUccPUTvP/Ld0JcVBbf4r7khpGEZd1XHnJpuwJ9vBK2pCSs8=
Received: from (2603:10b6:301:7c::11) by
 MW4PR21MB1956.namprd21.prod.outlook.com (2603:10b6:303:7a::14) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.3; Thu, 4 Feb 2021 16:49:25 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3846.006; Thu, 4 Feb 2021
 16:49:25 +0000
To: Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List
 <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v6 02/16] x86/hyperv: detect if Linux is the root partition
Thread-Topic: [PATCH v6 02/16] x86/hyperv: detect if Linux is the root
 partition
Thread-Index: AQHW+j3mivD6wT1UeEW9pWefcDdTbKpINqQw
Date: Thu, 4 Feb 2021 16:49:25 +0000
Message-ID: <MWHPR21MB1593184F9A91E0257CAE3A4BD7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210203150435.27941-1-wei.liu@kernel.org>
 <20210203150435.27941-3-wei.liu@kernel.org>
In-Reply-To: <20210203150435.27941-3-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-04T16:49:23Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=82473a84-8533-422f-a5d4-f33d9715ef58;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 73dd1fc8-7570-425c-2ef3-08d8c92cd484
x-ms-traffictypediagnostic: MW4PR21MB1956:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB19567905E4299799C095DCE8D7B39@MW4PR21MB1956.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1284;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: OIHul5Wd3lEpB+pykYEYJgYgHYOsW5MBkog/DktXWvLWhJd66dy6VzF47bfhU+ZXJGVgYooT4T+LSvjBdl3ZvGpblcQxPvVaqsGjBJeso5/eSsHhCySnAA2fcynov6KHOAwRYu2AX6lwaVzNznkNoM/IfQMuRV8jResQHVTnDZrGa325OFLCxL6Q3tUZBamPGmFzc80RD+KHn6Kn+PnChig/hERidYO/EO+LpuUsR2uT4BdUXnNi+8GyAGdZrAfTUYuexgTkACDtyTLUVuNhE2EmoXgvlXmV4eKosfqLTuPyDDBZpa4FXFGQ/BEVx3rlyHbuYRWgarFxIYXgaXO/tBrVoLpxhE6IX8mWSYXyRS4w9+yZPezc+HSfaXO5C5Nd60LK0aycJ/00ErBlkdsbv0f/zBlu8iMr4YdgqjRk5ekmPkSnuJLBMmGATEgs5srAk+jmDyv+Qm8jQohHaXzHpRDYmCFlfBVXfCVl9oxMTB+knwCWIjgOmFlUPdN1pnNYSlAXfUC5sHHMA4AToTpEAA==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR21MB1593.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(346002)(136003)(396003)(366004)(376002)(39860400002)(186003)(10290500003)(8990500004)(2906002)(82960400001)(316002)(9686003)(8936002)(478600001)(54906003)(76116006)(83380400001)(86362001)(52536014)(7416002)(6506007)(71200400001)(4326008)(33656002)(66946007)(5660300002)(66446008)(64756008)(55016002)(82950400001)(7696005)(8676002)(110136005)(66556008)(26005)(66476007);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?anWF+AasYBm+Qe8gy6cFsrXTHKH2R7xVDww1Bm/S5203w68mWsuKss2l/RFa?=
 =?us-ascii?Q?ebFb7W9tWtTSojCVrDP8ib047RxBX2gbXykV9F3IrVG1/EJhrATrNg14AYhZ?=
 =?us-ascii?Q?1Og7dADfOfwyHBtkbFKCrZOG9qpk8mLOMJi+cudjPrTO4mZ5/qK/X/aZMdDw?=
 =?us-ascii?Q?cIPOyXnyb6LCu6VTcNGFP50Ix6nizV47HCjAKdtZcfddYwbEJc70dg7wWpl9?=
 =?us-ascii?Q?WmMTZqQkBTjILVC5rnkebJResWsVLTKAoCewMNEd0qIqvBkcZBrcNOJ05f/K?=
 =?us-ascii?Q?FN0dqvJ4WAiRrXpE/u6oHWvs12cLkSd+tA3ImZpnxCMXyXHxtYypIQw0C7eE?=
 =?us-ascii?Q?ErujdfdPMKksDoE2LcSm2RDgp9AmBIgzg4B3ydsCc+yVjTNkqQD9TXNaozSt?=
 =?us-ascii?Q?i7Ect2AWnCEkrqcimmLuWjk6wH8UPCpFcg2YKniMa7Ua8mZJwH3uig6002IQ?=
 =?us-ascii?Q?sdmeuvMJnYSIULqirY1X7xD2AtmOjg51CO4zyTtZFnA7oHfzez5FwTFIbrpi?=
 =?us-ascii?Q?Rvpx1GMCJgdWkRCbhYzJzoom3PPM4rmBmdlwOshIZF2XYbsJPm82bkNNGc8P?=
 =?us-ascii?Q?2v6MetwBoewKbxZGq7JCr1p7sKEUWP3ALJwO7zazrNUL9DD0u5FjXq9St+LH?=
 =?us-ascii?Q?WjJn82FW16gVJUyPj6uFqzoKT9Ow81io+cWYsZf9dE7b6ZfdnQTZuwC04+aS?=
 =?us-ascii?Q?CrM8AiA5BVCnPaYqegADieg+0wzOWQnZTvraAQURm4Dhd2rEAkOa8IVcJ3lU?=
 =?us-ascii?Q?iBEc6ILCiY/U8KlG99yX+viRZ5CNPhLsgubCixupVZVZFSH40fnBRqNu2zLx?=
 =?us-ascii?Q?GiqWOfu216Zr7z/ob+b7nV9ZTfvYLu7QKKtTEhWuEPYcKNUcPOTvS2eEX+H3?=
 =?us-ascii?Q?QA86mRFEHHPJGmOEUcHtNDv++Hemwo7gTpQPf4f1FKY2F+LDH/60si6OAMob?=
 =?us-ascii?Q?3Cy306BM0uOuDA52L/InIvmkfcIR0y3ac4klmLP/FwfjLi3UmndfeyffvN6A?=
 =?us-ascii?Q?R1fB5Nxu85fdT8/Rfo0O2TIpbsxGcMWTKgEZpadpuDwHK/NGXTuKeuqx4qUz?=
 =?us-ascii?Q?dGxDR2xGVLqJXlTXQrzWpKxDUI5ZvS+yigaxfZg92Mcbi/ahFrdI3DzBVafM?=
 =?us-ascii?Q?gK5z4uWvjfTxxZM6fHaHH3p4ayxIOL05c83D34Fp0ss6RyZ9QI5TFsFQHoul?=
 =?us-ascii?Q?y9SEQRbM5u76wcMGBl5XKR5WUQ7TowyxqvxpJgLjcY/jqZ0KZsr2BQ81UEa4?=
 =?us-ascii?Q?yLLYTxwmqpXXpFnCjK4+HxclrVYTgNtyvW2A2y+gwZwiizvUzLED4gfAcJ6V?=
 =?us-ascii?Q?JQozWMnCYmMsy0VQvUugm429?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 73dd1fc8-7570-425c-2ef3-08d8c92cd484
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 16:49:25.2162 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qA8tZ7KfMdRRnRHPeUqEMKPnbB4RYLdoM05I145u32B+Yp1jnAO6hccJK+mnnb37KIO930S21A+JHRUFsOpZ3hxUoYvTREtWZATW+cxAzJg=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1956
Cc: Stephen Hemminger <sthemmin@microsoft.com>,
 "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter
 Anvin" <hpa@zytor.com>, Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Vineeth Pillai <viremana@linux.microsoft.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, February 3, 2021 7:04 AM
> 
> For now we can use the privilege flag to check. Stash the value to be
> used later.
> 
> Put in a bunch of defines for future use when we want to have more
> fine-grained detection.
> 
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> Reviewed-by: Pavel Tatashin <pasha.tatashin@soleen.com>
> ---
> v3: move hv_root_partition to mshyperv.c
> ---
>  arch/x86/include/asm/hyperv-tlfs.h | 10 ++++++++++
>  arch/x86/include/asm/mshyperv.h    |  2 ++
>  arch/x86/kernel/cpu/mshyperv.c     | 20 ++++++++++++++++++++
>  3 files changed, 32 insertions(+)
> 
> diff --git a/arch/x86/include/asm/hyperv-tlfs.h b/arch/x86/include/asm/hyperv-tlfs.h
> index 6bf42aed387e..204010350604 100644
> --- a/arch/x86/include/asm/hyperv-tlfs.h
> +++ b/arch/x86/include/asm/hyperv-tlfs.h
> @@ -21,6 +21,7 @@
>  #define HYPERV_CPUID_FEATURES			0x40000003
>  #define HYPERV_CPUID_ENLIGHTMENT_INFO		0x40000004
>  #define HYPERV_CPUID_IMPLEMENT_LIMITS		0x40000005
> +#define HYPERV_CPUID_CPU_MANAGEMENT_FEATURES	0x40000007
>  #define HYPERV_CPUID_NESTED_FEATURES		0x4000000A
> 
>  #define HYPERV_CPUID_VIRT_STACK_INTERFACE	0x40000081
> @@ -110,6 +111,15 @@
>  /* Recommend using enlightened VMCS */
>  #define HV_X64_ENLIGHTENED_VMCS_RECOMMENDED		BIT(14)
> 
> +/*
> + * CPU management features identification.
> + * These are HYPERV_CPUID_CPU_MANAGEMENT_FEATURES.EAX bits.
> + */
> +#define HV_X64_START_LOGICAL_PROCESSOR			BIT(0)
> +#define HV_X64_CREATE_ROOT_VIRTUAL_PROCESSOR		BIT(1)
> +#define HV_X64_PERFORMANCE_COUNTER_SYNC			BIT(2)
> +#define HV_X64_RESERVED_IDENTITY_BIT			BIT(31)
> +
>  /*
>   * Virtual processor will never share a physical core with another virtual
>   * processor, except for virtual processors that are reported as sibling SMT
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index ffc289992d1b..ac2b0d110f03 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -237,6 +237,8 @@ int hyperv_fill_flush_guest_mapping_list(
>  		struct hv_guest_mapping_flush_list *flush,
>  		u64 start_gfn, u64 end_gfn);
> 
> +extern bool hv_root_partition;
> +
>  #ifdef CONFIG_X86_64
>  void hv_apic_init(void);
>  void __init hv_init_spinlocks(void);
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index f628e3dc150f..c376d191a260 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -32,6 +32,10 @@
>  #include <asm/nmi.h>
>  #include <clocksource/hyperv_timer.h>
> 
> +/* Is Linux running as the root partition? */
> +bool hv_root_partition;
> +EXPORT_SYMBOL_GPL(hv_root_partition);
> +
>  struct ms_hyperv_info ms_hyperv;
>  EXPORT_SYMBOL_GPL(ms_hyperv);
> 
> @@ -237,6 +241,22 @@ static void __init ms_hyperv_init_platform(void)
>  	pr_debug("Hyper-V: max %u virtual processors, %u logical processors\n",
>  		 ms_hyperv.max_vp_index, ms_hyperv.max_lp_index);
> 
> +	/*
> +	 * Check CPU management privilege.
> +	 *
> +	 * To mirror what Windows does we should extract CPU management
> +	 * features and use the ReservedIdentityBit to detect if Linux is the
> +	 * root partition. But that requires negotiating CPU management
> +	 * interface (a process to be finalized).
> +	 *
> +	 * For now, use the privilege flag as the indicator for running as
> +	 * root.
> +	 */
> +	if (cpuid_ebx(HYPERV_CPUID_FEATURES) & HV_CPU_MANAGEMENT) {
> +		hv_root_partition = true;
> +		pr_info("Hyper-V: running as root partition\n");
> +	}
> +
>  	/*
>  	 * Extract host information.
>  	 */
> --
> 2.20.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
