Return-Path: <SRS0=wpUj=C7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C687C2D0E2
	for <virtualization@archiver.kernel.org>; Tue, 22 Sep 2020 13:52:26 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 83DA120936
	for <virtualization@archiver.kernel.org>; Tue, 22 Sep 2020 13:52:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="E0lN7WbJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 83DA120936
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2491085DD1;
	Tue, 22 Sep 2020 13:52:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gyswCga2wsje; Tue, 22 Sep 2020 13:52:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A981D85D37;
	Tue, 22 Sep 2020 13:52:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 88D9CC0859;
	Tue, 22 Sep 2020 13:52:24 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 644A2C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 13:52:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 5FDE185D40
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 13:52:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id w8MSe8vpWmKi
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 13:52:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 132D385D37
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 13:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1600782740;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=UfJX+wYYmH/wK4kLLTxGKgaWCNaGjgdbMHRevMH7+TA=;
 b=E0lN7WbJfWER8Ts2/AiHVK37G8fx8HJSXZ49leCuEpw/zeI/wM25cQiqJlRoKGAnTmf6C2
 nmvHK9MZVHSbZ+cTcpCb9FnM/sLCH0UL37koxns7sr5zbz3dz/s2KVgLvOp6ZOA8zdf2Mk
 SuScuRNMiP4/pIPELZkYsat+UcBEWFI=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-118-ShSjGPMmP-Kg_ShWlOc5Sg-1; Tue, 22 Sep 2020 09:52:19 -0400
X-MC-Unique: ShSjGPMmP-Kg_ShWlOc5Sg-1
Received: by mail-wr1-f69.google.com with SMTP id a12so7442069wrg.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Sep 2020 06:52:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=UfJX+wYYmH/wK4kLLTxGKgaWCNaGjgdbMHRevMH7+TA=;
 b=cl393xMg/+fax72fQlIpx8FdhE0qior8T+dM4JPkJKFCyIgFWIB7XnK2XNR0dwCJwn
 /N+sa//i8SbltPq7tNTHjypip1SE8L+lwyymhy+8yii0ZkmJmdz2atnUAUF3JYg8ged7
 LrMIgaekF+gBnHRHd1bFRH0amGrA4p8CvmHP2W71YWpJuSlrEicODZKN6Kx3xpFZXka5
 X5Yu8Q1tdWMXJEudb4HfTlAs0XB2Qr/9x93EnR7YgWjCfnV4JlT9Vx2HLbf/wLwTZ4IN
 GOyDa319JdCPa2l7iyRh1k/Ww4RcDNc8Ps6fV+RTeV+fWktjKoVv6MpOCD9QYkxuQGSm
 DG0Q==
X-Gm-Message-State: AOAM532v793D1hFgiyQI9GlSMKDaAts0xJ5ZhgNRDZamzkpnREwylQxW
 +oiULv2KOByIFyhuGCA62L/2BV+KG5G8Ymp/aVlAJMqR0lxWDlahJiEaJVeCptn5oMJBKeveAGn
 WA/+3r30CQDr1ncE5MgGNomS5A9UlY5gWFtJ0eQ9kXQ==
X-Received: by 2002:a1c:9cd3:: with SMTP id f202mr1187571wme.148.1600782737964; 
 Tue, 22 Sep 2020 06:52:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwA4/2LFfWxU8NUoke6X3tzAXQxbMT++c6m4LRcHMg/WZ6CRi0/J2NuZBapW4USmj+BNJiNDQ==
X-Received: by 2002:a1c:9cd3:: with SMTP id f202mr1187547wme.148.1600782737763; 
 Tue, 22 Sep 2020 06:52:17 -0700 (PDT)
Received: from redhat.com (bzq-109-65-116-225.red.bezeqint.net.
 [109.65.116.225])
 by smtp.gmail.com with ESMTPSA id y1sm4650054wmi.36.2020.09.22.06.52.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 22 Sep 2020 06:52:16 -0700 (PDT)
Date: Tue, 22 Sep 2020 09:52:12 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH v12 0/2] s390: virtio: let arch validate VIRTIO features
Message-ID: <20200922095158-mutt-send-email-mst@kernel.org>
References: <1599728030-17085-1-git-send-email-pmorel@linux.ibm.com>
 <de191c4d-cfe3-1414-53b8-e7a09cc15e32@de.ibm.com>
MIME-Version: 1.0
In-Reply-To: <de191c4d-cfe3-1414-53b8-e7a09cc15e32@de.ibm.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: gor@linux.ibm.com, linux-s390@vger.kernel.org, frankja@linux.ibm.com,
 Pierre Morel <pmorel@linux.ibm.com>, thomas.lendacky@amd.com,
 cohuck@redhat.com, linuxram@us.ibm.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, pasic@linux.ibm.com,
 kvm@vger.kernel.org, hca@linux.ibm.com, david@gibson.dropbear.id.au
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

Will do for the next Linux.

On Tue, Sep 22, 2020 at 02:15:17PM +0200, Christian Borntraeger wrote:
> Michael,
> 
> are you going to pick this series?
> 
> 
> On 10.09.20 10:53, Pierre Morel wrote:
> > Hi all,
> > 
> > The goal of the series is to give a chance to the architecture
> > to validate VIRTIO device features.
> > 
> > I changed VIRTIO_F_IOMMU_PLATFORM to VIRTIO_F_ACCESS_PLATFORM
> > I forgot in drivers/virtio/Kconfig, and put back the inclusion
> > of virtio_config.h for the definition of the callback in
> > arch/s390/mm/init.c I wrongly removed in the last series.
> > 
> > Regards,
> > Pierre
> > 
> > 
> > Pierre Morel (2):
> >   virtio: let arch advertise guest's memory access restrictions
> >   s390: virtio: PV needs VIRTIO I/O device protection
> > 
> >  arch/s390/Kconfig             |  1 +
> >  arch/s390/mm/init.c           | 11 +++++++++++
> >  drivers/virtio/Kconfig        |  6 ++++++
> >  drivers/virtio/virtio.c       | 15 +++++++++++++++
> >  include/linux/virtio_config.h | 10 ++++++++++
> >  5 files changed, 43 insertions(+)
> > 

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
