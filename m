Return-Path: <SRS0=T/77=JT=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B20D5C433B4
	for <virtualization@archiver.kernel.org>; Thu, 22 Apr 2021 10:48:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F086961428
	for <virtualization@archiver.kernel.org>; Thu, 22 Apr 2021 10:48:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F086961428
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7D17D6067F;
	Thu, 22 Apr 2021 10:48:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SpwoLUaLH-7o; Thu, 22 Apr 2021 10:48:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C38560677;
	Thu, 22 Apr 2021 10:48:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 104F0C000F;
	Thu, 22 Apr 2021 10:48:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0F26EC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 10:48:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E3F4F83BC0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 10:48:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id t3iI1oyphXTI
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 10:48:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BBA1582AEF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 10:48:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619088499;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=W56Co4nmu9futOlRgTdRc7GGowpj4sKz++PgS6J5tsk=;
 b=dlqBfDXOPLAAthq3eU+GFg8nSm5PKmrKr5EzImFVCrKAovkON0hRU4n+bkR1F1FpRCSW2h
 OkG9wFFfJxV7OWqPYYVvVLqaX2EP3QSnP93znGnOGPW5+CImK8+9i2vfi1Uufz0WlJQoI6
 tGBv79/rl8rQfpV6rrWKRoZGgfs+xuI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-519-NQz-zz92Mkuy46Vw1Q2_Zw-1; Thu, 22 Apr 2021 06:48:17 -0400
X-MC-Unique: NQz-zz92Mkuy46Vw1Q2_Zw-1
Received: by mail-ed1-f69.google.com with SMTP id
 o4-20020a0564024384b0290378d45ecf57so16649162edc.12
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Apr 2021 03:48:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=W56Co4nmu9futOlRgTdRc7GGowpj4sKz++PgS6J5tsk=;
 b=ac1YyQLOrk/oUxV2F/iM/WiwDpAjLa0hE8+nkXTpuD1ZiGGm1bMNS538Wl8j6Oa16p
 pTGtEL6XRqI/hwaonCskZLe+AgjSdbzMbxghMDbTqwD4ZotVPLKLh99N3MT/xMs8Ts/L
 KzEBTPWc1e4BfDafFAWB67+fnP2TRmK8sNXt3Fd/EfJRJpwAscLCgwZoDFQ4POgYoFmw
 i0mMbebyxN6rAjqrPAPoxADUEP0nhXPqtkhqPfqmt7r0zqh8NFGgqiUOKGH4UuA7U5jf
 pKq3+qYS9utM1v7lMwLcEQtmRLtVShi/0wkC03TwJGDfehB71Wv5UyaooBPpWVrJo9Tx
 5fRA==
X-Gm-Message-State: AOAM530fU+yeOWjZ4FMGFmKTu2JZ4hTnEuBExLTvooIk/NCXyu5i9DQF
 TIBn+O3vORuE2QCZhbprdW8/B77wkQIuVKWI4qjhH3Q/CF3NOiXn1bnvoEa4+J6Q8nQS/cJcHSY
 kG/kFdqmnUaXjQbJHqwDLzQ327YLbhZXMkc8s3j/gzg==
X-Received: by 2002:a17:906:cec2:: with SMTP id
 si2mr2807095ejb.234.1619088496544; 
 Thu, 22 Apr 2021 03:48:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz3/JpW1+yllDt8fPHdvJEi1YttSx3GfTb7YhzmFF4NC8d2xAOCwtXohAtzSrborDsblnu1zw==
X-Received: by 2002:a17:906:cec2:: with SMTP id
 si2mr2807055ejb.234.1619088496251; 
 Thu, 22 Apr 2021 03:48:16 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id d10sm1577096ejw.125.2021.04.22.03.48.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Apr 2021 03:48:15 -0700 (PDT)
Date: Thu, 22 Apr 2021 12:48:13 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [RFC PATCH v8 00/19] virtio/vsock: introduce SOCK_SEQPACKET
 support
Message-ID: <20210422104813.e2p4wzuk2ahw7af7@steredhat>
References: <20210413123954.3396314-1-arseny.krasnov@kaspersky.com>
 <20210421095213.25hnfi2th7gzyzt2@steredhat>
 <2c3d0749-0f41-e064-0153-b6130268add2@kaspersky.com>
 <20210422084638.bvblk33b4oi6cec6@steredhat>
 <bfefdd94-a84f-8bed-331e-274654a7426f@kaspersky.com>
 <20210422100217.jmpgevtrukqyukfo@steredhat>
 <bc649d1b-80d8-835c-6f47-8a7d402dd0b7@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <bc649d1b-80d8-835c-6f47-8a7d402dd0b7@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andra Paraschiv <andraprs@amazon.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "stsp2@yandex.ru" <stsp2@yandex.ru>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "oxffffaa@gmail.com" <oxffffaa@gmail.com>,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Jorgen Hansen <jhansen@vmware.com>,
 Alexander Popov <alex.popov@linux.com>
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

On Thu, Apr 22, 2021 at 01:29:54PM +0300, Arseny Krasnov wrote:
>
>On 22.04.2021 13:02, Stefano Garzarella wrote:
>> On Thu, Apr 22, 2021 at 12:40:17PM +0300, Arseny Krasnov wrote:
>>> On 22.04.2021 11:46, Stefano Garzarella wrote:
>>>> On Wed, Apr 21, 2021 at 06:06:28PM +0300, Arseny Krasnov wrote:
>>>>> Thank You, i'll prepare next version. Main question is: does this
>>>>> approach(no SEQ_BEGIN, SEQ_END, 'msg_len' and 'msg_id') considered
>>>>> good? In this case it will be easier to prepare final version, because
>>>>> is smaller and more simple than previous logic. Also patch to spec
>>>>> will be smaller.
>>>> Yes, it's definitely much better than before.
>>>>
>>>> The only problem I see is that we add some overhead per fragment
>>>> (header). We could solve that with the mergeable buffers that Jiang is
>>>> considering for DGRAM.
>>> If we are talking about receive, i think, i can reuse merge logic for
>> Yep, for TX the guest can potentially enqueue a big buffer.
>> Maybe it's still worth keeping a maximum size and fragmenting as we do
>> now.
>>
>>> stream sockets, the only difference is that buffers are mergeable
>>> until previous EOR(e.g. previous message) bit is found in rx queue.
>>>
>> I got a little lost.
>> Can you elaborate more?
>
>I'm talking about 'virtio_transport_recv_enqueue()': it tries to copy
>
>data of new packet to buffer of tail packet in rx queue. In case of
>
>SEQPACKET i can reuse it, just adding logic that check EOR bit of
>
>tail packet.

This might be a good idea.
It doesn't save us the transmitted header though, but at least it saves 
us from queuing it.
Even if with SEQPACKET I don't expect small packets, since it's the 
driver that divides them and I think it does everything to use the 
maximum available.

Instead the mergeable buffers I was referring to are based on the 
virito-net feature VIRTIO_NET_F_MRG_RXBUF.
Jiang is investigating whether we can reuse them for DGRAM.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
