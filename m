Received: from cmccmta1.chinamobile.com (cmccmta2.chinamobile.com [111.22.67.135])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8E2156676
	for <virtualization@lists.linux.dev>; Wed, 20 Nov 2024 07:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=111.22.67.135
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732088012; cv=none; b=qUH5ds7hz4jGbxE4Rjgk6CvIvyzShS8hkUmB4sYKaJ6Kug7hIT8A5ACI6QstA952o10kUEyYUOd7BFWSz/9yrapPlmakQ1w+NOp5giU5KIoWS6BZK4yHzdjumtzoqSNH/oU017HNKQ/1ePUDkl2v5sOMD+YMdh0WbMGPFSercz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732088012; c=relaxed/simple;
	bh=KL2avKrEhHAjiKIIhbAif+PymrYZOFuFoHbTsarkpeo=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=QspmcYBZa9URhefu2uklhHyc7cXYXOM/DkzwlAhx5LbKDg0s3LjHH+OYPIQLoWdsigxJ1v3PqE5PIyL5IIJeE+Feq7pR5Obhxmam/YWuORFHqcTBxxaGitYFL8McAh0BPxoIEHesWgudKN0wIwrcJK9ATaI537WEChjXrDW4trU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com; spf=pass smtp.mailfrom=cmss.chinamobile.com; arc=none smtp.client-ip=111.22.67.135
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cmss.chinamobile.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cmss.chinamobile.com
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from spf.mail.chinamobile.com (unknown[10.188.0.87])
	by rmmx-syy-dmz-app03-12003 (RichMail) with SMTP id 2ee3673d90bf508-21d30;
	Wed, 20 Nov 2024 15:33:19 +0800 (CST)
X-RM-TRANSID:2ee3673d90bf508-21d30
X-RM-TagInfo: emlType=0                                       
X-RM-SPAM-FLAG:00000000
Received:from localhost.localdomain (unknown[223.108.79.101])
	by rmsmtp-syy-appsvr01-12001 (RichMail) with SMTP id 2ee1673d90bfab1-6e2d0;
	Wed, 20 Nov 2024 15:33:19 +0800 (CST)
X-RM-TRANSID:2ee1673d90bfab1-6e2d0
From: zhangjiao2 <zhangjiao2@cmss.chinamobile.com>
To: mst@redhat.com
Cc: david@redhat.com,
	jasowang@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	zhang jiao <zhangjiao2@cmss.chinamobile.com>
Subject: [PATCH] virtio_balloon: Use outer variable 'page'
Date: Wed, 20 Nov 2024 13:49:20 +0800
Message-Id: <20241120054920.35291-1-zhangjiao2@cmss.chinamobile.com>
X-Mailer: git-send-email 2.33.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: zhang jiao <zhangjiao2@cmss.chinamobile.com>

There is no need to define a local variable 'page',
just use outer variable 'page'.

Signed-off-by: zhang jiao <zhangjiao2@cmss.chinamobile.com>
---
 drivers/virtio/virtio_balloon.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index b36d2803674e..89da052f4f68 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -251,7 +251,7 @@ static unsigned int fill_balloon(struct virtio_balloon *vb, size_t num)
 
 	for (num_pfns = 0; num_pfns < num;
 	     num_pfns += VIRTIO_BALLOON_PAGES_PER_PAGE) {
-		struct page *page = balloon_page_alloc();
+		page = balloon_page_alloc();
 
 		if (!page) {
 			dev_info_ratelimited(&vb->vdev->dev,
-- 
2.33.0



