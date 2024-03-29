Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A48C1420A3
	for <virtualization@lists.linux.dev>; Fri, 29 Mar 2024 13:19:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711718391; cv=none; b=ImBWTDbbmy+0nSe04aD8MN4ofMhKqhPqglz7q3Y+bR7NBN0jHMcfw/n3kiTI90caDxTldTAdEcD4m5wYZPshTjbphoVm/eP4cgrQipHU75GLwaXf6bzX/kCmVyOj3ZDdZzjrB2jIF/9elojsfF0GRlDc7hmzolT0jggs3n8yt1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711718391; c=relaxed/simple;
	bh=4zwBU2kn9BB4ZFJ8lWhfiXJTkHP6/4UIoSMUtfo4AZI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=kLZS15PqDqnRxu7klHjuJZuHakS2wjha1LelnWRAzF8thIk6c276lCw5lMJaFc6rrNkuuxiBpGblJnEA7HFOg9w5ZLoCVVgtKBzyIrvaK09ekU6XNpT6Er18zjZRHEvQULbHZeS6mdzsDs2vb+QzZ28jC69t8q5mSA4FBrufK4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=JE8Rnu41; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JE8Rnu41"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711718388;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=VJpKLUltxIUfVqHLS7sLgRrzqVOgRF5L+qleEhigOuA=;
	b=JE8Rnu4115qXCI/unZcQD20udKv4Eq92CpYg5iKLZn8GXKrHZHh1rBv650sUy6/vK73xnq
	QfG9dIuebdJyvQjchnsA67xKgzlU8pRWxGwl8eR2tobnkzX8d/axttHXYMAwUqcYAkw/n9
	jRZZcJe9PbdP6HR5LspeLNYI/A/45WM=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-198-EBsSKneLNBKuVF5EyrC9yQ-1; Fri, 29 Mar 2024 09:19:46 -0400
X-MC-Unique: EBsSKneLNBKuVF5EyrC9yQ-1
Received: by mail-lj1-f200.google.com with SMTP id 38308e7fff4ca-2d70f0791b4so12405551fa.3
        for <virtualization@lists.linux.dev>; Fri, 29 Mar 2024 06:19:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711718385; x=1712323185;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VJpKLUltxIUfVqHLS7sLgRrzqVOgRF5L+qleEhigOuA=;
        b=DakgvhV//HgWAd2Bqde0KfCCy1rN6DRQkP3zTfkLOWukq6nHNbwv2fUP1nPre0vtda
         4Yb0UnlwBuuMR1zsY0AiaiZqjNNkLAbhs5+LQcrZHtrdIRq6zWP4t0AqSeO4MBC+/s0D
         Zgt6Nlg08vo+dPu/rr7AQmNW7ac1/eWRorwa67+i87i6lsF8QBNxrRVNJaDgk6AyAfvw
         GotrW1DitPeLkuRaFBGBxJqYYJv+mmhVpPJW7cGeuks5Mqn6fAa2yMa/F5PDjCtRUtTp
         Vr6H5viJ2nglGisXOSkH8v+hcqjJB6uFUj01H+jHOv00GE65/Lw2mnd9xU4pHI073VkE
         Vfxg==
X-Gm-Message-State: AOJu0Yy4WoyY9vodTG0rvQCbGFidu5shQjFBHem4k94nCeADKyEYB7Vu
	292EHh/kv2F3zQZIcXlwlXBCNyYpzNY3PdIjtYAP53MCw7Zo+qcsrLBTcsXpSAuaUBmILcsoEGg
	YDIUoqZBhjTqO6X7ATAtLNgZHXmAugV6H4Pzfk/UtRV+4HiGTejZDVkS7VaBmXgfx
X-Received: by 2002:a2e:b904:0:b0:2d3:1bd0:6bcf with SMTP id b4-20020a2eb904000000b002d31bd06bcfmr1234633ljb.8.1711718385367;
        Fri, 29 Mar 2024 06:19:45 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE6NYMErHKwsp6fYNQPucYrrsoxB/ae/vZoWkcPzHcqu9rWWEc9uUu+tTGEC7htpSsLBJrx+A==
X-Received: by 2002:a2e:b904:0:b0:2d3:1bd0:6bcf with SMTP id b4-20020a2eb904000000b002d31bd06bcfmr1234620ljb.8.1711718385001;
        Fri, 29 Mar 2024 06:19:45 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-25-33.business.telecomitalia.it. [87.12.25.33])
        by smtp.gmail.com with ESMTPSA id v6-20020a05600c444600b0041488e78fc8sm8636466wmn.36.2024.03.29.06.19.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Mar 2024 06:19:44 -0700 (PDT)
Date: Fri, 29 Mar 2024 14:19:40 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Srujana Challa <schalla@marvell.com>
Cc: "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>, 
	"mst@redhat.com" <mst@redhat.com>, "jasowang@redhat.com" <jasowang@redhat.com>, 
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>, Vamsi Krishna Attunuru <vattunuru@marvell.com>, 
	Shijith Thotton <sthotton@marvell.com>, Nithin Kumar Dabilpuram <ndabilpuram@marvell.com>, 
	Jerin Jacob <jerinj@marvell.com>
Subject: Re: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marvell
 OCTEON DPU devices
Message-ID: <zngyydrkdaeufu3d4r4mfjijxua4ivtxy6aalctvyge2xhv623@kzcgysxs2lbg>
References: <20240327112136.2897479-1-schalla@marvell.com>
 <zuo2dwyz3rzwotgjnml2n5scjjwc563hh6cj5mtz6qieh6sgy7@kxluctu2tayv>
 <DS0PR18MB5368EA931E6FE873DD94A50BA03A2@DS0PR18MB5368.namprd18.prod.outlook.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <DS0PR18MB5368EA931E6FE873DD94A50BA03A2@DS0PR18MB5368.namprd18.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Fri, Mar 29, 2024 at 01:02:28PM +0000, Srujana Challa wrote:
>> Subject: [EXTERNAL] Re: [PATCH] virtio: vdpa: vDPA driver for Marvell OCTEON
>> DPU devices
>>
>> Prioritize security for external emails: Confirm sender and content safety
>> before clicking links or opening attachments
>>
>> ----------------------------------------------------------------------
>> On Wed, Mar 27, 2024 at 04:51:36PM +0530, Srujana Challa wrote:
>> >This commit introduces a new vDPA driver specifically designed for
>> >managing the virtio control plane over the vDPA bus for OCTEON DPU
>> >devices. The driver consists of two layers:
>> >
>> >1. Octep HW Layer (Octeon Endpoint): Responsible for handling hardware
>> >operations and configurations related to the DPU device.
>> >
>> >2. Octep Main Layer: Compliant with the vDPA bus framework, this layer
>> >implements device operations for the vDPA bus. It handles device
>> >probing, bus attachment, vring operations, and other relevant tasks.
>> >
>> >Signed-off-by: Srujana Challa <schalla@marvell.com>
>> >Signed-off-by: Vamsi Attunuru <vattunuru@marvell.com>
>> >Signed-off-by: Shijith Thotton <sthotton@marvell.com>
>> >Signed-off-by: Nithin Dabilpuram <ndabilpuram@marvell.com>
>> >---
>> > MAINTAINERS                              |   5 +
>> > drivers/vdpa/Kconfig                     |   9 +
>> > drivers/vdpa/Makefile                    |   1 +
>> > drivers/vdpa/octeon_ep/Makefile          |   4 +
>> > drivers/vdpa/octeon_ep/octep_vdpa.h      |  93 +++
>> > drivers/vdpa/octeon_ep/octep_vdpa_hw.c   | 457 ++++++++++++
>> > drivers/vdpa/octeon_ep/octep_vdpa_main.c | 903
>> +++++++++++++++++++++++
>> > 7 files changed, 1472 insertions(+)
>> > create mode 100644 drivers/vdpa/octeon_ep/Makefile  create mode
>> 100644
>> >drivers/vdpa/octeon_ep/octep_vdpa.h
>> > create mode 100644 drivers/vdpa/octeon_ep/octep_vdpa_hw.c
>> > create mode 100644 drivers/vdpa/octeon_ep/octep_vdpa_main.c

[...]

>> >diff --git a/drivers/vdpa/Kconfig b/drivers/vdpa/Kconfig index
>> >656c1cb541de..775149fad476 100644
>> >--- a/drivers/vdpa/Kconfig
>> >+++ b/drivers/vdpa/Kconfig
>> >@@ -126,4 +126,13 @@ config PDS_VDPA
>> > 	  With this driver, the VirtIO dataplane can be
>> > 	  offloaded to an AMD/Pensando DSC device.
>> >
>> >+config OCTEONEP_VDPA
>> >+	tristate "vDPA driver for Octeon DPU devices"
>> >+	depends on m
>>
>> Just for curiosity, why restrict it to module-only?
>
>There is an etherent driver for the same class of devices. So,
>we made this vDPA driver as module.

Sorry, I didn`t get it.

What would be the problem if we don`t put `depends on m` here?

>
>>
>> >+	depends on PCI_MSI
>> >+	help
>> >+	  vDPA driver for Marvell's Octeon DPU devices.
>> >+	  With this driver, the VirtIO dataplane can be
>> >+	  offloaded to a Octeon DPU device.
>> >+
>> > endif # VDPA

[...]

>> >+
>> >+void octep_notify_queue(struct octep_hw *oct_hw, u16 qid) {
>> >+	iowrite16(qid, oct_hw->vqs[qid].notify_addr); }
>> >+
>> >+void octep_read_dev_config(struct octep_hw *oct_hw, u64 offset, void
>> >+*dst, int length) {
>> >+	u8 old_gen, new_gen, *p;
>> >+	int i;
>> >+
>> >+	WARN_ON(offset + length > oct_hw->config_size);
>>                 ^
>> Should we return early in this case?
>Yes, I will move this to caller of this function.

Otherwise you can do this here:

	if (WARN_ON(offset + length > oct_hw->config_size))
		return;

Thanks,
Stefano

