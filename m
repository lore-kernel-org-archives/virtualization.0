Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80B77C433F5
	for <virtualization@archiver.kernel.org>; Fri, 26 Nov 2021 16:48:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 03521400C8;
	Fri, 26 Nov 2021 16:48:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RRAvduktmEKG; Fri, 26 Nov 2021 16:48:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CAAEB40004;
	Fri, 26 Nov 2021 16:48:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9485CC001E;
	Fri, 26 Nov 2021 16:48:10 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BCEB7C0012
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 16:48:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id A517D607AF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 16:48:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sDz89qKCAWE3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 16:48:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B7C21605CC
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 16:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637945287;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding;
 bh=Grbamj1Ui2RVl3b5MpDYwaWCz8FlCD80yhTd0RjsQF4=;
 b=XsxaeGhZr6sIrQc6wTPI8LeYrxyKpAOeAJ0YTA4Aydb0rLrr6RDUz9B7lMbir4f8F4wHNQ
 kFNJ7RK1ROlhJJTdx2FL17imWn9eLOjZiQgCONNKNCn23Bm+GgxFtSN7tLJZ55sNsGB1ZF
 mn9cq7k8wLqOQWoyFja4bBOiov5utsM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-348-CQIPzT1JN5O5Ca3KNBBfGA-1; Fri, 26 Nov 2021 11:48:02 -0500
X-MC-Unique: CQIPzT1JN5O5Ca3KNBBfGA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 521EE819015;
 Fri, 26 Nov 2021 16:48:01 +0000 (UTC)
Received: from steredhat.redhat.com (unknown [10.39.193.110])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D0866604CC;
 Fri, 26 Nov 2021 16:47:54 +0000 (UTC)
From: Stefano Garzarella <sgarzare@redhat.com>
To: virtualization@lists.linux-foundation.org
Subject: [PATCH v2 0/2] vdpa: add driver_override support and sysfs ABI
 documentation
Date: Fri, 26 Nov 2021 17:47:51 +0100
Message-Id: <20211126164753.181829-1-sgarzare@redhat.com>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
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

The first patch adds missing documentation of sysfs ABI for vDPA bus
and the second adds driver_override support (the code is the same of v1,
so I left Jason A-b tag).

v2:
- added preliminary commit to document pre-existing sysfs ABI for vDPA bus
- added `driver_override` documentation in Documentation/ABI/testing/sysfs-bus-vdpa

v1: https://lore.kernel.org/virtualization/20211104161729.258294-1-sgarzare@redhat.com/

Thanks,
Stefano

Stefano Garzarella (2):
  docs: document sysfs ABI for vDPA bus
  vdpa: add driver_override support

 include/linux/vdpa.h                     |  2 +
 drivers/vdpa/vdpa.c                      | 74 ++++++++++++++++++++++++
 Documentation/ABI/testing/sysfs-bus-vdpa | 57 ++++++++++++++++++
 MAINTAINERS                              |  1 +
 4 files changed, 134 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-bus-vdpa

-- 
2.31.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
