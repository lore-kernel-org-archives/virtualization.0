Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0BD30BF68
	for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 15:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782315609; cv=none; b=XURW8nYzhYe6lzUbZyoqS9rz2L7L+pReB5MqGq8TyzUniT/OIL+Df26eyqirzOQeozKiEFzQgI7FSmrqB69ldoEU+2JIS2YbpTiJ7l+/+/qmnq22Gzp74oobMHkjknd9FSc1vMFbMSkFLMv96FzzhEezjzu8u4CM+VcKA54h/kI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782315609; c=relaxed/simple;
	bh=+ftY4ThfwoEF3KS8z4f4RgMIAbP5Tx1p3bFUFB6zzLI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p4p1GUPc+bY9BGRXcZztGSLmHuOubzh3XSjvIPZ37kAOoGDt0QpluufQzpfov/J8SebStjz1n8Bgmzz/Uw8GLXd2Cx5APKWh5XOU04wBpwo9emoC9Y+Sgti7J9nPh0pHDWXv8TlhYpAdAP7953KUigCqW+F94pHF4fMCAkNiVGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org; spf=pass smtp.mailfrom=openvz.org; dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.b=p2Ixx8la; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=openvz.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=openvz.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=openvz.org header.i=@openvz.org header.b="p2Ixx8la"
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-49241dbf9c1so9875555e9.2
        for <virtualization@lists.linux.dev>; Wed, 24 Jun 2026 08:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=openvz.org; s=google; t=1782315605; x=1782920405; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bkYQNO5vR+uN9JdITatzFgUTsrAKtjKJYqqqqrE2vc8=;
        b=p2Ixx8la3+Aprzh62gN9/+xUuV7lrbXopRdXpEei8ZsNw4D/TfiWxwtGI4hzTRyCMx
         9cZLDA+iHTF3QX2vpv+zmU+FXNkg/phu4pjWiMBoTo41SBESmYFfdkHbyhzB90ZAf9Ck
         Us/xciTI9+pqfOyiHhg1z/uzne4DYRCbKZcwsF+e/ZFmUxuiWE/58KbJnM0gvgf2Ne6+
         yzfKfQ0QlJuWELPNLiZz40RqVB/tg/1s2eftKGRubUsQZ2ieSefWDZs+Wd+dvrs7EhMs
         ihRyQ92x6xC2Z0xcsTbKald18vS+ZnkvmFjNd69yKJu+Sktjrw5qMW2K+GbEX8vYHE1I
         2FeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782315605; x=1782920405;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=bkYQNO5vR+uN9JdITatzFgUTsrAKtjKJYqqqqrE2vc8=;
        b=jglaNrThWvDTV2sUy3kKPNwtwBJ+e/CzOXbbjIWfswOiYqtgp/WinqXJi9QL4G/INV
         kSAkebSbyxM7DacTjRTKCLNIH2wGP1uz4/JTg6UBY0cIxHgQzrdr9RONg0HepKZ3vMTk
         YJFVdl0iBYAqJTbh0jVphHVdHyofh0EyrGZfgLA//m9fKMlj1Km6PyCnFLLtr4cn5UFh
         P7vQL+AF4mtG3fmgrxGdXLlSRZe+2OjVfeadgbMKBrGm2fqnXF9I60CZ32EDPXcGYobU
         5hdq0NpDkOm9mpqFkL3vElVkz8bz/UTid8LIa4ooTiMDCWJcCV+uZUnbIsnJz11Gy3Km
         OpGA==
X-Gm-Message-State: AOJu0YwK0P2S/OpHJyirGzMHFrsqhMyk+3JP5f3TEsaj+LMw4W0VV5lw
	FAC+3t//Nd0a5AKLAv0mwrOuIhWu3QwYouAn1N0shR52MtNiI75qlLO0x+Le5VoV5/c=
X-Gm-Gg: AfdE7cmeAw1JOBuMjVYs/gWgVZXtou27UaajgO9Jj9oVtVnorTXQHDtVq64tnGox309
	wbdnvHG1xsjgN03YWsBmcDjaHMdtP72GJlzO67w6QtnSbItIyGzUmXsPaTGF76vMNpDYaqHkl2N
	Q0l6R0HKdHuI1IImrPSVOhGsiuDq6CLSj9BREGEB8bClq5PCx0mKFxcFwYLJKVZ9Q8bNVS0m+vD
	FXLrXmNFXNQ7rnCkyIAZlpn1Vb688T/1mJprsLLKmvwtWtZ2xXkpd/63vClbWFGSsNtXHafjRmX
	BnBOAM2Beo+1GiZ3HNza3UxNYiB09nWIRJUnVxIzC7zlIXPX5nJzeSeDIvNK/TIOdj9Kj4id4Ws
	kCz+xHO1+JvPt3k5tPA/BP4Z1UAWruf83INM0fQrZ3hktt9c9wT6KLP7UDN262j4KQYfQ3w==
X-Received: by 2002:a05:600c:540f:b0:490:e196:6574 with SMTP id 5b1f17b1804b1-492608530d1mr57482155e9.13.1782315604315;
        Wed, 24 Jun 2026 08:40:04 -0700 (PDT)
Received: from athena.sw.ru ([2a06:5b06:b600:300:306c:c2d:85d5:28d5])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49260915286sm160025075e9.1.2026.06.24.08.40.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2026 08:40:03 -0700 (PDT)
From: "Denis V. Lunev" <den@openvz.org>
To: mst@redhat.com,
	david@kernel.org
Cc: virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	"Denis V. Lunev" <den@openvz.org>
Subject: [PATCH v2 5/4] virtio_balloon: warn on failed buffer add in stats_handle_request()
Date: Wed, 24 Jun 2026 17:40:01 +0200
Message-ID: <20260624154001.2733242-1-den@openvz.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <549e5456-2b6c-48a5-abe5-ef5425c3f63c@kernel.org>
References: <549e5456-2b6c-48a5-abe5-ef5425c3f63c@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Like tell_host(), stats_handle_request() ignores the return value of
virtqueue_add_outbuf() and kicks the queue regardless. The same "we
should always be able to add one buffer to an empty queue" assumption
does not hold once the virtqueue has been broken (e.g. on device
shutdown), where the add fails with -EIO. Unlike tell_host() it does
not wait_event() afterwards so it cannot hang, but it still kicks a
queue with nothing queued.

Warn and bail out on failure, mirroring tell_host() and
virtballoon_free_page_report().

Suggested-by: David Hildenbrand <david@kernel.org>
Signed-off-by: Denis V. Lunev <den@openvz.org>
---
 drivers/virtio/virtio_balloon.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
index 0866a8781f0b..454bbb77331d 100644
--- a/drivers/virtio/virtio_balloon.c
+++ b/drivers/virtio/virtio_balloon.c
@@ -445,6 +445,7 @@ static void stats_handle_request(struct virtio_balloon *vb)
 	struct virtqueue *vq;
 	struct scatterlist sg;
 	unsigned int len, num_stats;
+	int err;
 
 	num_stats = update_balloon_stats(vb);
 
@@ -452,7 +453,9 @@ static void stats_handle_request(struct virtio_balloon *vb)
 	if (!virtqueue_get_buf(vq, &len))
 		return;
 	sg_init_one(&sg, vb->stats, sizeof(vb->stats[0]) * num_stats);
-	virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
+	err = virtqueue_add_outbuf(vq, &sg, 1, vb, GFP_KERNEL);
+	if (WARN_ON_ONCE(err))
+		return;
 	virtqueue_kick(vq);
 }
 
-- 
2.53.0

