Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D57C433FE
	for <virtualization@archiver.kernel.org>; Tue, 30 Nov 2021 23:22:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 9971C408F5;
	Tue, 30 Nov 2021 23:22:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WcjBI-gm3O4Z; Tue, 30 Nov 2021 23:22:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4170C40901;
	Tue, 30 Nov 2021 23:22:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 122E9C001C;
	Tue, 30 Nov 2021 23:22:09 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1B61C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 23:22:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9CCB8606B1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 23:22:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WmwPgEbH6ogg
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 23:22:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BF1C260684
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 23:22:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1638314525;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HE0msS1vCkRQbBzuUW+gFDjWtfUevvLfeKjclp9hKp4=;
 b=UWH00zQuSCt/cZ+p+6gRVtUWo6Iz9u0QYpOekTB+h1gxZx9KYjNWga7d8G9pwz6YuP8fks
 u4xsbFaUDK3Ycw4k4UTPzzeCc0ksB+H5hkWgBo3TDb74CibtGAtAePyjdx9BHgJu+GzfMG
 GhAE7zu2W0tKK/yHNycItoraNNgf/i0=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-qwSALYVdOvWfAd1-yrL_yA-1; Tue, 30 Nov 2021 18:22:04 -0500
X-MC-Unique: qwSALYVdOvWfAd1-yrL_yA-1
Received: by mail-ed1-f69.google.com with SMTP id
 b15-20020aa7c6cf000000b003e7cf0f73daso18316191eds.22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 Nov 2021 15:22:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HE0msS1vCkRQbBzuUW+gFDjWtfUevvLfeKjclp9hKp4=;
 b=YZD6fuhqp3bAmWNa486wiqMUwedOL8tkDWP3lMuWCPzBvmGWSNKN4COq7wpGJX7yj9
 pl/i2AC6FTg80U/Xg04OBb+RuzJ8LCs6ETdDzsRwRdah8iXn4V6JyESWvi4y5Wiukxdr
 BA0xgb7MjpKTLK705t1lOTFeWEM7eMlsXk6+7JRoqtl0x1MuXvT6FfHCV5O8/kZZB+ec
 xrWjEI9O3KCbGfCnFTs72HouKld0uYKrxF6LU0ojuKpc1OdDWNT4RykaBqFNZeJjetxJ
 l8CUSTJOBPUXSHxP3kO4Xim8e1m50UP7KgZ5MpbK99RUvVrQ79IY5xYSBdYI3u66aMLh
 rDkA==
X-Gm-Message-State: AOAM5321+TjLsV3bn9vtOC8KYMLPr5iXW9kf6YqOiJdrCpIxlHKetOBu
 D+pq3oaz9epE0SKYbwrDfJ9ekGNRUIxQaRr/bgAjsqLqfszY4aUiUo02PWn++aKwVT1ze86m9U2
 P8fTMfPwmwiKmLpIKnKOM0/5g+FgjRyyjVHrMGeSEEg==
X-Received: by 2002:a05:6402:4251:: with SMTP id
 g17mr3005800edb.89.1638314522886; 
 Tue, 30 Nov 2021 15:22:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwbvu86zvHjPQsYW2tVNM00LmXSduAUUk7Bx3bQsiawQ/LT23+JgeK73SoD9rq5dLPGwoV84w==
X-Received: by 2002:a05:6402:4251:: with SMTP id
 g17mr3005791edb.89.1638314522746; 
 Tue, 30 Nov 2021 15:22:02 -0800 (PST)
Received: from redhat.com ([2.53.15.215])
 by smtp.gmail.com with ESMTPSA id d10sm9814746eja.4.2021.11.30.15.22.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 30 Nov 2021 15:22:01 -0800 (PST)
Date: Tue, 30 Nov 2021 18:21:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: Re: [PATCH v2] virtio/vsock: fix the transport to work with
 VMADDR_CID_ANY
Message-ID: <20211130181948-mutt-send-email-mst@kernel.org>
References: <20211126011823.1760-1-wei.w.wang@intel.com>
 <20211126085341.wiab2frkcbmkg4ca@steredhat>
 <2853d4c373aa4cf0961a256622014eed@intel.com>
MIME-Version: 1.0
In-Reply-To: <2853d4c373aa4cf0961a256622014eed@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "stefanha@redhat.com" <stefanha@redhat.com>,
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

On Tue, Nov 30, 2021 at 01:34:20AM +0000, Wang, Wei W wrote:
> Hi Michael,
> 
> Do you plan to merge this patch through your tree?
> If not, I'll resend to have it applied to the net tree.
> 
> Thanks,
> Wei


Sure, I'll merge it. Thanks!

> On Friday, November 26, 2021 4:54 PM, Stefano Garzarella wrote:
> > On Thu, Nov 25, 2021 at 08:18:23PM -0500, Wei Wang wrote:
> > >The VMADDR_CID_ANY flag used by a socket means that the socket isn't
> > >bound to any specific CID. For example, a host vsock server may want to
> > >be bound with VMADDR_CID_ANY, so that a guest vsock client can connect
> > >to the host server with CID=VMADDR_CID_HOST (i.e. 2), and meanwhile, a
> > >host vsock client can connect to the same local server with
> > >CID=VMADDR_CID_LOCAL (i.e. 1).
> > >
> > >The current implementation sets the destination socket's svm_cid to a
> > >fixed CID value after the first client's connection, which isn't an
> > >expected operation. For example, if the guest client first connects to
> > >the host server, the server's svm_cid gets set to VMADDR_CID_HOST, then
> > >other host clients won't be able to connect to the server anymore.
> > >
> > >Reproduce steps:
> > >1. Run the host server:
> > >   socat VSOCK-LISTEN:1234,fork -
> > >2. Run a guest client to connect to the host server:
> > >   socat - VSOCK-CONNECT:2:1234
> > >3. Run a host client to connect to the host server:
> > >   socat - VSOCK-CONNECT:1:1234
> > >
> > >Without this patch, step 3. above fails to connect, and socat complains
> > >"socat[1720] E connect(5, AF=40 cid:1 port:1234, 16): Connection reset
> > >by peer".
> > >With this patch, the above works well.
> > >
> > >Fixes: c0cfa2d8a788 ("vsock: add multi-transports support")
> > >Signed-off-by: Wei Wang <wei.w.wang@intel.com>
> > >---
> > > net/vmw_vsock/virtio_transport_common.c | 3 ++-
> > > 1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > Usually fixes for net/vmw_vsock/* are applied through the net tree
> > (netdev@vger.kernel.org) that seems not CCed. Please
> > use ./scripts/get_maintainer.pl next time.
> > 
> > Maybe this one can be queued by Michael, let's wait a bit, otherwise please
> > resend CCing netdev and using "net" tag.
> > 
> > Anyway the patch LGTM:
> > 
> > Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
