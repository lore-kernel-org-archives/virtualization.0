Return-Path: <SRS0=+DIW=J2=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C45C43462
	for <virtualization@archiver.kernel.org>; Thu, 29 Apr 2021 04:16:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DD19861405
	for <virtualization@archiver.kernel.org>; Thu, 29 Apr 2021 04:16:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DD19861405
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B3F61606E5;
	Thu, 29 Apr 2021 04:16:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RPwv0urgITox; Thu, 29 Apr 2021 04:16:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 278EE60DD0;
	Thu, 29 Apr 2021 04:16:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 16BA0C000E;
	Thu, 29 Apr 2021 04:16:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4065DC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 04:16:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 3262C60DB0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 04:16:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id XFT925GDy_Wf
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 04:16:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1E97B606E5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 29 Apr 2021 04:16:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1619669803;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=u/QUY4qCTlUpRklnkagB+tJ3wFuKq8JIyfGnRJ0ldCk=;
 b=b9+KISNKLwYCiGKDw2954hB35/fGFQt9Bpb2TFzs4He3xjCIM3qjTHk58xfH7txjP8gEi6
 rggaEwoIJWpKK6sfY9DuvFuq2rJ+c5Uj5vRdagW4TxDbGYh1qoC1kLuciREsRw78jk7D7Q
 Hns+kazdIlHUHsssJuczbYQw9D4Rpp0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-OyWakbAFOPmsSM8Iu953tQ-1; Thu, 29 Apr 2021 00:16:39 -0400
X-MC-Unique: OyWakbAFOPmsSM8Iu953tQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id D06BD802938;
 Thu, 29 Apr 2021 04:16:37 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-162.pek2.redhat.com
 [10.72.13.162])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CEC8D6A967;
 Thu, 29 Apr 2021 04:16:26 +0000 (UTC)
Subject: Re: [RFC PATCH 0/7] Untrusted device support for virtio
To: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
References: <20210421032117.5177-1-jasowang@redhat.com>
 <YInOQt1l/59zzPJK@Konrads-MacBook-Pro.local>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <9b089e3b-7d7a-b9d6-a4a1-81a6eff2e425@redhat.com>
Date: Thu, 29 Apr 2021 12:16:25 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <YInOQt1l/59zzPJK@Konrads-MacBook-Pro.local>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: ashish.kalra@amd.com, file@sect.tu-berlin.de,
 martin.radev@aisec.fraunhofer.de, kvm@vger.kernel.org, mst@redhat.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 xieyongji@bytedance.com, stefanha@redhat.com
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvNC8yOSDJz87nNTowNiwgS29ucmFkIFJ6ZXN6dXRlayBXaWxrINC0tcA6Cj4gT24g
V2VkLCBBcHIgMjEsIDIwMjEgYXQgMTE6MjE6MTBBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4gSGkgQWxsOgo+Pgo+PiBTb21ldGltZXMsIHRoZSBkcml2ZXIgZG9lc24ndCB0cnVzdCB0aGUg
ZGV2aWNlLiBUaGlzIGlzIHVzdWFsbHkKPj4gaGFwcGVucyBmb3IgdGhlIGVuY3J0cHllZCBWTSBv
ciBWRFVTRVsxXS4gSW4gYm90aCBjYXNlcywgdGVjaG5vbG9neQo+PiBsaWtlIHN3aW90bGIgaXMg
dXNlZCB0byBwcmV2ZW50IHRoZSBwb2tpbmcvbWFuZ2xpbmcgb2YgbWVtb3J5IGZyb20gdGhlCj4+
IGRldmljZS4gQnV0IHRoaXMgaXMgbm90IHN1ZmZpY2llbnQgc2luY2UgY3VycmVudCB2aXJ0aW8g
ZHJpdmVyIG1heQo+PiB0cnVzdCB3aGF0IGlzIHN0b3JlZCBpbiB0aGUgZGVzY3JpcHRvciB0YWJs
ZSAoY29oZXJlbnQgbWFwcGluZykgZm9yCj4+IHBlcmZvcm1pbmcgdGhlIERNQSBvcGVyYXRpb25z
IGxpa2UgdW5tYXAgYW5kIGJvdW5jZSBzbyB0aGUgZGV2aWNlIG1heQo+PiBjaG9vc2UgdG8gdXRp
bGl6ZSB0aGUgYmVoYXZpb3VyIG9mIHN3aW90bGIgdG8gcGVyZm9ybSBhdHRhY2tzWzJdLgo+IFdl
IGZpeGVkIGl0IGluIHRoZSBTV0lPVExCLiBUaGF0IGlzIGl0IHNhdmVzIHRoZSBleHBlY3RlZCBs
ZW5ndGgKPiBvZiB0aGUgRE1BIG9wZXJhdGlvbi4gU2VlCj4KPiBjb21taXQgZGFmOTUxNGZkNWVi
MDk4ZDdkNmYzYTEyNDdjYjhjYzQ4ZmM5NDE1NQo+IEF1dGhvcjogTWFydGluIFJhZGV2IDxtYXJ0
aW4uYi5yYWRldkBnbWFpbC5jb20+Cj4gRGF0ZTogICBUdWUgSmFuIDEyIDE2OjA3OjI5IDIwMjEg
KzAxMDAKPgo+ICAgICAgc3dpb3RsYjogVmFsaWRhdGUgYm91bmNlIHNpemUgaW4gdGhlIHN5bmMv
dW5tYXAgcGF0aAo+ICAgICAgCj4gICAgICBUaGUgc2l6ZSBvZiB0aGUgYnVmZmVyIGJlaW5nIGJv
dW5jZWQgaXMgbm90IGNoZWNrZWQgaWYgaXQgaGFwcGVucwo+ICAgICAgdG8gYmUgbGFyZ2VyIHRo
YW4gdGhlIHNpemUgb2YgdGhlIG1hcHBlZCBidWZmZXIuIEJlY2F1c2UgdGhlIHNpemUKPiAgICAg
IGNhbiBiZSBjb250cm9sbGVkIGJ5IGEgZGV2aWNlLCBhcyBpdCdzIHRoZSBjYXNlIHdpdGggdmly
dGlvIGRldmljZXMsCj4gICAgICB0aGlzIGNhbiBsZWFkIHRvIG1lbW9yeSBjb3JydXB0aW9uLgo+
ICAgICAgCgoKR29vZCB0byBrbm93IHRoaXMsIGJ1dCB0aGlzIHNlcmllcyB0cmllcyB0byBwcm90
ZWN0IGF0IGRpZmZlcmVudCBsZXZlbC4gCkFuZCBJIGJlbGlldmUgc3VjaCBwcm90ZWN0aW9uIG5l
ZWRzIHRvIGJlIGRvbmUgYXQgYm90aCBsZXZlbHMuCgoKPj4gRm9yIGRvdWJsZSBpbnN1cmFuY2Us
IHRvIHByb3RlY3QgZnJvbSBhIG1hbGljb3VzIGRldmljZSwgd2hlbiBETUEgQVBJCj4+IGlzIHVz
ZWQgZm9yIHRoZSBkZXZpY2UsIHRoaXMgc2VyaWVzIHN0b3JlIGFuZCB1c2UgdGhlIGRlc2NyaXB0
b3IKPj4gbWV0YWRhdGEgaW4gYW4gYXV4aWxpYXkgc3RydWN0dXJlIHdoaWNoIGNhbiBub3QgYmUg
YWNjZXNzZWQgdmlhCj4+IHN3aW90bGIgaW5zdGVhZCBvZiB0aGUgb25lcyBpbiB0aGUgZGVzY3Jp
cHRvciB0YWJsZS4gQWN0dWFsbHksIHdlJ3ZlCj4gU29ycnkgZm9yIGJlaW5nIGRlbnNlIGhlcmUs
IGJ1dCBob3cgd29sZCBTV0lPVExCIGJlIHV0aWxpemVkIGZvcgo+IHRoaXMgYXR0YWNrPwoKClNv
IHdlIHN0aWxsIGJlaGF2aW9ycyB0aGF0IGlzIHRyaWdnZXJlZCBieSBkZXZpY2UgdGhhdCBpcyBu
b3QgdHJ1c3RlZC4gClN1Y2ggYmVoYXZpb3IgaXMgd2hhdCB0aGUgc2VyaWVzIHRyaWVzIHRvIGF2
b2lkLiBXZSd2ZSBsZWFybnQgYSBsb3Qgb2YgCmxlc3NvbnMgdG8gZWxpbWluYXRlIHRoZSBwb3Rl
bnRpYWwgYXR0YWNrcyB2aWEgdGhpcy4gQW5kIGl0IHdvdWxkIGJlIHRvbyAKbGF0ZSB0byBmaXgg
aWYgd2UgZm91bmQgYW5vdGhlciBpc3N1ZSBvZiBTV0lPVExCLgoKUHJvdmluZyAidGhlIHVuZXhw
ZWN0ZWQgZGV2aWNlIHRyaWdnZXJlZCBiZWhhdmlvciBpcyBzYWZlIiBpcyB2ZXJ5IGhhcmQgCihv
ciBldmVuIGltcG9zc2libGUpIHRoYW4gImVsaW1pbmF0aW5nIHRoZSB1bmV4cGVjdGVkIGRldmlj
ZSB0cmlnZ2VyZWQgCmJlaGF2aW9yIHRvdGFsbHkiLgoKRS5nIEkgd29uZGVyIHdoZXRoZXIgc29t
ZXRoaW5nIGxpa2UgdGhpcyBjYW4gaGFwcGVuOiBDb25zaWRlciB0aGUgRE1BIApkaXJlY3Rpb24g
b2YgdW5tYXAgaXMgdW5kZXIgdGhlIGNvbnRyb2wgb2YgZGV2aWNlLiBUaGUgZGV2aWNlIGNhbiBj
aGVhdCAKdGhlIFNXSU9UTEIgYnkgY2hhbmdpbmcgdGhlIGZsYWcgdG8gbW9kaWZ5IHRoZSBkZXZp
Y2UgcmVhZCBvbmx5IGJ1ZmZlci4gCklmIHllcywgaXQgaXMgcmVhbGx5IHNhZmU/CgpUaGUgYWJv
dmUgcGF0Y2ggb25seSBsb2cgdGhlIGJvdW5jZSBzaXplIGJ1dCBpdCBkb2Vzbid0IGxvZyB0aGUg
ZmxhZy4gCkV2ZW4gaWYgaXQgbG9ncyB0aGUgZmxhZywgU1dJT1RMQiBzdGlsbCBkb2Vzbid0IGtu
b3cgaG93IGVhY2ggYnVmZmVyIGlzIAp1c2VkIGFuZCB3aGVuIGl0J3MgdGhlIGFwcHJvcHJpYXRl
KHNhZmUpIHRpbWUgdG8gdW5tYXAgdGhlIGJ1ZmZlciwgb25seSAKdGhlIGRyaXZlciB0aGF0IGlz
IHVzaW5nIHRoZSBTV0lPVExCIGtub3cgdGhlbS4KClNvIEkgdGhpbmsgd2UgbmVlZCB0byBjb25z
b2xpZGF0ZSBvbiBib3RoIGxheWVycyBpbnN0ZWFkIG9mIHNvbGVseSAKZGVwZW5kaW5nIG9uIHRo
ZSBTV0lPVExCLgoKVGhhbmtzCgoKPgo+PiBhbG1vc3QgYWNoaWV2ZWQgdGhhdCB0aHJvdWdoIHBh
Y2tlZCB2aXJ0cXVldWUgYW5kIHdlIGp1c3QgbmVlZCB0byBmaXgKPj4gYSBjb3JuZXIgY2FzZSBv
ZiBoYW5kbGluZyBtYXBwaW5nIGVycm9ycy4gRm9yIHNwbGl0IHZpcnRxdWV1ZSB3ZSBqdXN0Cj4+
IGZvbGxvdyB3aGF0J3MgZG9uZSBpbiB0aGUgcGFja2VkLgo+Pgo+PiBOb3RlIHRoYXQgd2UgZG9u
J3QgZHVwbGljYXRlIGRlc2NyaXB0b3IgbWVkYXRhIGZvciBpbmRpcmVjdAo+PiBkZXNjcmlwdG9y
cyBzaW5jZSBpdCB1c2VzIHN0cmVhbSBtYXBwaW5nIHdoaWNoIGlzIHJlYWQgb25seSBzbyBpdCdz
Cj4+IHNhZmUgaWYgdGhlIG1ldGFkYXRhIG9mIG5vbi1pbmRpcmVjdCBkZXNjcmlwdG9ycyBhcmUg
Y29ycmVjdC4KPj4KPj4gVGhlIGJlaGFpdm9yIGZvciBub24gRE1BIEFQSSBpcyBrZXB0IGZvciBt
aW5pbWl6aW5nIHRoZSBwZXJmb3JtYW5jZQo+PiBpbXBhY3QuCj4+Cj4+IFNsaWdodGx5IHRlc3Rl
ZCB3aXRoIHBhY2tlZCBvbi9vZmYsIGlvbW11IG9uL29mLCBzd2lvdGxiIGZvcmNlL29mZiBpbgo+
PiB0aGUgZ3Vlc3QuCj4+Cj4+IFBsZWFzZSByZXZpZXcuCj4+Cj4+IFsxXSBodHRwczovL2xvcmUu
a2VybmVsLm9yZy9uZXRkZXYvZmFiNjE1Y2UtNWUxMy1hM2IzLTM3MTUtYTQyMDNiNGFiMDEwQHJl
ZGhhdC5jb20vVC8KPj4gWzJdIGh0dHBzOi8veWhidC5uZXQvbG9yZS9hbGwvYzM2MjlhMjctMzU5
MC0xZDlmLTIxMWItYzBiN2JlMTUyYjMyQHJlZGhhdC5jb20vVC8jbWM2YjZlMjM0M2NiZWZmY2E2
OGNhN2E5N2UwZjQ3M2FhYTg3MWM5NWIKPj4KPj4gSmFzb24gV2FuZyAoNyk6Cj4+ICAgIHZpcnRp
by1yaW5nOiBtYWludGFpbiBuZXh0IGluIGV4dHJhIHN0YXRlIGZvciBwYWNrZWQgdmlydHF1ZXVl
Cj4+ICAgIHZpcnRpb19yaW5nOiByZW5hbWUgdnJpbmdfZGVzY19leHRyYV9wYWNrZWQKPj4gICAg
dmlydGlvLXJpbmc6IGZhY3RvciBvdXQgZGVzY19leHRyYSBhbGxvY2F0aW9uCj4+ICAgIHZpcnRp
b19yaW5nOiBzZWN1cmUgaGFuZGxpbmcgb2YgbWFwcGluZyBlcnJvcnMKPj4gICAgdmlydGlvX3Jp
bmc6IGludHJvZHVjZSB2aXJ0cXVldWVfZGVzY19hZGRfc3BsaXQoKQo+PiAgICB2aXJ0aW86IHVz
ZSBlcnIgbGFiZWwgaW4gX192cmluZ19uZXdfdmlydHF1ZXVlKCkKPj4gICAgdmlydGlvLXJpbmc6
IHN0b3JlIERNQSBtZXRhZGF0YSBpbiBkZXNjX2V4dHJhIGZvciBzcGxpdCB2aXJ0cXVldWUKPj4K
Pj4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgMTg5ICsrKysrKysrKysrKysrKysr
KysrKysrKysrLS0tLS0tLS0tCj4+ICAgMSBmaWxlIGNoYW5nZWQsIDE0MSBpbnNlcnRpb25zKCsp
LCA0OCBkZWxldGlvbnMoLSkKPj4KPj4gLS0gCj4+IDIuMjUuMQo+PgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
