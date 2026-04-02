Received: from mail-dy1-f169.google.com (mail-dy1-f169.google.com [74.125.82.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDF5B299943
	for <virtualization@lists.linux.dev>; Thu,  2 Apr 2026 04:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775105220; cv=none; b=hso0McSul6Y/QizX12wq7ujVPBn93t/pLTWwg24srcRNBFIM46sOhum2wz3n2+uUdMXJQG16FSMh9uVbEoi6k09i/K02VFbOZ2l/967HCzmL6YLYch27TLn33PDf6um3+E2jjivrRnx7+XXqTl3C8xBvKKQwlD9hfTeQ85aDgpY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775105220; c=relaxed/simple;
	bh=jV5CWtutJqLa16q3x6lGkU+AgLFtOqIMJk0X4qmwhUc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=WT3lalUcEuFcVzfe+02yFo0bzHneFrLj6HkxacIGOLdmlQIO3Exnd6wcz6n5wdfauHgBX3gq4gZ7TXhFoY7P8LfwxgBh5YEOPc+M3xeuWBnnzgP10vOHTl9zKlGtMTlsVm16LNjFMq8na+IGZLZywadvs5S2qrT9ItPkyNUXUYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AX4k43VR; arc=none smtp.client-ip=74.125.82.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AX4k43VR"
Received: by mail-dy1-f169.google.com with SMTP id 5a478bee46e88-2c87871133dso658238eec.0
        for <virtualization@lists.linux.dev>; Wed, 01 Apr 2026 21:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775105218; x=1775710018; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yNPRt9AdqdMzFCaTU2ZjYAQXhCSBuqIya6uWjrlqzLU=;
        b=AX4k43VRAsVB5yZGRhPHnGuh375H5XlbrwoeU2Zx5IcmmeJeXpU2pPKs68uiNACCCM
         7DU1yTIVlZebMqWah4xrw2xhaVghvAUZ3ZcBIaoGgkmjc69j8DkBTSKOiWeI9a6ltQbi
         8T81cCw4Xv8IzjNmiflyUyIn7l6rPdTM2CGfof4u20Rx5RLGK5vtKhZKtisoUE/FJ/jY
         u7Wxhg92cpXBVccnEJPp2q91RRcCScbzisJhI/qNtBOF9OCbU66sYg6FNyG6iTRsjQLM
         a1bhE5hdnR2k33exKGiYBelPCIY3flD7WKrG4qOduv4PRuH2+j1DV3Fygung5FVS/B5E
         GRCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775105218; x=1775710018;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yNPRt9AdqdMzFCaTU2ZjYAQXhCSBuqIya6uWjrlqzLU=;
        b=EzHdFhp9eIsdjfp52eEIWBT9PVLkcwlMSU06/dqly70T1x2YrsHUYstpsgHG2V40Ol
         C0IseDqwoJ9yBIXh587a2xQ0KkH0vsryOX8Qg1emPlq0ND1q5upSEio6SGJ4GU5QrfS7
         L69bxdfb11DAcyqw09BQiUsYG3adVXV6T9lLDDgMrj9TwM/oYQfjuDahj9A/+GkCK4Te
         V9ZXAEUohd5nIrzy3x2e1fBXO+yV34Tv6FB084AzN5g0iyxXdCTekZltIzeIkpFm200x
         qRLkR9ppDJ8fQaauXCXei3odhiv1JHSNDM1e9r6lWqWvJy5tSFIIkdye0Vvzd0gnGU8+
         r98Q==
X-Gm-Message-State: AOJu0YwQc7EmfZmpoQqLuPq7rDbgDW4iYCzCDC6KXBzE02AgLAh0ujak
	0KKg+xQHpt9eWP9LnOc7H7vbKwH58h2KqgE0iLpO/gf8o+3pvQkLXJzA
X-Gm-Gg: ATEYQzyZDHQYPtqPgJeFn0aWjrwk1rXibjINmk7hak1km4lGI3JA215tvnPblEtJqcV
	CKfi03cPCLUHX7j+BNCMBjJ0OntfNKHrpDfPYZA/B7pSHHwx+0o7jKdQM0xEaQjAv2s5dP6C+er
	eoomtUNkTPvbzhbvqHzs+RglMmV9EoulnGYZ2Uy/Gcu4+LAAjmXjd2whb7Vy+OwjZt1pD87kMuu
	GsteiuxoJmVX59ODY+WNs5Dq3rTg8m1KkFpbvuJWAA0MJqBaauh3P7mhOCi5TNi8aQ283yU9t26
	xDaHqzyoGqxCckfU+VVhEUeJ4kzm69iXGXGCUpNe1mryw56a7vwch/NQ9htJGVDVDnuEm2hAaY7
	LKYMe+s3EAyXKYgQdVNJQB5K41qE6+p7N95rdrnBQ13XDdKpcF7yOnkc8QA+uLWFBiXShd0CaR8
	OvQrPQ41zPy/Sq9UNoR2uWlHOo8na7x9Y1ZUrBbIIxo2w6FFRV/LI9V3QAA7nU
X-Received: by 2002:a05:7300:724b:b0:2c5:30ed:5e99 with SMTP id 5a478bee46e88-2ca8dbde026mr1140306eec.14.1775105217820;
        Wed, 01 Apr 2026 21:46:57 -0700 (PDT)
Received: from elmini.. (c-98-42-127-152.hsd1.ca.comcast.net. [98.42.127.152])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2ca760b0518sm1554832eec.0.2026.04.01.21.46.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2026 21:46:57 -0700 (PDT)
From: Laurence Rowe <laurencerowe@gmail.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Cc: virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	Laurence Rowe <laurencerowe@gmail.com>
Subject: [PATCH] vsock: avoid timeout for non-blocking accept() with empty backlog
Date: Wed,  1 Apr 2026 21:46:37 -0700
Message-ID: <20260402044637.73531-1-laurencerowe@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A common pattern in epoll network servers is to eagerly accept all
pending connections from the non-blocking listening socket after
epoll_wait indicates the socket is ready by calling accept in a loop
until EAGAIN is returned indicating that the backlog is empty.

Scheduling a timeout for a non-blocking accept with an empty backlog
meant AF_VSOCK sockets used by epoll network servers incurred hundreds
of microseconds of additional latency per accept loop compared to
AF_INET or AF_UNIX sockets.

Signed-off-by: Laurence Rowe <laurencerowe@gmail.com>
---

This fixes the observed issue for me:

1. With loopback vsock on the host running Linux v6.19.10 built with
config-6.17.0-19-generic from Ubuntu 24.04 and make olddefconfig.

2. With Firecracker guests with current torvalds/master, v6.19.10, and
amazonlinux/microvm-kernel-6.1.166-24.303.amzn2023 used in Firecracker
CI and examples. (Firecracker guest vsocks are unix sockets on the host
side so this fix works there with just a fixed guest kernel.)

I struggled to build a generic 6.1.166 kernel that worked as a
Firecracker guest but the patch applies (conflict due to change of
`flags` to `arg->flags` in surrounding context) so I believe it should
work for generic v6.1.166 kernel.

Alternatively a minimal version of this fix is to just wrap the
`schedule_timeout` in an `if (timeout != 0)` but that leaves an
unnecessary additional `lock_sock` call.

There are ftrace's and reproduction tools at:
https://github.com/lrowe/linux-vsock-accept-timeout-investigation
---
 net/vmw_vsock/af_vsock.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/net/vmw_vsock/af_vsock.c b/net/vmw_vsock/af_vsock.c
index 2f7d94d682..483889b6d8 100644
--- a/net/vmw_vsock/af_vsock.c
+++ b/net/vmw_vsock/af_vsock.c
@@ -1850,11 +1850,11 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
 	 * created upon connection establishment.
 	 */
 	timeout = sock_rcvtimeo(listener, arg->flags & O_NONBLOCK);
-	prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
 
 	while ((connected = vsock_dequeue_accept(listener)) == NULL &&
-	       listener->sk_err == 0) {
+	       listener->sk_err == 0 && timeout != 0) {
 		release_sock(listener);
+		prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
 		timeout = schedule_timeout(timeout);
 		finish_wait(sk_sleep(listener), &wait);
 		lock_sock(listener);
@@ -1862,17 +1862,15 @@ static int vsock_accept(struct socket *sock, struct socket *newsock,
 		if (signal_pending(current)) {
 			err = sock_intr_errno(timeout);
 			goto out;
-		} else if (timeout == 0) {
-			err = -EAGAIN;
-			goto out;
 		}
-
-		prepare_to_wait(sk_sleep(listener), &wait, TASK_INTERRUPTIBLE);
 	}
-	finish_wait(sk_sleep(listener), &wait);
 
-	if (listener->sk_err)
+	if (listener->sk_err) {
 		err = -listener->sk_err;
+	} else if (timeout == 0 && connected == NULL) {
+		err = -EAGAIN;
+		goto out;
+	}
 
 	if (connected) {
 		sk_acceptq_removed(listener);
-- 
2.43.0

