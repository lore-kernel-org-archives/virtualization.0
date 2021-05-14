Return-Path: <SRS0=Tn2H=KJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA28AC433ED
	for <virtualization@archiver.kernel.org>; Fri, 14 May 2021 18:55:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EF4F613D6
	for <virtualization@archiver.kernel.org>; Fri, 14 May 2021 18:55:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EF4F613D6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E974183C7B;
	Fri, 14 May 2021 18:55:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9hX4-7h_kLxG; Fri, 14 May 2021 18:55:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7E00B83C56;
	Fri, 14 May 2021 18:55:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5207AC000E;
	Fri, 14 May 2021 18:55:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D5DB7C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 18:55:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id BAEB760E13
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 18:55:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=bytedance-com.20150623.gappssmtp.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1SA1I9gxkr7u
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 18:55:41 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x335.google.com (mail-ot1-x335.google.com
 [IPv6:2607:f8b0:4864:20::335])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 91AC660AEE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 18:55:41 +0000 (UTC)
Received: by mail-ot1-x335.google.com with SMTP id
 u25-20020a0568302319b02902ac3d54c25eso147500ote.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 14 May 2021 11:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Nqi0NKy59c1C9/2NDWBtm7xpu/p0Daohds+RwTh841A=;
 b=aY4hS4fFhP9AxpKFrhR58AtmGkXeeTABu1fIWYE50pEbCPNseMasprTY0GXveSUaOF
 iln2b8iqSLPx22VHsxXrtoY3cu9ae0QwJUIJ5FKrx3/UFxtIWQbngnWAVDSSt4IZi8Wg
 6MG8VsaLxphZ9prq8WyZLIVx2dgJvuNVv4HVY1jMTV3pcuefRgAVEism62XMSF+KBa8k
 V/hz7278B+9sW2A6FXa4C2iDpgyc4mNN0aMPDFmLiyxU8RAM6cziwFHvsb7poUWavFAm
 ZohqkoyhQkpMY8WyGf7TRK7Z/HqaNH++nAZ7xyXCK3zJ81qUS1pZyLiVDmjE6Y9m3E/l
 M5Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Nqi0NKy59c1C9/2NDWBtm7xpu/p0Daohds+RwTh841A=;
 b=tDz10zbLp86EzPMcVQlLcO4/WpfJLtHZ0bbiqq/q/bm+A74AHXouwlbL1ZHvLSo19L
 +YQ1gIeoRoryRFBVvgGzyeoMlrEvnpA1MMuSAMZaM1cYpad8Ncd4Vhf3lwZEV8ud6Btd
 cmDzT/7BbUCy+hf6b9B3u7NTzX74OoB7w3W+XdyvgdjNb4sKGp61cjem2OqKe/S4+PdZ
 a2MnO1FT68vKRNQoQOZECg/JXiGTDaWZF+2et5tvmUCtCh1s3KkwhDqeR+Gllw94Xpem
 GS2dIejedn6urB7SJHRBm2J6uYQfWTdczbkBe1vSUUK99dgRJnaAb+fUwcbp+7ULCGN8
 9gvA==
X-Gm-Message-State: AOAM530BmzysVmciiwqnOzujeSQXcnfwly8O4orH9kZx8GcZpZzPo9Bv
 F9dqsEDvMfaOeRADAueTp3T3du5vs8vPyv2sJeP78g==
X-Google-Smtp-Source: ABdhPJzBiV1eoKkmRrRWpTJWcFUg8mLtjhfiLIOUrifTeP/NgWwGqeqwpufbmn4cJ8aC3xFWt5X+MUd7gCgzfiGOtTg=
X-Received: by 2002:a05:6830:1594:: with SMTP id
 i20mr37884870otr.279.1621018540398; 
 Fri, 14 May 2021 11:55:40 -0700 (PDT)
MIME-Version: 1.0
References: <20210414093841.koerx2wsmszv4nnj@steredhat>
 <CAP_N_Z85c+GLTmqBkMrRGQzWFj73i=FSiU-hAP7bEmaKTNnc6g@mail.gmail.com>
 <CAP_N_Z9xPgyf=au4VD+fXF8iorZHHk7Q4-CbJCOVUeupG4v4sw@mail.gmail.com>
 <20210504161651.3b6fhi64d7g3jui4@steredhat>
 <CAP_N_Z_cYjTCUpmLAW0xskUM_kAi=8e7iU8RXsMRnYWOxhA5OA@mail.gmail.com>
 <20210505104933.wgdn4gw56kle2mec@steredhat>
 <CAP_N_Z_DN+SYZ3E52HGdcmSfopBoNayKVzUdH7Nc2jUK5nfmLA@mail.gmail.com>
 <CAP_N_Z9yZ4ydXaEn1e=70pDh3FyDjrrxgzis4YTfyDoZ5c8k+g@mail.gmail.com>
 <20210510145055.y7mxqaq4zggajz5a@steredhat>
 <CAP_N_Z94Pi4k8Dv6cHR0CZ9RTLJeQ3VWQoQgLTCWE4k+A01xbg@mail.gmail.com>
 <20210514151701.6fp27qanjseom4tl@steredhat>
In-Reply-To: <20210514151701.6fp27qanjseom4tl@steredhat>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Fri, 14 May 2021 11:55:29 -0700
Message-ID: <CAP_N_Z8CGx83D7yperR3OhMb-6YVrADxbZxocxSbpz9czKoO=w@mail.gmail.com>
Subject: Re: Re: [RFC v2] virtio-vsock: add description for datagram type
To: Stefano Garzarella <sgarzare@redhat.com>
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, May 14, 2021 at 8:17 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Thu, May 13, 2021 at 04:26:03PM -0700, Jiang Wang . wrote:
> >On Mon, May 10, 2021 at 7:52 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >> On Fri, May 07, 2021 at 09:53:19AM -0700, Jiang Wang . wrote:
>
> [...]
>
> >I was thinking if we don't add two new virtqueues, then maybe we don't
> >need to add new feature bit too? If the other end does not support
> >dgram, then the packets will be just dropped. What do you think? Do
> >we still need to add dgram feature bits? I can have a feature bit for
> >mergeable buffer.
>
> With seqpacket, where we reuse stream queues, we decided to add the new
> feature bit, so I guess we should do the same for dgram.
>
> In this way the driver knows if the protocol is supported and we can
> avoid for example to open a listening socket.

Sure. I will keep the feature bit.

> Without the feature bit this would not be possible. I mean, the sender
> will get an error, but the receiver will never know if it can receive or
> not.
>
> >> >What do you guys think? I remember Stefano mentioned that we should
> >> >add
> >> >two new virtqueues for dgram. Stefano, do you have some specific reasons
> >> >for that? Could we just keep using existing virtqueues? Thanks.
> >>
> >> My biggest concern was about the credit mechanism for datagrams. I mean
> >> avoiding datagrams from crowding the queue without limits, preventing
> >> streams from communicating.
> >>
> >> If you've found a way to limit datagram traffic, then maybe it's doable.
> >
> >I see. I will add some limit to dgram packets. Also, when the virtqueues
> >are shared between stream and dgram, both of them need to grab a lock
> >before using the virtqueue, so one will not completely block another one.
>
> I'm not worried about the concurrent access that we definitely need to
> handle with a lock, but more about the uncontrolled packet sending that
> dgram might have, flooding the queues and preventing others from
> communicating.

That is a valid concern. Let me explain how I would handle that if we
don't add two new virtqueues. For dgram, I also add a dgram_send_pkt_list,
which is similar to send_pkt_list for stream (and seqpacket). But there
is one difference. The dgram_send_pkt_list has a maximum size setting,
and keep tracking how many pkts are in the list. The track number
(dgram_send_pkt_list_size) is  increased when a packet is added
to the list and is decreased when a packet
is removed from the list and added to the virtqueue. In
virtio_transport_send_pkt, if the current
dgram_send_pkt_list_size is equal
to the maximum ( let's say 128), then it will not add to the
dgram_send_pkt_list and return an error to the application.

In this way, the number of pending dgram pkts to be sent is limited.
Then both stream and dgram sockets will compete to hold a lock
for the tx virtqueue. Depending on the linux scheduler, this competition
will be somewhat fair. As a result, dgram will not block stream completely.
It will compete and share the virtqueue with stream, but stream
can still send some pkts.

Basically, the virtqueue becomes a first-come first-serve resource for
the stream and dgram. When both stream and dgram applications
have lots of data to send, dgram_send_pkt_list and send_pkt_list
will still be a limited size, and each will have some chance to send out
the data via virtqueue.  Does this address your concern?


> So having 2 dedicated queues could avoid a credit mechanism at all for
> connection-less sockets, and simply the receiver discards packets that
> it can't handle.

With 2 dedicated queues, we still need some kind of accounting for
the dgram. Like the dgram_send_pkt_size I mentioned above.  Otherwise,
it will cause OOM. It is not a real credit mechanism, but code is similar
with or without 2 dedicated queues in my current prototype.

For receiver discarding packets part, could you explain more? I think
receiver discarding pkts code also is same with or without 2 dedicated
queues. Both will use can_enqueue = virtio_transport_inc_rx_pkt(vvs, pkt);
to check if a packet should be discarded or not.

Thanks,

Jiang

> Thanks,
> Stefano
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
