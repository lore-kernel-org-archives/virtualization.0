Return-Path: <SRS0=SJT6=GA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CA59C433E0
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 16:12:05 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9AF56207C9
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 16:12:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9AF56207C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 32D5922F05;
	Mon, 28 Dec 2020 16:12:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sEgdfQUKDHxw; Mon, 28 Dec 2020 16:12:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B41F022925;
	Mon, 28 Dec 2020 16:12:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 81D39C1787;
	Mon, 28 Dec 2020 16:12:02 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9D9AFC0891
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 16:12:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8C7DE86AA2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 16:12:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8zx+wsXxwm0n
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 16:11:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4D41286A7C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 16:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609171917;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uvKCkMpLbJBEy4PbLRQSRYxBLiCodoQvuCZpQ8VRVZ4=;
 b=dh3JXaJ/tp9KLKSDrAAuMrV0DTYhV4QmPZo9M9DtLFZEBC3AbPbaDWaQJ9qzEX/LUQV6KR
 MImMyZB3WX2ZjL8w+lOMGc7VnfoppExpl8N5yG9f9+4almd3XkWB0Q/2iPsHJLKFfikMX6
 socBcFgg6YotCvrO9wZNc847L4ZyXdI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-7hg54z-mOe6v9OOzg2XDTg-1; Mon, 28 Dec 2020 11:11:55 -0500
X-MC-Unique: 7hg54z-mOe6v9OOzg2XDTg-1
Received: by mail-wr1-f69.google.com with SMTP id b8so6503285wrv.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 08:11:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uvKCkMpLbJBEy4PbLRQSRYxBLiCodoQvuCZpQ8VRVZ4=;
 b=MhoS1y4/t7tcodpqJe76D2iVH5d9XOysKeHbZ1eQ9hoibmOax5Wz26/TOIwI1iCc01
 fYkN1dxHcVugQKH5gUcRoyjjn1CCxj74lcJOj1DpWSXa+wpMQZWWA/PfWmI2mDf219Fu
 ADa+jzmc/pnI4quna4ZdSwzlxgl6wQPWIrRJ96hRB7xzsKnnzFuusEztyva3dT/mBlDm
 StVJksP22liJeMsQ7x++67ENoXIeq2MndWxNfAD9NHq0RFbB1Mc3gGojmQR2lGIzpjUY
 7N+aHhbM0kZaxYk/2QkTKxkzaLc1TcwXpaDQjVGksfmBoWbyscBOvOBvXEN1bmFsM7dF
 EBhw==
X-Gm-Message-State: AOAM532ADOWe4oRQ8AeVGMWRj4WvlhVALhPiTdJuti3pPgbOkfgsLaMW
 a9dVeMGefzEgEO/1J4Qjr0iVXuKGoa5yS62mIPgEc4Z+z+KLmSWDR2r64N7I74zXpBrkDidZvjS
 uLliisQiV9oZ8N9qbW8i/qWTRH2Q73xnCx3ZRVO84Lw==
X-Received: by 2002:a1c:7218:: with SMTP id n24mr21030864wmc.186.1609171914410; 
 Mon, 28 Dec 2020 08:11:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyNOK/usBQvgTV6OkzrGuYREHCDYCUHLEQZiVe+l+R8T4qY+OyVyQWCp96GFBrHRx0AxH7vHQ==
X-Received: by 2002:a1c:7218:: with SMTP id n24mr21030845wmc.186.1609171914257; 
 Mon, 28 Dec 2020 08:11:54 -0800 (PST)
Received: from redhat.com (bzq-79-178-32-166.red.bezeqint.net. [79.178.32.166])
 by smtp.gmail.com with ESMTPSA id o124sm20561561wmb.5.2020.12.28.08.11.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Dec 2020 08:11:53 -0800 (PST)
Date: Mon, 28 Dec 2020 11:11:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: wangyunjian <wangyunjian@huawei.com>
Subject: Re: [PATCH net v5 2/2] vhost_net: fix tx queue stuck when sendmsg
 fails
Message-ID: <20201228111139-mutt-send-email-mst@kernel.org>
References: <1608881073-19004-1-git-send-email-wangyunjian@huawei.com>
 <20201227061916-mutt-send-email-mst@kernel.org>
 <34EFBCA9F01B0748BEB6B629CE643AE60DBA8C53@DGGEMM533-MBX.china.huawei.com>
MIME-Version: 1.0
In-Reply-To: <34EFBCA9F01B0748BEB6B629CE643AE60DBA8C53@DGGEMM533-MBX.china.huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "willemdebruijn.kernel@gmail.com" <willemdebruijn.kernel@gmail.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "Lilijun \(Jerry\)" <jerry.lilijun@huawei.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, xudingke <xudingke@huawei.com>,
 "huangbin \(J\)" <brian.huangbin@huawei.com>,
 chenchanghu <chenchanghu@huawei.com>
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

On Mon, Dec 28, 2020 at 01:27:42PM +0000, wangyunjian wrote:
> > -----Original Message-----
> > From: Michael S. Tsirkin [mailto:mst@redhat.com]
> > Sent: Sunday, December 27, 2020 7:21 PM
> > To: wangyunjian <wangyunjian@huawei.com>
> > Cc: netdev@vger.kernel.org; jasowang@redhat.com;
> > willemdebruijn.kernel@gmail.com; virtualization@lists.linux-foundation.org;
> > Lilijun (Jerry) <jerry.lilijun@huawei.com>; chenchanghu
> > <chenchanghu@huawei.com>; xudingke <xudingke@huawei.com>; huangbin (J)
> > <brian.huangbin@huawei.com>
> > Subject: Re: [PATCH net v5 2/2] vhost_net: fix tx queue stuck when sendmsg
> > fails
> > 
> > On Fri, Dec 25, 2020 at 03:24:33PM +0800, wangyunjian wrote:
> > > From: Yunjian Wang <wangyunjian@huawei.com>
> > >
> > > Currently the driver doesn't drop a packet which can't be sent by tun
> > > (e.g bad packet). In this case, the driver will always process the
> > > same packet lead to the tx queue stuck.
> > 
> > So not making progress on a bad packet has some advantages, e.g. this is
> > easier to debug.
> > When is it important to drop the packet and continue?
> > 
> > 
> > > To fix this issue:
> > > 1. in the case of persistent failure (e.g bad packet), the driver
> > >    can skip this descriptor by ignoring the error.
> > > 2. in the case of transient failure (e.g -ENOBUFS, -EAGAIN and -ENOMEM),
> > >    the driver schedules the worker to try again.
> > >
> > > Fixes: 3a4d5c94e959 ("vhost_net: a kernel-level virtio server")
> > 
> > I'd just drop this tag, looks more like a feature than a bug ...
> 
> Do these two patches need to be sent separately?
> 
> Thanks

Makes sense to me.

> > 
> > 
> > > Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> > > Acked-by: Willem de Bruijn <willemb@google.com>
> > > ---
> > >  drivers/vhost/net.c | 16 ++++++++--------
> > >  1 file changed, 8 insertions(+), 8 deletions(-)
> > >
> > > diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c index
> > > c8784dfafdd7..01558fb2c552 100644
> > > --- a/drivers/vhost/net.c
> > > +++ b/drivers/vhost/net.c
> > > @@ -827,14 +827,13 @@ static void handle_tx_copy(struct vhost_net *net,
> > struct socket *sock)
> > >  				msg.msg_flags &= ~MSG_MORE;
> > >  		}
> > >
> > > -		/* TODO: Check specific error and bomb out unless ENOBUFS? */
> > >  		err = sock->ops->sendmsg(sock, &msg, len);
> > > -		if (unlikely(err < 0)) {
> > > +		if (unlikely(err == -EAGAIN || err == -ENOMEM || err == -ENOBUFS))
> > > +{
> > >  			vhost_discard_vq_desc(vq, 1);
> > >  			vhost_net_enable_vq(net, vq);
> > >  			break;
> > >  		}
> > > -		if (err != len)
> > > +		if (err >= 0 && err != len)
> > >  			pr_debug("Truncated TX packet: len %d != %zd\n",
> > >  				 err, len);
> > >  done:
> > > @@ -922,7 +921,6 @@ static void handle_tx_zerocopy(struct vhost_net
> > *net, struct socket *sock)
> > >  			msg.msg_flags &= ~MSG_MORE;
> > >  		}
> > >
> > > -		/* TODO: Check specific error and bomb out unless ENOBUFS? */
> > >  		err = sock->ops->sendmsg(sock, &msg, len);
> > >  		if (unlikely(err < 0)) {
> > >  			if (zcopy_used) {
> > > @@ -931,11 +929,13 @@ static void handle_tx_zerocopy(struct vhost_net
> > *net, struct socket *sock)
> > >  				nvq->upend_idx = ((unsigned)nvq->upend_idx - 1)
> > >  					% UIO_MAXIOV;
> > >  			}
> > > -			vhost_discard_vq_desc(vq, 1);
> > > -			vhost_net_enable_vq(net, vq);
> > > -			break;
> > > +			if (err == -EAGAIN || err == -ENOMEM || err == -ENOBUFS) {
> > > +				vhost_discard_vq_desc(vq, 1);
> > > +				vhost_net_enable_vq(net, vq);
> > > +				break;
> > > +			}
> > >  		}
> > > -		if (err != len)
> > > +		if (err >= 0 && err != len)
> > >  			pr_debug("Truncated TX packet: "
> > >  				 " len %d != %zd\n", err, len);
> > >  		if (!zcopy_used)
> > > --
> > > 2.23.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
