Return-Path: <SRS0=jbvZ=DC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6AB1BC4363D
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 12:52:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0210A22B2D
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 12:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eb6ALVdn"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0210A22B2D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 1BBD22E174;
	Fri, 25 Sep 2020 12:52:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id toGw1R8tH0qq; Fri, 25 Sep 2020 12:52:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id A091620499;
	Fri, 25 Sep 2020 12:52:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FE5DC0859;
	Fri, 25 Sep 2020 12:52:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32F75C0859
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:52:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2F4D78750D
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:52:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KGo-JKqvUrSO
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:52:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f66.google.com (mail-wr1-f66.google.com
 [209.85.221.66])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 46BF587143
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:52:09 +0000 (UTC)
Received: by mail-wr1-f66.google.com with SMTP id k15so3447927wrn.10
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 05:52:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9eI5ySrz2OiQLFHfiZ2ocnjA2ayiRqTZ1gQtwjJhv6Q=;
 b=eb6ALVdnmFHCTlliFN8w9QQPFweSJ6Di6etcFIdumY21j+3VWYHbhdRz7orrZd4HNW
 BC4nCBlDbhKhp6XnTOh2XkBcX/rpHXp3DeYZ34PeLz4kqPPrY/F5SNXgz7NrQCyoBNGy
 KNB1ehCec9b7w+DJrxTUXT2jfRP2isSynh5wWCGH7z+PirCFWe6mkr56BuMx3N/o4LaE
 PNOprC+3WFDvrcMxerUHXbCs0Sb7JsONYWNzLbecNDWZuHuTaveLGuI7HmFLAXC2FOxF
 DmT1faygi6/tecLZE2OKcL89BFE2X2kCsFiu3TRkNllSt59innjb3U6sG8Sy3jpE5FZQ
 EulQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9eI5ySrz2OiQLFHfiZ2ocnjA2ayiRqTZ1gQtwjJhv6Q=;
 b=oL6rJw6eh/dhVRQdTSs0tG40utj4Z8VqTEYSnzbpZ6LR5jp3dF+xAJqH3lBZwJ17bL
 N34ZBiGVZELB1RjUNsee8imN1g2fEmuU/tuS8nqsUr7PRQ7M+/lwJC9kWV0HIhD5Qoap
 QhBpGAfIksdQ0M4AvoCf6JlL6b7LoKovGLy8ULmnrt0YBg4O1jlD7+HpRAt88cD5ERpP
 7xnn/slL9gYYS2sa9Ps5tFFo5uRcKdomS6r2/Xus2YBzsA4LsONITKJC8o2rBJCCo5WT
 9stElL+tnHyw6FoGDYkyEOu+XhXOtkaotMwYp0wk/Ik4XKRSGlzjeeTXCi5MLJrDSNN2
 L8NQ==
X-Gm-Message-State: AOAM5335CXd87TzkQHD0nZ1H3QBe38Gq11X1/wVKfCAEA84ya9h4wt1k
 +PewZuu21x9E49pRTJk9i1LrUg==
X-Google-Smtp-Source: ABdhPJwrBoyZaa9ySYnxA8u48SmELYctXq1T0Fdj46EQTS15QzgJZGB+uHCKPTfkdtsZGNMxEX84TA==
X-Received: by 2002:a05:6000:7:: with SMTP id h7mr4620923wrx.16.1601038327710; 
 Fri, 25 Sep 2020 05:52:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id v9sm3129761wrv.35.2020.09.25.05.51.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:52:00 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 41FCB1FF9A;
 Fri, 25 Sep 2020 13:51:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH 11/19] tools/vhost-user-rpmb: add --flash-path for backing
 store
Date: Fri, 25 Sep 2020 13:51:39 +0100
Message-Id: <20200925125147.26943-12-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925125147.26943-1-alex.bennee@linaro.org>
References: <20200925125147.26943-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Cc: jean-philippe@linaro.org, takahiro.akashi@linaro.org,
 virtualization@lists.linuxfoundation.org, arnd@linaro.org,
 stratos-dev@op-lists.linaro.org
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

V2Ugd2lsbCBuZWVkIHRvIHN0b3JlIHRoZSBkYXRhIHNvbWV3aGVyZSBzbyBhZGQgdGhlIG9wdGlv
biB0byBwb2ludCB0bwp0aGUgZmlsZSB3aGVyZSB3ZSB3aWxsIGtlZXAgdGhlIGRhdGEuCgpTaWdu
ZWQtb2ZmLWJ5OiBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+Ci0tLQogdG9v
bHMvdmhvc3QtdXNlci1ycG1iL21haW4uYyB8IDU4ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDU3IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKCmRpZmYgLS1naXQgYS90b29scy92aG9zdC11c2VyLXJwbWIvbWFpbi5jIGIvdG9vbHMvdmhv
c3QtdXNlci1ycG1iL21haW4uYwppbmRleCA3YjNiMjljY2ZjNWIuLjY0YmQ3ZTc5ZjU3MyAxMDA2
NDQKLS0tIGEvdG9vbHMvdmhvc3QtdXNlci1ycG1iL21haW4uYworKysgYi90b29scy92aG9zdC11
c2VyLXJwbWIvbWFpbi5jCkBAIC0xMyw5ICsxMywxNSBAQAogI2luY2x1ZGUgPGdpby9naW8uaD4K
ICNpbmNsdWRlIDxnaW8vZ3VuaXhzb2NrZXRhZGRyZXNzLmg+CiAjaW5jbHVkZSA8Z2xpYi11bml4
Lmg+CisjaW5jbHVkZSA8Z2xpYi9nc3RkaW8uaD4KICNpbmNsdWRlIDxzdGRpby5oPgogI2luY2x1
ZGUgPHN0cmluZy5oPgogI2luY2x1ZGUgPGludHR5cGVzLmg+CisjaW5jbHVkZSA8ZmNudGwuaD4K
KyNpbmNsdWRlIDxzeXMvdHlwZXMuaD4KKyNpbmNsdWRlIDxzeXMvc3RhdC5oPgorI2luY2x1ZGUg
PHN5cy9tbWFuLmg+CisjaW5jbHVkZSA8dW5pc3RkLmg+CiAKICNpbmNsdWRlICJjb250cmliL2xp
YnZob3N0LXVzZXIvbGlidmhvc3QtdXNlci1nbGliLmgiCiAjaW5jbHVkZSAiY29udHJpYi9saWJ2
aG9zdC11c2VyL2xpYnZob3N0LXVzZXIuaCIKQEAgLTI3LDYgKzMzLDcgQEAKICNlbmRpZgogCiBz
dGF0aWMgZ2NoYXIgKnNvY2tldF9wYXRoOworc3RhdGljIGNoYXIgKmZsYXNoX3BhdGg7CiBzdGF0
aWMgZ2ludCBzb2NrZXRfZmQgPSAtMTsKIHN0YXRpYyBnYm9vbGVhbiBwcmludF9jYXA7CiBzdGF0
aWMgZ2Jvb2xlYW4gdmVyYm9zZTsKQEAgLTM1LDYgKzQyLDcgQEAgc3RhdGljIGdib29sZWFuIGRl
YnVnOwogc3RhdGljIEdPcHRpb25FbnRyeSBvcHRpb25zW10gPQogewogICAgIHsgInNvY2tldC1w
YXRoIiwgMCwgMCwgR19PUFRJT05fQVJHX0ZJTEVOQU1FLCAmc29ja2V0X3BhdGgsICJMb2NhdGlv
biBvZiB2aG9zdC11c2VyIFVuaXggZG9tYWluIHNvY2tldCwgaW5jb21wYXRpYmxlIHdpdGggLS1m
ZCIsICJQQVRIIiB9LAorICAgIHsgImZsYXNoLXBhdGgiLCAwLCAwLCBHX09QVElPTl9BUkdfRklM
RU5BTUUsICZmbGFzaF9wYXRoLCAiTG9jYXRpb24gb2YgcmF3IGZsYXNoIGltYWdlIGZpbGUiLCAi
UEFUSCIgfSwKICAgICB7ICJmZCIsIDAsIDAsIEdfT1BUSU9OX0FSR19JTlQsICZzb2NrZXRfZmQs
ICJTcGVjaWZ5IHRoZSBmaWxlLWRlc2NyaXB0b3Igb2YgdGhlIGJhY2tlbmQsIGluY29tcGF0aWJs
ZSB3aXRoIC0tc29ja2V0LXBhdGgiLCAiRkQiIH0sCiAgICAgeyAicHJpbnQtY2FwYWJpbGl0aWVz
IiwgMCwgMCwgR19PUFRJT05fQVJHX05PTkUsICZwcmludF9jYXAsICJPdXRwdXQgdG8gc3Rkb3V0
IHRoZSBiYWNrZW5kIGNhcGFiaWxpdGllcyBpbiBKU09OIGZvcm1hdCBhbmQgZXhpdCIsIE5VTEx9
LAogICAgIHsgInZlcmJvc2UiLCAndicsIDAsIEdfT1BUSU9OX0FSR19OT05FLCAmdmVyYm9zZSwg
IkJlIG1vcmUgdmVyYm9zZSBpbiBvdXRwdXQiLCBOVUxMfSwKQEAgLTQ3LDYgKzU1LDggQEAgZW51
bSB7CiB9OwogCiAvKiBUaGVzZSBzdHJ1Y3R1cmVzIGFyZSBkZWZpbmVkIGluIHRoZSBzcGVjaWZp
Y2F0aW9uICovCisjZGVmaW5lIEtpQiAgICAgKDFVTCA8PCAxMCkKKyNkZWZpbmUgTUFYX1JQTUJf
U0laRSAoS2lCICogMTI4ICogMjU2KQogCiBzdHJ1Y3QgdmlydGlvX3JwbWJfY29uZmlnIHsKICAg
ICB1aW50OF90IGNhcGFjaXR5OwpAQCAtNzUsNiArODUsOCBAQCB0eXBlZGVmIHN0cnVjdCBWdVJw
bWIgewogICAgIFZ1Z0RldiBkZXY7CiAgICAgc3RydWN0IHZpcnRpb19ycG1iX2NvbmZpZyB2aXJ0
aW9fY29uZmlnOwogICAgIEdNYWluTG9vcCAqbG9vcDsKKyAgICBpbnQgZmxhc2hfZmQ7CisgICAg
dm9pZCAqZmxhc2hfbWFwOwogfSBWdVJwbWI7CiAKIHN0cnVjdCB2aXJ0aW9fcnBtYl9jdHJsX2Nv
bW1hbmQgewpAQCAtMTE2LDYgKzEyOCw4IEBAIHZycG1iX2dldF9jb25maWcoVnVEZXYgKmRldiwg
dWludDhfdCAqY29uZmlnLCB1aW50MzJfdCBsZW4pCiAgICAgVnVScG1iICpyID0gY29udGFpbmVy
X29mKGRldiwgVnVScG1iLCBkZXYucGFyZW50KTsKICAgICBnX3JldHVybl92YWxfaWZfZmFpbChs
ZW4gPD0gc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fcnBtYl9jb25maWcpLCAtMSk7CiAgICAgbWVtY3B5
KGNvbmZpZywgJnItPnZpcnRpb19jb25maWcsIGxlbik7CisKKyAgICBnX2luZm8oIiVzOiBkb25l
IiwgX19mdW5jX18pOwogICAgIHJldHVybiAwOwogfQogCkBAIC0xOTIsNiArMjA2LDQxIEBAIHN0
YXRpYyBjb25zdCBWdURldklmYWNlIHZ1aWZhY2UgPSB7CiAgICAgLnNldF9jb25maWcgPSB2cnBt
Yl9zZXRfY29uZmlnLAogfTsKIAorc3RhdGljIGJvb2wgdnJwbWJfbG9hZF9mbGFzaF9pbWFnZShW
dVJwbWIgKnIsIGNoYXIgKmltZ19wYXRoKQoreworICAgIEdTdGF0QnVmIHN0YXRidWY7CisgICAg
c2l6ZV90IG1hcF9zaXplOworCisgICAgaWYgKGdfc3RhdChpbWdfcGF0aCwgJnN0YXRidWYpIDwg
MCkgeworICAgICAgICBnX2Vycm9yKCJjb3VsZG4ndCBzdGF0ICVzIiwgaW1nX3BhdGgpOworICAg
ICAgICByZXR1cm4gZmFsc2U7CisgICAgfQorCisgICAgci0+Zmxhc2hfZmQgPSBnX29wZW4oaW1n
X3BhdGgsIE9fUkRXUiwgMCk7CisgICAgaWYgKHItPmZsYXNoX2ZkIDwgMCkgeworICAgICAgICBn
X2Vycm9yKCJjb3VsZG4ndCBvcGVuICVzICglcykiLCBpbWdfcGF0aCwgc3RyZXJyb3IoZXJybm8p
KTsKKyAgICAgICAgcmV0dXJuIGZhbHNlOworICAgIH0KKworICAgIGlmIChzdGF0YnVmLnN0X3Np
emUgPiBNQVhfUlBNQl9TSVpFKSB7CisgICAgICAgIGdfd2FybmluZygiJXMgbGFyZ2VyIHRoYW4g
bWF4aW11bSBzaXplIHN1cHBvcnRlZCIsIGltZ19wYXRoKTsKKyAgICAgICAgbWFwX3NpemUgPSBN
QVhfUlBNQl9TSVpFOworICAgIH0gZWxzZSB7CisgICAgICAgIG1hcF9zaXplID0gc3RhdGJ1Zi5z
dF9zaXplOworICAgIH0KKyAgICByLT52aXJ0aW9fY29uZmlnLmNhcGFjaXR5ID0gbWFwX3NpemUg
LyAoMTI4ICpLaUIpOworICAgIHItPnZpcnRpb19jb25maWcubWF4X3dyX2NudCA9IDE7CisgICAg
ci0+dmlydGlvX2NvbmZpZy5tYXhfcmRfY250ID0gMTsKKworICAgIHItPmZsYXNoX21hcCA9IG1t
YXAoTlVMTCwgbWFwX3NpemUsIFBST1RfUkVBRCwgTUFQX1NIQVJFRCwgci0+Zmxhc2hfZmQsIDAp
OworICAgIGlmIChyLT5mbGFzaF9tYXAgPT0gTUFQX0ZBSUxFRCkgeworICAgICAgICBnX2Vycm9y
KCJmYWlsZWQgdG8gbW1hcCBmaWxlIik7CisgICAgICAgIHJldHVybiBmYWxzZTsKKyAgICB9CisK
KyAgICByZXR1cm4gdHJ1ZTsKK30KKwogc3RhdGljIHZvaWQgdnJwbWJfZGVzdHJveShWdVJwbWIg
KnIpCiB7CiAgICAgdnVnX2RlaW5pdCgmci0+ZGV2KTsKQEAgLTIxNiw3ICsyNjUsNyBAQCBzdGF0
aWMgZ2Jvb2xlYW4gaGFuZ3VwKGdwb2ludGVyIHVzZXJfZGF0YSkKICAgICByZXR1cm4gdHJ1ZTsK
IH0KIAotaW50IG1haW4gKGludCBhcmdjLCBjaGFyICphcmd2W10pCitpbnQgbWFpbihpbnQgYXJn
YywgY2hhciAqYXJndltdKQogewogICAgIEdFcnJvciAqZXJyb3IgPSBOVUxMOwogICAgIEdPcHRp
b25Db250ZXh0ICpjb250ZXh0OwpAQCAtMjM2LDYgKzI4NSwxMyBAQCBpbnQgbWFpbiAoaW50IGFy
Z2MsIGNoYXIgKmFyZ3ZbXSkKICAgICAgICAgZXhpdCgwKTsKICAgICB9CiAKKyAgICBpZiAoIWZs
YXNoX3BhdGggfHwgIWdfZmlsZV90ZXN0KGZsYXNoX3BhdGgsIEdfRklMRV9URVNUX0VYSVNUUykp
IHsKKyAgICAgICAgZ19wcmludGVycigiUGxlYXNlIHNwZWNpZnkgYSB2YWxpZCAtLWZsYXNoLXBh
dGggZm9yIHRoZSBmbGFzaCBpbWFnZVxuIik7CisgICAgICAgIGV4aXQoRVhJVF9GQUlMVVJFKTsK
KyAgICB9IGVsc2UgeworICAgICAgICB2cnBtYl9sb2FkX2ZsYXNoX2ltYWdlKCZycG1iLCBmbGFz
aF9wYXRoKTsKKyAgICB9CisKICAgICBpZiAoIXNvY2tldF9wYXRoICYmIHNvY2tldF9mZCA8IDAp
IHsKICAgICAgICAgZ19wcmludGVycigiUGxlYXNlIHNwZWNpZnkgZWl0aGVyIC0tZmQgb3IgLS1z
b2NrZXQtcGF0aFxuIik7CiAgICAgICAgIGV4aXQoRVhJVF9GQUlMVVJFKTsKLS0gCjIuMjAuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
