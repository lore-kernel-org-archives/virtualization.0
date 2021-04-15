Return-Path: <SRS0=AynT=JM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C379C433B4
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 03:15:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 065B1611B0
	for <virtualization@archiver.kernel.org>; Thu, 15 Apr 2021 03:15:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 065B1611B0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=bytedance.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B85EB401CC;
	Thu, 15 Apr 2021 03:15:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pG7H1bi_vtJ5; Thu, 15 Apr 2021 03:15:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id 394E540003;
	Thu, 15 Apr 2021 03:15:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1072AC000C;
	Thu, 15 Apr 2021 03:15:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6D414C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 03:15:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 54276401CC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 03:15:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tfvD5iOD8q1P
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 03:15:49 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com
 [IPv6:2607:f8b0:4864:20::22a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EE62D40003
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Apr 2021 03:15:48 +0000 (UTC)
Received: by mail-oi1-x22a.google.com with SMTP id d12so22853133oiw.12
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 20:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=bytedance-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc; bh=Jm85JvwLMIcB2St9mVP1gl9ao7AfJpUNSERmY9e+tFw=;
 b=Ncc4hIHsAjrX8JDh/CcsPE5gLkwk97ngit/etruI/fVvsYrwa/u0ZT9VyVx1dwdJ9j
 P4e9LPlpBISrnaCvgcwHy1zXwTIgpYJIPgLX5a34gr2FvfgM5Sdg77keoC7PH4TBrtHz
 lI0CszHCIM6gjiUxTPNy2qfzE+n811yhqXax+Ga8IDBQzk9L3hnfrTdmFJuJ/dO4QWvF
 QHpdl8SF1oc1guYXT9mVRl1f+WIP8d4hVl3D27bQWF2cNq5Y5m5Zlon/P34zoZmqnn6u
 7G0csRKFRTVE7K+xIzAB8Wpa8rMKWHkNT5J8JiUh7/IivAanLFjXyFgYFJeLNVv+0UiY
 Eo7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Jm85JvwLMIcB2St9mVP1gl9ao7AfJpUNSERmY9e+tFw=;
 b=syr12YgaxVGPFJF/c5YAfBRHi7B1yvFS5UxrgPNrMyjs4RdLP6vNqyi0QWYKiuRQJA
 vn6DZ/b9WrR621nz7n2+PoIaCPVFJhzy+/b6D8mUoMRV8jM/aFjTlRvA0FQ9wb4DO1us
 8dowW4jR+FWDi3o2MqLd34uGrjXIohhqqfUssif4yd3CwC3rASU/hJZFFLxy2MI+GUoy
 7PRYWGAVXqWjdifVpKl7QBS1Rmwj/Jo42PbtAxC1XuFvjM5nFPj716NcLcLz/fJdydEg
 ZigpzCsiVvlYEKdyoNrxzjrUmd9917HlWcaKpQXyP665TFXMsoLVZ9MV6QEmdor0SVen
 dylw==
X-Gm-Message-State: AOAM5308be84u6nzODqkkfxQoE/rOd/VcWJL62cFbWMvEI5m0goQSdQB
 W0q1BGMq1/5VC+ljsE3epbQKN//nsb2LHGR5RibYzw==
X-Google-Smtp-Source: ABdhPJy7SfHUdm7SlhQs2UTK06u9WnH5fcYTfR/gHL93YlRodn+c+hiLzH+01tC5CZHWETq8uCIzCLBu6KSKdZgpl+U=
X-Received: by 2002:aca:af4b:: with SMTP id y72mr997390oie.97.1618456547623;
 Wed, 14 Apr 2021 20:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <20210412142133.t44pn5pjy6fdcvk4@steredhat>
 <CAP_N_Z9VPkBKX9QD+cuzSSAn6dL0cpQ=EZs5vk+ByjjDpGgdBA@mail.gmail.com>
 <20210413125853.2dkldmp23vkkc74c@steredhat>
 <20210413091251-mutt-send-email-mst@kernel.org>
 <20210413133852.ebkrlbyetiqu4uje@steredhat>
 <20210413094722-mutt-send-email-mst@kernel.org>
 <20210413140351.6vmffxqnj4azpyzx@steredhat>
 <20210413155635-mutt-send-email-mst@kernel.org>
 <20210414065706.inmjuoxsexejbbxj@steredhat>
 <20210414031220-mutt-send-email-mst@kernel.org>
 <20210414093841.koerx2wsmszv4nnj@steredhat>
In-Reply-To: <20210414093841.koerx2wsmszv4nnj@steredhat>
From: "Jiang Wang ." <jiang.wang@bytedance.com>
Date: Wed, 14 Apr 2021 20:15:36 -0700
Message-ID: <CAP_N_Z85c+GLTmqBkMrRGQzWFj73i=FSiU-hAP7bEmaKTNnc6g@mail.gmail.com>
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

On Wed, Apr 14, 2021 at 2:38 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>
> On Wed, Apr 14, 2021 at 03:20:07AM -0400, Michael S. Tsirkin wrote:
> >On Wed, Apr 14, 2021 at 08:57:06AM +0200, Stefano Garzarella wrote:
> >> On Tue, Apr 13, 2021 at 03:58:34PM -0400, Michael S. Tsirkin wrote:
> >> > On Tue, Apr 13, 2021 at 04:03:51PM +0200, Stefano Garzarella wrote:
> >> > > On Tue, Apr 13, 2021 at 09:50:45AM -0400, Michael S. Tsirkin wrote:
> >> > > > On Tue, Apr 13, 2021 at 03:38:52PM +0200, Stefano Garzarella wrote:
> >> > > > > On Tue, Apr 13, 2021 at 09:16:50AM -0400, Michael S. Tsirkin wrote:
> >> > > > > > On Tue, Apr 13, 2021 at 02:58:53PM +0200, Stefano Garzarella wrote:
> >> > > > > > > On Mon, Apr 12, 2021 at 03:42:23PM -0700, Jiang Wang . wrote:
> >> > > > > > > > On Mon, Apr 12, 2021 at 7:21 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
> >> > > > > > > > >
> >> > > > > > > > > On Mon, Apr 12, 2021 at 02:50:17PM +0100, Stefan Hajnoczi wrote:
> >> > > > > > > > > >On Thu, Apr 01, 2021 at 04:36:02AM +0000, jiang.wang
> >> > > > > > > > > >wrote:
>
> [...]
>
> >> > > > > > > > > >>
> >> > > > > > > > > >> +Datagram sockets provide connectionless unreliable messages of
> >> > > > > > > > > >> +a fixed maximum length.
> >> > > > > > > > > >
> >> > > > > > > > > >Plus unordered (?) and with message boundaries. In other words:
> >> > > > > > > > > >
> >> > > > > > > > > >  Datagram sockets provide unordered, unreliable, connectionless message
> >> > > > > > > > > >  with message boundaries and a fixed maximum length.
> >> > > > > > > > > >
> >> > > > > > > > > >I didn't think of the fixed maximum length aspect before. I guess the
> >> > > > > > > > > >intention is that the rx buffer size is the message size limit? That's
> >> > > > > > > > > >different from UDP messages, which can be fragmented into multiple IP
> >> > > > > > > > > >packets and can be larger than 64KiB:
> >> > > > > > > > > >https://en.wikipedia.org/wiki/User_Datagram_Protocol#UDP_datagram_structure
> >> > > > > > > > > >
> >> > > > > > > > > >Is it possible to support large datagram messages in vsock? I'm a little
> >> > > > > > > > > >concerned that applications that run successfully over UDP will not be
> >> > > > > > > > > >portable if vsock has this limitation because it would impose extra
> >> > > > > > > > > >message boundaries that the application protocol might not tolerate.
> >> > > > > > > > >
> >> > > > > > > > > Maybe we can reuse the same approach Arseny is using for SEQPACKET.
> >> > > > > > > > > Fragment the packets according to the buffers in the virtqueue and set
> >> > > > > > > > > the EOR flag to indicate the last packet in the message.
> >> > > > > > > > >
> >> > > > > > > > Agree. Another option is to use the ones for skb since we may need to
> >> > > > > > > > use skbs for multiple transport support anyway.
> >> > > > > > > >
> >> > > > > > >
> >> > > > > > > The important thing I think is to have a single flag in virtio-vsock that
> >> > > > > > > identifies pretty much the same thing: this is the last fragment of a series
> >> > > > > > > to rebuild a packet.
> >> > > > > > >
> >> > > > > > > We should reuse the same flag for DGRAM and SEQPACKET.
> >> > > > > > >
> >> > > > > > > Thanks,
> >> > > > > > > Stefano
> >> > > > > >
> >> > > > > > Well DGRAM can drop data so I wonder whether it can work ...
> >> > > > > >
> >> > > > >
> >> > > > > Yep, this is true, but the channel should not be losing packets, so if the
> >> > > > > receiver discards packets, it knows that it must then discard all of them
> >> > > > > until the EOR.
> >> > > >
> >> > > > That is not so easy - they can come mixed up from multiple sources.
> >> > >
> >> > > I think we can prevent mixing because virtuqueue is point to point and its
> >> > > use is not thread safe, so the access (in the same peer) is already
> >> > > serialized.
> >> > > In the end the packet would be fragmented only before copying it to the
> >> > > virtuqueue.
> >> > >
> >> > > But maybe I missed something...
> >> >
> >> > Well I ask what's the point of fragmenting then. I assume it's so we
> >> > can pass huge messages around so you can't keep locks ...
> >> >
> >>
> >> Maybe I'm wrong, but isn't this similar to what we do in virtio-net with
> >> mergeable buffers?
> >
> >The point of mergeable buffers is to use less memory: both for each
> >packet and for a full receive vq.
> >
> >> Also in this case I think the fragmentation will happen only in the device,
> >> since the driver can enqueue the entire buffer.
> >>
> >> Maybe we can reuse mergeable buffers for virtio-vsock if the EOR flag is not
> >> suitable.
> >
> >That sounds very reasonable.
>
> It should also allow us to save the header for each fragment.
>
> @Jiang Do you want to explore this?
> I'm talking about VIRTIO_NET_F_MRG_RXBUF feature.

Sure. Will do.

> >
> >> IIUC in the vsock device the fragmentation for DGRAM will happen just
> >> before
> >> to queue it in the virtqueue, and the device can check how many buffers are
> >> available in the queue and it can decide whether to queue them all up or
> >> throw them away.
> >> >
> >> > > > Sure linux net core does this but with fragmentation added in,
> >> > > > I start wondering whether you are beginning to reinvent the net stack
> >> > > > ...
> >> > >
> >> > > No, I hope not :-), in the end our advantage is that we have a channel that
> >> > > doesn't lose packets, so I guess we can make assumptions that the network
> >> > > stack can't.
> >> > >
> >> > > Thanks,
> >> > > Stefano
> >> >
> >> > I still don't know how will credit accounting work for datagram,
> >> > but proposals I saw seem to actually lose packets ...
> >> >
> >>
> >> I still don't know too, but I think it's not an issue in the RX side,
> >> since if it doesn't have space, can drop all the fragment.
> >>
> >> Another option to avoid fragmentation could be to allocate 64K buffers for
> >> the new DGRAM virtqueue.
> >
> >That's a lot of buffers ...
>
> Yep I see, and they would often be mostly unused...
>
> >
> >> In this way we will have at most 64K packets, which is similar to
> >> UDP/IP,
> >> without extra work for the fragmentation.
> >
> >IIRC default MTU is 1280 not 64K ...
>
> I was thinking that UDP at most can support 64K messages that IP should
> fragment according to MTU.
>
> Thanks,
> Stefano
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
