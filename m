Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 453C04F93DF
	for <virtualization@lists.linux.dev>; Tue, 29 Sep 2026 09:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790674817; cv=none; b=Z6zpf28o1kgs+yTY4kOZxFyVMgwvvyIA17ZSPPQvaELNYyEE9/4H73N5lG3Ipkcous+Mm6oq8IG8Omrsr3YC8avNS26IpHU+veuz7t/GlaVfSyhEavdPQw2szw+Eo9pTbNdeRxjBiOlwCfImNk+Ln+/zC0/K5tpa2/ULJXzYR54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790674817; c=relaxed/simple;
	bh=h8NnFbSIy+QoNm9NqaH9d/OmE+5LDVTnIQ0vAVyqF1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hkqw6K6oKopr6bMSO6eGK1oyIMoNZQ+M86PQMXIBWTwXA4/dVJfS+qZzkzadtTnBVt1gj7FUlv7oyzYFvee3xCM1WogUbFm3w2+ZNiwyPW0SA+VJAiycQGu7jUkBWwPpWetwDt4LtpxMr44W/zb9Y6wVoU9tdT01Ln15ULuzz0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TVhuc6Vl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TVhuc6Vl"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1790674814;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=JO2itsGsivXvho5/AYcTNUUH8sciAPUTxDG3FC+6WbY=;
	b=TVhuc6VlggabvBlw6AodPghsCbvZOBOHKm+PP7MSFcrTbn3TWHtRE9lW/abVY2wNkgZBoQ
	Ho2or6RtWEC4XvKfQYPWxxRRZOyFJQXOk9uIiHRoZUgYng0XFGPVoAJD4AhW1NNkwmG3UJ
	3Kadyl+6d3vsWtrW5S12fUn4tntLHJI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-564-qoovuO7dOZW5fI8C_CUY7A-1; Tue, 29 Sep 2026 05:40:12 -0400
X-MC-Unique: qoovuO7dOZW5fI8C_CUY7A-1
X-Mimecast-MFC-AGG-ID: qoovuO7dOZW5fI8C_CUY7A_1790674811
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48709a1fbd0so3526022f8f.1
        for <virtualization@lists.linux.dev>; Tue, 29 Sep 2026 02:40:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790674811; x=1791279611;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=JO2itsGsivXvho5/AYcTNUUH8sciAPUTxDG3FC+6WbY=;
        b=EKgh1e3Pc7cv2Pee3mbNHjM5vjc/kZcSQ+dT89gLHlMNFApbhZDxNsgSjrT228NyWu
         +PzkRAhph/zjSjwbCwDsHD+pm7ArqplT49HxGqdJrAKG8yZEx834qCOB5fPPdmRSWMKz
         VXsKLpu0oQphuonugYT5uXMX0j/pQ7nOpgiDQWVVy0HIbC0dzXlYo3N6FKW6sb0MHWl5
         w5E7dXeDDMsX0ke2dW9g9N7lrLrYE7mZXg2iw1Dc/SmLN1AKqcRhO7XAZF9Y+wymKPE0
         G4h/29fy+VEswOYBKY/aIDw7NyUkUxk4A/EwkvzBE4SXLeLAZ3Hsi6qt7UrlgMiQicqE
         vyEQ==
X-Forwarded-Encrypted: i=1; AKwUvBw9QDTVvdN0jaOrA7pi21e6xGFqYyIScDQ3GMpPIahccGYFPbbgM3xryFHVIMPVyVgBtdhbBAibaADqtwyqKA==@lists.linux.dev
X-Gm-Message-State: AFq9FYKHI3LMUCBjV3kgPp7479IusNzO84eaGXqZ3UXG6OglUFgyvav4
	iYlgLwbBhDhBSmvYWUYbLGkJaHtITNkYhgC215bGvr7BTToxMoc5ZVYmSTJdjTKLjwzgia7K1Mr
	XVAcuTYy2YZjGnpLKzEdkGAF0i1gDtalw0nocy8aIogESCOv5AUdp00/4Fktgi3UUC+HO
X-Gm-Gg: AYBFou3DpEg+j1exLjwcCefe1peA9QxJblYEiN0pKTDUUgjobyyJ727dQmDz/foHwEW
	2k709EArmHHs5LmUng+j33uuVYQFEo4kuCHclJybua4JeTXMwqE+naWGPj5yFMJtIusM6U5d35/
	dsSMEZJM+73xzM9OpjdC8wuGDlllmVdNEh1AAnVJYG4RjzAk47PHghSlhCnsXNPNY4GdQDIgg9z
	fl2yBsi9z4ivSEio5z5+E0MDvWPa3LKiO67PuI/2zQ3no1SdsIJHhu3oY1Y7AZqAY2p70JM2MCF
	j/iA+E5m8upaTeIrY3qtXB/Qnas5V99cFOSkCbjHZr7wpsZ2mviYuVPDO7Tt0U4afgiNqg==
X-Received: by 2002:a05:6000:2203:b0:48a:f454:3d4 with SMTP id ffacd0b85a97d-48af454067dmr2361512f8f.53.1790674811374;
        Tue, 29 Sep 2026 02:40:11 -0700 (PDT)
X-Received: by 2002:a05:6000:2203:b0:48a:f454:3d4 with SMTP id ffacd0b85a97d-48af454067dmr2361457f8f.53.1790674810791;
        Tue, 29 Sep 2026 02:40:10 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48af50a3c49sm2690704f8f.34.2026.09.29.02.40.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 29 Sep 2026 02:40:10 -0700 (PDT)
Date: Tue, 29 Sep 2026 05:40:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Hao Peng <flyingpenghao@gmail.com>
Cc: jasowangio@gmail.com, virtualization@lists.linux.dev,
	Peng Hao <flyingpeng@tencent.com>
Subject: Re: [PATCH v2] virtio_pci_modern: skip trailing zero feature dwords
Message-ID: <20260929053537-mutt-send-email-mst@kernel.org>
References: <20260924071412.6765-1-flyingpeng@tencent.com>
 <20260924115824-mutt-send-email-mst@kernel.org>
 <CAPm50aJzfPLvt4S+Fz7=i_B0Gi6EPET1d+-mt0bdYdq7Tk3wcQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAPm50aJzfPLvt4S+Fz7=i_B0Gi6EPET1d+-mt0bdYdq7Tk3wcQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: sovYSB6H9EYADw7W6YQMWKvflCz4e5pcRDUPO_NllUU_1790674811
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Mon, Sep 28, 2026 at 08:31:15PM +0800, Hao Peng wrote:
> On Fri, Sep 25, 2026 at 12:05 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Sep 24, 2026 at 03:14:12PM +0800, Peng Hao wrote:
> > > Since commit 69b9461512246 ("virtio_pci_modern: allow configuring
> > > extended features"), vp_modern_set_extended_features() writes all four
> > > feature dwords on every device, even when the upper ones are zero.
> > >
> > > Feature negotiation follows a device reset, which clears the device-side
> > > driver features, so trailing zero dwords need not be written at all.
> > > finalize_features() can be called again without an intervening reset,
> > > though, when a driver's validate callback narrows the features, so also
> > > write any dword written since the last reset, to clear what the previous
> > > call had enabled.
> > >
> > > Devices negotiating nothing above bit 63 save four MMIO writes; those
> > > using the 64..95 range (e.g. the UDP tunnel GSO features) save two.
> > > Counting dwords rather than 64-bit words is what makes the latter work:
> > > with VIRTIO_F_VERSION_1 at bit 32 the second dword is set on every modern
> > > device, so a qword count never drops below two.
> > >
> > > Signed-off-by: Peng Hao <flyingpeng@tencent.com>
> >
> > So .. why does all this matter? how many exits do you save
> > during a guest boot? is it worth the complexity?
> >
> it depends on the number of modern virtio-pci devices:
>   - A device using only feature bits 0..63 previously required eight
> MMIO writes and now requires four, saving four
>     MMIO writes, normally four VM-exits.
>   - A device using bits 64..95 saves two MMIO writes/exits.
>   - Thus, for example, a guest with five ordinary modern virtio-pci
> devices saves about 20 exits during their
>     initial feature negotiation.

Out of some 10000-100000 that boot takes? Why does this matter?

> 
> > > ---
> > >  drivers/virtio/virtio_pci_modern_dev.c | 32 ++++++++++++++++++++++----
> > >  include/linux/virtio_pci_modern.h      |  3 +++
> > >  2 files changed, 31 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> > > index 413a8c353463..7b4da37b6ae5 100644
> > > --- a/drivers/virtio/virtio_pci_modern_dev.c
> > > +++ b/drivers/virtio/virtio_pci_modern_dev.c
> > > @@ -230,6 +230,8 @@ int vp_modern_probe(struct virtio_pci_modern_device *mdev)
> > >
> > >       check_offsets();
> > >
> > > +     mdev->driver_features_dwords = 1;
> > > +
> > >       if (mdev->device_id_check) {
> > >               devid = mdev->device_id_check(pci_dev);
> > >               if (devid < 0)
> > > @@ -437,6 +439,11 @@ vp_modern_get_driver_extended_features(struct virtio_pci_modern_device *mdev,
> > >  }
> > >  EXPORT_SYMBOL_GPL(vp_modern_get_driver_extended_features);
> > >
> > > +static u32 vp_modern_features_dword(const u64 *features, int dword)
> > > +{
> > > +     return features[dword / 2] >> (32 * (dword % 2));
> > > +}
> > > +
> > >  /*
> > >   * vp_modern_set_extended_features - set features to device
> > >   * @mdev: the modern virtio-pci device
> > > @@ -446,14 +453,27 @@ void vp_modern_set_extended_features(struct virtio_pci_modern_device *mdev,
> > >                                    const u64 *features)
> > >  {
> > >       struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> > > -     int i;
> > > +     int dwords = VIRTIO_FEATURES_BITS / 32;
> > > +     int i, write_dwords;
> > >
> > > -     for (i = 0; i < VIRTIO_FEATURES_BITS / 32; i++) {
> > > -             u32 cur = features[i >> 1] >> (32 * (i & 1));
> >
> >
> > below is arguing with previous version of code
> > instead of straight explaining what is this code doing.
> > pls rewrite this comment.
> >
> > > +     /*
> > > +      * A device reset
> >
> > what "a device reset"? who did reset and when?
> >
> > > clears the driver features, so trailing all-zero
> >
> > trailing?
> >
> > > +      * dwords need not be written out.  Include any dword written since
> > > +      * that reset,
> >
> > what "that" reset?
> >
> The reset in question is performed by the virtio core.
> register_virtio_device() calls virtio_reset_device() before
>   driver matching and feature negotiation. For modern virtio-pci,
> vp_reset() writes zero to device_status and waits
>   for the device to report zero. That reset clears all driver feature registers.
> > > though, so that a repeated finalization can clear
> > > +      * features which were enabled by the previous one.
> > > +      */
> >
> > > +     while (dwords > 1 && !vp_modern_features_dword(features, dwords - 1))
> > > +             dwords--;
> >
> dwords is the number of registers needed to represent the new feature
> set. The loop examines
>  register dwords - 1 and reduces the count while the highest register
> is zero. Register 0
>  remains part of the range.
> > what's all this > 1, - 1?
> >
> > > +
> > > +     write_dwords = max_t(int, dwords, mdev->driver_features_dwords);
> >
> > and what is this. i have a vague idea but needs a comment.
> >
> > >
> > > +     for (i = 0; i < write_dwords; i++) {
> > >               vp_iowrite32(i, &cfg->guest_feature_select);
> > > -             vp_iowrite32(cur, &cfg->guest_feature);
> > > +             vp_iowrite32(vp_modern_features_dword(features, i),
> > > +                          &cfg->guest_feature);
> > >       }
> > > +
> > > +     mdev->driver_features_dwords = dwords;
> >
> >
> > contradicts the comment near driver_features_dwords.
> >
> > >  }
> > >  EXPORT_SYMBOL_GPL(vp_modern_set_extended_features);
> > >
> > > @@ -495,6 +515,10 @@ void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
> > >  {
> > >       struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> > >
> > > +     /* A reset clears the device's copy of the driver features. */
> > > +     if (!status)
> > > +             mdev->driver_features_dwords = 1;
> >
> > so why 1 not 0?
> >
> Initializing driver_features_dwords to 1 after reset was unnecessarily
> confusing. The reset leaves no
> previously programmed range to clear, so the new version sets it to 0.
> > > +
> > >       /*
> > >        * Per memory-barriers.txt, wmb() is not needed to guarantee
> > >        * that the cache coherent memory writes have completed
> > > diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_pci_modern.h
> > > index 9a3f2fc53bd6..b9f4783f0e02 100644
> > > --- a/include/linux/virtio_pci_modern.h
> > > +++ b/include/linux/virtio_pci_modern.h
> > > @@ -27,6 +27,8 @@
> > >   *               Returns the found device id or ERRNO
> > >   * @dma_mask:            Optional mask instead of the traditional DMA_BIT_MASK(64),
> > >   *               for vendor devices with DMA space address limitations
> > > + * @driver_features_dwords: Number of 32-bit driver feature words written
> > > + *               to the device since the last reset
> > >   */
> > >  struct virtio_pci_modern_device {
> > >       struct pci_dev *pci_dev;
> > > @@ -49,6 +51,7 @@ struct virtio_pci_modern_device {
> > >
> > >       int (*device_id_check)(struct pci_dev *pdev);
> > >       u64 dma_mask;
> > > +     u8 driver_features_dwords;
> > >  };
> > >
> > >  /*
> > > --
> > > 2.43.7
> >

