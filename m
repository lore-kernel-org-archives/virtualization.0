Received: from mail-wm2-f13.google.com (mail-wm2-f13.google.com [74.125.225.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A59DE415B71
	for <virtualization@lists.linux.dev>; Wed, 23 Sep 2026 16:29:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790180975; cv=none; b=rDy30suJriZjmI9SIyxpFkDUeb0maC3U4uK5kFfywUY55adGd2f2jSYT/MTSdNsQsoTR+3dcP7qRymr4p3ijmyv6/aUWCXFWf5iIleJwnzIFNUvFE0eVvZDSqzkWmfHyC8/+SZYfbv9Id+e64m26YuD9v2YE2olLjkwlgrkmGl4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790180975; c=relaxed/simple;
	bh=irhQM6PxErm5/M+kv3sqG5uyQturgL5M9IxGLYEqK20=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TSt5wu6PIitwNdHJWSPjsD7wXyjGFFoG97OjnJ5v9sJaPzdLNNV+3T8ffD5+YRkwHj+FlzVpFzbmHJljEwphN4+rqVhZILoIkq/KZhmxQ3Pq+Ez1nKCoxidnBJJcKoPSpJ67H9XFqG2QRoZrvgBlSsIYj0TK5rq8KftKKJ4VATE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=getfieldwork.ai; spf=pass smtp.mailfrom=getfieldwork.ai; dkim=pass (2048-bit key) header.d=getfieldwork.ai header.i=@getfieldwork.ai header.b=V2XgE8hu; arc=none smtp.client-ip=74.125.225.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=getfieldwork.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=getfieldwork.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=getfieldwork.ai header.i=@getfieldwork.ai header.b="V2XgE8hu"
Received: by mail-wm2-f13.google.com with SMTP id 5b1f17b1804b1-49b912d822dso7972585e9.2
        for <virtualization@lists.linux.dev>; Wed, 23 Sep 2026 09:29:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=getfieldwork.ai; s=google; t=1790180971; x=1790785771; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=f/Oxl6B462qmt7DFjvZCs7ILkpn+AJOBiwnAliwsA84=;
        b=V2XgE8hu3168B4UpkCaHVU5XPJGx+AA1F0h10bBZcr63LjE98UqiphbsO2Wu8N4/Kg
         L4dBwT350rk+O8gzxJRuwxD1mDnI6q6+yUJF/wm/xaCf9IZrCXOebl0oaQeEMyGFpQDu
         Ejg6Haau8KVhAT9rUF516NeW4GHtGPTppcw28lscsKjLMdo4782CNNoRjSIaSLvcpWOa
         m8UzyjOzzyhS/sw4eMJxE0DdUdxfaSUzznYVdFjtEGQsn+QboaUpaJPo7zm6d6DiBWAc
         izXTOI80t5SqO6+GUcXJNL7ggT/ZesLkH00dpGm6OJlXpAoKu7Sr7ug2HHATxSxZ8G79
         ahSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790180971; x=1790785771;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=f/Oxl6B462qmt7DFjvZCs7ILkpn+AJOBiwnAliwsA84=;
        b=Wy+OtYVfXXlH/UDdbg57L+KUIVMdnd6oKYZSfafTm6d3xKIXRMXSfyHRkKHFNXWa7M
         D2nokxEM3W9GRt9/rBeLpjOBJxXKH3/tHqLQssFlJukLs6FL9MMtJEOddKj7dWxF0e1Z
         5cTBRzcfvW0Ehd6dPf1+/XvgPPJo5Q2YeG4HJLp3LiR2ROrPV6gJbEWo96jPMzxnp9R3
         zQmz/lCqFkeyurBLHcO8QGduAkRmFVx0GrwjSwD58VSu4pt3oxPXU9BPVPWr78mlvYQf
         1G1Stcsw/edUx2Q9JIx426oBW82evWgExFqo7Ht/F7spZ8O/imYAr9OucQB3IW9r/AsB
         NOsQ==
X-Forwarded-Encrypted: i=1; AKwUvBzx2VV4Q7A1Yw70xEVCB6bSfeNj27XfO0i4zLUqHnP7P7FMCP5hbteAuqO8fA8HoSEMUxSQSArXx72GvDGbCg==@lists.linux.dev
X-Gm-Message-State: AFuF++nR3sNGkDZ7hBd2jL6t1ZkvaCfM/Rr6rXWxDUuWCaK7JJVM5v0G
	Y30ojjV8mX1sW5NtyNSQ1Z2345GvsINgrC0uV9+v5MCju8XxDzZeBzH9dWAzwwmvhlN8
X-Gm-Gg: AYBFou2yBHSVErV6bo2Q9SCnY1qn67eD6J5HtgzMp0mUsAXZ7+x6KsalougatlgQrWB
	4TV+D6XZ7OSABbYksVogNvqZazYrv3vOVTpLayPhpNQk2ev8QSprK8SXI1i1fNlKRO8hSUyDPrG
	e5tS3K8eaSV1jl+FqnsMHkVPRO4pQA/xmTfljNIKuwxREWeAnIAknBYtAQ3hhTTEP7Zp47Id3Pk
	sPb6QK0A70qTcedLh7DWres47JA+6xR84k4QwRwzXQD5DWKOWPuVzde3gIvBApf/N+XbRcsSUl5
	yedtq2IUhuJJUixUFR1YmELmoi/oVRsKTaDiyVUs1p/cAj9De2wvK6tx+gxe8MKjXqQ2mcvWJT4
	4vWlRmEM6epEzImqD5fsI+1EQfkzFznd/sYyjYpAcR23QccD91gB9aXgkl3QJLqCRdRZwfAFA1t
	6f6j2c9CJ60Q3RExnnxV2uH++JSOABWjr5I+CLX9+1TCXAnc861W8I2uw3XxQUfgc91aGQ2nu9d
	Oud571KVaDsbAE7icN1XOKtfpQeEdslY2gB8jLAO+nUllohgMGejPZ8q+wolPqjUO+AQyO8suiA
	WmArArt+YtvxeqkBaT2KYN8p1iIBZe/gx18L+rcPVM40z45tAS3SErAflUoS
X-Received: by 2002:a05:600c:a416:b0:49f:e238:e7cb with SMTP id 5b1f17b1804b1-49fe238e887mr34015775e9.29.1790180970792;
        Wed, 23 Sep 2026 09:29:30 -0700 (PDT)
Received: from NicksFWMBP.taile41d51.ts.net ([2a00:23c8:b064:8301:d086:f104:dfd3:b00b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49fde1aa057sm87184355e9.13.2026.09.23.09.29.29
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 23 Sep 2026 09:29:30 -0700 (PDT)
From: Nick Rogers <nick@getfieldwork.ai>
To: Brian Daniels <briandaniels@google.com>
Cc: Mauro Carvalho Chehab <mchehab@kernel.org>,
	adelva@google.com,
	aesteve@redhat.com,
	changyeon@google.com,
	daniel.almeida@collabora.com,
	eperezma@redhat.com,
	gnurou@gmail.com,
	gurchetansingh@google.com,
	hverkuil@xs4all.nl,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	mst@redhat.com,
	nicolas.dufresne@collabora.com,
	virtualization@lists.linux.dev,
	xuanzhuo@linux.alibaba.com,
	dbassey@redhat.com,
	laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH v9 4/4] media: virtio: Add ioctl operations and driver logic
Date: Wed, 23 Sep 2026 17:29:28 +0100
Message-ID: <20260923162928.73497-1-nick@getfieldwork.ai>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260917171921.2810550-5-briandaniels@google.com>
References: <20260917171921.2810550-1-briandaniels@google.com> <20260917171921.2810550-5-briandaniels@google.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Hi Brian, Alexandre,

We have been running v9 on 6.18 in lighter, a macOS VMM, against a
host-side stateful decoder and encoder backed by VideoToolbox, with
ffmpeg 5.1 and 7.1 and GStreamer 1.26 in the guest. It works well; we
found three problems along the way, all in this patch, and have been
carrying the fixes below.

1. queued_bufs can drift until poll stops reporting the queue writable

virtio_media_qbuf() increments queue->queued_bufs after the device has
replied, without queues_lock. A device that completes the buffer before
it replies (ours decodes within the command) sends the DQBUF event while
the QBUF caller is still waiting, and the event's decrement races the
unlocked increment. When the decrement is lost, queued_bufs creeps up
until it equals allocated_bufs and the OUTPUT queue is never reported
writable again. With our device this stalled ffmpeg about once a minute.
Counting the buffer before the device can see it, under the lock, and
undoing that if the command fails:

--- a/drivers/media/virtio/virtio_media_ioctls.c
+++ b/drivers/media/virtio/virtio_media_ioctls.c
@@ -899,15 +899,20 @@
 	old_flags = buffer->buffer.flags;
 	buffer->buffer.flags = V4L2_BUF_FLAG_QUEUED;

+	mutex_lock(&session->queues_lock);
+	queue->queued_bufs += 1;
+	mutex_unlock(&session->queues_lock);
+
 	ret = virtio_media_send_buffer_ioctl(vfh, VIDIOC_QBUF, b);
 	if (ret) {
 		/* Rollback the previous flags as the buffer is not queued. */
+		mutex_lock(&session->queues_lock);
+		queue->queued_bufs -= 1;
+		mutex_unlock(&session->queues_lock);
 		buffer->buffer.flags = old_flags;
 		return ret;
 	}

-	queue->queued_bufs += 1;
-
 	return 0;
 }

2. poll does not report the CAPTURE queue readable after the LAST buffer

Once the LAST buffer has been dequeued, DQBUF on the CAPTURE queue
returns -EPIPE, which is how clients such as ffmpeg's v4l2m2m wrapper
learn the stream has ended. vb2 reports the queue readable in that
state (vb2_core_poll() checks last_buffer_dequeued) so the client goes
on to call DQBUF; virtio_media_device_poll() does not, so a client that
polls once more after a drain waits forever. Debian's ffmpeg 5.1 does
exactly that at the end of a stream with no B-frames:

--- a/drivers/media/virtio/virtio_media_driver.c
+++ b/drivers/media/virtio/virtio_media_driver.c
@@ -633,7 +633,8 @@
 		    (capture_queue->queued_bufs == 0 &&
 		     list_empty(&capture_queue->pending_dqbufs)))
 			rc |= EPOLLERR;
-		else if (!list_empty(&capture_queue->pending_dqbufs))
+		else if (!list_empty(&capture_queue->pending_dqbufs) ||
+			 capture_queue->is_capture_last)
 			rc |= EPOLLIN | EPOLLRDNORM;
 	}
 	if (req_events & (EPOLLOUT | EPOLLWRNORM)) {

3. VIDIOC_G_CTRL and VIDIOC_S_CTRL fail with -EINVAL

The driver has no control handler, so the V4L2 core turns G_CTRL and
S_CTRL into a single extended control and calls the driver's
g/s_ext_ctrls. That control is built on the core's stack, and its size
field is never initialized; virtio_media_send_ext_controls_ioctl() takes
a nonzero size as a payload to copy from userspace, and the ioctl fails.
GStreamer's V4L2 encoders set their profile with S_CTRL and cannot
negotiate, and v4l2-ctl cannot read the MIN_BUFFERS controls.

The fault is really in the core, which should hand drivers a zeroed
structure, and I have sent a patch for that separately [1]. Until it
lands the driver sees garbage there, so you may also want to guard
against it; we have been clearing size when the controls array is on
the stack, which only the core's G/S_CTRL translation produces.

[1] https://lore.kernel.org/all/20260923160936.33445-1-nick@getfieldwork.ai/

Thanks for the driver,
Nick Rogers
