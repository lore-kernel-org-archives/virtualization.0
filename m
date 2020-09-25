Return-Path: <SRS0=jbvZ=DC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6BD3C4363D
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 12:59:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3169E206DB
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 12:59:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ng2mbfBa"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3169E206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 9CC3D87606;
	Fri, 25 Sep 2020 12:59:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XMoXuQXCWGpJ; Fri, 25 Sep 2020 12:59:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C9640875FC;
	Fri, 25 Sep 2020 12:59:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1153C0890;
	Fri, 25 Sep 2020 12:59:08 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9AF94C0859
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:59:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8EEA186D94
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:59:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id F-yemih06m3r
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:59:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 71AE086D23
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:59:05 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id e16so3541208wrm.2
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 05:59:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=9fkNiykv8ADFgLC/XdCeeBy0xSrSjYwQRRXXIjcsZfQ=;
 b=ng2mbfBaraUgOB2YcxAblz8zL/B2JiLaRmUITJQx7pI/RpR/qZr0cy2sSwPxSWDRCT
 GOaiiUyVeZnnyMd1JAeliXANvRli3jJpypwA3K+piwLhuP58yghIcf2FHiK3i/I6w8Y2
 8squPohCNbuCKFU5zycOQ2ZA3fuUfBDWeB/2H+4NN/Wa74uEGyo5zIiRZuqBPj2f236o
 ysTS4djRAw3rwKqug6u+wsiLi66HBgznwi/DWJUcKL3s9UEKzPg0EaXjnDVUL56+Kn19
 jG/A0xENSMpLe761AysdmZZjWvB7DK8NqKj8nvYZ/pOdT7FBFcx6MaCzt9mDFEu9quNV
 +F/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=9fkNiykv8ADFgLC/XdCeeBy0xSrSjYwQRRXXIjcsZfQ=;
 b=P/KIKNmIxCoqRsgqxwXCLzJsx50G/JImCD9nsWCiCj2tKo8NcAjbdg13TffY70ZAIB
 Mr8H3NelsJtfKosKngMAGK9qLp20dUX2/BOmwfYL+eieF+5W8CaxpHLYQICblvz/TMvl
 1x8bbNTI9/uLOAoLyH8kvnPoRWnLVZ53HNt7z7J2ZAoh3aG1CQWzNHmqEKGJabmp4psJ
 Da9uK44MaL/yCIrW+nZFZXqk709Z/RoO2tha0msWOk6nM5NgfdEycxI2Lg/kxIHLhFCL
 Gn+K5gvIj06gAcmdkJeO8Cx90slLrmXcYAnp1RTRwShXP2P1b/38DbzL/CPtPcPs253p
 +hsA==
X-Gm-Message-State: AOAM530J5bxac4WZxI+YZowzkCU044Ksny8oQjv6LpHw5xCwAkwVLCrj
 8QS/kwLAbB3OAoyrAYPuHLN5hQ==
X-Google-Smtp-Source: ABdhPJwZXb/aMNaYKd7Fb9nlyToAZPmVmFIUciP/z/7p3m/cMVRnn2njwc65CUypQ59VcJIyBLwOWg==
X-Received: by 2002:adf:ec47:: with SMTP id w7mr4681024wrn.175.1601038743834; 
 Fri, 25 Sep 2020 05:59:03 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id w7sm2681834wmc.43.2020.09.25.05.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:59:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id CBB9F1FFA5;
 Fri, 25 Sep 2020 13:51:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH  17/19] tools/vhost-user-rpmb: add key persistence
Date: Fri, 25 Sep 2020 13:51:45 +0100
Message-Id: <20200925125147.26943-18-alex.bennee@linaro.org>
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

QWRkIHN1cHBvcnQgZm9yIHBlcnNpc3RpbmcgdGhlIGtleSBpbiAtLWtleS1wYXRoLiBCeSBkZWZh
dWx0IGl0IHdpbGwKYWNjZXB0IHRoZSBwcm9ncmFtLWtleSBjb21tYW5kIGFuZCBzdG9yZSB0aGUg
a2V5IGluIHRoZSBrZXkgZmlsZS4gSWYKeW91IHBhc3MgLS1rZXktc2V0IHRoZW4gdGhlIGtleSBp
cyBkZWVtZWQgdG8gYmUgcHJvZ3JhbW1lZCBhbmQgY2FuJ3QKYmUgcmUtcHJvZ3JhbW1lZC4gT2J2
aW91c2x5IHlvdSB3aWxsIG5lZWQgc29tZSBvdGhlciBtZWNoYW5pc20gdG8gbGV0CnRoZSBndWVz
dCBrbm93IHdoYXQgdGhlIGtleSBpcyBzbyBpdCBjYW4gZG8gb3RoZXIgb3BlcmF0aW9ucy4KClNp
Z25lZC1vZmYtYnk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4KLS0tCiB0
b29scy92aG9zdC11c2VyLXJwbWIvbWFpbi5jIHwgMzcgKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrCiAxIGZpbGUgY2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKQoKZGlmZiAtLWdp
dCBhL3Rvb2xzL3Zob3N0LXVzZXItcnBtYi9tYWluLmMgYi90b29scy92aG9zdC11c2VyLXJwbWIv
bWFpbi5jCmluZGV4IDQ5ZDRlMDBiMjRhOS4uMzQ2MDdhZDE5NDI5IDEwMDY0NAotLS0gYS90b29s
cy92aG9zdC11c2VyLXJwbWIvbWFpbi5jCisrKyBiL3Rvb2xzL3Zob3N0LXVzZXItcnBtYi9tYWlu
LmMKQEAgLTM4LDE1ICszOCwxOSBAQAogCiBzdGF0aWMgZ2NoYXIgKnNvY2tldF9wYXRoOwogc3Rh
dGljIGNoYXIgKmZsYXNoX3BhdGg7CitzdGF0aWMgY2hhciAqa2V5X3BhdGg7CiBzdGF0aWMgZ2lu
dCBzb2NrZXRfZmQgPSAtMTsKIHN0YXRpYyBnYm9vbGVhbiBwcmludF9jYXA7CiBzdGF0aWMgZ2Jv
b2xlYW4gdmVyYm9zZTsKIHN0YXRpYyBnYm9vbGVhbiBkZWJ1ZzsKK3N0YXRpYyBnYm9vbGVhbiBr
ZXlfc2V0OwogCiBzdGF0aWMgR09wdGlvbkVudHJ5IG9wdGlvbnNbXSA9CiB7CiAgICAgeyAic29j
a2V0LXBhdGgiLCAwLCAwLCBHX09QVElPTl9BUkdfRklMRU5BTUUsICZzb2NrZXRfcGF0aCwgIkxv
Y2F0aW9uIG9mIHZob3N0LXVzZXIgVW5peCBkb21haW4gc29ja2V0LCBpbmNvbXBhdGlibGUgd2l0
aCAtLWZkIiwgIlBBVEgiIH0sCiAgICAgeyAiZmxhc2gtcGF0aCIsIDAsIDAsIEdfT1BUSU9OX0FS
R19GSUxFTkFNRSwgJmZsYXNoX3BhdGgsICJMb2NhdGlvbiBvZiByYXcgZmxhc2ggaW1hZ2UgZmls
ZSIsICJQQVRIIiB9LAorICAgIHsgImtleS1wYXRoIiwgMCwgMCwgR19PUFRJT05fQVJHX0ZJTEVO
QU1FLCAma2V5X3BhdGgsICJMb2NhdGlvbiBvZiBwZXJzaXN0ZW50IGtleWZpbGUiLCAiS0VZIn0s
CisgICAgeyAia2V5LXNldCIsIDAsIDAsIEdfT1BUSU9OX0FSR19OT05FLCAma2V5X3NldCwgIklz
IHRoZSBrZXkgYWxyZWFkeSBwcm9ncmFtbWVkIiwgTlVMTH0sCiAgICAgeyAiZmQiLCAwLCAwLCBH
X09QVElPTl9BUkdfSU5ULCAmc29ja2V0X2ZkLCAiU3BlY2lmeSB0aGUgZmlsZS1kZXNjcmlwdG9y
IG9mIHRoZSBiYWNrZW5kLCBpbmNvbXBhdGlibGUgd2l0aCAtLXNvY2tldC1wYXRoIiwgIkZEIiB9
LAogICAgIHsgInByaW50LWNhcGFiaWxpdGllcyIsIDAsIDAsIEdfT1BUSU9OX0FSR19OT05FLCAm
cHJpbnRfY2FwLCAiT3V0cHV0IHRvIHN0ZG91dCB0aGUgYmFja2VuZCBjYXBhYmlsaXRpZXMgaW4g
SlNPTiBmb3JtYXQgYW5kIGV4aXQiLCBOVUxMfSwKICAgICB7ICJ2ZXJib3NlIiwgJ3YnLCAwLCBH
X09QVElPTl9BUkdfTk9ORSwgJnZlcmJvc2UsICJCZSBtb3JlIHZlcmJvc2UgaW4gb3V0cHV0Iiwg
TlVMTH0sCkBAIC0yOTYsOCArMzAwLDE4IEBAIHN0YXRpYyB2b2lkIHZycG1iX2hhbmRsZV9wcm9n
cmFtX2tleShWdURldiAqZGV2LCBzdHJ1Y3QgdmlydGlvX3JwbWJfZnJhbWUgKmZyYW1lCiAgICAg
fSBlbHNlIHsKICAgICAgICAgci0+a2V5ID0gZ19tZW1kdXAoJmZyYW1lLT5rZXlfbWFjWzBdLCBS
UE1CX0tFWV9NQUNfU0laRSk7CiAgICAgICAgIHItPmxhc3RfcmVzdWx0ID0gVklSVElPX1JQTUJf
UkVTX09LOworICAgICAgICBpZiAoa2V5X3BhdGgpIHsKKyAgICAgICAgICAgIEdFcnJvciAqZXJy
ID0gTlVMTDsKKyAgICAgICAgICAgIGlmICghZ19maWxlX3NldF9jb250ZW50cyhrZXlfcGF0aCwg
KGNoYXIgKikgci0+a2V5LAorICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJQ
TUJfS0VZX01BQ19TSVpFLCAmZXJyKSkgeworICAgICAgICAgICAgICAgIGdfd2FybmluZygiJXM6
IHVuYWJsZSB0byBwZXJzaXN0IGtleSBkYXRhIHRvICVzOiAlcyIsCisgICAgICAgICAgICAgICAg
ICAgICAgICAgIF9fZnVuY19fLCBrZXlfcGF0aCwgZXJyLT5tZXNzYWdlKTsKKyAgICAgICAgICAg
ICAgICBnX2Vycm9yX2ZyZWUoZXJyKTsKKyAgICAgICAgICAgIH0KKyAgICAgICAgfQogICAgIH0K
IAorCiAgICAgZ19pbmZvKCIlczogcmVxX3Jlc3AgPSAleCwgcmVzdWx0ID0gJXgiLCBfX2Z1bmNf
XywKICAgICAgICAgICAgci0+bGFzdF9yZXFyZXNwLCByLT5sYXN0X3Jlc3VsdCk7CiAgICAgcmV0
dXJuOwpAQCAtNzA5LDYgKzcyMywyNSBAQCBzdGF0aWMgYm9vbCB2cnBtYl9sb2FkX2ZsYXNoX2lt
YWdlKFZ1UnBtYiAqciwgY2hhciAqaW1nX3BhdGgpCiAgICAgcmV0dXJuIHRydWU7CiB9CiAKK3N0
YXRpYyB2b2lkIHZycG1iX3NldF9rZXkoVnVScG1iICpyLCBjaGFyICprZXlfcGF0aCkKK3sKKyAg
ICBHRXJyb3IgKmVyciA9IE5VTEw7CisgICAgZ3NpemUgbGVuZ3RoOworCisgICAgaWYgKCFnX2Zp
bGVfZ2V0X2NvbnRlbnRzKGtleV9wYXRoLCAoY2hhciAqKikgJnItPmtleSwgJmxlbmd0aCwgJmVy
cikpIHsKKyAgICAgICAgZ19wcmludCgiVW5hYmxlIHRvIHJlYWQgJXM6ICVzIiwga2V5X3BhdGgs
IGVyci0+bWVzc2FnZSk7CisgICAgICAgIGV4aXQoMSk7CisgICAgfQorICAgIGlmIChsZW5ndGgg
PCBSUE1CX0tFWV9NQUNfU0laRSkgeworICAgICAgICBnX3ByaW50KCJrZXkgZmlsZSB0byBzbWFs
bCAlbGQgPCAlZCIsIGxlbmd0aCwgUlBNQl9LRVlfTUFDX1NJWkUpOworICAgICAgICBleGl0KDEp
OworICAgIH0gZWxzZSBpZiAobGVuZ3RoID4gUlBNQl9LRVlfTUFDX1NJWkUpIHsKKyAgICAgICAg
LyogYmVpbmcgdG9vIGJpZyBpc24ndCBmYXRhbCwgd2UganVzdCBpZ25vcmUgdGhlIGV4Y2VzcyAq
LworICAgICAgICBnX3dhcm5pbmcoIiVsZCBieXRlcyBvZiAlcyBpZ25vcmUgKGZpbGUgdG9vIGJp
ZykiLAorICAgICAgICAgICAgICAgICAgbGVuZ3RoIC0gUlBNQl9LRVlfTUFDX1NJWkUsIGtleV9w
YXRoKTsKKyAgICB9Cit9CisKIHN0YXRpYyB2b2lkIHZycG1iX2Rlc3Ryb3koVnVScG1iICpyKQog
ewogICAgIHZ1Z19kZWluaXQoJnItPmRldik7CkBAIC03NjAsNiArNzkzLDEwIEBAIGludCBtYWlu
KGludCBhcmdjLCBjaGFyICphcmd2W10pCiAgICAgICAgIHZycG1iX2xvYWRfZmxhc2hfaW1hZ2Uo
JnJwbWIsIGZsYXNoX3BhdGgpOwogICAgIH0KIAorICAgIGlmIChrZXlfcGF0aCAmJiBrZXlfc2V0
KSB7CisgICAgICAgIHZycG1iX3NldF9rZXkoJnJwbWIsIGtleV9wYXRoKTsKKyAgICB9CisKICAg
ICBpZiAoIXNvY2tldF9wYXRoICYmIHNvY2tldF9mZCA8IDApIHsKICAgICAgICAgZ19wcmludGVy
cigiUGxlYXNlIHNwZWNpZnkgZWl0aGVyIC0tZmQgb3IgLS1zb2NrZXQtcGF0aFxuIik7CiAgICAg
ICAgIGV4aXQoRVhJVF9GQUlMVVJFKTsKLS0gCjIuMjAuMQoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
