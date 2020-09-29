Return-Path: <SRS0=hez8=DG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8CA86C47423
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 15:16:58 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0B64020773
	for <virtualization@archiver.kernel.org>; Tue, 29 Sep 2020 15:16:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0B64020773
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9D19A203C9;
	Tue, 29 Sep 2020 15:16:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QnO9+569EXSw; Tue, 29 Sep 2020 15:16:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0D1892034C;
	Tue, 29 Sep 2020 15:16:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D1EE9C0889;
	Tue, 29 Sep 2020 15:16:53 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1776BC0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 15:16:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 00FCD85B68
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 15:16:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VrHsu+jHKYod
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 15:16:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 055FE8675E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Sep 2020 15:14:48 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 78C88AE85;
 Tue, 29 Sep 2020 15:14:46 +0000 (UTC)
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
Subject: [PATCH v3 7/7] drm/todo: Update entries around struct dma_buf_map
Date: Tue, 29 Sep 2020 17:14:37 +0200
Message-Id: <20200929151437.19717-8-tzimmermann@suse.de>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200929151437.19717-1-tzimmermann@suse.de>
References: <20200929151437.19717-1-tzimmermann@suse.de>
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

SW5zdGFuY2VzIG9mIHN0cnVjdCBkbWFfYnVmX21hcCBzaG91bGQgYmUgdXNlZnVsIHRocm91Z2hv
dXQgRFJNJ3MKbWVtb3J5IG1hbmFnZW1lbnQgY29kZS4gRnVydGhlcm1vcmUsIHNldmVyYWwgZHJp
dmVycyBjYW4gbm93IHVzZQpnZW5lcmljIGZiZGV2IGVtdWxhdGlvbi4KClNpZ25lZC1vZmYtYnk6
IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPgotLS0KIERvY3VtZW50YXRp
b24vZ3B1L3RvZG8ucnN0IHwgMjQgKysrKysrKysrKysrKysrKysrKysrKy0tCiAxIGZpbGUgY2hh
bmdlZCwgMjIgaW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKCmRpZmYgLS1naXQgYS9Eb2N1
bWVudGF0aW9uL2dwdS90b2RvLnJzdCBiL0RvY3VtZW50YXRpb24vZ3B1L3RvZG8ucnN0CmluZGV4
IDM3NTFhYzk3NmMzZS4uMDIzNjI2YzE4MzdiIDEwMDY0NAotLS0gYS9Eb2N1bWVudGF0aW9uL2dw
dS90b2RvLnJzdAorKysgYi9Eb2N1bWVudGF0aW9uL2dwdS90b2RvLnJzdApAQCAtMTk3LDggKzE5
NywxMCBAQCBDb252ZXJ0IGRyaXZlcnMgdG8gdXNlIGRybV9mYmRldl9nZW5lcmljX3NldHVwKCkK
IC0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQogCiBNb3N0
IGRyaXZlcnMgY2FuIHVzZSBkcm1fZmJkZXZfZ2VuZXJpY19zZXR1cCgpLiBEcml2ZXIgaGF2ZSB0
byBpbXBsZW1lbnQKLWF0b21pYyBtb2Rlc2V0dGluZyBhbmQgR0VNIHZtYXAgc3VwcG9ydC4gQ3Vy
cmVudCBnZW5lcmljIGZiZGV2IGVtdWxhdGlvbgotZXhwZWN0cyB0aGUgZnJhbWVidWZmZXIgaW4g
c3lzdGVtIG1lbW9yeSAob3Igc3lzdGVtLWxpa2UgbWVtb3J5KS4KK2F0b21pYyBtb2Rlc2V0dGlu
ZyBhbmQgR0VNIHZtYXAgc3VwcG9ydC4gSGlzdG9yaWNhbGx5LCBnZW5lcmljIGZiZGV2IGVtdWxh
dGlvbgorZXhwZWN0ZWQgdGhlIGZyYW1lYnVmZmVyIGluIHN5c3RlbSBtZW1vcnkgb3Igc3lzdGVt
LWxpa2UgbWVtb3J5LiBCeSBlbXBsb3lpbmcKK3N0cnVjdCBkbWFfYnVmX21hcCwgZHJpdmVycyB3
aXRoIGZyYW1idWZmZXJzIGluIEkvTyBtZW1vcnkgY2FuIGJlIHN1cHBvcnRlZAorYXMgd2VsbC4K
IAogQ29udGFjdDogTWFpbnRhaW5lciBvZiB0aGUgZHJpdmVyIHlvdSBwbGFuIHRvIGNvbnZlcnQK
IApAQCAtNDQ2LDYgKzQ0OCwyNCBAQCBDb250YWN0OiBWaWxsZSBTeXJqw6Rsw6QsIERhbmllbCBW
ZXR0ZXIKIAogTGV2ZWw6IEludGVybWVkaWF0ZQogCitVc2Ugc3RydWN0IGRtYV9idWZfbWFwIHRo
cm91Z2hvdXQgY29kZWJhc2UKKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLQorCitQb2ludGVycyB0byBzaGFyZWQgZGV2aWNlIG1lbW9yeSBhcmUgc3RvcmVkIGluIHN0
cnVjdCBkbWFfYnVmX21hcC4gRWFjaAoraW5zdGFuY2Uga25vd3Mgd2hldGhlciBpdCByZWZlcnMg
dG8gc3lzdGVtIG9yIEkvTyBtZW1vcnkuIE1vc3Qgb2YgdGhlIERSTS13aWRlCitpbnRlcmZhY2Ug
aGF2ZSBiZWVuIGNvbnZlcnRlZCB0byB1c2Ugc3RydWN0IGRtYV9idWZfbWFwLCBidXQgaW1wbGVt
ZW50YXRpb25zCitvZnRlbiBzdGlsbCB1c2UgcmF3IHBvaW50ZXJzLgorCitUaGUgdGFzayBpcyB0
byB1c2Ugc3RydWN0IGRtYV9idWZfbWFwIHdoZXJlIGl0IG1ha2VzIHNlbnNlLgorCisqIE1lbW9y
eSBtYW5hZ2VycyBzaG91bGQgdXNlIHN0cnVjdCBkbWFfYnVmX21hcCBmb3IgZG1hLWJ1Zi1pbXBv
cnRlZCBidWZmZXJzLgorKiBUVE0gbWlnaHQgYmVuZWZpdCBmcm9tIHVzaW5nIHN0cnVjdCBkbWFf
YnVmX21hcCBpbnRlcm5hbGx5LgorKiBGcmFtZWJ1ZmZlciBjb3B5aW5nIGFuZCBibGl0dGluZyBo
ZWxwZXJzIHNob3VsZCBvcGVyYXRlIG9uIHN0cnVjdCBkbWFfYnVmX21hcC4KKworQ29udGFjdDog
VGhvbWFzIFppbW1lcm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+LCBDaHJpc3RpYW4gS8O2bmln
LCBEYW5pZWwgVmV0dGVyCisKK0xldmVsOiBJbnRlcm1lZGlhdGUKKwogCiBDb3JlIHJlZmFjdG9y
aW5ncwogPT09PT09PT09PT09PT09PT0KLS0gCjIuMjguMAoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
