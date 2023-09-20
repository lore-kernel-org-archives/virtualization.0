Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1EBBCE79CE
	for <virtualization@archiver.kernel.org>; Wed, 20 Sep 2023 13:18:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 65DA8612DC;
	Wed, 20 Sep 2023 13:18:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 65DA8612DC
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Lst+AXDs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6ZXn9i1Fv8VL; Wed, 20 Sep 2023 13:18:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9F26560BB8;
	Wed, 20 Sep 2023 13:18:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F26560BB8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8232FC0071;
	Wed, 20 Sep 2023 13:18:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D56ACC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Sep 2023 13:18:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id AFBC9827CA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Sep 2023 13:18:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org AFBC9827CA
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Lst+AXDs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uZv0EzLYC90s
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Sep 2023 13:18:38 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D8D7482308
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Sep 2023 13:18:37 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D8D7482308
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695215916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Ft0Hvww98DIVI9AAi+gO6RxI47Nc/V9+mUfEY+K4xFY=;
 b=Lst+AXDsS2+GSuLw88nFpLL8TKWC7X/e+qG55zrJc9V4tw5ZMbGDawI5h/ziP/FU4WgUz+
 krmn/zrjDUoTHA5iiTqnT+F/tKAPzib+PvOcm7qgrfA/nw+j6zlc0/IjhYi+2a8ebTMbgz
 nfhNIIr0J3MLQ3TQM5+cXSsvlFpLODk=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-112-UFqYo7-HNBOG46JwnrYDpw-1; Wed, 20 Sep 2023 09:18:34 -0400
X-MC-Unique: UFqYo7-HNBOG46JwnrYDpw-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3fef5403093so4487395e9.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Sep 2023 06:18:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695215913; x=1695820713;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Ft0Hvww98DIVI9AAi+gO6RxI47Nc/V9+mUfEY+K4xFY=;
 b=TypIHzOEi3nBBTsKJp5GtAsJyvuMHuvbhkZsAlX05UZZxilZaFGp69LMPdjBbzySEo
 ZPSeiMBheuGHe2XrAtFo/GxRdYPrj5JzoQCSeyZaQKGkpRlCvuTwCsrsfFokyai2rmXV
 EH1ZyDcaMYZTYOOVrjnWVm9u0cdPEAnd6ju2c56r7+pf0hv/jYYMEokxGlnOAyr1+wN6
 I8lMtaGlu2xm+r3AMPU/L5UuLRg4agqVOVfRJ3Cgw0PK8KPX0rKOuvSaXRjFCWNWSBrI
 t0BiWcO6uZ9q1p/frGF+jg11KqA13zX5THO2ABe71NsmZTPIlTInHI5/gE1M7iOuZc3p
 cNsQ==
X-Gm-Message-State: AOJu0YwxMpe1Up3Jqu7zEIGhpjVZkAlpRO10QZUy+rWitGU2yYYanGwF
 qHHuE3xna4evViKTR0HBq5vbnshrvqeifXd34a5lptTlMmwDCdKTVRGlJuUPMLarHB5uU2XaAG3
 T3EY8iWTDu+FcJ2k+bb+dsC4U5yZpkfmnDxW06XI90g==
X-Received: by 2002:a05:600c:224b:b0:3ff:516b:5c4c with SMTP id
 a11-20020a05600c224b00b003ff516b5c4cmr2304962wmm.18.1695215912949; 
 Wed, 20 Sep 2023 06:18:32 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGabC1hwv/xqFBYRbrp9O89UlJtSsJ98NuuHoD1jnD2tJsRjwSepgqimuIq55Kap6Xk3Gd70Q==
X-Received: by 2002:a05:600c:224b:b0:3ff:516b:5c4c with SMTP id
 a11-20020a05600c224b00b003ff516b5c4cmr2304951wmm.18.1695215912588; 
 Wed, 20 Sep 2023 06:18:32 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
 by smtp.gmail.com with ESMTPSA id
 u3-20020a7bc043000000b003fd2d3462fcsm819037wmc.1.2023.09.20.06.18.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Sep 2023 06:18:32 -0700 (PDT)
Date: Wed, 20 Sep 2023 15:18:30 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: virtio-sound linux driver conformance to spec
Message-ID: <ZQrxJnzYHSH0OhiR@fedora>
References: <ZQHPeD0fds9sYzHO@pc-79.home>
 <20230919054054-mutt-send-email-mst@kernel.org>
 <ZQmt0Z8lbPMuFzR+@fedora>
 <20230919102250-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20230919102250-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtio-comment@lists.oasis-open.org, stefanha@redhat.com,
 virtualization@lists.linux-foundation.org
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

On Tue, Sep 19, 2023 at 11:52:27AM -0400, Michael S. Tsirkin wrote:
> On Tue, Sep 19, 2023 at 04:18:57PM +0200, Matias Ezequiel Vara Larsen wrote:
> > On Tue, Sep 19, 2023 at 05:43:56AM -0400, Michael S. Tsirkin wrote:
> > > On Wed, Sep 13, 2023 at 05:04:24PM +0200, Matias Ezequiel Vara Larsen wrote:
> > > > Hello,
> > > > 
> > > > This email is to report a behavior of the Linux virtio-sound driver that
> > > > looks like it is not conforming to the VirtIO specification. The kernel
> > > > driver is moving buffers from the used ring to the available ring
> > > > without knowing if the content has been updated from the user. If the
> > > > device picks up buffers from the available ring just after it is
> > > > notified, it happens that the content is old.
> > > 
> > > Then, what happens, exactly? Do things still work?
> > 
> > We are currently developing a vhost-user backend for virtio-sound and
> > what happens is that if the backend implementation decides to copy the
> > content of a buffer from a request that just arrived to the available
> > ring, it gets the old content thus reproducing some sections two times.
> > For example, we observe that when issuing `aplay FrontLeft.wav`, we hear
> > `Front, front left...`. To fix this issue, our current implementation
> > delays reading from guest memory just until the audio engine requires.
> > However, the first implementation shall also work since it is conforming
> > to the specification.
> > 
> > Matias
> 
> Sounds like it. How hard is it to change the behaviour though?
> Does it involve changing userspace?

AFAIU, a fix for the driver may be to somehow wait until userspace
updates the buffer before add it in the available ring.  
So far, when the device notifies the driver that a new buffer is in the
used ring, the driver calls the virtsnd_pcm_msg_complete() function to
do:
``` 
schedule_work(&vss->elapsed_period);

virtsnd_pcm_msg_send(vss); 
``` 
It first defers the notification to userspace regarding an elapse period
and then it enqueues the request again in the available
ring.`schedule_work()` defers the calling to the
`virtsnd_pcm_period_elapsed()` function that issues
`snd_pcm_period_elapsed(vss->substream);` to notify userspace.  
My proposal would be that the driver could also defer
`virtsnd_pcm_msg_send(vss)` to execute just after
`snd_pcm_period_elapsed(vss->substream)`. Something like this:

diff --git a/sound/virtio/virtio_pcm.c b/sound/virtio/virtio_pcm.c
index c10d91fff2fb..41f1e74c8478 100644
--- a/sound/virtio/virtio_pcm.c
+++ b/sound/virtio/virtio_pcm.c
@@ -309,6 +309,7 @@ static void virtsnd_pcm_period_elapsed(struct work_struct *work)
                container_of(work, struct virtio_pcm_substream, elapsed_period);
 
        snd_pcm_period_elapsed(vss->substream);
+       virtsnd_pcm_msg_send(vss);
 }
 
 /**
diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
index aca2dc1989ba..43f0078b1152 100644
--- a/sound/virtio/virtio_pcm_msg.c
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -321,7 +321,6 @@ static void virtsnd_pcm_msg_complete(struct virtio_pcm_msg *msg,
 
                schedule_work(&vss->elapsed_period);
 
-               virtsnd_pcm_msg_send(vss);
        } else if (!vss->msg_count) {
                wake_up_all(&vss->msg_empty);
        }


I tested it and it looks it fixes the issue. However, I am not sure if
this is enough since I do not know if when `snd_pcm_period_elapsed()`
returns, the buffers have been already updated.

Matias

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
