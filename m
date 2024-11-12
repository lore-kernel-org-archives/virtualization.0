Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A26A21A4D0
	for <virtualization@lists.linux.dev>; Tue, 12 Nov 2024 23:07:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731452834; cv=none; b=JgXKN8E0TQPOeS8cj/Nyw5r7j7GjA4DcCWTbA4gwAlCu7V8jDcw0909naj1vHpkbU25vlnhwcUgNfpNsp1YKLe2Nz99TILA5mkbMh69UhLgykkAPTG1XQ6kFzjxZJA2/WGkURuXkugHuWSrosuORbp07sSxr5wO6rJ/lto4v0hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731452834; c=relaxed/simple;
	bh=TFy3fU/4I2GpEadKr7IhLMNlWmHyK3B0PI16A0z0L/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=giQfF574vgxPW79NDZ2lsJggBX1TAxdZAbiaP76AryQ4vpSxSm+b5TONjH4Z3X4Zmt+IDjKlT6Wh05vOnOd+DVI76BtLuzdA9Ny/+D5tuiM9GMzzG4tEYLh4R5BhgvleGNeQpt5sJ2DnAZrhoZKE2VP8vxtDOmbFD/6IGZtVlSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=QDGnReqE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QDGnReqE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731452830;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=LE/PCh+Wa1FzY66oOB8AxWyuC5tcu2XLg9eirKv3WLg=;
	b=QDGnReqEQ3XAqkLIEmkoC2Ty1uKkIfB7QF4uKfBy4wmQY5YK2tnCE07xQG1q8OoyVpay05
	xjGRi7TZx0UJcKqcDcGaFR0Gi/+WpEp7VTcLdxNIs2Wldor0Fmcd/IDlYBD/VSIfNPlUbL
	Uds79oNzSPUka+X4EGzBr7cHeNGv5jc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-516-WjK0ihnQOhKivMg0zfhNAA-1; Tue, 12 Nov 2024 18:07:08 -0500
X-MC-Unique: WjK0ihnQOhKivMg0zfhNAA-1
X-Mimecast-MFC-AGG-ID: WjK0ihnQOhKivMg0zfhNAA
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-431518ae047so644705e9.0
        for <virtualization@lists.linux.dev>; Tue, 12 Nov 2024 15:07:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731452827; x=1732057627;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LE/PCh+Wa1FzY66oOB8AxWyuC5tcu2XLg9eirKv3WLg=;
        b=kdveqSM7sCSC4mtLiEoI9JGAeoeF0j7tnRFTo9hdIo3+YQdPuqmbvD5PGyFnnTYlGQ
         j9r0nZNf7pCvL9XSQl96U7MAwA+0FUJyuklquTDjgD7XpXu5nY4J1Y9DT7toTE/iYgmz
         qLNQsBLhIk51c2iCUGPKIbGpnaF/kBsGf8mrJhsYpIsCbnUotHl93G7ZDPzFBnZ8D4AD
         pNBff2FcmDE6ztWtE+aJlBbw/OYR9mjfJ+3XQ1am+Mu4RZK4Gh7dI8ahqeJywFQGWnbW
         dIjXH6L+svFXAyYxsqlJRSFB+SMkxC5RojRAJ+65zHa9if50h7gfqIJK2pd7LCIjIbrf
         Zn/g==
X-Forwarded-Encrypted: i=1; AJvYcCWwyIb17e+dpW60coZmZ+t7wLBwLFvZUcBVQrR2xpgns92RPqGX3jnFtkf4vV9ryuhS6WDsbNPodF0pAnhKbA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyZaHciWn8JIahrlsCDXd/hgnhkxA7JEp5QpYjQj328G9/eY2tb
	U/AIcVDMeVuaVcfsLH4naP2ffplS64RB4BhoGjpOKzYW4v1tLdNYTMU3ATgWki04WddP4PFGB/j
	3Kw5AFcJK5XYsGWVV9bTADLvYAsX9TiMVZ6Yw/f/PR1Bg9daBMud0/brzV2Ge6T6c
X-Received: by 2002:a05:600c:444a:b0:42c:b603:422 with SMTP id 5b1f17b1804b1-432b748015bmr146675385e9.8.1731452827516;
        Tue, 12 Nov 2024 15:07:07 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFG91DAj9dtbmBJmaPVjIVaDJVRfiBwwHIq3NwnUafHc3Lid0KCyDysuuqaOuhfXgM1r68lOQ==
X-Received: by 2002:a05:600c:444a:b0:42c:b603:422 with SMTP id 5b1f17b1804b1-432b748015bmr146675275e9.8.1731452827184;
        Tue, 12 Nov 2024 15:07:07 -0800 (PST)
Received: from redhat.com ([2a02:14f:17b:c70e:bfc8:d369:451b:c405])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432d54e8015sm2478145e9.7.2024.11.12.15.07.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Nov 2024 15:07:05 -0800 (PST)
Date: Tue, 12 Nov 2024 18:07:00 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Gediminas Repecka <gediminas.repecka@gmail.com>
Cc: jasowang@redhat.com, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vdpa: vdpa_sim: vdpa_sim_net: fixed cofing style issues
Message-ID: <20241112180522-mutt-send-email-mst@kernel.org>
References: <20241107191941.37300-1-gediminas.repecka@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241107191941.37300-1-gediminas.repecka@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: f63IlWupFMS7zlofcj7X66RM5ScYlg-5MBc6J5z6TnE_1731452827
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


On Thu, Nov 07, 2024 at 09:19:41PM +0200, Gediminas Repecka wrote:
> Fixed coding style issues reported by checkpatch script
> ---

A lot is wrong with this submission, given it's supposed to fix
checkpatch:

- no signature
- typo in subject
- not using direct voice (Fix, not Fixed)


pls fix and resubmit

>  drivers/vdpa/vdpa_sim/vdpa_sim_net.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> index 6caf09a1907b..0705aff74cf3 100644
> --- a/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> +++ b/drivers/vdpa/vdpa_sim/vdpa_sim_net.c
> @@ -53,7 +53,7 @@ struct vdpasim_cq_stats {
>  	u64 errors;
>  };
> 
> -struct vdpasim_net{
> +struct vdpasim_net {
>  	struct vdpasim vdpasim;
>  	struct vdpasim_dataq_stats tx_stats;
>  	struct vdpasim_dataq_stats rx_stats;
> @@ -293,7 +293,7 @@ static int vdpasim_net_get_stats(struct vdpasim *vdpasim, u16 idx,
>  	unsigned int start;
>  	int err = -EMSGSIZE;
> 
> -	switch(idx) {
> +	switch (idx) {
>  	case 0:
>  		do {
>  			start = u64_stats_fetch_begin(&net->rx_stats.syncp);
> @@ -543,7 +543,7 @@ static struct vdpa_mgmt_dev mgmt_dev = {
>  	.ops = &vdpasim_net_mgmtdev_ops,
>  	.config_attr_mask = (1 << VDPA_ATTR_DEV_NET_CFG_MACADDR |
>  			     1 << VDPA_ATTR_DEV_NET_CFG_MTU |
> -		             1 << VDPA_ATTR_DEV_FEATURES),
> +			     1 << VDPA_ATTR_DEV_FEATURES),
>  	.max_supported_vqs = VDPASIM_NET_VQ_NUM,
>  	.supported_features = VDPASIM_NET_FEATURES,
>  };
> 
> 2.34.1

