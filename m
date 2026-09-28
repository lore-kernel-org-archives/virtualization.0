Received: from mail-oo2-f39.google.com (mail-oo2-f39.google.com [74.125.231.167])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F89B140E5F
	for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 12:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.167
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790598690; cv=pass; b=YmtoRzNGoS4nGTGHfAeL9ziPg0C2fCL2Ae2ckSh4BX/hRN2ucsT7GcFIMpzAnqmqQCrqnXr8ngycEXXq3JAUTuj7D4y/ymMeGPwAkpYpUYsh0W6c2HwOzHUHDtRXdhbMAY9YzTrYHhp/SiAMagrHK7DxA+mp++Fm1HUJvH/8wI0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790598690; c=relaxed/simple;
	bh=pGqjouXigEb8Rd7xXM5yqOmz3KJeVZQOEeavZvKc804=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tH48RoE0FAV1CwuFJ5lecRZJTVafRYmuVu0WikVFWZlYM4QW22lk5mC9M3vBG1E92t4U3Psfg/bGEGlJ85hTM0ozA8gkSrsm77p9o9OqZgDzIZMmIg+b3ucEn/9oaCkPtaP39umFEzQpAQiRdPU5MWthfXKyMa3dV7un39zzOXA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=quygOSwL; arc=pass smtp.client-ip=74.125.231.167
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="quygOSwL"
Received: by mail-oo2-f39.google.com with SMTP id 46e09a7af769-81c05431513so552816a34.0
        for <virtualization@lists.linux.dev>; Mon, 28 Sep 2026 05:31:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790598687; cv=none;
        d=google.com; s=arc-20260327;
        b=A40z5p4Rfd0k3BseKFIiZR77OXZh0SOK/m9PGC8tLv8iRwb23GUu1FP4ur9Z4B1989
         Wei69YdWJspu7mzWGS3KyPa4tZ2Y4h59bXPufVsstOyCUbKy6vT8ICITMGqQMvJ3hfbm
         C0iEhS1zr+/eSgCLj8BorcGD1vJBtXC8nAU8ITVjLDnNR9Q5tNWfhLwNPaOflrmgPkOO
         IknGaZqf0AKOakwfKtTsXF+6OdUjw/8O1TZWLZZ0dnEj+XjpEloFb0pfrA00ULr8NVj9
         ee0z7RE4RH5RHGNXiCyUHiSfzgji104DB83NoyUQDpp13dUlgg+hnwMaqyg8jTjNyZVp
         PqPw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=G/GuFzECGjj3tn+lVvuFmxVqX0AegRDhg/drhFkgRmI=;
        fh=AkW0YdvFoXeX1H2jA5WJZgI+f24LtquM63fPA1B94Ds=;
        b=Mp2gqg1vNrE8Sr4cgwTU0Qpjhm6oqPzDlWwxMGG/ZJjUJNG08tipwMSWyb53Zw06p5
         Y04LsPol/AeyHZkSV1vK6bpBbVbSmbcBgNjsEihQmq7NEtghnwv+E5+31lb6alMTaA+W
         1Mh44sdeNH364f9uLu6V3SauEbyfIl/RZQMnbRdfW7xaEU6R7ca4l+XuPFLEAGBUNGuT
         qnBMNT8Q6dNJZgqcV0WW934mt3RfT7aPZnplb3BHStgYVoitNR00tFyBI1QLauu7Tz1s
         a/yYhWrJA5poTklkeP+w3X8Kb+Ficln1wECN1szGabao0xKk1mfK4vARxiqnJ/uRjiSK
         r5Hg==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790598687; x=1791203487; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=G/GuFzECGjj3tn+lVvuFmxVqX0AegRDhg/drhFkgRmI=;
        b=quygOSwL8qLMIh9M/7aEnAKXWHOmF8XKXKMNtApDlUUty2luzWdfWa/I6/gUOytZvi
         2LBwpLnqXHHYS1RhmrnMOYqVrFmXaRxuUPBqe+fP5tY+Hh/qhY07EAaUfgZgAifFumTx
         VUaPh4SBw0P+gBdBdYcCt+2/3eg81JCNavVnKfyibSW6jFtMzk6oYrwjR8W3+eDlpXKj
         seLrgVxPUR9sgitJ44zuAOFPsQUf33E94Te0H+ORL/+BdaSWlZDcUhOxUgUyuiXfMsrb
         GMGd0JdyRV+eXw/bljXI6H/LYjdQK4llNmt3gcxhvncSITcnsox9jOZe+ZjK4tBvDlla
         pReA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790598687; x=1791203487;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=G/GuFzECGjj3tn+lVvuFmxVqX0AegRDhg/drhFkgRmI=;
        b=IxmNj8RnLPIWd4cAIlpr+G7o9ZEX/Dfru6DgRPC6ghfd15Dur7XxKef1x4vtNrddOf
         brAJpPJDKNJEHK82H3GIBi1gzzJDfM0htJ3XG1NShEU/Mk+CBw+G1Cocj6m5bfJ1e+iN
         wLiXpJjJriQm8Nie5AFPD3o4trx7YST+4bTulCqk+atc01lNfuWhvmfQMBEnwCNDlRRD
         1qBtu1JWt+z7WecGGzNhaQGKArgkKQ8ZNW4isFdR2zEPjBSYEslBXkWVrxrihSYeF2F4
         vzC7ASIdTOvH92y3BHdNvaBbf1rCLqyFXhrosVJkDNPjSAr7nBqn/WGlA4Xzwd7rd03m
         c60w==
X-Forwarded-Encrypted: i=1; AKwUvBwkU677znTRiluzRuhVjtrMSN0bb0vsTqT8U5F3Ls3fZPSRNPo6+97V0NAej3vl9R5RhKutqTuQyYlV8/4rjw==@lists.linux.dev
X-Gm-Message-State: AFuF++nKpKePGYqi9ipRPF7E+204eggnh/wgDN/HIolggb9b9Hh9RWjr
	jOhy+z8uTl19eWjoRQQhOLMZdEbPe2ENuQ2sW9dp+266DdURTKPNX1LY8B/lWKmcv5XwG0HMZN4
	cuRtfRFpqhOyuYBJqf93cCWilTj/ArCE=
X-Gm-Gg: AYBFou0tccEraKNh1pZySHMvXuTYGwdZzkOLHubd6udsWaowEWmJi/KLj6sDkubnrmu
	1IGh+3ZyjbB3ScYYHo3LTeJvOExWE1mZIhjSTk1LIq1T2fJRk7YFbSEC3ytU3QmcDnQHWMWGFgZ
	wz/YWuwygzF1BmMPRrm3UoY6FYB8GTfQME+zymUcAwc5izQ1lJJXuKwrvpn01YpMRXR7NXt1PqB
	UQ/LXVpVk2b7H+8kPxpxXWPtEjq1w28iB6ES0K5G8CGzpwHG+Z2hDRTO84dzGosmDBKM+pewKn+
	SnaMb5MdMa+CvgizbkK3pOgZFL1Zgcdx81xcRkof4T2lf79Bi5l4GbCUSa7d2UkHMg==
X-Received: by 2002:a05:6830:6612:b0:80a:b8da:2792 with SMTP id
 46e09a7af769-81780d935bbmr12897007a34.6.1790598687334; Mon, 28 Sep 2026
 05:31:27 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260924071412.6765-1-flyingpeng@tencent.com> <20260924115824-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260924115824-mutt-send-email-mst@kernel.org>
From: Hao Peng <flyingpenghao@gmail.com>
Date: Mon, 28 Sep 2026 20:31:15 +0800
X-Gm-Features: AclHuK_kdU5PyJnHQ_ad60HVD_nWmMgrJNTDshhNQLOnxTybD-GkEk9UjSZymio
Message-ID: <CAPm50aJzfPLvt4S+Fz7=i_B0Gi6EPET1d+-mt0bdYdq7Tk3wcQ@mail.gmail.com>
Subject: Re: [PATCH v2] virtio_pci_modern: skip trailing zero feature dwords
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowangio@gmail.com, virtualization@lists.linux.dev, 
	Peng Hao <flyingpeng@tencent.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 25, 2026 at 12:05=E2=80=AFAM Michael S. Tsirkin <mst@redhat.com=
> wrote:
>
> On Thu, Sep 24, 2026 at 03:14:12PM +0800, Peng Hao wrote:
> > Since commit 69b9461512246 ("virtio_pci_modern: allow configuring
> > extended features"), vp_modern_set_extended_features() writes all four
> > feature dwords on every device, even when the upper ones are zero.
> >
> > Feature negotiation follows a device reset, which clears the device-sid=
e
> > driver features, so trailing zero dwords need not be written at all.
> > finalize_features() can be called again without an intervening reset,
> > though, when a driver's validate callback narrows the features, so also
> > write any dword written since the last reset, to clear what the previou=
s
> > call had enabled.
> >
> > Devices negotiating nothing above bit 63 save four MMIO writes; those
> > using the 64..95 range (e.g. the UDP tunnel GSO features) save two.
> > Counting dwords rather than 64-bit words is what makes the latter work:
> > with VIRTIO_F_VERSION_1 at bit 32 the second dword is set on every mode=
rn
> > device, so a qword count never drops below two.
> >
> > Signed-off-by: Peng Hao <flyingpeng@tencent.com>
>
> So .. why does all this matter? how many exits do you save
> during a guest boot? is it worth the complexity?
>
it depends on the number of modern virtio-pci devices:
  - A device using only feature bits 0..63 previously required eight
MMIO writes and now requires four, saving four
    MMIO writes, normally four VM-exits.
  - A device using bits 64..95 saves two MMIO writes/exits.
  - Thus, for example, a guest with five ordinary modern virtio-pci
devices saves about 20 exits during their
    initial feature negotiation.


> > ---
> >  drivers/virtio/virtio_pci_modern_dev.c | 32 ++++++++++++++++++++++----
> >  include/linux/virtio_pci_modern.h      |  3 +++
> >  2 files changed, 31 insertions(+), 4 deletions(-)
> >
> > diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/vi=
rtio_pci_modern_dev.c
> > index 413a8c353463..7b4da37b6ae5 100644
> > --- a/drivers/virtio/virtio_pci_modern_dev.c
> > +++ b/drivers/virtio/virtio_pci_modern_dev.c
> > @@ -230,6 +230,8 @@ int vp_modern_probe(struct virtio_pci_modern_device=
 *mdev)
> >
> >       check_offsets();
> >
> > +     mdev->driver_features_dwords =3D 1;
> > +
> >       if (mdev->device_id_check) {
> >               devid =3D mdev->device_id_check(pci_dev);
> >               if (devid < 0)
> > @@ -437,6 +439,11 @@ vp_modern_get_driver_extended_features(struct virt=
io_pci_modern_device *mdev,
> >  }
> >  EXPORT_SYMBOL_GPL(vp_modern_get_driver_extended_features);
> >
> > +static u32 vp_modern_features_dword(const u64 *features, int dword)
> > +{
> > +     return features[dword / 2] >> (32 * (dword % 2));
> > +}
> > +
> >  /*
> >   * vp_modern_set_extended_features - set features to device
> >   * @mdev: the modern virtio-pci device
> > @@ -446,14 +453,27 @@ void vp_modern_set_extended_features(struct virti=
o_pci_modern_device *mdev,
> >                                    const u64 *features)
> >  {
> >       struct virtio_pci_common_cfg __iomem *cfg =3D mdev->common;
> > -     int i;
> > +     int dwords =3D VIRTIO_FEATURES_BITS / 32;
> > +     int i, write_dwords;
> >
> > -     for (i =3D 0; i < VIRTIO_FEATURES_BITS / 32; i++) {
> > -             u32 cur =3D features[i >> 1] >> (32 * (i & 1));
>
>
> below is arguing with previous version of code
> instead of straight explaining what is this code doing.
> pls rewrite this comment.
>
> > +     /*
> > +      * A device reset
>
> what "a device reset"? who did reset and when?
>
> > clears the driver features, so trailing all-zero
>
> trailing?
>
> > +      * dwords need not be written out.  Include any dword written sin=
ce
> > +      * that reset,
>
> what "that" reset?
>
The reset in question is performed by the virtio core.
register_virtio_device() calls virtio_reset_device() before
  driver matching and feature negotiation. For modern virtio-pci,
vp_reset() writes zero to device_status and waits
  for the device to report zero. That reset clears all driver feature regis=
ters.
> > though, so that a repeated finalization can clear
> > +      * features which were enabled by the previous one.
> > +      */
>
> > +     while (dwords > 1 && !vp_modern_features_dword(features, dwords -=
 1))
> > +             dwords--;
>
dwords is the number of registers needed to represent the new feature
set. The loop examines
 register dwords - 1 and reduces the count while the highest register
is zero. Register 0
 remains part of the range.
> what's all this > 1, - 1?
>
> > +
> > +     write_dwords =3D max_t(int, dwords, mdev->driver_features_dwords)=
;
>
> and what is this. i have a vague idea but needs a comment.
>
> >
> > +     for (i =3D 0; i < write_dwords; i++) {
> >               vp_iowrite32(i, &cfg->guest_feature_select);
> > -             vp_iowrite32(cur, &cfg->guest_feature);
> > +             vp_iowrite32(vp_modern_features_dword(features, i),
> > +                          &cfg->guest_feature);
> >       }
> > +
> > +     mdev->driver_features_dwords =3D dwords;
>
>
> contradicts the comment near driver_features_dwords.
>
> >  }
> >  EXPORT_SYMBOL_GPL(vp_modern_set_extended_features);
> >
> > @@ -495,6 +515,10 @@ void vp_modern_set_status(struct virtio_pci_modern=
_device *mdev,
> >  {
> >       struct virtio_pci_common_cfg __iomem *cfg =3D mdev->common;
> >
> > +     /* A reset clears the device's copy of the driver features. */
> > +     if (!status)
> > +             mdev->driver_features_dwords =3D 1;
>
> so why 1 not 0?
>
Initializing driver_features_dwords to 1 after reset was unnecessarily
confusing. The reset leaves no
previously programmed range to clear, so the new version sets it to 0.
> > +
> >       /*
> >        * Per memory-barriers.txt, wmb() is not needed to guarantee
> >        * that the cache coherent memory writes have completed
> > diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_p=
ci_modern.h
> > index 9a3f2fc53bd6..b9f4783f0e02 100644
> > --- a/include/linux/virtio_pci_modern.h
> > +++ b/include/linux/virtio_pci_modern.h
> > @@ -27,6 +27,8 @@
> >   *               Returns the found device id or ERRNO
> >   * @dma_mask:            Optional mask instead of the traditional DMA_=
BIT_MASK(64),
> >   *               for vendor devices with DMA space address limitations
> > + * @driver_features_dwords: Number of 32-bit driver feature words writ=
ten
> > + *               to the device since the last reset
> >   */
> >  struct virtio_pci_modern_device {
> >       struct pci_dev *pci_dev;
> > @@ -49,6 +51,7 @@ struct virtio_pci_modern_device {
> >
> >       int (*device_id_check)(struct pci_dev *pdev);
> >       u64 dma_mask;
> > +     u8 driver_features_dwords;
> >  };
> >
> >  /*
> > --
> > 2.43.7
>
