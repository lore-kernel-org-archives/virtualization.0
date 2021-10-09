Return-Path: <SRS0=+9Ss=O5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 893F4C433EF
	for <virtualization@archiver.kernel.org>; Sat,  9 Oct 2021 09:30:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1ECD160F6C
	for <virtualization@archiver.kernel.org>; Sat,  9 Oct 2021 09:30:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 1ECD160F6C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E0221401EC;
	Sat,  9 Oct 2021 09:30:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IHJW809XqYsz; Sat,  9 Oct 2021 09:30:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id A14BC401EA;
	Sat,  9 Oct 2021 09:30:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 66867C000F;
	Sat,  9 Oct 2021 09:30:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C646CC000D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Oct 2021 09:30:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id B5E64832D9
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Oct 2021 09:30:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2UIKSvgN7wcB
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Oct 2021 09:30:08 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-133.freemail.mail.aliyun.com
 (out30-133.freemail.mail.aliyun.com [115.124.30.133])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7219283260
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Oct 2021 09:30:08 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=9; SR=0; TI=SMTPD_---0Ur5Wrt5_1633771803; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Ur5Wrt5_1633771803) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 09 Oct 2021 17:30:04 +0800
MIME-Version: 1.0
message-id: <1633771770.158572-1-xuanzhuo@linux.alibaba.com>
subject: Re: [PATCH net] virtio-net: fix for skb_over_panic inside big mode
date: Sat, 09 Oct 2021 17:29:30 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: Michael S. Tsirkin <mst@redhat.com>
in-reply-to: <20211009091604.84141-1-mst@redhat.com>
x-mailing-list: netdev@vger.kernel.org
Cc: Greg KH <gregkh@linuxfoundation.org>,
 =?utf-8?q?Corentin_No=C3=ABl?= <corentin.noel@collabora.com>,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org,
 Jakub Kicinski <kuba@kernel.org>, "David S. Miller" <davem@davemloft.net>,
 linux-kernel@vger.kernel.org
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gU2F0LCA5IE9jdCAyMDIxIDA1OjE3OjUzIC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gPG1z
dEByZWRoYXQuY29tPiB3cm90ZToKPiBGcm9tOiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFs
aWJhYmEuY29tPgo+Cj4gY29tbWl0IDEyNjI4NTY1MWI3ZiAoIk1lcmdlIHJhLmtlcm5lbC5vcmc6
L3B1Yi9zY20vbGludXgva2VybmVsL2dpdC9uZXRkZXYvbmV0IikKPiBhY2NpZGVudGFsbHkgcmV2
ZXJ0ZWQgdGhlIGVmZmVjdCBvZgo+IGNvbW1pdCAxYTgwMjQyMzlkYSAoInZpcnRpby1uZXQ6IGZp
eCBmb3Igc2tiX292ZXJfcGFuaWMgaW5zaWRlIGJpZyBtb2RlIikKPiBvbiBkcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMKPgo+IEFzIGEgcmVzdWx0LCB1c2VycyBvZiBjcm9zdm0gKHdoaWNoIGlzIHVz
aW5nIGxhcmdlIHBhY2tldCBtb2RlKQo+IGFyZSBleHBlcmllbmNpbmcgY3Jhc2hlcyB3aXRoIDUu
MTQtcmMxIGFuZCBhYm92ZSB0aGF0IGRvIG5vdAo+IG9jY3VyIHdpdGggNS4xMy4KPgo+IENyYXNo
IHRyYWNlOgo+Cj4gWyAgIDYxLjM0NjY3N10gc2tidWZmOiBza2Jfb3Zlcl9wYW5pYzogdGV4dDpm
ZmZmZmZmZjg4MWFlMmM3IGxlbjozNzYyIHB1dDozNzYyIGhlYWQ6ZmZmZjhhNWVjOGMyMjAwMCBk
YXRhOmZmZmY4YTVlYzhjMjIwMTAgdGFpbDoweGVjMiBlbmQ6MHhlYzAgZGV2OjxOVUxMPgo+IFsg
ICA2MS4zNjkxOTJdIGtlcm5lbCBCVUcgYXQgbmV0L2NvcmUvc2tidWZmLmM6MTExIQo+IFsgICA2
MS4zNzI4NDBdIGludmFsaWQgb3Bjb2RlOiAwMDAwIFsjMV0gU01QIFBUSQo+IFsgICA2MS4zNzQ4
OTJdIENQVTogNSBQSUQ6IDAgQ29tbTogc3dhcHBlci81IE5vdCB0YWludGVkIDUuMTQuMC1yYzEg
bGludXgtdjUuMTQtcmMxLWZvci1tZXNhLWNpLnRhci5iejIgIzEKPiBbICAgNjEuMzc2NDUwXSBI
YXJkd2FyZSBuYW1lOiBDaHJvbWl1bU9TIGNyb3N2bSwgQklPUyAwCj4KPiAuLgo+Cj4gWyAgIDYx
LjM5MzYzNV0gQ2FsbCBUcmFjZToKPiBbICAgNjEuMzk0MTI3XSAgPElSUT4KPiBbICAgNjEuMzk0
NDg4XSAgc2tiX3B1dC5jb2xkKzB4MTAvMHgxMAo+IFsgICA2MS4zOTUwOTVdICBwYWdlX3RvX3Nr
YisweGY3LzB4NDEwCj4gWyAgIDYxLjM5NTY4OV0gIHJlY2VpdmVfYnVmKzB4ODEvMHgxNjYwCj4g
WyAgIDYxLjM5NjIyOF0gID8gbmV0aWZfcmVjZWl2ZV9za2JfbGlzdF9pbnRlcm5hbCsweDFhZC8w
eDJiMAo+IFsgICA2MS4zOTcxODBdICA/IG5hcGlfZ3JvX2ZsdXNoKzB4OTcvMHhlMAo+IFsgICA2
MS4zOTc4OTZdICA/IGRldGFjaF9idWZfc3BsaXQrMHg2Ny8weDEyMAo+IFsgICA2MS4zOTg1NzNd
ICB2aXJ0bmV0X3BvbGwrMHgyY2YvMHg0MjAKPiBbICAgNjEuMzk5MTk3XSAgX19uYXBpX3BvbGwr
MHgyNS8weDE1MAo+IFsgICA2MS4zOTk3NjRdICBuZXRfcnhfYWN0aW9uKzB4MjJmLzB4MjgwCj4g
WyAgIDYxLjQwMDM5NF0gIF9fZG9fc29mdGlycSsweGJhLzB4MjU3Cj4gWyAgIDYxLjQwMTAxMl0g
IGlycV9leGl0X3JjdSsweDhlLzB4YjAKPiBbICAgNjEuNDAxNjE4XSAgY29tbW9uX2ludGVycnVw
dCsweDdiLzB4YTAKPiBbICAgNjEuNDAyMjcwXSAgPC9JUlE+Cj4KPiBTZWUKPiBodHRwczovL2xv
cmUua2VybmVsLm9yZy9yLzVlZGFhMmI3YzJmZTRhYmQwMzQ3Yjg0NTRiMmFjMDMyYjY2OTRlMmMu
Y2FtZWwlNDBjb2xsYWJvcmEuY29tCj4gZm9yIHRoZSByZXBvcnQuCj4KPiBBcHBseSB0aGUgb3Jp
Z2luYWwgMWE4MDI0MjM5ZGEgKCJ2aXJ0aW8tbmV0OiBmaXggZm9yIHNrYl9vdmVyX3BhbmljIGlu
c2lkZSBiaWcgbW9kZSIpCj4gYWdhaW4sIHRoZSBvcmlnaW5hbCBsb2dpYyBzdGlsbCBob2xkczoK
Pgo+IEluIHZpcnRpby1uZXQncyBsYXJnZSBwYWNrZXQgbW9kZSwgdGhlcmUgaXMgYSBob2xlIGlu
IHRoZSBzcGFjZSBiZWhpbmQKPiBidWYuCj4KPiAgICAgaGRyX3BhZGRlZF9sZW4gLSBoZHJfbGVu
Cj4KPiBXZSBtdXN0IHRha2UgdGhpcyBpbnRvIGFjY291bnQgd2hlbiBjYWxjdWxhdGluZyB0YWls
cm9vbS4KPgo+IENjOiBHcmVnIEtIIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4KPiBGaXhl
czogZmIzMjg1NmIxNmFkICgidmlydGlvLW5ldDogcGFnZV90b19za2IoKSB1c2UgYnVpbGRfc2ti
IHdoZW4gdGhlcmUncyBzdWZmaWNpZW50IHRhaWxyb29tIikKPiBGaXhlczogMTI2Mjg1NjUxYjdm
ICgiTWVyZ2UgcmEua2VybmVsLm9yZzovcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25ldGRldi9u
ZXQiKQo+IFNpZ25lZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5j
b20+Cj4gUmVwb3J0ZWQtYnk6IENvcmVudGluIE5vw6tsIDxjb3JlbnRpbi5ub2VsQGNvbGxhYm9y
YS5jb20+Cj4gVGVzdGVkLWJ5OiBDb3JlbnRpbiBOb8OrbCA8Y29yZW50aW4ubm9lbEBjb2xsYWJv
cmEuY29tPgo+IFNpZ25lZC1vZmYtYnk6IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5j
b20+CgpMR1RNCgpSZXZpZXdlZC1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJh
LmNvbT4KCj4gLS0tCj4KPiBEYXZpZCwgSSB0aGluayB3ZSBuZWVkIHRoaXMgaW4gc3RhYmxlLCB0
b28uCj4KPiAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgMiArLQo+ICAxIGZpbGUgY2hhbmdl
ZCwgMSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBpbmRleCAwOTZj
MmFjNmI3YTYuLjZiMDgxMmY0NGJiZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9f
bmV0LmMKPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiBAQCAtNDA2LDcgKzQwNiw3
IEBAIHN0YXRpYyBzdHJ1Y3Qgc2tfYnVmZiAqcGFnZV90b19za2Ioc3RydWN0IHZpcnRuZXRfaW5m
byAqdmksCj4gIAkgKiBhZGRfcmVjdmJ1Zl9tZXJnZWFibGUoKSArIGdldF9tZXJnZWFibGVfYnVm
X2xlbigpCj4gIAkgKi8KPiAgCXRydWVzaXplID0gaGVhZHJvb20gPyBQQUdFX1NJWkUgOiB0cnVl
c2l6ZTsKPiAtCXRhaWxyb29tID0gdHJ1ZXNpemUgLSBsZW4gLSBoZWFkcm9vbTsKPiArCXRhaWxy
b29tID0gdHJ1ZXNpemUgLSBsZW4gLSBoZWFkcm9vbSAtIChoZHJfcGFkZGVkX2xlbiAtIGhkcl9s
ZW4pOwo+ICAJYnVmID0gcCAtIGhlYWRyb29tOwo+Cj4gIAlsZW4gLT0gaGRyX2xlbjsKPiAtLQo+
IE1TVAo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
