Received: from smtp.smtpout.orange.fr (smtp-20.smtpout.orange.fr [80.12.242.20])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5BDA41802A
	for <virtualization@lists.linux.dev>; Sun, 10 Dec 2023 18:22:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="mkWMq5TB"
Received: from pop-os.home ([92.140.202.140])
	by smtp.orange.fr with ESMTPA
	id CNy4r77eNxqX7CNy4r8b6X; Sun, 10 Dec 2023 18:51:56 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1702230716;
	bh=I+oLHrfSteD1fM5wZcNGUaFi+cT/ZUrP8W7m+tITsR4=;
	h=From:To:Cc:Subject:Date;
	b=mkWMq5TBbq7Mt5b0vqjmNsCy44MG2vlYUyENYi5GtepUNxLqKPZnXgx5x90e79Xu4
	 kK3Vk+ulADvk2FkP248VX7Nx2QyglnFw5TqYDsn7aN28tqEIrdMloZ/tBfOAmG2DDf
	 JD5mPXyCkPWtBy3/fQJZosYogQcBjzVHqnHODhTGFHouy6YOb+U5QaYoo5F6B0faif
	 slLqRoNkhCuRZx2G+d93TRM2X94o1VS/eKxPUpdPyykrBBfePH5piqer/h0nY4WPvy
	 hJCBt1nMacbOMxAbnocPtbXHqgW195NJCgVcgIZOC0ptbTnaXsbiV3IvRJpOGXEn3r
	 kN/rjptAc/3Ug==
X-ME-Helo: pop-os.home
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 10 Dec 2023 18:51:56 +0100
X-ME-IP: 92.140.202.140
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org,
	Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
	virtualization@lists.linux.dev
Subject: [PATCH] vdpa: Remove usage of the deprecated ida_simple_xx() API
Date: Sun, 10 Dec 2023 18:51:50 +0100
Message-Id: <d7534cc4caf4ff9d6b072744352c1b69487779ea.1702230703.git.christophe.jaillet@wanadoo.fr>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ida_alloc() and ida_free() should be preferred to the deprecated
ida_simple_get() and ida_simple_remove().

This is less verbose.

Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
---
 drivers/vdpa/vdpa.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/vdpa/vdpa.c b/drivers/vdpa/vdpa.c
index a7612e0783b3..d0695680b282 100644
--- a/drivers/vdpa/vdpa.c
+++ b/drivers/vdpa/vdpa.c
@@ -131,7 +131,7 @@ static void vdpa_release_dev(struct device *d)
 	if (ops->free)
 		ops->free(vdev);
 
-	ida_simple_remove(&vdpa_index_ida, vdev->index);
+	ida_free(&vdpa_index_ida, vdev->index);
 	kfree(vdev->driver_override);
 	kfree(vdev);
 }
@@ -205,7 +205,7 @@ struct vdpa_device *__vdpa_alloc_device(struct device *parent,
 	return vdev;
 
 err_name:
-	ida_simple_remove(&vdpa_index_ida, vdev->index);
+	ida_free(&vdpa_index_ida, vdev->index);
 err_ida:
 	kfree(vdev);
 err:
-- 
2.34.1

