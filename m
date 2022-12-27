Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BBACC10F1B
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 07:33:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 955814054B;
	Tue, 27 Dec 2022 07:33:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 955814054B
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DcnmXABr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xl-jDTOJAfMA; Tue, 27 Dec 2022 07:33:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1A379403C2;
	Tue, 27 Dec 2022 07:33:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1A379403C2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE2CEC0035;
	Tue, 27 Dec 2022 07:33:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 26390C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:33:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id EDEEE81370
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:33:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EDEEE81370
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=DcnmXABr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hJOR2S3r1HRF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:33:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BAEAE8136C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id BAEAE8136C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 07:33:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672126432;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=h2F2GH9r8G5/9JPGcKQm0Kg39TfbvH77Y/WP493sark=;
 b=DcnmXABrf4YEAv6zA05+mHCBCNaSg8UqNcxuXrzcXWmzNOAie9q7nAXKljrQ52cZhjAD5b
 wDB3EJ951aHjiYhqMxxddOU+KrsDjPeahgU5x2mE7JiNpUR1JVKKznXDcpf9iytHNFmx5M
 zZDo2o7DvE8/n7R/fZJy63atb5fuz68=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-3-kam8_tQgORmK3uOkIhQ56w-1; Tue, 27 Dec 2022 02:33:49 -0500
X-MC-Unique: kam8_tQgORmK3uOkIhQ56w-1
Received: by mail-wm1-f71.google.com with SMTP id
 k42-20020a05600c1caa00b003d971135cd5so5697092wms.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Dec 2022 23:33:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h2F2GH9r8G5/9JPGcKQm0Kg39TfbvH77Y/WP493sark=;
 b=DAcEJiFobCYUez7274jcPLEFP0ciPqlJHDr3O3/enVjlxz7Tt6TQjL7DMEjsT2NKJ6
 9pAK7OB6FtUKn2pb45k/qQb+xEq+p7N8SeSg9RZHehRkhsiCj7uf1t2EVK7lW81Ga9RE
 Iiz8c1KmnTTNuesjOnXdiWXodW6C7FE8jQyoqQvYaar70Mp814eTKNOjNV+BIdPrvMez
 z3p7QKaDzPuQSw6DXwGdvYr57n5koK+kNJMhje7U2VSEzJj7phhwXcUo5uFdgZDJZRO5
 WNgUKgi+Mee8kAZKhvlV5ExtA0zc3v71D6u2v29NBS0qIprQehrX4aLGIeI4XcpBwXW3
 Zi1g==
X-Gm-Message-State: AFqh2kqcSOcxCeR1qp55S04WHkAFwLUl0GMLWOEsNKHcct53sr/LRDZs
 y5MN4G/WbC2yP16JYYd6X03ADWg/pM2/7ktzv8EKXKz89/oRJ3i17PfEq4Txi3AialOJjlfZzGB
 u61ogn3gVAxIJcAq86mASXTeQf8g/drSK2aAD+xAWxg==
X-Received: by 2002:a5d:6849:0:b0:280:70e1:c24f with SMTP id
 o9-20020a5d6849000000b0028070e1c24fmr2305144wrw.68.1672126428060; 
 Mon, 26 Dec 2022 23:33:48 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuclLqFnR9qkTo2hfrgyxoL/HUwscW2Ss3HBVsduIc3VD7zOi8RbL5ZWgzxX6AOL6LqRjw/Mg==
X-Received: by 2002:a5d:6849:0:b0:280:70e1:c24f with SMTP id
 o9-20020a5d6849000000b0028070e1c24fmr2305128wrw.68.1672126427814; 
 Mon, 26 Dec 2022 23:33:47 -0800 (PST)
Received: from redhat.com ([2.52.151.85]) by smtp.gmail.com with ESMTPSA id
 c17-20020adffb51000000b0027cb20605e3sm5064232wrs.105.2022.12.26.23.33.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 26 Dec 2022 23:33:47 -0800 (PST)
Date: Tue, 27 Dec 2022 02:33:43 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 3/4] virtio_ring: introduce a per virtqueue waitqueue
Message-ID: <20221227022255-mutt-send-email-mst@kernel.org>
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-4-jasowang@redhat.com>
 <20221226183705-mutt-send-email-mst@kernel.org>
 <CACGkMEuNZLJRnWw+XNxJ-to1y8L2GrTrJkk0y0Gwb5H2YhDczQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuNZLJRnWw+XNxJ-to1y8L2GrTrJkk0y0Gwb5H2YhDczQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

On Tue, Dec 27, 2022 at 12:30:35PM +0800, Jason Wang wrote:
> > But device is still going and will later use the buffers.
> >
> > Same for timeout really.
> 
> Avoiding infinite wait/poll is one of the goals, another is to sleep.
> If we think the timeout is hard, we can start from the wait.
> 
> Thanks

If the goal is to avoid disrupting traffic while CVQ is in use,
that sounds more reasonable. E.g. someone is turning on promisc,
a spike in CPU usage might be unwelcome.

things we should be careful to address then:
1- debugging. Currently it's easy to see a warning if CPU is stuck
   in a loop for a while, and we also get a backtrace.
   E.g. with this - how do we know who has the RTNL?
   We need to integrate with kernel/watchdog.c for good results
   and to make sure policy is consistent.
2- overhead. In a very common scenario when device is in hypervisor,
   programming timers etc has a very high overhead, at bootup
   lots of CVQ commands are run and slowing boot down is not nice.
   let's poll for a bit before waiting?
3- suprise removal. need to wake up thread in some way. what about
   other cases of device breakage - is there a chance this
   introduces new bugs around that? at least enumerate them please.


-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
