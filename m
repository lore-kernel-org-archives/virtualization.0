Return-Path: <SRS0=FgjU=D3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C02CFC56203
	for <virtualization@archiver.kernel.org>; Tue, 20 Oct 2020 12:21:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 50CC122253
	for <virtualization@archiver.kernel.org>; Tue, 20 Oct 2020 12:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 50CC122253
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DB20886211;
	Tue, 20 Oct 2020 12:21:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nTXTfNzaGM_s; Tue, 20 Oct 2020 12:20:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 36B3C8624A;
	Tue, 20 Oct 2020 12:20:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 17950C1AD6;
	Tue, 20 Oct 2020 12:20:59 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2D12C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 12:20:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id D9F2187310
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 12:20:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fCs+qSDiMfnU
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 12:20:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by hemlock.osuosl.org (Postfix) with ESMTPS id BCB8B872FE
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 12:20:54 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 6E2A2B1AC;
 Tue, 20 Oct 2020 12:20:52 +0000 (UTC)
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
Subject: [PATCH v5 04/10] drm/exynos: Remove empty exynos_drm_gem_prime_{vmap,
 vunmap}()
Date: Tue, 20 Oct 2020 14:20:40 +0200
Message-Id: <20201020122046.31167-5-tzimmermann@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020122046.31167-1-tzimmermann@suse.de>
References: <20201020122046.31167-1-tzimmermann@suse.de>
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

VGhlIGZ1bmN0aW9ucyBleHlub3NfZHJtX2dlbV9wcmltZV97dm1hcCx2dW5tYXB9KCkgYXJlIGVt
cHR5LiBSZW1vdmUKdGhlbSBiZWZvcmUgY2hhbmdpbmcgdGhlIGludGVyZmFjZSB0byB1c2Ugc3Ry
dWN0IGRybV9idWZfbWFwLiBBcyBhIHNpZGUKZWZmZWN0IG9mIHJlbW92aW5nIGRybV9nZW1fcHJp
bWVfdm1hcCgpLCB0aGUgZXJyb3IgY29kZSBjaGFuZ2VzIGZyb20KRU5PTUVNIHRvIEVPUE5PVFNV
UFAuCgpTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5k
ZT4KQWNrZWQtYnk6IENocmlzdGlhbiBLw7ZuaWcgPGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4K
VGVzdGVkLWJ5OiBTYW0gUmF2bmJvcmcgPHNhbUByYXZuYm9yZy5vcmc+Ci0tLQogZHJpdmVycy9n
cHUvZHJtL2V4eW5vcy9leHlub3NfZHJtX2dlbS5jIHwgMTIgLS0tLS0tLS0tLS0tCiBkcml2ZXJz
L2dwdS9kcm0vZXh5bm9zL2V4eW5vc19kcm1fZ2VtLmggfCAgMiAtLQogMiBmaWxlcyBjaGFuZ2Vk
LCAxNCBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0vZXh5bm9zL2V4
eW5vc19kcm1fZ2VtLmMgYi9kcml2ZXJzL2dwdS9kcm0vZXh5bm9zL2V4eW5vc19kcm1fZ2VtLmMK
aW5kZXggZTdhNmViOTZmNjkyLi4xM2EzNTYyM2FjMDQgMTAwNjQ0Ci0tLSBhL2RyaXZlcnMvZ3B1
L2RybS9leHlub3MvZXh5bm9zX2RybV9nZW0uYworKysgYi9kcml2ZXJzL2dwdS9kcm0vZXh5bm9z
L2V4eW5vc19kcm1fZ2VtLmMKQEAgLTEzNyw4ICsxMzcsNiBAQCBzdGF0aWMgY29uc3Qgc3RydWN0
IHZtX29wZXJhdGlvbnNfc3RydWN0IGV4eW5vc19kcm1fZ2VtX3ZtX29wcyA9IHsKIHN0YXRpYyBj
b25zdCBzdHJ1Y3QgZHJtX2dlbV9vYmplY3RfZnVuY3MgZXh5bm9zX2RybV9nZW1fb2JqZWN0X2Z1
bmNzID0gewogCS5mcmVlID0gZXh5bm9zX2RybV9nZW1fZnJlZV9vYmplY3QsCiAJLmdldF9zZ190
YWJsZSA9IGV4eW5vc19kcm1fZ2VtX3ByaW1lX2dldF9zZ190YWJsZSwKLQkudm1hcCA9IGV4eW5v
c19kcm1fZ2VtX3ByaW1lX3ZtYXAsCi0JLnZ1bm1hcAk9IGV4eW5vc19kcm1fZ2VtX3ByaW1lX3Z1
bm1hcCwKIAkudm1fb3BzID0gJmV4eW5vc19kcm1fZ2VtX3ZtX29wcywKIH07CiAKQEAgLTQ3MSwx
NiArNDY5LDYgQEAgZXh5bm9zX2RybV9nZW1fcHJpbWVfaW1wb3J0X3NnX3RhYmxlKHN0cnVjdCBk
cm1fZGV2aWNlICpkZXYsCiAJcmV0dXJuICZleHlub3NfZ2VtLT5iYXNlOwogfQogCi12b2lkICpl
eHlub3NfZHJtX2dlbV9wcmltZV92bWFwKHN0cnVjdCBkcm1fZ2VtX29iamVjdCAqb2JqKQotewot
CXJldHVybiBOVUxMOwotfQotCi12b2lkIGV4eW5vc19kcm1fZ2VtX3ByaW1lX3Z1bm1hcChzdHJ1
Y3QgZHJtX2dlbV9vYmplY3QgKm9iaiwgdm9pZCAqdmFkZHIpCi17Ci0JLyogTm90aGluZyB0byBk
byAqLwotfQotCiBpbnQgZXh5bm9zX2RybV9nZW1fcHJpbWVfbW1hcChzdHJ1Y3QgZHJtX2dlbV9v
YmplY3QgKm9iaiwKIAkJCSAgICAgIHN0cnVjdCB2bV9hcmVhX3N0cnVjdCAqdm1hKQogewpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL2V4eW5vcy9leHlub3NfZHJtX2dlbS5oIGIvZHJpdmVy
cy9ncHUvZHJtL2V4eW5vcy9leHlub3NfZHJtX2dlbS5oCmluZGV4IDc0ZTkyNmFiZWZmMC4uYTIz
MjcyZmI5NmZiIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vZXh5bm9zL2V4eW5vc19kcm1f
Z2VtLmgKKysrIGIvZHJpdmVycy9ncHUvZHJtL2V4eW5vcy9leHlub3NfZHJtX2dlbS5oCkBAIC0x
MDcsOCArMTA3LDYgQEAgc3RydWN0IGRybV9nZW1fb2JqZWN0ICoKIGV4eW5vc19kcm1fZ2VtX3By
aW1lX2ltcG9ydF9zZ190YWJsZShzdHJ1Y3QgZHJtX2RldmljZSAqZGV2LAogCQkJCSAgICAgc3Ry
dWN0IGRtYV9idWZfYXR0YWNobWVudCAqYXR0YWNoLAogCQkJCSAgICAgc3RydWN0IHNnX3RhYmxl
ICpzZ3QpOwotdm9pZCAqZXh5bm9zX2RybV9nZW1fcHJpbWVfdm1hcChzdHJ1Y3QgZHJtX2dlbV9v
YmplY3QgKm9iaik7Ci12b2lkIGV4eW5vc19kcm1fZ2VtX3ByaW1lX3Z1bm1hcChzdHJ1Y3QgZHJt
X2dlbV9vYmplY3QgKm9iaiwgdm9pZCAqdmFkZHIpOwogaW50IGV4eW5vc19kcm1fZ2VtX3ByaW1l
X21tYXAoc3RydWN0IGRybV9nZW1fb2JqZWN0ICpvYmosCiAJCQkgICAgICBzdHJ1Y3Qgdm1fYXJl
YV9zdHJ1Y3QgKnZtYSk7CiAKLS0gCjIuMjguMAoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
