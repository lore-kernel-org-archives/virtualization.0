Return-Path: <SRS0=Yk2c=PM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDB27C433EF
	for <virtualization@archiver.kernel.org>; Sun, 24 Oct 2021 08:33:28 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B4D760F9C
	for <virtualization@archiver.kernel.org>; Sun, 24 Oct 2021 08:33:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6B4D760F9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2A00D60770;
	Sun, 24 Oct 2021 08:33:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id TUuU0tvgBA1y; Sun, 24 Oct 2021 08:33:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 9D09C60622;
	Sun, 24 Oct 2021 08:33:26 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6F5A8C0012;
	Sun, 24 Oct 2021 08:33:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D449C000E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 08:33:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 162A16074F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 08:33:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id o5vUAzSSgyok
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 08:33:24 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtp.domeneshop.no (smtp.domeneshop.no
 [IPv6:2a01:5b40:0:3005::1])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6BC7860746
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 08:33:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
 ; s=ds202012;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=65RlaRrC7lDrEjewQhWmAarZm2pT+v5fMP7uMLXsL6c=; b=adz02WEnV/TxS7So01KXMEIB6v
 fPN7H8wTmJwWlV5rkGrES3sjst0LNicPXGN5ypTbhteKKFocsK+PFFVeGFCDhQyj0LPE5R0zkw0rq
 IytBm007J06iBPCBX/fIrVtTHrvbg0nYUqq5mqvmZ7f/CMb5Koelk7L7pxvAon4JIMdvhvCGcHPJR
 vl9Xayj3/+1SFt4duYl70pjr76Ag6JsDjwKWj+aC7t/2zwdi78TI2Er9LpvMnG5t3eqx5ZO2YrbU6
 w+1WAi2rJOIi2hYPEmn3TUK66hseiMZg9cTnKxFo2WDubYYuqkKhTqMFkkD0k87bK7bZM7JpAgggC
 078lahHw==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:49388
 helo=[192.168.10.61])
 by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <noralf@tronnes.org>)
 id 1meYwU-00084L-4U; Sun, 24 Oct 2021 10:33:22 +0200
Subject: Re: [PATCH 3/9] drm/format-helper: Add destination-buffer pitch to
 drm_fb_swab()
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@linux.ie, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 drawat.floss@gmail.com, airlied@redhat.com, kraxel@redhat.com,
 david@lechnology.com, sam@ravnborg.org, javierm@redhat.com,
 kernel@amanoeldawod.com, dirty.ice.hu@gmail.com, michael+lkml@stapelberg.ch,
 aros@gmx.com, joshua@stroblindustries.com, arnd@arndb.de
References: <20211022132829.7697-1-tzimmermann@suse.de>
 <20211022132829.7697-4-tzimmermann@suse.de>
From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <5df27b45-c560-3495-5fc3-91b30684eb25@tronnes.org>
Date: Sun, 24 Oct 2021 10:33:20 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211022132829.7697-4-tzimmermann@suse.de>
Cc: linux-hyperv@vger.kernel.org, dri-devel@lists.freedesktop.org,
 virtualization@lists.linux-foundation.org
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

CgpEZW4gMjIuMTAuMjAyMSAxNS4yOCwgc2tyZXYgVGhvbWFzIFppbW1lcm1hbm46Cj4gQWRkIGRl
c3RpbmF0aW9uLWJ1ZmZlciBwaXRjaCBhcyBhcmd1bWVudCB0byBkcm1fZmJfc3dhYigpLiBEb25l
IGZvcgo+IGNvbnNpc3RlbmN5IHdpdGggdGhlIHJlc3Qgb2YgdGhlIGludGVyZmFjZS4KPiAKPiBT
aWduZWQtb2ZmLWJ5OiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1hbm5Ac3VzZS5kZT4KPiAt
LS0KPiAgZHJpdmVycy9ncHUvZHJtL2RybV9mb3JtYXRfaGVscGVyLmMgfCAxOSArKysrKysrKysr
KysrKystLS0tCj4gIGRyaXZlcnMvZ3B1L2RybS9kcm1fbWlwaV9kYmkuYyAgICAgIHwgIDIgKy0K
PiAgZHJpdmVycy9ncHUvZHJtL2d1ZC9ndWRfcGlwZS5jICAgICAgfCAgMiArLQo+ICBpbmNsdWRl
L2RybS9kcm1fZm9ybWF0X2hlbHBlci5oICAgICB8ICA1ICsrKy0tCj4gIDQgZmlsZXMgY2hhbmdl
ZCwgMjAgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkKPiAKPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9ncHUvZHJtL2RybV9mb3JtYXRfaGVscGVyLmMgYi9kcml2ZXJzL2dwdS9kcm0vZHJtX2Zv
cm1hdF9oZWxwZXIuYwo+IGluZGV4IDM4YzgwNTVmNmZhOC4uNzk4NjllZDU1M2Q5IDEwMDY0NAo+
IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9kcm1fZm9ybWF0X2hlbHBlci5jCj4gKysrIGIvZHJpdmVy
cy9ncHUvZHJtL2RybV9mb3JtYXRfaGVscGVyLmMKPiBAQCAtOTIsNiArOTIsNyBAQCBFWFBPUlRf
U1lNQk9MKGRybV9mYl9tZW1jcHlfdG9pbyk7Cj4gIC8qKgo+ICAgKiBkcm1fZmJfc3dhYiAtIFN3
YXAgYnl0ZXMgaW50byBjbGlwIGJ1ZmZlcgo+ICAgKiBAZHN0OiBEZXN0aW5hdGlvbiBidWZmZXIK
PiArICogQGRzdF9waXRjaDogTnVtYmVyIG9mIGJ5dGVzIGJldHdlZW4gdHdvIGNvbnNlY3V0aXZl
IHNjYW5saW5lcyB3aXRoaW4gZHN0Cj4gICAqIEBzcmM6IFNvdXJjZSBidWZmZXIKPiAgICogQGZi
OiBEUk0gZnJhbWVidWZmZXIKPiAgICogQGNsaXA6IENsaXAgcmVjdGFuZ2xlIGFyZWEgdG8gY29w
eQo+IEBAIC0xMDMsMTkgKzEwNCwyNSBAQCBFWFBPUlRfU1lNQk9MKGRybV9mYl9tZW1jcHlfdG9p
byk7Cj4gICAqIFRoaXMgZnVuY3Rpb24gZG9lcyBub3QgYXBwbHkgY2xpcHBpbmcgb24gZHN0LCBp
LmUuIHRoZSBkZXN0aW5hdGlvbgoKWW91IGhhdmUgY2hhbmdlZCB0aGlzIGxpbmUgb24gdGhlIG90
aGVyIGZ1bmN0aW9ucywgbWF5YmUgeW91IGp1c3QgbWlzc2VkCml0IGhlcmU6Cgo+ICAgKiBpcyBh
IHNtYWxsIGJ1ZmZlciBjb250YWluaW5nIHRoZSBjbGlwIHJlY3Qgb25seS4KPiAgICovCj4gLXZv
aWQgZHJtX2ZiX3N3YWIodm9pZCAqZHN0LCB2b2lkICpzcmMsIHN0cnVjdCBkcm1fZnJhbWVidWZm
ZXIgKmZiLAo+IC0JCSBzdHJ1Y3QgZHJtX3JlY3QgKmNsaXAsIGJvb2wgY2FjaGVkKQo+ICt2b2lk
IGRybV9mYl9zd2FiKHZvaWQgKmRzdCwgdW5zaWduZWQgaW50IGRzdF9waXRjaCwgY29uc3Qgdm9p
ZCAqc3JjLAo+ICsJCSBjb25zdCBzdHJ1Y3QgZHJtX2ZyYW1lYnVmZmVyICpmYiwgY29uc3Qgc3Ry
dWN0IGRybV9yZWN0ICpjbGlwLAo+ICsJCSBib29sIGNhY2hlZCkKClRlc3RlZC1ieTogTm9yYWxm
IFRyw7hubmVzIDxub3JhbGZAdHJvbm5lcy5vcmc+ClJldmlld2VkLWJ5OiBOb3JhbGYgVHLDuG5u
ZXMgPG5vcmFsZkB0cm9ubmVzLm9yZz4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
