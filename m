Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE8F13B293
	for <virtualization@lists.linux.dev>; Fri, 15 May 2026 14:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778855041; cv=none; b=IOBFyry9Y2UYrJHfy/6o7u7NeEbbatOHBuINLE4FbFbsieOsGb1AEgZcXRQ/zxvkf21xdII4S9kzlNr8e1BZ62bPlcGt59SKTP54px2NfdBkv8WXd6Ol722OlLl/O937mtv8ZFbPOf4Vk07e/ajSinod4BA1wKUtqNNCWsgArEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778855041; c=relaxed/simple;
	bh=8tMd4kBQi6Hy9PmLRVOHEXCV4eeVaKBxaPfChs5q6/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=fdVGmJzrvw7VLp+iuwe42ufgqZxSKGObPtmsum7Mp0JFG0KL9sI+zrpoCGuQk3+/pofeCqcJFzOXvfFJr9nBb1Z+TAy3/646pUei+gtK8kpyuhs5Fk8CJFQ2InN7arpKYohLIQh+yAvpAd/GeIV9Q1c2EbtgA7L+fCPI20N+1IY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=CXjxnACs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CXjxnACs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1778855039;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=lIVZ/gYLJQUpRzC6abUVWLp7JCDoikQOBxMDIsDaUrM=;
	b=CXjxnACs22vjibw4orU1K+aJe1+7zoyB9xZ1nLDoq/XIwADT/+yQ0PQdhSMcNqBb4asMjE
	Eu/DiWKS2yfmtvO9TZittt3PBTjKJS/usJ6tz49tRHLLaCCz39QiFuDSu4yshncC6jEwCe
	1Xvu3heLzf0H+NrgOV/xKA38jc2iwIc=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-128-mGnjvsAJMgSpmupyYqdMbw-1; Fri, 15 May 2026 10:23:58 -0400
X-MC-Unique: mGnjvsAJMgSpmupyYqdMbw-1
X-Mimecast-MFC-AGG-ID: mGnjvsAJMgSpmupyYqdMbw_1778855038
Received: by mail-qk1-f197.google.com with SMTP id af79cd13be357-90fb1490e2cso698009785a.2
        for <virtualization@lists.linux.dev>; Fri, 15 May 2026 07:23:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778855038; x=1779459838;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lIVZ/gYLJQUpRzC6abUVWLp7JCDoikQOBxMDIsDaUrM=;
        b=m2iO8tv1aWgSS6L/5y7eI3lOndAff0s6mvKlFrzx0FtvufoevW/kCiuxW+Wk9uHaCi
         O0sAnRrk7Q87FHQwNZ2pKnp58dN9owzjdu7A9ijHROwwOf8I3+d3FG8IHGgtgDKblthQ
         blpoHHD3IXIJKQ9Pw66w/5lUnrn9Rvd1kyHXM5+aLcgIp0RuuwnbRLTfqa33ycF7m4iF
         H7H9Vu/G8DOSSEt/SYP5Z1+Gql7vNlOJP8zpveTtmmCNB0qO32X5L1Qm3DSpjLIwOzUB
         tLiH002Z+0rLkaYus7ZNoJtPzupzPDlyWMtQHnkreB0EYSL7Pv2UIqQEh7LFNzJ60EVD
         HuWw==
X-Forwarded-Encrypted: i=1; AFNElJ+DE3ZfWybZN43M/Kuc5rAI5s/x5ZF4B/VC2AcVwr/N06fYXWA8BwtdsCqAGSQWrsTxxODUxumRL6abUk6ikA==@lists.linux.dev
X-Gm-Message-State: AOJu0YwKn7MZ/4P2JSSVskzCoNTA+rWXCdrBSb4hYnnEqoIRUsX7PF+1
	6XeIOSdr0vha+iEiOwzdK16m249AFtcgrJ7dgzvwQx0k3K/pAJ5d4eKVkc1jhNudc0aSWPqYVfT
	eMM794/641ZGHAa+iSY0hh6rA8stS3vmOn479dV6VKZwhbNSpOR2rv4UiIF+hnX+VV/ab
X-Gm-Gg: Acq92OG/P6ozyfnDXM/FOl7DdMn6cvCH91hdJ673Au6svVQCD1PPoHhHFu/TteBYOLi
	RYmeCGBcfl3S8JJhZtVJqqeWCwyoi4Wex8RfQEKzneDhAz/+YPv1WpwWl2YBiFV6HlR7lHQdZ06
	u4IZvcWvABEa78gjOSnp6w/VeJ4GlNsZJSfvu7mVSmRIRzbGU2fl2xbdZcyY3wa/pcPmbgqzKbt
	iSXPKXHuy7PH5dEHSk30XV8uVZ+TI1GI9V3UzxRa9QnGPP1Pexs6i84j0a9SSuIxobglnCe6LvT
	43nphnxbBJ0DMlZooCKP9Dpn2mUOdf+CIoO5TbqnI6L8Zf3EJOpDCQi/Zfj5t8sR7eVM8whNpl4
	C3BB9YCkLIMoT6lIKpWws2LIf1CCQegzGAfqG8IHrTuG5ah5gMOfNgZrd4k4=
X-Received: by 2002:a05:620a:ac0a:b0:912:61f8:cab1 with SMTP id af79cd13be357-91261f8d5b2mr222477085a.25.1778855037713;
        Fri, 15 May 2026 07:23:57 -0700 (PDT)
X-Received: by 2002:a05:620a:ac0a:b0:912:61f8:cab1 with SMTP id af79cd13be357-91261f8d5b2mr222472385a.25.1778855037128;
        Fri, 15 May 2026 07:23:57 -0700 (PDT)
Received: from leonardi-redhat ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-910bd620fbcsm570309485a.42.2026.05.15.07.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 15 May 2026 07:23:56 -0700 (PDT)
Date: Fri, 15 May 2026 16:23:53 +0200
From: Luigi Leonardi <leonardi@redhat.com>
To: stable@vger.kernel.org
Cc: Stefano Garzarella <sgarzare@redhat.com>, 
	Eric Dumazet <edumazet@google.com>, Arseniy Krasnov <AVKrasnov@sberdevices.ru>, 
	Stefan Hajnoczi <stefanha@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, virtualization@lists.linux.dev, Jakub Kicinski <kuba@kernel.org>
Subject: Re: [PATCH] vsock/virtio: fix potential unbounded skb queue
Message-ID: <agcsQ4LlG9ZsvBGR@leonardi-redhat>
References: <20260515-dumazet-v1-1-73468c902889@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260515-dumazet-v1-1-73468c902889@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: RyXUN4U9fc2YejAPBVQWzrjOtLm9J0DbdWDzFh8LCHI_1778855038
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, May 15, 2026 at 04:22:12PM +0200, Luigi Leonardi wrote:
>From: Eric Dumazet <edumazet@google.com>
>
>Upstream commit 059b7dbd20a6f0c539a45ddff1573cb8946685b5
>
>virtio_transport_inc_rx_pkt() checks vvs->rx_bytes + len > vvs->buf_alloc.
>
>virtio_transport_recv_enqueue() skips coalescing for packets
>with VIRTIO_VSOCK_SEQ_EOM.
>
>If fed with packets with len == 0 and VIRTIO_VSOCK_SEQ_EOM,
>a very large number of packets can be queued
>because vvs->rx_bytes stays at 0.
>
>Fix this by estimating the skb metadata size:
>
>	(Number of skbs in the queue) * SKB_TRUESIZE(0)
>
>Fixes: 077706165717 ("virtio/vsock: don't use skbuff state to account credit")
>Signed-off-by: Eric Dumazet <edumazet@google.com>
>Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>Cc: Stefan Hajnoczi <stefanha@redhat.com>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Cc: Michael S. Tsirkin <mst@redhat.com>
>Cc: Jason Wang <jasowang@redhat.com>
>Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>Cc: Eugenio Pérez <eperezma@redhat.com>
>Cc: virtualization@lists.linux.dev
>Link: https://patch.msgid.link/20260430122653.554058-1-edumazet@google.com
>Signed-off-by: Jakub Kicinski <kuba@kernel.org>
>[LL: Fixed conflict since this tree does not use buf_used added by commit
> 45ca7e9f0730 ("vsock/virtio: fix `rx_bytes` accounting for stream sockets")]
>Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
>---
> net/vmw_vsock/virtio_transport_common.c | 4 +++-
> 1 file changed, 3 insertions(+), 1 deletion(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 4c374c36c29d..86e3051d000e 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -283,7 +283,9 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> 					u32 len)
> {
>-	if (vvs->rx_bytes + len > vvs->buf_alloc)
>+	u64 skb_overhead = (skb_queue_len(&vvs->rx_queue) + 1) * SKB_TRUESIZE(0);
>+
>+	if (skb_overhead + vvs->rx_bytes + len > vvs->buf_alloc)
> 		return false;
>
> 	vvs->rx_bytes += len;
>
>---
>base-commit: 3b9f64db049687c0d38b4b3ef2f297f0642179af
>change-id: 20260515-dumazet-07c0c855a9e2
>
>Best regards,
>--
>Luigi Leonardi <leonardi@redhat.com>
>

Forgot to add this is material for 6.6.y stable tree.

Luigi

