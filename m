Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F3AEC4332F
	for <virtualization@archiver.kernel.org>; Tue, 20 Dec 2022 11:12:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E337981D3D;
	Tue, 20 Dec 2022 11:12:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E337981D3D
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=JigKzRgJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Z83e63kt2Kdw; Tue, 20 Dec 2022 11:12:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 678DC81BD6;
	Tue, 20 Dec 2022 11:12:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 678DC81BD6
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6EE59C0032;
	Tue, 20 Dec 2022 11:12:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6CCDCC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 11:12:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id A4CA541553
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 11:12:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A4CA541553
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=JigKzRgJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zos5oYnPMxE3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 11:12:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 76DDD410E7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 76DDD410E7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 11:12:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1671534721;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=AcFvnlNioLP/KkH6qBwLrs8kaBJYehGt9ukR9bUDWnM=;
 b=JigKzRgJhAKdXkIrSOtUDMr6cV828G7GsPkCdcVPclwC2Yzhc5L8skdzei8/kBIYK2vhxQ
 vfG2bc5uv7kWN4P6EcKTlB6mbaNAd3bO0dwxCstcT8fNdAnvw+319S1ks4jz1opamLbnKf
 nlWy/1CVO6JoPrmdjPv7FNdYkGm+ZVA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-270-pxe3NhfJM9mferuPUoOp2w-1; Tue, 20 Dec 2022 06:11:59 -0500
X-MC-Unique: pxe3NhfJM9mferuPUoOp2w-1
Received: by mail-qt1-f198.google.com with SMTP id
 cm12-20020a05622a250c00b003a521f66e8eso5380498qtb.17
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Dec 2022 03:11:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=AcFvnlNioLP/KkH6qBwLrs8kaBJYehGt9ukR9bUDWnM=;
 b=rwPdgmmYZnqkSBzZ9oGHFnYdBIs7PkYVr+qKitkbhGAv3Wu1iuQXPz4eT9wc4jje8b
 Oq8k4C4/FCgMU48RFbFJ+FwKiaXuZqFQzmJXKdr9u2VlwFu7qbCX8+BKFhcWkXj1NlOD
 aBqUV/h0zSAVDXHExZCLJVocktRlUjcHhCGcjLooZD7qu2L86LO57TZza/AaWgdo+aUN
 xpu9pJcHzLD6paCygHD4KE0RUEwS6SCzZ/E2q4dJ5wYzqrrfViga72L7S51jOxlya2mp
 XIdJumrV4KKk9ow89LBtQEEBX8VVYnPFHxhSoTpdO317Gk7o1sfu9+B5MzXHWKPOUspt
 pQAg==
X-Gm-Message-State: ANoB5pnaCbdK4sM06v1cDXnF3GxG+6IL5bXOY1kXADJN+BaDS5LNJ5vP
 k/M1zu+cVVuRPVEDCE4af/CVZkoG/8llb5x7NQBTEe8HCqLjBuVN9+2SG8qa5ydh6qkkyGvjaNx
 t/fhUANNKVYM/fc+dskO/gWb452ZUK2EBA0f4ArvBZQ==
X-Received: by 2002:a05:6214:3990:b0:4ee:b86a:2b5a with SMTP id
 ny16-20020a056214399000b004eeb86a2b5amr31435792qvb.20.1671534719554; 
 Tue, 20 Dec 2022 03:11:59 -0800 (PST)
X-Google-Smtp-Source: AMrXdXuHlBJYZ26nly3d5ku6D7a6qEuXtdjCI1SVoOw5osIdwx03DPqQ1Xewxdch2fG+GWJlkP5OCQ==
X-Received: by 2002:a05:6214:3990:b0:4ee:b86a:2b5a with SMTP id
 ny16-20020a056214399000b004eeb86a2b5amr31435770qvb.20.1671534719340; 
 Tue, 20 Dec 2022 03:11:59 -0800 (PST)
Received: from redhat.com ([37.19.199.118]) by smtp.gmail.com with ESMTPSA id
 bl13-20020a05620a1a8d00b006fa22f0494bsm8662747qkb.117.2022.12.20.03.11.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 20 Dec 2022 03:11:58 -0800 (PST)
Date: Tue, 20 Dec 2022 06:11:53 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bagas Sanjaya <bagasdotme@gmail.com>
Subject: Re: [PATCH 0/3] docs: driver-api: virtio: documentation improv
 suggestion
Message-ID: <20221220061138-mutt-send-email-mst@kernel.org>
References: <20221220095828.27588-1-bagasdotme@gmail.com>
MIME-Version: 1.0
In-Reply-To: <20221220095828.27588-1-bagasdotme@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Cornelia Huck <cohuck@redhat.com>, Jonathan Corbet <corbet@lwn.net>,
 linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kernel@collabora.com
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

On Tue, Dec 20, 2022 at 04:58:26PM +0700, Bagas Sanjaya wrote:
> Michael S. Tsirkin has asked me [1] to post my improv suggestions for
> now-applied virtio documentation [2], so here is the suggestion patch series.
> The original suggestion must be splitted since it contains three distinct
> changes.
> 
> This series is based on kernel-doc fixup posted to fix recent linux-next
> warnings [3].
> 
> [1]: https://lore.kernel.org/linux-doc/20221219011647-mutt-send-email-mst@kernel.org/
> [2]: https://lore.kernel.org/linux-doc/Y0QYTq7KW9C731s0@debian.me/
> [3]: https://lore.kernel.org/lkml/20221220073709.2687151-1-ricardo.canuelo@collabora.com/

Thanks, will queue for rc2.

> Bagas Sanjaya (3):
>   docs: driver-api: virtio: parenthesize external reference targets
>   docs: driver-api: virtio: slightly reword virtqueues allocation
>     paragraph
>   docs: driver-api: virtio: commentize spec version checking
> 
>  Documentation/driver-api/virtio/virtio.rst | 19 ++++++++++---------
>  1 file changed, 10 insertions(+), 9 deletions(-)
> 
> -- 
> An old man doll... just what I always wanted! - Clara

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
