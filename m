Return-Path: <SRS0=Keeg=BP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57B11C433DF
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:43:43 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B0142065C
	for <virtualization@archiver.kernel.org>; Wed,  5 Aug 2020 13:43:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="h+jz6ZSH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2B0142065C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 080A18499E;
	Wed,  5 Aug 2020 13:43:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nL2OKXWQ2VIx; Wed,  5 Aug 2020 13:43:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 42DF484C16;
	Wed,  5 Aug 2020 13:43:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 23EBCC088E;
	Wed,  5 Aug 2020 13:43:42 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BD49C004C
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 0B8F388137
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GupQjQqTp4W9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [205.139.110.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 4D538880B3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Aug 2020 13:43:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596635019;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=uT4MZK/WmjMO9Hf3gYa75MOY3iZoVd/8WD7Av4sgX3M=;
 b=h+jz6ZSH+czroiJLnTM9hDxLyi9GwK/Wqbb9VnhzSDqtoKimmjAafraEK973Fxg7aOUqEy
 nZWT+wi1fM1x3PXRjwkodfN6Q+mZeiVryMb54VRwtQ6ojwFK6zaznNvXCWczF2wgNPdKhS
 dQnLHScPO3qMrBr0Ri6BiokmUKIAJ20=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-154-fXocm7OdP7GUc75jeu3ITA-1; Wed, 05 Aug 2020 09:43:37 -0400
X-MC-Unique: fXocm7OdP7GUc75jeu3ITA-1
Received: by mail-wm1-f70.google.com with SMTP id d22so2749433wmd.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 06:43:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=uT4MZK/WmjMO9Hf3gYa75MOY3iZoVd/8WD7Av4sgX3M=;
 b=VnYngTfBR22uvVgx6Q+prmPgBySB3u7QukhtS6CbEvC3vNUM5gy4+ezENUUhbFeosF
 Mlptmxr+aM037UYZGz1UhZzjJbWOcKiSlJMdQ8lAm05kTL6wTW7grbPj636LoIQyFsHc
 heIIn7FPYenJIgWuOLs0qY5SgcTvy67dCfavr1RVNwf6K89tU7sA38OOQgpDG4L/QMQM
 eA2XZs/XUyOvfQ2lY9icLC3nAgcWFoIzn0HN7WditIkHKWZnPm+BX0d3GHEVuOC1EoDa
 PfDUj0b+y2SPGE3JMfUWICfl82xl4eeEVygkDbbZck53uiFB2vlTjrPNkvyX9lYNU8sF
 BEEw==
X-Gm-Message-State: AOAM532itSVY3vNWuCfJk87P1coIJvI+Ro6zhz6+oo+XiVRbr9AFmcmc
 3p76nS1vtX/LBNf/CjWgx27gEdinEnxw1gRK8FBoFP2rHozNoYy4Bud7R3ivZF812q6A+6tA8Hw
 ydaEaT0QeDzIu7Q1v4HWXidkVT1DArZZ3jwEGRCD+AQ==
X-Received: by 2002:adf:b302:: with SMTP id j2mr2859688wrd.294.1596635016392; 
 Wed, 05 Aug 2020 06:43:36 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzITs/miouKXFVmBFtcFlH4aNnnt5FWqtlGH9JkX5pGWDGOgygL5Olr/ps3r5ZDSsC1a6fhYg==
X-Received: by 2002:adf:b302:: with SMTP id j2mr2859668wrd.294.1596635016220; 
 Wed, 05 Aug 2020 06:43:36 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id z15sm2842664wrn.89.2020.08.05.06.43.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 06:43:35 -0700 (PDT)
Date: Wed, 5 Aug 2020 09:43:33 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v3 07/38] virtio_console: correct tags for config space fields
Message-ID: <20200805134226.1106164-8-mst@redhat.com>
References: <20200805134226.1106164-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200805134226.1106164-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Cornelia Huck <cohuck@redhat.com>,
 virtualization@lists.linux-foundation.org, Amit Shah <amit@kernel.org>
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

Tag config space fields as having virtio endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
Reviewed-by: Cornelia Huck <cohuck@redhat.com>
---
 include/uapi/linux/virtio_console.h | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/virtio_console.h b/include/uapi/linux/virtio_console.h
index b7fb108c9310..7e6ec2ff0560 100644
--- a/include/uapi/linux/virtio_console.h
+++ b/include/uapi/linux/virtio_console.h
@@ -45,13 +45,13 @@
 
 struct virtio_console_config {
 	/* colums of the screens */
-	__u16 cols;
+	__virtio16 cols;
 	/* rows of the screens */
-	__u16 rows;
+	__virtio16 rows;
 	/* max. number of ports this device can hold */
-	__u32 max_nr_ports;
+	__virtio32 max_nr_ports;
 	/* emergency write register */
-	__u32 emerg_wr;
+	__virtio32 emerg_wr;
 } __attribute__((packed));
 
 /*
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
