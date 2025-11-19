Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3CE3587DA
	for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 12:35:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763555708; cv=none; b=lZhrNluD9NRo3ktZalLhdvyKt/Bv6Evou1wCywSNw8C/UtEySlK+Vjnxf3TUXzkw73RbAk4/IRUYA9Topq0TEqJB4vV3aqTZItSEk8WEnWIxF+s8W0+VtRC8uKdAexM9X6nHX2KQSX2+QgU6oDn9y2cnyTcdcUwy0qLa1RGqQ7U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763555708; c=relaxed/simple;
	bh=EPmrUepgE1rgeLfHqD5slhvdiL6tMO9t2cr77eQyKts=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=SfJrtemhrVX6RnvE4JhkNK7vMwU1so4JmQgwJp4XI/tuZL+1M+4/nZYmblMw41hu9ZBoKP0NZvSES2etkT/sdaanECqYXPfy6OpRMQvsthYKXNkbT8v1gzhbergVYOk0tQemU5J52PAfYpHHf7e7rjoyyW2vHXqfBu0MKb8R1n8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Y0j+n6mo; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y0j+n6mo"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1763555705;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=cX3V/Maq1P62aubbfEZMkx/73yOAMpSFaKpbQ5l618w=;
	b=Y0j+n6moUkptffLGrnn3nt9m9vC8WA7dualthxVUXZ2ce6gZa3mCVM8Ylm00/1OIflUbvw
	vpDBv0uWVxDIFp4zjnSAFY9DCff/A37cxuhliFPyR76CxiEZSFGAswruk6AHBx8qrjp38d
	ZKNLFT6llztvKboDuOiOHXiueGnSWOk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-683-ge7XfKPxN66rs8FCWJ2dyw-1; Wed, 19 Nov 2025 07:35:02 -0500
X-MC-Unique: ge7XfKPxN66rs8FCWJ2dyw-1
X-Mimecast-MFC-AGG-ID: ge7XfKPxN66rs8FCWJ2dyw_1763555702
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-429c76c8a1bso4029150f8f.0
        for <virtualization@lists.linux.dev>; Wed, 19 Nov 2025 04:35:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763555701; x=1764160501;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cX3V/Maq1P62aubbfEZMkx/73yOAMpSFaKpbQ5l618w=;
        b=aq49qIGv9eEAHcYZzams6flBqMSQxToY95qStSTRluTNAtCiv/9w5EtwkeBUPlmwt/
         Ofdj74xiIGX5osUVtX02Mitbk4zrpVk5mJg4LypXGSSwp1VV8GJEOEEmsgYajRA9tgW1
         VGgIfgvn9+Uc5njUO4yhdezCN/Y3eNuJmczlOStNfp2gaMwf1xxJdDvwHYWXPI/Sza0o
         j0map0j1tdDHOqlLTV/blK5U5nrxE2ckJDbmuN78PhEjdILZtYWG/MEpmkmdG4nR2u8z
         DRNFS9Fs6QQ71Dgz51dY6sKT/t42N0ohXoKvJ6e3ECfw8Qq+wqJKRe+y58vNoNMd0U8S
         TteQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxTbxaoJfcbFdajKzev9uJXIgv49vyql2U3lmSUaJ+9LzCYqVUlzv7rcHByPA1Wios+9HzvbPWyLUtEmlA1w==@lists.linux.dev
X-Gm-Message-State: AOJu0Yz58ZFSJZQbnrhMs/GochR//W0JoAVhpRFuaH8EmwqEue1AXaYk
	ttZEkB+FrUuQ8f/96UbljrjdP74cfNYloBXplgZCq9GWMEeAqzOsxgDBcMOsnTrN6VnZ8uh6g8H
	3EO/6I88+Uhsy+O1sBWlktNlWB3q1XscU4+oVACOHpHZ0BuIhrmUHHMnRGSc/Vts4DWIP
X-Gm-Gg: ASbGnctx0i/GoNm/KQoiC/5JezvigMgGJ4e8amlh8+meYKVltggxVWZeRJSpdZDy+fa
	DnWKuDcsVhPfOMEnZfjoJPzEnqx+I9/RoqFj9h+1+5sJy1Pwz+e60RVI8fc8KJhVz/GPbWuuoIc
	QyPnk74rWPYphhwX7zkFzr40bx1f9d7M9v4RpJyLJs4wlDzPtHzUIXxzK9Ao3g2Jd0Swg3W30/f
	r0ABSbccCgjSJnWICH4tIIiVxu4DMemaLP1AP02I0BZfsOLHV1ftQ33umfv/0RTvygb7jehvukB
	Di3WfFSvlGwhCnbkOfHxzmVaQ/hsIGMTA44CagQyyRhLR4KuYXpnTosjDumr5Q5dxXMxFWQYbwE
	mhymxgJSUfFlbNVyCHxwjLU9Hy6epig==
X-Received: by 2002:a05:6000:2c05:b0:42b:4177:7135 with SMTP id ffacd0b85a97d-42b593721efmr18718636f8f.41.1763555701514;
        Wed, 19 Nov 2025 04:35:01 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFZDtCaU9W4jbuIEbB8KCRjqHZi966/jHceca8fTLxnbGRC0wWJ1uQzXqWj/dl06f43gIEXkg==
X-Received: by 2002:a05:6000:2c05:b0:42b:4177:7135 with SMTP id ffacd0b85a97d-42b593721efmr18718600f8f.41.1763555701078;
        Wed, 19 Nov 2025 04:35:01 -0800 (PST)
Received: from redhat.com (IGLD-80-230-39-63.inter.net.il. [80.230.39.63])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f174afsm36933997f8f.33.2025.11.19.04.34.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Nov 2025 04:35:00 -0800 (PST)
Date: Wed, 19 Nov 2025 07:34:57 -0500
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
Message-ID: <20251119073155-mutt-send-email-mst@kernel.org>
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
X-Mimecast-MFC-PROC-ID: iwerdFwa7cyxytEKiNRqlArJNQi0te1hsTcqfx1zJMg_1763555702
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
> 
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


Ah. Good point.


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
> `VHOST_TEST_FEATURES` to `VHOST_FEATURES`,

This one I don't want to do, people tend to copy/paste code
and this is not what devices should be doing.

> the following two chunks
> should not be needed.
> 
> Thanks,
> 
> Paolo

