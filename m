Return-Path: <SRS0=hVMj=PQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 35CA6C433EF
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 08:58:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C2F6D610C7
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 08:58:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C2F6D610C7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 81B46405AC;
	Thu, 28 Oct 2021 08:58:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rHPQ1QqHAsrE; Thu, 28 Oct 2021 08:58:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 9A289403D1;
	Thu, 28 Oct 2021 08:58:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6A3FBC0012;
	Thu, 28 Oct 2021 08:58:36 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 74A85C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 08:58:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 561BE403D1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 08:58:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4KDCn2p_sRKR
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 08:58:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com
 [IPv6:2a00:1450:4864:20::32f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 1FA4040322
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 08:58:32 +0000 (UTC)
Received: by mail-wm1-x32f.google.com with SMTP id
 131-20020a1c0489000000b0032cca9883b5so7343166wme.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 01:58:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8pRnJQmmB+/kCdjQaACOoqogylSvktqG3v7tsX861XU=;
 b=hQr+RlB7nQ0kBfkch66CVzLGjeTDfB3+Y0hgwSAS2sIF7Etfjcn1XcPfLlpIGUHMg2
 ypErUzIrTp2LgbVFx1p0RhBKHqX4iSF0rouLa5lDo9WLKNJu5AZk0uauZWo/LjxYVWAW
 aSMx3vpPwRqidL6Xl4o1ByaNIE8eaf8bv2KzlC0APlc21nIIu6d5wba1ZN3krvZY4MD1
 gggPyRk+vDHQ5Y+S265L1eTwGOQaVUykfdsVPiEXgwTGPROcAdj3Q3kpqW4RqfMEDxcq
 vt9x97Bck2Zw8CGbRYDnZp3YcQgWD0+At0VlfPOEj8Pjs6MGvRQUd0a3A+7SmC4qCIFU
 DPJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
 :content-transfer-encoding;
 bh=8pRnJQmmB+/kCdjQaACOoqogylSvktqG3v7tsX861XU=;
 b=ZL8auKLq/nE6xf5uEVfIHUwA+Bqev5tHT7iw23zdfmJfQFBTxu1mmLIiRA3SRYqbqt
 sQFQohHZRTIYqXXS1Dzg4TEidO53pLt75fqbmOGhhZUL811BN7VDEVEEWV15YVanZWhY
 BVoVXNegTgPXnrW4SUx+B2Kjf/XOykgqc0dKMWxRNQJ0bMtHZreSep4birTVoxFPVexP
 FXt4H8aKbOVWHc06Xzg7nTc+JFDlk69S2MW+UaEJQjXd5w2pOllIsv7oDVlyyiQ/AcQp
 Eqodiqs9x3XHHJXIkUncwf2RHUUQThsHDpjlXjccL+/9RsGD7rE+/vYSLGJle84AQYhl
 DIvQ==
X-Gm-Message-State: AOAM533fwfgEj9ihwrHeCXa3LzOh3YXnxR5iyMUXRhITCXHn98Bmavdo
 RgmntfKKCIXrH7M/Dt7p1k8=
X-Google-Smtp-Source: ABdhPJz8YhMDtgUIgGgUYWl+alCbM4WTONsbnjfCXo4Ut5lcjRZxATOVrz1OmZRT4kcVrUlDv3UamA==
X-Received: by 2002:a7b:cd9a:: with SMTP id y26mr11110448wmj.107.1635411511382; 
 Thu, 28 Oct 2021 01:58:31 -0700 (PDT)
Received: from abel.fritz.box (p5b0ea1b5.dip0.t-ipconnect.de. [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id
 k22sm2412143wrd.59.2021.10.28.01.58.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Oct 2021 01:58:30 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org
Subject: [PATCH 1/4] dma-buf: add dma_fence_describe and dma_resv_describe
Date: Thu, 28 Oct 2021 10:58:26 +0200
Message-Id: <20211028085829.1726-1-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
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

QWRkIGZ1bmN0aW9ucyB0byBkdW1wIGRtYV9mZW5jZSBhbmQgZG1hX3Jlc3Ygb2JqZWN0cyBpbnRv
IGEgc2VxX2ZpbGUgYW5kCnVzZSB0aGVtIGZvciBwcmludGluZyB0aGUgZGVidWdmcyBpbmZvcm1h
dGlvbnMuCgpTaWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmln
QGFtZC5jb20+ClJldmlld2VkLWJ5OiBSb2IgQ2xhcmsgPHJvYmRjbGFya0BnbWFpbC5jb20+Ci0t
LQogZHJpdmVycy9kbWEtYnVmL2RtYS1idWYuYyAgIHwgMTEgKy0tLS0tLS0tLS0KIGRyaXZlcnMv
ZG1hLWJ1Zi9kbWEtZmVuY2UuYyB8IDE2ICsrKysrKysrKysrKysrKysKIGRyaXZlcnMvZG1hLWJ1
Zi9kbWEtcmVzdi5jICB8IDIzICsrKysrKysrKysrKysrKysrKysrKysrCiBpbmNsdWRlL2xpbnV4
L2RtYS1mZW5jZS5oICAgfCAgMSArCiBpbmNsdWRlL2xpbnV4L2RtYS1yZXN2LmggICAgfCAgMSAr
CiA1IGZpbGVzIGNoYW5nZWQsIDQyIGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLmMgYi9kcml2ZXJzL2RtYS1idWYvZG1h
LWJ1Zi5jCmluZGV4IDdiNjE5OTk4ZjAzYS4uMWQ2ZjZjNmEwYjA5IDEwMDY0NAotLS0gYS9kcml2
ZXJzL2RtYS1idWYvZG1hLWJ1Zi5jCisrKyBiL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtYnVmLmMKQEAg
LTEzMzIsOCArMTMzMiw2IEBAIHN0YXRpYyBpbnQgZG1hX2J1Zl9kZWJ1Z19zaG93KHN0cnVjdCBz
ZXFfZmlsZSAqcywgdm9pZCAqdW51c2VkKQogewogCXN0cnVjdCBkbWFfYnVmICpidWZfb2JqOwog
CXN0cnVjdCBkbWFfYnVmX2F0dGFjaG1lbnQgKmF0dGFjaF9vYmo7Ci0Jc3RydWN0IGRtYV9yZXN2
X2l0ZXIgY3Vyc29yOwotCXN0cnVjdCBkbWFfZmVuY2UgKmZlbmNlOwogCWludCBjb3VudCA9IDAs
IGF0dGFjaF9jb3VudDsKIAlzaXplX3Qgc2l6ZSA9IDA7CiAJaW50IHJldDsKQEAgLTEzNjEsMTQg
KzEzNTksNyBAQCBzdGF0aWMgaW50IGRtYV9idWZfZGVidWdfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUg
KnMsIHZvaWQgKnVudXNlZCkKIAkJCQlmaWxlX2lub2RlKGJ1Zl9vYmotPmZpbGUpLT5pX2lubywK
IAkJCQlidWZfb2JqLT5uYW1lID86ICIiKTsKIAotCQlkbWFfcmVzdl9mb3JfZWFjaF9mZW5jZSgm
Y3Vyc29yLCBidWZfb2JqLT5yZXN2LCB0cnVlLCBmZW5jZSkgewotCQkJc2VxX3ByaW50ZihzLCAi
XHQlcyBmZW5jZTogJXMgJXMgJXNzaWduYWxsZWRcbiIsCi0JCQkJICAgZG1hX3Jlc3ZfaXRlcl9p
c19leGNsdXNpdmUoJmN1cnNvcikgPwotCQkJCQkiRXhjbHVzaXZlIiA6ICJTaGFyZWQiLAotCQkJ
CSAgIGZlbmNlLT5vcHMtPmdldF9kcml2ZXJfbmFtZShmZW5jZSksCi0JCQkJICAgZmVuY2UtPm9w
cy0+Z2V0X3RpbWVsaW5lX25hbWUoZmVuY2UpLAotCQkJCSAgIGRtYV9mZW5jZV9pc19zaWduYWxl
ZChmZW5jZSkgPyAiIiA6ICJ1biIpOwotCQl9CisJCWRtYV9yZXN2X2Rlc2NyaWJlKGJ1Zl9vYmot
PnJlc3YsIHMpOwogCiAJCXNlcV9wdXRzKHMsICJcdEF0dGFjaGVkIERldmljZXM6XG4iKTsKIAkJ
YXR0YWNoX2NvdW50ID0gMDsKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtZmVuY2Uu
YyBiL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtZmVuY2UuYwppbmRleCAxZTgyZWNkNDQzZmEuLjUxNzVh
ZGY1ODY0NCAxMDA2NDQKLS0tIGEvZHJpdmVycy9kbWEtYnVmL2RtYS1mZW5jZS5jCisrKyBiL2Ry
aXZlcnMvZG1hLWJ1Zi9kbWEtZmVuY2UuYwpAQCAtOTA3LDYgKzkwNywyMiBAQCBkbWFfZmVuY2Vf
d2FpdF9hbnlfdGltZW91dChzdHJ1Y3QgZG1hX2ZlbmNlICoqZmVuY2VzLCB1aW50MzJfdCBjb3Vu
dCwKIH0KIEVYUE9SVF9TWU1CT0woZG1hX2ZlbmNlX3dhaXRfYW55X3RpbWVvdXQpOwogCisvKioK
KyAqIGRtYV9mZW5jZV9kZXNjcmliZSAtIER1bXAgZmVuY2UgZGVzY3JpYnRpb24gaW50byBzZXFf
ZmlsZQorICogQGZlbmNlOiB0aGUgNmZlbmNlIHRvIGRlc2NyaWJlCisgKiBAc2VxOiB0aGUgc2Vx
X2ZpbGUgdG8gcHV0IHRoZSB0ZXh0dWFsIGRlc2NyaXB0aW9uIGludG8KKyAqCisgKiBEdW1wIGEg
dGV4dHVhbCBkZXNjcmlwdGlvbiBvZiB0aGUgZmVuY2UgYW5kIGl0J3Mgc3RhdGUgaW50byB0aGUg
c2VxX2ZpbGUuCisgKi8KK3ZvaWQgZG1hX2ZlbmNlX2Rlc2NyaWJlKHN0cnVjdCBkbWFfZmVuY2Ug
KmZlbmNlLCBzdHJ1Y3Qgc2VxX2ZpbGUgKnNlcSkKK3sKKwlzZXFfcHJpbnRmKHNlcSwgIiVzICVz
IHNlcSAlbGx1ICVzc2lnbmFsbGVkXG4iLAorCQkgICBmZW5jZS0+b3BzLT5nZXRfZHJpdmVyX25h
bWUoZmVuY2UpLAorCQkgICBmZW5jZS0+b3BzLT5nZXRfdGltZWxpbmVfbmFtZShmZW5jZSksIGZl
bmNlLT5zZXFubywKKwkJICAgZG1hX2ZlbmNlX2lzX3NpZ25hbGVkKGZlbmNlKSA/ICIiIDogInVu
Iik7Cit9CitFWFBPUlRfU1lNQk9MKGRtYV9mZW5jZV9kZXNjcmliZSk7CisKIC8qKgogICogZG1h
X2ZlbmNlX2luaXQgLSBJbml0aWFsaXplIGEgY3VzdG9tIGZlbmNlLgogICogQGZlbmNlOiB0aGUg
ZmVuY2UgdG8gaW5pdGlhbGl6ZQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9kbWEtYnVmL2RtYS1yZXN2
LmMgYi9kcml2ZXJzL2RtYS1idWYvZG1hLXJlc3YuYwppbmRleCA5ZWIyYmFhMzg3ZDQuLmZmM2Mw
NTU4YjNiOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9kbWEtYnVmL2RtYS1yZXN2LmMKKysrIGIvZHJp
dmVycy9kbWEtYnVmL2RtYS1yZXN2LmMKQEAgLTM4LDYgKzM4LDcgQEAKICNpbmNsdWRlIDxsaW51
eC9tbS5oPgogI2luY2x1ZGUgPGxpbnV4L3NjaGVkL21tLmg+CiAjaW5jbHVkZSA8bGludXgvbW11
X25vdGlmaWVyLmg+CisjaW5jbHVkZSA8bGludXgvc2VxX2ZpbGUuaD4KIAogLyoqCiAgKiBET0M6
IFJlc2VydmF0aW9uIE9iamVjdCBPdmVydmlldwpAQCAtNjY2LDYgKzY2NywyOCBAQCBib29sIGRt
YV9yZXN2X3Rlc3Rfc2lnbmFsZWQoc3RydWN0IGRtYV9yZXN2ICpvYmosIGJvb2wgdGVzdF9hbGwp
CiB9CiBFWFBPUlRfU1lNQk9MX0dQTChkbWFfcmVzdl90ZXN0X3NpZ25hbGVkKTsKIAorLyoqCisg
KiBkbWFfcmVzdl9kZXNjcmliZSAtIER1bXAgZGVzY3JpcHRpb24gb2YgdGhlIHJlc3Ygb2JqZWN0
IGludG8gc2VxX2ZpbGUKKyAqIEBvYmo6IHRoZSByZXNlcnZhdGlvbiBvYmplY3QKKyAqIEBzZXE6
IHRoZSBzZXFfZmlsZSB0byBkdW1wIHRoZSBkZXNjcmlwdGlvbiBpbnRvCisgKgorICogRHVtcCBh
IHRleHR1YWwgZGVzY3JpcHRpb24gb2YgdGhlIGZlbmNlcyBpbnNpZGUgYW4gZG1hX3Jlc3Ygb2Jq
ZWN0IGludG8gdGhlCisgKiBzZXFfZmlsZS4KKyAqLwordm9pZCBkbWFfcmVzdl9kZXNjcmliZShz
dHJ1Y3QgZG1hX3Jlc3YgKm9iaiwgc3RydWN0IHNlcV9maWxlICpzZXEpCit7CisJc3RydWN0IGRt
YV9yZXN2X2l0ZXIgY3Vyc29yOworCXN0cnVjdCBkbWFfZmVuY2UgKmZlbmNlOworCisJZG1hX3Jl
c3ZfZm9yX2VhY2hfZmVuY2UoJmN1cnNvciwgb2JqLCB0cnVlLCBmZW5jZSkgeworCQlzZXFfcHJp
bnRmKHNlcSwgIlx0JXMgZmVuY2U6IiwKKwkJCSAgIGRtYV9yZXN2X2l0ZXJfaXNfZXhjbHVzaXZl
KCZjdXJzb3IpID8KKwkJCQkiRXhjbHVzaXZlIiA6ICJTaGFyZWQiKTsKKwkJZG1hX2ZlbmNlX2Rl
c2NyaWJlKGZlbmNlLCBzZXEpOworCX0KK30KK0VYUE9SVF9TWU1CT0xfR1BMKGRtYV9yZXN2X2Rl
c2NyaWJlKTsKKwogI2lmIElTX0VOQUJMRUQoQ09ORklHX0xPQ0tERVApCiBzdGF0aWMgaW50IF9f
aW5pdCBkbWFfcmVzdl9sb2NrZGVwKHZvaWQpCiB7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L2RtYS1mZW5jZS5oIGIvaW5jbHVkZS9saW51eC9kbWEtZmVuY2UuaAppbmRleCBhNzA2YjdiZjUx
ZDcuLjFlYTY5MTc1M2JkMyAxMDA2NDQKLS0tIGEvaW5jbHVkZS9saW51eC9kbWEtZmVuY2UuaAor
KysgYi9pbmNsdWRlL2xpbnV4L2RtYS1mZW5jZS5oCkBAIC0yNjQsNiArMjY0LDcgQEAgdm9pZCBk
bWFfZmVuY2VfaW5pdChzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZSwgY29uc3Qgc3RydWN0IGRtYV9m
ZW5jZV9vcHMgKm9wcywKIAogdm9pZCBkbWFfZmVuY2VfcmVsZWFzZShzdHJ1Y3Qga3JlZiAqa3Jl
Zik7CiB2b2lkIGRtYV9mZW5jZV9mcmVlKHN0cnVjdCBkbWFfZmVuY2UgKmZlbmNlKTsKK3ZvaWQg
ZG1hX2ZlbmNlX2Rlc2NyaWJlKHN0cnVjdCBkbWFfZmVuY2UgKmZlbmNlLCBzdHJ1Y3Qgc2VxX2Zp
bGUgKnNlcSk7CiAKIC8qKgogICogZG1hX2ZlbmNlX3B1dCAtIGRlY3JlYXNlcyByZWZjb3VudCBv
ZiB0aGUgZmVuY2UKZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZG1hLXJlc3YuaCBiL2luY2x1
ZGUvbGludXgvZG1hLXJlc3YuaAppbmRleCBkYmQyMzVhYjQ0N2YuLjA5YzYwNjNiMTk5YSAxMDA2
NDQKLS0tIGEvaW5jbHVkZS9saW51eC9kbWEtcmVzdi5oCisrKyBiL2luY2x1ZGUvbGludXgvZG1h
LXJlc3YuaApAQCAtNDkwLDUgKzQ5MCw2IEBAIGludCBkbWFfcmVzdl9jb3B5X2ZlbmNlcyhzdHJ1
Y3QgZG1hX3Jlc3YgKmRzdCwgc3RydWN0IGRtYV9yZXN2ICpzcmMpOwogbG9uZyBkbWFfcmVzdl93
YWl0X3RpbWVvdXQoc3RydWN0IGRtYV9yZXN2ICpvYmosIGJvb2wgd2FpdF9hbGwsIGJvb2wgaW50
ciwKIAkJCSAgIHVuc2lnbmVkIGxvbmcgdGltZW91dCk7CiBib29sIGRtYV9yZXN2X3Rlc3Rfc2ln
bmFsZWQoc3RydWN0IGRtYV9yZXN2ICpvYmosIGJvb2wgdGVzdF9hbGwpOwordm9pZCBkbWFfcmVz
dl9kZXNjcmliZShzdHJ1Y3QgZG1hX3Jlc3YgKm9iaiwgc3RydWN0IHNlcV9maWxlICpzZXEpOwog
CiAjZW5kaWYgLyogX0xJTlVYX1JFU0VSVkFUSU9OX0ggKi8KLS0gCjIuMjUuMQoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
