Return-Path: <SRS0=jbvZ=DC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB7FEC4727C
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 12:52:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 533F3235FD
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 12:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="fOjWrSyC"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 533F3235FD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 2C99287600;
	Fri, 25 Sep 2020 12:52:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nw14pMiHzljA; Fri, 25 Sep 2020 12:52:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 325FB875FE;
	Fri, 25 Sep 2020 12:52:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1544DC0890;
	Fri, 25 Sep 2020 12:52:06 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C374CC0859
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:52:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AAAE886DC1
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:52:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N2N1ox5XKYUF
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:52:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com
 [209.85.128.49])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CF36086DC8
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:52:03 +0000 (UTC)
Received: by mail-wm1-f49.google.com with SMTP id x23so2927202wmi.3
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 05:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=BtOwqygZxNZk6oWCI22F6lqMw1LRPXvFIADZTQl+rOY=;
 b=fOjWrSyCvJQYpMmASANN0N5QLGO7rBHdRnm4ZVIiBVZlboHIMioFdOTj8nD0PTwhEv
 k/IGXoGYu3E5ubzC3bbcoLsONq5pPZuY1RfllMwg2CURFDzpYPe5K0cafBWCDhEU7dhp
 qp2WvHMxU24jfTi3SacCtzZjqZFRLXpuIkjsf3PZMjqGOEYktpXJZ//HQERRHsxDVfNG
 F7aQsxtpv9FimpmVRLFaU3JP/oMwKAcJ854HlbhxoZEvitK741+tB/KwWEP9DXYBl+Fy
 yRcExZhp/9sThFMQ+pFYyy8KLFlqKVS/a4D60ETPCuECkpiOfg6MMpPbJob43Qkdsz+8
 FiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=BtOwqygZxNZk6oWCI22F6lqMw1LRPXvFIADZTQl+rOY=;
 b=XKuDSuksWNYQEUaHH2VprGKuxgEdfVSN9nu5obeGr/Zh+oFbUvhWK8Q9je3pzR9+Zg
 LbolauEs09/g/k7DWAjYWrfwogd6lTs7fZgqKNIJSU8FPDdJOKozzomAJHBID1EL2kgt
 coaRv5PymTWknzvv8YFyFUGlubD1GSZfs2XdWwW0iwExAc1AxfHxRs6xbRyaRt8DWj78
 kQ8dmRs0DDMB/Qbn4R1+6y6VFlvo3CDty7t0a46C7GoPsYr/vvYVGDtxenfxnPK+9lVy
 HwL/1APgFnnGTqPFJT6Ggs/gyyyXNhzpRIUFPV6N/RlODr+MVn732TEzG+0DaGLJ3K/s
 ubvA==
X-Gm-Message-State: AOAM5324ayyYTFRY4vK25Gb2RWu78JkeCHYVlQaIEWdRlxsugnHeF278
 ErhuJ03E2Wf1hhTemMtrgcmhaw==
X-Google-Smtp-Source: ABdhPJykzsVoFuABJlyF48BUdTgFdDhu4D6Z6tqvRMH73d8CJkJCXeBVJNsmCMLI+v2nkSCEGVIPrw==
X-Received: by 2002:a05:600c:252:: with SMTP id
 18mr2846464wmj.63.1601038322276; 
 Fri, 25 Sep 2020 05:52:02 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id h17sm3046659wro.27.2020.09.25.05.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:51:56 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id DB33B1FF93;
 Fri, 25 Sep 2020 13:51:48 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH 07/19] tools/vhost-user-rpmb: implement
 --print-capabilities
Date: Fri, 25 Sep 2020 13:51:35 +0100
Message-Id: <20200925125147.26943-8-alex.bennee@linaro.org>
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

QSB2ZXJ5IHNpbXBsZSBjYXBhYmlsaXRpZXMgZHVtcC4KClNpZ25lZC1vZmYtYnk6IEFsZXggQmVu
bsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4KLS0tCiB0b29scy92aG9zdC11c2VyLXJwbWIv
bWFpbi5jIHwgMTMgKysrKysrKysrKysrKwogMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMo
KykKCmRpZmYgLS1naXQgYS90b29scy92aG9zdC11c2VyLXJwbWIvbWFpbi5jIGIvdG9vbHMvdmhv
c3QtdXNlci1ycG1iL21haW4uYwppbmRleCBhNDBhNjgwYTc0Y2EuLjZiMTk4OTEyNWJkNiAxMDA2
NDQKLS0tIGEvdG9vbHMvdmhvc3QtdXNlci1ycG1iL21haW4uYworKysgYi90b29scy92aG9zdC11
c2VyLXJwbWIvbWFpbi5jCkBAIC03LDYgKzcsNyBAQAogICovCiAKICNpbmNsdWRlIDxnbGliLmg+
CisjaW5jbHVkZSA8c3RkaW8uaD4KIAogc3RhdGljIGdjaGFyICpzb2NrZXRfcGF0aDsKIHN0YXRp
YyBnaW50IHNvY2tldF9mZDsKQEAgLTIwLDYgKzIxLDE0IEBAIHN0YXRpYyBHT3B0aW9uRW50cnkg
b3B0aW9uc1tdID0KICAgICB7IE5VTEwgfQogfTsKIAorLyogUHJpbnQgdmhvc3QtdXNlci5qc29u
IGJhY2tlbmQgcHJvZ3JhbSBjYXBhYmlsaXRpZXMgKi8KK3N0YXRpYyB2b2lkIHByaW50X2NhcGFi
aWxpdGllcyh2b2lkKQoreworICAgIHByaW50Zigie1xuIik7CisgICAgcHJpbnRmKCIgIFwidHlw
ZVwiOiBcImJsb2NrXCJcbiIpOworICAgIHByaW50ZigifVxuIik7Cit9CisKIGludCBtYWluIChp
bnQgYXJnYywgY2hhciAqYXJndltdKQogewogICAgIEdFcnJvciAqZXJyb3IgPSBOVUxMOwpAQCAt
MzMsNSArNDIsOSBAQCBpbnQgbWFpbiAoaW50IGFyZ2MsIGNoYXIgKmFyZ3ZbXSkKICAgICAgICAg
ZXhpdCAoMSk7CiAgICAgfQogCisgICAgaWYgKHByaW50X2NhcCkgeworICAgICAgICBwcmludF9j
YXBhYmlsaXRpZXMoKTsKKyAgICAgICAgZXhpdCgwKTsKKyAgICB9CiAKIH0KLS0gCjIuMjAuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
