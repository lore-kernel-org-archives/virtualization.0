Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 190C9C77B75
	for <virtualization@archiver.kernel.org>; Fri, 12 May 2023 13:30:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5641F409F3;
	Fri, 12 May 2023 13:30:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5641F409F3
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V6rntGoG
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FxgUEJlAZcH1; Fri, 12 May 2023 13:30:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E66964050C;
	Fri, 12 May 2023 13:30:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E66964050C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1976C0036;
	Fri, 12 May 2023 13:30:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 18740C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 13:30:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D9EB6405B8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 13:30:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D9EB6405B8
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tRY6tJFXmK1s
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 13:30:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EDB6F4050C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id EDB6F4050C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 13:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1683898218;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ukyw32JRJGiabHOmgdKRXIVOrAFdfaiaSm7mhvRcLR8=;
 b=V6rntGoGxNP381ref2EzFixMhySjXqx7pA8FscemTfOJJf0ocXLFVd7nyVaFzFJ9Gc4Smp
 xkyofQuIgSxvpxN03+NT0VY/elj57w0ugNdYhC5/RWO3ByGhhavATxiuWk+e9KH7GguZwH
 RzzVSXVcgjcP4Z7r0qNu3B5VM6P5SDA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-274-2_SI9lZEMQWF6pHAFThZdQ-1; Fri, 12 May 2023 09:30:17 -0400
X-MC-Unique: 2_SI9lZEMQWF6pHAFThZdQ-1
Received: by mail-wm1-f72.google.com with SMTP id
 5b1f17b1804b1-3f420742d40so26062665e9.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 May 2023 06:30:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1683898216; x=1686490216;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Ukyw32JRJGiabHOmgdKRXIVOrAFdfaiaSm7mhvRcLR8=;
 b=Ke8CZ439g4Vf5abTHnd2cixF4lHJGhruyvQJa0Pf3PEv5r6/9kVymlc2FUYkLbuRGC
 JG20pP2kJNdU8dAxJfzUV3kAhgaxZZXwfnXIhifi059APHD+LDDht4BNs55auf9K6/xA
 uHNuel0MUFZEr6LT3bOpq/UmiRV0eDFycfB3lw+sQMDuYjb71dii73KRXa+IsKnviM+D
 WJRnbbmvCIVJxlvaJ1HDDZpmgWDBJXuRKBz+MMIMUdCsLanZaYb/v2rZj3xguEjmpFM3
 puf4REl65y42rg5V5PjFGJtW0gcFmFNMzxihBXSBgxG0zLoGlGf7PMC1jQgIlV/DG12X
 lMig==
X-Gm-Message-State: AC+VfDyjdukNupkwf5n9Yp0Qzwm4FuC7dagosObOfioY4s1BG7fmZ977
 NOol3aUafdFJuP3HA2c0/QI4fI2EDWhT5iSGfDaexbH6gYA4u8Yb4K9JU3H7l9/276KJcyymJND
 obCsVYhldFUbJmd5v1WbWX24Q99HVe7oym0kSau4YHA==
X-Received: by 2002:adf:ee49:0:b0:306:2701:5346 with SMTP id
 w9-20020adfee49000000b0030627015346mr18528766wro.39.1683898215932; 
 Fri, 12 May 2023 06:30:15 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4F10zBx+Lys1LHJzFIqbci4nxbtSgAdy2EOozucQR2jHZDFL9MLbYUg4Mew1HRJ6TnFGHMEQ==
X-Received: by 2002:adf:ee49:0:b0:306:2701:5346 with SMTP id
 w9-20020adfee49000000b0030627015346mr18528743wro.39.1683898215596; 
 Fri, 12 May 2023 06:30:15 -0700 (PDT)
Received: from redhat.com ([31.187.78.61]) by smtp.gmail.com with ESMTPSA id
 c22-20020a7bc016000000b003f4e3ed9912sm6660077wmb.46.2023.05.12.06.30.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 12 May 2023 06:30:14 -0700 (PDT)
Date: Fri, 12 May 2023 09:30:11 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Dragos Tatulea <dtatulea@nvidia.com>
Subject: Re: [PATCH] virtio-vdpa: Fix unchecked call to NULL set_vq_affinity
Message-ID: <20230512093000-mutt-send-email-mst@kernel.org>
References: <20230504135053.2283816-1-dtatulea@nvidia.com>
 <26ee2c04-7844-14fe-5cba-fe30172f075f@nvidia.com>
 <20230504145110-mutt-send-email-mst@kernel.org>
 <8e1f076cb09560ee2bcda2092c0de10a701ba00b.camel@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <8e1f076cb09560ee2bcda2092c0de10a701ba00b.camel@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "xuanzhuo@linux.alibaba.com" <xuanzhuo@linux.alibaba.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 Gal Pressman <gal@nvidia.com>
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
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Fri, May 12, 2023 at 12:51:21PM +0000, Dragos Tatulea wrote:
> On Thu, 2023-05-04 at 14:51 -0400, Michael S. Tsirkin wrote:
> > On Thu, May 04, 2023 at 01:08:54PM -0400, Feng Liu wrote:
> > > =

> > > =

> > > On 2023-05-04 a.m.9:50, Dragos Tatulea wrote:
> > > > External email: Use caution opening links or attachments
> > > > =

> > > > =

> > > > The referenced patch calls set_vq_affinity without checking if the =
op is
> > > > valid. This patch adds the check.
> > > > =

> > > > Fixes: 3dad56823b53 ("virtio-vdpa: Support interrupt affinity sprea=
ding
> > > > mechanism")
> > > > Reviewed-by: Gal Pressman <gal@nvidia.com>
> > > > Signed-off-by: Dragos Tatulea <dtatulea@nvidia.com>
> > > > ---
> > > > =A0 drivers/virtio/virtio_vdpa.c | 4 +++-
> > > > =A0 1 file changed, 3 insertions(+), 1 deletion(-)
> > > > =

> > > > diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_v=
dpa.c
> > > > index eb6aee8c06b2..989e2d7184ce 100644
> > > > --- a/drivers/virtio/virtio_vdpa.c
> > > > +++ b/drivers/virtio/virtio_vdpa.c
> > > > @@ -385,7 +385,9 @@ static int virtio_vdpa_find_vqs(struct virtio_d=
evice
> > > > *vdev, unsigned int nvqs,
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 err =3D PTR_ERR(vqs[i]);
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
=A0=A0 goto err_setup_vq;
> > > > =A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 }
> > > > -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 ops->set_vq_affinity(vd=
pa, i, &masks[i]);
> > > > +
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 if (ops->set_vq_affinit=
y)
> > > > +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=
 ops->set_vq_affinity(vdpa, i, &masks[i]);
> > > if ops->set_vq_affinity is NULL, should give an error code to err, and
> > > return err
> > =

> > Given we ignore return code, hardly seems like a critical thing to do.
> > Is it really important? affinity is an optimization isn't it?
> > =

> > > > =

> set_vq_affinity is optional so it's not an error if the op is not impleme=
nted.
> =

> Is there anything else that needs to be done for this fix?
> =

> Thanks,
> Dragos
> =


no, it's queued already.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
