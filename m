Return-Path: <SRS0=JeE0=EJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F33C2D0A3
	for <virtualization@archiver.kernel.org>; Tue,  3 Nov 2020 09:05:21 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3A95F20756
	for <virtualization@archiver.kernel.org>; Tue,  3 Nov 2020 09:05:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bOoDSURf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3A95F20756
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 79CD520515;
	Tue,  3 Nov 2020 09:05:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id veOh5V6iMAC3; Tue,  3 Nov 2020 09:05:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 90D0F203A3;
	Tue,  3 Nov 2020 09:05:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 57B09C0889;
	Tue,  3 Nov 2020 09:05:16 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA705C0051
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 09:05:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id E598885773
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 09:05:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id puvDYwG_rjkK
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 09:05:14 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4174D8557E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  3 Nov 2020 09:05:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604394313;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NCLuRFwSBz7lCHK9Xxh7qpGQtAw7uNBdQ5Y4F/GcLRE=;
 b=bOoDSURfuiKVuCuityHb0l5MLp9SxE4oHhjRwpeiBhEgEtjFfTCEBuikAD5+J4RcO+W4+W
 e72DioWrZ38hAFbTRovksXKxcRpVLvJmhHG5WkeGaYELhFBcjVT42SeB49qzNkYHnpgks1
 S+RUYUNJqEBMi5mlcZl5CgIFpwez1rU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-547-QnBW_FxePh-2eshNLH4Rrw-1; Tue, 03 Nov 2020 04:05:09 -0500
X-MC-Unique: QnBW_FxePh-2eshNLH4Rrw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com
 [10.5.11.23])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23D0C106B816;
 Tue,  3 Nov 2020 09:05:08 +0000 (UTC)
Received: from [10.72.13.208] (ovpn-13-208.pek2.redhat.com [10.72.13.208])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 2F47D21E97;
 Tue,  3 Nov 2020 09:04:32 +0000 (UTC)
Subject: Re: [PATCH] vhost/vsock: add IOTLB API support
To: Stefano Garzarella <sgarzare@redhat.com>
References: <20201029174351.134173-1-sgarzare@redhat.com>
 <751cc074-ae68-72c8-71de-a42458058761@redhat.com>
 <20201030105422.ju2aj2bmwsckdufh@steredhat>
 <278f4732-e561-2b4f-03ee-b26455760b01@redhat.com>
 <20201102171104.eiovmkj23fle5ioj@steredhat>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <8648a2e3-1052-3b5b-11ce-87628ac8dd33@redhat.com>
Date: Tue, 3 Nov 2020 17:04:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201102171104.eiovmkj23fle5ioj@steredhat>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>
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

Ck9uIDIwMjAvMTEvMyDkuIrljYgxOjExLCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6Cj4gT24g
RnJpLCBPY3QgMzAsIDIwMjAgYXQgMDc6NDQ6NDNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4KPj4gT24gMjAyMC8xMC8zMCDkuIvljYg2OjU0LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6
Cj4+PiBPbiBGcmksIE9jdCAzMCwgMjAyMCBhdCAwNjowMjoxOFBNICswODAwLCBKYXNvbiBXYW5n
IHdyb3RlOgo+Pj4+Cj4+Pj4gT24gMjAyMC8xMC8zMCDkuIrljYgxOjQzLCBTdGVmYW5vIEdhcnph
cmVsbGEgd3JvdGU6Cj4+Pj4+IFRoaXMgcGF0Y2ggZW5hYmxlcyB0aGUgSU9UTEIgQVBJIHN1cHBv
cnQgZm9yIHZob3N0LXZzb2NrIGRldmljZXMsCj4+Pj4+IGFsbG93aW5nIHRoZSB1c2Vyc3BhY2Ug
dG8gZW11bGF0ZSBhbiBJT01NVSBmb3IgdGhlIGd1ZXN0Lgo+Pj4+Pgo+Pj4+PiBUaGVzZSBjaGFu
Z2VzIHdlcmUgbWFkZSBmb2xsb3dpbmcgdmhvc3QtbmV0LCBpbiBkZXRhaWxzIHRoaXMgcGF0Y2g6
Cj4+Pj4+IC0gZXhwb3NlcyBWSVJUSU9fRl9BQ0NFU1NfUExBVEZPUk0gZmVhdHVyZSBhbmQgaW5p
dHMgdGhlIGlvdGxiCj4+Pj4+IMKgIGRldmljZSBpZiB0aGUgZmVhdHVyZSBpcyBhY2tlZAo+Pj4+
PiAtIGltcGxlbWVudHMgVkhPU1RfR0VUX0JBQ0tFTkRfRkVBVFVSRVMgYW5kCj4+Pj4+IMKgIFZI
T1NUX1NFVF9CQUNLRU5EX0ZFQVRVUkVTIGlvY3Rscwo+Pj4+PiAtIGNhbGxzIHZxX21ldGFfcHJl
ZmV0Y2goKSBiZWZvcmUgdnEgcHJvY2Vzc2luZyB0byBwcmVmZXRjaCB2cQo+Pj4+PiDCoCBtZXRh
ZGF0YSBhZGRyZXNzIGluIElPVExCCj4+Pj4+IC0gcHJvdmlkZXMgLnJlYWRfaXRlciwgLndyaXRl
X2l0ZXIsIGFuZCAucG9sbCBjYWxsYmFja3MgZm9yIHRoZQo+Pj4+PiDCoCBjaGFyZGV2OyB0aGV5
IGFyZSB1c2VkIGJ5IHRoZSB1c2Vyc3BhY2UgdG8gZXhjaGFuZ2UgSU9UTEIgbWVzc2FnZXMKPj4+
Pj4KPj4+Pj4gVGhpcyBwYXRjaCB3YXMgdGVzdGVkIHdpdGggUUVNVSBhbmQgYSBwYXRjaCBhcHBs
aWVkIFsxXSB0byBmaXggYQo+Pj4+PiBzaW1wbGUgaXNzdWU6Cj4+Pj4+IMKgwqDCoCAkIHFlbXUg
LU0gcTM1LGFjY2VsPWt2bSxrZXJuZWwtaXJxY2hpcD1zcGxpdCBcCj4+Pj4+IMKgwqDCoMKgwqDC
oMKgwqDCoMKgIC1kcml2ZSBmaWxlPWZlZG9yYS5xY293Mixmb3JtYXQ9cWNvdzIsaWY9dmlydGlv
IFwKPj4+Pj4gwqDCoMKgwqDCoMKgwqDCoMKgwqAgLWRldmljZSBpbnRlbC1pb21tdSxpbnRyZW1h
cD1vbiBcCj4+Pj4+IMKgwqDCoMKgwqDCoMKgwqDCoMKgIC1kZXZpY2Ugdmhvc3QtdnNvY2stcGNp
LGd1ZXN0LWNpZD0zLGlvbW11X3BsYXRmb3JtPW9uCj4+Pj4KPj4+Pgo+Pj4+IFBhdGNoIGxvb2tz
IGdvb2QsIGJ1dCBhIHF1ZXN0aW9uOgo+Pj4+Cj4+Pj4gSXQgbG9va3MgdG8gbWUgeW91IGRvbid0
IGVuYWJsZSBBVFMgd2hpY2ggbWVhbnMgdmhvc3Qgd29uJ3QgZ2V0IGFueSAKPj4+PiBpbnZhbGlk
YXRpb24gcmVxdWVzdCBvciBkaWQgSSBtaXNzIGFueXRoaW5nPwo+Pj4+Cj4+Pgo+Pj4gWW91J3Jl
IHJpZ2h0LCBJIGRpZG4ndCBzZWUgaW52YWxpZGF0aW9uIHJlcXVlc3RzLCBvbmx5IG1pc3MgYW5k
IAo+Pj4gdXBkYXRlcy4KPj4+IE5vdyBJIGhhdmUgdHJpZWQgdG8gZW5hYmxlICdhdHMnIGFuZCAn
ZGV2aWNlLWlvdGxiJyBidXQgSSBzdGlsbCAKPj4+IGRvbid0IHNlZSBhbnkgaW52YWxpZGF0aW9u
Lgo+Pj4KPj4+IEhvdyBjYW4gSSB0ZXN0IGl0PyAoU29ycnkgYnV0IEkgZG9uJ3QgaGF2ZSBtdWNo
IGV4cGVyaWVuY2UgeWV0IHdpdGggCj4+PiB2SU9NTVUpCj4+Cj4+Cj4+IEkgZ3Vlc3MgaXQncyBi
ZWNhdXNlIHRoZSBiYXRjaGVkIHVubWFwLiBNYXliZSB5b3UgY2FuIHRyeSB0byB1c2UgCj4+ICJp
bnRlbF9pb21tdT1zdHJpY3QiIGluIGd1ZXN0IGtlcm5lbCBjb21tYW5kIGxpbmUgdG8gc2VlIGlm
IGl0IHdvcmtzLgo+Pgo+PiBCdHcsIG1ha2Ugc3VyZSB0aGUgcWVtdSBjb250YWlucyB0aGUgcGF0
Y2ggWzFdLiBPdGhlcndpc2UgQVRTIHdvbid0IAo+PiBiZSBlbmFibGVkIGZvciByZWNlbnQgTGlu
dXggS2VybmVsIGluIHRoZSBndWVzdC4KPgo+IFRoZSBwcm9ibGVtIHdhcyBteSBrZXJuZWwsIGl0
IHdhcyBidWlsdCB3aXRoIGEgdGlueSBjb25maWd1cmF0aW9uLgo+IFVzaW5nIGZlZG9yYSBzdG9j
ayBrZXJuZWwgSSBjYW4gc2VlIHRoZSAnaW52YWxpZGF0ZScgcmVxdWVzdHMsIGJ1dCBJIAo+IGFs
c28gaGFkIHRoZSBmb2xsb3dpbmcgaXNzdWVzLgo+Cj4gRG8gdGhleSBtYWtlIHlvdSByaW5nIGFu
eSBiZWxscz8KPgo+ICQgLi9xZW11IC1tIDRHIC1zbXAgNCAtTSBxMzUsYWNjZWw9a3ZtLGtlcm5l
bC1pcnFjaGlwPXNwbGl0IFwKPiDCoMKgwqAgLWRyaXZlIGZpbGU9ZmVkb3JhLnFjb3cyLGZvcm1h
dD1xY293MixpZj12aXJ0aW8gXAo+IMKgwqDCoCAtZGV2aWNlIGludGVsLWlvbW11LGludHJlbWFw
PW9uLGRldmljZS1pb3RsYj1vbiBcCj4gwqDCoMKgIC1kZXZpY2Ugdmhvc3QtdnNvY2stcGNpLGd1
ZXN0LWNpZD02LGlvbW11X3BsYXRmb3JtPW9uLGF0cz1vbixpZD12MQo+Cj4gwqDCoMKgIHFlbXUt
c3lzdGVtLXg4Nl82NDogdnRkX2lvdmFfdG9fc2xwdGU6IGRldGVjdGVkIElPVkEgb3ZlcmZsb3cg
wqDCoMKgIAo+IChpb3ZhPTB4MWQ0MDAwMDAzMGMwKQoKCkl0J3MgYSBoaW50IHRoYXQgSU9WQSBl
eGNlZWRzIHRoZSBBVy4gSXQgbWlnaHQgYmUgd29ydGggdG8gY2hlY2sgd2hldGhlciAKdGhlIG1p
c3NlZCBJT1ZBIHJlcG9ydGVkIGZyb20gSU9UTEIgaXMgbGVnYWwuCgpUaGFua3MKCgo+IHFlbXUt
c3lzdGVtLXg4Nl82NDogdnRkX2lvbW11X3RyYW5zbGF0ZTogZGV0ZWN0ZWQgdHJhbnNsYXRpb24g
ZmFpbHVyZSAKPiAoZGV2PTAwOjAzOjAwLCBpb3ZhPTB4MWQ0MDAwMDAzMGMwKQo+IMKgwqDCoCBx
ZW11LXN5c3RlbS14ODZfNjQ6IE5ldyBmYXVsdCBpcyBub3QgcmVjb3JkZWQgZHVlIHRvIGNvbXBy
ZXNzaW9uIAo+IG9mIMKgwqDCoCBmYXVsdHMKPgo+IEd1ZXN0IGtlcm5lbCBtZXNzYWdlczoKPiDC
oMKgwqAgW8KgwqAgNDQuOTQwODcyXSBETUFSOiBEUkhEOiBoYW5kbGluZyBmYXVsdCBzdGF0dXMg
cmVnIDIKPiDCoMKgwqAgW8KgwqAgNDQuOTQxOTg5XSBETUFSOiBbRE1BIFJlYWRdIFJlcXVlc3Qg
ZGV2aWNlIFswMDowMy4wXSBQQVNJRCDCoMKgwqAgCj4gZmZmZmZmZmYgZmF1bHQgYWRkciBmZmZm
ODhXCj4gwqDCoMKgIFvCoMKgIDQ5Ljc4NTg4NF0gRE1BUjogRFJIRDogaGFuZGxpbmcgZmF1bHQg
c3RhdHVzIHJlZyAyCj4gwqDCoMKgIFvCoMKgIDQ5Ljc4ODg3NF0gRE1BUjogW0RNQSBSZWFkXSBS
ZXF1ZXN0IGRldmljZSBbMDA6MDMuMF0gUEFTSUQgwqDCoMKgIAo+IGZmZmZmZmZmIGZhdWx0IGFk
ZHIgZmZmZjg4Vwo+Cj4KPiBRRU1VOiBiMTQ5ZGVhNTVjIE1lcmdlIHJlbW90ZS10cmFja2luZyBi
cmFuY2ggCj4gJ3JlbW90ZXMvY3NjaG9lbmViZWNrL3RhZ3MvcHVsbC05cC0yMDIwMTEwMicgaW50
byBzdGFnaW5nCj4KPiBMaW51eCBndWVzdDogNS44LjE2LTIwMC5mYzMyLng4Nl82NAo+Cj4KPiBU
aGFua3MsCj4gU3RlZmFubwo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
