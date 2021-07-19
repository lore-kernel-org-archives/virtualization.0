Return-Path: <SRS0=a9bH=ML=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B85DCC07E9D
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 12:05:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 693E260200
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 12:05:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 693E260200
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2998F4028F;
	Mon, 19 Jul 2021 12:05:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RlH5rlceWJCP; Mon, 19 Jul 2021 12:05:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 884E940235;
	Mon, 19 Jul 2021 12:05:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4E106C0010;
	Mon, 19 Jul 2021 12:05:04 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 92D96C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 12:05:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 812EE40187
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 12:05:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NJUcJfEg6H8i
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 12:05:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 4412F400FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 12:05:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626696299;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=jHzwTbLR9eQDz6e+1sLHFsL5glt/mpmZl0Q3gFBDrMk=;
 b=fGJzvchZcqQbh5XwqeepdZnuPHznZOKyFuDzU6zuQAtVmERUAMMMut8Uphm4aql7+dgF/n
 Hjf99ReE6EM61NmnqXGx/Y05QANN9UdANae/DoU/lEi1lQ49I9fsBgSVtPH85IUO8Foy6M
 pX2KDaWM+jcAVfc5m3/pB+d761b7EQg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-NmNJzYiAMf2FWEiEyPKrJg-1; Mon, 19 Jul 2021 08:04:58 -0400
X-MC-Unique: NmNJzYiAMf2FWEiEyPKrJg-1
Received: by mail-ed1-f70.google.com with SMTP id
 o6-20020a0564024386b02903a7ebf6dc50so9156378edc.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 05:04:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=jHzwTbLR9eQDz6e+1sLHFsL5glt/mpmZl0Q3gFBDrMk=;
 b=kMe9RLwEuOXpdM9MOj94yGZJ23KIe2OQO0lMazHJdNetCyaWtca920qaGj7WOWqFp1
 qSeaI+9IlAOIqSBoE69UtBaU2aE75VS4PU8lpLEyoARMJECDGsaxuO9U3Y6YukHfdky0
 DHuRH9N9LSNGjaUMaSzDN+mJlgKUJu3ihPWsEGl0e+kkFaSRVrfDcxi9GSMbDflrblMb
 u90QAvwY06FVkhT2d8R563jJAiDU8HsBnnH5oG2XCKNVUZCYqoSg4LHNoVOBZDMi7q5B
 HmMv1vGkc5r0IqPeXJh2dP1+UpGjcF7Tmozkyc6n0seGlZoOFUMU20DAsPS9YMujTY1r
 MkXA==
X-Gm-Message-State: AOAM531gi6vZOfFFRfDE+7HYid47v1jhAKNqtJFGCzwu0JBBZP/iqZlc
 tHl5yXlSWdqy04oBmoxht2AvVnp8zRh0AxIHzZR/d45HC/5AnQz7ctdwhbsEQ8La7NCtnPodGcj
 N+O9EOSzUZWKAFuztlGqkARHUJfU0NVMJsE1+rExatw==
X-Received: by 2002:a17:906:90ca:: with SMTP id
 v10mr26915856ejw.325.1626696297572; 
 Mon, 19 Jul 2021 05:04:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzV8Xwbz4/GYt2JDZQpL5br33PGNa1We7PkPG+rn10p7jrXeXGnoGKsDZa5e60yhBehB3/gAg==
X-Received: by 2002:a17:906:90ca:: with SMTP id
 v10mr26915843ejw.325.1626696297409; 
 Mon, 19 Jul 2021 05:04:57 -0700 (PDT)
Received: from redhat.com ([2.55.11.37])
 by smtp.gmail.com with ESMTPSA id gn13sm5741290ejc.1.2021.07.19.05.04.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Jul 2021 05:04:55 -0700 (PDT)
Date: Mon, 19 Jul 2021 08:04:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH 1/4] virtio: Improve vq->broken access to avoid any
 compiler optimization
Message-ID: <20210719080316-mutt-send-email-mst@kernel.org>
References: <20210717074258.1463313-1-parav@nvidia.com>
 <20210717074258.1463313-2-parav@nvidia.com>
 <20210717163319-mutt-send-email-mst@kernel.org>
 <PH0PR12MB5481EBA531451478010F926DDCE19@PH0PR12MB5481.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <PH0PR12MB5481EBA531451478010F926DDCE19@PH0PR12MB5481.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

On Mon, Jul 19, 2021 at 05:26:22AM +0000, Parav Pandit wrote:
> 
> 
> > From: Michael S. Tsirkin <mst@redhat.com>
> > Sent: Sunday, July 18, 2021 2:09 AM
> > 
> > On Sat, Jul 17, 2021 at 10:42:55AM +0300, Parav Pandit wrote:
> > > Currently vq->broken field is read by virtqueue_is_broken() in busy
> > > loop in one context by virtnet_send_command().
> > >
> > > vq->broken is set to true in other process context by
> > > virtio_break_device(). Reader and writer are accessing it without any
> > > synchronization. This may lead to a compiler optimization which may
> > > result to optimize reading vq->broken only once.
> > >
> > > Hence, force reading vq->broken on each invocation of
> > > virtqueue_is_broken() and ensure that its update is visible.
> > >
> > > Fixes: e2dcdfe95c0b ("virtio: virtio_break_device() to mark all
> > > virtqueues broken.")
> > 
> > This is all theoretical right?
> > virtqueue_get_buf is not inlined so compiler generally assumes any vq field
> > can change.
> Broken bit checking cannot rely on some other kernel API for correctness.
> So it possibly not hitting this case now, but we shouldn't depend other APIs usage to ensure correctness.
> 
> > 
> > I'm inclined to not include a Fixes
> > tag then. And please do change subject to say "theoretical"
> > to make that clear to people.
> > 
> I do not have any strong opinion on fixes tag. But virtio_broken_queue() API should be self-contained; for that I am not sure if this just theoretical.
> Do you mean theoretical, because we haven't hit this bug?

Because with existing code I don't believe existing compilers are clever enough to
optimize this away.

> > > Signed-off-by: Parav Pandit <parav@nvidia.com>
> > > ---
> > >  drivers/virtio/virtio_ring.c | 6 ++++--
> > >  1 file changed, 4 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c
> > > b/drivers/virtio/virtio_ring.c index 89bfe46a8a7f..7f379fe7d78d 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -2373,7 +2373,7 @@ bool virtqueue_is_broken(struct virtqueue *_vq)
> > > {
> > >  	struct vring_virtqueue *vq = to_vvq(_vq);
> > >
> > > -	return vq->broken;
> > > +	return READ_ONCE(vq->broken);
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_is_broken);
> > >
> > > @@ -2387,7 +2387,9 @@ void virtio_break_device(struct virtio_device
> > > *dev)
> > >
> > >  	list_for_each_entry(_vq, &dev->vqs, list) {
> > >  		struct vring_virtqueue *vq = to_vvq(_vq);
> > > -		vq->broken = true;
> > > +
> > > +		/* Pairs with READ_ONCE() in virtqueue_is_broken(). */
> > > +		smp_store_release(&vq->broken, true);
> > 
> > A bit puzzled here. Why do we need release semantics here?
> > IUC store_release does not generally pair with READ_ONCE - does it?
> > 
> It does; paired at few places, such as,
> 
> (a) in uverbs_main.c, default_async_file
> (b) in netlink.c, cb_table
> (c) fs/dcache.c i_dir_seq,
> 
> However, in this scenario, WRITE_ONCE() is enough. So I will simplify and use that in v1.
> 
> 
> > The commit log does not describe this either.
> In commit log I mentioned that "ensure that update is visible".
> I think a better commit log is, to say: "ensure that broken bit is written".

"is read repeatedly" maybe.

> I will send v2 with 
> (a) updated comment
> (b) replacing smp.. with WRITE_ONCE()
> (c) dropping the fixes tag.
> 
> > 
> > >  	}
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtio_break_device);
> > > --
> > > 2.27.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
