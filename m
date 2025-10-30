Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A885221FBB
	for <virtualization@lists.linux.dev>; Thu, 30 Oct 2025 11:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761823888; cv=none; b=h+nPpXJeF1v0fRhiBbGrVdLRiubHz5iI8kRCEqjZwlUN/l+MVZoUlN8BxE70JiW57N87IrcOmJYZw8pLzAujaCStB3qdRV8HtMQtfK7WlfMyo+tAVS8M+5zWXEyKR7AmJ4pnezE0jVY0oJ0DwYqy/bKnHYDV1FpFVLfbMf3GxjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761823888; c=relaxed/simple;
	bh=PalcqpnJMqwi6lBplDZuoLJUjAKrWK8eNRu93Izv5nc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qRIq/lnLqV+EzcyW02pnnpP4iDMWvHdTro6qd8PmKeBbeNYWoSbbSia/Sc22iehDI/q/XAWAGqrRbuuPGd+UvzSZVxbFuLzM3a1b4BX/t08pbeEKtfCP/qijPmBEsGU+mNgmiG9QKCuZYrIj9rMpqeU5n1sg4fd4SpzcMgV0jrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q2qQvsw/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q2qQvsw/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761823885;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gNPmqukZVrL1nRBEg8kswOAZNYJ7QWgglOXnRwYjysY=;
	b=Q2qQvsw/Xbs0yRCnshUV0HITk4HDpOi/A1tisJgI6kyFYLP2HWH6T3vhJqAGm/jjyJWM6J
	eOSxMcseoqiH1TlJfhkfg/Tjrn2MkEMlrcZKgApVcdZRtbjlGYkQsNKrw1M7PyJhSZ2hfK
	kjJWfhKNgt3/l186CndZjWAKwjYfuvs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-624-BW26rKLsMKC0GTt51duvVQ-1; Thu, 30 Oct 2025 07:31:23 -0400
X-MC-Unique: BW26rKLsMKC0GTt51duvVQ-1
X-Mimecast-MFC-AGG-ID: BW26rKLsMKC0GTt51duvVQ_1761823882
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-477171bbf51so6100365e9.3
        for <virtualization@lists.linux.dev>; Thu, 30 Oct 2025 04:31:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761823882; x=1762428682;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gNPmqukZVrL1nRBEg8kswOAZNYJ7QWgglOXnRwYjysY=;
        b=B2EIbsMD0PM/AiC/5pgUW1jU6lSH4NBSneiUkXykWAEzzNrSx5jeMi+ccMqwaO1hBf
         G9FYo3SjD1ghCGehdVDgsz9NyVBqGX+JMWPLRAzW1kPZP4OVwRQQ+hcjbJf/j9AHTjK6
         I4bLQVITYr5ioQhMiRa/Nt1AqnlNygKmsrUMO8yTvdttaB0p1v0dGmTHXqyD7hSTf3wH
         2Co6t/9Tb3Sjj08Hm3t30n8yIBVPnFueRr/UrBZI/Z+XvtOJddDvpStGexHo1HRi4tIz
         ZMxmE6VAlrc1ALXyHSfxaru4P+Eb5GSr2j7q7lYn7MBu0CJNCV62IizTOi9JTKOqa093
         ToQA==
X-Gm-Message-State: AOJu0YzCTPHXDbxdAvVMuxb1vurjEXahj4avDld22tMVVUrKy4kjF6Ff
	/nIHDTkxidRf7LPyhJlgpU2n4LaoAFdx82SsdZeS4CKSxgzcbxb0NAPWb4au16Ocp32BTYfuZ3L
	IUpb/LBpP1c5/0cGrTKjb4kZUpSEyN3EeCaOWLUlSNgUSnElG4S459a7TQRZeMaT/AdBa
X-Gm-Gg: ASbGncvAdsjIZFX0lydvfuZodxM38xRos88ob7CpCIbuz0/inxm/Rvcb4Idpwue3fcs
	YwJ64C7Zu4JRwjnVVT4lN1zlIU7/nhIvzea7UOYgocv9Aauw/WETFTP0S24ahqu4TD4md7zHb7s
	7omSwGMf6JcUOBPlOqRkzfmvRhb/z+I7cqx6qnl7rNKzMTj5jCqA84SFW+X0SuuiJkfVLMRsddB
	zLnU0+22+5TT+cz1RwtBP4I30BFb0IJ4/wIBjQhzHAqLyn6RkZ6efSE2E1PW0fS4KZ1egnpeo+c
	yGs06K1BjFEFs4DrkN1L87m/z7tp0eQjLTYSV4qZ7p+nl1VqtcNgUk5BMX2ZrC/PmKKh6GQ9Hyw
	2Y2Kti9SYf+oBoAdQJ2lHj9dT5ff1IDITia7Fy0L20kY/
X-Received: by 2002:a05:600c:4ed1:b0:46d:a04:50c6 with SMTP id 5b1f17b1804b1-4771e1e10a5mr57072485e9.30.1761823882500;
        Thu, 30 Oct 2025 04:31:22 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHg4pUYWYJn5DSp/qvYpqqu8dWSsUkDIL1fKa7DHscLp3BNjyufKl2NcGIwl/reA4vImajWlA==
X-Received: by 2002:a05:600c:4ed1:b0:46d:a04:50c6 with SMTP id 5b1f17b1804b1-4771e1e10a5mr57072195e9.30.1761823881975;
        Thu, 30 Oct 2025 04:31:21 -0700 (PDT)
Received: from ?IPV6:2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6? ([2a0d:3341:b8a2:8d10:2aab:5fa:9fa0:d7e6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4771902fa8dsm64427935e9.8.2025.10.30.04.31.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 30 Oct 2025 04:31:20 -0700 (PDT)
Message-ID: <9d469be5-e2f3-427d-9e6b-5d9c239fcb79@redhat.com>
Date: Thu, 30 Oct 2025 12:31:18 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v6 08/12] virtio_net: Use existing classifier if
 possible
To: Daniel Jurgens <danielj@nvidia.com>, netdev@vger.kernel.org,
 mst@redhat.com, jasowang@redhat.com, alex.williamson@redhat.com
Cc: virtualization@lists.linux.dev, parav@nvidia.com, shshitrit@nvidia.com,
 yohadt@nvidia.com, xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
 shameerali.kolothum.thodi@huawei.com, jgg@ziepe.ca, kevin.tian@intel.com,
 kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
References: <20251027173957.2334-1-danielj@nvidia.com>
 <20251027173957.2334-9-danielj@nvidia.com>
From: Paolo Abeni <pabeni@redhat.com>
In-Reply-To: <20251027173957.2334-9-danielj@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: jvepuh2oD-jNOlYLPZPeTzUk08OsQ4C_ATolKopHGoI_1761823882
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/27/25 6:39 PM, Daniel Jurgens wrote:
> @@ -7082,8 +7097,9 @@ validate_classifier_selectors(struct virtnet_ff *ff,
>  			      int num_hdrs)
>  {
>  	struct virtio_net_ff_selector *selector = (void *)classifier->selectors;
> +	int i;
>  
> -	for (int i = 0; i < num_hdrs; i++) {
> +	for (i = 0; i < num_hdrs; i++) {
>  		if (!validate_mask(ff, selector))
>  			return -EINVAL;

Minor nit: this chunk possibly belongs to in patch 6/12.

/P

