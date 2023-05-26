Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56E22C7EE29
	for <virtualization@archiver.kernel.org>; Fri, 26 May 2023 01:35:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B6CD760B3C;
	Fri, 26 May 2023 01:35:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B6CD760B3C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=M6mVEbJe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ICioG9IjwKZh; Fri, 26 May 2023 01:35:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 1285A60DFD;
	Fri, 26 May 2023 01:35:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 1285A60DFD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D4DBFC0036;
	Fri, 26 May 2023 01:35:21 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 32350C002A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 01:35:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 046B141E94
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 01:35:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 046B141E94
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=M6mVEbJe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id urZQu7xioE6m
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 01:35:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A741141E89
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id A741141E89
 for <virtualization@lists.linux-foundation.org>;
 Fri, 26 May 2023 01:35:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1685064918;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=X9YZ+fj9tMCdpEx0yJi+x/cVjUY7dqnbtcz7uQ27pJA=;
 b=M6mVEbJe8v4Lp3H8dlHHRjtoMEDt7XvgfEKy4qt4ve747u4MBoyWNKFUlq+6fkaIfhfy44
 vx5D8bqcS0Qc10LG3WO1x8+PilGsdXPbStEpiANRIvLLzypWyNdJMd2Y+0TsItMrKkdG/I
 Tic/ogMxzLNpiWr+Z+vHQgHpd8Y5F5Y=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-457-zXzIDtQ-NyO4PZZ006iuXw-1; Thu, 25 May 2023 21:35:09 -0400
X-MC-Unique: zXzIDtQ-NyO4PZZ006iuXw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4f4b64cd0daso66823e87.3
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 May 2023 18:35:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1685064908; x=1687656908;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=X9YZ+fj9tMCdpEx0yJi+x/cVjUY7dqnbtcz7uQ27pJA=;
 b=X8v8Gw25HkDnMqry7/AY9YtYp1gvtzvVzITlSDHfcxxR2dR5xmb+mtsMzWLCtpT6Yg
 v7cp9LUqHagtVjtjh6fi0U8B1Ys0R/vTR9dAva1fGex11zdlCoe67w4n5bkeYIvnL7LL
 WL7aQbuPZ1Kp/JIRaTMpXlzgOgZExqL+OEexEECvWLHS4+s6BP6WhEttt6krO4NreyXD
 VDbrT3Ve07xVaWQ3e86kl3NOeZpBMxkNUuS/Ay01LD8xIjTczmqbNAciUzCcH2A+7FHp
 Rkb/wAp61Uf4ltnvhWd43boYWQMqJQQMtsPf4AXkUwCa8Y+6LwJeH5A3WIptxTJvq/gH
 Pqpw==
X-Gm-Message-State: AC+VfDzygmOdj0h95xpfykZTJ3P2nKdYmd7DI7ghFTmkUbVx9k+K6RtK
 MWqASCeszASS6DogSpD4dfHkbUPvDpwy10jYLiJu2W/3J7Dah8A0qy3UdI4T/9RNajjdoofoMFB
 JPdLVQKu5pxL2Fm5FlH79sTeVkgdCX8s/1She9OESFcnqzTYYEtyimL2bGQ==
X-Received: by 2002:ac2:54b3:0:b0:4f3:b32d:f744 with SMTP id
 w19-20020ac254b3000000b004f3b32df744mr18344lfk.11.1685064908249; 
 Thu, 25 May 2023 18:35:08 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ4lAAiq5TBU50zrEUXNhEoJz46Nn6bK1Adet8qqPWU++u0YVrC0DipLFDArSq8y0QSmlX7JuvpjW1+D38EBuFc=
X-Received: by 2002:ac2:54b3:0:b0:4f3:b32d:f744 with SMTP id
 w19-20020ac254b3000000b004f3b32df744mr18342lfk.11.1685064907952; Thu, 25 May
 2023 18:35:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230508180512.17371-1-lingshan.zhu@intel.com>
 <20230508180512.17371-5-lingshan.zhu@intel.com>
 <CACGkMEsoBw3MGzoDBG2p6Txv+0c=6JuNQDV89tg1io04QdNK9A@mail.gmail.com>
 <20d83aaf-2439-7a21-cc75-7db2e0de4659@intel.com>
In-Reply-To: <20d83aaf-2439-7a21-cc75-7db2e0de4659@intel.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 26 May 2023 09:34:56 +0800
Message-ID: <CACGkMEtmSBhaMrVCLO6TLJ40_fY5pwa2p+jC6=Q0D09zUJRcOg@mail.gmail.com>
Subject: Re: [PATCH V2 4/5] vDPA/ifcvf: synchronize irqs in the reset routine
To: "Zhu, Lingshan" <lingshan.zhu@intel.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org, mst@redhat.com
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

T24gVGh1LCBNYXkgMjUsIDIwMjMgYXQgNTozOOKAr1BNIFpodSwgTGluZ3NoYW4gPGxpbmdzaGFu
LnpodUBpbnRlbC5jb20+IHdyb3RlOgo+Cj4KPgo+IE9uIDUvMjQvMjAyMyA0OjAzIFBNLCBKYXNv
biBXYW5nIHdyb3RlOgo+ID4gT24gTW9uLCBNYXkgOCwgMjAyMyBhdCA2OjA14oCvUE0gWmh1IExp
bmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPiB3cm90ZToKPiA+PiBUaGlzIGNvbW1pdCBz
eW5jaHJvbml6ZSBpcnFzIG9mIHRoZSB2aXJ0cXVldWVzCj4gPj4gYW5kIGNvbmZpZyBzcGFjZSBp
biB0aGUgcmVzZXQgcm91dGluZS4KPiA+PiBUaHVzIGlmY3ZmX3N0b3BfaHcoKSBhbmQgcmVzZXQo
KSBhcmUgcmVmYWN0b3JlZCBhcyB3ZWxsLgo+ID4+Cj4gPj4gU2lnbmVkLW9mZi1ieTogWmh1IExp
bmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPgo+ID4+IC0tLQo+ID4+ICAgZHJpdmVycy92
ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYyB8IDQxICsrKysrKysrKysrKysrKysrKysrKy0tLS0tLS0t
Cj4gPj4gICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oIHwgIDEgKwo+ID4+ICAgZHJp
dmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyB8IDQ2ICsrKysrLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQo+ID4+ICAgMyBmaWxlcyBjaGFuZ2VkLCAzOCBpbnNlcnRpb25zKCspLCA1MCBk
ZWxldGlvbnMoLSkKPiA+Pgo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZj
dmZfYmFzZS5jIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYwo+ID4+IGluZGV4IDc5
ZTMxM2M1ZTEwZS4uMWYzOTI5MGJhYTM4IDEwMDY0NAo+ID4+IC0tLSBhL2RyaXZlcnMvdmRwYS9p
ZmN2Zi9pZmN2Zl9iYXNlLmMKPiA+PiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFz
ZS5jCj4gPj4gQEAgLTE3MCwxMiArMTcwLDkgQEAgdm9pZCBpZmN2Zl9zZXRfc3RhdHVzKHN0cnVj
dCBpZmN2Zl9odyAqaHcsIHU4IHN0YXR1cykKPiA+Pgo+ID4+ICAgdm9pZCBpZmN2Zl9yZXNldChz
dHJ1Y3QgaWZjdmZfaHcgKmh3KQo+ID4+ICAgewo+ID4+IC0gICAgICAgaHctPmNvbmZpZ19jYi5j
YWxsYmFjayA9IE5VTEw7Cj4gPj4gLSAgICAgICBody0+Y29uZmlnX2NiLnByaXZhdGUgPSBOVUxM
Owo+ID4+IC0KPiA+PiAgICAgICAgICBpZmN2Zl9zZXRfc3RhdHVzKGh3LCAwKTsKPiA+PiAtICAg
ICAgIC8qIGZsdXNoIHNldF9zdGF0dXMsIG1ha2Ugc3VyZSBWRiBpcyBzdG9wcGVkLCByZXNldCAq
Lwo+ID4+IC0gICAgICAgaWZjdmZfZ2V0X3N0YXR1cyhodyk7Cj4gPj4gKyAgICAgICB3aGlsZSAo
aWZjdmZfZ2V0X3N0YXR1cyhodykpCj4gPj4gKyAgICAgICAgICAgICAgIG1zbGVlcCgxKTsKPiA+
PiAgIH0KPiA+Pgo+ID4+ICAgdTY0IGlmY3ZmX2dldF9od19mZWF0dXJlcyhzdHJ1Y3QgaWZjdmZf
aHcgKmh3KQo+ID4+IEBAIC0zNjgsMjAgKzM2NSw0MiBAQCB2b2lkIGlmY3ZmX3NldF92cV9yZWFk
eShzdHJ1Y3QgaWZjdmZfaHcgKmh3LCB1MTYgcWlkLCBib29sIHJlYWR5KQo+ID4+ICAgICAgICAg
IHZwX2lvd3JpdGUxNihyZWFkeSwgJmNmZy0+cXVldWVfZW5hYmxlKTsKPiA+PiAgIH0KPiA+Pgo+
ID4+IC1zdGF0aWMgdm9pZCBpZmN2Zl9od19kaXNhYmxlKHN0cnVjdCBpZmN2Zl9odyAqaHcpCj4g
Pj4gK3N0YXRpYyB2b2lkIGlmY3ZmX3Jlc2V0X3ZyaW5nKHN0cnVjdCBpZmN2Zl9odyAqaHcpCj4g
Pj4gICB7Cj4gPj4gLSAgICAgICB1MzIgaTsKPiA+PiArICAgICAgIHUxNiBxaWQ7Cj4gPj4gKwo+
ID4+ICsgICAgICAgZm9yIChxaWQgPSAwOyBxaWQgPCBody0+bnJfdnJpbmc7IHFpZCsrKSB7Cj4g
Pj4gKyAgICAgICAgICAgICAgIGh3LT52cmluZ1txaWRdLmNiLmNhbGxiYWNrID0gTlVMTDsKPiA+
PiArICAgICAgICAgICAgICAgaHctPnZyaW5nW3FpZF0uY2IucHJpdmF0ZSA9IE5VTEw7Cj4gPj4g
KyAgICAgICAgICAgICAgIGlmY3ZmX3NldF92cV92ZWN0b3IoaHcsIHFpZCwgVklSVElPX01TSV9O
T19WRUNUT1IpOwo+ID4+ICsgICAgICAgfQo+ID4+ICt9Cj4gPj4KPiA+PiArc3RhdGljIHZvaWQg
aWZjdmZfcmVzZXRfY29uZmlnX2hhbmRsZXIoc3RydWN0IGlmY3ZmX2h3ICpodykKPiA+PiArewo+
ID4+ICsgICAgICAgaHctPmNvbmZpZ19jYi5jYWxsYmFjayA9IE5VTEw7Cj4gPj4gKyAgICAgICBo
dy0+Y29uZmlnX2NiLnByaXZhdGUgPSBOVUxMOwo+ID4+ICAgICAgICAgIGlmY3ZmX3NldF9jb25m
aWdfdmVjdG9yKGh3LCBWSVJUSU9fTVNJX05PX1ZFQ1RPUik7Cj4gPj4gLSAgICAgICBmb3IgKGkg
PSAwOyBpIDwgaHctPm5yX3ZyaW5nOyBpKyspIHsKPiA+PiAtICAgICAgICAgICAgICAgaWZjdmZf
c2V0X3ZxX3ZlY3RvcihodywgaSwgVklSVElPX01TSV9OT19WRUNUT1IpOwo+ID4+ICt9Cj4gPj4g
Kwo+ID4+ICtzdGF0aWMgdm9pZCBpZmN2Zl9zeW5jaHJvbml6ZV9pcnEoc3RydWN0IGlmY3ZmX2h3
ICpodykKPiA+PiArewo+ID4+ICsgICAgICAgdTMyIG52ZWN0b3JzID0gaHctPm51bV9tc2l4X3Zl
Y3RvcnM7Cj4gPj4gKyAgICAgICBzdHJ1Y3QgcGNpX2RldiAqcGRldiA9IGh3LT5wZGV2Owo+ID4+
ICsgICAgICAgaW50IGksIGlycTsKPiA+PiArCj4gPj4gKyAgICAgICBmb3IgKGkgPSAwOyBpIDwg
bnZlY3RvcnM7IGkrKykgewo+ID4+ICsgICAgICAgICAgICAgICBpcnEgPSBwY2lfaXJxX3ZlY3Rv
cihwZGV2LCBpKTsKPiA+PiArICAgICAgICAgICAgICAgaWYgKGlycSA+PSAwKQo+ID4+ICsgICAg
ICAgICAgICAgICAgICAgICAgIHN5bmNocm9uaXplX2lycShpcnEpOwo+ID4+ICAgICAgICAgIH0K
PiA+PiAgIH0KPiA+Pgo+ID4+ICAgdm9pZCBpZmN2Zl9zdG9wX2h3KHN0cnVjdCBpZmN2Zl9odyAq
aHcpCj4gPj4gICB7Cj4gPj4gLSAgICAgICBpZmN2Zl9od19kaXNhYmxlKGh3KTsKPiA+PiAtICAg
ICAgIGlmY3ZmX3Jlc2V0KGh3KTsKPiA+PiArICAgICAgIGlmY3ZmX3N5bmNocm9uaXplX2lycSho
dyk7Cj4gPj4gKyAgICAgICBpZmN2Zl9yZXNldF92cmluZyhodyk7Cj4gPj4gKyAgICAgICBpZmN2
Zl9yZXNldF9jb25maWdfaGFuZGxlcihodyk7Cj4gPiBOaXQ6Cj4gPgo+ID4gU28gdGhlIG5hbWUg
b2YgdGhpcyBmdW5jdGlvbiBpcyBraW5kIG9mIG1pc2xlYWRpbmcgc2luY2UgaXJxCj4gPiBzeW5j
aHJvbml6YXRpb24gYW5kIHZpcnRxdWV1ZS9jb25maWcgaGFuZGxlciBhcmUgbm90IGJlbG9uZyB0
bwo+ID4gaGFyZHdhcmU/Cj4gPgo+ID4gTWF5YmUgaXQgd291bGQgYmUgYmV0dGVyIHRvIGNhbGwg
aXQgaWZjdmZfc3RvcCgpLgo+IFN1cmUsIEkgd2lsbCBzZW5kIGEgVjMgd2l0aCB0aGlzIHJlbmFt
aW5nLAo+IGRvIHlvdSBhY2sgcGF0Y2ggMS81PwoKWWVzLCBJIHRoaW5rIEkndmUgYWNrZWQgdG8g
dGhhdCBwYXRjaC4KClRoYW5rcwoKPgo+IFRoYW5rcwo+IFpodSBMaW5nc2hhbgo+ID4KPiA+IFRo
YW5rcwo+ID4KPiA+PiAgIH0KPiA+Pgo+ID4+ICAgdm9pZCBpZmN2Zl9ub3RpZnlfcXVldWUoc3Ry
dWN0IGlmY3ZmX2h3ICpodywgdTE2IHFpZCkKPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBh
L2lmY3ZmL2lmY3ZmX2Jhc2UuaCBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPiA+
PiBpbmRleCBkMzRkM2JjMGRiZjQuLjc0MzBmODA3NzliZSAxMDA2NDQKPiA+PiAtLS0gYS9kcml2
ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4gPj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3Zm
L2lmY3ZmX2Jhc2UuaAo+ID4+IEBAIC04Miw2ICs4Miw3IEBAIHN0cnVjdCBpZmN2Zl9odyB7Cj4g
Pj4gICAgICAgICAgaW50IHZxc19yZXVzZWRfaXJxOwo+ID4+ICAgICAgICAgIHUxNiBucl92cmlu
ZzsKPiA+PiAgICAgICAgICAvKiBWSVJUSU9fUENJX0NBUF9ERVZJQ0VfQ0ZHIHNpemUgKi8KPiA+
PiArICAgICAgIHUzMiBudW1fbXNpeF92ZWN0b3JzOwo+ID4+ICAgICAgICAgIHUzMiBjYXBfZGV2
X2NvbmZpZ19zaXplOwo+ID4+ICAgICAgICAgIHN0cnVjdCBwY2lfZGV2ICpwZGV2Owo+ID4+ICAg
fTsKPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyBiL2Ry
aXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPiA+PiBpbmRleCA5Njg2ODcxNTllNDQuLjM0
MDFiOTkwMWRkMiAxMDA2NDQKPiA+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFp
bi5jCj4gPj4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+ID4+IEBAIC0x
MjUsNiArMTI1LDcgQEAgc3RhdGljIHZvaWQgaWZjdmZfZnJlZV9pcnEoc3RydWN0IGlmY3ZmX2h3
ICp2ZikKPiA+PiAgICAgICAgICBpZmN2Zl9mcmVlX3ZxX2lycSh2Zik7Cj4gPj4gICAgICAgICAg
aWZjdmZfZnJlZV9jb25maWdfaXJxKHZmKTsKPiA+PiAgICAgICAgICBpZmN2Zl9mcmVlX2lycV92
ZWN0b3JzKHBkZXYpOwo+ID4+ICsgICAgICAgdmYtPm51bV9tc2l4X3ZlY3RvcnMgPSAwOwo+ID4+
ICAgfQo+ID4+Cj4gPj4gICAvKiBpZmN2ZiBNU0lYIHZlY3RvcnMgYWxsb2NhdG9yLCB0aGlzIGhl
bHBlciB0cmllcyB0byBhbGxvY2F0ZQo+ID4+IEBAIC0zNDMsMzYgKzM0NCwxMSBAQCBzdGF0aWMg
aW50IGlmY3ZmX3JlcXVlc3RfaXJxKHN0cnVjdCBpZmN2Zl9odyAqdmYpCj4gPj4gICAgICAgICAg
aWYgKHJldCkKPiA+PiAgICAgICAgICAgICAgICAgIHJldHVybiByZXQ7Cj4gPj4KPiA+PiAtICAg
ICAgIHJldHVybiAwOwo+ID4+IC19Cj4gPj4gLQo+ID4+IC1zdGF0aWMgaW50IGlmY3ZmX3N0b3Bf
ZGF0YXBhdGgoc3RydWN0IGlmY3ZmX2FkYXB0ZXIgKmFkYXB0ZXIpCj4gPj4gLXsKPiA+PiAtICAg
ICAgIHN0cnVjdCBpZmN2Zl9odyAqdmYgPSBhZGFwdGVyLT52ZjsKPiA+PiAtICAgICAgIGludCBp
Owo+ID4+IC0KPiA+PiAtICAgICAgIGZvciAoaSA9IDA7IGkgPCB2Zi0+bnJfdnJpbmc7IGkrKykK
PiA+PiAtICAgICAgICAgICAgICAgdmYtPnZyaW5nW2ldLmNiLmNhbGxiYWNrID0gTlVMTDsKPiA+
PiAtCj4gPj4gLSAgICAgICBpZmN2Zl9zdG9wX2h3KHZmKTsKPiA+PiArICAgICAgIHZmLT5udW1f
bXNpeF92ZWN0b3JzID0gbnZlY3RvcnM7Cj4gPj4KPiA+PiAgICAgICAgICByZXR1cm4gMDsKPiA+
PiAgIH0KPiA+Pgo+ID4+IC1zdGF0aWMgdm9pZCBpZmN2Zl9yZXNldF92cmluZyhzdHJ1Y3QgaWZj
dmZfYWRhcHRlciAqYWRhcHRlcikKPiA+PiAtewo+ID4+IC0gICAgICAgc3RydWN0IGlmY3ZmX2h3
ICp2ZiA9IGFkYXB0ZXItPnZmOwo+ID4+IC0gICAgICAgaW50IGk7Cj4gPj4gLQo+ID4+IC0gICAg
ICAgZm9yIChpID0gMDsgaSA8IHZmLT5ucl92cmluZzsgaSsrKSB7Cj4gPj4gLSAgICAgICAgICAg
ICAgIHZmLT52cmluZ1tpXS5sYXN0X2F2YWlsX2lkeCA9IDA7Cj4gPj4gLSAgICAgICAgICAgICAg
IHZmLT52cmluZ1tpXS5jYi5jYWxsYmFjayA9IE5VTEw7Cj4gPj4gLSAgICAgICAgICAgICAgIHZm
LT52cmluZ1tpXS5jYi5wcml2YXRlID0gTlVMTDsKPiA+PiAtICAgICAgIH0KPiA+PiAtCj4gPj4g
LSAgICAgICBpZmN2Zl9yZXNldCh2Zik7Cj4gPj4gLX0KPiA+PiAtCj4gPj4gICBzdGF0aWMgc3Ry
dWN0IGlmY3ZmX2FkYXB0ZXIgKnZkcGFfdG9fYWRhcHRlcihzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZk
cGFfZGV2KQo+ID4+ICAgewo+ID4+ICAgICAgICAgIHJldHVybiBjb250YWluZXJfb2YodmRwYV9k
ZXYsIHN0cnVjdCBpZmN2Zl9hZGFwdGVyLCB2ZHBhKTsKPiA+PiBAQCAtNDYyLDIzICs0MzgsMTUg
QEAgc3RhdGljIHZvaWQgaWZjdmZfdmRwYV9zZXRfc3RhdHVzKHN0cnVjdCB2ZHBhX2RldmljZSAq
dmRwYV9kZXYsIHU4IHN0YXR1cykKPiA+Pgo+ID4+ICAgc3RhdGljIGludCBpZmN2Zl92ZHBhX3Jl
c2V0KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYpCj4gPj4gICB7Cj4gPj4gLSAgICAgICBz
dHJ1Y3QgaWZjdmZfYWRhcHRlciAqYWRhcHRlcjsKPiA+PiAtICAgICAgIHN0cnVjdCBpZmN2Zl9o
dyAqdmY7Cj4gPj4gLSAgICAgICB1OCBzdGF0dXNfb2xkOwo+ID4+IC0KPiA+PiAtICAgICAgIHZm
ICA9IHZkcGFfdG9fdmYodmRwYV9kZXYpOwo+ID4+IC0gICAgICAgYWRhcHRlciA9IHZkcGFfdG9f
YWRhcHRlcih2ZHBhX2Rldik7Cj4gPj4gLSAgICAgICBzdGF0dXNfb2xkID0gaWZjdmZfZ2V0X3N0
YXR1cyh2Zik7Cj4gPj4gKyAgICAgICBzdHJ1Y3QgaWZjdmZfaHcgKnZmID0gdmRwYV90b192Zih2
ZHBhX2Rldik7Cj4gPj4gKyAgICAgICB1OCBzdGF0dXMgPSBpZmN2Zl9nZXRfc3RhdHVzKHZmKTsK
PiA+Pgo+ID4+IC0gICAgICAgaWYgKHN0YXR1c19vbGQgPT0gMCkKPiA+PiAtICAgICAgICAgICAg
ICAgcmV0dXJuIDA7Cj4gPj4gKyAgICAgICBpZmN2Zl9zdG9wX2h3KHZmKTsKPiA+Pgo+ID4+IC0g
ICAgICAgaWYgKHN0YXR1c19vbGQgJiBWSVJUSU9fQ09ORklHX1NfRFJJVkVSX09LKSB7Cj4gPj4g
LSAgICAgICAgICAgICAgIGlmY3ZmX3N0b3BfZGF0YXBhdGgoYWRhcHRlcik7Cj4gPj4gKyAgICAg
ICBpZiAoc3RhdHVzICYgVklSVElPX0NPTkZJR19TX0RSSVZFUl9PSykKPiA+PiAgICAgICAgICAg
ICAgICAgIGlmY3ZmX2ZyZWVfaXJxKHZmKTsKPiA+PiAtICAgICAgIH0KPiA+Pgo+ID4+IC0gICAg
ICAgaWZjdmZfcmVzZXRfdnJpbmcoYWRhcHRlcik7Cj4gPj4gKyAgICAgICBpZmN2Zl9yZXNldCh2
Zik7Cj4gPj4KPiA+PiAgICAgICAgICByZXR1cm4gMDsKPiA+PiAgIH0KPiA+PiAtLQo+ID4+IDIu
MzkuMQo+ID4+Cj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
