Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 62558C433FE
	for <virtualization@archiver.kernel.org>; Tue, 17 May 2022 06:39:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id AFD1683E4A;
	Tue, 17 May 2022 06:39:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ycR7rZMc2IeV; Tue, 17 May 2022 06:39:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 459A183E41;
	Tue, 17 May 2022 06:39:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0D2D8C0039;
	Tue, 17 May 2022 06:39:06 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D6344C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 06:39:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BDF5940B9F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 06:39:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id TMX97LYfdbpq
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 06:39:00 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from ams.source.kernel.org (ams.source.kernel.org
 [IPv6:2604:1380:4601:e00::1])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 78CB4400F1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 May 2022 06:39:00 +0000 (UTC)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id 7A0B0B80E85;
 Tue, 17 May 2022 06:38:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7714C385B8;
 Tue, 17 May 2022 06:38:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1652769536;
 bh=k4oaGxVJDU0hyszqWxQ7H2kToJSm4bnOU5y/tmGTh50=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=hzFn4MyyuYUY5gSaLlapA8GOl6imR6Gy+NX+A6kvjpy5C9b5msZdq4G7WpN+Pv58u
 9/xKanaQFLGug/oX1g21ZRCWEGcYu3CFlZNgE5q6qkVMsNH4Vu94wZ3k3eFHhqgYOb
 bG+lVEitJ/14NHOTvEW8sX1bngK3hM6z+I3OhLUo=
Date: Tue, 17 May 2022 08:38:48 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 2/3] vdpa: Add a device object for vdpa management
 device
Message-ID: <YoNC+P8Dm75em0+g@kroah.com>
References: <20220516060342.106-1-xieyongji@bytedance.com>
 <20220516060342.106-2-xieyongji@bytedance.com>
 <51811045-548c-1241-0a25-d23e8f7c9d1d@redhat.com>
 <CACycT3uoWjYjogi0H4yrA7GuKnY=djt6BmafoRB-rbmz+8Y4BA@mail.gmail.com>
 <20220516055356-mutt-send-email-mst@kernel.org>
 <CACycT3sqEJ7JSYV646m6CLVH5tKpfbTUV4Oz+XcfXTe4ApEE1w@mail.gmail.com>
 <20220516063357-mutt-send-email-mst@kernel.org>
 <YoI7eBEkVNPj3qFz@kroah.com>
 <CACGkMEuF8wJu7mvMbKpB+Ui-XvB_O8+w0qH2yU6=yQ5mYVQW1Q@mail.gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <CACGkMEuF8wJu7mvMbKpB+Ui-XvB_O8+w0qH2yU6=yQ5mYVQW1Q@mail.gmail.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
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

T24gVHVlLCBNYXkgMTcsIDIwMjIgYXQgMDI6Mjk6MzhQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBNb24sIE1heSAxNiwgMjAyMiBhdCA3OjU0IFBNIEdyZWcgS0ggPGdyZWdraEBsaW51
eGZvdW5kYXRpb24ub3JnPiB3cm90ZToKPiA+Cj4gPiBPbiBNb24sIE1heSAxNiwgMjAyMiBhdCAw
NjozNDozNkFNIC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+IE9uIE1vbiwg
TWF5IDE2LCAyMDIyIGF0IDA2OjMxOjE4UE0gKzA4MDAsIFlvbmdqaSBYaWUgd3JvdGU6Cj4gPiA+
ID4gT24gTW9uLCBNYXkgMTYsIDIwMjIgYXQgNTo1NCBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1z
dEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+Cj4gPiA+ID4gPiBPbiBNb24sIE1heSAxNiwg
MjAyMiBhdCAwNTozMToyN1BNICswODAwLCBZb25namkgWGllIHdyb3RlOgo+ID4gPiA+ID4gPiBP
biBNb24sIE1heSAxNiwgMjAyMiBhdCA1OjE0IFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhh
dC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiDl
nKggMjAyMi81LzE2IDE0OjAzLCBYaWUgWW9uZ2ppIOWGmemBkzoKPiA+ID4gPiA+ID4gPiA+IElu
dHJvZHVjZSBhIGRldmljZSBvYmplY3QgZm9yIHZkcGEgbWFuYWdlbWVudCBkZXZpY2UgdG8gY29u
dHJvbAo+ID4gPiA+ID4gPiA+ID4gaXRzIGxpZmVjeWNsZS4gQW5kIHRoZSBkZXZpY2UgbmFtZSB3
aWxsIGJlIHVzZWQgdG8gbWF0Y2gKPiA+ID4gPiA+ID4gPiA+IFZEUEFfQVRUUl9NR01UREVWX0RF
Vl9OQU1FIGZpZWxkIG9mIG5ldGxpbmsgbWVzc2FnZSByYXRoZXIgdGhhbgo+ID4gPiA+ID4gPiA+
ID4gdXNpbmcgcGFyZW50IGRldmljZSBuYW1lLgo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiA+IFdpdGggdGhpcyBwYXRjaCBhcHBsaWVkLCBkcml2ZXJzIHNob3VsZCB1c2UgdmRwYV9tZ210
ZGV2X2FsbG9jKCkKPiA+ID4gPiA+ID4gPiA+IG9yIF92ZHBhX21nbXRkZXZfYWxsb2MoKSB0byBh
bGxvY2F0ZSBhIHZEUEEgbWFuYWdlbWVudCBkZXZpY2UKPiA+ID4gPiA+ID4gPiA+IGJlZm9yZSBj
YWxsaW5nIHZkcGFfbWdtdGRldl9yZWdpc3RlcigpLiBBbmQgc29tZSBidWdneSBlbXB0eQo+ID4g
PiA+ID4gPiA+ID4gcmVsZWFzZSBmdW5jdGlvbiBjYW4gYWxzbyBiZSByZW1vdmVkIGZyb20gdGhl
IGRyaXZlciBjb2Rlcy4KPiA+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBYaWUgWW9uZ2ppIDx4aWV5b25namlAYnl0ZWRhbmNlLmNvbT4KPiA+ID4gPiA+ID4gPiA+
IC0tLQo+ID4gPiA+ID4gPiA+ID4gICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jICAg
ICAgfCAxMSArKy0tCj4gPiA+ID4gPiA+ID4gPiAgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1
X3ZuZXQuYyAgICB8IDExICsrLS0KPiA+ID4gPiA+ID4gPiA+ICAgZHJpdmVycy92ZHBhL3ZkcGEu
YyAgICAgICAgICAgICAgICAgIHwgOTIgKysrKysrKysrKysrKysrKysrKysrKysrLS0tLQo+ID4g
PiA+ID4gPiA+ID4gICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fYmxrLmMgfCAzOSAr
KysrLS0tLS0tLS0KPiA+ID4gPiA+ID4gPiA+ICAgZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFf
c2ltX25ldC5jIHwgNDYgKysrKystLS0tLS0tLS0KPiA+ID4gPiA+ID4gPiA+ICAgZHJpdmVycy92
ZHBhL3ZkcGFfdXNlci92ZHVzZV9kZXYuYyAgIHwgMzggKysrKy0tLS0tLS0tCj4gPiA+ID4gPiA+
ID4gPiAgIGluY2x1ZGUvbGludXgvdmRwYS5oICAgICAgICAgICAgICAgICB8IDM4ICsrKysrKysr
KysrLQo+ID4gPiA+ID4gPiA+ID4gICA3IGZpbGVzIGNoYW5nZWQsIDE2OCBpbnNlcnRpb25zKCsp
LCAxMDcgZGVsZXRpb25zKC0pCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgYi9kcml2ZXJzL3ZkcGEvaWZj
dmYvaWZjdmZfbWFpbi5jCj4gPiA+ID4gPiA+ID4gPiBpbmRleCA0MzY2MzIwZmI2OGQuLmQ0MDg3
YzM3Y2ZkZiAxMDA2NDQKPiA+ID4gPiA+ID4gPiA+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9p
ZmN2Zl9tYWluLmMKPiA+ID4gPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2
Zl9tYWluLmMKPiA+ID4gPiA+ID4gPiA+IEBAIC04MjEsMTAgKzgyMSwxMSBAQCBzdGF0aWMgaW50
IGlmY3ZmX3Byb2JlKHN0cnVjdCBwY2lfZGV2ICpwZGV2LCBjb25zdCBzdHJ1Y3QgcGNpX2Rldmlj
ZV9pZCAqaWQpCj4gPiA+ID4gPiA+ID4gPiAgICAgICB1MzIgZGV2X3R5cGU7Cj4gPiA+ID4gPiA+
ID4gPiAgICAgICBpbnQgcmV0Owo+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IC0gICAg
IGlmY3ZmX21nbXRfZGV2ID0ga3phbGxvYyhzaXplb2Yoc3RydWN0IGlmY3ZmX3ZkcGFfbWdtdF9k
ZXYpLCBHRlBfS0VSTkVMKTsKPiA+ID4gPiA+ID4gPiA+IC0gICAgIGlmICghaWZjdmZfbWdtdF9k
ZXYpIHsKPiA+ID4gPiA+ID4gPiA+ICsgICAgIGlmY3ZmX21nbXRfZGV2ID0gdmRwYV9tZ210ZGV2
X2FsbG9jKHN0cnVjdCBpZmN2Zl92ZHBhX21nbXRfZGV2LAo+ID4gPiA+ID4gPiA+ID4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWRldiwgZGV2X25hbWUoZGV2KSwg
ZGV2KTsKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gSnVzdCB3b25k
ZXIgaWYgaXQncyBiZXR0ZXIgdG8gbWFrZSB2RFBBIGRldmljZSBhIGNoaWxkIG9mIHRoZSBtZ210
Cj4gPiA+ID4gPiA+ID4gZGV2aWNlIGluc3RlYWQgb2YgdGhlIFBDSSBkZXZpY2U/Cj4gPiA+ID4g
PiA+ID4KPiA+ID4gPiA+ID4gPiAoQ3VycmVudGx5IHdlIHVzZSBQQ0kgZGV2aWNlIGFzIHRoZSBw
YXJlbnQgb2YgdGhlIHZEUEEgZGV2aWNlLCBvciBhdAo+ID4gPiA+ID4gPiA+IGxlYXN0IHdlIGNh
biBkbyB0aGlzIGZvciB0aGUgc2ltdWxhdG9yIHdoaWNoIGRvZXNuJ3QgaGF2ZSBhIHBhcmVudD8p
Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gTWFrZSBzZW5zZS4gSSB0aGlu
ayB3ZSBjYW4gZG8gaXQgZm9yIGFsbCB2RFBBIGRyaXZlcnMuIE1ha2Ugc3VyZSB0aGUKPiA+ID4g
PiA+ID4gcGFyZW50IG9mIHRoZSB2RFBBIGRldmljZSBpcyB0aGUgdkRQQSBtYW5hZ2VtZW50IGRl
dmljZS4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gVGhhbmtzLAo+ID4gPiA+ID4gPiBZb25namkK
PiA+ID4gPiA+Cj4gPiA+ID4gPgo+ID4gPiA+ID4gdGhhdCdzIGFuIEFCSSBjaGFuZ2UgdGhvdWdo
IGlzbid0IGl0PyBwYXJlbnQgaXMgZXhwb3NlZCBpbiBzeXNmcywKPiA+ID4gPiA+IHJpZ2h0Pwo+
ID4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+IEhtbS4uLnllcy4gU28gaXQgbG9va3MgbGlrZSB3ZSBj
YW4ndCBjaGFuZ2UgaXQsIHJpZ2h0Pwo+ID4gPiA+Cj4gPiA+ID4gVGhhbmtzLAo+ID4gPiA+IFlv
bmdqaQo+ID4gPgo+ID4gPiBBZnJhaWQgc28uIGEgd2F5IHRvIGZpbmQgdGhlIHBjaSBkZXZpY2Ug
YWxyZWFkeSBleGlzdHMgSSB0aGluaywgcmlnaHQ/Cj4gPgo+ID4gWW91IGNhbiBjaGFuZ2UgaXQs
IGFueSB0b29scyBzaG91bGQgYmUgZ29pbmcgdGhyb3VnaCB0aGUgYnVzL2RldmljZQo+ID4gbGlu
a3MsIG5vdCB3YWxraW5nIHRoZSBzeXNmcyB0cmVlIGRpcmVjdGx5LCByaWdodD8gIFRoYXQncyB3
aGF0IHRob3NlCj4gPiBzeW1saW5rcyBhcmUgZm9yLCBpbiBvcmRlciB0byBwcm9wZXJseSBiZSBh
YmxlIHRvIGVudW1lcmF0ZSBkaWZmZXJlbnQKPiA+IGRldmljZSB0eXBlcy4KPiA+Cj4gPiBBIHNw
ZWNpZmljIHRvcG9sb2d5IGluIHN5c2ZzIHNob3VsZCBub3QgZXZlciBiZSBhc3N1bWVkIHRvIGJl
IHN0YXRpYwo+ID4gb3ZlciB0aW1lLCB0aGF0J3Mgbm90IGFuIGFjY3VyYXRlIHJlcHJlc2VudGF0
aW9uIG9mIGhvdyB0aGUga2VybmVsCj4gPiB3b3Jrcy4KPiA+Cj4gPiBTbyB0cnkgaXQgYW5kIHNl
ZT8gIE9kZHMgYXJlIHRoZXJlIGFyZSBubyB0b29scyB0aGF0IGV2ZW4gY2FyZSBhYm91dAo+ID4g
dGhlc2UgZGV2aWNlcywgcmlnaHQ/ICBPciBpcyB0aGVyZT8KPiAKPiBJIHRoaW5rIHRoZXJlJ3Mg
bm8gdG9vbCB0aGF0IGRlcGVuZHMgb24gdGhlIHN5c2ZzIHRyZWUgbm93LiBUaGUKPiBtYW5hZ2Vt
ZW50IGxheWVyIGlzIG9ubHkgZXhwZWN0ZWQgdG8gdGFsayB0byB0aGUgbWFuYWdlbWVudCBkZXZp
Y2UgdmlhCj4gdmRwYSg4KSB3aGljaCBpcyBpbnRlZ3JhdGVkIGluIGlwcm91dGUyLgoKR3JlYXQs
IHRoZW4gY2hhbmdlIGF3YXkhCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
