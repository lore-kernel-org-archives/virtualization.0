Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A67A74C92
	for <virtualization@lists.linux.dev>; Sun,  8 Feb 2026 11:54:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770551682; cv=none; b=GBflUuymVfM+mIY+E7MM3RWQmU+9TjWhLqdBK+UmE0X/eeHWu7OLb9N8n9ZF7763tlW482FhD8Eh+08hb+eGZuLmH9EiyV2CmhKfci6MAlbQ+JF6mLHoMpNmkUsGRcIiIpYsd+RhiV8IFk6v/yQ9NP5khvlimAMzHX/h6OWHxGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770551682; c=relaxed/simple;
	bh=TvWEngvMoPQLfKVyDs4XmVBpluDLYqdvpBEeahZNGvo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=r2a2ESyM0aO3QRTTLub9jzXQDnw5rlmmTfoxNiGABxrIiOKOXM5TE9162Kit7wXFVxnBmb82WK1+QRu7NOU8fNPD24olHACi/Zt82G17CcCUEC1RMsIHvX3ZnftnNMhH4xRWT0vaw/jjddi4hFcAVEYQLiLpr68FWiTxuLRSXwQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VQwxfzqY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VQwxfzqY"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770551680;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Nvl4g9KclHkA3GKW58oziSPsnURrFzYwrfY70D3VSlw=;
	b=VQwxfzqYcR3kKibPxqo9eFTDDqPOOH8gO3NQ2oLFnVQsTeJr+vxQcqekIAFRmSVJxZ8Drn
	sJq5S5pKq/1pF1d2Si4uhdnjlNjL31VuilyUWGWPFw0DUv/e2VsaKEE46+M5nCI1WoWJQe
	Qp4GgQ00pv7wXTgzZ5C0UxZhcDFy7uA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-122-MM22d3NANiatUtEGQpt7-A-1; Sun, 08 Feb 2026 06:54:39 -0500
X-MC-Unique: MM22d3NANiatUtEGQpt7-A-1
X-Mimecast-MFC-AGG-ID: MM22d3NANiatUtEGQpt7-A_1770551678
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-480711d09f1so42049925e9.0
        for <virtualization@lists.linux.dev>; Sun, 08 Feb 2026 03:54:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770551678; x=1771156478;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nvl4g9KclHkA3GKW58oziSPsnURrFzYwrfY70D3VSlw=;
        b=xQNXjwzUJihsKCUXjqjtDXoSEWAnMBz+fU47jJ0MaAKV8mq7S+K2xpBycuBkFmbYb/
         Plbm0eWYc2/yaYobPW0FM2HRLM9WZgWohNGFukh1p+I1xcmvRK7/BP5Fba5FjnNgXi1n
         3l0wLI/98RxFU5liCkB7frhAD48jgEnfts0bPR7FskgLM5U9hAO4QOL/TeXPT2IIC7+I
         cqT4x4OzzifHymUj7hKF8zyu0xZk2jxfn/SzWdebcffCS/tjTpBZpCkxhq4vRBh3qWYk
         5nk3gq7te0A+kz6aPRecUnTqewxyx837U59sViyvJD1DV9OCZKhs0oln0E+xeFXkZY/8
         M70A==
X-Forwarded-Encrypted: i=1; AJvYcCXEcI16DjIGTDZVNdgyMc51yeQ6rSMZvZtzThZ5WI+JDvhU8Xi3ILLnEuJ4bjk5cY+cSmg6Vnfzt8CRiUPOCg==@lists.linux.dev
X-Gm-Message-State: AOJu0YwZsr8OhLJriGJ3Xwf5KtzcnADTIZFUe9OnNNMqGubyv6hOiMcL
	bDwg2yoBFmKB3JOrg++fIQBDqfcmulu6X6aaU23S25iJmy6Bv83QfbTsxOQM5vWZ3MMCU7mg33b
	aAkIoqSJhKs1o/t1Mud1uW37C28xc49jwWWrtEqDSmS3ikNJ7O5zbf3zTT00hv50M3dmN
X-Gm-Gg: AZuq6aJmZU/kitPrATI2h+XpKGuv5QnO3j7TaTwJcy/OkaKLpW+wTnORzFVPnGcO3xN
	l6ukotFdHdeSl8BfWplelXlvWwWSkKilB8gzhte7ac9/0xreIT1JCgDRqGohNWs93YAQ7FLVD9A
	W/2A0Oy5FFwvXgudCge/5s7vxLvUEkeRRkM6jaRZr6w9UvMiQGmn3H9CzAqJ0U1lTri4+wPBMTI
	ILQWRmYHiORhkV2/Kv3Loahggj+zv5e8i9a/3WjdJPJQ5iF7mYR4TleZbnEWTkvR0keNbrSd+Gv
	1E6/YNhazlzzKqKwf1aM5Kd8sB19bI6Lh4LtXEl96g8NbMbvpHDgE+539QyZCmt76+CiDv+7Qsy
	CydbOfm6yjqNcffpzvdWXcrmsHaO0Hb1OVA==
X-Received: by 2002:a05:6000:26cd:b0:431:1d4:3a71 with SMTP id ffacd0b85a97d-43629345e67mr12971523f8f.27.1770551677856;
        Sun, 08 Feb 2026 03:54:37 -0800 (PST)
X-Received: by 2002:a05:6000:26cd:b0:431:1d4:3a71 with SMTP id ffacd0b85a97d-43629345e67mr12971487f8f.27.1770551677323;
        Sun, 08 Feb 2026 03:54:37 -0800 (PST)
Received: from redhat.com (IGLD-80-230-34-155.inter.net.il. [80.230.34.155])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4376accfc58sm3853360f8f.16.2026.02.08.03.54.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 08 Feb 2026 03:54:36 -0800 (PST)
Date: Sun, 8 Feb 2026 06:54:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Daniel Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v20 07/12] virtio_net: Implement layer 2 ethtool
 flow rules
Message-ID: <20260208065146-mutt-send-email-mst@kernel.org>
References: <20260205224707.16995-1-danielj@nvidia.com>
 <20260205224707.16995-8-danielj@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260205224707.16995-8-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pmWmxEcynNsBl5LWXbp4BjqLBQg6CDv491Ohx3hJQCo_1770551678
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Feb 05, 2026 at 04:47:02PM -0600, Daniel Jurgens wrote:
> @@ -295,8 +301,16 @@ struct virtnet_ff {
>  	struct virtio_net_ff_cap_data *ff_caps;
>  	struct virtio_net_ff_cap_mask_data *ff_mask;
>  	struct virtio_net_ff_actions *ff_actions;
> +	struct xarray classifiers;
> +	int num_classifiers;
> +	struct virtnet_ethtool_ff ethtool;
>  };
>  
> +static int virtnet_ethtool_flow_insert(struct virtnet_ff *ff,
> +				       struct ethtool_rx_flow_spec *fs,
> +				       u16 curr_queue_pairs);
> +static int virtnet_ethtool_flow_remove(struct virtnet_ff *ff, int location);
> +
>  #define VIRTNET_Q_TYPE_RX 0
>  #define VIRTNET_Q_TYPE_TX 1
>  #define VIRTNET_Q_TYPE_CQ 2


btw reordering code so we do not need forward declarations would make
review a tiny bit easier.


-- 
MST

