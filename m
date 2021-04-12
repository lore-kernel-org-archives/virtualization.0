Return-Path: <SRS0=TAdK=JJ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 024C6C43460
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 14:04:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 990976128E
	for <virtualization@archiver.kernel.org>; Mon, 12 Apr 2021 14:04:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 990976128E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 66E626062C;
	Mon, 12 Apr 2021 14:04:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id subJ_bqpRp4s; Mon, 12 Apr 2021 14:04:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id C8E4460A87;
	Mon, 12 Apr 2021 14:04:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8185DC000B;
	Mon, 12 Apr 2021 14:04:47 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D9BCC000A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 14:04:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7BBD660A87
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 14:04:45 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kh4axvMhnq3L
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 14:04:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 92B856060B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 14:04:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618236283;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Milm+ZpD4p8fQX5ep4YA+mBfvp9QBbTbvO+DYpJDU18=;
 b=QApx9zMpxQphojcnVWrGS5rND3FClHooSZx3foLeSmCFdS/LgpiF2NcvW/iKCXYJUekwK7
 5BszUvbFCln+aGP7qYrBL14ztLgIn098UJNJIAaRgO+rgEe9PSDeolmVvA16B2VqvqSpYw
 PIjqZkacDfH2jl4UOfoBCvYidhnruUo=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-545-b2c8WA6YPByWW8-Xb9UehA-1; Mon, 12 Apr 2021 10:04:41 -0400
X-MC-Unique: b2c8WA6YPByWW8-Xb9UehA-1
Received: by mail-ed1-f70.google.com with SMTP id dj13so3286891edb.14
 for <virtualization@lists.linux-foundation.org>;
 Mon, 12 Apr 2021 07:04:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Milm+ZpD4p8fQX5ep4YA+mBfvp9QBbTbvO+DYpJDU18=;
 b=fthDd+RBpdeTkA3A4NngUm5CN/+xxWXIM1Qck3NhjtWoD+n330Q4elEQLmG4G1mbFO
 B3Niz513fnq0e6jhoOxHRZgzECK+3u0c6YeK8UuFqFD7GO0XOpQdyQ0MwCi0nEw1OSPr
 tYE/fEJ0Qum2VaIhAqkxzD88u3L6T6aAgV5JjjiO2SyWSEkY5l956ZkzWWGWVFdmkgSV
 Rv9mnA3RkYxKZrn0nwUJWHb3Qb1NfDGa+1MdWDIfFYfNCS2175g9i91ASxvvqAQq73Nc
 FyJ6hKnnGrmLYRubl2tTMUX+RdJ+7ZQaCNAGKDJ+QTapigiCLwHtjDfzqCi23wfN4VBM
 dC9g==
X-Gm-Message-State: AOAM530MAEirHp7sy/qfWapz6V7Rshx0kyikn3MxEZzwbkcKwJxrYPI5
 8u89+0/0DskS4CRaLaUlxLkpV1OvUNxRZ65wzB3jcHgHTmeswaFd4M29+3kFC2NZqRToEkT8Mte
 D9Msg8FFNTARK42zKZkR6yUdDsy5GPyXGsEXGflBCFA==
X-Received: by 2002:a17:907:367:: with SMTP id
 rs7mr13497902ejb.468.1618236280399; 
 Mon, 12 Apr 2021 07:04:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxAO03nKUgqVdQNXtykFitW8Mn5GTR/gCbYmSlRkP2aDoipwEngT50nePILvx+KJFTgeG/aKA==
X-Received: by 2002:a17:907:367:: with SMTP id
 rs7mr13497872ejb.468.1618236280127; 
 Mon, 12 Apr 2021 07:04:40 -0700 (PDT)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id h3sm6860322edv.80.2021.04.12.07.04.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 12 Apr 2021 07:04:39 -0700 (PDT)
Date: Mon, 12 Apr 2021 16:04:37 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Jiang Wang ." <jiang.wang@bytedance.com>,
 Jorgen Hansen <jhansen@vmware.com>
Subject: Re: [External] Re: [RFC] vsock: add multiple transports support for
 dgram
Message-ID: <20210412140437.6k3zxw2cv4p54lvm@steredhat>
References: <20210406183112.1150657-1-jiang.wang@bytedance.com>
 <1D46A084-5B77-4803-8B5F-B2F36541DA10@vmware.com>
 <CAP_N_Z-KFUYZc7p1z_-9nb9CvjtyGFkgkX1PEbh-SgKbX_snQw@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAP_N_Z-KFUYZc7p1z_-9nb9CvjtyGFkgkX1PEbh-SgKbX_snQw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "cong.wang@bytedance.com" <cong.wang@bytedance.com>,
 "duanxiongchun@bytedance.com" <duanxiongchun@bytedance.com>,
 Andra Paraschiv <andraprs@amazon.com>,
 "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "xieyongji@bytedance.com" <xieyongji@bytedance.com>,
 Norbert Slusarek <nslusarek@gmx.net>, Stefan Hajnoczi <stefanha@redhat.com>,
 Colin Ian King <colin.king@canonical.com>, Jakub Kicinski <kuba@kernel.org>,
 "David S. Miller" <davem@davemloft.net>,
 Alexander Popov <alex.popov@linux.com>
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

SGkgSmlhbmcsCnRoYW5rcyBmb3IgcmUtc3RhcnRpbmcgdGhlIG11bHRpLXRyYW5zcG9ydCBzdXBw
b3J0IGZvciBkZ3JhbSEKCk9uIFdlZCwgQXByIDA3LCAyMDIxIGF0IDExOjI1OjM2QU0gLTA3MDAs
IEppYW5nIFdhbmcgLiB3cm90ZToKPk9uIFdlZCwgQXByIDcsIDIwMjEgYXQgMjo1MSBBTSBKb3Jn
ZW4gSGFuc2VuIDxqaGFuc2VuQHZtd2FyZS5jb20+IHdyb3RlOgo+Pgo+Pgo+PiA+IE9uIDYgQXBy
IDIwMjEsIGF0IDIwOjMxLCBKaWFuZyBXYW5nIDxqaWFuZy53YW5nQGJ5dGVkYW5jZS5jb20+IHdy
b3RlOgo+PiA+Cj4+ID4gRnJvbTogImppYW5nLndhbmciIDxqaWFuZy53YW5nQGJ5dGVkYW5jZS5j
b20+Cj4+ID4KPj4gPiBDdXJyZW50bHksIG9ubHkgVk1DSSBzdXBwb3J0cyBkZ3JhbSBzb2NrZXRz
LiBUbyBzdXBwb3J0ZWQKPj4gPiBuZXN0ZWQgVk0gdXNlIGNhc2UsIHRoaXMgcGF0Y2ggcmVtb3Zl
cyB0cmFuc3BvcnRfZGdyYW0gYW5kCj4+ID4gdXNlcyB0cmFuc3BvcnRfZzJoIGFuZCB0cmFuc3Bv
cnRfaDJnIGZvciBkZ3JhbSB0b28uCgpJIGFncmVlIG9uIHRoaXMgcGFydCwgSSB0aGluayB0aGF0
J3MgdGhlIGRpcmVjdGlvbiB0byBnby4gIAp0cmFuc3BvcnRfZGdyYW0gd2FzIGFkZGVkIGFzIGEg
c2hvcnRjdXQuCgo+Pgo+PiBDb3VsZCB5b3UgcHJvdmlkZSBzb21lIGJhY2tncm91bmQgZm9yIGlu
dHJvZHVjaW5nIHRoaXMgY2hhbmdlIC0gYXJlIHlvdQo+PiBsb29raW5nIGF0IGludHJvZHVjaW5n
IGRhdGFncmFtcyBmb3IgYSBkaWZmZXJlbnQgdHJhbnNwb3J0PyBWTUNJIGRhdGFncmFtcwo+PiBh
bHJlYWR5IHN1cHBvcnQgdGhlIG5lc3RlZCB1c2UgY2FzZSwKPgo+WWVzLCBJIGFtIHRyeWluZyB0
byBpbnRyb2R1Y2UgZGF0YWdyYW0gZm9yIHZpcnRpbyB0cmFuc3BvcnQuIEkgd3JvdGUgYQo+c3Bl
YyBwYXRjaCBmb3IKPnZpcnRpbyBkZ3JhbSBzdXBwb3J0IGFuZCBhbHNvIGEgY29kZSBwYXRjaCwg
YnV0IHRoZSBjb2RlIHBhdGNoIGlzIHN0aWxsIFdJUC4KPldoZW4gSSB3cm90ZSB0aGlzIGNvbW1p
dCBtZXNzYWdlLCBJIHdhcyB0aGlua2luZyBuZXN0ZWQgVk0gaXMgdGhlIHNhbWUgYXMKPm11bHRp
cGxlIHRyYW5zcG9ydCBzdXBwb3J0LiBCdXQgbm93LCBJIHJlYWxpemUgdGhleSBhcmUgZGlmZmVy
ZW50Lgo+TmVzdGVkIFZNcyBtYXkgdXNlCj50aGUgc2FtZSB2aXJ0dWFsaXphdGlvbiBsYXllcihL
Vk0gb24gS1ZNKSwgb3IgZGlmZmVyZW50IHZpcnR1YWxpemF0aW9uIGxheWVycwo+KEtWTSBvbiBF
U1hpKS4gVGhhbmtzIGZvciBsZXR0aW5nIG1lIGtub3cgdGhhdCBWTUNJIGFscmVhZHkgc3VwcG9y
dGVkIG5lc3RlZAo+dXNlIGNhc2VzLiBJIHRoaW5rIHlvdSBtZWFuIFZNQ0kgb24gVk1DSSwgcmln
aHQ/Cj4KPj4gYnV0IGlmIHdlIG5lZWQgdG8gc3VwcG9ydCBtdWx0aXBsZSBkYXRhZ3JhbQo+PiB0
cmFuc3BvcnRzIHdlIG5lZWQgdG8gcmV3b3JrIGhvdyB3ZSBhZG1pbmlzdGVyIHBvcnQgYXNzaWdu
bWVudCBmb3IgZGF0YWdyYW1zLgo+PiBPbmUgc3BlY2lmaWMgaXNzdWUgaXMgdGhhdCB0aGUgdm1j
aSB0cmFuc3BvcnQgd29u4oCZdCByZWNlaXZlIGFueSBkYXRhZ3JhbXMgZm9yIGEKPj4gcG9ydCB1
bmxlc3MgdGhlIGRhdGFncmFtIHNvY2tldCBoYXMgYWxyZWFkeSBiZWVuIGFzc2lnbmVkIHRoZSB2
bWNpIHRyYW5zcG9ydAo+PiBhbmQgdGhlIHBvcnQgYm91bmQgdG8gdGhlIHVuZGVybHlpbmcgVk1D
SSBkZXZpY2UgKHNlZSBiZWxvdyBmb3IgbW9yZSBkZXRhaWxzKS4KPj4KPkkgc2VlLgo+Cj4+ID4g
VGhlIHRyYW5zcG9ydCBpcyBhc3NnaW5lZCB3aGVuIHNlbmRpbmcgZXZlcnkgcGFja2V0IGFuZAo+
PiA+IHJlY2VpdmluZyBldmVyeSBwYWNrZXQgb24gZGdyYW0gc29ja2V0cy4KPj4KPj4gSXMgdGhl
IGludGVudCB0aGF0IHRoZSBzYW1lIGRhdGFncmFtIHNvY2tldCBjYW4gYmUgdXNlZCBmb3Igc2Vu
ZGluZyBwYWNrZXRzIGJvdGgKPj4gSW4gdGhlIGhvc3QgdG8gZ3Vlc3QsIGFuZCB0aGUgZ3Vlc3Qg
dG8gZGlyZWN0aW9ucz8KPgo+Tm9wZS4gT25lIGRhdGFncmFtIHNvY2tldCB3aWxsIG9ubHkgc2Vu
ZCBwYWNrZXRzIHRvIG9uZSBkaXJlY3Rpb24sIGVpdGhlciB0byB0aGUKPmhvc3Qgb3IgdG8gdGhl
IGd1ZXN0LiBNeSBhYm92ZSBkZXNjcmlwdGlvbiBpcyB3cm9uZy4gV2hlbiBzZW5kaW5nIHBhY2tl
dHMsIHRoZQo+dHJhbnNwb3J0IGlzIGFzc2lnbmVkIHdpdGggdGhlIGZpcnN0IHBhY2tldCAod2l0
aCBhdXRvX2JpbmQpLgoKSSdtIG5vdCBzdXJlIHRoaXMgaXMgcmlnaHQuClRoZSBhdXRvX2JpbmQg
b24gdGhlIGZpcnN0IHBhY2tldCBzaG91bGQgb25seSBhc3NpZ24gYSBsb2NhbCBwb3J0IHRvIHRo
ZSAKc29ja2V0LCBidXQgZG9lcyBub3QgYWZmZWN0IHRoZSB0cmFuc3BvcnQgdG8gYmUgdXNlZC4K
CkEgdXNlciBjb3VsZCBzZW5kIG9uZSBwYWNrZXQgdG8gdGhlIG5lc3RlZCBndWVzdCBhbmQgYW5v
dGhlciB0byB0aGUgaG9zdCAKdXNpbmcgdGhlIHNhbWUgc29ja2V0LCBvciBhbSBJIHdyb25nPwoK
Pgo+VGhlIHByb2JsZW0gaXMgd2hlbiByZWNlaXZpbmcgcGFja2V0cy4gVGhlIGxpc3RlbmVyIGNh
biBiaW5kIHRvIHRoZQo+Vk1BRERSX0NJRF9BTlkKPmFkZHJlc3MuIFRoZW4gaXQgaXMgdW5jbGVh
ciB3aGljaCB0cmFuc3BvcnQgd2Ugc2hvdWxkIHVzZS4gRm9yIHN0cmVhbQo+c29ja2V0cywgdGhl
cmUgd2lsbCBiZSBhIG5ldyBzb2NrZXQgZm9yIGVhY2ggY29ubmVjdGlvbiwgYW5kIHRyYW5zcG9y
dAo+Y2FuIGJlIGRlY2lkZWQKPmF0IHRoYXQgdGltZS4gRm9yIGRhdGFncmFtIHNvY2tldHMsIEkg
YW0gbm90IHN1cmUgaG93IHRvIGhhbmRsZSB0aGF0LgoKeWVzLCB0aGlzIEkgdGhpbmsgaXMgdGhl
IG1haW4gcHJvYmxlbSwgYnV0IG1heWJlIHRoZSBzZW5kZXIgb25lIGlzIGV2ZW4gCm1vcmUgY29t
cGxpY2F0ZWQuCgpNYXliZSB3ZSBzaG91bGQgcmVtb3ZlIHRoZSAxOjEgYXNzb2NpYXRpb24gd2Ug
aGF2ZSBub3cgYmV0d2VlbiB2c2sgYW5kIAp0cmFuc3BvcnQuCgpBdCBsZWFzdCBmb3IgREdSQU0s
IGZvciBjb25uZWN0ZWQgc29ja2V0cyBJIHRoaW5rIHRoZSBhc3NvY2lhdGlvbiBtYWtlcyAKc2Vu
c2UuCgo+Rm9yIFZNQ0ksIGRvZXMgdGhlIHNhbWUgdHJhbnNwb3J0IGNhbiBiZSB1c2VkIGZvciBi
b3RoIHJlY2VpdmluZyBmcm9tCj5ob3N0IGFuZCBmcm9tCj50aGUgZ3Vlc3Q/CgpZZXMsIHRoZXkn
cmUgcmVnaXN0ZXJlZCBhdCBkaWZmZXJlbnQgdGltZXMsIGJ1dCBpdCdzIHRoZSBzYW1lIHRyYW5z
cG9ydC4KCj4KPkZvciB2aXJ0aW8sIHRoZSBoMmcgYW5kIGcyaCB0cmFuc3BvcnRzIGFyZSBkaWZm
ZXJlbnQsLCBzbyB3ZSBoYXZlIHRvIAo+Y2hvb3NlCj5vbmUgb2YgdGhlbS4gTXkgb3JpZ2luYWwg
dGhvdWdodCBpcyB0byB3YWl0IHVudGlsIHRoZSBmaXJzdCBwYWNrZXQgCj5hcnJpdmVzLgo+Cj5B
bm90aGVyIGlkZWEgaXMgdGhhdCB3ZSBhbHdheXMgYmluZCB0byBob3N0IGFkZHIgYW5kIHVzZSBo
MmcKPnRyYW5zcG9ydCBiZWNhdXNlIEkgdGhpbmsgdGhhdCBtaWdodAo+YmUgbW9yZSBjb21tb24u
IElmIGEgbGlzdGVuZXIgd2FudHMgdG8gcmVjdiBwYWNrZXRzIGZyb20gdGhlIGhvc3QsIHRoZW4g
Cj5pdAo+c2hvdWxkIGJpbmQgdG8gdGhlIGd1ZXN0IGFkZHIgaW5zdGVhZCBvZiBDSURfQU5ZLgoK
WWVzLCBJIHJlbWVtYmVyIHdlIGRpc2N1c3NlZCB0aGlzIGlkZWEsIHRoaXMgd291bGQgc2ltcGxp
ZnkgdGhlIApyZWNlaXZpbmcsIGJ1dCB0aGVyZSBpcyBzdGlsbCB0aGUgaXNzdWUgb2YgYSB1c2Vy
IHdhbnRpbmcgdG8gcmVjZWl2ZSAKcGFja2V0cyBmcm9tIGJvdGggdGhlIG5lc3RlZCBndWVzdCBh
bmQgdGhlIGhvc3QuCgo+QW55IG90aGVyIHN1Z2dlc3Rpb25zPwo+CgpJIHRoaW5rIG9uZSBzb2x1
dGlvbiBjb3VsZCBiZSB0byByZW1vdmUgdGhlIDE6MSBhc3NvY2lhdGlvbiBiZXR3ZWVuIApER1JB
TSBzb2NrZXQgYW5kIHRyYW5zcG9ydC4KCklJVUMgVk1DSSBjcmVhdGVzIGEgc2tiIGZvciBlYWNo
IHJlY2VpdmVkIHBhY2tldCBhbmQgcXVldWVzIGl0IHRocm91Z2ggCnNrX3JlY2VpdmVfc2tiKCkg
ZGlyZWN0bHkgaW4gdGhlIHN0cnVjdCBzb2NrLgoKVGhlbiB0aGUgLmRncmFtX2RlcXVldWUoKSBj
YWxsYmFjayBkZXF1ZXVlcyB0aGVtIHVzaW5nIApza2JfcmVjdl9kYXRhZ3JhbSgpLgoKV2UgY2Fu
IG1vdmUgdGhlc2UgcGFydHMgaW4gdGhlIHZzb2NrIGNvcmUsIGFuZCBjcmVhdGUgc29tZSBoZWxw
ZXJzIHRvIAphbGxvdyB0aGUgdHJhbnNwb3J0cyB0byBlbnF1ZXVlIHJlY2VpdmVkIERHUkFNIHBh
Y2tldHMgaW4gdGhlIHNhbWUgd2F5IAooYW5kIHdpdGggdGhlIHNhbWUgZm9ybWF0KSBkaXJlY3Rs
eSBpbiB0aGUgc3RydWN0IHNvY2suCgoKV2hhdCBkbyB5b3UgdGhpbms/CgpUaGFua3MsClN0ZWZh
bm8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
