Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8C049C77B61
	for <virtualization@archiver.kernel.org>; Tue, 25 Apr 2023 08:35:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id F1E69405A6;
	Tue, 25 Apr 2023 08:35:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F1E69405A6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SnrKdbHK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZvNkwveNPWyo; Tue, 25 Apr 2023 08:35:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3584A40510;
	Tue, 25 Apr 2023 08:35:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3584A40510
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F16AAC0036;
	Tue, 25 Apr 2023 08:35:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5051C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 08:35:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9237040328
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 08:35:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9237040328
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=SnrKdbHK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QWimQwxQ9ViF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 08:35:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ADF144026A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id ADF144026A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 08:35:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682411705;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=12yPNwee6eKmLgy6pNQQ5971cnoVK8ZLgf7UFS2TwrU=;
 b=SnrKdbHK1WzgQpXjmh5e4SGPv2zOrzIuNUB8NduF/PnFAN/WVfvXuJcqNHfdvEHE2jop1Z
 n/c2C0SdUsWkuCqumf4gDc7l/GGvbcXFHYc4vLeN8tpw2IOc+2A2gDhRC0RAl/CyzKgdWq
 NujJFixNfKEWFuHNa4mKxX17qcAANNk=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-62-dKNZ7vdVOl6V6m-wRILyLQ-1; Tue, 25 Apr 2023 04:35:04 -0400
X-MC-Unique: dKNZ7vdVOl6V6m-wRILyLQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 ffacd0b85a97d-2fcec825133so1725813f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 Apr 2023 01:35:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682411703; x=1685003703;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=12yPNwee6eKmLgy6pNQQ5971cnoVK8ZLgf7UFS2TwrU=;
 b=dXiuzVQdHYfELllvjEM2/WIfGEDhLuUoUHtu1gAAH/J/N4XVrJMJ3E4I1a1PojWMn5
 r0KorcNWeFDbCXi8e0lEkP3Xm9AVpdbO6xeMArTHY+i54Nwr5h3RhksoV+nR9/5v4O3m
 2S2iWP9BT1rjkCDybCeMrTqOX/nM4IV3u5/SEfuo65xT619lvyFqrmt+2z5Kn2p8Zk1z
 IGnSzPiaOrdOIjV8QXhpf1sapMcTJgZJA9ofWVWpDw6DaOgmppBJl+9zOhsiUFBU/52l
 wtKbidQBVrtuCnGh9uYdy4GboomXGXp3XYEGgOxLEJVrGuRfwHnf4h8wOkX7/EeV2CtE
 bf4g==
X-Gm-Message-State: AAQBX9e39VxoXtNK7EIVmQmITKLlTA4aQSbkXImGvTwpWpN8xEQ+dUAD
 +RFLv0t5O6CNtRqGfW18i7gqLC8VSJ1HzNshLjbXwoWqFmgpTbWtzalwkT21gT7CBnnKGwL1a1b
 iVLsT+0P45wQx7rwWeNcYcdPM4P2m/8LpLfULYx4XTQ==
X-Received: by 2002:adf:f24c:0:b0:2f4:6574:5a93 with SMTP id
 b12-20020adff24c000000b002f465745a93mr12516605wrp.4.1682411703057; 
 Tue, 25 Apr 2023 01:35:03 -0700 (PDT)
X-Google-Smtp-Source: AKy350YzvhAFxQchdtafHwvmXBchE/YcmkSUeMa1HoC1zk1lBrrRDtHRpjgJc3aGfUSP7c/RWHiheA==
X-Received: by 2002:adf:f24c:0:b0:2f4:6574:5a93 with SMTP id
 b12-20020adff24c000000b002f465745a93mr12516582wrp.4.1682411702685; 
 Tue, 25 Apr 2023 01:35:02 -0700 (PDT)
Received: from redhat.com ([2.55.61.39]) by smtp.gmail.com with ESMTPSA id
 f4-20020a0560001b0400b002ffbf2213d4sm12594526wrz.75.2023.04.25.01.35.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Apr 2023 01:35:02 -0700 (PDT)
Date: Tue, 25 Apr 2023 04:34:58 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Message-ID: <20230425041352-mutt-send-email-mst@kernel.org>
References: <20230417051816-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237705695AFD873DEE4530D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417073830-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723FA4F0FFEBD25903E3344D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417075645-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723FA90465186B5A8A5C001D4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230423031308-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47233B680283E892C45430BCD4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230423065132-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237D46ADE7954289025B66D4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB47237D46ADE7954289025B66D4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
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

On Sun, Apr 23, 2023 at 12:28:49PM +0000, Alvaro Karsz wrote:
> 
> > > > The rest of stuff can probably just be moved to after find_vqs without
> > > > much pain.
> > > >
> > > Actually, I think that with a little bit of pain :)
> > > If we use small vrings and a GRO feature bit is set, Linux will need to allocate 64KB of continuous memory for every receive descriptor..
> > 
> > Oh right. Hmm. Well this is same as big packets though, isn't it?
> > 
> 
> Well, when VIRTIO_NET_F_MRG_RXBUF is not negotiated and one of the GRO features is, the receive buffers are page size buffers chained together to form a 64K buffer.
> In this case, do all the chained descriptors actually point to a single block of continuous memory, or is it possible for the descriptors to point to pages spread all over?
> 
> > 
> > > Instead of failing probe if GRO/CVQ are set, can we just reset the device if we discover small vrings and start over?
> > > Can we remember that this device uses small vrings, and then just avoid negotiating the features that we cannot support?
> > 
> > 
> > We technically can of course. I am just not sure supporting CVQ with just 1 s/g entry will
> > ever be viable.
> 
> Even if we won't support 1 s/g entry, do we want to fail probe in such cases?
> We could just disable the CVQ feature (with reset, as suggested before).
> I'm not saying that we should, just raising the option.
> 

So, let's add some funky flags in virtio device to block out
features, have core compare these before and after,
detect change, reset and retry?


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
