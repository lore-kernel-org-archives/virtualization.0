Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4443C154C04
	for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 09:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712741236; cv=none; b=ZaMT8MsGStzpbh+aODnzV43KS9k545tX27KNWjBIdCAR7LKz953HEFQalweHfwjuM3pUjT20hNdUTSNvFkkFrAxvR8Of0OZaJV+HtUcL8qa6wR6dBYFxwiNrTNVAYB5da8pWJQL4Qo5wbrD9MH+19e02wsk4i1wLrv19mcAUtRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712741236; c=relaxed/simple;
	bh=fcElBr/fQ4jTUM/R9mh4OCeXuheb7dMyysRCnNaeaU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=tEETXKFOwUz4vQEXZqbnTRKxWHBzhk+tNM27/XOY3W58DggPBG/uOyiyxESUboT3OVyjMavnOtxFNKTDFpmMw7QnhO2n9RbSkr3N346VObSKmg76FGPiM2yYQkflqEt9AMy7uPaiSFhXm96SRZuAfMqGg5c1n4DIh8buD4gNMgw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f8zyFLBu; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f8zyFLBu"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1712741233;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=nd8Bsk/tl0jIPK4UNvuIu/hIN0VvXZcDRh7sv/2CcB8=;
	b=f8zyFLBuO8HWp46sLDfbupygK/kzj1ZlBEWcElAqmVIiPaEmlxIe6Ck3jXyEBDlu1yNQbl
	rpiOPmog0fyWjXGABFx8z+1YUPPiOqsFJtDlojC2O82LL+JVPhBW8iXGJEgbkOiILOE+3C
	Gdk6aI+q2IRU2kqxsbwoeDCWZ1Dbc6Q=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-QqP1wGP2PlSK6VrdqdPlUA-1; Wed, 10 Apr 2024 05:27:11 -0400
X-MC-Unique: QqP1wGP2PlSK6VrdqdPlUA-1
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-343c6a990dbso2772055f8f.1
        for <virtualization@lists.linux.dev>; Wed, 10 Apr 2024 02:27:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712741230; x=1713346030;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nd8Bsk/tl0jIPK4UNvuIu/hIN0VvXZcDRh7sv/2CcB8=;
        b=ZxPBXOkkUjCsYN7BylMPtPSHk3zczKVddTxcD3/IzGFmvf+9cRTagdTr955TN0kzAY
         TsvcqWqFAuiDnLrHKDZvwInP0IR+Ycm/Ixk+EKdKNyl9QO5ObEb4bi94aOOmZJFE5XBi
         AL09EwOauqTdrQjB3Y6TZ8wZVphV8BTeX74ArubQ2nJsteNWt1JakrhqlSPoF36+ZMlZ
         AfrDJqHmuF7GDb3FNHOfsOb+qQLtGJEOJRzHf2lx37NuTO4f+agL/UzArmC3S7QffyDx
         sNTMfEubw+qgRka8YwrvU/Is/Dv/a5BFcvT0f3oE7nXRjoR+6EA/EqLUsoSfBHmDzAYU
         3usQ==
X-Forwarded-Encrypted: i=1; AJvYcCXWsJ0nbuKnjeK/U/rLvB0QoaZ39ZqXab2WyJYBxoTS50ADZdL+ZDoXejhvfcTpYMTCl7hIhwj4xP9nDgn3cdudzgsvi1ExYOVfzT/PaWQ=
X-Gm-Message-State: AOJu0YyXvz0066Y2gWI58VzFXS6tVXrkMJnQu73nx4Shf0s65EG7qpaT
	vYG6QwKmYDmyuGPYgS2A2VKJ629T49dyY4Wqj7nYKpKPgov7dPm7ARX0Jxsn691QtASzsegnKut
	6na0Ng4wqSJHvLd6buX2FD0NuVj5lk3FI3E+GACVk2zegdTC1VDiqyh8etuCZPQBR
X-Received: by 2002:a5d:6745:0:b0:345:a63d:4a2f with SMTP id l5-20020a5d6745000000b00345a63d4a2fmr1877944wrw.0.1712741230379;
        Wed, 10 Apr 2024 02:27:10 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE3+y5ZERWEdESiEjio8GX2kelNJq0swIWK3VLPt2UUg+ayvq6dp08tl4HhVGaBB1GqEVjkmw==
X-Received: by 2002:a5d:6745:0:b0:345:a63d:4a2f with SMTP id l5-20020a5d6745000000b00345a63d4a2fmr1877923wrw.0.1712741229842;
        Wed, 10 Apr 2024 02:27:09 -0700 (PDT)
Received: from redhat.com ([2a02:14f:179:8bde:8cd:63ff:6fae:3872])
        by smtp.gmail.com with ESMTPSA id q23-20020adfab17000000b003437799a373sm13564087wrc.83.2024.04.10.02.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Apr 2024 02:27:09 -0700 (PDT)
Date: Wed, 10 Apr 2024 05:27:05 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Zhu Lingshan <lingshan.zhu@intel.com>
Cc: sgarzare@redhat.com, jasowang@redhat.com,
	virtualization@lists.linux.dev
Subject: Re: [PATCH] vDPA: code clean for vhost_vdpa uapi
Message-ID: <20240410052059-mutt-send-email-mst@kernel.org>
References: <20240410163716.699708-1-lingshan.zhu@intel.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240410163716.699708-1-lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Apr 11, 2024 at 12:37:16AM +0800, Zhu Lingshan wrote:
> This commit cleans up the upai for vhost_vdpa by
> better naming some of the macros which report blk
> information to user space.
> 
> Signed-off-by: Zhu Lingshan <lingshan.zhu@intel.com>

These are enums not macros.

And tweaking UAPI is problematic as it can break userspace
builds. If you do this you need a #define for the old name
to avoid that issue.

> ---
>  drivers/vdpa/vdpa.c       | 6 +++---
>  include/uapi/linux/vdpa.h | 6 +++---
>  2 files changed, 6 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
> index b246067e074b..6cb96a1e8b7d 100644
> --- a/drivers/vdpa/vdpa.c
> +++ b/drivers/vdpa/vdpa.c
> @@ -967,7 +967,7 @@ vdpa_dev_blk_seg_size_config_fill(struct sk_buff *msg, u64 features,
>  
>  	val_u32 = __virtio32_to_cpu(true, config->size_max);
>  
> -	return nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_SEG_SIZE, val_u32);
> +	return nla_put_u32(msg, VDPA_ATTR_DEV_BLK_CFG_SIZE_MAX, val_u32);
>  }
>  
>  /* fill the block size*/
> @@ -1089,7 +1089,7 @@ static int vdpa_dev_blk_ro_config_fill(struct sk_buff *msg, u64 features)
>  	u8 ro;
>  
>  	ro = ((features & BIT_ULL(VIRTIO_BLK_F_RO)) == 0) ? 0 : 1;
> -	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_CFG_READ_ONLY, ro))
> +	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_READ_ONLY, ro))
>  		return -EMSGSIZE;
>  
>  	return 0;
> @@ -1100,7 +1100,7 @@ static int vdpa_dev_blk_flush_config_fill(struct sk_buff *msg, u64 features)
>  	u8 flush;
>  
>  	flush = ((features & BIT_ULL(VIRTIO_BLK_F_FLUSH)) == 0) ? 0 : 1;
> -	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_CFG_FLUSH, flush))
> +	if (nla_put_u8(msg, VDPA_ATTR_DEV_BLK_FLUSH, flush))
>  		return -EMSGSIZE;
>  
>  	return 0;
> diff --git a/include/uapi/linux/vdpa.h b/include/uapi/linux/vdpa.h
> index 43c51698195c..842bf1201ac4 100644
> --- a/include/uapi/linux/vdpa.h
> +++ b/include/uapi/linux/vdpa.h
> @@ -57,7 +57,7 @@ enum vdpa_attr {
>  	VDPA_ATTR_DEV_FEATURES,                 /* u64 */
>  
>  	VDPA_ATTR_DEV_BLK_CFG_CAPACITY,		/* u64 */
> -	VDPA_ATTR_DEV_BLK_CFG_SEG_SIZE,		/* u32 */
> +	VDPA_ATTR_DEV_BLK_CFG_SIZE_MAX,		/* u32 */
>  	VDPA_ATTR_DEV_BLK_CFG_BLK_SIZE,		/* u32 */
>  	VDPA_ATTR_DEV_BLK_CFG_SEG_MAX,		/* u32 */
>  	VDPA_ATTR_DEV_BLK_CFG_NUM_QUEUES,	/* u16 */
> @@ -70,8 +70,8 @@ enum vdpa_attr {
>  	VDPA_ATTR_DEV_BLK_CFG_DISCARD_SEC_ALIGN,/* u32 */
>  	VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEC,	/* u32 */
>  	VDPA_ATTR_DEV_BLK_CFG_MAX_WRITE_ZEROES_SEG,	/* u32 */
> -	VDPA_ATTR_DEV_BLK_CFG_READ_ONLY,		/* u8 */
> -	VDPA_ATTR_DEV_BLK_CFG_FLUSH,		/* u8 */
> +	VDPA_ATTR_DEV_BLK_READ_ONLY,		/* u8 */
> +	VDPA_ATTR_DEV_BLK_FLUSH,		/* u8 */
>  
>  	/* new attributes must be added above here */
>  	VDPA_ATTR_MAX,
> -- 
> 2.39.3

