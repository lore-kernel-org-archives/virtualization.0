Return-Path: <SRS0=hVMj=PQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA7A6C433EF
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 02:29:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8A37460F56
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 02:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8A37460F56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5725C81911;
	Thu, 28 Oct 2021 02:29:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SF-jMIPOyNQp; Thu, 28 Oct 2021 02:29:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0081F81836;
	Thu, 28 Oct 2021 02:29:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C516DC0019;
	Thu, 28 Oct 2021 02:29:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 94BEAC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 02:29:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 873D14020A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 02:29:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XIuXWqQXGLXr
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 02:29:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 98EBA40150
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 02:29:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635388139;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ai5EJYH+XM1xHPGl2sOT1f/06ywkQNnnLxzitLQLLRk=;
 b=Elm1cvxtX1bhGNqColxrA88KBRYpj3ywaIIwqshyAKSkG3teJTcTZC8Xq3wbY4KdZAA71n
 KFUz38s1yZf+xILxk8i44gz9Em8E3wPgFaIsk+CcQE5k/8VqlpW/U9O1SGPiYXhV/Lq2Bk
 GBQHLIBglvJWxNL5lHSdSx78nGClhKc=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-74-MJ0SROyKN7aVoNipqJBa9w-1; Wed, 27 Oct 2021 22:28:58 -0400
X-MC-Unique: MJ0SROyKN7aVoNipqJBa9w-1
Received: by mail-lf1-f70.google.com with SMTP id
 x205-20020a19c7d6000000b003ffdde261b9so422531lff.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 19:28:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc;
 bh=Ai5EJYH+XM1xHPGl2sOT1f/06ywkQNnnLxzitLQLLRk=;
 b=HuB4fWDzHynXzgO2f9nqEizq+v+Vp3V7MZNo4NhmZO0nDf5nENorwQpU+chGxnMllH
 xT8mge7iu1HMExE287ugG/6h4m0nr84Zqud+/D72VBdFrnpvo6nTgxbuC9hhuEOoRQQK
 p/loVu6DRY0GKbKk0OIN6wsDzCXYe4PYZz8w60XjS5e9rROTNdFGTv+OP3T9BcfWBETX
 89nccMWe5V0EdOJZpzui1bxWlYdBWM1Vhd9JqQuj1yRR7xcYL35BmExhANxmVViZor0N
 L9jLv9vzCB5jKnYC1gD5eGfzzPEP4HbWHlWmwE/9SgcVWVo6VBnsTdEiHsSEnDj4kK4Q
 djSQ==
X-Gm-Message-State: AOAM533LZe7QJA0PoNmzbLHOg/HCNIp4FeH5DaPa5mhFhT2noIZtTPAp
 pVtS901T0v8JRfO5psO82xi0lT2z2TftbvXGcGLp+cKogK99CjwD7m0wfgoCqeM/jrNUP2c1mbT
 LBtT23iXE54jY+/cqPodCtxIt1jPCIzNanuozp+HbJpBuxnjx6a3KKFyxRg==
X-Received: by 2002:a05:6512:3d11:: with SMTP id
 d17mr1379157lfv.481.1635388136850; 
 Wed, 27 Oct 2021 19:28:56 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyck4H1QE2hfPhL/QuSTnQR+n77jAyInsCjKIN0wFVzlktEE7qGyKmte6qKTmyTlDp9jCcZ9l+EVMHzWfMgyZg=
X-Received: by 2002:a05:6512:3d11:: with SMTP id
 d17mr1379143lfv.481.1635388136683; 
 Wed, 27 Oct 2021 19:28:56 -0700 (PDT)
MIME-Version: 1.0
References: <20211027085528.01c4b313@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <1635386220.8124611-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1635386220.8124611-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Oct 2021 10:28:45 +0800
Message-ID: <CACGkMEs0V7Hy2mkQymCyVBYAaM7tM=Wj7d+tfxTOg8zJdr4YDA@mail.gmail.com>
Subject: Re: [PATCH 3/3] virtio-net: enable virtio indirect cache
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jakub Kicinski <kuba@kernel.org>, netdev <netdev@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>,
 virtualization <virtualization@lists.linux-foundation.org>
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

On Thu, Oct 28, 2021 at 9:59 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
>
> On Wed, 27 Oct 2021 08:55:28 -0700, Jakub Kicinski <kuba@kernel.org> wrote:
> > On Wed, 27 Oct 2021 14:19:13 +0800 Xuan Zhuo wrote:
> > > +static bool virtio_desc_cache = true;
> > >  module_param(csum, bool, 0444);
> > >  module_param(gso, bool, 0444);
> > >  module_param(napi_tx, bool, 0644);
> > > +module_param(virtio_desc_cache, bool, 0644);
> >
> > Can this be an ethtool priv flag? module params are discouraged because
> > they can't be controlled per-netdev.
>
>
> The current design can only be set when the device is initialized. So using
> ethtool to modify it will not work.

Anyhow you can add things like synchronization to make it work. But I
think what we want is to make it work unconditionally, so having a
module parameter seems useless. If you want to use it for
benchmarking?

Thanks

>
> Thanks.
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
