Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A90AC001DE
	for <virtualization@archiver.kernel.org>; Wed,  2 Aug 2023 07:46:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 22A4C40A17;
	Wed,  2 Aug 2023 07:46:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 22A4C40A17
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hVlz3z9o
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uA-wqYoSb3sZ; Wed,  2 Aug 2023 07:46:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3195840C99;
	Wed,  2 Aug 2023 07:46:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3195840C99
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 02297C0072;
	Wed,  2 Aug 2023 07:46:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7E6DEC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 07:46:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5907840395
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 07:46:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5907840395
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3bj5q88_-96F
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 07:46:17 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A95FE40A17
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Aug 2023 07:46:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A95FE40A17
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690962376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h0UDSjpYhDP6foyjtQosf3cDeLd01SyV7B6Zn77rW4I=;
 b=hVlz3z9oubslwFeNNfP1fFqZuRqYGw7POGtZt/4+j9N0PvOqXix6iTAuT+NrtFQapRAMmF
 kfpuCF6tC4i3WSc038+9VEanZn67ddivfGIu4Ya2dIJ8osEjAd7V83xMsfLJSEmVZAXWSb
 C/aS+S211EQcDepzZeomwPoVZPvYHB4=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-315-XakCxjGGMKWUKQ-LYK61yA-1; Wed, 02 Aug 2023 03:46:14 -0400
X-MC-Unique: XakCxjGGMKWUKQ-LYK61yA-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-76c83aab2c7so676698285a.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Aug 2023 00:46:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690962374; x=1691567174;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h0UDSjpYhDP6foyjtQosf3cDeLd01SyV7B6Zn77rW4I=;
 b=cEKOeNWlQax+36bIZIo6BxDAX/f1FAgeDkpGpM2Lgh0MzvUmfzQJGvVISpflvqBnjV
 yJI3ydkbymCVzyEElFOrtUMQLu694Mqd/qZXz9MP19YR6D6QFthp0W4OgK35pZUyeO68
 zUpoqo7ucxM4UBIJmsVqII7LTcsHSNfF9VdxSjTpapyLLDC+npTRK0yr5Lj9skqnOkFC
 IWteVWO96p+T+UdUxMsmMN3r18yYnHaaBw7fpPUE+gcL+QXOOcyspXD+tia1wTMTGcky
 jXyB3O6zYFdF94lH6xN6dqOyEuo4FiP7bSHdmv8pTdYNZW+eXyz7jJ9MHomX8dzlZeJu
 FjwA==
X-Gm-Message-State: ABy/qLYCcDj0Qdw6YiepGYuLQwH5RFmepFHnT2uUrldKpamsUsuCYYwX
 EOiwQSDOMEX4FBRhTPoxSCzxAgZuUGMT48v+1ZN7i+ELkSML/44us9QdF09oITLio0owtal84RK
 v9gQc9QhwSq0Yxtq41qPrjeSLaa7TkrW/OU9Zy3kwIw==
X-Received: by 2002:a05:620a:2ae7:b0:76c:a35d:ee7b with SMTP id
 bn39-20020a05620a2ae700b0076ca35dee7bmr10630799qkb.75.1690962374346; 
 Wed, 02 Aug 2023 00:46:14 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFodtYusq4miD67/qZPAflmfAiVup1o7pJRX1yLg/dsHxa8uZugDcgzMDc/Lwni4Tbe0+BMww==
X-Received: by 2002:a05:620a:2ae7:b0:76c:a35d:ee7b with SMTP id
 bn39-20020a05620a2ae700b0076ca35dee7bmr10630782qkb.75.1690962374098; 
 Wed, 02 Aug 2023 00:46:14 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-214.retail.telecomitalia.it.
 [82.57.51.214]) by smtp.gmail.com with ESMTPSA id
 f10-20020a0ccc8a000000b0062439f05b87sm5270298qvl.45.2023.08.02.00.46.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Aug 2023 00:46:13 -0700 (PDT)
Date: Wed, 2 Aug 2023 09:46:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 1/2] vsock: send SIGPIPE on write to shutdowned
 socket
Message-ID: <qgn26mgfotc7qxzp6ad7ezkdex6aqniv32c5tvehxh4hljsnvs@x7wvyvptizxx>
References: <20230801141727.481156-1-AVKrasnov@sberdevices.ru>
 <20230801141727.481156-2-AVKrasnov@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <20230801141727.481156-2-AVKrasnov@sberdevices.ru>
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

On Tue, Aug 01, 2023 at 05:17:26PM +0300, Arseniy Krasnov wrote:
>POSIX requires to send SIGPIPE on write to SOCK_STREAM socket which was
>shutdowned with SHUT_WR flag or its peer was shutdowned with SHUT_RD
>flag. Also we must not send SIGPIPE if MSG_NOSIGNAL flag is set.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/af_vsock.c | 3 +++
> 1 file changed, 3 insertions(+)
>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 020cf17ab7e4..013b65241b65 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -1921,6 +1921,9 @@ static int vsock_connectible_sendmsg(struct socket *sock, struct msghdr *msg,
> 			err = total_written;
> 	}
> out:
>+	if (sk->sk_type == SOCK_STREAM)
>+		err = sk_stream_error(sk, msg->msg_flags, err);

Do you know why we don't need this for SOCK_SEQPACKET and SOCK_DGRAM?

Thanks,
Stefano

>+
> 	release_sock(sk);
> 	return err;
> }
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
