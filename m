Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34DDCC282E7
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 21:39:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C626E60BD6;
	Mon, 15 Aug 2022 21:39:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C626E60BD6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=enVrrMK0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SIeTFRvpFh26; Mon, 15 Aug 2022 21:39:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 4066560B97;
	Mon, 15 Aug 2022 21:39:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4066560B97
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1E9AC0033;
	Mon, 15 Aug 2022 21:39:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 10214C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:39:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E619960BD1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:39:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E619960BD1
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zodZ_NbUCxZA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:39:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A466060B97
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A466060B97
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:39:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660599556;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e2Hg6grA0aMUmuL4rEa0v8OvN+G77+vUxp19mNa37p4=;
 b=enVrrMK0rucjJuLwOAd1IqnWoH0tMH4eaJfVVZFRpUqp1rtNO48M2PRHOy6gejCqYmP0mg
 Vw4veI3b7g4Prtfp4Hq0oIN50VjBs7eNYr9Yg5ST6HBr99wkHFkay3wLdYfYWevkUvOHBV
 togAPUQlUI5NWkRTpilHNnyKL0gfGNA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-59-wUQcv87aOO206Ud6mScPGg-1; Mon, 15 Aug 2022 17:39:15 -0400
X-MC-Unique: wUQcv87aOO206Ud6mScPGg-1
Received: by mail-wm1-f71.google.com with SMTP id
 m4-20020a7bce04000000b003a386063752so1589569wmc.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 14:39:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=e2Hg6grA0aMUmuL4rEa0v8OvN+G77+vUxp19mNa37p4=;
 b=Iz78ezll51YEimbbK1evy7epYphwi4o+wEOy5fcQDWh2Dyly3wc2UGKr8lUIzOVrIE
 87T4Z01FygIoIpgC5AnqXXuuWZSmoyYj1PJzwIcXSEA+QwA2RV5jrGTGRLPZi8+d63vt
 QNKVqkSD+Sc5TrOyJ6kZxSlJ4SKAMR7MFu7CZ4S06RZfRD0hBgbs3AVGRm0nl3bvi44W
 cWXb+Q1nYYF0WuaJmUDhGHYH8BRkrBSClJgjKnuJZ6WzZd7jokGAAZDD6OiakTQ6BjvH
 fgqeBwJaz9tHHLgNmoU5Tr8HJIjqhZK3fWU0AAjvzOcToEcuFRseoTbD/ZPTPpPc5HV8
 EdTw==
X-Gm-Message-State: ACgBeo0SY6gpTqO/keCPOJ/MTDnqDpceipA2q/urQr35GbvQWEnvZa+N
 zkWbyrvw0S4nhEjZQ3hyqPMg3DrlMnIWag5HRjlf8rojp4N6b2jMV9KrGZfVO0XpRgBm+K4fUsO
 7Fryxxpgyxn5bo52CIcEys4hqdsJkZpVCGnvxAzgKcw==
X-Received: by 2002:a05:600c:1e8d:b0:3a5:e37f:6fd2 with SMTP id
 be13-20020a05600c1e8d00b003a5e37f6fd2mr6889430wmb.33.1660599553675; 
 Mon, 15 Aug 2022 14:39:13 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5OPTU7ZmWCtVBzowlE4TRPIvtXzHuep1+lrOGeKpN4aAF6Aj1ToJOY72dVoYDK4Ke/fClJcg==
X-Received: by 2002:a05:600c:1e8d:b0:3a5:e37f:6fd2 with SMTP id
 be13-20020a05600c1e8d00b003a5e37f6fd2mr6889413wmb.33.1660599553427; 
 Mon, 15 Aug 2022 14:39:13 -0700 (PDT)
Received: from redhat.com ([2.55.4.37]) by smtp.gmail.com with ESMTPSA id
 e14-20020a05600c4e4e00b003a31ca9dfb6sm13814387wmq.32.2022.08.15.14.39.10
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 14:39:12 -0700 (PDT)
Date: Mon, 15 Aug 2022 17:39:08 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andres Freund <andres@anarazel.de>
Subject: Re: [PATCH] virtio_net: Revert "virtio_net: set the default max ring
 size by find_vqs()"
Message-ID: <20220815173256-mutt-send-email-mst@kernel.org>
References: <20220815090521.127607-1-mst@redhat.com>
 <20220815203426.GA509309@roeck-us.net>
 <20220815164013-mutt-send-email-mst@kernel.org>
 <20220815205053.GD509309@roeck-us.net>
 <20220815165608-mutt-send-email-mst@kernel.org>
 <20220815212839.aop6wwx4fkngihbf@awork3.anarazel.de>
MIME-Version: 1.0
In-Reply-To: <20220815212839.aop6wwx4fkngihbf@awork3.anarazel.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>,
 "Martin K. Petersen" <martin.petersen@oracle.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 James Bottomley <James.Bottomley@hansenpartnership.com>,
 Eric Dumazet <edumazet@google.com>, Greg KH <gregkh@linuxfoundation.org>,
 c@redhat.com, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>,
 Linus Torvalds <torvalds@linux-foundation.org>,
 "David S. Miller" <davem@davemloft.net>, Guenter Roeck <linux@roeck-us.net>
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

On Mon, Aug 15, 2022 at 02:28:39PM -0700, Andres Freund wrote:
> Hi,
> 
> On 2022-08-15 17:04:10 -0400, Michael S. Tsirkin wrote:
> > So virtio has a queue_size register. When read, it will give you
> > originally the maximum queue size. Normally we just read it and
> > use it as queue size.
> > 
> > However, when queue memory allocation fails, and unconditionally with a
> > network device with the problematic patch, driver is asking the
> > hypervisor to make the ring smaller by writing a smaller value into this
> > register.
> > 
> > I suspect that what happens is hypervisor still uses the original value
> > somewhere.
> 
> It looks more like the host is never told about the changed size for legacy
> devices...
> 
> Indeed, adding a vp_legacy_set_queue_size() & call to it to setup_vq(), makes
> 5.19 + restricting queue sizes to 1024 boot again.

Interesting, the register is RO in the legacy interface.
And to be frank I can't find where is vp_legacy_set_queue_size
even implemented. It's midnight here too ...

>  I'd bet that it also would
> fix 6.0rc1, but I'm running out of time to test that.
> 
> Greetings,
> 
> Andres Freund

Yes I figured this out too. And I was able to reproduce on qemu now.

Andres thanks a lot for the help!

I'm posting a new patchset reverting all the handing of resize
restrictions, I think we should rethink it for the next release.

Thanks everyone for the help!

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
