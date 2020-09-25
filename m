Return-Path: <SRS0=jbvZ=DC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A537C4363D
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 12:52:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0128221741
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 12:52:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SgRYZHcF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0128221741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CDE77875C5;
	Fri, 25 Sep 2020 12:52:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ywkFXwyisZ4t; Fri, 25 Sep 2020 12:52:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 151CC87599;
	Fri, 25 Sep 2020 12:52:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0163C0890;
	Fri, 25 Sep 2020 12:52:00 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFBC4C1AD6
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:51:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DAFEC87599
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:51:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2mpPRa9e-Lfh
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:51:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 08C688750D
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:51:58 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id o5so3428698wrn.13
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 05:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qmK72LzpAk+sHPJlMHFLJRJNfxPeFEWb03L+Le08bE4=;
 b=SgRYZHcF/mHGDtqMaPrLM0TYZ4xvkmAnBYe9mEz2RmcztJXqrPMmpSYzj7wQ+6EM+k
 jay8naQYyZIakKg8pCmwg7IMR7/REwAiaWv+57mAuwViVCmZI7kZX2LABNuRTGsKhUJb
 0uHj4sFTab/oGjXCbWlOVulMvO0vGOI1c1KkwHwYVGGs1CpzTQp4yy43A1ydFGsfIIHQ
 J2/SvtegF2jptFk1nfXaABVWoGFr9UoITuVTGBU9wTpoMkbwpiCPL12YRKlOsSwVOjR9
 P1RmA1HPPWwWmf3+WknjmWex3xsp33lqRXlt2IjxCUCSl67xAANBNCdr5cXh01k5471Q
 epdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qmK72LzpAk+sHPJlMHFLJRJNfxPeFEWb03L+Le08bE4=;
 b=TeTZqgg7U+osbF10tsNSe5A+m+IeGHSd8peKo+FnPv9iWY4I0pH5qEBExMM45S/7rT
 F1s4+BPS+r+SEWKkWXD+6mdQDSEkUUOM9rwd7UzeIDMG32/wGaTWcffgOGd/j2y7uWTb
 RbS0zrL0T1idqoaGtxv2t6Jsu/4bUHi82CYMdI9GmWCifs8HNYJ/s1uy94g7Ec/zfxeQ
 luGrTCt2MbuoOWwOSdMo5uHShS/dIX4WvTv1hOSjVYzCoDX4nAm7I0ZP5lICiqMUT5rN
 eFvMUK2ojYlCH5O4coUMNC0Ti3fTO6sZOxMh/I4tRBcoebDPddbrl8Scq8xJSM4RFElT
 KpLQ==
X-Gm-Message-State: AOAM530HWoZoBe5xgYCK/tAXlbFyccMSRLT1jwJxQuRfeh5ExlrtUggR
 arsKEE//GeHXNt0e8712sb22ZQ==
X-Google-Smtp-Source: ABdhPJyVMN0X63SItNReY5JJEsFfyQ3owfll7yNWGpQiY0FQLy7Jdcq4fU/KL11JP3iunvtBLpKjzA==
X-Received: by 2002:adf:e6c2:: with SMTP id y2mr4591930wrm.117.1601038316477; 
 Fri, 25 Sep 2020 05:51:56 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i6sm3021447wra.1.2020.09.25.05.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:51:51 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8D3271FF90;
 Fri, 25 Sep 2020 13:51:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH  04/19] hw/block: add vhost-user-rpmb-pci boilerplate
Date: Fri, 25 Sep 2020 13:51:32 +0100
Message-Id: <20200925125147.26943-5-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925125147.26943-1-alex.bennee@linaro.org>
References: <20200925125147.26943-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Cc: jean-philippe@linaro.org,
 "open list:Block layer core" <qemu-block@nongnu.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Max Reitz <mreitz@redhat.com>,
 takahiro.akashi@linaro.org, virtualization@lists.linuxfoundation.org,
 arnd@linaro.org, stratos-dev@op-lists.linaro.org
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

VGhpcyBhbGxvd3MgaXMgdG8gaW5zdGFudGlhdGUgYSB2aG9zdC11c2VyLXJwbWIgZGV2aWNlIGFz
IHBhcnQgb2YgYQpQQ0kgYnVzLiBJdCBpcyBtb3N0bHkgYm9pbGVycGxhdGUgd2hpY2ggbG9va3Mg
cHJldHR5IHNpbWlsYXIgdG8gdGhlCnZob3N0LXVzZXItZnMtcGNpIGRldmljZSBpZiB5b3Ugc3F1
aW50LgoKU2lnbmVkLW9mZi1ieTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3Jn
PgoKLS0tCiAgLSBlbmFibGUgdXNlIElPRVZFTlRGRCBmbGFnCiAgLSBzd2FwIG9iaiBzZXQgYm9v
bCBhcmdzCi0tLQogaHcvYmxvY2svdmhvc3QtdXNlci1ycG1iLXBjaS5jIHwgODIgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKwogaHcvYmxvY2svbWVzb24uYnVpbGQgICAgICAgICAg
IHwgIDIgKwogMiBmaWxlcyBjaGFuZ2VkLCA4NCBpbnNlcnRpb25zKCspCiBjcmVhdGUgbW9kZSAx
MDA2NDQgaHcvYmxvY2svdmhvc3QtdXNlci1ycG1iLXBjaS5jCgpkaWZmIC0tZ2l0IGEvaHcvYmxv
Y2svdmhvc3QtdXNlci1ycG1iLXBjaS5jIGIvaHcvYmxvY2svdmhvc3QtdXNlci1ycG1iLXBjaS5j
Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uZjA1MTgzMDVhMWQ5Ci0t
LSAvZGV2L251bGwKKysrIGIvaHcvYmxvY2svdmhvc3QtdXNlci1ycG1iLXBjaS5jCkBAIC0wLDAg
KzEsODIgQEAKKy8qCisgKiBWaG9zdC11c2VyIFJQTUIgdmlydGlvIGRldmljZSBQQ0kgZ2x1ZQor
ICoKKyAqIENvcHlyaWdodCAoYykgMjAyMCBMaW5hcm8gTHRkCisgKgorICogU1BEWC1MaWNlbnNl
LUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKKyAqLworCisjaW5jbHVkZSAicWVtdS9vc2Rl
cC5oIgorI2luY2x1ZGUgImh3L3FkZXYtcHJvcGVydGllcy5oIgorI2luY2x1ZGUgImh3L3ZpcnRp
by92aG9zdC11c2VyLXJwbWIuaCIKKyNpbmNsdWRlICJody92aXJ0aW8vdmlydGlvLXBjaS5oIgor
CitzdHJ1Y3QgVkhvc3RVc2VyUlBNQlBDSSB7CisgICAgVmlydElPUENJUHJveHkgcGFyZW50X29i
ajsKKyAgICBWSG9zdFVzZXJSUE1CIHZkZXY7Cit9OworCit0eXBlZGVmIHN0cnVjdCBWSG9zdFVz
ZXJSUE1CUENJIFZIb3N0VXNlclJQTUJQQ0k7CisKKyNkZWZpbmUgVFlQRV9WSE9TVF9VU0VSX1JQ
TUJfUENJICJ2aG9zdC11c2VyLXJwbWItcGNpLWJhc2UiCisKKyNkZWZpbmUgVkhPU1RfVVNFUl9S
UE1CX1BDSShvYmopIFwKKyAgICAgICAgT0JKRUNUX0NIRUNLKFZIb3N0VXNlclJQTUJQQ0ksIChv
YmopLCBUWVBFX1ZIT1NUX1VTRVJfUlBNQl9QQ0kpCisKK3N0YXRpYyBQcm9wZXJ0eSB2dXJwbWJf
cGNpX3Byb3BlcnRpZXNbXSA9IHsKKyAgICBERUZJTkVfUFJPUF9CSVQoImlvZXZlbnRmZCIsIFZp
cnRJT1BDSVByb3h5LCBmbGFncywKKyAgICAgICAgICAgICAgICAgICAgVklSVElPX1BDSV9GTEFH
X1VTRV9JT0VWRU5URkRfQklULCB0cnVlKSwKKyAgICBERUZJTkVfUFJPUF9VSU5UMzIoInZlY3Rv
cnMiLCBWaXJ0SU9QQ0lQcm94eSwgbnZlY3RvcnMsCisgICAgICAgICAgICAgICAgICAgICAgIERF
Vl9OVkVDVE9SU19VTlNQRUNJRklFRCksCisgICAgREVGSU5FX1BST1BfRU5EX09GX0xJU1QoKSwK
K307CisKK3N0YXRpYyB2b2lkIHZ1cnBtYl9wY2lfcmVhbGl6ZShWaXJ0SU9QQ0lQcm94eSAqdnBj
aV9kZXYsIEVycm9yICoqZXJycCkKK3sKKyAgICBWSG9zdFVzZXJSUE1CUENJICpkZXYgPSBWSE9T
VF9VU0VSX1JQTUJfUENJKHZwY2lfZGV2KTsKKyAgICBEZXZpY2VTdGF0ZSAqdmRldiA9IERFVklD
RSgmZGV2LT52ZGV2KTsKKworICAgIGlmICh2cGNpX2Rldi0+bnZlY3RvcnMgPT0gREVWX05WRUNU
T1JTX1VOU1BFQ0lGSUVEKSB7CisgICAgICAgIHZwY2lfZGV2LT5udmVjdG9ycyA9IDE7CisgICAg
fQorCisgICAgcWRldl9zZXRfcGFyZW50X2J1cyh2ZGV2LCBCVVMoJnZwY2lfZGV2LT5idXMpKTsK
KyAgICBvYmplY3RfcHJvcGVydHlfc2V0X2Jvb2woT0JKRUNUKHZkZXYpLCAicmVhbGl6ZWQiLCB0
cnVlLCBlcnJwKTsKK30KKworc3RhdGljIHZvaWQgdnVycG1iX3BjaV9jbGFzc19pbml0KE9iamVj
dENsYXNzICprbGFzcywgdm9pZCAqZGF0YSkKK3sKKyAgICBEZXZpY2VDbGFzcyAqZGMgPSBERVZJ
Q0VfQ0xBU1Moa2xhc3MpOworICAgIFZpcnRpb1BDSUNsYXNzICprID0gVklSVElPX1BDSV9DTEFT
UyhrbGFzcyk7CisgICAgUENJRGV2aWNlQ2xhc3MgKnBjaWRldl9rID0gUENJX0RFVklDRV9DTEFT
UyhrbGFzcyk7CisgICAgay0+cmVhbGl6ZSA9IHZ1cnBtYl9wY2lfcmVhbGl6ZTsKKyAgICBzZXRf
Yml0KERFVklDRV9DQVRFR09SWV9TVE9SQUdFLCBkYy0+Y2F0ZWdvcmllcyk7CisgICAgZGV2aWNl
X2NsYXNzX3NldF9wcm9wcyhkYywgdnVycG1iX3BjaV9wcm9wZXJ0aWVzKTsKKyAgICBwY2lkZXZf
ay0+dmVuZG9yX2lkID0gUENJX1ZFTkRPUl9JRF9SRURIQVRfUVVNUkFORVQ7CisgICAgcGNpZGV2
X2stPmRldmljZV9pZCA9IDA7IC8qIFNldCBieSB2aXJ0aW8tcGNpIGJhc2VkIG9uIHZpcnRpbyBp
ZCAqLworICAgIHBjaWRldl9rLT5yZXZpc2lvbiA9IDB4MDA7CisgICAgcGNpZGV2X2stPmNsYXNz
X2lkID0gUENJX0NMQVNTX1NUT1JBR0VfT1RIRVI7Cit9CisKK3N0YXRpYyB2b2lkIHZ1cnBtYl9w
Y2lfaW5zdGFuY2VfaW5pdChPYmplY3QgKm9iaikKK3sKKyAgICBWSG9zdFVzZXJSUE1CUENJICpk
ZXYgPSBWSE9TVF9VU0VSX1JQTUJfUENJKG9iaik7CisKKyAgICB2aXJ0aW9faW5zdGFuY2VfaW5p
dF9jb21tb24ob2JqLCAmZGV2LT52ZGV2LCBzaXplb2YoZGV2LT52ZGV2KSwKKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgVFlQRV9WSE9TVF9VU0VSX1JQTUIpOworfQorCitzdGF0aWMg
Y29uc3QgVmlydGlvUENJRGV2aWNlVHlwZUluZm8gdnVycG1iX3BjaV9pbmZvID0geworICAgIC5i
YXNlX25hbWUgICAgICAgICAgICAgPSBUWVBFX1ZIT1NUX1VTRVJfUlBNQl9QQ0ksCisgICAgLm5v
bl90cmFuc2l0aW9uYWxfbmFtZSA9ICJ2aG9zdC11c2VyLXJwbWItcGNpIiwKKyAgICAuaW5zdGFu
Y2Vfc2l6ZSA9IHNpemVvZihWSG9zdFVzZXJSUE1CUENJKSwKKyAgICAuaW5zdGFuY2VfaW5pdCA9
IHZ1cnBtYl9wY2lfaW5zdGFuY2VfaW5pdCwKKyAgICAuY2xhc3NfaW5pdCAgICA9IHZ1cnBtYl9w
Y2lfY2xhc3NfaW5pdCwKK307CisKK3N0YXRpYyB2b2lkIHZ1cnBtYl9wY2lfcmVnaXN0ZXIodm9p
ZCkKK3sKKyAgICB2aXJ0aW9fcGNpX3R5cGVzX3JlZ2lzdGVyKCZ2dXJwbWJfcGNpX2luZm8pOwor
fQorCit0eXBlX2luaXQodnVycG1iX3BjaV9yZWdpc3Rlcik7CmRpZmYgLS1naXQgYS9ody9ibG9j
ay9tZXNvbi5idWlsZCBiL2h3L2Jsb2NrL21lc29uLmJ1aWxkCmluZGV4IDExNDIyMmYxODQyNC4u
MGIyZDEwMjAxZTI4IDEwMDY0NAotLS0gYS9ody9ibG9jay9tZXNvbi5idWlsZAorKysgYi9ody9i
bG9jay9tZXNvbi5idWlsZApAQCAtMTgsNSArMTgsNyBAQCBzb2Z0bW11X3NzLmFkZCh3aGVuOiAn
Q09ORklHX05WTUVfUENJJywgaWZfdHJ1ZTogZmlsZXMoJ252bWUuYycpKQogc3BlY2lmaWNfc3Mu
YWRkKHdoZW46ICdDT05GSUdfVklSVElPX0JMSycsIGlmX3RydWU6IGZpbGVzKCd2aXJ0aW8tYmxr
LmMnKSkKIHNwZWNpZmljX3NzLmFkZCh3aGVuOiAnQ09ORklHX1ZIT1NUX1VTRVJfQkxLJywgaWZf
dHJ1ZTogZmlsZXMoJ3Zob3N0LXVzZXItYmxrLmMnKSkKIHNwZWNpZmljX3NzLmFkZCh3aGVuOiAn
Q09ORklHX1ZIT1NUX1VTRVJfUlBNQicsIGlmX3RydWU6IGZpbGVzKCd2aG9zdC11c2VyLXJwbWIu
YycpKQorc3BlY2lmaWNfc3MuYWRkKHdoZW46IFsnQ09ORklHX1ZIT1NUX1VTRVJfUlBNQicsICdD
T05GSUdfVklSVElPX1BDSScgXSwKKyAgICAgICAgICAgICAgICBpZl90cnVlOiBmaWxlcygndmhv
c3QtdXNlci1ycG1iLXBjaS5jJykpCiAKIHN1YmRpcignZGF0YXBsYW5lJykKLS0gCjIuMjAuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
