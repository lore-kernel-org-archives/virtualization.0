Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4970AC001B0
	for <virtualization@archiver.kernel.org>; Wed, 16 Aug 2023 03:33:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AAFCA41516;
	Wed, 16 Aug 2023 03:33:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org AAFCA41516
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MFEmQ-xMmgDG; Wed, 16 Aug 2023 03:33:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0958A4150B;
	Wed, 16 Aug 2023 03:33:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0958A4150B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D42F0C0071;
	Wed, 16 Aug 2023 03:33:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2E08CC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 03:33:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F2DD64062B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 03:33:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org F2DD64062B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id chKkxx7Or9fp
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 03:33:32 +0000 (UTC)
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C68F2405D8
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Aug 2023 03:33:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C68F2405D8
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045192;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=14; SR=0;
 TI=SMTPD_---0Vpu9MVY_1692156804; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vpu9MVY_1692156804) by smtp.aliyun-inc.com;
 Wed, 16 Aug 2023 11:33:25 +0800
Message-ID: <1692156147.7470396-3-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH vhost v13 05/12] virtio_ring: introduce virtqueue_dma_dev()
Date: Wed, 16 Aug 2023 11:22:27 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
References: <20230810123057.43407-1-xuanzhuo@linux.alibaba.com>
 <20230810123057.43407-6-xuanzhuo@linux.alibaba.com>
 <CACGkMEsaYbsWyOKxA-xY=3dSmvzq9pMdYbypG9q+Ry2sMwAMPg@mail.gmail.com>
 <1692081029.4299796-8-xuanzhuo@linux.alibaba.com>
 <CACGkMEt5RyOy_6rTXon_7py=ZmdJD=e4dMOGpNOo3NOyahGvjg@mail.gmail.com>
 <1692091669.428807-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEsnW-+fqcxu6E-cbAtMduE_n82fu+RA162fX5gr=Ckf5A@mail.gmail.com>
 <1692151724.9150448-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEt7LSTY-TRcSD75vYcv0AkH2a5otVXga7VGRLu7JQT_dA@mail.gmail.com>
 <1692152487.9422052-2-xuanzhuo@linux.alibaba.com>
 <CACGkMEvnVy+p8+Nro6v7Yr-m_N07200skcqwz-pCr5==sn68BQ@mail.gmail.com>
In-Reply-To: <CACGkMEvnVy+p8+Nro6v7Yr-m_N07200skcqwz-pCr5==sn68BQ@mail.gmail.com>
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, "David S. Miller" <davem@davemloft.net>
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

T24gV2VkLCAxNiBBdWcgMjAyMyAxMDozMzozNCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gT24gV2VkLCBBdWcgMTYsIDIwMjMgYXQgMTA6MjTigK9BTSBY
dWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBX
ZWQsIDE2IEF1ZyAyMDIzIDEwOjE5OjM0ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPiA+ID4gT24gV2VkLCBBdWcgMTYsIDIwMjMgYXQgMTA6MTbigK9BTSBY
dWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+ID4gPgo+ID4g
PiA+IE9uIFdlZCwgMTYgQXVnIDIwMjMgMDk6MTM6NDggKzA4MDAsIEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gT24gVHVlLCBBdWcgMTUsIDIwMjMgYXQg
NTo0MOKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+
ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBPbiBUdWUsIDE1IEF1ZyAyMDIzIDE1OjUwOjIzICswODAw
LCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPiBP
biBUdWUsIEF1ZyAxNSwgMjAyMyBhdCAyOjMy4oCvUE0gWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51
eC5hbGliYWJhLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiA+IEhpLCBKYXNvbgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IENv
dWxkIHlvdSBza2lwIHRoaXMgcGF0Y2g/Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBJJ20g
ZmluZSB3aXRoIGVpdGhlciBtZXJnaW5nIG9yIGRyb3BwaW5nIHRoaXMuCj4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBMZXQgd2UgcmV2aWV3IG90aGVyIHBhdGNo
ZXMgZmlyc3RseT8KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEkgd2lsbCBiZSBvbiB2YWNh
dGlvbiBzb29uLCBhbmQgd29uJ3QgaGF2ZSB0aW1lIHRvIGRvIHRoaXMgdW50aWwgbmV4dCB3ZWVr
Lgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBIYXZlIGEgaGFwcGx5IHZhY2F0aW9uLgo+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gQnV0IEkgc3BvdCB0d28gcG9zc2libGUg
Imlzc3VlcyI6Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiAxKSB0aGUgRE1BIG1ldGFkYXRh
IHdlcmUgc3RvcmVkIGluIHRoZSBoZWFkcm9vbSBvZiB0aGUgcGFnZSwgdGhpcwo+ID4gPiA+ID4g
PiA+IGJyZWFrcyBmcmFncyBjb2FsZXNjaW5nLCB3ZSBuZWVkIHRvIGJlbmNobWFyayBpdCdzIGlt
cGFjdAo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBOb3QgZXZlcnkgcGFnZSwganVzdCB0aGUgZmly
c3QgcGFnZSBvZiB0aGUgQ09NUCBwYWdlcy4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gU28gSSB0
aGluayB0aGVyZSBpcyBubyBpbXBhY3QuCj4gPiA+ID4gPgo+ID4gPiA+ID4gTm9wZSwgc2VlIHRo
aXM6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gICAgICAgICBpZiAoU0tCX0ZSQUdfUEFHRV9PUkRFUiAm
Jgo+ID4gPiA+ID4gICAgICAgICAgICAgIXN0YXRpY19icmFuY2hfdW5saWtlbHkoJm5ldF9oaWdo
X29yZGVyX2FsbG9jX2Rpc2FibGVfa2V5KSkgewo+ID4gPiA+ID4gICAgICAgICAgICAgICAgIC8q
IEF2b2lkIGRpcmVjdCByZWNsYWltIGJ1dCBhbGxvdyBrc3dhcGQgdG8gd2FrZSAqLwo+ID4gPiA+
ID4gICAgICAgICAgICAgICAgIHBmcmFnLT5wYWdlID0gYWxsb2NfcGFnZXMoKGdmcCAmIH5fX0dG
UF9ESVJFQ1RfUkVDTEFJTSkgfAo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgX19HRlBfQ09NUCB8IF9fR0ZQX05PV0FSTiB8Cj4gPiA+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX0dGUF9OT1JFVFJZLAo+ID4g
PiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU0tCX0ZSQUdf
UEFHRV9PUkRFUik7Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgaWYgKGxpa2VseShwZnJhZy0+
cGFnZSkpIHsKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHBmcmFnLT5zaXplID0g
UEFHRV9TSVpFIDw8IFNLQl9GUkFHX1BBR0VfT1JERVI7Cj4gPiA+ID4gPiAgICAgICAgICAgICAg
ICAgICAgICAgICByZXR1cm4gdHJ1ZTsKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICB9Cj4gPiA+
ID4gPiAgICAgICAgIH0KPiA+ID4gPiA+Cj4gPiA+ID4gPiBUaGUgY29tcCBwYWdlIG1pZ2h0IGJl
IGRpc2FibGVkIGR1ZSB0byB0aGUgU0tCX0ZSQUdfUEFHRV9PUkRFUiBhbmQKPiA+ID4gPiA+IG5l
dF9oaWdoX29yZGVyX2FsbG9jX2Rpc2FibGVfa2V5Lgo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBZ
RVMuCj4gPiA+ID4KPiA+ID4gPiBCdXQgaWYgY29tcCBwYWdlIGlzIGRpc2FibGVkLiBUaGVuIHdl
IG9ubHkgZ2V0IG9uZSBwYWdlIGVhY2ggdGltZS4gVGhlIHBhZ2VzIGFyZQo+ID4gPiA+IG5vdCBj
b250aWd1b3VzLCBzbyB3ZSBkb24ndCBoYXZlIGZyYWdzIGNvYWxlc2NpbmcuCj4gPiA+ID4KPiA+
ID4gPiBJZiB5b3UgbWVhbiB0aGUgdHdvIHBhZ2VzIGdvdCBmcm9tIGFsbG9jX3BhZ2UgbWF5IGJl
IGNvbnRpZ3VvdXMuIFRoZSBjb2FsZXNjaW5nCj4gPiA+ID4gbWF5IHRoZW4gYmUgYnJva2VuLiBJ
dCdzIGEgcG9zc2liaWxpdHksIGJ1dCBJIHRoaW5rIHRoZSBpbXBhY3Qgd2lsbCBiZSBzbWFsbC4K
PiA+ID4KPiA+ID4gTGV0J3MgaGF2ZSBhIHNpbXBsZSBiZW5jaG1hcmsgYW5kIHNlZT8KPiA+Cj4g
Pgo+ID4gVGhhdCBpcyBvay4KPiA+Cj4gPiBJIHRoaW5rIHlvdSB3YW50IHRvIGtub3cgdGhlIHBl
cmYgbnVtIHdpdGggYmlnIHRyYWZmaWMgYW5kIHRoZSBjb21wIHBhZ2UKPiA+IGRpc2FibGVkLgo+
Cj4gWWVzLgoKCkhpLAoKSG9zdDoKCWZvciAoKGk9MDsgaSA8IDEwOyArK2kpKSBkbyBzb2NrcGVy
ZiB0cCAtaSAxOTIuMTY4LjEyMi4xMDAgLXQgMTAwMCAgLW0gNjQwMDAmIGRvbmUKR3Vlc3Q6Cgkw
MzoyMzoxMiBBTSAgICAgSUZBQ0UgICByeHBjay9zICAgdHhwY2svcyAgICByeGtCL3MgICAgdHhr
Qi9zICAgcnhjbXAvcyAgIHR4Y21wL3MgIHJ4bWNzdC9zICAgJWlmdXRpbAoJMDM6MjM6MTMgQU0g
ICAgICAgIGxvICAgICAgMC4wMCAgICAgIDAuMDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAu
MDAgICAgICAwLjAwICAgICAgMC4wMCAgICAgIDAuMDAKCTAzOjIzOjEzIEFNICAgICAgZW5zNCAg
NjE4NDguMDAgICAgICAxLjAwIDM4NjgwMzYuNzMgICAgICAwLjU4ICAgICAgMC4wMCAgICAgIDAu
MDAgICAgICAwLjAwICAgICAgMC4wMAoKCXRjcGR1bXA6CgkJMDM6MjU6MDEuNzQxNTYzIElQIDE5
Mi4xNjguMTIyLjEuMjk2OTMgPiAxOTIuMTY4LjEyMi4xMDAuMTExMTE6IFVEUCwgbGVuZ3RoIDY0
MDAwCgkJMDM6MjU6MDEuNzQxNTgwIElQIDE5Mi4xNjguMTIyLjEuMjIyMzkgPiAxOTIuMTY4LjEy
Mi4xMDAuMTExMTE6IFVEUCwgbGVuZ3RoIDY0MDAwCgkJMDM6MjU6MDEuNzQxNjIzIElQIDE5Mi4x
NjguMTIyLjEuMjIzOTYgPiAxOTIuMTY4LjEyMi4xMDAuMTExMTE6IFVEUCwgbGVuZ3RoIDY0MDAw
CgpUaGUgR3Vlc3QgQ1BVIHV0aWwgaXMgbG93LCBldmVyeSBwYWNrZXQgaXMgNjQwMDAuIEJ1dCB0
aGUgSG9zdCB2aG9zdCBwcm9jZXNzIGlzCjEwMCUuIFNvIHdlIGNhbiBub3QganVkZ2UgYnkgdGhl
IHRyYWZmaWMgb3IgdGhlIGNwdSBvZiB0aGUgR3Vlc3QuCgpTbyBJIHVzZSB0aGUga2VybmVsIHdp
dGhvdXQgbXkgcGF0Y2hlcyAwNjM1ODE5ZGVjYWY5ZDYwZTZjYWNmZWNmZWJmYWJlM2NiZGRkYWZi
LgoKSSB3YW50IHRvIGNvdW50IHRoZSBmcmFncyBjb2FsZXNjaW5nIG51bSB3aGVuIHRoZSBjb21w
IHBhZ2UgaXMgZGlzYWJsZWQuCgoJJCBzaCAteCB0ZXN0LnNoCgkrIHN5c2N0bCAtdyBuZXQuY29y
ZS5oaWdoX29yZGVyX2FsbG9jX2Rpc2FibGU9MQoJbmV0LmNvcmUuaGlnaF9vcmRlcl9hbGxvY19k
aXNhYmxlID0gMQoJKyBzeXNjdGwgbmV0LmNvcmUuaGlnaF9vcmRlcl9hbGxvY19kaXNhYmxlCglu
ZXQuY29yZS5oaWdoX29yZGVyX2FsbG9jX2Rpc2FibGUgPSAxCgkrIHNsZWVwIDUKCSsgdGltZW91
dCA1IGJwZnRyYWNlIC1lICdrcHJvYmU6IHNrYl9jb2FsZXNjZV9yeF9mcmFne0BbbnNlY3MvMTAw
MC8xMDAwLzEwMDBdPWNvdW50KCl9JwoJQXR0YWNoaW5nIDEgcHJvYmUuLi4KCgoKCSsgc3lzY3Rs
IC13IG5ldC5jb3JlLmhpZ2hfb3JkZXJfYWxsb2NfZGlzYWJsZT0wCgluZXQuY29yZS5oaWdoX29y
ZGVyX2FsbG9jX2Rpc2FibGUgPSAwCgkrIHN5c2N0bCBuZXQuY29yZS5oaWdoX29yZGVyX2FsbG9j
X2Rpc2FibGUKCW5ldC5jb3JlLmhpZ2hfb3JkZXJfYWxsb2NfZGlzYWJsZSA9IDAKCSsgc2xlZXAg
NQoJKyB0aW1lb3V0IDUgYnBmdHJhY2UgLWUgJ2twcm9iZTogc2tiX2NvYWxlc2NlX3J4X2ZyYWd7
QFtuc2Vjcy8xMDAwLzEwMDAvMTAwMF09Y291bnQoKX0nCglBdHRhY2hpbmcgMSBwcm9iZS4uLgoK
CglAWzM1Nl06IDE2NzAyMAoJQFszNjFdOiA2NzM2NTMKCUBbMzU5XTogOTAwODQ0CglAWzM2MF06
IDkxMjY1NwoJQFszNThdOiA5MTU4NTMKCUBbMzU3XTogOTMyMjQ1CgoKV2UgY2FuIHNlZSB0aGF0
IHRoZSBza2JfY29hbGVzY2VfcnhfZnJhZyBpcyBub3QgY2FsbGVkIHdoZW4gY29tcCBwYWdlIGlz
IGRpc2FibGVkLgpJZiB0aGUgY29tcCBwYWdlIGlzIGVuYWJsZSwgdGhlcmUgd2lsbCBiZSBtYW55
IGZyYWdzIGNvYWxlc2NpbmcuCgpTbyBJIHRoaW5rIHRoYXQgbXkgY2hhbmdlIHdpbGwgbm90IGhh
dmUgaW1wYWN0LgoKVGhhbmtzLgoKCgoKPgo+IFRoYW5rcwo+Cj4gPgo+ID4gVGhhbmtzLgo+ID4K
PiA+Cj4gPiA+Cj4gPiA+IFRoYW5rcwo+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gVGhhbmtzLgo+ID4g
PiA+Cj4gPiA+ID4KPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gMikgcHJlIG1hcHBlZCBETUEgYWRkcmVzc2VzIHdlcmUgbm90IHJldXNlZCBpbiB0aGUgY2Fz
ZSBvZiBYRFBfVFgvWERQX1JFRElSRUNUCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IEJlY2F1c2Ug
dGhhdCB0aGUgdHggaXMgbm90IHRoZSBwcmVtYXBwZWQgbW9kZS4KPiA+ID4gPiA+Cj4gPiA+ID4g
PiBZZXMsIHdlIGNhbiBvcHRpbWl6ZSB0aGlzIG9uIHRvcC4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBU
aGFua3MKPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFRoYW5rcy4KPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEkgc2VlIE1pY2hhZWwgaGFzIG1lcmdlIHRo
aXMgc2VyaWVzIHNvIEknbSBmaW5lIHRvIGxldCBpdCBnbyBmaXJzdC4KPiA+ID4gPiA+ID4gPgo+
ID4gPiA+ID4gPiA+IFRoYW5rcwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4gPiA+ID4gVGhhbmtzLgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPgo+ID4KPgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
