Return-Path: <SRS0=NA0D=IN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFD3BC433DB
	for <virtualization@archiver.kernel.org>; Mon, 15 Mar 2021 11:29:38 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5D4CF64E61
	for <virtualization@archiver.kernel.org>; Mon, 15 Mar 2021 11:29:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5D4CF64E61
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 19AAE430DD;
	Mon, 15 Mar 2021 11:29:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A7V5cyCESFDz; Mon, 15 Mar 2021 11:29:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id B4A1B430CE;
	Mon, 15 Mar 2021 11:29:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DE66C000A;
	Mon, 15 Mar 2021 11:29:36 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 038E0C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 11:29:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D9516835D9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 11:29:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F23DoXyZBvrw
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 11:29:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2693F835CF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 11:29:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615807773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=1+7AUzrzm8HAwAnNkO+PDguvC47LB5o6Xz8fUn4oHzc=;
 b=cAVkKJghkyTwlNk4NqOLqTmWgkmXUrZnNWhVNe1TvNtp0pdjg7AN5GxKcEAIqyehLTLSHE
 xPrX+s9EVgOqnXdNQ33ogp7sBk1ymMfsTiGRP+A8TkRYo0F+91JfEFYuOm0nds3MLt8MZv
 p4B33M4LdYNvQuZ3sLESc2ZbbXzClCw=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-587-XRxiokXIM8ai9nVR7yA-aA-1; Mon, 15 Mar 2021 07:29:31 -0400
X-MC-Unique: XRxiokXIM8ai9nVR7yA-aA-1
Received: by mail-wm1-f69.google.com with SMTP id s192so8056862wme.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Mar 2021 04:29:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=1+7AUzrzm8HAwAnNkO+PDguvC47LB5o6Xz8fUn4oHzc=;
 b=kGK3OpKVJdRxJhSjQwypYyE8cI3HOGtCG9EUnkJUWR7UI6qp0Jhws/tjq3DOcDat7g
 +PYPEKQl103pY2eOiKYz36rShupoOZOKs0Je8gRvoupH8XdHu3UBXgXoQX777QjOLlO8
 OZAlg32B2VAtVZDrlhFVnK6jGRzl8Vlh99ewpkMWRv07cpBaq0LjhTKVDSZdbI2M3q2G
 EXXxiXqOVGkoLSEZavRuU9XLDuKTtdKji6JYaisKC7Nm2Y2FickPBF4e8zPGH+WPdUhJ
 6VDuXTv757ipE++RnlEctCtqAsVyDCkbSrSZGzreKhA7EV1YUU0wKXJvZICy8Kq54wGt
 lSnw==
X-Gm-Message-State: AOAM530nMQ+XZADwvxgpydDifOB8NCQx8AjKubWumqQFIHbwWze6iULP
 vCIXz/V44UBbU7ikUuBgHEN8Lvjx0u27BSFDEXGrO7V+BJLrFT9OrJsRabEzNppA9r1n7zaL7Ct
 bIo3wAMUXOoKGsnXoiOIdUaRyC+bycmNr7brgRSUyGg==
X-Received: by 2002:a5d:4d0f:: with SMTP id z15mr27172921wrt.192.1615807770754; 
 Mon, 15 Mar 2021 04:29:30 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPaa1RsYizJWQVGBx3qj8UyDGlrRh47JNGjq0sqiNSmbivdESKClpUjnV47KEmVgApFQQIBA==
X-Received: by 2002:a5d:4d0f:: with SMTP id z15mr27172900wrt.192.1615807770597; 
 Mon, 15 Mar 2021 04:29:30 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id s16sm18201253wru.91.2021.03.15.04.29.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Mar 2021 04:29:30 -0700 (PDT)
Date: Mon, 15 Mar 2021 12:29:27 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v6 17/22] virtio/vsock: SEQPACKET feature bit support
Message-ID: <20210315112927.4aygxeby2f7p3mju@steredhat>
References: <20210307175722.3464068-1-arseny.krasnov@kaspersky.com>
 <20210307180404.3466602-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210307180404.3466602-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, stsp2@yandex.ru,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 oxffffaa@gmail.com, Norbert Slusarek <nslusarek@gmx.net>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>
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

On Sun, Mar 07, 2021 at 09:04:01PM +0300, Arseny Krasnov wrote:
>This adds handling of SEQPACKET bit: guest tries to negotiate it
>with vhost.
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/virtio_transport.c | 5 +++++
> 1 file changed, 5 insertions(+)

Also for this patch I think is better to move after we set the 
seqpackets ops.

>
>diff --git a/net/vmw_vsock/virtio_transport.c b/net/vmw_vsock/virtio_transport.c
>index 2700a63ab095..41c5d0a31e08 100644
>--- a/net/vmw_vsock/virtio_transport.c
>+++ b/net/vmw_vsock/virtio_transport.c
>@@ -612,6 +612,10 @@ static int virtio_vsock_probe(struct virtio_device *vdev)
> 	rcu_assign_pointer(the_virtio_vsock, vsock);
>
> 	mutex_unlock(&the_virtio_vsock_mutex);
>+
>+	if (vdev->features & (1ULL << VIRTIO_VSOCK_F_SEQPACKET))
>+		virtio_transport.seqpacket_allow = true;
>+
> 	return 0;
>
> out:
>@@ -695,6 +699,7 @@ static struct virtio_device_id id_table[] = {
> };
>
> static unsigned int features[] = {
>+	VIRTIO_VSOCK_F_SEQPACKET
> };
>
> static struct virtio_driver virtio_vsock_driver = {
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
