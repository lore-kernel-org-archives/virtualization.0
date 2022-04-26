Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CC535C433F5
	for <virtualization@archiver.kernel.org>; Tue, 26 Apr 2022 03:43:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 66F1C82CC7;
	Tue, 26 Apr 2022 03:43:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ssLyINv5gWMD; Tue, 26 Apr 2022 03:43:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id DE792828F2;
	Tue, 26 Apr 2022 03:43:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9198AC0032;
	Tue, 26 Apr 2022 03:43:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id D047EC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 03:43:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BA6C14173C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 03:43:13 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BMmfmE-qSMsL
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 03:43:12 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6B872416E4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 03:43:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650944591;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uFxmVKYXvSZPtacNcJTM6MnScqFh9HT3TZrp7pNItgg=;
 b=A52vUBbVRNI1lgROHs0630dNtymrooA9LrBVRx6YjgDD104htOpCGqJa9LP64W6mktB6Yg
 ARPxSuQgvC69atF9ku8nvUD9A4OoTPVqUIgj4IEiLQDT2wnnQ+KEfPIjOWyPDL6L0zTsIB
 vH8uO3/xyyhNwBuCYxBCdiuYqNoRuJc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-399-VHz0HFAMOJatmU6NiO_01A-1; Mon, 25 Apr 2022 23:43:09 -0400
X-MC-Unique: VHz0HFAMOJatmU6NiO_01A-1
Received: by mail-pj1-f72.google.com with SMTP id
 t15-20020a17090a3b4f00b001d67e27715dso788318pjf.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 20:43:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=uFxmVKYXvSZPtacNcJTM6MnScqFh9HT3TZrp7pNItgg=;
 b=1dRxdkfOoXHXCFR9q83FtvnejckWP+AFVj0C5VJQfWIpymT/F69Oq3vvMFWwK0jaGM
 scRPp47wqNKkJnEUAz3OjbM8ild3hfo1jJ2OZllUyZgLyTk1dP3/hB1Nn2WK4dNc00L0
 b+8LxfoHg9z4pwkoHDVKgqNhPt3lmXytk6quBJWeH7Dwjz9Huej0BMcFz+7ohwv0M3Bb
 EG4VlYqGf8QZXW494VkaQJM8fvecsOvGB28iNjVVHg1ASnLbYk9Uriz2kQX0S3Zzgbto
 0H6hWJ93jK+b1r2cY8+unsb3sp7fn2KOVAcRBlCJWlPWRRNbAP11V7IGaRz4vnU6h1h6
 wqJg==
X-Gm-Message-State: AOAM533rOCJ58VmKuTXGXftnblhJsAmarlaHEhjWNOt797vviKGXJOQW
 dSH0GHsoQuumNz6LVaS2vmGiVSmZYJ7TQ+AfS27t1iEiAspHqwciuf+PStP0AVseXTSujw8cAWZ
 SQJmzCuVHrY212u25uK1KRzAaaGqEn9w1wrAZianvDA==
X-Received: by 2002:a17:90b:1689:b0:1d8:28f9:3ba9 with SMTP id
 kv9-20020a17090b168900b001d828f93ba9mr22293955pjb.56.1650944588676; 
 Mon, 25 Apr 2022 20:43:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxecPEtk+FpSPOmqCkDa4+7ZxcyXXxdF6EIM0b3g5xsoz9pZBoQkhEllm1rd+qlAOZyrrB5DQ==
X-Received: by 2002:a17:90b:1689:b0:1d8:28f9:3ba9 with SMTP id
 kv9-20020a17090b168900b001d828f93ba9mr22293939pjb.56.1650944588438; 
 Mon, 25 Apr 2022 20:43:08 -0700 (PDT)
Received: from [10.72.13.91] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 x4-20020a628604000000b0050d2ff56603sm7426174pfd.60.2022.04.25.20.43.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 25 Apr 2022 20:43:07 -0700 (PDT)
Message-ID: <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
Date: Tue, 26 Apr 2022 11:42:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
To: "Michael S. Tsirkin" <mst@redhat.com>, Halil Pasic <pasic@linux.ibm.com>
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-7-jasowang@redhat.com>
 <20220425040512-mutt-send-email-mst@kernel.org> <87a6c98rwf.fsf@redhat.com>
 <20220425095742-mutt-send-email-mst@kernel.org>
 <20220426042911.544477f9.pasic@linux.ibm.com>
 <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220425233604-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: paulmck@kernel.org, lulu@redhat.com, peterz@infradead.org, maz@kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, eperezma@redhat.com,
 tglx@linutronix.de
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

CuWcqCAyMDIyLzQvMjYgMTE6MzgsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4gT24gTW9u
LCBBcHIgMjUsIDIwMjIgYXQgMTE6MzU6NDFQTSAtMDQwMCwgTWljaGFlbCBTLiBUc2lya2luIHdy
b3RlOgo+PiBPbiBUdWUsIEFwciAyNiwgMjAyMiBhdCAwNDoyOToxMUFNICswMjAwLCBIYWxpbCBQ
YXNpYyB3cm90ZToKPj4+IE9uIE1vbiwgMjUgQXByIDIwMjIgMDk6NTk6NTUgLTA0MDAKPj4+ICJN
aWNoYWVsIFMuIFRzaXJraW4iIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pgo+Pj4+IE9uIE1v
biwgQXByIDI1LCAyMDIyIGF0IDEwOjU0OjI0QU0gKzAyMDAsIENvcm5lbGlhIEh1Y2sgd3JvdGU6
Cj4+Pj4+IE9uIE1vbiwgQXByIDI1IDIwMjIsICJNaWNoYWVsIFMuIFRzaXJraW4iIDxtc3RAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4+Pj4+ICAgIAo+Pj4+Pj4gT24gTW9uLCBBcHIgMjUsIDIwMjIgYXQg
MTA6NDQ6MTVBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4+PiBUaGlzIHBhdGNoIHRy
aWVzIHRvIGltcGxlbWVudCB0aGUgc3luY2hyb25pemVfY2JzKCkgZm9yIGNjdy4gRm9yIHRoZQo+
Pj4+Pj4+IHZyaW5nX2ludGVycnVwdCgpIHRoYXQgaXMgY2FsbGVkIHZpYSB2aXJ0aW9fYWlycV9o
YW5kbGVyKCksIHRoZQo+Pj4+Pj4+IHN5bmNocm9uaXphdGlvbiBpcyBzaW1wbHkgZG9uZSB2aWEg
dGhlIGFpcnFfaW5mbydzIGxvY2suIEZvciB0aGUKPj4+Pj4+PiB2cmluZ19pbnRlcnJ1cHQoKSB0
aGF0IGlzIGNhbGxlZCB2aWEgdmlydGlvX2Njd19pbnRfaGFuZGxlcigpLCBhIHBlcgo+Pj4+Pj4+
IGRldmljZSBzcGlubG9jayBmb3IgaXJxIGlzIGludHJvZHVjZWQgYW5zIHVzZWQgaW4gdGhlIHN5
bmNocm9uaXphdGlvbgo+Pj4+Pj4+IG1ldGhvZC4KPj4+Pj4+Pgo+Pj4+Pj4+IENjOiBUaG9tYXMg
R2xlaXhuZXIgPHRnbHhAbGludXRyb25peC5kZT4KPj4+Pj4+PiBDYzogUGV0ZXIgWmlqbHN0cmEg
PHBldGVyekBpbmZyYWRlYWQub3JnPgo+Pj4+Pj4+IENjOiAiUGF1bCBFLiBNY0tlbm5leSIgPHBh
dWxtY2tAa2VybmVsLm9yZz4KPj4+Pj4+PiBDYzogTWFyYyBaeW5naWVyIDxtYXpAa2VybmVsLm9y
Zz4KPj4+Pj4+PiBDYzogSGFsaWwgUGFzaWMgPHBhc2ljQGxpbnV4LmlibS5jb20+Cj4+Pj4+Pj4g
Q2M6IENvcm5lbGlhIEh1Y2sgPGNvaHVja0ByZWRoYXQuY29tPgo+Pj4+Pj4+IFNpZ25lZC1vZmYt
Ynk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+Cj4+Pj4+Pgo+Pj4+Pj4gVGhpcyBp
cyB0aGUgb25seSBvbmUgdGhhdCBpcyBnaXZpbmcgbWUgcGF1c2UuIEhhbGlsLCBDb3JuZWxpYSwK
Pj4+Pj4+IHNob3VsZCB3ZSBiZSBjb25jZXJuZWQgYWJvdXQgdGhlIHBlcmZvcm1hbmNlIGltcGFj
dCBoZXJlPwo+Pj4+Pj4gQW55IGNoYW5jZSBpdCBjYW4gYmUgdGVzdGVkPwo+Pj4+PiBXZSBjYW4g
aGF2ZSBhIGJ1bmNoIG9mIGRldmljZXMgdXNpbmcgdGhlIHNhbWUgYWlycSBzdHJ1Y3R1cmUsIGFu
ZCB0aGUKPj4+Pj4gc3luYyBjYiBjcmVhdGVzIGEgY2hva2UgcG9pbnQsIHNhbWUgYXMgcmVnaXN0
ZXJpbmcvdW5yZWdpc3RlcmluZy4KPj4+PiBCVFcgY2FuIGNhbGxiYWNrcyBmb3IgbXVsdGlwbGUg
VlFzIHJ1biBvbiBtdWx0aXBsZSBDUFVzIGF0IHRoZSBtb21lbnQ/Cj4+PiBJJ20gbm90IHN1cmUg
SSB1bmRlcnN0YW5kIHRoZSBxdWVzdGlvbi4KPj4+Cj4+PiBJIGRvIHRoaW5rIHdlIGNhbiBoYXZl
IG11bHRpcGxlIENQVXMgdGhhdCBhcmUgZXhlY3V0aW5nIHNvbWUgcG9ydGlvbiBvZgo+Pj4gdmly
dGlvX2Njd19pbnRfaGFuZGxlcigpLiBTbyBJIGd1ZXNzIHRoZSBhbnN3ZXIgaXMgeWVzLiBDb25u
aWUgd2hhdCBkbyB5b3UgdGhpbms/Cj4+Pgo+Pj4gT24gdGhlIG90aGVyIGhhbmQgd2UgY291bGQg
YWxzbyBlbmQgdXAgc2VyaWFsaXppbmcgc3luY2hyb25pemVfY2JzKCkKPj4+IGNhbGxzIGZvciBk
aWZmZXJlbnQgZGV2aWNlcyBpZiB0aGV5IGhhcHBlbiB0byB1c2UgdGhlIHNhbWUgYWlycV9pbmZv
LiBCdXQKPj4+IHRoaXMgcHJvYmFibHkgd2FzIG5vdCB5b3VyIHF1ZXN0aW9uCj4+Cj4+IEkgYW0g
bGVzcyBjb25jZXJuZWQgYWJvdXQgIHN5bmNocm9uaXplX2NicyBiZWluZyBzbG93IGFuZCBtb3Jl
IGFib3V0Cj4+IHRoZSBzbG93ZG93biBpbiBpbnRlcnJ1cHQgcHJvY2Vzc2luZyBpdHNlbGYuCj4+
Cj4+Pj4gdGhpcyBwYXRjaCBzZXJpYWxpemVzIHRoZW0gb24gYSBzcGlubG9jay4KPj4+Pgo+Pj4g
VGhvc2UgY291bGQgdGhlbiBwaWxlIHVwIG9uIHRoZSBuZXdseSBpbnRyb2R1Y2VkIHNwaW5sb2Nr
Lgo+Pj4KPj4+IFJlZ2FyZHMsCj4+PiBIYWxpbAo+PiBIbW0geWVhIC4uLiBub3QgZ29vZC4KPiBJ
cyB0aGVyZSBhbnkgb3RoZXIgd2F5IHRvIHN5bmNocm9uaXplIHdpdGggYWxsIGNhbGxiYWNrcz8K
CgpNYXliZSB1c2luZyByd2xvY2sgYXMgYWlycSBoYW5kbGVyPwoKVGhhbmtzCgoKPgo+PiAtLSAK
Pj4gTVNUCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
