Return-Path: <SRS0=l8rc=LD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54A5FC47095
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 07:40:22 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0515A61364
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 07:40:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0515A61364
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C1CE5839C0;
	Wed,  9 Jun 2021 07:40:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 27MLdqHOKkJ0; Wed,  9 Jun 2021 07:40:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 5F95D83342;
	Wed,  9 Jun 2021 07:40:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2FEB4C000E;
	Wed,  9 Jun 2021 07:40:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32308C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 07:40:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1D71340168
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 07:40:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eox_1DX-BRfY
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 07:40:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4345F400D4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 07:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623224417;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MsKvXoYCnxoUejiwWiqJJmSyWN2Cpc7qfkppPMsYsyg=;
 b=OMHHTkGYbxx/dHAzbOWH5xGBUFDSD1N0Ll5t8Syvhoan+uFTNxOTJ8hH61sRSgjrRsdCG2
 YWkgtqHPcuUg2xW+8n7Z+ZbliXcasw30heS/Ya6lp3+TpP7gTy8h2y5VgEq1/Ydgg8uPJJ
 nOQFMgXVE4soAAgaTQj5oaaAcKOZm20=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-543-EWxAg7RWOYOvz37U3x7dSg-1; Wed, 09 Jun 2021 03:40:15 -0400
X-MC-Unique: EWxAg7RWOYOvz37U3x7dSg-1
Received: by mail-ed1-f69.google.com with SMTP id
 h23-20020aa7c5d70000b029038fed7b27d5so11943584eds.21
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Jun 2021 00:40:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MsKvXoYCnxoUejiwWiqJJmSyWN2Cpc7qfkppPMsYsyg=;
 b=oLtoqjid7m4Hv/zJKcd8EU8XTImCejDT0kK4PUL9ySVlxig7BMFAlfihyQT/v6sZPG
 BpKTA3OcscnVnicxoL2oxjzwFzmSqj9ulBfn/kkeVL6CITDyA2y/ezh5oJ7ZPOPLRSvw
 b4JMadgtIycGH0LWWUTOumMnWT71pN0y2jwL0hd0BeOAauJc8FDUtpCwfOVdCGyQ4Ris
 IJDsrKzVqcB/vS7MvOm7kao05x9bj+q3RO6IbMvr96KqkZS39f0dH1f4WLoOHIz8RBJa
 dll9tYzH4XR7DbHcSEfqD2Q7fvO0suPbfeAN0jywbG8fDWtxb2AdyZddmL8+UXAmUIyl
 3vHA==
X-Gm-Message-State: AOAM532qv0fZ7FXgGvF8xnSvTejTrrFWZLdV9v+J3PUk7dEDIEd//7gE
 lsca/4GG8ocyDJis2ZyP0OUrSWdORoQ00xg8KSScRdm8feXJajTJ3WYqqyI4OG7WPldGcyHQVZq
 +mJbrk9T3KTocEGRCL49B5J7gyJhX3/hyUSZL1F5AnA==
X-Received: by 2002:a05:6402:10cc:: with SMTP id
 p12mr29873042edu.328.1623224414501; 
 Wed, 09 Jun 2021 00:40:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw+y51hn2W4Jkx9Wl+NRmcoHSpnCWYSmDrNVmqhh+nyDRhURDblJiN5QkBuHtz29JViK5wUpQ==
X-Received: by 2002:a05:6402:10cc:: with SMTP id
 p12mr29873030edu.328.1623224414346; 
 Wed, 09 Jun 2021 00:40:14 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id n15sm782916eds.28.2021.06.09.00.40.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Jun 2021 00:40:13 -0700 (PDT)
Date: Wed, 9 Jun 2021 09:40:11 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Jiang Wang ." <jiang.wang@bytedance.com>
Subject: Re: [RFC v2] virtio-vsock: add description for datagram type
Message-ID: <20210609074011.at7wx2jxkquy7ykk@steredhat>
References: <CAP_N_Z9yZ4ydXaEn1e=70pDh3FyDjrrxgzis4YTfyDoZ5c8k+g@mail.gmail.com>
 <20210510145055.y7mxqaq4zggajz5a@steredhat>
 <CAP_N_Z94Pi4k8Dv6cHR0CZ9RTLJeQ3VWQoQgLTCWE4k+A01xbg@mail.gmail.com>
 <20210514151701.6fp27qanjseom4tl@steredhat>
 <CAP_N_Z8CGx83D7yperR3OhMb-6YVrADxbZxocxSbpz9czKoO=w@mail.gmail.com>
 <20210517110208.lippuk4rv57cn6hj@steredhat>
 <CAP_N_Z9hC7a4pKVP=MM1+Nk0fgNECTUfCB-at09mD9EpW03Ukg@mail.gmail.com>
 <20210518130242.plnzg5mx7ljnhxig@steredhat>
 <CAP_N_Z9BccUvm=yuNd8694uhc_uF8f=0A0faTETBYF=R4=t7vQ@mail.gmail.com>
 <CAP_N_Z9hKXKyf28Ve9U1O2DPACvbc4YdjNARL7brT01TuFtdBA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP_N_Z9hKXKyf28Ve9U1O2DPACvbc4YdjNARL7brT01TuFtdBA@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: cong.wang@bytedance.com, Xiongchun Duan <duanxiongchun@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org,
 Yongji Xie <xieyongji@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Arseny Krasnov <arseny.krasnov@kaspersky.com>
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

On Tue, Jun 08, 2021 at 09:31:28PM -0700, Jiang Wang . wrote:
>On Tue, May 18, 2021 at 9:59 PM Jiang Wang . <jiang.wang@bytedance.com> wrote:
>>
>> On Tue, May 18, 2021 at 6:02 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >
>> > On Mon, May 17, 2021 at 11:33:06PM -0700, Jiang Wang . wrote:
>> > >On Mon, May 17, 2021 at 4:02 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> > >>
>> > >> On Fri, May 14, 2021 at 11:55:29AM -0700, Jiang Wang . wrote:
>> > >> >On Fri, May 14, 2021 at 8:17 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> > >> >> On Thu, May 13, 2021 at 04:26:03PM -0700, Jiang Wang . wrote:
>> > >>
>> > >> [...]
>> > >>
>> > >> >> >I see. I will add some limit to dgram packets. Also, when the
>> > >> >> >virtqueues
>> > >> >> >are shared between stream and dgram, both of them need to grab a lock
>> > >> >> >before using the virtqueue, so one will not completely block another one.
>> > >> >>
>> > >> >> I'm not worried about the concurrent access that we definitely need to
>> > >> >> handle with a lock, but more about the uncontrolled packet sending that
>> > >> >> dgram might have, flooding the queues and preventing others from
>> > >> >> communicating.
>> > >> >
>> > >> >That is a valid concern. Let me explain how I would handle that if we
>> > >> >don't add two new virtqueues. For dgram, I also add a dgram_send_pkt_list,
>> > >> >which is similar to send_pkt_list for stream (and seqpacket). But there
>> > >> >is one difference. The dgram_send_pkt_list has a maximum size setting,
>> > >> >and keep tracking how many pkts are in the list. The track number
>> > >> >(dgram_send_pkt_list_size) is  increased when a packet is added
>> > >> >to the list and is decreased when a packet
>> > >> >is removed from the list and added to the virtqueue. In
>> > >> >virtio_transport_send_pkt, if the current
>> > >> >dgram_send_pkt_list_size is equal
>> > >> >to the maximum ( let's say 128), then it will not add to the
>> > >> >dgram_send_pkt_list and return an error to the application.
>> > >>
>> > >> For stream socket, we have the send_pkt_list and the send worker because
>> > >> the virtqueue can be full and the transmitter needs to wait available
>> > >> slots, because we can't discard packets.
>> > >> For dgram I think we don't need this, so we can avoid the
>> > >> dgram_send_pkt_list and directly enqueue packets in the virtqueue.
>> > >>
>
>For the question of whether we need dgram_send_pkt_list, I tried to remove
>it and that has no problem with virtio vsock in the guest. But on the host, we
>still need to keep the dgram_send_pkt_list. The reason is that we cannot
>access virtqueue memory reliably in the syscall handling of an
>arbitrary process.
>The virtqueue memory is in the QEMU process virtual memory and may be
>paged out.

I see, I think in that case we can use the virtqueue size as limit for 
the dgram_send_pkt_list.

I mean for example if the virtqueue has 128 elements, we can queue at 
least 128 packets in the dgram_send_pkt_list.

If you have a better idea go ahead, we can discuss this implementation 
detail in the RFC linux series :-)

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
