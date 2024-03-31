Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF410146D63
	for <virtualization@lists.linux.dev>; Sun, 31 Mar 2024 20:03:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711915400; cv=none; b=JvXpJAcaZIpMBFW1OH0dQwp0RNpBzMqfLfPr55eBXfdGrSQlRTLnwGhsrTCJQhJCA3D1YdrVtDDy0S4Zv6MBZfznVBz2AlMnV53ANS/GNnPzUEMLR/7LFc3fsYNfNidQG1y0I6TtOjC2ZSLfm491tqWPNhs1DK0x4qB11wX8FgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711915400; c=relaxed/simple;
	bh=MP2M3Ps9Xm6CKR5ajbIyexLK1aZwxbrMgAjKO3uOxlo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bjBt7UCYpy4/LEgUqXumHhhSMtmTaSCeqJGRrSGvwrT5eoaXMkN59kPC9dj5nByHd98E5L+MEpqOy8V7zo+z3tHImQuqhfBQGs9mJSGF4C128/kJVNgC1XSFSC6PPjl4iDpUw6nLoDf+jEI6SsFFs5zW7/v+3j7lWINjYK7kjO8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EVed+8L7; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EVed+8L7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711915396;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=mWrFvQov9tCVj8RAaHACi83R1vmWvJiiD5ExnniOzKE=;
	b=EVed+8L7Jz4O1hOcnvKtvTJQUpx0e/Xj8smDX5d286MzcQrj1Qb5K+VJo+h3ja2jO2OhN2
	BOS5J3D3AYjHjIZ5wo6WR87qCBTiVZMlxXAOYeaNvGWyShlk20xEYJh10WlwO8OhenYjzZ
	rbKhBLjwITXC6WI6jZuZSkirjPJNiH4=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-636-780J1xg9MWmpR_GWeK3txw-1; Sun, 31 Mar 2024 16:03:14 -0400
X-MC-Unique: 780J1xg9MWmpR_GWeK3txw-1
Received: by mail-lf1-f72.google.com with SMTP id 2adb3069b0e04-516a368df47so643673e87.2
        for <virtualization@lists.linux.dev>; Sun, 31 Mar 2024 13:03:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711915392; x=1712520192;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mWrFvQov9tCVj8RAaHACi83R1vmWvJiiD5ExnniOzKE=;
        b=j5LdbvB5ukvBp2QolzbHdPF9MTMV8tBgBzAHLVLzrP26mZK2Ff5gIOd3XKhgpiSJ7p
         Sa9f3ZiNvYRNiukLaeYtFeacJKMqiE/i4MoBrQO+e3qsReLKBD5aWocgnXFl2LOEExb6
         JsAdDq9lcHhm41nP87a4a/1atYYg2W4jeq18u77BFneLISsvGbfPj77abrhFjELvvipo
         /FDvuXQEngVA1cFwtCaKpSbqxp/aMJgDofSBb94AFhovJF712xi07wmwewYzo7VGR04e
         uYiTHKYM01t9udbrCTdf/mScA70u7napOsiPJp9TcVvpSzws+xuffmPhG5pJBskv7z6S
         XbKA==
X-Forwarded-Encrypted: i=1; AJvYcCUwF6OsbREC4MtcQSGjdFFdd90HhyEb355NoPHE75T1ID4BgOtjKiKhGelCL3rPSQPnMsg8Xfc6fXE8rGL/qHoektJiQ3uc5JdjSdZAr4M=
X-Gm-Message-State: AOJu0Yxkf0NuPnD+r6iPgdg/Uyw2jEujM9//kTILRkXIqK6RJVEEXaUX
	maYrGl75dm0sJymBdHe+mIwmg4eLsrJLIiuWXs5B5jBe7og5fQ5CkggpKA+8/VbloVMGHvumxtv
	yZ5sXCwDBHqXc29gC/ODpf7Jl80rPYGf0sL3hlPoU7aO0QKa+cH9F+h1yH/8OgdB0
X-Received: by 2002:a05:6512:368c:b0:514:a821:a020 with SMTP id d12-20020a056512368c00b00514a821a020mr5180246lfs.26.1711915392530;
        Sun, 31 Mar 2024 13:03:12 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEFdmpfkI6NnK9AqfaprVEiuFFOt+Phk0G+1ZLvP3sE9r/ROIA7eSSX2UhbKHe0UpvwkI7XPA==
X-Received: by 2002:a05:6512:368c:b0:514:a821:a020 with SMTP id d12-20020a056512368c00b00514a821a020mr5180206lfs.26.1711915391865;
        Sun, 31 Mar 2024 13:03:11 -0700 (PDT)
Received: from redhat.com ([2a02:14f:172:9c27:9486:684f:de6:8ab8])
        by smtp.gmail.com with ESMTPSA id ef5-20020a17090697c500b00a473792da26sm4556704ejb.19.2024.03.31.13.03.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 31 Mar 2024 13:03:11 -0700 (PDT)
Date: Sun, 31 Mar 2024 16:03:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: Stefano Garzarella <sgarzare@redhat.com>, jasowang@redhat.com,
	virtualization@lists.linux.dev
Subject: Re: [PATCH 02/10] vDPA: report virtio-block max segment size to user
 space
Message-ID: <20240331160230-mutt-send-email-mst@kernel.org>
References: <20240218185606.13509-1-lingshan.zhu@intel.com>
 <20240218185606.13509-3-lingshan.zhu@intel.com>
 <etmgf3zcsnuz5hoj26g2nr7qunc7dxqg5p5hb43oe2mefkgyk5@4dofowgn4vcy>
 <bfd9be81-d84d-424f-bed0-2e2cfe945bf4@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <bfd9be81-d84d-424f-bed0-2e2cfe945bf4@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Mar 29, 2024 at 10:48:25PM +0800, Zhu, Lingshan wrote:
> 
> 
> On 3/20/2024 12:04 AM, Stefano Garzarella wrote:
> > On Mon, Feb 19, 2024 at 02:55:58AM +0800, Zhu Lingshan wrote:
> > > This commit allows reporting the max size of any
> > > single segment of virtio-block devices to user space.
> > > 
> > > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > > ---
> > > drivers/vdpa/vdpa.c       | 17 +++++++++++++++++
> > > include/uapi/linux/vdpa.h |  1 +
> > > 2 files changed, 18 insertions(+)
> > > 
> > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > index d5ccb618de2b..ee1472d32b0d 100644
> > > --- a/drivers/vdpa/vdpa.c
> > > +++ b/drivers/vdpa/vdpa.c
> > > @@ -956,6 +956,20 @@ vdpa_dev_blk_capacity_config_fill(struct
> > > sk_buff *msg,
> > >                  val_u64, VDPA_ATTR_PAD);
> > > }
> > > 
> > > +static int
> > > +vdpa_dev_blk_seg_size_config_fill(struct sk_buff *msg, u64 features,
> > > +                  const struct virtio_blk_config *config)
> > > +{
> > > +    u32 val_u32;
> > > +
> > > +    if ((features & BIT_ULL(VIRTIO_BLK_F_SIZE_MAX)) == 0)
> > > +        return 0;
> > > +
> > > +    val_u32 = __virtio32_to_cpu(true, config->size_max);
> > > +
> > > +    return nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_SEG_SIZE, val_u32);
> > 
> > Should we call this VDPA_ATTR_DEV_BLK_CFG_SIZE_MAX ?
> I have tried this before, but this macro is too long causing a odd format in
> the header file.
> 
> I can change this since you point this out. This is uapi means we should
> merge the
> fix during the RC release before 6.9 official.
> 
> @MST, does the process work for you?


I'm fine applying a fixup patch. Yes it's preferable to make changed
before the release.

> > 
> > > +}
> > > +
> > > static int vdpa_dev_blk_config_fill(struct vdpa_device *vdev,
> > >                     struct sk_buff *msg)
> > > {
> > > @@ -973,6 +987,9 @@ static int vdpa_dev_blk_config_fill(struct
> > > vdpa_device *vdev,
> > >     if (vdpa_dev_blk_capacity_config_fill(msg, &config))
> > >         return -EMSGSIZE;
> > > 
> > > +    if (vdpa_dev_blk_seg_size_config_fill(msg, features_device,
> > > &config))
> > > +        return -EMSGSIZE;
> > > +
> > >     return 0;
> > > }
> > > 
> > > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > > index 1bf69226cb96..586bce3c906a 100644
> > > --- a/include/uapi/linux/vdpa.h
> > > +++ b/include/uapi/linux/vdpa.h
> > > @@ -57,6 +57,7 @@ enum vdpa_attr {
> > >     VDPA_ATTR_DEV_FEATURES,                 /* u64 */
> > > 
> > >     VDPA_ATTR_DEV_BLK_CFG_CAPACITY,        /* u64 */
> > > +    VDPA_ATTR_DEV_BLK_CFG_SEG_SIZE,        /* u32 */
> > > 
> > >     /* new attributes must be added above here */
> > >     VDPA_ATTR_MAX,
> > > -- 
> > > 2.39.3
> > > 
> > > 
> > 
> > 

