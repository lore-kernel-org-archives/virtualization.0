Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53D9036C592
	for <virtualization@lists.linux-foundation.org>; Tue, 16 Jun 2026 13:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781615435; cv=none; b=o480UtgMeyjG3Z1i+TqD7lF3gHuuHTc94Um2miBo+A0lqiBsrm/3ImVjZXdlC4zUDj4+lG1saWjdtEcb6jUeGlfaqLvvGK8Qds6YTJed0FPyJsHJnfz9V4WuS2KJ/dL48LSzZ/qoTUp62AKwVg4h1ZyzXIm7fVKscAWkwx17V1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781615435; c=relaxed/simple;
	bh=j8djdhTpE9KyreEqk3wMsIFtENli4AKg3GaItI1dKoQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=V439JLSONCAcYbTdnn2wOP+OJToVdYn+GrbA+MKgCfXZe61KEtYya2uvm2EevgMFH8aw0JgMgNYkahKXfvgYlX9RkYEN4GXAx1M3ZUQT+Rdc6NHEVsAShEO6Ovku/O16XhkmWrMEdojUmoGo1u77ky3Iueg1UD9kCTnP4d9ARs4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=g6P2MBjx; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="g6P2MBjx"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C73656F50F
	for <virtualization@lists.linux-foundation.org>; Tue, 16 Jun 2026 13:10:22 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.792
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id u7hqTyR6uyBq for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Jun 2026 13:10:19 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 4C7F96F4DE
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4C7F96F4DE
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=g6P2MBjx
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4C7F96F4DE
	for <virtualization@lists.linux-foundation.org>; Tue, 16 Jun 2026 13:10:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1781615417;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=81JkjnjNjtM/PGFVX6BX0wxD8D777cX7VAjC2y6ng/8=;
	b=g6P2MBjxJgiBerbF6ygNpPkSn9b74qHJC0plFVZPXoUklZiDV+nlQqK++X1tSWC75ysiXe
	kuxLzX8idFePzNr+1Iptp7A9exlE/tD6XVajkzLWejyz6FkC8HgDwFQwgd/E8DaMC1CnPN
	4TwBoygYj2y49uKFOoEh9Aiaat+ByGU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-1-A4D3cVKyP5W6L2oTbZ1k8w-1; Tue, 16 Jun 2026 09:10:15 -0400
X-MC-Unique: A4D3cVKyP5W6L2oTbZ1k8w-1
X-Mimecast-MFC-AGG-ID: A4D3cVKyP5W6L2oTbZ1k8w_1781615415
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-45ef616db45so3550462f8f.2
        for <virtualization@lists.linux-foundation.org>; Tue, 16 Jun 2026 06:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781615414; x=1782220214;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=81JkjnjNjtM/PGFVX6BX0wxD8D777cX7VAjC2y6ng/8=;
        b=l6Ir5zQipcEmCjYQBd6YWhBpPFAgdyyaVfjlVuSrE5kd1x4Hmut5DK6nXS1otsqy2+
         +6XyypXo/t+clT4kuGTcy/oOUUsngDPLQfCv5tMlZVmw6bTJ9WwixblrCspY7ndA34w+
         E4mDCoLuKkYI5fYHtbkj0MqnFp/p5ZeJ5kD5eJS9dfPpZjYrpFvySvoQ0mTap0pVIZCb
         EUVZfaex4yb6n4Ab6Tb1EMggMWKHav1fPC//VkXk536jAckeXzFAkdQnUtmioqJeSSyu
         Muc7OsNg+xoNsDrBwrQBCHLrJg3IKPOPcYBgANREAd0VSzUxz2beqx25tPSfrlNXSn0j
         V6yA==
X-Forwarded-Encrypted: i=1; AFNElJ81lrRtUUiddDUNNE9+tBMe3DO2hPGZiT2jlrId9gZDAn/CSA2b7ibLE+oeSG34hJXWZQ4E+MqH4e4HffFjmw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0Ywev7MxqjFzDXVdtvwMc7oa5BK2LDfVRNgYRq6IMZPrO7G2CuNx
	bbFRj71ydzJvSUwdEZZ4bICM3/8H2tLeRzSJcungE+P649M4jhmaWjqlVFCBUB9doGkrUGVxDa7
	b+Ujg03sapjiVM/ZtI3vROUlT2lluudt5XMDuErw7AEb8guVGkd26D3JKvVHgGd550os4BP2B2v
	LVihJkk9U=
X-Gm-Gg: Acq92OHQOmXqpAvC6tk0lH9yeLoJlo36mIQGGaX9kqTvVHoTy329z30MlKSybuNgzcp
	3pfKyqId8GftGrEd0h95jgFs7zU9AgcWrkJvso3KYHuUBjppiG+OXy0DzQrC+Uhk7bfo6PfSi26
	CF1IsBPSswWMYXSFUUmhfPtzxDzi6Dn9CHDKW+aodOTq7QEkbzqxjEAhLho48fknrTAx1OdTmSu
	W4lSU4rQjVEIYTnKRLBxsPenqSAB39WZVoj9TQZed1+w0z7GNKkxTaB+yZfefCoshDWwMomUDLG
	sDem4elnyrUftfY7ax8s/KZ4oqJyqLFuPwcu5d26RTPIYVNDQPsUF7+/aWTjuTSvbrmitT7dCbG
	lKwHA/pP3WQRHcRFQ2iK1hjgrafAXnj74BYkxwNg6naaLmL07CfPGho3kkuKega9Iukc8nwA=
X-Received: by 2002:a5d:5d87:0:b0:45e:da9b:97d6 with SMTP id ffacd0b85a97d-46074a8a2a8mr23974042f8f.27.1781615414594;
        Tue, 16 Jun 2026 06:10:14 -0700 (PDT)
X-Received: by 2002:a5d:5d87:0:b0:45e:da9b:97d6 with SMTP id ffacd0b85a97d-46074a8a2a8mr23973939f8f.27.1781615413909;
        Tue, 16 Jun 2026 06:10:13 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-135-12.retail.telecomitalia.it. [82.53.135.12])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4606f2cf5d9sm39082850f8f.32.2026.06.16.06.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2026 06:10:13 -0700 (PDT)
Date: Tue, 16 Jun 2026 15:09:59 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@rulkc.org>
Cc: Stefan Hajnoczi <stefanha@redhat.com>, 
	"David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	"Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
	Bobby Eshleman <bobby.eshleman@bytedance.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
	Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, Simon Horman <horms@kernel.org>, kvm@vger.kernel.org, 
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, 
	oxffffaa@gmail.com, rulkc@linuxtesting.org
Subject: Re: [PATCH v2] vsock/virtio: rework MSG_ZEROCOPY flag handling
Message-ID: <ajFFOJSdqpNWgohB@sgarzare-redhat>
References: <20260614174756.170631-1-avkrasnov@rulkc.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20260614174756.170631-1-avkrasnov@rulkc.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 93TH5UZviKuFpiQa_sSFVKqLSEdk3h-kkGhYGKEVD8I_1781615415
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Sun, Jun 14, 2026 at 08:47:56PM +0300, Arseniy Krasnov wrote:
>Logically it was based on TCP implementation, so make further support
>easier, rewrite it in the TCP way.

Hi Arseniy, and thank you so much for the patch!

I’d like to ask you to expand on the message a bit, especially to 
explain why we’re making this change.

In particular, I’d like to better understand whether this is just a 
cosmetic change or if we’re fixing any issues (and if so, which ones), 
so we can determine whether this patch should be backported to the 
stable branches.

>
>Signed-off-by: Arseniy Krasnov <avkrasnov@rulkc.org>
>---
> Changelog v1->v2:
> * Rebase on last 'net-next'. Don't need 'skb_zcopy_set()' now - it was
>   already added.

Ah, okay is net-next material, please use the net-next tag (ie. [PATCH 
net-next v2]).

>
> net/vmw_vsock/virtio_transport_common.c | 48 ++++++++++++-------------
> 1 file changed, 23 insertions(+), 25 deletions(-)
>
>diff --git a/net/vmw_vsock/virtio_transport_common.c b/net/vmw_vsock/virtio_transport_common.c
>index 09475007165b..787524b8cb44 100644
>--- a/net/vmw_vsock/virtio_transport_common.c
>+++ b/net/vmw_vsock/virtio_transport_common.c
>@@ -328,38 +328,36 @@ static int virtio_transport_send_pkt_info(struct vsock_sock *vsk,
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
>

nit: we can remove this extra blank line.

For the rest I can't see anything wrong, but a bit more context in the 
commit would help me in the review.

Thanks,
Stefano

