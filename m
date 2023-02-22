Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99404C61DA4
	for <virtualization@archiver.kernel.org>; Wed, 22 Feb 2023 16:11:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2760B4169C;
	Wed, 22 Feb 2023 16:11:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 2760B4169C
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XPmvFZmJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4WF2JThEuBju; Wed, 22 Feb 2023 16:11:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A32D940329;
	Wed, 22 Feb 2023 16:11:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A32D940329
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 76F1BC0032;
	Wed, 22 Feb 2023 16:11:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2FD2C002B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 16:11:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8023F820DE
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 16:11:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8023F820DE
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XPmvFZmJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LFmHaaGCLJQj
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 16:11:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1F3378209A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1F3378209A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 16:11:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1677082273;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=S8/ghNNTbLiIrYnO3iHVdavpmvCg0NzWCI0d6aV/XW4=;
 b=XPmvFZmJwp9zCR9TFDRy0iWYmeg2mitgiaZL2UdMgi8yhLq/Uejskqf4fRAskzb5rDPJL7
 lbC8np7dcYNCzgK5PhcLxH8gDstB+pJebEk7YW5rLYMC9WfgZZKiNeKIBirjADsDaM8h98
 qkHF9ehaMdDwFjrHKaJr/oS+K/6uVEc=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-478-BNMx5DrvPpWRXJRmKzLyrA-1; Wed, 22 Feb 2023 11:11:12 -0500
X-MC-Unique: BNMx5DrvPpWRXJRmKzLyrA-1
Received: by mail-wm1-f72.google.com with SMTP id
 e17-20020a05600c219100b003e21fa60ec1so3656645wme.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Feb 2023 08:11:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=S8/ghNNTbLiIrYnO3iHVdavpmvCg0NzWCI0d6aV/XW4=;
 b=TeN3Io+8LMrGViaBDI6UZ7uu3Li3Ka5RpBTe+eeqawKlaMVyGm+Bn06ETsmiq9LSlg
 vYjR3uit0k27MB6YuF4PmaBllF5/babzxejtG3LgazzuLLuAiff2w1UhowShPwjPkcjK
 Vl/VnisDC3nnxh6gyveOjQHJ2P5vAGHvZmST/rwnGpQpziv+cH+oZW2A1ZpVVaG0Cy2G
 wIABczuKkrFJCKxW/WB3QUhHS5hGtueIoltGceva0zZpVTvOGkhJkfhpdqeDp3SfyKZp
 Qww1BGAewNJCvH4UELv6RMKficLrB6d7qyM37RVzlBFzE78CIe4LNyj6LqGl4N1bB5TI
 blCQ==
X-Gm-Message-State: AO0yUKXp1T4N9u1quCMo2IsnRX6DNXpv0psKdkgg9FZRHq3Bm8Lj6aFi
 qKIaJrrExnIsBDK27A8/1FDBZAdgEWHN3SqS/zOL4+VGbvyb1pu4lghtVS2jzZ2iK+srx2rHZF0
 rdEA91AN0k3+eETDsKEDR8WeFPJBPVqxVmYjZPszudA==
X-Received: by 2002:a05:600c:c8:b0:3d2:392e:905f with SMTP id
 u8-20020a05600c00c800b003d2392e905fmr6409848wmm.24.1677082271079; 
 Wed, 22 Feb 2023 08:11:11 -0800 (PST)
X-Google-Smtp-Source: AK7set+Un1ypNExaFc+kZXMwSn3M07lTqk0Yp2UvtUsGjthoH8fmjLy+NvB/zR6OGvIrn8kdBsh6vQ==
X-Received: by 2002:a05:600c:c8:b0:3d2:392e:905f with SMTP id
 u8-20020a05600c00c800b003d2392e905fmr6409831wmm.24.1677082270782; 
 Wed, 22 Feb 2023 08:11:10 -0800 (PST)
Received: from redhat.com ([2.52.2.78]) by smtp.gmail.com with ESMTPSA id
 iz4-20020a05600c554400b003e203681b26sm5571009wmb.29.2023.02.22.08.11.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 22 Feb 2023 08:11:10 -0800 (PST)
Date: Wed, 22 Feb 2023 11:11:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [patch net-next v2] net: virtio_net: implement exact header
 length guest feature
Message-ID: <20230222110534-mutt-send-email-mst@kernel.org>
References: <20230221144741.316477-1-jiri@resnulli.us>
 <63f4df39e0728_ce6df208fe@willemb.c.googlers.com.notmuch>
 <Y/TltJnD4k5hB6Z1@nanopsycho>
 <63f4ed716af37_d174a20880@willemb.c.googlers.com.notmuch>
 <Y/XLIs+4eg7xPyF0@nanopsycho>
 <63f6314d678bc_2ab6208a@willemb.c.googlers.com.notmuch>
MIME-Version: 1.0
In-Reply-To: <63f6314d678bc_2ab6208a@willemb.c.googlers.com.notmuch>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jiri Pirko <jiri@resnulli.us>, vmireyno@marvell.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

On Wed, Feb 22, 2023 at 10:14:21AM -0500, Willem de Bruijn wrote:
> Either including the link that Michael shared or quoting the relevant
> part verbatim in the commit message would help, thanks.
> 
> Thinking it over, my main concern is that the prescriptive section in
> the spec does not state what to do when the value is clearly garbage,
> as we have seen with syzkaller.
> 
> Having to sanitize input, by dropping if < ETH_HLEN or > length, to
> me means that the device cannot trust the field, as the spec says it
> should. 

Right. I think the implication is that if device detects and illegal
value it's OK for it to just drop the packet or reset or enter
a broken mode until reset.

By contrast without the feature bit the header size can be
used as a hint e.g. to size allocations but you must
recover if it's incorrect.

And yes tap seems to break if you make it too small or if you make
it huge so it does not really follow the spec in this regard.

Setting the flag will not fix tap because we can't really
affort breaking all drivers who don't set it. But it will
prepare the ground for when tens of years from now we
actually look back and say all drivers set it, no problem.

So that's a good reason to ack this patch.

However if someone is worried about this then fixing tap
so it recovers from incorrect header length without
packet loss is a good idea.

> Sanitization is harder in the kernel, because it has to support all
> kinds of link layers, including variable length.
> 
> Perhaps that's a discussion for the spec rather than this commit. But
> it's a point to clarify as we add support to the code.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
