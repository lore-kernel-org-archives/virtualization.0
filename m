Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81832C4332F
	for <virtualization@archiver.kernel.org>; Tue, 20 Dec 2022 06:44:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 19C6881279;
	Tue, 20 Dec 2022 06:44:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 19C6881279
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=fOT8LjDr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xkAaH8_ZDNCs; Tue, 20 Dec 2022 06:44:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8BF4680BB0;
	Tue, 20 Dec 2022 06:44:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8BF4680BB0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 619A8C0035;
	Tue, 20 Dec 2022 06:44:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 024BDC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 06:44:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C14C080BB0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 06:44:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C14C080BB0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F1FL8V3lg4qe
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 06:44:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BC26E80FFE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BC26E80FFE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 06:44:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671518669;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=IwzbCVxJgzqh/hZntLgZPVw/8F+zWvpGjiJvEA/MIXQ=;
 b=fOT8LjDr7XUfp+a4RAtm99I9HZKBSmGtUs5DevYXnP1VicAX0sU7YKconJeIBCf2CGBndk
 rQs3jHOX8Y5FbW823MVFZcLo40XNGc7PVkyN8ef81sDUiH4oqTTSodFiv5wI3IJSGCz4Y1
 ustFzTjHLSCfVijSgtmCwflVEg+T2yY=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-6-q_AkhZHTN4-pPvsI6RQSYA-1; Tue, 20 Dec 2022 01:44:28 -0500
X-MC-Unique: q_AkhZHTN4-pPvsI6RQSYA-1
Received: by mail-oo1-f70.google.com with SMTP id
 c6-20020a4ad206000000b004a33f36aa4dso5372797oos.21
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Dec 2022 22:44:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=IwzbCVxJgzqh/hZntLgZPVw/8F+zWvpGjiJvEA/MIXQ=;
 b=rGWSsrT2Nm5zdYaAJtsP4VR6qIOvOrvnurdOrkfbYg5uk6llkBD3BQ7MTkODEitygq
 8e8wTmFCQH6YN8T2qW6KL8C2L/mKqmKIFdpzBvg1mVBSD1hUi7lPA1i+Ie0pYwJ1uaVM
 UTVblQcPGHlrmGQqyP2zU3sXu2OsA60OfbdFpuHKW7+EXtNGrKU+yz54ax31KgzBeBJt
 uRABFOE1c5O1zOS0ukU78wEmhaQ1xtOM9WBoO9hE84yK3MgbrHyPELDF+4kfNBiKunwj
 KRWy2tnsLPv+plzjSDVqsvf/6DDKCJ1f0uq9x48Jf/P2/nkvSuOdfsO78Z/1l2jLbQmt
 aXUA==
X-Gm-Message-State: ANoB5pkd4jio/IFT+RSqQpSaN2MKb7HJ8R0KLTdkbPjQCdhM1TSTfNQW
 nV9gAe+6DQieSMV7r58OQs0bq1jvRTZNux1CItOd9jGoPf23fu1EY6qKxUn5D9sUNG+rXqglaQJ
 uIyDm+uJe9wfIVyJc2gjZU2UjtQu62MhmoWxv7hRs1e5A5aJn/AeG7GimcA==
X-Received: by 2002:a05:6808:114c:b0:35e:7a42:7ab5 with SMTP id
 u12-20020a056808114c00b0035e7a427ab5mr1228664oiu.280.1671518667339; 
 Mon, 19 Dec 2022 22:44:27 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7jGysDqwGrWJu197Nisc2Stp5MBJuSZWK+fp7URpsNdbjTOdPL95/ws7E6NNNRPis0ciTrq34bL9g/AETi3fk=
X-Received: by 2002:a05:6808:114c:b0:35e:7a42:7ab5 with SMTP id
 u12-20020a056808114c00b0035e7a427ab5mr1228649oiu.280.1671518667107; Mon, 19
 Dec 2022 22:44:27 -0800 (PST)
MIME-Version: 1.0
References: <20221128021005.232105-1-lizetao1@huawei.com>
 <20221128042945-mutt-send-email-mst@kernel.org>
 <CACGkMEtuOk+wyCsvY0uayGAvy926G381PC-csoXVAwCfiKCZQw@mail.gmail.com>
 <20221219050716-mutt-send-email-mst@kernel.org>
In-Reply-To: <20221219050716-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 20 Dec 2022 14:44:16 +0800
Message-ID: <CACGkMEsHojBVQWUDH4L1xiVTjNm3JgkYBppyOHKr8QLUg3=FsQ@mail.gmail.com>
Subject: Re: [PATCH 0/4] Fix probe failed when modprobe modules
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: axboe@kernel.dk, rusty@rustcorp.com.au, ericvh@gmail.com,
 netdev@vger.kernel.org, linux_oss@crudebyte.com,
 Li Zetao <lizetao1@huawei.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 v9fs-developer@lists.sourceforge.net, edumazet@google.com, stefanha@redhat.com,
 kuba@kernel.org, pbonzini@redhat.com, pabeni@redhat.com, davem@davemloft.net
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

On Mon, Dec 19, 2022 at 6:15 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Tue, Nov 29, 2022 at 11:37:09AM +0800, Jason Wang wrote:
> > >
> > >
> > > Quite a lot of core work here. Jason are you still looking into
> > > hardening?
> >
> > Yes, last time we've discussed a solution that depends on the first
> > kick to enable the interrupt handler. But after some thought, it seems
> > risky since there's no guarantee that the device work in this way.
> >
> > One example is the current vhost_net, it doesn't wait for the kick to
> > process the rx packets. Any more thought on this?
> >
> > Thanks
>
> Specifically virtio net is careful to call virtio_device_ready
> under rtnl lock so buffers are only added after DRIVER_OK.

Right but it only got fixed this year after some code audit.

>
> However we do not need to tie this to kick, this is what I wrote:
>
> > BTW Jason, I had the idea to disable callbacks until driver uses the
> > virtio core for the first time (e.g. by calling virtqueue_add* family of
> > APIs). Less aggressive than your ideas but I feel it will add security
> > to the init path at least.
>
> So not necessarily kick, we can make adding buffers allow the
> interrupt.

Some questions:

1) It introduces a code defined behaviour other than depending on the
spec defined behavior like DRIVER_OK, this will lead extra complexity
in auditing
2) there's no guarantee that the interrupt handler is ready before
virtqueue_add(), or it requires barriers before virtqueue_add() to
make sure the handler is commit

So it looks to me the virtio_device_ready() should be still the
correct way to go:

1) it depends on spec defined behaviour like DRIVER_OK, and it then
can comply with possible future security requirement of drivers
defined in the spec
2) choose to use a new boolean instead of reusing vq->broken
3) enable the harden in driver one by one

Does it make sense?

Thanks

>
>
>
> --
> MST
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
