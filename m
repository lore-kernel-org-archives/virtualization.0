Return-Path: <SRS0=FCrO=F7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01BA7C433DB
	for <virtualization@archiver.kernel.org>; Sun, 27 Dec 2020 11:21:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 91498206ED
	for <virtualization@archiver.kernel.org>; Sun, 27 Dec 2020 11:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 91498206ED
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3097686030;
	Sun, 27 Dec 2020 11:21:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R7c7lzXWF897; Sun, 27 Dec 2020 11:21:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3769D8601E;
	Sun, 27 Dec 2020 11:21:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10DF1C1787;
	Sun, 27 Dec 2020 11:21:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03360C0891
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 11:20:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DFCE4204E9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 11:20:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7mkWEnKm-TCC
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 11:20:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 2DDD9204E8
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 11:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609068057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=CVdBs2xrsrjmHICbemcVljFqnuHXxMjleLXoBb8vV18=;
 b=jSvl/bIKXHCDaT44zny+3yyV0hgnke5mos+3hdLKXZ1hFHDq4GiAArFnmj8+vLPlOBTSD/
 EZK15oNf1/xJJ+6MMlEPaQ+gLR8q9zMp6rQbsuD0QJZRn5NxuLttj30cqvl4RV+kLbKGhQ
 T+9gVz+2OzjUGCTFmqKnWugRM8nSxEQ=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-440-29Z_tCFLNeydi-0wmhcTpw-1; Sun, 27 Dec 2020 06:20:55 -0500
X-MC-Unique: 29Z_tCFLNeydi-0wmhcTpw-1
Received: by mail-wr1-f70.google.com with SMTP id r8so4956887wro.22
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Dec 2020 03:20:55 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=CVdBs2xrsrjmHICbemcVljFqnuHXxMjleLXoBb8vV18=;
 b=HJkflQw8Q/DvY3xM0K8IpMmoP0uRbOg53YB9RECAV/PxmxjG5qMWCUfVEYhve03YO3
 PCl8XB2GgXY40QKKuSp7EdibiL8s7JP44ZIZr3gXNCR2Cm2TIihW7EH0UEMfoumepbQH
 MrNXZLASuWasJ44lt5AyaW1x3Dl/gancoOCyn1ntB99RXfQXMV+ZA/W5ykxaRoo+bTfC
 DJynPfkL6YP1rlC+5uex8bUpMRVCy+IbfQwzRy46NBBp97UgIqyjT9Wj2lDsWAbuZLcg
 i37SSkDY2x/kFMZdVGwB55Ek2xDxkyFsCNqPdfXGjjaphAoOL11TQm2IhZKs6xDq29Rp
 ZRLA==
X-Gm-Message-State: AOAM5302tfF++EO2MrDeIqauCUw6swYhCbLHux0+hKNga3GPiHKvn13n
 LNRXi1WRpUEryPqPHmTWTUbI2ijYpKwzzqCm2tmu1VBeY6MOTWhuFCaEp/mXnUs4TsVjr6BYyuO
 daW4P0oGvk/cu3XgwBJUS/ymSgIp18Zik9vU7Ifq4ag==
X-Received: by 2002:a1c:b608:: with SMTP id g8mr16204742wmf.110.1609068054000; 
 Sun, 27 Dec 2020 03:20:54 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyUzl/++4UPXggZtiDjmqg147nueL0wrgEoGxCli7YzJPIkDWw1Vh9nmJu4PWjnGgqGQ5LTkg==
X-Received: by 2002:a1c:b608:: with SMTP id g8mr16204729wmf.110.1609068053804; 
 Sun, 27 Dec 2020 03:20:53 -0800 (PST)
Received: from redhat.com (bzq-79-178-32-166.red.bezeqint.net. [79.178.32.166])
 by smtp.gmail.com with ESMTPSA id q143sm15618150wme.28.2020.12.27.03.20.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Dec 2020 03:20:53 -0800 (PST)
Date: Sun, 27 Dec 2020 06:20:50 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: wangyunjian <wangyunjian@huawei.com>
Subject: Re: [PATCH net v5 2/2] vhost_net: fix tx queue stuck when sendmsg
 fails
Message-ID: <20201227061916-mutt-send-email-mst@kernel.org>
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

So not making progress on a bad packet has some advantages,
e.g. this is easier to debug.
When is it important to drop the packet and continue?


> To fix this issue:
> 1. in the case of persistent failure (e.g bad packet), the driver
>    can skip this descriptor by ignoring the error.
> 2. in the case of transient failure (e.g -ENOBUFS, -EAGAIN and -ENOMEM),
>    the driver schedules the worker to try again.
> 
> Fixes: 3a4d5c94e959 ("vhost_net: a kernel-level virtio server")

I'd just drop this tag, looks more like a feature than a bug ...


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
