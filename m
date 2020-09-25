Return-Path: <SRS0=jbvZ=DC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75B0AC4727D
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 12:59:17 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 17A2B206DB
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 12:59:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="rFOBI8Z/"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 17A2B206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id C3C398760E;
	Fri, 25 Sep 2020 12:59:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id d3PrJHY8tY3i; Fri, 25 Sep 2020 12:59:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3861787609;
	Fri, 25 Sep 2020 12:59:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30641C1AD5;
	Fri, 25 Sep 2020 12:59:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF633C0859
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:59:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 9F00686AF2
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:59:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8OXA2YVt1UZy
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:59:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f68.google.com (mail-wr1-f68.google.com
 [209.85.221.68])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id B60BC86AD0
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:59:14 +0000 (UTC)
Received: by mail-wr1-f68.google.com with SMTP id s12so3478323wrw.11
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 05:59:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=kjcelvvovVPpABaKJSYVdSxl5UaJWqhfw0gOadK/FqU=;
 b=rFOBI8Z/RXPzGJ54j6yDyARsXqgXrWBJScBJqf9ABJFKS4dAg2QKZTqsQJ2e6b6XVL
 klf2Dfm1xFQGAAPaQFKYdDHmI2g6rKakJuzlIdVR/Jo1ycHmcurFG+nShetNucqKayf+
 9nL6g6xloQjox9U6xWTlVhh2alG5a9qNEZUvqJ0Y86VwBrnNMWmtjs3PNuS3wFCC2+Vk
 q95Kdzk0/5A4F5xPYWVDQi6Xhlfi/qh6/EySkqZZ5h8Y7DDhs1oh3dRKMyv802zPDGLI
 LCGCTS60G8uBxOxCb/PYZpBVt1hHMJuOv1MLBxM1POI3XUfYvu3HfIf76ymgi9Wqzedm
 y1kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=kjcelvvovVPpABaKJSYVdSxl5UaJWqhfw0gOadK/FqU=;
 b=OvxMGJgaiVXd7p0MhIeyu4o2NBAREPMDtj3DL6voidaeqrs8K/w1UmIJd6tAfS88FL
 UkWlHch9GSAWE5/u7C+rg+Iq1yIterRkcaxAC/0sKUzbMYjs0xcEzflSCGcgBcylsgFz
 SBtNchWSOPc4662VNQyJzRIYeJ6HKslYm7OshwCaoP/uMs0Z2BIp32y8NHIc7zwneTOm
 7NbMHMs4GGws1qgX+Yk5pp18HoJAjsV4OYmRVolX4vIWK6hgGGhFCY6yBWBCgdy/Yl0Z
 OiZ+hq0vTyYTLmcsfUVq0Y0+r3TAIUY2fagIWEXbW6u5k5xRbnz80GFeVk8jgM49Ofz8
 //+g==
X-Gm-Message-State: AOAM53144rfJB1fLi9U7qa1aCY+R/fu63hoChcLFGUvInIEuFXx2HGFb
 eXN/Ba07ktABbIEQzZzXM1Co7A==
X-Google-Smtp-Source: ABdhPJz/pSEUzxyT825aVOOpaDQxurDcxtpN6iSAvnZnK6Jj718Enur34F0X+qcoNK0bh0dijaHmJg==
X-Received: by 2002:adf:dfc9:: with SMTP id q9mr4334999wrn.400.1601038753214; 
 Fri, 25 Sep 2020 05:59:13 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l17sm2777107wme.11.2020.09.25.05.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:59:10 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 8BC0F1FF9D;
 Fri, 25 Sep 2020 13:51:49 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH 14/19] tools/vhost-user-rpmb: implement
 VIRTIO_RPMB_REQ_GET_WRITE_COUNTER
Date: Fri, 25 Sep 2020 13:51:42 +0100
Message-Id: <20200925125147.26943-15-alex.bennee@linaro.org>
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

VGhpcyBpcyB0aGUgZmlyc3QgZnVuY3Rpb24gd2l0aCBhbiBpbXBsaWVkIHJlc3BvbnNlIHRoYXQg
ZG9lc24ndCBuZWVkCmEgVklSVElPX1JQTUJfUkVRX1JFU1VMVF9SRUFELgoKU2lnbmVkLW9mZi1i
eTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPgotLS0KIHRvb2xzL3Zob3N0
LXVzZXItcnBtYi9tYWluLmMgfCA0NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysKIDEgZmlsZSBjaGFuZ2VkLCA0NCBpbnNlcnRpb25zKCspCgpkaWZmIC0tZ2l0IGEvdG9vbHMv
dmhvc3QtdXNlci1ycG1iL21haW4uYyBiL3Rvb2xzL3Zob3N0LXVzZXItcnBtYi9tYWluLmMKaW5k
ZXggOWM5OGY2OTE2ZjZmLi44ODc0N2M1MGZhNDQgMTAwNjQ0Ci0tLSBhL3Rvb2xzL3Zob3N0LXVz
ZXItcnBtYi9tYWluLmMKKysrIGIvdG9vbHMvdmhvc3QtdXNlci1ycG1iL21haW4uYwpAQCAtMTIx
LDggKzEyMSwxMCBAQCB0eXBlZGVmIHN0cnVjdCBWdVJwbWIgewogICAgIGludCBmbGFzaF9mZDsK
ICAgICB2b2lkICpmbGFzaF9tYXA7CiAgICAgdWludDhfdCAqa2V5OworICAgIHVpbnQ4X3QgIGxh
c3Rfbm9uY2VbMTZdOwogICAgIHVpbnQxNl90IGxhc3RfcmVzdWx0OwogICAgIHVpbnQxNl90IGxh
c3RfcmVxcmVzcDsKKyAgICB1aW50MzJfdCB3cml0ZV9jb3VudDsKIH0gVnVScG1iOwogCiAvKiBy
ZWZlciB0byB1dGlsL2lvdi5jICovCkBAIC0yODYsNiArMjg4LDQyIEBAIHN0YXRpYyB2b2lkIHZy
cG1iX2hhbmRsZV9wcm9ncmFtX2tleShWdURldiAqZGV2LCBzdHJ1Y3QgdmlydGlvX3JwbWJfZnJh
bWUgKmZyYW1lCiAgICAgcmV0dXJuOwogfQogCisvKgorICogdnJwbWJfaGFuZGxlX2dldF93cml0
ZV9jb3VudGVyOgorICoKKyAqIFdlIHJlc3BvbmQgc3RyYWlnaHQgYXdheSB3aXRoIHJlLXVzaW5n
IHRoZSBmcmFtZSBhcyBzZW50LgorICovCitzdGF0aWMgc3RydWN0IHZpcnRpb19ycG1iX2ZyYW1l
ICoKK3ZycG1iX2hhbmRsZV9nZXRfd3JpdGVfY291bnRlcihWdURldiAqZGV2LCBzdHJ1Y3Qgdmly
dGlvX3JwbWJfZnJhbWUgKmZyYW1lKQoreworICAgIFZ1UnBtYiAqciA9IGNvbnRhaW5lcl9vZihk
ZXYsIFZ1UnBtYiwgZGV2LnBhcmVudCk7CisgICAgc3RydWN0IHZpcnRpb19ycG1iX2ZyYW1lICpy
ZXNwID0gZ19uZXcwKHN0cnVjdCB2aXJ0aW9fcnBtYl9mcmFtZSwgMSk7CisKKyAgICAvKgorICAg
ICAqIFJ1biB0aGUgY2hlY2tzIGZyb206CisgICAgICogNS4xMi42LjEuMiBEZXZpY2UgUmVxdWly
ZW1lbnRzOiBEZXZpY2UgT3BlcmF0aW9uOiBHZXQgV3JpdGUgQ291bnRlcgorICAgICAqLworCisg
ICAgcmVzcC0+cmVxX3Jlc3AgPSBodG9iZTE2KFZJUlRJT19SUE1CX1JFU1BfR0VUX0NPVU5URVIp
OworICAgIGlmICghci0+a2V5KSB7CisgICAgICAgIGdfZGVidWcoIm5vIGtleSBwcm9ncmFtbWVk
Iik7CisgICAgICAgIHJlc3AtPnJlc3VsdCA9IGh0b2JlMTYoVklSVElPX1JQTUJfUkVTX05PX0FV
VEhfS0VZKTsKKyAgICAgICAgcmV0dXJuIHJlc3A7CisgICAgfSBlbHNlIGlmIChiZTE2dG9oKGZy
YW1lLT5ibG9ja19jb3VudCkgPiAxKSB7IC8qIGFsbG93IDAgKE5PTkNPTkYpICovCisgICAgICAg
IGdfZGVidWcoImludmFsaWQgYmxvY2sgY291bnQgKCVkKSIsIGJlMTZ0b2goZnJhbWUtPmJsb2Nr
X2NvdW50KSk7CisgICAgICAgIHJlc3AtPnJlc3VsdCA9IGh0b2JlMTYoVklSVElPX1JQTUJfUkVT
X0dFTkVSQUxfRkFJTFVSRSk7CisgICAgfSBlbHNlIHsKKyAgICAgICAgcmVzcC0+d3JpdGVfY291
bnRlciA9IGh0b2JlMzIoci0+d3JpdGVfY291bnQpOworICAgIH0KKyAgICAvKiBjb3B5IG5vbmNl
ICovCisgICAgbWVtY3B5KCZyZXNwLT5ub25jZSwgJmZyYW1lLT5ub25jZSwgc2l6ZW9mKGZyYW1l
LT5ub25jZSkpOworCisgICAgLyogY2FsY3VsYXRlIE1BQyAqLworICAgIHZycG1iX3VwZGF0ZV9t
YWNfaW5fZnJhbWUociwgcmVzcCk7CisKKyAgICByZXR1cm4gcmVzcDsKK30KKwogLyoKICAqIFJl
dHVybiB0aGUgcmVzdWx0IG9mIHRoZSBsYXN0IG1lc3NhZ2UuIFRoaXMgaXMgb25seSB2YWxpZCBp
ZiB0aGUKICAqIHByZXZpb3VzIG1lc3NhZ2Ugd2FzIFZJUlRJT19SUE1CX1JFUV9QUk9HUkFNX0tF
WSBvcgpAQCAtMjk4LDYgKzMzNiw5IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydGlvX3JwbWJfZnJhbWUg
KiB2cnBtYl9oYW5kbGVfcmVzdWx0X3JlYWQoVnVEZXYgKmRldikKICAgICBWdVJwbWIgKnIgPSBj
b250YWluZXJfb2YoZGV2LCBWdVJwbWIsIGRldi5wYXJlbnQpOwogICAgIHN0cnVjdCB2aXJ0aW9f
cnBtYl9mcmFtZSAqcmVzcCA9IGdfbmV3MChzdHJ1Y3QgdmlydGlvX3JwbWJfZnJhbWUsIDEpOwog
CisgICAgZ19pbmZvKCIlczogZm9yIHJlcXVlc3Q6JXggcmVzdWx0OiV4IiwgX19mdW5jX18sCisg
ICAgICAgICAgIHItPmxhc3RfcmVxcmVzcCwgci0+bGFzdF9yZXN1bHQpOworCiAgICAgaWYgKHIt
Pmxhc3RfcmVxcmVzcCA9PSBWSVJUSU9fUlBNQl9SRVNQX1BST0dSQU1fS0VZIHx8CiAgICAgICAg
IHItPmxhc3RfcmVxcmVzcCA9PSBWSVJUSU9fUlBNQl9SRVFfREFUQV9XUklURSkgewogICAgICAg
ICByZXNwLT5yZXN1bHQgPSBodG9iZTE2KHItPmxhc3RfcmVzdWx0KTsKQEAgLTM5Myw2ICs0MzQs
OSBAQCB2cnBtYl9oYW5kbGVfY3RybChWdURldiAqZGV2LCBpbnQgcWlkeCkKICAgICAgICAgICAg
IGNhc2UgVklSVElPX1JQTUJfUkVRX1BST0dSQU1fS0VZOgogICAgICAgICAgICAgICAgIHZycG1i
X2hhbmRsZV9wcm9ncmFtX2tleShkZXYsIGYpOwogICAgICAgICAgICAgICAgIGJyZWFrOworICAg
ICAgICAgICAgY2FzZSBWSVJUSU9fUlBNQl9SRVFfR0VUX1dSSVRFX0NPVU5URVI6CisgICAgICAg
ICAgICAgICAgcmVzcCA9IHZycG1iX2hhbmRsZV9nZXRfd3JpdGVfY291bnRlcihkZXYsIGYpOwor
ICAgICAgICAgICAgICAgIGJyZWFrOwogICAgICAgICAgICAgY2FzZSBWSVJUSU9fUlBNQl9SRVFf
UkVTVUxUX1JFQUQ6CiAgICAgICAgICAgICAgICAgaWYgKCFyZXNwb25kZWQpIHsKICAgICAgICAg
ICAgICAgICAgICAgcmVzcCA9IHZycG1iX2hhbmRsZV9yZXN1bHRfcmVhZChkZXYpOwotLSAKMi4y
MC4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
