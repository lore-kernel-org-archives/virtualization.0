Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E4686C43217
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 09:25:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6CA17833C9;
	Wed,  9 Mar 2022 09:25:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8v4ZOKd7EVF8; Wed,  9 Mar 2022 09:25:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ED4A283E34;
	Wed,  9 Mar 2022 09:25:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A5A87C0012;
	Wed,  9 Mar 2022 09:25:25 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 442F1C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:25:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 1EB1183E34
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:25:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zihVl41UzONm
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:25:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 943EF833C9
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:25:22 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R321e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=33; SR=0; TI=SMTPD_---0V6jFhsP_1646817915; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V6jFhsP_1646817915) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 09 Mar 2022 17:25:16 +0800
Message-ID: <1646817847.746638-6-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v7 09/26] virtio_ring: split: implement
 virtqueue_reset_vring_split()
Date: Wed, 9 Mar 2022 17:24:07 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-10-xuanzhuo@linux.alibaba.com>
 <512de020-b36e-8473-69c8-8b3925fbb6c1@redhat.com>
In-Reply-To: <512de020-b36e-8473-69c8-8b3925fbb6c1@redhat.com>
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, virtualization@lists.linux-foundation.org,
 Heiko Carstens <hca@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, kvm@vger.kernel.org,
 platform-driver-x86@vger.kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 bpf@vger.kernel.org, "David S. Miller" <davem@davemloft.net>
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

T24gV2VkLCA5IE1hciAyMDIyIDE1OjU1OjQ0ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIyLzMvOCDkuIvljYg4OjM1LCBYdWFuIFpodW8g
5YaZ6YGTOgo+ID4gdmlydGlvIHJpbmcgc3VwcG9ydHMgcmVzZXQuCj4gPgo+ID4gUXVldWUgcmVz
ZXQgaXMgZGl2aWRlZCBpbnRvIHNldmVyYWwgc3RhZ2VzLgo+ID4KPiA+IDEuIG5vdGlmeSBkZXZp
Y2UgcXVldWUgcmVzZXQKPiA+IDIuIHZyaW5nIHJlbGVhc2UKPiA+IDMuIGF0dGFjaCBuZXcgdnJp
bmcKPiA+IDQuIG5vdGlmeSBkZXZpY2UgcXVldWUgcmUtZW5hYmxlCj4gPgo+ID4gQWZ0ZXIgdGhl
IGZpcnN0IHN0ZXAgaXMgY29tcGxldGVkLCB0aGUgdnJpbmcgcmVzZXQgb3BlcmF0aW9uIGNhbiBi
ZQo+ID4gcGVyZm9ybWVkLiBJZiB0aGUgbmV3bHkgc2V0IHZyaW5nIG51bSBkb2VzIG5vdCBjaGFu
Z2UsIHRoZW4ganVzdCByZXNldAo+ID4gdGhlIHZxIHJlbGF0ZWQgdmFsdWUuCj4gPgo+ID4gT3Ro
ZXJ3aXNlLCB0aGUgdnJpbmcgd2lsbCBiZSByZWxlYXNlZCBhbmQgdGhlIHZyaW5nIHdpbGwgYmUg
cmVhbGxvY2F0ZWQuCj4gPiBBbmQgdGhlIHZyaW5nIHdpbGwgYmUgYXR0YWNoZWQgdG8gdGhlIHZx
LiBJZiB0aGlzIHByb2Nlc3MgZmFpbHMsIHRoZQo+ID4gZnVuY3Rpb24gd2lsbCBleGl0LCBhbmQg
dGhlIHN0YXRlIG9mIHRoZSB2cSB3aWxsIGJlIHRoZSB2cmluZyByZWxlYXNlCj4gPiBzdGF0ZS4g
WW91IGNhbiBjYWxsIHRoaXMgZnVuY3Rpb24gYWdhaW4gdG8gcmVhbGxvY2F0ZSB0aGUgdnJpbmcu
Cj4gPgo+ID4gSW4gYWRkaXRpb24sIHZyaW5nX2FsaWduLCBtYXlfcmVkdWNlX251bSBhcmUgbmVj
ZXNzYXJ5IGZvciByZWFsbG9jYXRpbmcKPiA+IHZyaW5nLCBzbyB0aGV5IGFyZSByZXRhaW5lZCB3
aGVuIGNyZWF0aW5nIHZxLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpo
dW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiAtLS0KPiA+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlv
X3JpbmcuYyB8IDY5ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+ID4gICAx
IGZpbGUgY2hhbmdlZCwgNjkgaW5zZXJ0aW9ucygrKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+
ID4gaW5kZXggZTA0MjJjMDRjOTAzLi4xNDhmYjFmZDNkNWEgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9f
cmluZy5jCj4gPiBAQCAtMTU4LDYgKzE1OCwxMiBAQCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlIHsK
PiA+ICAgCQkJLyogRE1BIGFkZHJlc3MgYW5kIHNpemUgaW5mb3JtYXRpb24gKi8KPiA+ICAgCQkJ
ZG1hX2FkZHJfdCBxdWV1ZV9kbWFfYWRkcjsKPiA+ICAgCQkJc2l6ZV90IHF1ZXVlX3NpemVfaW5f
Ynl0ZXM7Cj4gPiArCj4gPiArCQkJLyogVGhlIHBhcmFtZXRlcnMgZm9yIGNyZWF0aW5nIHZyaW5n
cyBhcmUgcmVzZXJ2ZWQgZm9yCj4gPiArCQkJICogY3JlYXRpbmcgbmV3IHZyaW5ncyB3aGVuIGVu
YWJsaW5nIHJlc2V0IHF1ZXVlLgo+ID4gKwkJCSAqLwo+ID4gKwkJCXUzMiB2cmluZ19hbGlnbjsK
PiA+ICsJCQlib29sIG1heV9yZWR1Y2VfbnVtOwo+ID4gICAJCX0gc3BsaXQ7Cj4gPgo+ID4gICAJ
CS8qIEF2YWlsYWJsZSBmb3IgcGFja2VkIHJpbmcgKi8KPiA+IEBAIC0yMTcsNiArMjIzLDEyIEBA
IHN0cnVjdCB2cmluZ192aXJ0cXVldWUgewo+ID4gICAjZW5kaWYKPiA+ICAgfTsKPiA+Cj4gPiAr
c3RhdGljIHZvaWQgdnJpbmdfZnJlZShzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7Cj4gPiArc3RhdGlj
IHZvaWQgX192cmluZ192aXJ0cXVldWVfaW5pdF9zcGxpdChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVl
ICp2cSwKPiA+ICsJCQkJCSBzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldik7Cj4gPiArc3RhdGlj
IGludCBfX3ZyaW5nX3ZpcnRxdWV1ZV9hdHRhY2hfc3BsaXQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1
ZSAqdnEsCj4gPiArCQkJCQkgIHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LAo+ID4gKwkJCQkJ
ICBzdHJ1Y3QgdnJpbmcgdnJpbmcpOwo+ID4KPiA+ICAgLyoKPiA+ICAgICogSGVscGVycy4KPiA+
IEBAIC0xMDEyLDYgKzEwMjQsOCBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3Jl
YXRlX3ZpcnRxdWV1ZV9zcGxpdCgKPiA+ICAgCQlyZXR1cm4gTlVMTDsKPiA+ICAgCX0KPiA+Cj4g
PiArCXRvX3Z2cSh2cSktPnNwbGl0LnZyaW5nX2FsaWduID0gdnJpbmdfYWxpZ247Cj4gPiArCXRv
X3Z2cSh2cSktPnNwbGl0Lm1heV9yZWR1Y2VfbnVtID0gbWF5X3JlZHVjZV9udW07Cj4gPiAgIAl0
b192dnEodnEpLT5zcGxpdC5xdWV1ZV9kbWFfYWRkciA9IHZyaW5nLmRtYV9hZGRyOwo+ID4gICAJ
dG9fdnZxKHZxKS0+c3BsaXQucXVldWVfc2l6ZV9pbl9ieXRlcyA9IHZyaW5nLnF1ZXVlX3NpemVf
aW5fYnl0ZXM7Cj4gPiAgIAl0b192dnEodnEpLT53ZV9vd25fcmluZyA9IHRydWU7Cj4gPiBAQCAt
MTAxOSw2ICsxMDMzLDU5IEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19jcmVhdGVf
dmlydHF1ZXVlX3NwbGl0KAo+ID4gICAJcmV0dXJuIHZxOwo+ID4gICB9Cj4gPgo+ID4gK3N0YXRp
YyBpbnQgdmlydHF1ZXVlX3Jlc2V0X3ZyaW5nX3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92cSwg
dTMyIG51bSkKPiA+ICt7Cj4KPgo+IFNvIHdoYXQgdGhpcyBmdW5jdGlvbiBkb2VzIGlzIHRvIHJl
c2l6ZSB0aGUgdmlydHF1ZXVlIGFjdHVhbGx5LCBJCj4gc3VnZ2VzdCB0byByZW5hbWUgaXQgYXMg
dmlydHF1ZXVlX3Jlc2l6ZV9zcGxpdCgpLgoKT0suCgo+Cj4KPiA+ICsJc3RydWN0IHZyaW5nX3Zp
cnRxdWV1ZSAqdnEgPSB0b192dnEoX3ZxKTsKPiA+ICsJc3RydWN0IHZpcnRpb19kZXZpY2UgKnZk
ZXYgPSBfdnEtPnZkZXY7Cj4gPiArCXN0cnVjdCB2cmluZ19zcGxpdCB2cmluZzsKPiA+ICsJaW50
IGVycjsKPiA+ICsKPiA+ICsJaWYgKG51bSA+IF92cS0+bnVtX21heCkKPiA+ICsJCXJldHVybiAt
RTJCSUc7Cj4gPiArCj4gPiArCXN3aXRjaCAodnEtPnZxLnJlc2V0KSB7Cj4gPiArCWNhc2UgVklS
VElPX1ZRX1JFU0VUX1NURVBfTk9ORToKPiA+ICsJCXJldHVybiAtRU5PRU5UOwo+ID4gKwo+ID4g
KwljYXNlIFZJUlRJT19WUV9SRVNFVF9TVEVQX1ZSSU5HX0FUVEFDSDoKPiA+ICsJY2FzZSBWSVJU
SU9fVlFfUkVTRVRfU1RFUF9ERVZJQ0U6Cj4gPiArCQlpZiAodnEtPnNwbGl0LnZyaW5nLm51bSA9
PSBudW0gfHwgIW51bSkKPiA+ICsJCQlicmVhazsKPiA+ICsKPiA+ICsJCXZyaW5nX2ZyZWUoX3Zx
KTsKPiA+ICsKPiA+ICsJCWZhbGx0aHJvdWdoOwo+ID4gKwo+ID4gKwljYXNlIFZJUlRJT19WUV9S
RVNFVF9TVEVQX1ZSSU5HX1JFTEVBU0U6Cj4gPiArCQlpZiAoIW51bSkKPiA+ICsJCQludW0gPSB2
cS0+c3BsaXQudnJpbmcubnVtOwo+ID4gKwo+ID4gKwkJZXJyID0gdnJpbmdfY3JlYXRlX3ZyaW5n
X3NwbGl0KCZ2cmluZywgdmRldiwKPiA+ICsJCQkJCSAgICAgICB2cS0+c3BsaXQudnJpbmdfYWxp
Z24sCj4gPiArCQkJCQkgICAgICAgdnEtPndlYWtfYmFycmllcnMsCj4gPiArCQkJCQkgICAgICAg
dnEtPnNwbGl0Lm1heV9yZWR1Y2VfbnVtLCBudW0pOwo+ID4gKwkJaWYgKGVycikKPiA+ICsJCQly
ZXR1cm4gLUVOT01FTTsKPgo+Cj4gV2UnZCBiZXR0ZXIgbmVlZCBhIHNhZmUgZmFsbGJhY2sgaGVy
ZSBsaWtlOgo+Cj4gSWYgd2UgY2FuJ3QgYWxsb2NhdGUgbmV3IG1lbW9yeSwgd2UgY2FuIGtlZXAg
dXNpbmcgdGhlIGN1cnJlbnQgb25lLgo+IE90aGVyd2lzZSBhbiBldGh0b29sIC1HIGZhaWwgbWF5
IG1ha2UgdGhlIGRldmljZSBub3QgdXNhYmxlLgo+Cj4gVGhpcyBjb3VsZCBiZSBkb25lIGJ5IG5v
dCBmcmVlaW5nIHRoZSBvbGQgdnJpbmcgYW5kIHZpcnRxdWV1ZSBzdGF0ZXMKPiB1bnRpbCBuZXcg
aXMgYWxsb2NhdGVkLgoKSSd2ZSBiZWVuIHRoaW5raW5nIHRoZSBzYW1lIHRoaW5nIGZvciB0aGUg
cGFzdCB0d28gZGF5cy4KCj4KPgo+ID4gKwo+ID4gKwkJZXJyID0gX192cmluZ192aXJ0cXVldWVf
YXR0YWNoX3NwbGl0KHZxLCB2ZGV2LCB2cmluZy52cmluZyk7Cj4gPiArCQlpZiAoZXJyKSB7Cj4g
PiArCQkJdnJpbmdfZnJlZV9xdWV1ZSh2ZGV2LCB2cmluZy5xdWV1ZV9zaXplX2luX2J5dGVzLAo+
ID4gKwkJCQkJIHZyaW5nLnF1ZXVlLAo+ID4gKwkJCQkJIHZyaW5nLmRtYV9hZGRyKTsKPiA+ICsJ
CQlyZXR1cm4gLUVOT01FTTsKPiA+ICsJCX0KPiA+ICsKPiA+ICsJCXZxLT5zcGxpdC5xdWV1ZV9k
bWFfYWRkciA9IHZyaW5nLmRtYV9hZGRyOwo+ID4gKwkJdnEtPnNwbGl0LnF1ZXVlX3NpemVfaW5f
Ynl0ZXMgPSB2cmluZy5xdWV1ZV9zaXplX2luX2J5dGVzOwo+ID4gKwl9Cj4gPiArCj4gPiArCV9f
dnJpbmdfdmlydHF1ZXVlX2luaXRfc3BsaXQodnEsIHZkZXYpOwo+ID4gKwl2cS0+d2Vfb3duX3Jp
bmcgPSB0cnVlOwo+Cj4KPiBUaGlzIHNlZW1zIHdyb25nLCB3ZSBoYXZlIHRoZSB0cmFuc3BvcnQg
KHJwcm9jL21seHRiZikgdGhhdCBhbGxvY2F0ZSB0aGUKPiB2cmluZyBieSB0aGVtc2VsdmVzLiBJ
IHRoaW5rIHdlIG5lZWQgdG8gZmFpbCB0aGUgcmVzaXplIGZvciB3ZV9vd25fcmluZwo+ID09IGZh
bHNlLgoKT2gsIGl0IHR1cm5zIG91dCB0aGF0IHdlX293bl9yaW5nIGlzIGZvciB0aGlzIHB1cnBv
c2UuCgpUaGFua3MuCgo+Cj4gVGhhbmtzCj4KPgo+Cj4gPiArCXZxLT52cS5yZXNldCA9IFZJUlRJ
T19WUV9SRVNFVF9TVEVQX1ZSSU5HX0FUVEFDSDsKPiA+ICsKPiA+ICsJcmV0dXJuIDA7Cj4gPiAr
fQo+ID4gKwo+ID4KPiA+ICAgLyoKPiA+ICAgICogUGFja2VkIHJpbmcgc3BlY2lmaWMgZnVuY3Rp
b25zIC0gKl9wYWNrZWQoKS4KPiA+IEBAIC0yMzE3LDYgKzIzODQsOCBAQCBzdGF0aWMgaW50IF9f
dnJpbmdfdmlydHF1ZXVlX2F0dGFjaF9zcGxpdChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwK
PiA+ICAgc3RhdGljIHZvaWQgX192cmluZ192aXJ0cXVldWVfaW5pdF9zcGxpdChzdHJ1Y3QgdnJp
bmdfdmlydHF1ZXVlICp2cSwKPiA+ICAgCQkJCQkgc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYp
Cj4gPiAgIHsKPiA+ICsJdnEtPnZxLnJlc2V0ID0gVklSVElPX1ZRX1JFU0VUX1NURVBfTk9ORTsK
PiA+ICsKPiA+ICAgCXZxLT5wYWNrZWRfcmluZyA9IGZhbHNlOwo+ID4gICAJdnEtPndlX293bl9y
aW5nID0gZmFsc2U7Cj4gPiAgIAl2cS0+YnJva2VuID0gZmFsc2U7Cj4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
