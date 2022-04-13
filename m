Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4909AC433F5
	for <virtualization@archiver.kernel.org>; Wed, 13 Apr 2022 16:21:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E108A824F4;
	Wed, 13 Apr 2022 16:21:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id f1NV9XdyXYb4; Wed, 13 Apr 2022 16:21:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 86DC082681;
	Wed, 13 Apr 2022 16:21:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5B5E8C002F;
	Wed, 13 Apr 2022 16:21:24 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E3D61C002C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 16:21:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C2F8882681
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 16:21:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id b_pkbVk6XxKq
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 16:21:23 +0000 (UTC)
X-Greylist: delayed 00:08:19 by SQLgrey-1.8.0
Received: from netline-mail3.netline.ch (mail.netline.ch [148.251.143.180])
 by smtp1.osuosl.org (Postfix) with ESMTP id D11CB824F4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 13 Apr 2022 16:21:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by netline-mail3.netline.ch (Postfix) with ESMTP id BCB5E2020CD;
 Wed, 13 Apr 2022 18:13:00 +0200 (CEST)
X-Virus-Scanned: Debian amavisd-new at netline-mail3.netline.ch
Received: from netline-mail3.netline.ch ([127.0.0.1])
 by localhost (netline-mail3.netline.ch [127.0.0.1]) (amavisd-new, port 10024)
 with LMTP id xd4LjdJCkB0z; Wed, 13 Apr 2022 18:13:00 +0200 (CEST)
Received: from kaveri (24.99.2.85.dynamic.wline.res.cust.swisscom.ch
 [85.2.99.24])
 by netline-mail3.netline.ch (Postfix) with ESMTPA id 5ED9820206E;
 Wed, 13 Apr 2022 18:13:00 +0200 (CEST)
Received: from daenzer by kaveri with local (Exim 4.95)
 (envelope-from <michel@daenzer.net>) id 1nefc3-007mNl-M0;
 Wed, 13 Apr 2022 18:12:59 +0200
From: =?UTF-8?q?Michel=20D=C3=A4nzer?= <michel@daenzer.net>
To: Gerd Hoffmann <kraxel@redhat.com>
Subject: [PATCH] drm/bochs: Explicitly include linux/module.h
Date: Wed, 13 Apr 2022 18:12:59 +0200
Message-Id: <20220413161259.1854270-1-michel@daenzer.net>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
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

RnJvbTogTWljaGVsIETDpG56ZXIgPG1kYWVuemVyQHJlZGhhdC5jb20+CgpJbnN0ZWFkIG9mIHJl
bHlpbmcgb24gaXQgZ2V0dGluZyBwdWxsZWQgaW4gaW5kaXJlY3RseS4KClNpZ25lZC1vZmYtYnk6
IE1pY2hlbCBEw6RuemVyIDxtZGFlbnplckByZWRoYXQuY29tPgotLS0KIGRyaXZlcnMvZ3B1L2Ry
bS90aW55L2JvY2hzLmMgfCAxICsKIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQoKZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90aW55L2JvY2hzLmMgYi9kcml2ZXJzL2dwdS9kcm0v
dGlueS9ib2Nocy5jCmluZGV4IGVkOTcxYzhiYjQ0Ni4uNGY4YmY4NjYzM2RmIDEwMDY0NAotLS0g
YS9kcml2ZXJzL2dwdS9kcm0vdGlueS9ib2Nocy5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS90aW55
L2JvY2hzLmMKQEAgLTEsNSArMSw2IEBACiAvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMC1vci1sYXRlcgogCisjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+CiAjaW5jbHVkZSA8bGlu
dXgvcGNpLmg+CiAKICNpbmNsdWRlIDxkcm0vZHJtX2FwZXJ0dXJlLmg+Ci0tIAoyLjM1LjEKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
