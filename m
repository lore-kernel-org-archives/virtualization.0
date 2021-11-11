Return-Path: <SRS0=fJjx=P6=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DE4C433EF
	for <virtualization@archiver.kernel.org>; Thu, 11 Nov 2021 16:04:27 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0201160EE4
	for <virtualization@archiver.kernel.org>; Thu, 11 Nov 2021 16:04:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 0201160EE4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=axis.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id AFBC54050D;
	Thu, 11 Nov 2021 16:04:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KQxtvbfVZ8h3; Thu, 11 Nov 2021 16:04:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 780884050B;
	Thu, 11 Nov 2021 16:04:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 632A2C0020;
	Thu, 11 Nov 2021 16:04:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BAECDC001E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 16:04:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 9B51F4050D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 16:04:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b0yUWQcZ7WKR
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 16:04:20 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtp1.axis.com (smtp1.axis.com [195.60.68.17])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 56AA5404DA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Nov 2021 16:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=axis.com; q=dns/txt; s=axis-central1; t=1636646661;
 x=1668182661;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=11EZ2ZPkaqpcts1rfIERfLSJBeembwtvoHHKNE3fh48=;
 b=eiwwqjL+XHUMatq336YAPPvMIdFVKPCtqi346hIsgz8KZUVBfcKgexbJ
 tZKQnxrpG+uDwk5ZSI3L/lFfmVKKPvKvoTxg0mH7BvDr7hi00WTr2LYTb
 NZON6wF1/Hb1YIKkXNF66u7Uj39oKDSUb0Ew6PNiO/2Lz5Idda0jxZLlM
 sRDRey4yM7NFUwZHoDAo+v9Gh4XOOPIxieShMUIzVRZolG3cuW1NTzFD3
 H01VNb2mLDqYr8pRDLzkZM4ZB8SMlQOVi4GjiE4DtTyvxGXzN/KozXfWx
 ufT6bVHnR7JzBEq0CmVIaOW5kUIAK98kCz7wZyoxCVO4ltqMCPCIFRlkS w==;
From: Vincent Whitchurch <vincent.whitchurch@axis.com>
To: <wsa@kernel.org>, <jie.deng@intel.com>, <viresh.kumar@linaro.org>
Subject: [PATCH v2 0/2] virtio-i2c: Fix buffer handling
Date: Thu, 11 Nov 2021 17:04:10 +0100
Message-ID: <20211111160412.11980-1-vincent.whitchurch@axis.com>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Cc: mst@redhat.com, Vincent Whitchurch <vincent.whitchurch@axis.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 kernel@axis.com, linux-i2c@vger.kernel.org, conghui.chen@intel.com
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

Changes in v2:
- Added Acked-by and Fixes tags

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
