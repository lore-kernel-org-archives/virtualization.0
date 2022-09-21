Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0269CECAAD8
	for <virtualization@archiver.kernel.org>; Wed, 21 Sep 2022 15:21:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6130861038;
	Wed, 21 Sep 2022 15:21:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6130861038
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GxEcKPUY
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PpueBCkYwFwD; Wed, 21 Sep 2022 15:21:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D86FE60F4C;
	Wed, 21 Sep 2022 15:21:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D86FE60F4C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD41FC0033;
	Wed, 21 Sep 2022 15:21:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 44706C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 15:21:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 12F1761038
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 15:21:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 12F1761038
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WObsb1QI8lHU
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 15:21:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3BB0260F4C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3BB0260F4C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 15:21:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1663773709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=YKklums/Err7Bepni4gts8csmAXQyEMPG5WxwPmhH+I=;
 b=GxEcKPUY6x8GKCTIvvYfgU0IKXTcJYP+z8KSGysJujd4QqrGKei51TdQer7gPwU9ZpB4MC
 0w7e1lxXmAZsSDoXQmApETCjMkhnryjZFoDM4z6vntA9zYbSAU9z/rMYvJcj8uV1faPSxs
 5gInuxDZ03dGL1yZx0SzAn8+egrm6CU=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-511-eSOhAr-MNc2okMu2fW2JrA-1; Wed, 21 Sep 2022 11:21:40 -0400
X-MC-Unique: eSOhAr-MNc2okMu2fW2JrA-1
Received: by mail-qt1-f200.google.com with SMTP id
 fe14-20020a05622a4d4e00b0035cc376b1d5so4370864qtb.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Sep 2022 08:21:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=YKklums/Err7Bepni4gts8csmAXQyEMPG5WxwPmhH+I=;
 b=xLWcuz/D/GzRl0SM03WPAfekdGuAjh0ozRMRG1HHdQVGm0UKYFJcnES6O15Ytk3NJa
 cDl7RVaYL0N9kPDHokjDpEgBqp9GZ0gatsRA9vDuprn2eMq4e7xaKXiRbmTf5KiD6UQB
 nuF4BVeCl1++OTQdI6c8QsF/3k+kwb6XJKyPmsp3L20jgASmF81W8YMKVnEHfoC+Ocn6
 6R23MpLm42llVwUl0EZHtrtaxMAbNnl+02H4qTe2Rk4jhPaowu3oVbHagKOLcfPi2Q4+
 yOtP11xeP7hno90nvod9wVoQIW/0boF3jGvAo6EKN80TseEHBsywG9fSPCcWp6VikE50
 zVVw==
X-Gm-Message-State: ACrzQf2oVjl5sb3gq9nSXGIML2C4fsmdk1h+NieqTWCIC5U4ZEpIPnMM
 iPnDvjmBJvxGpRRXcp5qpxJ5IvLUGLPpTURbq1tulEHCJth3kXybffLAQ7AgjFfIJq8e8DN7A3M
 irHk6ktQVpVGaK9P/GPnMUoRvd9sNiP8PBrCUk5Mi
X-Received: by 2002:a05:622a:613:b0:342:f81f:4f7e with SMTP id
 z19-20020a05622a061300b00342f81f4f7emr23848816qta.198.1663773699683; 
 Wed, 21 Sep 2022 08:21:39 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM7OzWfjG2GRtTFHT6VQqKwenYDGxd0vRx6UOENP8cSn03FrcY2GR/YED/OGOmZJunHnK1JMlw==
X-Received: by 2002:a05:622a:613:b0:342:f81f:4f7e with SMTP id
 z19-20020a05622a061300b00342f81f4f7emr23848782qta.198.1663773699383; 
 Wed, 21 Sep 2022 08:21:39 -0700 (PDT)
Received: from localhost ([217.138.198.196]) by smtp.gmail.com with ESMTPSA id
 cf14-20020a05622a400e00b0031f41ea94easm1815844qtb.28.2022.09.21.08.21.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 21 Sep 2022 08:21:39 -0700 (PDT)
Date: Wed, 21 Sep 2022 11:21:37 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Sarthak Kukreti <sarthakkukreti@chromium.org>
Subject: Re: [PATCH RFC 4/8] fs: Introduce FALLOC_FL_PROVISION
Message-ID: <YyssAb/zTcIG2bev@redhat.com>
References: <20220915164826.1396245-1-sarthakkukreti@google.com>
 <20220915164826.1396245-5-sarthakkukreti@google.com>
 <YylweQAZkIdb5ixo@infradead.org>
 <CAG9=OMNoG01UUStNs_Zhsv6mXZw0M0q2v54ZriJvHZ4aspvjEQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAG9=OMNoG01UUStNs_Zhsv6mXZw0M0q2v54ZriJvHZ4aspvjEQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
 Theodore Ts'o <tytso@mit.edu>, "Michael S . Tsirkin" <mst@redhat.com>,
 Bart Van Assche <bvanassche@google.com>, Mike Snitzer <snitzer@kernel.org>,
 linux-kernel@vger.kernel.org, Gwendal Grignou <gwendal@google.com>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, dm-devel@redhat.com,
 Andreas Dilger <adilger.kernel@dilger.ca>, Daniil Lunev <dlunev@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 linux-ext4@vger.kernel.org, Evan Green <evgreen@google.com>,
 Alasdair Kergon <agk@redhat.com>
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

On Wed, Sep 21 2022 at  1:54P -0400,
Sarthak Kukreti <sarthakkukreti@chromium.org> wrote:

> On Tue, Sep 20, 2022 at 12:49 AM Christoph Hellwig <hch@infradead.org> wrote:
> >
> > On Thu, Sep 15, 2022 at 09:48:22AM -0700, Sarthak Kukreti wrote:
> > > From: Sarthak Kukreti <sarthakkukreti@chromium.org>
> > >
> > > FALLOC_FL_PROVISION is a new fallocate() allocation mode that
> > > sends a hint to (supported) thinly provisioned block devices to
> > > allocate space for the given range of sectors via REQ_OP_PROVISION.
> >
> > So, how does that "provisioning" actually work in todays world where
> > storage is usually doing out of place writes in one or more layers,
> > including the flash storage everyone is using.  Does it give you one
> > write?  And unlimited number?  Some undecided number inbetween?
> 
> Apologies, the patchset was a bit short on describing the semantics so
> I'll expand more in the next revision; I'd say that it's the minimum
> of regular mode fallocate() guarantees at each allocation layer. For
> example, the guarantees from a contrived storage stack like (left to
> right is bottom to top):
> 
> [ mmc0blkp1 | ext4(1) | sparse file | loop | dm-thinp | dm-thin | ext4(2) ]
> 
> would be predicated on the guarantees of fallocate() per allocation
> layer; if ext4(1) was replaced by a filesystem that did not support
> fallocate(), then there would be no guarantee that a write to a file
> on ext4(2) succeeds.
> 
> For dm-thinp, in the current implementation, the provision request
> allocates blocks for the range specified and adds the mapping to the
> thinpool metadata. All subsequent writes are to the same block, so
> you'll be able to write to the same block inifinitely. Brian mentioned
> this above, one case it doesn't cover is if provision is called on a
> shared block, but the natural extension would be to allocate and
> assign a new block and copy the contents of the shared block (kind of
> like copy-on-provision).

It follows that ChromiumOS isn't using dm-thinp's snapshot support?

But please do fold in incremental dm-thinp support to properly handle
shared blocks (dm-thinp already handles breaking sharing, etc.. so
I'll need to see where you're hooking into that you don't get this
"for free").

Mike

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
