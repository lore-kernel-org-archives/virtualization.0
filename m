Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFEBC433EF
	for <virtualization@archiver.kernel.org>; Fri, 29 Apr 2022 13:42:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A454E83FF7;
	Fri, 29 Apr 2022 13:42:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xQtP2gviBW3A; Fri, 29 Apr 2022 13:42:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4B33783E5D;
	Fri, 29 Apr 2022 13:42:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA02AC0032;
	Fri, 29 Apr 2022 13:42:40 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8A73BC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 13:42:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7989683F16
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 13:42:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5QgAYyVAmfxs
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 13:42:38 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com
 [IPv6:2a00:1450:4864:20::434])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9E82983E5D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 13:42:38 +0000 (UTC)
Received: by mail-wr1-x434.google.com with SMTP id i5so10825612wrc.13
 for <virtualization@lists.linux-foundation.org>;
 Fri, 29 Apr 2022 06:42:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=LNM1AEcQA1TC9gdIDYx11HgLW6iNh6oI5PWYGXlZlcE=;
 b=p/2OcZKTlgGP3GKgPfjNkt19DmFAK1dTdwQk5tAt0UhUE0cUd2X+fBDeOjf+Ffhe20
 r8F0++xJoGDy/lMVhaIPOSxtSuqyIcMOJ9HBLV9NNr7ObSnlU/diKZ9ipcFVjv+TTqwY
 HE/caSuK0kXPP4K+O8GyFhmXAMiv904Z47g6SsMj2bYVIX2t8W2ahVQId9UJdCHOXHE8
 2U49sCmK/Nk/Tc6wLGAUPWscFd7MfUUBsdWJApCLS9hINYejWXiyU5eYW/MRgg3YVVVP
 2ZzMvonSIH2W5qf9YEGGIDN+6ilSubR8i/SSkOWBWbqb76P1XR13wDBLfICZ2vArmoJZ
 b12A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=LNM1AEcQA1TC9gdIDYx11HgLW6iNh6oI5PWYGXlZlcE=;
 b=eIzyTle2/CgNgnbiMGPz56IXC7XWwyhcdwrBqj4+eZnVA7ZF2cNp7i06su8Nw91CIZ
 5tm83ZcAj7pnyqFg3dvEIA9USfoPXYASEgfNExcuPBu7CZOGNX4QU/bXRYQeAc1l+CSU
 fiLj6210+XfvJKsMxXjYxYiPR/AHf3HHS0B/tB713dT21BieTTzbgmZZnJOhFrwr93SK
 Kzj52jRYsk2jWYPYQOM0MFF9vsLjSgag0Dvldqq7wY2pHJUEePl4ifZu7ko8FZPmMmtg
 WaMqOdI3MlTEm1ULVcLq7yNH6u1/+IibA6W1VLPfiJs3oDydtrTJTEsKtSJjkG44Mkiz
 n/nA==
X-Gm-Message-State: AOAM532wX93ZhcRn86+TzXwaLRJcAFz9vdqs374nA83IWHDrW1TTW3k+
 5JTwDEU/a5ytdyB+pfhwMUg=
X-Google-Smtp-Source: ABdhPJwU7PzmmCxcteLi5KWHy5fqWgZ5rFNEm/7Iy4Q7eBRKgkHL9WPdF7q8HZOW2aG5+mwxhSn5aw==
X-Received: by 2002:a5d:5966:0:b0:20a:e810:5e9d with SMTP id
 e38-20020a5d5966000000b0020ae8105e9dmr14033832wri.240.1651239756938; 
 Fri, 29 Apr 2022 06:42:36 -0700 (PDT)
Received: from able.fritz.box (p57b0b9e1.dip0.t-ipconnect.de. [87.176.185.225])
 by smtp.gmail.com with ESMTPSA id
 u19-20020a05600c19d300b00393f081d49fsm7301227wmq.2.2022.04.29.06.42.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 29 Apr 2022 06:42:36 -0700 (PDT)
From: "=?UTF-8?q?Christian=20K=C3=B6nig?=" <ckoenig.leichtzumerken@gmail.com>
X-Google-Original-From: =?UTF-8?q?Christian=20K=C3=B6nig?=
 <christian.koenig@amd.com>
To: daniel.vetter@ffwll.ch,
	dri-devel@lists.freedesktop.org
Subject: [PATCH 4/4] drm/qxl: add drm_gem_plane_helper_prepare_fb
Date: Fri, 29 Apr 2022 15:42:30 +0200
Message-Id: <20220429134230.24334-4-christian.koenig@amd.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220429134230.24334-1-christian.koenig@amd.com>
References: <20220429134230.24334-1-christian.koenig@amd.com>
MIME-Version: 1.0
Cc: spice-devel@lists.freedesktop.org, Dave Airlie <airlied@redhat.com>,
 virtualization@lists.linux-foundation.org,
 =?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>
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

V2UgY291bGQgbmVlZCB0byB3YWl0IGZvciB0aGUgcGluIHRvIGNvbXBsZXRlIGhlcmUuCgpTaWdu
ZWQtb2ZmLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNj
OiBEYXZlIEFpcmxpZSA8YWlybGllZEByZWRoYXQuY29tPgpDYzogR2VyZCBIb2ZmbWFubiA8a3Jh
eGVsQHJlZGhhdC5jb20+CkNjOiB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpDYzogc3BpY2UtZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCi0tLQogZHJpdmVycy9n
cHUvZHJtL3F4bC9xeGxfZGlzcGxheS5jIHwgOCArKysrKysrLQogMSBmaWxlIGNoYW5nZWQsIDcg
aW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2Ry
bS9xeGwvcXhsX2Rpc3BsYXkuYyBiL2RyaXZlcnMvZ3B1L2RybS9xeGwvcXhsX2Rpc3BsYXkuYwpp
bmRleCA5YTljMjliMWQzZTEuLjlhNjRmYTRjNzUzMCAxMDA2NDQKLS0tIGEvZHJpdmVycy9ncHUv
ZHJtL3F4bC9xeGxfZGlzcGxheS5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9xeGwvcXhsX2Rpc3Bs
YXkuYwpAQCAtMzQsNiArMzQsNyBAQAogI2luY2x1ZGUgPGRybS9kcm1fcGxhbmVfaGVscGVyLmg+
CiAjaW5jbHVkZSA8ZHJtL2RybV9wcm9iZV9oZWxwZXIuaD4KICNpbmNsdWRlIDxkcm0vZHJtX3Np
bXBsZV9rbXNfaGVscGVyLmg+CisjaW5jbHVkZSA8ZHJtL2RybV9nZW1fYXRvbWljX2hlbHBlci5o
PgogCiAjaW5jbHVkZSAicXhsX2Rydi5oIgogI2luY2x1ZGUgInF4bF9vYmplY3QuaCIKQEAgLTgy
OSw2ICs4MzAsNyBAQCBzdGF0aWMgaW50IHF4bF9wbGFuZV9wcmVwYXJlX2ZiKHN0cnVjdCBkcm1f
cGxhbmUgKnBsYW5lLAogCXN0cnVjdCBxeGxfZGV2aWNlICpxZGV2ID0gdG9fcXhsKHBsYW5lLT5k
ZXYpOwogCXN0cnVjdCBkcm1fZ2VtX29iamVjdCAqb2JqOwogCXN0cnVjdCBxeGxfYm8gKnVzZXJf
Ym87CisJaW50IHJldDsKIAogCWlmICghbmV3X3N0YXRlLT5mYikKIAkJcmV0dXJuIDA7CkBAIC04
NTIsNyArODU0LDExIEBAIHN0YXRpYyBpbnQgcXhsX3BsYW5lX3ByZXBhcmVfZmIoc3RydWN0IGRy
bV9wbGFuZSAqcGxhbmUsCiAJCXF4bF9mcmVlX2N1cnNvcihvbGRfY3Vyc29yX2JvKTsKIAl9CiAK
LQlyZXR1cm4gcXhsX2JvX3Bpbih1c2VyX2JvKTsKKwlyZXQgPSBxeGxfYm9fcGluKHVzZXJfYm8p
OworCWlmIChyZXQpCisJCXJldHVybiByZXQ7CisKKwlyZXR1cm4gZHJtX2dlbV9wbGFuZV9oZWxw
ZXJfcHJlcGFyZV9mYihwbGFuZSwgbmV3X3N0YXRlKTsKIH0KIAogc3RhdGljIHZvaWQgcXhsX3Bs
YW5lX2NsZWFudXBfZmIoc3RydWN0IGRybV9wbGFuZSAqcGxhbmUsCi0tIAoyLjI1LjEKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
