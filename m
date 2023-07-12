Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B000EEB64DD
	for <virtualization@archiver.kernel.org>; Wed, 12 Jul 2023 12:47:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 22827419D3;
	Wed, 12 Jul 2023 12:47:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 22827419D3
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20221208 header.b=k4x8P5cQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n7IN0XAnf-PF; Wed, 12 Jul 2023 12:47:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5450D4195A;
	Wed, 12 Jul 2023 12:47:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5450D4195A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 06F64C0072;
	Wed, 12 Jul 2023 12:47:14 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 73273C0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 12:47:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4E6024036F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 12:47:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4E6024036F
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20221208 header.b=k4x8P5cQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a64qtlUOm6IR
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 12:47:12 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 668EA400CC
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 668EA400CC
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 12:47:12 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id
 ffacd0b85a97d-31590e4e27aso4313539f8f.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jul 2023 05:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20221208; t=1689166030; x=1691758030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=3Xh5RMuLzB6AZnd1vsrppGQ5UNHATRX9hF95pP3+kNg=;
 b=k4x8P5cQn4pvpM6erMvBQpUTVTNi+yCigoFuT064t5a8Hgw67L/Etwvh9FrfKUYGtn
 Pi0qGA+/t4CID0SuoPV41x32dlC+j5rNnfW46fWZQPjLDoxDlQnVQTSozUG5pRK77k96
 4voJqBe3Ol69T0bc7YAqCdB1HEQTuzazEb9dm4BBypSTQx3bmTeMzyW5tRhGc/nA3cYo
 Qri7L0mCKtr7ktZu722tvkuVUG3tvIqYtJaSt02eMTJkRCkAnsDO/MPk6SIn59Moor3J
 ah0agXhL2OWLzq03MRtdBwkYJEnutH78oZICLz1frHIZYy3EWY5fyzXXO5vQ1YaOqA14
 GKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689166030; x=1691758030;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3Xh5RMuLzB6AZnd1vsrppGQ5UNHATRX9hF95pP3+kNg=;
 b=Tb6/mZJHqB6nR/cxsWb88IzZz3r1ocQISiD73LYHJPMBwnCn7eMcYkfQ7pwk1qV2pa
 CfdrizqJ2QJSlSNZ7r+9xsaKuZpYxy1+8TBh+FUy5GdjXUAZKUtXEJIjSN0lv7S2Raya
 S4lBeSFIIpMOzw57VexYyZFEaxzNpP1kXSJvhUErnP2HTC4dly5lOtcCn7tAO8e+4RU0
 5XXa4CRIovMKnbxLj2xBkNUzsn/OBtnes/gaSmOAbf/nrQGLIpGpyVMrhgSR52R6XYXX
 14PCXw7qSrB6XlwfVdULWdMpTsmBOiG379m5jEaPo9ODjH+AZha5BwGno7D7CmUDBR/B
 XaZw==
X-Gm-Message-State: ABy/qLa/KumJ9+RDqO9u+54mOxwhxpGS0HMczUdWk9YxeoPhVKCbjMuL
 T0W7/+UyVRUb3Q+vEmXjIEo=
X-Google-Smtp-Source: APBJJlGPxZP3AapSCcqrBo9XpTcLvDyjY/PBnCBR0Cv72nSZgVUCz5VzggU0jEc/10Vksn0+sILn4A==
X-Received: by 2002:a05:6000:1cc9:b0:314:2735:dc13 with SMTP id
 bf9-20020a0560001cc900b003142735dc13mr18659974wrb.47.1689166030228; 
 Wed, 12 Jul 2023 05:47:10 -0700 (PDT)
Received: from EliteBook.fritz.box ([2a00:e180:1557:4100:d4c4:2bb7:77d6:6d86])
 by smtp.gmail.com with ESMTPSA id
 j8-20020adfe508000000b0031424950a99sm4989225wrm.81.2023.07.12.05.47.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Jul 2023 05:47:09 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: dri-devel@lists.freedesktop.org
Subject: [PATCH 4/7] drm/virtgpu: switch to using drm_exec
Date: Wed, 12 Jul 2023 14:47:01 +0200
Message-Id: <20230712124704.333004-5-christian.koenig@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230712124704.333004-1-christian.koenig@amd.com>
References: <20230712124704.333004-1-christian.koenig@amd.com>
MIME-Version: 1.0
Cc: =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 David Airlie <airlied@redhat.com>, virtualization@lists.linux-foundation.org,
 Chia-I Wu <olvaffe@gmail.com>
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

SnVzdCBhIHN0cmFpZ2h0Zm9yd2FyZCBjb252ZXJzaW9uIHdpdGhvdXQgYW55IG9wdGltaXphdGlv
bi4KCk9ubHkgY29tcGlsZSB0ZXN0ZWQgZm9yIG5vdy4KClNpZ25lZC1vZmYtYnk6IENocmlzdGlh
biBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IERhdmlkIEFpcmxpZSA8YWly
bGllZEByZWRoYXQuY29tPgpDYzogR2VyZCBIb2ZmbWFubiA8a3JheGVsQHJlZGhhdC5jb20+CkNj
OiBHdXJjaGV0YW4gU2luZ2ggPGd1cmNoZXRhbnNpbmdoQGNocm9taXVtLm9yZz4KQ2M6IENoaWEt
SSBXdSA8b2x2YWZmZUBnbWFpbC5jb20+CkNjOiB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwotLS0KIGRyaXZlcnMvZ3B1L2RybS92aXJ0aW8vS2NvbmZpZyAgICAgICB8
ICAxICsKIGRyaXZlcnMvZ3B1L2RybS92aXJ0aW8vdmlydGdwdV9kcnYuaCB8ICAzICsrLQogZHJp
dmVycy9ncHUvZHJtL3ZpcnRpby92aXJ0Z3B1X2dlbS5jIHwgMjggKysrKystLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQogMyBmaWxlcyBjaGFuZ2VkLCA4IGluc2VydGlvbnMoKyksIDI0IGRlbGV0aW9u
cygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS92aXJ0aW8vS2NvbmZpZyBiL2RyaXZl
cnMvZ3B1L2RybS92aXJ0aW8vS2NvbmZpZwppbmRleCBlYTA2ZmYyYWE0YjQuLmEyNGExY2U1ZTY2
NiAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL3ZpcnRpby9LY29uZmlnCisrKyBiL2RyaXZl
cnMvZ3B1L2RybS92aXJ0aW8vS2NvbmZpZwpAQCAtNSw2ICs1LDcgQEAgY29uZmlnIERSTV9WSVJU
SU9fR1BVCiAJc2VsZWN0IFZJUlRJTwogCXNlbGVjdCBEUk1fS01TX0hFTFBFUgogCXNlbGVjdCBE
Uk1fR0VNX1NITUVNX0hFTFBFUgorCXNlbGVjdCBEUk1fRVhFQwogCXNlbGVjdCBWSVJUSU9fRE1B
X1NIQVJFRF9CVUZGRVIKIAloZWxwCiAJICAgVGhpcyBpcyB0aGUgdmlydHVhbCBHUFUgZHJpdmVy
IGZvciB2aXJ0aW8uICBJdCBjYW4gYmUgdXNlZCB3aXRoCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dw
dS9kcm0vdmlydGlvL3ZpcnRncHVfZHJ2LmggYi9kcml2ZXJzL2dwdS9kcm0vdmlydGlvL3ZpcnRn
cHVfZHJ2LmgKaW5kZXggNDEyNmMzODQyODZiLi5jYjVkOTIxOGEzYWIgMTAwNjQ0Ci0tLSBhL2Ry
aXZlcnMvZ3B1L2RybS92aXJ0aW8vdmlydGdwdV9kcnYuaAorKysgYi9kcml2ZXJzL2dwdS9kcm0v
dmlydGlvL3ZpcnRncHVfZHJ2LmgKQEAgLTM1LDYgKzM1LDcgQEAKICNpbmNsdWRlIDxkcm0vZHJt
X2F0b21pYy5oPgogI2luY2x1ZGUgPGRybS9kcm1fZHJ2Lmg+CiAjaW5jbHVkZSA8ZHJtL2RybV9l
bmNvZGVyLmg+CisjaW5jbHVkZSA8ZHJtL2RybV9leGVjLmg+CiAjaW5jbHVkZSA8ZHJtL2RybV9m
b3VyY2MuaD4KICNpbmNsdWRlIDxkcm0vZHJtX2ZyYW1lYnVmZmVyLmg+CiAjaW5jbHVkZSA8ZHJt
L2RybV9nZW0uaD4KQEAgLTExNiw3ICsxMTcsNyBAQCBzdHJ1Y3QgdmlydGlvX2dwdV9vYmplY3Rf
dnJhbSB7CiAJY29udGFpbmVyX29mKCh2aXJ0aW9fZ3B1X29iamVjdCksIHN0cnVjdCB2aXJ0aW9f
Z3B1X29iamVjdF92cmFtLCBiYXNlKQogCiBzdHJ1Y3QgdmlydGlvX2dwdV9vYmplY3RfYXJyYXkg
ewotCXN0cnVjdCB3d19hY3F1aXJlX2N0eCB0aWNrZXQ7CisJc3RydWN0IGRybV9leGVjIGV4ZWM7
CiAJc3RydWN0IGxpc3RfaGVhZCBuZXh0OwogCXUzMiBuZW50cywgdG90YWw7CiAJc3RydWN0IGRy
bV9nZW1fb2JqZWN0ICpvYmpzW107CmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdmlydGlv
L3ZpcnRncHVfZ2VtLmMgYi9kcml2ZXJzL2dwdS9kcm0vdmlydGlvL3ZpcnRncHVfZ2VtLmMKaW5k
ZXggN2RiNDhkMTdlZTNhLi5iYjc5MjhlN2IzYjYgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2Ry
bS92aXJ0aW8vdmlydGdwdV9nZW0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vdmlydGlvL3ZpcnRn
cHVfZ2VtLmMKQEAgLTE3MSw2ICsxNzEsNyBAQCBzdHJ1Y3QgdmlydGlvX2dwdV9vYmplY3RfYXJy
YXkgKnZpcnRpb19ncHVfYXJyYXlfYWxsb2ModTMyIG5lbnRzKQogCiAJb2Jqcy0+bmVudHMgPSAw
OwogCW9ianMtPnRvdGFsID0gbmVudHM7CisJZHJtX2V4ZWNfaW5pdCgmb2Jqcy0+ZXhlYywgRFJN
X0VYRUNfSU5URVJSVVBUSUJMRV9XQUlUKTsKIAlyZXR1cm4gb2JqczsKIH0KIApAQCAtMjE0LDM2
ICsyMTUsMTcgQEAgdm9pZCB2aXJ0aW9fZ3B1X2FycmF5X2FkZF9vYmooc3RydWN0IHZpcnRpb19n
cHVfb2JqZWN0X2FycmF5ICpvYmpzLAogCiBpbnQgdmlydGlvX2dwdV9hcnJheV9sb2NrX3Jlc3Yo
c3RydWN0IHZpcnRpb19ncHVfb2JqZWN0X2FycmF5ICpvYmpzKQogewotCXVuc2lnbmVkIGludCBp
OwogCWludCByZXQ7CiAKLQlpZiAob2Jqcy0+bmVudHMgPT0gMSkgewotCQlyZXQgPSBkbWFfcmVz
dl9sb2NrX2ludGVycnVwdGlibGUob2Jqcy0+b2Jqc1swXS0+cmVzdiwgTlVMTCk7Ci0JfSBlbHNl
IHsKLQkJcmV0ID0gZHJtX2dlbV9sb2NrX3Jlc2VydmF0aW9ucyhvYmpzLT5vYmpzLCBvYmpzLT5u
ZW50cywKLQkJCQkJCSZvYmpzLT50aWNrZXQpOwotCX0KLQlpZiAocmV0KQotCQlyZXR1cm4gcmV0
OwotCi0JZm9yIChpID0gMDsgaSA8IG9ianMtPm5lbnRzOyArK2kpIHsKLQkJcmV0ID0gZG1hX3Jl
c3ZfcmVzZXJ2ZV9mZW5jZXMob2Jqcy0+b2Jqc1tpXS0+cmVzdiwgMSk7Ci0JCWlmIChyZXQpIHsK
LQkJCXZpcnRpb19ncHVfYXJyYXlfdW5sb2NrX3Jlc3Yob2Jqcyk7Ci0JCQlyZXR1cm4gcmV0Owot
CQl9Ci0JfQorCWRybV9leGVjX3VudGlsX2FsbF9sb2NrZWQoJm9ianMtPmV4ZWMpCisJCXJldCA9
IGRybV9leGVjX3ByZXBhcmVfYXJyYXkoJm9ianMtPmV4ZWMsIG9ianMtPm9ianMsCisJCQkJCSAg
ICAgb2Jqcy0+bmVudHMsIDEpOwogCXJldHVybiByZXQ7CiB9CiAKIHZvaWQgdmlydGlvX2dwdV9h
cnJheV91bmxvY2tfcmVzdihzdHJ1Y3QgdmlydGlvX2dwdV9vYmplY3RfYXJyYXkgKm9ianMpCiB7
Ci0JaWYgKG9ianMtPm5lbnRzID09IDEpIHsKLQkJZG1hX3Jlc3ZfdW5sb2NrKG9ianMtPm9ianNb
MF0tPnJlc3YpOwotCX0gZWxzZSB7Ci0JCWRybV9nZW1fdW5sb2NrX3Jlc2VydmF0aW9ucyhvYmpz
LT5vYmpzLCBvYmpzLT5uZW50cywKLQkJCQkJICAgICZvYmpzLT50aWNrZXQpOwotCX0KKwlkcm1f
ZXhlY19maW5pKCZvYmpzLT5leGVjKTsKIH0KIAogdm9pZCB2aXJ0aW9fZ3B1X2FycmF5X2FkZF9m
ZW5jZShzdHJ1Y3QgdmlydGlvX2dwdV9vYmplY3RfYXJyYXkgKm9ianMsCi0tIAoyLjM0LjEKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
