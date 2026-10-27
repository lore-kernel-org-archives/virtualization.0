Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.228.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793109202;
	b=0VUU95G2xSWccKUb+df0jOzk24WcvXJFD2Oz6J1ol29Hs6gtRZcWV71DT++6wuBLl9lN
	 NgurLgAlF0vTK3b7ypvT5smpLxWO46YgRgurr7HzAf4azYv5fobhcf+jzoCCgBLtaDUhz
	 zcxmGCof4sXfa+J3MWhEATh/veo4FyNwmplEisn2dl9EzNaHL6YbqLag9UgGAnWZCaQPk
	 OlTCEiUwAfX/rk+/tw4iUNrLO42Xz9UDLEyftYVUYO6vGZv3HBl1kj5rE49Ey2uEzHpk0
	 GrI7dydMzOYio7HjMbyBKRSVJ+7qsaTkrpHWvCVPc1+myh++abpUFbBIjJdSgIejGQg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793109202;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=seoLYPoPk5mt5piMxvDgKwZd5rMW4AsZNb6zEMwZMTU=;
	b=ZG0V4kvmytfPNUKFRjWw6/GAaiqeLYGVkhwPGYvzqop4j+/zK0cw04bTii97Kt0kJXNE
	 pOYBPFbJr+1zdIIlqCBi1pmSc7hvfiJ612W+qnABDNE1dGjVpQg/HUgDmV1b7+VmTC9Sf
	 OmfDVHMgkUDDKuJAOnpes3lu+1lRmn3rQK9bRtPL7WPZ1FvDGhjw3X/JCmkPttfDbKlM8
	 MWl0wtnIP/nB3Jqbwa7tyulH3Lifg4EWqvDrml68yHxDqZJy5LI1UvIxGXQWK7evlaNdU
	 c7840v1eVsJQqZqwJLSll+iSDaOT49hH5PPQp3lTN35JqX93ZPcUqFtXIMce3ZCPXvQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eTpfZxJU;
	arc=none smtp.remote-ip=74.125.228.5
Received: from mail-pz2-f5.google.com (mail-pz2-f5.google.com [74.125.228.5])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EF72606A33D
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 13:53:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EF72606A33D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=eTpfZxJU
Received: by mail-pz2-f5.google.com with SMTP id 41be03b00d2f7-cc7c286026aso1658856a12.0
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 06:53:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793109200; x=1793714000; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=seoLYPoPk5mt5piMxvDgKwZd5rMW4AsZNb6zEMwZMTU=;
        b=eTpfZxJU2Q7g4cfRRiRW3e9K6UOpERAitBAHiSHSYtrtv9MFEH/Ac3Dps4lyhSwkrU
         4kgjO1hiRvvNMF+RddafZFqX5gHBcNtsi0LHSY9DHdYySraUr0eFBxAP6YV1cJBurI8A
         pOYTVn7A/IO5YpDYxCsg/B3KgO/GTrfrNUM5tgDa2RD3703mPNrbwLmixQFpnEEnMRJ+
         B9C2fpPnLEOGFtONH6Nx02V/YKmBp9l+dvJT6s1LqvvZYOqOji8bVp7WuXQ3bnUpwG4u
         trOz5Lb83hKinImVaJpEsw9FQy+E2l0u9FqpRTJCGtRc1KNtt67xGD+Rcp6GejmB5F3O
         uj9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793109200; x=1793714000;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=seoLYPoPk5mt5piMxvDgKwZd5rMW4AsZNb6zEMwZMTU=;
        b=zJsEyFhLc6omVZveZCCGpHdv55BRs2hg0yU2tXvbLpKY40mhCUaWL8CBV4fElB/Fza
         yPEqzB5kHxS7yQSKHmnd3WVch3zNMbx3kURh9POHQ1vv4hvwy2CcGfje3wLK93beb7k1
         zytI4bxjHAyNFppQNV6MXoaou9KpBlkPXDZaFARNwt4BDzrZZl4q0ZgYhZl5ldo4LazF
         aLEWcK0/UuC5wlngySYdnyA3jTZLAh2cn+8LGwnlO1Mcu/WD+fImMGFaHIrZ4yr81zCQ
         PTTR9rXQz2bYgJJuwmmb1gO/gU+OfG2i4hL8Gz/etDObRDEeJ3pXcH1Q21jH82S+mPF3
         a97g==
X-Forwarded-Encrypted: i=1; AKwUvBwVjGkc0RtlgqHu2dgNoImPI7wECXgi3cmSw5whnBdQxcWN3/VRGO/xMw9VmavBw9bbrucxXeHimCfrL9iaXw==@lists.linux.dev
X-Gm-Message-State: AFq9FYIEwh5aykUu1nrUuU9QQi7EZfTTaO7cTJ0EPHepR/tN0fSvj3wh
	fUKN6Q0Wf1X/XDcIYSRPKdLiXUGyySfltDzLn3v0ov2o/dETufpXG/6n
X-Gm-Gg: AYBFou044gmF57DxUQyonO7pdTaNu5ejufA80VU6u8mZuJ3OTTGH6leCXXEWl4vsiC4
	6yZ2mU0lc+h5jbjDrd8tno/sVErTofp12y4sysNUzh8JD94e74AxEmIRVHjFfEn5CpJU3AbN3p2
	ArIsXPRbx2DtPYgWRLqHRJaFZxu55Zeip5/L/VwaGARvGPx0THKDn2eRmdgKppPUHn/kG5w5jD+
	bl0EbQK0mcF0oa8wLqlOiV0KVsoPsZv/G14T1m5sbM8XvL6aqB7ocBZurUwCdjteQVj4lwP4UT5
	BK+2Ws3Mkk6MGMBcXCboPDKnn7n4eKz1gpbwFqJsmEd3cOdbQx3Totwvptyz3B3S1c7B6p/cpQK
	BMPPRsVWyK/ccScwJ4u1NfOt1pqU67xjG+xl9pibTeq5k7hMRCFE9NF2RI6Q4tS40fTLqJuIxwr
	Wkjp1h4F7VSw4HEEuGyWsClVxAV0EK+kzMSEpBHI9UUa3KYeWQcYTXB141SUmA0nG+0cDHQ4S4u
	GCPPF2oQo2uIr8Qs64+RqXqB7fzpxXhb1Q13ELlLXb7vsWtge/k5ZLR3LEp8QzNuk2h9bRYZZM/
	lqfvel952wPnaPdDDiaE1ARP8SLRy40b10eJj5YDFBNGA25OBmSf2ZJytpwrPyzOzYX4s/0NzDU
	yJH/mfhElsNNJEWovvES0gqfK5gQmFP5Pn1LTv+UqJGnAIkh0nR8GZ0xsA7//g7ABFIYHo9LsJS
	Ib
X-Received: by 2002:a05:6a00:3a17:b0:89e:779b:cff with SMTP id d2e1a72fcca58-8a364b4ce5fmr8249181b3a.6.1793109200511;
        Tue, 27 Oct 2026 06:53:20 -0700 (PDT)
Received: from wang0.localdomain ([133.11.33.33])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a6a5f652aasm50188b3a.17.2026.10.27.06.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 06:53:19 -0700 (PDT)
Date: Tue, 27 Oct 2026 22:53:16 +0900
From: Lianjie Wang <karin0.zst@gmail.com>
To: Paolo Abeni <pabeni@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, netdev@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH net] virtio_net: reject stats replies for queues outside
 the request
Message-ID: <auCkXHi6IulXgm7v@wang0.localdomain>
References: <20261022182710.2055771-1-karin0.zst@gmail.com>
 <096bd22b-c569-4998-a943-0381c3fa9998@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <096bd22b-c569-4998-a943-0381c3fa9998@redhat.com>

On Tue, Oct 27, 2026 at 01:06:41PM +0100, Paolo Abeni wrote:
> On 10/22/26 20:26, Lianjie Wang wrote:
> > [...]
> > @@ -4976,6 +4977,10 @@ static int __virtnet_get_hw_stats(struct virtnet_info *vi,
> >   	for (p = reply; p - reply < res_size; p += le16_to_cpu(hdr->size)) {
> >   		hdr = p;
> >   		qid = le16_to_cpu(hdr->vq_index);
> > +		if ((qid < first_vq || qid > last_vq) &&
> > +		    !(enable_cvq && qid == vi->max_queue_pairs * 2))
> > +			return -EINVAL;
>
> I think the above check could be simplified to:
> 		if (qid < first_vq || qid > last_vq)
> 			return -EINVAL;
>
> squashing the following in virtnet_get_hw_stats():
>
> -       if (enable_cvq)
> +       if (enable_cvq) {
>                 virtnet_make_stat_req(vi, ctx, req, vi->max_queue_pairs * 2, &j);
> +               last_vq++;
> +       }
>
> (likely with some meaningful comment).

Thanks for the review!

I looked into this, and I think last_vq + 1 matches the control vq
only when all queue pairs are in use. The control vq index is
max_queue_pairs * 2, while last_vq is curr_queue_pairs * 2 - 1 for
ethtool -S. After ethtool -L lowers the queue count, or when probe caps
curr_queue_pairs at num_online_cpus(), last_vq + 1 is the receive vq at
index curr_queue_pairs * 2, which is not in the request. The simplified
check would accept a record for it. Since the ethtool -S array has
slots for only curr_queue_pairs queue pairs, with the transmit slots at
its end, virtnet_fill_stats() would write the counters of that record
into the transmit slots, and can write past the end of the array.

Would you like me to keep the current check or change it in some
other way?

As for the comment, I would add the following above the check in v2:

		/* The control vq comes after all max_queue_pairs pairs, so it
		 * exceeds last_vq + 1 when fewer pairs are in use.
		 */

Thanks,
Lianjie Wang
