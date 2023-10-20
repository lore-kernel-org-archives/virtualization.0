Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 792A6CDB474
	for <virtualization@archiver.kernel.org>; Fri, 20 Oct 2023 09:42:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 187E6704AB;
	Fri, 20 Oct 2023 09:42:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 187E6704AB
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=QaUOZhgT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1lhZrJ_o4DgJ; Fri, 20 Oct 2023 09:42:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 8ED81704A7;
	Fri, 20 Oct 2023 09:42:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8ED81704A7
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 64974C0071;
	Fri, 20 Oct 2023 09:42:24 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 82898C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 09:42:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 5C5C543299
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 09:42:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5C5C543299
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=QaUOZhgT
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0Zem9jd57H5H
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 09:42:21 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 5B7FE43295
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 09:42:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5B7FE43295
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697794940;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=B8zhNyoPjCzPI6JP3Ig1aNei31DQ1+NDAezu4yisodc=;
 b=QaUOZhgTofI/zk+f6+XyZdbKteTJr7sXkjBd72rj238pRyFzQWtE68lxRJdqB1r1/Rv40Y
 ehrhc3T5VqX6IshZtsdnqQStjaaT1z90pA+pIN44LW5qPNjG2+ytb6+OgC+laTbNwDxmeg
 QmBDOa4KTo0rEhn/x4tD0LLcs1sxQ6o=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-451-ySc2-4kFMmyxyFT3CKuCoQ-1; Fri, 20 Oct 2023 05:42:18 -0400
X-MC-Unique: ySc2-4kFMmyxyFT3CKuCoQ-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-407f9d07b41so3934505e9.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 20 Oct 2023 02:42:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697794937; x=1698399737;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=B8zhNyoPjCzPI6JP3Ig1aNei31DQ1+NDAezu4yisodc=;
 b=oVwh6ER4R1zVUSVxCVmcZ98T4sA4etlV0Saw/QBlnruQbdOFNaKBbpdRJpt8IMkQt3
 /mvX/45KafX89ijDWUphWOTF5cana2Dc+Qa1nHx3kTWLMohUPD+RIpJZXzLnanlvucTB
 U5VCB5saTesWO6UrBtF4kAzTtQLPD8bUCTLJMX3gQ+IHVRx4onFPB02ROV6uRnDE62+7
 Sb47SPHSFJjh8sQuPzG+5o0rvloMxj/X1kMh7F3/poysHq2v+xFbVaWJrosJDR/HR5Uu
 UIIsn4goTATzxkJFUAecbycU/UlY1Rmkk806882SuwENvJ3IJHXfnFMGeUCtVq+7Xan4
 8Isg==
X-Gm-Message-State: AOJu0YxDwIDwY7o//dW/Coyl0NWFUbcjxAJUPeW7z4YCDRhUMLsEyON7
 7TS9kX2GjtAOIXc35u2wWQSSWe5QyUqwEPvVXOCeMWyjbf35kHdBbdw14tljjOuuYdsEDJyNKdn
 y9faKx5cmhTjk2TbMl+NnTi0Yt7qCIbQCHhOggDCebg==
X-Received: by 2002:a05:600c:5010:b0:401:b652:b6cf with SMTP id
 n16-20020a05600c501000b00401b652b6cfmr1071102wmr.13.1697794937692; 
 Fri, 20 Oct 2023 02:42:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHM1EM6T+wMVFzF33cC7Y8KaN3eWcPR5dXbra2BbI2AyJPoDU5x0TqLATbg4eiyQEcfWjjlHA==
X-Received: by 2002:a05:600c:5010:b0:401:b652:b6cf with SMTP id
 n16-20020a05600c501000b00401b652b6cfmr1071091wmr.13.1697794937447; 
 Fri, 20 Oct 2023 02:42:17 -0700 (PDT)
Received: from redhat.com ([2a06:c701:73d2:bf00:e379:826:5137:6b23])
 by smtp.gmail.com with ESMTPSA id
 f18-20020a05600c155200b00402ff8d6086sm1734198wmg.18.2023.10.20.02.42.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Oct 2023 02:42:16 -0700 (PDT)
Date: Fri, 20 Oct 2023 05:42:14 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_ring: add an error code check in virtqueue_resize
Message-ID: <20231020054140-mutt-send-email-mst@kernel.org>
References: <20231020092320.209234-1-suhui@nfschina.com>
 <20231020053047-mutt-send-email-mst@kernel.org>
 <1697794601.5857713-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1697794601.5857713-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Su Hui <suhui@nfschina.com>, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

On Fri, Oct 20, 2023 at 05:36:41PM +0800, Xuan Zhuo wrote:
> On Fri, 20 Oct 2023 05:34:32 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Fri, Oct 20, 2023 at 05:23:21PM +0800, Su Hui wrote:
> > > virtqueue_resize_packed() or virtqueue_resize_split() can return
> > > error code if failed, so add a check for this.
> > >
> > > Signed-off-by: Su Hui <suhui@nfschina.com>
> > > ---
> > >
> > > I'm not sure that return directly is right or not,
> > > maybe there are some process should do before return.
> >
> > yes - presizely what virtqueue_enable_after_reset does.
> >
> > Error handling in virtqueue_enable_after_reset is really weird BTW.
> > For some reason it overrides the error code returned.
> >
> >
> >
> >
> >
> > >  drivers/virtio/virtio_ring.c | 3 +++
> > >  1 file changed, 3 insertions(+)
> > >
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > > index 51d8f3299c10..cf662c3a755b 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -2759,6 +2759,9 @@ int virtqueue_resize(struct virtqueue *_vq, u32 num,
> > >  	else
> > >  		err = virtqueue_resize_split(_vq, num);
> > >
> > > +	if (err)
> > > +		return err;
> > > +
> > >  	return virtqueue_enable_after_reset(_vq);
> >
> > So I think it should be something like:
> >
> > 	int err_reset = virtqueue_enable_after_reset(_vq);
> > 	BUG_ON(err_reset);
> >
> > 	return err;
> >
> 
> How about WARN and vq->broken?
> 
> Thanks.

Well, what are the cases where it can happen practically?

> 
> >
> >
> > >  }
> > >  EXPORT_SYMBOL_GPL(virtqueue_resize);
> > > --
> > > 2.30.2
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
