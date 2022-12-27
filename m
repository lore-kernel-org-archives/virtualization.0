Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FDF8C10F1B
	for <virtualization@archiver.kernel.org>; Tue, 27 Dec 2022 09:09:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id D02C380BB5;
	Tue, 27 Dec 2022 09:09:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D02C380BB5
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=A28xMfkV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id j5Yorzgu4IIB; Tue, 27 Dec 2022 09:09:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 21CA980B54;
	Tue, 27 Dec 2022 09:09:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 21CA980B54
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F1D35C0032;
	Tue, 27 Dec 2022 09:09:28 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D7CACC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 09:09:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ABF504018E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 09:09:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ABF504018E
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=A28xMfkV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Nb40LbTprPha
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 09:09:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A66914017B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id A66914017B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 09:09:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672132165;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZSradRKv8X4tppTdp+nyd/8jKoHTyaIYm93jfzfVBMs=;
 b=A28xMfkVVq5B4rHXcRGIpcPW2rJ+K6Ly1P3zWuK26DBY/r+z6D0tCrhyRTK8caEBJev4C0
 dRCcGhVMfoo1gFL6mIrl7VvxKOPeHDPUVynNNXhn/2YIs/MQuKyceMs83kgSdaR1ZtKY3/
 9ad6EkCCX+bcgrnaWNS7J7Ksjy3Sawk=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-15-_US6KpTEOomtJL2M1oKmhw-1; Tue, 27 Dec 2022 04:09:22 -0500
X-MC-Unique: _US6KpTEOomtJL2M1oKmhw-1
Received: by mail-pf1-f199.google.com with SMTP id
 b13-20020a056a000a8d00b0057348c50123so6758045pfl.18
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Dec 2022 01:09:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=ZSradRKv8X4tppTdp+nyd/8jKoHTyaIYm93jfzfVBMs=;
 b=GIYaMsLTA04OOcGnJgJ0nxfRFbQYoBo0DDYwehg0VLFj40GcJab3Ya5iiW5T7SmCKV
 SBhHXibheg28WligGj1MVbHf87w9NozqiEbEKkZs7/B3toCQpevDXtO2ZIO+CIoBy8pd
 dd2mv2LgrAWB1RaZF4cHdLbQqEaP/695lLtvWNF7kQKF9DBedTUR1zvHPZnMhgcSPvxz
 uu09CgNrlQRqHzaQz09df0H3WBoGwqIbWeB4UYzxqSKCCuvKO6E8NlcyjwNbXdJDkxT4
 vPlFLWFzgqtS872zjLKJl58qLqrRXhkznr2E4dcWRGys/8UUujRvCHfNq12pGt6qxZdy
 6bcg==
X-Gm-Message-State: AFqh2kr2zITCN/bm5Y4krtKj0XiobIJx2i6/ZTuqFvrtvqBumm8RcLYl
 gD0kccoNfK2271T1sVGH7Ls02mRHwwrKesG+xhWw8e/bMoqn4P5JxVKPz13cdcOHvHX3hvi+VRy
 OJwQyfZKCQI7XtMrFwrnWGlm2jTjiAADy8UwAlc8REQ==
X-Received: by 2002:a05:6a21:9990:b0:a6:f26b:558 with SMTP id
 ve16-20020a056a21999000b000a6f26b0558mr34620496pzb.16.1672132160884; 
 Tue, 27 Dec 2022 01:09:20 -0800 (PST)
X-Google-Smtp-Source: AMrXdXujkKWu8TaIx5QDj+Ms6FxKWfhgvgCot/DHhIN7/4Mzjd1pf+hfvZSKMRrWnDv9cpyYdI8/KA==
X-Received: by 2002:a05:6a21:9990:b0:a6:f26b:558 with SMTP id
 ve16-20020a056a21999000b000a6f26b0558mr34620466pzb.16.1672132160560; 
 Tue, 27 Dec 2022 01:09:20 -0800 (PST)
Received: from [10.72.13.143] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 p188-20020a625bc5000000b00580fe3b958esm4044388pfb.131.2022.12.27.01.09.17
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 27 Dec 2022 01:09:20 -0800 (PST)
Message-ID: <0abaec22-ec5f-9136-b043-0989d97b209f@redhat.com>
Date: Tue, 27 Dec 2022 17:09:12 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 3/4] virtio_ring: introduce a per virtqueue waitqueue
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20221226074908.8154-1-jasowang@redhat.com>
 <20221226074908.8154-4-jasowang@redhat.com>
 <20221226183348-mutt-send-email-mst@kernel.org>
 <CACGkMEsJYn=4mC-+QKnkHi+zjZsRL+m+mdyuLemPhsZDi_hcEw@mail.gmail.com>
 <20221227020901-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20221227020901-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, maxime.coquelin@redhat.com, kuba@kernel.org,
 pabeni@redhat.com, davem@davemloft.net
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

CuWcqCAyMDIyLzEyLzI3IDE1OjE5LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+IE9uIFR1
ZSwgRGVjIDI3LCAyMDIyIGF0IDExOjQ3OjM0QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+
IE9uIFR1ZSwgRGVjIDI3LCAyMDIyIGF0IDc6MzQgQU0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4+PiBPbiBNb24sIERlYyAyNiwgMjAyMiBhdCAwMzo0OTowN1BN
ICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+IFRoaXMgcGF0Y2ggaW50cm9kdWNlcyBhIHBl
ciB2aXJ0cXVldWUgd2FpdHF1ZXVlIHRvIGFsbG93IGRyaXZlciB0bwo+Pj4+IHNsZWVwIGFuZCB3
YWl0IGZvciBtb3JlIHVzZWQuIFR3byBuZXcgaGVscGVycyBhcmUgaW50cm9kdWNlZCB0byBhbGxv
dwo+Pj4+IGRyaXZlciB0byBzbGVlcCBhbmQgd2FrZSB1cC4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYt
Ynk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4+Pj4gLS0tCj4+Pj4gQ2hhbmdl
cyBzaW5jZSBWMToKPj4+PiAtIGNoZWNrIHZpcnRxdWV1ZV9pc19icm9rZW4oKSBhcyB3ZWxsCj4+
Pj4gLSB1c2UgbW9yZV91c2VkKCkgaW5zdGVhZCBvZiB2aXJ0cXVldWVfZ2V0X2J1ZigpIHRvIGFs
bG93IGNhbGxlciB0bwo+Pj4+ICAgIGdldCBidWZmZXJzIGFmdGVyd2FyZHMKPj4+PiAtLS0KPj4+
PiAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAyOSArKysrKysrKysrKysrKysrKysr
KysrKysrKysrKwo+Pj4+ICAgaW5jbHVkZS9saW51eC92aXJ0aW8uaCAgICAgICB8ICAzICsrKwo+
Pj4+ICAgMiBmaWxlcyBjaGFuZ2VkLCAzMiBpbnNlcnRpb25zKCspCj4+Pj4KPj4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMKPj4+PiBpbmRleCA1Y2ZiMmZhOGFiZWUuLjljODNlYjk0NTQ5MyAxMDA2NDQKPj4+
PiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4+Pj4gKysrIGIvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYwo+Pj4+IEBAIC0xMyw2ICsxMyw3IEBACj4+Pj4gICAjaW5jbHVk
ZSA8bGludXgvZG1hLW1hcHBpbmcuaD4KPj4+PiAgICNpbmNsdWRlIDxsaW51eC9rbXNhbi5oPgo+
Pj4+ICAgI2luY2x1ZGUgPGxpbnV4L3NwaW5sb2NrLmg+Cj4+Pj4gKyNpbmNsdWRlIDxsaW51eC93
YWl0Lmg+Cj4+Pj4gICAjaW5jbHVkZSA8eGVuL3hlbi5oPgo+Pj4+Cj4+Pj4gICAjaWZkZWYgREVC
VUcKPj4+PiBAQCAtNjAsNiArNjEsNyBAQAo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgIiVz
OiJmbXQsIChfdnEpLT52cS5uYW1lLCAjI2FyZ3MpOyAgICAgIFwKPj4+PiAgICAgICAgICAgICAg
ICAvKiBQYWlycyB3aXRoIFJFQURfT05DRSgpIGluIHZpcnRxdWV1ZV9pc19icm9rZW4oKS4gKi8g
XAo+Pj4+ICAgICAgICAgICAgICAgIFdSSVRFX09OQ0UoKF92cSktPmJyb2tlbiwgdHJ1ZSk7ICAg
ICAgICAgICAgICAgICAgICAgICBcCj4+Pj4gKyAgICAgICAgICAgICB3YWtlX3VwX2ludGVycnVw
dGlibGUoJihfdnEpLT53cSk7ICAgICAgICAgICAgICAgICAgICAgXAo+Pj4+ICAgICAgICB9IHdo
aWxlICgwKQo+Pj4+ICAgI2RlZmluZSBTVEFSVF9VU0UodnEpCj4+Pj4gICAjZGVmaW5lIEVORF9V
U0UodnEpCj4+Pj4gQEAgLTIwMyw2ICsyMDUsOSBAQCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlIHsK
Pj4+PiAgICAgICAgLyogRE1BLCBhbGxvY2F0aW9uLCBhbmQgc2l6ZSBpbmZvcm1hdGlvbiAqLwo+
Pj4+ICAgICAgICBib29sIHdlX293bl9yaW5nOwo+Pj4+Cj4+Pj4gKyAgICAgLyogV2FpdCBmb3Ig
YnVmZmVyIHRvIGJlIHVzZWQgKi8KPj4+PiArICAgICB3YWl0X3F1ZXVlX2hlYWRfdCB3cTsKPj4+
PiArCj4+Pj4gICAjaWZkZWYgREVCVUcKPj4+PiAgICAgICAgLyogVGhleSdyZSBzdXBwb3NlZCB0
byBsb2NrIGZvciB1cy4gKi8KPj4+PiAgICAgICAgdW5zaWduZWQgaW50IGluX3VzZTsKPj4+PiBA
QCAtMjAyNCw2ICsyMDI5LDggQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0
ZV92aXJ0cXVldWVfcGFja2VkKAo+Pj4+ICAgICAgICBpZiAodmlydGlvX2hhc19mZWF0dXJlKHZk
ZXYsIFZJUlRJT19GX09SREVSX1BMQVRGT1JNKSkKPj4+PiAgICAgICAgICAgICAgICB2cS0+d2Vh
a19iYXJyaWVycyA9IGZhbHNlOwo+Pj4+Cj4+Pj4gKyAgICAgaW5pdF93YWl0cXVldWVfaGVhZCgm
dnEtPndxKTsKPj4+PiArCj4+Pj4gICAgICAgIGVyciA9IHZyaW5nX2FsbG9jX3N0YXRlX2V4dHJh
X3BhY2tlZCgmdnJpbmdfcGFja2VkKTsKPj4+PiAgICAgICAgaWYgKGVycikKPj4+PiAgICAgICAg
ICAgICAgICBnb3RvIGVycl9zdGF0ZV9leHRyYTsKPj4+PiBAQCAtMjUxNyw2ICsyNTI0LDggQEAg
c3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKl9fdnJpbmdfbmV3X3ZpcnRxdWV1ZSh1bnNpZ25lZCBp
bnQgaW5kZXgsCj4+Pj4gICAgICAgIGlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElP
X0ZfT1JERVJfUExBVEZPUk0pKQo+Pj4+ICAgICAgICAgICAgICAgIHZxLT53ZWFrX2JhcnJpZXJz
ID0gZmFsc2U7Cj4+Pj4KPj4+PiArICAgICBpbml0X3dhaXRxdWV1ZV9oZWFkKCZ2cS0+d3EpOwo+
Pj4+ICsKPj4+PiAgICAgICAgZXJyID0gdnJpbmdfYWxsb2Nfc3RhdGVfZXh0cmFfc3BsaXQodnJp
bmdfc3BsaXQpOwo+Pj4+ICAgICAgICBpZiAoZXJyKSB7Cj4+Pj4gICAgICAgICAgICAgICAga2Zy
ZWUodnEpOwo+Pj4+IEBAIC0yNjU0LDYgKzI2NjMsOCBAQCBzdGF0aWMgdm9pZCB2cmluZ19mcmVl
KHN0cnVjdCB2aXJ0cXVldWUgKl92cSkKPj4+PiAgIHsKPj4+PiAgICAgICAgc3RydWN0IHZyaW5n
X3ZpcnRxdWV1ZSAqdnEgPSB0b192dnEoX3ZxKTsKPj4+Pgo+Pj4+ICsgICAgIHdha2VfdXBfaW50
ZXJydXB0aWJsZSgmdnEtPndxKTsKPj4+PiArCj4+Pj4gICAgICAgIGlmICh2cS0+d2Vfb3duX3Jp
bmcpIHsKPj4+PiAgICAgICAgICAgICAgICBpZiAodnEtPnBhY2tlZF9yaW5nKSB7Cj4+Pj4gICAg
ICAgICAgICAgICAgICAgICAgICB2cmluZ19mcmVlX3F1ZXVlKHZxLT52cS52ZGV2LAo+Pj4+IEBA
IC0yODYzLDQgKzI4NzQsMjIgQEAgY29uc3Qgc3RydWN0IHZyaW5nICp2aXJ0cXVldWVfZ2V0X3Zy
aW5nKHN0cnVjdCB2aXJ0cXVldWUgKnZxKQo+Pj4+ICAgfQo+Pj4+ICAgRVhQT1JUX1NZTUJPTF9H
UEwodmlydHF1ZXVlX2dldF92cmluZyk7Cj4+Pj4KPj4+PiAraW50IHZpcnRxdWV1ZV93YWl0X2Zv
cl91c2VkKHN0cnVjdCB2aXJ0cXVldWUgKl92cSkKPj4+PiArewo+Pj4+ICsgICAgIHN0cnVjdCB2
cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7Cj4+Pj4gKwo+Pj4+ICsgICAgIC8qIFRP
RE86IFR3ZWFrIHRoZSB0aW1lb3V0LiAqLwo+Pj4+ICsgICAgIHJldHVybiB3YWl0X2V2ZW50X2lu
dGVycnVwdGlibGVfdGltZW91dCh2cS0+d3EsCj4+Pj4gKyAgICAgICAgICAgIHZpcnRxdWV1ZV9p
c19icm9rZW4oX3ZxKSB8fCBtb3JlX3VzZWQodnEpLCBIWik7Cj4+PiBUaGVyZSdzIG5vIGdvb2Qg
dGltZW91dC4gTGV0J3Mgbm90IGV2ZW4gZ28gdGhlcmUsIGlmIGRldmljZSBnb2VzCj4+PiBiYWQg
aXQgc2hvdWxkIHNldCB0aGUgbmVlZCByZXNldCBiaXQuCj4+IFRoZSBwcm9ibGVtIGlzIHRoYXQg
d2UgY2FuJ3QgZGVwZW5kIG9uIHRoZSBkZXZpY2UuIElmIGl0IHRha2VzIHRvbwo+PiBsb25nIGZv
ciB0aGUgZGV2aWNlIHRvIHJlc3BvbmQgdG8gY3ZxLCB0aGVyZSdzIGEgaGlnaCBwb3NzaWJpbGl0
eSB0aGF0Cj4+IHRoZSBkZXZpY2UgaXMgYnVnZ3kgb3IgZXZlbiBtYWxpY2lvdXMuIFdlIGNhbiBo
YXZlIGEgaGlnaGVyIHRpbWVvdXQKPj4gaGVyZSBhbmQgaXQgc2hvdWxkIGJlIHN0aWxsIGJldHRl
ciB0aGFuIHdhaXRpbmcgZm9yZXZlciAodGhlIGN2cQo+PiBjb21tYW5kcyBuZWVkIHRvIGJlIHNl
cmlhbGl6ZWQgc28gaXQgbmVlZHMgdG8gaG9sZCBhIGxvY2sgYW55d2F5Cj4+IChSVE5MKSApLgo+
Pgo+PiBUaGFua3MKPiBXaXRoIGEgVE9ETyBpdGVtIGxpa2UgdGhpcyBJJ2QgZXhwZWN0IHRoaXMg
dG8gYmUgYW4gUkZDLgo+IEhlcmUncyB3aHk6Cj4KPiBNYWtpbmcgZHJpdmVyIG1vcmUgcm9idXN0
IGZyb20gZGV2aWNlIGZhaWx1cmVzIGlzIGEgbGF1ZGFibGUgZ29hbCBidXQgaXQncyByZWFsbHkK
PiBoYXJkIHRvIGJlIDEwMCUgZm9vbHByb29mIGhlcmUuIEUuZy4gZGV2aWNlIGNhbiBqdXN0IGJs
b2NrIHBjaSByZWFkcyBhbmQKPiBpdCB3b3VsZCBiZSB2ZXJ5IGhhcmQgdG8gcmVjb3Zlci4KCgpZ
ZXMuCgoKPiAgICBTbyBJJ20gZ29pbmcgdG8gb25seSBtZXJnZSBwYXRjaGVzCj4gbGlrZSB0aGlz
IGlmIHRoZXkgYXQgbGVhc3QgdGhlb3JldGljYWxseSBoYXZlIHZlcnkgbGl0dGxlIGNoYW5jZQo+
IG9mIGJyZWFraW5nIGV4aXN0aW5nIHVzZXJzLgoKCkFGQUlLLCB0aGlzIGlzIG5vdCB0aGVvcmV0
aWNhbCwgY29uc2lkZXI6CgoxKSBEUFUgbWF5IGltcGxlbWVudCB2aXJ0aW8tbmV0IENWUSB3aXRo
IGNvZGVzIHJ1bm5pbmcgaW4gQ1BVCjIpIFZEVVNFIG1heSB3YW50IHRvIHN1cHBvcnQgQ1ZRIGlu
IHRoZSBmdXR1cmUKCgo+Cj4gQW5kIG5vdGUgdGhhdCBpbiBtb3N0IHNldHVwcywgQ1ZRIGlzIG9u
bHkgdXNlZCBhdCBzdGFydHVwIGFuZCB0aGVuIGxlZnQgbW9zdGx5IGFsb25lLgo+Cj4gRmluYWxs
eSwgbm90ZSB0aGF0IGxvdHMgb2YgZ3Vlc3RzIG5lZWQgdmlydGlvIHRvIGRvIGFueXRoaW5nIHVz
ZWZ1bCBhdCBhbGwuCj4gU28ganVzdCBmYWlsaW5nIGNvbW1hbmRzIGlzIG5vdCBlbm91Z2ggdG8g
cmVjb3ZlciAtIHlvdSBuZWVkIHRvIHRyeQo+IGhhcmRlciBtYXliZSBieSBhdHRlbXB0aW5nIHRv
IHJlc2V0IGRldmljZS4KCgpUaGlzIHJlcXVpcmVzIHVwcGVyIGxheWVyIHN1cHBvcnQgd2hpY2gg
c2VlbXMgbm90IGV4aXN0ZWQgaW4gdGhlIApuZXR3b3JraW5nIHN1YnN5c3RlbS4KCgo+IENvdWxk
IGJlIGEgcXVlc3Rpb24gb2YKPiBwb2xpY3kgLSBtaWdodCBuZWVkIHRvIG1ha2UgdGhpcyBndWVz
dCBjb25maWd1cmFibGUuCgoKWWVzLgoKVGhhbmtzCgoKPgo+Cj4KPj4+Cj4+Pj4gK30KPj4+PiAr
RVhQT1JUX1NZTUJPTF9HUEwodmlydHF1ZXVlX3dhaXRfZm9yX3VzZWQpOwo+Pj4+ICsKPj4+PiAr
dm9pZCB2aXJ0cXVldWVfd2FrZV91cChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpCj4+Pj4gK3sKPj4+
PiArICAgICBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+Pj4+ICsK
Pj4+PiArICAgICB3YWtlX3VwX2ludGVycnVwdGlibGUoJnZxLT53cSk7Cj4+Pj4gK30KPj4+PiAr
RVhQT1JUX1NZTUJPTF9HUEwodmlydHF1ZXVlX3dha2VfdXApOwo+Pj4+ICsKPj4+PiAgIE1PRFVM
RV9MSUNFTlNFKCJHUEwiKTsKPj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92aXJ0aW8u
aCBiL2luY2x1ZGUvbGludXgvdmlydGlvLmgKPj4+PiBpbmRleCBkY2FiOWM3ZTg3ODQuLjJlYjYy
Yzc3NDg5NSAxMDA2NDQKPj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4+Pj4gKysr
IGIvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+Pj4+IEBAIC03Miw2ICs3Miw5IEBAIHZvaWQgKnZp
cnRxdWV1ZV9nZXRfYnVmKHN0cnVjdCB2aXJ0cXVldWUgKnZxLCB1bnNpZ25lZCBpbnQgKmxlbik7
Cj4+Pj4gICB2b2lkICp2aXJ0cXVldWVfZ2V0X2J1Zl9jdHgoc3RydWN0IHZpcnRxdWV1ZSAqdnEs
IHVuc2lnbmVkIGludCAqbGVuLAo+Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQg
KipjdHgpOwo+Pj4+Cj4+Pj4gK2ludCB2aXJ0cXVldWVfd2FpdF9mb3JfdXNlZChzdHJ1Y3Qgdmly
dHF1ZXVlICp2cSk7Cj4+Pj4gK3ZvaWQgdmlydHF1ZXVlX3dha2VfdXAoc3RydWN0IHZpcnRxdWV1
ZSAqdnEpOwo+Pj4+ICsKPj4+PiAgIHZvaWQgdmlydHF1ZXVlX2Rpc2FibGVfY2Ioc3RydWN0IHZp
cnRxdWV1ZSAqdnEpOwo+Pj4+Cj4+Pj4gICBib29sIHZpcnRxdWV1ZV9lbmFibGVfY2Ioc3RydWN0
IHZpcnRxdWV1ZSAqdnEpOwo+Pj4+IC0tCj4+Pj4gMi4yNS4xCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
