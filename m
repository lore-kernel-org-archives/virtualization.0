Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E762FC6FD18
	for <virtualization@archiver.kernel.org>; Tue, 25 Apr 2023 12:32:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 62E804081F;
	Tue, 25 Apr 2023 12:32:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 62E804081F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YoL28ba0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id So3IF71Zsk6l; Tue, 25 Apr 2023 12:32:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 72C9740512;
	Tue, 25 Apr 2023 12:32:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 72C9740512
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4FEE7C0036;
	Tue, 25 Apr 2023 12:32:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B77EC002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 12:32:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DA61F81FB2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 12:32:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DA61F81FB2
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YoL28ba0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6WuCZfHg4xEH
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 12:32:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 78EB881FAF
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 78EB881FAF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 12:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682425921;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xUCCLfKIJcIMQQC1+iJEFgXpJl2oC+XHJLW7QTm0PdU=;
 b=YoL28ba05koO80K6LURlUTxgFY7nm+2OT6PeWfy93lNqLP/tP3tOC/aiUaymEQk0rmRpWU
 ctAvICSpQFzIy9oAqrIysTqThJm98f+mdRDgDOdAwThSM6gUDqYSbotkCZTh7PXR97yDQH
 nfkvpz8OmTLQFIZlmmDpmf9PInW8hcw=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-43-OADKLTFvM3yjuMZn5dA-JA-1; Tue, 25 Apr 2023 08:32:00 -0400
X-MC-Unique: OADKLTFvM3yjuMZn5dA-JA-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-2fbb99cb244so3208519f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 05:31:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682425919; x=1685017919;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=xUCCLfKIJcIMQQC1+iJEFgXpJl2oC+XHJLW7QTm0PdU=;
 b=hdAYLP1XvQSc+uN8fp9+P5fwvpJ/rIdJcCqr2Dy2k/2h/RnE4JIPKJwdNXdIAYnJDd
 kEowuX6LUEKS19Yw9H/DF0Di9VHgA7MaLAjzzj0SVCY9d9N0DNwAbGWYsbxpdmAXifFK
 qBfXrCt6gGt8pJczJUe1fBTpXAN8vsjeNda8AgqVUAGnrQMQa01VvXdT6LLB99sjoiFR
 qCdrxe/oyxp5999HrWdcAxMeCFsQRL7mZcbG2agIxgoRCCA7V83yN5ACLe7nxJdXMzYP
 8qah40NNiOYKFd8ZORAURmfRZ4U3Kxlf2H2vrSwOYO7tKn78Oh/zc7QxjS4l5dtdm/Hx
 9m/w==
X-Gm-Message-State: AAQBX9d0StdctKikHGfdcvBMbzCB2IvipUeh0vBagwXpARQMsgPZ0ny2
 +GE5kyL7mglwEsk5ysHWDekpglw3jnU45grvs9YolwUZ/e5kDhjAIBQDJ+HJtzWmmgTqgO0JAFz
 v3SS29v/EA0VclcN4aBiaJTuA772r/gByp2IqPS3HTw==
X-Received: by 2002:adf:ffcf:0:b0:301:8551:446a with SMTP id
 x15-20020adfffcf000000b003018551446amr12600275wrs.2.1682425918926; 
 Tue, 25 Apr 2023 05:31:58 -0700 (PDT)
X-Google-Smtp-Source: AKy350YNPM6rmdz9nqud0Gs0uKp5JlWWQ13dR/vmTBC10HPYXJvjvSupNGyK5SYEMtOckP8U65WVkg==
X-Received: by 2002:adf:ffcf:0:b0:301:8551:446a with SMTP id
 x15-20020adfffcf000000b003018551446amr12600255wrs.2.1682425918573; 
 Tue, 25 Apr 2023 05:31:58 -0700 (PDT)
Received: from redhat.com ([2.55.17.255]) by smtp.gmail.com with ESMTPSA id
 a15-20020adfdd0f000000b003048d07f9absm1411810wrm.70.2023.04.25.05.31.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Apr 2023 05:31:57 -0700 (PDT)
Date: Tue, 25 Apr 2023 08:31:54 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Message-ID: <20230425082150-mutt-send-email-mst@kernel.org>
References: <20230417073830-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723FA4F0FFEBD25903E3344D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417075645-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723FA90465186B5A8A5C001D4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230423031308-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47233B680283E892C45430BCD4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230423065132-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237D46ADE7954289025B66D4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230425041352-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723CE2A9B8BFA7963A66A98D4649@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4723CE2A9B8BFA7963A66A98D4649@AM0PR04MB4723.eurprd04.prod.outlook.com>
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

On Tue, Apr 25, 2023 at 09:41:35AM +0000, Alvaro Karsz wrote:
> > So, let's add some funky flags in virtio device to block out
> > features, have core compare these before and after,
> > detect change, reset and retry?
> 
> In the virtnet case, we'll decide which features to block based on the ring size.
> 2 < ring < MAX_FRAGS + 2  -> BLOCK GRO + MRG_RXBUF
> ring < 2  -> BLOCK GRO + MRG_RXBUF + CTRL_VQ

why MRG_RXBUF? what does it matter?

> So we'll need a new virtio callback instead of flags.
> Furthermore, other virtio drivers may decide which features to block based on parameters different than ring size (I don't have a good example at the moment).
> So maybe we should leave it to the driver to handle (during probe), and offer a virtio core function to re-negotiate the features?
> 
> In the solution I'm working on, I expose a new virtio core function that resets the device and renegotiates the received features.
> + A new virtio_config_ops callback peek_vqs_len to peek at the VQ lengths before calling find_vqs. (The callback must be called after the features negotiation)
> 
> So, the flow is something like:
> 
> * Super early in virtnet probe, we peek at the VQ lengths and decide if we are 
>    using small vrings, if so, we reset and renegotiate the features.

Using which APIs? What does peek_vqs_len do and why does it matter that
it is super early?

> * We continue normally and create the VQs.
> * We check if the created rings are small.
>    If they are and some blocked features were negotiated anyway (may occur if 
>    the re-negotiation fails, or if the transport has no implementation for 
>    peek_vqs_len), we fail probe.
>    If the ring is small and the features are ok, we mark the virtnet device as 
>    vring_small and fixup some variables.
>  
> 
> peek_vqs_len is needed because we must know the VQ length before calling init_vqs.
> 
> During virtnet_find_vqs we check the following:
> vi->has_cvq
> vi->big_packets
> vi->mergeable_rx_bufs
> 
> But these will change if the ring is small..
> 
> (Of course, another solution will be to re-negotiate features after init_vqs, but this will make a big mess, tons of things to clean and reconfigure)
> 
> 
> The 2 < ring < MAX_FRAGS + 2 part is ready, I have tested a few cases and it is working.
> 
> I'm considering splitting the effort into 2 series.
> A 2 < ring < MAX_FRAGS + 2  series, and a follow up series with the ring < 2 case.
> 
> I'm also thinking about sending the first series as an RFC soon, so it will be more broadly tested.
> 
> What do you think?

Lots of work spilling over to transports.

And I especially don't like that it slows down boot on good path.

I have the following idea:
- add a blocked features value in virtio_device
- before calling probe, core saves blocked features
- if probe fails, checks blocked features.
  if any were added, reset, negotiate all features
  except blocked ones and do the validate/probe dance again


This will mean mostly no changes to drivers: just check condition,
block feature and fail probe.


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
