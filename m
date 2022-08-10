Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EEEDCC25B08
	for <virtualization@archiver.kernel.org>; Wed, 10 Aug 2022 09:43:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 75F9D4028F;
	Wed, 10 Aug 2022 09:43:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 75F9D4028F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BDL8blns
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sJbHeRH453-o; Wed, 10 Aug 2022 09:43:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A8D4140288;
	Wed, 10 Aug 2022 09:43:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A8D4140288
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4C31BC0033;
	Wed, 10 Aug 2022 09:43:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CA0EDC002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:43:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9795760B8F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:43:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9795760B8F
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BDL8blns
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wjlwDyJoruOx
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:43:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9557E60ACA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9557E60ACA
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 09:43:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1660124632;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=VtlaRizDRVz5xKTGkF8JZcC+vIs+0Z48fSCCTWvcw2I=;
 b=BDL8blnsdBMBfsHE1BNpEK6s1+Y4D96ijKBCka9yZSScdY8l6SEwhvxsihf7sdxLKGA5wH
 rEq2YL7F79VGBDKYKg97qw6QNvevi3c05S2gCKaH4hnPYOh6auoesI4hk2LjGpduFDxDnP
 kWLxtXjyMCj6LXIkIoXPgL+Orn+q7ak=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-124-1ERPLiCqNwWe9enRnBbhhA-1; Wed, 10 Aug 2022 05:43:51 -0400
X-MC-Unique: 1ERPLiCqNwWe9enRnBbhhA-1
Received: by mail-wm1-f70.google.com with SMTP id
 b16-20020a05600c4e1000b003a5a47762c3so1428146wmq.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Aug 2022 02:43:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-message-state:from:to:cc;
 bh=VtlaRizDRVz5xKTGkF8JZcC+vIs+0Z48fSCCTWvcw2I=;
 b=hmhzSHvbxSokm9jmipYCpzYes/LC1r2lduJyd59kWsLpbTIW826eBMSYeEN6zbQZ7u
 q02sQmBlC9um/Pp44cakXDNeWyzL3Z0lkJI3h4IoEuK465miUyXSWAOx3ZWjQdsk9+Do
 36S0s589WxNZlgRYFH76eiH23oALYrFG0E7MvDsHAg9f7WFeTuXIYMWOLjoKCesRWa5i
 03bfrUgYQkFdpNVH20TKVJMYcTuLsGV4jhXqQ9aQuAi8cyQpy6RVxXZAqoHY6Bin2EKi
 tRf6/hebskhLLznaRYnwY2SafENim07nTq0iCns/zr7brPjYMQ27cHIL6lseDbq+SZjU
 4IAQ==
X-Gm-Message-State: ACgBeo06ARqKD/TZ7kWXYQ8nGpq5JkpjfM4AZMkbQYbbzNiRheUY/HX3
 eKNyEDiO0aFN7oQn+/HEgQCyNbeA8P2lO29cK4cUJ/dYRFyrbgekKG2vLAP53McrTgYlOYbhqut
 Tq6BM8GSkpW9swTkicDrIRR8uuT3UHJhvQ2BYAeKkGLBKPbsCdklFi7PMTvwIf8H1nmn2gI68gd
 rOkOGhnolFQPZjPSqbmg==
X-Received: by 2002:a05:600c:4f44:b0:3a5:6de3:8375 with SMTP id
 m4-20020a05600c4f4400b003a56de38375mr1815829wmq.198.1660124630068; 
 Wed, 10 Aug 2022 02:43:50 -0700 (PDT)
X-Google-Smtp-Source: AA6agR73NTIQcHhhjgyT7WWLXo220NhOzmLOYriyW/7ugDFMDAUT4z9ZA6kWovCQgVfIpay4scizNQ==
X-Received: by 2002:a05:600c:4f44:b0:3a5:6de3:8375 with SMTP id
 m4-20020a05600c4f4400b003a56de38375mr1815803wmq.198.1660124629773; 
 Wed, 10 Aug 2022 02:43:49 -0700 (PDT)
Received: from step1.redhat.com (host-79-46-200-178.retail.telecomitalia.it.
 [79.46.200.178]) by smtp.gmail.com with ESMTPSA id
 q11-20020a5d658b000000b0021e4bc9edbfsm12921743wru.112.2022.08.10.02.43.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Aug 2022 02:43:49 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2 0/4] vdpa_sim_blk: add support for flush, discard,
 and write-zeroes
Date: Wed, 10 Aug 2022 11:43:43 +0200
Message-Id: <20220810094347.20449-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.37.1
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
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

The first 2 patches are in preparation and generalize parts later used
by the following patches that add handling of flush, discard, and
write-zeroes requests.

v2:
- rebased on https://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git
- used dev_dbg() to print errors [Jason]
- moved sector to be 0 checking to another patch and generalized for
  other requests
- modified vdpasim_blk_check_range() to be used also with discard and
  write-zeroes
- added discard and write-zeroes requests handling

v1: https://lore.kernel.org/virtualization/20220428151242.213824-1-sgarzare@redhat.com/

Tree available here:
https://gitlab.com/sgarzarella/linux.git vdpa-sim-blk-flush-discard-wz

Thanks,
Stefano

Stefano Garzarella (4):
  vdpa_sim_blk: check if sector is 0 for commands other than read or
    write
  vdpa_sim_blk: make vdpasim_blk_check_range usable by other requests
  vdpa_sim_blk: add support for VIRTIO_BLK_T_FLUSH
  vdpa_sim_blk: add support for discard and write-zeroes

 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 127 +++++++++++++++++++++++----
 1 file changed, 111 insertions(+), 16 deletions(-)

-- 
2.37.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
