Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14725C4332F
	for <virtualization@archiver.kernel.org>; Mon, 19 Dec 2022 15:41:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6F14F8145D;
	Mon, 19 Dec 2022 15:41:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6F14F8145D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zafnv7Ni
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 50l2stM0LZ0K; Mon, 19 Dec 2022 15:41:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BD66D813B7;
	Mon, 19 Dec 2022 15:41:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BD66D813B7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CAE7C0032;
	Mon, 19 Dec 2022 15:41:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F162C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 15:41:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3B59F40490
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 15:41:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3B59F40490
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Zafnv7Ni
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 82GudCFVEh1J
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 15:41:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 50660400BF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 50660400BF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 15:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671464491;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vlKnSWSIx1ojfKs5edw/VgZ4TRdc4IynKJCcaopveyo=;
 b=Zafnv7Nig/UTeg77w2vXdoCeyJp6o0iy9UbEcYb1mzqzWjLAV0Ulv6kWfEZghUrS41fG3C
 ox0X0YN5kQDv+W/0pNHrKjmS7rHrFOmM9f+lj/2eCBdcTKlF652JS7n7apDsqnlCGwfPhB
 iBkQdjqkVK1DZxR6wg1A1OhKs9i/+RE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-185-KaPcj2U4P4-ItfAf8LrE9A-1; Mon, 19 Dec 2022 10:41:30 -0500
X-MC-Unique: KaPcj2U4P4-ItfAf8LrE9A-1
Received: by mail-wm1-f70.google.com with SMTP id
 r129-20020a1c4487000000b003d153a83d27so5317341wma.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 07:41:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vlKnSWSIx1ojfKs5edw/VgZ4TRdc4IynKJCcaopveyo=;
 b=y79JsW8zHhioqmWFjMUvMo9YGxfP6FkzQXiNcaU7JA1hP7O0ePjodfEbqIdTuyFa4t
 8X2tDBWCY7At5dyNDxLirYR9xQFlgQhdpXWBwUARMmV0EVDGkTg0NhIRnqRGuZadgUje
 dfjP1IhY5k7MUQzYCAniutycKptku3bicNGQGalKbRsUgeEL5hXHY77ey6t4se24LKYD
 /n3026TvYilX+EG+wNVd4HdkKks8f6MZF852ke+eabm2hx10M2FtBy1TXIakwRejhEuN
 T6bnTgChGzKCf/mFmyL69xVWdnVHYD1qq4wW5Nph5k4D15vpLhU2s6qRo5405APJ6jSw
 G8EA==
X-Gm-Message-State: ANoB5pnDF8QUr6FN6siTZOfPcvBc4RZLiTieFXDOP3mINR2SbR38jlVf
 DJCT8fkFli0YWPnTnqhZEPi+CKFXUqxcVID4nELsK7llrCQ0NBpoufo+2Gs859k6l9h8fbLnadO
 9kCfOtpQsGdWmY3Tj6ONEMTSIVgfh7BLLm3b00p8Kfw==
X-Received: by 2002:adf:f98c:0:b0:242:5582:f947 with SMTP id
 f12-20020adff98c000000b002425582f947mr27182922wrr.19.1671464488916; 
 Mon, 19 Dec 2022 07:41:28 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7c1CCW4GpXsPVVZneJb9YGEsZaku3fS+KXI667IWEo0kL8508tyP91BWhdT1KIQ5j10Q7ikw==
X-Received: by 2002:adf:f98c:0:b0:242:5582:f947 with SMTP id
 f12-20020adff98c000000b002425582f947mr27182913wrr.19.1671464488677; 
 Mon, 19 Dec 2022 07:41:28 -0800 (PST)
Received: from sgarzare-redhat (host-87-11-6-51.retail.telecomitalia.it.
 [87.11.6.51]) by smtp.gmail.com with ESMTPSA id
 az17-20020adfe191000000b00241bd7a7165sm10281220wrb.82.2022.12.19.07.41.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Dec 2022 07:41:28 -0800 (PST)
Date: Mon, 19 Dec 2022 16:41:23 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Arseniy Krasnov <AVKrasnov@sberdevices.ru>
Subject: Re: [RFC PATCH v1 0/2] virtio/vsock: fix mutual rx/tx hungup
Message-ID: <CAGxU2F4ca5pxW3RX4wzsTx3KRBtxLK_rO9KxPgUtqcaSNsqXCA@mail.gmail.com>
References: <39b2e9fd-601b-189d-39a9-914e5574524c@sberdevices.ru>
MIME-Version: 1.0
In-Reply-To: <39b2e9fd-601b-189d-39a9-914e5574524c@sberdevices.ru>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Arseniy Krasnov <AVKrasnov@sberdevices.ru>,
 Krasnov Arseniy <oxffffaa@gmail.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, kernel <kernel@sberdevices.ru>,
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Hi Arseniy,

On Sat, Dec 17, 2022 at 8:42 PM Arseniy Krasnov <AVKrasnov@sberdevices.ru> wrote:
>
> Hello,
>
> seems I found strange thing(may be a bug) where sender('tx' later) and
> receiver('rx' later) could stuck forever. Potential fix is in the first
> patch, second patch contains reproducer, based on vsock test suite.
> Reproducer is simple: tx just sends data to rx by 'write() syscall, rx
> dequeues it using 'read()' syscall and uses 'poll()' for waiting. I run
> server in host and client in guest.
>
> rx side params:
> 1) SO_VM_SOCKETS_BUFFER_SIZE is 256Kb(e.g. default).
> 2) SO_RCVLOWAT is 128Kb.
>
> What happens in the reproducer step by step:
>

I put the values of the variables involved to facilitate understanding:

RX: buf_alloc = 256 KB; fwd_cnt = 0; last_fwd_cnt = 0;
    free_space = buf_alloc - (fwd_cnt - last_fwd_cnt) = 256 KB

The credit update is sent if
free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE [64 KB]

> 1) tx tries to send 256Kb + 1 byte (in a single 'write()')
> 2) tx sends 256Kb, data reaches rx (rx_bytes == 256Kb)
> 3) tx waits for space in 'write()' to send last 1 byte
> 4) rx does poll(), (rx_bytes >= rcvlowat) 256Kb >= 128Kb, POLLIN is set
> 5) rx reads 64Kb, credit update is not sent due to *

RX: buf_alloc = 256 KB; fwd_cnt = 64 KB; last_fwd_cnt = 0;
    free_space = 192 KB

> 6) rx does poll(), (rx_bytes >= rcvlowat) 192Kb >= 128Kb, POLLIN is set
> 7) rx reads 64Kb, credit update is not sent due to *

RX: buf_alloc = 256 KB; fwd_cnt = 128 KB; last_fwd_cnt = 0;
    free_space = 128 KB

> 8) rx does poll(), (rx_bytes >= rcvlowat) 128Kb >= 128Kb, POLLIN is set
> 9) rx reads 64Kb, credit update is not sent due to *

Right, (free_space < VIRTIO_VSOCK_MAX_PKT_BUF_SIZE) is still false.

RX: buf_alloc = 256 KB; fwd_cnt = 196 KB; last_fwd_cnt = 0;
    free_space = 64 KB

> 10) rx does poll(), (rx_bytes < rcvlowat) 64Kb < 128Kb, rx waits in poll()

I agree that the TX is stuck because we are not sending the credit 
update, but also if RX sends the credit update at step 9, RX won't be 
woken up at step 10, right?

>
> * is optimization in 'virtio_transport_stream_do_dequeue()' which
>   sends OP_CREDIT_UPDATE only when we have not too much space -
>   less than VIRTIO_VSOCK_MAX_PKT_BUF_SIZE.
>
> Now tx side waits for space inside write() and rx waits in poll() for
> 'rx_bytes' to reach SO_RCVLOWAT value. Both sides will wait forever. I
> think, possible fix is to send credit update not only when we have too
> small space, but also when number of bytes in receive queue is smaller
> than SO_RCVLOWAT thus not enough to wake up sleeping reader. I'm not
> sure about correctness of this idea, but anyway - I think that problem
> above exists. What do You think?

I'm not sure, I have to think more about it, but if RX reads less than 
SO_RCVLOWAT, I expect it's normal to get to a case of stuck.

In this case we are only unstucking TX, but even if it sends that single 
byte, RX is still stuck and not consuming it, so it was useless to wake 
up TX if RX won't consume it anyway, right?

If RX woke up (e.g. SO_RCVLOWAT = 64KB) and read the remaining 64KB, 
then it would still send the credit update even without this patch and 
TX will send the 1 byte.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
