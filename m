Return-Path: <SRS0=Bv1r=PI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B441C433EF
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 07:18:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2420660FD8
	for <virtualization@archiver.kernel.org>; Wed, 20 Oct 2021 07:18:32 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2420660FD8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D54C460766;
	Wed, 20 Oct 2021 07:18:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fcfm8W9njEY1; Wed, 20 Oct 2021 07:18:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id ABF0260ABF;
	Wed, 20 Oct 2021 07:18:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5CB53C000F;
	Wed, 20 Oct 2021 07:18:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91985C000D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 07:18:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 736FF60B5D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 07:18:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VDFFEXRuJ9bB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 07:18:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 66E3360ABF
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 07:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1634714303;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=xdgj6SdvLhFwHBvEbV5KY24EzQ2wsW3+msXZfewzZ28=;
 b=Pm72XrXVY3AWPhzSZSd02Dw0R6FLuf4twOba3C51MmtcPA4zq9ysrGbID2P0nuXvH/T5h/
 wL9HbNhl530pyEv2VqNGb9muhLHAqCYAgmRYnqHE5K5pg8oXZIw9OpV6cfNib4Op11ucY4
 72ilHw6TFTiGgYprNitGW6CubHiTHcA=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-rFRH3qGDPz2ecuJlsc3Z8A-1; Wed, 20 Oct 2021 03:18:21 -0400
X-MC-Unique: rFRH3qGDPz2ecuJlsc3Z8A-1
Received: by mail-ed1-f72.google.com with SMTP id
 u23-20020a50a417000000b003db23c7e5e2so20095923edb.8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Oct 2021 00:18:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=xdgj6SdvLhFwHBvEbV5KY24EzQ2wsW3+msXZfewzZ28=;
 b=qh372FQtYr9zgUiKRRyumNHw+NCQo4lT21df222/3EHIKYEUA5ge7KfxS7K8cXJp0p
 ny4sFNv3QaEPa6/PLjmHEmAGVQ80M0kDdCAW2iZM0shtv+iBzOZkutDhuKgS4tDKCmE/
 /fXQMSZ1Q6hm593RgtboCiV/30Gu9xGK1Uhwg/y11CWAMPXxCvVs8ZBL6tAKdQNZNYxs
 YuFPNuB8D8kmblKydojX3VI/PmwOYluKlLq5JaiEgYnfZ5KsTMnH0S/YAjQu71xKqDS1
 aSIsO6+As4r8DQ1dhEgugNqmLazSAdusR0F9wmcGYQoPBiv5bXJUrNgQVHUT9FxsC2ih
 9uDQ==
X-Gm-Message-State: AOAM533PY1/Aol4mhis4BVpTJ6ImZ7t8U0iEktLl08Wm6m8EApIW8RTY
 1Jf0nxOWzHSgZPEZz9B13T60o+TjI+/+fkZScXF2eCTow47GRyiqXTccQQzYIng+sC5iwC2s9A1
 VuXKq0BUYhtzbSOiGtUvP6cV5CwwxaPP8hp1t14W4Dw==
X-Received: by 2002:a05:6402:1c94:: with SMTP id
 cy20mr60372412edb.144.1634714300326; 
 Wed, 20 Oct 2021 00:18:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxHtowpIQurYGdY2Ipfvn7cEUWyB9V830NvZof3v0pUEFTKdE9/01f6TbWLuJvV0UND3sbbFQ==
X-Received: by 2002:a05:6402:1c94:: with SMTP id
 cy20mr60372386edb.144.1634714300083; 
 Wed, 20 Oct 2021 00:18:20 -0700 (PDT)
Received: from steredhat (host-79-34-250-211.business.telecomitalia.it.
 [79.34.250.211])
 by smtp.gmail.com with ESMTPSA id u23sm655460edr.97.2021.10.20.00.18.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 20 Oct 2021 00:18:19 -0700 (PDT)
Date: Wed, 20 Oct 2021 09:18:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 01/10] virtio-blk: validate num_queues during probe
Message-ID: <20211020071817.pzyfploxlryvdf3p@steredhat>
References: <20211019070152.8236-1-jasowang@redhat.com>
 <20211019070152.8236-2-jasowang@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20211019070152.8236-2-jasowang@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: david.kaplan@amd.com, konrad.wilk@oracle.com, f.hetzelt@tu-berlin.de,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 mst@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>
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

On Tue, Oct 19, 2021 at 03:01:43PM +0800, Jason Wang wrote:
>If an untrusted device neogitates BLK_F_MQ but advertises a zero

s/neogitates/negotiates

>num_queues, the driver may end up trying to allocating zero size
>buffers where ZERO_SIZE_PTR is returned which may pass the checking
>against the NULL. This will lead unexpected results.
>
>Fixing this by failing the probe in this case.
>
>Cc: Paolo Bonzini <pbonzini@redhat.com>
>Cc: Stefan Hajnoczi <stefanha@redhat.com>
>Cc: Stefano Garzarella <sgarzare@redhat.com>
>Signed-off-by: Jason Wang <jasowang@redhat.com>
>---
> drivers/block/virtio_blk.c | 4 ++++
> 1 file changed, 4 insertions(+)

Should we CC stable?

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
