Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 271A1C61DA4
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 09:29:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AE9E2429E6;
	Fri,  3 Feb 2023 09:29:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org AE9E2429E6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=cuAtLAew
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jBq2qkHwbPNt; Fri,  3 Feb 2023 09:29:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BEB39429D9;
	Fri,  3 Feb 2023 09:29:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BEB39429D9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93926C0033;
	Fri,  3 Feb 2023 09:29:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EBBF2C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:29:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C5D8981494
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:29:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C5D8981494
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=cuAtLAew
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qG8zpb9TfJ2B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:29:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F290181250
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F290181250
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 09:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675416589;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=bNds1HI1I/0dpuSXz+oY0DFaA+4gCa4y5cBoLVvC84g=;
 b=cuAtLAewThZyS81gZkEZ7iH3uOnsYf2loYctixZd+wum6bLISpsWiiwaf8S9HDsEJvb01o
 UkAyiTwAkTZquysaoslWSMTX4GqjGuoJE+NSZKXUs+UuXZ++luALkweOHaqmCd8b6ZG1+L
 VevIf5a247nEgcg34yo9ix4pYuzPNz0=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-166-bkDC35pfND69FFEVH5gK0w-1; Fri, 03 Feb 2023 04:29:48 -0500
X-MC-Unique: bkDC35pfND69FFEVH5gK0w-1
Received: by mail-ed1-f72.google.com with SMTP id
 n17-20020a056402061100b004a3f32cc366so3228518edv.20
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Feb 2023 01:29:48 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bNds1HI1I/0dpuSXz+oY0DFaA+4gCa4y5cBoLVvC84g=;
 b=eUHiMJ0trnqKGky+pQYcYSRXt1WR845BXVi4nS//ba3k1e2b1Sz8jOAmknAcz6IUJq
 7aCKPCY8QNjJ1DcTUPhH1CysMkJJwA6yRMYVhPgkz+C7SL6TogSy0JxLzAgcIY8wIIom
 jJ7OS7yDa0SP8E9j1FPkjWZgN+x0mBxq5ZKCXMiJqUG3CzVwWE2bZTVBcaBL8mvKE6l9
 /RSAXxQahMh85H2w90YHBjrwwqwhMI30JUYndfy9unzEROnEsnJ7pN7dp6YifH6FeZ86
 ids0b0gbIbGLDqocqCxhxlk1eLAxlyLNXp0rS/fXebAfJ7YOUNjnbBrUR97sYxvqfizj
 qvbA==
X-Gm-Message-State: AO0yUKX7/Tu0Q7fEvPC66Ut5q/78fK0JnTzS8rDuHEOtwbmQFPJ4OBas
 VwxyM9ltrBsIizWFKoib9W5qTm0WlhZqa0dons2f6gJqYl2xCYR4ywfydL5rhap/80dnRIjGEqY
 iygl9Up0uwR8UG1oimOmELGc1ro4p+B9bo0MeawFx4Q==
X-Received: by 2002:a17:907:3e82:b0:878:6755:9089 with SMTP id
 hs2-20020a1709073e8200b0087867559089mr12602392ejc.39.1675416587251; 
 Fri, 03 Feb 2023 01:29:47 -0800 (PST)
X-Google-Smtp-Source: AK7set/jWXVc31NjbbKgYo8E+Q5ARi8JpVQ4Jp8pluUOVMkbKQPKWx5Bd61WD+5ofhOfbTrQifSc5w==
X-Received: by 2002:a17:907:3e82:b0:878:6755:9089 with SMTP id
 hs2-20020a1709073e8200b0087867559089mr12602375ejc.39.1675416587074; 
 Fri, 03 Feb 2023 01:29:47 -0800 (PST)
Received: from redhat.com ([2.52.156.122]) by smtp.gmail.com with ESMTPSA id
 c15-20020a170906340f00b008778f177fbesm1140263ejb.11.2023.02.03.01.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Feb 2023 01:29:46 -0800 (PST)
Date: Fri, 3 Feb 2023 04:29:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 24/33] virtio_net: xsk: stop disable tx napi
Message-ID: <20230203042821-mutt-send-email-mst@kernel.org>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <20230202110058.130695-25-xuanzhuo@linux.alibaba.com>
 <20230202122445-mutt-send-email-mst@kernel.org>
 <1675394682.9569418-1-xuanzhuo@linux.alibaba.com>
 <20230203032945-mutt-send-email-mst@kernel.org>
 <1675414156.9460502-2-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1675414156.9460502-2-xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Petr Machata <petrm@nvidia.com>, Menglong Dong <imagedong@tencent.com>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, netdev@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>,
 =?iso-8859-1?Q?Bj=F6rn_T=F6pel?= <bjorn@kernel.org>,
 Alexei Starovoitov <ast@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Kuniyuki Iwashima <kuniyu@amazon.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

On Fri, Feb 03, 2023 at 04:49:16PM +0800, Xuan Zhuo wrote:
> On Fri, 3 Feb 2023 03:33:41 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Fri, Feb 03, 2023 at 11:24:42AM +0800, Xuan Zhuo wrote:
> > > On Thu, 2 Feb 2023 12:25:59 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > > > On Thu, Feb 02, 2023 at 07:00:49PM +0800, Xuan Zhuo wrote:
> > > > > Since xsk's TX queue is consumed by TX NAPI, if sq is bound to xsk, then
> > > > > we must stop tx napi from being disabled.
> > > > >
> > > > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > > > ---
> > > > >  drivers/net/virtio/main.c | 9 ++++++++-
> > > > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > > > >
> > > > > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > > > > index ed79e750bc6c..232cf151abff 100644
> > > > > --- a/drivers/net/virtio/main.c
> > > > > +++ b/drivers/net/virtio/main.c
> > > > > @@ -2728,8 +2728,15 @@ static int virtnet_set_coalesce(struct net_device *dev,
> > > > >  		return ret;
> > > > >
> > > > >  	if (update_napi) {
> > > > > -		for (i = 0; i < vi->max_queue_pairs; i++)
> > > > > +		for (i = 0; i < vi->max_queue_pairs; i++) {
> > > > > +			/* xsk xmit depend on the tx napi. So if xsk is active,
> > > >
> > > > depends.
> > > >
> > > > > +			 * prevent modifications to tx napi.
> > > > > +			 */
> > > > > +			if (rtnl_dereference(vi->sq[i].xsk.pool))
> > > > > +				continue;
> > > > > +
> > > > >  			vi->sq[i].napi.weight = napi_weight;
> > > >
> > > > I don't get it.
> > > > changing napi weight does not work then.
> > > > why is this ok?
> > >
> > >
> > > static void skb_xmit_done(struct virtqueue *vq)
> > > {
> > > 	struct virtnet_info *vi = vq->vdev->priv;
> > > 	struct napi_struct *napi = &vi->sq[vq2txq(vq)].napi;
> > >
> > > 	/* Suppress further interrupts. */
> > > 	virtqueue_disable_cb(vq);
> > >
> > > 	if (napi->weight)
> > > 		virtqueue_napi_schedule(napi, vq);
> > > 	else
> > > 		/* We were probably waiting for more output buffers. */
> > > 		netif_wake_subqueue(vi->dev, vq2txq(vq));
> > > }
> > >
> > >
> > > If the weight is 0, tx napi will not be triggered again.
> > >
> > > Thanks.
> >
> > This needs more thought then. First ignoring what user is requesting is
> > not nice.
> 
> Maybe we should return an error.

maybe


> >Second what if napi is first disabled and then xsk enabled?
> 
> 
> static int virtnet_xsk_pool_enable(struct net_device *dev,
> 				   struct xsk_buff_pool *pool,
> 				   u16 qid)
> {
> 	struct virtnet_info *vi = netdev_priv(dev);
> 	struct receive_queue *rq;
> 	struct send_queue *sq;
> 	int err;
> 
> 	if (qid >= vi->curr_queue_pairs)
> 		return -EINVAL;
> 
> 	sq = &vi->sq[qid];
> 	rq = &vi->rq[qid];
> 
> 	/* xsk zerocopy depend on the tx napi.
> 	 *
> 	 * All xsk packets are actually consumed and sent out from the xsk tx
> 	 * queue under the tx napi mechanism.
> 	 */
> ->	if (!sq->napi.weight)
> 		return -EPERM;
> 
> Thanks.
> 
> 
> >
> >
> > > >
> > > >
> > > > > +		}
> > > > >  	}
> > > > >
> > > > >  	return ret;
> > > > > --
> > > > > 2.32.0.3.g01195cf9f
> > > >
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
