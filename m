Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A20AC32771
	for <virtualization@archiver.kernel.org>; Wed, 17 Aug 2022 17:53:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 7596A41A2D;
	Wed, 17 Aug 2022 17:53:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 7596A41A2D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OjDxCM1e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wBLXMI9lCUEw; Wed, 17 Aug 2022 17:53:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id B6D8341A0D;
	Wed, 17 Aug 2022 17:53:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B6D8341A0D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 86D7DC0033;
	Wed, 17 Aug 2022 17:53:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5442C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 17:53:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A6E5181363
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 17:53:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A6E5181363
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OjDxCM1e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L6UKoTzIr92i
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 17:53:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DC0D481352
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id DC0D481352
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 17:53:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660758822;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=SQOVouI0K9iJWnYSVBtpjkA3WVldpQ/o4YTxV/vt74M=;
 b=OjDxCM1eIEnL+4fTMGvGGB2oaS/l/orgtk9MpM/+In6BQ1QyhGwtFUBCtyFXc6tmrh/Sk6
 dqoSJ9tArPjswYWHeU6edfzfqNp0TkFZyQYloTo3uUk3L2Z1/39fBi6p28yWB65qudvEqH
 fQmm3kI5AVF6TrJjTW1uScVR/iJduF0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-648-J3kD0FP2OA6ah6wrA7JMnw-1; Wed, 17 Aug 2022 13:53:41 -0400
X-MC-Unique: J3kD0FP2OA6ah6wrA7JMnw-1
Received: by mail-wm1-f72.google.com with SMTP id
 v11-20020a1cf70b000000b003a318238826so504661wmh.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 Aug 2022 10:53:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=SQOVouI0K9iJWnYSVBtpjkA3WVldpQ/o4YTxV/vt74M=;
 b=MALQui9Qhdqq26eDyuyhRFZjS+Pt0qT69PV6BdrN8L0U37jKLSPlgL3cr8Xs7Kur1x
 8kuSMzMK14EbVbrJpkNYKhi30Xbst2CmrCukzuNaM+JWgEXfvV92tstIVVfLvlF7SarI
 HBaJiT6OZscqPfd51g8ur37J0vGW2RBByqGciIr/quIRmRHk3kcFXjB+/LX9SYs8nrPj
 jPnQ5YG26GhV85cO+7v1RPAcpy4Rw/euqBZIXJlKhaHx1QyJXyWIiQFSmZrXHMDtYxe1
 i7ySfP1pQ6IQQi2IO0enb+gzMzHNMEk9D2w04Flzr5OE8N87fj0MdAFO+iv9BsUrA1nd
 NSfg==
X-Gm-Message-State: ACgBeo2CX/U/4vA91UJJJyloeMG2n3e7OzCa3pnGSsC3SuUcrcp8zT4H
 HatI0S+1h1ZanNYn2ALUdvg3mhaGJ2u33D3inepnc9DelvjGoOCptSbof069EvejynwlAYg/b7w
 Wvond4nZYvku/GvHZvDIeqDAXeU8WbAhVVG8CkQ75yg==
X-Received: by 2002:a05:6000:4083:b0:21f:fb6:9293 with SMTP id
 da3-20020a056000408300b0021f0fb69293mr14792304wrb.303.1660758820166; 
 Wed, 17 Aug 2022 10:53:40 -0700 (PDT)
X-Google-Smtp-Source: AA6agR4ONxUsrUHKKEaZOO44Ixn5LdAH2Y94mokPuvnN34a8r6PY+eKWeMnaGAVNXB2YU7T+If8QUw==
X-Received: by 2002:a05:6000:4083:b0:21f:fb6:9293 with SMTP id
 da3-20020a056000408300b0021f0fb69293mr14792286wrb.303.1660758819888; 
 Wed, 17 Aug 2022 10:53:39 -0700 (PDT)
Received: from redhat.com ([2.55.43.215]) by smtp.gmail.com with ESMTPSA id
 y11-20020adfe6cb000000b00220592005edsm1060157wrm.85.2022.08.17.10.53.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Aug 2022 10:53:39 -0700 (PDT)
Date: Wed, 17 Aug 2022 13:53:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bobby Eshleman <bobbyeshleman@gmail.com>
Subject: Re: [PATCH 0/6] virtio/vsock: introduce dgrams, sk_buff, and qdisc
Message-ID: <20220817135311-mutt-send-email-mst@kernel.org>
References: <cover.1660362668.git.bobby.eshleman@bytedance.com>
 <20220817025250-mutt-send-email-mst@kernel.org>
 <YvtmYpMieMFb80qR@bullseye>
 <20220817130044-mutt-send-email-mst@kernel.org>
 <Yvt6nxUYMfDrLd/A@bullseye>
MIME-Version: 1.0
In-Reply-To: <Yvt6nxUYMfDrLd/A@bullseye>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Wei Liu <wei.liu@kernel.org>, Cong Wang <cong.wang@bytedance.com>,
 Stephen Hemminger <sthemmin@microsoft.com>,
 Bobby Eshleman <bobby.eshleman@bytedance.com>,
 Jiang Wang <jiang.wang@bytedance.com>, Dexuan Cui <decui@microsoft.com>,
 Bobby Eshleman <bobby.eshleman@gmail.com>, linux-kernel@vger.kernel.org,
 Haiyang Zhang <haiyangz@microsoft.com>,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 netdev@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 kvm@vger.kernel.org, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, linux-hyperv@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

On Tue, Aug 16, 2022 at 11:08:26AM +0000, Bobby Eshleman wrote:
> On Wed, Aug 17, 2022 at 01:02:52PM -0400, Michael S. Tsirkin wrote:
> > On Tue, Aug 16, 2022 at 09:42:51AM +0000, Bobby Eshleman wrote:
> > > > The basic question to answer then is this: with a net device qdisc
> > > > etc in the picture, how is this different from virtio net then?
> > > > Why do you still want to use vsock?
> > > > 
> > > 
> > > When using virtio-net, users looking for inter-VM communication are
> > > required to setup bridges, TAPs, allocate IP addresses or setup DNS,
> > > etc... and then finally when you have a network, you can open a socket
> > > on an IP address and port. This is the configuration that vsock avoids.
> > > For vsock, we just need a CID and a port, but no network configuration.
> > 
> > Surely when you mention DNS you are going overboard? vsock doesn't
> > remove the need for DNS as much as it does not support it.
> > 
> 
> Oops, s/DNS/dhcp.

That too.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
