Return-Path: <SRS0=HAf6=MG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5546C07E9A
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 06:47:46 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 57DA8613A9
	for <virtualization@archiver.kernel.org>; Wed, 14 Jul 2021 06:47:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 57DA8613A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 12571608DB;
	Wed, 14 Jul 2021 06:47:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iBXD_7ckI4-s; Wed, 14 Jul 2021 06:47:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B1BF6605DF;
	Wed, 14 Jul 2021 06:47:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 84969C0010;
	Wed, 14 Jul 2021 06:47:44 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 51C75C000E;
 Wed, 14 Jul 2021 06:47:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2C65482BE5;
 Wed, 14 Jul 2021 06:47:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=linuxfoundation.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vct1NVew3bV7; Wed, 14 Jul 2021 06:47:42 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 9C72082BD6;
 Wed, 14 Jul 2021 06:47:42 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id 96EA5613AA;
 Wed, 14 Jul 2021 06:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1626245261;
 bh=YNUqH8SXbCanLQzbk4axEfesSFurixvhv/5EA0zfQNs=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=wAUkEGuaJJ+xyTOr/3CDeDn85Emf2yTZJe5ZHYx0VnNfvTbl7kecruHBrIiXB9tD4
 hOTnqvfdmfYs99MmWfQCGkqgZRAEQaJUr3W2yvScHeXWy0hWoFfBhRxFqDrGmW4RKY
 pl0XDR1Yzvo9UeO+3Eo4T4k0nBkLz7h3AOHxAbt0=
Date: Wed, 14 Jul 2021 08:47:36 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v9 16/17] vduse: Introduce VDUSE - vDPA Device in Userspace
Message-ID: <YO6IiDIMUjQsA2LS@kroah.com>
References: <20210713084656.232-1-xieyongji@bytedance.com>
 <20210713084656.232-17-xieyongji@bytedance.com>
 <26116714-f485-eeab-4939-71c4c10c30de@redhat.com>
 <20210714014817-mutt-send-email-mst@kernel.org>
 <0565ed6c-88e2-6d93-7cc6-7b4afaab599c@redhat.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <0565ed6c-88e2-6d93-7cc6-7b4afaab599c@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, christian.brauner@canonical.com,
 corbet@lwn.net, joro@8bytes.org, willy@infradead.org, hch@infradead.org,
 Xie Yongji <xieyongji@bytedance.com>, dan.carpenter@oracle.com,
 xiaodong.liu@intel.com, viro@zeniv.linux.org.uk, stefanha@redhat.com,
 songmuchun@bytedance.com, axboe@kernel.dk, zhe.he@windriver.com,
 netdev@vger.kernel.org, rdunlap@infradead.org, linux-kernel@vger.kernel.org,
 iommu@lists.linux-foundation.org, bcrl@kvack.org,
 linux-fsdevel@vger.kernel.org, mika.penttila@nextfour.com
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

T24gV2VkLCBKdWwgMTQsIDIwMjEgYXQgMDI6MDI6NTBQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMS83LzE0IOS4i+WNiDE6NTQsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnp
gZM6Cj4gPiBPbiBXZWQsIEp1bCAxNCwgMjAyMSBhdCAwMTo0NTozOVBNICswODAwLCBKYXNvbiBX
YW5nIHdyb3RlOgo+ID4gPiA+ICtzdGF0aWMgaW50IHZkdXNlX2Rldl9tc2dfc3luYyhzdHJ1Y3Qg
dmR1c2VfZGV2ICpkZXYsCj4gPiA+ID4gKwkJCSAgICAgIHN0cnVjdCB2ZHVzZV9kZXZfbXNnICpt
c2cpCj4gPiA+ID4gK3sKPiA+ID4gPiArCWludCByZXQ7Cj4gPiA+ID4gKwo+ID4gPiA+ICsJaW5p
dF93YWl0cXVldWVfaGVhZCgmbXNnLT53YWl0cSk7Cj4gPiA+ID4gKwlzcGluX2xvY2soJmRldi0+
bXNnX2xvY2spOwo+ID4gPiA+ICsJbXNnLT5yZXEucmVxdWVzdF9pZCA9IGRldi0+bXNnX3VuaXF1
ZSsrOwo+ID4gPiA+ICsJdmR1c2VfZW5xdWV1ZV9tc2coJmRldi0+c2VuZF9saXN0LCBtc2cpOwo+
ID4gPiA+ICsJd2FrZV91cCgmZGV2LT53YWl0cSk7Cj4gPiA+ID4gKwlzcGluX3VubG9jaygmZGV2
LT5tc2dfbG9jayk7Cj4gPiA+ID4gKwo+ID4gPiA+ICsJd2FpdF9ldmVudF9raWxsYWJsZV90aW1l
b3V0KG1zZy0+d2FpdHEsIG1zZy0+Y29tcGxldGVkLAo+ID4gPiA+ICsJCQkJICAgIFZEVVNFX1JF
UVVFU1RfVElNRU9VVCAqIEhaKTsKPiA+ID4gPiArCXNwaW5fbG9jaygmZGV2LT5tc2dfbG9jayk7
Cj4gPiA+ID4gKwlpZiAoIW1zZy0+Y29tcGxldGVkKSB7Cj4gPiA+ID4gKwkJbGlzdF9kZWwoJm1z
Zy0+bGlzdCk7Cj4gPiA+ID4gKwkJbXNnLT5yZXNwLnJlc3VsdCA9IFZEVVNFX1JFUV9SRVNVTFRf
RkFJTEVEOwo+ID4gPiA+ICsJfQo+ID4gPiA+ICsJcmV0ID0gKG1zZy0+cmVzcC5yZXN1bHQgPT0g
VkRVU0VfUkVRX1JFU1VMVF9PSykgPyAwIDogLUVJTzsKPiA+ID4gCj4gPiA+IEkgdGhpbmsgd2Ug
c2hvdWxkIG1hcmsgdGhlIGRldmljZSBhcyBtYWxmdW5jdGlvbiB3aGVuIHRoZXJlIGlzIGEgdGlt
ZW91dCBhbmQKPiA+ID4gZm9yYmlkIGFueSB1c2Vyc3BhY2Ugb3BlcmF0aW9ucyBleGNlcHQgZm9y
IHRoZSBkZXN0cm95IGFmdHdhcmRzIGZvciBzYWZldHkuCj4gPiBUaGlzIGxvb2tzIGxpa2UgaWYg
b25lIHRyaWVkIHRvIHJ1biBnZGIgb24gdGhlIHByb2dyYW0gdGhlIGJlaGF2aW91cgo+ID4gd2ls
bCBjaGFuZ2UgY29tcGxldGVseSBiZWNhdXNlIGtlcm5lbCB3YW50cyBpdCB0byByZXNwb25kIHdp
dGhpbgo+ID4gc3BlY2lmaWMgdGltZS4gTG9va3MgbGlrZSBhIHJlY2VpcGUgZm9yIGhlaXNlbmJ1
Z3MuCj4gPiAKPiA+IExldCdzIG5vdCBidWlsZCBpbnRlcmZhY2VzIHdpdGggYXJiaXRyYXJ5IHRp
bWVvdXRzIGxpa2UgdGhhdC4KPiA+IEludGVycnVwdGlibGUgd2FpdCBleGlzdHMgZm9yIHRoaXMg
dmVyeSByZWFzb24uCj4gCj4gCj4gVGhlIHByb2JsZW0gaXMuIERvIHdlIHdhbnQgdXNlcnNwYWNl
IHByb2dyYW0gbGlrZSBtb2Rwcm9iZSB0byBiZSBzdHVjayBmb3IKPiBpbmRlZmluaXRlIHRpbWUg
YW5kIGV4cGVjdCB0aGUgYWRtaW5pc3RyYXRvciB0byBraWxsIHRoYXQ/CgpXaHkgd291bGQgbW9k
cHJvYmUgYmUgc3R1Y2sgZm9yIGZvcmV2ZXI/CgpJcyB0aGlzIG9uIHRoZSBtb2R1bGUgcHJvYmUg
cGF0aD8KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
