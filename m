Return-Path: <SRS0=hVMj=PQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB008C433FE
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 08:58:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7CFC161100
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 08:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 7CFC161100
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 38F12817C0;
	Thu, 28 Oct 2021 08:58:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J0tgsXKx0H-W; Thu, 28 Oct 2021 08:58:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F211181D11;
	Thu, 28 Oct 2021 08:58:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B1AAC0037;
	Thu, 28 Oct 2021 08:58:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7418C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 08:58:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id C6CCA60B4F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 08:58:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yu19VdCI62BI
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 08:58:36 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com
 [IPv6:2a00:1450:4864:20::32c])
 by smtp3.osuosl.org (Postfix) with ESMTPS id DA01760725
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 08:58:35 +0000 (UTC)
Received: by mail-wm1-x32c.google.com with SMTP id
 j128-20020a1c2386000000b003301a98dd62so285612wmj.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 01:58:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4CDt1ISjRTMYLH7FxvvLqp3He8TQZQtgj+2GfXtaN90=;
 b=a49w+C/y2sbZAU5tKWLTRIp351EX7VpCOI6BKaM8KxWJvC5HzCpafogg+jEZ2O+f5a
 Nm/7cC3SJ2uXEmJ5bCkyV63be86lADCvdtC8euPvITGkeSRYZyQw7Sa1680UshZFXQz/
 9UlHdHthOhGAcl73+AG83bWY/CJaTpkPfDA8/GzGX6HalbIti0y/6sjgY6/P/BSNDBiA
 6GbgPHZ0q87VEgCbsxXdTsCQsRmlq0C4KnFUbX8xR46d4POBvvUr9nkVwcviOHxCqcg4
 kXZB1y8qbCNJRdsRMQ3DMbG2/5NN1hkF5HeNQMo34c5Uwz++WzYb5AX+49xiwcLK3kJX
 90hg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4CDt1ISjRTMYLH7FxvvLqp3He8TQZQtgj+2GfXtaN90=;
 b=516GOw8K1zEVwR6OrVfSWT3eO8bXJ0P2E/Rv43mq6T/1ARmuEAyytqss+CbQFup24j
 204X/6I8sG/LjX9h0q8nXE2I7RGhoR0Jqtc6mD0s8yWSzohcRJChYHsdsSGMnqIH5Nxo
 OCG+Y5JN4bnP5557TS1lsFJVa/c+mlgjbiW/Ix2axTYMlQuXtDlYEEVv6han2E6e11+p
 btshaeCZC7tJQ3ZhQuEL9OJ/RbBYCOw1sJlo7Pk3n5rh/dZowBt/gqR5iC9BPIJZBvjO
 MAZhBekN9HKIE3pvgFVsPpuedBdmlYs+K+jSwAZOHlDUzNLnA6j1nU1iDdnxN1ihncYu
 PYzA==
X-Gm-Message-State: AOAM531D52iPX8lQ6HQ7um6kPhm5ztr/IbcDX9T6+iZfFbOny0EYi2dB
 qeSBduU/qFhWXD0pwgYPlBc=
X-Google-Smtp-Source: ABdhPJwOvkH0PJNa8GaEqN3ST8vn3EFPokaEJKjsSgERJyLOcZWZ1yA+NuGzCaCXn2rkSVmKVfClTA==
X-Received: by 2002:a1c:540c:: with SMTP id i12mr3048967wmb.6.1635411513954;
 Thu, 28 Oct 2021 01:58:33 -0700 (PDT)
Received: from abel.fritz.box (p5b0ea1b5.dip0.t-ipconnect.de. [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id
 k22sm2412143wrd.59.2021.10.28.01.58.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Oct 2021 01:58:33 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org
Subject: [PATCH 4/4] drm/qxl: use iterator instead of dma_resv_shared_list
Date: Thu, 28 Oct 2021 10:58:29 +0200
Message-Id: <20211028085829.1726-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211028085829.1726-1-christian.koenig@amd.com>
References: <20211028085829.1726-1-christian.koenig@amd.com>
MIME-Version: 1.0
Cc: spice-devel@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 freedreno@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

SSdtIG5vdCBzdXJlIHdoeSBpdCBpcyB1c2VmdWwgdG8ga25vdyB0aGUgbnVtYmVyIG9mIGZlbmNl
cwppbiB0aGUgcmVzZXJ2YXRpb24gb2JqZWN0LCBidXQgd2UgdHJ5IHRvIGF2b2lkIGV4cG9zaW5n
IHRoZQpkbWFfcmVzdl9zaGFyZWRfbGlzdCgpIGZ1bmN0aW9uLgoKU28gdXNlIHRoZSBpdGVyYXRv
ciBpbnN0ZWFkLiBJZiBtb3JlIGluZm9ybWF0aW9uIGlzIGRlc2lyZWQKd2UgY291bGQgdXNlIGRt
YV9yZXN2X2Rlc2NyaWJlKCkgYXMgd2VsbC4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlhbiBLw7Zu
aWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vcXhsL3F4
bF9kZWJ1Z2ZzLmMgfCAxNyArKysrKysrKysrLS0tLS0tLQogMSBmaWxlIGNoYW5nZWQsIDEwIGlu
c2VydGlvbnMoKyksIDcgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L3F4bC9xeGxfZGVidWdmcy5jIGIvZHJpdmVycy9ncHUvZHJtL3F4bC9xeGxfZGVidWdmcy5jCmlu
ZGV4IDFmOWE1OTYwMWJiMS4uNmEzNmIwZmQ4NDVjIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9k
cm0vcXhsL3F4bF9kZWJ1Z2ZzLmMKKysrIGIvZHJpdmVycy9ncHUvZHJtL3F4bC9xeGxfZGVidWdm
cy5jCkBAIC01NywxMyArNTcsMTYgQEAgcXhsX2RlYnVnZnNfYnVmZmVyc19pbmZvKHN0cnVjdCBz
ZXFfZmlsZSAqbSwgdm9pZCAqZGF0YSkKIAlzdHJ1Y3QgcXhsX2JvICpibzsKIAogCWxpc3RfZm9y
X2VhY2hfZW50cnkoYm8sICZxZGV2LT5nZW0ub2JqZWN0cywgbGlzdCkgewotCQlzdHJ1Y3QgZG1h
X3Jlc3ZfbGlzdCAqZm9iajsKLQkJaW50IHJlbDsKLQotCQlyY3VfcmVhZF9sb2NrKCk7Ci0JCWZv
YmogPSBkbWFfcmVzdl9zaGFyZWRfbGlzdChiby0+dGJvLmJhc2UucmVzdik7Ci0JCXJlbCA9IGZv
YmogPyBmb2JqLT5zaGFyZWRfY291bnQgOiAwOwotCQlyY3VfcmVhZF91bmxvY2soKTsKKwkJc3Ry
dWN0IGRtYV9yZXN2X2l0ZXIgY3Vyc29yOworCQlzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZTsKKwkJ
aW50IHJlbCA9IDA7CisKKwkJZG1hX3Jlc3ZfaXRlcl9iZWdpbigmY3Vyc29yLCBiby0+dGJvLmJh
c2UucmVzdiwgdHJ1ZSk7CisJCWRtYV9yZXN2X2Zvcl9lYWNoX2ZlbmNlX3VubG9ja2VkKCZjdXJz
b3IsIGZlbmNlKSB7CisJCQlpZiAoZG1hX3Jlc3ZfaXRlcl9pc19yZXN0YXJ0ZWQoJmN1cnNvcikp
CisJCQkJcmVsID0gMDsKKwkJCSsrcmVsOworCQl9CiAKIAkJc2VxX3ByaW50ZihtLCAic2l6ZSAl
bGQsIHBjICVkLCBudW0gcmVsZWFzZXMgJWRcbiIsCiAJCQkgICAodW5zaWduZWQgbG9uZyliby0+
dGJvLmJhc2Uuc2l6ZSwKLS0gCjIuMjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
