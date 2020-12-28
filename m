Return-Path: <SRS0=SJT6=GA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36CF4C433DB
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 12:20:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BAC9E20867
	for <virtualization@archiver.kernel.org>; Mon, 28 Dec 2020 12:19:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BAC9E20867
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 573A786CBD;
	Mon, 28 Dec 2020 12:19:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cDqVqwpdC2FX; Mon, 28 Dec 2020 12:19:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id A59CD867E3;
	Mon, 28 Dec 2020 12:19:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FE83C1787;
	Mon, 28 Dec 2020 12:19:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CFDFC0891
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 12:19:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 41A2920464
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 12:19:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id G4cyMBHhSMJ8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 12:19:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id E71FD20457
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 12:19:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609157992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=BFLa7/fMJxMD+hmxL9RGelfjAN9ACxv2rYzNAsWqtCs=;
 b=eKftgFOkYd+JHHJ/JZSFqJnq5ALyn/AEwmm8NdmPkCggoOcjF8o0Uk//resjiMcWZcXm+R
 Ue4P8AjbKwt0q8tjIlkuY8yC+EvIrBRWdzifBCKLiZgoL14aDh+r5SLFrnBBB9tJnGVTLB
 r8Ma+6dQMgZGwbsqRiIAdiI6JVoAwRw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-308-va--Fv9-Njm69KlEUmxOuw-1; Mon, 28 Dec 2020 07:19:50 -0500
X-MC-Unique: va--Fv9-Njm69KlEUmxOuw-1
Received: by mail-wr1-f71.google.com with SMTP id u3so6274615wri.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Dec 2020 04:19:50 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=BFLa7/fMJxMD+hmxL9RGelfjAN9ACxv2rYzNAsWqtCs=;
 b=ovJTx2AM2bTWr7qBtZHzgAFtCARTIrCk0hn0kSTpbF0/URNuV8DSsVvd1z+OXG+YhE
 qmBHMYoVkrgEvL4Cy6ika5iUnSlyo2cqoRFyJmq4vb+u5oAj/y+cnJiLXIA4O5IYKg8g
 BmVmbVyVgc/GRcBVcuokrwpHpnfq2uKGW0jcX1tJc62+JDZKi8dxSHYoaXmgc2XtbmC4
 FaO7GiRoUorl2aCkW6qfYsfiVl43fY04JGCas/Sin0C/1yamwjTnmIrxIfKeqwjqtUqF
 TFYGRneybW7pQz1EaD15x2yiB/+0t0YeA3TC+MizrhzIxO48rn2/k6CIQlm9mpmfLIzW
 YoTA==
X-Gm-Message-State: AOAM531b+5WEhVaLEOQa+5e2MuMEV1CC191v1l7YmDp/+PpTLfGSO3tn
 9Lo7ExWLv1Np04rdt3CwYTRha2+QWAqMWpDnMmB6yOdZIEkaU1ZiS0aqaGqXp0DpPaJj6QDm3dO
 E4/45/GbpoZkcEWoudGddWFKcqBdk0tIqduYXfOpuFg==
X-Received: by 2002:adf:9546:: with SMTP id 64mr51864088wrs.343.1609157989160; 
 Mon, 28 Dec 2020 04:19:49 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQuAj8JtF1rda3DQCqKrOZND9lbHxggLWIfd1KjoHhcs91SFpo39C2HjpJzys8kW5RxrTRng==
X-Received: by 2002:adf:9546:: with SMTP id 64mr51864079wrs.343.1609157989021; 
 Mon, 28 Dec 2020 04:19:49 -0800 (PST)
Received: from redhat.com (bzq-79-178-32-166.red.bezeqint.net. [79.178.32.166])
 by smtp.gmail.com with ESMTPSA id h3sm20098736wmm.4.2020.12.28.04.19.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 28 Dec 2020 04:19:47 -0800 (PST)
Date: Mon, 28 Dec 2020 07:19:45 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: wangyunjian <wangyunjian@huawei.com>
Subject: Re: [PATCH net v5 2/2] vhost_net: fix tx queue stuck when sendmsg
 fails
Message-ID: <20201228071824-mutt-send-email-mst@kernel.org>
References: <1608881073-19004-1-git-send-email-wangyunjian@huawei.com>
 <20201227061916-mutt-send-email-mst@kernel.org>
 <34EFBCA9F01B0748BEB6B629CE643AE60DBA7B3C@DGGEMM533-MBX.china.huawei.com>
MIME-Version: 1.0
In-Reply-To: <34EFBCA9F01B0748BEB6B629CE643AE60DBA7B3C@DGGEMM533-MBX.china.huawei.com>
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

On Mon, Dec 28, 2020 at 11:55:36AM +0000, wangyunjian wrote:
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
> 
> In the case, the VM will not be able to send packets persistently. Services of VM
> are affected.
> 
> Thanks


Well VM can always harm itself right? Just halt the CPU, services will
be affected ;)


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
> OK
> 
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
