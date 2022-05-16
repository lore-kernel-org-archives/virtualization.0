Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 637A2C433EF
	for <virtualization@archiver.kernel.org>; Mon, 16 May 2022 11:54:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DC15F82A5D;
	Mon, 16 May 2022 11:54:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id lCIbguGtfX7E; Mon, 16 May 2022 11:54:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 756EE82A0B;
	Mon, 16 May 2022 11:54:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 46FAAC0039;
	Mon, 16 May 2022 11:54:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 09AE6C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 11:54:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E505E417D4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 11:54:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wAk7l2c8WetO
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 11:54:37 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from dfw.source.kernel.org (dfw.source.kernel.org
 [IPv6:2604:1380:4641:c500::1])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E87F3417BE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 11:54:36 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 20A486100F;
 Mon, 16 May 2022 11:54:36 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3112AC385AA;
 Mon, 16 May 2022 11:54:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1652702075;
 bh=Rf0M99ifKYv2RAtTJPm+8F28nvoNDy9fUhTS1KwWX18=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=HC61FUdxfQrVVBVNoJfHQy07wQFzkdr3UL/ILLd93kHBPFBST1LurIzdC7yKenFEa
 gnUE/g6t4jwVvc002hF0/SqX3GQsX6h72l67L2LCoP8MTeXa1HFyKdWYUreaNYeDIL
 ie0bPZDgn9Py+gHk6CZgcOah/4WlzHgmwI7lwq3Q=
Date: Mon, 16 May 2022 13:54:32 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v2 2/3] vdpa: Add a device object for vdpa management
 device
Message-ID: <YoI7eBEkVNPj3qFz@kroah.com>
References: <20220516060342.106-1-xieyongji@bytedance.com>
 <20220516060342.106-2-xieyongji@bytedance.com>
 <51811045-548c-1241-0a25-d23e8f7c9d1d@redhat.com>
 <CACycT3uoWjYjogi0H4yrA7GuKnY=djt6BmafoRB-rbmz+8Y4BA@mail.gmail.com>
 <20220516055356-mutt-send-email-mst@kernel.org>
 <CACycT3sqEJ7JSYV646m6CLVH5tKpfbTUV4Oz+XcfXTe4ApEE1w@mail.gmail.com>
 <20220516063357-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220516063357-mutt-send-email-mst@kernel.org>
Cc: virtualization <virtualization@lists.linux-foundation.org>,
 Yongji Xie <xieyongji@bytedance.com>, "Zhu, Lingshan" <lingshan.zhu@intel.com>,
 Eli Cohen <elic@nvidia.com>
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

T24gTW9uLCBNYXkgMTYsIDIwMjIgYXQgMDY6MzQ6MzZBTSAtMDQwMCwgTWljaGFlbCBTLiBUc2ly
a2luIHdyb3RlOgo+IE9uIE1vbiwgTWF5IDE2LCAyMDIyIGF0IDA2OjMxOjE4UE0gKzA4MDAsIFlv
bmdqaSBYaWUgd3JvdGU6Cj4gPiBPbiBNb24sIE1heSAxNiwgMjAyMiBhdCA1OjU0IFBNIE1pY2hh
ZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiBPbiBNb24s
IE1heSAxNiwgMjAyMiBhdCAwNTozMToyN1BNICswODAwLCBZb25namkgWGllIHdyb3RlOgo+ID4g
PiA+IE9uIE1vbiwgTWF5IDE2LCAyMDIyIGF0IDU6MTQgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPgo+ID4gPiA+ID4KPiA+ID4gPiA+IOWcqCAyMDIy
LzUvMTYgMTQ6MDMsIFhpZSBZb25namkg5YaZ6YGTOgo+ID4gPiA+ID4gPiBJbnRyb2R1Y2UgYSBk
ZXZpY2Ugb2JqZWN0IGZvciB2ZHBhIG1hbmFnZW1lbnQgZGV2aWNlIHRvIGNvbnRyb2wKPiA+ID4g
PiA+ID4gaXRzIGxpZmVjeWNsZS4gQW5kIHRoZSBkZXZpY2UgbmFtZSB3aWxsIGJlIHVzZWQgdG8g
bWF0Y2gKPiA+ID4gPiA+ID4gVkRQQV9BVFRSX01HTVRERVZfREVWX05BTUUgZmllbGQgb2YgbmV0
bGluayBtZXNzYWdlIHJhdGhlciB0aGFuCj4gPiA+ID4gPiA+IHVzaW5nIHBhcmVudCBkZXZpY2Ug
bmFtZS4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gV2l0aCB0aGlzIHBhdGNoIGFwcGxpZWQsIGRy
aXZlcnMgc2hvdWxkIHVzZSB2ZHBhX21nbXRkZXZfYWxsb2MoKQo+ID4gPiA+ID4gPiBvciBfdmRw
YV9tZ210ZGV2X2FsbG9jKCkgdG8gYWxsb2NhdGUgYSB2RFBBIG1hbmFnZW1lbnQgZGV2aWNlCj4g
PiA+ID4gPiA+IGJlZm9yZSBjYWxsaW5nIHZkcGFfbWdtdGRldl9yZWdpc3RlcigpLiBBbmQgc29t
ZSBidWdneSBlbXB0eQo+ID4gPiA+ID4gPiByZWxlYXNlIGZ1bmN0aW9uIGNhbiBhbHNvIGJlIHJl
bW92ZWQgZnJvbSB0aGUgZHJpdmVyIGNvZGVzLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlAYnl0ZWRhbmNlLmNvbT4KPiA+ID4gPiA+
ID4gLS0tCj4gPiA+ID4gPiA+ICAgZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyAgICAg
IHwgMTEgKystLQo+ID4gPiA+ID4gPiAgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQu
YyAgICB8IDExICsrLS0KPiA+ID4gPiA+ID4gICBkcml2ZXJzL3ZkcGEvdmRwYS5jICAgICAgICAg
ICAgICAgICAgfCA5MiArKysrKysrKysrKysrKysrKysrKysrKystLS0tCj4gPiA+ID4gPiA+ICAg
ZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX2Jsay5jIHwgMzkgKysrKy0tLS0tLS0tCj4g
PiA+ID4gPiA+ICAgZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX25ldC5jIHwgNDYgKysr
KystLS0tLS0tLS0KPiA+ID4gPiA+ID4gICBkcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rl
di5jICAgfCAzOCArKysrLS0tLS0tLS0KPiA+ID4gPiA+ID4gICBpbmNsdWRlL2xpbnV4L3ZkcGEu
aCAgICAgICAgICAgICAgICAgfCAzOCArKysrKysrKysrKy0KPiA+ID4gPiA+ID4gICA3IGZpbGVz
IGNoYW5nZWQsIDE2OCBpbnNlcnRpb25zKCspLCAxMDcgZGVsZXRpb25zKC0pCj4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5j
IGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+ID4gPiA+ID4gPiBpbmRleCA0MzY2
MzIwZmI2OGQuLmQ0MDg3YzM3Y2ZkZiAxMDA2NDQKPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy92
ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+ID4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3ZkcGEvaWZj
dmYvaWZjdmZfbWFpbi5jCj4gPiA+ID4gPiA+IEBAIC04MjEsMTAgKzgyMSwxMSBAQCBzdGF0aWMg
aW50IGlmY3ZmX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBjb25zdCBzdHJ1Y3QgcGNpX2Rl
dmljZV9pZCAqaWQpCj4gPiA+ID4gPiA+ICAgICAgIHUzMiBkZXZfdHlwZTsKPiA+ID4gPiA+ID4g
ICAgICAgaW50IHJldDsKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gLSAgICAgaWZjdmZfbWdtdF9k
ZXYgPSBremFsbG9jKHNpemVvZihzdHJ1Y3QgaWZjdmZfdmRwYV9tZ210X2RldiksIEdGUF9LRVJO
RUwpOwo+ID4gPiA+ID4gPiAtICAgICBpZiAoIWlmY3ZmX21nbXRfZGV2KSB7Cj4gPiA+ID4gPiA+
ICsgICAgIGlmY3ZmX21nbXRfZGV2ID0gdmRwYV9tZ210ZGV2X2FsbG9jKHN0cnVjdCBpZmN2Zl92
ZHBhX21nbXRfZGV2LAo+ID4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBtZGV2LCBkZXZfbmFtZShkZXYpLCBkZXYpOwo+ID4gPiA+ID4KPiA+ID4gPiA+
Cj4gPiA+ID4gPiBKdXN0IHdvbmRlciBpZiBpdCdzIGJldHRlciB0byBtYWtlIHZEUEEgZGV2aWNl
IGEgY2hpbGQgb2YgdGhlIG1nbXQKPiA+ID4gPiA+IGRldmljZSBpbnN0ZWFkIG9mIHRoZSBQQ0kg
ZGV2aWNlPwo+ID4gPiA+ID4KPiA+ID4gPiA+IChDdXJyZW50bHkgd2UgdXNlIFBDSSBkZXZpY2Ug
YXMgdGhlIHBhcmVudCBvZiB0aGUgdkRQQSBkZXZpY2UsIG9yIGF0Cj4gPiA+ID4gPiBsZWFzdCB3
ZSBjYW4gZG8gdGhpcyBmb3IgdGhlIHNpbXVsYXRvciB3aGljaCBkb2Vzbid0IGhhdmUgYSBwYXJl
bnQ/KQo+ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+IE1ha2Ugc2Vuc2UuIEkgdGhpbmsgd2UgY2Fu
IGRvIGl0IGZvciBhbGwgdkRQQSBkcml2ZXJzLiBNYWtlIHN1cmUgdGhlCj4gPiA+ID4gcGFyZW50
IG9mIHRoZSB2RFBBIGRldmljZSBpcyB0aGUgdkRQQSBtYW5hZ2VtZW50IGRldmljZS4KPiA+ID4g
Pgo+ID4gPiA+IFRoYW5rcywKPiA+ID4gPiBZb25namkKPiA+ID4KPiA+ID4KPiA+ID4gdGhhdCdz
IGFuIEFCSSBjaGFuZ2UgdGhvdWdoIGlzbid0IGl0PyBwYXJlbnQgaXMgZXhwb3NlZCBpbiBzeXNm
cywKPiA+ID4gcmlnaHQ/Cj4gPiA+Cj4gPiAKPiA+IEhtbS4uLnllcy4gU28gaXQgbG9va3MgbGlr
ZSB3ZSBjYW4ndCBjaGFuZ2UgaXQsIHJpZ2h0Pwo+ID4gCj4gPiBUaGFua3MsCj4gPiBZb25namkK
PiAKPiBBZnJhaWQgc28uIGEgd2F5IHRvIGZpbmQgdGhlIHBjaSBkZXZpY2UgYWxyZWFkeSBleGlz
dHMgSSB0aGluaywgcmlnaHQ/CgpZb3UgY2FuIGNoYW5nZSBpdCwgYW55IHRvb2xzIHNob3VsZCBi
ZSBnb2luZyB0aHJvdWdoIHRoZSBidXMvZGV2aWNlCmxpbmtzLCBub3Qgd2Fsa2luZyB0aGUgc3lz
ZnMgdHJlZSBkaXJlY3RseSwgcmlnaHQ/ICBUaGF0J3Mgd2hhdCB0aG9zZQpzeW1saW5rcyBhcmUg
Zm9yLCBpbiBvcmRlciB0byBwcm9wZXJseSBiZSBhYmxlIHRvIGVudW1lcmF0ZSBkaWZmZXJlbnQK
ZGV2aWNlIHR5cGVzLgoKQSBzcGVjaWZpYyB0b3BvbG9neSBpbiBzeXNmcyBzaG91bGQgbm90IGV2
ZXIgYmUgYXNzdW1lZCB0byBiZSBzdGF0aWMKb3ZlciB0aW1lLCB0aGF0J3Mgbm90IGFuIGFjY3Vy
YXRlIHJlcHJlc2VudGF0aW9uIG9mIGhvdyB0aGUga2VybmVsCndvcmtzLgoKU28gdHJ5IGl0IGFu
ZCBzZWU/ICBPZGRzIGFyZSB0aGVyZSBhcmUgbm8gdG9vbHMgdGhhdCBldmVuIGNhcmUgYWJvdXQK
dGhlc2UgZGV2aWNlcywgcmlnaHQ/ICBPciBpcyB0aGVyZT8KCnRoYW5rcywKCmdyZWcgay1oCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
