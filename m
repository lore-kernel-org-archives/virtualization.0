Return-Path: <SRS0=OwTx=BQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA130C433E0
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 03:23:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8AAAF20792
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 03:23:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Vuz1tDZM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 8AAAF20792
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 53C5A8817F;
	Thu,  6 Aug 2020 03:23:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XdZBaxqq-umm; Thu,  6 Aug 2020 03:23:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7F5D988198;
	Thu,  6 Aug 2020 03:23:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 75C80C0051;
	Thu,  6 Aug 2020 03:23:58 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D27F1C004C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 03:23:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BCE3A887E9
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 03:23:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id A7P1W+-S9yZD
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 03:23:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 94EFA88680
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 03:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596684233;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=F6EdwxxPxToRlRVjg4VjqE/IKz5jwoBOjp4Hl0tx224=;
 b=Vuz1tDZMkuZyWgHcrEt8ZfKScuHd91XHts20uESSnjwZb3m/HmXK3QET3cIgQmnfOQtptt
 ePc1Gj0+/ayDmSvYwe9BtlRqfFELVVWwN4drln7OsPxWuqxnMZ5hL3eGMg7hAe8vD+RnRW
 n8MPxmGYQ6YwYXU3wj7gidSA9gtllXc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-q58d4V6iNR67iVGqe8xPng-1; Wed, 05 Aug 2020 23:23:52 -0400
X-MC-Unique: q58d4V6iNR67iVGqe8xPng-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3023358;
 Thu,  6 Aug 2020 03:23:51 +0000 (UTC)
Received: from [10.72.13.140] (ovpn-13-140.pek2.redhat.com [10.72.13.140])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DB2335D9E2;
 Thu,  6 Aug 2020 03:23:46 +0000 (UTC)
Subject: Re: [PATCH v2 22/24] vdpa_sim: fix endian-ness of config space
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-23-mst@redhat.com>
 <dd24f2e6-4aef-4a26-374c-2349fe1e6a66@redhat.com>
 <20200805080434-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0ad1b5e6-52a8-aa4c-ec5f-a44a5727d84d@redhat.com>
Date: Thu, 6 Aug 2020 11:23:45 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200805080434-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjAvOC81IOS4i+WNiDg6MDYsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBPbiBX
ZWQsIEF1ZyAwNSwgMjAyMCBhdCAwMjoyMTowN1BNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+
PiBPbiAyMDIwLzgvNCDkuIrljYg1OjAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+PiBW
RFBBIHNpbSBhY2Nlc3NlcyBjb25maWcgc3BhY2UgYXMgbmF0aXZlIGVuZGlhbiAtIHRoaXMgaXMK
Pj4+IHdyb25nIHNpbmNlIGl0J3MgYSBtb2Rlcm4gZGV2aWNlIGFuZCBhY3R1YWxseSB1c2VzIExF
Lgo+Pj4KPj4+IEl0IG9ubHkgc3VwcG9ydHMgbW9kZXJuIGd1ZXN0cyBzbyB3ZSBjb3VsZCBwdW50
IGFuZAo+Pj4ganVzdCBmb3JjZSBMRSwgYnV0IGxldCdzIHVzZSB0aGUgZnVsbCB2aXJ0aW8gQVBJ
cyBzaW5jZSBwZW9wbGUKPj4+IHRlbmQgdG8gY29weS9wYXN0ZSBjb2RlLCBhbmQgdGhpcyBpcyBu
b3QgZGF0YSBwYXRoIGFueXdheS4KPj4+Cj4+PiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFMuIFRz
aXJraW48bXN0QHJlZGhhdC5jb20+Cj4+PiAtLS0KPj4+ICAgIGRyaXZlcnMvdmRwYS92ZHBhX3Np
bS92ZHBhX3NpbS5jIHwgMzEgKysrKysrKysrKysrKysrKysrKysrKysrKystLS0tLQo+Pj4gICAg
MSBmaWxlIGNoYW5nZWQsIDI2IGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4+Pgo+Pj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jIGIvZHJpdmVycy92
ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPj4+IGluZGV4IGE5YmM1ZTBmYjM1My4uZmEwNWUwNjVm
ZjY5IDEwMDY0NAo+Pj4gLS0tIGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPj4+
ICsrKyBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4+PiBAQCAtMjQsNiArMjQs
NyBAQAo+Pj4gICAgI2luY2x1ZGUgPGxpbnV4L2V0aGVyZGV2aWNlLmg+Cj4+PiAgICAjaW5jbHVk
ZSA8bGludXgvdnJpbmdoLmg+Cj4+PiAgICAjaW5jbHVkZSA8bGludXgvdmRwYS5oPgo+Pj4gKyNp
bmNsdWRlIDxsaW51eC92aXJ0aW9fYnl0ZW9yZGVyLmg+Cj4+PiAgICAjaW5jbHVkZSA8bGludXgv
dmhvc3RfaW90bGIuaD4KPj4+ICAgICNpbmNsdWRlIDx1YXBpL2xpbnV4L3ZpcnRpb19jb25maWcu
aD4KPj4+ICAgICNpbmNsdWRlIDx1YXBpL2xpbnV4L3ZpcnRpb19uZXQuaD4KPj4+IEBAIC03Miw2
ICs3MywyMyBAQCBzdHJ1Y3QgdmRwYXNpbSB7Cj4+PiAgICAJdTY0IGZlYXR1cmVzOwo+Pj4gICAg
fTsKPj4+ICsvKiBUT0RPOiBjcm9zcy1lbmRpYW4gc3VwcG9ydCAqLwo+Pj4gK3N0YXRpYyBpbmxp
bmUgYm9vbCB2ZHBhc2ltX2lzX2xpdHRsZV9lbmRpYW4oc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0p
Cj4+PiArewo+Pj4gKwlyZXR1cm4gdmlydGlvX2xlZ2FjeV9pc19saXR0bGVfZW5kaWFuKCkgfHwK
Pj4+ICsJCSh2ZHBhc2ltLT5mZWF0dXJlcyAmICgxVUxMIDw8IFZJUlRJT19GX1ZFUlNJT05fMSkp
Owo+Pj4gK30KPj4+ICsKPj4+ICtzdGF0aWMgaW5saW5lIHUxNiB2ZHBhc2ltMTZfdG9fY3B1KHN0
cnVjdCB2ZHBhc2ltICp2ZHBhc2ltLCBfX3ZpcnRpbzE2IHZhbCkKPj4+ICt7Cj4+PiArCXJldHVy
biBfX3ZpcnRpbzE2X3RvX2NwdSh2ZHBhc2ltX2lzX2xpdHRsZV9lbmRpYW4odmRwYXNpbSksIHZh
bCk7Cj4+PiArfQo+Pj4gKwo+Pj4gK3N0YXRpYyBpbmxpbmUgX192aXJ0aW8xNiBjcHVfdG9fdmRw
YXNpbTE2KHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltLCB1MTYgdmFsKQo+Pj4gK3sKPj4+ICsJcmV0
dXJuIF9fY3B1X3RvX3ZpcnRpbzE2KHZkcGFzaW1faXNfbGl0dGxlX2VuZGlhbih2ZHBhc2ltKSwg
dmFsKTsKPj4+ICt9Cj4+PiArCj4+PiAgICBzdGF0aWMgc3RydWN0IHZkcGFzaW0gKnZkcGFzaW1f
ZGV2Owo+Pj4gICAgc3RhdGljIHN0cnVjdCB2ZHBhc2ltICp2ZHBhX3RvX3NpbShzdHJ1Y3QgdmRw
YV9kZXZpY2UgKnZkcGEpCj4+PiBAQCAtMzA2LDcgKzMyNCw2IEBAIHN0YXRpYyBjb25zdCBzdHJ1
Y3QgdmRwYV9jb25maWdfb3BzIHZkcGFzaW1fbmV0X2NvbmZpZ19vcHM7Cj4+PiAgICBzdGF0aWMg
c3RydWN0IHZkcGFzaW0gKnZkcGFzaW1fY3JlYXRlKHZvaWQpCj4+PiAgICB7Cj4+PiAtCXN0cnVj
dCB2aXJ0aW9fbmV0X2NvbmZpZyAqY29uZmlnOwo+Pj4gICAgCXN0cnVjdCB2ZHBhc2ltICp2ZHBh
c2ltOwo+Pj4gICAgCXN0cnVjdCBkZXZpY2UgKmRldjsKPj4+ICAgIAlpbnQgcmV0ID0gLUVOT01F
TTsKPj4+IEBAIC0zMzEsMTAgKzM0OCw3IEBAIHN0YXRpYyBzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNp
bV9jcmVhdGUodm9pZCkKPj4+ICAgIAlpZiAoIXZkcGFzaW0tPmJ1ZmZlcikKPj4+ICAgIAkJZ290
byBlcnJfaW9tbXU7Cj4+PiAtCWNvbmZpZyA9ICZ2ZHBhc2ltLT5jb25maWc7Cj4+PiAtCWNvbmZp
Zy0+bXR1ID0gMTUwMDsKPj4+IC0JY29uZmlnLT5zdGF0dXMgPSBWSVJUSU9fTkVUX1NfTElOS19V
UDsKPj4+IC0JZXRoX3JhbmRvbV9hZGRyKGNvbmZpZy0+bWFjKTsKPj4+ICsJZXRoX3JhbmRvbV9h
ZGRyKHZkcGFzaW0tPmNvbmZpZy5tYWMpOwo+Pj4gICAgCXZyaW5naF9zZXRfaW90bGIoJnZkcGFz
aW0tPnZxc1swXS52cmluZywgdmRwYXNpbS0+aW9tbXUpOwo+Pj4gICAgCXZyaW5naF9zZXRfaW90
bGIoJnZkcGFzaW0tPnZxc1sxXS52cmluZywgdmRwYXNpbS0+aW9tbXUpOwo+Pj4gQEAgLTQ0OCw2
ICs0NjIsNyBAQCBzdGF0aWMgdTY0IHZkcGFzaW1fZ2V0X2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2Rl
dmljZSAqdmRwYSkKPj4+ICAgIHN0YXRpYyBpbnQgdmRwYXNpbV9zZXRfZmVhdHVyZXMoc3RydWN0
IHZkcGFfZGV2aWNlICp2ZHBhLCB1NjQgZmVhdHVyZXMpCj4+PiAgICB7Cj4+PiAgICAJc3RydWN0
IHZkcGFzaW0gKnZkcGFzaW0gPSB2ZHBhX3RvX3NpbSh2ZHBhKTsKPj4+ICsJc3RydWN0IHZpcnRp
b19uZXRfY29uZmlnICpjb25maWcgPSAmdmRwYXNpbS0+Y29uZmlnOwo+Pj4gICAgCS8qIERNQSBt
YXBwaW5nIG11c3QgYmUgZG9uZSBieSBkcml2ZXIgKi8KPj4+ICAgIAlpZiAoIShmZWF0dXJlcyAm
ICgxVUxMIDw8IFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSkpKQo+Pj4gQEAgLTQ1NSw2ICs0NzAs
MTIgQEAgc3RhdGljIGludCB2ZHBhc2ltX3NldF9mZWF0dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2Ug
KnZkcGEsIHU2NCBmZWF0dXJlcykKPj4+ICAgIAl2ZHBhc2ltLT5mZWF0dXJlcyA9IGZlYXR1cmVz
ICYgdmRwYXNpbV9mZWF0dXJlczsKPj4+ICsJLyogV2Ugb25seSBrbm93IHdoZXRoZXIgZ3Vlc3Qg
aXMgdXNpbmcgdGhlIGxlZ2FjeSBpbnRlcmZhY2UgaGVyZSwgc28KPj4+ICsJICogdGhhdCdzIHRo
ZSBlYXJsaWVzdCB3ZSBjYW4gc2V0IGNvbmZpZyBmaWVsZHMuCj4+PiArCSAqLwo+PiBXZSBjaGVj
ayB3aGV0aGVyIG9yIG5vdCBBQ0NFU1NfUExBVEZPUk0gaXMgc2V0IGJlZm9yZSB3aGljaCBpcyBw
cm9iYWJseSBhCj4+IGhpbnQgdGhhdCBvbmx5IG1vZGVybiBkZXZpY2UgaXMgc3VwcG9ydGVkLiBT
byBJIHdvbmRlciBqdXN0IGZvcmNlIExFIGFuZAo+PiBmYWlsIGlmIFZFUlNJT05fMSBpcyBub3Qg
c2V0IGlzIGJldHRlcj8KPj4KPj4gVGhhbmtzCj4gU28gaG93IGFib3V0IEkgYWRkIGEgY29tbWVu
dCBhbG9uZyB0aGUgbGluZXMgb2YKPgo+IC8qCj4gICAqIHZkcGFzaW0gQVRNIHJlcXVpcmVzIFZJ
UlRJT19GX0FDQ0VTU19QTEFURk9STSwgc28gd2UgZG9uJ3QgbmVlZCB0bwo+ICAgKiBzdXBwb3J0
IGxlZ2FjeSBndWVzdHMuIEtlZXAgdHJhbnNpdGlvbmFsIGRldmljZSBjb2RlIGFyb3VuZCBmb3IK
PiAgICogdGhlIGJlbmVmaXQgb2YgcGVvcGxlIHdobyBtaWdodCBjb3B5LWFuZC1wYXN0ZSB0aGlz
IGludG8gdHJhbnNpdGlvbmFsCj4gICAqIGRldmljZSBjb2RlLgo+ICAgKi8KCgpUaGF0J3MgZmlu
ZS4KClRoYW5rcwoKCj4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
