Return-Path: <SRS0=RKVt=P5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A7E7FC433FE
	for <virtualization@archiver.kernel.org>; Wed, 10 Nov 2021 10:37:15 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6122A60E8D
	for <virtualization@archiver.kernel.org>; Wed, 10 Nov 2021 10:37:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6122A60E8D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2366960901;
	Wed, 10 Nov 2021 10:37:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xLGHgEpat2WV; Wed, 10 Nov 2021 10:37:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7F09D605AB;
	Wed, 10 Nov 2021 10:37:13 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 398C4C003F;
	Wed, 10 Nov 2021 10:37:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F5EDC0019
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 10:37:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 6657B60901
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 10:37:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id oRLZdRIlVmWf
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 10:37:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 9E0586059F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 10:37:09 +0000 (UTC)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by smtp-out1.suse.de (Postfix) with ESMTPS id C3EA921B17;
 Wed, 10 Nov 2021 10:37:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1636540627; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NkYQaVKrGH7uTRvl4bz/W0pMqdYAOLpVdgrspXEDLgo=;
 b=2M9ONZooniFT/gdbmz4EnYCN9aduttAFKOcyz7YBU5DtAbngHzLivS2GqYOOHBdzpULvUu
 TV5Ec5iEkdzTxWV1j1Kaz2METEDRQ6yiBAQS1oB3libXS42/f/Z/MrD9EjDwd2rgGxkq6Q
 0BWoKqu+IdNaEvcrqQq4OJ95gJznuAg=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1636540627;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NkYQaVKrGH7uTRvl4bz/W0pMqdYAOLpVdgrspXEDLgo=;
 b=sDvOM+0Bkc9eircYBoGci9kxTd/17dgSCU80trUeFT+esBAMiBZzAsxtIcosdJO1CMkxYv
 MYSWfTEoDqkDUYCA==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
 (No client certificate requested)
 by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 4999313E72;
 Wed, 10 Nov 2021 10:37:07 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
 by imap2.suse-dmz.suse.de with ESMTPSA id KPvzENOgi2EnPAAAMHmgww
 (envelope-from <tzimmermann@suse.de>); Wed, 10 Nov 2021 10:37:07 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: daniel@ffwll.ch, airlied@linux.ie, mripard@kernel.org,
 maarten.lankhorst@linux.intel.com, noralf@tronnes.org,
 drawat.floss@gmail.com, airlied@redhat.com, kraxel@redhat.com,
 david@lechnology.com, sam@ravnborg.org, javierm@redhat.com,
 kernel@amanoeldawod.com, dirty.ice.hu@gmail.com,
 michael+lkml@stapelberg.ch, aros@gmx.com, joshua@stroblindustries.com,
 arnd@arndb.de
Subject: [PATCH v3 9/9] drm: Clarify semantics of struct drm_mode_config.{min,
 max}_{width, height}
Date: Wed, 10 Nov 2021 11:37:02 +0100
Message-Id: <20211110103702.374-10-tzimmermann@suse.de>
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

QWRkIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24gb24gdGhlIHNlbWFudGljcyBvZiB0aGUgc2l6ZSBm
aWVsZHMgaW4Kc3RydWN0IGRybV9tb2RlX2NvbmZpZy4gQWxzbyBhZGQgYSBUT0RPIHRvIHJldmll
dyBhbGwgZHJpdmVyIGZvcgpjb3JyZWN0IHVzYWdlIG9mIHRoZXNlIGZpZWxkcy4KClNpZ25lZC1v
ZmYtYnk6IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNlLmRlPgpBY2tlZC1ieTog
Tm9yYWxmIFRyw7hubmVzIDxub3JhbGZAdHJvbm5lcy5vcmc+Ci0tLQogRG9jdW1lbnRhdGlvbi9n
cHUvdG9kby5yc3QgICAgfCAxNSArKysrKysrKysrKysrKysKIGluY2x1ZGUvZHJtL2RybV9tb2Rl
X2NvbmZpZy5oIHwgMTMgKysrKysrKysrKysrKwogMiBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRp
b25zKCspCgpkaWZmIC0tZ2l0IGEvRG9jdW1lbnRhdGlvbi9ncHUvdG9kby5yc3QgYi9Eb2N1bWVu
dGF0aW9uL2dwdS90b2RvLnJzdAppbmRleCA2MGQxZDdlZTA3MTkuLmY0ZTFkNzIxNDlmNyAxMDA2
NDQKLS0tIGEvRG9jdW1lbnRhdGlvbi9ncHUvdG9kby5yc3QKKysrIGIvRG9jdW1lbnRhdGlvbi9n
cHUvdG9kby5yc3QKQEAgLTQ2Myw2ICs0NjMsMjEgQEAgQ29udGFjdDogVGhvbWFzIFppbW1lcm1h
bm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+LCBDaHJpc3RpYW4gS8O2bmlnLCBEYW5pZWwgVmV0dGUK
IAogTGV2ZWw6IEludGVybWVkaWF0ZQogCitSZXZpZXcgYWxsIGRyaXZlcnMgZm9yIHNldHRpbmcg
c3RydWN0IGRybV9tb2RlX2NvbmZpZy57bWF4X3dpZHRoLG1heF9oZWlnaHR9IGNvcnJlY3RseQor
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KKworVGhlIHZhbHVlcyBpbiBzdHJ1Y3QgZHJt
X21vZGVfY29uZmlnLnttYXhfd2lkdGgsbWF4X2hlaWdodH0gZGVzY3JpYmUgdGhlCittYXhpbXVt
IHN1cHBvcnRlZCBmcmFtZWJ1ZmZlciBzaXplLiBJdCdzIHRoZSB2aXJ0dWFsIHNjcmVlbiBzaXpl
LCBidXQgbWFueQorZHJpdmVycyB0cmVhdCBpdCBsaWtlIGxpbWl0YXRpb25zIG9mIHRoZSBwaHlz
aWNhbCByZXNvbHV0aW9uLgorCitUaGUgbWF4aW11bSB3aWR0aCBkZXBlbmRzIG9uIHRoZSBoYXJk
d2FyZSdzIG1heGltdW0gc2NhbmxpbmUgcGl0Y2guIFRoZQorbWF4aW11bSBoZWlnaHQgZGVwZW5k
cyBvbiB0aGUgYW1vdW50IG9mIGFkZHJlc3NhYmxlIHZpZGVvIG1lbW9yeS4gUmV2aWV3IGFsbAor
ZHJpdmVycyB0byBpbml0aWFsaXplIHRoZSBmaWVsZHMgdG8gdGhlIGNvcnJlY3QgdmFsdWVzLgor
CitDb250YWN0OiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4KKworTGV2
ZWw6IEludGVybWVkaWF0ZQorCiAKIENvcmUgcmVmYWN0b3JpbmdzCiA9PT09PT09PT09PT09PT09
PQpkaWZmIC0tZ2l0IGEvaW5jbHVkZS9kcm0vZHJtX21vZGVfY29uZmlnLmggYi9pbmNsdWRlL2Ry
bS9kcm1fbW9kZV9jb25maWcuaAppbmRleCA0OGI3ZGU4MGRhZjUuLjkxY2E1NzVhNzhkZSAxMDA2
NDQKLS0tIGEvaW5jbHVkZS9kcm0vZHJtX21vZGVfY29uZmlnLmgKKysrIGIvaW5jbHVkZS9kcm0v
ZHJtX21vZGVfY29uZmlnLmgKQEAgLTM1OSw2ICszNTksMTkgQEAgc3RydWN0IGRybV9tb2RlX2Nv
bmZpZ19mdW5jcyB7CiAgKiBDb3JlIG1vZGUgcmVzb3VyY2UgdHJhY2tpbmcgc3RydWN0dXJlLiAg
QWxsIENSVEMsIGVuY29kZXJzLCBhbmQgY29ubmVjdG9ycwogICogZW51bWVyYXRlZCBieSB0aGUg
ZHJpdmVyIGFyZSBhZGRlZCBoZXJlLCBhcyBhcmUgZ2xvYmFsIHByb3BlcnRpZXMuICBTb21lCiAg
KiBnbG9iYWwgcmVzdHJpY3Rpb25zIGFyZSBhbHNvIGhlcmUsIGUuZy4gZGltZW5zaW9uIHJlc3Ry
aWN0aW9ucy4KKyAqCisgKiBGcmFtZWJ1ZmZlciBzaXplcyByZWZlciB0byB0aGUgdmlydHVhbCBz
Y3JlZW4gdGhhdCBjYW4gYmUgZGlzcGxheWVkIGJ5CisgKiB0aGUgQ1JUQy4gVGhpcyBjYW4gYmUg
ZGlmZmVyZW50IGZyb20gdGhlIHBoeXNpY2FsIHJlc29sdXRpb24gcHJvZ3JhbW1lZC4KKyAqIFRo
ZSBtaW5pbXVtIHdpZHRoIGFuZCBoZWlnaHQsIHN0b3JlZCBpbiBAbWluX3dpZHRoIGFuZCBAbWlu
X2hlaWdodCwKKyAqIGRlc2NyaWJlIHRoZSBzbWFsbGVzdCBzaXplIG9mIHRoZSBmcmFtZWJ1ZmZl
ci4gSXQgY29ycmVsYXRlcyB0byB0aGUKKyAqIG1pbmltdW0gcHJvZ3JhbW1hYmxlIHJlc29sdXRp
b24uCisgKiBUaGUgbWF4aW11bSB3aWR0aCwgc3RvcmVkIGluIEBtYXhfd2lkdGgsIGlzIHR5cGlj
YWxseSBsaW1pdGVkIGJ5IHRoZQorICogbWF4aW11bSBwaXRjaCBiZXR3ZWVuIHR3byBhZGphY2Vu
dCBzY2FubGluZXMuIFRoZSBtYXhpbXVtIGhlaWdodCwgc3RvcmVkCisgKiBpbiBAbWF4X2hlaWdo
dCwgaXMgdXN1YWxseSBvbmx5IGxpbWl0ZWQgYnkgdGhlIGFtb3VudCBvZiBhZGRyZXNzYWJsZSB2
aWRlbworICogbWVtb3J5LiBGb3IgaGFyZHdhcmUgdGhhdCBoYXMgbm8gcmVhbCBtYXhpbXVtLCBk
cml2ZXJzIHNob3VsZCBwaWNrIGEKKyAqIHJlYXNvbmFibGUgZGVmYXVsdC4KKyAqCisgKiBTZWUg
YWxzbyBARFJNX1NIQURPV19QTEFORV9NQVhfV0lEVEggYW5kIEBEUk1fU0hBRE9XX1BMQU5FX01B
WF9IRUlHSFQuCiAgKi8KIHN0cnVjdCBkcm1fbW9kZV9jb25maWcgewogCS8qKgotLSAKMi4zMy4x
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
