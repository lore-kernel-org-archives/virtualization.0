Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52BCBC433F5
	for <virtualization@archiver.kernel.org>; Fri,  6 May 2022 14:14:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C49CB404D3;
	Fri,  6 May 2022 14:14:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ARQc-OXcrbFY; Fri,  6 May 2022 14:14:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7B4BC40193;
	Fri,  6 May 2022 14:14:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B275C0032;
	Fri,  6 May 2022 14:14:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A4A97C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 14:14:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 7CD3F41849
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 14:14:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hhASfOVqX6CQ
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 14:14:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [170.10.129.74])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6595641769
 for <virtualization@lists.linux-foundation.org>;
 Fri,  6 May 2022 14:14:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651846457;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6EwxLss5z9pqfmNAfnE+750spjOXcHfkOQWWavm7Z64=;
 b=Po+Sszh3iBJkb4iPhqRWef617jkgSED5KvJgwzCYGqxF/zRc66HXbOIX+lerrd9kxo10sG
 T0Sw4w0ge8Lc3Vy4oOBkXYNBMOe4dbcaCJSS4+JQL+Xpu4Th56bhaXGqqWwyatZ6P0lMPB
 RMrjI25IjzPM0vrk/WeTdDDBnJEOpw8=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-629-JOl7y0ZTMU2Q4CKqjoBT5Q-1; Fri, 06 May 2022 10:14:15 -0400
X-MC-Unique: JOl7y0ZTMU2Q4CKqjoBT5Q-1
Received: by mail-ej1-f72.google.com with SMTP id
 sh14-20020a1709076e8e00b006f4a5de6888so4451561ejc.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 06 May 2022 07:14:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=6EwxLss5z9pqfmNAfnE+750spjOXcHfkOQWWavm7Z64=;
 b=s5ZvdpApaigd5PRaedmSo935Ha319OKjTuJtU6C3+CNxmbC57B4yTp8MpH/vQley6z
 7vo86EEYXOaPBBjsapihky10M3Ery3kDWQEn4hE/Nhh1s0d+cWF064NiHSeI31zi30oh
 ipnJbCgvk6K0+FK+qeHoBOb4DrzmiJuac6DCYZBj9/agWC7fbaLBTDTGwztluaWuTA3g
 VpGNpYOAriU5pNLh0iyO+dN1Xf8npiwMd8r+xTdN5XBLvx9hGTRBQPSqTeRL9tRaV23O
 Dh7ZEuF4zskb2B2zJslwdi4Bny8NdYsnZBjmbhoTxs8+AGyp1c7iA7A/393fgcVwSmCn
 IAaA==
X-Gm-Message-State: AOAM531k+QUn36YPUCzYlLLDp0ycWIbrkh5ql8XAW0tx5KVFnsc6MZXB
 /8ZLE7mC67xDtfyBWPcC1TpHVnF+P/sHBbcLBRpUj31fPvgiRxFh7g2cyhULPOpau6sd/nP8/ca
 3bHEqEQpqWE6iV0/Uj9O4pUNkwOJ7PoZoCkKRUwl9wg==
X-Received: by 2002:a17:907:1b1e:b0:6d7:31b0:e821 with SMTP id
 mp30-20020a1709071b1e00b006d731b0e821mr3152147ejc.334.1651846439148; 
 Fri, 06 May 2022 07:13:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyckf4ruK6WdXTZnQq2U7aWMOvfIW+9+F+1UXGr2zoM6PiRjmvaqZw5/Ho5iGuSVQegyf/HHg==
X-Received: by 2002:a17:907:1b1e:b0:6d7:31b0:e821 with SMTP id
 mp30-20020a1709071b1e00b006d731b0e821mr3152126ejc.334.1651846438898; 
 Fri, 06 May 2022 07:13:58 -0700 (PDT)
Received: from fedora (nat-2.ign.cz. [91.219.240.2])
 by smtp.gmail.com with ESMTPSA id
 hf15-20020a1709072c4f00b006f3ef214e4asm1940876ejc.176.2022.05.06.07.13.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 06 May 2022 07:13:58 -0700 (PDT)
From: Vitaly Kuznetsov <vkuznets@redhat.com>
To: vdasa@vmware.com
Subject: Re: [PATCH] VMCI: Add support for ARM64
In-Reply-To: <20220414193316.14356-1-vdasa@vmware.com>
References: <20220414193316.14356-1-vdasa@vmware.com>
Date: Fri, 06 May 2022 16:13:57 +0200
Message-ID: <87levezr2y.fsf@redhat.com>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=vkuznets@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Vishnu Dasa <vdasa@vmware.com>, pv-drivers@vmware.com,
 gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-kernel-review@vmware.com,
 Bryan Tan <bryantan@vmware.com>, Cyprien Laplace <claplace@vmware.com>,
 linux-arm-kernel@lists.infradead.org
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

vdasa@vmware.com writes:

> From: Vishnu Dasa <vdasa@vmware.com>
>
> Add support for ARM64 architecture so that the driver can now be built
> and VMCI device can be used.
>
> Update Kconfig file to allow the driver to be built on ARM64 as well.
> Fail vmci_guest_probe_device() on ARM64 if the device does not support
> MMIO register access.  Lastly, add virtualization specific barriers
> which map to actual memory barrier instructions on ARM64, because it
> is required in case of ARM64 for queuepair (de)queuing.
>

FWIW, it seems you're doing three things at once, better split this into
a 3-patch series.

> Reviewed-by: Bryan Tan <bryantan@vmware.com>
> Reviewed-by: Cyprien Laplace <claplace@vmware.com>
> Signed-off-by: Vishnu Dasa <vdasa@vmware.com>
> ---
>  drivers/misc/vmw_vmci/Kconfig           |  2 +-
>  drivers/misc/vmw_vmci/vmci_guest.c      |  4 ++++
>  drivers/misc/vmw_vmci/vmci_queue_pair.c | 12 ++++++++++++
>  3 files changed, 17 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/misc/vmw_vmci/Kconfig b/drivers/misc/vmw_vmci/Kconfig
> index 605794aadf11..b6d4d7fd686a 100644
> --- a/drivers/misc/vmw_vmci/Kconfig
> +++ b/drivers/misc/vmw_vmci/Kconfig
> @@ -5,7 +5,7 @@
>  
>  config VMWARE_VMCI
>  	tristate "VMware VMCI Driver"
> -	depends on X86 && PCI
> +	depends on (X86 || ARM64) && !CPU_BIG_ENDIAN && PCI
>  	help
>  	  This is VMware's Virtual Machine Communication Interface.  It enables
>  	  high-speed communication between host and guest in a virtual
> diff --git a/drivers/misc/vmw_vmci/vmci_guest.c b/drivers/misc/vmw_vmci/vmci_guest.c
> index 57a6157209a1..aa7b05de97dd 100644
> --- a/drivers/misc/vmw_vmci/vmci_guest.c
> +++ b/drivers/misc/vmw_vmci/vmci_guest.c
> @@ -614,6 +614,10 @@ static int vmci_guest_probe_device(struct pci_dev *pdev,
>  	}
>  
>  	if (!mmio_base) {
> +		if (IS_ENABLED(CONFIG_ARM64)) {
> +			dev_err(&pdev->dev, "MMIO base is invalid\n");
> +			return -ENXIO;
> +		}
>  		error = pcim_iomap_regions(pdev, BIT(0), KBUILD_MODNAME);
>  		if (error) {
>  			dev_err(&pdev->dev, "Failed to reserve/map IO regions\n");
> diff --git a/drivers/misc/vmw_vmci/vmci_queue_pair.c b/drivers/misc/vmw_vmci/vmci_queue_pair.c
> index 94ebf7f3fd58..8f2de1893245 100644
> --- a/drivers/misc/vmw_vmci/vmci_queue_pair.c
> +++ b/drivers/misc/vmw_vmci/vmci_queue_pair.c
> @@ -2577,6 +2577,12 @@ static ssize_t qp_enqueue_locked(struct vmci_queue *produce_q,
>  	if (result < VMCI_SUCCESS)
>  		return result;
>  
> +	/*
> +	 * This virt_wmb() ensures that data written to the queue
> +	 * is observable before the new producer_tail is.
> +	 */
> +	virt_wmb();
> +
>  	vmci_q_header_add_producer_tail(produce_q->q_header, written,
>  					produce_q_size);
>  	return written;
> @@ -2620,6 +2626,12 @@ static ssize_t qp_dequeue_locked(struct vmci_queue *produce_q,
>  	if (buf_ready < VMCI_SUCCESS)
>  		return (ssize_t) buf_ready;
>  
> +	/*
> +	 * This virt_rmb() ensures that data from the queue will be read
> +	 * after we have determined how much is ready to be consumed.
> +	 */
> +	virt_rmb();
> +
>  	read = (size_t) (buf_ready > buf_size ? buf_size : buf_ready);
>  	head = vmci_q_header_consumer_head(produce_q->q_header);
>  	if (likely(head + read < consume_q_size)) {

-- 
Vitaly

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
