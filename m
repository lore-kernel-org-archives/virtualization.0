Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DCEC79460
	for <virtualization@lists.linux.dev>; Thu, 21 Dec 2023 23:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--shakeelb.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="nWnkbGls"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dbccc6dfa6cso2935448276.1
        for <virtualization@lists.linux.dev>; Thu, 21 Dec 2023 15:27:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703201238; x=1703806038; darn=lists.linux.dev;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=TQBK3S+cxkss8EKQd6OTegL/cKtMcOEpQ7fU5gL2SH4=;
        b=nWnkbGlsbYLJnxjE8YjSGhv0piknfrv0Xdze6YvGhGz4aTRtq5pdj2OWRDbvbsD54M
         yguZ0RLbEAaU4a0ppFykyXK82Y9/w0VhAGHQTS2ZFtaxuhIz6a/QBMD+e47TlgpJZTi0
         g+UHpB/xDwBYlIiExvGORjG7gZaqAOlY2dgCm6wg9wXuHONpHRt98w3KbXgWlsxMPK+Q
         AFFOSy9K268Hxl1PqsNn3uYcrHdJyASqBVJ+lhLJL8Oi3KfTEta9LlE5VMMXM4SrOeEt
         TSh4xr2+pShQKWcDOtdN1ItS3bcqA439J64o5usMR+B2SQuG2QkTYypt+/pIP4Vs/2s9
         Z2Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703201238; x=1703806038;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TQBK3S+cxkss8EKQd6OTegL/cKtMcOEpQ7fU5gL2SH4=;
        b=XdqLPaEsynXqxglczgRAC91WcvTX++rOZITaqwT/TVYSLwLN3p2IyFHSAU04LDROFl
         iro7Kx4RgCi+9IpPDg+leehO3/4je62ZLeMJXPPYqy96x+OYLZM4//ncTX5k6y/2o/Zn
         JKLlpOKYkUA381rDR8wteDZHp3gbfp3fy6TOZtpjAImCWBvzbXmLNmKuXiM4R+79B4Eg
         6xv9ZDnAyOf5SFSZrtxxzj7lBeV/Zzmxow3j2DLIM6AjQZPZSXI/MrsPsHQ/xIvJQm5j
         ozKeaSfMFvvYUT99zNg/cO/odfTqw+jpFENi/8ytPknPzffZ9XB8cvwp+6ryiDxPnXQG
         n2TA==
X-Gm-Message-State: AOJu0Yx/zhBzyJQ7LnRY2W4YUwg9ahqOfo0uDUg96esS8tTmpal7A1yz
	tENaBSnEvJcW0EYcHlAWl7ZhhyY6XnmD/8ClHtgM
X-Google-Smtp-Source: AGHT+IHz6Vx9BVCm69eXFOwEY+5r5/zDa9Kri6vSrgY7qRPuVVIYL/un696UdtbG9xPdf62Sv/ozrRMtnVdK/Q==
X-Received: from shakeelb.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:262e])
 (user=shakeelb job=sendgmr) by 2002:a25:844e:0:b0:dbd:2c5a:6c53 with SMTP id
 r14-20020a25844e000000b00dbd2c5a6c53mr188580ybm.6.1703201238254; Thu, 21 Dec
 2023 15:27:18 -0800 (PST)
Date: Thu, 21 Dec 2023 23:27:16 +0000
In-Reply-To: <20231220214505.2303297-4-almasrymina@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
References: <20231220214505.2303297-1-almasrymina@google.com> <20231220214505.2303297-4-almasrymina@google.com>
Message-ID: <20231221232716.4fspnvngfuqhaycu@google.com>
Subject: Re: [PATCH net-next v3 3/3] net: add netmem_ref to skb_frag_t
From: Shakeel Butt <shakeelb@google.com>
To: Mina Almasry <almasrymina@google.com>
Cc: linux-kernel@vger.kernel.org, netdev@vger.kernel.org, kvm@vger.kernel.org, 
	virtualization@lists.linux.dev, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella <sgarzare@redhat.com>, 
	David Howells <dhowells@redhat.com>, Jason Gunthorpe <jgg@nvidia.com>, 
	"Christian =?utf-8?B?S8O2bmln?=" <christian.koenig@amd.com>, Yunsheng Lin <linyunsheng@huawei.com>, 
	Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Content-Type: text/plain; charset="us-ascii"

On Wed, Dec 20, 2023 at 01:45:02PM -0800, Mina Almasry wrote:
> diff --git a/net/kcm/kcmsock.c b/net/kcm/kcmsock.c
> index 65d1f6755f98..3180a54b2c68 100644
> --- a/net/kcm/kcmsock.c
> +++ b/net/kcm/kcmsock.c
> @@ -636,9 +636,15 @@ static int kcm_write_msgs(struct kcm_sock *kcm)
>  		for (i = 0; i < skb_shinfo(skb)->nr_frags; i++)
>  			msize += skb_shinfo(skb)->frags[i].bv_len;

Don't you need the above to cast to bio_vec to get bv_len? skb_frag_t
does not have bv_len anymore.

>  
> +		/* The cast to struct bio_vec* here assumes the frags are
> +		 * struct page based. WARN if there is no page in this skb.
> +		 */
> +		DEBUG_NET_WARN_ON_ONCE(
> +			!skb_frag_page(&skb_shinfo(skb)->frags[0]));
> +
>  		iov_iter_bvec(&msg.msg_iter, ITER_SOURCE,
> -			      skb_shinfo(skb)->frags, skb_shinfo(skb)->nr_frags,
> -			      msize);
> +			      (const struct bio_vec *)skb_shinfo(skb)->frags,
> +			      skb_shinfo(skb)->nr_frags, msize);
>  		iov_iter_advance(&msg.msg_iter, txm->frag_offset);
>  
>  		do {
> -- 
> 2.43.0.472.g3155946c3a-goog
> 
