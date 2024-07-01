Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2334F16D320
	for <virtualization@lists.linux-foundation.org>; Mon,  1 Jul 2024 15:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719847958; cv=none; b=kgkltdk01HZ5wN/zK7+dipXuJf0VKWAVmDc6ja65mgShrol2QMZBCNkH3xbor29PQir9Wm7mj5KGExWfUCz/9VFL5KHesViNVlpYDjcLFciqsaS1LYHFugrm3zdEiUZIRJUCVlPz4nyp30Oe0b4cirnvqG+ch3SvayF6ipRoMbU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719847958; c=relaxed/simple;
	bh=zi+8fbwcptjmw/P2wZ5lSDZ3iDkRd/wjaUHGZ/OL5lI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=dphuSFYYh/kO6lurq4jbEab0alSol2bN3iLzHdnI0sKtrbhFlLtsb4M90+S7CVJLB929PQnDtui0HFoVRbk3aw3p/sNDfLiu5Ba296foq/fYSIWO4dDdUFG/YYnyz2P8DfjoUFrPTuH+8q7rRCRkmteDP943gGJyHvXrOjrAtnY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VeH9fuSF; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VeH9fuSF"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id BEF1960A59
	for <virtualization@lists.linux-foundation.org>; Mon,  1 Jul 2024 15:32:36 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id lfmHNBGQ6L7F for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Jul 2024 15:32:35 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 966EA605A2
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 966EA605A2
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VeH9fuSF
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 966EA605A2
	for <virtualization@lists.linux-foundation.org>; Mon,  1 Jul 2024 15:32:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1719847954;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OGj93uGkH1pdIY4bLcgMBtJuKm0uxksm0StLnbxqKDU=;
	b=VeH9fuSFlAT7GJ4rJl3ucb/MCixS8qq3dnlICghAA2yc+lr6v8apyYe2le65OocRN1b/0e
	hU7WDfU+GRDZoaza738VG20LO5M+lg83ma8i3RDbhHG0xZiB2uBinoabx3hVdC1bjSoeZk
	HhkjausfdC8nqIZJbGhyLuVA2otxiLY=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-Mg_dgDjyPziRf9rssCCWLg-1; Mon, 01 Jul 2024 11:32:32 -0400
X-MC-Unique: Mg_dgDjyPziRf9rssCCWLg-1
Received: by mail-qv1-f71.google.com with SMTP id 6a1803df08f44-6b56000666dso50865646d6.1
        for <virtualization@lists.linux-foundation.org>; Mon, 01 Jul 2024 08:32:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719847952; x=1720452752;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=OGj93uGkH1pdIY4bLcgMBtJuKm0uxksm0StLnbxqKDU=;
        b=N/w741QbvNDrRQLXbdtwm+XTdn3MbD/3M+wR+mVdsGLvrykvZWyzVZ2Mh/wSYHX6dI
         AgkaKUvHQs28LIJ+2JU605gEWK4/AzcLJKL6wz39k+U6r9wemNwR7wtv0HertxxCB709
         GtXVEU/gaskikBGFfYOisbVMObCHYq9XlrgG4xxICpa6yKB90HTvJjWJJpwJdbkEa1IB
         N8NFvgsxYyNh47Ea2wjdtnKvxprh3vJaXNf8ub/JIFSgC5wniKHKDuNSmklk0HNtwo2W
         cnG99JBmWqm+mRK5bXxqo5D6MDG8G4giNGrHYaX1FCxnmD0/Ms5tOCtZsMHr6C71To9F
         3GFQ==
X-Forwarded-Encrypted: i=1; AJvYcCUwL9mFFUfKPeM+doIY6g9NNRqr7q15rS/lc7dX5GogiFU7hZ0FIXL50jo1IxeGaDMlGk/WWuB2bOIJZjD1q6h7wwALa8cEop29M7UsycN4VrPWuZ4oWeQHRw==
X-Gm-Message-State: AOJu0Yw3zpj5+KwMESUTxvM5ipioT8/C0C8GhGRLHJ7R4MkXkQGJhNKJ
	3lJB18lc9UYBBC3FZ2N1OZbQmf4MUEc5PiK5DoWB8hTclYBWNWs1oHSUOwhdrRD+pqy6deNpG01
	KevVBbzW7yM9pUNdJe2oXYxcRGn4rYMiAO+Jqyj27INPErlMRAUdvGQ+GD65tVzFyWw7w8EhKbO
	lwNIo=
X-Received: by 2002:a05:6214:248e:b0:6af:2344:5811 with SMTP id 6a1803df08f44-6b5b71b6e5fmr96492566d6.55.1719847952325;
        Mon, 01 Jul 2024 08:32:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEqlm/0WDwpS5KeYlMAis8uyUKkkCDY9gfKmx9JQ3uzDgIThn0Pe6YuT5CFCsxpsqgIj8oqrg==
X-Received: by 2002:a05:6214:248e:b0:6af:2344:5811 with SMTP id 6a1803df08f44-6b5b71b6e5fmr96492046d6.55.1719847951861;
        Mon, 01 Jul 2024 08:32:31 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.163.0])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-6b59e563aefsm34189636d6.38.2024.07.01.08.32.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jul 2024 08:32:31 -0700 (PDT)
Date: Mon, 1 Jul 2024 17:32:22 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org, 
	netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kernel@sberdevices.ru, 
	oxffffaa@gmail.com
Subject: Re: [RFC PATCH v1 1/2] virtio/vsock: rework deferred credit update
 logic
Message-ID: <ua7aoa6yapzzitbg77taspl7h34mmp32lrn6zmr7m6w6xfwk26@w6hheulzftw6>
References: <20240621192541.2082657-1-avkrasnov@salutedevices.com>
 <20240621192541.2082657-2-avkrasnov@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240621192541.2082657-2-avkrasnov@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Arseniy,

On Fri, Jun 21, 2024 at 10:25:40PM GMT, Arseniy Krasnov wrote:
>Previous calculation of 'free_space' was wrong (but worked as expected
>in most cases, see below), because it didn't account number of bytes in
>rx queue. Let's rework 'free_space' calculation in the following way:
>as this value is considered free space at rx side from tx point of 
>view,
>it must be equal to return value of 'virtio_transport_get_credit()' at
>tx side. This function uses 'tx_cnt' counter and 'peer_fwd_cnt': first
>is number of transmitted bytes (without wrap), second is last 'fwd_cnt'
>value received from rx. So let's use same approach at rx side during
>'free_space' calculation: add 'rx_cnt' counter which is number of
>received bytes (also without wrap) and subtract 'last_fwd_cnt' from it.
>Now we have:
>1) 'rx_cnt' == 'tx_cnt' at both sides.
>2) 'last_fwd_cnt' == 'peer_fwd_cnt' - because first is last 'fwd_cnt'
>   sent to tx, while second is last 'fwd_cnt' received from rx.
>
>Now 'free_space' is handled correctly and also we don't need
>'low_rx_bytes' flag - this was more like a hack.
>
>Previous calculation of 'free_space' worked (in 99% cases), because if
>we take a look on behaviour of both expressions (new and previous):
>
>'(rx_cnt - last_fwd_cnt)' and '(fwd_cnt - last_fwd_cnt)'
>
>Both of them always grows up, with almost same "speed": only difference
>is that 'rx_cnt' is incremented earlier during packet is received,
>while 'fwd_cnt' in incremented when packet is read by user. So if 
>'rx_cnt'
>grows "faster", then resulting 'free_space' become smaller also, so we
>send credit updates a little bit more, but:
>
>  * 'free_space' calculation based on 'rx_cnt' gives the same value,
>    which tx sees as free space at rx side, so original idea of
>    'free_space' is now implemented as planned.
>  * Hack with 'low_rx_bytes' now is not needed.
>
>Also here is some performance comparison between both versions of
>'free_space' calculation:
>
> *------*----------*----------*
> |      | 'rx_cnt' | previous |
> *------*----------*----------*
> |H -> G|   8.42   |   7.82   |
> *------*----------*----------*
> |G -> H|   11.6   |   12.1   |
> *------*----------*----------*

I did some tests on an Intel(R) Xeon(R) Silver 4410Y using iperf-vsock:
- kernel 6.9.0
pkt_size     G->H     H->G
4k            4.6      6.4
64k          13.8     11.5
128k         13.4     11.7

- kernel 6.9.0 with this series applied
pkt_size     G->H     H->G
4k            4.6     8.16
64k          12.2     8.9
128k         12.8     8.8

I see a big drop, especially on H->G with big packets. Can you try to 
replicate on your env?

I'll try to understand more and also an i7 on the next days.

Thanks,
Stefano

>
>As benchmark 'vsock-iperf' with default arguments was used. There is no
>significant performance difference before and after this patch.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> include/linux/virtio_vsock.h            | 1 +
> net/vmw_vsock/virtio_transport_common.c | 8 +++-----
> 2 files changed, 4 insertions(+), 5 deletions(-)
>
>diff --git a/include/linux/virtio_vsock.h b/include/linux/virtio_vsock.h
>index c82089dee0c8..3579491c411e 100644
>--- a/include/linux/virtio_vsock.h
>+++ b/include/linux/virtio_vsock.h
>@@ -135,6 +135,7 @@ struct virtio_vsock_sock {
> 	u32 peer_buf_alloc;
>
> 	/* Protected by rx_lock */
>+	u32 rx_cnt;
> 	u32 fwd_cnt;
> 	u32 last_fwd_cnt;
> 	u32 rx_bytes;
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 16ff976a86e3..1d4e2328e06e 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -441,6 +441,7 @@ static bool virtio_transport_inc_rx_pkt(struct virtio_vsock_sock *vvs,
> 		return false;
>
> 	vvs->rx_bytes += len;
>+	vvs->rx_cnt += len;
> 	return true;
> }
>
>@@ -558,7 +559,6 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	size_t bytes, total = 0;
> 	struct sk_buff *skb;
> 	u32 fwd_cnt_delta;
>-	bool low_rx_bytes;
> 	int err = -EFAULT;
> 	u32 free_space;
>
>@@ -603,9 +603,7 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	}
>
> 	fwd_cnt_delta = vvs->fwd_cnt - vvs->last_fwd_cnt;
>-	free_space = vvs->buf_alloc - fwd_cnt_delta;
>-	low_rx_bytes = (vvs->rx_bytes <
>-			sock_rcvlowat(sk_vsock(vsk), 0, INT_MAX));
>+	free_space = vvs->buf_alloc - (vvs->rx_cnt - vvs->last_fwd_cnt);
>
> 	spin_unlock_bh(&vvs->rx_lock);
>
>@@ -619,7 +617,7 @@ virtio_transport_stream_do_dequeue(struct vsock_sock *vsk,
> 	 * number of bytes in rx queue is not enough to wake up reader.
> 	 */
> 	if (fwd_cnt_delta &&
>-	    (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE || low_rx_bytes))
>+	    (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE))
> 		virtio_transport_send_credit_update(vsk);
>
> 	return total;
>-- 
>2.25.1
>
>

