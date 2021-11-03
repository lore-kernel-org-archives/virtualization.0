Return-Path: <SRS0=Oeu7=PW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3F142C4167B
	for <virtualization@archiver.kernel.org>; Wed,  3 Nov 2021 08:12:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E68E661175
	for <virtualization@archiver.kernel.org>; Wed,  3 Nov 2021 08:12:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org E68E661175
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B51AA80E83;
	Wed,  3 Nov 2021 08:12:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ctxg-b32tbuk; Wed,  3 Nov 2021 08:12:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 21A0380E9E;
	Wed,  3 Nov 2021 08:12:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E0A85C0019;
	Wed,  3 Nov 2021 08:12:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 48296C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 08:12:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 44CF580E83
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 08:12:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IhSuSEoFiGIl
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 08:12:37 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com
 [IPv6:2a00:1450:4864:20::436])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5054080E81
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Nov 2021 08:12:37 +0000 (UTC)
Received: by mail-wr1-x436.google.com with SMTP id t30so2203449wra.10
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Nov 2021 01:12:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6PkQ3oa1hrBIqSDtBCmc6g6vqm5e94FteFPaTzIHs+w=;
 b=dWxWDB/8hZjRDwFH55CGQDjWRInNWUTrjuXsNpn+6pbhiqoBhwwMigWZl6VsOYVYWZ
 aCW05F4gQbuuKWGtMtN+ddEvE83NsxQ0JTzBMudf2nbnrVrBND4RMqoYOKD0GdRKor2q
 pLYo/in+LnzMmMdcMp9/HjhrbZDHRRlPN/GEaunL38Gb4ZsJyZ26I1cxF8MwznPUq5XF
 hmeann7cnf/nB/mh5i5m28AHGYxB3gis2/vPHUHCgcoH4mcFL5VE9avnIjoccNHJllk6
 D/ksxdqAT9lPYr4tUNyAW2U8GSYTHDE4G7WpTM0PjRC7yrTBzWbXhdlo1pN4c8iB1sPt
 0KVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6PkQ3oa1hrBIqSDtBCmc6g6vqm5e94FteFPaTzIHs+w=;
 b=vBKgaEJ/9mdkmu00fd8xFgbwcbwYuMKqHM0e+z++IGRcQKlQ03O0y/hfDXKrHr56MO
 pBiY6DosrndKEAy1Rwgo7tvNA00xQBgMVPi3eU0NH/R/dJwYtYgGK3w5WQbCySSMu2f3
 MAspzDl9g95JG2bzvka/9Y4FFLp5UpCKVgsjniDy2U6RfuJF2Q9utiaDrdfptIaK3xmu
 WMaokYrLFCtaL/jSe6ZonHKX9LusAK4G01XXq1dVmAkJnrwvKC5IlSrNL+4I0VDeWOcX
 ZNVJbm2+7PiHBn741bDPkM/+UmQJ9h479jwTJiywRnrNO+0CNeY2TM/xpLkAoPN/V7Xl
 dAWg==
X-Gm-Message-State: AOAM530//anWEoeDFIWv7aVXbJEaTg80Yr0C1r8gFkyVmQOdJ3ZrsvwW
 JeDeEuh7wIBTuvPjotXVqy4=
X-Google-Smtp-Source: ABdhPJygSaNIkxB6dcQmxoYV0rxENHtn4TJzZeO3ZXaNhGUPxjyjmtmjD0mED986omYbswxSqqp4kg==
X-Received: by 2002:adf:fe8b:: with SMTP id l11mr51604325wrr.228.1635927155632; 
 Wed, 03 Nov 2021 01:12:35 -0700 (PDT)
Received: from abel.fritz.box (p5b0ea1b5.dip0.t-ipconnect.de. [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id
 l7sm1450088wry.86.2021.11.03.01.12.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 03 Nov 2021 01:12:35 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: linux-media@vger.kernel.org, etnaviv@lists.freedesktop.org,
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org,
 spice-devel@lists.freedesktop.org
Subject: [PATCH 1/4] dma-buf: add dma_fence_describe and dma_resv_describe v2
Date: Wed,  3 Nov 2021 09:12:28 +0100
Message-Id: <20211103081231.18578-2-christian.koenig@amd.com>
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

QWRkIGZ1bmN0aW9ucyB0byBkdW1wIGRtYV9mZW5jZSBhbmQgZG1hX3Jlc3Ygb2JqZWN0cyBpbnRv
IGEgc2VxX2ZpbGUgYW5kCnVzZSB0aGVtIGZvciBwcmludGluZyB0aGUgZGVidWdmcyBpbmZvcm1h
dGlvbi4KCnYyOiBmaXggbWlzc2luZyBpbmNsdWRlIHJlcG9ydGVkIGJ5IHRlc3Qgcm9ib3QuCgpT
aWduZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+
ClJldmlld2VkLWJ5OiBSb2IgQ2xhcmsgPHJvYmRjbGFya0BnbWFpbC5jb20+Ci0tLQogZHJpdmVy
cy9kbWEtYnVmL2RtYS1idWYuYyAgIHwgMTEgKy0tLS0tLS0tLS0KIGRyaXZlcnMvZG1hLWJ1Zi9k
bWEtZmVuY2UuYyB8IDE3ICsrKysrKysrKysrKysrKysrCiBkcml2ZXJzL2RtYS1idWYvZG1hLXJl
c3YuYyAgfCAyMyArKysrKysrKysrKysrKysrKysrKysrKwogaW5jbHVkZS9saW51eC9kbWEtZmVu
Y2UuaCAgIHwgIDEgKwogaW5jbHVkZS9saW51eC9kbWEtcmVzdi5oICAgIHwgIDEgKwogNSBmaWxl
cyBjaGFuZ2VkLCA0MyBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2RtYS1idWYvZG1hLWJ1Zi5jIGIvZHJpdmVycy9kbWEtYnVmL2RtYS1idWYuYwpp
bmRleCAzZjYzZDU4YmY2OGEuLjM4NWNkMDM3MzI1ZSAxMDA2NDQKLS0tIGEvZHJpdmVycy9kbWEt
YnVmL2RtYS1idWYuYworKysgYi9kcml2ZXJzL2RtYS1idWYvZG1hLWJ1Zi5jCkBAIC0xMzIxLDgg
KzEzMjEsNiBAQCBzdGF0aWMgaW50IGRtYV9idWZfZGVidWdfc2hvdyhzdHJ1Y3Qgc2VxX2ZpbGUg
KnMsIHZvaWQgKnVudXNlZCkKIHsKIAlzdHJ1Y3QgZG1hX2J1ZiAqYnVmX29iajsKIAlzdHJ1Y3Qg
ZG1hX2J1Zl9hdHRhY2htZW50ICphdHRhY2hfb2JqOwotCXN0cnVjdCBkbWFfcmVzdl9pdGVyIGN1
cnNvcjsKLQlzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZTsKIAlpbnQgY291bnQgPSAwLCBhdHRhY2hf
Y291bnQ7CiAJc2l6ZV90IHNpemUgPSAwOwogCWludCByZXQ7CkBAIC0xMzUwLDE0ICsxMzQ4LDcg
QEAgc3RhdGljIGludCBkbWFfYnVmX2RlYnVnX3Nob3coc3RydWN0IHNlcV9maWxlICpzLCB2b2lk
ICp1bnVzZWQpCiAJCQkJZmlsZV9pbm9kZShidWZfb2JqLT5maWxlKS0+aV9pbm8sCiAJCQkJYnVm
X29iai0+bmFtZSA/OiAiIik7CiAKLQkJZG1hX3Jlc3ZfZm9yX2VhY2hfZmVuY2UoJmN1cnNvciwg
YnVmX29iai0+cmVzdiwgdHJ1ZSwgZmVuY2UpIHsKLQkJCXNlcV9wcmludGYocywgIlx0JXMgZmVu
Y2U6ICVzICVzICVzc2lnbmFsbGVkXG4iLAotCQkJCSAgIGRtYV9yZXN2X2l0ZXJfaXNfZXhjbHVz
aXZlKCZjdXJzb3IpID8KLQkJCQkJIkV4Y2x1c2l2ZSIgOiAiU2hhcmVkIiwKLQkJCQkgICBmZW5j
ZS0+b3BzLT5nZXRfZHJpdmVyX25hbWUoZmVuY2UpLAotCQkJCSAgIGZlbmNlLT5vcHMtPmdldF90
aW1lbGluZV9uYW1lKGZlbmNlKSwKLQkJCQkgICBkbWFfZmVuY2VfaXNfc2lnbmFsZWQoZmVuY2Up
ID8gIiIgOiAidW4iKTsKLQkJfQorCQlkbWFfcmVzdl9kZXNjcmliZShidWZfb2JqLT5yZXN2LCBz
KTsKIAogCQlzZXFfcHV0cyhzLCAiXHRBdHRhY2hlZCBEZXZpY2VzOlxuIik7CiAJCWF0dGFjaF9j
b3VudCA9IDA7CmRpZmYgLS1naXQgYS9kcml2ZXJzL2RtYS1idWYvZG1hLWZlbmNlLmMgYi9kcml2
ZXJzL2RtYS1idWYvZG1hLWZlbmNlLmMKaW5kZXggMWU4MmVjZDQ0M2ZhLi4wNjY0MDBlZDg4NDEg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtZmVuY2UuYworKysgYi9kcml2ZXJzL2Rt
YS1idWYvZG1hLWZlbmNlLmMKQEAgLTE1LDYgKzE1LDcgQEAKICNpbmNsdWRlIDxsaW51eC9hdG9t
aWMuaD4KICNpbmNsdWRlIDxsaW51eC9kbWEtZmVuY2UuaD4KICNpbmNsdWRlIDxsaW51eC9zY2hl
ZC9zaWduYWwuaD4KKyNpbmNsdWRlIDxsaW51eC9zZXFfZmlsZS5oPgogCiAjZGVmaW5lIENSRUFU
RV9UUkFDRV9QT0lOVFMKICNpbmNsdWRlIDx0cmFjZS9ldmVudHMvZG1hX2ZlbmNlLmg+CkBAIC05
MDcsNiArOTA4LDIyIEBAIGRtYV9mZW5jZV93YWl0X2FueV90aW1lb3V0KHN0cnVjdCBkbWFfZmVu
Y2UgKipmZW5jZXMsIHVpbnQzMl90IGNvdW50LAogfQogRVhQT1JUX1NZTUJPTChkbWFfZmVuY2Vf
d2FpdF9hbnlfdGltZW91dCk7CiAKKy8qKgorICogZG1hX2ZlbmNlX2Rlc2NyaWJlIC0gRHVtcCBm
ZW5jZSBkZXNjcmlidGlvbiBpbnRvIHNlcV9maWxlCisgKiBAZmVuY2U6IHRoZSA2ZmVuY2UgdG8g
ZGVzY3JpYmUKKyAqIEBzZXE6IHRoZSBzZXFfZmlsZSB0byBwdXQgdGhlIHRleHR1YWwgZGVzY3Jp
cHRpb24gaW50bworICoKKyAqIER1bXAgYSB0ZXh0dWFsIGRlc2NyaXB0aW9uIG9mIHRoZSBmZW5j
ZSBhbmQgaXQncyBzdGF0ZSBpbnRvIHRoZSBzZXFfZmlsZS4KKyAqLwordm9pZCBkbWFfZmVuY2Vf
ZGVzY3JpYmUoc3RydWN0IGRtYV9mZW5jZSAqZmVuY2UsIHN0cnVjdCBzZXFfZmlsZSAqc2VxKQor
eworCXNlcV9wcmludGYoc2VxLCAiJXMgJXMgc2VxICVsbHUgJXNzaWduYWxsZWRcbiIsCisJCSAg
IGZlbmNlLT5vcHMtPmdldF9kcml2ZXJfbmFtZShmZW5jZSksCisJCSAgIGZlbmNlLT5vcHMtPmdl
dF90aW1lbGluZV9uYW1lKGZlbmNlKSwgZmVuY2UtPnNlcW5vLAorCQkgICBkbWFfZmVuY2VfaXNf
c2lnbmFsZWQoZmVuY2UpID8gIiIgOiAidW4iKTsKK30KK0VYUE9SVF9TWU1CT0woZG1hX2ZlbmNl
X2Rlc2NyaWJlKTsKKwogLyoqCiAgKiBkbWFfZmVuY2VfaW5pdCAtIEluaXRpYWxpemUgYSBjdXN0
b20gZmVuY2UuCiAgKiBAZmVuY2U6IHRoZSBmZW5jZSB0byBpbml0aWFsaXplCmRpZmYgLS1naXQg
YS9kcml2ZXJzL2RtYS1idWYvZG1hLXJlc3YuYyBiL2RyaXZlcnMvZG1hLWJ1Zi9kbWEtcmVzdi5j
CmluZGV4IDllYjJiYWEzODdkNC4uZmYzYzA1NThiM2I4IDEwMDY0NAotLS0gYS9kcml2ZXJzL2Rt
YS1idWYvZG1hLXJlc3YuYworKysgYi9kcml2ZXJzL2RtYS1idWYvZG1hLXJlc3YuYwpAQCAtMzgs
NiArMzgsNyBAQAogI2luY2x1ZGUgPGxpbnV4L21tLmg+CiAjaW5jbHVkZSA8bGludXgvc2NoZWQv
bW0uaD4KICNpbmNsdWRlIDxsaW51eC9tbXVfbm90aWZpZXIuaD4KKyNpbmNsdWRlIDxsaW51eC9z
ZXFfZmlsZS5oPgogCiAvKioKICAqIERPQzogUmVzZXJ2YXRpb24gT2JqZWN0IE92ZXJ2aWV3CkBA
IC02NjYsNiArNjY3LDI4IEBAIGJvb2wgZG1hX3Jlc3ZfdGVzdF9zaWduYWxlZChzdHJ1Y3QgZG1h
X3Jlc3YgKm9iaiwgYm9vbCB0ZXN0X2FsbCkKIH0KIEVYUE9SVF9TWU1CT0xfR1BMKGRtYV9yZXN2
X3Rlc3Rfc2lnbmFsZWQpOwogCisvKioKKyAqIGRtYV9yZXN2X2Rlc2NyaWJlIC0gRHVtcCBkZXNj
cmlwdGlvbiBvZiB0aGUgcmVzdiBvYmplY3QgaW50byBzZXFfZmlsZQorICogQG9iajogdGhlIHJl
c2VydmF0aW9uIG9iamVjdAorICogQHNlcTogdGhlIHNlcV9maWxlIHRvIGR1bXAgdGhlIGRlc2Ny
aXB0aW9uIGludG8KKyAqCisgKiBEdW1wIGEgdGV4dHVhbCBkZXNjcmlwdGlvbiBvZiB0aGUgZmVu
Y2VzIGluc2lkZSBhbiBkbWFfcmVzdiBvYmplY3QgaW50byB0aGUKKyAqIHNlcV9maWxlLgorICov
Cit2b2lkIGRtYV9yZXN2X2Rlc2NyaWJlKHN0cnVjdCBkbWFfcmVzdiAqb2JqLCBzdHJ1Y3Qgc2Vx
X2ZpbGUgKnNlcSkKK3sKKwlzdHJ1Y3QgZG1hX3Jlc3ZfaXRlciBjdXJzb3I7CisJc3RydWN0IGRt
YV9mZW5jZSAqZmVuY2U7CisKKwlkbWFfcmVzdl9mb3JfZWFjaF9mZW5jZSgmY3Vyc29yLCBvYmos
IHRydWUsIGZlbmNlKSB7CisJCXNlcV9wcmludGYoc2VxLCAiXHQlcyBmZW5jZToiLAorCQkJICAg
ZG1hX3Jlc3ZfaXRlcl9pc19leGNsdXNpdmUoJmN1cnNvcikgPworCQkJCSJFeGNsdXNpdmUiIDog
IlNoYXJlZCIpOworCQlkbWFfZmVuY2VfZGVzY3JpYmUoZmVuY2UsIHNlcSk7CisJfQorfQorRVhQ
T1JUX1NZTUJPTF9HUEwoZG1hX3Jlc3ZfZGVzY3JpYmUpOworCiAjaWYgSVNfRU5BQkxFRChDT05G
SUdfTE9DS0RFUCkKIHN0YXRpYyBpbnQgX19pbml0IGRtYV9yZXN2X2xvY2tkZXAodm9pZCkKIHsK
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvZG1hLWZlbmNlLmggYi9pbmNsdWRlL2xpbnV4L2Rt
YS1mZW5jZS5oCmluZGV4IGE3MDZiN2JmNTFkNy4uMWVhNjkxNzUzYmQzIDEwMDY0NAotLS0gYS9p
bmNsdWRlL2xpbnV4L2RtYS1mZW5jZS5oCisrKyBiL2luY2x1ZGUvbGludXgvZG1hLWZlbmNlLmgK
QEAgLTI2NCw2ICsyNjQsNyBAQCB2b2lkIGRtYV9mZW5jZV9pbml0KHN0cnVjdCBkbWFfZmVuY2Ug
KmZlbmNlLCBjb25zdCBzdHJ1Y3QgZG1hX2ZlbmNlX29wcyAqb3BzLAogCiB2b2lkIGRtYV9mZW5j
ZV9yZWxlYXNlKHN0cnVjdCBrcmVmICprcmVmKTsKIHZvaWQgZG1hX2ZlbmNlX2ZyZWUoc3RydWN0
IGRtYV9mZW5jZSAqZmVuY2UpOwordm9pZCBkbWFfZmVuY2VfZGVzY3JpYmUoc3RydWN0IGRtYV9m
ZW5jZSAqZmVuY2UsIHN0cnVjdCBzZXFfZmlsZSAqc2VxKTsKIAogLyoqCiAgKiBkbWFfZmVuY2Vf
cHV0IC0gZGVjcmVhc2VzIHJlZmNvdW50IG9mIHRoZSBmZW5jZQpkaWZmIC0tZ2l0IGEvaW5jbHVk
ZS9saW51eC9kbWEtcmVzdi5oIGIvaW5jbHVkZS9saW51eC9kbWEtcmVzdi5oCmluZGV4IGRiZDIz
NWFiNDQ3Zi4uMDljNjA2M2IxOTlhIDEwMDY0NAotLS0gYS9pbmNsdWRlL2xpbnV4L2RtYS1yZXN2
LmgKKysrIGIvaW5jbHVkZS9saW51eC9kbWEtcmVzdi5oCkBAIC00OTAsNSArNDkwLDYgQEAgaW50
IGRtYV9yZXN2X2NvcHlfZmVuY2VzKHN0cnVjdCBkbWFfcmVzdiAqZHN0LCBzdHJ1Y3QgZG1hX3Jl
c3YgKnNyYyk7CiBsb25nIGRtYV9yZXN2X3dhaXRfdGltZW91dChzdHJ1Y3QgZG1hX3Jlc3YgKm9i
aiwgYm9vbCB3YWl0X2FsbCwgYm9vbCBpbnRyLAogCQkJICAgdW5zaWduZWQgbG9uZyB0aW1lb3V0
KTsKIGJvb2wgZG1hX3Jlc3ZfdGVzdF9zaWduYWxlZChzdHJ1Y3QgZG1hX3Jlc3YgKm9iaiwgYm9v
bCB0ZXN0X2FsbCk7Cit2b2lkIGRtYV9yZXN2X2Rlc2NyaWJlKHN0cnVjdCBkbWFfcmVzdiAqb2Jq
LCBzdHJ1Y3Qgc2VxX2ZpbGUgKnNlcSk7CiAKICNlbmRpZiAvKiBfTElOVVhfUkVTRVJWQVRJT05f
SCAqLwotLSAKMi4yNS4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
