Return-Path: <SRS0=FCrO=F7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16E6BC433DB
	for <virtualization@archiver.kernel.org>; Sun, 27 Dec 2020 11:09:47 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 99CDB224B8
	for <virtualization@archiver.kernel.org>; Sun, 27 Dec 2020 11:09:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 99CDB224B8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4B61E86016;
	Sun, 27 Dec 2020 11:09:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZkPN40RkT9GD; Sun, 27 Dec 2020 11:09:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 512EB85FEF;
	Sun, 27 Dec 2020 11:09:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3D7F4C1787;
	Sun, 27 Dec 2020 11:09:45 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3EC18C0891
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 11:09:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 304C4855D1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 11:09:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id WHXQa7-2u_T1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 11:09:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id D4E1084806
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 11:09:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609067380;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=mMpHyCvuukTc4reZINDYlJOGEPebUzIz94UtOCDP/1Q=;
 b=V4cyhDJCHctGjgF8L2F/ySb1Y4Y0Fxl+3Y/v/sB5hAJg/nWTtoVp7Me11ZhLgI7aOTZDPs
 /rC6NSpccZStr6F42nOn/AL7I8EDOV9itQFNNNdh7TdkBMzA4bkz+TNsJwarIihcCrq4dx
 hLmrsfnB3Mq5+RF0eN75Xxof1+3y1kk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-521-D87lJWJVMFuiwd0ZyeiEvQ-1; Sun, 27 Dec 2020 06:09:38 -0500
X-MC-Unique: D87lJWJVMFuiwd0ZyeiEvQ-1
Received: by mail-wr1-f69.google.com with SMTP id m20so4423590wrh.2
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 03:09:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=mMpHyCvuukTc4reZINDYlJOGEPebUzIz94UtOCDP/1Q=;
 b=YxjHs8HgAlxvVKvELe8Xe38MsF0r4GuSAOdXYvqp5RbGtOeTHKcbIDkQYomBt1fkzy
 WoFJstIlp/kmJ40ArAlwx+2KPNRPg0Jjpc4l8S+6etZzoLfNz2lw+PwBsXwki4geMBA9
 PwJ2utzDfPAGXiG3IgP9PmdI8yP5u8vMsBhJIAVRLOppbQTx6Gt03j2BaeyiSI35Xsge
 IMqgJcyXm2pk1XmbbBJb4JiLbdxI19Es0nqTPALIYQcAZL3CltB3vdWeB9EuvFy+nl1L
 xCJACDQP9IRS8u0DzmaURb1hqJpIIbr/wJk6xZxvXPqALyHmyTji0SGIKBa7uIHmFOxo
 KMpQ==
X-Gm-Message-State: AOAM530+v0Zd4Nk42D4usI629N4yFWba5ndNAL0zryknmCv26EDzoBeI
 uEK0+tL8Ul25d4cTZQNPlI1+kHHYo11D0oWFTgFSQajF3nAzMv98iJnxiDaI5AZ+M5pWzFugsud
 f6jwm+diMeYZxFgKIqWsOabhc/ikpiiqMmfZmP5IFQQ==
X-Received: by 2002:a1c:1fc2:: with SMTP id
 f185mr16269030wmf.134.1609067376928; 
 Sun, 27 Dec 2020 03:09:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyblWot66nLLpG2MFt38HIgsgQZlTRFTn4rhCHII0+SK76t/5Yk/vOo9nlDECxlC8Axj8zo9A==
X-Received: by 2002:a1c:1fc2:: with SMTP id
 f185mr16269009wmf.134.1609067376770; 
 Sun, 27 Dec 2020 03:09:36 -0800 (PST)
Received: from redhat.com (bzq-79-178-32-166.red.bezeqint.net. [79.178.32.166])
 by smtp.gmail.com with ESMTPSA id u10sm14272328wmd.43.2020.12.27.03.09.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Dec 2020 03:09:35 -0800 (PST)
Date: Sun, 27 Dec 2020 06:09:32 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: wangyunjian <wangyunjian@huawei.com>
Subject: Re: [PATCH net v5 2/2] vhost_net: fix tx queue stuck when sendmsg
 fails
Message-ID: <20201227060159-mutt-send-email-mst@kernel.org>
References: <1608881073-19004-1-git-send-email-wangyunjian@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1608881073-19004-1-git-send-email-wangyunjian@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: willemdebruijn.kernel@gmail.com, netdev@vger.kernel.org,
 jerry.lilijun@huawei.com, virtualization@lists.linux-foundation.org,
 xudingke@huawei.com, brian.huangbin@huawei.com, chenchanghu@huawei.com
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

On Fri, Dec 25, 2020 at 03:24:33PM +0800, wangyunjian wrote:
> From: Yunjian Wang <wangyunjian@huawei.com>
> 
> Currently the driver doesn't drop a packet which can't be sent by tun
> (e.g bad packet). In this case, the driver will always process the
> same packet lead to the tx queue stuck.
> 
> To fix this issue:
> 1. in the case of persistent failure (e.g bad packet), the driver
>    can skip this descriptor by ignoring the error.
> 2. in the case of transient failure (e.g -ENOBUFS, -EAGAIN and -ENOMEM),
>    the driver schedules the worker to try again.
> 
> Fixes: 3a4d5c94e959 ("vhost_net: a kernel-level virtio server")
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> Acked-by: Willem de Bruijn <willemb@google.com>
> ---
>  drivers/vhost/net.c | 16 ++++++++--------
>  1 file changed, 8 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index c8784dfafdd7..01558fb2c552 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -827,14 +827,13 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  				msg.msg_flags &= ~MSG_MORE;
>  		}
>  
> -		/* TODO: Check specific error and bomb out unless ENOBUFS? */
>  		err = sock->ops->sendmsg(sock, &msg, len);
> -		if (unlikely(err < 0)) {
> +		if (unlikely(err == -EAGAIN || err == -ENOMEM || err == -ENOBUFS)) {
>  			vhost_discard_vq_desc(vq, 1);
>  			vhost_net_enable_vq(net, vq);
>  			break;
>  		}


Hmm, there's the case of link being temporarily down (e.g. for
reconfigure), which IIRC returns EIO.

It's also probably a good idea to keep unlikely(err < 0) around
and then just regular err == -EAGAIN || err == -ENOMEM || err == -ENOBUFS
since that first test can be done faster.


> -		if (err != len)
> +		if (err >= 0 && err != len)
>  			pr_debug("Truncated TX packet: len %d != %zd\n",
>  				 err, len);
>  done:
> @@ -922,7 +921,6 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
>  			msg.msg_flags &= ~MSG_MORE;
>  		}
>  
> -		/* TODO: Check specific error and bomb out unless ENOBUFS? */
>  		err = sock->ops->sendmsg(sock, &msg, len);
>  		if (unlikely(err < 0)) {
>  			if (zcopy_used) {
> @@ -931,11 +929,13 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
>  				nvq->upend_idx = ((unsigned)nvq->upend_idx - 1)
>  					% UIO_MAXIOV;
>  			}
> -			vhost_discard_vq_desc(vq, 1);
> -			vhost_net_enable_vq(net, vq);
> -			break;
> +			if (err == -EAGAIN || err == -ENOMEM || err == -ENOBUFS) {


same here

> +				vhost_discard_vq_desc(vq, 1);
> +				vhost_net_enable_vq(net, vq);
> +				break;
> +			}
>  		}
> -		if (err != len)
> +		if (err >= 0 && err != len)
>  			pr_debug("Truncated TX packet: "
>  				 " len %d != %zd\n", err, len);
>  		if (!zcopy_used)
> -- 
> 2.23.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
