Return-Path: <SRS0=RKVt=P5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E150C4332F
	for <virtualization@archiver.kernel.org>; Wed, 10 Nov 2021 10:37:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B9D160E8D
	for <virtualization@archiver.kernel.org>; Wed, 10 Nov 2021 10:37:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3B9D160E8D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0B7D7817C3;
	Wed, 10 Nov 2021 10:37:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qvWrpPb--0_L; Wed, 10 Nov 2021 10:37:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A58A181764;
	Wed, 10 Nov 2021 10:37:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D6C3C000E;
	Wed, 10 Nov 2021 10:37:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14974C0019
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 10:37:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 104424021B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 10:37:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="IqWBudsv";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="Fg7N0QvP"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3_JwYxgQWJU4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 10:37:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AE0A24012E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 10:37:06 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id 338D4218B5;
 Wed, 10 Nov 2021 10:37:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636540624; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wiDDj8XZv99R5G3WYXWhB689FbZNacrlX753PGPXc3E=;
 b=IqWBudsvizwMLj7jFbIh6xkuhe8yZiQVAlqk3MKScGqMBcimDtGixGxIN0WZIgEJ+lOFh7
 vJEOKqCh/a/6bGLCXhN3Js52hlNend8yQYCD2zDNQogzHL1l1xKqa7PvTTwVJnQm9h2rwI
 u3fV0l8QQ1aPyuwV+GxUVHa1BV2scU8=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636540624;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wiDDj8XZv99R5G3WYXWhB689FbZNacrlX753PGPXc3E=;
 b=Fg7N0QvPP3HZjyFUN9TTdVi+l0mWrbq00jLh7WS8vY5ssbZGVanABscILlHcK7siK+LNFB
 saT+ov8PwwIgsMDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id C2AE713E72;
 Wed, 10 Nov 2021 10:37:03 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id aGqGLs+gi2EnPAAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Wed, 10 Nov 2021 10:37:03 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, noralf@tronnes.org,
 drawat.floss@gmail.com, airlied@redhat.com, kraxel@redhat.com,
 david@lechnology.com, sam@ravnborg.org, javierm@redhat.com,
 kernel@amanoeldawod.com, dirty.ice.hu@gmail.com,
 michael+lkml@stapelberg.ch, aros@gmx.com, joshua@stroblindustries.com,
 arnd@arndb.de
Subject: [PATCH v3 1/9] drm/format-helper: Export drm_fb_clip_offset()
Date: Wed, 10 Nov 2021 11:36:54 +0100
Message-Id: <20211110103702.374-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.33.1
In-Reply-To: <20211110103702.374-1-tzimmermann@suse.de>
References: <20211110103702.374-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: linux-hyperv@vger.kernel.org, Thomas Zimmermann <tzimmermann@suse.de>,
 dri-devel@lists.freedesktop.org, virtualization@lists.linux-foundation.org
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

UHJvdmlkZSBhIGZ1bmN0aW9uIHRoYXQgY29tcHV0ZXMgdGhlIG9mZnNldCBpbnRvIGEgYmxpdCBk
ZXN0aW5hdGlvbgpidWZmZXIuIFRoaXMgd2lsbCBhbGxvdyB0byBtb3ZlIGRlc3RpbmF0aW9uLWJ1
ZmZlciBjbGlwcGluZyBpbnRvIHRoZQpmb3JtYXQtaGVscGVyIGNhbGxlcnMuCgp2MjoKCSogcHJv
dmlkZSBkb2N1bWVudGF0aW9uIChTYW0pCgkqIHJldHVybiAndW5zaWduZWQgaW50JyAoU2FtLCBO
b3JhbGYpCgpTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3Vz
ZS5kZT4KUmV2aWV3ZWQtYnk6IE5vcmFsZiBUcsO4bm5lcyA8bm9yYWxmQHRyb25uZXMub3JnPgot
LS0KIGRyaXZlcnMvZ3B1L2RybS9kcm1fZm9ybWF0X2hlbHBlci5jIHwgMTkgKysrKysrKysrKysr
KysrKystLQogaW5jbHVkZS9kcm0vZHJtX2Zvcm1hdF9oZWxwZXIuaCAgICAgfCAgNCArKysrCiAy
IGZpbGVzIGNoYW5nZWQsIDIxIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCgpkaWZmIC0t
Z2l0IGEvZHJpdmVycy9ncHUvZHJtL2RybV9mb3JtYXRfaGVscGVyLmMgYi9kcml2ZXJzL2dwdS9k
cm0vZHJtX2Zvcm1hdF9oZWxwZXIuYwppbmRleCA2OWZkZTYwZTM2YjMuLjY3N2U2MmUzOWY3MiAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL2RybV9mb3JtYXRfaGVscGVyLmMKKysrIGIvZHJp
dmVycy9ncHUvZHJtL2RybV9mb3JtYXRfaGVscGVyLmMKQEAgLTE3LDEyICsxNywyNyBAQAogI2lu
Y2x1ZGUgPGRybS9kcm1fZm91cmNjLmg+CiAjaW5jbHVkZSA8ZHJtL2RybV9yZWN0Lmg+CiAKLXN0
YXRpYyB1bnNpZ25lZCBpbnQgY2xpcF9vZmZzZXQoc3RydWN0IGRybV9yZWN0ICpjbGlwLAotCQkJ
CXVuc2lnbmVkIGludCBwaXRjaCwgdW5zaWduZWQgaW50IGNwcCkKK3N0YXRpYyB1bnNpZ25lZCBp
bnQgY2xpcF9vZmZzZXQoY29uc3Qgc3RydWN0IGRybV9yZWN0ICpjbGlwLCB1bnNpZ25lZCBpbnQg
cGl0Y2gsIHVuc2lnbmVkIGludCBjcHApCiB7CiAJcmV0dXJuIGNsaXAtPnkxICogcGl0Y2ggKyBj
bGlwLT54MSAqIGNwcDsKIH0KIAorLyoqCisgKiBkcm1fZmJfY2xpcF9vZmZzZXQgLSBSZXR1cm5z
IHRoZSBjbGlwcGluZyByZWN0YW5nbGVzIGJ5dGUtb2Zmc2V0IGluIGEgZnJhbWJ1ZmZlcgorICog
cGl0Y2g6IEZyYW1idWZmZXIgbGluZSBwaXRjaCBpbiBieXRlCisgKiBmb3JtYXQ6IEZyYW1idWZm
ZXIgZm9ybWF0CisgKiBjbGlwOiBDbGlwIHJlY3RhbmdsZQorICoKKyAqIFJldHVybnM6CisgKiBU
aGUgYnl0ZSBvZmZzZXQgb2YgdGhlIGNsaXAgcmVjdGFuZ2xlJ3MgdG9wLWxlZnQgY29ybmVyIHdp
dGhpbiB0aGUgZnJhbWVidWZmZXIuCisgKi8KK3Vuc2lnbmVkIGludCBkcm1fZmJfY2xpcF9vZmZz
ZXQodW5zaWduZWQgaW50IHBpdGNoLCBjb25zdCBzdHJ1Y3QgZHJtX2Zvcm1hdF9pbmZvICpmb3Jt
YXQsCisJCQkJY29uc3Qgc3RydWN0IGRybV9yZWN0ICpjbGlwKQoreworCXJldHVybiBjbGlwX29m
ZnNldChjbGlwLCBwaXRjaCwgZm9ybWF0LT5jcHBbMF0pOworfQorRVhQT1JUX1NZTUJPTChkcm1f
ZmJfY2xpcF9vZmZzZXQpOworCiAvKioKICAqIGRybV9mYl9tZW1jcHkgLSBDb3B5IGNsaXAgYnVm
ZmVyCiAgKiBAZHN0OiBEZXN0aW5hdGlvbiBidWZmZXIKZGlmZiAtLWdpdCBhL2luY2x1ZGUvZHJt
L2RybV9mb3JtYXRfaGVscGVyLmggYi9pbmNsdWRlL2RybS9kcm1fZm9ybWF0X2hlbHBlci5oCmlu
ZGV4IGU4NjkyNWNmMDdiOS4uZjVhOGIzMzRiMThkIDEwMDY0NAotLS0gYS9pbmNsdWRlL2RybS9k
cm1fZm9ybWF0X2hlbHBlci5oCisrKyBiL2luY2x1ZGUvZHJtL2RybV9mb3JtYXRfaGVscGVyLmgK
QEAgLTYsOSArNiwxMyBAQAogI2lmbmRlZiBfX0xJTlVYX0RSTV9GT1JNQVRfSEVMUEVSX0gKICNk
ZWZpbmUgX19MSU5VWF9EUk1fRk9STUFUX0hFTFBFUl9ICiAKK3N0cnVjdCBkcm1fZm9ybWF0X2lu
Zm87CiBzdHJ1Y3QgZHJtX2ZyYW1lYnVmZmVyOwogc3RydWN0IGRybV9yZWN0OwogCit1bnNpZ25l
ZCBpbnQgZHJtX2ZiX2NsaXBfb2Zmc2V0KHVuc2lnbmVkIGludCBwaXRjaCwgY29uc3Qgc3RydWN0
IGRybV9mb3JtYXRfaW5mbyAqZm9ybWF0LAorCQkJCWNvbnN0IHN0cnVjdCBkcm1fcmVjdCAqY2xp
cCk7CisKIHZvaWQgZHJtX2ZiX21lbWNweSh2b2lkICpkc3QsIHZvaWQgKnZhZGRyLCBzdHJ1Y3Qg
ZHJtX2ZyYW1lYnVmZmVyICpmYiwKIAkJICAgc3RydWN0IGRybV9yZWN0ICpjbGlwKTsKIHZvaWQg
ZHJtX2ZiX21lbWNweV9kc3RjbGlwKHZvaWQgX19pb21lbSAqZHN0LCB1bnNpZ25lZCBpbnQgZHN0
X3BpdGNoLCB2b2lkICp2YWRkciwKLS0gCjIuMzMuMQoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
