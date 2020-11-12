Return-Path: <SRS0=8i8N=ES=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DF6DC5519F
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 16:56:53 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8BE0206FA
	for <virtualization@archiver.kernel.org>; Thu, 12 Nov 2020 16:56:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JtpY/2yz"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8BE0206FA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 843938774E;
	Thu, 12 Nov 2020 16:56:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HfUALzqnH+JL; Thu, 12 Nov 2020 16:56:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 85A5C875EE;
	Thu, 12 Nov 2020 16:56:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5144EC0889;
	Thu, 12 Nov 2020 16:56:51 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DC837C016F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 16:56:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id CE091875FF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 16:56:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OwaUc9RMqobh
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 16:56:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id D6469875EE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 16:56:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605200208;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wYP9Gq+ts7pzjErccComK+H3r9U6J/KV+gx7+NzTNxw=;
 b=JtpY/2yz4ItydXFkdlRVWzzBRK013QiZ8rR7UN+mz2N1ofDfpVfxO7iYbHemhN5ELNCJSE
 lyfCQ/U3Q3j90Gkw5wyQvWXUiTaVS7Z+A7xtyfv7KjtpMCP4fNnVTGpl8JYyJ9SKzgMYt+
 PAVWy8TuYjwn1InP3nhumUrHXQUiqcM=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-nx3RDfbFPE-_XCj3kE7Tgg-1; Thu, 12 Nov 2020 11:56:46 -0500
X-MC-Unique: nx3RDfbFPE-_XCj3kE7Tgg-1
Received: by mail-wm1-f70.google.com with SMTP id j62so830235wma.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Nov 2020 08:56:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=wYP9Gq+ts7pzjErccComK+H3r9U6J/KV+gx7+NzTNxw=;
 b=AiOHnsekPFnEahRMWNLIyjpNb4acJtimvLeOwkAxfMMFKswKlSXQly7Yq6Cx8SkOFo
 bjc4HlHEplZLO1DAIa85nLKll5s1k0PtCBSWVb3gGc3oJqPo++BDaVQLFInUnNGlb+I1
 F4fmQ88VQTanLdyqmGWEvzIC3NpCvFyT1vp/24XMdgmBW1hIhqpDgawIWfEmMozrtCT2
 Jo1deg15bMxstPNeCwIc5Z4eMVAS38LOCCY/xLKEHDc9znyUCaLOfT00Q7FJG6Z7AxLf
 zPJ+zx3eLfgihSmb1osreMqFIw5UQLSSGBUsnfQbHQcXcgEiwpL+cZot73Ww3hsLxaO5
 1/EA==
X-Gm-Message-State: AOAM533Zj6WsxIeCjLfgAIx0XYcnbWRoDHyRJ+d6q2pJxh6sb7HAYdao
 v1oBErs1OIKoIRypP9clsqjcEDnQ0rmoWMecTEqFQN103XJ6QXZFGruBcXPMtVNK3AHzto+HDjl
 W6b3lJYnu0FmZTxBn4kVRPEaPluEOlqqbITPBXrwpNQ==
X-Received: by 2002:adf:c443:: with SMTP id a3mr510010wrg.249.1605200203895;
 Thu, 12 Nov 2020 08:56:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx6zhpK0qox59X6e8JQyr5bppOI0Wy0lYHwipyzYIWWWvgR2UM9kbCVk5xgd/kpNhNWxHp2QQ==
X-Received: by 2002:adf:c443:: with SMTP id a3mr509971wrg.249.1605200203625;
 Thu, 12 Nov 2020 08:56:43 -0800 (PST)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id g131sm7418395wma.35.2020.11.12.08.56.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 12 Nov 2020 08:56:42 -0800 (PST)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Wei Liu <wei.liu@kernel.org>, Linux on Hyper-V List
 <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH v2 17/17] x86/hyperv: handle IO-APIC when running as root
In-Reply-To: <20201105165814.29233-18-wei.liu@kernel.org>
References: <20201105165814.29233-1-wei.liu@kernel.org>
 <20201105165814.29233-18-wei.liu@kernel.org>
Date: Thu, 12 Nov 2020 17:56:41 +0100
Message-ID: <87v9eawm2e.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Haiyang Zhang <haiyangz@microsoft.com>,
 "maintainer:X86 ARCHITECTURE \(32-BIT AND 64-BIT\)" <x86@kernel.org>,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Michael Kelley <mikelley@microsoft.com>, Ingo Molnar <mingo@redhat.com>,
 Borislav Petkov <bp@alien8.de>, "H. Peter Anvin" <hpa@zytor.com>,
 Nuno Das Neves <nunodasneves@linux.microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 virtualization@lists.linux-foundation.org,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Wei Liu <wei.liu@kernel.org> writes:

> Just like MSI/MSI-X, IO-APIC interrupts are remapped by Microsoft
> Hypervisor when Linux runs as the root partition. Implement an IRQ chip
> to handle mapping and unmapping of IO-APIC interrupts.
>
> Use custom functions for mapping and unmapping ACPI GSIs. They will
> issue Microsoft Hypervisor specific hypercalls on top of the native
> routines.
>
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  arch/x86/hyperv/hv_init.c   |  13 +++
>  arch/x86/hyperv/irqdomain.c | 226 ++++++++++++++++++++++++++++++++++++
>  2 files changed, 239 insertions(+)
>
> diff --git a/arch/x86/hyperv/hv_init.c b/arch/x86/hyperv/hv_init.c
> index a46b817b5b2a..2c2189832da7 100644
> --- a/arch/x86/hyperv/hv_init.c
> +++ b/arch/x86/hyperv/hv_init.c
> @@ -267,10 +267,23 @@ static int hv_cpu_die(unsigned int cpu)
>  	return 0;
>  }
>  
> +int hv_acpi_register_gsi(struct device *dev, u32 gsi, int trigger, int polarity);
> +void hv_acpi_unregister_gsi(u32 gsi);
> +
> +extern int (*native_acpi_register_gsi)(struct device *dev, u32 gsi, int trigger, int polarity);
> +extern void (*native_acpi_unregister_gsi)(u32 gsi);
> +
>  static int __init hv_pci_init(void)
>  {
>  	int gen2vm = efi_enabled(EFI_BOOT);
>  
> +	if (hv_root_partition) {
> +		native_acpi_register_gsi = __acpi_register_gsi;
> +		native_acpi_unregister_gsi = __acpi_unregister_gsi;
> +		__acpi_register_gsi = hv_acpi_register_gsi;
> +		__acpi_unregister_gsi = hv_acpi_unregister_gsi;
> +	}
> +
>  	/*
>  	 * For Generation-2 VM, we exit from pci_arch_init() by returning 0.
>  	 * The purpose is to suppress the harmless warning:
> diff --git a/arch/x86/hyperv/irqdomain.c b/arch/x86/hyperv/irqdomain.c
> index 80109e3cbf8f..ae9a728589a4 100644
> --- a/arch/x86/hyperv/irqdomain.c
> +++ b/arch/x86/hyperv/irqdomain.c
> @@ -9,6 +9,8 @@
>  #include <linux/pci.h>
>  #include <linux/irq.h>
>  #include <asm/mshyperv.h>
> +#include <asm/apic.h>
> +#include <asm/io_apic.h>
>  
>  struct rid_data {
>  	struct pci_dev *bridge;
> @@ -328,3 +330,227 @@ struct irq_domain * __init hv_create_pci_msi_domain(void)
>  	return d;
>  }
>  
> +/* Copied from io_apic.c */
> +union entry_union {
> +	struct { u32 w1, w2; };
> +	struct IO_APIC_route_entry entry;
> +};
> +
> +static int hv_unmap_ioapic_interrupt(int gsi)
> +{
> +	union hv_device_id device_id;
> +	int ioapic, ioapic_id;
> +	u8 ioapic_pin;
> +	struct IO_APIC_route_entry ire;
> +	union entry_union eu;
> +	struct hv_interrupt_entry entry;
> +
> +	ioapic = mp_find_ioapic(gsi);
> +	ioapic_pin = mp_find_ioapic_pin(ioapic, gsi);
> +	ioapic_id = mpc_ioapic_id(ioapic);
> +	ire = ioapic_read_entry(ioapic, ioapic_pin);
> +
> +	eu.entry = ire;
> +
> +	/*
> +	 * Polarity may have been set by us, but Hyper-V expects the exact same
> +	 * entry. See the mapping routine.
> +	 */
> +	eu.entry.polarity = 0;
> +
> +	memset(&entry, 0, sizeof(entry));
> +	entry.source = HV_INTERRUPT_SOURCE_IOAPIC;
> +	entry.ioapic_rte.low_uint32 = eu.w1;
> +	entry.ioapic_rte.high_uint32 = eu.w2;
> +
> +	device_id.as_uint64 = 0;
> +	device_id.device_type = HV_DEVICE_TYPE_IOAPIC;
> +	device_id.ioapic.ioapic_id = (u8)ioapic_id;
> +
> +	return hv_unmap_interrupt(device_id.as_uint64, &entry) & HV_HYPERCALL_RESULT_MASK;
> +}
> +
> +static int hv_map_ioapic_interrupt(int ioapic_id, int trigger, int vcpu, int vector,
> +		struct hv_interrupt_entry *out_entry)
> +{
> +	unsigned long flags;
> +	struct hv_input_map_device_interrupt *input;
> +	struct hv_output_map_device_interrupt *output;
> +	union hv_device_id device_id;
> +	struct hv_device_interrupt_descriptor *intr_desc;
> +	u16 status;
> +
> +	device_id.as_uint64 = 0;
> +	device_id.device_type = HV_DEVICE_TYPE_IOAPIC;
> +	device_id.ioapic.ioapic_id = (u8)ioapic_id;
> +
> +	local_irq_save(flags);
> +	input = *this_cpu_ptr(hyperv_pcpu_input_arg);
> +	output = *this_cpu_ptr(hyperv_pcpu_output_arg);
> +	memset(input, 0, sizeof(*input));
> +	intr_desc = &input->interrupt_descriptor;
> +	input->partition_id = hv_current_partition_id;
> +	input->device_id = device_id.as_uint64;
> +	intr_desc->interrupt_type = HV_X64_INTERRUPT_TYPE_FIXED;
> +	intr_desc->target.vector = vector;
> +	intr_desc->vector_count = 1;
> +
> +	if (trigger)
> +		intr_desc->trigger_mode = HV_INTERRUPT_TRIGGER_MODE_LEVEL;
> +	else
> +		intr_desc->trigger_mode = HV_INTERRUPT_TRIGGER_MODE_EDGE;
> +
> +	__set_bit(vcpu, (unsigned long *)&intr_desc->target.vp_mask);
> +
> +	status = hv_do_rep_hypercall(HVCALL_MAP_DEVICE_INTERRUPT, 0, 0, input, output) &
> +			 HV_HYPERCALL_RESULT_MASK;
> +	local_irq_restore(flags);
> +
> +	*out_entry = output->interrupt_entry;
> +
> +	return status;
> +}
> +
> +static unsigned int hv_ioapic_startup_irq(struct irq_data *data)
> +{
> +	u16 status;
> +	struct IO_APIC_route_entry ire;
> +	u32 vector;
> +	struct irq_cfg *cfg;
> +	int ioapic;
> +	u8 ioapic_pin;
> +	int ioapic_id;
> +	int gsi;
> +	union entry_union eu;
> +	struct cpumask *affinity;
> +	int cpu, vcpu;
> +	struct hv_interrupt_entry entry;
> +	struct mp_chip_data *mp_data = data->chip_data;
> +
> +	gsi = data->irq;
> +	cfg = irqd_cfg(data);
> +	affinity = irq_data_get_effective_affinity_mask(data);
> +	cpu = cpumask_first_and(affinity, cpu_online_mask);
> +	vcpu = hv_cpu_number_to_vp_number(cpu);
> +
> +	vector = cfg->vector;
> +
> +	ioapic = mp_find_ioapic(gsi);
> +	ioapic_pin = mp_find_ioapic_pin(ioapic, gsi);
> +	ioapic_id = mpc_ioapic_id(ioapic);
> +	ire = ioapic_read_entry(ioapic, ioapic_pin);
> +
> +	/*
> +	 * Always try unmapping. We do not have visibility into which whether
> +	 * an IO-APIC has been mapped or not. We can't use chip_data because it
> +	 * already points to mp_data.
> +	 *
> +	 * We don't use retarget interrupt hypercalls here because Hyper-V
> +	 * doens't allow root to change the vector or specify VPs outside of
> +	 * the set that is initially used during mapping.
> +	 */
> +	status = hv_unmap_ioapic_interrupt(gsi);
> +
> +	if (!(status == HV_STATUS_SUCCESS || status == HV_STATUS_INVALID_PARAMETER)) {
> +		pr_debug("%s: unexpected unmap status %d\n", __func__, status);
> +		return -1;

Nit: the function returns 'unsigned int' but I see other 'irq_startup'
routines return negative values too, however, they tend to returd
'-ESOMETHING' so maybe -EFAULT here?

> +	}
> +
> +	status = hv_map_ioapic_interrupt(ioapic_id, ire.trigger, vcpu, vector, &entry);
> +
> +	if (status != HV_STATUS_SUCCESS) {
> +		pr_err("%s: map hypercall failed, status %d\n", __func__, status);
> +		return -1;

and here.

> +	}
> +
> +	/* Update the entry in mp_chip_data. It is used in other places. */
> +	mp_data->entry = *(struct IO_APIC_route_entry *)&entry.ioapic_rte;
> +
> +	/* Sync polarity -- Hyper-V's returned polarity is always 0... */
> +	mp_data->entry.polarity = ire.polarity;
> +
> +	eu.w1 = entry.ioapic_rte.low_uint32;
> +	eu.w2 = entry.ioapic_rte.high_uint32;
> +	ioapic_write_entry(ioapic, ioapic_pin, eu.entry);
> +
> +	return 0;
> +}
> +
> +static void hv_ioapic_mask_irq(struct irq_data *data)
> +{
> +	mask_ioapic_irq(data);
> +}
> +
> +static void hv_ioapic_unmask_irq(struct irq_data *data)
> +{
> +	unmask_ioapic_irq(data);
> +}
> +
> +static int hv_ioapic_set_affinity(struct irq_data *data,
> +			       const struct cpumask *mask, bool force)
> +{
> +	/*
> +	 * We only update the affinity mask here. Programming the hardware is
> +	 * done in irq_startup.
> +	 */
> +	return ioapic_set_affinity(data, mask, force);
> +}
> +
> +void hv_ioapic_ack_level(struct irq_data *irq_data)
> +{
> +	/*
> +	 * Per email exchange with Hyper-V team, all is needed is write to
> +	 * LAPIC's EOI register. They don't support directed EOI to IO-APIC.
> +	 * Hyper-V handles it for us.
> +	 */
> +	apic_ack_irq(irq_data);
> +}
> +
> +struct irq_chip hv_ioapic_chip __read_mostly = {
> +	.name			= "HV-IO-APIC",
> +	.irq_startup		= hv_ioapic_startup_irq,
> +	.irq_mask		= hv_ioapic_mask_irq,
> +	.irq_unmask		= hv_ioapic_unmask_irq,
> +	.irq_ack		= irq_chip_ack_parent,
> +	.irq_eoi		= hv_ioapic_ack_level,
> +	.irq_set_affinity	= hv_ioapic_set_affinity,
> +	.irq_retrigger		= irq_chip_retrigger_hierarchy,
> +	.irq_get_irqchip_state	= ioapic_irq_get_chip_state,
> +	.flags			= IRQCHIP_SKIP_SET_WAKE,
> +};
> +
> +
> +int (*native_acpi_register_gsi)(struct device *dev, u32 gsi, int trigger, int polarity);
> +void (*native_acpi_unregister_gsi)(u32 gsi);
> +
> +int hv_acpi_register_gsi(struct device *dev, u32 gsi, int trigger, int polarity)
> +{
> +	int irq = gsi;
> +
> +#ifdef CONFIG_X86_IO_APIC
> +	irq = native_acpi_register_gsi(dev, gsi, trigger, polarity);
> +	if (irq < 0) {
> +		pr_err("native_acpi_register_gsi failed %d\n", irq);
> +		return irq;
> +	}
> +
> +	if (trigger) {
> +		irq_set_status_flags(irq, IRQ_LEVEL);
> +		irq_set_chip_and_handler_name(irq, &hv_ioapic_chip,
> +			handle_fasteoi_irq, "ioapic-fasteoi");
> +	} else {
> +		irq_clear_status_flags(irq, IRQ_LEVEL);
> +		irq_set_chip_and_handler_name(irq, &hv_ioapic_chip,
> +			handle_edge_irq, "ioapic-edge");
> +	}
> +#endif
> +	return irq;
> +}
> +
> +void hv_acpi_unregister_gsi(u32 gsi)
> +{
> +#ifdef CONFIG_X86_IO_APIC
> +	(void)hv_unmap_ioapic_interrupt(gsi);
> +	native_acpi_unregister_gsi(gsi);
> +#endif
> +}

-- 
Vitaly

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
