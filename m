Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD0BC77B7A
	for <virtualization@archiver.kernel.org>; Wed, 31 May 2023 01:07:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 987E560FC6;
	Wed, 31 May 2023 01:07:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 987E560FC6
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hcJB1m/Y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Nciu1OWa9Etf; Wed, 31 May 2023 01:07:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id DDA9060FE5;
	Wed, 31 May 2023 01:07:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org DDA9060FE5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3855C0037;
	Wed, 31 May 2023 01:07:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9772C002A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 01:07:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id BBDE9417CB
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 01:07:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BBDE9417CB
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=hcJB1m/Y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Ytr3Z_G6EowI
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 01:07:41 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6126A4171B
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 6126A4171B
 for <virtualization@lists.linux-foundation.org>;
 Wed, 31 May 2023 01:07:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685495260;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=2a4YKqXAVZsfIDOnK1o6EetH++cnzg6vwlfUs57fikU=;
 b=hcJB1m/YFc5MXdNS26DrNXL3BYzKitQrni3zfZtjrtc9RcuCZWVAN9pEq31j1nR06xCkUe
 Kr85kquD1NZy6pbcF951BIoGVXeCS+QT+TRrm5biv9YmDwmujjz+P91sA7ormVU94wCBfA
 9Jb8+b0gGX8XB+BY4+Mzi9memJOxC40=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-230-t9eJk644P8GuLNUwumdWGw-1; Tue, 30 May 2023 21:07:38 -0400
X-MC-Unique: t9eJk644P8GuLNUwumdWGw-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2af1eda690aso26829081fa.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 30 May 2023 18:07:38 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685495257; x=1688087257;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=2a4YKqXAVZsfIDOnK1o6EetH++cnzg6vwlfUs57fikU=;
 b=RKoth9X7YV0EqmOf3b0uS1aRRk7m73h9bD5yDeCzn3trKYHY4kzowMK5voif1ACLXL
 aOOtOGfN+rZ+5hvThe4EnvtMdZcLA/Rg+dC1epo5YzqtogMGll+GbwzLVG0mVCWnFbVF
 NWfCQHC1AghwZhotcp4s3L+/dcGimQOf7SI10m3249TTlMU7getZP2zkDfAuJblNAGSD
 ONdgECobzicieSW7+NSvpRqV2la2iCu1GyHC0NXfuKYYCVI9lXQ7PK5IpEzIWc0/Zt8+
 MzfdOtcRp0WMipxsL4zlGrrb6rlg0rwD1ZVfT3W9+PiG6vITWT8YIeHEHb0rvJwmqZAH
 KVaQ==
X-Gm-Message-State: AC+VfDw4P4GhqEYdA65j8rcyvSe+QHVGEsChSsxquoPPj5FU2cLmFC70
 kdb97rUXsviF03h1rQuTkc+URRbtkL6xnZeslQjWH7yMp7aPlRH0WjV7Aygb10f1YnYTo/JWL2f
 oaslYF4OrffqRlS9oORIdt8uzL21zV1kd+0ey8Km0RwzsqxLMnTbPlMDrjw==
X-Received: by 2002:a2e:83d5:0:b0:2a8:bf74:61cc with SMTP id
 s21-20020a2e83d5000000b002a8bf7461ccmr1603353ljh.26.1685495257100; 
 Tue, 30 May 2023 18:07:37 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5mcll9hwd9ORK2nSdd4ipN83XKS3tVT9bk0w17vjAvbvyIAcRZLtd9f4CeW67BqYPZlHXbCkMUDPf6FxvjQes=
X-Received: by 2002:a2e:83d5:0:b0:2a8:bf74:61cc with SMTP id
 s21-20020a2e83d5000000b002a8bf7461ccmr1603346ljh.26.1685495256793; Tue, 30
 May 2023 18:07:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230524081842.3060-1-jasowang@redhat.com>
 <20230524081842.3060-2-jasowang@redhat.com>
 <20230524050604-mutt-send-email-mst@kernel.org>
 <CACGkMEvm=MJz5e2C_7U=yjrvoo7pxsr=tRAL29OdxJDWhvtiSQ@mail.gmail.com>
 <20230525033750-mutt-send-email-mst@kernel.org>
 <CACGkMEtCA0-NY=qq_FnGzoY+VXmixGmBV3y80nZWO=NmxdRWmw@mail.gmail.com>
 <20230528073139-mutt-send-email-mst@kernel.org>
 <CACGkMEvcjjGRfNYeZaG0hS8R2fnpve62QFv_ReRTXxCUKwf36w@mail.gmail.com>
In-Reply-To: <CACGkMEvcjjGRfNYeZaG0hS8R2fnpve62QFv_ReRTXxCUKwf36w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 May 2023 09:07:25 +0800
Message-ID: <CACGkMEtgZ_=L2noqdADgNTr_E7s3adw=etvcFt3G7ZERQq43_g@mail.gmail.com>
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

T24gTW9uLCBNYXkgMjksIDIwMjMgYXQgOToyMeKAr0FNIEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gU3VuLCBNYXkgMjgsIDIwMjMgYXQgNzozOeKAr1BNIE1p
Y2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIEZyaSwg
TWF5IDI2LCAyMDIzIGF0IDA5OjMxOjM0QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+
IE9uIFRodSwgTWF5IDI1LCAyMDIzIGF0IDM6NDHigK9QTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1z
dEByZWRoYXQuY29tPiB3cm90ZToKPiA+ID4gPgo+ID4gPiA+IE9uIFRodSwgTWF5IDI1LCAyMDIz
IGF0IDExOjQzOjM0QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiBPbiBXZWQs
IE1heSAyNCwgMjAyMyBhdCA1OjE14oCvUE0gTWljaGFlbCBTLiBUc2lya2luIDxtc3RAcmVkaGF0
LmNvbT4gd3JvdGU6Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IE9uIFdlZCwgTWF5IDI0LCAyMDIz
IGF0IDA0OjE4OjQxUE0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gVGhp
cyBwYXRjaCBjb252ZXJ0IHJ4IG1vZGUgc2V0dGluZyB0byBiZSBkb25lIGluIGEgd29ya3F1ZXVl
LCB0aGlzIGlzCj4gPiA+ID4gPiA+ID4gYSBtdXN0IGZvciBhbGxvdyB0byBzbGVlcCB3aGVuIHdh
aXRpbmcgZm9yIHRoZSBjdnEgY29tbWFuZCB0bwo+ID4gPiA+ID4gPiA+IHJlc3BvbnNlIHNpbmNl
IGN1cnJlbnQgY29kZSBpcyBleGVjdXRlZCB1bmRlciBhZGRyIHNwaW4gbG9jay4KPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJl
ZGhhdC5jb20+Cj4gPiA+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiA+ID4gQ2hhbmdlcyBzaW5jZSBW
MToKPiA+ID4gPiA+ID4gPiAtIHVzZSBSVE5MIHRvIHN5bmNocm9uaXplIHJ4IG1vZGUgd29ya2Vy
Cj4gPiA+ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiA+ID4gIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQu
YyB8IDU1ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKystLS0KPiA+ID4gPiA+
ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDUyIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4g
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gPiA+ID4gaW5kZXggNTZj
YTFkMjcwMzA0Li41ZDJmMWRhNGVhYTAgMTAwNjQ0Cj4gPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVy
cy9uZXQvdmlydGlvX25ldC5jCj4gPiA+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlv
X25ldC5jCj4gPiA+ID4gPiA+ID4gQEAgLTI2NSw2ICsyNjUsMTIgQEAgc3RydWN0IHZpcnRuZXRf
aW5mbyB7Cj4gPiA+ID4gPiA+ID4gICAgICAgLyogV29yayBzdHJ1Y3QgZm9yIGNvbmZpZyBzcGFj
ZSB1cGRhdGVzICovCj4gPiA+ID4gPiA+ID4gICAgICAgc3RydWN0IHdvcmtfc3RydWN0IGNvbmZp
Z193b3JrOwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gKyAgICAgLyogV29yayBzdHJ1Y3Qg
Zm9yIGNvbmZpZyByeCBtb2RlICovCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFdpdGggYSBiaXQg
bGVzcyBhYmJyZXZpYXRpb24gbWF5YmU/IHNldHRpbmcgcnggbW9kZT8KPiA+ID4gPiA+Cj4gPiA+
ID4gPiBUaGF0J3MgZmluZS4KPiA+ID4gPiA+Cj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gKyAg
ICAgc3RydWN0IHdvcmtfc3RydWN0IHJ4X21vZGVfd29yazsKPiA+ID4gPiA+ID4gPiArCj4gPiA+
ID4gPiA+ID4gKyAgICAgLyogSXMgcnggbW9kZSB3b3JrIGVuYWJsZWQ/ICovCj4gPiA+ID4gPiA+
Cj4gPiA+ID4gPiA+IFVnaCBub3QgYSBncmVhdCBjb21tZW50Lgo+ID4gPiA+ID4KPiA+ID4gPiA+
IEFueSBzdWdnZXN0aW9ucyBmb3IgdGhpcy4gRS5nIHdlIGhhZDoKPiA+ID4gPiA+Cj4gPiA+ID4g
PiAgICAgICAgIC8qIElzIGRlbGF5ZWQgcmVmaWxsIGVuYWJsZWQ/ICovCj4gPiA+ID4KPiA+ID4g
PiAvKiBPSyB0byBxdWV1ZSB3b3JrIHNldHRpbmcgUlggbW9kZT8gKi8KPiA+ID4KPiA+ID4gT2su
Cj4gPiA+Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ICsgICAgIGJv
b2wgcnhfbW9kZV93b3JrX2VuYWJsZWQ7Cj4gPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ICAgICAgIC8qIERvZXMgdGhlIGFmZmlu
aXR5IGhpbnQgaXMgc2V0IGZvciB2aXJ0cXVldWVzPyAqLwo+ID4gPiA+ID4gPiA+ICAgICAgIGJv
b2wgYWZmaW5pdHlfaGludF9zZXQ7Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBAQCAtMzg4
LDYgKzM5NCwyMCBAQCBzdGF0aWMgdm9pZCBkaXNhYmxlX2RlbGF5ZWRfcmVmaWxsKHN0cnVjdCB2
aXJ0bmV0X2luZm8gKnZpKQo+ID4gPiA+ID4gPiA+ICAgICAgIHNwaW5fdW5sb2NrX2JoKCZ2aS0+
cmVmaWxsX2xvY2spOwo+ID4gPiA+ID4gPiA+ICB9Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiArc3RhdGljIHZvaWQgZW5hYmxlX3J4X21vZGVfd29yayhzdHJ1Y3QgdmlydG5ldF9pbmZvICp2
aSkKPiA+ID4gPiA+ID4gPiArewo+ID4gPiA+ID4gPiA+ICsgICAgIHJ0bmxfbG9jaygpOwo+ID4g
PiA+ID4gPiA+ICsgICAgIHZpLT5yeF9tb2RlX3dvcmtfZW5hYmxlZCA9IHRydWU7Cj4gPiA+ID4g
PiA+ID4gKyAgICAgcnRubF91bmxvY2soKTsKPiA+ID4gPiA+ID4gPiArfQo+ID4gPiA+ID4gPiA+
ICsKPiA+ID4gPiA+ID4gPiArc3RhdGljIHZvaWQgZGlzYWJsZV9yeF9tb2RlX3dvcmsoc3RydWN0
IHZpcnRuZXRfaW5mbyAqdmkpCj4gPiA+ID4gPiA+ID4gK3sKPiA+ID4gPiA+ID4gPiArICAgICBy
dG5sX2xvY2soKTsKPiA+ID4gPiA+ID4gPiArICAgICB2aS0+cnhfbW9kZV93b3JrX2VuYWJsZWQg
PSBmYWxzZTsKPiA+ID4gPiA+ID4gPiArICAgICBydG5sX3VubG9jaygpOwo+ID4gPiA+ID4gPiA+
ICt9Cj4gPiA+ID4gPiA+ID4gKwo+ID4gPiA+ID4gPiA+ICBzdGF0aWMgdm9pZCB2aXJ0cXVldWVf
bmFwaV9zY2hlZHVsZShzdHJ1Y3QgbmFwaV9zdHJ1Y3QgKm5hcGksCj4gPiA+ID4gPiA+ID4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aXJ0cXVldWUgKnZxKQo+ID4g
PiA+ID4gPiA+ICB7Cj4gPiA+ID4gPiA+ID4gQEAgLTIzNDEsOSArMjM2MSwxMSBAQCBzdGF0aWMg
aW50IHZpcnRuZXRfY2xvc2Uoc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiA+ID4gPiA+ID4gPiAg
ICAgICByZXR1cm4gMDsKPiA+ID4gPiA+ID4gPiAgfQo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+
ID4gLXN0YXRpYyB2b2lkIHZpcnRuZXRfc2V0X3J4X21vZGUoc3RydWN0IG5ldF9kZXZpY2UgKmRl
dikKPiA+ID4gPiA+ID4gPiArc3RhdGljIHZvaWQgdmlydG5ldF9yeF9tb2RlX3dvcmsoc3RydWN0
IHdvcmtfc3RydWN0ICp3b3JrKQo+ID4gPiA+ID4gPiA+ICB7Cj4gPiA+ID4gPiA+ID4gLSAgICAg
c3RydWN0IHZpcnRuZXRfaW5mbyAqdmkgPSBuZXRkZXZfcHJpdihkZXYpOwo+ID4gPiA+ID4gPiA+
ICsgICAgIHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpID0KPiA+ID4gPiA+ID4gPiArICAgICAgICAg
ICAgIGNvbnRhaW5lcl9vZih3b3JrLCBzdHJ1Y3QgdmlydG5ldF9pbmZvLCByeF9tb2RlX3dvcmsp
Owo+ID4gPiA+ID4gPiA+ICsgICAgIHN0cnVjdCBuZXRfZGV2aWNlICpkZXYgPSB2aS0+ZGV2Owo+
ID4gPiA+ID4gPiA+ICAgICAgIHN0cnVjdCBzY2F0dGVybGlzdCBzZ1syXTsKPiA+ID4gPiA+ID4g
PiAgICAgICBzdHJ1Y3QgdmlydGlvX25ldF9jdHJsX21hYyAqbWFjX2RhdGE7Cj4gPiA+ID4gPiA+
ID4gICAgICAgc3RydWN0IG5ldGRldl9od19hZGRyICpoYTsKPiA+ID4gPiA+ID4gPiBAQCAtMjM1
Niw2ICsyMzc4LDggQEAgc3RhdGljIHZvaWQgdmlydG5ldF9zZXRfcnhfbW9kZShzdHJ1Y3QgbmV0
X2RldmljZSAqZGV2KQo+ID4gPiA+ID4gPiA+ICAgICAgIGlmICghdmlydGlvX2hhc19mZWF0dXJl
KHZpLT52ZGV2LCBWSVJUSU9fTkVUX0ZfQ1RSTF9SWCkpCj4gPiA+ID4gPiA+ID4gICAgICAgICAg
ICAgICByZXR1cm47Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiArICAgICBydG5sX2xvY2so
KTsKPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ID4gICAgICAgdmktPmN0cmwtPnByb21pc2Mg
PSAoKGRldi0+ZmxhZ3MgJiBJRkZfUFJPTUlTQykgIT0gMCk7Cj4gPiA+ID4gPiA+ID4gICAgICAg
dmktPmN0cmwtPmFsbG11bHRpID0gKChkZXYtPmZsYWdzICYgSUZGX0FMTE1VTFRJKSAhPSAwKTsK
PiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEBAIC0yMzczLDE0ICsyMzk3LDE5IEBAIHN0YXRp
YyB2b2lkIHZpcnRuZXRfc2V0X3J4X21vZGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiA+ID4g
PiA+ID4gPiAgICAgICAgICAgICAgIGRldl93YXJuKCZkZXYtPmRldiwgIkZhaWxlZCB0byAlc2Fi
bGUgYWxsbXVsdGkgbW9kZS5cbiIsCj4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgICAg
ICB2aS0+Y3RybC0+YWxsbXVsdGkgPyAiZW4iIDogImRpcyIpOwo+ID4gPiA+ID4gPiA+Cj4gPiA+
ID4gPiA+ID4gKyAgICAgbmV0aWZfYWRkcl9sb2NrX2JoKGRldik7Cj4gPiA+ID4gPiA+ID4gKwo+
ID4gPiA+ID4gPiA+ICAgICAgIHVjX2NvdW50ID0gbmV0ZGV2X3VjX2NvdW50KGRldik7Cj4gPiA+
ID4gPiA+ID4gICAgICAgbWNfY291bnQgPSBuZXRkZXZfbWNfY291bnQoZGV2KTsKPiA+ID4gPiA+
ID4gPiAgICAgICAvKiBNQUMgZmlsdGVyIC0gdXNlIG9uZSBidWZmZXIgZm9yIGJvdGggbGlzdHMg
Ki8KPiA+ID4gPiA+ID4gPiAgICAgICBidWYgPSBremFsbG9jKCgodWNfY291bnQgKyBtY19jb3Vu
dCkgKiBFVEhfQUxFTikgKwo+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgKDIgKiBz
aXplb2YobWFjX2RhdGEtPmVudHJpZXMpKSwgR0ZQX0FUT01JQyk7Cj4gPiA+ID4gPiA+ID4gICAg
ICAgbWFjX2RhdGEgPSBidWY7Cj4gPiA+ID4gPiA+ID4gLSAgICAgaWYgKCFidWYpCj4gPiA+ID4g
PiA+ID4gKyAgICAgaWYgKCFidWYpIHsKPiA+ID4gPiA+ID4gPiArICAgICAgICAgICAgIG5ldGlm
X2FkZHJfdW5sb2NrX2JoKGRldik7Cj4gPiA+ID4gPiA+ID4gKyAgICAgICAgICAgICBydG5sX3Vu
bG9jaygpOwo+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgcmV0dXJuOwo+ID4gPiA+ID4gPiA+
ICsgICAgIH0KPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ICAgICAgIHNnX2luaXRfdGFibGUo
c2csIDIpOwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gQEAgLTI0MDEsNiArMjQzMCw4IEBA
IHN0YXRpYyB2b2lkIHZpcnRuZXRfc2V0X3J4X21vZGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldikK
PiA+ID4gPiA+ID4gPiAgICAgICBuZXRkZXZfZm9yX2VhY2hfbWNfYWRkcihoYSwgZGV2KQo+ID4g
PiA+ID4gPiA+ICAgICAgICAgICAgICAgbWVtY3B5KCZtYWNfZGF0YS0+bWFjc1tpKytdWzBdLCBo
YS0+YWRkciwgRVRIX0FMRU4pOwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gKyAgICAgbmV0
aWZfYWRkcl91bmxvY2tfYmgoZGV2KTsKPiA+ID4gPiA+ID4gPiArCj4gPiA+ID4gPiA+ID4gICAg
ICAgc2dfc2V0X2J1Zigmc2dbMV0sIG1hY19kYXRhLAo+ID4gPiA+ID4gPiA+ICAgICAgICAgICAg
ICAgICAgc2l6ZW9mKG1hY19kYXRhLT5lbnRyaWVzKSArIChtY19jb3VudCAqIEVUSF9BTEVOKSk7
Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiBAQCAtMjQwOCw5ICsyNDM5LDE5IEBAIHN0YXRp
YyB2b2lkIHZpcnRuZXRfc2V0X3J4X21vZGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiA+ID4g
PiA+ID4gPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFZJUlRJT19ORVRfQ1RSTF9N
QUNfVEFCTEVfU0VULCBzZykpCj4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICBkZXZfd2Fybigm
ZGV2LT5kZXYsICJGYWlsZWQgdG8gc2V0IE1BQyBmaWx0ZXIgdGFibGUuXG4iKTsKPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ICsgICAgIHJ0bmxfdW5sb2NrKCk7Cj4gPiA+ID4gPiA+ID4gKwo+
ID4gPiA+ID4gPiA+ICAgICAgIGtmcmVlKGJ1Zik7Cj4gPiA+ID4gPiA+ID4gIH0KPiA+ID4gPiA+
ID4gPgo+ID4gPiA+ID4gPiA+ICtzdGF0aWMgdm9pZCB2aXJ0bmV0X3NldF9yeF9tb2RlKHN0cnVj
dCBuZXRfZGV2aWNlICpkZXYpCj4gPiA+ID4gPiA+ID4gK3sKPiA+ID4gPiA+ID4gPiArICAgICBz
dHJ1Y3QgdmlydG5ldF9pbmZvICp2aSA9IG5ldGRldl9wcml2KGRldik7Cj4gPiA+ID4gPiA+ID4g
Kwo+ID4gPiA+ID4gPiA+ICsgICAgIGlmICh2aS0+cnhfbW9kZV93b3JrX2VuYWJsZWQpCj4gPiA+
ID4gPiA+ID4gKyAgICAgICAgICAgICBzY2hlZHVsZV93b3JrKCZ2aS0+cnhfbW9kZV93b3JrKTsK
PiA+ID4gPiA+ID4gPiArfQo+ID4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4g
PiAgc3RhdGljIGludCB2aXJ0bmV0X3ZsYW5fcnhfYWRkX3ZpZChzdHJ1Y3QgbmV0X2RldmljZSAq
ZGV2LAo+ID4gPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIF9fYmUx
NiBwcm90bywgdTE2IHZpZCkKPiA+ID4gPiA+ID4gPiAgewo+ID4gPiA+ID4gPiA+IEBAIC0zMTgx
LDYgKzMyMjIsOCBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0X2ZyZWV6ZV9kb3duKHN0cnVjdCB2aXJ0
aW9fZGV2aWNlICp2ZGV2KQo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gICAgICAgLyogTWFr
ZSBzdXJlIG5vIHdvcmsgaGFuZGxlciBpcyBhY2Nlc3NpbmcgdGhlIGRldmljZSAqLwo+ID4gPiA+
ID4gPiA+ICAgICAgIGZsdXNoX3dvcmsoJnZpLT5jb25maWdfd29yayk7Cj4gPiA+ID4gPiA+ID4g
KyAgICAgZGlzYWJsZV9yeF9tb2RlX3dvcmsodmkpOwo+ID4gPiA+ID4gPiA+ICsgICAgIGZsdXNo
X3dvcmsoJnZpLT5yeF9tb2RlX3dvcmspOwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gICAg
ICAgbmV0aWZfdHhfbG9ja19iaCh2aS0+ZGV2KTsKPiA+ID4gPiA+ID4gPiAgICAgICBuZXRpZl9k
ZXZpY2VfZGV0YWNoKHZpLT5kZXYpOwo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiBIbW0gc28gcXVl
dWVkIHJ4IG1vZGUgd29yayB3aWxsIGp1c3QgZ2V0IHNraXBwZWQKPiA+ID4gPiA+ID4gYW5kIG9u
IHJlc3RvcmUgd2UgZ2V0IGEgd3JvbmcgcnggbW9kZS4KPiA+ID4gPiA+ID4gQW55IHdheSB0byBt
YWtlIHRoaXMgbW9yZSByb2J1c3Q/Cj4gPiA+ID4gPgo+ID4gPiA+ID4gSXQgY291bGQgYmUgZG9u
ZSBieSBzY2hlZHVsaW5nIGEgd29yayBvbiByZXN0b3JlLgo+ID4gPgo+ID4gPiBSZXRoaW5rIHRo
aXMsIEkgdGhpbmsgd2UgZG9uJ3QgbmVlZCB0byBjYXJlIGFib3V0IHRoaXMgY2FzZSBzaW5jZSB0
aGUKPiA+ID4gdXNlciBwcm9jZXNzZXMgc2hvdWxkIGhhdmUgYmVlbiBmcm96ZW5lZC4KPiA+Cj4g
PiBZZXMgYnV0IG5vdCB0aGUgd29ya3F1ZXVlLiBXYW50IHRvIHN3aXRjaCB0byBzeXN0ZW1fZnJl
ZXphYmxlX3dxPwo+Cj4gWWVzLCBJIHdpbGwgZG8gaXQgaW4gdjIuCgpBY3R1YWxseSwgdGhpcyBk
b2Vzbid0IHdvcmsuIEZyZWV6YWJsZSB3b3JrcXVldWUgY2FuIG9ubHkgZ3VhcmFudGVlCndoZW4g
YmVpbmcgZnJlZXplZCB0aGUgbmV3IHdvcmsgd2lsbCBiZSBxdWV1ZWQgYW5kIG5vdCBzY2hlZHVs
ZWQgdW50aWwKdGhhdy4gU28gdGhlIGt0cmhlYWQgdGhhdCBpcyBleGVjdXRpbmcgdGhlIHdvcmtx
dWV1ZSBpcyBub3QgZnJlZXphYmxlLgpUaGUgYnVzeSBsb29wIChldmVuIHdpdGggY29uZF9yZXNj
aGVkKCkpIHdpbGwgZm9yY2Ugc3VzcGVuZCBpbiB0aGlzCmNhc2UuCgpJIHdvbmRlciBpZiB3ZSBz
aG91bGQgc3dpdGNoIHRvIHVzaW5nIGEgZGVkaWNhdGVkIGt0aHJlYWQgZm9yCnZpcnRpby1uZXQg
dGhlbiB3ZSBjYW4gYWxsb3cgaXQgdG8gYmUgZnJvemVuLgoKVGhhbmtzCgoKPgo+IFRoYW5rcwo+
Cj4gPgo+ID4gPiBBbmQgdGhhdCB0aGUgcmVhc29uIHdlIGRvbid0Cj4gPiA+IGV2ZW4gbmVlZCB0
byBob2xkIFJUTkwgaGVyZS4KPiA+ID4KPiA+ID4gVGhhbmtzCj4gPiA+Cj4gPiA+ID4gPgo+ID4g
PiA+ID4gVGhhbmtzCj4gPiA+ID4KPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPgo+ID4g
PiA+ID4gPiA+IEBAIC0zMjAzLDYgKzMyNDYsNyBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcmVzdG9y
ZV91cChzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiA+ID4gPiA+ID4gPiAgICAgICB2aXJ0
aW9fZGV2aWNlX3JlYWR5KHZkZXYpOwo+ID4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+ID4gICAgICAg
ZW5hYmxlX2RlbGF5ZWRfcmVmaWxsKHZpKTsKPiA+ID4gPiA+ID4gPiArICAgICBlbmFibGVfcnhf
bW9kZV93b3JrKHZpKTsKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ICAgICAgIGlmIChuZXRp
Zl9ydW5uaW5nKHZpLT5kZXYpKSB7Cj4gPiA+ID4gPiA+ID4gICAgICAgICAgICAgICBlcnIgPSB2
aXJ0bmV0X29wZW4odmktPmRldik7Cj4gPiA+ID4gPiA+ID4gQEAgLTQwMDIsNiArNDA0Niw3IEBA
IHN0YXRpYyBpbnQgdmlydG5ldF9wcm9iZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiA+
ID4gPiA+ID4gPiAgICAgICB2ZGV2LT5wcml2ID0gdmk7Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+
ID4gPiAgICAgICBJTklUX1dPUksoJnZpLT5jb25maWdfd29yaywgdmlydG5ldF9jb25maWdfY2hh
bmdlZF93b3JrKTsKPiA+ID4gPiA+ID4gPiArICAgICBJTklUX1dPUksoJnZpLT5yeF9tb2RlX3dv
cmssIHZpcnRuZXRfcnhfbW9kZV93b3JrKTsKPiA+ID4gPiA+ID4gPiAgICAgICBzcGluX2xvY2tf
aW5pdCgmdmktPnJlZmlsbF9sb2NrKTsKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ICAgICAg
IGlmICh2aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX05FVF9GX01SR19SWEJVRikpIHsK
PiA+ID4gPiA+ID4gPiBAQCAtNDExMCw2ICs0MTU1LDggQEAgc3RhdGljIGludCB2aXJ0bmV0X3By
b2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gPiA+ID4gPiA+ICAgICAgIGlmICh2
aS0+aGFzX3JzcyB8fCB2aS0+aGFzX3Jzc19oYXNoX3JlcG9ydCkKPiA+ID4gPiA+ID4gPiAgICAg
ICAgICAgICAgIHZpcnRuZXRfaW5pdF9kZWZhdWx0X3Jzcyh2aSk7Cj4gPiA+ID4gPiA+ID4KPiA+
ID4gPiA+ID4gPiArICAgICBlbmFibGVfcnhfbW9kZV93b3JrKHZpKTsKPiA+ID4gPiA+ID4gPiAr
Cj4gPiA+ID4gPiA+ID4gICAgICAgLyogc2VyaWFsaXplIG5ldGRldiByZWdpc3RlciArIHZpcnRp
b19kZXZpY2VfcmVhZHkoKSB3aXRoIG5kb19vcGVuKCkgKi8KPiA+ID4gPiA+ID4gPiAgICAgICBy
dG5sX2xvY2soKTsKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IEBAIC00MjA3LDYgKzQyNTQs
OCBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0X3JlbW92ZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRl
dikKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+ICAgICAgIC8qIE1ha2Ugc3VyZSBubyB3b3Jr
IGhhbmRsZXIgaXMgYWNjZXNzaW5nIHRoZSBkZXZpY2UuICovCj4gPiA+ID4gPiA+ID4gICAgICAg
Zmx1c2hfd29yaygmdmktPmNvbmZpZ193b3JrKTsKPiA+ID4gPiA+ID4gPiArICAgICBkaXNhYmxl
X3J4X21vZGVfd29yayh2aSk7Cj4gPiA+ID4gPiA+ID4gKyAgICAgZmx1c2hfd29yaygmdmktPnJ4
X21vZGVfd29yayk7Cj4gPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gPiAgICAgICB1bnJlZ2lzdGVy
X25ldGRldih2aS0+ZGV2KTsKPiA+ID4gPiA+ID4gPgo+ID4gPiA+ID4gPiA+IC0tCj4gPiA+ID4g
PiA+ID4gMi4yNS4xCj4gPiA+ID4gPiA+Cj4gPiA+ID4KPiA+CgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
