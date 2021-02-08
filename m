Return-Path: <SRS0=X+k7=HK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFE3EC433E0
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 04:13:44 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 77A0664E5C
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 04:13:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 77A0664E5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 436DD86FE1;
	Mon,  8 Feb 2021 04:13:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id teyWgW1dsfxM; Mon,  8 Feb 2021 04:13:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 74CB686FAA;
	Mon,  8 Feb 2021 04:13:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 41D9AC0174;
	Mon,  8 Feb 2021 04:13:43 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 087D9C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 04:13:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EF50D203E2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 04:13:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7IDqaJezyAqb
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 04:13:40 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 8DF43203CD
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 04:13:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612757618;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OwbGbSWL1LBJv8uhMlfeoPlfAVlcGee31SXrkqRKFhU=;
 b=cv9sH2uH5lFecs9zfWEPTsU6gEbRlxhOjMvgLKkv9LX2Bd4OpPKAjqywD4oB/tnsC/WxCz
 G6OPnMMv+sdtpmtIWtYrNXeKm76WjnOkVnMzlYMUV4FlISi12pT07oy1Qe0IiZEM4jjhKh
 58P7LXDdGFuYtO1VfLES327ieNZs5WU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-432-Ncn5d9ULMziacd2DWrxyRg-1; Sun, 07 Feb 2021 23:13:35 -0500
X-MC-Unique: Ncn5d9ULMziacd2DWrxyRg-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id CC93A427C1;
 Mon,  8 Feb 2021 04:13:33 +0000 (UTC)
Received: from [10.72.13.185] (ovpn-13-185.pek2.redhat.com [10.72.13.185])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 97DF262A22;
 Mon,  8 Feb 2021 04:13:24 +0000 (UTC)
Subject: Re: [PATCH v3 09/13] vhost/vdpa: remove vhost_vdpa_config_validate()
To: Stefano Garzarella <sgarzare@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20210204172230.85853-1-sgarzare@redhat.com>
 <20210204172230.85853-10-sgarzare@redhat.com>
 <6919d2d4-cc8e-2b67-2385-35803de5e38b@redhat.com>
 <20210205091651.xfcdyuvwwzew2ufo@steredhat>
 <20210205083108-mutt-send-email-mst@kernel.org>
 <20210205141707.clbckauxnrzd7nmv@steredhat>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <d86393d3-67b6-6524-5f9f-8634ec4f9b8f@redhat.com>
Date: Mon, 8 Feb 2021 12:13:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210205141707.clbckauxnrzd7nmv@steredhat>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>
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

Ck9uIDIwMjEvMi81IOS4i+WNiDEwOjE3LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gT24g
RnJpLCBGZWIgMDUsIDIwMjEgYXQgMDg6MzI6MzdBTSAtMDUwMCwgTWljaGFlbCBTLiBUc2lya2lu
IHdyb3RlOgo+PiBPbiBGcmksIEZlYiAwNSwgMjAyMSBhdCAxMDoxNjo1MUFNICswMTAwLCBTdGVm
YW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4+PiBPbiBGcmksIEZlYiAwNSwgMjAyMSBhdCAxMToyNzoz
MkFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4gPgo+Pj4gPiBPbiAyMDIxLzIvNSDkuIrl
jYgxOjIyLCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4+PiA+ID4gZ2V0X2NvbmZpZygpIGFu
ZCBzZXRfY29uZmlnKCkgY2FsbGJhY2tzIGluIHRoZSAnc3RydWN0IAo+Pj4gdmRwYV9jb25maWdf
b3BzJwo+Pj4gPiA+IHVzdWFsbHkgYWxyZWFkeSB2YWxpZGF0ZWQgdGhlIGlucHV0cy4gQWxzbyBu
b3cgdGhleSBjYW4gcmV0dXJuIAo+Pj4gYW4gZXJyb3IsCj4+PiA+ID4gc28gd2UgZG9uJ3QgbmVl
ZCB0byB2YWxpZGF0ZSB0aGVtIGhlcmUgYW55bW9yZS4KPj4+ID4gPgo+Pj4gPiA+IExldCdzIHVz
ZSB0aGUgcmV0dXJuIHZhbHVlIG9mIHRoZXNlIGNhbGxiYWNrcyBhbmQgcmV0dXJuIGl0IGluIAo+
Pj4gY2FzZSBvZgo+Pj4gPiA+IGVycm9yIGluIHZob3N0X3ZkcGFfZ2V0X2NvbmZpZygpIGFuZCB2
aG9zdF92ZHBhX3NldF9jb25maWcoKS4KPj4+ID4gPgo+Pj4gPiA+IE9yaWdpbmFsbHktYnk6IFhp
ZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgo+Pj4gPiA+IFNpZ25lZC1vZmYtYnk6
IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4KPj4+ID4gPiAtLS0KPj4+
ID4gPsKgIGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwgNDEgCj4+PiArKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+Pj4gPiA+wqAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2Vy
dGlvbnMoKyksIDI4IGRlbGV0aW9ucygtKQo+Pj4gPiA+Cj4+PiA+ID4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvdmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4+ID4gPiBpbmRleCBl
ZjY4OGM4YzBlMGUuLmQ2MWU3NzkwMDBhOCAxMDA2NDQKPj4+ID4gPiAtLS0gYS9kcml2ZXJzL3Zo
b3N0L3ZkcGEuYwo+Pj4gPiA+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+PiA+ID4gQEAg
LTE4NSw1MSArMTg1LDM1IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfc2V0X3N0YXR1cyhzdHJ1
Y3QgCj4+PiB2aG9zdF92ZHBhICp2LCB1OCBfX3VzZXIgKnN0YXR1c3ApCj4+PiA+ID7CoMKgwqDC
oMKgIHJldHVybiAwOwo+Pj4gPiA+wqAgfQo+Pj4gPiA+IC1zdGF0aWMgaW50IHZob3N0X3ZkcGFf
Y29uZmlnX3ZhbGlkYXRlKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+Pj4gPiA+IC3CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgc3RydWN0IHZob3N0X3ZkcGFfY29uZmln
ICpjKQo+Pj4gPiA+IC17Cj4+PiA+ID4gLcKgwqDCoCBsb25nIHNpemUgPSAwOwo+Pj4gPiA+IC0K
Pj4+ID4gPiAtwqDCoMKgIHN3aXRjaCAodi0+dmlydGlvX2lkKSB7Cj4+PiA+ID4gLcKgwqDCoCBj
YXNlIFZJUlRJT19JRF9ORVQ6Cj4+PiA+ID4gLcKgwqDCoMKgwqDCoMKgIHNpemUgPSBzaXplb2Yo
c3RydWN0IHZpcnRpb19uZXRfY29uZmlnKTsKPj4+ID4gPiAtwqDCoMKgwqDCoMKgwqAgYnJlYWs7
Cj4+PiA+ID4gLcKgwqDCoCB9Cj4+PiA+ID4gLQo+Pj4gPiA+IC3CoMKgwqAgaWYgKGMtPmxlbiA9
PSAwKQo+Pj4gPiA+IC3CoMKgwqDCoMKgwqDCoCByZXR1cm4gLUVJTlZBTDsKPj4+ID4gPiAtCj4+
PiA+ID4gLcKgwqDCoCBpZiAoYy0+bGVuID4gc2l6ZSAtIGMtPm9mZikKPj4+ID4gPiAtwqDCoMKg
wqDCoMKgwqAgcmV0dXJuIC1FMkJJRzsKPj4+ID4gPiAtCj4+PiA+ID4gLcKgwqDCoCByZXR1cm4g
MDsKPj4+ID4gPiAtfQo+Pj4gPiA+IC0KPj4+ID4gPsKgIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFf
Z2V0X2NvbmZpZyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPj4+ID4gPsKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgIHN0cnVjdCB2aG9zdF92ZHBhX2NvbmZpZyBfX3VzZXIgKmMp
Cj4+PiA+ID7CoCB7Cj4+PiA+ID7CoMKgwqDCoMKgIHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9
IHYtPnZkcGE7Cj4+PiA+ID7CoMKgwqDCoMKgIHN0cnVjdCB2aG9zdF92ZHBhX2NvbmZpZyBjb25m
aWc7Cj4+PiA+ID7CoMKgwqDCoMKgIHVuc2lnbmVkIGxvbmcgc2l6ZSA9IG9mZnNldG9mKHN0cnVj
dCB2aG9zdF92ZHBhX2NvbmZpZywgYnVmKTsKPj4+ID4gPiArwqDCoMKgIGxvbmcgcmV0Owo+Pj4g
PiA+wqDCoMKgwqDCoCB1OCAqYnVmOwo+Pj4gPiA+wqDCoMKgwqDCoCBpZiAoY29weV9mcm9tX3Vz
ZXIoJmNvbmZpZywgYywgc2l6ZSkpCj4+PiA+ID7CoMKgwqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1F
RkFVTFQ7Cj4+PiA+ID4gLcKgwqDCoCBpZiAodmhvc3RfdmRwYV9jb25maWdfdmFsaWRhdGUodiwg
JmNvbmZpZykpCj4+PiA+ID4gK8KgwqDCoCBpZiAoY29uZmlnLmxlbiA9PSAwKQo+Pj4gPiA+wqDC
oMKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUlOVkFMOwo+Pj4gPiA+wqDCoMKgwqDCoCBidWYgPSBr
dnphbGxvYyhjb25maWcubGVuLCBHRlBfS0VSTkVMKTsKPj4+ID4KPj4+ID4KPj4+ID4gVGhlbiBp
dCBtZWFucyB1c2Vyc2FwY2UgY2FuIGFsbG9jYXRlIGEgdmVyeSBsYXJnZSBtZW1vcnkuCj4+Pgo+
Pj4gR29vZCBwb2ludC4KPj4+Cj4+PiA+Cj4+PiA+IFJldGhpbmsgYWJvdXQgdGhpcywgd2Ugc2hv
dWxkIGxpbWl0IHRoZSBzaXplIGhlcmUgKGUuZyBQQUdFX1NJWkUpIG9yCj4+PiA+IGZldGNoIHRo
ZSBjb25maWcgc2l6ZSBmaXJzdCAoZWl0aGVyIHRocm91Z2ggYSBjb25maWcgb3BzIGFzIHlvdQo+
Pj4gPiBzdWdnZXN0ZWQgb3IgYSB2YXJpYWJsZSBpbiB0aGUgdmRwYSBkZXZpY2UgdGhhdCBpcyBp
bml0aWFsaXplZCBkdXJpbmcKPj4+ID4gZGV2aWNlIGNyZWF0aW9uKS4KPj4+Cj4+PiBNYXliZSBQ
QUdFX1NJWkUgaXMgb2theSBhcyBhIGxpbWl0Lgo+Pj4KPj4+IElmIGluc3RlYWQgd2Ugd2FudCB0
byBmZXRjaCB0aGUgY29uZmlnIHNpemUsIHRoZW4gYmV0dGVyIGEgY29uZmlnIAo+Pj4gb3BzIGlu
IG15Cj4+PiBvcGluaW9uLCB0byBhdm9pZCBhZGRpbmcgYSBuZXcgcGFyYW1ldGVyIHRvIF9fdmRw
YV9hbGxvY19kZXZpY2UoKS4KPj4+Cj4+PiBJIHZvdGUgZm9yIFBBR0VfU0laRSwgYnV0IGl0IGlz
bid0IGEgc3Ryb25nIG9waW5pb24uCj4+Pgo+Pj4gV2hhdCBkbyB5b3UgYW5kIEBNaWNoYWVsIHN1
Z2dlc3Q/Cj4+Pgo+Pj4gVGhhbmtzLAo+Pj4gU3RlZmFubwo+Pgo+PiBEZXZpY2VzIGtub3cgd2hh
dCB0aGUgY29uZmlnIHNpemUgaXMuIEp1c3QgaGF2ZSB0aGVtIHByb3ZpZGUgaXQuCj4+Cj4KPiBP
a2F5LCBJJ2xsIGFkZCBnZXRfY29uZmlnX3NpemUoKSBjYWxsYmFjayBpbiB2ZHBhX2NvbmZpZ19v
cHMgYW5kIEknbGwgCj4gbGVhdmUgdmhvc3RfdmRwYV9jb25maWdfdmFsaWRhdGUoKSB0aGF0IHdp
bGwgdXNlIHRoYXQgY2FsbGJhY2sgaW5zdGVhZCAKPiBvZiAndmlydGlvX2lkJyB0byBnZXQgdGhl
IGNvbmZpZyBzaXplIGZyb20gdGhlIGRldmljZS4KPgo+IEF0IHRoaXMgcG9pbnQgSSB0aGluayBJ
IGNhbiByZW1vdmUgdGhlICJ2ZHBhOiBhZGQgcmV0dXJuIHZhbHVlIHRvIAo+IGdldF9jb25maWcv
c2V0X2NvbmZpZyBjYWxsYmFja3MiIHBhdGNoIGFuZCBsZWF2ZSB2b2lkIHJldHVybiB0byAKPiBn
ZXRfY29uZmlnL3NldF9jb25maWcgY2FsbGJhY2tzLgo+Cj4gRG9lcyB0aGlzIG1ha2Ugc2Vuc2U/
Cj4KPiBUaGFua3MsCj4gU3RlZmFubwoKClllcyBJIHRoaW5rIHNvLgoKVGhhbmtzCgoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
