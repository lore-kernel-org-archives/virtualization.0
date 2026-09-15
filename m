Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142063BBFAB
	for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 14:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789482727; cv=none; b=bXcpaIEvie0MZMGjqEFucdM+KJNY70gLJ2G6Bbi0DRIuLmkBJ4paImkLOEDLrjThRp8yo+x2qprld474LZ7K3EmCG6S7rJEpPGK3n5d1bPtOM6AvbKWI3bSTnA1wLLvVKiVwLV8SQhk5yPpzMsnSl3I0AH4qYj8gLGcP4nPpG0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789482727; c=relaxed/simple;
	bh=KY4kERpfsrEQBrI45v69gonojzVxLkhX5dHC1+b8Rak=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uEAoxQHQz7eP9XERSc5N/sWDxoEGh2/CQULlgfIN/L6uYtCt6w4/4JGwANEVBQGq+ZjSNE/MZWwk0ZlkLkAkyIRz9DM2P+jCkIoVsrhv8ZlhBBDpWMeFmVEC1fHeFIBSbWir1GoyptsGxw0SiW2540Zs7j+eoEfmrZbFuqZV81s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=HLRLd6Nh; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HLRLd6Nh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789482722;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tAyTrdAHjcg/q5ZT0uo4l59VjZSOR5Zm5NeK3JMUfQI=;
	b=HLRLd6NhVHHp9TOXTr7lb3ylcbzv6T3+4m8nomPMDk3GSC0BRckZLqnsU0rAsx6o1ckbII
	GHlepFT/jTX+QzAhWOpkRiEnPIMrVUy+eaNw+7SPwa9PQGZ28OJiyZweuIIo/ImcUyaiiW
	5T10/V5XUcHq4qKrICN0e7JdFBpiJvc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-209-UB5IjfuoNxeTxJJYQy0FTw-1; Tue, 15 Sep 2026 10:32:01 -0400
X-MC-Unique: UB5IjfuoNxeTxJJYQy0FTw-1
X-Mimecast-MFC-AGG-ID: UB5IjfuoNxeTxJJYQy0FTw_1789482720
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-49b0e6638e3so41012285e9.2
        for <virtualization@lists.linux.dev>; Tue, 15 Sep 2026 07:32:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789482720; x=1790087520;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=tAyTrdAHjcg/q5ZT0uo4l59VjZSOR5Zm5NeK3JMUfQI=;
        b=o2EoZH38Zruzd6YxdKUmQPC1ClbiZib2ZuUn0OX0Knm/S3GnywrKJoJeMLJd7ehYwH
         RG3rr1RRZyquDbS7w8n+r5Ijkbv6cVFQd8uI16SFjVC/ZDen84Cf6jYT3iiUKybS8xlA
         iq3FKZNloxUAnCoQYHuItg8yTEZ7scoe4UoPAm+tyBaDig6MSM9rLqqdcEPzS59QudiR
         2bxO6vHONrzJWWBo6f21oAOWiLaXOKI1Kn86kWh7sHQozxdlWT/hxHcxb6yMKKHck8dG
         ah478oROtSm90YuOksWtO68/Yl4gh5mL8J04ZW2/oLzh+0pswR11cfUJ5NhwcxaBxdZ1
         y8lg==
X-Forwarded-Encrypted: i=1; AKwUvByKkQWeHWjSb/a1xDsFHrweHQSfNQ/slQEVwGGEW2Z6ADQYDjZcZyE2LzuxbYT6VJ+zMTxgxaNUO9bGY11sMA==@lists.linux.dev
X-Gm-Message-State: AFuF++kR+FDvYSZHsKJBk0zmqU+7AE10bnsxxuA/9arMnB5nw6GB03sk
	SZtKE+baL1p0Iy0KWGvZRfSDznRYpbEUSlC96QogLCb2B1NwQpvQDga/S61ymJVBd/J8fj4NJqN
	zaAhXUmf91l2Uf24OvhsIx8RFjUwUnhSu4H+0El4I+S6ju+MoHfTpenY7K6PBby+ip7ab
X-Gm-Gg: AYBFou2V4/96WsKaKYk5v0JA8rRIofjdH0GY45Bga4i35A24++rpRS6sxssheTq54Ld
	/KS8iUFWCapFjDdnbKXypzFhrU//AXPzjlRFdhSIFlnYJroYeZg0wBLHvbiVHGKKgMeFy8+A8XV
	oFY28brWL45Y4pzlhF6SZffrV8nAh9BJ07RcLNF0rpbu2dgoO+Nxo2y6JbD7DvAJ//FHESWECTn
	pjm/7rmg1RGBgQLE6wgnvAC3+AfWhN5RxfeMbd6JHhIuq3GSS8BegbLlomyHfZGhjVQa2rqjFyd
	N/rRgWCbucmYMOXWHdehMu+0bn4fwTcQe3r1kCtcFcmVfgM4BOG+s05p5VWUYg6Yiv3qqW1SMhB
	CrNqXRC508Z0tnF0OfaXAqJ0=
X-Received: by 2002:a05:600c:8b76:b0:49e:719e:e215 with SMTP id 5b1f17b1804b1-49e7a68c8f7mr91051605e9.26.1789482718749;
        Tue, 15 Sep 2026 07:31:58 -0700 (PDT)
X-Received: by 2002:a05:600c:8b76:b0:49e:719e:e215 with SMTP id 5b1f17b1804b1-49e7a68c8f7mr91050695e9.26.1789482717622;
        Tue, 15 Sep 2026 07:31:57 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-79-236.inter.net.il. [80.230.79.236])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-487072a93f6sm5460548f8f.15.2026.09.15.07.31.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 07:31:56 -0700 (PDT)
Date: Tue, 15 Sep 2026 10:31:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hao Peng <flyingpenghao@gmail.com>
Cc: jasowangio@gmail.com, virtualization@lists.linux.dev,
	Peng Hao <flyingpeng@tencent.com>
Subject: Re: [PATCH] virtio_pci_modern: fall back to 64 bits features for
 devices without an extended features space
Message-ID: <20260915102416-mutt-send-email-mst@kernel.org>
References: <20260911081133.16434-1-flyingpeng@tencent.com>
 <20260913152022-mutt-send-email-mst@kernel.org>
 <CAPm50aK=tjPRPdCjbpK9Kp8AD2o-e2JG2TZdx8nTVFh=0rf5Rg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAPm50aK=tjPRPdCjbpK9Kp8AD2o-e2JG2TZdx8nTVFh=0rf5Rg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: epDgZsJIFunyu1sVLXZZa9m72DX77KnU81g5Ig0K4IQ_1789482720
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Sep 15, 2026 at 08:32:25PM +0800, Hao Peng wrote:
> On Mon, Sep 14, 2026 at 3:20 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Sep 11, 2026 at 04:11:33PM +0800, Peng Hao wrote:
> > > From: Peng Hao <flyingingpeng@tencent.com>
> > >
> > > Since commit 69b9461512246 ("virtio_pci_modern: allow configuring
> > > extended features") the modern virtio-pci driver unconditionally
> > > accesses the whole 128 bits features space, i.e. it drives
> > > device_feature_select / guest_feature_select with the values 0..3.
> > >
> > > Devices predating the extended features space only implement the
> > > legacy 64 bits one, and what they report for the selectors above it is
> > > not a valid features space.  Negotiating it makes the driver and the
> > > device end up with different features sets: on a smart NIC exposing a
> > > virtio_net device the link comes up but carries no traffic, while the
> > > same device works with a kernel that only accesses the low 64 bits.
> > >
> > > Reading the features space has no side effect, so keep reading all of
> > > it and use the extended part to tell whether the device implements it:
> > > report the legacy 64 bits only when the extended words read back as
> > > all-ones or as an alias of the low words, and latch the device down for
> > > good.  As the features negotiation ANDs the device and driver features,
> > > no feature above bit 63 can be negotiated afterwards.
> > >
> > > Writing a selector the device does not implement cannot be relied upon
> > > the same way, so never drive one above the highest word that actually
> > > carries a bit.  The reset preceding the features negotiation zeroes the
> > > device side features, hence the words left unwritten stay cleared.
> > >
> > > Also dump the raw device_feature dwords, and add a max_features_u64s
> > > module parameter to force the legacy 64 bits space on devices whose
> > > quirk the detection does not catch.
> > >
> > > Conforming devices are unaffected: their extended words are neither
> > > all-ones nor an alias of the low ones, so the detection does not
> > > trigger.
> > >
> > > Signed-off-by: Peng Hao <flyingingpeng@tencent.com>
> >
> >
> > Also can you dump the pci header of the device please?
> >
> Yes. The affected PCI function is:
> 
>           BDF:               0000:45:00.0
>           Class:             0880
>           Vendor/device:     1af4:1000
>           Subsystem:         1af4:0001
>           Revision:          00
>           Physical slot:     0-34
>           Kernel driver:     virtio-pci
> 
>   The relevant `lspci -nnvv` output is:
> 
>   45:00.0 System peripheral [0880]: Red Hat, Inc. Virtio network
> device [1af4:1000]
>           Subsystem: Red Hat, Inc. Device [1af4:0001]
>           Physical Slot: 0-34
>           Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop-
>                    ParErr- Stepping- SERR- FastB2B- DisINTx+
>           Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast
>                   >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
>           NUMA node: 0
>           IOMMU group: 138
>           Region 0: Memory at 3ffbffc04000 (64-bit, prefetchable) [size=16K]
>           Region 2: Memory at 3ffbffc00000 (64-bit, prefetchable) [size=16K]
>           Capabilities: [94] MSI-X: Enable+ Count=66 Masked-
>                   Vector table: BAR=2 offset=00000000
>                   PBA: BAR=2 offset=00001000
>           Capabilities: [84] Vendor Specific Information: VirtIO: <unknown>
>                   BAR=0 offset=00000860 size=00000004


weird that lspci does not know about PciCfg wanna patch that?


>           Capabilities: [74] Vendor Specific Information: VirtIO: DeviceCfg
>                   BAR=0 offset=00000840 size=00000040
>           Capabilities: [64] Vendor Specific Information: VirtIO: ISR
>                   BAR=0 offset=00000820 size=00000020
>           Capabilities: [50] Vendor Specific Information: VirtIO: Notify
>                   BAR=0 offset=00001000 size=00000020 multiplier=00000000
>           Capabilities: [40] Vendor Specific Information: VirtIO: CommonCfg
>                   BAR=0 offset=00000888 size=00000078
>           Kernel driver in use: virtio-pci
> 
>   I have attached the complete `lspci -nnvvxxxx` output and the raw 4 KiB
>   PCI configuration-space dump.
> 
>  By the way, the information mentioned above was collected using the 7.2 kernel
> with my patch applied. Without this patch, the 7.2 kernel would be
> unable to establish
>  a network connection.
> 
>   Thanks,
>   Hao

So they didn't set subsystem id and we can't identify the device for
a quirk. Not nice. And sadly I do not see anything here that will
let us identify the specific hardware with any kind of robustness.

Waiting for you to report whether the device can be fixed in the field with
some kind of firmware update.


> > > ---
> > > diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> > > index 413a8c353463..cfb10c9f32dd 100644
> > > --- a/drivers/virtio/virtio_pci_modern_dev.c
> > > +++ b/drivers/virtio/virtio_pci_modern_dev.c
> > > @@ -5,6 +5,21 @@
> > >  #include <linux/pci.h>
> > >  #include <linux/delay.h>
> > >
> > > +static int max_features_u64s = -1;
> > > +module_param(max_features_u64s, int, 0444);
> > > +MODULE_PARM_DESC(max_features_u64s,
> > > +              "Max number of 64 bit words of the virtio features space to access (1 = legacy 64 bits only, -1 = auto-detect)");
> > > +
> > > +static u8 vp_modern_features_u64s(const struct virtio_pci_modern_device *mdev)
> > > +{
> > > +     u8 u64s = mdev->features_u64s ?: VIRTIO_FEATURES_U64S;
> > > +
> > > +     if (max_features_u64s > 0 && u64s > max_features_u64s)
> > > +             u64s = max_features_u64s;
> > > +
> > > +     return u64s;
> > > +}
> > > +
> > >  /*
> > >   * vp_modern_map_capability - map a part of virtio pci capability
> > >   * @mdev: the modern virtio-pci device
> > > @@ -230,6 +245,8 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
> > >
> > >       check_offsets();
> > >
> > > +     mdev->features_u64s = VIRTIO_FEATURES_U64S;
> > > +
> > >       if (mdev->device_id_check) {
> > >               devid = mdev->device_id_check(pci_dev);
> > >               if (devid < 0)
> > > @@ -398,15 +415,36 @@ void vp_modern_get_extended_features(struct virtio_pci_modern_device *mdev,
> > >                                    u64 *features)
> > >  {
> > >       struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> > > +     u32 raw[VIRTIO_FEATURES_BITS / 32];
> > > +     u8 u64s = vp_modern_features_u64s(mdev);
> > >       int i;
> > >
> > > -     virtio_features_zero(features);
> > >       for (i = 0; i < VIRTIO_FEATURES_BITS / 32; i++) {
> > > -             u64 cur;
> > > -
> > >               vp_iowrite32(i, &cfg->device_feature_select);
> > > -             cur = vp_ioread32(&cfg->device_feature);
> > > -             features[i >> 1] |= cur << (32 * (i & 1));
> > > +             raw[i] = vp_ioread32(&cfg->device_feature);
> > > +     }
> > > +
> > > +     dev_info(&mdev->pci_dev->dev,
> > > +              "virtio_pci: device_feature[0..3] = 0x%08x 0x%08x 0x%08x 0x%08x\n",
> > > +              raw[0], raw[1], raw[2], raw[3]);
> > > +
> > > +     virtio_features_zero(features);
> > > +     for (i = 0; i < u64s * 2; i++)
> > > +             features[i >> 1] |= (u64)raw[i] << (32 * (i & 1));
> > > +
> > > +     for (i = 1; i < u64s; i++) {
> > > +             int j;
> > > +
> > > +             if (features[i] != U64_MAX &&
> > > +                 !(features[0] && features[i] == features[0]))
> > > +                     continue;
> > > +
> > > +             dev_info(&mdev->pci_dev->dev,
> > > +                      "virtio_pci: no extended features space, using 64 bits features only\n");
> > > +             mdev->features_u64s = 1;
> > > +             for (j = 1; j < VIRTIO_FEATURES_U64S; j++)
> > > +                     features[j] = 0;
> > > +             break;
> > >       }
> > >  }
> > >  EXPORT_SYMBOL_GPL(vp_modern_get_extended_features);
> > > @@ -424,10 +462,11 @@ vp_modern_get_driver_extended_features(struct virtio_pci_modern_device *mdev,
> > >                                      u64 *features)
> > >  {
> > >       struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> > > +     u8 u64s = vp_modern_features_u64s(mdev);
> > >       int i;
> > >
> > >       virtio_features_zero(features);
> > > -     for (i = 0; i < VIRTIO_FEATURES_BITS / 32; i++) {
> > > +     for (i = 0; i < u64s * 2; i++) {
> > >               u64 cur;
> > >
> > >               vp_iowrite32(i, &cfg->guest_feature_select);
> > > @@ -446,9 +485,19 @@ void vp_modern_set_extended_features(struct virtio_pci_modern_device *mdev,
> > >                                    const u64 *features)
> > >  {
> > >       struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> > > +     u8 u64s = vp_modern_features_u64s(mdev);
> > >       int i;
> > >
> > > -     for (i = 0; i < VIRTIO_FEATURES_BITS / 32; i++) {
> > > +     /*
> > > +      * Never drive a selector the device may not implement: stop at the
> > > +      * highest word that carries a bit.  The device side features are
> > > +      * zeroed by the reset that precedes the features negotiation, so the
> > > +      * words left unwritten keep the value the driver wants for them.
> > > +      */
> > > +     while (u64s > 1 && !features[u64s - 1])
> > > +             u64s--;
> > > +
> > > +     for (i = 0; i < u64s * 2; i++) {
> > >               u32 cur = features[i >> 1] >> (32 * (i & 1));
> > >
> > >               vp_iowrite32(i, &cfg->guest_feature_select);
> > > diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
> > > index 9a3f2fc53bd6..7dc76afa671e 100644
> > > --- a/include/linux/virtio_pci_modern.h
> > > +++ b/include/linux/virtio_pci_modern.h
> > > @@ -27,6 +27,9 @@
> > >   *               Returns the found device id or ERRNO
> > >   * @dma_mask:            Optional mask instead of the traditional DMA_BIT_MASK(64),
> > >   *               for vendor devices with DMA space address limitations
> > > + * @features_u64s:  Number of 64 bit words of the features space that can be
> > > + *               accessed on this device; 1 for devices not implementing
> > > + *               the extended (128 bits) features space
> > >   */
> > >  struct virtio_pci_modern_device {
> > >       struct pci_dev *pci_dev;
> > > @@ -49,6 +52,7 @@ struct virtio_pci_modern_device {
> > >
> > >       int (*device_id_check)(struct pci_dev *pdev);
> > >       u64 dma_mask;
> > > +     u8 features_u64s;
> > >  };
> > >
> > >  /*
> > > --
> > > 2.43.0
> >

> 45:00.0 System peripheral [0880]: Red Hat, Inc. Virtio network device [1af4:1000]
> 	Subsystem: Red Hat, Inc. Device [1af4:0001]
> 	Physical Slot: 0-34
> 	Control: I/O- Mem+ BusMaster+ SpecCycle- MemWINV- VGASnoop- ParErr- Stepping- SERR- FastB2B- DisINTx+
> 	Status: Cap+ 66MHz- UDF- FastB2B- ParErr- DEVSEL=fast >TAbort- <TAbort- <MAbort- >SERR- <PERR- INTx-
> 	Latency: 0, Cache Line Size: 64 bytes
> 	NUMA node: 0
> 	IOMMU group: 138
> 	Region 0: Memory at 3ffbffc04000 (64-bit, prefetchable) [size=16K]
> 	Region 2: Memory at 3ffbffc00000 (64-bit, prefetchable) [size=16K]
> 	Capabilities: [a0] Express (v2) Endpoint, MSI 00
> 		DevCap:	MaxPayload 512 bytes, PhantFunc 0, Latency L0s <64ns, L1 <1us
> 			ExtTag+ AttnBtn- AttnInd- PwrInd- RBE+ FLReset- SlotPowerLimit 0W
> 		DevCtl:	CorrErr+ NonFatalErr+ FatalErr+ UnsupReq-
> 			RlxdOrd+ ExtTag+ PhantFunc- AuxPwr- NoSnoop+
> 			MaxPayload 512 bytes, MaxReadReq 2048 bytes
> 		DevSta:	CorrErr- NonFatalErr- FatalErr- UnsupReq- AuxPwr- TransPend-
> 		LnkCap:	Port #0, Speed 16GT/s, Width x8, ASPM not supported
> 			ClockPM- Surprise- LLActRep+ BwNot+ ASPMOptComp-
> 		LnkCtl:	ASPM Disabled; RCB 64 bytes, Disabled- CommClk-
> 			ExtSynch- ClockPM- AutWidDis- BWInt- AutBWInt-
> 		LnkSta:	Speed 16GT/s, Width x8
> 			TrErr- Train- SlotClk+ DLActive+ BWMgmt- ABWMgmt-
> 		DevCap2: Completion Timeout: Range ABCD, TimeoutDis+ NROPrPrP- LTR-
> 			 10BitTagComp+ 10BitTagReq+ OBFF Not Supported, ExtFmt- EETLPPrefix-
> 			 EmergencyPowerReduction Not Supported, EmergencyPowerReductionInit-
> 			 FRS- TPHComp- ExtTPHComp-
> 			 AtomicOpsCap: 32bit- 64bit- 128bitCAS-
> 		DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 10BitTagReq- OBFF Disabled,
> 			 AtomicOpsCtl: ReqEn-
> 		LnkCap2: Supported Link Speeds: 2.5-16GT/s, Crosslink- Retimer- 2Retimers- DRS-
> 		LnkCtl2: Target Link Speed: 16GT/s, EnterCompliance- SpeedDis-
> 			 Transmit Margin: Normal Operating Range, EnterModifiedCompliance- ComplianceSOS-
> 			 Compliance Preset/De-emphasis: -6dB de-emphasis, 0dB preshoot
> 		LnkSta2: Current De-emphasis Level: -6dB, EqualizationComplete- EqualizationPhase1-
> 			 EqualizationPhase2- EqualizationPhase3- LinkEqualizationRequest-
> 			 Retimer- 2Retimers- CrosslinkRes: unsupported
> 	Capabilities: [94] MSI-X: Enable+ Count=66 Masked-
> 		Vector table: BAR=2 offset=00000000
> 		PBA: BAR=2 offset=00001000
> 	Capabilities: [84] Vendor Specific Information: VirtIO: <unknown>
> 		BAR=0 offset=00000860 size=00000004
> 	Capabilities: [74] Vendor Specific Information: VirtIO: DeviceCfg
> 		BAR=0 offset=00000840 size=00000040
> 	Capabilities: [64] Vendor Specific Information: VirtIO: ISR
> 		BAR=0 offset=00000820 size=00000020
> 	Capabilities: [50] Vendor Specific Information: VirtIO: Notify
> 		BAR=0 offset=00001000 size=00000020 multiplier=00000000
> 	Capabilities: [40] Vendor Specific Information: VirtIO: CommonCfg
> 		BAR=0 offset=00000888 size=00000078
> 	Capabilities: [100 v2] Advanced Error Reporting
> 		UESta:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UEMsk:	DLP- SDES- TLP- FCP- CmpltTO- CmpltAbrt- UnxCmplt- RxOF- MalfTLP- ECRC- UnsupReq- ACSViol-
> 		UESvrt:	DLP+ SDES+ TLP- FCP+ CmpltTO- CmpltAbrt- UnxCmplt- RxOF+ MalfTLP+ ECRC+ UnsupReq- ACSViol+
> 		CESta:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
> 		CEMsk:	RxErr- BadTLP- BadDLLP- Rollover- Timeout- AdvNonFatalErr-
> 		AERCap:	First Error Pointer: 00, ECRCGenCap+ ECRCGenEn+ ECRCChkCap+ ECRCChkEn+
> 			MultHdrRecCap- MultHdrRecEn- TLPPfxPres- HdrLogCap-
> 		HeaderLog: 00000000 00000000 00000000 00000000
> 	Capabilities: [1a0 v1] Alternative Routing-ID Interpretation (ARI)
> 		ARICap:	MFVC- ACS-, Next Function: 0
> 		ARICtl:	MFVC- ACS-, Function Group: 0
> 	Kernel driver in use: virtio-pci
> 	Kernel modules: virtio_pci
> 00: f4 1a 00 10 06 04 10 00 00 00 80 08 10 00 00 00
> 10: 0c 40 c0 ff fb 3f 00 00 0c 00 c0 ff fb 3f 00 00
> 20: 00 00 00 00 00 00 00 00 00 00 00 00 f4 1a 01 00
> 30: 00 00 00 00 a0 00 00 00 00 00 00 00 ff 00 00 00
> 40: 09 00 10 01 00 00 00 00 88 08 00 00 78 00 00 00
> 50: 09 40 14 02 00 00 00 00 00 10 00 00 20 00 00 00
> 60: 00 00 00 00 09 50 10 03 00 00 00 00 20 08 00 00
> 70: 20 00 00 00 09 64 10 04 00 00 00 00 40 08 00 00
> 80: 40 00 00 00 09 74 10 05 00 00 00 00 60 08 00 00
> 90: 04 00 00 00 11 84 41 80 02 00 00 00 02 10 00 00
> a0: 10 94 02 00 22 80 00 00 57 49 00 00 84 60 30 00
> b0: 00 00 84 30 00 00 00 00 00 00 00 00 00 00 00 00
> c0: 00 00 00 00 1f 00 03 00 00 00 00 00 1e 00 00 00
> d0: 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 100: 01 00 02 1a 00 00 00 00 00 00 00 00 30 20 ee 03
> 110: 00 00 00 00 00 00 00 00 e0 01 00 00 00 00 00 00
> 120: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 130: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 140: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 150: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 160: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 170: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 180: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 190: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 1a0: 0e 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> 1b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 1c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 1d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 1e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 1f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 200: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 210: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 220: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 230: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 240: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 250: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 260: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 270: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 280: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 290: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 2a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 2b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 2c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 2d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 2e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 2f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 300: a0 1e a0 1e 00 04 10 00 00 00 80 08 10 00 00 00
> 310: 0c 40 b0 ff fb 3f 00 00 0c 00 b0 ff fb 3f 00 00
> 320: 00 00 00 00 00 00 00 00 00 00 00 00 a0 1e 01 00
> 330: 00 00 00 00 a0 00 00 00 00 00 00 00 ff 00 00 00
> 340: 09 00 10 01 00 00 00 00 88 08 00 00 78 00 00 00
> 350: 09 40 14 02 00 00 00 00 00 10 00 00 20 00 00 00
> 360: 00 00 00 00 09 50 10 03 00 00 00 00 20 08 00 00
> 370: 20 00 00 00 09 64 10 04 00 00 00 00 40 08 00 00
> 380: 40 00 00 00 09 74 10 05 00 00 00 00 60 08 00 00
> 390: 04 00 00 00 11 84 00 01 02 00 00 00 02 20 00 00
> 3a0: 10 94 02 00 22 80 00 00 57 49 00 00 84 60 30 00
> 3b0: 00 00 84 30 00 00 00 00 00 00 00 00 00 00 00 00
> 3c0: 00 00 00 00 1f 00 03 00 00 00 00 00 1e 00 00 00
> 3d0: 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 3e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 3f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 400: 01 00 02 1a 00 00 00 00 00 00 00 00 30 20 ee 03
> 410: 00 00 00 00 00 00 00 00 e0 01 00 00 00 00 00 00
> 420: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 430: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 440: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 450: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 460: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 470: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 480: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 490: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 4a0: 0e 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> 4b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 4c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 4d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 4e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 4f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 500: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 510: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 520: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 530: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 540: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 550: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 560: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 570: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 580: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 590: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 5a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 5b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 5c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 5d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 5e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 5f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 600: a0 1e a0 1e 00 04 10 00 00 00 80 08 10 00 00 00
> 610: 0c 40 a0 ff fb 3f 00 00 0c 00 a0 ff fb 3f 00 00
> 620: 00 00 00 00 00 00 00 00 00 00 00 00 a0 1e 01 00
> 630: 00 00 00 00 a0 00 00 00 00 00 00 00 ff 00 00 00
> 640: 09 00 10 01 00 00 00 00 88 08 00 00 78 00 00 00
> 650: 09 40 14 02 00 00 00 00 00 10 00 00 20 00 00 00
> 660: 00 00 00 00 09 50 10 03 00 00 00 00 20 08 00 00
> 670: 20 00 00 00 09 64 10 04 00 00 00 00 40 08 00 00
> 680: 40 00 00 00 09 74 10 05 00 00 00 00 60 08 00 00
> 690: 04 00 00 00 11 84 00 01 02 00 00 00 02 20 00 00
> 6a0: 10 94 02 00 22 80 00 00 57 49 00 00 84 60 30 00
> 6b0: 00 00 84 30 00 00 00 00 00 00 00 00 00 00 00 00
> 6c0: 00 00 00 00 1f 00 03 00 00 00 00 00 1e 00 00 00
> 6d0: 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 6e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 6f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 700: 01 00 02 1a 00 00 00 00 00 00 00 00 30 20 ee 03
> 710: 00 00 00 00 00 00 00 00 e0 01 00 00 00 00 00 00
> 720: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 730: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 740: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 750: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 760: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 770: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 780: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 790: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 7a0: 0e 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> 7b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 7c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 7d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 7e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 7f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 800: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 810: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 820: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 830: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 840: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 850: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 860: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 870: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 880: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 890: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 8a0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 8b0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 8c0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 8d0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 8e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 8f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 900: a0 1e a0 1e 00 04 10 00 00 00 80 08 10 00 00 00
> 910: 0c 40 90 ff fb 3f 00 00 0c 00 90 ff fb 3f 00 00
> 920: 00 00 00 00 00 00 00 00 00 00 00 00 a0 1e 01 00
> 930: 00 00 00 00 a0 00 00 00 00 00 00 00 ff 00 00 00
> 940: 09 00 10 01 00 00 00 00 88 08 00 00 78 00 00 00
> 950: 09 40 14 02 00 00 00 00 00 10 00 00 20 00 00 00
> 960: 00 00 00 00 09 50 10 03 00 00 00 00 20 08 00 00
> 970: 20 00 00 00 09 64 10 04 00 00 00 00 40 08 00 00
> 980: 40 00 00 00 09 74 10 05 00 00 00 00 60 08 00 00
> 990: 04 00 00 00 11 84 00 01 02 00 00 00 02 20 00 00
> 9a0: 10 94 02 00 22 80 00 00 57 49 00 00 84 60 30 00
> 9b0: 00 00 84 30 00 00 00 00 00 00 00 00 00 00 00 00
> 9c0: 00 00 00 00 1f 00 03 00 00 00 00 00 1e 00 00 00
> 9d0: 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 9e0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 9f0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a00: 01 00 02 1a 00 00 00 00 00 00 00 00 30 20 ee 03
> a10: 00 00 00 00 00 00 00 00 e0 01 00 00 00 00 00 00
> a20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> a90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> aa0: 0e 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> ab0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ac0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ad0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ae0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> af0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> b90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ba0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> bb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> bc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> bd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> be0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> bf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> c00: a0 1e a0 1e 00 04 10 00 00 00 80 08 10 00 00 00
> c10: 0c 40 80 ff fb 3f 00 00 0c 00 80 ff fb 3f 00 00
> c20: 00 00 00 00 00 00 00 00 00 00 00 00 a0 1e 01 00
> c30: 00 00 00 00 a0 00 00 00 00 00 00 00 ff 00 00 00
> c40: 09 00 10 01 00 00 00 00 88 08 00 00 78 00 00 00
> c50: 09 40 14 02 00 00 00 00 00 10 00 00 20 00 00 00
> c60: 00 00 00 00 09 50 10 03 00 00 00 00 20 08 00 00
> c70: 20 00 00 00 09 64 10 04 00 00 00 00 40 08 00 00
> c80: 40 00 00 00 09 74 10 05 00 00 00 00 60 08 00 00
> c90: 04 00 00 00 11 84 00 01 02 00 00 00 02 20 00 00
> ca0: 10 94 02 00 22 80 00 00 57 49 00 00 84 60 30 00
> cb0: 00 00 84 30 00 00 00 00 00 00 00 00 00 00 00 00
> cc0: 00 00 00 00 1f 00 03 00 00 00 00 00 1e 00 00 00
> cd0: 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ce0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> cf0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d00: 01 00 02 1a 00 00 00 00 00 00 00 00 30 20 ee 03
> d10: 00 00 00 00 00 00 00 00 e0 01 00 00 00 00 00 00
> d20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> d90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> da0: 0e 00 01 00 00 00 00 00 00 00 00 00 00 00 00 00
> db0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> dc0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> dd0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> de0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> df0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e00: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e10: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e20: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e30: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e40: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e50: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e60: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e70: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e80: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> e90: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ea0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> eb0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ec0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ed0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ee0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ef0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> f00: a0 1e a0 1e 00 04 10 00 00 00 80 08 10 00 00 00
> f10: 0c 40 70 ff fb 3f 00 00 0c 00 70 ff fb 3f 00 00
> f20: 00 00 00 00 00 00 00 00 00 00 00 00 a0 1e 01 00
> f30: 00 00 00 00 a0 00 00 00 00 00 00 00 ff 00 00 00
> f40: 09 00 10 01 00 00 00 00 88 08 00 00 78 00 00 00
> f50: 09 40 14 02 00 00 00 00 00 10 00 00 20 00 00 00
> f60: 00 00 00 00 09 50 10 03 00 00 00 00 20 08 00 00
> f70: 20 00 00 00 09 64 10 04 00 00 00 00 40 08 00 00
> f80: 40 00 00 00 09 74 10 05 00 00 00 00 60 08 00 00
> f90: 04 00 00 00 11 84 00 01 02 00 00 00 02 20 00 00
> fa0: 10 94 02 00 22 80 00 00 57 49 00 00 84 60 30 00
> fb0: 00 00 84 30 00 00 00 00 00 00 00 00 00 00 00 00
> fc0: 00 00 00 00 1f 00 03 00 00 00 00 00 1e 00 00 00
> fd0: 04 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> fe0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> ff0: 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00
> 

