Return-Path: <SRS0=2z8p=FU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30BEBC4361B
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 09:23:32 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 89AD0230FF
	for <virtualization@archiver.kernel.org>; Wed, 16 Dec 2020 09:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 89AD0230FF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A9C538690A;
	Wed, 16 Dec 2020 09:23:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9rbO1n6jpEfu; Wed, 16 Dec 2020 09:23:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7E1BE868FB;
	Wed, 16 Dec 2020 09:23:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5F17CC0893;
	Wed, 16 Dec 2020 09:23:28 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 42CACC013B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 09:23:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2517085E8A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 09:23:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dkdqA21_Z1nF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 09:23:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 34D7D85E7D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 09:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608110605;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=MUx4wa69PeOW8vAItriAUKANW50g23Sn/MtCvu68J3o=;
 b=BaNRE3CK7TD2dUTVSRu5ygKr0sPABr9D/B1VphzafVHncwBrwTI0QttttujlTI1W/ICV0y
 9UDWbmf+tEieAA0cGP+3/Z2P6T6SRQZe4038zhpB4nm+n2+dNlxh/eRsnMhKJPcFs++CcE
 RlubDQUofBcL/gibeHyTnvxn7wk7m9g=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-341-nEE2SmhWNkOEo8ej8HgdbA-1; Wed, 16 Dec 2020 04:23:21 -0500
X-MC-Unique: nEE2SmhWNkOEo8ej8HgdbA-1
Received: by mail-wr1-f71.google.com with SMTP id w9so7977742wrt.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Dec 2020 01:23:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=MUx4wa69PeOW8vAItriAUKANW50g23Sn/MtCvu68J3o=;
 b=PY+eAFBKnegMjiGSKBWrFZLCbtAv/ViZznX5NKwPIfTHGX8BcbBLmCGvDlWORifCMa
 TrGnnIyCTimQBpV4QTuec+LHTz9XbvwD4YJtqzvaHbz/v5Dg/v2E5/Z3CZSDuz3VWpNY
 JE6xuW9t0gqRNvaMuHGIp1rVnIH/tRo0ZM4r7SpksOYlCAne/ipoD4w1hr6ncbD9q9ny
 PcZD57Ahcpzy2ZFf8Y+ZzJWDH3LbOMzHqq81U0Su5eRfR5uOMrga0EI9ixud6Id+FE6d
 yjSmAlBTR7nYGSJpzsbwio75ZUsegsM9KWy6bCMHaDLvnnKBAMaCGgX0MWOwmJBURMli
 Pc1Q==
X-Gm-Message-State: AOAM531CcvjhcAAKXlL8/NajD+Xa+hrHhtBlgeK+W0z0N1mOHBAd97p1
 s0Bo2yWTf1TzsPrcSa3Kty/COLcernC+u3iHGwzdbD6fdQbTFiRuxN9CWsE1nZf+6flvn+ptgIl
 SKxSfumfqn6brcXls7Uew4pCirS3EKD9D+vTUDlZLOw==
X-Received: by 2002:a1c:6446:: with SMTP id y67mr2297978wmb.144.1608110600188; 
 Wed, 16 Dec 2020 01:23:20 -0800 (PST)
X-Google-Smtp-Source: ABdhPJygTHQ8GqT8mpW+0WKMBETjpkzHbjIExWECh+GMsL2oQNZX9gfDaNiLncaogJblgVV93AcnPQ==
X-Received: by 2002:a1c:6446:: with SMTP id y67mr2297955wmb.144.1608110599993; 
 Wed, 16 Dec 2020 01:23:19 -0800 (PST)
Received: from redhat.com (bzq-109-67-15-113.red.bezeqint.net. [109.67.15.113])
 by smtp.gmail.com with ESMTPSA id q17sm2178361wrr.53.2020.12.16.01.23.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 16 Dec 2020 01:23:19 -0800 (PST)
Date: Wed, 16 Dec 2020 04:23:16 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: wangyunjian <wangyunjian@huawei.com>
Subject: Re: [PATCH net v2 2/2] vhost_net: fix high cpu load when sendmsg fails
Message-ID: <20201216042027-mutt-send-email-mst@kernel.org>
References: <cover.1608065644.git.wangyunjian@huawei.com>
 <6b4c5fff8705dc4b5b6a25a45c50f36349350c73.1608065644.git.wangyunjian@huawei.com>
MIME-Version: 1.0
In-Reply-To: <6b4c5fff8705dc4b5b6a25a45c50f36349350c73.1608065644.git.wangyunjian@huawei.com>
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

On Wed, Dec 16, 2020 at 04:20:37PM +0800, wangyunjian wrote:
> From: Yunjian Wang <wangyunjian@huawei.com>
> 
> Currently we break the loop and wake up the vhost_worker when
> sendmsg fails. When the worker wakes up again, we'll meet the
> same error. This will cause high CPU load. To fix this issue,
> we can skip this description by ignoring the error. When we
> exceeds sndbuf, the return value of sendmsg is -EAGAIN. In
> the case we don't skip the description and don't drop packet.

Question: with this patch, what happens if sendmsg is interrupted by a signal?


> 
> Signed-off-by: Yunjian Wang <wangyunjian@huawei.com>
> ---
>  drivers/vhost/net.c | 21 +++++++++------------
>  1 file changed, 9 insertions(+), 12 deletions(-)
> 
> diff --git a/drivers/vhost/net.c b/drivers/vhost/net.c
> index c8784dfafdd7..3d33f3183abe 100644
> --- a/drivers/vhost/net.c
> +++ b/drivers/vhost/net.c
> @@ -827,16 +827,13 @@ static void handle_tx_copy(struct vhost_net *net, struct socket *sock)
>  				msg.msg_flags &= ~MSG_MORE;
>  		}
>  
> -		/* TODO: Check specific error and bomb out unless ENOBUFS? */
>  		err = sock->ops->sendmsg(sock, &msg, len);
> -		if (unlikely(err < 0)) {
> +		if (unlikely(err == -EAGAIN)) {
>  			vhost_discard_vq_desc(vq, 1);
>  			vhost_net_enable_vq(net, vq);
>  			break;
> -		}
> -		if (err != len)
> -			pr_debug("Truncated TX packet: len %d != %zd\n",
> -				 err, len);
> +		} else if (unlikely(err != len))
> +			vq_err(vq, "Fail to sending packets err : %d, len : %zd\n", err, len);
>  done:
>  		vq->heads[nvq->done_idx].id = cpu_to_vhost32(vq, head);
>  		vq->heads[nvq->done_idx].len = 0;
> @@ -922,7 +919,6 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
>  			msg.msg_flags &= ~MSG_MORE;
>  		}
>  
> -		/* TODO: Check specific error and bomb out unless ENOBUFS? */
>  		err = sock->ops->sendmsg(sock, &msg, len);
>  		if (unlikely(err < 0)) {
>  			if (zcopy_used) {
> @@ -931,13 +927,14 @@ static void handle_tx_zerocopy(struct vhost_net *net, struct socket *sock)
>  				nvq->upend_idx = ((unsigned)nvq->upend_idx - 1)
>  					% UIO_MAXIOV;
>  			}
> -			vhost_discard_vq_desc(vq, 1);
> -			vhost_net_enable_vq(net, vq);
> -			break;
> +			if (err == -EAGAIN) {
> +				vhost_discard_vq_desc(vq, 1);
> +				vhost_net_enable_vq(net, vq);
> +				break;
> +			}
>  		}
>  		if (err != len)
> -			pr_debug("Truncated TX packet: "
> -				 " len %d != %zd\n", err, len);
> +			vq_err(vq, "Fail to sending packets err : %d, len : %zd\n", err, len);

I'd rather make the pr_debug -> vq_err a separate change, with proper
commit log describing motivation.


>  		if (!zcopy_used)
>  			vhost_add_used_and_signal(&net->dev, vq, head, 0);
>  		else
> -- 
> 2.23.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
