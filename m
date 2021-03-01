Return-Path: <SRS0=COaL=H7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DC1F3C433E0
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 08:17:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7D54964DB2
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 08:17:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7D54964DB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 306F083D6A;
	Mon,  1 Mar 2021 08:17:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mipbZ-yoQ4sx; Mon,  1 Mar 2021 08:17:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id A820B83B9D;
	Mon,  1 Mar 2021 08:17:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A89FC000A;
	Mon,  1 Mar 2021 08:17:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E6CB7C0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 08:17:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C764160675
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 08:17:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6420B2YuXdgw
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 08:17:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id BE39760600
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 08:17:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614586661;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=tKTcoC9836gUjKa05XhBkB41/zp/zhab93GjDyMxI/c=;
 b=Afq8mdDhCN5IuOEbajgUZ+n9bvrVQIMIVocWqQKMEB+TKkqIzZWK6XobEgWoR8Pg/HZcEC
 6Lj3LRaDR3cFtqgO7Dk2IgvyBuz6jcF964sQSbLnlkHkCw24R0v+t67sPywH3++Mrwp87j
 J/7oSmTuQJwO6nOoIbj1ahApmpRrF5I=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-45-rBSO-49lPB-4VemPNF4pMg-1; Mon, 01 Mar 2021 03:17:33 -0500
X-MC-Unique: rBSO-49lPB-4VemPNF4pMg-1
Received: by mail-ed1-f69.google.com with SMTP id t18so8335906edr.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Mar 2021 00:17:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=tKTcoC9836gUjKa05XhBkB41/zp/zhab93GjDyMxI/c=;
 b=TUPQ6AhneP6lXiwfT1Fu6w/15MSPF97msIWTstATaMbRA9vpvBJuh/nbSFBIccoZd0
 mJCqWtW9l/pz3I0LooTCvmKdzgYE7rjkKeGL+Nek0HleCdNphwfFlZfqzUD/dSC3mgTz
 ONVSF8UG4MV7FPHDO55xQ8IBcEzJDSGu3jZWu3ktbiYrlyVdqqwAPOsWChBq2f/qiG2G
 n3og2EVGgL+e4z3HHuVq6GO2tC17eJ25Zl8AUxVpVy0e/gXfBHyTTPmoBAhcrt7YhyF3
 JORqgI7+ZI9fyGJFjjEpTNmt/GmCB4/X6hVd5uyMroe7MXxN6p98Np9m9LIyxGPQTV5F
 oHxw==
X-Gm-Message-State: AOAM5325M+/gMRIAX7P7DgsaLf0kchUKFeLs/eFPi2XxxRJjT5Ud/jca
 aDIpz9z23U6WuNpPgkZ0lKYGYRoFMRDhidAOsRSHHFvUeblmn0SPo10nWqCuKRrnae7HFCaRyL1
 1pAaWjBdJeT3uwybrroXKShf6HYdeEmLius8NVskzjw==
X-Received: by 2002:a17:907:9863:: with SMTP id
 ko3mr4754992ejc.543.1614586652778; 
 Mon, 01 Mar 2021 00:17:32 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwOJQF4XmlN9Kj2YNp2sgq/OJTqRNjmmF1UykY+KaTBK5B08lVVp1Se9T8pnZHi1l/9eMb5kg==
X-Received: by 2002:a17:907:9863:: with SMTP id
 ko3mr4754977ejc.543.1614586652538; 
 Mon, 01 Mar 2021 00:17:32 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id 35sm14542379edp.85.2021.03.01.00.17.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Mar 2021 00:17:32 -0800 (PST)
Date: Mon, 1 Mar 2021 09:17:30 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH 00/10] vdpa: get/set_config() rework
Message-ID: <20210301081730.45cqbq7s6fbrdkhw@steredhat>
References: <20210216094454.82106-1-sgarzare@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20210216094454.82106-1-sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

nice ping :-)

On Tue, Feb 16, 2021 at 10:44:44AM +0100, Stefano Garzarella wrote:
>Following the discussion with Michael and Jason [1], I reworked a bit
>get/set_config() in vdpa.
>
>I changed vdpa_get_config() to check the boundaries and added vdpa_set_config().
>When 'offset' or 'len' parameters exceed boundaries, we limit the reading to
>the available configuration space in the device, and we return the amount of
>bytes read/written.
>
>In this way the user space can pass buffers bigger than config space.
>I also returned the amount of bytes read and written to user space.
>
>Patches also available here:
>https://github.com/stefano-garzarella/linux/tree/vdpa-get-set-config-refactoring
>
>Thanks for your comments,
>Stefano
>
>[1] https://lkml.org/lkml/2021/2/10/350
>
>Stefano Garzarella (10):
>  vdpa: add get_config_size callback in vdpa_config_ops
>  vdpa: check vdpa_get_config() parameters and return bytes read
>  vdpa: add vdpa_set_config() helper
>  vdpa: remove param checks in the get/set_config callbacks
>  vdpa: remove WARN_ON() in the get/set_config callbacks
>  virtio_vdpa: use vdpa_set_config()
>  vhost/vdpa: use vdpa_set_config()
>  vhost/vdpa: allow user space to pass buffers bigger than config space
>  vhost/vdpa: use get_config_size callback in
>    vhost_vdpa_config_validate()
>  vhost/vdpa: return configuration bytes read and written to user space
>
> include/linux/vdpa.h              | 22 ++++-------
> drivers/vdpa/ifcvf/ifcvf_base.c   |  3 +-
> drivers/vdpa/ifcvf/ifcvf_main.c   |  8 +++-
> drivers/vdpa/mlx5/net/mlx5_vnet.c |  9 ++++-
> drivers/vdpa/vdpa.c               | 51 ++++++++++++++++++++++++
> drivers/vdpa/vdpa_sim/vdpa_sim.c  | 15 +++++---
> drivers/vhost/vdpa.c              | 64 ++++++++++++++++---------------
> drivers/virtio/virtio_vdpa.c      |  3 +-
> 8 files changed, 116 insertions(+), 59 deletions(-)
>
>-- 
>2.29.2
>
>_______________________________________________
>Virtualization mailing list
>Virtualization@lists.linux-foundation.org
>https://lists.linuxfoundation.org/mailman/listinfo/virtualization
>

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
