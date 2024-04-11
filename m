Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76A4D13C9DF
	for <virtualization@lists.linux.dev>; Thu, 11 Apr 2024 06:06:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712815564; cv=none; b=tZ/EY8NQAq+HRTWxbJNPS/hnlG+UBXyMOGbFfDZ0NBnWt9pzHvPxdPb+sOvkV1T6d61dh0K7+taGgpCaE1uL95dwpTKhLakD2PPehLwSsKRbADwyxQfsyaZfRCTrNOrD8I5aZtPudX7Cmt17lhGcZT1ayppBTahixiVCF1Z1BAY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712815564; c=relaxed/simple;
	bh=cQ9QnQ/MUicueM0BUoJIlrDkMPBiJieqj6M2nisKMUU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=IqrQjR4qPgf0D/L073L4lFiqwJd0NdVbfiRbaJ4qOmwzBeM4MyXeWV/+TZuqEzRRv9qVbQlgA7XkueZls2GhbTfj1OHCwYZTPZIM/b/E0/L6xu4oXUlr1OChUu6C1knXs/kcr2rpJliMbJNzRBMm7iQ/ewjzf6dlYZ1+rc3Er2A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=OhZJY4Cx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="OhZJY4Cx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712815561;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=8ImEgrGdLsDYvaLmxDzR3mVu85nDEup4xskw1ao362c=;
	b=OhZJY4Cx1RDOecS9TtiamdfqjgufiRosBZdO0hfzLGlsrDSIPSnCvY51tWX4w5v0GW7Tiz
	/LW535ewbijixuPoH8/A1wgMs6WrAEyhoY3JktMgAg/0cWWDCNO9z7rrt+LFRjillLgtZ/
	PYYdkMTIBw/VFh2KpOTRgJDucjkTvYo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-325-OBMfjiKRPqOliVUT92nfCw-1; Thu, 11 Apr 2024 02:05:59 -0400
X-MC-Unique: OBMfjiKRPqOliVUT92nfCw-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-343bc1e4ecdso1982733f8f.3
        for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 23:05:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712815558; x=1713420358;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8ImEgrGdLsDYvaLmxDzR3mVu85nDEup4xskw1ao362c=;
        b=BLQR/vJghaOjyLk/KAHu4hEhgdRg16TfArK3wQb6qp152Q2mVVsU9tuSd2BcNXuUEf
         vxdMHBQombFs1sw175oCoWDDjjZqJ7uxxhYuQ+PRMS04NE2Y9N7unrGejDr7VHn0w3G8
         Gzopdt0pRYYqMu+6km0/u5zLMVluzBYJ6vL3a+hm2hHla4g/XsKIderKtL484gx8Qp7d
         f0DqVUkAM4gWBF6FCR6HWwuKWXkNKgL7wv4xO78oKZf72NBqXnQfQbWS73cvBGtoW621
         oz19CnUanFSv7UXjYH1pfvBo2oHoxuZ2cJTrXLQctZpEQ3bGzis1EUbHmuugZPOFsQr+
         YP5g==
X-Forwarded-Encrypted: i=1; AJvYcCUOzSuGTqD4AZHr7xUysXEtxYE007l2KSJUs+6Xd3GQ9jUxEb+AiiKpdDi2fBghFMqNGdopOC81c7bFU+JGOPl19LRKq1GhojFsLORRHug=
X-Gm-Message-State: AOJu0Yye+8D7PBwvPFi5xWUc7ywwbwiexqf/1GcEuIiM2iqNfSMH9VKW
	iC1OB4c4MJEWgLKDKrMA4TOKUPBe5JYlMgpwgzGSJQhQ4P1mX33CwqtRjOLtKTW9dbVPqQLpXKk
	OHF+tZ88WK+sdZENPcoPWjdoJM8dY/BsG/MxaybSNzE2yh/tx9Czu3BwNFuXKyMMb
X-Received: by 2002:a05:6000:c81:b0:343:a098:f41 with SMTP id dp1-20020a0560000c8100b00343a0980f41mr3162944wrb.28.1712815558172;
        Wed, 10 Apr 2024 23:05:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHhPC02y4D8o+y6L8sp6E0lekKAN4G6kg+efgguz1Jw4jeHKHOzOiD4ikHqD6uNt9aXvDNqhw==
X-Received: by 2002:a05:6000:c81:b0:343:a098:f41 with SMTP id dp1-20020a0560000c8100b00343a0980f41mr3162927wrb.28.1712815557668;
        Wed, 10 Apr 2024 23:05:57 -0700 (PDT)
Received: from redhat.com ([2a02:14f:1fa:c0af:5382:6fae:1fbb:660f])
        by smtp.gmail.com with ESMTPSA id d27-20020adfa41b000000b00346bc5da705sm722969wra.16.2024.04.10.23.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 23:05:57 -0700 (PDT)
Date: Thu, 11 Apr 2024 02:05:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
Cc: sgarzare@redhat.com, jasowang@redhat.com,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] vDPA: code clean for vhost_vdpa uapi
Message-ID: <20240411020502-mutt-send-email-mst@kernel.org>
References: <20240410163716.699708-1-lingshan.zhu@intel.com>
 <20240410052059-mutt-send-email-mst@kernel.org>
 <1d6a5761-3a5a-4de8-8472-9a4dbb2db6b6@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1d6a5761-3a5a-4de8-8472-9a4dbb2db6b6@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 11, 2024 at 10:19:38AM +0800, Zhu, Lingshan wrote:
> 
> 
> On 4/10/2024 5:27 PM, Michael S. Tsirkin wrote:
> > On Thu, Apr 11, 2024 at 12:37:16AM +0800, Zhu Lingshan wrote:
> > > This commit cleans up the upai for vhost_vdpa by
> > > better naming some of the macros which report blk
> > > information to user space.
> > > 
> > > Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>
> > These are enums not macros.
> > 
> > And tweaking UAPI is problematic as it can break userspace
> > builds. If you do this you need a #define for the old name
> > to avoid that issue.
> The enums are not in 6.9 official release yet, so we have a chance and
> agreed
> to deliver a fix during RC stage.
> 
> https://lore.kernel.org/all/20240331160230-mutt-send-email-mst@kernel.org/
> 
> Shall I post a V2 for better commit message: macros --> enums?
> 
> Thanks
> Zhu Lingshan


Pls do. Add a Fixes: tag listing the commits that introduced them.
And mention that it wasn't in any releases.

> > 
> > > ---
> > >   drivers/vdpa/vdpa.c       | 6 +++---
> > >   include/uapi/linux/vdpa.h | 6 +++---
> > >   2 files changed, 6 insertions(+), 6 deletions(-)
> > > 
> > > diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> > > index b246067e074b..6cb96a1e8b7d 100644
> > > --- a/drivers/vdpa/vdpa.c
> > > +++ b/drivers/vdpa/vdpa.c
> > > @@ -967,7 +967,7 @@ vdpa_dev_blk_seg_size_config_fill(struct sk_buff *msg, u64 features,
> > >   	val_u32 = __virtio32_to_cpu(true, config->size_max);
> > > -	return nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_SEG_SIZE, val_u32);
> > > +	return nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_SIZE_MAX, val_u32);
> > >   }
> > >   /* fill the block size*/
> > > @@ -1089,7 +1089,7 @@ static int vdpa_dev_blk_ro_config_fill(struct sk_buff *msg, u64 features)
> > >   	u8 ro;
> > >   	ro = ((features & BIT_ULL(VIRTIO_BLK_F_RO)) == 0) ? 0 : 1;
> > > -	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_CFG_READ_ONLY, ro))
> > > +	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_READ_ONLY, ro))
> > >   		return -EMSGSIZE;
> > >   	return 0;
> > > @@ -1100,7 +1100,7 @@ static int vdpa_dev_blk_flush_config_fill(struct sk_buff *msg, u64 features)
> > >   	u8 flush;
> > >   	flush = ((features & BIT_ULL(VIRTIO_BLK_F_FLUSH)) == 0) ? 0 : 1;
> > > -	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_CFG_FLUSH, flush))
> > > +	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_FLUSH, flush))
> > >   		return -EMSGSIZE;
> > >   	return 0;
> > > diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> > > index 43c51698195c..842bf1201ac4 100644
> > > --- a/include/uapi/linux/vdpa.h
> > > +++ b/include/uapi/linux/vdpa.h
> > > @@ -57,7 +57,7 @@ enum vdpa_attr {
> > >   	VDPA_ATTR_DEV_FEATURES,                 /* u64 */
> > >   	VDPA_ATTR_DEV_BLK_CFG_CAPACITY,		/* u64 */
> > > -	VDPA_ATTR_DEV_BLK_CFG_SEG_SIZE,		/* u32 */
> > > +	VDPA_ATTR_DEV_BLK_CFG_SIZE_MAX,		/* u32 */
> > >   	VDPA_ATTR_DEV_BLK_CFG_BLK_SIZE,		/* u32 */
> > >   	VDPA_ATTR_DEV_BLK_CFG_SEG_MAX,		/* u32 */
> > >   	VDPA_ATTR_DEV_BLK_CFG_NUM_QUEUES,	/* u16 */
> > > @@ -70,8 +70,8 @@ enum vdpa_attr {
> > >   	VDPA_ATTR_DEV_BLK_CFG_DISCARD_SEC_ALIGN,/* u32 */
> > >   	VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEC,	/* u32 */
> > >   	VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEG,	/* u32 */
> > > -	VDPA_ATTR_DEV_BLK_CFG_READ_ONLY,		/* u8 */
> > > -	VDPA_ATTR_DEV_BLK_CFG_FLUSH,		/* u8 */
> > > +	VDPA_ATTR_DEV_BLK_READ_ONLY,		/* u8 */
> > > +	VDPA_ATTR_DEV_BLK_FLUSH,		/* u8 */
> > >   	/* new attributes must be added above here */
> > >   	VDPA_ATTR_MAX,
> > > -- 
> > > 2.39.3

