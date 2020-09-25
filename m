Return-Path: <SRS0=jbvZ=DC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3057EC4363D
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 12:59:24 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D0BA6206DB
	for <virtualization@archiver.kernel.org>; Fri, 25 Sep 2020 12:59:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ZBJZ7pcJ"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D0BA6206DB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id A95C486DF0;
	Fri, 25 Sep 2020 12:59:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mm9m5H39y-95; Fri, 25 Sep 2020 12:59:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id BD22B86DED;
	Fri, 25 Sep 2020 12:59:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A8F84C0890;
	Fri, 25 Sep 2020 12:59:22 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AAB73C0859
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:59:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 99E4620370
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:59:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ic1N26XUbkAv
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:59:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by silver.osuosl.org (Postfix) with ESMTPS id 3FC9420486
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 12:59:12 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id m6so3554214wrn.0
 for <virtualization@lists.linuxfoundation.org>;
 Fri, 25 Sep 2020 05:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pVKBS48AbwRPMB8Nsn3vDh4qlhS4C2TzgyypcYvasXA=;
 b=ZBJZ7pcJqJAVmUAbL4bU66vcIwVRIBqHWOASZ/moE0vV9ZZ33zqzmEXlFz4PpHxyJj
 Uaz50G84KCnXXDED5db8v/So/HcoT41z/5o6kTlmVpJeGh9K1osiMIDL+9ePs+osyjtw
 ILIJ4EmKoiyejWgBu8wQq6abQvntQ8CYDjEe2HFSomOfk4gmh26KOujkWs9BaIO1BKUR
 Z1Uh1k1BlhWT/C+rmkcVZk7X5PcR9R/g/YTXKLN7lFCNJhPdxGR+HfwTM8xnlyqrvzDG
 a+1tkSxfjFM2zda9K6l23VMm3E+YHLGwoij5h5DI9k3dvIDSp0NyuCjHuEyXrR0ZUmiP
 c69g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pVKBS48AbwRPMB8Nsn3vDh4qlhS4C2TzgyypcYvasXA=;
 b=gkww7Td77HBB5dsGBi6dlEn5UKMUokaVkAqlu0RlO/hF4bsXvz6sHE9yNrs3AnBRa0
 BHcymIcEiU7UKModvYRN4Ij4IDrhgqPgoXCswxfaLT5p+tV2Qxp9f1RWG3O0+oVG+I9m
 gdkJzYk9gKheENhRtP0lTk8HnTmgwo/ELbujYXuVKBgON13p5e3GmmFLfP07UmykR6mH
 EACVwO5TLsfSDk7fROtSLG24N2zvtXaC4gFLOVsP8+rj3XnNMg4RoxFPy0zE900JLYWv
 NWBGgjvo7XWGFjyhZD9wTYa/hLFP2bZH464Ag+0yI/+VSjkqqnswwIKmYPZuU0MxEaAe
 TsSg==
X-Gm-Message-State: AOAM532wTi24xp1V+bc/F7aXI16BfwjBN3hWlo6nnBhcuP5lDplTvFEw
 QkeXnUb/g4njJVJEMwtx5zg30g==
X-Google-Smtp-Source: ABdhPJwCqES0abvcUL6qZHv6FfjWwPBI3DLs8hO10nQV8cxdXD+ajQvsKcdNDT3JetUMn+NKAOi/PQ==
X-Received: by 2002:a5d:4cc1:: with SMTP id c1mr4416288wrt.122.1601038750650; 
 Fri, 25 Sep 2020 05:59:10 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id e1sm2891195wrp.49.2020.09.25.05.59.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 25 Sep 2020 05:59:02 -0700 (PDT)
Received: from zen.lan (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 064BC1FF7E;
 Fri, 25 Sep 2020 13:51:50 +0100 (BST)
From: =?UTF-8?q?Alex=20Benn=C3=A9e?= <alex.bennee@linaro.org>
To: qemu-devel@nongnu.org, maxim.uvarov@linaro.org, joakim.bech@linaro.org,
 ilias.apalodimas@linaro.org, tomas.winkler@intel.com, yang.huang@intel.com,
 bing.zhu@intel.com, Matti.Moell@opensynergy.com, hmo@opensynergy.com
Subject: [RFC PATCH  19/19] docs: add a man page for vhost-user-rpmb
Date: Fri, 25 Sep 2020 13:51:47 +0100
Message-Id: <20200925125147.26943-20-alex.bennee@linaro.org>
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

QmFzaWMgdXNhZ2UgYW5kIGV4YW1wbGUgaW52b2NhdGlvbi4KClNpZ25lZC1vZmYtYnk6IEFsZXgg
QmVubsOpZSA8YWxleC5iZW5uZWVAbGluYXJvLm9yZz4KLS0tCiBkb2NzL3Rvb2xzL2luZGV4LnJz
dCAgICAgICAgICAgfCAgIDEgKwogZG9jcy90b29scy92aG9zdC11c2VyLXJwbWIucnN0IHwgMTAy
ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAxMDMg
aW5zZXJ0aW9ucygrKQogY3JlYXRlIG1vZGUgMTAwNjQ0IGRvY3MvdG9vbHMvdmhvc3QtdXNlci1y
cG1iLnJzdAoKZGlmZiAtLWdpdCBhL2RvY3MvdG9vbHMvaW5kZXgucnN0IGIvZG9jcy90b29scy9p
bmRleC5yc3QKaW5kZXggMjMyY2U5ZjNlNDYzLi40ODg3ODRiM2JmMWYgMTAwNjQ0Ci0tLSBhL2Rv
Y3MvdG9vbHMvaW5kZXgucnN0CisrKyBiL2RvY3MvdG9vbHMvaW5kZXgucnN0CkBAIC0xNSwzICsx
NSw0IEBAIENvbnRlbnRzOgogICAgcWVtdS10cmFjZS1zdGFwCiAgICB2aXJ0ZnMtcHJveHktaGVs
cGVyCiAgICB2aXJ0aW9mc2QKKyAgIHZob3N0LXVzZXItcnBtYgpkaWZmIC0tZ2l0IGEvZG9jcy90
b29scy92aG9zdC11c2VyLXJwbWIucnN0IGIvZG9jcy90b29scy92aG9zdC11c2VyLXJwbWIucnN0
Cm5ldyBmaWxlIG1vZGUgMTAwNjQ0CmluZGV4IDAwMDAwMDAwMDAwMC4uNDBkNWQzYmNlYjdjCi0t
LSAvZGV2L251bGwKKysrIGIvZG9jcy90b29scy92aG9zdC11c2VyLXJwbWIucnN0CkBAIC0wLDAg
KzEsMTAyIEBACitRRU1VIHZob3N0LXVzZXItcnBtYiAtIHJwbWIgZW11bGF0aW9uIGJhY2tlbmQK
Kz09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PQorCitTeW5vcHNp
cworLS0tLS0tLS0KKworKip2aG9zdC11c2VyLXJwbWIqKiBbKk9QVElPTlMqXQorCitEZXNjcmlw
dGlvbgorLS0tLS0tLS0tLS0KKworVGhpcyBwcm9ncmFtIGlzIGEgdmhvc3QtdXNlciBiYWNrZWQg
dGhhdCBlbXVsYXRlcyBhIFZpcnRJTyBSZXBsYXkKK1Byb3RlY3RlZCBNZW1vcnkgQmxvY2sgZGV2
aWNlLiBUaGVzZSBhcmUgdXN1YWxseSBzcGVjaWFsIHBhcnRpdGlvbnMKK3RoYXQgYXJlIHBhcnQg
b2YgYSBmbGFzaCBkZXZpY2UgdGhhdCBvZmZlciBwcm90ZWN0aW9uIGFnYWluc3QgcmVwbHkKK2F0
dGFja3MuIFRoZXkgYXJlIHVzZWQgdG8gc3RvcmUgc2VjdXJlIGluZm9ybWF0aW9uIGluIGEgd2F5
IHRoYXQgaXMKK2hhcmQgdG8gdGFtcGVyIHdpdGguCisKK1RoaXMgcHJvZ3JhbSBpcyBkZXNpZ25l
ZCB0byB3b3JrIHdpdGggUUVNVSdzIGBgLS1kZXZpY2UKK3Zob3N0LXVzZXItcnBtYi1wY2lgYCBi
dXQgc2hvdWxkIHdvcmsgd2l0aCBhbnkgdmlydHVhbCBtYWNoaW5lCittb25pdG9yIChWTU0pIHRo
YXQgc3VwcG9ydHMgdmhvc3QtdXNlci4gU2VlIHRoZSBFeGFtcGxlcyBzZWN0aW9uCitiZWxvdy4K
KworVGhpcyBwcm9ncmFtIHJlcXVpcmVzIGEgYmFja2luZyBzdG9yZSB0byBwZXJzaXN0IGFueSBk
YXRhIHByb2dyYW1tZWQKK2ludG8gdGhlIGRldmljZS4gVGhlIHNwZWMgc3VwcG9ydHMgZGV2aWNl
cyB1cCAzMk1iIGluIHNpemUuIEZvciB0aGUKK2RhZW1vbiB0aGlzIGlzIHNpbXBseSBhIHJhdyBm
aWxlIG9mIHRoZSBhcHByb3ByaWF0ZSBzaXplLiBUbyBwcm9ncmFtCit0aGUgZGV2aWNlIGl0IG5l
ZWRzIHRvIGhhdmUgYSBrZXkuIFRoaXMgY2FuIGVpdGhlciBiZSBwcm9ncmFtbWVkIGJ5Cit0aGUg
Z3Vlc3QgYXQgdGhlIHN0YXJ0IG9yIGNvbWUgZnJvbSBhIGtleSBmaWxlIHN1cHBsaWVkIHRvIHRo
ZSBkYWVtb24uCisKK09wdGlvbnMKKy0tLS0tLS0KKworLi4gcHJvZ3JhbTo6IHZob3N0LXVzZXIt
cnBtYgorCisuLiBvcHRpb246OiAtaCwgLS1oZWxwCisKKyAgUHJpbnQgaGVscC4KKworLi4gb3B0
aW9uOjogLVYsIC0tdmVyc2lvbgorCisgIFByaW50IHZlcnNpb24uCisKKy4uIG9wdGlvbjo6IC12
LCAtLXZlcmJvc2UKKworICAgSW5jcmVhc2UgdmVyYm9zaXR5IG9mIG91dHB1dAorICAgICAgICAg
ICAgCisuLiBvcHRpb246OiAtLWRlYnVnCisKKyAgRW5hYmxlIGRlYnVnIG91dHB1dC4KKworLi4g
b3B0aW9uOjogLS1zb2NrZXQtcGF0aD1QQVRICisKKyAgTGlzdGVuIG9uIHZob3N0LXVzZXIgVU5J
WCBkb21haW4gc29ja2V0IGF0IFBBVEguIEluY29tcGF0aWJsZSB3aXRoIC0tZmQuCisKKy4uIG9w
dGlvbjo6IC0tZmQ9RkROVU0KKworICBBY2NlcHQgY29ubmVjdGlvbnMgZnJvbSB2aG9zdC11c2Vy
IFVOSVggZG9tYWluIHNvY2tldCBmaWxlIGRlc2NyaXB0b3IgRkROVU0uCisgIFRoZSBmaWxlIGRl
c2NyaXB0b3IgbXVzdCBhbHJlYWR5IGJlIGxpc3RlbmluZyBmb3IgY29ubmVjdGlvbnMuCisgIElu
Y29tcGF0aWJsZSB3aXRoIC0tc29ja2V0LXBhdGguCisKKy4uIG9wdGlvbjo6IC0tZmxhc2gtcGF0
aD1QQVRICisKKyAgUGF0aCB0byB0aGUgYmFja2luZyBzdG9yZSBmb3IgdGhlIGZsYXNoIGltYWdl
LCBjYW4gYmUgdXAgdG8gMzJNYiBpbiBzaXplLgorCisuLiBvcHRpb246OiAtLWtleS1wYXRoPVBB
VEgKKworICBQYXRoIHRvIHRoZSBiYWNraW5nIHN0b3JlIGZvciB0aGUga2V5IG9mIDMyIGJ5dGVz
LgorICAgICAgICAgICAgCisuLiBvcHRpb246OiAtLWtleS1zZXQKKworICBUcmVhdCB0aGUgdmFs
dWUgb2Yga2V5LXBhdGggYXMgc2V0IG1lYW5pbmcgdGhlIGtleSBjYW5ub3QgYmUKKyAgcmVwcm9n
cmFtbWVkIGJ5IHRoZSBndWVzdC4KKworLi4gb3B0aW9uOjogLS1pbml0aWFsLWNvdW50ZXI9Tgor
CisgIFNldCB0aGUgaW5pdGlhbCB2YWx1ZSBvZiB0aGUgZGV2aWNlcyB3cml0ZSBjb3VudC4gSXQg
aXMKKyAgaW5jcmVtZW50ZWQgYnkgZWFjaCB3cml0ZSBvcGVyYXRpb24uIAorCitFeGFtcGxlcwor
LS0tLS0tLS0KKworVGhlIGRhZW1vbiBzaG91bGQgYmUgc3RhcnRlZCBmaXJzdDoKKworOjoKKwor
ICBob3N0IyB2aG9zdC11c2VyLXJwbWIgLS1zb2NrZXQtcGF0aD12cnBtYi5zb2NrIFwKKyAgIC0t
Zmxhc2gtcGF0aD1mbGFzaC5pbWcgXAorICAgLS1rZXktcGF0aD1rZXkgLS1rZXktc2V0IFwKKyAg
IC0taW5pdGlhbC1jb3VudGVyPTEyMzQKKworVGhlIFFFTVUgaW52b2NhdGlvbiBuZWVkcyB0byBj
cmVhdGUgYSBjaGFyZGV2IHNvY2tldCB0aGUgZGV2aWNlIGNhbgordXNlIHRvIGNvbW11bmljYXRl
IGFzIHdlbGwgYXMgc2hhcmUgdGhlIGd1ZXN0cyBtZW1vcnkgb3ZlciBhIG1lbWZkLgorCis6Ogor
CisgIGhvc3QjIHFlbXUtc3lzdGVtIFwKKyAgICAgIC1jaGFyZGV2IHNvY2tldCxwYXRoPXZycG1i
LnNvY2ssaWQ9dnJwbWIgXAorICAgICAgLWRldmljZSB2aG9zdC11c2VyLXJwbWItcGNpLGNoYXJk
ZXY9dnJwbWIsaWQ9cnBtYiBcCisgICAgICAtbSA0MDk2IFwKKyAgICAgIC1vYmplY3QgbWVtb3J5
LWJhY2tlbmQtZmlsZSxpZD1tZW0sc2l6ZT00RyxtZW0tcGF0aD0vZGV2L3NobSxzaGFyZT1vbiBc
CisgICAgICAtbnVtYSBub2RlLG1lbWRldj1tZW0gXAorICAgICAgLi4uCisKLS0gCjIuMjAuMQoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
