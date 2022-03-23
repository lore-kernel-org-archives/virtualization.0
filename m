Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3289AC433F5
	for <virtualization@archiver.kernel.org>; Wed, 23 Mar 2022 09:45:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BB0E740BE9;
	Wed, 23 Mar 2022 09:45:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DmHumM8OnAyY; Wed, 23 Mar 2022 09:45:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id B34EC4028D;
	Wed, 23 Mar 2022 09:45:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8AC9EC001A;
	Wed, 23 Mar 2022 09:45:23 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8EDCBC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 09:45:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6E6228493F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 09:45:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nTXpVxQn81PG
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 09:45:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by smtp1.osuosl.org (Postfix) with ESMTP id 23E628493D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 23 Mar 2022 09:45:19 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 511CD23A;
 Wed, 23 Mar 2022 02:45:19 -0700 (PDT)
Received: from [10.57.43.230] (unknown [10.57.43.230])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA7353F73B;
 Wed, 23 Mar 2022 02:45:17 -0700 (PDT)
Message-ID: <a6acb2ce-2465-6619-e3fd-ac34ddf07d35@arm.com>
Date: Wed, 23 Mar 2022 09:45:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH v1 1/2] drm/qxl: replace ioremap by ioremap_cache on arm64
Content-Language: en-GB
To: =?UTF-8?Q?Christian_K=c3=b6nig?= <christian.koenig@amd.com>,
 Cong Liu <liucong2@kylinos.cn>, airlied@redhat.com, kraxel@redhat.com,
 airlied@linux.ie, daniel@ffwll.ch, ray.huang@amd.com,
 virtualization@lists.linux-foundation.org,
 spice-devel@lists.freedesktop.org, dri-devel@lists.freedesktop.org
References: <20220322093444.1236582-1-liucong2@kylinos.cn>
 <e2bc20e4-41e1-7162-257c-f2ad3309f1cb@amd.com>
From: Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <e2bc20e4-41e1-7162-257c-f2ad3309f1cb@amd.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gMjAyMi0wMy0yMyAwNzoxNSwgQ2hyaXN0aWFuIEvDtm5pZyB3cm90ZToKPiBBbSAyMi4wMy4y
MiB1bSAxMDozNCBzY2hyaWViIENvbmcgTGl1Ogo+PiBxeGwgdXNlIGlvcmVtYXAgdG8gbWFwIHJh
bV9oZWFkZXIgYW5kIHJvbSwgaW4gdGhlIGFybTY0IGltcGxlbWVudGF0aW9uLAo+PiB0aGUgZGV2
aWNlIGlzIG1hcHBlZCBhcyBERVZJQ0VfbkduUkUsIGl0IGNhbiBub3Qgc3VwcG9ydCB1bmFsaWdu
ZWQKPj4gYWNjZXNzLgo+IAo+IFdlbGwgdGhhdCBzb21lIEFSTSBib2FyZHMgZG9lc24ndCBhbGxv
dyB1bmFsaWduZWQgYWNjZXNzIHRvIE1NSU8gc3BhY2UgCj4gaXMgYSB3ZWxsIGtub3duIGJ1ZyBv
ZiB0aG9zZSBBUk0gYm9hcmRzLgo+IAo+IFNvIGFzIGZhciBhcyBJIGtub3cgdGhpcyBpcyBhIGhh
cmR3YXJlIGJ1ZyB5b3UgYXJlIHRyeWluZyB0byB3b3JrYXJvdW5kIAo+IGhlcmUgYW5kIEknbSBu
b3QgMTAwJSBzdXJlIHRoYXQgdGhpcyBpcyBjb3JyZWN0LgoKTm8sIHRoaXMgb25lJ3Mgbm90IGEg
YnVnLiBUaGUgRGV2aWNlIG1lbW9yeSB0eXBlIHVzZWQgZm9yIGlvbWVtIG1hcHBpbmdzIAppcyAq
YXJjaGl0ZWN0dXJhbGx5KiBkZWZpbmVkIHRvIGVuZm9yY2UgcHJvcGVydGllcyBsaWtlIGFsaWdu
ZWQgCmFjY2Vzc2VzLCBubyBzcGVjdWxhdGlvbiwgbm8gcmVvcmRlcmluZywgZXRjLiBJZiBzb21l
dGhpbmcgd2FudHMgdG8gYmUgCnRyZWF0ZWQgbW9yZSBsaWtlIFJBTSB0aGFuIGFjdHVhbCBNTUlP
IHJlZ2lzdGVycywgdGhlbiBpb3JlbWFwX3djKCkgb3IgCmlvcmVtYXBfY2FjaGUoKSBpcyB0aGUg
YXBwcm9wcmlhdGUgdGhpbmcgdG8gZG8gaW4gZ2VuZXJhbCAod2l0aCB0aGUgCmZvcm1lciBiZWlu
ZyBhIGJpdCBtb3JlIHBvcnRhYmxlIGFjY29yZGluZyB0byAKRG9jdW1lbnRhdGlvbi9kcml2ZXIt
YXBpL2RldmljZS1pby5yc3QpLgoKT2YgY291cnNlICp0aGVuKiB5b3UgbWlnaHQgZmluZCB0aGF0
IG9uIHNvbWUgc3lzdGVtcyB0aGUgCmludGVyY29ubmVjdC9QQ0llIGltcGxlbWVudGF0aW9uL2Vu
ZHBvaW50IGRvZXNuJ3QgYWN0dWFsbHkgbGlrZSAKdW5hbGlnbmVkIGFjY2Vzc2VzIG9uY2UgdGhl
IENQVSBNTVUgc3RhcnRzIGFsbG93aW5nIHRoZW0gdG8gYmUgc2VudCBvdXQsIApidXQgaGV5LCBv
bmUgc3RlcCBhdCBhIHRpbWUgOykKClJvYmluLgoKPiAKPiBDaHJpc3RpYW4uCj4gCj4+Cj4+IMKg
wqAgNi42MjA1MTVdIHBjIDogc2V0dXBfaHdfc2xvdCsweDI0LzB4NjAgW3F4bF0KPj4gW8KgwqDC
oCA2LjYyMDk2MV0gbHIgOiBzZXR1cF9zbG90KzB4MzQvMHhmMCBbcXhsXQo+PiBbwqDCoMKgIDYu
NjIxMzc2XSBzcCA6IGZmZmY4MDAwMTJiNzM3NjAKPj4gW8KgwqDCoCA2LjYyMTcwMV0geDI5OiBm
ZmZmODAwMDEyYjczNzYwIHgyODogMDAwMDAwMDAwMDAwMDAwMSB4Mjc6IAo+PiAwMDAwMDAwMDEw
MDAwMDAwCj4+IFvCoMKgwqAgNi42MjI0MDBdIHgyNjogMDAwMDAwMDAwMDAwMDAwMSB4MjU6IDAw
MDAwMDAwMDQwMDAwMDAgeDI0OiAKPj4gZmZmZmNmMzc2ODQ4YzAwMAo+PiBbwqDCoMKgIDYuNjIz
MDk5XSB4MjM6IGZmZmYwMDAwYzQwODc0MDAgeDIyOiBmZmZmY2YzNzE4ZTE3MTQwIHgyMTogCj4+
IDAwMDAwMDAwMDAwMDAwMDAKPj4gW8KgwqDCoCA2LjYyMzgyM10geDIwOiBmZmZmMDAwMGM0MDg2
MDAwIHgxOTogZmZmZjAwMDBjNDA4NzBiMCB4MTg6IAo+PiAwMDAwMDAwMDAwMDAwMDE0Cj4+IFvC
oMKgwqAgNi42MjQ1MTldIHgxNzogMDAwMDAwMDA0ZDM2MDVhYiB4MTY6IDAwMDAwMDAwYmIzYjYx
MjkgeDE1OiAKPj4gMDAwMDAwMDA2ZTc3MTgwOQo+PiBbwqDCoMKgIDYuNjI1MjE0XSB4MTQ6IDAw
MDAwMDAwMDAwMDAwMDEgeDEzOiAwMDc0NzM2OTZjNWY3OTc0IHgxMjogCj4+IDY5NmU2OTY2NjY2
MTVmNjUKPj4gW8KgwqDCoCA2LjYyNTkwOV0geDExOiAwMDAwMDAwMGQ1NDM2NTZhIHgxMDogMDAw
MDAwMDAwMDAwMDAwMCB4OSA6IAo+PiBmZmZmY2YzNzE4ZTA4NWE0Cj4+IFvCoMKgwqAgNi42MjY2
MTZdIHg4IDogMDAwMDAwMDAwMDZjNzg3MSB4NyA6IDAwMDAwMDAwMDAwMDAwMGEgeDYgOiAKPj4g
MDAwMDAwMDAwMDAwMDAxNwo+PiBbwqDCoMKgIDYuNjI3MzQzXSB4NSA6IDAwMDAwMDAwMDAwMDE0
MDAgeDQgOiBmZmZmODAwMDExZjYzNDAwIHgzIDogCj4+IDAwMDAwMDAwMTQwMDAwMDAKPj4gW8Kg
wqDCoCA2LjYyODA0N10geDIgOiAwMDAwMDAwMDAwMDAwMDAwIHgxIDogZmZmZjAwMDBjNDA4NzBi
MCB4MCA6IAo+PiBmZmZmMDAwMGM0MDg2MDAwCj4+IFvCoMKgwqAgNi42Mjg3NTFdIENhbGwgdHJh
Y2U6Cj4+IFvCoMKgwqAgNi42Mjg5OTRdwqAgc2V0dXBfaHdfc2xvdCsweDI0LzB4NjAgW3F4bF0K
Pj4gW8KgwqDCoCA2LjYyOTQwNF3CoCBzZXR1cF9zbG90KzB4MzQvMHhmMCBbcXhsXQo+PiBbwqDC
oMKgIDYuNjI5NzkwXcKgIHF4bF9kZXZpY2VfaW5pdCsweDZmMC8weDdmMCBbcXhsXQo+PiBbwqDC
oMKgIDYuNjMwMjM1XcKgIHF4bF9wY2lfcHJvYmUrMHhkYy8weDFkMCBbcXhsXQo+PiBbwqDCoMKg
IDYuNjMwNjU0XcKgIGxvY2FsX3BjaV9wcm9iZSsweDQ4LzB4YjgKPj4gW8KgwqDCoCA2LjYzMTAy
N13CoCBwY2lfZGV2aWNlX3Byb2JlKzB4MTk0LzB4MjA4Cj4+IFvCoMKgwqAgNi42MzE0NjRdwqAg
cmVhbGx5X3Byb2JlKzB4ZDAvMHg0NTgKPj4gW8KgwqDCoCA2LjYzMTgxOF3CoCBfX2RyaXZlcl9w
cm9iZV9kZXZpY2UrMHgxMjQvMHgxYzAKPj4gW8KgwqDCoCA2LjYzMjI1Nl3CoCBkcml2ZXJfcHJv
YmVfZGV2aWNlKzB4NDgvMHgxMzAKPj4gW8KgwqDCoCA2LjYzMjY2OV3CoCBfX2RyaXZlcl9hdHRh
Y2grMHhjNC8weDFhOAo+PiBbwqDCoMKgIDYuNjMzMDQ5XcKgIGJ1c19mb3JfZWFjaF9kZXYrMHg3
OC8weGQwCj4+IFvCoMKgwqAgNi42MzM0MzddwqAgZHJpdmVyX2F0dGFjaCsweDJjLzB4MzgKPj4g
W8KgwqDCoCA2LjYzMzc4OV3CoCBidXNfYWRkX2RyaXZlcisweDE1NC8weDI0OAo+PiBbwqDCoMKg
IDYuNjM0MTY4XcKgIGRyaXZlcl9yZWdpc3RlcisweDZjLzB4MTI4Cj4+IFvCoMKgwqAgNi42MzUy
MDVdwqAgX19wY2lfcmVnaXN0ZXJfZHJpdmVyKzB4NGMvMHg1OAo+PiBbwqDCoMKgIDYuNjM1NjI4
XcKgIHF4bF9pbml0KzB4NDgvMHgxMDAwIFtxeGxdCj4+IFvCoMKgwqAgNi42MzYwMTNdwqAgZG9f
b25lX2luaXRjYWxsKzB4NTAvMHgyNDAKPj4gW8KgwqDCoCA2LjYzNjM5MF3CoCBkb19pbml0X21v
ZHVsZSsweDYwLzB4MjM4Cj4+IFvCoMKgwqAgNi42MzY3NjhdwqAgbG9hZF9tb2R1bGUrMHgyNDU4
LzB4MjkwMAo+PiBbwqDCoMKgIDYuNjM3MTM2XcKgIF9fZG9fc3lzX2Zpbml0X21vZHVsZSsweGJj
LzB4MTI4Cj4+IFvCoMKgwqAgNi42Mzc1NjFdwqAgX19hcm02NF9zeXNfZmluaXRfbW9kdWxlKzB4
MjgvMHgzOAo+PiBbwqDCoMKgIDYuNjM4MDA0XcKgIGludm9rZV9zeXNjYWxsKzB4NzQvMHhmMAo+
PiBbwqDCoMKgIDYuNjM4MzY2XcKgIGVsMF9zdmNfY29tbW9uLmNvbnN0cHJvcC4wKzB4NTgvMHgx
YTgKPj4gW8KgwqDCoCA2LjYzODgzNl3CoCBkb19lbDBfc3ZjKzB4MmMvMHg5MAo+PiBbwqDCoMKg
IDYuNjM5MjE2XcKgIGVsMF9zdmMrMHg0MC8weDE5MAo+PiBbwqDCoMKgIDYuNjM5NTI2XcKgIGVs
MHRfNjRfc3luY19oYW5kbGVyKzB4YjAvMHhiOAo+PiBbwqDCoMKgIDYuNjM5OTM0XcKgIGVsMHRf
NjRfc3luYysweDFhNC8weDFhOAo+PiBbwqDCoMKgIDYuNjQwMjk0XSBDb2RlOiA5MTAwMDNmZCBm
OTQ4NDgwNCBmOTQwMGMyMyA4YjA1MDA4NCAoZjgwOWMwODMpCj4+IFvCoMKgwqAgNi42NDA4ODld
IC0tLVsgZW5kIHRyYWNlIDk1NjE1ZDg5YjdjODdmOTUgXS0tLQo+Pgo+PiBTaWduZWQtb2ZmLWJ5
OiBDb25nIExpdSA8bGl1Y29uZzJAa3lsaW5vcy5jbj4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvZ3B1
L2RybS9xeGwvcXhsX2ttcy5jIHwgMTAgKysrKysrKysrKwo+PiDCoCAxIGZpbGUgY2hhbmdlZCwg
MTAgaW5zZXJ0aW9ucygrKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJtL3F4bC9x
eGxfa21zLmMgCj4+IGIvZHJpdmVycy9ncHUvZHJtL3F4bC9xeGxfa21zLmMKPj4gaW5kZXggNGRj
NWFkMTNmMTJjLi4wZTYxYWMwNGQ4YWQgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvZ3B1L2RybS9x
eGwvcXhsX2ttcy5jCj4+ICsrKyBiL2RyaXZlcnMvZ3B1L2RybS9xeGwvcXhsX2ttcy5jCj4+IEBA
IC0xNjUsNyArMTY1LDExIEBAIGludCBxeGxfZGV2aWNlX2luaXQoc3RydWN0IHF4bF9kZXZpY2Ug
KnFkZXYsCj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIChpbnQpcWRldi0+c3VyZmFjZXJhbV9zaXpl
IC8gMTAyNCwKPj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgKHNiID09IDQpID8gIjY0Yml0IiA6ICIz
MmJpdCIpOwo+PiArI2lmZGVmIENPTkZJR19BUk02NAo+PiArwqDCoMKgIHFkZXYtPnJvbSA9IGlv
cmVtYXBfY2FjaGUocWRldi0+cm9tX2Jhc2UsIHFkZXYtPnJvbV9zaXplKTsKPj4gKyNlbHNlCj4+
IMKgwqDCoMKgwqAgcWRldi0+cm9tID0gaW9yZW1hcChxZGV2LT5yb21fYmFzZSwgcWRldi0+cm9t
X3NpemUpOwo+PiArI2VuZGlmCj4+IMKgwqDCoMKgwqAgaWYgKCFxZGV2LT5yb20pIHsKPj4gwqDC
oMKgwqDCoMKgwqDCoMKgIHByX2VycigiVW5hYmxlIHRvIGlvcmVtYXAgUk9NXG4iKTsKPj4gwqDC
oMKgwqDCoMKgwqDCoMKgIHIgPSAtRU5PTUVNOwo+PiBAQCAtMTgzLDkgKzE4NywxNSBAQCBpbnQg
cXhsX2RldmljZV9pbml0KHN0cnVjdCBxeGxfZGV2aWNlICpxZGV2LAo+PiDCoMKgwqDCoMKgwqDC
oMKgwqAgZ290byByb21fdW5tYXA7Cj4+IMKgwqDCoMKgwqAgfQo+PiArI2lmZGVmIENPTkZJR19B
Uk02NAo+PiArwqDCoMKgIHFkZXYtPnJhbV9oZWFkZXIgPSBpb3JlbWFwX2NhY2hlKHFkZXYtPnZy
YW1fYmFzZSArCj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgcWRldi0+
cm9tLT5yYW1faGVhZGVyX29mZnNldCwKPj4gK8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCBzaXplb2YoKnFkZXYtPnJhbV9oZWFkZXIpKTsKPj4gKyNlbHNlCj4+IMKgwqDCoMKg
wqAgcWRldi0+cmFtX2hlYWRlciA9IGlvcmVtYXAocWRldi0+dnJhbV9iYXNlICsKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCBxZGV2LT5yb20tPnJhbV9oZWFkZXJf
b2Zmc2V0LAo+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHNpemVv
ZigqcWRldi0+cmFtX2hlYWRlcikpOwo+PiArI2VuZGlmCj4+IMKgwqDCoMKgwqAgaWYgKCFxZGV2
LT5yYW1faGVhZGVyKSB7Cj4+IMKgwqDCoMKgwqDCoMKgwqDCoCBEUk1fRVJST1IoIlVuYWJsZSB0
byBpb3JlbWFwIFJBTSBoZWFkZXJcbiIpOwo+PiDCoMKgwqDCoMKgwqDCoMKgwqAgciA9IC1FTk9N
RU07Cj4gCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
