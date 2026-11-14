Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.56.87.2
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794643099;
	b=gqzkruSpA0ANooeECEo8YTC6N5GK354KJP138trRVH0+utXnvJY8f9N8cPclWQKbpub3
	 S1OIxLfyyOBMknns94qz7OOp/yIg3XAHcgFnUbqcH40GvB/mmh8qdY/yvsnYLZytQOyyW
	 Wr2eeEnTBUJ9FXkWObgpLDCqWofmt9dBGjKvr7Jlg3jUt/gmaMk2YPhPJ7GI0hBukNBxH
	 GbSppeo5u0HPgX9m8mxTrrFBO0PI4JQrm7A/Usl+fcAZuFXDS4JQNPKjHrweL+PN/3oJQ
	 M6Ze6+S9IbJoPXpbRFXTqxAH/mImW1T28g9Tn8wN7q8ogFLvAJn9iEvhFN9HNA3qZjA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794643099;
	h=DMARC-Filter:DKIM-Signature:Received:DKIM-Signature:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:X-Source-Dir:
	 X-SGantispam-id:X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:AntiSpam-DLSRS:
	 AntiSpam-TS:CFBL-Address:CFBL-Feedback-ID;
	bh=jA+sLX6FuAJLOpO1NCKwUHJ+bXZyD4SXvSbfSoXOmV4=;
	b=K939/MJyYuor+ZJuBLtfvhlpgeP6LFaxYQcJS9liKXSqwuaJJEtk+MeWn+p8tvzvxrFB
	 EqdP6D/+soJjV7bvGAPOsjDxqx8UrXjxR4ar6MJCIJXye0WtwxG7pQuVbdgzwI3vgSztV
	 8zYTxw39djBM0PgEP1kh/9IQkomwLsMRBZO6FTRR6sHBD6pm0KNus3GXOjW+jzZtNeT8p
	 43APVgjpuj1YdZF6dGNb6odKpii9xcRyIKMAVGEi0Ev/lvZqsBkji4JBJJD7wKyShL2XY
	 gETkkz1fxrx7YpWELdT3AkFgV1z7pZLuFwi0hswkpPT8Dt+u5zdiPD7xiTK+l6a7Qcw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valla.it;
	spf=pass smtp.mailfrom=valla.it;
	dkim=pass header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=JNXjfazz;
	dkim=pass header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=sEN3M3QT;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.56.87.2
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12ADC606A327
	for <virtualization@lists.linux.dev>; Sat, 14 Nov 2026 07:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 12ADC606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=JNXjfazz;
	dkim=pass (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=sEN3M3QT
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-c9nw.prod.antispam.mailspamprotection.com; s=arckey; t=1794643098;
	 b=fBIwNY/kQDppoO86W9FRFoNklzS9lqhqWFyDTAGXLSDu5bAH1y9Sul6mAAQFZyuZuvNvmgHei9
	  Tk2Tj6euFzr4GWLwMUm1J2W9TgZL22hjQeRJhD2p3L1mjVhTf6LpVmDjA5nvIxOaYX7PaKR2yY
	  xOyoRzp8OKWvit2Cz6EhofLutp8QmYLTu1lFN1qN3APqZUNk6D5YvceIJ0C9tuueYdJOzNWpmW
	  g96DD2nCyBlndSk11TiZVQAaptkjKorAVpTaTFFqTnIxAz0feP3V6ydlZocyh2SYP0pUSVpUSz
	  w5DxrLGNWlRhk6eIO8eC9d9Hw2DvaMRY/5Wms+FojszSkQ==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-c9nw.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-c9nw.prod.antispam.mailspamprotection.com; s=arckey; t=1794643098;
	bh=8IWj/0VY0T5tZdfo4gxNmRXp9p/VjborN97vhgdYfz4=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature:DKIM-Signature;
	b=fm8odkrS7kXfdGAxhccJhKffVF+EbohMtR8CP95ze+wAgmqdGgLuaOEQV39W1IPrauVNsvK1mY
	  rrBinOpzJu0HP9mZWRRoY+dcQMBWYEep+FS0c1i922qdL0mluUWpa61IeZJncWRNscZtm5N0R2
	  kZ2u15kD81697tKnk9hFuzeWyr2QUCCq4R7cVsluGUG+vtu5LnCvUlYGY+1WcW5qv70lELSOW3
	  J5IrOvNXHMNs/3Q4ofZ+jNpCQmzx0TqdaqPdwAD0CBNfZ2iOJmfAGDianFxJBmaQzCQ6Mz22TC
	  LCBqVZ6Joo1z268Khfi7L7KeK/0H7ck9wi7XEWzESMF26w==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=jA+sLX6FuAJLOpO1NCKwUHJ+bXZyD4SXvSbfSoXOmV4=; b=JNXjfazzJBu2pEJWeWlFqQsuKU
	ES4vdvufSE1HUx4DJQ7Mjg/CPn/MbivAYjO4S2on/Gki1xIOVdwicPqIq2dloP5q1P0mmMjA9MNpb
	jEqrgq8ir+94W51Wydt48JRwgsbL/2CuM9bNU0EvtyDMAKmVD/PomxCIp5k27mO+WQNk=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-c9nw.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xS8eI-00000009k9C-2WXB
	for virtualization@lists.linux.dev;
	Sat, 14 Nov 2026 07:58:11 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=jA+sLX6FuAJLOpO1NCKwUHJ+bXZyD4SXvSbfSoXOmV4=; b=sEN3M3QTXDHOH2KkWCqKKNKp2r
	1ooxvN2B2ME9NDt15AUqxezXl9/UAtaoRxDDZgA8kFXll/hUNN8ACcXIHwGkJvCrLmQBjLvel98p+
	izoR2TSwC5nxcK6MIKKpb7gIoh8O8l9KVHUaj3bL/tPaA4EYnuUx5GiaqpUSEBcSGI2E=;
Received: from [95.75.15.255] (port=5081 helo=bywater)
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xS8e5-000000002dU-2bF5;
	Sat, 14 Nov 2026 07:57:57 +0000
Date: Sat, 14 Nov 2026 08:57:55 +0100
From: Francesco Valla <francesco@valla.it>
To: Stjepan Poljak <stjepan.poljak@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andy Lutomirski <luto@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	virtualization@lists.linux.dev, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] virtio_ring: reject a split ring size that is not
 a power of two again
Message-ID: <avgUMQjBDIGskHBK@bywater>
References: <20261112154927.4004184-1-stjepan.poljak@gmail.com>
 <20261112154927.4004184-2-stjepan.poljak@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261112154927.4004184-2-stjepan.poljak@gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 62cdaf09d12ed8d078541b5ca1311bfc
X-AntiAbuse: ID - 62cdaf09d12ed8d078541b5ca1311bfc
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xS8eI-00000009k9C-2WXB-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-c9nw.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

On Thu, Nov 12, 2026 at 04:49:16PM +0100, Stjepan Poljak wrote:
> The split ring indexes its avail and used rings with num - 1 as a mask,
> so its size must be a power of two. Commit 2a2d1382fe9d ("virtio: Add
> improved queue allocation API") moved that check from
> vring_new_virtqueue() into the new allocation path, which
> vring_new_virtqueue() does not use.
> 
> remoteproc calls vring_new_virtqueue() with a ring size from the
> firmware, checked only to be non-zero. With 100 entries, for example,
> the driver would put buffers 4 and 8 in avail slot 0. The device would
> look for them at slots 4 and 8, possibly reading the wrong data.
> 
> Put the check back for the split ring; the packed ring has no such
> restriction.
> 
> Fixes: 2a2d1382fe9d ("virtio: Add improved queue allocation API")
> Signed-off-by: Stjepan Poljak <stjepan.poljak@gmail.com>
> ---
> remoteproc still reports this as -ENOMEM, although the "Bad virtqueue
> length" error names the cause. Returning an error pointer from
> vring_new_virtqueue() is left for later; the same change for
> vring_create_virtqueue() is here:
> https://lore.kernel.org/r/20261106055635.3019889-1-stjepan.poljak@gmail.com
> 
> v2:
> - Log with dev_err() rather than dev_warn(), and say in the message why
>   the length is bad (Francesco)
> ---
>  drivers/virtio/virtio_ring.c | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index f683a2d6a200..f855b8d41575 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -3513,6 +3513,13 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
>  						    name, map);
>  	}
>  
> +	/* The split ring indexes its rings with num - 1 as a mask. */
> +	if (!is_power_of_2(num)) {
> +		dev_err(&vdev->dev,
> +			"Bad virtqueue length %u (not a power of two)\n", num);
> +		return NULL;
> +	}
> +
>  	vring_init(&vring_split.vring, num, pages, vring_align);
>  	return __vring_new_virtqueue_split(index, &vring_split, vdev, weak_barriers,
>  				     context, notify, callback, name,
> -- 
> 2.53.0
>

Reviewed-by: Francesco Valla <francesco@valla.it>
Tested-by: Francesco Valla <francesco@valla.it> # AM67A, rpmsg with R5F

