Return-Path: <SRS0=CXPs=PH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB33EC433F5
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 07:47:28 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4500160F9D
	for <virtualization@archiver.kernel.org>; Tue, 19 Oct 2021 07:47:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4500160F9D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0ED9B406EF;
	Tue, 19 Oct 2021 07:47:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PayaAKsTN_9i; Tue, 19 Oct 2021 07:47:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id C8982406E9;
	Tue, 19 Oct 2021 07:47:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9CF6CC000F;
	Tue, 19 Oct 2021 07:47:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 393C0C000D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 07:47:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 320D660B1A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 07:47:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=axis.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IJZjUNZfriZw
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 07:47:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtp2.axis.com (smtp2.axis.com [195.60.68.18])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DC64260AFA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 19 Oct 2021 07:47:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; q=dns/txt; s=axis-central1; t=1634629644;
 x=1666165644;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=gvQqvgRehd1oxV4E9VaOG353OV8xOewLauaUhLvPf5E=;
 b=Kkn2Ts61Tfm0TtcIUCYTcS3cGXeoJ2MMIXMjlXExf6DRCOj32iR7+7dB
 YBMuDP16Kd9O5pB0dGms15DNRrMr3vao5pPRhTZNPDIJgsIxY1bmFIYVN
 hxZMhQRWOI7jokRpnl8N08UMdSvS9U2053RQz10AjUHBgzgpd5xvy6FTm
 xp0lNaQPPqMqo1IqNu/mMIHwyty2zKY0vZAepyBQ+i+dPk0OO/MQxWIDu
 XZ+TCtX2kLUm9Puc+pNUQc9MX848OjYWYAH3IRj84FVyaV7hogsmE8SFR
 9ooS6WUgQ4Nw6UeITQJzDWvRmQTtyqRo/iumr1C60dcBgDN/HYUJI96xg g==;
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
To: <wsa@kernel.org>, <jie.deng@intel.com>, <viresh.kumar@linaro.org>
Subject: [PATCH 0/2] virtio-i2c: Fix buffer handling
Date: Tue, 19 Oct 2021 09:46:45 +0200
Message-ID: <20211019074647.19061-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Cc: linux-kernel@vger.kernel.org,
 Vincent Whitchurch <vincent.whitchurch@axis.com>, kernel@axis.com,
 linux-i2c@vger.kernel.org, virtualization@lists.linux-foundation.org
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

This fixes a couple of bugs in the buffer handling in virtio-i2c which can
result in incorrect data on the I2C bus or memory corruption in the guest.

I tested this on UML (virtio-uml needs a bug fix too, I will sent that out
later) with the device implementation in rust-vmm/vhost-device.

Vincent Whitchurch (2):
  i2c: virtio: disable timeout handling
  i2c: virtio: fix completion handling

 drivers/i2c/busses/i2c-virtio.c | 46 ++++++++++++++-------------------
 1 file changed, 19 insertions(+), 27 deletions(-)

-- 
2.28.0

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
