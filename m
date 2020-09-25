Return-Path: <SRS0=jbvZ=DC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB281C4727C
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 12:52:17 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 446AF206DB
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 12:52:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="PLLxusxh"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 446AF206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 119DD86CAF;
	Fri, 25 Sep 2020 12:52:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pge8IKmtcWKE; Fri, 25 Sep 2020 12:52:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 2B27586AD0;
	Fri, 25 Sep 2020 12:52:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1619EC1AD5;
	Fri, 25 Sep 2020 12:52:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 129ADC0859
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:52:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EBBF320474
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:52:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n85lMz1q8MhX
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:52:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f68.google.com (mail-wm1-f68.google.com
 [209.85.128.68])
 by silver.osuosl.org (Postfix) with ESMTPS id 58F482E148
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:52:08 +0000 (UTC)
Received: by mail-wm1-f68.google.com with SMTP id v12so3166767wmh.3
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 05:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=DYHqy58UJZR46wXpvs59hJagcJIqgUuvxLRDNUapKkI=;
 b=PLLxusxhPFqPGcofHMPBU7+IrVX7cQrLqgbuFwawPTVl20xOtV1nU3phv+B+iZ4AHa
 g6keJCPtstcNtkR9uvaZR6JJFaC+CjknldAUPdPCKsKEqqQdWg7LQ/K64hl5HabyR+I2
 XSZC8zZAAoQbmjDZS9YNLV94KZuLi3xRHX0VLG/Fck6PAhVxCTdnu5nWkj+h3JthSgFt
 /DM5h3kfoW2vgHw+PVqreYUPDkb5qTvo2xXHv7fcmFtCsNdZ/1Wv5+Bqip7AwK31O8Vt
 TwzJnYZQXcWYdG2MOygKPCTZz2aVxUEYC/IWxxydBRUNyRiC7pnfkoDkJoL/Yb8CwfVz
 LUDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=DYHqy58UJZR46wXpvs59hJagcJIqgUuvxLRDNUapKkI=;
 b=BRqTQjevx+5uUtfwlB/9k0VdTeUnumw2R5dyecEVbqFtOoQsQfjek+4uZKK43mr/IN
 +7qnrTUtpchgn0DcSr+h7jc0ipPAhKlxGFuNev1A5rQrky8TJRFjDJYsC40cz7CSeRy4
 GD7pqPrORpceQNj3RjTGNDN2E2qpvZAEVrviMnoRqXfjCnkcc2KUOqmq6fcQzPNVQl3S
 5SJWRb7kve1NVGGI0WvBhTg36jE8mKav5g6hw4STrHw9duGRpMX7RQ5abRUar4rvq0UA
 zKXzcfe6IL4OcsVYIpqSfCPGBPdd3neaJnz+Btyg51IVzOx3N251LoL3Oyc9Q3Ajv/mp
 nqVQ==
X-Gm-Message-State: AOAM531ZBTt6Stfc+lJM1VQDd+156dsnO6KnTKlOy3+MrFe6hENqvEDv
 gw8MwX3xodnVKvKAPHSeeFbKWg==
X-Google-Smtp-Source: ABdhPJzzqmM6H2FagwjjJuJz8oyzXp/4kjhdAn5abuNmGND89rNn/daHMZEIYFS4dnMv23kcecepaA==
X-Received: by 2002:a1c:4455:: with SMTP id r82mr2957959wma.60.1601038326726; 
 Fri, 25 Sep 2020 05:52:06 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id m12sm2708543wml.38.2020.09.25.05.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:52:00 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 173971FF98;
 Fri, 25 Sep 2020 13:51:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH 09/19] tools/vhost-user-rpmb: add a --verbose/debug flags
 for logging
Date: Fri, 25 Sep 2020 13:51:37 +0100
Message-Id: <20200925125147.26943-10-alex.bennee@linaro.org>
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

VGhpcyBnaXZlcyB1cyB0d28gbGV2ZWxzIG9mIGluZm9ybWF0aW9uYWwgb3V0cHV0IHdoZW4gdHJh
Y2luZyB3aGF0IHRoZQpkYWVtb24gaXMgZG9pbmcuCgpTaWduZWQtb2ZmLWJ5OiBBbGV4IEJlbm7D
qWUgPGFsZXguYmVubmVlQGxpbmFyby5vcmc+Ci0tLQogdG9vbHMvdmhvc3QtdXNlci1ycG1iL21h
aW4uYyB8IDE5ICsrKysrKysrKysrKysrKysrKysKIDEgZmlsZSBjaGFuZ2VkLCAxOSBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvdG9vbHMvdmhvc3QtdXNlci1ycG1iL21haW4uYyBiL3Rvb2xz
L3Zob3N0LXVzZXItcnBtYi9tYWluLmMKaW5kZXggMjY5Yzg2Y2JiNjMzLi4xYmUwZDRiOGE1Njcg
MTAwNjQ0Ci0tLSBhL3Rvb2xzL3Zob3N0LXVzZXItcnBtYi9tYWluLmMKKysrIGIvdG9vbHMvdmhv
c3QtdXNlci1ycG1iL21haW4uYwpAQCAtNiw2ICs2LDkgQEAKICAqIFNQRFgtTGljZW5zZS1JZGVu
dGlmaWVyOiBHUEwtMi4wLW9yLWxhdGVyCiAgKi8KIAorI2RlZmluZSBHX0xPR19ET01BSU4gInZo
b3N0LXVzZXItcnBtYiIKKyNkZWZpbmUgR19MT0dfVVNFX1NUUlVDVFVSRUQgMQorCiAjaW5jbHVk
ZSA8Z2xpYi5oPgogI2luY2x1ZGUgPGdpby9naW8uaD4KICNpbmNsdWRlIDxnaW8vZ3VuaXhzb2Nr
ZXRhZGRyZXNzLmg+CkBAIC0yNSwxMiArMjgsMTYgQEAKIHN0YXRpYyBnY2hhciAqc29ja2V0X3Bh
dGg7CiBzdGF0aWMgZ2ludCBzb2NrZXRfZmQgPSAtMTsKIHN0YXRpYyBnYm9vbGVhbiBwcmludF9j
YXA7CitzdGF0aWMgZ2Jvb2xlYW4gdmVyYm9zZTsKK3N0YXRpYyBnYm9vbGVhbiBkZWJ1ZzsKIAog
c3RhdGljIEdPcHRpb25FbnRyeSBvcHRpb25zW10gPQogewogICAgIHsgInNvY2tldC1wYXRoIiwg
MCwgMCwgR19PUFRJT05fQVJHX0ZJTEVOQU1FLCAmc29ja2V0X3BhdGgsICJMb2NhdGlvbiBvZiB2
aG9zdC11c2VyIFVuaXggZG9tYWluIHNvY2tldCwgaW5jb21wYXRpYmxlIHdpdGggLS1mZCIsICJQ
QVRIIiB9LAogICAgIHsgImZkIiwgMCwgMCwgR19PUFRJT05fQVJHX0lOVCwgJnNvY2tldF9mZCwg
IlNwZWNpZnkgdGhlIGZpbGUtZGVzY3JpcHRvciBvZiB0aGUgYmFja2VuZCwgaW5jb21wYXRpYmxl
IHdpdGggLS1zb2NrZXQtcGF0aCIsICJGRCIgfSwKICAgICB7ICJwcmludC1jYXBhYmlsaXRpZXMi
LCAwLCAwLCBHX09QVElPTl9BUkdfTk9ORSwgJnByaW50X2NhcCwgIk91dHB1dCB0byBzdGRvdXQg
dGhlIGJhY2tlbmQgY2FwYWJpbGl0aWVzIGluIEpTT04gZm9ybWF0IGFuZCBleGl0IiwgTlVMTH0s
CisgICAgeyAidmVyYm9zZSIsICd2JywgMCwgR19PUFRJT05fQVJHX05PTkUsICZ2ZXJib3NlLCAi
QmUgbW9yZSB2ZXJib3NlIGluIG91dHB1dCIsIE5VTEx9LAorICAgIHsgImRlYnVnIiwgMCwgMCwg
R19PUFRJT05fQVJHX05PTkUsICZkZWJ1ZywgIkluY2x1ZGUgZGVidWcgb3V0cHV0IiwgTlVMTH0s
CiAgICAgeyBOVUxMIH0KIH07CiAKQEAgLTg0LDYgKzkxLDcgQEAgc3RhdGljIHZvaWQgdnJwbWJf
cGFuaWMoVnVEZXYgKmRldiwgY29uc3QgY2hhciAqbXNnKQogCiBzdGF0aWMgdWludDY0X3QgdnJw
bWJfZ2V0X2ZlYXR1cmVzKFZ1RGV2ICpkZXYpCiB7CisgICAgZ19pbmZvKCIlczogcmVwbHlpbmci
LCBfX2Z1bmNfXyk7CiAgICAgcmV0dXJuIDA7CiB9CiAKQEAgLTIwOSw2ICsyMTcsMTcgQEAgaW50
IG1haW4gKGludCBhcmdjLCBjaGFyICphcmd2W10pCiAgICAgICAgIGV4aXQoRVhJVF9GQUlMVVJF
KTsKICAgICB9CiAKKyAgICBpZiAodmVyYm9zZSB8fCBkZWJ1ZykgeworICAgICAgICBnX2xvZ19z
ZXRfaGFuZGxlcihOVUxMLCBHX0xPR19MRVZFTF9NQVNLLCBnX2xvZ19kZWZhdWx0X2hhbmRsZXIs
IE5VTEwpOworICAgICAgICBpZiAoZGVidWcpIHsKKyAgICAgICAgICAgIGdfc2V0ZW52KCJHX01F
U1NBR0VTX0RFQlVHIiwgImFsbCIsIHRydWUpOworICAgICAgICB9CisgICAgfSBlbHNlIHsKKyAg
ICAgICAgZ19sb2dfc2V0X2hhbmRsZXIoTlVMTCwKKyAgICAgICAgICAgICAgICAgICAgICAgICAg
R19MT0dfTEVWRUxfV0FSTklORyB8IEdfTE9HX0xFVkVMX0NSSVRJQ0FMIHwgR19MT0dfTEVWRUxf
RVJST1IsCisgICAgICAgICAgICAgICAgICAgICAgICAgIGdfbG9nX2RlZmF1bHRfaGFuZGxlciwg
TlVMTCk7CisgICAgfQorCiAgICAgLyoKICAgICAgKiBOb3cgY3JlYXRlIGEgdmhvc3QtdXNlciBz
b2NrZXQgdGhhdCB3ZSB3aWxsIHJlY2VpdmUgbWVzc2FnZXMKICAgICAgKiBvbi4gT25jZSB3ZSBo
YXZlIG91ciBoYW5kbGVyIHNldCB1cCB3ZSBjYW4gZW50ZXIgdGhlIGdsaWIgbWFpbgotLSAKMi4y
MC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
