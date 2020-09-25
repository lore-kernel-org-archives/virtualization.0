Return-Path: <SRS0=jbvZ=DC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5172C4727C
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 12:59:16 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 590CF206DB
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 12:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZBulUDn5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 590CF206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id ADB5F86D94;
	Fri, 25 Sep 2020 12:59:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3hoP0Rq-IkRh; Fri, 25 Sep 2020 12:59:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id EF2B686DF2;
	Fri, 25 Sep 2020 12:59:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C2A4AC1AD6;
	Fri, 25 Sep 2020 12:59:11 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 89659C0890
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:59:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7F47986B04
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:59:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rH5wSONEPbrp
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:59:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id BC94B86AD0
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:59:09 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id s13so2944732wmh.4
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 05:59:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=sln1IsFPWRFtNzDapJfqz9D0UXVcbAOIwCVnS/WVrtY=;
 b=ZBulUDn5etyg+1dgFomway7kca2EbjmeP6HXXUn2kPBv7e7AxynvYVSXdfxdyMdsoU
 xEK2ZtRZVQD+4fy7Et8CsSFF82ZVYh3tL0ehKCKvCe0Wvi8ciIArcncdn0L/wGVeSM3X
 aYv85YBs14SG+7zMjCj0rcm+Xx41zh4wMGs/dKmBOF5L6eBSb2UvS57QZDKSKb7jEBqW
 YnQZnZfqzXDevKvT/WTNM83s9lDRmS5JvZr26qlvg6rWPXmQdouKNzvzCTNpH4WJ2lPu
 zJiJQpf5g9nCDXCKIFFmqd1gVULLBqJ9fdyYqC5xlG3iD1yaF0PiyWJ4irYUtCwQKT4m
 8nrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=sln1IsFPWRFtNzDapJfqz9D0UXVcbAOIwCVnS/WVrtY=;
 b=L06PSitwR72rR7hcJViiezRpTlxYpxH0cgIpvADY5sx6vZmhBYUYZtsHqsaVgCYbkA
 I4H2J82Ik0nGOgVVsEQngcanDsdooQXcQX6anA9SzxnZVyKRPOmk9k+uME7lWZiZra/h
 ck7TC3lnAmUE2+cwPbVmLCtjWG8zztYwhf934F4FbUdFVJBQ9hEcJRaahHtuCkk+Sz9I
 /753Y1N0YMJTQr49mAowjmPGZxN7530kY0C9edKsiLRBhmYkJLACRz1EwILal31a3g4j
 O7tUSD+IxK6xoQTNlI8KQSMMrdOQG95CrKrC8TN/fq5yUGjXERR50ZDh7uJcr4cAVCcw
 ZfbA==
X-Gm-Message-State: AOAM532Wfw7WTo2X5OT2o1Dh+ZCE+zqCeK6m92OU9VzLvtPp7LUBtmKL
 4RQefNH0uDBQjlDl4J9XfLK5aw==
X-Google-Smtp-Source: ABdhPJwOvPxIbh1o3qPJsaGqkunGlbhgt2Yfji/eep9aSP6iGhmKJbXwgWNt3MCRzqxCCkT92+9UHw==
X-Received: by 2002:a05:600c:2317:: with SMTP id
 23mr3135313wmo.183.1601038748151; 
 Fri, 25 Sep 2020 05:59:08 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id n2sm3112612wma.29.2020.09.25.05.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:59:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id E2DCB1FFA6;
 Fri, 25 Sep 2020 13:51:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH 18/19] tools/vhost-user-rpmb: allow setting of the
 write_count
Date: Fri, 25 Sep 2020 13:51:46 +0100
Message-Id: <20200925125147.26943-19-alex.bennee@linaro.org>
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

VGhpcyBpcyBtb3N0bHkgdXNlZnVsIGZvciB0ZXN0aW5nLiBQcmFjdGljYWxseSBhbGwgZ3Vlc3Qg
b3BlcmF0aW9ucwp3aWxsIHByb2JlIHRoZSB3cml0ZSBjb3VudCBiZWZvcmUgYW55IHdyaXRlIHRy
YW5zYWN0aW9uLgoKU2lnbmVkLW9mZi1ieTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5h
cm8ub3JnPgotLS0KIHRvb2xzL3Zob3N0LXVzZXItcnBtYi9tYWluLmMgfCA2ICsrKysrKwogMSBm
aWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdpdCBhL3Rvb2xzL3Zob3N0LXVz
ZXItcnBtYi9tYWluLmMgYi90b29scy92aG9zdC11c2VyLXJwbWIvbWFpbi5jCmluZGV4IDM0NjA3
YWQxOTQyOS4uYzc5OGE2ZjY2Y2QyIDEwMDY0NAotLS0gYS90b29scy92aG9zdC11c2VyLXJwbWIv
bWFpbi5jCisrKyBiL3Rvb2xzL3Zob3N0LXVzZXItcnBtYi9tYWluLmMKQEAgLTM5LDYgKzM5LDcg
QEAKIHN0YXRpYyBnY2hhciAqc29ja2V0X3BhdGg7CiBzdGF0aWMgY2hhciAqZmxhc2hfcGF0aDsK
IHN0YXRpYyBjaGFyICprZXlfcGF0aDsKK3N0YXRpYyBnaW50IGluaXRpYWxfY291bnRlcjsKIHN0
YXRpYyBnaW50IHNvY2tldF9mZCA9IC0xOwogc3RhdGljIGdib29sZWFuIHByaW50X2NhcDsKIHN0
YXRpYyBnYm9vbGVhbiB2ZXJib3NlOwpAQCAtNDksNiArNTAsNyBAQCBzdGF0aWMgR09wdGlvbkVu
dHJ5IG9wdGlvbnNbXSA9CiB7CiAgICAgeyAic29ja2V0LXBhdGgiLCAwLCAwLCBHX09QVElPTl9B
UkdfRklMRU5BTUUsICZzb2NrZXRfcGF0aCwgIkxvY2F0aW9uIG9mIHZob3N0LXVzZXIgVW5peCBk
b21haW4gc29ja2V0LCBpbmNvbXBhdGlibGUgd2l0aCAtLWZkIiwgIlBBVEgiIH0sCiAgICAgeyAi
Zmxhc2gtcGF0aCIsIDAsIDAsIEdfT1BUSU9OX0FSR19GSUxFTkFNRSwgJmZsYXNoX3BhdGgsICJM
b2NhdGlvbiBvZiByYXcgZmxhc2ggaW1hZ2UgZmlsZSIsICJQQVRIIiB9LAorICAgIHsgImluaXRp
YWwtY291bnRlciIsIDAsIDAsIEdfT1BUSU9OX0FSR19JTlQsICZpbml0aWFsX2NvdW50ZXIsICJT
ZXQgaW5pdGlhbCB2YWx1ZSBvZiB3cml0ZSBjb3VudGVyIiwgTlVMTH0sCiAgICAgeyAia2V5LXBh
dGgiLCAwLCAwLCBHX09QVElPTl9BUkdfRklMRU5BTUUsICZrZXlfcGF0aCwgIkxvY2F0aW9uIG9m
IHBlcnNpc3RlbnQga2V5ZmlsZSIsICJLRVkifSwKICAgICB7ICJrZXktc2V0IiwgMCwgMCwgR19P
UFRJT05fQVJHX05PTkUsICZrZXlfc2V0LCAiSXMgdGhlIGtleSBhbHJlYWR5IHByb2dyYW1tZWQi
LCBOVUxMfSwKICAgICB7ICJmZCIsIDAsIDAsIEdfT1BUSU9OX0FSR19JTlQsICZzb2NrZXRfZmQs
ICJTcGVjaWZ5IHRoZSBmaWxlLWRlc2NyaXB0b3Igb2YgdGhlIGJhY2tlbmQsIGluY29tcGF0aWJs
ZSB3aXRoIC0tc29ja2V0LXBhdGgiLCAiRkQiIH0sCkBAIC03OTcsNiArNzk5LDEwIEBAIGludCBt
YWluKGludCBhcmdjLCBjaGFyICphcmd2W10pCiAgICAgICAgIHZycG1iX3NldF9rZXkoJnJwbWIs
IGtleV9wYXRoKTsKICAgICB9CiAKKyAgICBpZiAoaW5pdGlhbF9jb3VudGVyKSB7CisgICAgICAg
IHJwbWIud3JpdGVfY291bnQgPSBpbml0aWFsX2NvdW50ZXI7CisgICAgfQorCiAgICAgaWYgKCFz
b2NrZXRfcGF0aCAmJiBzb2NrZXRfZmQgPCAwKSB7CiAgICAgICAgIGdfcHJpbnRlcnIoIlBsZWFz
ZSBzcGVjaWZ5IGVpdGhlciAtLWZkIG9yIC0tc29ja2V0LXBhdGhcbiIpOwogICAgICAgICBleGl0
KEVYSVRfRkFJTFVSRSk7Ci0tIAoyLjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
