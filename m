Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 455581E0DCF
	for <virtualization@lists.linux.dev>; Fri,  8 Nov 2024 09:13:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731057211; cv=none; b=t1fg33MmztkTIpcx6qXqfDzxsUOLu23atteQzL0OW2Th2OVrxxeqDb/DGwCwMxK3KRe7iB6caOnhnu2AbDFrTxab0xL0eMFMdR42pMQO1a9Zu3gDERREFkM+yqIJAMLL68Y3DTBXnvNKH90AmuuTV2MtexMnT16JD/VduQrB3Jo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731057211; c=relaxed/simple;
	bh=HEAsdYLwkrtGtogdvIBPZEXWue42gncPQ87YECUk5kY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=iK89MoxSgLcLaKz7Sha8+1TBtcWlvkC7iCz25EE1KMZNzPwfUztY2zXcGyTbZBGwpudg94ctrZvTqQc+9Dg38X77FQkRhZ6yJFXU1wLdVupQHRO+qsNqgYXczRKyfVH9wPL98wtUnym+YAuHjPfAixt93IDa816T3hA2tz3Ig6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=RNzik05j; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RNzik05j"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1731057208;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=GO0OGIRGWxKfjRBGTtqAfw57F84sGfgBv8XkGbO8UBE=;
	b=RNzik05jnXLZqJ9feI2reYharozV0DXk7KH98pr8XHdBcBqGH/60AwaZdKEvN81o5iym+k
	2RaeS+mfqN8Kpka9g8R6FqfpKtyFu1aeaOhEP9L9WNJ5N57Kf7OYJzsynwTHbOE27aoLHx
	0Ey55xd+g7TxmtYRUS7BfAvM0E9hbEs=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-267-LBQuQbSfNl-k5xqY4YDkCA-1; Fri, 08 Nov 2024 04:13:26 -0500
X-MC-Unique: LBQuQbSfNl-k5xqY4YDkCA-1
X-Mimecast-MFC-AGG-ID: LBQuQbSfNl-k5xqY4YDkCA
Received: by mail-wm1-f71.google.com with SMTP id 5b1f17b1804b1-4315b7b0c16so13550145e9.1
        for <virtualization@lists.linux.dev>; Fri, 08 Nov 2024 01:13:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731057205; x=1731662005;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GO0OGIRGWxKfjRBGTtqAfw57F84sGfgBv8XkGbO8UBE=;
        b=XjiiTHk24IJg1gxx/Qu1LQJE09f+9+WpCWWbx/GDDfM37Sg7X3C9/6WEyVB0I3OdTm
         7wO8kifI4PAlEQofkv8axqVW6eTwkMkjuH7nbFDZuf+EoRpM8F8pIzJeW+B8c9TGm/zF
         CnHgeSXyfZFX7Yg1xgLeWRSx4xy+MhC4kBHgetVaLL2oZHF2vlcxvwjc4WQ7t0bH0HU9
         LP/65uIgzcn0deu3mMLe1xdphkpMf/N6DlkavIfzWRZuDf7eFU5kcHkKva+/NlxzSG4G
         8zJJ8SZuQ//7C6NU/fZYLrC+ms6Zn8QkSW+sUsHRbtttTpEEifah7D56xqKB18g4S64Q
         JduA==
X-Forwarded-Encrypted: i=1; AJvYcCUOU1+1TktrOB2SWesIToPFngGTkV6D1Zofy6MY08rC7rNCiVgCK55JbrP4FNmXqU3EWoa9m0qEFk8okZn2dA==@lists.linux.dev
X-Gm-Message-State: AOJu0Yx39jfZ9OriYQHu/sKliU+BXIH/Art3UcdqojXYxpwGSfbgtI9z
	19aQeyZFKfP+JEV7K+SNAK1V70f7BsYT4+hvIluRYpH7Eq40B3PKnMyGgo4mtNcuisD1ew9h/Nq
	2P1GMop01qZu/qk7He0D56BCTbN15cPMpsHoJJflafrfkDpfbhyp6HZzGAaQAa+cA
X-Received: by 2002:a05:600c:1c88:b0:42c:de34:34be with SMTP id 5b1f17b1804b1-432b74fa92amr16075635e9.3.1731057205634;
        Fri, 08 Nov 2024 01:13:25 -0800 (PST)
X-Google-Smtp-Source: AGHT+IFAK5vTncKeqE+EzHOeYy/PGvMNPyTWcejCYkWGsZcXDWCK4COat90VpxuJseJwMBr3OSiYWQ==
X-Received: by 2002:a05:600c:1c88:b0:42c:de34:34be with SMTP id 5b1f17b1804b1-432b74fa92amr16075165e9.3.1731057205008;
        Fri, 08 Nov 2024 01:13:25 -0800 (PST)
Received: from sgarzare-redhat ([193.207.101.111])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05c1c81sm56640315e9.32.2024.11.08.01.13.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Nov 2024 01:13:24 -0800 (PST)
Date: Fri, 8 Nov 2024 10:13:17 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Michal Luczaj <mhal@rbox.co>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
	Jia He <justin.he@arm.com>, Arseniy Krasnov <avkrasnov@salutedevices.com>, 
	Dmitry Torokhov <dtor@vmware.com>, Andy King <acking@vmware.com>, 
	George Zhang <georgezhang@vmware.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, 
	netdev@vger.kernel.org
Subject: Re: [PATCH net v2 2/3] vsock: Fix sk_error_queue memory leak
Message-ID: <qjib7qrjxitohmdyjdvnxh7pavzkqohzthwn3mxiaot5copoh2@yg4dstc2fx5w>
References: <20241107-vsock-mem-leaks-v2-0-4e21bfcfc818@rbox.co>
 <20241107-vsock-mem-leaks-v2-2-4e21bfcfc818@rbox.co>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20241107-vsock-mem-leaks-v2-2-4e21bfcfc818@rbox.co>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: dCmTBOCU0rTrfAOC7pqI4S23My34URNNxJXUPIQobSk_1731057206
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Thu, Nov 07, 2024 at 09:46:13PM +0100, Michal Luczaj wrote:
>Kernel queues MSG_ZEROCOPY completion notifications on the error queue.
>Where they remain, until explicitly recv()ed. To prevent memory leaks,
>clean up the queue when the socket is destroyed.
>
>unreferenced object 0xffff8881028beb00 (size 224):
>  comm "vsock_test", pid 1218, jiffies 4294694897
>  hex dump (first 32 bytes):
>    90 b0 21 17 81 88 ff ff 90 b0 21 17 81 88 ff ff  ..!.......!.....
>    00 00 00 00 00 00 00 00 00 b0 21 17 81 88 ff ff  ..........!.....
>  backtrace (crc 6c7031ca):
>    [<ffffffff81418ef7>] kmem_cache_alloc_node_noprof+0x2f7/0x370
>    [<ffffffff81d35882>] __alloc_skb+0x132/0x180
>    [<ffffffff81d2d32b>] sock_omalloc+0x4b/0x80
>    [<ffffffff81d3a8ae>] msg_zerocopy_realloc+0x9e/0x240
>    [<ffffffff81fe5cb2>] virtio_transport_send_pkt_info+0x412/0x4c0
>    [<ffffffff81fe6183>] virtio_transport_stream_enqueue+0x43/0x50
>    [<ffffffff81fe0813>] vsock_connectible_sendmsg+0x373/0x450
>    [<ffffffff81d233d5>] ____sys_sendmsg+0x365/0x3a0
>    [<ffffffff81d246f4>] ___sys_sendmsg+0x84/0xd0
>    [<ffffffff81d26f47>] __sys_sendmsg+0x47/0x80
>    [<ffffffff820d3df3>] do_syscall_64+0x93/0x180
>    [<ffffffff8220012b>] entry_SYSCALL_64_after_hwframe+0x76/0x7e
>
>Fixes: 581512a6dc93 ("vsock/virtio: MSG_ZEROCOPY flag support")
>Signed-off-by: Michal Luczaj <mhal@rbox.co>
>---
> net/vmw_vsock/af_vsock.c | 3 +++
> 1 file changed, 3 insertions(+)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 35681adedd9aaec3565495158f5342b8aa76c9bc..dfd29160fe11c4675f872c1ee123d65b2da0dae6 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -836,6 +836,9 @@ static void vsock_sk_destruct(struct sock *sk)
> {
> 	struct vsock_sock *vsk = vsock_sk(sk);
>
>+	/* Flush MSG_ZEROCOPY leftovers. */
>+	__skb_queue_purge(&sk->sk_error_queue);
>+
> 	vsock_deassign_transport(vsk);
>
> 	/* When clearing these addresses, there's no need to set the family and
>
>-- 
>2.46.2
>

