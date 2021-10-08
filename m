Return-Path: <SRS0=03hR=O4=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D46EC433F5
	for <virtualization@archiver.kernel.org>; Fri,  8 Oct 2021 16:41:34 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9D0C260F9C
	for <virtualization@archiver.kernel.org>; Fri,  8 Oct 2021 16:41:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9D0C260F9C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5ACA740192;
	Fri,  8 Oct 2021 16:41:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nOdZcURwUxch; Fri,  8 Oct 2021 16:41:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9B6E540482;
	Fri,  8 Oct 2021 16:41:31 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 70679C000F;
	Fri,  8 Oct 2021 16:41:31 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E479FC000D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Oct 2021 16:41:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C51F740482
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Oct 2021 16:41:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0TSVWb8oWwPL
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Oct 2021 16:41:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-132.freemail.mail.aliyun.com
 (out30-132.freemail.mail.aliyun.com [115.124.30.132])
 by smtp2.osuosl.org (Postfix) with ESMTPS id AD51E40192
 for <virtualization@lists.linux-foundation.org>;
 Fri,  8 Oct 2021 16:41:27 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R141e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04395; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0Ur0qMHi_1633711282; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Ur0qMHi_1633711282) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 09 Oct 2021 00:41:23 +0800
MIME-Version: 1.0
message-id: <1633710428.4908655-1-xuanzhuo@linux.alibaba.com>
subject: Re: virtio-net: kernel panic in virtio_net.c
date: Sat, 09 Oct 2021 00:27:08 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: Greg KH <gregkh@linuxfoundation.org>
in-reply-to: <YV/8Ia1d9zXvMqqc@kroah.com>
Cc: regressions@lists.linux.dev, "Michael S. Tsirkin" <mst@redhat.com>,
 =?utf-8?q?Corentin_No=C3=ABl?= <corentin.noel@collabora.com>,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>
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

T24gRnJpLCA4IE9jdCAyMDIxIDEwOjA2OjU3ICswMjAwLCBHcmVnIEtIIDxncmVna2hAbGludXhm
b3VuZGF0aW9uLm9yZz4gd3JvdGU6Cj4gT24gRnJpLCBPY3QgMDgsIDIwMjEgYXQgMTI6MTc6MjZB
TSArMDgwMCwgWHVhbiBaaHVvIHdyb3RlOgo+ID4gT24gVGh1LCA3IE9jdCAyMDIxIDE3OjI1OjAy
ICswMjAwLCBHcmVnIEtIIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6Cj4gPiA+
IE9uIFRodSwgT2N0IDA3LCAyMDIxIGF0IDExOjA2OjEyUE0gKzA4MDAsIFh1YW4gWmh1byB3cm90
ZToKPiA+ID4gPiBPbiBUaHUsIDA3IE9jdCAyMDIxIDE0OjA0OjIyICswMjAwLCBDb3JlbnRpbiBO
b8OrbCA8Y29yZW50aW4ubm9lbEBjb2xsYWJvcmEuY29tPiB3cm90ZToKPiA+ID4gPiA+IEkndmUg
YmVlbiBleHBlcmllbmNpbmcgY3Jhc2hlcyB3aXRoIDUuMTQtcmMxIGFuZCBhYm92ZSB0aGF0IGRv
IG5vdAo+ID4gPiA+ID4gb2NjdXIgd2l0aCA1LjEzLAo+ID4gPiA+Cj4gPiA+ID4gSSBzaG91bGQg
aGF2ZSBmaXhlZCB0aGlzIHByb2JsZW0gYmVmb3JlLiBJIGRvbid0IGtub3cgd2h5LCBJIGp1c3Qg
bG9va2VkIGF0IHRoZQo+ID4gPiA+IGxhdGVzdCBuZXQgY29kZSwgYW5kIHRoaXMgY29tbWl0IHNl
ZW1zIHRvIGJlIGxvc3QuCj4gPiA+ID4KPiA+ID4gPiAgICAgIDFhODAyNDIzOWRhY2Y1M2ZjZjM5
YzBmMDdmYmYyNzEyYWYyMjg2NGYgdmlydGlvLW5ldDogZml4IGZvciBza2Jfb3Zlcl9wYW5pYyBp
bnNpZGUgYmlnIG1vZGUKPiA+ID4gPgo+ID4gPiA+IENhbiB5b3UgdGVzdCB0aGlzIHBhdGNoIGFn
YWluPwo+ID4gPgo+ID4gPiBUaGF0IGNvbW1pdCBzaG93ZWQgdXAgaW4gNS4xMy1yYzUsIHNvIDUu
MTQtcmMxIGFuZCA1LjEzIHNob3VsZCBoYXZlIGhhZAo+ID4gPiBpdCBpbiBpdCwgcmlnaHQ/Cj4g
PiA+Cj4gPgo+ID4gWWVzLCBpdCBtYXkgYmUgbG9zdCBkdWUgdG8gY29uZmxpY3RzIGR1cmluZyBh
IGNlcnRhaW4gbWVyZ2UuCj4KPiBSZWFsbHk/ICBJIHRyaWVkIHRvIGFwcGx5IHRoYXQgYWdhaW4g
dG8gNS4xNCBhbmQgaXQgZGlkIG5vdCB3b3JrLiAgU28gSQo+IGRvIG5vdCB1bmRlcnN0YW5kIHdo
YXQgdG8gZG8gaGVyZSwgY2FuIHlvdSB0cnkgdG8gZXhwbGFpbiBpdCBiZXR0ZXI/CgpJIHRvb2sg
YSBsb29rLCBhbmQgdGhlcmUgaXMgYWN0dWFsbHkgYW5vdGhlciBtaXNzaW5nIHBhdGNoOgoKQS4g
OGZiN2RhOWU5OTA3OTMyOTljODllZDdhNDI4MWMyMzViZmRkMzFmOCB2aXJ0aW9fbmV0OiBnZXQg
YnVpbGRfc2tiKCkgYnVmIGJ5IGRhdGEgcHRyCkIuIDFhODAyNDIzOWRhY2Y1M2ZjZjM5YzBmMDdm
YmYyNzEyYWYyMjg2NGYgdmlydGlvLW5ldDogZml4IGZvciBza2Jfb3Zlcl9wYW5pYyBpbnNpZGUg
YmlnIG1vZGUKCkEgaXMgcmVwbGFjZWQgYnkgYW5vdGhlciBwYXRjaDoKCgljb21taXQgYzMyMzI1
YjhmZGYyZjk3OWJlZmI5ZmQ1NTg3OTE4YzBkNTQxMmRiMwoJQXV0aG9yOiBKYWt1YiBLaWNpbnNr
aSA8a3ViYUBrZXJuZWwub3JnPgoJRGF0ZTogICBNb24gQXVnIDIgMTA6NTc6MjkgMjAyMSAtMDcw
MAoKCSAgICB2aXJ0aW8tbmV0OiByZWFsaWduIHBhZ2VfdG9fc2tiKCkgYWZ0ZXIgbWVyZ2VzCgoJ
ICAgIFdlIGVuZGVkIHVwIG1lcmdpbmcgdHdvIHZlcnNpb25zIG9mIHRoZSBzYW1lIHBhdGNoIHNl
dDoKCgkgICAgY29tbWl0IDhmYjdkYTllOTkwNyAoInZpcnRpb19uZXQ6IGdldCBidWlsZF9za2Io
KSBidWYgYnkgZGF0YSBwdHIiKQoJICAgIGNvbW1pdCA1YzM3NzExZDlmMjcgKCJ2aXJ0aW8tbmV0
OiBmaXggZm9yIHVuYWJsZSB0byBoYW5kbGUgcGFnZSBmYXVsdCBmb3IgYWRkcmVzcyIpCgoJICAg
IGludG8gbmV0LCBhbmQKCgkgICAgY29tbWl0IDdiZjY0NDYwZTNiMiAoInZpcnRpby1uZXQ6IGdl
dCBidWlsZF9za2IoKSBidWYgYnkgZGF0YSBwdHIiKQoJICAgIGNvbW1pdCA2YzY2YzE0N2I5YTQg
KCJ2aXJ0aW8tbmV0OiBmaXggZm9yIHVuYWJsZSB0byBoYW5kbGUgcGFnZSBmYXVsdCBmb3IgYWRk
cmVzcyIpCgoJICAgIGludG8gbmV0LW5leHQuIFJlZG8gdGhlIG1lcmdlIGZyb20gY29tbWl0IDEy
NjI4NTY1MWI3ZiAoIk1lcmdlCgkgICAgcmEua2VybmVsLm9yZzovcHViL3NjbS9saW51eC9rZXJu
ZWwvZ2l0L25ldGRldi9uZXQiKSwgc28gdGhhdAoJICAgIHRoZSBtb3N0IHJlY2VudCBjb2RlIHJl
bWFpbnMuCgoJICAgIEFja2VkLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29t
PgoJICAgIFNpZ25lZC1vZmYtYnk6IEpha3ViIEtpY2luc2tpIDxrdWJhQGtlcm5lbC5vcmc+Cgkg
ICAgQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgkgICAgU2lnbmVk
LW9mZi1ieTogRGF2aWQgUy4gTWlsbGVyIDxkYXZlbUBkYXZlbWxvZnQubmV0PgoKU28gYWZ0ZXIg
dGhpcyBwYXRjaCwgcGF0Y2ggQiBjYW4gYmUgYXBwbGllZCBub3JtYWxseS4KClNvIG9uIHRoZSBs
YXRlc3QgbmV0IGJyYW5jaCwgb25seSBsb3N0CgogICAgICAgICAgMWE4MDI0MjM5ZGFjZjUzZmNm
MzljMGYwN2ZiZjI3MTJhZjIyODY0ZiB2aXJ0aW8tbmV0OiBmaXggZm9yIHNrYl9vdmVyX3Bhbmlj
IGluc2lkZSBiaWcgbW9kZQoKVGhhbmtzLgoKPgo+IHRoYW5rcywKPgo+IGdyZWcgay1oCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
