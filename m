Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EF560C25B47
	for <virtualization@archiver.kernel.org>; Wed, 25 Oct 2023 08:34:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4A7EF84C17;
	Wed, 25 Oct 2023 08:34:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4A7EF84C17
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=SpYxdJ1W
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DY8VvYpafiNH; Wed, 25 Oct 2023 08:34:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 92CD6848A5;
	Wed, 25 Oct 2023 08:34:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 92CD6848A5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61B27C0071;
	Wed, 25 Oct 2023 08:34:07 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0D43AC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 08:34:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DA4A584C1D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 08:34:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DA4A584C1D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I1JDimVrTKEY
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 08:34:05 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 17803848A5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 08:34:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 17803848A5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698222843;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=PwvR0H/rJekRKW7bPChVNQWyI2TmQ8ZzJ/CtmxOFWqI=;
 b=SpYxdJ1WrLHdcqJcift3iEEjgSOB8HThh7vHZwBImlDMf/B4bkwFugRNQ85dlRyWayKYZ6
 +dvJ3SjcooiQWqjUA+B6sl+/2+Vh9p06tt10y4CltLmEPNPLLb34hYLa7P3mE7zt2vZo07
 I/GU/bK4h/76yNze8viUIlPJF5HYYvE=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-308-JvL6xsVFNTi9mRFtwxZesg-1; Wed, 25 Oct 2023 04:34:02 -0400
X-MC-Unique: JvL6xsVFNTi9mRFtwxZesg-1
Received: by mail-qk1-f200.google.com with SMTP id
 af79cd13be357-7740829f2beso734743585a.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 25 Oct 2023 01:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698222841; x=1698827641;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=PwvR0H/rJekRKW7bPChVNQWyI2TmQ8ZzJ/CtmxOFWqI=;
 b=kYdnaLCgUjIrI9J63sw+/1tUa7GmOQFr5JOo+XQcaBT/h0W9RsUBHvSSYjDhqDsh2n
 tGZKpXqm1hgkzVzu79VpCMKJ4CUh4HtETGXK/wZgdQg/6W2rXuKi7j12xVOItQEQ/2Er
 LIam2EqnSgEecTdag0wfmK3oxLsrt5kCzvuNGy/hdM4pIhhBaVHVl0nShkrHmIw3wIak
 6amrUFa2iwOJPe0etISNFNZ5QUB5V4tA6CTD3q6AvC3y+LOel1hbusDXgN3OTL5S6ghE
 +jOgawO5lohKn4CIZmICFqLIEY+QV8T96pTlzeqVKrHrODNMceVBgacYLkOL4dBHv4f2
 xtSw==
X-Gm-Message-State: AOJu0YyQtoG1GdNw+CfjIbC4Og3Cs+t1vcfvsiCBdGkJxTMWnQ242ZFc
 a7p2xhHhtRxgr10t79kE+KJSW8X5LoK9EuQObm+v2921d0sBHxkNdP67bTkEVEptmEIsPW3fQtY
 U1aMWXQ0RYNgpTTquajwHbav8wd1mrRUOoBoVu9ACTQ==
X-Received: by 2002:a05:622a:3d3:b0:418:b8c:1a0a with SMTP id
 k19-20020a05622a03d300b004180b8c1a0amr19027900qtx.25.1698222841615; 
 Wed, 25 Oct 2023 01:34:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEwwSeGExFJjD6DFEBCEVHy8IMPsNdmNyv4qMG1/LmCczDQr1ec7svBZSUmolsxUEMpJlCnJQ==
X-Received: by 2002:a05:622a:3d3:b0:418:b8c:1a0a with SMTP id
 k19-20020a05622a03d300b004180b8c1a0amr19027875qtx.25.1698222841295; 
 Wed, 25 Oct 2023 01:34:01 -0700 (PDT)
Received: from sgarzare-redhat (host-87-12-185-56.business.telecomitalia.it.
 [87.12.185.56]) by smtp.gmail.com with ESMTPSA id
 f2-20020ac87f02000000b004198f67acbesm4022433qtk.63.2023.10.25.01.33.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 25 Oct 2023 01:34:00 -0700 (PDT)
Date: Wed, 25 Oct 2023 10:33:56 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Alexandru Matei <alexandru.matei@uipath.com>
Subject: Re: [PATCH v4] vsock/virtio: initialize the_virtio_vsock before
 using VQs
Message-ID: <gg3dml3ipk44cx55gjshr7km74xsksdc6pkosa5sulufannxsw@pgpqq7kjosw4>
References: <20231024191742.14259-1-alexandru.matei@uipath.com>
MIME-Version: 1.0
In-Reply-To: <20231024191742.14259-1-alexandru.matei@uipath.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Viorel Canja <viorel.canja@uipath.com>, kvm@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Eric Dumazet <edumazet@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Mihai Petrisor <mihai.petrisor@uipath.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, Oct 24, 2023 at 10:17:42PM +0300, Alexandru Matei wrote:
>Once VQs are filled with empty buffers and we kick the host, it can send
>connection requests. If the_virtio_vsock is not initialized before,
>replies are silently dropped and do not reach the host.
>
>virtio_transport_send_pkt() can queue packets once the_virtio_vsock is
>set, but they won't be processed until vsock->tx_run is set to true. We
>queue vsock->send_pkt_work when initialization finishes to send those
>packets queued earlier.
>
>Fixes: 0deab087b16a ("vsock/virtio: use RCU to avoid use-after-free on the_virtio_vsock")
>Signed-off-by: Alexandru Matei <alexandru.matei@uipath.com>
>---
>v4:
>- moved queue_work for send_pkt_work in vqs_start and added comment explaining why
>v3:
>- renamed vqs_fill to vqs_start and moved tx_run initialization to it
>- queued send_pkt_work at the end of initialization to send packets queued earlier
>v2:
>- split virtio_vsock_vqs_init in vqs_init and vqs_fill and moved
>  the_virtio_vsock initialization after vqs_init
>
> net/vmw_vsock/virtio_transport.c | 18 +++++++++++++++++-
> 1 file changed, 17 insertions(+), 1 deletion(-)

LGTM!

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
