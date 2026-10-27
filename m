Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793098250;
	b=fl6VVprEjzgtsTUA2VZ4lVnifIemY40AvEd97nyc0z7R9sEXNfhzAYIBfcJCqeMRRRRf
	 tE9Oh8oS3A5cPr04WyBBpswEbdvoDFyQ61inImhKxELMR6AaNEJvI3GnPzJ2KA9jhxjnT
	 MeAkdajhCTzqkg/EFeLMNMt1Taz9PDNvZRUJCOMWsp8juij3tDzxU89LuxhGraDejMGPB
	 o6Y9oSXfgocqL3+gc+SlJbIK/UnXc5GqoGtuhBiiBdu5B4OU4PI7UmSKKpWVy0KrNRFR/
	 oyyJBKTQDnsWyEMR6/wPJux2TlCjEShQeAstRJ2ugGXWQYvvFAhDU5kMW2MNtTO3nUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793098250;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=08drD1ymTUi9hsmUJNZ4ArGmW7O1mMyycL0HsIwG3PI=;
	b=KyP0/FvfmIUrnwAgN+KrYvX969j/PlcA2qDnBZHJyM+fRitwUk/k4M5Ki2yud+7JUrh4
	 MIv/gJy7FlpMZP8tzr5kf0rNt1BViu19JdrVPlBB8eb5JKL57tDpgIgotczWxe8x+WlXI
	 AOSbv9i18EvSUiFnrND+pIYo9IalFkDY1sVvBTPkNldZWBO1KGqh6e2RxKy+Uzx2UPq2g
	 //S+hLTjk93FPz3h6fsWPHbSkZW708RtAiduCDYe2UEmHEZwCD2k5AkEeRkjYjLfHmD4v
	 1SBJkgxeLgfLPGjSGU44tZjcz8/BZskoB1Phav3lo5viYuK87cfBErWAte75u+lHYPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=nLoWmpOU;
	arc=none smtp.remote-ip=209.85.128.49
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A3660A263C
	for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 10:50:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B6A3660A263C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=nLoWmpOU
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-4a35db1f202so22297045e9.3
        for <virtualization@lists.linux.dev>; Tue, 27 Oct 2026 03:50:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793098248; x=1793703048; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=08drD1ymTUi9hsmUJNZ4ArGmW7O1mMyycL0HsIwG3PI=;
        b=nLoWmpOUi2rrf0fBfrmXPFGHCWxXi/h38A52pebcigPkz4gCgvQ7DDvKSZgpzxrY9a
         VR2MNvLEjUEIFqDrvv/0CgDR5tppXTiPixqOihIi6JVaj4XseilKLVbJa96VuNPkzl01
         n2J+uptPuIN5tK1ihuNTTbNu0E1xcNkmmP4GVJk1OJ8uB9gpT6G6xr2XUOIaZ7ufW1xY
         XxG8jitfdDAB+q6+1oPSjkESpR/SPQNYE4kO9ugf+eGAcEbkiBBvFO2dSKwDZaQlbiPn
         QG/9XmSzaawk6UbYtBc76vtCR8VgoaatrSXxjoQsPvEEqnkOgMG5zjzUtoXslIuVr1/X
         IqaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793098248; x=1793703048;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=08drD1ymTUi9hsmUJNZ4ArGmW7O1mMyycL0HsIwG3PI=;
        b=VvR9VFHji7/rLBO93bSmCYHmrmPN8ySJSsvOhzexcK6ZFjz1jnUhQGBc55ygZ6Oai3
         Jqc5kvFFy/9cXnrfhIGln3qK2efYO39IRz99x1nU+0SEH5QHMuTSAsgSVVOoQENnmNxF
         qKfcr9X4pLQqSjPem+ZGqCQgHWLx1kHts8/cqUpu+uzo72WGRIgCX927Rn+h9jp3OUPO
         0fOGiLbtUtSmUm7Js3cHf/dPBw/Tk/+SucYk2t8p2JsSnEfvbhGMhAP0wlxzcuBjsPKD
         0eIR17s4KpKsD6TLp6UE9NRziyeSAOtDqaoE/QHyOxLIwWqx/PoEAigtX9TH5xbggWVI
         ny/w==
X-Forwarded-Encrypted: i=1; AKwUvByzNTjDrlV0bSPGl/7DZNZDgnOXszwo99rMwbZigErZuxxU3AMeozW8Kro/neEvGm1U3aeGB581TuT73Iwl8g==@lists.linux.dev
X-Gm-Message-State: AFq9FYIyVCPlYG111QRUCnbtuMD32bU4ZtsFAaYx+HsVWFXap0qZonIV
	l330oPo/TsdrDzM11XUuZ43b3wjarf8LhTCWpbsDFqGb8pcRpentDvlWyv6cs2Mo51z27hP7Lku
	G6E3oTl4=
X-Gm-Gg: AYBFou2xKZ98cNt0aqKvXI/S1Bw64mdwx7yaKXP2h3GoqKxo0qibTfmlV5ua1kWGL0U
	rMdpITvFJ5ELEgnuuV6PeM6Y/AusimXW+WkNhiV8FDLWfxW2agyBativtBN06L8kUginF0+f6qx
	ooscQQVcrDc4mdcRHwYQzl6FqAVoZOqTBsOReSoBBbW7x3xHVhObumGC0l7+hvW4ZGPP2LL6DKy
	B/TBPUXfAfB7wV9SxNoC0ldz6rOR78ER7sJH4cG2T43cfOGDLOixtT0mIxZlccA/WICnHEc3bSk
	/oUkoLX28cLRsSq2w4G3IkkmFzSerO4ohVRXPnBs8oXQQjgwslK10hOQzow2KJ81ooQCFlgMyca
	dt6NhvZwEbfklx6aSIjA7l+WS8UFDZBCSNRsAORnC8AHPArQ/MsP/+T6ZftGPul/Y1GHfhsQzDW
	gMQuo2UVzCK4xrMX0Lm0ih5pJqo+5HechpMyoOzum4px64lL8YfQoXLSlEdiiRGCLbTnI2+brvL
	PGhI0gGrdvB3EhlK0JJ7ukqhquNsJLJVXQkhy6dSqSRU9Cnhy1zl8d0XcZDAP/l62Mo5+1T6qOK
	8hzObjRdbwfGVbY0nh3xecXWUTLB5osHWRKnsQn9xk+GBy0womjox4szcwwm/fkszG104A0dBm2
	oNzaDHTEtcAAiGVxN
X-Received: by 2002:a05:600c:8b86:b0:4a3:59c9:a754 with SMTP id 5b1f17b1804b1-4a35acb17bfmr177092795e9.22.1793098248233;
        Tue, 27 Oct 2026 03:50:48 -0700 (PDT)
Received: from localhost (p200300f65f19a904240e81f1f32a429c.dip0.t-ipconnect.de. [2003:f6:5f19:a904:240e:81f1:f32a:429c])
        by smtp.gmail.com with UTF8SMTPSA id 5b1f17b1804b1-4a359fbb725sm257775775e9.0.2026.10.27.03.50.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Oct 2026 03:50:47 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: Andy Shevchenko <andy@kernel.org>,
	"Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	linux-gpio@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v4 17/23] gpio: virtio: Use a named initializer for virtio_device_id array
Date: Tue, 27 Oct 2026 11:48:54 +0100
Message-ID:  <0ff54324a8cdb1f036bd01f05dfaff75512d8abe.1793097104.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.56.0.rc1
In-Reply-To: <cover.1793097104.git.u.kleine-koenig@baylibre.com>
References: <cover.1793097104.git.u.kleine-koenig@baylibre.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Developer-Signature: v=1; a=openpgp-sha256; l=1078; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=HvLKZnIb7RtprxLD/D+7QxSMDdlX02hi9zaVYI1agxw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq4IHL55n0O6CbSHLAYjy/VwqEdsY+cZcVZlvXU /YSi3wb+H6JATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCauCBywAKCRCPgPtYfRL+ TtSNB/47f7idwujRUL62MyxZqdila+JxQe2sFy21p90zLDAWqeOh9phY6aVPSFuI3cCtJl9FIHm yXmV+NgiGxVGPbGmjtaVlNt7TvwxrKKD4DykEceu4+LgcW1qWY6KJwSVK/4pve14di0ygt8dTzv k8kToE94nDb1GWFWy8HbKhbgWVNYP21R6r7C/q+ZTrWiJtzXIW7qBg2eMpqsuQE5Ak5FAf1zgGg Dv1jyW+oJVVwfR6XK0/Ch4mhQlvqOQoEEccJ5mShNSO3wnh07Z0eu+IvJtIytag85I2oKnNtp/X pln5RT1N5amHzixg5WZB7cLEQJCDiRy392STmwpWppui45f7
X-Developer-Key: i=u.kleine-koenig@baylibre.com; a=openpgp; fpr=0D2511F322BFAB1C1580266BE2DCDD9132669BD6
Content-Transfer-Encoding: 8bit

While being less compact, using named initializers allows to more easily
see which members of the structs are assigned which value without having
to lookup the declaration of the struct. And it's also more robust
against changes to the struct definition.

This patch doesn't modify the compiled array, only its representation in
source form benefits.

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
Signed-off-by: Uwe Kleine-König (The Capable Hub) <u.kleine-koenig@baylibre.com>
---
 drivers/gpio/gpio-virtio.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
index ed6e0e90fa8a..42871db05ec1 100644
--- a/drivers/gpio/gpio-virtio.c
+++ b/drivers/gpio/gpio-virtio.c
@@ -646,7 +646,7 @@ static void virtio_gpio_remove(struct virtio_device *vdev)
 }
 
 static const struct virtio_device_id id_table[] = {
-	{ VIRTIO_ID_GPIO, VIRTIO_DEV_ANY_ID },
+	{ .device = VIRTIO_ID_GPIO, .vendor = VIRTIO_DEV_ANY_ID },
 	{},
 };
 MODULE_DEVICE_TABLE(virtio, id_table);
-- 
2.56.0.rc1

