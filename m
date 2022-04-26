Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A6A25C433EF
	for <virtualization@archiver.kernel.org>; Tue, 26 Apr 2022 03:55:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 62C3281450;
	Tue, 26 Apr 2022 03:55:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FHN9KZcPPEWq; Tue, 26 Apr 2022 03:55:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id F40BE81448;
	Tue, 26 Apr 2022 03:55:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B9573C0032;
	Tue, 26 Apr 2022 03:55:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8F521C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 03:55:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6725A4015A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 03:55:18 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id gszR-LmQ7OEh
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 03:55:17 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 90DCE4013B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 03:55:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650945316;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k8DCgpThd7pILyojCaMETysh65rozf6ZoyV6RveS5yk=;
 b=EIqZucAHjCt/I2g/c1uGRO6CdI4GDv4sKjJ+JQzf6rnWc9axwpehLvNLqm31FVKIZr7ptu
 a97ejVktVJ3VRe95MKNdQatZf21y0NyaY2jOcBFOjOWQZDE3bbQ3EIXuz+j/JyOOhnmmRW
 aw5Zlu5NqI/6ghoVtXaBTGW5Prc1J/c=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-207-QJnn5bf-PX-L8QBPUgtbmw-1; Mon, 25 Apr 2022 23:55:15 -0400
X-MC-Unique: QJnn5bf-PX-L8QBPUgtbmw-1
Received: by mail-wr1-f72.google.com with SMTP id
 e13-20020adf9bcd000000b0020adc114131so1414428wrc.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 20:55:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=k8DCgpThd7pILyojCaMETysh65rozf6ZoyV6RveS5yk=;
 b=h1TSSYRFbjFg0izfcbFpRUz79K/sgw4gWlpCNBWt2fB0yaTgnYwCV73pW4Imypfy1i
 GOgtwNDVSGizuLx5tIATXGKSAx/hgKdkcYyp6oTzbRVC8oufsNGpq7iv+DnXyrSvhI8F
 Tbn/m5KqEbCZN7JG5j0YK09Z7n4M3SfLEKziyUi4hKs2aAXhviajzhCEQ67YZScvdb24
 sZcpqI55Y282Re9J9a9CW/hkbC7JWm7EoOqo9B2lDNO8IUseW3tnRXbwyZE+YEp+ahV/
 D/oo482IJfkLK1mqttlCAF690i0zOYwBzUJDkmbNXDNO9YEf+W1aMejDjebpCnOiU0UX
 Ft4w==
X-Gm-Message-State: AOAM531bjQ0dVibAGGiz7x8PIVC/9cd0iDsYp8Wn4wRhlUzIp3wdB5wi
 qYveV9PXoDuftcrhAJIjD1VdOBq4QCQitas3c+whGgNRhEFgZWt2VAp0vpGJIDouMZ+AoEW9r13
 Ayzm6DUYu6G/Zy+vEJGHyfRc8rmJvxWbuiz+X7sOijQ==
X-Received: by 2002:a7b:cb83:0:b0:37e:bc50:3c6b with SMTP id
 m3-20020a7bcb83000000b0037ebc503c6bmr28978714wmi.67.1650945314219; 
 Mon, 25 Apr 2022 20:55:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxUZ0sdWxGZIAvoc1Bigfd+lXNXJtNCcFHGVd5kuF2nbZVjYpDciBMefaxxcg5uKysfxdjG4w==
X-Received: by 2002:a7b:cb83:0:b0:37e:bc50:3c6b with SMTP id
 m3-20020a7bcb83000000b0037ebc503c6bmr28978700wmi.67.1650945314032; 
 Mon, 25 Apr 2022 20:55:14 -0700 (PDT)
Received: from redhat.com ([2.53.22.137]) by smtp.gmail.com with ESMTPSA id
 q128-20020a1c4386000000b003915e19d47asm12952833wma.32.2022.04.25.20.55.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Apr 2022 20:55:13 -0700 (PDT)
Date: Mon, 25 Apr 2022 23:55:09 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220425235415-mutt-send-email-mst@kernel.org>
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-7-jasowang@redhat.com>
 <20220425040512-mutt-send-email-mst@kernel.org>
 <87a6c98rwf.fsf@redhat.com>
 <20220425095742-mutt-send-email-mst@kernel.org>
 <20220426042911.544477f9.pasic@linux.ibm.com>
 <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org>
 <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
 <20220425235134-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20220425235134-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: paulmck@kernel.org, lulu@redhat.com, peterz@infradead.org, maz@kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>,
 eperezma@redhat.com, tglx@linutronix.de
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

T24gTW9uLCBBcHIgMjUsIDIwMjIgYXQgMTE6NTM6MjRQTSAtMDQwMCwgTWljaGFlbCBTLiBUc2ly
a2luIHdyb3RlOgo+IE9uIFR1ZSwgQXByIDI2LCAyMDIyIGF0IDExOjQyOjQ1QU0gKzA4MDAsIEph
c29uIFdhbmcgd3JvdGU6Cj4gPiAKPiA+IOWcqCAyMDIyLzQvMjYgMTE6MzgsIE1pY2hhZWwgUy4g
VHNpcmtpbiDlhpnpgZM6Cj4gPiA+IE9uIE1vbiwgQXByIDI1LCAyMDIyIGF0IDExOjM1OjQxUE0g
LTA0MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiA+ID4gPiBPbiBUdWUsIEFwciAyNiwg
MjAyMiBhdCAwNDoyOToxMUFNICswMjAwLCBIYWxpbCBQYXNpYyB3cm90ZToKPiA+ID4gPiA+IE9u
IE1vbiwgMjUgQXByIDIwMjIgMDk6NTk6NTUgLTA0MDAKPiA+ID4gPiA+ICJNaWNoYWVsIFMuIFRz
aXJraW4iIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gT24g
TW9uLCBBcHIgMjUsIDIwMjIgYXQgMTA6NTQ6MjRBTSArMDIwMCwgQ29ybmVsaWEgSHVjayB3cm90
ZToKPiA+ID4gPiA+ID4gPiBPbiBNb24sIEFwciAyNSAyMDIyLCAiTWljaGFlbCBTLiBUc2lya2lu
IiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiA+ID4gT24gTW9uLCBBcHIgMjUs
IDIwMjIgYXQgMTA6NDQ6MTVBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiA+ID4g
PiA+ID4gVGhpcyBwYXRjaCB0cmllcyB0byBpbXBsZW1lbnQgdGhlIHN5bmNocm9uaXplX2Nicygp
IGZvciBjY3cuIEZvciB0aGUKPiA+ID4gPiA+ID4gPiA+ID4gdnJpbmdfaW50ZXJydXB0KCkgdGhh
dCBpcyBjYWxsZWQgdmlhIHZpcnRpb19haXJxX2hhbmRsZXIoKSwgdGhlCj4gPiA+ID4gPiA+ID4g
PiA+IHN5bmNocm9uaXphdGlvbiBpcyBzaW1wbHkgZG9uZSB2aWEgdGhlIGFpcnFfaW5mbydzIGxv
Y2suIEZvciB0aGUKPiA+ID4gPiA+ID4gPiA+ID4gdnJpbmdfaW50ZXJydXB0KCkgdGhhdCBpcyBj
YWxsZWQgdmlhIHZpcnRpb19jY3dfaW50X2hhbmRsZXIoKSwgYSBwZXIKPiA+ID4gPiA+ID4gPiA+
ID4gZGV2aWNlIHNwaW5sb2NrIGZvciBpcnEgaXMgaW50cm9kdWNlZCBhbnMgdXNlZCBpbiB0aGUg
c3luY2hyb25pemF0aW9uCj4gPiA+ID4gPiA+ID4gPiA+IG1ldGhvZC4KPiA+ID4gPiA+ID4gPiA+
ID4gCj4gPiA+ID4gPiA+ID4gPiA+IENjOiBUaG9tYXMgR2xlaXhuZXIgPHRnbHhAbGludXRyb25p
eC5kZT4KPiA+ID4gPiA+ID4gPiA+ID4gQ2M6IFBldGVyIFppamxzdHJhIDxwZXRlcnpAaW5mcmFk
ZWFkLm9yZz4KPiA+ID4gPiA+ID4gPiA+ID4gQ2M6ICJQYXVsIEUuIE1jS2VubmV5IiA8cGF1bG1j
a0BrZXJuZWwub3JnPgo+ID4gPiA+ID4gPiA+ID4gPiBDYzogTWFyYyBaeW5naWVyIDxtYXpAa2Vy
bmVsLm9yZz4KPiA+ID4gPiA+ID4gPiA+ID4gQ2M6IEhhbGlsIFBhc2ljIDxwYXNpY0BsaW51eC5p
Ym0uY29tPgo+ID4gPiA+ID4gPiA+ID4gPiBDYzogQ29ybmVsaWEgSHVjayA8Y29odWNrQHJlZGhh
dC5jb20+Cj4gPiA+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+Cj4gPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiA+IFRoaXMgaXMg
dGhlIG9ubHkgb25lIHRoYXQgaXMgZ2l2aW5nIG1lIHBhdXNlLiBIYWxpbCwgQ29ybmVsaWEsCj4g
PiA+ID4gPiA+ID4gPiBzaG91bGQgd2UgYmUgY29uY2VybmVkIGFib3V0IHRoZSBwZXJmb3JtYW5j
ZSBpbXBhY3QgaGVyZT8KPiA+ID4gPiA+ID4gPiA+IEFueSBjaGFuY2UgaXQgY2FuIGJlIHRlc3Rl
ZD8KPiA+ID4gPiA+ID4gPiBXZSBjYW4gaGF2ZSBhIGJ1bmNoIG9mIGRldmljZXMgdXNpbmcgdGhl
IHNhbWUgYWlycSBzdHJ1Y3R1cmUsIGFuZCB0aGUKPiA+ID4gPiA+ID4gPiBzeW5jIGNiIGNyZWF0
ZXMgYSBjaG9rZSBwb2ludCwgc2FtZSBhcyByZWdpc3RlcmluZy91bnJlZ2lzdGVyaW5nLgo+ID4g
PiA+ID4gPiBCVFcgY2FuIGNhbGxiYWNrcyBmb3IgbXVsdGlwbGUgVlFzIHJ1biBvbiBtdWx0aXBs
ZSBDUFVzIGF0IHRoZSBtb21lbnQ/Cj4gPiA+ID4gPiBJJ20gbm90IHN1cmUgSSB1bmRlcnN0YW5k
IHRoZSBxdWVzdGlvbi4KPiA+ID4gPiA+IAo+ID4gPiA+ID4gSSBkbyB0aGluayB3ZSBjYW4gaGF2
ZSBtdWx0aXBsZSBDUFVzIHRoYXQgYXJlIGV4ZWN1dGluZyBzb21lIHBvcnRpb24gb2YKPiA+ID4g
PiA+IHZpcnRpb19jY3dfaW50X2hhbmRsZXIoKS4gU28gSSBndWVzcyB0aGUgYW5zd2VyIGlzIHll
cy4gQ29ubmllIHdoYXQgZG8geW91IHRoaW5rPwo+ID4gPiA+ID4gCj4gPiA+ID4gPiBPbiB0aGUg
b3RoZXIgaGFuZCB3ZSBjb3VsZCBhbHNvIGVuZCB1cCBzZXJpYWxpemluZyBzeW5jaHJvbml6ZV9j
YnMoKQo+ID4gPiA+ID4gY2FsbHMgZm9yIGRpZmZlcmVudCBkZXZpY2VzIGlmIHRoZXkgaGFwcGVu
IHRvIHVzZSB0aGUgc2FtZSBhaXJxX2luZm8uIEJ1dAo+ID4gPiA+ID4gdGhpcyBwcm9iYWJseSB3
YXMgbm90IHlvdXIgcXVlc3Rpb24KPiA+ID4gPiAKPiA+ID4gPiBJIGFtIGxlc3MgY29uY2VybmVk
IGFib3V0ICBzeW5jaHJvbml6ZV9jYnMgYmVpbmcgc2xvdyBhbmQgbW9yZSBhYm91dAo+ID4gPiA+
IHRoZSBzbG93ZG93biBpbiBpbnRlcnJ1cHQgcHJvY2Vzc2luZyBpdHNlbGYuCj4gPiA+ID4gCj4g
PiA+ID4gPiA+IHRoaXMgcGF0Y2ggc2VyaWFsaXplcyB0aGVtIG9uIGEgc3BpbmxvY2suCj4gPiA+
ID4gPiA+IAo+ID4gPiA+ID4gVGhvc2UgY291bGQgdGhlbiBwaWxlIHVwIG9uIHRoZSBuZXdseSBp
bnRyb2R1Y2VkIHNwaW5sb2NrLgo+ID4gPiA+ID4gCj4gPiA+ID4gPiBSZWdhcmRzLAo+ID4gPiA+
ID4gSGFsaWwKPiA+ID4gPiBIbW0geWVhIC4uLiBub3QgZ29vZC4KPiA+ID4gSXMgdGhlcmUgYW55
IG90aGVyIHdheSB0byBzeW5jaHJvbml6ZSB3aXRoIGFsbCBjYWxsYmFja3M/Cj4gPiAKPiA+IAo+
ID4gTWF5YmUgdXNpbmcgcndsb2NrIGFzIGFpcnEgaGFuZGxlcj8KPiA+IAo+ID4gVGhhbmtzCj4g
PiAKPiAKPiByd2xvY2sgaXMgc3RpbGwgYSBzaGFyZWQgY2FjaGVsaW5lIGJvdW5jaW5nIGJldHdl
ZW4gQ1BVcyBhbmQKPiBhIGJ1bmNoIG9mIG9yZGVyaW5nIGluc3RydWN0aW9ucy4KPiBNYXliZSBz
b21ldGhpbmcgcGVyLWNwdSArIHNvbWUgSVBJcyB0byBydW4gdGhpbmdzIG9uIGFsbCBDUFVzIGlu
c3RlYWQ/CgouLi4gYW5kIEkgdGhpbmsgY2xhc3NpYyBhbmQgZGV2aWNlIGludGVycnVwdHMgYXJl
IGRpZmZlcmVudCBlbm91Z2gKaGVyZSAuLi4KCj4gPiA+IAo+ID4gPiA+IC0tIAo+ID4gPiA+IE1T
VAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
