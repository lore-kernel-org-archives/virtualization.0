Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5758C433F5
	for <virtualization@archiver.kernel.org>; Tue, 26 Apr 2022 06:30:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 8835782C84;
	Tue, 26 Apr 2022 06:30:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id L4lb1IVGC6nO; Tue, 26 Apr 2022 06:30:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1086482865;
	Tue, 26 Apr 2022 06:30:16 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B5AD6C0039;
	Tue, 26 Apr 2022 06:30:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 9F3ADC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 06:30:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 955CA82909
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 06:30:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id RFWE0dhVamh3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 06:30:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 73E7082865
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 06:30:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650954610;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=V7VQIxc2enYPlbUgW2+LE7wrg1Lnj3sGptBhnMeOEwQ=;
 b=b4yCqzpG1fRqEfAMHOumbbQts/0PwYzA1lfRf/vg9+D7gTA/KFcnR6t+SyjOS1aGdMrjfe
 pHI7yoaARaCLAvt51Ccp8JPe61F9GRF52vTJBL0Fb9bvCccU46PYOIIEp9wayqwm/8L2UN
 RqADYaZP/Hp6A41pM2uVhbN17OUakUQ=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-389-capNZMQKPkCBAx9PN6BLuQ-1; Tue, 26 Apr 2022 02:30:07 -0400
X-MC-Unique: capNZMQKPkCBAx9PN6BLuQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 l11-20020adfc78b000000b0020abc1ce7e4so3416155wrg.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 23:30:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=V7VQIxc2enYPlbUgW2+LE7wrg1Lnj3sGptBhnMeOEwQ=;
 b=mQvwxRs5sMU5DEELh9wbBaCYZOahNvVQy1bQfitHUh9wg85V5/T/dq9hFASgBwuBhj
 g8zOPHoZ38NUq3Aq/tNJBcMsU+61M29hy2zBUDa103WnujYTGgjx0gt0tBa329lH5Vo9
 zfME5WzTyKtxfuaSi8Po6WCUxSr6N0iNEAnKHHed6WOyuj7rtVdT4phWUB70Wvo/Dvou
 vuvUJWx/0CMOu4goGRUefBn7zx4nt88k5WJHGJwL9I9pKxWZ7hNimJKy8Xio4v/m/5JU
 uuTEejCTtjTCL4934hzOQ04MN25eRsaLNCR1H1HfYh/QpTCZ59FQ8LQzuMhbaSq2RVpC
 ic/g==
X-Gm-Message-State: AOAM532c2AVhsEfOfOBnYg8w1oCHpw8rJLTi6HJVu393joCSyzFO1UcX
 tnvWG/aAj4gEqQQMTXgMK2WISqtskVhursgvmw4gOoQrm7hqCgppcdeeqVr5G8wnQUXbfOvUw+o
 e03z11gnYL1dXw8MquVSpDnYkmTioCylfsS580vXf0Q==
X-Received: by 2002:adf:db46:0:b0:20a:c903:4711 with SMTP id
 f6-20020adfdb46000000b0020ac9034711mr15430191wrj.625.1650954605943; 
 Mon, 25 Apr 2022 23:30:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyNRarFYV3D7gCGqSQ56FDt3rR3NZYRd0yD8ep+RHjYur6XMku/TQPdgMHlcQhhlsKNogy/Pg==
X-Received: by 2002:adf:db46:0:b0:20a:c903:4711 with SMTP id
 f6-20020adfdb46000000b0020ac9034711mr15430177wrj.625.1650954605766; 
 Mon, 25 Apr 2022 23:30:05 -0700 (PDT)
Received: from redhat.com ([2.53.22.137]) by smtp.gmail.com with ESMTPSA id
 l5-20020adfa385000000b0020adb3ae75dsm4701707wrb.3.2022.04.25.23.30.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Apr 2022 23:30:04 -0700 (PDT)
Date: Tue, 26 Apr 2022 02:30:00 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220426022420-mutt-send-email-mst@kernel.org>
References: <20220425040512-mutt-send-email-mst@kernel.org>
 <87a6c98rwf.fsf@redhat.com>
 <20220425095742-mutt-send-email-mst@kernel.org>
 <20220426042911.544477f9.pasic@linux.ibm.com>
 <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org>
 <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org>
 <20220425235415-mutt-send-email-mst@kernel.org>
 <CACGkMEve+3ugK-Kgao3_2wbjb=fbF7AO2uEuArGjKgEAQcGdiQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEve+3ugK-Kgao3_2wbjb=fbF7AO2uEuArGjKgEAQcGdiQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

T24gVHVlLCBBcHIgMjYsIDIwMjIgYXQgMTI6MDc6MzlQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUdWUsIEFwciAyNiwgMjAyMiBhdCAxMTo1NSBBTSBNaWNoYWVsIFMuIFRzaXJraW4g
PG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiBPbiBNb24sIEFwciAyNSwgMjAyMiBhdCAx
MTo1MzoyNFBNIC0wNDAwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+IE9uIFR1ZSwg
QXByIDI2LCAyMDIyIGF0IDExOjQyOjQ1QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+
ID4KPiA+ID4gPiDlnKggMjAyMi80LzI2IDExOjM4LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGT
Ogo+ID4gPiA+ID4gT24gTW9uLCBBcHIgMjUsIDIwMjIgYXQgMTE6MzU6NDFQTSAtMDQwMCwgTWlj
aGFlbCBTLiBUc2lya2luIHdyb3RlOgo+ID4gPiA+ID4gPiBPbiBUdWUsIEFwciAyNiwgMjAyMiBh
dCAwNDoyOToxMUFNICswMjAwLCBIYWxpbCBQYXNpYyB3cm90ZToKPiA+ID4gPiA+ID4gPiBPbiBN
b24sIDI1IEFwciAyMDIyIDA5OjU5OjU1IC0wNDAwCj4gPiA+ID4gPiA+ID4gIk1pY2hhZWwgUy4g
VHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4g
PiA+ID4gT24gTW9uLCBBcHIgMjUsIDIwMjIgYXQgMTA6NTQ6MjRBTSArMDIwMCwgQ29ybmVsaWEg
SHVjayB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4gT24gTW9uLCBBcHIgMjUgMjAyMiwgIk1pY2hh
ZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPiA+ID4gPiA+ID4g
PiBPbiBNb24sIEFwciAyNSwgMjAyMiBhdCAxMDo0NDoxNUFNICswODAwLCBKYXNvbiBXYW5nIHdy
b3RlOgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gVGhpcyBwYXRjaCB0cmllcyB0byBpbXBsZW1lbnQg
dGhlIHN5bmNocm9uaXplX2NicygpIGZvciBjY3cuIEZvciB0aGUKPiA+ID4gPiA+ID4gPiA+ID4g
PiA+IHZyaW5nX2ludGVycnVwdCgpIHRoYXQgaXMgY2FsbGVkIHZpYSB2aXJ0aW9fYWlycV9oYW5k
bGVyKCksIHRoZQo+ID4gPiA+ID4gPiA+ID4gPiA+ID4gc3luY2hyb25pemF0aW9uIGlzIHNpbXBs
eSBkb25lIHZpYSB0aGUgYWlycV9pbmZvJ3MgbG9jay4gRm9yIHRoZQo+ID4gPiA+ID4gPiA+ID4g
PiA+ID4gdnJpbmdfaW50ZXJydXB0KCkgdGhhdCBpcyBjYWxsZWQgdmlhIHZpcnRpb19jY3dfaW50
X2hhbmRsZXIoKSwgYSBwZXIKPiA+ID4gPiA+ID4gPiA+ID4gPiA+IGRldmljZSBzcGlubG9jayBm
b3IgaXJxIGlzIGludHJvZHVjZWQgYW5zIHVzZWQgaW4gdGhlIHN5bmNocm9uaXphdGlvbgo+ID4g
PiA+ID4gPiA+ID4gPiA+ID4gbWV0aG9kLgo+ID4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiA+ID4gPiA+IENjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4KPiA+
ID4gPiA+ID4gPiA+ID4gPiA+IENjOiBQZXRlciBaaWpsc3RyYSA8cGV0ZXJ6QGluZnJhZGVhZC5v
cmc+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBDYzogIlBhdWwgRS4gTWNLZW5uZXkiIDxwYXVsbWNr
QGtlcm5lbC5vcmc+Cj4gPiA+ID4gPiA+ID4gPiA+ID4gPiBDYzogTWFyYyBaeW5naWVyIDxtYXpA
a2VybmVsLm9yZz4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IENjOiBIYWxpbCBQYXNpYyA8cGFzaWNA
bGludXguaWJtLmNvbT4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IENjOiBDb3JuZWxpYSBIdWNrIDxj
b2h1Y2tAcmVkaGF0LmNvbT4KPiA+ID4gPiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4gPiA+ID4gPiA+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gPiA+ID4gPiBUaGlzIGlzIHRoZSBvbmx5IG9uZSB0aGF0IGlzIGdpdmluZyBtZSBwYXVz
ZS4gSGFsaWwsIENvcm5lbGlhLAo+ID4gPiA+ID4gPiA+ID4gPiA+IHNob3VsZCB3ZSBiZSBjb25j
ZXJuZWQgYWJvdXQgdGhlIHBlcmZvcm1hbmNlIGltcGFjdCBoZXJlPwo+ID4gPiA+ID4gPiA+ID4g
PiA+IEFueSBjaGFuY2UgaXQgY2FuIGJlIHRlc3RlZD8KPiA+ID4gPiA+ID4gPiA+ID4gV2UgY2Fu
IGhhdmUgYSBidW5jaCBvZiBkZXZpY2VzIHVzaW5nIHRoZSBzYW1lIGFpcnEgc3RydWN0dXJlLCBh
bmQgdGhlCj4gPiA+ID4gPiA+ID4gPiA+IHN5bmMgY2IgY3JlYXRlcyBhIGNob2tlIHBvaW50LCBz
YW1lIGFzIHJlZ2lzdGVyaW5nL3VucmVnaXN0ZXJpbmcuCj4gPiA+ID4gPiA+ID4gPiBCVFcgY2Fu
IGNhbGxiYWNrcyBmb3IgbXVsdGlwbGUgVlFzIHJ1biBvbiBtdWx0aXBsZSBDUFVzIGF0IHRoZSBt
b21lbnQ/Cj4gPiA+ID4gPiA+ID4gSSdtIG5vdCBzdXJlIEkgdW5kZXJzdGFuZCB0aGUgcXVlc3Rp
b24uCj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBJIGRvIHRoaW5rIHdlIGNhbiBoYXZlIG11
bHRpcGxlIENQVXMgdGhhdCBhcmUgZXhlY3V0aW5nIHNvbWUgcG9ydGlvbiBvZgo+ID4gPiA+ID4g
PiA+IHZpcnRpb19jY3dfaW50X2hhbmRsZXIoKS4gU28gSSBndWVzcyB0aGUgYW5zd2VyIGlzIHll
cy4gQ29ubmllIHdoYXQgZG8geW91IHRoaW5rPwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4g
T24gdGhlIG90aGVyIGhhbmQgd2UgY291bGQgYWxzbyBlbmQgdXAgc2VyaWFsaXppbmcgc3luY2hy
b25pemVfY2JzKCkKPiA+ID4gPiA+ID4gPiBjYWxscyBmb3IgZGlmZmVyZW50IGRldmljZXMgaWYg
dGhleSBoYXBwZW4gdG8gdXNlIHRoZSBzYW1lIGFpcnFfaW5mby4gQnV0Cj4gPiA+ID4gPiA+ID4g
dGhpcyBwcm9iYWJseSB3YXMgbm90IHlvdXIgcXVlc3Rpb24KPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gSSBhbSBsZXNzIGNvbmNlcm5lZCBhYm91dCAgc3luY2hyb25pemVfY2JzIGJlaW5nIHNsb3cg
YW5kIG1vcmUgYWJvdXQKPiA+ID4gPiA+ID4gdGhlIHNsb3dkb3duIGluIGludGVycnVwdCBwcm9j
ZXNzaW5nIGl0c2VsZi4KPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiA+IHRoaXMgcGF0Y2ggc2Vy
aWFsaXplcyB0aGVtIG9uIGEgc3BpbmxvY2suCj4gPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+
IFRob3NlIGNvdWxkIHRoZW4gcGlsZSB1cCBvbiB0aGUgbmV3bHkgaW50cm9kdWNlZCBzcGlubG9j
ay4KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IFJlZ2FyZHMsCj4gPiA+ID4gPiA+ID4gSGFs
aWwKPiA+ID4gPiA+ID4gSG1tIHllYSAuLi4gbm90IGdvb2QuCj4gPiA+ID4gPiBJcyB0aGVyZSBh
bnkgb3RoZXIgd2F5IHRvIHN5bmNocm9uaXplIHdpdGggYWxsIGNhbGxiYWNrcz8KPiA+ID4gPgo+
ID4gPiA+Cj4gPiA+ID4gTWF5YmUgdXNpbmcgcndsb2NrIGFzIGFpcnEgaGFuZGxlcj8KPiA+ID4g
Pgo+ID4gPiA+IFRoYW5rcwo+ID4gPiA+Cj4gPiA+Cj4gPiA+IHJ3bG9jayBpcyBzdGlsbCBhIHNo
YXJlZCBjYWNoZWxpbmUgYm91bmNpbmcgYmV0d2VlbiBDUFVzIGFuZAo+ID4gPiBhIGJ1bmNoIG9m
IG9yZGVyaW5nIGluc3RydWN0aW9ucy4KPiAKPiBZZXMsIGJ1dCBpdCBzaG91bGQgYmUgZmFzdGVy
IHRoYW4gc3BpbmxvY2tzIGFueWhvdy4KPiAKPiA+ID4gTWF5YmUgc29tZXRoaW5nIHBlci1jcHUg
KyBzb21lIElQSXMgdG8gcnVuIHRoaW5ncyBvbiBhbGwgQ1BVcyBpbnN0ZWFkPwo+IAo+IElzIHRo
aXMgc29tZXRoaW5nIGxpa2UgYSBjdXN0b21pemVkIHZlcnNpb24gb2Ygc3luY2hyb256aWVfcmN1
X2V4cGVkaXRlZCgpPwoKV2l0aCBpbnRlcnJ1cHRzIHJ1bm5pbmcgaW4gYW4gUkNVIHJlYWQgc2l6
ZSBjcml0aWNhbCBzZWN0aW9uPwpRdWl0ZSBwb3NzaWJseSB0aGF0IGlzIGFsc28gYW4gb3B0aW9u
LgpUaGlzIHdpbGwgbmVlZCBhIGJ1bmNoIG9mIGRvY3VtZW50YXRpb24gc2luY2UgdGhpcyBpcyBu
b3QKYSBzdGFuZGFyZCB1c2Ugb2YgUkNVLCBhbmQgcHJvYmFibHkgZ2V0IGEgY29uZmlybWF0aW9u
CmZyb20gUkNVIG1haW50YWluZXJzIHRoYXQgd2hhdGV2ZXIgYXNzdW1wdGlvbnMgd2UgbWFrZQph
cmUgZ3VhcmFudGVlZCB0byBob2xkIGRvd24gdGhlIHJvYWQuCgo+ID4KPiA+IC4uLiBhbmQgSSB0
aGluayBjbGFzc2ljIGFuZCBkZXZpY2UgaW50ZXJydXB0cyBhcmUgZGlmZmVyZW50IGVub3VnaAo+
ID4gaGVyZSAuLi4KPiAKPiBZZXMuCj4gCj4gVGhhbmtzCj4gCj4gPgo+ID4gPiA+ID4KPiA+ID4g
PiA+ID4gLS0KPiA+ID4gPiA+ID4gTVNUCj4gPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
