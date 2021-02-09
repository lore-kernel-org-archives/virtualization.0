Return-Path: <SRS0=H/CR=HL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3FD15C433E6
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 03:24:21 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AB20364E45
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 03:24:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AB20364E45
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 58D876F66D
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 03:24:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ZRFTZRHtVlKE for <virtualization@archiver.kernel.org>;
	Tue,  9 Feb 2021 03:24:19 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 4A91F6F5FD; Tue,  9 Feb 2021 03:24:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1DDF56EAA1;
	Tue,  9 Feb 2021 03:24:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD94CC0174;
	Tue,  9 Feb 2021 03:24:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7BF95C013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 03:24:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 6A4F187248
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 03:24:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yFIHBF+Ym+HE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 03:24:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id C49D2871E1
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 03:24:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612841053;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nEaydSkEX8erChBy2g+JUKqaHNN0oPrHU7w4kkEF1Es=;
 b=ajw2eoKVbxCtF0ZttasoC4rVphVl/15zwk5CNDo74b9eM0J5/eLJyFC1H4mRc6FiAJbC1/
 MDWHIUzkSWvGC8jhCyx7JAc/O5RrqxyLtWJNa/loHZ8krz3Qk/ojVUoPFcXauOiNub9mjn
 ZaLuQKCmZ57mY10rWDGXavLxvRQEijo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-172-T_dfgWtlPb2WaT3yA5OSDQ-1; Mon, 08 Feb 2021 22:24:11 -0500
X-MC-Unique: T_dfgWtlPb2WaT3yA5OSDQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6C697192D787;
 Tue,  9 Feb 2021 03:24:10 +0000 (UTC)
Received: from [10.72.13.32] (ovpn-13-32.pek2.redhat.com [10.72.13.32])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 889B419C66;
 Tue,  9 Feb 2021 03:24:05 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: fix param validation in mlx5_vdpa_get_config()
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Stefano Garzarella <sgarzare@redhat.com>
References: <20210208161741.104939-1-sgarzare@redhat.com>
 <20210208133312-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <fc523fbe-b742-0ebe-84d1-2b7e5529f00b@redhat.com>
Date: Tue, 9 Feb 2021 11:24:03 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210208133312-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: Eli Cohen <elic@nvidia.com>, linux-kernel@vger.kernel.org,
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

Ck9uIDIwMjEvMi85IOS4iuWNiDI6MzgsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBPbiBN
b24sIEZlYiAwOCwgMjAyMSBhdCAwNToxNzo0MVBNICswMTAwLCBTdGVmYW5vIEdhcnphcmVsbGEg
d3JvdGU6Cj4+IEl0J3MgbGVnYWwgdG8gaGF2ZSAnb2Zmc2V0ICsgbGVuJyBlcXVhbCB0bwo+PiBz
aXplb2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnKSwgc2luY2UgJ25kZXYtPmNvbmZpZycgaXMg
YQo+PiAnc3RydWN0IHZpcnRpb19uZXRfY29uZmlnJywgc28gd2UgY2FuIHNhZmVseSBjb3B5IGl0
cyBjb250ZW50IHVuZGVyCj4+IHRoaXMgY29uZGl0aW9uLgo+Pgo+PiBGaXhlczogMWE4NmIzNzdh
YTIxICgidmRwYS9tbHg1OiBBZGQgVkRQQSBkcml2ZXIgZm9yIHN1cHBvcnRlZCBtbHg1IGRldmlj
ZXMiKQo+PiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZwo+PiBTaWduZWQtb2ZmLWJ5OiBTdGVm
YW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4+IC0tLQo+PiAgIGRyaXZlcnMv
dmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDIgKy0KPj4gICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRw
YS9tbHg1L25ldC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQu
Ywo+PiBpbmRleCBkYzg4NTU5YThkNDkuLjEwZTliMDk5MzJlYiAxMDA2NDQKPj4gLS0tIGEvZHJp
dmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1
L25ldC9tbHg1X3ZuZXQuYwo+PiBAQCAtMTgyMCw3ICsxODIwLDcgQEAgc3RhdGljIHZvaWQgbWx4
NV92ZHBhX2dldF9jb25maWcoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBpbnQg
b2Zmc2V0LAo+PiAgIAlzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYgPSB0b19tdmRldih2ZGV2
KTsKPj4gICAJc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYgPSB0b19tbHg1X3ZkcGFfbmRldiht
dmRldik7Cj4+ICAgCj4+IC0JaWYgKG9mZnNldCArIGxlbiA8IHNpemVvZihzdHJ1Y3QgdmlydGlv
X25ldF9jb25maWcpKQo+PiArCWlmIChvZmZzZXQgKyBsZW4gPD0gc2l6ZW9mKHN0cnVjdCB2aXJ0
aW9fbmV0X2NvbmZpZykpCj4+ICAgCQltZW1jcHkoYnVmLCAodTggKikmbmRldi0+Y29uZmlnICsg
b2Zmc2V0LCBsZW4pOwo+PiAgIH0KPiBBY3R1YWxseSBmaXJzdCBJIGFtIG5vdCBzdXJlIHdlIG5l
ZWQgdGhlc2UgY2hlY2tzIGF0IGFsbC4KPiB2aG9zdF92ZHBhX2NvbmZpZ192YWxpZGF0ZSBhbHJl
YWR5IHZhbGlkYXRlcyB0aGUgdmFsdWVzLCByaWdodD8KCgpJIHRoaW5rIHRoZXkncmUgd29ya2lu
ZyBhdCBkaWZmZXJlbnQgbGV2ZWxzLiBUaGVyZSdzIG5vIGd1YXJhbnRlZSB0aGF0IAp2aG9zdC12
ZHBhIGlzIHRoZSBkcml2ZXIgZm9yIHRoaXMgdmRwYSBkZXZpY2UuCgoKPgo+IFNlY29uZCwgd2hh
dCB3aWxsIGhhcHBlbiB3aGVuIHdlIGV4dGVuZCB0aGUgc3RydWN0IGFuZCB0aGVuCj4gcnVuIG5l
dyB1c2Vyc3BhY2Ugb24gYW4gb2xkIGtlcm5lbD8gTG9va3MgbGlrZSBpdCB3aWxsIGp1c3QKPiBm
YWlsIHJpZ2h0PyBTbyB3aGF0IGlzIHRoZSBwbGFuPwoKCkluIHRoaXMgY2FzZSwgZ2V0X2NvbmZp
ZygpIHNob3VsZCBtYXRjaCB0aGUgc3BlYyBiZWhhdmlvdXIuIFRoYXQgaXMgdG8gCnNheSB0aGUg
c2l6ZSBvZiBjb25maWcgc3BhY2UgZGVwZW5kcyBvbiB0aGUgZmVhdHVyZSBuZWdvdGlhdGVkLgoK
VGhhbmtzCgoKPiAgIEkgdGhpbmsgd2Ugc2hvdWxkCj4gYWxsb3cgYSBiaWdnZXIgc2l6ZSwgYW5k
IHJldHVybiB0aGUgY29waWVkIGNvbmZpZyBzaXplIHRvIHVzZXJzcGFjZS4KPgo+Cj4+IC0tIAo+
PiAyLjI5LjIKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
