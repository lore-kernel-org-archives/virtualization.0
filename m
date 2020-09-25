Return-Path: <SRS0=jbvZ=DC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5B70C4727C
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 12:51:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 474A3206DB
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 12:51:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="DFsHI2Wr"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 474A3206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id CD26487526;
	Fri, 25 Sep 2020 12:51:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xD8tMXUOKfCJ; Fri, 25 Sep 2020 12:51:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 17D98874A4;
	Fri, 25 Sep 2020 12:51:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE0F2C0890;
	Fri, 25 Sep 2020 12:51:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E8EB3C0890
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:51:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id E4CFA874A4
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:51:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SOoVrrwzJrNP
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:51:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com
 [209.85.128.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BB64487143
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:51:52 +0000 (UTC)
Received: by mail-wm1-f65.google.com with SMTP id x23so2926595wmi.3
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 05:51:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=eP8IRx33KYKqoe6PrhN3NXzNGwmBRsBzrSybQmnNqbM=;
 b=DFsHI2WrX2bvmPvaYzx4q3vrYDT3aD10kqia+n0n0cLkhAIQvGH7BcatBmpMUgdH5Z
 tHtEcmi5oA67VPWMPu+54In/VSaVz3SExTkDelbfjLCOL4rkSQdwVk7sMi4aTToGZCWn
 YJqrYzAJpGoLzHrmExztamoCKN8ljmDo4w4secV3sIhM7L9BTvQi+qm9lWxgFdUfWTdk
 gThM7iCy2G4HkIC6i+xJsT1NPFpiS/w6kdTjUM5Bh+gVEK4SDZVZtP9gfpZOMDL8JxQl
 1AlTzKKoQJaJIZvWTfe/QS4t3+d15isKpHamSbCggX+cCvCh9nx3803zr+eyrSa/f+/H
 wphw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=eP8IRx33KYKqoe6PrhN3NXzNGwmBRsBzrSybQmnNqbM=;
 b=qmfLClViDmGjGoo9EVkXebmK5bxB1WWg5/4zu9OkFvd9VgGMDjeZ19QmEchWYsuw6d
 RrxTFcKupxOFZnN4W+v7r8SmamQpm/7P0CxVYX+ugWfm/uoOsjdAyF1SUo99BX7tVS+P
 OuQh3Ztdq6CmdoXS6/HcQbaLpQ8j2oDvdCX+BUWO/1Fx2LRswNUI+xP+kLFkUZMllyaI
 rMF5zm5C1bygKaLyJP2Xxeb09vHNJB8JoeFOdLSOgB4evNpiFR7i0WSJuMt/Co7v3XXQ
 DxifkN41JwrT7a71qWLRLjWb05sq/XapqUBIywizeQrjqJpEq2bK8mbfgQwBVXmUmvDx
 mHbg==
X-Gm-Message-State: AOAM532+dIvU1YacH/ulCAHD2MLSnPMz126zpN/KyUh5o6hjZOT98isQ
 Rplf4zgC8qAFz2JEfkSNANxpHw==
X-Google-Smtp-Source: ABdhPJzqvbmnlt8MESPNUh64kjEJicRNegOyt85mThr8I355eHjzgmjl6Y8OMw0PQM5x3EQSbbn+HQ==
X-Received: by 2002:a1c:4e08:: with SMTP id g8mr2952305wmh.53.1601038311085;
 Fri, 25 Sep 2020 05:51:51 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id u66sm2766046wme.12.2020.09.25.05.51.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:51:48 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 1DD701FF87;
 Fri, 25 Sep 2020 13:51:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH  01/19] tools/virtiofsd: add support for --socket-group
Date: Fri, 25 Sep 2020 13:51:29 +0100
Message-Id: <20200925125147.26943-2-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925125147.26943-1-alex.bennee@linaro.org>
References: <20200925125147.26943-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Cc: jean-philippe@linaro.org, "Dr. David Alan Gilbert" <dgilbert@redhat.com>,
 takahiro.akashi@linaro.org, Stefan Hajnoczi <stefanha@redhat.com>,
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

SWYgeW91IGxpa2UgcnVubmluZyBRRU1VIGFzIGEgbm9ybWFsIHVzZXIgKHZlcnkgY29tbW9uIGZv
ciBUQ0cgcnVucykKYnV0IHlvdSBoYXZlIHRvIHJ1biB2aXJ0aW9mc2QgYXMgYSByb290IHVzZXIg
eW91IHJ1biBpbnRvIGNvbm5lY3Rpb24KcHJvYmxlbXMuIEFkZGluZyBzdXBwb3J0IGZvciBhbiBv
cHRpb25hbCAtLXNvY2tldC1ncm91cCBhbGxvd3MgdGhlCnVzZXJzIHRvIGtlZXAgdXNpbmcgdGhl
IGNvbW1hbmQgbGluZS4KClNpZ25lZC1vZmYtYnk6IEFsZXggQmVubsOpZSA8YWxleC5iZW5uZWVA
bGluYXJvLm9yZz4KUmV2aWV3ZWQtYnk6IFN0ZWZhbiBIYWpub2N6aSA8c3RlZmFuaGFAcmVkaGF0
LmNvbT4KCi0tLQp2MQogIC0gdHdlYWsgZG9jdW1lbnRhdGlvbiBhbmQgY29tbWVudGFyeQotLS0K
IGRvY3MvdG9vbHMvdmlydGlvZnNkLnJzdCAgICAgICAgfCAgNCArKysrCiB0b29scy92aXJ0aW9m
c2QvZnVzZV9pLmggICAgICAgIHwgIDEgKwogdG9vbHMvdmlydGlvZnNkL2Z1c2VfbG93bGV2ZWwu
YyB8ICA2ICsrKysrKwogdG9vbHMvdmlydGlvZnNkL2Z1c2VfdmlydGlvLmMgICB8IDIwICsrKysr
KysrKysrKysrKysrKy0tCiA0IGZpbGVzIGNoYW5nZWQsIDI5IGluc2VydGlvbnMoKyksIDIgZGVs
ZXRpb25zKC0pCgpkaWZmIC0tZ2l0IGEvZG9jcy90b29scy92aXJ0aW9mc2QucnN0IGIvZG9jcy90
b29scy92aXJ0aW9mc2QucnN0CmluZGV4IGUzM2M4MWVkNDFmMS4uMDg1ZjliMTJhNmEzIDEwMDY0
NAotLS0gYS9kb2NzL3Rvb2xzL3ZpcnRpb2ZzZC5yc3QKKysrIGIvZG9jcy90b29scy92aXJ0aW9m
c2QucnN0CkBAIC04Nyw2ICs4NywxMCBAQCBPcHRpb25zCiAKICAgTGlzdGVuIG9uIHZob3N0LXVz
ZXIgVU5JWCBkb21haW4gc29ja2V0IGF0IFBBVEguCiAKKy4uIG9wdGlvbjo6IC0tc29ja2V0LWdy
b3VwPUdST1VQCisKKyAgU2V0IHRoZSB2aG9zdC11c2VyIFVOSVggZG9tYWluIHNvY2tldCBnaWQg
dG8gR1JPVVAuCisKIC4uIG9wdGlvbjo6IC0tZmQ9RkROVU0KIAogICBBY2NlcHQgY29ubmVjdGlv
bnMgZnJvbSB2aG9zdC11c2VyIFVOSVggZG9tYWluIHNvY2tldCBmaWxlIGRlc2NyaXB0b3IgRkRO
VU0uCmRpZmYgLS1naXQgYS90b29scy92aXJ0aW9mc2QvZnVzZV9pLmggYi90b29scy92aXJ0aW9m
c2QvZnVzZV9pLmgKaW5kZXggMTI0MDgyODIwOGFiLi40OTJlMDAyMTgxZTIgMTAwNjQ0Ci0tLSBh
L3Rvb2xzL3ZpcnRpb2ZzZC9mdXNlX2kuaAorKysgYi90b29scy92aXJ0aW9mc2QvZnVzZV9pLmgK
QEAgLTY4LDYgKzY4LDcgQEAgc3RydWN0IGZ1c2Vfc2Vzc2lvbiB7CiAgICAgc2l6ZV90IGJ1ZnNp
emU7CiAgICAgaW50IGVycm9yOwogICAgIGNoYXIgKnZ1X3NvY2tldF9wYXRoOworICAgIGNoYXIg
KnZ1X3NvY2tldF9ncm91cDsKICAgICBpbnQgICB2dV9saXN0ZW5fZmQ7CiAgICAgaW50ICAgdnVf
c29ja2V0ZmQ7CiAgICAgc3RydWN0IGZ2X1Z1RGV2ICp2aXJ0aW9fZGV2OwpkaWZmIC0tZ2l0IGEv
dG9vbHMvdmlydGlvZnNkL2Z1c2VfbG93bGV2ZWwuYyBiL3Rvb2xzL3ZpcnRpb2ZzZC9mdXNlX2xv
d2xldmVsLmMKaW5kZXggMmRkMzZlYzAzYjZlLi40ZDFiYTI5MjVkMWIgMTAwNjQ0Ci0tLSBhL3Rv
b2xzL3ZpcnRpb2ZzZC9mdXNlX2xvd2xldmVsLmMKKysrIGIvdG9vbHMvdmlydGlvZnNkL2Z1c2Vf
bG93bGV2ZWwuYwpAQCAtMjUyMyw2ICsyNTIzLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBmdXNl
X29wdCBmdXNlX2xsX29wdHNbXSA9IHsKICAgICBMTF9PUFRJT04oIi0tZGVidWciLCBkZWJ1Zywg
MSksCiAgICAgTExfT1BUSU9OKCJhbGxvd19yb290IiwgZGVueV9vdGhlcnMsIDEpLAogICAgIExM
X09QVElPTigiLS1zb2NrZXQtcGF0aD0lcyIsIHZ1X3NvY2tldF9wYXRoLCAwKSwKKyAgICBMTF9P
UFRJT04oIi0tc29ja2V0LWdyb3VwPSVzIiwgdnVfc29ja2V0X2dyb3VwLCAwKSwKICAgICBMTF9P
UFRJT04oIi0tZmQ9JWQiLCB2dV9saXN0ZW5fZmQsIDApLAogICAgIExMX09QVElPTigiLS10aHJl
YWQtcG9vbC1zaXplPSVkIiwgdGhyZWFkX3Bvb2xfc2l6ZSwgMCksCiAgICAgRlVTRV9PUFRfRU5E
CkBAIC0yNjMwLDYgKzI2MzEsMTEgQEAgc3RydWN0IGZ1c2Vfc2Vzc2lvbiAqZnVzZV9zZXNzaW9u
X25ldyhzdHJ1Y3QgZnVzZV9hcmdzICphcmdzLAogICAgICAgICAgICAgICAgICAiZnVzZTogLS1z
b2NrZXQtcGF0aCBhbmQgLS1mZCBjYW5ub3QgYmUgZ2l2ZW4gdG9nZXRoZXJcbiIpOwogICAgICAg
ICBnb3RvIG91dDQ7CiAgICAgfQorICAgIGlmIChzZS0+dnVfc29ja2V0X2dyb3VwICYmICFzZS0+
dnVfc29ja2V0X3BhdGgpIHsKKyAgICAgICAgZnVzZV9sb2coRlVTRV9MT0dfRVJSLAorICAgICAg
ICAgICAgICAgICAiZnVzZTogLS1zb2NrZXQtZ3JvdXAgY2FuIG9ubHkgYmUgdXNlZCB3aXRoIC0t
c29ja2V0LXBhdGhcbiIpOworICAgICAgICBnb3RvIG91dDQ7CisgICAgfQogCiAgICAgc2UtPmJ1
ZnNpemUgPSBGVVNFX01BWF9NQVhfUEFHRVMgKiBnZXRwYWdlc2l6ZSgpICsgRlVTRV9CVUZGRVJf
SEVBREVSX1NJWkU7CiAKZGlmZiAtLWdpdCBhL3Rvb2xzL3ZpcnRpb2ZzZC9mdXNlX3ZpcnRpby5j
IGIvdG9vbHMvdmlydGlvZnNkL2Z1c2VfdmlydGlvLmMKaW5kZXggOWU1NTM3NTA2YzE2Li43OTQy
ZDNkMTFhODcgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3ZpcnRpb2ZzZC9mdXNlX3ZpcnRpby5jCisrKyBi
L3Rvb2xzL3ZpcnRpb2ZzZC9mdXNlX3ZpcnRpby5jCkBAIC0zMSw2ICszMSw4IEBACiAjaW5jbHVk
ZSA8c3lzL3NvY2tldC5oPgogI2luY2x1ZGUgPHN5cy90eXBlcy5oPgogI2luY2x1ZGUgPHN5cy91
bi5oPgorI2luY2x1ZGUgPHN5cy90eXBlcy5oPgorI2luY2x1ZGUgPGdycC5oPgogI2luY2x1ZGUg
PHVuaXN0ZC5oPgogCiAjaW5jbHVkZSAiY29udHJpYi9saWJ2aG9zdC11c2VyL2xpYnZob3N0LXVz
ZXIuaCIKQEAgLTkyNCwxNSArOTI2LDI5IEBAIHN0YXRpYyBpbnQgZnZfY3JlYXRlX2xpc3Rlbl9z
b2NrZXQoc3RydWN0IGZ1c2Vfc2Vzc2lvbiAqc2UpCiAKICAgICAvKgogICAgICAqIFVuZm9ydHVu
YXRlbHkgYmluZCBkb2Vzbid0IGxldCB5b3Ugc2V0IHRoZSBtYXNrIG9uIHRoZSBzb2NrZXQsCi0g
ICAgICogc28gc2V0IHVtYXNrIHRvIDA3NyBhbmQgcmVzdG9yZSBpdCBsYXRlci4KKyAgICAgKiBz
byBzZXQgdW1hc2sgYXBwcm9wcmlhdGVseSBhbmQgcmVzdG9yZSBpdCBsYXRlci4KICAgICAgKi8K
LSAgICBvbGRfdW1hc2sgPSB1bWFzaygwMDc3KTsKKyAgICBpZiAoc2UtPnZ1X3NvY2tldF9ncm91
cCkgeworICAgICAgICBvbGRfdW1hc2sgPSB1bWFzayhTX0lST1RIIHwgU19JV09USCB8IFNfSVhP
VEgpOworICAgIH0gZWxzZSB7CisgICAgICAgIG9sZF91bWFzayA9IHVtYXNrKFNfSVJHUlAgfCBT
X0lXR1JQIHwgU19JWEdSUCB8IFNfSVJPVEggfCBTX0lXT1RIIHwgU19JWE9USCk7CisgICAgfQog
ICAgIGlmIChiaW5kKGxpc3Rlbl9zb2NrLCAoc3RydWN0IHNvY2thZGRyICopJnVuLCBhZGRyX2xl
bikgPT0gLTEpIHsKICAgICAgICAgZnVzZV9sb2coRlVTRV9MT0dfRVJSLCAidmhvc3Qgc29ja2V0
IGJpbmQ6ICVtXG4iKTsKICAgICAgICAgY2xvc2UobGlzdGVuX3NvY2spOwogICAgICAgICB1bWFz
ayhvbGRfdW1hc2spOwogICAgICAgICByZXR1cm4gLTE7CiAgICAgfQorICAgIGlmIChzZS0+dnVf
c29ja2V0X2dyb3VwKSB7CisgICAgICAgIHN0cnVjdCBncm91cCAqZyA9IGdldGdybmFtKHNlLT52
dV9zb2NrZXRfZ3JvdXApOworICAgICAgICBpZiAoZykgeworICAgICAgICAgICAgaWYgKCFjaG93
bihzZS0+dnVfc29ja2V0X3BhdGgsIC0xLCBnLT5ncl9naWQpKSB7CisgICAgICAgICAgICAgICAg
ZnVzZV9sb2coRlVTRV9MT0dfV0FSTklORywKKyAgICAgICAgICAgICAgICAgICAgICAgICAidmhv
c3Qgc29ja2V0IGZhaWxlZCB0byBzZXQgZ3JvdXAgdG8gJXMgKCVkKVxuIiwKKyAgICAgICAgICAg
ICAgICAgICAgICAgICBzZS0+dnVfc29ja2V0X2dyb3VwLCBnLT5ncl9naWQpOworICAgICAgICAg
ICAgfQorICAgICAgICB9CisgICAgfQogICAgIHVtYXNrKG9sZF91bWFzayk7CiAKICAgICBpZiAo
bGlzdGVuKGxpc3Rlbl9zb2NrLCAxKSA9PSAtMSkgewotLSAKMi4yMC4xCgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
