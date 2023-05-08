Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5775CC77B75
	for <virtualization@archiver.kernel.org>; Mon,  8 May 2023 07:45:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BE4A7417DC;
	Mon,  8 May 2023 07:45:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BE4A7417DC
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id oNpPw_odqmrn; Mon,  8 May 2023 07:45:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id BEDD7417B2;
	Mon,  8 May 2023 07:45:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BEDD7417B2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8D350C0036;
	Mon,  8 May 2023 07:45:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 39169C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 07:45:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1443D40530
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 07:45:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1443D40530
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0DfxstZx-mm3
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 07:45:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8C54240232
Received: from out30-101.freemail.mail.aliyun.com
 (out30-101.freemail.mail.aliyun.com [115.124.30.101])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8C54240232
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 May 2023 07:45:13 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R161e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=ay29a033018045176;
 MF=xuanzhuo@linux.alibaba.com; NM=1; PH=DS; RN=13; SR=0;
 TI=SMTPD_---0Vi0xjwt_1683531906; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Vi0xjwt_1683531906) by smtp.aliyun-inc.com;
 Mon, 08 May 2023 15:45:07 +0800
Message-ID: <1683531716.238961-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH] virtio_net: set default mtu to 1500 when 'Device maximum
 MTU' bigger than 1500
Date: Mon, 8 May 2023 15:41:56 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20230506021529.396812-1-chenh@yusur.tech>
 <1683341417.0965195-4-xuanzhuo@linux.alibaba.com>
 <07b6b325-9a15-222f-e618-d149b57cbac2@yusur.tech>
 <20230507045627-mutt-send-email-mst@kernel.org>
 <1683511319.099806-2-xuanzhuo@linux.alibaba.com>
 <20230508020953-mutt-send-email-mst@kernel.org>
 <1683526688.7492425-1-xuanzhuo@linux.alibaba.com>
 <20230508024147-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230508024147-mutt-send-email-mst@kernel.org>
Cc: zy@yusur.tech, Hao Chen <chenh@yusur.tech>,
 "open list:NETWORKING DRIVERS" <netdev@vger.kernel.org>,
 open list <linux-kernel@vger.kernel.org>,
 "open list:VIRTIO CORE AND NET DRIVERS"
 <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, hengqi@linux.alibaba.com,
 huangml@yusur.tech, Jakub Kicinski <kuba@kernel.org>,
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

T24gTW9uLCA4IE1heSAyMDIzIDAyOjQzOjI0IC0wNDAwLCAiTWljaGFlbCBTLiBUc2lya2luIiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+IE9uIE1vbiwgTWF5IDA4LCAyMDIzIGF0IDAyOjE4OjA4
UE0gKzA4MDAsIFh1YW4gWmh1byB3cm90ZToKPiA+IE9uIE1vbiwgOCBNYXkgMjAyMyAwMjoxNTo0
NiAtMDQwMCwgIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+
ID4gT24gTW9uLCBNYXkgMDgsIDIwMjMgYXQgMTA6MDE6NTlBTSArMDgwMCwgWHVhbiBaaHVvIHdy
b3RlOgo+ID4gPiA+IE9uIFN1biwgNyBNYXkgMjAyMyAwNDo1ODo1OCAtMDQwMCwgIk1pY2hhZWwg
Uy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+IE9uIFNhdCwgTWF5
IDA2LCAyMDIzIGF0IDA0OjU2OjM1UE0gKzA4MDAsIEhhbyBDaGVuIHdyb3RlOgo+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiDlnKggMjAyMy81LzYgMTA6NTAsIFh1YW4gWmh1byDl
hpnpgZM6Cj4gPiA+ID4gPiA+ID4gT24gU2F0LCAgNiBNYXkgMjAyMyAxMDoxNToyOSArMDgwMCwg
SGFvIENoZW4gPGNoZW5oQHl1c3VyLnRlY2g+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gV2hlbiBW
SVJUSU9fTkVUX0ZfTVRVKDMpIERldmljZSBtYXhpbXVtIE1UVSByZXBvcnRpbmcgaXMgc3VwcG9y
dGVkLgo+ID4gPiA+ID4gPiA+ID4gSWYgb2ZmZXJlZCBieSB0aGUgZGV2aWNlLCBkZXZpY2UgYWR2
aXNlcyBkcml2ZXIgYWJvdXQgdGhlIHZhbHVlIG9mIGl0cwo+ID4gPiA+ID4gPiA+ID4gbWF4aW11
bSBNVFUuIElmIG5lZ290aWF0ZWQsIHRoZSBkcml2ZXIgdXNlcyBtdHUgYXMgdGhlIG1heGltdW0K
PiA+ID4gPiA+ID4gPiA+IE1UVSB2YWx1ZS4gQnV0IHRoZXJlIHRoZSBkcml2ZXIgYWxzbyB1c2Vz
IGl0IGFzIGRlZmF1bHQgbXR1LAo+ID4gPiA+ID4gPiA+ID4gc29tZSBkZXZpY2VzIG1heSBoYXZl
IGEgbWF4aW11bSBNVFUgZ3JlYXRlciB0aGFuIDE1MDAsIHRoaXMgbWF5Cj4gPiA+ID4gPiA+ID4g
PiBjYXVzZSBzb21lIGxhcmdlIHBhY2thZ2VzIHRvIGJlIGRpc2NhcmRlZCwKPiA+ID4gPiA+ID4g
Pgo+ID4gPiA+ID4gPiA+IFlvdSBtZWFuIHR4IHBhY2tldD8KPiA+ID4gPiA+ID4gWWVzLgo+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gSWYgeWVzLCBJIGRvIG5vdCB0aGluayB0aGlzIGlzIHRo
ZSBwcm9ibGVtIG9mIGRyaXZlci4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IE1heWJlIHlv
dSBzaG91bGQgZ2l2ZSBtb3JlIGRldGFpbHMgYWJvdXQgdGhlIGRpc2NhcmQuCj4gPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gSW4gdGhlIGN1cnJlbnQgY29kZSwgaWYgdGhlIG1heGltdW0gTVRVIHN1
cHBvcnRlZCBieSB0aGUgdmlydGlvIG5ldCBoYXJkd2FyZQo+ID4gPiA+ID4gPiBpcyA5MDAwLCB0
aGUgZGVmYXVsdCBNVFUgb2YgdGhlIHZpcnRpbyBuZXQgZHJpdmVyIHdpbGwgYWxzbyBiZSBzZXQg
dG8gOTAwMC4KPiA+ID4gPiA+ID4gV2hlbiBzZW5kaW5nIHBhY2tldHMgdGhyb3VnaCAicGluZyAt
cyA1MDAwIiwgaWYgdGhlIHBlZXIgcm91dGVyIGRvZXMgbm90Cj4gPiA+ID4gPiA+IHN1cHBvcnQg
bmVnb3RpYXRpbmcgYSBwYXRoIE1UVSB0aHJvdWdoIElDTVAgcGFja2V0cywgdGhlIHBhY2tldHMg
d2lsbCBiZQo+ID4gPiA+ID4gPiBkaXNjYXJkZWQuIElmIHRoZSBwZWVyIHJvdXRlciBzdXBwb3J0
cyBuZWdvdGlhdGluZyBwYXRoIG10dSB0aHJvdWdoIElDTVAKPiA+ID4gPiA+ID4gcGFja2V0cywg
dGhlIGhvc3Qgc2lkZSB3aWxsIHBlcmZvcm0gcGFja2V0IHNoYXJkaW5nIHByb2Nlc3NpbmcgYmFz
ZWQgb24gdGhlCj4gPiA+ID4gPiA+IG5lZ290aWF0ZWQgcGF0aCBtdHUsIHdoaWNoIGlzIGdlbmVy
YWxseSB3aXRoaW4gMTUwMC4KPiA+ID4gPiA+ID4gVGhpcyBpcyBub3QgYSBidWdmaXggcGF0Y2gs
IEkgdGhpbmsgc2V0dGluZyB0aGUgZGVmYXVsdCBtdHUgdG8gd2l0aGluIDE1MDAKPiA+ID4gPiA+
ID4gd291bGQgYmUgbW9yZSBzdWl0YWJsZSBoZXJlLlRoYW5rcy4KPiA+ID4gPiA+Cj4gPiA+ID4g
PiBJIGRvbid0IHRoaW5rIFZJUlRJT19ORVRfRl9NVFUgaXMgYXBwcm9wcmlhdGUgZm9yIHN1cHBv
cnQgZm9yIGp1bWJvIHBhY2tldHMuCj4gPiA+ID4gPiBUaGUgc3BlYyBzYXlzOgo+ID4gPiA+ID4g
CVRoZSBkZXZpY2UgTVVTVCBmb3J3YXJkIHRyYW5zbWl0dGVkIHBhY2tldHMgb2YgdXAgdG8gbXR1
IChwbHVzIGxvdyBsZXZlbCBldGhlcm5ldCBoZWFkZXIgbGVuZ3RoKSBzaXplIHdpdGgKPiA+ID4g
PiA+IAlnc29fdHlwZSBOT05FIG9yIEVDTiwgYW5kIGRvIHNvIHdpdGhvdXQgZnJhZ21lbnRhdGlv
biwgYWZ0ZXIgVklSVElPX05FVF9GX01UVSBoYXMgYmVlbiBzdWNjZXNzLQo+ID4gPiA+ID4gCWZ1
bGx5IG5lZ290aWF0ZWQuCj4gPiA+ID4gPiBWSVJUSU9fTkVUX0ZfTVRVIGhhcyBiZWVuIGRlc2ln
bmVkIGZvciBhbGwga2luZCBvZiB0dW5uZWxpbmcgZGV2aWNlcywKPiA+ID4gPiA+IGFuZCB0aGlz
IGlzIHdoeSB3ZSBzZXQgbXR1IHRvIG1heCBieSBkZWZhdWx0Lgo+ID4gPiA+ID4KPiA+ID4gPiA+
IEZvciB0aGluZ3MgbGlrZSBqdW1ibyBmcmFtZXMgd2hlcmUgTVRVIG1pZ2h0IG9yIG1pZ2h0IG5v
dCBiZSBhdmFpbGFibGUsCj4gPiA+ID4gPiBhIG5ldyBmZWF0dXJlIHdvdWxkIGJlIG1vcmUgYXBw
cm9wcmlhdGUuCj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+IFNvIGZvciBqdW1ibyBmcmFtZSwgd2hh
dCBpcyB0aGUgcHJvYmxlbT8KPiA+ID4gPgo+ID4gPiA+IFdlIGFyZSB0cnlpbmcgdG8gZG8gdGhp
cy4gQEhlbmcKPiA+ID4gPgo+ID4gPiA+IFRoYW5rcy4KPiA+ID4KPiA+ID4gSXQgaXMgbm90IGEg
cHJvYmxlbSBhcyBzdWNoLiBCdXQgVklSVElPX05FVF9GX01UVSB3aWxsIHNldCB0aGUKPiA+ID4g
ZGVmYXVsdCBNVFUgbm90IGp1c3QgdGhlIG1heGltdW0gb25lLCBiZWNhdXNlIHNwZWMgc2VlbXMg
dG8KPiA+ID4gc2F5IGl0IGNhbi4KPiA+Cj4gPiBJIHNlZS4KPiA+Cj4gPiBJbiB0aGUgY2FzZSBv
ZiBKdW1ibyBGcmFtZSwgd2UgYWxzbyBob3BlIHRoYXQgdGhlIGRyaXZlciB3aWxsIHNldCB0aGUg
ZGVmYXVsdAo+ID4gZGlyZWN0bHkgdG8gdGhlIG1heCBtdHUuIEp1c3QgbGlrZSB3aGF0IHlvdSBz
YWlkICJCaWdnZXIgcGFja2V0cyA9IGJldHRlcgo+ID4gcGVyZm9ybWFuY2UuIgo+ID4KPiA+IEkg
ZG9uJ3Qga25vdywgaW4gYW55IHNjZW5hcmlvLCB3aGVuIHRoZSBoYXJkd2FyZSBzdXBwb3J0cyBh
IGxhcmdlIG10dSwgYnV0IHdlIGRvCj4gPiBub3Qgd2FudCB0aGUgdXNlciB0byB1c2UgaXQgYnkg
ZGVmYXVsdC4KPgo+IFdoZW4gb3RoZXIgZGV2aWNlcyBvbiB0aGUgc2FtZSBMQU4gaGF2ZSBtdHUg
c2V0IHRvIDE1MDAgYW5kCj4gd29uJ3QgYWNjZXB0IGJpZ2dlciBwYWNrZXRzLgoKU28sIHRoYXQg
ZGVwZW5kcyBvbiBwbXR1L3RjcC1wcm9iZS1tdHUuCgpJZiB0aGUgb3Mgd2l0aG91dCBwbXR1L3Rj
cC1wcm9iZS1tdHUgaGFzIGEgYmlnZ2VyIG10dSwgdGhlbiBpdCdzIGJpZyBwYWNrZXQKd2lsbCBs
b3N0LgoKVGhhbmtzLgoKCj4KPiA+IE9mIGNvdXJzZSwgdGhlIHNjZW5lIHRoYXQgdGhpcyBwYXRj
aAo+ID4gd2FudHMgdG8gaGFuZGxlIGRvZXMgZXhpc3QsIGJ1dCBJIGhhdmUgbmV2ZXIgdGhvdWdo
dCB0aGF0IHRoaXMgaXMgYSBwcm9ibGVtIGF0Cj4gPiB0aGUgZHJpdmVyIGxldmVsLgo+ID4KPiA+
IFRoYW5rcy4KPiA+Cj4gPgo+ID4gPgo+ID4gPgo+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4gc28gSSBjaGFuZ2VkIHRoZSBNVFUgdG8gYSBtb3JlCj4gPiA+ID4gPiA+ID4gPiBnZW5l
cmFsIDE1MDAgd2hlbiAnRGV2aWNlIG1heGltdW0gTVRVJyBiaWdnZXIgdGhhbiAxNTAwLgo+ID4g
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEhhbyBDaGVuIDxjaGVu
aEB5dXN1ci50ZWNoPgo+ID4gPiA+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiA+ID4gPiAgIGRyaXZl
cnMvbmV0L3ZpcnRpb19uZXQuYyB8IDUgKysrKy0KPiA+ID4gPiA+ID4gPiA+ICAgMSBmaWxlIGNo
YW5nZWQsIDQgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+ID4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiA+ID4gPiA+IGluZGV4IDhkODAzODUzOGZjNC4u
ZTcxYzdkMWI1ZjI5IDEwMDY0NAo+ID4gPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9uZXQvdmly
dGlvX25ldC5jCj4gPiA+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMK
PiA+ID4gPiA+ID4gPiA+IEBAIC00MDQwLDcgKzQwNDAsMTAgQEAgc3RhdGljIGludCB2aXJ0bmV0
X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gPiA+ID4gPiA+ID4gICAJCQln
b3RvIGZyZWU7Cj4gPiA+ID4gPiA+ID4gPiAgIAkJfQo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiA+IC0JCWRldi0+bXR1ID0gbXR1Owo+ID4gPiA+ID4gPiA+ID4gKwkJaWYgKG10dSA+IDE1
MDApCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBzLzE1MDAvRVRIX0RBVEFfTEVOLwo+ID4g
PiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gVGhhbmtzLgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gPiArCQkJZGV2LT5tdHUgPSAxNTAwOwo+ID4gPiA+ID4gPiA+ID4gKwkJZWxzZQo+ID4gPiA+
ID4gPiA+ID4gKwkJCWRldi0+bXR1ID0gbXR1Owo+ID4gPiA+ID4gPiA+ID4gICAJCWRldi0+bWF4
X210dSA9IG10dTsKPiA+ID4gPiA+ID4gPiA+ICAgCX0KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4g
PiA+ID4gPiAtLQo+ID4gPiA+ID4gPiA+ID4gMi4yNy4wCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+
ID4KPiA+ID4KPgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
