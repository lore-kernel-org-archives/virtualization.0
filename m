Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA235C761AF
	for <virtualization@archiver.kernel.org>; Thu, 30 Mar 2023 08:03:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3EC70842AF;
	Thu, 30 Mar 2023 08:03:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3EC70842AF
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iILY5fRz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id CnYioGz6Xq_f; Thu, 30 Mar 2023 08:03:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C44E8842AC;
	Thu, 30 Mar 2023 08:03:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C44E8842AC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BD59C0037;
	Thu, 30 Mar 2023 08:03:12 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67AA9C002F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 08:03:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3DDE4402A9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 08:03:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3DDE4402A9
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=iILY5fRz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YGOXG40Rrl3W
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 08:03:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5267B4027D
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5267B4027D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 08:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680163387;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BmvkK8fYK4TJ5NfFumKVdlTRthgnv0I/fv0iMmHm2zA=;
 b=iILY5fRzMlnnVJ3NU35Q03M+IbAzk3P4cWG2PiqpNPcxpa0GUMTl4wI+TnJ6qeoBpd8K0P
 oHvktS7uL9nJ0u7ZfCtvtz/9WVOY/tsq9fShpy+1BZbseNGruQfovUlUQuvPLGWUjMRr+Y
 L4LAuvIA6ZEM1dhHu6LYXGenGNYEeiE=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-652-8dajFsY9NoWevtR5_rRADg-1; Thu, 30 Mar 2023 04:03:03 -0400
X-MC-Unique: 8dajFsY9NoWevtR5_rRADg-1
Received: by mail-qt1-f200.google.com with SMTP id
 h6-20020ac85846000000b003e3c23d562aso11913571qth.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Mar 2023 01:03:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680163383;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BmvkK8fYK4TJ5NfFumKVdlTRthgnv0I/fv0iMmHm2zA=;
 b=bj4wpkBc0gfYUQ2kS7Ci/uobz1s1FS7r4QO/1sRcfM1ilmvZuCw7dlxQnZS+J5b5cm
 NyWnKK0bZBjK8a9TGi6rjo3HoO70R+E9TGRzsW+KEUtXmB3yp/L5HRH7oM4ssKDaQcCC
 R2hsEOL6FEueEMsQ7q/vCUT+VFOgQsjQoRYfcTggNkGvq/nzR+Ss1ZrTxiFpqchEuIYt
 qnAVQhRtNfCWP0SkR8j/bZJNNq4h/a0MAUK7CywPEIJLd2MC6ap1cJdPeaUz9mjdY6Ft
 1x7gbi2QBU+29c+RJ5L/sptFTNprZ0vWwYSj5LhsuGiolbmV4ZH1Jd0zVwI2BfBZrtB1
 7etA==
X-Gm-Message-State: AAQBX9dayrDx8oaTtQ7mTdrf1dD/Qbnvtu1su6x3p60ZqXzaIRlXCfZv
 yLCOo7KndvwDaOaGYU3WzviDtacSe+57AGqhsv0t67TRw4AFl3IKyHL2H69gZ/Bdcfeo5mVDqdz
 AAkf3lQimpYn1woXw7/zd/z9B06PqV/KtvnqlW728TA==
X-Received: by 2002:ad4:5dcd:0:b0:5a9:c0a1:d31a with SMTP id
 m13-20020ad45dcd000000b005a9c0a1d31amr32511908qvh.49.1680163383486; 
 Thu, 30 Mar 2023 01:03:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350b/24uAmv6SuUb1n6/2cdmqOMqi4TQbiOPJWGZJaeeZPx69yK8YzSEPOHSxImFh4Y41wpxtEg==
X-Received: by 2002:ad4:5dcd:0:b0:5a9:c0a1:d31a with SMTP id
 m13-20020ad45dcd000000b005a9c0a1d31amr32511878qvh.49.1680163383217; 
 Thu, 30 Mar 2023 01:03:03 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-130.retail.telecomitalia.it.
 [82.57.51.130]) by smtp.gmail.com with ESMTPSA id
 mh2-20020a056214564200b005dd8b934582sm5197140qvb.26.2023.03.30.01.02.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Mar 2023 01:03:02 -0700 (PDT)
Date: Thu, 30 Mar 2023 10:02:57 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v2 1/3] vsock: return errors other than -ENOMEM to
 socket
Message-ID: <p64mv3f2ujn4uokl5i7abhdbmed3zy2lrozqoam3llcf4r2qkv@gmyoyikbyiwj>
References: <60abc0da-0412-6e25-eeb0-8e32e3ec21e7@sberdevices.ru>
 <b910764f-a193-e684-a762-f941883a0745@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <b910764f-a193-e684-a762-f941883a0745@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vishnu Dasa <vdasa@vmware.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 pv-drivers@vmware.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Bryan Tan <bryantan@vmware.com>, Eric Dumazet <edumazet@google.com>,
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

On Thu, Mar 30, 2023 at 10:05:45AM +0300, Arseniy Krasnov wrote:
>This removes behaviour, where error code returned from any transport
>was always switched to ENOMEM. This works in the same way as:
>commit
>c43170b7e157 ("vsock: return errors other than -ENOMEM to socket"),
>but for receive calls.
>
>Signed-off-by: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
>---
> net/vmw_vsock/af_vsock.c | 4 ++--
> 1 file changed, 2 insertions(+), 2 deletions(-)

We should first make sure that all transports return the right value,
and then expose it to the user, so I would move this patch, after
patch 2.

Thanks,
Stefano

>
>diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
>index 5f2dda35c980..413407bb646c 100644
>--- a/net/vmw_vsock/af_vsock.c
>+++ b/net/vmw_vsock/af_vsock.c
>@@ -2043,7 +2043,7 @@ static int __vsock_stream_recvmsg(struct sock *sk, struct msghdr *msg,
>
> 		read = transport->stream_dequeue(vsk, msg, len - copied, flags);
> 		if (read < 0) {
>-			err = -ENOMEM;
>+			err = read;
> 			break;
> 		}
>
>@@ -2094,7 +2094,7 @@ static int __vsock_seqpacket_recvmsg(struct sock *sk, struct msghdr *msg,
> 	msg_len = transport->seqpacket_dequeue(vsk, msg, flags);
>
> 	if (msg_len < 0) {
>-		err = -ENOMEM;
>+		err = msg_len;
> 		goto out;
> 	}
>
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
