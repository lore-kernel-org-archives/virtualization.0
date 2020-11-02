Return-Path: <SRS0=4MNw=EI=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF7A4C55179
	for <virtualization@archiver.kernel.org>; Mon,  2 Nov 2020 17:11:17 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 331F12071A
	for <virtualization@archiver.kernel.org>; Mon,  2 Nov 2020 17:11:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HWACDyWR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 331F12071A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id BEB0F867ED;
	Mon,  2 Nov 2020 17:11:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gwdfzg0Wo2YU; Mon,  2 Nov 2020 17:11:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 793D986776;
	Mon,  2 Nov 2020 17:11:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 711E8C0889;
	Mon,  2 Nov 2020 17:11:15 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 902BDC0051
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 17:11:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 7AB2E867ED
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 17:11:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id COY6df8+ofZa
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 17:11:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1866986776
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Nov 2020 17:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604337071;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qe9HtNbCEgI8DjOjklRgoiEgF3X7IiclvAtTrYaenm8=;
 b=HWACDyWRQAsj9E4AxtQseVwe71ejy4NiblNEpVbsRohgu3/RajGALxi2q+A5U8hhV7cgZo
 6/iY42vA2NFZZ22wAPdPkDosYXND3wXHn6lGat/N8GZgcO4d2OS/5qZs/6vRmaaWSD9XMU
 B+A79s7kle/7Nf9cNxPFYsfEOzLfxwc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-i8RbfPlqMvqrkazZD120pA-1; Mon, 02 Nov 2020 12:11:09 -0500
X-MC-Unique: i8RbfPlqMvqrkazZD120pA-1
Received: by mail-wr1-f71.google.com with SMTP id i1so6659476wrb.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 02 Nov 2020 09:11:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=qe9HtNbCEgI8DjOjklRgoiEgF3X7IiclvAtTrYaenm8=;
 b=K3oNxeorTXujom5NtOZWdYkvPS0aHFU7a89ueuXrnLX1V9sLaHiUwFP2pBy4FLAwvf
 Io31ZwE721Gr6Fbg9YVpoHDVmp0bwyyhd9U7kE6tkzIEbWOropKUIr5a2YWv2drfX4fo
 q2HDtOlax+QymkSi+6q0/mw2elqA9kzL5Bc+cKr+QIemHmbAcU+fo3d+BEI2eSyfeRsW
 UCfugVvyy5TMJetUFAf3ea9pwjK8AZg0Fk+HncjcF9rkfO8CXKYBAkFOh+egoGB+pW5Z
 DXgnF0YPwxQ/Hs2gdV70Xr6F82TJBcx0xipyEAYx1G6+9u1JDXHG94adiqUToMjRVS8S
 WNfQ==
X-Gm-Message-State: AOAM530FRVKOaPDwCx3/E/bEQIFPol+g8wD7wYhA/YtxUnMMmtuuF9ZJ
 KqgwpMPYWEEOC5JfbpcmDlVpadSnRzC4M/S/HmVuGEAphy05w3qbHQ0q37T7yzLgOaNJZBpG2Qo
 ZiuAchlHeU1vQHTobRMKqRcpeoOVjV4aRv3nkPJDUzg==
X-Received: by 2002:a1c:2441:: with SMTP id k62mr19529350wmk.10.1604337068048; 
 Mon, 02 Nov 2020 09:11:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxftVuRDvqXD+CO65Xi6YzLd9A4FBJz+cftSjYhfrG9NB/4h4AS+WlFGmto5fs0nWE6W+uFJQ==
X-Received: by 2002:a1c:2441:: with SMTP id k62mr19529323wmk.10.1604337067797; 
 Mon, 02 Nov 2020 09:11:07 -0800 (PST)
Received: from steredhat (host-79-22-200-33.retail.telecomitalia.it.
 [79.22.200.33])
 by smtp.gmail.com with ESMTPSA id c9sm9435227wrp.65.2020.11.02.09.11.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 02 Nov 2020 09:11:06 -0800 (PST)
Date: Mon, 2 Nov 2020 18:11:04 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost/vsock: add IOTLB API support
Message-ID: <20201102171104.eiovmkj23fle5ioj@steredhat>
References: <20201029174351.134173-1-sgarzare@redhat.com>
 <751cc074-ae68-72c8-71de-a42458058761@redhat.com>
 <20201030105422.ju2aj2bmwsckdufh@steredhat>
 <278f4732-e561-2b4f-03ee-b26455760b01@redhat.com>
MIME-Version: 1.0
In-Reply-To: <278f4732-e561-2b4f-03ee-b26455760b01@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

T24gRnJpLCBPY3QgMzAsIDIwMjAgYXQgMDc6NDQ6NDNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMC8xMC8zMCDkuIvljYg2OjU0LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6
Cj4+T24gRnJpLCBPY3QgMzAsIDIwMjAgYXQgMDY6MDI6MThQTSArMDgwMCwgSmFzb24gV2FuZyB3
cm90ZToKPj4+Cj4+Pk9uIDIwMjAvMTAvMzAg5LiK5Y2IMTo0MywgU3RlZmFubyBHYXJ6YXJlbGxh
IHdyb3RlOgo+Pj4+VGhpcyBwYXRjaCBlbmFibGVzIHRoZSBJT1RMQiBBUEkgc3VwcG9ydCBmb3Ig
dmhvc3QtdnNvY2sgZGV2aWNlcywKPj4+PmFsbG93aW5nIHRoZSB1c2Vyc3BhY2UgdG8gZW11bGF0
ZSBhbiBJT01NVSBmb3IgdGhlIGd1ZXN0Lgo+Pj4+Cj4+Pj5UaGVzZSBjaGFuZ2VzIHdlcmUgbWFk
ZSBmb2xsb3dpbmcgdmhvc3QtbmV0LCBpbiBkZXRhaWxzIHRoaXMgcGF0Y2g6Cj4+Pj4tIGV4cG9z
ZXMgVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNIGZlYXR1cmUgYW5kIGluaXRzIHRoZSBpb3RsYgo+
Pj4+wqAgZGV2aWNlIGlmIHRoZSBmZWF0dXJlIGlzIGFja2VkCj4+Pj4tIGltcGxlbWVudHMgVkhP
U1RfR0VUX0JBQ0tFTkRfRkVBVFVSRVMgYW5kCj4+Pj7CoCBWSE9TVF9TRVRfQkFDS0VORF9GRUFU
VVJFUyBpb2N0bHMKPj4+Pi0gY2FsbHMgdnFfbWV0YV9wcmVmZXRjaCgpIGJlZm9yZSB2cSBwcm9j
ZXNzaW5nIHRvIHByZWZldGNoIHZxCj4+Pj7CoCBtZXRhZGF0YSBhZGRyZXNzIGluIElPVExCCj4+
Pj4tIHByb3ZpZGVzIC5yZWFkX2l0ZXIsIC53cml0ZV9pdGVyLCBhbmQgLnBvbGwgY2FsbGJhY2tz
IGZvciB0aGUKPj4+PsKgIGNoYXJkZXY7IHRoZXkgYXJlIHVzZWQgYnkgdGhlIHVzZXJzcGFjZSB0
byBleGNoYW5nZSBJT1RMQiBtZXNzYWdlcwo+Pj4+Cj4+Pj5UaGlzIHBhdGNoIHdhcyB0ZXN0ZWQg
d2l0aCBRRU1VIGFuZCBhIHBhdGNoIGFwcGxpZWQgWzFdIHRvIGZpeCBhCj4+Pj5zaW1wbGUgaXNz
dWU6Cj4+Pj7CoMKgwqAgJCBxZW11IC1NIHEzNSxhY2NlbD1rdm0sa2VybmVsLWlycWNoaXA9c3Bs
aXQgXAo+Pj4+wqDCoMKgwqDCoMKgwqDCoMKgwqAgLWRyaXZlIGZpbGU9ZmVkb3JhLnFjb3cyLGZv
cm1hdD1xY293MixpZj12aXJ0aW8gXAo+Pj4+wqDCoMKgwqDCoMKgwqDCoMKgwqAgLWRldmljZSBp
bnRlbC1pb21tdSxpbnRyZW1hcD1vbiBcCj4+Pj7CoMKgwqDCoMKgwqDCoMKgwqDCoCAtZGV2aWNl
IHZob3N0LXZzb2NrLXBjaSxndWVzdC1jaWQ9Myxpb21tdV9wbGF0Zm9ybT1vbgo+Pj4KPj4+Cj4+
PlBhdGNoIGxvb2tzIGdvb2QsIGJ1dCBhIHF1ZXN0aW9uOgo+Pj4KPj4+SXQgbG9va3MgdG8gbWUg
eW91IGRvbid0IGVuYWJsZSBBVFMgd2hpY2ggbWVhbnMgdmhvc3Qgd29uJ3QgZ2V0IAo+Pj5hbnkg
aW52YWxpZGF0aW9uIHJlcXVlc3Qgb3IgZGlkIEkgbWlzcyBhbnl0aGluZz8KPj4+Cj4+Cj4+WW91
J3JlIHJpZ2h0LCBJIGRpZG4ndCBzZWUgaW52YWxpZGF0aW9uIHJlcXVlc3RzLCBvbmx5IG1pc3Mg
YW5kIHVwZGF0ZXMuCj4+Tm93IEkgaGF2ZSB0cmllZCB0byBlbmFibGUgJ2F0cycgYW5kICdkZXZp
Y2UtaW90bGInIGJ1dCBJIHN0aWxsIAo+PmRvbid0IHNlZSBhbnkgaW52YWxpZGF0aW9uLgo+Pgo+
PkhvdyBjYW4gSSB0ZXN0IGl0PyAoU29ycnkgYnV0IEkgZG9uJ3QgaGF2ZSBtdWNoIGV4cGVyaWVu
Y2UgeWV0IHdpdGggCj4+dklPTU1VKQo+Cj4KPkkgZ3Vlc3MgaXQncyBiZWNhdXNlIHRoZSBiYXRj
aGVkIHVubWFwLiBNYXliZSB5b3UgY2FuIHRyeSB0byB1c2UgCj4iaW50ZWxfaW9tbXU9c3RyaWN0
IiBpbiBndWVzdCBrZXJuZWwgY29tbWFuZCBsaW5lIHRvIHNlZSBpZiBpdCB3b3Jrcy4KPgo+QnR3
LCBtYWtlIHN1cmUgdGhlIHFlbXUgY29udGFpbnMgdGhlIHBhdGNoIFsxXS4gT3RoZXJ3aXNlIEFU
UyB3b24ndCBiZSAKPmVuYWJsZWQgZm9yIHJlY2VudCBMaW51eCBLZXJuZWwgaW4gdGhlIGd1ZXN0
LgoKVGhlIHByb2JsZW0gd2FzIG15IGtlcm5lbCwgaXQgd2FzIGJ1aWx0IHdpdGggYSB0aW55IGNv
bmZpZ3VyYXRpb24uClVzaW5nIGZlZG9yYSBzdG9jayBrZXJuZWwgSSBjYW4gc2VlIHRoZSAnaW52
YWxpZGF0ZScgcmVxdWVzdHMsIGJ1dCBJIAphbHNvIGhhZCB0aGUgZm9sbG93aW5nIGlzc3Vlcy4K
CkRvIHRoZXkgbWFrZSB5b3UgcmluZyBhbnkgYmVsbHM/CgokIC4vcWVtdSAtbSA0RyAtc21wIDQg
LU0gcTM1LGFjY2VsPWt2bSxrZXJuZWwtaXJxY2hpcD1zcGxpdCBcCiAgICAgLWRyaXZlIGZpbGU9
ZmVkb3JhLnFjb3cyLGZvcm1hdD1xY293MixpZj12aXJ0aW8gXAogICAgIC1kZXZpY2UgaW50ZWwt
aW9tbXUsaW50cmVtYXA9b24sZGV2aWNlLWlvdGxiPW9uIFwKICAgICAtZGV2aWNlIHZob3N0LXZz
b2NrLXBjaSxndWVzdC1jaWQ9Nixpb21tdV9wbGF0Zm9ybT1vbixhdHM9b24saWQ9djEKCiAgICAg
cWVtdS1zeXN0ZW0teDg2XzY0OiB2dGRfaW92YV90b19zbHB0ZTogZGV0ZWN0ZWQgSU9WQSBvdmVy
ZmxvdyAKICAgICAoaW92YT0weDFkNDAwMDAwMzBjMCkKICAgICBxZW11LXN5c3RlbS14ODZfNjQ6
IHZ0ZF9pb21tdV90cmFuc2xhdGU6IGRldGVjdGVkIHRyYW5zbGF0aW9uIAogICAgIGZhaWx1cmUg
KGRldj0wMDowMzowMCwgaW92YT0weDFkNDAwMDAwMzBjMCkKICAgICBxZW11LXN5c3RlbS14ODZf
NjQ6IE5ldyBmYXVsdCBpcyBub3QgcmVjb3JkZWQgZHVlIHRvIGNvbXByZXNzaW9uIG9mIAogICAg
IGZhdWx0cwoKR3Vlc3Qga2VybmVsIG1lc3NhZ2VzOgogICAgIFsgICA0NC45NDA4NzJdIERNQVI6
IERSSEQ6IGhhbmRsaW5nIGZhdWx0IHN0YXR1cyByZWcgMgogICAgIFsgICA0NC45NDE5ODldIERN
QVI6IFtETUEgUmVhZF0gUmVxdWVzdCBkZXZpY2UgWzAwOjAzLjBdIFBBU0lEIAogICAgIGZmZmZm
ZmZmIGZhdWx0IGFkZHIgZmZmZjg4VwogICAgIFsgICA0OS43ODU4ODRdIERNQVI6IERSSEQ6IGhh
bmRsaW5nIGZhdWx0IHN0YXR1cyByZWcgMgogICAgIFsgICA0OS43ODg4NzRdIERNQVI6IFtETUEg
UmVhZF0gUmVxdWVzdCBkZXZpY2UgWzAwOjAzLjBdIFBBU0lEIAogICAgIGZmZmZmZmZmIGZhdWx0
IGFkZHIgZmZmZjg4VwoKClFFTVU6IGIxNDlkZWE1NWMgTWVyZ2UgcmVtb3RlLXRyYWNraW5nIGJy
YW5jaCAKJ3JlbW90ZXMvY3NjaG9lbmViZWNrL3RhZ3MvcHVsbC05cC0yMDIwMTEwMicgaW50byBz
dGFnaW5nCgpMaW51eCBndWVzdDogNS44LjE2LTIwMC5mYzMyLng4Nl82NAoKClRoYW5rcywKU3Rl
ZmFubwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
