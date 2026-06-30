Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 661783A874F
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jun 2026 09:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782812480; cv=none; b=qTr+Oha3DvQPKVA+rscWdXUuLZNLpgt5LR8SjjuPvyMLmnLV9drOgcVFaF89P1ryU+C/EvqZBgHyISvaCmB0IUOpz44Nr+rXxoTHzijd2CAHHU0I2mZJAXa2qPyIyyhxDjIe0SSjyVXxoxHvmjTNw5FoVhe5kCmDKhDJ/YsLH7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782812480; c=relaxed/simple;
	bh=YqmB8gQ2CSWotm3YyLmOYcMApzVTX/fpUiUxd3r4ALA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dlKrLvQIYXV1gaUHT4s0TLXlJ5/ZTxA4GWpb7mE3Uc/F2fs7mDMurWLh9uRWqSFMrkiUokiH/WvHjwvM4Md73UdohKwKuE/Mn0SjCjPkuf7QlqU6mu8oEjt3UVAkZsgGJ/qDaMQCBhup1M40haKtfl5PTxFqIZ3uxB6X6SSQyXQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=N5jUq8qt; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="N5jUq8qt"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 1F7BE82337
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jun 2026 09:41:19 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 85w0bAJ6Zbzs for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Jun 2026 09:41:18 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org 1437B8233A
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1437B8233A
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N5jUq8qt
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1437B8233A
	for <virtualization@lists.linux-foundation.org>; Tue, 30 Jun 2026 09:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782812476;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=sT7VxdFpL+bwbQAtpOmSJ4nkpUzUgPkf4e0PHfftdcI=;
	b=N5jUq8qteDoM2HBNvyK73qszNNqKgxoj9PCsuFRJxktYMpuj3xaYNgBI+BlxA353im8Im2
	JH/aDt3RvCg7h7+fOHhTuyFdKZR82WRO3GvOmK+t8mmcYA15WZ8vcjz5EtJeqXN7QlL5y+
	OVBbQVFnPeSqyE+4bRBaWB8eEzZVILM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-379-1_sUdPvgOeuGahOvkgThSA-1; Tue, 30 Jun 2026 05:41:14 -0400
X-MC-Unique: 1_sUdPvgOeuGahOvkgThSA-1
X-Mimecast-MFC-AGG-ID: 1_sUdPvgOeuGahOvkgThSA_1782812473
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-492714d002cso16486495e9.0
        for <virtualization@lists.linux-foundation.org>; Tue, 30 Jun 2026 02:41:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782812473; x=1783417273;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sT7VxdFpL+bwbQAtpOmSJ4nkpUzUgPkf4e0PHfftdcI=;
        b=hZ7Qo76a4sobAc1ABjtI78P0jJlhjYsYQL+q2s7/vFdDV9c7KG7GboVMx+J9Okwxi9
         +vU4ad1Yf+L6A/xRp9ACZkZ9ebETXmQVYhKU1mJ7mGYI9uyaiPkQGbc9sh8adPv9v135
         W98fxm9dRMeUTlqqTdj1oKu8SxxmW9vACOpoEvfM/ihCLWXA5KkGa9AX70LLtieoiGvd
         CCvkBomIJhty3wg5cPmpXjImeaSXwpyQ4xMqz0tKTb7DwbUMpUwSPY7I/6rpc1R9Eiq3
         RS9K0WdISijFOgCZ8h+ZHhgdqVj1pUzmdYevC+vBkE9MGevOh9Ce0JMeKsi7DvOiCBRn
         QTmA==
X-Forwarded-Encrypted: i=1; AFNElJ8uIeX1vJVqSEGXwgDb+RsWwsOoKhWF5IAg30uM2XfNk41p4QXKxta33CMrEL8pmgvS4AF67ZVchT+/Mqj6GA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Ywoo8sFZM7+TIqSKhn8qenbHtPzP1CoVNsVUGb4R9kV/0v3vZrN
	xtCAFEyokoyO6XwqIom/PiLkSAaNrWG/ysKdyGsITe0A0QvEHB7DNHYa1aa1yIsYb/Yyx9WcoMW
	3HkDYdQMa4oVGzXTHnuOPAQCv/XAxfRk8QoUT7SOB9pkIuf9+ARjM22tuLLGt34buq3hCaS7wlz
	hkY4uTQfg=
X-Gm-Gg: AfdE7cltN6WWoz7b7aVEAiPdcvjLGTUPW3LjNnN7xEIVe7jlm3RJip17xSwENc0cnDt
	dS6MGTknlrFFmXPdAngIgKkYCBmyqf8Ia7AEilsWxibYTC3t3VqU/DdPFes+z4Vjf0fKw4a0/MO
	THYJkYZsccFoiaOqNTRtHjVhUbbQIttAl9P8LHx4N6JNox3VXa9zc3J2GuCApyW5gWivP3Lsnhk
	2524/Tvmef7RThpESiYKCo2IEjMahc8kuCSI3g1s9MXZIOE5DY0xjsVwUxcHHYd18UjwG1Tet/c
	tDt3B5iBx466q2rgr2WD5yMMLxU68sp+5JJqG4Gx78iwvCJMvw2O9UTU7lu0TMxDhHoCqbAsKwm
	861asir9/hwNCe6utrWXDM5TytfyE1D6L7YMFrmeJe5Asu+MtblM0bFtmGHRr
X-Received: by 2002:a05:600c:a403:b0:493:a5d0:d1a1 with SMTP id 5b1f17b1804b1-493b82bc279mr38092575e9.31.1782812473030;
        Tue, 30 Jun 2026 02:41:13 -0700 (PDT)
X-Received: by 2002:a05:600c:a403:b0:493:a5d0:d1a1 with SMTP id 5b1f17b1804b1-493b82bc279mr38092065e9.31.1782812472479;
        Tue, 30 Jun 2026 02:41:12 -0700 (PDT)
Received: from sgarzare-redhat (host-79-34-22-35.business.telecomitalia.it. [79.34.22.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493b8d0bbbcsm64869355e9.13.2026.06.30.02.41.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2026 02:41:11 -0700 (PDT)
Date: Tue, 30 Jun 2026 11:41:07 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@rulkc.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobbyeshleman@meta.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Simon Horman <horms@kernel.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	oxffffaa@gmail.com, rulkc@linuxtesting.org
Subject: Re: [PATCH net-next v4] vsock/virtio: rewrite MSG_ZEROCOPY flag
 handling
Message-ID: <akOOf7ShQS4OBJrd@sgarzare-redhat>
References: <20260628182052.951760-1-avkrasnov@rulkc.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260628182052.951760-1-avkrasnov@rulkc.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Ah1vNLAJlfECjaRpTqrwvvf6-8yNzewmf1wo2wxCqWI_1782812473
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sun, Jun 28, 2026 at 09:20:52PM +0300, Arseniy Krasnov wrote:
>Logically it was based on TCP implementation, so to make further support
>easier, rewrite it in the TCP way (like in 'tcp_sendmsg_locked()'). By
>this way, patch also adds handling case when 'msg_ubuf' is already set.

Thanks for this!

IIUC the result will be similar of commit eb315a7d1396 ("tcp: support 
externally provided ubufs") for tcp. Maybe I would have added it to the 
commit description, anyway the patch LGTM:

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>
>---
> Changelog v1->v2:
> * Rebase on last 'net-next'. Don't need 'skb_zcopy_set()' now - it was
>   already added.
> Changelog v2->v3:
> * Update commit message.
> * Remove one empty line.
> Changelog v3->v4:
> * Update commit message.
>
> net/vmw_vsock/virtio_transport_common.c | 47 ++++++++++++-------------
> 1 file changed, 22 insertions(+), 25 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 09475007165b..41c2a0b82a8e 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -328,38 +328,35 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
> 	if (pkt_len == 0 && info->op == VIRTIO_VSOCK_OP_RW)
> 		return pkt_len;
>
>-	if (info->msg) {
>-		/* If zerocopy is not enabled by 'setsockopt()', we behave as
>-		 * there is no MSG_ZEROCOPY flag set.
>+	if (info->msg && (info->msg->msg_flags & MSG_ZEROCOPY)) {
>+		/* If 'info->msg' is not NULL, this is only VIRTIO_VSOCK_OP_RW.
>+		 * 'MSG_ZEROCOPY' flag handling here is based on the same flag
>+		 * handling from 'tcp_sendmsg_locked()'.
> 		 */
>-		if (!sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY))
>-			info->msg->msg_flags &= ~MSG_ZEROCOPY;
>+		if (info->msg->msg_ubuf) {
>+			uarg = info->msg->msg_ubuf;
>+			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
>+		} else if (sock_flag(sk_vsock(vsk), SOCK_ZEROCOPY)) {
>+			uarg = msg_zerocopy_realloc(sk_vsock(vsk), pkt_len,
>+						    NULL, false);
>+			if (!uarg) {
>+				virtio_transport_put_credit(vvs, pkt_len);
>+				return -ENOMEM;
>+			}
>
>-		if (info->msg->msg_flags & MSG_ZEROCOPY)
> 			can_zcopy = virtio_transport_can_zcopy(t_ops, info, pkt_len);
>+			if (!can_zcopy)
>+				uarg_to_msgzc(uarg)->zerocopy = 0;
>
>+			have_uref = true;
>+		}
>+
>+		/* 'can_zcopy' means that this transmission will be
>+		 * in zerocopy way (e.g. using 'frags' array).
>+		 */
> 		if (can_zcopy)
> 			max_skb_len = min_t(u32, VIRTIO_VSOCK_MAX_PKT_BUF_SIZE,
> 					    (MAX_SKB_FRAGS * PAGE_SIZE));
>-
>-		if (info->msg->msg_flags & MSG_ZEROCOPY &&
>-		    info->op == VIRTIO_VSOCK_OP_RW) {
>-			uarg = info->msg->msg_ubuf;
>-
>-			if (!uarg) {
>-				uarg = msg_zerocopy_realloc(sk_vsock(vsk),
>-							    pkt_len, NULL, false);
>-				if (!uarg) {
>-					virtio_transport_put_credit(vvs, pkt_len);
>-					return -ENOMEM;
>-				}
>-
>-				if (!can_zcopy)
>-					uarg_to_msgzc(uarg)->zerocopy = 0;
>-
>-				have_uref = true;
>-			}
>-		}
> 	}
>
> 	rest_len = pkt_len;
>-- 
>2.25.1
>

