Received: from njjs-sys-mailin01.njjs.baidu.com (mx311.baidu.com [180.101.52.76])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A25363101
	for <virtualization@lists.linux.dev>; Wed, 24 Jan 2024 12:16:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=180.101.52.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706098618; cv=none; b=PjXSI1uRCuLlymDUCIsb87WVdKt3+YE8VZjgcZ23ZGYGQj9aToOrIPOUQH4b+mdRdXka5MaoGLnPFvaGElHxlWyYAEDwq0B2fzFvdS/3wwIi2TlwV3i3Y0zbE8bBTcTgSSNOZ2PLVQL9iPPB62wolTftbPDsMyIXd7Iltlfaxdw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706098618; c=relaxed/simple;
	bh=C5c4sH4CaI7m2M5NSlfinxL7zAECwlDceD08znN1xdQ=;
	h=From:To:Cc:Subject:Date:Message-Id; b=jJDi5I9LbmySta1RlpptLSOl9nGjKuHEPORGFB5lZj6g0iMJfOR1O42OYpJqjVwKHNvQf/P+4QM7o+txG/eR6Yad3ZE5iMs48BPUjXEn4Zs1jQCZ3wIlYVQrDHQ1EbZoL/JT/iMk8HlFkX/7JGxp8GFLefI5At8iV3XpfFG7QO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com; spf=pass smtp.mailfrom=baidu.com; arc=none smtp.client-ip=180.101.52.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=baidu.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baidu.com
Received: from localhost (bjhw-sys-rpm015653cc5.bjhw.baidu.com [10.227.53.39])
	by njjs-sys-mailin01.njjs.baidu.com (Postfix) with ESMTP id 8CFB67F0003D;
	Wed, 24 Jan 2024 20:08:38 +0800 (CST)
From: Li RongQing <lirongqing@baidu.com>
To: anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	perex@perex.cz,
	tiwai@suse.com,
	virtualization@lists.linux.dev,
	alsa-devel@alsa-project.org,
	linux-sound@vger.kernel.org
Cc: Li RongQing <lirongqing@baidu.com>
Subject: [PATCH] ALSA: virtio: remove duplicate check if queue is broken
Date: Wed, 24 Jan 2024 20:08:34 +0800
Message-Id: <20240124120834.49410-1-lirongqing@baidu.com>
X-Mailer: git-send-email 2.9.4
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>

virtqueue_enable_cb() will call virtqueue_poll() which will check if
queue is broken at beginning, so remove the virtqueue_is_broken() call

Signed-off-by: Li RongQing <lirongqing@baidu.com>
---
 sound/virtio/virtio_card.c    | 2 --
 sound/virtio/virtio_ctl_msg.c | 2 --
 sound/virtio/virtio_pcm_msg.c | 2 --
 3 files changed, 6 deletions(-)

diff --git a/sound/virtio/virtio_card.c b/sound/virtio/virtio_card.c
index e2847c0..b158c3c 100644
--- a/sound/virtio/virtio_card.c
+++ b/sound/virtio/virtio_card.c
@@ -91,8 +91,6 @@ static void virtsnd_event_notify_cb(struct virtqueue *vqueue)
 			virtsnd_event_dispatch(snd, event);
 			virtsnd_event_send(vqueue, event, true, GFP_ATOMIC);
 		}
-		if (unlikely(virtqueue_is_broken(vqueue)))
-			break;
 	} while (!virtqueue_enable_cb(vqueue));
 	spin_unlock_irqrestore(&queue->lock, flags);
 }
diff --git a/sound/virtio/virtio_ctl_msg.c b/sound/virtio/virtio_ctl_msg.c
index 18dc5ac..9dabea0 100644
--- a/sound/virtio/virtio_ctl_msg.c
+++ b/sound/virtio/virtio_ctl_msg.c
@@ -303,8 +303,6 @@ void virtsnd_ctl_notify_cb(struct virtqueue *vqueue)
 		virtqueue_disable_cb(vqueue);
 		while ((msg = virtqueue_get_buf(vqueue, &length)))
 			virtsnd_ctl_msg_complete(msg);
-		if (unlikely(virtqueue_is_broken(vqueue)))
-			break;
 	} while (!virtqueue_enable_cb(vqueue));
 	spin_unlock_irqrestore(&queue->lock, flags);
 }
diff --git a/sound/virtio/virtio_pcm_msg.c b/sound/virtio/virtio_pcm_msg.c
index 542446c..8c32efa 100644
--- a/sound/virtio/virtio_pcm_msg.c
+++ b/sound/virtio/virtio_pcm_msg.c
@@ -358,8 +358,6 @@ static inline void virtsnd_pcm_notify_cb(struct virtio_snd_queue *queue)
 		virtqueue_disable_cb(queue->vqueue);
 		while ((msg = virtqueue_get_buf(queue->vqueue, &written_bytes)))
 			virtsnd_pcm_msg_complete(msg, written_bytes);
-		if (unlikely(virtqueue_is_broken(queue->vqueue)))
-			break;
 	} while (!virtqueue_enable_cb(queue->vqueue));
 	spin_unlock_irqrestore(&queue->lock, flags);
 }
-- 
2.9.4

