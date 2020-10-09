Return-Path: <SRS0=qiqk=DQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE637C433DF
	for <virtualization@archiver.kernel.org>; Fri,  9 Oct 2020 03:49:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7DFFA22248
	for <virtualization@archiver.kernel.org>; Fri,  9 Oct 2020 03:49:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bpf5gow+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7DFFA22248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 233B7876A4;
	Fri,  9 Oct 2020 03:49:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Tqj6Ra+GctI0; Fri,  9 Oct 2020 03:49:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 78519876A5;
	Fri,  9 Oct 2020 03:49:56 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5E183C016F;
	Fri,  9 Oct 2020 03:49:56 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 703D5C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 03:49:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 4EEEC20410
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 03:49:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9NHuR7oc06IY
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 03:49:53 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id B917C2033E
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 03:49:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602215392;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9TF1EF4zJCZjRxFtIEJ5tn74n9O/x+z0nQ+pg77K66I=;
 b=bpf5gow+v84d6k2AkEI7y9gwIYR+qPTjlRgBb6h7CuKhffFcpyYd+X7nNO6fMVGlOm+WSb
 g0wqbz3UfpstCTLDgPYxkA8LO5j7HC9it0CzXHhob11ZgrRPbFgNFLGox8R+AmDjyXTxQs
 q91X4T1wGw53xW0YBtUeqQ9yWwrTZwM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-272-o-030-bYOD2Yu33kdPw8sA-1; Thu, 08 Oct 2020 23:49:50 -0400
X-MC-Unique: o-030-bYOD2Yu33kdPw8sA-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0D9731015ECB;
 Fri,  9 Oct 2020 03:49:49 +0000 (UTC)
Received: from [10.72.13.133] (ovpn-13-133.pek2.redhat.com [10.72.13.133])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 719415C1BD;
 Fri,  9 Oct 2020 03:49:33 +0000 (UTC)
Subject: Re: [RFC PATCH 08/24] vdpa: introduce virtqueue groups
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20200924032125.18619-1-jasowang@redhat.com>
 <20200924032125.18619-9-jasowang@redhat.com>
 <CAJaqyWdDX4JoPUHHXxkB=veiK9nETyqCPEJxcrHdjLmpE4PRCg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <3afd0747-d058-61b6-7818-f3c6993ef728@redhat.com>
Date: Fri, 9 Oct 2020 11:49:31 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CAJaqyWdDX4JoPUHHXxkB=veiK9nETyqCPEJxcrHdjLmpE4PRCg@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: Cindy Lu <lulu@redhat.com>, kvm list <kvm@vger.kernel.org>,
 Michael Tsirkin <mst@redhat.com>, netdev@vger.kernel.org,
 mhabets@solarflare.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, eli@mellanox.com,
 Maxime Coquelin <maxime.coquelin@redhat.com>, lingshan.zhu@intel.com,
 Rob Miller <rob.miller@broadcom.com>
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

Ck9uIDIwMjAvOS8yOCDkuIvljYgxMTo0NCwgRXVnZW5pbyBQZXJleiBNYXJ0aW4gd3JvdGU6Cj4g
T24gVGh1LCBTZXAgMjQsIDIwMjAgYXQgNToyMyBBTSBKYXNvbiBXYW5nPGphc293YW5nQHJlZGhh
dC5jb20+ICB3cm90ZToKPj4gVGhpcyBwYXRjaCBpbnRyb2R1Y2VzIHZpcnRxdWV1ZSBncm91cHMg
dG8gdkRQQSBkZXZpY2UuIFRoZSB2aXJ0cXVldWUKPj4gZ3JvdXAgaXMgdGhlIG1pbmltYWwgc2V0
IG9mIHZpcnRxdWV1ZXMgdGhhdCBtdXN0IHNoYXJlIGFuIGFkZHJlc3MKPj4gc3BhY2UuIEFuZCB0
aGUgYWRkZHJlc3Mgc3BhY2UgaWRlbnRpZmllciBjb3VsZCBvbmx5IGJlIGF0dGFjaGVkIHRvCj4+
IGEgc3BlY2lmaWMgdmlydHF1ZXVlIGdyb3VwLgo+Pgo+PiBBIG5ldyBtYW5kYXRlZCBidXMgb3Bl
cmF0aW9uIGlzIGludHJvZHVjZWQgdG8gZ2V0IHRoZSB2aXJ0cXVldWUgZ3JvdXAKPj4gSUQgZm9y
IGEgc3BlY2lmaWMgdmlydHF1ZXVlLgo+Pgo+PiBBbGwgdGhlIHZEUEEgZGV2aWNlIGRyaXZlcnMg
d2VyZSBjb252ZXJ0ZWQgdG8gc2ltcGx5IHN1cHBvcnQgYSBzaW5nbGUKPj4gdmlydHF1ZXVlIGdy
b3VwLgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nPGphc293YW5nQHJlZGhhdC5jb20+
Cj4+IC0tLQo+PiAgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgICB8ICA5ICsrKysr
KysrLQo+PiAgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8ICA4ICsrKysrKyst
Cj4+ICAgZHJpdmVycy92ZHBhL3ZkcGEuYyAgICAgICAgICAgICAgIHwgIDQgKysrLQo+PiAgIGRy
aXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jICB8IDExICsrKysrKysrKystCj4+ICAgaW5j
bHVkZS9saW51eC92ZHBhLmggICAgICAgICAgICAgIHwgMTIgKysrKysrKysrLS0tCj4+ICAgNSBm
aWxlcyBjaGFuZ2VkLCAzNyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyBiL2RyaXZlcnMvdmRwYS9p
ZmN2Zi9pZmN2Zl9tYWluLmMKPj4gaW5kZXggMDc2ZDdhYzVlNzIzLi5lNmEwYmUzNzRlNTEgMTAw
NjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPj4gKysrIGIvZHJp
dmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+PiBAQCAtMzI3LDYgKzMyNywxMSBAQCBzdGF0
aWMgdTMyIGlmY3ZmX3ZkcGFfZ2V0X3ZxX2FsaWduKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9k
ZXYpCj4+ICAgICAgICAgIHJldHVybiBJRkNWRl9RVUVVRV9BTElHTk1FTlQ7Cj4+ICAgfQo+Pgo+
PiArc3RhdGljIHUzMiBpZmN2Zl92ZHBhX2dldF92cV9ncm91cChzdHJ1Y3QgdmRwYV9kZXZpY2Ug
KnZkcGEsIHUxNiBpZHgpCj4+ICt7Cj4+ICsgICAgICAgcmV0dXJuIDA7Cj4+ICt9Cj4+ICsKPj4g
ICBzdGF0aWMgdm9pZCBpZmN2Zl92ZHBhX2dldF9jb25maWcoc3RydWN0IHZkcGFfZGV2aWNlICp2
ZHBhX2RldiwKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1bnNpZ25lZCBp
bnQgb2Zmc2V0LAo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKmJ1
ZiwgdW5zaWduZWQgaW50IGxlbikKPj4gQEAgLTM4Nyw2ICszOTIsNyBAQCBzdGF0aWMgY29uc3Qg
c3RydWN0IHZkcGFfY29uZmlnX29wcyBpZmNfdmRwYV9vcHMgPSB7Cj4+ICAgICAgICAgIC5nZXRf
ZGV2aWNlX2lkICA9IGlmY3ZmX3ZkcGFfZ2V0X2RldmljZV9pZCwKPj4gICAgICAgICAgLmdldF92
ZW5kb3JfaWQgID0gaWZjdmZfdmRwYV9nZXRfdmVuZG9yX2lkLAo+PiAgICAgICAgICAuZ2V0X3Zx
X2FsaWduICAgPSBpZmN2Zl92ZHBhX2dldF92cV9hbGlnbiwKPj4gKyAgICAgICAuZ2V0X3ZxX2dy
b3VwICAgPSBpZmN2Zl92ZHBhX2dldF92cV9ncm91cCwKPj4gICAgICAgICAgLmdldF9jb25maWcg
ICAgID0gaWZjdmZfdmRwYV9nZXRfY29uZmlnLAo+PiAgICAgICAgICAuc2V0X2NvbmZpZyAgICAg
PSBpZmN2Zl92ZHBhX3NldF9jb25maWcsCj4+ICAgICAgICAgIC5zZXRfY29uZmlnX2NiICA9IGlm
Y3ZmX3ZkcGFfc2V0X2NvbmZpZ19jYiwKPj4gQEAgLTQzNCw3ICs0NDAsOCBAQCBzdGF0aWMgaW50
IGlmY3ZmX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBjb25zdCBzdHJ1Y3QgcGNpX2Rldmlj
ZV9pZCAqaWQpCj4+Cj4+ICAgICAgICAgIGFkYXB0ZXIgPSB2ZHBhX2FsbG9jX2RldmljZShzdHJ1
Y3QgaWZjdmZfYWRhcHRlciwgdmRwYSwKPj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIGRldiwgJmlmY192ZHBhX29wcywKPj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgSUZDVkZfTUFYX1FVRVVFX1BBSVJTICogMik7Cj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIElGQ1ZGX01BWF9RVUVVRV9QQUlSUyAqIDIsIDEpOwo+PiArCj4+
ICAgICAgICAgIGlmIChhZGFwdGVyID09IE5VTEwpIHsKPj4gICAgICAgICAgICAgICAgICBJRkNW
Rl9FUlIocGRldiwgIkZhaWxlZCB0byBhbGxvY2F0ZSB2RFBBIHN0cnVjdHVyZSIpOwo+PiAgICAg
ICAgICAgICAgICAgIHJldHVybiAtRU5PTUVNOwo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBh
L21seDUvbmV0L21seDVfdm5ldC5jIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5j
Cj4+IGluZGV4IDlkZjY5ZDVlZmU4Yy4uNGU0ODBmNGY3NTRlIDEwMDY0NAo+PiAtLS0gYS9kcml2
ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4gKysrIGIvZHJpdmVycy92ZHBhL21seDUv
bmV0L21seDVfdm5ldC5jCj4+IEBAIC0xNDI4LDYgKzE0MjgsMTEgQEAgc3RhdGljIHUzMiBtbHg1
X3ZkcGFfZ2V0X3ZxX2FsaWduKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldikKPj4gICAgICAgICAg
cmV0dXJuIFBBR0VfU0laRTsKPj4gICB9Cj4+Cj4+ICtzdGF0aWMgdTMyIG1seDVfdmRwYV9nZXRf
dnFfZ3JvdXAoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhLCB1MTYgaWR4KQo+PiArewo+PiArICAg
ICAgIHJldHVybiAwOwo+PiArfQo+PiArCj4+ICAgZW51bSB7IE1MWDVfVklSVElPX05FVF9GX0dV
RVNUX0NTVU0gPSAxIDw8IDksCj4+ICAgICAgICAgIE1MWDVfVklSVElPX05FVF9GX0NTVU0gPSAx
IDw8IDEwLAo+PiAgICAgICAgICBNTFg1X1ZJUlRJT19ORVRfRl9IT1NUX1RTTzYgPSAxIDw8IDEx
LAo+PiBAQCAtMTgzOCw2ICsxODQzLDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZp
Z19vcHMgbWx4NV92ZHBhX29wcyA9IHsKPj4gICAgICAgICAgLmdldF92cV9ub3RpZmljYXRpb24g
PSBtbHg1X2dldF92cV9ub3RpZmljYXRpb24sCj4+ICAgICAgICAgIC5nZXRfdnFfaXJxID0gbWx4
NV9nZXRfdnFfaXJxLAo+PiAgICAgICAgICAuZ2V0X3ZxX2FsaWduID0gbWx4NV92ZHBhX2dldF92
cV9hbGlnbiwKPj4gKyAgICAgICAuZ2V0X3ZxX2dyb3VwID0gbWx4NV92ZHBhX2dldF92cV9ncm91
cCwKPj4gICAgICAgICAgLmdldF9mZWF0dXJlcyA9IG1seDVfdmRwYV9nZXRfZmVhdHVyZXMsCj4+
ICAgICAgICAgIC5zZXRfZmVhdHVyZXMgPSBtbHg1X3ZkcGFfc2V0X2ZlYXR1cmVzLAo+PiAgICAg
ICAgICAuc2V0X2NvbmZpZ19jYiA9IG1seDVfdmRwYV9zZXRfY29uZmlnX2NiLAo+PiBAQCAtMTky
NSw3ICsxOTMxLDcgQEAgdm9pZCAqbWx4NV92ZHBhX2FkZF9kZXYoc3RydWN0IG1seDVfY29yZV9k
ZXYgKm1kZXYpCj4+ICAgICAgICAgIG1heF92cXMgPSBtaW5fdCh1MzIsIG1heF92cXMsIE1MWDVf
TUFYX1NVUFBPUlRFRF9WUVMpOwo+Pgo+PiAgICAgICAgICBuZGV2ID0gdmRwYV9hbGxvY19kZXZp
Y2Uoc3RydWN0IG1seDVfdmRwYV9uZXQsIG12ZGV2LnZkZXYsIG1kZXYtPmRldmljZSwgJm1seDVf
dmRwYV9vcHMsCj4+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIDIgKiBtbHg1X3Zk
cGFfbWF4X3FwcyhtYXhfdnFzKSk7Cj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IDIgKiBtbHg1X3ZkcGFfbWF4X3FwcyhtYXhfdnFzKSwgMSk7Cj4+ICAgICAgICAgIGlmIChJU19F
UlIobmRldikpCj4+ICAgICAgICAgICAgICAgICAgcmV0dXJuIG5kZXY7Cj4+Cj4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3ZkcGEvdmRwYS5jIGIvZHJpdmVycy92ZHBhL3ZkcGEuYwo+PiBpbmRleCBh
NjlmZmM5OTFlMTMuLjQ2Mzk5NzQ2ZWM3YyAxMDA2NDQKPj4gLS0tIGEvZHJpdmVycy92ZHBhL3Zk
cGEuYwo+PiArKysgYi9kcml2ZXJzL3ZkcGEvdmRwYS5jCj4+IEBAIC02Miw2ICs2Miw3IEBAIHN0
YXRpYyB2b2lkIHZkcGFfcmVsZWFzZV9kZXYoc3RydWN0IGRldmljZSAqZCkKPj4gICAgKiBAcGFy
ZW50OiB0aGUgcGFyZW50IGRldmljZQo+PiAgICAqIEBjb25maWc6IHRoZSBidXMgb3BlcmF0aW9u
cyB0aGF0IGlzIHN1cHBvcnRlZCBieSB0aGlzIGRldmljZQo+PiAgICAqIEBudnFzOiBudW1iZXIg
b2YgdmlydHF1ZXVlcyBzdXBwb3J0ZWQgYnkgdGhpcyBkZXZpY2UKPj4gKyAqIEBuZ3JvdXBzOiBu
dW1iZXIgb2YgZ3JvdXBzIHN1cHBvcnRlZCBieSB0aGlzIGRldmljZQo+IEhpIQo+Cj4gTWF5YmUg
dGhlIGRlc2NyaXB0aW9uIG9mICJuZ3JvdXBzIiBjb3VsZCBiZSAibnVtYmVyIG9mKnZpcnRxdWV1
ZSoKPiBncm91cHMgc3VwcG9ydGVkIGJ5IHRoaXMgZGV2aWNlIj8gSSB0aGluayB0aGF0IGl0IGNv
dWxkIGJlIG5lZWRlZCBpbgo+IHNvbWUgY29udGV4dHMgcmVhZGluZyB0aGUgY29kZS4KCgpFeGFj
dGx5LgoKV2lsbCBmaXguCgpUaGFua3MKCgo+Cj4gVGhhbmtzIQo+CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
