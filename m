Return-Path: <SRS0=ofWe=BV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADF55C433E0
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 12:44:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D8CF20756
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 12:44:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QvUZBAyB"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D8CF20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 4767820004;
	Tue, 11 Aug 2020 12:44:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mLBB3zVwp7r9; Tue, 11 Aug 2020 12:44:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A8369203BE;
	Tue, 11 Aug 2020 12:44:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8DD70C07FF;
	Tue, 11 Aug 2020 12:44:55 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96241C004D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 12:44:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 848CB85BC4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 12:44:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dP6-iaVwr0fv
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 12:44:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 34AA9855A1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 12:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597149892;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=4gObRQ0Fq7QQ6hAOg5wupZW2BNQ64paK3yGpxjhjhBc=;
 b=QvUZBAyBKO9JidjPSh1HzuNbnTiDtcHLyj5dNp2XPrzm9Q5A8JufdEnAACXiQ/hDDoktH+
 tRhhYSShmXyy/t66mwC5KyY6Yh2qy/3u5FmH6PkXSJpWSmzPPn0O+gibPuUtFBB3BjgeCz
 76UbbjIeifrrwb/D9X1N7qu8ZYawgV0=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-532-tC7DkTpbPbCeeseU05_OtA-1; Tue, 11 Aug 2020 08:44:49 -0400
X-MC-Unique: tC7DkTpbPbCeeseU05_OtA-1
Received: by mail-ed1-f71.google.com with SMTP id b39so4580553edf.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 05:44:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=4gObRQ0Fq7QQ6hAOg5wupZW2BNQ64paK3yGpxjhjhBc=;
 b=gtavI7+Nn2Wj+74W1DXVifxZ09YrDdLHEao2AYWLRIbHXFaQBlsWJ0b/l1whCpSEZ/
 SR+XyPGKI7/lzGQ3MRWU0Ib7I3YcY97pSORCV9nLNcsrRnbm+PSAEubQj0rXTJjaLe5c
 WfsttDHgjFGDQROAFKC6Xf1tG+EXYIHjC7Xbx7RB71fbDdEn2B0FSyI7DDkSaqlOFXMf
 fO8AGSRGKjeF0pNEFoGghcYXZFsjGNB0XOuqSRT9WQFUCu1DQ4mzzzu81hV3++tjq7TY
 FoJZRIC3F2ITaA2DoYou8g4jFyX5+Il+1gqLxIOcM/01xUpZNqv96v3oAuunY/Ezvgd3
 EcSw==
X-Gm-Message-State: AOAM530sGZgmN+iGpRnDbYutBib5zKcybo+SPM+lHpD/HnIXcY76uv3N
 M91/P91tDSsxifMsg0SHj6kaCH/4Ppm8BN2KNi6mOY7ycjRVOni4YdOTVWEkSvcGJx3TUW/R55j
 kz9PduEgtlC//KhYNw5m6lBF/68SD7OjL06Fg7XHDFg==
X-Received: by 2002:a05:6402:1218:: with SMTP id
 c24mr25203349edw.44.1597149888491; 
 Tue, 11 Aug 2020 05:44:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzIaQixLajacpoqLdEsULPbWw/H9fIINTYi9tun3K98B+6Mv/G3SkYZ35zHOyX7A3SBCMINnQ==
X-Received: by 2002:a05:6402:1218:: with SMTP id
 c24mr25203332edw.44.1597149888269; 
 Tue, 11 Aug 2020 05:44:48 -0700 (PDT)
Received: from redhat.com ([147.161.12.106])
 by smtp.gmail.com with ESMTPSA id q11sm14418807edn.12.2020.08.11.05.44.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 05:44:47 -0700 (PDT)
Date: Tue, 11 Aug 2020 08:44:43 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: VDPA Debug/Statistics
Message-ID: <20200811083803-mutt-send-email-mst@kernel.org>
References: <BN8PR12MB342559414BE03DFC992AD03DAB450@BN8PR12MB3425.namprd12.prod.outlook.com>
 <20200811073144-mutt-send-email-mst@kernel.org>
 <BN8PR12MB34259F2AE1FDAF2D40E48C5BAB450@BN8PR12MB3425.namprd12.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <BN8PR12MB34259F2AE1FDAF2D40E48C5BAB450@BN8PR12MB3425.namprd12.prod.outlook.com>
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
 "eli@mellanox.com" <eli@mellanox.com>, Maor Dickman <maord@nvidia.com>,
 Parav Pandit <parav@mellanox.com>
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

On Tue, Aug 11, 2020 at 11:58:23AM +0000, Eli Cohen wrote:
> On Tue, Aug 11, 2020 at 11:26:20AM +0000, Eli Cohen wrote:
> > Hi All
> > 
> > Currently, the only statistics we get for a VDPA instance comes from the virtio_net device instance. Since VDPA involves hardware acceleration, there can be quite a lot of information that can be fetched from the underlying device. Currently there is no generic method to fetch this information.
> > 
> > One way of doing this can be to create a the host, a net device for 
> > each VDPA instance, and use it to get this information or do some 
> > configuration. Ethtool can be used in such a case
> > 
> > I would like to hear what you think about this or maybe you have some other ideas to address this topic.
> > 
> > Thanks,
> > Eli
> 
> Something I'm not sure I understand is how are vdpa instances created on mellanox cards? There's a devlink command for that, is that right?
> Can that be extended for stats?
> 
> Currently any VF will be probed as VDPA device. We're adding devlink support but I am not sure if devlink is suitable for displaying statistics. We will discuss internally but I wanted to know why you guys think.

OK still things like specifying the mac are managed through rtnetlink,
right?

Right now it does not look like you can mix stats and vf, they are
handled separately:

        if (rtnl_fill_stats(skb, dev))
                goto nla_put_failure;

        if (rtnl_fill_vf(skb, dev, ext_filter_mask))
                goto nla_put_failure;

but ability to query vf stats on the host sounds useful generally.

As another option, we could use a vdpa specific way to retrieve stats,
and teach qemu to report them.




> --
> MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
