Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91335C433F5
	for <virtualization@archiver.kernel.org>; Thu,  6 Oct 2022 21:07:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 066AF610F0;
	Thu,  6 Oct 2022 21:07:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 066AF610F0
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=dKk8bfqp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sR4GDkh0FjVw; Thu,  6 Oct 2022 21:07:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 754CC610A0;
	Thu,  6 Oct 2022 21:07:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 754CC610A0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30361C0033;
	Thu,  6 Oct 2022 21:07:08 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C0C7FC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Oct 2022 21:07:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 9B9918401E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Oct 2022 21:07:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 9B9918401E
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=dKk8bfqp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GAfxD4OAfrhb
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Oct 2022 21:07:05 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C671984023
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp1.osuosl.org (Postfix) with ESMTPS id C671984023
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Oct 2022 21:07:05 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id s206so2933454pgs.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 06 Oct 2022 14:07:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
 bh=5bTBLyGPfmCxkvCIzfZznH2Ifhb8gJd3z2V25tJPiD0=;
 b=dKk8bfqpece8TZo84O+skqcxluLPH+y9y7rV2xLWxGfrjAgtytR3zgHSpZ2ynt5dd4
 HrXCLreff/N1dVyFdxU1ljT97CZnmWHCQvZTLZLzkYIdeTF3nPznmMAv2eqk/v89e/QI
 YSCiqi5GugQ3S4/HoAYp6bqCN8QBAuK3gvvHCvwqwJNuqUTBt7Qx0xMFlC/o5QwuwAeq
 9tzB8Up2piU9iIE1Fm5H68ZtWkt9rU8a3E8nOtRZ322avw10TkgM532X0/Xv9wXjoYxZ
 gvP3ZwVOVGc2C+DydjHAcAKUpMkG9qc+gAQce2h3qJFc8STO4ZtM+Fy6jM8c4rW+1o76
 C9dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date;
 bh=5bTBLyGPfmCxkvCIzfZznH2Ifhb8gJd3z2V25tJPiD0=;
 b=3jCt8bbcg5VTGqFmOVqmycqwXTK8pPKWpVATJ1oPlnlL0yydBILaxZpgNQKICgfk4n
 bGx5LMmw5/f3laapDEZEHbe9WepHFGZ/SymwsOwsxsS+fW/OxQZYfow6d07RSfc/pwr0
 45LL0s/XfDwwLteu1jEnyWblOt8oHpdkAuvkt1U8rsYSOzHW1N/aWFECQiKmmng+UDgW
 KfqQxH632oyZVtt8ENWNat42n3RUMWaJQk4J/dUn1y0iLDD3Ih6FqwU4K/2K1zA8G6lZ
 lxh/L/9Pup5RR9Sz9nK9uVwFyRTQLk5Bdcghi0g4cB3ZGWIgF77TWevzgw2J528U4qbc
 Ubdw==
X-Gm-Message-State: ACrzQf3rXJMPQAp2iFhWDzY44aDSTafoeenIz86hs40PHpkVd1MTyrol
 sCqjsEU+Md8/izQb/esFA5s=
X-Google-Smtp-Source: AMsMyM6P/PidTZjuJ1+qQsyjd+J50nx98115Wq9dUPuvR3L5nFtZc04pmmeSWfJ29n8vVG5DiIoMeA==
X-Received: by 2002:a63:fa4f:0:b0:438:e26d:5ec with SMTP id
 g15-20020a63fa4f000000b00438e26d05ecmr1510069pgk.361.1665090424880; 
 Thu, 06 Oct 2022 14:07:04 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net.
 [24.6.216.183]) by smtp.gmail.com with ESMTPSA id
 n1-20020a17090a2bc100b0020a0571b354sm134439pje.57.2022.10.06.14.07.03
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Thu, 06 Oct 2022 14:07:04 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v4 2/7] Enable balloon drivers to report inflated memory
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <a8ce5c48-3efc-5ea3-6f5c-53b9e33f65c7@virtuozzo.com>
Date: Thu, 6 Oct 2022 14:07:02 -0700
Message-Id: <42C75E59-696B-41D5-BD77-68EFF0B075C6@gmail.com>
References: <20221005090158.2801592-1-alexander.atanasov@virtuozzo.com>
 <20221005090158.2801592-3-alexander.atanasov@virtuozzo.com>
 <88EDC41D-408F-4ADF-A933-0A6F36E5F262@gmail.com>
 <a8ce5c48-3efc-5ea3-6f5c-53b9e33f65c7@virtuozzo.com>
To: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
Cc: "Michael S. Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 linux-mm@kvack.org, kernel@openvz.org,
 Andrew Morton <akpm@linux-foundation.org>
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

T24gT2N0IDYsIDIwMjIsIGF0IDEyOjM0IEFNLCBBbGV4YW5kZXIgQXRhbmFzb3YgPGFsZXhhbmRl
ci5hdGFuYXNvdkB2aXJ0dW96em8uY29tPiB3cm90ZToKCj4gSGVsbG8sCj4gCj4gCj4gT24gNS4x
MC4yMiAyMDoyNSwgTmFkYXYgQW1pdCB3cm90ZToKPj4gT24gT2N0IDUsIDIwMjIsIGF0IDI6MDEg
QU0sIEFsZXhhbmRlciBBdGFuYXNvdiA8YWxleGFuZGVyLmF0YW5hc292QHZpcnR1b3p6by5jb20+
IHdyb3RlOgo+Pj4gQWRkIGNvdW50ZXJzIHRvIGJlIHVwZGF0ZWQgYnkgdGhlIGJhbGxvb24gZHJp
dmVycy4KPj4+IENyZWF0ZSBiYWxsb29uIG5vdGlmaWVyIHRvIHByb3BhZ2F0ZSBjaGFuZ2VzLgo+
PiBJIG1pc3NlZCB0aGUgb3RoZXIgcGF0Y2hlcyBiZWZvcmUgKGluY2x1ZGluZyB0aGlzIG9uZSku
IFNvcnJ5LCBidXQgbmV4dAo+PiB0aW1lLCBwbGVhc2UgY2MgbWUuCj4gCj4gWW91IGFyZSBDQ2Vk
IGluIHRoZSBjb3ZlciBsZXR0ZXIgc2luY2UgdGhlIHZlcnNpb24uIEkgd2lsbCBhZGQgQ0MgdG8g
eW91Cj4gaW4gdGhlIGluZGl2aWR1YWwgcGF0Y2hlcyBpZiB5b3Ugd2FudCBzby4KClRoYW5rcy4K
Ckp1c3QgdG8gY2xhcmlmeSAtIEkgYW0gbm90IGF0dGFja2luZyB5b3UuIEl04oCZcyBtb3JlIG9m
IG1lIG1ha2luZyBhbiBleGN1c2UKZm9yIG5vdCBhZGRyZXNzaW5nIHNvbWUgaXNzdWVzIGluIGVh
cmxpZXIgdmVyc2lvbnMuCgo+PiBJIHdhcyBsb29raW5nIHRocm91Z2ggdGhlIHNlcmllcyBhbmQg
SSBkaWQgbm90IHNlZSBhY3R1YWwgdXNlcnMgb2YgdGhlCj4+IG5vdGlmaWVyLiBVc3VhbGx5LCBp
dCBpcyBub3QgZ3JlYXQgdG8gYnVpbGQgYW4gQVBJIHdpdGhvdXQgdXNlcnMuCj4gCj4gCj4gWW91
IGFyZSByaWdodC4gSSBob3BlIHRvIGdldCBzb21lIGZlZWRiYWNrL2ludGVyZXN0IGZyb20gcG90
ZW50aWFsIHVzZXJzIHRoYXQgaSBtZW50aW9uZWQgaW4gdGhlIGNvdmVyIGxldHRlci4gSSB3aWxs
IHByb2JhYmx5IHNwbGl0IHRoZSBub3RpZmllcgo+IGluIHNlcGFyYXRlIHNlcmllcy4gVG8gbWFr
ZSBpdCB1c2VmdWxsIGl0IHdpbGwgcmVxdWlyZSBtb3JlIGNoYW5nZXMuCj4gU2VlIGJlbGxvdyBt
b3JlIGFib3V0IHRoZW0uCgpGYWlyLCBidXQgdGhpcyBpcyBzb21ldGhpbmcgdGhhdCBpcyBtb3Jl
IHN1aXRhYmxlIGZvciBSRkMuIE90aGVyd2lzZSwgbW9yZQpsaWtlbHkgdGhhbiBub3QgLSB5b3Vy
IHBhdGNoZXMgd291bGQgZ28gaW4gYXMgaXMuCgo+PiBbc25pcF0KPj4+ICsKPj4+ICtzdGF0aWMg
aW50IGJhbGxvb25fbm90aWZ5KHVuc2lnbmVkIGxvbmcgdmFsKQo+Pj4gK3sKPj4+ICsJcmV0dXJu
IHNyY3Vfbm90aWZpZXJfY2FsbF9jaGFpbigmYmFsbG9vbl9jaGFpbiwgdmFsLCBOVUxMKTsKPj4g
U2luY2UgeW91IGtub3cgdGhlIGluZmxhdGVkX2tiIHZhbHVlIGhlcmUsIHdoeSBub3QgdG8gdXNl
IGl0IGFzIGFuIGFyZ3VtZW50Cj4+IHRvIHRoZSBjYWxsYmFjaz8gSSB0aGluayBjYXN0aW5nIHRv
ICh2b2lkICopIGFuZCBiYWNrIGlzIGJlc3QuIEJ1dCB5b3UgY2FuCj4+IGFsc28gcHJvdmlkZSBw
b2ludGVyIHRvIHRoZSB2YWx1ZS4gRG9lc27igJl0IGl0IHNvdW5kIGJldHRlciB0aGFuIGhhdmlu
Zwo+PiBwb3RlbnRpYWxseSBkaWZmZXJlbnQgbm90aWZpZXJzIHJlYWRpbmcgZGlmZmVyZW50IHZh
bHVlcz8KPiAKPiBNeSBjdXJyZW50IGlkZWEgaXMgdG8gaGF2ZSBhIHN0cnVjdCB3aXRoIGN1cnJl
bnQgYW5kIHByZXZpb3VzIHZhbHVlLAo+IG1heSBiZSBjaGFuZ2UgaW4gcGVyY2VudHMuIFRoZSBh
Y3R1YWwgdmFsdWUgZG9lcyBub3QgbWF0dGVyIHRvIGFueW9uZQo+IGJ1dCB0aGUgc2l6ZSBvZiBj
aGFuZ2UgZG9lcy4gV2hlbiBhIHVzZXIgZ2V0cyBub3RpZmllZCBpdCBjYW4gYWN0IHVwb24KPiB0
aGUgY2hhbmdlIC0gaWYgaXQgaXMgc21hbGwgaXQgY2FuIGlnbm9yZSBpdCAsIGlmIGl0IGlzIGFi
b3ZlIHNvbWUgdGhyZXNob2xkIGl0IGNhbiBhY3QgLSBpZiBpdCBtYWtlcyBzZW5zZSBmb3Igc29t
ZSByZWNlaXZlciAgaXMgY2FuIGFjY3VtdWxhdGUgY2hhbmdlcyBmcm9tIHNldmVyYWwgbm90aWZp
Y2F0aW9uLiBPdGhlciBvcHRpb24vYWRkaXRpb24gaXMgdG8gaGF2ZSBzaV9tZW1pbmZvX2N1cnJl
bnQoLi4pIGFuZCB0b3RhbHJhbV9wYWdlc19jdXJyZW50KC4uKSB0aGF0IHJldHVybiB2YWx1ZXMg
YWRqdXN0ZWQgd2l0aCB0aGUgYmFsbG9vbiB2YWx1ZXMuCj4gCj4gR29pbmcgZnVydGhlciAtIHRo
ZXJlIGFyZSBmZXcgcGxhY2VzIHRoYXQgY2FsY3VsYXRlIHNvbWV0aGluZyBiYXNlZCBvbiBhdmFp
bGFibGUgbWVtb3J5IHRoYXQgZG8gbm90IGhhdmUgc3lzZnMvcHJvYyBpbnRlcmZhY2UgZm9yIHNl
dHRpbmcgbGltaXRzLiBNb3N0IG9mIHRoZW0gd29yayBpbiBwZXJjZW50cyBzbyB0aGV5IGNhbiBi
ZSBjb252ZXJ0ZWQgdG8gZG8gY2FsY3VsYXRpb25zIHdoZW4gdGhleSBnZXQgbm90aWZpY2F0aW9u
Lgo+IAo+IFRoZSBvbmUgdGhhdCBoYXZlIGludGVyZmFjZSBmb3IgY29uZmlndXJhdGlvbiBidXQg
dXNlIG1lbW9yeSB2YWx1ZXMgY2FuIGJlIGhhbmRsZWQgaW4gdHdvIHdheXMgLSBjb252ZXJ0IHRv
IHVzZSBwZXJjZW50cyBvZiB3aGF0IGlzIGF2YWlsYWJsZSBvciBleHRlbmQgdGhlIG5vdGlmaWVy
IHRvIG5vdGlmeSB1c2Vyc3BhY2Ugd2hpY2ggaW4gdHVybiB0byBkbyBjYWxjdWxhdGlvbnMgYW5k
IHVwZGF0ZSBjb25maWd1cmF0aW9uLgoKSSByZWFsbHkgbmVlZCB0byBzZWUgY29kZSB0byBmdWxs
eSB1bmRlcnN0YW5kIHdoYXQgeW91IGhhdmUgaW4gbWluZC4KRGl2aXNpb24sIGFzIHlvdSBrbm93
LCBpcyBub3Qgc29tZXRoaW5nIHRoYXQgd2UgcmVhbGx5IHdhbnQgdG8gZG8gdmVyeQpmcmVxdWVu
dGx5LgoKPj4gQW55aG93LCB3aXRob3V0IHVzZXJzIChhY3R1YWwgbm90aWZpZXJzKSBpdOKAmXMg
a2luZCBvZiBoYXJkIHRvIGtub3cgaG93Cj4+IHJlYXNvbmFibGUgaXQgYWxsIGlzLiBGb3IgaW5z
dGFuY2UsIGlzIGl0IGJhbGxvb25fbm90aWZ5KCkgc3VwcG9zZWQgdG8KPj4gcHJldmVudCBmdXJ0
aGVyIGJhbGxvb24gaW5mbGF0aW5nL2RlZmxhdGluZyB1bnRpbCB0aGUgbm90aWZpZXIgY29tcGxl
dGVzPwo+IAo+IE5vLCB3ZSBtdXN0IGF2b2lkIHRoYXQgYXQgYW55IGNvc3QuCj4gCj4+IEFjY29y
ZGluZ2x5LCBhcmUgY2FsbGVycyB0byBiYWxsb29uX25vdGlmeSgpIGV4cGVjdGVkIHRvIHJlbGlu
cXVpc2ggbG9ja3MKPj4gYmVmb3JlIGNhbGxpbmcgYmFsbG9vbl9ub3RpZnkoKSB0byBwcmV2ZW50
IGRlYWRsb2NrcyBhbmQgaGlnaCBsYXRlbmN5Pwo+IAo+IE15IGdvYWwgaXMgdG8gYXZvaWQgYW55
IHBvc3NpYmxlIGltcGFjdCBvbiBwZXJmb3JtYW5jZS4gRHJpdmVycyBhcmUgZnJlZSB0byBkZWxh
eSBub3RpZmljYXRpb25zIGlmIHRoZXkgZ2V0IGluIHRoZSB3YXkuIChJIHNlZSB0aGF0IGkgbmVl
ZCB0byBtb3ZlIHRoZSBub3RpZmljYXRpb24gYWZ0ZXIgdGhlIHNlbWFwaG9yZSBpbiB0aGUgdm13
IGRyaXZlciAtIGkgbWlzc2VkIHRoYXQgLSB3aWxsIGZpeCBpbiB0aGUgbmV4dCBpdGVycmF0aW9u
LikKPiBEZWFkbG9ja3MgLSBkZXBlbmRzIG9uIHRoZSB1c2VycyBidXQgYSBmZXcgdG8gbm9uZSB3
aWxsIHBvc3NpYmx5IGhhdmUgdG8gZGVhbCB3aXRoIGNvbW1vbiBsb2Nrcy4KCkkgd2lsbCBuZWVk
IHRvIHNlZSB0aGUgbmV4dCB2ZXJzaW9uIHRvIGdpdmUgYmV0dGVyIGZlZWRiYWNrLiBPbmUgbW9y
ZSB0aGluZwp0aGF0IGNvbWVzIHRvIG1pbmQgdGhvdWdoIGlzIHdoZXRoZXIgc2F2aW5nIHRoZSBi
YWxsb29uIHNpemUgaW4gbXVsdGlwbGUKcGxhY2VzIChib3RoIG1lbV9iYWxsb29uX2luZmxhdGVk
X3RvdGFsX2tiIGFuZCBlYWNoIGJhbGxvb27igJlzIGFjY291bnRpbmcpIGlzCnRoZSByaWdodCB3
YXkuIEl0IGRvZXMgbm90IHNvdW5kcyB2ZXJ5IGNsZWFuLgoKVHdvIG90aGVyIG9wdGlvbnMgaXMg
dG8gbW92ZSAqYWxsKiB0aGUgYWNjb3VudGluZyB0byB5b3VyIG5ldwptZW1fYmFsbG9vbl9pbmZs
YXRlZF90b3RhbF9rYi1saWtlIGludGVyZmFjZSBvciBleHBvc2Ugc29tZSBwZXItYmFsbG9vbgpm
dW5jdGlvbiB0byBnZXQgdGhlIGJhbGxvb24gc2l6ZSAoaW5kaXJlY3QtZnVuY3Rpb24tY2FsbCB3
b3VsZCBsaWtlbHkgaGF2ZQpzb21lIG92ZXJoZWFkIHRob3VnaCkuCgpBbnlob3csIEkgYW0gbm90
IGNyYXp5IGFib3V0IGhhdmluZyB0aGUgc2FtZSBkYXRhIHJlcGxpY2F0ZWQuIEV2ZW4gZnJvbQpy
ZWFkaW5nIHRoZSBjb2RlIHN0YW5kLW9mLXZpZXcgaXQgaXMgbm90IGludHVpdGl2ZS4KCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
