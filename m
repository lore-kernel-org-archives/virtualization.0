Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D8BCECAAD1
	for <virtualization@archiver.kernel.org>; Wed, 31 Aug 2022 15:12:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 338DB40C8E;
	Wed, 31 Aug 2022 15:12:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 338DB40C8E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=jNwP5YyP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jG4_lHZ-1OrU; Wed, 31 Aug 2022 15:12:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id AA20B40C9B;
	Wed, 31 Aug 2022 15:12:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AA20B40C9B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7236AC0033;
	Wed, 31 Aug 2022 15:12:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7EA69C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 15:12:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5822E8300C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 15:12:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5822E8300C
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=jNwP5YyP
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id vCYX-RG6OSfC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 15:12:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 90BC283005
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 90BC283005
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 15:12:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661958756;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=JKP8dj8WuZemTKuRl66zdjz4lCSZEv7hTLOVxotDaj0=;
 b=jNwP5YyPQrlipAgcux1/zOGZ2+KzphsIWJ1RByarvLXGNPcYHcGCs5Ny0KoJ6yBnRKHJ1T
 yIJixOObedhi4GPlHUXFYFsDAlpfEdyMW6JPXJjgLmXTQPzk5rIJpXs+jgWgNLCjDW4VGr
 u17D5pHiz1H/zlV3WdlWGmovfSsGLf4=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-582-x0AInvjoPL-X9437xjcqTw-1; Wed, 31 Aug 2022 11:12:35 -0400
X-MC-Unique: x0AInvjoPL-X9437xjcqTw-1
Received: by mail-wm1-f72.google.com with SMTP id
 i132-20020a1c3b8a000000b003a537064611so8417435wma.4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 Aug 2022 08:12:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
 bh=JKP8dj8WuZemTKuRl66zdjz4lCSZEv7hTLOVxotDaj0=;
 b=ky292YZ2BTNXcRdLs9HafEjp7/tMocSY+feswUVRxTexIUngAiRaDfjBgCxX+41D83
 KKdvTUZXIjTB49sawafyDk+cpjEsrYDMRI9swJ2IeNCAEVxtR4/Gk8rtJlUEWOgGaU9D
 uvM9PYnj3G5CiK01EshJV6DWshAF6I4HN10Nx+/KBLE7ARCK99hgMGrFiisNeiMDpl75
 8/2xepHyhCmi9mYCH24OM1MHXWUg9jfwqVC8MjlQrlUb5LUowH0BYevR5dpC1qtOn0L6
 CBmnWKuzQm2kY77bbcYftw8hvVzJpIe69NQGDo+hUoQs3o0T2eNt35KbbfdomtwlrBoa
 1Y/g==
X-Gm-Message-State: ACgBeo08mb+IsxP50zMoDbyTDMjRkM0PEuXKVfUE7aLEAbBeYzjm6YRL
 /PBo48rZongnJYBHzpQ0K6HhGN+BJwnXHe5gHtB3ZUZvh3irE3WDMezwgXZi+3/iUPb+gV4rbTt
 /3zSlMx8zHHeFn/Lw97lKco7EsZ7PCaVibYYHd657WQ==
X-Received: by 2002:adf:fac1:0:b0:226:d790:7644 with SMTP id
 a1-20020adffac1000000b00226d7907644mr9387377wrs.471.1661958753946; 
 Wed, 31 Aug 2022 08:12:33 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5PJFVzXSpBCAXnH3mX+ZSWG4afgD21FAy1UQUdZOBZlILIOyvF5zouIz/cz3kS0Aab8WIhyg==
X-Received: by 2002:adf:fac1:0:b0:226:d790:7644 with SMTP id
 a1-20020adffac1000000b00226d7907644mr9387364wrs.471.1661958753736; 
 Wed, 31 Aug 2022 08:12:33 -0700 (PDT)
Received: from redhat.com ([2.55.191.225]) by smtp.gmail.com with ESMTPSA id
 j5-20020a05600c42c500b003a54fffa809sm2233442wme.17.2022.08.31.08.12.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 31 Aug 2022 08:12:32 -0700 (PDT)
Date: Wed, 31 Aug 2022 11:12:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH v2] vduse: prevent uninitialized memory accesses
Message-ID: <20220831111220-mutt-send-email-mst@kernel.org>
References: <20220829073424.5677-1-maxime.coquelin@redhat.com>
 <YwxvXFiuRqGxRgZH@kroah.com>
 <796c9d73-30a0-2401-e499-724aeb0f8dc6@redhat.com>
MIME-Version: 1.0
In-Reply-To: <796c9d73-30a0-2401-e499-724aeb0f8dc6@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: guanjun@linux.alibaba.com, Greg KH <gregkh@linuxfoundation.org>,
 linux-kernel@vger.kernel.org, stable@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 elic@nvidia.com, gautam.dawar@xilinx.com, dan.carpenter@oracle.com
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

On Wed, Aug 31, 2022 at 05:01:11PM +0200, Maxime Coquelin wrote:
> On 8/29/22 09:48, Greg KH wrote:
> > On Mon, Aug 29, 2022 at 09:34:24AM +0200, Maxime Coquelin wrote:
> > > If the VDUSE application provides a smaller config space
> > > than the driver expects, the driver may use uninitialized
> > > memory from the stack.
> > > 
> > > This patch prevents it by initializing the buffer passed by
> > > the driver to store the config value.
> > > 
> > > This fix addresses CVE-2022-2308.
> > > 
> > > Cc: xieyongji@bytedance.com
> > > Cc: stable@vger.kernel.org # v5.15+
> > > Fixes: c8a6153b6c59 ("vduse: Introduce VDUSE - vDPA Device in Userspace")
> > > 
> > > Acked-by: Jason Wang <jasowang@redhat.com>
> > > Signed-off-by: Maxime Coquelin <maxime.coquelin@redhat.com>
> > 
> > Please no blank line above the Acked-by: line here if possible.
> 
> Sure.
> 
> Jason, do you prefer I post a new revision with this single change or
> you will handle it while applying? Either way is fine to me.
> 
> Thanks,
> Maxime

Repost pls, easier.

> > thanks,
> > 
> > greg k-h
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
