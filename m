Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AEDEFC4332F
	for <virtualization@archiver.kernel.org>; Sun,  9 Oct 2022 05:59:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3BD2960D54;
	Sun,  9 Oct 2022 05:59:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3BD2960D54
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZtFMWHBW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g_4487aVkVvX; Sun,  9 Oct 2022 05:59:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AD2CC60C03;
	Sun,  9 Oct 2022 05:59:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AD2CC60C03
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7C6B5C0032;
	Sun,  9 Oct 2022 05:59:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32291C002D
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Oct 2022 05:59:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 06B23401FB
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Oct 2022 05:59:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 06B23401FB
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZtFMWHBW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0Iw8aDbabq5D
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Oct 2022 05:59:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0A0324011C
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0A0324011C
 for <virtualization@lists.linux-foundation.org>;
 Sun,  9 Oct 2022 05:59:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1665295145;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=XyL4XgZY3fE78rf1t1J98tuq3HEa3BcmqHdSW/YDE7Y=;
 b=ZtFMWHBWnqNjqog3k0z9BaBsNKKC3WYYHQb1YiMSR0xyKpre1F8JIUNjAhx9/UiTSlbthU
 jC73DhZBJuXwTMYX9pOkiCH9HvUiUXd4nyk7H4cpT+G5stYUsnndFP5hbxnnJoYIFjC4C8
 hIShn3T2qLGnQtequZyR5FpzSSIORqE=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-246-1Irm8JLhO42CrG6FRgw8uA-1; Sun, 09 Oct 2022 01:59:03 -0400
X-MC-Unique: 1Irm8JLhO42CrG6FRgw8uA-1
Received: by mail-pg1-f198.google.com with SMTP id
 x16-20020a63b210000000b0045f5c1e18d0so2370427pge.0
 for <virtualization@lists.linux-foundation.org>;
 Sat, 08 Oct 2022 22:59:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=XyL4XgZY3fE78rf1t1J98tuq3HEa3BcmqHdSW/YDE7Y=;
 b=M1fcDHaSYG6eEfYjgVyshm+lPH7tGFH9EcTl5V8BT8G4iFRulyoEwbt05tocRWOh9S
 IFArl7fz9Z6H+aELJHyQwPPGIXPV0dUfLxd/sp7OdhRehYJnL3G2mBhIwRvUzASNX+nF
 VAOCVb+QwrqMbOdOUhwf/MEI0VEHwSK+wBtkl/sHb0RqkYuMK2anpd2ZuvF8y3ry8PTW
 bCkpAGC0Y7YXjNX3J8EoicpOE9FzLfMpwhUcFYxfxO1cqrUuQrA3ZZDqj0sOQ1jsrC3E
 Oy2elXxe4pmre1kcDTVOBt/H6t0HUEybEYrlmf45MXIWUnZZyL4YRVadpez/BsugeTCW
 Gfjg==
X-Gm-Message-State: ACrzQf1b63JHpjtS4xiAfv1ekSK0pX5jhk3cRffAZLIMHnAbuGEm+3UT
 05zqKaJA3sO6y0SfsbGp5pNxZO8E5wa1yjIDTfpKp/oHFgneyI28zT5tzFhadfDgLIfeWY/9GlV
 MEkljN7j2rbommUgpfAfMyKWjC+uXyowjh9MJio0RgQ==
X-Received: by 2002:a17:90a:1347:b0:20b:ffd:66b9 with SMTP id
 y7-20020a17090a134700b0020b0ffd66b9mr16351263pjf.15.1665295142949; 
 Sat, 08 Oct 2022 22:59:02 -0700 (PDT)
X-Google-Smtp-Source: AMsMyM57/2XHWbN7XzWOLjsjlVXU3IBSBWoYzNW9XJfotIZtsRHFNdZuR0KhTY81FYcV9G64goQDVg==
X-Received: by 2002:a17:90a:1347:b0:20b:ffd:66b9 with SMTP id
 y7-20020a17090a134700b0020b0ffd66b9mr16351239pjf.15.1665295142628; 
 Sat, 08 Oct 2022 22:59:02 -0700 (PDT)
Received: from [10.72.12.61] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 67-20020a620446000000b0054ee4b632dasm4350688pfe.169.2022.10.08.22.58.59
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 08 Oct 2022 22:59:02 -0700 (PDT)
Message-ID: <c8cd9a2e-3480-6ca5-96fa-4b5bd2c1174a@redhat.com>
Date: Sun, 9 Oct 2022 13:58:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.1
Subject: Re: [PATCH net] virtio-net: add cond_resched() to the command waiting
 loop
To: "Michael S. Tsirkin" <mst@redhat.com>, Jakub Kicinski <kuba@kernel.org>
References: <20220905045341.66191-1-jasowang@redhat.com>
 <20220905031405-mutt-send-email-mst@kernel.org>
 <CACGkMEtjQ0Jfok-gcRW+kuinsua2X0TscyTNfBJoXHny0Yob+g@mail.gmail.com>
 <056ba905a2579903a372258383afdf6579767ad0.camel@redhat.com>
 <CACGkMEuiDqqOEKUWRN9LvQKv8Jz4mi3aSZMwbhUsJkZp=C-0RQ@mail.gmail.com>
 <c9180ac41b00543e3531a343afae8f5bdca64d8d.camel@redhat.com>
 <20220907034407-mutt-send-email-mst@kernel.org>
 <d32101bb-783f-dbd1-545a-be291c27cb63@redhat.com>
 <20220908011858-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220908011858-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eric Dumazet <edumazet@google.com>, Gautam Dawar <gautam.dawar@xilinx.com>,
 Paolo Abeni <pabeni@redhat.com>, davem <davem@davemloft.net>
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

CuWcqCAyMDIyLzkvOCAxMzoxOSwgTWljaGFlbCBTLiBUc2lya2luIOWGmemBkzoKPiBPbiBUaHUs
IFNlcCAwOCwgMjAyMiBhdCAxMDoyMTo0NUFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiDl
nKggMjAyMi85LzcgMTU6NDYsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4+PiBPbiBXZWQs
IFNlcCAwNywgMjAyMiBhdCAwOTowNzoyMEFNICswMjAwLCBQYW9sbyBBYmVuaSB3cm90ZToKPj4+
PiBPbiBXZWQsIDIwMjItMDktMDcgYXQgMTA6MDkgKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4+
Pj4+IE9uIFR1ZSwgU2VwIDYsIDIwMjIgYXQgNjo1NiBQTSBQYW9sbyBBYmVuaSA8cGFiZW5pQHJl
ZGhhdC5jb20+IHdyb3RlOgo+Pj4+Pj4gT24gTW9uLCAyMDIyLTA5LTA1IGF0IDE1OjQ5ICswODAw
LCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+Pj4+IE9uIE1vbiwgU2VwIDUsIDIwMjIgYXQgMzoxNSBQ
TSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPj4+Pj4+Pj4gT24g
TW9uLCBTZXAgMDUsIDIwMjIgYXQgMTI6NTM6NDFQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
Pj4+Pj4+Pj4+IEFkZGluZyBjb25kX3Jlc2NoZWQoKSB0byB0aGUgY29tbWFuZCB3YWl0aW5nIGxv
b3AgZm9yIGEgYmV0dGVyCj4+Pj4+Pj4+PiBjby1vcGVyYXRpb24gd2l0aCB0aGUgc2NoZWR1bGVy
LiBUaGlzIGFsbG93cyB0byBnaXZlIENQVSBhIGJyZWF0aCB0bwo+Pj4+Pj4+Pj4gcnVuIG90aGVy
IHRhc2sod29ya3F1ZXVlKSBpbnN0ZWFkIG9mIGJ1c3kgbG9vcGluZyB3aGVuIHByZWVtcHRpb24g
aXMKPj4+Pj4+Pj4+IG5vdCBhbGxvd2VkLgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IFdoYXQncyBtb3Jl
IGltcG9ydGFudC4gVGhpcyBpcyBhIG11c3QgZm9yIHNvbWUgdkRQQSBwYXJlbnQgdG8gd29yawo+
Pj4+Pj4+Pj4gc2luY2UgY29udHJvbCB2aXJ0cXVldWUgaXMgZW11bGF0ZWQgdmlhIGEgd29ya3F1
ZXVlIGZvciB0aG9zZSBwYXJlbnRzLgo+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IEZpeGVzOiBiZGEzMjRm
ZDAzN2EgKCJ2ZHBhc2ltOiBjb250cm9sIHZpcnRxdWV1ZSBzdXBwb3J0IikKPj4+Pj4+Pj4gVGhh
dCdzIGEgd2VpcmQgY29tbWl0IHRvIGZpeC4gc28gaXQgZml4ZXMgdGhlIHNpbXVsYXRvcj8KPj4+
Pj4+PiBZZXMsIHNpbmNlIHRoZSBzaW11bGF0b3IgaXMgdXNpbmcgYSB3b3JrcXVldWUgdG8gaGFu
ZGxlIGNvbnRyb2wgdmlydHVldWUuCj4+Pj4+PiBVaG1tLi4uIHRvdWNoaW5nIGEgZHJpdmVyIGZv
ciBhIHNpbXVsYXRvcidzIHNha2UgbG9va3MgYSBsaXR0bGUgd2VpcmQuCj4+Pj4+IFNpbXVsYXRv
ciBpcyBub3QgdGhlIG9ubHkgb25lIHRoYXQgaXMgdXNpbmcgYSB3b3JrcXVldWUgKGJ1dCBzaG91
bGQgYmUKPj4+Pj4gdGhlIGZpcnN0KS4KPj4+Pj4KPj4+Pj4gSSBjYW4gc2VlICB0aGF0IHRoZSBt
bHg1IHZEUEEgZHJpdmVyIGlzIHVzaW5nIGEgd29ya3F1ZXVlIGFzIHdlbGwgKHNlZQo+Pj4+PiBt
bHg1X3ZkcGFfa2lja192cSgpKS4KPj4+Pj4KPj4+Pj4gQW5kIGluIHRoZSBjYXNlIG9mIFZEVVNF
LCBpdCBuZWVkcyB0byB3YWl0IGZvciB0aGUgcmVzcG9uc2UgZnJvbSB0aGUKPj4+Pj4gdXNlcnNw
YWNlLCB0aGlzIG1lYW5zIGNvbmRfcmVzY2hlZCgpIGlzIHByb2JhYmx5IGEgbXVzdCBmb3IgdGhl
IGNhc2UKPj4+Pj4gbGlrZSBVUC4KPj4+Pj4KPj4+Pj4+IEFkZGl0aW9uYWxseSwgaWYgdGhlIGJ1
ZyBpcyB2ZHBhc2ltLCBJIHRoaW5rIGl0J3MgYmV0dGVyIHRvIHRyeSB0bwo+Pj4+Pj4gc29sdmUg
aXQgdGhlcmUsIGlmIHBvc3NpYmxlLgo+Pj4+Pj4KPj4+Pj4+IExvb2tpbmcgYXQgdmRwYXNpbV9u
ZXRfd29yaygpIGFuZCB2ZHBhc2ltX2Jsa193b3JrKCkgaXQgbG9va3MgbGlrZQo+Pj4+Pj4gbmVp
dGhlciBuZWVkcyBhIHByb2Nlc3MgY29udGV4dCwgc28gcGVyaGFwcyB5b3UgY291bGQgcmV3b3Jr
IGl0IHRvIHJ1bgo+Pj4+Pj4gdGhlIHdvcmtfZm4oKSBkaXJlY3RseSBmcm9tIHZkcGFzaW1fa2lj
a192cSgpLCBhdCBsZWFzdCBmb3IgdGhlIGNvbnRyb2wKPj4+Pj4+IHZpcnRxdWV1ZT8KPj4+Pj4g
SXQncyBwb3NzaWJsZSAoYnV0IHJlcXVpcmUgc29tZSByZXdvcmsgb24gdGhlIHNpbXVsYXRvciBj
b3JlKS4gQnV0Cj4+Pj4+IGNvbnNpZGVyaW5nIHdlIGhhdmUgb3RoZXIgc2ltaWxhciB1c2UgY2Fz
ZXMsIGl0IGxvb2tzIGJldHRlciB0byBzb2x2ZQo+Pj4+PiBpdCBpbiB0aGUgdmlydGlvLW5ldCBk
cml2ZXIuCj4+Pj4gSSBzZWUuCj4+Pj4KPj4+Pj4gQWRkaXRpb25hbGx5LCB0aGlzIG1heSBoYXZl
IGJldHRlciBiZWhhdmlvdXIgd2hlbiB1c2luZyBmb3IgdGhlIGJ1Z2d5Cj4+Pj4+IGhhcmR3YXJl
IChlLmcgdGhlIGNvbnRyb2wgdmlydHF1ZXVlIHRha2VzIHRvbyBsb25nIHRvIHJlc3BvbmQpLiBX
ZSBtYXkKPj4+Pj4gY29uc2lkZXIgc3dpdGNoaW5nIHRvIHVzZSBpbnRlcnJ1cHQvc2xlZXAgaW4g
dGhlIGZ1dHVyZSAoYnV0IG5vdAo+Pj4+PiBzdWl0YWJsZSBmb3IgLW5ldCkuCj4+Pj4gQWdyZWVk
LiBQb3NzaWJseSBhIHRpbWVvdXQgY291bGQgYmUgdXNlZnVsLCB0b28uCj4+Pj4KPj4+PiBDaGVl
cnMsCj4+Pj4KPj4+PiBQYW9sbwo+Pj4gSG1tIHRpbWVvdXRzIGFyZSBraW5kIG9mIGFyYml0cmFy
eS4KPj4+IHJlZ3VsYXIgZHJpdmVycyBiYXNpY2FsbHkgZGVyaXZlIHRoZW0gZnJvbSBoYXJkd2Fy
ZQo+Pj4gYmVoYXZpb3VyIGJ1dCB3aXRoIGEgZ2VuZXJpYyBkcml2ZXIgbGlrZSB2aXJ0aW8gaXQn
cyBoYXJkZXIuCj4+PiBJIGd1ZXNzIHdlIGNvdWxkIGFkZCB0aW1lb3V0IGFzIGEgY29uZmlnIGZp
ZWxkLCBoYXZlCj4+PiBkZXZpY2UgbWFrZSBhIHByb21pc2UgdG8gdGhlIGRyaXZlci4KPj4+Cj4+
PiBNYWtpbmcgdGhlIHdhaXQgaW50ZXJydXB0aWJsZSBzZWVtcyBtb3JlIHJlYXNvbmFibGUuCj4+
Cj4+IFllcywgYnV0IEkgdGhpbmsgd2Ugc3RpbGwgbmVlZCB0aGlzIHBhdGNoIGZvciAtbmV0IGFu
ZCAtc3RhYmxlLgo+Pgo+PiBUaGFua3MKPiBJIHdhcyByZWZlcnJpbmcgdG8gUGFvbG8ncyBpZGVh
IG9mIGhhdmluZyBhIHRpbWVvdXQuCgoKT2ssIEkgdGhpbmsgd2UncmUgZmluZSB3aXRoIHRoaXMg
cGF0Y2guIEFueSBjaGFuY2UgdG8gbWVyZ2UgdGhpcyBvciBkbyBJIApuZWVkIHRvIHJlc2VuZD8K
ClRoYW5rcwoKCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
