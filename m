Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.51
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793032197;
	b=ur+6KTZWTpbZnw9qetIlMo2f1CCU1xULouEf7ryi2FuwIfAHsi8gVpQPkKwfgSMqsNBN
	 m/Kk5h63VYvXzbBqOxrSBw21dgVEqpahWi6y8UC5joCXPndYlY8a7fxvTgir9kt3UM9C1
	 2xKSVPbAJkpwjUUjRQaE83etbKeUGIxUZV/4dcx1vyc2FhkjsTDE+0KKWCjHZac2J5Wnl
	 mTf3JcP9nFB3YYPYItrjJm9QNnAKCZqq8fJufyv9sKJwXkThA1MmQN6aQMzEYf9eD8ZxZ
	 sr/2PhKIejxjim8oh2rUeCq28uBM9LrQyAsY16jF7tcn9OfexjI3Ukin/KJFYOP38pA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793032197;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Type:X-Developer-Signature:X-Developer-Key:
	 Content-Transfer-Encoding;
	bh=08drD1ymTUi9hsmUJNZ4ArGmW7O1mMyycL0HsIwG3PI=;
	b=gqUIbhpaAuIa75z/dsL+tK5/ngwdew2Fs1yBsjsPSLF5ySCNaDNwieYCI9DT/0Ij1N1/
	 KbDP3otV5a1vbZnpwHWnwxX/XfrsqK4CQ2bmv5BHYytG9ImDmq5KqmVMGBpVYvjhP1wpg
	 bsv1sx/JZFjmSCaQXtiMc521INZ20FY+w3r0ZdNs5/oLR9qoYOlLa/pMlHVnFXsXm9+GH
	 N5JMdgJoSTBTQ0b6j45uPFbYuBceKVmDVbkMPul7nDJW6wGaK9lxsg8ha8CmQeebetz87
	 3swxZZXgFVyNYxdPS+znlcCMy55BjNCsiQApELytpN6fK1woT8h8hXKT/pVKoeYGIrg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=baylibre.com;
	spf=pass smtp.mailfrom=baylibre.com;
	dkim=pass header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=hawRLWGs;
	arc=none smtp.remote-ip=209.85.128.51
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A61F160A383A
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 16:29:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A61F160A383A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=baylibre.com header.i=@baylibre.com header.a=rsa-sha256 header.s=google header.b=hawRLWGs
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-4a2d6d01ecbso15320835e9.0
        for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 09:29:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1793032195; x=1793636995; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=08drD1ymTUi9hsmUJNZ4ArGmW7O1mMyycL0HsIwG3PI=;
        b=hawRLWGsJxJMOvzgTM9MdAaXoCQZ6ovu7tX8i5KbyGViXl0QBgtMu+wbXjuahhtY+R
         i5CyQDiDPGbXlli2m+nVlXM8xDDR2x4CpqqDEbDOXkR5PliJuLgJx03KbUcgFW/i4p0l
         uM3r0Jkbj8WEXJkoaAf/6fVg2+1WTflmovvAL/8UYK2cJUuDnstxEHYYTj5oH6R8G0tQ
         97CGQNHrIVM7Z20WWtu60UZPVIOHD5JBU0Z43PLeFBzJhmbjuZPKSN3BqrHDMmQvAGtM
         p75eOODvoT0TIkox2Euzp/MwDwgkTCQTr2Umyd9EgS6GNHlUjD8EbdMiUgnU5gwsj/6O
         FFhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793032195; x=1793636995;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=08drD1ymTUi9hsmUJNZ4ArGmW7O1mMyycL0HsIwG3PI=;
        b=yC/nduZHwK1ndUlAZnqJtAxXc+7uk0LyOJDzop552J3CX2umvp8OfQah9SCXzip3gc
         0oZa/WkBv4yUc9J/rSFd+viZzXR1gi1P2iFvUOl7aOjGNIsSknY9VHWhfcZKGCxHXHhh
         TEM3TedTzlZ/hsuOc6zsBMSPpEVf67MB5JDAsaWDlMkOiiM/6la08Aec/ubF9KmYTaQm
         0UV+w2wlUVDqmtS2GiyDeI38j46kn4XX4dVYuh5y8srJ7HCvzZ764HkIC1mKCdWkg1h4
         LdAPufFiMrSHb3Thlof/mgZ0FkupmKK2u4XO+KVNcPZZh6O+WnqOVm9VVpI3QHaYkC/z
         vEfQ==
X-Forwarded-Encrypted: i=1; AKwUvBwkvb07K4B6Is+pY1BWrGEI+bOnHxH8laOJVjjtpgbTfbW2T2gcXyNTSypRdB0NPy+VUekC3Yq2yUgN5DEXcQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYLp5PMnHo45L6oPV32WWVvIWIzaw7TV6Qap/kdxrBQTfupq3j2J
	FZcPk3q1boEnVV7XW3P/h3BtRqoY4EQrCuZyg2kgujeZ38MjFeI5NGJrFP8cWSVriaY=
X-Gm-Gg: AYBFou322Po2Xxv7MtFP+i7W4Vt5d1GwyokqKjRsvCFKlP9yEc9kky8OAZqwK+WB0RM
	jzgGpI05cms3PGQkKa/njbQEsjN8IDk2pf5ygzy3skUNfM8eBtnskK8g7wgLsIc94/ESCIzxF9k
	TjU2bE7sKJg5anYk5H9Vg7NAn02pTPkxHPUFLmWuB/ngGVXk6aAgItIn6EDc5mGH3p5z8/u9CPE
	zP0V17d6sV5ivyHs68Nsv+UB65tz3GnqV8oyiUsZdptZZePQs3utIrvyLm0324rfRY/ZpSdGg9P
	nsko0AWcyg7jcR6+gCK0C2MRilkQar538w+pG25g4cN6HqlnNvif+aljZa3cohu9iE78z3dEtty
	qQwVFyWwL9Si/jzSwherW/SpBW622hbRTozvCp1UjuMOYTdGmOGw3O8Q9iQ1b6AiwvZq2NYAJey
	MNdn6vs9ySU1XAfsJAgt9nXcGHR7RiRnP0/mCGyKQlr1Dc0dI7Rr19ge1cA25d3E1lBwVLxtzb2
	13cdtttlvYvbiodLvCCRK7L9nJgxe+4EbWZ/iaEXPxQi35VmALiymI89FwAklFFl2xlPsKpaYkx
	miOhZPwDQzHWJlmE8JmpkzlU+uCfMtQmsYfXT6PoIZ5n
X-Received: by 2002:a05:600c:4e43:b0:4a3:5991:719 with SMTP id 5b1f17b1804b1-4a7776698f9mr22225345e9.31.1793032195002;
        Mon, 26 Oct 2026 09:29:55 -0700 (PDT)
Received: from localhost (p200300f65f19a904cbccaa7a4d73ac15.dip0.t-ipconnect.de. [2003:f6:5f19:a904:cbcc:aa7a:4d73:ac15])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-48e3ebd49afsm17669401f8f.35.2026.10.26.09.29.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:29:54 -0700 (PDT)
From: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig=20=28The=20Capable=20Hub=29?= <u.kleine-koenig@baylibre.com>
To: Linus Walleij <linusw@kernel.org>,
	Bartosz Golaszewski <brgl@kernel.org>
Cc: "Enrico Weigelt, metux IT consult" <info@metux.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Andy Shevchenko <andy@kernel.org>,
	linux-gpio@vger.kernel.org,
	virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Viresh Kumar <viresh.kumar@linaro.org>
Subject: [PATCH v3 16/22] gpio: virtio: Use a named initializer for virtio_device_id array
Date: Mon, 26 Oct 2026 17:28:27 +0100
Message-ID:  <214191c76607fa156b8c9d9209ec8f4e49a4b44d.1793030820.git.u.kleine-koenig@baylibre.com>
X-Mailer: git-send-email 2.56.0.rc1
In-Reply-To: <cover.1793030820.git.u.kleine-koenig@baylibre.com>
References: <cover.1793030820.git.u.kleine-koenig@baylibre.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1078; i=u.kleine-koenig@baylibre.com; h=from:subject:message-id; bh=HvLKZnIb7RtprxLD/D+7QxSMDdlX02hi9zaVYI1agxw=; b=owEBbQGS/pANAwAKAY+A+1h9Ev5OAcsmYgBq33/E2/88AYjCtY1NH3iLuLQmQBlGZKTuZPwEN I+ROn5ltvSJATMEAAEKAB0WIQQ/gaxpOnoeWYmt/tOPgPtYfRL+TgUCat9/xAAKCRCPgPtYfRL+ Ti09CACXlBrBIggIPRy7K+bnoOgAplGl7A2GNsIbOzirBWsIaPJ2sZoYQcdMyaUJ7dyRvMEXVbW 4L0MenSBLD1aCJBa1sMnYOMhhp8r5UL7zjAmh/SiFLr6pzbUPdtgqE5PTo7t6yueD2k3HBmQ/0x 3aepLEUro6ABLL8k3sKyfLFK18CuxIYb5BggqhKSQHjbN661TVZHaT+oFi1PkgaCWI0qSMn2jMB cizrNJq1w7ITdmWFrRo/RdJELM8a1EnZw/2y3/Whjc6kVbLVxxnBHm6F7wsZhJLgDCdt4dPBhLC dnbcvS1DmGYvPVju+7LvCxleQFfL7OzCNCctALVZU66wcsq3
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

