Return-Path: <SRS0=edzl=JL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE835C433B4
	for <virtualization@archiver.kernel.org>; Wed, 14 Apr 2021 09:38:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5DE6C61222
	for <virtualization@archiver.kernel.org>; Wed, 14 Apr 2021 09:38:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5DE6C61222
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2333D40167;
	Wed, 14 Apr 2021 09:38:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jWc8__8X2ogQ; Wed, 14 Apr 2021 09:38:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id A80474013E;
	Wed, 14 Apr 2021 09:38:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52B2DC000C;
	Wed, 14 Apr 2021 09:38:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D05FC000A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 09:38:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7BD358464A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 09:38:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Noleay1koqE9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 09:38:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 584A7845F9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 09:38:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618393129;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lalZc/1rI+lVJo0eVoE/lJp+eH10vNd++g6zak8QyqE=;
 b=G0/UkHKMbwvcHP6HK4bSxPhhYGrzxs1av83pMAHglLF1XhW9T4iL+xlLsS378GaKCqiUf/
 JuaJSlgYGRTi+cNjK7DG2qfuHg3Tb1cqZLGW+N+ftoK08sRo81hACnb39ALIWBkaLWrGQe
 tDIxFYwI18TfPq33uGqDb0uDHIJMItg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-578-XU-pLwYHOem-2zMTnbhcyg-1; Wed, 14 Apr 2021 05:38:46 -0400
X-MC-Unique: XU-pLwYHOem-2zMTnbhcyg-1
Received: by mail-ej1-f69.google.com with SMTP id cd13so258168ejb.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 14 Apr 2021 02:38:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lalZc/1rI+lVJo0eVoE/lJp+eH10vNd++g6zak8QyqE=;
 b=S/9LS1+WSRz5ge+NPZuiqJmcbTVHGk5cxNmfnGTNj5+RBAz5DWR9KC9lBuP/oQcLA2
 5s9nvlgDtyg0wdPxP4vN9lXj0u1Xro8dZcX4EJYFj5PN1JZ3eedi6D5PFyfA2TZk1JA3
 W3u+g6R1UNtuKzE0N6hDCy9p1wJ2/2E2dtSw/yOyaK8k83rvDt7SUwLv9Ld4M94yn5W4
 pfxkin/XM0frT7hVeHOjVLyMMRHOz6l0FA5hYuFZ+4ID5SOrHOjsmPdHWBNPXOKUEvyr
 EYe0pweHr2zc34QBBTLPAezd+GSiViWflr48Av4O4D6RnZA1CztE+WWiDr+nG5joc95e
 R4Vw==
X-Gm-Message-State: AOAM531OOyNw7bOh8Yrua4SLVQ4TbiSMm6I9/op9rbEF5yNSkpAQT4ZC
 45N/61mQUF/5vkmrIHwoH/vMw4DgcWcW/7eTojLX37K8AKm00y/m+/uUW+qOduux+n2qLfwnKtS
 MarG4lFjuUsiM676BX5fHBha8K7OgCPvRbRc5DLloKQ==
X-Received: by 2002:a17:906:6d12:: with SMTP id
 m18mr22031721ejr.435.1618393124760; 
 Wed, 14 Apr 2021 02:38:44 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzcFEOZlRdGAfhEv5zQ/EyqcpDT8X5SyssWtaqG6IyCSC68m8br91luE2LM+vWRfLVTQO26IQ==
X-Received: by 2002:a17:906:6d12:: with SMTP id
 m18mr22031703ejr.435.1618393124579; 
 Wed, 14 Apr 2021 02:38:44 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id e11sm7454837ejn.100.2021.04.14.02.38.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 14 Apr 2021 02:38:44 -0700 (PDT)
Date: Wed, 14 Apr 2021 11:38:41 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 "Jiang Wang ." <jiang.wang@bytedance.com>
Subject: Re: [RFC v2] virtio-vsock: add description for datagram type
Message-ID: <20210414093841.koerx2wsmszv4nnj@steredhat>
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
MIME-Version: 1.0
In-Reply-To: <20210414031220-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: cong.wang@bytedance.com, Xiongchun Duan <duanxiongchun@bytedance.com>,
 cohuck@redhat.com, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, Stefan Hajnoczi <stefanha@redhat.com>,
 asias@redhat.com, Arseny Krasnov <arseny.krasnov@kaspersky.com>
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

On Wed, Apr 14, 2021 at 03:20:07AM -0400, Michael S. Tsirkin wrote:
>On Wed, Apr 14, 2021 at 08:57:06AM +0200, Stefano Garzarella wrote:
>> On Tue, Apr 13, 2021 at 03:58:34PM -0400, Michael S. Tsirkin wrote:
>> > On Tue, Apr 13, 2021 at 04:03:51PM +0200, Stefano Garzarella wrote:
>> > > On Tue, Apr 13, 2021 at 09:50:45AM -0400, Michael S. Tsirkin wrote:
>> > > > On Tue, Apr 13, 2021 at 03:38:52PM +0200, Stefano Garzarella wrote:
>> > > > > On Tue, Apr 13, 2021 at 09:16:50AM -0400, Michael S. Tsirkin wrote:
>> > > > > > On Tue, Apr 13, 2021 at 02:58:53PM +0200, Stefano Garzarella wrote:
>> > > > > > > On Mon, Apr 12, 2021 at 03:42:23PM -0700, Jiang Wang . wrote:
>> > > > > > > > On Mon, Apr 12, 2021 at 7:21 AM Stefano Garzarella <sgarzare@redhat.com> wrote:
>> > > > > > > > >
>> > > > > > > > > On Mon, Apr 12, 2021 at 02:50:17PM +0100, Stefan Hajnoczi wrote:
>> > > > > > > > > >On Thu, Apr 01, 2021 at 04:36:02AM +0000, jiang.wang 
>> > > > > > > > > >wrote:

[...]

>> > > > > > > > > >>
>> > > > > > > > > >> +Datagram sockets provide connectionless unreliable messages of
>> > > > > > > > > >> +a fixed maximum length.
>> > > > > > > > > >
>> > > > > > > > > >Plus unordered (?) and with message boundaries. In other words:
>> > > > > > > > > >
>> > > > > > > > > >  Datagram sockets provide unordered, unreliable, connectionless message
>> > > > > > > > > >  with message boundaries and a fixed maximum length.
>> > > > > > > > > >
>> > > > > > > > > >I didn't think of the fixed maximum length aspect before. I guess the
>> > > > > > > > > >intention is that the rx buffer size is the message size limit? That's
>> > > > > > > > > >different from UDP messages, which can be fragmented into multiple IP
>> > > > > > > > > >packets and can be larger than 64KiB:
>> > > > > > > > > >https://en.wikipedia.org/wiki/User_Datagram_Protocol#UDP_datagram_structure
>> > > > > > > > > >
>> > > > > > > > > >Is it possible to support large datagram messages in vsock? I'm a little
>> > > > > > > > > >concerned that applications that run successfully over UDP will not be
>> > > > > > > > > >portable if vsock has this limitation because it would impose extra
>> > > > > > > > > >message boundaries that the application protocol might not tolerate.
>> > > > > > > > >
>> > > > > > > > > Maybe we can reuse the same approach Arseny is using for SEQPACKET.
>> > > > > > > > > Fragment the packets according to the buffers in the virtqueue and set
>> > > > > > > > > the EOR flag to indicate the last packet in the message.
>> > > > > > > > >
>> > > > > > > > Agree. Another option is to use the ones for skb since we may need to
>> > > > > > > > use skbs for multiple transport support anyway.
>> > > > > > > >
>> > > > > > >
>> > > > > > > The important thing I think is to have a single flag in virtio-vsock that
>> > > > > > > identifies pretty much the same thing: this is the last fragment of a series
>> > > > > > > to rebuild a packet.
>> > > > > > >
>> > > > > > > We should reuse the same flag for DGRAM and SEQPACKET.
>> > > > > > >
>> > > > > > > Thanks,
>> > > > > > > Stefano
>> > > > > >
>> > > > > > Well DGRAM can drop data so I wonder whether it can work ...
>> > > > > >
>> > > > >
>> > > > > Yep, this is true, but the channel should not be losing packets, so if the
>> > > > > receiver discards packets, it knows that it must then discard all of them
>> > > > > until the EOR.
>> > > >
>> > > > That is not so easy - they can come mixed up from multiple sources.
>> > >
>> > > I think we can prevent mixing because virtuqueue is point to point and its
>> > > use is not thread safe, so the access (in the same peer) is already
>> > > serialized.
>> > > In the end the packet would be fragmented only before copying it to the
>> > > virtuqueue.
>> > >
>> > > But maybe I missed something...
>> >
>> > Well I ask what's the point of fragmenting then. I assume it's so we
>> > can pass huge messages around so you can't keep locks ...
>> >
>>
>> Maybe I'm wrong, but isn't this similar to what we do in virtio-net with
>> mergeable buffers?
>
>The point of mergeable buffers is to use less memory: both for each
>packet and for a full receive vq.
>
>> Also in this case I think the fragmentation will happen only in the device,
>> since the driver can enqueue the entire buffer.
>>
>> Maybe we can reuse mergeable buffers for virtio-vsock if the EOR flag is not
>> suitable.
>
>That sounds very reasonable.

It should also allow us to save the header for each fragment.

@Jiang Do you want to explore this?
I'm talking about VIRTIO_NET_F_MRG_RXBUF feature.

>
>> IIUC in the vsock device the fragmentation for DGRAM will happen just 
>> before
>> to queue it in the virtqueue, and the device can check how many buffers are
>> available in the queue and it can decide whether to queue them all up or
>> throw them away.
>> >
>> > > > Sure linux net core does this but with fragmentation added in,
>> > > > I start wondering whether you are beginning to reinvent the net stack
>> > > > ...
>> > >
>> > > No, I hope not :-), in the end our advantage is that we have a channel that
>> > > doesn't lose packets, so I guess we can make assumptions that the network
>> > > stack can't.
>> > >
>> > > Thanks,
>> > > Stefano
>> >
>> > I still don't know how will credit accounting work for datagram,
>> > but proposals I saw seem to actually lose packets ...
>> >
>>
>> I still don't know too, but I think it's not an issue in the RX side,
>> since if it doesn't have space, can drop all the fragment.
>>
>> Another option to avoid fragmentation could be to allocate 64K buffers for
>> the new DGRAM virtqueue.
>
>That's a lot of buffers ...

Yep I see, and they would often be mostly unused...

>
>> In this way we will have at most 64K packets, which is similar to 
>> UDP/IP,
>> without extra work for the fragmentation.
>
>IIRC default MTU is 1280 not 64K ...

I was thinking that UDP at most can support 64K messages that IP should 
fragment according to MTU.

Thanks,
Stefano

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
