Return-Path: <SRS0=jbvZ=DC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BE43C4363D
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 12:52:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 49BA521741
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 12:52:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="gDSOYgSF"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 49BA521741
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EBA2486DE8;
	Fri, 25 Sep 2020 12:52:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id n22fOoKXw7Q6; Fri, 25 Sep 2020 12:52:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id D2FF386DD7;
	Fri, 25 Sep 2020 12:52:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BC521C1AD5;
	Fri, 25 Sep 2020 12:52:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 721BBC0859
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:52:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6E95187508
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:52:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id je+Z8t85c9HJ
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:52:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A0EDB87143
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:52:10 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id z4so3506631wrr.4
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 05:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=La3wf0jgdLLaxy3qyiZ5nLFWQDulF/WBD+D4LgHv5vo=;
 b=gDSOYgSFewYCKCeiBthgQfO9lDdu251R/GVGuV69QTfKwahNlWXaTyMUnKiZcCLRwZ
 J3We7jodc6NQ7jHC86IJpHHURJc45O+bvnnqI/MehiicHpvvWUHzonrCKxc14M1htnM/
 ieM+uPWUdkfYbyHoEGQ0NqHWnjG2MmAr6amBossVDArsXaThqA69zcMqZjL29V/xRPkG
 kQHSWh0RGM5Ot/o7V6ISt5Uk//+IctUG0nsjkBfnJ8HUfN9mJvW0hGc0oHrppjAB3Gyr
 4qJxETzaACuIVtVWHItKkcHuifPd/KG7nyqc8SFS3PCAQDKiG1gnlCzGoa6FpimLafIb
 6DlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=La3wf0jgdLLaxy3qyiZ5nLFWQDulF/WBD+D4LgHv5vo=;
 b=s/5TvlJjvCyMKo4DNEXfa7dCv5+yiD+7PiqEoOUd+CkPTwjZztZPmO1eNRiqNzPX1U
 Na1NlAdvLLmCYXuEtJ7huHV5eeCIiIMwJKpvzq664eirSgymaYi4IzUnxGxRZYs+s47Q
 ehPamccjqDnMDFTkvAY0zXeqZRa6NMTjbN3uSvyMm4yQz4BxiM5KErGMgzX3IF4UGsko
 v5ktjqDvUdzEMeru9bjHnIzYlhtDQn+gpuS6ssDsCDddnluOc+EZbH8ATq7SJqKWYL4Y
 p0Bb4G8/TRSaNN8BPQo34R36WF8d132koS0RYVveuz9mxJSupS9z4R3TniwCiy1tIfjC
 pvrA==
X-Gm-Message-State: AOAM53068w0EWQgSxg/FXzpxo66LcPw2jd/chMsttWwB7M7Zb5OuObCD
 na/1Lx1k7Q/wl5U/OrA9rYom+g==
X-Google-Smtp-Source: ABdhPJw+FnAq0jAiugV2Cg4Tl3jIA4VQwRsQf9Hp7qNWdz8GCxcD2vXGq4F6xrTrZ0uReMSF0qA0HQ==
X-Received: by 2002:adf:e292:: with SMTP id v18mr4351820wri.256.1601038329141; 
 Fri, 25 Sep 2020 05:52:09 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id i83sm2877331wma.22.2020.09.25.05.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:52:00 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 2C74D1FF99;
 Fri, 25 Sep 2020 13:51:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH 10/19] tools/vhost-user-rpmb: handle shutdown and
 SIGINT/SIGHUP cleanly
Date: Fri, 25 Sep 2020 13:51:38 +0100
Message-Id: <20200925125147.26943-11-alex.bennee@linaro.org>
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

VGhlIGxpYnZob3N0LXVzZXIgbGlicmFyeSB3aWxsIGp1c3QgZXhpdCBpZiBpdCBoYW5kbGVzIHRo
ZQpWSE9TVF9VU0VSX05PTkUgbWVzc2FnZSBhbmQgd2Ugd2FudCB0byBlbnN1cmUgd2UgaGF2ZSB0
aWRpZWQgdXAgYWZ0ZXIKb3Vyc2VsdmVzLiBBcyB3ZSBuZWVkIHRvIHNpZ25hbCB0aGUgc2h1dGRv
d24gb2YgdGhlIG1haW4gbG9vcCB3ZSBuZWVkCnRvIG1vdmUgdGhlIGluZm9ybWF0aW9uIGludG8g
dGhlIFZ1Um1iIHN0YXRlIHN0cnVjdHVyZS4KCldlIGFsc28gd2FudCB0byBkbyB0aGUgc2FtZSBp
ZiB3ZSBjYXRjaCBhIFNJR0lOVC9TSUdIVVAgdGVybWluYXRpb24Kc2lnbmFsLiBXaGlsZSB3ZSBh
cmUgYXQgaXQgYWRkIHNvbWUgaW5zdHJ1bWVudGF0aW9uIHNvIHdlIGNhbiBmb2xsb3cKdGhlIHBy
b2dyYW0gZmxvdy4KClNpZ25lZC1vZmYtYnk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGlu
YXJvLm9yZz4KLS0tCiB0b29scy92aG9zdC11c2VyLXJwbWIvbWFpbi5jIHwgNDkgKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKy0tLS0tCiAxIGZpbGUgY2hhbmdlZCwgNDMgaW5zZXJ0aW9u
cygrKSwgNiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS90b29scy92aG9zdC11c2VyLXJwbWIv
bWFpbi5jIGIvdG9vbHMvdmhvc3QtdXNlci1ycG1iL21haW4uYwppbmRleCAxYmUwZDRiOGE1Njcu
LjdiM2IyOWNjZmM1YiAxMDA2NDQKLS0tIGEvdG9vbHMvdmhvc3QtdXNlci1ycG1iL21haW4uYwor
KysgYi90b29scy92aG9zdC11c2VyLXJwbWIvbWFpbi5jCkBAIC0xMiw2ICsxMiw3IEBACiAjaW5j
bHVkZSA8Z2xpYi5oPgogI2luY2x1ZGUgPGdpby9naW8uaD4KICNpbmNsdWRlIDxnaW8vZ3VuaXhz
b2NrZXRhZGRyZXNzLmg+CisjaW5jbHVkZSA8Z2xpYi11bml4Lmg+CiAjaW5jbHVkZSA8c3RkaW8u
aD4KICNpbmNsdWRlIDxzdHJpbmcuaD4KICNpbmNsdWRlIDxpbnR0eXBlcy5oPgpAQCAtNzMsNiAr
NzQsNyBAQCBzdHJ1Y3QgdmlydGlvX3JwbWJfZnJhbWUgewogdHlwZWRlZiBzdHJ1Y3QgVnVScG1i
IHsKICAgICBWdWdEZXYgZGV2OwogICAgIHN0cnVjdCB2aXJ0aW9fcnBtYl9jb25maWcgdmlydGlv
X2NvbmZpZzsKKyAgICBHTWFpbkxvb3AgKmxvb3A7CiB9IFZ1UnBtYjsKIAogc3RydWN0IHZpcnRp
b19ycG1iX2N0cmxfY29tbWFuZCB7CkBAIC0xNTgsMTAgKzE2MCwyMiBAQCB2cnBtYl9xdWV1ZV9z
ZXRfc3RhcnRlZChWdURldiAqZGV2LCBpbnQgcWlkeCwgYm9vbCBzdGFydGVkKQogICAgIH0KIH0K
IAotc3RhdGljIGludAotdnJwbWJfcHJvY2Vzc19tc2coVnVEZXYgKmRldiwgVmhvc3RVc2VyTXNn
ICptc2csIGludCAqZG9fcmVwbHkpCisvKgorICogdnJwbWJfcHJvY2Vzc19tc2c6IHByb2Nlc3Mg
bWVzc2FnZXMgb2Ygdmhvc3QtdXNlciBpbnRlcmZhY2UKKyAqCisgKiBBbnkgdGhhdCBhcmUgbm90
IGhhbmRsZWQgaGVyZSBhcmUgcHJvY2Vzc2VkIGJ5IHRoZSBsaWJ2aG9zdCBsaWJyYXJ5CisgKiBp
dHNlbGYuCisgKi8KK3N0YXRpYyBpbnQgdnJwbWJfcHJvY2Vzc19tc2coVnVEZXYgKmRldiwgVmhv
c3RVc2VyTXNnICptc2csIGludCAqZG9fcmVwbHkpCiB7CisgICAgVnVScG1iICpyID0gY29udGFp
bmVyX29mKGRldiwgVnVScG1iLCBkZXYucGFyZW50KTsKKworICAgIGdfaW5mbygiJXM6IG1zZyAl
ZCIsIF9fZnVuY19fLCBtc2ctPnJlcXVlc3QpOworCiAgICAgc3dpdGNoIChtc2ctPnJlcXVlc3Qp
IHsKKyAgICBjYXNlIFZIT1NUX1VTRVJfTk9ORToKKyAgICAgICAgZ19tYWluX2xvb3BfcXVpdChy
LT5sb29wKTsKKyAgICAgICAgcmV0dXJuIDE7CiAgICAgZGVmYXVsdDoKICAgICAgICAgcmV0dXJu
IDA7CiAgICAgfQpAQCAtMTgxLDYgKzE5NSw5IEBAIHN0YXRpYyBjb25zdCBWdURldklmYWNlIHZ1
aWZhY2UgPSB7CiBzdGF0aWMgdm9pZCB2cnBtYl9kZXN0cm95KFZ1UnBtYiAqcikKIHsKICAgICB2
dWdfZGVpbml0KCZyLT5kZXYpOworICAgIGlmIChzb2NrZXRfcGF0aCkgeworICAgICAgICB1bmxp
bmsoc29ja2V0X3BhdGgpOworICAgIH0KIH0KIAogLyogUHJpbnQgdmhvc3QtdXNlci5qc29uIGJh
Y2tlbmQgcHJvZ3JhbSBjYXBhYmlsaXRpZXMgKi8KQEAgLTE5MSwxMSArMjA4LDE4IEBAIHN0YXRp
YyB2b2lkIHByaW50X2NhcGFiaWxpdGllcyh2b2lkKQogICAgIHByaW50ZigifVxuIik7CiB9CiAK
K3N0YXRpYyBnYm9vbGVhbiBoYW5ndXAoZ3BvaW50ZXIgdXNlcl9kYXRhKQoreworICAgIEdNYWlu
TG9vcCAqbG9vcCA9IChHTWFpbkxvb3AgKikgdXNlcl9kYXRhOworICAgIGdfaW5mbygiJXM6IGNh
dWdodCBoYW5ndXAvcXVpdCBzaWduYWwsIHF1aXR0aW5nIG1haW4gbG9vcCIsIF9fZnVuY19fKTsK
KyAgICBnX21haW5fbG9vcF9xdWl0KGxvb3ApOworICAgIHJldHVybiB0cnVlOworfQorCiBpbnQg
bWFpbiAoaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKIHsKICAgICBHRXJyb3IgKmVycm9yID0gTlVM
TDsKICAgICBHT3B0aW9uQ29udGV4dCAqY29udGV4dDsKLSAgICBnX2F1dG9wdHIoR01haW5Mb29w
KSBsb29wID0gTlVMTDsKICAgICBnX2F1dG9wdHIoR1NvY2tldCkgc29ja2V0ID0gTlVMTDsKICAg
ICBWdVJwbWIgcnBtYiA9IHsgIH07CiAKQEAgLTI2MiwxNSArMjg2LDI4IEBAIGludCBtYWluIChp
bnQgYXJnYywgY2hhciAqYXJndltdKQogICAgICAgICB9CiAgICAgfQogCisgICAgLyoKKyAgICAg
KiBDcmVhdGUgdGhlIG1haW4gbG9vcCBmaXJzdCBzbyBhbGwgdGhlIHZhcmlvdXMgc291cmNlcyBj
YW4gYmUKKyAgICAgKiBhZGRlZC4gQXMgd2VsbCBhcyBjYXRjaGluZyBzaWduYWxzIHdlIG5lZWQg
dG8gZW5zdXJlIHZ1Z19pbml0CisgICAgICogY2FuIGFkZCBpdCdzIEdTb3VyY2Ugd2F0Y2hlcy4K
KyAgICAgKi8KKworICAgIHJwbWIubG9vcCA9IGdfbWFpbl9sb29wX25ldyhOVUxMLCBGQUxTRSk7
CisgICAgLyogY2F0Y2ggZXhpdCBzaWduYWxzICovCisgICAgZ191bml4X3NpZ25hbF9hZGQoU0lH
SFVQLCBoYW5ndXAsIHJwbWIubG9vcCk7CisgICAgZ191bml4X3NpZ25hbF9hZGQoU0lHSU5ULCBo
YW5ndXAsIHJwbWIubG9vcCk7CisKICAgICBpZiAoIXZ1Z19pbml0KCZycG1iLmRldiwgVkhPU1Rf
VVNFUl9SUE1CX01BWF9RVUVVRVMsIGdfc29ja2V0X2dldF9mZChzb2NrZXQpLAogICAgICAgICAg
ICAgICAgICAgdnJwbWJfcGFuaWMsICZ2dWlmYWNlKSkgewogICAgICAgICBnX3ByaW50ZXJyKCJG
YWlsZWQgdG8gaW5pdGlhbGl6ZSBsaWJ2aG9zdC11c2VyLWdsaWIuXG4iKTsKICAgICAgICAgZXhp
dChFWElUX0ZBSUxVUkUpOwogICAgIH0KIAotICAgIGxvb3AgPSBnX21haW5fbG9vcF9uZXcoTlVM
TCwgRkFMU0UpOwotICAgIGdfbWFpbl9sb29wX3J1bihsb29wKTsKLSAgICBnX21haW5fbG9vcF91
bnJlZihsb29wKTsKIAorICAgIGdfbWVzc2FnZSgiZW50ZXJpbmcgbWFpbiBsb29wLCBhd2FpdGlu
ZyBtZXNzYWdlcyIpOworICAgIGdfbWFpbl9sb29wX3J1bihycG1iLmxvb3ApOworICAgIGdfbWVz
c2FnZSgiZmluaXNoZWQgbWFpbiBsb29wLCBjbGVhbmluZyB1cCIpOworCisgICAgZ19tYWluX2xv
b3BfdW5yZWYocnBtYi5sb29wKTsKICAgICB2cnBtYl9kZXN0cm95KCZycG1iKTsKIH0KLS0gCjIu
MjAuMQoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
