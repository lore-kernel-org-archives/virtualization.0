Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62461C7EE21
	for <virtualization@archiver.kernel.org>; Thu,  4 May 2023 18:52:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DDA868416D;
	Thu,  4 May 2023 18:52:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DDA868416D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gUKhGvBX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id huX-NkEW4ltJ; Thu,  4 May 2023 18:52:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1409984161;
	Thu,  4 May 2023 18:52:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1409984161
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DC9D8C0036;
	Thu,  4 May 2023 18:52:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DD2F0C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 May 2023 18:52:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id AE5A742776
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 May 2023 18:52:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AE5A742776
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gUKhGvBX
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Iqv6GvXjGoA
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 May 2023 18:52:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 37E9F42778
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 37E9F42778
 for <virtualization@lists.linux-foundation.org>;
 Thu,  4 May 2023 18:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683226321;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=yoeKifcrHut/aVoBaYmqNutB3vVh6nFGSk8RRjdeSWE=;
 b=gUKhGvBX0rAnVwgekrHpVhwA0WTLDdJzJphv+lymGCT6Ld6xWi+a5gndQEnHlqbHRdhHW9
 9Xu0lBi/MGvJTbNezT319OUhwo1y6ybYOEVZmJ15a76cDPashpA0KjSuqrj3/ahzk6R4N1
 KcXaTI9nbrxmskGG7j5sQoouveHsfi8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-247-i-M7n0GONEqCgUfYkqt1Ow-1; Thu, 04 May 2023 14:52:00 -0400
X-MC-Unique: i-M7n0GONEqCgUfYkqt1Ow-1
Received: by mail-wr1-f72.google.com with SMTP id
 ffacd0b85a97d-2fbb99cb244so476252f8f.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 04 May 2023 11:52:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683226319; x=1685818319;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yoeKifcrHut/aVoBaYmqNutB3vVh6nFGSk8RRjdeSWE=;
 b=Zw98ykCNmX+r/Ws/FvHkvlvHsnwkZXp57RE5k2R4ZHXAiV0nCHlOFeQUSkeNuii6bb
 E6uyRc2wlaKaOTMVBNHujC/UoKgAgEolBn9sDUQZMn+Q/Mv9i1ysuCAueVZ66xuV8ZpX
 ILMOUZeLalxOnoJ8KhZffj6BWzir0C/yG05bBlWIbYLLtr36SNZwlKOn0NcaC/fKhA8I
 ozD0fQqZKHjYpZdqIszsqGqJlqQgTDbjqVtFV8/V6sMPm/jN2Y9xKXHsIsf30gLDYoZF
 yzVvjMCNXZy6HDq3isZYF/h/KfOD5hSEfKhchoum3gb4ya/OtlDzc6bu9FKgJE0SvvfL
 chNQ==
X-Gm-Message-State: AC+VfDwblJQhVg3iZSmOQTnwdMWpeBgxXTT5pAMTWinC6cPrPR/ha5Uv
 +W207vaQKCKRt3Gw/o8k7eg6MVy/X/g7RDIh1+nwmFQEj1cpw/uCKiuI3otPlKh8qLLx9sLI1Er
 xdXugH4IUBZizzasg/OsgLmzBvdk5YHRdwCU7ObESZA==
X-Received: by 2002:adf:dcd2:0:b0:306:2aea:3dff with SMTP id
 x18-20020adfdcd2000000b003062aea3dffmr3617970wrm.31.1683226319571; 
 Thu, 04 May 2023 11:51:59 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ7cx+2cMwtc4BneZKjj77rQ0pMBPF0hJCSWkGLah28tDXXF/f2SErFruAwMUMwKlukaFfr+tA==
X-Received: by 2002:adf:dcd2:0:b0:306:2aea:3dff with SMTP id
 x18-20020adfdcd2000000b003062aea3dffmr3617960wrm.31.1683226319266; 
 Thu, 04 May 2023 11:51:59 -0700 (PDT)
Received: from redhat.com ([2.52.10.43]) by smtp.gmail.com with ESMTPSA id
 u6-20020adff886000000b002f7780eee10sm37569197wrp.59.2023.05.04.11.51.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 04 May 2023 11:51:58 -0700 (PDT)
Date: Thu, 4 May 2023 14:51:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Feng Liu <feliu@nvidia.com>
Subject: Re: [PATCH] virtio-vdpa: Fix unchecked call to NULL set_vq_affinity
Message-ID: <20230504145110-mutt-send-email-mst@kernel.org>
References: <20230504135053.2283816-1-dtatulea@nvidia.com>
 <26ee2c04-7844-14fe-5cba-fe30172f075f@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <26ee2c04-7844-14fe-5cba-fe30172f075f@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>, Gal Pressman <gal@nvidia.com>
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

On Thu, May 04, 2023 at 01:08:54PM -0400, Feng Liu wrote:
> 
> 
> On 2023-05-04 a.m.9:50, Dragos Tatulea wrote:
> > External email: Use caution opening links or attachments
> > 
> > 
> > The referenced patch calls set_vq_affinity without checking if the op is
> > valid. This patch adds the check.
> > 
> > Fixes: 3dad56823b53 ("virtio-vdpa: Support interrupt affinity spreading mechanism")
> > Reviewed-by: Gal Pressman <gal@nvidia.com>
> > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > ---
> >   drivers/virtio/virtio_vdpa.c | 4 +++-
> >   1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> > index eb6aee8c06b2..989e2d7184ce 100644
> > --- a/drivers/virtio/virtio_vdpa.c
> > +++ b/drivers/virtio/virtio_vdpa.c
> > @@ -385,7 +385,9 @@ static int virtio_vdpa_find_vqs(struct virtio_device *vdev, unsigned int nvqs,
> >                          err = PTR_ERR(vqs[i]);
> >                          goto err_setup_vq;
> >                  }
> > -               ops->set_vq_affinity(vdpa, i, &masks[i]);
> > +
> > +               if (ops->set_vq_affinity)
> > +                       ops->set_vq_affinity(vdpa, i, &masks[i]);
> if ops->set_vq_affinity is NULL, should give an error code to err, and
> return err

Given we ignore return code, hardly seems like a critical thing to do.
Is it really important? affinity is an optimization isn't it?

> >          }
> > 
> >          cb.callback = virtio_vdpa_config_cb;
> > --
> > 2.40.1
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
