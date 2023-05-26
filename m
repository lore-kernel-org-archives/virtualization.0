Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DD3C6C7EE29
	for <virtualization@archiver.kernel.org>; Fri, 26 May 2023 01:31:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4542B84380;
	Fri, 26 May 2023 01:31:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4542B84380
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=LjqsNPJH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id rOO5yNMWavLf; Fri, 26 May 2023 01:31:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 733A78437C;
	Fri, 26 May 2023 01:31:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 733A78437C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4687CC0036;
	Fri, 26 May 2023 01:31:53 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2FC03C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 01:31:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id EACA340320
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 01:31:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org EACA340320
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=LjqsNPJH
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dp2f25bmG3Z9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 01:31:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6B054402D0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 6B054402D0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 01:31:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685064709;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=H0kCOd6zZFv7bAvvBeo0wUHiEHw+jtzkrolNnIKKHFY=;
 b=LjqsNPJHrTQfV0bIljMPetlrYtITwW87HUXYmfp7vMyBgTimaWBb9Eo9rQXaQC7sb2RxXZ
 jKtr1eluZ6RQYQT9Hb7vzLcwFfVMS+CBskttvBm2H7RcgXlakAEkKRg71xoZAyd6Y4Mexu
 zqjXllijs1+Uok1hjCVnXs0XD6OQY+Y=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-515-9sWxTV5kNWaghMQ15oO7fw-1; Thu, 25 May 2023 21:31:47 -0400
X-MC-Unique: 9sWxTV5kNWaghMQ15oO7fw-1
Received: by mail-lf1-f69.google.com with SMTP id
 2adb3069b0e04-4f4b7b4e7c5so68742e87.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 18:31:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685064706; x=1687656706;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=H0kCOd6zZFv7bAvvBeo0wUHiEHw+jtzkrolNnIKKHFY=;
 b=HmkS6PiuhwoVFnGrlLLuiCr+0s9Yv5k6NjsthSXAayhXbfjgOScI1w/WX9IgX0LOVd
 i2iXI9vWdIA+F5U1T5A0kkfHSXT8BlI+v/7B/HbCQ8FqJTiwcF0pa5qkvgyRLs5TPO2Q
 5ANh0PfZTZSxLTJ/Q2oB0tbVUsZSZIRF4pVQQe69VnoY/7oVe77Xuxr+B+zr4Hi+sWIJ
 wzzFbWdtILWXm7joemwweh7IcvQgpOHuBeuTHjh5el0YGHqF0N1fczQ72ZfRezXXSFAa
 sEQihULXIlBiuzTA2vnE6hR3eZkpzG4gePhzO0mI311/pbyDPzgVpW+h5zJtjy9pjLvA
 t4Vg==
X-Gm-Message-State: AC+VfDxaOhq3Srfz9LPCoQQxDVbhoL5e8HYq/U5AyWNrDRCm8DI5WMKP
 7THR/VBfjMqz9eReK1ACDiq4TPoZdfOVHrGbcLHrqEvyQ/I1slRZcxMeeIDFZHa/viHyAddjDM9
 7gzklUeD4Itg3OgapZ5KkyCCTMSYR+54EyqL9pC3nHBd3hJlEtRgx3EQvWg==
X-Received: by 2002:ac2:5926:0:b0:4f3:b258:fee4 with SMTP id
 v6-20020ac25926000000b004f3b258fee4mr4553lfi.59.1685064706411; 
 Thu, 25 May 2023 18:31:46 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ42AdCfrI+6WFJ/soB09uftcaVkd1k5xpC2LlL0MHfrmY7ShJUXBM/xwj8CeIYPn5vW0zmH4Zy4ClWMwUvdO1A=
X-Received: by 2002:ac2:5926:0:b0:4f3:b258:fee4 with SMTP id
 v6-20020ac25926000000b004f3b258fee4mr4541lfi.59.1685064706005; Thu, 25 May
 2023 18:31:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230524081842.3060-1-jasowang@redhat.com>
 <20230524081842.3060-2-jasowang@redhat.com>
 <20230524050604-mutt-send-email-mst@kernel.org>
 <CACGkMEvm=MJz5e2C_7U=yjrvoo7pxsr=tRAL29OdxJDWhvtiSQ@mail.gmail.com>
 <20230525033750-mutt-send-email-mst@kernel.org>
In-Reply-To: <20230525033750-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 May 2023 09:31:34 +0800
Message-ID: <CACGkMEtCA0-NY=qq_FnGzoY+VXmixGmBV3y80nZWO=NmxdRWmw@mail.gmail.com>
Subject: Re: [PATCH V3 net-next 1/2] virtio-net: convert rx mode setting to
 use workqueue
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, davem@davemloft.net
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

T24gVGh1LCBNYXkgMjUsIDIwMjMgYXQgMzo0MeKAr1BNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gVGh1LCBNYXkgMjUsIDIwMjMgYXQgMTE6NDM6MzRB
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+IE9uIFdlZCwgTWF5IDI0LCAyMDIzIGF0IDU6
MTXigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4K
PiA+ID4gT24gV2VkLCBNYXkgMjQsIDIwMjMgYXQgMDQ6MTg6NDFQTSArMDgwMCwgSmFzb24gV2Fu
ZyB3cm90ZToKPiA+ID4gPiBUaGlzIHBhdGNoIGNvbnZlcnQgcnggbW9kZSBzZXR0aW5nIHRvIGJl
IGRvbmUgaW4gYSB3b3JrcXVldWUsIHRoaXMgaXMKPiA+ID4gPiBhIG11c3QgZm9yIGFsbG93IHRv
IHNsZWVwIHdoZW4gd2FpdGluZyBmb3IgdGhlIGN2cSBjb21tYW5kIHRvCj4gPiA+ID4gcmVzcG9u
c2Ugc2luY2UgY3VycmVudCBjb2RlIGlzIGV4ZWN1dGVkIHVuZGVyIGFkZHIgc3BpbiBsb2NrLgo+
ID4gPiA+Cj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0
LmNvbT4KPiA+ID4gPiAtLS0KPiA+ID4gPiBDaGFuZ2VzIHNpbmNlIFYxOgo+ID4gPiA+IC0gdXNl
IFJUTkwgdG8gc3luY2hyb25pemUgcnggbW9kZSB3b3JrZXIKPiA+ID4gPiAtLS0KPiA+ID4gPiAg
ZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgNTUgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwgNTIgaW5zZXJ0aW9ucygrKSwg
MyBkZWxldGlvbnMoLSkKPiA+ID4gPgo+ID4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4gPiBpbmRleCA1NmNh
MWQyNzAzMDQuLjVkMmYxZGE0ZWFhMCAxMDA2NDQKPiA+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC92
aXJ0aW9fbmV0LmMKPiA+ID4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+ID4g
PiBAQCAtMjY1LDYgKzI2NSwxMiBAQCBzdHJ1Y3QgdmlydG5ldF9pbmZvIHsKPiA+ID4gPiAgICAg
ICAvKiBXb3JrIHN0cnVjdCBmb3IgY29uZmlnIHNwYWNlIHVwZGF0ZXMgKi8KPiA+ID4gPiAgICAg
ICBzdHJ1Y3Qgd29ya19zdHJ1Y3QgY29uZmlnX3dvcms7Cj4gPiA+ID4KPiA+ID4gPiArICAgICAv
KiBXb3JrIHN0cnVjdCBmb3IgY29uZmlnIHJ4IG1vZGUgKi8KPiA+ID4KPiA+ID4gV2l0aCBhIGJp
dCBsZXNzIGFiYnJldmlhdGlvbiBtYXliZT8gc2V0dGluZyByeCBtb2RlPwo+ID4KPiA+IFRoYXQn
cyBmaW5lLgo+ID4KPiA+ID4KPiA+ID4gPiArICAgICBzdHJ1Y3Qgd29ya19zdHJ1Y3QgcnhfbW9k
ZV93b3JrOwo+ID4gPiA+ICsKPiA+ID4gPiArICAgICAvKiBJcyByeCBtb2RlIHdvcmsgZW5hYmxl
ZD8gKi8KPiA+ID4KPiA+ID4gVWdoIG5vdCBhIGdyZWF0IGNvbW1lbnQuCj4gPgo+ID4gQW55IHN1
Z2dlc3Rpb25zIGZvciB0aGlzLiBFLmcgd2UgaGFkOgo+ID4KPiA+ICAgICAgICAgLyogSXMgZGVs
YXllZCByZWZpbGwgZW5hYmxlZD8gKi8KPgo+IC8qIE9LIHRvIHF1ZXVlIHdvcmsgc2V0dGluZyBS
WCBtb2RlPyAqLwoKT2suCgo+Cj4KPiA+ID4KPiA+ID4gPiArICAgICBib29sIHJ4X21vZGVfd29y
a19lbmFibGVkOwo+ID4gPiA+ICsKPiA+ID4KPiA+ID4KPiA+ID4KPiA+ID4gPiAgICAgICAvKiBE
b2VzIHRoZSBhZmZpbml0eSBoaW50IGlzIHNldCBmb3IgdmlydHF1ZXVlcz8gKi8KPiA+ID4gPiAg
ICAgICBib29sIGFmZmluaXR5X2hpbnRfc2V0Owo+ID4gPiA+Cj4gPiA+ID4gQEAgLTM4OCw2ICsz
OTQsMjAgQEAgc3RhdGljIHZvaWQgZGlzYWJsZV9kZWxheWVkX3JlZmlsbChzdHJ1Y3QgdmlydG5l
dF9pbmZvICp2aSkKPiA+ID4gPiAgICAgICBzcGluX3VubG9ja19iaCgmdmktPnJlZmlsbF9sb2Nr
KTsKPiA+ID4gPiAgfQo+ID4gPiA+Cj4gPiA+ID4gK3N0YXRpYyB2b2lkIGVuYWJsZV9yeF9tb2Rl
X3dvcmsoc3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gPiA+ID4gK3sKPiA+ID4gPiArICAgICBy
dG5sX2xvY2soKTsKPiA+ID4gPiArICAgICB2aS0+cnhfbW9kZV93b3JrX2VuYWJsZWQgPSB0cnVl
Owo+ID4gPiA+ICsgICAgIHJ0bmxfdW5sb2NrKCk7Cj4gPiA+ID4gK30KPiA+ID4gPiArCj4gPiA+
ID4gK3N0YXRpYyB2b2lkIGRpc2FibGVfcnhfbW9kZV93b3JrKHN0cnVjdCB2aXJ0bmV0X2luZm8g
KnZpKQo+ID4gPiA+ICt7Cj4gPiA+ID4gKyAgICAgcnRubF9sb2NrKCk7Cj4gPiA+ID4gKyAgICAg
dmktPnJ4X21vZGVfd29ya19lbmFibGVkID0gZmFsc2U7Cj4gPiA+ID4gKyAgICAgcnRubF91bmxv
Y2soKTsKPiA+ID4gPiArfQo+ID4gPiA+ICsKPiA+ID4gPiAgc3RhdGljIHZvaWQgdmlydHF1ZXVl
X25hcGlfc2NoZWR1bGUoc3RydWN0IG5hcGlfc3RydWN0ICpuYXBpLAo+ID4gPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgdmlydHF1ZXVlICp2cSkKPiA+ID4gPiAg
ewo+ID4gPiA+IEBAIC0yMzQxLDkgKzIzNjEsMTEgQEAgc3RhdGljIGludCB2aXJ0bmV0X2Nsb3Nl
KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCj4gPiA+ID4gICAgICAgcmV0dXJuIDA7Cj4gPiA+ID4g
IH0KPiA+ID4gPgo+ID4gPiA+IC1zdGF0aWMgdm9pZCB2aXJ0bmV0X3NldF9yeF9tb2RlKHN0cnVj
dCBuZXRfZGV2aWNlICpkZXYpCj4gPiA+ID4gK3N0YXRpYyB2b2lkIHZpcnRuZXRfcnhfbW9kZV93
b3JrKHN0cnVjdCB3b3JrX3N0cnVjdCAqd29yaykKPiA+ID4gPiAgewo+ID4gPiA+IC0gICAgIHN0
cnVjdCB2aXJ0bmV0X2luZm8gKnZpID0gbmV0ZGV2X3ByaXYoZGV2KTsKPiA+ID4gPiArICAgICBz
dHJ1Y3QgdmlydG5ldF9pbmZvICp2aSA9Cj4gPiA+ID4gKyAgICAgICAgICAgICBjb250YWluZXJf
b2Yod29yaywgc3RydWN0IHZpcnRuZXRfaW5mbywgcnhfbW9kZV93b3JrKTsKPiA+ID4gPiArICAg
ICBzdHJ1Y3QgbmV0X2RldmljZSAqZGV2ID0gdmktPmRldjsKPiA+ID4gPiAgICAgICBzdHJ1Y3Qg
c2NhdHRlcmxpc3Qgc2dbMl07Cj4gPiA+ID4gICAgICAgc3RydWN0IHZpcnRpb19uZXRfY3RybF9t
YWMgKm1hY19kYXRhOwo+ID4gPiA+ICAgICAgIHN0cnVjdCBuZXRkZXZfaHdfYWRkciAqaGE7Cj4g
PiA+ID4gQEAgLTIzNTYsNiArMjM3OCw4IEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRfc2V0X3J4X21v
ZGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiA+ID4gPiAgICAgICBpZiAoIXZpcnRpb19oYXNf
ZmVhdHVyZSh2aS0+dmRldiwgVklSVElPX05FVF9GX0NUUkxfUlgpKQo+ID4gPiA+ICAgICAgICAg
ICAgICAgcmV0dXJuOwo+ID4gPiA+Cj4gPiA+ID4gKyAgICAgcnRubF9sb2NrKCk7Cj4gPiA+ID4g
Kwo+ID4gPiA+ICAgICAgIHZpLT5jdHJsLT5wcm9taXNjID0gKChkZXYtPmZsYWdzICYgSUZGX1BS
T01JU0MpICE9IDApOwo+ID4gPiA+ICAgICAgIHZpLT5jdHJsLT5hbGxtdWx0aSA9ICgoZGV2LT5m
bGFncyAmIElGRl9BTExNVUxUSSkgIT0gMCk7Cj4gPiA+ID4KPiA+ID4gPiBAQCAtMjM3MywxNCAr
MjM5NywxOSBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0X3NldF9yeF9tb2RlKHN0cnVjdCBuZXRfZGV2
aWNlICpkZXYpCj4gPiA+ID4gICAgICAgICAgICAgICBkZXZfd2FybigmZGV2LT5kZXYsICJGYWls
ZWQgdG8gJXNhYmxlIGFsbG11bHRpIG1vZGUuXG4iLAo+ID4gPiA+ICAgICAgICAgICAgICAgICAg
ICAgICAgdmktPmN0cmwtPmFsbG11bHRpID8gImVuIiA6ICJkaXMiKTsKPiA+ID4gPgo+ID4gPiA+
ICsgICAgIG5ldGlmX2FkZHJfbG9ja19iaChkZXYpOwo+ID4gPiA+ICsKPiA+ID4gPiAgICAgICB1
Y19jb3VudCA9IG5ldGRldl91Y19jb3VudChkZXYpOwo+ID4gPiA+ICAgICAgIG1jX2NvdW50ID0g
bmV0ZGV2X21jX2NvdW50KGRldik7Cj4gPiA+ID4gICAgICAgLyogTUFDIGZpbHRlciAtIHVzZSBv
bmUgYnVmZmVyIGZvciBib3RoIGxpc3RzICovCj4gPiA+ID4gICAgICAgYnVmID0ga3phbGxvYygo
KHVjX2NvdW50ICsgbWNfY291bnQpICogRVRIX0FMRU4pICsKPiA+ID4gPiAgICAgICAgICAgICAg
ICAgICAgICgyICogc2l6ZW9mKG1hY19kYXRhLT5lbnRyaWVzKSksIEdGUF9BVE9NSUMpOwo+ID4g
PiA+ICAgICAgIG1hY19kYXRhID0gYnVmOwo+ID4gPiA+IC0gICAgIGlmICghYnVmKQo+ID4gPiA+
ICsgICAgIGlmICghYnVmKSB7Cj4gPiA+ID4gKyAgICAgICAgICAgICBuZXRpZl9hZGRyX3VubG9j
a19iaChkZXYpOwo+ID4gPiA+ICsgICAgICAgICAgICAgcnRubF91bmxvY2soKTsKPiA+ID4gPiAg
ICAgICAgICAgICAgIHJldHVybjsKPiA+ID4gPiArICAgICB9Cj4gPiA+ID4KPiA+ID4gPiAgICAg
ICBzZ19pbml0X3RhYmxlKHNnLCAyKTsKPiA+ID4gPgo+ID4gPiA+IEBAIC0yNDAxLDYgKzI0MzAs
OCBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0X3NldF9yeF9tb2RlKHN0cnVjdCBuZXRfZGV2aWNlICpk
ZXYpCj4gPiA+ID4gICAgICAgbmV0ZGV2X2Zvcl9lYWNoX21jX2FkZHIoaGEsIGRldikKPiA+ID4g
PiAgICAgICAgICAgICAgIG1lbWNweSgmbWFjX2RhdGEtPm1hY3NbaSsrXVswXSwgaGEtPmFkZHIs
IEVUSF9BTEVOKTsKPiA+ID4gPgo+ID4gPiA+ICsgICAgIG5ldGlmX2FkZHJfdW5sb2NrX2JoKGRl
dik7Cj4gPiA+ID4gKwo+ID4gPiA+ICAgICAgIHNnX3NldF9idWYoJnNnWzFdLCBtYWNfZGF0YSwK
PiA+ID4gPiAgICAgICAgICAgICAgICAgIHNpemVvZihtYWNfZGF0YS0+ZW50cmllcykgKyAobWNf
Y291bnQgKiBFVEhfQUxFTikpOwo+ID4gPiA+Cj4gPiA+ID4gQEAgLTI0MDgsOSArMjQzOSwxOSBA
QCBzdGF0aWMgdm9pZCB2aXJ0bmV0X3NldF9yeF9tb2RlKHN0cnVjdCBuZXRfZGV2aWNlICpkZXYp
Cj4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9fTkVUX0NUUkxf
TUFDX1RBQkxFX1NFVCwgc2cpKQo+ID4gPiA+ICAgICAgICAgICAgICAgZGV2X3dhcm4oJmRldi0+
ZGV2LCAiRmFpbGVkIHRvIHNldCBNQUMgZmlsdGVyIHRhYmxlLlxuIik7Cj4gPiA+ID4KPiA+ID4g
PiArICAgICBydG5sX3VubG9jaygpOwo+ID4gPiA+ICsKPiA+ID4gPiAgICAgICBrZnJlZShidWYp
Owo+ID4gPiA+ICB9Cj4gPiA+ID4KPiA+ID4gPiArc3RhdGljIHZvaWQgdmlydG5ldF9zZXRfcnhf
bW9kZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQo+ID4gPiA+ICt7Cj4gPiA+ID4gKyAgICAgc3Ry
dWN0IHZpcnRuZXRfaW5mbyAqdmkgPSBuZXRkZXZfcHJpdihkZXYpOwo+ID4gPiA+ICsKPiA+ID4g
PiArICAgICBpZiAodmktPnJ4X21vZGVfd29ya19lbmFibGVkKQo+ID4gPiA+ICsgICAgICAgICAg
ICAgc2NoZWR1bGVfd29yaygmdmktPnJ4X21vZGVfd29yayk7Cj4gPiA+ID4gK30KPiA+ID4gPiAr
Cj4gPiA+Cj4gPiA+ID4gIHN0YXRpYyBpbnQgdmlydG5ldF92bGFuX3J4X2FkZF92aWQoc3RydWN0
IG5ldF9kZXZpY2UgKmRldiwKPiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBfX2JlMTYgcHJvdG8sIHUxNiB2aWQpCj4gPiA+ID4gIHsKPiA+ID4gPiBAQCAtMzE4MSw2ICsz
MjIyLDggQEAgc3RhdGljIHZvaWQgdmlydG5ldF9mcmVlemVfZG93bihzdHJ1Y3QgdmlydGlvX2Rl
dmljZSAqdmRldikKPiA+ID4gPgo+ID4gPiA+ICAgICAgIC8qIE1ha2Ugc3VyZSBubyB3b3JrIGhh
bmRsZXIgaXMgYWNjZXNzaW5nIHRoZSBkZXZpY2UgKi8KPiA+ID4gPiAgICAgICBmbHVzaF93b3Jr
KCZ2aS0+Y29uZmlnX3dvcmspOwo+ID4gPiA+ICsgICAgIGRpc2FibGVfcnhfbW9kZV93b3JrKHZp
KTsKPiA+ID4gPiArICAgICBmbHVzaF93b3JrKCZ2aS0+cnhfbW9kZV93b3JrKTsKPiA+ID4gPgo+
ID4gPiA+ICAgICAgIG5ldGlmX3R4X2xvY2tfYmgodmktPmRldik7Cj4gPiA+ID4gICAgICAgbmV0
aWZfZGV2aWNlX2RldGFjaCh2aS0+ZGV2KTsKPiA+ID4KPiA+ID4gSG1tIHNvIHF1ZXVlZCByeCBt
b2RlIHdvcmsgd2lsbCBqdXN0IGdldCBza2lwcGVkCj4gPiA+IGFuZCBvbiByZXN0b3JlIHdlIGdl
dCBhIHdyb25nIHJ4IG1vZGUuCj4gPiA+IEFueSB3YXkgdG8gbWFrZSB0aGlzIG1vcmUgcm9idXN0
Pwo+ID4KPiA+IEl0IGNvdWxkIGJlIGRvbmUgYnkgc2NoZWR1bGluZyBhIHdvcmsgb24gcmVzdG9y
ZS4KClJldGhpbmsgdGhpcywgSSB0aGluayB3ZSBkb24ndCBuZWVkIHRvIGNhcmUgYWJvdXQgdGhp
cyBjYXNlIHNpbmNlIHRoZQp1c2VyIHByb2Nlc3NlcyBzaG91bGQgaGF2ZSBiZWVuIGZyb3plbmVk
LiBBbmQgdGhhdCB0aGUgcmVhc29uIHdlIGRvbid0CmV2ZW4gbmVlZCB0byBob2xkIFJUTkwgaGVy
ZS4KClRoYW5rcwoKPiA+Cj4gPiBUaGFua3MKPgo+Cj4gPiA+Cj4gPiA+Cj4gPiA+ID4gQEAgLTMy
MDMsNiArMzI0Niw3IEBAIHN0YXRpYyBpbnQgdmlydG5ldF9yZXN0b3JlX3VwKHN0cnVjdCB2aXJ0
aW9fZGV2aWNlICp2ZGV2KQo+ID4gPiA+ICAgICAgIHZpcnRpb19kZXZpY2VfcmVhZHkodmRldik7
Cj4gPiA+ID4KPiA+ID4gPiAgICAgICBlbmFibGVfZGVsYXllZF9yZWZpbGwodmkpOwo+ID4gPiA+
ICsgICAgIGVuYWJsZV9yeF9tb2RlX3dvcmsodmkpOwo+ID4gPiA+Cj4gPiA+ID4gICAgICAgaWYg
KG5ldGlmX3J1bm5pbmcodmktPmRldikpIHsKPiA+ID4gPiAgICAgICAgICAgICAgIGVyciA9IHZp
cnRuZXRfb3Blbih2aS0+ZGV2KTsKPiA+ID4gPiBAQCAtNDAwMiw2ICs0MDQ2LDcgQEAgc3RhdGlj
IGludCB2aXJ0bmV0X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gPiA+ICAg
ICAgIHZkZXYtPnByaXYgPSB2aTsKPiA+ID4gPgo+ID4gPiA+ICAgICAgIElOSVRfV09SSygmdmkt
PmNvbmZpZ193b3JrLCB2aXJ0bmV0X2NvbmZpZ19jaGFuZ2VkX3dvcmspOwo+ID4gPiA+ICsgICAg
IElOSVRfV09SSygmdmktPnJ4X21vZGVfd29yaywgdmlydG5ldF9yeF9tb2RlX3dvcmspOwo+ID4g
PiA+ICAgICAgIHNwaW5fbG9ja19pbml0KCZ2aS0+cmVmaWxsX2xvY2spOwo+ID4gPiA+Cj4gPiA+
ID4gICAgICAgaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfTVJHX1JY
QlVGKSkgewo+ID4gPiA+IEBAIC00MTEwLDYgKzQxNTUsOCBAQCBzdGF0aWMgaW50IHZpcnRuZXRf
cHJvYmUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gPiA+ID4gICAgICAgaWYgKHZpLT5o
YXNfcnNzIHx8IHZpLT5oYXNfcnNzX2hhc2hfcmVwb3J0KQo+ID4gPiA+ICAgICAgICAgICAgICAg
dmlydG5ldF9pbml0X2RlZmF1bHRfcnNzKHZpKTsKPiA+ID4gPgo+ID4gPiA+ICsgICAgIGVuYWJs
ZV9yeF9tb2RlX3dvcmsodmkpOwo+ID4gPiA+ICsKPiA+ID4gPiAgICAgICAvKiBzZXJpYWxpemUg
bmV0ZGV2IHJlZ2lzdGVyICsgdmlydGlvX2RldmljZV9yZWFkeSgpIHdpdGggbmRvX29wZW4oKSAq
Lwo+ID4gPiA+ICAgICAgIHJ0bmxfbG9jaygpOwo+ID4gPiA+Cj4gPiA+ID4gQEAgLTQyMDcsNiAr
NDI1NCw4IEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRfcmVtb3ZlKHN0cnVjdCB2aXJ0aW9fZGV2aWNl
ICp2ZGV2KQo+ID4gPiA+Cj4gPiA+ID4gICAgICAgLyogTWFrZSBzdXJlIG5vIHdvcmsgaGFuZGxl
ciBpcyBhY2Nlc3NpbmcgdGhlIGRldmljZS4gKi8KPiA+ID4gPiAgICAgICBmbHVzaF93b3JrKCZ2
aS0+Y29uZmlnX3dvcmspOwo+ID4gPiA+ICsgICAgIGRpc2FibGVfcnhfbW9kZV93b3JrKHZpKTsK
PiA+ID4gPiArICAgICBmbHVzaF93b3JrKCZ2aS0+cnhfbW9kZV93b3JrKTsKPiA+ID4gPgo+ID4g
PiA+ICAgICAgIHVucmVnaXN0ZXJfbmV0ZGV2KHZpLT5kZXYpOwo+ID4gPiA+Cj4gPiA+ID4gLS0K
PiA+ID4gPiAyLjI1LjEKPiA+ID4KPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
