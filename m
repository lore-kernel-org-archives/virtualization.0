Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3A50CA0FE8
	for <virtualization@archiver.kernel.org>; Fri,  1 Sep 2023 12:34:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66C3E81E50;
	Fri,  1 Sep 2023 12:34:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 66C3E81E50
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=dW71cnaq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ogRaTiuD4hzg; Fri,  1 Sep 2023 12:34:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CEF9D81E46;
	Fri,  1 Sep 2023 12:34:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CEF9D81E46
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A281BC0039;
	Fri,  1 Sep 2023 12:34:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FBABC0032
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Sep 2023 12:34:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 25C474200E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Sep 2023 12:34:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 25C474200E
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=dW71cnaq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q-JEUfBcnuEU
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Sep 2023 12:34:15 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 22CE04200D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  1 Sep 2023 12:34:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 22CE04200D
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693571654;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=aNIJ/eGigZtGUYGZTGziEv0Hr86IZ6MX9zljYZmw98Q=;
 b=dW71cnaqsMBubyvulZnP+cNA3c7u+JDEORkXzSESoNtOiMqluKcZ5vuebGHdn7iVw/i67h
 1zgsJeoogWW/sOQrilF/vapsv06UEZnA8ioNtJVNDMlleiZYTRCX2wkQ1NRvJ3O8QmoN7O
 nHoMv837Fo6suG6BuTgfwQ8iXkKtwRQ=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-135-mXmSrYPkN_6YzD2VlQ51kQ-1; Fri, 01 Sep 2023 08:34:13 -0400
X-MC-Unique: mXmSrYPkN_6YzD2VlQ51kQ-1
Received: by mail-ej1-f70.google.com with SMTP id
 a640c23a62f3a-98e40d91fdfso141299066b.3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 01 Sep 2023 05:34:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693571652; x=1694176452;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aNIJ/eGigZtGUYGZTGziEv0Hr86IZ6MX9zljYZmw98Q=;
 b=bDrk9Fq8wS9gWirz6k9iHbYB3IA/dKlOdJASO8kf/s1F8JKet6FLK0Orrm0GO+eKaj
 Zh4Fkj5mDC7Yrsybgkmk1JCS4XlAhclBzJRlXyo1gs8szKkfYuOoyQSdiDGCiFKhRT4l
 IIr2eLmZ1Wi2oEK+8J5pQPf4qQmpxMV4GuC0JlhwOdF8JlH6utARiFQO7Fyn7oldm7kX
 /izgEmGc62QQoSy/sLQDuRZOU+P/6YMEMzQ6xh//lIjwPQ4BmSeRkgYUrJ2sjgktwuko
 QmWr2N1EYEFds3a1nDoxIsjfAbO0M7T7ruwQmltL32AcgrD6rRxeBwZJHHjjasbj9GGh
 FDTA==
X-Gm-Message-State: AOJu0Yy80xQrxq2qfGoD4lXj1CZq8y+dTQKX+TGcod2ltXfMteg85BeY
 n0y1SuGllHhmjNNhMB3Prc/ys2Vm1I8Ccy+hMikCwOhWqBb6Hkn6CJLJsKB94NMrPZ+pKKlV3nH
 vm52OkPkpp6yY9n3G6QKBFs6e1HZslk6Q5eHOhCSCUQ==
X-Received: by 2002:a17:906:cc4b:b0:9a1:f521:c3ff with SMTP id
 mm11-20020a170906cc4b00b009a1f521c3ffmr1968916ejb.40.1693571651948; 
 Fri, 01 Sep 2023 05:34:11 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFdwDTby/bdcndq6+v/2sv0Oadl3EG/Z9W3gE2sao7E3fQXKbNEUWMjvDkVCoig3fFvaMVq/Q==
X-Received: by 2002:a17:906:cc4b:b0:9a1:f521:c3ff with SMTP id
 mm11-20020a170906cc4b00b009a1f521c3ffmr1968892ejb.40.1693571651661; 
 Fri, 01 Sep 2023 05:34:11 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-114.retail.telecomitalia.it.
 [82.57.51.114]) by smtp.gmail.com with ESMTPSA id
 l13-20020a170906a40d00b0099bc0daf3d7sm1926076ejz.182.2023.09.01.05.34.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 01 Sep 2023 05:34:11 -0700 (PDT)
Date: Fri, 1 Sep 2023 14:34:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Subject: Re: [PATCH net-next v7 1/4] vsock/virtio/vhost: read data from
 non-linear skb
Message-ID: <auffsp3vajtsh4gynsfusph74bdbghvhoalalgvcfqyvphj5vw@hgiwneiqcbrd>
References: <20230827085436.941183-1-avkrasnov@salutedevices.com>
 <20230827085436.941183-2-avkrasnov@salutedevices.com>
MIME-Version: 1.0
In-Reply-To: <20230827085436.941183-2-avkrasnov@salutedevices.com>
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

On Sun, Aug 27, 2023 at 11:54:33AM +0300, Arseniy Krasnov wrote:
>This is preparation patch for MSG_ZEROCOPY support. It adds handling of
>non-linear skbs by replacing direct calls of 'memcpy_to_msg()' with
>'skb_copy_datagram_iter()'. Main advantage of the second one is that it
>can handle paged part of the skb by using 'kmap()' on each page, but if
>there are no pages in the skb, it behaves like simple copying to iov
>iterator. This patch also adds new field to the control block of skb -
>this value shows current offset in the skb to read next portion of data
>(it doesn't matter linear it or not). Idea behind this field is that
>'skb_copy_datagram_iter()' handles both types of skb internally - it
>just needs an offset from which to copy data from the given skb. This
>offset is incremented on each read from skb. This approach allows to
>simplify handling of both linear and non-linear skbs, because for
>linear skb we need to call 'skb_pull()' after reading data from it,
>while in non-linear case we need to update 'data_len'.
>
>Signed-off-by: Arseniy Krasnov <avkrasnov@salutedevices.com>
>---
> Changelog:
> v5(big patchset) -> v1:
>  * Merge 'virtio_transport_common.c' and 'vhost/vsock.c' patches into
>    this single patch.
>  * Commit message update: grammar fix and remark that this patch is
>    MSG_ZEROCOPY preparation.
>  * Use 'min_t()' instead of comparison using '<>' operators.
> v1 -> v2:
>  * R-b tag added.
> v3 -> v4:
>  * R-b tag removed due to rebase:
>    * Part for 'virtio_transport_stream_do_peek()' is changed.
>    * Part for 'virtio_transport_seqpacket_do_peek()' is added.
>  * Comments about sleep in 'memcpy_to_msg()' now describe sleep in
>    'skb_copy_datagram_iter()'.
> v5 -> v6:
>  * Commit message update.
>  * Rename 'frag_off' to 'offset' in 'virtio_vsock_skb_cb'.
>
> drivers/vhost/vsock.c                   | 14 +++++++----
> include/linux/virtio_vsock.h            |  1 +
> net/vmw_vsock/virtio_transport_common.c | 32 +++++++++++++++----------
> 3 files changed, 29 insertions(+), 18 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
