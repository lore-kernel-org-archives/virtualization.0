Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 94B25C433F5
	for <virtualization@archiver.kernel.org>; Tue,  7 Dec 2021 06:32:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1AD3A607C2;
	Tue,  7 Dec 2021 06:32:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wig3s1rbQg1Y; Tue,  7 Dec 2021 06:32:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id CE5146078B;
	Tue,  7 Dec 2021 06:32:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1921C001E;
	Tue,  7 Dec 2021 06:32:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7F7E7C0012
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 06:32:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 612C1607C2
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 06:32:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p_CtOC9-9-sa
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 06:32:19 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com
 [IPv6:2607:f8b0:4864:20::102f])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 39AC06078B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Dec 2021 06:32:19 +0000 (UTC)
Received: by mail-pj1-x102f.google.com with SMTP id
 f18-20020a17090aa79200b001ad9cb23022so1800474pjq.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 06 Dec 2021 22:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=chromium.org; s=google;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Cods9WyaktA6BF6JbbixG/DZf7V5gCMolIBwnRIBsoA=;
 b=MMD41CtxbBzB9YAAnCbHieIqVxNNB7RXyBlaQGRrHSeyJzYxkZgp4SmWmDhqYNerxg
 MprUuKqQAdg87VjPx7xnn5SuRVIZ4iMi7flp+RPD7CksU6Va8ZAaqdNdm1cV5SSwSrLo
 tc/PwmOJa5JD+CExp35BTRQAXpR6U5Ek4JuVc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=Cods9WyaktA6BF6JbbixG/DZf7V5gCMolIBwnRIBsoA=;
 b=xksp0Uw5HtjTZMu+QJp2DymtQuUsasHRsaASTFmtRyy0kYpJ7zzuYu7ro2YoTXULoy
 uqfMvFaFjfZF1JVrJo28q1vCJr6qEuv4V8brINHywYw9fttRGVy2iSOOJpSLDsFjkdDr
 JwvO+lCFQF6l62c5SCP4lAJYxDL5Pn4n02LbFGqsB67rDh1Wm9hfodzLcG3eOdP98fNd
 66kMclVyLkDJFmIk2BLd1xgNIdU7k/nAuQOjfmIyRFIhVcQoXAi5vF55VXgChvEdvNBZ
 GUtZ1eKxEMNkzhDU1G5GN0K3MQrE6kmqQJiWiZ6yfeAcbLpVDIwWMMqcfxUNj1HcVUyS
 7MUw==
X-Gm-Message-State: AOAM532uCdUmhhIxbli0ckwPkBUA/F/NnXwG+Z8bw9tg8sbiceVKlh0y
 4PkAFeeLvjd4/pbPURPtx8wocw==
X-Google-Smtp-Source: ABdhPJyp1UxglPEqmBhAA0mHlqJZn71XaypcbZcnECd4iiPFthtfrShdVlCTDQxxiafiXeZrE7GRMg==
X-Received: by 2002:a17:90b:17cc:: with SMTP id
 me12mr4322891pjb.179.1638858738693; 
 Mon, 06 Dec 2021 22:32:18 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
 by smtp.gmail.com with ESMTPSA id y6sm15487110pfi.154.2021.12.06.22.32.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 06 Dec 2021 22:32:18 -0800 (PST)
From: Kees Cook <keescook@chromium.org>
To: "K. Y. Srinivasan" <kys@microsoft.com>
Subject: [PATCH] hv_sock: Extract hvs_send_data() helper that takes only header
Date: Mon,  6 Dec 2021 22:32:17 -0800
Message-Id: <20211207063217.2591451-1-keescook@chromium.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=2572; h=from:subject;
 bh=48lY+W7yxU1t+Az6SdjP5/a959EClqgZo8+U7ONH7iw=;
 b=owEBbQKS/ZANAwAKAYly9N/cbcAmAcsmYgBhrv/woEdF1Rs69O+MuGiyQRAPdwunWIkJe1PXhimt
 WEGXogyJAjMEAAEKAB0WIQSlw/aPIp3WD3I+bhOJcvTf3G3AJgUCYa7/8AAKCRCJcvTf3G3AJoBLD/
 0ULE05fML+vI6+/LCIG9Ks4prnpoPtcUsW4eIvsa59c015zp36rvqreqIxD63DBa64rs8r4MgskEc9
 WFVuih/7jWmW9P0kl6Wpb1qpRJxTTg85WPn53QptwU4zIbYVjo8u3om7OU8/ZSzD0oCDo7QRQDR8sq
 vu1hEZ6KZRPmdx0RguKp1+TgiUdYRDRRVcSAB977TwcutxZ3U1JNZy53y+ze3DanRCy5HW+qNFly9D
 ZyYFmUZxGcMNc+4v5B36dIKkRmJrHLZK5xrbUnrpxpCC/iXfR2DsJeHQVFrc7ejRYe0qjtSb2TWZlf
 2Hondoefq+t1yBc0iL1SZBn8y/V9E6Qy0cWhF8zO89pX96X+hAZzEJKceL1hD/r1nNbfwlJl4I9t4F
 Cwu1o1EQSktmt/Cs2kUNx9HsTUiGBY3IaQ2EwDDiLHSJZRFCty/eOH7zKT1BDwNmIdUH0wytq+dma+
 1w+fUpV+dA3wpd+XqK/IgwIY5xKby/V+mUZVhz4GT+WQaRib/yeVFrVRdy3iue/rpBnsqq31xiXOdi
 WN3gjAK/DLqn0KCr9zObiXuiRdVbWoIVXXFsrbEOmiMZM+mC9VfVRNAIjxRfPhWoYSaEhsxfNjQViZ
 fPHEZ/ZDNNJ9EGqpcRzaJIuGKy++T3K+6nLXpcl7XsjqOZ7XQCiuvWaa0Wsw==
X-Developer-Key: i=keescook@chromium.org; a=openpgp;
 fpr=A5C3F68F229DD60F723E6E138972F4DFDC6DC026
Cc: Wei Liu <wei.liu@kernel.org>, Stephen Hemminger <sthemmin@microsoft.com>,
 Kees Cook <keescook@chromium.org>, linux-hyperv@vger.kernel.org,
 netdev@vger.kernel.org, Haiyang Zhang <haiyangz@microsoft.com>,
 Dexuan Cui <decui@microsoft.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, linux-hardening@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>
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

When building under -Warray-bounds, the compiler is especially
conservative when faced with casts from a smaller object to a larger
object. While this has found many real bugs, there are some cases that
are currently false positives (like here). With this as one of the last
few instances of the warning in the kernel before -Warray-bounds can be
enabled globally, rearrange the functions so that there is a header-only
version of hvs_send_data(). Silences this warning:

net/vmw_vsock/hyperv_transport.c: In function 'hvs_shutdown_lock_held.constprop':
net/vmw_vsock/hyperv_transport.c:231:32: warning: array subscript 'struct hvs_send_buf[0]' is partly outside array bounds of 'struct vmpipe_proto_header[1]' [-Warray-bounds]
  231 |         send_buf->hdr.pkt_type = 1;
      |         ~~~~~~~~~~~~~~~~~~~~~~~^~~
net/vmw_vsock/hyperv_transport.c:465:36: note: while referencing 'hdr'
  465 |         struct vmpipe_proto_header hdr;
      |                                    ^~~

This change results in no executable instruction differences.

Signed-off-by: Kees Cook <keescook@chromium.org>
---
 net/vmw_vsock/hyperv_transport.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/net/vmw_vsock/hyperv_transport.c b/net/vmw_vsock/hyperv_transport.c
index 19189cf30a72..e111e13b6660 100644
--- a/net/vmw_vsock/hyperv_transport.c
+++ b/net/vmw_vsock/hyperv_transport.c
@@ -225,14 +225,20 @@ static size_t hvs_channel_writable_bytes(struct vmbus_channel *chan)
 	return round_down(ret, 8);
 }
 
+static int __hvs_send_data(struct vmbus_channel *chan,
+			   struct vmpipe_proto_header *hdr,
+			   size_t to_write)
+{
+	hdr->pkt_type = 1;
+	hdr->data_size = to_write;
+	return vmbus_sendpacket(chan, hdr, sizeof(*hdr) + to_write,
+				0, VM_PKT_DATA_INBAND, 0);
+}
+
 static int hvs_send_data(struct vmbus_channel *chan,
 			 struct hvs_send_buf *send_buf, size_t to_write)
 {
-	send_buf->hdr.pkt_type = 1;
-	send_buf->hdr.data_size = to_write;
-	return vmbus_sendpacket(chan, &send_buf->hdr,
-				sizeof(send_buf->hdr) + to_write,
-				0, VM_PKT_DATA_INBAND, 0);
+	return __hvs_send_data(chan, &send_buf->hdr, to_write);
 }
 
 static void hvs_channel_cb(void *ctx)
@@ -468,7 +474,7 @@ static void hvs_shutdown_lock_held(struct hvsock *hvs, int mode)
 		return;
 
 	/* It can't fail: see hvs_channel_writable_bytes(). */
-	(void)hvs_send_data(hvs->chan, (struct hvs_send_buf *)&hdr, 0);
+	(void)__hvs_send_data(hvs->chan, &hdr, 0);
 	hvs->fin_sent = true;
 }
 
-- 
2.30.2

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
