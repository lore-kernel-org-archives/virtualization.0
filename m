Return-Path: <SRS0=ow7J=HD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-23.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FB72C433E0
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 23:26:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9619464EBD
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 23:26:06 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9619464EBD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 59132847F3;
	Mon,  1 Feb 2021 23:26:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l71pCgpEk8Cn; Mon,  1 Feb 2021 23:26:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9726D81BDC;
	Mon,  1 Feb 2021 23:26:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7A80EC0FA7;
	Mon,  1 Feb 2021 23:26:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 72870C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 23:26:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 55F6185ADB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 23:26:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id V9adxg50S00A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 23:26:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 67D11855D8
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 23:26:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612221961;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=3NlvvSEK6Q9k5kOj7hFhTGXtCazv2Lc7Wa4M2xagkr4=;
 b=HNHB0Z+Q1cb7E6bJWmoIwtEZqMfxAsTrffzvHuySKtDQUasfHfxXTq6+nc3ez0TVVNmzeM
 O9DAUpsUuAveT4GhMpFQIJfGa/rU4wr/Y+puIMrK9FvlJuSKeold8AchNrsNLO2Iu7Kctb
 9jJCPAGrpeYawEoDNYwvXIMxTdR+9GQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-307-rWHA_WdzN0yP8oRhv-wKIA-1; Mon, 01 Feb 2021 18:25:16 -0500
X-MC-Unique: rWHA_WdzN0yP8oRhv-wKIA-1
Received: by mail-wr1-f71.google.com with SMTP id x7so11346627wrp.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Feb 2021 15:25:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=3NlvvSEK6Q9k5kOj7hFhTGXtCazv2Lc7Wa4M2xagkr4=;
 b=Y0dvyK8ruWyeS6h45/ul/9T7mGoh7Ny6sfR7siE5uTYXiIQo7d3IQumaufL69wzpCF
 aK5K2JXYymzUb2/wifdXX7GCfn1IjSI5Cor4nPPi1kCMOxpaPdVqPWRWpZaf/WUgi/Nc
 Q5smsD87vBAmR50rumCeZL/xfDtSRXS/RoN68clyta5Upjv1iaA50dzzWX5hsmZjXsLz
 BXYSW6UpyWAxl4RgZ8lTp2PP45tqBEhsk1LFAqBvUBTMHkY77GFRDzYQnF4hIfoRK0YS
 nXsPWJ689lJ3uUqwRMEa/HXMhwh0BpSAp2TX/izJmIDDaNFKcwwrf2+fWMld5ElyLl9A
 sEGg==
X-Gm-Message-State: AOAM532cV68W/mO1pRjUxYXji+tVxI7JSH1WrZcDGjw7eZ2VCMPD2Ygj
 4OjLoL6Ye+A+EQZ02wSOhjB+Z/BbLwHD7ZAHpo+290p44cujH+XzqEgOo8089u90LDWxys7ZaL+
 2iO87XtohGo0r9weEhl9DBNUnHxOBlENPYODzC3WTlQ==
X-Received: by 2002:a5d:4389:: with SMTP id i9mr20449588wrq.272.1612221914695; 
 Mon, 01 Feb 2021 15:25:14 -0800 (PST)
X-Google-Smtp-Source: ABdhPJy4HJP0YlL5i0Gxd468JQgYWduTKkfVlwthOeclSr3eUKT2z3XdRpKPsU0NR9y8yC+/NJR5iA==
X-Received: by 2002:a5d:4389:: with SMTP id i9mr20449577wrq.272.1612221914513; 
 Mon, 01 Feb 2021 15:25:14 -0800 (PST)
Received: from redhat.com (bzq-79-177-39-148.red.bezeqint.net. [79.177.39.148])
 by smtp.gmail.com with ESMTPSA id z15sm27405334wrs.25.2021.02.01.15.25.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Feb 2021 15:25:13 -0800 (PST)
Date: Mon, 1 Feb 2021 18:25:10 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] vdpa: bugfix
Message-ID: <20210201182510-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 elic@nvidia.com
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

The following changes since commit 19c329f6808995b142b3966301f217c831e7cf31:

  Linux 5.11-rc4 (2021-01-17 16:37:05 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 710eb8e32d04714452759f2b66884bfa7e97d495:

  vdpa/mlx5: Fix memory key MTT population (2021-01-20 03:47:04 -0500)

----------------------------------------------------------------
vdpa: bugfix

A single mlx bugfix.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Eli Cohen (1):
      vdpa/mlx5: Fix memory key MTT population

 drivers/vdpa/mlx5/core/mlx5_vdpa.h |  1 +
 drivers/vdpa/mlx5/core/mr.c        | 28 ++++++++++++----------------
 2 files changed, 13 insertions(+), 16 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
