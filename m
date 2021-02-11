Return-Path: <SRS0=kV/H=HN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67063C433DB
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 14:31:46 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4E6260C3E
	for <virtualization@archiver.kernel.org>; Thu, 11 Feb 2021 14:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4E6260C3E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 8E3C686E91;
	Thu, 11 Feb 2021 14:31:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0upuf9YP9V0Y; Thu, 11 Feb 2021 14:31:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2CA9086E96;
	Thu, 11 Feb 2021 14:31:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 24C4DC0891;
	Thu, 11 Feb 2021 14:31:45 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 11B5BC013A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 14:31:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 00421871F1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 14:31:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4aIdxV160G0z
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 14:31:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2417C87385
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 14:31:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613053901;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=qx1vF4VDTg9ZiVHP56/p9LQUivZBdKHBXUEg2h4ECWE=;
 b=WskLWRG7/P4GFAYlV6HEtjB0VkJPtIIj0q7fRjmSSlF9uWcQniLblflAFqH/i+N8LU1sEf
 ZaER0cJBJiyhlHwnGT0OZYmhc+oTFz5YHJYYzkRI5mmJPjWBU7w6/psaHcmSPrv0VZdR40
 lfqDw5hPk8biWwsYoJzhrpk4PP6D6O8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-MEhrs9k9Ofe5bSDajl1hRQ-1; Thu, 11 Feb 2021 09:31:39 -0500
X-MC-Unique: MEhrs9k9Ofe5bSDajl1hRQ-1
Received: by mail-ed1-f69.google.com with SMTP id i4so4715213edt.11
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Feb 2021 06:31:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=qx1vF4VDTg9ZiVHP56/p9LQUivZBdKHBXUEg2h4ECWE=;
 b=XlIVhrrBfTOowdJ1K3c4jGLmmV5R969W6U9zfHjmwq2S0Kv5hjRWr7SRRzJ0qWUDxv
 o0kYPtCH02TzL+XT22Uh+t7Qnvcg417K2dFAHpfc7B3vTIqZCeHLj2NGYcs9zL+9Bjfh
 goS+IeLmyMkO3PG3BCuE3UQZH4NjvsleRN2oLMKRky25bBg/ijhEMK/dZUQ5U0ftnobI
 atGZaS4hKHChTlwmi9k2oKr0nVfcqqn1V3DZaFAP72f+nUpXQohnuG+DOMuyoBpRia3E
 /Ur2Y4J7gZg0F2albvLnFJifGnLE2GeYy9Y6V2FjaLI/JLa8WM0UM0fv4/u97DNauILr
 aPLw==
X-Gm-Message-State: AOAM532w6KcEoUuW5LPzL6oN35fZY90Z47iJ2DHz38Oo8az1xVj6238O
 AMui8afXTT8CbGDqKp64FQ9FkbqV/P0aDr/IxLjNG7WwypXXp4atYMJj9fRJ3/7bWu5f+rY1JJm
 ZZDGHGGFp8PkhTdatwOyZ+ow8GqDywEj6PV+TwdSvHA==
X-Received: by 2002:a05:6402:2690:: with SMTP id
 w16mr8674178edd.304.1613053898760; 
 Thu, 11 Feb 2021 06:31:38 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxsl6V5GNKxpKd/ex6D4v2PjeuJ2YZDy6YsN4AWMb++9K3iYM1L51RtUTNQ9HDhfu68aafpbg==
X-Received: by 2002:a05:6402:2690:: with SMTP id
 w16mr8674161edd.304.1613053898597; 
 Thu, 11 Feb 2021 06:31:38 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id u2sm4173850edo.38.2021.02.11.06.31.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 11 Feb 2021 06:31:37 -0800 (PST)
Date: Thu, 11 Feb 2021 15:31:35 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v4 16/17] loopback/vsock: setup SEQPACKET ops for
 transport
Message-ID: <20210211143135.jbrfb5izewuiiaka@steredhat>
References: <20210207151259.803917-1-arseny.krasnov@kaspersky.com>
 <20210207151851.806233-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20210207151851.806233-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, Jeff Vander Stoep <jeffv@google.com>,
 stsp2@yandex.ru, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
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

Please move this patch before the test and I'd change the prefix in 
"vsock_loopback" or "vsock/loopback".

Thanks,
Stefano

On Sun, Feb 07, 2021 at 06:18:48PM +0300, Arseny Krasnov wrote:
>This adds SEQPACKET ops for loopback transport
>
>Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
>---
> net/vmw_vsock/vsock_loopback.c | 5 +++++
> 1 file changed, 5 insertions(+)
>
>diff --git a/net/vmw_vsock/vsock_loopback.c b/net/vmw_vsock/vsock_loopback.c
>index a45f7ffca8c5..c0da94119f74 100644
>--- a/net/vmw_vsock/vsock_loopback.c
>+++ b/net/vmw_vsock/vsock_loopback.c
>@@ -89,6 +89,11 @@ static struct virtio_transport loopback_transport = {
> 		.stream_is_active         = virtio_transport_stream_is_active,
> 		.stream_allow             = virtio_transport_stream_allow,
>
>+		.seqpacket_seq_send_len	  = virtio_transport_seqpacket_seq_send_len,
>+		.seqpacket_seq_send_eor	  = virtio_transport_seqpacket_seq_send_eor,
>+		.seqpacket_seq_get_len	  = virtio_transport_seqpacket_seq_get_len,
>+		.seqpacket_dequeue        = virtio_transport_seqpacket_dequeue,
>+
> 		.notify_poll_in           = virtio_transport_notify_poll_in,
> 		.notify_poll_out          = virtio_transport_notify_poll_out,
> 		.notify_recv_init         = virtio_transport_notify_recv_init,
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
