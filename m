Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 754F0C77B7A
	for <virtualization@archiver.kernel.org>; Thu, 25 May 2023 07:42:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E29EF61324;
	Thu, 25 May 2023 07:42:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E29EF61324
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FFai56Fh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id KURYSFwvLZE8; Thu, 25 May 2023 07:42:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3A25461300;
	Thu, 25 May 2023 07:42:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3A25461300
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B19AC0035;
	Thu, 25 May 2023 07:42:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7CBB3C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 07:42:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4351761302
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 07:42:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4351761302
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id j3bf10T1IPJQ
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 07:42:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E359D61300
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E359D61300
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 07:41:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685000518;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xLlszakwtl2NiocvGs5LQWEAprM6Y0QlYDNKUyv6EwY=;
 b=FFai56Fh9x4mkZsmR0+2G5LfTjMbyBGvihPhHtCW7kh6Nvrc3/LdELNn7lqm/iUVglRhr3
 ZS1KOMTvxX3+0p2GlCZYtrn8XODEJ8YVT8q0+Csc+N2gXFs7/isfgg+elbu0+Qvom70vEO
 +ZOsNhWNkyY1TMjAbrJ5R8eBJs6pRsc=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-658-kfrobCa-OV-7kr0br-WHgA-1; Thu, 25 May 2023 03:41:54 -0400
X-MC-Unique: kfrobCa-OV-7kr0br-WHgA-1
Received: by mail-qv1-f69.google.com with SMTP id
 6a1803df08f44-6240a60181dso7067446d6.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 00:41:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685000514; x=1687592514;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=xLlszakwtl2NiocvGs5LQWEAprM6Y0QlYDNKUyv6EwY=;
 b=fgVbYuR7H48W9rFGb0l/poH6swqW0b9lZsZGtbGi3Q7SUJpvFkTgKZfLZrst7m1Hx5
 SVI9WYPRE7yb16cRIYrBonfIWy1W4Q4v3Mkm0GS45vMLiqr2fxwQ28R8702WBJgKoJ1W
 mRK9KJx3lg4ZtGaJOXuDqEXqk4pe2sv1Tt8UzP7XQVAR3fpP7uSvWhWstfBo2xw0zDNO
 Gmlhzz6OIfGHeUbOMV7FWz0FxlOu0sS2uT6kTWMV6Xo7/B2caPvmoTlXkv5BW/7z5i0W
 7P/+E5Fvz8/k+NWV7LRK9E+1eVc6JX3akhILFKTbY1p5H3kllTnsC03KwA7vHU2OdWF7
 rInA==
X-Gm-Message-State: AC+VfDx/QJMYFAQOgYjzJrRWl7RV0zTE1wFUeL3TqHw0MdO+6Nsktsle
 okEVNggON+HYzcwywdwrlBI/+vpyh2pnGJUBpeNSwakU3RPTy7SvXS+wAiE9GkMg0cZJHGtAgNY
 er9QxUWjq1th4bhwe5HnXKjhlbvHuiS0HDfLGr9pLWg==
X-Received: by 2002:a05:6214:d4e:b0:56f:52ba:cce6 with SMTP id
 14-20020a0562140d4e00b0056f52bacce6mr569111qvr.19.1685000514245; 
 Thu, 25 May 2023 00:41:54 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ5qH+YWw5yHuyI4A93GN69Ss1hSLcoPsLz80aHg9NVN0huU1YrbOORiES+yuWNgP5FGs17w4g==
X-Received: by 2002:a05:6214:d4e:b0:56f:52ba:cce6 with SMTP id
 14-20020a0562140d4e00b0056f52bacce6mr569095qvr.19.1685000513802; 
 Thu, 25 May 2023 00:41:53 -0700 (PDT)
Received: from redhat.com ([191.101.160.247]) by smtp.gmail.com with ESMTPSA id
 e14-20020a0cf74e000000b005dd8b9345besm214153qvo.86.2023.05.25.00.41.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 May 2023 00:41:53 -0700 (PDT)
Date: Thu, 25 May 2023 03:41:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 net-next 1/2] virtio-net: convert rx mode setting to
 use workqueue
Message-ID: <20230525033750-mutt-send-email-mst@kernel.org>
References: <20230524081842.3060-1-jasowang@redhat.com>
 <20230524081842.3060-2-jasowang@redhat.com>
 <20230524050604-mutt-send-email-mst@kernel.org>
 <CACGkMEvm=MJz5e2C_7U=yjrvoo7pxsr=tRAL29OdxJDWhvtiSQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEvm=MJz5e2C_7U=yjrvoo7pxsr=tRAL29OdxJDWhvtiSQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
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

T24gVGh1LCBNYXkgMjUsIDIwMjMgYXQgMTE6NDM6MzRBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBXZWQsIE1heSAyNCwgMjAyMyBhdCA1OjE14oCvUE0gTWljaGFlbCBTLiBUc2lya2lu
IDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24gV2VkLCBNYXkgMjQsIDIwMjMgYXQg
MDQ6MTg6NDFQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gVGhpcyBwYXRjaCBjb252
ZXJ0IHJ4IG1vZGUgc2V0dGluZyB0byBiZSBkb25lIGluIGEgd29ya3F1ZXVlLCB0aGlzIGlzCj4g
PiA+IGEgbXVzdCBmb3IgYWxsb3cgdG8gc2xlZXAgd2hlbiB3YWl0aW5nIGZvciB0aGUgY3ZxIGNv
bW1hbmQgdG8KPiA+ID4gcmVzcG9uc2Ugc2luY2UgY3VycmVudCBjb2RlIGlzIGV4ZWN1dGVkIHVu
ZGVyIGFkZHIgc3BpbiBsb2NrLgo+ID4gPgo+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKYXNvbiBXYW5n
IDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+ID4gPiAtLS0KPiA+ID4gQ2hhbmdlcyBzaW5jZSBWMToK
PiA+ID4gLSB1c2UgUlROTCB0byBzeW5jaHJvbml6ZSByeCBtb2RlIHdvcmtlcgo+ID4gPiAtLS0K
PiA+ID4gIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDU1ICsrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKysrKysrKystLS0KPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA1MiBpbnNlcnRpb25z
KCspLCAzIGRlbGV0aW9ucygtKQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+IGluZGV4IDU2Y2Ex
ZDI3MDMwNC4uNWQyZjFkYTRlYWEwIDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2ZXJzL25ldC92aXJ0
aW9fbmV0LmMKPiA+ID4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4gPiA+IEBAIC0y
NjUsNiArMjY1LDEyIEBAIHN0cnVjdCB2aXJ0bmV0X2luZm8gewo+ID4gPiAgICAgICAvKiBXb3Jr
IHN0cnVjdCBmb3IgY29uZmlnIHNwYWNlIHVwZGF0ZXMgKi8KPiA+ID4gICAgICAgc3RydWN0IHdv
cmtfc3RydWN0IGNvbmZpZ193b3JrOwo+ID4gPgo+ID4gPiArICAgICAvKiBXb3JrIHN0cnVjdCBm
b3IgY29uZmlnIHJ4IG1vZGUgKi8KPiA+Cj4gPiBXaXRoIGEgYml0IGxlc3MgYWJicmV2aWF0aW9u
IG1heWJlPyBzZXR0aW5nIHJ4IG1vZGU/Cj4gCj4gVGhhdCdzIGZpbmUuCj4gCj4gPgo+ID4gPiAr
ICAgICBzdHJ1Y3Qgd29ya19zdHJ1Y3QgcnhfbW9kZV93b3JrOwo+ID4gPiArCj4gPiA+ICsgICAg
IC8qIElzIHJ4IG1vZGUgd29yayBlbmFibGVkPyAqLwo+ID4KPiA+IFVnaCBub3QgYSBncmVhdCBj
b21tZW50Lgo+IAo+IEFueSBzdWdnZXN0aW9ucyBmb3IgdGhpcy4gRS5nIHdlIGhhZDoKPiAKPiAg
ICAgICAgIC8qIElzIGRlbGF5ZWQgcmVmaWxsIGVuYWJsZWQ/ICovCgovKiBPSyB0byBxdWV1ZSB3
b3JrIHNldHRpbmcgUlggbW9kZT8gKi8KCgo+ID4KPiA+ID4gKyAgICAgYm9vbCByeF9tb2RlX3dv
cmtfZW5hYmxlZDsKPiA+ID4gKwo+ID4KPiA+Cj4gPgo+ID4gPiAgICAgICAvKiBEb2VzIHRoZSBh
ZmZpbml0eSBoaW50IGlzIHNldCBmb3IgdmlydHF1ZXVlcz8gKi8KPiA+ID4gICAgICAgYm9vbCBh
ZmZpbml0eV9oaW50X3NldDsKPiA+ID4KPiA+ID4gQEAgLTM4OCw2ICszOTQsMjAgQEAgc3RhdGlj
IHZvaWQgZGlzYWJsZV9kZWxheWVkX3JlZmlsbChzdHJ1Y3QgdmlydG5ldF9pbmZvICp2aSkKPiA+
ID4gICAgICAgc3Bpbl91bmxvY2tfYmgoJnZpLT5yZWZpbGxfbG9jayk7Cj4gPiA+ICB9Cj4gPiA+
Cj4gPiA+ICtzdGF0aWMgdm9pZCBlbmFibGVfcnhfbW9kZV93b3JrKHN0cnVjdCB2aXJ0bmV0X2lu
Zm8gKnZpKQo+ID4gPiArewo+ID4gPiArICAgICBydG5sX2xvY2soKTsKPiA+ID4gKyAgICAgdmkt
PnJ4X21vZGVfd29ya19lbmFibGVkID0gdHJ1ZTsKPiA+ID4gKyAgICAgcnRubF91bmxvY2soKTsK
PiA+ID4gK30KPiA+ID4gKwo+ID4gPiArc3RhdGljIHZvaWQgZGlzYWJsZV9yeF9tb2RlX3dvcmso
c3RydWN0IHZpcnRuZXRfaW5mbyAqdmkpCj4gPiA+ICt7Cj4gPiA+ICsgICAgIHJ0bmxfbG9jaygp
Owo+ID4gPiArICAgICB2aS0+cnhfbW9kZV93b3JrX2VuYWJsZWQgPSBmYWxzZTsKPiA+ID4gKyAg
ICAgcnRubF91bmxvY2soKTsKPiA+ID4gK30KPiA+ID4gKwo+ID4gPiAgc3RhdGljIHZvaWQgdmly
dHF1ZXVlX25hcGlfc2NoZWR1bGUoc3RydWN0IG5hcGlfc3RydWN0ICpuYXBpLAo+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHZpcnRxdWV1ZSAqdnEpCj4gPiA+
ICB7Cj4gPiA+IEBAIC0yMzQxLDkgKzIzNjEsMTEgQEAgc3RhdGljIGludCB2aXJ0bmV0X2Nsb3Nl
KHN0cnVjdCBuZXRfZGV2aWNlICpkZXYpCj4gPiA+ICAgICAgIHJldHVybiAwOwo+ID4gPiAgfQo+
ID4gPgo+ID4gPiAtc3RhdGljIHZvaWQgdmlydG5ldF9zZXRfcnhfbW9kZShzdHJ1Y3QgbmV0X2Rl
dmljZSAqZGV2KQo+ID4gPiArc3RhdGljIHZvaWQgdmlydG5ldF9yeF9tb2RlX3dvcmsoc3RydWN0
IHdvcmtfc3RydWN0ICp3b3JrKQo+ID4gPiAgewo+ID4gPiAtICAgICBzdHJ1Y3QgdmlydG5ldF9p
bmZvICp2aSA9IG5ldGRldl9wcml2KGRldik7Cj4gPiA+ICsgICAgIHN0cnVjdCB2aXJ0bmV0X2lu
Zm8gKnZpID0KPiA+ID4gKyAgICAgICAgICAgICBjb250YWluZXJfb2Yod29yaywgc3RydWN0IHZp
cnRuZXRfaW5mbywgcnhfbW9kZV93b3JrKTsKPiA+ID4gKyAgICAgc3RydWN0IG5ldF9kZXZpY2Ug
KmRldiA9IHZpLT5kZXY7Cj4gPiA+ICAgICAgIHN0cnVjdCBzY2F0dGVybGlzdCBzZ1syXTsKPiA+
ID4gICAgICAgc3RydWN0IHZpcnRpb19uZXRfY3RybF9tYWMgKm1hY19kYXRhOwo+ID4gPiAgICAg
ICBzdHJ1Y3QgbmV0ZGV2X2h3X2FkZHIgKmhhOwo+ID4gPiBAQCAtMjM1Niw2ICsyMzc4LDggQEAg
c3RhdGljIHZvaWQgdmlydG5ldF9zZXRfcnhfbW9kZShzdHJ1Y3QgbmV0X2RldmljZSAqZGV2KQo+
ID4gPiAgICAgICBpZiAoIXZpcnRpb19oYXNfZmVhdHVyZSh2aS0+dmRldiwgVklSVElPX05FVF9G
X0NUUkxfUlgpKQo+ID4gPiAgICAgICAgICAgICAgIHJldHVybjsKPiA+ID4KPiA+ID4gKyAgICAg
cnRubF9sb2NrKCk7Cj4gPiA+ICsKPiA+ID4gICAgICAgdmktPmN0cmwtPnByb21pc2MgPSAoKGRl
di0+ZmxhZ3MgJiBJRkZfUFJPTUlTQykgIT0gMCk7Cj4gPiA+ICAgICAgIHZpLT5jdHJsLT5hbGxt
dWx0aSA9ICgoZGV2LT5mbGFncyAmIElGRl9BTExNVUxUSSkgIT0gMCk7Cj4gPiA+Cj4gPiA+IEBA
IC0yMzczLDE0ICsyMzk3LDE5IEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRfc2V0X3J4X21vZGUoc3Ry
dWN0IG5ldF9kZXZpY2UgKmRldikKPiA+ID4gICAgICAgICAgICAgICBkZXZfd2FybigmZGV2LT5k
ZXYsICJGYWlsZWQgdG8gJXNhYmxlIGFsbG11bHRpIG1vZGUuXG4iLAo+ID4gPiAgICAgICAgICAg
ICAgICAgICAgICAgIHZpLT5jdHJsLT5hbGxtdWx0aSA/ICJlbiIgOiAiZGlzIik7Cj4gPiA+Cj4g
PiA+ICsgICAgIG5ldGlmX2FkZHJfbG9ja19iaChkZXYpOwo+ID4gPiArCj4gPiA+ICAgICAgIHVj
X2NvdW50ID0gbmV0ZGV2X3VjX2NvdW50KGRldik7Cj4gPiA+ICAgICAgIG1jX2NvdW50ID0gbmV0
ZGV2X21jX2NvdW50KGRldik7Cj4gPiA+ICAgICAgIC8qIE1BQyBmaWx0ZXIgLSB1c2Ugb25lIGJ1
ZmZlciBmb3IgYm90aCBsaXN0cyAqLwo+ID4gPiAgICAgICBidWYgPSBremFsbG9jKCgodWNfY291
bnQgKyBtY19jb3VudCkgKiBFVEhfQUxFTikgKwo+ID4gPiAgICAgICAgICAgICAgICAgICAgICgy
ICogc2l6ZW9mKG1hY19kYXRhLT5lbnRyaWVzKSksIEdGUF9BVE9NSUMpOwo+ID4gPiAgICAgICBt
YWNfZGF0YSA9IGJ1ZjsKPiA+ID4gLSAgICAgaWYgKCFidWYpCj4gPiA+ICsgICAgIGlmICghYnVm
KSB7Cj4gPiA+ICsgICAgICAgICAgICAgbmV0aWZfYWRkcl91bmxvY2tfYmgoZGV2KTsKPiA+ID4g
KyAgICAgICAgICAgICBydG5sX3VubG9jaygpOwo+ID4gPiAgICAgICAgICAgICAgIHJldHVybjsK
PiA+ID4gKyAgICAgfQo+ID4gPgo+ID4gPiAgICAgICBzZ19pbml0X3RhYmxlKHNnLCAyKTsKPiA+
ID4KPiA+ID4gQEAgLTI0MDEsNiArMjQzMCw4IEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRfc2V0X3J4
X21vZGUoc3RydWN0IG5ldF9kZXZpY2UgKmRldikKPiA+ID4gICAgICAgbmV0ZGV2X2Zvcl9lYWNo
X21jX2FkZHIoaGEsIGRldikKPiA+ID4gICAgICAgICAgICAgICBtZW1jcHkoJm1hY19kYXRhLT5t
YWNzW2krK11bMF0sIGhhLT5hZGRyLCBFVEhfQUxFTik7Cj4gPiA+Cj4gPiA+ICsgICAgIG5ldGlm
X2FkZHJfdW5sb2NrX2JoKGRldik7Cj4gPiA+ICsKPiA+ID4gICAgICAgc2dfc2V0X2J1Zigmc2db
MV0sIG1hY19kYXRhLAo+ID4gPiAgICAgICAgICAgICAgICAgIHNpemVvZihtYWNfZGF0YS0+ZW50
cmllcykgKyAobWNfY291bnQgKiBFVEhfQUxFTikpOwo+ID4gPgo+ID4gPiBAQCAtMjQwOCw5ICsy
NDM5LDE5IEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRfc2V0X3J4X21vZGUoc3RydWN0IG5ldF9kZXZp
Y2UgKmRldikKPiA+ID4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBWSVJUSU9fTkVU
X0NUUkxfTUFDX1RBQkxFX1NFVCwgc2cpKQo+ID4gPiAgICAgICAgICAgICAgIGRldl93YXJuKCZk
ZXYtPmRldiwgIkZhaWxlZCB0byBzZXQgTUFDIGZpbHRlciB0YWJsZS5cbiIpOwo+ID4gPgo+ID4g
PiArICAgICBydG5sX3VubG9jaygpOwo+ID4gPiArCj4gPiA+ICAgICAgIGtmcmVlKGJ1Zik7Cj4g
PiA+ICB9Cj4gPiA+Cj4gPiA+ICtzdGF0aWMgdm9pZCB2aXJ0bmV0X3NldF9yeF9tb2RlKHN0cnVj
dCBuZXRfZGV2aWNlICpkZXYpCj4gPiA+ICt7Cj4gPiA+ICsgICAgIHN0cnVjdCB2aXJ0bmV0X2lu
Zm8gKnZpID0gbmV0ZGV2X3ByaXYoZGV2KTsKPiA+ID4gKwo+ID4gPiArICAgICBpZiAodmktPnJ4
X21vZGVfd29ya19lbmFibGVkKQo+ID4gPiArICAgICAgICAgICAgIHNjaGVkdWxlX3dvcmsoJnZp
LT5yeF9tb2RlX3dvcmspOwo+ID4gPiArfQo+ID4gPiArCj4gPgo+ID4gPiAgc3RhdGljIGludCB2
aXJ0bmV0X3ZsYW5fcnhfYWRkX3ZpZChzdHJ1Y3QgbmV0X2RldmljZSAqZGV2LAo+ID4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBfX2JlMTYgcHJvdG8sIHUxNiB2aWQpCj4gPiA+
ICB7Cj4gPiA+IEBAIC0zMTgxLDYgKzMyMjIsOCBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0X2ZyZWV6
ZV9kb3duKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gPgo+ID4gPiAgICAgICAvKiBN
YWtlIHN1cmUgbm8gd29yayBoYW5kbGVyIGlzIGFjY2Vzc2luZyB0aGUgZGV2aWNlICovCj4gPiA+
ICAgICAgIGZsdXNoX3dvcmsoJnZpLT5jb25maWdfd29yayk7Cj4gPiA+ICsgICAgIGRpc2FibGVf
cnhfbW9kZV93b3JrKHZpKTsKPiA+ID4gKyAgICAgZmx1c2hfd29yaygmdmktPnJ4X21vZGVfd29y
ayk7Cj4gPiA+Cj4gPiA+ICAgICAgIG5ldGlmX3R4X2xvY2tfYmgodmktPmRldik7Cj4gPiA+ICAg
ICAgIG5ldGlmX2RldmljZV9kZXRhY2godmktPmRldik7Cj4gPgo+ID4gSG1tIHNvIHF1ZXVlZCBy
eCBtb2RlIHdvcmsgd2lsbCBqdXN0IGdldCBza2lwcGVkCj4gPiBhbmQgb24gcmVzdG9yZSB3ZSBn
ZXQgYSB3cm9uZyByeCBtb2RlLgo+ID4gQW55IHdheSB0byBtYWtlIHRoaXMgbW9yZSByb2J1c3Q/
Cj4gCj4gSXQgY291bGQgYmUgZG9uZSBieSBzY2hlZHVsaW5nIGEgd29yayBvbiByZXN0b3JlLgo+
IAo+IFRoYW5rcwoKCj4gPgo+ID4KPiA+ID4gQEAgLTMyMDMsNiArMzI0Niw3IEBAIHN0YXRpYyBp
bnQgdmlydG5ldF9yZXN0b3JlX3VwKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gPiAg
ICAgICB2aXJ0aW9fZGV2aWNlX3JlYWR5KHZkZXYpOwo+ID4gPgo+ID4gPiAgICAgICBlbmFibGVf
ZGVsYXllZF9yZWZpbGwodmkpOwo+ID4gPiArICAgICBlbmFibGVfcnhfbW9kZV93b3JrKHZpKTsK
PiA+ID4KPiA+ID4gICAgICAgaWYgKG5ldGlmX3J1bm5pbmcodmktPmRldikpIHsKPiA+ID4gICAg
ICAgICAgICAgICBlcnIgPSB2aXJ0bmV0X29wZW4odmktPmRldik7Cj4gPiA+IEBAIC00MDAyLDYg
KzQwNDYsNyBAQCBzdGF0aWMgaW50IHZpcnRuZXRfcHJvYmUoc3RydWN0IHZpcnRpb19kZXZpY2Ug
KnZkZXYpCj4gPiA+ICAgICAgIHZkZXYtPnByaXYgPSB2aTsKPiA+ID4KPiA+ID4gICAgICAgSU5J
VF9XT1JLKCZ2aS0+Y29uZmlnX3dvcmssIHZpcnRuZXRfY29uZmlnX2NoYW5nZWRfd29yayk7Cj4g
PiA+ICsgICAgIElOSVRfV09SSygmdmktPnJ4X21vZGVfd29yaywgdmlydG5ldF9yeF9tb2RlX3dv
cmspOwo+ID4gPiAgICAgICBzcGluX2xvY2tfaW5pdCgmdmktPnJlZmlsbF9sb2NrKTsKPiA+ID4K
PiA+ID4gICAgICAgaWYgKHZpcnRpb19oYXNfZmVhdHVyZSh2ZGV2LCBWSVJUSU9fTkVUX0ZfTVJH
X1JYQlVGKSkgewo+ID4gPiBAQCAtNDExMCw2ICs0MTU1LDggQEAgc3RhdGljIGludCB2aXJ0bmV0
X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ID4gPiAgICAgICBpZiAodmktPmhh
c19yc3MgfHwgdmktPmhhc19yc3NfaGFzaF9yZXBvcnQpCj4gPiA+ICAgICAgICAgICAgICAgdmly
dG5ldF9pbml0X2RlZmF1bHRfcnNzKHZpKTsKPiA+ID4KPiA+ID4gKyAgICAgZW5hYmxlX3J4X21v
ZGVfd29yayh2aSk7Cj4gPiA+ICsKPiA+ID4gICAgICAgLyogc2VyaWFsaXplIG5ldGRldiByZWdp
c3RlciArIHZpcnRpb19kZXZpY2VfcmVhZHkoKSB3aXRoIG5kb19vcGVuKCkgKi8KPiA+ID4gICAg
ICAgcnRubF9sb2NrKCk7Cj4gPiA+Cj4gPiA+IEBAIC00MjA3LDYgKzQyNTQsOCBAQCBzdGF0aWMg
dm9pZCB2aXJ0bmV0X3JlbW92ZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiA+ID4KPiA+
ID4gICAgICAgLyogTWFrZSBzdXJlIG5vIHdvcmsgaGFuZGxlciBpcyBhY2Nlc3NpbmcgdGhlIGRl
dmljZS4gKi8KPiA+ID4gICAgICAgZmx1c2hfd29yaygmdmktPmNvbmZpZ193b3JrKTsKPiA+ID4g
KyAgICAgZGlzYWJsZV9yeF9tb2RlX3dvcmsodmkpOwo+ID4gPiArICAgICBmbHVzaF93b3JrKCZ2
aS0+cnhfbW9kZV93b3JrKTsKPiA+ID4KPiA+ID4gICAgICAgdW5yZWdpc3Rlcl9uZXRkZXYodmkt
PmRldik7Cj4gPiA+Cj4gPiA+IC0tCj4gPiA+IDIuMjUuMQo+ID4KCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
