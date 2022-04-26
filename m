Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A79A5C433F5
	for <virtualization@archiver.kernel.org>; Tue, 26 Apr 2022 04:08:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3551A4049D;
	Tue, 26 Apr 2022 04:08:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8bI1K5iQ0InX; Tue, 26 Apr 2022 04:08:02 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 95AD9400AB;
	Tue, 26 Apr 2022 04:08:01 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 52E46C0032;
	Tue, 26 Apr 2022 04:08:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 67904C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 04:08:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4B7A04013B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 04:08:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hLIYuUKGeDiM
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 04:07:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D2685400AB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 04:07:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650946074;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AuGMiVQ54UHeSvg8sdwlcgbUOg1bzj5/F3tz+KJ+Q24=;
 b=E81ve1K6nSzXW0qyCp9KTTqaKVQl0gUrDeKWHWVc7nJebgr4G4ggRFtUM+P61cv7i7m19n
 aqWYQ0qg0IIJ3jdrnWkBU2PpG6MuyFbzVkhIYJYInMqbbdiOQwkvFCwafQBfx9h88yVRn3
 yZ37nUsNxlG2dqp001b+4QStDpfB2Tg=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-475-Ezu_DTwUOfStEA7y7Ya6PQ-1; Tue, 26 Apr 2022 00:07:53 -0400
X-MC-Unique: Ezu_DTwUOfStEA7y7Ya6PQ-1
Received: by mail-lf1-f72.google.com with SMTP id
 j7-20020a05651231c700b00471d875f78aso5091021lfe.22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 21:07:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=AuGMiVQ54UHeSvg8sdwlcgbUOg1bzj5/F3tz+KJ+Q24=;
 b=GDOjpT4L3pseVDTYF2khfLOGXwoaUeWVxNPgFtWXZcYA97aRdhfYyFiGScqGUxPT2D
 gC41R96MNWvHyyZLdXX23a/w4ZL28Lnn7M1Tvnszn26pnt2lJgvLzk+ECfkE3qowz7/3
 pnBDOH1kyj91L3NwX4uJQqXw8NicsocYt3JQtcBQnuTdHuA1vjjJZww5kb5jxUy87wWy
 nJqt5hYapJ65l7nXpXPUHCS0cMuYrNaIRX9CD/NuNVIzkQwCavjB6v0d9bqkqNCQpA7/
 r1us+UGnD6KSw667RCfvKdSrCWHKHMH4mO/llBcSw1JdNbKuYjhG88fjwqXd1d7ehKt4
 uVQA==
X-Gm-Message-State: AOAM5323Go4uMy+ibOL/YiWCd+zMjQ4n+u4S4hfKiAIl29OFJ41UJxLD
 i73TZx0YUpMDXazCS1K/FS+UG7hi1Mnb48zWAeC2RKPTntSLBiueG3CBuz4bNl3bW0aVeFz/dMa
 u3yf0tSFBmVOivSAtnsOfsndOwVhpEEZnRNkTJU0tlYCxFEkVhAw9Amhpog==
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id
 b1-20020a0565120b8100b00448b342513cmr15264143lfv.257.1650946071300; 
 Mon, 25 Apr 2022 21:07:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8cMRgeJdLRR9nm75CnO2Nx0KqwdQSMGUUkDvsKw8o5celdKNAmeZb54EkxXEys10n8QzGyW2l09PAXlsiqFA=
X-Received: by 2002:a05:6512:b81:b0:448:b342:513c with SMTP id
 b1-20020a0565120b8100b00448b342513cmr15264132lfv.257.1650946071111; Mon, 25
 Apr 2022 21:07:51 -0700 (PDT)
MIME-Version: 1.0
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-7-jasowang@redhat.com>
 <20220425040512-mutt-send-email-mst@kernel.org> <87a6c98rwf.fsf@redhat.com>
 <20220425095742-mutt-send-email-mst@kernel.org>
 <20220426042911.544477f9.pasic@linux.ibm.com>
 <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org>
 <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org>
 <20220425235415-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220425235415-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Apr 2022 12:07:39 +0800
Message-ID: <CACGkMEve+3ugK-Kgao3_2wbjb=fbF7AO2uEuArGjKgEAQcGdiQ@mail.gmail.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Cindy Lu <lulu@redhat.com>,
 Peter Zijlstra <peterz@infradead.org>, Marc Zyngier <maz@kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, eperezma <eperezma@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

T24gVHVlLCBBcHIgMjYsIDIwMjIgYXQgMTE6NTUgQU0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RA
cmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBNb24sIEFwciAyNSwgMjAyMiBhdCAxMTo1MzoyNFBN
IC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiBPbiBUdWUsIEFwciAyNiwgMjAy
MiBhdCAxMTo0Mjo0NUFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+ID4gPgo+ID4gPiDlnKgg
MjAyMi80LzI2IDExOjM4LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+ID4gPiA+IE9uIE1v
biwgQXByIDI1LCAyMDIyIGF0IDExOjM1OjQxUE0gLTA0MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3
cm90ZToKPiA+ID4gPiA+IE9uIFR1ZSwgQXByIDI2LCAyMDIyIGF0IDA0OjI5OjExQU0gKzAyMDAs
IEhhbGlsIFBhc2ljIHdyb3RlOgo+ID4gPiA+ID4gPiBPbiBNb24sIDI1IEFwciAyMDIyIDA5OjU5
OjU1IC0wNDAwCj4gPiA+ID4gPiA+ICJNaWNoYWVsIFMuIFRzaXJraW4iIDxtc3RAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gT24gTW9uLCBBcHIgMjUsIDIwMjIg
YXQgMTA6NTQ6MjRBTSArMDIwMCwgQ29ybmVsaWEgSHVjayB3cm90ZToKPiA+ID4gPiA+ID4gPiA+
IE9uIE1vbiwgQXByIDI1IDIwMjIsICJNaWNoYWVsIFMuIFRzaXJraW4iIDxtc3RAcmVkaGF0LmNv
bT4gd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+IE9uIE1vbiwgQXByIDI1LCAyMDIyIGF0IDEwOjQ0
OjE1QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiA+ID4gVGhpcyBw
YXRjaCB0cmllcyB0byBpbXBsZW1lbnQgdGhlIHN5bmNocm9uaXplX2NicygpIGZvciBjY3cuIEZv
ciB0aGUKPiA+ID4gPiA+ID4gPiA+ID4gPiB2cmluZ19pbnRlcnJ1cHQoKSB0aGF0IGlzIGNhbGxl
ZCB2aWEgdmlydGlvX2FpcnFfaGFuZGxlcigpLCB0aGUKPiA+ID4gPiA+ID4gPiA+ID4gPiBzeW5j
aHJvbml6YXRpb24gaXMgc2ltcGx5IGRvbmUgdmlhIHRoZSBhaXJxX2luZm8ncyBsb2NrLiBGb3Ig
dGhlCj4gPiA+ID4gPiA+ID4gPiA+ID4gdnJpbmdfaW50ZXJydXB0KCkgdGhhdCBpcyBjYWxsZWQg
dmlhIHZpcnRpb19jY3dfaW50X2hhbmRsZXIoKSwgYSBwZXIKPiA+ID4gPiA+ID4gPiA+ID4gPiBk
ZXZpY2Ugc3BpbmxvY2sgZm9yIGlycSBpcyBpbnRyb2R1Y2VkIGFucyB1c2VkIGluIHRoZSBzeW5j
aHJvbml6YXRpb24KPiA+ID4gPiA+ID4gPiA+ID4gPiBtZXRob2QuCj4gPiA+ID4gPiA+ID4gPiA+
ID4KPiA+ID4gPiA+ID4gPiA+ID4gPiBDYzogVGhvbWFzIEdsZWl4bmVyIDx0Z2x4QGxpbnV0cm9u
aXguZGU+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gQ2M6IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5m
cmFkZWFkLm9yZz4KPiA+ID4gPiA+ID4gPiA+ID4gPiBDYzogIlBhdWwgRS4gTWNLZW5uZXkiIDxw
YXVsbWNrQGtlcm5lbC5vcmc+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gQ2M6IE1hcmMgWnluZ2llciA8
bWF6QGtlcm5lbC5vcmc+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gQ2M6IEhhbGlsIFBhc2ljIDxwYXNp
Y0BsaW51eC5pYm0uY29tPgo+ID4gPiA+ID4gPiA+ID4gPiA+IENjOiBDb3JuZWxpYSBIdWNrIDxj
b2h1Y2tAcmVkaGF0LmNvbT4KPiA+ID4gPiA+ID4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNv
biBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4gPiBUaGlzIGlzIHRoZSBvbmx5IG9uZSB0aGF0IGlzIGdpdmluZyBtZSBwYXVzZS4gSGFs
aWwsIENvcm5lbGlhLAo+ID4gPiA+ID4gPiA+ID4gPiBzaG91bGQgd2UgYmUgY29uY2VybmVkIGFi
b3V0IHRoZSBwZXJmb3JtYW5jZSBpbXBhY3QgaGVyZT8KPiA+ID4gPiA+ID4gPiA+ID4gQW55IGNo
YW5jZSBpdCBjYW4gYmUgdGVzdGVkPwo+ID4gPiA+ID4gPiA+ID4gV2UgY2FuIGhhdmUgYSBidW5j
aCBvZiBkZXZpY2VzIHVzaW5nIHRoZSBzYW1lIGFpcnEgc3RydWN0dXJlLCBhbmQgdGhlCj4gPiA+
ID4gPiA+ID4gPiBzeW5jIGNiIGNyZWF0ZXMgYSBjaG9rZSBwb2ludCwgc2FtZSBhcyByZWdpc3Rl
cmluZy91bnJlZ2lzdGVyaW5nLgo+ID4gPiA+ID4gPiA+IEJUVyBjYW4gY2FsbGJhY2tzIGZvciBt
dWx0aXBsZSBWUXMgcnVuIG9uIG11bHRpcGxlIENQVXMgYXQgdGhlIG1vbWVudD8KPiA+ID4gPiA+
ID4gSSdtIG5vdCBzdXJlIEkgdW5kZXJzdGFuZCB0aGUgcXVlc3Rpb24uCj4gPiA+ID4gPiA+Cj4g
PiA+ID4gPiA+IEkgZG8gdGhpbmsgd2UgY2FuIGhhdmUgbXVsdGlwbGUgQ1BVcyB0aGF0IGFyZSBl
eGVjdXRpbmcgc29tZSBwb3J0aW9uIG9mCj4gPiA+ID4gPiA+IHZpcnRpb19jY3dfaW50X2hhbmRs
ZXIoKS4gU28gSSBndWVzcyB0aGUgYW5zd2VyIGlzIHllcy4gQ29ubmllIHdoYXQgZG8geW91IHRo
aW5rPwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBPbiB0aGUgb3RoZXIgaGFuZCB3ZSBjb3VsZCBh
bHNvIGVuZCB1cCBzZXJpYWxpemluZyBzeW5jaHJvbml6ZV9jYnMoKQo+ID4gPiA+ID4gPiBjYWxs
cyBmb3IgZGlmZmVyZW50IGRldmljZXMgaWYgdGhleSBoYXBwZW4gdG8gdXNlIHRoZSBzYW1lIGFp
cnFfaW5mby4gQnV0Cj4gPiA+ID4gPiA+IHRoaXMgcHJvYmFibHkgd2FzIG5vdCB5b3VyIHF1ZXN0
aW9uCj4gPiA+ID4gPgo+ID4gPiA+ID4gSSBhbSBsZXNzIGNvbmNlcm5lZCBhYm91dCAgc3luY2hy
b25pemVfY2JzIGJlaW5nIHNsb3cgYW5kIG1vcmUgYWJvdXQKPiA+ID4gPiA+IHRoZSBzbG93ZG93
biBpbiBpbnRlcnJ1cHQgcHJvY2Vzc2luZyBpdHNlbGYuCj4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
IHRoaXMgcGF0Y2ggc2VyaWFsaXplcyB0aGVtIG9uIGEgc3BpbmxvY2suCj4gPiA+ID4gPiA+ID4K
PiA+ID4gPiA+ID4gVGhvc2UgY291bGQgdGhlbiBwaWxlIHVwIG9uIHRoZSBuZXdseSBpbnRyb2R1
Y2VkIHNwaW5sb2NrLgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBSZWdhcmRzLAo+ID4gPiA+ID4g
PiBIYWxpbAo+ID4gPiA+ID4gSG1tIHllYSAuLi4gbm90IGdvb2QuCj4gPiA+ID4gSXMgdGhlcmUg
YW55IG90aGVyIHdheSB0byBzeW5jaHJvbml6ZSB3aXRoIGFsbCBjYWxsYmFja3M/Cj4gPiA+Cj4g
PiA+Cj4gPiA+IE1heWJlIHVzaW5nIHJ3bG9jayBhcyBhaXJxIGhhbmRsZXI/Cj4gPiA+Cj4gPiA+
IFRoYW5rcwo+ID4gPgo+ID4KPiA+IHJ3bG9jayBpcyBzdGlsbCBhIHNoYXJlZCBjYWNoZWxpbmUg
Ym91bmNpbmcgYmV0d2VlbiBDUFVzIGFuZAo+ID4gYSBidW5jaCBvZiBvcmRlcmluZyBpbnN0cnVj
dGlvbnMuCgpZZXMsIGJ1dCBpdCBzaG91bGQgYmUgZmFzdGVyIHRoYW4gc3BpbmxvY2tzIGFueWhv
dy4KCj4gPiBNYXliZSBzb21ldGhpbmcgcGVyLWNwdSArIHNvbWUgSVBJcyB0byBydW4gdGhpbmdz
IG9uIGFsbCBDUFVzIGluc3RlYWQ/CgpJcyB0aGlzIHNvbWV0aGluZyBsaWtlIGEgY3VzdG9taXpl
ZCB2ZXJzaW9uIG9mIHN5bmNocm9uemllX3JjdV9leHBlZGl0ZWQoKT8KCj4KPiAuLi4gYW5kIEkg
dGhpbmsgY2xhc3NpYyBhbmQgZGV2aWNlIGludGVycnVwdHMgYXJlIGRpZmZlcmVudCBlbm91Z2gK
PiBoZXJlIC4uLgoKWWVzLgoKVGhhbmtzCgo+Cj4gPiA+ID4KPiA+ID4gPiA+IC0tCj4gPiA+ID4g
PiBNU1QKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
