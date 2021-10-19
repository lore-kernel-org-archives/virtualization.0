Return-Path: <SRS0=CXPs=PH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DB44C433FE
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 10:39:29 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2C363610E7
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 10:39:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2C363610E7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EDD0C81BCF;
	Tue, 19 Oct 2021 10:39:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fbYrk3ZS3nNP; Tue, 19 Oct 2021 10:39:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 6AB7481AF6;
	Tue, 19 Oct 2021 10:39:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 44839C000F;
	Tue, 19 Oct 2021 10:39:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A7294C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 10:39:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6C68360B5E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 10:37:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IsP7jwRemDLz
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 10:37:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id A707360B56
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 10:37:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634639827;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cAQsBHydgzMjOzRTPF8Ki+usRko1EEMZbSVZpLxCFAA=;
 b=R1iBhi83wnc43WqZfNW/0KLxVLgKPrrhJi2qjMoOnc+6GQn0TBndRztzZ+SFIOvJuoiygl
 JQIwy7C6XvpxBKEY3rn+GoYJkUQ63irt69+MvGz5l8piWwi0HjWAnTVwccqZmuiPoZz/ZY
 /At1OeH6CqDwe3QQO656cAlPINo2OZs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-102-vaYTwGw9OvWY8u8vNolbBQ-1; Tue, 19 Oct 2021 06:37:06 -0400
X-MC-Unique: vaYTwGw9OvWY8u8vNolbBQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 s18-20020adfbc12000000b00160b2d4d5ebso10045283wrg.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 03:37:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=cAQsBHydgzMjOzRTPF8Ki+usRko1EEMZbSVZpLxCFAA=;
 b=hVIAoWnEssv/cGp8r4yvvtt2StOit8W1Ap/FOeT6MfHckt9IMxtg+6i6wbtkUHHu2z
 cxYvpQlS4ffLLqyl6jvM6RCgo4Lp+V3I7dJXmYvQ1fFb/2zzuoJSx6KEBiG3qc670LrR
 2zxTKnplMEuadsMrom8h/mWCq0kzw8wUG2SKqU73JQ6Ab09Ee055z3ZBBXb/c36rHSzh
 fw7iu2FpvGPCyVXGzmZ5YPwruSZnvxOgXplGFNDl2kAgLcWcyCV3aLhAcJyxrXlRzg4u
 OufZ9sqcq23tSIpY/TPfAcGSAE04vcJ1lg2XzNolx680wM8MnbCMphqLlay6OyrZqpcf
 ssYQ==
X-Gm-Message-State: AOAM532psbOKhwdw1SptxHz54VtfVGD4aNxrB/zx+EcVxpNVNRatFctW
 0UVDcEdWNKqFq2rSAQJefhURbGLWpnG+3gDJYE0csZnFEOJUeSHB2/yeqOydbzbgXuaKYV2IGhS
 DWcqSjPyBFCD5Wcacv2C584i7ZeLS35bdVdA7wEo07Q==
X-Received: by 2002:adf:8b84:: with SMTP id o4mr42842557wra.108.1634639825269; 
 Tue, 19 Oct 2021 03:37:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzVLveMMkJNDyTdvIMAyJyBw2e+/NydmNGsn4YI7SpswnHqSAORSosIXakO0U2k13gdqAkzKg==
X-Received: by 2002:adf:8b84:: with SMTP id o4mr42842521wra.108.1634639824955; 
 Tue, 19 Oct 2021 03:37:04 -0700 (PDT)
Received: from redhat.com ([2.55.24.172])
 by smtp.gmail.com with ESMTPSA id i13sm2152294wmq.41.2021.10.19.03.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Oct 2021 03:37:03 -0700 (PDT)
Date: Tue, 19 Oct 2021 06:37:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio: Introduce a new kick interface
 virtqueue_kick_try()
Message-ID: <20211019063009-mutt-send-email-mst@kernel.org>
References: <fdfca0e9-dd2c-13a2-39ed-b360f7bcb881@redhat.com>
 <1634631199.0198228-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1634631199.0198228-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>, netdev@vger.kernel.org
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

On Tue, Oct 19, 2021 at 04:13:19PM +0800, Xuan Zhuo wrote:
> On Mon, 31 May 2021 14:34:16 +0800, Jason Wang <jasowang@redhat.com> wrot=
e:
> >
> > =D4=DA 2021/5/19 =CF=C2=CE=E77:47, Xuan Zhuo =D0=B4=B5=C0:
> > > Unlike virtqueue_kick(), virtqueue_kick_try() returns true only when =
the
> > > kick is successful. In virtio-net, we want to count the number of kic=
ks.
> > > So we need an interface that can perceive whether the kick is actually
> > > executed.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> >
> >
> > Acked-by: Jason Wang <jasowang@redhat.com>
> =

> Hi, this patch seems to have not been merged, is there something wrong wi=
th me?
> =

> Thanks.

The commit log does not make it clear, but this is just
code refactoring. Pls make it clearer in the log.
Also, if we add a new API like this as a cleanup,
it needs to be documented much better.


> >
> > Thanks
> >
> >
> > > ---
> > >   drivers/net/virtio_net.c     |  8 ++++----
> > >   drivers/virtio/virtio_ring.c | 20 ++++++++++++++++++++
> > >   include/linux/virtio.h       |  2 ++
> > >   3 files changed, 26 insertions(+), 4 deletions(-)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 9b6a4a875c55..167697030cb6 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -617,7 +617,7 @@ static int virtnet_xdp_xmit(struct net_device *de=
v,
> > >   	ret =3D nxmit;
> > >
> > >   	if (flags & XDP_XMIT_FLUSH) {
> > > -		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq))
> > > +		if (virtqueue_kick_try(sq->vq))
> > >   			kicks =3D 1;
> > >   	}
> > >   out:
> > > @@ -1325,7 +1325,7 @@ static bool try_fill_recv(struct virtnet_info *=
vi, struct receive_queue *rq,
> > >   		if (err)
> > >   			break;
> > >   	} while (rq->vq->num_free);
> > > -	if (virtqueue_kick_prepare(rq->vq) && virtqueue_notify(rq->vq)) {
> > > +	if (virtqueue_kick_try(rq->vq)) {
> > >   		unsigned long flags;
> > >
> > >   		flags =3D u64_stats_update_begin_irqsave(&rq->stats.syncp);
> > > @@ -1533,7 +1533,7 @@ static int virtnet_poll(struct napi_struct *nap=
i, int budget)
> > >
> > >   	if (xdp_xmit & VIRTIO_XDP_TX) {
> > >   		sq =3D virtnet_xdp_get_sq(vi);
> > > -		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
> > > +		if (virtqueue_kick_try(sq->vq)) {
> > >   			u64_stats_update_begin(&sq->stats.syncp);
> > >   			sq->stats.kicks++;
> > >   			u64_stats_update_end(&sq->stats.syncp);
> > > @@ -1710,7 +1710,7 @@ static netdev_tx_t start_xmit(struct sk_buff *s=
kb, struct net_device *dev)
> > >   	}
> > >
> > >   	if (kick || netif_xmit_stopped(txq)) {
> > > -		if (virtqueue_kick_prepare(sq->vq) && virtqueue_notify(sq->vq)) {
> > > +		if (virtqueue_kick_try(sq->vq)) {
> > >   			u64_stats_update_begin(&sq->stats.syncp);
> > >   			sq->stats.kicks++;
> > >   			u64_stats_update_end(&sq->stats.syncp);
> > > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_rin=
g.c
> > > index 71e16b53e9c1..1462be756875 100644
> > > --- a/drivers/virtio/virtio_ring.c
> > > +++ b/drivers/virtio/virtio_ring.c
> > > @@ -1874,6 +1874,26 @@ bool virtqueue_kick(struct virtqueue *vq)
> > >   }
> > >   EXPORT_SYMBOL_GPL(virtqueue_kick);
> > >
> > > +/**
> > > + * virtqueue_kick_try - try update after add_buf
> > > + * @vq: the struct virtqueue
> > > + *
> > > + * After one or more virtqueue_add_* calls, invoke this to kick
> > > + * the other side.
> > > + *
> > > + * Caller must ensure we don't call this with other virtqueue
> > > + * operations at the same time (except where noted).
> > > + *
> > > + * Returns true if kick success, otherwise false.

on a successful kick?

> > > + */

I don't really understand what this is doing, the comment
doesn't seem to explain. Try implies it might fail to update.

virtqueue_kick seems to be documented the same:
 * Returns false if kick failed, otherwise true.


> > > +bool virtqueue_kick_try(struct virtqueue *vq)
> > > +{
> > > +	if (virtqueue_kick_prepare(vq) && virtqueue_notify(vq))
> > > +		return true;
> > > +	return false;
> > > +}
> > > +EXPORT_SYMBOL_GPL(virtqueue_kick_try);
> > > +
> > >   /**
> > >    * virtqueue_get_buf - get the next used buffer
> > >    * @_vq: the struct virtqueue we're talking about.
> > > diff --git a/include/linux/virtio.h b/include/linux/virtio.h
> > > index b1894e0323fa..45cd6a0af24d 100644
> > > --- a/include/linux/virtio.h
> > > +++ b/include/linux/virtio.h
> > > @@ -59,6 +59,8 @@ int virtqueue_add_sgs(struct virtqueue *vq,
> > >
> > >   bool virtqueue_kick(struct virtqueue *vq);
> > >
> > > +bool virtqueue_kick_try(struct virtqueue *vq);
> > > +
> > >   bool virtqueue_kick_prepare(struct virtqueue *vq);
> > >
> > >   bool virtqueue_notify(struct virtqueue *vq);
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
