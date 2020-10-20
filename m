Return-Path: <SRS0=FgjU=D3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65384C61DD8
	for <virtualization@archiver.kernel.org>; Tue, 20 Oct 2020 12:21:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EF1B222253
	for <virtualization@archiver.kernel.org>; Tue, 20 Oct 2020 12:21:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EF1B222253
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4FDCD86B60;
	Tue, 20 Oct 2020 12:21:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HG+dtVbvZg1t; Tue, 20 Oct 2020 12:21:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 8878186B67;
	Tue, 20 Oct 2020 12:21:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 79457C088B;
	Tue, 20 Oct 2020 12:21:00 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 944BDC088B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 12:20:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7A17786B6B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 12:20:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id FLncDiVhUteJ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 12:20:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 75F4A86B42
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 12:20:54 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id F029AB1D0;
 Tue, 20 Oct 2020 12:20:51 +0000 (UTC)
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
Subject: [PATCH v5 01/10] drm/vram-helper: Remove invariant parameters from
 internal kmap function
Date: Tue, 20 Oct 2020 14:20:37 +0200
Message-Id: <20201020122046.31167-2-tzimmermann@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20201020122046.31167-1-tzimmermann@suse.de>
References: <20201020122046.31167-1-tzimmermann@suse.de>
MIME-Version: 1.0
Cc: linux-samsung-soc@vger.kernel.org, lima@lists.freedesktop.org,
 nouveau@lists.freedesktop.org, Daniel Vetter <daniel.vetter@ffwll.ch>,
 etnaviv@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org, linaro-mm-sig@lists.linaro.org,
 linux-rockchip@lists.infradead.org, dri-devel@lists.freedesktop.org,
 Thomas Zimmermann <tzimmermann@suse.de>, xen-devel@lists.xenproject.org,
 spice-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-media@vger.kernel.org
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

VGhlIHBhcmFtZXRlcnMgbWFwIGFuZCBpc19pb21lbSBhcmUgYWx3YXlzIG9mIHRoZSBzYW1lIHZh
bHVlLiBSZW1vdmVkIHRoZW0KdG8gcHJlcGFyZXMgdGhlIGZ1bmN0aW9uIGZvciBjb252ZXJzaW9u
IHRvIHN0cnVjdCBkbWFfYnVmX21hcC4KCnY0OgoJKiBkb24ndCBjaGVjayBmb3IgIWttYXAtPnZp
cnR1YWw7IHdpbGwgYWx3YXlzIGJlIGZhbHNlCgpTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgWmltbWVy
bWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4KUmV2aWV3ZWQtYnk6IERhbmllbCBWZXR0ZXIgPGRh
bmllbC52ZXR0ZXJAZmZ3bGwuY2g+ClJldmlld2VkLWJ5OiBDaHJpc3RpYW4gS8O2bmlnIDxjaHJp
c3RpYW4ua29lbmlnQGFtZC5jb20+ClRlc3RlZC1ieTogU2FtIFJhdm5ib3JnIDxzYW1AcmF2bmJv
cmcub3JnPgotLS0KIGRyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtX3ZyYW1faGVscGVyLmMgfCAxOCAr
KysrLS0tLS0tLS0tLS0tLS0KIDEgZmlsZSBjaGFuZ2VkLCA0IGluc2VydGlvbnMoKyksIDE0IGRl
bGV0aW9ucygtKQoKZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtX3ZyYW1faGVs
cGVyLmMgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2dlbV92cmFtX2hlbHBlci5jCmluZGV4IDdhZWI1
ZGFmMjgwNS4uYmZjMDU5OTQ1ZTMxIDEwMDY0NAotLS0gYS9kcml2ZXJzL2dwdS9kcm0vZHJtX2dl
bV92cmFtX2hlbHBlci5jCisrKyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtX3ZyYW1faGVscGVy
LmMKQEAgLTM3OSwzMiArMzc5LDIyIEBAIGludCBkcm1fZ2VtX3ZyYW1fdW5waW4oc3RydWN0IGRy
bV9nZW1fdnJhbV9vYmplY3QgKmdibykKIH0KIEVYUE9SVF9TWU1CT0woZHJtX2dlbV92cmFtX3Vu
cGluKTsKIAotc3RhdGljIHZvaWQgKmRybV9nZW1fdnJhbV9rbWFwX2xvY2tlZChzdHJ1Y3QgZHJt
X2dlbV92cmFtX29iamVjdCAqZ2JvLAotCQkJCSAgICAgIGJvb2wgbWFwLCBib29sICppc19pb21l
bSkKK3N0YXRpYyB2b2lkICpkcm1fZ2VtX3ZyYW1fa21hcF9sb2NrZWQoc3RydWN0IGRybV9nZW1f
dnJhbV9vYmplY3QgKmdibykKIHsKIAlpbnQgcmV0OwogCXN0cnVjdCB0dG1fYm9fa21hcF9vYmog
KmttYXAgPSAmZ2JvLT5rbWFwOworCWJvb2wgaXNfaW9tZW07CiAKIAlpZiAoZ2JvLT5rbWFwX3Vz
ZV9jb3VudCA+IDApCiAJCWdvdG8gb3V0OwogCi0JaWYgKGttYXAtPnZpcnR1YWwgfHwgIW1hcCkK
LQkJZ290byBvdXQ7Ci0KIAlyZXQgPSB0dG1fYm9fa21hcCgmZ2JvLT5ibywgMCwgZ2JvLT5iby5u
dW1fcGFnZXMsIGttYXApOwogCWlmIChyZXQpCiAJCXJldHVybiBFUlJfUFRSKHJldCk7CiAKIG91
dDoKLQlpZiAoIWttYXAtPnZpcnR1YWwpIHsKLQkJaWYgKGlzX2lvbWVtKQotCQkJKmlzX2lvbWVt
ID0gZmFsc2U7Ci0JCXJldHVybiBOVUxMOyAvKiBub3QgbWFwcGVkOyBkb24ndCBpbmNyZW1lbnQg
cmVmICovCi0JfQogCSsrZ2JvLT5rbWFwX3VzZV9jb3VudDsKLQlpZiAoaXNfaW9tZW0pCi0JCXJl
dHVybiB0dG1fa21hcF9vYmpfdmlydHVhbChrbWFwLCBpc19pb21lbSk7Ci0JcmV0dXJuIGttYXAt
PnZpcnR1YWw7CisJcmV0dXJuIHR0bV9rbWFwX29ial92aXJ0dWFsKGttYXAsICZpc19pb21lbSk7
CiB9CiAKIHN0YXRpYyB2b2lkIGRybV9nZW1fdnJhbV9rdW5tYXBfbG9ja2VkKHN0cnVjdCBkcm1f
Z2VtX3ZyYW1fb2JqZWN0ICpnYm8pCkBAIC00NDksNyArNDM5LDcgQEAgdm9pZCAqZHJtX2dlbV92
cmFtX3ZtYXAoc3RydWN0IGRybV9nZW1fdnJhbV9vYmplY3QgKmdibykKIAlyZXQgPSBkcm1fZ2Vt
X3ZyYW1fcGluX2xvY2tlZChnYm8sIDApOwogCWlmIChyZXQpCiAJCWdvdG8gZXJyX3R0bV9ib191
bnJlc2VydmU7Ci0JYmFzZSA9IGRybV9nZW1fdnJhbV9rbWFwX2xvY2tlZChnYm8sIHRydWUsIE5V
TEwpOworCWJhc2UgPSBkcm1fZ2VtX3ZyYW1fa21hcF9sb2NrZWQoZ2JvKTsKIAlpZiAoSVNfRVJS
KGJhc2UpKSB7CiAJCXJldCA9IFBUUl9FUlIoYmFzZSk7CiAJCWdvdG8gZXJyX2RybV9nZW1fdnJh
bV91bnBpbl9sb2NrZWQ7Ci0tIAoyLjI4LjAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
