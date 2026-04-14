Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C1F13EDAB3
	for <virtualization@lists.linux.dev>; Tue, 14 Apr 2026 16:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776183037; cv=none; b=AE2562x7882XYPm2CgxPYP6PhScvgO2KR221GagQbmXg4d7Fun0PvLdUpIdrM0y6SHLPyDN1pnLLA11B9ey/RQ5ugsCx0CwFdDvzsw8yEIR+715fzsJIjoJSyUX+2zRyQe+jAp0GpGTBqvsEhlRVLcrhEKJShkWo0o1wc0yksCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776183037; c=relaxed/simple;
	bh=8KxSLwY587LR57aGsCLpqgDw1kJidOt4vFYe6TGecyU=;
	h=From:Date:Subject:MIME-Version:Message-Id:References:In-Reply-To:
	 To:Cc:Content-Type; b=cTxcdTJ0nsEVnmxJQvW6z+PSjk4O00dNraiEKp+qW3sWM2Jp73UwByE0xjqBTfP5ZnhiRDbeutVlSGCq7E7O1KLsm+UoJ6gNYYPo7JoifHF03kY3tfKjYwdhoeY85YqqLPvMlCFZ3Ch9DSQnKD8FJdA6sORCWLQB5KLZS1LiUJQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=GDjfZIYA; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GDjfZIYA"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776183035;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GGbKEVk7Q+3WFRVihAcafbqDB4/UKYyFXHFteVNPtTg=;
	b=GDjfZIYA1tSLf+yzFzmlSCBCDjD+RtxKs3VDjwjRbQbvPRSO05/t4BRtjTfrU4CcQCvxNa
	QhCfD2W8kKaa2Tno+kl8uvCTilCBRYO1RDFxBPzRU4HEfi3xFbYUyLM/0wlJri484rf/3Q
	OYw/U+UFJqQop4ruswzkNpTpQleg+Qc=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-672--Xby6dkrNIu3jsviwjFopA-1; Tue, 14 Apr 2026 12:10:28 -0400
X-MC-Unique: -Xby6dkrNIu3jsviwjFopA-1
X-Mimecast-MFC-AGG-ID: -Xby6dkrNIu3jsviwjFopA_1776183027
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-4362197d1easo4059502f8f.2
        for <virtualization@lists.linux.dev>; Tue, 14 Apr 2026 09:10:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776183026; x=1776787826;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GGbKEVk7Q+3WFRVihAcafbqDB4/UKYyFXHFteVNPtTg=;
        b=jqBVlC7Ly7YgyB0Ud7G/NpLNBzVkT61h71IpVpCRbg4JX3I5LozSrTRos1x5HuE59j
         Tl8wiYrM8NY5bozIQ77M8wMYWRzsxnJX1MLRoLRju8ZmfikBJ2CRGDwpW2uwY9DQQLMS
         F+VwNjMrVjTci1SOJK5ltlZzwzkQPN5nd7NTfAiOVCSnlp1O/QCgC+CrUvPha0jDO799
         YI+zVbDLVacDhF46VThRopXw5mYl4reVIUmlkrNnD6ER8bkYxktB5tnjbyBAEH+dRgfN
         l1dJxZpHLZE/dYOtBnjp0aETuP8rb9vAV0ZQXwmgS9KFp3ccfjf4uegr88bUOADpu2vG
         adag==
X-Forwarded-Encrypted: i=1; AFNElJ9aXTmrn0s6Qp/XAnyzpshB6vp9wOhy4n1wrTpTYy+NuApyoiK9zHI13BGIo1QtWsE9JbA9TPMW7i2hGmrjTA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzzvlDDuudXiAPbciuL2u/DnRjuNiMcSTdsUFBXXFI4S+ZxIzCv
	8L4e+DRW9lkQTIG9R3SrhaTPkRo5YgrhXAiG8atYJIBZkqzf2CykYR87D5MGyTfGjJ206T5I7MQ
	ZC/ptw+miI+PMCAZOo0DPuGLh/gLUsA5KH9eZFRimxg4rFLQfH4Za+d3+klhsbPgmGuKOAjalLL
	iC
X-Gm-Gg: AeBDietnHWTI8b5zViWsSapXfrCv4Ghk35tM8+8Xvfma+zuQQYgnMgQOcWIQ3ff3cNB
	Zzm0Qkyyrq6rje0yLqj3WlgeT0qCjiMOo0l41r50GmEH3SXs76jWEYKS1yeXk+M3FbGo/WjA+fn
	ikLkCsnWt9jYF3czMjKVJUIIzsp4OVyrYhwRJhaZB+8/8WWHUXn4KgpVV5J2SGxfvqIVJhexHfm
	iONp5yyQoC49QLjSASH5NYXzqLI9r7AjTFeofF068IbGnufvneG8lQ8qbxOrIlKugdmsnlkmJBH
	Riq74mqqJ0l3e7UYjYkc5XlWlFaQhahOclUW72mZb8BUrFIhx2gKTrR7q5f06qH/vouCtmyQyl1
	+wD/LD0FUcseZS+YcAqDDuCAfZcmCyBserQRxj1lgDbbZ8RJC5yDG8rKGQCZX
X-Received: by 2002:a05:6000:4284:b0:43d:762e:76ba with SMTP id ffacd0b85a97d-43d762e777dmr15595045f8f.17.1776183026391;
        Tue, 14 Apr 2026 09:10:26 -0700 (PDT)
X-Received: by 2002:a05:6000:4284:b0:43d:762e:76ba with SMTP id ffacd0b85a97d-43d762e777dmr15594975f8f.17.1776183025862;
        Tue, 14 Apr 2026 09:10:25 -0700 (PDT)
Received: from lleonard-thinkpadx1carbongen13.rmtit.csb ([176.206.19.176])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec090sm43035268f8f.12.2026.04.14.09.10.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Apr 2026 09:10:25 -0700 (PDT)
From: Luigi Leonardi <leonardi@redhat.com>
Date: Tue, 14 Apr 2026 18:10:21 +0200
Subject: [PATCH net v3 1/3] vsock/virtio: fix MSG_PEEK ignoring skb offset
 when calculating bytes to copy
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Message-Id: <20260414-fix_peek-v3-1-e7daead49f83@redhat.com>
References: <20260414-fix_peek-v3-0-e7daead49f83@redhat.com>
In-Reply-To: <20260414-fix_peek-v3-0-e7daead49f83@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>, 
 Stefano Garzarella <sgarzare@redhat.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Simon Horman <horms@kernel.org>, 
 Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux.dev, 
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Luigi Leonardi <leonardi@redhat.com>
X-Mailer: b4 0.14.3
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Vt2_iKd4jwt7msw60W2FkH1eJY3aJXJxNqVr1MfiPEw_1776183027
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit

`virtio_transport_stream_do_peek()` does not account for the skb offset
when computing the number of bytes to copy.

This means that, after a partial recv() that advances the offset, a peek
requesting more bytes than are available in the sk_buff causes
`skb_copy_datagram_iter()` to go past the valid payload, resulting in
a -EFAULT.

The dequeue path already handles this correctly.
Apply the same logic to the peek path.

Fixes: 0df7cd3c13e4 ("vsock/virtio/vhost: read data from non-linear skb")
Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>
Acked-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
Signed-off-by: Luigi Leonardi <leonardi@redhat.com>
---
 net/vmw_vsock/virtio_transport_common.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
index a152a9e208d0..b5015ab2ee1e 100644
--- a/net/vmw_vsock/virtio_transport_common.c
+++ b/net/vmw_vsock/virtio_transport_common.c
@@ -545,9 +545,8 @@ virtio_transport_stream_do_peek(struct vsock_sock *vsk,
 	skb_queue_walk(&vvs->rx_queue, skb) {
 		size_t bytes;
 
-		bytes = len - total;
-		if (bytes > skb->len)
-			bytes = skb->len;
+		bytes = min_t(size_t, len - total,
+			      skb->len - VIRTIO_VSOCK_SKB_CB(skb)->offset);
 
 		spin_unlock_bh(&vvs->rx_lock);
 

-- 
2.53.0

