Return-Path: <SRS0=UCi2=GD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C9CDC433DB
	for <virtualization@archiver.kernel.org>; Thu, 31 Dec 2020 02:50:01 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9ECD820B1F
	for <virtualization@archiver.kernel.org>; Thu, 31 Dec 2020 02:50:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 9ECD820B1F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5875A86A0E;
	Thu, 31 Dec 2020 02:50:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Sqg7DIGgF5hg; Thu, 31 Dec 2020 02:49:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6F5ED86A01;
	Thu, 31 Dec 2020 02:49:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 56864C088B;
	Thu, 31 Dec 2020 02:49:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 22C45C013A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Dec 2020 02:49:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EE0052E0F3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Dec 2020 02:49:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id n25QxFEbfC9S
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Dec 2020 02:49:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 806ED20495
 for <virtualization@lists.linux-foundation.org>;
 Thu, 31 Dec 2020 02:49:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609382992;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=jaBXRn3R6xRNQg/4syGGTAnxznRs8q7smaQWSZzeHto=;
 b=GxasZsPPGYUoOKgBPat+tWoYUIorRH6VqV5t8JJF0u95qN7dp9W/YZXqo2kWcnIGZwNPQQ
 Jzx78Ty0nrvAjr+M3FDh/PwpqicXTlrWdh4yy/JikkSrG8ZxAx1Eb7YZ/64egRmrjnwEiM
 u+c2/eAWHJdOtZcQs6l+j6ttqjeizCs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-Lh-HFYLCMCCg_MhT9L4ufA-1; Wed, 30 Dec 2020 21:49:49 -0500
X-MC-Unique: Lh-HFYLCMCCg_MhT9L4ufA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id B4A4210054FF;
 Thu, 31 Dec 2020 02:49:46 +0000 (UTC)
Received: from [10.72.12.236] (ovpn-12-236.pek2.redhat.com [10.72.12.236])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 25DE572161;
 Thu, 31 Dec 2020 02:49:34 +0000 (UTC)
Subject: Re: [RFC v2 09/13] vduse: Add support for processing vhost iotlb
 message
To: Yongji Xie <xieyongji@bytedance.com>
References: <20201222145221.711-1-xieyongji@bytedance.com>
 <CACycT3s=m=PQb5WFoMGhz8TNGme4+=rmbbBTtrugF9ZmNnWxEw@mail.gmail.com>
 <0e6faf9c-117a-e23c-8d6d-488d0ec37412@redhat.com>
 <CACycT3uwXBYvRbKDWdN3oCekv+o6_Lc=-KTrxejD=fr-zgibGw@mail.gmail.com>
 <2b24398c-e6d9-14ec-2c0d-c303d528e377@redhat.com>
 <CACycT3uDV43ecScrMh1QVpStuwDETHykJzzY=pkmZjP2Dd2kvg@mail.gmail.com>
 <e77c97c5-6bdc-cdd0-62c0-6ff75f6dbdff@redhat.com>
 <CACycT3soQoX5avZiFBLEGBuJpdni6-UxdhAPGpWHBWVf+dEySg@mail.gmail.com>
 <1356137727.40748805.1609233068675.JavaMail.zimbra@redhat.com>
 <CACycT3sg61yRdupnD+jQEkWKsVEvMWfhkJ=5z_bYZLxCibDiHw@mail.gmail.com>
 <b1aef426-29c7-7244-5fc9-56d52e86abb4@redhat.com>
 <CACycT3vZ7V5WWhCFLBK6FuvVNmPmMj_yc=COOB4cjjC13yHUwg@mail.gmail.com>
 <3fc6a132-9fc2-c4e2-7fb1-b5a8bfb771fa@redhat.com>
 <CACycT3tD3zyvV6Zy5NT4x=02hBgrRGq35xeTsRXXx-_wPGJXpQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e0e693c3-1871-a410-c3d5-964518ec939a@redhat.com>
Date: Thu, 31 Dec 2020 10:49:33 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <CACycT3tD3zyvV6Zy5NT4x=02hBgrRGq35xeTsRXXx-_wPGJXpQ@mail.gmail.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: axboe@kernel.dk, corbet@lwn.net, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-aio@kvack.org,
 netdev@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>,
 Matthew Wilcox <willy@infradead.org>,
 virtualization@lists.linux-foundation.org, linux-mm@kvack.org, bcrl@kvack.org,
 viro@zeniv.linux.org.uk, Stefan Hajnoczi <stefanha@redhat.com>,
 linux-fsdevel@vger.kernel.org, akpm@linux-foundation.org
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

Ck9uIDIwMjAvMTIvMzAg5LiL5Y2INjoxMiwgWW9uZ2ppIFhpZSB3cm90ZToKPiBPbiBXZWQsIERl
YyAzMCwgMjAyMCBhdCA0OjQxIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdy
b3RlOgo+Pgo+PiBPbiAyMDIwLzEyLzMwIOS4i+WNiDM6MDksIFlvbmdqaSBYaWUgd3JvdGU6Cj4+
PiBPbiBXZWQsIERlYyAzMCwgMjAyMCBhdCAyOjExIFBNIEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgo+Pj4+IE9uIDIwMjAvMTIvMjkg5LiL5Y2INjoyNiwgWW9uZ2ppIFhp
ZSB3cm90ZToKPj4+Pj4gT24gVHVlLCBEZWMgMjksIDIwMjAgYXQgNToxMSBQTSBKYXNvbiBXYW5n
IDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4+IC0tLS0tIE9yaWdpbmFsIE1lc3Nh
Z2UgLS0tLS0KPj4+Pj4+PiBPbiBNb24sIERlYyAyOCwgMjAyMCBhdCA0OjQzIFBNIEphc29uIFdh
bmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+Pj4+PiBPbiAyMDIwLzEyLzI4IOS4
i+WNiDQ6MTQsIFlvbmdqaSBYaWUgd3JvdGU6Cj4+Pj4+Pj4+Pj4gSSBzZWUuIFNvIGFsbCB0aGUg
YWJvdmUgdHdvIHF1ZXN0aW9ucyBhcmUgYmVjYXVzZSBWSE9TVF9JT1RMQl9JTlZBTElEQVRFCj4+
Pj4+Pj4+Pj4gaXMgZXhwZWN0ZWQgdG8gYmUgc3luY2hyb25vdXMuIFRoaXMgbmVlZCB0byBiZSBz
b2x2ZWQgYnkgdHdlYWtpbmcgdGhlCj4+Pj4+Pj4+Pj4gY3VycmVudCBWRFVTRSBBUEkgb3Igd2Ug
Y2FuIHJlLXZpc2l0IHRvIGdvIHdpdGggZGVzY3JpcHRvcnMgcmVsYXlpbmcKPj4+Pj4+Pj4+PiBm
aXJzdC4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4gQWN0dWFsbHkgYWxsIHZkcGEgcmVsYXRlZCBvcGVy
YXRpb25zIGFyZSBzeW5jaHJvbm91cyBpbiBjdXJyZW50Cj4+Pj4+Pj4+PiBpbXBsZW1lbnRhdGlv
bi4gVGhlIG9wcy5zZXRfbWFwL2RtYV9tYXAvZG1hX3VubWFwIHNob3VsZCBub3QgcmV0dXJuCj4+
Pj4+Pj4+PiB1bnRpbCB0aGUgVkRVU0VfVVBEQVRFX0lPVExCL1ZEVVNFX0lOVkFMSURBVEVfSU9U
TEIgbWVzc2FnZSBpcyByZXBsaWVkCj4+Pj4+Pj4+PiBieSB1c2Vyc3BhY2UuIENvdWxkIGl0IHNv
bHZlIHRoaXMgcHJvYmxlbT8KPj4+Pj4+Pj4gICAgICBJIHdhcyB0aGlua2luZyB3aGV0aGVyIG9y
IG5vdCB3ZSBuZWVkIHRvIGdlbmVyYXRlIElPVExCX0lOVkFMSURBVEUKPj4+Pj4+Pj4gbWVzc2Fn
ZSB0byBWRFVTRSBkdXJpbmcgZG1hX3VubWFwICh2ZHVzZV9kZXZfdW5tYXBfcGFnZSkuCj4+Pj4+
Pj4+Cj4+Pj4+Pj4+IElmIHdlIGRvbid0LCB3ZSdyZSBwcm9iYWJseSBmaW5lLgo+Pj4+Pj4+Pgo+
Pj4+Pj4+IEl0IHNlZW1zIG5vdCBmZWFzaWJsZS4gVGhpcyBtZXNzYWdlIHdpbGwgYmUgYWxzbyB1
c2VkIGluIHRoZQo+Pj4+Pj4+IHZpcnRpby12ZHBhIGNhc2UgdG8gbm90aWZ5IHVzZXJzcGFjZSB0
byB1bm1hcCBzb21lIHBhZ2VzIGR1cmluZwo+Pj4+Pj4+IGNvbnNpc3RlbnQgZG1hIHVubWFwcGlu
Zy4gTWF5YmUgd2UgY2FuIGRvY3VtZW50IGl0IHRvIG1ha2Ugc3VyZSB0aGUKPj4+Pj4+PiB1c2Vy
cyBjYW4gaGFuZGxlIHRoZSBtZXNzYWdlIGNvcnJlY3RseS4KPj4+Pj4+IEp1c3QgdG8gbWFrZSBz
dXJlIEkgdW5kZXJzdGFuZCB5b3VyIHBvaW50Lgo+Pj4+Pj4KPj4+Pj4+IERvIHlvdSBtZWFuIHlv
dSBwbGFuIHRvIG5vdGlmeSB0aGUgdW5tYXAgb2YgMSkgc3RyZWFtaW5nIERNQSBvciAyKQo+Pj4+
Pj4gY29oZXJlbnQgRE1BPwo+Pj4+Pj4KPj4+Pj4+IEZvciAxKSB5b3UgcHJvYmFibHkgbmVlZCBh
IHdvcmtxdWV1ZSB0byBkbyB0aGF0IHNpbmNlIGRtYSB1bm1hcCBjYW4KPj4+Pj4+IGJlIGRvbmUg
aW4gaXJxIG9yIGJoIGNvbnRleHQuIEFuZCBpZiB1c3JzcGFjZSBkb2VzJ3QgZG8gdGhlIHVubWFw
LCBpdAo+Pj4+Pj4gY2FuIHN0aWxsIGFjY2VzcyB0aGUgYm91bmNlIGJ1ZmZlciAoaWYgeW91IGRv
bid0IHphcCBwdGUpPwo+Pj4+Pj4KPj4+Pj4gSSBwbGFuIHRvIGRvIGl0IGluIHRoZSBjb2hlcmVu
dCBETUEgY2FzZS4KPj4+PiBBbnkgcmVhc29uIGZvciB0cmVhdGluZyBjb2hlcmVudCBETUEgZGlm
ZmVyZW50bHk/Cj4+Pj4KPj4+IE5vdyB0aGUgbWVtb3J5IG9mIHRoZSBib3VuY2UgYnVmZmVyIGlz
IGFsbG9jYXRlZCBwYWdlIGJ5IHBhZ2UgaW4gdGhlCj4+PiBwYWdlIGZhdWx0IGhhbmRsZXIuIFNv
IGl0IGNhbid0IGJlIHVzZWQgaW4gY29oZXJlbnQgRE1BIG1hcHBpbmcgY2FzZQo+Pj4gd2hpY2gg
bmVlZHMgc29tZSBtZW1vcnkgd2l0aCBjb250aWd1b3VzIHZpcnR1YWwgYWRkcmVzc2VzLiBJIGNh
biB1c2UKPj4+IHZtYWxsb2MoKSB0byBkbyBhbGxvY2F0aW9uIGZvciB0aGUgYm91bmNlIGJ1ZmZl
ciBpbnN0ZWFkLiBCdXQgaXQgbWlnaHQKPj4+IGNhdXNlIHNvbWUgbWVtb3J5IHdhc3RlLiBBbnkg
c3VnZ2VzdGlvbj8KPj4KPj4gSSBtYXkgbWlzcyBzb21ldGhpbmcuIEJ1dCBJIGRvbid0IHNlZSBh
IHJlbGF0aW9uc2hpcCBiZXR3ZWVuIHRoZQo+PiBJT1RMQl9VTk1BUCBhbmQgdm1hbGxvYygpLgo+
Pgo+IEluIHRoZSB2bWFsbG9jKCkgY2FzZSwgdGhlIGNvaGVyZW50IERNQSBwYWdlIHdpbGwgYmUg
dGFrZW4gZnJvbSB0aGUKPiBtZW1vcnkgYWxsb2NhdGVkIGJ5IHZtYWxsb2MoKS4gU28gSU9UTEJf
VU5NQVAgaXMgbm90IG5lZWRlZCBhbnltb3JlCj4gZHVyaW5nIGNvaGVyZW50IERNQSB1bm1hcHBp
bmcgYmVjYXVzZSB0aG9zZSB2bWFsbG9jJ2VkIG1lbW9yeSB3aGljaAo+IGhhcyBiZWVuIG1hcHBl
ZCBpbnRvIHVzZXJzcGFjZSBhZGRyZXNzIHNwYWNlIGR1cmluZyBpbml0aWFsaXphdGlvbiBjYW4K
PiBiZSByZXVzZWQuIEFuZCB1c2Vyc3BhY2Ugc2hvdWxkIG5vdCB1bm1hcCB0aGUgcmVnaW9uIHVu
dGlsIHdlIGRlc3Ryb3kKPiB0aGUgZGV2aWNlLgoKCkp1c3QgdG8gbWFrZSBzdXJlIEkgdW5kZXJz
dGFuZC4gTXkgdW5kZXJzdGFuZGluZyBpcyB0aGF0IElPVExCX1VOTUFQIGlzIApvbmx5IG5lZWRl
ZCB3aGVuIHRoZXJlJ3MgYSBjaGFuZ2UgdGhlIG1hcHBpbmcgZnJvbSBJT1ZBIHRvIHBhZ2UuCgpT
byBpZiB3ZSBzdGljayB0byB0aGUgbWFwcGluZywgZS5nIGR1cmluZyBkbWFfdW5tYXAsIHdlIGp1
c3QgcHV0IElPVkEgdG8gCmZyZWUgbGlzdCB0byBiZSB1c2VkIGJ5IHRoZSBuZXh0IElPVkEgYWxs
b2NhdGluZy4gSU9UTEJfVU5NQVAgY291bGQgYmUgCmF2b2lkZWQuCgpTbyB3ZSBhcmUgbm90IGxp
bWl0ZWQgYnkgaG93IHRoZSBwYWdlcyBhcmUgYWN0dWFsbHkgYWxsb2NhdGVkPwoKVGhhbmtzCgoK
Pgo+Pj4+PiBJdCdzIHRydWUgdGhhdCB1c2Vyc3BhY2UgY2FuCj4+Pj4+IGFjY2VzcyB0aGUgZG1h
IGJ1ZmZlciBpZiB1c2Vyc3BhY2UgZG9lc24ndCBkbyB0aGUgdW5tYXAuIEJ1dCB0aGUgZG1hCj4+
Pj4+IHBhZ2VzIHdvdWxkIG5vdCBiZSBmcmVlZCBhbmQgcmV1c2VkIHVubGVzcyB1c2VyIHNwYWNl
IGNhbGxlZCBtdW5tYXAoKQo+Pj4+PiBmb3IgdGhlbS4KPj4+PiBJIHdvbmRlciB3aGV0aGVyIG9y
IG5vdCB3ZSBjb3VsZCByZWN5Y2xlIElPVkEgaW4gdGhpcyBjYXNlIHRvIGF2b2lkIHRoZQo+Pj4+
IElPVExCX1VNQVAgbWVzc2FnZS4KPj4+Pgo+Pj4gV2UgY2FuIGFjaGlldmUgdGhhdCBpZiB3ZSB1
c2Ugdm1hbGxvYygpIHRvIGRvIGFsbG9jYXRpb24gZm9yIHRoZQo+Pj4gYm91bmNlIGJ1ZmZlciB3
aGljaCBjYW4gYmUgdXNlZCBpbiBjb2hlcmVudCBETUEgbWFwcGluZyBjYXNlLiBCdXQKPj4+IGxv
b2tzIGxpa2Ugd2Ugc3RpbGwgaGF2ZSBubyB3YXkgdG8gYXZvaWQgdGhlIElPVExCX1VNQVAgbWVz
c2FnZSBpbgo+Pj4gdmhvc3QtdmRwYSBjYXNlLgo+Pgo+PiBJIHRoaW5rIHRoYXQncyBmaW5lLiBG
b3IgdmlydGlvLXZkcGEsIGZyb20gVkRVU0UgdXNlcnNwYWNlIHBlcnNwZWN0aXZlLAo+PiBpdCB3
b3JrcyBsaWtlIGEgZHJpdmVyIHRoYXQgaXMgdXNpbmcgU1dJT1RMQiBpbiB0aGlzIGNhc2UuCj4+
Cj4gT0ssIHdpbGwgZG8gaXQgaW4gdjMuCj4KPiBUaGFua3MsCj4gWW9uZ2ppCj4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
