Return-Path: <SRS0=2X6m=EE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38830C5517A
	for <virtualization@archiver.kernel.org>; Thu, 29 Oct 2020 07:39:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6B3B0218AC
	for <virtualization@archiver.kernel.org>; Thu, 29 Oct 2020 07:39:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JYNQ5cjR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 6B3B0218AC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DF7CA86925;
	Thu, 29 Oct 2020 07:39:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7xI4rCxhXZKp; Thu, 29 Oct 2020 07:39:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DA71585FAE;
	Thu, 29 Oct 2020 07:39:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 94600C088B;
	Thu, 29 Oct 2020 07:39:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B0F8FC0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 07:39:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id AD7BB868F0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 07:39:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3lcsrlWUStPX
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 07:39:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 7D7F486822
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Oct 2020 07:39:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603957175;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=vSXtkgaVTp0TVhMVC3oRaL4cKku7QCQcFRCq6q/d8Wk=;
 b=JYNQ5cjRrqlRLkEpAgBTTvjxrYJQfOEc8hGnDxMeUamSkosVbR/61XLwR7es6PSmmdqotq
 aSBAypdByTDHQiajcDRvF6tkOeOQRlUcOotHWS+nqeO3Ad8XRx9nmo0q7oHUfZTfn+z0Wc
 onjI2bfG3M8TtSb3VmvJYmUwdlgUSCM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-KZqfB9rXNRCslrUL2DKyTw-1; Thu, 29 Oct 2020 03:39:33 -0400
X-MC-Unique: KZqfB9rXNRCslrUL2DKyTw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BF79487311B;
 Thu, 29 Oct 2020 07:39:31 +0000 (UTC)
Received: from [10.72.12.209] (ovpn-12-209.pek2.redhat.com [10.72.12.209])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 586045D9EF;
 Thu, 29 Oct 2020 07:39:26 +0000 (UTC)
Subject: Re: [PATCH] vhost: Use mutex to protect vq_irq setup
To: Eli Cohen <elic@nvidia.com>
References: <20201028142004.GA100353@mtl-vdi-166.wap.labs.mlnx>
 <60e24a0e-0d72-51b3-216a-b3cf62fb1a58@redhat.com>
 <20201029073717.GA132479@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7b92d057-75cc-8bee-6354-2fbefcd1850a@redhat.com>
Date: Thu, 29 Oct 2020 15:39:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029073717.GA132479@mtl-vdi-166.wap.labs.mlnx>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: netdev <netdev@vger.kernel.org>, lingshan.zhu@intel.com,
 virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

Ck9uIDIwMjAvMTAvMjkg5LiL5Y2IMzozNywgRWxpIENvaGVuIHdyb3RlOgo+IE9uIFRodSwgT2N0
IDI5LCAyMDIwIGF0IDAzOjAzOjI0UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+IE9uIDIw
MjAvMTAvMjgg5LiL5Y2IMTA6MjAsIEVsaSBDb2hlbiB3cm90ZToKPj4+IEJvdGggaXJxX2J5cGFz
c19yZWdpc3Rlcl9wcm9kdWNlcigpIGFuZCBpcnFfYnlwYXNzX3VucmVnaXN0ZXJfcHJvZHVjZXIo
KQo+Pj4gcmVxdWlyZSBwcm9jZXNzIGNvbnRleHQgdG8gcnVuLiBDaGFuZ2UgdGhlIGNhbGwgY29u
dGV4dCBsb2NrIGZyb20KPj4+IHNwaW5sb2NrIHRvIG11dGV4IHRvIHByb3RlY3QgdGhlIHNldHVw
IHByb2Nlc3MgdG8gYXZvaWQgZGVhZGxvY2tzLgo+Pj4KPj4+IEZpeGVzOiAyNjVhMGFkODczMWQg
KCJ2aG9zdDogaW50cm9kdWNlIHZob3N0X3ZyaW5nX2NhbGwiKQo+Pj4gU2lnbmVkLW9mZi1ieTog
RWxpIENvaGVuIDxlbGljQG52aWRpYS5jb20+Cj4+Cj4+IEhpIEVsaToKPj4KPj4gRHVyaW5nIHJl
dmlldyB3ZSBzcG90IHRoYXQgdGhlIHNwaW5sb2NrIGlzIG5vdCBuZWNlc3NhcnkuIEFuZCBpdCB3
YXMgYWxyZWFkeQo+PiBwcm90ZWN0ZWQgYnkgdnEgbXV0ZXguIFNvIGl0IHdhcyByZW1vdmVkIGlu
IHRoaXMgY29tbWl0Ogo+Pgo+PiBodHRwczovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20vbGludXgv
a2VybmVsL2dpdC90b3J2YWxkcy9saW51eC5naXQvY29tbWl0Lz9pZD04NmUxODJmZTEyZWU1ODY5
MDIyNjE0NDU3MDM3MDk3YzcwZmUyZWQxCj4+Cj4+IFRoYW5rcwo+Pgo+IEkgc2VlLCB0aGFua3Mu
Cj4KPiBCVFcsIHdoaWxlIHRlc3RpbmcgaXJxIGJ5cGFzc2luZywgSSBub3RpY2VkIHRoYXQgcWVt
dSBzdGFydGVkIGNyYXNoaW5nCj4gYW5kIEkgZmFpbCB0byBib290IHRoZSBWTT8gSXMgdGhhdCBh
IGtub3duIGlzc3VlLiBJIGNoZWNrZWQgdXNpbmcKPiB1cGRhdGVkIG1hc3RlciBicmFuY2ggb2Yg
cWVtdSB1cGRhdGVkIHllc3RlcmRheS4KCgpOb3Qga25vd24geWV0LgoKCj4KPiBBbnkgaWRlYXMg
aG93IHRvIGNoZWNrIHRoaXMgZnVydGhlcj8KCgpJIHdvdWxkIGJlIGhlbHBmdWwgaWYgeW91IGNh
biBwYXN0ZSB0aGUgY2FsbHRyYWNlIGhlcmUuCgoKPiBEaWQgYW55b25lIGFjdHVhbGx5IGNoZWNr
IHRoYXQgaXJxIGJ5cGFzc2luZyB3b3Jrcz8KCgpZZXMsIExpbmcgU2hhbiB0ZXN0ZWQgaXQgdmlh
IElGQ1ZGIGRyaXZlci4KClRoYW5rcwoKCj4KPj4+IC0tLQo+Pj4gICAgZHJpdmVycy92aG9zdC92
ZHBhLmMgIHwgMTAgKysrKystLS0tLQo+Pj4gICAgZHJpdmVycy92aG9zdC92aG9zdC5jIHwgIDYg
KysrLS0tCj4+PiAgICBkcml2ZXJzL3Zob3N0L3Zob3N0LmggfCAgMyArKy0KPj4+ICAgIDMgZmls
ZXMgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgOSBkZWxldGlvbnMoLSkKPj4+Cj4+PiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4g
aW5kZXggYmU3ODM1OTJmZTU4Li4wYTc0NGYyYjZlNzYgMTAwNjQ0Cj4+PiAtLS0gYS9kcml2ZXJz
L3Zob3N0L3ZkcGEuYwo+Pj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4+IEBAIC05OCwy
NiArOTgsMjYgQEAgc3RhdGljIHZvaWQgdmhvc3RfdmRwYV9zZXR1cF92cV9pcnEoc3RydWN0IHZo
b3N0X3ZkcGEgKnYsIHUxNiBxaWQpCj4+PiAgICAJCXJldHVybjsKPj4+ICAgIAlpcnEgPSBvcHMt
PmdldF92cV9pcnEodmRwYSwgcWlkKTsKPj4+IC0Jc3Bpbl9sb2NrKCZ2cS0+Y2FsbF9jdHguY3R4
X2xvY2spOwo+Pj4gKwltdXRleF9sb2NrKCZ2cS0+Y2FsbF9jdHguY3R4X2xvY2spOwo+Pj4gICAg
CWlycV9ieXBhc3NfdW5yZWdpc3Rlcl9wcm9kdWNlcigmdnEtPmNhbGxfY3R4LnByb2R1Y2VyKTsK
Pj4+ICAgIAlpZiAoIXZxLT5jYWxsX2N0eC5jdHggfHwgaXJxIDwgMCkgewo+Pj4gLQkJc3Bpbl91
bmxvY2soJnZxLT5jYWxsX2N0eC5jdHhfbG9jayk7Cj4+PiArCQltdXRleF91bmxvY2soJnZxLT5j
YWxsX2N0eC5jdHhfbG9jayk7Cj4+PiAgICAJCXJldHVybjsKPj4+ICAgIAl9Cj4+PiAgICAJdnEt
PmNhbGxfY3R4LnByb2R1Y2VyLnRva2VuID0gdnEtPmNhbGxfY3R4LmN0eDsKPj4+ICAgIAl2cS0+
Y2FsbF9jdHgucHJvZHVjZXIuaXJxID0gaXJxOwo+Pj4gICAgCXJldCA9IGlycV9ieXBhc3NfcmVn
aXN0ZXJfcHJvZHVjZXIoJnZxLT5jYWxsX2N0eC5wcm9kdWNlcik7Cj4+PiAtCXNwaW5fdW5sb2Nr
KCZ2cS0+Y2FsbF9jdHguY3R4X2xvY2spOwo+Pj4gKwltdXRleF91bmxvY2soJnZxLT5jYWxsX2N0
eC5jdHhfbG9jayk7Cj4+PiAgICB9Cj4+PiAgICBzdGF0aWMgdm9pZCB2aG9zdF92ZHBhX3Vuc2V0
dXBfdnFfaXJxKHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1MTYgcWlkKQo+Pj4gICAgewo+Pj4gICAg
CXN0cnVjdCB2aG9zdF92aXJ0cXVldWUgKnZxID0gJnYtPnZxc1txaWRdOwo+Pj4gLQlzcGluX2xv
Y2soJnZxLT5jYWxsX2N0eC5jdHhfbG9jayk7Cj4+PiArCW11dGV4X2xvY2soJnZxLT5jYWxsX2N0
eC5jdHhfbG9jayk7Cj4+PiAgICAJaXJxX2J5cGFzc191bnJlZ2lzdGVyX3Byb2R1Y2VyKCZ2cS0+
Y2FsbF9jdHgucHJvZHVjZXIpOwo+Pj4gLQlzcGluX3VubG9jaygmdnEtPmNhbGxfY3R4LmN0eF9s
b2NrKTsKPj4+ICsJbXV0ZXhfdW5sb2NrKCZ2cS0+Y2FsbF9jdHguY3R4X2xvY2spOwo+Pj4gICAg
fQo+Pj4gICAgc3RhdGljIHZvaWQgdmhvc3RfdmRwYV9yZXNldChzdHJ1Y3Qgdmhvc3RfdmRwYSAq
dikKPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMgYi9kcml2ZXJzL3Zob3N0
L3Zob3N0LmMKPj4+IGluZGV4IDlhZDQ1ZTFkMjdmMC4uOTM4MjM5ZTExNDU1IDEwMDY0NAo+Pj4g
LS0tIGEvZHJpdmVycy92aG9zdC92aG9zdC5jCj4+PiArKysgYi9kcml2ZXJzL3Zob3N0L3Zob3N0
LmMKPj4+IEBAIC0zMDIsNyArMzAyLDcgQEAgc3RhdGljIHZvaWQgdmhvc3RfdnJpbmdfY2FsbF9y
ZXNldChzdHJ1Y3Qgdmhvc3RfdnJpbmdfY2FsbCAqY2FsbF9jdHgpCj4+PiAgICB7Cj4+PiAgICAJ
Y2FsbF9jdHgtPmN0eCA9IE5VTEw7Cj4+PiAgICAJbWVtc2V0KCZjYWxsX2N0eC0+cHJvZHVjZXIs
IDB4MCwgc2l6ZW9mKHN0cnVjdCBpcnFfYnlwYXNzX3Byb2R1Y2VyKSk7Cj4+PiAtCXNwaW5fbG9j
a19pbml0KCZjYWxsX2N0eC0+Y3R4X2xvY2spOwo+Pj4gKwltdXRleF9pbml0KCZjYWxsX2N0eC0+
Y3R4X2xvY2spOwo+Pj4gICAgfQo+Pj4gICAgc3RhdGljIHZvaWQgdmhvc3RfdnFfcmVzZXQoc3Ry
dWN0IHZob3N0X2RldiAqZGV2LAo+Pj4gQEAgLTE2NTAsOSArMTY1MCw5IEBAIGxvbmcgdmhvc3Rf
dnJpbmdfaW9jdGwoc3RydWN0IHZob3N0X2RldiAqZCwgdW5zaWduZWQgaW50IGlvY3RsLCB2b2lk
IF9fdXNlciAqYXJnCj4+PiAgICAJCQlicmVhazsKPj4+ICAgIAkJfQo+Pj4gLQkJc3Bpbl9sb2Nr
KCZ2cS0+Y2FsbF9jdHguY3R4X2xvY2spOwo+Pj4gKwkJbXV0ZXhfbG9jaygmdnEtPmNhbGxfY3R4
LmN0eF9sb2NrKTsKPj4+ICAgIAkJc3dhcChjdHgsIHZxLT5jYWxsX2N0eC5jdHgpOwo+Pj4gLQkJ
c3Bpbl91bmxvY2soJnZxLT5jYWxsX2N0eC5jdHhfbG9jayk7Cj4+PiArCQltdXRleF91bmxvY2so
JnZxLT5jYWxsX2N0eC5jdHhfbG9jayk7Cj4+PiAgICAJCWJyZWFrOwo+Pj4gICAgCWNhc2UgVkhP
U1RfU0VUX1ZSSU5HX0VSUjoKPj4+ICAgIAkJaWYgKGNvcHlfZnJvbV91c2VyKCZmLCBhcmdwLCBz
aXplb2YgZikpIHsKPj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmggYi9kcml2
ZXJzL3Zob3N0L3Zob3N0LmgKPj4+IGluZGV4IDkwMzJkM2MyYTlmNC4uZTg4NTVlYTA0MjA1IDEw
MDY0NAo+Pj4gLS0tIGEvZHJpdmVycy92aG9zdC92aG9zdC5oCj4+PiArKysgYi9kcml2ZXJzL3Zo
b3N0L3Zob3N0LmgKPj4+IEBAIC02NCw3ICs2NCw4IEBAIGVudW0gdmhvc3RfdWFkZHJfdHlwZSB7
Cj4+PiAgICBzdHJ1Y3Qgdmhvc3RfdnJpbmdfY2FsbCB7Cj4+PiAgICAJc3RydWN0IGV2ZW50ZmRf
Y3R4ICpjdHg7Cj4+PiAgICAJc3RydWN0IGlycV9ieXBhc3NfcHJvZHVjZXIgcHJvZHVjZXI7Cj4+
PiAtCXNwaW5sb2NrX3QgY3R4X2xvY2s7Cj4+PiArCS8qIHByb3RlY3QgdnEgaXJxIHNldHVwICov
Cj4+PiArCXN0cnVjdCBtdXRleCBjdHhfbG9jazsKPj4+ICAgIH07Cj4+PiAgICAvKiBUaGUgdmly
dHF1ZXVlIHN0cnVjdHVyZSBkZXNjcmliZXMgYSBxdWV1ZSBhdHRhY2hlZCB0byBhIGRldmljZS4g
Ki8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
