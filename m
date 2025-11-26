Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3927D201278
	for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 18:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764180035; cv=none; b=jyj4Cwi9nrJ7vXXHBY4ECEBzzuJfBUY4bSHy2QqNZ7ytX76zNDLpKHhDU006FpMrhqn+xw7KwrdILlh1eWhV/fNXoLapfzgRg4jwzAAw38lq+Aoo8kAO7b5iUKWNvSG5xs6ZVoxZ+kjfhPwHvYQEJVZsrmch7QBuYHU9K9mIbz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764180035; c=relaxed/simple;
	bh=IYZdkZZKGPGx9sx2990egUZQsDNd44OswOXxoE5ncJ4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=bneYzadBbcCuFllIn6cqclME566OLYgpXyUuj/WnxVA7/6TygbT4qbOo3cw3ePVds/vYTGz2b/aaVKrRawQr5pExjNN6w1waD5jjeWItyN3dnOuJ3+SRGSOObiPVLI4MkbRmLQC+dZGzOjmfhp1flD7ewTXcjshOhn/bBdKz/wo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=DhNV0prD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DhNV0prD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764180032;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=9YgBhXcGSddKFMYnZCe5lp8J3od8fCjODxmcHFceGH4=;
	b=DhNV0prDJPmpierS5UDhBPmdcpKvGklWhOFotPrHQgRyAANUkF8i4aPJTc/TsGq77sAtoQ
	xHRzxTxS15X77ohwefzElA7sWYi9UEo49MzJyefW41yGqvW+secrxw8t2t1okYEtQP/0Be
	g/fM1HgsUbzaWZ+vuHNqASY0EU31PaM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-447-xAbnf7bmMpyFJIwbt3-X6Q-1; Wed, 26 Nov 2025 13:00:30 -0500
X-MC-Unique: xAbnf7bmMpyFJIwbt3-X6Q-1
X-Mimecast-MFC-AGG-ID: xAbnf7bmMpyFJIwbt3-X6Q_1764180029
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-42b2f79759bso61237f8f.2
        for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 10:00:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764180029; x=1764784829;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9YgBhXcGSddKFMYnZCe5lp8J3od8fCjODxmcHFceGH4=;
        b=BeRHSyDph33YIIrOtPkUqn0Ee+YB2+bheZnOmV35LB31gSDWCy8TT4Drfv9EfQXDq5
         /JWmtW9Xaoe2KEf6Ca/N8anWj/8MzGJa0zXpEuL8D6B8d+lSDzSeI+C6gDTFGL/dB4w9
         kfQv7cIleEkK7JPep4T/6JId3e5vm0xLqip8SV3b766D+2z+LFONVoNCNcbaloVl5n8p
         PyJOuEFRS+BSk3ho32hEpdj3SJV9QsQJJa62mEc7G/DZOC3oWxy10sDngGfdTDt6ZkHS
         6zsGoLaY8hZISoXJO41lHhAovluvDhG2MgWrQ3uqSpw7yApIa61H+o9TADlDkZhKeSk4
         uGSQ==
X-Forwarded-Encrypted: i=1; AJvYcCUPZg8gakY1IYzw5GcmVW9U7duIQy5pyaNB+vPIqyq08YViE6MUOSgBsPWfHvNIlThOUV287sCEKuPxJQkamg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyOXJ31v4bpxw9XaDYfNOjHySE9/k/8fZETOzoa+9MKgl87SrB2
	EDN7FhSczAarEASSX6EELoC5+IBgO7+3zeAn+x8Ak7hyHDQBpCuQR9OgIHgVyMS/RPKaJhxiJRg
	fOL0pR1hC1OYllHn5TC9lUfr7TUjnyw4eW9azQ704EcX/pZcf2E/yZs3+B5qpDtUTbHoo
X-Gm-Gg: ASbGnct/ghifxvFxjFDXJQY73Qf3E9m+mVZZ8BOrU5Pqv1kGTq+yMR9pfU/ko1Q27zX
	pJ8MyeO+0Xt6RWeivT4JV250h3xPZODy8Wdelzr1GUHSD3EzrEnqXOqOiddGYAtm33ha9Lr5MHW
	Pom0XCHkCWO6y1jQwVoTnwj3SvO4h4ZUKRjPMrXsLC2oJKaupI6DSKWvdncQbbr+UwH2Fv8Xahe
	9Lmz7jzF2MW2GT00N3qftVbalzDmceVHu0Tmt49UUtobFYDmi6XfzIoJT4VYPE5x652lMCIqL/2
	DewaUqwffC+nUumTD+N5PR1bgY+KJu5Nskjev7LejuYuVVw+UuzZVjVox5sgE0GTrCMVj4rDnJL
	tKU8zuNTJ/Zho+RWRplka5zE5zoNt7w==
X-Received: by 2002:a05:6000:290f:b0:429:8bfe:d842 with SMTP id ffacd0b85a97d-42cc1cd8f9fmr23640972f8f.4.1764180029295;
        Wed, 26 Nov 2025 10:00:29 -0800 (PST)
X-Google-Smtp-Source: AGHT+IE0n3yZ2xVz1rTRRSLX3s4tZ7PRJCUewur62JS2UwJ6l+0kyCvE19owlYWk1fAt9tOk3rS6ZQ==
X-Received: by 2002:a05:6000:290f:b0:429:8bfe:d842 with SMTP id ffacd0b85a97d-42cc1cd8f9fmr23640923f8f.4.1764180028743;
        Wed, 26 Nov 2025 10:00:28 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42cb7fb9190sm42148196f8f.33.2025.11.26.10.00.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 10:00:28 -0800 (PST)
Date: Wed, 26 Nov 2025 13:00:25 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dan Jurgens <danielj@nvidia.com>
Cc: netdev@vger.kernel.org, jasowang@redhat.com, pabeni@redhat.com,
	virtualization@lists.linux.dev, parav@nvidia.com,
	shshitrit@nvidia.com, yohadt@nvidia.com, xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com, jgg@ziepe.ca, kevin.tian@intel.com,
	kuba@kernel.org, andrew+netdev@lunn.ch, edumazet@google.com
Subject: Re: [PATCH net-next v12 07/12] virtio_net: Implement layer 2 ethtool
 flow rules
Message-ID: <20251126125951-mutt-send-email-mst@kernel.org>
References: <20251119191524.4572-1-danielj@nvidia.com>
 <20251119191524.4572-8-danielj@nvidia.com>
 <20251124160517-mutt-send-email-mst@kernel.org>
 <1a770ddf-af27-4a44-95e0-b7971deac819@nvidia.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <1a770ddf-af27-4a44-95e0-b7971deac819@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: XaWRc6eWj6WUydqNUOGSbvmC79kxPHoJWWaOmD2tFJw_1764180029
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 26, 2025 at 10:25:44AM -0600, Dan Jurgens wrote:
> On 11/24/25 3:05 PM, Michael S. Tsirkin wrote:
> > On Wed, Nov 19, 2025 at 01:15:18PM -0600, Daniel Jurgens wrote:
> >> @@ -5681,6 +5710,7 @@ static const struct ethtool_ops virtnet_ethtool_ops = {
> >>  	.get_rxfh_fields = virtnet_get_hashflow,
> >>  	.set_rxfh_fields = virtnet_set_hashflow,
> >>  	.get_rx_ring_count = virtnet_get_rx_ring_count,
> >> +	.set_rxnfc = virtnet_set_rxnfc,
> >>  };
> >>  
> >>  static void virtnet_get_queue_stats_rx(struct net_device *dev, int i,
> > 
> > should we not wire up get_rxnfc too? weird to be able to set but
> > not get.
> > 
> 
> I prefer to do that as the last patch. That's what really turn the
> feature on. ethtool need to do gets before it can set. Also, this patch
> is already quite large.


ok

