Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3FF8C433EF
	for <virtualization@archiver.kernel.org>; Fri, 28 Jan 2022 05:56:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3EFE960AD4;
	Fri, 28 Jan 2022 05:56:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id A_0P9QuANTYV; Fri, 28 Jan 2022 05:56:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id BB52260A80;
	Fri, 28 Jan 2022 05:56:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 85C88C001A;
	Fri, 28 Jan 2022 05:56:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 07090C000B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 05:56:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DCB694031F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 05:56:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pMQ9xDdoWEVi
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 05:56:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 8491D400AB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 28 Jan 2022 05:56:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1643349368;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NmvUTogdu9baspfBfX4rGdD/WSBa3qyhLpro0p4Kf88=;
 b=abBjW/InIN25RN0YtYWsBVkqIdQ/As1WAkCz2gZVpNGXrhNqjr68RFhEGn7jL57+CiXeZ9
 PuZNgpSBhA/3/ipRfEl83G1vOgsQQVax0UxS7CWSopFR4g//lzqOJcDIAx/NVArM5pHAb/
 L1ci8lUgUwuGhePu0oSbhtaAp1IyoLY=
Received: from mail-pg1-f200.google.com (mail-pg1-f200.google.com
 [209.85.215.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-294-JHbG2NkIPKagMuYeb6e_3w-1; Fri, 28 Jan 2022 00:56:06 -0500
X-MC-Unique: JHbG2NkIPKagMuYeb6e_3w-1
Received: by mail-pg1-f200.google.com with SMTP id
 r13-20020a638f4d000000b0034c8f73f9efso2800407pgn.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 Jan 2022 21:56:06 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=NmvUTogdu9baspfBfX4rGdD/WSBa3qyhLpro0p4Kf88=;
 b=jrU575mi2Xv71CPN3QAn0GCIF9hChGvvvCazo0DE6cf4HQ5jveDr98VH9yjvVVXmb8
 38a8ylM61QIyxJXnunAyF8VJA4fJMvL0m4uu7UsC8hIPwoDhqD9wDkLlFuU7qqfslYp9
 FQKXWLu0YVhq5/CUWMu9ozycwlIWJ9LS41IlpSblg9913WH6tV04Ol5F1aD1Ci/dH6St
 pkg9xDSOE5bFTj7zKY16ncPAykGTWzMwcta4eIw1aBBgBj13YjN8dWoxThJvyN2jHiSq
 ZXecyUIlmv5dqRucUANvFKSNoAWsBI6qhZd+239PcT/b6V0DNffZAXAWFAxF5oUuhc17
 QjLA==
X-Gm-Message-State: AOAM532x4QjrHqsX3ejbZKwCmVIMhkLR/0/nGht6BRPJIc0AkzrL76VM
 5B4hG1GEmBm6y3JgpcZk9IjYeQKerChP/CUtstI0ek3nG+g6fEAaKO60ePzaw0FR74TZvWRwFoq
 4AHujhQGkFoRKByYof/z5i8WAJ7glCefjUxeJ4CDdZQ==
X-Received: by 2002:a17:903:2093:: with SMTP id
 d19mr6880858plc.29.1643349365473; 
 Thu, 27 Jan 2022 21:56:05 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz95qaukLEbZr8VsmgQvFlsKXiWASwMyW6mr5bfmyA0korfMYDb0Bp7tw8WKU55Q0DHPgjCcg==
X-Received: by 2002:a17:903:2093:: with SMTP id
 d19mr6880836plc.29.1643349365189; 
 Thu, 27 Jan 2022 21:56:05 -0800 (PST)
Received: from [10.72.13.185] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id d22sm960881pfl.71.2022.01.27.21.55.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 27 Jan 2022 21:56:04 -0800 (PST)
Message-ID: <345cd684-0cc2-a685-0611-e2fcf0dfc52b@redhat.com>
Date: Fri, 28 Jan 2022 13:55:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.5.0
Subject: Re: [PATCH 21/31] util: Add iova_tree_alloc
To: Peter Xu <peterx@redhat.com>, Eugenio Perez Martin <eperezma@redhat.com>
References: <20220121202733.404989-1-eperezma@redhat.com>
 <20220121202733.404989-22-eperezma@redhat.com> <Ye4r7tKFhP9VaT5/@xz-m1.local>
 <CAJaqyWf--wbNZz5ZzbpixD9op_fO5fV01kbYXzG097c_NkqYrw@mail.gmail.com>
 <Ye6IhLCe6NDKO6+E@xz-m1.local>
 <CAJaqyWcdpTr2X4VuAN2NLmpviCjDoAaY269+VQGZ7-F6myOhSw@mail.gmail.com>
 <YfJSezhQv1kXa1x8@xz-m1.local>
 <CAJaqyWczZ7C_vbwugyN9bEgOVuRokGqVMb_g5UK_R4F8O+qKOA@mail.gmail.com>
 <YfNprA3OLUqj8LSG@xz-m1.local>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <YfNprA3OLUqj8LSG@xz-m1.local>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Laurent Vivier <lvivier@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 qemu-level <qemu-devel@nongnu.org>, Gautam Dawar <gdawar@xilinx.com>,
 Markus Armbruster <armbru@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Zhu Lingshan <lingshan.zhu@intel.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Blake <eblake@redhat.com>
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

CuWcqCAyMDIyLzEvMjgg5LiK5Y2IMTE6NTcsIFBldGVyIFh1IOWGmemBkzoKPiBPbiBUaHUsIEph
biAyNywgMjAyMiBhdCAxMDoyNDoyN0FNICswMTAwLCBFdWdlbmlvIFBlcmV6IE1hcnRpbiB3cm90
ZToKPj4gT24gVGh1LCBKYW4gMjcsIDIwMjIgYXQgOTowNiBBTSBQZXRlciBYdSA8cGV0ZXJ4QHJl
ZGhhdC5jb20+IHdyb3RlOgo+Pj4gT24gVHVlLCBKYW4gMjUsIDIwMjIgYXQgMTA6NDA6MDFBTSAr
MDEwMCwgRXVnZW5pbyBQZXJleiBNYXJ0aW4gd3JvdGU6Cj4+Pj4gU28gSSB0aGluayB0aGF0IHRo
ZSBmaXJzdCBzdGVwIHRvIHJlbW92ZSBjb21wbGV4aXR5IGZyb20gdGhlIG9sZCBvbmUKPj4+PiBp
cyB0byByZW1vdmUgaW92YV9iZWdpbiBhbmQgaW92YV9lbmQuCj4+Pj4KPj4+PiBBcyBKYXNvbiBw
b2ludHMgb3V0LCByZW1vdmluZyBpb3ZhX2VuZCBpcyBlYXNpZXIuIEl0IGhhcyB0aGUgZHJhd2Jh
Y2sKPj4+PiBvZiBoYXZpbmcgdG8gdHJhdmVyc2UgYWxsIHRoZSBsaXN0IGJleW9uZCBpb3ZhX2Vu
ZCwgYnV0IGEgd2VsbCBmb3JtZWQKPj4+PiBpb3ZhIHRyZWUgc2hvdWxkIGNvbnRhaW4gbm9uZS4g
SWYgdGhlIGd1ZXN0IGNhbiBtYW5pcHVsYXRlIGl0LCBpdCdzCj4+Pj4gb25seSBodXJ0aW5nIGl0
c2VsZiBhZGRpbmcgbm9kZXMgdG8gaXQuCj4+Pj4KPj4+PiBJdCdzIHBvc3NpYmxlIHRvIGV4dHJh
Y3QgdGhlIGNoZWNrIGZvciBob2xlX3JpZ2h0IChvciB0aGlzIGluIEphc29uJ3MKPj4+PiBwcm9w
b3NhbCkgYXMgYSBzcGVjaWFsIGNhc2UgdG9vLgo+Pj4+Cj4+Pj4gQnV0IHJlbW92aW5nIHRoZSBp
b3ZhX2JlZ2luIHBhcmFtZXRlciBpcyBtb3JlIGNvbXBsaWNhdGVkLiBXZSBjYW5ub3QKPj4+PiBr
bm93IGlmIGl0J3MgYSB2YWxpZCBob2xlIHdpdGhvdXQga25vd2luZyBpb3ZhX2JlZ2luLCBhbmQg
d2UgY2Fubm90Cj4+Pj4gcmVzdW1lIHRyYXZlcnNpbmcuIENvdWxkIHdlIGFzc3VtZSBpb3ZhX2Jl
Z2luIHdpbGwgYWx3YXlzIGJlIDA/IEkKPj4+PiB0aGluayBub3QsIHRoZSB2ZHBhIGRldmljZSBj
YW4gcmV0dXJuIGFueXRoaW5nIHRocm91Z2ggc3lzY2FsbC4KPj4+IEZyYW5rbHkgSSBkb24ndCBr
bm93IHdoYXQncyB0aGUgc3lzY2FsbCB5b3UncmUgdGFsa2luZyBhYm91dCwKPj4gSSBtZWFudCBW
SE9TVF9WRFBBX0dFVF9JT1ZBX1JBTkdFLCB3aGljaCBhbGxvd3MgcWVtdSB0byBrbm93IHRoZSB2
YWxpZAo+PiByYW5nZSBvZiBpb3ZhIGFkZHJlc3Nlcy4gV2UgZ2V0IGEgcGFpciBvZiB1aW50NjRf
dCBmcm9tIGl0LCB0aGF0Cj4+IGluZGljYXRlcyB0aGUgbWluaW11bSBhbmQgbWF4aW11bSBpb3Zh
IGFkZHJlc3MgdGhlIGRldmljZSAob3IgaW9tbXUpCj4+IHN1cHBvcnRzLgo+Pgo+PiBXZSBtdXN0
IGFsbG9jYXRlIGlvdmEgcmFuZ2VzIHdpdGhpbiB0aGF0IGFkZHJlc3MgcmFuZ2UsIHdoaWNoCj4+
IGNvbXBsaWNhdGVzIHRoaXMgYWxnb3JpdGhtIGEgbGl0dGxlIGJpdC4gU2luY2UgdGhlIFNWUSBp
b3ZhIGFkZHJlc3Nlcwo+PiBhcmUgbm90IEdQQSwgcWVtdSBuZWVkcyBleHRyYSBjb2RlIHRvIGJl
IGFibGUgdG8gYWxsb2NhdGUgYW5kIGZyZWUKPj4gdGhlbSwgY3JlYXRpbmcgYSBuZXcgY3VzdG9t
IGlvdmEgYXMuCj4+Cj4+IFBsZWFzZSBsZXQgbWUga25vdyBpZiB5b3Ugd2FudCBtb3JlIGRldGFp
bHMgb3IgaWYgeW91IHByZWZlciBtZSB0bwo+PiBnaXZlIG1vcmUgY29udGV4dCBpbiB0aGUgcGF0
Y2ggbWVzc2FnZS4KPiBUaGF0J3MgZ29vZCBlbm91Z2gsIHRoYW5rcy4KPgo+Pj4gSSBtZWFuIHRo
aXMgb25lOgo+Pj4KPj4+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2ZWwvMjAyMTEw
MjkxODM1MjUuMTc3NjQxNi0yNC1lcGVyZXptYUByZWRoYXQuY29tLwo+Pj4KPj4+IFRob3VnaCB0
aGlzIHRpbWUgSSBoYXZlIHNvbWUgY29tbWVudHMgb24gdGhlIGRldGFpbHMuCj4+Pgo+Pj4gUGVy
c29uYWxseSBJIGxpa2UgdGhhdCBvbmUgKHByb2JhYmx5IHdpdGggc29tZSBhbWVuZG1lbnQgdXBv
biB0aGUgb2xkIHZlcnNpb24pCj4+PiBtb3JlIHRoYW4gdGhlIGN1cnJlbnQgbGlzdC1iYXNlZCBh
cHByb2FjaC4gIEJ1dCBJJ2QgbGlrZSB0byBrbm93IHlvdXIgdGhvdWdodHMKPj4+IHRvbyAoaW5j
bHVkaW5nIEphc29uKS4gIEknbGwgZnVydGhlciBjb21tZW50IGluIHRoYXQgdGhyZWFkIHNvb24u
Cj4+Pgo+PiBTdXJlLCBJJ20gZmluZSB3aXRoIHdoYXRldmVyIHNvbHV0aW9uIHdlIGNob29zZSwg
YnV0IEknbSBqdXN0IHJ1bm5pbmcKPj4gb3V0IG9mIGlkZWFzIHRvIHNpbXBsaWZ5IGl0LiBSZWFk
aW5nIHlvdXIgc3VnZ2VzdGlvbnMgb24gb2xkIFJGQyBub3cuCj4+Cj4+IE92ZXJhbGwgSSBmZWVs
IGxpc3QtYmFzZWQgb25lIGlzIGJvdGggbW9yZSBjb252ZW5pZW50IGFuZCBlYXN5IHRvCj4+IGRl
bGV0ZSB3aGVuIHFlbXUgcmFpc2VzIHRoZSBtaW5pbWFsIGdsaWIgdmVyc2lvbiwgYnV0IGl0IGFk
ZHMgYSBsb3QKPj4gbW9yZSBjb2RlLgo+Pgo+PiBJdCBjb3VsZCBhZGQgbGVzcyBjb2RlIHdpdGgg
dGhpcyBsZXNzIGVsZWdhbnQgY2hhbmdlczoKPj4gKiBJZiB3ZSBqdXN0IHB1dCB0aGUgbGlzdCBl
bnRyeSBpbiB0aGUgRE1BTWFwIGl0c2VsZiwgYWx0aG91Z2ggaXQKPj4gZXhwb3NlcyB1bm5lZWRl
ZCBpbXBsZW1lbnRhdGlvbiBkZXRhaWxzLgo+PiAqIFdlIGZvcmNlIHRoZSBpb3ZhIHRyZWUgZWl0
aGVyIHRvIGJlIGFuIGFsbG9jYXRpb24tYmFzZWQgb3IgYW4KPj4gaW5zZXJ0aW9uLWJhc2VkLCBi
dXQgbm90IGJvdGguIEluIG90aGVyIHdvcmRzLCB5b3UgY2FuIG9ubHkgZWl0aGVyIHVzZQo+PiBp
b3ZhX3RyZWVfYWxsb2Mgb3IgaW92YV90cmVlX2luc2VydCBvbiB0aGUgc2FtZSB0cmVlLgoKClRo
aXMgc2VlbXMgYW4gb2RkIEFQSSBJIG11c3Qgc2F5IDooCgoKPiBZZWFoLCBJIGp1c3Qgbm90aWNl
ZCBpdCB5ZXN0ZXJkYXkgdGhhdCB0aGVyZSdzIG5vIGVhc3kgY2hvaWNlIG9uIGl0LiAgTGV0J3Mg
Z28KPiB3aXRoIGVpdGhlciB3YXk7IGl0IHNob3VsZG4ndCBibG9jayB0aGUgcmVzdCBvZiB0aGUg
Y29kZS4gIEl0J2xsIGJlIGdvb2QgaWYKPiBKYXNvbiBvciBNaWNoYWVsIHNoYXJlIHRoZWlyIHBy
ZWZlcmVuY2VzIHRvby4KCgooSGF2bmUndCBnb25lIHRocm91Z2ggdGhlIGNvZGUgZGVlcGx5KQoK
SSB3b25kZXIgaG93IGFib3V0IGp1c3QgY29weS1wYXN0ZSBndHJlZV9ub2RlX2ZpcnN0fGxhc3Qo
KT8gQSBxdWljayAKZ29vZ2xlIHRvbGQgbWUgaXQncyBub3QgY29tcGxpY2F0ZWQuCgpUaGFua3MK
Cgo+Cj4+IEkgaGF2ZSBhIGZldyB0ZXN0cyB0byBjaGVjayB0aGUgYWxnb3JpdGhtcywgYnV0IHRo
ZXkgYXJlIG5vdCBpbiB0aGUKPj4gcWVtdSB0ZXN0IGZvcm1hdC4gSSB3aWxsIHBvc3QgdGhlbSBz
byB3ZSBhbGwgY2FuIHVuZGVyc3RhbmQgYmV0dGVyCj4+IHdoYXQgaXMgZXhwZWN0ZWQgZnJvbSB0
aGlzLgo+IFN1cmUuICBUaGFua3MuCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
