Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA1F83DDDC4
	for <virtualization@lists.linux.dev>; Tue,  9 Jun 2026 08:48:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780994940; cv=none; b=gA3MZK+EU22rtTPn4B0KmgAIOVlNfG2lK5KOE2UTzGyKcXR4zENtu6W0hmoP/CSemPAQBOzkBOouFQ/awTYei35VnVmrVx7av4hstHPXVp7e/CRyg8c/LTX/Xc6FvxhZTZEs6WMegTINqRDZtUXMCIuoYwxRq5YOxFqdiDLItfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780994940; c=relaxed/simple;
	bh=NDpEqQTyBnFaNwSrHBIymgwCB1NOUG/MXeIFTqcPqBc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=H7M9gP6FNgTZ7m038dVphC1EnuWyElV2VO/Yg66mTLBxTgR2V7yBjOKNw7epfuVAW7YgLXZuv0JLoP2HgPhqVFJ69tZzBpxifeA7DCwjvdA/azeQNykHVsVDI4t1+nm2/qxCABeOaNii+GwPVpChOcEAlWYICk6wbsuM38s0Iis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R/MBOy95; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R/MBOy95"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1780994938;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YVJGRkzfCQAxcTxT+5xsslew5qgZuC6BrnznINZ4a2c=;
	b=R/MBOy95DbYcUGo4QM7QcKEdWgHXh+T8T/T7y880Jm1MKBhTG9eQk17d5+bF/fKcfhWJiP
	1jobrBaOyIhlaxZ7pUKQeTjxB0XVywvlrb5UNU/5J+00LjnVCOAitG5k+m66i+fUJo0aMx
	7YPO3WAtMEMBi/yLyDqhxHOZu6TPtfk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-381-moN2rHyyNmCATLadSJme7Q-1; Tue, 09 Jun 2026 04:48:56 -0400
X-MC-Unique: moN2rHyyNmCATLadSJme7Q-1
X-Mimecast-MFC-AGG-ID: moN2rHyyNmCATLadSJme7Q_1780994935
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45ef0af9517so2918035f8f.3
        for <virtualization@lists.linux.dev>; Tue, 09 Jun 2026 01:48:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780994935; x=1781599735;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVJGRkzfCQAxcTxT+5xsslew5qgZuC6BrnznINZ4a2c=;
        b=OVsfYzU40Ch/f72RRM/0czlmgJ9YQzVUz+uXNI9uTYyqpvdNQaBExRnN0noAowG81M
         NpkY/g2V5hUwOPa3sHzYEQrK4kT1J9SITFqbW9XJzY0xxbNIdPFDFgKoi8M8DY9rdxHg
         O9vEvxJ8bvj+dWFsr2LMtHVyoyIfnCSPxraBq1j8C/bny+WLSjvxQ6bqRHkgFfNfRUgb
         +0cwSMEiGBtAUeUINFVtVSYFG2V4x2RsWT20NV3lgSQBMWRThSKvZFoqXKEW5zDw+kbk
         X6DArj/JlvKEHlTGCdlN+rlYUY/Wifr/a/53PCCOgf0ESRWcuQWjOpDopgydKUATZdME
         8WiA==
X-Forwarded-Encrypted: i=1; AFNElJ8O2RhUUWL1Dlw4UkL45nUjTBG3a2BjY3TvpGwZ0R/MSysBmBQApal5ROR9DEkmTa4VA+wz2uJC1s+3VR9N+w==@lists.linux.dev
X-Gm-Message-State: AOJu0YwMaAkUItR+gekmtO9dgO+o5DKrbQSj7dvn9+JP0rYtJsm4W6K7
	MiJdfneMFKUbJFvJyz2yBYBm9kWDEJ0X5TaZuYjjctADfIh90YTEIg53iCO5jeQryX2FttILeGc
	FT4Lev65eZpdcw7BzSS6k+NxCLr40hlZgKkb+mhiWdtx/ZdqyccG5QV7w/LhzwVed9aFn
X-Gm-Gg: Acq92OGcVD8j18WcIHa3/UguI3pARBHZfEiXjFjwmIyaIBQspBhpTEXeJYDYXnZ0YCO
	cB6LrVoONZl4OIEmjTx5eEl2AiXSnTWNHBf/1G9agJJEN306wT11i09pteUbFPVMbUCCV+IxZNL
	qpQk7Clg2eOJVA0l7bP4zq//tXfzIjfdHro/IUwcSMIO2gqpFPdCYoIvUQ2+PAiWHxhP57rbPhi
	JsA7EiawcnQAtrtDvxjTEAbQ4OHK5tglXsbbM3p/HQmxSHfEiMCmRGtkXJ5u3351lgBMW9fvwTZ
	0yXkdGmsZ6WKDqRLBOHbT2gKmgjaqfOMr5D+7L5UMgcDsJwVo7k9pHEKtkPJ56iD3MjiL/4bEVK
	uZCWgI+Hv7w3Sr5hMxnleNZpAotMjs0JJ/fPiT5bgKtfd0Z81UXbw86IYBxRGWQNMbp/TCTCrs0
	ZNhvJoNw==
X-Received: by 2002:a5d:4e03:0:b0:43d:740:fb37 with SMTP id ffacd0b85a97d-46030641a81mr22875639f8f.24.1780994935306;
        Tue, 09 Jun 2026 01:48:55 -0700 (PDT)
X-Received: by 2002:a5d:4e03:0:b0:43d:740:fb37 with SMTP id ffacd0b85a97d-46030641a81mr22875570f8f.24.1780994934775;
        Tue, 09 Jun 2026 01:48:54 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4601f351d69sm108611773f8f.29.2026.06.09.01.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 01:48:54 -0700 (PDT)
Date: Tue, 9 Jun 2026 10:48:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Octavian Purdila <tavip@google.com>
Cc: netdev@vger.kernel.org, 
	syzbot+28e5f3d207b14bae122a@syzkaller.appspotmail.com, Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Arseniy Krasnov <avkrasnov@salutedevices.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] vsock/virtio: restore msg_iter on transmission
 failure
Message-ID: <aifL0f_QO1kocccU@sgarzare-redhat>
References: <20260609004809.1285028-1-tavip@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260609004809.1285028-1-tavip@google.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: R8G1Y9K4K6OYgWZ0dzNvEpbXTHL47VzGB9VhzbbWvLA_1780994935
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Tue, Jun 09, 2026 at 12:48:05AM +0000, Octavian Purdila wrote:
>When transmission fails in virtio_transport_send_pkt_info, the msg_iter
>might have been partially advanced. If we don't restore it, the next
>attempt to send data will use an incorrect iterator state, leading to
>desync and warnings like "send_pkt() returns 0, but X expected".

Thanks for the fix! I have some comments.
>
>Specifically, this can happen in the following scenario, triggered by
>the syzkaller repro:
>
>1. A write-only VMA (PROT_WRITE only) is partially populated by a
>   prior TUN write that failed with -EIO but still faulted in some
>   pages).
>2. A vsock sendmmsg call with MSG_ZEROCOPY requests transmission of a
>   buffer from this VMA.
>3. The first packet (64KB) is sent successfully because the pages are
>   populated.
>4. The second packet allocation fails because GUP fast pins the first page
>   but GUP slow fails on the next unpopulated page due to PROT_WRITE-only
>   permissions.
>5. The iterator is advanced by the partially successful GUP (68KB total
>   advanced: 64KB from first packet + 4KB from second), but the send loop
>   breaks and only reports 64KB sent. This creates a 4KB desync.
>6. The next retry starts with a non-zero iov_offset, disabling zerocopy
>   and falling back to copy mode.
>7. In copy mode, the transmission succeeds for the next packets but
>   exhausts the iterator early because of the desync.
>8. The final retry sees an empty iterator but zerocopy is re-enabled
>   (offset resets). It attempts to send the remaining bytes with zerocopy
>   but pins 0 pages, creating an empty packet.
>9. The transport sends the empty packet, triggering the warning because
>   the returned bytes (header only) do not match the expected payload size.
>10. The loop continues to spin, allocating ubuf_info each time, eventually
>    exhausting sysctl_optmem_max and returning -ENOMEM to userspace.
>
>Restore msg_iter to its original state before the packet allocation
>and transmission attempt if they fail.
>
>Fixes: e0718bd82e27 ("vsock: enable setting SO_ZEROCOPY")
>Reported-by: syzbot+28e5f3d207b14bae122a@syzkaller.appspotmail.com
>Closes: https://syzkaller.appspot.com/bug?extid=28e5f3d207b14bae122a
>Assisted-by: gemini:gemini-3.1-pro
>Signed-off-by: Octavian Purdila <tavip@google.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 11 ++++++++++-
> 1 file changed, 10 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index b10666937c490..588623a3e2bbc 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -367,6 +367,10 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 	do {
> 		struct sk_buff *skb;
> 		size_t skb_len;
>+		struct iov_iter saved_iter;

trivial: reverse xmas tree: 
https://docs.kernel.org/process/maintainer-netdev.html#local-variable-ordering-reverse-xmas-tree-rcs

>+
>+		if (info->msg)
>+			saved_iter = info->msg->msg_iter;

What about using iov_iter_save_state()/iov_iter_restore() ?

IIUC we may need to export iov_iter_restore(), so not a strong opinion, 
but it looks better to use those API IMHO.

>
> 		skb_len = min(max_skb_len, rest_len);
>
>@@ -375,6 +379,8 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 						 src_cid, src_port,
> 						 dst_cid, dst_port);

What about adding a comment on top of virtio_transport_alloc_skb() call 
(or when we save the state) to explain that in specific cases it can 
advance the msg_iter ?

> 		if (!skb) {
>+			if (info->msg)
>+				info->msg->msg_iter = saved_iter;
> 			ret = -ENOMEM;
> 			break;
> 		}
>@@ -382,8 +388,11 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 		virtio_transport_inc_tx_pkt(vvs, skb);
>
> 		ret = t_ops->send_pkt(skb, info->net);
>-		if (ret < 0)
>+		if (ret < 0) {
>+			if (info->msg)
>+				info->msg->msg_iter = saved_iter;

Also, what about having a single restore point after the loop?

I mean something like this (untested):

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index b10666937c49..2f3c6c82c155 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -295,6 +295,7 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
         u32 max_skb_len = VIRTIO_VSOCK_MAX_PKT_BUF_SIZE;
         u32 src_cid, src_port, dst_cid, dst_port;
         const struct virtio_transport *t_ops;
+       struct iov_iter_state msg_iter_state;
         struct virtio_vsock_sock *vvs;
         struct ubuf_info *uarg = NULL;
         u32 pkt_len = info->pkt_len;
@@ -368,6 +369,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
                 struct sk_buff *skb;
                 size_t skb_len;
  
+               if (info->msg)
+                       iov_iter_save_state(&info->msg->msg_iter, &msg_iter_state);
+
                 skb_len = min(max_skb_len, rest_len);
  
                 skb = virtio_transport_alloc_skb(info, skb_len, can_zcopy,
@@ -399,6 +403,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
                         break;
         } while (rest_len);
  
+       if (info->msg && ret < 0)
+               iov_iter_restore(&info->msg->msg_iter, &msg_iter_state);
+
         virtio_transport_put_credit(vvs, rest_len);
  
         /* msg_zerocopy_realloc() initializes the ubuf_info refcnt to 1.


Thanks,
Stefano

> 			break;
>+		}
>
> 		/* Both virtio and vhost 'send_pkt()' returns 'skb_len',
> 		 * but for reliability use 'ret' instead of 'skb_len'.
>-- 
>2.54.0.1064.gd145956f57-goog
>

