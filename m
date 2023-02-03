Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8E0BC636D6
	for <virtualization@archiver.kernel.org>; Fri,  3 Feb 2023 08:33:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 66076429C6;
	Fri,  3 Feb 2023 08:33:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 66076429C6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Es+CFDeM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id H_kiXWmtnn4f; Fri,  3 Feb 2023 08:33:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8D4D041D41;
	Fri,  3 Feb 2023 08:33:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8D4D041D41
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60497C0032;
	Fri,  3 Feb 2023 08:33:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1D178C002B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:33:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D62CF41D41
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:33:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D62CF41D41
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2VqzUgBfOBy2
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:33:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C273541D21
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C273541D21
 for <virtualization@lists.linux-foundation.org>;
 Fri,  3 Feb 2023 08:33:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675413229;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=c9gia5gCXojDKJbnjBecgsqKUe4A6lVBjKVa+Q7BTrU=;
 b=Es+CFDeMQrAGZA/KkThcSvNXwe5vpbGJZXeKQxoddvNTcjN5jvOUGNp8SJhJgKjnFnWfy8
 FGtRJ7ZUAoKNRI2B6mY2Az+ngvrwpoWNQivK7J2G3kcBsnr4OeDwx7xwCmMkwAm4oq7OWa
 k1E5WEKIrk9Eat5/XgEpUp486a+lDuA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-279-6cftP8pBNaSNCf9SmJoAHg-1; Fri, 03 Feb 2023 03:33:48 -0500
X-MC-Unique: 6cftP8pBNaSNCf9SmJoAHg-1
Received: by mail-wm1-f71.google.com with SMTP id
 o31-20020a05600c511f00b003dc53da325dso4207060wms.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 03 Feb 2023 00:33:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=c9gia5gCXojDKJbnjBecgsqKUe4A6lVBjKVa+Q7BTrU=;
 b=vqTsD2v+an3+VQODJyklSSY/6hm4tR68F0x9EM2IS7cc91wN4k4oKJ1CtLkQGw/9tu
 rbkCdpliOwDxsjqwTO9/jaftBeZVHZmMVAgqdnb8CdURYpP7SOT0CTUt6yIlY+vUNPE9
 QK8HQgS4VzmpxaSTysP2sQOCGp0GSdTjP7wpxEc9sSgAYcpdkhgypHcxhD7dBc77vXLm
 l+J24n6aVvXL9zlwaHVHTbG7UZtSMlmiwp1nA1PXDo9su4z0vu5O1fwNFthXcxC2ZggP
 K5m/UbZ6c01nZK+XOwdlQLaoSm6S02+gcy7AxZFfmWpu9JGAL2gb4w1VYzhubnCDH2JE
 66lA==
X-Gm-Message-State: AO0yUKUSKHNK6Kg3ND7v6Mahb1nUpCVbGu2CKtnEhyPu12sCNJR20AQy
 EdrPBFs5Eac2cpjDvX3Eu5cbQETpHcFbEiRqS+yFVzcLefaGdVHu45VODW3Mqvx7VKfabw7SHWa
 4tImJL7lsoTsKI0O45RTS3kxeJQkRh6ohWIWrzfamNQ==
X-Received: by 2002:a05:600c:1d03:b0:3dd:1bcc:eb17 with SMTP id
 l3-20020a05600c1d0300b003dd1bcceb17mr8913701wms.28.1675413226957; 
 Fri, 03 Feb 2023 00:33:46 -0800 (PST)
X-Google-Smtp-Source: AK7set+Y8WwnwZ3TGibkgw7+NTRwE/wRyUdxNN+qG3QQe1IWY+jcAry8oCig/t9FCfmiWTBrHfVg6Q==
X-Received: by 2002:a05:600c:1d03:b0:3dd:1bcc:eb17 with SMTP id
 l3-20020a05600c1d0300b003dd1bcceb17mr8913678wms.28.1675413226764; 
 Fri, 03 Feb 2023 00:33:46 -0800 (PST)
Received: from redhat.com ([2.52.156.122]) by smtp.gmail.com with ESMTPSA id
 m13-20020a05600c3b0d00b003dc51c48f0bsm7879692wms.19.2023.02.03.00.33.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 03 Feb 2023 00:33:46 -0800 (PST)
Date: Fri, 3 Feb 2023 03:33:41 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 24/33] virtio_net: xsk: stop disable tx napi
Message-ID: <20230203032945-mutt-send-email-mst@kernel.org>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <20230202110058.130695-25-xuanzhuo@linux.alibaba.com>
 <20230202122445-mutt-send-email-mst@kernel.org>
 <1675394682.9569418-1-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <1675394682.9569418-1-xuanzhuo@linux.alibaba.com>
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

On Fri, Feb 03, 2023 at 11:24:42AM +0800, Xuan Zhuo wrote:
> On Thu, 2 Feb 2023 12:25:59 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> > On Thu, Feb 02, 2023 at 07:00:49PM +0800, Xuan Zhuo wrote:
> > > Since xsk's TX queue is consumed by TX NAPI, if sq is bound to xsk, then
> > > we must stop tx napi from being disabled.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >  drivers/net/virtio/main.c | 9 ++++++++-
> > >  1 file changed, 8 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> > > index ed79e750bc6c..232cf151abff 100644
> > > --- a/drivers/net/virtio/main.c
> > > +++ b/drivers/net/virtio/main.c
> > > @@ -2728,8 +2728,15 @@ static int virtnet_set_coalesce(struct net_device *dev,
> > >  		return ret;
> > >
> > >  	if (update_napi) {
> > > -		for (i = 0; i < vi->max_queue_pairs; i++)
> > > +		for (i = 0; i < vi->max_queue_pairs; i++) {
> > > +			/* xsk xmit depend on the tx napi. So if xsk is active,
> >
> > depends.
> >
> > > +			 * prevent modifications to tx napi.
> > > +			 */
> > > +			if (rtnl_dereference(vi->sq[i].xsk.pool))
> > > +				continue;
> > > +
> > >  			vi->sq[i].napi.weight = napi_weight;
> >
> > I don't get it.
> > changing napi weight does not work then.
> > why is this ok?
> 
> 
> static void skb_xmit_done(struct virtqueue *vq)
> {
> 	struct virtnet_info *vi = vq->vdev->priv;
> 	struct napi_struct *napi = &vi->sq[vq2txq(vq)].napi;
> 
> 	/* Suppress further interrupts. */
> 	virtqueue_disable_cb(vq);
> 
> 	if (napi->weight)
> 		virtqueue_napi_schedule(napi, vq);
> 	else
> 		/* We were probably waiting for more output buffers. */
> 		netif_wake_subqueue(vi->dev, vq2txq(vq));
> }
> 
> 
> If the weight is 0, tx napi will not be triggered again.
> 
> Thanks.

This needs more thought then. First ignoring what user is requesting is
not nice.  Second what if napi is first disabled and then xsk enabled?


> >
> >
> > > +		}
> > >  	}
> > >
> > >  	return ret;
> > > --
> > > 2.32.0.3.g01195cf9f
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
