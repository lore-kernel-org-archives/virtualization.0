Return-Path: <SRS0=DI2N=FG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82604C64E90
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 11:52:01 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C22D22086A
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 11:52:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C22D22086A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id DC8812E225;
	Wed,  2 Dec 2020 11:51:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fwu1CcapRxof; Wed,  2 Dec 2020 11:51:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 8A2212E1AE;
	Wed,  2 Dec 2020 11:51:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7B291C0859;
	Wed,  2 Dec 2020 11:51:58 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7680CC0052
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 11:51:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 716FE86D22
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 11:51:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DtSKRXM5udMD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 11:51:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 7E1D686BBD
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 11:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606909913;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=eZnLI0Wik0eaxTfaNNAVKLQ21xyT2CoTcJpXnx1wngM=;
 b=DYE1A+98W3tnn2+7c23MG14A46HKHLzE2JcPnrB1IW8NYOX7J7eNvmgx2NmXGjfkVQvf0z
 rHexVr8IHFOHwPcjEO5rzYKyq1XN5xBvqS9Yx3rn1jx5szxr/3/lY0xLcVTYzZe0pek1Fm
 Ni5YTJmJNLMoqg5mTcHn52KN7uRR53g=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-565-rTC63_yeMGqFQVHzocY_AA-1; Wed, 02 Dec 2020 06:51:52 -0500
X-MC-Unique: rTC63_yeMGqFQVHzocY_AA-1
Received: by mail-wr1-f70.google.com with SMTP id 91so3462717wrk.17
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Dec 2020 03:51:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=eZnLI0Wik0eaxTfaNNAVKLQ21xyT2CoTcJpXnx1wngM=;
 b=gCu5vry6ekZf1KtANhq8S3yJObVRDJeY1vomfkx9WaKOdyr5hjVLdkyi30RbDfKpPy
 5sPjNwehdOi6PAlxaJotvJ7XHOaY2Q8+Bg7t3LDvm/8S67C382wKt+IcXBuIM94bGJtB
 tMnLLPVZwYAADpajn/2wDItK9NJvXMq0irlMBOptM/sMupDxHMuZN2Scs8j5dyKp13Sm
 p58Acn0HvwG2i3/HybhokcjSxqni1PP7n4boGU6onpjWF5FMsZz2qA2MvjjS8aA7HlS9
 HL3V/LQIVb7HNZt4sFAFRWlMVZoXn0N+0bk09/uN292sD8Ww42puXHo5X5eG5FLD3/0z
 t+uw==
X-Gm-Message-State: AOAM530r1ixC4jv9bTOz9v5/FYpnnJzGFNKzmThN7HDmgxLe43wJDy6P
 avbOivxeCC/yHcC4JI9351a4dEae5BJ9fZEOP7DW76z45RPD0oiU2tZXOHwC6bJYKwe/yhaUHlO
 ymdcROcbLmwFrAizSSy3DbkzJzP7ATud6b+M4hwDC3Q==
X-Received: by 2002:a05:600c:2106:: with SMTP id
 u6mr1002274wml.4.1606909911246; 
 Wed, 02 Dec 2020 03:51:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyDk/79fb5VUyBoaUX2SQVUTrvAjsll90UI65W+kVpuHWCvrrBFwGplb9GAKNlrMm4UMxEqKg==
X-Received: by 2002:a05:600c:2106:: with SMTP id
 u6mr1002258wml.4.1606909911075; 
 Wed, 02 Dec 2020 03:51:51 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
 by smtp.gmail.com with ESMTPSA id f7sm1766312wmc.1.2020.12.02.03.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Dec 2020 03:51:50 -0800 (PST)
Date: Wed, 2 Dec 2020 06:51:47 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] vdpa: last minute bugfixes
Message-ID: <20201202065147-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lkp@intel.com, kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eli@mellanox.com, leonro@nvidia.com,
 saeedm@nvidia.com, dan.carpenter@oracle.com, parav@mellanox.com
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

A couple of patches of the obviously correct variety.

The following changes since commit ad89653f79f1882d55d9df76c9b2b94f008c4e27:

  vhost-vdpa: fix page pinning leakage in error path (rework) (2020-11-25 04:29:07 -0500)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 2c602741b51daa12f8457f222ce9ce9c4825d067:

  vhost_vdpa: return -EFAULT if copy_to_user() fails (2020-12-02 04:36:40 -0500)

----------------------------------------------------------------
vdpa: last minute bugfixes

A couple of fixes that surfaced at the last minute.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Dan Carpenter (1):
      vhost_vdpa: return -EFAULT if copy_to_user() fails

Randy Dunlap (1):
      vdpa: mlx5: fix vdpa/vhost dependencies

 drivers/Makefile     | 1 +
 drivers/vdpa/Kconfig | 1 +
 drivers/vhost/vdpa.c | 4 +++-
 3 files changed, 5 insertions(+), 1 deletion(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
