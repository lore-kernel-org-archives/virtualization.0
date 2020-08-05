Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBE79C433DF
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:29:25 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 853822312C
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:29:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VUWxFKnT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 853822312C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1374888184;
	Wed,  5 Aug 2020 13:29:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id teQGkl+sK9YL; Wed,  5 Aug 2020 13:29:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5C8EA880C8;
	Wed,  5 Aug 2020 13:29:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C8AEC0051;
	Wed,  5 Aug 2020 13:29:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7FB1C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:29:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B2F1B862C7
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:29:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T5cGSobPOq2G
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:29:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 0A53A86005
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:29:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596634160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=ZlNXGeTfp4AaGj7FagUROXadawxdtFtkc3vB/EgDPDU=;
 b=VUWxFKnTS0KSWei83tAEkl+vRngfqxSqenQ/TqtRdS2MXlE38LMQOdoGyxyIHjJZ1qYDFN
 KmLsvJV16qVi5zQMO2BuGV8TzblTzPvfYSQkxD9FYfxGOs40xUwNAYAUzdqWY+j8UmCIgG
 J+SaIl8jegjx65MsimjefNrNaVUHPjg=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-qo28Cq5JMbS60AHwsSGs9w-1; Wed, 05 Aug 2020 09:29:19 -0400
X-MC-Unique: qo28Cq5JMbS60AHwsSGs9w-1
Received: by mail-wm1-f72.google.com with SMTP id h205so2728713wmf.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 06:29:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=ZlNXGeTfp4AaGj7FagUROXadawxdtFtkc3vB/EgDPDU=;
 b=WjsoRSz9qOXlO4leBKWYlyl6ujzE5edPusnI6ocCZ5aEmuDlkc2ZO8tdmgegsZ5kgp
 +VvI+InixTP+B5H4Kj0JskNk9CBrknJQmrrfza6ib+Ao+LKzAudCeBSAGmFmTaJISN98
 /Bz+EcZ3wQYIOKBAqR7qa67koBDSwgFstRSgL3RI5O6B8vyqXysKnaPYZlmGHhzB52t4
 V+bvyR/Ngh1OBjr4ZIzq29Xx3IPC+kNQOWNCnhCepYpbse7a3c/A3SOgZy5vLXblCn60
 Emds/MnSrljoWMJFHPEWP37AoaDX5jFRa+LdAmWCiKqAlqmi0ejw3f2kmj8HQz4IbLRt
 eMeQ==
X-Gm-Message-State: AOAM531G5NzltiaaPw3RDHoupwnyx3T3b1FYUMPuk0mY/BziEACP0nPx
 YjT1KPfJC61PkH/RVTko4dCLvjvvZA34C8HjbREVi3U0c25GDJM2+XH/w2prO9gQsRjujXzK9Hy
 xiGWRWGM91QUoSDkmCoM6G2WkfMrdeLFcbzGo/xbMsw==
X-Received: by 2002:a1c:2dc6:: with SMTP id t189mr3492804wmt.26.1596634158283; 
 Wed, 05 Aug 2020 06:29:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJbh142iguNxC67bdTgdKSa8fH88cZSGiuSiR54HZcWK+ZPtzZyXH9COzQuExoJPoIfhvlDw==
X-Received: by 2002:a1c:2dc6:: with SMTP id t189mr3492788wmt.26.1596634158107; 
 Wed, 05 Aug 2020 06:29:18 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id d14sm2806981wre.44.2020.08.05.06.29.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 06:29:17 -0700 (PDT)
Date: Wed, 5 Aug 2020 09:29:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH v2 18/24] mlxbf-tmfifo: sparse tags for config access
Message-ID: <20200805092904-mutt-send-email-mst@kernel.org>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-19-mst@redhat.com>
 <20200804165634.4df11c6b.cohuck@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200804165634.4df11c6b.cohuck@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Vadim Pasternak <vadimp@mellanox.com>, linux-kernel@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, Darren Hart <dvhart@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Andy Shevchenko <andy@infradead.org>
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

On Tue, Aug 04, 2020 at 04:56:34PM +0200, Cornelia Huck wrote:
> On Mon, 3 Aug 2020 17:00:01 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > mlxbf-tmfifo accesses config space using native types -
> > which works for it since the legacy virtio native types.
> > 
> > This will break if it ever needs to support modern virtio,
> > so with new tags previously introduced for virtio net config,
> > sparse now warns for this in drivers.
> > 
> > Since this is a legacy only device, fix it up using
> > virtio_legacy_is_little_endian for now.
> 
> I'm wondering if the driver should make this more explicit?


Not sure how though.

> No issues with the patch, though.
> 
> > 
> > No functional changes.
> > 
> > Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> > ---
> >  drivers/platform/mellanox/mlxbf-tmfifo.c | 13 ++++++++++---
> >  1 file changed, 10 insertions(+), 3 deletions(-)
> 
> Acked-by: Cornelia Huck <cohuck@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
