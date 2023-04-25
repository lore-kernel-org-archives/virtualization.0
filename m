Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7225C77B61
	for <virtualization@archiver.kernel.org>; Tue, 25 Apr 2023 12:33:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 60CAE81282;
	Tue, 25 Apr 2023 12:33:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 60CAE81282
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SdtUrury
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kkM7VOqEssOl; Tue, 25 Apr 2023 12:33:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id CD9A381257;
	Tue, 25 Apr 2023 12:33:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CD9A381257
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B168DC0036;
	Tue, 25 Apr 2023 12:33:42 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E70B1C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 12:33:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BF7184030C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 12:33:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BF7184030C
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SdtUrury
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ofQpDexykLZn
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 12:33:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 9D0E44030A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 9D0E44030A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 12:33:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682426018;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wUQt5lQEAzd3ahqHmV1QENMOzdVqzkRfQSadc2YBDxM=;
 b=SdtUrurypSbDFA/N2O4X9rVgdmfGJrpzr8TfN1M6d912DN8irMKCtYq42E/R26kEBUxMaQ
 r6+na99j3whceqHXwuQoc6z/nRrl127JVZcqQzALBcMxg48T5u5BRJ9m7J5wb232OAVvlE
 d0gZ7S0PjQ6rEda3ZUphKxJs1+K8ggs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-298-_tSZwAJlO7awrv_WpwM1TQ-1; Tue, 25 Apr 2023 08:33:36 -0400
X-MC-Unique: _tSZwAJlO7awrv_WpwM1TQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 5b1f17b1804b1-3f19517536eso16731325e9.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 05:33:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682426015; x=1685018015;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wUQt5lQEAzd3ahqHmV1QENMOzdVqzkRfQSadc2YBDxM=;
 b=adXpLKQPAZXMKAyXSzhCOLKNGZa0Sw3QsqbMSaqXZZslaxSZ+DJYvugTDZf8dqX6fr
 RXy4UKk5jKDox6L5LEOpjX6W54x071F37k362fw+8aDhPHbMp+Vj1yO3hNkdCuDc24kZ
 zTGU5S0SGfEE4XI/uT4Ow5x/KBsIIDIFO5pNGjLWKGi5MGcW8o/r9NPqfzgP4kv1Hm88
 R+xKKOfdyOcTJVk+9C357ef+7RSTi4ZxSUCUC6Brm5yo/mTihkWSimJHxpOwEGwDFDLq
 GEcxZB1ZUf0WALmuf0H2AXZck0SJw41OT+qJW1Dv6ykQ0rFGNt1vr2WL88UDQR0gEwC/
 5grQ==
X-Gm-Message-State: AAQBX9fy6H3WFdQWIBjHW4My3d36PSsnheEny8tKnuxT8fZj2Q3xD/Sp
 disWns6gDZmstFVtxj2atQjG7pfGXBpG5Hpnm83Tlr8jbxt8Jj4ot9Mk0FL+KvUqTHAE0nqkWCP
 HkgBCUjZZsRIMY/uoRlEoY0MfO790DSmisBSw76ftaA==
X-Received: by 2002:a1c:7707:0:b0:3f1:92e8:a6fe with SMTP id
 t7-20020a1c7707000000b003f192e8a6femr9788145wmi.31.1682426015464; 
 Tue, 25 Apr 2023 05:33:35 -0700 (PDT)
X-Google-Smtp-Source: AKy350bbwbXGwV35ZzB88SPcCWZhKgDOx1uFXZVk4jqEryiTgkP0rJUqoUzbI4IvWln0BbQKedDO+g==
X-Received: by 2002:a1c:7707:0:b0:3f1:92e8:a6fe with SMTP id
 t7-20020a1c7707000000b003f192e8a6femr9788133wmi.31.1682426015164; 
 Tue, 25 Apr 2023 05:33:35 -0700 (PDT)
Received: from redhat.com ([2.55.17.255]) by smtp.gmail.com with ESMTPSA id
 w9-20020a1cf609000000b003ede06f3178sm14890603wmc.31.2023.04.25.05.33.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Apr 2023 05:33:34 -0700 (PDT)
Date: Tue, 25 Apr 2023 08:33:31 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Message-ID: <20230425083212-mutt-send-email-mst@kernel.org>
References: <AM0PR04MB4723FA4F0FFEBD25903E3344D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417075645-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723FA90465186B5A8A5C001D4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230423031308-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47233B680283E892C45430BCD4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230423065132-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237D46ADE7954289025B66D4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230425041352-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723CE2A9B8BFA7963A66A98D4649@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <AM0PR04MB4723E09C948B92912C796BEAD4649@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4723E09C948B92912C796BEAD4649@AM0PR04MB4723.eurprd04.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
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

On Tue, Apr 25, 2023 at 11:11:54AM +0000, Alvaro Karsz wrote:
> > > So, let's add some funky flags in virtio device to block out
> > > features, have core compare these before and after,
> > > detect change, reset and retry?
> > 
> > In the virtnet case, we'll decide which features to block based on the ring size.
> > 2 < ring < MAX_FRAGS + 2  -> BLOCK GRO + MRG_RXBUF
> > ring < 2  -> BLOCK GRO + MRG_RXBUF + CTRL_VQ
> > 
> > So we'll need a new virtio callback instead of flags.
> > 
> > Furthermore, other virtio drivers may decide which features to block based on parameters different than ring size (I don't have a good example at the moment).
> > So maybe we should leave it to the driver to handle (during probe), > and offer a virtio core function to re-negotiate the features?
> > 
> > In the solution I'm working on, I expose a new virtio core function that resets the device and renegotiates the received features.
> > + A new virtio_config_ops callback peek_vqs_len to peek at the VQ lengths before calling find_vqs. (The callback must be called after the features negotiation)
> > 
> > So, the flow is something like:
> > 
> > * Super early in virtnet probe, we peek at the VQ lengths and decide if we are
> >    using small vrings, if so, we reset and renegotiate the features.
> > * We continue normally and create the VQs.
> > * We check if the created rings are small.
> >    If they are and some blocked features were negotiated anyway (may occur if
> >    the re-negotiation fails, or if the transport has no implementation for
> >    peek_vqs_len), we fail probe.
> 
> Small fix: if the re-negotiation fails, we fail probe immediately.
> The only way to negotiate blocked features with a small vring is if the transport has no implementation for peek_vqs_len.

with my idea, you can go iteratively: fail one condition, core will
retry with a feature blocked, we can block more, retry again.
up to 64 times :)

> >    If the ring is small and the features are ok, we mark the virtnet device as
> >    vring_small and fixup some variables.
> > 
> > 
> > peek_vqs_len is needed because we must know the VQ length before calling init_vqs.
> > 
> > During virtnet_find_vqs we check the following:
> > vi->has_cvq
> > vi->big_packets
> > vi->mergeable_rx_bufs
> > 
> > But these will change if the ring is small..
> > 
> > (Of course, another solution will be to re-negotiate features after init_vqs, but this will make a big mess, tons of things to clean and reconfigure)
> > 
> > 
> > The 2 < ring < MAX_FRAGS + 2 part is ready, I have tested a few cases and it is working.
> > 
> > I'm considering splitting the effort into 2 series.
> > A 2 < ring < MAX_FRAGS + 2  series, and a follow up series with the ring < 2 case.
> > 
> > I'm also thinking about sending the first series as an RFC soon, so it will be more broadly tested.
> > 
> > What do you think?
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
