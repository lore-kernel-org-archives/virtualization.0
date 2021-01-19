Return-Path: <SRS0=ogTN=GW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_RED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE6B8C433E0
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 09:55:40 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 40FEA20771
	for <virtualization@archiver.kernel.org>; Tue, 19 Jan 2021 09:55:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 40FEA20771
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C9746861A2;
	Tue, 19 Jan 2021 09:55:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MLvKl568j48J; Tue, 19 Jan 2021 09:55:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1A6CB85F29;
	Tue, 19 Jan 2021 09:55:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EBF40C088B;
	Tue, 19 Jan 2021 09:55:38 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A504BC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 09:55:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 938F0845D4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 09:55:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mw7ssreOijSg
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 09:55:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E35FC8204B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 09:55:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611050135;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=e5k+Bd6G3jBkGotE4e2JJUwLMC9njtVsJGU8frM5Op4=;
 b=RUcHZWRKR6Vr4mH63EmjpZV+ni/UrneJ5ibeTU+t0ml0c4c5PfSJbLNq1aXXgHUwBySslV
 azX8ySrKiCuh+3/HnY2OndMuQ/o8OKVLW8p0BH2ZQvJrp9tyr2NN9RXG1JdViC6SjNKhm9
 8s9PbBVVF6yZqhwPNQae4Xa9yp2suFo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-538-2UT3-eV8OlSLxk9Rj3bf_A-1; Tue, 19 Jan 2021 04:55:32 -0500
X-MC-Unique: 2UT3-eV8OlSLxk9Rj3bf_A-1
Received: by mail-wm1-f72.google.com with SMTP id s24so3209237wmj.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Jan 2021 01:55:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=e5k+Bd6G3jBkGotE4e2JJUwLMC9njtVsJGU8frM5Op4=;
 b=O2Zl/K+sxA9CugBgoTu0PQjqDaVYHRMibufLG7HsobFyYzkJrbE03GjEZR66jDm+/R
 7CViUpFJALQnBOOnQzhwQ0HXThhzjhmoOpY/6rpgUB04kG4lPLW9TnOxpDbGL2E32EXL
 X68HcLbBaba5qXGQ3rKrh/xbEO0GtjgjVRVHEuIvv5mI3W3W1DbaD8RaQTSTEolukles
 9YSkABeEsbwwHLP5r2SU8VFZXTWNvoy1dfSxBs+ZcvcfWBrp08XdsJ3uHuvgWf38xPBU
 BRW6wfMjirXThWScLvRytXUPR4BCJj30hJgGKCnokj5OX2H+6NdiMN0fdIQpP6oO8Bae
 clDQ==
X-Gm-Message-State: AOAM533idOfb6qwQY6cLL6OJCNkXTphbkGdxrBgBlGIhEQ15YeIRIYpl
 4dLtwxyy0N8RFgc8TmDFYvs8WC+DpRGyfpKw0+oJtOZgh/aUue0bdPXvN5vBaPRgalv1wkKIYuX
 JmYUnZwOh0ICmCHX3oGx3R/A9lnuN4QPb5FhONNZPMA==
X-Received: by 2002:a05:600c:21cb:: with SMTP id
 x11mr3323285wmj.29.1611050131102; 
 Tue, 19 Jan 2021 01:55:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxKND6Zca35zFaKj21qvuworTdTNrBW2UVMdAEyN6/1tBZVNe5H5LJNjKLvAzdn+brbuTjaAw==
X-Received: by 2002:a05:600c:21cb:: with SMTP id
 x11mr3323275wmj.29.1611050130907; 
 Tue, 19 Jan 2021 01:55:30 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
 by smtp.gmail.com with ESMTPSA id h14sm34416111wrx.37.2021.01.19.01.55.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 19 Jan 2021 01:55:30 -0800 (PST)
Date: Tue, 19 Jan 2021 04:55:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: wangyunjian <wangyunjian@huawei.com>
Subject: Re: [PATCH net-next v7] vhost_net: avoid tx queue stuck when sendmsg
 fails
Message-ID: <20210119045414-mutt-send-email-mst@kernel.org>
References: <1610685980-38608-1-git-send-email-wangyunjian@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1610685980-38608-1-git-send-email-wangyunjian@huawei.com>
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

On Fri, Jan 15, 2021 at 12:46:20PM +0800, wangyunjian wrote:
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
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>

Acked-by: Michael S. Tsirkin <mst@redhat.com>

> ---
> v7:
>    * code rebase
> v6:
>    * update code styles and commit log
> ---
>  drivers/vhost/net.c | 26 ++++++++++++++------------
>  1 file changed, 14 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 3b744031ec8f..df82b124170e 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -828,14 +828,15 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  				msg.msg_flags &= ~MSG_MORE;
>  		}
>  
> -		/* TODO: Check specific error and bomb out unless ENOBUFS? */
>  		err = sock->ops->sendmsg(sock, &msg, len);
>  		if (unlikely(err < 0)) {
> -			vhost_discard_vq_desc(vq, 1);
> -			vhost_net_enable_vq(net, vq);
> -			break;
> -		}
> -		if (err != len)
> +			if (err == -EAGAIN || err == -ENOMEM || err == -ENOBUFS) {
> +				vhost_discard_vq_desc(vq, 1);
> +				vhost_net_enable_vq(net, vq);
> +				break;
> +			}
> +			pr_debug("Fail to send packet: err %d", err);
> +		} else if (unlikely(err != len))
>  			pr_debug("Truncated TX packet: len %d != %zd\n",
>  				 err, len);
>  done:
> @@ -924,7 +925,6 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
>  			msg.msg_flags &= ~MSG_MORE;
>  		}
>  
> -		/* TODO: Check specific error and bomb out unless ENOBUFS? */
>  		err = sock->ops->sendmsg(sock, &msg, len);
>  		if (unlikely(err < 0)) {
>  			if (zcopy_used) {
> @@ -933,11 +933,13 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
>  				nvq->upend_idx = ((unsigned)nvq->upend_idx - 1)
>  					% UIO_MAXIOV;
>  			}
> -			vhost_discard_vq_desc(vq, 1);
> -			vhost_net_enable_vq(net, vq);
> -			break;
> -		}
> -		if (err != len)
> +			if (err == -EAGAIN || err == -ENOMEM || err == -ENOBUFS) {
> +				vhost_discard_vq_desc(vq, 1);
> +				vhost_net_enable_vq(net, vq);
> +				break;
> +			}
> +			pr_debug("Fail to send packet: err %d", err);
> +		} else if (unlikely(err != len))
>  			pr_debug("Truncated TX packet: "
>  				 " len %d != %zd\n", err, len);
>  		if (!zcopy_used)
> -- 
> 2.23.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
