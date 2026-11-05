Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.176
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793862566;
	b=FTV4VkJJnyk024jxaCATBRlzldjEkYv+uhClAzqzHCoL7E95OX/8+49JmlbkG1btSOFF
	 AoI+l93qtwPg447CsjhrPIXWnoVJHqd5eYKkOL2vyD37t9uY/xTQMM7BfHIUg/xSBdADM
	 wRyRaMYK3hNSR5B8M1rno3QAeiIbYsFkkUPa3Ix3A/jFUbk/CZy0zGjyVS4uOuWPGNbIe
	 B14Fd4FpYJv3cb1eoOD0571Ltb3EMuJHa3YA3Ps1i5MnD3zcWnG6+IRjDy/VeoAAypAj3
	 IYnryoky4uB9Uq5jWhXEJjeANDaA21D+sU/LtW7HgqeZHP3NRnz+U+IPGtL7ZqGo+RQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793862566;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=uAb7bK+oRWXf9bD+sbQ9BK8EE9xp2VcjvnyDo4nUrT0=;
	b=vhlsLBfe8XUjAPyiaufgndDLSwxevYijsBH8Kft75rpXCSJYC/NZgmJs0gNrSWBw7Zy6
	 MX4W3Lc/UrAW8fbusnf273OXa7uKaqUImi03rNehBYj3BdduDzfIE+Q8nME6kEeeu+6nU
	 OwB0kwi+6XHj7N+E/dyKqPakB3DNfAW3+entxvEQ+gCfU2JQQpW6ZyKAqtNKUtjWTjdZ6
	 4LnQJrm1pBHBL7sFjbwtHxapzomJQ4m37YJIvodQf2i9Pd7YWZaG1RQigCMuPl7maK6oI
	 yIiHetsq5OYrf8F4YaHHii/o4TfXdyWb6l25+6DcHehElwKTWJd7I6faGFAlV8sYrqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jBXyLWHn;
	arc=none smtp.remote-ip=74.125.82.176
Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5007606D827
	for <virtualization@lists.linux.dev>; Thu,  5 Nov 2026 07:09:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E5007606D827
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=jBXyLWHn
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-3282db206d3so2995693eec.0
        for <virtualization@lists.linux.dev>; Wed, 04 Nov 2026 23:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793862565; x=1794467365; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=uAb7bK+oRWXf9bD+sbQ9BK8EE9xp2VcjvnyDo4nUrT0=;
        b=jBXyLWHnFnl/2j66bBlS5tBq8eWZjbgehOnmrdINeKo6rGCYmsKO6Uq0OjWuuUOcwf
         Bqhfj00XUULLD6KZq+ZXO8y2GLgIH1R1tq9BqDIp9OYykiF8XVZW0ud875uOdULOMMJz
         VfWEzKgTN4tuUN1IsHkGB0OPSGmAZ++LDh1lgUQmYvTMGmc9xL9aPEJGJff3jCMH55kV
         5vUSdgyLTB1e38FwMMkNEbhzbzBThsED5uPj8s/MDgXMX6m2yU4TgYwcTAxwRDRMoZ+I
         KAFp+jnVELKs1jUVs9+xboKj3gW7Cbd0WSUIYmz1zG5CsHdqjsoWyI/Itd7zu7kQAAns
         Hc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793862565; x=1794467365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=uAb7bK+oRWXf9bD+sbQ9BK8EE9xp2VcjvnyDo4nUrT0=;
        b=iys5eyyfJOzf/GPHiqv3JnKrwDSnutCiKWHhWCFDisHMY/CpPJtPn5c5q1GJGDRPgK
         Z+imqw+YRYl9S8fcVaMmpTyiaoqQ4lGkcImF/pfzmXWBX2XpUS+9FUzENf4Q9YZwVMHf
         3LZE1s3XwBHJnCTlRxWJSnul6OsHDcybSg8zS/C5QyWQKkz5p4kd+NcQQZC/4wVIGDH8
         W+tBvGoxngyWWTPV57lep0XvyQVi33EISUhBl14jndpjUlrT2pgsW6fHsIiqF2OT++Gq
         sugzhjcGek3dlsLXQ4yx6CImQSY9bo2gYALDKiWd0a+zJlSb3m8oyJjdCRPrbbzd3kdX
         e+lg==
X-Forwarded-Encrypted: i=1; AKwUvBxW5ASLeu2iz/5djdu2u3at+czf/ly1+gruY5ZA6EVTTjpv3TPM3oxErgdubSW9wiFp9tnhl+3TBr2vKXSUdg==@lists.linux.dev
X-Gm-Message-State: APuU4Z/WuqjS/PJ87Zwdt0vWXD44iJWNv4Hw6SOUUJUeEA9k3zxal/lI
	Wh+t+TRKzVU2TQ7RguX4W0Wkned7xx8TelwqJ3wItGmFhyWxRGqu40Su
X-Gm-Gg: AYBFou1FA7X4U6QiM7KFqnZCfAkNoTpfjWjdUbTtW7e2E5Ci+usBFqujJfnMNmeywvG
	qe3Lw9qNhDwznLjwV3LqPmmPUv3XmjiWViroZiy9CAR+YtG2Ogui1tnEUqTR9Gg8YfDJ05XGLPi
	7sKpq3LIhHNV70Uqnd/hmiYcE0bMZEbXQ+2ylgQZxtQD/LiHeygMDrU8QO3EtUFhNbyZx8ShKDc
	/kg4LJUA/VRRKH9+iSQjxCbFArXBwpeylMAnteEVQJf8XBUCS0wOUWXNV1VX9qh7aciP048n7GS
	9BeM9+a6gjRrb07OvAh0O5Q2jmwCJQQaaLhEQoARuEPqJKnc7rROPvJkOJPwNekZJhK6hBnlomQ
	0pTs07fx3q2lka0mcBkQp1Wjpv4TJ6y1qygZD/bOmQ/Se/nJUKtkYoMgPPwA5ee9mKzIa6NsMDh
	peKD/jb4cP7EHNJPcctnXmw3RqI1d0jZy+1Us4sms3N/2OudxxBita49xzta1Ri47cUH7skpQyS
	mZKlOY8hxijVaqPgoaEuvPhTdG9klzDSd/EEuc8NCHE0wcpVi+sAHf9yilAShUQH4rpqw4bdHHf
	EIKcFdHEv85AcUrZSlEPMmtqlPvuD7M9eAe0NuQOhkmr4ivcSLBoAjh7hZ+Fa8ZEW22tj3d6V6V
	j6A/J6h1Q4N2gHBhrDMrv1S/9q13nm3m2XRfOt0sOyc3fx3o=
X-Received: by 2002:a05:693c:6391:20b0:36a:21b8:b6c4 with SMTP id 5a478bee46e88-36a423408a1mr27278440eec.8.1793862564710;
        Wed, 04 Nov 2026 23:09:24 -0800 (PST)
Received: from localhost.localdomain ([183.96.175.225])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-36ca3981ff0sm16812286eec.24.2026.11.04.23.09.21
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 04 Nov 2026 23:09:24 -0800 (PST)
From: Joonho Lee <mynameisjune111@gmail.com>
To: linux-sound@vger.kernel.org
Cc: tiwai@suse.com,
	perex@perex.cz,
	anton.yakovlev@opensynergy.com,
	mst@redhat.com,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	corbet@lwn.net,
	skhan@linuxfoundation.org,
	rdunlap@infradead.org,
	linux-doc@vger.kernel.org,
	Joonho Lee <mynameisjune111@gmail.com>
Subject: [PATCH v17 09/12] ALSA: virtio: wait through signals for PCM teardown
Date: Thu,  5 Nov 2026 16:08:42 +0900
Message-ID: <20261105070845.6449-10-mynameisjune111@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261105070845.6449-1-mynameisjune111@gmail.com>
References: <20261105070845.6449-1-mynameisjune111@gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A signal can end the interruptible wait while a STOP or RELEASE request
is still pending. A later teardown may then submit another RELEASE
before the first request completes.

Keep both waits non-interruptible and use the existing message timeout.
Other control requests remain interruptible. Device reset still cancels
the pending request and wakes the waiter.

Keep completion timeout and wait return values wide enough for the full timeout range on 32-bit and HZ=1000 builds.
Signed-off-by: Joonho Lee <mynameisjune111@gmail.com>

---
sound/virtio/virtio_ctl_msg.c |   19 ++++++++++++++++---
 sound/virtio/virtio_ctl_msg.h |    3 +++
 2 files changed, 19 insertions(+), 3 deletions(-)

diff --git a/sound/virtio/virtio_ctl_msg.c b/sound/virtio/virtio_ctl_msg.c
--- a/sound/virtio/virtio_ctl_msg.c
+++ b/sound/virtio/virtio_ctl_msg.c
@@ -265,7 +265,7 @@
 {
 	struct virtio_device *vdev = snd->vdev;
 	struct virtio_snd_queue *queue = virtsnd_control_queue(snd);
-	unsigned int js = msecs_to_jiffies(virtsnd_msg_timeout_ms);
+	unsigned long js = msecs_to_jiffies(virtsnd_msg_timeout_ms);
 	struct virtio_snd_hdr *request = virtsnd_ctl_msg_request(msg);
 	struct virtio_snd_hdr *response = virtsnd_ctl_msg_response(msg);
 	unsigned int nouts = 0;
@@ -273,7 +273,7 @@
 	struct scatterlist *psgs[4];
 	bool notify = false;
 	unsigned long flags;
-	int rc;
+	long rc;
 
 	virtsnd_ctl_msg_ref(msg);
 	/* This reference stays with the queue until completion or teardown. */
@@ -314,7 +314,20 @@
 		 */
 		virtsnd_ctl_msg_unref(msg);
 	} else if (!nowait) {
-		rc = wait_for_completion_interruptible_timeout(&msg->notify, js);
+		/*
+		 * Teardown must observe completion even with a pending signal.
+		 * Otherwise a subsequent open can retry RELEASE while the device
+		 * is still processing the previous teardown request.
+		 */
+		switch (le32_to_cpu(request->code)) {
+		case VIRTIO_SND_R_PCM_STOP:
+		case VIRTIO_SND_R_PCM_RELEASE:
+			rc = wait_for_completion_timeout(&msg->notify, js);
+			break;
+		default:
+			rc = wait_for_completion_interruptible_timeout(&msg->notify, js);
+			break;
+		}
 		if (!rc) {
 			dev_err(&vdev->dev,
 				"control message (0x%08x) timeout\n",
diff --git a/sound/virtio/virtio_ctl_msg.h b/sound/virtio/virtio_ctl_msg.h
--- a/sound/virtio/virtio_ctl_msg.h
+++ b/sound/virtio/virtio_ctl_msg.h
@@ -47,6 +47,9 @@
  * The msg_timeout_ms module parameter defines the message completion timeout.
  * If the message is not completed within this time, the function will return an
  * error.
+ * PCM STOP and RELEASE wait through pending signals within this timeout.
+ * Other requests remain interruptible. Device reset cancels and wakes either
+ * kind of waiter.
  *
  * Context: Any context that permits to sleep.
  * Return: 0 on success, -errno on failure.
