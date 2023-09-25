Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1D38CE7A94
	for <virtualization@archiver.kernel.org>; Mon, 25 Sep 2023 14:33:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1A3ED4194C;
	Mon, 25 Sep 2023 14:33:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1A3ED4194C
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=CqvMpOjv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OwePQHdwydw5; Mon, 25 Sep 2023 14:33:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 1AEBE41939;
	Mon, 25 Sep 2023 14:33:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1AEBE41939
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA735C0071;
	Mon, 25 Sep 2023 14:33:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B8EC3C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 14:33:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 8609C81B17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 14:33:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8609C81B17
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=CqvMpOjv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TVHCig-qagQn
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 14:33:44 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7A56C81699
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 14:33:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7A56C81699
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695652423;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=OYzJ5V4E8C0wj9J8fVAJVvVv5Gl2yEjT3moeQQdvrhQ=;
 b=CqvMpOjvNiRWfbtcF0fObwrfq9BMet6LjDm6Kb3pPpXtEoH4cvAyPHXATNWxKBJ/FhBbZM
 T8dZoNJF6lqSHNjNZNNFOM2gZxGBRkI4HuHHZrZNYqyqxSY+CVI+lqZT0j42zwKflYGoTf
 v8bJB+Frc/6Wf94etZlhaxQwVZEHtYo=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-341-H5FECzBmMDyzmTCJdfplLw-1; Mon, 25 Sep 2023 10:33:42 -0400
X-MC-Unique: H5FECzBmMDyzmTCJdfplLw-1
Received: by mail-qt1-f199.google.com with SMTP id
 d75a77b69052e-4180de770f5so67804811cf.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 07:33:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695652421; x=1696257221;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=OYzJ5V4E8C0wj9J8fVAJVvVv5Gl2yEjT3moeQQdvrhQ=;
 b=Sisb5g+UMkJ76Ebe2mI4RvGul7GD/yvQ1gfiJCaZrD+K06m82u0jOVaYbRzcnDM4V7
 VtG4Apa0a01fMe53op7l/eyJknIJQAxCSsdNUmUfOuOQ3G78tlchEE13NnhQ+UwLeNuC
 m8U2OXFZ9QZPevliwPiHJpfWKixkhC/OFUgSzLlg/YRAOMgIBDiX54x+ycko+sSpKKpb
 BXg5vy1psO47NhaCrUpwUwqNR2kjPNkulyJyLPENe+3luTvdb5Gg3wlt8yH9QotoWPGP
 l+ceb0dzfQA5zbMADDSWJaaUjGHNxCU2luSK4sSfEsWuxeVRCniI2tq8MqlmUIYrBP9F
 iLrw==
X-Gm-Message-State: AOJu0YxgKDNbn8R6WQduBfjJ+EoBN1YyXx/BmXNaslSp51v7qBEk2VIB
 XsX6It+3NMNXbKawVNr4rTWKZuP32eZswB8GVegN7k6DeD/Bwg8skJ2LuJYauBT0FUGOF2y0RSo
 kDGzaLUdmalzQ9gzihHTqSKcr3KClPYSQKUPtoMbJJw==
X-Received: by 2002:ac8:4e84:0:b0:412:1e0a:772d with SMTP id
 4-20020ac84e84000000b004121e0a772dmr9670228qtp.12.1695652421399; 
 Mon, 25 Sep 2023 07:33:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFrVTM+y4dsWarhzq0K88LNdGBEmRN1dbe8sMBcIW8VRcYqCh2brXlGxtqJnFwmxhCwEjO2YA==
X-Received: by 2002:ac8:4e84:0:b0:412:1e0a:772d with SMTP id
 4-20020ac84e84000000b004121e0a772dmr9670205qtp.12.1695652421032; 
 Mon, 25 Sep 2023 07:33:41 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
 by smtp.gmail.com with ESMTPSA id
 o20-20020ac86994000000b00403cce833eesm3808973qtq.27.2023.09.25.07.33.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Sep 2023 07:33:40 -0700 (PDT)
Date: Mon, 25 Sep 2023 16:33:37 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Subject: Re: virtio-sound linux driver conformance to spec
Message-ID: <ZRGaQU/I6Qfz8cLP@fedora>
References: <ZQHPeD0fds9sYzHO@pc-79.home>
 <20230919054054-mutt-send-email-mst@kernel.org>
 <ZQmt0Z8lbPMuFzR+@fedora>
 <20230919102250-mutt-send-email-mst@kernel.org>
 <ZQrxJnzYHSH0OhiR@fedora>
 <0f377606-ac93-4be1-9e5e-80bce31e6bce@opensynergy.com>
MIME-Version: 1.0
In-Reply-To: <0f377606-ac93-4be1-9e5e-80bce31e6bce@opensynergy.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, stefanha@redhat.com,
 virtio-comment@lists.oasis-open.org, "Michael S. Tsirkin" <mst@redhat.com>
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

On Mon, Sep 25, 2023 at 10:04:33AM +0900, Anton Yakovlev wrote:
> Hello Matias,
> 
> On 20.09.2023 22:18, Matias Ezequiel Vara Larsen wrote:
> > On Tue, Sep 19, 2023 at 11:52:27AM -0400, Michael S. Tsirkin wrote:
> > > On Tue, Sep 19, 2023 at 04:18:57PM +0200, Matias Ezequiel Vara Larsen wrote:
> > > > On Tue, Sep 19, 2023 at 05:43:56AM -0400, Michael S. Tsirkin wrote:
> > > > > On Wed, Sep 13, 2023 at 05:04:24PM +0200, Matias Ezequiel Vara Larsen wrote:
> > > > > > Hello,
> > > > > > 
> > > > > > This email is to report a behavior of the Linux virtio-sound driver that
> > > > > > looks like it is not conforming to the VirtIO specification. The kernel
> > > > > > driver is moving buffers from the used ring to the available ring
> > > > > > without knowing if the content has been updated from the user. If the
> > > > > > device picks up buffers from the available ring just after it is
> > > > > > notified, it happens that the content is old.
> > > > > 
> > > > > Then, what happens, exactly? Do things still work?
> > > > 
> > > > We are currently developing a vhost-user backend for virtio-sound and
> > > > what happens is that if the backend implementation decides to copy the
> > > > content of a buffer from a request that just arrived to the available
> > > > ring, it gets the old content thus reproducing some sections two times.
> > > > For example, we observe that when issuing `aplay FrontLeft.wav`, we hear
> > > > `Front, front left...`. To fix this issue, our current implementation
> > > > delays reading from guest memory just until the audio engine requires.
> > > > However, the first implementation shall also work since it is conforming
> > > > to the specification.
> > > > 
> > > > Matias
> > > 
> > > Sounds like it. How hard is it to change the behaviour though?
> > > Does it involve changing userspace?
> > 
> > AFAIU, a fix for the driver may be to somehow wait until userspace
> > updates the buffer before add it in the available ring.
> > So far, when the device notifies the driver that a new buffer is in the
> > used ring, the driver calls the virtsnd_pcm_msg_complete() function to
> > do:
> > ```
> > schedule_work(&vss->elapsed_period);
> > 
> > virtsnd_pcm_msg_send(vss);
> > ```
> > It first defers the notification to userspace regarding an elapse period
> > and then it enqueues the request again in the available
> > ring.`schedule_work()` defers the calling to the
> > `virtsnd_pcm_period_elapsed()` function that issues
> > `snd_pcm_period_elapsed(vss->substream);` to notify userspace.
> > My proposal would be that the driver could also defer
> > `virtsnd_pcm_msg_send(vss)` to execute just after
> > `snd_pcm_period_elapsed(vss->substream)`. Something like this:
> > 
> > diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
> > index c10d91fff2fb..41f1e74c8478 100644
> > --- a/sound/virtio/virtio_pcm.c
> > +++ b/sound/virtio/virtio_pcm.c
> > @@ -309,6 +309,7 @@ static void virtsnd_pcm_period_elapsed(struct work_struct *work)
> >                  container_of(work, struct virtio_pcm_substream, elapsed_period);
> >          snd_pcm_period_elapsed(vss->substream);
> > +       virtsnd_pcm_msg_send(vss);
> >   }
> >   /**
> > diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
> > index aca2dc1989ba..43f0078b1152 100644
> > --- a/sound/virtio/virtio_pcm_msg.c
> > +++ b/sound/virtio/virtio_pcm_msg.c
> > @@ -321,7 +321,6 @@ static void virtsnd_pcm_msg_complete(struct virtio_pcm_msg *msg,
> >                  schedule_work(&vss->elapsed_period);
> > -               virtsnd_pcm_msg_send(vss);
> >          } else if (!vss->msg_count) {
> >                  wake_up_all(&vss->msg_empty);
> >          }
> > 
> > 
> > I tested it and it looks it fixes the issue. However, I am not sure if
> > this is enough since I do not know if when `snd_pcm_period_elapsed()`
> > returns, the buffers have been already updated.
> 
> It's just a lucky coincidence that this change helped in your case.
> 
> Instead, to solve the problem, it's necessary to implement read/write()
> operations for the substream, and disable MMAP access mode.
> 
> I'll try, but I'm not sure I'll have enough time for this in the near future.
> 
> 
Hello Anton,

Thanks, I will try to propose a better fix in the next few weeks. I
am not familiar with sound drivers so I may require some help. I'll let
you know if I have any question.

Thanks, Matias.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
