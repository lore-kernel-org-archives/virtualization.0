Return-Path: <SRS0=ow7J=HD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAD93C433E0
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 03:36:42 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4121464E25
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 03:36:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4121464E25
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id D63382002F;
	Mon,  1 Feb 2021 03:36:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id x0ufvN7lYk17; Mon,  1 Feb 2021 03:36:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 6B4FE20009;
	Mon,  1 Feb 2021 03:36:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3C0BEC0174;
	Mon,  1 Feb 2021 03:36:38 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C4A69C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 03:36:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id C095F86F12
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 03:36:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wkolpOd0CLOn
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 03:36:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 8C21886E64
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 03:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612150594;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/gAb6zAwOxu2R4KqWA0oIvyoIahKBpzIeRdzj32BG5w=;
 b=S9EjiCHNSJAa30GxK7Jc5jifaFq8KwhyPSpYIm/K6pPS7vb+Q0sD/1RWwMkWEUq2oWtrqO
 NlIU3IBScXHKaiULS3J8bIVilVkEYcP0dukPP+uFFKU22oYPXjJzgp462C6de+cgQZedbh
 rQ/7zMOhyV6hPPhalMsTm/fc2zgP61c=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-389-3I_W8Ol6Ns6EcSdpf565sA-1; Sun, 31 Jan 2021 22:36:31 -0500
X-MC-Unique: 3I_W8Ol6Ns6EcSdpf565sA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 83616801B13;
 Mon,  1 Feb 2021 03:36:30 +0000 (UTC)
Received: from [10.72.13.233] (ovpn-13-233.pek2.redhat.com [10.72.13.233])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEE9D5D9DC;
 Mon,  1 Feb 2021 03:36:24 +0000 (UTC)
Subject: Re: [PATCH 2/2] vdpa/mlx5: Restore the hardware used index after
 change map
To: Eli Cohen <elic@nvidia.com>
References: <20210128134130.3051-1-elic@nvidia.com>
 <20210128134130.3051-3-elic@nvidia.com>
 <54239b51-918c-3475-dc88-4da1a4548da8@redhat.com>
 <20210131185536.GA164217@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0c99f35c-7644-7201-cd11-7d486389a182@redhat.com>
Date: Mon, 1 Feb 2021 11:36:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210131185536.GA164217@mtl-vdi-166.wap.labs.mlnx>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, lulu@redhat.com, mst@redhat.com
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

Ck9uIDIwMjEvMi8xIOS4iuWNiDI6NTUsIEVsaSBDb2hlbiB3cm90ZToKPiBPbiBGcmksIEphbiAy
OSwgMjAyMSBhdCAxMTo0OTo0NUFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiBPbiAyMDIx
LzEvMjgg5LiL5Y2IOTo0MSwgRWxpIENvaGVuIHdyb3RlOgo+Pj4gV2hlbiBhIGNoYW5nZSBvZiBt
ZW1vcnkgbWFwIG9jY3VycywgdGhlIGhhcmR3YXJlIHJlc291cmNlcyBhcmUgZGVzdHJveWVkCj4+
PiBhbmQgdGhlbiByZS1jcmVhdGVkIGFnYWluIHdpdGggdGhlIG5ldyBtZW1vcnkgbWFwLiBJbiBz
dWNoIGNhc2UsIHdlIG5lZWQKPj4+IHRvIHJlc3RvcmUgdGhlIGhhcmR3YXJlIGF2YWlsYWJsZSBh
bmQgdXNlZCBpbmRpY2VzLiBUaGUgZHJpdmVyIGZhaWxlZCB0bwo+Pj4gcmVzdG9yZSB0aGUgdXNl
ZCBpbmRleCB3aGljaCBpcyBhZGRlZCBoZXJlLgo+Pj4KPj4+IEZpeGVzIDFhODZiMzc3YWEyMSAo
InZkcGEvbWx4NTogQWRkIFZEUEEgZHJpdmVyIGZvciBzdXBwb3J0ZWQgbWx4NSBkZXZpY2VzIikK
Pj4+IFNpZ25lZC1vZmYtYnk6IEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPgo+Pgo+PiBBIHF1
ZXN0aW9uLiBEb2VzIHRoaXMgbWVhbiBhZnRlciBhIHZxIGlzIHN1c3BlbmRlZCwgdGhlIGh3IHVz
ZWQgaW5kZXggaXMgbm90Cj4+IGVxdWFsIHRvIHZxIHVzZWQgaW5kZXg/Cj4gU3VyZWx5IHRoZXJl
IGlzIGp1c3Qgb25lICJVc2VkIGluZGV4IiBmb3IgYSBWUS4gV2hhdCBJIHdhcyB0cnlpbmcgdG8g
c2F5Cj4gaXMgdGhhdCBhZnRlciB0aGUgVlEgaXMgc3VzcGVuZGVkLCBJIHJlYWQgdGhlIHVzZWQg
aW5kZXggYnkgcXVlcnlpbmcgdGhlCj4gaGFyZHdhcmUuIFRoZSByZWFkIHJlc3VsdCBpcyB0aGUg
dXNlZCBpbmRleCB0aGF0IHRoZSBoYXJkd2FyZSB3cm90ZSB0bwo+IG1lbW9yeS4KCgpKdXN0IHRv
IG1ha2Ugc3VyZSBJIHVuZGVyc3RhbmQgaGVyZS4gU28gaXQgbG9va3MgdG8gbWUgd2UgaGFkIHR3
byBpbmRleC4gClRoZSBmaXJzdCBpcyB0aGUgdXNlZCBpbmRleCB3aGljaCBpcyBzdG9yZWQgaW4g
dGhlIG1lbW9yeS92aXJ0cXVldWUsIHRoZSAKc2Vjb25kIGlzIHRoZSBvbmUgdGhhdCBpcyBzdG9y
ZWQgYnkgdGhlIGRldmljZS4KCgo+ICAgQWZ0ZXIgdGhlIEkgY3JlYXRlIHRoZSBuZXcgaGFyZHdh
cmUgb2JqZWN0LCBJIG5lZWQgdG8gdGVsbCBpdAo+IHdoYXQgaXMgdGhlIHVzZWQgaW5kZXggKGFu
ZCB0aGUgYXZhaWxhYmxlIGluZGV4KSBhcyBhIHdheSB0byBzeW5jIGl0Cj4gd2l0aCB0aGUgZXhp
c3RpbmcgVlEuCgoKRm9yIGF2YWlsIGluZGV4IEkgdW5kZXJzdGFuZCB0aGF0IHRoZSBoYXJkd2Fy
ZSBpbmRleCBpcyBub3Qgc3luY2VkIHdpdGggCnRoZSBhdmFpbCBpbmRleCBzdG9yZWQgaW4gdGhl
IG1lbW9yeS92aXJ0cXVldWUuIFRoZSBxdWVzdGlvbiBpcyB1c2VkIAppbmRleCwgaWYgdGhlIGhh
cmR3YXJlIG9uZSBpcyBub3Qgc3luY2VkIHdpdGggdGhlIG9uZSBpbiB0aGUgdmlydHF1ZXVlLiAK
SXQgbWVhbnMgYWZ0ZXIgdnEgaXMgc3VzcGVuZGVkLMKgIHNvbWUgcmVxdWVzdHMgaXMgbm90IGNv
bXBsZXRlZCBieSB0aGUgCmhhcmR3YXJlIChlLmcgdGhlIGJ1ZmZlciB3ZXJlIG5vdCBwdXQgdG8g
dXNlZCByaW5nKS4KClRoaXMgbWF5IGhhdmUgaW1wbGljYXRpb25zIHRvIGxpdmUgbWlncmF0aW9u
LCBpdCBtZWFucyB0aG9zZSAKdW5hY2NvbXBsaXNoZWQgcmVxdWVzdHMgbmVlZHMgdG8gYmUgbWln
cmF0ZWQgdG8gdGhlIGRlc3RpbmF0aW9uIGFuZCAKcmVzdWJtaXR0ZWQgdG8gdGhlIGRldmljZS4g
VGhpcyBsb29rcyBub3QgZWFzeS4KClRoYW5rcwoKCj4KPiBUaGlzIHN5bmMgaXMgZXNwZWNpYWxs
eSBpbXBvcnRhbnQgd2hlbiBhIGNoYW5nZSBvZiBtYXAgb2NjdXJzIHdoaWxlIHRoZQo+IFZRIHdh
cyBhbHJlYWR5IHVzZWQgKGhlbmNlIHRoZSBpbmRpY2VzIGFyZSBsaWtlbHkgdG8gYmUgbm9uIHpl
cm8pLiBUaGlzCj4gY2FuIGJlIHRyaWdnZXJlZCBieSBob3QgYWRkaW5nIG1lbW9yeSBhZnRlciB0
aGUgVlFzIGhhdmUgYmVlbiB1c2VkLgo+Cj4+IFRoYW5rcwo+Pgo+Pgo+Pj4gLS0tCj4+PiAgICBk
cml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCA3ICsrKysrKysKPj4+ICAgIDEgZmls
ZSBjaGFuZ2VkLCA3IGluc2VydGlvbnMoKykKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
ZHBhL21seDUvbmV0L21seDVfdm5ldC5jIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5l
dC5jCj4+PiBpbmRleCA1NDlkZWQwNzRmZjMuLjNmYzg1ODhjZWNhZSAxMDA2NDQKPj4+IC0tLSBh
L2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+Pj4gKysrIGIvZHJpdmVycy92ZHBh
L21seDUvbmV0L21seDVfdm5ldC5jCj4+PiBAQCAtODcsNiArODcsNyBAQCBzdHJ1Y3QgbWx4NV92
cV9yZXN0b3JlX2luZm8gewo+Pj4gICAgCXU2NCBkZXZpY2VfYWRkcjsKPj4+ICAgIAl1NjQgZHJp
dmVyX2FkZHI7Cj4+PiAgICAJdTE2IGF2YWlsX2luZGV4Owo+Pj4gKwl1MTYgdXNlZF9pbmRleDsK
Pj4+ICAgIAlib29sIHJlYWR5Owo+Pj4gICAgCXN0cnVjdCB2ZHBhX2NhbGxiYWNrIGNiOwo+Pj4g
ICAgCWJvb2wgcmVzdG9yZTsKPj4+IEBAIC0xMjEsNiArMTIyLDcgQEAgc3RydWN0IG1seDVfdmRw
YV92aXJ0cXVldWUgewo+Pj4gICAgCXUzMiB2aXJ0cV9pZDsKPj4+ICAgIAlzdHJ1Y3QgbWx4NV92
ZHBhX25ldCAqbmRldjsKPj4+ICAgIAl1MTYgYXZhaWxfaWR4Owo+Pj4gKwl1MTYgdXNlZF9pZHg7
Cj4+PiAgICAJaW50IGZ3X3N0YXRlOwo+Pj4gICAgCS8qIGtlZXAgbGFzdCBpbiB0aGUgc3RydWN0
ICovCj4+PiBAQCAtODA0LDYgKzgwNiw3IEBAIHN0YXRpYyBpbnQgY3JlYXRlX3ZpcnRxdWV1ZShz
dHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiwgc3RydWN0IG1seDVfdmRwYV92aXJ0cXVlCj4+PiAg
ICAJb2JqX2NvbnRleHQgPSBNTFg1X0FERFJfT0YoY3JlYXRlX3ZpcnRpb19uZXRfcV9pbiwgaW4s
IG9ial9jb250ZXh0KTsKPj4+ICAgIAlNTFg1X1NFVCh2aXJ0aW9fbmV0X3Ffb2JqZWN0LCBvYmpf
Y29udGV4dCwgaHdfYXZhaWxhYmxlX2luZGV4LCBtdnEtPmF2YWlsX2lkeCk7Cj4+PiArCU1MWDVf
U0VUKHZpcnRpb19uZXRfcV9vYmplY3QsIG9ial9jb250ZXh0LCBod191c2VkX2luZGV4LCBtdnEt
PnVzZWRfaWR4KTsKPj4+ICAgIAlNTFg1X1NFVCh2aXJ0aW9fbmV0X3Ffb2JqZWN0LCBvYmpfY29u
dGV4dCwgcXVldWVfZmVhdHVyZV9iaXRfbWFza18xMl8zLAo+Pj4gICAgCQkgZ2V0X2ZlYXR1cmVz
XzEyXzMobmRldi0+bXZkZXYuYWN0dWFsX2ZlYXR1cmVzKSk7Cj4+PiAgICAJdnFfY3R4ID0gTUxY
NV9BRERSX09GKHZpcnRpb19uZXRfcV9vYmplY3QsIG9ial9jb250ZXh0LCB2aXJ0aW9fcV9jb250
ZXh0KTsKPj4+IEBAIC0xMDIyLDYgKzEwMjUsNyBAQCBzdGF0aWMgaW50IGNvbm5lY3RfcXBzKHN0
cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2LCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWV1ZSAqbQo+
Pj4gICAgc3RydWN0IG1seDVfdmlydHFfYXR0ciB7Cj4+PiAgICAJdTggc3RhdGU7Cj4+PiAgICAJ
dTE2IGF2YWlsYWJsZV9pbmRleDsKPj4+ICsJdTE2IHVzZWRfaW5kZXg7Cj4+PiAgICB9Owo+Pj4g
ICAgc3RhdGljIGludCBxdWVyeV92aXJ0cXVldWUoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYs
IHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXVlICptdnEsCj4+PiBAQCAtMTA1Miw2ICsxMDU2LDcg
QEAgc3RhdGljIGludCBxdWVyeV92aXJ0cXVldWUoc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYs
IHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXUKPj4+ICAgIAltZW1zZXQoYXR0ciwgMCwgc2l6ZW9m
KCphdHRyKSk7Cj4+PiAgICAJYXR0ci0+c3RhdGUgPSBNTFg1X0dFVCh2aXJ0aW9fbmV0X3Ffb2Jq
ZWN0LCBvYmpfY29udGV4dCwgc3RhdGUpOwo+Pj4gICAgCWF0dHItPmF2YWlsYWJsZV9pbmRleCA9
IE1MWDVfR0VUKHZpcnRpb19uZXRfcV9vYmplY3QsIG9ial9jb250ZXh0LCBod19hdmFpbGFibGVf
aW5kZXgpOwo+Pj4gKwlhdHRyLT51c2VkX2luZGV4ID0gTUxYNV9HRVQodmlydGlvX25ldF9xX29i
amVjdCwgb2JqX2NvbnRleHQsIGh3X3VzZWRfaW5kZXgpOwo+Pj4gICAgCWtmcmVlKG91dCk7Cj4+
PiAgICAJcmV0dXJuIDA7Cj4+PiBAQCAtMTYwMiw2ICsxNjA3LDcgQEAgc3RhdGljIGludCBzYXZl
X2NoYW5uZWxfaW5mbyhzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiwgc3RydWN0IG1seDVfdmRw
YV92aXJ0cXUKPj4+ICAgIAkJcmV0dXJuIGVycjsKPj4+ICAgIAlyaS0+YXZhaWxfaW5kZXggPSBh
dHRyLmF2YWlsYWJsZV9pbmRleDsKPj4+ICsJcmktPnVzZWRfaW5kZXggPSBhdHRyLnVzZWRfaW5k
ZXg7Cj4+PiAgICAJcmktPnJlYWR5ID0gbXZxLT5yZWFkeTsKPj4+ICAgIAlyaS0+bnVtX2VudCA9
IG12cS0+bnVtX2VudDsKPj4+ICAgIAlyaS0+ZGVzY19hZGRyID0gbXZxLT5kZXNjX2FkZHI7Cj4+
PiBAQCAtMTY0Niw2ICsxNjUyLDcgQEAgc3RhdGljIHZvaWQgcmVzdG9yZV9jaGFubmVsc19pbmZv
KHN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2KQo+Pj4gICAgCQkJY29udGludWU7Cj4+PiAgICAJ
CW12cS0+YXZhaWxfaWR4ID0gcmktPmF2YWlsX2luZGV4Owo+Pj4gKwkJbXZxLT51c2VkX2lkeCA9
IHJpLT51c2VkX2luZGV4Owo+Pj4gICAgCQltdnEtPnJlYWR5ID0gcmktPnJlYWR5Owo+Pj4gICAg
CQltdnEtPm51bV9lbnQgPSByaS0+bnVtX2VudDsKPj4+ICAgIAkJbXZxLT5kZXNjX2FkZHIgPSBy
aS0+ZGVzY19hZGRyOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
