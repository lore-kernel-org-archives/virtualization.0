Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3719C4321E
	for <virtualization@archiver.kernel.org>; Wed,  9 Mar 2022 09:25:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E2C060F81;
	Wed,  9 Mar 2022 09:25:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ps9DnPuSbLL6; Wed,  9 Mar 2022 09:25:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2CF2360F53;
	Wed,  9 Mar 2022 09:25:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0B03C0012;
	Wed,  9 Mar 2022 09:25:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 592F6C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:25:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 39FEB60F81
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:25:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 5R4QPgiOeoan
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:25:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5A94360F53
 for <virtualization@lists.linux-foundation.org>;
 Wed,  9 Mar 2022 09:25:43 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R281e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=33; SR=0; TI=SMTPD_---0V6j9G9H_1646817937; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V6j9G9H_1646817937) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 09 Mar 2022 17:25:38 +0800
Message-ID: <1646817926.9029093-7-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v7 13/26] virtio: queue_reset: struct virtio_config_ops
 add callbacks for queue_reset
Date: Wed, 9 Mar 2022 17:25:26 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220308123518.33800-1-xuanzhuo@linux.alibaba.com>
 <20220308123518.33800-14-xuanzhuo@linux.alibaba.com>
 <a3782384-c7e5-b0b3-6529-3aa3b8b589de@redhat.com>
In-Reply-To: <a3782384-c7e5-b0b3-6529-3aa3b8b589de@redhat.com>
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

T24gV2VkLCA5IE1hciAyMDIyIDE2OjQ3OjExICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIyLzMvOCDkuIvljYg4OjM1LCBYdWFuIFpodW8g
5YaZ6YGTOgo+ID4gUGVyZm9ybWluZyByZXNldCBvbiBhIHF1ZXVlIGlzIGRpdmlkZWQgaW50byBm
b3VyIHN0ZXBzOgo+ID4KPiA+ICAgMS4gcmVzZXRfdnEoKSAgICAgICAgICAgICAgICAgICAgIC0g
bm90aWZ5IHRoZSBkZXZpY2UgdG8gcmVzZXQgdGhlIHF1ZXVlCj4gPiAgIDIuIHZpcnRxdWV1ZV9k
ZXRhY2hfdW51c2VkX2J1ZigpICAtIHJlY3ljbGUgdGhlIGJ1ZmZlciBzdWJtaXR0ZWQKPiA+ICAg
My4gdmlydHF1ZXVlX3Jlc2V0X3ZyaW5nKCkgICAgICAgIC0gcmVzZXQgdGhlIHZyaW5nIChtYXkg
cmUtYWxsb2MpCj4gPiAgIDQuIGVuYWJsZV9yZXNldF92cSgpICAgICAgICAgICAgICAtIG1tYXAg
dnJpbmcgdG8gZGV2aWNlLCBhbmQgZW5hYmxlIHRoZSBxdWV1ZQo+ID4KPiA+IFNvIGFkZCB0d28g
Y2FsbGJhY2tzIHJlc2V0X3ZxLCBlbmFibGVfcmVzZXRfdnEgdG8gc3RydWN0Cj4gPiB2aXJ0aW9f
Y29uZmlnX29wcy4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPgo+ID4gLS0tCj4gPiAgIGluY2x1ZGUvbGludXgvdmlydGlvX2NvbmZp
Zy5oIHwgMTEgKysrKysrKysrKysKPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMo
KykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmggYi9p
bmNsdWRlL2xpbnV4L3ZpcnRpb19jb25maWcuaAo+ID4gaW5kZXggNGQxMDdhZDMxMTQ5Li5kNTE5
MDZiMTM4OWYgMTAwNjQ0Cj4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpb19jb25maWcuaAo+
ID4gKysrIGIvaW5jbHVkZS9saW51eC92aXJ0aW9fY29uZmlnLmgKPiA+IEBAIC03NCw2ICs3NCwx
NSBAQCBzdHJ1Y3QgdmlydGlvX3NobV9yZWdpb24gewo+ID4gICAgKiBAc2V0X3ZxX2FmZmluaXR5
OiBzZXQgdGhlIGFmZmluaXR5IGZvciBhIHZpcnRxdWV1ZSAob3B0aW9uYWwpLgo+ID4gICAgKiBA
Z2V0X3ZxX2FmZmluaXR5OiBnZXQgdGhlIGFmZmluaXR5IGZvciBhIHZpcnRxdWV1ZSAob3B0aW9u
YWwpLgo+ID4gICAgKiBAZ2V0X3NobV9yZWdpb246IGdldCBhIHNoYXJlZCBtZW1vcnkgcmVnaW9u
IGJhc2VkIG9uIHRoZSBpbmRleC4KPiA+ICsgKiBAcmVzZXRfdnE6IHJlc2V0IGEgcXVldWUgaW5k
aXZpZHVhbGx5IChvcHRpb25hbCkuCj4gPiArICoJdnE6IHRoZSB2aXJ0cXVldWUKPiA+ICsgKglS
ZXR1cm5zIDAgb24gc3VjY2VzcyBvciBlcnJvciBzdGF0dXMKPiA+ICsgKglDYWxsZXIgc2hvdWxk
IGd1YXJhbnRlZSB0aGF0IHRoZSB2cmluZyBpcyBub3QgYWNjZXNzZWQgYnkgYW55IGZ1bmN0aW9u
cwo+ID4gKyAqCW9mIHZpcnRxdWV1ZS4KPgo+Cj4gV2UgcHJvYmFibHkgbmVlZCB0byBiZSBtb3Jl
IGFjY3VyYXRlIGhlcmU6Cj4KPiAxKSByZXNldF92cSB3aWxsIGd1YXJhbnRlZSB0aGF0IHRoZSBj
YWxsYmFja3MgYXJlIGRpc2FibGVkIG9yIHN5bmNocm9uaXplZAo+IDIpIGV4Y2VwdCBmb3IgdGhl
IGNhbGxiYWNrLCB0aGUgY2FsbGVyIHNob3VsZCBndWFyYW50ZWUgLi4uCgpPSy4KClRoYW5rcy4K
Cj4KPiBUaGFua3MKPgo+Cj4gPiArICogQGVuYWJsZV9yZXNldF92cTogZW5hYmxlIGEgcmVzZXQg
cXVldWUKPiA+ICsgKgl2cTogdGhlIHZpcnRxdWV1ZQo+ID4gKyAqCVJldHVybnMgMCBvbiBzdWNj
ZXNzIG9yIGVycm9yIHN0YXR1cwo+ID4gKyAqCUlmIHJlc2V0X3ZxIGlzIHNldCwgdGhlbiBlbmFi
bGVfcmVzZXRfdnEgbXVzdCBhbHNvIGJlIHNldC4KPiA+ICAgICovCj4gPiAgIHR5cGVkZWYgdm9p
ZCB2cV9jYWxsYmFja190KHN0cnVjdCB2aXJ0cXVldWUgKik7Cj4gPiAgIHN0cnVjdCB2aXJ0aW9f
Y29uZmlnX29wcyB7Cj4gPiBAQCAtMTAwLDYgKzEwOSw4IEBAIHN0cnVjdCB2aXJ0aW9fY29uZmln
X29wcyB7Cj4gPiAgIAkJCWludCBpbmRleCk7Cj4gPiAgIAlib29sICgqZ2V0X3NobV9yZWdpb24p
KHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2LAo+ID4gICAJCQkgICAgICAgc3RydWN0IHZpcnRp
b19zaG1fcmVnaW9uICpyZWdpb24sIHU4IGlkKTsKPiA+ICsJaW50ICgqcmVzZXRfdnEpKHN0cnVj
dCB2aXJ0cXVldWUgKnZxKTsKPiA+ICsJaW50ICgqZW5hYmxlX3Jlc2V0X3ZxKShzdHJ1Y3Qgdmly
dHF1ZXVlICp2cSk7Cj4gPiAgIH07Cj4gPgo+ID4gICAvKiBJZiBkcml2ZXIgZGlkbid0IGFkdmVy
dGlzZSB0aGUgZmVhdHVyZSwgaXQgd2lsbCBuZXZlciBhcHBlYXIuICovCj4KX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
