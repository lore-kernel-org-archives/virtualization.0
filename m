Return-Path: <SRS0=15I4=NC=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BBA7CC4338F
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 08:17:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 6E88060F55
	for <virtualization@archiver.kernel.org>; Wed, 11 Aug 2021 08:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 6E88060F55
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2C123402A8;
	Wed, 11 Aug 2021 08:17:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OX5ndxdNY0xb; Wed, 11 Aug 2021 08:17:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8CA26400F1;
	Wed, 11 Aug 2021 08:17:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 682AAC0010;
	Wed, 11 Aug 2021 08:17:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 595E0C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 08:17:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4542840487
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 08:17:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PclNDMZ96rPh
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 08:17:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E482240461
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 08:17:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628669836;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=wNmjID7LH/+1LxWk3TC8KwfEGjzjMfu4p9WimWrIvGQ=;
 b=HmuDP46uA5ff1xf9Zq4qNYvSHvQKI/3qTrg9EeK+OXiZGshhPNubPj/meL3jRLzD+Ls+MA
 G9hRVS3G3tS3064sc3c4szGdrLVk81pRCJIAO+ok3BXkr2iu+EqxewlCrZT32HabnhDpNS
 PaRmlVJ5fjcCPGnS8juyOVtxVI9Y8d4=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-597-m3GuhihmNCeFY4l4AsyFdg-1; Wed, 11 Aug 2021 04:17:14 -0400
X-MC-Unique: m3GuhihmNCeFY4l4AsyFdg-1
Received: by mail-pj1-f70.google.com with SMTP id
 mi10-20020a17090b4b4ab0290178b6d7574aso1814022pjb.6
 for <virtualization@lists.linux-foundation.org>;
 Wed, 11 Aug 2021 01:17:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=wNmjID7LH/+1LxWk3TC8KwfEGjzjMfu4p9WimWrIvGQ=;
 b=N0sA2nm0Ay2b0BvqYxhoX1/UxLytWxdg2EhibdS6g7ff6S9EnOUKYjHhn4rMFDZQhP
 FccgjNmseJk9F48iNHCvkKKApJktlAf2DrL9D/x6efy+9UdKhy/b2sZZIOyG+7k182kD
 H9iHXLZ+cPaFjQR8wtvNKTSgInK+4HaAHKdSYBMVH0cCyHTaUfSIS+BMMO91YWdo2boX
 m5PbRgdyPyJUNwu6ZX2dQ6j1ogEaqXYvs1LInTYVgCwR4qwBz9/EA4oh/2Qi9qQQIQOK
 Y35PFU4vCnKDsP0qXkkv6TpNkCGU/K5zNkMHWoVSEDQQRaaRCvHUJ66zFzQ4YCph6x01
 eSeA==
X-Gm-Message-State: AOAM532zVxnZRSQ02IyxYntdK9gdZjCC4pNcXrbWN5vO9r4ej9CZ7ZEI
 acB8h4TfAi95qXTmgjsLaUCFvoaiwiZO7mjb1jROfiGwWOXfhqq7PpYNXL9dKBy5hmv0iVEvft4
 V5hLw5se/kMX65rYDI8QCFBXscbkdC9ngw8KZ3x3TEQ==
X-Received: by 2002:a63:4f43:: with SMTP id p3mr393873pgl.435.1628669833282;
 Wed, 11 Aug 2021 01:17:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxEuUtn7qU8Bf58IEoC7wUljIjsxXq9LUN1sUuIXDHkYC3+Ud/ZagZ9zuXqdUc9gWgQUIH5hw==
X-Received: by 2002:a63:4f43:: with SMTP id p3mr393855pgl.435.1628669832941;
 Wed, 11 Aug 2021 01:17:12 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id c16sm27117765pfb.196.2021.08.11.01.17.07
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 11 Aug 2021 01:17:12 -0700 (PDT)
Subject: Re: PROBLEM: virtio_net LRO kernel panics
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <CACFia2eUi4KNRC7MYktzUS9Nq2WcBiesX04Tbn2pTuvuGkY4qA@mail.gmail.com>
 <CACFia2dns1rTe5OQj4H-kpurVm2CTtGfAXz0aOUS0_cs0QUrsA@mail.gmail.com>
 <20210727050944-mutt-send-email-mst@kernel.org>
 <CACFia2dLp19pzJsScSvVYREpQm0n6XCWLieWXzA94=OVYVHTbw@mail.gmail.com>
 <20210802154901-mutt-send-email-mst@kernel.org>
 <CACFia2f8xmOwB69Cj+OUNobNSurVnrLrJFdrxnmurww9aSzJMw@mail.gmail.com>
 <20210810112147-mutt-send-email-mst@kernel.org>
 <CACGkMEt94bNsM6e+U6a+H4ZGp5Ss+y=1_fBDUKto5BJXcG_47w@mail.gmail.com>
 <20210811030612-mutt-send-email-mst@kernel.org>
 <847f9477-634f-bf14-967e-38852c82a841@redhat.com>
 <20210811035908-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <230f4c4c-fc9c-8fc6-8ba5-81185da6ea71@redhat.com>
Date: Wed, 11 Aug 2021 16:17:04 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210811035908-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Willem de Bruijn <willemb@google.com>,
 Ivan <ivan@prestigetransportation.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

CuWcqCAyMDIxLzgvMTEg5LiL5Y2INDowMSwgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiBP
biBXZWQsIEF1ZyAxMSwgMjAyMSBhdCAwMzo0NTo0OFBNICswODAwLCBKYXNvbiBXYW5nIHdyb3Rl
Ogo+PiDlnKggMjAyMS84LzExIOS4i+WNiDM6MzksIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6
Cj4+PiBPbiBXZWQsIEF1ZyAxMSwgMjAyMSBhdCAxMTozODo1OUFNICswODAwLCBKYXNvbiBXYW5n
IHdyb3RlOgo+Pj4+IE9uIFR1ZSwgQXVnIDEwLCAyMDIxIGF0IDExOjMxIFBNIE1pY2hhZWwgUy4g
VHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+PiBPbiBNb24sIEF1ZyAwMiwgMjAy
MSBhdCAwNDoyMzoxMlBNIC0wNTAwLCBJdmFuIHdyb3RlOgo+Pj4+Pj4gT24gTW9uLCBBdWcgMiwg
MjAyMSBhdCAyOjUyIFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3Rl
Ogo+Pj4+Pj4+IE9uIE1vbiwgQXVnIDAyLCAyMDIxIGF0IDAxOjMyOjA1UE0gLTA1MDAsIEl2YW4g
d3JvdGU6Cj4+Pj4+Pj4+IE9uIFR1ZSwgSnVsIDI3LCAyMDIxIGF0IDQ6MTEgQU0gTWljaGFlbCBT
LiBUc2lya2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4+Pj4+PiBPbiBNb24sIEp1bCAy
NiwgMjAyMSBhdCAwNzo0NDo0M1BNIC0wNTAwLCBJdmFuIHdyb3RlOgo+Pj4+Pj4+Pj4+IE9uIFNh
dCwgSnVsIDI0LCAyMDIxIGF0IDExOjE4IFBNIEl2YW4gPGl2YW5AcHJlc3RpZ2V0cmFuc3BvcnRh
dGlvbi5jb20+IHdyb3RlOgo+Pj4+Pj4+Pj4+PiBPbiBTYXQsIEp1bCAyNCwgMjAyMSBhdCA3OjE3
IFBNIEl2YW4gPGl2YW5AcHJlc3RpZ2V0cmFuc3BvcnRhdGlvbi5jb20+IHdyb3RlOgo+Pj4+Pj4+
Pj4+Pj4gT24gRnJpLCBKdWwgMjMsIDIwMjEgYXQgNzozMyBBTSBJdmFuIDxpdmFuQHByZXN0aWdl
dHJhbnNwb3J0YXRpb24uY29tPiB3cm90ZToKPj4+Pj4+Pj4+Pj4+PiBPbiBGcmksIEp1bCAyMywg
MjAyMSBhdCA3OjEwIEFNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3Rl
Ogo+Pj4+Pj4+Pj4+Pj4+PiBPbiBGcmksIEp1bCAyMywgMjAyMSBhdCAwMzowNjowNEFNIC0wNTAw
LCBJdmFuIHdyb3RlOgo+Pj4+Pj4+Pj4+Pj4+Pj4gT24gRnJpLCBKdWwgMjMsIDIwMjEgYXQgMjo1
OSBBTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4+Pj4+
Pj4+Pj4+PiBPbiBUaHUsIEp1bCAyMiwgMjAyMSBhdCAxMTo1MDoxMVBNIC0wNTAwLCBJdmFuIHdy
b3RlOgo+Pj4+Pj4+Pj4+Pj4+Pj4+PiBPbiBUaHUsIEp1bCAyMiwgMjAyMSBhdCAxMToyNSBQTSBK
YXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+
IOWcqCAyMDIxLzcvMjMg5LiK5Y2IMTA6NTQsIEl2YW4g5YaZ6YGTOgo+Pj4+Pj4+Pj4+Pj4+Pj4+
Pj4+IE9uIFRodSwgSnVsIDIyLCAyMDIxIGF0IDk6MzcgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4+IERvZXMgaXQgd29yayBpZiB5
b3UgdHVybiBvZmYgbHJvIGJlZm9yZSBlbmFibGluZyB0aGUgZm9yd2FyZGluZz8KPj4+Pj4+Pj4+
Pj4+Pj4+Pj4+PiAwIHJvb3RATnVSYWlkOn4jIGV0aHRvb2wgLUsgZXRoMCBscm8gb2ZmCj4+Pj4+
Pj4+Pj4+Pj4+Pj4+Pj4gQWN0dWFsIGNoYW5nZXM6Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gcngtbHJv
OiBvbiBbcmVxdWVzdGVkIG9mZl0KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+PiBDb3VsZCBub3QgY2hhbmdl
IGFueSBkZXZpY2UgZmVhdHVyZXMKPj4+Pj4+Pj4+Pj4+Pj4+Pj4+IE9rLCBpdCBsb29rcyBsaWtl
IHRoZSBkZXZpY2UgbWlzc2VzIHRoZSBWSVJUSU9fTkVUX0ZfQ1RSTF9HVUVTVF9PRkZMT0FEUwo+
Pj4+Pj4+Pj4+Pj4+Pj4+Pj4gd2hpY2ggbWFrZXMgaXQgaW1wb3NzaWJsZSB0byBjaGFuZ2UgdGhl
IExSTyBzZXR0aW5nLgo+Pj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4+Pj4+Pj4+IERpZCB5
b3UgdXNlIHFlbXU/IElmIHllcywgd2hhdCdzIHRoZSBxZW11IHZlcnNpb24geW91J3ZlIHVzZWQ/
Cj4+Pj4+Pj4+Pj4+Pj4+Pj4+IFRoZXNlIGFyZSBWaXJ0dWFsQm94IG1hY2hpbmVzLCB3aGljaCBJ
J3ZlIGJlZW4gdXNpbmcgZm9yIHllYXJzIHdpdGgKPj4+Pj4+Pj4+Pj4+Pj4+Pj4gbG9uZ3Rlcm0g
a2VybmVscyA0LjE5LCBhbmQgSSBuZXZlciBoYWQgc3VjaCBhIHByb2JsZW0uICBCdXQgbm93IHRo
YXQgSQo+Pj4+Pj4+Pj4+Pj4+Pj4+PiB0cmllZCB1cGdyYWRpbmcgdG8ga2VybmVscyA1LjEwIG9y
IDUuMTMgLS0gdGhlIHBhbmljcyBzdGFydGVkLiAgVGhlc2UKPj4+Pj4+Pj4+Pj4+Pj4+Pj4gYXJl
IGp1c3QgZ2VuZXJpYyBrZXJuZWwgYnVpbGRzLCBhbmQgYSBtaW5pbWFsaXN0aWMgdXNlcnNwYWNl
Lgo+Pj4+Pj4+Pj4+Pj4+Pj4+IEkgd291bGQgYmUgdXNlZnVsIHRvIHNlZSB0aGUgZmVhdHVyZXMg
eW91ciB2aXJ0dWFsYm94IGluc3RhbmNlIHByb3ZpZGVzCj4+Pj4+Pj4+Pj4+Pj4+Pj4KPj4+Pj4+
Pj4+Pj4+Pj4+PiBjYXQgL3N5cy9jbGFzcy9uZXQvZXRoMC9kZXZpY2UvZmVhdHVyZXMKPj4+Pj4+
Pj4+Pj4+Pj4+ICMgY2F0IC9zeXMvY2xhc3MvbmV0L2V0aDAvZGV2aWNlL2ZlYXR1cmVzCj4+Pj4+
Pj4+Pj4+Pj4+PiAxMTAwMDEwMTEwMTExMDExMTExMTAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MDAwMDAwMDAwMDAwMDAwMDAwCj4+Pj4+Pj4+Pj4+Pj4+IEkgd2FzIGFibGUgdG8gcmVwcm9kdWNl
IHRoZSB3YXJuaW5nIGJ1dCBub3QgdGhlIHBhbmljLgo+Pj4+Pj4+Pj4+Pj4+PiBPVE9IIGlmIExS
TyBzdGF5cyBvbiB3aGVuIGVuYWJsaW5nIGZvcndhcmRpbmcgdGhhdAo+Pj4+Pj4+Pj4+Pj4+PiBp
cyBhbHJlYWR5IGEgcHJvYmxlbS4gQW55IGNoYW5jZSB5b3UgY2FuIGJpc2VjdCB0bwo+Pj4+Pj4+
Pj4+Pj4+PiBmaW5kIG91dCB3aGljaCBjaGFuZ2UgaW50cm9kdWNlZCB0aGUgcGFuaWM/Cj4+Pj4+
Pj4+Pj4+Pj4gQW55IGtlcm5lbHMgdXAgdG8gNC4xOS4xOTggZG9uJ3QgcGFuaWMuCj4+Pj4+Pj4+
Pj4+Pj4gQW55IGtlcm5lbHMgNS4xMCsgcGFuaWMgaW1tZWRpYXRlbHkgdXBvbiBzdGFydGluZyBm
b3J3YXJkaW5nLgo+Pj4+Pj4+Pj4+Pj4+IEkgaGF2ZSBub3QgdGVzdGVkIGFueSBrZXJuZWxzIGJl
dHdlZW4gNC4xOSBhbmQgNS4xMC4KPj4+Pj4+Pj4+Pj4+PiBJIGd1ZXNzIEkgY2FuIGJ1aWxkIGEg
ZmV3IGtlcm5lbHMgaW5iZXR3ZWVuLCBhbmQgdHJ5IHBpbnBvaW50IHdoZXJlIGl0IHN0YXJ0cy4K
Pj4+Pj4+Pj4+Pj4+PiBUaGF0IG1heSB0YWtlIGEgZGF5IG9yIHNvLiAgSSdsbCBnZXQgb24gd2l0
aCBpdCBub3csIGFuZCByZXBvcnQgbXkgZmluZGluZ3MuCj4+Pj4+Pj4+Pj4+PiBTbywgSSBuYXJy
b3dlZCAgaXQgZG93bjogdGhlIHBhbmljcyBzdGFydCB3aXRoIGtlcm5lbCA1LjAtcmMuCj4+Pj4+
Pj4+Pj4+IE1vcmUgbmFyb3dseSwgdGhlIHByb2JsZW0gc2VlbXMgYmUgY29taW5nIGZyb20gY29t
bWl0Cj4+Pj4+Pj4+Pj4+IGEwMmU4OTY0ZWFmOTI3MWE4YTVmY2MwYzU1YmQxM2Y5MzNiYWZjNTYu
Cj4+Pj4+Pj4+Pj4+IEp1c3QgdG8gdGVzdCBteSBzdXNwaWNpb24sIEkgZGVsZXRlZCBhIGZldyBs
aW5lcyBmcm9tIHRoYXQgY29kZSwKPj4+Pj4+Pj4+Pj4gYW5kIHRoZSBwYW5pYyB3ZW50IGF3YXku
ICBIb3BlIHRoYXQgaGVscHMgeW91IGd1eXMgZmlndXJlIG91dAo+Pj4+Pj4+Pj4+PiB3aGF0IHRo
ZSBwcm9ibGVtIG1pZ2h0IGJlLgo+Pj4+Pj4+Pj4gV2VsbCBpdCBkaXNhYmxlcyBMUk8gYnV0IHdl
IGtuZXcgdGhpcyA6KCBJJ2QgaGVscCBpZiB3ZSBrbmV3Cj4+Pj4+Pj4+PiB3aGVyZSBkb2VzIGl0
IHBhbmljLCBhbGwgd2Ugc2VlIGl0IHRoZSB3YXJuaW5nIHdoaWNoIGlzCj4+Pj4+Pj4+PiByZWxh
dGVkIGZvciBzdXJlIGJ1dCBub3QgdGhlIGltbWVkaWF0ZSByb290Y2F1c2UgLi4uCj4+Pj4+Pj4+
Pgo+Pj4+Pj4+Pj4+PiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4+Pj4+Pj4+Pj4g
KysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+Pj4+Pj4+Pj4+IEBAIC0yOTc4LDExICsy
OTc4LDYgQEAKPj4+Pj4+Pj4+Pj4gICAgIH0KPj4+Pj4+Pj4+Pj4gICAgIGlmICh2aXJ0aW9faGFz
X2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9GX0dVRVNUX0NTVU0pKQo+Pj4+Pj4+Pj4+PiAgICAg
ICAgZGV2LT5mZWF0dXJlcyB8PSBORVRJRl9GX1JYQ1NVTTsKPj4+Pj4+Pj4+Pj4gLSBpZiAodmly
dGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9HVUVTVF9UU080KSB8fAo+Pj4+Pj4+
Pj4+PiAtICAgIHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfVFNP
NikpCj4+Pj4+Pj4+Pj4+IC0gICAgZGV2LT5mZWF0dXJlcyB8PSBORVRJRl9GX0xSTzsKPj4+Pj4+
Pj4+Pj4gLSBpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19ORVRfRl9DVFJMX0dV
RVNUX09GRkxPQURTKSkKPj4+Pj4+Pj4+Pj4gLSAgICBkZXYtPmh3X2ZlYXR1cmVzIHw9IE5FVElG
X0ZfTFJPOwo+Pj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+PiAgICAgZGV2LT52bGFuX2ZlYXR1cmVzID0g
ZGV2LT5mZWF0dXJlczsKPj4+Pj4+Pj4+PiBKdXN0IEZZSSwgR29vZ2xlIHR1cm5lZCB1cCB0d28g
c2ltaWxhciBidWcgcmVwb3N0cy4uLgo+Pj4+Pj4+Pj4+IEFwciAxNCwgMjAyMCAtLSBodHRwczov
L2dpdGh1Yi5jb20vY29udGFpbmVycy9wb2RtYW4vaXNzdWVzLzU4MTUKPj4+Pj4+Pj4+PiBPY3Qg
MDkuIDIwMjAgLS0gaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0y
MDk1OTMKPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IElzIHRoZXJlIGFueSBzZW5zaWJsZSB0aGluZyBJ
IGNvdWxkIGRvLCB0ZW1wb3JhcmlseSwgdW50aWwgdGhpcwo+Pj4+Pj4+Pj4+IHByb2JsZW0gaXMg
c29ydGVkIG91dD8KPj4+Pj4+Pj4+PiBPciBhbSBJIHNpbXBseSBzdHVjayB0byBrZXJuZWxzIDQu
MTkgb24gdGhlc2UgbWFjaGluZXMgZm9yIG5vdz8KPj4+Pj4+Pj4+IFNvbWV0aGluZyBsaWtlIHRo
aXMgSSBndWVzczoKPj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gZGlmZiAtLWdpdCBhL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+Pj4+Pj4+
Pj4gaW5kZXggOGE1OGEyZjAxM2FmLi5jYzU5ODIxOTNhNDAgMTAwNjQ0Cj4+Pj4+Pj4+PiAtLS0g
YS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPj4+Pj4+Pj4+ICsrKyBiL2RyaXZlcnMvbmV0L3Zp
cnRpb19uZXQuYwo+Pj4+Pj4+Pj4gQEAgLTMwNjMsNiArMzA2Myw4IEBAIHN0YXRpYyBpbnQgdmly
dG5ldF92YWxpZGF0ZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPj4+Pj4+Pj4+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgX192aXJ0aW9fY2xlYXJfYml0KHZkZXYsIFZJUlRJT19ORVRf
Rl9NVFUpOwo+Pj4+Pj4+Pj4gICAgICAgICAgIH0KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiArICAgICAg
IF9fdmlydGlvX2NsZWFyX2JpdCh2ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1RfVFNPNCk7Cj4+Pj4+
Pj4+PiArICAgICAgIF9fdmlydGlvX2NsZWFyX2JpdCh2ZGV2LCBWSVJUSU9fTkVUX0ZfR1VFU1Rf
VFNPNik7Cj4+Pj4+Pj4+PiAgICAgICAgICAgcmV0dXJuIDA7Cj4+Pj4+Pj4+PiAgICB9Cj4+Pj4+
Pj4+IFdoZW4gSSBhcHBseSB5b3VyIHBhdGNoLCB0aGVuIEkgc2VlIGRyYXN0aWMgKG1vcmUgdGhh
biBoYWxmKQo+Pj4+Pj4+PiByZWR1Y3Rpb25zIGluIHNwZWVkLiAoY29uZmlybWVkIHdpdGggaXBl
cmYpLgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBCdXQgaWYgaW5zdGVhZCBJIGp1c3QgcmVtb3ZlIGEgZmV3
IGxpbmVzIGZyb20gY29tbWl0Cj4+Pj4+Pj4+IGEwMmU4OTY0ZWFmOTI3MWE4YTVmY2MwYzU1YmQx
M2Y5MzNiYWZjNTYKPj4+Pj4+Pj4gYXMgaW4gbXkgZWFybGllciBwb3N0LCB0aGVuIEknbSBiYWNr
IHRvIGZ1bGwgc3BlZWQKPj4+Pj4+Pj4KPj4+Pj4+Pj4gSSB1bmRlcnN0YW5kIHRoYXQgdGhpcyBp
cyBqdXN0IHRlbXBvcmFyeSB3b3JrYXJvdW5kLCB1bnRpbCB3ZSBmaWd1cmUgdGhpcyBvdXQuCj4+
Pj4+Pj4gT2ggd2VpcmQuIFNvIGl0J3Mgbm90IGFib3V0IGdldHRpbmcgc29tZSB3ZWlyZCBMUk8g
cGFja2V0LiBXZSB3aWxsIGdldCBpdCB3aXRoCj4+Pj4+Pj4gVklSVElPX05FVF9GX0dVRVNUX1RT
TzQgYW55d2F5LiBJdCdzIGFib3V0IHRoZSBMUk8gZmxhZyBiZWluZyBzZXQgaW4KPj4+Pj4+PiBm
ZWF0dXJlcy4KPj4+Pj4+Pgo+Pj4+Pj4+IEhvdyBhYm91dCB0aGlzIHRoZW4/IEp1c3QgcHJldGVu
ZCB0byBMaW51eCB0aGF0IHdlIGRpc2FibGVkIExSTy4KPj4+Pj4+Pgo+Pj4+Pj4+Cj4+Pj4+Pj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRp
b19uZXQuYwo+Pj4+Pj4+IGluZGV4IDhhNThhMmYwMTNhZi4uOGU3ZTRjZWExNzZiIDEwMDY0NAo+
Pj4+Pj4+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+Pj4+Pj4+ICsrKyBiL2RyaXZl
cnMvbmV0L3ZpcnRpb19uZXQuYwo+Pj4+Pj4+IEBAIC0yNjUxLDggKzI2NTEsOSBAQCBzdGF0aWMg
aW50IHZpcnRuZXRfc2V0X2ZlYXR1cmVzKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYsCj4+Pj4+Pj4g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH5HVUVTVF9PRkZMT0FEX0xST19N
QVNLOwo+Pj4+Pj4+Cj4+Pj4+Pj4gICAgICAgICAgICAgICAgICAgZXJyID0gdmlydG5ldF9zZXRf
Z3Vlc3Rfb2ZmbG9hZHModmksIG9mZmxvYWRzKTsKPj4+Pj4+PiAtICAgICAgICAgICAgICAgaWYg
KGVycikKPj4+Pj4+PiAtICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gZXJyOwo+Pj4+Pj4+
ICsgICAgICAgICAgICAgICBXQVJOX09OKGVycik7Cj4+Pj4+Pj4gKyAgICAgICAgICAgICAgIC8v
aWYgKGVycikKPj4+Pj4+PiArICAgICAgICAgICAgICAgLy8gICAgICByZXR1cm4gZXJyOwo+Pj4+
Pj4+ICAgICAgICAgICAgICAgICAgIHZpLT5ndWVzdF9vZmZsb2FkcyA9IG9mZmxvYWRzOwo+Pj4+
Pj4+ICAgICAgICAgICB9Cj4+Pj4+PiBOby4gV2l0aCB0aGlzIGFwcGxpZWQsIHRoZSBwcm9ibGVt
IHBlcnNpc3RzOgo+Pj4+Pj4KPj4+Pj4+ICMgZWNobyAiMSIgPiAvcHJvYy9zeXMvbmV0L2lwdjQv
aXBfZm9yd2FyZAo+Pj4+Pj4KPj4+Pj4+IGtlcm5lbDogLS0tLS0tLS0tLS0tWyBjdXQgaGVyZSBd
LS0tLS0tLS0tLS0tCj4+Pj4+PiBrZXJuZWw6IG5ldGRldmljZTogZXRoMDogZmFpbGVkIHRvIGRp
c2FibGUgTFJPIQo+Pj4+Pj4ga2VybmVsOiBXQVJOSU5HOiBDUFU6IDAgUElEOiA0NTIgYXQgbmV0
L2NvcmUvZGV2LmM6MTc2OAo+Pj4+Pj4gZGV2X2Rpc2FibGVfbHJvKzB4MTA4LzB4MTUwCj4+Pj4+
PiBrZXJuZWw6IE1vZHVsZXMgbGlua2VkIGluOiBzZyBubHNfaXNvODg1OV8xIG5sc19jcDQzNyB2
ZmF0IGZhdAo+Pj4+Pj4gaGlkX2dlbmVyaWMgdXNiaGlkIGhpZCB2aXJ0aW9fbmV0IG5ldF9mYWls
b3ZlciBmYWlsb3ZlciBhZXNuaV9pbnRlbAo+Pj4+Pj4gbGliYWVzIGNyeXB0b19zaW1kIG9oY2lf
cGNpIGFoY2kgbGliYWhjaSBjcnlwdGQgcmFwbCBlaGNpX3BjaSBvaGNpX2hjZAo+Pj4+Pj4gZWhj
aV9oY2QgdXNiY29yZSB1c2JfY29tbW9uIGxpYmF0YSBldmRldiBscGNfaWNoIG1mZF9jb3JlIHJu
Z19jb3JlCj4+Pj4+PiBpMmNfcGlpeDQgaTJjX2NvcmUgdmlydGlvX3BjaSB2aXJ0aW9fcGNpX21v
ZGVybl9kZXYgdmlydGlvX3JpbmcgdmlydGlvCj4+Pj4+PiBydGNfY21vcyBhdGtiZCBsaWJwczIg
aTgwNDIgc2VyaW8gYmF0dGVyeSBhYyBidXR0b24gbG9vcCB1bml4Cj4+Pj4+PiBrZXJuZWw6IENQ
VTogMCBQSUQ6IDQ1MiBDb21tOiBiYXNoIE5vdCB0YWludGVkIDUuMTMuNy1nbnUuMS1OdU1pbmkg
IzEKPj4+Pj4+IGtlcm5lbDogSGFyZHdhcmUgbmFtZTogaW5ub3RlayBHbWJIIFZpcnR1YWxCb3gv
VmlydHVhbEJveCwgQklPUwo+Pj4+Pj4gVmlydHVhbEJveCAxMi8wMS8yMDA2Cj4+Pj4+PiBrZXJu
ZWw6IFJJUDogMDAxMDpkZXZfZGlzYWJsZV9scm8rMHgxMDgvMHgxNTAKPj4+Pj4gQWdhaW4gdGhl
IHdhcm5pbmcgaXNuJ3QgYSBiaWcgZGVhbC4gSSBhZ3JlZSB3ZSBzaG91bGQgYWRkcmVzcyAtIEph
c29uCj4+Pj4+IGFueSB1cGRhdGU/Cj4+Pj4gSSBzdGlsbCB0aGluayB1c2luZyBORVRJRl9GX0xS
TyBtaWdodCBub3QgYmUgY29ycmVjdC4gU2luY2Ugd2UncmUKPj4+PiBiYXNpY2FsbHkgcmVjZWl2
aW5nIEdTTyBwYWNrZXRzLgo+Pj4+Cj4+Pj4gQW5kIGl0IG1pZ2h0IGNhdXNlIGEgbG90IG9mIGlz
c3VlcyBpZiB0aGUgZGV2aWNlIGRvZXNuJ3QgaGF2ZQo+Pj4+IFZJUlRJT19ORVRfRl9DVFJMX0dV
RVNUX09GRkxPQURTLgo+Pj4+Cj4+Pj4gSSBzZWUgdHdvIHBvc3NpYmxlIGZpeGVzOgo+Pj4+Cj4+
Pj4gMSkgdXNpbmcgTkVUSUZfRl9HUk9fSFcgaW5zdGVhZCAodGhlIHBhdGNoIGlzIGF0dGFjaGVk
KQo+Pj4gSXQncyB1bmZvcnR1bmF0ZSB5b3UgZGlkbid0IGlubGluZS4gQW55d2F5Lgo+Pj4gSXZh
biBjb3VsZCB5b3UgdGVzdCB0aGUgcGF0Y2ggYW5kIHJlcG9ydD8KPj4+Cj4+Pj4gb3IKPj4+IEht
bS4gSSBhbSBub3Qgc3VyZSB3ZSBhbHdheXMgcHJlc2VydmUgdGhlIEdST19IVyByZXF1aXJlbWVu
dCB0aGF0Cj4+PiBwYWNrZXRzIGNhbiBiZSByZS1zZWdtZW50ZWQgdG8gcmVjb25zdHJ1Y3QgdGhl
IG9yaWdpbmFsIHBhY2tldCBzdHJlYW0uCj4+PiBEbyBhbGwgYmFja2VuZHMgZ3VhcmFudGVlIHRo
aXM/Cj4+Cj4+IEkgdGhpbmsgd2UgY2FuJ3QuCj4+Cj4+Cj4+PiBDb3VsZCB5b3UgZXhwbGFpbiB3
aHk/Cj4+Cj4+IE9yIHdlIHByb2JhYmx5IG5lZWQgYW5vdGhlciBuZXcgbmV0ZGV2IGZlYXR1cmUg
bGlrZSByeC1nc28/Cj4+Cj4+Cj4+Pgo+Pj4KPj4+PiAyKSBzZXQgTkVUSUZfRl9MUk8gb25seSBp
ZiB0aGUgZGV2aWNlIGhhcyBDVFJMX0dVRVNUX09GRkxPQURTCj4+Pj4KPj4+PiBUaGFua3MKPj4+
IFRoaXMgb25lIHdvdWxkIHNsb3cgZ3Vlc3RzIG9uIG9sZCBob3N0cyBkb3duIHNpZ25pZmljYW50
bHkuCj4+Cj4+IEFjdHVhbGx5LCBpdCdzIG5vdCB0aGlzIHByb3Bvc2FsIGJ1dCBzZWUgYmVsb3cu
Cj4+Cj4+Cj4+PiBJIGFtIG5vdCBzdXJlIHdoeSB0aGlzIGRpZG4ndCB0cmlnZ2VyIHByZXZpb3Vz
bHkKPj4KPj4gSXQgbG9va3MgdG8gbWUgaXQgd2FzIGNhdXNlZCBieSBhMDJlODk2NGVhZjkyNzFh
OGE1ZmNjMGM1NWJkMTNmOTMzYmFmYzU2Cj4+ICgidmlydGlvLW5ldDogZXRodG9vbCBjb25maWd1
cmFibGUgTFJPIikuCj4+Cj4+IEJlZm9yZSB0aGlzIGNvbW1pdCB3ZSB3b24ndCBldmVuIGFkdmVy
dGlzZSBORVRJRl9GX0xSTywgc28gZGV2X2Rpc2FibGVfbHJvKCkKPj4gd29uJ3Qgd2Fybi4KPj4K
Pj4gQWZ0ZXIgdGhpcyBjb21taXQsIHdlIGFkdmVydGlzZSBMUk8gYW5kIGRldl9kaXNhYmxlX2xy
bygpIHdpbGwgdHJ5IHRvCj4+IGRpc2FibGUgYWxsIGd1ZXN0IG9mZmxvYWRzIHdoaWNoIHdpbGw6
Cj4+Cj4+IDEpIHNsb3cgdGhlIHRyYWZmaWMKPj4KPj4gYW5kCj4+Cj4+IDIpIHdhcm4gaWYgImxy
byIgY2FuJ3QgYmUgZGlzYWJsZWQgb24gdGhlIGRldmljZSB3aXRob3V0IGN0cmwgZ3Vlc3Qgb2Zm
bG9hZHMKPj4gKGUuZyB0aGUgdmlydHVhbGJveCBob3N0KQo+Pgo+PiBUaGFua3MKPiBPSy4gU28g
SSB0aGluayBJIHVuZGVyc3RhbmQgeW91ciBjb21tZW50IG5vdzogR1JPX0hXIG1ha2VzIHNlbnNl
IHNpbXBseQo+IGJlY2F1c2UgaGlzdG9yaWNhbGx5IGJlZm9yZSBhMDJlODk2NGVhZjkyNzFhOGE1
ZmNjMGM1NWJkMTNmOTMzYmFmYzU2IHdlCj4gbmV2ZXIgYWR2ZXJ0aXNlZCBMUk8uCgoKWWVzLgoK
Cj4KPiBDYW4geW91IHBvc3QgYSBwYXRjaCBSRkMgcHJvcGVybHkgc28gSXZhbiBjYW4gdGVzdD8K
CgpEb25lLgoKVGhhbmtzCgoKPgo+Cj4+PiBidHcgLQo+Pj4gd2UgdXNlZCBub3QgdG8gaGF2ZSBD
VFJMX0dVRVNUX09GRkxPQURTIGFmdGVyIGFsbC4KPj4+Cj4+Pgo+Pj4KPj4+Pj4gQnV0IHRoZSBt
YWluIGlzc3VlIGlzIHlvdSBsb3NlIGNvbm5lY3Rpdml0eS4gVGhhdCBzdGlsbAo+Pj4+PiBwZXJz
aXN0cyB3aXRoIHRoaXM/IENhbid0IHlvdSBnZXQgYSBzZXJpYWwgY29ubmVjdGlvbgo+Pj4+PiBv
dXQ/IEkga25vdyBxZW11IERpZCB0aGUga2VybmVsIG9vcHMgYWZ0ZXJ3YXJkcz8KPj4+Pj4KPj4+
Pj4gLS0KPj4+Pj4gTVNUCj4+Pj4+Cj4+PgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
