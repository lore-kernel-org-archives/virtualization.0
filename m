Return-Path: <SRS0=+Z4V=G5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B988AC433E0
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 03:53:36 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0628F22597
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 03:53:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0628F22597
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5C1698579E;
	Tue, 26 Jan 2021 03:53:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wFr1uLMNWIOL; Tue, 26 Jan 2021 03:53:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 853C38574F;
	Tue, 26 Jan 2021 03:53:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BBC8C0FA7;
	Tue, 26 Jan 2021 03:53:33 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2676C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 03:53:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 9E48987122
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 03:53:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lm9rnvjPr5wq
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 03:53:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from NAM12-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam12on2111.outbound.protection.outlook.com [40.107.237.111])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 30A11870E9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 03:53:30 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrXAFv09KZLS6+tMX5WRGKqqeY6Zfx0F/lBmPBrj0g+NgAGRUTG33Oa2BsQSo7iM8b2w38/ozvyQ3QIg5r96RIBbTCoW86FFW+WmTCyHYocrCoikDtm2LKoKuLx458pN6FIWiN76hmJ0oYGPdlgKHd6onzxpyt9CHj30MslXWJ+q1VO4fjfdAGXqkPiTy3XhyOi7BMRULkpjckKpu3iV8CdeMVyufRI/QsqbNxu8760hVKcinfZa5+Eh18eioCCTpBqGw5ZJUNt3VvPC8v0l0b/pi9mY1oM5wl+evDpRJT9l1MVLFN0eV6XV8WDKdCVc61GTe4/5fkcgRk5L+ZpdNw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPzgVaOwCGeNDgoqp1nDc20TcW78pTcwMsQO3SGfMSM=;
 b=eKFcnCKdZHu2WRlNoKGdJRNfvIW8TCifxKnK9r/E3KbSqCnrwJ9SSPpuTh/bIEXW4Qf92m0J3AbCzq+X0eyj7ie6xO/O+TQs0I/aLjDbcuNpR+RTJGwNd2/R0gkz86Ptas+FDfEoqknAQhZbDvdtBxA5BDkOpb00GEEnCoK89zgHCSTr50jWCf8tEkwJkwKwCo5sXUugmqQyS90JgcuFtzlXUziC3aJ5CuhhVwpSWr+x+nPqb2pV8Kprk2rIcZU1SQdnn/uTK9hiI7rhuWCxRwL6GLchQmAbZInuubLEcezbdWyidESy2QIp+03HYzhajzmJMRkficJmywzeVUW/6A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=tPzgVaOwCGeNDgoqp1nDc20TcW78pTcwMsQO3SGfMSM=;
 b=FRUCdsfKCjQcljmnvxH2njUVhB4PWT/ISj7i13DpbgnGccw2d9XcJCHd9Y90o4CEnqvcBJK0fQpn5yujqKjlSowHtX6dzITyMbjhJC+6nnWhR/zDUf8oOxl3jhyZskAhRushN1rZ3gDXLMCezhGoxVx6OHbrvkvFV5nOWYFZBvk=
Received: from (2603:10b6:301:7c::11) by
 MWHPR2101MB0873.namprd21.prod.outlook.com (2603:10b6:301:7e::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.3825.6; Tue, 26 Jan
 2021 01:21:14 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3825.003; Tue, 26 Jan 2021
 01:21:14 +0000
To: Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List
 <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v5 10/16] x86/hyperv: implement and use hv_smp_prepare_cpus
Thread-Topic: [PATCH v5 10/16] x86/hyperv: implement and use
 hv_smp_prepare_cpus
Thread-Index: AQHW7yP27+zNdKWlU02NgaE0dmDREqo5JKOw
Date: Tue, 26 Jan 2021 01:21:14 +0000
Message-ID: <MWHPR21MB159345C90D79F300DA05C588D7BC9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-11-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-11-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-26T01:21:12Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=3b94c419-7738-4b95-91c9-ea76089aaef7;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [66.75.126.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: d81e41d5-9eb6-474c-b12a-08d8c198ac44
x-ms-traffictypediagnostic: MWHPR2101MB0873:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MWHPR2101MB08737C1F3F8F86A9729E4B09D7BC9@MWHPR2101MB0873.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2043;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: smjODyt3LtXSunW6KCooZpgHV6GAypoXTK0F2b4SgIvlbYA1DFcP17toBybMgyEpq2ueqaVVfS9SmC9GqYvDsmTISwXnaJjr8wgkrf75DnjRnERxPuQpbueS3N3+M+PPi/OMXv4NVWuiGmMTC0kRqSY8lTUwdCDoVvxXZayjKNMkO3KcU4J+kVemwmVTM5qhyD/fZT45HWf6O29ekD2+E9nAl9QJ/Rdm7i6a8cRoEXuR740RqaqpMlQ6TQYNFFOYQ4RFOj+mvVW28IJqPAb9JYxNTQMSVhQUwdzjgDKALhRFmI4xmleHwNLgbEtdaGc7DRjxFvSBMs699kPpRRqcfa1HUQ814NRg7s+RcX0lBhuvK3GY1uy54rtKJQqwxAfCVgWzRzv31cptTuSsy5Ssm8n/ijiebytF1Zli0GZVL/szAvpKN+4C/29FmmHX16qrw1Jm9e9c/01nRNpFMVJFA9xUHm8EkXB6eoiKNttRK5pWIg/Z2bHTVaQK5aSKMQiegOiqeISvn2pEvlMOQglcQg==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR21MB1593.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(366004)(346002)(136003)(396003)(376002)(39860400002)(478600001)(52536014)(66446008)(71200400001)(55016002)(8936002)(7416002)(54906003)(4326008)(66946007)(76116006)(64756008)(110136005)(83380400001)(9686003)(66476007)(66556008)(86362001)(7696005)(6506007)(8990500004)(82960400001)(82950400001)(33656002)(8676002)(26005)(186003)(316002)(10290500003)(5660300002)(2906002);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?oJJFEM0XJhtL/oA8Db6TNZgU3LP+vxAXIToaCTBFowdo8lcFTxjTqdiO+Jym?=
 =?us-ascii?Q?AdPcLfitshHjl1zHByjU5QP5hrNrfWyei/PTQ+6+YtN2X4kXVf0XbUKNaUIn?=
 =?us-ascii?Q?Vht4UlF+88pfhGuY1w/t5Huf64UvgRcgJMwjJiAvCsDxM/eqN1+RADGtz95d?=
 =?us-ascii?Q?+obIFdeyniP7gfjh1nN4FfkOSsiPpyiUaj2u+PrXqAwwMAaw522nYGzO7hR+?=
 =?us-ascii?Q?EKT0CyoY4ZLpftM2nhVHmx2y0dUCs1rneM4A9cy/Sz2NMOLqA9pfwhtEbld0?=
 =?us-ascii?Q?F4W9s+fiEaenINvo7hFYRLWVUtJ/tDEqXXK6GO4lPpyGKB2VYo5lya8o1NPa?=
 =?us-ascii?Q?xlbdTH1Dl42S0aOvqTOI+psQti52FWGGHYWD7T1Ayt/AbbQcRSiG+BFNUDX5?=
 =?us-ascii?Q?8Qo22DJdvVkBM5DpNT6za3Voq23y1I2RoIjwXfUBs7MPjrmZPHFJmKVqnJsK?=
 =?us-ascii?Q?vT9ZWhBho7wmAvIg1KYe7VaUaJVPhqfOrSICshJiFs7tJFK4BIWx3VgLQytL?=
 =?us-ascii?Q?bcwMERWuD1VTNhTPJLjKC1f2vhWWia4DmIDwCxGzPhvWc8edsmMr+f0ucKKw?=
 =?us-ascii?Q?ZKOCweTKuc+RP0R1om7k121M/CuwgDgxN4cM1rg+ZYLK9GdZLYxjnW/cERVq?=
 =?us-ascii?Q?ECN5u8QR4BfalF2o08DXlIvCs7vJcnThHQ53CWrEhaV43Vks9Rf7BmFUOb2F?=
 =?us-ascii?Q?ZP+ecQnqcmdqi0zkOaZo0metKVGckMSDssKd+f3FiKToTcKBn0ClcGex0vbV?=
 =?us-ascii?Q?tXweyIl4dIqSNBuaN9Cj+10XC32Cb4QyVYEDVhQMwl3w4vOKkmcCuG6W0dkH?=
 =?us-ascii?Q?djSW94s7DNHdLwYKtaQ67jlXf5S0PjGrjNMvjY0E8vcg29FyFFZyLNe6Clms?=
 =?us-ascii?Q?4j4owS5Qh0DZ1oftYgD8yLURfjWOSRorzuuSlfRnaSVsHnzAHg82rd5n8Acz?=
 =?us-ascii?Q?1Br+dbd1DoBiKVfLCD9T5q2G/bQqjy0tffc3oO45YzHJcZzWhg95PHBy/o6g?=
 =?us-ascii?Q?DApYvxMN9OFwj8R71tgqXzu1G1xvd0a5b4dssV6cfh2wuaOGuUWcM+78C2Ca?=
 =?us-ascii?Q?vUe2rBhq?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d81e41d5-9eb6-474c-b12a-08d8c198ac44
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 01:21:14.0708 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: d0ODB7oa/4kd6lUTvR1RdS5Rkh1uBURAo89mO/dfxqsCEJtukwvTqEUfEQQJ+6OdUL1MkilmiOFNgbQn7hjlVAEWPLjLjnKa3P+55WIcA1g=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR2101MB0873
Cc: Stephen Hemminger <sthemmin@microsoft.com>,
 "pasha.tatashin@soleen.com" <pasha.tatashin@soleen.com>,
 Lillian Grassin-Drake <Lillian.GrassinDrake@microsoft.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Ingo Molnar <mingo@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>, "H. Peter
 Anvin" <hpa@zytor.com>, Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Borislav Petkov <bp@alien8.de>, Sunil Muthuswamy <sunilmut@microsoft.com>,
 Vineeth Pillai <viremana@linux.microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>
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

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:01 AM
> 
> Microsoft Hypervisor requires the root partition to make a few
> hypercalls to setup application processors before they can be used.
> 
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> CPU hotplug and unplug is not yet supported in this setup, so those
> paths remain untouched.
> 
> v3: Always call native SMP preparation function.
> ---
>  arch/x86/kernel/cpu/mshyperv.c | 29 +++++++++++++++++++++++++++++
>  1 file changed, 29 insertions(+)
> 
> diff --git a/arch/x86/kernel/cpu/mshyperv.c b/arch/x86/kernel/cpu/mshyperv.c
> index c376d191a260..13d3b6dd21a3 100644
> --- a/arch/x86/kernel/cpu/mshyperv.c
> +++ b/arch/x86/kernel/cpu/mshyperv.c
> @@ -31,6 +31,7 @@
>  #include <asm/reboot.h>
>  #include <asm/nmi.h>
>  #include <clocksource/hyperv_timer.h>
> +#include <asm/numa.h>
> 
>  /* Is Linux running as the root partition? */
>  bool hv_root_partition;
> @@ -212,6 +213,32 @@ static void __init hv_smp_prepare_boot_cpu(void)
>  	hv_init_spinlocks();
>  #endif
>  }
> +
> +static void __init hv_smp_prepare_cpus(unsigned int max_cpus)
> +{
> +#ifdef CONFIG_X86_64
> +	int i;
> +	int ret;
> +#endif
> +
> +	native_smp_prepare_cpus(max_cpus);
> +
> +#ifdef CONFIG_X86_64
> +	for_each_present_cpu(i) {
> +		if (i == 0)
> +			continue;
> +		ret = hv_call_add_logical_proc(numa_cpu_node(i), i, cpu_physical_id(i));
> +		BUG_ON(ret);
> +	}
> +
> +	for_each_present_cpu(i) {
> +		if (i == 0)
> +			continue;
> +		ret = hv_call_create_vp(numa_cpu_node(i), hv_current_partition_id, i, i);
> +		BUG_ON(ret);
> +	}
> +#endif
> +}
>  #endif
> 
>  static void __init ms_hyperv_init_platform(void)
> @@ -368,6 +395,8 @@ static void __init ms_hyperv_init_platform(void)
> 
>  # ifdef CONFIG_SMP
>  	smp_ops.smp_prepare_boot_cpu = hv_smp_prepare_boot_cpu;
> +	if (hv_root_partition)
> +		smp_ops.smp_prepare_cpus = hv_smp_prepare_cpus;
>  # endif
> 
>  	/*
> --
> 2.20.1

Reviewed-by: Michael Kelley <mikelley@microsoft.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
