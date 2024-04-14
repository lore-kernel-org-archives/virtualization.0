Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F11FF21A19
	for <virtualization@lists.linux.dev>; Sun, 14 Apr 2024 08:28:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713083302; cv=none; b=NAgtk3DjJLj7+oXjYw+J88rNfLbLk/pIg09PJC5PF875MmU5wF4U569gQymdyNIJb6+V6LMWlOe/e10OV6+Mh2rH+9+g+pA3PU6aL/KXMu/VPXhACQw17aIamgNTrxDyxRsQvZAzny4bvn1QgGZgdtTPnFNXycNEO2Eg9Ar2aZY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713083302; c=relaxed/simple;
	bh=SE3F9TbB1avS9hf79AXENyTaieZhR1mMsyuMJrj3tsA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=o3Y9tft2yzKIjXBHfyb89CBLi00g5zJiwV3/1jCPgQkcMrUvVG+vjcYHhEaBq5MXHQ7SM1hrOwn7gdOggbGEY4vhgrbEixhXNH69MzTfHCeog1XhxQd0X+NH9qSYSHbw3fsfS/Fr9Sgd9LoiWF+rnhwQoJv0q5TUXb/fTlalSzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FpFUAiDk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FpFUAiDk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1713083299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=EChjziFecLnZQ56CpOVya3UvT/k9zByf8JlyR24WnXA=;
	b=FpFUAiDkRee67L8ks0NbXWKmewF0Vu49vFS+oWjiqZIthW+k0BgjHNgDCFrJeJyucxMoH6
	ZT9LE04QTOH9wyDUl24qV4OLLJLvEuuWfWOV6c+iJ4OeN9zws9RO/uETsYMcxPWrGkImBr
	ftSVMT0T31YyoMLwQGnWsyUCOdSP0IA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-374-pEaiWD3mOQu-uiimpbx4Tw-1; Sun, 14 Apr 2024 04:28:18 -0400
X-MC-Unique: pEaiWD3mOQu-uiimpbx4Tw-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-418591f78d2so15895e9.2
        for <virtualization@lists.linux.dev>; Sun, 14 Apr 2024 01:28:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713083297; x=1713688097;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EChjziFecLnZQ56CpOVya3UvT/k9zByf8JlyR24WnXA=;
        b=PkWLJRjj6rKobQtgTqiSP+8c+G7Ve0Tpp9hAB1aoKSndsji7cJ+UMjgNxF6Y8BD+lO
         6uDkqqYvXVe4xmSvgUADlPCdtmP6iMXqynw1HbUqUtoEet1KSrl1OM6cbsy1DFSqvCIB
         JuJqTDOfd+Nzu/5F5AVG18Imnlpa1uBLTgpHSTf4yFA0eHf5ca6U/zGyvFt4dAMfXS7A
         9IfRGakxvALE53cB1oGIQmztvnyvIljwCZOIVc9Xdt+1XnI6BWZkMNwKokclOVRHRJYK
         vPQSP97/L4UG9OYx8f0vBxhppZ96k7s4y1sNUiO350Tp07kWafk6BsggQAUcKNcAxhVW
         8YZA==
X-Forwarded-Encrypted: i=1; AJvYcCXP3+fRMy0njtoEJSQLq3uWC0CIa7v5j2bX5ChtMJIRPngyKSazrwzaqdbI4DMw8B+lI9RClm2S2/HLUK/O0D6dkCluACsnAkpcZ7sTcyk=
X-Gm-Message-State: AOJu0YyTcgYQt0/ZUBZG/1G29vldtl7U6IOgtjBsthQcMkJP552IgP5r
	mNHwGINVMGYpTkJK4BQZZAsBOWec8R0edEVlC918G1oqptZI7t6uZAa8lp77N3WnjXNost0S5Gr
	0WxxKI3JiXIJjNBZTnKvMyiFKC+lVkz8wTLfb3KGGGx3EsTHmSd4GKn9a0lWYs0yR
X-Received: by 2002:a05:600c:350a:b0:417:f527:21d0 with SMTP id h10-20020a05600c350a00b00417f52721d0mr5961814wmq.0.1713083297215;
        Sun, 14 Apr 2024 01:28:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsjh8TYe3mid09TS/q1PNBpoVjP6d/XHu5t2si06LpShN6tv+zwlhxzZgs7BtytswS34wakw==
X-Received: by 2002:a05:600c:350a:b0:417:f527:21d0 with SMTP id h10-20020a05600c350a00b00417f52721d0mr5961796wmq.0.1713083296637;
        Sun, 14 Apr 2024 01:28:16 -0700 (PDT)
Received: from redhat.com ([31.187.78.68])
        by smtp.gmail.com with ESMTPSA id p12-20020a05600c1d8c00b004184e3b7c03sm925019wms.0.2024.04.14.01.28.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Apr 2024 01:28:16 -0700 (PDT)
Date: Sun, 14 Apr 2024 04:28:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: sgarzare@redhat.com, jasowang@redhat.com,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] vDPA: code clean for vhost_vdpa uapi
Message-ID: <20240414042538-mutt-send-email-mst@kernel.org>
References: <20240410163716.699708-1-lingshan.zhu@intel.com>
 <20240410052059-mutt-send-email-mst@kernel.org>
 <1d6a5761-3a5a-4de8-8472-9a4dbb2db6b6@intel.com>
 <20240411020502-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240411020502-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 11, 2024 at 02:05:57AM -0400, Michael S. Tsirkin wrote:
> On Thu, Apr 11, 2024 at 10:19:38AM +0800, Zhu, Lingshan wrote:
> > 
> > 
> > On 4/10/2024 5:27 PM, Michael S. Tsirkin wrote:
> > > On Thu, Apr 11, 2024 at 12:37:16AM +0800, Zhu Lingshan wrote:
> > > > This commit cleans up the upai for vhost_vdpa by
> > > > better naming some of the macros which report blk
> > > > information to user space.
> > > > 
> > > > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > > These are enums not macros.
> > > 
> > > And tweaking UAPI is problematic as it can break userspace
> > > builds. If you do this you need a #define for the old name
> > > to avoid that issue.
> > The enums are not in 6.9 official release yet, so we have a chance and
> > agreed
> > to deliver a fix during RC stage.
> > 
> > https://lore.kernel.org/all/20240331160230-mutt-send-email-mst@kernel.org/
> > 
> > Shall I post a V2 for better commit message: macros --> enums?
> > 
> > Thanks
> > Zhu Lingshan
> 
> 
> Pls do. Add a Fixes: tag listing the commits that introduced them.
> And mention that it wasn't in any releases.


Still waiting for this. Note I keep changes in next for several days
so there's a chance to shake out bugs, and if I send a pull
at the last minute it might not make it in the release.
We'll then not be able to make these changes to avoid breaking
userspace builds.


> > > 
> > > > ---
> > > >   drivers/vdpa/vdpa.c       | 6 +++---
> > > >   include/uapi/linux/vdpa.h | 6 +++---
> > > >   2 files changed, 6 insertions(+), 6 deletions(-)
> > > > 
> > > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > > index b246067e074b..6cb96a1e8b7d 100644
> > > > --- a/drivers/vdpa/vdpa.c
> > > > +++ b/drivers/vdpa/vdpa.c
> > > > @@ -967,7 +967,7 @@ vdpa_dev_blk_seg_size_config_fill(struct sk_buff *msg, u64 features,
> > > >   	val_u32 = __virtio32_to_cpu(true, config->size_max);
> > > > -	return nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_SEG_SIZE, val_u32);
> > > > +	return nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_SIZE_MAX, val_u32);
> > > >   }
> > > >   /* fill the block size*/
> > > > @@ -1089,7 +1089,7 @@ static int vdpa_dev_blk_ro_config_fill(struct sk_buff *msg, u64 features)
> > > >   	u8 ro;
> > > >   	ro = ((features & BIT_ULL(VIRTIO_BLK_F_RO)) == 0) ? 0 : 1;
> > > > -	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_CFG_READ_ONLY, ro))
> > > > +	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_READ_ONLY, ro))
> > > >   		return -EMSGSIZE;
> > > >   	return 0;
> > > > @@ -1100,7 +1100,7 @@ static int vdpa_dev_blk_flush_config_fill(struct sk_buff *msg, u64 features)
> > > >   	u8 flush;
> > > >   	flush = ((features & BIT_ULL(VIRTIO_BLK_F_FLUSH)) == 0) ? 0 : 1;
> > > > -	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_CFG_FLUSH, flush))
> > > > +	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_FLUSH, flush))
> > > >   		return -EMSGSIZE;
> > > >   	return 0;
> > > > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > > > index 43c51698195c..842bf1201ac4 100644
> > > > --- a/include/uapi/linux/vdpa.h
> > > > +++ b/include/uapi/linux/vdpa.h
> > > > @@ -57,7 +57,7 @@ enum vdpa_attr {
> > > >   	VDPA_ATTR_DEV_FEATURES,                 /* u64 */
> > > >   	VDPA_ATTR_DEV_BLK_CFG_CAPACITY,		/* u64 */
> > > > -	VDPA_ATTR_DEV_BLK_CFG_SEG_SIZE,		/* u32 */
> > > > +	VDPA_ATTR_DEV_BLK_CFG_SIZE_MAX,		/* u32 */
> > > >   	VDPA_ATTR_DEV_BLK_CFG_BLK_SIZE,		/* u32 */
> > > >   	VDPA_ATTR_DEV_BLK_CFG_SEG_MAX,		/* u32 */
> > > >   	VDPA_ATTR_DEV_BLK_CFG_NUM_QUEUES,	/* u16 */
> > > > @@ -70,8 +70,8 @@ enum vdpa_attr {
> > > >   	VDPA_ATTR_DEV_BLK_CFG_DISCARD_SEC_ALIGN,/* u32 */
> > > >   	VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEC,	/* u32 */
> > > >   	VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEG,	/* u32 */
> > > > -	VDPA_ATTR_DEV_BLK_CFG_READ_ONLY,		/* u8 */
> > > > -	VDPA_ATTR_DEV_BLK_CFG_FLUSH,		/* u8 */
> > > > +	VDPA_ATTR_DEV_BLK_READ_ONLY,		/* u8 */
> > > > +	VDPA_ATTR_DEV_BLK_FLUSH,		/* u8 */
> > > >   	/* new attributes must be added above here */
> > > >   	VDPA_ATTR_MAX,
> > > > -- 
> > > > 2.39.3

