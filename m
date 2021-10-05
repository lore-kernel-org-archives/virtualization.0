Return-Path: <SRS0=LBOH=OZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 407ECC433FE
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 11:55:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D7844613AC
	for <virtualization@archiver.kernel.org>; Tue,  5 Oct 2021 11:55:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D7844613AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 981B760AEA;
	Tue,  5 Oct 2021 11:55:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8bdcCZkVsQzf; Tue,  5 Oct 2021 11:55:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1F3C4605E7;
	Tue,  5 Oct 2021 11:55:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 03A8AC000F;
	Tue,  5 Oct 2021 11:55:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07074C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 11:55:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E83CD402C6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 11:55:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NA862MCoD-iZ
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 11:55:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DFBF04011B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  5 Oct 2021 11:55:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1633434908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=751Mq58IyY6njGZql4czNj7G+CX1GwSnnuMROueTMmM=;
 b=eH0pIe3ZZBU4NCfNOuIBCbPcZR0NLBzepRX38LF45wC3iU62TdeFxk7nHbmd6GlSxdr6jR
 +D2/gHlJDu5hE+9z9InxX0tgtMWUqaopSqzUxmeBkuHtvVMIDGcmoMPeixNGZvZMlrRU84
 hQlHlSMGpG5Cih9Nld129vX49wH56BM=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-8VFEOA_DNFuAs2lYipX5LA-1; Tue, 05 Oct 2021 07:55:07 -0400
X-MC-Unique: 8VFEOA_DNFuAs2lYipX5LA-1
Received: by mail-ed1-f72.google.com with SMTP id
 r11-20020aa7cfcb000000b003d4fbd652b9so20361952edy.14
 for <virtualization@lists.linux-foundation.org>;
 Tue, 05 Oct 2021 04:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=751Mq58IyY6njGZql4czNj7G+CX1GwSnnuMROueTMmM=;
 b=WBi712RYnO0zuBHslaX8QTxrRDhweKPaoGRkx4al3TYPN3D+LvW67nRs4qaH3lZ8VB
 crGCbU2QFICBJDfnmHCxTw9Xz04WglJ5JCi2JVAVI6Mdn9xwYoqiO22y8vzS3wKcN7ek
 ljktNVJNRWcfJ+hvKN1sCXiFw6SkKFe43zWfzxaccr9mMOeieDdM8G32yTCuuUxFGI7A
 wjlrqZydk5IUpEPZdUnVhOCbsQPofs5RKIgOmnuHXp473VuvBPjZy8vsniLneHtBj3b3
 639yY9+IuwjOUhUOyBoWMZEyX/Q0ogsuLKXb9nANujZzVYVXfOVLUBqlixz9McE0a3ck
 SGNQ==
X-Gm-Message-State: AOAM530FigSgjfBTpMvjpopzeoFhyvcLRxrquD+UypvfFhP2qygCd/GZ
 ly8QOZm03QzTiCcTFF1CkUC2mEHAShXiJ8gJz7S1jnkr7MolhRB0T9Og6bv3HeOSrL9nCfqAUur
 WDif0jWlvH6z8BmYwwX+laZqHU64fGNtNFRspxmW0IQ==
X-Received: by 2002:aa7:dcca:: with SMTP id w10mr9306074edu.113.1633434906573; 
 Tue, 05 Oct 2021 04:55:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxKDDgPsgNIUpsi1sJPCxnLqF7SOpHow7WZJ20HTv9RycP25PPJd6O0cpLj5bn/LJOFxmdAmA==
X-Received: by 2002:aa7:dcca:: with SMTP id w10mr9306046edu.113.1633434906347; 
 Tue, 05 Oct 2021 04:55:06 -0700 (PDT)
Received: from redhat.com ([2.55.147.134])
 by smtp.gmail.com with ESMTPSA id k23sm1850590edv.22.2021.10.05.04.55.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 05 Oct 2021 04:55:05 -0700 (PDT)
Date: Tue, 5 Oct 2021 07:55:02 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Laurent Vivier <lvivier@redhat.com>
Subject: Re: [PATCH 1/4] hwrng: virtio - add an internal buffer
Message-ID: <20211005075433-mutt-send-email-mst@kernel.org>
References: <20210922170903.577801-1-lvivier@redhat.com>
 <20210922170903.577801-2-lvivier@redhat.com>
 <20210922145651-mutt-send-email-mst@kernel.org>
 <0dd338bb-0fbe-b9d5-0962-d47ac2de4c4e@redhat.com>
 <20210923030026-mutt-send-email-mst@kernel.org>
 <fcd17df1-5aed-346b-e7cd-abe4dfb67e69@redhat.com>
MIME-Version: 1.0
In-Reply-To: <fcd17df1-5aed-346b-e7cd-abe4dfb67e69@redhat.com>
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

On Thu, Sep 23, 2021 at 09:34:18AM +0200, Laurent Vivier wrote:
> On 23/09/2021 09:04, Michael S. Tsirkin wrote:
> > On Thu, Sep 23, 2021 at 08:26:06AM +0200, Laurent Vivier wrote:
> > > On 22/09/2021 21:02, Michael S. Tsirkin wrote:
> > > > On Wed, Sep 22, 2021 at 07:09:00PM +0200, Laurent Vivier wrote:
> > > > > hwrng core uses two buffers that can be mixed in the
> > > > > virtio-rng queue.
> > > > > 
> > > > > If the buffer is provided with wait=0 it is enqueued in the
> > > > > virtio-rng queue but unused by the caller.
> > > > > On the next call, core provides another buffer but the
> > > > > first one is filled instead and the new one queued.
> > > > > And the caller reads the data from the new one that is not
> > > > > updated, and the data in the first one are lost.
> > > > > 
> > > > > To avoid this mix, virtio-rng needs to use its own unique
> > > > > internal buffer at a cost of a data copy to the caller buffer.
> > > > > 
> > > > > Signed-off-by: Laurent Vivier <lvivier@redhat.com>
> > > > > ---
> > > > >    drivers/char/hw_random/virtio-rng.c | 43 ++++++++++++++++++++++-------
> > > > >    1 file changed, 33 insertions(+), 10 deletions(-)
> > > > > 
> > > > > diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> > > > > index a90001e02bf7..208c547dcac1 100644
> > > > > --- a/drivers/char/hw_random/virtio-rng.c
> > > > > +++ b/drivers/char/hw_random/virtio-rng.c
> > > > > @@ -18,13 +18,20 @@ static DEFINE_IDA(rng_index_ida);
> > > > >    struct virtrng_info {
> > > > >    	struct hwrng hwrng;
> > > > >    	struct virtqueue *vq;
> > > > > -	struct completion have_data;
> > > > >    	char name[25];
> > > > > -	unsigned int data_avail;
> > > > >    	int index;
> > > > >    	bool busy;
> > > > >    	bool hwrng_register_done;
> > > > >    	bool hwrng_removed;
> > > > > +	/* data transfer */
> > > > > +	struct completion have_data;
> > > > > +	unsigned int data_avail;
> > > > > +	/* minimal size returned by rng_buffer_size() */
> > > > > +#if SMP_CACHE_BYTES < 32
> > > > > +	u8 data[32];
> > > > > +#else
> > > > > +	u8 data[SMP_CACHE_BYTES];
> > > > > +#endif
> > > > 
> > > > Let's move this logic to a macro in hw_random.h ?
> > > > 
> > > > >    };
> > > > >    static void random_recv_done(struct virtqueue *vq)
> > > > > @@ -39,14 +46,14 @@ static void random_recv_done(struct virtqueue *vq)
> > > > >    }
> > > > >    /* The host will fill any buffer we give it with sweet, sweet randomness. */
> > > > > -static void register_buffer(struct virtrng_info *vi, u8 *buf, size_t size)
> > > > > +static void register_buffer(struct virtrng_info *vi)
> > > > >    {
> > > > >    	struct scatterlist sg;
> > > > > -	sg_init_one(&sg, buf, size);
> > > > > +	sg_init_one(&sg, vi->data, sizeof(vi->data));
> > > > 
> > > > Note that add_early_randomness requests less:
> > > >           size_t size = min_t(size_t, 16, rng_buffer_size());
> > > > 
> > > > maybe track how much was requested and grow up to sizeof(data)?
> > > 
> > > I think this problem is managed by PATCH 3/4 as we reuse unused data of the buffer.
> > 
> > the issue I'm pointing out is that we are requesting too much
> > entropy from host - more than guest needs.
> 
> Yes, guest asks for 16 bytes, but we request SMP_CACHE_BYTES (64 on x86_64),
> and these 16 bytes are used with add_device_randomness(). With the following
> patches, the remaining 48 bytes are used rapidly by hwgnd kthread or by the
> next virtio_read.
> 
> If there is no enough entropy the call is simply ignored as wait=0.
> 
> At this patch level the call is always simply ignored (because wait=0) and
> the data requested here are used by the next read that always asks for a
> SMP_CACHE_BYTES bytes data size.
> 
> Moreover in PATCH 4/4 we always have a pending request of size
> SMP_CACHE_BYTES, so driver always asks a block of this size and the guest
> takes what it needs.
> 
> Originally I used a 16 bytes block but performance are divided by 4.
> 
> Do you propose something else?
> 
> Thanks,
> Laurent

Maybe min(size, sizeof(vi->data))?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
