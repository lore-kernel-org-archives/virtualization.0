Return-Path: <SRS0=9iyF=FE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8DA89C64E7B
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 03:06:04 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1276220757
	for <virtualization@archiver.kernel.org>; Mon, 30 Nov 2020 03:06:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Qwu2pn4A"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1276220757
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 9054F214FD;
	Mon, 30 Nov 2020 03:06:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1gePmZOOPvyV; Mon, 30 Nov 2020 03:06:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id BA8ED2045D;
	Mon, 30 Nov 2020 03:06:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A51E7C0859;
	Mon, 30 Nov 2020 03:06:00 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EC072C0052
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:05:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id DA2FB863AC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:05:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id sD4haLNE2EiC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:05:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id E95308629C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 30 Nov 2020 03:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606705557;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dnsVtndyELHsaur81QLe69cRyRjj10mlyd0UTsFRal0=;
 b=Qwu2pn4AeLGLo/9HwhDzGUxroxED0dtcWVFSRCNIVDOvDgkCmUNUTIbXY/oxlyjQ18PDgZ
 r/tN6cawoXHyI3Ea1jMALDXVKPVST8mbluV+OZIgPs0iTcsKAcEv+wvT+lWhwUy4D/XFFh
 1CEi2IYWPeUM0hm/8+tdnUUvQIgKFOc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-179-W1QyoK9aODi8B7--ZvCdAA-1; Sun, 29 Nov 2020 22:05:55 -0500
X-MC-Unique: W1QyoK9aODi8B7--ZvCdAA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id ABB2B879514;
 Mon, 30 Nov 2020 03:05:54 +0000 (UTC)
Received: from [10.72.13.173] (ovpn-13-173.pek2.redhat.com [10.72.13.173])
 by smtp.corp.redhat.com (Postfix) with ESMTP id AE53460C4D;
 Mon, 30 Nov 2020 03:05:45 +0000 (UTC)
Subject: Re: [PATCH v2 03/17] vdpa_sim: remove hard-coded virtq count
To: Stefano Garzarella <sgarzare@redhat.com>,
 virtualization@lists.linux-foundation.org
References: <20201126144950.92850-1-sgarzare@redhat.com>
 <20201126144950.92850-4-sgarzare@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5e229e63-d127-a4dc-bc0a-c34a4a661cf6@redhat.com>
Date: Mon, 30 Nov 2020 11:05:44 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201126144950.92850-4-sgarzare@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>
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

Ck9uIDIwMjAvMTEvMjYg5LiL5Y2IMTA6NDksIFN0ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPiBG
cm9tOiBNYXggR3VydG92b3kgPG1ndXJ0b3ZveUBudmlkaWEuY29tPgo+Cj4gQWRkIGEgbmV3IGF0
dHJpYnV0ZSB0aGF0IHdpbGwgZGVmaW5lIHRoZSBudW1iZXIgb2YgdmlydCBxdWV1ZXMgdG8gYmUK
PiBjcmVhdGVkIGZvciB0aGUgdmRwYXNpbSBkZXZpY2UuCj4KPiBTaWduZWQtb2ZmLWJ5OiBNYXgg
R3VydG92b3kgPG1ndXJ0b3ZveUBudmlkaWEuY29tPgo+IFtzZ2FyemFyZTogcmVwbGFjZSBrbWFs
bG9jX2FycmF5KCkgd2l0aCBrY2FsbG9jKCldCj4gU2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6
YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNv
d2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4gdjE6Cj4gLSB1c2Uga2NhbGxvYygpIGluc3RlYWQg
b2Yga21hbGxvY19hcnJheSgpIHNpbmNlIHNvbWUgZnVuY3Rpb24gZXhwZWN0cwo+ICAgIHZhcmlh
YmxlcyBpbml0aWFsaXplZCB0byB6ZXJvCj4gLS0tCj4gICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0v
dmRwYV9zaW0uYyB8IDE4ICsrKysrKysrKysrKystLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDEz
IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92
ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0u
Ywo+IGluZGV4IGM2ZWFmNjJkZjhlYy4uYWQ3MmY3YjFhNGViIDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2lt
L3ZkcGFfc2ltLmMKPiBAQCAtNTcsNyArNTcsNyBAQCBzdGF0aWMgdTY0IHZkcGFzaW1fZmVhdHVy
ZXMgPSAoMVVMTCA8PCBWSVJUSU9fRl9BTllfTEFZT1VUKSB8Cj4gICAvKiBTdGF0ZSBvZiBlYWNo
IHZkcGFzaW0gZGV2aWNlICovCj4gICBzdHJ1Y3QgdmRwYXNpbSB7Cj4gICAJc3RydWN0IHZkcGFf
ZGV2aWNlIHZkcGE7Cj4gLQlzdHJ1Y3QgdmRwYXNpbV92aXJ0cXVldWUgdnFzW1ZEUEFTSU1fVlFf
TlVNXTsKPiArCXN0cnVjdCB2ZHBhc2ltX3ZpcnRxdWV1ZSAqdnFzOwo+ICAgCXN0cnVjdCB3b3Jr
X3N0cnVjdCB3b3JrOwo+ICAgCS8qIHNwaW5sb2NrIHRvIHN5bmNocm9uaXplIHZpcnRxdWV1ZSBz
dGF0ZSAqLwo+ICAgCXNwaW5sb2NrX3QgbG9jazsKPiBAQCAtNjcsNiArNjcsNyBAQCBzdHJ1Y3Qg
dmRwYXNpbSB7Cj4gICAJdTMyIHN0YXR1czsKPiAgIAl1MzIgZ2VuZXJhdGlvbjsKPiAgIAl1NjQg
ZmVhdHVyZXM7Cj4gKwlpbnQgbnZxczsKPiAgIAkvKiBzcGlubG9jayB0byBzeW5jaHJvbml6ZSBp
b21tdSB0YWJsZSAqLwo+ICAgCXNwaW5sb2NrX3QgaW9tbXVfbG9jazsKPiAgIH07Cj4gQEAgLTEz
MSw3ICsxMzIsNyBAQCBzdGF0aWMgdm9pZCB2ZHBhc2ltX3Jlc2V0KHN0cnVjdCB2ZHBhc2ltICp2
ZHBhc2ltKQo+ICAgewo+ICAgCWludCBpOwo+ICAgCj4gLQlmb3IgKGkgPSAwOyBpIDwgVkRQQVNJ
TV9WUV9OVU07IGkrKykKPiArCWZvciAoaSA9IDA7IGkgPCB2ZHBhc2ltLT5udnFzOyBpKyspCj4g
ICAJCXZkcGFzaW1fdnFfcmVzZXQoJnZkcGFzaW0tPnZxc1tpXSk7Cj4gICAKPiAgIAlzcGluX2xv
Y2soJnZkcGFzaW0tPmlvbW11X2xvY2spOwo+IEBAIC0zMzcsNyArMzM4LDcgQEAgc3RhdGljIHN0
cnVjdCB2ZHBhc2ltICp2ZHBhc2ltX2NyZWF0ZSh2b2lkKQo+ICAgCWNvbnN0IHN0cnVjdCB2ZHBh
X2NvbmZpZ19vcHMgKm9wczsKPiAgIAlzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbTsKPiAgIAlzdHJ1
Y3QgZGV2aWNlICpkZXY7Cj4gLQlpbnQgcmV0ID0gLUVOT01FTTsKPiArCWludCBpLCByZXQgPSAt
RU5PTUVNOwo+ICAgCj4gICAJaWYgKGJhdGNoX21hcHBpbmcpCj4gICAJCW9wcyA9ICZ2ZHBhc2lt
X25ldF9iYXRjaF9jb25maWdfb3BzOwo+IEBAIC0zNDgsNiArMzQ5LDcgQEAgc3RhdGljIHN0cnVj
dCB2ZHBhc2ltICp2ZHBhc2ltX2NyZWF0ZSh2b2lkKQo+ICAgCWlmICghdmRwYXNpbSkKPiAgIAkJ
Z290byBlcnJfYWxsb2M7Cj4gICAKPiArCXZkcGFzaW0tPm52cXMgPSBWRFBBU0lNX1ZRX05VTTsK
PiAgIAlJTklUX1dPUksoJnZkcGFzaW0tPndvcmssIHZkcGFzaW1fd29yayk7Cj4gICAJc3Bpbl9s
b2NrX2luaXQoJnZkcGFzaW0tPmxvY2spOwo+ICAgCXNwaW5fbG9ja19pbml0KCZ2ZHBhc2ltLT5p
b21tdV9sb2NrKTsKPiBAQCAtMzU4LDYgKzM2MCwxMSBAQCBzdGF0aWMgc3RydWN0IHZkcGFzaW0g
KnZkcGFzaW1fY3JlYXRlKHZvaWQpCj4gICAJCWdvdG8gZXJyX2lvbW11Owo+ICAgCXNldF9kbWFf
b3BzKGRldiwgJnZkcGFzaW1fZG1hX29wcyk7Cj4gICAKPiArCXZkcGFzaW0tPnZxcyA9IGtjYWxs
b2ModmRwYXNpbS0+bnZxcywgc2l6ZW9mKHN0cnVjdCB2ZHBhc2ltX3ZpcnRxdWV1ZSksCj4gKwkJ
CSAgICAgICBHRlBfS0VSTkVMKTsKPiArCWlmICghdmRwYXNpbS0+dnFzKQo+ICsJCWdvdG8gZXJy
X2lvbW11Owo+ICsKPiAgIAl2ZHBhc2ltLT5pb21tdSA9IHZob3N0X2lvdGxiX2FsbG9jKDIwNDgs
IDApOwo+ICAgCWlmICghdmRwYXNpbS0+aW9tbXUpCj4gICAJCWdvdG8gZXJyX2lvbW11Owo+IEBA
IC0zNzYsOCArMzgzLDggQEAgc3RhdGljIHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltX2NyZWF0ZSh2
b2lkKQo+ICAgCQlldGhfcmFuZG9tX2FkZHIodmRwYXNpbS0+Y29uZmlnLm1hYyk7Cj4gICAJfQo+
ICAgCj4gLQl2cmluZ2hfc2V0X2lvdGxiKCZ2ZHBhc2ltLT52cXNbMF0udnJpbmcsIHZkcGFzaW0t
PmlvbW11KTsKPiAtCXZyaW5naF9zZXRfaW90bGIoJnZkcGFzaW0tPnZxc1sxXS52cmluZywgdmRw
YXNpbS0+aW9tbXUpOwo+ICsJZm9yIChpID0gMDsgaSA8IHZkcGFzaW0tPm52cXM7IGkrKykKPiAr
CQl2cmluZ2hfc2V0X2lvdGxiKCZ2ZHBhc2ltLT52cXNbaV0udnJpbmcsIHZkcGFzaW0tPmlvbW11
KTsKPiAgIAo+ICAgCXZkcGFzaW0tPnZkcGEuZG1hX2RldiA9IGRldjsKPiAgIAlyZXQgPSB2ZHBh
X3JlZ2lzdGVyX2RldmljZSgmdmRwYXNpbS0+dmRwYSk7Cj4gQEAgLTY0Niw2ICs2NTMsNyBAQCBz
dGF0aWMgdm9pZCB2ZHBhc2ltX2ZyZWUoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhKQo+ICAgCWtm
cmVlKHZkcGFzaW0tPmJ1ZmZlcik7Cj4gICAJaWYgKHZkcGFzaW0tPmlvbW11KQo+ICAgCQl2aG9z
dF9pb3RsYl9mcmVlKHZkcGFzaW0tPmlvbW11KTsKPiArCWtmcmVlKHZkcGFzaW0tPnZxcyk7Cj4g
ICB9Cj4gICAKPiAgIHN0YXRpYyBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzIHZkcGFzaW1f
bmV0X2NvbmZpZ19vcHMgPSB7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
