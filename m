Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5F13BC433F5
	for <virtualization@archiver.kernel.org>; Mon,  7 Mar 2022 10:06:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DE83640472;
	Mon,  7 Mar 2022 10:06:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uIbk6_F-Mgxz; Mon,  7 Mar 2022 10:06:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3A0AF4012D;
	Mon,  7 Mar 2022 10:06:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C620C001D;
	Mon,  7 Mar 2022 10:06:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A17CC000B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 10:06:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 672F8607A4
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 10:06:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vvXe1k2l2seD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 10:05:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-42.freemail.mail.aliyun.com
 (out30-42.freemail.mail.aliyun.com [115.124.30.42])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 295676059C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Mar 2022 10:05:58 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R591e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=7; SR=0; TI=SMTPD_---0V6UQkd0_1646647518; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V6UQkd0_1646647518) by smtp.aliyun-inc.com(127.0.0.1);
 Mon, 07 Mar 2022 18:05:22 +0800
Message-ID: <1646647482.2340114-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost] virtio_net: fix build warnings
Date: Mon, 7 Mar 2022 18:04:42 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20220307094042.22180-1-xuanzhuo@linux.alibaba.com>
 <20220307045948-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220307045948-mutt-send-email-mst@kernel.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Mon, 7 Mar 2022 05:00:20 -0500, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> On Mon, Mar 07, 2022 at 05:40:42PM +0800, Xuan Zhuo wrote:
> > These warnings appear on some platforms (arm multi_v7_defconfig). This
> > patch fixes these warnings.
> >
> > drivers/net/virtio_net.c: In function 'virtnet_rx_vq_reset':
> > drivers/net/virtio_net.c:1823:63: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'int' [-Wformat=]
> >  1823 |                    "reset rx reset vq fail: rx queue index: %ld err: %d\n",
> >       |                                                             ~~^
> >       |                                                               |
> >       |                                                               long int
> >       |                                                             %d
> >  1824 |                    rq - vi->rq, err);
> >       |                    ~~~~~~~~~~~
> >       |                       |
> >       |                       int
> > drivers/net/virtio_net.c: In function 'virtnet_tx_vq_reset':
> > drivers/net/virtio_net.c:1873:63: warning: format '%ld' expects argument of type 'long int', but argument 3 has type 'int' [-Wformat=]
> >  1873 |                    "reset tx reset vq fail: tx queue index: %ld err: %d\n",
> >       |                                                             ~~^
> >       |                                                               |
> >       |                                                               long int
> >       |                                                             %d
> >  1874 |                    sq - vi->sq, err);
> >       |                    ~~~~~~~~~~~
> >       |                       |
> >       |                       int
> >
> > Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
>
> I squashed this into the problematic patch. Take a look
> at my tree to verify all's well pls.

LGTM.

Thanks.

>
> > ---
> >  drivers/net/virtio_net.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > index 1fa2d632a994..4d629d1ea894 100644
> > --- a/drivers/net/virtio_net.c
> > +++ b/drivers/net/virtio_net.c
> > @@ -1820,7 +1820,7 @@ static int virtnet_rx_vq_reset(struct virtnet_info *vi,
> >
> >  err:
> >  	netdev_err(vi->dev,
> > -		   "reset rx reset vq fail: rx queue index: %ld err: %d\n",
> > +		   "reset rx reset vq fail: rx queue index: %td err: %d\n",
> >  		   rq - vi->rq, err);
> >  	virtnet_napi_enable(rq->vq, &rq->napi);
> >  	return err;
> > @@ -1870,7 +1870,7 @@ static int virtnet_tx_vq_reset(struct virtnet_info *vi,
> >
> >  err:
> >  	netdev_err(vi->dev,
> > -		   "reset tx reset vq fail: tx queue index: %ld err: %d\n",
> > +		   "reset tx reset vq fail: tx queue index: %td err: %d\n",
> >  		   sq - vi->sq, err);
> >  	virtnet_napi_tx_enable(vi, sq->vq, &sq->napi);
> >  	return err;
> > --
> > 2.31.0
>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
