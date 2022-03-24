Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4599C433EF
	for <virtualization@archiver.kernel.org>; Thu, 24 Mar 2022 08:52:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7E06B60B6C;
	Thu, 24 Mar 2022 08:52:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id I4IJ_xZFjQP8; Thu, 24 Mar 2022 08:52:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2739460B6A;
	Thu, 24 Mar 2022 08:52:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0C6ECC001A;
	Thu, 24 Mar 2022 08:52:36 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 33BDFC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:52:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 152AC60A79
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:52:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id I24zeFzQgG8Q
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:52:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-45.freemail.mail.aliyun.com
 (out30-45.freemail.mail.aliyun.com [115.124.30.45])
 by smtp3.osuosl.org (Postfix) with ESMTPS id D86E360B6A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 24 Mar 2022 08:52:32 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R391e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04407; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=3; SR=0; TI=SMTPD_---0V83zLki_1648111949; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V83zLki_1648111949) by smtp.aliyun-inc.com(127.0.0.1);
 Thu, 24 Mar 2022 16:52:30 +0800
Message-ID: <1648111934.4249241-5-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v8 00/16] virtio pci support VIRTIO_F_RING_RESET (refactor
 vring)
Date: Thu, 24 Mar 2022 16:52:14 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220314093455.34707-1-xuanzhuo@linux.alibaba.com>
 <70194138-072d-ecec-7571-af893f22e52c@redhat.com>
In-Reply-To: <70194138-072d-ecec-7571-af893f22e52c@redhat.com>
Cc: virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

T24gVHVlLCAyMiBNYXIgMjAyMiAxNDo0MDo1MSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMi8zLzE0IOS4i+WNiDU6MzQsIFh1YW4gWmh1
byDlhpnpgZM6Cj4gPiBUaGUgdmlydGlvIHNwZWMgYWxyZWFkeSBzdXBwb3J0cyB0aGUgdmlydGlv
IHF1ZXVlIHJlc2V0IGZ1bmN0aW9uLiBUaGlzIHBhdGNoIHNldAo+ID4gaXMgdG8gYWRkIHRoaXMg
ZnVuY3Rpb24gdG8gdGhlIGtlcm5lbC4gVGhlIHJlbGV2YW50IHZpcnRpbyBzcGVjIGluZm9ybWF0
aW9uIGlzCj4gPiBoZXJlOgo+ID4KPiA+ICAgICAgaHR0cHM6Ly9naXRodWIuY29tL29hc2lzLXRj
cy92aXJ0aW8tc3BlYy9pc3N1ZXMvMTI0Cj4gPgo+ID4gQWxzbyByZWdhcmRpbmcgTU1JTyBzdXBw
b3J0IGZvciBxdWV1ZSByZXNldCwgSSBwbGFuIHRvIHN1cHBvcnQgaXQgYWZ0ZXIgdGhpcwo+ID4g
cGF0Y2ggaXMgcGFzc2VkLgo+ID4KPiA+IFRoaXMgcGF0Y2ggc2V0IGltcGxlbWVudHMgdGhlIHJl
ZmFjdG9yaW5nIG9mIHZyaW5nLiBGaW5hbGx5LCB0aGUKPiA+IHZpcnR1cXVlX3Jlc2l6ZSgpIGlu
dGVyZmFjZSBpcyBwcm92aWRlZCBiYXNlZCBvbiB0aGUgcmVzZXQgZnVuY3Rpb24gb2YgdGhlCj4g
PiB0cmFuc3BvcnQgbGF5ZXIuCj4gPgo+ID4gVGVzdCBlbnZpcm9ubWVudDoKPiA+ICAgICAgSG9z
dDogNC4xOS45MQo+ID4gICAgICBRZW11OiBRRU1VIGVtdWxhdG9yIHZlcnNpb24gNi4yLjUwICh3
aXRoIHZxIHJlc2V0IHN1cHBvcnQpCj4KPgo+IEl0IHdvdWxkIGJlIGJldHRlciBpZiB5b3UgY2Fu
IHBvc3QgUWVtdSBjb2RlIGZvciByZXZpZXcgYXMgd2VsbC4KCk9LLgoKPgo+Cj4gPiAgICAgIFRl
c3QgQ21kOiAgZXRodG9vbCAtRyBldGgxIHJ4ICQxIHR4ICQyOyBldGh0b29sIC1nIGV0aDEKPiA+
Cj4gPiAgICAgIFRoZSBkZWZhdWx0IGlzIHNwbGl0IG1vZGUsIG1vZGlmeSBRZW11IHZpcnRpby1u
ZXQgdG8gYWRkIFBBQ0tFRCBmZWF0dXJlIHRvIHRlc3QKPiA+ICAgICAgcGFja2VkIG1vZGUuCj4g
Pgo+ID4gUGxlYXNlIHJldmlldy4gVGhhbmtzLgo+Cj4KPiBMb29rcyBnb29kIG92ZXJhbGwsIHNl
ZSBjb21tZW50cyBpbiBpbmRpdmlkdWFsIHBhdGNoLgo+Cj4gSSB0aGluayB0aGUgY29kZSBpcyBz
dHJ1Y3R1cmVkIGluIGEgd2F5IHRoYXQgaXMgbm90IGZyaWVuZGx5IHRvIHRoZQo+IHJldmlld2Vy
cy4gRm9yIG5leHQgdmVyc2lvbiwgd2UgY2FuIGJyaW5nIGJhY2sgdGhlIGV0aHRvb2wgLUcgZm9y
Cj4gdmlydGlvLW5ldC4KCk9LLgoKVGhhbmtzLgoKCj4KPiBUaGFua3MKPgo+Cj4gPgo+ID4gdjg6
Cj4gPiAgICAxLiBQcm92aWRlIGEgdmlydHF1ZXVlX3Jlc2V0KCkgaW50ZXJmYWNlIGRpcmVjdGx5
Cj4gPiAgICAyLiBTcGxpdCB0aGUgdHdvIHBhdGNoIHNldHMsIHRoaXMgaXMgdGhlIGZpcnN0IHBh
cnQKPiA+ICAgIDMuIEFkZCBpbmRlcGVuZGVudCBhbGxvY2F0aW9uIGhlbHBlciBmb3IgYWxsb2Nh
dGluZyBzdGF0ZSwgZXh0cmEKPiA+Cj4gPiB2NzoKPiA+ICAgIDEuIGZpeCAjNiBzdWJqZWN0IHR5
cG8KPiA+ICAgIDIuIGZpeCAjNiByaW5nX3NpemVfaW5fYnl0ZXMgaXMgdW5pbml0aWFsaXplZAo+
ID4gICAgMy4gY2hlY2sgYnk6IG1ha2UgVz0xMgo+ID4KPiA+IHY2Ogo+ID4gICAgMS4gdmlydGlv
X3BjaTogdXNlIHN5bmNocm9uaXplX2lycShpcnEpIHRvIHN5bmMgdGhlIGlycSBjYWxsYmFja3MK
PiA+ICAgIDIuIEludHJvZHVjZSB2aXJ0cXVldWVfcmVzZXRfdnJpbmcoKSB0byBpbXBsZW1lbnQg
dGhlIHJlc2V0IG9mIHZyaW5nIGR1cmluZwo+ID4gICAgICAgdGhlIHJlc2V0IHByb2Nlc3MuIE1h
eSB1c2UgdGhlIG9sZCB2cmluZyBpZiBudW0gb2YgdGhlIHZxIG5vdCBjaGFuZ2UuCj4gPiAgICAz
LiBmaW5kX3ZxcygpIHN1cHBvcnQgc2l6ZXMgdG8gc3BlY2lhbCB0aGUgbWF4IHNpemUgb2YgZWFj
aCB2cQo+ID4KPiA+IHY1Ogo+ID4gICAgMS4gYWRkIHZpcnRpby1uZXQgc3VwcG9ydCBzZXRfcmlu
Z3BhcmFtCj4gPgo+ID4gdjQ6Cj4gPiAgICAxLiBqdXN0IHRoZSBjb2RlIG9mIHZpcnRpbywgd2l0
aG91dCB2aXJ0aW8tbmV0Cj4gPiAgICAyLiBQZXJmb3JtaW5nIHJlc2V0IG9uIGEgcXVldWUgaXMg
ZGl2aWRlZCBpbnRvIHRoZXNlIHN0ZXBzOgo+ID4gICAgICAxLiByZXNldF92cTogcmVzZXQgb25l
IHZxCj4gPiAgICAgIDIuIHJlY3ljbGUgdGhlIGJ1ZmZlciBmcm9tIHZxIGJ5IHZpcnRxdWV1ZV9k
ZXRhY2hfdW51c2VkX2J1ZigpCj4gPiAgICAgIDMuIHJlbGVhc2UgdGhlIHJpbmcgb2YgdGhlIHZx
IGJ5IHZyaW5nX3JlbGVhc2VfdmlydHF1ZXVlKCkKPiA+ICAgICAgNC4gZW5hYmxlX3Jlc2V0X3Zx
OiByZS1lbmFibGUgdGhlIHJlc2V0IHF1ZXVlCj4gPiAgICAzLiBTaW1wbGlmeSB0aGUgcGFyYW1l
dGVycyBvZiBlbmFibGVfcmVzZXRfdnEoKQo+ID4gICAgNC4gYWRkIGNvbnRhaW5lciBzdHJ1Y3R1
cmVzIGZvciB2aXJ0aW9fcGNpX2NvbW1vbl9jZmcKPiA+Cj4gPiB2MzoKPiA+ICAgIDEuIGtlZXAg
dnEsIGlycSB1bnJlbGVhc2VkCj4gPgo+ID4gWHVhbiBaaHVvICgxNik6Cj4gPiAgICB2aXJ0aW86
IGFkZCBoZWxwZXIgdmlydHF1ZXVlX2dldF92cmluZ19tYXhfc2l6ZSgpCj4gPiAgICB2aXJ0aW86
IHN0cnVjdCB2aXJ0aW9fY29uZmlnX29wcyBhZGQgY2FsbGJhY2tzIGZvciBxdWV1ZV9yZXNldAo+
ID4gICAgdmlydGlvX3Jpbmc6IHVwZGF0ZSB0aGUgZG9jdW1lbnQgb2YgdGhlIHZpcnRxdWV1ZV9k
ZXRhY2hfdW51c2VkX2J1Zgo+ID4gICAgICBmb3IgcXVldWUgcmVzZXQKPiA+ICAgIHZpcnRpb19y
aW5nOiByZW1vdmUgdGhlIGFyZyB2cSBvZiB2cmluZ19hbGxvY19kZXNjX2V4dHJhKCkKPiA+ICAg
IHZpcnRpb19yaW5nOiBleHRyYWN0IHRoZSBsb2dpYyBvZiBmcmVlaW5nIHZyaW5nCj4gPiAgICB2
aXJ0aW9fcmluZzogc3BsaXQ6IGV4dHJhY3QgdGhlIGxvZ2ljIG9mIGFsbG9jIHF1ZXVlCj4gPiAg
ICB2aXJ0aW9fcmluZzogc3BsaXQ6IGV4dHJhY3QgdGhlIGxvZ2ljIG9mIGFsbG9jIHN0YXRlIGFu
ZCBleHRyYQo+ID4gICAgdmlydGlvX3Jpbmc6IHNwbGl0OiBleHRyYWN0IHRoZSBsb2dpYyBvZiBh
dHRhY2ggdnJpbmcKPiA+ICAgIHZpcnRpb19yaW5nOiBzcGxpdDogZXh0cmFjdCB0aGUgbG9naWMg
b2YgdnEgaW5pdAo+ID4gICAgdmlydGlvX3Jpbmc6IHNwbGl0OiBpbXBsZW1lbnQgdmlydHF1ZXVl
X3Jlc2l6ZV9zcGxpdCgpCj4gPiAgICB2aXJ0aW9fcmluZzogcGFja2VkOiBleHRyYWN0IHRoZSBs
b2dpYyBvZiBhbGxvYyBxdWV1ZQo+ID4gICAgdmlydGlvX3Jpbmc6IHBhY2tlZDogZXh0cmFjdCB0
aGUgbG9naWMgb2YgYWxsb2Mgc3RhdGUgYW5kIGV4dHJhCj4gPiAgICB2aXJ0aW9fcmluZzogcGFj
a2VkOiBleHRyYWN0IHRoZSBsb2dpYyBvZiBhdHRhY2ggdnJpbmcKPiA+ICAgIHZpcnRpb19yaW5n
OiBwYWNrZWQ6IGV4dHJhY3QgdGhlIGxvZ2ljIG9mIHZxIGluaXQKPiA+ICAgIHZpcnRpb19yaW5n
OiBwYWNrZWQ6IGltcGxlbWVudCB2aXJ0cXVldWVfcmVzaXplX3BhY2tlZCgpCj4gPiAgICB2aXJ0
aW9fcmluZzogaW50cm9kdWNlIHZpcnRxdWV1ZV9yZXNpemUoKQo+ID4KPiA+ICAgZHJpdmVycy92
aXJ0aW8vdmlydGlvX21taW8uYyAgICAgICB8ICAgMiArCj4gPiAgIGRyaXZlcnMvdmlydGlvL3Zp
cnRpb19wY2lfbGVnYWN5LmMgfCAgIDIgKwo+ID4gICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNp
X21vZGVybi5jIHwgICAyICsKPiA+ICAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyAgICAg
ICB8IDYwNCArKysrKysrKysrKysrKysrKysrKysrLS0tLS0tLQo+ID4gICBpbmNsdWRlL2xpbnV4
L3ZpcnRpby5oICAgICAgICAgICAgIHwgICA1ICsKPiA+ICAgaW5jbHVkZS9saW51eC92aXJ0aW9f
Y29uZmlnLmggICAgICB8ICAxMiArCj4gPiAgIDYgZmlsZXMgY2hhbmdlZCwgNDk0IGluc2VydGlv
bnMoKyksIDEzMyBkZWxldGlvbnMoLSkKPiA+Cj4gPiAtLQo+ID4gMi4zMS4wCj4gPgo+Cl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
