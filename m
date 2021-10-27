Return-Path: <SRS0=5D8L=PP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 265D5C433EF
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 07:40:36 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4A6E6008E
	for <virtualization@archiver.kernel.org>; Wed, 27 Oct 2021 07:40:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C4A6E6008E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 871C74019F;
	Wed, 27 Oct 2021 07:40:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id bgbpvOhOEQ-d; Wed, 27 Oct 2021 07:40:34 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0972F400CC;
	Wed, 27 Oct 2021 07:40:33 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7AA0C0012;
	Wed, 27 Oct 2021 07:40:33 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2AA3FC000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 07:40:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 11FFD60631
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 07:40:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id m-MFD6GCxNh9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 07:40:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 602326058F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 07:40:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635320430;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=X3BQqvENOGhoRqOhT/j02NvDjxHkrDgPt4zshLFq8ZY=;
 b=ObmexrqIXTkJEnqGLEouL/Y4rj1HQzuYfFxb2mRx6BorDBqPq/WAHpOOcnLP02ocUQFV+n
 rswHgUPppVTlFWrKuG0ztu8nHQ5ZZYwu87QtCCewUeff4G0zh3XUatyCF7j3Ta6rXlQvbP
 1CKNHagajxFSF6iiAZb3D4l5B6DmI7w=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-548-7R1ul4GxNFKucrhDSptCyg-1; Wed, 27 Oct 2021 03:40:26 -0400
X-MC-Unique: 7R1ul4GxNFKucrhDSptCyg-1
Received: by mail-ed1-f71.google.com with SMTP id
 z1-20020a05640235c100b003dcf0fbfbd8so1514491edc.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Oct 2021 00:40:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=X3BQqvENOGhoRqOhT/j02NvDjxHkrDgPt4zshLFq8ZY=;
 b=2i9pFu+N+K/ay5punbcvrv6kF1BdGwdojvp3FbTCBssLbWytLg5Xw30FfiltEqoU9o
 xdiuFEtam1ZtrjXVdAo2wOPoqQqcT6D4y5ovaAtgkpVpvPXaIQoM4bVeo/kPyJm9lLqH
 EDKmF5LVx3M6Zz5EHN8E4ymzeUBzaAuoJVjgg8vOsuDL2c38uoYbLRlTPEKZq0e7Mwd+
 MnmlsZSE6mMOctD9nAz3IJQ2xFAxC0WyH93xrEEAXcxH30fBfYSbmRNIw2HDZx2+w1Lp
 ZEyaHP6JaBIdVNWxqZQAQrYQqQ6h5EYGgxoXAaZUeojHRHYrmDMLe/47Hsll/vlWXxaT
 H/Bg==
X-Gm-Message-State: AOAM531BVb7RufK+f4ea5ucYKjazdV+/ivnYulUt0RFxeIKRCeHAx/i6
 NzYSpZ/NrlvvKkSEd6lKHDBvT30sbvDjpgIGaYH/l3/9oPEyq8vpvVuXWU6qIyqKIygs2/wvMTr
 ubJQZNnE1I95lbScYb+N60eG5XlLqTNZOvdegg2AlFw==
X-Received: by 2002:a17:907:96a5:: with SMTP id
 hd37mr26086396ejc.423.1635320425754; 
 Wed, 27 Oct 2021 00:40:25 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwZWkDuAKORXZ4Ca0jNfIO2qvGBHSFC3GfWaD+iRVxqBgt1687fz0z+viBEw4ZEKAZR7O46QQ==
X-Received: by 2002:a17:907:96a5:: with SMTP id
 hd37mr26086380ejc.423.1635320425596; 
 Wed, 27 Oct 2021 00:40:25 -0700 (PDT)
Received: from steredhat (host-79-30-88-77.retail.telecomitalia.it.
 [79.30.88.77])
 by smtp.gmail.com with ESMTPSA id f7sm12223044edl.33.2021.10.27.00.40.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 27 Oct 2021 00:40:25 -0700 (PDT)
Date: Wed, 27 Oct 2021 09:40:23 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Parav Pandit <parav@nvidia.com>
Subject: Re: [PATCH linux-next v7 4/8] vdpa: Enable user to set mac and mtu
 of vdpa device
Message-ID: <20211027074023.jt3nppb6cr3wxukf@steredhat>
References: <20211026175519.87795-1-parav@nvidia.com>
 <20211026175519.87795-5-parav@nvidia.com>
MIME-Version: 1.0
In-Reply-To: <20211026175519.87795-5-parav@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: elic@nvidia.com, mst@redhat.com, virtualization@lists.linux-foundation.org
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

On Tue, Oct 26, 2021 at 08:55:15PM +0300, Parav Pandit via Virtualization wrote:
>$ vdpa dev add name bar mgmtdev vdpasim_net mac 00:11:22:33:44:55 mtu 9000
>
>$ vdpa dev config show
>bar: mac 00:11:22:33:44:55 link up link_announce false mtu 9000
>
>$ vdpa dev config show -jp
>{
>    "config": {
>        "bar": {
>            "mac": "00:11:22:33:44:55",
>            "link ": "up",
>            "link_announce ": false,
>            "mtu": 9000,
>        }
>    }
>}
>
>Signed-off-by: Parav Pandit <parav@nvidia.com>
>Reviewed-by: Eli Cohen <elic@nvidia.com>
>Acked-by: Jason Wang <jasowang@redhat.com>
>
>---
>changelog:
>v5->v6:
> - fixed typo of device
>v4->v5:
> - added comment for checking device capabilities
>v3->v4:
> - provide config attributes during device addition time
>---
> drivers/vdpa/ifcvf/ifcvf_main.c      |  3 ++-
> drivers/vdpa/mlx5/net/mlx5_vnet.c    |  3 ++-
> drivers/vdpa/vdpa.c                  | 38 ++++++++++++++++++++++++++--
> drivers/vdpa/vdpa_sim/vdpa_sim_blk.c |  3 ++-
> drivers/vdpa/vdpa_sim/vdpa_sim_net.c |  3 ++-
> drivers/vdpa/vdpa_user/vduse_dev.c   |  3 ++-
> include/linux/vdpa.h                 | 17 ++++++++++++-
> 7 files changed, 62 insertions(+), 8 deletions(-)

Reviewed-by: Stefano Garzarella <sgarzare@redhat.com>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
