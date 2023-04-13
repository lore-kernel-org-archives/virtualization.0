Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1534C77B61
	for <virtualization@archiver.kernel.org>; Thu, 13 Apr 2023 13:06:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 30B3341FC9;
	Thu, 13 Apr 2023 13:06:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 30B3341FC9
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZgZTTBoS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SPn0Aoy9ptoQ; Thu, 13 Apr 2023 13:06:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2EA0341EEA;
	Thu, 13 Apr 2023 13:05:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2EA0341EEA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 00DBCC0036;
	Thu, 13 Apr 2023 13:05:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 63E6EC002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 13:05:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3EB6760D67
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 13:05:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3EB6760D67
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZgZTTBoS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L-JsB1qjPuGp
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 13:05:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org EA1AE60BAC
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id EA1AE60BAC
 for <virtualization@lists.linux-foundation.org>;
 Thu, 13 Apr 2023 13:05:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681391155;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6wSVcYYxYpVN5DF7FLqIuRd52scPCmKkAnh64SyS2hM=;
 b=ZgZTTBoSU1wY+F8LA5HH13WdMYVS0B4ZGFIax/6ozOXre2bIDYn3s9TCu+VKcFfSjMl7Os
 P32EW5jV5yRvp0tnrLCM8Hq4ODiGZh3gUPr5/1/wC4v6w5sRiSZ/bHMf6BKmm3DMVzlWM/
 s07zDkANgFvvvK6kWZ1I+jBXqsLFJTA=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-4hBr1V99Nc-apSJvZIMxTQ-1; Thu, 13 Apr 2023 09:05:52 -0400
X-MC-Unique: 4hBr1V99Nc-apSJvZIMxTQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.rdu2.redhat.com
 [10.11.54.5])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id ED09485C6E3;
 Thu, 13 Apr 2023 13:05:51 +0000 (UTC)
Received: from [10.39.208.7] (unknown [10.39.208.7])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 91A8C7D283;
 Thu, 13 Apr 2023 13:05:49 +0000 (UTC)
Message-ID: <12865759-344a-9111-0ceb-6a31ac510426@redhat.com>
Date: Thu, 13 Apr 2023 15:05:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH net-next V2 0/2] virtio-net: don't busy poll for cvq
 command
Content-Language: en-US
From: Maxime Coquelin <maxime.coquelin@redhat.com>
To: Jason Wang <jasowang@redhat.com>, mst@redhat.com
References: <20230413064027.13267-1-jasowang@redhat.com>
 <f9e75ce5-e6df-d1be-201b-7d0f18c1b6e7@redhat.com>
In-Reply-To: <f9e75ce5-e6df-d1be-201b-7d0f18c1b6e7@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.5
Cc: xuanzhuo@linux.alibaba.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
 david.marchand@redhat.com, davem@davemloft.net
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

CgpPbiA0LzEzLzIzIDE1OjAyLCBNYXhpbWUgQ29xdWVsaW4gd3JvdGU6Cj4gSGkgSmFzb24sCj4g
Cj4gT24gNC8xMy8yMyAwODo0MCwgSmFzb24gV2FuZyB3cm90ZToKPj4gSGkgYWxsOgo+Pgo+PiBU
aGUgY29kZSB1c2VkIHRvIGJ1c3kgcG9sbCBmb3IgY3ZxIGNvbW1hbmQgd2hpY2ggdHVybnMgb3V0
IHRvIGhhdmUKPj4gc2V2ZXJhbCBzaWRlIGVmZmVjdHM6Cj4+Cj4+IDEpIGluZmluaXRlIHBvbGwg
Zm9yIGJ1Z2d5IGRldmljZXMKPj4gMikgYmFkIGludGVyYWN0aW9uIHdpdGggc2NoZWR1bGVyCj4+
Cj4+IFNvIHRoaXMgc2VyaWVzIHRyaWVzIHRvIHVzZSBzbGVlcCBpbnN0ZWFkIG9mIGJ1c3kgcG9s
bGluZy4gSW4gdGhpcwo+PiB2ZXJzaW9uLCBJIHRha2UgYSBzdGVwIGJhY2s6IHRoZSBoYXJkZW5p
bmcgcGFydCBpcyBub3QgaW1wbGVtZW50ZWQgYW5kCj4+IGxlYXZlIGZvciBmdXR1cmUgaW52ZXN0
aWdhdGlvbi4gV2UgdXNlIHRvIGFnZ3JlZSB0byB1c2UgaW50ZXJydXB0aWJsZQo+PiBzbGVlcCBi
dXQgaXQgZG9lc24ndCB3b3JrIGZvciBhIGdlbmVyYWwgd29ya3F1ZXVlLgo+Pgo+PiBQbGVhc2Ug
cmV2aWV3Lgo+IAo+IFRoYW5rcyBmb3Igd29ya2luZyBvbiB0aGlzLgo+IE15IERQREsgVkRVU0Ug
UkZDIG1pc3NlZCB0byBzZXQgdGhlIGludGVycnVwdCwgYXMgWHVhbiBaaG91IGhpZ2hsaWdodGVk
Cj4gaXQgbWFrZXMgdGhlIHZkcGEgZGV2IGFkZC9kZWwgY29tbWFuZHMgdG8gZnJlZXplOgo+IFs8
MD5dIGRldmljZV9kZWwrMHgzNy8weDNkMAo+IFs8MD5dIGRldmljZV91bnJlZ2lzdGVyKzB4MTMv
MHg2MAo+IFs8MD5dIHVucmVnaXN0ZXJfdmlydGlvX2RldmljZSsweDExLzB4MjAKPiBbPDA+XSBk
ZXZpY2VfcmVsZWFzZV9kcml2ZXJfaW50ZXJuYWwrMHgxOTMvMHgyMDAKPiBbPDA+XSBidXNfcmVt
b3ZlX2RldmljZSsweGJmLzB4MTMwCj4gWzwwPl0gZGV2aWNlX2RlbCsweDE3NC8weDNkMAo+IFs8
MD5dIGRldmljZV91bnJlZ2lzdGVyKzB4MTMvMHg2MAo+IFs8MD5dIHZkcGFfbmxfY21kX2Rldl9k
ZWxfc2V0X2RvaXQrMHg2Ni8weGUwIFt2ZHBhXQo+IFs8MD5dIGdlbmxfZmFtaWx5X3Jjdl9tc2df
ZG9pdC5pc3JhLjArMHhiOC8weDEwMAo+IFs8MD5dIGdlbmxfcmN2X21zZysweDE1MS8weDI5MAo+
IFs8MD5dIG5ldGxpbmtfcmN2X3NrYisweDU0LzB4MTAwCj4gWzwwPl0gZ2VubF9yY3YrMHgyNC8w
eDQwCj4gWzwwPl0gbmV0bGlua191bmljYXN0KzB4MjE3LzB4MzQwCj4gWzwwPl0gbmV0bGlua19z
ZW5kbXNnKzB4MjNlLzB4NGEwCj4gWzwwPl0gc29ja19zZW5kbXNnKzB4OGYvMHhhMAo+IFs8MD5d
IF9fc3lzX3NlbmR0bysweGZjLzB4MTcwCj4gWzwwPl0gX194NjRfc3lzX3NlbmR0bysweDIwLzB4
MzAKPiBbPDA+XSBkb19zeXNjYWxsXzY0KzB4NTkvMHg5MAo+IFs8MD5dIGVudHJ5X1NZU0NBTExf
NjRfYWZ0ZXJfaHdmcmFtZSsweDcyLzB4ZGMKPiAKPiBPbmNlIGZpeGVkIG9uIERQREsgc2lkZSAo
eW91IGNhbiB1c2UgbXkgdmR1c2VfdjEgYnJhbmNoIFswXSBmb3IKPiB0ZXN0aW5nKSwgaXQgd29y
a3MgZmluZToKPiAKPiBUZXN0ZWQtYnk6IE1heGltZSBDb3F1ZWxpbiA8bWF4aW1lLmNvcXVlbGlu
QHJlZGhhdC5jb20+Cj4gCj4gRm9yIHRoZSBwb3RlbnRpYWwgbWlzc2luZyBpbnRlcnJ1cHQgd2l0
aCBub24tY29tcGxpYW50IGRldmljZXMsIEkgZ3Vlc3MKPiBpdCBjb3VsZCBiZSBoYW5kbGVkIHdp
dGggdGhlIGhhcmRlbmluZyB3b3JrIGFzIHNhbWUgdGhpbmcgY291bGQgaGFwcGVuCj4gaWYgdGhl
IFZEVVNFIGFwcGxpY2F0aW9uIGNyYXNoZWQgZm9yIGV4YW1wbGUuCj4gCj4gUmVnYXJkcywKPiBN
YXhpbWUKPiAKPiBbMF06CgpCZXR0ZXIgd2l0aCB0aGUgbGluay4uLgoKWzBdOiBodHRwczovL2dp
dGxhYi5jb20vbWNvcXVlbGluL2RwZGstbmV4dC12aXJ0aW8vLS9jb21taXRzL3ZkdXNlX3YxLwoK
Pj4gVGhhbmtzCj4+Cj4+IENoYW5nZXMgc2luY2UgVjE6Cj4+IC0gdXNlIFJUTkwgdG8gc3luY2hy
b25pemUgcnggbW9kZSB3b3JrZXIKPj4gLSB1c2UgY29tcGxldGlvbiBmb3Igc2ltcGxpY2l0eQo+
PiAtIGRvbid0IHRyeSB0byBoYXJkZW4gQ1ZRIGNvbW1hbmQKPj4KPj4gQ2hhbmdlcyBzaW5jZSBS
RkM6Cj4+Cj4+IC0gc3dpdGNoIHRvIHVzZSBCQURfUklORyBpbiB2aXJ0aW9fYnJlYWtfZGV2aWNl
KCkKPj4gLSBjaGVjayB2aXJ0cXVldWVfaXNfYnJva2VuKCkgYWZ0ZXIgYmVpbmcgd29rZW4gdXAK
Pj4gLSB1c2UgbW9yZV91c2VkKCkgaW5zdGVhZCBvZiB2aXJ0cXVldWVfZ2V0X2J1ZigpIHRvIGFs
bG93IGNhbGxlciB0bwo+PiDCoMKgIGdldCBidWZmZXJzIGFmdGVyd2FyZHMKPj4gwqDCoCAtIGJy
ZWFrIHRoZSB2aXJ0aW8tbmV0IGRldmljZSB3aGVuIHRpbWVvdXQKPj4gwqDCoCAtIGdldCBidWZm
ZXIgbWFudWFsbHkgc2luY2UgdGhlIHZpcnRpbyBjb3JlIGNoZWNrIG1vcmVfdXNlZCgpIGluc3Rl
YWQKPj4KPj4gSmFzb24gV2FuZyAoMik6Cj4+IMKgwqAgdmlydGlvLW5ldDogY29udmVydCByeCBt
b2RlIHNldHRpbmcgdG8gdXNlIHdvcmtxdWV1ZQo+PiDCoMKgIHZpcnRpby1uZXQ6IHNsZWVwIGlu
c3RlYWQgb2YgYnVzeSB3YWl0aW5nIGZvciBjdnEgY29tbWFuZAo+Pgo+PiDCoCBkcml2ZXJzL25l
dC92aXJ0aW9fbmV0LmMgfCA3NiArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrLS0t
LS0tCj4+IMKgIDEgZmlsZSBjaGFuZ2VkLCA2NiBpbnNlcnRpb25zKCspLCAxMCBkZWxldGlvbnMo
LSkKPj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
