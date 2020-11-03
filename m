Return-Path: <SRS0=JeE0=EJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0986EC63697
	for <virtualization@archiver.kernel.org>; Tue,  3 Nov 2020 09:30:25 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8264A2242A
	for <virtualization@archiver.kernel.org>; Tue,  3 Nov 2020 09:30:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8264A2242A
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id EDD1E86C13;
	Tue,  3 Nov 2020 09:30:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id yjYO0MUT6RKD; Tue,  3 Nov 2020 09:30:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 2E1A486BBE;
	Tue,  3 Nov 2020 09:30:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E4DEC08A1;
	Tue,  3 Nov 2020 09:30:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8229DC0889
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 09:30:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7595E86BE7
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 09:30:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id h2s0Vbn3UoSj
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 09:30:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTP id 5165A86BBE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 09:30:20 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 398E5B016;
 Tue,  3 Nov 2020 09:30:19 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: maarten.lankhorst@linux.intel.com, mripard@kernel.org, airlied@linux.ie,
 daniel@ffwll.ch, sam@ravnborg.org, alexander.deucher@amd.com,
 christian.koenig@amd.com, kraxel@redhat.com, l.stach@pengutronix.de,
 linux+etnaviv@armlinux.org.uk, christian.gmeiner@gmail.com,
 inki.dae@samsung.com, jy0922.shim@samsung.com, sw0312.kim@samsung.com,
 kyungmin.park@samsung.com, kgene@kernel.org, krzk@kernel.org,
 yuq825@gmail.com, bskeggs@redhat.com, robh@kernel.org,
 tomeu.vizoso@collabora.com, steven.price@arm.com,
 alyssa.rosenzweig@collabora.com, hjc@rock-chips.com, heiko@sntech.de,
 hdegoede@redhat.com, sean@poorly.run, eric@anholt.net,
 oleksandr_andrushchenko@epam.com, ray.huang@amd.com,
 sumit.semwal@linaro.org, emil.velikov@collabora.com, luben.tuikov@amd.com,
 apaneers@amd.com, linus.walleij@linaro.org, melissa.srw@gmail.com,
 chris@chris-wilson.co.uk, miaoqinglang@huawei.com
Subject: [PATCH v7 02/10] drm/cma-helper: Remove empty
 drm_gem_cma_prime_vunmap()
Date: Tue,  3 Nov 2020 10:30:07 +0100
Message-Id: <20201103093015.1063-3-tzimmermann@suse.de>
X-Mailer: git-send-email 2.29.0
In-Reply-To: <20201103093015.1063-1-tzimmermann@suse.de>
References: <20201103093015.1063-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: linux-samsung-soc@vger.kernel.org, lima@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, etnaviv@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, virtualization@lists.linux-foundation.org,
 linaro-mm-sig@lists.linaro.org, linux-rockchip@lists.infradead.org,
 dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 xen-devel@lists.xenproject.org, spice-devel@lists.freedesktop.org,
 linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org
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

VGhlIGZ1bmN0aW9uIGRybV9nZW1fY21hX3ByaW1lX3Z1bm1hcCgpIGlzIGVtcHR5LiBSZW1vdmUg
aXQgYmVmb3JlCmNoYW5naW5nIHRoZSBpbnRlcmZhY2UgdG8gdXNlIHN0cnVjdCBkcm1fYnVmX21h
cC4KClNpZ25lZC1vZmYtYnk6IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRl
PgpSZXZpZXdlZC1ieTogQ2hyaXN0aWFuIEvDtm5pZyA8Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29t
PgpUZXN0ZWQtYnk6IFNhbSBSYXZuYm9yZyA8c2FtQHJhdm5ib3JnLm9yZz4KLS0tCiBkcml2ZXJz
L2dwdS9kcm0vZHJtX2dlbV9jbWFfaGVscGVyLmMgfCAxNyAtLS0tLS0tLS0tLS0tLS0tLQogZHJp
dmVycy9ncHUvZHJtL3ZjNC92YzRfYm8uYyAgICAgICAgIHwgIDEgLQogaW5jbHVkZS9kcm0vZHJt
X2dlbV9jbWFfaGVscGVyLmggICAgIHwgIDEgLQogMyBmaWxlcyBjaGFuZ2VkLCAxOSBkZWxldGlv
bnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2dlbV9jbWFfaGVscGVyLmMg
Yi9kcml2ZXJzL2dwdS9kcm0vZHJtX2dlbV9jbWFfaGVscGVyLmMKaW5kZXggMjE2NTYzM2M5Yjll
Li5kNTI3NDg1ZWEwYjcgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtX2NtYV9o
ZWxwZXIuYworKysgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2dlbV9jbWFfaGVscGVyLmMKQEAgLTUz
NywyMyArNTM3LDYgQEAgdm9pZCAqZHJtX2dlbV9jbWFfcHJpbWVfdm1hcChzdHJ1Y3QgZHJtX2dl
bV9vYmplY3QgKm9iaikKIH0KIEVYUE9SVF9TWU1CT0xfR1BMKGRybV9nZW1fY21hX3ByaW1lX3Zt
YXApOwogCi0vKioKLSAqIGRybV9nZW1fY21hX3ByaW1lX3Z1bm1hcCAtIHVubWFwIGEgQ01BIEdF
TSBvYmplY3QgZnJvbSB0aGUga2VybmVsJ3MgdmlydHVhbAotICogICAgIGFkZHJlc3Mgc3BhY2UK
LSAqIEBvYmo6IEdFTSBvYmplY3QKLSAqIEB2YWRkcjoga2VybmVsIHZpcnR1YWwgYWRkcmVzcyB3
aGVyZSB0aGUgQ01BIEdFTSBvYmplY3Qgd2FzIG1hcHBlZAotICoKLSAqIFRoaXMgZnVuY3Rpb24g
cmVtb3ZlcyBhIGJ1ZmZlciBleHBvcnRlZCB2aWEgRFJNIFBSSU1FIGZyb20gdGhlIGtlcm5lbCdz
Ci0gKiB2aXJ0dWFsIGFkZHJlc3Mgc3BhY2UuIFRoaXMgaXMgYSBuby1vcCBiZWNhdXNlIENNQSBi
dWZmZXJzIGNhbm5vdCBiZQotICogdW5tYXBwZWQgZnJvbSBrZXJuZWwgc3BhY2UuIERyaXZlcnMg
dXNpbmcgdGhlIENNQSBoZWxwZXJzIHNob3VsZCBzZXQgdGhpcwotICogYXMgdGhlaXIgJmRybV9n
ZW1fb2JqZWN0X2Z1bmNzLnZ1bm1hcCBjYWxsYmFjay4KLSAqLwotdm9pZCBkcm1fZ2VtX2NtYV9w
cmltZV92dW5tYXAoc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmosIHZvaWQgKnZhZGRyKQotewot
CS8qIE5vdGhpbmcgdG8gZG8gKi8KLX0KLUVYUE9SVF9TWU1CT0xfR1BMKGRybV9nZW1fY21hX3By
aW1lX3Z1bm1hcCk7Ci0KIHN0YXRpYyBjb25zdCBzdHJ1Y3QgZHJtX2dlbV9vYmplY3RfZnVuY3Mg
ZHJtX2dlbV9jbWFfZGVmYXVsdF9mdW5jcyA9IHsKIAkuZnJlZSA9IGRybV9nZW1fY21hX2ZyZWVf
b2JqZWN0LAogCS5wcmludF9pbmZvID0gZHJtX2dlbV9jbWFfcHJpbnRfaW5mbywKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS92YzQvdmM0X2JvLmMgYi9kcml2ZXJzL2dwdS9kcm0vdmM0L3Zj
NF9iby5jCmluZGV4IGY0MzIyNzgxNzNjZC4uNTU3ZjBkMWU2NDM3IDEwMDY0NAotLS0gYS9kcml2
ZXJzL2dwdS9kcm0vdmM0L3ZjNF9iby5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS92YzQvdmM0X2Jv
LmMKQEAgLTM4Nyw3ICszODcsNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IGRybV9nZW1fb2JqZWN0
X2Z1bmNzIHZjNF9nZW1fb2JqZWN0X2Z1bmNzID0gewogCS5leHBvcnQgPSB2YzRfcHJpbWVfZXhw
b3J0LAogCS5nZXRfc2dfdGFibGUgPSBkcm1fZ2VtX2NtYV9wcmltZV9nZXRfc2dfdGFibGUsCiAJ
LnZtYXAgPSB2YzRfcHJpbWVfdm1hcCwKLQkudnVubWFwID0gZHJtX2dlbV9jbWFfcHJpbWVfdnVu
bWFwLAogCS52bV9vcHMgPSAmdmM0X3ZtX29wcywKIH07CiAKZGlmZiAtLWdpdCBhL2luY2x1ZGUv
ZHJtL2RybV9nZW1fY21hX2hlbHBlci5oIGIvaW5jbHVkZS9kcm0vZHJtX2dlbV9jbWFfaGVscGVy
LmgKaW5kZXggMmJmYTI1MDI2MDdhLi5hMDY0YjBkMWM0ODAgMTAwNjQ0Ci0tLSBhL2luY2x1ZGUv
ZHJtL2RybV9nZW1fY21hX2hlbHBlci5oCisrKyBiL2luY2x1ZGUvZHJtL2RybV9nZW1fY21hX2hl
bHBlci5oCkBAIC0xMDQsNyArMTA0LDYgQEAgZHJtX2dlbV9jbWFfcHJpbWVfaW1wb3J0X3NnX3Rh
YmxlKHN0cnVjdCBkcm1fZGV2aWNlICpkZXYsCiBpbnQgZHJtX2dlbV9jbWFfcHJpbWVfbW1hcChz
dHJ1Y3QgZHJtX2dlbV9vYmplY3QgKm9iaiwKIAkJCSAgIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAq
dm1hKTsKIHZvaWQgKmRybV9nZW1fY21hX3ByaW1lX3ZtYXAoc3RydWN0IGRybV9nZW1fb2JqZWN0
ICpvYmopOwotdm9pZCBkcm1fZ2VtX2NtYV9wcmltZV92dW5tYXAoc3RydWN0IGRybV9nZW1fb2Jq
ZWN0ICpvYmosIHZvaWQgKnZhZGRyKTsKIAogc3RydWN0IGRybV9nZW1fb2JqZWN0ICoKIGRybV9n
ZW1fY21hX2NyZWF0ZV9vYmplY3RfZGVmYXVsdF9mdW5jcyhzdHJ1Y3QgZHJtX2RldmljZSAqZGV2
LCBzaXplX3Qgc2l6ZSk7Ci0tIAoyLjI5LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
