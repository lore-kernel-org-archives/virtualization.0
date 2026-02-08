Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3F7628002B
	for <virtualization@lists.linux.dev>; Sun,  8 Feb 2026 14:35:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770561301; cv=none; b=JGGlw4W2hwyI1uSAlH+4PCv92N8m/pMC4hRjJj8yM96gr61NDV86QNLBcekoYewgqqgq26h1m3QIurZuhTNpZQ2DXdd2H/eKBnKHExXyFGlptD0nrd3EntqQD09smzGk9R3ius5kVjhaS+anZa0CSq+TMMbzoFm7wWk3S2TQEOM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770561301; c=relaxed/simple;
	bh=kCFklQNimDbQxqRtKmEGp8OsrVvQkvdJ4FZi/fH6BTM=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:content-type; b=pqC+dHLsqExhEDB74YvRzV8ieTc33py5xYOCyOnbG3HjTfGdtq+YYmubYYeSv/V8W73d0pqBZipJWwbqJl7ZljMaagJp9ar2UPnX4s2nNDQ0Rg6URiDDWzcWaVl64kwMC+JqqNoAEQ42FdawqJS4Dhtla/gNNCFe4pEcrwKYi7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SQEjZA/h; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SQEjZA/h"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770561299;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=pspMQtjTZwBdLYk3DLvxWkcNg8Z4rVD+1Sbx2a24tGE=;
	b=SQEjZA/hIbblsZh/1hdohsjs0CRFrtr6bLeRAK3uZc3wrxDZCzO8AJunff+hMLuMhOBVDC
	rysNbk/+9sBMiwCT7V0QjaKmykZvd+yq2UNBMPlG3zxLmerwdHhPSkmJqmGK+gVJDCyT0U
	KDcZy7oN401D9/l4ONv1QB8cOwA2veo=
Received: from mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-549-kjLThcnnP4CWE2wVqlkZkQ-1; Sun,
 08 Feb 2026 09:34:58 -0500
X-MC-Unique: kjLThcnnP4CWE2wVqlkZkQ-1
X-Mimecast-MFC-AGG-ID: kjLThcnnP4CWE2wVqlkZkQ_1770561297
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-01.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 6A1C6195608F;
	Sun,  8 Feb 2026 14:34:57 +0000 (UTC)
Received: from S2.redhat.com (unknown [10.72.112.33])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 8BC7718004AD;
	Sun,  8 Feb 2026 14:34:53 +0000 (UTC)
From: Cindy Lu <lulu@redhat.com>
To: lulu@redhat.com,
	mst@redhat.com,
	jasowang@redhat.com,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [RFC 0/3]  vhost-net: netfilter support for RX path
Date: Sun,  8 Feb 2026 22:32:21 +0800
Message-ID: <20260208143441.2177372-1-lulu@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: HniVyOEDJhZyREOZ647rGZLCDnk9kThPnLb1jfeJsDY_1770561297
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

This series adds a minimal vhost-net filter support for RX.
It introduces a UAPI for VHOST_NET_SET_FILTER and a simple
SOCK_SEQPACKET message header. The kernel side keeps a filter
socket reference and routes RX packets to userspace when
it was enabled.

Tested
- vhost=on  and vhost=off

Cindy Lu (3):
  uapi: vhost: add vhost-net netfilter offload API
  vhost/net: add netfilter socket support
  vhost/net: add RX netfilter offload path

 drivers/vhost/net.c        | 338 +++++++++++++++++++++++++++++++++++++
 include/uapi/linux/vhost.h |  20 +++
 2 files changed, 358 insertions(+)

-- 
2.52.0

