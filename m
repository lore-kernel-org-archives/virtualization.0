Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B6C1CD80D5
	for <virtualization@archiver.kernel.org>; Tue, 10 Oct 2023 13:56:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DF26F61369;
	Tue, 10 Oct 2023 13:56:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DF26F61369
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JQO+VrUM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id D1HCbzukltLP; Tue, 10 Oct 2023 13:56:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5C94560FD0;
	Tue, 10 Oct 2023 13:56:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5C94560FD0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3FBB5C0071;
	Tue, 10 Oct 2023 13:56:21 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D9ADBC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 13:56:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B50FA813CC
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 13:56:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B50FA813CC
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JQO+VrUM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hI9UkcYasNum
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 13:56:19 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id EAA2D80314
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 13:56:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org EAA2D80314
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696946177;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8/nFjvwS56V7OUAo4D2QoDI4RZYmaHavyYCmq+zkU0g=;
 b=JQO+VrUMn5OnKGdEp4k8wfTO3f1qNqS8P0qhuKC5AAtO5A7MQLkTFhnpYG50zjQCrBK0VR
 Xp0zXFWGSY4jqoDbBb8tBEY08xBPvz0krQRy0zdcg/PAgGGR36/ADVTdOZ5jXbAcanuK+h
 6ppNZwf3ulLnGHyAEJtg+mwThYWZaN0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-533-rd4-2oO6OPa3hG9e01p-bw-1; Tue, 10 Oct 2023 09:56:06 -0400
X-MC-Unique: rd4-2oO6OPa3hG9e01p-bw-1
Received: by mail-wm1-f71.google.com with SMTP id
 5b1f17b1804b1-4055ce1e8c4so30362995e9.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:56:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696946165; x=1697550965;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8/nFjvwS56V7OUAo4D2QoDI4RZYmaHavyYCmq+zkU0g=;
 b=mJFPozEbtzxR6vOqgkY4R9eDGlUCia24nDm8iQsJD1Vyg/7f1TvQ+p2QqLIokd0jnG
 BzavKt7Gz0xEIoEcZ2qKD80+cGWq+nYRnnznAkGJf/Fz1cK3j6/JxDkLvn5WHhgovW8f
 UFEb5Hl2P7gg5LukU1ebjW167VxLUGa8QajrhJGU20rJDYjbbSUl0ovms1kkI+i/WXfi
 j/s64/pODp3hl94UzNynCAdXZQGYkuVQpRJtladYj78oYvyg4Wft3zsGY5WSbwWv8COU
 iLvkaQw5VV4Fqqhr3thC2cO/9EKb2lGp4HDXeeehJVK5XFyQh7FEuhQjf8sZx3zhTViC
 6skg==
X-Gm-Message-State: AOJu0YzPz2Zytx3o7o494kLMPR1Cp1BY+HjiBoZhVuNY1bf+ez6PDpbw
 wps8BTwbmTmvcLp6n0PVOCCBT4lKUJjODjTNhUqRaT3e7qczyrPqh4Edf9SQEAiSwR0wdxO3hPL
 /NO1893SMyWlyTjJxL70ymcQclxiPlyNHSqcVNWAnFg==
X-Received: by 2002:a05:600c:2187:b0:401:b0f2:88d3 with SMTP id
 e7-20020a05600c218700b00401b0f288d3mr12644055wme.19.1696946165447; 
 Tue, 10 Oct 2023 06:56:05 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGPR74xcoRnn7rHPwNnL+k0ait5tAnM9xrQDqU+TQYe1Lpr60Cr97Kw6Gsuf7NuKa0hpjMTCw==
X-Received: by 2002:a05:600c:2187:b0:401:b0f2:88d3 with SMTP id
 e7-20020a05600c218700b00401b0f288d3mr12644030wme.19.1696946165016; 
 Tue, 10 Oct 2023 06:56:05 -0700 (PDT)
Received: from redhat.com ([147.235.219.90]) by smtp.gmail.com with ESMTPSA id
 s17-20020a1cf211000000b00405623e0186sm16576404wmc.26.2023.10.10.06.56.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 06:56:04 -0700 (PDT)
Date: Tue, 10 Oct 2023 09:56:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Message-ID: <20231010094756-mutt-send-email-mst@kernel.org>
References: <20230921124040.145386-11-yishaih@nvidia.com>
 <20230922055336-mutt-send-email-mst@kernel.org>
 <c3724e2f-7938-abf7-6aea-02bfb3881151@nvidia.com>
 <20230926072538-mutt-send-email-mst@kernel.org>
 <ZRpjClKM5mwY2NI0@infradead.org>
 <20231002151320.GA650762@nvidia.com>
 <ZR54shUxqgfIjg/p@infradead.org>
 <20231005111004.GK682044@nvidia.com>
 <ZSAG9cedvh+B0c0E@infradead.org> <20231010131031.GJ3952@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20231010131031.GJ3952@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, maorg@nvidia.com,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, jiri@nvidia.com, leonro@nvidia.com
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

On Tue, Oct 10, 2023 at 10:10:31AM -0300, Jason Gunthorpe wrote:
> > > There is alot of code in VFIO and the VMM side to take a VF and turn
> > > it into a vPCI function. You can't just trivially duplicate VFIO in a
> > > dozen drivers without creating a giant mess.
> > 
> > I do not advocate for duplicating it.  But the code that calls this
> > functionality belongs into the driver that deals with the compound
> > device that we're doing this work for.
> 
> On one hand, I don't really care - we can put the code where people
> like.
> 
> However - the Intel GPU VFIO driver is such a bad experiance I don't
> want to encourage people to make VFIO drivers, or code that is only
> used by VFIO drivers, that are not under drivers/vfio review.

So if Alex feels it makes sense to add some virtio functionality
to vfio and is happy to maintain or let you maintain the UAPI
then why would I say no? But we never expected devices to have
two drivers like this does, so just exposing device pointer
and saying "use regular virtio APIs for the rest" does not
cut it, the new APIs have to make sense
so virtio drivers can develop normally without fear of stepping
on the toes of this admin driver.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
