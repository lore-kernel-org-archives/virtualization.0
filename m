Return-Path: <SRS0=AmYR=HG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4F4BC433E0
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 17:57:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22C6764E27
	for <virtualization@archiver.kernel.org>; Thu,  4 Feb 2021 17:57:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22C6764E27
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8F2E78687B;
	Thu,  4 Feb 2021 17:57:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5TBwla6cT19r; Thu,  4 Feb 2021 17:57:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A850386130;
	Thu,  4 Feb 2021 17:57:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82218C07FD;
	Thu,  4 Feb 2021 17:57:44 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C750C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 17:57:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 87D0186CC5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 17:57:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id x17if29aaUKu
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 17:57:42 +0000 (UTC)
X-Greylist: delayed 01:02:40 by SQLgrey-1.7.6
Received: from NAM11-BN8-obe.outbound.protection.outlook.com
 (mail-bn8nam11on2114.outbound.protection.outlook.com [40.107.236.114])
 by whitealder.osuosl.org (Postfix) with ESMTPS id D20A286CBE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 Feb 2021 17:57:41 +0000 (UTC)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HXhmR/77Zeqf6uFd/z/s2lQVnjZ3RBfqlHU7bnqGVBvBOh0KcLJba+Lo+s7Ge61tQ8ceJJJL9m/RBkS4Ms8N3Gm3cZEQXYz3+iF6j721KVzDFDu0U+bxArHY7DPBsQOmQa/gH3nmxTyTMPOcVxjE45Rdy2mW9rZq9dSvbTV/CEHUympelbfTxXjyNCVnwEhYS/f1PqyBPNnZGVV1TTINLb2vKhr7k+b92LNahyTCK97xJXx+N71Mqde6hgGKI5g5ztG4oxZiZC6WG/FU2hKfVx7+16gNmex94B62Wo6OXP/ilBpmRj3uFL1KGCkQuw14o9T6EWZ4QoPDB5Rf5oNmRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wvp1YRVO5w340d7lm7du64JxrP7azioLEjsLvVDiGM=;
 b=OV6GVUd/U2c1hcN/KUGnK6qH56NKbXjTnKpQHA7J4++XJ1MvEV8guLYpOqCiXjwJ7vafwxtL9fYo0BJistN7yQUqgfadKw3kbrkh7/pe+EnGtPkq6lwq/iK5/7GKFyW4IeZfh9NUdudkqnFBtqOvUmKHtxQERVjYcyrokgElrcPumNm8DOAQMuW54f60jneVpqWNGB8HAtAK2awUNY3AoK8JLXS2d6hAtDFZTBXbQNfLtEGJ0lbc85CeEct2Kii6m220CfmKbiahHJpEc6/0kMOTlM0KVAbTDh+5CAIQV0RPQ2QYUp+dO5wwvAaoKk/G8+oq3aZxOZNyo+T3+iW/NA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=microsoft.com; dmarc=pass action=none
 header.from=microsoft.com; dkim=pass header.d=microsoft.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=1wvp1YRVO5w340d7lm7du64JxrP7azioLEjsLvVDiGM=;
 b=dzkWGhS/IXqlDNBFG3ydhCpjAmWfUoyCeop8vfF/0MovsknK1b8kOIyEkbQE2AOijElFwBqGW3kpkisbcuLKryQuMv+SN/ybGlQXsR9dhudWOCvEZ40w7kC8wC+BNAVdw0Njx5HtOPNdQYkIoEYi5ptov8xpwiVG5o33IDSQnbQ=
Received: from (2603:10b6:301:7c::11) by
 MW4PR21MB1986.namprd21.prod.outlook.com (2603:10b6:303:7d::13) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.3805.3; Thu, 4 Feb 2021 17:43:16 +0000
Received: from MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2]) by MWHPR21MB1593.namprd21.prod.outlook.com
 ([fe80::9c8:94c9:faf1:17c2%9]) with mapi id 15.20.3846.006; Thu, 4 Feb 2021
 17:43:16 +0000
To: Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List
 <linux-hyperv@vger.kernel.org>
Subject: RE: [PATCH v6 15/16] x86/hyperv: implement an MSI domain for root
 partition
Thread-Topic: [PATCH v6 15/16] x86/hyperv: implement an MSI domain for root
 partition
Thread-Index: AQHW+j3xAalli8BY20CIoxf429V3G6pIPvGw
Date: Thu, 4 Feb 2021 17:43:16 +0000
Message-ID: <MWHPR21MB15932010E9CF5975EBAD1EDAD7B39@MWHPR21MB1593.namprd21.prod.outlook.com>
References: <20210203150435.27941-1-wei.liu@kernel.org>
 <20210203150435.27941-16-wei.liu@kernel.org>
In-Reply-To: <20210203150435.27941-16-wei.liu@kernel.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
msip_labels: MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Enabled=true;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SetDate=2021-02-04T17:43:14Z; 
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Method=Standard;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_Name=Internal;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_SiteId=72f988bf-86f1-41af-91ab-2d7cd011db47;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ActionId=8e935c7f-865b-4bff-b81c-11d93292b68a;
 MSIP_Label_f42aa342-8706-4288-bd11-ebb85995028c_ContentBits=0
authentication-results: kernel.org; dkim=none (message not signed)
 header.d=none;kernel.org; dmarc=none action=none header.from=microsoft.com;
x-originating-ip: [24.22.167.197]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 94446d1c-3140-4145-5162-08d8c9345a9f
x-ms-traffictypediagnostic: MW4PR21MB1986:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <MW4PR21MB19862D92C683848BDC7B717FD7B39@MW4PR21MB1986.namprd21.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:4941;
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 9pbkEOlp09C7Eoa7Zxp/AVt+GQJpEyZJ8nhQhkONi3yPF5RNIWx1hop/auFes6VgA0r6KPyOmYjywBuybxBNcdtB3VXUGuYjyhMkZON0ILWBEs+oGisLfWCLnsQbd2SSP9rlnhqWYhJxmyZ/TGaF5jp2r3lv7lwQcH+pQ/H/1rxjvtZTDH4hPiMvSebNAlRx8DybBIyBywq/9/QHkNuNcIR2AUYzMqeVy1PLAFGRwT+eriB/cbXNjdtqMa4eSA535djk6Jxe5tAJwRO6FVk/6qjBBRv10m3Hf07XTSasEC7FpiEQ/yuqo19fxd1cywPccEm/OYuc1XZM5xMAWlYIZHZK2nU2KreZKgnVIR5+JVmpb3Zv6GSAlnkryI4y3kjBhUjykdO7xiknUK+W7aSbw4sLujFokt2uUXOMs16Df05RqkqZn5oLLuuf5ZUptg9kWOpM2/bzRCFzKT7jGNUTDW3d+KL2L01sFcMgZaAQQkkoCqvMwpN+lkeWe6Hb3hihiZM0JQ34TNSQEWC9s60iTw==
x-forefront-antispam-report: CIP:255.255.255.255; CTRY:; LANG:en; SCL:1; SRV:;
 IPV:NLI; SFV:NSPM; H:MWHPR21MB1593.namprd21.prod.outlook.com; PTR:; CAT:NONE;
 SFS:(4636009)(136003)(376002)(366004)(396003)(39860400002)(346002)(8676002)(5660300002)(82950400001)(55016002)(82960400001)(9686003)(64756008)(66556008)(6506007)(478600001)(86362001)(76116006)(7416002)(71200400001)(30864003)(83380400001)(66946007)(316002)(66446008)(66476007)(10290500003)(52536014)(33656002)(7696005)(54906003)(186003)(4326008)(2906002)(8990500004)(26005)(8936002)(110136005);
 DIR:OUT; SFP:1102; 
x-ms-exchange-antispam-messagedata: /uYZnLqfWr1Xw/8ykWl6mltnZQppm7oF0hvafXmI2ZZlm82/KGjtPGdVmYE39F313T1kaCE8beb8rRoTyknpAs84Vao5VnGsRjGSo7uINWbs/jyBI04VQPzTAYItHnzpgNt4wFJK/JCD8ovY5LKxr+uaQyq4HVfpgC0XFcY9leZwIrsXR3eTx79MwkYObjb/4+IMd4YIWOTJ7/vccWT6bDZTy1beT0rHZp23eJOXaIvsJZR6VH3/WyQu13AM/H8uDvQW8qUwfh/08oAIaMuMAVONjK76+5iGFBq6BPOufDfqZlAeoxyY2RTfaAUkDEljpuQ5lH4PD2gs0KspBJDiShr3MUchBwJNaJPQ7XsQCXUuNfkUpo1Z0Z+JmKg8NYNTNjhu/PNJNiw+pLfa2uG6ltAKfhtGhoxb9DTOaaprEdA+6vjRewsJJVVqqBWrDi2qjIwUcXNwrHMj1vXsZJoy35iQv/4ptgLRmSM9jLOyzqlYKrW0D6GWOSMRPk0jhwwCsTnhWg/EBtmC8NXFmnMDneGpB9IYxA4+esgJEiEZUC22RWBz+l/3D4z8Gm6HeAa7MYqdwGVj6t2iR2c4jnaxhzCXCEL56+Kluga44f11HjOhWe6OO4YCaRv+Y8XHzw9+9/y/oOJ9cjZ+QgCaJ8vJaCUW2YHPSURjdSp3ZsOgaeXqBl217iLVjVRww9/3M4C/+h78rBBxMoWU2ubhHIpLj5Zy+0iZI0ZjMBlzx0a7e1o=
MIME-Version: 1.0
X-OriginatorOrg: microsoft.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: MWHPR21MB1593.namprd21.prod.outlook.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 94446d1c-3140-4145-5162-08d8c9345a9f
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Feb 2021 17:43:16.7178 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 72f988bf-86f1-41af-91ab-2d7cd011db47
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: H2C6iG3LuVJFLzqAW6HI2leBdwm/282uJARCws+ypZsQbplqjG8oINgRSOL3jMxfZBTPPQcqn429UW5B2ykCuLLIK3EPczz+FtU4oIsmBF4=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR21MB1986
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

From: Wei Liu <wei.liu@kernel.org> Sent: Wednesday, February 3, 2021 7:05 AM
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
> v6:
> 1. Use u64 status.
> 2. Use vpset instead of bitmap.
> 3. Factor out hv_map_interrupt
> 4. Address other misc comments.
> 
> v4: Fix compilation issue when CONFIG_PCI_MSI is not set.
> v3: build irqdomain.o for 32bit as well.
> v2: This patch is simplified due to upstream changes.
> ---
>  arch/x86/hyperv/Makefile        |   2 +-
>  arch/x86/hyperv/hv_init.c       |   9 +
>  arch/x86/hyperv/irqdomain.c     | 362 ++++++++++++++++++++++++++++++++
>  arch/x86/include/asm/mshyperv.h |   2 +
>  4 files changed, 374 insertions(+), 1 deletion(-)
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
> index 11c5997691f4..894ce899f0cb 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -483,6 +483,15 @@ void __init hyperv_init(void)
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
> index 000000000000..117f17e8c88a
> --- /dev/null
> +++ b/arch/x86/hyperv/irqdomain.c
> @@ -0,0 +1,362 @@
> +// SPDX-License-Identifier: GPL-2.0
> +
> +/*
> + * for Linux to run as the root partition on Microsoft Hypervisor.

Nit:  Looks like the initial word "Irqdomain" got dropped from the above
comment line.  But don't respin just for this.

> + *
> + * Authors:
> + *  Sunil Muthuswamy <sunilmut@microsoft.com>
> + *  Wei Liu <wei.liu@kernel.org>
> + */
> +
> +#include <linux/pci.h>
> +#include <linux/irq.h>
> +#include <asm/mshyperv.h>
> +
> +static int hv_map_interrupt(union hv_device_id device_id, bool level,
> +		int cpu, int vector, struct hv_interrupt_entry *entry)
> +{
> +	struct hv_input_map_device_interrupt *input;
> +	struct hv_output_map_device_interrupt *output;
> +	struct hv_device_interrupt_descriptor *intr_desc;
> +	unsigned long flags;
> +	u64 status;
> +	cpumask_t mask = CPU_MASK_NONE;
> +	int nr_bank, var_size;
> +
> +	local_irq_save(flags);
> +
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> +
> +	intr_desc = &input->interrupt_descriptor;
> +	memset(input, 0, sizeof(*input));
> +	input->partition_id = hv_current_partition_id;
> +	input->device_id = device_id.as_uint64;
> +	intr_desc->interrupt_type = HV_X64_INTERRUPT_TYPE_FIXED;
> +	intr_desc->vector_count = 1;
> +	intr_desc->target.vector = vector;
> +
> +	if (level)
> +		intr_desc->trigger_mode = HV_INTERRUPT_TRIGGER_MODE_LEVEL;
> +	else
> +		intr_desc->trigger_mode = HV_INTERRUPT_TRIGGER_MODE_EDGE;
> +
> +	cpumask_set_cpu(cpu, &mask);
> +	intr_desc->target.vp_set.valid_bank_mask = 0;
> +	intr_desc->target.vp_set.format = HV_GENERIC_SET_SPARSE_4K;
> +	nr_bank = cpumask_to_vpset(&(intr_desc->target.vp_set), &mask);

There's a function get_cpu_mask() that returns a pointer to a cpumask with only
the specified cpu set in the mask.  It returns a const pointer to the correct entry
in a pre-allocated array of all such cpumasks, so it's a lot more efficient than
allocating and initializing a local cpumask instance on the stack.

> +	if (nr_bank < 0) {
> +		local_irq_restore(flags);
> +		pr_err("%s: unable to generate VP set\n", __func__);
> +		return EINVAL;
> +	}
> +	intr_desc->target.flags = HV_DEVICE_INTERRUPT_TARGET_PROCESSOR_SET;
> +
> +	/*
> +	 * var-sized hypercall, var-size starts after vp_mask (thus
> +	 * vp_set.format does not count, but vp_set.valid_bank_mask
> +	 * does).
> +	 */
> +	var_size = nr_bank + 1;
> +
> +	status = hv_do_rep_hypercall(HVCALL_MAP_DEVICE_INTERRUPT, 0, var_size,
> +			input, output);
> +	*entry = output->interrupt_entry;
> +
> +	local_irq_restore(flags);
> +
> +	if ((status & HV_HYPERCALL_RESULT_MASK) != HV_STATUS_SUCCESS)
> +		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
> +
> +	return status & HV_HYPERCALL_RESULT_MASK;
> +}
> +
> +static int hv_unmap_interrupt(u64 id, struct hv_interrupt_entry *old_entry)
> +{
> +	unsigned long flags;
> +	struct hv_input_unmap_device_interrupt *input;
> +	struct hv_interrupt_entry *intr_entry;
> +	u64 status;
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
> +	status = hv_do_hypercall(HVCALL_UNMAP_DEVICE_INTERRUPT, input, NULL);
> +	local_irq_restore(flags);
> +
> +	return status & HV_HYPERCALL_RESULT_MASK;
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
> +static int hv_map_msi_interrupt(struct pci_dev *dev, int cpu, int vector,
> +				struct hv_interrupt_entry *entry)
> +{
> +	union hv_device_id device_id = hv_build_pci_dev_id(dev);
> +
> +	return hv_map_interrupt(device_id, false, cpu, vector, entry);
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
> +	cpumask_t *affinity;
> +	int cpu;
> +	u64 status;
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
> +			pr_debug("%s: failed to unmap, status %lld", __func__, status);
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
> +	status = hv_map_msi_interrupt(dev, cpu, cfg->vector, &out_entry);
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
> +static int hv_unmap_msi_interrupt(struct pci_dev *dev, struct hv_interrupt_entry *old_entry)
> +{
> +	return hv_unmap_interrupt(hv_build_pci_dev_id(dev).as_uint64, old_entry);
> +}
> +
> +static void hv_teardown_msi_irq_common(struct pci_dev *dev, struct msi_desc *msidesc, int irq)
> +{
> +	u64 status;
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
> +		pr_err("%s: hypercall failed, status %lld\n", __func__, status);
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
> +				hv_teardown_msi_irq_common(pdev, entry, entry->irq + i);
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
> +		d = pci_msi_create_irq_domain(fn, &hv_pci_msi_domain_info, x86_vector_domain);
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
