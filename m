Return-Path: <SRS0=X+k7=HK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9D5FCC433DB
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 19:09:10 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1982764E5A
	for <virtualization@archiver.kernel.org>; Mon,  8 Feb 2021 19:09:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1982764E5A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8CA0387114;
	Mon,  8 Feb 2021 19:09:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6sdsieaK+ars; Mon,  8 Feb 2021 19:09:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id B59EC870EA;
	Mon,  8 Feb 2021 19:09:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6ABDDC0891;
	Mon,  8 Feb 2021 19:09:08 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4819DC013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 19:09:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 2E7D28454E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 19:09:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id lG5MtIojvZwY
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 19:09:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 3F199842B2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  8 Feb 2021 19:09:05 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id s26so14237004edt.10
 for <virtualization@lists.linux-foundation.org>;
 Mon, 08 Feb 2021 11:09:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=l0kbrSaQgUXnEY1P7PcjdolquDqjSA58IJTFJAK0lBc=;
 b=pZSi6AjgTzOb5nK5lYZzBBmmH71S7J5hcYyYCI/j+LZgR+XB/OEBx583W9IvuD3OmO
 Gh9yAkRs7VivwAQH/DpjjIx4/kSgX3x4xPwL/Ynz6MT6jVab9uVkiqSA4KUob9JSv9zd
 DYZZj9hRKIUHDDQM7eO0f3fmzd7WQHf291nYmuV9TqKFWlUEmz2V45l2CP99wGE6hHs5
 xp2JWFLVVgUUThvW6unDGE+8hJw/a56AZneBjxfUSxcoFaGwJlqzBYeToU/13zx6xQuW
 J7u3PwDgBhq7QXlCj8aeDm/puefJf6LpqINcZee+M9iJQvFvkNUjoSRIyjKnGxrrIiXs
 NZ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=l0kbrSaQgUXnEY1P7PcjdolquDqjSA58IJTFJAK0lBc=;
 b=H5QNZZ2QdDBnrDMMCu3f0CLvSFJ1qzN1UwDpPToI+X4N/0kKGkI1atAdNxcewm5KCG
 XHfRsT4K7ykezOlqQYmnIvMbhQrfmJGGf00XzsW/xQ7UB+gYgN2cv3aIsHtDBz8Zh7wy
 1gmHFPIYwTlsK1g4L742UyAj8scVmvV5o+N3ZCWbJlwqpqjRGR/xV6yyXAd9L6OCO3Wo
 TFXVFGR0uoh06O1dkXQxFY2zgc2gChjFAtoQXbNJznl3DrNkQl4DaJFPdZxy86Jim5QR
 /ughdaFBsMqkHJl4wo67Abesla2ma2HRSJur0+3WZSDxaGmm4RAGcyrMftz+fk3KeLfp
 K5xA==
X-Gm-Message-State: AOAM5324B5OmeqpMiYh37giiVbyB+w8MSd7qkw+24G1vteYHP7cVth8n
 /x0Q/CwRpPeh13JQL6u6Qb3ygfil7+cXgSypXCY=
X-Google-Smtp-Source: ABdhPJxF/8gMEIpp3RevkkNsme+QbmBql5G+BJf6SWQ5H8PvnybBbCf5zSqSrZK7g3ZZiquPGd4IV15YthKlqI8F5eY=
X-Received: by 2002:aa7:da17:: with SMTP id r23mr18113059eds.176.1612811343705; 
 Mon, 08 Feb 2021 11:09:03 -0800 (PST)
MIME-Version: 1.0
References: <20210129002136.70865-1-weiwan@google.com>
 <a0b2cb8d-eb8f-30fb-2a22-678e6dd2f58f@redhat.com>
 <CAF=yD-+aPBF2RaCR8L5orTM37bf7Z4Z8Qko2D2LZjOz0khHTUg@mail.gmail.com>
 <3a3e005d-f9b2-c16a-5ada-6e04242c618e@redhat.com>
 <CAF=yD-+NVKiwS6P2=cS=gk2nLcsWP1anMyy4ghdPiNrhOmLRDw@mail.gmail.com>
 <9b0b8f2a-8476-697e-9002-e9947e3eab63@redhat.com>
 <CA+FuTScVOuoHKtrdrRFswjA3Zq1-7sgMVhnP2iMB5sYFFS8NFg@mail.gmail.com>
 <50ae0b71-df87-f26c-8b4d-8035f9f6a58d@redhat.com>
In-Reply-To: <50ae0b71-df87-f26c-8b4d-8035f9f6a58d@redhat.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Mon, 8 Feb 2021 14:08:26 -0500
Message-ID: <CAF=yD-J5-60D=JDwvpecjaO6J03SZHoHJyCsR3B1HbP1-jbqng@mail.gmail.com>
Subject: Re: [PATCH net] virtio-net: suppress bad irq warning for tx napi
To: Jason Wang <jasowang@redhat.com>
Cc: Network Development <netdev@vger.kernel.org>, Wei Wang <weiwan@google.com>,
 virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>,
 Jakub Kicinski <kuba@kernel.org>
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

T24gU3VuLCBGZWIgNywgMjAyMSBhdCAxMDoyOSBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPgo+Cj4gT24gMjAyMS8yLzUg5LiK5Y2INDo1MCwgV2lsbGVtIGRlIEJy
dWlqbiB3cm90ZToKPiA+IE9uIFdlZCwgRmViIDMsIDIwMjEgYXQgMTA6MDYgUE0gSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPj4KPiA+PiBPbiAyMDIxLzIvNCDkuIrl
jYgyOjI4LCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOgo+ID4+PiBPbiBXZWQsIEZlYiAzLCAyMDIx
IGF0IDEyOjMzIEFNIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4+
Pj4gT24gMjAyMS8yLzIg5LiL5Y2IMTA6MzcsIFdpbGxlbSBkZSBCcnVpam4gd3JvdGU6Cj4gPj4+
Pj4gT24gTW9uLCBGZWIgMSwgMjAyMSBhdCAxMDowOSBQTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0By
ZWRoYXQuY29tPiB3cm90ZToKPiA+Pj4+Pj4gT24gMjAyMS8xLzI5IOS4iuWNiDg6MjEsIFdlaSBX
YW5nIHdyb3RlOgo+ID4+Pj4+Pj4gV2l0aCB0aGUgaW1wbGVtZW50YXRpb24gb2YgbmFwaS10eCBp
biB2aXJ0aW8gZHJpdmVyLCB3ZSBjbGVhbiB0eAo+ID4+Pj4+Pj4gZGVzY3JpcHRvcnMgZnJvbSBy
eCBuYXBpIGhhbmRsZXIsIGZvciB0aGUgcHVycG9zZSBvZiByZWR1Y2luZyB0eAo+ID4+Pj4+Pj4g
Y29tcGxldGUgaW50ZXJydXB0cy4gQnV0IHRoaXMgY291bGQgaW50cm9kdWNlIGEgcmFjZSB3aGVy
ZSB0eCBjb21wbGV0ZQo+ID4+Pj4+Pj4gaW50ZXJydXB0IGhhcyBiZWVuIHJhaXNlZCwgYnV0IHRo
ZSBoYW5kbGVyIGZvdW5kIHRoZXJlIGlzIG5vIHdvcmsgdG8gZG8KPiA+Pj4+Pj4+IGJlY2F1c2Ug
d2UgaGF2ZSBkb25lIHRoZSB3b3JrIGluIHRoZSBwcmV2aW91cyByeCBpbnRlcnJ1cHQgaGFuZGxl
ci4KPiA+Pj4+Pj4+IFRoaXMgY291bGQgbGVhZCB0byB0aGUgZm9sbG93aW5nIHdhcm5pbmcgbXNn
Ogo+ID4+Pj4+Pj4gWyAzNTg4LjAxMDc3OF0gaXJxIDM4OiBub2JvZHkgY2FyZWQgKHRyeSBib290
aW5nIHdpdGggdGhlCj4gPj4+Pj4+PiAiaXJxcG9sbCIgb3B0aW9uKQo+ID4+Pj4+Pj4gWyAzNTg4
LjAxNzkzOF0gQ1BVOiA0IFBJRDogMCBDb21tOiBzd2FwcGVyLzQgTm90IHRhaW50ZWQKPiA+Pj4+
Pj4+IDUuMy4wLTE5LWdlbmVyaWMgIzIwfjE4LjA0LjItVWJ1bnR1Cj4gPj4+Pj4+PiBbIDM1ODgu
MDE3OTQwXSBDYWxsIFRyYWNlOgo+ID4+Pj4+Pj4gWyAzNTg4LjAxNzk0Ml0gIDxJUlE+Cj4gPj4+
Pj4+PiBbIDM1ODguMDE3OTUxXSAgZHVtcF9zdGFjaysweDYzLzB4ODUKPiA+Pj4+Pj4+IFsgMzU4
OC4wMTc5NTNdICBfX3JlcG9ydF9iYWRfaXJxKzB4MzUvMHhjMAo+ID4+Pj4+Pj4gWyAzNTg4LjAx
Nzk1NV0gIG5vdGVfaW50ZXJydXB0KzB4MjRiLzB4MmEwCj4gPj4+Pj4+PiBbIDM1ODguMDE3OTU2
XSAgaGFuZGxlX2lycV9ldmVudF9wZXJjcHUrMHg1NC8weDgwCj4gPj4+Pj4+PiBbIDM1ODguMDE3
OTU3XSAgaGFuZGxlX2lycV9ldmVudCsweDNiLzB4NjAKPiA+Pj4+Pj4+IFsgMzU4OC4wMTc5NThd
ICBoYW5kbGVfZWRnZV9pcnErMHg4My8weDFhMAo+ID4+Pj4+Pj4gWyAzNTg4LjAxNzk2MV0gIGhh
bmRsZV9pcnErMHgyMC8weDMwCj4gPj4+Pj4+PiBbIDM1ODguMDE3OTY0XSAgZG9fSVJRKzB4NTAv
MHhlMAo+ID4+Pj4+Pj4gWyAzNTg4LjAxNzk2Nl0gIGNvbW1vbl9pbnRlcnJ1cHQrMHhmLzB4Zgo+
ID4+Pj4+Pj4gWyAzNTg4LjAxNzk2Nl0gIDwvSVJRPgo+ID4+Pj4+Pj4gWyAzNTg4LjAxNzk4OV0g
aGFuZGxlcnM6Cj4gPj4+Pj4+PiBbIDM1ODguMDIwMzc0XSBbPDAwMDAwMDAwMWI5ZjFkYTg+XSB2
cmluZ19pbnRlcnJ1cHQKPiA+Pj4+Pj4+IFsgMzU4OC4wMjUwOTldIERpc2FibGluZyBJUlEgIzM4
Cj4gPj4+Pj4+Pgo+ID4+Pj4+Pj4gVGhpcyBwYXRjaCBhZGRzIGEgbmV3IHBhcmFtIHRvIHN0cnVj
dCB2cmluZ192aXJ0cXVldWUsIGFuZCB3ZSBzZXQgaXQgZm9yCj4gPj4+Pj4+PiB0eCB2aXJ0cXVl
dWVzIGlmIG5hcGktdHggaXMgZW5hYmxlZCwgdG8gc3VwcHJlc3MgdGhlIHdhcm5pbmcgaW4gc3Vj
aAo+ID4+Pj4+Pj4gY2FzZS4KPiA+Pj4+Pj4+Cj4gPj4+Pj4+PiBGaXhlczogN2IwNDExZWY0YWE2
ICgidmlydGlvLW5ldDogY2xlYW4gdHggZGVzY3JpcHRvcnMgZnJvbSByeCBuYXBpIikKPiA+Pj4+
Pj4+IFJlcG9ydGVkLWJ5OiBSaWNrIEpvbmVzIDxqb25lc3JpY2tAZ29vZ2xlLmNvbT4KPiA+Pj4+
Pj4+IFNpZ25lZC1vZmYtYnk6IFdlaSBXYW5nIDx3ZWl3YW5AZ29vZ2xlLmNvbT4KPiA+Pj4+Pj4+
IFNpZ25lZC1vZmYtYnk6IFdpbGxlbSBkZSBCcnVpam4gPHdpbGxlbWJAZ29vZ2xlLmNvbT4KPiA+
Pj4+Pj4gUGxlYXNlIHVzZSBnZXRfbWFpbnRhaW5lci5wbCB0byBtYWtlIHN1cmUgTWljaGFlbCBh
bmQgbWUgd2VyZSBjY2VkLgo+ID4+Pj4+IFdpbGwgZG8uIFNvcnJ5IGFib3V0IHRoYXQuIEkgc3Vn
Z2VzdGVkIGp1c3QgdGhlIHZpcnR1YWxpemF0aW9uIGxpc3QsIG15IGJhZC4KPiA+Pj4+Pgo+ID4+
Pj4+Pj4gLS0tCj4gPj4+Pj4+PiAgICAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyAgICAgfCAx
OSArKysrKysrKysrKysrKy0tLS0tCj4gPj4+Pj4+PiAgICAgIGRyaXZlcnMvdmlydGlvL3ZpcnRp
b19yaW5nLmMgfCAxNiArKysrKysrKysrKysrKysrCj4gPj4+Pj4+PiAgICAgIGluY2x1ZGUvbGlu
dXgvdmlydGlvLmggICAgICAgfCAgMiArKwo+ID4+Pj4+Pj4gICAgICAzIGZpbGVzIGNoYW5nZWQs
IDMyIGluc2VydGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4gPj4+Pj4+Pgo+ID4+Pj4+Pj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyBiL2RyaXZlcnMvbmV0L3ZpcnRpb19u
ZXQuYwo+ID4+Pj4+Pj4gaW5kZXggNTA4NDA4ZmJlNzhmLi5lOWEzZjMwODY0ZTggMTAwNjQ0Cj4g
Pj4+Pj4+PiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+Pj4+Pj4+ICsrKyBiL2Ry
aXZlcnMvbmV0L3ZpcnRpb19uZXQuYwo+ID4+Pj4+Pj4gQEAgLTEzMDMsMTMgKzEzMDMsMjIgQEAg
c3RhdGljIHZvaWQgdmlydG5ldF9uYXBpX3R4X2VuYWJsZShzdHJ1Y3QgdmlydG5ldF9pbmZvICp2
aSwKPiA+Pj4+Pj4+ICAgICAgICAgICAgICAgICAgcmV0dXJuOwo+ID4+Pj4+Pj4gICAgICAgICAg
fQo+ID4+Pj4+Pj4KPiA+Pj4+Pj4+ICsgICAgIC8qIFdpdGggbmFwaV90eCBlbmFibGVkLCBmcmVl
X29sZF94bWl0X3NrYnMoKSBjb3VsZCBiZSBjYWxsZWQgZnJvbQo+ID4+Pj4+Pj4gKyAgICAgICog
cnggbmFwaSBoYW5kbGVyLiBTZXQgd29ya19zdGVhbCB0byBzdXBwcmVzcyBiYWQgaXJxIHdhcm5p
bmcgZm9yCj4gPj4+Pj4+PiArICAgICAgKiBJUlFfTk9ORSBjYXNlIGZyb20gdHggY29tcGxldGUg
aW50ZXJydXB0IGhhbmRsZXIuCj4gPj4+Pj4+PiArICAgICAgKi8KPiA+Pj4+Pj4+ICsgICAgIHZp
cnRxdWV1ZV9zZXRfd29ya19zdGVhbCh2cSwgdHJ1ZSk7Cj4gPj4+Pj4+PiArCj4gPj4+Pj4+PiAg
ICAgICAgICByZXR1cm4gdmlydG5ldF9uYXBpX2VuYWJsZSh2cSwgbmFwaSk7Cj4gPj4+Pj4+IERv
IHdlIG5lZWQgdG8gZm9yY2UgdGhlIG9yZGVyaW5nIGJldHdlZW4gc3RlYWwgc2V0IGFuZCBuYXBp
IGVuYWJsZT8KPiA+Pj4+PiBUaGUgd2FybmluZyBvbmx5IG9jY3VycyBhZnRlciBvbmUgaHVuZHJl
ZCBzcHVyaW91cyBpbnRlcnJ1cHRzLCBzbyBub3QKPiA+Pj4+PiByZWFsbHkuCj4gPj4+PiBPaywg
c28gaXQgbG9va3MgbGlrZSBhIGhpbnQuIFRoZW4gSSB3b25kZXIgaG93IG11Y2ggdmFsdWUgZG8g
d2UgbmVlZCB0bwo+ID4+Pj4gaW50cm9kdWNlIGhlbHBlciBsaWtlIHZpcnRxdWV1ZV9zZXRfd29y
a19zdGVhbCgpIHRoYXQgYWxsb3dzIHRoZSBjYWxsZXIKPiA+Pj4+IHRvIHRvZ2dsZS4gSG93IGFi
b3V0IGRpc2FibGUgdGhlIGNoZWNrIGZvcmV2ZXIgZHVyaW5nIHZpcnRxdWV1ZQo+ID4+Pj4gaW5p
dGlhbGl6YXRpb24/Cj4gPj4+IFllcywgdGhhdCBpcyBldmVuIHNpbXBsZXIuCj4gPj4+Cj4gPj4+
IFdlIHN0aWxsIG5lZWQgdGhlIGhlbHBlciwgYXMgdGhlIGludGVybmFsIHZhcmlhYmxlcyBvZiB2
cmluZ192aXJ0cXVldWUKPiA+Pj4gYXJlIG5vdCBhY2Nlc3NpYmxlIGZyb20gdmlydGlvLW5ldC4g
QW4gZWFybGllciBwYXRjaCBhZGRlZCB0aGUKPiA+Pj4gdmFyaWFibGUgdG8gdmlydHF1ZXVlIGl0
c2VsZiwgYnV0IEkgdGhpbmsgaXQgYmVsb25ncyBpbgo+ID4+PiB2cmluZ192aXJ0cXVldWUuIEFu
ZCB0aGUgaGVscGVyIGlzIG5vdCBhIGxvdCBvZiBjb2RlLgo+ID4+Cj4gPj4gSXQncyBiZXR0ZXIg
dG8gZG8gdGhpcyBiZWZvcmUgdGhlIGFsbG9jYXRpbmcgdGhlIGlycS4gQnV0IGl0IGxvb2tzIG5v
dAo+ID4+IGVhc3kgdW5sZXNzIHdlIGV4dGVuZCBmaW5kX3ZxcygpLgo+ID4gQ2FuIHlvdSBlbGFi
b3JhdGUgd2h5IHRoYXQgaXMgYmV0dGVyPyBBdCB2aXJ0bmV0X29wZW4gdGhlIGludGVycnVwdHMK
PiA+IGFyZSBub3QgZmlyaW5nIGVpdGhlci4KPgo+Cj4gSSB0aGluayB5b3UgbWVhbnQgTkFQSSBh
Y3R1YWxseT8KCkkgbWVhbnQgaW50ZXJydXB0OiB3ZSBkb24ndCBoYXZlIHRvIHdvcnJ5IGFib3V0
IHRoZSBzcHVyaW91cyBpbnRlcnJ1cHQKd2FybmluZyB3aGVuIG5vIGludGVycnVwdHMgd2lsbCBi
ZSBmaXJpbmcuIFVudGlsIHZpcnRuZXRfb3Blbgpjb21wbGV0ZXMsIHRoZSBkZXZpY2UgaXMgZG93
bi4KCgo+Cj4gPgo+ID4gSSBoYXZlIG5vIHByZWZlcmVuY2UuIEp1c3QgY3VyaW91cywgZXNwZWNp
YWxseSBpZiBpdCBjb21wbGljYXRlcyB0aGUgcGF0Y2guCj4gPgo+Cj4gTXkgdW5kZXJzdGFuZGlu
ZyBpcyB0aGF0LiBJdCdzIHByb2JhYmx5IG9rIGZvciBuZXQuIEJ1dCB3ZSBwcm9iYWJseSBuZWVk
Cj4gdG8gZG9jdW1lbnQgdGhlIGFzc3VtcHRpb25zIHRvIG1ha2Ugc3VyZSBpdCB3YXMgbm90IGFi
dXNlZCBpbiBvdGhlciBkcml2ZXJzLgo+Cj4gSW50cm9kdWNlIG5ldyBwYXJhbWV0ZXJzIGZvciBm
aW5kX3ZxcygpIGNhbiBoZWxwIHRvIGVsaW1pbmF0ZSB0aGUgc3VidGxlCj4gc3R1ZmZzIGJ1dCBJ
IGFncmVlIGl0IGxvb2tzIGxpa2UgYSBvdmVya2lsbC4KPgo+IChCdHcsIEkgZm9yZ2V0IHRoZSBu
dW1iZXJzIGJ1dCB3b25kZXIgaG93IG11Y2ggZGlmZmVyZW5jZSBpZiB3ZSBzaW1wbGUKPiByZW1v
dmUgdGhlIGZyZWVfb2xkX3htaXRzKCkgZnJvbSB0aGUgcnggTkFQSSBwYXRoPykKClRoZSBjb21t
aXR0ZWQgcGF0Y2hzZXQgZGlkIG5vdCByZWNvcmQgdGhvc2UgbnVtYmVycywgYnV0IEkgZm91bmQg
dGhlbQppbiBhbiBlYXJsaWVyIGl0ZXJhdGlvbjoKCiAgW1BBVENIIG5ldC1uZXh0IDAvM10gdmly
dGlvLW5ldCB0eCBuYXBpCiAgaHR0cHM6Ly9saXN0cy5vcGVud2FsbC5uZXQvbmV0ZGV2LzIwMTcv
MDQvMDIvNTUKCkl0IGRpZCBzZWVtIHRvIHNpZ25pZmljYW50bHkgcmVkdWNlIGNvbXB1dGUgY3lj
bGVzICgiR2N5YyIpIGF0IHRoZQp0aW1lLiBGb3IgaW5zdGFuY2U6CgogICAgVENQX1JSIExhdGVu
Y3kgKHVzKToKICAgIDF4OgogICAgICBwNTAgICAgICAgICAgICAgIDI0ICAgICAgIDI0ICAgICAg
IDIxCiAgICAgIHA5OSAgICAgICAgICAgICAgMjcgICAgICAgMjcgICAgICAgMjcKICAgICAgR2N5
Y2xlcyAgICAgICAgIDI5OSAgICAgIDQzMiAgICAgIDMwOAoKSSdtIGNvbmNlcm5lZCB0aGF0IHJl
bW92aW5nIGl0IG5vdyBtYXkgY2F1c2UgYSByZWdyZXNzaW9uIHJlcG9ydCBpbiBhCmZldyBtb250
aHMuIFRoYXQgaXMgaGlnaGVyIHJpc2sgdGhhbiB0aGUgc3B1cmlvdXMgaW50ZXJydXB0IHdhcm5p
bmcKdGhhdCB3YXMgb25seSByZXBvcnRlZCBhZnRlciB5ZWFycyBvZiB1c2UuCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
