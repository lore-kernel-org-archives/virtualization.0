Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0480C43460
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 05:06:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 44B48613AB
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 05:06:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 44B48613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9E1140654;
	Tue, 13 Apr 2021 05:06:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0Xk46ROHCrcG; Tue, 13 Apr 2021 05:06:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 5C2BF40657;
	Tue, 13 Apr 2021 05:06:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3158AC000B;
	Tue, 13 Apr 2021 05:06:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AD85EC000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 05:06:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 88C57400C5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 05:06:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l6mRuHQqIXx0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 05:06:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E2A05400C1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 05:06:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618290376;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=8yk3x/SMpfREk/zOV4sftMFvMQg+J6weHzyZPLn+Zb8=;
 b=K4JULXpb7/c05zM1DTZCwPEiCb4iLsdSQmOH+OJF+kcpHcxKcJk4MNtxtt70llw3unHjIr
 0MebWwRi9ouD3T9S7EhlSwTHuf1+049e30zW+7EZNTkEw5MN22f5o+R3Jga5237jBx0vZK
 kR5MueRx6UdscEBwV1t43ns8Blwgg3o=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-508-zMsmErt2O0GRVKznct3t7g-1; Tue, 13 Apr 2021 01:06:14 -0400
X-MC-Unique: zMsmErt2O0GRVKznct3t7g-1
Received: by mail-wr1-f72.google.com with SMTP id s10so286434wre.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 22:06:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=8yk3x/SMpfREk/zOV4sftMFvMQg+J6weHzyZPLn+Zb8=;
 b=WG8MOUZy+DXKf4Yvj6QU/4rwFz5wacpAwbQ4ctXX5no3h88ZIOvdkQMExp/0dBiYEf
 L+9o9wxxWw3yh6wqsbdD5SiITeJ22P2KW0BZ5yTHuSfYC6Wn3wC6MJ/i2jOp5g0S1SlC
 5CI8nWYpm8eEsslc0AHMkDI3Gv2cS3SRoPUOfXRLjOAjz0HB2bi/Rk4TcrPintu1rBMS
 LMrq6hL7zTG3C/xywO75v6w7T3Fe+MBOW1oVi/lmB1QTnAsmm4XQQE1uigJkMUJH7GFd
 ZDNbnag4mFng4dLkSsrDlbLFmXW9L+9w+qz+beXhQpBdb7lzuUlPuxR64gHhDqU8nG8q
 CJMg==
X-Gm-Message-State: AOAM533d89PiSchtH0QpHdSxj4u9OJjeyJ8kSVkKYQHk6AaIRQoynFGg
 t8/5AmONCjSutA1H3lYP/1AMKEN2isqV6r8LA+YN121K+PjglnkHB/H48GSaZhOjlkqukDMGzd+
 uouUJew7ZdLtqFZxfe47xXx6+OWqsrkhZuMnq31Y96g==
X-Received: by 2002:a7b:cdf7:: with SMTP id p23mr2227286wmj.26.1618290373625; 
 Mon, 12 Apr 2021 22:06:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxraaCqJzAsUGqK1x4ZfxYE88R4+PkRQIo0V4mGnAEtSy7W9XIwo9Os5I+suQUauNsjM9ku5Q==
X-Received: by 2002:a7b:cdf7:: with SMTP id p23mr2227274wmj.26.1618290373493; 
 Mon, 12 Apr 2021 22:06:13 -0700 (PDT)
Received: from redhat.com ([2a10:8006:2281:0:1994:c627:9eac:1825])
 by smtp.gmail.com with ESMTPSA id r2sm4909962wrt.79.2021.04.12.22.06.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Apr 2021 22:06:13 -0700 (PDT)
Date: Tue, 13 Apr 2021 01:06:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Subject: Re: [PATCH net-next v3 5/5] virtio-net: keep tx interrupts disabled
 unless kick
Message-ID: <20210413010354-mutt-send-email-mst@kernel.org>
References: <20170424174930.82623-1-willemdebruijn.kernel@gmail.com>
 <20170424174930.82623-6-willemdebruijn.kernel@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20170424174930.82623-6-willemdebruijn.kernel@gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Willem de Bruijn <willemb@google.com>, netdev@vger.kernel.org,
 davem@davemloft.net, virtualization@lists.linux-foundation.org
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

On Mon, Apr 24, 2017 at 01:49:30PM -0400, Willem de Bruijn wrote:
> From: Willem de Bruijn <willemb@google.com>
> 
> Tx napi mode increases the rate of transmit interrupts. Suppress some
> by masking interrupts while more packets are expected. The interrupts
> will be reenabled before the last packet is sent.
> 
> This optimization reduces the througput drop with tx napi for
> unidirectional flows such as UDP_STREAM that do not benefit from
> cleaning tx completions in the the receive napi handler.
> 
> Signed-off-by: Willem de Bruijn <willemb@google.com>
> ---
>  drivers/net/virtio_net.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 9dd978f34c1f..003143835766 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -1200,6 +1200,9 @@ static netdev_tx_t start_xmit(struct sk_buff *skb, struct net_device *dev)
>  	/* Free up any pending old buffers before queueing new ones. */
>  	free_old_xmit_skbs(sq);
>  
> +	if (use_napi && kick)
> +		virtqueue_enable_cb_delayed(sq->vq);
> +
>  	/* timestamp packet in software */
>  	skb_tx_timestamp(skb);


I have been poking at this code today and I noticed that is
actually does enable cb where the commit log says masking interrupts.
I think the reason is that with even index previously disable cb
actually did nothing while virtqueue_enable_cb_delayed pushed
the event index out some more.
And this likely explains why it does not work well for packed,
where virtqueue_enable_cb_delayed is same as virtqueue_enable_cb.

Right? Or did I miss something?

> -- 
> 2.12.2.816.g2cccc81164-goog

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
