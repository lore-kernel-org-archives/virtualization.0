Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50F9238B9AF
	for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 15:44:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768837444; cv=none; b=kR+H/9RQiZ2gMDgDHEiSFX7FS92kgXke0b22yPQajeY4xCjoNE6OytKQ/RBluZj1ghxVkgC4hXRFrEUvz4LFFM7ippDAOs79aZYAdCac7vH2FmDxpxWUjg6HR3NJGj5MPqn1i0teBS97gPE08o0VA7POgGF36weAiS0Y+B5mfPw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768837444; c=relaxed/simple;
	bh=2HuE6tbSpLQ62H6pjoqaeKbW/rufO55isJK3aHLjh8U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kKYjFyzP2tEV+WtpzqwAgEvjudFnHox/9N/kxQ0qIWGJXqW3vhzO+OAADl6RG0Smzd5OAaf8UnueLVW27nTGejT0gJSHNhDHiiWUgQ+Qlt9QtOm1SzlQ/lBEsf4lMy0j7jFbroG92uleE6KrRaOBxNdTGfs3Md9UrKjc+sq9D4c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ho/XNJ3U; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ho/XNJ3U"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-47ff94b46afso29215145e9.1
        for <virtualization@lists.linux.dev>; Mon, 19 Jan 2026 07:44:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768837442; x=1769442242; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=EWJKJQsunGDWGcktrSRSGAJYI4Y83xT0WkUFHjnbal0=;
        b=Ho/XNJ3UXEuJtad+aMn/0gt2kchxoNyKMyizSCcf1HM4NRXYbxZitcmuT6gYMZ2TyE
         lZqMz50qfFecfOlWEYUyoYHxbTz7c1YQvzwlMwNtpPnmvnKMw2/DUT3MZ5ieZUPDACWM
         9OivT59z69GrP92aqY5vNG30Dsq/fs6QwxB5t4v9c7+w+aJNpkV6gwxcu6qpBgDkedaG
         bP2TR6Sv+mQMYG5yl6eBV45jXv9DLq+R9FKQv+CEkr33suU9U3FuzI6Uxju5qiNBTG3u
         VI1j5s2sr6EjwPcCuW2d+wKvHwR+INgSgIqZvlf0bB8JjoAnDsvsgPLs68JDlZIgA+yS
         yyTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768837442; x=1769442242;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EWJKJQsunGDWGcktrSRSGAJYI4Y83xT0WkUFHjnbal0=;
        b=PilWxWejiU7RJldml0Vth/Tl86m4jBc+QOcNqblvhgL4PTPtFyNaqhj2NN+g3gTVEc
         vQ48SsDumbv2LBC8f+ukrRW+yNUwu8RKusYO6mSsmKyGyb5IMp4H4O+6wql+8V88c9oD
         ODp/injSI8YeOoELffqjxUmwN3sqt0A5W9A2eua0GCAtemI2v15h9Bc8QnkAp4m3fK3k
         WQSj5agrfLgQI+I7EEe41+qzzUtmijnXcn2IE+xF8we9jo1qVZZ7xf3xpz2nT4L6xDOW
         QDb2q7hjp++NiUlMsObdMZJjWMP23u8ie+ktWnoiLTpB7v05F/euxKYF719KfhcYGujB
         wzOg==
X-Forwarded-Encrypted: i=1; AJvYcCUi0X9fqHhDJTnEC8j5AeVSb3kbF9/swNXH+Roc3aRDDn77c7IrVGp4/mrUndIFRwyEP+fXuchIAMJmPxn79Q==@lists.linux.dev
X-Gm-Message-State: AOJu0Ywq3T2J6Y80HJQepcJMwm5saLsSUudVUr9bsAnb2cftMZxWjThr
	1b7PwmlrG/WPZCdgO5vABh5V3lW6gLPH8c7ks7JJAoKVyVQNNRQYJb08
X-Gm-Gg: AY/fxX5jNbVF8CzNrL4uQDgrsaTwRzpfWbsOIiAUPMWNMfpP6zRsXPYPV5+BhadyFvR
	8fETEEXSJ0LSq5p/g5LtyFDTtWG2KAqixmvmz06BvdHrIQTECCnyjJU6ReNuxtLh4j/gkdrN/7m
	l3xhPpdwM8bJY1sRMOU1teBV4I4hjKYR9pKJfLWEYuqCN1lsz9lU6DKmkS0cmu3kpUoRshrkItL
	66ra38doHXnSiSk+rGeUaLBn+LDj1fpvaEG4sEB1GZkShLWlrAIjUdFrzbxxzjgFFj0gPAJ1EQw
	Sa4l9OnsrrEuInK4XIBHPQlRY2DDrLU+FGYbE532rZYUpe3Iq15gMVpPI9E7QJE44mdkr3N3smK
	Cqjms75VmiiCnCZHgEU6WK/Oge/I2GS2QJdK2lKOnMMnk4JSbtalAEdfE55E8+xV6X+1bfMw9ax
	Pa623WL4U1Vnu5ESAhlF7e/H4mqNLV56jQX0RY48wl5LLSkB8wJGrVqM/IQIEGb9+GQw==
X-Received: by 2002:a05:600c:8b6c:b0:46e:2815:8568 with SMTP id 5b1f17b1804b1-4801e66fcc5mr130852245e9.10.1768837441407;
        Mon, 19 Jan 2026 07:44:01 -0800 (PST)
Received: from f4d4888f22f2.ant.amazon.com.com ([15.248.2.27])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-47f428ac749sm261155365e9.5.2026.01.19.07.44.00
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 19 Jan 2026 07:44:01 -0800 (PST)
From: Jack Thomson <jackabt.amazon@gmail.com>
To: mst@redhat.com,
	david@kernel.org,
	jasowang@redhat.com
Cc: xuanzhuo@linux.alibaba.com,
	eperezma@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	kalyazin@amazon.co.uk,
	xmarcalx@amazon.co.uk,
	jackabt@amazon.com
Subject: [RFC PATCH] virtio_balloon: Support wait on ACK for hinting
Date: Mon, 19 Jan 2026 15:42:36 +0000
Message-ID: <20260119154236.39412-1-jackabt.amazon@gmail.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jack Thomson <jackabt@amazon.com>

This RFC patch adds a new virtio feature for the virtio-balloon driver
during free page hinting, which will wait on device ack before
committing the range to the free_page_list. The reason for the change is
it allows the device to modify this range without it being reclaimed
from the free_page_list before the ack is sent. As expected, testing
shows this adds overhead to the hinting run duration, increasing it by
~30% with our Firecracker setup. Currently free page hinting is used
mainly for live migration, but this would open it up for a new use-case.

We would like to leverage this with MADV_DONTNEED to reduce RSS of a
guest. We'd like to use hinting because of the flexibility of control it
brings compared to reporting, allowing memory to be reclaimed in
deterministic periods. The traditional balloon device was tested to be
much slower when compared to hinting for these workloads. Currently,
without this synchronization, hinted pages may be reclaimed from the
free list before the device finishes processing them, making hinting
unsuitable for this use-case.

Signed-off-by: Jack Thomson <jackabt@amazon.com>
---
 drivers/virtio/virtio_balloon.c     | 21 ++++++++++++++++++---
 include/uapi/linux/virtio_balloon.h |  1 +
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 74fe59f5a78c..82b560422279 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -596,8 +596,11 @@ static int init_vqs(struct virtio_balloon *vb)
 		vqs_info[VIRTIO_BALLOON_VQ_STATS].callback = stats_request;
 	}
 
-	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
+	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT)) {
 		vqs_info[VIRTIO_BALLOON_VQ_FREE_PAGE].name = "free_page_vq";
+		if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_HINT_WAIT_ON_ACK))
+			vqs_info[VIRTIO_BALLOON_VQ_FREE_PAGE].callback = balloon_ack;
+	}
 
 	if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_REPORTING)) {
 		vqs_info[VIRTIO_BALLOON_VQ_REPORTING].name = "reporting_vq";
@@ -669,8 +672,11 @@ static int send_cmd_id_start(struct virtio_balloon *vb)
 					virtio_balloon_cmd_id_received(vb));
 	sg_init_one(&sg, &vb->cmd_id_active, sizeof(vb->cmd_id_active));
 	err = virtqueue_add_outbuf(vq, &sg, 1, &vb->cmd_id_active, GFP_KERNEL);
-	if (!err)
+	if (!err) {
 		virtqueue_kick(vq);
+		if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_HINT_WAIT_ON_ACK))
+			wait_event(vb->acked, virtqueue_get_buf(vq, &unused));
+	}
 	return err;
 }
 
@@ -686,8 +692,11 @@ static int send_cmd_id_stop(struct virtio_balloon *vb)
 
 	sg_init_one(&sg, &vb->cmd_id_stop, sizeof(vb->cmd_id_stop));
 	err = virtqueue_add_outbuf(vq, &sg, 1, &vb->cmd_id_stop, GFP_KERNEL);
-	if (!err)
+	if (!err) {
 		virtqueue_kick(vq);
+		if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_HINT_WAIT_ON_ACK))
+			wait_event(vb->acked, virtqueue_get_buf(vq, &unused));
+	}
 	return err;
 }
 
@@ -722,6 +731,8 @@ static int get_free_page_and_send(struct virtio_balloon *vb)
 			return err;
 		}
 		virtqueue_kick(vq);
+		if (virtio_has_feature(vb->vdev, VIRTIO_BALLOON_F_HINT_WAIT_ON_ACK))
+			wait_event(vb->acked, virtqueue_get_buf(vq, &unused));
 		spin_lock_irq(&vb->free_page_list_lock);
 		balloon_page_push(&vb->free_page_list, page);
 		vb->num_free_page_blocks++;
@@ -1186,6 +1197,9 @@ static int virtballoon_validate(struct virtio_device *vdev)
 	else if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_PAGE_POISON))
 		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_REPORTING);
 
+	if (!virtio_has_feature(vdev, VIRTIO_BALLOON_F_FREE_PAGE_HINT))
+		__virtio_clear_bit(vdev, VIRTIO_BALLOON_F_HINT_WAIT_ON_ACK);
+
 	__virtio_clear_bit(vdev, VIRTIO_F_ACCESS_PLATFORM);
 	return 0;
 }
@@ -1197,6 +1211,7 @@ static unsigned int features[] = {
 	VIRTIO_BALLOON_F_FREE_PAGE_HINT,
 	VIRTIO_BALLOON_F_PAGE_POISON,
 	VIRTIO_BALLOON_F_REPORTING,
+	VIRTIO_BALLOON_F_HINT_WAIT_ON_ACK,
 };
 
 static struct virtio_driver virtio_balloon_driver = {
diff --git a/include/uapi/linux/virtio_balloon.h b/include/uapi/linux/virtio_balloon.h
index ee35a372805d..86698ab06261 100644
--- a/include/uapi/linux/virtio_balloon.h
+++ b/include/uapi/linux/virtio_balloon.h
@@ -37,6 +37,7 @@
 #define VIRTIO_BALLOON_F_FREE_PAGE_HINT	3 /* VQ to report free pages */
 #define VIRTIO_BALLOON_F_PAGE_POISON	4 /* Guest is using page poisoning */
 #define VIRTIO_BALLOON_F_REPORTING	5 /* Page reporting virtqueue */
+#define VIRTIO_BALLOON_F_HINT_WAIT_ON_ACK	6 /* Page hinting waits on device ack */
 
 /* Size of a PFN in the balloon interface. */
 #define VIRTIO_BALLOON_PFN_SHIFT 12

base-commit: 24d479d26b25bce5faea3ddd9fa8f3a6c3129ea7
-- 
2.43.0

