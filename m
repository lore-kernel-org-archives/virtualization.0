Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0FFAC6FD1E
	for <virtualization@archiver.kernel.org>; Fri, 10 Mar 2023 11:40:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0905C418D8;
	Fri, 10 Mar 2023 11:40:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0905C418D8
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OJ3Xfx63
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kPdRLv4KG0Yl; Fri, 10 Mar 2023 11:40:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4741641810;
	Fri, 10 Mar 2023 11:40:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4741641810
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16AC2C0035;
	Fri, 10 Mar 2023 11:40:12 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C780C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 11:40:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3643C60B8F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 11:40:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3643C60B8F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OJ3Xfx63
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MgtAu_68bxDS
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 11:40:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 65A7860AA4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 65A7860AA4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 11:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678448408;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rJwQlAakOokhmQO5hlNSSM0QAOQ7URuACK/mNX+Ecvw=;
 b=OJ3Xfx63shEv/qq3wxCdzzUsdGMHfbUcVOOnZUnehEZ7cdTFzJb5k2KeX/c0hSVKBAviWu
 CA/aNygzLvN+9l7wiZZrB8GaAwC5biRKefIJf2kqZmFktX+djGIc/52icv7//MYA6mBPK0
 q/Xv0V2Ll18HySAAWdGoeLBNpX+/0q4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-322-dcbaocUkMK69Vqnbc-9G-w-1; Fri, 10 Mar 2023 06:40:05 -0500
X-MC-Unique: dcbaocUkMK69Vqnbc-9G-w-1
Received: by mail-wm1-f70.google.com with SMTP id
 bi27-20020a05600c3d9b00b003e9d0925341so1702215wmb.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 10 Mar 2023 03:40:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678448404;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=rJwQlAakOokhmQO5hlNSSM0QAOQ7URuACK/mNX+Ecvw=;
 b=ZdXhLSn3WSefu2hhhqXw+Yx7dqKAUXkGKJOPeEkneIUAZ2qPYwWZ1j0S6YPut44tOV
 3KnVFetWTxGggOqbW1AwEvLgGrw/aKAaEJsanyWaR2x86ykr5aThZ7p9+oft+RF0SX1V
 8yN3lS+4kZIxjo/GFRRHJibVmopqP1yl0W/vdlaLHJd0nENfPsT++iNm3y9DMqKd1VGH
 f5I4+C/njPD+c8/7rjkhbFu8JRqB43rjB71nzAowUKwFh6gkMRtHdvqYtgMxNPRuRsxW
 3W/McxqEkO1wwZk9kAhlweiVJtn22ZKAnZP0Yz9SY/rF4ElKZKZc4Sne4mXfVUd0Y7w/
 AJMw==
X-Gm-Message-State: AO0yUKUja9bLznazHkJ//d9uzeXDAabszcmmYlzehTVoRvRWzXCPx05+
 ymHWY2zT/fyliZkppL+2vFAFWgURIBBRof34BY1Udi25K5kAuXhGp2hxVrWygVKfMj8N9fwrpYh
 WgIn2eSwyck79wZv+VBhtBJuNkFoY+NZodVyi3B2WjA==
X-Received: by 2002:adf:ef10:0:b0:2ca:3576:756d with SMTP id
 e16-20020adfef10000000b002ca3576756dmr17441600wro.50.1678448404005; 
 Fri, 10 Mar 2023 03:40:04 -0800 (PST)
X-Google-Smtp-Source: AK7set+RNKqlJyQI+1SQ507spnOBqv3bWEPOICTIm+RgBVN6rKvCG9ALHkeDNEO4/C58wDmMpo7bIA==
X-Received: by 2002:adf:ef10:0:b0:2ca:3576:756d with SMTP id
 e16-20020adfef10000000b002ca3576756dmr17441579wro.50.1678448403714; 
 Fri, 10 Mar 2023 03:40:03 -0800 (PST)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 m4-20020a5d6244000000b002c707b336c9sm2065136wrv.36.2023.03.10.03.40.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 10 Mar 2023 03:40:03 -0800 (PST)
Date: Fri, 10 Mar 2023 12:40:00 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <avkrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v4 0/4] several updates to virtio/vsock
Message-ID: <20230310114000.6ptwpryulbvcqf5m@sgarzare-redhat>
References: <1804d100-1652-d463-8627-da93cb61144e@sberdevices.ru>
 <20230310090937.s55af2fx56zn4ewu@sgarzare-redhat>
 <15b9df26-bdc1-e139-8df7-62f966c719ed@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <15b9df26-bdc1-e139-8df7-62f966c719ed@sberdevices.ru>
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
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, Mar 10, 2023 at 12:42:13PM +0300, Arseniy Krasnov wrote:
>
>
>On 10.03.2023 12:09, Stefano Garzarella wrote:
>> Hi Arseniy,
>>
>> On Thu, Mar 09, 2023 at 11:24:42PM +0300, Arseniy Krasnov wrote:
>>> Hello,
>>>
>>> this patchset evolved from previous v2 version (see link below). It does
>>> several updates to virtio/vsock:
>>> 1) Changes 'virtio_transport_inc/dec_rx_pkt()' interface. Now instead of
>>> =A0 using skbuff state ('head' and 'data' pointers) to update 'fwd_cnt'
>>> =A0 and 'rx_bytes', integer value is passed as an input argument. This
>>> =A0 makes code more simple, because in this case we don't need to update
>>> =A0 skbuff state before calling 'virtio_transport_inc/dec_rx_pkt()'. In
>>> =A0 more common words - we don't need to change skbuff state to update
>>> =A0 'rx_bytes' and 'fwd_cnt' correctly.
>>> 2) For SOCK_STREAM, when copying data to user fails, current skbuff is
>>> =A0 not dropped. Next read attempt will use same skbuff and last offset.
>>> =A0 Instead of 'skb_dequeue()', 'skb_peek()' + '__skb_unlink()' are use=
d.
>>> =A0 This behaviour was implemented before skbuff support.
>>> 3) For SOCK_SEQPACKET it removes unneeded 'skb_pull()' call, because for
>>> =A0 this type of socket each skbuff is used only once: after removing it
>>> =A0 from socket's queue, it will be freed anyway.
>>
>> thanks for the fixes, I would wait a few days to see if there are any
>> comments and then I think you can send it on net without RFC.
>>
>> @Bobby if you can take a look, your ack would be appreciated :-)
>Ok, thanks for review. I'll wait for several days and also wait until
>net-next will be opened. Then i'll resend this patchset with net-next

Since they are fixes, they should go with the net tree, not net-next.

Cheers,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
