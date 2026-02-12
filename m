Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A6B30B500
	for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 20:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770929972; cv=none; b=L8eDW3unK2Jy4EM/avxknr5F5O6J+W5IukaklFGX+O27ZDEQF/xPOCZP/IFIR+NZTZpftomynUwiESHBELhbVmGmnyHAfX9sGa6y/Yeu0Hfu3/4wbQgvtZPAxEkHvnnWYJvPHFD2LSCcBl1RTSo5uDIrJPkFm7PozaD6J/YABJM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770929972; c=relaxed/simple;
	bh=2HJhD4jwEiQd+Sw0gop1LZRkZ9dv9Da9YU2irp8nJI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=WlZl/hUaGz/EP8qmwL+yoc2XrWCdGd+vB/nQJw6WIisEpvfxHTWnAGR0VKen8SX5Zaa/+oLe2mvDvj1aUwwMSk6hk24oZYq97+vp0FuLJLrwL2zO8Y3W64vkd5+Pxptxiju/1cJf6UArj/bJhPwaegCpXYCcCdI4BZUmVdN1dlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YsZViGfX; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YsZViGfX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770929970;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=EDtloKc54TB42uRGUdYvHpL+cAu7dip36yXl2Un1+Yk=;
	b=YsZViGfXVECs+n31N8/VdOk7ddC5Jp0QW6MkNnUD1b5dwbifzUCdkmcVfNofUQ/YRBgBG+
	YxswpsB4YxPDK5zCzxQ3nK/1uV+yZRPb0Wy/3nSI6htCN0Zj9m5eIG0h4LsHiQCZqWDqaH
	2fGUdq0LnH5MTlsOXidS0nE4bxjbSyA=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-300-mAXDoNGeNgWCe-vuu-IeVQ-1; Thu, 12 Feb 2026 15:59:29 -0500
X-MC-Unique: mAXDoNGeNgWCe-vuu-IeVQ-1
X-Mimecast-MFC-AGG-ID: mAXDoNGeNgWCe-vuu-IeVQ_1770929968
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4806fa4a180so1747295e9.2
        for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 12:59:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770929968; x=1771534768;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=EDtloKc54TB42uRGUdYvHpL+cAu7dip36yXl2Un1+Yk=;
        b=OOQ/OGvWemqV7MI5cBT6anQ5ipNy+lWbVAJGwj0DMMHpXIH8ZFb3buOgnIbHGYK9jo
         Rz+pKFUw6o1Cl13PDx7X7WsYTirMDsIAMmJ9hezqSFYOIYktgXObFqZjvWaWC/CZg4v9
         oR3tQHVQSo5kCWeRlWYkxOokfMzxyfqy9llbBg6X6PiQJ/TPk77LloX3Adrd1wx/OQyn
         awUG0CzFd0hXWHfDsFz+MWwX8TyOBuFi4SI+oNJy2MFd0H4XnNWX7+7wIU6/IDremc6l
         k5zsMpruMXY7RersB+ZHhIM0td9W/IHKWqDUJweQQUcMvY8xzZOneB0hKW+1qMr1QFbU
         RR7w==
X-Forwarded-Encrypted: i=1; AJvYcCUb+ax0cG8WBeVUxUYUNSAKfUp7cC1fEKWW4OzcCRm7uBv6sj4T5R7zPSXSHrO8tWnMhRUUul7/HPxjxj00vw==@lists.linux.dev
X-Gm-Message-State: AOJu0Yw8T+lCQjCw6FOC/ipFOLAFuTksjTT1YqS1bnBEyCpEzK2Ymaj0
	KXw4PJOYvm80aeR76OMIGRm7pHw36/FSIbjgQ9fZwHLKV8ZH7yuuR1BPWr5Vi2F0DwMgrLShSAN
	zjoedqica6tnThm0lJz8Vrtw2Ux4gRZbK3aYtrwadr3GGuVcSE/SKNoXWmdXIvPW6bo/H
X-Gm-Gg: AZuq6aLCgma6JIp9/Dz1AAJJSHcW9/YCsYeFMwTeHzGhim6UZL9eQ8ZlFq+N62TEAMb
	BWvCM2c+9+czAXKcN1QI58XBx1NUMY6wlV1KrdyyGcKao4vEGJK7Yr06WZ5eD8wwTT6sCMo8SFz
	ojdZmdogFTte1SuX2xLmOEa4JFCFhr0CWqm0S5MXD8FYHBu4gXi9DXOE0zxGmZgGIIBpifxjPtf
	vn9U+yeh2Zr/oSFulZSAONAzuMOK8wjSW2c9AYdTaWI9277QTEeUh6WzxGFUarHQTCf4o+XVUsh
	Xlj3+ryhipVUBHTiY6hwsx2Qfa5lKuwjkLltf3xiYu2BkhEu2h8ddlykfrjjvyUjpSNrQX5kKlB
	GopFbaD5JdQrJVCCPpaUh+gI1ld2SJ1PNkQ1ixEExDeZEvQDCRCDl+9QzYA==
X-Received: by 2002:a05:600c:444d:b0:480:1b65:b741 with SMTP id 5b1f17b1804b1-48370e305e6mr6147325e9.15.1770929967917;
        Thu, 12 Feb 2026 12:59:27 -0800 (PST)
X-Received: by 2002:a05:600c:444d:b0:480:1b65:b741 with SMTP id 5b1f17b1804b1-48370e305e6mr6146965e9.15.1770929967362;
        Thu, 12 Feb 2026 12:59:27 -0800 (PST)
Received: from stex1 (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483709fdd39sm5618975e9.0.2026.02.12.12.59.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 12:59:26 -0800 (PST)
From: Stefano Garzarella <sgarzare@redhat.com>
To: netdev@vger.kernel.org
Cc: Eric Dumazet <edumazet@google.com>,
	linux-kernel@vger.kernel.org,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Stefano Garzarella <sgarzare@redhat.com>,
	virtualization@lists.linux.dev,
	Paolo Abeni <pabeni@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Simon Horman <horms@kernel.org>,
	"David S. Miller" <davem@davemloft.net>
Subject: [PATCH net 2/2] vsock: prevent child netns mode switch from local to global
Date: Thu, 12 Feb 2026 21:59:16 +0100
Message-ID: <20260212205916.97533-3-sgarzare@redhat.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260212205916.97533-1-sgarzare@redhat.com>
References: <20260212205916.97533-1-sgarzare@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: pm1W29Pc72UrT91XYN_RFMiEZzoi9GMMctrdZzn_T50_1770929968
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

A "local" namespace can change its `child_ns_mode` sysctl to "global",
allowing nested namespaces to access global CIDs. This can be exploited
by an unprivileged user who gained CAP_NET_ADMIN through a user
namespace.

Prevent this by rejecting writes that attempt to set `child_ns_mode` to
"global" when the current namespace's mode is "local".

Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
Cc: bobbyeshleman@meta.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/af_vsock.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 3b629b4a0359..9880756d9eff 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -95,8 +95,9 @@
  *     the namespace's own ns_mode.
  *
  *   Changing child_ns_mode only affects newly created namespaces, not the
- *   current namespace or existing children. At namespace creation, ns_mode
- *   is inherited from the parent's child_ns_mode.
+ *   current namespace or existing children. A "local" namespace cannot set
+ *   child_ns_mode to "global". At namespace creation, ns_mode is inherited
+ *   from the parent's child_ns_mode.
  *
  *   The init_net mode is "global" and cannot be modified.
  *
@@ -2844,8 +2845,16 @@ static int vsock_net_child_mode_string(const struct ctl_table *table, int write,
 	if (ret)
 		return ret;
 
-	if (write)
+	if (write) {
+		/* Prevent a "local" namespace from escalating to "global",
+		 * which would give nested namespaces access to global CIDs.
+		 */
+		if (vsock_net_mode(net) == VSOCK_NET_MODE_LOCAL &&
+		    new_mode == VSOCK_NET_MODE_GLOBAL)
+			return -EPERM;
+
 		vsock_net_set_child_mode(net, new_mode);
+	}
 
 	return 0;
 }
-- 
2.53.0

