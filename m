Received: from mail-oo2-f43.google.com (mail-oo2-f43.google.com [74.125.231.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9902933ADBA
	for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 07:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.231.171
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790233706; cv=pass; b=TLBGTlca/CrszfSjHoodn1xnzUi4do1IMr3uB1y6nAhQfcrjctcYPMsPic/4pJ3x0NKLKIabs2ZAhV1tVXbZ5OVMCmxlnu1C77rhEJC1MR8wcK54x9V6o+ZMxOqBsKeb/Vv7TkipzRyFBwh+ein38trRvAnuPX3ZOIc31AaUvmA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790233706; c=relaxed/simple;
	bh=TtsrjRvpIrHzAWITSsmR3UV4wBweJ77jSkLMzPeJA/s=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fVFyReQK/NCm8yVuDRSRW2hnQ64Y6YYiylYGZDKydg/fk9e+6X0f8P53jTIYYMnMZ9sMRvDLj13O+H6J0oNRZhC4+XU6DGyeQ3wT8lfOWTy8P88XzilWuJ7CPwi82E9QRwvWQKLqTBvbv9xodNxL6R25nMYr7uY4nzvtUkHjWEI=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMdEAp4X; arc=pass smtp.client-ip=74.125.231.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMdEAp4X"
Received: by mail-oo2-f43.google.com with SMTP id 006d021491bc7-6b1ae6b1b26so791205eaf.2
        for <virtualization@lists.linux.dev>; Thu, 24 Sep 2026 00:08:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790233701; cv=none;
        d=google.com; s=arc-20260327;
        b=Vzlfvflaz3qj0Ql/H1/X1CGM/QTOiAw+2sYu3sevZO2EcJn5MKZnFEuLuJzToY5GZ3
         Hx/2/L7zpDKTMn25wqfGRbCIJjVnpD+wNE3QYKinF8YAbjyQxcEna6UsdOlZ36YYCrVG
         AMPl9PyEX15dVXDlQaxswU+OlcK9Q4Drg+7297lgHUsfyglxCO6w7bGGiyfmCvoxkBv0
         M1XWwt2LIdx5WhurXdyZhIlv0UkfZD7BfUmpcd1RB1GFH9Hw7HO3PgiHA+XqPx1+Ar0L
         /2HNdMn0HkYNiWqw9FFMGrXaWrCbLv/bJk2eh/JgvbKXZfGFEDyNkHqtaGPSmpVs6/I6
         fuEg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=2aXd+2MZ1cx/47/pzcE1FN1vxDGFgcdVRW2Epwhjzf4=;
        fh=PZ6PuxG7qTpUEMeWRHAREGo2ykwRgp4k9oP4F2eWQxM=;
        b=ewU5e32UJ2m6OID3pKT5eTxruBEnrZxhvUahSocmX6g/9agUYafO4vAiOAVLb6Ttt3
         13Q7BobJa0kE9BEusP1PZmEfbOwdeJCVw091CeGEDlKKWUa+4Hne0eRDaTwhwgFYcfWW
         OpfhPrk/iicNFP+Noy89JmxH8VydlK1oFW6IFObqzeNqjYf7qALKOvGFk6Pc4wOVuqex
         NxzyUWNYCQlBv2pnSEdoA4OFXO4+CGdd12D60W345kza4VsJBXbHZtwtbUxMVm53DbHU
         et4Fq3bPLQwjCft9uvXQ0w+StTB6N/iGDt+b8Je+qJ5DSHW1sRAaytmrR2nBM4cxnACa
         qm5w==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790233701; x=1790838501; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=2aXd+2MZ1cx/47/pzcE1FN1vxDGFgcdVRW2Epwhjzf4=;
        b=lMdEAp4XcKd1Aepz9Rjn09QpHmCG6teHVnWr8Aq0mn7qv94IQPzfPAu1YHnkAINMre
         Gw8DuN3iiPeG3rhFE6y7IMgf4tVz31vSsZ7Lv0+wVl4/q15P4E5Q/T+504wTYjKMyq4h
         dcKoPEOp9TASSfOI+IitP+wxJe8SBRjk04HTJzqN8iBcNTyLYDpDJfKOM873Xb1EafJO
         M0foTFzP9CcwIN8W1Wk1JvENer5Ozv7KGpR0oxL8S+IxwbH8ZIgv9nyuL1KW3fZ1Ckrw
         9TGn+EbxO+odugCLXNhkrNBsYMvBCYb+3ejDjFZm8SN/xORhXn+YbHWyrb9oqQfMEN9j
         dFcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790233701; x=1790838501;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2aXd+2MZ1cx/47/pzcE1FN1vxDGFgcdVRW2Epwhjzf4=;
        b=j7bkCPcm78ILtt4uQPq/cFCSixP7YTHAYrsTsZ9ktgOfKhz3niBdvbLI691mXL9rzX
         FX6wcsmqmsgCJT5WipoWrFd0bFZmEbEm6FCahFwntX2ZF7bsylFXrHMD+7KCEq0qbbgF
         2KgXPV4ioBUlHDLtzA/c3ZS8cCjbOfuOaLNwB/5GMF+yISVKoSDIgUhJ7e1PVQp7/ZtM
         6o4VIDlm6A1sya3IxOUeHjTI3x7H5wsuBkpmQAjDtrucq2cv7ktbcx1/QU1FGUZlMP/y
         FrhXVOOpzTYVtGNl+pXNS/OoOxbsxn9IOrYTEi2wf5w//LQRrPFGt8otKRKKWYeMCwC8
         BJPA==
X-Forwarded-Encrypted: i=1; AKwUvBz+Dx26p5kPmjo7hSV7eculrH9XDl0yjAGTXQMInmTCh/uoJ6MiFhj3ufdwynE+m6FSnV7D+KR/AvLM0WDYPQ==@lists.linux.dev
X-Gm-Message-State: AFuF++lKDWMyocROEuJy06VUS0g+4oI2ocFD7jY4WNuqjbTZdM/58Koy
	U3gU5Ej11F+kZvSlvDDDn9vLG7quTIHojvkLXggMTWDzGCE00ZgYzILsyuc5QuGAUIAqfRT3jYi
	sBzF6ZF7xhhPGKfaP7KpoLwgzX535gxE=
X-Gm-Gg: AYBFou3lLSweoruDb5zlyYhbo8Dy4sakPaSk1cACr2BTt9n/VWoDPw+UyhaGdlVwZn/
	4QRIsGdBp2phusw1mMeatcrnTv0p7baxVnjfGOFopNZLL32W8AQyQw81vrQfEmvvfa7W8v5qFAY
	KiVByhcj+NTsLsbvXqdDK8+ktgO8REDXjhevh/J8SbiN4GJRLp5G8Qrh2AIKBDe/ik8kw2Uhbtm
	1ntd3z8Km0ZVuaYOdImhPMCSpm7W2v33vo0j8cGPWMcv9eC5UJRNOqv53ZDiVv/EquLEYcNdnmc
	wR1g2U2jDtbtuDz780KEhqBCk3VZwyWULVtXj2cWhId8dPaxbm/es2Y=
X-Received: by 2002:a05:6820:2085:b0:6be:456c:c443 with SMTP id
 006d021491bc7-6d44062e98dmr1513228eaf.65.1790233701097; Thu, 24 Sep 2026
 00:08:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <20260920065746.86415-1-flyingpeng@tencent.com> <20260920043705-mutt-send-email-mst@kernel.org>
In-Reply-To: <20260920043705-mutt-send-email-mst@kernel.org>
From: Hao Peng <flyingpenghao@gmail.com>
Date: Thu, 24 Sep 2026 15:08:09 +0800
X-Gm-Features: AclHuK_cuohd0Z7u3YYTtyg9NyGtxFYICW9vULItFwi2U3AEsZEDBW71cw2_AfY
Message-ID: <CAPm50aJXf7sEmM5TFX=F=wJJcUhuxN4QawU9f0r99dG903ixUQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_pci_modern: skip unused trailing driver feature words
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jasowangio@gmail.com, virtualization@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 20, 2026 at 4:41=E2=80=AFPM Michael S. Tsirkin <mst@redhat.com>=
 wrote:
>
> On Sun, Sep 20, 2026 at 02:57:46PM +0800, Peng Hao wrote:
> > Since commit 69b9461512246 ("virtio_pci_modern: allow configuring
> > extended features"), vp_modern_set_extended_features() writes all 128
> > feature bits on every device.  Each 32-bit word requires one write to
> > guest_feature_select and another to guest_feature, even when the upper
> > 64 feature bits are all zero.
> >
> > Feature negotiation starts after a device reset, which clears the
> > device-side driver features.  There is therefore no need to write
> > trailing zero 64-bit words on the first feature finalization.
> >
> > finalize_features() can, however, be called again without an intervenin=
g
> > reset when a driver's validate callback changes the negotiated features=
.
> > Remember how many words were written since the last reset and include
> > that range in the next write, so that a repeated finalization can clear
> > features which were previously enabled.
> >
> > This avoids four MMIO writes for devices which negotiate no feature
> > above bit 63, while preserving the full-overwrite behavior when the
> > negotiated feature range shrinks.
> >
> > Signed-off-by: Peng Hao <flyingpeng@tencent.com>
>
> I don't get it. pci updates features in units of 32 bit dwords.
>
> Most devices only use the 1st 32 bit dword.
>
> /scm/linux$ git grep _F_ include/uapi/linux/virtio*h|grep [4-9][0-9]|wc -=
l
> 21
> /scm/linux$ git grep _F_ include/uapi/linux/virtio*h|wc -l
> 190
>
> Why are you tracking 64-bit qwords?
>
No good reason -- I tracked the unit the features array happens to be
stored in rather than the unit the register interface uses.  You're
right, and it's not just cosmetic: qword granularity is strictly worse
here, because VIRTIO_F_VERSION_1 is bit 32.  Every modern device has
dword 1 set, so the qword count can never fall below 2, and the v1 patch
therefore saved nothing at all for a device using bits 64..95.  Counting
dwords fixes that:

  virtio-net, nothing above bit 63     8 -> 4 writes (v1: 4)
  virtio-net + UDP tunnel GSO (65..68) 8 -> 6 writes (v1: 8, no saving)

v2 counts dwords throughout.  The struct field becomes

        u8 driver_features_dwords;

initialised to 1 at probe and reset to 1 in vp_modern_set_status(status
=3D=3D 0), and the write loop runs to max_t(int, dwords,
mdev->driver_features_dwords).

Thanks,
Peng Hao
>
> > ---
> >  drivers/virtio/virtio_pci_modern_dev.c | 22 +++++++++++++++++++++-
> >  include/linux/virtio_pci_modern.h      |  3 +++
> >  2 files changed, 24 insertions(+), 1 deletion(-)
> >
> > diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/vi=
rtio_pci_modern_dev.c
> > index 413a8c353463..8211e491a17b 100644
> > --- a/drivers/virtio/virtio_pci_modern_dev.c
> > +++ b/drivers/virtio/virtio_pci_modern_dev.c
> > @@ -230,6 +230,8 @@ int vp_modern_probe(struct virtio_pci_modern_device=
 *mdev)
> >
> >       check_offsets();
> >
> > +     mdev->driver_features_u64s =3D 1;
> > +
> >       if (mdev->device_id_check) {
> >               devid =3D mdev->device_id_check(pci_dev);
> >               if (devid < 0)
> > @@ -446,14 +448,29 @@ void vp_modern_set_extended_features(struct virti=
o_pci_modern_device *mdev,
> >                                    const u64 *features)
> >  {
> >       struct virtio_pci_common_cfg __iomem *cfg =3D mdev->common;
> > +     u8 u64s =3D VIRTIO_FEATURES_U64S;
> > +     u8 write_u64s;
> >       int i;
> >
> > -     for (i =3D 0; i < VIRTIO_FEATURES_BITS / 32; i++) {
> > +     /*
> > +      * A reset clears the device-side driver features, so trailing ze=
ro
> > +      * words need not be written.  Include words written by the previ=
ous
> > +      * call, though, so a repeated feature finalization can clear fea=
tures
> > +      * that were previously enabled.
> > +      */
> > +     while (u64s > 1 && !features[u64s - 1])
> > +             u64s--;
> > +
> > +     write_u64s =3D max(u64s, mdev->driver_features_u64s);
> > +
> > +     for (i =3D 0; i < write_u64s * 2; i++) {
> >               u32 cur =3D features[i >> 1] >> (32 * (i & 1));
> >
> >               vp_iowrite32(i, &cfg->guest_feature_select);
> >               vp_iowrite32(cur, &cfg->guest_feature);
> >       }
> > +
> > +     mdev->driver_features_u64s =3D u64s;
> >  }
> >  EXPORT_SYMBOL_GPL(vp_modern_set_extended_features);
> >
> > @@ -495,6 +512,9 @@ void vp_modern_set_status(struct virtio_pci_modern_=
device *mdev,
> >  {
> >       struct virtio_pci_common_cfg __iomem *cfg =3D mdev->common;
> >
> > +     if (!status)
> > +             mdev->driver_features_u64s =3D 1;
> > +
> >       /*
> >        * Per memory-barriers.txt, wmb() is not needed to guarantee
> >        * that the cache coherent memory writes have completed
> > diff --git a/include/linux/virtio_pci_modern.h b/include/linux/virtio_p=
ci_modern.h
> > index 9a3f2fc53bd6..8df287d545c9 100644
> > --- a/include/linux/virtio_pci_modern.h
> > +++ b/include/linux/virtio_pci_modern.h
> > @@ -27,6 +27,8 @@
> >   *               Returns the found device id or ERRNO
> >   * @dma_mask:            Optional mask instead of the traditional DMA_=
BIT_MASK(64),
> >   *               for vendor devices with DMA space address limitations
> > + * @driver_features_u64s: Number of 64-bit driver feature words progra=
mmed
> > + *               since the last device reset
> >   */
> >  struct virtio_pci_modern_device {
> >       struct pci_dev *pci_dev;
> > @@ -49,6 +51,7 @@ struct virtio_pci_modern_device {
> >
> >       int (*device_id_check)(struct pci_dev *pdev);
> >       u64 dma_mask;
> > +     u8 driver_features_u64s;
> >  };
> >
> >  /*
> > --
> > 2.43.7
>
