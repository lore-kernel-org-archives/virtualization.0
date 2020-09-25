Return-Path: <SRS0=jbvZ=DC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7FA3C4741F
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 12:52:05 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5C40E206DB
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 12:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="UHH9XotP"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5C40E206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3F536875F0;
	Fri, 25 Sep 2020 12:52:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id cUhbGiufiBRl; Fri, 25 Sep 2020 12:52:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 958FC875F6;
	Fri, 25 Sep 2020 12:52:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7509FC0890;
	Fri, 25 Sep 2020 12:52:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9EE5C0859
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:52:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E3F3287599
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:52:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QiZgYKy266nP
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:52:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 972A48750D
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:52:01 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id g4so3486716wrs.5
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 05:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=qsQZO642QNM9thsI3rY2HZwoa6pjzpWob+CVTQWTY9k=;
 b=UHH9XotPcaYd69YG2moOspEe8L59ggJkDB9j8hC7qbik1KRbkYDtM6C4EsDe/h0MLq
 Sq4RMjWheINojM95Qcm/GW4lfrhRJINf4TnM+1AinLXgny7ZLW/WYYXl3aEF6GMGS4vE
 B7UzanlSuTJ+faT1+h1dZiNiabnem737nOmJCmBVT/RvgddxGluHp0DHoyiafjPy78cH
 kgnXQ61iULB1D2ILTuiZcmEJAvAUx2SOPQjH9uaSeHrUnvhpnV9LVEWBujE/yi1F76mn
 VZ0+GzOrusr4XWoGZUpP/HvVuqXDStYmZKgkm9FP0Ljkcs7pxxxtNCk7OlbDgnsPjwsO
 pTVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=qsQZO642QNM9thsI3rY2HZwoa6pjzpWob+CVTQWTY9k=;
 b=kLWFq4L2L+7F83+rpvG7eN1ATIyCfJ3rjivPBrhwhkrBXmqbAgNUV6ff/m2A7l8XhI
 GqQUaJYReER3EcR722RCzsvl7L+e1QZqBeX3SdngYwKwHJdPAVh/22le+v4fyVDaqnan
 0k+MjM68TGb1PIbaTik/+Y4e81ISpNEY/Qy9k9MXQcEff4B+pxE0h4okPui+HOadp0TR
 Wx5XZsyeNQsRQuqyetV/ypIBrdSlPlfK1t1s/IYFeRqRJwnWEP81bAxXC6p7Mp3Xo48m
 5+XfdpGsuSMPR1+0UQQJObBKjiOSmOTCvVh6MP/CZ/gxeqBqXB9Tfcvjc+hQISPVfssR
 2FeQ==
X-Gm-Message-State: AOAM530a6jrl+8nzYcureza9/r7XQqy/vPzViAeX+pi1xDrNflCmylGP
 c4tnLhoNxpDHHaZGrEFR+6mfDg==
X-Google-Smtp-Source: ABdhPJzxGOLpvB7rUaudCgm/+nAA6NXLFNZlEuBZJJxkQw7M1L981nLdC9hOSy871SGN+c1FCuXWFA==
X-Received: by 2002:a5d:5261:: with SMTP id l1mr4316749wrc.193.1601038320023; 
 Fri, 25 Sep 2020 05:52:00 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l18sm2730665wrp.84.2020.09.25.05.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:51:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id C544D1FF92;
 Fri, 25 Sep 2020 13:51:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH 06/19] tools/vhost-user-rpmb: add boilerplate and initial
 main
Date: Fri, 25 Sep 2020 13:51:34 +0100
Message-Id: <20200925125147.26943-7-alex.bennee@linaro.org>
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

VGhpcyBhZGRzIHRoZSBib2lsZXJwbGF0ZSBmaWxlcyBmb3IgYSBuZXcgdmhvc3QtdXNlciBoZWxw
ZXIgY2FsbGVkCnZob3N0LXVzZXItcnBtYiB3aGljaCB3aWxsIHN1cHBvcnQgdmlydGlvIGJhc2Vk
IFJQTUIgKFJlcGxheSBQcm90ZWN0ZWQKTWVtb3J5IEJsb2NrKSBkZXZpY2VzLgoKVGhpcyBjb21t
aXQganVzdCBhZGRzIHRoZSBpbml0aWFsIGJvaWxlcnBsYXRlIGZvciBidWlsZGluZyB0aGUgYmlu
YXJ5CndpdGggdGhlIGNvbW1vbiB2aG9zdC11c2VyIG9wdGlvbnMuIEFzIG9mIHRoaXMgY29tbWl0
IHRoZSBvbmx5IHVzZWZ1bApvdXRwdXQgeW91IGdldCBpcyB3aGVuIHJ1bm5pbmc6CgogIHZob3N0
LXVzZXItcnBtYiAtLWhlbHAKClNpZ25lZC1vZmYtYnk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5u
ZWVAbGluYXJvLm9yZz4KLS0tCiB0b29scy92aG9zdC11c2VyLXJwbWIvbWFpbi5jICAgICAgICAg
ICAgICAgfCAzNyArKysrKysrKysrKysrKysrKysrKysrCiBNQUlOVEFJTkVSUyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgfCAgNSArKysKIHRvb2xzL21lc29uLmJ1aWxkICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICA4ICsrKysrCiB0b29scy92aG9zdC11c2VyLXJwbWIvNTAtcWVt
dS1ycG1iLmpzb24uaW4gfCAgNSArKysKIHRvb2xzL3Zob3N0LXVzZXItcnBtYi9tZXNvbi5idWls
ZCAgICAgICAgICB8IDExICsrKysrKysKIDUgZmlsZXMgY2hhbmdlZCwgNjYgaW5zZXJ0aW9ucygr
KQogY3JlYXRlIG1vZGUgMTAwNjQ0IHRvb2xzL3Zob3N0LXVzZXItcnBtYi9tYWluLmMKIGNyZWF0
ZSBtb2RlIDEwMDY0NCB0b29scy92aG9zdC11c2VyLXJwbWIvNTAtcWVtdS1ycG1iLmpzb24uaW4K
IGNyZWF0ZSBtb2RlIDEwMDY0NCB0b29scy92aG9zdC11c2VyLXJwbWIvbWVzb24uYnVpbGQKCmRp
ZmYgLS1naXQgYS90b29scy92aG9zdC11c2VyLXJwbWIvbWFpbi5jIGIvdG9vbHMvdmhvc3QtdXNl
ci1ycG1iL21haW4uYwpuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAwMDAwMDAuLmE0
MGE2ODBhNzRjYQotLS0gL2Rldi9udWxsCisrKyBiL3Rvb2xzL3Zob3N0LXVzZXItcnBtYi9tYWlu
LmMKQEAgLTAsMCArMSwzNyBAQAorLyoKKyAqIFZJUlRJTyBSUE1CIEVtdWxhdGlvbiB2aWEgdmhv
c3QtdXNlcgorICoKKyAqIENvcHlyaWdodCAoYykgMjAyMCBMaW5hcm8gTHRkCisgKgorICogU1BE
WC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAtb3ItbGF0ZXIKKyAqLworCisjaW5jbHVkZSA8
Z2xpYi5oPgorCitzdGF0aWMgZ2NoYXIgKnNvY2tldF9wYXRoOworc3RhdGljIGdpbnQgc29ja2V0
X2ZkOworc3RhdGljIGdib29sZWFuIHByaW50X2NhcDsKKworc3RhdGljIEdPcHRpb25FbnRyeSBv
cHRpb25zW10gPQoreworICAgIHsgInNvY2tldC1wYXRoIiwgMCwgMCwgR19PUFRJT05fQVJHX0ZJ
TEVOQU1FLCAmc29ja2V0X3BhdGgsICJMb2NhdGlvbiBvZiB2aG9zdC11c2VyIFVuaXggZG9tYWlu
IHNvY2tldCwgaW5jb21wYXRpYmxlIHdpdGggLS1mZCIsICJQQVRIIiB9LAorICAgIHsgImZkIiwg
MCwgMCwgR19PUFRJT05fQVJHX0lOVCwgJnNvY2tldF9mZCwgIlNwZWNpZnkgdGhlIGZpbGUtZGVz
Y3JpcHRvciBvZiB0aGUgYmFja2VuZCwgaW5jb21wYXRpYmxlIHdpdGggLS1zb2NrZXQtcGF0aCIs
ICJGRCIgfSwKKyAgICB7ICJwcmludC1jYXBhYmlsaXRpZXMiLCAwLCAwLCBHX09QVElPTl9BUkdf
Tk9ORSwgJnByaW50X2NhcCwgIk91dHB1dCB0byBzdGRvdXQgdGhlIGJhY2tlbmQgY2FwYWJpbGl0
aWVzIGluIEpTT04gZm9ybWF0IGFuZCBleGl0IiwgTlVMTH0sCisgICAgeyBOVUxMIH0KK307CisK
K2ludCBtYWluIChpbnQgYXJnYywgY2hhciAqYXJndltdKQoreworICAgIEdFcnJvciAqZXJyb3Ig
PSBOVUxMOworICAgIEdPcHRpb25Db250ZXh0ICpjb250ZXh0OworCisgICAgY29udGV4dCA9IGdf
b3B0aW9uX2NvbnRleHRfbmV3ICgidmhvc3QtdXNlci1ycG1iIC0gdmhvc3QtdXNlciBlbXVsYXRp
b24gb2YgUlBCTSBkZXZpY2UiKTsKKyAgICBnX29wdGlvbl9jb250ZXh0X2FkZF9tYWluX2VudHJp
ZXMgKGNvbnRleHQsIG9wdGlvbnMsICJ2aG9zdC11c2VyLXJwbWIiKTsKKyAgICBpZiAoIWdfb3B0
aW9uX2NvbnRleHRfcGFyc2UgKGNvbnRleHQsICZhcmdjLCAmYXJndiwgJmVycm9yKSkKKyAgICB7
CisgICAgICAgIGdfcHJpbnQgKCJvcHRpb24gcGFyc2luZyBmYWlsZWQ6ICVzXG4iLCBlcnJvci0+
bWVzc2FnZSk7CisgICAgICAgIGV4aXQgKDEpOworICAgIH0KKworCit9CmRpZmYgLS1naXQgYS9N
QUlOVEFJTkVSUyBiL01BSU5UQUlORVJTCmluZGV4IDNkMTdjYWQxOWFhMC4uZTMyNWMxMDI0YTMz
IDEwMDY0NAotLS0gYS9NQUlOVEFJTkVSUworKysgYi9NQUlOVEFJTkVSUwpAQCAtMTg3Myw2ICsx
ODczLDExIEBAIEY6IGh3L3ZpcnRpby92aXJ0aW8tbWVtLXBjaS5oCiBGOiBody92aXJ0aW8vdmly
dGlvLW1lbS1wY2kuYwogRjogaW5jbHVkZS9ody92aXJ0aW8vdmlydGlvLW1lbS5oCiAKK3ZpcnRp
by1ycG1iCitNOiBBbGV4IEJlbm7DqWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+CitTOiBTdXBw
b3J0ZWQKK0Y6IHRvb2xzL3Zob3N0LXVzZXItcnBtYi8qCisKIG52bWUKIE06IEtlaXRoIEJ1c2No
IDxrYnVzY2hAa2VybmVsLm9yZz4KIE06IEtsYXVzIEplbnNlbiA8aXRzQGlycmVsZXZhbnQuZGs+
CmRpZmYgLS1naXQgYS90b29scy9tZXNvbi5idWlsZCBiL3Rvb2xzL21lc29uLmJ1aWxkCmluZGV4
IDUxM2JkMmZmNGZkMi4uNDA4MDQ4YzYzNTdjIDEwMDY0NAotLS0gYS90b29scy9tZXNvbi5idWls
ZAorKysgYi90b29scy9tZXNvbi5idWlsZApAQCAtOCwzICs4LDExIEBAIGhhdmVfdmlydGlvZnNk
ID0gKGhhdmVfc3lzdGVtIGFuZAogaWYgaGF2ZV92aXJ0aW9mc2QKICAgc3ViZGlyKCd2aXJ0aW9m
c2QnKQogZW5kaWYKKworaGF2ZV92aXJ0aW9ycG1iID0gKGhhdmVfc3lzdGVtIGFuZAorICAgIGhh
dmVfdG9vbHMgYW5kCisgICAgJ0NPTkZJR19MSU5VWCcgaW4gY29uZmlnX2hvc3QpCisKK2lmIGhh
dmVfdmlydGlvcnBtYgorICBzdWJkaXIoJ3Zob3N0LXVzZXItcnBtYicpCitlbmRpZgpkaWZmIC0t
Z2l0IGEvdG9vbHMvdmhvc3QtdXNlci1ycG1iLzUwLXFlbXUtcnBtYi5qc29uLmluIGIvdG9vbHMv
dmhvc3QtdXNlci1ycG1iLzUwLXFlbXUtcnBtYi5qc29uLmluCm5ldyBmaWxlIG1vZGUgMTAwNjQ0
CmluZGV4IDAwMDAwMDAwMDAwMC4uMmIwMzNjZGE1NjdjCi0tLSAvZGV2L251bGwKKysrIGIvdG9v
bHMvdmhvc3QtdXNlci1ycG1iLzUwLXFlbXUtcnBtYi5qc29uLmluCkBAIC0wLDAgKzEsNSBAQAor
eworICAiZGVzY3JpcHRpb24iOiAiUUVNVSB2aG9zdC11c2VyLXJwbWIiLAorICAidHlwZSI6ICJi
bG9jayIsCisgICJiaW5hcnkiOiAiQGxpYmV4ZWNkaXJAL3Zob3N0LXVzZXItcnBtYiIKK30KZGlm
ZiAtLWdpdCBhL3Rvb2xzL3Zob3N0LXVzZXItcnBtYi9tZXNvbi5idWlsZCBiL3Rvb2xzL3Zob3N0
LXVzZXItcnBtYi9tZXNvbi5idWlsZApuZXcgZmlsZSBtb2RlIDEwMDY0NAppbmRleCAwMDAwMDAw
MDAwMDAuLmUwZGYxYjY5YTNmYgotLS0gL2Rldi9udWxsCisrKyBiL3Rvb2xzL3Zob3N0LXVzZXIt
cnBtYi9tZXNvbi5idWlsZApAQCAtMCwwICsxLDExIEBACitleGVjdXRhYmxlKCd2aG9zdC11c2Vy
LXJwbWInLCBmaWxlcygKKyAgJ21haW4uYycpLAorICBkZXBlbmRlbmNpZXM6IFtnbGliXSwKKyAg
bGlua193aXRoOiBbbGlidmhvc3RfdXNlcl0sCisgIGluc3RhbGw6IHRydWUsCisgIGluc3RhbGxf
ZGlyOiBnZXRfb3B0aW9uKCdsaWJleGVjZGlyJykpCisKK2NvbmZpZ3VyZV9maWxlKGlucHV0OiAn
NTAtcWVtdS1ycG1iLmpzb24uaW4nLAorICAgICAgICAgICAgICAgb3V0cHV0OiAnNTAtcWVtdS1y
cG1iLmpzb24nLAorICAgICAgICAgICAgICAgY29uZmlndXJhdGlvbjogY29uZmlnX2hvc3QsCisg
ICAgICAgICAgICAgICBpbnN0YWxsX2RpcjogcWVtdV9kYXRhZGlyIC8gJ3Zob3N0LXVzZXInKQot
LSAKMi4yMC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
