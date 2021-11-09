Return-Path: <SRS0=KS98=P4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48709C433F5
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 13:04:53 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F41A161152
	for <virtualization@archiver.kernel.org>; Tue,  9 Nov 2021 13:04:52 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org F41A161152
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=tronnes.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B5BB680E24;
	Tue,  9 Nov 2021 13:04:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ITUi2wt0SYfe; Tue,  9 Nov 2021 13:04:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2BA1580DFE;
	Tue,  9 Nov 2021 13:04:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0F298C0012;
	Tue,  9 Nov 2021 13:04:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7EC7C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 13:04:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D28C540144
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 13:04:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=tronnes.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id k747EVJRgfYU
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 13:04:48 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from smtp.domeneshop.no (smtp.domeneshop.no
 [IPv6:2a01:5b40:0:3005::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 417B3400DA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Nov 2021 13:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=tronnes.org
 ; s=ds202012;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZNSEhLFWrkLL9EmRr49v/5HyMGUEzRlkNEyGiRw0RGI=; b=fBWuBjwxB83X6fFfkpBpG1AN29
 NzY0JkAZuKcDXJ0O5s4xb6wzvzEGhdQTOh1r1Bz6Wl/snFkeDjkG8uUw6R7HKZ2cN0LIM4Nvw8cHh
 aBiA2FeAvn52QQWLW28NRHJrpXZmeHaKa/fbaLQfBWHbZpEoKxUvBQ/3CJTRFfczyqm9adOPktAsR
 JNBp7IZAifIRUQLPr6/ooyMijUwqPqZId+vBWmZpyAvZu2qWKbeRXsfOvFS5ipCn/pOJhjLYiO+lG
 MQvaSjtox2JP+jrV7Yn1oQ3dwX1JQP2ZLKJB/2iicRcibIwlZVzT5wylpiaUlvyZcb0MH/dGe+dbm
 +BsGELwQ==;
Received: from 211.81-166-168.customer.lyse.net ([81.166.168.211]:54309
 helo=[192.168.10.61])
 by smtp.domeneshop.no with esmtpsa (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 (Exim 4.92) (envelope-from <noralf@tronnes.org>)
 id 1mkQnt-0006xp-UN; Tue, 09 Nov 2021 14:04:45 +0100
Subject: Re: [PATCH v2 7/9] drm/simpledrm: Enable FB_DAMAGE_CLIPS property
To: Thomas Zimmermann <tzimmermann@suse.de>, daniel@ffwll.ch,
 airlied@linux.ie, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 drawat.floss@gmail.com, airlied@redhat.com, kraxel@redhat.com,
 david@lechnology.com, sam@ravnborg.org, javierm@redhat.com,
 kernel@amanoeldawod.com, dirty.ice.hu@gmail.com, michael+lkml@stapelberg.ch,
 aros@gmx.com, joshua@stroblindustries.com, arnd@arndb.de
References: <20211101141532.26655-1-tzimmermann@suse.de>
 <20211101141532.26655-8-tzimmermann@suse.de>
 <974e10bb-ae58-d1c1-a89e-881b39da4930@tronnes.org>
 <b5e514a7-74f3-d072-cfba-80ff05c2669c@suse.de>
From: =?UTF-8?Q?Noralf_Tr=c3=b8nnes?= <noralf@tronnes.org>
Message-ID: <1b1e8a38-2ad6-406e-0d07-bd28dcba08a3@tronnes.org>
Date: Tue, 9 Nov 2021 14:04:40 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <b5e514a7-74f3-d072-cfba-80ff05c2669c@suse.de>
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

CgpEZW4gMDkuMTEuMjAyMSAxMy4zOCwgc2tyZXYgVGhvbWFzIFppbW1lcm1hbm46Cj4gCj4gCj4g
QW0gMDguMTEuMjEgdW0gMjE6NTUgc2NocmllYiBOb3JhbGYgVHLDuG5uZXM6Cj4+Cj4+Cj4+IERl
biAwMS4xMS4yMDIxIDE1LjE1LCBza3JldiBUaG9tYXMgWmltbWVybWFubjoKPj4+IEVuYWJsZSB0
aGUgRkJfREFNQUdFX0NMSVBTIHByb3BlcnR5IHRvIHJlZHVjZSBkaXNwbGF5LXVwZGF0ZQo+Pj4g
b3ZlcmhlYWQuIEFsc28gZml4ZXMgYSB3YXJuaW5nIGluIHRoZSBrZXJuZWwgbG9nLgo+Pj4KPj4+
IMKgwqAgc2ltcGxlLWZyYW1lYnVmZmVyIHNpbXBsZS1mcmFtZWJ1ZmZlci4wOiBbZHJtXQo+Pj4g
ZHJtX3BsYW5lX2VuYWJsZV9mYl9kYW1hZ2VfY2xpcHMoKSBub3QgY2FsbGVkCj4+Pgo+Pj4gRml4
IHRoZSBjb21wdXRhdGlvbiBvZiB0aGUgYmxpdCByZWN0YW5nbGUuIFRoaXMgd2Fzbid0IGFuIGlz
c3VlIHNvCj4+PiBmYXIsIGFzIHNpbXBsZWRybSBhbHdheXMgYmxpdHRlZCB0aGUgZnVsbCBmcmFt
ZWJ1ZmZlci4gVGhlIGNvZGUgbm93Cj4+PiBzdXBwb3J0cyBkYW1hZ2UgY2xpcHBpbmcgYW5kIHZp
cnR1YWwgc2NyZWVuIHNpemVzLgo+Pj4KPj4+IFNpZ25lZC1vZmYtYnk6IFRob21hcyBaaW1tZXJt
YW5uIDx0emltbWVybWFubkBzdXNlLmRlPgo+Pj4gLS0tCj4+PiDCoCBkcml2ZXJzL2dwdS9kcm0v
dGlueS9zaW1wbGVkcm0uYyB8IDMwICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLQo+Pj4g
wqAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pCj4+Pgo+
Pj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvZ3B1L2RybS90aW55L3NpbXBsZWRybS5jCj4+PiBiL2Ry
aXZlcnMvZ3B1L2RybS90aW55L3NpbXBsZWRybS5jCj4+PiBpbmRleCA1NzFmNzE2ZmY0MjcuLmU4
NzIxMjFlOWZiMCAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS90aW55L3NpbXBsZWRy
bS5jCj4+PiArKysgYi9kcml2ZXJzL2dwdS9kcm0vdGlueS9zaW1wbGVkcm0uYwo+Pj4gQEAgLTY0
Miw3ICs2NDIsNyBAQCBzaW1wbGVkcm1fc2ltcGxlX2Rpc3BsYXlfcGlwZV9lbmFibGUoc3RydWN0
Cj4+PiBkcm1fc2ltcGxlX2Rpc3BsYXlfcGlwZSAqcGlwZSwKPj4+IMKgwqDCoMKgwqAgdm9pZCAq
dm1hcCA9IHNoYWRvd19wbGFuZV9zdGF0ZS0+ZGF0YVswXS52YWRkcjsgLyogVE9ETzogVXNlCj4+
PiBtYXBwaW5nIGFic3RyYWN0aW9uICovCj4+PiDCoMKgwqDCoMKgIHN0cnVjdCBkcm1fZGV2aWNl
ICpkZXYgPSAmc2Rldi0+ZGV2Owo+Pj4gwqDCoMKgwqDCoCB2b2lkIF9faW9tZW0gKmRzdCA9IHNk
ZXYtPnNjcmVlbl9iYXNlOwo+Pj4gLcKgwqDCoCBzdHJ1Y3QgZHJtX3JlY3QgY2xpcDsKPj4+ICvC
oMKgwqAgc3RydWN0IGRybV9yZWN0IHNyY19jbGlwLCBkc3RfY2xpcDsKPj4+IMKgwqDCoMKgwqAg
aW50IGlkeDsKPj4+IMKgIMKgwqDCoMKgwqAgaWYgKCFmYikKPj4+IEBAIC02NTEsMTAgKzY1MSwx
NCBAQCBzaW1wbGVkcm1fc2ltcGxlX2Rpc3BsYXlfcGlwZV9lbmFibGUoc3RydWN0Cj4+PiBkcm1f
c2ltcGxlX2Rpc3BsYXlfcGlwZSAqcGlwZSwKPj4+IMKgwqDCoMKgwqAgaWYgKCFkcm1fZGV2X2Vu
dGVyKGRldiwgJmlkeCkpCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+Pj4gwqAgLcKg
wqDCoCBkcm1fcmVjdF9pbml0KCZjbGlwLCAwLCAwLCBmYi0+d2lkdGgsIGZiLT5oZWlnaHQpOwo+
Pj4gK8KgwqDCoCBkcm1fcmVjdF9mcF90b19pbnQoJnNyY19jbGlwLCAmcGxhbmVfc3RhdGUtPnNy
Yyk7Cj4+PiDCoCAtwqDCoMKgIGRzdCArPSBkcm1fZmJfY2xpcF9vZmZzZXQoc2Rldi0+cGl0Y2gs
IHNkZXYtPmZvcm1hdCwgJmNsaXApOwo+Pj4gLcKgwqDCoCBkcm1fZmJfYmxpdF90b2lvKGRzdCwg
c2Rldi0+cGl0Y2gsIHNkZXYtPmZvcm1hdC0+Zm9ybWF0LCB2bWFwLAo+Pj4gZmIsICZjbGlwKTsK
Pj4+ICvCoMKgwqAgZHN0X2NsaXAgPSBwbGFuZV9zdGF0ZS0+ZHN0Owo+Pgo+PiBJIGFzc3VtZSB0
aGF0IHNyY19jbGlwIGFuZCBkc3RfY2xpcCBhcmUgb2YgdGhlIHNhbWUgc2l6ZSwgc2luY2Ugc2Nh
bGluZwo+PiBpcyBub3Qgc3VwcG9ydGVkLiBXaGF0IHByZXZlbnRzIGRzdF9jbGlwIGZyb20gYmVp
bmcgYmlnZ2VyIHRoYW4gdGhlCj4+IGJ1ZmZlciB0aGF0J3MgYmVpbmcgYmxpdHRlZCBpbnRvPyBX
aGVyZSBpcyB0aGF0IGJvdW5kcyBjaGVja2luZyBkb25lPwo+IAo+IFRoZSB2YWx1ZSBvZiBkc3Rf
Y2xpcCBjb21lcyBmcm9tIHBsYW5lX3N0YXRlLT5kc3QsIHdoaWNoIGdldHMKPiBpbml0aWFsaXpl
ZCBpbiBkcm1fYXRvbWljX2hlbHBlcl9jaGVja19wbGFuZV9zdGF0ZSgpLiBbMV0gVGhlIGZpZWxk
cyBhcmUKPiB0YWtlbiBmcm9tIHRoZSBjcnRjX3t4LHksdyxofSB2YWx1ZXMgYnkgZHJtX3BsYW5l
X2dldF9kZXN0KCkuIFsyXSBGb3IKPiBwcmltYXJ5IHBsYW5lcywgdGhlIGNydGNfe3gseSx3LGh9
IHZhbHVlcyBhcmUgaW5pdGlhbGl6ZWQgaW4KPiBfX2RybV9hdG9taWNfaGVscGVyX3NldF9jb25m
aWcoKSB0byB0aGUgc2l6ZSBvZiB0aGUgZGlzcGxheS4gWzNdIFRoYXQKPiBzaXplIGNvbWVzIGRp
cmVjdGx5IGZyb20gdGhlIGN1cnJlbnQgdmlkZW8gbW9kZS4gWzRdIEZyb20gYWxsIEkgY2FuIHNl
ZQo+IHRoaXMgY2Fubm90IG92ZXJmbG93Lgo+IAoKT2ssIHRoYXQgdGFrZXMgY2FyZSBvZiB0aGUg
dXBwZXIgYm91bmQuCgpUaGVyZSdzIHRoaXMgaW4gZHJtX2F0b21pY19oZWxwZXJfY2hlY2tfcGxh
bmVfc3RhdGUoKToKCglwbGFuZV9zdGF0ZS0+dmlzaWJsZSA9IGRybV9yZWN0X2NsaXBfc2NhbGVk
KHNyYywgZHN0LCAmY2xpcCk7CgoJaWYgKCFwbGFuZV9zdGF0ZS0+dmlzaWJsZSkKCQkvKgoJCSAq
IFBsYW5lIGlzbid0IHZpc2libGU7IHNvbWUgZHJpdmVycyBjYW4gaGFuZGxlIHRoaXMKCQkgKiBz
byB3ZSBqdXN0IHJldHVybiBzdWNjZXNzIGhlcmUuICBEcml2ZXJzIHRoYXQgY2FuJ3QKCQkgKiAo
aW5jbHVkaW5nIHRob3NlIHRoYXQgdXNlIHRoZSBwcmltYXJ5IHBsYW5lIGhlbHBlcidzCgkJICog
dXBkYXRlIGZ1bmN0aW9uKSB3aWxsIHJldHVybiBhbiBlcnJvciBmcm9tIHRoZWlyCgkJICogdXBk
YXRlX3BsYW5lIGhhbmRsZXIuCgkJICovCgkJcmV0dXJuIDA7Cgpkcm1fYXRvbWljX2hlbHBlcl9k
YW1hZ2VfbWVyZ2VkKCkgY2hlY2tzIC0+dmlzaWJsZSBhbmQgcmV0dXJucyBmYWxzZSBpZgppdCBp
cyBub3Qgc2V0IHNvIHVwZGF0ZSgpIGlzIGdvb2Qgb24gdGhlIGxvd2VyIGJvdW5kLgoKTWF5YmUg
aXQncyBuZWNlc3NhcnkgdG8gY2hlY2sgLT52aXNpYmxlIGhlcmUgaW4gZW5hYmxlKCkgYmVmb3Jl
IGRvaW5nCnRoZSBibGl0PwoKTm9yYWxmLgoKPiBCZXN0IHJlZ2FyZHMKPiBUaG9tYXMKPiAKPiBb
MV0KPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2RyaXZl
cnMvZ3B1L2RybS9kcm1fYXRvbWljX2hlbHBlci5jI0w4MDcKPiAKPiBbMl0KPiBodHRwczovL2Vs
aXhpci5ib290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2luY2x1ZGUvZHJtL2RybV9wbGFu
ZS5oI0wyNTcKPiBbM10KPiBodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC9sYXRlc3Qv
c291cmNlL2RyaXZlcnMvZ3B1L2RybS9kcm1fYXRvbWljLmMjTDE1OTAKPiAKPiBbNF0KPiBodHRw
czovL2VsaXhpci5ib290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2RyaXZlcnMvZ3B1L2Ry
bS9kcm1fbW9kZXMuYyNMNzg4Cj4gCj4gCj4+Cj4+IE5vcmFsZi4KPj4KPj4+ICvCoMKgwqAgaWYg
KCFkcm1fcmVjdF9pbnRlcnNlY3QoJmRzdF9jbGlwLCAmc3JjX2NsaXApKQo+Pj4gK8KgwqDCoMKg
wqDCoMKgIHJldHVybjsKPj4+ICsKPj4+ICvCoMKgwqAgZHN0ICs9IGRybV9mYl9jbGlwX29mZnNl
dChzZGV2LT5waXRjaCwgc2Rldi0+Zm9ybWF0LCAmZHN0X2NsaXApOwo+Pj4gK8KgwqDCoCBkcm1f
ZmJfYmxpdF90b2lvKGRzdCwgc2Rldi0+cGl0Y2gsIHNkZXYtPmZvcm1hdC0+Zm9ybWF0LCB2bWFw
LAo+Pj4gZmIsICZzcmNfY2xpcCk7Cj4+PiDCoCDCoMKgwqDCoMKgIGRybV9kZXZfZXhpdChpZHgp
Owo+Pj4gwqAgfQo+Pj4gQEAgLTY4NiwyMCArNjkwLDI4IEBAIHNpbXBsZWRybV9zaW1wbGVfZGlz
cGxheV9waXBlX3VwZGF0ZShzdHJ1Y3QKPj4+IGRybV9zaW1wbGVfZGlzcGxheV9waXBlICpwaXBl
LAo+Pj4gwqDCoMKgwqDCoCBzdHJ1Y3QgZHJtX2ZyYW1lYnVmZmVyICpmYiA9IHBsYW5lX3N0YXRl
LT5mYjsKPj4+IMKgwqDCoMKgwqAgc3RydWN0IGRybV9kZXZpY2UgKmRldiA9ICZzZGV2LT5kZXY7
Cj4+PiDCoMKgwqDCoMKgIHZvaWQgX19pb21lbSAqZHN0ID0gc2Rldi0+c2NyZWVuX2Jhc2U7Cj4+
PiAtwqDCoMKgIHN0cnVjdCBkcm1fcmVjdCBjbGlwOwo+Pj4gK8KgwqDCoCBzdHJ1Y3QgZHJtX3Jl
Y3QgZGFtYWdlX2NsaXAsIHNyY19jbGlwLCBkc3RfY2xpcDsKPj4+IMKgwqDCoMKgwqAgaW50IGlk
eDsKPj4+IMKgIMKgwqDCoMKgwqAgaWYgKCFmYikKPj4+IMKgwqDCoMKgwqDCoMKgwqDCoCByZXR1
cm47Cj4+PiDCoCAtwqDCoMKgIGlmICghZHJtX2F0b21pY19oZWxwZXJfZGFtYWdlX21lcmdlZChv
bGRfcGxhbmVfc3RhdGUsCj4+PiBwbGFuZV9zdGF0ZSwgJmNsaXApKQo+Pj4gK8KgwqDCoCBpZiAo
IWRybV9hdG9taWNfaGVscGVyX2RhbWFnZV9tZXJnZWQob2xkX3BsYW5lX3N0YXRlLAo+Pj4gcGxh
bmVfc3RhdGUsICZkYW1hZ2VfY2xpcCkpCj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+Pj4g
Kwo+Pj4gK8KgwqDCoCBkcm1fcmVjdF9mcF90b19pbnQoJnNyY19jbGlwLCAmcGxhbmVfc3RhdGUt
PnNyYyk7Cj4+PiArwqDCoMKgIGlmICghZHJtX3JlY3RfaW50ZXJzZWN0KCZzcmNfY2xpcCwgJmRh
bWFnZV9jbGlwKSkKPj4+ICvCoMKgwqDCoMKgwqDCoCByZXR1cm47Cj4+PiArCj4+PiArwqDCoMKg
IGRzdF9jbGlwID0gcGxhbmVfc3RhdGUtPmRzdDsKPj4+ICvCoMKgwqAgaWYgKCFkcm1fcmVjdF9p
bnRlcnNlY3QoJmRzdF9jbGlwLCAmc3JjX2NsaXApKQo+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgIHJl
dHVybjsKPj4+IMKgIMKgwqDCoMKgwqAgaWYgKCFkcm1fZGV2X2VudGVyKGRldiwgJmlkeCkpCj4+
PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuOwo+Pj4gwqAgLcKgwqDCoCBkc3QgKz0gZHJtX2Zi
X2NsaXBfb2Zmc2V0KHNkZXYtPnBpdGNoLCBzZGV2LT5mb3JtYXQsICZjbGlwKTsKPj4+IC3CoMKg
wqAgZHJtX2ZiX2JsaXRfdG9pbyhkc3QsIHNkZXYtPnBpdGNoLCBzZGV2LT5mb3JtYXQtPmZvcm1h
dCwgdm1hcCwKPj4+IGZiLCAmY2xpcCk7Cj4+PiArwqDCoMKgIGRzdCArPSBkcm1fZmJfY2xpcF9v
ZmZzZXQoc2Rldi0+cGl0Y2gsIHNkZXYtPmZvcm1hdCwgJmRzdF9jbGlwKTsKPj4+ICvCoMKgwqAg
ZHJtX2ZiX2JsaXRfdG9pbyhkc3QsIHNkZXYtPnBpdGNoLCBzZGV2LT5mb3JtYXQtPmZvcm1hdCwg
dm1hcCwKPj4+IGZiLCAmc3JjX2NsaXApOwo+Pj4gwqAgwqDCoMKgwqDCoCBkcm1fZGV2X2V4aXQo
aWR4KTsKPj4+IMKgIH0KPj4+IEBAIC03OTQsNiArODA2LDggQEAgc3RhdGljIGludCBzaW1wbGVk
cm1fZGV2aWNlX2luaXRfbW9kZXNldChzdHJ1Y3QKPj4+IHNpbXBsZWRybV9kZXZpY2UgKnNkZXYp
Cj4+PiDCoMKgwqDCoMKgIGlmIChyZXQpCj4+PiDCoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIHJl
dDsKPj4+IMKgICvCoMKgwqAgZHJtX3BsYW5lX2VuYWJsZV9mYl9kYW1hZ2VfY2xpcHMoJnBpcGUt
PnBsYW5lKTsKPj4+ICsKPj4+IMKgwqDCoMKgwqAgZHJtX21vZGVfY29uZmlnX3Jlc2V0KGRldik7
Cj4+PiDCoCDCoMKgwqDCoMKgIHJldHVybiAwOwo+Pj4KPiAKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
