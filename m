Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 035C5CDB465
	for <virtualization@archiver.kernel.org>; Tue, 17 Oct 2023 03:21:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7AD8F4029F;
	Tue, 17 Oct 2023 03:21:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7AD8F4029F
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=i6CpBNZW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id vqJ1a-bZUMEg; Tue, 17 Oct 2023 03:21:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 84B61400EC;
	Tue, 17 Oct 2023 03:21:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 84B61400EC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 51FBBC0071;
	Tue, 17 Oct 2023 03:21:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C229C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 03:20:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id E181D60F7B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 03:20:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E181D60F7B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=i6CpBNZW
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Lg9liCfKubYY
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 03:20:57 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B904960ED6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 17 Oct 2023 03:20:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B904960ED6
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697512856;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dQBANuGLA2Qaczjxyv0Yf+lURIM7hVcQNEeOyQdlaF0=;
 b=i6CpBNZW+BU+mnTrk85ChCGqx0h0faWxnNnxWEWwU1UgR0Q+GsB5qQ9jmlD/xXV7G4ZpIx
 eY9xTXfVJ4XUvOs0XsnQmt8Yb+vIgJoTWD+lqtXanC1Ugu8tVx4lt42Bva9SA+UwVDBViE
 I/jX0naY2E3wi4BLA/D6HivnpjAICUo=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-20-03HB-uISPDunTfCTj60u5Q-1; Mon, 16 Oct 2023 23:20:54 -0400
X-MC-Unique: 03HB-uISPDunTfCTj60u5Q-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2c28a2793bcso49597561fa.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Oct 2023 20:20:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697512853; x=1698117653;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dQBANuGLA2Qaczjxyv0Yf+lURIM7hVcQNEeOyQdlaF0=;
 b=Ycw8dQWSjr4AtWnHrHCaGaJcxwZH4jXPtVLInf6wcPTzQ7bC5TLNRGTyCJrHPQr049
 24zjXXvsJp7IVViznR04SBg7zdOAFxa6yIgUMtHAXF3Bbw0k7V8DokRHC6Djqk9wz90q
 RZx89lqkBh2HyAwqAylH9ifmQ0mOdOHmD7FzvXB9WddiQAqTIdcMNbTfuh7agr0BGPfV
 LbpAwsStLzMDB0KqQq8pyoOnIWBLYL5pj5zOMq4sOB/E+Rr4cL/DtZjY7YiFc8ZB3HOm
 FrvRwEa/x7aGdDEM/eEpYwkmST6yPsb4LqVUq5OPdhfQiapRAc80tHzpN56m5UvUWqPQ
 21/Q==
X-Gm-Message-State: AOJu0Ywky+BC99ycz/N9b/Rn0sJYFLFjvbzZ+wRoJaJG5PNkDz7twWaH
 wtTo+69uXWo2ovjAD2jqGj20A+02Rohr2sswM07YwWfW+QuIHh+qahBOuSwdFhjvgGhhqvyc2rj
 TUyuTY4CpDNTUE7zUzfCm3Pmp3vyIp2FVmscrt97FQ/wNAnEp0xvqhdB+Vw==
X-Received: by 2002:a19:2d1b:0:b0:4f8:6d9d:abe0 with SMTP id
 k27-20020a192d1b000000b004f86d9dabe0mr307423lfj.33.1697512853459; 
 Mon, 16 Oct 2023 20:20:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEriSO1NnxU3cWGUDSHPSou5pJhfNNgUsEOrGIO0a9jE2MpZhdAKIqP4yHxef6EH0GJZb2STXQJZXTCtFqBkAI=
X-Received: by 2002:a19:2d1b:0:b0:4f8:6d9d:abe0 with SMTP id
 k27-20020a192d1b000000b004f86d9dabe0mr307414lfj.33.1697512853053; Mon, 16 Oct
 2023 20:20:53 -0700 (PDT)
MIME-Version: 1.0
References: <20231016120033.26933-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEs4u-4ch2UAK14hNfKeORjqMu4BX7=46OfaXpvxW+VT7w@mail.gmail.com>
 <1697511725.2037013-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1697511725.2037013-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 17 Oct 2023 11:20:41 +0800
Message-ID: <CACGkMEskfXDo+bnx5hbGU3JRwOgBRwOC-bYDdFYSmEO2jjgPnA@mail.gmail.com>
Subject: Re: [PATCH net-next v1 00/19] virtio-net: support AF_XDP zero copy
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 "David S. Miller" <davem@davemloft.net>
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

T24gVHVlLCBPY3QgMTcsIDIwMjMgYXQgMTE6MTHigK9BTSBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IE9uIFR1ZSwgMTcgT2N0IDIwMjMgMTA6NTM6NDQg
KzA4MDAsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gT24gTW9u
LCBPY3QgMTYsIDIwMjMgYXQgODowMOKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxp
YmFiYS5jb20+IHdyb3RlOgo+ID4gPgo+ID4gPiAjIyBBRl9YRFAKPiA+ID4KPiA+ID4gWERQIHNv
Y2tldChBRl9YRFApIGlzIGFuIGV4Y2VsbGVudCBieXBhc3Mga2VybmVsIG5ldHdvcmsgZnJhbWV3
b3JrLiBUaGUgemVybwo+ID4gPiBjb3B5IGZlYXR1cmUgb2YgeHNrIChYRFAgc29ja2V0KSBuZWVk
cyB0byBiZSBzdXBwb3J0ZWQgYnkgdGhlIGRyaXZlci4gVGhlCj4gPiA+IHBlcmZvcm1hbmNlIG9m
IHplcm8gY29weSBpcyB2ZXJ5IGdvb2QuIG1seDUgYW5kIGludGVsIGl4Z2JlIGFscmVhZHkgc3Vw
cG9ydAo+ID4gPiB0aGlzIGZlYXR1cmUsIFRoaXMgcGF0Y2ggc2V0IGFsbG93cyB2aXJ0aW8tbmV0
IHRvIHN1cHBvcnQgeHNrJ3MgemVyb2NvcHkgeG1pdAo+ID4gPiBmZWF0dXJlLgo+ID4gPgo+ID4g
PiBBdCBwcmVzZW50LCB3ZSBoYXZlIGNvbXBsZXRlZCBzb21lIHByZXBhcmF0aW9uOgo+ID4gPgo+
ID4gPiAxLiB2cS1yZXNldCAodmlydGlvIHNwZWMgYW5kIGtlcm5lbCBjb2RlKQo+ID4gPiAyLiB2
aXJ0aW8tY29yZSBwcmVtYXBwZWQgZG1hCj4gPiA+IDMuIHZpcnRpby1uZXQgeGRwIHJlZmFjdG9y
Cj4gPiA+Cj4gPiA+IFNvIGl0IGlzIHRpbWUgZm9yIFZpcnRpby1OZXQgdG8gY29tcGxldGUgdGhl
IHN1cHBvcnQgZm9yIHRoZSBYRFAgU29ja2V0Cj4gPiA+IFplcm9jb3B5Lgo+ID4gPgo+ID4gPiBW
aXJ0aW8tbmV0IGNhbiBub3QgaW5jcmVhc2UgdGhlIHF1ZXVlIG51bSBhdCB3aWxsLCBzbyB4c2sg
c2hhcmVzIHRoZSBxdWV1ZSB3aXRoCj4gPiA+IGtlcm5lbC4KPiA+ID4KPiA+ID4gT24gdGhlIG90
aGVyIGhhbmQsIFZpcnRpby1OZXQgZG9lcyBub3Qgc3VwcG9ydCBnZW5lcmF0ZSBpbnRlcnJ1cHQg
ZnJvbSBkcml2ZXIKPiA+ID4gbWFudWFsbHksIHNvIHdoZW4gd2Ugd2FrZXVwIHR4IHhtaXQsIHdl
IHVzZWQgc29tZSB0aXBzLiBJZiB0aGUgQ1BVIHJ1biBieSBUWAo+ID4gPiBOQVBJIGxhc3QgdGlt
ZSBpcyBvdGhlciBDUFVzLCB1c2UgSVBJIHRvIHdha2UgdXAgTkFQSSBvbiB0aGUgcmVtb3RlIENQ
VS4gSWYgaXQKPiA+ID4gaXMgYWxzbyB0aGUgbG9jYWwgQ1BVLCB0aGVuIHdlIHdha2UgdXAgbmFw
aSBkaXJlY3RseS4KPiA+ID4KPiA+ID4gVGhpcyBwYXRjaCBzZXQgaW5jbHVkZXMgc29tZSByZWZh
Y3RvciB0byB0aGUgdmlydGlvLW5ldCB0byBsZXQgdGhhdCB0byBzdXBwb3J0Cj4gPiA+IEFGX1hE
UC4KPiA+ID4KPiA+ID4gIyMgcGVyZm9ybWFuY2UKPiA+ID4KPiA+ID4gRU5WOiBRZW11IHdpdGgg
dmhvc3QtdXNlcihwb2xsaW5nIG1vZGUpLgo+ID4gPgo+ID4gPiBTb2NrcGVyZjogaHR0cHM6Ly9n
aXRodWIuY29tL01lbGxhbm94L3NvY2twZXJmCj4gPiA+IEkgdXNlIHRoaXMgdG9vbCB0byBzZW5k
IHVkcCBwYWNrZXQgYnkga2VybmVsIHN5c2NhbGwuCj4gPiA+Cj4gPiA+IHhtaXQgY29tbWFuZDog
c29ja3BlcmYgdHAgLWkgMTAuMC4zLjEgLXQgMTAwMAo+ID4gPgo+ID4gPiBJIHdyaXRlIGEgdG9v
bCB0aGF0IHNlbmRzIHVkcCBwYWNrZXRzIG9yIHJlY3ZzIHVkcCBwYWNrZXRzIGJ5IEFGX1hEUC4K
PiA+ID4KPiA+ID4gICAgICAgICAgICAgICAgICAgfCBHdWVzdCBBUFAgQ1BVIHxHdWVzdCBTb2Z0
aXJxIENQVSB8IFVEUCBQUFMKPiA+ID4gLS0tLS0tLS0tLS0tLS0tLS0tfC0tLS0tLS0tLS0tLS0t
LXwtLS0tLS0tLS0tLS0tLS0tLS18LS0tLS0tLS0tLS0tCj4gPiA+IHhtaXQgYnkgc3lzY2FsbCAg
IHwgICAxMDAlICAgICAgICB8ICAgICAgICAgICAgICAgICAgfCAgIDY3Niw5MTUKPiA+ID4geG1p
dCBieSB4c2sgICAgICAgfCAgIDU5LjElICAgICAgIHwgICAxMDAlICAgICAgICAgICB8IDUsNDQ3
LDE2OAo+ID4gPiByZWN2IGJ5IHN5c2NhbGwgICB8ICAgNjAlICAgICAgICAgfCAgIDEwMCUgICAg
ICAgICAgIHwgICA5MzIsMjg4Cj4gPiA+IHJlY3YgYnkgeHNrICAgICAgIHwgICAzNS43JSAgICAg
ICB8ICAgMTAwJSAgICAgICAgICAgfCAzLDM0MywxNjgKPiA+Cj4gPiBBbnkgY2hhbmNlIHdlIGNh
biBnZXQgYSB0ZXN0cG1kIHJlc3VsdCAod2hpY2ggSSBndWVzcyBzaG91bGQgYmUgYmV0dGVyCj4g
PiB0aGFuIFBQUyBhYm92ZSk/Cj4KPiBEbyB5b3UgbWVhbiB0ZXN0cG1kICsgRFBESyArIEFGX1hE
UD8KClllcy4KCj4KPiBZZXMuIFRoaXMgaXMgcHJvYmFibHkgYmV0dGVyIGJlY2F1c2UgbXkgdG9v
bCBkb2VzIG1vcmUgd29yay4gVGhhdCBpcyBub3QgYQo+IGNvbXBsZXRlIHRlc3RpbmcgdG9vbCB1
c2VkIGJ5IG91ciBidXNpbmVzcy4KClByb2JhYmx5LCBidXQgaXQgd291bGQgYmUgYXBwZWFsaW5n
IGZvciBvdGhlcnMuIEVzcGVjaWFsbHkgY29uc2lkZXJpbmcKRFBESyBzdXBwb3J0cyBBRl9YRFAg
UE1EIG5vdy4KCj4KPiBXaGF0IEkgbm90aWNlZCBpcyB0aGF0IHRoZSBob3RzcG90IGlzIHRoZSBk
cml2ZXIgd3JpdGluZyB2aXJ0aW8gZGVzYy4gQmVjYXVzZQo+IHRoZSBkZXZpY2UgaXMgaW4gYnVz
eSBtb2RlLiBTbyB0aGVyZSBpcyByYWNlIGJldHdlZW4gZHJpdmVyIGFuZCBkZXZpY2UuCj4gU28g
SSBtb2RpZmllZCB0aGUgdmlydGlvIGNvcmUgYW5kIGxhemlseSB1cGRhdGVkIGF2YWlsIGlkeC4g
VGhlbiBwcHMgY2FuIHJlYWNoCj4gMTAsMDAwLDAwMC4KCkNhcmUgdG8gcG9zdCBhIGRyYWZ0IGZv
ciB0aGlzPwoKVGhhbmtzCgo+Cj4gVGhhbmtzLgo+Cj4gPgo+ID4gVGhhbmtzCj4gPgo+ID4gPgo+
ID4gPiAjIyBtYWludGFpbgo+ID4gPgo+ID4gPiBJIGFtIGN1cnJlbnRseSBhIHJldmlld2VyIGZv
ciB2aXJ0aW8tbmV0LiBJIGNvbW1pdCB0byBtYWludGFpbiBBRl9YRFAgc3VwcG9ydCBpbgo+ID4g
PiB2aXJ0aW8tbmV0Lgo+ID4gPgo+ID4gPiBQbGVhc2UgcmV2aWV3Lgo+ID4gPgo+ID4gPiBUaGFu
a3MuCj4gPiA+Cj4gPiA+IHYxOgo+ID4gPiAgICAgMS4gcmVtb3ZlIHR3byB2aXJ0aW8gY29tbWl0
cy4gUHVzaCB0aGlzIHBhdGNoc2V0IHRvIG5ldC1uZXh0Cj4gPiA+ICAgICAyLiBzcXVhc2ggInZp
cnRpb19uZXQ6IHZpcnRuZXRfcG9sbF90eCBzdXBwb3J0IHJlc2NoZWR1bGVkIiB0byB4c2s6IHN1
cHBvcnQgdHgKPiA+ID4gICAgIDMuIGZpeCBzb21lIHdhcm5pbmdzCj4gPiA+Cj4gPiA+IFh1YW4g
Wmh1byAoMTkpOgo+ID4gPiAgIHZpcnRpb19uZXQ6IHJlbmFtZSBmcmVlX29sZF94bWl0X3NrYnMg
dG8gZnJlZV9vbGRfeG1pdAo+ID4gPiAgIHZpcnRpb19uZXQ6IHVuaWZ5IHRoZSBjb2RlIGZvciBy
ZWN5Y2xpbmcgdGhlIHhtaXQgcHRyCj4gPiA+ICAgdmlydGlvX25ldDogaW5kZXBlbmRlbnQgZGly
ZWN0b3J5Cj4gPiA+ICAgdmlydGlvX25ldDogbW92ZSB0byB2aXJ0aW9fbmV0LmgKPiA+ID4gICB2
aXJ0aW9fbmV0OiBhZGQgcHJlZml4IHZpcnRuZXQgdG8gYWxsIHN0cnVjdC9hcGkgaW5zaWRlIHZp
cnRpb19uZXQuaAo+ID4gPiAgIHZpcnRpb19uZXQ6IHNlcGFyYXRlIHZpcnRuZXRfcnhfcmVzaXpl
KCkKPiA+ID4gICB2aXJ0aW9fbmV0OiBzZXBhcmF0ZSB2aXJ0bmV0X3R4X3Jlc2l6ZSgpCj4gPiA+
ICAgdmlydGlvX25ldDogc3Egc3VwcG9ydCBwcmVtYXBwZWQgbW9kZQo+ID4gPiAgIHZpcnRpb19u
ZXQ6IHhzazogYmluZC91bmJpbmQgeHNrCj4gPiA+ICAgdmlydGlvX25ldDogeHNrOiBwcmV2ZW50
IGRpc2FibGUgdHggbmFwaQo+ID4gPiAgIHZpcnRpb19uZXQ6IHhzazogdHg6IHN1cHBvcnQgdHgK
PiA+ID4gICB2aXJ0aW9fbmV0OiB4c2s6IHR4OiBzdXBwb3J0IHdha2V1cAo+ID4gPiAgIHZpcnRp
b19uZXQ6IHhzazogdHg6IHZpcnRuZXRfZnJlZV9vbGRfeG1pdCgpIGRpc3Rpbmd1aXNoZXMgeHNr
IGJ1ZmZlcgo+ID4gPiAgIHZpcnRpb19uZXQ6IHhzazogdHg6IHZpcnRuZXRfc3FfZnJlZV91bnVz
ZWRfYnVmKCkgY2hlY2sgeHNrIGJ1ZmZlcgo+ID4gPiAgIHZpcnRpb19uZXQ6IHhzazogcng6IGlu
dHJvZHVjZSBhZGRfcmVjdmJ1Zl94c2soKQo+ID4gPiAgIHZpcnRpb19uZXQ6IHhzazogcng6IGlu
dHJvZHVjZSByZWNlaXZlX3hzaygpIHRvIHJlY3YgeHNrIGJ1ZmZlcgo+ID4gPiAgIHZpcnRpb19u
ZXQ6IHhzazogcng6IHZpcnRuZXRfcnFfZnJlZV91bnVzZWRfYnVmKCkgY2hlY2sgeHNrIGJ1ZmZl
cgo+ID4gPiAgIHZpcnRpb19uZXQ6IHVwZGF0ZSB0eCB0aW1lb3V0IHJlY29yZAo+ID4gPiAgIHZp
cnRpb19uZXQ6IHhkcF9mZWF0dXJlcyBhZGQgTkVUREVWX1hEUF9BQ1RfWFNLX1pFUk9DT1BZCj4g
PiA+Cj4gPiA+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwg
ICAyICstCj4gPiA+ICBkcml2ZXJzL25ldC9LY29uZmlnICAgICAgICAgICAgICAgICAgICAgICAg
IHwgICA4ICstCj4gPiA+ICBkcml2ZXJzL25ldC9NYWtlZmlsZSAgICAgICAgICAgICAgICAgICAg
ICAgIHwgICAyICstCj4gPiA+ICBkcml2ZXJzL25ldC92aXJ0aW8vS2NvbmZpZyAgICAgICAgICAg
ICAgICAgIHwgIDEzICsKPiA+ID4gIGRyaXZlcnMvbmV0L3ZpcnRpby9NYWtlZmlsZSAgICAgICAg
ICAgICAgICAgfCAgIDggKwo+ID4gPiAgZHJpdmVycy9uZXQve3ZpcnRpb19uZXQuYyA9PiB2aXJ0
aW8vbWFpbi5jfSB8IDY1MiArKysrKysrKystLS0tLS0tLS0tLQo+ID4gPiAgZHJpdmVycy9uZXQv
dmlydGlvL3ZpcnRpb19uZXQuaCAgICAgICAgICAgICB8IDM1OSArKysrKysrKysrKwo+ID4gPiAg
ZHJpdmVycy9uZXQvdmlydGlvL3hzay5jICAgICAgICAgICAgICAgICAgICB8IDU0NSArKysrKysr
KysrKysrKysrCj4gPiA+ICBkcml2ZXJzL25ldC92aXJ0aW8veHNrLmggICAgICAgICAgICAgICAg
ICAgIHwgIDMyICsKPiA+ID4gIDkgZmlsZXMgY2hhbmdlZCwgMTI0NyBpbnNlcnRpb25zKCspLCAz
NzQgZGVsZXRpb25zKC0pCj4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvdmly
dGlvL0tjb25maWcKPiA+ID4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC92aXJ0aW8v
TWFrZWZpbGUKPiA+ID4gIHJlbmFtZSBkcml2ZXJzL25ldC97dmlydGlvX25ldC5jID0+IHZpcnRp
by9tYWluLmN9ICg5MSUpCj4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvdmly
dGlvL3ZpcnRpb19uZXQuaAo+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3Zp
cnRpby94c2suYwo+ID4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3ZpcnRpby94
c2suaAo+ID4gPgo+ID4gPiAtLQo+ID4gPiAyLjMyLjAuMy5nMDExOTVjZjlmCj4gPiA+Cj4gPgo+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
