Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6919DEB64D9
	for <virtualization@archiver.kernel.org>; Sun,  2 Jul 2023 13:37:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C875A404D1;
	Sun,  2 Jul 2023 13:37:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C875A404D1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fl0JhCKJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SvSxiz3NLhxF; Sun,  2 Jul 2023 13:37:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4C8DD40122;
	Sun,  2 Jul 2023 13:37:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4C8DD40122
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 21D40C0072;
	Sun,  2 Jul 2023 13:37:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22695C0032
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Jul 2023 13:37:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC9E340972
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Jul 2023 13:37:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org DC9E340972
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fl0JhCKJ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 25vQdcCWMmHh
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Jul 2023 13:37:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 8B170401A1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8B170401A1
 for <virtualization@lists.linux-foundation.org>;
 Sun,  2 Jul 2023 13:37:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1688305038;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Fscz16jdu5EOdDpNFofgtOkAvApauMfws1a+RHlsQn0=;
 b=Fl0JhCKJchdr5bGV1k4J5b4NrQY045YWAao/f57WpA1i1FaxpuGznaw3Nc9YEV6PYUgCym
 nO5soKDQqv+Eet2utC1jhLjeNR3DGh+97RuOXnAD+EpIRkM7WNjO/WROWT81tW/GRnwaV9
 wDUIrhKqDeFxo5XDzrtw5yMaROviYsw=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-Thbz71_2MIKvOOkWMv2EOg-1; Sun, 02 Jul 2023 09:37:15 -0400
X-MC-Unique: Thbz71_2MIKvOOkWMv2EOg-1
Received: by mail-ej1-f69.google.com with SMTP id
 a640c23a62f3a-987e47d2e81so259732466b.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 02 Jul 2023 06:37:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1688305032; x=1690897032;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fscz16jdu5EOdDpNFofgtOkAvApauMfws1a+RHlsQn0=;
 b=YeMNxHQSM4grTXs7+x72mMyO0Ti3IemmX982dpZJtOxmr4l+YQNFlRbUx1sDZBWcmx
 CZYG0l/uFDo7B+setNwgIuGjaqG9m8wgORl8GaJAJw8EjO9iQ4h5y7pm7CLWTktkayjl
 hOddO7SRc684vg8oRgL2wZyzaQrgLPFiCzHKSDiQ0qyB50837X+guyiA/X40a7mOn9kc
 4WtCYcNdoyIJLjyOSAPZHEMo+o2ZUAfL4Pi6Wx4GCgb+8KWrjnyBtOvJXG6NBSfO3W/u
 eVGSrQoNrRylQtwJcV7k5BeY+fo6wLJ/uOftxvZJdAlDweiF6LdcA7xwCaJk3qaBC8/4
 V6xQ==
X-Gm-Message-State: AC+VfDz4xikJihOv8l9B6a5qLIKMkmR9lLU4gFZKGemVmlXijwreLYF4
 LTA6XfQQrhvbUxQXWycq6urRi4Ft67z/ogWUsTr56EvBD/v1GKh6SEh4ZonOWgcZMKaJfPl7StA
 ayys/TN1IhxK+7WpZdqlC0WbdpXlfbu9Eadrm9xYS8w==
X-Received: by 2002:a17:906:b811:b0:979:65f0:cced with SMTP id
 dv17-20020a170906b81100b0097965f0ccedmr5934776ejb.17.1688305031943; 
 Sun, 02 Jul 2023 06:37:11 -0700 (PDT)
X-Google-Smtp-Source: APBJJlFGgYm6Pej4shREErdqqtoaKfnv59VDi8oQbzHD5HcPb5WjgVVGyKQF1QNN/hdRhbN02rqoIg==
X-Received: by 2002:a17:906:b811:b0:979:65f0:cced with SMTP id
 dv17-20020a170906b81100b0097965f0ccedmr5934769ejb.17.1688305031706; 
 Sun, 02 Jul 2023 06:37:11 -0700 (PDT)
Received: from redhat.com ([2.52.134.224]) by smtp.gmail.com with ESMTPSA id
 x26-20020a1709065ada00b00992025654c1sm7342793ejs.179.2023.07.02.06.37.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 02 Jul 2023 06:37:11 -0700 (PDT)
Date: Sun, 2 Jul 2023 09:37:06 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [PATCH v1 0/2] vduse: add support for networking devices
Message-ID: <20230702093530-mutt-send-email-mst@kernel.org>
References: <20230627113652.65283-1-maxime.coquelin@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20230627113652.65283-1-maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xuanzhuo@linux.alibaba.com, lulu@redhat.com, eperezma@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 david.marchand@redhat.com
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

On Tue, Jun 27, 2023 at 01:36:50PM +0200, Maxime Coquelin wrote:
> This small series enables virtio-net device type in VDUSE.
> With it, basic operation have been tested, both with
> virtio-vdpa and vhost-vdpa using DPDK Vhost library series
> adding VDUSE support using split rings layout (merged in
> DPDK v23.07-rc1).
> 
> Control queue support (and so multiqueue) has also been
> tested, but requires a Kernel series from Jason Wang
> relaxing control queue polling [1] to function reliably.
> 
> [1]: https://lore.kernel.org/lkml/CACGkMEtgrxN3PPwsDo4oOsnsSLJfEmBEZ0WvjGRr3whU+QasUg@mail.gmail.com/T/

Jason promised to post a new version of that patch.
Right Jason?
For now let's make sure CVQ feature flag is off?

> RFC -> v1 changes:
> ==================
> - Fail device init if it does not support VERSION_1 (Jason)
> 
> Maxime Coquelin (2):
>   vduse: validate block features only with block devices
>   vduse: enable Virtio-net device type
> 
>  drivers/vdpa/vdpa_user/vduse_dev.c | 15 +++++++++++----
>  1 file changed, 11 insertions(+), 4 deletions(-)
> 
> -- 
> 2.41.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
