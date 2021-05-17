Return-Path: <SRS0=CgtS=KM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61649C433ED
	for <virtualization@archiver.kernel.org>; Mon, 17 May 2021 11:02:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DC1D4611CA
	for <virtualization@archiver.kernel.org>; Mon, 17 May 2021 11:02:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DC1D4611CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 933A9404A1;
	Mon, 17 May 2021 11:02:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 456wyZ4pgd9l; Mon, 17 May 2021 11:02:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTP id 208E640452;
	Mon, 17 May 2021 11:02:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7C4CC000D;
	Mon, 17 May 2021 11:02:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 115ECC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 11:02:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id D920083A0A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 11:02:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4uDoP81xLwUE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 11:02:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 796E882A2D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 11:02:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621249335;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=7cQMfiU/6CmbRXKnviF1ET7KvNhLtdTnWH8rwrQnGjk=;
 b=BbSERFzhI8DI8Od2aj7lzN2gNORjE252pNlyK8gX1TeJswFBUMEM3Wjpa5MwOsjdQZlASi
 tZ+uP8HbNIYWBH62xGjH6E3aV14rUBb0NjjwUB17IWL2GG3RCXEyvnf19tpktCMk+ZCr7t
 jEuoHQllxVe84sJA01sqA5f9VZ9BkVc=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-46-3Ijkpn5rOmiLiZ4trng2QA-1; Mon, 17 May 2021 07:02:13 -0400
X-MC-Unique: 3Ijkpn5rOmiLiZ4trng2QA-1
Received: by mail-ej1-f70.google.com with SMTP id
 y12-20020a170906558cb02903d65e5767ebso606038ejp.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 May 2021 04:02:13 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=7cQMfiU/6CmbRXKnviF1ET7KvNhLtdTnWH8rwrQnGjk=;
 b=Z5PLXWc7sk4cEx10FOFip/4emB5D8SzuP3yyR3g1LMqrxlP5wGj71foCeUdcrMRHUJ
 Q3zwYwxHA53GLB0h7/lqEPGu0PQqJCWlaYUxI0AiCKiF2Mr1aHf4i3FfZ4hv8861Ao4f
 nOhKiX/3VXgnI8q0NbEDtXaK4QGSOJkg8Q4sFoWk99HXJPQBM+tGwB988EXLZoctclAM
 HZpzzQE8J6fsRrTA1Fu1jyQVT4aWWb2gNYoUVHW3UG1syH9rMlmcATJ8MMFiQjR5rNit
 yF6jp2/fhdwJd4UqKcXTfPwG90cAIqn20Tp4n/KraIyD/8NohPBb1gkGsNuiUxfyJha8
 Gb4w==
X-Gm-Message-State: AOAM531GxAluXvtSTKd82J92HYrw7l624bmrrfzrgquTyEmDPCSd9YZX
 fuvIaKzYpPfsx39CDz+jFiFzD7ivVQwaLJW4NS2gn1zrm0Kl/wxaY/aIX+OWU2lfsqOuO16G0DD
 x8qjNLTtnuw0UKBER/L0kvCfTB4XnweWjaWSI1fIAoQ==
X-Received: by 2002:a17:907:161f:: with SMTP id
 hb31mr62383693ejc.514.1621249331457; 
 Mon, 17 May 2021 04:02:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzlg0uX670Nfd2xSHNOeeZACDhuQCkzpm5rVSLUkgqp/qwOPw8NC0DwyIZ6KIc9MSQkGFO98g==
X-Received: by 2002:a17:907:161f:: with SMTP id
 hb31mr62383670ejc.514.1621249331239; 
 Mon, 17 May 2021 04:02:11 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id t23sm6195213edq.74.2021.05.17.04.02.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 May 2021 04:02:10 -0700 (PDT)
Date: Mon, 17 May 2021 13:02:08 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Jiang Wang ." <jiang.wang@bytedance.com>
Subject: Re: [RFC v2] virtio-vsock: add description for datagram type
Message-ID: <20210517110208.lippuk4rv57cn6hj@steredhat>
References: <CAP_N_Z9xPgyf=au4VD+fXF8iorZHHk7Q4-CbJCOVUeupG4v4sw@mail.gmail.com>
 <20210504161651.3b6fhi64d7g3jui4@steredhat>
 <CAP_N_Z_cYjTCUpmLAW0xskUM_kAi=8e7iU8RXsMRnYWOxhA5OA@mail.gmail.com>
 <20210505104933.wgdn4gw56kle2mec@steredhat>
 <CAP_N_Z_DN+SYZ3E52HGdcmSfopBoNayKVzUdH7Nc2jUK5nfmLA@mail.gmail.com>
 <CAP_N_Z9yZ4ydXaEn1e=70pDh3FyDjrrxgzis4YTfyDoZ5c8k+g@mail.gmail.com>
 <20210510145055.y7mxqaq4zggajz5a@steredhat>
 <CAP_N_Z94Pi4k8Dv6cHR0CZ9RTLJeQ3VWQoQgLTCWE4k+A01xbg@mail.gmail.com>
 <20210514151701.6fp27qanjseom4tl@steredhat>
 <CAP_N_Z8CGx83D7yperR3OhMb-6YVrADxbZxocxSbpz9czKoO=w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP_N_Z8CGx83D7yperR3OhMb-6YVrADxbZxocxSbpz9czKoO=w@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: cong.wang@bytedance.com, Xiongchun Duan <duanxiongchun@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 Stefan Hajnoczi <stefanha@redhat.com>,
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

On Fri, May 14, 2021 at 11:55:29AM -0700, Jiang Wang . wrote:
>On Fri, May 14, 2021 at 8:17 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> On Thu, May 13, 2021 at 04:26:03PM -0700, Jiang Wang . wrote:

[...]

>> >I see. I will add some limit to dgram packets. Also, when the 
>> >virtqueues
>> >are shared between stream and dgram, both of them need to grab a lock
>> >before using the virtqueue, so one will not completely block another one.
>>
>> I'm not worried about the concurrent access that we definitely need to
>> handle with a lock, but more about the uncontrolled packet sending that
>> dgram might have, flooding the queues and preventing others from
>> communicating.
>
>That is a valid concern. Let me explain how I would handle that if we
>don't add two new virtqueues. For dgram, I also add a dgram_send_pkt_list,
>which is similar to send_pkt_list for stream (and seqpacket). But there
>is one difference. The dgram_send_pkt_list has a maximum size setting,
>and keep tracking how many pkts are in the list. The track number
>(dgram_send_pkt_list_size) is  increased when a packet is added
>to the list and is decreased when a packet
>is removed from the list and added to the virtqueue. In
>virtio_transport_send_pkt, if the current
>dgram_send_pkt_list_size is equal
>to the maximum ( let's say 128), then it will not add to the
>dgram_send_pkt_list and return an error to the application.

For stream socket, we have the send_pkt_list and the send worker because 
the virtqueue can be full and the transmitter needs to wait available 
slots, because we can't discard packets.

For dgram I think we don't need this, so we can avoid the 
dgram_send_pkt_list and directly enqueue packets in the virtqueue.

If there are no slots available, we can simply drop the packet.
In this way we don't have to put limits other than the available space 
in the virtqueue.

>
>In this way, the number of pending dgram pkts to be sent is limited.
>Then both stream and dgram sockets will compete to hold a lock
>for the tx virtqueue. Depending on the linux scheduler, this competition
>will be somewhat fair. As a result, dgram will not block stream completely.
>It will compete and share the virtqueue with stream, but stream
>can still send some pkts.
>
>Basically, the virtqueue becomes a first-come first-serve resource for
>the stream and dgram. When both stream and dgram applications
>have lots of data to send, dgram_send_pkt_list and send_pkt_list
>will still be a limited size, and each will have some chance to send out
>the data via virtqueue.  Does this address your concern?
>
>
>> So having 2 dedicated queues could avoid a credit mechanism at all for
>> connection-less sockets, and simply the receiver discards packets that
>> it can't handle.
>
>With 2 dedicated queues, we still need some kind of accounting for
>the dgram. Like the dgram_send_pkt_size I mentioned above.  Otherwise,
>it will cause OOM. It is not a real credit mechanism, but code is similar
>with or without 2 dedicated queues in my current prototype.

I think in both cases we don't need an accounting, but we can drop 
packets if the virtqueue is full.

It's still not clear to me where OOM may occur. Can you elaborate on 
this?

>
>For receiver discarding packets part, could you explain more? I think
>receiver discarding pkts code also is same with or without 2 dedicated
>queues.

Yep.

> Both will use can_enqueue = virtio_transport_inc_rx_pkt(vvs, pkt);
>to check if a packet should be discarded or not.

I don't think we can use virtio_transport_inc_rx_pkt() for dgram.
This is based on the credit mechanism (e.g. buf_alloc) that works when 
you have a connection oriented socket.

With dgram you can have multiple transmitter for a single socket, so how 
we can exchange that information?

If we reuse the VMCI implementation with skbuff, the sk_receive_skb() 
already checks if the sk_rcvbuf is full and discards the packet in this 
case, so we don't need an internal rx_queue.

Maybe someday we should convert stream to skbuff too, it would make our 
lives easier.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
