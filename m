Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66920C433F5
	for <virtualization@archiver.kernel.org>; Tue,  8 Feb 2022 03:20:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E9E4E405C8;
	Tue,  8 Feb 2022 03:20:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G8zj4xuYIC0m; Tue,  8 Feb 2022 03:20:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A60BC40591;
	Tue,  8 Feb 2022 03:20:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 67AA7C001A;
	Tue,  8 Feb 2022 03:20:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2ED60C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:20:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2AC84405C8
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:20:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HpFvALmMQsCv
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:20:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 04EE840591
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 03:20:22 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R451e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V3uaWvN_1644290418; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V3uaWvN_1644290418) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 08 Feb 2022 11:20:18 +0800
Message-Id: <1644290312.0241497-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v3 01/17] virtio_pci: struct virtio_pci_common_cfg add
 queue_notify_data
Date: Tue, 08 Feb 2022 11:18:32 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20220126073533.44994-1-xuanzhuo@linux.alibaba.com>
 <20220126073533.44994-2-xuanzhuo@linux.alibaba.com>
 <28013a95-4ce4-7859-9ca1-d836265e8792@redhat.com>
 <1644213876.065673-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEuJ_v5g2ypLZ3eNhAcUM9Q3PpWuiaeWVfEC6KACGzWAZw@mail.gmail.com>
 <1644286649.5989025-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvVmKg0r4WudojL6dGt3vG4f=_4Pnsn-kBwQcge63jNqQ@mail.gmail.com>
In-Reply-To: <CACGkMEvVmKg0r4WudojL6dGt3vG4f=_4Pnsn-kBwQcge63jNqQ@mail.gmail.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 "David S. Miller" <davem@davemloft.net>
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

T24gVHVlLCA4IEZlYiAyMDIyIDExOjAzOjE3ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPiBPbiBUdWUsIEZlYiA4LCAyMDIyIGF0IDEwOjE3IEFNIFh1YW4g
Wmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIE1vbiwg
NyBGZWIgMjAyMiAxNjowNjoxNSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4gPiA+IE9uIE1vbiwgRmViIDcsIDIwMjIgYXQgMjowNyBQTSBYdWFuIFpodW8g
PHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+ID4gPgo+ID4gPiA+IE9uIE1v
biwgNyBGZWIgMjAyMiAxMTo0MTowNiArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4g5ZyoIDIwMjIvMS8yNiDkuIvljYgzOjM1
LCBYdWFuIFpodW8g5YaZ6YGTOgo+ID4gPiA+ID4gPiBBZGQgcXVldWVfbm90aWZ5X2RhdGEgaW4g
c3RydWN0IHZpcnRpb19wY2lfY29tbW9uX2NmZywgd2hpY2ggY29tZXMgZnJvbQo+ID4gPiA+ID4g
PiBoZXJlIGh0dHBzOi8vZ2l0aHViLmNvbS9vYXNpcy10Y3MvdmlydGlvLXNwZWMvaXNzdWVzLzg5
Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFNpbmNlIEkgd2FudCB0byBhZGQgcXVldWVfcmVzZXQg
YWZ0ZXIgaXQsIEkgc3VibWl0dGVkIHRoaXMgcGF0Y2ggZmlyc3QuCj4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5j
b20+Cj4gPiA+ID4gPiA+IC0tLQo+ID4gPiA+ID4gPiAgIGluY2x1ZGUvdWFwaS9saW51eC92aXJ0
aW9fcGNpLmggfCAxICsKPiA+ID4gPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KykKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9saW51
eC92aXJ0aW9fcGNpLmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3BjaS5oCj4gPiA+ID4g
PiA+IGluZGV4IDNhODZmMzZkN2UzZC4uNDkyYzg5ZjU2YzZhIDEwMDY0NAo+ID4gPiA+ID4gPiAt
LS0gYS9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX3BjaS5oCj4gPiA+ID4gPiA+ICsrKyBiL2lu
Y2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNpLmgKPiA+ID4gPiA+ID4gQEAgLTE2NCw2ICsxNjQs
NyBAQCBzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25fY2ZnIHsKPiA+ID4gPiA+ID4gICAgIF9fbGUz
MiBxdWV1ZV9hdmFpbF9oaTsgICAgICAgICAgLyogcmVhZC13cml0ZSAqLwo+ID4gPiA+ID4gPiAg
ICAgX19sZTMyIHF1ZXVlX3VzZWRfbG87ICAgICAgICAgICAvKiByZWFkLXdyaXRlICovCj4gPiA+
ID4gPiA+ICAgICBfX2xlMzIgcXVldWVfdXNlZF9oaTsgICAgICAgICAgIC8qIHJlYWQtd3JpdGUg
Ki8KPiA+ID4gPiA+ID4gKyAgIF9fbGUxNiBxdWV1ZV9ub3RpZnlfZGF0YTsgICAgICAgLyogcmVh
ZC13cml0ZSAqLwo+ID4gPiA+ID4gPiAgIH07Cj4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+
IFNvIEkgaGFkIHRoZSBzYW1lIGNvbmNlcm4gYXMgcHJldmlvdXMgdmVyc2lvbi4KPiA+ID4gPiA+
Cj4gPiA+ID4gPiBUaGlzIGJyZWFrcyB1QUJJIHdoZXJlIHByb2dyYW0gbWF5IHRyeSB0byB1c2Ug
c2l6ZW9mKHN0cnVjdAo+ID4gPiA+ID4gdmlydGlvX3BjaV9jb21tb25fY2ZnKS4KPiA+ID4gPiA+
Cj4gPiA+ID4gPiBXZSBwcm9iYWJseSBuZWVkIGEgY29udGFpbmVyIHN0cnVjdHVyZSBoZXJlLgo+
ID4gPiA+Cj4gPiA+ID4gSSBzZWUsIEkgcGxhbiB0byBhZGQgYSBzdHJ1Y3QgbGlrZSB0aGlzLCBk
byB5b3UgdGhpbmsgaXQncyBhcHByb3ByaWF0ZT8KPiA+ID4gPgo+ID4gPiA+IHN0cnVjdCB2aXJ0
aW9fcGNpX2NvbW1vbl9jZmdfdjEgewo+ID4gPiA+ICAgICAgICAgc3RydWN0IHZpcnRpb19wY2lf
Y29tbW9uX2NmZyBjZmc7Cj4gPiA+ID4gICAgICAgICBfX2xlMTYgcXVldWVfbm90aWZ5X2RhdGE7
ICAgICAgIC8qIHJlYWQtd3JpdGUgKi8KPiA+ID4gPiB9Cj4gPiA+Cj4gPiA+IFNvbWV0aGluZyBs
aWtlIHRoaXMgYnV0IHdlIHByb2JhYmx5IG5lZWQgYSBiZXR0ZXIgbmFtZS4KPiA+Cj4gPgo+ID4g
aG93IGFib3V0IHRoaXM/Cj4gPgo+ID4gICAgICAgICAvKiBFeHQgRmllbGRzIGluIFZJUlRJT19Q
Q0lfQ0FQX0NPTU1PTl9DRkc6ICovCj4gPiAgICAgICAgIHN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1v
bl9jZmdfZXh0IHsKPiA+ICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25f
Y2ZnIGNmZzsKPiA+Cj4gPiAgICAgICAgICAgICAgICAgX19sZTE2IHF1ZXVlX25vdGlmeV9kYXRh
OyAgICAgICAvKiByZWFkLXdyaXRlICovCj4gPgo+ID4gICAgICAgICAgICAgICAgIF9fbGUxNiBy
ZXNlcnZlZDA7Cj4gPiAgICAgICAgICAgICAgICAgX19sZTE2IHJlc2VydmVkMTsKPiA+ICAgICAg
ICAgICAgICAgICBfX2xlMTYgcmVzZXJ2ZWQyOwo+ID4gICAgICAgICAgICAgICAgIF9fbGUxNiBy
ZXNlcnZlZDM7Cj4gPiAgICAgICAgICAgICAgICAgX19sZTE2IHJlc2VydmVkNDsKPiA+ICAgICAg
ICAgICAgICAgICBfX2xlMTYgcmVzZXJ2ZWQ1Owo+ID4gICAgICAgICAgICAgICAgIF9fbGUxNiBy
ZXNlcnZlZDY7Cj4gPiAgICAgICAgICAgICAgICAgX19sZTE2IHJlc2VydmVkNzsKPiA+ICAgICAg
ICAgICAgICAgICBfX2xlMTYgcmVzZXJ2ZWQ4Owo+ID4gICAgICAgICAgICAgICAgIF9fbGUxNiBy
ZXNlcnZlZDk7Cj4gPiAgICAgICAgICAgICAgICAgX19sZTE2IHJlc2VydmVkMTA7Cj4gPiAgICAg
ICAgICAgICAgICAgX19sZTE2IHJlc2VydmVkMTE7Cj4gPiAgICAgICAgICAgICAgICAgX19sZTE2
IHJlc2VydmVkMTI7Cj4gPiAgICAgICAgICAgICAgICAgX19sZTE2IHJlc2VydmVkMTM7Cj4gPiAg
ICAgICAgICAgICAgICAgX19sZTE2IHJlc2VydmVkMTQ7Cj4gPiAgICAgICAgIH07Cj4KPiBJIHN0
aWxsIHRoaW5rIHRoZSBjb250YWluZXIgd2l0aG91dCBwYWRkaW5nIGlzIGJldHRlci4gT3RoZXJ3
aXNlCj4gdXNlcnNwYWNlIG5lZWRzIHRvIHVzZSBvZmZzZXRfb2YoKSB0cmljayBpbnN0ZWFkIG9m
IHNpemVvZigpLgoKSW4gdGhpcyBjYXNlLCBhcyB2aXJ0aW9fcGNpX2NvbW1vbl9jZmdfZXh0IGFk
ZHMgbmV3IG1lbWJlcnMgaW4gdGhlIGZ1dHVyZSwgd2UKd2lsbCBhZGQgbW9yZSBjb250YWluZXIg
c3RydWN0dXJlcy4KCkluIHRoYXQgY2FzZSwgSSB0aGluayB2aXJ0aW9fcGNpX2NvbW1vbl9jZmdf
djEgaXMgYSBnb29kIG5hbWUgaW5zdGVhZC4KClRoYW5rcy4KCgo+Cj4gVGhhbmtzCj4KPiA+Cj4g
PiBUaGFua3MKPiA+Cj4gPiA+Cj4gPiA+IFRoYW5rcwo+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gVGhh
bmtzLgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gVEhhbmtzCj4gPiA+ID4gPgo+ID4gPiA+
ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gICAvKiBGaWVsZHMgaW4gVklSVElPX1BDSV9DQVBf
UENJX0NGRzogKi8KPiA+ID4gPiA+Cj4gPiA+ID4KPiA+ID4KPiA+Cj4KX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
