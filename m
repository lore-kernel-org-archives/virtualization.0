Return-Path: <SRS0=COaL=H7=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 035CAC433E0
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 16:12:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 715AE64DE5
	for <virtualization@archiver.kernel.org>; Mon,  1 Mar 2021 16:12:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 715AE64DE5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0D8964305F;
	Mon,  1 Mar 2021 16:12:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7hY3D-FX0kJY; Mon,  1 Mar 2021 16:12:44 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id ADBB54304D;
	Mon,  1 Mar 2021 16:12:43 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7E437C000A;
	Mon,  1 Mar 2021 16:12:43 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F4BCC0001
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 16:12:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 270734305F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 16:12:42 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O2ryNHRrrsCp
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 16:12:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 62A864304D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Mar 2021 16:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614615160;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w5C0ICtdcscDpfLdEZo4CtbhG1JRQu69uTcCCkwWORw=;
 b=Xa8as0U6vVOEsiQyYqLwWE/nBucbYQslQEW7+qwxK/RJL/zegEyIf0wKFuFV2wQ1xrDazl
 nMfjkZC9kjKlpZr9cfT/RSXtfAbZ5glM/PNw+NJVKNf4Am84pC3yLNfP3fFT0Garz/TgT2
 laT01JsXid4Gtn8z78TF63J2Udgr+Zk=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-588-t-XinUBzMru0Lg_1sgsjJQ-1; Mon, 01 Mar 2021 11:12:37 -0500
X-MC-Unique: t-XinUBzMru0Lg_1sgsjJQ-1
Received: by mail-ed1-f71.google.com with SMTP id k8so670773edn.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Mar 2021 08:12:37 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=w5C0ICtdcscDpfLdEZo4CtbhG1JRQu69uTcCCkwWORw=;
 b=hWCbV33bOtAdigbnoEx1eE2D3AEFybU388KUlaZCMy4tSDRxA/rIWW6+BMdDWeuDXb
 KDLmre4eK9Cs9uxJt/7EzSeRuOKdZFawu1EXm4GQuTpLNtT95FCSRL0m/g5fyqqRic64
 gxTQi9oQ1J1elI/7QURBcjc7zw0GaBHCC2GBRSpfPx0Rk7H3Vp7hUF/vMpJYKJM1sHtm
 2IqUR59DEWoFPxg2lMyz49eSFOAOHubtFK4tNqnaipvizkrjf0TnzDFzYvcir3ut5X54
 jUJUA71Sglc4FC6lKUkDvlKXJi293+UZ8APq9m+xV7JToTfad3NBSCtB2NbzE5wAacGS
 PpwQ==
X-Gm-Message-State: AOAM531RBtVoP5RJg4xtVJdofvYOKo0GVH2FcPMVcM83G5CvfnATYVKO
 AlNEz9nXtm+zrE4sksHDCuN41CrJYMbTmZfcOPsnqUMa6sbpmCDXNhk8+GY6Sbaq3ztwQodm2tR
 7q68BRIonDt+NYWE+9R6C7t70nPSKN/qUgR/JAgmWWA==
X-Received: by 2002:a17:906:558:: with SMTP id
 k24mr7452845eja.387.1614615156500; 
 Mon, 01 Mar 2021 08:12:36 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxBmbRJyt04z0ZamIS9kzzLsqEGf6g+gjKmom1WU0F9TKxgjUXS+yvKbGXXJbC70C47hE7kTg==
X-Received: by 2002:a17:906:558:: with SMTP id
 k24mr7452830eja.387.1614615156359; 
 Mon, 01 Mar 2021 08:12:36 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id u18sm14059656ejc.76.2021.03.01.08.12.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Mar 2021 08:12:35 -0800 (PST)
Date: Mon, 1 Mar 2021 11:12:33 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH linux-next 7/9] vdpa/mlx5: Provide device generated
 random MAC address
Message-ID: <20210301110937-mutt-send-email-mst@kernel.org>
References: <20210224061844.137776-1-parav@nvidia.com>
 <20210224061844.137776-8-parav@nvidia.com>
 <97a01cb9-8278-1ed6-59b5-807c58523c82@redhat.com>
 <20210301070828.GA184680@mtl-vdi-166.wap.labs.mlnx>
 <20210301080731-mutt-send-email-mst@kernel.org>
 <20210301131951.GA196924@mtl-vdi-166.wap.labs.mlnx>
MIME-Version: 1.0
In-Reply-To: <20210301131951.GA196924@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org
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

T24gTW9uLCBNYXIgMDEsIDIwMjEgYXQgMDM6MTk6NTFQTSArMDIwMCwgRWxpIENvaGVuIHdyb3Rl
Ogo+IE9uIE1vbiwgTWFyIDAxLCAyMDIxIGF0IDA4OjA5OjQ4QU0gLTA1MDAsIE1pY2hhZWwgUy4g
VHNpcmtpbiB3cm90ZToKPiA+IE9uIE1vbiwgTWFyIDAxLCAyMDIxIGF0IDA5OjA4OjI4QU0gKzAy
MDAsIEVsaSBDb2hlbiB3cm90ZToKPiA+ID4gT24gV2VkLCBGZWIgMjQsIDIwMjEgYXQgMDU6MTE6
MjNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiAKPiA+ID4gPiBPbiAyMDIxLzIv
MjQgMjoxOCDkuIvljYgsIFBhcmF2IFBhbmRpdCB3cm90ZToKPiA+ID4gPiA+IEZyb206IEVsaSBD
b2hlbiA8ZWxpY0BudmlkaWEuY29tPgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBVc2UgYSByYW5kb21s
eSBnZW5lcmF0ZWQgTUFDIGFkZHJlc3MgdG8gYmUgYXBwbGllZCBpbiBjYXNlIGl0IGlzIG5vdAo+
ID4gPiA+ID4gY29uZmlndXJlZCBieSBtYW5hZ2VtZW50IHRvb2wuCj4gPiA+ID4gPiAKPiA+ID4g
PiA+IFRoZSB2YWx1ZSBxdWVyaWVkIHRocm91Z2ggbWx4NV9xdWVyeV9uaWNfdnBvcnRfbWFjX2Fk
ZHJlc3MoKSBpcyBub3QKPiA+ID4gPiA+IHJlbGVsYXZudCB0byB2ZHBhIHNpbmNlIGl0IGlzIHRo
ZSBtYWMgdGhhdCBzaG91bGQgYmUgdXNlZCBieSB0aGUgcmVndWxhcgo+ID4gPiA+ID4gTklDIGRy
aXZlci4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogRWxpIENvaGVuIDxlbGlj
QG52aWRpYS5jb20+Cj4gPiA+ID4gPiBSZXZpZXdlZC1ieTogUGFyYXYgUGFuZGl0IDxwYXJhdkBu
dmlkaWEuY29tPgo+ID4gPiA+IAo+ID4gPiA+IAo+ID4gPiA+IEFja2VkLWJ5OiBKYXNvbiBXYW5n
IDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiA+IAo+ID4gPiA+IAo+ID4gPiA+ID4gLS0tCj4g
PiA+ID4gPiAgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyB8IDUgKy0tLS0KPiA+
ID4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCA0IGRlbGV0aW9ucygtKQo+
ID4gPiA+ID4gCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21s
eDVfdm5ldC5jIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiA+ID4gPiBp
bmRleCBiNjdiYmE1ODFkZmQuLmVjZTIxODNlN2IyMCAxMDA2NDQKPiA+ID4gPiA+IC0tLSBhL2Ry
aXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy92
ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiA+ID4gPiBAQCAtMjAwNSwxMCArMjAwNSw3IEBA
IHN0YXRpYyBpbnQgbWx4NV92ZHBhX2Rldl9hZGQoc3RydWN0IHZkcGFfbWdtdF9kZXYgKnZfbWRl
diwgY29uc3QgY2hhciAqbmFtZSkKPiA+ID4gPiA+ICAgCWlmIChlcnIpCj4gPiA+ID4gPiAgIAkJ
Z290byBlcnJfbXR1Owo+ID4gPiA+ID4gLQllcnIgPSBtbHg1X3F1ZXJ5X25pY192cG9ydF9tYWNf
YWRkcmVzcyhtZGV2LCAwLCAwLCBjb25maWctPm1hYyk7Cj4gPiA+ID4gPiAtCWlmIChlcnIpCj4g
PiA+ID4gPiAtCQlnb3RvIGVycl9tdHU7Cj4gPiA+ID4gPiAtCj4gPiA+ID4gPiArCWV0aF9yYW5k
b21fYWRkcihjb25maWctPm1hYyk7Cj4gPiA+IAo+ID4gPiBJIHRoaW5rIHRoaXMgcGF0Y2ggaXMg
bWlzc2luZyBzZXR0aW5nIFZJUlRJT19ORVRfRl9NVFUuIEkgd2lsbCBwb3N0IHYyCj4gPiA+IHdp
dGggdGhlIG90aGVyIGZpeGVzIGluIHRoaXMgc2VyaWVzLgo+ID4gCj4gPiBJIGRvbid0IHJlYWxs
eSB1bmRlcnN0YW5kIHdoeSB0aGlzIGlzIGEgZ29vZCBpZGVhLgo+ID4gCj4gPiBJZiB1c2Vyc3Bh
Y2Ugd2FudHMgYSByYW5kb20gbWFjIGl0IGNhbiBzZXQgaXQsIHdpdGggdGhpcwo+ID4gcGF0Y2gg
aXQgaXMgaW1wb3NzaWJsZSB0byBrbm93IHdoZXRoZXIgdGhlIG1hYyBpcwo+ID4gYSBoYXJkd2Fy
ZSBvbmUgKHdoaWNoIHdpbGwgYmUgcGVyc2lzdGVudCBlLmcuIGFjcm9zcyByZWJvb3RzKQo+ID4g
b3IgYSByYW5kb20gb25lLgo+ID4gCj4gCj4gWW91IGNhbiBzdGlsbCBnZXQgYSBwZXJzaXN0ZW50
IE1BQyBzZXQgYnkgdGhlIHZkcGEgdG9vbC4gZS5nCj4gCj4gdmRwYSBkZXYgY29uZmlnIHNldCB2
ZHBhMCBtYWMgMDA6MTE6MjI6MzM6NDQ6NTUKPiAKPiBJZiB5b3UgZG9uJ3QgdXNlIHZkcGEgdG9v
bCwgdGhlIGRldmljZSBhc3NpZ25zIGEgcmFuZG9tIE1BQy4gVGhpcyBNQUMgaXMKPiB1c2VkIHRv
IGZpbHRlciBpbWNvbWluZyB1bmljYXN0IHRyYWZmaWMgKGRvbmUgaW4gYSBzdWJzZXF1ZW50IHBh
dGNoKS4KCldlbGwgcHJldmlvdXNseSBkZXZpY2UgbGVhcm5lZCB0aGUgTUFDIGZyb20gb3V0Z29p
bmcgdHJhZmZpYwphbmQgdXNlZCB0aGF0IGZvciB0aGUgZmlsdGVyLgpJcyBjaGFuZ2luZyB0aGF0
IHRvIGEgcmFuZG9tIHZhbHVlIHJlYWxseSBhbGwgdGhhdCB1c2VmdWwgYXMKYSBkZWZhdWx0PyAg
V2h5IG5vdCBkbyB0aGUgcmFuZG9taXphdGlvbiBpbiB1c2Vyc3BhY2U/CgoKPiA+IEUuZy4gdGhl
cmUgaXMgYSBwYXRjaCBjb25maWd1cmluZyBhIHVzZXJzcGFjZSBzdXBwbGllZAo+ID4gbWFjIGlm
IHRoZSBoYXJkd2FyZSBtYWMgaXMgemVyby4KPiA+IAo+ID4gVGhpcyBwYXRjaCB3aWxsIGJyZWFr
IGl0Lgo+ID4gCj4gPiA+ID4gPiAgIAltdmRldi0+dmRldi5kbWFfZGV2ID0gbWRldi0+ZGV2aWNl
Owo+ID4gPiA+ID4gICAJZXJyID0gbWx4NV92ZHBhX2FsbG9jX3Jlc291cmNlcygmbmRldi0+bXZk
ZXYpOwo+ID4gPiA+ID4gICAJaWYgKGVycikKPiA+ID4gPiAKPiA+IAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
