Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.54
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794418201;
	b=lFWk14/aU+dJO2Uh+t0gVQfDghTwwhqSxyXiCPzoP4ii3Bvsi8z87u1m2936h68tPU/2
	 Hb1XtmenIcG4rvu/Y4b4NQx9XA1jPZiP8NK9PyFIi/lIhrQ1ZqBPb3WRNPZWaCg5TNEXM
	 ykKf0a4mh+K1pj3y20BKJJYW2QRkN/XD97zjXGrZoCkIWOxjC7xp6qPSBEkc0w+2dbevs
	 SGNyiSlWQGBWGtrwkegxWDv/PciL784qzYVPKFnzVeBOSFVxCpSyfxa1mzQtYNHPSxi5L
	 3w/g6jU/uzO9vNH4fGAPsPCAKbEbe1YK66DtFMexLDObQZcIS0FTRkMYTBKUrnADsXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794418201;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=IKVepiIWQTpytFczV61SNR3/LqMGsWtSoR5eXQ7P2qo=;
	b=xH7uimuBl+Nl9w2gMnZON/helw7bE+wKdl4BogIn0nbCapqQ1NEYT5cWzS4OeUbsFHzM
	 ZYklVQ1liJno9SfTMRgChEwnvJoL5QVk3ZKuvaC2WSNYySige2fgmm0sUjjXEBFwI22aF
	 Fm4tZxiLEE/JVw62H8tJFfPblooQ8bo1a1fp8I1s3K63PkOHvoWVCAEXv1hxAGD+bnFkF
	 11Q0oGNLR3nJMJfKN+48ciBSD85Qst9GEnIP+Zn4H2sHH2LyAEItaXunK+wEoAuDyQN2b
	 rtODxl/9upwLjJUIDBoYfM6QHvAJT1QEtDNSjKM1+4DBjM0xsaPJgN04HtjN/BtOvgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b7y9eXz6;
	arc=none smtp.remote-ip=209.85.128.54
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80134606A88F
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 17:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 80134606A88F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=b7y9eXz6
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-4ba013938d7so21275595e9.2
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 09:30:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794418200; x=1795023000; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=IKVepiIWQTpytFczV61SNR3/LqMGsWtSoR5eXQ7P2qo=;
        b=b7y9eXz6dGN+enLbXaCS7jGHI7K25/zmgKQ86kf+/YQYtawjNrf2WjVVGILVv+9Boh
         wFHSSUJ2gABE04gH3oBCiqc6dLurGCnw79QFlma4aVGQglcdWZsu8vmbOUvTsawGGoL6
         qVdVMhef9g3jWFUKj5QyzMFLThrrTprQlo5bUvtM7dPaNZZIB7G9ZBdBrScQZHp9JtDL
         XIGWFKkF+vDIEXzxuxS36KmyifFpuiySXj5FT8+CMVasubpkACSk05aBip6IglNn0rT0
         wkGOlvuzLS56UbCRrlGSfbeNSnNiDWzUz0hhKqoIA9ky2BRooKQYqeKnT5GgeCcrskeo
         HXhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794418200; x=1795023000;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IKVepiIWQTpytFczV61SNR3/LqMGsWtSoR5eXQ7P2qo=;
        b=QOAhvc/1o9IelRi0zeZtF+eVdY5NEE44sjRD5kVLQzsNYI8Cc0M7JxUVrJz/NLkbMS
         1MQwrF855aUGHHyzWEOspjJWIgC1/r6XbBcyWzx6Z6UCjsgbf6HSrWSwQWrOhLK2JRYm
         mV0ViRcS8vje/Ljbqz01fN2pbKEjLPBRg5mGi+j1dvPsFdjEfFIyxuOcQ88GIHKvADoV
         abu+G/sH0P07Gf/G3ElRpZnQ/lp98W+KzUtAKncfxEtBktjMSIkpczs5bmIPzTzUFrzq
         zY73AZ6S202VcdZq1voN6vbuhHgNKm7AJcnclhxFsoEVwWPYrqKt7Qklx95XbAc2oOX4
         75WQ==
X-Forwarded-Encrypted: i=1; AL+hErEsEertbeOT9j9uu3uxCWgD7V90upKvL2LWPwl5x6/qfxiP3q9GwXShOxr+v/2g+EJf1pOkecnloYNz0Fa/ZA==@lists.linux.dev
X-Gm-Message-State: APuU4Z+4kVqr9izalmZBeaS4RAUNyOImkYjo2qtSrU8F9MuWjrCRUsXi
	NY+FlUbpcwCxOH1dlY9FqA3p+v08FfEOak6/yJLoANM7hdN7wMK9z5iX
X-Gm-Gg: AYBFou0gVerCwAviwmK+xC72yNiUnU2mPdGONpDg65WnhElsirzVFeJnmCTj7c7Btj2
	4WXAgMYf8RLfxm8yQoU9w4pmw5JpBDQDCNEABh8oHdqE0F9BZfdE/WnXW58Q7h+OS1Igc6uYwE4
	DJ4C4v+Pa+2HjLW7u5IXQELX3ct51xuWyJV8Cmhz5K+ONrjGTUSWKk2ypNyN8hXVRmJHXOCY3qh
	xCLdx36TJopNRX7NgsgmlvVM3XAMC8tno0Q4fEeZOr1Iz+TB8AUHEeIf+Qh59f9qkPeHbQepkk7
	gBelT3qHpq0Q+9es12XnB0ZdhyINsmsbVs8hFNSlGOeSmtnzbneIGUXxuzaxWXFpVGJVO9agvhS
	BVvVDt/Jxygh6nZXs5i+w/B4X3Zx9If6zi5MT1j2xBiZWweonhVBJwbMb1mwQfCHrZeHISoh94c
	Ti038ntoqrmlJaGdyk78FPO4hFbl7VBlmDWGkI97CQzF92oAYgzB2Sg1uX/aYwWrs3XLaVKemc5
	zNTkIvoq6D7/fHPJboLob7tnQtTTsucuwFCygXaLO/XuhjGDoyE3AI337HYCVAOznjZKIjnTKH0
	pw9N0sKIHsFHlLCZZqiPPhJPImi+f7TZBZq6oh9jPVpLt8DwRKwAZHdfm4C1jQ==
X-Received: by 2002:a05:600c:1e04:b0:4a7:9025:5c3b with SMTP id 5b1f17b1804b1-4ba093b9702mr55946345e9.19.1794418199918;
        Wed, 11 Nov 2026 09:29:59 -0800 (PST)
Received: from stjepan-Aspire-F5-573G.tailc0f20e.ts.net ([2a00:1bb8:118:d39e:d655:6a9b:5ab8:7f68])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb4e26700fsm3134525e9.10.2026.11.11.09.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 09:29:59 -0800 (PST)
From: Stjepan Poljak <stjepan.poljak@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowangio@gmail.com>
Cc: =?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Andy Lutomirski <luto@kernel.org>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	virtualization@lists.linux.dev,
	linux-remoteproc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] tools/virtio: vringh_test: check that a split ring must be a power of two
Date: Wed, 11 Nov 2026 18:29:38 +0100
Message-ID: <20261111172947.3579982-3-stjepan.poljak@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111172947.3579982-1-stjepan.poljak@gmail.com>
References: <20261111172947.3579982-1-stjepan.poljak@gmail.com>
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

With it, vring_new_virtqueue() prints "Bad virtqueue length 255" and the
rest of the test runs as before.

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

