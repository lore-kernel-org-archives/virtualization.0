Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0CE138DE0
	for <virtualization@lists.linux.dev>; Thu,  6 Jun 2024 06:05:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717653931; cv=none; b=lWE8y1wTHa9A+hEduS1gVBumftdUyJP/fYqRZRrJtyB5+9c8wKOX3lBaFVDh5IgaKFN1mdpjUjyzWd6Q9t8tXgMQfwenudZUHS+Af3y1+8LwbN4iCi+Jumzc/GN4gGQ4Jx8+vwFIMiaIjIfpZOzrdJkvoMmHlCC9Tcun8RtLPuc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717653931; c=relaxed/simple;
	bh=xZKIrW8/SuE4qqD2uv3M3ACaJ92yjjULx+qrf+XjCxk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SRJr6cd+nyhZjyelM3bBUR9o27fhQgu/6Yto4Vhn2jqb6WuL5iQk7SE6fTah0HPeSeyZP1/TIsjyEsKUnpMGQJip23CY5Tw6mJAH9UwLKbbVcutPxa5SV3bXpkU2IymrgK+RqwLE8p1CHP+oF2OmvmFIFZmh1bLEOAXy9dp5arY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SBg9g354; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SBg9g354"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1717653928;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=TsrZUlxApod7nrUSmaJxIfXQuT4xkPv6XR1BlDjdQ14=;
	b=SBg9g35448Qji+n1KyTNFucpKvFBelXQuco1gcPXh1fUSa0v0n9FQhCVSWjQvKY183hiRm
	n/tkQackdBiN750+M6NGVrdUOF14HZsP7qEAdZPSVwPkot590xorMw/vxGZrK9NQTBpdzY
	nAfpa/x0ixiD53TZSCgnIBLkOVc+D3o=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-131-h5qqdUY4P0KrkqBre1lD5Q-1; Thu, 06 Jun 2024 02:05:27 -0400
X-MC-Unique: h5qqdUY4P0KrkqBre1lD5Q-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a68b41fb17cso149701166b.0
        for <virtualization@lists.linux.dev>; Wed, 05 Jun 2024 23:05:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717653926; x=1718258726;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TsrZUlxApod7nrUSmaJxIfXQuT4xkPv6XR1BlDjdQ14=;
        b=iDLcxyQOJOixAEIESwGSsGi27VbVf3IBb9Ye0VY8OD1tYC33ndzD/JijepGq075G3C
         +q4G+Aokp20xhJ+XM1w7U8ynDXjx3pJhWMx9Ri9HC+LFiyc1gAt9tGTjaaA1rYa07VHV
         GxGWqoStaZ2vw7xRMK+CnGm7yddBqWQKqfOvVJP9deKMG0sdKndu0g0oHZF4O1QgZRqF
         hS48IihB68Up4HJCRL1Sufd70+EFFntmF2zZNjH0G0atzfGluWbyBT1ZAcd43qaQrO+m
         JqDmVQ7mAEZQ0ps9xpKQF34uoTLpc5SfYY6po3zR7Tho7r9AX2N4yLJizf26bvIN6SVX
         BSZA==
X-Forwarded-Encrypted: i=1; AJvYcCXbm+CXjan+lp6ZfHfT5xgy2eTEaNIq54oyIi5a2VZhQN0/W8jxx6nbHj2s/fi6OrAN1CriEn0c/thUKr8gdjB4btXq5AXE0YKyrhAGbsg=
X-Gm-Message-State: AOJu0Yw/PFfuL06zM12o47G0COwX97SihIJS9lpF3yjoKrUS77NodN5U
	4CABFeR96KMioL8LTW8IXhCbrrlNrNTv5RYV3R0ax32h0bU/z/CBES8CxZVvoqEa8Pc5RZVKeLX
	xDtPSeqS2NfNElDRAI97w+lwvwrzA9qjBCaJI23WV9yg8uJwYTe6DPNTFkCu69swH
X-Received: by 2002:a17:906:b198:b0:a59:9f88:f1f1 with SMTP id a640c23a62f3a-a6c762bcb66mr147655666b.19.1717653925934;
        Wed, 05 Jun 2024 23:05:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHK8HAAcmA9u09zvEwVLZTGKDryhlokys9J5BLeWli7B/moSHAoVGjthnoy2bJ5A/eL6Fnn6Q==
X-Received: by 2002:a17:906:b198:b0:a59:9f88:f1f1 with SMTP id a640c23a62f3a-a6c762bcb66mr147653066b.19.1717653925439;
        Wed, 05 Jun 2024 23:05:25 -0700 (PDT)
Received: from redhat.com ([2.55.59.85])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a6c806ec823sm44887766b.101.2024.06.05.23.05.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Jun 2024 23:05:24 -0700 (PDT)
Date: Thu, 6 Jun 2024 02:05:20 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: Jason Xing <kerneljasonxing@gmail.com>,
	Heng Qi <hengqi@linux.alibaba.com>, Jiri Pirko <jiri@resnulli.us>,
	davem@davemloft.net, edumazet@google.com, kuba@kernel.org,
	pabeni@redhat.com, xuanzhuo@linux.alibaba.com,
	virtualization@lists.linux.dev, ast@kernel.org,
	daniel@iogearbox.net, hawk@kernel.org, john.fastabend@gmail.com,
	netdev@vger.kernel.org
Subject: Re: [patch net-next] virtio_net: add support for Byte Queue Limits
Message-ID: <20240606020248-mutt-send-email-mst@kernel.org>
References: <20240509114615.317450-1-jiri@resnulli.us>
 <1715325076.4219763-2-hengqi@linux.alibaba.com>
 <ZktGj4nDU4X0Lxtx@nanopsycho.orion>
 <ZmBMa7Am3LIYQw1x@nanopsycho.orion>
 <1717587768.1588957-5-hengqi@linux.alibaba.com>
 <CACGkMEsiosWxNCS=Jpb-H14b=-26UzPjw+sD3H21FwVh2ZTF5g@mail.gmail.com>
 <CAL+tcoB8y6ctDO4Ph8WM-19qAoNMcYTVWLKRqsJYYrmW9q41=w@mail.gmail.com>
 <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvh6nKfFMp5fb6tbijrs88vgSofCNkwN1UzKHnf6RqURg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 06, 2024 at 12:25:15PM +0800, Jason Wang wrote:
> > If the codes of orphan mode don't have an impact when you enable
> > napi_tx mode, please keep it if you can.
> 
> For example, it complicates BQL implementation.
> 
> Thanks

I very much doubt sending interrupts to a VM can
*on all benchmarks* compete with not sending interrupts.

So yea, it's great if napi and hardware are advanced enough
that the default can be changed, since this way virtio
is closer to a regular nic and more or standard
infrastructure can be used.

But dropping it will go against *no breaking userspace* rule.
Complicated? Tough.

-- 
MST

