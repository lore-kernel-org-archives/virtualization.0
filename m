Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3BC4C00140
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 20:22:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 190BC4089C;
	Mon, 15 Aug 2022 20:22:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 190BC4089C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=iTFOV2zg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WaxNXZ5Py-k9; Mon, 15 Aug 2022 20:22:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 391E34088F;
	Mon, 15 Aug 2022 20:22:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 391E34088F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 01F59C0032;
	Mon, 15 Aug 2022 20:22:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 410A3C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 20:22:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E779E40893
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 20:22:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E779E40893
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6FY3wPkop06O
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 20:22:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 198054088F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 198054088F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 20:22:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660594920;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Rm2wKHLo3eIkvMoJ4hWHfr10tTEqNp9fs5ikAVIvZnA=;
 b=iTFOV2zgxYI5uGizZwS3h2ZaLFKvaGkSRGBThc0ESfPTxByQIcuykx5QuN5iahqyZlJgWz
 NqGulhz08WX7CAJHHh6Hwk+dL9s6qUeD/NwB86UN/ELoogLYkRAmHAT7ELZKnTrwEB2LlT
 t6h+OHj/3FYD3ZZI2HvqUtjY1Il8Tas=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-467-2uaOpSygOcG6QTfkFLFn2Q-1; Mon, 15 Aug 2022 16:21:59 -0400
X-MC-Unique: 2uaOpSygOcG6QTfkFLFn2Q-1
Received: by mail-wm1-f72.google.com with SMTP id
 j36-20020a05600c1c2400b003a540d88677so3961341wms.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 13:21:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=Rm2wKHLo3eIkvMoJ4hWHfr10tTEqNp9fs5ikAVIvZnA=;
 b=UoFNCGZepIkcmFGqpqgP5Fw7LgFLUCMz62dLxJjA7MB8qEXmKUnskdjsK87nl0Md4u
 GKN8GEQw9fY9IiVAI/U+S4MYJMtwVdSUxrK9kfPm1WldyrvMZvwH/ab2t7TPNXtc7Bxx
 43Yyq51aBa7wJ5EfgyU60QKkRrbwP7NZIVrthLtqJs0gQMK6LowFD7VR6mZPrdgn8xiK
 1AfMop51txCdZYP/wQhddNWBqM64rRmiPzXE2c3ox3ef/klXVWM9JUAE/QZ0XP/GPgfT
 INTKPMMuQMFtY6IqK9K9/8V0eCvG8FxkHfq6QM/BXjiADwt2Ucks6dUP+SEwacS4hKTo
 4VvQ==
X-Gm-Message-State: ACgBeo10aiw4dIxZYvpRfoKCxcp+d/mzSfUB74dIoYwZLzBaA1JBPVGE
 Do6nVPYIy2x+6X8gUrqdcNyZiatTMLNbvEYEFOUt9gZtdl11ufDflNrv2NFJuPKn+1JKZxMq9gj
 TxjVuGPc7Wucs5m16XYC3OI3BiwAk0ZBb7rxQyujGew==
X-Received: by 2002:a7b:cb0e:0:b0:3a5:afff:d520 with SMTP id
 u14-20020a7bcb0e000000b003a5afffd520mr16521524wmj.3.1660594918278; 
 Mon, 15 Aug 2022 13:21:58 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6afLEHm3zW7k4Gxy/c/Vt6rsCXaxSClRUlE4+wMWQqwu2WwHKMucdlqtxtUbqpr2PcXXxaHg==
X-Received: by 2002:a7b:cb0e:0:b0:3a5:afff:d520 with SMTP id
 u14-20020a7bcb0e000000b003a5afffd520mr16521507wmj.3.1660594918038; 
 Mon, 15 Aug 2022 13:21:58 -0700 (PDT)
Received: from redhat.com ([2.55.43.215]) by smtp.gmail.com with ESMTPSA id
 e14-20020a05600c4e4e00b003a31ca9dfb6sm13620139wmq.32.2022.08.15.13.21.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 13:21:56 -0700 (PDT)
Date: Mon, 15 Aug 2022 16:21:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andres Freund <andres@anarazel.de>
Subject: Re: upstream kernel crashes
Message-ID: <20220815161423-mutt-send-email-mst@kernel.org>
References: <CAHk-=wikzU4402P-FpJRK_QwfVOS+t-3p1Wx5awGHTvr-s_0Ew@mail.gmail.com>
 <20220815071143.n2t5xsmifnigttq2@awork3.anarazel.de>
 <20220815034532-mutt-send-email-mst@kernel.org>
 <20220815081527.soikyi365azh5qpu@awork3.anarazel.de>
 <20220815042623-mutt-send-email-mst@kernel.org>
 <FCDC5DDE-3CDD-4B8A-916F-CA7D87B547CE@anarazel.de>
 <20220815113729-mutt-send-email-mst@kernel.org>
 <20220815164503.jsoezxcm6q4u2b6j@awork3.anarazel.de>
 <20220815124748-mutt-send-email-mst@kernel.org>
 <20220815174617.z4chnftzcbv6frqr@awork3.anarazel.de>
MIME-Version: 1.0
In-Reply-To: <20220815174617.z4chnftzcbv6frqr@awork3.anarazel.de>
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

On Mon, Aug 15, 2022 at 10:46:17AM -0700, Andres Freund wrote:
> Hi,
> 
> On 2022-08-15 12:50:52 -0400, Michael S. Tsirkin wrote:
> > On Mon, Aug 15, 2022 at 09:45:03AM -0700, Andres Freund wrote:
> > > Hi,
> > > 
> > > On 2022-08-15 11:40:59 -0400, Michael S. Tsirkin wrote:
> > > > OK so this gives us a quick revert as a solution for now.
> > > > Next, I would appreciate it if you just try this simple hack.
> > > > If it crashes we either have a long standing problem in virtio
> > > > code or more likely a gcp bug where it can't handle smaller
> > > > rings than what device requestes.
> > > > Thanks!
> > > 
> > > I applied the below and the problem persists.
> > > 
> > > [...]
> >
> > Okay!
> 
> Just checking - I applied and tested this atop 6.0-rc1, correct? Or did you
> want me to test it with the 762faee5a267 reverted? I guess what you're trying
> to test if a smaller queue than what's requested you'd want to do so without
> the problematic patch applied...
> 
> 
> > And just to be 100% sure, can you try the following on top of 5.19:
> 
> > diff --git a/drivers/virtio/virtio_pci_modern.c b/drivers/virtio/virtio_pci_modern.c
> > index 623906b4996c..6f4e54a618bc 100644
> > --- a/drivers/virtio/virtio_pci_modern.c
> > +++ b/drivers/virtio/virtio_pci_modern.c
> > @@ -208,6 +208,9 @@ static struct virtqueue *setup_vq(struct virtio_pci_device *vp_dev,
> >  		return ERR_PTR(-EINVAL);
> >  	}
> >  
> > +	if (num > 1024)
> > +		num = 1024;
> > +
> >  	info->msix_vector = msix_vec;
> >  
> >  	/* create the vring */
> > 
> > -- 
> 
> Either way, I did this, and there are no issues that I could observe. No
> oopses, no broken networking. But:
> 
> To make sure it does something I added a debugging printk - which doesn't show
> up. I assume this is at a point at least earlyprintk should work (which I see
> getting enabled via serial)?
> 
> Greetings,
> 
> Andres Freund


Sorry if I was unclear.  I wanted to know whether the change somehow
exposes a driver bug or a GCP bug. So what I wanted to do is to test
this patch on top of *5.19*, not on top of the revert.
The idea is if we reduce the size and it starts crashing then
we know it's GCP fault, if not then GCP can handle smaller sizes
and it's one of the driver changes.

It will apply on top of the revert but won't do much.

Yes I think printk should work here.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
