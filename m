Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20687C48BDF
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 12:19:39 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BD19460FF0
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 12:19:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BD19460FF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 877BE607A2;
	Thu, 10 Jun 2021 12:19:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3pDPNh5bZ29I; Thu, 10 Jun 2021 12:19:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D279F6084C;
	Thu, 10 Jun 2021 12:19:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 980FEC000E;
	Thu, 10 Jun 2021 12:19:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E398C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 12:19:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 276346084C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 12:19:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wKv0OWOmFqOz
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 12:19:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C81D0607A2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 12:19:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623327572;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=QQOIii4bEWPToYyYDc/aW4Uv74xP+T34/eKJrmK7hmY=;
 b=fz81M8nJIw5M4+uh7Y94dNI175SzYpfr5CUsL1Su8kQgN8snB3f+FyvTN7tGikaWcToDE8
 CKpEonFC+32hgBSlJAuRwaQsHE0tR88Lj2mkfrUj1mYJJ0hdt1iMOU52VihvTvXAwOjEtd
 jEW6IGfX+Q3LtWl2226A+Pt86msi0h0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-qF2YjzOMOI-BxMXf7zBZeQ-1; Thu, 10 Jun 2021 08:19:31 -0400
X-MC-Unique: qF2YjzOMOI-BxMXf7zBZeQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 v2-20020a7bcb420000b0290146b609814dso2970141wmj.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 05:19:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=QQOIii4bEWPToYyYDc/aW4Uv74xP+T34/eKJrmK7hmY=;
 b=d7vwCI3ihWrtH3bAIdF5mvtiphNJIXTVWS6OrBcggG8QS5e7kjgP+YfSqCfGVnCrJk
 WPB+XcusF8LilVfDHElxMT1k+9Z48hsP0eBtkwQX7ZwJPsoezxbV+50ev0mq5NwrAs5E
 aV3NqzCEODsh8HWU6M8KLBZFq/VusIdKbDoOCoZArgC4EHgOX8KGvhYdqWisDhXfvXZi
 Cd2WWBLvDjDysDambeIbkjYNTYulCMHHyWnlKot/BzEEAWM0YKHzUsjpvMSJwlFA3IGT
 DGEBnGUPmT4M0CJNz2TRVywPoO9UNRHnk5tiHGY85rN43jobTP+CHdX4txxMeSiZjDeV
 C5vg==
X-Gm-Message-State: AOAM530nd66+ynO+jvi+plT/DH9kN+9B+rtqhtfDrylZ4gzAwuubWTjl
 EV5bvktxtEUgvG8M4YzNTbjGhPJXX2nmP9IzPROPAmIDyKLLLxUsqkIZOlkZpN/gh8m93Jan9QF
 oyEzRKd1DfdAME7qFEBTCbWdTkw0b0c4LwNMwA1TrMg==
X-Received: by 2002:adf:fa48:: with SMTP id y8mr5167075wrr.387.1623327570146; 
 Thu, 10 Jun 2021 05:19:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzorCpVig2PET3uYQ2dt4pHi981u72/cs4+c7t2xXbetFrlhopGZKbOJ/fs6m5pwgsV+hdQDQ==
X-Received: by 2002:adf:fa48:: with SMTP id y8mr5167055wrr.387.1623327569917; 
 Thu, 10 Jun 2021 05:19:29 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id s5sm1473758wrn.38.2021.06.10.05.19.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 10 Jun 2021 05:19:29 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Vineeth Pillai <viremana@linux.microsoft.com>, Nuno Das Neves
 <nunodasneves@linux.microsoft.com>, Wei Liu <wei.liu@kernel.org>, Sunil
 Muthuswamy <sunilmut@microsoft.com>, Michael Kelley
 <mikelley@microsoft.com>
Subject: Re: [PATCH 06/17] mshv: SynIC port and connection hypercalls
In-Reply-To: <3125953aae8e7950a6da4c311ef163b79d6fb6b3.1622654100.git.viremana@linux.microsoft.com>
References: <cover.1622654100.git.viremana@linux.microsoft.com>
 <3125953aae8e7950a6da4c311ef163b79d6fb6b3.1622654100.git.viremana@linux.microsoft.com>
Date: Thu, 10 Jun 2021 14:19:28 +0200
Message-ID: <87v96lykrz.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-hyperv@vger.kernel.org, Vineeth Pillai <viremana@linux.microsoft.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Vineeth Pillai <viremana@linux.microsoft.com> writes:

> Hyper-V enables inter-partition communication through the port and
> connection constructs. More details about ports and connections in
> TLFS chapter 11.
>
> Implement hypercalls related to ports and connections for enabling
> inter-partiion communication.
>
> Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
> ---
>  drivers/hv/hv_call.c                   | 161 +++++++++++++++++++++++++
>  drivers/hv/mshv.h                      |  12 ++
>  include/asm-generic/hyperv-tlfs.h      |  55 +++++++++
>  include/linux/hyperv.h                 |   9 --
>  include/uapi/asm-generic/hyperv-tlfs.h |  76 ++++++++++++
>  5 files changed, 304 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/hv/hv_call.c b/drivers/hv/hv_call.c
> index 025d4e2b892f..57db3a8ac94a 100644
> --- a/drivers/hv/hv_call.c
> +++ b/drivers/hv/hv_call.c
> @@ -742,3 +742,164 @@ int hv_call_translate_virtual_address(
>  	return hv_status_to_errno(status);
>  }
>  
> +
> +int
> +hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
> +		    u64 connection_partition_id,
> +		    struct hv_port_info *port_info,
> +		    u8 port_vtl, u8 min_connection_vtl, int node)
> +{
> +	struct hv_create_port *input;
> +	unsigned long flags;
> +	int ret = 0;
> +	int status;
> +
> +	do {
> +		local_irq_save(flags);
> +		input = (struct hv_create_port *)(*this_cpu_ptr(
> +				hyperv_pcpu_input_arg));
> +		memset(input, 0, sizeof(*input));
> +
> +		input->port_partition_id = port_partition_id;
> +		input->port_id = port_id;
> +		input->connection_partition_id = connection_partition_id;
> +		input->port_info = *port_info;
> +		input->port_vtl = port_vtl;
> +		input->min_connection_vtl = min_connection_vtl;
> +		input->proximity_domain_info =
> +			numa_node_to_proximity_domain_info(node);
> +		status = hv_do_hypercall(HVCALL_CREATE_PORT, input,
> +					NULL) & HV_HYPERCALL_RESULT_MASK;
> +		local_irq_restore(flags);
> +		if (status == HV_STATUS_SUCCESS)
> +			break;
> +
> +		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {
> +			pr_err("%s: %s\n",
> +			       __func__, hv_status_to_string(status));
> +			ret = -hv_status_to_errno(status);

In Nuno's "x86/hyperv: convert hyperv statuses to linux error codes"
patch, hv_status_to_errno() already returns negatives:

+int hv_status_to_errno(u64 hv_status)
+{
+       switch (hv_result(hv_status)) {
+       case HV_STATUS_SUCCESS:
+               return 0;
+       case HV_STATUS_INVALID_PARAMETER:
+       case HV_STATUS_UNKNOWN_PROPERTY:
+       case HV_STATUS_PROPERTY_VALUE_OUT_OF_RANGE:
+       case HV_STATUS_INVALID_VP_INDEX:
+       case HV_STATUS_INVALID_REGISTER_VALUE:
+       case HV_STATUS_INVALID_LP_INDEX:
+               return -EINVAL;
+       case HV_STATUS_ACCESS_DENIED:
+       case HV_STATUS_OPERATION_DENIED:
+               return -EACCES;
+       case HV_STATUS_NOT_ACKNOWLEDGED:
+       case HV_STATUS_INVALID_VP_STATE:
+       case HV_STATUS_INVALID_PARTITION_STATE:
+               return -EBADFD;
+       }
+       return -ENOTRECOVERABLE;
+}
+EXPORT_SYMBOL_GPL(hv_status_to_errno);
+

> +			break;
> +		}
> +		ret = hv_call_deposit_pages(NUMA_NO_NODE,
> +				port_partition_id, 1);
> +
> +	} while (!ret);
> +
> +	return ret;
> +}
> +
> +int
> +hv_call_delete_port(u64 port_partition_id, union hv_port_id port_id)
> +{
> +	union hv_delete_port input = { 0 };
> +	unsigned long flags;
> +	int status;
> +
> +	local_irq_save(flags);
> +	input.port_partition_id = port_partition_id;
> +	input.port_id = port_id;
> +	status = hv_do_fast_hypercall16(HVCALL_DELETE_PORT,
> +					input.as_uint64[0],
> +					input.as_uint64[1]) &
> +			HV_HYPERCALL_RESULT_MASK;
> +	local_irq_restore(flags);
> +
> +	if (status != HV_STATUS_SUCCESS) {
> +		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
> +		return -hv_status_to_errno(status);
> +	}
> +
> +	return 0;
> +}
> +
> +int
> +hv_call_connect_port(u64 port_partition_id, union hv_port_id port_id,
> +		     u64 connection_partition_id,
> +		     union hv_connection_id connection_id,
> +		     struct hv_connection_info *connection_info,
> +		     u8 connection_vtl, int node)
> +{
> +	struct hv_connect_port *input;
> +	unsigned long flags;
> +	int ret = 0, status;
> +
> +	do {
> +		local_irq_save(flags);
> +		input = (struct hv_connect_port *)(*this_cpu_ptr(
> +				hyperv_pcpu_input_arg));
> +		memset(input, 0, sizeof(*input));
> +		input->port_partition_id = port_partition_id;
> +		input->port_id = port_id;
> +		input->connection_partition_id = connection_partition_id;
> +		input->connection_id = connection_id;
> +		input->connection_info = *connection_info;
> +		input->connection_vtl = connection_vtl;
> +		input->proximity_domain_info =
> +			numa_node_to_proximity_domain_info(node);
> +		status = hv_do_hypercall(HVCALL_CONNECT_PORT, input,
> +					NULL) & HV_HYPERCALL_RESULT_MASK;
> +
> +		local_irq_restore(flags);
> +		if (status == HV_STATUS_SUCCESS)
> +			break;
> +
> +		if (status != HV_STATUS_INSUFFICIENT_MEMORY) {
> +			pr_err("%s: %s\n",
> +			       __func__, hv_status_to_string(status));
> +			ret = -hv_status_to_errno(status);
> +			break;
> +		}
> +		ret = hv_call_deposit_pages(NUMA_NO_NODE,
> +				connection_partition_id, 1);
> +	} while (!ret);
> +
> +	return ret;
> +}
> +
> +int
> +hv_call_disconnect_port(u64 connection_partition_id,
> +			union hv_connection_id connection_id)
> +{
> +	union hv_disconnect_port input = { 0 };
> +	unsigned long flags;
> +	int status;
> +
> +	local_irq_save(flags);
> +	input.connection_partition_id = connection_partition_id;
> +	input.connection_id = connection_id;
> +	input.is_doorbell = 1;
> +	status = hv_do_fast_hypercall16(HVCALL_DISCONNECT_PORT,
> +					input.as_uint64[0],
> +					input.as_uint64[1]) &
> +			HV_HYPERCALL_RESULT_MASK;
> +	local_irq_restore(flags);
> +
> +	if (status != HV_STATUS_SUCCESS) {
> +		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
> +		return -hv_status_to_errno(status);
> +	}
> +
> +	return 0;
> +}
> +
> +int
> +hv_call_notify_port_ring_empty(u32 sint_index)
> +{
> +	union hv_notify_port_ring_empty input = { 0 };
> +	unsigned long flags;
> +	int status;
> +
> +	local_irq_save(flags);
> +	input.sint_index = sint_index;
> +	status = hv_do_fast_hypercall8(HVCALL_NOTIFY_PORT_RING_EMPTY,
> +					input.as_uint64) &
> +			HV_HYPERCALL_RESULT_MASK;
> +	local_irq_restore(flags);
> +
> +	if (status != HV_STATUS_SUCCESS) {
> +		pr_err("%s: %s\n", __func__, hv_status_to_string(status));
> +		return -hv_status_to_errno(status);
> +	}
> +
> +	return 0;
> +}
> diff --git a/drivers/hv/mshv.h b/drivers/hv/mshv.h
> index 037291a0ad45..e16818e977b9 100644
> --- a/drivers/hv/mshv.h
> +++ b/drivers/hv/mshv.h
> @@ -117,4 +117,16 @@ int hv_call_translate_virtual_address(
>  		u64 *gpa,
>  		union hv_translate_gva_result *result);
>  
> +int hv_call_create_port(u64 port_partition_id, union hv_port_id port_id,
> +			u64 connection_partition_id, struct hv_port_info *port_info,
> +			u8 port_vtl, u8 min_connection_vtl, int node);
> +int hv_call_delete_port(u64 port_partition_id, union hv_port_id port_id);
> +int hv_call_connect_port(u64 port_partition_id, union hv_port_id port_id,
> +			 u64 connection_partition_id,
> +			 union hv_connection_id connection_id,
> +			 struct hv_connection_info *connection_info,
> +			 u8 connection_vtl, int node);
> +int hv_call_disconnect_port(u64 connection_partition_id,
> +			    union hv_connection_id connection_id);
> +int hv_call_notify_port_ring_empty(u32 sint_index);
>  #endif /* _MSHV_H */
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index f70391a3320f..42e0237b0da8 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -159,6 +159,8 @@ struct ms_hyperv_tsc_page {
>  #define HVCALL_GET_VP_REGISTERS			0x0050
>  #define HVCALL_SET_VP_REGISTERS			0x0051
>  #define HVCALL_TRANSLATE_VIRTUAL_ADDRESS	0x0052
> +#define HVCALL_DELETE_PORT			0x0058
> +#define HVCALL_DISCONNECT_PORT			0x005b
>  #define HVCALL_POST_MESSAGE			0x005c
>  #define HVCALL_SIGNAL_EVENT			0x005d
>  #define HVCALL_POST_DEBUG_DATA			0x0069
> @@ -168,7 +170,10 @@ struct ms_hyperv_tsc_page {
>  #define HVCALL_MAP_DEVICE_INTERRUPT		0x007c
>  #define HVCALL_UNMAP_DEVICE_INTERRUPT		0x007d
>  #define HVCALL_RETARGET_INTERRUPT		0x007e
> +#define HVCALL_NOTIFY_PORT_RING_EMPTY		0x008b
>  #define HVCALL_ASSERT_VIRTUAL_INTERRUPT		0x0094
> +#define HVCALL_CREATE_PORT			0x0095
> +#define HVCALL_CONNECT_PORT			0x0096
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_SPACE 0x00af
>  #define HVCALL_FLUSH_GUEST_PHYSICAL_ADDRESS_LIST 0x00b0
>  #define HVCALL_MAP_VP_STATE_PAGE			0x00e1
> @@ -949,4 +954,54 @@ struct hv_translate_virtual_address_out {
>  	u64 gpa_page;
>  } __packed;
>  
> +struct hv_create_port {
> +	u64 port_partition_id;
> +	union hv_port_id port_id;
> +	u8 port_vtl;
> +	u8 min_connection_vtl;
> +	u16 padding;
> +	u64 connection_partition_id;
> +	struct hv_port_info port_info;
> +	union hv_proximity_domain_info proximity_domain_info;
> +} __packed;
> +
> +union hv_delete_port {
> +	u64 as_uint64[2];
> +	struct {
> +		u64 port_partition_id;
> +		union hv_port_id port_id;
> +		u32 reserved;
> +	} __packed;
> +};
> +
> +union hv_notify_port_ring_empty {
> +	u64 as_uint64;
> +	struct {
> +		u32 sint_index;
> +		u32 reserved;
> +	} __packed;
> +};
> +
> +struct hv_connect_port {
> +	u64 connection_partition_id;
> +	union hv_connection_id connection_id;
> +	u8 connection_vtl;
> +	u8 rsvdz0;
> +	u16 rsvdz1;
> +	u64 port_partition_id;
> +	union hv_port_id port_id;
> +	u32 reserved2;
> +	struct hv_connection_info connection_info;
> +	union hv_proximity_domain_info proximity_domain_info;
> +} __packed;
> +
> +union hv_disconnect_port {
> +	u64 as_uint64[2];
> +	struct {
> +		u64 connection_partition_id;
> +		union hv_connection_id connection_id;
> +		u32 is_doorbell: 1;
> +		u32 reserved: 31;
> +	} __packed;
> +};
>  #endif
> diff --git a/include/linux/hyperv.h b/include/linux/hyperv.h
> index 2e859d2f9609..76ff26579622 100644
> --- a/include/linux/hyperv.h
> +++ b/include/linux/hyperv.h
> @@ -750,15 +750,6 @@ struct vmbus_close_msg {
>  	struct vmbus_channel_close_channel msg;
>  };
>  
> -/* Define connection identifier type. */
> -union hv_connection_id {
> -	u32 asu32;
> -	struct {
> -		u32 id:24;
> -		u32 reserved:8;
> -	} u;
> -};
> -
>  enum vmbus_device_type {
>  	HV_IDE = 0,
>  	HV_SCSI,
> diff --git a/include/uapi/asm-generic/hyperv-tlfs.h b/include/uapi/asm-generic/hyperv-tlfs.h
> index 388c4eb29212..2031115c6cce 100644
> --- a/include/uapi/asm-generic/hyperv-tlfs.h
> +++ b/include/uapi/asm-generic/hyperv-tlfs.h
> @@ -53,6 +53,25 @@ union hv_message_flags {
>  	} __packed;
>  };
>  
> +enum hv_port_type {
> +	HV_PORT_TYPE_MESSAGE = 1,
> +	HV_PORT_TYPE_EVENT   = 2,
> +	HV_PORT_TYPE_MONITOR = 3,
> +	HV_PORT_TYPE_DOORBELL = 4	// Root Partition only
> +};
> +
> +
> +/*
> + * Doorbell connection_info flags.
> + */
> +#define HV_DOORBELL_FLAG_TRIGGER_SIZE_MASK  0x00000007
> +#define HV_DOORBELL_FLAG_TRIGGER_SIZE_ANY   0x00000000
> +#define HV_DOORBELL_FLAG_TRIGGER_SIZE_BYTE  0x00000001
> +#define HV_DOORBELL_FLAG_TRIGGER_SIZE_WORD  0x00000002
> +#define HV_DOORBELL_FLAG_TRIGGER_SIZE_DWORD 0x00000003
> +#define HV_DOORBELL_FLAG_TRIGGER_SIZE_QWORD 0x00000004
> +#define HV_DOORBELL_FLAG_TRIGGER_ANY_VALUE  0x80000000
> +
>  /* Define port identifier type. */
>  union hv_port_id {
>  	__u32 asu32;
> @@ -62,6 +81,63 @@ union hv_port_id {
>  	} __packed u;
>  };
>  
> +struct hv_port_info {
> +	enum hv_port_type port_type;
> +	__u32 padding;
> +	union {
> +		struct {
> +			__u32 target_sint;
> +			__u32 target_vp;
> +			__u64 rsvdz;
> +		} message_port_info;
> +		struct {
> +			__u32 target_sint;
> +			__u32 target_vp;
> +			__u16 base_flag_number;
> +			__u16 flag_count;
> +			__u32 rsvdz;
> +		} event_port_info;
> +		struct {
> +			__u64 monitor_address;
> +			__u64 rsvdz;
> +		} monitor_port_info;
> +		struct {
> +			__u32 target_sint;
> +			__u32 target_vp;
> +			__u64 rsvdz;
> +		} doorbell_port_info;
> +	};
> +};
> +
> +union hv_connection_id {
> +	__u32 asu32;
> +	struct {
> +		__u32 id:24;
> +		__u32 reserved:8;
> +	} u;
> +};
> +
> +struct hv_connection_info {
> +	enum hv_port_type port_type;
> +	__u32 padding;
> +	union {
> +		struct {
> +			__u64 rsvdz;
> +		} message_connection_info;
> +		struct {
> +			__u64 rsvdz;
> +		} event_connection_info;
> +		struct {
> +			__u64 monitor_address;
> +		} monitor_connection_info;
> +		struct {
> +			__u64 gpa;
> +			__u64 trigger_value;
> +			__u64 flags;
> +		} doorbell_connection_info;
> +	};
> +};
> +
>  /* Define synthetic interrupt controller message header. */
>  struct hv_message_header {
>  	__u32 message_type;

-- 
Vitaly

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
