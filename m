Return-Path: <SRS0=QXZB=GC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB55C433DB
	for <virtualization@archiver.kernel.org>; Wed, 30 Dec 2020 20:56:13 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A3A9F206F6
	for <virtualization@archiver.kernel.org>; Wed, 30 Dec 2020 20:56:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A3A9F206F6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 733BB86B02;
	Wed, 30 Dec 2020 20:56:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8jFvHRWyWRal; Wed, 30 Dec 2020 20:56:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id B7C1586B06;
	Wed, 30 Dec 2020 20:56:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9F08DC088B;
	Wed, 30 Dec 2020 20:56:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A9DFC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 20:56:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C095A20366
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 20:56:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DctSCSUGhn09
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 20:56:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id EBEF520110
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 20:56:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609361766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=iFlZtz74xmTz/ktSlcFt8gctOusgNHUwrHkjcpUKl9Y=;
 b=IAFjOFKTzYuL0nPHFkOlMlBDN55g2RIpd3qxmTvzWZZXtDB1s4KAdcJ1pP69CE1fY1ctNx
 q6q+rFDLhV0D0P+D0cdK7aAfS6ZDGTfEx5myFI3Rvwv3taNkdSf0mY6qYAfczEItszerjN
 rJGJ2HmdOUvyJh0roeq78fGXVvdk1hA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-35-2TwY-rUdO5eMABPblc00Ag-1; Wed, 30 Dec 2020 15:56:04 -0500
X-MC-Unique: 2TwY-rUdO5eMABPblc00Ag-1
Received: by mail-wr1-f70.google.com with SMTP id y5so9294792wrs.15
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 12:56:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=iFlZtz74xmTz/ktSlcFt8gctOusgNHUwrHkjcpUKl9Y=;
 b=LV9lWyZ7HtTNlzUw35mOn+B6/8nFqjtYyUQkEn+PAGRyzwsUIs6q5Qsh3VeHdz5l/N
 HhKcxx/gISqXHTN8Qk0UK8BBZeLcN3CYy8y6Bf9oD+g8xxsDAXv4C7EzFpUdROuY5PsO
 hOgvw+HqO87Dd0WQSce3ygF4g6i8Zm5f/17Ng7w83HEgQx1vRc1ueo+mWSlxhZ12xGzK
 cTRY/iaSuU8ZmQpbsf1SOhk+MigAB7c2o0xAKHNhpRigLbk5nmZvIOCIXsEgIK/nevYV
 Oaj19Nmr+O1xuXu6r13SEnM1ypRGkEgQRnrVaQfW+idOhjlzTqsWOZ3p/drmT6cNeQLw
 FqSA==
X-Gm-Message-State: AOAM533Ha51B8MDLCCIObC7UFkBU6ygw9FfAt16WQtrOIVeektVlIEy/
 etea8qRMbTUcjT8TLSVqYhflzIb4NISO0usXpXvTt3fBcTgWlmxKv95iwiEWSx1NnZ80NQnulzz
 WDuT7WVcbG44yUunsEsQ5PWkB0+PkCdjttzKNYQskNA==
X-Received: by 2002:a7b:c319:: with SMTP id k25mr9111286wmj.142.1609361763378; 
 Wed, 30 Dec 2020 12:56:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyB48GLoSLLN8yYRD+dbDksR16DwdSfBGhZ/WcRSvjWjsNVj0mfX0SAKJH/DWv1GhEP0T8aRA==
X-Received: by 2002:a7b:c319:: with SMTP id k25mr9111280wmj.142.1609361763191; 
 Wed, 30 Dec 2020 12:56:03 -0800 (PST)
Received: from redhat.com (bzq-79-178-32-166.red.bezeqint.net. [79.178.32.166])
 by smtp.gmail.com with ESMTPSA id i9sm64608892wrs.70.2020.12.30.12.55.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Dec 2020 12:56:02 -0800 (PST)
Date: Wed, 30 Dec 2020 15:55:58 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [PATCH 2/3] vhost/vsock: support for SOCK_SEQPACKET socket.
Message-ID: <20201230155410-mutt-send-email-mst@kernel.org>
References: <20201229110634.275024-1-arseny.krasnov@kaspersky.com>
MIME-Version: 1.0
In-Reply-To: <20201229110634.275024-1-arseny.krasnov@kaspersky.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>
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

On Tue, Dec 29, 2020 at 02:06:33PM +0300, Arseny Krasnov wrote:
> 	This patch simply adds transport ops and removes
> ignore of non-stream type of packets.
> 
> Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>

How is this supposed to work? virtio vsock at the moment
has byte level end to end credit accounting at the
protocol level. I suspect some protocol changes involving
more than this tweak would
be needed to properly support anything that isn't a stream.

> ---
>  drivers/vhost/vsock.c | 6 ++++--
>  1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> index a483cec31d5c..4a36ef1c52d0 100644
> --- a/drivers/vhost/vsock.c
> +++ b/drivers/vhost/vsock.c
> @@ -346,8 +346,7 @@ vhost_vsock_alloc_pkt(struct vhost_virtqueue *vq,
>  		return NULL;
>  	}
>  
> -	if (le16_to_cpu(pkt->hdr.type) == VIRTIO_VSOCK_TYPE_STREAM)
> -		pkt->len = le32_to_cpu(pkt->hdr.len);
> +	pkt->len = le32_to_cpu(pkt->hdr.len);
>  
>  	/* No payload */
>  	if (!pkt->len)
> @@ -416,6 +415,9 @@ static struct virtio_transport vhost_transport = {
>  		.stream_is_active         = virtio_transport_stream_is_active,
>  		.stream_allow             = virtio_transport_stream_allow,
>  
> +		.seqpacket_seq_send_len	  = virtio_transport_seqpacket_seq_send_len,
> +		.seqpacket_seq_get_len	  = virtio_transport_seqpacket_seq_get_len,
> +
>  		.notify_poll_in           = virtio_transport_notify_poll_in,
>  		.notify_poll_out          = virtio_transport_notify_poll_out,
>  		.notify_recv_init         = virtio_transport_notify_recv_init,
> -- 
> 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
