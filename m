Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA60C77B72
	for <virtualization@archiver.kernel.org>; Thu, 20 Apr 2023 10:22:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id ECD4A60BE9;
	Thu, 20 Apr 2023 10:22:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org ECD4A60BE9
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c+zf/oqK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id i2gs4f6gpZPJ; Thu, 20 Apr 2023 10:22:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 7C00960C24;
	Thu, 20 Apr 2023 10:22:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7C00960C24
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 560F9C0037;
	Thu, 20 Apr 2023 10:22:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E395EC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 10:22:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BE79883D22
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 10:22:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BE79883D22
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=c+zf/oqK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 50uFBLNsBEAB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 10:22:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D615983CA1
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D615983CA1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 20 Apr 2023 10:22:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681986170;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xHh4Hk5Wr59/VR6ozFS/iFZq7pLvic32jswlAbPFFNU=;
 b=c+zf/oqKrWbC7asJzHP+skopR38D4atanek+Ti/ENHvRyi+C466jVv9fowVTpmF64W0+wE
 2uL12ecHlbo8EyLuK9I/H8utRrPEv4zmyTPVbWns4e87T2H0qBeMZcB5zCmTYdKlfOl/In
 zYxcc09Pw3JSRfVMgdf2Qt7XKIF71FI=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-368-1K4aE1vEMg2jHWaV3Oc8jg-1; Thu, 20 Apr 2023 06:22:39 -0400
X-MC-Unique: 1K4aE1vEMg2jHWaV3Oc8jg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com
 [10.11.54.2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id BAB46101A531;
 Thu, 20 Apr 2023 10:22:38 +0000 (UTC)
Received: from [10.39.208.29] (unknown [10.39.208.29])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id D3D114020BEE;
 Thu, 20 Apr 2023 10:22:36 +0000 (UTC)
Message-ID: <b860bd8d-c99b-eeee-b7a3-c58aa79f3146@redhat.com>
Date: Thu, 20 Apr 2023 12:22:34 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [RFC 1/2] vduse: validate block features only with block devices
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20230419134329.346825-1-maxime.coquelin@redhat.com>
 <20230419134329.346825-2-maxime.coquelin@redhat.com>
 <CACGkMEtooodqB9pSGTQJx4x55-+RqPhNhT5_4zSDMiCSJXyjVg@mail.gmail.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
In-Reply-To: <CACGkMEtooodqB9pSGTQJx4x55-+RqPhNhT5_4zSDMiCSJXyjVg@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.2
Cc: xuanzhuo@linux.alibaba.com, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, eperezma@redhat.com, david.marchand@redhat.com
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

CgpPbiA0LzIwLzIzIDA2OjA2LCBKYXNvbiBXYW5nIHdyb3RlOgo+IE9uIFdlZCwgQXByIDE5LCAy
MDIzIGF0IDk6NDPigK9QTSBNYXhpbWUgQ29xdWVsaW4KPiA8bWF4aW1lLmNvcXVlbGluQHJlZGhh
dC5jb20+IHdyb3RlOgo+Pgo+PiBUaGlzIHBhdGNoIGlzIHByZWxpbWluYXJ5IHdvcmsgdG8gZW5h
YmxlIG5ldHdvcmsgZGV2aWNlCj4+IHR5cGUgc3VwcG9ydCB0byBWRFVTRS4KPj4KPj4gQXMgVklS
VElPX0JMS19GX0NPTkZJR19XQ0Ugc2hhcmVzIHRoZSBzYW1lIHZhbHVlIGFzCj4+IFZJUlRJT19O
RVRfRl9IT1NUX1RTTzQsIHdlIG5lZWQgdG8gcmVzdHJpY3QgaXRzIGNoZWNrCj4+IHRvIFZpcnRp
by1ibGsgZGV2aWNlIHR5cGUuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IE1heGltZSBDb3F1ZWxpbiA8
bWF4aW1lLmNvcXVlbGluQHJlZGhhdC5jb20+Cj4+IC0tLQo+PiAgIGRyaXZlcnMvdmRwYS92ZHBh
X3VzZXIvdmR1c2VfZGV2LmMgfCA5ICsrKysrLS0tLQo+PiAgIDEgZmlsZSBjaGFuZ2VkLCA1IGlu
c2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4+Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zk
cGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jIGIvZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9k
ZXYuYwo+PiBpbmRleCAwYzNiNDg2MTZhOWYuLjZmYTU5OGEwM2Q4ZSAxMDA2NDQKPj4gLS0tIGEv
ZHJpdmVycy92ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYwo+PiArKysgYi9kcml2ZXJzL3ZkcGEv
dmRwYV91c2VyL3ZkdXNlX2Rldi5jCj4+IEBAIC0xNDE2LDEzICsxNDE2LDE0IEBAIHN0YXRpYyBi
b29sIGRldmljZV9pc19hbGxvd2VkKHUzMiBkZXZpY2VfaWQpCj4+ICAgICAgICAgIHJldHVybiBm
YWxzZTsKPj4gICB9Cj4+Cj4+IC1zdGF0aWMgYm9vbCBmZWF0dXJlc19pc192YWxpZCh1NjQgZmVh
dHVyZXMpCj4+ICtzdGF0aWMgYm9vbCBmZWF0dXJlc19pc192YWxpZChzdHJ1Y3QgdmR1c2VfZGV2
X2NvbmZpZyAqY29uZmlnKQo+PiAgIHsKPj4gLSAgICAgICBpZiAoIShmZWF0dXJlcyAmICgxVUxM
IDw8IFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSkpKQo+PiArICAgICAgIGlmICghKGNvbmZpZy0+
ZmVhdHVyZXMgJiAoMVVMTCA8PCBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0pKSkKPj4gICAgICAg
ICAgICAgICAgICByZXR1cm4gZmFsc2U7Cj4+Cj4+ICAgICAgICAgIC8qIE5vdyB3ZSBvbmx5IHN1
cHBvcnQgcmVhZC1vbmx5IGNvbmZpZ3VyYXRpb24gc3BhY2UgKi8KPj4gLSAgICAgICBpZiAoZmVh
dHVyZXMgJiAoMVVMTCA8PCBWSVJUSU9fQkxLX0ZfQ09ORklHX1dDRSkpCj4+ICsgICAgICAgaWYg
KChjb25maWctPmRldmljZV9pZCA9PSBWSVJUSU9fSURfQkxPQ0spICYmCj4+ICsgICAgICAgICAg
ICAgICAgICAgICAgIChjb25maWctPmZlYXR1cmVzICYgKDFVTEwgPDwgVklSVElPX0JMS19GX0NP
TkZJR19XQ0UpKSkKPiAKPiBUaGUgcmVhc29uIHdlIGZpbHRlciBXQ0Ugb3V0IGlzIHRvIGF2b2lk
IHdyaXRhYmxlIGNvbmZpZyBzcGFjZSB3aGljaAo+IG1pZ2h0IGJsb2NrIHRoZSBkcml2ZXIgd2l0
aCBhIGJ1Z2d5IHVzZXJzcGFjZS4KPiAKPiBGb3IgbmV0d29ya2luZywgSSBndWVzcyB3ZSBzaG91
bGQgZmFpbCBpZiBWRVJTSU9OXzEgaXMgbm90IG5lZ290aWF0ZWQsCj4gdGhlbiB3ZSBjYW4gYXZv
aWQgc2V0dGluZyBtYWMgYWRkcmVzc2VzIHZpYSB0aGUgY29uZmlnIHNwYWNlLgoKICBPaywgSSB3
aWxsIGFkZCBpdCB0byBwYXRjaCAyIGluIFYxLgoKVGhhbmtzLApNYXhpbWUKCj4gCj4gVGhhbmtz
Cj4gCj4+ICAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOwo+Pgo+PiAgICAgICAgICByZXR1
cm4gdHJ1ZTsKPj4gQEAgLTE0NDYsNyArMTQ0Nyw3IEBAIHN0YXRpYyBib29sIHZkdXNlX3ZhbGlk
YXRlX2NvbmZpZyhzdHJ1Y3QgdmR1c2VfZGV2X2NvbmZpZyAqY29uZmlnKQo+PiAgICAgICAgICBp
ZiAoIWRldmljZV9pc19hbGxvd2VkKGNvbmZpZy0+ZGV2aWNlX2lkKSkKPj4gICAgICAgICAgICAg
ICAgICByZXR1cm4gZmFsc2U7Cj4+Cj4+IC0gICAgICAgaWYgKCFmZWF0dXJlc19pc192YWxpZChj
b25maWctPmZlYXR1cmVzKSkKPj4gKyAgICAgICBpZiAoIWZlYXR1cmVzX2lzX3ZhbGlkKGNvbmZp
ZykpCj4+ICAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOwo+Pgo+PiAgICAgICAgICByZXR1
cm4gdHJ1ZTsKPj4gLS0KPj4gMi4zOS4yCj4+Cj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
