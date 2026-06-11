Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBEF3C553B
	for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 09:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781171322; cv=none; b=ZbvQC5spzJFU+6lyZqsAuFKEp6li6apvCTKvMUmSWPCrfb13xwpViycv91qCYnv5SKgUIy0c2EG5SgNBbf43xStC+MPacxuz6n9jiwcKxdwEnXwg/wFYOQv68mELInqqD1+JLGUfUFCpXpQxSjRZuuNXyKCzEF2IkUae56TieR4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781171322; c=relaxed/simple;
	bh=m/eXo++qysxw7lybczOtxAQVK9dhV3toSMRwZYW/4jM=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WQ/HxRcOJt69WAKI8qZIsXf7yz2fv5dPYmWAHgxki2JZ4NgxathyIU5BRMTjARPezzBgfRAhPsKCZZpaZJ2ZuecuY41lQ150TPUGyZTpa+ar6DzSO0L72sT8S7cO2zXv1BiHBKx9EVP5whewVtD9WD1QMCpKdUAuud68NJ6JLc8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CWq7tO9e; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CWq7tO9e"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-490af320e2aso86190215e9.2
        for <virtualization@lists.linux.dev>; Thu, 11 Jun 2026 02:48:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781171319; x=1781776119; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0PnrMx3F3Mo06rwgwVZw+wlkBVdU2ASIomiMmAPzODI=;
        b=CWq7tO9eYnZG56XtMfONFqmU1Jw7ynHSrrCl1R2u6ukuUwy2MghQBlMG2JCQqw7KSB
         NWXQQg++GjWsOi1vOe1bn6zCmw60mGcymF1mlaN1XrYfwCrxwlFesv2Y71MvT/DfHkZn
         CoIWjsQodwPRM3Fty5r+WrAvApEugS/M8YkhG9L9FnkaNy4sQG/ZpWwKWK21+ugtynsQ
         gomUouWm5ObdUJRjcnp65sgnpNYwPksv/vJHJ1jPc0wLDI94cqo+7MPIS175CZx47FHW
         MNycqpKtRC3z4SBDjX2SL2gYknUXfiZuh1IVQDwcfXJtEuT5JQadm5ky7o9ssFC2Vi7K
         NwPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781171319; x=1781776119;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=0PnrMx3F3Mo06rwgwVZw+wlkBVdU2ASIomiMmAPzODI=;
        b=XbvMwCXiTfT06Oxp9OhEI93yspGET3G0C3scLBhshLrS+52gLgEU1PKtzSVWsg59i5
         KEFRASGT5dZaS7C0T4cznDOAjJ5S1ATnzsDM0UbhNqe3s2RccJ6caJmvSki2/vw6aHOg
         h7dcfsmY5Ejv3AD5r19h6NVdUbEsESnDh3O+k9dIUx1MVKKWJrLWbh4uk+QL38UlO7Fj
         E4/fGyaCx0bpU6oleHP7ofZBer9awIRuHkqUUs7FdetLEhCXsWBva7Hyfbpgic87O9vm
         OEE+9xlRE55z2rbyfu5S/B2QTCsub4QzuoF5m+dAUenSceiahC7J2VWJgWsVwQk47YLW
         /xCA==
X-Forwarded-Encrypted: i=1; AFNElJ89lF+h2hXYFKpvpJxk/zhGpkiVSQQfLVkUVrn6hgCSuTaPRWqMF+MKXmlLfkiehn4AEbGYZjoMOrProSNwvQ==@lists.linux.dev
X-Gm-Message-State: AOJu0YxG0xts5H80HvDlop9jS94OSRJ/zaQ86QxYd6I3kpCeCXUdJoyX
	H/HHzd/9FfiVkbpbgPeF+Kd/01nJFlPt3nvrmJs2H3JLn6Ecpzi/x/RA
X-Gm-Gg: Acq92OFUF6tb7sGJPEY2oO/XVwY+ThJtaG3ejr//lpkGdMHnnR83x1EPZ6EPzCBVeQK
	jSchYHHPGvXMkLh54BZyW76Y/oGX8Fk/iiHb/xrajKHKSxBu54v8s7jJpnixe7l11haAurzMHwG
	uwqjzrbiv1Mj5OY/EXkp5eW4TPEm6fFoWrMMT9OwibwaNJJWhabvW8O7Ehwo9Mpt/knvHb8HnT9
	qFf9RPLdh2fzhUveC7Dr+MrdCK1SDGIhwclS2j7yjQ2pkTpmv4jqKZjHtvlNu8BxNxmnR6Aw8By
	nrZOREZKVuw0cyPW1CQBOv5wJo5EancHAPiyiIKze/TVwK9xt8yv01PpQhxJ/C2QzaVIfrAXmeR
	kAorEnnjuXzUwDY4KX9mNOH90wa4Vasdwl6ZcX5dqMIeqjNibOAZtpHUIJSJX0bauWzwsryAELT
	uUFg3qJJIvbWZLKdlmLh+Co56H6yjhQGqT0Lekkf3h33U8aBk3J8Oduam5GiKsfkQcCJ284Yk=
X-Received: by 2002:a05:600c:3b19:b0:490:e5c1:b8c6 with SMTP id 5b1f17b1804b1-490e5d0fffbmr23778935e9.8.1781171318970;
        Thu, 11 Jun 2026 02:48:38 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490e4228768sm38905995e9.0.2026.06.11.02.48.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 11 Jun 2026 02:48:38 -0700 (PDT)
Date: Thu, 11 Jun 2026 10:48:36 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Xiang Mei <xmei5@asu.edu>
Cc: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 eperezma@redhat.com, andrew+netdev@lunn.ch, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 netdev@vger.kernel.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org, minhquangbui99@gmail.com, bestswngs@gmail.com
Subject: Re: [PATCH net] virtio-net: fix len check in receive_big()
Message-ID: <20260611104836.469610b0@pumpkin>
In-Reply-To: <20260610221606.1091465-1-xmei5@asu.edu>
References: <20260610221606.1091465-1-xmei5@asu.edu>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Wed, 10 Jun 2026 15:16:06 -0700
Xiang Mei <xmei5@asu.edu> wrote:

> receive_big() bounds the device-announced length by
> (big_packets_num_skbfrags + 1) * PAGE_SIZE.  That is still too loose:
> add_recvbuf_big() sets sg[1] to start at offset
> sizeof(struct padded_vnet_hdr) into the first page, so the chain
> actually carries hdr_len + (PAGE_SIZE - sizeof(padded_vnet_hdr)) +
> big_packets_num_skbfrags * PAGE_SIZE bytes -- 20 bytes less than the
> check allows for the common hdr_len == 12 case.
> 
> A malicious virtio backend can announce a len in that gap.  page_to_skb()
> then walks one frag past the page chain, storing a NULL page->private
> into skb_shinfo()->frags[MAX_SKB_FRAGS], which is both an out-of-bounds
> write past the static frag array and a NULL frag handed up the rx path.
> 
> Bound len by the size add_recvbuf_big() actually advertised.
> 
> Fixes: 0c716703965f ("virtio-net: fix received length check in big packets")
> Reported-by: Weiming Shi <bestswngs@gmail.com>
> Signed-off-by: Xiang Mei <xmei5@asu.edu>
> ---
>  drivers/net/virtio_net.c | 8 +++++---
>  1 file changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index f4adcfee7a80..afe73eda1491 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1999,15 +1999,17 @@ static struct sk_buff *receive_big(struct net_device *dev,
>  				   struct virtnet_rq_stats *stats)
>  {
>  	struct page *page = buf;
> +	unsigned long max_len;
>  	struct sk_buff *skb;
>  
>  	/* Make sure that len does not exceed the size allocated in
>  	 * add_recvbuf_big.
>  	 */
> -	if (unlikely(len > (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE)) {
> +	max_len = vi->hdr_len + (PAGE_SIZE - sizeof(struct padded_vnet_hdr)) +
> +		  vi->big_packets_num_skbfrags * PAGE_SIZE;

That looks like a constant (for the vi).
Probably worth saving rather than recalculating all the time.

-- David

> +	if (unlikely(len > max_len)) {
>  		pr_debug("%s: rx error: len %u exceeds allocated size %lu\n",
> -			 dev->name, len,
> -			 (vi->big_packets_num_skbfrags + 1) * PAGE_SIZE);
> +			 dev->name, len, max_len);
>  		goto err;
>  	}
>  

