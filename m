Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.56.87.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794433908;
	b=Tkt8u8xGwrbGCYbUHQwIab7kZOXNV9T9TyFmYKcc/nFvEp+WavGxwzgQDjGSwkWFLIzZ
	 8QHiJwcXPEHWLx4co4UlN3TiBkNPrq8awI8YPlsFWHv6I5ZTf3fyc5FIVhDGDVkGOoahd
	 OkSxIfJaFsL4iMqS8LtWl7YfyvGNRRfrmnEdnYDaoeRwg958iN9Bveygr/D5Tj9k02gbU
	 s0MGLMAJGVywaYEXPzSxS5Ufe7HceWxOxbjwzj5JBWbjTNdeh1bC4t1VCDWUKVCIgIOj6
	 X/SUdNiUob3MqOh8HVR4/uRvesBF/6WQ1U4gU7C21Sp3eJik8JrBisQHhwgqrFYmIOA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794433908;
	h=DMARC-Filter:DKIM-Signature:Received:DKIM-Signature:Received:Date:
	 From:To:Cc:Subject:Message-ID:References:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To:X-AntiAbuse:X-AntiAbuse:X-AntiAbuse:
	 X-AntiAbuse:X-AntiAbuse:X-Source:X-Source-Args:X-Source-Dir:
	 X-SGantispam-id:X-AntiAbuse:AntiSpam-DLS:AntiSpam-DLSP:AntiSpam-DLSRS:
	 AntiSpam-TS:CFBL-Address:CFBL-Feedback-ID;
	bh=Vbx0Meut0QWhwLY5JReWROPpzdfMrBn/4+QeVAVvMPI=;
	b=vGdUqPJvUCN41PtNsI1VbvyO4ZPxeEB5FZjpcvxUVvPAXQKMRFSkxi3we/SZE36aGoeW
	 jwQYh0Dyi3kdOEyP+IDO4S/YibX3KtWd/Zj+ftd+EB/+JjOfnypcS+Kx7rd/YezgMOoXh
	 MIIB5l64haOhN225IM9Pah14iQcIr3geXLcrWqHJICB68GOMy/LI6AUsIeAwbW1VQeeC4
	 vS9aSTh/dIsvxxt78inXnfpdVpqRP+NsaQ4eA7Dm9Zyepi2jv5wGM93HR5u8ebp+cXZ5/
	 WyKyXzoizIZEygKS3BRfw0j2U4H//USy3SCvpbn06K3YFn4m5bE0hfZ0BSaTtl8fPxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=valla.it;
	spf=pass smtp.mailfrom=valla.it;
	dkim=pass header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=N1lUvULp;
	dkim=pass header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=Aq6+g+6A;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.56.87.11
Received: from delivery.antispam.mailspamprotection.com (delivery.antispam.mailspamprotection.com [185.56.87.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BB83606A332
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 21:51:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8BB83606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=valla.it
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=valla.it
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=antispam.mailspamprotection.com header.i=@antispam.mailspamprotection.com header.a=rsa-sha256 header.s=default header.b=N1lUvULp;
	dkim=pass (1024-bit key, unprotected) header.d=valla.it header.i=@valla.it header.a=rsa-sha256 header.s=default header.b=Aq6+g+6A
ARC-Seal: i=1; cv=none; a=rsa-sha256; d=outgoing.instance-europe-west4-ssp3.prod.antispam.mailspamprotection.com; s=arckey; t=1794433907;
	 b=IUrBP3+nnsqpIMXDMemnIM/Ox8qcCcNzjkp75tZpGwCcVxyd7kJPnFgeItxjlhoHMEMsyRE02/
	  gzaIrz3YSCOZJ3B6KJgHq7op3ucOmho3J0gu9DzhFl8lFJydSkEzepYZwbZU4Y7bB4Li4jaK8N
	  +A3kUmfuCMDFAcZkjPOt0Gh4oMSFa86lagrjWDWDk7bSg4v7sZDc55SLh61H4sFLtCRWzLRAjn
	  5mQ2+id+CNa2z+itG/JFjXHx/NTyXZ2NtxhGPtbNuRe413kk+V75LiEmuWr0YLMVrpIQA+jGt+
	  aKKXU+Z5jIzYIE+OzSlFkGq6zXs2KvIAoa1ZIotVnEzsXw==;
ARC-Authentication-Results: i=1; outgoing.instance-europe-west4-ssp3.prod.antispam.mailspamprotection.com; smtp.remote-ip=35.214.173.214;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed; d=outgoing.instance-europe-west4-ssp3.prod.antispam.mailspamprotection.com; s=arckey; t=1794433907;
	bh=wE06SBMMCgOMrEf8HNYFL5BLe2cwoz+SLDUxZoCq3sc=;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:
	  From:Date:DKIM-Signature:DKIM-Signature;
	b=PxdAUx3jsXsBWanhNxEZbxy1mMYJGNTMOyzCHOZi2KoTQpTaUM7uxWHDHtgio4U+yOkdAd3wIS
	  LgYJAojHKY0TkniNkjiCllDSS01HgeahAKZq+iVv2yieT/JWC2tjiDxTsHYlHE0e9PFdu/0EPB
	  ZHyUQJz1XXJDaMDgXTYO++dDU/zq+C5N4LHvCURGLlh3MagYpossZVpKvKNhIy2HltDEZGeL9W
	  /ikhBd76Aoxd0bHo972qz4l+fNL4YYphCp2bDL4zR5WjaI3RdMbMITcMbqA5SL/5OW02rD78ik
	  4IZxGgc+w9M5k5+u2SkVQj7DzT3jm5m8d33zvylGgjZrSQ==;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=antispam.mailspamprotection.com; s=default; h=CFBL-Feedback-ID:CFBL-Address
	:Content-Type:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	List-Unsubscribe:Content-Transfer-Encoding;
	bh=Vbx0Meut0QWhwLY5JReWROPpzdfMrBn/4+QeVAVvMPI=; b=N1lUvULpAKD9sh9rCkkqTGJBS5
	UVP3q5EnV7N1yDcgGZTKSmAb1LJIPrgQNTVUtozbQPNOoc8G6+tob0zRFlYqnVyQUK9VEG9bYH1gy
	6ZxZYSqLe7At5iY9sw0ztFdi4nizaU7lCuqfGtxV2niBLaQVRh2zlJGjh0sdJyPNeH7A=;
Received: from 214.173.214.35.bc.googleusercontent.com ([35.214.173.214] helo=esm19.siteground.biz)
	by instance-europe-west4-ssp3.prod.antispam.mailspamprotection.com with esmtpsa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xRGEF-00000000Ojb-0Me3
	for virtualization@lists.linux.dev;
	Wed, 11 Nov 2026 21:51:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=valla.it;
	s=default; h=Subject:Cc:To:From:Date:list-help:list-unsubscribe:
	list-subscribe:list-post:list-owner:list-archive;
	bh=Vbx0Meut0QWhwLY5JReWROPpzdfMrBn/4+QeVAVvMPI=; b=Aq6+g+6AcHy0QLhEQnG/yUlCbN
	CN0yTZsZx+Zj6ueBMau198JKdMwt1qNMDLPZa8wVpCgFLb6/3vxBsGUp82I0GXJKh6jC695S/sZC7
	2fnHDs2IBrpXpoUzinQ4bDzc9c2KQd0cn0zP9fc23wgnB0h/ULmL5PsxnPAZBeVCu8yw=;
Received: from [79.17.15.196] (port=62469 helo=bywater)
	by esm19.siteground.biz with essmtpa  (TLS1.3) tls TLS_AES_256_GCM_SHA384
	(Exim 4.100.1)
	(envelope-from <francesco@valla.it>)
	id 1xRGE6-00000000FIH-21LM;
	Wed, 11 Nov 2026 21:51:30 +0000
Date: Wed, 11 Nov 2026 22:51:28 +0100
From: Francesco Valla <francesco@valla.it>
To: Stjepan Poljak <stjepan.poljak@gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Andy Lutomirski <luto@kernel.org>, 
	Bjorn Andersson <andersson@kernel.org>, Mathieu Poirier <mathieu.poirier@linaro.org>, 
	virtualization@lists.linux.dev, linux-remoteproc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] virtio_ring: reject a split ring size that is not a
 power of two again
Message-ID: <avThD0u2WQx8drWl@bywater>
References: <20261111172947.3579982-1-stjepan.poljak@gmail.com>
 <20261111172947.3579982-2-stjepan.poljak@gmail.com>
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
In-Reply-To: <20261111172947.3579982-2-stjepan.poljak@gmail.com>
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - esm19.siteground.biz
X-AntiAbuse: Original Domain - lists.linux.dev
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - valla.it
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-SGantispam-id: 1dd1656ad9c6d0c1c7d5c7e284a28435
X-AntiAbuse: ID - 1dd1656ad9c6d0c1c7d5c7e284a28435
AntiSpam-DLS: false
AntiSpam-DLSP: 
AntiSpam-DLSRS: 
AntiSpam-TS: 1.0
CFBL-Address: feedback@antispam.mailspamprotection.com; report=arf
CFBL-Feedback-ID: 1xRGEF-00000000Ojb-0Me3-feedback@antispam.mailspamprotection.com
Authentication-Results: outgoing.instance-europe-west4-ssp3.prod.antispam.mailspamprotection.com;
	iprev=pass (214.173.214.35.bc.googleusercontent.com) smtp.remote-ip=35.214.173.214;
	auth=pass (LOGIN) smtp.auth=esm19.siteground.biz;
	dkim=pass header.d=valla.it header.s=default header.a=rsa-sha256;
	arc=none

Hi Stjepan,

On Wed, Nov 11, 2026 at 06:29:37PM +0100, Stjepan Poljak wrote:
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

Good catch - I think I encountered something like this during my
experiments with virtio-over-remoteproc and ascribed it to a different
cause.

> Put the check back for the split ring; the packed ring has no such
> restriction.
> 
> Fixes: 2a2d1382fe9d ("virtio: Add improved queue allocation API")
> Signed-off-by: Stjepan Poljak <stjepan.poljak@gmail.com>
> ---
> remoteproc still reports this as -ENOMEM, although the "Bad virtqueue
> length" warning names the cause. Returning an error pointer from
> vring_new_virtqueue() is left for later; the same change for
> vring_create_virtqueue() is here:
> https://lore.kernel.org/r/20261106055635.3019889-1-stjepan.poljak@gmail.com
> ---
>  drivers/virtio/virtio_ring.c | 6 ++++++
>  1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index f683a2d6a200..8da9bd0e70f4 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -3513,6 +3513,12 @@ struct virtqueue *vring_new_virtqueue(unsigned int index,
>  						    name, map);
>  	}
>  
> +	/* The split ring indexes its rings with num - 1 as a mask. */
> +	if (!is_power_of_2(num)) {
> +		dev_warn(&vdev->dev, "Bad virtqueue length %u\n", num);

This is definitely and error, and should be logged as such (I know, the
same message is printed as a warn in vring_alloc_queue_split(), but we
have no ABI to align to here).

Also, consider to adopt a message a bit more descriptive; maybe
something like this is sufficient:

   "Bad virtqueue length %u (not a power of two)\n"

> +		return NULL;
> +	}
> +
>  	vring_init(&vring_split.vring, num, pages, vring_align);
>  	return __vring_new_virtqueue_split(index, &vring_split, vdev, weak_barriers,
>  				     context, notify, callback, name,
> 
> base-commit: 1a577f9402c1780cc1e663f48d5dd54c02051b09
> -- 
> 2.53.0
> 
> 

Thank you!

Regards,
Francesco

