Return-Path: <SRS0=mw09=HS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4105EC433DB
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 09:45:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF69A64DDA
	for <virtualization@archiver.kernel.org>; Tue, 16 Feb 2021 09:45:14 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF69A64DDA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 555108679D;
	Tue, 16 Feb 2021 09:45:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Fv1s5jiGSA8A; Tue, 16 Feb 2021 09:45:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 3ED9B8670A;
	Tue, 16 Feb 2021 09:45:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 031C4C0893;
	Tue, 16 Feb 2021 09:45:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 81392C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 09:45:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6C25E6F4E4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 09:45:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id M6utgiaFT7jM
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 09:45:10 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
 id 513436F4C8; Tue, 16 Feb 2021 09:45:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B3AAC6F4E4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Feb 2021 09:45:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613468707;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=wcnd7ClbZgShooWszPEgOAqPp+c33seC7pun/tamuzE=;
 b=hti9g678GWwU23gGIDts/48Kubo5NXXl/1cT/UQlemoHVxp53DCzgmQGQCCE87GwvSFwPS
 Cs8EulP2Q30rGhWDNW6kOAAt895hwf2nOUH7HC7eJE4iYn5gTIMkfrLDVqHO0/Yo+RSGXv
 Cg7a34t/6+mDLNMvOdrsvlV5u2K3RHc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-474-MA4WhP80O1ixGB_T6ZurCA-1; Tue, 16 Feb 2021 04:45:04 -0500
X-MC-Unique: MA4WhP80O1ixGB_T6ZurCA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0CD6A801998;
 Tue, 16 Feb 2021 09:45:03 +0000 (UTC)
Received: from steredhat.redhat.com (ovpn-113-212.ams2.redhat.com
 [10.36.113.212])
 by smtp.corp.redhat.com (Postfix) with ESMTP id E7BD15D9C0;
 Tue, 16 Feb 2021 09:44:55 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [RFC PATCH 00/10] vdpa: get/set_config() rework
Date: Tue, 16 Feb 2021 10:44:44 +0100
Message-Id: <20210216094454.82106-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

Following the discussion with Michael and Jason [1], I reworked a bit
get/set_config() in vdpa.

I changed vdpa_get_config() to check the boundaries and added vdpa_set_config().
When 'offset' or 'len' parameters exceed boundaries, we limit the reading to
the available configuration space in the device, and we return the amount of
bytes read/written.

In this way the user space can pass buffers bigger than config space.
I also returned the amount of bytes read and written to user space.

Patches also available here:
https://github.com/stefano-garzarella/linux/tree/vdpa-get-set-config-refactoring

Thanks for your comments,
Stefano

[1] https://lkml.org/lkml/2021/2/10/350

Stefano Garzarella (10):
  vdpa: add get_config_size callback in vdpa_config_ops
  vdpa: check vdpa_get_config() parameters and return bytes read
  vdpa: add vdpa_set_config() helper
  vdpa: remove param checks in the get/set_config callbacks
  vdpa: remove WARN_ON() in the get/set_config callbacks
  virtio_vdpa: use vdpa_set_config()
  vhost/vdpa: use vdpa_set_config()
  vhost/vdpa: allow user space to pass buffers bigger than config space
  vhost/vdpa: use get_config_size callback in
    vhost_vdpa_config_validate()
  vhost/vdpa: return configuration bytes read and written to user space

 include/linux/vdpa.h              | 22 ++++-------
 drivers/vdpa/ifcvf/ifcvf_base.c   |  3 +-
 drivers/vdpa/ifcvf/ifcvf_main.c   |  8 +++-
 drivers/vdpa/mlx5/net/mlx5_vnet.c |  9 ++++-
 drivers/vdpa/vdpa.c               | 51 ++++++++++++++++++++++++
 drivers/vdpa/vdpa_sim/vdpa_sim.c  | 15 +++++---
 drivers/vhost/vdpa.c              | 64 ++++++++++++++++---------------
 drivers/virtio/virtio_vdpa.c      |  3 +-
 8 files changed, 116 insertions(+), 59 deletions(-)

-- 
2.29.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
