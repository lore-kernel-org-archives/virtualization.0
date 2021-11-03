Return-Path: <SRS0=Oeu7=PW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D526C43217
	for <virtualization@archiver.kernel.org>; Wed,  3 Nov 2021 08:12:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D2F161139
	for <virtualization@archiver.kernel.org>; Wed,  3 Nov 2021 08:12:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4D2F161139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 81D5D40357;
	Wed,  3 Nov 2021 08:12:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A6Mul3_6ge1O; Wed,  3 Nov 2021 08:12:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id EE1724031E;
	Wed,  3 Nov 2021 08:12:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC9B1C0037;
	Wed,  3 Nov 2021 08:12:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0ADE8C0019
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 08:12:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id DD04080E83
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 08:12:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PAIoGWPENykX
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 08:12:40 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com
 [IPv6:2a00:1450:4864:20::42c])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1D9E680E84
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 08:12:39 +0000 (UTC)
Received: by mail-wr1-x42c.google.com with SMTP id r8so2222320wra.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Nov 2021 01:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=4CDt1ISjRTMYLH7FxvvLqp3He8TQZQtgj+2GfXtaN90=;
 b=g9U1aSa+6bfag8lo3nJKStn7BnOsmwJb6j1n4QC0Lkp1bDff6m9nVVeAoToH3yAudW
 4jTbxb8/cz27CKva48/O/RblrmnLlJa141hwjr/7zvWE1IjnsP9KKu7Zbc4G7kGQ+bjy
 TRMIQFhu0WKSRP/jVfYGghycdSFltphYSAwVFMpZt91dTudt5/B1Bw7LABU4HXO3tbv8
 q9Q62IJ8avbKVgS4KTNxIMKbWGcXUxKEB+i3t+0ZCrlwNWFLXmBmD/GZCpKLiZFgIp3z
 8zW847hVRQ1jOayX9XCwct3J+rN0aZqVN6CWHmMOhJF6kywpn1Xl6nxJGDznecM+bw+q
 2k2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=4CDt1ISjRTMYLH7FxvvLqp3He8TQZQtgj+2GfXtaN90=;
 b=hrBEs9smIlslSW15zRbu6sYVbDecnETiqgK6TE7cOG7AG3UwwKELeHG4BzUZbN3vGa
 UIv+bqFYlj35VPc6+jwTvSxPtnmP0Rpzp/ZsgahytXvCHa03xA6rhXtm/E7kwnQh868I
 9IanUwVZqhmZJumUHDaeWmUbCY/HuJnB6Y0UHEMq/FzkioeR1Rek5yQClkIozYfTIbAe
 CePup0V1D2Ha4OvaJLL4FoeBWNjvElGF5koMJr0pFipMYSmWZnUvH7WjO4m3Pq4hhqth
 zF/IhQMsRmKRu8pydHGNk5HpiDDUjOsmGQlMqJI22IOwvZKHzLbCYEIl27nwZJ5otHCZ
 wj+w==
X-Gm-Message-State: AOAM532ueU/LKZTur5i+amAuMcLC91DvH6P8vwHWXQlQu+YLd14lON0f
 2SaM9Ailt3Wp+Nk4JqNgSt692/bY8IU=
X-Google-Smtp-Source: ABdhPJxlY/OJLgc774nRzsIwvqJo4XvP/pZEzGcq0XIZGbOcmmVvVYVPx0RKwrS16P8UJv2gUPvNvA==
X-Received: by 2002:a5d:6dae:: with SMTP id u14mr53757436wrs.46.1635927158385; 
 Wed, 03 Nov 2021 01:12:38 -0700 (PDT)
Received: from abel.fritz.box (p5b0ea1b5.dip0.t-ipconnect.de. [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id
 l7sm1450088wry.86.2021.11.03.01.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Nov 2021 01:12:38 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: linux-media@vger.kernel.org, etnaviv@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org,
 spice-devel@lists.freedesktop.org
Subject: [PATCH 4/4] drm/qxl: use iterator instead of dma_resv_shared_list
Date: Wed,  3 Nov 2021 09:12:31 +0100
Message-Id: <20211103081231.18578-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20211103081231.18578-1-christian.koenig@amd.com>
References: <20211103081231.18578-1-christian.koenig@amd.com>
MIME-Version: 1.0
Cc: sumit.semwal@linaro.org, daniel@ffwll.ch, l.stach@pengutronix.de
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
