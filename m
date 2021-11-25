Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1176DC433EF
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 06:38:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CFCB82733;
	Thu, 25 Nov 2021 06:38:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y-9TDpuimAJD; Thu, 25 Nov 2021 06:38:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 85591824EF;
	Thu, 25 Nov 2021 06:38:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 59575C0038;
	Thu, 25 Nov 2021 06:38:05 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3A08C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 06:38:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8BB9C4012D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 06:38:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4o1t4fOUvPTS
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 06:38:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 89E5D400DE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 06:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637822281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eHJ7MMRM38qWNKAfIMagbO6YequielqNERfHEsYHFTs=;
 b=EkABmr2D2xRMExxmDBDlHGSADrmK4wL1Mjk/gZq9Y38My3rnXVZyFB8+xsXbv5SjfMMhou
 QJsBLJeWXGV4ZQWucTMhgrcZ7prJutStGZ36EySvaONJfnzUyu7kS9od62iuklRjlrng1V
 ydF344POekjdPFC5I75hRj0mh0mh+Vg=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-353-qHJcPvyePRWMMol9TL0aKw-1; Thu, 25 Nov 2021 01:37:59 -0500
X-MC-Unique: qHJcPvyePRWMMol9TL0aKw-1
Received: by mail-lj1-f200.google.com with SMTP id
 2-20020a2e0902000000b00218c22336abso1567867ljj.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 24 Nov 2021 22:37:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=eHJ7MMRM38qWNKAfIMagbO6YequielqNERfHEsYHFTs=;
 b=6w0wucHL24m8VA2ldKsjYYWzfuYbGlScWhhdpB1zSllc+9NuLdN2EMS5/w8WYuWAKz
 mJ9ZczcZ4NNr+uXoo4S1Vp00uJSlzTl/fmJEkNUtCJhkEOiRRI5RqH4s2YiJsjpwqCOS
 4vGqHbqQWN3quH0wppluCUBxoxHXQVDE358Ak3qUeLGzfVjMA9drgq87yYH6Qt4Sqwpf
 ETguvjgiamro/xqbComg/jjxweu1EusESgE+vEhxJF/MyBbL3mqFjjLcsk4V1Bffk8ic
 VDkM7AQwsc5F7Xh7A3wy1Q9sOl/FSHthbAA4LV3TdhN/I/lMWP9fUmosEis/sUKY8SU1
 +tZg==
X-Gm-Message-State: AOAM533HDzgZhrk0V+XelKx3j4C8xyTBsXXwT9y4LhZfkEnCgt97M/2m
 QtaxTy3nf1bYNEL/50ucJmcWtRqr4JfzLoNv4T8HILUe1gpn+vFR8GJ5MaqXha+NGBzw/NESB0v
 ln462kN+B52nnTQbPvZ84wEV4R2yCO7P8ub4uGqXOs6pYVmfTddyQOHQSeA==
X-Received: by 2002:a2e:b742:: with SMTP id k2mr23160449ljo.107.1637822277438; 
 Wed, 24 Nov 2021 22:37:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxfKDzopEf5gBdNkwJMujTdQMOR0YDXUEhfMXk5jRnMH1m3UyG7mWtqK+GkarTWkC+zcci02fv6RLhaAyr0vd8=
X-Received: by 2002:a2e:b742:: with SMTP id k2mr23160418ljo.107.1637822277134; 
 Wed, 24 Nov 2021 22:37:57 -0800 (PST)
MIME-Version: 1.0
References: <71d7b0463629471e9d4887d7fcef1d8d@intel.com>
 <20211110054121-mutt-send-email-mst@kernel.org>
 <dcaf10bed215456ab689956275d4b998@intel.com>
In-Reply-To: <dcaf10bed215456ab689956275d4b998@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Nov 2021 14:37:46 +0800
Message-ID: <CACGkMEsY_XkRo_P+R=ipQ1iYm-AimvLvfXUwEy40Nn4f1D_suA@mail.gmail.com>
Subject: Re: [RFC] hypercall-vsock: add a new vsock transport
To: "Wang, Wei W" <wei.w.wang@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Yamahata, Isaku" <isaku.yamahata@intel.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 "srutherford@google.com" <srutherford@google.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "erdemaktas@google.com" <erdemaktas@google.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Kleen, Andi" <andi.kleen@intel.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>
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

T24gVGh1LCBOb3YgMTEsIDIwMjEgYXQgMzo1OSBQTSBXYW5nLCBXZWkgVyA8d2VpLncud2FuZ0Bp
bnRlbC5jb20+IHdyb3RlOgo+Cj4gT24gV2VkbmVzZGF5LCBOb3ZlbWJlciAxMCwgMjAyMSA2OjUw
IFBNLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiBPbiBXZWQsIE5vdiAxMCwgMjAyMSBh
dCAwNzoxMjozNkFNICswMDAwLCBXYW5nLCBXZWkgVyB3cm90ZToKPiA+Cj4gPiBoeXBlcmNhbGxz
IGFyZSBmdW5kYW1lbnRhbGx5IGh5cGVydmlzb3IgZGVwZW5kZW50IHRob3VnaC4KPgo+IFllcywg
ZWFjaCBoeXBlcnZpc29yIG5lZWRzIHRvIHN1cHBvcnQgaXQuCj4gV2UgY291bGQgc2ltcGxpZnkg
dGhlIGRlc2lnbiBhbmQgaW1wbGVtZW50YXRpb24gdG8gdGhlIG1pbmltYWwsIHNvIHRoYXQgZWFj
aCBoeXBlcnZpc29yIGNhbiBlYXNpbHkgc3VwcG9ydCBpdC4KPiBPbmNlIGV2ZXJ5IGh5cGVydmlz
b3IgaGFzIHRoZSBzdXBwb3J0LCB0aGUgZ3Vlc3QgKE1pZ1REKSBjb3VsZCBiZSBhIHVuaWZpZWQg
dmVyc2lvbi4KPiAoZS5nLiBubyBuZWVkIGZvciBlYWNoIGh5cGVydmlzb3IgdXNlciB0byBkZXZl
bG9wIHRoZWlyIG93biBNaWdURCB1c2luZyB0aGVpciBvd24gdnNvY2sgdHJhbnNwb3J0KQo+Cj4g
PiBBc3N1bWluZyB5b3UgY2FuIGNhcnZlIHVwIGEgaHlwZXJ2aXNvciBpbmRlcGVuZGVudCBoeXBl
cmNhbGwsIHVzaW5nIGl0IGZvcgo+ID4gc29tZXRoaW5nIGFzIG11bmRhbmUgYW5kIHNwZWNpZmlj
IGFzIHZzb2NrIGZvciBURFggc2VlbXMgbGlrZSBhIGh1Z2Ugb3ZlcmtpbGwuCj4gPiBGb3IgZXhh
bXBsZSwgdmlydGlvIGNvdWxkIGJlbmVmaXQgZnJvbSBmYXN0ZXIgdm1leGl0cyB0aGF0IGh5cGVy
Y2FsbHMgZ2l2ZSB5b3UKPiA+IGZvciBzaWduYWxsaW5nLgo+ID4gSG93IGFib3V0IGEgY29tYmlu
YXRpb24gb2YgdmlydGlvLW1taW8gYW5kIGh5cGVyY2FsbHMgZm9yIGZhc3QtcGF0aCBzaWduYWxs
aW5nCj4gPiB0aGVuPwo+Cj4gV2UgdGhvdWdodCBhYm91dCB2aXJ0aW8tbW1pby4gVGhlcmUgYXJl
IHNvbWUgYmFycmllcnM6Cj4gMSkgSXQgd2Fzbid0IG9yaWdpbmFsbHkgaW50ZW5kZWQgZm9yIHg4
NiBtYWNoaW5lcy4gVGhlIG9ubHkgbWFjaGluZSB0eXBlIGluIFFFTVUKPiB0aGF0IHN1cHBvcnRz
IGl0ICh0byBydW4gb24geDg2KSBpcyBtaWNyb3ZtLiBCdXQgIm1pY3Jvdm0iIGRvZXNu4oCZdCBz
dXBwb3J0IFREWCBjdXJyZW50bHksCj4gYW5kIGFkZGluZyB0aGlzIHN1cHBvcnQgbWlnaHQgbmVl
ZCBsYXJnZXIgZWZmb3J0LgoKQ2FuIHlvdSBleHBsYWluIHdoeSBtaWNyb3ZtIG5lZWRzIGxhcmdl
ciBlZmZvcnQ/IEl0IGxvb2tzIHRvIG1lIGl0CmZpdHMgZm9yIFREWCBwZXJmZWN0bHkgc2luY2Ug
aXQgaGFzIGxlc3MgYXR0YWNrIHN1cmZhY2UuCgpUaGFua3MKCj4gMikgSXQncyBzaW1wbGVyIHRo
YW4gdmlydGlvLXBjaSwgYnV0IHN0aWxsIG1vcmUgY29tcGxleCB0aGFuIGh5cGVyY2FsbC4KPiAz
KSBTb21lIENTUHMgZG9uJ3QgaGF2ZSB2aXJ0aW8gc3VwcG9ydCBpbiB0aGVpciBzb2Z0d2FyZSwg
c28gdGhpcyBtaWdodCBhZGQgdG9vIG11Y2ggZGV2ZWxvcG1lbnQgZWZmb3J0IGZvciB0aGVtLgo+
Cj4gVGhpcyB1c2FnZSBkb2VzbuKAmXQgbmVlZCBoaWdoIHBlcmZvcm1hbmNlLCBzbyBmYXN0ZXIg
aHlwZXJjYWxsIGZvciBzaWduYWxsaW5nIGlzbid0IHJlcXVpcmVkLCBJIHRoaW5rLgo+IChidXQg
aWYgaHlwZXJjYWxsIGhhcyBiZWVuIHZlcmlmaWVkIHRvIGJlIG11Y2ggZmFzdGVyIHRoYW4gdGhl
IGN1cnJlbnQgRVBUIG1pc2NvbmZpZyBiYXNlZCBub3RpZmljYXRpb24sCj4gaXQgY291bGQgYmUg
YWRkZWQgZm9yIHRoZSBnZW5lcmFsIHZpcnRpbyB1c2FnZXMpCj4KPiA+Cj4gPiA+IDIpICAgICAg
IEl0IGlzIHNpbXBsZXIuIEl0IGRvZXNu4oCZdCByZWx5IG9uIGFueSBjb21wbGV4IGJ1cyBlbnVt
ZXJhdGlvbgo+ID4gPgo+ID4gPiAoZS5nLiB2aXJ0aW8tcGNpIGJhc2VkIHZzb2NrIGRldmljZSBt
YXkgbmVlZCB0aGUgd2hvbGUgaW1wbGVtZW50YXRpb24gb2YKPiA+IFBDSSkuCj4gPiA+Cj4gPgo+
ID4gTmV4dCB0aGluZyBwZW9wbGUgd2lsbCB0cnkgdG8gZG8gaXMgaW1wbGVtZW50IGEgYnVuY2gg
b2Ygb3RoZXIgZGV2aWNlIG9uIHRvcCBvZgo+ID4gaXQuICB2aXJ0aW8gdXNlZCBwY2kgc2ltcGx5
IGJlY2F1c2UgZXZlcnlvbmUgaW1wbGVtZW50cyBwY2kuICBBbmQgdGhlIHJlYXNvbgo+ID4gZm9y
ICp0aGF0KiBpcyBiZWNhdXNlIGltcGxlbWVudGluZyBhIGJhc2ljIHBjaSBidXMgaXMgZGVhZCBz
aW1wbGUsIHdob2xlIG9mCj4gPiBwY2kuYyBpbiBxZW11IGlzIDwzMDAwIExPQy4KPgo+IFRoaXMg
ZG9lc27igJl0IGluY2x1ZGUgdGhlIFBDSSBlbnVtZXJhdGlvbiBpbiBzZWFCSU9TIGFuZCB0aGUg
UENJIGRyaXZlciBpbiB0aGUgZ3Vlc3QgdGhvdWdoLgo+Cj4gVmlydGlvIGhhcyBoaWdoIHBlcmZv
cm1hbmNlLCBJIHRoaW5rIHRoYXQncyBhbiBpbXBvcnRhbnQgcmVhc29uIHRoYXQgbW9yZSBkZXZp
Y2VzIGFyZSBjb250aW51YWxseSBhZGRlZC4KPiBGb3IgdGhpcyB0cmFuc3BvcnQsIEkgY291bGRu
4oCZdCBlbnZpc2lvbiB0aGF0IGEgYnVuY2ggb2YgZGV2aWNlcyB3b3VsZCBiZSBhZGRlZC4gSXQn
cyBhIHNpbXBsZSBQViBtZXRob2QuCj4KPgo+ID4KPiA+ID4KPiA+ID4gQW4gZXhhbXBsZSB1c2Fn
ZSBpcyB0aGUgY29tbXVuaWNhdGlvbiBiZXR3ZWVuIE1pZ1REIGFuZCBob3N0IChQYWdlIDgKPiA+
ID4gYXQKPiA+ID4KPiA+ID4gaHR0cHM6Ly9zdGF0aWMuc2NoZWQuY29tL2hvc3RlZF9maWxlcy9r
dm1mb3J1bTIwMjEvZWYvCj4gPiA+IFREWCUyMExpdmUlMjBNaWdyYXRpb25fV2VpJTIwV2FuZy5w
ZGYpLgo+ID4gPgo+ID4gPiBNaWdURCBjb21tdW5pY2F0ZXMgdG8gaG9zdCB0byBhc3Npc3QgdGhl
IG1pZ3JhdGlvbiBvZiB0aGUgdGFyZ2V0ICh1c2VyKSBURC4KPiA+ID4KPiA+ID4gTWlnVEQgaXMg
cGFydCBvZiB0aGUgVENCLCBzbyBpdHMgaW1wbGVtZW50YXRpb24gaXMgZXhwZWN0ZWQgdG8gYmUg
YXMKPiA+ID4gc2ltcGxlIGFzIHBvc3NpYmxlCj4gPiA+Cj4gPiA+IChlLmcuIGJhcmUgbWVudGFs
IGltcGxlbWVudGF0aW9uIHdpdGhvdXQgT1MsIG5vIFBDSSBkcml2ZXIgc3VwcG9ydCkuCj4gPiA+
Cj4gPiA+Cj4gPgo+ID4gVHJ5IHRvIGxpc3QgZHJhd2JhY2tzPyBGb3IgZXhhbXBsZSwgcGFzc3Ro
cm91Z2ggZm9yIG5lc3RlZCB2aXJ0IGlzbid0IHBvc3NpYmxlCj4gPiB1bmxpa2UgcGNpLCBuZWl0
aGVyIGFyZSBoYXJkd2FyZSBpbXBsZW1lbnRhdGlvbnMuCj4gPgo+Cj4gV2h5IGh5cGVyY2FsbCB3
b3VsZG4ndCBiZSBwb3NzaWJsZSBmb3IgbmVzdGVkIHZpcnQ/Cj4gTDIgaHlwZXJjYWxsIGdvZXMg
dG8gTDAgZGlyZWN0bHkgYW5kIEwwIGNhbiBkZWNpZGUgd2hldGhlciB0byBmb3J3YXJkIHRoZSBj
YWxsIHRoZSBMMSAoaW4gb3VyIGNhc2UsIEkgdGhpbmsgbm8gbmVlZCBhcyB0aGUgcGFja2V0IHdp
bGwgZ28gb3V0KSwgcmlnaHQ/Cj4KPiBJdHMgZHJhd2JhY2tzIGFyZSBvYnZpb3VzIChlLmcuIGxv
dyBwZXJmb3JtYW5jZSkuCj4gSW4gZ2VuZXJhbCwgSSB0aGluayBpdCBjb3VsZCBiZSBjb25zaWRl
cmVkIGFzIGEgY29tcGxlbWVudCB0byB2aXJ0aW8uCj4gSSB0aGluayBtb3N0IHVzYWdlcyB3b3Vs
ZCBjaG9vc2UgdmlydGlvIGFzIHRoZXkgZG9u4oCZdCB3b3JyeSBhYm91dCB0aGUgY29tcGxleGl0
eSBhbmQgdGhleSBwdXJzZSBoaWdoIHBlcmZvcm1hbmNlLgo+IEZvciBzb21lIHNwZWNpYWwgdXNh
Z2VzIHRoYXQgdGhpbmsgdmlydGlvIGlzIHRvbyBjb21wbGV4IHRvIHN1ZmZpY2UgYW5kIHRoZXkg
d2FudCBzb21ldGhpbmcgc2ltcGxlciwgdGhleSB3b3VsZCBjb25zaWRlciB0byB1c2UgdGhpcyB0
cmFuc3BvcnTjgIIKPgo+IFRoYW5rcywKPiBXZWkKPgoKX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1
YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhm
b3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
