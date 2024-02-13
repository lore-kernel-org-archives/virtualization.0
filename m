Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B22ED60DE3
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 18:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707848701; cv=none; b=Y92KN3ySiE0+FrF7T1SLexEU6WWRMP2kCkJdMyj+TgVlYVeS1aMNaHDeC1MQ3chasEkoC21Ho+7KewzujvZ2oUCy4U47F5rrWW4wyYZTWz0EDcQfI2VOwMaozwY0gLxEEDa6F/vRCwTOSO4Y58dteEC2b1fgNGKaS4qBCKLKUSQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707848701; c=relaxed/simple;
	bh=xNe4rvigIDdiz86ntX0XKJVb3S5877ZvE6xU/3SDiXE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Lgs19ZlhzYoreENXPp5eT+GOIhmu7ZCTrpfsaBYfH2DPN+fX0reZz/CEm79L3MmfWPx8YZAPauyY5QuQTFCZTixCYu03ZlLp7NGxdXqawQmLSsLAY24Svpr06YrdmQqSTmBRzgMzmV70S5dqbPefs+qwkcv+MoERKoZjcZdyUNE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FZRuFJt4; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FZRuFJt4"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7558341529
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 18:24:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wUBmbW8Lc2Cq
	for <virtualization@lists.linux-foundation.org>;
	Tue, 13 Feb 2024 18:24:58 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=eperezma@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 64ABE400D8
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 64ABE400D8
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FZRuFJt4
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 64ABE400D8
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 18:24:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707848696;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=bMTfbhuWj6UnNZL3Is+fIHua86/r90O7KAifCJJu4B8=;
	b=FZRuFJt40VDVXQg+yu9hBhWnxJ86xIxzYg5P8LfFWBH8WYuaGKzruRMtoDfM1ozaV7g+rV
	ZSR552cSRG1cKEG/OY47jQhO1FN50GTiSQoejRmLGTQnHz2gR1td38ypD4Gc7p8qVVYWqB
	Dhvk2Aj2J4XKaRtCkfa/hush8Xe7HSU=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-606-RgK2ALvQP8eOJjMuLxstDA-1; Tue, 13 Feb 2024 13:24:53 -0500
X-MC-Unique: RgK2ALvQP8eOJjMuLxstDA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.rdu2.redhat.com [10.11.54.6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 5CE89106D0C2;
	Tue, 13 Feb 2024 18:24:53 +0000 (UTC)
Received: from eperezma-thinkpadt480s.rmtes.csb (unknown [10.39.193.199])
	by smtp.corp.redhat.com (Postfix) with ESMTP id 7DDDE2166B31;
	Tue, 13 Feb 2024 18:24:52 +0000 (UTC)
From: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>
To: mst@redhat.com
Cc: Jason Wang <jasowang@redhat.com>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	virtualization <virtualization@lists.linux-foundation.org>
Subject: [PATCH] =?UTF-8?q?MAINTAINERS:=20add=20Eugenio=20P=C3=A9rez=20as?= =?UTF-8?q?=20reviewer?=
Date: Tue, 13 Feb 2024 19:24:50 +0100
Message-ID: <20240213182450.106796-1-eperezma@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.11.54.6

Add myself as a reviewer of some VirtIO areas I'm interested.

Until this point I've been scanning manually the list looking for
series that touches this area.  Adding myself to make this task easier.

Signed-off-by: Eugenio Pérez <eperezma@redhat.com>
---
 MAINTAINERS | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 61117c3afa80..d0789ecc4f70 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -23219,6 +23219,7 @@ M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	Jason Wang <jasowang@redhat.com>
 R:	Paolo Bonzini <pbonzini@redhat.com>
 R:	Stefan Hajnoczi <stefanha@redhat.com>
+R:	Eugenio Pérez <eperezma@redhat.com>
 L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	drivers/block/virtio_blk.c
@@ -23237,6 +23238,7 @@ VIRTIO CORE AND NET DRIVERS
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	Jason Wang <jasowang@redhat.com>
 R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
+R:	Eugenio Pérez <eperezma@redhat.com>
 L:	virtualization@lists.linux.dev
 S:	Maintained
 F:	Documentation/ABI/testing/sysfs-bus-vdpa
@@ -23277,6 +23279,7 @@ VIRTIO FILE SYSTEM
 M:	Vivek Goyal <vgoyal@redhat.com>
 M:	Stefan Hajnoczi <stefanha@redhat.com>
 M:	Miklos Szeredi <miklos@szeredi.hu>
+R:	Eugenio Pérez <eperezma@redhat.com>
 L:	virtualization@lists.linux.dev
 L:	linux-fsdevel@vger.kernel.org
 S:	Supported
@@ -23310,6 +23313,7 @@ F:	include/uapi/linux/virtio_gpu.h
 VIRTIO HOST (VHOST)
 M:	"Michael S. Tsirkin" <mst@redhat.com>
 M:	Jason Wang <jasowang@redhat.com>
+R:	Eugenio Pérez <eperezma@redhat.com>
 L:	kvm@vger.kernel.org
 L:	virtualization@lists.linux.dev
 L:	netdev@vger.kernel.org
-- 
2.43.0

