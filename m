Return-Path: <SRS0=TAdK=JJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DE39C433ED
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 06:35:26 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 164BB6008E
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 06:35:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 164BB6008E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B828E82D47;
	Mon, 12 Apr 2021 06:35:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QbB8HtKdPKbu; Mon, 12 Apr 2021 06:35:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4F2CF82BE5;
	Mon, 12 Apr 2021 06:35:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 28684C000B;
	Mon, 12 Apr 2021 06:35:24 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 015BFC000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 06:35:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC2D040285
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 06:35:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yct630c-tUWM
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 06:35:20 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 93FE840254
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 06:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618209319;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=O4EBv0iM8QkeGxL9/hee8qNtWhBLhiqd7BzISi5se0s=;
 b=H0B7Ay6fAJgLW20yzJgPbEe3ECR3WhSsHFbulxAs+/DCyS0VEsaWAyQjZnjrts3UsPSZTw
 l3qdFnkHvux8e028+9yoMzKfo2XSK8WxzOBViAqNiGuYVY9JtYQiX9gAkoak3Jy6qCIyet
 p6vY1KDnmnVXwxoZSY6ZYgnNFCiDXXM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-188-ldkqjGUtMEGBC1_Pt9LsKA-1; Mon, 12 Apr 2021 02:35:15 -0400
X-MC-Unique: ldkqjGUtMEGBC1_Pt9LsKA-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CF52510054F6;
 Mon, 12 Apr 2021 06:35:14 +0000 (UTC)
Received: from wangxiaodeMacBook-Air.local (ovpn-13-232.pek2.redhat.com
 [10.72.13.232])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 3DE141A86A;
 Mon, 12 Apr 2021 06:35:08 +0000 (UTC)
Subject: Re: [RFC PATCH] vdpa: mandate 1.0 device
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20210408082648.20145-1-jasowang@redhat.com>
 <20210408115834-mutt-send-email-mst@kernel.org>
 <a6a4ab68-c958-7266-c67c-142960222b67@redhat.com>
 <20210409115343-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <42891807-cb24-5352-f8cb-798e9d1a1854@redhat.com>
Date: Mon, 12 Apr 2021 14:35:07 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <20210409115343-mutt-send-email-mst@kernel.org>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: elic@nvidia.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIxLzQvMTAg5LiK5Y2IMTI6MDQsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4g
T24gRnJpLCBBcHIgMDksIDIwMjEgYXQgMTI6NDc6NTVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPj4g5ZyoIDIwMjEvNC84IOS4i+WNiDExOjU5LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGT
Ogo+Pj4gT24gVGh1LCBBcHIgMDgsIDIwMjEgYXQgMDQ6MjY6NDhQTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPj4+PiBUaGlzIHBhdGNoIG1hbmRhdGVzIDEuMCBmb3IgdkRQQSBkZXZpY2VzLiBU
aGUgZ29hbCBpcyB0byBoYXZlIHRoZQo+Pj4+IHNlbWFudGljIG9mIG5vcm1hdGl2ZSBzdGF0ZW1l
bnQgaW4gdGhlIHZpcnRpbyBzcGVjIGFuZCBlbGltaW5hdGUgdGhlCj4+Pj4gYnVyZGVuIG9mIHRy
YW5zaXRpb25hbCBkZXZpY2UgZm9yIGJvdGggdkRQQSBidXMgYW5kIHZEUEEgcGFyZW50Lgo+Pj4+
Cj4+Pj4gdUFQSSBzZWVtcyBmaW5lIHNpbmNlIGFsbCB0aGUgdkRQQSBwYXJlbnQgbWFuZGF0ZXMK
Pj4+PiBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0gd2hpY2ggaW1wbGllcyAxLjAgZGV2aWNlcy4K
Pj4+Pgo+Pj4+IEZvciBsZWdhY3kgZ3Vlc3RzLCBpdCBjYW4gc3RpbGwgd29yayBzaW5jZSBRZW11
IHdpbGwgbWVkaWF0ZSB3aGVuCj4+Pj4gbmVjZXNzYXJ5IChlLmcgZG9pbmcgdGhlIGVuZGlhbiBj
b252ZXJzaW9uKS4KPj4+Pgo+Pj4+IFNpZ25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5n
QHJlZGhhdC5jb20+Cj4+PiBIbW0uIElmIHdlIGRvIHRoaXMsIGRvbid0IHdlIHN0aWxsIGhhdmUg
YSBwcm9ibGVtIHdpdGgKPj4+IGxlZ2FjeSBkcml2ZXJzIHdoaWNoIGRvbid0IGFjayAxLjA/Cj4+
Cj4+IFllcywgYnV0IGl0J3Mgbm90IHNvbWV0aGluZyB0aGF0IGlzIGludHJvZHVjZWQgaW4gdGhp
cyBjb21taXQuIFRoZSBsZWdhY3kKPj4gZHJpdmVyIG5ldmVyIHdvcmsgLi4uCj4gTXkgcG9pbnQg
aXMgdGhpcyBuZWl0aGVyIGZpeGVzIG9yIHByZXZlbnRzIHRoaXMuCj4KPiBTbyBteSBzdWdnZXN0
aW9uIGlzIHRvIGZpbmFsbHkgYWRkIGlvY3RscyBhbG9uZyB0aGUgbGluZXMKPiBvZiBQUk9UT0NP
TF9GRUFUVVJFUyBvZiB2aG9zdC11c2VyLgo+Cj4gVGhlbiB0aGF0IG9uZSBjYW4gaGF2ZSBiaXRz
IGZvciBsZWdhY3kgbGUsIGxlZ2FjeSBiZSBhbmQgbW9kZXJuLgo+Cj4gQlRXIEkgbG9va2VkIGF0
IHZob3N0LXVzZXIgYW5kIGl0IGRvZXMgbm90IGxvb2sgbGlrZSB0aGF0Cj4gaGFzIGEgc29sdXRp
b24gZm9yIHRoaXMgcHJvYmxlbSBlaXRoZXIsIHJpZ2h0PwoKClJpZ2h0LgoKCj4KPgo+Pj4gTm90
ZSAxLjAgYWZmZWN0cyByaW5nIGVuZGlhbm5lc3Mgd2hpY2ggaXMgbm90IG1lZGlhdGVkIGluIFFF
TVUKPj4+IHNvIFFFTVUgY2FuJ3QgcHJldGVuZCB0byBkZXZpY2UgZ3Vlc3QgaXMgMS4wLgo+Pgo+
PiBSaWdodCwgSSBwbGFuIHRvIHNlbmQgcGF0Y2hlcyB0byBkbyBtZWRpYXRpb24gaW4gdGhlIFFl
bXUgdG8gdW5icmVhayBsZWdhY3kKPj4gZHJpdmVycy4KPj4KPj4gVGhhbmtzCj4gSSBmcmFua2x5
IHRoaW5rIHdlJ2xsIG5lZWQgUFJPVE9DT0xfRkVBVFVSRVMgYW55d2F5LCBpdCdzIHRvbyB1c2Vm
dWwgLi4uCj4gc28gd2h5IG5vdCB0ZWFjaCBkcml2ZXJzIGFib3V0IGl0IGFuZCBiZSBkb25lIHdp
dGggaXQ/IFlvdSBjYW4ndCBlbXVsYXRlCj4gbGVnYWN5IG9uIG1vZGVybiBpbiBhIGNyb3NzIGVu
ZGlhbiBzaXR1YXRpb24gYmVjYXVzZSBvZiB2cmluZwo+IGVuZGlhbi1uZXNzIC4uLgoKClNvIHRo
ZSBwcm9ibGVtIHN0aWxsLiBUaGlzIGNhbiBvbmx5IHdvcmsgd2hlbiB0aGUgaGFyZHdhcmUgY2Fu
IHN1cHBvcnQgCmxlZ2FjeSB2cmluZyBlbmRpYW4tbmVzcy4KCkNvbnNpZGVyOgoKMSkgdGhlIGxl
YWdjeSBkcml2ZXIgc3VwcG9ydCBpcyBub24tbm9ybWF0aXZlIGluIHRoZSBzcGVjCjIpIHN1cHBv
cnQgYSB0cmFuc2l0aW9uYWwgZGV2aWNlIGluIHRoZSBrZW5yZWwgbWF5IHJlcXVpcmVzIHRoZSBo
YXJkd2FyZSAKc3VwcG9ydCBhbmQgYSBidXJkZW4gb2Yga2VybmVsIGNvZGVzCgpJJ2QgcmF0aGVy
IHNpbXBseSBkcm9wIHRoZSBsZWdhY3kgZHJpdmVyIHN1cHBvcnQgdG8gaGF2ZSBhIHNpbXBsZSBh
bmQgCmVhc3kgYWJzdGFyY3Rpb24gaW4gdGhlIGtlbnJlbC4gRm9yIGxlZ2FjeSBkcml2ZXIgaW4g
dGhlIGd1ZXN0LCAKaHlwZXJ2aXNvciBpcyBpbiBjaGFyZ2Ugb2YgdGhlIG1lZGlhdGlvbjoKCjEp
IGNvbmZpZyBzcGFjZSBhY2Nlc3MgZW5kaWFuIGNvbnZlcnNpb24KMikgdXNpbmcgc2hhZG93IHZp
cnRxdWV1ZSB0byBjaGFuZ2UgdGhlIGVuZGlhbiBpbiB0aGUgdnJpbmcKClRoYW5rcwoKCj4KPgo+
Pj4KPj4+Cj4+Pgo+Pj4KPj4+PiAtLS0KPj4+PiAgICBpbmNsdWRlL2xpbnV4L3ZkcGEuaCB8IDYg
KysrKysrCj4+Pj4gICAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQo+Pj4+Cj4+Pj4g
ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmRwYS5oIGIvaW5jbHVkZS9saW51eC92ZHBhLmgK
Pj4+PiBpbmRleCAwZmVmZWI5NzY4NzcuLmNmZGU0ZWM5OTliNCAxMDA2NDQKPj4+PiAtLS0gYS9p
bmNsdWRlL2xpbnV4L3ZkcGEuaAo+Pj4+ICsrKyBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4+Pj4g
QEAgLTYsNiArNiw3IEBACj4+Pj4gICAgI2luY2x1ZGUgPGxpbnV4L2RldmljZS5oPgo+Pj4+ICAg
ICNpbmNsdWRlIDxsaW51eC9pbnRlcnJ1cHQuaD4KPj4+PiAgICAjaW5jbHVkZSA8bGludXgvdmhv
c3RfaW90bGIuaD4KPj4+PiArI2luY2x1ZGUgPHVhcGkvbGludXgvdmlydGlvX2NvbmZpZy5oPgo+
Pj4+ICAgIC8qKgo+Pj4+ICAgICAqIHZEUEEgY2FsbGJhY2sgZGVmaW5pdGlvbi4KPj4+PiBAQCAt
MzE3LDYgKzMxOCwxMSBAQCBzdGF0aWMgaW5saW5lIGludCB2ZHBhX3NldF9mZWF0dXJlcyhzdHJ1
Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHU2NCBmZWF0dXJlcykKPj4+PiAgICB7Cj4+Pj4gICAgICAg
ICAgICBjb25zdCBzdHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMgPSB2ZGV2LT5jb25maWc7Cj4+
Pj4gKyAgICAgICAgLyogTWFuZGF0aW5nIDEuMCB0byBoYXZlIHNlbWFudGljcyBvZiBub3JtYXRp
dmUgc3RhdGVtZW50cyBpbgo+Pj4+ICsgICAgICAgICAqIHRoZSBzcGVjLiAqLwo+Pj4+ICsgICAg
ICAgIGlmICghKGZlYXR1cmVzICYgQklUX1VMTChWSVJUSU9fRl9WRVJTSU9OXzEpKSkKPj4+PiAr
CQlyZXR1cm4gLUVJTlZBTDsKPj4+PiArCj4+Pj4gICAgCXZkZXYtPmZlYXR1cmVzX3ZhbGlkID0g
dHJ1ZTsKPj4+PiAgICAgICAgICAgIHJldHVybiBvcHMtPnNldF9mZWF0dXJlcyh2ZGV2LCBmZWF0
dXJlcyk7Cj4+Pj4gICAgfQo+Pj4+IC0tIAo+Pj4+IDIuMjUuMQoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
