Return-Path: <SRS0=MByQ=KN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB006C433ED
	for <virtualization@archiver.kernel.org>; Tue, 18 May 2021 13:02:58 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6116561040
	for <virtualization@archiver.kernel.org>; Tue, 18 May 2021 13:02:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6116561040
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 01C6F842AD;
	Tue, 18 May 2021 13:02:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uEjwNPvc-0vE; Tue, 18 May 2021 13:02:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6062983FEE;
	Tue, 18 May 2021 13:02:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 289E3C000E;
	Tue, 18 May 2021 13:02:56 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0397EC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 May 2021 13:02:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DB91A84258
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 May 2021 13:02:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nmHgTEQ9zvJO
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 May 2021 13:02:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B08B583FEE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 May 2021 13:02:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621342972;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=dkVWaNGC8MziF5ac1Etkx1KERaCA64TYsVBiyHgXWxk=;
 b=gnDpVkGG/3T2XHtKfxQ6YXpTR31oSNZE1PenvksQnbMJvfBTy/m+pUQGHXovP8xzT2rhVM
 oin2y7pT/9vVwyUvabZZP5pWMxGD03CV3JJE/kpLaCOZz6hZzKXi0imHuRJrQ+U8IQwFvO
 uf9HLQoV0EV+vZ6L9s2zSOR1xEpcXsY=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-419-PbUYmaPdN12mSMzUZQSkeQ-1; Tue, 18 May 2021 09:02:48 -0400
X-MC-Unique: PbUYmaPdN12mSMzUZQSkeQ-1
Received: by mail-ed1-f70.google.com with SMTP id
 c21-20020a0564021015b029038c3f08ce5aso5752018edu.18
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 May 2021 06:02:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=dkVWaNGC8MziF5ac1Etkx1KERaCA64TYsVBiyHgXWxk=;
 b=AMAG4G7alrsRXARrX+o5p5gu5ez7w9Jwn8G1+IRgaTogjImeuSLmBcXDu6cHy+vAPH
 48IfrqtzcUj7FzLQ6wnk6ZF9DjPZ21n4aEZaxFpmaGhES+8a5ahQ+7tCV+5+zBgB/hQh
 psgUwkJ+ANqORmYqPBhM/e7SJ/qk0x4p1SeWoOOUFtL/NN2yN/ZydaqNfANZhyxu/uk+
 3gULnbriTlKBNEd/qZP0aoWNHDZxaMvwSk8CD0MS7yJTdGYQcN/vHdbU+aqTRCry/06z
 lGzwtFyyca+j8dYDKRF7r/7V7SHScEDo/A2mQ6XWBPKJTSoQ0WkTfpjANKcDzHE5Kmjq
 Zq0Q==
X-Gm-Message-State: AOAM530mFzMrCoIYYXyKHhaG+w568/+MMPLR8uj3wTFb48wi813iLncl
 m6+KbBAWEdl6WPInqgL1PG4z8RYDVapaIMmhN4/yR3XhJlbrN+lW4cAMbvduXCqcDAsIL7GwWZQ
 XhQ2BCy6Sl3SvIoiIuQW79v3WaQopMKXeRv4xZk8Z5A==
X-Received: by 2002:a17:906:b0c:: with SMTP id
 u12mr5820408ejg.37.1621342966127; 
 Tue, 18 May 2021 06:02:46 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy6avWM8D9LWp+w6WkYDJHdO0KbEHzelazXEspAjCVP1FviVJDfBDXRBU91OtSh+SK39QeMSQ==
X-Received: by 2002:a17:906:b0c:: with SMTP id
 u12mr5820384ejg.37.1621342965900; 
 Tue, 18 May 2021 06:02:45 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id cf19sm10404092ejb.24.2021.05.18.06.02.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 May 2021 06:02:45 -0700 (PDT)
Date: Tue, 18 May 2021 15:02:42 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Jiang Wang ." <jiang.wang@bytedance.com>
Subject: Re: [RFC v2] virtio-vsock: add description for datagram type
Message-ID: <20210518130242.plnzg5mx7ljnhxig@steredhat>
References: <CAP_N_Z_cYjTCUpmLAW0xskUM_kAi=8e7iU8RXsMRnYWOxhA5OA@mail.gmail.com>
 <20210505104933.wgdn4gw56kle2mec@steredhat>
 <CAP_N_Z_DN+SYZ3E52HGdcmSfopBoNayKVzUdH7Nc2jUK5nfmLA@mail.gmail.com>
 <CAP_N_Z9yZ4ydXaEn1e=70pDh3FyDjrrxgzis4YTfyDoZ5c8k+g@mail.gmail.com>
 <20210510145055.y7mxqaq4zggajz5a@steredhat>
 <CAP_N_Z94Pi4k8Dv6cHR0CZ9RTLJeQ3VWQoQgLTCWE4k+A01xbg@mail.gmail.com>
 <20210514151701.6fp27qanjseom4tl@steredhat>
 <CAP_N_Z8CGx83D7yperR3OhMb-6YVrADxbZxocxSbpz9czKoO=w@mail.gmail.com>
 <20210517110208.lippuk4rv57cn6hj@steredhat>
 <CAP_N_Z9hC7a4pKVP=MM1+Nk0fgNECTUfCB-at09mD9EpW03Ukg@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP_N_Z9hC7a4pKVP=MM1+Nk0fgNECTUfCB-at09mD9EpW03Ukg@mail.gmail.com>
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

On Mon, May 17, 2021 at 11:33:06PM -0700, Jiang Wang . wrote:
>On Mon, May 17, 2021 at 4:02 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>>
>> On Fri, May 14, 2021 at 11:55:29AM -0700, Jiang Wang . wrote:
>> >On Fri, May 14, 2021 at 8:17 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> >> On Thu, May 13, 2021 at 04:26:03PM -0700, Jiang Wang . wrote:
>>
>> [...]
>>
>> >> >I see. I will add some limit to dgram packets. Also, when the
>> >> >virtqueues
>> >> >are shared between stream and dgram, both of them need to grab a lock
>> >> >before using the virtqueue, so one will not completely block another one.
>> >>
>> >> I'm not worried about the concurrent access that we definitely need to
>> >> handle with a lock, but more about the uncontrolled packet sending that
>> >> dgram might have, flooding the queues and preventing others from
>> >> communicating.
>> >
>> >That is a valid concern. Let me explain how I would handle that if we
>> >don't add two new virtqueues. For dgram, I also add a dgram_send_pkt_list,
>> >which is similar to send_pkt_list for stream (and seqpacket). But there
>> >is one difference. The dgram_send_pkt_list has a maximum size setting,
>> >and keep tracking how many pkts are in the list. The track number
>> >(dgram_send_pkt_list_size) is  increased when a packet is added
>> >to the list and is decreased when a packet
>> >is removed from the list and added to the virtqueue. In
>> >virtio_transport_send_pkt, if the current
>> >dgram_send_pkt_list_size is equal
>> >to the maximum ( let's say 128), then it will not add to the
>> >dgram_send_pkt_list and return an error to the application.
>>
>> For stream socket, we have the send_pkt_list and the send worker because
>> the virtqueue can be full and the transmitter needs to wait available
>> slots, because we can't discard packets.
>>
>> For dgram I think we don't need this, so we can avoid the
>> dgram_send_pkt_list and directly enqueue packets in the virtqueue.
>>
>> If there are no slots available, we can simply drop the packet.
>> In this way we don't have to put limits other than the available space
>> in the virtqueue.
>
>I considered this approach before. One question not clear to me is
>whether we should call virtqueue_kick for every dgram packet. If I
>am not wrong, each virtqueue_kick will lead to a vm_exit to the host.
>If we call virtqueue_kick() for each dgram packet, the performance
>might be bad when there are lots of packets.

Not every virtqueue_kick() will lead to a vm_exit. If the host (see 
vhost_transport_do_send_pkt()) is handling the virtqueue, it disables 
the notification through vhost_disable_notify().

>One idea is to set
>a threshold and a timer to call virtqueue_kick(). When there are
>lots of packets, we wait until a threshold. When there are few packets,
>the timer will make sure those packets will be delivered not too late.

I think is better to keep the host polling a bit if we want to avoid 
some notifications (see vhost_net_busy_poll()).

>
>Any other ideas for virtqueue_kick? If the threshold plus timer is fine,
>I can go this direction too.

I think is better to follow vhost_net_busy_poll() approach.

>
>> >
>> >In this way, the number of pending dgram pkts to be sent is limited.
>> >Then both stream and dgram sockets will compete to hold a lock
>> >for the tx virtqueue. Depending on the linux scheduler, this competition
>> >will be somewhat fair. As a result, dgram will not block stream completely.
>> >It will compete and share the virtqueue with stream, but stream
>> >can still send some pkts.
>> >
>> >Basically, the virtqueue becomes a first-come first-serve resource for
>> >the stream and dgram. When both stream and dgram applications
>> >have lots of data to send, dgram_send_pkt_list and send_pkt_list
>> >will still be a limited size, and each will have some chance to send out
>> >the data via virtqueue.  Does this address your concern?
>> >
>> >
>> >> So having 2 dedicated queues could avoid a credit mechanism at all for
>> >> connection-less sockets, and simply the receiver discards packets that
>> >> it can't handle.
>> >
>> >With 2 dedicated queues, we still need some kind of accounting for
>> >the dgram. Like the dgram_send_pkt_size I mentioned above.  Otherwise,
>> >it will cause OOM. It is not a real credit mechanism, but code is similar
>> >with or without 2 dedicated queues in my current prototype.
>>
>> I think in both cases we don't need an accounting, but we can drop
>> packets if the virtqueue is full.
>>
>> It's still not clear to me where OOM may occur. Can you elaborate on
>> this?
>
>OOM depending on the implementation details. If we keep
>dgram_send_pkt_list, and put no limitation,  it may increase indefinitely
>and cause OOM. As long as we have some limitations or drop packets
>quickly, then we should be fine.

Sure, with the extra list we need some limitations.

>
>> >
>> >For receiver discarding packets part, could you explain more? I think
>> >receiver discarding pkts code also is same with or without 2 dedicated
>> >queues.
>>
>> Yep.
>>
>> > Both will use can_enqueue = virtio_transport_inc_rx_pkt(vvs, pkt);
>> >to check if a packet should be discarded or not.
>>
>> I don't think we can use virtio_transport_inc_rx_pkt() for dgram.
>> This is based on the credit mechanism (e.g. buf_alloc) that works when
>> you have a connection oriented socket.
>>
>> With dgram you can have multiple transmitter for a single socket, so how
>> we can exchange that information?
>>
>In my view, we don't need to exchange that information. Buf_alloc for
>dgram is local to a receiving socket. The sending sockets do not know
>about that. For receiving socket, it just checks if there is still buffer
>available to decide to drop a packet or not. If multiple transmitter
>send to a single socket, they will share the same buf_alloc, and packets
>will be dropped randomly for those transmitters.

I see, but if we reuse skbuff I think we don't need this.

>
>> If we reuse the VMCI implementation with skbuff, the sk_receive_skb()
>> already checks if the sk_rcvbuf is full and discards the packet in 
>> this
>> case, so we don't need an internal rx_queue.
>
>OK.
>
>> Maybe someday we should convert stream to skbuff too, it would make our
>> lives easier.
>>
>Yeah.  I remember the original virtio vsock patch did use skb, but somehow
>it  did not use skb anymore when merging to the upstream, not sure why.

Really? I didn't know, then I'll take a look. If you have any links, 
please send :-)

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
