Return-Path: <SRS0=FgjU=D3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86991C433E7
	for <virtualization@archiver.kernel.org>; Tue, 20 Oct 2020 08:01:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DAF942225F
	for <virtualization@archiver.kernel.org>; Tue, 20 Oct 2020 08:01:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Pxawn+wT"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DAF942225F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 5786387586;
	Tue, 20 Oct 2020 08:01:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PkYGxz2ZJN+a; Tue, 20 Oct 2020 08:01:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8CACA87565;
	Tue, 20 Oct 2020 08:01:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 71D97C0052;
	Tue, 20 Oct 2020 08:01:48 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4E05EC0051
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 08:01:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 3CCE68708A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 08:01:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id N9LM-cPHCr24
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 08:01:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id A6AF68706B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 20 Oct 2020 08:01:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1603180903;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nQarwNjEMfQ1ltnkQfUYDu0cq5r+xzk15cAJFI+bn8k=;
 b=Pxawn+wTm1EQl+jceYhfR85WffI+U2ftRnWB5YlVeCzV/JMQQ63PUDNDt8U0f6hZb0dSWL
 foZKyjSPLcbFe16eGwQRpneAENDb4aMHvH4Vc4HfJlB+jYPRGXZbxBpfVLERuKwryz1Rhh
 O7tMkuTVB8UfPHoQsi8PK0UyrKiWzFA=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-112-UPC5wQf2NsOazfw1-K5r4A-1; Tue, 20 Oct 2020 04:01:41 -0400
X-MC-Unique: UPC5wQf2NsOazfw1-K5r4A-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 222261868420;
 Tue, 20 Oct 2020 08:01:40 +0000 (UTC)
Received: from [10.72.13.171] (ovpn-13-171.pek2.redhat.com [10.72.13.171])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DEC7A5D9D2;
 Tue, 20 Oct 2020 08:01:34 +0000 (UTC)
Subject: Re: [External] Re: [RFC 0/4] Introduce VDUSE - vDPA Device in
 Userspace
To: Yongji Xie <xieyongji@bytedance.com>
References: <20201019145623.671-1-xieyongji@bytedance.com>
 <c1f8c9df-d5e1-437f-91ee-68f00ebfe2a2@redhat.com>
 <CACycT3srzADF63rotgHwfsqn5GJOCbXx+19Dcnw8HLyTGY_7Eg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <c83aad4f-8ac5-3279-0429-ae2154622fe5@redhat.com>
Date: Tue, 20 Oct 2020 16:01:32 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACycT3srzADF63rotgHwfsqn5GJOCbXx+19Dcnw8HLyTGY_7Eg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-mm@kvack.org, akpm@linux-foundation.org,
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

Ck9uIDIwMjAvMTAvMjAg5LiL5Y2IMzozOSwgWW9uZ2ppIFhpZSB3cm90ZToKPgo+Cj4gT24gVHVl
LCBPY3QgMjAsIDIwMjAgYXQgMTE6MjAgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bSAKPiA8bWFpbHRvOmphc293YW5nQHJlZGhhdC5jb20+PiB3cm90ZToKPgo+Cj4gICAgIE9uIDIw
MjAvMTAvMTkg5LiL5Y2IMTA6NTYsIFhpZSBZb25namkgd3JvdGU6Cj4gICAgID4gVGhpcyBzZXJp
ZXMgaW50cm9kdWNlcyBhIGZyYW1ld29yaywgd2hpY2ggY2FuIGJlIHVzZWQgdG8gaW1wbGVtZW50
Cj4gICAgID4gdkRQQSBEZXZpY2VzIGluIGEgdXNlcnNwYWNlIHByb2dyYW0uIFRvIGltcGxlbWVu
dCBpdCwgdGhlIHdvcmsKPiAgICAgPiBjb25zaXN0IG9mIHR3byBwYXJ0czogY29udHJvbCBwYXRo
IGVtdWxhdGluZyBhbmQgZGF0YSBwYXRoCj4gICAgIG9mZmxvYWRpbmcuCj4gICAgID4KPiAgICAg
PiBJbiB0aGUgY29udHJvbCBwYXRoLCB0aGUgVkRVU0UgZHJpdmVyIHdpbGwgbWFrZSB1c2Ugb2Yg
bWVzc2FnZQo+ICAgICA+IG1lY2huaXNtIHRvIGZvcndhcmQgdGhlIGFjdGlvbnMgKGdldC9zZXQg
ZmVhdHVyZXMsIGdldC9zdCBzdGF0dXMsCj4gICAgID4gZ2V0L3NldCBjb25maWcgc3BhY2UgYW5k
IHNldCB2aXJ0cXVldWUgc3RhdGVzKSBmcm9tIHZpcnRpby12ZHBhCj4gICAgID4gZHJpdmVyIHRv
IHVzZXJzcGFjZS4gVXNlcnNwYWNlIGNhbiB1c2UgcmVhZCgpL3dyaXRlKCkgdG8KPiAgICAgPiBy
ZWNlaXZlL3JlcGx5IHRvIHRob3NlIGNvbnRyb2wgbWVzc2FnZXMuCj4gICAgID4KPiAgICAgPiBJ
biB0aGUgZGF0YSBwYXRoLCB0aGUgVkRVU0UgZHJpdmVyIGltcGxlbWVudHMgYSBNTVUtYmFzZWQK
PiAgICAgPiBvbi1jaGlwIElPTU1VIGRyaXZlciB3aGljaCBzdXBwb3J0cyBib3RoIGRpcmVjdCBt
YXBwaW5nIGFuZAo+ICAgICA+IGluZGlyZWN0IG1hcHBpbmcgd2l0aCBib3VuY2UgYnVmZmVyLiBU
aGVuIHVzZXJzcGFjZSBjYW4gYWNjZXNzCj4gICAgID4gdGhvc2UgaW92YSBzcGFjZSB2aWEgbW1h
cCgpLiBCZXNpZGVzLCBldmVudGZkIG1lY2huaXNtIGlzIHVzZWQgdG8KPiAgICAgPiB0cmlnZ2Vy
IGludGVycnVwdHMgYW5kIGZvcndhcmQgdmlydHF1ZXVlIGtpY2tzLgo+Cj4KPiAgICAgVGhpcyBp
cyBwcmV0dHkgaW50ZXJlc3RpbmchCj4KPiAgICAgRm9yIHZob3N0LXZkcGEsIGl0IHNob3VsZCB3
b3JrLCBidXQgZm9yIHZpcnRpby12ZHBhLCBJIHRoaW5rIHdlCj4gICAgIHNob3VsZAo+ICAgICBj
YXJlZnVsbHkgZGVhbCB3aXRoIHRoZSBJT01NVS9ETUEgb3BzIHN0dWZmcy4KPgo+Cj4gICAgIEkg
bm90aWNlIHRoYXQgbmVpdGhlciBkbWFfbWFwIG5vciBzZXRfbWFwIGlzIGltcGxlbWVudGVkIGlu
Cj4gICAgIHZkdXNlX3ZkcGFfY29uZmlnX29wcywgdGhpcyBtZWFucyB5b3Ugd2FudCB0byBsZXQg
dmhvc3QtdkRQQSB0byBkZWFsCj4gICAgIHdpdGggSU9NTVUgZG9tYWlucyBzdHVmZnMuwqAgQW55
IHJlYXNvbiBmb3IgZG9pbmcgdGhhdD8KPgo+IEFjdHVhbGx5LCB0aGlzIHNlcmllcyBvbmx5IGZv
Y3VzIG9uIHZpcnRpby12ZHBhIGNhc2Ugbm93LiBUbyBzdXBwb3J0IAo+IHZob3N0LXZkcGEswqAg
YXMgeW91IHNhaWQsIHdlIG5lZWQgdG8gaW1wbGVtZW50IGRtYV9tYXAvZG1hX3VubWFwLiBCdXQg
Cj4gdGhlcmUgaXMgYSBsaW1pdCB0aGF0IHZtJ3MgbWVtb3J5IGNhbid0IGJlIGFub255bW91cyBw
YWdlcyB3aGljaCBhcmUgCj4gZm9yYmlkZGVuIGluIHZtX2luc2VydF9wYWdlKCkuIE1heWJlIHdl
IG5lZWQgdG8gYWRkIHNvbWUgbGltaXRzIG9uIAo+IHZob3N0LXZkcGE/CgoKSSdtIG5vdCBzdXJl
IEkgZ2V0IHRoaXMsIGFueSByZWFzb24gdGhhdCB5b3Ugd2FudCB0byB1c2UgCnZtX2luc2VydF9w
YWdlKCkgdG8gVk0ncyBtZW1vcnkuIE9yIGRvIHlvdSBtZWFuIHlvdSB3YW50IHRvIGltcGxlbWVu
dCAKc29tZSBraW5kIG9mIHplcm8tY29weT8KCkkgZ3Vlc3MgZnJvbSB0aGUgc29mdHdhcmUgZGV2
aWNlIGltcGxlbWVudGlvbiBpbiB1c2VyIHNwYWNlIGl0IG9ubHkgbmVlZCAKdG8gcmVjZWl2ZSBJ
T1ZBIHJhbmdlcyBhbmQgbWFwIHRoZW0gaW4gaXRzIG93biBhZGRyZXNzIHNwYWNlLgoKCj4gICAg
IFRoZSByZWFzb24gZm9yIHRoZSBxdWVzdGlvbnMgYXJlOgo+Cj4gICAgIDEpIFlvdSd2ZSBpbXBs
ZW1lbnRlZCBhIG9uLWNoaXAgSU9NTVUgZHJpdmVyIGJ1dCBkb24ndCBleHBvc2UgaXQgdG8KPiAg
ICAgZ2VuZXJpYyBJT01NVSBsYXllciAob3IgZ2VuZXJpYyBJT01NVSBsYXllciBtYXkgbmVlZCBz
b21lCj4gICAgIGV4dGVuc2lvbiB0bwo+ICAgICBzdXBwb3J0IHRoaXMpCj4gICAgIDIpIFdlIHdp
bGwgcHJvYmFibHkgcmVtb3ZlIHRoZSBJT01NVSBkb21haW4gbWFuYWdlbWVudCBpbiB2aG9zdC12
RFBBLAo+ICAgICBhbmQgbW92ZSBpdCB0byB0aGUgZGV2aWNlKHBhcmVudCkuCj4KPiAgICAgU28g
aWYgaXQncyBwb3NzaWJsZSwgcGxlYXNlIGltcGxlbWVudCBlaXRoZXIgc2V0X21hcCgpIG9yCj4g
ICAgIGRtYV9tYXAoKS9kbWFfdW5tYXAoKSwgdGhpcyBtYXkgYWxpZ24gd2l0aCBvdXIgZnV0dXJl
IGdvYWwgYW5kIG1heQo+ICAgICBzcGVlZAo+ICAgICB1cCB0aGUgZGV2ZWxvcG1lbnQuCj4KPiAg
ICAgQnR3LCBpdCB3b3VsZCBiZSBoZWxwZnVsIHRvIGdpdmUgZXZlbiBtb3JlIGRldGFpbHMgb24g
aG93IHRoZSBvbi1jaGlwCj4gICAgIElPTU1VIGRyaXZlciBpbiBpbXBsZW1lbnRlZC4KPgo+Cj4g
VGhlIGJhc2ljIGlkZWEgaXMgdHJlYXRpbmcgTU1VIChWQS0+UEEpIGFzIElPTU1VIChJT1ZBLT5Q
QSkuIEFuZCB1c2luZyAKPiB2bV9pbnNlcnRfcGFnZSgpL3phcF9wYWdlX3JhbmdlKCkgdG8gZG8g
YWRkcmVzcyBtYXBwaW5nL3VubWFwcGluZy4gQW5kIAo+IHRoZSBhZGRyZXNzIG1hcHBpbmcgd2ls
bCBiZSBkb25lIGluIHBhZ2UgZmF1bHQgaGFuZGxlciBiZWNhdXNlIAo+IHZtX2luc2VydF9wYWdl
KCkgY2FuJ3QgYmUgY2FsbGVkIGluIGF0b21pY19jb250ZXh0IHN1Y2ggCj4gYXPCoGRtYV9tYXBf
b3BzLT5tYXBfcGFnZSgpLgoKCk9rLCBwbGVhc2UgYWRkIGl0IGluIHRoZSBjb3ZlciBsZXR0ZXIg
b3IgcGF0Y2ggMiBpbiB0aGUgbmV4dCB2ZXJzaW9uLgoKCj4KPiAgICAgPgo+ICAgICA+IFRoZSBk
ZXRhaWxzIGFuZCBvdXIgdXNlciBjYXNlIGlzIHNob3duIGJlbG93Ogo+ICAgICA+Cj4gICAgID4g
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4gICAgIMKgLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgICAgPiB8wqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqAgQVBQIHzCoCDCoCDCoHwgUUVNVcKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgfAo+ICAgICA+IHzCoCDCoCDCoCDCoC0tLS0tLS0tLcKgIMKgIMKg
IHzCoCDCoCDCoHwgLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgICAgLS0tLS0tLS0tLS0tLS0tLS0t
LSs8LS0+Ky0tLS0tLSB8Cj4gICAgID4gfMKgIMKgIMKgIMKgfGRldi92ZHh8wqAgwqAgwqAgfMKg
IMKgIMKgfCB8IGRldmljZSBlbXVsYXRpb24gfCB8IHZpcnRpbwo+ICAgICBkYXRhcGxhbmUgfMKg
IMKgIHwgQkRTIHwgfAo+ICAgICA+IC0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLQo+ICAgICDCoC0t
LS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0tLS0tLS0tKy0tLS0t
Cj4gICAgID7CoCDCoCDCoCDCoCDCoCDCoCDCoCB8wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqAgwqAgwqAgwqB8IMKgIMKgIMKgIMKgIMKgfMKgIMKgIMKgIMKgIMKgIMKgCj4gICAgIMKg
IMKgIMKgfAo+ICAgICA+wqAgwqAgwqAgwqAgwqAgwqAgwqAgfMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgIMKgIMKgfCBlbXVsYXRpbmcgwqAgwqAgwqAgwqAgwqB8Cj4gICAgIG9m
ZmxvYWRpbmfCoCDCoCDCoCB8Cj4gICAgID4KPiAgICAgLS0tLS0tLS0tLS0tKy0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLSstLS0tLS0tLS0tLS0tLS0t
LSstLS0tLS0KPiAgICAgPiB8wqAgwqAgfCBibG9jayBkZXZpY2UgfMKgIMKgIMKgIMKgIMKgIMKg
fMKgIHZkdXNlIGRyaXZlciB8IMKgIHzCoCB2ZHBhCj4gICAgIGRldmljZSB8wqAgwqAgfCBUQ1Av
SVAgfCB8Cj4gICAgID4gfMKgIMKgIC0tLS0tLS0rLS0tLS0tLS3CoCDCoCDCoCDCoCDCoCDCoC0t
LS0tLS0tKy0tLS0tLS0tIMKgCj4gICAgICstLS0tLS0rLS0tLS0tLcKgIMKgIMKgLS0tLS0rLS0t
LSB8Cj4gICAgID4gfMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIMKgfCDCoCB8wqAgwqAgwqAgfMKgIMKgIMKgIMKgIMKgIMKgCj4gICAgIMKg
IMKgIMKgfMKgIMKgIMKgfAo+ICAgICA+IHzCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoCDCoCDCoCDC
oCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHwgwqAgfMKgIMKgIMKgIHzCoCDCoCDCoCDCoCDC
oCDCoAo+ICAgICDCoCDCoCDCoHzCoCDCoCDCoHwKPiAgICAgPiB8IC0tLS0tLS0tLS0rLS0tLS0t
LS0tLcKgIMKgIMKgIMKgLS0tLS0tLS0tLSstLS0tLS0tLS0tLSDCoHzCoCDCoCDCoCB8wqAKPiAg
ICAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAgwqB8Cj4gICAgID4gfCB8IHZpcnRpby1i
bGsgZHJpdmVyIHzCoCDCoCDCoCDCoHwgdmlydGlvLXZkcGEgZHJpdmVyIHwgwqB8wqAgwqAgwqAg
fMKgCj4gICAgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgfMKgIMKgIMKgfAo+ICAgICA+IHwgLS0t
LS0tLS0tLSstLS0tLS0tLS0twqAgwqAgwqAgwqAtLS0tLS0tLS0tKy0tLS0tLS0tLS0tIMKgfMKg
IMKgIMKgIHzCoAo+ICAgICDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoCDCoHwKPiAgICAg
PiB8wqAgwqAgwqAgwqAgwqAgwqB8wqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAgwqAg
wqAgwqB8IMKgIHzCoCDCoCDCoCB8wqAgwqAgwqAgwqAgwqAgwqAKPiAgICAgwqAgwqAgwqB8wqAg
wqAgwqB8Cj4gICAgID4gfMKgIMKgIMKgIMKgIMKgIMKgfCDCoC0tLS0tLS0tLS0tLS0tLS0tLcKg
IMKgIMKgIHzCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHzCoCDCoCDCoHwKPiAgICAgPiB8IMKg
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0gwqAg
wqAgwqAgwqAKPiAgICAgLS0tKy0tLcKgIHwKPiAgICAgPgo+ICAgICAtLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0KPiAgICAgfCBOSUMgfC0tLQo+ICAgICA+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgLS0tKy0tLQo+ICAgICA+IMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKgIMKg
IMKgIMKgIMKgIMKgIHwKPiAgICAgPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC0tLS0t
LS0tLSstLS0tLS0tLS0KPiAgICAgPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoHwgUmVt
b3RlIFN0b3JhZ2VzIHwKPiAgICAgPiDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoCDCoC0tLS0t
LS0tLS0tLS0tLS0tLS0KPgo+Cj4gICAgIFRoZSBmaWd1cmUgaXMgbm90IHZlcnkgY2xlYXIgdG8g
bWUgaW4gdGhlIGZvbGxvd2luZyBwb2ludHM6Cj4KPiAgICAgMSkgaWYgdGhlIGRldmljZSBlbXVs
YXRpb24gYW5kIHZpcnRpbyBkYXRhcGxhbmUgaXMgYWxsIGltcGxlbWVudGVkIGluCj4gICAgIFFF
TVUsIHdoYXQncyB0aGUgcG9pbnQgb2YgZG9pbmcgdGhpcz8gSSB0aG91Z2h0IHRoZSBkZXZpY2Ug
c2hvdWxkCj4gICAgIGJlIGEKPiAgICAgcmVtb3ZlIHByb2Nlc3M/Cj4KPiAgICAgMikgaXQgd291
bGQgYmUgYmV0dGVyIHRvIGRyYXcgYSB2RFBBIGJ1cyBzb21ld2hlcmUgdG8gaGVscCBwZW9wbGUg
dG8KPiAgICAgdW5kZXJzdGFuZCB0aGUgYXJjaGl0ZWN0dXJlCj4gICAgIDMpIGZvciB0aGUgIm9m
ZmxvYWRpbmciIEkgZ3Vlc3MgaXQgc2hvdWxkIGJlIGRvbmUgdmlydGlvCj4gICAgIHZob3N0LXZE
UEEsIHNvCj4gICAgIGl0J3MgYmV0dGVyIHRvIGRyYXcgYSB2aG9zdC12RFBBIGJsb2NrIHRoZXJl
Cj4KPgo+IFRoaXMgZmlndXJlIG9ubHkgc2hvd3MgdmlydGlvLXZkcGEgY2FzZSwgSSB3aWxsIHRh
a2Ugdmhvc3QtdmRwYSBjYXNlIAo+IGludG8gY29uc2lkZXJhdGlvbsKgaW4gbmV4dCB2ZXJzaW9u
LgoKClBsZWFzZSBkbyB0aGF0LCBvdGhlcndpc2UgdGhpcyBwcm9wb3NhbCBpcyBpbmNvbXBsZXRl
LgoKVGhhbmtzCgoKPgo+IFRoYW5rcywKPiBZb25namkKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
