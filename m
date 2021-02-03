Return-Path: <SRS0=+GVp=HF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76215C433DB
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 18:28:57 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B9ADC64DE1
	for <virtualization@archiver.kernel.org>; Wed,  3 Feb 2021 18:28:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B9ADC64DE1
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id BAEDC232FA;
	Wed,  3 Feb 2021 18:28:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id HraQHopthMvx; Wed,  3 Feb 2021 18:28:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id B1165203FD;
	Wed,  3 Feb 2021 18:28:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9DA54C0FA7;
	Wed,  3 Feb 2021 18:28:50 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28DF1C013A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 18:28:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 235C684AC4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 18:28:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GEhVJQIZDAhJ
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 18:28:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com
 [209.85.208.42])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 3617584AB2
 for <virtualization@lists.linux-foundation.org>;
 Wed,  3 Feb 2021 18:28:49 +0000 (UTC)
Received: by mail-ed1-f42.google.com with SMTP id z22so764674edb.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 03 Feb 2021 10:28:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=deKmDPZvxIuZwtD1VBiDKxq5DpDNT8e07XxCpE/cvT0=;
 b=hQVQuaI8pkqkS6L+ood4W5X3XXISXMSRVeb64JeIF1OiOmHm3hN1PXnNTa+eNomtdU
 k7yljb1eu//LQQBM7y4WbTbM+tyn7Xw0UEIch4M/IKBFs489HMKCV6Df7G4mSi/VrApx
 X2bg8yh17S1FKu077Sco/E+ZwgQLJqS/N0Psj3AVpJ4b/kRZ8rSoBoyjGp6qgFuoCzEm
 WijjfUbEjq0pEB8MPgoObqHatLhprPyRc7r0fA+63U5eUKCiiVsbOAplICfX37Jf7fk8
 zC+lblsfgUeFShy175Jk5Vb6MwXavlJelZA/velPqAsUhwJqhfXhcLLXNt9S9KiDbQ+b
 2x+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=deKmDPZvxIuZwtD1VBiDKxq5DpDNT8e07XxCpE/cvT0=;
 b=JgpHL155IR3uQHwx2sxqDUISuvl4lWEFhv7PtyLTqfaBw8XTHL/2KUJnTCcxtqAmb+
 Xd8teGkJ1VdpRAMjZfuA5HWglEfWjDISyX/3QEVpQiXffBTAlmMfiTR4Exf1oe6drk4n
 Is1k0VlghsWqzxH7q5MI57ThRLAgxIXkMlDtsg4BRxkwVOLdR4Hy+Hj15M1UVpzSsad2
 +0j6XhdUsh+BdJO2u0J+fOip77acAQP/ne419LW5nsHd+G1r0sJFBGm6IjYebY6wSaPL
 oQ8djuP5+J8HjZvAa2vv2Mb/CMrD9o2KOxl9giCYik4jaIAn/1dWmdN9egzl9EkJZHTd
 0ViA==
X-Gm-Message-State: AOAM531wVhfdgPgQLNjLNp3iGPv/EGCSrgEzaJclTPuMOjFdst6UNMxo
 DfI7wdwMqseJqUlvdH+2U+iNyv6MfdldvrHdXqM=
X-Google-Smtp-Source: ABdhPJwOPfZsPY5C71OdoeodHEOHYUshG/GCcrIRNJjIbXDJNJk4/9fnLU/YytcvgbeZiYNkoUxV44likijyqs16nG4=
X-Received: by 2002:a05:6402:d09:: with SMTP id
 eb9mr4411830edb.285.1612376927774; 
 Wed, 03 Feb 2021 10:28:47 -0800 (PST)
MIME-Version: 1.0
References: <20210129002136.70865-1-weiwan@google.com>
 <a0b2cb8d-eb8f-30fb-2a22-678e6dd2f58f@redhat.com>
 <CAF=yD-+aPBF2RaCR8L5orTM37bf7Z4Z8Qko2D2LZjOz0khHTUg@mail.gmail.com>
 <3a3e005d-f9b2-c16a-5ada-6e04242c618e@redhat.com>
In-Reply-To: <3a3e005d-f9b2-c16a-5ada-6e04242c618e@redhat.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Wed, 3 Feb 2021 13:28:11 -0500
Message-ID: <CAF=yD-+NVKiwS6P2=cS=gk2nLcsWP1anMyy4ghdPiNrhOmLRDw@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: suppress bad irq warning for tx napi
To: Jason Wang <jasowang@redhat.com>
Cc: Willem de Bruijn <willemb@google.com>,
 Network Development <netdev@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 Wei Wang <weiwan@google.com>, David Miller <davem@davemloft.net>
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

T24gV2VkLCBGZWIgMywgMjAyMSBhdCAxMjozMyBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPgo+Cj4gT24gMjAyMS8yLzIg5LiL5Y2IMTA6MzcsIFdpbGxlbSBkZSBC
cnVpam4gd3JvdGU6Cj4gPiBPbiBNb24sIEZlYiAxLCAyMDIxIGF0IDEwOjA5IFBNIEphc29uIFdh
bmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4+Cj4gPj4gT24gMjAyMS8xLzI5IOS4
iuWNiDg6MjEsIFdlaSBXYW5nIHdyb3RlOgo+ID4+PiBXaXRoIHRoZSBpbXBsZW1lbnRhdGlvbiBv
ZiBuYXBpLXR4IGluIHZpcnRpbyBkcml2ZXIsIHdlIGNsZWFuIHR4Cj4gPj4+IGRlc2NyaXB0b3Jz
IGZyb20gcnggbmFwaSBoYW5kbGVyLCBmb3IgdGhlIHB1cnBvc2Ugb2YgcmVkdWNpbmcgdHgKPiA+
Pj4gY29tcGxldGUgaW50ZXJydXB0cy4gQnV0IHRoaXMgY291bGQgaW50cm9kdWNlIGEgcmFjZSB3
aGVyZSB0eCBjb21wbGV0ZQo+ID4+PiBpbnRlcnJ1cHQgaGFzIGJlZW4gcmFpc2VkLCBidXQgdGhl
IGhhbmRsZXIgZm91bmQgdGhlcmUgaXMgbm8gd29yayB0byBkbwo+ID4+PiBiZWNhdXNlIHdlIGhh
dmUgZG9uZSB0aGUgd29yayBpbiB0aGUgcHJldmlvdXMgcnggaW50ZXJydXB0IGhhbmRsZXIuCj4g
Pj4+IFRoaXMgY291bGQgbGVhZCB0byB0aGUgZm9sbG93aW5nIHdhcm5pbmcgbXNnOgo+ID4+PiBb
IDM1ODguMDEwNzc4XSBpcnEgMzg6IG5vYm9keSBjYXJlZCAodHJ5IGJvb3Rpbmcgd2l0aCB0aGUK
PiA+Pj4gImlycXBvbGwiIG9wdGlvbikKPiA+Pj4gWyAzNTg4LjAxNzkzOF0gQ1BVOiA0IFBJRDog
MCBDb21tOiBzd2FwcGVyLzQgTm90IHRhaW50ZWQKPiA+Pj4gNS4zLjAtMTktZ2VuZXJpYyAjMjB+
MTguMDQuMi1VYnVudHUKPiA+Pj4gWyAzNTg4LjAxNzk0MF0gQ2FsbCBUcmFjZToKPiA+Pj4gWyAz
NTg4LjAxNzk0Ml0gIDxJUlE+Cj4gPj4+IFsgMzU4OC4wMTc5NTFdICBkdW1wX3N0YWNrKzB4NjMv
MHg4NQo+ID4+PiBbIDM1ODguMDE3OTUzXSAgX19yZXBvcnRfYmFkX2lycSsweDM1LzB4YzAKPiA+
Pj4gWyAzNTg4LjAxNzk1NV0gIG5vdGVfaW50ZXJydXB0KzB4MjRiLzB4MmEwCj4gPj4+IFsgMzU4
OC4wMTc5NTZdICBoYW5kbGVfaXJxX2V2ZW50X3BlcmNwdSsweDU0LzB4ODAKPiA+Pj4gWyAzNTg4
LjAxNzk1N10gIGhhbmRsZV9pcnFfZXZlbnQrMHgzYi8weDYwCj4gPj4+IFsgMzU4OC4wMTc5NThd
ICBoYW5kbGVfZWRnZV9pcnErMHg4My8weDFhMAo+ID4+PiBbIDM1ODguMDE3OTYxXSAgaGFuZGxl
X2lycSsweDIwLzB4MzAKPiA+Pj4gWyAzNTg4LjAxNzk2NF0gIGRvX0lSUSsweDUwLzB4ZTAKPiA+
Pj4gWyAzNTg4LjAxNzk2Nl0gIGNvbW1vbl9pbnRlcnJ1cHQrMHhmLzB4Zgo+ID4+PiBbIDM1ODgu
MDE3OTY2XSAgPC9JUlE+Cj4gPj4+IFsgMzU4OC4wMTc5ODldIGhhbmRsZXJzOgo+ID4+PiBbIDM1
ODguMDIwMzc0XSBbPDAwMDAwMDAwMWI5ZjFkYTg+XSB2cmluZ19pbnRlcnJ1cHQKPiA+Pj4gWyAz
NTg4LjAyNTA5OV0gRGlzYWJsaW5nIElSUSAjMzgKPiA+Pj4KPiA+Pj4gVGhpcyBwYXRjaCBhZGRz
IGEgbmV3IHBhcmFtIHRvIHN0cnVjdCB2cmluZ192aXJ0cXVldWUsIGFuZCB3ZSBzZXQgaXQgZm9y
Cj4gPj4+IHR4IHZpcnRxdWV1ZXMgaWYgbmFwaS10eCBpcyBlbmFibGVkLCB0byBzdXBwcmVzcyB0
aGUgd2FybmluZyBpbiBzdWNoCj4gPj4+IGNhc2UuCj4gPj4+Cj4gPj4+IEZpeGVzOiA3YjA0MTFl
ZjRhYTYgKCJ2aXJ0aW8tbmV0OiBjbGVhbiB0eCBkZXNjcmlwdG9ycyBmcm9tIHJ4IG5hcGkiKQo+
ID4+PiBSZXBvcnRlZC1ieTogUmljayBKb25lcyA8am9uZXNyaWNrQGdvb2dsZS5jb20+Cj4gPj4+
IFNpZ25lZC1vZmYtYnk6IFdlaSBXYW5nIDx3ZWl3YW5AZ29vZ2xlLmNvbT4KPiA+Pj4gU2lnbmVk
LW9mZi1ieTogV2lsbGVtIGRlIEJydWlqbiA8d2lsbGVtYkBnb29nbGUuY29tPgo+ID4+Cj4gPj4g
UGxlYXNlIHVzZSBnZXRfbWFpbnRhaW5lci5wbCB0byBtYWtlIHN1cmUgTWljaGFlbCBhbmQgbWUg
d2VyZSBjY2VkLgo+ID4gV2lsbCBkby4gU29ycnkgYWJvdXQgdGhhdC4gSSBzdWdnZXN0ZWQganVz
dCB0aGUgdmlydHVhbGl6YXRpb24gbGlzdCwgbXkgYmFkLgo+ID4KPiA+Pj4gLS0tCj4gPj4+ICAg
IGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyAgICAgfCAxOSArKysrKysrKysrKysrKy0tLS0tCj4g
Pj4+ICAgIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAxNiArKysrKysrKysrKysrKysr
Cj4gPj4+ICAgIGluY2x1ZGUvbGludXgvdmlydGlvLmggICAgICAgfCAgMiArKwo+ID4+PiAgICAz
IGZpbGVzIGNoYW5nZWQsIDMyIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4gPj4+Cj4g
Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMKPiA+Pj4gaW5kZXggNTA4NDA4ZmJlNzhmLi5lOWEzZjMwODY0ZTggMTAwNjQ0
Cj4gPj4+IC0tLSBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4+PiArKysgYi9kcml2ZXJz
L25ldC92aXJ0aW9fbmV0LmMKPiA+Pj4gQEAgLTEzMDMsMTMgKzEzMDMsMjIgQEAgc3RhdGljIHZv
aWQgdmlydG5ldF9uYXBpX3R4X2VuYWJsZShzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSwKPiA+Pj4g
ICAgICAgICAgICAgICAgcmV0dXJuOwo+ID4+PiAgICAgICAgfQo+ID4+Pgo+ID4+PiArICAgICAv
KiBXaXRoIG5hcGlfdHggZW5hYmxlZCwgZnJlZV9vbGRfeG1pdF9za2JzKCkgY291bGQgYmUgY2Fs
bGVkIGZyb20KPiA+Pj4gKyAgICAgICogcnggbmFwaSBoYW5kbGVyLiBTZXQgd29ya19zdGVhbCB0
byBzdXBwcmVzcyBiYWQgaXJxIHdhcm5pbmcgZm9yCj4gPj4+ICsgICAgICAqIElSUV9OT05FIGNh
c2UgZnJvbSB0eCBjb21wbGV0ZSBpbnRlcnJ1cHQgaGFuZGxlci4KPiA+Pj4gKyAgICAgICovCj4g
Pj4+ICsgICAgIHZpcnRxdWV1ZV9zZXRfd29ya19zdGVhbCh2cSwgdHJ1ZSk7Cj4gPj4+ICsKPiA+
Pj4gICAgICAgIHJldHVybiB2aXJ0bmV0X25hcGlfZW5hYmxlKHZxLCBuYXBpKTsKPiA+Pgo+ID4+
IERvIHdlIG5lZWQgdG8gZm9yY2UgdGhlIG9yZGVyaW5nIGJldHdlZW4gc3RlYWwgc2V0IGFuZCBu
YXBpIGVuYWJsZT8KPiA+IFRoZSB3YXJuaW5nIG9ubHkgb2NjdXJzIGFmdGVyIG9uZSBodW5kcmVk
IHNwdXJpb3VzIGludGVycnVwdHMsIHNvIG5vdAo+ID4gcmVhbGx5Lgo+Cj4KPiBPaywgc28gaXQg
bG9va3MgbGlrZSBhIGhpbnQuIFRoZW4gSSB3b25kZXIgaG93IG11Y2ggdmFsdWUgZG8gd2UgbmVl
ZCB0bwo+IGludHJvZHVjZSBoZWxwZXIgbGlrZSB2aXJ0cXVldWVfc2V0X3dvcmtfc3RlYWwoKSB0
aGF0IGFsbG93cyB0aGUgY2FsbGVyCj4gdG8gdG9nZ2xlLiBIb3cgYWJvdXQgZGlzYWJsZSB0aGUg
Y2hlY2sgZm9yZXZlciBkdXJpbmcgdmlydHF1ZXVlCj4gaW5pdGlhbGl6YXRpb24/CgpZZXMsIHRo
YXQgaXMgZXZlbiBzaW1wbGVyLgoKV2Ugc3RpbGwgbmVlZCB0aGUgaGVscGVyLCBhcyB0aGUgaW50
ZXJuYWwgdmFyaWFibGVzIG9mIHZyaW5nX3ZpcnRxdWV1ZQphcmUgbm90IGFjY2Vzc2libGUgZnJv
bSB2aXJ0aW8tbmV0LiBBbiBlYXJsaWVyIHBhdGNoIGFkZGVkIHRoZQp2YXJpYWJsZSB0byB2aXJ0
cXVldWUgaXRzZWxmLCBidXQgSSB0aGluayBpdCBiZWxvbmdzIGluCnZyaW5nX3ZpcnRxdWV1ZS4g
QW5kIHRoZSBoZWxwZXIgaXMgbm90IGEgbG90IG9mIGNvZGUuCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
