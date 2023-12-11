Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AE2C1D69C
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Dec 2023 16:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BCKtJ3Ke"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C609B81E14
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Dec 2023 16:37:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C609B81E14
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BCKtJ3Ke
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nst4vYtz7Okw
	for <virtualization@lists.linux-foundation.org>;
	Mon, 11 Dec 2023 16:37:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1414D81DF7
	for <virtualization@lists.linux-foundation.org>; Mon, 11 Dec 2023 16:37:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1414D81DF7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702312673;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=dVilu1XfoAUvH6IB8U//hkpAqxI7bnvmhbzG6eO/9yo=;
	b=BCKtJ3Ke05SFmvYqBhdGC4j5qE2nNOOqYiPQ/RzLHSkUX7/1V/0lGz/afHnSJ+14ZbFiR8
	4bvaaNnCFRvWvtdRx0DBR3CpuFfNzBFlh9EPtdDHvgFc+atKoAN4orviBg4J/f2R6e9tSe
	kzYUzFA1iAG2ub9cY+x9IgrWt9P0rgw=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-47-OGMqjXDDNjm7Q5B8l7SpRA-1; Mon, 11 Dec 2023 11:37:51 -0500
X-MC-Unique: OGMqjXDDNjm7Q5B8l7SpRA-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33342e25313so4096577f8f.3
        for <virtualization@lists.linux-foundation.org>; Mon, 11 Dec 2023 08:37:51 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702312670; x=1702917470;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dVilu1XfoAUvH6IB8U//hkpAqxI7bnvmhbzG6eO/9yo=;
        b=Kwj7yClb88Xjo6XWTq7xZFc6adbRy/pVoSCW2AFjy8zn59+xGbhcOqw/Cd3YdgoGOf
         0vbauE/qGAPJFyba03Krs9vD7QjiFgbSoSD4/t7i5iRrgJZdz96CuQODgthgu8iBUsbr
         mFHpSpqrFrr5mObXMEnCA/+B2x21QCKQ5t79Mq0kpx5TBsTY2zxJQe07DmocOQg19oki
         RPGc+SiE3hJ/KVw2VK1eiEAUsiy2pvHGwoPLs5mE/DE0/LWEiBqkOwpt6BPNFtmfuehw
         PLomh/Jlwi2QBVqOCJuW+NRfX4MHTiWoHWK/3cG6J1ZErrV3NhejCOxdoPnzKkJ0dtYP
         cwxQ==
X-Gm-Message-State: AOJu0YxNDRVNK71b1+S6OyTlDVuyhntaxQpPbsE9vYSUBqlVohvAFr/3
	/wSMPc81osVoBhknlJs1NU29VjVS2J4nYdH+fj9w36FxCbT9KcagEFaczfcNaXUb8sQC7Kt6gif
	gJm+nKDtU/0G7mcxM9Vj0ArkYc8QFyWnHZYQt37WQ7g==
X-Received: by 2002:a05:600c:2319:b0:40c:347b:b5c1 with SMTP id 25-20020a05600c231900b0040c347bb5c1mr2177778wmo.157.1702312670421;
        Mon, 11 Dec 2023 08:37:50 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEQq+HFXFZ1Mz3I9TqHai3Z8E01pvu1tPCn8KfPwQXzyUPoWuse2huLkuajrCr5e1OJvklZcw==
X-Received: by 2002:a05:600c:2319:b0:40c:347b:b5c1 with SMTP id 25-20020a05600c231900b0040c347bb5c1mr2177772wmo.157.1702312670083;
        Mon, 11 Dec 2023 08:37:50 -0800 (PST)
Received: from redhat.com ([2a06:c701:73ff:4f00:b091:120e:5537:ac67])
        by smtp.gmail.com with ESMTPSA id fc7-20020a05600c524700b0040c44cb251dsm5746268wmb.46.2023.12.11.08.37.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 Dec 2023 08:37:49 -0800 (PST)
Date: Mon, 11 Dec 2023 11:37:46 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: David Stevens <stevensd@chromium.org>
Cc: Jason Wang <jasowang@redhat.com>,
	virtualization@lists.linux-foundation.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] virtio: Add support for no-reset virtio PCI PM
Message-ID: <20231211113710-mutt-send-email-mst@kernel.org>
References: <20231208070754.3132339-1-stevensd@chromium.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20231208070754.3132339-1-stevensd@chromium.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Dec 08, 2023 at 04:07:54PM +0900, David Stevens wrote:
> If a virtio_pci_device supports native PCI power management and has the
> No_Soft_Reset bit set, then skip resetting and reinitializing the device
> when suspending and restoring the device. This allows system-wide low
> power states like s2idle to be used in systems with stateful virtio
> devices that can't simply be re-initialized (e.g. virtio-fs).
> 
> Signed-off-by: David Stevens <stevensd@chromium.org>

tagged, thanks!
I'm still debating with myself whether we can classify this
as a bugfix ... better not risk it I guess.

> ---
> v1 -> v2:
>  - Check the No_Soft_Reset bit
> 
>  drivers/virtio/virtio_pci_common.c | 34 +++++++++++++++++++++++++++++-
>  1 file changed, 33 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_pci_common.c
> index c2524a7207cf..3a95ecaf12dc 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -492,8 +492,40 @@ static int virtio_pci_restore(struct device *dev)
>  	return virtio_device_restore(&vp_dev->vdev);
>  }
>  
> +static bool vp_supports_pm_no_reset(struct device *dev)
> +{
> +	struct pci_dev *pci_dev = to_pci_dev(dev);
> +	u16 pmcsr;
> +
> +	if (!pci_dev->pm_cap)
> +		return false;
> +
> +	pci_read_config_word(pci_dev, pci_dev->pm_cap + PCI_PM_CTRL, &pmcsr);
> +	if (PCI_POSSIBLE_ERROR(pmcsr)) {
> +		dev_err(dev, "Unable to query pmcsr");
> +		return false;
> +	}
> +
> +	return pmcsr & PCI_PM_CTRL_NO_SOFT_RESET;
> +}
> +
> +static int virtio_pci_suspend(struct device *dev)
> +{
> +	return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_freeze(dev);
> +}
> +
> +static int virtio_pci_resume(struct device *dev)
> +{
> +	return vp_supports_pm_no_reset(dev) ? 0 : virtio_pci_restore(dev);
> +}
> +
>  static const struct dev_pm_ops virtio_pci_pm_ops = {
> -	SET_SYSTEM_SLEEP_PM_OPS(virtio_pci_freeze, virtio_pci_restore)
> +	.suspend = virtio_pci_suspend,
> +	.resume = virtio_pci_resume,
> +	.freeze = virtio_pci_freeze,
> +	.thaw = virtio_pci_restore,
> +	.poweroff = virtio_pci_freeze,
> +	.restore = virtio_pci_restore,
>  };
>  #endif
>  
> -- 
> 2.43.0.472.g3155946c3a-goog

