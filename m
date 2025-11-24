Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBFF32F6164
	for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 23:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764025952; cv=none; b=DrN79wIdQbRzPH3Co6SSm9x4rV3fi0TSSSw7VMae4b/LuvTxfXDyjhpJosMOVsCgMDK1wKC2PvsqRHGrk9brMI3TuQf5yb3KuunDFtJt9n7qKz7UVWLgkXBfoXEKaZEkih0yJ3sV37ClL8JsF54iD1wDX79F3lkhdENpJsxefFA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764025952; c=relaxed/simple;
	bh=t+dQyxsBUhLUAbNkjKawqLLJkl8sAq5hrGHFsew7x/Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JZbwYoWEb4EISGTbWk/tm/X5TUtOXSjDnJPavNmoCH/Vnk186mMG2BXXrpOA8mj7TqMgdUU1QZKUiogKqiqUqYyZ81Bj9PAF4u1zuF1fTGUGYMReJ1/Nb7pjkmKII4nrSKT6iKQMdglALYL5G0XfUp9DzoMo8gub76rbg+DfAqw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=al/lkCRE; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="al/lkCRE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764025949;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=bbkmiqvkCCftq3VuUnSJTTGS10mvI3AeaWokAUq0+2o=;
	b=al/lkCREq1cRYFNUCqL4Uqosy/dyco4aeONhfwS+0nYRdzzqM3TAfi9IJQmzNQlHD3SF3V
	e9Yah1AkBFmNgvyIuje8Wx7t5A2YDDEZPYmyt/VjL7J3n15gpZo2dl/aAGYdLmxQS8HVxH
	w8dTdTKURhJfR0rtmYVv+wn7yUKYcEk=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-Qpc_DKX3NDS0Yxgs3xA3Uw-1; Mon, 24 Nov 2025 18:12:26 -0500
X-MC-Unique: Qpc_DKX3NDS0Yxgs3xA3Uw-1
X-Mimecast-MFC-AGG-ID: Qpc_DKX3NDS0Yxgs3xA3Uw_1764025945
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477563e531cso41181285e9.1
        for <virtualization@lists.linux.dev>; Mon, 24 Nov 2025 15:12:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764025945; x=1764630745;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bbkmiqvkCCftq3VuUnSJTTGS10mvI3AeaWokAUq0+2o=;
        b=iSa647nmjZ8OyK3wtN3ftN5safTm+1FsuHbkw7ic3odn7lQCm8Zpf5oeaeGA+wUlrT
         Eg/ok0bSOkpQryqXMgYMa0j4jGmsZEuGG+tv6bAPHtFtp3xqSA8kjKTGslczmECiaS5j
         NHfBCPgel//n4Qix8sWDOlE1kxMsTti7X7M0nMm6kbeB8CPkAAyaVQ9wljuLry97o+mv
         XN7+ZfJD7dJMfvvh47eEAcWS7f6AzRDT9DmbzagOaCcHyCdsSeAUnllIcdTKiDOAyrLz
         IDVuxJmtxuaZmSGjoKvLfB9jeFebhRuY4LrdAYFXdFDF2MHz0Bgx9cHwyFWFPhKezEep
         +slw==
X-Forwarded-Encrypted: i=1; AJvYcCWtrB5b+uDWs+ShAI0zjYAYbrQnyPO+EslmhRP+cdGzSD94Teowr6DS7FVmgXfBy7luNXnSOkOwCFN689VWBw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwLE952+3zdsN57+7PjMSy+FYyLXQzQzIzHG1y9EgWiTyoOqZh6
	OCokrrWcrX+Mr9QE8+IdyK2LnS4cy8AN5hIRwoPyUgFweQ5ckh+fNE3wyVwhMrq1j+9/Av6rz0s
	njHz0v9ywlRc2sCz71NkrlYzuXSiZ0f0YrvXCkQCXBRHsAYLvMZEI54N/zEcvxnt/FkxQ
X-Gm-Gg: ASbGncsD5vZFl9BmAdHS3Ge53LIVxK3qkawKLMEeNBUKmTjC2g1kTKU4rvt0xkVIBG5
	LwkqBAiRcxKVwHEYELroJ+iOC++mXytEU0Zgd4y6gTURITIvRv+ErivPhFwTTe5SF7vg+1DiIir
	EBTySw9anWdZ6PVUg3MBouLgUzYgW3WgLQClqP4DmFlSMyhbPA8Rcpz0kWZ71+sq9MW5L0dyBeM
	GvLAmnsDtvSAnzaZCZQdPDRMj7E3bFKGMOQFAR7RsAadoRYmfgtWGOFO1pQnhMPltBxitBL6WF2
	hPRdKI1AKyeMKQUiyurpAHhublF/S0r9c5PZiPeJ0JBQNxIWc4tcWiASQ4v1E/zx4xZH0E0ilot
	TtASrqFxmc8IkceF5gf7CPObG9CflVg==
X-Received: by 2002:a05:600c:4f46:b0:477:63a4:88fe with SMTP id 5b1f17b1804b1-477c1103099mr131145945e9.2.1764025945307;
        Mon, 24 Nov 2025 15:12:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE97kAFAAvBCPRt2eYieLcnYMtDDOkrkjPisgwhzw+CQWl2ZNHnhkcNLeBayfDzFQDI18+Wbg==
X-Received: by 2002:a05:600c:4f46:b0:477:63a4:88fe with SMTP id 5b1f17b1804b1-477c1103099mr131145785e9.2.1764025944867;
        Mon, 24 Nov 2025 15:12:24 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477bd1580cbsm104150135e9.2.2025.11.24.15.12.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Nov 2025 15:12:24 -0800 (PST)
Date: Mon, 24 Nov 2025 18:12:21 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v12 10/12] virtio_net: Add support for IPv6
 ethtool steering
Message-ID: <20251124180941-mutt-send-email-mst@kernel.org>
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-11-danielj@nvidia.com>
 <20251124165246-mutt-send-email-mst@kernel.org>
 <16f665a8-6b4b-4722-93d7-69f792798be4@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <16f665a8-6b4b-4722-93d7-69f792798be4@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: A-099KQSXa_aZVKnOp6a_4OkLS-k0PhNCa7tsP2qrHg_1764025945
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 24, 2025 at 05:04:30PM -0600, Dan Jurgens wrote:
> On 11/24/25 3:59 PM, Michael S. Tsirkin wrote:
> > On Wed, Nov 19, 2025 at 01:15:21PM -0600, Daniel Jurgens wrote:
> >> Implement support for IPV6_USER_FLOW type rules.
> >>
> 
> >>  	return false;
> >> @@ -5958,11 +5989,33 @@ static void parse_ip4(struct iphdr *mask, struct iphdr *key,
> >>  	}
> >>  }
> >>  
> >> +static void parse_ip6(struct ipv6hdr *mask, struct ipv6hdr *key,
> >> +		      const struct ethtool_rx_flow_spec *fs)
> >> +{
> > 
> > I note logic wise it is different from ipv4, it is looking at the fs.
> 
> I'm not following you here. They both get the l3_mask and l3_val from
> the flow spec.

yes but ipv4 is buggy in your patch.

> > 
> >> +	const struct ethtool_usrip6_spec *l3_mask = &fs->m_u.usr_ip6_spec;
> >> +	const struct ethtool_usrip6_spec *l3_val  = &fs->h_u.usr_ip6_spec;
> >> +
> >> +	if (!ipv6_addr_any((struct in6_addr *)l3_mask->ip6src)) {
> >> +		memcpy(&mask->saddr, l3_mask->ip6src, sizeof(mask->saddr));
> >> +		memcpy(&key->saddr, l3_val->ip6src, sizeof(key->saddr));
> >> +	}
> >> +
> >> +	if (!ipv6_addr_any((struct in6_addr *)l3_mask->ip6dst)) {
> >> +		memcpy(&mask->daddr, l3_mask->ip6dst, sizeof(mask->daddr));
> >> +		memcpy(&key->daddr, l3_val->ip6dst, sizeof(key->daddr));
> >> +	}
> > 
> > Is this enough?
> > For example, what if user tries to set up a filter by l4_proto ?
> > 
> 
> That's in the next patch.

yes but if just this one is applied (e.g. by bisect)?


> > 
> >> +}
> >> +
> >>  static bool has_ipv4(u32 flow_type)
> >>  {
> >>  	return flow_type == IP_USER_FLOW;
> >>  }
> >>  
> >> +static bool has_ipv6(u32 flow_type)
> >> +{
> >> +	return flow_type == IPV6_USER_FLOW;
> >> +}
> >> +
> dr);
> >>  
> >> -	if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> >> -	    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
> >> -	    fs->m_u.usr_ip4_spec.l4_4_bytes ||
> >> -	    fs->m_u.usr_ip4_spec.ip_ver ||
> >> -	    fs->m_u.usr_ip4_spec.proto)
> >> -		return -EINVAL;
> >> +		if (fs->h_u.usr_ip6_spec.l4_4_bytes ||
> >> +		    fs->m_u.usr_ip6_spec.l4_4_bytes)
> >> +			return -EINVAL;
> >>  
> >> -	parse_ip4(v4_m, v4_k, fs);
> >> +		parse_ip6(v6_m, v6_k, fs);
> > 
> > 
> > why does ipv6 not check unsupported fields unlike ipv4?
> 
> The UAPI for user_ip6 doesn't make the same assertions:
> 
> /**
> 
>  * struct ethtool_usrip6_spec - general flow specification for IPv6
> 
>  * @ip6src: Source host
> 
>  * @ip6dst: Destination host
> 
>  * @l4_4_bytes: First 4 bytes of transport (layer 4) header
> 
>  * @tclass: Traffic Class
> 
>  * @l4_proto: Transport protocol number (nexthdr after any Extension
> Headers)                                          ]
>  */
> 
> /**
>  * struct ethtool_usrip4_spec - general flow specification for IPv4
>  * @ip4src: Source host
>  * @ip4dst: Destination host
>  * @l4_4_bytes: First 4 bytes of transport (layer 4) header
>  * @tos: Type-of-service
>  * @ip_ver: Value must be %ETH_RX_NFC_IP4; mask must be 0
>  * @proto: Transport protocol number; mask must be 0
>  */
> 
> A check of l4_proto is probably reasonable though, since this is adding
> filter by IP only, so l4_proto should be unset.


maybe run this by relevant maintainers.
> 
> > 
> >> +	} else {
> >> +		selector->type = VIRTIO_NET_FF_MASK_TYPE_IPV4;
> >> +		selector->length = sizeof(struct iphdr);
> >> +
> >> +		if (fs->h_u.usr_ip4_spec.l4_4_bytes ||
> >> +		    fs->h_u.usr_ip4_spec.ip_ver != ETH_RX_NFC_IP4 ||
> >> +		    fs->m_u.usr_ip4_spec.l4_4_bytes ||
> >> +		    fs->m_u.usr_ip4_spec.ip_ver ||
> >> +		    fs->m_u.usr_ip4_spec.proto)
> >> +			return -EINVAL;
> >> +
> >> +		parse_ip4(v4_m, v4_k, fs);
> >> +	}
> >>  
> >>  	return 0;
> >>  }
> >> -- 
> >> 2.50.1
> > 

