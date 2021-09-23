Return-Path: <SRS0=2rcL=ON=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 02E34C433F5
	for <virtualization@archiver.kernel.org>; Thu, 23 Sep 2021 07:04:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95A76611C6
	for <virtualization@archiver.kernel.org>; Thu, 23 Sep 2021 07:04:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 95A76611C6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 54C9761534;
	Thu, 23 Sep 2021 07:04:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1lEPoEZMM6Nk; Thu, 23 Sep 2021 07:04:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D218561519;
	Thu, 23 Sep 2021 07:04:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE104C0011;
	Thu, 23 Sep 2021 07:04:35 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6EEABC000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 07:04:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6B87B6151E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 07:04:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zFc5TRvZFulf
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 07:04:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AF97561519
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 07:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632380672;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=sHWe/4xEkfiCD6fVR0vhWpP/mCzT888yzZbNxm0TXDw=;
 b=HX8/gKkn/bu9LovOtCZEpVf6npKfCCc0WZVmaKk3wLoiRHRbY1j7OYys1vbeJ8ZKePjRLV
 b8I+ZXJe3akHuWhAbDj1NNyP0M77dkHnUDO9voPaYXXyO2gfrlBjrEXGqzpNtMsLdlhM8D
 2jK+f6KUsXU7VuyRtXarz1q+YycvA2g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-98-ddN_ecwCOJSUbeBzO78QGw-1; Thu, 23 Sep 2021 03:04:31 -0400
X-MC-Unique: ddN_ecwCOJSUbeBzO78QGw-1
Received: by mail-wr1-f70.google.com with SMTP id
 i4-20020a5d5224000000b0015b14db14deso4263550wra.23
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Sep 2021 00:04:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=sHWe/4xEkfiCD6fVR0vhWpP/mCzT888yzZbNxm0TXDw=;
 b=bnZtT5wZ527ZGdms9Unryv87E5EdU/KUlMN3Ms+GMZAAo420F8ruLi8gXKosxi/KBZ
 1NrvYMhaFB49HFqVLEek33ajVHEDWmi5gCZEaT/9Ffps7C3xoN1s9ak4lZRoDHtrMQlI
 fAhYG0FrrqKsAocp+rHJPI2nCFlviZ671qN66MG2BdhLK49fnm6VNqzOcFHx/u54HaRf
 1XW7uquGQDjJZHzuN3rW8+vF/6G9rNg2JFY8gFtKMe1mIHJu403XT0OVHjmCo+knXXTT
 v06sZC9N4dLp5drGyzZLAVgrEGsBXYVD1Qda5/YQyVT6D02wJE59ydyo2U8r5tSOj6+x
 JVrw==
X-Gm-Message-State: AOAM533uDOiHh9we3MYsY3GUSMUCyj0ip+e6q2zu8BF8Ffh7M+vg7pvG
 c1MF2kg5NtTBuqD0OXcRsLOa5vjGmTsOsFkBdI+Oxkab8okxvivNZizH3b2pAH7J2Cb/qSvS7dj
 ko/rqxnLA31qh6gBjWBVFj5iIEHWYgAu9EjNorX5lSw==
X-Received: by 2002:adf:d1eb:: with SMTP id g11mr3231297wrd.194.1632380669936; 
 Thu, 23 Sep 2021 00:04:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxyhNcyRrQ0UISVsN6EX3ylQ1wmCRTHutBo4vW6SvawXhtq0ItioLRisgG4k4kuB/oaOyTIpg==
X-Received: by 2002:adf:d1eb:: with SMTP id g11mr3231280wrd.194.1632380669659; 
 Thu, 23 Sep 2021 00:04:29 -0700 (PDT)
Received: from redhat.com ([2.55.11.56])
 by smtp.gmail.com with ESMTPSA id o26sm8181379wmc.17.2021.09.23.00.04.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Sep 2021 00:04:28 -0700 (PDT)
Date: Thu, 23 Sep 2021 03:04:23 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 1/4] hwrng: virtio - add an internal buffer
Message-ID: <20210923030026-mutt-send-email-mst@kernel.org>
References: <20210922170903.577801-1-lvivier@redhat.com>
 <20210922170903.577801-2-lvivier@redhat.com>
 <20210922145651-mutt-send-email-mst@kernel.org>
 <0dd338bb-0fbe-b9d5-0962-d47ac2de4c4e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <0dd338bb-0fbe-b9d5-0962-d47ac2de4c4e@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Herbert Xu <herbert@gondor.apana.org.au>, amit@kernel.org,
 rusty@rustcorp.com.au, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Alexander Potapenko <glider@google.com>, linux-crypto@vger.kernel.org,
 Matt Mackall <mpm@selenic.com>, akong@redhat.com,
 Dmitriy Vyukov <dvyukov@google.com>
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

On Thu, Sep 23, 2021 at 08:26:06AM +0200, Laurent Vivier wrote:
> On 22/09/2021 21:02, Michael S. Tsirkin wrote:
> > On Wed, Sep 22, 2021 at 07:09:00PM +0200, Laurent Vivier wrote:
> > > hwrng core uses two buffers that can be mixed in the
> > > virtio-rng queue.
> > > 
> > > If the buffer is provided with wait=0 it is enqueued in the
> > > virtio-rng queue but unused by the caller.
> > > On the next call, core provides another buffer but the
> > > first one is filled instead and the new one queued.
> > > And the caller reads the data from the new one that is not
> > > updated, and the data in the first one are lost.
> > > 
> > > To avoid this mix, virtio-rng needs to use its own unique
> > > internal buffer at a cost of a data copy to the caller buffer.
> > > 
> > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > > ---
> > >   drivers/char/hw_random/virtio-rng.c | 43 ++++++++++++++++++++++-------
> > >   1 file changed, 33 insertions(+), 10 deletions(-)
> > > 
> > > diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> > > index a90001e02bf7..208c547dcac1 100644
> > > --- a/drivers/char/hw_random/virtio-rng.c
> > > +++ b/drivers/char/hw_random/virtio-rng.c
> > > @@ -18,13 +18,20 @@ static DEFINE_IDA(rng_index_ida);
> > >   struct virtrng_info {
> > >   	struct hwrng hwrng;
> > >   	struct virtqueue *vq;
> > > -	struct completion have_data;
> > >   	char name[25];
> > > -	unsigned int data_avail;
> > >   	int index;
> > >   	bool busy;
> > >   	bool hwrng_register_done;
> > >   	bool hwrng_removed;
> > > +	/* data transfer */
> > > +	struct completion have_data;
> > > +	unsigned int data_avail;
> > > +	/* minimal size returned by rng_buffer_size() */
> > > +#if SMP_CACHE_BYTES < 32
> > > +	u8 data[32];
> > > +#else
> > > +	u8 data[SMP_CACHE_BYTES];
> > > +#endif
> > 
> > Let's move this logic to a macro in hw_random.h ?
> > 
> > >   };
> > >   static void random_recv_done(struct virtqueue *vq)
> > > @@ -39,14 +46,14 @@ static void random_recv_done(struct virtqueue *vq)
> > >   }
> > >   /* The host will fill any buffer we give it with sweet, sweet randomness. */
> > > -static void register_buffer(struct virtrng_info *vi, u8 *buf, size_t size)
> > > +static void register_buffer(struct virtrng_info *vi)
> > >   {
> > >   	struct scatterlist sg;
> > > -	sg_init_one(&sg, buf, size);
> > > +	sg_init_one(&sg, vi->data, sizeof(vi->data));
> > 
> > Note that add_early_randomness requests less:
> >          size_t size = min_t(size_t, 16, rng_buffer_size());
> > 
> > maybe track how much was requested and grow up to sizeof(data)?
> 
> I think this problem is managed by PATCH 3/4 as we reuse unused data of the buffer.

the issue I'm pointing out is that we are requesting too much
entropy from host - more than guest needs.

> > 
> > >   	/* There should always be room for one buffer. */
> > > -	virtqueue_add_inbuf(vi->vq, &sg, 1, buf, GFP_KERNEL);
> > > +	virtqueue_add_inbuf(vi->vq, &sg, 1, vi->data, GFP_KERNEL);
> > 
> > 
> > BTW no longer true if DMA API is in use ... not easy to fix,
> > I think some changes to virtio API to allow pre-mapping
> > s/g for DMA might be needed ...
> 
> Is there something I can do here?
> 
> Thanks,
> Laurent

We can let it be for now, but down the road I think we should
support a way to pre-map memory for DMA.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
