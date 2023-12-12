Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1B8F5D494
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Dec 2023 16:12:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Xe9MEmer"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 404B941969
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Dec 2023 16:12:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 404B941969
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Xe9MEmer
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bSPETLMjN9WS
	for <virtualization@lists.linux-foundation.org>;
	Tue, 12 Dec 2023 16:12:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EA43941724
	for <virtualization@lists.linux-foundation.org>; Tue, 12 Dec 2023 16:12:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EA43941724
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1702397563;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=73Y77tPLmgg9X166NzbyHTwHM16bRnjvtwZKK18ICnw=;
	b=Xe9MEmerM5i/qpmQhXskNsI5775JOfc6cYsh1ZVyV+Y4jXWcMKFPFtt4GeMQwFbyi8HbfG
	ltS3E+tkmXtc82LcLf6QPU3pvHPNwujNh6EDjkUXBkDrsn99zawJX9uRnShRrILqreOQJl
	d0adYfNinpZxQVJPolzhCh0FZQ+KiNE=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-692-CQ-kEF8ONhu9EftWMeWZ7Q-1; Tue, 12 Dec 2023 11:12:41 -0500
X-MC-Unique: CQ-kEF8ONhu9EftWMeWZ7Q-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33347dc610dso5174264f8f.1
        for <virtualization@lists.linux-foundation.org>; Tue, 12 Dec 2023 08:12:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1702397560; x=1703002360;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=73Y77tPLmgg9X166NzbyHTwHM16bRnjvtwZKK18ICnw=;
        b=fNFWg4pQPrjKipDjkPYR4wWOo3Se+YWL97awBldespR1ay4g//HO8F0uTLxHUGN2RF
         j6g91c469HwE22G1AITivcs2O+9d2Ir/QYYf9iK0NvNdMf9Yn/9DbstRgu3QI4BpyFc8
         beQtW79+ISoHVRTBjC07gEZXrhdoCsogiN2e/04ii+8FjAIuUKb4SDMOXIAR3JiGXVHC
         GCA3AotYcVMAhozttKykzq0Y/jHJ3+bPf6oZqaKTynQ4Lh53jpULjlJSImq1ZJOtv/4n
         iSyni4TLJ/WW0j9yrTXhHqhudVyC/BlZbsSPmj6tAUQRItmidPO7Zmz9SHaddmN4cUiM
         4Csg==
X-Gm-Message-State: AOJu0Yzy620aI5wZoYLjl02wgzbmxEc6PLaR/mGgpAoEypmWXxdl7jkA
	VOYJcOKXquihWaFX2Zd6YRPyDClQM5Lru0b47Iop/noB81hER4P9eFh0fKsgiV3RGqbah/qaRPf
	wWg0xUEFSVaG5RpA6a8hFU3N/+gATwat5iYDUlloiZw==
X-Received: by 2002:a7b:cc0c:0:b0:40c:3e8c:74fa with SMTP id f12-20020a7bcc0c000000b0040c3e8c74famr3240808wmh.70.1702397559976;
        Tue, 12 Dec 2023 08:12:39 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEyb1/I2wKTLMi+hetTQnpC0FPFzMqzR4AJJQa8dDCJSD0J7Uw3hfcLHdSCE9DDEEdCK5s0fA==
X-Received: by 2002:a7b:cc0c:0:b0:40c:3e8c:74fa with SMTP id f12-20020a7bcc0c000000b0040c3e8c74famr3240796wmh.70.1702397559537;
        Tue, 12 Dec 2023 08:12:39 -0800 (PST)
Received: from redhat.com ([2.52.23.105])
        by smtp.gmail.com with ESMTPSA id j1-20020a5d5641000000b00333dbecdce3sm11134355wrw.62.2023.12.12.08.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 12 Dec 2023 08:12:38 -0800 (PST)
Date: Tue, 12 Dec 2023 11:12:35 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseniy Krasnov <avkrasnov@salutedevices.com>
Cc: Stefan Hajnoczi <stefanha@redhat.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Bobby Eshleman <bobby.eshleman@bytedance.com>, kvm@vger.kernel.org,
	virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, kernel@sberdevices.ru,
	oxffffaa@gmail.com
Subject: Re: [PATCH net-next v8 0/4] send credit update during setting
 SO_RCVLOWAT
Message-ID: <20231212111131-mutt-send-email-mst@kernel.org>
References: <20231211211658.2904268-1-avkrasnov@salutedevices.com>
 <20231212105423-mutt-send-email-mst@kernel.org>
 <d27f22f0-0f1e-e1bb-5b13-a524dc6e94d7@salutedevices.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <d27f22f0-0f1e-e1bb-5b13-a524dc6e94d7@salutedevices.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Dec 12, 2023 at 06:59:03PM +0300, Arseniy Krasnov wrote:
> 
> 
> On 12.12.2023 18:54, Michael S. Tsirkin wrote:
> > On Tue, Dec 12, 2023 at 12:16:54AM +0300, Arseniy Krasnov wrote:
> >> Hello,
> >>
> >>                                DESCRIPTION
> >>
> >> This patchset fixes old problem with hungup of both rx/tx sides and adds
> >> test for it. This happens due to non-default SO_RCVLOWAT value and
> >> deferred credit update in virtio/vsock. Link to previous old patchset:
> >> https://lore.kernel.org/netdev/39b2e9fd-601b-189d-39a9-914e5574524c@sberdevices.ru/
> > 
> > 
> > Patchset:
> > 
> > Acked-by: Michael S. Tsirkin <mst@redhat.com>
> 
> Thanks!
> 
> > 
> > 
> > But I worry whether we actually need 3/8 in net not in net-next.
> 
> Because of "Fixes" tag ? I think this problem is not critical and reproducible
> only in special cases, but i'm not familiar with netdev process so good, so I don't
> have strong opinion. I guess @Stefano knows better.
> 
> Thanks, Arseniy

Fixes means "if you have that other commit then you need this commit
too". I think as a minimum you need to rearrange patches to make the
fix go in first. We don't want a regression followed by a fix.

> > 
> > Thanks!
> > 
> >> Here is what happens step by step:
> >>
> >>                                   TEST
> >>
> >>                             INITIAL CONDITIONS
> >>
> >> 1) Vsock buffer size is 128KB.
> >> 2) Maximum packet size is also 64KB as defined in header (yes it is
> >>    hardcoded, just to remind about that value).
> >> 3) SO_RCVLOWAT is default, e.g. 1 byte.
> >>
> >>
> >>                                  STEPS
> >>
> >>             SENDER                              RECEIVER
> >> 1) sends 128KB + 1 byte in a
> >>    single buffer. 128KB will
> >>    be sent, but for 1 byte
> >>    sender will wait for free
> >>    space at peer. Sender goes
> >>    to sleep.
> >>
> >>
> >> 2)                                     reads 64KB, credit update not sent
> >> 3)                                     sets SO_RCVLOWAT to 64KB + 1
> >> 4)                                     poll() -> wait forever, there is
> >>                                        only 64KB available to read.
> >>
> >> So in step 4) receiver also goes to sleep, waiting for enough data or
> >> connection shutdown message from the sender. Idea to fix it is that rx
> >> kicks tx side to continue transmission (and may be close connection)
> >> when rx changes number of bytes to be woken up (e.g. SO_RCVLOWAT) and
> >> this value is bigger than number of available bytes to read.
> >>
> >> I've added small test for this, but not sure as it uses hardcoded value
> >> for maximum packet length, this value is defined in kernel header and
> >> used to control deferred credit update. And as this is not available to
> >> userspace, I can't control test parameters correctly (if one day this
> >> define will be changed - test may become useless). 
> >>
> >> Head for this patchset is:
> >> https://git.kernel.org/pub/scm/linux/kernel/git/netdev/net-next.git/commit/?id=021b0c952f226236f2edf89c737efb9a28d1422d
> >>
> >> Link to v1:
> >> https://lore.kernel.org/netdev/20231108072004.1045669-1-avkrasnov@salutedevices.com/
> >> Link to v2:
> >> https://lore.kernel.org/netdev/20231119204922.2251912-1-avkrasnov@salutedevices.com/
> >> Link to v3:
> >> https://lore.kernel.org/netdev/20231122180510.2297075-1-avkrasnov@salutedevices.com/
> >> Link to v4:
> >> https://lore.kernel.org/netdev/20231129212519.2938875-1-avkrasnov@salutedevices.com/
> >> Link to v5:
> >> https://lore.kernel.org/netdev/20231130130840.253733-1-avkrasnov@salutedevices.com/
> >> Link to v6:
> >> https://lore.kernel.org/netdev/20231205064806.2851305-1-avkrasnov@salutedevices.com/
> >> Link to v7:
> >> https://lore.kernel.org/netdev/20231206211849.2707151-1-avkrasnov@salutedevices.com/
> >>
> >> Changelog:
> >> v1 -> v2:
> >>  * Patchset rebased and tested on new HEAD of net-next (see hash above).
> >>  * New patch is added as 0001 - it removes return from SO_RCVLOWAT set
> >>    callback in 'af_vsock.c' when transport callback is set - with that
> >>    we can set 'sk_rcvlowat' only once in 'af_vsock.c' and in future do
> >>    not copy-paste it to every transport. It was discussed in v1.
> >>  * See per-patch changelog after ---.
> >> v2 -> v3:
> >>  * See changelog after --- in 0003 only (0001 and 0002 still same).
> >> v3 -> v4:
> >>  * Patchset rebased and tested on new HEAD of net-next (see hash above).
> >>  * See per-patch changelog after ---.
> >> v4 -> v5:
> >>  * Change patchset tag 'RFC' -> 'net-next'.
> >>  * See per-patch changelog after ---.
> >> v5 -> v6:
> >>  * New patch 0003 which sends credit update during reading bytes from
> >>    socket.
> >>  * See per-patch changelog after ---.
> >> v6 -> v7:
> >>  * Patchset rebased and tested on new HEAD of net-next (see hash above).
> >>  * See per-patch changelog after ---.
> >> v7 -> v8:
> >>  * See per-patch changelog after ---.
> >>
> >> Arseniy Krasnov (4):
> >>   vsock: update SO_RCVLOWAT setting callback
> >>   virtio/vsock: send credit update during setting SO_RCVLOWAT
> >>   virtio/vsock: fix logic which reduces credit update messages
> >>   vsock/test: two tests to check credit update logic
> >>
> >>  drivers/vhost/vsock.c                   |   1 +
> >>  include/linux/virtio_vsock.h            |   1 +
> >>  include/net/af_vsock.h                  |   2 +-
> >>  net/vmw_vsock/af_vsock.c                |   9 +-
> >>  net/vmw_vsock/hyperv_transport.c        |   4 +-
> >>  net/vmw_vsock/virtio_transport.c        |   1 +
> >>  net/vmw_vsock/virtio_transport_common.c |  43 +++++-
> >>  net/vmw_vsock/vsock_loopback.c          |   1 +
> >>  tools/testing/vsock/vsock_test.c        | 175 ++++++++++++++++++++++++
> >>  9 files changed, 229 insertions(+), 8 deletions(-)
> >>
> >> -- 
> >> 2.25.1
> > 

