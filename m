Return-Path: <SRS0=Zxjt=CY=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B55CDC43461
	for <virtualization@archiver.kernel.org>; Tue, 15 Sep 2020 11:17:12 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 47F0B20872
	for <virtualization@archiver.kernel.org>; Tue, 15 Sep 2020 11:17:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fshi2p0v"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 47F0B20872
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D715E20022;
	Tue, 15 Sep 2020 11:17:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KUYuvkdk80MX; Tue, 15 Sep 2020 11:17:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 908C1203F7;
	Tue, 15 Sep 2020 11:17:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76ECEC0859;
	Tue, 15 Sep 2020 11:17:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FC24C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 11:17:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 36BE7203F7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 11:17:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3FS3e2-vSYBK
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 11:17:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by silver.osuosl.org (Postfix) with ESMTPS id 5D3DA20022
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 11:17:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600168626;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=woQDJzqYhg7fywcaDyz/edYf2Kcu8mkUs5XrNK4Tz2w=;
 b=fshi2p0vv7emc7NJMpGolyIc3uY4KC/63LFyxa6GLPW6XvfuN1xGL+kvbpJVQu1izwhnI3
 qvjPSpV7LGR4De0iqRTvYvNq8w0b5GdCOk2iFCSFkwZbKWtbV5A2qqZhrdmyX9sErO8Smh
 N42h6u79huRto2JhskypFwROH3VinMs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-239-q0v7VcBKNiO137cfeVJw8A-1; Tue, 15 Sep 2020 07:17:02 -0400
X-MC-Unique: q0v7VcBKNiO137cfeVJw8A-1
Received: by mail-wr1-f71.google.com with SMTP id y3so1089256wrl.21
 for <virtualization@lists.linux-foundation.org>;
 Tue, 15 Sep 2020 04:17:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=woQDJzqYhg7fywcaDyz/edYf2Kcu8mkUs5XrNK4Tz2w=;
 b=rGEczpbXf7YXdKlb+MEJdN31s+dFTG1kW3qR+HJg5pZox/Zlucg4NfYHr2FdT9bn9s
 2/9QBuL/QqOjejhtURtktE3qoMcvVoqh0Lj6C5rajAdeKEMl3F+64Ru0ysEyuxQtPp80
 rxJWfqMTge4kojTOkk3shsrZFdk2WRpFCCgNpgacQPIrqGYLWK3tbvoARd5Cgn7hKTbE
 jfFFmdT+GI+AYaYx+k0Z6HgHZtvDm2yecGYj2hi6S6DHg+XV4tkPadIAfOflh3dKoNzh
 +DjvzoFgPjYWofykiMlEUX+sgl5Rl+aIHCP80JVaojaYqn52MRk65eY8e7A59EwRqIRF
 GpDQ==
X-Gm-Message-State: AOAM532K/EutjdszwaqqiBFXdoLyaUfDsy/2Tm/kte6ZZygpZ+u6EXyb
 BoYCj2K5Tz0eCedLS7N9FnSWUa4kerp6t8D65CiRBG4pnVusu+tMYhUJ+DaalKaTMEEBbN5wdaF
 GT3in09gNYH7pyqjp/b8dnn89m/ccM3bs8y8IZgLayQ==
X-Received: by 2002:adf:e58b:: with SMTP id l11mr22315904wrm.210.1600168621432; 
 Tue, 15 Sep 2020 04:17:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy1+xzFGs26g7aJCk9FSSsiFCpkMroz/Chp7v9K3IdFtvipyWWejeB5dTWSLfG+tS8/srkFkQ==
X-Received: by 2002:adf:e58b:: with SMTP id l11mr22315875wrm.210.1600168621197; 
 Tue, 15 Sep 2020 04:17:01 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id w21sm25728597wmk.34.2020.09.15.04.17.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2020 04:17:00 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: Wei Liu <wei.liu@kernel.org>,
 Linux on Hyper-V List <linux-hyperv@vger.kernel.org>
Subject: Re: [PATCH RFC v1 13/18] asm-generic/hyperv: introduce hv_device_id
 and auxiliary structures
In-Reply-To: <20200914115928.83184-5-wei.liu@kernel.org>
References: <20200914112802.80611-1-wei.liu@kernel.org>
 <20200914115928.83184-5-wei.liu@kernel.org>
Date: Tue, 15 Sep 2020 13:16:59 +0200
Message-ID: <87k0wvjnmc.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0.002
X-Mimecast-Originator: redhat.com
Cc: "open list:GENERIC INCLUDE/ASM HEADER FILES" <linux-arch@vger.kernel.org>,
 Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Arnd Bergmann <arnd@arndb.de>, Haiyang Zhang <haiyangz@microsoft.com>,
 virtualization@lists.linux-foundation.org,
 Linux Kernel List <linux-kernel@vger.kernel.org>,
 Nuno Das Neves <nudasnev@microsoft.com>,
 Sunil Muthuswamy <sunilmut@microsoft.com>,
 Michael Kelley <mikelley@microsoft.com>,
 Vineeth Pillai <viremana@linux.microsoft.com>
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

> We will need to identify the device we want Microsoft Hypervisor to
> manipulate.  Introduce the data structures for that purpose.
>
> They will be used in a later patch.
>
> Signed-off-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Co-Developed-by: Sunil Muthuswamy <sunilmut@microsoft.com>
> Signed-off-by: Wei Liu <wei.liu@kernel.org>
> ---
>  include/asm-generic/hyperv-tlfs.h | 79 +++++++++++++++++++++++++++++++
>  1 file changed, 79 insertions(+)
>
> diff --git a/include/asm-generic/hyperv-tlfs.h b/include/asm-generic/hyperv-tlfs.h
> index 83945ada5a50..faf892ce152d 100644
> --- a/include/asm-generic/hyperv-tlfs.h
> +++ b/include/asm-generic/hyperv-tlfs.h
> @@ -612,4 +612,83 @@ struct hv_set_vp_registers_input {
>  	} element[];
>  } __packed;
>  
> +enum hv_device_type {
> +	HV_DEVICE_TYPE_LOGICAL = 0,
> +	HV_DEVICE_TYPE_PCI = 1,
> +	HV_DEVICE_TYPE_IOAPIC = 2,
> +	HV_DEVICE_TYPE_ACPI = 3,
> +};
> +
> +typedef u16 hv_pci_rid;
> +typedef u16 hv_pci_segment;
> +typedef u64 hv_logical_device_id;
> +union hv_pci_bdf {
> +	u16 as_uint16;
> +
> +	struct {
> +		u8 function:3;
> +		u8 device:5;
> +		u8 bus;
> +	};
> +} __packed;
> +
> +union hv_pci_bus_range {
> +	u16 as_uint16;
> +
> +	struct {
> +		u8 subordinate_bus;
> +		u8 secondary_bus;
> +	};
> +} __packed;
> +
> +union hv_device_id {
> +	u64 as_uint64;
> +
> +	struct {
> +		u64 :62;
> +		u64 device_type:2;
> +	};
> +
> +	// HV_DEVICE_TYPE_LOGICAL

Nit: please no '//' comments.

> +	struct {
> +		u64 id:62;
> +		u64 device_type:2;
> +	} logical;
> +
> +	// HV_DEVICE_TYPE_PCI
> +	struct {
> +		union {
> +			hv_pci_rid rid;
> +			union hv_pci_bdf bdf;
> +		};
> +
> +		hv_pci_segment segment;
> +		union hv_pci_bus_range shadow_bus_range;
> +
> +		u16 phantom_function_bits:2;
> +		u16 source_shadow:1;
> +
> +		u16 rsvdz0:11;
> +		u16 device_type:2;
> +	} pci;
> +
> +	// HV_DEVICE_TYPE_IOAPIC
> +	struct {
> +		u8 ioapic_id;
> +		u8 rsvdz0;
> +		u16 rsvdz1;
> +		u16 rsvdz2;
> +
> +		u16 rsvdz3:14;
> +		u16 device_type:2;
> +	} ioapic;
> +
> +	// HV_DEVICE_TYPE_ACPI
> +	struct {
> +		u32 input_mapping_base;
> +		u32 input_mapping_count:30;
> +		u32 device_type:2;
> +	} acpi;
> +} __packed;
> +
>  #endif

-- 
Vitaly

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
