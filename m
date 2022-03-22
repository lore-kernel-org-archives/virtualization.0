Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B26DBC4332F
	for <virtualization@archiver.kernel.org>; Tue, 22 Mar 2022 06:24:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4C78E611BB;
	Tue, 22 Mar 2022 06:24:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vyMZ75c93QOF; Tue, 22 Mar 2022 06:24:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D9F0860E39;
	Tue, 22 Mar 2022 06:24:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5E2EC001A;
	Tue, 22 Mar 2022 06:24:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 04DD1C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 06:24:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CF928415D5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 06:24:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1lkAIpmNC-5D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 06:24:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0B03F415D1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 06:24:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647930290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=HEz0eGSQCNfMxHOZJEc6t2WQP3o27mzcx3/UPYIzBqk=;
 b=Y1IRJ19Fc2+/3+kyqdl1ZQagBZCmBm12TSTIZ5IZNdY9xqKEW/FsyZlN6anzG+8HxtETdr
 5lLRqOZr+2ozMp4aY1WdRjgPn/pHqYGhcREYE9/ptbm4SXhIgM98zHhmhUKaxxHVf1/hCW
 k2HpnPyMFiirmx8t8ievWD4VDsJx5VY=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-214-Oq_FI7P6MtCvxSVxxV5FAw-1; Tue, 22 Mar 2022 02:24:49 -0400
X-MC-Unique: Oq_FI7P6MtCvxSVxxV5FAw-1
Received: by mail-wm1-f69.google.com with SMTP id
 l7-20020a05600c1d0700b0038c9c48f1e7so596111wms.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 23:24:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=HEz0eGSQCNfMxHOZJEc6t2WQP3o27mzcx3/UPYIzBqk=;
 b=IG8DYAwuHYEsJ/sTgL4X//XgXdRFr7HoS3u5GZuLAyZtZUFAz6nBcjrV39yWvbei1z
 pg1XFf2jKJXQmdqiyvOEvXQvXwukWZwS42GYqZLfd0dFOE0OTgjBO6xJ+6vbqP2M4x4g
 dho3VpRGm9/PUM9jn+R8wKpRWo+bDoZXs0T8iQFJkkSCleSmVrG5lOvbutA/xPzmFxTt
 k5wo4lg5kesIA2o98JKNLey3q/J1YJKosmK26u+TY60HMEzEtGGDguce7Q2ykVaNJ5Mk
 cuV89pgymix1I078GxPgwYX1QVtYEy+pD7F8JaXmU9ys/b5XcpJmJmz3gEZElT/mTXl+
 j/Xg==
X-Gm-Message-State: AOAM532jRE2m1tnAhRd5/KYiHk7aJf/UGnEGM+YKUcUIk8OfRRnaEiZk
 OiCZVBz+kvhpWpr3kF1Q61D+BYgfcdCmQTrwYWIcWrsRKD21ai2e9RGGVLwJSBBTl9J5bEh7eR0
 DGpy9h/9Fvpx3PcXwLFpjvds7NxHfW8qvs6PBAUnmAA==
X-Received: by 2002:a05:600c:378d:b0:38b:e12f:edde with SMTP id
 o13-20020a05600c378d00b0038be12feddemr2194127wmr.69.1647930287691; 
 Mon, 21 Mar 2022 23:24:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzZiKTplxP6YyBZi2v2w5Yhl2dtthUYjwGl566x0gjf+UuNb4xHAApToT8Yi6mDtRMz7aIXBA==
X-Received: by 2002:a05:600c:378d:b0:38b:e12f:edde with SMTP id
 o13-20020a05600c378d00b0038be12feddemr2194115wmr.69.1647930287465; 
 Mon, 21 Mar 2022 23:24:47 -0700 (PDT)
Received: from redhat.com ([2.55.132.0]) by smtp.gmail.com with ESMTPSA id
 z5-20020a05600c0a0500b0037bb8df81a2sm1268234wmp.13.2022.03.21.23.24.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 21 Mar 2022 23:24:46 -0700 (PDT)
Date: Tue, 22 Mar 2022 02:24:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v8 01/16] virtio: add helper virtqueue_get_vring_max_size()
Message-ID: <20220322022341-mutt-send-email-mst@kernel.org>
References: <20220314093455.34707-1-xuanzhuo@linux.alibaba.com>
 <20220314093455.34707-2-xuanzhuo@linux.alibaba.com>
 <87cziohnhr.fsf@redhat.com>
 <20220314071819-mutt-send-email-mst@kernel.org>
 <1647256878.7874777-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1647256878.7874777-2-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Cornelia Huck <cohuck@redhat.com>,
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

On Mon, Mar 14, 2022 at 07:21:18PM +0800, Xuan Zhuo wrote:
> On Mon, 14 Mar 2022 07:18:27 -0400, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Mon, Mar 14, 2022 at 10:50:08AM +0100, Cornelia Huck wrote:
> > > On Mon, Mar 14 2022, Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrote:
> > >
> > > > Record the maximum queue num supported by the device.
> > > >
> > > > virtio-net can display the maximum (supported by hardware) ring size in
> > > > ethtool -g eth0.
> > > >
> > > > When the subsequent patch implements vring reset, it can judge whether
> > > > the ring size passed by the driver is legal based on this.
> > > >
> > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > > ---
> > > >  drivers/virtio/virtio_mmio.c       |  2 ++
> > > >  drivers/virtio/virtio_pci_legacy.c |  2 ++
> > > >  drivers/virtio/virtio_pci_modern.c |  2 ++
> > > >  drivers/virtio/virtio_ring.c       | 14 ++++++++++++++
> > > >  include/linux/virtio.h             |  2 ++
> > > >  5 files changed, 22 insertions(+)
> > >
> > > Don't you also need to init this for ccw (even though we won't do ring
> > > reset there), just for completeness? (Any other transports?)
> >
> > rpmsg?
> 
> There should be these.
> 
>  arch/um/drivers/virtio_uml.c             |  1 +
>  drivers/platform/mellanox/mlxbf-tmfifo.c |  2 ++
>  drivers/remoteproc/remoteproc_virtio.c   |  2 ++
>  drivers/s390/virtio/virtio_ccw.c         |  3 +++
>  drivers/virtio/virtio_mmio.c             |  2 ++
>  drivers/virtio/virtio_pci_legacy.c       |  2 ++
>  drivers/virtio/virtio_pci_modern.c       |  2 ++
>  drivers/virtio/virtio_vdpa.c             |  2 ++
> 
> It will be included in the next version.

Hmm so merge window is open but we don't have a final version yet.
Not sure it can make it in this merge window ..


> Thanks.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
