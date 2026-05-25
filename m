Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96EAA372054
	for <virtualization@lists.linux.dev>; Mon, 25 May 2026 11:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779708349; cv=none; b=hq7CXip3+l54ftmcW0exyKVRZSCUz6HkrR/v9fwWGbN3g17VOAFXmgUg5s9dGdq17JQ8CtZ4XWNiV9HGkHDCPvK7f0P8vXgPQrrJMn6wLa4UkgprQYDP6ZWo/5vnGA8REVURCOUL4wHfh/AJVfybuW8hRB8cfB1h1st+Yk3QVRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779708349; c=relaxed/simple;
	bh=zuX0Di4TKhnMq54tvjmHDzO+X5SQw874TgobIrg3T80=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=j5O/6oE9dv/FFk1hVxRR4iZietWBZYoMJHiBtaT1QIRtxQKGfmIbnzu0Z12C3j/sX6CalfrCHTbI3iG2m27AcRIMlFiS+3FNtMJG8VmMHClMntBgPGY765K3LKbf6uh4fBX0oDPnMSdPgGk8QIb1G3vFw7VOr2hspUuoS35qseE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=eBq1y+E9; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eBq1y+E9"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1779708346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=7IxQxHR/6kpLhzpKQfpUJefi9nFgXyGkAWeI40YgJOo=;
	b=eBq1y+E96i+zwBYCjDe2OkDzOBFsBXnRoI0rJEppAqfpi8Fk70pnMlZKkwGsdOpXUmWG0i
	koIDk2yIm6OcsT0RQKguJnMVwgZt4A4558gLIOXX9KP7jDs5s/9HR5SP1sNbC8Cu8asKJ0
	C6k1ino/l0LuEkcVMeiGS4CpMrhXnRA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-489-q9_Qx7XzNh26q-YMkqo4iw-1; Mon, 25 May 2026 07:25:45 -0400
X-MC-Unique: q9_Qx7XzNh26q-YMkqo4iw-1
X-Mimecast-MFC-AGG-ID: q9_Qx7XzNh26q-YMkqo4iw_1779708344
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-49047e9ca88so22915205e9.3
        for <virtualization@lists.linux.dev>; Mon, 25 May 2026 04:25:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779708344; x=1780313144;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7IxQxHR/6kpLhzpKQfpUJefi9nFgXyGkAWeI40YgJOo=;
        b=pV+u6shW6Vppspr8H1l8I4612x7VmQxIFZuqJVtP6dyb6wQACF62HxX6SGEmZkb514
         ATO/20M0EyYv+4PTXKXAO0SRViGGzy2fdqgWZnGYClR/888U7e4MymU0/uvK4pqKY2Cw
         vM+OsmGXZNC2e0HhVxV9eGYHc46Ms4ZYMBRwfp3NEc2WL92cZSeoAFsqUBXlga1DV75T
         783ZQXWkYBwLcvjtY9boBVa6PzmPNKJh5lUl6ojc4reK+4BNWDRjrDeoxSH/KEbDjCis
         2Ce6zd9gVTCcSblMjPrAptkU3VlzxQPBgC4vDlVk2Jz8QNNGQmrsot6UMmOPc+mzWkmd
         3+JQ==
X-Forwarded-Encrypted: i=1; AFNElJ/+2ecuFR3Ic/LvgDdD7hEChwzUlVqZdiH7hApRL1xJxXZm90nX1iCoiIr4QsafUSnn+syFWBZUiKC0ONfXiw==@lists.linux.dev
X-Gm-Message-State: AOJu0YyzXS/cdQ/XjKrRr9wWu0YrUaEGVXluJtriykOT5MJ9uhOVrS4b
	zZVuvdB2fYf5/5jao+spgO8HEBIRWxgpZtfnTQ7TdOnsw0eyA9yvLdAiK4czrnq+AgNCo+THRM8
	izJyO+70xBRpbg1hvxc6q5LRVydQ8dB53p1rXbgIh55Zljj/JG6+HH0NbIwtR4gk1wJjt
X-Gm-Gg: Acq92OGBAEGpxXehaiBJQUo4fI8H2XsSReCwkd+5ES6suHtsYPsFCZpmygiH1x48JuD
	GsMyQZoTGbSQn1+O100ncEpfkaohocdMcRhcRjXvhls56lXisHgw1Rkr9SLdwr1NDb8SQpn6zMW
	hjfWCvicjPzdReC1ZTFrsil8/tEHDfcGxMro7omAt50tPP0j1N5kuINNong+x47eMnk5EgcbJY3
	Tg+9qm1bbMEshNevBIHSff0M512EHeJ8Y04h4WV7+m45llxkupqIfbSaTY0Zar9Jr4p0miCynEu
	AKTBh/dedaWbrg6tQFkknY2Nr/8pApFazTawb2ZhlUsFo8rw05D/1yX99r+zz+yeAvrWFLDcC2p
	fANjNWM7NSwxpAgO9JZd7KKLj0muQz10ksMbx2/u1cQk=
X-Received: by 2002:a05:600c:4510:b0:489:1c1f:35df with SMTP id 5b1f17b1804b1-490424a682emr215601055e9.10.1779708343995;
        Mon, 25 May 2026 04:25:43 -0700 (PDT)
X-Received: by 2002:a05:600c:4510:b0:489:1c1f:35df with SMTP id 5b1f17b1804b1-490424a682emr215600375e9.10.1779708343354;
        Mon, 25 May 2026 04:25:43 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-45.inter.net.il. [80.230.25.45])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49045282201sm268455945e9.8.2026.05.25.04.25.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2026 04:25:42 -0700 (PDT)
Date: Mon, 25 May 2026 07:25:38 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "malin (R)" <malin89@huawei.com>
Cc: Arseniy Krasnov <avkrasnov@salutedevices.com>,
	tanjingguo <tanjingguo@huawei.com>,
	"jasowang@redhat.com" <jasowang@redhat.com>,
	"xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
	"eperezma@redhat.com" <eperezma@redhat.com>,
	"stefanha@redhat.com" <stefanha@redhat.com>,
	"sgarzare@redhat.com" <sgarzare@redhat.com>,
	"davem@davemloft.net" <davem@davemloft.net>,
	"edumazet@google.com" <edumazet@google.com>,
	"kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>,
	"horms@kernel.org" <horms@kernel.org>, Chenzhe <chenzhe@huawei.com>,
	cenxianlong <cenxianlong@huawei.com>,
	cuirongzhen <cuirongzhen@huawei.com>,
	"virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
	"kvm@vger.kernel.org" <kvm@vger.kernel.org>,
	"netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] vsock/virtio: bind uarg before filling zerocopy skb
Message-ID: <20260525072533-mutt-send-email-mst@kernel.org>
References: <9fece5ea269049f883f367642c07eaa0@huawei.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <9fece5ea269049f883f367642c07eaa0@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: MFtYXgcUOGb26bLTYu9ULXuozCaXrEczb1bP4E_gYEY_1779708344
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, May 25, 2026 at 11:15:12AM +0000, malin (R) wrote:
> >From 9eea4f61a4dca97f56c23e12267219bf791a20d1 Mon Sep 17 00:00:00 2001
> From: Jingguo Tan <tanjingguo@huawei.com>
> Date: Fri, 22 May 2026 19:53:45 +0800
> Subject: [PATCH net] vsock/virtio: bind uarg before filling zerocopy skb
> 
> virtio_transport_send_pkt_info() allocates or reuses the zerocopy uarg
> before entering the send loop, but virtio_transport_alloc_skb() still
> fills the skb before it inherits that uarg. When fixed-buffer vectored
> zerocopy hits MAX_SKB_FRAGS, io_sg_from_iter() may partially attach
> managed frags and return -EMSGSIZE. The rollback path calls kfree_skb()
> to free an skb that carries SKBFL_MANAGED_FRAG_REFS but no uarg, so
> skb_release_data() falls through to ordinary frag unref.
> 
> Pass the uarg into virtio_transport_alloc_skb() and bind it immediately
> before virtio_transport_fill_skb(). This keeps control or no-payload skbs
> untouched while ensuring success and rollback share one lifetime rule.
> 
> Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
> Signed-off-by: Lin Ma <malin89@huawei.com>
> Signed-off-by: Rongzhen Cui <cuirongzhen@huawei.com>
> Signed-off-by: Jingguo Tan <tanjingguo@huawei.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> 
>  net/vmw_vsock/virtio_transport_common.c | 11 ++++++++---
>  1 file changed, 8 insertions(+), 3 deletions(-)
> 
> diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
> index df3b418e0392..73f58925ff72 100644
> --- a/net/vmw_vsock/virtio_transport_common.c
> +++ b/net/vmw_vsock/virtio_transport_common.c
> @@ -205,6 +205,7 @@ static u16 virtio_transport_get_type(struct sock *sk)
>  static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *info,
>  						  size_t payload_len,
>  						  bool zcopy,
> +						  struct ubuf_info *uarg,
>  						  u32 src_cid,
>  						  u32 src_port,
>  						  u32 dst_cid,
> @@ -245,6 +246,11 @@ static struct sk_buff *virtio_transport_alloc_skb(struct virtio_vsock_pkt_info *
>  	if (info->msg && payload_len > 0) {
>  		int err;
>  
> +		/* Bind the zerocopy lifetime before filling frags so error rollback
> +		 * frees managed fixed-buffer pages through the uarg-aware path.
> +		 */
> +		skb_zcopy_set(skb, uarg, NULL);
> +
>  		err = virtio_transport_fill_skb(skb, info, payload_len, zcopy);
>  		if (err)
>  			goto out;
> @@ -364,6 +370,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  		skb_len = min(max_skb_len, rest_len);
>  
>  		skb = virtio_transport_alloc_skb(info, skb_len, can_zcopy,
> +						 uarg,
>  						 src_cid, src_port,
>  						 dst_cid, dst_port);
>  		if (!skb) {
> @@ -371,8 +378,6 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
>  			break;
>  		}
>  
> -		skb_zcopy_set(skb, uarg, NULL);
> -
>  		virtio_transport_inc_tx_pkt(vvs, skb);
>  
>  		ret = t_ops->send_pkt(skb, info->net);
> @@ -1183,7 +1188,7 @@ static int virtio_transport_reset_no_sock(const struct virtio_transport *t,
>  	if (!t)
>  		return -ENOTCONN;
>  
> -	reply = virtio_transport_alloc_skb(&info, 0, false,
> +	reply = virtio_transport_alloc_skb(&info, 0, false, NULL,
>  					   le64_to_cpu(hdr->dst_cid),
>  					   le32_to_cpu(hdr->dst_port),
>  					   le64_to_cpu(hdr->src_cid),
> -- 
> 2.53.0

