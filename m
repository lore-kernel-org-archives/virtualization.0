Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41A3E38DF9
	for <virtualization@lists.linux.dev>; Sun,  8 Feb 2026 10:09:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770545347; cv=none; b=JdtMI4OSak4UhcI/6Y0fFo9AezByetTHz/OQPQBvzYP7b+yNxTSrrbNOpFEqLRkvTZ4Py2+6ST36vOCp0JZ9gXPuGkeQYixkgfBK6MjQE6MO3iVBVaekmrzALIEwNpdZFzWktVZ3HyiXVSl0EwXFEl6kEqgHx6yNXx8wPbdPenU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770545347; c=relaxed/simple;
	bh=24CNzPhFld1ZXJkgrJO/l4oQ/ugW1VWQRdsWzt3JY9Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=sy642fqp21xmDTSfUhTt4es/ZRuZ/wRGmacBfocJOXVL/ZLYuS0MgkcOgYiuwls1wcCRBOCXhiPWecy1KuLLm5Tqha46vJ7vHC1fYdGbDpjtdJgjpDkfW/Wa33EjeAAfzfbCIM2nu3qJHQuvDGUAQ6ZZMx5b9pu/DDulLUmNRU4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=PgFeFqUb; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PgFeFqUb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770545346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=rfuh2plodm8DQ54d7nVZcVI6X16Jjo175gNLcwSIUvA=;
	b=PgFeFqUbUbRQqhgUGMxuPFXk5fTq9Fe3dkgq6taIoHLHW1usgVimAnv7+k67SfnFNcTpT5
	yb7yxcLhzs9cVL3LbZbqVCi8LaNPmUq/oTgnnnY4ZdirBZoE1WpuVpyG/+i7oanB2B4KTj
	JHN8TfNTi2+5Eiy9kxFX2GAFrbbSiV8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-49-apSBxA2bPNi7gyQ5zSgW7Q-1; Sun, 08 Feb 2026 05:09:02 -0500
X-MC-Unique: apSBxA2bPNi7gyQ5zSgW7Q-1
X-Mimecast-MFC-AGG-ID: apSBxA2bPNi7gyQ5zSgW7Q_1770545341
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-4362197d1easo3487904f8f.2
        for <virtualization@lists.linux.dev>; Sun, 08 Feb 2026 02:09:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770545341; x=1771150141;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rfuh2plodm8DQ54d7nVZcVI6X16Jjo175gNLcwSIUvA=;
        b=sWaxPx+RxIyndX9Klal6IiX5QbqYuwMw10om5deKPSpoDJajQ1poErIPZDqzRVp6is
         0hJga3U4L7Q+uskDBESHD0oWZeJlw79TFpWa4ASs8CvTFJ6EI3VsIOsb8cWVWZ6VICPz
         5Ftu1PjSPSL6QRWBwIhHQizKg5tzCkvYpEUUP6hLoxWM1cdoSTT7SKOA51GEX/7NRYsE
         IZFx3MFg2SiczGyn5HIGKmfzSwPDG6ilqUuszat7PfrLE9hbXE1++l09pketwbc9hpVP
         K+srnGME33SIPNuRrVXBEDcpIynlL40i1xeR8juYbglFCw4bow1wTkOuiapSD6xSpEez
         pWsw==
X-Forwarded-Encrypted: i=1; AJvYcCVQMs+kwxEd4gU2Lk+5e3l+bB9Rxj6pEa68HYGlD3XyNYeWjgi6Woe2VcjOMdl2dyoVZjBFkWAwcpYEvKquKw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwL2DLRqAhNK75ea6Q04puVNUePc/SOCJps+5Kddcj5qX31vz3o
	gkHx9lgyl4TBGp5U3JixgIMoK8BJYu9Vzx7qUhoQvtxzUCRLUNTei2Av8Jk2526xJG4e3qohzLz
	KcA2+Dp2k+CdwxKoaikGvnWumDY0G4lrx17i9j2OkkvNlk8jC4+F0jptL+p0HOOy8waDg
X-Gm-Gg: AZuq6aJfFpeMiTjasS1vWz2D2xLMSKYsWnPkB4FciIoMHFM3cjlsuOFQ+Jf/c8kd5wY
	nXe4zNMyD46IjeRh7/0mGgeKp2ckXGAQEn1rDLYMTvyLYEjLMFebzB4REJpbfCw2ABJBFQvfeQs
	o/tvhkAmz6Fr3awr9V4Baaa6Y8M6t0MP3naC8GmP478GLG3qGoLD87TykFkpY6bF6i+FE6CJke1
	oQIR5+kh4tPAXyWQm0umSpRT7SoCzsTrY3sMfwIOpeCY5IchXYRYEgf7pQVJZijU7GcDNAK+6DQ
	Nl42rXoEwgCnH86LjRRfxJLrVeFwiWuQgh6Vd+UEwnOj8Ll9gaGddqe0S4uz3FMVU3hkAWQIJz+
	yaXrm6Cq+BzDdrr3N/Cl+EU7kscjvZQGHxA==
X-Received: by 2002:a05:6000:2381:b0:436:233c:c7c1 with SMTP id ffacd0b85a97d-4362923780emr13486651f8f.23.1770545340913;
        Sun, 08 Feb 2026 02:09:00 -0800 (PST)
X-Received: by 2002:a05:6000:2381:b0:436:233c:c7c1 with SMTP id ffacd0b85a97d-4362923780emr13486609f8f.23.1770545340396;
        Sun, 08 Feb 2026 02:09:00 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376806626fsm5151675f8f.37.2026.02.08.02.08.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 02:08:59 -0800 (PST)
Date: Sun, 8 Feb 2026 05:08:56 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v20 10/12] virtio_net: Add support for IPv6
 ethtool steering
Message-ID: <20260207203120-mutt-send-email-mst@kernel.org>
References: <20260205224707.16995-1-danielj@nvidia.com>
 <20260205224707.16995-11-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260205224707.16995-11-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: o9GXYXEJBGvJHV6e9vfirl6rJ4cw7fJ53gF2pdSDlZQ_1770545341
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

> @@ -6111,20 +6176,38 @@ static int setup_ip_key_mask(struct virtio_net_ff_selector *selector,
>  			     u8 *key,
>  			     const struct ethtool_rx_flow_spec *fs)
>  {
> +	struct ipv6hdr *v6_m = (struct ipv6hdr *)&selector->mask;
>  	struct iphdr *v4_m = (struct iphdr *)&selector->mask;
> +	struct ipv6hdr *v6_k = (struct ipv6hdr *)key;
>  	struct iphdr *v4_k = (struct iphdr *)key;
>  
> -	selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
> -	selector->length = sizeof(struct iphdr);
> +	if (has_ipv6(fs->flow_type)) {
> +		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV6;
> +		selector->length = sizeof(struct ipv6hdr);
> +
> +		/* exclude tclass, it's not exposed properly struct ip6hdr */

do you mean:

+		/* exclude tclass, it's not exposed properly in struct ipv6hdr */

?

and maybe properly -> directly?

> +		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
> +		    fs->m_u.usr_ip6_spec.l4_4_bytes ||
> +		    fs->h_u.usr_ip6_spec.tclass ||
> +		    fs->m_u.usr_ip6_spec.tclass ||
> +		    fs->h_u.usr_ip6_spec.l4_proto ||
> +		    fs->m_u.usr_ip6_spec.l4_proto)
> +			return -EINVAL;
>  
> -	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> -	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
> -	    fs->m_u.usr_ip4_spec.l4_4_bytes ||
> -	    fs->m_u.usr_ip4_spec.ip_ver ||
> -	    fs->m_u.usr_ip4_spec.proto)
> -		return -EINVAL;
> +		parse_ip6(v6_m, v6_k, fs);
> +	} else {
> +		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
> +		selector->length = sizeof(struct iphdr);
> +
> +		if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> +		    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
> +		    fs->m_u.usr_ip4_spec.l4_4_bytes ||
> +		    fs->m_u.usr_ip4_spec.ip_ver ||
> +		    fs->m_u.usr_ip4_spec.proto)
> +			return -EINVAL;
>  
> -	parse_ip4(v4_m, v4_k, fs);
> +		parse_ip4(v4_m, v4_k, fs);
> +	}
>  
>  	return 0;
>  }
> @@ -6194,7 +6277,7 @@ static int build_and_insert(struct virtnet_ff *ff,
>  
>  	setup_eth_hdr_key_mask(selector, key, fs, num_hdrs);
>  
> -	if (has_ipv4(fs->flow_type)) {
> +	if (has_ipv4(fs->flow_type) || has_ipv6(fs->flow_type)) {
>  		selector = next_selector(selector);
>  
>  		err = setup_ip_key_mask(selector, key + sizeof(struct ethhdr), fs);
> -- 
> 2.50.1

