Return-Path: <SRS0=rWzq=EQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87965C388F7
	for <virtualization@archiver.kernel.org>; Tue, 10 Nov 2020 13:37:05 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 03CAA206B6
	for <virtualization@archiver.kernel.org>; Tue, 10 Nov 2020 13:37:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 03CAA206B6
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6A1DE86404;
	Tue, 10 Nov 2020 13:37:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6HLpGoGENI70; Tue, 10 Nov 2020 13:37:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 87335863D5;
	Tue, 10 Nov 2020 13:37:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B978C088B;
	Tue, 10 Nov 2020 13:37:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1BAEAC016F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Nov 2020 13:37:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 15FDB86404
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Nov 2020 13:37:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5rw7Osqxo961
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Nov 2020 13:37:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 6A47F863D5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Nov 2020 13:37:00 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 65E00ABD6;
 Tue, 10 Nov 2020 13:36:58 +0000 (UTC)
From: Thomas Zimmermann <tzimmermann@suse.de>
To: bskeggs@redhat.com, airlied@linux.ie, daniel@ffwll.ch,
 michael.j.ruhl@intel.com, christian.koenig@amd.com
Subject: [PATCH] drm/nouveau: Fix out-of-bounds access when deferencing MMU
 type
Date: Tue, 10 Nov 2020 14:36:55 +0100
Message-Id: <20201110133655.13174-1-tzimmermann@suse.de>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Cc: amd-gfx@lists.freedesktop.org, nouveau@lists.freedesktop.org,
 Felix Kuehling <Felix.Kuehling@amd.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, virtualization@lists.linux-foundation.org,
 Roland Scheidegger <sroland@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Huang Rui <ray.huang@amd.com>,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 dri-devel@lists.freedesktop.org, Thomas Zimmermann <tzimmermann@suse.de>,
 spice-devel@lists.freedesktop.org, Alex Deucher <alexander.deucher@amd.com>,
 Dave Airlie <airlied@redhat.com>, Likun Gao <Likun.Gao@amd.com>,
 Hawking Zhang <Hawking.Zhang@amd.com>
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

VGhlIHZhbHVlIG9mIHN0cnVjdCBkcm1fZGV2aWNlLnR0bS50eXBlX3ZyYW0gY2FuIGJlY29tZSAt
MSBmb3IgdW5rbm93bgp0eXBlcyBvZiBtZW1vcnkgKHNlZSBub3V2ZWF1X3R0bV9pbml0KCkpLiBU
aGlzIGxlYWRzIHRvIGFuIG91dC1vZi1ib3VuZHMKZXJyb3Igd2hlbiBhY2Nlc3Npbmcgc3RydWN0
IG52aWZfbW11LnR5cGVbXToKCiAgWyAgIDE4LjMwNDExNl0gPT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09CiAgWyAgIDE4LjMx
MTY0OV0gQlVHOiBLQVNBTjogc2xhYi1vdXQtb2YtYm91bmRzIGluIG5vdXZlYXVfdHRtX2lvX21l
bV9yZXNlcnZlKzB4MTdhLzB4N2UwIFtub3V2ZWF1XQogIFsgICAxOC4zMjA0MTVdIFJlYWQgb2Yg
c2l6ZSAxIGF0IGFkZHIgZmZmZjg4ODEwZmZhYzFmZSBieSB0YXNrIHN5c3RlbWQtdWRldmQvMzQy
CiAgWyAgIDE4LjMyNzY4MV0KICBbICAgMTguMzI5MjA4XSBDUFU6IDEgUElEOiAzNDIgQ29tbTog
c3lzdGVtZC11ZGV2ZCBUYWludGVkOiBHICAgICAgICAgICAgRSAgICAgNS4xMC4wLXJjMi0xLWRl
ZmF1bHQrICM1ODEKICBbICAgMTguMzM4NjgxXSBIYXJkd2FyZSBuYW1lOiBEZWxsIEluYy4gT3B0
aVBsZXggOTAyMC8wTjRZQzgsIEJJT1MgQTI0IDEwLzI0LzIwMTgKICBbICAgMTguMzQ2MDMyXSBD
YWxsIFRyYWNlOgogIFsgICAxOC4zNDg1MzZdICBkdW1wX3N0YWNrKzB4YWUvMHhlNQogIFsgICAx
OC4zNTE5MTldICBwcmludF9hZGRyZXNzX2Rlc2NyaXB0aW9uLmNvbnN0cHJvcC4wKzB4MTcvMHhm
MAogIFsgICAxOC4zNTc3ODddICA/IG5vdXZlYXVfdHRtX2lvX21lbV9yZXNlcnZlKzB4MTdhLzB4
N2UwIFtub3V2ZWF1XQogIFsgICAxOC4zNjM4MThdICBfX2thc2FuX3JlcG9ydC5jb2xkKzB4MjAv
MHgzOAogIFsgICAxOC4zNjgwOTldICA/IG5vdXZlYXVfdHRtX2lvX21lbV9yZXNlcnZlKzB4MTdh
LzB4N2UwIFtub3V2ZWF1XQogIFsgICAxOC4zNzQxMzNdICBrYXNhbl9yZXBvcnQrMHgzYS8weDUw
CiAgWyAgIDE4LjM3Nzc4OV0gIG5vdXZlYXVfdHRtX2lvX21lbV9yZXNlcnZlKzB4MTdhLzB4N2Uw
IFtub3V2ZWF1XQogIDwuLi4+CiAgWyAgIDE4Ljc2NzY5MF0gQWxsb2NhdGVkIGJ5IHRhc2sgMzQy
OgogIFsgICAxOC43NzMwODddICBrYXNhbl9zYXZlX3N0YWNrKzB4MWIvMHg0MAogIFsgICAxOC43
Nzg4OTBdICBfX2thc2FuX2ttYWxsb2MuY29uc3Rwcm9wLjArMHhiZi8weGQwCiAgWyAgIDE4Ljc4
NTY0Nl0gIF9fa21hbGxvY190cmFja19jYWxsZXIrMHgxYmUvMHgzOTAKICBbICAgMTguNzkyMTY1
XSAga3N0cmR1cF9jb25zdCsweDQ2LzB4NzAKICBbICAgMTguNzk3Njg2XSAga29iamVjdF9zZXRf
bmFtZV92YXJncysweDJmLzB4YjAKICBbICAgMTguODAzOTkyXSAga29iamVjdF9pbml0X2FuZF9h
ZGQrMHg5ZC8weGYwCiAgWyAgIDE4LjgxMDExN10gIHR0bV9tZW1fZ2xvYmFsX2luaXQrMHgxMmMv
MHgyMTAgW3R0bV0KICBbICAgMTguODE2ODUzXSAgdHRtX2JvX2dsb2JhbF9pbml0KzB4NGEvMHgx
NjAgW3R0bV0KICBbICAgMTguODIzNDIwXSAgdHRtX2JvX2RldmljZV9pbml0KzB4MzkvMHgyMjAg
W3R0bV0KICBbICAgMTguODMwMDQ2XSAgbm91dmVhdV90dG1faW5pdCsweDJjMy8weDgzMCBbbm91
dmVhdV0KICBbICAgMTguODM2OTI5XSAgbm91dmVhdV9kcm1fZGV2aWNlX2luaXQrMHgxYjQvMHgz
ZjAgW25vdXZlYXVdCiAgPC4uLj4KICBbICAgMTkuMTA1MzM2XSA9PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KCkZpeCB0aGlz
IGVycm9yLCBieSBub3QgdXNpbmcgdHlwZV92cmFtIGFzIGFuIGluZGV4IGlmIGl0J3MgbmVnYXRp
dmUuCkFzc3VtZSBkZWZhdWx0IHZhbHVlcyBpbnN0ZWFkLgoKVGhlIGVycm9yIHdhcyBzZWVuIG9u
IE52aWRpYSBHNzIgaGFyZHdhcmUuCgpTaWduZWQtb2ZmLWJ5OiBUaG9tYXMgWmltbWVybWFubiA8
dHppbW1lcm1hbm5Ac3VzZS5kZT4KRml4ZXM6IDFjZjY1YzQ1MTgzYSAoImRybS90dG06IGFkZCBj
YWNoaW5nIHN0YXRlIHRvIHR0bV9idXNfcGxhY2VtZW50IikKQ2M6IENocmlzdGlhbiBLw7ZuaWcg
PGNocmlzdGlhbi5rb2VuaWdAYW1kLmNvbT4KQ2M6IE1pY2hhZWwgSi4gUnVobCA8bWljaGFlbC5q
LnJ1aGxAaW50ZWwuY29tPgpDYzogTWFhcnRlbiBMYW5raG9yc3QgPG1hYXJ0ZW4ubGFua2hvcnN0
QGxpbnV4LmludGVsLmNvbT4KQ2M6IE1heGltZSBSaXBhcmQgPG1yaXBhcmRAa2VybmVsLm9yZz4K
Q2M6IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPgpDYzogRGF2aWQgQWly
bGllIDxhaXJsaWVkQGxpbnV4LmllPgpDYzogRGFuaWVsIFZldHRlciA8ZGFuaWVsQGZmd2xsLmNo
PgpDYzogQmVuIFNrZWdncyA8YnNrZWdnc0ByZWRoYXQuY29tPgpDYzogRGF2ZSBBaXJsaWUgPGFp
cmxpZWRAcmVkaGF0LmNvbT4KQ2M6IEdlcmQgSG9mZm1hbm4gPGtyYXhlbEByZWRoYXQuY29tPgpD
YzogQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hlckBhbWQuY29tPgpDYzogIkNocmlzdGlh
biBLw7ZuaWciIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+CkNjOiBWTXdhcmUgR3JhcGhpY3Mg
PGxpbnV4LWdyYXBoaWNzLW1haW50YWluZXJAdm13YXJlLmNvbT4KQ2M6IFJvbGFuZCBTY2hlaWRl
Z2dlciA8c3JvbGFuZEB2bXdhcmUuY29tPgpDYzogSHVhbmcgUnVpIDxyYXkuaHVhbmdAYW1kLmNv
bT4KQ2M6IEZlbGl4IEt1ZWhsaW5nIDxGZWxpeC5LdWVobGluZ0BhbWQuY29tPgpDYzogSGF3a2lu
ZyBaaGFuZyA8SGF3a2luZy5aaGFuZ0BhbWQuY29tPgpDYzogSmFzb24gR3VudGhvcnBlIDxqZ2dA
emllcGUuY2E+CkNjOiBMaWt1biBHYW8gPExpa3VuLkdhb0BhbWQuY29tPgpDYzogZHJpLWRldmVs
QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwpDYzogbm91dmVhdUBsaXN0cy5mcmVlZGVza3RvcC5vcmcK
Q2M6IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCkNjOiBzcGljZS1k
ZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKQ2M6IGFtZC1nZnhAbGlzdHMuZnJlZWRlc2t0b3Au
b3JnCi0tLQogZHJpdmVycy9ncHUvZHJtL25vdXZlYXUvbm91dmVhdV9iby5jIHwgNSArKysrLQog
MSBmaWxlIGNoYW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQoKZGlmZiAtLWdp
dCBhL2RyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L25vdXZlYXVfYm8uYyBiL2RyaXZlcnMvZ3B1L2Ry
bS9ub3V2ZWF1L25vdXZlYXVfYm8uYwppbmRleCA4MTMzMzc3ZDg2NWQuLmZlMTUyOTlkNDE3ZSAx
MDA2NDQKLS0tIGEvZHJpdmVycy9ncHUvZHJtL25vdXZlYXUvbm91dmVhdV9iby5jCisrKyBiL2Ry
aXZlcnMvZ3B1L2RybS9ub3V2ZWF1L25vdXZlYXVfYm8uYwpAQCAtMTE0Miw5ICsxMTQyLDEyIEBA
IG5vdXZlYXVfdHRtX2lvX21lbV9yZXNlcnZlKHN0cnVjdCB0dG1fYm9fZGV2aWNlICpiZGV2LCBz
dHJ1Y3QgdHRtX3Jlc291cmNlICpyZWcpCiAJc3RydWN0IG52a21fZGV2aWNlICpkZXZpY2UgPSBu
dnh4X2RldmljZSgmZHJtLT5jbGllbnQuZGV2aWNlKTsKIAlzdHJ1Y3Qgbm91dmVhdV9tZW0gKm1l
bSA9IG5vdXZlYXVfbWVtKHJlZyk7CiAJc3RydWN0IG52aWZfbW11ICptbXUgPSAmZHJtLT5jbGll
bnQubW11OwotCWNvbnN0IHU4IHR5cGUgPSBtbXUtPnR5cGVbZHJtLT50dG0udHlwZV92cmFtXS50
eXBlOworCXU4IHR5cGUgPSAwOwogCWludCByZXQ7CiAKKwlpZiAoZHJtLT50dG0udHlwZV92cmFt
ID49IDApCisJCXR5cGUgPSBtbXUtPnR5cGVbZHJtLT50dG0udHlwZV92cmFtXS50eXBlOworCiAJ
bXV0ZXhfbG9jaygmZHJtLT50dG0uaW9fcmVzZXJ2ZV9tdXRleCk7CiByZXRyeToKIAlzd2l0Y2gg
KHJlZy0+bWVtX3R5cGUpIHsKLS0gCjIuMjkuMgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
