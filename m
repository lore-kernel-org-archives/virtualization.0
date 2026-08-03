Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FDA358378
	for <virtualization@lists.linux.dev>; Mon,  3 Aug 2026 16:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785775163; cv=none; b=l1N2T5Juyied/c+NJooeC/h0lmDuMGpA+vnD2zw58I4tRlqW2hxRfRbanNgEwvh9VkT6Vyy+3wU3liOfZ8PklO5GRVtR9k4FL86rPFPuPOBhllu1mF5mOc5TPgYzxxmZTVjq8aGusHDy1WmTK04oO7A94BOmkkVML4di2NP9tMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785775163; c=relaxed/simple;
	bh=mqUEgn1Epw+wydGosGOX18016E8j2UEyqJXR33YIW5g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=GfR2k9XkRcc//IhTFa7YXWJrGKjAAJRngrHhufYD8SFi1pWixmm0be33G+Nvfsgzy119sBkUSYuoJF1yZO5jOveOxxFaRQ1Y0wPnwZ0oLMgzCprqacv8ETaDfEMBCkPK5JkthfX/oBx3UTdE5FK7b9vDGnNKXZwJlxvhYYAIFlo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=TjXg0KAD; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TjXg0KAD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1785775159;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=x6ljzSC+4qTqONEyzGjxVIdBzwjub/8R38l2gLkronQ=;
	b=TjXg0KAD+ZnDK9XOAtQ6eC5ZsDq45wbAR+lCNOszeLFAPAQ0fRBxZ7SqzjgoMaPKEPTDX7
	N8OWBXMnqD+D+VBx6z4gEKsZL8dyfHyDB8ffxa9ov2A9BA1329F/3F8sqtey48VnOQDXXO
	3EPDIx6OX2HffEtbpBxGY2ZUXYgTtQU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-331-ti5y1qA-P5KJh75J4tL8uQ-1; Mon, 03 Aug 2026 12:39:18 -0400
X-MC-Unique: ti5y1qA-P5KJh75J4tL8uQ-1
X-Mimecast-MFC-AGG-ID: ti5y1qA-P5KJh75J4tL8uQ_1785775157
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-47faa02f707so47422f8f.1
        for <virtualization@lists.linux.dev>; Mon, 03 Aug 2026 09:39:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785775157; x=1786379957;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=x6ljzSC+4qTqONEyzGjxVIdBzwjub/8R38l2gLkronQ=;
        b=eoQbclfmLMqnlFqUEl4kLIhMSmV2pROxb1AuuDkfrL1ikdG1NxXn8CLUx4XG6Avoky
         h0kZOtekZn7A1HmxwnpTXMkth0wFSAIpnvIH4J2N2sQ8Ns4Va78PFzgfzrgQ3wp6gOdE
         Xdzs0Ri5xTZ/NQmfwx1aRuleDRKdtqChQim2NR0mJmHKXLkmY/U7pPivCvIwXrI44m+p
         ARDD5R7/bZ6+tDgA4YC2nCFBNwZ2VgsB2S9H1LfDfv94OvhKlL3V3iNvfRRCP0US3WR6
         hptgpBgwSI8+cq7hauEA2+RBl7/DIgmW734NMRN27DAhgDCSRfGe0W+g//yzoRYSyDRR
         BfxA==
X-Forwarded-Encrypted: i=1; AHgh+RqmdBnkBDgFOtmHxjxnLlqJ1mb6pE+Oldnwur91GtTwLtY7iebR9BZdpztlf4APvfi1PQf+ccHfGZS7jnpjYQ==@lists.linux.dev
X-Gm-Message-State: AOJu0Yyan+LHjVnzMssdxMG6XlTIaGRFTl9X+0+xdKbeHG9ABn9CH8AM
	kF3s7TIBQwJK1M79EBJNQTKqUNBIsIpBQKv2BA0rFw7dIJ1UJWmDoG6KOpX87g6MqjfwnCLWg/B
	QjWB6xDBiQNLkvUyG5LJrzxJU3OUKtxViEw+Agz1oin81qgW7caAiCYifOXYbmZ6PjD3T
X-Gm-Gg: AR+sD103Ih2XEK4NrHNsnKJHv9zGXORGZDGhmlPSL5MgMyfLQHCgEr+S4eQXqM7/+Ro
	RKyObstAzYYYIFkPhhVsRCsGLWaqSoYt0/npjKDrlwxVZhBRuNnYZRXD+UolRIId6f3lq72aFZH
	I3ex+8siDEYct3S2jeyICOZ9QFST/5olV5rWcK+GRp/+e9OaeZmPOEr5gDd9YKnyDathyBLO77N
	vNhCVWUI71i5fMaQclrfMU4FWtWOp3fMNVI9Bnnaz4JAfsf1SKXe+XyPbzhwi/folMeGzhOUBOV
	yPaYLR5Ok+L5nBtPkaq8nVj0onjXpitWE7R+3v2Z3iL2FRMmIXgQb388vWyunRgu6fwRyD3pZQL
	u5XKBpmdXj2tGaXM04eqFrA==
X-Received: by 2002:a5d:5f94:0:b0:47f:7fe0:a287 with SMTP id ffacd0b85a97d-47fe81983f1mr844386f8f.2.1785775157492;
        Mon, 03 Aug 2026 09:39:17 -0700 (PDT)
X-Received: by 2002:a5d:5f94:0:b0:47f:7fe0:a287 with SMTP id ffacd0b85a97d-47fe81983f1mr844296f8f.2.1785775157008;
        Mon, 03 Aug 2026 09:39:17 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-28-14.inter.net.il. [80.230.28.14])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47fd4562667sm36096625f8f.24.2026.08.03.09.39.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2026 09:39:16 -0700 (PDT)
Date: Mon, 3 Aug 2026 12:39:13 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jun Yang <juny24602@gmail.com>
Cc: netdev@vger.kernel.org, Jun Yang <junvyyang@tencent.com>,
	stable@kernel.org, TencentOS Corvus AI <corvus@tencent.com>,
	Jason Wang <jasowangio@gmail.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] vhost: reset the vring metadata cache on vring
 reconfiguration
Message-ID: <20260803123853-mutt-send-email-mst@kernel.org>
References: <20260803014823.68623-1-juny24602@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260803014823.68623-1-juny24602@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3wF5lMrTw1agxraNHm7VQW5r_d7SbYCXVwuQ3fyi784_1785775157
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Aug 03, 2026 at 09:45:14AM +0800, Jun Yang wrote:
> From: Jun Yang <junvyyang@tencent.com>
> 
> vq->meta_iotlb[] caches the vhost_iotlb_map that backs each vring
> metadata region, and iotlb_access_ok() returns early on a cache hit,
> taking the hit as proof that the region has already been validated:
> 
> 	if (vhost_vq_meta_fetch(vq, addr, len, type))
> 		return true;
> 
> The cache is reset on VHOST_IOTLB_UPDATE and VHOST_IOTLB_INVALIDATE, on
> device IOTLB (re)initialisation and on vq reset, but not when
> VHOST_SET_VRING_ADDR replaces vq->desc, vq->avail and vq->used, nor when
> VHOST_SET_VRING_NUM changes the region sizes.
> 
> With a device IOTLB attached both ioctls are accepted while the vq is
> live, and neither validates the addresses at ioctl time: vq_access_ok()
> and vq_log_used_access_ok() return true early because the addresses are
> GIOVAs, deferring validation to prefetch time.  Once the cache has been
> populated that deferred validation no longer runs -- vq_meta_prefetch()
> hits the stale entry and returns true -- and vhost_vq_meta_fetch() keeps
> translating through the old mapping as
> 
> 	map->addr + addr - map->start
> 
> for an address the mapping no longer covers.  vhost_copy_to_user() and
> vhost_copy_from_user() consume the result with __copy_to_user() and
> __copy_from_user(), which do not check it either, so a subsequent used
> ring update or descriptor fetch accesses memory outside the region the
> IOTLB actually maps.
> 
> Reset the metadata cache whenever the vring is reconfigured, so the new
> addresses are pushed back through iotlb_access_ok()'s slow path.
> 
> Fixes: f88949138058 ("vhost: introduce O(1) vq metadata cache")
> Cc: stable@kernel.org
> Reported-by: TencentOS Corvus AI <corvus@tencent.com>
> Signed-off-by: Jun Yang <junvyyang@tencent.com>

patch itself ok:

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
>  drivers/vhost/vhost.c | 8 ++++++++
>  1 file changed, 8 insertions(+)
> 
> diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
> index 4c525b3e16ea..77c96993100b 100644
> --- a/drivers/vhost/vhost.c
> +++ b/drivers/vhost/vhost.c
> @@ -2126,6 +2126,14 @@ static long vhost_vring_set_num_addr(struct vhost_dev *d,
>  		BUG();
>  	}
>  
> +	/*
> +	 * The metadata cache holds the IOTLB mapping that backed the previous
> +	 * desc/avail/used addresses and vring size, both of which are being
> +	 * replaced here.  iotlb_access_ok() takes a cache hit as proof that the
> +	 * region was validated, so the stale entries have to go.
> +	 */
> +	__vhost_vq_meta_reset(vq);
> +
>  	mutex_unlock(&vq->mutex);
>  
>  	return r;
> -- 
> 2.55.0

