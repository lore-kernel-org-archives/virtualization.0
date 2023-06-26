Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DCC8DEB64DA
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 16:14:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 706BD40960;
	Mon, 26 Jun 2023 16:14:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 706BD40960
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=b16c2Rv9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id u2SLmS7-xQQt; Mon, 26 Jun 2023 16:14:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 57BF640948;
	Mon, 26 Jun 2023 16:14:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 57BF640948
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E395C007A;
	Mon, 26 Jun 2023 16:14:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 19D18C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:14:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DCB01400EC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:14:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DCB01400EC
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=b16c2Rv9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f9gyzdyrglHK
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:14:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 30FF8404AF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 30FF8404AF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687796058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lAvdeHjRiEhExMf/8PkhS/lqlgbR8Yp8qV2L+W5RPMM=;
 b=b16c2Rv9kCAdt6Z4iEeBBpCohkilCNuwf9tj0W8B872mhpuZjd35NihhdbsbJURFxQd8Uy
 lFeq0GeTFEupaUpGpDqh76CqVpk05H3lmZcCAWSThctN9leI9Af/cu00sA8inaphKpOX9O
 AphRfmipxuKVA/3qqUgHfg5AHw8pjyA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-91-O0kzjJBgMRWt9R3WXQC_8g-1; Mon, 26 Jun 2023 12:14:17 -0400
X-MC-Unique: O0kzjJBgMRWt9R3WXQC_8g-1
Received: by mail-qv1-f71.google.com with SMTP id
 6a1803df08f44-635e6c83cf0so7026646d6.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 09:14:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687796054; x=1690388054;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lAvdeHjRiEhExMf/8PkhS/lqlgbR8Yp8qV2L+W5RPMM=;
 b=KPWHB7YkzyOM7GLnuQGYesy/wKU+1r0nOutuh15VvbHD18QEZGSUb5ByMADAd7payc
 OFxjdZyZYULgew0jzlxihKJdwAXg4e+BEFfAx94BCQiA6VjB5z90N1yRTEpy7WsqqxYU
 27OPL/U7EPAIllmo2QjOru7IhiTFCyqk0v2q2oh5JdqnyQmNEm8VMuCvkgSBeazjyHL5
 8Q5EBusKXvBWrhiPBzFVLKUL/tWUvdGN6EzunCq7wm1pi2vaQMGdazHogsouY4N+ye/i
 m4nAhkN412ES4qF9ITpM+YgZq9xcBwwaUaIWh0deRKOIm+WCtCxy/qjQcv0qyAz50I4j
 eFfw==
X-Gm-Message-State: AC+VfDx1ufmJM3wWjQjmENxgssW9qKrzEXxFy29p2Qln2VqOWLS9Nk+7
 K6mXoS070VcjC1km6UjuS0QJs/qlr41j7FDjkzCmy7znpSY3g9fomL7ASLfB3/MSVLNrbg3Rtxk
 qWeMxUlVZ+l0Iy2zlRZb5h8Q47TCfS1k6FHvU35jfrg==
X-Received: by 2002:a05:6214:4015:b0:62d:d6e4:7ccf with SMTP id
 kd21-20020a056214401500b0062dd6e47ccfmr31955495qvb.40.1687796054275; 
 Mon, 26 Jun 2023 09:14:14 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6dcXj93WXuU6BFIJYyBOMHVPNnCeqXrPEQR3X/qVTsVAuQorwHM7WjdhifsJqsX7Lt2y/AjA==
X-Received: by 2002:a05:6214:4015:b0:62d:d6e4:7ccf with SMTP id
 kd21-20020a056214401500b0062dd6e47ccfmr31955480qvb.40.1687796054044; 
 Mon, 26 Jun 2023 09:14:14 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it.
 [87.11.6.160]) by smtp.gmail.com with ESMTPSA id
 lw15-20020a05621457cf00b00626161ea7a3sm3349930qvb.2.2023.06.26.09.14.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 09:14:13 -0700 (PDT)
Date: Mon, 26 Jun 2023 18:14:09 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v4 12/17] vsock/loopback: support MSG_ZEROCOPY for
 transport
Message-ID: <lex6l5suez7azhirt22lidndtjomkbagfbpvvi5p7c2t7klzas@4l2qly7at37c>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-13-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230603204939.1598818-13-AVKrasnov@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel@sberdevices.ru,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Sat, Jun 03, 2023 at 11:49:34PM +0300, Arseniy Krasnov wrote:
>Add 'msgzerocopy_allow()' callback for loopback transport.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/vsock_loopback.c | 8 ++++++++
> 1 file changed, 8 insertions(+)
>
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index 5c6360df1f31..a2e4aeda2d92 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -47,6 +47,7 @@ static int vsock_loopback_cancel_pkt(struct vsock_sock *vsk)
> }
>
> static bool vsock_loopback_seqpacket_allow(u32 remote_cid);
>+static bool vsock_loopback_msgzerocopy_allow(void);

I don't know why we did this for `vsock_loopback_seqpacket_allow`, but
can we just put the implementation here?

>
> static struct virtio_transport loopback_transport = {
> 	.transport = {
>@@ -92,11 +93,18 @@ static struct virtio_transport loopback_transport = {
> 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
>
> 		.read_skb = virtio_transport_read_skb,
>+
>+		.msgzerocopy_allow        = vsock_loopback_msgzerocopy_allow,

Ditto the moving.

> 	},
>
> 	.send_pkt = vsock_loopback_send_pkt,
> };
>
>+static bool vsock_loopback_msgzerocopy_allow(void)
>+{
>+	return true;
>+}
>+
> static bool vsock_loopback_seqpacket_allow(u32 remote_cid)
> {
> 	return true;
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
