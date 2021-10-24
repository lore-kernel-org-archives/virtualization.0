Return-Path: <SRS0=Yk2c=PM=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C384DC433EF
	for <virtualization@archiver.kernel.org>; Sun, 24 Oct 2021 11:32:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5840860D43
	for <virtualization@archiver.kernel.org>; Sun, 24 Oct 2021 11:32:21 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 5840860D43
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E789A40308;
	Sun, 24 Oct 2021 11:32:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5DiuZHwKpn4J; Sun, 24 Oct 2021 11:32:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 8E1FF40303;
	Sun, 24 Oct 2021 11:32:19 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 62CCBC0019;
	Sun, 24 Oct 2021 11:32:19 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C099EC000E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 11:32:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BB0FD401BD
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 11:32:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=tronnes.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RbRRCDMeVO3i
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 11:32:14 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtp.domeneshop.no (smtp.domeneshop.no
 [IPv6:2a01:5b40:0:3005::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9797C40135
 for <virtualization@lists.linux-foundation.org>;
 Sun, 24 Oct 2021 11:32:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
 ; s=ds202012;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4UjwHqhlZinB2vUUN1dbRV9mgrL0gkzMPLMVhpVUDqI=; b=OyDlWLdV8slnS+VFpMcCWmTn+k
 iHAjSeNYvIc1ugrRhWGds1Bu/vn0DNurwMr0j6anwvr/XkkooSz7lQl7pIAdhRv150fSfKowt1B2P
 OzZOwZ1FCQJBCR6TTiZLZvVCRbRVj7IX9oBbXZ55/AqoC6M+XOYsFYTnm+iInUSqa+LYxUntCEd24
 bWpw/itsxfzp1MkOqZUwQXDWZMLyNKuuRjwnpBsXC++cCYfLKHITOoQpD31na7p0gjG5W/H22CgS0
 k8pGHlfwNM6ppqn2hwNXDpKPBMZsWsaaioATZHqW0/WIXv2gJvkiD9DEbLXPtmcCSOe1Di5NyeDMT
 +d0BT+Xw==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:52392
 helo=[192.168.10.61])
 by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <noralf@tronnes.org>)
 id 1mebjY-0007RS-4M; Sun, 24 Oct 2021 13:32:12 +0200
Subject: Re: [PATCH 4/9] drm/format-helper: Rework format-helper conversion
 functions
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@linux.ie, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 drawat.floss@gmail.com, airlied@redhat.com, kraxel@redhat.com,
 david@lechnology.com, sam@ravnborg.org, javierm@redhat.com,
 kernel@amanoeldawod.com, dirty.ice.hu@gmail.com, michael+lkml@stapelberg.ch,
 aros@gmx.com, joshua@stroblindustries.com, arnd@arndb.de
References: <20211022132829.7697-1-tzimmermann@suse.de>
 <20211022132829.7697-5-tzimmermann@suse.de>
From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <34b8daf3-b6b4-02fb-9e10-ef11c0848572@tronnes.org>
Date: Sun, 24 Oct 2021 13:32:07 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211022132829.7697-5-tzimmermann@suse.de>
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

CgpEZW4gMjIuMTAuMjAyMSAxNS4yOCwgc2tyZXYgVGhvbWFzIFppbW1lcm1hbm46Cj4gTW92ZSBk
ZXN0aW5hdGlvbi1idWZmZXIgY2xpcHBpbmcgZnJvbSBhbGwgZm9ybWF0LWhlbHBlciBjb252ZXJz
aW9uCj4gZnVuY3Rpb25zIGludG8gY2FsbGVycy4gU3VwcG9ydCBkZXN0aW5hdGlvbi1idWZmZXIg
cGl0Y2guIE9ubHkKPiBkaXN0aW5ndWlzaCBiZXR3ZWVuIHN5c3RlbSBhbmQgSS9PIG1lbW9yeSwg
YnV0IHVzZSBzYW1lIGxvZ2ljCj4gZXZlcnl3aGVyZS4KPiAKPiBTaW1wbHkgaGFybW9uaXplIHRo
ZSBpbnRlcmZhY2UgYW5kIHNlbWFudGljcyBvZiB0aGUgZXhpc3RpbmcgY29kZS4KPiBOb3QgYWxs
IGNvbnZlcnNpb24gaGVscGVycyBzdXBwb3J0IGFsbCBjb21iaW5hdGlvbnMgb2YgcGFyYW1ldGVy
cy4KPiBXZSBoYXZlIHRvIGFkZCBhZGRpdGlvbmFsIGZlYXR1cmVzIHdoZW4gd2UgbmVlZCB0aGVt
Lgo+IAo+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNl
LmRlPgo+IC0tLQoKPiAgLyoqCj4gICAqIGRybV9mYl94cmdiODg4OF90b19ncmF5OCAtIENvbnZl
cnQgWFJHQjg4ODggdG8gZ3JheXNjYWxlCj4gICAqIEBkc3Q6IDgtYml0IGdyYXlzY2FsZSBkZXN0
aW5hdGlvbiBidWZmZXIKPiArICogQGRzdF9waXRjaDogTnVtYmVyIG9mIGJ5dGVzIGJldHdlZW4g
dHdvIGNvbnNlY3V0aXZlIHNjYW5saW5lcyB3aXRoaW4gZHN0Cj4gICAqIEB2YWRkcjogWFJHQjg4
ODggc291cmNlIGJ1ZmZlcgo+ICAgKiBAZmI6IERSTSBmcmFtZWJ1ZmZlcgo+ICAgKiBAY2xpcDog
Q2xpcCByZWN0YW5nbGUgYXJlYSB0byBjb3B5Cj4gQEAgLTQxNSwxNiArNDE3LDIxIEBAIEVYUE9S
VF9TWU1CT0woZHJtX2ZiX3hyZ2I4ODg4X3RvX3JnYjg4OF9kc3RjbGlwKTsKPiAgICoKPiAgICog
SVRVIEJULjYwMSBpcyB1c2VkIGZvciB0aGUgUkdCIC0+IGx1bWEgKGJyaWdodG5lc3MpIGNvbnZl
cnNpb24uCj4gICAqLwo+IC12b2lkIGRybV9mYl94cmdiODg4OF90b19ncmF5OCh1OCAqZHN0LCB2
b2lkICp2YWRkciwgc3RydWN0IGRybV9mcmFtZWJ1ZmZlciAqZmIsCj4gLQkJCSAgICAgICBzdHJ1
Y3QgZHJtX3JlY3QgKmNsaXApCj4gK3ZvaWQgZHJtX2ZiX3hyZ2I4ODg4X3RvX2dyYXk4KHZvaWQg
KmRzdCwgdW5zaWduZWQgaW50IGRzdF9waXRjaCwgY29uc3Qgdm9pZCAqdmFkZHIsCj4gKwkJCSAg
ICAgIGNvbnN0IHN0cnVjdCBkcm1fZnJhbWVidWZmZXIgKmZiLCBjb25zdCBzdHJ1Y3QgZHJtX3Jl
Y3QgKmNsaXApCj4gIHsKPiAgCXVuc2lnbmVkIGludCBsZW4gPSAoY2xpcC0+eDIgLSBjbGlwLT54
MSkgKiBzaXplb2YodTMyKTsKPiAgCXVuc2lnbmVkIGludCB4LCB5Owo+ICAJdm9pZCAqYnVmOwo+
IC0JdTMyICpzcmM7Cj4gKwl1OCAqZHN0ODsKPiArCXUzMiAqc3JjMzI7Cj4gIAo+ICAJaWYgKFdB
Uk5fT04oZmItPmZvcm1hdC0+Zm9ybWF0ICE9IERSTV9GT1JNQVRfWFJHQjg4ODgpKQo+ICAJCXJl
dHVybjsKPiArCj4gKwlpZiAoIWRzdF9waXRjaCkKCmxlbiBpcyBzb3VyY2UgbGVuZ3RoIChzaG91
bGQgcmVhbGx5IGhhdmUgYmVlbiBuYW1lZCBzcmNfbGVuKSB3aGljaApyZXN1bHRzIGluIGEga2Vy
bmVsIGNyYXNoOgoKPiArCQlkc3RfcGl0Y2ggPSBsZW47CgpUaGlzIHdvcmtzOgoKCQlkc3RfcGl0
Y2ggPSBkcm1fcmVjdF93aWR0aChjbGlwKTsKCldpdGggdGhhdCBmaXhlZDoKClRlc3RlZC1ieTog
Tm9yYWxmIFRyw7hubmVzIDxub3JhbGZAdHJvbm5lcy5vcmc+ClJldmlld2VkLWJ5OiBOb3JhbGYg
VHLDuG5uZXMgPG5vcmFsZkB0cm9ubmVzLm9yZz4KCj4gKwo+ICAJLyoKPiAgCSAqIFRoZSBjbWEg
bWVtb3J5IGlzIHdyaXRlLWNvbWJpbmVkIHNvIHJlYWRzIGFyZSB1bmNhY2hlZC4KPiAgCSAqIFNw
ZWVkIHVwIGJ5IGZldGNoaW5nIG9uZSBsaW5lIGF0IGEgdGltZS4KPiBAQCAtNDMzLDIwICs0NDAs
MjIgQEAgdm9pZCBkcm1fZmJfeHJnYjg4ODhfdG9fZ3JheTgodTggKmRzdCwgdm9pZCAqdmFkZHIs
IHN0cnVjdCBkcm1fZnJhbWVidWZmZXIgKmZiLAo+ICAJaWYgKCFidWYpCj4gIAkJcmV0dXJuOwo+
ICAKPiArCXZhZGRyICs9IGNsaXBfb2Zmc2V0KGNsaXAsIGZiLT5waXRjaGVzWzBdLCBzaXplb2Yo
dTMyKSk7Cj4gIAlmb3IgKHkgPSBjbGlwLT55MTsgeSA8IGNsaXAtPnkyOyB5KyspIHsKPiAtCQlz
cmMgPSB2YWRkciArICh5ICogZmItPnBpdGNoZXNbMF0pOwo+IC0JCXNyYyArPSBjbGlwLT54MTsK
PiAtCQltZW1jcHkoYnVmLCBzcmMsIGxlbik7Cj4gLQkJc3JjID0gYnVmOwo+ICsJCWRzdDggPSBk
c3Q7Cj4gKwkJc3JjMzIgPSBtZW1jcHkoYnVmLCB2YWRkciwgbGVuKTsKPiAgCQlmb3IgKHggPSBj
bGlwLT54MTsgeCA8IGNsaXAtPngyOyB4KyspIHsKPiAtCQkJdTggciA9ICgqc3JjICYgMHgwMGZm
MDAwMCkgPj4gMTY7Cj4gLQkJCXU4IGcgPSAoKnNyYyAmIDB4MDAwMGZmMDApID4+IDg7Cj4gLQkJ
CXU4IGIgPSAgKnNyYyAmIDB4MDAwMDAwZmY7Cj4gKwkJCXU4IHIgPSAoKnNyYzMyICYgMHgwMGZm
MDAwMCkgPj4gMTY7Cj4gKwkJCXU4IGcgPSAoKnNyYzMyICYgMHgwMDAwZmYwMCkgPj4gODsKPiAr
CQkJdTggYiA9ICAqc3JjMzIgJiAweDAwMDAwMGZmOwo+ICAKPiAgCQkJLyogSVRVIEJULjYwMTog
WSA9IDAuMjk5IFIgKyAwLjU4NyBHICsgMC4xMTQgQiAqLwo+IC0JCQkqZHN0KysgPSAoMyAqIHIg
KyA2ICogZyArIGIpIC8gMTA7Cj4gLQkJCXNyYysrOwo+ICsJCQkqZHN0OCsrID0gKDMgKiByICsg
NiAqIGcgKyBiKSAvIDEwOwo+ICsJCQlzcmMzMisrOwo+ICAJCX0KPiArCj4gKwkJdmFkZHIgKz0g
ZmItPnBpdGNoZXNbMF07Cj4gKwkJZHN0ICs9IGRzdF9waXRjaDsKPiAgCX0KPiAgCj4gIAlrZnJl
ZShidWYpOwpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
