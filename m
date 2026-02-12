Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2B2E25B2F4
	for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 20:59:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770929968; cv=none; b=ZQTL8k0MPP4TmhvJxS6+ow0L7RdAKpVXBPSvPCuM4PWjufNM+BcMHLEejEn4ICIuyJzJ67LEURbOhBmolMEb/mrACaCGMu1UlVNeWrdJWE7VYRHf6Vjyw9m55MDfOUj1saY1clQdy4r0s093XW4WTl+8nCg/g+xuj9uPVLCPX14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770929968; c=relaxed/simple;
	bh=GfXVbSIiCSvAfNsvXZFkw5pPzo6pnCYgQ7VhFaW9av4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:content-type; b=arXAT7RtSP+iVzTSiNAUPO+3GFNNuSBRgiiznVcvhccz6jtLhh0DyBPxdTFByh9j3NYnqO32njCmFyYiLlq5hs+U9Yz7TZqltm+y4kNUpk6bSiUw26wdPAVlA7qqjBX5IOmsW++bYF/pOfobVYRmNDokuqhh2EJt0YDng/7tDGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=H/i+OloG; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="H/i+OloG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1770929966;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=1qRvoym6nLJZOIFftihpZCiMWAoHUET6JGe7MHQ2xs4=;
	b=H/i+OloGuNTGC394NLENQGDHghRyDZ9g2kCtJYxk6tbVUlsa3yDp3RppSRXkNtdgcTmF6k
	67DtRwiXwpDG3Eq9BBhqOzHSZhNKTdEnR/MFQRbzncazM03xL1zxjwRgMttEbWImRTxhGs
	6TjpT1SdMkFyac7q3vRIMkuJ8amXeIE=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-147-mjPO4XTTN1uOWTtnz8eQnA-1; Thu, 12 Feb 2026 15:59:25 -0500
X-MC-Unique: mjPO4XTTN1uOWTtnz8eQnA-1
X-Mimecast-MFC-AGG-ID: mjPO4XTTN1uOWTtnz8eQnA_1770929964
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-4836cd6dfe6so1904685e9.2
        for <virtualization@lists.linux.dev>; Thu, 12 Feb 2026 12:59:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770929964; x=1771534764;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1qRvoym6nLJZOIFftihpZCiMWAoHUET6JGe7MHQ2xs4=;
        b=iaatz6sLmHJEbjH9I7ClW3Tsj1r+PmXE+MbIkbdDjirfOI179V7kHKXe77hJiTLUNM
         cwXEwzlITK/NBP/OnPjzwyMOiQzUk7xBWaUsCt3jsp9Id0IFxs6pjxHP2Y85PNGoLHvb
         gZcFF0Z0yt9QMpFGvKKVGHPeuOWdxLaK/Tm7CiNsGecnnHYMBtY2769mnRmDFQ+fJjRd
         +Wf26LmQMg/+vN/BeHjYKJM1/X9xlvL/A1FgjGl5EcJa57Rhb+pD7T7LytJ24ccQb/+/
         KUH18CMlX2zCWhyMsWajk17ACg7qwoe4NEcT+CElFpIdgrynrsSX3OKujHZjG6XKB6fg
         apOw==
X-Forwarded-Encrypted: i=1; AJvYcCVt6kzamQJutizOHNcwt/3iJ0e6B+wL9u6nhevCIFdE9ijYxYX2EXsB53U/K8Mvm6pV7mQy+v4WAtw+qwP4uw==@lists.linux.dev
X-Gm-Message-State: AOJu0YxXt9T+od+KN380faThXyvkkKZJgVLPL8xVVEagXFGN09S/MIVk
	IX08+sZDEXPjoxi7WN4tyE+cGTm1vnhQmbmVm9V8wEH6PePQGJMT7/sEzXeYQsqPKQJJeQCIiCD
	aYKF8UIAVMUvBCI/Qg3fwoomFXNSK9LRZTKCxHsN0Inb1pXjaepNssTpM1RoC520+FJLv6cYg17
	HO
X-Gm-Gg: AZuq6aK6EZ3jGkX7WISwwaddt79TQtykqdwxcryCI+08wraFYknF+iwYK3nt55pxn6n
	gJLpxe4r4Py5V0UJ3Wi1eU8CGpXU6vnIxHUJS8uTDWyibqZRJKde8L/hXqbCO+v9c+cPqzhkK/6
	jkCYMoQBYd3HKRYR6fOObpXAvcixIsT0iNd6PPNawZqnQmODNSovKjX+XW4eftz9PfTv7u40i90
	/PthHxki8NVEgbJj06O8bzv/DQvZK/1Jm8KkynEwUx7fuTWfI34i37+qaUzakNIZGl2a6gtaX72
	iNOwhEovi6RyR3PQ+Tdx1Pg+mM8vdpF16QwPjcBbGWXZmrX0kdmmjNfm2ZPTZ6/0JUupuypkq5q
	IdzUTdqghTK1JhF4helVOyQNz329oV5LMwMHYogk4GQYVFbXJ/KuitEI40Q==
X-Received: by 2002:a05:6000:2003:b0:435:8aa1:ff4d with SMTP id ffacd0b85a97d-43796aa67c4mr421863f8f.22.1770929963775;
        Thu, 12 Feb 2026 12:59:23 -0800 (PST)
X-Received: by 2002:a05:6000:2003:b0:435:8aa1:ff4d with SMTP id ffacd0b85a97d-43796aa67c4mr421834f8f.22.1770929963268;
        Thu, 12 Feb 2026 12:59:23 -0800 (PST)
Received: from stex1 (host-82-53-134-58.retail.telecomitalia.it. [82.53.134.58])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43796abd793sm465791f8f.25.2026.02.12.12.59.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Feb 2026 12:59:22 -0800 (PST)
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
Subject: [PATCH net 1/2] vsock: fix child netns mode initialization
Date: Thu, 12 Feb 2026 21:59:15 +0100
Message-ID: <20260212205916.97533-2-sgarzare@redhat.com>
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
X-Mimecast-MFC-PROC-ID: Qh3-pNk6aNvt-tOezPbPgLMxKQOwOaAZKJhF6kUYcs8_1770929964
X-Mimecast-Originator: redhat.com
Content-Transfer-Encoding: 8bit
content-type: text/plain; charset="US-ASCII"; x-default=true

From: Stefano Garzarella <sgarzare@redhat.com>

When a new network namespace is created, vsock_net_init() correctly
initializes the namespace's mode by reading the parent's `child_ns_mode`
via vsock_net_child_mode(). However, the `child_ns_mode` of the new
namespace was always hardcoded to VSOCK_NET_MODE_GLOBAL, regardless of
its own mode.

This means that if a parent namespace has `child_ns_mode` set to "local",
the child namespace correctly gets mode "local", but its `child_ns_mode`
is reset to "global". As a result, further nested namespaces will
incorrectly get mode "global" instead of inheriting "local", breaking
the expected propagation of the mode through nested namespaces.

Fix this by initializing `child_ns_mode` to the namespace's own mode,
so the setting propagates correctly through all levels of nesting.

Fixes: eafb64f40ca4 ("vsock: add netns to vsock core")
Cc: bobbyeshleman@meta.com
Signed-off-by: Stefano Garzarella <sgarzare@redhat.com>
---
 net/vmw_vsock/af_vsock.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 20ad2b2dc17b..3b629b4a0359 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -91,7 +91,8 @@
  *   - /proc/sys/net/vsock/ns_mode (read-only) reports the current namespace's
  *     mode, which is set at namespace creation and immutable thereafter.
  *   - /proc/sys/net/vsock/child_ns_mode (writable) controls what mode future
- *     child namespaces will inherit when created. The default is "global".
+ *     child namespaces will inherit when created. The initial value matches
+ *     the namespace's own ns_mode.
  *
  *   Changing child_ns_mode only affects newly created namespaces, not the
  *   current namespace or existing children. At namespace creation, ns_mode
@@ -2912,7 +2913,7 @@ static void vsock_net_init(struct net *net)
 	else
 		net->vsock.mode = vsock_net_child_mode(current->nsproxy->net_ns);
 
-	net->vsock.child_ns_mode = VSOCK_NET_MODE_GLOBAL;
+	net->vsock.child_ns_mode = net->vsock.mode;
 }
 
 static __net_init int vsock_sysctl_init_net(struct net *net)
-- 
2.53.0

