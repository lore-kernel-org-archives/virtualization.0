Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A3591DEFE9
	for <virtualization@lists.linux.dev>; Wed, 25 Jun 2025 12:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750855156; cv=none; b=YpNnDFXlHkqFtDXhUNrzWmkBnbtsALY8Ilp42j7N3Qxg9bau2sgLRYip5d698X/ppOZFx6TEHFW/L/QbvyUjen91FquYUeiPRMDk/cOPNIKGvqvjpVkQOim1ynBMPQyF1OEFewOPZtjjRmuRgoylnSHU3vMpQaUgTPFVdmWWiGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750855156; c=relaxed/simple;
	bh=+4o3PIxGblecPLXQPo7HXJT+oP1v6Y4BbGilVIDxAXc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ce0Z+JbaweZit4yxjfbHiysPsNLSvnCIoKiRkHRE5Un4M85y28zgUtLrwMO12sJF3J64vfyd8nOk4/B4CO92vJHcf6wuopdfWa8AaR3F/3lw1AfUY7yppzbjof1hw2d042eLDMeeiXvfh39RG4kk5ev1HlQAh3HRUesqoWg5I3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XJ0Qnyf8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XJ0Qnyf8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1750855153;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=e4bNJPQhEh1mvM7sPpimO979n6aXsflGYx498uhPxi4=;
	b=XJ0Qnyf8JVbPesJi41ksOa848ESwycYDqnj3XI2ox/0PK+V2jTV12AKtBaI/BnXi6jADHV
	XK8uxqIbBW+3hvWt/BLHEVYWMvNzs09RwV1I5QgaAUCigDO9hMomTr8A5rgY7QYZolgOMK
	mbl6Xa/RRbdTCG4YLGFfeCNEhxRYPbY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-26-GlU-j-n3P_q2baELAu_p5w-1; Wed, 25 Jun 2025 08:39:12 -0400
X-MC-Unique: GlU-j-n3P_q2baELAu_p5w-1
X-Mimecast-MFC-AGG-ID: GlU-j-n3P_q2baELAu_p5w_1750855151
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-3a503f28b09so512344f8f.0
        for <virtualization@lists.linux.dev>; Wed, 25 Jun 2025 05:39:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750855151; x=1751459951;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=e4bNJPQhEh1mvM7sPpimO979n6aXsflGYx498uhPxi4=;
        b=CgFOFmlbl9rBFIU3ah7LDRDhCHB0cANvcM46pLd8fnDZ3OFnR08jVYmtQLaxJbG0nq
         MOczIAqyKgnhba9uBH3IJZzXyCmMswBh0BU9rnpzXEyDOZwhL1UwvZFWphcKX2f2K87L
         rs2RUDSTqblP3ajHNew5GqAE8gw+dREhFOK5On9WeQoBYcKAqKdgCPPqmHczKh+NxZfI
         6a+7DcODWuUmpwIu1lQQqRukiIYZH7bGhpJ+BWHOzprby3ZFAmHsGhSeZbQRsaicJ5IN
         ZoawFy5sfNQr/cCh0p6BFvnW++zoqhjK1uxETHhSqhvzHsWFsPaB9nLsDkcTiTEDE2/u
         IzlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWRp7o8XYMuMBHZ9F0bIEGa5JdZ29igDdqbGuc2uKSgVZNzH26tYdOSrjQM1IuOYpdJsm08Ori0Cq0nVwqUUQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YwqLqNY8BgejXTYkJYlqoRKLA/XtuQ4zRQxSP+rHEoN8x8Wloef
	nnVu35heH4hFLMJcYFq9nqj5L/0RnQugq6qBAWZZ/PnhZKadPtKx5FlDPXT7CWKERG8h0+5D89h
	GUrcA+nvWo5s8uPIk9rcyZRO7yXxqC2VAVH6Lk976Y8fSS9dB4NQp0tMOLLM+TAWPwTNI
X-Gm-Gg: ASbGnctLHNhPeOsV6jE5+QdFl9Er2Xm0wiNLiXlGRmaTjcUYRcZgvizqS/CXJbduIPQ
	22Q+EYqh4bvmNKxxNaH78lUP1XNLIVUtBYvAsG9jO6m1stfh9ZP0YwQg+ZC7B04/xeEJwrJguhC
	SOwbFwiDzptTQnt1JbC/2+ku3ZnIyJOtnYaFIr/a1W/JiaN5N7ElNHo1WDc39z1wmeQ/Tk5mmm8
	FtidewSqafxKdbx0t9jfJUuaRNP98srzx6toz3OuNjeObzuWQ3U6TNQY02kpj2O35DBIrNEMATo
	lcZgUNV+dgvuREI/
X-Received: by 2002:a5d:588d:0:b0:3a4:edf5:8a41 with SMTP id ffacd0b85a97d-3a6e71b86f6mr6479133f8f.4.1750855151341;
        Wed, 25 Jun 2025 05:39:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGoof/kcQj6EiHD8phskEoSt5Jd80UBJdNlsfnTMCY5+ROTqwx0M7qzM/M2LNKp+Y8Bpd1tLg==
X-Received: by 2002:a5d:588d:0:b0:3a4:edf5:8a41 with SMTP id ffacd0b85a97d-3a6e71b86f6mr6479099f8f.4.1750855150779;
        Wed, 25 Jun 2025 05:39:10 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73ea:4300:f7cc:3f8:48e8:2142])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-453823671cbsm18931125e9.29.2025.06.25.05.39.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jun 2025 05:39:10 -0700 (PDT)
Date: Wed, 25 Jun 2025 08:39:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Parav Pandit <parav@nvidia.com>, axboe@kernel.dk,
	virtualization@lists.linux.dev, linux-block@vger.kernel.org,
	stable@vger.kernel.org, lirongqing@baidu.com, kch@nvidia.com,
	xuanzhuo@linux.alibaba.com, pbonzini@redhat.com,
	jasowang@redhat.com, alok.a.tiwari@oracle.com,
	Max Gurtovoy <mgurtovoy@nvidia.com>,
	Israel Rukshin <israelr@nvidia.com>
Subject: Re: [PATCH v5] virtio_blk: Fix disk deletion hang on device surprise
 removal
Message-ID: <20250625083746-mutt-send-email-mst@kernel.org>
References: <20250602024358.57114-1-parav@nvidia.com>
 <20250624185622.GB5519@fedora>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250624185622.GB5519@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6SdKkvCCryF9tGwAjNnLIv5WT4Z6fEurNv5oWa-s9TE_1750855151
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Jun 24, 2025 at 02:56:22PM -0400, Stefan Hajnoczi wrote:
> On Mon, Jun 02, 2025 at 02:44:33AM +0000, Parav Pandit wrote:
> > When the PCI device is surprise removed, requests may not complete
> > the device as the VQ is marked as broken. Due to this, the disk
> > deletion hangs.
> 
> There are loops in the core virtio driver code that expect device
> register reads to eventually return 0:
> drivers/virtio/virtio_pci_modern.c:vp_reset()
> drivers/virtio/virtio_pci_modern_dev.c:vp_modern_set_queue_reset()
> 
> Is there a hang if these loops are hit when a device has been surprise
> removed? I'm trying to understand whether surprise removal is fully
> supported or whether this patch is one step in that direction.
> 
> Apart from that, I'm happy with the virtio_blk.c aspects of the patch:
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Is this as simple as this?

-->


Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

---

diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
index 7182f43ed055..df983fa9046a 100644
--- a/drivers/virtio/virtio_pci_modern.c
+++ b/drivers/virtio/virtio_pci_modern.c
@@ -555,8 +555,12 @@ static void vp_reset(struct virtio_device *vdev)
 	 * This will flush out the status write, and flush in device writes,
 	 * including MSI-X interrupts, if any.
 	 */
-	while (vp_modern_get_status(mdev))
+	while (vp_modern_get_status(mdev)) {
+		/* If device is removed meanwhile, it will never respond. */
+		if (!pci_device_is_present(vp_dev->pci_dev))
+			break;
 		msleep(1);
+	}
 
 	vp_modern_avq_cleanup(vdev);
 
diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
index 0d3dbfaf4b23..7177ce0d63be 100644
--- a/drivers/virtio/virtio_pci_modern_dev.c
+++ b/drivers/virtio/virtio_pci_modern_dev.c
@@ -523,11 +523,19 @@ void vp_modern_set_queue_reset(struct virtio_pci_modern_device *mdev, u16 index)
 	vp_iowrite16(index, &cfg->cfg.queue_select);
 	vp_iowrite16(1, &cfg->queue_reset);
 
-	while (vp_ioread16(&cfg->queue_reset))
+	while (vp_ioread16(&cfg->queue_reset)) {
+		/* If device is removed meanwhile, it will never respond. */
+		if (!pci_device_is_present(vp_dev->pci_dev))
+			break;
 		msleep(1);
+	}
 
-	while (vp_ioread16(&cfg->cfg.queue_enable))
+	while (vp_ioread16(&cfg->cfg.queue_enable)) {
+		/* If device is removed meanwhile, it will never respond. */
+		if (!pci_device_is_present(vp_dev->pci_dev))
+			break;
 		msleep(1);
+	}
 }
 EXPORT_SYMBOL_GPL(vp_modern_set_queue_reset);
 

