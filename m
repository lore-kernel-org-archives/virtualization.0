Return-Path: <SRS0=KS98=P4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF912C433FE
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 13:06:02 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9224161175
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 13:06:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9224161175
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 45A3780F27;
	Tue,  9 Nov 2021 13:06:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Dhqv-J19gZfB; Tue,  9 Nov 2021 13:06:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id BDB3E80F21;
	Tue,  9 Nov 2021 13:06:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FD27C0012;
	Tue,  9 Nov 2021 13:06:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E5B9C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 13:06:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E3ADD4035B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 13:05:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=tronnes.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T5HTcb4s-TD5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 13:05:59 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtp.domeneshop.no (smtp.domeneshop.no
 [IPv6:2a01:5b40:0:3005::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 11BC8401CC
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 13:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
 ; s=ds202012;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FNybxeiwGJvmy2fP6P5foWuCIXWQuBiniiHZ2pQzUaI=; b=HyvymZBU1v/cqEDILAglLmRsF0
 4KY649M364Hd8eV+OyA30pz5eOZlX7xzMZwBR0NjmdsNVxHvonlCNHaDvBLL0cd7x0cQIT3YSC5P1
 0rE/nycmlOkOmMw9rqliJ5Mi9vjQZ/CUVuwUVhRMd4HEsbU4kndiKc9heUluapUGrWl1l7mQ666y3
 s3p+kAAO9YqqDmMIgPniLdfd174U6hi8FM47u8i/yflxEeCs48Qwd3Fh6DR4uOeDxeizK/GyQGigX
 BqGI270/q+QslPXmYo0TyKXMAXRFnRdZdN0OLNmcwFeIcx3SkwPb/H9RFKbxVz/EdvBZhudfamuw4
 S7QU7I7Q==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:54350
 helo=[192.168.10.61])
 by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <noralf@tronnes.org>)
 id 1mkQp2-00082F-Lm; Tue, 09 Nov 2021 14:05:56 +0100
Subject: Re: [PATCH v2 8/9] drm/simpledrm: Support virtual screen sizes
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@linux.ie, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 drawat.floss@gmail.com, airlied@redhat.com, kraxel@redhat.com,
 david@lechnology.com, sam@ravnborg.org, javierm@redhat.com,
 kernel@amanoeldawod.com, dirty.ice.hu@gmail.com, michael+lkml@stapelberg.ch,
 aros@gmx.com, joshua@stroblindustries.com, arnd@arndb.de
References: <20211101141532.26655-1-tzimmermann@suse.de>
 <20211101141532.26655-9-tzimmermann@suse.de>
 <597cc1b8-30c1-bdf0-68ad-3ad0fd53fb5f@tronnes.org>
 <e3acf05c-3215-dd40-a677-76e6df597151@suse.de>
From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <652b3233-1af4-f0a3-6b9c-54da50e5d18a@tronnes.org>
Date: Tue, 9 Nov 2021 14:05:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <e3acf05c-3215-dd40-a677-76e6df597151@suse.de>
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

CgpEZW4gMDkuMTEuMjAyMSAxMC4wNiwgc2tyZXYgVGhvbWFzIFppbW1lcm1hbm46Cj4gSGkKPiAK
PiBBbSAwOC4xMS4yMSB1bSAyMjowMSBzY2hyaWViIE5vcmFsZiBUcsO4bm5lczoKPj4KPj4KPj4g
RGVuIDAxLjExLjIwMjEgMTUuMTUsIHNrcmV2IFRob21hcyBaaW1tZXJtYW5uOgo+Pj4gQWRkIGNv
bnN0YW50cyBmb3IgdGhlIG1heGltdW0gc2l6ZSBvZiB0aGUgc2hhZG93LXBsYW5lIHN1cmZhY2UK
Pj4+IHNpemUuIFVzZWZ1bCBmb3Igc2hhZG93IHBsYW5lcyB3aXRoIHZpcnR1YWwgc2NyZWVuIHNp
emVzLiBUaGUKPj4+IGN1cnJlbnQgc2l6ZXMgYXJlIDQwOTYgc2NhbmxpbmVzIHdpdGggNDA5NiBw
aXhlbHMgZWFjaC4gVGhpcwo+Pj4gc2VlbXMgcmVhc29uYWJsZSBmb3IgY3VycmVudCBoYXJkd2Fy
ZSwgYnV0IGNhbiBiZSBpbmNyZWFzZWQgYXMKPj4+IG5lY2Vzc2FyeS4KPj4+Cj4+PiBJbiBzaW1w
bGVkcm0sIHNldCB0aGUgbWF4aW11bSBmcmFtZWJ1ZmZlciBzaXplIGZyb20gdGhlIGNvbnN0YW50
cwo+Pj4gZm9yIHNoYWRvdyBwbGFuZXMuIEltcGxlbWVudHMgc3VwcG9ydCBmb3IgdmlydHVhbCBz
Y3JlZW4gc2l6ZXMgYW5kCj4+PiBwYWdlIGZsaXBwaW5nIG9uIHRoZSBmYmRldiBjb25zb2xlLgo+
Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBaaW1tZXJtYW5uIDx0emltbWVybWFubkBzdXNl
LmRlPgo+Pj4gLS0tCj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0vdGlueS9zaW1wbGVkcm0uY8KgwqDC
oCB8wqAgOSArKysrKysrLS0KPj4+IMKgIGluY2x1ZGUvZHJtL2RybV9nZW1fYXRvbWljX2hlbHBl
ci5oIHwgMTggKysrKysrKysrKysrKysrKysrCj4+PiDCoCAyIGZpbGVzIGNoYW5nZWQsIDI1IGlu
c2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4+Pgo+Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
Z3B1L2RybS90aW55L3NpbXBsZWRybS5jCj4+PiBiL2RyaXZlcnMvZ3B1L2RybS90aW55L3NpbXBs
ZWRybS5jCj4+PiBpbmRleCBlODcyMTIxZTlmYjAuLmU0MmFlMWM2ZWJjZCAxMDA2NDQKPj4+IC0t
LSBhL2RyaXZlcnMvZ3B1L2RybS90aW55L3NpbXBsZWRybS5jCj4+PiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vdGlueS9zaW1wbGVkcm0uYwo+Pj4gQEAgLTIsNiArMiw3IEBACj4+PiDCoCDCoCAjaW5j
bHVkZSA8bGludXgvY2xrLmg+Cj4+PiDCoCAjaW5jbHVkZSA8bGludXgvb2ZfY2xrLmg+Cj4+PiAr
I2luY2x1ZGUgPGxpbnV4L21pbm1heC5oPgo+Pj4gwqAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3Jt
X2RhdGEvc2ltcGxlZmIuaD4KPj4+IMKgICNpbmNsdWRlIDxsaW51eC9wbGF0Zm9ybV9kZXZpY2Uu
aD4KPj4+IMKgICNpbmNsdWRlIDxsaW51eC9yZWd1bGF0b3IvY29uc3VtZXIuaD4KPj4+IEBAIC03
NzYsNiArNzc3LDcgQEAgc3RhdGljIGludCBzaW1wbGVkcm1fZGV2aWNlX2luaXRfbW9kZXNldChz
dHJ1Y3QKPj4+IHNpbXBsZWRybV9kZXZpY2UgKnNkZXYpCj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBk
cm1fZGlzcGxheV9tb2RlICptb2RlID0gJnNkZXYtPm1vZGU7Cj4+PiDCoMKgwqDCoMKgIHN0cnVj
dCBkcm1fY29ubmVjdG9yICpjb25uZWN0b3IgPSAmc2Rldi0+Y29ubmVjdG9yOwo+Pj4gwqDCoMKg
wqDCoCBzdHJ1Y3QgZHJtX3NpbXBsZV9kaXNwbGF5X3BpcGUgKnBpcGUgPSAmc2Rldi0+cGlwZTsK
Pj4+ICvCoMKgwqAgdW5zaWduZWQgbG9uZyBtYXhfd2lkdGgsIG1heF9oZWlnaHQ7Cj4+PiDCoMKg
wqDCoMKgIGNvbnN0IHVpbnQzMl90ICpmb3JtYXRzOwo+Pj4gwqDCoMKgwqDCoCBzaXplX3QgbmZv
cm1hdHM7Cj4+PiDCoMKgwqDCoMKgIGludCByZXQ7Cj4+PiBAQCAtNzg0LDEwICs3ODYsMTMgQEAg
c3RhdGljIGludCBzaW1wbGVkcm1fZGV2aWNlX2luaXRfbW9kZXNldChzdHJ1Y3QKPj4+IHNpbXBs
ZWRybV9kZXZpY2UgKnNkZXYpCj4+PiDCoMKgwqDCoMKgIGlmIChyZXQpCj4+PiDCoMKgwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIHJldDsKPj4+IMKgICvCoMKgwqAgbWF4X3dpZHRoID0gbWF4X3QodW5z
aWduZWQgbG9uZywgbW9kZS0+aGRpc3BsYXksCj4+PiBEUk1fU0hBRE9XX1BMQU5FX01BWF9XSURU
SCk7Cj4+PiArwqDCoMKgIG1heF9oZWlnaHQgPSBtYXhfdCh1bnNpZ25lZCBsb25nLCBtb2RlLT52
ZGlzcGxheSwKPj4+IERSTV9TSEFET1dfUExBTkVfTUFYX0hFSUdIVCk7Cj4+PiArCj4+PiDCoMKg
wqDCoMKgIGRldi0+bW9kZV9jb25maWcubWluX3dpZHRoID0gbW9kZS0+aGRpc3BsYXk7Cj4+PiAt
wqDCoMKgIGRldi0+bW9kZV9jb25maWcubWF4X3dpZHRoID0gbW9kZS0+aGRpc3BsYXk7Cj4+PiAr
wqDCoMKgIGRldi0+bW9kZV9jb25maWcubWF4X3dpZHRoID0gbWF4X3dpZHRoOwo+Pj4gwqDCoMKg
wqDCoCBkZXYtPm1vZGVfY29uZmlnLm1pbl9oZWlnaHQgPSBtb2RlLT52ZGlzcGxheTsKPj4+IC3C
oMKgwqAgZGV2LT5tb2RlX2NvbmZpZy5tYXhfaGVpZ2h0ID0gbW9kZS0+dmRpc3BsYXk7Cj4+PiAr
wqDCoMKgIGRldi0+bW9kZV9jb25maWcubWF4X2hlaWdodCA9IG1heF9oZWlnaHQ7Cj4+PiDCoMKg
wqDCoMKgIGRldi0+bW9kZV9jb25maWcucHJlZmVyX3NoYWRvd19mYmRldiA9IHRydWU7Cj4+PiDC
oMKgwqDCoMKgIGRldi0+bW9kZV9jb25maWcucHJlZmVycmVkX2RlcHRoID0gc2Rldi0+Zm9ybWF0
LT5jcHBbMF0gKiA4Owo+Pj4gwqDCoMKgwqDCoCBkZXYtPm1vZGVfY29uZmlnLmZ1bmNzID0gJnNp
bXBsZWRybV9tb2RlX2NvbmZpZ19mdW5jczsKPj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2RybS9k
cm1fZ2VtX2F0b21pY19oZWxwZXIuaAo+Pj4gYi9pbmNsdWRlL2RybS9kcm1fZ2VtX2F0b21pY19o
ZWxwZXIuaAo+Pj4gaW5kZXggNDgyMjJhMTA3ODczLi41NDk4M2VjZjY0MWEgMTAwNjQ0Cj4+PiAt
LS0gYS9pbmNsdWRlL2RybS9kcm1fZ2VtX2F0b21pY19oZWxwZXIuaAo+Pj4gKysrIGIvaW5jbHVk
ZS9kcm0vZHJtX2dlbV9hdG9taWNfaGVscGVyLmgKPj4+IEBAIC0yMiw2ICsyMiwyNCBAQCBpbnQg
ZHJtX2dlbV9zaW1wbGVfZGlzcGxheV9waXBlX3ByZXBhcmVfZmIoc3RydWN0Cj4+PiBkcm1fc2lt
cGxlX2Rpc3BsYXlfcGlwZSAqcGlwZSwKPj4+IMKgwqAgKiBIZWxwZXJzIGZvciBwbGFuZXMgd2l0
aCBzaGFkb3cgYnVmZmVycwo+Pj4gwqDCoCAqLwo+Pj4gwqAgKy8qKgo+Pj4gKyAqIERSTV9TSEFE
T1dfUExBTkVfTUFYX1dJRFRIIC0gTWF4aW11bSB3aWR0aCBvZiBhIHBsYW5lJ3Mgc2hhZG93Cj4+
PiBidWZmZXIgaW4gcGl4ZWxzCj4+PiArICoKPj4+ICsgKiBGb3IgZHJpdmVycyB3aXRoIHNoYWRv
dyBwbGFuZXMsIHRoZSBtYXhpbXVtIHdpZHRoIG9mIHRoZQo+Pj4gZnJhbWVidWZmZXIgaXMKPj4+
ICsgKiB1c3VhbGx5IGluZGVwZW5kZW50IGZyb20gaGFyZHdhcmUgbGltaXRhdGlvbnMuIERyaXZl
cnMgY2FuCj4+PiBpbml0aWFsaXplIHN0cnVjdAo+Pj4gKyAqIGRybV9tb2RlX2NvbmZpZy5tYXhf
d2lkdGggZnJvbSBEUk1fU0hBRE9XX1BMQU5FX01BWF9XSURUSC4KPj4KPj4gV2h5IHdvdWxkIGEg
ZHJpdmVyIGRvIHRoYXQgaW5zdGVhZCBvZiB1c2luZyBhIHZhbHVlIG9mIGl0cyBvd24/IElzIGl0
Cj4+IHNvbWUga2luZCBvZiBzdGFuZGFyZGl6YXRpb24/Cj4gCj4gRXhhY3RseS4gVGhlIHNoYWRv
dyBmcmFtZWJ1ZmZlciBpcyBpbiBzeXN0ZW0gbWVtb3J5LCBzbyBpdHMgc2l6ZSBpcwo+IGFyYml0
cmFyaWx5IGxhcmdlLiBJZiBlYWNoIGRyaXZlciBzZXRzIGl0cyBvd24gbGltaXQsIGl0IGp1c3Qg
ZnJhZ21lbnRzCj4gdGhlIERSTSBmZWF0dXJlIHNldC4gVGhlcmUncyB1c3VhbGx5IG5vIHJlYXNv
biB3aHkgb25lIGRyaXZlciBjYW4gaGF2ZQo+IDQwOTYgcGl4ZWxzIGFuZCBhbm90aGVyIG9uZSBq
dXN0IDIwNDggb3IgZXZlbiA4MTkyLiBTZXR0aW5nIGEgY29uc3RhbnQKPiBoYXJtb25pemVzIHRo
aXMgYW1vbmcgZHJpdmVycy4KPiAKPiBQbGVhc2Ugbm90ZSB0aGF0IG5vdGhpbmcgcmVhbGx5IGRl
cGVuZHMgb24gdGhpcyB2YWx1ZS4gRHJpdmVycyBjYW4gc3RpbGwKPiB1c2UgYSBkaWZmZXJlbnQg
bGltaXQgaWYgdGhleSBoYXZlIHRvLgo+IAo+Pgo+Pj4gKyAqLwo+Pj4gKyNkZWZpbmUgRFJNX1NI
QURPV19QTEFORV9NQVhfV0lEVEjCoMKgwqAgKDF1bCA8PCAxMikKPj4KPj4gUGxlYXNlIHVzZSBh
IGRlY2ltYWwgbnVtYmVyLCBJJ20gc28gc2xvdyBhdCBkb2luZyB0aGlzIGluIG15IGhlYWQgdGhh
dCBJCj4+IHVzZSBiYXNoIHRvIGNhbGN1bGF0ZSBpdCBmb3IgbWUsIHdoaWNoIHJlYWxseSBzbG93
cyBkb3duIHBhcnNpbmcgdGhlCj4+IGNvZGUuCj4gCj4gT2suIDpECj4gCgpXaXRoIHRoYXQgZml4
ZWQ6CgpBY2tlZC1ieTogTm9yYWxmIFRyw7hubmVzIDxub3JhbGZAdHJvbm5lcy5vcmc+CgoKPiBC
ZXN0IHJlZ2FyZAo+IFRob21hcwo+IAo+Pgo+PiBOb3JhbGYuCj4+Cj4+PiArCj4+PiArLyoqCj4+
PiArICogRFJNX1NIQURPV19QTEFORV9NQVhfSEVJR0hUIC0gTWF4aW11bSBoZWlnaHQgb2YgYSBw
bGFuZSdzIHNoYWRvdwo+Pj4gYnVmZmVyIGluIHNjYW5saW5lcwo+Pj4gKyAqCj4+PiArICogRm9y
IGRyaXZlcnMgd2l0aCBzaGFkb3cgcGxhbmVzLCB0aGUgbWF4aW11bSBoZWlnaHQgb2YgdGhlCj4+
PiBmcmFtZWJ1ZmZlciBpcwo+Pj4gKyAqIHVzdWFsbHkgaW5kZXBlbmRlbnQgZnJvbSBoYXJkd2Fy
ZSBsaW1pdGF0aW9ucy4gRHJpdmVycyBjYW4KPj4+IGluaXRpYWxpemUgc3RydWN0Cj4+PiArICog
ZHJtX21vZGVfY29uZmlnLm1heF9oZWlnaHQgZnJvbSBEUk1fU0hBRE9XX1BMQU5FX01BWF9IRUlH
SFQuCj4+PiArICovCj4+PiArI2RlZmluZSBEUk1fU0hBRE9XX1BMQU5FX01BWF9IRUlHSFTCoMKg
wqAgKDF1bCA8PCAxMikKPj4+ICsKPj4+IMKgIC8qKgo+Pj4gwqDCoCAqIHN0cnVjdCBkcm1fc2hh
ZG93X3BsYW5lX3N0YXRlIC0gcGxhbmUgc3RhdGUgZm9yIHBsYW5lcyB3aXRoCj4+PiBzaGFkb3cg
YnVmZmVycwo+Pj4gwqDCoCAqCj4+Pgo+IApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
