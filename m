Return-Path: <SRS0=jbvZ=DC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C19C2C4363D
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 12:59:12 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6767D206DB
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 12:59:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="G/4+NjmM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6767D206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 31EBB87605;
	Fri, 25 Sep 2020 12:59:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wsrEb6AvOea3; Fri, 25 Sep 2020 12:59:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8D88E875D9;
	Fri, 25 Sep 2020 12:59:11 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BC72C0890;
	Fri, 25 Sep 2020 12:59:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0ADC6C0859
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:59:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DF27587607
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:59:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id S16XAzNEyEFx
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:59:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f65.google.com (mail-wr1-f65.google.com
 [209.85.221.65])
 by hemlock.osuosl.org (Postfix) with ESMTPS id A31C3875D9
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:59:08 +0000 (UTC)
Received: by mail-wr1-f65.google.com with SMTP id s12so3477964wrw.11
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 05:59:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=uzbbYkb4NnbTBJGCofcpI1INW2euUpldKIpyeVgpePE=;
 b=G/4+NjmMBCwOaEnAD8G4WHhVWosqSJutwj2jU41+Wz3f+z5Pu+x3w+Apvq4vw/gI6v
 OWEZlnT5uP58hV4MyLlM6VfpFHdnUJ4oqdaUQf4zXdNX3SOuQgljdobicUopdh9+6Ttb
 tXUTPX9pd8fHN81fYhE73C+f0Vr4nbSfPJs/eTSm7mBApwHMwISTgoEUPS1o/1aTGy59
 Ly1MU/lRmWaDwMuBlaDKximatvYG0mrhUzV1I42Ya1KBavcxdPG4gy+D1vTEfCiEcnNY
 0b0zurgjWbBhlZV/04f0ObAWGAtX/EUic+h5M9zvFuDlqSnXZHFaMy2ek4+dRMByrReH
 XEZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=uzbbYkb4NnbTBJGCofcpI1INW2euUpldKIpyeVgpePE=;
 b=aYuOmAFXcvTJwVT32xRtj5fCGqwIDDLLlFUwNxp34A6PRqBfmGXfWBblKKj9VIfMrp
 o5BtZZaaS/NhpEMtHe1I5KeVVTvs3nDYIbDTrCKSuJ7VdEnfZG9pT/ESe1w/34b03ny4
 XBGH3zhUuc9tt1rSzuiycqekFTc7X9aLoW7dHk0I27FJT5rSrMwUHFYZXk4i3LbPLoNh
 +32yzwih5EhKW5zI4NxyBG3J4gPx3+WpizqT4HfOJ4r+6KcFjASHUGz0rKDZQ5HJAMzh
 m2DxiKRn2gSSfrQMpTlX45lRCcZl+lzXFUXH3Z1Skhc/8guGI6cACa1F6UEGQDEOTuYH
 kzWQ==
X-Gm-Message-State: AOAM532BpduTpvWleXQ20RNO2Sotq6yBTxJ5OHMe8zcFrDULxgWEC4p7
 VPkSsRGqZpVnu1PTa28Oog3T/Q==
X-Google-Smtp-Source: ABdhPJy8Ipyz4jx7i9Y+XtUqRtfhW1VyFR6m8SCZSQPxBY5fr63M/xHX3v8k/G7hF1I7i6WrR75kfg==
X-Received: by 2002:a5d:4645:: with SMTP id j5mr4392648wrs.230.1601038747151; 
 Fri, 25 Sep 2020 05:59:07 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id a17sm3054427wra.24.2020.09.25.05.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:59:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id B5F5C1FF9F;
 Fri, 25 Sep 2020 13:51:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH 16/19] tools/vhost-user-rpmb: implement
 VIRTIO_RPMB_REQ_DATA_READ
Date: Fri, 25 Sep 2020 13:51:44 +0100
Message-Id: <20200925125147.26943-17-alex.bennee@linaro.org>
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

VGhlIHJlYWQgY29tbWFuZCBpcyBhIGxvdCBzaW1wbGVyIHRvIGltcGxlbWVudC4gSG93ZXZlciB0
aGUgc3BlYyBkb2VzCnNwZWNpZnkgeW91IGNhbiBvbmx5IHJlYWQgYSBzaW5nbGUgYmxvY2sgYXQg
YSB0aW1lIHNvIHdlIGxpbWl0IGl0IHRvCnRoYXQuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IEJlbm7D
qWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+Ci0tLQogdG9vbHMvdmhvc3QtdXNlci1ycG1iL21h
aW4uYyB8IDUyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMSBmaWxlIGNo
YW5nZWQsIDUyIGluc2VydGlvbnMoKykKCmRpZmYgLS1naXQgYS90b29scy92aG9zdC11c2VyLXJw
bWIvbWFpbi5jIGIvdG9vbHMvdmhvc3QtdXNlci1ycG1iL21haW4uYwppbmRleCBhMTdjM2I0YmNj
NGUuLjQ5ZDRlMDBiMjRhOSAxMDA2NDQKLS0tIGEvdG9vbHMvdmhvc3QtdXNlci1ycG1iL21haW4u
YworKysgYi90b29scy92aG9zdC11c2VyLXJwbWIvbWFpbi5jCkBAIC00MTQsNiArNDE0LDU1IEBA
IHN0YXRpYyBpbnQgdnJwbWJfaGFuZGxlX3dyaXRlKFZ1RGV2ICpkZXYsIHN0cnVjdCB2aXJ0aW9f
cnBtYl9mcmFtZSAqZnJhbWUpCiAgICAgcmV0dXJuIGV4dHJhX2ZyYW1lczsKIH0KIAorLyoKKyAq
IHZycG1iX2hhbmRsZV9yZWFkOgorICoKKyAqIFVubGlrZSB0aGUgd3JpdGUgb3BlcmF0aW9uIHdl
IHJldHVybiBhIGZyYW1lIHdpdGggdGhlIHJlc3VsdCBvZiB0aGUKKyAqIHJlYWQgaGVyZS4gV2hp
bGUgdGhlIGNvbmZpZyBzcGVjaWZpZXMgYSBtYXhpbXVtIHJlYWQgY291bnQgdGhlIHNwZWMKKyAq
IGlzIGxpbWl0ZWQgdG8gYSBzaW5nbGUgcmVhZCBhdCBhIHRpbWUuCisgKi8KK3N0YXRpYyBzdHJ1
Y3QgdmlydGlvX3JwbWJfZnJhbWUgKgordnJwbWJfaGFuZGxlX3JlYWQoVnVEZXYgKmRldiwgc3Ry
dWN0IHZpcnRpb19ycG1iX2ZyYW1lICpmcmFtZSkKK3sKKyAgICBWdVJwbWIgKnIgPSBjb250YWlu
ZXJfb2YoZGV2LCBWdVJwbWIsIGRldi5wYXJlbnQpOworICAgIHNpemVfdCBvZmZzZXQgPSBiZTE2
dG9oKGZyYW1lLT5hZGRyZXNzKSAqIFJQTUJfQkxPQ0tfU0laRTsKKyAgICB1aW50MTZfdCBibG9j
a19jb3VudCA9IGJlMTZ0b2goZnJhbWUtPmJsb2NrX2NvdW50KTsKKyAgICBzdHJ1Y3QgdmlydGlv
X3JwbWJfZnJhbWUgKnJlc3AgPSBnX25ldzAoc3RydWN0IHZpcnRpb19ycG1iX2ZyYW1lLCAxKTsK
KworICAgIHJlc3AtPnJlcV9yZXNwID0gaHRvYmUxNihWSVJUSU9fUlBNQl9SRVNQX0RBVEFfUkVB
RCk7CisgICAgcmVzcC0+YWRkcmVzcyA9IGZyYW1lLT5hZGRyZXNzOworICAgIHJlc3AtPmJsb2Nr
X2NvdW50ID0gaHRvYmUxNigxKTsKKworICAgIC8qCisgICAgICogUnVuIHRoZSBjaGVja3MgZnJv
bToKKyAgICAgKiA1LjEyLjYuMS40IERldmljZSBSZXF1aXJlbWVudHM6IERldmljZSBPcGVyYXRp
b246IERhdGEgUmVhZAorICAgICAqLworICAgIGlmICghci0+a2V5KSB7CisgICAgICAgIGdfd2Fy
bmluZygibm8ga2V5IHByb2dyYW1tZWQiKTsKKyAgICAgICAgcmVzcC0+cmVzdWx0ID0gaHRvYmUx
NihWSVJUSU9fUlBNQl9SRVNfTk9fQVVUSF9LRVkpOworICAgIH0gZWxzZSBpZiAoYmxvY2tfY291
bnQgIT0gMSkgeworICAgICAgICAvKgorICAgICAgICAgKiBEZXNwaXRlIHRoZSBjb25maWcgdGhl
IHNwZWMgb25seSBhbGxvd3MgZm9yIHJlYWRpbmcgb25lCisgICAgICAgICAqIGJsb2NrIGF0IGEg
dGltZTogIklmIGJsb2NrIGNvdW50IGhhcyBub3QgYmVlbiBzZXQgdG8gMSB0aGVuCisgICAgICAg
ICAqIFZJUlRJT19SUE1CX1JFU19HRU5FUkFMX0ZBSUxVUkUgU0hPVUxEIGJlIHJlc3BvbmRlZCBh
cworICAgICAgICAgKiByZXN1bHQuIgorICAgICAgICAgKi8KKyAgICAgICAgcmVzcC0+cmVzdWx0
ID0gaHRvYmUxNihWSVJUSU9fUlBNQl9SRVNfR0VORVJBTF9GQUlMVVJFKTsKKyAgICB9IGVsc2Ug
aWYgKG9mZnNldCA+IChyLT52aXJ0aW9fY29uZmlnLmNhcGFjaXR5ICogKDEyOCAqIEtpQikpKSB7
CisgICAgICAgIHJlc3AtPnJlc3VsdCA9IGh0b2JlMTYoVklSVElPX1JQTUJfUkVTX0FERFJfRkFJ
TFVSRSk7CisgICAgfSBlbHNlIHsKKyAgICAgICAgdm9pZCAqYmxrID0gci0+Zmxhc2hfbWFwICsg
b2Zmc2V0OworICAgICAgICBnX2RlYnVnKCIlczogcmVhZGluZyBibG9jayBmcm9tICVwICglenUp
IiwgX19mdW5jX18sIGJsaywgb2Zmc2V0KTsKKyAgICAgICAgbWVtY3B5KHJlc3AtPmRhdGEsIGJs
aywgUlBNQl9CTE9DS19TSVpFKTsKKyAgICAgICAgcmVzcC0+cmVzdWx0ID0gaHRvYmUxNihWSVJU
SU9fUlBNQl9SRVNfT0spOworICAgIH0KKworICAgIC8qIEZpbmFsIGhvdXNla2VlcGluZywgY29w
eSBub25jZSBhbmQgY2FsY3VsYXRlIE1BQyAqLworICAgIG1lbWNweSgmcmVzcC0+bm9uY2UsICZm
cmFtZS0+bm9uY2UsIHNpemVvZihmcmFtZS0+bm9uY2UpKTsKKyAgICB2cnBtYl91cGRhdGVfbWFj
X2luX2ZyYW1lKHIsIHJlc3ApOworCisgICAgcmV0dXJuIHJlc3A7Cit9CiAKIC8qCiAgKiBSZXR1
cm4gdGhlIHJlc3VsdCBvZiB0aGUgbGFzdCBtZXNzYWdlLiBUaGlzIGlzIG9ubHkgdmFsaWQgaWYg
dGhlCkBAIC01NDQsNiArNTkzLDkgQEAgdnJwbWJfaGFuZGxlX2N0cmwoVnVEZXYgKmRldiwgaW50
IHFpZHgpCiAgICAgICAgICAgICAgICAgLyogd2UgY2FuIGhhdmUgbXVsdGlwbGUgYmxvY2tzIGhh
bmRsZWQgKi8KICAgICAgICAgICAgICAgICBuICs9IHZycG1iX2hhbmRsZV93cml0ZShkZXYsIGYp
OwogICAgICAgICAgICAgICAgIGJyZWFrOworICAgICAgICAgICAgY2FzZSBWSVJUSU9fUlBNQl9S
RVFfREFUQV9SRUFEOgorICAgICAgICAgICAgICAgIHJlc3AgPSB2cnBtYl9oYW5kbGVfcmVhZChk
ZXYsIGYpOworICAgICAgICAgICAgICAgIGJyZWFrOwogICAgICAgICAgICAgZGVmYXVsdDoKICAg
ICAgICAgICAgICAgICBnX2RlYnVnKCJ1bi1oYW5kbGVkIHJlcXVlc3Q6ICV4IiwgZi0+cmVxX3Jl
c3ApOwogICAgICAgICAgICAgICAgIGJyZWFrOwotLSAKMi4yMC4xCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
