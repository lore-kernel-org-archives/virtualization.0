Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 508942652B4
	for <virtualization@lists.linux.dev>; Thu,  9 Oct 2025 10:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760005870; cv=none; b=XcE2DK9+NmsfU6GtjPFQPolG4ZncEmlFUEhAtuvW5rZXI0YcEjAXJJH2Vk9j2FMaHFq58unyK5Dk2u6oxSodp2YwOX7+9urqiAxbM+zDeyPj0HUb27Scmx/NLv7l2rj/9Yd+rYzE4qv3gMZ6UWwsbEoENbyHWxVgpT3heYMyXB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760005870; c=relaxed/simple;
	bh=vgAod7crx7R4xXAIc9s1jZIP1TAXz3XkbhEUFIzMc8k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=C8hjtTDchwY2HwhaJpFq7lFZ/9sxIwxPCWDU/bEZJKuqaMmSWeqAx4ssPl3vTla98LJMow+ShDYTgnhCvcdVZtVNflKaB4qNgVaOBg5IXZKnNePCDfSqMbm5vxlP/2T9CTCWgj7o3FQ8xHSw5g28Q4IQsl7zOrorYiIr44yqbrs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RhOSvMnq; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RhOSvMnq"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760005868;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=3xwzUfSGmIaE1JMs7cPjjEDpCSBNoPpYVvArzBqo+h8=;
	b=RhOSvMnqLwM44wzM6z1eivY9Af0or4RVpGdqJ9oIkuFzfgzkd6YqesiANl3r46eImxR9QN
	+Ulk1cMbU9Gt99f8HTVz3QoWuWX2gDHyrzUDRI3hLyB60+B3gQ4BTu0c3N9lthnO/eVfJ5
	rSKY79FsLpWIQa/jAespIIUJjx1XrJo=
Received: from mail-qv1-f70.google.com (mail-qv1-f70.google.com
 [209.85.219.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-573-FsIaqWp5PlaVHC1bUxTzcQ-1; Thu, 09 Oct 2025 06:31:07 -0400
X-MC-Unique: FsIaqWp5PlaVHC1bUxTzcQ-1
X-Mimecast-MFC-AGG-ID: FsIaqWp5PlaVHC1bUxTzcQ_1760005867
Received: by mail-qv1-f70.google.com with SMTP id 6a1803df08f44-78e45d71f05so20029506d6.2
        for <virtualization@lists.linux.dev>; Thu, 09 Oct 2025 03:31:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760005867; x=1760610667;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3xwzUfSGmIaE1JMs7cPjjEDpCSBNoPpYVvArzBqo+h8=;
        b=SEQgjiQlHKShUukYYyupPrjFdZ+UBNaEpeF4e/stiOBVGv8B6t7Mc4u/2RT1Rrg/X/
         YxMva+nNgEz7LfWx9XkNEekNqpYfc0VfvKUWuAaoc5qN+T27kXXQ2xjta44b3r6t8QJq
         e+WwCMSlicPhZeyyvAOB2Uxwpz8fq0JpzyGAvmP+MbnfxiFkk4OIrGGmb2IiihbL9sGA
         Lq+/ta7sQxama3D0B7/jDPZwVIb0r1y/DDeLz2JFNvrFKH/63tE0hetRwcfd9e/DMR1S
         KYcOcMQVCGr3y0NGPAJvwT/beZBB6a36ntugsnOjLHRmF2B2rh7LqwEkhnc4hrEm87gv
         G5iQ==
X-Forwarded-Encrypted: i=1; AJvYcCVKYp9DoBsuaM8e4SLWdqFvfV/+pNM44H0RuCSabKQQeKdadgNAImPV9n/ij977/gL/xpQ1NpZ5OfdZRrxKZw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxWOdujvLJtTlbsSuah/JVtgu5EZEOuE7X72+tNfVcxeh2wAooI
	HUyCrDZuLI71djcwXYyu5YSY6+t2fuiF5YBeYFp97gMcnU7tBaAfpu3HlXm/sT8IZ6tciXCQOGI
	l6Rr2ew6f9oUeA3aqywbHRMzJBWuBfWmHIC/Y0qm7yJNjlxGIWCAwSZW00XzGecD7kRNS
X-Gm-Gg: ASbGncvKh2mJHMhtS5l0GCTq4F6pNz20Zgl6aZnjMqWTVsotSJz1dHCixCJYChiWLD/
	G0GSfOrvlMWO6ZqkaRJQ0WtjSeChYrEX0y8GGNMNjLDf3obEfe1HL1bDMXnJiMO9G7IIWbs1Prx
	PuFSsqlQXp2m6T0S/DDUoi9rdsNHiTH6IlAdyhMbYoczmW/aD8ON5oErcTruVbpu+l/aUkDa6hP
	izzw5lTbyAi7B/mBeKHiSiG6gkw9Ty7UdRAk681CkOopkzKMY3/iigguKLhDj41GfoZRmoEHmsV
	AxUHZQnB0xEiglmqB64iLH1iNkuvRxgJVpI=
X-Received: by 2002:ad4:5f0f:0:b0:797:cef:c862 with SMTP id 6a1803df08f44-87b210a21c1mr74474886d6.29.1760005866601;
        Thu, 09 Oct 2025 03:31:06 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHb59BlWNtrd9ASVIv5OrEtZDxeNHD6M5rLTvtfko0iTPAMDChI1SFbi2QmoEXT3T4ySUiwVg==
X-Received: by 2002:ad4:5f0f:0:b0:797:cef:c862 with SMTP id 6a1803df08f44-87b210a21c1mr74474576d6.29.1760005866091;
        Thu, 09 Oct 2025 03:31:06 -0700 (PDT)
Received: from redhat.com ([138.199.52.81])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-878bd786769sm181429956d6.31.2025.10.09.03.31.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Oct 2025 03:31:05 -0700 (PDT)
Date: Thu, 9 Oct 2025 06:31:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Kommula Shiva Shankar <kshankar@marvell.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	xuanzhuo@linux.alibaba.com, virtualization@lists.linux.dev,
	parav@nvidia.com, jerinj@marvell.com, ndabilpuram@marvell.com,
	sburla@marvell.com, schalla@marvell.com
Subject: Re: [PATCH v2 net-next  3/3] vhost/net: enable outer nw header
 offset support
Message-ID: <20251009062720-mutt-send-email-mst@kernel.org>
References: <20251008110004.2933101-1-kshankar@marvell.com>
 <20251008110004.2933101-4-kshankar@marvell.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251008110004.2933101-4-kshankar@marvell.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: DDLpbGrVBjvKAsePa4d0qJuak2Bh7vWhCA8NbpvV0qI_1760005867
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Oct 08, 2025 at 04:30:04PM +0530, Kommula Shiva Shankar wrote:
> apprise vhost net about the virtio net header size.
> 
> Signed-off-by: Kommula Shiva Shankar <kshankar@marvell.com>
> ---
>  drivers/vhost/net.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 35ded4330431..8d055405746d 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -78,6 +78,7 @@ static const u64 vhost_net_features[VIRTIO_FEATURES_DWORDS] = {
>  	(1ULL << VIRTIO_F_IN_ORDER),
>  	VIRTIO_BIT(VIRTIO_NET_F_GUEST_UDP_TUNNEL_GSO) |
>  	VIRTIO_BIT(VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO),
> +	VIRTIO_BIT(VIRTIO_NET_F_OUT_NET_HEADER),
>  };
>  
>  enum {


How does this even work?
VIRTIO_FEATURES_DWORDS is 2, you can't really
add more elements.

Pls include info on testing done in your next
submission.


> @@ -1655,6 +1656,9 @@ static int vhost_net_set_features(struct vhost_net *n, const u64 *features)
>  		  sizeof(struct virtio_net_hdr_mrg_rxbuf) :
>  		  sizeof(struct virtio_net_hdr);
>  
> +	if (virtio_features_test_bit(features,
> +				     VIRTIO_NET_F_OUT_NET_HEADER))
> +		hdr_len = sizeof(struct virtio_net_hdr_v1_hash_tunnel_out_net_hdr);
>  	if (virtio_features_test_bit(features,
>  				     VIRTIO_NET_F_HOST_UDP_TUNNEL_GSO) ||
>  	    virtio_features_test_bit(features,
> -- 
> 2.48.1

