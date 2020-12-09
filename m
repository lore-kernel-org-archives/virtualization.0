Return-Path: <SRS0=MC01=FN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CF44C433FE
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 12:50:25 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A290C238A0
	for <virtualization@archiver.kernel.org>; Wed,  9 Dec 2020 12:50:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A290C238A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id E8C532E243;
	Wed,  9 Dec 2020 12:50:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id emdy0NR1+3CH; Wed,  9 Dec 2020 12:50:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id CB8FA20349;
	Wed,  9 Dec 2020 12:50:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA14EC0FA7;
	Wed,  9 Dec 2020 12:50:22 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 02640C013B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 12:50:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D237F87808
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 12:50:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id aeTC7oKRuE8W
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 12:50:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 9E77C8752C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Dec 2020 12:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1607518212;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=3rk0ejDD/QdmyhXmhnACbWCnOfZlWDy18TogCs6fwJc=;
 b=Hbslh6lPooTH8TpeGYuVN+JbIxZhMEIyitLoQmtnDUKL0ivM/TGJApR1OQxEGxETrSrX2q
 xE8Gz0IQwXMIlspE7krtOB9j/h6NXRs175NHZbKCnngEyevAcU1zdJIMI7H6zuo+pmEyp6
 o5tjY1FHxuCBB7s/Qz1+qHAOKsldfgY=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-561-PmOamTrIMgGgFVS3t8_VHg-1; Wed, 09 Dec 2020 07:50:10 -0500
X-MC-Unique: PmOamTrIMgGgFVS3t8_VHg-1
Received: by mail-wm1-f71.google.com with SMTP id k128so520870wme.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Dec 2020 04:50:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=3rk0ejDD/QdmyhXmhnACbWCnOfZlWDy18TogCs6fwJc=;
 b=W/IQN7ZmIAmh41xpsJIXXKt9pusP1M3Nz7cG+lkCsfOWYJBT3bXugIHvcmJYaiHe/U
 haNigL+mKFDy4iyiCHvinxYiEtJ6goK87d62sESqUVdV7qZ7lKgbg0CKCdTkizf2wnlI
 j+j4V96vSdJpH3YikIU+16QogenCUOTaFoiaOevQzOJQPEki1AhNztTDMNh/AQbtpr/K
 1LmSH4mXXY8O4YqFJbBgtCETBI/1tNE3P9MbUx7gYsn04Dk8s6+L3dRdRoSDqN1Inu0R
 8ipCDZZI7toUYPFGmfJxD9a01ru+zS2DURcwliH89nGkSLHfslTdB9SE7aWYux9e9nZK
 0/DQ==
X-Gm-Message-State: AOAM53090rQ4805TV2lHLYYxtegPyCEn93zEOF/iDpRkvmOYIq3LVUrA
 XbuOx0dVk7mUO/hyYYaSEUMHVlBLMb4swJ3TjH/sUDLWkatJzXyMX6LdimurpvrKv4IVDof4pI2
 FnTSe7RtMlRJ3cNWO88rjh1XP7nEjs6bJlLW6SAj7iw==
X-Received: by 2002:a5d:4746:: with SMTP id o6mr2458197wrs.324.1607518209746; 
 Wed, 09 Dec 2020 04:50:09 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyt/Xq9MGGEWkdqnz18kbdsDt/3I1ptobtgQHQhceGWRK01mdjNxG6qe9f5EodsVxgUOcJZGg==
X-Received: by 2002:a5d:4746:: with SMTP id o6mr2458177wrs.324.1607518209549; 
 Wed, 09 Dec 2020 04:50:09 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
 by smtp.gmail.com with ESMTPSA id p19sm3986052wrg.18.2020.12.09.04.49.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 09 Dec 2020 04:50:08 -0800 (PST)
Date: Wed, 9 Dec 2020 07:49:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: wangyunjian <wangyunjian@huawei.com>
Subject: Re: [PATCH net] vhost_net: fix high cpu load when sendmsg fails
Message-ID: <20201209074832-mutt-send-email-mst@kernel.org>
References: <1607514504-20956-1-git-send-email-wangyunjian@huawei.com>
MIME-Version: 1.0
In-Reply-To: <1607514504-20956-1-git-send-email-wangyunjian@huawei.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: netdev@vger.kernel.org, jerry.lilijun@huawei.com,
 virtualization@lists.linux-foundation.org, chenchanghu@huawei.com,
 xudingke@huawei.com
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

On Wed, Dec 09, 2020 at 07:48:24PM +0800, wangyunjian wrote:
> From: Yunjian Wang <wangyunjian@huawei.com>
> 
> Currently we break the loop and wake up the vhost_worker when
> sendmsg fails. When the worker wakes up again, we'll meet the
> same error. This will cause high CPU load. To fix this issue,
> we can skip this description by ignoring the error.
> 
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---
>  drivers/vhost/net.c | 24 +++++-------------------
>  1 file changed, 5 insertions(+), 19 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index 531a00d703cd..ac950b1120f5 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -829,14 +829,8 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  
>  		/* TODO: Check specific error and bomb out unless ENOBUFS? */
>  		err = sock->ops->sendmsg(sock, &msg, len);
> -		if (unlikely(err < 0)) {
> -			vhost_discard_vq_desc(vq, 1);
> -			vhost_net_enable_vq(net, vq);
> -			break;
> -		}
> -		if (err != len)
> -			pr_debug("Truncated TX packet: len %d != %zd\n",
> -				 err, len);
> +		if (unlikely(err < 0 || err != len))
> +			vq_err(vq, "Fail to sending packets err : %d, len : %zd\n", err, len);
>  done:
>  		vq->heads[nvq->done_idx].id = cpu_to_vhost32(vq, head);
>  		vq->heads[nvq->done_idx].len = 0;

One of the reasons for sendmsg to fail is ENOBUFS.
In that case for sure we don't want to drop packet.
There could be other transient errors.
Which error did you encounter, specifically?

> @@ -925,19 +919,11 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
>  
>  		/* TODO: Check specific error and bomb out unless ENOBUFS? */
>  		err = sock->ops->sendmsg(sock, &msg, len);
> -		if (unlikely(err < 0)) {
> -			if (zcopy_used) {
> +		if (unlikely(err < 0 || err != len)) {
> +			if (zcopy_used && err < 0)
>  				vhost_net_ubuf_put(ubufs);
> -				nvq->upend_idx = ((unsigned)nvq->upend_idx - 1)
> -					% UIO_MAXIOV;
> -			}
> -			vhost_discard_vq_desc(vq, 1);
> -			vhost_net_enable_vq(net, vq);
> -			break;
> +			vq_err(vq, "Fail to sending packets err : %d, len : %zd\n", err, len);
>  		}
> -		if (err != len)
> -			pr_debug("Truncated TX packet: "
> -				 " len %d != %zd\n", err, len);
>  		if (!zcopy_used)
>  			vhost_add_used_and_signal(&net->dev, vq, head, 0);
>  		else
> -- 
> 2.23.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
