Return-Path: <SRS0=+Z4V=G5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 724E1C433E0
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 03:14:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F20A022D58
	for <virtualization@archiver.kernel.org>; Tue, 26 Jan 2021 03:14:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F20A022D58
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8467E869B5;
	Tue, 26 Jan 2021 03:14:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5M0cSAqOu+7O; Tue, 26 Jan 2021 03:14:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id ABB1B8673B;
	Tue, 26 Jan 2021 03:14:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 99728C08A1;
	Tue, 26 Jan 2021 03:14:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3854C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 03:14:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 990F9203AF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 03:14:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Xx62lGuHXFg1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 03:14:09 +0000 (UTC)
X-Greylist: delayed 02:18:03 by SQLgrey-1.7.6
Received: from NAM02-SN1-obe.outbound.protection.outlook.com
 (mail-eopbgr770105.outbound.protection.outlook.com [40.107.77.105])
 by silver.osuosl.org (Postfix) with ESMTPS id 6EBAF203A3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jan 2021 03:14:09 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BFIf57gZPEdwcsmZZqrmGQ+piUG7K6vUmFcrnAou5IGdLhbvv09nPhfYRT1YGkvEmmnAyubDmxcqxWZ0Sps/a5nR6cOEyaCWuAxFL9c2p7GmYE7xOy0ELrqZBYy3eAulfy+wM1ek6hYIzQjIw40TufNp1MugpXrPscABIM+vSs7ha7S6B36kVHbxTioHtnK09kz1bsczQqd/d+Un8X2tIKgFCvvHFWb5HdPPnnAQN1NULC1Id8xf2ioSd++NppdbdoZN5LD83WLRVOM8SvvplcJLfHc5FBAUXzRN+nIBL2msdYx7BTLsdlHSn8fd3CAYJ3wDp3ycdG9Og906Djlh4g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbjKy3YYMl5siIE5QIwaxZ4tykBSM9B42E4legvRjhk=;
 b=HPZjyeClVh/Ihkov7rTrD9e/17zVYg+fOYF5ENyN0js/MsuE50cPOPUZe11tVtvlNd6MhlLWdzJsWymESydBd85lSbqwiellRbVoz0q0jUCNQNfhkPk8y43OLOTXwXtALbETj2PhiRUwvyBjAorz7xptuZLw14f26OKsa1p0aDWyt3ZmmzTz1vUIexP/yEgJmQhr51T8bbABHqhluh3urNHnWLoEhIBoucM6peVIbYXPrJRXGC5u2Ta8bj78r2hZ3/VF6MWBU3LKBL6TOv0Xou9LqY/JUSKaTHfzFLNDdkAMwVMByNVKlKseY99CFZ+My9tEPLUB3MAc6EIPqO/m4Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=VbjKy3YYMl5siIE5QIwaxZ4tykBSM9B42E4legvRjhk=;
 b=QHHLM+Jwnqb/+YL8dIdTsIPcCfqo7kOEBF+T0qFLs0OmIfMKUNNbfmcxB69dpDEmexQoXrMu9oCH8eIlu8aiC1zZptjYBhcSwXd4MemhPpcP8wAG3P7J+AqFvoFlmh0L9EuqVAJUZmPdryXEhgAW0L1ukni2cLBYHfxsY9S0OWQ=
Received: from (2603:10b6:301:7c::11) by
 MW4PR21MB1875.namprd21.prod.outlook.com (2603:10b6:303:72::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.3; Tue, 26 Jan 2021 00:41:05 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3825.003; Tue, 26 Jan 2021
 00:41:05 +0000
To: Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List
 <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v5 06/16] x86/hyperv: allocate output arg pages if required
Thread-Topic: [PATCH v5 06/16] x86/hyperv: allocate output arg pages if
 required
Thread-Index: AQHW7yPwFkR3Rhgf6kuMdLf0j4o32qo5GEFw
Date: Tue, 26 Jan 2021 00:41:05 +0000
Message-ID: <MWHPR21MB15938593C5E118766FECB58FD7BC9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-7-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-7-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-26T00:41:03Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=d0f06a5b-b57b-4879-a5a3-1cd9dd52a284;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [66.75.126.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: e803bf57-83d6-4580-551d-08d8c1931094
x-ms-traffictypediagnostic: MW4PR21MB1875:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB1875140865BA684801A141ECD7BC9@MW4PR21MB1875.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: moDXikPXhxdq//TRMB5pCud5ydFylRzEnBP08eG33sW0eQcErnAfkkiIfkcANDQS7gUF6KyXDFgvx2p6czDMeVjxTGVgTYl1sUw7K1cq2tRZkBdyQnUZc/Munpm9zZKAHxGceB6PaNmrarcxpCHSlBjdNieC1T44oMTBwBuU9OO3j0kBojvneQLHQAhooAKPRk114l0dVtqW/8lxqK5uWkNQPQTiwMJyUtRrfaH6EeEpuhX5IgAt/yqhhH9YxCdC35D56KvRuSbL9ZFPUhmMzyK7FIryBVyE59aeu+1u5fOgSxueoUuBFL3SqHQVvC0DFNH0nSFVwzNaGorGJP4ZPjo6TOkkkQPginTaI2zXAEVZqGa9+D8AENVQvLvbpdzDnojRkAcE4nzUyL3mUaal+lNhKR8IlVnkoR/yMzJB7Zd9lxyvBnAlPvAwprA0daUbI31rxrZT0qstVcq3GXiqW5R3qKkS05/uZ8bmO7iGC6OCfntiGMeayil1jbNshERWBIoQvurWRtF35BUfRFM5bw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR21MB1593.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(39860400002)(346002)(376002)(396003)(366004)(136003)(66946007)(66476007)(8676002)(9686003)(71200400001)(55016002)(76116006)(7416002)(4326008)(86362001)(10290500003)(186003)(7696005)(478600001)(5660300002)(8936002)(52536014)(110136005)(66556008)(66446008)(2906002)(26005)(54906003)(316002)(6506007)(64756008)(33656002)(82960400001)(82950400001)(83380400001)(8990500004);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?hcrP6C5mROxt8OBx3OAT12p3p5hnqynd60dpbMRM0C76N2nCdt4kIQuMMfof?=
 =?us-ascii?Q?IskX6EqDj9rFPHoSvoAHdUQWhTd/MhO8Ltwk7UsyTGhUdeYhVEFMntd7CPiK?=
 =?us-ascii?Q?XBQFfam28XhaxI/WF9U+ookoVW1GhE9y2VZjTLsdhMMYr/0W8nrPYzRS/rEV?=
 =?us-ascii?Q?/fxSd7JlnvS4wtn81g2zWYBU6e+r7KF34q+c8WDu225Wp2e4RYJsE8kmHrGo?=
 =?us-ascii?Q?YWDgMq21CpUgulb2Saf1gxpfVeezxAweKGVknaXiV2b7Z9XdgrqQF/QMINhG?=
 =?us-ascii?Q?YBPTJjuDWM+2GQ/EDDNH6hEjYunZSElEM+Dv5pjj6omkgJJNbn1UfExAhrIM?=
 =?us-ascii?Q?DtRB6wqXbqWzCnSJQAEVkSvRyOyRMpFXG/p+WNh8I35pxTKukGA0nC6mm44K?=
 =?us-ascii?Q?1uTpBJ8sRI5G9LLBRbfpqGmbH9/1LK80VunNTcwnXA+1a6zYEMkb1FviETtN?=
 =?us-ascii?Q?6G7GTj5ChHgW8je8cBfv5etImuRPa6AwjMx/oc9Jn3O8rrBw1lD3QvFUjbAw?=
 =?us-ascii?Q?+n5WCcSk7axaOv6/9Ul35B1gKo4oWsX5UAyi8Nj8Qk53Nn4XkPIBc/jddb8g?=
 =?us-ascii?Q?0NraG+/ekPb0SUY4R1saVccSvhaN5mlQMI35wXGmju/Y6DC/7TYhNuzvZjAj?=
 =?us-ascii?Q?QH8LfXZHVeGgJmsSz28px3OuExEnXomKxdcXef9RPa6qZ5qmDAmRd6o2meZk?=
 =?us-ascii?Q?RnqOScfpvdN/X0sFNc709cxIrbPbx5sBOtwwW+TG7AjtBusNARBSuHd/w3fI?=
 =?us-ascii?Q?OTgVrUBfYR3R41M5ctOG/+drl4CK9qbG7IJ44kT2wuCBBu5L6My03fg6aOcl?=
 =?us-ascii?Q?DnhYqiR/EZAE83ProBEzamzsWl/p0M3B1MoVlXOV7PcZooHrOeKcNPAoUZ2C?=
 =?us-ascii?Q?ZB/gOp370XOQe+s37j7ToD6WblKk5C4e2pU5tz/AHJXFopQkcz+hMeTg9mMe?=
 =?us-ascii?Q?gi/FgM6MiFQg3sKn+hiNrB0wTWP0hz3vYpsAun05VkHf87VhPESeWw7Cymug?=
 =?us-ascii?Q?3OQ+ZUebu87j/GgFaGx5PKvWurNmQezhXWV/6vZ8aGNjiqbkj5nNH7gEqtL1?=
 =?us-ascii?Q?xi0N8qUo?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e803bf57-83d6-4580-551d-08d8c1931094
X-MS-Exchange-CrossTenant-originalarrivaltime: 26 Jan 2021 00:41:05.3366 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: tFNhMuaE6pM8NsQ6VbwQeqbU6ExdK6EazGKC6I6xoHrVWnLiJNNr3X/CvI9sqXk2HEIlmKRF7WLWi6GN27efc3GnN8bkX3ujGOFiVPAFmZI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1875
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
> When Linux runs as the root partition, it will need to make hypercalls
> which return data from the hypervisor.
> 
> Allocate pages for storing results when Linux runs as the root
> partition.
> 
> Signed-off-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Co-Developed-by: Lillian Grassin-Drake <ligrassi@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> v3: Fix hv_cpu_die to use free_pages.
> v2: Address Vitaly's comments
> ---
>  arch/x86/hyperv/hv_init.c       | 35 ++++++++++++++++++++++++++++-----
>  arch/x86/include/asm/mshyperv.h |  1 +
>  2 files changed, 31 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index e04d90af4c27..6f4cb40e53fe 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -41,6 +41,9 @@ EXPORT_SYMBOL_GPL(hv_vp_assist_page);
>  void  __percpu **hyperv_pcpu_input_arg;
>  EXPORT_SYMBOL_GPL(hyperv_pcpu_input_arg);
> 
> +void  __percpu **hyperv_pcpu_output_arg;
> +EXPORT_SYMBOL_GPL(hyperv_pcpu_output_arg);
> +
>  u32 hv_max_vp_index;
>  EXPORT_SYMBOL_GPL(hv_max_vp_index);
> 
> @@ -73,12 +76,19 @@ static int hv_cpu_init(unsigned int cpu)
>  	void **input_arg;
>  	struct page *pg;
> 
> -	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
>  	/* hv_cpu_init() can be called with IRQs disabled from hv_resume() */
> -	pg = alloc_page(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL);
> +	pg = alloc_pages(irqs_disabled() ? GFP_ATOMIC : GFP_KERNEL, hv_root_partition ?
> 1 : 0);
>  	if (unlikely(!pg))
>  		return -ENOMEM;
> +
> +	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
>  	*input_arg = page_address(pg);
> +	if (hv_root_partition) {
> +		void **output_arg;
> +
> +		output_arg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
> +		*output_arg = page_address(pg + 1);
> +	}
> 
>  	hv_get_vp_index(msr_vp_index);
> 
> @@ -205,14 +215,23 @@ static int hv_cpu_die(unsigned int cpu)
>  	unsigned int new_cpu;
>  	unsigned long flags;
>  	void **input_arg;
> -	void *input_pg = NULL;
> +	void *pg;
> 
>  	local_irq_save(flags);
>  	input_arg = (void **)this_cpu_ptr(hyperv_pcpu_input_arg);
> -	input_pg = *input_arg;
> +	pg = *input_arg;
>  	*input_arg = NULL;
> +
> +	if (hv_root_partition) {
> +		void **output_arg;
> +
> +		output_arg = (void **)this_cpu_ptr(hyperv_pcpu_output_arg);
> +		*output_arg = NULL;
> +	}
> +
>  	local_irq_restore(flags);
> -	free_page((unsigned long)input_pg);
> +
> +	free_pages((unsigned long)pg, hv_root_partition ? 1 : 0);
> 
>  	if (hv_vp_assist_page && hv_vp_assist_page[cpu])
>  		wrmsrl(HV_X64_MSR_VP_ASSIST_PAGE, 0);
> @@ -346,6 +365,12 @@ void __init hyperv_init(void)
> 
>  	BUG_ON(hyperv_pcpu_input_arg == NULL);
> 
> +	/* Allocate the per-CPU state for output arg for root */
> +	if (hv_root_partition) {
> +		hyperv_pcpu_output_arg = alloc_percpu(void *);
> +		BUG_ON(hyperv_pcpu_output_arg == NULL);
> +	}
> +
>  	/* Allocate percpu VP index */
>  	hv_vp_index = kmalloc_array(num_possible_cpus(), sizeof(*hv_vp_index),
>  				    GFP_KERNEL);
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index ac2b0d110f03..62d9390f1ddf 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -76,6 +76,7 @@ static inline void hv_disable_stimer0_percpu_irq(int irq) {}
>  #if IS_ENABLED(CONFIG_HYPERV)
>  extern void *hv_hypercall_pg;
>  extern void  __percpu  **hyperv_pcpu_input_arg;
> +extern void  __percpu  **hyperv_pcpu_output_arg;
> 
>  static inline u64 hv_do_hypercall(u64 control, void *input, void *output)
>  {
> --
> 2.20.1

I think this all works OK.  But a meta question:  Do we need a separate
per-cpu output argument page?  From the Hyper-V hypercall standpoint, I
don't think input and output args need to be in separate pages.  They both
just need to not cross a page boundary.  As long as we don't have a hypercall
where the sum of the sizes of the input and output args exceeds a page,
we could just have a single page, and split it up in any manner that works
for the particular hypercall.

Thoughts?

Michael


_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
