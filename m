Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 596A7C05027
	for <virtualization@archiver.kernel.org>; Thu,  2 Feb 2023 17:26:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E231741CD6;
	Thu,  2 Feb 2023 17:26:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E231741CD6
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=NPRTwZXW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WJ6R-5ArzeSD; Thu,  2 Feb 2023 17:26:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2B2B341CD4;
	Thu,  2 Feb 2023 17:26:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2B2B341CD4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 089F7C0033;
	Thu,  2 Feb 2023 17:26:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 43B9EC002B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 17:26:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1EE6D41CD5
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 17:26:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1EE6D41CD5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kj9nFikUi42j
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 17:26:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3CC6241CD4
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3CC6241CD4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  2 Feb 2023 17:26:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1675358773;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6WKJ+xTBuqvHJA/DgjJYK9bFyVaTh4ihb15FuQHGdbU=;
 b=NPRTwZXW58S3YBbmdCqzMahGDswTvbD8uAAietX4kOcgjYpqr8cLfwnAd/udJpNSvyF64P
 M8Xj41uSTXRM3yEgr2uMk5ujWtMfc4Q2bVd1yMaleaaEFYyu6f1BeN8/k7K1UH8mJvNwnR
 70i31MzSH6J9pA1W+SjEMsG5F7tyb2A=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-266-Xar-TO6iP06Mw7NVF2nsiQ-1; Thu, 02 Feb 2023 12:26:07 -0500
X-MC-Unique: Xar-TO6iP06Mw7NVF2nsiQ-1
Received: by mail-wr1-f72.google.com with SMTP id
 o24-20020a5d58d8000000b002bfe173775aso359942wrf.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 02 Feb 2023 09:26:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6WKJ+xTBuqvHJA/DgjJYK9bFyVaTh4ihb15FuQHGdbU=;
 b=ywgbR3YkYs/FMEvhHVpg9YHW7pnR1D0CWn2Xy+RRXZckpHRr/v56wY5Ni5umaerkvV
 eO/Sg6yk3fspWLP5rvfOGDudfg+4w75QnZR0e7I2awfKLDNtWrIJfn4WlxyfiD5YcPIV
 xN+RhMOfEzzpjdF5UYLhOSUhf6peXOYz0tlR33/74/dAr7XoW+MgkU0bGoW5Qr94lz7P
 LCH2q/MiD6lTiHHyevTgYKUYHVhSK3WU5/8Z42t+NrLTs9YWWfCa3V+Ym9LPD5GUezay
 cFlaVrC2Lwx9aMWMZw/qee9O+/Fepy8ooR08mYwnaj6MV9xk3D6eEOujmGotBHZFQiru
 K0IA==
X-Gm-Message-State: AO0yUKXO5Sq0e+NHMXaS/WvjMW9FuITtMHh5C2SrItpwNNmR62Nq3BIo
 Y3ta3A5XfGlvHKIy1g8YhMqQztzKqRxfW2EduoNKf9ZQFSaCRbLnuKrvcmX99/TFiI87n6g7n95
 +i7hfOKfoNdpYHhYH0X7zmvPRQT9THxV/T1TSF8cvvQ==
X-Received: by 2002:a05:600c:1e0b:b0:3da:1e35:dfec with SMTP id
 ay11-20020a05600c1e0b00b003da1e35dfecmr6910492wmb.4.1675358765642; 
 Thu, 02 Feb 2023 09:26:05 -0800 (PST)
X-Google-Smtp-Source: AK7set/z5RmItaflCIcRIT8kR78dHQV5cx7Dg457PMDawnbySjhpBnXC5/Fk1nq6JbSLeIjJqL5pxQ==
X-Received: by 2002:a05:600c:1e0b:b0:3da:1e35:dfec with SMTP id
 ay11-20020a05600c1e0b00b003da1e35dfecmr6910475wmb.4.1675358765455; 
 Thu, 02 Feb 2023 09:26:05 -0800 (PST)
Received: from redhat.com ([2.52.156.122]) by smtp.gmail.com with ESMTPSA id
 i10-20020a05600c354a00b003dd1c15e7fcsm6365187wmq.15.2023.02.02.09.26.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 02 Feb 2023 09:26:04 -0800 (PST)
Date: Thu, 2 Feb 2023 12:25:59 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH 24/33] virtio_net: xsk: stop disable tx napi
Message-ID: <20230202122445-mutt-send-email-mst@kernel.org>
References: <20230202110058.130695-1-xuanzhuo@linux.alibaba.com>
 <20230202110058.130695-25-xuanzhuo@linux.alibaba.com>
MIME-Version: 1.0
In-Reply-To: <20230202110058.130695-25-xuanzhuo@linux.alibaba.com>
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

On Thu, Feb 02, 2023 at 07:00:49PM +0800, Xuan Zhuo wrote:
> Since xsk's TX queue is consumed by TX NAPI, if sq is bound to xsk, then
> we must stop tx napi from being disabled.
> 
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio/main.c | 9 ++++++++-
>  1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/net/virtio/main.c b/drivers/net/virtio/main.c
> index ed79e750bc6c..232cf151abff 100644
> --- a/drivers/net/virtio/main.c
> +++ b/drivers/net/virtio/main.c
> @@ -2728,8 +2728,15 @@ static int virtnet_set_coalesce(struct net_device *dev,
>  		return ret;
>  
>  	if (update_napi) {
> -		for (i = 0; i < vi->max_queue_pairs; i++)
> +		for (i = 0; i < vi->max_queue_pairs; i++) {
> +			/* xsk xmit depend on the tx napi. So if xsk is active,

depends.

> +			 * prevent modifications to tx napi.
> +			 */
> +			if (rtnl_dereference(vi->sq[i].xsk.pool))
> +				continue;
> +
>  			vi->sq[i].napi.weight = napi_weight;

I don't get it.
changing napi weight does not work then.
why is this ok?


> +		}
>  	}
>  
>  	return ret;
> -- 
> 2.32.0.3.g01195cf9f

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
