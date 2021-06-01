Return-Path: <SRS0=ZGfu=K3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86124C47092
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 06:23:41 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 361E061375
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 06:23:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 361E061375
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EB26B83CBA;
	Tue,  1 Jun 2021 06:23:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id U-4EQQge5ExL; Tue,  1 Jun 2021 06:23:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 72E3D83CB8;
	Tue,  1 Jun 2021 06:23:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 13166C000D;
	Tue,  1 Jun 2021 06:23:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F2A9C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 06:23:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4E86640454
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 06:23:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bq7PsIEvOzLL
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 06:23:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-56.freemail.mail.aliyun.com
 (out30-56.freemail.mail.aliyun.com [115.124.30.56])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6598640453
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 06:23:35 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R671e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04400; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=11; SR=0; TI=SMTPD_---0UardGIu_1622528611; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0UardGIu_1622528611) by smtp.aliyun-inc.com(127.0.0.1);
 Tue, 01 Jun 2021 14:23:32 +0800
MIME-Version: 1.0
Message-Id: <1622528482.6132154-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net 2/2] virtio-net: get build_skb() buf by data ptr
Date: Tue, 01 Jun 2021 14:21:22 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
In-Reply-To: <24aee726-83a9-9741-23bb-1f8be0e775e6@redhat.com>
X-Mailing-List: bpf@vger.kernel.org
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gVHVlLCAxIEp1biAyMDIxIDE0OjE3OjI3ICswODAwLCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPgo+IOWcqCAyMDIxLzYvMSDkuIvljYgxOjU5LCBYdWFuIFpodW8g
5YaZ6YGTOgo+ID4gT24gVHVlLCAxIEp1biAyMDIxIDExOjI3OjEyICswODAwLCBKYXNvbiBXYW5n
IDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+PiDlnKggMjAyMS82LzEg5LiK5Y2IMTE6
MDgsIFh1YW4gWmh1byDlhpnpgZM6Cj4gPj4+IE9uIFR1ZSwgMSBKdW4gMjAyMSAxMTowMzozNyAr
MDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPj4+PiDlnKgg
MjAyMS81LzMxIOS4i+WNiDY6NTgsIFh1YW4gWmh1byDlhpnpgZM6Cj4gPj4+Pj4gT24gTW9uLCAz
MSBNYXkgMjAyMSAxNDoxMDo1NSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4gPj4+Pj4+IOWcqCAyMDIxLzUvMTQg5LiL5Y2IMTE6MTYsIFh1YW4gWmh1byDl
hpnpgZM6Cj4gPj4+Pj4+PiBJbiB0aGUgY2FzZSBvZiBtZXJnZSwgdGhlIHBhZ2UgcGFzc2VkIGlu
dG8gcGFnZV90b19za2IoKSBtYXkgYmUgYSBoZWFkCj4gPj4+Pj4+PiBwYWdlLCBub3QgdGhlIHBh
Z2Ugd2hlcmUgdGhlIGN1cnJlbnQgZGF0YSBpcyBsb2NhdGVkLgo+ID4+Pj4+PiBJIGRvbid0IGdl
dCBob3cgdGhpcyBjYW4gaGFwcGVuPwo+ID4+Pj4+Pgo+ID4+Pj4+PiBNYXliZSB5b3UgY2FuIGV4
cGxhaW4gYSBsaXR0bGUgYml0IG1vcmU/Cj4gPj4+Pj4+Cj4gPj4+Pj4+IHJlY2VpdmVfbWVyZ2Vh
YmxlKCkgY2FsbCBwYWdlX3RvX3NrYigpIGluIHR3byBwbGFjZXM6Cj4gPj4+Pj4+Cj4gPj4+Pj4+
IDEpIFhEUF9QQVNTIGZvciBsaW5lYXJpemVkIHBhZ2UgLCBpbiB0aGlzIGNhc2Ugd2UgdXNlIHhk
cF9wYWdlCj4gPj4+Pj4+IDIpIHBhZ2VfdG9fc2tiKCkgZm9yICJub3JtYWwiIHBhZ2UsIGluIHRo
aXMgY2FzZSB0aGUgcGFnZSBjb250YWlucyB0aGUgZGF0YQo+ID4+Pj4+IFRoZSBvZmZzZXQgbWF5
IGJlIGdyZWF0ZXIgdGhhbiBQQUdFX1NJWkUsIGJlY2F1c2UgcGFnZSBpcyBvYnRhaW5lZCBieQo+
ID4+Pj4+IHZpcnRfdG9faGVhZF9wYWdlKCksIG5vdCB0aGUgcGFnZSB3aGVyZSBidWYgaXMgbG9j
YXRlZC4gQW5kICJvZmZzZXQiIGlzIHRoZSBvZmZzZXQKPiA+Pj4+PiBvZiBidWYgcmVsYXRpdmUg
dG8gcGFnZS4KPiA+Pj4+Pgo+ID4+Pj4+IAl0YWlscm9vbSA9IHRydWVzaXplIC0gbGVuIC0gb2Zm
c2V0Owo+ID4+Pj4+Cj4gPj4+Pj4gSW4gdGhpcyBjYXNlLCB0aGUgdGFpbHJvb20gbXVzdCBiZSBs
ZXNzIHRoYW4gMC4gQWx0aG91Z2ggdGhlcmUgbWF5IGJlIGVub3VnaAo+ID4+Pj4+IGNvbnRlbnQg
b24gdGhpcyBwYWdlIHRvIHNhdmUgc2tiX3NoYXJlZF9pbmZvLgo+ID4+Pj4gSW50ZXJlc3Rpbmcs
IEkgdGhpbmsgd2UgZG9uJ3QgdXNlIGNvbXBvdW5kIHBhZ2VzIGZvciB2aXJ0aW8tbmV0LiAoV2UK
PiA+Pj4+IGRvbid0IGRlZmluZSBTS0JfRlJBR19QQUdFX09SREVSKS4KPiA+Pj4+Cj4gPj4+PiBB
bSBJIHdyb25nPwo+ID4+PiBJdCBzZWVtcyB0byBtZSB0aGF0IGl0IHNlZW1zIHRvIGJlIGEgZml4
ZWQgc2V0dGluZywgbm90IGZvciB1cyB0byBjb25maWd1cmUKPiA+Pj4gaW5kZXBlbmRlbnRseQo+
ID4+Cj4gPj4gTG9va3MgbGlrZSB5b3UgYXJlIHJpZ2h0Lgo+ID4+Cj4gPj4gU2VlIGNvbW1lbnRz
IGJlbG93Lgo+ID4+Cj4gPj4KPiA+Pj4gVGhhbmtzLgo+ID4+Pgo+ID4+PiA9PT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT0KPiA+Pj4KPiA+Pj4gbmV0L3NvY2suYwo+ID4+
Pgo+ID4+PiAjZGVmaW5lIFNLQl9GUkFHX1BBR0VfT1JERVIJZ2V0X29yZGVyKDMyNzY4KQo+ID4+
PiBERUZJTkVfU1RBVElDX0tFWV9GQUxTRShuZXRfaGlnaF9vcmRlcl9hbGxvY19kaXNhYmxlX2tl
eSk7Cj4gPj4+Cj4gPj4+IC8qKgo+ID4+PiAgICAqIHNrYl9wYWdlX2ZyYWdfcmVmaWxsIC0gY2hl
Y2sgdGhhdCBhIHBhZ2VfZnJhZyBjb250YWlucyBlbm91Z2ggcm9vbQo+ID4+PiAgICAqIEBzejog
bWluaW11bSBzaXplIG9mIHRoZSBmcmFnbWVudCB3ZSB3YW50IHRvIGdldAo+ID4+PiAgICAqIEBw
ZnJhZzogcG9pbnRlciB0byBwYWdlX2ZyYWcKPiA+Pj4gICAgKiBAZ2ZwOiBwcmlvcml0eSBmb3Ig
bWVtb3J5IGFsbG9jYXRpb24KPiA+Pj4gICAgKgo+ID4+PiAgICAqIE5vdGU6IFdoaWxlIHRoaXMg
YWxsb2NhdG9yIHRyaWVzIHRvIHVzZSBoaWdoIG9yZGVyIHBhZ2VzLCB0aGVyZSBpcwo+ID4+PiAg
ICAqIG5vIGd1YXJhbnRlZSB0aGF0IGFsbG9jYXRpb25zIHN1Y2NlZWQuIFRoZXJlZm9yZSwgQHN6
IE1VU1QgYmUKPiA+Pj4gICAgKiBsZXNzIG9yIGVxdWFsIHRoYW4gUEFHRV9TSVpFLgo+ID4+PiAg
ICAqLwo+ID4+PiBib29sIHNrYl9wYWdlX2ZyYWdfcmVmaWxsKHVuc2lnbmVkIGludCBzeiwgc3Ry
dWN0IHBhZ2VfZnJhZyAqcGZyYWcsIGdmcF90IGdmcCkKPiA+Pj4gewo+ID4+PiAJaWYgKHBmcmFn
LT5wYWdlKSB7Cj4gPj4+IAkJaWYgKHBhZ2VfcmVmX2NvdW50KHBmcmFnLT5wYWdlKSA9PSAxKSB7
Cj4gPj4+IAkJCXBmcmFnLT5vZmZzZXQgPSAwOwo+ID4+PiAJCQlyZXR1cm4gdHJ1ZTsKPiA+Pj4g
CQl9Cj4gPj4+IAkJaWYgKHBmcmFnLT5vZmZzZXQgKyBzeiA8PSBwZnJhZy0+c2l6ZSkKPiA+Pj4g
CQkJcmV0dXJuIHRydWU7Cj4gPj4+IAkJcHV0X3BhZ2UocGZyYWctPnBhZ2UpOwo+ID4+PiAJfQo+
ID4+Pgo+ID4+PiAJcGZyYWctPm9mZnNldCA9IDA7Cj4gPj4+IAlpZiAoU0tCX0ZSQUdfUEFHRV9P
UkRFUiAmJgo+ID4+PiAJICAgICFzdGF0aWNfYnJhbmNoX3VubGlrZWx5KCZuZXRfaGlnaF9vcmRl
cl9hbGxvY19kaXNhYmxlX2tleSkpIHsKPiA+Pj4gCQkvKiBBdm9pZCBkaXJlY3QgcmVjbGFpbSBi
dXQgYWxsb3cga3N3YXBkIHRvIHdha2UgKi8KPiA+Pj4gCQlwZnJhZy0+cGFnZSA9IGFsbG9jX3Bh
Z2VzKChnZnAgJiB+X19HRlBfRElSRUNUX1JFQ0xBSU0pIHwKPiA+Pj4gCQkJCQkgIF9fR0ZQX0NP
TVAgfCBfX0dGUF9OT1dBUk4gfAo+ID4+PiAJCQkJCSAgX19HRlBfTk9SRVRSWSwKPiA+Pj4gCQkJ
CQkgIFNLQl9GUkFHX1BBR0VfT1JERVIpOwo+ID4+PiAJCWlmIChsaWtlbHkocGZyYWctPnBhZ2Up
KSB7Cj4gPj4+IAkJCXBmcmFnLT5zaXplID0gUEFHRV9TSVpFIDw8IFNLQl9GUkFHX1BBR0VfT1JE
RVI7Cj4gPj4+IAkJCXJldHVybiB0cnVlOwo+ID4+PiAJCX0KPiA+Pj4gCX0KPiA+Pj4gCXBmcmFn
LT5wYWdlID0gYWxsb2NfcGFnZShnZnApOwo+ID4+PiAJaWYgKGxpa2VseShwZnJhZy0+cGFnZSkp
IHsKPiA+Pj4gCQlwZnJhZy0+c2l6ZSA9IFBBR0VfU0laRTsKPiA+Pj4gCQlyZXR1cm4gdHJ1ZTsK
PiA+Pj4gCX0KPiA+Pj4gCXJldHVybiBmYWxzZTsKPiA+Pj4gfQo+ID4+PiBFWFBPUlRfU1lNQk9M
KHNrYl9wYWdlX2ZyYWdfcmVmaWxsKTsKPiA+Pj4KPiA+Pj4KPiA+Pj4+IFRoYW5rcwo+ID4+Pj4K
PiA+Pj4+Cj4gPj4+Pj4gVGhhbmtzLgo+ID4+Pj4+Cj4gPj4+Pj4+IFRoYW5rcwo+ID4+Pj4+Pgo+
ID4+Pj4+Pgo+ID4+Pj4+Pj4gU28gd2hlbiB0cnlpbmcgdG8KPiA+Pj4+Pj4+IGdldCB0aGUgYnVm
IHdoZXJlIHRoZSBkYXRhIGlzIGxvY2F0ZWQsIHlvdSBzaG91bGQgZGlyZWN0bHkgdXNlIHRoZQo+
ID4+Pj4+Pj4gcG9pbnRlcihwKSB0byBnZXQgdGhlIGFkZHJlc3MgY29ycmVzcG9uZGluZyB0byB0
aGUgcGFnZS4KPiA+Pj4+Pj4+Cj4gPj4+Pj4+PiBBdCB0aGUgc2FtZSB0aW1lLCB0aGUgb2Zmc2V0
IG9mIHRoZSBkYXRhIGluIHRoZSBwYWdlIHNob3VsZCBhbHNvIGJlCj4gPj4+Pj4+PiBvYnRhaW5l
ZCB1c2luZyBvZmZzZXRfaW5fcGFnZSgpLgo+ID4+Pj4+Pj4KPiA+Pj4+Pj4+IFRoaXMgcGF0Y2gg
c29sdmVzIHRoaXMgcHJvYmxlbS4gQnV0IGlmIHlvdSBkb27igJl0IHVzZSB0aGlzIHBhdGNoLCB0
aGUKPiA+Pj4+Pj4+IG9yaWdpbmFsIGNvZGUgY2FuIGFsc28gcnVuLCBiZWNhdXNlIGlmIHRoZSBw
YWdlIGlzIG5vdCB0aGUgcGFnZSBvZiB0aGUKPiA+Pj4+Pj4+IGN1cnJlbnQgZGF0YSwgdGhlIGNh
bGN1bGF0ZWQgdGFpbHJvb20gd2lsbCBiZSBsZXNzIHRoYW4gMCwgYW5kIHdpbGwgbm90Cj4gPj4+
Pj4+PiBlbnRlciB0aGUgbG9naWMgb2YgYnVpbGRfc2tiKCkgLiBUaGUgc2lnbmlmaWNhbmNlIG9m
IHRoaXMgcGF0Y2ggaXMgdG8KPiA+Pj4+Pj4+IG1vZGlmeSB0aGlzIGxvZ2ljYWwgcHJvYmxlbSwg
YWxsb3dpbmcgbW9yZSBzaXR1YXRpb25zIHRvIHVzZQo+ID4+Pj4+Pj4gYnVpbGRfc2tiKCkuCj4g
Pj4+Pj4+Pgo+ID4+Pj4+Pj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51
eC5hbGliYWJhLmNvbT4KPiA+Pj4+Pj4+IEFja2VkLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1z
dEByZWRoYXQuY29tPgo+ID4+Pj4+Pj4gLS0tCj4gPj4+Pj4+PiAgICAgIGRyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYyB8IDggKysrKysrLS0KPiA+Pj4+Pj4+ICAgICAgMSBmaWxlIGNoYW5nZWQsIDYg
aW5zZXJ0aW9ucygrKSwgMiBkZWxldGlvbnMoLSkKPiA+Pj4+Pj4+Cj4gPj4+Pj4+PiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5j
Cj4gPj4+Pj4+PiBpbmRleCAzZTQ2YzEyZGRlMDguLjA3M2ZlYzRjMGRmMSAxMDA2NDQKPiA+Pj4+
Pj4+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4+Pj4+Pj4gKysrIGIvZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jCj4gPj4+Pj4+PiBAQCAtNDA3LDggKzQwNywxMiBAQCBzdGF0aWMg
c3RydWN0IHNrX2J1ZmYgKnBhZ2VfdG9fc2tiKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+ID4+
Pj4+Pj4gICAgICAJCSAqIHNlZSBhZGRfcmVjdmJ1Zl9tZXJnZWFibGUoKSArIGdldF9tZXJnZWFi
bGVfYnVmX2xlbigpCj4gPj4+Pj4+PiAgICAgIAkJICovCj4gPj4+Pj4+PiAgICAgIAkJdHJ1ZXNp
emUgPSBQQUdFX1NJWkU7Cj4gPj4+Pj4+PiAtCQl0YWlscm9vbSA9IHRydWVzaXplIC0gbGVuIC0g
b2Zmc2V0Owo+ID4+Pj4+Pj4gLQkJYnVmID0gcGFnZV9hZGRyZXNzKHBhZ2UpOwo+ID4+Pj4+Pj4g
Kwo+ID4+Pj4+Pj4gKwkJLyogcGFnZSBtYXliZSBoZWFkIHBhZ2UsIHNvIHdlIHNob3VsZCBnZXQg
dGhlIGJ1ZiBieSBwLCBub3QgdGhlCj4gPj4+Pj4+PiArCQkgKiBwYWdlCj4gPj4+Pj4+PiArCQkg
Ki8KPiA+Pj4+Pj4+ICsJCXRhaWxyb29tID0gdHJ1ZXNpemUgLSBsZW4gLSBvZmZzZXRfaW5fcGFn
ZShwKTsKPiA+Pgo+ID4+IEkgd29uZGVyIHdoeSBvZmZzZXRfaW5fcGFnZShwKSBpcyBjb3JyZWN0
PyBJIGd1ZXNzIGl0IHNob3VsZCBiZToKPiA+Pgo+ID4+IHRhaWxyb29tID0gdHJ1ZXNpemUgLSBs
ZW4gLSBoZWFkcm9vbTsKPiA+Pgo+ID4+IFRoZSByZWFzb24gaXMgdGhhdCB0aGUgYnVmZmVyIGlz
IG5vdCBuZWNlc3NhcmlseSBhbGxvY2F0ZWQgYXQgdGhlIHBhZ2UKPiA+PiBib3VuZGFyeS4KPiA+
IEluIG15IHVuZGVyc3RhbmRpbmcsIG9mZnNldF9pbl9wYWdlKHApIGlzIHRoZSBvZmZzZXQgb2Yg
cCBpbiB0aGUgcGFnZSB3aGVyZSBpdAo+ID4gaXMgbG9jYXRlZC4gSW4gdGhpcyBjYXNlLCB0aGUg
dHdvIHNob3VsZCBiZSBlcXVhbC4KPgo+Cj4gSSB0aGluayBub3QsIGlmIHRoZSBmcmFnIGlzIG5v
dCBwYWdlIGFsaWduZWQuIG9mZnNldF9pbl9wYWdlKHApIGRvZXNuJ3QKPiBlcXVhbCB0byBoZWFk
cm9vbS4KPgo+IENvbnNpZGVyIHRoZSBjYXNlIHRoYXQgdGhlIGZyYWcgc3RhcnQgZnJvbSBwYWdl
IG9mZnNldCAxNTAwLgoKWWVzLCB5b3UgYXJlIHJpZ2h0LiBJIGFsc28gZmVsdCBhIGxpdHRsZSB3
ZWlyZCBqdXN0IG5vdywgc28gSSB0b29rIGEgY2xvc2VyIGxvb2sKYXQgYWRkX3JlY3ZidWZfbWVy
Z2VhYmxlKCkuCgpUaGFuayB5b3UsIHZlcnkgbXVjaC4KCj4KPgo+ID4gICBUaGlzIGhhcyBub3Ro
aW5nIHRvIGRvIHdpdGgKPiA+IHdoaWNoIHBhZ2UgaXMgYWxsb2NhdGVkLgo+ID4KPiA+IE9mIGNv
dXJzZSBJIHRoaW5rIHVzaW5nIGhlYWRyb29tIGlzIGEgZ29vZCBpZGVhLCBhbmQgaXQgaXMgc2Vt
YW50aWNhbGx5IGJldHRlci4KPiA+Cj4gPiBUaGFua3MuCj4KPgo+IFRoYW5rcwo+Cj4KPiA+Cj4g
Pj4gVGhhbmtzCj4gPj4KPiA+Pgo+ID4+Pj4+Pj4gKwkJYnVmID0gKGNoYXIgKikoKHVuc2lnbmVk
IGxvbmcpcCAmIFBBR0VfTUFTSyk7Cj4gPj4+Pj4+PiAgICAgIAl9IGVsc2Ugewo+ID4+Pj4+Pj4g
ICAgICAJCXRhaWxyb29tID0gdHJ1ZXNpemUgLSBsZW47Cj4gPj4+Pj4+PiAgICAgIAkJYnVmID0g
cDsKPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
