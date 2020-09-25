Return-Path: <SRS0=jbvZ=DC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96A0DC4363D
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 10:19:44 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1DBEB21D91
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 10:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zpvffw5e"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1DBEB21D91
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1171E2E15E;
	Fri, 25 Sep 2020 10:19:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mkXHxy4GYvyg; Fri, 25 Sep 2020 10:19:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7E6DB2E15A;
	Fri, 25 Sep 2020 10:19:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 610B2C0889;
	Fri, 25 Sep 2020 10:19:41 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AEDA4C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 10:19:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9C34D86C6E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 10:19:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AU-qCb9VAA8T
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 10:19:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CFDE6860A2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 10:19:39 +0000 (UTC)
Dkim-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1601029178;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=P26OWL3+8b1prUkCt7qDotBrREGjXGjJKCeLvVKhHiw=;
 b=Zpvffw5eBL12N5/U4yskXrqzyniknqzcQKFBfxD1AVjfDvQl/mcRvw37V6FzkXbr0NF9u9
 kbZbxkmBdDx0Qo57eYKLm/eDdvLjQ9qWy08MP/J1KBr6x16soBWgSR88DAd4AI9aOsMvAd
 luigpYUPInLzaNGaihXE+ylhs2N8+f8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-553-6mLmiYxZPsmWAMn1X2OeFg-1; Fri, 25 Sep 2020 06:19:36 -0400
X-MC-Unique: 6mLmiYxZPsmWAMn1X2OeFg-1
Received: by mail-wr1-f71.google.com with SMTP id o6so899334wrp.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 25 Sep 2020 03:19:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=P26OWL3+8b1prUkCt7qDotBrREGjXGjJKCeLvVKhHiw=;
 b=B9j6zYZasuIH7HIyT34Rvf9RczOjm8vBSgIfLm0EQAovizvc3gF9qnaobhCHUTNZDl
 0ZJ5xIjkMlErxlfMA0V19QDe2MKiGpm4z1vBk8LeINt3OE49d9DFmiPqKYqGJrDou51P
 gXyCjl5QNCOrejnuge1x4z3IM8jJ8cHNPnTPHBD53bevdNDe2dixCE0WgtiTLAoMaenV
 h+caIbUkwXORsW8FEzGz7yv8Ujqd8DtU/ODRAifIBrhYPmqxCZkwBrQHojvBksCi3xj8
 U7XfZ/90cSIn7B/AZ79GXzHcd/8YYHcVIONbCdqbOY529Nm1s/IEfWTLOt283eEJKB30
 ZLeg==
X-Gm-Message-State: AOAM533LBNBtUjBIK3DIMOC6s7TCxKmNWt5DBDxQiPM+oESU3nQ44WhE
 UiW6KaLNkAwMde3s1gxXATtNKIeOqC7DZdQXiKrfQPsmCYJIUxRkb64n28mDMTnninpnkJVN2l1
 GhpGlFa/qGp6XsXD8Au1qPNtwpBnIMpMIYQlbbSV6tA==
X-Received: by 2002:a5d:470f:: with SMTP id y15mr3625813wrq.420.1601029175427; 
 Fri, 25 Sep 2020 03:19:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwLSbI9jm2XMOk+32xte7rC7OY1SRWmEug56SJmm4FkGi+zaNWLZhe1WA4eNqffhuABgGE01g==
X-Received: by 2002:a5d:470f:: with SMTP id y15mr3625796wrq.420.1601029175219; 
 Fri, 25 Sep 2020 03:19:35 -0700 (PDT)
Received: from redhat.com (bzq-79-179-71-128.red.bezeqint.net. [79.179.71.128])
 by smtp.gmail.com with ESMTPSA id u126sm2972203wmu.9.2020.09.25.03.19.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 03:19:34 -0700 (PDT)
Date: Fri, 25 Sep 2020 06:19:30 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Leon Romanovsky <leonro@nvidia.com>
Subject: Re: [PATCH v3 -next] vdpa: mlx5: change Kconfig depends to fix build
 errors
Message-ID: <20200925061847-mutt-send-email-mst@kernel.org>
References: <73f7e48b-8d16-6b20-07d3-41dee0e3d3bd@infradead.org>
 <20200918082245.GP869610@unreal>
 <20200924052932-mutt-send-email-mst@kernel.org>
 <20200924102413.GD170403@mtl-vdi-166.wap.labs.mlnx>
 <079c831e-214d-22c1-028e-05d84e3b7f04@infradead.org>
 <20200924120217-mutt-send-email-mst@kernel.org>
 <20200925072005.GB2280698@unreal>
MIME-Version: 1.0
In-Reply-To: <20200925072005.GB2280698@unreal>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Randy Dunlap <rdunlap@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Eli Cohen <elic@nvidia.com>,
 Saeed Mahameed <saeedm@nvidia.com>
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

On Fri, Sep 25, 2020 at 10:20:05AM +0300, Leon Romanovsky wrote:
> On Thu, Sep 24, 2020 at 12:02:43PM -0400, Michael S. Tsirkin wrote:
> > On Thu, Sep 24, 2020 at 08:47:05AM -0700, Randy Dunlap wrote:
> > > On 9/24/20 3:24 AM, Eli Cohen wrote:
> > > > On Thu, Sep 24, 2020 at 05:30:55AM -0400, Michael S. Tsirkin wrote:
> > > >>>> --- linux-next-20200917.orig/drivers/vdpa/Kconfig
> > > >>>> +++ linux-next-20200917/drivers/vdpa/Kconfig
> > > >>>> @@ -31,7 +31,7 @@ config IFCVF
> > > >>>>
> > > >>>>  config MLX5_VDPA
> > > >>>>  	bool "MLX5 VDPA support library for ConnectX devices"
> > > >>>> -	depends on MLX5_CORE
> > > >>>> +	depends on VHOST_IOTLB && MLX5_CORE
> > > >>>>  	default n
> > > >>>
> > > >>> While we are here, can anyone who apply this patch delete the "default n" line?
> > > >>> It is by default "n".
> > > >
> > > > I can do that
> > > >
> > > >>>
> > > >>> Thanks
> > > >>
> > > >> Hmm other drivers select VHOST_IOTLB, why not do the same?
> > >
> > > v1 used select, but Saeed requested use of depends instead because
> > > select can cause problems.
> > >
> > > > I can't see another driver doing that. Perhaps I can set dependency on
> > > > VHOST which by itself depends on VHOST_IOTLB?
> > > >>
> > > >>
> > > >>>>  	help
> > > >>>>  	  Support library for Mellanox VDPA drivers. Provides code that is
> > > >>>>
> > > >>
> > >
> >
> > Saeed what kind of problems? It's used with select in other places,
> > isn't it?
> 
> IMHO, "depends" is much more explicit than "select".
> 
> Thanks

This is now how VHOST_IOTLB has been designed though.
If you want to change VHOST_IOTLB to depends I think
we should do it consistently all over.


config VHOST_IOTLB
        tristate
        help
          Generic IOTLB implementation for vhost and vringh.
          This option is selected by any driver which needs to support
          an IOMMU in software.


> >
> > > --
> > > ~Randy
> >

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
