Return-Path: <SRS0=p2bm=JS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D6A1C43461
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 07:41:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D8EEF61433
	for <virtualization@archiver.kernel.org>; Wed, 21 Apr 2021 07:41:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D8EEF61433
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 754F183DDF;
	Wed, 21 Apr 2021 07:41:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MpbYQpqUmZe0; Wed, 21 Apr 2021 07:41:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id F2F0583D37;
	Wed, 21 Apr 2021 07:41:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CC630C000F;
	Wed, 21 Apr 2021 07:41:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 001A6C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 07:41:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D41AE40249
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 07:41:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8yBvImdQwlG3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 07:41:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1AF3040245
 for <virtualization@lists.linux-foundation.org>;
 Wed, 21 Apr 2021 07:41:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618990907;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2yN6XcKhbSauKK4BfJl008OKCv6/B7lbDp7G8UqJ3nU=;
 b=GEWhoFtNlyeKBJkug3WVdDF01BdKnbWYD1GwRWqdAHHZdYQZWoZt0B6kDMeD+wgyyTPAHx
 3pre2kkh6KUqP4cddDSLovCM8BPzr2mKVctLNQuaW0UFOwNyMWDyW7ehHXKgf/GEfT5dIH
 wGzqwaQFegbFPn/E/pewWlZ+5gR1vUY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-XujTHFoeOWm6cWS6FymcKA-1; Wed, 21 Apr 2021 03:41:45 -0400
X-MC-Unique: XujTHFoeOWm6cWS6FymcKA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com
 [10.5.11.12])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 64A691B2C980;
 Wed, 21 Apr 2021 07:41:44 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-189.pek2.redhat.com
 [10.72.13.189])
 by smtp.corp.redhat.com (Postfix) with ESMTP id CE94A60C5F;
 Wed, 21 Apr 2021 07:41:38 +0000 (UTC)
Subject: Re: [RFC PATCH] vdpa: mandate 1.0 device
From: Jason Wang <jasowang@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20210408082648.20145-1-jasowang@redhat.com>
 <20210408115834-mutt-send-email-mst@kernel.org>
 <a6a4ab68-c958-7266-c67c-142960222b67@redhat.com>
 <20210409115343-mutt-send-email-mst@kernel.org>
 <42891807-cb24-5352-f8cb-798e9d1a1854@redhat.com>
 <20210412050730-mutt-send-email-mst@kernel.org>
 <01918e14-7f7a-abf2-5864-292a32f0233c@redhat.com>
Message-ID: <d5632a4d-4d0b-b08d-06f9-c56f16734607@redhat.com>
Date: Wed, 21 Apr 2021 15:41:36 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <01918e14-7f7a-abf2-5864-292a32f0233c@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Cc: elic@nvidia.com, linux-kernel@vger.kernel.org, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>, virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIxLzQvMTIg5LiL5Y2INToyMywgSmFzb24gV2FuZyDlhpnpgZM6Cj4KPiDlnKggMjAy
MS80LzEyIOS4i+WNiDU6MDksIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4+IE9uIE1vbiwg
QXByIDEyLCAyMDIxIGF0IDAyOjM1OjA3UE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+PiDl
nKggMjAyMS80LzEwIOS4iuWNiDEyOjA0LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+Pj4+
IE9uIEZyaSwgQXByIDA5LCAyMDIxIGF0IDEyOjQ3OjU1UE0gKzA4MDAsIEphc29uIFdhbmcgd3Jv
dGU6Cj4+Pj4+IOWcqCAyMDIxLzQvOCDkuIvljYgxMTo1OSwgTWljaGFlbCBTLiBUc2lya2luIOWG
memBkzoKPj4+Pj4+IE9uIFRodSwgQXByIDA4LCAyMDIxIGF0IDA0OjI2OjQ4UE0gKzA4MDAsIEph
c29uIFdhbmcgd3JvdGU6Cj4+Pj4+Pj4gVGhpcyBwYXRjaCBtYW5kYXRlcyAxLjAgZm9yIHZEUEEg
ZGV2aWNlcy4gVGhlIGdvYWwgaXMgdG8gaGF2ZSB0aGUKPj4+Pj4+PiBzZW1hbnRpYyBvZiBub3Jt
YXRpdmUgc3RhdGVtZW50IGluIHRoZSB2aXJ0aW8gc3BlYyBhbmQgZWxpbWluYXRlIAo+Pj4+Pj4+
IHRoZQo+Pj4+Pj4+IGJ1cmRlbiBvZiB0cmFuc2l0aW9uYWwgZGV2aWNlIGZvciBib3RoIHZEUEEg
YnVzIGFuZCB2RFBBIHBhcmVudC4KPj4+Pj4+Pgo+Pj4+Pj4+IHVBUEkgc2VlbXMgZmluZSBzaW5j
ZSBhbGwgdGhlIHZEUEEgcGFyZW50IG1hbmRhdGVzCj4+Pj4+Pj4gVklSVElPX0ZfQUNDRVNTX1BM
QVRGT1JNIHdoaWNoIGltcGxpZXMgMS4wIGRldmljZXMuCj4+Pj4+Pj4KPj4+Pj4+PiBGb3IgbGVn
YWN5IGd1ZXN0cywgaXQgY2FuIHN0aWxsIHdvcmsgc2luY2UgUWVtdSB3aWxsIG1lZGlhdGUgd2hl
bgo+Pj4+Pj4+IG5lY2Vzc2FyeSAoZS5nIGRvaW5nIHRoZSBlbmRpYW4gY29udmVyc2lvbikuCj4+
Pj4+Pj4KPj4+Pj4+PiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQu
Y29tPgo+Pj4+Pj4gSG1tLiBJZiB3ZSBkbyB0aGlzLCBkb24ndCB3ZSBzdGlsbCBoYXZlIGEgcHJv
YmxlbSB3aXRoCj4+Pj4+PiBsZWdhY3kgZHJpdmVycyB3aGljaCBkb24ndCBhY2sgMS4wPwo+Pj4+
PiBZZXMsIGJ1dCBpdCdzIG5vdCBzb21ldGhpbmcgdGhhdCBpcyBpbnRyb2R1Y2VkIGluIHRoaXMg
Y29tbWl0LiBUaGUgCj4+Pj4+IGxlZ2FjeQo+Pj4+PiBkcml2ZXIgbmV2ZXIgd29yayAuLi4KPj4+
PiBNeSBwb2ludCBpcyB0aGlzIG5laXRoZXIgZml4ZXMgb3IgcHJldmVudHMgdGhpcy4KPj4+Pgo+
Pj4+IFNvIG15IHN1Z2dlc3Rpb24gaXMgdG8gZmluYWxseSBhZGQgaW9jdGxzIGFsb25nIHRoZSBs
aW5lcwo+Pj4+IG9mIFBST1RPQ09MX0ZFQVRVUkVTIG9mIHZob3N0LXVzZXIuCj4+Pj4KPj4+PiBU
aGVuIHRoYXQgb25lIGNhbiBoYXZlIGJpdHMgZm9yIGxlZ2FjeSBsZSwgbGVnYWN5IGJlIGFuZCBt
b2Rlcm4uCj4+Pj4KPj4+PiBCVFcgSSBsb29rZWQgYXQgdmhvc3QtdXNlciBhbmQgaXQgZG9lcyBu
b3QgbG9vayBsaWtlIHRoYXQKPj4+PiBoYXMgYSBzb2x1dGlvbiBmb3IgdGhpcyBwcm9ibGVtIGVp
dGhlciwgcmlnaHQ/Cj4+Pgo+Pj4gUmlnaHQuCj4+Pgo+Pj4KPj4+Pgo+Pj4+Pj4gTm90ZSAxLjAg
YWZmZWN0cyByaW5nIGVuZGlhbm5lc3Mgd2hpY2ggaXMgbm90IG1lZGlhdGVkIGluIFFFTVUKPj4+
Pj4+IHNvIFFFTVUgY2FuJ3QgcHJldGVuZCB0byBkZXZpY2UgZ3Vlc3QgaXMgMS4wLgo+Pj4+PiBS
aWdodCwgSSBwbGFuIHRvIHNlbmQgcGF0Y2hlcyB0byBkbyBtZWRpYXRpb24gaW4gdGhlIFFlbXUg
dG8gCj4+Pj4+IHVuYnJlYWsgbGVnYWN5Cj4+Pj4+IGRyaXZlcnMuCj4+Pj4+Cj4+Pj4+IFRoYW5r
cwo+Pj4+IEkgZnJhbmtseSB0aGluayB3ZSdsbCBuZWVkIFBST1RPQ09MX0ZFQVRVUkVTIGFueXdh
eSwgaXQncyB0b28gCj4+Pj4gdXNlZnVsIC4uLgo+Pj4+IHNvIHdoeSBub3QgdGVhY2ggZHJpdmVy
cyBhYm91dCBpdCBhbmQgYmUgZG9uZSB3aXRoIGl0PyBZb3UgY2FuJ3QgCj4+Pj4gZW11bGF0ZQo+
Pj4+IGxlZ2FjeSBvbiBtb2Rlcm4gaW4gYSBjcm9zcyBlbmRpYW4gc2l0dWF0aW9uIGJlY2F1c2Ug
b2YgdnJpbmcKPj4+PiBlbmRpYW4tbmVzcyAuLi4KPj4+Cj4+PiBTbyB0aGUgcHJvYmxlbSBzdGls
bC4gVGhpcyBjYW4gb25seSB3b3JrIHdoZW4gdGhlIGhhcmR3YXJlIGNhbiBzdXBwb3J0Cj4+PiBs
ZWdhY3kgdnJpbmcgZW5kaWFuLW5lc3MuCj4+Pgo+Pj4gQ29uc2lkZXI6Cj4+Pgo+Pj4gMSkgdGhl
IGxlYWdjeSBkcml2ZXIgc3VwcG9ydCBpcyBub24tbm9ybWF0aXZlIGluIHRoZSBzcGVjCj4+PiAy
KSBzdXBwb3J0IGEgdHJhbnNpdGlvbmFsIGRldmljZSBpbiB0aGUga2VucmVsIG1heSByZXF1aXJl
cyB0aGUgCj4+PiBoYXJkd2FyZQo+Pj4gc3VwcG9ydCBhbmQgYSBidXJkZW4gb2Yga2VybmVsIGNv
ZGVzCj4+Pgo+Pj4gSSdkIHJhdGhlciBzaW1wbHkgZHJvcCB0aGUgbGVnYWN5IGRyaXZlciBzdXBw
b3J0Cj4+Cj4+IE15IHBvaW50IGlzIHRoaXMgcGF0Y2ggZG9lcyBub3QgZHJvcCBsZWdhY3kgc3Vw
cG9ydC4gSXQgbWVyZWx5IG1hbmRhdGVzCj4+IG1vZGVybiBzdXBwb3J0Lgo+Cj4KPiBJIGFtIG5v
dCBzdXJlIEkgZ2V0IGhlcmUuIFRoaXMgcGF0Y2ggZmFpbHMgdGhlIHNldF9mZWF0dXJlIGlmIAo+
IFZFUlNJT05fMSBpcyBub3QgbmVnb3RpYXRlZC4gVGhpcyBtZWFuczoKPgo+IDEpIHZEUEEgcHJl
c2VudHMgYSBtb2Rlcm4gZGV2aWNlIGluc3RlYWQgb2YgdHJhbnNpdG9uYWwgZGV2aWNlCj4gMikg
bGVnYWN5IGRyaXZlciBjYW4ndCBiZSBwcm9iZWQKPgo+IFdoYXQgSSdtIG1pc3Npbmc/CgoKSGkg
TWljaGFlbDoKCkRvIHlvdSBhZ3JlZSB0byBmaW5kIHRoZSB3YXkgdG8gcHJlc2VudCBtb2Rlcm4g
ZGV2aWNlPyBXZSBuZWVkIGEgCmNvbmNsdXNpb24gdG8gbWFrZSB0aGUgbmV0bGluayBBUEkgd29y
ayB0byBtb3ZlIGZvcndhcmQuCgpUaGFua3MKCgo+Cj4KPj4KPj4+IHRvIGhhdmUgYSBzaW1wbGUg
YW5kIGVhc3kKPj4+IGFic3RhcmN0aW9uIGluIHRoZSBrZW5yZWwuIEZvciBsZWdhY3kgZHJpdmVy
IGluIHRoZSBndWVzdCwgCj4+PiBoeXBlcnZpc29yIGlzIGluCj4+PiBjaGFyZ2Ugb2YgdGhlIG1l
ZGlhdGlvbjoKPj4+Cj4+PiAxKSBjb25maWcgc3BhY2UgYWNjZXNzIGVuZGlhbiBjb252ZXJzaW9u
Cj4+PiAyKSB1c2luZyBzaGFkb3cgdmlydHF1ZXVlIHRvIGNoYW5nZSB0aGUgZW5kaWFuIGluIHRo
ZSB2cmluZwo+Pj4KPj4+IFRoYW5rcwo+PiBJJ2QgbGlrZSB0byBhdm9pZCBzaGFkb3cgdmlydHF1
ZXVlIGhhY2tzIGlmIGF0IGFsbCBwb3NzaWJsZS4KPj4gTGFzdCBJIGNoZWNrZWQgcGVyZm9ybWFu
Y2Ugd2Fzbid0IG11Y2ggYmV0dGVyIHRoYW4ganVzdCBlbXVsYXRpbmcKPj4gdmlydGlvIGluIHNv
ZnR3YXJlLgo+Cj4KPiBJIHRoaW5rIHRoZSBsZWdhY3kgZHJpdmVyIHN1cHBvcnQgaXMganVzdCBh
IG5pY2UgdG8gaGF2ZS4gT3IgZG8geW91IAo+IHNlZSBhbnkgdmFsdWUgdG8gdGhhdD8gSSBndWVz
cyBmb3IgbWVsbGFub3ggYW5kIGludGVsLCBvbmx5IG1vZGVybiAKPiBkZXZpY2UgaXMgc3VwcG9y
dGVkIGluIHRoZSBoYXJkd2FyZS4KPgo+IFRoYW5rcwo+Cj4KPj4KPj4+Pgo+Pj4+Pj4KPj4+Pj4+
Cj4+Pj4+Pgo+Pj4+Pj4+IC0tLQo+Pj4+Pj4+IMKgwqDCoCBpbmNsdWRlL2xpbnV4L3ZkcGEuaCB8
IDYgKysrKysrCj4+Pj4+Pj4gwqDCoMKgIDEgZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKykK
Pj4+Pj4+Pgo+Pj4+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaCBiL2luY2x1
ZGUvbGludXgvdmRwYS5oCj4+Pj4+Pj4gaW5kZXggMGZlZmViOTc2ODc3Li5jZmRlNGVjOTk5YjQg
MTAwNjQ0Cj4+Pj4+Pj4gLS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgKPj4+Pj4+PiArKysgYi9p
bmNsdWRlL2xpbnV4L3ZkcGEuaAo+Pj4+Pj4+IEBAIC02LDYgKzYsNyBAQAo+Pj4+Pj4+IMKgwqDC
oCAjaW5jbHVkZSA8bGludXgvZGV2aWNlLmg+Cj4+Pj4+Pj4gwqDCoMKgICNpbmNsdWRlIDxsaW51
eC9pbnRlcnJ1cHQuaD4KPj4+Pj4+PiDCoMKgwqAgI2luY2x1ZGUgPGxpbnV4L3Zob3N0X2lvdGxi
Lmg+Cj4+Pj4+Pj4gKyNpbmNsdWRlIDx1YXBpL2xpbnV4L3ZpcnRpb19jb25maWcuaD4KPj4+Pj4+
PiDCoMKgwqAgLyoqCj4+Pj4+Pj4gwqDCoMKgwqAgKiB2RFBBIGNhbGxiYWNrIGRlZmluaXRpb24u
Cj4+Pj4+Pj4gQEAgLTMxNyw2ICszMTgsMTEgQEAgc3RhdGljIGlubGluZSBpbnQgdmRwYV9zZXRf
ZmVhdHVyZXMoc3RydWN0IAo+Pj4+Pj4+IHZkcGFfZGV2aWNlICp2ZGV2LCB1NjQgZmVhdHVyZXMp
Cj4+Pj4+Pj4gwqDCoMKgIHsKPj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGNvbnN0IHN0
cnVjdCB2ZHBhX2NvbmZpZ19vcHMgKm9wcyA9IHZkZXYtPmNvbmZpZzsKPj4+Pj4+PiArwqDCoMKg
wqDCoMKgwqAgLyogTWFuZGF0aW5nIDEuMCB0byBoYXZlIHNlbWFudGljcyBvZiBub3JtYXRpdmUg
Cj4+Pj4+Pj4gc3RhdGVtZW50cyBpbgo+Pj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgICogdGhlIHNw
ZWMuICovCj4+Pj4+Pj4gK8KgwqDCoMKgwqDCoMKgIGlmICghKGZlYXR1cmVzICYgQklUX1VMTChW
SVJUSU9fRl9WRVJTSU9OXzEpKSkKPj4+Pj4+PiArwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5W
QUw7Cj4+Pj4+Pj4gKwo+Pj4+Pj4+IMKgwqDCoMKgwqDCoMKgIHZkZXYtPmZlYXR1cmVzX3ZhbGlk
ID0gdHJ1ZTsKPj4+Pj4+PiDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHJldHVybiBvcHMtPnNldF9m
ZWF0dXJlcyh2ZGV2LCBmZWF0dXJlcyk7Cj4+Pj4+Pj4gwqDCoMKgIH0KPj4+Pj4+PiAtLSAKPj4+
Pj4+PiAyLjI1LjEKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
