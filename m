Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B76BB33AD88;
	Thu, 30 Jul 2026 21:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785447626; cv=none; b=fmmAnSVyUSgZOnsDDBYs8LAuk3/G3bgr+2Vn6DFVLFrhb9mAoYFXjVckcw+4BQKlK1VpIs2wUYJcJwBg+iMPNz5X4SxbPf98OVBDF7jeqHphOFv6+fhrpcacSdJ1HWh0sfgeYGZsFGfGo1QhD38kD0YuEoQMVrOXqbt1SOZcYM4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785447626; c=relaxed/simple;
	bh=lwyjYGWYFgTDpQ85Ojydg1Cb3khxAupjJPpngwLFhSk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LKc1ZZwk31IW547BBd3NBBhNFhImQKWjlBpr3+KPHuY5GGKNQb8glzlZDEUQuBeaavWXDnPfg0WVA80sKvzrOnYynASzZcXRhcOcrr7OFGBUP6NjkVc9i3GM9Mf0uQwf08XPMRbx+uPL+AsL7zopfFIGLzask7D91tlTk8V7eJg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=JWSsgngE; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="JWSsgngE"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=tu-dortmund.de;
	s=unimail; t=1785447413;
	bh=MPZXFC4u7gfjPVIpwagoHXEDBexqpmRoZFGvCwt4B40=;
	h=From:To:Subject:Date:In-Reply-To:References;
	b=JWSsgngEVIJE8fiwW0wfnhoHhzNMVinGJVwDHCNVjTaGbiJ5/QvlD2MheNJMNm28z
	 mfDs3VOXlAi+QT0bZVr/dZrHkso0zzCDtCo75zdKfQonyEWR4LFVUv0tjaKRGc/dEw
	 wbI82TivTFFDAXVwWkhnLYOEZR+gvrxsY8Rc618c=
Received: from simon-Latitude-5450.fritz.box (pd9eaa9cd.dip0.t-ipconnect.de [217.234.169.205])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 66ULan2q027704
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 30 Jul 2026 23:36:53 +0200 (CEST)
From: Simon Schippers <simon.schippers@tu-dortmund.de>
To: willemdebruijn.kernel@gmail.com, jasowangio@gmail.com, jasowang@redhat.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, horms@kernel.org, mst@redhat.com,
        eperezma@redhat.com, leiyang@redhat.com, stephen@networkplumber.org,
        jon@nutanix.com, brett@librecast.net, corbet@lwn.net,
        skhan@linuxfoundation.org, tim.gebauer@tu-dortmund.de,
        simon.schippers@tu-dortmund.de, netdev@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org, virtualization@lists.linux.dev
Subject: [PATCH net-next v13 1/5] tun/tap: add IFF_BACKPRESSURE flag
Date: Thu, 30 Jul 2026 23:36:35 +0200
Message-ID: <20260730213639.726381-2-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730213639.726381-1-simon.schippers@tu-dortmund.de>
References: <20260730213639.726381-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the IFF_BACKPRESSURE flag to the UAPI header and to TUN_FEATURES so
that it can be set via TUNSETIFF. The flag has no effect yet, it is the
gate for the qdisc backpressure logic added by the following patches.

Keeping the flag and its users in separate patches would either leave a
window where backpressure is unconditional, or make the gate a later
add-on. Adding the flag first lets every following patch be a no-op
unless it is set.

Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 drivers/net/tun.c                 | 3 ++-
 include/uapi/linux/if_tun.h       | 4 ++++
 tools/include/uapi/linux/if_tun.h | 4 ++++
 3 files changed, 10 insertions(+), 1 deletion(-)

diff --git a/drivers/net/tun.c b/drivers/net/tun.c
index 51e80000bd0e..ea8573efb848 100644
--- a/drivers/net/tun.c
+++ b/drivers/net/tun.c
@@ -98,7 +98,8 @@ static void tun_default_link_ksettings(struct net_device *dev,
 #define TUN_FASYNC	IFF_ATTACH_QUEUE
 
 #define TUN_FEATURES (IFF_NO_PI | IFF_ONE_QUEUE | IFF_VNET_HDR | \
-		      IFF_MULTI_QUEUE | IFF_NAPI | IFF_NAPI_FRAGS)
+		      IFF_MULTI_QUEUE | IFF_NAPI | IFF_NAPI_FRAGS | \
+		      IFF_BACKPRESSURE)
 
 #define GOODCOPY_LEN 128
 
diff --git a/include/uapi/linux/if_tun.h b/include/uapi/linux/if_tun.h
index 79d53c7a1ebd..a0ddc50a7534 100644
--- a/include/uapi/linux/if_tun.h
+++ b/include/uapi/linux/if_tun.h
@@ -69,6 +69,10 @@
 #define IFF_NAPI_FRAGS	0x0020
 /* Used in TUNSETIFF to bring up tun/tap without carrier */
 #define IFF_NO_CARRIER	0x0040
+/* Stop the queue instead of dropping when the internal ring is full, so an
+ * attached qdisc applies backpressure instead of being bypassed.
+ */
+#define IFF_BACKPRESSURE	0x0080
 #define IFF_NO_PI	0x1000
 /* This flag has no real effect */
 #define IFF_ONE_QUEUE	0x2000
diff --git a/tools/include/uapi/linux/if_tun.h b/tools/include/uapi/linux/if_tun.h
index 2ec07de1d73b..2c85525704c1 100644
--- a/tools/include/uapi/linux/if_tun.h
+++ b/tools/include/uapi/linux/if_tun.h
@@ -67,6 +67,10 @@
 #define IFF_TAP		0x0002
 #define IFF_NAPI	0x0010
 #define IFF_NAPI_FRAGS	0x0020
+/* Stop the queue instead of dropping when the internal ring is full, so an
+ * attached qdisc applies backpressure instead of being bypassed.
+ */
+#define IFF_BACKPRESSURE	0x0080
 #define IFF_NO_PI	0x1000
 /* This flag has no real effect */
 #define IFF_ONE_QUEUE	0x2000
-- 
2.43.0

