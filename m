Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 120F8C433EF
	for <virtualization@archiver.kernel.org>; Wed,  9 Feb 2022 04:44:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A5E8B41521;
	Wed,  9 Feb 2022 04:44:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ikFO-kosNALr; Wed,  9 Feb 2022 04:44:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 18D124151A;
	Wed,  9 Feb 2022 04:44:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D55BDC001A;
	Wed,  9 Feb 2022 04:44:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E4BFEC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 04:44:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B8ABF60EB2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 04:44:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id NZSAXhgwCWLy
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 04:44:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 74BF860E2A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Feb 2022 04:44:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644381893;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a8gj37MRQ8xwMURk0vAQh2NMA0eBwSyEISE9txFEN/4=;
 b=OQD73OTcwzfE9aHAz6ocTDKhHyRmXun78GnNfF823oa/s2PjeuCkjcHyMIhIFuLmrQkPX8
 grzuyQnuUDlywShenl1s//tdlU0ft3ro7TZwqlafLtcBoICkF0eMlFQ77HD8ZdrNHOLtxK
 6fMXHd6906iVWLssctxmxvBfshEo+SQ=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-522-wWNWjiZ6McSQOrgxSsfmwQ-1; Tue, 08 Feb 2022 23:44:52 -0500
X-MC-Unique: wWNWjiZ6McSQOrgxSsfmwQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 k80-20020a628453000000b004e042d3910eso951929pfd.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 08 Feb 2022 20:44:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=a8gj37MRQ8xwMURk0vAQh2NMA0eBwSyEISE9txFEN/4=;
 b=3UBvx7JpjLxCpkvlxFfHvimzRNFvVynEOdFs4Fh16Zo9txA5R1h+fmFheLvXfbW4s4
 aPI+f4MCdyRx0/7trdlchYM3oGbSjZcbxpZzNID4bGIlDxHwH+V53d+JHZhtp9R/9rhU
 I0jBHVI3neOtsArEyTGr6Dkz+uuxIIECQ6nDWeAZ+jCvr0/QAXozDCvfOnvzKqwZ1lVx
 RhEeJuo9k32efF/OlDgyW2kkblBf0mqqGR7FmFJLyvewUAc/Ru4/Eap5mLh2deP3vDQL
 DRr5Er/40Rir/twRldpq112bQPT/SCUtdmElw58BRbfCSAhHGf8gL0t8m8YK8EF/E4pq
 +P7Q==
X-Gm-Message-State: AOAM532zYl6DvJ4sNCIFTyCvP7WgcpHZyRMuAV8Qapngc71Hb07xRZ42
 uPItuS936wWRtWl46rb9pDd2DY6EmfKCpnvNf0H5OM0z9Dx5K5DtdfmlqGuxVvvlgoRIM8JQhrB
 Z3KA801eW20+yMtfxqZsmiIEpijyqeBghF9UzI6MUpA==
X-Received: by 2002:a17:90b:a06:: with SMTP id
 gg6mr1452903pjb.153.1644381891260; 
 Tue, 08 Feb 2022 20:44:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwT+QxXjlJ0SaaM0kkOKxf0X5GYo0uqNI3uLhER1MI1QJk1PxbBUXYbpF29jjDOGwJPE6rDxg==
X-Received: by 2002:a17:90b:a06:: with SMTP id
 gg6mr1452886pjb.153.1644381890996; 
 Tue, 08 Feb 2022 20:44:50 -0800 (PST)
Received: from [10.72.13.141] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id v12sm12234256pgr.68.2022.02.08.20.44.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 08 Feb 2022 20:44:50 -0800 (PST)
Message-ID: <6d74c8f6-ddf8-9258-cb99-80e0e8efbf38@redhat.com>
Date: Wed, 9 Feb 2022 12:44:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.1
Subject: Re: [RFC PATCH 5/5] drivers/net/virtio_net.c: Added USO support.
To: Andrew Melnychenko <andrew@daynix.com>, davem@davemloft.net,
 kuba@kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
References: <20220125084702.3636253-1-andrew@daynix.com>
 <20220125084702.3636253-6-andrew@daynix.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220125084702.3636253-6-andrew@daynix.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: yan@daynix.com, yuri.benditovich@daynix.com
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

CuWcqCAyMDIyLzEvMjUg5LiL5Y2INDo0NywgQW5kcmV3IE1lbG55Y2hlbmtvIOWGmemBkzoKPiBO
b3csIGl0IHBvc3NpYmxlIHRvIGVuYWJsZSBHU09fVURQX0w0KCJ0eC11ZHAtc2VnbWVudGF0aW9u
IikgZm9yIFZpcnRpb05ldC4KPgo+IFNpZ25lZC1vZmYtYnk6IEFuZHJldyBNZWxueWNoZW5rbyA8
YW5kcmV3QGRheW5peC5jb20+Cj4gLS0tCj4gICBkcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgfCAy
MiArKysrKysrKysrKysrKysrKystLS0tCj4gICAxIGZpbGUgY2hhbmdlZCwgMTggaW5zZXJ0aW9u
cygrKSwgNCBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9f
bmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBpbmRleCBhODAxZWE0MDkwOGYuLmE0
NWVlZTAyMmJlNCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiArKysg
Yi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBAQCAtNjAsMTMgKzYwLDE3IEBAIHN0YXRpYyBj
b25zdCB1bnNpZ25lZCBsb25nIGd1ZXN0X29mZmxvYWRzW10gPSB7Cj4gICAJVklSVElPX05FVF9G
X0dVRVNUX1RTTzYsCj4gICAJVklSVElPX05FVF9GX0dVRVNUX0VDTiwKPiAgIAlWSVJUSU9fTkVU
X0ZfR1VFU1RfVUZPLAo+IC0JVklSVElPX05FVF9GX0dVRVNUX0NTVU0KPiArCVZJUlRJT19ORVRf
Rl9HVUVTVF9DU1VNLAo+ICsJVklSVElPX05FVF9GX0dVRVNUX1VTTzQsCj4gKwlWSVJUSU9fTkVU
X0ZfR1VFU1RfVVNPNgo+ICAgfTsKPiAgIAo+ICAgI2RlZmluZSBHVUVTVF9PRkZMT0FEX0dST19I
V19NQVNLICgoMVVMTCA8PCBWSVJUSU9fTkVUX0ZfR1VFU1RfVFNPNCkgfCBcCj4gICAJCQkJKDFV
TEwgPDwgVklSVElPX05FVF9GX0dVRVNUX1RTTzYpIHwgXAo+ICAgCQkJCSgxVUxMIDw8IFZJUlRJ
T19ORVRfRl9HVUVTVF9FQ04pICB8IFwKPiAtCQkJCSgxVUxMIDw8IFZJUlRJT19ORVRfRl9HVUVT
VF9VRk8pKQo+ICsJCQkJKDFVTEwgPDwgVklSVElPX05FVF9GX0dVRVNUX1VGTykgIHwgXAo+ICsJ
CQkJKDFVTEwgPDwgVklSVElPX05FVF9GX0dVRVNUX1VTTzQpIHwgXAo+ICsJCQkJKDFVTEwgPDwg
VklSVElPX05FVF9GX0dVRVNUX1VTTzYpKQo+ICAgCj4gICBzdHJ1Y3QgdmlydG5ldF9zdGF0X2Rl
c2Mgewo+ICAgCWNoYXIgZGVzY1tFVEhfR1NUUklOR19MRU5dOwo+IEBAIC0yNTMwLDcgKzI1MzQs
OSBAQCBzdGF0aWMgaW50IHZpcnRuZXRfeGRwX3NldChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LCBz
dHJ1Y3QgYnBmX3Byb2cgKnByb2csCj4gICAJICAgICAgICB2aXJ0aW9faGFzX2ZlYXR1cmUodmkt
PnZkZXYsIFZJUlRJT19ORVRfRl9HVUVTVF9UU082KSB8fAo+ICAgCSAgICAgICAgdmlydGlvX2hh
c19mZWF0dXJlKHZpLT52ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfRUNOKSB8fAo+ICAgCQl2aXJ0
aW9faGFzX2ZlYXR1cmUodmktPnZkZXYsIFZJUlRJT19ORVRfRl9HVUVTVF9VRk8pIHx8Cj4gLQkJ
dmlydGlvX2hhc19mZWF0dXJlKHZpLT52ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfQ1NVTSkpKSB7
Cj4gKwkJdmlydGlvX2hhc19mZWF0dXJlKHZpLT52ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfQ1NV
TSkgfHwKPiArCQl2aXJ0aW9faGFzX2ZlYXR1cmUodmktPnZkZXYsIFZJUlRJT19ORVRfRl9HVUVT
VF9VU080KSB8fAo+ICsJCXZpcnRpb19oYXNfZmVhdHVyZSh2aS0+dmRldiwgVklSVElPX05FVF9G
X0dVRVNUX1VTTzYpKSkgewo+ICAgCQlOTF9TRVRfRVJSX01TR19NT0QoZXh0YWNrLCAiQ2FuJ3Qg
c2V0IFhEUCB3aGlsZSBob3N0IGlzIGltcGxlbWVudGluZyBHUk9fSFcvQ1NVTSwgZGlzYWJsZSBH
Uk9fSFcvQ1NVTSBmaXJzdCIpOwo+ICAgCQlyZXR1cm4gLUVPUE5PVFNVUFA7Cj4gICAJfQo+IEBA
IC0zMTU1LDYgKzMxNjEsOCBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcHJvYmUoc3RydWN0IHZpcnRp
b19kZXZpY2UgKnZkZXYpCj4gICAJCQlkZXYtPmh3X2ZlYXR1cmVzIHw9IE5FVElGX0ZfVFNPNjsK
PiAgIAkJaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfSE9TVF9FQ04p
KQo+ICAgCQkJZGV2LT5od19mZWF0dXJlcyB8PSBORVRJRl9GX1RTT19FQ047Cj4gKwkJaWYgKHZp
cnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfSE9TVF9VU08pKQo+ICsJCQlkZXYt
Pmh3X2ZlYXR1cmVzIHw9IE5FVElGX0ZfR1NPX1VEUF9MNDsKPiAgIAo+ICAgCQlkZXYtPmZlYXR1
cmVzIHw9IE5FVElGX0ZfR1NPX1JPQlVTVDsKPiAgIAo+IEBAIC0zMTY5LDYgKzMxNzcsOSBAQCBz
dGF0aWMgaW50IHZpcnRuZXRfcHJvYmUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gICAJ
CWRldi0+ZmVhdHVyZXMgfD0gTkVUSUZfRl9HUk9fSFc7Cj4gICAJaWYgKHZpcnRpb19oYXNfZmVh
dHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfQ1RSTF9HVUVTVF9PRkZMT0FEUykpCj4gICAJCWRldi0+
aHdfZmVhdHVyZXMgfD0gTkVUSUZfRl9HUk9fSFc7Cj4gKwlpZiAodmlydGlvX2hhc19mZWF0dXJl
KHZkZXYsIFZJUlRJT19ORVRfRl9HVUVTVF9VU080KSB8fAo+ICsJICAgIHZpcnRpb19oYXNfZmVh
dHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfVVNPNikpCj4gKwkJZGV2LT5od19mZWF0dXJl
cyB8PSBORVRJRl9GX0xSTzsKCgpJIHRoaW5rIHdlIG5lZWQgdG8gdXNlIEdST19IVywgc2VlIGRi
Y2YyNGQxNTM4ODQgKCJ2aXJ0aW8tbmV0OiB1c2UgCk5FVElGX0ZfR1JPX0hXIGluc3RlYWQgb2Yg
TkVUSUZfRl9MUk8iCgpUaGFua3MKCgo+ICAgCj4gICAJZGV2LT52bGFuX2ZlYXR1cmVzID0gZGV2
LT5mZWF0dXJlczsKPiAgIAo+IEBAIC0zMjAwLDcgKzMyMTEsOSBAQCBzdGF0aWMgaW50IHZpcnRu
ZXRfcHJvYmUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gICAJaWYgKHZpcnRpb19oYXNf
ZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfVFNPNCkgfHwKPiAgIAkgICAgdmlydGlv
X2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9HVUVTVF9UU082KSB8fAo+ICAgCSAgICB2
aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9GX0dVRVNUX0VDTikgfHwKPiAtCSAg
ICB2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9GX0dVRVNUX1VGTykpCj4gKwkg
ICAgdmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9HVUVTVF9VRk8pIHx8Cj4g
KwkgICAgdmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9HVUVTVF9VU080KSB8
fAo+ICsJICAgIHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfVVNP
NikpCj4gICAJCXZpLT5iaWdfcGFja2V0cyA9IHRydWU7Cj4gICAKPiAgIAlpZiAodmlydGlvX2hh
c19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9NUkdfUlhCVUYpKQo+IEBAIC0zNDAwLDYgKzM0
MTMsNyBAQCBzdGF0aWMgc3RydWN0IHZpcnRpb19kZXZpY2VfaWQgaWRfdGFibGVbXSA9IHsKPiAg
IAlWSVJUSU9fTkVUX0ZfSE9TVF9UU080LCBWSVJUSU9fTkVUX0ZfSE9TVF9VRk8sIFZJUlRJT19O
RVRfRl9IT1NUX1RTTzYsIFwKPiAgIAlWSVJUSU9fTkVUX0ZfSE9TVF9FQ04sIFZJUlRJT19ORVRf
Rl9HVUVTVF9UU080LCBWSVJUSU9fTkVUX0ZfR1VFU1RfVFNPNiwgXAo+ICAgCVZJUlRJT19ORVRf
Rl9HVUVTVF9FQ04sIFZJUlRJT19ORVRfRl9HVUVTVF9VRk8sIFwKPiArCVZJUlRJT19ORVRfRl9I
T1NUX1VTTywgVklSVElPX05FVF9GX0dVRVNUX1VTTzQsIFZJUlRJT19ORVRfRl9HVUVTVF9VU082
LCBcCj4gICAJVklSVElPX05FVF9GX01SR19SWEJVRiwgVklSVElPX05FVF9GX1NUQVRVUywgVklS
VElPX05FVF9GX0NUUkxfVlEsIFwKPiAgIAlWSVJUSU9fTkVUX0ZfQ1RSTF9SWCwgVklSVElPX05F
VF9GX0NUUkxfVkxBTiwgXAo+ICAgCVZJUlRJT19ORVRfRl9HVUVTVF9BTk5PVU5DRSwgVklSVElP
X05FVF9GX01RLCBcCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
