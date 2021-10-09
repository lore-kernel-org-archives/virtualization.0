Return-Path: <SRS0=+9Ss=O5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 477C9C433F5
	for <virtualization@archiver.kernel.org>; Sat,  9 Oct 2021 09:40:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D18AB610A4
	for <virtualization@archiver.kernel.org>; Sat,  9 Oct 2021 09:40:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D18AB610A4
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 87AAA40131;
	Sat,  9 Oct 2021 09:40:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OnzXK_cmLjTF; Sat,  9 Oct 2021 09:40:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D398640265;
	Sat,  9 Oct 2021 09:40:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A25B2C000F;
	Sat,  9 Oct 2021 09:40:09 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9839CC000D
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Oct 2021 09:40:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 94BC340641
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Oct 2021 09:40:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rovqFSr86Gro
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Oct 2021 09:40:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-130.freemail.mail.aliyun.com
 (out30-130.freemail.mail.aliyun.com [115.124.30.130])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6BCEE40634
 for <virtualization@lists.linux-foundation.org>;
 Sat,  9 Oct 2021 09:40:03 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R891e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04394; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=8; SR=0; TI=SMTPD_---0Ur5h2r1_1633772400; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Ur5h2r1_1633772400) by smtp.aliyun-inc.com(127.0.0.1);
 Sat, 09 Oct 2021 17:40:01 +0800
MIME-Version: 1.0
message-id: <1633771866.6350079-2-xuanzhuo@linux.alibaba.com>
subject: Re: virtio-net: kernel panic in virtio_net.c
date: Sat, 09 Oct 2021 17:31:06 +0800
from: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
to: Greg KH <gregkh@linuxfoundation.org>
in-reply-to: <YWEma6YvB2HN9/E/@kroah.com>
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

T24gU2F0LCA5IE9jdCAyMDIxIDA3OjE5OjM5ICswMjAwLCBHcmVnIEtIIDxncmVna2hAbGludXhm
b3VuZGF0aW9uLm9yZz4gd3JvdGU6Cj4gT24gU2F0LCBPY3QgMDksIDIwMjEgYXQgMTI6Mjc6MDhB
TSArMDgwMCwgWHVhbiBaaHVvIHdyb3RlOgo+ID4gT24gRnJpLCA4IE9jdCAyMDIxIDEwOjA2OjU3
ICswMjAwLCBHcmVnIEtIIDxncmVna2hAbGludXhmb3VuZGF0aW9uLm9yZz4gd3JvdGU6Cj4gPiA+
IE9uIEZyaSwgT2N0IDA4LCAyMDIxIGF0IDEyOjE3OjI2QU0gKzA4MDAsIFh1YW4gWmh1byB3cm90
ZToKPiA+ID4gPiBPbiBUaHUsIDcgT2N0IDIwMjEgMTc6MjU6MDIgKzAyMDAsIEdyZWcgS0ggPGdy
ZWdraEBsaW51eGZvdW5kYXRpb24ub3JnPiB3cm90ZToKPiA+ID4gPiA+IE9uIFRodSwgT2N0IDA3
LCAyMDIxIGF0IDExOjA2OjEyUE0gKzA4MDAsIFh1YW4gWmh1byB3cm90ZToKPiA+ID4gPiA+ID4g
T24gVGh1LCAwNyBPY3QgMjAyMSAxNDowNDoyMiArMDIwMCwgQ29yZW50aW4gTm/Dq2wgPGNvcmVu
dGluLm5vZWxAY29sbGFib3JhLmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gSSd2ZSBiZWVuIGV4
cGVyaWVuY2luZyBjcmFzaGVzIHdpdGggNS4xNC1yYzEgYW5kIGFib3ZlIHRoYXQgZG8gbm90Cj4g
PiA+ID4gPiA+ID4gb2NjdXIgd2l0aCA1LjEzLAo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBJIHNo
b3VsZCBoYXZlIGZpeGVkIHRoaXMgcHJvYmxlbSBiZWZvcmUuIEkgZG9uJ3Qga25vdyB3aHksIEkg
anVzdCBsb29rZWQgYXQgdGhlCj4gPiA+ID4gPiA+IGxhdGVzdCBuZXQgY29kZSwgYW5kIHRoaXMg
Y29tbWl0IHNlZW1zIHRvIGJlIGxvc3QuCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ICAgICAgMWE4
MDI0MjM5ZGFjZjUzZmNmMzljMGYwN2ZiZjI3MTJhZjIyODY0ZiB2aXJ0aW8tbmV0OiBmaXggZm9y
IHNrYl9vdmVyX3BhbmljIGluc2lkZSBiaWcgbW9kZQo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBD
YW4geW91IHRlc3QgdGhpcyBwYXRjaCBhZ2Fpbj8KPiA+ID4gPiA+Cj4gPiA+ID4gPiBUaGF0IGNv
bW1pdCBzaG93ZWQgdXAgaW4gNS4xMy1yYzUsIHNvIDUuMTQtcmMxIGFuZCA1LjEzIHNob3VsZCBo
YXZlIGhhZAo+ID4gPiA+ID4gaXQgaW4gaXQsIHJpZ2h0Pwo+ID4gPiA+ID4KPiA+ID4gPgo+ID4g
PiA+IFllcywgaXQgbWF5IGJlIGxvc3QgZHVlIHRvIGNvbmZsaWN0cyBkdXJpbmcgYSBjZXJ0YWlu
IG1lcmdlLgo+ID4gPgo+ID4gPiBSZWFsbHk/ICBJIHRyaWVkIHRvIGFwcGx5IHRoYXQgYWdhaW4g
dG8gNS4xNCBhbmQgaXQgZGlkIG5vdCB3b3JrLiAgU28gSQo+ID4gPiBkbyBub3QgdW5kZXJzdGFu
ZCB3aGF0IHRvIGRvIGhlcmUsIGNhbiB5b3UgdHJ5IHRvIGV4cGxhaW4gaXQgYmV0dGVyPwo+ID4K
PiA+IEkgdG9vayBhIGxvb2ssIGFuZCB0aGVyZSBpcyBhY3R1YWxseSBhbm90aGVyIG1pc3Npbmcg
cGF0Y2g6Cj4gPgo+ID4gQS4gOGZiN2RhOWU5OTA3OTMyOTljODllZDdhNDI4MWMyMzViZmRkMzFm
OCB2aXJ0aW9fbmV0OiBnZXQgYnVpbGRfc2tiKCkgYnVmIGJ5IGRhdGEgcHRyCj4gPiBCLiAxYTgw
MjQyMzlkYWNmNTNmY2YzOWMwZjA3ZmJmMjcxMmFmMjI4NjRmIHZpcnRpby1uZXQ6IGZpeCBmb3Ig
c2tiX292ZXJfcGFuaWMgaW5zaWRlIGJpZyBtb2RlCj4gPgo+ID4gQSBpcyByZXBsYWNlZCBieSBh
bm90aGVyIHBhdGNoOgo+ID4KPiA+IAljb21taXQgYzMyMzI1YjhmZGYyZjk3OWJlZmI5ZmQ1NTg3
OTE4YzBkNTQxMmRiMwo+ID4gCUF1dGhvcjogSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9y
Zz4KPiA+IAlEYXRlOiAgIE1vbiBBdWcgMiAxMDo1NzoyOSAyMDIxIC0wNzAwCj4gPgo+ID4gCSAg
ICB2aXJ0aW8tbmV0OiByZWFsaWduIHBhZ2VfdG9fc2tiKCkgYWZ0ZXIgbWVyZ2VzCj4gPgo+ID4g
CSAgICBXZSBlbmRlZCB1cCBtZXJnaW5nIHR3byB2ZXJzaW9ucyBvZiB0aGUgc2FtZSBwYXRjaCBz
ZXQ6Cj4gPgo+ID4gCSAgICBjb21taXQgOGZiN2RhOWU5OTA3ICgidmlydGlvX25ldDogZ2V0IGJ1
aWxkX3NrYigpIGJ1ZiBieSBkYXRhIHB0ciIpCj4gPiAJICAgIGNvbW1pdCA1YzM3NzExZDlmMjcg
KCJ2aXJ0aW8tbmV0OiBmaXggZm9yIHVuYWJsZSB0byBoYW5kbGUgcGFnZSBmYXVsdCBmb3IgYWRk
cmVzcyIpCj4gPgo+ID4gCSAgICBpbnRvIG5ldCwgYW5kCj4gPgo+ID4gCSAgICBjb21taXQgN2Jm
NjQ0NjBlM2IyICgidmlydGlvLW5ldDogZ2V0IGJ1aWxkX3NrYigpIGJ1ZiBieSBkYXRhIHB0ciIp
Cj4gPiAJICAgIGNvbW1pdCA2YzY2YzE0N2I5YTQgKCJ2aXJ0aW8tbmV0OiBmaXggZm9yIHVuYWJs
ZSB0byBoYW5kbGUgcGFnZSBmYXVsdCBmb3IgYWRkcmVzcyIpCj4gPgo+ID4gCSAgICBpbnRvIG5l
dC1uZXh0LiBSZWRvIHRoZSBtZXJnZSBmcm9tIGNvbW1pdCAxMjYyODU2NTFiN2YgKCJNZXJnZQo+
ID4gCSAgICByYS5rZXJuZWwub3JnOi9wdWIvc2NtL2xpbnV4L2tlcm5lbC9naXQvbmV0ZGV2L25l
dCIpLCBzbyB0aGF0Cj4gPiAJICAgIHRoZSBtb3N0IHJlY2VudCBjb2RlIHJlbWFpbnMuCj4gPgo+
ID4gCSAgICBBY2tlZC1ieTogTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4KPiA+
IAkgICAgU2lnbmVkLW9mZi1ieTogSmFrdWIgS2ljaW5za2kgPGt1YmFAa2VybmVsLm9yZz4KPiA+
IAkgICAgQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4gPiAJICAg
IFNpZ25lZC1vZmYtYnk6IERhdmlkIFMuIE1pbGxlciA8ZGF2ZW1AZGF2ZW1sb2Z0Lm5ldD4KPiA+
Cj4gPiBTbyBhZnRlciB0aGlzIHBhdGNoLCBwYXRjaCBCIGNhbiBiZSBhcHBsaWVkIG5vcm1hbGx5
Lgo+ID4KPiA+IFNvIG9uIHRoZSBsYXRlc3QgbmV0IGJyYW5jaCwgb25seSBsb3N0Cj4gPgo+ID4g
ICAgICAgICAgIDFhODAyNDIzOWRhY2Y1M2ZjZjM5YzBmMDdmYmYyNzEyYWYyMjg2NGYgdmlydGlv
LW5ldDogZml4IGZvciBza2Jfb3Zlcl9wYW5pYyBpbnNpZGUgYmlnIG1vZGUKPgo+IEFnYWluLCBJ
IGRvIG5vdCBrbm93IHdoYXQgdG8gZG8gaGVyZSwgY2FuIHlvdSBzdWJtaXQgdGhlIG5lZWRlZCBm
aXggdG8KPiB0aGUgbmV0d29ya2luZyBkZXZlbG9wZXJzIHNvIHRoaXMgZ2V0cyBmaXhlZD8KCk1p
Y2hhZWwgaGFzIGFscmVhZHkgc3VibWl0dGVkIHRoZSBwYXRjaC4KCmh0dHBzOi8vbG9yZS5rZXJu
ZWwub3JnL25ldGRldi8yMDIxMTAwOTA5MTYwNC44NDE0MS0xLW1zdEByZWRoYXQuY29tL1QvI3UK
ClRoYW5rcy4KCj4KPiB0aGFua3MsCj4KPiBncmVnIGstaApfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
