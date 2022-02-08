Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43EA3C433F5
	for <virtualization@archiver.kernel.org>; Tue,  8 Feb 2022 02:17:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CA7C2817A7;
	Tue,  8 Feb 2022 02:17:53 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id auN3zojGAbrQ; Tue,  8 Feb 2022 02:17:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 755D3813BF;
	Tue,  8 Feb 2022 02:17:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F773C0011;
	Tue,  8 Feb 2022 02:17:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EE9A2C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 02:17:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DCCE640492
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 02:17:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SLRn7pkxddPo
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 02:17:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-131.freemail.mail.aliyun.com
 (out30-131.freemail.mail.aliyun.com [115.124.30.131])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 2B0C44035C
 for <virtualization@lists.linux-foundation.org>;
 Tue,  8 Feb 2022 02:17:48 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R201e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04423; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0V3u65I2_1644286664; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0V3u65I2_1644286664) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 08 Feb 2022 10:17:44 +0800
Message-Id: <1644286649.5989025-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v3 01/17] virtio_pci: struct virtio_pci_common_cfg add
 queue_notify_data
Date: Tue, 08 Feb 2022 10:17:29 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CACGkMEuJ_v5g2ypLZ3eNhAcUM9Q3PpWuiaeWVfEC6KACGzWAZw@mail.gmail.com>
References: <20220126073533.44994-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuJ_v5g2ypLZ3eNhAcUM9Q3PpWuiaeWVfEC6KACGzWAZw@mail.gmail.com>
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

T24gTW9uLCA3IEZlYiAyMDIyIDE2OjA2OjE1ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPiBPbiBNb24sIEZlYiA3LCAyMDIyIGF0IDI6MDcgUE0gWHVhbiBa
aHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gTW9uLCA3
IEZlYiAyMDIyIDExOjQxOjA2ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PiB3cm90ZToKPiA+ID4KPiA+ID4g5ZyoIDIwMjIvMS8yNiDkuIvljYgzOjM1LCBYdWFuIFpodW8g
5YaZ6YGTOgo+ID4gPiA+IEFkZCBxdWV1ZV9ub3RpZnlfZGF0YSBpbiBzdHJ1Y3QgdmlydGlvX3Bj
aV9jb21tb25fY2ZnLCB3aGljaCBjb21lcyBmcm9tCj4gPiA+ID4gaGVyZSBodHRwczovL2dpdGh1
Yi5jb20vb2FzaXMtdGNzL3ZpcnRpby1zcGVjL2lzc3Vlcy84OQo+ID4gPiA+Cj4gPiA+ID4gU2lu
Y2UgSSB3YW50IHRvIGFkZCBxdWV1ZV9yZXNldCBhZnRlciBpdCwgSSBzdWJtaXR0ZWQgdGhpcyBw
YXRjaCBmaXJzdC4KPiA+ID4gPgo+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVh
bnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gPiA+ID4gLS0tCj4gPiA+ID4gICBpbmNsdWRlL3Vh
cGkvbGludXgvdmlydGlvX3BjaS5oIHwgMSArCj4gPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKykKPiA+ID4gPgo+ID4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL3VhcGkvbGlu
dXgvdmlydGlvX3BjaS5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19wY2kuaAo+ID4gPiA+
IGluZGV4IDNhODZmMzZkN2UzZC4uNDkyYzg5ZjU2YzZhIDEwMDY0NAo+ID4gPiA+IC0tLSBhL2lu
Y2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNpLmgKPiA+ID4gPiArKysgYi9pbmNsdWRlL3VhcGkv
bGludXgvdmlydGlvX3BjaS5oCj4gPiA+ID4gQEAgLTE2NCw2ICsxNjQsNyBAQCBzdHJ1Y3Qgdmly
dGlvX3BjaV9jb21tb25fY2ZnIHsKPiA+ID4gPiAgICAgX19sZTMyIHF1ZXVlX2F2YWlsX2hpOyAg
ICAgICAgICAvKiByZWFkLXdyaXRlICovCj4gPiA+ID4gICAgIF9fbGUzMiBxdWV1ZV91c2VkX2xv
OyAgICAgICAgICAgLyogcmVhZC13cml0ZSAqLwo+ID4gPiA+ICAgICBfX2xlMzIgcXVldWVfdXNl
ZF9oaTsgICAgICAgICAgIC8qIHJlYWQtd3JpdGUgKi8KPiA+ID4gPiArICAgX19sZTE2IHF1ZXVl
X25vdGlmeV9kYXRhOyAgICAgICAvKiByZWFkLXdyaXRlICovCj4gPiA+ID4gICB9Owo+ID4gPgo+
ID4gPgo+ID4gPiBTbyBJIGhhZCB0aGUgc2FtZSBjb25jZXJuIGFzIHByZXZpb3VzIHZlcnNpb24u
Cj4gPiA+Cj4gPiA+IFRoaXMgYnJlYWtzIHVBQkkgd2hlcmUgcHJvZ3JhbSBtYXkgdHJ5IHRvIHVz
ZSBzaXplb2Yoc3RydWN0Cj4gPiA+IHZpcnRpb19wY2lfY29tbW9uX2NmZykuCj4gPiA+Cj4gPiA+
IFdlIHByb2JhYmx5IG5lZWQgYSBjb250YWluZXIgc3RydWN0dXJlIGhlcmUuCj4gPgo+ID4gSSBz
ZWUsIEkgcGxhbiB0byBhZGQgYSBzdHJ1Y3QgbGlrZSB0aGlzLCBkbyB5b3UgdGhpbmsgaXQncyBh
cHByb3ByaWF0ZT8KPiA+Cj4gPiBzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25fY2ZnX3YxIHsKPiA+
ICAgICAgICAgc3RydWN0IHZpcnRpb19wY2lfY29tbW9uX2NmZyBjZmc7Cj4gPiAgICAgICAgIF9f
bGUxNiBxdWV1ZV9ub3RpZnlfZGF0YTsgICAgICAgLyogcmVhZC13cml0ZSAqLwo+ID4gfQo+Cj4g
U29tZXRoaW5nIGxpa2UgdGhpcyBidXQgd2UgcHJvYmFibHkgbmVlZCBhIGJldHRlciBuYW1lLgoK
CmhvdyBhYm91dCB0aGlzPwoKCS8qIEV4dCBGaWVsZHMgaW4gVklSVElPX1BDSV9DQVBfQ09NTU9O
X0NGRzogKi8KCXN0cnVjdCB2aXJ0aW9fcGNpX2NvbW1vbl9jZmdfZXh0IHsKCQlzdHJ1Y3Qgdmly
dGlvX3BjaV9jb21tb25fY2ZnIGNmZzsKCgkJX19sZTE2IHF1ZXVlX25vdGlmeV9kYXRhOwkvKiBy
ZWFkLXdyaXRlICovCgoJCV9fbGUxNiByZXNlcnZlZDA7CgkJX19sZTE2IHJlc2VydmVkMTsKCQlf
X2xlMTYgcmVzZXJ2ZWQyOwoJCV9fbGUxNiByZXNlcnZlZDM7CgkJX19sZTE2IHJlc2VydmVkNDsK
CQlfX2xlMTYgcmVzZXJ2ZWQ1OwoJCV9fbGUxNiByZXNlcnZlZDY7CgkJX19sZTE2IHJlc2VydmVk
NzsKCQlfX2xlMTYgcmVzZXJ2ZWQ4OwoJCV9fbGUxNiByZXNlcnZlZDk7CgkJX19sZTE2IHJlc2Vy
dmVkMTA7CgkJX19sZTE2IHJlc2VydmVkMTE7CgkJX19sZTE2IHJlc2VydmVkMTI7CgkJX19sZTE2
IHJlc2VydmVkMTM7CgkJX19sZTE2IHJlc2VydmVkMTQ7Cgl9OwoKVGhhbmtzCgo+Cj4gVGhhbmtz
Cj4KPiA+Cj4gPiBUaGFua3MuCj4gPgo+ID4gPgo+ID4gPiBUSGFua3MKPiA+ID4KPiA+ID4KPiA+
ID4gPgo+ID4gPiA+ICAgLyogRmllbGRzIGluIFZJUlRJT19QQ0lfQ0FQX1BDSV9DRkc6ICovCj4g
PiA+Cj4gPgo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
