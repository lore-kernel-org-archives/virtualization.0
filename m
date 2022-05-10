Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D63ACC43217
	for <virtualization@archiver.kernel.org>; Tue, 10 May 2022 12:24:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 88AFF81DA3;
	Tue, 10 May 2022 12:24:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rrTsuQQw1Z1M; Tue, 10 May 2022 12:24:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 3C52D8186E;
	Tue, 10 May 2022 12:24:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FAA6C0032;
	Tue, 10 May 2022 12:24:02 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03821C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 12:24:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E509840144
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 12:23:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ffUEi2nRNtsN
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 12:23:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9D827400FB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 12:23:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652185437;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type;
 bh=7m17XESO0G49jDg02rMzQLZSx70dw+GOL5ZFcuicuDo=;
 b=TBBLy/alubZ89OqlFfHTKaoMvRccKoY7J9H9itFODM3llr8WVpAJyg7XWWEKf+f+xu427D
 jBlcgLyJbTYvUxBaBeaiLPBka7j2CwOKMa0A5loUBl1WPkJUgOqb/HmXYUUKAGfu2gzt+R
 0Rx4tdOmV1GqxEczDMmXynTU5LhgtQU=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-621-qdlHMfkjP2O9SXxQJwaF3w-1; Tue, 10 May 2022 08:23:56 -0400
X-MC-Unique: qdlHMfkjP2O9SXxQJwaF3w-1
Received: by mail-wr1-f70.google.com with SMTP id
 o11-20020adfca0b000000b0020adc114131so6937753wrh.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 May 2022 05:23:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
 :content-disposition;
 bh=7m17XESO0G49jDg02rMzQLZSx70dw+GOL5ZFcuicuDo=;
 b=TCFo+QTemaxRAJ3fVJ06Kx/5e7rxN7GHii4liqAWqNTpTLGniMEQ56AbLLVvrGoey/
 o5zT22C3sFVOGw6QObThAsDRP1QIPO15UpBUe4e2ZHmdO9+Gz3ywzsSAVeEcEgCzvSl5
 xHVK6u9Kt9SS7OAT30elah6Hw0YeRrnBu9ZZI1UUpWhmfLFm/tw+hh+Vv/IYj2P6Xq35
 U1Yl3ZqT0SAGE1vWEshzdIwbNXK99QAWh7HllGBszYZ7HHeI8KNtFC1On4jMRbIMlh6x
 NyCFK5GeaJAcqEC57jBkZHBWLjJYB4rqZQcxStFENJey6RgqYGY4ZGh4GOdAfea2lOe/
 68ew==
X-Gm-Message-State: AOAM531BGVwnaJLtOb9FETTFWgblJ+Jo1KmvVUzW0NOg4/ND3FvUvc/X
 HsM2gJMrUJalLvqUwvQqjCXHrdVxO6HnwevyIdREF3QlTIjVwkD0XRVkOb0twOoycDb/3YZYAEp
 sBbdGmkVPpG1otjPv7Hp1f0ayN9ZdMH4mPqgXsSPVag==
X-Received: by 2002:a05:600c:1552:b0:394:52a9:e48a with SMTP id
 f18-20020a05600c155200b0039452a9e48amr27849866wmg.45.1652185434973; 
 Tue, 10 May 2022 05:23:54 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwsBADRFdiPYDIntIzaGZobSQWMrIRqRIfrtkXtgAgFq5t+PGvub34r/lKVUbvjx0CiBVRltA==
X-Received: by 2002:a05:600c:1552:b0:394:52a9:e48a with SMTP id
 f18-20020a05600c155200b0039452a9e48amr27849841wmg.45.1652185434656; 
 Tue, 10 May 2022 05:23:54 -0700 (PDT)
Received: from redhat.com ([2.55.130.230]) by smtp.gmail.com with ESMTPSA id
 n21-20020a1c7215000000b0039489e1bbd6sm2373609wmc.47.2022.05.10.05.23.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 May 2022 05:23:54 -0700 (PDT)
Date: Tue, 10 May 2022 08:23:51 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Subject: [GIT PULL] virtio: last minute fixup
Message-ID: <20220510082351-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
X-Mutt-Fcc: =sent
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 mie@igel.co.jp
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

The following changes since commit 1c80cf031e0204fde471558ee40183695773ce13:

  vdpa: mlx5: synchronize driver status with CVQ (2022-03-30 04:18:14 -0400)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git tags/for_linus

for you to fetch changes up to 7ff960a6fe399fdcbca6159063684671ae57eee9:

  virtio: fix virtio transitional ids (2022-05-10 07:22:28 -0400)

----------------------------------------------------------------
virtio: last minute fixup

A last minute fixup of the transitional ID numbers.
Important to get these right - if users start to depend on the
wrong ones they are very hard to fix.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

----------------------------------------------------------------
Shunsuke Mie (1):
      virtio: fix virtio transitional ids

 include/uapi/linux/virtio_ids.h | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
