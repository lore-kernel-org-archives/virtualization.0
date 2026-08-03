Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA5DD36D9F9;
	Tue,  4 Aug 2026 01:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785808431; cv=none; b=Ul2J7LeiRs2Y5X8KxSfN+jTiuFijjJYsECs+sUOSa5ym/EYvC5Oy0WOeKs4dTYKjRVnY051C6lBs1D1g6f80GOx8VvIvfrTgLR3X8QSiNG4FZqcUiVL+ifm0eEdOe+M6KJdzqw5pdutUJ/0hpRzofIqs6bp+lsZg61mXyGE2RJU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785808431; c=relaxed/simple;
	bh=4OI3Hs0sv/S0B4vF5IVZYPEvHTmYHCo+FmYDpPmm8Hk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pva5Dk/XPUTL7K88ndOEXprAIUaYgj7NVdS7eW+tVeVE9gmbsfbiGKOpuS64Lwy+JzMCRKyORmAk+VfVJc8dq1yXdottTayIqxKbLO3CRG/0/jrde0TTWeOgqReMIN6malFWIyVOtGZEiqXQjXa1c/He9D1c2G0Mqs/nw+10t5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Received: from simon-Latitude-5450.. (tmo-075-57.customers.d1-online.com [80.187.75.57])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.19.0.2/8.19.0.2) with ESMTPSA id 673Iars8011387
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 3 Aug 2026 20:36:57 +0200 (CEST)
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
Subject: [PATCH net-next v14 1/5] tun/tap: add IFF_BACKPRESSURE flag
Date: Mon,  3 Aug 2026 20:36:37 +0200
Message-ID: <20260803183641.96882-2-simon.schippers@tu-dortmund.de>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803183641.96882-1-simon.schippers@tu-dortmund.de>
References: <20260803183641.96882-1-simon.schippers@tu-dortmund.de>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add the IFF_BACKPRESSURE flag to the UAPI header and to its tools/ copy.
The flag has no effect yet, it is the opt-in switch for the qdisc
backpressure logic added by the following patches.

It is added to TUN_FEATURES only in the last patch of the series, once the
implementation is complete. Until then TUNSETIFF silently masks it off, as
it does for any flag outside TUN_FEATURES.

Keeping the flag and its users in separate patches would either leave a
window where backpressure is unconditional, or make the opt-in a later
add-on. Adding the flag first lets every following patch be a no-op
unless it is set.

Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
---
 include/uapi/linux/if_tun.h       | 4 ++++
 tools/include/uapi/linux/if_tun.h | 4 ++++
 2 files changed, 8 insertions(+)

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

