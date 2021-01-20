Return-Path: <SRS0=zQmE=GX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C138C433E0
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 02:48:02 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC0C7230FE
	for <virtualization@archiver.kernel.org>; Wed, 20 Jan 2021 02:48:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC0C7230FE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 357F685B0C;
	Wed, 20 Jan 2021 02:48:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AC6SjWxzmn-x; Wed, 20 Jan 2021 02:47:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AC89E85ABE;
	Wed, 20 Jan 2021 02:47:59 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8EE8FC08A1;
	Wed, 20 Jan 2021 02:47:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9212EC013A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 02:47:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 8594886667
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 02:47:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TeDZMAyHf07S
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 02:47:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 52E9B86663
 for <virtualization@lists.linux-foundation.org>;
 Wed, 20 Jan 2021 02:47:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1611110876;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=DiTKU8gYtxBQpvm0b/ZcYK/Nr18SzCyr5u24C3RyBek=;
 b=bcc5ID/IxuSQWOPQe/UuemUxlK6pWVY4p/0ir7OWjjuTRQQ/2cxb3tWAPCuffHuFE7AKHr
 k6IeB/oYYeLfdVFRz0YWFdS2u1ICKHky+3h9J0AilEesOlSpiotiznIyUK52vScA3KrxIJ
 I0y+SsbbQwUAg+730tdUVfFRbXlPzVQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-N2kpQFDYO5SaCm6M1Ad9Vw-1; Tue, 19 Jan 2021 21:47:54 -0500
X-MC-Unique: N2kpQFDYO5SaCm6M1Ad9Vw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DA28D1800D41;
 Wed, 20 Jan 2021 02:47:52 +0000 (UTC)
Received: from [10.72.13.124] (ovpn-13-124.pek2.redhat.com [10.72.13.124])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DA1B777C1F;
 Wed, 20 Jan 2021 02:47:47 +0000 (UTC)
Subject: Re: [PATCH RFC] virtio-blk: support per-device queue depth
To: JeffleXu <jefflexu@linux.alibaba.com>,
 Joseph Qi <joseph.qi@linux.alibaba.com>, "Michael S. Tsirkin"
 <mst@redhat.com>
References: <1610942338-78252-1-git-send-email-joseph.qi@linux.alibaba.com>
 <ab4cbc06-b629-dd35-52ac-1246d500d1c4@redhat.com>
 <4141645d-6dfc-110c-bfcd-03641df8332c@linux.alibaba.com>
 <46f2f81f-9906-e1f7-d8fd-6da2c61683ba@redhat.com>
 <25d8430c-bf18-38ca-cf0c-c054507e1466@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b782bcb7-9b45-a122-0f80-8cfcd89b5f70@redhat.com>
Date: Wed, 20 Jan 2021 10:47:40 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <25d8430c-bf18-38ca-cf0c-c054507e1466@linux.alibaba.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Cc: linux-block@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjEvMS8yMCDkuIrljYg5OjUxLCBKZWZmbGVYdSB3cm90ZToKPgo+IE9uIDEvMTkvMjEg
MTI6MDYgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4+IE9uIDIwMjEvMS8xOSDkuIrljYg5OjMzLCBK
ZWZmbGVYdSB3cm90ZToKPj4+IE9uIDEvMTgvMjEgMToyNSBQTSwgSmFzb24gV2FuZyB3cm90ZToK
Pj4+PiBPbiAyMDIxLzEvMTgg5LiK5Y2IMTE6NTgsIEpvc2VwaCBRaSB3cm90ZToKPj4+Pj4gbW9k
dWxlIHBhcmFtZXRlciAndmlydGJsa19xdWV1ZV9kZXB0aCcgd2FzIGZpcnN0bHkgaW50cm9kdWNl
ZCBmb3IKPj4+Pj4gdGVzdGluZy9iZW5jaG1hcmtpbmcgcHVycG9zZXMgZGVzY3JpYmVkIGluIGNv
bW1pdCBmYzQzMjRiNDU5N2MKPj4+Pj4gKCJ2aXJ0aW8tYmxrOiBiYXNlIHF1ZXVlLWRlcHRoIG9u
IHZpcnRxdWV1ZSByaW5nc2l6ZSBvciBtb2R1bGUgcGFyYW0iKS4KPj4+Pj4gU2luY2Ugd2UgaGF2
ZSBkaWZmZXJlbnQgdmlydGlvLWJsayBkZXZpY2VzIHdoaWNoIGhhdmUgZGlmZmVyZW50Cj4+Pj4+
IGNhcGFiaWxpdGllcywgaXQgcmVxdWlyZXMgdGhhdCB3ZSBzdXBwb3J0IHBlci1kZXZpY2UgcXVl
dWUgZGVwdGgKPj4+Pj4gaW5zdGVhZAo+Pj4+PiBvZiBwZXItbW9kdWxlLiBTbyBkZWZhdWx0bHkg
dXNlIHZxIGZyZWUgZWxlbWVudHMgaWYgbW9kdWxlIHBhcmFtZXRlcgo+Pj4+PiAndmlydGJsa19x
dWV1ZV9kZXB0aCcgaXMgbm90IHNldC4KPj4+PiBJIHdvbmRlciBpZiBpdCdzIGJldHRlciB0byB1
c2Ugc3lzZnMgaW5zdGVhZCAob3Igd2hldGhlciBpdCBoYXMgYWxyZWFkeQo+Pj4+IGhhZCBzb21l
dGhpbmcgbGlrZSB0aGlzIGluIHRoZSBibG9ja2VyIGxheWVyKS4KPj4+Pgo+Pj4gIi9zeXMvYmxv
Y2svPGRldj4vcXVldWUvbnJfcmVxdWVzdHMiIGluZGVlZCB3b3JrcywgYnV0IGlzbid0IGJldHRl
ciB0bwo+Pj4gc2V0IHF1ZXVlX2RlcHRoIGFjY29yZGluZyB0byB0aGUgaGFyZHdhcmUgY2FwYWJp
bGl0eSBhdCB0aGUgdmVyeSBmaXJzdD8KPj4+IEFGQUlLLCBudm1lIGp1c3Qgc2V0IHBlci1kZXZp
Y2UgcXVldWVfZGVwdGggYXQgaW5pdGlhbGl6aW5nIHBoYXNlLgo+Pgo+PiBJIGFncmVlLCB0aGUg
cHJvYmxlbSBpcyB0aGF0IHRoZSBjdXJyZW50IGNvZGUgbWF5IG1vZGlmeSBtb2R1bGUgcGFyYW1l
dGVyLgo+IFRoZSBtb2R1bGUgcGFyYW1ldGVyICd2aXJ0YmxrX3F1ZXVlX2RlcHRoJyBpcyBhY3R1
YWxseSByZW1haW5lZCB1bnRhaW50ZWQuCj4KPiBBY3R1YWxseSBpdCBpcyB0aGUgb3JpZ2luYWwg
Y29kZSBiZWZvcmUgdGhpcyBwYXRjaCB0aGF0IGNoYW5nZXMgdGhlCj4gbW9kdWxlIHBhcmFtZXRl
ci4KCgpZZXMsIHRoYXQncyB3aGF0IEkgbWVhbnQuCgoKPiBXaGVuIHRoZSBtb2R1bGUgcGFyYW1l
dGVyIGlzIG5vdCBzZXQgYnkgYm9vdCBjbWRsaW5lCj4gKGkuZS4sIGRlZmF1bHQgdG8gMCksIGl0
IHdpbGwgYmUgaW5pdGlhbGl6ZWQgdG8gdGhlIHF1ZXVlX2RlcHRoIG9mIHRoZQo+IHZyaW5nIG9m
IHRoZSBmaXJzdCBwcm9iZWQgdmlydGlvLWJsayBkZXZpY2UsIGFuZCB3aWxsIGJlIHJldmVhbGVk
IHRvCj4gdXNlciBzcGFjZSB0aHJvdWdoICcvc3lzL21vZHVsZS92aXJ0aW9fYmxrL3BhcmFtZXRl
cnMvcXVldWVfZGVwdGgnLiBJJ20KPiBub3Qgc3VyZSBpZiB0aGlzIGJlaGF2aW9yIGlzIHJlYXNv
bmFibGUgb3Igbm90LgoKClJpZ2h0LCBpdCBtZWFucyB0aGUgdmlydGlvLWJsayBkZXZpY2VzIHRo
YXQgaXMgcHJvYmVkIGFmdGVyIHRoZSBmaXJzdCAKb25lIGNhbiBvbmx5IHVzZSB0aGUgcXVldWVf
ZGVwdGggdGhhdCBpcyBzZXQgYWNjb3JkaW5nIHRvIHRoZSBjYXBhYmlsaXR5IApvZiB0aGUgZmly
c3QgdmlydGlvLWJsayBkZXZpY2UuCgoKPgo+IFRoZSBvbmx5IHNpZGUgZWZmZWN0IG9mIHRoaXMg
cGF0Y2ggaXMgdGhhdCwgbm93Cj4gJy9zeXMvbW9kdWxlL3ZpcnRpb19ibGsvcGFyYW1ldGVycy9x
dWV1ZV9kZXB0aCcgd2lsbCBiZSBrZXB0IGFzICcwJyB3aGVuCj4gdGhlIG1vZHVsZSBwYXJhbWV0
ZXIgaXMgbm90IHNldCBtYW51YWxseS4KCgpJIHRoaW5rIGl0J3Mgbm90IGFuIGlzc3VlLCB0aGUg
bnJfcmVxdWVzdCBzaG91bGQgYmUgdGhlIGNvcnJlY3Qgd2F5IHRvwqAgCmdldCBwZXIgZGV2aWNl
IHF1ZXVlIGRlcHRoLgoKVGhhbmtzCgoKPgo+Cj4gVGhhbmtzLAo+IEplZmZsZQo+Cj4KPj4+Pj4g
U2lnbmVkLW9mZi1ieTogSm9zZXBoIFFpIDxqb3NlcGgucWlAbGludXguYWxpYmFiYS5jb20+Cj4+
Pj4+IC0tLQo+Pj4+PiAgwqDCoCBkcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYyB8IDEyICsrKysr
KystLS0tLQo+Pj4+PiAgwqDCoCAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA1IGRl
bGV0aW9ucygtKQo+Pj4+Pgo+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ibG9jay92aXJ0aW9f
YmxrLmMgYi9kcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYwo+Pj4+PiBpbmRleCAxNDU2MDZkLi5m
ODNhNDE3IDEwMDY0NAo+Pj4+PiAtLS0gYS9kcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYwo+Pj4+
PiArKysgYi9kcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYwo+Pj4+PiBAQCAtNzA1LDYgKzcwNSw3
IEBAIHN0YXRpYyBpbnQgdmlydGJsa19wcm9iZShzdHJ1Y3QgdmlydGlvX2RldmljZQo+Pj4+PiAq
dmRldikKPj4+Pj4gIMKgwqDCoMKgwqDCoCB1MzIgdiwgYmxrX3NpemUsIG1heF9zaXplLCBzZ19l
bGVtcywgb3B0X2lvX3NpemU7Cj4+Pj4+ICDCoMKgwqDCoMKgwqAgdTE2IG1pbl9pb19zaXplOwo+
Pj4+PiAgwqDCoMKgwqDCoMKgIHU4IHBoeXNpY2FsX2Jsb2NrX2V4cCwgYWxpZ25tZW50X29mZnNl
dDsKPj4+Pj4gK8KgwqDCoCB1bnNpZ25lZCBpbnQgcXVldWVfZGVwdGg7Cj4+Pj4+ICDCoMKgIMKg
wqDCoMKgwqAgaWYgKCF2ZGV2LT5jb25maWctPmdldCkgewo+Pj4+PiAgwqDCoMKgwqDCoMKgwqDC
oMKgwqAgZGV2X2VycigmdmRldi0+ZGV2LCAiJXMgZmFpbHVyZTogY29uZmlnIGFjY2VzcyBkaXNh
YmxlZFxuIiwKPj4+Pj4gQEAgLTc1NSwxNyArNzU2LDE4IEBAIHN0YXRpYyBpbnQgdmlydGJsa19w
cm9iZShzdHJ1Y3QgdmlydGlvX2RldmljZQo+Pj4+PiAqdmRldikKPj4+Pj4gIMKgwqDCoMKgwqDC
oMKgwqDCoMKgIGdvdG8gb3V0X2ZyZWVfdnE7Cj4+Pj4+ICDCoMKgwqDCoMKgwqAgfQo+Pj4+PiAg
wqDCoCAtwqDCoMKgIC8qIERlZmF1bHQgcXVldWUgc2l6aW5nIGlzIHRvIGZpbGwgdGhlIHJpbmcu
ICovCj4+Pj4+IC3CoMKgwqAgaWYgKCF2aXJ0YmxrX3F1ZXVlX2RlcHRoKSB7Cj4+Pj4+IC3CoMKg
wqDCoMKgwqDCoCB2aXJ0YmxrX3F1ZXVlX2RlcHRoID0gdmJsay0+dnFzWzBdLnZxLT5udW1fZnJl
ZTsKPj4+Pj4gK8KgwqDCoCBpZiAobGlrZWx5KCF2aXJ0YmxrX3F1ZXVlX2RlcHRoKSkgewo+Pj4+
PiArwqDCoMKgwqDCoMKgwqAgcXVldWVfZGVwdGggPSB2YmxrLT52cXNbMF0udnEtPm51bV9mcmVl
Owo+Pj4+PiAgwqDCoMKgwqDCoMKgwqDCoMKgwqAgLyogLi4uIGJ1dCB3aXRob3V0IGluZGlyZWN0
IGRlc2NzLCB3ZSB1c2UgMiBkZXNjcyBwZXIgcmVxICovCj4+Pj4+ICDCoMKgwqDCoMKgwqDCoMKg
wqDCoCBpZiAoIXZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fUklOR19GX0lORElSRUNU
X0RFU0MpKQo+Pj4+PiAtwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB2aXJ0YmxrX3F1ZXVlX2RlcHRo
IC89IDI7Cj4+Pj4+ICvCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIHF1ZXVlX2RlcHRoIC89IDI7Cj4+
Pj4+ICvCoMKgwqAgfSBlbHNlIHsKPj4+Pj4gK8KgwqDCoMKgwqDCoMKgIHF1ZXVlX2RlcHRoID0g
dmlydGJsa19xdWV1ZV9kZXB0aDsKPj4+Pj4gIMKgwqDCoMKgwqDCoCB9Cj4+Pj4+ICDCoMKgIMKg
wqDCoMKgwqAgbWVtc2V0KCZ2YmxrLT50YWdfc2V0LCAwLCBzaXplb2YodmJsay0+dGFnX3NldCkp
Owo+Pj4+PiAgwqDCoMKgwqDCoMKgIHZibGstPnRhZ19zZXQub3BzID0gJnZpcnRpb19tcV9vcHM7
Cj4+Pj4+IC3CoMKgwqAgdmJsay0+dGFnX3NldC5xdWV1ZV9kZXB0aCA9IHZpcnRibGtfcXVldWVf
ZGVwdGg7Cj4+Pj4+ICvCoMKgwqAgdmJsay0+dGFnX3NldC5xdWV1ZV9kZXB0aCA9IHF1ZXVlX2Rl
cHRoOwo+Pj4+PiAgwqDCoMKgwqDCoMKgIHZibGstPnRhZ19zZXQubnVtYV9ub2RlID0gTlVNQV9O
T19OT0RFOwo+Pj4+PiAgwqDCoMKgwqDCoMKgIHZibGstPnRhZ19zZXQuZmxhZ3MgPSBCTEtfTVFf
Rl9TSE9VTERfTUVSR0U7Cj4+Pj4+ICDCoMKgwqDCoMKgwqAgdmJsay0+dGFnX3NldC5jbWRfc2l6
ZSA9CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
