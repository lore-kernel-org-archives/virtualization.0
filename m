Return-Path: <SRS0=iZVf=BO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF89AC433E1
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 08:38:44 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D11072076C
	for <virtualization@archiver.kernel.org>; Tue,  4 Aug 2020 08:38:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qwr86Xro"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D11072076C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 76DB984471;
	Tue,  4 Aug 2020 08:38:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lgxY2e4XSzG3; Tue,  4 Aug 2020 08:38:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id B099D84403;
	Tue,  4 Aug 2020 08:38:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 902C1C0051;
	Tue,  4 Aug 2020 08:38:43 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8535CC004C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 08:38:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 6AE85864F6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 08:38:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PjrHusIrPV1i
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 08:38:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-2.mimecast.com
 [207.211.31.81])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 4A64B85C98
 for <virtualization@lists.linux-foundation.org>;
 Tue,  4 Aug 2020 08:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596530318;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IHNP6heDtaeW+hWwm0uePXKP19Hfc5NyOA6m2+z2mfI=;
 b=Qwr86XroIonP4oFZw2Me9cxYBxjoxElMMNRC6sTiFjvsyn0/yK9DdchtlH9acyMQvMXxuo
 IxuJoWuDjs7txwrDlO368IhzU17vSBtVjmTeC8ZW+n28Z3KcNrLv6DIvAFhfOT1zyNyho9
 xWamwoBmpNXscYqzgdq6qe5UvW0gLM0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-119-h4MQ3iLQM9G6TTnE5NEoRQ-1; Tue, 04 Aug 2020 04:38:36 -0400
X-MC-Unique: h4MQ3iLQM9G6TTnE5NEoRQ-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com
 [10.5.11.16])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB707101C8A0;
 Tue,  4 Aug 2020 08:38:34 +0000 (UTC)
Received: from [10.72.13.197] (ovpn-13-197.pek2.redhat.com [10.72.13.197])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7167E5C3F8;
 Tue,  4 Aug 2020 08:38:21 +0000 (UTC)
Subject: Re: [PATCH V5 1/6] vhost: introduce vhost_vring_call
To: Zhu Lingshan <lingshan.zhu@intel.com>, alex.williamson@redhat.com,
 mst@redhat.com, pbonzini@redhat.com, sean.j.christopherson@intel.com,
 wanpengli@tencent.com
References: <20200731065533.4144-1-lingshan.zhu@intel.com>
 <20200731065533.4144-2-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5e646141-ca8d-77a5-6f41-d30710d91e6d@redhat.com>
Date: Tue, 4 Aug 2020 16:38:19 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200731065533.4144-2-lingshan.zhu@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Cc: shahafs@mellanox.com, parav@mellanox.com, kvm@vger.kernel.org,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eli@mellanox.com
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

Ck9uIDIwMjAvNy8zMSDkuIvljYgyOjU1LCBaaHUgTGluZ3NoYW4gd3JvdGU6Cj4gVGhpcyBjb21t
aXQgaW50cm9kdWNlcyBzdHJ1Y3Qgdmhvc3RfdnJpbmdfY2FsbCB3aGljaCByZXBsYWNlZAo+IHJh
dyBzdHJ1Y3QgZXZlbnRmZF9jdHggKmNhbGxfY3R4IGluIHN0cnVjdCB2aG9zdF92aXJ0cXVldWUu
Cj4gQmVzaWRlcyBldmVudGZkX2N0eCwgaXQgY29udGFpbnMgYSBzcGluIGxvY2sgYW5kIGFuCj4g
aXJxX2J5cGFzc19wcm9kdWNlciBpbiBpdHMgc3RydWN0dXJlLgo+Cj4gU2lnbmVkLW9mZi1ieTog
Wmh1IExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+IFN1Z2dlc3RlZC1ieTogSmFz
b24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiAtLS0KPiAgIGRyaXZlcnMvdmhvc3QvdmRw
YS5jICB8ICA0ICsrLS0KPiAgIGRyaXZlcnMvdmhvc3Qvdmhvc3QuYyB8IDIyICsrKysrKysrKysr
KysrKystLS0tLS0KPiAgIGRyaXZlcnMvdmhvc3Qvdmhvc3QuaCB8ICA5ICsrKysrKysrLQo+ICAg
MyBmaWxlcyBjaGFuZ2VkLCAyNiBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQo+Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBp
bmRleCBhNTRiNjBkNjYyM2YuLmRmM2NmMzg2YjBjZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zo
b3N0L3ZkcGEuYwo+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gQEAgLTk2LDcgKzk2LDcg
QEAgc3RhdGljIHZvaWQgaGFuZGxlX3ZxX2tpY2soc3RydWN0IHZob3N0X3dvcmsgKndvcmspCj4g
ICBzdGF0aWMgaXJxcmV0dXJuX3Qgdmhvc3RfdmRwYV92aXJ0cXVldWVfY2Iodm9pZCAqcHJpdmF0
ZSkKPiAgIHsKPiAgIAlzdHJ1Y3Qgdmhvc3RfdmlydHF1ZXVlICp2cSA9IHByaXZhdGU7Cj4gLQlz
dHJ1Y3QgZXZlbnRmZF9jdHggKmNhbGxfY3R4ID0gdnEtPmNhbGxfY3R4Owo+ICsJc3RydWN0IGV2
ZW50ZmRfY3R4ICpjYWxsX2N0eCA9IHZxLT5jYWxsX2N0eC5jdHg7Cj4gICAKPiAgIAlpZiAoY2Fs
bF9jdHgpCj4gICAJCWV2ZW50ZmRfc2lnbmFsKGNhbGxfY3R4LCAxKTsKPiBAQCAtMzgyLDcgKzM4
Miw3IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfdnJpbmdfaW9jdGwoc3RydWN0IHZob3N0X3Zk
cGEgKnYsIHVuc2lnbmVkIGludCBjbWQsCj4gICAJCWJyZWFrOwo+ICAgCj4gICAJY2FzZSBWSE9T
VF9TRVRfVlJJTkdfQ0FMTDoKPiAtCQlpZiAodnEtPmNhbGxfY3R4KSB7Cj4gKwkJaWYgKHZxLT5j
YWxsX2N0eC5jdHgpIHsKPiAgIAkJCWNiLmNhbGxiYWNrID0gdmhvc3RfdmRwYV92aXJ0cXVldWVf
Y2I7Cj4gICAJCQljYi5wcml2YXRlID0gdnE7Cj4gICAJCX0gZWxzZSB7Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmhvc3Qvdmhvc3QuYyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+IGluZGV4IGQ3
YjhkZjNlZGZmYy4uOWYxYTg0NWE5MzAyIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3Qvdmhv
c3QuYwo+ICsrKyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+IEBAIC0yOTgsNiArMjk4LDEzIEBA
IHN0YXRpYyB2b2lkIHZob3N0X3ZxX21ldGFfcmVzZXQoc3RydWN0IHZob3N0X2RldiAqZCkKPiAg
IAkJX192aG9zdF92cV9tZXRhX3Jlc2V0KGQtPnZxc1tpXSk7Cj4gICB9Cj4gICAKPiArc3RhdGlj
IHZvaWQgdmhvc3RfdnJpbmdfY2FsbF9yZXNldChzdHJ1Y3Qgdmhvc3RfdnJpbmdfY2FsbCAqY2Fs
bF9jdHgpCj4gK3sKPiArCWNhbGxfY3R4LT5jdHggPSBOVUxMOwo+ICsJbWVtc2V0KCZjYWxsX2N0
eC0+cHJvZHVjZXIsIDB4MCwgc2l6ZW9mKHN0cnVjdCBpcnFfYnlwYXNzX3Byb2R1Y2VyKSk7Cj4g
KwlzcGluX2xvY2tfaW5pdCgmY2FsbF9jdHgtPmN0eF9sb2NrKTsKPiArfQo+ICsKPiAgIHN0YXRp
YyB2b2lkIHZob3N0X3ZxX3Jlc2V0KHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKPiAgIAkJCSAgIHN0
cnVjdCB2aG9zdF92aXJ0cXVldWUgKnZxKQo+ICAgewo+IEBAIC0zMTksMTMgKzMyNiwxMyBAQCBz
dGF0aWMgdm9pZCB2aG9zdF92cV9yZXNldChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4gICAJdnEt
PmxvZ19iYXNlID0gTlVMTDsKPiAgIAl2cS0+ZXJyb3JfY3R4ID0gTlVMTDsKPiAgIAl2cS0+a2lj
ayA9IE5VTEw7Cj4gLQl2cS0+Y2FsbF9jdHggPSBOVUxMOwo+ICAgCXZxLT5sb2dfY3R4ID0gTlVM
TDsKPiAgIAl2aG9zdF9yZXNldF9pc19sZSh2cSk7Cj4gICAJdmhvc3RfZGlzYWJsZV9jcm9zc19l
bmRpYW4odnEpOwo+ICAgCXZxLT5idXN5bG9vcF90aW1lb3V0ID0gMDsKPiAgIAl2cS0+dW1lbSA9
IE5VTEw7Cj4gICAJdnEtPmlvdGxiID0gTlVMTDsKPiArCXZob3N0X3ZyaW5nX2NhbGxfcmVzZXQo
JnZxLT5jYWxsX2N0eCk7Cj4gICAJX192aG9zdF92cV9tZXRhX3Jlc2V0KHZxKTsKPiAgIH0KPiAg
IAo+IEBAIC02ODUsOCArNjkyLDggQEAgdm9pZCB2aG9zdF9kZXZfY2xlYW51cChzdHJ1Y3Qgdmhv
c3RfZGV2ICpkZXYpCj4gICAJCQlldmVudGZkX2N0eF9wdXQoZGV2LT52cXNbaV0tPmVycm9yX2N0
eCk7Cj4gICAJCWlmIChkZXYtPnZxc1tpXS0+a2ljaykKPiAgIAkJCWZwdXQoZGV2LT52cXNbaV0t
PmtpY2spOwo+IC0JCWlmIChkZXYtPnZxc1tpXS0+Y2FsbF9jdHgpCj4gLQkJCWV2ZW50ZmRfY3R4
X3B1dChkZXYtPnZxc1tpXS0+Y2FsbF9jdHgpOwo+ICsJCWlmIChkZXYtPnZxc1tpXS0+Y2FsbF9j
dHguY3R4KQo+ICsJCQlldmVudGZkX2N0eF9wdXQoZGV2LT52cXNbaV0tPmNhbGxfY3R4LmN0eCk7
Cj4gICAJCXZob3N0X3ZxX3Jlc2V0KGRldiwgZGV2LT52cXNbaV0pOwo+ICAgCX0KPiAgIAl2aG9z
dF9kZXZfZnJlZV9pb3ZlY3MoZGV2KTsKPiBAQCAtMTYyOSw3ICsxNjM2LDEwIEBAIGxvbmcgdmhv
c3RfdnJpbmdfaW9jdGwoc3RydWN0IHZob3N0X2RldiAqZCwgdW5zaWduZWQgaW50IGlvY3RsLCB2
b2lkIF9fdXNlciAqYXJnCj4gICAJCQlyID0gUFRSX0VSUihjdHgpOwo+ICAgCQkJYnJlYWs7Cj4g
ICAJCX0KPiAtCQlzd2FwKGN0eCwgdnEtPmNhbGxfY3R4KTsKPiArCj4gKwkJc3Bpbl9sb2NrKCZ2
cS0+Y2FsbF9jdHguY3R4X2xvY2spOwo+ICsJCXN3YXAoY3R4LCB2cS0+Y2FsbF9jdHguY3R4KTsK
PiArCQlzcGluX3VubG9jaygmdnEtPmNhbGxfY3R4LmN0eF9sb2NrKTsKPiAgIAkJYnJlYWs7Cj4g
ICAJY2FzZSBWSE9TVF9TRVRfVlJJTkdfRVJSOgo+ICAgCQlpZiAoY29weV9mcm9tX3VzZXIoJmYs
IGFyZ3AsIHNpemVvZiBmKSkgewo+IEBAIC0yNDQwLDggKzI0NTAsOCBAQCBzdGF0aWMgYm9vbCB2
aG9zdF9ub3RpZnkoc3RydWN0IHZob3N0X2RldiAqZGV2LCBzdHJ1Y3Qgdmhvc3RfdmlydHF1ZXVl
ICp2cSkKPiAgIHZvaWQgdmhvc3Rfc2lnbmFsKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwgc3RydWN0
IHZob3N0X3ZpcnRxdWV1ZSAqdnEpCj4gICB7Cj4gICAJLyogU2lnbmFsIHRoZSBHdWVzdCB0ZWxs
IHRoZW0gd2UgdXNlZCBzb21ldGhpbmcgdXAuICovCj4gLQlpZiAodnEtPmNhbGxfY3R4ICYmIHZo
b3N0X25vdGlmeShkZXYsIHZxKSkKPiAtCQlldmVudGZkX3NpZ25hbCh2cS0+Y2FsbF9jdHgsIDEp
Owo+ICsJaWYgKHZxLT5jYWxsX2N0eC5jdHggJiYgdmhvc3Rfbm90aWZ5KGRldiwgdnEpKQo+ICsJ
CWV2ZW50ZmRfc2lnbmFsKHZxLT5jYWxsX2N0eC5jdHgsIDEpOwo+ICAgfQo+ICAgRVhQT1JUX1NZ
TUJPTF9HUEwodmhvc3Rfc2lnbmFsKTsKPiAgIAo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0
L3Zob3N0LmggYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmgKPiBpbmRleCBjOGU5NmEwOTVkM2IuLjM4
ZWIxYWEzYjY4ZCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmgKPiArKysgYi9k
cml2ZXJzL3Zob3N0L3Zob3N0LmgKPiBAQCAtMTMsNiArMTMsNyBAQAo+ICAgI2luY2x1ZGUgPGxp
bnV4L3ZpcnRpb19yaW5nLmg+Cj4gICAjaW5jbHVkZSA8bGludXgvYXRvbWljLmg+Cj4gICAjaW5j
bHVkZSA8bGludXgvdmhvc3RfaW90bGIuaD4KPiArI2luY2x1ZGUgPGxpbnV4L2lycWJ5cGFzcy5o
Pgo+ICAgCj4gICBzdHJ1Y3Qgdmhvc3Rfd29yazsKPiAgIHR5cGVkZWYgdm9pZCAoKnZob3N0X3dv
cmtfZm5fdCkoc3RydWN0IHZob3N0X3dvcmsgKndvcmspOwo+IEBAIC02MCw2ICs2MSwxMiBAQCBl
bnVtIHZob3N0X3VhZGRyX3R5cGUgewo+ICAgCVZIT1NUX05VTV9BRERSUyA9IDMsCj4gICB9Owo+
ICAgCj4gK3N0cnVjdCB2aG9zdF92cmluZ19jYWxsIHsKPiArCXN0cnVjdCBldmVudGZkX2N0eCAq
Y3R4Owo+ICsJc3RydWN0IGlycV9ieXBhc3NfcHJvZHVjZXIgcHJvZHVjZXI7Cj4gKwlzcGlubG9j
a190IGN0eF9sb2NrOwoKCkl0J3Mgbm90IGNsZWFyIHRvIG1lIHdoeSB3ZSBuZWVkIGN0eF9sb2Nr
IGhlcmUuCgpUaGFua3MKCgo+ICt9Owo+ICsKPiAgIC8qIFRoZSB2aXJ0cXVldWUgc3RydWN0dXJl
IGRlc2NyaWJlcyBhIHF1ZXVlIGF0dGFjaGVkIHRvIGEgZGV2aWNlLiAqLwo+ICAgc3RydWN0IHZo
b3N0X3ZpcnRxdWV1ZSB7Cj4gICAJc3RydWN0IHZob3N0X2RldiAqZGV2Owo+IEBAIC03Miw3ICs3
OSw3IEBAIHN0cnVjdCB2aG9zdF92aXJ0cXVldWUgewo+ICAgCXZyaW5nX3VzZWRfdCBfX3VzZXIg
KnVzZWQ7Cj4gICAJY29uc3Qgc3RydWN0IHZob3N0X2lvdGxiX21hcCAqbWV0YV9pb3RsYltWSE9T
VF9OVU1fQUREUlNdOwo+ICAgCXN0cnVjdCBmaWxlICpraWNrOwo+IC0Jc3RydWN0IGV2ZW50ZmRf
Y3R4ICpjYWxsX2N0eDsKPiArCXN0cnVjdCB2aG9zdF92cmluZ19jYWxsIGNhbGxfY3R4Owo+ICAg
CXN0cnVjdCBldmVudGZkX2N0eCAqZXJyb3JfY3R4Owo+ICAgCXN0cnVjdCBldmVudGZkX2N0eCAq
bG9nX2N0eDsKPiAgIAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
