Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794498582;
	b=FGt3JPSu4DdDiC0CPG7q0+j72ULTb5crl3BltVwEKz5HBxEISHxzO+oYETG4Je4pzk6t
	 ZWGb7mEogd7mYUPsF+QQEMFA4vPtsMKcgh3Q656K+W/8dsHzdlykP0cYTvgjKqOLtuNlo
	 U9ZTWeh5ankkq9NdXoaXBpvZRYQlodS8mtOsFgM3/nwgHEHyqDv1hDu0b0AmYg3U8Z1EU
	 Y3hA/2TlXV3JOiH7GEYcFBX1fyYFzdtOXhBFNjG//MVS+Z+JvaOAsyJmcLl8AZwUkv+qI
	 LilxDg0U8CQh00xyLResDm923yU2ScY0ZOGUvex7pHbmO6qly1Wg9IBsw+dvUPCA/qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794498582;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=CxFoK2bKFif4r5nTuXcKQcoyXDPnIP5aTxYirQtgrTk=;
	b=fL7ELULt17TQq5G8QXzhmihS6tw7PNXo/qoru22ZWvuzZYZbPDj61UFzV34K0X4IKtvj
	 OPTnxCvd2pEGvFfezV+tk0WYmFr7P1MCzuJ33iL0atONg/Gfv7OryPkEgII/2cg/Mz+Z4
	 UMMPThB3JmHcU7kDjtumC50+sHjnwugc6piK2FOOTuql7BQHXfy7VQFUUk3AA3V3vfH/d
	 nmg6pJRm5lmGhARuES0pa1bmLuPlW3V56M4X4qgyo5leN8gjGK/t05j5a4wEAUEB80TZK
	 kG7NSEiyaARwpclZGMdC0iQWomt5JAmCqiIgR/BPGcgBNpGq+zQZgUWoriJvPRDc6XQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0ZidE0nL;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CB78606A8AC
	for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 15:49:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CB78606A8AC
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0ZidE0nL
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so35925705e9.3
        for <virtualization@lists.linux.dev>; Thu, 12 Nov 2026 07:49:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794498581; x=1795103381; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CxFoK2bKFif4r5nTuXcKQcoyXDPnIP5aTxYirQtgrTk=;
        b=0ZidE0nLtx0bqugyDSgP7Yqdek2QCh95c6jTXO4OVZLvdQUio9Ng3c9xC4s7P7HoCE
         mg5+cZ53kwjrje6fM7omn1HhjW/FXJugQz7G/LK7yWSPbg7jBe74ffSMTGKAxwqSbdwo
         NEyIDEZyJKcerAhs/y8roJ9wPKRVkn38SohwLQZjg2wTqIJf1Vj2UdLJ+fbS8XFLw31D
         lRKcGt06mP9fI43zFRP3IcY+br2lltHXPrN25CDFkNOICTHNpQ2ikRvPLFCvTu/qPsq8
         4dJoH5VoLH9cx0lu+LFeftj2/veEhhPcxbS6RurrJtMmI80cNxt+M3wn41FFJfDzCjFg
         I50Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794498581; x=1795103381;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=CxFoK2bKFif4r5nTuXcKQcoyXDPnIP5aTxYirQtgrTk=;
        b=pbVZhuXvF/T9N/3VontRDt55iGHUdT7Yzs1NFPC4dLsQDE02UFIZPzOgO82sQeDTxe
         vJyMUlMA2r6fTWaRX04qHq45agUa8zAy61oMpm+i/UnImL89BUZOcuyEH6cAoRCMGaPK
         KZimDZnlGAtv/1mMPcya9ZGepkVQ+cIC2hrXN8KtEBWZ1xdRmCzZBpmYPFZOQMP4rbEq
         KBURUngKPTgAzoYvYJ/Bja/KWdAyKoxlq/HgT/lFuNhcl1w+oSE5v3DwJWHDOnUaun1X
         w456DIoO45g3Eib/x51GqhO2sBKhT+9ALnp4Udn5t9CuHaSzl5WSvDJRcX7uZZH1cfa/
         YI6g==
X-Forwarded-Encrypted: i=1; AL+hErGTo8GkOgTh0mBzOpdENRv5GLBVU3SftXTOzYUCN3D4E2zaCBkCY3N9/AZJziEojFxpTYLnAFDGYgiMW+NOuw==@lists.linux.dev
X-Gm-Message-State: APuU4Z/nZpA4ZXr/cO7ZQOMNhiXVX/bySibki9S3ya04dKhUbrKW0Eg0
	ftyLTtJ2YBKMFDcf0UF54u0sbYK5OdPycHPvtTjs2dROoSfYvUpaQ6cB
X-Gm-Gg: AYBFou0wcaelhmMuYuRGiC6Pqm36EcmkpGQV9Yb8aa8CDnzN4xDsSmfhUYSo9f5AdZK
	SrH680F5muvw2oZ2MBgvCUucW/GEzaufIS5Mty1Y6OI/LOKu2lxCxYXK2er+ON83Z2asGxe8OCH
	0hrew8akVa4N38yzNIu5aujunIuLTfUz0r98D1yDeFeu2KBD+/r53rG/l/5Vlrx4cKZNsoXdOqA
	dXZcvCI6MQc2v6YnscIAIm3vh5zGM72Q8f/xUatG30J6Ain8CvVa+TmHaEB2a6Ao0mimz4O44A2
	8qPTQUB+R65gtSMNAglnxw+sttsP/0vFe93fhbvDtboWb58pnlMQOrI5j1fo8Zb9iQBv8FXCpdB
	ysUT0nCVolfRaFR2FKEjB+NAJfZanyX2AeUtvL/LdwgqpGbJq+JbpF3SswLI+U36wiRguobFvGM
	Q+RrTYQa/iIrNEw8SvIM/ZbZYQCTz/iM+Vup9sXgJ/r7ETScyUJoUU4k1T1RqZZnUuZVOHqZ0Ot
	p5jb35U5PFmEIPISpVm2AI3RY6LzTpXYUYjuIeSrJq6m248/rd0WuT3KZoDK9xCYFU4p7E5q3Yb
	nb/bQc9G0W97qJ+cqJkD1nVSVHOTrQf08xqP6DAQrlundtpImPvmpmZ8wVZb3gzRm/JmViGX968
	=
X-Received: by 2002:a05:600c:34c7:b0:4a1:992f:d0e7 with SMTP id 5b1f17b1804b1-4ba09391696mr107327305e9.16.1794498580905;
        Thu, 12 Nov 2026 07:49:40 -0800 (PST)
Received: from stjepan-Aspire-F5-573G.tailc0f20e.ts.net ([2a00:1bb8:118:d39e:4868:f22e:b51d:7cb])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e2538b9sm139337155e9.1.2026.11.12.07.49.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 07:49:40 -0800 (PST)
From: Stjepan Poljak <stjepan.poljak@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: Francesco Valla <francesco@valla.it>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andy Lutomirski <luto@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] tools/virtio: vringh_test: check that a split ring must be a power of two
Date: Thu, 12 Nov 2026 16:49:17 +0100
Message-ID: <20261112154927.4004184-3-stjepan.poljak@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261112154927.4004184-1-stjepan.poljak@gmail.com>
References: <20261112154927.4004184-1-stjepan.poljak@gmail.com>
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

vring_new_virtqueue() used to accept a split ring of any size, although
the ring is indexed with num - 1 as a mask. Check that it now refuses
one size short of RINGSIZE.

Without the preceding fix, vringh_test fails with:

  vringh_test: vring_new_virtqueue accepted size 255

With it, vring_new_virtqueue() prints:

  Bad virtqueue length 255 (not a power of two)

and the rest of the test runs as before.

Signed-off-by: Stjepan Poljak <stjepan.poljak@gmail.com>
---
 tools/virtio/vringh_test.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
index 2a5d7f7d2d6c..75c66385502d 100644
--- a/tools/virtio/vringh_test.c
+++ b/tools/virtio/vringh_test.c
@@ -494,6 +494,17 @@ int main(int argc, char *argv[])
 	__user_addr_max = __user_addr_min + USER_MEM;
 	memset(__user_addr_min, 0, vring_size(RINGSIZE, ALIGN));
 
+	/*
+	 * The split ring indexes its rings with num - 1 as a mask, so a
+	 * size that is not a power of two must be refused.
+	 */
+	vq = vring_new_virtqueue(0, RINGSIZE - 1, ALIGN, &vdev, true, false,
+				 __user_addr_min,
+				 never_notify_host, never_callback_guest,
+				 "guest vq");
+	if (vq)
+		errx(1, "vring_new_virtqueue accepted size %u", RINGSIZE - 1);
+
 	/* Set up guest side. */
 	vq = vring_new_virtqueue(0, RINGSIZE, ALIGN, &vdev, true, false,
 				 __user_addr_min,
-- 
2.53.0

