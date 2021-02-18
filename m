Return-Path: <SRS0=I+ly=HU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7D9EDC433DB
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 05:47:44 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EC77564DF0
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 05:47:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EC77564DF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 871AC605D7
	for <virtualization@archiver.kernel.org>; Thu, 18 Feb 2021 05:47:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WsX9tJuFAMCT for <virtualization@archiver.kernel.org>;
	Thu, 18 Feb 2021 05:47:41 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 6E453605D4; Thu, 18 Feb 2021 05:47:41 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 96050605AA;
	Thu, 18 Feb 2021 05:47:38 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6744AC000E;
	Thu, 18 Feb 2021 05:47:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AA924C000D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 05:47:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 9223A864F6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 05:47:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PPh+QMYN7--8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 05:47:35 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 86CA186429
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 Feb 2021 05:47:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1613627254;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EEzp7Q6dzVcDVJyytaj42+XIoYTvxu65V7wyoIhA9bU=;
 b=OaODqyV55XgncJvRjGmUG1DqQTFYB+MBKAHLUfClX6XMAhR67REOuDioivYKQvL6nZtNL+
 CNdoVMdQHPia1DdKbKIKNb4lQkhHp3cBX8e/MYrF0l0qsnlcU0pDL/a0rCOrLzzez7R+dt
 Phi0WnA3zRtOXj6wGY2RRlzbWP5k7x8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-562--ipJzhiQPR6dI9UCcYvbFg-1; Thu, 18 Feb 2021 00:47:32 -0500
X-MC-Unique: -ipJzhiQPR6dI9UCcYvbFg-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com
 [10.5.11.14])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1CBC51936B66;
 Thu, 18 Feb 2021 05:47:31 +0000 (UTC)
Received: from [10.72.13.28] (ovpn-13-28.pek2.redhat.com [10.72.13.28])
 by smtp.corp.redhat.com (Postfix) with ESMTP id EFCB05D9C2;
 Thu, 18 Feb 2021 05:47:25 +0000 (UTC)
Subject: Re: [PATCH] vdpa/mlx5: fix param validation in mlx5_vdpa_get_config()
To: Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20210208161741.104939-1-sgarzare@redhat.com>
 <20210208133312-mutt-send-email-mst@kernel.org>
 <fc523fbe-b742-0ebe-84d1-2b7e5529f00b@redhat.com>
 <20210209042530-mutt-send-email-mst@kernel.org>
 <20210210100821.aaye2cgmrpwhhzgn@steredhat>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <5b748533-7091-cba1-50c6-3da2049bc354@redhat.com>
Date: Thu, 18 Feb 2021 13:47:24 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210210100821.aaye2cgmrpwhhzgn@steredhat>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
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

Ck9uIDIwMjEvMi8xMCDkuIvljYg2OjA4LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gT24g
VHVlLCBGZWIgMDksIDIwMjEgYXQgMDQ6MzE6MjNBTSAtMDUwMCwgTWljaGFlbCBTLiBUc2lya2lu
IHdyb3RlOgo+PiBPbiBUdWUsIEZlYiAwOSwgMjAyMSBhdCAxMToyNDowM0FNICswODAwLCBKYXNv
biBXYW5nIHdyb3RlOgo+Pj4KPj4+IE9uIDIwMjEvMi85IOS4iuWNiDI6MzgsIE1pY2hhZWwgUy4g
VHNpcmtpbiB3cm90ZToKPj4+ID4gT24gTW9uLCBGZWIgMDgsIDIwMjEgYXQgMDU6MTc6NDFQTSAr
MDEwMCwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+Pj4gPiA+IEl0J3MgbGVnYWwgdG8gaGF2
ZSAnb2Zmc2V0ICsgbGVuJyBlcXVhbCB0bwo+Pj4gPiA+IHNpemVvZihzdHJ1Y3QgdmlydGlvX25l
dF9jb25maWcpLCBzaW5jZSAnbmRldi0+Y29uZmlnJyBpcyBhCj4+PiA+ID4gJ3N0cnVjdCB2aXJ0
aW9fbmV0X2NvbmZpZycsIHNvIHdlIGNhbiBzYWZlbHkgY29weSBpdHMgY29udGVudCB1bmRlcgo+
Pj4gPiA+IHRoaXMgY29uZGl0aW9uLgo+Pj4gPiA+Cj4+PiA+ID4gRml4ZXM6IDFhODZiMzc3YWEy
MSAoInZkcGEvbWx4NTogQWRkIFZEUEEgZHJpdmVyIGZvciBzdXBwb3J0ZWQgCj4+PiBtbHg1IGRl
dmljZXMiKQo+Pj4gPiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnCj4+PiA+ID4gU2lnbmVk
LW9mZi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgo+Pj4gPiA+
IC0tLQo+Pj4gPiA+wqDCoCBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAyICst
Cj4+PiA+ID7CoMKgIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigt
KQo+Pj4gPiA+Cj4+PiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1
X3ZuZXQuYyAKPj4+IGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+PiA+ID4g
aW5kZXggZGM4ODU1OWE4ZDQ5Li4xMGU5YjA5OTMyZWIgMTAwNjQ0Cj4+PiA+ID4gLS0tIGEvZHJp
dmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+PiA+ID4gKysrIGIvZHJpdmVycy92ZHBh
L21seDUvbmV0L21seDVfdm5ldC5jCj4+PiA+ID4gQEAgLTE4MjAsNyArMTgyMCw3IEBAIHN0YXRp
YyB2b2lkIG1seDVfdmRwYV9nZXRfY29uZmlnKHN0cnVjdCAKPj4+IHZkcGFfZGV2aWNlICp2ZGV2
LCB1bnNpZ25lZCBpbnQgb2Zmc2V0LAo+Pj4gPiA+wqDCoMKgwqDCoMKgIHN0cnVjdCBtbHg1X3Zk
cGFfZGV2ICptdmRldiA9IHRvX212ZGV2KHZkZXYpOwo+Pj4gPiA+wqDCoMKgwqDCoMKgIHN0cnVj
dCBtbHg1X3ZkcGFfbmV0ICpuZGV2ID0gdG9fbWx4NV92ZHBhX25kZXYobXZkZXYpOwo+Pj4gPiA+
IC3CoMKgwqAgaWYgKG9mZnNldCArIGxlbiA8IHNpemVvZihzdHJ1Y3QgdmlydGlvX25ldF9jb25m
aWcpKQo+Pj4gPiA+ICvCoMKgwqAgaWYgKG9mZnNldCArIGxlbiA8PSBzaXplb2Yoc3RydWN0IHZp
cnRpb19uZXRfY29uZmlnKSkKPj4+ID4gPsKgwqDCoMKgwqDCoMKgwqDCoMKgIG1lbWNweShidWYs
ICh1OCAqKSZuZGV2LT5jb25maWcgKyBvZmZzZXQsIGxlbik7Cj4+PiA+ID7CoMKgIH0KPj4+ID4g
QWN0dWFsbHkgZmlyc3QgSSBhbSBub3Qgc3VyZSB3ZSBuZWVkIHRoZXNlIGNoZWNrcyBhdCBhbGwu
Cj4+PiA+IHZob3N0X3ZkcGFfY29uZmlnX3ZhbGlkYXRlIGFscmVhZHkgdmFsaWRhdGVzIHRoZSB2
YWx1ZXMsIHJpZ2h0Pwo+Pj4KPj4+Cj4+PiBJIHRoaW5rIHRoZXkncmUgd29ya2luZyBhdCBkaWZm
ZXJlbnQgbGV2ZWxzLiBUaGVyZSdzIG5vIGd1YXJhbnRlZSB0aGF0Cj4+PiB2aG9zdC12ZHBhIGlz
IHRoZSBkcml2ZXIgZm9yIHRoaXMgdmRwYSBkZXZpY2UuCj4+Cj4+IEluIGZhY3QsIGdldF9jb25m
aWcgcmV0dXJucyB2b2lkLCBzbyB1c2Vyc3BhY2UgY2FuIGVhc2lseSBnZXQKPj4gdHJhc2ggaWYg
aXQgcGFzc2VzIGluY29ycmVjdCBwYXJhbWV0ZXJzIGJ5IG1pc3Rha2UsIHRoZXJlIGlzCj4+IG5v
IHdheSBmb3IgdXNlcnNwYWNlIHRvIGZpbmQgb3V0IHdoZXRoZXIgdGhhdCBpcyB0aGUgY2FzZSA6
KAo+Pgo+PiBBbnkgb2JqZWN0aW9ucyB0byByZXR1cm5pbmcgdGhlICMgb2YgYnl0ZXMgY29waWVk
LCBvciAtMQo+PiBvbiBlcnJvcj8KPgo+IE1ha2Ugc2Vuc2UgZm9yIG1lLCBidXQgYXJlIHdlIHN1
cmUgd2UgZG9uJ3QgYnJlYWsgdXNlcnNwYWNlIGlmIHdlIAo+IHJldHVybiB0aGUgbnVtYmVyIG9m
IGJ5dGVzIGluc3RlYWQgb2YgMCBvbiBzdWNjZXNzPwo+Cj4gSSBoYWQgYSBxdWljayBsb29rIGF0
IFFFTVUgYW5kIGl0IGxvb2tzIGxpa2Ugd2UgY29uc2lkZXIgc3VjY2VzcyBpZiAKPiB0aGUgcmV0
dXJuIHZhbHVlIGlzID49IDAsIGJ1dCBJIG5lZWQgdG8gY2hlY2sgZnVydGhlci4KCgpTbyBJIHRo
aW5rIGluIHRoZSB2ZHBhIGJ1cyBsZXZlbCwgd2UgY2FuIHJldHVybiAjYnl0ZXMgYW5kIGluIHZo
b3N0IHVBUEkgCmxldmVsLCB3ZSBjYW4gcmV0dXJuIGVycm9yIGlmIHRoZSBzaXplIGlzIG5vdCBl
eHBlY3RlZCBvdGhlcndpc2UgemVybz8KClRoYW5rcwoKCj4KPj4KPj4+Cj4+PiA+Cj4+PiA+IFNl
Y29uZCwgd2hhdCB3aWxsIGhhcHBlbiB3aGVuIHdlIGV4dGVuZCB0aGUgc3RydWN0IGFuZCB0aGVu
Cj4+PiA+IHJ1biBuZXcgdXNlcnNwYWNlIG9uIGFuIG9sZCBrZXJuZWw/IExvb2tzIGxpa2UgaXQg
d2lsbCBqdXN0Cj4+PiA+IGZhaWwgcmlnaHQ/IFNvIHdoYXQgaXMgdGhlIHBsYW4/Cj4+Pgo+Pj4K
Pj4+IEluIHRoaXMgY2FzZSwgZ2V0X2NvbmZpZygpIHNob3VsZCBtYXRjaCB0aGUgc3BlYyBiZWhh
dmlvdXIuIFRoYXQgaXMgCj4+PiB0byBzYXkKPj4+IHRoZSBzaXplIG9mIGNvbmZpZyBzcGFjZSBk
ZXBlbmRzIG9uIHRoZSBmZWF0dXJlIG5lZ290aWF0ZWQuCj4+Pgo+Pj4gVGhhbmtzCj4+Cj4+IFll
cyBidXQgc3BlYyBzYXlzIGNvbmZpZyBzcGFjZSBjYW4gYmUgYmlnZ2VyIHRoYW4gc3BlY2lmaWVk
IGJ5IGZlYXR1cmVzOgo+Pgo+PiDCoMKgwqDCoERyaXZlcnMgTVVTVCBOT1QgbGltaXQgc3RydWN0
dXJlIHNpemUgYW5kIGRldmljZSBjb25maWd1cmF0aW9uIAo+PiBzcGFjZSBzaXplLiBJbnN0ZWFk
LCBkcml2ZXJzIFNIT1VMRCBvbmx5Cj4+IMKgwqDCoMKgY2hlY2sgdGhhdCBkZXZpY2UgY29uZmln
dXJhdGlvbiBzcGFjZSBpcyBsYXJnZSBlbm91Z2ggdG8gY29udGFpbiAKPj4gdGhlIGZpZWxkcyBu
ZWNlc3NhcnkgZm9yIGRldmljZSBvcGVyYXRpb24uCj4+Cj4KPiBTbyBJSVVDIGluIHRoZSBkcml2
ZXIgd2Ugc2hvdWxkIGNvcHkgYXMgbXVjaCBhcyB3ZSBjYW4uCj4KPiBJZiB5b3UgYWdyZWUsIEkg
Y2FuIHNlbmQgYW4gUkZDIHNlcmllcyBhbmQgd2UgY2FuIGNvbnRpbnVlIHRoZSAKPiBkaXNjdXNz
aW9uIG9uIGl0LCBidXQgSSB0aGluayB3ZSBzaG91bGQgcXVldWUgdGhpcyBwYXRjaCBmb3Igc3Rh
YmxlIAo+IGJyYW5jaGVzLgo+Cj4gVGhhbmtzLAo+IFN0ZWZhbm8KPgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
