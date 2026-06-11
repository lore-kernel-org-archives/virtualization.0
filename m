Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BC013A6F09
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 09:10:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781169043; cv=none; b=IVCwNVgrj5wc3y7n32YamiL+ZRCSyebKck+4f1yBH/HK7CUnBCF9QrbBOxg7f7mzivfwJA7tWIbhO9LCL0XcKiSButylGbfYyM8o0s7vsqP40AA/x1u66WC1C+mvqG/BW6EeICLmRki1rI2O6FfUWIjgul49tY2t4JX/kgbINf4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781169043; c=relaxed/simple;
	bh=ngimsOS9hzgh2ezE0TEY4e5wFmKWHB3Fv7cSOMsZbsw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=E5rWctqZfAc3wFimJXDYO1OyRrqjSwSgTV9Buw/J4XkBviatnnukCwyUlvtCKEM16QUqps9DoOqJH/UhEisNuUsnqj/3eX7BodIgkGwtoNbGiSjg8rH0QhD8PevrdDcE9LKvomoUa+hEqwV3OZsR1NVx8tLZ5VZ0O6qV4t7479M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=jD2ycoKR; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="jD2ycoKR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781169041;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=PriinPzTGWMIUfhykveslGOYnSGaX13PaffHy++jEKM=;
	b=jD2ycoKRz0UQyG5jFgRrGzGIIyYaNJc4AbXHiyNXz3rVFsGlqk8GtnRCQ9+T/W3/dAlBaq
	mGFQVtdorh0bm+IgbXTwvY7C5zPbPZqeYwuW0b69k6rQ+0thQOAh2oYh3EhWXo7+LfsKHu
	lcU40NXgqjHmqoqnLsvmIzNVHM7mPmI=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-55-a052kOc-Ovyg0d3RaXaDDw-1; Thu, 11 Jun 2026 05:10:37 -0400
X-MC-Unique: a052kOc-Ovyg0d3RaXaDDw-1
X-Mimecast-MFC-AGG-ID: a052kOc-Ovyg0d3RaXaDDw_1781169037
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-46010392f89so6929740f8f.2
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 02:10:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781169037; x=1781773837;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PriinPzTGWMIUfhykveslGOYnSGaX13PaffHy++jEKM=;
        b=CQtdL3gOP+P6THBWCPXTkxSQtQ330kejFU1ciCzrG8hVOINeO2SyOuImHkKe6cjjy0
         ZcPdnhnCRiQJNlf22qAzUPJYFdVnNz+hmmNIrZ0mpEMjXRpxden02ApLgn1TVkIWsz3C
         WccspiooyjpisISh5pIYDdJpP2GscqGowN1oPOH8p67JHwl0mM94c2hePjaDcSUOG41s
         oo4GmuXco3tVhERFH+LnCjrw7OO6l6iVh1pzIjkPmqmpYWJoKNEQPdBJZW9HIJBV4usp
         2x9FtWwduXevI7JzzgcbrNQFHSvhaqfzwirBKM4vKuBaKMHsWFEjKSurwEdFWoqmacJf
         QEGg==
X-Forwarded-Encrypted: i=1; AFNElJ+Ryhyz5E49ES58zd2HnmRzcsI2+zgq0w4RIOLJHaVxvnBs6QMcOZAqn+ulmOpmT6DwG4KKhvyUsEf3wIlEdA==@lists.linux.dev
X-Gm-Message-State: AOJu0YyjnPEqX4UZrQv01fs1PdyNJzaF2sdG53oiE0ghv+lqwN1VOmf0
	umQTFMR2ZEeJiEgbdpMSVZYBTFmnkGdxNg4bhGADutVde1DVlKQouzZzpS6X/7zbzWyMxpy2m7I
	Qk1CKYoqeuIlWI+nkAr7qlMe9fQ8MpmMzlbU6VO030prtEHOXMsYig4QBnDks6LXyju1l
X-Gm-Gg: Acq92OGClEfH9IaZGz/HnvG9g7XqGnhVnqMt85NpqDDkN+Ullr/eQRwn3nrFn3Ddc1z
	IFhif4oGFRPwg9lsGt2JZfgZYUP5codZnvPbj1vgbKWohvC6ULceA2QXzTV1y+yXxy+IHfFA2wD
	tzLIsAiYHOuvRPHYNrxkV412M5v4MlNIdHKqTxAAP/tzfRgvM5lvcherQPE1qA5NIZN0UonzCJx
	aZVC4mt3GxyypijgJ5HDJRWUe7ofKJclCuO6o9vujlLNPHJfU6GXxxFbZ4VzykfrY0BeHu5/4oj
	t9gAO8mxfVIavjddeEQOmQ14QTsDNhGIzwhPhgwzXQtxTvX0YOp+xtFxZgJN5AQHJYKxt8A30Sa
	dDdpfMwFaFnbNuczal6TZKKr9IpOqAF4FEN9dY/mlkWYzYpPfr0zAtw==
X-Received: by 2002:a05:6000:18ac:b0:45e:b21e:f840 with SMTP id ffacd0b85a97d-46067469f27mr2851817f8f.8.1781169036394;
        Thu, 11 Jun 2026 02:10:36 -0700 (PDT)
X-Received: by 2002:a05:6000:18ac:b0:45e:b21e:f840 with SMTP id ffacd0b85a97d-46067469f27mr2851771f8f.8.1781169035966;
        Thu, 11 Jun 2026 02:10:35 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-85-71.inter.net.il. [80.230.85.71])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4602cda3651sm68120262f8f.32.2026.06.11.02.10.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 02:10:35 -0700 (PDT)
Date: Thu, 11 Jun 2026 05:10:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Herbert Xu <herbert@gondor.apana.org.au>
Cc: Michael Bommarito <michael.bommarito@gmail.com>,
	Olivia Mackall <olivia@selenic.com>, linux-crypto@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>, Kees Cook <kees@kernel.org>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org,
	Dan Williams <djbw@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	"H. Peter Anvin" <hpa@zytor.com>, torvalds@linux-foundation.org,
	alan@linux.intel.com, tglx@linutronix.de
Subject: Re: [PATCH v3] hwrng: virtio: clamp device-reported used.len at
 copy_data()
Message-ID: <20260611050731-mutt-send-email-mst@kernel.org>
References: <20260531142251.2792061-1-michael.bommarito@gmail.com>
 <aio83ZWadVTiuNpR@gondor.apana.org.au>
 <20260611025916-mutt-send-email-mst@kernel.org>
 <aipn8sIAQ6Ai2sax@gondor.apana.org.au>
 <20260611035035-mutt-send-email-mst@kernel.org>
 <aipvZhfvdtRxOQm0@gondor.apana.org.au>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aipvZhfvdtRxOQm0@gondor.apana.org.au>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6qpQ6Yxk3J8dzx7vtDgidZDbpUQe7BU5GLE2EuDWlBU_1781169037
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Jun 11, 2026 at 04:18:46PM +0800, Herbert Xu wrote:
> On Thu, Jun 11, 2026 at 03:58:17AM -0400, Michael S. Tsirkin wrote:
> > On Thu, Jun 11, 2026 at 03:46:58PM +0800, Herbert Xu wrote:
> > > On Thu, Jun 11, 2026 at 03:30:14AM -0400, Michael S. Tsirkin wrote:
> > > > On Thu, Jun 11, 2026 at 12:43:09PM +0800, Herbert Xu wrote:
> > > > > On Sun, May 31, 2026 at 10:22:51AM -0400, Michael Bommarito wrote:
> > > > > >
> > > > > > +	size = min_t(unsigned int, size, avail - vi->data_idx);
> > > > > > +	idx = array_index_nospec(vi->data_idx, sizeof(vi->data));
> > > > > > +	memcpy(buf, vi->data + idx, size);
> > > > 
> > > > All the "malicious device" things are confusing. Spectre things -
> > > > doubly so.
> > > > 
> > > > So if an access is speculated then CPU might speculate feeding a kernel
> > > > secret into RNG. And then the speculated RNG value maybe can be also
> > > > speculatively be used by some kernel code as an index
> > > > to trigger a cache access, finally leaking the secret?
> > > > 
> > > > Maybe?
> > > 
> > > The way Spectre works is if you have an actual instruction using
> > > idx directly.  I don't see how that translates to memcpy.
> > 
> > I am not sure it has to be direct:
> > 
> > if (malicious_idx > SIZE)
> > 	return;
> > src += malicious_idx;
> 
> Wait but vi->data_idx isn't even under the hypervisor's control.
> 
> It's an index maintained by our own driver.  So how can it be
> malicious?
> 
> Cheers,
> -- 
> Email: Herbert Xu <herbert@gondor.apana.org.au>
> Home Page: http://gondor.apana.org.au/~herbert/
> PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt


data_avail is under hypervisor control

        avail = min_t(unsigned int, vi->data_avail, sizeof(vi->data));
        if (vi->data_idx >= avail) {
        	vi->data_idx = 0;

and maybe this can speculate past the if?

I agree, this is all speculation )


-- 
MST

