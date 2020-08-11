Return-Path: <SRS0=ofWe=BV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 661A2C433E0
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 11:33:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 295BE20658
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 11:33:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gI/FeK23"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 295BE20658
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E375D85540;
	Tue, 11 Aug 2020 11:33:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QCUymAxAoXsA; Tue, 11 Aug 2020 11:33:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5410F8542A;
	Tue, 11 Aug 2020 11:33:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 456E6C013C;
	Tue, 11 Aug 2020 11:33:52 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C19EC004D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 11:33:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6327986DAF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 11:33:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lhAhwLVyFg+d
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 11:33:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CA1B986B30
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 11:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597145628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=GiCPzZPtpDgWrMbwVo68Gc9UUX4p+0NK8qKoCf+Lg2k=;
 b=gI/FeK23M41k5meXY2J3IjYS42tHdB/K+Q1SVuMTLjw/wOcxZKxrHCBl5TYqCEDw3L38MC
 vOvtkbvH0nJ7WoGChrB5viI0Sqm8a6EcILU1BhptpSKGVDYxRKVdGHZoKy0wL5MbqRxTLb
 0b6Duxx1rjRItchpsi4zA7l+V2aYmWk=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-8YMP7EOWMwGgaHWPnXXl3A-1; Tue, 11 Aug 2020 07:33:46 -0400
X-MC-Unique: 8YMP7EOWMwGgaHWPnXXl3A-1
Received: by mail-wr1-f69.google.com with SMTP id z1so5486960wrn.18
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 04:33:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=GiCPzZPtpDgWrMbwVo68Gc9UUX4p+0NK8qKoCf+Lg2k=;
 b=FmA6Ofbk4CGWuzeYHcZ1EBIfvaEtBxK7M4JQZjPBGHTCCcgT4J1L6GwaxfdHQS8t/6
 d8AhAHLaFaONGGKj0PvjPB6l2LjZqiZiIxH/LfpzqsghzZ+lGDiyzyAURvMohusk+jy6
 mzQ2tC8Jlar465NXzrkyZVZiXpJu0+kF8DPUvpngmNIkROJQJGANjPMTzbmrDMi5SG2C
 jztiR+3sE5huhjL95JXzLZVSbt/FzbaFkAhHdl2UTQZ4D0nvzyYzvx1K1hCxNhZP1ZA/
 89qxjqZkwK4PsuWoYjr8IWvDhz7LJ/l52DFiLRM3A6PECsjGPw9wQ+2Hmekqqgm+wrzz
 Z/KQ==
X-Gm-Message-State: AOAM531XxJRZXhXCSIJzaiEEds07wnnypsxjNIlquOtvOPkEcZkVz5Z7
 +BkZ24Ia5m2b+r4vC1U5PqVGjQVuHSy2LkTFrY3vFgzcEhZL0h2AgCDTKiF/hwE7V5iqkYUNuwm
 xTO7nGpy46+Coz6+nOXKRQo9CaPOb5AuKcN1+qFA8Sg==
X-Received: by 2002:a1c:2dcb:: with SMTP id t194mr3499782wmt.94.1597145625675; 
 Tue, 11 Aug 2020 04:33:45 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzEaIvjLTJL/NIBPByzAEwifrGXrzHsoFwTXAZoU9RkSJbGkn6bslOVl7J4dDyoTVHhx7FazQ==
X-Received: by 2002:a1c:2dcb:: with SMTP id t194mr3499766wmt.94.1597145625527; 
 Tue, 11 Aug 2020 04:33:45 -0700 (PDT)
Received: from redhat.com ([147.161.8.240])
 by smtp.gmail.com with ESMTPSA id 32sm27064327wrn.86.2020.08.11.04.33.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 04:33:44 -0700 (PDT)
Date: Tue, 11 Aug 2020 07:33:26 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: VDPA Debug/Statistics
Message-ID: <20200811073144-mutt-send-email-mst@kernel.org>
References: <BN8PR12MB342559414BE03DFC992AD03DAB450@BN8PR12MB3425.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BN8PR12MB342559414BE03DFC992AD03DAB450@BN8PR12MB3425.namprd12.prod.outlook.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Shahaf Shuler <shahafs@mellanox.com>, "lulu@redhat.com" <lulu@redhat.com>,
 "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 Majd Dibbiny <majd@nvidia.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "eli@mellanox.com" <eli@mellanox.com>, Maor Dickman <maord@nvidia.com>
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

On Tue, Aug 11, 2020 at 11:26:20AM +0000, Eli Cohen wrote:
> Hi All
> 
> Currently, the only statistics we get for a VDPA instance comes from the virtio_net device instance. Since VDPA involves hardware acceleration, there can be quite a lot of information that can be fetched from the underlying device. Currently there is no generic method to fetch this information.
> 
> One way of doing this can be to create a the host, a net device for each VDPA instance, and use it to get this information or do some configuration. Ethtool can be used in such a case
> 
> I would like to hear what you think about this or maybe you have some other ideas to address this topic.
> 
> Thanks,
> Eli

Something I'm not sure I understand is how are vdpa instances created
on mellanox cards? There's a devlink command for that, is that right?
Can that be extended for stats?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
