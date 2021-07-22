Return-Path: <SRS0=qcdz=MO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6CFDC6379A
	for <virtualization@archiver.kernel.org>; Thu, 22 Jul 2021 09:05:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5AB2261370
	for <virtualization@archiver.kernel.org>; Thu, 22 Jul 2021 09:05:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5AB2261370
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 1C4F16066E;
	Thu, 22 Jul 2021 09:05:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9T7py704qRdz; Thu, 22 Jul 2021 09:05:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 92D8B60657;
	Thu, 22 Jul 2021 09:05:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5FA2EC001A;
	Thu, 22 Jul 2021 09:05:18 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E5E21C000E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 09:05:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E0E4D60657
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 09:05:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id LQi3enXaRLXQ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 09:05:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AB9A86062D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 09:05:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626944715;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=613H4wAGuEnZg548mMLIz3DNJ0VmDXrroK5bj+IIg9Q=;
 b=aS+hBmnykPE37TnJjdcuJw/YnzXpE2V4OuFQvdpoPiy8LnpIRt5TrT0b4IHWzjUVe3Rvnr
 H5V5gRkI4ypHj4ALT0hJpdh5wHPabZWUw0u1htmQU1vwyjOnU4BR1bbVhARSUTHAnLUn/x
 b9YlbHq0czXXRnxvI3WZQHgxrLjlUUU=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-150-I13iGMCEPQiJmM1g-6BN6g-1; Thu, 22 Jul 2021 05:05:08 -0400
X-MC-Unique: I13iGMCEPQiJmM1g-6BN6g-1
Received: by mail-pl1-f200.google.com with SMTP id
 a6-20020a1709027d86b02901019f88b046so2407154plm.21
 for <virtualization@lists.linux-foundation.org>;
 Thu, 22 Jul 2021 02:05:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=613H4wAGuEnZg548mMLIz3DNJ0VmDXrroK5bj+IIg9Q=;
 b=SujJbR3n9U2YjLzOU2hVexP/tfSC2GV90jA91l1rkeyhoP6qbKhSgNziCTPw4RPl5b
 xu1o9hXfzW8Rsdvg7/chEbQqzfXfkF88QlmDhHr+DkGfK+173Asu2mXsQ6k41ABU3f5k
 Tkf/KkBnzlv4YhenyEhAMLmo7GR1vMieiVp4gq6qezSXD6wjgGNMo3m+0xpv5YkJfU0f
 P+hEev/3RRVaxvoZ1AkDy+vPC5V63E3Rxl9Kk4Hd2CB9o8SA3+OQqTIz98LTnsZK0UE1
 BHoz7HWvznmzsKuljcihrKuo/g+jSbkQgJMrB8niaNvyIuD/MqVkARigo/2TZ/egeFmO
 1xVA==
X-Gm-Message-State: AOAM532ewcDzZzC94HJVG4vlA/dfUfQlOfKByRtr5fIrxj2Vaxuddgxs
 6xYK/DVQ6Qr/hgueBRzjVASKukNfgyK8ZgYd5KQIONzNdWMKLtk0NuU8yDy3ceZVT6qzcxC1e3E
 EnRu3tkqf2tjuc6nJ3L8DsaGUQCNVtIo2YWiBl2nrCQ==
X-Received: by 2002:a63:1658:: with SMTP id 24mr12874154pgw.307.1626944707783; 
 Thu, 22 Jul 2021 02:05:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJy0+x8zNhuoIB4bhgvnGT/Lauq7S1tovNJXVfSEHqXJ8wvxOVkqIxFpT/VtggSDtTXoyT+32Q==
X-Received: by 2002:a63:1658:: with SMTP id 24mr12874128pgw.307.1626944707458; 
 Thu, 22 Jul 2021 02:05:07 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id t3sm4781930pfd.153.2021.07.22.02.05.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 22 Jul 2021 02:05:07 -0700 (PDT)
Subject: Re: [RFC 0/3] cpuidle: add poll_source API and virtio vq polling
To: Stefan Hajnoczi <stefanha@redhat.com>
References: <20210713161906.457857-1-stefanha@redhat.com>
 <1008dee4-fce1-2462-1520-f5432bc89a07@redhat.com>
 <YPfryV7qZVRbjNgP@stefanha-x1.localdomain>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <869a993d-a1b0-1c39-d081-4cdd2b71041f@redhat.com>
Date: Thu, 22 Jul 2021 17:04:57 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <YPfryV7qZVRbjNgP@stefanha-x1.localdomain>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Michael S . Tsirkin" <mst@redhat.com>, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>, linux-kernel@vger.kernel.org,
 Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIxLzcvMjEg5LiL5Y2INTo0MSwgU3RlZmFuIEhham5vY3ppIOWGmemBkzoKPiBPbiBX
ZWQsIEp1bCAyMSwgMjAyMSBhdCAxMToyOTo1NUFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+
PiDlnKggMjAyMS83LzE0IOS4iuWNiDEyOjE5LCBTdGVmYW4gSGFqbm9jemkg5YaZ6YGTOgo+Pj4g
VGhlc2UgcGF0Y2hlcyBhcmUgbm90IHBvbGlzaGVkIHlldCBidXQgSSB3b3VsZCBsaWtlIHJlcXVl
c3QgZmVlZGJhY2sgb24gdGhpcwo+Pj4gYXBwcm9hY2ggYW5kIHNoYXJlIHBlcmZvcm1hbmNlIHJl
c3VsdHMgd2l0aCB5b3UuCj4+Pgo+Pj4gSWRsZSBDUFVzIHRlbnRhdGl2ZWx5IGVudGVyIGEgYnVz
eSB3YWl0IGxvb3AgYmVmb3JlIGhhbHRpbmcgd2hlbiB0aGUgY3B1aWRsZQo+Pj4gaGFsdHBvbGwg
ZHJpdmVyIGlzIGVuYWJsZWQgaW5zaWRlIGEgdmlydHVhbCBtYWNoaW5lLiBUaGlzIHJlZHVjZXMg
d2FrZXVwCj4+PiBsYXRlbmN5IGZvciBldmVudHMgdGhhdCBvY2N1ciBzb29uIGFmdGVyIHRoZSB2
Q1BVIGJlY29tZXMgaWRsZS4KPj4+Cj4+PiBUaGlzIHBhdGNoIHNlcmllcyBleHRlbmRzIHRoZSBj
cHVpZGxlIGJ1c3kgd2FpdCBsb29wIHdpdGggdGhlIG5ldyBwb2xsX3NvdXJjZQo+Pj4gQVBJIHNv
IGRyaXZlcnMgY2FuIHBhcnRpY2lwYXRlIGluIHBvbGxpbmcuIFN1Y2ggcG9sbGluZy1hd2FyZSBk
cml2ZXJzIGRpc2FibGUKPj4+IHRoZWlyIGRldmljZSdzIGlycSBkdXJpbmcgdGhlIGJ1c3kgd2Fp
dCBsb29wIHRvIGF2b2lkIHRoZSBjb3N0IG9mIGludGVycnVwdHMuCj4+PiBUaGlzIHJlZHVjZXMg
bGF0ZW5jeSBmdXJ0aGVyIHRoYW4gcmVndWxhciBjcHVpZGxlIGhhbHRwb2xsLCB3aGljaCBzdGls
bCByZWxpZXMKPj4+IG9uIGlycXMuCj4+Pgo+Pj4gVmlydGlvIGRyaXZlcnMgYXJlIG1vZGlmaWVk
IHRvIHVzZSB0aGUgcG9sbF9zb3VyY2UgQVBJIHNvIGFsbCB2aXJ0aW8gZGV2aWNlCj4+PiB0eXBl
cyBnZXQgdGhpcyBmZWF0dXJlLiBUaGUgZm9sbG93aW5nIHZpcnRpby1ibGsgZmlvIGJlbmNobWFy
ayByZXN1bHRzIHNob3cgdGhlCj4+PiBpbXByb3ZlbWVudDoKPj4+Cj4+PiAgICAgICAgICAgICAg
ICBJT1BTIChudW1qb2JzPTQsIGlvZGVwdGg9MSwgNCB2aXJ0cXVldWVzKQo+Pj4gICAgICAgICAg
ICAgICAgICBiZWZvcmUgICBwb2xsX3NvdXJjZSAgICAgIGlvX3BvbGwKPj4+IDRrIHJhbmRyZWFk
ICAgIDE2NzEwMiAgMTg2MDQ5ICgrMTElKSAgMTg2NjU0ICgrMTElKQo+Pj4gNGsgcmFuZHdyaXRl
ICAgMTYyMjA0ICAxODEyMTQgKCsxMSUpICAxODE4NTAgKCsxMiUpCj4+PiA0ayByYW5kcncgICAg
ICAxNTk1MjAgIDE3NzA3MSAoKzExJSkgIDE3NzkyOCAoKzExJSkKPj4+Cj4+PiBUaGUgY29tcGFy
aXNvbiBhZ2FpbnN0IGlvX3BvbGwgc2hvd3MgdGhhdCBjcHVpZGxlIHBvbGxfc291cmNlIGFjaGll
dmVzCj4+PiBlcXVpdmFsZW50IHBlcmZvcm1hbmNlIHRvIHRoZSBibG9jayBsYXllcidzIGlvX3Bv
bGwgZmVhdHVyZSAod2hpY2ggSQo+Pj4gaW1wbGVtZW50ZWQgaW4gYSBzZXBhcmF0ZSBwYXRjaCBz
ZXJpZXMgWzFdKS4KPj4+Cj4+PiBUaGUgYWR2YW50YWdlIG9mIHBvbGxfc291cmNlIGlzIHRoYXQg
YXBwbGljYXRpb25zIGRvIG5vdCBuZWVkIHRvIGV4cGxpY2l0bHkgc2V0Cj4+PiB0aGUgUldGX0hJ
UFJJIEkvTyByZXF1ZXN0IGZsYWcuIFRoZSBwb2xsX3NvdXJjZSBhcHByb2FjaCBpcyBhdHRyYWN0
aXZlIGJlY2F1c2UKPj4+IGZldyBhcHBsaWNhdGlvbnMgYWN0dWFsbHkgdXNlIFJXRl9ISVBSSSBh
bmQgaXQgdGFrZXMgYWR2YW50YWdlIG9mIENQVSBjeWNsZXMgd2UKPj4+IHdvdWxkIGhhdmUgc3Bl
bnQgaW4gY3B1aWRsZSBoYWx0cG9sbCBhbnl3YXkuCj4+Pgo+Pj4gVGhlIGN1cnJlbnQgc2VyaWVz
IGRvZXMgbm90IGltcHJvdmUgdmlydGlvLW5ldC4gSSBoYXZlbid0IGludmVzdGlnYXRlZCBkZWVw
bHksCj4+PiBidXQgaXQgaXMgcG9zc2libGUgdGhhdCBOQVBJIGFuZCBwb2xsX3NvdXJjZSBkbyBu
b3QgY29tYmluZS4gU2VlIHRoZSBmaW5hbAo+Pj4gcGF0Y2ggZm9yIGEgc3RhcnRpbmcgcG9pbnQg
b24gbWFraW5nIHRoZSB0d28gd29yayB0b2dldGhlci4KPj4+Cj4+PiBJIGhhdmUgbm90IHRyaWVk
IHRoaXMgb24gYmFyZSBtZXRhbCBidXQgaXQgbWlnaHQgaGVscCB0aGVyZSB0b28uIFRoZSBjb3N0
IG9mCj4+PiBkaXNhYmxpbmcgYSBkZXZpY2UncyBpcnEgbXVzdCBiZSBsZXNzIHRoYW4gdGhlIHNh
dmluZ3MgZnJvbSBhdm9pZGluZyBpcnEKPj4+IGhhbmRsaW5nIGZvciB0aGlzIG9wdGltaXphdGlv
biB0byBtYWtlIHNlbnNlLgo+Pj4KPj4+IFsxXSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51
eC1ibG9jay8yMDIxMDUyMDE0MTMwNS4zNTU5NjEtMS1zdGVmYW5oYUByZWRoYXQuY29tLwo+Pgo+
PiBIaSBTdGVmYW46Cj4+Cj4+IFNvbWUgcXVlc3Rpb25zOgo+Pgo+PiAxKSBXaGF0J3MgdGhlIGFk
dmFudGFnZXMgb2YgaW50cm9kdWNpbmcgcG9sbGluZyBhdCB2aXJ0aW8gbGV2ZWwgaW5zdGVhZCBv
Zgo+PiBkb2luZyBpdCBhdCBlYWNoIHN1YnN5c3RlbXM/IFBvbGxpbmcgaW4gdmlydGlvIGxldmVs
IG1heSBvbmx5IHdvcmsgd2VsbCBpZgo+PiBhbGwgKG9yIG1vc3QpIG9mIHRoZSBkZXZpY2VzIGFy
ZSB2aXJ0aW8KPiBJJ20gbm90IHN1cmUgSSB1bmRlcnN0YW5kIHRoZSBxdWVzdGlvbi4gY3B1aWRs
ZSBoYWx0cG9sbCBiZW5lZml0cyBhbGwKPiBkZXZpY2VzIHRvZGF5LCBleGNlcHQgaXQgaW5jdXJz
IGludGVycnVwdCBsYXRlbmN5LiBUaGUgcG9sbF9zb3VyY2UgQVBJCj4gZWxpbWluYXRlcyB0aGUg
aW50ZXJydXB0IGxhdGVuY3kgZm9yIGRyaXZlcnMgdGhhdCBjYW4gZGlzYWJsZSBkZXZpY2UKPiBp
bnRlcnJ1cHRzIGNoZWFwbHkuCj4KPiBUaGlzIHBhdGNoIGFkZHMgcG9sbF9zb3VyY2UgdG8gY29y
ZSB2aXJ0aW8gY29kZSBzbyB0aGF0IGFsbCB2aXJ0aW8KPiBkcml2ZXJzIGdldCB0aGlzIGZlYXR1
cmUgZm9yIGZyZWUuIE5vIGRyaXZlci1zcGVjaWZpYyBjaGFuZ2VzIGFyZQo+IG5lZWRlZC4KPgo+
IElmIHlvdSBtZWFuIG5ldHdvcmtpbmcsIGJsb2NrIGxheWVyLCBldGMgYnkgInN1YnN5c3RlbXMi
IHRoZW4gdGhlcmUncwo+IG5vdGhpbmcgdGhvc2Ugc3Vic3lzdGVtcyBjYW4gZG8gdG8gaGVscC4g
V2hldGhlciBwb2xsX3NvdXJjZSBjYW4gYmUgdXNlZAo+IGRlcGVuZHMgb24gdGhlIHNwZWNpZmlj
IGRyaXZlciwgbm90IHRoZSBzdWJzeXN0ZW0uIElmIHlvdSBjb25zaWRlcgo+IGRyaXZlcnMvdmly
dGlvLyBhIHN1YnN5c3RlbSwgdGhlbiB0aGF0J3MgZXhhY3RseSB3aGF0IHRoZSBwYXRjaCBzZXJp
ZXMKPiBpcyBkb2luZy4KCgpJIG1lYW50LCBpZiB3ZSBjaG9vc2UgdG8gdXNlIGlkbGUgcG9sbCwg
d2UgaGF2ZSBzb21lIHNldmVyYWwgY2hvaWNlczoKCjEpIGJ1cyBsZXZlbCAoZS5nIHRoZSB2aXJ0
aW8pCjIpIHN1YnN5c3RlbSBsZXZlbCAoZS5nIHRoZSBuZXR3b3JraW5nIGFuZCBibG9jaykKCkkn
bSBub3Qgc3VyZSB3aGljaCBvbmUgaXMgYmV0dGVyLgoKCj4KPj4gMikgV2hhdCdzIHRoZSBhZHZh
bnRhZ2VzIG9mIHVzaW5nIGNwdWlkbGUgaW5zdGVhZCBvZiB1c2luZyBhIHRocmVhZCAoYW5kCj4+
IGxldmVyYWdlIHRoZSBzY2hlZHVsZXIpPwo+IEluIG9yZGVyIHRvIGNvbWJpbmUgd2l0aCB0aGUg
ZXhpc3RpbmcgY3B1aWRsZSBpbmZyYXN0cnVjdHVyZS4gTm8gbmV3Cj4gcG9sbGluZyBsb29wIGlz
IGludHJvZHVjZWQgYW5kIG5vIGFkZGl0aW9uYWwgQ1BVIGN5Y2xlcyBhcmUgc3BlbnQgb24KPiBw
b2xsaW5nLgo+Cj4gSWYgY3B1aWRsZSBpdHNlbGYgaXMgY29udmVydGVkIHRvIHRocmVhZHMgdGhl
biBwb2xsX3NvdXJjZSB3b3VsZAo+IGF1dG9tYXRpY2FsbHkgb3BlcmF0ZSBpbiBhIHRocmVhZCB0
b28sIGJ1dCB0aGlzIHBhdGNoIHNlcmllcyBkb2Vzbid0Cj4gY2hhbmdlIGhvdyB0aGUgY29yZSBj
cHVpZGxlIGNvZGUgd29ya3MuCgoKU28gbmV0d29ya2luZyBzdWJzeXN0ZW0gY2FuIHVzZSBOQVBJ
IGJ1c3kgcG9sbGluZyBpbiB0aGUgcHJvY2VzcyBjb250ZXh0IAp3aGljaCBtZWFucyBpdCBjYW4g
YmUgbGV2ZXJhZ2VkIGJ5IHRoZSBzY2hlZHVsZXIuCgpJJ20gbm90IHN1cmUgaXQncyBhIGdvb2Qg
aWRlYSB0byBwb2xsIGRyaXZlcnMgZm9yIGEgc3BlY2lmaWMgYnVzIGluIHRoZSAKZ2VuZXJhbCBj
cHUgaWRsZSBsYXllci4KCkFub3RoZXIgcXVlc3Rpb25zLCBhcmUgdGhvc2UgbnVtYmVycyBtZWFz
dXJlZCBieSBBUElDViBjYXBhYmxlIG1hY2hpbmU/CgpWaXJ0aW8tbmV0IHR1cm5zIG9uIHRoZSB0
eCBpbnRlcnJ1cHRzIHNpbmNlIDIgeWVhcnMgYWdvLiBBbmQgd2UgZG9uJ3QgCnNlZSB0b28gbXVj
aCBkaWZmZXJlbmNlIHdoZW4gbWVhc3VyZWQgd2l0aCBhIEFQSUNWIGhvc3QuCgoKPgo+PiAzKSBB
bnkgcmVhc29uIGl0J3MgdmlydGlvX3BjaSBzcGVjaWZpYyBub3QgYSBnZW5lcmFsIHZpcnRpbyBv
bmU/Cj4gR29vZCBpZGVhLCBpdCBpcyBwb3NzaWJsZSB0byBtb3ZlIHRoZSB2aXJ0aW9fcGNpIGNo
YW5nZXMgaW50byB2aXJ0aW8uYy4KPgo+IE90aGVyIHRyYW5zcG9ydHMgY2FuJ3QgdXNlIHRoaXMg
ZmVhdHVyZSB5ZXQgdGhvdWdoLiBPbmx5IHZpcnRpb19wY2kKPiBzdXBwb3J0cyB2cSBpcnEgYWZm
aW5pdHkuIEJ1dCB0aGUgY29kZSBjYW4gYmUgZ2VuZXJpYyBhbmQgaWYgb3RoZXIKPiB0cmFuc3Bv
cnRzIGV2ZXIgc3VwcG9ydCB2cSBpcnEgYWZmaW5pdHkgdGhleSdsbCBnZXQgaXQgZm9yIGZyZWUu
CgoKWWVzLgoKVGhhbmtzCgoKPgo+PiAoQnR3LCBkbyB3ZSBuZWVkIHRvIGNjIHNjaGVkdWxlciBn
dXlzPykKPiBJJ20gbm90IHN1cmUuIFRoaXMgcGF0Y2ggc2VyaWVzIGRvZXNuJ3QgY2hhbmdlIGhv
dyBjcHVpZGxlIGludGVyYWN0cwo+IHdpdGggdGhlIHNjaGVkdWxlci4gVGhlIGNwdWlkbGUgbWFp
bnRhaW5lcnMgY2FuIHB1bGwgaW4gbW9yZSBwZW9wbGUsIGlmCj4gbmVjZXNzYXJ5Lgo+Cj4gU3Rl
ZmFuCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
