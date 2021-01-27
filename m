Return-Path: <SRS0=N1kl=G6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FA00C433E0
	for <virtualization@archiver.kernel.org>; Wed, 27 Jan 2021 05:47:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB69320709
	for <virtualization@archiver.kernel.org>; Wed, 27 Jan 2021 05:47:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB69320709
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 40A7A20531;
	Wed, 27 Jan 2021 05:47:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oT7GHDv7b+Xh; Wed, 27 Jan 2021 05:47:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 60BB0200ED;
	Wed, 27 Jan 2021 05:47:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E50DC08A1;
	Wed, 27 Jan 2021 05:47:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88E43C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 05:47:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 845648554A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 05:47:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Jy6d6Zqd8hTL
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 05:47:06 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from NAM10-MW2-obe.outbound.protection.outlook.com
 (mail-mw2nam10on2130.outbound.protection.outlook.com [40.107.94.130])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8E63184EF0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jan 2021 05:47:06 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Abq3C/jG1fKYhV9/sXiwars//zxyOP2kHKLBr0z7HW6+vh3yN4oJGlWBtwQAqThdXPcSs+Bp/hWQqCLR0G+SSVXC17te/5h6M3gxVm5cSnVhtSIdSp9MUa+zSQP57qnZ7+YDSUb2dJT07mn3DtRfwfnsA/hR2wwUKiK9lq+5JfLwbRZA5Rvmi4U6HOjQBEVqpaHYefT4YNxejPUciCzrEiO0UnpD+/cBUoniZt6TQv+SqXGGQ4yF1hkaZEOUNkB6U4bTuyr5gUphRqMrZ6uYjD3uKeZid85LDR90gn9nBhE+YHWXufPWjZ7nNSm5WWb9Pm0i6G8Otv9JwWlLsrUN7w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZ9z5X96EewKkfj7Wk7lxHDa9VSWI3z5dMotn8jnYMY=;
 b=U742e5NkrxnkblEaPXra62CQaSeaXXku/T4u1Acc1vTP6uP/sqwzZB/3iWN6KURMcioyIgSFvBl8JmHnH4AXLMpYUq1AUoe8gl+oFJtj40jh8W3S29vdnXAvcLg5Yl8Eq4kY6CcgQF2ApQ+GO/p8WWF0Of/ZIDQMQy1XwAhdoZhY/6vFgUzL7tyT9wOdJMl2wBGaXWPX9jjDRT8OBgoSsbjvAkBGpb58dH41RtqdKDtpq0Mp4rAh6ipwIZVLej4hste839RyP8lf38jodbL8h0yrdMQ9wXXe4/PjKbRRLxeWY9LGkDCeWw3GtRWZn1zhO3+zbbWV4DPu4J2j+/AWqw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fZ9z5X96EewKkfj7Wk7lxHDa9VSWI3z5dMotn8jnYMY=;
 b=KRKcHV8YBDpzJqnG+zBEiA4bJtK8N6d7yqLdN7kBmf/TTUal35w8Ywv0J8G5NHBa/vZSCnFUJHBhNbThc7B879OGo0FqWubZ637vk/ft+hyWuALeStCqqrwlxQDZ6k7r05mSq3fpbglP/m4Y7ceU+SDY9XkeVNZOO5p5vBZbjwY=
Received: from (2603:10b6:301:7c::11) by
 MW4PR21MB1987.namprd21.prod.outlook.com (2603:10b6:303:78::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3825.2; Wed, 27 Jan 2021 05:47:04 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3825.003; Wed, 27 Jan 2021
 05:47:04 +0000
To: Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List
 <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v5 15/16] x86/hyperv: implement an MSI domain for root
 partition
Thread-Topic: [PATCH v5 15/16] x86/hyperv: implement an MSI domain for root
 partition
Thread-Index: AQHW7yP6HaVdmem27E2jxVVgXGHGnKo6+Dxg
Date: Wed, 27 Jan 2021 05:47:04 +0000
Message-ID: <MWHPR21MB1593FFC6005966A3D9BEA3EFD7BB9@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210120120058.29138-1-wei.liu@kernel.org>
 <20210120120058.29138-16-wei.liu@kernel.org>
In-Reply-To: <20210120120058.29138-16-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-01-27T05:47:02Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=a867e241-d853-41ae-a1dd-f1e6507754aa;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [66.75.126.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 82b20901-dbb2-4b47-5814-08d8c286f9e2
x-ms-traffictypediagnostic: MW4PR21MB1987:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB19874D85D74818DA403082B6D7BB9@MW4PR21MB1987.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1122;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: MA4MiQAXfSFZSC6Qk4OIwrdbTk6EEgLbl/OXFROr0JPiaZIrhzzdhWa5rzGEl30P9acSct2ILjyiVMGtKGsxAncSW9nflsFGqWwne2ysOyQushsc0aUPBXkVxy0uEd9OBeFpYet5Z0D3q+kyUz6higrUtaS/vdTWYnXsAwrf+V4B46Cv/FwOe3SruTQvj/eNvhbm7CTr7b0x9tVXrq55vC3DVnHTs0DT9giQ/0kRHNkO7ynFiadtJSMxP5H0+WNkHtg4EXIyDHLvZIJKQngOdihAYHKHWTDYdbCOxE75BsdLvSDduPMQXyYy2zfiHk3flIfc1gsQCG0G2V0KlnZCVw1hBuundQoioxNAl9RnGmGcjaqMCWLPIr4vsNGbjy6tELG/yAselcyLpMxZZ2IwwIIKHqxKNJ/OZplD5502MiPhNUxzGQqBJkox8isE4mR/Ch5GPD6CoEbYWgR+lDnWWIv1VM30mXrti4spuNbLinhs4Y4AwtQ3Pw+GjkK12eMv8j6fnMyszxKlrgLhzyIYTw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR21MB1593.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(396003)(376002)(366004)(39860400002)(136003)(346002)(186003)(26005)(7696005)(2906002)(30864003)(8936002)(83380400001)(64756008)(55016002)(5660300002)(8676002)(6506007)(9686003)(10290500003)(478600001)(66946007)(33656002)(110136005)(52536014)(76116006)(86362001)(54906003)(71200400001)(8990500004)(4326008)(316002)(66476007)(66446008)(82950400001)(7416002)(66556008)(82960400001);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: =?us-ascii?Q?pYjNtKRZ9jswC08uH4tGMGJTyfW2BGULAxTPNxfVbF+e+2JoESEhXaOXdB+h?=
 =?us-ascii?Q?a7ppIKOmD/qDhHEzXsvyBmHWu4eXIRYP8NLk0PnVV2vtOqvfNH/wOc4bbS25?=
 =?us-ascii?Q?ZVPKGKIZxf6PD9uVonNsuYr90+Rfyp41sqsjK2m99cWwmkvSqRLBu8PxYpQc?=
 =?us-ascii?Q?2you/XZtcBHNSC1mq9tR9p+tB68GUxWRt9SjPeFMqqIEdxzzoZyreglW8W9M?=
 =?us-ascii?Q?H+Bc5GCOzeH5et0Wyo20YBxxBBTxDJyy7C0DW/aX6IpY7K7r2jnibUD56WlX?=
 =?us-ascii?Q?YGAODKBsjDe4U/ntP9M/NnveXsmXyU8RqDIKdQ4EAQJcbCTOIAZ4IvQ+QlCx?=
 =?us-ascii?Q?vNwtUThitEmp8qCbVEqA7jOLapI6i5mOmuZMLOtxVdkDeJZv7bskXZqv2WxZ?=
 =?us-ascii?Q?Sp/mqdbEUgDIpb0Uq+f3SvEXoukDNQvh7pMmwMTXaShbM76fjVLy+l+ZYJzD?=
 =?us-ascii?Q?SuSr7nYqZoTUNUdtEsVvaUpwLRtQ70Oc/oo+3qrqO124qW0Eq27q6RjbAPjY?=
 =?us-ascii?Q?Enrr1k3uG99Zr20uqhq/h0Y0iE+wazMSB0nDb/AXfkvC8Vhv3exeoTs3XGlP?=
 =?us-ascii?Q?jD/ZIE7XDKW1oQX+j7/mq59tDP46rlohMjwO1JdzrfIcfpcFP5l3rSeej/+J?=
 =?us-ascii?Q?GZ5dmYIrQso/9yrOtqaziyaeyHW/P2Vbt8PImGxxyKbFkAPy24Jk0FNR9937?=
 =?us-ascii?Q?gMdU96KdJxGJ2i1LAloZd9ypfFA3DlRYWgE17+KQICiJDGkKLu0NjuHPpQbu?=
 =?us-ascii?Q?VEbE+MX+dDJYyDnofgCgfQYLAihyJbL27IlwGq5JRa5w32vA62y4fPW6KeH7?=
 =?us-ascii?Q?OoAea83NlbKa2dYTqVkwYFgOv1jqTv0SZZsZpfLPAW7i6rg7y/IAc5f32Wws?=
 =?us-ascii?Q?/qKnSkW+YIEZrK0p8vQ6/ZcPLF8iYYksPgw2d3+6OLxac979A9+H2OrIk/ar?=
 =?us-ascii?Q?/tFZOlQQDuxwJMDA7Z9xEMedVilpiRqrsH5uLjSbPIaI2QxJTi8B3fE+7B/M?=
 =?us-ascii?Q?YOhxJQpIjH7FPoB0AUXGYTo1mJ3U+0HF9iAXC0wOqWQtG7sM61eB5pZms4/V?=
 =?us-ascii?Q?Epa0MrXJ?=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 82b20901-dbb2-4b47-5814-08d8c286f9e2
X-MS-Exchange-CrossTenant-originalarrivaltime: 27 Jan 2021 05:47:04.4583 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: sMvLe51tPffI4LueOQzPBwngdnSpFQlCdsqHY33y6lDjMbXRe/WwMfWacaLBfRlilECWqXiznvr7DlyQEgl/kLi/wcUNeMTprtFlBqLQtpI=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1987
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

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, January 20, 2021 4:01 AM
> 
> When Linux runs as the root partition on Microsoft Hypervisor, its
> interrupts are remapped.  Linux will need to explicitly map and unmap
> interrupts for hardware.
> 
> Implement an MSI domain to issue the correct hypercalls. And initialize
> this irqdomain as the default MSI irq domain.
> 
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
> v4: Fix compilation issue when CONFIG_PCI_MSI is not set.
> v3: build irqdomain.o for 32bit as well.

I'm not clear on the intent for 32-bit builds.  Given that hv_proc.c is built
only for 64-bit, I'm assuming running Linux in the root partition
is only functional for 64-bit builds.  So is the goal simply that 32-bit
builds will compile correctly?  Seems like maybe there should be
a CONFIG option for running Linux in the root partition, and that
option would force 64-bit.

> v2: This patch is simplified due to upstream changes.
> ---
>  arch/x86/hyperv/Makefile        |   2 +-
>  arch/x86/hyperv/hv_init.c       |   9 +
>  arch/x86/hyperv/irqdomain.c     | 332 ++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h |   2 +
>  4 files changed, 344 insertions(+), 1 deletion(-)
>  create mode 100644 arch/x86/hyperv/irqdomain.c
> 
> diff --git a/arch/x86/hyperv/Makefile b/arch/x86/hyperv/Makefile
> index 565358020921..48e2c51464e8 100644
> --- a/arch/x86/hyperv/Makefile
> +++ b/arch/x86/hyperv/Makefile
> @@ -1,5 +1,5 @@
>  # SPDX-License-Identifier: GPL-2.0-only
> -obj-y			:= hv_init.o mmu.o nested.o
> +obj-y			:= hv_init.o mmu.o nested.o irqdomain.o
>  obj-$(CONFIG_X86_64)	+= hv_apic.o hv_proc.o
> 
>  ifdef CONFIG_X86_64
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index ad8e77859b32..1cb2f7d1850a 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -484,6 +484,15 @@ void __init hyperv_init(void)
> 
>  	BUG_ON(hv_root_partition && hv_current_partition_id == ~0ull);
> 
> +#ifdef CONFIG_PCI_MSI
> +	/*
> +	 * If we're running as root, we want to create our own PCI MSI domain.
> +	 * We can't set this in hv_pci_init because that would be too late.
> +	 */
> +	if (hv_root_partition)
> +		x86_init.irqs.create_pci_msi_domain = hv_create_pci_msi_domain;
> +#endif
> +
>  	return;
> 
>  remove_cpuhp_state:
> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> new file mode 100644
> index 000000000000..19637cd60231
> --- /dev/null
> +++ b/arch/x86/hyperv/irqdomain.c
> @@ -0,0 +1,332 @@
> +// SPDX-License-Identifier: GPL-2.0
> +//
> +// Irqdomain for Linux to run as the root partition on Microsoft Hypervisor.
> +//
> +// Authors:
> +//   Sunil Muthuswamy <sunilmut@microsoft.com>
> +//   Wei Liu <wei.liu@kernel.org>

I think the // comment style should only be used for the SPDX line.

> +
> +#include <linux/pci.h>
> +#include <linux/irq.h>
> +#include <asm/mshyperv.h>
> +
> +static int hv_unmap_interrupt(u64 id, struct hv_interrupt_entry *old_entry)
> +{
> +	unsigned long flags;
> +	struct hv_input_unmap_device_interrupt *input;
> +	struct hv_interrupt_entry *intr_entry;
> +	u16 status;
> +
> +	local_irq_save(flags);
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +
> +	memset(input, 0, sizeof(*input));
> +	intr_entry = &input->interrupt_entry;
> +	input->partition_id = hv_current_partition_id;
> +	input->device_id = id;
> +	*intr_entry = *old_entry;
> +
> +	status = hv_do_rep_hypercall(HVCALL_UNMAP_DEVICE_INTERRUPT, 0, 0, input, NULL) &
> +			 HV_HYPERCALL_RESULT_MASK;
> +	local_irq_restore(flags);
> +
> +	return status;
> +}
> +
> +#ifdef CONFIG_PCI_MSI
> +struct rid_data {
> +	struct pci_dev *bridge;
> +	u32 rid;
> +};
> +
> +static int get_rid_cb(struct pci_dev *pdev, u16 alias, void *data)
> +{
> +	struct rid_data *rd = data;
> +	u8 bus = PCI_BUS_NUM(rd->rid);
> +
> +	if (pdev->bus->number != bus || PCI_BUS_NUM(alias) != bus) {
> +		rd->bridge = pdev;
> +		rd->rid = alias;
> +	}
> +
> +	return 0;
> +}
> +
> +static union hv_device_id hv_build_pci_dev_id(struct pci_dev *dev)
> +{
> +	union hv_device_id dev_id;
> +	struct rid_data data = {
> +		.bridge = NULL,
> +		.rid = PCI_DEVID(dev->bus->number, dev->devfn)
> +	};
> +
> +	pci_for_each_dma_alias(dev, get_rid_cb, &data);
> +
> +	dev_id.as_uint64 = 0;
> +	dev_id.device_type = HV_DEVICE_TYPE_PCI;
> +	dev_id.pci.segment = pci_domain_nr(dev->bus);
> +
> +	dev_id.pci.bdf.bus = PCI_BUS_NUM(data.rid);
> +	dev_id.pci.bdf.device = PCI_SLOT(data.rid);
> +	dev_id.pci.bdf.function = PCI_FUNC(data.rid);
> +	dev_id.pci.source_shadow = HV_SOURCE_SHADOW_NONE;
> +
> +	if (data.bridge) {
> +		int pos;
> +
> +		/*
> +		 * Microsoft Hypervisor requires a bus range when the bridge is
> +		 * running in PCI-X mode.
> +		 *
> +		 * To distinguish conventional vs PCI-X bridge, we can check
> +		 * the bridge's PCI-X Secondary Status Register, Secondary Bus
> +		 * Mode and Frequency bits. See PCI Express to PCI/PCI-X Bridge
> +		 * Specification Revision 1.0 5.2.2.1.3.
> +		 *
> +		 * Value zero means it is in conventional mode, otherwise it is
> +		 * in PCI-X mode.
> +		 */
> +
> +		pos = pci_find_capability(data.bridge, PCI_CAP_ID_PCIX);
> +		if (pos) {
> +			u16 status;
> +
> +			pci_read_config_word(data.bridge, pos +
> +					PCI_X_BRIDGE_SSTATUS, &status);
> +
> +			if (status & PCI_X_SSTATUS_FREQ) {
> +				/* Non-zero, PCI-X mode */
> +				u8 sec_bus, sub_bus;
> +
> +				dev_id.pci.source_shadow = HV_SOURCE_SHADOW_BRIDGE_BUS_RANGE;
> +
> +				pci_read_config_byte(data.bridge, PCI_SECONDARY_BUS, &sec_bus);
> +				dev_id.pci.shadow_bus_range.secondary_bus = sec_bus;
> +				pci_read_config_byte(data.bridge, PCI_SUBORDINATE_BUS, &sub_bus);
> +				dev_id.pci.shadow_bus_range.subordinate_bus = sub_bus;
> +			}
> +		}
> +	}
> +
> +	return dev_id;
> +}
> +
> +static int hv_map_msi_interrupt(struct pci_dev *dev, int vcpu, int vector,
> +				struct hv_interrupt_entry *entry)
> +{
> +	struct hv_input_map_device_interrupt *input;
> +	struct hv_output_map_device_interrupt *output;
> +	struct hv_device_interrupt_descriptor *intr_desc;
> +	unsigned long flags;
> +	u16 status;
> +
> +	local_irq_save(flags);
> +
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +	intr_desc = &input->interrupt_descriptor;
> +	memset(input, 0, sizeof(*input));
> +	input->partition_id = hv_current_partition_id;
> +	input->device_id = hv_build_pci_dev_id(dev).as_uint64;
> +	intr_desc->interrupt_type = HV_X64_INTERRUPT_TYPE_FIXED;
> +	intr_desc->trigger_mode = HV_INTERRUPT_TRIGGER_MODE_EDGE;
> +	intr_desc->vector_count = 1;
> +	intr_desc->target.vector = vector;
> +	__set_bit(vcpu, (unsigned long*)&intr_desc->target.vp_mask);

This is using the CPU bitmap format that supports up to 64 vCPUs.  Any reason not
to use the format that supports a larger number of CPUs?   In either case, perhaps
a check for the value of vcpu against the max of 64 (or the larger number if you
change the bitmap format) would be appropriate.

> +
> +	status = hv_do_rep_hypercall(HVCALL_MAP_DEVICE_INTERRUPT, 0, 0, input, output) &
> +			 HV_HYPERCALL_RESULT_MASK;
> +	*entry = output->interrupt_entry;
> +
> +	local_irq_restore(flags);
> +
> +	if (status != HV_STATUS_SUCCESS)
> +		pr_err("%s: hypercall failed, status %d\n", __func__, status);
> +
> +	return status;
> +}
> +
> +static inline void entry_to_msi_msg(struct hv_interrupt_entry *entry, struct msi_msg *msg)
> +{
> +	/* High address is always 0 */
> +	msg->address_hi = 0;
> +	msg->address_lo = entry->msi_entry.address.as_uint32;
> +	msg->data = entry->msi_entry.data.as_uint32;
> +}
> +
> +static int hv_unmap_msi_interrupt(struct pci_dev *dev, struct hv_interrupt_entry *old_entry);
> +static void hv_irq_compose_msi_msg(struct irq_data *data, struct msi_msg *msg)
> +{
> +	struct msi_desc *msidesc;
> +	struct pci_dev *dev;
> +	struct hv_interrupt_entry out_entry, *stored_entry;
> +	struct irq_cfg *cfg = irqd_cfg(data);
> +	struct cpumask *affinity;
> +	int cpu, vcpu;
> +	u16 status;
> +
> +	msidesc = irq_data_get_msi_desc(data);
> +	dev = msi_desc_to_pci_dev(msidesc);
> +
> +	if (!cfg) {
> +		pr_debug("%s: cfg is NULL", __func__);
> +		return;
> +	}
> +
> +	affinity = irq_data_get_effective_affinity_mask(data);
> +	cpu = cpumask_first_and(affinity, cpu_online_mask);
> +	vcpu = hv_cpu_number_to_vp_number(cpu);
> +
> +	if (data->chip_data) {
> +		/*
> +		 * This interrupt is already mapped. Let's unmap first.
> +		 *
> +		 * We don't use retarget interrupt hypercalls here because
> +		 * Microsoft Hypervisor doens't allow root to change the vector
> +		 * or specify VPs outside of the set that is initially used
> +		 * during mapping.
> +		 */
> +		stored_entry = data->chip_data;
> +		data->chip_data = NULL;
> +
> +		status = hv_unmap_msi_interrupt(dev, stored_entry);
> +
> +		kfree(stored_entry);
> +
> +		if (status != HV_STATUS_SUCCESS) {
> +			pr_debug("%s: failed to unmap, status %d", __func__, status);
> +			return;
> +		}
> +	}
> +
> +	stored_entry = kzalloc(sizeof(*stored_entry), GFP_ATOMIC);
> +	if (!stored_entry) {
> +		pr_debug("%s: failed to allocate chip data\n", __func__);
> +		return;
> +	}
> +
> +	status = hv_map_msi_interrupt(dev, vcpu, cfg->vector, &out_entry);
> +	if (status != HV_STATUS_SUCCESS) {
> +		kfree(stored_entry);
> +		return;
> +	}
> +
> +	*stored_entry = out_entry;
> +	data->chip_data = stored_entry;
> +	entry_to_msi_msg(&out_entry, msg);
> +
> +	return;
> +}
> +
> +static int hv_unmap_msi_interrupt(struct pci_dev *dev, struct hv_interrupt_entry
> *old_entry)
> +{
> +	return hv_unmap_interrupt(hv_build_pci_dev_id(dev).as_uint64, old_entry)
> +		& HV_HYPERCALL_RESULT_MASK;

The masking with HV_HYPERCALL_RESULT_MASK is already done in
hv_unmap_interrupt().

> +}
> +
> +static void hv_teardown_msi_irq_common(struct pci_dev *dev, struct msi_desc
> *msidesc, int irq)
> +{
> +	u16 status;
> +	struct hv_interrupt_entry old_entry;
> +	struct irq_desc *desc;
> +	struct irq_data *data;
> +	struct msi_msg msg;
> +
> +	desc = irq_to_desc(irq);
> +	if (!desc) {
> +		pr_debug("%s: no irq desc\n", __func__);
> +		return;
> +	}
> +
> +	data = &desc->irq_data;
> +	if (!data) {
> +		pr_debug("%s: no irq data\n", __func__);
> +		return;
> +	}
> +
> +	if (!data->chip_data) {
> +		pr_debug("%s: no chip data\n!", __func__);
> +		return;
> +	}
> +
> +	old_entry = *(struct hv_interrupt_entry *)data->chip_data;
> +	entry_to_msi_msg(&old_entry, &msg);
> +
> +	kfree(data->chip_data);
> +	data->chip_data = NULL;
> +
> +	status = hv_unmap_msi_interrupt(dev, &old_entry);
> +
> +	if (status != HV_STATUS_SUCCESS) {
> +		pr_err("%s: hypercall failed, status %d\n", __func__, status);
> +		return;
> +	}
> +}
> +
> +static void hv_msi_domain_free_irqs(struct irq_domain *domain, struct device *dev)
> +{
> +	int i;
> +	struct msi_desc *entry;
> +	struct pci_dev *pdev;
> +
> +	if (WARN_ON_ONCE(!dev_is_pci(dev)))
> +		return;
> +
> +	pdev = to_pci_dev(dev);
> +
> +	for_each_pci_msi_entry(entry, pdev) {
> +		if (entry->irq) {
> +			for (i = 0; i < entry->nvec_used; i++) {
> +				hv_teardown_msi_irq_common(pdev, entry, entry->irq +
> i);
> +				irq_domain_free_irqs(entry->irq + i, 1);
> +			}
> +		}
> +	}
> +}
> +
> +/*
> + * IRQ Chip for MSI PCI/PCI-X/PCI-Express Devices,
> + * which implement the MSI or MSI-X Capability Structure.
> + */
> +static struct irq_chip hv_pci_msi_controller = {
> +	.name			= "HV-PCI-MSI",
> +	.irq_unmask		= pci_msi_unmask_irq,
> +	.irq_mask		= pci_msi_mask_irq,
> +	.irq_ack		= irq_chip_ack_parent,
> +	.irq_retrigger		= irq_chip_retrigger_hierarchy,
> +	.irq_compose_msi_msg	= hv_irq_compose_msi_msg,
> +	.irq_set_affinity	= msi_domain_set_affinity,
> +	.flags			= IRQCHIP_SKIP_SET_WAKE,
> +};
> +
> +static struct msi_domain_ops pci_msi_domain_ops = {
> +	.domain_free_irqs	= hv_msi_domain_free_irqs,
> +	.msi_prepare		= pci_msi_prepare,
> +};
> +
> +static struct msi_domain_info hv_pci_msi_domain_info = {
> +	.flags		= MSI_FLAG_USE_DEF_DOM_OPS |
> MSI_FLAG_USE_DEF_CHIP_OPS |
> +			  MSI_FLAG_PCI_MSIX,
> +	.ops		= &pci_msi_domain_ops,
> +	.chip		= &hv_pci_msi_controller,
> +	.handler	= handle_edge_irq,
> +	.handler_name	= "edge",
> +};
> +
> +struct irq_domain * __init hv_create_pci_msi_domain(void)
> +{
> +	struct irq_domain *d = NULL;
> +	struct fwnode_handle *fn;
> +
> +	fn = irq_domain_alloc_named_fwnode("HV-PCI-MSI");
> +	if (fn)
> +		d = pci_msi_create_irq_domain(fn, &hv_pci_msi_domain_info,
> x86_vector_domain);
> +
> +	/* No point in going further if we can't get an irq domain */
> +	BUG_ON(!d);
> +
> +	return d;
> +}
> +
> +#endif /* CONFIG_PCI_MSI */
> diff --git a/arch/x86/include/asm/mshyperv.h b/arch/x86/include/asm/mshyperv.h
> index cbee72550a12..ccc849e25d5e 100644
> --- a/arch/x86/include/asm/mshyperv.h
> +++ b/arch/x86/include/asm/mshyperv.h
> @@ -261,6 +261,8 @@ static inline void hv_set_msi_entry_from_desc(union hv_msi_entry
> *msi_entry,
>  	msi_entry->data.as_uint32 = msi_desc->msg.data;
>  }
> 
> +struct irq_domain *hv_create_pci_msi_domain(void);
> +
>  #else /* CONFIG_HYPERV */
>  static inline void hyperv_init(void) {}
>  static inline void hyperv_setup_mmu_ops(void) {}
> --
> 2.20.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
