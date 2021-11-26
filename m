Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0FB0AC433EF
	for <virtualization@archiver.kernel.org>; Fri, 26 Nov 2021 22:28:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8913760715;
	Fri, 26 Nov 2021 22:28:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nVAbWVplNF1h; Fri, 26 Nov 2021 22:28:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id F01E36058F;
	Fri, 26 Nov 2021 22:28:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C6997C0012;
	Fri, 26 Nov 2021 22:28:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C25FDC000A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 22:28:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9C66C60778
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 22:28:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ujMA_RJpxzSl
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 22:28:25 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from www62.your-server.de (www62.your-server.de [213.133.104.62])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3B9E860715
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 Nov 2021 22:28:24 +0000 (UTC)
Received: from sslproxy03.your-server.de ([88.198.220.132])
 by www62.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92.3) (envelope-from <daniel@iogearbox.net>)
 id 1mqjgd-000AaT-NR; Fri, 26 Nov 2021 23:27:19 +0100
Received: from [85.1.206.226] (helo=linux.home)
 by sslproxy03.your-server.de with esmtpsa (TLSv1.3:TLS_AES_256_GCM_SHA384:256)
 (Exim 4.92) (envelope-from <daniel@iogearbox.net>)
 id 1mqjgc-0003zq-Pf; Fri, 26 Nov 2021 23:27:18 +0100
Subject: Re: [PATCH v2 net-next 21/26] ice: add XDP and XSK generic
 per-channel statistics
To: Jakub Kicinski <kuba@kernel.org>, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vu?=
 =?UTF-8?Q?sen?= <toke@redhat.com>
References: <20211123163955.154512-1-alexandr.lobakin@intel.com>
 <20211123163955.154512-22-alexandr.lobakin@intel.com>
 <77407c26-4e32-232c-58e0-2d601d781f84@iogearbox.net> <87bl28bga6.fsf@toke.dk>
 <20211125170708.127323-1-alexandr.lobakin@intel.com>
 <20211125094440.6c402d63@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
 <20211125204007.133064-1-alexandr.lobakin@intel.com> <87sfvj9k13.fsf@toke.dk>
 <20211126100611.514df099@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
From: Daniel Borkmann <daniel@iogearbox.net>
Message-ID: <871ae82a-3d5b-2693-2f77-7c86d725a056@iogearbox.net>
Date: Fri, 26 Nov 2021 23:27:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.2
MIME-Version: 1.0
In-Reply-To: <20211126100611.514df099@kicinski-fedora-pc1c0hjn.dhcp.thefacebook.com>
Content-Language: en-US
X-Authenticated-Sender: daniel@iogearbox.net
X-Virus-Scanned: Clear (ClamAV 0.103.3/26365/Fri Nov 26 10:23:49 2021)
Cc: Song Liu <songliubraving@fb.com>, Sergey Ryazanov <ryazanov.s.a@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Vladimir Oltean <vladimir.oltean@nxp.com>, Alexei Starovoitov <ast@kernel.org>,
 Russell King <linux@armlinux.org.uk>, Andrei Vagin <avagin@gmail.com>,
 Tony Nguyen <anthony.l.nguyen@intel.com>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 Ioana Ciornei <ioana.ciornei@nxp.com>, Arthur Kiyanovski <akiyano@amazon.com>,
 Leon Romanovsky <leon@kernel.org>, Jonathan Corbet <corbet@lwn.net>,
 linux-rdma@vger.kernel.org, linux-doc@vger.kernel.org,
 John Fastabend <john.fastabend@gmail.com>, Noam Dagan <ndagan@amazon.com>,
 Cong Wang <cong.wang@bytedance.com>, Martin Habets <habetsm.xilinx@gmail.com>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Johannes Berg <johannes.berg@intel.com>, KP Singh <kpsingh@kernel.org>,
 Andrii Nakryiko <andrii@kernel.org>, Claudiu Manoil <claudiu.manoil@nxp.com>,
 Alexander Lobakin <alexandr.lobakin@intel.com>, Yonghong Song <yhs@fb.com>,
 Shay Agroskin <shayagr@amazon.com>, Marcin Wojtas <mw@semihalf.com>,
 David Arinzon <darinzon@amazon.com>, David Ahern <dsahern@kernel.org>,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
 Martin KaFai Lau <kafai@fb.com>, Edward Cree <ecree.xilinx@gmail.com>,
 Yajun Deng <yajun.deng@linux.dev>, netdev@vger.kernel.org,
 Saeed Bishara <saeedb@amazon.com>,
 Michal Swiatkowski <michal.swiatkowski@linux.intel.com>, bpf@vger.kernel.org,
 Saeed Mahameed <saeedm@nvidia.com>, "David S. Miller" <davem@davemloft.net>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gMTEvMjYvMjEgNzowNiBQTSwgSmFrdWIgS2ljaW5za2kgd3JvdGU6Cj4gT24gRnJpLCAyNiBO
b3YgMjAyMSAxMzozMDoxNiArMDEwMCBUb2tlIEjDuGlsYW5kLUrDuHJnZW5zZW4gd3JvdGU6Cj4+
Pj4gVEJIIEkgd2Fzbid0IGZvbGxvd2luZyB0aGlzIHRocmVhZCB0b28gY2xvc2VseSBzaW5jZSBJ
IHNhdyBEYW5pZWwKPj4+PiBuYWNrZWQgaXQgYWxyZWFkeS4gSSBkbyBwcmVmZXIgcnRubCB4c3Rh
dHMsIEknZCBqdXN0IHJlcG9ydCB0aGVtCj4+Pj4gaW4gLXMgaWYgdGhleSBhcmUgbm9uLXplcm8u
IEJ1dCBkb2Vzbid0IHNvdW5kIGxpa2Ugd2UgaGF2ZSBhbiBhZ3JlZW1lbnQKPj4+PiB3aGV0aGVy
IHRoZXkgc2hvdWxkIGV4aXN0IG9yIG5vdC4KPj4+Cj4+PiBSaWdodCwganVzdCAtcyBpcyBmaW5l
LCBpZiB3ZSBkcm9wIHRoZSBwZXItY2hhbm5lbCBhcHByb2FjaC4KPj4KPj4gSSBhZ3JlZSB0aGF0
IGFkZGluZyB0aGVtIHRvIC1zIGlzIGZpbmUgKGFuZCB0aGF0IHJlc29sdmVzIG15ICJubyBvbmUK
Pj4gd2lsbCBmaW5kIHRoZW0iIGNvbXBsYWluIGFzIHdlbGwpLiBJZiBpdCBjcm93ZHMgdGhlIG91
dHB1dCB3ZSBjb3VsZCBhbHNvCj4+IGRlZmF1bHQgdG8gb25seSBvdXRwdXQnaW5nIGEgc3Vic2V0
LCBhbmQgaGF2ZSB0aGUgbW9yZSBkZXRhaWxlZAo+PiBzdGF0aXN0aWNzIGhpZGRlbiBiZWhpbmQg
YSB2ZXJib3NlIHN3aXRjaCAob3IgZXZlbiBqdXN0IGluIHRoZSBKU09OCj4+IG91dHB1dCk/Cj4+
Cj4+Pj4gQ2FuIHdlIHRoaW5rIG9mIGFuIGFwcHJvYWNoIHdoaWNoIHdvdWxkIG1ha2UgY2xvdWRm
bGFyZSBhbmQgY2lsaXVtCj4+Pj4gaGFwcHk/IEZlZWxzIGxpa2Ugd2UncmUgdHJ5aW5nIHRvIG1h
a2UgdGhlIHNsaWdodGx5IGh5cG90aGV0aWNhbAo+Pj4+IGFkbWluIGhhcHB5IHdoaWxlIGlnbm9y
aW5nIG9iamVjdGlvbnMgb2YgdmVyeSByZWFsIHVzZXJzLgo+Pj4KPj4+IFRoZSBpbml0aWFsIGlk
ZWEgd2FzIHRvIG9ubHkgdW5pZm9ybSB0aGUgZHJpdmVycy4gQnV0IGluIGdlbmVyYWwKPj4+IHlv
dSBhcmUgcmlnaHQsIDEwIGRyaXZlcnMgaGF2aW5nIHNvbWV0aGluZyBkb2Vzbid0IG1lYW4gaXQn
cwo+Pj4gc29tZXRoaW5nIGdvb2QuCj4+Cj4+IEkgZG9uJ3QgdGhpbmsgaXQncyBhY2N1cmF0ZSB0
byBjYWxsIHRoZSBhZG1pbiB1c2UgY2FzZSAiaHlwb3RoZXRpY2FsIi4KPj4gV2UncmUgZXhwZW5k
aW5nIGEgc2lnbmlmaWNhbnQgZWZmb3J0IGV4cGxhaW5pbmcgdG8gcGVvcGxlIHRoYXQgWERQIGNh
bgo+PiAiZWF0IiB5b3VyIHBhY2tldHMsIGFuZCBub3QgaGF2aW5nIGFueSBzdGFuZGFyZCBzdGF0
aXN0aWNzIG1ha2VzIHRoaXMKPj4gd2F5IGhhcmRlci4gV2Ugc2hvdWxkIGFic29sdXRlbHkgY2F0
ZXIgdG8gb3VyICJlYXJseSBhZG9wdGVycyIsIGJ1dCBpZgo+PiB3ZSB3YW50IFhEUCB0byBzZWUg
d2lkZXIgYWRvcHRpb24sIG1ha2luZyBpdCAibGVzcyB3ZWlyZCIgaXMgY3JpdGljYWwhCj4gCj4g
RmFpci4gSW4gYWxsIGhvbmVzdHkgSSBzYWlkIHRoYXQgaG9waW5nIHRvIHB1c2ggZm9yIGEgbW9y
ZSBmbGV4aWJsZQo+IGFwcHJvYWNoIGhpZGRlbiBlbnRpcmVseSBpbiBCUEYsIGFuZCBub3QgaW52
b2x2aW5nIGRyaXZlciBjaGFuZ2VzLgo+IEFzc3VtaW5nIHRoZSBYRFAgcHJvZ3JhbSBoYXMgbW9y
ZSBmaW5lIGdyYWluZWQgc3RhdHMgd2Ugc2hvdWxkIGJlIGFibGUKPiB0byBleHRyYWN0IHRob3Nl
IGluc3RlYWQgb2YgZG91YmxlLWNvdW50aW5nLiBIZW5jZSBteSB2YWd1ZSAibGV0J3Mgd29yawo+
IHdpdGggYXBwcyIgY29tbWVudC4KPiAKPiBGb3IgZXhhbXBsZSB0byBhIHBlcnNvbiBmYW1pbGlh
ciB3aXRoIHRoZSB3b3JrbG9hZCBpdCdkIGJlIHVzZWZ1bCB0bwo+IGtub3cgaWYgcHJvZ3JhbSBy
ZXR1cm5lZCBYRFBfRFJPUCBiZWNhdXNlIG9mIGNvbmZpZ3VyZWQgcG9saWN5IG9yCj4gZmFpbHVy
ZSB0byBwYXJzZSBhIHBhY2tldC4gSSBkb24ndCB0aGluayB0aGF0IHNvcnQgZGlzdGluY3Rpb24g
aXMKPiBhY2hpZXZhYmxlIGF0IHRoZSBsZXZlbCBvZiBzdGFuZGFyZCBzdGF0cy4KCkFncmVlIG9u
IHRoZSBhZGRpdGlvbmFsIGNvbnRleHQuIEhvdyBvZnRlbiBoYXZlIHlvdSBsb29rZWQgYXQgdGMg
Y2xzYWN0Ci9kcm9wcGVkLyBzdGF0cyBzcGVjaWZpY2FsbHkgd2hlbiB5b3UgZGVidWcgYSBtb3Jl
IGNvbXBsZXggQlBGIHByb2dyYW0KdGhlcmU/CgogICAjIHRjIC1zIHFkaXNjIHNob3cgY2xzYWN0
IGRldiBmb28KICAgcWRpc2MgY2xzYWN0IGZmZmY6IHBhcmVudCBmZmZmOmZmZjEKICAgIFNlbnQg
NjgwMCBieXRlcyAxMjAgcGt0IChkcm9wcGVkIDAsIG92ZXJsaW1pdHMgMCByZXF1ZXVlcyAwKQog
ICAgYmFja2xvZyAwYiAwcCByZXF1ZXVlcyAwCgpTaW1pbGFybHksIFhEUF9QQVNTIGNvdW50ZXJz
IG1heSBiZSBvZiBsaW1pdGVkIHVzZSBhcyB3ZWxsIGZvciBzYW1lIHJlYXNvbgooYW5kIEkgdGhp
bmsgd2UgbWlnaHQgbm90IGV2ZW4gaGF2ZSBhIHRjIGNvdW50ZXIgZXF1aXZhbGVudCBmb3IgaXQp
LgoKPiBUaGUgaW5mb3JtYXRpb24gcmVxdWlyZWQgYnkgdGhlIGFkbWluIGlzIGhpZ2hlciBsZXZl
bC4gQXMgeW91IHNheSB0aGUKPiBwcmltYXJ5IGNvbmNlcm4gdGhlcmUgaXMgImhvdyBtYW55IHBh
Y2tldHMgZGlkIFhEUCBlYXQiLgoKQWdyZWUuIEFib3ZlIHNhaWQsIGZvciBYRFBfRFJPUCBJIHdv
dWxkIHNlZSBvbmUgdXNlIGNhc2Ugd2hlcmUgeW91IGNvbXBhcmUKZGlmZmVyZW50IGRyaXZlcnMg
b3IgYm9uZCB2cyBubyBib25kIGFzIHdlIGRpZCBpbiB0aGUgcGFzdCBpbiBbMF0gd2hlbgp0ZXN0
aW5nIGFnYWluc3QgYSBwYWNrZXQgZ2VuZXJhdG9yIChhbHRob3VnaCBJIGRvbid0IHNlZSBib25k
IGRyaXZlciBjb3ZlcmVkCmluIHRoaXMgc2VyaWVzIGhlcmUgeWV0IHdoZXJlIGl0IGFnZ3JlZ2F0
ZXMgdGhlIFhEUCBzdGF0cyBmcm9tIGFsbCBib25kIHNsYXZlCmRldnMpLgoKT24gYSBoaWdoZXIt
bGV2ZWwgd3J0ICJob3cgbWFueSBwYWNrZXRzIGRpZCBYRFAgZWF0IiwgaXQgd291bGQgbWFrZSBz
ZW5zZQp0byBoYXZlIHRoZSBzdGF0cyBmb3Igc3VjY2Vzc2Z1bCBYRFBfe1RYLFJFRElSRUNUfSBn
aXZlbiB0aGVzZSBhcmUgb3V0Cm9mIHJlYWNoIGZyb20gYSBCUEYgcHJvZyBQb1YgLSB3ZSBjYW4g
b25seSBjb3VudCB0aGVyZSBob3cgbWFueSB0aW1lcyB3ZQpyZXR1cm5lZCB3aXRoIFhEUF9UWCBi
dXQgbm90IHdoZXRoZXIgdGhlIHBrdCAvc3VjY2Vzc2Z1bGx5IG1hZGUgaXQvLgoKSW4gdGVybXMg
b2YgZXJyb3IgY2FzZXMsIGNvdWxkIHdlIGp1c3Qgc3RhbmRhcmRpemUgYWxsIGRyaXZlcnMgb24g
dGhlIGJlaGF2aW9yCm9mIGUuZy4gbWx4NWVfeGRwX2hhbmRsZSgpLCBtZWFuaW5nLCBhIGZhaWx1
cmUgZnJvbSBYRFBfe1RYLFJFRElSRUNUfSB3aWxsCmhpdCB0aGUgdHJhY2VfeGRwX2V4Y2VwdGlv
bigpIGFuZCB0aGVuIGZhbGx0aHJvdWdoIHRvIGJ1bXAgYSBkcm9wIGNvdW50ZXIKKHNhbWUgYXMg
d2UgYnVtcCBpbiBYRFBfRFJPUCB0aGVuKS4gU28gdGhlIGRyb3AgY291bnRlciB3aWxsIGFjY291
bnQgZm9yCnByb2dyYW0gZHJvcHMgYnV0IGFsc28gZHJpdmVyLXJlbGF0ZWQgZHJvcHMuCgpBdCBz
b21lIGxhdGVyIHBvaW50IHRoZSB0cmFjZV94ZHBfZXhjZXB0aW9uKCkgY291bGQgYmUgZXh0ZW5k
ZWQgd2l0aCBhbiBlcnJvcgpjb2RlIHRoYXQgdGhlIGRyaXZlciB3b3VsZCBwcm9wYWdhdGUgKGdp
dmVuIHNvbWUgb2YgdGhlbSBsb29rIHF1aXRlIHNpbWlsYXIKYWNyb3NzIGRyaXZlcnMsIGZ3aXcp
LCBhbmQgdGhlbiB3aG9ldmVyIHdhbnRzIHRvIGRvIGZ1cnRoZXIgcHJvY2Vzc2luZyB3aXRoCnRo
ZW0gY2FuIGRvIHNvIHZpYSBicGZ0cmFjZSBvciBvdGhlciB0b29saW5nLgoKU28gb3ZlcmFsbCB3
cnQgdGhpcyBzZXJpZXM6IGZyb20gdGhlIGxyc3RhdHMgd2UnZCBiZSAvZHJvcHBpbmcvIHRoZSBw
YXNzLAp0eF9lcnJvcnMsIHJlZGlyZWN0X2Vycm9ycywgaW52YWxpZCwgYWJvcnRlZCBjb3VudGVy
cy4gQW5kIHdlJ2QgYmUgL2tlZXBpbmcvCmJ5dGVzICYgcGFja2V0cyBjb3VudGVycyB0aGF0IFhE
UCBzZWVzLCAoZHJpdmVyLSlzdWNjZXNzZnVsIHR4ICYgcmVkaXJlY3QKY291bnRlcnMgYXMgd2Vs
bCBhcyBkcm9wIGNvdW50ZXIuIEFsc28sIFhEUCBieXRlcyAmIHBhY2tldHMgY291bnRlcnMgc2hv
dWxkCm5vdCBiZSBjb3VudGVkIHR3aWNlIHdydCBldGh0b29sIHN0YXRzLgoKICAgWzBdIGh0dHBz
Oi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4
LmdpdC9jb21taXQvP2lkPTllMmVlNWM3ZTdjMzVkMTk1ZTJhYTA2OTJhNzI0MWQ0N2E0MzNkMWUK
ClRoYW5rcywKRGFuaWVsCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
