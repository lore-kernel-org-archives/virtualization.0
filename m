Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941C73FFFB5
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jun 2026 15:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780672141; cv=none; b=haa+/eTuNmnEbLnaKemf8KlGwwx9L7U8dluuOr+y8PoE+BJugX6enF4W9iZCN8gD/LtFjD+eaTTAC86TwDAgYZERiRdVJpWDSngLJY0hshzGFKK4JNeJzyzMtXaNpDRlUt65/jDFeXJ1m83YDLgohOy/IHKiNe8vv7OonpMnmpk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780672141; c=relaxed/simple;
	bh=HtxAlA0bpzrKu0Tr9l4oqmpPC0VovkQ79lbq7PZ+w0s=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=u0kp4FZ0jEYkuARXu38dwegnZiyZajHsffECm5mbJ1RDEdPllfC0w0LEvmyR+lLGNoKwi8jAbiHQ01lnK+f5SxSy05qDeAa111KHMPjN5Bb5ocUbA4b7HenB4eDpuUtOFCwMjDs7RZVilTyngyUDw0/ehlRPHswLMz3YtuPJW08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MloMpC4Q; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MloMpC4Q"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A8E3819D2
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jun 2026 15:09:00 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -1.099
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id IE8m_tBT8WNQ for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Jun 2026 15:08:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=2a00:1450:4864:20::42b; helo=mail-wr1-x42b.google.com; envelope-from=david.laight.linux@gmail.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 47B5B819D1
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=gmail.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 47B5B819D1
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MloMpC4Q
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 47B5B819D1
	for <virtualization@lists.linux-foundation.org>; Fri,  5 Jun 2026 15:08:59 +0000 (UTC)
Received: by mail-wr1-x42b.google.com with SMTP id ffacd0b85a97d-4600cbb06deso1146420f8f.1
        for <virtualization@lists.linux-foundation.org>; Fri, 05 Jun 2026 08:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780672137; x=1781276937; darn=lists.linux-foundation.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgCzrE/kcx5xV+VBfBM1xmyxfRLG6AWjmyf9O3n0QS0=;
        b=MloMpC4QFfkbueu7sqeBi5hQAO7H5C1MXECFaRF5Twjmcoa2M4rOEa1WwUxrtQ5lB5
         VYkDHDQxk5RU5Ywh//wyGlGVoBZ/Yt4VwIAUg2TfBDJxpn68a6JI41RxaIu60wvUi1WK
         Z9UfqUIWcAQelK8TpsJfH51o/CtAOB6lcxr+OrvYt3hFZQWzHwPPDJ8mjvVOxUapqY0U
         lHMTzmHeBdJrbLcOuTGP/kn67cN+m3U1ygdGpni3H3beIXsnzu5Z5vQSb1RIIlvCkX9E
         zkspeAzbLHUxmhOKyDPWafUieBv4tU4SlUkC/nuo02NafudiIDKTQJlqPvpzRdHW9gpO
         7m9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780672137; x=1781276937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HgCzrE/kcx5xV+VBfBM1xmyxfRLG6AWjmyf9O3n0QS0=;
        b=VZiGqmUn5TpC6RgZlakFn178xidj5bqYjfRrpSFOwC/U2T4tUQD1ZOwAQhircceRFP
         93cNBluLHaX+XnbpZh3eYsXZLZ7TsVcFw8wXwl4TgMItaFSIY8v6Ks38bAkSq3aAa+16
         ixy3LxcjN5tszdzhvWjKZCcx1VTtqDMUpZjDTuxrBxOgaq6zsS6K4GHR/wEVgTRMXqDo
         7NYmvDJf2kxEI/eTGrjXrfYrFk6/f6TpwIuBIPZaCvEBTeCedYLIc2FvzPhIwidx0nDR
         NjvAMDFS2aB2sCBpjX2ETyOrnEw/4yZh0sleKRvrep8VWVziRWAHcb8hlhG0K3bT1tlN
         1GiA==
X-Forwarded-Encrypted: i=1; AFNElJ/LOs6xBpZFW6DDYOEWTZM8gX/aLRwxIKWuvbmOwI/abav5jqIMXRzRrhxScZCO+0CfhKgF5R6XPZIsHDGPHA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzqgHg1jtRYg0pspeKYPVayqAWT/WZ2qG/hzIwL5vL9tj56IFYy
	/Bikqo3cd9/2n0KXc/BfE+X+u+TTX3xnTFavQaeloGdle4wcoB5m+92p
X-Gm-Gg: Acq92OEjqwKr6rGbCct5QYpt4R9i1LUFV277bEeITlkX9AejelIzdVuVY9kP6xaAsNH
	vHjUCLexaasaKD+2T+VVOircgHUXzviuystd1RUEUtbpQzwPHC9UKBdD65Z7958sEbvLlaHYAXI
	8RFVL6wbln/PwuqT/9Du/3VIrqE6p5sgwrbEZ+7cmyUJUVD5Hs8R1v7sOzcFFK3zw8x/qZPREii
	6dznFrimbCxAZ1FNCbcQd6Fzuer0zMG7L8OkzmP3nzZNP7T7o+X0m5mioURuynNsrE074l1nxk7
	/RDxMclhPtJH1OBUvdkZrszBiIDBWS3UbyQ+NKsuI7LS6xPlETzjb54q9MsaSHySYqYuLZ9ZHlA
	sDSAB6bxh0ZASZaGw/NASc26f9yCuIFz8PLkVCQILJHknrScchFv/Oi5cBZ940NOh44pTGKaqZ1
	/JF8pR/DoTQMD90uX43+3Say7TPk1pB7TMpo6UfO2VPt5nNnEcvc8aexC/agUVK13asUCc99KOj
	unME2u9yA==
X-Received: by 2002:a5d:64e5:0:b0:45a:5392:3a19 with SMTP id ffacd0b85a97d-46032da19dfmr5307301f8f.16.1780672137010;
        Fri, 05 Jun 2026 08:08:57 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351ac0sm44178439f8f.27.2026.06.05.08.08.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 Jun 2026 08:08:56 -0700 (PDT)
Date: Fri, 5 Jun 2026 16:08:51 +0100
From: David Laight <david.laight.linux@gmail.com>
To: Arseniy Krasnov <avkrasnov@rulkc.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, Stefano Garzarella
 <sgarzare@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric
 Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo
 Abeni <pabeni@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, Jason
 Wang <jasowang@redhat.com>, Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?UTF-8?B?UMOpcmV6?=
 <eperezma@redhat.com>, Simon Horman <horms@kernel.org>,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, oxffffaa@gmail.com,
 rulkc@linuxtesting.org
Subject: Re: [PATCH v1] vsock/virtio: rework MSG_ZEROCOPY flag handling
Message-ID: <20260605160851.3ddbd2ed@pumpkin>
In-Reply-To: <20260605115314.552321-1-avkrasnov@rulkc.org>
References: <20260605115314.552321-1-avkrasnov@rulkc.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Fri,  5 Jun 2026 14:53:14 +0300
Arseniy Krasnov <avkrasnov@rulkc.org> wrote:

> Logically it was based on TCP implementation, so to make further
> support easier, rewrite it in the TCP way.
> 
> Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>
> ---
>  net/vmw_vsock/virtio_transport_common.c | 64 ++++++++++++-------------
>  1 file changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index 2fd9eaaf5ca6..00caeeaa5590 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -73,10 +73,13 @@ static bool virtio_transport_can_zcopy(const struct virtio_transport *t_ops,
>  static int virtio_transport_fill_skb(struct sk_buff *skb,
>  				     struct virtio_vsock_pkt_info *info,
>  				     size_t len,
> -				     bool zcopy)
> +				     bool zcopy, struct ubuf_info *uarg)
>  {
>  	struct msghdr *msg = info->msg;
>  
> +	/* We have completion - attach it to 'skb'. */
> +	skb_zcopy_set(skb, uarg, NULL);
> +
>  	if (zcopy)
>  		return __zerocopy_sg_from_iter(msg, NULL, skb,
>  					       &msg->msg_iter, len, NULL);
> @@ -208,7 +211,8 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
>  						  u32 src_cid,
>  						  u32 src_port,
>  						  u32 dst_cid,
> -						  u32 dst_port)
> +						  u32 dst_port,
> +						  struct ubuf_info *uarg)
>  {
>  	struct vsock_sock *vsk;
>  	struct sk_buff *skb;
> @@ -245,7 +249,7 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
>  	if (info->msg && payload_len > 0) {
>  		int err;
>  
> -		err = virtio_transport_fill_skb(skb, info, payload_len, zcopy);
> +		err = virtio_transport_fill_skb(skb, info, payload_len, zcopy, uarg);
>  		if (err)
>  			goto out;
>  
> @@ -321,38 +325,36 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
>  		return pkt_len;
>  
> -	if (info->msg) {
> -		/* If zerocopy is not enabled by 'setsockopt()', we behave as
> -		 * there is no MSG_ZEROCOPY flag set.
> +	if (info->msg && (info->msg->msg_flags & MSG_ZEROCOPY)) {
> +		/* If 'info->msg' is not NULL, this is only VIRTIO_VSOCK_OP_RW.
> +		 * 'MSG_ZEROCOPY' flag handling here is based on the same flag
> +		 * handling from 'tcp_sendmsg_locked()'.
>  		 */
> -		if (!sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY))
> -			info->msg->msg_flags &= ~MSG_ZEROCOPY;
> +		if (info->msg->msg_ubuf) {
> +			uarg = info->msg->msg_ubuf;
> +			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
> +		} else if (sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY)) {
> +			uarg = msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
> +						    NULL, false);
> +			if (!uarg) {
> +				virtio_transport_put_credit(vvs, pkt_len);
> +				return -ENOMEM;
> +			}
>  
> -		if (info->msg->msg_flags & MSG_ZEROCOPY)
>  			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
>  
> +			if (!can_zcopy)
> +				uarg_to_msgzc(uarg)->zerocopy = 0;
> +
> +			have_uref = true;
> +		}
> +
> +		/* 'can_zcopy' means that this transmission will be
> +		 * in zerocopy way (e.g. using 'frags' array).
> +		 */

I've not looked at the tcp code, but the above doesn't look right.
I don't see why msg->msg_ubuf might be non-NULL without SOCK_ZEROCOPY set.
That would give the outer code a callback when the last skb is freed but
still copy the data.

I also don't see the point of calling msg_zerocopy_realloc() to get a
callback when the last skb is freed and then setting
	uarg_to_msgzc(uarg)->zerocopy = 0;
so that the callback doesn't actually do anything.
It isn't as though you 'find out' later on that you can't actually do
zerocopy.

>  		if (can_zcopy)
>  			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
>  					    (MAX_SKB_FRAGS * PAGE_SIZE));
> -
> -		if (info->msg->msg_flags & MSG_ZEROCOPY &&
> -		    info->op == VIRTIO_VSOCK_OP_RW) {
> -			uarg = info->msg->msg_ubuf;
> -
> -			if (!uarg) {
> -				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
> -							    pkt_len, NULL, false);
> -				if (!uarg) {
> -					virtio_transport_put_credit(vvs, pkt_len);
> -					return -ENOMEM;
> -				}
> -
> -				if (!can_zcopy)
> -					uarg_to_msgzc(uarg)->zerocopy = 0;
> -
> -				have_uref = true;
> -			}
> -		}
>  	}
>  
>  	rest_len = pkt_len;
> @@ -365,14 +367,12 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  
>  		skb = virtio_transport_alloc_skb(info, skb_len, can_zcopy,
>  						 src_cid, src_port,
> -						 dst_cid, dst_port);
> +						 dst_cid, dst_port, uarg);
>  		if (!skb) {
>  			ret = -ENOMEM;
>  			break;
>  		}
>  
> -		skb_zcopy_set(skb, uarg, NULL);

Aren't you passing uarg through two function calls instead of doing it here.
Doesn't even make it clearer what is going on.

-- David

> -
>  		virtio_transport_inc_tx_pkt(vvs, skb);
>  
>  		ret = t_ops->send_pkt(skb, info->net);
> @@ -1178,7 +1178,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
>  					   le64_to_cpu(hdr->dst_cid),
>  					   le32_to_cpu(hdr->dst_port),
>  					   le64_to_cpu(hdr->src_cid),
> -					   le32_to_cpu(hdr->src_port));
> +					   le32_to_cpu(hdr->src_port), NULL);
>  	if (!reply)
>  		return -ENOMEM;
>  

