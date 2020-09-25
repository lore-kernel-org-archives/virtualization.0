Return-Path: <SRS0=jbvZ=DC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEDACC4727C
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 12:52:04 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 69C6B206DB
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 12:52:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xkrWq1Cg"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 69C6B206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 3CF7A875EC;
	Fri, 25 Sep 2020 12:52:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id unELUFIqrHdZ; Fri, 25 Sep 2020 12:52:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5C48A8750D;
	Fri, 25 Sep 2020 12:52:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46864C0890;
	Fri, 25 Sep 2020 12:52:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EF63C0859
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:52:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 7C2928750D
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:52:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mPrKyYrYCpSw
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:52:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f67.google.com (mail-wm1-f67.google.com
 [209.85.128.67])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 786AD875CB
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:52:00 +0000 (UTC)
Received: by mail-wm1-f67.google.com with SMTP id y15so3185185wmi.0
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 05:52:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=XCceP6Edp7P+SbIMUL/HUpL1UYE1lgoGhcHsF49MNZU=;
 b=xkrWq1Cgr+Bj+7+g3Nsr1J0dGpvBwK6/soDxBuin8vmQu03hos6U4PAOcTMjmMKRL7
 053HDpQ9gKsC4gqYY+hhtpxiQgwtpPVev+YAkW9hgL6wkv9kWCiGCvJi8zl30d0e+KN6
 RS79a41HZOeJk5EJB/LJFupJXSDYjkWE5/BHvYqdnpz5FFFXI9c4VXoh0AzDfu1bROCy
 DrU82EgjSbMCg5u/pXqXgBA5BFgug2JbKSIkxQNuWFzUZNsEqPaDmHBbwtW9VVjt6cHu
 OZhTEVNxe8LVkTWgxAbD1ep09yeMIbCDKH+dOq7JOm9Rk8Y/y9Vl87jYYCaRIXmzaAQt
 nxGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=XCceP6Edp7P+SbIMUL/HUpL1UYE1lgoGhcHsF49MNZU=;
 b=Qa8/bQUs0FoICQ8YBi1ZcPn1T/Ex0BETXCo6Nz0Eh3NbX8S7AIJwATlCYdCc/nL2P0
 F9MnFycUye2uxk0byi0N/11vCHlOXmLYxeP89ad2vvuXUdY1IHKOlpq2PkBNVntrSbT6
 DVPhgX4B9sCsTiklr3FBGTXLS6AvaY86AXji7jT6FGuC4t+C9kecvqwdLgdYOQnLRz/l
 G6tOKvko+VTu9dSJs2iHfNlNAlOgOhPOzs41azLYdA9BzhJqrquRnm1uPE4StEiyimtv
 nKkIztXHvKMmU3qzsPW3Ji/eW7GgzIThIz0SioRbZT/mjtu65rUz7AduzEFnUkf6dKZK
 pMlQ==
X-Gm-Message-State: AOAM532vZ7yyksrgJ5sEPMS+WmOc9eOjIn/t6uNx/6ic3BybDlAWkZKu
 dJlDoUz1pFnVdzM8A6PX6XbwCA==
X-Google-Smtp-Source: ABdhPJxbsS2HesAWoB4xN00MHkBIOSc+8lw3iA/LUtk3G3s0NUGb1qyDjlBEXfv2nmJedBiuG7Rhjw==
X-Received: by 2002:a1c:dd87:: with SMTP id u129mr2979946wmg.172.1601038318896; 
 Fri, 25 Sep 2020 05:51:58 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id l17sm2756361wme.11.2020.09.25.05.51.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:51:53 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id A74381FF91;
 Fri, 25 Sep 2020 13:51:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH  05/19] virtio-pci: add notification trace points
Date: Fri, 25 Sep 2020 13:51:33 +0100
Message-Id: <20200925125147.26943-6-alex.bennee@linaro.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200925125147.26943-1-alex.bennee@linaro.org>
References: <20200925125147.26943-1-alex.bennee@linaro.org>
MIME-Version: 1.0
Cc: jean-philippe@linaro.org, "Michael S. Tsirkin" <mst@redhat.com>,
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

U2lnbmVkLW9mZi1ieTogQWxleCBCZW5uw6llIDxhbGV4LmJlbm5lZUBsaW5hcm8ub3JnPgotLS0K
IGh3L3ZpcnRpby92aXJ0aW8tcGNpLmMgfCAzICsrKwogaHcvdmlydGlvL3RyYWNlLWV2ZW50cyB8
IDcgKysrKysrLQogMiBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkKCmRpZmYgLS1naXQgYS9ody92aXJ0aW8vdmlydGlvLXBjaS5jIGIvaHcvdmlydGlvL3ZpcnRp
by1wY2kuYwppbmRleCA1MDdjYjU3YzQxMGYuLjMzYTQwZTMxZDk1NSAxMDA2NDQKLS0tIGEvaHcv
dmlydGlvL3ZpcnRpby1wY2kuYworKysgYi9ody92aXJ0aW8vdmlydGlvLXBjaS5jCkBAIC0zNiw2
ICszNiw3IEBACiAjaW5jbHVkZSAicWVtdS9yYW5nZS5oIgogI2luY2x1ZGUgImh3L3ZpcnRpby92
aXJ0aW8tYnVzLmgiCiAjaW5jbHVkZSAicWFwaS92aXNpdG9yLmgiCisjaW5jbHVkZSAidHJhY2Uu
aCIKIAogI2RlZmluZSBWSVJUSU9fUENJX1JFR0lPTl9TSVpFKGRldikgICAgIFZJUlRJT19QQ0lf
Q09ORklHX09GRihtc2l4X3ByZXNlbnQoZGV2KSkKIApAQCAtMTM0MCw2ICsxMzQxLDcgQEAgc3Rh
dGljIHZvaWQgdmlydGlvX3BjaV9ub3RpZnlfd3JpdGUodm9pZCAqb3BhcXVlLCBod2FkZHIgYWRk
ciwKICAgICB1bnNpZ25lZCBxdWV1ZSA9IGFkZHIgLyB2aXJ0aW9fcGNpX3F1ZXVlX21lbV9tdWx0
KHByb3h5KTsKIAogICAgIGlmICh2ZGV2ICE9IE5VTEwgJiYgcXVldWUgPCBWSVJUSU9fUVVFVUVf
TUFYKSB7CisgICAgICAgIHRyYWNlX3ZpcnRpb19wY2lfbm90aWZ5X3dyaXRlKGFkZHIsIHZhbCwg
c2l6ZSk7CiAgICAgICAgIHZpcnRpb19xdWV1ZV9ub3RpZnkodmRldiwgcXVldWUpOwogICAgIH0K
IH0KQEAgLTEzNTMsNiArMTM1NSw3IEBAIHN0YXRpYyB2b2lkIHZpcnRpb19wY2lfbm90aWZ5X3dy
aXRlX3Bpbyh2b2lkICpvcGFxdWUsIGh3YWRkciBhZGRyLAogICAgIHVuc2lnbmVkIHF1ZXVlID0g
dmFsOwogCiAgICAgaWYgKHZkZXYgIT0gTlVMTCAmJiBxdWV1ZSA8IFZJUlRJT19RVUVVRV9NQVgp
IHsKKyAgICAgICAgdHJhY2VfdmlydGlvX3BjaV9ub3RpZnlfd3JpdGVfcGlvKGFkZHIsIHZhbCwg
c2l6ZSk7CiAgICAgICAgIHZpcnRpb19xdWV1ZV9ub3RpZnkodmRldiwgcXVldWUpOwogICAgIH0K
IH0KZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby90cmFjZS1ldmVudHMgYi9ody92aXJ0aW8vdHJhY2Ut
ZXZlbnRzCmluZGV4IDg0NTIwMGJmMTA5ZC4uMTg5OTcyYjkyMTNhIDEwMDY0NAotLS0gYS9ody92
aXJ0aW8vdHJhY2UtZXZlbnRzCisrKyBiL2h3L3ZpcnRpby90cmFjZS1ldmVudHMKQEAgLTU1LDcg
KzU1LDEyIEBAIHZpcnRpb19tbWlvX2d1ZXN0X3BhZ2UodWludDY0X3Qgc2l6ZSwgaW50IHNoaWZ0
KSAiZ3Vlc3QgcGFnZSBzaXplIDB4JSIgUFJJeDY0ICIKIHZpcnRpb19tbWlvX3F1ZXVlX3dyaXRl
KHVpbnQ2NF90IHZhbHVlLCBpbnQgbWF4X3NpemUpICJtbWlvX3F1ZXVlIHdyaXRlIDB4JSIgUFJJ
eDY0ICIgbWF4ICVkIgogdmlydGlvX21taW9fc2V0dGluZ19pcnEoaW50IGxldmVsKSAidmlydGlv
X21taW8gc2V0dGluZyBJUlEgJWQiCiAKLSMgdmlydGlvLWlvbW11LmMKKyMgdmlydGlvLXBjaS5j
Cit2aXJ0aW9fcGNpX25vdGlmeSh1aW50MTZfdCB2ZWN0b3IpICJ2aXJ0aW9fcGNpX25vdGlmeSB2
ZWMgMHgleCIKK3ZpcnRpb19wY2lfbm90aWZ5X3dyaXRlKHVpbnQ2NF90IGFkZHIsIHVpbnQ2NF90
IHZhbCwgdW5zaWduZWQgaW50IHNpemUpICIweCUiIFBSSXg2NCIgPSAweCUiIFBSSXg2NCAiICgl
ZCkiCit2aXJ0aW9fcGNpX25vdGlmeV93cml0ZV9waW8odWludDY0X3QgYWRkciwgdWludDY0X3Qg
dmFsLCB1bnNpZ25lZCBpbnQgc2l6ZSkgIjB4JSIgUFJJeDY0IiA9IDB4JSIgUFJJeDY0ICIgKCVk
KSIKKworIyBody92aXJ0aW8vdmlydGlvLWlvbW11LmMKIHZpcnRpb19pb21tdV9kZXZpY2VfcmVz
ZXQodm9pZCkgInJlc2V0ISIKIHZpcnRpb19pb21tdV9nZXRfZmVhdHVyZXModWludDY0X3QgZmVh
dHVyZXMpICJkZXZpY2Ugc3VwcG9ydHMgZmVhdHVyZXM9MHglIlBSSXg2NAogdmlydGlvX2lvbW11
X2RldmljZV9zdGF0dXModWludDhfdCBzdGF0dXMpICJkcml2ZXIgc3RhdHVzID0gJWQiCi0tIAoy
LjIwLjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
