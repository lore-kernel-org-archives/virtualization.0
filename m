Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE5BBC77B61
	for <virtualization@archiver.kernel.org>; Mon,  1 May 2023 10:21:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 50160405E6;
	Mon,  1 May 2023 10:21:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 50160405E6
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=D49GZzgd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id UIXcTVTt91f2; Mon,  1 May 2023 10:21:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 72E6D400CC;
	Mon,  1 May 2023 10:21:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 72E6D400CC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 409BBC0037;
	Mon,  1 May 2023 10:21:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1DC96C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 10:21:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id E7D7681FC0
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 10:21:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E7D7681FC0
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=D49GZzgd
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HWDVsjIoFm4f
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 10:21:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5FFA081FBF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5FFA081FBF
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 May 2023 10:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682936459;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xqEYTLc79qp9oTPQxNKqZLuaG3/dvV631bV4KWP+w7E=;
 b=D49GZzgdH3Z7a2EX/fXuL7zDJ0NgpMqd5qeUPRQv2WJVL6jNQMAc8OTo9Qs/bM9qcgZ2ki
 7a3ZGQKvMiWqeS/ozIGmkLtB6qmMYuOHdnyXpE43HDmaJ857IleHLIB9i+EwINQgUrlaHf
 O13d90aqhAHoEWQF35kJh5ClG77UpuE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-96-lvWefpPhPTWXA2CP58OCyw-1; Mon, 01 May 2023 06:20:57 -0400
X-MC-Unique: lvWefpPhPTWXA2CP58OCyw-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f17b8d24bbso14177045e9.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 May 2023 03:20:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682936456; x=1685528456;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xqEYTLc79qp9oTPQxNKqZLuaG3/dvV631bV4KWP+w7E=;
 b=OARijXOttJNScTip7pC2a6v8ft9ELc90lMqU990iGr/sSvtIp9cl9GB+X0CQivv7Lx
 /iD2G4IGTyl45uCk4GBO/T1VLWHSLeM5/75xgSD21FTzwCyXpNuQjrbI+P57/SR+8CpT
 w9HMTLmgnX2JavB6+E2bkwDoFR/UrtCPnAO1t6DOSNOpOYUl08RnOEvM8/78i8xENKDr
 AlsMTYmaYEZ/y9Cp+ySzP1DVjbO7N4ksT5PG3E5TQVLGZq3K37v0550+o00e/ngahKMJ
 mSJj6+a0JdgD5a3+dZplL42DkC9LdTUVlyYziy/OJSnDCCMdxV7NVREMWrFbsAUkluzZ
 ZXRg==
X-Gm-Message-State: AC+VfDwz4YLc12h1m23wbrp9Go0E0iKuqkhAWU0ZjwaPvM7L7+pldx6l
 31E0ZOllRTVJ1PE1GeCl9PTUbArIZn3towNVk93uxISpey4c7Lb8SMrAG7YYNiaFUvukwKzhhO9
 2IEqEbWX5bGd+Ap1m8f2UpAwAt2YKHGWWKrFe1Ao8KQ==
X-Received: by 2002:a1c:ed0e:0:b0:3f2:5999:4f2b with SMTP id
 l14-20020a1ced0e000000b003f259994f2bmr9139285wmh.33.1682936456679; 
 Mon, 01 May 2023 03:20:56 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ72X1vR13VjjxYqG1HTUb+n8Z2asBncrr5dEu91cJ0Bd7PlhwGBobchaQrzQgj/VfvezvCgTA==
X-Received: by 2002:a1c:ed0e:0:b0:3f2:5999:4f2b with SMTP id
 l14-20020a1ced0e000000b003f259994f2bmr9139277wmh.33.1682936456371; 
 Mon, 01 May 2023 03:20:56 -0700 (PDT)
Received: from redhat.com ([2a06:c701:742c:c300:3695:a81b:6f0b:8940])
 by smtp.gmail.com with ESMTPSA id
 k6-20020a5d5186000000b003062b57ffd1sm3366770wrv.50.2023.05.01.03.20.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 May 2023 03:20:55 -0700 (PDT)
Date: Mon, 1 May 2023 06:20:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [RFC PATCH net 2/3] virtio-net: allow usage of vrings smaller
 than MAX_SKB_FRAGS + 2
Message-ID: <20230501061401-mutt-send-email-mst@kernel.org>
References: <20230430131518.2708471-1-alvaro.karsz@solid-run.com>
 <20230430131518.2708471-3-alvaro.karsz@solid-run.com>
 <20230430093009-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723043772ACAF516D6BFA79D4699@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4723043772ACAF516D6BFA79D4699@AM0PR04MB4723.eurprd04.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
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

On Sun, Apr 30, 2023 at 06:54:08PM +0000, Alvaro Karsz wrote:
> > > At the moment, if a network device uses vrings with less than
> > > MAX_SKB_FRAGS + 2 entries, the device won't be functional.
> > >
> > > The following condition vq->num_free >= 2 + MAX_SKB_FRAGS will always
> > > evaluate to false, leading to TX timeouts.
> > >
> > > This patch introduces a new variable, single_pkt_max_descs, that holds
> > > the max number of descriptors we may need to handle a single packet.
> > >
> > > This patch also detects the small vring during probe, blocks some
> > > features that can't be used with small vrings, and fails probe,
> > > leading to a reset and features re-negotiation.
> > >
> > > Features that can't be used with small vrings:
> > > GRO features (VIRTIO_NET_F_GUEST_*):
> > > When we use small vrings, we may not have enough entries in the ring to
> > > chain page size buffers and form a 64K buffer.
> > > So we may need to allocate 64k of continuous memory, which may be too
> > > much when the system is stressed.
> > >
> > > This patch also fixes the MTU size in small vring cases to be up to the
> > > default one, 1500B.
> > 
> > and then it should clear VIRTIO_NET_F_MTU?
> > 
> 
> Following [1], I was thinking to accept the feature and a let the device figure out that it can't transmit a big packet, since the RX buffers are not big enough (without VIRTIO_NET_F_MRG_RXBUF).
> But, I think that we may need to block the MTU feature after all.
> Quoting the spec:
> 
> A driver SHOULD negotiate VIRTIO_NET_F_MTU if the device offers it.
> If the driver negotiates VIRTIO_NET_F_MTU, it MUST supply enough receive buffers to receive at least one receive packet of size mtu (plus low level ethernet header length) with gso_type NONE or ECN.
> 
> So, if VIRTIO_NET_F_MTU is negotiated, we MUST supply enough receive buffers.
> So I think that blocking VIRTIO_NET_F_MTU  should be the way to go, If mtu > 1500.
> 
> [1] https://lore.kernel.org/lkml/20230417031052-mutt-send-email-mst@kernel.org/


First up to 4k should not be a problem. Even jumbo frames e.g. 9k
is highly likely to succeed. And a probe time which is often boot
even 64k isn't a problem ...

Hmm. We could allocate large buffers at probe time. Reuse them and
copy data over.

IOW reusing  GOOD_COPY_LEN flow for this case.  Not yet sure how I feel
about this. OTOH it removes the need for the whole feature blocking
approach, does it not?
WDYT?


> > > +     /* How many ring descriptors we may need to transmit a single packet */
> > > +     u16 single_pkt_max_descs;
> > > +
> > > +     /* Do we have virtqueues with small vrings? */
> > > +     bool svring;
> > > +
> > >       /* CPU hotplug instances for online & dead */
> > >       struct hlist_node node;
> > >       struct hlist_node node_dead;
> > 
> > worth checking that all these layout changes don't push useful things to
> > a different cache line. can you add that analysis?
> > 
> 
> Good point.
> I think that we can just move these to the bottom of the struct.
> 
> > 
> > I see confusiong here wrt whether some rings are "small"? all of them?
> > some rx rings? some tx rings? names should make it clear.
> 
> The small vring is a device attribute, not a vq attribute. It blocks features, which affects the entire device.
> Maybe we can call it "small vring mode".
> 
> > also do we really need bool svring? can't we just check single_pkt_max_descs
> > all the time?
> > 
> 
> We can work without the bool, we could always check if single_pkt_max_descs != MAX_SKB_FRAGS + 2.
> It doesn't really matter to me, I was thinking it may be more readable this way.
> 
> > > +static bool virtnet_uses_svring(struct virtnet_info *vi)
> > > +{
> > > +     u32 i;
> > > +
> > > +     /* If a transmit/receive virtqueue is small,
> > > +      * we cannot handle fragmented packets.
> > > +      */
> > > +     for (i = 0; i < vi->max_queue_pairs; i++) {
> > > +             if (IS_SMALL_VRING(virtqueue_get_vring_size(vi->sq[i].vq)) ||
> > > +                 IS_SMALL_VRING(virtqueue_get_vring_size(vi->rq[i].vq)))
> > > +                     return true;
> > > +     }
> > > +
> > > +     return false;
> > > +}
> > 
> > I see even if only some rings are too small we force everything to use
> > small ones. Wouldn't it be better to just disable small ones in this
> > case? That would not need a reset.
> > 
> 
> I'm not sure. It may complicate things.
> 
> What if all TX vqs are small?
> What if all RX vqs are small?
> What if we end up with an unbalanced number of TX vqs and RX vqs? is this allowed by the spec?
> What if we end up disabling the RX default vq (receiveq1)?
> 
> I guess we could do it, after checking some conditions.
> Maybe we can do it in a follow up patch?
> Do you think it's important for it to be included since day 1?
> 
> I think that the question is: what's more important, to use all the vqs while blocking some features, or to use part of the vqs without blocking features?
> 
> > > +
> > > +/* Function returns the number of features it blocked */
> > 
> > We don't need the # though. Make it bool?
> > 
> 
> Sure.
> 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
