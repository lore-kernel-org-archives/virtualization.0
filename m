Return-Path: <SRS0=hVMj=PQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B1E4C433F5
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 08:58:42 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2FD956023D
	for <virtualization@archiver.kernel.org>; Thu, 28 Oct 2021 08:58:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2FD956023D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id D43BB4045D;
	Thu, 28 Oct 2021 08:58:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id l13xBr-sUrNr; Thu, 28 Oct 2021 08:58:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3FCA2402F3;
	Thu, 28 Oct 2021 08:58:40 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17D70C0012;
	Thu, 28 Oct 2021 08:58:40 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A235EC000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 08:58:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 82663405AF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 08:58:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bLfPOjlSbvCw
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 08:58:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com
 [IPv6:2a00:1450:4864:20::335])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C1D2240322
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 08:58:34 +0000 (UTC)
Received: by mail-wm1-x335.google.com with SMTP id v127so5024281wme.5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 28 Oct 2021 01:58:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=6i0TILSChMzKedgIRlQxmjqUOkHsjq/nCVlt/Lvwgi8=;
 b=QygpYOhUkudEJ5eF+BqP+MPdtid8Z5JegqUKDJoG3b4Gzc9Jwd6mGsg1KsEr4hEEU3
 IcGwxgniQNWU5VObJumOOAVCwPXdfrZ4Ldd/00nQ/fikfjzW9ULVfKFzTJDoyIt1otp8
 wNWZ4M+sZP0c5wZJrOzxg4UkHJHSNxLMVCbZrt+tu9DEzQw5J+Ol83c3es73Dwgt90Oq
 bIHGttyt8S1p3gU3dwdqjp9kYAFVzQLWSDMw+ITwnrlq746rG9+DhDAniVG8OS/HCQDH
 CVV+o6S1apv5JRlWf9JW7nXOGkOG8Y2hGKhoqTX3xGD7eeaqiEAcmqFD/H2A5g37zyl5
 iJDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=6i0TILSChMzKedgIRlQxmjqUOkHsjq/nCVlt/Lvwgi8=;
 b=gBW2sDHbODEeaoHeTL/sI9Ixmmq4vQduKsaFg/StFy5ffqAf7Kf4lFON7R7t+HaCrS
 yKjIEy7j0Zcef9AUpr6pNxHcHuQPHz7mFySt4/51+qunHD9MyA9C5G48pLt7M60Meoyx
 Ow8sUUHI/uXt6YJDJuXmjE7mdEqfWttU9yz9tX2j4T27llMM9/tCgkaApfKPHiHZVae1
 5im/pHmKVCR9DPrvHBhsvicYvEpOmU4NyWQ1fm9XH2oBcuqWBlTbnn1ZcRIMh751Cs1s
 IcbWbLrt0TR/Sr6q1Ih2rrgg0PRMUzmBT5i7AbuY6ODNd3IsOPYydg5v1EdPA2PXWAff
 lrBA==
X-Gm-Message-State: AOAM530ppEYIj8GN+85Me4T64LOOx+niIeJuzAWoCAMGQMx0k0TAxSnD
 rczIXPqgscc2d10GH1Lq73A=
X-Google-Smtp-Source: ABdhPJyunwbQl67vWAeCOZxuApaRU12OkPj/DV3QTXOhqgjUkwXU/oANthE3I1spKyH9PmmyBFthJg==
X-Received: by 2002:a1c:e906:: with SMTP id q6mr11139378wmc.126.1635411513115; 
 Thu, 28 Oct 2021 01:58:33 -0700 (PDT)
Received: from abel.fritz.box (p5b0ea1b5.dip0.t-ipconnect.de. [91.14.161.181])
 by smtp.gmail.com with ESMTPSA id
 k22sm2412143wrd.59.2021.10.28.01.58.32
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 Oct 2021 01:58:32 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: dri-devel@lists.freedesktop.org,
	linux-media@vger.kernel.org
Subject: [PATCH 3/4] drm/etnaviv: use dma_resv_describe
Date: Thu, 28 Oct 2021 10:58:28 +0200
Message-Id: <20211028085829.1726-3-christian.koenig@amd.com>
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

SW5zdGVhZCBvZiBkdW1waW5nIHRoZSBmZW5jZSBpbmZvIG1hbnVhbGx5LgoKU2lnbmVkLW9mZi1i
eTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgpSZXZpZXdlZC1i
eTogUm9iIENsYXJrIDxyb2JkY2xhcmtAZ21haWwuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9l
dG5hdml2L2V0bmF2aXZfZ2VtLmMgfCAyNiArKysrKysrLS0tLS0tLS0tLS0tLS0tLS0tLQogMSBm
aWxlIGNoYW5nZWQsIDcgaW5zZXJ0aW9ucygrKSwgMTkgZGVsZXRpb25zKC0pCgpkaWZmIC0tZ2l0
IGEvZHJpdmVycy9ncHUvZHJtL2V0bmF2aXYvZXRuYXZpdl9nZW0uYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9ldG5hdml2L2V0bmF2aXZfZ2VtLmMKaW5kZXggYjAxODY5M2UzODc3Li5kNTMxNGFhMjhmZjcg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9ldG5hdml2L2V0bmF2aXZfZ2VtLmMKKysrIGIv
ZHJpdmVycy9ncHUvZHJtL2V0bmF2aXYvZXRuYXZpdl9nZW0uYwpAQCAtNDI0LDM2ICs0MjQsMjQg
QEAgaW50IGV0bmF2aXZfZ2VtX3dhaXRfYm8oc3RydWN0IGV0bmF2aXZfZ3B1ICpncHUsIHN0cnVj
dCBkcm1fZ2VtX29iamVjdCAqb2JqLAogfQogCiAjaWZkZWYgQ09ORklHX0RFQlVHX0ZTCi1zdGF0
aWMgdm9pZCBldG5hdml2X2dlbV9kZXNjcmliZV9mZW5jZShzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5j
ZSwKLQljb25zdCBjaGFyICp0eXBlLCBzdHJ1Y3Qgc2VxX2ZpbGUgKm0pCi17Ci0Jc2VxX3ByaW50
ZihtLCAiXHQlOXM6ICVzICVzIHNlcSAlbGx1XG4iLCB0eXBlLAotCQkgICBmZW5jZS0+b3BzLT5n
ZXRfZHJpdmVyX25hbWUoZmVuY2UpLAotCQkgICBmZW5jZS0+b3BzLT5nZXRfdGltZWxpbmVfbmFt
ZShmZW5jZSksCi0JCSAgIGZlbmNlLT5zZXFubyk7Ci19Ci0KIHN0YXRpYyB2b2lkIGV0bmF2aXZf
Z2VtX2Rlc2NyaWJlKHN0cnVjdCBkcm1fZ2VtX29iamVjdCAqb2JqLCBzdHJ1Y3Qgc2VxX2ZpbGUg
Km0pCiB7CiAJc3RydWN0IGV0bmF2aXZfZ2VtX29iamVjdCAqZXRuYXZpdl9vYmogPSB0b19ldG5h
dml2X2JvKG9iaik7CiAJc3RydWN0IGRtYV9yZXN2ICpyb2JqID0gb2JqLT5yZXN2OwotCXN0cnVj
dCBkbWFfcmVzdl9pdGVyIGN1cnNvcjsKLQlzdHJ1Y3QgZG1hX2ZlbmNlICpmZW5jZTsKIAl1bnNp
Z25lZCBsb25nIG9mZiA9IGRybV92bWFfbm9kZV9zdGFydCgmb2JqLT52bWFfbm9kZSk7CisJaW50
IHI7CiAKIAlzZXFfcHJpbnRmKG0sICIlMDh4OiAlYyAlMmQgKCUyZCkgJTA4bHggJXAgJXpkXG4i
LAogCQkJZXRuYXZpdl9vYmotPmZsYWdzLCBpc19hY3RpdmUoZXRuYXZpdl9vYmopID8gJ0EnIDog
J0knLAogCQkJb2JqLT5uYW1lLCBrcmVmX3JlYWQoJm9iai0+cmVmY291bnQpLAogCQkJb2ZmLCBl
dG5hdml2X29iai0+dmFkZHIsIG9iai0+c2l6ZSk7CiAKLQlkbWFfcmVzdl9pdGVyX2JlZ2luKCZj
dXJzb3IsIHJvYmosIHRydWUpOwotCWRtYV9yZXN2X2Zvcl9lYWNoX2ZlbmNlX3VubG9ja2VkKCZj
dXJzb3IsIGZlbmNlKSB7Ci0JCWlmIChkbWFfcmVzdl9pdGVyX2lzX2V4Y2x1c2l2ZSgmY3Vyc29y
KSkKLQkJCWV0bmF2aXZfZ2VtX2Rlc2NyaWJlX2ZlbmNlKGZlbmNlLCAiRXhjbHVzaXZlIiwgbSk7
Ci0JCWVsc2UKLQkJCWV0bmF2aXZfZ2VtX2Rlc2NyaWJlX2ZlbmNlKGZlbmNlLCAiU2hhcmVkIiwg
bSk7Ci0JfQotCWRtYV9yZXN2X2l0ZXJfZW5kKCZjdXJzb3IpOworCXIgPSBkbWFfcmVzdl9sb2Nr
KHJvYmosIE5VTEwpOworCWlmIChyKQorCQlyZXR1cm47CisKKwlkbWFfcmVzdl9kZXNjcmliZShy
b2JqLCBtKTsKKwlkbWFfcmVzdl91bmxvY2socm9iaik7CiB9CiAKIHZvaWQgZXRuYXZpdl9nZW1f
ZGVzY3JpYmVfb2JqZWN0cyhzdHJ1Y3QgZXRuYXZpdl9kcm1fcHJpdmF0ZSAqcHJpdiwKLS0gCjIu
MjUuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
