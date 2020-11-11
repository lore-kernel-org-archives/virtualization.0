Return-Path: <SRS0=5vFd=ER=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F0FDC388F9
	for <virtualization@archiver.kernel.org>; Wed, 11 Nov 2020 12:08:13 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A4D7B206C0
	for <virtualization@archiver.kernel.org>; Wed, 11 Nov 2020 12:08:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A4D7B206C0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=suse.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0051B87531;
	Wed, 11 Nov 2020 12:08:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3ykmVBVW3A-N; Wed, 11 Nov 2020 12:08:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C17A58736E;
	Wed, 11 Nov 2020 12:08:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AE123C0889;
	Wed, 11 Nov 2020 12:08:10 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 935ACC016F
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Nov 2020 12:08:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 7EED222E89
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Nov 2020 12:08:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id cUvpDzgtMvTj
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Nov 2020 12:08:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mx2.suse.de (mx2.suse.de [195.135.220.15])
 by silver.osuosl.org (Postfix) with ESMTPS id C0C6421515
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Nov 2020 12:08:06 +0000 (UTC)
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
 by mx2.suse.de (Postfix) with ESMTP id 9400DABDE;
 Wed, 11 Nov 2020 12:08:04 +0000 (UTC)
Subject: Re: [PATCH] drm/nouveau: Fix out-of-bounds access when deferencing
 MMU type
To: "Ruhl, Michael J" <michael.j.ruhl@intel.com>,
 "bskeggs@redhat.com" <bskeggs@redhat.com>,
 "airlied@linux.ie" <airlied@linux.ie>, "daniel@ffwll.ch" <daniel@ffwll.ch>,
 "christian.koenig@amd.com" <christian.koenig@amd.com>
References: <20201110133655.13174-1-tzimmermann@suse.de>
 <85758a6215f74917aee81b18d037fb82@intel.com>
From: Thomas Zimmermann <tzimmermann@suse.de>
Message-ID: <f4cedda2-48f6-565c-4154-0975a2d119a0@suse.de>
Date: Wed, 11 Nov 2020 13:08:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.4.0
MIME-Version: 1.0
In-Reply-To: <85758a6215f74917aee81b18d037fb82@intel.com>
Content-Language: en-US
Cc: "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
 "nouveau@lists.freedesktop.org" <nouveau@lists.freedesktop.org>,
 "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Roland Scheidegger <sroland@vmware.com>, Jason Gunthorpe <jgg@ziepe.ca>,
 Huang Rui <ray.huang@amd.com>,
 VMware Graphics <linux-graphics-maintainer@vmware.com>,
 "spice-devel@lists.freedesktop.org" <spice-devel@lists.freedesktop.org>,
 Alex Deucher <alexander.deucher@amd.com>, Dave Airlie <airlied@redhat.com>,
 Likun Gao <Likun.Gao@amd.com>, Felix Kuehling <Felix.Kuehling@amd.com>,
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

SGkKCkFtIDEwLjExLjIwIHVtIDE2OjI3IHNjaHJpZWIgUnVobCwgTWljaGFlbCBKOgo+IAo+IAo+
PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQo+PiBGcm9tOiBUaG9tYXMgWmltbWVybWFubiA8
dHppbW1lcm1hbm5Ac3VzZS5kZT4KPj4gU2VudDogVHVlc2RheSwgTm92ZW1iZXIgMTAsIDIwMjAg
ODozNyBBTQo+PiBUbzogYnNrZWdnc0ByZWRoYXQuY29tOyBhaXJsaWVkQGxpbnV4LmllOyBkYW5p
ZWxAZmZ3bGwuY2g7IFJ1aGwsIE1pY2hhZWwgSgo+PiA8bWljaGFlbC5qLnJ1aGxAaW50ZWwuY29t
PjsgY2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tCj4+IENjOiBub3V2ZWF1QGxpc3RzLmZyZWVkZXNr
dG9wLm9yZzsgZHJpLWRldmVsQGxpc3RzLmZyZWVkZXNrdG9wLm9yZzsgVGhvbWFzCj4+IFppbW1l
cm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+OyBNYWFydGVuIExhbmtob3JzdAo+PiA8bWFhcnRl
bi5sYW5raG9yc3RAbGludXguaW50ZWwuY29tPjsgTWF4aW1lIFJpcGFyZAo+PiA8bXJpcGFyZEBr
ZXJuZWwub3JnPjsgRGF2ZSBBaXJsaWUgPGFpcmxpZWRAcmVkaGF0LmNvbT47IEdlcmQgSG9mZm1h
bm4KPj4gPGtyYXhlbEByZWRoYXQuY29tPjsgQWxleCBEZXVjaGVyIDxhbGV4YW5kZXIuZGV1Y2hl
ckBhbWQuY29tPjsKPj4gVk13YXJlIEdyYXBoaWNzIDxsaW51eC1ncmFwaGljcy1tYWludGFpbmVy
QHZtd2FyZS5jb20+OyBSb2xhbmQKPj4gU2NoZWlkZWdnZXIgPHNyb2xhbmRAdm13YXJlLmNvbT47
IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+Owo+PiBGZWxpeCBLdWVobGluZyA8RmVsaXgu
S3VlaGxpbmdAYW1kLmNvbT47IEhhd2tpbmcgWmhhbmcKPj4gPEhhd2tpbmcuWmhhbmdAYW1kLmNv
bT47IEphc29uIEd1bnRob3JwZSA8amdnQHppZXBlLmNhPjsgTGlrdW4gR2FvCj4+IDxMaWt1bi5H
YW9AYW1kLmNvbT47IHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnOyBz
cGljZS0KPj4gZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnOyBhbWQtZ2Z4QGxpc3RzLmZyZWVk
ZXNrdG9wLm9yZwo+PiBTdWJqZWN0OiBbUEFUQ0hdIGRybS9ub3V2ZWF1OiBGaXggb3V0LW9mLWJv
dW5kcyBhY2Nlc3Mgd2hlbiBkZWZlcmVuY2luZwo+PiBNTVUgdHlwZQo+Pgo+PiBUaGUgdmFsdWUg
b2Ygc3RydWN0IGRybV9kZXZpY2UudHRtLnR5cGVfdnJhbSBjYW4gYmVjb21lIC0xIGZvciB1bmtu
b3duCj4+IHR5cGVzIG9mIG1lbW9yeSAoc2VlIG5vdXZlYXVfdHRtX2luaXQoKSkuIFRoaXMgbGVh
ZHMgdG8gYW4gb3V0LW9mLWJvdW5kcwo+PiBlcnJvciB3aGVuIGFjY2Vzc2luZyBzdHJ1Y3QgbnZp
Zl9tbXUudHlwZVtdOgo+IAo+IFdvdWxkIHRoaXMgbWFrZSBtb3JlIHNlbnNlIHRvIGp1c3Qgc2V0
IHRoZSB0eXBlX3ZyYW0gPSAwIGluc3RlYWQgb2YgLTE/CgpGcm9tIHdoYXQgSSB1bmRlcnN0YW5k
LCB0aGVzZSBpbmRpY2VzIHJlZmVyIHRvIGFuIGludGVybmFsIHR5cGUgb2YgTU1VLApyc3AgdGhl
IE1NVSdzIGNhcGFiaWxpdGllcy4gSG93ZXZlciwgbXkgaGFyZHdhcmUgKHByZS1OVjUwKSBkb2Vz
IG5vdApoYXZlIGFuIE1NVSBhdCBhbGwuCgpJIGFncmVlIHRoYXQgaXQgd291bGQgYmUgbmljZSB0
byBoYXZlIGEgY2xlYW5lciBkZXNpZ24gdGhhdCBpbmNvcnBvcmF0ZXMKdGhpcyBjYXNlLCBidXQg
cmVzb2x2aW5nIHRoYXQgd291bGQgYXBwYXJlbnRseSByZXF1aXJlIG1vcmUgdGhhbiBhIGJ1Z2Zp
eC4KCkJlc3QgcmVnYXJkcwpUaG9tYXMKCj4gCj4gTWlrZQo+IAo+Pgo+PiAgWyAgIDE4LjMwNDEx
Nl0KPj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT0KPj4gPT09PT09PQo+PiAgWyAgIDE4LjMxMTY0OV0gQlVHOiBLQVNBTjogc2xhYi1v
dXQtb2YtYm91bmRzIGluCj4+IG5vdXZlYXVfdHRtX2lvX21lbV9yZXNlcnZlKzB4MTdhLzB4N2Uw
IFtub3V2ZWF1XQo+PiAgWyAgIDE4LjMyMDQxNV0gUmVhZCBvZiBzaXplIDEgYXQgYWRkciBmZmZm
ODg4MTBmZmFjMWZlIGJ5IHRhc2sgc3lzdGVtZC0KPj4gdWRldmQvMzQyCj4+ICBbICAgMTguMzI3
NjgxXQo+PiAgWyAgIDE4LjMyOTIwOF0gQ1BVOiAxIFBJRDogMzQyIENvbW06IHN5c3RlbWQtdWRl
dmQgVGFpbnRlZDogRyAgICAgICAgICAgIEUKPj4gNS4xMC4wLXJjMi0xLWRlZmF1bHQrICM1ODEK
Pj4gIFsgICAxOC4zMzg2ODFdIEhhcmR3YXJlIG5hbWU6IERlbGwgSW5jLiBPcHRpUGxleCA5MDIw
LzBONFlDOCwgQklPUyBBMjQKPj4gMTAvMjQvMjAxOAo+PiAgWyAgIDE4LjM0NjAzMl0gQ2FsbCBU
cmFjZToKPj4gIFsgICAxOC4zNDg1MzZdICBkdW1wX3N0YWNrKzB4YWUvMHhlNQo+PiAgWyAgIDE4
LjM1MTkxOV0gIHByaW50X2FkZHJlc3NfZGVzY3JpcHRpb24uY29uc3Rwcm9wLjArMHgxNy8weGYw
Cj4+ICBbICAgMTguMzU3Nzg3XSAgPyBub3V2ZWF1X3R0bV9pb19tZW1fcmVzZXJ2ZSsweDE3YS8w
eDdlMCBbbm91dmVhdV0KPj4gIFsgICAxOC4zNjM4MThdICBfX2thc2FuX3JlcG9ydC5jb2xkKzB4
MjAvMHgzOAo+PiAgWyAgIDE4LjM2ODA5OV0gID8gbm91dmVhdV90dG1faW9fbWVtX3Jlc2VydmUr
MHgxN2EvMHg3ZTAgW25vdXZlYXVdCj4+ICBbICAgMTguMzc0MTMzXSAga2FzYW5fcmVwb3J0KzB4
M2EvMHg1MAo+PiAgWyAgIDE4LjM3Nzc4OV0gIG5vdXZlYXVfdHRtX2lvX21lbV9yZXNlcnZlKzB4
MTdhLzB4N2UwIFtub3V2ZWF1XQo+PiAgPC4uLj4KPj4gIFsgICAxOC43Njc2OTBdIEFsbG9jYXRl
ZCBieSB0YXNrIDM0MjoKPj4gIFsgICAxOC43NzMwODddICBrYXNhbl9zYXZlX3N0YWNrKzB4MWIv
MHg0MAo+PiAgWyAgIDE4Ljc3ODg5MF0gIF9fa2FzYW5fa21hbGxvYy5jb25zdHByb3AuMCsweGJm
LzB4ZDAKPj4gIFsgICAxOC43ODU2NDZdICBfX2ttYWxsb2NfdHJhY2tfY2FsbGVyKzB4MWJlLzB4
MzkwCj4+ICBbICAgMTguNzkyMTY1XSAga3N0cmR1cF9jb25zdCsweDQ2LzB4NzAKPj4gIFsgICAx
OC43OTc2ODZdICBrb2JqZWN0X3NldF9uYW1lX3ZhcmdzKzB4MmYvMHhiMAo+PiAgWyAgIDE4Ljgw
Mzk5Ml0gIGtvYmplY3RfaW5pdF9hbmRfYWRkKzB4OWQvMHhmMAo+PiAgWyAgIDE4LjgxMDExN10g
IHR0bV9tZW1fZ2xvYmFsX2luaXQrMHgxMmMvMHgyMTAgW3R0bV0KPj4gIFsgICAxOC44MTY4NTNd
ICB0dG1fYm9fZ2xvYmFsX2luaXQrMHg0YS8weDE2MCBbdHRtXQo+PiAgWyAgIDE4LjgyMzQyMF0g
IHR0bV9ib19kZXZpY2VfaW5pdCsweDM5LzB4MjIwIFt0dG1dCj4+ICBbICAgMTguODMwMDQ2XSAg
bm91dmVhdV90dG1faW5pdCsweDJjMy8weDgzMCBbbm91dmVhdV0KPj4gIFsgICAxOC44MzY5Mjld
ICBub3V2ZWF1X2RybV9kZXZpY2VfaW5pdCsweDFiNC8weDNmMCBbbm91dmVhdV0KPj4gIDwuLi4+
Cj4+ICBbICAgMTkuMTA1MzM2XQo+PiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PQo+PiA9PT09PT09Cj4+Cj4+IEZpeCB0aGlzIGVycm9y
LCBieSBub3QgdXNpbmcgdHlwZV92cmFtIGFzIGFuIGluZGV4IGlmIGl0J3MgbmVnYXRpdmUuCj4+
IEFzc3VtZSBkZWZhdWx0IHZhbHVlcyBpbnN0ZWFkLgo+Pgo+PiBUaGUgZXJyb3Igd2FzIHNlZW4g
b24gTnZpZGlhIEc3MiBoYXJkd2FyZS4KPj4KPj4gU2lnbmVkLW9mZi1ieTogVGhvbWFzIFppbW1l
cm1hbm4gPHR6aW1tZXJtYW5uQHN1c2UuZGU+Cj4+IEZpeGVzOiAxY2Y2NWM0NTE4M2EgKCJkcm0v
dHRtOiBhZGQgY2FjaGluZyBzdGF0ZSB0byB0dG1fYnVzX3BsYWNlbWVudCIpCj4+IENjOiBDaHJp
c3RpYW4gS8O2bmlnIDxjaHJpc3RpYW4ua29lbmlnQGFtZC5jb20+Cj4+IENjOiBNaWNoYWVsIEou
IFJ1aGwgPG1pY2hhZWwuai5ydWhsQGludGVsLmNvbT4KPj4gQ2M6IE1hYXJ0ZW4gTGFua2hvcnN0
IDxtYWFydGVuLmxhbmtob3JzdEBsaW51eC5pbnRlbC5jb20+Cj4+IENjOiBNYXhpbWUgUmlwYXJk
IDxtcmlwYXJkQGtlcm5lbC5vcmc+Cj4+IENjOiBUaG9tYXMgWmltbWVybWFubiA8dHppbW1lcm1h
bm5Ac3VzZS5kZT4KPj4gQ2M6IERhdmlkIEFpcmxpZSA8YWlybGllZEBsaW51eC5pZT4KPj4gQ2M6
IERhbmllbCBWZXR0ZXIgPGRhbmllbEBmZndsbC5jaD4KPj4gQ2M6IEJlbiBTa2VnZ3MgPGJza2Vn
Z3NAcmVkaGF0LmNvbT4KPj4gQ2M6IERhdmUgQWlybGllIDxhaXJsaWVkQHJlZGhhdC5jb20+Cj4+
IENjOiBHZXJkIEhvZmZtYW5uIDxrcmF4ZWxAcmVkaGF0LmNvbT4KPj4gQ2M6IEFsZXggRGV1Y2hl
ciA8YWxleGFuZGVyLmRldWNoZXJAYW1kLmNvbT4KPj4gQ2M6ICJDaHJpc3RpYW4gS8O2bmlnIiA8
Y2hyaXN0aWFuLmtvZW5pZ0BhbWQuY29tPgo+PiBDYzogVk13YXJlIEdyYXBoaWNzIDxsaW51eC1n
cmFwaGljcy1tYWludGFpbmVyQHZtd2FyZS5jb20+Cj4+IENjOiBSb2xhbmQgU2NoZWlkZWdnZXIg
PHNyb2xhbmRAdm13YXJlLmNvbT4KPj4gQ2M6IEh1YW5nIFJ1aSA8cmF5Lmh1YW5nQGFtZC5jb20+
Cj4+IENjOiBGZWxpeCBLdWVobGluZyA8RmVsaXguS3VlaGxpbmdAYW1kLmNvbT4KPj4gQ2M6IEhh
d2tpbmcgWmhhbmcgPEhhd2tpbmcuWmhhbmdAYW1kLmNvbT4KPj4gQ2M6IEphc29uIEd1bnRob3Jw
ZSA8amdnQHppZXBlLmNhPgo+PiBDYzogTGlrdW4gR2FvIDxMaWt1bi5HYW9AYW1kLmNvbT4KPj4g
Q2M6IGRyaS1kZXZlbEBsaXN0cy5mcmVlZGVza3RvcC5vcmcKPj4gQ2M6IG5vdXZlYXVAbGlzdHMu
ZnJlZWRlc2t0b3Aub3JnCj4+IENjOiB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwo+PiBDYzogc3BpY2UtZGV2ZWxAbGlzdHMuZnJlZWRlc2t0b3Aub3JnCj4+IENjOiBh
bWQtZ2Z4QGxpc3RzLmZyZWVkZXNrdG9wLm9yZwo+PiAtLS0KPj4gZHJpdmVycy9ncHUvZHJtL25v
dXZlYXUvbm91dmVhdV9iby5jIHwgNSArKysrLQo+PiAxIGZpbGUgY2hhbmdlZCwgNCBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2dwdS9kcm0v
bm91dmVhdS9ub3V2ZWF1X2JvLmMKPj4gYi9kcml2ZXJzL2dwdS9kcm0vbm91dmVhdS9ub3V2ZWF1
X2JvLmMKPj4gaW5kZXggODEzMzM3N2Q4NjVkLi5mZTE1Mjk5ZDQxN2UgMTAwNjQ0Cj4+IC0tLSBh
L2RyaXZlcnMvZ3B1L2RybS9ub3V2ZWF1L25vdXZlYXVfYm8uYwo+PiArKysgYi9kcml2ZXJzL2dw
dS9kcm0vbm91dmVhdS9ub3V2ZWF1X2JvLmMKPj4gQEAgLTExNDIsOSArMTE0MiwxMiBAQCBub3V2
ZWF1X3R0bV9pb19tZW1fcmVzZXJ2ZShzdHJ1Y3QKPj4gdHRtX2JvX2RldmljZSAqYmRldiwgc3Ry
dWN0IHR0bV9yZXNvdXJjZSAqcmVnKQo+PiAJc3RydWN0IG52a21fZGV2aWNlICpkZXZpY2UgPSBu
dnh4X2RldmljZSgmZHJtLT5jbGllbnQuZGV2aWNlKTsKPj4gCXN0cnVjdCBub3V2ZWF1X21lbSAq
bWVtID0gbm91dmVhdV9tZW0ocmVnKTsKPj4gCXN0cnVjdCBudmlmX21tdSAqbW11ID0gJmRybS0+
Y2xpZW50Lm1tdTsKPj4gLQljb25zdCB1OCB0eXBlID0gbW11LT50eXBlW2RybS0+dHRtLnR5cGVf
dnJhbV0udHlwZTsKPj4gKwl1OCB0eXBlID0gMDsKPj4gCWludCByZXQ7Cj4+Cj4+ICsJaWYgKGRy
bS0+dHRtLnR5cGVfdnJhbSA+PSAwKQo+PiArCQl0eXBlID0gbW11LT50eXBlW2RybS0+dHRtLnR5
cGVfdnJhbV0udHlwZTsKPj4gKwo+PiAJbXV0ZXhfbG9jaygmZHJtLT50dG0uaW9fcmVzZXJ2ZV9t
dXRleCk7Cj4+IHJldHJ5Ogo+PiAJc3dpdGNoIChyZWctPm1lbV90eXBlKSB7Cj4+IC0tCj4+IDIu
MjkuMgo+IAoKLS0gClRob21hcyBaaW1tZXJtYW5uCkdyYXBoaWNzIERyaXZlciBEZXZlbG9wZXIK
U1VTRSBTb2Z0d2FyZSBTb2x1dGlvbnMgR2VybWFueSBHbWJICk1heGZlbGRzdHIuIDUsIDkwNDA5
IE7DvHJuYmVyZywgR2VybWFueQooSFJCIDM2ODA5LCBBRyBOw7xybmJlcmcpCkdlc2Now6RmdHNm
w7xocmVyOiBGZWxpeCBJbWVuZMO2cmZmZXIKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
