Return-Path: <SRS0=QXZB=GC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82FE0C433DB
	for <virtualization@archiver.kernel.org>; Wed, 30 Dec 2020 20:58:19 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17DC0206D7
	for <virtualization@archiver.kernel.org>; Wed, 30 Dec 2020 20:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17DC0206D7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id B0D3A86B12;
	Wed, 30 Dec 2020 20:58:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y4UPQfvcK3+K; Wed, 30 Dec 2020 20:58:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 335F586B06;
	Wed, 30 Dec 2020 20:58:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15206C088B;
	Wed, 30 Dec 2020 20:58:18 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 84B33C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 20:58:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 72E5886B0F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 20:58:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l62HJ73fJ8UP
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 20:58:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7940586B06
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 20:58:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609361894;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=lDaf9gK/5CMnrHmaEEdNBnavCV6ONasVpqtwDHwq9uQ=;
 b=SEz4riUpY0XFouR1UUBnQISOrewKN0lqd6RBx9IXkyLBiMMBEKYGxY6vHWW/20+idShTDr
 iN5Tu5rstwvQ135NSbZYJquzixcYAJ2XjXeRORE4sufQZZAJ+OQYvMv3FDApZfKESdVE0m
 Y036NZ1PAbkg75jNO+sV98gki4ve1bs=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-375-6T9o7TLcP9e7675AVpRT3A-1; Wed, 30 Dec 2020 15:58:12 -0500
X-MC-Unique: 6T9o7TLcP9e7675AVpRT3A-1
Received: by mail-wm1-f69.google.com with SMTP id h21so2910645wmq.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 30 Dec 2020 12:58:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=lDaf9gK/5CMnrHmaEEdNBnavCV6ONasVpqtwDHwq9uQ=;
 b=fcsLvXWphgMtRrPf6wqb7mpqc/eQpjISETiwD4pXpKVHdTdCYkwQZBwfmANkMAF6FL
 Dp2lOrFa451gR/nnWm93W4JLuVjk8PIsjvj+H4BWskM89Dzegj9jfho/D5ym1eSZuFg9
 6qmw5FioUaRqxpH9EXdZlrUL0ENmLx7YALeyYIL06rhZJM+ir9WdQawnLi8V7mouB7ER
 fhuw0Bp7FoZCsHG3+o3GSGHOsMjP1pVTtOkfdZcBoGRW6hYgcnSf/fzIa/9AAw+b6cpI
 43JhK0dCGk0dYjgobsye9H6rWMHa9Zmae1GbLhia2kwlaI+rGfifYeFogB24uNyUyeTY
 gJmw==
X-Gm-Message-State: AOAM531R8DuqaOyjvkjnTSelkroZ4tySsyzcjDu4pqesHGFBAMntoEAi
 YqJUOBlcdHlcQ3TFX8UjkLgkiVypiTOC7YQjzNAs+3ENcmwJLEl53NfBYPKdEjjXRbrlcbWmHpy
 pw/P1ytCrAs/Pe/m3anxVQdyyoRmcbGv5RWbgT5kvdA==
X-Received: by 2002:a1c:5447:: with SMTP id p7mr9088160wmi.116.1609361891274; 
 Wed, 30 Dec 2020 12:58:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz4bdqLukNRVhkbPZzhHtiaz3QtqIPXIm1HllomjylrEHnRN3Uj4rvTqH8/DqgtuwFNl8qVpA==
X-Received: by 2002:a1c:5447:: with SMTP id p7mr9088150wmi.116.1609361891091; 
 Wed, 30 Dec 2020 12:58:11 -0800 (PST)
Received: from redhat.com (bzq-79-178-32-166.red.bezeqint.net. [79.178.32.166])
 by smtp.gmail.com with ESMTPSA id s12sm8405138wmh.29.2020.12.30.12.58.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Dec 2020 12:58:10 -0800 (PST)
Date: Wed, 30 Dec 2020 15:58:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Arseny Krasnov <arseny.krasnov@kaspersky.com>
Subject: Re: [PATCH 2/3] vhost/vsock: support for SOCK_SEQPACKET socket.
Message-ID: <20201230155742-mutt-send-email-mst@kernel.org>
References: <20201229110634.275024-1-arseny.krasnov@kaspersky.com>
 <20201230155410-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20201230155410-mutt-send-email-mst@kernel.org>
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

On Wed, Dec 30, 2020 at 03:56:03PM -0500, Michael S. Tsirkin wrote:
> On Tue, Dec 29, 2020 at 02:06:33PM +0300, Arseny Krasnov wrote:
> > 	This patch simply adds transport ops and removes
> > ignore of non-stream type of packets.
> > 
> > Signed-off-by: Arseny Krasnov <arseny.krasnov@kaspersky.com>
> 
> How is this supposed to work? virtio vsock at the moment
> has byte level end to end credit accounting at the
> protocol level. I suspect some protocol changes involving
> more than this tweak would
> be needed to properly support anything that isn't a stream.


oh this was not threaded correctly so I did not see rest of
patches. ignore this pls will respond there.

> > ---
> >  drivers/vhost/vsock.c | 6 ++++--
> >  1 file changed, 4 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/vhost/vsock.c b/drivers/vhost/vsock.c
> > index a483cec31d5c..4a36ef1c52d0 100644
> > --- a/drivers/vhost/vsock.c
> > +++ b/drivers/vhost/vsock.c
> > @@ -346,8 +346,7 @@ vhost_vsock_alloc_pkt(struct vhost_virtqueue *vq,
> >  		return NULL;
> >  	}
> >  
> > -	if (le16_to_cpu(pkt->hdr.type) == VIRTIO_VSOCK_TYPE_STREAM)
> > -		pkt->len = le32_to_cpu(pkt->hdr.len);
> > +	pkt->len = le32_to_cpu(pkt->hdr.len);
> >  
> >  	/* No payload */
> >  	if (!pkt->len)
> > @@ -416,6 +415,9 @@ static struct virtio_transport vhost_transport = {
> >  		.stream_is_active         = virtio_transport_stream_is_active,
> >  		.stream_allow             = virtio_transport_stream_allow,
> >  
> > +		.seqpacket_seq_send_len	  = virtio_transport_seqpacket_seq_send_len,
> > +		.seqpacket_seq_get_len	  = virtio_transport_seqpacket_seq_get_len,
> > +
> >  		.notify_poll_in           = virtio_transport_notify_poll_in,
> >  		.notify_poll_out          = virtio_transport_notify_poll_out,
> >  		.notify_recv_init         = virtio_transport_notify_recv_init,
> > -- 
> > 2.25.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
