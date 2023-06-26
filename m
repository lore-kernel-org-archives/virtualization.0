Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC3AEB64DC
	for <virtualization@archiver.kernel.org>; Mon, 26 Jun 2023 16:11:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD45640949;
	Mon, 26 Jun 2023 16:11:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BD45640949
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X0fkjx5S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Eza8vFYcZaM0; Mon, 26 Jun 2023 16:11:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 076E5408B3;
	Mon, 26 Jun 2023 16:11:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 076E5408B3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E047CC007A;
	Mon, 26 Jun 2023 16:11:15 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F9B9C0029
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:11:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 69D3840493
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:11:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 69D3840493
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=X0fkjx5S
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HfAb4YGDa0td
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:11:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AC995400EC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AC995400EC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 16:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687795867;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vSj67Bysge00sGJTpLw1MntXa5IUhJN9aBkXlNz5ucg=;
 b=X0fkjx5SjS4H5iKEuW4Bk+L8PFq2N6fsAdo0rU6Zc9edPKO9eJYsG6dSSy1HJV6NHRfO+M
 I7judHsG4spuoTKw4HpXCkEKk0k6lVjHWdgFNDslTnxWrag3ffVDbsKpEcBpup9KhtCXnW
 PLiVPRuDWlvtPb9f7n+BjHRQmE7kl8U=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-663-3F-n8LwBNX-qE2_MtMIlUg-1; Mon, 26 Jun 2023 12:11:06 -0400
X-MC-Unique: 3F-n8LwBNX-qE2_MtMIlUg-1
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-76531f671c0so319183885a.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jun 2023 09:11:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687795862; x=1690387862;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vSj67Bysge00sGJTpLw1MntXa5IUhJN9aBkXlNz5ucg=;
 b=eK0DzxAG9/6FtHVAfNWkYIt7umhYEIlF7B/Z8SChb/MjumRCHWs30Gj+HYR3ktST1v
 PxRXHlXkt3s17Cks9f5gUM7sqS6v/6dgURA4SMwSQMvhXIEgTTavYqDDALqdXPil8pXd
 GCM59pxAJnXfEpuo9xgoYFQoGCG67SfihhSLPWgp1EKE+n/6vois/mO0EyYzobKsWp2i
 POCrAEHF5vbBVh0DvGaDZcCV3L7IoMSRjh4bXTUYZ3J4m1I+u2ScXbWWF+vrb2kTnzb5
 e+0Ez9H0FTo8ClDSbrL+FF4y+7OwkquN1TcGQJ3LDFCsKVNPPOjOBzde6pGVt8OZGPEv
 5Xsg==
X-Gm-Message-State: AC+VfDx13Hh950tMstahML5YRn1iPj8uiWXE6NJ/7pIlaiP3qjDVe0Zd
 TsZHfU/zpZB6gKWQPdHCdHIJo+eJ2Yiz65dQ5KNx6cjIhBiTR7x67dVM/eDmhYWxFJfHZNDzy5K
 4wtvDb5tr8hUZ0ygGOOl2IfN6g7e82Yhng0qXItBFfQ==
X-Received: by 2002:a05:620a:4542:b0:75b:23a1:830c with SMTP id
 u2-20020a05620a454200b0075b23a1830cmr40000800qkp.7.1687795862091; 
 Mon, 26 Jun 2023 09:11:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5AAJeVZO0AaDvZksfxGubjZjegdRtILGSI73Wjq9DgEqaoTB4CbROal09UCjmsMp7T1Z9vfA==
X-Received: by 2002:a05:620a:4542:b0:75b:23a1:830c with SMTP id
 u2-20020a05620a454200b0075b23a1830cmr40000771qkp.7.1687795861845; 
 Mon, 26 Jun 2023 09:11:01 -0700 (PDT)
Received: from sgarzare-redhat (host-87-11-6-160.retail.telecomitalia.it.
 [87.11.6.160]) by smtp.gmail.com with ESMTPSA id
 c25-20020a05620a11b900b007607324644asm2806347qkk.118.2023.06.26.09.10.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Jun 2023 09:11:01 -0700 (PDT)
Date: Mon, 26 Jun 2023 18:10:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v4 10/17] vhost/vsock: support MSG_ZEROCOPY for
 transport
Message-ID: <cqlp2jr7laleku3reiqf64swlieso6rvi47u5cnlu24kfn3fnm@3x45ihmjox77>
References: <20230603204939.1598818-1-AVKrasnov@sberdevices.ru>
 <20230603204939.1598818-11-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230603204939.1598818-11-AVKrasnov@sberdevices.ru>
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

On Sat, Jun 03, 2023 at 11:49:32PM +0300, Arseniy Krasnov wrote:
>Add 'msgzerocopy_allow()' callback for vhost transport.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> drivers/vhost/vsock.c | 6 ++++++
> 1 file changed, 6 insertions(+)
>
>diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
>index b254aa4b756a..318866713ef7 100644
>--- a/drivers/vhost/vsock.c
>+++ b/drivers/vhost/vsock.c
>@@ -396,6 +396,11 @@ static bool vhost_vsock_more_replies(struct vhost_vsock *vsock)
> 	return val < vq->num;
> }
>
>+static bool vhost_transport_msgzerocopy_allow(void)
>+{
>+	return true;
>+}
>+
> static bool vhost_transport_seqpacket_allow(u32 remote_cid);
>
> static struct virtio_transport vhost_transport = {
>@@ -442,6 +447,7 @@ static struct virtio_transport vhost_transport = {
> 		.notify_buffer_size       = virtio_transport_notify_buffer_size,
>
> 		.read_skb = virtio_transport_read_skb,
>+		.msgzerocopy_allow        = vhost_transport_msgzerocopy_allow,

Can we move this after .seqpacket section?

> 	},
>
> 	.send_pkt = vhost_transport_send_pkt,
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
