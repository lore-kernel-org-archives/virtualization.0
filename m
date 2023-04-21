Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40907C7618E
	for <virtualization@archiver.kernel.org>; Fri, 21 Apr 2023 07:04:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D674481EDB;
	Fri, 21 Apr 2023 07:04:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D674481EDB
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XDZc2JPi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IfYXKMxAepX0; Fri, 21 Apr 2023 07:04:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 55C8C81ECC;
	Fri, 21 Apr 2023 07:04:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 55C8C81ECC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31B98C007A;
	Fri, 21 Apr 2023 07:04:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FC3FC002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 07:04:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5D33640217
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 07:04:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5D33640217
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XDZc2JPi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U-mK4qL_n_yq
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 07:04:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9931840148
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9931840148
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 07:04:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682060659;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sQJO95UUdAAV3qDudgkbVRn+BO9giFeNO5BoGKzmtSE=;
 b=XDZc2JPi7TLi7Um5+A2D6WOnMnXWnIHy76R4dWjAwOWlBJd3RCBbkZpie8pa8DNUbBvkRl
 zcmG/TM0jMhDy5m/w2mEk3+RK7ZwUsatIZ6qbIxZyTmmnQLBFVxmMi+SRuJiAug3xoc6nn
 vmmyoT3IX9uwdiqcNP5hRMUi4KvemtU=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-317-uWnHx6YQMkuOkL_5ult-9A-1; Fri, 21 Apr 2023 03:04:17 -0400
X-MC-Unique: uWnHx6YQMkuOkL_5ult-9A-1
Received: by mail-wr1-f69.google.com with SMTP id
 ffacd0b85a97d-2f43679bcf5so838597f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 21 Apr 2023 00:04:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682060656; x=1684652656;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=sQJO95UUdAAV3qDudgkbVRn+BO9giFeNO5BoGKzmtSE=;
 b=VvhSSkdrxcVE6o8ZfnlJX/VVm9uOUKTyeiw2J2yq2BkPb8d3LlyQZ2eN1/yojz64Qq
 HdqkWikZkrkfkz9SFg/HDnkGgp/Jx4G24E2cR1kQhjDI66PoquFOVtvSQwOkeyowAGdJ
 zP5UBVt3UDfzPgc4R3t+ghfUI8rZ4dmI3MLrD1gvaQgkowe4cjp+InIIn0RbQiZNsCZ1
 voVVovqZR2suoM/ZVtTbrg9B5u/AeP5lpNQSyMjCUnWBKto76cJ0CIqIBV/CI9sLHB0f
 X2QNFGV3T8H1KNKrtO52yH7seLLEZKreQHr1A2at3KZ/mrAc5PFtgLAqLNNsnvKBXJwi
 8QJg==
X-Gm-Message-State: AAQBX9ddIj6gyHZwn7knZMmSHHD0l7WXmOxpN7OeoOjim1NWAocoCig9
 iLjf6Ql7UPI3qqu6qL5FwRNTC9wc5fwGbwQ/aBBFRLZ+3CiBgruyhEMcsTmNCFlPI3bjn0BZDoE
 XvVxxvkHe8SLsMSHfx1nb7mhowsdjfmhoInUppm8m9w==
X-Received: by 2002:adf:dc89:0:b0:2f7:faa0:3f19 with SMTP id
 r9-20020adfdc89000000b002f7faa03f19mr3151255wrj.28.1682060656347; 
 Fri, 21 Apr 2023 00:04:16 -0700 (PDT)
X-Google-Smtp-Source: AKy350aHGati/ymbZ+DxYiF2QaRNV5Ff23Y+Nuvqn19bIrzunMC8mgm4mQ7wFV57Pwfs/5R1bDroBQ==
X-Received: by 2002:adf:dc89:0:b0:2f7:faa0:3f19 with SMTP id
 r9-20020adfdc89000000b002f7faa03f19mr3151237wrj.28.1682060656055; 
 Fri, 21 Apr 2023 00:04:16 -0700 (PDT)
Received: from redhat.com ([2.55.62.70]) by smtp.gmail.com with ESMTPSA id
 g2-20020a5d5402000000b002da75c5e143sm3732830wrv.29.2023.04.21.00.04.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Apr 2023 00:04:15 -0700 (PDT)
Date: Fri, 21 Apr 2023 03:04:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost_net: revert upend_idx only on retriable error
Message-ID: <20230421030345-mutt-send-email-mst@kernel.org>
References: <20221123102207.451527-1-asmetanin@yandex-team.ru>
 <CACGkMEs3gdcQ5_PkYmz2eV-kFodZnnPPhvyRCyLXBYYdfHtNjw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEs3gdcQ5_PkYmz2eV-kFodZnnPPhvyRCyLXBYYdfHtNjw@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Andrey Smetanin <asmetanin@yandex-team.ru>, yc-core@yandex-team.ru
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

On Thu, Dec 01, 2022 at 05:01:58PM +0800, Jason Wang wrote:
> On Wed, Nov 23, 2022 at 6:24 PM Andrey Smetanin
> <asmetanin@yandex-team.ru> wrote:
> >
> > Fix possible virtqueue used buffers leak and corresponding stuck
> > in case of temporary -EIO from sendmsg() which is produced by
> > tun driver while backend device is not up.
> >
> > In case of no-retriable error and zcopy do not revert upend_idx
> > to pass packet data (that is update used_idx in corresponding
> > vhost_zerocopy_signal_used()) as if packet data has been
> > transferred successfully.
> 
> Should we mark head.len as VHOST_DMA_DONE_LEN in this case?
> 
> Thanks

Jason do you want to take over this work? It's been stuck
in my inbox for a while.

> >
> > Signed-off-by: Andrey Smetanin <asmetanin@yandex-team.ru>
> > ---
> >  drivers/vhost/net.c | 9 ++++++---
> >  1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> > index 20265393aee7..93e9166039b9 100644
> > --- a/drivers/vhost/net.c
> > +++ b/drivers/vhost/net.c
> > @@ -934,13 +934,16 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
> >
> >                 err = sock->ops->sendmsg(sock, &msg, len);
> >                 if (unlikely(err < 0)) {
> > +                       bool retry = err == -EAGAIN || err == -ENOMEM || err == -ENOBUFS;
> > +
> >                         if (zcopy_used) {
> >                                 if (vq->heads[ubuf->desc].len == VHOST_DMA_IN_PROGRESS)
> >                                         vhost_net_ubuf_put(ubufs);
> > -                               nvq->upend_idx = ((unsigned)nvq->upend_idx - 1)
> > -                                       % UIO_MAXIOV;
> > +                               if (retry)
> > +                                       nvq->upend_idx = ((unsigned)nvq->upend_idx - 1)
> > +                                               % UIO_MAXIOV;
> >                         }
> > -                       if (err == -EAGAIN || err == -ENOMEM || err == -ENOBUFS) {
> > +                       if (retry) {
> >                                 vhost_discard_vq_desc(vq, 1);
> >                                 vhost_net_enable_vq(net, vq);
> >                                 break;
> > --
> > 2.25.1
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
