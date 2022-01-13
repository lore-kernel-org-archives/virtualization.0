Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B326C433EF
	for <virtualization@archiver.kernel.org>; Thu, 13 Jan 2022 07:03:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id C0FD760F38;
	Thu, 13 Jan 2022 07:03:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aIDi5izQ9Elk; Thu, 13 Jan 2022 07:03:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3EA9960BE6;
	Thu, 13 Jan 2022 07:03:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 166E8C002F;
	Thu, 13 Jan 2022 07:03:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0B24CC001E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 07:03:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D118240650
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 07:03:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XBL0px1LJqxR
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 07:03:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 33DCB40544
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Jan 2022 07:03:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642057394;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=0DzGLZtoe9PbhWfFi6edUudRLxvAzmMgAEADf3eZSOU=;
 b=edblW4d4U9S/8ypJmU0pn4ixV6/xE0FTsQALOaPXjkaW8JipWIgyUoWIFHsCdOV09Hm4BE
 6yu10x/oIedmxTPZ6aW7Em1ZEOe5wSRY3NFgtthdB1wfsekiK1Hhe8zKVNdctPJPJA5av+
 Pjdmx197Xhz9KAJ9TSewLWivapm0sHg=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-347-eOF-1-YxNt2elbA89W0rhg-1; Thu, 13 Jan 2022 02:03:11 -0500
X-MC-Unique: eOF-1-YxNt2elbA89W0rhg-1
Received: by mail-ed1-f70.google.com with SMTP id
 o20-20020a056402439400b003f83cf1e472so4462545edc.18
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 23:03:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=0DzGLZtoe9PbhWfFi6edUudRLxvAzmMgAEADf3eZSOU=;
 b=pHyxBRW7+i8ckWC6Ufy5y7J1+mhCjUp1Vv72kLAhxYFWyORkaBURRErfoYrSERcVd1
 L2QqW1mLe4mEgod7Be1yvYTi9rszWHNrp/U2Dr20dBUu9/sfqukm4n1I6Uoa7Xqh6W8C
 n7JVyUCzoKwduFsFWCFIyKZ4YxEKsL3zHHio0kHM0Gpa4v3PxWWm6VHGX2SKV3LDUdpI
 OyOTJIUuNXaER+C+LHAkg8M3quZp7tNZ1aZoZv9O2nA+MD0hELITNey5ehLrCCq7sy87
 D8gZiv29M9bO9fEA9duSFUaGJwwSc4wV9KXdBZvCarSFF5Tb4GXv+Pm2Xkyj8VzM+5sO
 w+mQ==
X-Gm-Message-State: AOAM532qSvcthEz425jHwPLQsGumq4a9xhUGxFQuZ03X2YFiqY7kEISz
 LDQ9BU4gJcQRJoLfXiXoSzKf/MwZe7ECbyTmEEBvCbZnHbr5dYKO8RDm3vp4FRycDCJQ5s9ugal
 eIm/LalX2KkugzvohkOFYMLaYyoMFDy8TZ8Y6p3BPjQ==
X-Received: by 2002:a17:907:3e96:: with SMTP id
 hs22mr2379697ejc.743.1642057390412; 
 Wed, 12 Jan 2022 23:03:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJznsrinbUvJIEnjlftNmW9HV2V6CeseH8omCCYpSfc3MmwDgsDlki7npfWSf15SeoVqHdDpHQ==
X-Received: by 2002:a17:907:3e96:: with SMTP id
 hs22mr2379688ejc.743.1642057390272; 
 Wed, 12 Jan 2022 23:03:10 -0800 (PST)
Received: from redhat.com ([2.55.6.51])
 by smtp.gmail.com with ESMTPSA id ne41sm560111ejc.121.2022.01.12.23.03.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jan 2022 23:03:09 -0800 (PST)
Date: Thu, 13 Jan 2022 02:03:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Si-Wei Liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH 0/3] fixes for mlx5_vdpa multiqueue support
Message-ID: <20220113020125-mutt-send-email-mst@kernel.org>
References: <1642050651-16197-1-git-send-email-si-wei.liu@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1642050651-16197-1-git-send-email-si-wei.liu@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lvivier@redhat.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, elic@nvidia.com
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

On Thu, Jan 13, 2022 at 12:10:48AM -0500, Si-Wei Liu wrote:
> This patchset contains the fixes for a few issues uncovered during the
> review for the "Allow for configuring max number of virtqueue pairs"
> series.
> 
> It is based on Eli's fixes:
> 2e4cda633a22 ("vdpa/mlx5: Fix tracking of current number of VQs")
> in the vhost tree.

It's really cleanups more than fixes. I'm not sure about the
code changes (the vdpa change looks ok, mlx5 ones need review
by nvidia folks) but from documentation POV this patchset needs
more work.


> 
> Si-Wei Liu (3):
>   vdpa: factor out vdpa_set_features_unlocked for vdpa internal use
>   vdpa/mlx5: set_features should nack MQ if no CTRL_VQ
>   vdpa/mlx5: validate the queue pair value from driver
> 
>  drivers/vdpa/mlx5/net/mlx5_vnet.c | 26 +++++++++++++++++++++++---
>  drivers/vdpa/vdpa.c               |  2 +-
>  drivers/vhost/vdpa.c              |  2 +-
>  drivers/virtio/virtio_vdpa.c      |  2 +-
>  include/linux/vdpa.h              | 18 ++++++++++++------
>  5 files changed, 38 insertions(+), 12 deletions(-)
> 
> -- 
> 1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
