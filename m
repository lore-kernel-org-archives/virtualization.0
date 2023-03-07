Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41A92C678D4
	for <virtualization@archiver.kernel.org>; Tue,  7 Mar 2023 07:21:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B1F9C40484;
	Tue,  7 Mar 2023 07:21:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B1F9C40484
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LlbFyzD2RkS9; Tue,  7 Mar 2023 07:21:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0EF604010F;
	Tue,  7 Mar 2023 07:21:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0EF604010F
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D5A61C0071;
	Tue,  7 Mar 2023 07:21:54 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D0B94C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 07:21:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A392B813EE
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 07:21:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A392B813EE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5k9zFbsAtZaa
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 07:21:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F3B44813E5
Received: from out30-111.freemail.mail.aliyun.com
 (out30-111.freemail.mail.aliyun.com [115.124.30.111])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F3B44813E5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  7 Mar 2023 07:21:51 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R821e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=3; SR=0;
 TI=SMTPD_---0VdKPl7d_1678173706; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VdKPl7d_1678173706) by smtp.aliyun-inc.com;
 Tue, 07 Mar 2023 15:21:47 +0800
Message-ID: <1678173052.7791555-6-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v1 11/12] virtio_ring: separate the logic of
 reset/enable from virtqueue_resize
Date: Tue, 7 Mar 2023 15:10:52 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230302115908.1461-1-xuanzhuo@linux.alibaba.com>
 <20230302115908.1461-12-xuanzhuo@linux.alibaba.com>
 <CACGkMEsbmN6Tnsz3kAOraY1=QVNvids91RW3EDwWAP=N7jEAng@mail.gmail.com>
In-Reply-To: <CACGkMEsbmN6Tnsz3kAOraY1=QVNvids91RW3EDwWAP=N7jEAng@mail.gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
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
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVHVlLCA3IE1hciAyMDIzIDE0OjQzOjU4ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPiBPbiBUaHUsIE1hciAyLCAyMDIzIGF0IDc6NTnigK9QTSBYdWFu
IFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+Cj4gPiBUaGUgc3Vi
c2VxdWVudCByZXNldCBmdW5jdGlvbiB3aWxsIHJldXNlIHRoZXNlIGxvZ2ljLgo+ID4KPiA+IFNp
Z25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiAt
LS0KPiA+ICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgNTggKysrKysrKysrKysrKysr
KysrKysrKysrLS0tLS0tLS0tLS0tCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDM5IGluc2VydGlvbnMo
KyksIDE5IGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gaW5kZXggNTAw
Y2I4NTYzZjJiLi41YWI5MTM2YTM2M2UgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcmluZy5jCj4gPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiBA
QCAtMjIxNSw2ICsyMjE1LDQzIEBAIHN0YXRpYyBpbnQgdmlydHF1ZXVlX3Jlc2l6ZV9wYWNrZWQo
c3RydWN0IHZpcnRxdWV1ZSAqX3ZxLCB1MzIgbnVtKQo+ID4gICAgICAgICByZXR1cm4gLUVOT01F
TTsKPiA+ICB9Cj4gPgo+ID4gK3N0YXRpYyBpbnQgdmlydHF1ZXVlX2Rpc2FibGVfYW5kX3JlY3lj
bGUoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxLAo+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB2b2lkICgqcmVjeWNsZSkoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHZvaWQg
KmJ1ZikpCj4gPiArewo+ID4gKyAgICAgICBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9IHRv
X3Z2cShfdnEpOwo+ID4gKyAgICAgICBzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiA9IHZxLT52
cS52ZGV2Owo+ID4gKyAgICAgICB2b2lkICpidWY7Cj4gPiArICAgICAgIGludCBlcnI7Cj4gPiAr
Cj4gPiArICAgICAgIGlmICghdnEtPndlX293bl9yaW5nKQo+ID4gKyAgICAgICAgICAgICAgIHJl
dHVybiAtRVBFUk07Cj4gPiArCj4gPiArICAgICAgIGlmICghdmRldi0+Y29uZmlnLT5kaXNhYmxl
X3ZxX2FuZF9yZXNldCkKPiA+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVOT0VOVDsKPiA+ICsK
PiA+ICsgICAgICAgaWYgKCF2ZGV2LT5jb25maWctPmVuYWJsZV92cV9hZnRlcl9yZXNldCkKPiA+
ICsgICAgICAgICAgICAgICByZXR1cm4gLUVOT0VOVDsKPiA+ICsKPiA+ICsgICAgICAgZXJyID0g
dmRldi0+Y29uZmlnLT5kaXNhYmxlX3ZxX2FuZF9yZXNldChfdnEpOwo+ID4gKyAgICAgICBpZiAo
ZXJyKQo+ID4gKyAgICAgICAgICAgICAgIHJldHVybiBlcnI7Cj4gPiArCj4gPiArICAgICAgIHdo
aWxlICgoYnVmID0gdmlydHF1ZXVlX2RldGFjaF91bnVzZWRfYnVmKF92cSkpICE9IE5VTEwpCj4g
PiArICAgICAgICAgICAgICAgcmVjeWNsZShfdnEsIGJ1Zik7Cj4gPiArCj4gPiArICAgICAgIHJl
dHVybiAwOwo+ID4gK30KPiA+ICsKPiA+ICtzdGF0aWMgaW50IHZpcnRxdWV1ZV9lbmFibGVfYWZ0
ZXJfcmVzZXQoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+ID4gK3sKPiA+ICsgICAgICAgc3RydWN0
IHZyaW5nX3ZpcnRxdWV1ZSAqdnEgPSB0b192dnEoX3ZxKTsKPiA+ICsgICAgICAgc3RydWN0IHZp
cnRpb19kZXZpY2UgKnZkZXYgPSB2cS0+dnEudmRldjsKPiA+ICsKPiA+ICsgICAgICAgaWYgKHZk
ZXYtPmNvbmZpZy0+ZW5hYmxlX3ZxX2FmdGVyX3Jlc2V0KF92cSkpCj4gPiArICAgICAgICAgICAg
ICAgcmV0dXJuIC1FQlVTWTsKPiA+ICsKPiA+ICsgICAgICAgcmV0dXJuIDA7Cj4gPiArfQo+ID4K
PiA+ICAvKgo+ID4gICAqIEdlbmVyaWMgZnVuY3Rpb25zIGFuZCBleHBvcnRlZCBzeW1ib2xzLgo+
ID4gQEAgLTI4MzYsMTMgKzI4NzMsOCBAQCBpbnQgdmlydHF1ZXVlX3Jlc2l6ZShzdHJ1Y3Qgdmly
dHF1ZXVlICpfdnEsIHUzMiBudW0sCj4gPiAgICAgICAgICAgICAgICAgICAgICB2b2lkICgqcmVj
eWNsZSkoc3RydWN0IHZpcnRxdWV1ZSAqdnEsIHZvaWQgKmJ1ZikpCj4gPiAgewo+ID4gICAgICAg
ICBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSA9IHRvX3Z2cShfdnEpOwo+ID4gLSAgICAgICBz
dHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiA9IHZxLT52cS52ZGV2Owo+ID4gLSAgICAgICB2b2lk
ICpidWY7Cj4gPiAgICAgICAgIGludCBlcnI7Cj4gPgo+ID4gLSAgICAgICBpZiAoIXZxLT53ZV9v
d25fcmluZykKPiA+IC0gICAgICAgICAgICAgICByZXR1cm4gLUVQRVJNOwo+Cj4gQW55IHJlYXNv
biB0byBtb3ZlIHRoaXMgYnV0IGtlZXAgdGhlIG51bV9tYXggY2hlY2s/CgoKVGhlIHB1cnBvc2Ug
b2YgdGhpcyBjb21taXQgaXMgdG8gc2VwYXJhdGUgZGlzYWJsZS9lbmFibGUgbG9naWMuCgpCdXQg
bnVtX21heCBjaGVjayBpcyByZXNpemUtcmVsYXRlZCwgc28gaXQgaXMgc3RpbGwgcmV0YWluZWQg
aW4gdGhpcyBmdW5jdGlvbi4KCgo+Cj4gPiAtCj4gPiAgICAgICAgIGlmIChudW0gPiB2cS0+dnEu
bnVtX21heCkKPiA+ICAgICAgICAgICAgICAgICByZXR1cm4gLUUyQklHOwo+ID4KPiA+IEBAIC0y
ODUyLDI4ICsyODg0LDE2IEBAIGludCB2aXJ0cXVldWVfcmVzaXplKHN0cnVjdCB2aXJ0cXVldWUg
Kl92cSwgdTMyIG51bSwKPiA+ICAgICAgICAgaWYgKCh2cS0+cGFja2VkX3JpbmcgPyB2cS0+cGFj
a2VkLnZyaW5nLm51bSA6IHZxLT5zcGxpdC52cmluZy5udW0pID09IG51bSkKPiA+ICAgICAgICAg
ICAgICAgICByZXR1cm4gMDsKPiA+Cj4gPiAtICAgICAgIGlmICghdmRldi0+Y29uZmlnLT5kaXNh
YmxlX3ZxX2FuZF9yZXNldCkKPiA+IC0gICAgICAgICAgICAgICByZXR1cm4gLUVOT0VOVDsKPiA+
IC0KPiA+IC0gICAgICAgaWYgKCF2ZGV2LT5jb25maWctPmVuYWJsZV92cV9hZnRlcl9yZXNldCkK
PiA+IC0gICAgICAgICAgICAgICByZXR1cm4gLUVOT0VOVDsKPiA+IC0KPiA+IC0gICAgICAgZXJy
ID0gdmRldi0+Y29uZmlnLT5kaXNhYmxlX3ZxX2FuZF9yZXNldChfdnEpOwo+ID4gKyAgICAgICBl
cnIgPSB2aXJ0cXVldWVfZGlzYWJsZV9hbmRfcmVjeWNsZShfdnEsIHJlY3ljbGUpOwo+ID4gICAg
ICAgICBpZiAoZXJyKQo+ID4gICAgICAgICAgICAgICAgIHJldHVybiBlcnI7Cj4gPgo+ID4gLSAg
ICAgICB3aGlsZSAoKGJ1ZiA9IHZpcnRxdWV1ZV9kZXRhY2hfdW51c2VkX2J1ZihfdnEpKSAhPSBO
VUxMKQo+ID4gLSAgICAgICAgICAgICAgIHJlY3ljbGUoX3ZxLCBidWYpOwo+Cj4gSSB3b25kZXIg
aWYgaXQgbWFrZXMgc2Vuc2UgdG8gZmFjdG9yIG91dCByZWN5Y2xlKCkgdG8gYmUgdXNlZCBieSBv
dGhlcgo+IGZhY2lsaXRpZXMgaW4gdGhlIGZ1dHVyZT8KCgpJIHRoaW5rIHRoYXQgZm9yIHZpcnRR
dWV1ZV9kaXNhYmxlX2FuZF9yZWN5Y2xlKCksIGl0IGlzIG1lYW5pbmdmdWwganVzdApkaXNhYmxp
bmcgdnEgYW5kIG5vIHJlY3ljbGUuIElmIHRoZXJlIGlzIHRoaXMgc2NlbmUgaW4gdGhlIGZ1dHVy
ZSwgd2Ugb25seSBuZWVkCnRvIGFsbG93IHZpcnRxdWV1ZV9kaXNhYmxlX2FuZF9yZWN5Y2xlIHRv
IGFjY2VwdCBOVUxMIGFzIHJleWNsZS4KClRoYW5zay4KCj4KPiBUaGFua3MKPgo+Cj4gPiAtCj4g
PiAgICAgICAgIGlmICh2cS0+cGFja2VkX3JpbmcpCj4gPiAgICAgICAgICAgICAgICAgZXJyID0g
dmlydHF1ZXVlX3Jlc2l6ZV9wYWNrZWQoX3ZxLCBudW0pOwo+ID4gICAgICAgICBlbHNlCj4gPiAg
ICAgICAgICAgICAgICAgZXJyID0gdmlydHF1ZXVlX3Jlc2l6ZV9zcGxpdChfdnEsIG51bSk7Cj4g
Pgo+ID4gLSAgICAgICBpZiAodmRldi0+Y29uZmlnLT5lbmFibGVfdnFfYWZ0ZXJfcmVzZXQoX3Zx
KSkKPiA+IC0gICAgICAgICAgICAgICByZXR1cm4gLUVCVVNZOwo+ID4gLQo+ID4gLSAgICAgICBy
ZXR1cm4gZXJyOwo+ID4gKyAgICAgICByZXR1cm4gdmlydHF1ZXVlX2VuYWJsZV9hZnRlcl9yZXNl
dChfdnEpOwo+ID4gIH0KPiA+ICBFWFBPUlRfU1lNQk9MX0dQTCh2aXJ0cXVldWVfcmVzaXplKTsK
PiA+Cj4gPiAtLQo+ID4gMi4zMi4wLjMuZzAxMTk1Y2Y5Zgo+ID4KPgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
