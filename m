Return-Path: <SRS0=RKVt=P5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7482CC433F5
	for <virtualization@archiver.kernel.org>; Wed, 10 Nov 2021 10:37:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 39EED60E8D
	for <virtualization@archiver.kernel.org>; Wed, 10 Nov 2021 10:37:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 39EED60E8D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 94FF640475;
	Wed, 10 Nov 2021 10:37:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mU6rkg7ZRlet; Wed, 10 Nov 2021 10:37:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EF7384043F;
	Wed, 10 Nov 2021 10:37:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4584C0019;
	Wed, 10 Nov 2021 10:37:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1E3C3C0042
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 10:37:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id F35214012E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 10:37:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=suse.de header.b="XZU3Lpy1";
 dkim=neutral reason="invalid (unsupported algorithm ed25519-sha256)"
 header.d=suse.de header.b="ME+XKZEh"
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yC8dan8CBAZS
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 10:37:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 06A2840223
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 10:37:08 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 432A71FDBE;
 Wed, 10 Nov 2021 10:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636540627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0LFfXlGUeG3G8ODo61MekjumhZ/G6LtuRrp9DCLbMEw=;
 b=XZU3Lpy1ThKRJgQsIfG/7LgndhH1dciz9NXc+2CfppCNpFnFbD+AdOJcKouLJlA9BGhtwi
 DBbKAXPYV3ASV31uuXk1Hhe43UzssHIyEXWeXBShZc2jtU3r+PcrfpYfmmcwsjE30AhwEj
 OCvIRUoRzlR6/hHOrnUkVPqUDnSlnUE=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636540627;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0LFfXlGUeG3G8ODo61MekjumhZ/G6LtuRrp9DCLbMEw=;
 b=ME+XKZEhBjMRvOoFfVqNRZO/FPDLB773fTqtflnWctxCka/o/inpET0G02aPDPYQ5L/upD
 dNyixiYuUkWNfoDA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id D040A13BEA;
 Wed, 10 Nov 2021 10:37:06 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id WBrjMdKgi2EnPAAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Wed, 10 Nov 2021 10:37:06 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, noralf@tronnes.org,
 drawat.floss@gmail.com, airlied@redhat.com, kraxel@redhat.com,
 david@lechnology.com, sam@ravnborg.org, javierm@redhat.com,
 kernel@amanoeldawod.com, dirty.ice.hu@gmail.com,
 michael+lkml@stapelberg.ch, aros@gmx.com, joshua@stroblindustries.com,
 arnd@arndb.de
Subject: [PATCH v3 8/9] drm/simpledrm: Support virtual screen sizes
Date: Wed, 10 Nov 2021 11:37:01 +0100
Message-Id: <20211110103702.374-9-tzimmermann@suse.de>
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

QWRkIGNvbnN0YW50cyBmb3IgdGhlIG1heGltdW0gc2l6ZSBvZiB0aGUgc2hhZG93LXBsYW5lIHN1
cmZhY2UKc2l6ZS4gVXNlZnVsIGZvciBzaGFkb3cgcGxhbmVzIHdpdGggdmlydHVhbCBzY3JlZW4g
c2l6ZXMuIFRoZQpjdXJyZW50IHNpemVzIGFyZSA0MDk2IHNjYW5saW5lcyB3aXRoIDQwOTYgcGl4
ZWxzIGVhY2guIFRoaXMKc2VlbXMgcmVhc29uYWJsZSBmb3IgY3VycmVudCBoYXJkd2FyZSwgYnV0
IGNhbiBiZSBpbmNyZWFzZWQgYXMKbmVjZXNzYXJ5LgoKSW4gc2ltcGxlZHJtLCBzZXQgdGhlIG1h
eGltdW0gZnJhbWVidWZmZXIgc2l6ZSBmcm9tIHRoZSBjb25zdGFudHMKZm9yIHNoYWRvdyBwbGFu
ZXMuIEltcGxlbWVudHMgc3VwcG9ydCBmb3IgdmlydHVhbCBzY3JlZW4gc2l6ZXMgYW5kCnBhZ2Ug
ZmxpcHBpbmcgb24gdGhlIGZiZGV2IGNvbnNvbGUuCgp2MzoKCSogdXNlIGRlY2ltYWwgbnVtYmVy
cyBmb3Igc2hhZG93LXBsYW5lIGNvbnN0YW50cyAoTm9yYWxmKQoKU2lnbmVkLW9mZi1ieTogVGhv
bWFzIFppbW1lcm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+CkFja2VkLWJ5OiBOb3JhbGYgVHLD
uG5uZXMgPG5vcmFsZkB0cm9ubmVzLm9yZz4KLS0tCiBkcml2ZXJzL2dwdS9kcm0vdGlueS9zaW1w
bGVkcm0uYyAgICB8ICA5ICsrKysrKystLQogaW5jbHVkZS9kcm0vZHJtX2dlbV9hdG9taWNfaGVs
cGVyLmggfCAxOCArKysrKysrKysrKysrKysrKysKIDIgZmlsZXMgY2hhbmdlZCwgMjUgaW5zZXJ0
aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vdGlu
eS9zaW1wbGVkcm0uYyBiL2RyaXZlcnMvZ3B1L2RybS90aW55L3NpbXBsZWRybS5jCmluZGV4IDdj
N2QwYWNhOGUzMS4uMmY5OTk5MTViOWFhIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vdGlu
eS9zaW1wbGVkcm0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vdGlueS9zaW1wbGVkcm0uYwpAQCAt
Miw2ICsyLDcgQEAKIAogI2luY2x1ZGUgPGxpbnV4L2Nsay5oPgogI2luY2x1ZGUgPGxpbnV4L29m
X2Nsay5oPgorI2luY2x1ZGUgPGxpbnV4L21pbm1heC5oPgogI2luY2x1ZGUgPGxpbnV4L3BsYXRm
b3JtX2RhdGEvc2ltcGxlZmIuaD4KICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2UuaD4K
ICNpbmNsdWRlIDxsaW51eC9yZWd1bGF0b3IvY29uc3VtZXIuaD4KQEAgLTc3Miw2ICs3NzMsNyBA
QCBzdGF0aWMgaW50IHNpbXBsZWRybV9kZXZpY2VfaW5pdF9tb2Rlc2V0KHN0cnVjdCBzaW1wbGVk
cm1fZGV2aWNlICpzZGV2KQogCXN0cnVjdCBkcm1fZGlzcGxheV9tb2RlICptb2RlID0gJnNkZXYt
Pm1vZGU7CiAJc3RydWN0IGRybV9jb25uZWN0b3IgKmNvbm5lY3RvciA9ICZzZGV2LT5jb25uZWN0
b3I7CiAJc3RydWN0IGRybV9zaW1wbGVfZGlzcGxheV9waXBlICpwaXBlID0gJnNkZXYtPnBpcGU7
CisJdW5zaWduZWQgbG9uZyBtYXhfd2lkdGgsIG1heF9oZWlnaHQ7CiAJY29uc3QgdWludDMyX3Qg
KmZvcm1hdHM7CiAJc2l6ZV90IG5mb3JtYXRzOwogCWludCByZXQ7CkBAIC03ODAsMTAgKzc4Miwx
MyBAQCBzdGF0aWMgaW50IHNpbXBsZWRybV9kZXZpY2VfaW5pdF9tb2Rlc2V0KHN0cnVjdCBzaW1w
bGVkcm1fZGV2aWNlICpzZGV2KQogCWlmIChyZXQpCiAJCXJldHVybiByZXQ7CiAKKwltYXhfd2lk
dGggPSBtYXhfdCh1bnNpZ25lZCBsb25nLCBtb2RlLT5oZGlzcGxheSwgRFJNX1NIQURPV19QTEFO
RV9NQVhfV0lEVEgpOworCW1heF9oZWlnaHQgPSBtYXhfdCh1bnNpZ25lZCBsb25nLCBtb2RlLT52
ZGlzcGxheSwgRFJNX1NIQURPV19QTEFORV9NQVhfSEVJR0hUKTsKKwogCWRldi0+bW9kZV9jb25m
aWcubWluX3dpZHRoID0gbW9kZS0+aGRpc3BsYXk7Ci0JZGV2LT5tb2RlX2NvbmZpZy5tYXhfd2lk
dGggPSBtb2RlLT5oZGlzcGxheTsKKwlkZXYtPm1vZGVfY29uZmlnLm1heF93aWR0aCA9IG1heF93
aWR0aDsKIAlkZXYtPm1vZGVfY29uZmlnLm1pbl9oZWlnaHQgPSBtb2RlLT52ZGlzcGxheTsKLQlk
ZXYtPm1vZGVfY29uZmlnLm1heF9oZWlnaHQgPSBtb2RlLT52ZGlzcGxheTsKKwlkZXYtPm1vZGVf
Y29uZmlnLm1heF9oZWlnaHQgPSBtYXhfaGVpZ2h0OwogCWRldi0+bW9kZV9jb25maWcucHJlZmVy
X3NoYWRvd19mYmRldiA9IHRydWU7CiAJZGV2LT5tb2RlX2NvbmZpZy5wcmVmZXJyZWRfZGVwdGgg
PSBzZGV2LT5mb3JtYXQtPmNwcFswXSAqIDg7CiAJZGV2LT5tb2RlX2NvbmZpZy5mdW5jcyA9ICZz
aW1wbGVkcm1fbW9kZV9jb25maWdfZnVuY3M7CmRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9kcm1f
Z2VtX2F0b21pY19oZWxwZXIuaCBiL2luY2x1ZGUvZHJtL2RybV9nZW1fYXRvbWljX2hlbHBlci5o
CmluZGV4IDQ4MjIyYTEwNzg3My4uMGIxZTJkZDJhYzNmIDEwMDY0NAotLS0gYS9pbmNsdWRlL2Ry
bS9kcm1fZ2VtX2F0b21pY19oZWxwZXIuaAorKysgYi9pbmNsdWRlL2RybS9kcm1fZ2VtX2F0b21p
Y19oZWxwZXIuaApAQCAtMjIsNiArMjIsMjQgQEAgaW50IGRybV9nZW1fc2ltcGxlX2Rpc3BsYXlf
cGlwZV9wcmVwYXJlX2ZiKHN0cnVjdCBkcm1fc2ltcGxlX2Rpc3BsYXlfcGlwZSAqcGlwZSwKICAq
IEhlbHBlcnMgZm9yIHBsYW5lcyB3aXRoIHNoYWRvdyBidWZmZXJzCiAgKi8KIAorLyoqCisgKiBE
Uk1fU0hBRE9XX1BMQU5FX01BWF9XSURUSCAtIE1heGltdW0gd2lkdGggb2YgYSBwbGFuZSdzIHNo
YWRvdyBidWZmZXIgaW4gcGl4ZWxzCisgKgorICogRm9yIGRyaXZlcnMgd2l0aCBzaGFkb3cgcGxh
bmVzLCB0aGUgbWF4aW11bSB3aWR0aCBvZiB0aGUgZnJhbWVidWZmZXIgaXMKKyAqIHVzdWFsbHkg
aW5kZXBlbmRlbnQgZnJvbSBoYXJkd2FyZSBsaW1pdGF0aW9ucy4gRHJpdmVycyBjYW4gaW5pdGlh
bGl6ZSBzdHJ1Y3QKKyAqIGRybV9tb2RlX2NvbmZpZy5tYXhfd2lkdGggZnJvbSBEUk1fU0hBRE9X
X1BMQU5FX01BWF9XSURUSC4KKyAqLworI2RlZmluZSBEUk1fU0hBRE9XX1BMQU5FX01BWF9XSURU
SAkoNDA5NnUpCisKKy8qKgorICogRFJNX1NIQURPV19QTEFORV9NQVhfSEVJR0hUIC0gTWF4aW11
bSBoZWlnaHQgb2YgYSBwbGFuZSdzIHNoYWRvdyBidWZmZXIgaW4gc2NhbmxpbmVzCisgKgorICog
Rm9yIGRyaXZlcnMgd2l0aCBzaGFkb3cgcGxhbmVzLCB0aGUgbWF4aW11bSBoZWlnaHQgb2YgdGhl
IGZyYW1lYnVmZmVyIGlzCisgKiB1c3VhbGx5IGluZGVwZW5kZW50IGZyb20gaGFyZHdhcmUgbGlt
aXRhdGlvbnMuIERyaXZlcnMgY2FuIGluaXRpYWxpemUgc3RydWN0CisgKiBkcm1fbW9kZV9jb25m
aWcubWF4X2hlaWdodCBmcm9tIERSTV9TSEFET1dfUExBTkVfTUFYX0hFSUdIVC4KKyAqLworI2Rl
ZmluZSBEUk1fU0hBRE9XX1BMQU5FX01BWF9IRUlHSFQJKDQwOTZ1KQorCiAvKioKICAqIHN0cnVj
dCBkcm1fc2hhZG93X3BsYW5lX3N0YXRlIC0gcGxhbmUgc3RhdGUgZm9yIHBsYW5lcyB3aXRoIHNo
YWRvdyBidWZmZXJzCiAgKgotLSAKMi4zMy4xCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
