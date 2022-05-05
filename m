Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5F6FC433F5
	for <virtualization@archiver.kernel.org>; Thu,  5 May 2022 04:58:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5941541928;
	Thu,  5 May 2022 04:58:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SYAdZgH4mgab; Thu,  5 May 2022 04:58:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 647E44091D;
	Thu,  5 May 2022 04:58:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3B3C7C0039;
	Thu,  5 May 2022 04:58:01 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08584C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 04:58:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E534860AAD
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 04:57:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f3ihSZZIRXl2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 04:57:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [170.10.129.74])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DB8AC60AA7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 04:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651726677;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=rzUleSxK9nl8YlNcYVSjvCKZ2tNHw3I29yrW6MqQSZs=;
 b=GpvhyVdNwd1H+eQz79q1iSjNGdTQKwn+ZbFmGf56/Ksp7E0TJnUilBnM3yF0CvAnguQQvn
 KmvGWBgjysE2KCHiNb+tbarCxEKqEvgE1xRr/v5YRwr7JaZCYGP70Hc/E9yDuUkPNsoltD
 wlMX/pteL+h+KWVW+yfLmjIT0yWh00c=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-169-OCCt0w-LMrO6au-hXHIwwQ-1; Thu, 05 May 2022 00:57:55 -0400
X-MC-Unique: OCCt0w-LMrO6au-hXHIwwQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 b65-20020a509f47000000b00427b34634d3so1705379edf.20
 for <virtualization@lists.linux-foundation.org>;
 Wed, 04 May 2022 21:57:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=rzUleSxK9nl8YlNcYVSjvCKZ2tNHw3I29yrW6MqQSZs=;
 b=OeDR4/AlVgTb8Ug3bVDVlJJSlIxIrF20MqjBr1umeavMQF23CCjS0Jof4yjSoupQj6
 M6zPdmRP8W4ka1OsOzNoJSuSpkMgIjJ+FtDaVI7WClo5m/4t1bgdOo2Utfo1FqCks9rl
 oow9Gn+WOjj9ZsjUhste2Ys2x8KZC8S4ehn7dzVLQHA2y0W6sbx3E4A6SPGOIoRnVZ4X
 6JzwDNKUqgSoEgEAN8XMAEcV9d6gLKHStxOXFwKapqbnWgIOMT5Ng8t6jaBWqN6Wx+3b
 FmcsIIh25/Ql5cHzMgH7o+/i7IfJfAbrfYAyk2Ydo6rj65RL1JMhriVBjcJaSYEIwMGi
 RgyQ==
X-Gm-Message-State: AOAM5308fC/2BkHnEiuR7UyQnPM9Q91DKbp8Xe0pgpY3Om3c3no3QAv/
 iFtMtsHXWMcoPZxQoqFnDnwMRlN47/F/H01FJ5wttgdYc4vf+05TmuV6G8NXp9kcveVDNvQoskf
 b1xkR5j0gcrmLJsRluxDY4RVJFwD0APC3Tt9hyd2qig==
X-Received: by 2002:a17:906:4fcd:b0:6f4:b5c0:aa44 with SMTP id
 i13-20020a1709064fcd00b006f4b5c0aa44mr7687131ejw.445.1651726674812; 
 Wed, 04 May 2022 21:57:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwbX4SoVGMOKvRO7Omo/n5jSKXm67g9e9YispmVFqRKvn39kXm8wsjujTpuSP3Yg3lt2T129Q==
X-Received: by 2002:a17:906:4fcd:b0:6f4:b5c0:aa44 with SMTP id
 i13-20020a1709064fcd00b006f4b5c0aa44mr7687117ejw.445.1651726674576; 
 Wed, 04 May 2022 21:57:54 -0700 (PDT)
Received: from redhat.com ([2.53.134.204]) by smtp.gmail.com with ESMTPSA id
 q10-20020a1709064cca00b006f3ef214dd7sm311969ejt.61.2022.05.04.21.57.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 May 2022 21:57:53 -0700 (PDT)
Date: Thu, 5 May 2022 00:57:49 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Gonglei (Arei)" <arei.gonglei@huawei.com>
Subject: Re: PING: [PATCH v4 0/5] virtio-crypto: Improve performance
Message-ID: <20220505005607-mutt-send-email-mst@kernel.org>
References: <20220424104140.44841-1-pizhenwei@bytedance.com>
 <cc9eb4aa-2e40-490f-f5a0-beee3a57313b@bytedance.com>
 <7f7ab8ae46174ed6b0888b5fbeb5849b@huawei.com>
MIME-Version: 1.0
In-Reply-To: <7f7ab8ae46174ed6b0888b5fbeb5849b@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "herbert@gondor.apana.org.au" <herbert@gondor.apana.org.au>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 zhenwei pi <pizhenwei@bytedance.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-crypto@vger.kernel.org" <linux-crypto@vger.kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>,
 "helei.sig11@bytedance.com" <helei.sig11@bytedance.com>
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

On Thu, May 05, 2022 at 03:14:40AM +0000, Gonglei (Arei) wrote:
> 
> 
> > -----Original Message-----
> > From: zhenwei pi [mailto:pizhenwei@bytedance.com]
> > Sent: Thursday, May 5, 2022 10:35 AM
> > To: Gonglei (Arei) <arei.gonglei@huawei.com>; mst@redhat.com;
> > jasowang@redhat.com
> > Cc: herbert@gondor.apana.org.au; linux-kernel@vger.kernel.org;
> > virtualization@lists.linux-foundation.org; linux-crypto@vger.kernel.org;
> > helei.sig11@bytedance.com; davem@davemloft.net
> > Subject: PING: [PATCH v4 0/5] virtio-crypto: Improve performance
> > 
> > Hi, Lei
> > 
> > Jason replied in another patch:
> > Still hundreds of lines of changes, I'd leave this change to other maintainers to
> > decide.
> > 
> > Quite frankly, the virtio crypto driver changed only a few in the past, and the
> > performance of control queue is not good enough. I am in doubt about that this
> > driver is not used widely. So I'd like to rework a lot, it would be best to complete
> > this work in 5.18 window.
> > 
> > This gets different point with Jason. I would appreciate it if you could give me
> > any hint.
> > 
> 
> This is already in my todo list.
> 
> Regards,
> -Gonglei

It's been out a month though, not really acceptable latency for review.
So I would apply this for next,  but you need to address Dan Captenter's
comment, and look for simular patterns elesewhere in your patch.


> > On 4/24/22 18:41, zhenwei pi wrote:
> > > Hi, Lei
> > > I'd like to move helper and callback functions(Eg, virtcrypto_clear_request
> > >   and virtcrypto_ctrlq_callback) from xx_core.c to xx_common.c, then
> > > the xx_core.c supports:
> > >    - probe/remove/irq affinity seting for a virtio device
> > >    - basic virtio related operations
> > >
> > > xx_common.c supports:
> > >    - common helpers/functions for algos
> > >
> > > Do you have any suggestion about this?
> > >
> > > v3 -> v4:
> > >   - Don't create new file virtio_common.c, the new functions are added
> > >     into virtio_crypto_core.c
> > >   - Split the first patch into two parts:
> > >       1, change code style,
> > >       2, use private buffer instead of shared buffer
> > >   - Remove relevant change.
> > >   - Other minor changes.
> > >
> > > v2 -> v3:
> > >   - Jason suggested that spliting the first patch into two part:
> > >       1, using private buffer
> > >       2, remove the busy polling
> > >     Rework as Jason's suggestion, this makes the smaller change in
> > >     each one and clear.
> > >
> > > v1 -> v2:
> > >   - Use kfree instead of kfree_sensitive for insensitive buffer.
> > >   - Several coding style fix.
> > >   - Use memory from current node, instead of memory close to device
> > >   - Add more message in commit, also explain why removing per-device
> > >     request buffer.
> > >   - Add necessary comment in code to explain why using kzalloc to
> > >     allocate struct virtio_crypto_ctrl_request.
> > >
> > > v1:
> > > The main point of this series is to improve the performance for virtio
> > > crypto:
> > > - Use wait mechanism instead of busy polling for ctrl queue, this
> > >    reduces CPU and lock racing, it's possiable to create/destroy session
> > >    parallelly, QPS increases from ~40K/s to ~200K/s.
> > > - Enable retry on crypto engine to improve performance for data queue,
> > >    this allows the larger depth instead of 1.
> > > - Fix dst data length in akcipher service.
> > > - Other style fix.
> > >
> > > lei he (2):
> > >    virtio-crypto: adjust dst_len at ops callback
> > >    virtio-crypto: enable retry for virtio-crypto-dev
> > >
> > > zhenwei pi (3):
> > >    virtio-crypto: change code style
> > >    virtio-crypto: use private buffer for control request
> > >    virtio-crypto: wait ctrl queue instead of busy polling
> > >
> > >   .../virtio/virtio_crypto_akcipher_algs.c      |  83 ++++++-----
> > >   drivers/crypto/virtio/virtio_crypto_common.h  |  21 ++-
> > >   drivers/crypto/virtio/virtio_crypto_core.c    |  55 ++++++-
> > >   .../virtio/virtio_crypto_skcipher_algs.c      | 140 ++++++++----------
> > >   4 files changed, 180 insertions(+), 119 deletions(-)
> > >
> > 
> > --
> > zhenwei pi

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
