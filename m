Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0A69C28B2B
	for <virtualization@archiver.kernel.org>; Mon, 15 Aug 2022 21:47:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 13CDB60BE7;
	Mon, 15 Aug 2022 21:47:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 13CDB60BE7
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J1qgdFbl
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dxEOt-_p3NsK; Mon, 15 Aug 2022 21:47:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9D78A60BD1;
	Mon, 15 Aug 2022 21:47:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9D78A60BD1
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D59FC0033;
	Mon, 15 Aug 2022 21:47:55 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5FC8C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:47:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9AC5660BD9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:47:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9AC5660BD9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6wVCAEPg8N4V
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:47:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org A9BCF60BD1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A9BCF60BD1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 21:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660600071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=pwXJio4p0RALiK5hRjEtrlFD6Yn2dwN8viKDJN8w4cg=;
 b=J1qgdFbld2wiax8kZphFMeSw0NeWz3oRFaGOKBJQ7Lw8xquW1UiqoeY0U3YiLgECOnQOIr
 bQKMJm+6MMZV7+DKSFV0dZyS/mLC5HTRKuuJtTI2je8nSyZb0sC9qE/qRlSi3eMcoq4UxI
 WSeF98CAZ3hwj7ITqohBV6SrjSkRlA0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-510-RL3qmYoCNJyyoKu5__luDw-1; Mon, 15 Aug 2022 17:47:48 -0400
X-MC-Unique: RL3qmYoCNJyyoKu5__luDw-1
Received: by mail-wm1-f69.google.com with SMTP id
 f18-20020a05600c4e9200b003a5f81299caso940116wmq.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 15 Aug 2022 14:47:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
 bh=pwXJio4p0RALiK5hRjEtrlFD6Yn2dwN8viKDJN8w4cg=;
 b=ps2vdsdDW95AWwXXpdNV3OS2+9U4lXRGcG4dby6hqvwUixzgdJDEyhGKcUe9i1ovGO
 Wv08WHxDAITA+Av/gN/LpmPprgdcia+ShI9hQGVVfV7NhkEU0jNa7o8VRyrrUcuUz5CR
 G+nK5gyjcByWncE14it1rRjjHAeZIbRdy13Xsgdw0y5/rzM9ZHrXGqZXMC7VJSz8pwnQ
 PCJJcXmVpqVJs/2j7dYy1G2w0ju6O4+WvAQgy83D8pF7RrAtGYbKeH1Wqb9TRIh4rmAt
 s9KFEFuRsemGAFhbgKQZfEFWKKLrfnMCKixblHMSqfXlw74Z4xnyp7PW+xt0jbzE3z1+
 dGCQ==
X-Gm-Message-State: ACgBeo1rXzhhbrEsuJ7lKSDBQX5BBqIz+nCbuKxHqEBRAdtUGOaxbM73
 WTQezaUQSz9r5KCZ/THBo/BexHEIGa/C0I+gkmRjotAq5kWzHMkic189r/zapIRn6TQBl7t2V0G
 P87xO/dKBLpcm/b57jbFGFaAApFfOqZosourGDoGe+A==
X-Received: by 2002:a05:600c:20a:b0:3a5:a700:17d with SMTP id
 10-20020a05600c020a00b003a5a700017dmr11264423wmi.148.1660600067259; 
 Mon, 15 Aug 2022 14:47:47 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6HEO33wTMDod+4BRmHsyVipe5ttcq3PUtK52S+GrjNTcVgMog3ddScg1I78q3Vl9wVp4kBQw==
X-Received: by 2002:a05:600c:20a:b0:3a5:a700:17d with SMTP id
 10-20020a05600c020a00b003a5a700017dmr11264408wmi.148.1660600067077; 
 Mon, 15 Aug 2022 14:47:47 -0700 (PDT)
Received: from redhat.com ([2.55.43.215]) by smtp.gmail.com with ESMTPSA id
 t9-20020a05600c198900b003a4f08495b7sm11295641wmq.34.2022.08.15.14.47.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 15 Aug 2022 14:47:46 -0700 (PDT)
Date: Mon, 15 Aug 2022 17:47:42 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Andres Freund <andres@anarazel.de>
Subject: Re: [PATCH] virtio_net: Revert "virtio_net: set the default max ring
 size by find_vqs()"
Message-ID: <20220815174655-mutt-send-email-mst@kernel.org>
References: <20220815090521.127607-1-mst@redhat.com>
 <20220815203426.GA509309@roeck-us.net>
 <20220815164013-mutt-send-email-mst@kernel.org>
 <20220815205053.GD509309@roeck-us.net>
 <20220815165608-mutt-send-email-mst@kernel.org>
 <20220815212839.aop6wwx4fkngihbf@awork3.anarazel.de>
 <20220815173256-mutt-send-email-mst@kernel.org>
 <20220815214604.x7g342h3oadruxx2@awork3.anarazel.de>
MIME-Version: 1.0
In-Reply-To: <20220815214604.x7g342h3oadruxx2@awork3.anarazel.de>
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

On Mon, Aug 15, 2022 at 02:46:04PM -0700, Andres Freund wrote:
> Hi,
> 
> On 2022-08-15 17:39:08 -0400, Michael S. Tsirkin wrote:
> > On Mon, Aug 15, 2022 at 02:28:39PM -0700, Andres Freund wrote:
> > > On 2022-08-15 17:04:10 -0400, Michael S. Tsirkin wrote:
> > > > So virtio has a queue_size register. When read, it will give you
> > > > originally the maximum queue size. Normally we just read it and
> > > > use it as queue size.
> > > > 
> > > > However, when queue memory allocation fails, and unconditionally with a
> > > > network device with the problematic patch, driver is asking the
> > > > hypervisor to make the ring smaller by writing a smaller value into this
> > > > register.
> > > > 
> > > > I suspect that what happens is hypervisor still uses the original value
> > > > somewhere.
> > > 
> > > It looks more like the host is never told about the changed size for legacy
> > > devices...
> > > 
> > > Indeed, adding a vp_legacy_set_queue_size() & call to it to setup_vq(), makes
> > > 5.19 + restricting queue sizes to 1024 boot again.
> > 
> > Interesting, the register is RO in the legacy interface.
> > And to be frank I can't find where is vp_legacy_set_queue_size
> > even implemented. It's midnight here too ...
> 
> Yea, I meant that added both vp_legacy_set_queue_size() and a call to it. I
> was just quickly experimenting around.

interesting that it's writeable on GCP. It's RO on QEMU.

> 
> > Yes I figured this out too. And I was able to reproduce on qemu now.
> 
> Cool.
> 
> 
> > I'm posting a new patchset reverting all the handing of resize
> > restrictions, I think we should rethink it for the next release.
> 
> Makes sense.
> 
> Greetings,
> 
> Andres Freund

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
