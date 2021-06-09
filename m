Return-Path: <SRS0=l8rc=LD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 283D8C47095
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 04:31:46 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9E070601FC
	for <virtualization@archiver.kernel.org>; Wed,  9 Jun 2021 04:31:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9E070601FC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5800740483;
	Wed,  9 Jun 2021 04:31:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id t-Gwh9P604kc; Wed,  9 Jun 2021 04:31:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 665684047F;
	Wed,  9 Jun 2021 04:31:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1867AC000E;
	Wed,  9 Jun 2021 04:31:43 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6B2BFC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 04:31:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4497960685
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 04:31:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nJp4j13r7C8H
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 04:31:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 12BBC60680
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Jun 2021 04:31:39 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 o17-20020a9d76510000b02903eabfc221a9so8964580otl.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Jun 2021 21:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=nv6jlx9/Svomx/AxcFIJu9iMF+P2oxdtyf1xVcyGy30=;
 b=09K8eZ+ZSojqiJwOflIaGwTIFujMu2Yqv918wLLuutbkPYmrOsLPOVx16wQcskDW7q
 VmYzfg63Ag6nq6Pke1By9WaIW1vWVdNxNAmkXnBMdvPZHU9QxbxeFZWvIS7dUL2m1Jqo
 lhLKHsP84LTDdAOzrgoJx+zxjylw11TScwEacoeWIjtTX/Rcr+uHClOwpyBWUTokkR7y
 gOENH7DN+ukdcswRLLiu6iSsse+RCV18a7WUIu3zQbKLk8OzbwGSO2dguqutdkky58S5
 mrTSeAAzmON+T4y2FBogLUC8+Y83js9j1y6bZO05oTYlADvlCz1knL8Pw6/fTJWxandk
 nCOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=nv6jlx9/Svomx/AxcFIJu9iMF+P2oxdtyf1xVcyGy30=;
 b=DWszp25ZpOuIYMN6SAx4ByW3emxM+jDHbeGn0uFKtck3YtL/leYWnepUqZJ2bBEI5l
 kjsK0wt1EfX/X+nanXJbgGhBRBcBe1PDBlgSxAyFFM5CEiHQOwlIW8E0M9BNKbFNl+rk
 jMDMaBCijmpVOtIkt+gdQyIzM1va8C1/SD+hJM/7w3n6GIGzxU6bxh5R4sODGqPIQhR5
 di2WVUeqsfSYqD1EoMbLgNUxi7ZOyMXZ+Ai8KD1ZyptI5OrQYq/XwSN6bAEnT/h4KxXt
 eKD5Dh2or7+LtcmzlC4wzZ32Ao38dX3MxJw4lW8OdJhcKmE48+cnuePhVgHJJjUwMD0i
 Tu4Q==
X-Gm-Message-State: AOAM530EEWitFY2cf0920OPAXi0sbpwLsYxT5vbOm4tUkqGsVgG/9F/F
 ByG0kB5jLLAkOCWlJXE0sjO+nBnhftDcXoSAZ/44jA==
X-Google-Smtp-Source: ABdhPJwIGH5j9h2IsJ8UY6N7JbaaqBtuU3NqyCl4pUtBexBPxbGU4O3LlHwFdDVDqOT/5mFwwWB2vvf8XsbFVxsfAZE=
X-Received: by 2002:a05:6830:2117:: with SMTP id
 i23mr13577999otc.279.1623213099070; 
 Tue, 08 Jun 2021 21:31:39 -0700 (PDT)
MIME-Version: 1.0
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
 <20210518130242.plnzg5mx7ljnhxig@steredhat>
 <CAP_N_Z9BccUvm=yuNd8694uhc_uF8f=0A0faTETBYF=R4=t7vQ@mail.gmail.com>
In-Reply-To: <CAP_N_Z9BccUvm=yuNd8694uhc_uF8f=0A0faTETBYF=R4=t7vQ@mail.gmail.com>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Tue, 8 Jun 2021 21:31:28 -0700
Message-ID: <CAP_N_Z9hKXKyf28Ve9U1O2DPACvbc4YdjNARL7brT01TuFtdBA@mail.gmail.com>
Subject: Re: Re: [RFC v2] virtio-vsock: add description for datagram type
To: Stefano Garzarella <sgarzare@redhat.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, May 18, 2021 at 9:59 PM Jiang Wang . <jiang.wang@bytedance.com> wrote:
>
> On Tue, May 18, 2021 at 6:02 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >
> > On Mon, May 17, 2021 at 11:33:06PM -0700, Jiang Wang . wrote:
> > >On Mon, May 17, 2021 at 4:02 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > >>
> > >> On Fri, May 14, 2021 at 11:55:29AM -0700, Jiang Wang . wrote:
> > >> >On Fri, May 14, 2021 at 8:17 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> > >> >> On Thu, May 13, 2021 at 04:26:03PM -0700, Jiang Wang . wrote:
> > >>
> > >> [...]
> > >>
> > >> >> >I see. I will add some limit to dgram packets. Also, when the
> > >> >> >virtqueues
> > >> >> >are shared between stream and dgram, both of them need to grab a lock
> > >> >> >before using the virtqueue, so one will not completely block another one.
> > >> >>
> > >> >> I'm not worried about the concurrent access that we definitely need to
> > >> >> handle with a lock, but more about the uncontrolled packet sending that
> > >> >> dgram might have, flooding the queues and preventing others from
> > >> >> communicating.
> > >> >
> > >> >That is a valid concern. Let me explain how I would handle that if we
> > >> >don't add two new virtqueues. For dgram, I also add a dgram_send_pkt_list,
> > >> >which is similar to send_pkt_list for stream (and seqpacket). But there
> > >> >is one difference. The dgram_send_pkt_list has a maximum size setting,
> > >> >and keep tracking how many pkts are in the list. The track number
> > >> >(dgram_send_pkt_list_size) is  increased when a packet is added
> > >> >to the list and is decreased when a packet
> > >> >is removed from the list and added to the virtqueue. In
> > >> >virtio_transport_send_pkt, if the current
> > >> >dgram_send_pkt_list_size is equal
> > >> >to the maximum ( let's say 128), then it will not add to the
> > >> >dgram_send_pkt_list and return an error to the application.
> > >>
> > >> For stream socket, we have the send_pkt_list and the send worker because
> > >> the virtqueue can be full and the transmitter needs to wait available
> > >> slots, because we can't discard packets.
> > >> For dgram I think we don't need this, so we can avoid the
> > >> dgram_send_pkt_list and directly enqueue packets in the virtqueue.
> > >>

For the question of whether we need dgram_send_pkt_list, I tried to remove
it and that has no problem with virtio vsock in the guest. But on the host, we
still need to keep the dgram_send_pkt_list. The reason is that we cannot
access virtqueue memory reliably in the syscall handling of an
arbitrary process.
The virtqueue memory is in the QEMU process virtual memory and may be
paged out.

> > >> If there are no slots available, we can simply drop the packet.
> > >> In this way we don't have to put limits other than the available space
> > >> in the virtqueue.
> > >
> > >I considered this approach before. One question not clear to me is
> > >whether we should call virtqueue_kick for every dgram packet. If I
> > >am not wrong, each virtqueue_kick will lead to a vm_exit to the host.
> > >If we call virtqueue_kick() for each dgram packet, the performance
> > >might be bad when there are lots of packets.
> >
> > Not every virtqueue_kick() will lead to a vm_exit. If the host (see
> > vhost_transport_do_send_pkt()) is handling the virtqueue, it disables
> > the notification through vhost_disable_notify().
>
> Got it.
>
> > >One idea is to set
> > >a threshold and a timer to call virtqueue_kick(). When there are
> > >lots of packets, we wait until a threshold. When there are few packets,
> > >the timer will make sure those packets will be delivered not too late.
> >
> > I think is better to keep the host polling a bit if we want to avoid
> > some notifications (see vhost_net_busy_poll()).
>
> Sure.
>
> > >
> > >Any other ideas for virtqueue_kick? If the threshold plus timer is fine,
> > >I can go this direction too.
> >
> > I think is better to follow vhost_net_busy_poll() approach.
>
> OK. I will follow vhost_net_busy_poll()
>
> > >
> > >> >
> > >> >In this way, the number of pending dgram pkts to be sent is limited.
> > >> >Then both stream and dgram sockets will compete to hold a lock
> > >> >for the tx virtqueue. Depending on the linux scheduler, this competition
> > >> >will be somewhat fair. As a result, dgram will not block stream completely.
> > >> >It will compete and share the virtqueue with stream, but stream
> > >> >can still send some pkts.
> > >> >
> > >> >Basically, the virtqueue becomes a first-come first-serve resource for
> > >> >the stream and dgram. When both stream and dgram applications
> > >> >have lots of data to send, dgram_send_pkt_list and send_pkt_list
> > >> >will still be a limited size, and each will have some chance to send out
> > >> >the data via virtqueue.  Does this address your concern?
> > >> >
> > >> >
> > >> >> So having 2 dedicated queues could avoid a credit mechanism at all for
> > >> >> connection-less sockets, and simply the receiver discards packets that
> > >> >> it can't handle.
> > >> >
> > >> >With 2 dedicated queues, we still need some kind of accounting for
> > >> >the dgram. Like the dgram_send_pkt_size I mentioned above.  Otherwise,
> > >> >it will cause OOM. It is not a real credit mechanism, but code is similar
> > >> >with or without 2 dedicated queues in my current prototype.
> > >>
> > >> I think in both cases we don't need an accounting, but we can drop
> > >> packets if the virtqueue is full.
> > >>
> > >> It's still not clear to me where OOM may occur. Can you elaborate on
> > >> this?
> > >
> > >OOM depending on the implementation details. If we keep
> > >dgram_send_pkt_list, and put no limitation,  it may increase indefinitely
> > >and cause OOM. As long as we have some limitations or drop packets
> > >quickly, then we should be fine.
> >
> > Sure, with the extra list we need some limitations.
> >
> > >
> > >> >
> > >> >For receiver discarding packets part, could you explain more? I think
> > >> >receiver discarding pkts code also is same with or without 2 dedicated
> > >> >queues.
> > >>
> > >> Yep.
> > >>
> > >> > Both will use can_enqueue = virtio_transport_inc_rx_pkt(vvs, pkt);
> > >> >to check if a packet should be discarded or not.
> > >>
> > >> I don't think we can use virtio_transport_inc_rx_pkt() for dgram.
> > >> This is based on the credit mechanism (e.g. buf_alloc) that works when
> > >> you have a connection oriented socket.
> > >>
> > >> With dgram you can have multiple transmitter for a single socket, so how
> > >> we can exchange that information?
> > >>
> > >In my view, we don't need to exchange that information. Buf_alloc for
> > >dgram is local to a receiving socket. The sending sockets do not know
> > >about that. For receiving socket, it just checks if there is still buffer
> > >available to decide to drop a packet or not. If multiple transmitter
> > >send to a single socket, they will share the same buf_alloc, and packets
> > >will be dropped randomly for those transmitters.
> >
> > I see, but if we reuse skbuff I think we don't need this.
> >
> > >
> > >> If we reuse the VMCI implementation with skbuff, the sk_receive_skb()
> > >> already checks if the sk_rcvbuf is full and discards the packet in
> > >> this
> > >> case, so we don't need an internal rx_queue.
> > >
> > >OK.
> > >
> > >> Maybe someday we should convert stream to skbuff too, it would make our
> > >> lives easier.
> > >>
> > >Yeah.  I remember the original virtio vsock patch did use skb, but somehow
> > >it  did not use skb anymore when merging to the upstream, not sure why.
> >
> > Really? I didn't know, then I'll take a look. If you have any links,
> > please send :-)
>
> No. I take it back. The skb is only used for dgram, not for stream
> sockets. Sorry for the confusion. The code I found is not in a easy-to-read
> format. Anyway, here is the link if you are interested:
>
> https://kvm.vger.kernel.narkive.com/BMvH9eEr/rfc-v2-0-7-introduce-vm-sockets-virtio-transport#post1
>
> btw: as major parts of the spec are kind of settled. I will send my current
> POC code to the mailing list just to have a reference and see if there are
> other major changes are needed. I will add to do's in the cover letter.
>
> Will update spec too.
>
>
> > Thanks,
> > Stefano
> >
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
