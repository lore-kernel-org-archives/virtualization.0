Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9239DCD8C9C
	for <virtualization@archiver.kernel.org>; Tue, 10 Oct 2023 14:54:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0EB448226B;
	Tue, 10 Oct 2023 14:54:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0EB448226B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=T1fyuf/b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QjDe7YSLipXF; Tue, 10 Oct 2023 14:54:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 99F688226F;
	Tue, 10 Oct 2023 14:54:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 99F688226F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 74807C0039;
	Tue, 10 Oct 2023 14:54:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 46CD2C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 14:54:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2D17F41BAA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 14:54:35 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2D17F41BAA
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=T1fyuf/b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ito8YMNWcc25
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 14:54:32 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 38E1E41B9B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 14:54:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 38E1E41B9B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696949671;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=vH/MnbtKKOMlCHZOBuk2f+A+YeXj1EEx7KSK3diMmgU=;
 b=T1fyuf/bxWJp/zJY9UqO0ZYlNnVBl/kt39g8Yg75L4QdhviOd3r0vfSAi/ZlEHz8DLj1pY
 pwWYmfNOYcz72tJ0Vb+NxyUSBjNOLAiZifMJ35rrMJOq6VTnX68CmUXAlnVFxf4qmqD8Kw
 B4a78bxtzScqFhf1tEzZQ2iGGGCpy1w=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-518-JJRQYY2GMh62gvcHbFJkoQ-1; Tue, 10 Oct 2023 10:54:29 -0400
X-MC-Unique: JJRQYY2GMh62gvcHbFJkoQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-406710d9a4aso44917025e9.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 07:54:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696949668; x=1697554468;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=vH/MnbtKKOMlCHZOBuk2f+A+YeXj1EEx7KSK3diMmgU=;
 b=IYZGirxihARgzSN1hTpagSeAJR5zaxKksHMbNQQ3eAjZ+LhQ5zOsajW6d6xpdkTxR5
 leiE42GO+h0Cq8GSlKaELMsquoi0ZaxQYo7O1XEarrMZwcm8sdVSwhp+zWGZbGJWavQK
 RMnHyWIy6OmLFnaBWsPWo69oKl46yTEoy4+jJzJsBuB0N/vyd+x4HjR0hylm+nZTKl6K
 PX3LcGISShF2WkVtt+SrG8IkqbgS+pszzLUypMjA9XUczNzuAzEE43I+49wEZCuYWNFl
 f6tpK5cE0rDGmD8Qftxx2RfOkLX63r0H9S0XrnIg4zHAVIVNGdN1YfY6mxbPpdPncsQe
 BJNw==
X-Gm-Message-State: AOJu0Yy+HklkrmQ0noT+SXb2EXkV+7mbl4iulFB8sa6fCi/w61mKyIhr
 dNWN1E0OJR5H8vgFnzrK1ku6W8owLsi8hSOP2YTClACROJAVOC7JCsIXb4d1FFvmPll99RLnP6s
 /+nnqwgzIxLgNd6aaPiOXz3aaOHaWprfVNZH326qePA==
X-Received: by 2002:a05:600c:d1:b0:405:3a3d:6f42 with SMTP id
 u17-20020a05600c00d100b004053a3d6f42mr16390018wmm.39.1696949668257; 
 Tue, 10 Oct 2023 07:54:28 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHwxS+5Hdl6YIlvPeBVrNrp4ft3RNUHoqkj2WG1fNEpSoTU00S2AQrMpg6XmmwADS1I11lK7w==
X-Received: by 2002:a05:600c:d1:b0:405:3a3d:6f42 with SMTP id
 u17-20020a05600c00d100b004053a3d6f42mr16390004wmm.39.1696949667941; 
 Tue, 10 Oct 2023 07:54:27 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 s11-20020a7bc38b000000b003fbe4cecc3bsm16612016wmj.16.2023.10.10.07.54.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Oct 2023 07:54:27 -0700 (PDT)
Date: Tue, 10 Oct 2023 10:54:24 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Gunthorpe <jgg@nvidia.com>
Subject: Re: [PATCH vfio 10/11] vfio/virtio: Expose admin commands over
 virtio device
Message-ID: <20231010105339-mutt-send-email-mst@kernel.org>
References: <c3724e2f-7938-abf7-6aea-02bfb3881151@nvidia.com>
 <20230926072538-mutt-send-email-mst@kernel.org>
 <ZRpjClKM5mwY2NI0@infradead.org>
 <20231002151320.GA650762@nvidia.com>
 <ZR54shUxqgfIjg/p@infradead.org>
 <20231005111004.GK682044@nvidia.com>
 <ZSAG9cedvh+B0c0E@infradead.org> <20231010131031.GJ3952@nvidia.com>
 <20231010094756-mutt-send-email-mst@kernel.org>
 <20231010140849.GL3952@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20231010140849.GL3952@nvidia.com>
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

On Tue, Oct 10, 2023 at 11:08:49AM -0300, Jason Gunthorpe wrote:
> On Tue, Oct 10, 2023 at 09:56:00AM -0400, Michael S. Tsirkin wrote:
> 
> > > However - the Intel GPU VFIO driver is such a bad experiance I don't
> > > want to encourage people to make VFIO drivers, or code that is only
> > > used by VFIO drivers, that are not under drivers/vfio review.
> > 
> > So if Alex feels it makes sense to add some virtio functionality
> > to vfio and is happy to maintain or let you maintain the UAPI
> > then why would I say no? But we never expected devices to have
> > two drivers like this does, so just exposing device pointer
> > and saying "use regular virtio APIs for the rest" does not
> > cut it, the new APIs have to make sense
> > so virtio drivers can develop normally without fear of stepping
> > on the toes of this admin driver.
> 
> Please work with Yishai to get something that make sense to you. He
> can post a v2 with the accumulated comments addressed so far and then
> go over what the API between the drivers is.
> 
> Thanks,
> Jason

/me shrugs. I pretty much posted suggestions already. Should not be hard.
Anything unclear - post on list.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
