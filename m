Return-Path: <SRS0=pGqY=CS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8B6BC433E2
	for <virtualization@archiver.kernel.org>; Wed,  9 Sep 2020 09:05:06 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5F259206C9
	for <virtualization@archiver.kernel.org>; Wed,  9 Sep 2020 09:05:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cBJMIE+k"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5F259206C9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id E62BA86C19;
	Wed,  9 Sep 2020 09:05:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id GNYqgfRC_Ua4; Wed,  9 Sep 2020 09:05:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0B05886FC3;
	Wed,  9 Sep 2020 09:05:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CD3BCC0859;
	Wed,  9 Sep 2020 09:05:02 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3D38CC0051
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 09:05:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 09B772E114
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 09:05:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CXF6iZIpIzgO
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 09:05:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by silver.osuosl.org (Postfix) with ESMTPS id D918F272BB
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Sep 2020 09:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1599642298;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hF5FRl4+JcryV02oF186NMbYpd31+bm49DOKtjwi4hY=;
 b=cBJMIE+k+INH7ExziNhm1ocLK1jqLEiTpXz58pLKNRBSSxk3aqXFy+bDXJIIR9I38vqp7h
 Ld0fR5/Z37od8V6jVnZP0WFIDzt9m8R6Z/nF1Ts3EvXo1p2H0Bi+q/3ixnHAFJ8YBAQpMB
 r/oemdDQZlM2pbYLsg34A6d4z6kmXGs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-S9pHHcnKP2GaTHqVUgeIEg-1; Wed, 09 Sep 2020 05:04:56 -0400
X-MC-Unique: S9pHHcnKP2GaTHqVUgeIEg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CD4A21DDFF;
 Wed,  9 Sep 2020 09:04:55 +0000 (UTC)
Received: from [10.72.12.24] (ovpn-12-24.pek2.redhat.com [10.72.12.24])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE09946;
 Wed,  9 Sep 2020 09:04:47 +0000 (UTC)
Subject: Re: [PATCH] vhost_vdpa: remove unnecessary spin_lock in
 vhost_vring_call
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com
References: <20200909065234.3313-1-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <a7035d50-04e4-714a-e4aa-03872b939827@redhat.com>
Date: Wed, 9 Sep 2020 17:04:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200909065234.3313-1-lingshan.zhu@intel.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ck9uIDIwMjAvOS85IOS4i+WNiDI6NTIsIFpodSBMaW5nc2hhbiB3cm90ZToKPiBUaGlzIGNvbW1p
dCByZW1vdmVkIHVubmVjZXNzYXJ5IHNwaW5fbG9ja3MgaW4gdmhvc3RfdnJpbmdfY2FsbAo+IGFu
ZCByZWxhdGVkIG9wZXJhdGlvbnMuIEJlY2F1c2Ugd2UgbWFuaXB1bGF0ZSBpcnEgb2ZmbG9hZGlu
Zwo+IGNvbnRlbnRzIGluIHZob3N0X3ZkcGEgaW9jdGwgY29kZSBwYXRoIHdoaWNoIGlzIGFscmVh
ZHkKPiBwcm90ZWN0ZWQgYnkgZGV2IG11dGV4IGFuZCB2cSBtdXRleC4KPgo+IFNpZ25lZC1vZmYt
Ynk6IFpodSBMaW5nc2hhbiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4KCgpBY2tlZC1ieTogSmFz
b24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy92aG9zdC92
ZHBhLmMgIHwgOCArLS0tLS0tLQo+ICAgZHJpdmVycy92aG9zdC92aG9zdC5jIHwgMyAtLS0KPiAg
IGRyaXZlcnMvdmhvc3Qvdmhvc3QuaCB8IDEgLQo+ICAgMyBmaWxlcyBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMTEgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92
ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+IGluZGV4IDNmYWI5NGY4ODg5NC4uYmM2Nzlk
MGI3Yjg3IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gKysrIGIvZHJpdmVy
cy92aG9zdC92ZHBhLmMKPiBAQCAtOTcsMjYgKzk3LDIwIEBAIHN0YXRpYyB2b2lkIHZob3N0X3Zk
cGFfc2V0dXBfdnFfaXJxKHN0cnVjdCB2aG9zdF92ZHBhICp2LCB1MTYgcWlkKQo+ICAgCQlyZXR1
cm47Cj4gICAKPiAgIAlpcnEgPSBvcHMtPmdldF92cV9pcnEodmRwYSwgcWlkKTsKPiAtCXNwaW5f
bG9jaygmdnEtPmNhbGxfY3R4LmN0eF9sb2NrKTsKPiAgIAlpcnFfYnlwYXNzX3VucmVnaXN0ZXJf
cHJvZHVjZXIoJnZxLT5jYWxsX2N0eC5wcm9kdWNlcik7Cj4gLQlpZiAoIXZxLT5jYWxsX2N0eC5j
dHggfHwgaXJxIDwgMCkgewo+IC0JCXNwaW5fdW5sb2NrKCZ2cS0+Y2FsbF9jdHguY3R4X2xvY2sp
Owo+ICsJaWYgKCF2cS0+Y2FsbF9jdHguY3R4IHx8IGlycSA8IDApCj4gICAJCXJldHVybjsKPiAt
CX0KPiAgIAo+ICAgCXZxLT5jYWxsX2N0eC5wcm9kdWNlci50b2tlbiA9IHZxLT5jYWxsX2N0eC5j
dHg7Cj4gICAJdnEtPmNhbGxfY3R4LnByb2R1Y2VyLmlycSA9IGlycTsKPiAgIAlyZXQgPSBpcnFf
YnlwYXNzX3JlZ2lzdGVyX3Byb2R1Y2VyKCZ2cS0+Y2FsbF9jdHgucHJvZHVjZXIpOwo+IC0Jc3Bp
bl91bmxvY2soJnZxLT5jYWxsX2N0eC5jdHhfbG9jayk7Cj4gICB9Cj4gICAKPiAgIHN0YXRpYyB2
b2lkIHZob3N0X3ZkcGFfdW5zZXR1cF92cV9pcnEoc3RydWN0IHZob3N0X3ZkcGEgKnYsIHUxNiBx
aWQpCj4gICB7Cj4gICAJc3RydWN0IHZob3N0X3ZpcnRxdWV1ZSAqdnEgPSAmdi0+dnFzW3FpZF07
Cj4gICAKPiAtCXNwaW5fbG9jaygmdnEtPmNhbGxfY3R4LmN0eF9sb2NrKTsKPiAgIAlpcnFfYnlw
YXNzX3VucmVnaXN0ZXJfcHJvZHVjZXIoJnZxLT5jYWxsX2N0eC5wcm9kdWNlcik7Cj4gLQlzcGlu
X3VubG9jaygmdnEtPmNhbGxfY3R4LmN0eF9sb2NrKTsKPiAgIH0KPiAgIAo+ICAgc3RhdGljIHZv
aWQgdmhvc3RfdmRwYV9yZXNldChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdikKPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy92aG9zdC92aG9zdC5jIGIvZHJpdmVycy92aG9zdC92aG9zdC5jCj4gaW5kZXggYjQ1
NTE5Y2E2NmE3Li45OWYyN2NlOTgyZGEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9zdC92aG9z
dC5jCj4gKysrIGIvZHJpdmVycy92aG9zdC92aG9zdC5jCj4gQEAgLTMwMiw3ICszMDIsNiBAQCBz
dGF0aWMgdm9pZCB2aG9zdF92cmluZ19jYWxsX3Jlc2V0KHN0cnVjdCB2aG9zdF92cmluZ19jYWxs
ICpjYWxsX2N0eCkKPiAgIHsKPiAgIAljYWxsX2N0eC0+Y3R4ID0gTlVMTDsKPiAgIAltZW1zZXQo
JmNhbGxfY3R4LT5wcm9kdWNlciwgMHgwLCBzaXplb2Yoc3RydWN0IGlycV9ieXBhc3NfcHJvZHVj
ZXIpKTsKPiAtCXNwaW5fbG9ja19pbml0KCZjYWxsX2N0eC0+Y3R4X2xvY2spOwo+ICAgfQo+ICAg
Cj4gICBzdGF0aWMgdm9pZCB2aG9zdF92cV9yZXNldChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4g
QEAgLTE2MzcsOSArMTYzNiw3IEBAIGxvbmcgdmhvc3RfdnJpbmdfaW9jdGwoc3RydWN0IHZob3N0
X2RldiAqZCwgdW5zaWduZWQgaW50IGlvY3RsLCB2b2lkIF9fdXNlciAqYXJnCj4gICAJCQlicmVh
azsKPiAgIAkJfQo+ICAgCj4gLQkJc3Bpbl9sb2NrKCZ2cS0+Y2FsbF9jdHguY3R4X2xvY2spOwo+
ICAgCQlzd2FwKGN0eCwgdnEtPmNhbGxfY3R4LmN0eCk7Cj4gLQkJc3Bpbl91bmxvY2soJnZxLT5j
YWxsX2N0eC5jdHhfbG9jayk7Cj4gICAJCWJyZWFrOwo+ICAgCWNhc2UgVkhPU1RfU0VUX1ZSSU5H
X0VSUjoKPiAgIAkJaWYgKGNvcHlfZnJvbV91c2VyKCZmLCBhcmdwLCBzaXplb2YgZikpIHsKPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92aG9zdC5oIGIvZHJpdmVycy92aG9zdC92aG9zdC5o
Cj4gaW5kZXggOTAzMmQzYzJhOWY0Li40ODZkY2YzNzFlMDYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVy
cy92aG9zdC92aG9zdC5oCj4gKysrIGIvZHJpdmVycy92aG9zdC92aG9zdC5oCj4gQEAgLTY0LDcg
KzY0LDYgQEAgZW51bSB2aG9zdF91YWRkcl90eXBlIHsKPiAgIHN0cnVjdCB2aG9zdF92cmluZ19j
YWxsIHsKPiAgIAlzdHJ1Y3QgZXZlbnRmZF9jdHggKmN0eDsKPiAgIAlzdHJ1Y3QgaXJxX2J5cGFz
c19wcm9kdWNlciBwcm9kdWNlcjsKPiAtCXNwaW5sb2NrX3QgY3R4X2xvY2s7Cj4gICB9Owo+ICAg
Cj4gICAvKiBUaGUgdmlydHF1ZXVlIHN0cnVjdHVyZSBkZXNjcmliZXMgYSBxdWV1ZSBhdHRhY2hl
ZCB0byBhIGRldmljZS4gKi8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
