Return-Path: <SRS0=Dg4u=MS=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12D84C4338F
	for <virtualization@archiver.kernel.org>; Mon, 26 Jul 2021 15:47:37 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE32B60F51
	for <virtualization@archiver.kernel.org>; Mon, 26 Jul 2021 15:47:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org AE32B60F51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 776F74021E;
	Mon, 26 Jul 2021 15:47:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aVvqkZUdQaTN; Mon, 26 Jul 2021 15:47:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D583F400C3;
	Mon, 26 Jul 2021 15:47:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8CFB5C001A;
	Mon, 26 Jul 2021 15:47:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA19DC000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 15:47:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id D030140395
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 15:47:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1Lrv-v5kb57B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 15:47:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-f173.google.com (mail-oi1-f173.google.com
 [209.85.167.173])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A1DBA40390
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 15:47:31 +0000 (UTC)
Received: by mail-oi1-f173.google.com with SMTP id q6so11346642oiw.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 26 Jul 2021 08:47:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=1d5cbYYMozpblAP6PNRBcPUfwE0i3V4+yazexCHen30=;
 b=RY081z7tKXS7TQgvpfuQZXNzCnLkrUm/LhEUrjDY6DM/UgIfCdFUEWq6KRo3pS9rnC
 tgATxMHc4aQadEaMwNQo2A/eTtEx/xkJK/TWCgWXSnEhZKmVyEFdBz1GqJmX4euIA2Ki
 ovFqKuvfVOieeIa3J18OhsbXNBr8QKPYEJ8HqjuU/cCTcMYBPhkDSxs1c1KMNw/4dxlZ
 PDtYPmGCa970b1N6sTGhUa9eFYRKJ++O3BnD5Ramgul2IdVWUJXmk1qFQGFhsw9ykwwU
 pxd9MopudVP8SjM1586q5CyQ7G8dTdImyAQOFo4PUes6BBo81SvdxLuvEtgbfBHfLpZj
 JtCg==
X-Gm-Message-State: AOAM532QpR+mlCsYj2RxZoC+qoWI2e01jr89SF7+5adaxZqtGkwDXI4+
 mDHd2hshoHhqIuvJ9XbTm91VelDxPfkoB4AS0BU=
X-Google-Smtp-Source: ABdhPJx0q9YBnz9WLfHdhCVrn/hzRPrULJgYI/JQvdfQmpyoGjjcrki0nozWOZyNW1UvlHssLxm5idt1i650SQcmG3o=
X-Received: by 2002:aca:d7d5:: with SMTP id o204mr11062448oig.69.1627314450708; 
 Mon, 26 Jul 2021 08:47:30 -0700 (PDT)
MIME-Version: 1.0
References: <20210713161906.457857-1-stefanha@redhat.com>
 <1008dee4-fce1-2462-1520-f5432bc89a07@redhat.com>
 <YPfryV7qZVRbjNgP@stefanha-x1.localdomain>
 <869a993d-a1b0-1c39-d081-4cdd2b71041f@redhat.com>
 <YP7SEkDEIBOch9U8@stefanha-x1.localdomain>
In-Reply-To: <YP7SEkDEIBOch9U8@stefanha-x1.localdomain>
From: "Rafael J. Wysocki" <rafael@kernel.org>
Date: Mon, 26 Jul 2021 17:47:19 +0200
Message-ID: <CAJZ5v0h+RrRP-3MtV8dgxmba0rDfqoOw54DsFh0yx3YGUAVRqw@mail.gmail.com>
Subject: Re: [RFC 0/3] cpuidle: add poll_source API and virtio vq polling
To: Stefan Hajnoczi <stefanha@redhat.com>
Cc: Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@infradead.org>,
 "Michael S . Tsirkin" <mst@redhat.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 Linux PM <linux-pm@vger.kernel.org>, virtualization@lists.linux-foundation.org
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

T24gTW9uLCBKdWwgMjYsIDIwMjEgYXQgNToxNyBQTSBTdGVmYW4gSGFqbm9jemkgPHN0ZWZhbmhh
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gVGh1LCBKdWwgMjIsIDIwMjEgYXQgMDU6MDQ6NTdQ
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+Cj4gPiDlnKggMjAyMS83LzIxIOS4i+WNiDU6
NDEsIFN0ZWZhbiBIYWpub2N6aSDlhpnpgZM6Cj4gPiA+IE9uIFdlZCwgSnVsIDIxLCAyMDIxIGF0
IDExOjI5OjU1QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4g5ZyoIDIwMjEvNy8x
NCDkuIrljYgxMjoxOSwgU3RlZmFuIEhham5vY3ppIOWGmemBkzoKPiA+ID4gPiA+IFRoZXNlIHBh
dGNoZXMgYXJlIG5vdCBwb2xpc2hlZCB5ZXQgYnV0IEkgd291bGQgbGlrZSByZXF1ZXN0IGZlZWRi
YWNrIG9uIHRoaXMKPiA+ID4gPiA+IGFwcHJvYWNoIGFuZCBzaGFyZSBwZXJmb3JtYW5jZSByZXN1
bHRzIHdpdGggeW91Lgo+ID4gPiA+ID4KPiA+ID4gPiA+IElkbGUgQ1BVcyB0ZW50YXRpdmVseSBl
bnRlciBhIGJ1c3kgd2FpdCBsb29wIGJlZm9yZSBoYWx0aW5nIHdoZW4gdGhlIGNwdWlkbGUKPiA+
ID4gPiA+IGhhbHRwb2xsIGRyaXZlciBpcyBlbmFibGVkIGluc2lkZSBhIHZpcnR1YWwgbWFjaGlu
ZS4gVGhpcyByZWR1Y2VzIHdha2V1cAo+ID4gPiA+ID4gbGF0ZW5jeSBmb3IgZXZlbnRzIHRoYXQg
b2NjdXIgc29vbiBhZnRlciB0aGUgdkNQVSBiZWNvbWVzIGlkbGUuCj4gPiA+ID4gPgo+ID4gPiA+
ID4gVGhpcyBwYXRjaCBzZXJpZXMgZXh0ZW5kcyB0aGUgY3B1aWRsZSBidXN5IHdhaXQgbG9vcCB3
aXRoIHRoZSBuZXcgcG9sbF9zb3VyY2UKPiA+ID4gPiA+IEFQSSBzbyBkcml2ZXJzIGNhbiBwYXJ0
aWNpcGF0ZSBpbiBwb2xsaW5nLiBTdWNoIHBvbGxpbmctYXdhcmUgZHJpdmVycyBkaXNhYmxlCj4g
PiA+ID4gPiB0aGVpciBkZXZpY2UncyBpcnEgZHVyaW5nIHRoZSBidXN5IHdhaXQgbG9vcCB0byBh
dm9pZCB0aGUgY29zdCBvZiBpbnRlcnJ1cHRzLgo+ID4gPiA+ID4gVGhpcyByZWR1Y2VzIGxhdGVu
Y3kgZnVydGhlciB0aGFuIHJlZ3VsYXIgY3B1aWRsZSBoYWx0cG9sbCwgd2hpY2ggc3RpbGwgcmVs
aWVzCj4gPiA+ID4gPiBvbiBpcnFzLgo+ID4gPiA+ID4KPiA+ID4gPiA+IFZpcnRpbyBkcml2ZXJz
IGFyZSBtb2RpZmllZCB0byB1c2UgdGhlIHBvbGxfc291cmNlIEFQSSBzbyBhbGwgdmlydGlvIGRl
dmljZQo+ID4gPiA+ID4gdHlwZXMgZ2V0IHRoaXMgZmVhdHVyZS4gVGhlIGZvbGxvd2luZyB2aXJ0
aW8tYmxrIGZpbyBiZW5jaG1hcmsgcmVzdWx0cyBzaG93IHRoZQo+ID4gPiA+ID4gaW1wcm92ZW1l
bnQ6Cj4gPiA+ID4gPgo+ID4gPiA+ID4gICAgICAgICAgICAgICAgSU9QUyAobnVtam9icz00LCBp
b2RlcHRoPTEsIDQgdmlydHF1ZXVlcykKPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgYmVmb3Jl
ICAgcG9sbF9zb3VyY2UgICAgICBpb19wb2xsCj4gPiA+ID4gPiA0ayByYW5kcmVhZCAgICAxNjcx
MDIgIDE4NjA0OSAoKzExJSkgIDE4NjY1NCAoKzExJSkKPiA+ID4gPiA+IDRrIHJhbmR3cml0ZSAg
IDE2MjIwNCAgMTgxMjE0ICgrMTElKSAgMTgxODUwICgrMTIlKQo+ID4gPiA+ID4gNGsgcmFuZHJ3
ICAgICAgMTU5NTIwICAxNzcwNzEgKCsxMSUpICAxNzc5MjggKCsxMSUpCj4gPiA+ID4gPgo+ID4g
PiA+ID4gVGhlIGNvbXBhcmlzb24gYWdhaW5zdCBpb19wb2xsIHNob3dzIHRoYXQgY3B1aWRsZSBw
b2xsX3NvdXJjZSBhY2hpZXZlcwo+ID4gPiA+ID4gZXF1aXZhbGVudCBwZXJmb3JtYW5jZSB0byB0
aGUgYmxvY2sgbGF5ZXIncyBpb19wb2xsIGZlYXR1cmUgKHdoaWNoIEkKPiA+ID4gPiA+IGltcGxl
bWVudGVkIGluIGEgc2VwYXJhdGUgcGF0Y2ggc2VyaWVzIFsxXSkuCj4gPiA+ID4gPgo+ID4gPiA+
ID4gVGhlIGFkdmFudGFnZSBvZiBwb2xsX3NvdXJjZSBpcyB0aGF0IGFwcGxpY2F0aW9ucyBkbyBu
b3QgbmVlZCB0byBleHBsaWNpdGx5IHNldAo+ID4gPiA+ID4gdGhlIFJXRl9ISVBSSSBJL08gcmVx
dWVzdCBmbGFnLiBUaGUgcG9sbF9zb3VyY2UgYXBwcm9hY2ggaXMgYXR0cmFjdGl2ZSBiZWNhdXNl
Cj4gPiA+ID4gPiBmZXcgYXBwbGljYXRpb25zIGFjdHVhbGx5IHVzZSBSV0ZfSElQUkkgYW5kIGl0
IHRha2VzIGFkdmFudGFnZSBvZiBDUFUgY3ljbGVzIHdlCj4gPiA+ID4gPiB3b3VsZCBoYXZlIHNw
ZW50IGluIGNwdWlkbGUgaGFsdHBvbGwgYW55d2F5Lgo+ID4gPiA+ID4KPiA+ID4gPiA+IFRoZSBj
dXJyZW50IHNlcmllcyBkb2VzIG5vdCBpbXByb3ZlIHZpcnRpby1uZXQuIEkgaGF2ZW4ndCBpbnZl
c3RpZ2F0ZWQgZGVlcGx5LAo+ID4gPiA+ID4gYnV0IGl0IGlzIHBvc3NpYmxlIHRoYXQgTkFQSSBh
bmQgcG9sbF9zb3VyY2UgZG8gbm90IGNvbWJpbmUuIFNlZSB0aGUgZmluYWwKPiA+ID4gPiA+IHBh
dGNoIGZvciBhIHN0YXJ0aW5nIHBvaW50IG9uIG1ha2luZyB0aGUgdHdvIHdvcmsgdG9nZXRoZXIu
Cj4gPiA+ID4gPgo+ID4gPiA+ID4gSSBoYXZlIG5vdCB0cmllZCB0aGlzIG9uIGJhcmUgbWV0YWwg
YnV0IGl0IG1pZ2h0IGhlbHAgdGhlcmUgdG9vLiBUaGUgY29zdCBvZgo+ID4gPiA+ID4gZGlzYWJs
aW5nIGEgZGV2aWNlJ3MgaXJxIG11c3QgYmUgbGVzcyB0aGFuIHRoZSBzYXZpbmdzIGZyb20gYXZv
aWRpbmcgaXJxCj4gPiA+ID4gPiBoYW5kbGluZyBmb3IgdGhpcyBvcHRpbWl6YXRpb24gdG8gbWFr
ZSBzZW5zZS4KPiA+ID4gPiA+Cj4gPiA+ID4gPiBbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcv
bGludXgtYmxvY2svMjAyMTA1MjAxNDEzMDUuMzU1OTYxLTEtc3RlZmFuaGFAcmVkaGF0LmNvbS8K
PiA+ID4gPgo+ID4gPiA+IEhpIFN0ZWZhbjoKPiA+ID4gPgo+ID4gPiA+IFNvbWUgcXVlc3Rpb25z
Ogo+ID4gPiA+Cj4gPiA+ID4gMSkgV2hhdCdzIHRoZSBhZHZhbnRhZ2VzIG9mIGludHJvZHVjaW5n
IHBvbGxpbmcgYXQgdmlydGlvIGxldmVsIGluc3RlYWQgb2YKPiA+ID4gPiBkb2luZyBpdCBhdCBl
YWNoIHN1YnN5c3RlbXM/IFBvbGxpbmcgaW4gdmlydGlvIGxldmVsIG1heSBvbmx5IHdvcmsgd2Vs
bCBpZgo+ID4gPiA+IGFsbCAob3IgbW9zdCkgb2YgdGhlIGRldmljZXMgYXJlIHZpcnRpbwo+ID4g
PiBJJ20gbm90IHN1cmUgSSB1bmRlcnN0YW5kIHRoZSBxdWVzdGlvbi4gY3B1aWRsZSBoYWx0cG9s
bCBiZW5lZml0cyBhbGwKPiA+ID4gZGV2aWNlcyB0b2RheSwgZXhjZXB0IGl0IGluY3VycyBpbnRl
cnJ1cHQgbGF0ZW5jeS4gVGhlIHBvbGxfc291cmNlIEFQSQo+ID4gPiBlbGltaW5hdGVzIHRoZSBp
bnRlcnJ1cHQgbGF0ZW5jeSBmb3IgZHJpdmVycyB0aGF0IGNhbiBkaXNhYmxlIGRldmljZQo+ID4g
PiBpbnRlcnJ1cHRzIGNoZWFwbHkuCj4gPiA+Cj4gPiA+IFRoaXMgcGF0Y2ggYWRkcyBwb2xsX3Nv
dXJjZSB0byBjb3JlIHZpcnRpbyBjb2RlIHNvIHRoYXQgYWxsIHZpcnRpbwo+ID4gPiBkcml2ZXJz
IGdldCB0aGlzIGZlYXR1cmUgZm9yIGZyZWUuIE5vIGRyaXZlci1zcGVjaWZpYyBjaGFuZ2VzIGFy
ZQo+ID4gPiBuZWVkZWQuCj4gPiA+Cj4gPiA+IElmIHlvdSBtZWFuIG5ldHdvcmtpbmcsIGJsb2Nr
IGxheWVyLCBldGMgYnkgInN1YnN5c3RlbXMiIHRoZW4gdGhlcmUncwo+ID4gPiBub3RoaW5nIHRo
b3NlIHN1YnN5c3RlbXMgY2FuIGRvIHRvIGhlbHAuIFdoZXRoZXIgcG9sbF9zb3VyY2UgY2FuIGJl
IHVzZWQKPiA+ID4gZGVwZW5kcyBvbiB0aGUgc3BlY2lmaWMgZHJpdmVyLCBub3QgdGhlIHN1YnN5
c3RlbS4gSWYgeW91IGNvbnNpZGVyCj4gPiA+IGRyaXZlcnMvdmlydGlvLyBhIHN1YnN5c3RlbSwg
dGhlbiB0aGF0J3MgZXhhY3RseSB3aGF0IHRoZSBwYXRjaCBzZXJpZXMKPiA+ID4gaXMgZG9pbmcu
Cj4gPgo+ID4KPiA+IEkgbWVhbnQsIGlmIHdlIGNob29zZSB0byB1c2UgaWRsZSBwb2xsLCB3ZSBo
YXZlIHNvbWUgc2V2ZXJhbCBjaG9pY2VzOgo+ID4KPiA+IDEpIGJ1cyBsZXZlbCAoZS5nIHRoZSB2
aXJ0aW8pCj4gPiAyKSBzdWJzeXN0ZW0gbGV2ZWwgKGUuZyB0aGUgbmV0d29ya2luZyBhbmQgYmxv
Y2spCj4gPgo+ID4gSSdtIG5vdCBzdXJlIHdoaWNoIG9uZSBpcyBiZXR0ZXIuCj4KPiBUaGlzIEFQ
SSBpcyBpbnRlbmRlZCB0byBiZSBkcml2ZXItIG9yIGJ1cy1sZXZlbC4gSSBkb24ndCB0aGluawo+
IHN1YnN5c3RlbXMgY2FuIGRvIHZlcnkgbXVjaCBzaW5jZSB0aGV5IGRvbid0IGtub3cgdGhlIGhh
cmR3YXJlCj4gY2FwYWJpbGl0aWVzIChjaGVhcCBpbnRlcnJ1cHQgZGlzYWJsaW5nKSBhbmQgaW4g
bW9zdCBjYXNlcyB0aGVyZSdzIG5vCj4gYWR2YW50YWdlIG9mIHBsdW1iaW5nIGl0IHRocm91Z2gg
c3Vic3lzdGVtcyB3aGVuIGRyaXZlcnMgY2FuIGNhbGwgdGhlCj4gQVBJIGRpcmVjdGx5Lgo+Cj4g
PiA+ID4gMikgV2hhdCdzIHRoZSBhZHZhbnRhZ2VzIG9mIHVzaW5nIGNwdWlkbGUgaW5zdGVhZCBv
ZiB1c2luZyBhIHRocmVhZCAoYW5kCj4gPiA+ID4gbGV2ZXJhZ2UgdGhlIHNjaGVkdWxlcik/Cj4g
PiA+IEluIG9yZGVyIHRvIGNvbWJpbmUgd2l0aCB0aGUgZXhpc3RpbmcgY3B1aWRsZSBpbmZyYXN0
cnVjdHVyZS4gTm8gbmV3Cj4gPiA+IHBvbGxpbmcgbG9vcCBpcyBpbnRyb2R1Y2VkIGFuZCBubyBh
ZGRpdGlvbmFsIENQVSBjeWNsZXMgYXJlIHNwZW50IG9uCj4gPiA+IHBvbGxpbmcuCj4gPiA+Cj4g
PiA+IElmIGNwdWlkbGUgaXRzZWxmIGlzIGNvbnZlcnRlZCB0byB0aHJlYWRzIHRoZW4gcG9sbF9z
b3VyY2Ugd291bGQKPiA+ID4gYXV0b21hdGljYWxseSBvcGVyYXRlIGluIGEgdGhyZWFkIHRvbywg
YnV0IHRoaXMgcGF0Y2ggc2VyaWVzIGRvZXNuJ3QKPiA+ID4gY2hhbmdlIGhvdyB0aGUgY29yZSBj
cHVpZGxlIGNvZGUgd29ya3MuCj4gPgo+ID4KPiA+IFNvIG5ldHdvcmtpbmcgc3Vic3lzdGVtIGNh
biB1c2UgTkFQSSBidXN5IHBvbGxpbmcgaW4gdGhlIHByb2Nlc3MgY29udGV4dAo+ID4gd2hpY2gg
bWVhbnMgaXQgY2FuIGJlIGxldmVyYWdlZCBieSB0aGUgc2NoZWR1bGVyLgo+ID4KPiA+IEknbSBu
b3Qgc3VyZSBpdCdzIGEgZ29vZCBpZGVhIHRvIHBvbGwgZHJpdmVycyBmb3IgYSBzcGVjaWZpYyBi
dXMgaW4gdGhlCj4gPiBnZW5lcmFsIGNwdSBpZGxlIGxheWVyLgo+Cj4gV2h5PyBNYXliZSBiZWNh
dXNlIHRoZSBjcHVpZGxlIGV4ZWN1dGlvbiBlbnZpcm9ubWVudCBpcyBhIGxpdHRsZSBzcGVjaWFs
PwoKV2VsbCwgdGhpcyB3b3VsZCBiZSBwcm9uZSB0byBhYnVzZS4KClRoZSB0aW1lIHNwZW50IGlu
IHRoYXQgZHJpdmVyIGNhbGxiYWNrIGNvdW50cyBhcyBDUFUgaWRsZSB0aW1lIHdoaWxlCml0IHJl
YWxseSBpcyB0aGUgZHJpdmVyIHJ1bm5pbmcgYW5kIHRoZXJlIGlzIG5vdCBsaW1pdCBvbiBob3cg
bXVjaAp0aW1lIHRoZSBjYWxsYmFjayBjYW4gdGFrZSwgd2hpbGUgZG9pbmcgY29zdGx5IHRoaW5n
cyBpbiB0aGUgaWRsZSBsb29wCmlzIGdlbmVyYWxseSBhdm9pZGVkLCBiZWNhdXNlIG9uIHdha2V1
cCB0aGUgQ1BVIG5lZWRzIHRvIGJlIGF2YWlsYWJsZQp0byB0aGUgdGFzayBuZWVkaW5nIGl0IGFz
IHNvb24gYXMgcG9zc2libGUuICBJT1csIHRoZSBjYWxsYmFjawpwb3RlbnRpYWxseSBhZGQgdW5i
b3VuZGVkIGxhdGVuY3kgdG8gdGhlIENQVSB3YWtldXAgcGF0aC4KX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
