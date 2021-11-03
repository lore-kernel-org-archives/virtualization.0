Return-Path: <SRS0=Oeu7=PW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B734C433EF
	for <virtualization@archiver.kernel.org>; Wed,  3 Nov 2021 08:12:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E664461139
	for <virtualization@archiver.kernel.org>; Wed,  3 Nov 2021 08:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E664461139
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B9C66608F3;
	Wed,  3 Nov 2021 08:12:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q7me7gdzgAgE; Wed,  3 Nov 2021 08:12:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 72B1D608F7;
	Wed,  3 Nov 2021 08:12:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4AA0DC0038;
	Wed,  3 Nov 2021 08:12:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2057BC0036
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 08:12:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0F5D5608F3
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 08:12:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id plwfUpX69Md8
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 08:12:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5414D608EC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 08:12:38 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id d24so2312286wra.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Nov 2021 01:12:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=HJ3FVZIBonOhulw4j97XZ+WDT4N0aGjKYTEFgdMl2bY=;
 b=JXOifM4MNm9L+pvuMPCtYiZuBmZxpoW+xBg9RV/lvq0vyOIrhLBU90/mOdrfeSUONJ
 7oJiN5DqUEPt/WZUSZrMEMk+u6gaZPniYJUK2Jn8Mog/pUaRgkGcVa2d4azMjZu6ge8V
 2tRhElbBP5TnzfgEFaFCCbq+ZCv503uEfWo063bHwjqdW1+lIRR8cQ017Xhb5Lxev8vf
 MzKFGpB7hjfY0/bSldFn6nMBqnpLeZXejg6iMgrLKz9QstuA7ymU8B9MqkqTUA6Mx0J7
 RDMtBegu9+f9FTuDvCyXICw1ac39wji75n9NXrc1PWh8c/06rLLwAnVBC6hsK9QkqcDd
 oAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=HJ3FVZIBonOhulw4j97XZ+WDT4N0aGjKYTEFgdMl2bY=;
 b=mRP7nA1/Yr453rBXAXR0RkuNpDW5c/tGU2duwgV5kZ6n6g/NeAE9o7Uu6UI5f2B2pV
 oCU77PRKzDER3XR53EsH9zrh8N/co06qGRz+8ZxELgxjUO/TsuqOqEV0WW5GrDERQ1uc
 sR49HhXrPcZ4vBKEGOyLi5wl+pDcersNFno0h56g0y9wA4E+o7HAsEtd/dSORjibPW02
 mngS5pEYdbUWNYIqCMlY//89ihU6WSzy72RYkR2XzGDSalsUYIFwDQV6c9P+ksiCVf0G
 T7y3kxRFT8j4miBrBPpdViuYCiSzQYINL5QLeqYtzBLautgtbZKXxP121Z5sGF8jcUAZ
 aNEg==
X-Gm-Message-State: AOAM533h9er/yTIOaYTM+Xo5ZJeuAPiAJjF516FueEKXeBnVVbN0k8Xz
 UDY+Y5ZmpCetoROALHO10Es=
X-Google-Smtp-Source: ABdhPJzp5J2ZSTw5FkIantmdIMrJRVk6kmOjpd1Snb9Ua//19DlbcOGakawpnJrzusJ9UjVTMxcMiA==
X-Received: by 2002:a5d:460d:: with SMTP id t13mr50612704wrq.44.1635927156535; 
 Wed, 03 Nov 2021 01:12:36 -0700 (PDT)
Received: from abel.fritz.box (p5b0ea1b5.dip0.t-ipconnect.de. [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id
 l7sm1450088wry.86.2021.11.03.01.12.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Nov 2021 01:12:36 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: linux-media@vger.kernel.org, etnaviv@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org,
 spice-devel@lists.freedesktop.org
Subject: [PATCH 2/4] drm/msm: use the new dma_resv_describe
Date: Wed,  3 Nov 2021 09:12:29 +0100
Message-Id: <20211103081231.18578-3-christian.koenig@amd.com>
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

SW5zdGVhZCBvZiBoYW5kIHJvbGxpbmcgcHJldHR5IG11Y2ggdGhlIHNhbWUgY29kZS4KClNpZ25l
ZC1vZmYtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KUmV2
aWV3ZWQtYnk6IFJvYiBDbGFyayA8cm9iZGNsYXJrQGdtYWlsLmNvbT4KLS0tCiBkcml2ZXJzL2dw
dS9kcm0vbXNtL21zbV9nZW0uYyB8IDIwICstLS0tLS0tLS0tLS0tLS0tLS0tCiAxIGZpbGUgY2hh
bmdlZCwgMSBpbnNlcnRpb24oKyksIDE5IGRlbGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZl
cnMvZ3B1L2RybS9tc20vbXNtX2dlbS5jIGIvZHJpdmVycy9ncHUvZHJtL21zbS9tc21fZ2VtLmMK
aW5kZXggNWJkNTExZjA3YzA3Li4zODc4YjhkYzJkNTkgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9tc20vbXNtX2dlbS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9tc20vbXNtX2dlbS5jCkBA
IC04NjUsMjMgKzg2NSwxMSBAQCBpbnQgbXNtX2dlbV9jcHVfZmluaShzdHJ1Y3QgZHJtX2dlbV9v
YmplY3QgKm9iaikKIH0KIAogI2lmZGVmIENPTkZJR19ERUJVR19GUwotc3RhdGljIHZvaWQgZGVz
Y3JpYmVfZmVuY2Uoc3RydWN0IGRtYV9mZW5jZSAqZmVuY2UsIGNvbnN0IGNoYXIgKnR5cGUsCi0J
CXN0cnVjdCBzZXFfZmlsZSAqbSkKLXsKLQlpZiAoIWRtYV9mZW5jZV9pc19zaWduYWxlZChmZW5j
ZSkpCi0JCXNlcV9wcmludGYobSwgIlx0JTlzOiAlcyAlcyBzZXEgJWxsdVxuIiwgdHlwZSwKLQkJ
CQlmZW5jZS0+b3BzLT5nZXRfZHJpdmVyX25hbWUoZmVuY2UpLAotCQkJCWZlbmNlLT5vcHMtPmdl
dF90aW1lbGluZV9uYW1lKGZlbmNlKSwKLQkJCQlmZW5jZS0+c2Vxbm8pOwotfQotCiB2b2lkIG1z
bV9nZW1fZGVzY3JpYmUoc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmosIHN0cnVjdCBzZXFfZmls
ZSAqbSwKIAkJc3RydWN0IG1zbV9nZW1fc3RhdHMgKnN0YXRzKQogewogCXN0cnVjdCBtc21fZ2Vt
X29iamVjdCAqbXNtX29iaiA9IHRvX21zbV9ibyhvYmopOwogCXN0cnVjdCBkbWFfcmVzdiAqcm9i
aiA9IG9iai0+cmVzdjsKLQlzdHJ1Y3QgZG1hX3Jlc3ZfaXRlciBjdXJzb3I7Ci0Jc3RydWN0IGRt
YV9mZW5jZSAqZmVuY2U7CiAJc3RydWN0IG1zbV9nZW1fdm1hICp2bWE7CiAJdWludDY0X3Qgb2Zm
ID0gZHJtX3ZtYV9ub2RlX3N0YXJ0KCZvYmotPnZtYV9ub2RlKTsKIAljb25zdCBjaGFyICptYWR2
OwpAQCAtOTU1LDEzICs5NDMsNyBAQCB2b2lkIG1zbV9nZW1fZGVzY3JpYmUoc3RydWN0IGRybV9n
ZW1fb2JqZWN0ICpvYmosIHN0cnVjdCBzZXFfZmlsZSAqbSwKIAkJc2VxX3B1dHMobSwgIlxuIik7
CiAJfQogCi0JZG1hX3Jlc3ZfZm9yX2VhY2hfZmVuY2UoJmN1cnNvciwgcm9iaiwgdHJ1ZSwgZmVu
Y2UpIHsKLQkJaWYgKGRtYV9yZXN2X2l0ZXJfaXNfZXhjbHVzaXZlKCZjdXJzb3IpKQotCQkJZGVz
Y3JpYmVfZmVuY2UoZmVuY2UsICJFeGNsdXNpdmUiLCBtKTsKLQkJZWxzZQotCQkJZGVzY3JpYmVf
ZmVuY2UoZmVuY2UsICJTaGFyZWQiLCBtKTsKLQl9Ci0KKwlkbWFfcmVzdl9kZXNjcmliZShyb2Jq
LCBtKTsKIAltc21fZ2VtX3VubG9jayhvYmopOwogfQogCi0tIAoyLjI1LjEKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
