Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA70C6FCB
	for <virtualization@lists.linux.dev>; Mon, 29 Apr 2024 07:02:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714374146; cv=none; b=JzA2+vfqbn1SHYxyq0pH4cV6ELASokaBpcpNrYDF8TPW3ify3yDXLSeWEbu8RA9ZYSQqO/kVmEMyU+cnFeMmpG1R2H7NGpasgA0yOp6RxYtsIXQe0jJzcJh86rxy+1YmqH7TpwUYoRj4z1DZVhKaP2Dmvx1CCaeRpPh+ZApMoE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714374146; c=relaxed/simple;
	bh=pogqEdNSBms+a1/+ebRncU/sioC2zzur3n3WfxW6guA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=UFpYMGePtrphDv7hzO5zGLiVlP5b0nE0Mo7KVnBWoRalWwsNUDnu99C2cNV+ZJsJxU1UBeVqYmv/ApToEKAnjgVGBBhr0/38Eiv7rvmwsze9EW4u2ggCPFR1NxhFeA9NNcCc2O3TlNmzXaeDP3WNSk+77VUupZOH3AxnUDFM3oE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gkCNDrUO; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gkCNDrUO"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1714374143;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=2DoxRr+mz0BriEoydrVcRkNlqWUgXwM3/o76Mys3JDE=;
	b=gkCNDrUOjVQsAXpFhOoPx4vmQR5n1SFgQqRIdjjdVb/uWv1Oooy0ae1McREIng+k6dB7xx
	1HYCyyxkzgeYzJMVRh0ZEzh7hNS1RgD88tYrQMs9SyUZylpaj6T7d9/085a27b8RdphX8z
	9Gq4ruoa40B7x7ivmt4bsN9rYxWEAyw=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-498-d2CJnJSENoeh84YvShBNcw-1; Mon, 29 Apr 2024 03:02:21 -0400
X-MC-Unique: d2CJnJSENoeh84YvShBNcw-1
Received: by mail-lj1-f199.google.com with SMTP id 38308e7fff4ca-2da2f30cb50so32614011fa.2
        for <virtualization@lists.linux.dev>; Mon, 29 Apr 2024 00:02:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714374140; x=1714978940;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2DoxRr+mz0BriEoydrVcRkNlqWUgXwM3/o76Mys3JDE=;
        b=Qkoa6oiUfSiRDE7PlGkNTYxtPrJUYI0LUxHw/oDG6jnBWr8ltth5kEHyEA1QPyaqfb
         5HPpIsA7oXqIUjqleCAzcGMv057pzZxQcqRe6PBDzFVshqHvsluUIRwd26a0IUYOqh3p
         D9y0C6TkBIY1DhGabf8fo+qIdSrSZ11OUo1PvlvopG1j6j/XnuYrZD4JvTcpCzwyKtQp
         8ihOJUhHvddd8HMmw0/QcuX9j12/v1e54UWO+PQ5mwTyBa8NRSi5IvjXB5dBEE1eXOV1
         b1nfzkSE/gHyKMUbZTv8e8WBRrIdxiYVMXoDN35kpkH6BfYgdu0XxSP3MEA5+t5ouDK3
         9d7g==
X-Gm-Message-State: AOJu0YzfwKMI5BEADoELk9S1R7BZkmo1xZSJpUvCm1MIRaT3LjCTS9Up
	cLV1fvz4xeraXQQlIPOnGeOTrN+lngXLfN5Zux36ykl20YyQIMcHWkjxTnBxg8o5/j20yEYm466
	8XhaImHvFYE3j0o408FwWreYxN9EOtDzOXCevfdLCb+SgT0YAFFBLhVtFOtodae20
X-Received: by 2002:a2e:9858:0:b0:2df:b0e3:b548 with SMTP id e24-20020a2e9858000000b002dfb0e3b548mr3826432ljj.42.1714374139989;
        Mon, 29 Apr 2024 00:02:19 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGuHIAp2n2tfSQLWrLVwFMNH9X760go/jcvnYYzf5sELahjo+ORqasE4j3baWKWjef6Q8qWjQ==
X-Received: by 2002:a2e:9858:0:b0:2df:b0e3:b548 with SMTP id e24-20020a2e9858000000b002dfb0e3b548mr3826328ljj.42.1714374137176;
        Mon, 29 Apr 2024 00:02:17 -0700 (PDT)
Received: from redhat.com ([212.116.168.114])
        by smtp.gmail.com with ESMTPSA id o20-20020a05600c511400b0041a49b10a13sm28190575wms.11.2024.04.29.00.02.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 00:02:16 -0700 (PDT)
Date: Mon, 29 Apr 2024 03:02:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gavin Shan <gshan@redhat.com>
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	jasowang@redhat.com, shan.gavin@gmail.com
Subject: Re: [PATCH 0/4] vhost: Cleanup
Message-ID: <20240429025750-mutt-send-email-mst@kernel.org>
References: <20240423032407.262329-1-gshan@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240423032407.262329-1-gshan@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Apr 23, 2024 at 01:24:03PM +1000, Gavin Shan wrote:
> This is suggested by Michael S. Tsirkin according to [1] and the goal
> is to apply smp_rmb() inside vhost_get_avail_idx() if needed. With it,
> the caller of the function needn't to worry about memory barriers. Since
> we're here, other cleanups are also applied.


Gavin I suggested another approach.
1. Start with the patch I sent (vhost: order avail ring reads after
   index updates) just do a diff against latest.
   simplify error handling a bit.
2. Do any other cleanups on top.

> [1] https://lore.kernel.org/virtualization/20240327075940-mutt-send-email-mst@kernel.org/
> 
> PATCH[1] drops the local variable @last_avail_idx since it's equivalent
>          to vq->last_avail_idx
> PATCH[2] improves vhost_get_avail_idx() so that smp_rmb() is applied if
>          needed. Besides, the sanity checks on the retrieved available
>          queue index are also squeezed to vhost_get_avail_idx()
> PATCH[3] improves vhost_get_avail_head(), similar to what we're doing
>          for vhost_get_avail_idx(), so that the relevant sanity checks
>          on the head are squeezed to vhost_get_avail_head()
> PATCH[4] Reformat vhost_{get, put}_user() by using tab instead of space
>          as the terminator for each line
> 
> Gavin Shan (4):
>   vhost: Drop variable last_avail_idx in vhost_get_vq_desc()
>   vhost: Improve vhost_get_avail_idx() with smp_rmb()
>   vhost: Improve vhost_get_avail_head()
>   vhost: Reformat vhost_{get, put}_user()
> 
>  drivers/vhost/vhost.c | 199 +++++++++++++++++++-----------------------
>  1 file changed, 88 insertions(+), 111 deletions(-)
> 
> -- 
> 2.44.0

