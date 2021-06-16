Return-Path: <SRS0=d+i8=LK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B07E7C48BE6
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 13:06:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1507661356
	for <virtualization@archiver.kernel.org>; Wed, 16 Jun 2021 13:06:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1507661356
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C66A1401FC;
	Wed, 16 Jun 2021 13:06:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qCzMtfCf_Gd9; Wed, 16 Jun 2021 13:06:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 73A1D40107;
	Wed, 16 Jun 2021 13:06:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3F6CEC000D;
	Wed, 16 Jun 2021 13:06:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C70D3C000B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 13:06:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BAF54834CB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 13:06:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IBf7SFU11iiD
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 13:06:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from out30-44.freemail.mail.aliyun.com
 (out30-44.freemail.mail.aliyun.com [115.124.30.44])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C16C7834D5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 16 Jun 2021 13:06:47 +0000 (UTC)
X-Alimail-AntiSpam: AC=PASS; BC=-1|-1; BR=01201311R101e4; CH=green; DM=||false|;
 DS=||; FP=0|-1|-1|-1|0|-1|-1|-1; HT=e01e04426; MF=xuanzhuo@linux.alibaba.com;
 NM=1; PH=DS; RN=20; SR=0; TI=SMTPD_---0Ucce9HI_1623848803; 
Received: from localhost(mailfrom:xuanzhuo@linux.alibaba.com
 fp:SMTPD_---0Ucce9HI_1623848803) by smtp.aliyun-inc.com(127.0.0.1);
 Wed, 16 Jun 2021 21:06:44 +0800
MIME-Version: 1.0
Message-Id: <1623848265.175296-1-xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH net-next v5 12/15] virtio-net: support AF_XDP zc tx
Date: Wed, 16 Jun 2021 20:57:45 +0800
From: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
To: Jason Wang <jasowang@redhat.com>
In-Reply-To: <f81775f8-7df9-5ca0-0bd2-99c86786fe78@redhat.com>
X-Mailing-List: bpf@vger.kernel.org
Cc: Song Liu <songliubraving@fb.com>, Martin KaFai Lau <kafai@fb.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 Yonghong Song <yhs@fb.com>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, Andrii Nakryiko <andrii@kernel.org>,
 netdev@vger.kernel.org, =?utf-8?b?QmrDtnJuIFTDtnBlbA==?= <bjorn@kernel.org>,
 "dust.li" <dust.li@linux.alibaba.com>,
 Jonathan Lemon <jonathan.lemon@gmail.com>, KP Singh <kpsingh@kernel.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 "David S. Miller" <davem@davemloft.net>,
 Magnus Karlsson <magnus.karlsson@intel.com>
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

T24gV2VkLCAxNiBKdW4gMjAyMSAyMDo1MTo0MSArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiDlnKggMjAyMS82LzE2IOS4i+WNiDY6MTksIFh1YW4gWmh1
byDlhpnpgZM6Cj4gPj4+ICsgKiBJbiB0aGlzIHdheSwgZXZlbiBpZiB4c2sgaGFzIGJlZW4gdW5i
dW5kbGVkIHdpdGggcnEvc3EsIG9yIGEgbmV3IHhzayBhbmQKPiA+Pj4gKyAqIHJxL3NxICBhcmUg
Ym91bmQsIGFuZCBhIG5ldyB2aXJ0bmV0X3hza19jdHhfaGVhZCBpcyBjcmVhdGVkLiBJdCB3aWxs
IG5vdAo+ID4+PiArICogYWZmZWN0IHRoZSBvbGQgdmlydG5ldF94c2tfY3R4IHRvIGJlIHJlY3lj
bGVkLiBBbmQgZnJlZSBhbGwgaGVhZCBhbmQgY3R4IHdoZW4KPiA+Pj4gKyAqIHJlZiBpcyAwLgo+
ID4+IFRoaXMgbG9va3MgY29tcGxpY2F0ZWQgYW5kIGl0IHdpbGwgaW5jcmVhc2UgdGhlIGZvb3Rw
cmludC4gQ29uc2lkZXIgdGhlCj4gPj4gcGVyZm9ybWFuY2UgcGVuYWx0eSBhbmQgdGhlIGNvbXBs
ZXhpdHksIEkgd291bGQgc3VnZ2VzdCB0byB1c2UgcmVzZXQKPiA+PiBpbnN0ZWFkLgo+ID4+Cj4g
Pj4gVGhlbiB3ZSBkb24ndCBuZWVkIHRvIGludHJvZHVjZSBzdWNoIGNvbnRleHQuCj4gPiBJIGRv
bid0IGxpa2UgdGhpcyBlaXRoZXIuIEl0IGlzIGJlc3QgaWYgd2UgY2FuIHJlc2V0IHRoZSBxdWV1
ZSwgYnV0IHRoZW4sCj4gPiBhY2NvcmRpbmcgdG8gbXkgdW5kZXJzdGFuZGluZywgdGhlIGJhY2tl
bmQgc2hvdWxkIGFsc28gYmUgc3VwcG9ydGVkCj4gPiBzeW5jaHJvbm91c2x5LCBzbyBpZiB5b3Ug
ZG9uJ3QgdXBkYXRlIHRoZSBiYWNrZW5kIHN5bmNocm9ub3VzbHksIHlvdSBjYW4ndCB1c2UKPiA+
IHhzay4KPgo+Cj4gWWVzLCBhY3R1YWxseSwgdmhvc3QtbmV0IHN1cHBvcnQgcGVyIHZxIHN1c3Bl
bmRpbmcuIFRoZSBwcm9ibGVtIGlzIHRoYXQKPiB3ZSdyZSBsYWNraW5nIGEgcHJvcGVyIEFQSSBh
dCB2aXJ0aW8gbGV2ZWwuCj4KPiBWaXJ0aW8tcGNpIGhhcyBxdWV1ZV9lbmFibGUgYnV0IGl0IGZv
cmJpZHMgd3JpdGluZyB6ZXJvIHRvIHRoYXQuCj4KPgo+ID4KPiA+IEkgZG9u4oCZdCB0aGluayBy
ZXNldHRpbmcgdGhlIGVudGlyZSBkZXYgaXMgYSBnb29kIHNvbHV0aW9uLiBJZiB5b3Ugd2FudCB0
byBiaW5kCj4gPiB4c2sgdG8gMTAgcXVldWVzLCB5b3UgbWF5IGhhdmUgdG8gcmVzZXQgdGhlIGVu
dGlyZSBkZXZpY2UgMTAgdGltZXMuIEkgZG9u4oCZdAo+ID4gdGhpbmsgdGhpcyBpcyBhIGdvb2Qg
d2F5LiBCdXQgdGhlIGN1cnJlbnQgc3BlYyBkb2VzIG5vdCBzdXBwb3J0IHJlc2V0IHNpbmdsZQo+
ID4gcXVldWUsIHNvIEkgY2hvc2UgdGhlIGN1cnJlbnQgc29sdXRpb24uCj4gPgo+ID4gSmFzb24s
IHdoYXQgZG8geW91IHRoaW5rIHdlIGFyZSBnb2luZyB0byBkbz8gUmVhbGl6ZSB0aGUgcmVzZXQg
ZnVuY3Rpb24gb2YgYQo+ID4gc2luZ2xlIHF1ZXVlPwo+Cj4KPiBZZXMsIGl0J3MgdGhlIGJlc3Qg
d2F5LiBEbyB5b3Ugd2FudCB0byB3b3JrIG9uIHRoYXQ/CgpPZiBjb3Vyc2UsIEkgYW0gdmVyeSB3
aWxsaW5nIHRvIGNvbnRpbnVlIHRoaXMgd29yay4gQWx0aG91Z2ggdXNlcnMgbXVzdCB1cGdyYWRl
CnRoZSBiYWNrZW5kIHRvIHVzZSB2aXJ0aW8tbmV0ICsgeHNrIGluIHRoZSBmdXR1cmUsIHRoaXMg
bWFrZXMgdGhlIHNpdHVhdGlvbiBhCmJpdCB0cm91Ymxlc29tZS4KCkkgd2lsbCBjb21wbGV0ZSB0
aGUga2VybmVsIG1vZGlmaWNhdGlvbiBhcyBzb29uIGFzIHBvc3NpYmxlLCBidXQgSSBhbSBub3QK
ZmFtaWxpYXIgd2l0aCB0aGUgcHJvY2VzcyBvZiBzdWJtaXR0aW5nIHRoZSBzcGVjIHBhdGNoLiBD
YW4geW91IGdpdmUgbWUgc29tZQpndWlkYW5jZSBhbmQgd2hlcmUgc2hvdWxkIEkgc2VuZCB0aGUg
c3BlYyBwYXRjaC4KClRoYW5rcy4KCj4KPiBXZSBjYW4gc3RhcnQgZnJvbSB0aGUgc3BlYyBwYXRj
aCwgYW5kIGludHJvZHVjZSBpdCBhcyBiYXNpYyBmYWNpbGl0eSBhbmQKPiBpbXBsZW1lbnQgaXQg
aW4gdGhlIFBDSSB0cmFuc3BvcnQgZmlyc3QuCj4KPiBUaGFua3MKPgo+Cj4gPgo+ID4gTG9va2lu
ZyBmb3J3YXJkIHRvIHlvdXIgcmVwbHkhISEKPiA+Cj4gPiBUaGFua3MKPiA+Cj4KX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
