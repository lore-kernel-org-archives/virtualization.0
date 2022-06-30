Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E6779C433EF
	for <virtualization@archiver.kernel.org>; Thu, 30 Jun 2022 15:32:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7088F81A6F;
	Thu, 30 Jun 2022 15:32:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7088F81A6F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AfSoszMs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v1QrdNIbwxSJ; Thu, 30 Jun 2022 15:32:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DE11681A24;
	Thu, 30 Jun 2022 15:32:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DE11681A24
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9FAFAC002D;
	Thu, 30 Jun 2022 15:32:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 428EFC0011
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 15:32:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1C38E60F31
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 15:32:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1C38E60F31
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AfSoszMs
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7s1_o_M0wwPx
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 15:32:30 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1C3F660B02
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1C3F660B02
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 15:32:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656603148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=pcmUWHwjNzcwYP1ffPOW41Lm6XhO65tP5GIsXRO8MKU=;
 b=AfSoszMsonUBL+3f2HBAoMC+Lu+s9SqByGxxxzkPGLHekMX+bOjbs3aW78DZY37tM/4qfT
 KOJYwLiHeJef/PGtTQXUlSrfVj90+vLhPAkq05QplW+kXj9OB/dHYw7bhR8gb0zdo5TdD1
 hLVEHog5wjtGulSOfc4NpZHbo2HCU1I=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-88-IeQ0FaoqOYeeUpIhIKps_g-1; Thu, 30 Jun 2022 11:32:27 -0400
X-MC-Unique: IeQ0FaoqOYeeUpIhIKps_g-1
Received: by mail-qv1-f71.google.com with SMTP id
 mr11-20020a056214348b00b004705c0cb439so18778786qvb.19
 for <virtualization@lists.linux-foundation.org>;
 Thu, 30 Jun 2022 08:32:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=pcmUWHwjNzcwYP1ffPOW41Lm6XhO65tP5GIsXRO8MKU=;
 b=UjQwj7Q9DTU75zljEGA8ZIksnP7ZKreS5k2X4MLgqgq0enx5nMbW8V08YrCjyAH8F8
 V4FCbPya76jVmvFxyfozdBBNaYvQEJZXsAJOexVcYEn/TWgiy9Rkgp1cHYfP1/T3ftoK
 DAmSxHXKn25gQFXlxeXt8o7PWHS30SltjTEknwi9wXu6GLjzWbrplxo7pO+DenffH/9k
 3dkyK8vLTJ0/Gc/5Q6HWk3WJWzr1y6UkNlr7lZFASkSadTfYmfMiebbvQjzjJoHD5iCu
 AqrFBZSnazY+Sms+j+jVBDYshtfQ1lHA3BVGl8aAYX5VzlLauv0EYl7oLLTlYgdwXJ5l
 gOJg==
X-Gm-Message-State: AJIora+WNkK/GaFr2oKHw0GZmArlY+nJFO/n4qnHvMogDVgI26b/tkTx
 COP9M8SnxkMULfbHwjoicyrwLaZinwKyqks4yr6FNciMmWWEjrJY1/cUjRl7VXrvlg04An2SO9z
 nvhmy8MYs6Ifo159L4DTafDwwwktCIQWlwF7HA+PO98RQZgtnBhj5Djh2c4oMbJ0Quh2fnhobRH
 r1XCFkUel5P9Bpv+ZMIQ==
X-Received: by 2002:a05:620a:8018:b0:6af:1fee:41ac with SMTP id
 ee24-20020a05620a801800b006af1fee41acmr6695922qkb.476.1656603146815; 
 Thu, 30 Jun 2022 08:32:26 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vkIc7TNQUd9dH7P1QOC596mqRPfmhoP8IEwy11rq536OjOmrdmPduBteJuiTGuWl5OEDH/Ag==
X-Received: by 2002:a05:620a:8018:b0:6af:1fee:41ac with SMTP id
 ee24-20020a05620a801800b006af1fee41acmr6695886qkb.476.1656603146450; 
 Thu, 30 Jun 2022 08:32:26 -0700 (PDT)
Received: from step1.redhat.com (host-87-11-6-149.retail.telecomitalia.it.
 [87.11.6.149]) by smtp.gmail.com with ESMTPSA id
 y20-20020a05620a44d400b006af0639f7casm16089325qkp.12.2022.06.30.08.32.24
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 30 Jun 2022 08:32:25 -0700 (PDT)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2 0/3] vdpa_sim_blk: several fixes for the vDPA block
 simulator
Date: Thu, 30 Jun 2022 17:32:18 +0200
Message-Id: <20220630153221.83371-1-sgarzare@redhat.com>
X-Mailer: git-send-email 2.36.1
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
 linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
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

v2:
- Patch 2: restored previous behaviour, exiting the loop immediately if the
  request is malformed [Jason]
- Added Jason's A-b In patch 1 and 3

v1: https://lore.kernel.org/virtualization/20220621160859.196646-1-sgarzare@redhat.com/

The first two patches essentially limit the possibility of the guest
doing a DoS to the host.

The third makes the simulator more correct (following what we do in
vdpa_sim_net) by calling vringh_complete_iotlb() in the error path as well.

Stefano Garzarella (3):
  vdpa_sim_blk: use dev_dbg() to print errors
  vdpa_sim_blk: limit the number of request handled per batch
  vdpa_sim_blk: call vringh_complete_iotlb() also in the error path

 drivers/vdpa/vdpa_sim/vdpa_sim_blk.c | 44 ++++++++++++++++++----------
 1 file changed, 29 insertions(+), 15 deletions(-)

-- 
2.36.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
