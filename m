Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 003E4C433F5
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 09:22:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A1C98417D3;
	Wed,  9 Mar 2022 09:22:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YrnvVIot8_Vb; Wed,  9 Mar 2022 09:22:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2195C41684;
	Wed,  9 Mar 2022 09:22:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA3AFC0012;
	Wed,  9 Mar 2022 09:22:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FCBCC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:22:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0E15D40159
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:22:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lZylrXAYexav
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:22:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BCAC64002B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:22:02 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R761e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=33; SR=0; TI=SMTPD_---0V6j1jVj_1646817715; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V6j1jVj_1646817715) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 09 Mar 2022 17:21:57 +0800
Message-ID: <1646817687.2614713-4-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v7 05/26] virtio_ring: split: extract the logic of init vq
 and attach vring
Date: Wed, 9 Mar 2022 17:21:27 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-6-xuanzhuo@linux.alibaba.com>
 <85dde6ed-cdf1-61e4-6f05-d3e2477b9e35@redhat.com>
In-Reply-To: <85dde6ed-cdf1-61e4-6f05-d3e2477b9e35@redhat.com>
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

T24gV2VkLCA5IE1hciAyMDIyIDE1OjM2OjU5ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIyLzMvOCDkuIvljYg4OjM0LCBYdWFuIFpodW8g
5YaZ6YGTOgo+ID4gU3BsaXQgdGhlIGxvZ2ljIG9mIHNwbGl0IGFzc2lnbm1lbnQgdnEgaW50byB0
aHJlZSBwYXJ0cy4KPiA+Cj4gPiAxLiBUaGUgYXNzaWdubWVudCBwYXNzZWQgZnJvbSB0aGUgZnVu
Y3Rpb24gcGFyYW1ldGVyCj4gPiAyLiBUaGUgcGFydCB0aGF0IGF0dGFjaGVzIHZyaW5nIHRvIHZx
LiAtLSBfX3ZyaW5nX3ZpcnRxdWV1ZV9hdHRhY2hfc3BsaXQoKQo+ID4gMy4gVGhlIHBhcnQgdGhh
dCBpbml0aWFsaXplcyB2cSB0byBhIGZpeGVkIHZhbHVlIC0tCj4gPiAgICAgX192cmluZ192aXJ0
cXVldWVfaW5pdF9zcGxpdCgpCj4gPgo+ID4gVGhpcyBmZWF0dXJlIGlzIHJlcXVpcmVkIGZvciBz
dWJzZXF1ZW50IHZpcnR1cXVldWUgcmVzZXQgdnJpbmcKPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBY
dWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+ID4gLS0tCj4gPiAgIGRyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAxMTEgKysrKysrKysrKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDY3IGluc2VydGlvbnMoKyksIDQ0IGRlbGV0
aW9ucygtKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5j
IGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ID4gaW5kZXggZDMyNzkzNjE1NDUxLi5k
YzYzMTNiNzkzMDUgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5j
Cj4gPiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gPiBAQCAtMjE5NiwzNCAr
MjE5Niw0MCBAQCBpcnFyZXR1cm5fdCB2cmluZ19pbnRlcnJ1cHQoaW50IGlycSwgdm9pZCAqX3Zx
KQo+ID4gICB9Cj4gPiAgIEVYUE9SVF9TWU1CT0xfR1BMKHZyaW5nX2ludGVycnVwdCk7Cj4gPgo+
ID4gLS8qIE9ubHkgYXZhaWxhYmxlIGZvciBzcGxpdCByaW5nICovCj4gPiAtc3RydWN0IHZpcnRx
dWV1ZSAqX192cmluZ19uZXdfdmlydHF1ZXVlKHVuc2lnbmVkIGludCBpbmRleCwKPiA+IC0JCQkJ
CXN0cnVjdCB2cmluZyB2cmluZywKPiA+IC0JCQkJCXN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2
LAo+ID4gLQkJCQkJYm9vbCB3ZWFrX2JhcnJpZXJzLAo+ID4gLQkJCQkJYm9vbCBjb250ZXh0LAo+
ID4gLQkJCQkJYm9vbCAoKm5vdGlmeSkoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPiA+IC0JCQkJCXZv
aWQgKCpjYWxsYmFjaykoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPiA+IC0JCQkJCWNvbnN0IGNoYXIg
Km5hbWUpCj4gPiArc3RhdGljIGludCBfX3ZyaW5nX3ZpcnRxdWV1ZV9hdHRhY2hfc3BsaXQoc3Ry
dWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEsCj4gPiArCQkJCQkgIHN0cnVjdCB2aXJ0aW9fZGV2aWNl
ICp2ZGV2LAo+ID4gKwkJCQkJICBzdHJ1Y3QgdnJpbmcgdnJpbmcpCj4gPiAgIHsKPiA+IC0Jc3Ry
dWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnE7Cj4gPiArCXZxLT52cS5udW1fZnJlZSA9IHZyaW5nLm51
bTsKPiA+Cj4gPiAtCWlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX0ZfUklOR19Q
QUNLRUQpKQo+ID4gLQkJcmV0dXJuIE5VTEw7Cj4gPiArCXZxLT5zcGxpdC52cmluZyA9IHZyaW5n
Owo+ID4gKwl2cS0+c3BsaXQucXVldWVfZG1hX2FkZHIgPSAwOwo+ID4gKwl2cS0+c3BsaXQucXVl
dWVfc2l6ZV9pbl9ieXRlcyA9IDA7Cj4gPgo+ID4gLQl2cSA9IGttYWxsb2Moc2l6ZW9mKCp2cSks
IEdGUF9LRVJORUwpOwo+ID4gLQlpZiAoIXZxKQo+ID4gLQkJcmV0dXJuIE5VTEw7Cj4gPiArCXZx
LT5zcGxpdC5kZXNjX3N0YXRlID0ga21hbGxvY19hcnJheSh2cmluZy5udW0sCj4gPiArCQkJCQkg
ICAgIHNpemVvZihzdHJ1Y3QgdnJpbmdfZGVzY19zdGF0ZV9zcGxpdCksIEdGUF9LRVJORUwpOwo+
ID4gKwlpZiAoIXZxLT5zcGxpdC5kZXNjX3N0YXRlKQo+ID4gKwkJZ290byBlcnJfc3RhdGU7Cj4g
Pgo+ID4gKwl2cS0+c3BsaXQuZGVzY19leHRyYSA9IHZyaW5nX2FsbG9jX2Rlc2NfZXh0cmEodnEs
IHZyaW5nLm51bSk7Cj4gPiArCWlmICghdnEtPnNwbGl0LmRlc2NfZXh0cmEpCj4gPiArCQlnb3Rv
IGVycl9leHRyYTsKPgo+Cj4gU28gdGhpcyBjb250YWlucyBzdHVmZnMgbW9yZSB0aGFuIGp1c3Qg
YXR0YWNoLiBJIHdvbmRlciBpZiBpdCdzIGJldHRlcgo+IHRvIHNwbGl0IHRoZSBhbGxvY2F0aW9u
IG91dCB0byBhbiBkZWRpY2F0ZWQgaGVscGVyICh3ZSBoYXZlIGRlZGljYXRlZAo+IGhlbHBlciB0
byBhbGxvY2F0ZSB2cmluZykuCgpJIHdpbGwgdHJ5IGluIG5leHQgdmVyc2lvbi4KClRoYW5rcy4K
Cj4KPiBUaGFua3MKPgo+Cj4gPiArCj4gPiArCW1lbXNldCh2cS0+c3BsaXQuZGVzY19zdGF0ZSwg
MCwgdnJpbmcubnVtICoKPiA+ICsJICAgICAgIHNpemVvZihzdHJ1Y3QgdnJpbmdfZGVzY19zdGF0
ZV9zcGxpdCkpOwo+ID4gKwlyZXR1cm4gMDsKPiA+ICsKPiA+ICtlcnJfZXh0cmE6Cj4gPiArCWtm
cmVlKHZxLT5zcGxpdC5kZXNjX3N0YXRlKTsKPiA+ICtlcnJfc3RhdGU6Cj4gPiArCXJldHVybiAt
RU5PTUVNOwo+ID4gK30KPiA+ICsKPiA+ICtzdGF0aWMgdm9pZCBfX3ZyaW5nX3ZpcnRxdWV1ZV9p
bml0X3NwbGl0KHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxLAo+ID4gKwkJCQkJIHN0cnVjdCB2
aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gK3sKPiA+ICAgCXZxLT5wYWNrZWRfcmluZyA9IGZhbHNl
Owo+ID4gLQl2cS0+dnEuY2FsbGJhY2sgPSBjYWxsYmFjazsKPiA+IC0JdnEtPnZxLnZkZXYgPSB2
ZGV2Owo+ID4gLQl2cS0+dnEubmFtZSA9IG5hbWU7Cj4gPiAtCXZxLT52cS5udW1fZnJlZSA9IHZy
aW5nLm51bTsKPiA+IC0JdnEtPnZxLmluZGV4ID0gaW5kZXg7Cj4gPiAgIAl2cS0+d2Vfb3duX3Jp
bmcgPSBmYWxzZTsKPiA+IC0JdnEtPm5vdGlmeSA9IG5vdGlmeTsKPiA+IC0JdnEtPndlYWtfYmFy
cmllcnMgPSB3ZWFrX2JhcnJpZXJzOwo+ID4gICAJdnEtPmJyb2tlbiA9IGZhbHNlOwo+ID4gICAJ
dnEtPmxhc3RfdXNlZF9pZHggPSAwOwo+ID4gICAJdnEtPmV2ZW50X3RyaWdnZXJlZCA9IGZhbHNl
Owo+ID4gQEAgLTIyMzQsNTAgKzIyNDAsNjcgQEAgc3RydWN0IHZpcnRxdWV1ZSAqX192cmluZ19u
ZXdfdmlydHF1ZXVlKHVuc2lnbmVkIGludCBpbmRleCwKPiA+ICAgCXZxLT5sYXN0X2FkZF90aW1l
X3ZhbGlkID0gZmFsc2U7Cj4gPiAgICNlbmRpZgo+ID4KPiA+IC0JdnEtPmluZGlyZWN0ID0gdmly
dGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19SSU5HX0ZfSU5ESVJFQ1RfREVTQykgJiYKPiA+
IC0JCSFjb250ZXh0Owo+ID4gICAJdnEtPmV2ZW50ID0gdmlydGlvX2hhc19mZWF0dXJlKHZkZXYs
IFZJUlRJT19SSU5HX0ZfRVZFTlRfSURYKTsKPiA+Cj4gPiAgIAlpZiAodmlydGlvX2hhc19mZWF0
dXJlKHZkZXYsIFZJUlRJT19GX09SREVSX1BMQVRGT1JNKSkKPiA+ICAgCQl2cS0+d2Vha19iYXJy
aWVycyA9IGZhbHNlOwo+ID4KPiA+IC0JdnEtPnNwbGl0LnF1ZXVlX2RtYV9hZGRyID0gMDsKPiA+
IC0JdnEtPnNwbGl0LnF1ZXVlX3NpemVfaW5fYnl0ZXMgPSAwOwo+ID4gLQo+ID4gLQl2cS0+c3Bs
aXQudnJpbmcgPSB2cmluZzsKPiA+ICAgCXZxLT5zcGxpdC5hdmFpbF9mbGFnc19zaGFkb3cgPSAw
Owo+ID4gICAJdnEtPnNwbGl0LmF2YWlsX2lkeF9zaGFkb3cgPSAwOwo+ID4KPiA+ICAgCS8qIE5v
IGNhbGxiYWNrPyAgVGVsbCBvdGhlciBzaWRlIG5vdCB0byBib3RoZXIgdXMuICovCj4gPiAtCWlm
ICghY2FsbGJhY2spIHsKPiA+ICsJaWYgKCF2cS0+dnEuY2FsbGJhY2spIHsKPiA+ICAgCQl2cS0+
c3BsaXQuYXZhaWxfZmxhZ3Nfc2hhZG93IHw9IFZSSU5HX0FWQUlMX0ZfTk9fSU5URVJSVVBUOwo+
ID4gICAJCWlmICghdnEtPmV2ZW50KQo+ID4gICAJCQl2cS0+c3BsaXQudnJpbmcuYXZhaWwtPmZs
YWdzID0gY3B1X3RvX3ZpcnRpbzE2KHZkZXYsCj4gPiAgIAkJCQkJdnEtPnNwbGl0LmF2YWlsX2Zs
YWdzX3NoYWRvdyk7Cj4gPiAgIAl9Cj4gPgo+ID4gLQl2cS0+c3BsaXQuZGVzY19zdGF0ZSA9IGtt
YWxsb2NfYXJyYXkodnJpbmcubnVtLAo+ID4gLQkJCXNpemVvZihzdHJ1Y3QgdnJpbmdfZGVzY19z
dGF0ZV9zcGxpdCksIEdGUF9LRVJORUwpOwo+ID4gLQlpZiAoIXZxLT5zcGxpdC5kZXNjX3N0YXRl
KQo+ID4gLQkJZ290byBlcnJfc3RhdGU7Cj4gPiAtCj4gPiAtCXZxLT5zcGxpdC5kZXNjX2V4dHJh
ID0gdnJpbmdfYWxsb2NfZGVzY19leHRyYSh2cSwgdnJpbmcubnVtKTsKPiA+IC0JaWYgKCF2cS0+
c3BsaXQuZGVzY19leHRyYSkKPiA+IC0JCWdvdG8gZXJyX2V4dHJhOwo+ID4gLQo+ID4gICAJLyog
UHV0IGV2ZXJ5dGhpbmcgaW4gZnJlZSBsaXN0cy4gKi8KPiA+ICAgCXZxLT5mcmVlX2hlYWQgPSAw
Owo+ID4gLQltZW1zZXQodnEtPnNwbGl0LmRlc2Nfc3RhdGUsIDAsIHZyaW5nLm51bSAqCj4gPiAt
CQkJc2l6ZW9mKHN0cnVjdCB2cmluZ19kZXNjX3N0YXRlX3NwbGl0KSk7Cj4gPiArfQo+ID4gKwo+
ID4gKy8qIE9ubHkgYXZhaWxhYmxlIGZvciBzcGxpdCByaW5nICovCj4gPiArc3RydWN0IHZpcnRx
dWV1ZSAqX192cmluZ19uZXdfdmlydHF1ZXVlKHVuc2lnbmVkIGludCBpbmRleCwKPiA+ICsJCQkJ
CXN0cnVjdCB2cmluZyB2cmluZywKPiA+ICsJCQkJCXN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2
LAo+ID4gKwkJCQkJYm9vbCB3ZWFrX2JhcnJpZXJzLAo+ID4gKwkJCQkJYm9vbCBjb250ZXh0LAo+
ID4gKwkJCQkJYm9vbCAoKm5vdGlmeSkoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPiA+ICsJCQkJCXZv
aWQgKCpjYWxsYmFjaykoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPiA+ICsJCQkJCWNvbnN0IGNoYXIg
Km5hbWUpCj4gPiArewo+ID4gKwlzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cTsKPiA+ICsJaW50
IGVycjsKPiA+ICsKPiA+ICsJaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fRl9S
SU5HX1BBQ0tFRCkpCj4gPiArCQlyZXR1cm4gTlVMTDsKPiA+ICsKPiA+ICsJdnEgPSBrbWFsbG9j
KHNpemVvZigqdnEpLCBHRlBfS0VSTkVMKTsKPiA+ICsJaWYgKCF2cSkKPiA+ICsJCXJldHVybiBO
VUxMOwo+ID4gKwo+ID4gKwl2cS0+dnEuY2FsbGJhY2sgPSBjYWxsYmFjazsKPiA+ICsJdnEtPnZx
LnZkZXYgPSB2ZGV2Owo+ID4gKwl2cS0+dnEubmFtZSA9IG5hbWU7Cj4gPiArCXZxLT52cS5pbmRl
eCA9IGluZGV4Owo+ID4gKwl2cS0+bm90aWZ5ID0gbm90aWZ5Owo+ID4gKwl2cS0+d2Vha19iYXJy
aWVycyA9IHdlYWtfYmFycmllcnM7Cj4gPiArCXZxLT5pbmRpcmVjdCA9IHZpcnRpb19oYXNfZmVh
dHVyZSh2ZGV2LCBWSVJUSU9fUklOR19GX0lORElSRUNUX0RFU0MpICYmCj4gPiArCQkhY29udGV4
dDsKPiA+ICsKPiA+ICsJZXJyID0gX192cmluZ192aXJ0cXVldWVfYXR0YWNoX3NwbGl0KHZxLCB2
ZGV2LCB2cmluZyk7Cj4gPiArCWlmIChlcnIpCj4gPiArCQlnb3RvIGVycjsKPiA+ICsKPiA+ICsJ
X192cmluZ192aXJ0cXVldWVfaW5pdF9zcGxpdCh2cSwgdmRldik7Cj4gPgo+ID4gICAJc3Bpbl9s
b2NrKCZ2ZGV2LT52cXNfbGlzdF9sb2NrKTsKPiA+ICAgCWxpc3RfYWRkX3RhaWwoJnZxLT52cS5s
aXN0LCAmdmRldi0+dnFzKTsKPiA+ICAgCXNwaW5fdW5sb2NrKCZ2ZGV2LT52cXNfbGlzdF9sb2Nr
KTsKPiA+IC0JcmV0dXJuICZ2cS0+dnE7Cj4gPgo+ID4gLWVycl9leHRyYToKPiA+IC0Ja2ZyZWUo
dnEtPnNwbGl0LmRlc2Nfc3RhdGUpOwo+ID4gLWVycl9zdGF0ZToKPiA+ICsJcmV0dXJuICZ2cS0+
dnE7Cj4gPiArZXJyOgo+ID4gICAJa2ZyZWUodnEpOwo+ID4gICAJcmV0dXJuIE5VTEw7Cj4gPiAg
IH0KPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
