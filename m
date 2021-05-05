Return-Path: <SRS0=Wmx8=KA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FCA7C433B4
	for <virtualization@archiver.kernel.org>; Wed,  5 May 2021 16:58:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5C8B610A7
	for <virtualization@archiver.kernel.org>; Wed,  5 May 2021 16:58:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5C8B610A7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5AED840535;
	Wed,  5 May 2021 16:58:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cxIyXt9xk99p; Wed,  5 May 2021 16:58:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id AA346404A0;
	Wed,  5 May 2021 16:58:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 82C78C000D;
	Wed,  5 May 2021 16:58:41 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81A7DC0001
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 16:58:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5A816404A0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 16:58:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5h9wgdW8-m4j
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 16:58:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1179F404D7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 May 2021 16:58:36 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id n184so2758462oia.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 May 2021 09:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=gHpA0twi8FI/74G8L25KSoNmqwrOz37Tgbxan+eRt4w=;
 b=zxLNg/YSuiJ5A6CcBScjK0IyCThs1Nbofaj31W/OejlteUu5UbC7wAjH3VViE/5NUB
 pTFZax3tAoaLzELrAnsGXejukf5JoABEnLYuqWqyg75c369TA44Iuhi24840NjwB5Hsg
 QFrsbxrQxQTaKRgITE2gghZMl1nrsdwHKnIf6ITkhWPlO0/F0HxQ4MuQQGMN3FMfFlgu
 Yz68z+tx+rKyyEOj22SFV+TaU07RGL5K4LZD8woBtg5wQlXB8rEZ8EjHan7pSwnAj4iJ
 zVowb9gp2ZYECq6HNYIgCcLw3drtESg4b2Rov7IXkkMnG4rIho4zrULEdV6UruIqhZPY
 KwQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=gHpA0twi8FI/74G8L25KSoNmqwrOz37Tgbxan+eRt4w=;
 b=WQt8x1KRwe58clypEF5m7TJXsqqJpUhuCB/BXHeGi7oU9xXtG0aFaVinHBXneOwifb
 4JYntkpWzVq5/07+qyTguGYediOicpZCq/kj7eZsvokIrfVK0xTkVbeM4Zj+DXmnOumj
 FiiGkczvsz0KfEzgNAKgy/cDzOjvVSxhrvxaQTQj0Hk5Kh7dQNz2QAmXkptFVS59+XjK
 RWu09xx/oE3kttZgDqnyEZm77z70Oe4nDuxNcXGR+Y82/ngzFwIZbVw4GQthP79WdQ/2
 NOccVzyHbcLHh7HFy0cywgfYrWUMt4hfpOgL+eJVfCrn4W1ibXo/yYNCYQ4o1WnVz8Us
 FlYg==
X-Gm-Message-State: AOAM533z+BKthM9xD/MJIXjMZH3oAFwbyB+xamcU5eTiTAOrIYqg1L2z
 IbUXFto+iRJbd6eYJKvgo4vuYQiOkHq+ZyjHYlaZwA==
X-Google-Smtp-Source: ABdhPJzzRdlH3rD8iKPy+VStqXH47QDx3C7C8pFFnFJsQt0KbWf/lrWNMBwKyndEa9CRqX8KV8ftgbsDmARwxYUd4nI=
X-Received: by 2002:a05:6808:1405:: with SMTP id
 w5mr22163254oiv.48.1620233915470; 
 Wed, 05 May 2021 09:58:35 -0700 (PDT)
MIME-Version: 1.0
References: <20210413094722-mutt-send-email-mst@kernel.org>
 <20210413140351.6vmffxqnj4azpyzx@steredhat>
 <20210413155635-mutt-send-email-mst@kernel.org>
 <20210414065706.inmjuoxsexejbbxj@steredhat>
 <20210414031220-mutt-send-email-mst@kernel.org>
 <20210414093841.koerx2wsmszv4nnj@steredhat>
 <CAP_N_Z85c+GLTmqBkMrRGQzWFj73i=FSiU-hAP7bEmaKTNnc6g@mail.gmail.com>
 <CAP_N_Z9xPgyf=au4VD+fXF8iorZHHk7Q4-CbJCOVUeupG4v4sw@mail.gmail.com>
 <20210504161651.3b6fhi64d7g3jui4@steredhat>
 <CAP_N_Z_cYjTCUpmLAW0xskUM_kAi=8e7iU8RXsMRnYWOxhA5OA@mail.gmail.com>
 <20210505104933.wgdn4gw56kle2mec@steredhat>
In-Reply-To: <20210505104933.wgdn4gw56kle2mec@steredhat>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Wed, 5 May 2021 09:58:24 -0700
Message-ID: <CAP_N_Z_DN+SYZ3E52HGdcmSfopBoNayKVzUdH7Nc2jUK5nfmLA@mail.gmail.com>
Subject: Re: Re: [RFC v2] virtio-vsock: add description for datagram type
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: cong.wang@bytedance.com, Xiongchun Duan <duanxiongchun@bytedance.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, cohuck@redhat.com,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 Stefan Hajnoczi <stefanha@redhat.com>, asias@redhat.com,
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

On Wed, May 5, 2021 at 3:49 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Tue, May 04, 2021 at 10:06:02AM -0700, Jiang Wang . wrote:
> >On Tue, May 4, 2021 at 9:16 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >>
> >> Hi Jiang,
> >>
> >> On Mon, May 03, 2021 at 08:40:46PM -0700, Jiang Wang . wrote:
> >> >Hi Stefano,
> >> >
> >> >I checked the VIRTIO_NET_F_MRG_RXBUF feature bit and I think vsock
> >> >dgram can use that feature too.
> >>
> >> Cool, thanks for checking!
> >
> >NP.
> >
> >> >Do we want to make this feature a must-have or optional? One idea is
> >> >to make it optional. When not
> >>
> >> I think optional is fine, and we should support it for all kind of
> >> traffic (stream, dgram, seqpacket).
> >
> >Got it. I was thinking only for dgram originally, but I think it should be fine
> >for stream and seqpacket too.
> >
> >Btw, I have a small implementation question. For now, the vsock
> >allocates rx buffers with two scatterlist. One for header and one for the
> >payload. After we enable VIRTIO_NET_F_MRG_RXBUF feature,
> >do we still want to allocate buffers like that? Or could we just use
> >one big scatterlist for the whole packet? I think using the same allocation
> >method is fine, but it just may not line up with the real packets well since
> >we will skip headers for the big packets except the first buffer.
>
> Good question.
>
> With mergeable buffer I think is better to remove the little buffer for
> the header in the scatterlist, this should also avoid to do two
> allocations per packet/buffer in the guest.

Got  it. Will do.

> >
> >> >supported, dgram rx buf is 16 KB which should be good in most cases.
> >>
> >> Why not 4 KB like for stream? Or we could make it configurable.
> >
> >OK. sure. 4 KB is fine with me. I mentioned 16 KB because I was thinking
> >jumbo frames in the ethernet world. But  I just found out the jumbo frame
> >is about 8 KB or 9 KB only.
> >
> >If we make it configurable, what kind of interface to use to configure it?
> >In linux, we could use something like the sysfs interface. I guess we don't
>
> Yes, something like that for the guest driver.

Got it.

> >need to specify that detail in the spec though. I will just put the size should
> >be configurable in the spec.
>
> Yeah, I remember that at some point we fixed an issue where the host
> always expected buffer of 4 KB.
>
> Now it should support any buffer sizes less or equal to 64 KB.
>
I see. I will if there is any issue with that.

> >
> >> >When VIRTIO_NET_F_MRG_RXBUF is supported, the rx buf is 4K and the max
> >> >packet size is 64 KB.
> >> >
> >> >Also, just to make sure we are on the same page, the current vsock
> >> >stream code can also split a
> >> >big packet to multiple buffers and the receive side can assemble them
> >> >together.
> >>
> >> Yes, sort of. Being a stream, there's no concept of a boundary.
> >>
> >> > But dgram cannot
> >> >use that code because the dgram may drop a buffer in the driver code
> >> >(if there is not enough space).
> >> >That means dgram may drop some buffers at the beginning, in the end or in the
> >> >middle of a pkt. And a packet may
> >> >not be received as a complete one. Therefore, we need something like
> >> >VIRTIO_NET_F_MRG_RXBUF.
> >>
> >> Yep.
> >>
> >> >
> >> >If we want to leverage current stream code without using
> >> >VIRTIO_NET_F_MRG_RXBUF,
> >> >we could add a total_len and offset to the virtio_vsock_hdr. Then when sending
> >> >packet, the device split the big packet to multiple small ones and
> >> >each has a header. They will have the
> >> >same total_len, but different offsets. On the driver side, the driver
> >> >can check the total_len before
> >> >enqueueing the big packet for the one with offset 0.
> >> >If there is enough space, all the remaining packets will be received.
> >> >If not, the remaining packets will be dropped.
> >> >I feel this implementation might be easier than using
> >> >VIRTIO_NET_F_MRG_RXBUF. But either one is fine with me.
> >> >Any preference? Thanks.
> >>
> >> This is very similar to what we discussed with Michael. He pointed
> >> out
> >> that it could be complicated and we could have several problems.
> >>
> >> For example, we should also provide an ID to prevent different
> >> fragments
> >> from overlapping. Also we might have problems handling different
> >> flows
> >> at the same time.
> >>
> >> Mergable buffers allow us to avoid these problems and also bring
> >> advantages for the other types of traffic (stream, seqpacket).
> >>
> >> It also allows us to use a single header for the packet and all its
> >> fragments.
> >>
> >> So IMHO, if there are no significant issues, the best way would be to
> >> implement mergeable buffers in vsock,
> >> I think there are only advantages to using this feature.
> >
> >Sure. Got it. I was thinking only about dgram, which is simpler than
> >stream and seqpacket. For those two, they will have issues as you
> >just mentioned.
> >
> >Also, just to make sure. For steam and seqpacket, supporting
> >mergeable buffers is mainly for performance improvements,
> >right? Or to save memory? I think functionally, they will be the
> >same with or without
> >mergeable buffers.
>
> Yes, right!
>
> > For dgram, the maximum supported packet size
> >is increased when using MRG_RXBUF if the rx buf size is fixed,
> >and it can save lots of memory.
> >
> >I am a little bit confused about the motivation to support mergeable
> >buffers for stream and seqpacket. Could you remind me again? Sorry
> >that if it was already mentioned in the old emails.
>
> We can save the header overhead, using a single header for the entire
> "big" packet.
>
> For example, in the current implementation, if the host has a 64KB
> buffer to send to the guest with a stream socket, must split it into 16
> packets, using a header for each fragment. With mergable buffers, we
> would save the extra header for each fragment by using a single initial
> header specifying the number of descriptors used.
>
OK. Sure.
> >
> >We could only support it on dgram since dgram has its own virtqueues.
>
> Maybe for the initial implementation is fine, then we can add support
> also for other types.
>
> Please, keep this in mind, so it will be easier to reuse it for other
> types.
>
Got it. Will do. Thanks for the suggestions and comments. I will
update the spec patch next.

> >
> >btw, my company email system automatically adds [External] to
> >these emails, and I meant to remove it manually when I reply,
> >but forgot to do that sometimes, so the email threading may not
> >be very accurate.
> >Sorry about that.
>
> Don't worry :-)
>
> Thanks,
> Stefano
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
