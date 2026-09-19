Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com [74.125.228.40])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD4482D2394
	for <virtualization@lists.linux.dev>; Sat, 19 Sep 2026 13:18:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.40
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789823891; cv=none; b=jaLK/7hJzETEmkQSiVbUt9vFVA396JDXdlSMqvsvRe8mIV+RN37Ha4Tpz3WkvSAUgSDE5uHYZrP+aiztGL+CQQeJcize+915EsYNvWtcJwu4nB0GFrCk7GkWmqiy+kp71FszdXnuExDWgwSXnMM8xBpFM6RpzMGYOOZ4Hdn2xXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789823891; c=relaxed/simple;
	bh=CsmY2C0LUhQFV2xkI5Vula3YY7rYEiZTWt4OODXOZMg=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=DL1phnyex6yRmYe2sayXr1sBncSJkuAGHSDAFfnZqIv2j6VBTUGuHxvmauLjn82weYSnIYqq2VAhmeGF2LFsStWJZwpQMj++O9+zzAIifyRHS7FigzBhMb7xC4hKR424DuKR2f+S59CjuNJ284QiJQqLj6ZznjFSktnpxnC0X7A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IF2s2pd2; arc=none smtp.client-ip=74.125.228.40
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IF2s2pd2"
Received: by mail-pz2-f40.google.com with SMTP id 41be03b00d2f7-cc515bef69dso1074962a12.2
        for <virtualization@lists.linux.dev>; Sat, 19 Sep 2026 06:18:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789823889; x=1790428689; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=JsTGylBrKeTBmgAOYV6+2j7T7Vnx2su+clGWmC3zkts=;
        b=IF2s2pd2avez1tO5mmjD9bEj1SeqWAInHn4Vwvbkepsa5ITvOrnq5vKQeDG2zIh1Ev
         nLqjsMVfKFcTnMpKlY7c2VG4PiKpPLof7mvB85JkRgN5sGcrTI7Rrfo8DUGiyvN7ZGHg
         tkZAJEmu9XFIWkHyhmJAQUOtyNSIg7nF0HN5qeaZg5+ng9ZfRVBdTnkA5x4JHplaOFLJ
         VkWGnuzTD0EgOZTHvat0jEOoueaVoTx28vtUtXRm+LMYYudnbhLUYWnNgkS9rTLBqIa4
         XR+r9fjOfivoCqhyYhTFb+6RIyd8C40XAAeT6JXZA+aTBJ70akMXKHpT1u5RgTBvrK6w
         cj1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789823889; x=1790428689;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=JsTGylBrKeTBmgAOYV6+2j7T7Vnx2su+clGWmC3zkts=;
        b=EejjnmOvE1mWsi+Uoifk4MhrsjXZpRFWdB7SkN9YhgLLof758I1kdMB3moQEgwtoCy
         CaMjsUd9My5NQbOsioW1ncNJKbbqoIsWlUN+rWl4RYBlbTdHeQYTcu4gcb5wS884f9kR
         Wl4FYPXz/S3yEqwKkHLn5oTz6sCm6D0TZbSvyoGbr6eF7ZV72JVAeIYJVvb7IrmxAMsv
         7D4sLqfRhiJDEaLm9VvVIXQ/D6SlzCaDuOyidtzfcziwnD6yXQ9WhR/f2BNAXcszwL7K
         N9eam9CWiU7PVkV3zdQcteZAAlRxoOQLcmOdqqZk4Sn5VzauZBCClcMuTHmZ+ogUbGVA
         MYvA==
X-Forwarded-Encrypted: i=1; AKwUvBzOtPC6VI5dehVYj7AnB2JjYNrVNfzEBOcjAMnCR2i1cMi/NqGZ2sHr1CNeNE+Bn3KDBlWy2wpJEhBN3xZQCA==@lists.linux.dev
X-Gm-Message-State: AFuF++kyGdHzFZHk/gcTncUStrdXRfjZ7FtozU6dkSNKqt/vXMtxzOdw
	AUhYwd6RMWs1rFsPXIw9fBFoi83XE0PBlIJBBk9wXfb/qUT2eaN8pw61
X-Gm-Gg: AYBFou0IqqorkQ2t6M/7UMOV7TyE+dJM5uuRaZvVqe9LgkEuKaTexM7SR7pXWb4b0xf
	V1hKUBfrRBPwGlReOpHUdbASDXEHDZhEY8/VltweypMG6kafrCjZHQfk47E+DNntAW0JYvkAOcW
	AFbNMzov9Awdo5NoKc/YaTrdBJD+Qa+84ds41CBycPcugrnClwYjHrukI87ZgffDCQ4m3a3qQIv
	7Q4ChZ+0Qj5KNfd/ylvmcjebVRsnIRL96Lciwut22DMPAQFmwxSAmhZQX4a10QuJnJWYyl7xm4s
	rOV5FmDXld7A6uOKEym7iffEtd9atY/DmI8Rtw6Le4MoMoBNFhO8pkOY6RjwjD1CAEbJ3aMwmgP
	JmAPFTtOnr34AuoR0DBLU+s91QbotwTdAigtg/ufm4RcI9/+7IApl6CrE/4ieyTpXEc/XPnkh/M
	6SD+jpzPhV46CrbTfq1RMy2diMt9yQwqVRy1/1slMccSfWM69otAhYq0lHPNE98vMMlEuVPw==
X-Received: by 2002:a17:90b:5706:b0:39e:6c6a:209e with SMTP id 98e67ed59e1d1-39e6c6a234emr3242069a91.63.1789823888812;
        Sat, 19 Sep 2026 06:18:08 -0700 (PDT)
Received: from gmail.com ([188.253.12.32])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a023cf10bbsm1276314a91.3.2026.09.19.06.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 06:18:08 -0700 (PDT)
From: Jia Jia <physicalmtea@gmail.com>
To: "Michael S . Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowangio@gmail.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Nicholas Bellinger <nab@linux-iscsi.org>,
	kvm@vger.kernel.org,
	virtualization@lists.linux.dev,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] vhost: keep vring addresses stable while the backend is attached
Date: Sat, 19 Sep 2026 21:17:44 +0800
Message-Id: <20260919131744.131030-1-physicalmtea@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

vhost-scsi keeps the response and bounce-buffer iovecs until the backend
completes the command.  If userspace changes the vring addresses while the
command is in flight, the completion data is copied through the old iovecs
while vhost_add_used() updates the new used ring.  The guest then no longer
sees the completion.

Reject changes to the vring addresses while a backend is attached to the
queue.  Keep accepting the current addresses so userspace can update
VHOST_VRING_F_LOG or log_guest_addr without stopping the backend.  Queues
that have not been attached retain the existing setup behavior; userspace
must detach the backend before changing their addresses.

Fixes: 057cbf49a1f0 ("tcm_vhost: Initial merge for vhost level target fabric driver")
Signed-off-by: Jia Jia <physicalmtea@gmail.com>
---
 drivers/vhost/vhost.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/vhost/vhost.c b/drivers/vhost/vhost.c
index 44cac11b68d2..074590838de5 100644
--- a/drivers/vhost/vhost.c
+++ b/drivers/vhost/vhost.c
@@ -2150,6 +2150,17 @@ static long vhost_vring_set_addr(struct vhost_dev *d,
 				a.flags & (0x1 << VHOST_VRING_F_LOG),
 				a.log_guest_addr))
 			return -EINVAL;
+
+		/*
+		 * Commands may retain iovecs derived from the current ring
+		 * addresses.  Keep the addresses unchanged while the backend
+		 * is attached.
+		 */
+		if ((vq->desc || vq->avail || vq->used) &&
+		    (vq->desc != (void __user *)(unsigned long)a.desc_user_addr ||
+		     vq->avail != (void __user *)(unsigned long)a.avail_user_addr ||
+		     vq->used != (void __user *)(unsigned long)a.used_user_addr))
+			return -EBUSY;
 	}
 
 	vq->log_used = !!(a.flags & (0x1 << VHOST_VRING_F_LOG));
