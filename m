Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DF312D9EE4
	for <virtualization@lists.linux.dev>; Wed, 26 Nov 2025 21:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764191837; cv=none; b=NpgNVuJ7dzjRKgyV8IaXsGrhFdTmf7SqNy9B7qKOrHFm2oAIjnsxIxheQ7AVcdjRHGcL9WRYxu4k/hbP6vAeHnB3Bw5PSUj75aXdD0fQUcwfHCo+12nTCcn1RXZvHmWtEAOvhPECQPeYl50M9jL7xnJyag5BJlNNcoGZZZ/PvhE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764191837; c=relaxed/simple;
	bh=LeauSPWgUT1TyXCfm8K70hoF35nKv7ZGtWhbp3ycLz4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=C523KbIF12pExNpRDwKf5iAsCJqh32fKAUwjXjpyeNX8eZyBYbRs/WpX2vhYzfGV1rD/TJMW24TjyGWVMS2QKOnQIMktcdjvUxv/V64uGZD6Fy0BgLcWQ3g2kvdylekD1RVQ3PugjqtSkVsHcFQc46mtZgfgsZmMhr1muMglHro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=BuDGxCSx; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BuDGxCSx"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1764191835;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=3x6C1wZtOSrBs0hiPev6vXIvqHeh6TE7yZaYhbRklKQ=;
	b=BuDGxCSxPYMA9ITC+mO9SNfG4K94wxWcaIenNDfxUWlQAcD57lT8Du5b/k26d06IYAmUYS
	oKNOYv/IzG0Yy6OzlWIf018jVskfKxjW0MNzzdmUPFRnQpToaXsKggO4cE4B6/LF3HOmce
	psNcBlHLJWVNq9Cpr1GRZceMDnmA3Zk=
Received: from mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-17-r6N1D3ygNzauFo32vWHhMw-1; Wed,
 26 Nov 2025 16:17:05 -0500
X-MC-Unique: r6N1D3ygNzauFo32vWHhMw-1
X-Mimecast-MFC-AGG-ID: r6N1D3ygNzauFo32vWHhMw_1764191824
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 1FC971800561;
	Wed, 26 Nov 2025 21:17:04 +0000 (UTC)
Received: from localhost (unknown [10.2.16.34])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id ECD531800240;
	Wed, 26 Nov 2025 21:17:02 +0000 (UTC)
From: Stefan Hajnoczi <stefanha@redhat.com>
To: linux-fsdevel@vger.kernel.org
Cc: German Maglione <gmaglione@redhat.com>,
	linux-kernel@vger.kernel.org,
	Miklos Szeredi <miklos@szeredi.hu>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Vivek Goyal <vgoyal@redhat.com>,
	virtualization@lists.linux.dev,
	Stefan Hajnoczi <stefanha@redhat.com>
Subject: [PATCH] MAINTAINERS: add German Maglione as virtiofs co-maintainer
Date: Wed, 26 Nov 2025 16:15:48 -0500
Message-ID: <20251126211548.598469-1-stefanha@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111

German Maglione is a co-maintainer of the virtiofsd userspace device
implementation (https://gitlab.com/virtio-fs/virtiofsd) and is currently
one of the most active virtiofs developers outside the kernel.

I have not worked on virtiofs except to review kernel patches for a few
years now and would like German to take over from me gradually. It is
healthier to have a kernel maintainer who is actively involved. I expect
to remove myself in a few months.

Signed-off-by: Stefan Hajnoczi <stefanha@redhat.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 6df89b14b521a..99e0ff4170f00 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -27165,6 +27165,7 @@ F:	arch/s390/include/uapi/asm/virtio-ccw.h
 F:	drivers/s390/virtio/
 
 VIRTIO FILE SYSTEM
+M:	German Maglione <gmaglione@redhat.com>
 M:	Vivek Goyal <vgoyal@redhat.com>
 M:	Stefan Hajnoczi <stefanha@redhat.com>
 M:	Miklos Szeredi <miklos@szeredi.hu>
-- 
2.52.0

