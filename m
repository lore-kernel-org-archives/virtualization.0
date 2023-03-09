Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2841FC64EC4
	for <virtualization@archiver.kernel.org>; Thu,  9 Mar 2023 16:22:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 85700613BB;
	Thu,  9 Mar 2023 16:22:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 85700613BB
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OJVlJ9OC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id F3ujrt1B0-tp; Thu,  9 Mar 2023 16:22:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E97C5607A4;
	Thu,  9 Mar 2023 16:22:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E97C5607A4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1015C0035;
	Thu,  9 Mar 2023 16:22:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9A82C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 16:22:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B712582121
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 16:22:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B712582121
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OJVlJ9OC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OhA-xoZ7qICs
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 16:22:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 839CD82131
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 839CD82131
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Mar 2023 16:22:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678378923;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=LEHbZXmqj5JG1Cxdlx+rAzJmqeOLu7jI6Qgs9itxkdM=;
 b=OJVlJ9OC3B0I2WGYNZ2J5Vo5dwMAdt6hq0CAlW9D11+FIDwvlAzVi60igNUBl5ST9QVCFn
 YPbS8ftJ25XfHGTUZ16B6afLnDZS+FYOU47ZQIhJ9jjA5j9JSyOIcmAen40yT4zfyplrq4
 XUPaHlA8iNZqGN/oIbFh8zyP/8N07FQ=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-385-7Xo4LL35PO-v0jr0VGOGPw-1; Thu, 09 Mar 2023 11:22:02 -0500
X-MC-Unique: 7Xo4LL35PO-v0jr0VGOGPw-1
Received: by mail-qv1-f69.google.com with SMTP id
 s18-20020a0cf792000000b00572c04240f1so1442493qvn.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Mar 2023 08:22:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678378921;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=LEHbZXmqj5JG1Cxdlx+rAzJmqeOLu7jI6Qgs9itxkdM=;
 b=6U3J+f+LFbtIKOQVH2pBfrn3KF614w8oAcKMu7dlySTLmlK+27aQlQ7nPFHRY3zW95
 HrdNlk4TeWf+EUC/78Xy/niBF0zLlGtPk1WcaIEF5sfIlR8sSbkZS67uFhRSbGsiuVl+
 6mRgpryaWIDcLkk7K/6gvYa0ZJF5W/uEFJ+jrbFHaG8Pep8GF3vQs3g6efBZDSYqsLaB
 +9NckE7vwI8koUzK9WI47Ui20Ka3ps8MPsC3c3deczh46fVTkZ0jfm2m3rX1YvG5ibls
 l32NJbDTRxwUILoqjsUg6TkXhywh39ZaB6MNdRGJL1O/8kcWhBCjBAa58awQqw4GkJJ9
 ToMg==
X-Gm-Message-State: AO0yUKWKL7FNG6olmD35t3KS3d3mxQ0Q7d1nCr5N646dd0iZGEOyz48l
 YIDZG0fPummb+jQ4/8dMrSLDW1caeP0IKSflC98hAL2fMYJWOzZA2/ddxkOKgjpzkajfB+UWz8L
 7nuepJh40lej/AVES3AKo+fQEIDqHajoPu/jyf12aaQ==
X-Received: by 2002:a05:622a:1a1c:b0:3b8:6788:bf25 with SMTP id
 f28-20020a05622a1a1c00b003b86788bf25mr37444157qtb.23.1678378916664; 
 Thu, 09 Mar 2023 08:21:56 -0800 (PST)
X-Google-Smtp-Source: AK7set+GI92GzioBeNCbqnB3nXBd7JnBKOAfAg1RXELqlvwy47gh802YuCBcQAaesacewK2BJ1ThFw==
X-Received: by 2002:a05:622a:1a1c:b0:3b8:6788:bf25 with SMTP id
 f28-20020a05622a1a1c00b003b86788bf25mr37444121qtb.23.1678378916373; 
 Thu, 09 Mar 2023 08:21:56 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 t197-20020a3746ce000000b007417e60f621sm13896467qka.126.2023.03.09.08.21.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Mar 2023 08:21:55 -0800 (PST)
Date: Thu, 9 Mar 2023 17:21:50 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v3 0/4] several updates to virtio/vsock
Message-ID: <20230309162150.qqrlqmqghi5muucx@sgarzare-redhat>
References: <0abeec42-a11d-3a51-453b-6acf76604f2e@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <0abeec42-a11d-3a51-453b-6acf76604f2e@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, oxffffaa@gmail.com,
 Eric Dumazet <edumazet@google.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 kernel@sberdevices.ru, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

On Thu, Mar 09, 2023 at 01:10:36PM +0300, Arseniy Krasnov wrote:
>Hello,
>
>this patchset evolved from previous v2 version (see link below). It does
>several updates to virtio/vsock:
>1) Changes 'virtio_transport_inc/dec_rx_pkt()' interface. Now instead of
>   using skbuff state ('head' and 'data' pointers) to update 'fwd_cnt'
>   and 'rx_bytes', integer value is passed as an input argument. This
>   makes code more simple, because in this case we don't need to udpate
>   skbuff state before calling 'virtio_transport_inc/dec_rx_pkt()'. In
>   more common words - we don't need to change skbuff state to update
>   'rx_bytes' and 'fwd_cnt' correctly.
>2) For SOCK_STREAM, when copying data to user fails, current skbuff is
>   not dropped. Next read attempt will use same skbuff and last offset.
>   Instead of 'skb_dequeue()', 'skb_peek()' + '__skb_unlink()' are used.
>   This behaviour was implemented before skbuff support.
>3) For SOCK_SEQPACKET it removes unneeded 'skb_pull()' call, because for
>   this type of socket each skbuff is used only once: after removing it
>   from socket's queue, it will be freed anyway.
>
>Test for 2) also added:
>Test tries to 'recv()' data to NULL buffer, then does 'recv()' with valid
>buffer. For SOCK_STREAM second 'recv()' must return data, because skbuff
>must not be dropped, but for SOCK_SEQPACKET skbuff will be dropped by
>kernel, and 'recv()' will return EAGAIN.
>
>Link to v1 on lore:
>https://lore.kernel.org/netdev/c2d3e204-89d9-88e9-8a15-3fe027e56b4b@sberdevices.ru/
>
>Link to v2 on lore:
>https://lore.kernel.org/netdev/a7ab414b-5e41-c7b6-250b-e8401f335859@sberdevices.ru/
>
>Change log:
>
>v1 -> v2:
> - For SOCK_SEQPACKET call 'skb_pull()' also in case of copy failure or
>   dropping skbuff (when we just waiting message end).
> - Handle copy failure for SOCK_STREAM in the same manner (plus free
>   current skbuff).
> - Replace bug repdroducer with new test in vsock_test.c
>
>v2 -> v3:
> - Replace patch which removes 'skb->len' subtraction from function
>   'virtio_transport_dec_rx_pkt()' with patch which updates functions
>   'virtio_transport_inc/dec_rx_pkt()' by passing integer argument
>   instead of skbuff pointer.
> - Replace patch which drops skbuff when copying to user fails with
>   patch which changes this behaviour by keeping skbuff in queue until
>   it has no data.
> - Add patch for SOCK_SEQPACKET which removes redundant 'skb_pull()'
>   call on read.
> - I remove "Fixes" tag from all patches, because all of them now change
>   code logic, not only fix something.

Yes, but they solve the problem, so we should use the tag (I think at
least in patch 1 and 3).

We usually use the tag when we are fixing a problem introduced by a
previous change. So we need to backport the patch to the stable branches
as well, and we need the tag to figure out which branches have the patch
or not.

Thanks,
Stefano

>
>Arseniy Krasnov (4):
>  virtio/vsock: don't use skbuff state to account credit
>  virtio/vsock: remove redundant 'skb_pull()' call
>  virtio/vsock: don't drop skbuff on copy failure
>  test/vsock: copy to user failure test
>
> net/vmw_vsock/virtio_transport_common.c |  29 +++---
> tools/testing/vsock/vsock_test.c        | 118 ++++++++++++++++++++++++
> 2 files changed, 131 insertions(+), 16 deletions(-)
>
>-- 
>2.25.1
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
