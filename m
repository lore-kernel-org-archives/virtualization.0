Return-Path: <SRS0=ivLu=BN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7C4BC433E1
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:02 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E80CE22CAD
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 20:59:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LyRuZKxX"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E80CE22CAD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8B14E8790F;
	Mon,  3 Aug 2020 20:59:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 2pUIVPOoaA+5; Mon,  3 Aug 2020 20:59:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 232C287766;
	Mon,  3 Aug 2020 20:59:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F786C0050;
	Mon,  3 Aug 2020 20:59:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B2477C004C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:58:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id A93E72048D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:58:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CONqaH4lAS9r
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:58:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 5CA631FE0A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 20:58:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596488337;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=EgJGJjLXNDNxv1S9tFSxLl/zl31va0ARwAnPHhIniqo=;
 b=LyRuZKxX7eK2cmQZVOVIPasxC0CyFldaVZc9fkMcJQN+xUl8PoMmsfOQ9mICnre2gZr9Bk
 o5j+ja+bVCNbQWdi4Ot/HWJd2qMRUyUNPCiJdguiEFaXtGgAkIf07ORRtAtppE/0Oyat8p
 7k3LPuQl3rQ6qnah0xnZM9U9sz0yHKE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-335-l2uLlM7qOXGBe8EwURdNKQ-1; Mon, 03 Aug 2020 16:58:55 -0400
X-MC-Unique: l2uLlM7qOXGBe8EwURdNKQ-1
Received: by mail-qv1-f69.google.com with SMTP id l10so16582125qvw.22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Aug 2020 13:58:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=EgJGJjLXNDNxv1S9tFSxLl/zl31va0ARwAnPHhIniqo=;
 b=MCMoFjHDcOSC+a+rXQQ0ZUPiOkwVi29j5867E/tSFrOHG2VQmAT9Z42nxJRdEec/P9
 xZzP11gn4QfpbMXXCAELcEhblXRaPlXuuFnJpZ+kyHByguPqQq6bBBUM7mHRQw5ctpMV
 YR4bCqz/PHr8iB36edAoTs5ysPVRP6tl4A6woJak6d1O8R0YjN/o64KvrRx8wC/Oswkc
 tBTuWout1Fw2tngY/NerT54UfZvgrw3Qu+91LiO3xJHKepVBBA+CZ0kxrLsf6INzsE1A
 y369pZEU0GaVRgKIkn9NOdd5NA0UyYzY7BVMfJH8QZe2ZWHM2NnRxtUnxH8oqGKFxZLc
 3ikg==
X-Gm-Message-State: AOAM533qdOj0+SARJW82biFd+uXkaiahV/eTkpfX7wg9uasQT+ULgCBP
 BC651IclpmEMC+J1utvZjOArwxKTvHGzFmcYZFS4LvKFwWqyV4jrTw0z0A+Kg4iq4d02Eubterb
 kfd8iy4F3WlmVTyHj1jrB9SQNWDw3a1wv6rswa/M8uA==
X-Received: by 2002:ae9:e00b:: with SMTP id m11mr16520745qkk.341.1596488335096; 
 Mon, 03 Aug 2020 13:58:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzhufE6JFaK7bGmm6mLbB9GDhDAi6TBHVwCMJewMzhq9hJKY2E/SiLeAoUb/AkDMVbg0hKQkg==
X-Received: by 2002:ae9:e00b:: with SMTP id m11mr16520707qkk.341.1596488334744; 
 Mon, 03 Aug 2020 13:58:54 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id n33sm22173580qtd.43.2020.08.03.13.58.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 03 Aug 2020 13:58:54 -0700 (PDT)
Date: Mon, 3 Aug 2020 16:58:50 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2 04/24] virtio_9p: correct tags for config space fields
Message-ID: <20200803205814.540410-5-mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20200803205814.540410-1-mst@redhat.com>
X-Mailer: git-send-email 2.27.0.106.g8ac3dc51b1
X-Mutt-Fcc: =sent
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eric Van Hensbergen <ericvh@gmail.com>,
 virtualization@lists.linux-foundation.org,
 v9fs-developer@lists.sourceforge.net
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

Tag config space fields as having virtio endian-ness.

Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
---
 include/uapi/linux/virtio_9p.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/include/uapi/linux/virtio_9p.h b/include/uapi/linux/virtio_9p.h
index 277c4ad44e84..441047432258 100644
--- a/include/uapi/linux/virtio_9p.h
+++ b/include/uapi/linux/virtio_9p.h
@@ -25,7 +25,7 @@
  * LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY
  * OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF
  * SUCH DAMAGE. */
-#include <linux/types.h>
+#include <linux/virtio_types.h>
 #include <linux/virtio_ids.h>
 #include <linux/virtio_config.h>
 
@@ -36,7 +36,7 @@
 
 struct virtio_9p_config {
 	/* length of the tag name */
-	__u16 tag_len;
+	__virtio16 tag_len;
 	/* non-NULL terminated tag name */
 	__u8 tag[0];
 } __attribute__((packed));
-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
