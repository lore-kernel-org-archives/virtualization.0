Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAA1823D7D4
	for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 10:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760955098; cv=none; b=NQxDSY+8EfoKR+gzvCGvD1T9f90/3bXPbiYKplu/57m319hUs67JkfNAep8OI88fnXLuKP3/MQSyC5ABm2WLhvJn9BhLKZRSZ44kT9b7u8g5fSPhMUpOsg5eerFvUGGAJ2wMclQ5hJK4Lj0Thg3WbrnMIFg5r1wO71UfElkarFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760955098; c=relaxed/simple;
	bh=ZHTslemG6vD7mveUfKMEef1heksyeaxeei4lGFbU3eA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ylky5Xh3xeV2CIzeZfD6AF/Q1FCN3tdD5wixfuwyb4YkuOiDmcuxjbdl6DKYUeUdLfhThpr6rhI57yLD73x4/6BUO3ifPbM11LmGx5pRmBcXWDjdj69g49/KPGdTvnAJMR0XTNYwZBV+XJ8jSflfwPGdPl2whWhU6C9plwfdVaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YJqDUezh; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YJqDUezh"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760955095;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=By7D5EDOrUkPayF85rpQrUjI0fj8mVU6g5pLLb1g4yk=;
	b=YJqDUezhOd/uN5Ep5cY19bXOkRaCzT8P8Y2BM5Kl3dJmsMB6Khq0dCp9bPDPWcKwmJJxd/
	4JYrYhpTrWqyGPJR3ZfGO8bwoXscxzvi5KFARyuW6x8JPMGlbXGKaTLaYyug3ztRMdFTnA
	wswJZEbjL8DwxTzuoOkjhxRHEiauumI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-116-aC8ynd5WMoi-CCaohH3YJw-1; Mon, 20 Oct 2025 06:11:34 -0400
X-MC-Unique: aC8ynd5WMoi-CCaohH3YJw-1
X-Mimecast-MFC-AGG-ID: aC8ynd5WMoi-CCaohH3YJw_1760955093
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-47113dcc15dso30822125e9.1
        for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 03:11:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760955093; x=1761559893;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=By7D5EDOrUkPayF85rpQrUjI0fj8mVU6g5pLLb1g4yk=;
        b=D2n3ebkX23NyXrRqH8P5kGGxVWz/VhIwB124Emmegmij2rz1Pmu9zggq0xJHqPqHOF
         EzSVx3PoWrx7VgPylI1KkIkNDl1U7Z1GN/NLv+3UIeSmJxUzo8Se/iakTfJ0MpUudLc5
         Kv+r/JRVOrksDR2zMQ+0DyBcqDsXJAfZxWw7Mi6/Kn0pHwfXMVA8MhtuzZ1S3puzypi8
         D7JTarvyfwvsXFyn6bBLnxugAt3olCGx167sqs4KL//evy1ieGJgtnX1ivx0b9UqbxUN
         dbn1jEJlP2tLZH7ZM4sEuaGqlXay414+h3+N1H9sVqcApBcohVlvJmKYpHO3kXwvuVhp
         mvPQ==
X-Forwarded-Encrypted: i=1; AJvYcCXjP9GTDxnKAa7Y/ICUP1RB0swXqW5Ysy/Je2fz2ova8ZlvUP4/sOySw6/1tUwJ/1mHx+uqBct5UlYIkMmCLA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx7GYicWyzooWnijn4n1/UUAP5/KVBKYZWlo8I/DwPmHNwIivim
	oi9+FDjGdC+GRi+AuNcEPLumvbdsUD1Fk/Rx++Wc9VBRoxw/qLjMo8Dwmc3Yy3aREazAjfqyasv
	dxnVjxbGeq+rUh3V/usQEO2K+c1Ful05nofBFoNDqMVE7IAoUQhNYROWC3QGkIz5KfUoMF7V+ZH
	G6
X-Gm-Gg: ASbGnct/34BkZgx8tb6wfihDh8OskKjhmamV3iyds3usH9FJbJchU4yw44N0mXW/vzM
	ul2VujMz7N1XPaOu6XV8co0VXB4cpI7PiOWx+m/A5v6F1zP+fhpgNo5Ya4DDSbi40wBzqvKSTJi
	KYF1tt4pVKCObW9lP5L/NbuleeYKckhIQe/MoL+JWMF+DORMt9KusT6MjSe3LzTuljTyEYwe9b7
	OIVyRAs/he6lgZErPp6bVXMwrzuqUc4wLGRAsTDZ9JK0xBiM/TXNchM66i1av5YfFt97PjbCwLW
	IP97DaUepm/oeOLzzKYr9U+WKeZTlY8aG2c7uRxpRItbQlkHqmwRiQh0VSJ+3i2ohQve
X-Received: by 2002:a05:6000:2512:b0:426:d589:2633 with SMTP id ffacd0b85a97d-42704d993d3mr9607611f8f.44.1760955092894;
        Mon, 20 Oct 2025 03:11:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEcCqLGIZso6bGMyB5AaLWkPWA+ClbR/rzs2RDoBD+0IFStoS89flwVj7QRG0ejepqFb1hRXw==
X-Received: by 2002:a05:6000:2512:b0:426:d589:2633 with SMTP id ffacd0b85a97d-42704d993d3mr9607593f8f.44.1760955092488;
        Mon, 20 Oct 2025 03:11:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427f00b9fdfsm14430388f8f.40.2025.10.20.03.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 03:11:32 -0700 (PDT)
Date: Mon, 20 Oct 2025 06:11:29 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 19/19] virtio_ring: add in order support
Message-ID: <20251020061049-mutt-send-email-mst@kernel.org>
References: <20251020071003.28834-1-jasowang@redhat.com>
 <20251020071003.28834-20-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251020071003.28834-20-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: vMJpdQflsZ0ujKVlOYaRJff99KvYmgYqJ3ZlS70UFvY_1760955093
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 20, 2025 at 03:10:03PM +0800, Jason Wang wrote:
> @@ -168,7 +172,7 @@ struct vring_virtqueue_packed {
>  struct vring_virtqueue;
>  
>  struct virtqueue_ops {
> -	int (*add)(struct vring_virtqueue *_vq, struct scatterlist *sgs[],
> +	int (*add)(struct vring_virtqueue *vq, struct scatterlist *sgs[],
>  		   unsigned int total_sg, unsigned int out_sgs,
>  		   unsigned int in_sgs,	void *data,
>  		   void *ctx, bool premapped, gfp_t gfp);

BTW this should really be part of 13/19, not here.

-- 
MST

