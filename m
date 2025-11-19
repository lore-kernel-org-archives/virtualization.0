Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1077D357A31
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 12:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763556544; cv=none; b=g8ah2YwnUmzV9qkZpJfOY8kCck+G65NpEZiuZuGOO9N/AsNi35GVRUorZASI3TfbKw1UWXQZQcz88ZOj+9eyail42aBl6+Fv+MjwuExKg4YL12erBECT9rzNwBwwYCzQXhAKBHrlcDZ1BwGog2AKlGxN3cU7rnOYQGrTUc/1SnY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763556544; c=relaxed/simple;
	bh=UZNBewuvwkPWj+bu4O3n8vX8SbsHsZYXgD064ZW+wME=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=DjWcKC6UVNPRzyq4E+M79oS30fa5e1032ZwF6pl+f7noU23AOSI2ggEGu/Q3G+/M5LGUYRcsTo/3lQU3eWJA/Htu0NieWNmlBdlJR7Lo1S4h5WNJ5RBf5ZuL5g/bfr2ItRs6hbRQ72FlfGh/99D7Uyu+1L3OsGkFOcqzGS8C9sM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=XyBNZwEk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XyBNZwEk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763556540;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=efzFAXa6AqvKlr68xmTUgqr7OrHhr6l1HfrVAauk7zk=;
	b=XyBNZwEk4nm5xu8Yv7jWIJ/bNwmTNI3iLJ5GtfGLmr3CQ1uu36W5hfNm/vUytmf2Rj/3RQ
	/F8MMMGYrS6Tr4PtgsIqo8fc1QpsNBJSNeEt8Mu+TZ/6nAyxarHPA7tY+KK8e489BYw+by
	vEvuO8js/hzEO7r8ZtWVWo3kNUEwheU=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-278-L0VO0mV9OziyTECoFYmi-g-1; Wed, 19 Nov 2025 07:48:59 -0500
X-MC-Unique: L0VO0mV9OziyTECoFYmi-g-1
X-Mimecast-MFC-AGG-ID: L0VO0mV9OziyTECoFYmi-g_1763556538
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-42b366a76ffso3493610f8f.1
        for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 04:48:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763556538; x=1764161338;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=efzFAXa6AqvKlr68xmTUgqr7OrHhr6l1HfrVAauk7zk=;
        b=GTrsmrlFlqnQ09o+fcZMgXeost9+VEIljRb4HerbX1z0AqWaFnvWp1zCkoGCrmC0Zs
         c+/a9rvK5yCKQAPRLjeRd9nNivY3DaCLvJjwcwx6inp3Z/gbfl2vjIc+itjUJezBdMXZ
         AxqOIITAmvpUqLDXPgzzYUH/UAylQR7agtQtY6vd25mJD0foaSPVxT6qmcsx3xu3kgAv
         9zu1dyAR2F+n2hVaJUj3DKd0umfldPfYRSLFTXUfQ26Gh5VTyHvMyQrQrZMbnDX+bwwn
         BLm4pZ3uJSvfFZhZbAfFq2sa1tpAdoQn6qmHfyUtDwQW3GwNEIOPR9lCcZO396QIVOZh
         tphg==
X-Forwarded-Encrypted: i=1; AJvYcCXHFhuMupLYMin+zg8TY6Z5VeYUnVft0MF2849paGSHVQ2Cxh38BfbG+9SbbmOKocm1945E9tY+KpCpFvAVrA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzT0/O/AEmF4X+P46WyiiYmlEiHIJXw24jS345Jti8bKLd9jWW6
	TgVon8F7ZQZXc1E37nJORSNnGLvVGpiq7JZko+FekOXkf9wIogw6Yln2HJTJKDW3UGkRHDLgHjd
	eOlNVW7LHi+CyOzt8WdOnVoZwaUN1nUolljpzrfCji8EKj6Gc347xyWnolsQKHx1KThDY
X-Gm-Gg: ASbGncs3H3CeFg2Nki8+7gtfflyJjOFc0hQQ5BL9dVqCVzMjUM5K9WASc0qAOtTfw8y
	3B7Rx10BgqClQhLoAw0h7ZqP0OJt7jl5OZSOh53dE3s/FQbVdH9fCFkYmI1ikQ+e5Bkq/hXRgiJ
	N3+jzcnbyVns9pWucNZMMw/6VfBk8zcfvJAqxqYSVpKdX3Bd8Xoie4f5g5Wwe7TkSa7KnyOtl4d
	1cYdy8nekmujzPMsmZ4SfNfhH8uUak0mUlSWcbnyqLIf05qXbVt3Dj+83dYrzZUvyQlRd7bIkOE
	g9dwKHA5EXzNXfs2WIWtpkgK11iBUwQIFdgEY2oCpcxjVw+Vj04Ly1m53h4d2hJO/leSm4q9K3J
	s75cuz4Ny0U8DNeTpBbE56C3pry87QA==
X-Received: by 2002:a05:600c:45c4:b0:477:7658:572a with SMTP id 5b1f17b1804b1-4778fea84d9mr173008205e9.20.1763556537874;
        Wed, 19 Nov 2025 04:48:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IF3vS0uApFcgFVlL2gt/R9GTQH3kJDQoD3RSC3xgY4lk5mLnK8+RM+7y+ofmIidRok8jpEiHw==
X-Received: by 2002:a05:600c:45c4:b0:477:7658:572a with SMTP id 5b1f17b1804b1-4778fea84d9mr173007825e9.20.1763556537409;
        Wed, 19 Nov 2025 04:48:57 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-477a9e19875sm38753245e9.16.2025.11.19.04.48.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 04:48:56 -0800 (PST)
Date: Wed, 19 Nov 2025 07:48:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
	Jason Wang <jasowang@redhat.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Jonathan Corbet <corbet@lwn.net>, kvm@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org,
	linux-doc@vger.kernel.org,
	Mike Christie <michael.christie@oracle.com>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v5 2/2] vhost: switch to arrays of feature bits
Message-ID: <20251119074746-mutt-send-email-mst@kernel.org>
References: <cover.1763535083.git.mst@redhat.com>
 <fbf51913a243558ddfee96d129d37d570fa23946.1763535083.git.mst@redhat.com>
 <4204ed4b-0da1-407f-84e0-e23e2ce65fc7@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <4204ed4b-0da1-407f-84e0-e23e2ce65fc7@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: c4ag7qiC7Lru_biCocNzaNVIQWVHHfWLJ2Gi0J5OANo_1763556538
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Nov 19, 2025 at 12:04:12PM +0100, Paolo Abeni wrote:
> On 11/19/25 7:55 AM, Michael S. Tsirkin wrote:
> > @@ -1720,6 +1720,7 @@ static long vhost_net_set_owner(struct vhost_net *n)
> >  static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
> >  			    unsigned long arg)
> >  {
> > +	const DEFINE_VHOST_FEATURES_ARRAY(features_array, vhost_net_features);
> 
> I'm sorry for the late feedback, I was drowning in other stuff.
> 
> I have just a couple of non blocking suggestions, feel free to ignore.


Oh this is really nice.
I did exactly this and the diff is smaller while the compiler
was smart enough to figure it out and the generated code is the same.

Thanks!


> I think that if you rename `vhost_net_features` as
> `vhost_net_features_bits` and `features_array` as `vhost_net_features`
> the diffstat could be smaller and possibly clearer.
> 
> >  	u64 all_features[VIRTIO_FEATURES_U64S];
> >  	struct vhost_net *n = f->private_data;
> >  	void __user *argp = (void __user *)arg;
> > @@ -1734,14 +1735,14 @@ static long vhost_net_ioctl(struct file *f, unsigned int ioctl,
> >  			return -EFAULT;
> >  		return vhost_net_set_backend(n, backend.index, backend.fd);
> >  	case VHOST_GET_FEATURES:
> > -		features = vhost_net_features[0];
> > +		features = VHOST_FEATURES_U64(vhost_net_features, 0);
> 
> Here and below you could use directly:
> 
> 		features = features_array[0];
> 
> if you apply the rename mentioned above, this chunk and the following 3
> should not be needed.
> 
> [...]> diff --git a/drivers/vhost/test.c b/drivers/vhost/test.c
> > index 42c955a5b211..af727fccfe40 100644
> > --- a/drivers/vhost/test.c
> > +++ b/drivers/vhost/test.c
> > @@ -308,6 +308,12 @@ static long vhost_test_set_backend(struct vhost_test *n, unsigned index, int fd)
> >  	return r;
> >  }
> >  
> > +static const int vhost_test_features[] = {
> > +	VHOST_FEATURES
> > +};
> > +
> > +#define VHOST_TEST_FEATURES VHOST_FEATURES_U64(vhost_test_features, 0)
> 
> If you rename `VHOST_FEATURES` to `VHOST_FEATURES_BITS` and
> `VHOST_TEST_FEATURES` to `VHOST_FEATURES`, the following two chunks
> should not be needed.
> 
> Thanks,
> 
> Paolo

