Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2EC26A08A
	for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 21:54:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782338061; cv=none; b=bLOW0w4kRAADj6SjR1KQeRROIgpejalB9vBzTB1eXMR5BCz4WXWHuejKOFKrBXWUc3iuiXJJN7XQ08ddVkcAEKW9oA8NtSkBMnqJc7qJ+nS2HW0qZS7PWS4EhGyRlJrBD5GPPd20uMokOiZKsO5K6jzNeUuu1o8PAPRVC27CggM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782338061; c=relaxed/simple;
	bh=YEH0ivn6OIsDyjtX0rImX+2K0Q3ZGkW8hP4mvHsm9Gw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=HkQIkWoj6gJCoYPADQ8CAsfTdh+OzR8/5O8E+IMzcuSuofhesT4t8jI7wGCDJTJxZhE7RP0kqmc45rI+DDKOw+ndfv6NVAeHV/B7hKY0BweW00Wi5T+nJu9LsNQjb7bfywMHV4NB6VPvdghzOLhBizLom831EB5RjGdDze+LI8U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FRQ6UBDJ; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FRQ6UBDJ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782338059;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BDvcN2LNdN+d8LE14HUcEEpxSiVmThGnJVY9yWwMAdc=;
	b=FRQ6UBDJye1UsaXQoZdBBv1Tj3gEI1GXvWtAFjvTq35RjnUCOGyRPmm9LfMYoj3q6LUMDa
	zjHYoCQC8NLcg3gWlaID/jUAyVfwMqRyA602HBhSq7iDmCWHekc1vTktHOMkE+UPxnYbCy
	paDWkf4Nu0fg4Hx1sfwem0ck4QX3iV8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-36-CHE6u_5LPtSlMYsX1FaN3Q-1; Wed, 24 Jun 2026 17:54:18 -0400
X-MC-Unique: CHE6u_5LPtSlMYsX1FaN3Q-1
X-Mimecast-MFC-AGG-ID: CHE6u_5LPtSlMYsX1FaN3Q_1782338057
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-492488f8583so14371035e9.2
        for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 14:54:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782338057; x=1782942857;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BDvcN2LNdN+d8LE14HUcEEpxSiVmThGnJVY9yWwMAdc=;
        b=Nh6sXsXyw5anmnd11i9V26cHVy/xIjLWIQV2jzLxn4PamKlXXAw+V6CiRLhLftR3Cy
         tzh+diCsx6wxLvzheFAuCF6tXdOoRnSN3BCULgZ10k0uEy+rAl4NApboEQo8F/exbOWA
         umRLS26xRLHa9gvYr6XwTHUoIQ/CFglGKdnCPzc2/elLW8JuwO8whkZ/6jj/kX0uWjky
         9nMsto1K/4ZxXIXF+yWpSgSVOBlLhVhD/zFYXfv4DZDEanaZfONuggyzQeHyCTvyTbfx
         uGcE9UrC8m3bhkasajCZH6KjSilQjkemAIMeIY9rSP5bacxiTzWZ49E30TTQhN3MfOkw
         bKNg==
X-Forwarded-Encrypted: i=1; AFNElJ9T/qPWlALyOi7zbIxLCBdePXn6eDCJS6pyb3dktXm3yuVri4RG06aegfuAatcIcRoFQUbvjreLKswPBds+4g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxwDdTRu59lsZwlqI1y2IuA8jCxIf5+I62WibsnghUTG/Ldg6U7
	aBOhwh5uqWlZ0Tq+So6azLdpjUHpRG1d2mtiZrQlTLPTXLyREQ6LjBHCGVwwOPJ7txcc1PE2cqF
	EwlAe9AF5Y/v3v7Jec0PLhS8ZZh4z1lrHJO4L1OHk8wnq1BPPNijz4eXyWxqmqevcNELh
X-Gm-Gg: AfdE7clnsWDSbKDu7llDKJwskGOzKNOrXSkcBtnrHXdc0yn+wnoQ6F1rQxh3d5gRn8T
	HZutufvKs3VmedUzjH6wuW9hqysX6DTgG1MDILhOVsWsf4ZivBW4CL7BG2pH61lU5fqwmVPo+sL
	giyvyt9CCBN95FFnTKcaS47l187fW41B0SNyH1CNOQOU+iEFP1+I9CLZeXoBJzw+BlmsjllLvae
	FZ02XPpVNwwXuvyiGzSXSdU0kdrc3Yipqmq8b+j56aFSaooB6baqX+9jDJfMo9BaWaq/jna2idq
	vC4OYJ6c2hyfyG2mPfmeME5G1hNvmaNsPjHx7oWfCzQSvkxnS2VNpRTuKl9THNIzrIYDOxgFlp7
	52YlepqSA408FTzVMesZ5tb5DWv/SpkNO
X-Received: by 2002:a05:600c:c118:b0:492:63ff:d577 with SMTP id 5b1f17b1804b1-49263ffd59bmr15123305e9.27.1782338057077;
        Wed, 24 Jun 2026 14:54:17 -0700 (PDT)
X-Received: by 2002:a05:600c:c118:b0:492:63ff:d577 with SMTP id 5b1f17b1804b1-49263ffd59bmr15123165e9.27.1782338056620;
        Wed, 24 Jun 2026 14:54:16 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-46c221d93d8sm17353516f8f.23.2026.06.24.14.54.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 14:54:15 -0700 (PDT)
Date: Wed, 24 Jun 2026 17:54:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yousef Alhouseen <alhouseenyousef@gmail.com>
Cc: Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] vhost/vdpa: reject overflowing PA map page counts on
 32-bit
Message-ID: <20260624175356-mutt-send-email-mst@kernel.org>
References: <CAMuQ4bURwyoJtKUskzXpbUtrxXT1vBZZxpKpnnJY6qWsLtTBMA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAMuQ4bURwyoJtKUskzXpbUtrxXT1vBZZxpKpnnJY6qWsLtTBMA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: ZT5xa6vrR6dANM-uVJe-pv_wxnMajjnp-uQHRpIEIcY_1782338057
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Jun 24, 2026 at 02:51:53PM -0700, Yousef Alhouseen wrote:
> vhost_vdpa_pa_map() adds the IOVA page offset to the user-controlled map
> size before computing the number of pages to pin. On 32-bit systems,
> where unsigned long is narrower than u64, that addition can overflow and
> the code can pin and map fewer pages than the requested IOTLB range.
> 
> Reject sizes that overflow the unsigned long page-count calculation.
> 


And a Fixes: tag, please.

> Signed-off-by: Yousef Alhouseen <alhouseenyousef@gmail.com>
> ---
> Changes in v2:
> - Clarify that the overflow is on 32-bit systems.
> - Drop the unrelated memlock check change.
> 
>  drivers/vhost/vdpa.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/vhost/vdpa.c b/drivers/vhost/vdpa.c
> index ac55275fa..38b28ed3d 100644
> --- a/drivers/vhost/vdpa.c
> +++ b/drivers/vhost/vdpa.c
> @@ -1102,6 +1102,7 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>  	unsigned int gup_flags = FOLL_LONGTERM;
>  	unsigned long npages, cur_base, map_pfn, last_pfn = 0;
>  	unsigned long lock_limit, sz2pin, nchunks, i;
> +	unsigned long page_offset;
>  	u64 start = iova;
>  	long pinned;
>  	int ret = 0;
> @@ -1114,7 +1115,13 @@ static int vhost_vdpa_pa_map(struct vhost_vdpa *v,
>  	if (perm & VHOST_ACCESS_WO)
>  		gup_flags |= FOLL_WRITE;
> 
> -	npages = PFN_UP(size + (iova & ~PAGE_MASK));
> +	page_offset = iova & ~PAGE_MASK;
> +	if (size > ULONG_MAX - page_offset) {
> +		ret = -EINVAL;
> +		goto free;
> +	}
> +
> +	npages = PFN_UP(size + page_offset);
>  	if (!npages) {
>  		ret = -EINVAL;
>  		goto free;
> -- 
> 2.54.0

