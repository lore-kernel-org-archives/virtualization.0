Return-Path: <SRS0=5KLU=JN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	URIBL_RED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54E7DC433ED
	for <virtualization@archiver.kernel.org>; Fri, 16 Apr 2021 05:40:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F2E7A611AB
	for <virtualization@archiver.kernel.org>; Fri, 16 Apr 2021 05:40:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F2E7A611AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B6FF7400B8;
	Fri, 16 Apr 2021 05:40:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jIR5_2K-cWl7; Fri, 16 Apr 2021 05:40:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id DB2364012F;
	Fri, 16 Apr 2021 05:40:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9A557C000B;
	Fri, 16 Apr 2021 05:40:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F3DFC000A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 05:40:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 329E440E47
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 05:40:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GQOu--dtl0Vj
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 05:40:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 001EC404F4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Apr 2021 05:40:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618551601;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iXR+AvjVGuda7dQOFocgVCv8J9VhytFo6/uOxLJAmq8=;
 b=bHuiAapDUJBk0jCKIETWeFO3bvYefceLHqJHFNYnE1E9wvN90wEAGihHXH065OkfolM3rz
 VC74UB9gY/ETSZ1Ujl5pwSqvEPEgKCDBaf1R+ny0pgKFKNVaY0opCbGsa/TuTKBeXUaNn/
 G67A5mCgggO/94KROTOOIoLR5S5a514=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-257-lHWnn7OmOVy-u-w2jP_QdQ-1; Fri, 16 Apr 2021 01:40:00 -0400
X-MC-Unique: lHWnn7OmOVy-u-w2jP_QdQ-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6821F107ACC7;
 Fri, 16 Apr 2021 05:39:57 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-9.pek2.redhat.com
 [10.72.13.9])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 7EAD25D9C0;
 Fri, 16 Apr 2021 05:39:47 +0000 (UTC)
Subject: Re: [PATCH v6 10/10] Documentation: Add documentation for VDUSE
To: Yongji Xie <xieyongji@bytedance.com>
References: <20210331080519.172-1-xieyongji@bytedance.com>
 <20210331080519.172-11-xieyongji@bytedance.com>
 <YHb44R4HyLEUVSTF@stefanha-x1.localdomain>
 <CACycT3uNR+nZY5gY0UhPkeOyi7Za6XkX4b=hasuDcgqdc7fqfg@mail.gmail.com>
 <YHfo8pc7dIO9lNc3@stefanha-x1.localdomain>
 <80b31814-9e41-3153-7efb-c0c2fab44feb@redhat.com>
 <YHhP4i+yXgA2KkVJ@stefanha-x1.localdomain>
 <31aa139a-dd4e-ba8a-c671-a2a1c69c1ffc@redhat.com>
 <CACycT3u_qAE=D_ezLPU9SpXPMACErmpqpH5pMg0TZAb3CZVGdg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fab615ce-5e13-a3b3-3715-a4203b4ab010@redhat.com>
Date: Fri, 16 Apr 2021 13:39:45 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CACycT3u_qAE=D_ezLPU9SpXPMACErmpqpH5pMg0TZAb3CZVGdg@mail.gmail.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: Jens Axboe <axboe@kernel.dk>, Jonathan Corbet <corbet@lwn.net>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>,
 Christian Brauner <christian.brauner@canonical.com>, bcrl@kvack.org,
 viro@zeniv.linux.org.uk, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, Dan Carpenter <dan.carpenter@oracle.com>,
 =?UTF-8?Q?Mika_Penttil=c3=a4?= <mika.penttila@nextfour.com>
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

CuWcqCAyMDIxLzQvMTYg5LiK5Y2IMTE6MTksIFlvbmdqaSBYaWUg5YaZ6YGTOgo+IE9uIEZyaSwg
QXByIDE2LCAyMDIxIGF0IDEwOjI0IEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+
IHdyb3RlOgo+Pgo+PiDlnKggMjAyMS80LzE1IOS4i+WNiDEwOjM4LCBTdGVmYW4gSGFqbm9jemkg
5YaZ6YGTOgo+Pj4gT24gVGh1LCBBcHIgMTUsIDIwMjEgYXQgMDQ6MzY6MzVQTSArMDgwMCwgSmFz
b24gV2FuZyB3cm90ZToKPj4+PiDlnKggMjAyMS80LzE1IOS4i+WNiDM6MTksIFN0ZWZhbiBIYWpu
b2N6aSDlhpnpgZM6Cj4+Pj4+IE9uIFRodSwgQXByIDE1LCAyMDIxIGF0IDAxOjM4OjM3UE0gKzA4
MDAsIFlvbmdqaSBYaWUgd3JvdGU6Cj4+Pj4+PiBPbiBXZWQsIEFwciAxNCwgMjAyMSBhdCAxMDox
NSBQTSBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhhQHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+Pj4+
IE9uIFdlZCwgTWFyIDMxLCAyMDIxIGF0IDA0OjA1OjE5UE0gKzA4MDAsIFhpZSBZb25namkgd3Jv
dGU6Cj4+Pj4+Pj4+IFZEVVNFICh2RFBBIERldmljZSBpbiBVc2Vyc3BhY2UpIGlzIGEgZnJhbWV3
b3JrIHRvIHN1cHBvcnQKPj4+Pj4+Pj4gaW1wbGVtZW50aW5nIHNvZnR3YXJlLWVtdWxhdGVkIHZE
UEEgZGV2aWNlcyBpbiB1c2Vyc3BhY2UuIFRoaXMKPj4+Pj4+Pj4gZG9jdW1lbnQgaXMgaW50ZW5k
ZWQgdG8gY2xhcmlmeSB0aGUgVkRVU0UgZGVzaWduIGFuZCB1c2FnZS4KPj4+Pj4+Pj4KPj4+Pj4+
Pj4gU2lnbmVkLW9mZi1ieTogWGllIFlvbmdqaSA8eGlleW9uZ2ppQGJ5dGVkYW5jZS5jb20+Cj4+
Pj4+Pj4+IC0tLQo+Pj4+Pj4+PiAgICAgRG9jdW1lbnRhdGlvbi91c2Vyc3BhY2UtYXBpL2luZGV4
LnJzdCB8ICAgMSArCj4+Pj4+Pj4+ICAgICBEb2N1bWVudGF0aW9uL3VzZXJzcGFjZS1hcGkvdmR1
c2UucnN0IHwgMjEyICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPj4+Pj4+Pj4g
ICAgIDIgZmlsZXMgY2hhbmdlZCwgMjEzIGluc2VydGlvbnMoKykKPj4+Pj4+Pj4gICAgIGNyZWF0
ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL3VzZXJzcGFjZS1hcGkvdmR1c2UucnN0Cj4+Pj4+
Pj4gSnVzdCBsb29raW5nIG92ZXIgdGhlIGRvY3VtZW50YXRpb24gYnJpZWZseSAoSSBoYXZlbid0
IHN0dWRpZWQgdGhlIGNvZGUKPj4+Pj4+PiB5ZXQpLi4uCj4+Pj4+Pj4KPj4+Pj4+IFRoYW5rIHlv
dSEKPj4+Pj4+Cj4+Pj4+Pj4+ICtIb3cgVkRVU0Ugd29ya3MKPj4+Pj4+Pj4gKy0tLS0tLS0tLS0t
LQo+Pj4+Pj4+PiArRWFjaCB1c2Vyc3BhY2UgdkRQQSBkZXZpY2UgaXMgY3JlYXRlZCBieSB0aGUg
VkRVU0VfQ1JFQVRFX0RFViBpb2N0bCBvbgo+Pj4+Pj4+PiArdGhlIGNoYXJhY3RlciBkZXZpY2Ug
KC9kZXYvdmR1c2UvY29udHJvbCkuIFRoZW4gYSBkZXZpY2UgZmlsZSB3aXRoIHRoZQo+Pj4+Pj4+
PiArc3BlY2lmaWVkIG5hbWUgKC9kZXYvdmR1c2UvJE5BTUUpIHdpbGwgYXBwZWFyLCB3aGljaCBj
YW4gYmUgdXNlZCB0bwo+Pj4+Pj4+PiAraW1wbGVtZW50IHRoZSB1c2Vyc3BhY2UgdkRQQSBkZXZp
Y2UncyBjb250cm9sIHBhdGggYW5kIGRhdGEgcGF0aC4KPj4+Pj4+PiBUaGVzZSBzdGVwcyBhcmUg
dGFrZW4gYWZ0ZXIgc2VuZGluZyB0aGUgVkRQQV9DTURfREVWX05FVyBuZXRsaW5rCj4+Pj4+Pj4g
bWVzc2FnZT8gKFBsZWFzZSBjb25zaWRlciByZW9yZGVyaW5nIHRoZSBkb2N1bWVudGF0aW9uIHRv
IG1ha2UgaXQgY2xlYXIKPj4+Pj4+PiB3aGF0IHRoZSBzZXF1ZW5jZSBvZiBzdGVwcyBhcmUuKQo+
Pj4+Pj4+Cj4+Pj4+PiBObywgVkRVU0UgZGV2aWNlcyBzaG91bGQgYmUgY3JlYXRlZCBiZWZvcmUg
c2VuZGluZyB0aGUKPj4+Pj4+IFZEUEFfQ01EX0RFVl9ORVcgbmV0bGluayBtZXNzYWdlcyB3aGlj
aCBtaWdodCBwcm9kdWNlIEkvT3MgdG8gVkRVU0UuCj4+Pj4+IEkgc2VlLiBQbGVhc2UgaW5jbHVk
ZSBhbiBvdmVydmlldyBvZiB0aGUgc3RlcHMgYmVmb3JlIGdvaW5nIGludG8gZGV0YWlsLgo+Pj4+
PiBTb21ldGhpbmcgbGlrZToKPj4+Pj4KPj4+Pj4gICAgICBWRFVTRSBkZXZpY2VzIGFyZSBzdGFy
dGVkIGFzIGZvbGxvd3M6Cj4+Pj4+Cj4+Pj4+ICAgICAgMS4gQ3JlYXRlIGEgbmV3IFZEVVNFIGlu
c3RhbmNlIHdpdGggaW9jdGwoVkRVU0VfQ1JFQVRFX0RFVikgb24KPj4+Pj4gICAgICAgICAvZGV2
L3ZkdXNlL2NvbnRyb2wuCj4+Pj4+Cj4+Pj4+ICAgICAgMi4gQmVnaW4gcHJvY2Vzc2luZyBWRFVT
RSBtZXNzYWdlcyBmcm9tIC9kZXYvdmR1c2UvJE5BTUUuIFRoZSBmaXJzdAo+Pj4+PiAgICAgICAg
IG1lc3NhZ2VzIHdpbGwgYXJyaXZlIHdoaWxlIGF0dGFjaGluZyB0aGUgVkRVU0UgaW5zdGFuY2Ug
dG8gdkRQQS4KPj4+Pj4KPj4+Pj4gICAgICAzLiBTZW5kIHRoZSBWRFBBX0NNRF9ERVZfTkVXIG5l
dGxpbmsgbWVzc2FnZSB0byBhdHRhY2ggdGhlIFZEVVNFCj4+Pj4+ICAgICAgICAgaW5zdGFuY2Ug
dG8gdkRQQS4KPj4+Pj4KPj4+Pj4gICAgICBWRFVTRSBkZXZpY2VzIGFyZSBzdG9wcGVkIGFzIGZv
bGxvd3M6Cj4+Pj4+Cj4+Pj4+ICAgICAgLi4uCj4+Pj4+Cj4+Pj4+Pj4+ICsgICAgIHN0YXRpYyBp
bnQgbmV0bGlua19hZGRfdmR1c2UoY29uc3QgY2hhciAqbmFtZSwgaW50IGRldmljZV9pZCkKPj4+
Pj4+Pj4gKyAgICAgewo+Pj4+Pj4+PiArICAgICAgICAgICAgIHN0cnVjdCBubF9zb2NrICpubHNv
Y2s7Cj4+Pj4+Pj4+ICsgICAgICAgICAgICAgc3RydWN0IG5sX21zZyAqbXNnOwo+Pj4+Pj4+PiAr
ICAgICAgICAgICAgIGludCBmYW1pZDsKPj4+Pj4+Pj4gKwo+Pj4+Pj4+PiArICAgICAgICAgICAg
IG5sc29jayA9IG5sX3NvY2tldF9hbGxvYygpOwo+Pj4+Pj4+PiArICAgICAgICAgICAgIGlmICgh
bmxzb2NrKQo+Pj4+Pj4+PiArICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07Cj4+
Pj4+Pj4+ICsKPj4+Pj4+Pj4gKyAgICAgICAgICAgICBpZiAoZ2VubF9jb25uZWN0KG5sc29jaykp
Cj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICBnb3RvIGZyZWVfc29jazsKPj4+Pj4+Pj4g
Kwo+Pj4+Pj4+PiArICAgICAgICAgICAgIGZhbWlkID0gZ2VubF9jdHJsX3Jlc29sdmUobmxzb2Nr
LCBWRFBBX0dFTkxfTkFNRSk7Cj4+Pj4+Pj4+ICsgICAgICAgICAgICAgaWYgKGZhbWlkIDwgMCkK
Pj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgIGdvdG8gY2xvc2Vfc29jazsKPj4+Pj4+Pj4g
Kwo+Pj4+Pj4+PiArICAgICAgICAgICAgIG1zZyA9IG5sbXNnX2FsbG9jKCk7Cj4+Pj4+Pj4+ICsg
ICAgICAgICAgICAgaWYgKCFtc2cpCj4+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAgICBnb3Rv
IGNsb3NlX3NvY2s7Cj4+Pj4+Pj4+ICsKPj4+Pj4+Pj4gKyAgICAgICAgICAgICBpZiAoIWdlbmxt
c2dfcHV0KG1zZywgTkxfQVVUT19QT1JULCBOTF9BVVRPX1NFUSwgZmFtaWQsIDAsIDAsCj4+Pj4+
Pj4+ICsgICAgICAgICAgICAgICAgIFZEUEFfQ01EX0RFVl9ORVcsIDApKQo+Pj4+Pj4+PiArICAg
ICAgICAgICAgICAgICAgICAgZ290byBubGFfcHV0X2ZhaWx1cmU7Cj4+Pj4+Pj4+ICsKPj4+Pj4+
Pj4gKyAgICAgICAgICAgICBOTEFfUFVUX1NUUklORyhtc2csIFZEUEFfQVRUUl9ERVZfTkFNRSwg
bmFtZSk7Cj4+Pj4+Pj4+ICsgICAgICAgICAgICAgTkxBX1BVVF9TVFJJTkcobXNnLCBWRFBBX0FU
VFJfTUdNVERFVl9ERVZfTkFNRSwgInZkdXNlIik7Cj4+Pj4+Pj4+ICsgICAgICAgICAgICAgTkxB
X1BVVF9VMzIobXNnLCBWRFBBX0FUVFJfREVWX0lELCBkZXZpY2VfaWQpOwo+Pj4+Pj4+IFdoYXQg
YXJlIHRoZSBwZXJtaXNzaW9uL2NhcGFiaWxpdHkgcmVxdWlyZW1lbnRzIGZvciBWRFVTRT8KPj4+
Pj4+Pgo+Pj4+Pj4gTm93IEkgdGhpbmsgd2UgbmVlZCBwcml2aWxlZ2VkIHBlcm1pc3Npb24gKHJv
b3QgdXNlcikuIEJlY2F1c2UKPj4+Pj4+IHVzZXJzcGFjZSBkYWVtb24gaXMgYWJsZSB0byBhY2Nl
c3MgYXZhaWwgdnJpbmcsIHVzZWQgdnJpbmcsIGRlc2NyaXB0b3IKPj4+Pj4+IHRhYmxlIGluIGtl
cm5lbCBkcml2ZXIgZGlyZWN0bHkuCj4+Pj4+IFBsZWFzZSBzdGF0ZSB0aGlzIGV4cGxpY2l0bHkg
YXQgdGhlIHN0YXJ0IG9mIHRoZSBkb2N1bWVudC4gRXhpc3RpbmcKPj4+Pj4gaW50ZXJmYWNlcyBs
aWtlIEZVU0UgYXJlIGRlc2lnbmVkIHRvIGF2b2lkIHRydXN0aW5nIHVzZXJzcGFjZS4KPj4+PiBU
aGVyZSdyZSBzb21lIHN1YnRsZSBkaWZmZXJlbmNlIGhlcmUuIFZEVVNFIHByZXNlbnQgYSBkZXZp
Y2UgdG8ga2VybmVsIHdoaWNoCj4+Pj4gbWVhbnMgSU9NTVUgaXMgcHJvYmFibHkgdGhlIG9ubHkg
dGhpbmcgdG8gcHJldmVudCBhIG1hbGljb3VzIGRldmljZS4KPj4+Pgo+Pj4+Cj4+Pj4+IFRoZXJl
Zm9yZQo+Pj4+PiBwZW9wbGUgbWlnaHQgdGhpbmsgdGhlIHNhbWUgaXMgdGhlIGNhc2UgaGVyZS4g
SXQncyBjcml0aWNhbCB0aGF0IHBlb3BsZQo+Pj4+PiBhcmUgYXdhcmUgb2YgdGhpcyBiZWZvcmUg
ZGVwbG95aW5nIFZEVVNFIHdpdGggdmlydGlvLXZkcGEuCj4+Pj4+Cj4+Pj4+IFdlIHNob3VsZCBw
cm9iYWJseSBwYXVzZSBoZXJlIGFuZCB0aGluayBhYm91dCB3aGV0aGVyIGl0J3MgcG9zc2libGUg
dG8KPj4+Pj4gYXZvaWQgdHJ1c3RpbmcgdXNlcnNwYWNlLiBFdmVuIGlmIGl0IHRha2VzIHNvbWUg
ZWZmb3J0IGFuZCBjb3N0cyBzb21lCj4+Pj4+IHBlcmZvcm1hbmNlIGl0IHdvdWxkIHByb2JhYmx5
IGJlIHdvcnRod2hpbGUuCj4+Pj4gU2luY2UgdGhlIGJvdW5jZSBidWZmZXIgaXMgdXNlZCB0aGUg
b25seSBhdHRhY2sgc3VyZmFjZSBpcyB0aGUgY29oZXJlbnQKPj4+PiBhcmVhLCBpZiB3ZSB3YW50
IHRvIGVuZm9yY2Ugc3Ryb25nZXIgaXNvbGF0aW9uIHdlIG5lZWQgdG8gdXNlIHNoYWRvdwo+Pj4+
IHZpcnRxdWV1ZSAod2hpY2ggaXMgcHJvcG9zZWQgaW4gZWFybGllciB2ZXJzaW9uIGJ5IG1lKSBp
biB0aGlzIGNhc2UuIEJ1dCBJJ20KPj4+PiBub3Qgc3VyZSBpdCdzIHdvcnRoIHRvIGRvIHRoYXQu
Cj4+PiBUaGUgc2VjdXJpdHkgc2l0dWF0aW9uIG5lZWRzIHRvIGJlIGNsZWFyIGJlZm9yZSBtZXJn
aW5nIHRoaXMgZmVhdHVyZS4KPj4KPj4gKzEKPj4KPj4KPj4+IEkgdGhpbmsgdGhlIElPTU1VIGFu
ZCB2cmluZyBjYW4gYmUgbWFkZSBzZWN1cmUuIFdoYXQgaXMgbW9yZSBjb25jZXJuaW5nCj4+PiBp
cyB0aGUga2VybmVsIGNvZGUgdGhhdCBydW5zIG9uIHRvcDogVklSVElPIGRldmljZSBkcml2ZXJz
LCBuZXR3b3JrCj4+PiBzdGFjaywgZmlsZSBzeXN0ZW1zLCBldGMuIFRoZXkgdHJ1c3QgZGV2aWNl
cyB0byBhbiBleHRlbnQuCj4+Pgo+Pj4gU2luY2UgdmlydGlvLXZkcGEgaXMgYSBiaWcgcmVhc29u
IGZvciBkb2luZyBWRFVTRSBpbiB0aGUgZmlyc3QgcGxhY2UgSQo+Pj4gZG9uJ3QgdGhpbmsgaXQg
bWFrZXMgc2Vuc2UgdG8gZGlzYWJsZSB2aXJ0aW8tdmRwYSB3aXRoIFZEVVNFLiBBIHNvbHV0aW9u
Cj4+PiBpcyBuZWVkZWQuCj4+Cj4+IFllcywgc28gdGhlIGNhc2Ugb2YgVkRVU0UgaXMgc29tZXRo
aW5nIHNpbWlsYXIgdG8gdGhlIGNhc2Ugb2YgZS5nIFNFVi4KPj4KPj4gQm90aCBjYXNlcyB3b24n
dCB0cnVzdCBkZXZpY2UgYW5kIHVzZSBzb21lIGtpbmQgb2Ygc29mdHdhcmUgSU9UTEIuCj4+Cj4+
IFRoYXQgbWVhbnMgd2UgbmVlZCB0byBwcm90ZWN0IGF0IGJvdGggSU9UTEIgYW5kIHZpcnRpbyBk
cml2ZXJzLgo+Pgo+PiBMZXQgbWUgcG9zdCBwYXRjaGVzIGZvciB2aXJ0aW8gZmlyc3QuCj4+Cj4g
TG9va2luZyBmb3J3YXJkIHlvdXIgcGF0Y2hlcy4KPgo+IFRoYW5rcy4KPiBZb25namkKPgoKRm9y
dHVhbnRlbHksIHBhY2tlZCByaW5nIGhhcyBhbHJlYWR5IGRpZCB0aGlzIHNpbmNlIHRoZSBkZXNj
cmlwdG9yIHRhbGJlIAppcyBleHBlY3RlZCB0byBiZSByZS13cm90ZSBieSB0aGUgZGV2aWNlLiBJ
IGp1c3QgbmVlZCB0byBjb252ZXIgdGhlIApzcGxpdCByaW5nLgoKVGhhbmtzCgoKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
