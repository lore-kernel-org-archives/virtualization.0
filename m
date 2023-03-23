Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74A57C6FD1D
	for <virtualization@archiver.kernel.org>; Thu, 23 Mar 2023 05:58:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DB13C614C4;
	Thu, 23 Mar 2023 05:58:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DB13C614C4
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id RJf2Fep5VH22; Thu, 23 Mar 2023 05:58:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5386360BA8;
	Thu, 23 Mar 2023 05:58:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5386360BA8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0DDA5C0071;
	Thu, 23 Mar 2023 05:58:55 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 38D3AC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 05:58:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F28804090C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 05:58:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F28804090C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hSf1hXe1RuK2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 05:58:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0CDD1408ED
Received: from out30-98.freemail.mail.aliyun.com
 (out30-98.freemail.mail.aliyun.com [115.124.30.98])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0CDD1408ED
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 05:58:50 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R241e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018046059;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0VeTApVT_1679551122; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0VeTApVT_1679551122) by smtp.aliyun-inc.com;
 Thu, 23 Mar 2023 13:58:43 +0800
Message-ID: <1679551089.625654-2-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next 1/8] virtio_net: mergeable xdp: put old page
 immediately
Date: Thu, 23 Mar 2023 13:58:09 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230322030308.16046-1-xuanzhuo@linux.alibaba.com>
 <20230322030308.16046-2-xuanzhuo@linux.alibaba.com>
 <4bd07874-b1ad-336b-b15e-ba56a10182e9@huawei.com>
 <1679535365.5410192-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEvS7N1tXFD2-2n2upY15JF6=0uaAebewsP8=K+Cwbtgsg@mail.gmail.com>
In-Reply-To: <CACGkMEvS7N1tXFD2-2n2upY15JF6=0uaAebewsP8=K+Cwbtgsg@mail.gmail.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Eric Dumazet <edumazet@google.com>, Alexei Starovoitov <ast@kernel.org>,
 Yunsheng Lin <linyunsheng@huawei.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 virtualization@lists.linux-foundation.org,
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

T24gVGh1LCAyMyBNYXIgMjAyMyAxMzozODozMCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gVGh1LCBNYXIgMjMsIDIwMjMgYXQgOTo0M+KAr0FNIFh1
YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIFdl
ZCwgMjIgTWFyIDIwMjMgMTY6MjI6MTggKzA4MDAsIFl1bnNoZW5nIExpbiA8bGlueXVuc2hlbmdA
aHVhd2VpLmNvbT4gd3JvdGU6Cj4gPiA+IE9uIDIwMjMvMy8yMiAxMTowMywgWHVhbiBaaHVvIHdy
b3RlOgo+ID4gPiA+IEluIHRoZSB4ZHAgaW1wbGVtZW50YXRpb24gb2YgdmlydGlvLW5ldCBtZXJn
ZWFibGUsIGl0IGFsd2F5cyBjaGVja3MKPiA+ID4gPiB3aGV0aGVyIHR3byBwYWdlIGlzIHVzZWQg
YW5kIGEgcGFnZSBpcyBzZWxlY3RlZCB0byByZWxlYXNlLiBUaGlzIGlzCj4gPiA+ID4gY29tcGxp
Y2F0ZWQgZm9yIHRoZSBwcm9jZXNzaW5nIG9mIGFjdGlvbiwgYW5kIGJlIGNhcmVmdWwuCj4gPiA+
ID4KPiA+ID4gPiBJbiB0aGUgZW50aXJlIHByb2Nlc3MsIHdlIGhhdmUgc3VjaCBwcmluY2lwbGVz
Ogo+ID4gPiA+ICogSWYgeGRwX3BhZ2UgaXMgdXNlZCAoUEFTUywgVFgsIFJlZGlyZWN0KSwgdGhl
biB3ZSByZWxlYXNlIHRoZSBvbGQKPiA+ID4gPiAgIHBhZ2UuCj4gPiA+ID4gKiBJZiBpdCBpcyBh
IGRyb3AgY2FzZSwgd2Ugd2lsbCByZWxlYXNlIHR3by4gVGhlIG9sZCBwYWdlIG9idGFpbmVkIGZy
b20KPiA+ID4gPiAgIGJ1ZiBpcyByZWxlYXNlIGluc2lkZSBlcnJfeGRwLCBhbmQgeGRwX3BhZ2Ug
bmVlZHMgYmUgcmVsYXNlZCBieSB1cy4KPiA+ID4gPgo+ID4gPiA+IEJ1dCBpbiBmYWN0LCB3aGVu
IHdlIGFsbG9jYXRlIGEgbmV3IHBhZ2UsIHdlIGNhbiByZWxlYXNlIHRoZSBvbGQgcGFnZQo+ID4g
PiA+IGltbWVkaWF0ZWx5LiBUaGVuIGp1c3Qgb25lIGlzIHVzaW5nLCB3ZSBqdXN0IG5lZWQgdG8g
cmVsZWFzZSB0aGUgbmV3Cj4gPiA+ID4gcGFnZSBmb3IgZHJvcCBjYXNlLiBPbiB0aGUgZHJvcCBw
YXRoLCBlcnJfeGRwIHdpbGwgcmVsZWFzZSB0aGUgdmFyaWFibGUKPiA+ID4gPiAicGFnZSIsIHNv
IHdlIG9ubHkgbmVlZCB0byBsZXQgInBhZ2UiIHBvaW50IHRvIHRoZSBuZXcgeGRwX3BhZ2UgaW4K
PiA+ID4gPiBhZHZhbmNlLgo+ID4gPiA+Cj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVv
IDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+ID4gPiAtLS0KPiA+ID4gPiAgZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jIHwgMTUgKysrKysrLS0tLS0tLS0tCj4gPiA+ID4gIDEgZmlsZSBj
aGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDkgZGVsZXRpb25zKC0pCj4gPiA+ID4KPiA+ID4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jCj4gPiA+ID4gaW5kZXggZTI1NjBiNmY3OTgwLi40ZDJiZjFjZTA3MzAgMTAwNjQ0Cj4g
PiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gKysrIGIvZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gQEAgLTEyNDUsNiArMTI0NSw5IEBAIHN0YXRpYyBz
dHJ1Y3Qgc2tfYnVmZiAqcmVjZWl2ZV9tZXJnZWFibGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwK
PiA+ID4gPiAgICAgICAgICAgICAgICAgICAgIGlmICgheGRwX3BhZ2UpCj4gPiA+ID4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGdvdG8gZXJyX3hkcDsKPiA+ID4gPiAgICAgICAgICAgICAg
ICAgICAgIG9mZnNldCA9IFZJUlRJT19YRFBfSEVBRFJPT007Cj4gPiA+ID4gKwo+ID4gPiA+ICsg
ICAgICAgICAgICAgICAgICAgcHV0X3BhZ2UocGFnZSk7Cj4gPiA+Cj4gPiA+IHRoZSBlcnJvciBo
YW5kbGluZyBvZiB4ZHBfbGluZWFyaXplX3BhZ2UoKSBkb2VzIG5vdCBzZWVtcyBzZWxmIGNvbnRh
aW5lZC4KPiA+ID4gRG9lcyBpdCBub3Qgc2VlbSBiZXR0ZXLvvJoKPiA+ID4gMS4gaWYgeGRwX2xp
bmVhcml6ZV9wYWdlKCkgc3VjY2VzZWQsIGNhbGwgcHV0X3BhZ2UoKSBmb3IgZmlyc3QgYnVmZmVy
IGp1c3QKPiA+ID4gICAgYXMgcHV0X3BhZ2UoKSBpcyBjYWxsIGZvciBvdGhlciBidWZmZXIKPiA+
ID4gMi4gb3IgY2FsbCB2aXJ0cXVldWVfZ2V0X2J1ZigpIGFuZCBwdXRfcGFnZSgpIGZvciBhbGwg
dGhlIGJ1ZmZlciBvZiB0aGUgcGFja2V0Cj4gPiA+ICAgIHNvIHRoZSBlcnJvciBoYW5kbGluZyBp
cyBub3QgbmVlZGVkIG91dHNpZGUgdGhlIHZpcnRxdWV1ZV9nZXRfYnVmKCkuCj4gPiA+Cj4gPiA+
IEluIHRoYXQgY2FzZSwgaXQgc2VlbXMgd2UgY2FuIGp1c3QgZG8gYmVsb3cgd2l0aG91dCB4ZHBf
cGFnZToKPiA+ID4gcGFnZSA9IHhkcF9saW5lYXJpemVfcGFnZShycSwgbnVtX2J1ZiwgcGFnZSwg
Li4uKTsKPiA+Cj4gPgo+ID4gVGhpcyBkb2VzIGxvb2sgYmV0dGVyLgo+ID4KPiA+IEluIGZhY3Qs
IHdlIGFscmVhZHkgaGF2ZSB2cSByZXNldCwgd2UgY2FuIGxvYWQgWERQIGJhc2VkIG9uIHZxIHJl
c2V0Lgo+ID4gSW4gdGhpcyB3YXksIHdlIGNhbiBydW4gd2l0aG91dCB4ZHBfbGluZWFyaXplX3Bh
Z2UuCj4KPiBUaGUgZ29hbCBpcyB0byB0cnkgb3VyIGJlc3Qgbm90IHRvIGRyb3AgcGFja2V0cywg
c28gSSB0aGluayBpdCdzCj4gYmV0dGVyIHRvIGtlZXAgaXQuCgoKWWVzLiB2cSByZXNldCBtYXkg
ZHJvcCBzb21lIHBhY2tldHMuCgpUaGFua3MuCgo+Cj4gVGhhbmtzCj4KPiA+Cj4gPgo+ID4gPgo+
ID4gPgo+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgcGFnZSA9IHhkcF9wYWdlOwo+ID4gPiA+
ICAgICAgICAgICAgIH0gZWxzZSBpZiAodW5saWtlbHkoaGVhZHJvb20gPCB2aXJ0bmV0X2dldF9o
ZWFkcm9vbSh2aSkpKSB7Cj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICB4ZHBfcm9vbSA9IFNL
Ql9EQVRBX0FMSUdOKFZJUlRJT19YRFBfSEVBRFJPT00gKwo+ID4gPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzaXplb2Yoc3RydWN0IHNrYl9zaGFyZWRf
aW5mbykpOwo+ID4gPiA+IEBAIC0xMjU5LDYgKzEyNjIsOSBAQCBzdGF0aWMgc3RydWN0IHNrX2J1
ZmYgKnJlY2VpdmVfbWVyZ2VhYmxlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcGFnZV9hZGRyZXNzKHBhZ2UpICsgb2Zmc2V0LCBsZW4p
Owo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgZnJhbWVfc3ogPSBQQUdFX1NJWkU7Cj4gPiA+
ID4gICAgICAgICAgICAgICAgICAgICBvZmZzZXQgPSBWSVJUSU9fWERQX0hFQURST09NOwo+ID4g
PiA+ICsKPiA+ID4gPiArICAgICAgICAgICAgICAgICAgIHB1dF9wYWdlKHBhZ2UpOwo+ID4gPiA+
ICsgICAgICAgICAgICAgICAgICAgcGFnZSA9IHhkcF9wYWdlOwo+ID4gPgo+ID4gPiBJdCBzZWVt
cyB3ZSBjYW4gbGltaXQgdGhlIHNjb3BlIG9mIHhkcF9wYWdlIGluIHRoaXMgImVsc2UgaWYiIGJs
b2NrLgo+ID4gPgo+ID4gPiA+ICAgICAgICAgICAgIH0gZWxzZSB7Cj4gPiA+ID4gICAgICAgICAg
ICAgICAgICAgICB4ZHBfcGFnZSA9IHBhZ2U7Cj4gPiA+ID4gICAgICAgICAgICAgfQo+ID4gPgo+
ID4gPiBJdCBzZWVtcyB0aGUgYWJvdmUgZWxzZSBibG9jayBpcyBub3QgbmVlZGVkIGFueW1vcmUu
Cj4gPgo+ID4gWWVzLCB0aGUgZm9sbG93LXVwIHBhdGNoIGhhcyB0aGlzIG9wdGltaXphdGlvbi4K
PiA+Cj4gPgo+ID4gPgo+ID4gPiA+IEBAIC0xMjc4LDggKzEyODQsNiBAQCBzdGF0aWMgc3RydWN0
IHNrX2J1ZmYgKnJlY2VpdmVfbWVyZ2VhYmxlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4gPiA+
ID4gICAgICAgICAgICAgICAgICAgICBpZiAodW5saWtlbHkoIWhlYWRfc2tiKSkKPiA+ID4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnJfeGRwX2ZyYWdzOwo+ID4gPiA+Cj4g
PiA+ID4gLSAgICAgICAgICAgICAgICAgICBpZiAodW5saWtlbHkoeGRwX3BhZ2UgIT0gcGFnZSkp
Cj4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgIHB1dF9wYWdlKHBhZ2UpOwo+ID4g
PiA+ICAgICAgICAgICAgICAgICAgICAgcmN1X3JlYWRfdW5sb2NrKCk7Cj4gPiA+ID4gICAgICAg
ICAgICAgICAgICAgICByZXR1cm4gaGVhZF9za2I7Cj4gPiA+ID4gICAgICAgICAgICAgY2FzZSBY
RFBfVFg6Cj4gPiA+ID4gQEAgLTEyOTcsOCArMTMwMSw2IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVm
ZiAqcmVjZWl2ZV9tZXJnZWFibGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldiwKPiA+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZ290byBlcnJfeGRwX2ZyYWdzOwo+ID4gPiA+ICAgICAg
ICAgICAgICAgICAgICAgfQo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgKnhkcF94bWl0IHw9
IFZJUlRJT19YRFBfVFg7Cj4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICBpZiAodW5saWtlbHko
eGRwX3BhZ2UgIT0gcGFnZSkpCj4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgIHB1
dF9wYWdlKHBhZ2UpOwo+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgcmN1X3JlYWRfdW5sb2Nr
KCk7Cj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICBnb3RvIHhkcF94bWl0Owo+ID4gPiA+ICAg
ICAgICAgICAgIGNhc2UgWERQX1JFRElSRUNUOgo+ID4gPiA+IEBAIC0xMzA3LDggKzEzMDksNiBA
QCBzdGF0aWMgc3RydWN0IHNrX2J1ZmYgKnJlY2VpdmVfbWVyZ2VhYmxlKHN0cnVjdCBuZXRfZGV2
aWNlICpkZXYsCj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICBpZiAoZXJyKQo+ID4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBnb3RvIGVycl94ZHBfZnJhZ3M7Cj4gPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAqeGRwX3htaXQgfD0gVklSVElPX1hEUF9SRURJUjsKPiA+ID4gPiAt
ICAgICAgICAgICAgICAgICAgIGlmICh1bmxpa2VseSh4ZHBfcGFnZSAhPSBwYWdlKSkKPiA+ID4g
PiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgcHV0X3BhZ2UocGFnZSk7Cj4gPiA+ID4gICAg
ICAgICAgICAgICAgICAgICByY3VfcmVhZF91bmxvY2soKTsKPiA+ID4gPiAgICAgICAgICAgICAg
ICAgICAgIGdvdG8geGRwX3htaXQ7Cj4gPiA+ID4gICAgICAgICAgICAgZGVmYXVsdDoKPiA+ID4g
PiBAQCAtMTMyMSw5ICsxMzIxLDYgQEAgc3RhdGljIHN0cnVjdCBza19idWZmICpyZWNlaXZlX21l
cmdlYWJsZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ID4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgZ290byBlcnJfeGRwX2ZyYWdzOwo+ID4gPiA+ICAgICAgICAgICAgIH0KPiA+ID4gPiAgZXJy
X3hkcF9mcmFnczoKPiA+ID4gPiAtICAgICAgICAgICBpZiAodW5saWtlbHkoeGRwX3BhZ2UgIT0g
cGFnZSkpCj4gPiA+ID4gLSAgICAgICAgICAgICAgICAgICBfX2ZyZWVfcGFnZXMoeGRwX3BhZ2Us
IDApOwo+ID4gPgo+ID4gPiBJdCBzZWVtcyBfX2ZyZWVfcGFnZXMoKSBhbmQgcHV0X3BhZ2UoKSBp
cyB1c2VkIGludGVyY2hhbmdlYWJseSBoZXJlLgo+ID4gPiBQZXJoYXBzIHVzaW5nIF9fZnJlZV9w
YWdlcygpIGhhdmUgcGVyZm9ybWFuY2UgcmVhc29uPyBBcyB0aGUgY29tbWVudCBiZWxvdzoKPiA+
ID4KPiA+ID4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvdjYuMy1yYzMvc291cmNl
L25ldC9jb3JlL3BhZ2VfcG9vbC5jI0w1MDAKPiA+Cj4gPgo+ID4gWWVzLCBidXQgbm93IHdlIGRv
bid0IHNlZW0gdG8gYmUgdmVyeSBnb29kIHRvIGRpc3Rpbmd1aXNoIGl0LiBCdXQgSSB0aGluawo+
ID4gaXQgZG9lc24ndCBtYXR0ZXIuIFRoaXMgbG9naWMgaXMgcmFyZSB1bmRlciBhY3R1YWwgc2l0
dWF0aW9uLgo+ID4KPiA+IFRoYW5rcy4KPiA+Cj4gPgo+ID4gPgo+ID4gPiA+IC0KPiA+ID4gPiAg
ICAgICAgICAgICBpZiAoeGRwX2J1ZmZfaGFzX2ZyYWdzKCZ4ZHApKSB7Cj4gPiA+ID4gICAgICAg
ICAgICAgICAgICAgICBzaGluZm8gPSB4ZHBfZ2V0X3NoYXJlZF9pbmZvX2Zyb21fYnVmZigmeGRw
KTsKPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBzaGluZm8tPm5y
X2ZyYWdzOyBpKyspIHsKPiA+ID4gPgo+ID4KPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
