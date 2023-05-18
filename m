Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 899E2C7EE25
	for <virtualization@archiver.kernel.org>; Thu, 18 May 2023 05:24:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id E7B96408F4;
	Thu, 18 May 2023 05:24:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org E7B96408F4
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gozqQs8Y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QuKPyK9PE77B; Thu, 18 May 2023 05:24:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 11130408F8;
	Thu, 18 May 2023 05:24:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 11130408F8
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D38D1C0037;
	Thu, 18 May 2023 05:24:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4C162C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 05:24:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 12B2383CC5
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 05:24:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 12B2383CC5
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gozqQs8Y
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kUhd4GboFzit
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 05:24:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2B6818223A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 2B6818223A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 05:24:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684387447;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GrsD8X4mKF9iMZU7WYETF5oZXeiLdtauBuodAunhRF0=;
 b=gozqQs8YO/qKr5fjZX+PsxEAfBed5y0s/JdaslFXpDvN189l/lEYQ95kZgl3jWHHGyS7uL
 Jc/wTZsiMp9RZn5/TdceBd2h1jsRNZmMiJmRkFRVoIvAp0TvrV+xOqKo2d/EaCRVQofAju
 O0m+TIO6VMnWPiNrt6mmn+Z5tZyqqcQ=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-227-8rVZHOtWMymBy1mGeUpH-g-1; Thu, 18 May 2023 01:24:04 -0400
X-MC-Unique: 8rVZHOtWMymBy1mGeUpH-g-1
Received: by mail-lf1-f72.google.com with SMTP id
 2adb3069b0e04-4f19bffbc23so1128560e87.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 22:24:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684387442; x=1686979442;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=GrsD8X4mKF9iMZU7WYETF5oZXeiLdtauBuodAunhRF0=;
 b=dX7ZEBEBLX7yzATuzoMImBSYb3vtzNi34K1YDJanYHqW7ayFSnsR8Vb5jA/N0ZPF47
 /GuHQ8t2csbss2F8s2SmPDLVMCUIzoS17WB9DFp7t3KPV8+qQC8DImOBdzFfXDJp0NlZ
 5cT1Pc6zEKyXgiLGHUjZRUPosJcRiJR9fEJ+qlA0xpyl27dHIZrAJOSLWhyFT5+/WCI3
 znlnSIDsPvuRJJ9f938//PTksk7+S8ja7b/0VKieS+2b/s10QaMod2dzNg/8MDEPOYFL
 dGFSZYbxVh1K0iQYlWllCZPhQfmL1zse419KX7ThRr+TLAl4b5u2hJnkBD0L0Ocfjnp8
 bmSA==
X-Gm-Message-State: AC+VfDzWJBP18uxQV4InmP0ybTW+jJu4nFxgIgVa2GOtyVNV+U3ooskI
 G5EKu+16LOMmmqOWAjLDJ2AjeJ8IqiqwSzhYjMWZ0TCgBuaIK4PyQUlQ+UUkr+WDo3cVkiFQUjo
 zwuaXXGeVgD9lHY9UKb6f6aOa+6jRoeA5cZEBKFWHRPdZx31JRRSIzStM/w==
X-Received: by 2002:a05:6512:503:b0:4f1:43ad:7fac with SMTP id
 o3-20020a056512050300b004f143ad7facmr982722lfb.17.1684387442527; 
 Wed, 17 May 2023 22:24:02 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ69bFTJyozRNyfkwXSSg0dhoRm3OQLHiHedgCVnZuOzpAFB7PbMG87vqj9OTF34HgUaSfQL5JO6qk/PhAPvjQg=
X-Received: by 2002:a05:6512:503:b0:4f1:43ad:7fac with SMTP id
 o3-20020a056512050300b004f143ad7facmr982715lfb.17.1684387442190; Wed, 17 May
 2023 22:24:02 -0700 (PDT)
MIME-Version: 1.0
References: <20230424225031.18947-1-shannon.nelson@amd.com>
 <20230424225031.18947-3-shannon.nelson@amd.com>
 <ogzrlfid7jwfzgk42zffegaq4xhdsrpi6vu22333ub4bkmvpc3@3pa2eyzub3jn>
 <58f93ced-2f2b-dba1-b8a3-96bdb755d54e@amd.com>
 <q6cmfha36sdkgflwwd3pr4sw7rgajag4ahgjbpfjrr76w4o2b6@3yc7zs5u65s4>
 <dcfb15e6-a4c9-cb91-becd-a1e56e14d340@amd.com>
 <CACGkMEsNo4O0uAdO5koXgYbgQLoOWp81KNjsaZYSuQ7YzjvPbA@mail.gmail.com>
 <CAGxU2F4kwnGq41q99nx879Y4Br=0aeZsf2bjx2ZqpOc93G_gDQ@mail.gmail.com>
In-Reply-To: <CAGxU2F4kwnGq41q99nx879Y4Br=0aeZsf2bjx2ZqpOc93G_gDQ@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 May 2023 13:23:51 +0800
Message-ID: <CACGkMEsi0Vu21ZX2WZuEWNKQ4KTGA1iNb6+8SHeCb+Penqxr8g@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] vhost: support PACKED when setting-getting
 vring_base
To: Stefano Garzarella <sgarzare@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: drivers@pensando.io, mst@redhat.com,
 virtualization@lists.linux-foundation.org
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

T24gV2VkLCBNYXkgMTcsIDIwMjMgYXQgMzowMOKAr1BNIFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dh
cnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4KPiBPbiBXZWQsIE1heSAxNywgMjAyMyBhdCA3OjI2
4oCvQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPgo+ID4gT24g
V2VkLCBNYXkgMTcsIDIwMjMgYXQgMjoyNuKAr0FNIFNoYW5ub24gTmVsc29uIDxzaGFubm9uLm5l
bHNvbkBhbWQuY29tPiB3cm90ZToKPiA+ID4KPiA+ID4gT24gNS8xNi8yMyAxMjo0OSBBTSwgU3Rl
ZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+ID4gPiA+IE9uIE1vbiwgTWF5IDE1LCAyMDIzIGF0IDAx
OjQxOjEyUE0gLTA3MDAsIFNoYW5ub24gTmVsc29uIHdyb3RlOgo+ID4gPiA+PiBPbiA1LzkvMjMg
MTo0NiBBTSwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+ID4gPiA+Pj4gT24gTW9uLCBBcHIg
MjQsIDIwMjMgYXQgMDM6NTA6MzBQTSAtMDcwMCwgU2hhbm5vbiBOZWxzb24gdmlhCj4gPiA+ID4+
PiBWaXJ0dWFsaXphdGlvbiB3cm90ZToKPiA+ID4gPj4+PiBVc2UgdGhlIHJpZ2h0IHN0cnVjdHMg
Zm9yIFBBQ0tFRCBvciBzcGxpdCB2cXMgd2hlbiBzZXR0aW5nIGFuZAo+ID4gPiA+Pj4+IGdldHRp
bmcgdGhlIHZyaW5nIGJhc2UuCj4gPiA+ID4+Pj4KPiA+ID4gPj4+PiBTaWduZWQtb2ZmLWJ5OiBT
aGFubm9uIE5lbHNvbiA8c2hhbm5vbi5uZWxzb25AYW1kLmNvbT4KPiA+ID4gPj4+PiAtLS0KPiA+
ID4gPj4+PiBkcml2ZXJzL3Zob3N0L3Zob3N0LmMgfCAxOCArKysrKysrKysrKysrLS0tLS0KPiA+
ID4gPj4+PiBkcml2ZXJzL3Zob3N0L3Zob3N0LmggfCAgOCArKysrKystLQo+ID4gPiA+Pj4+IDIg
ZmlsZXMgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkKPiA+ID4gPj4+
Pgo+ID4gPiA+Pj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMgYi9kcml2ZXJz
L3Zob3N0L3Zob3N0LmMKPiA+ID4gPj4+PiBpbmRleCBmMTFiZGJlNGMyYzUuLmY2NGVmZGE0OGYy
MSAxMDA2NDQKPiA+ID4gPj4+PiAtLS0gYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiA+ID4gPj4+
PiArKysgYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiA+ID4gPj4+PiBAQCAtMTYzMywxNyArMTYz
MywyNSBAQCBsb25nIHZob3N0X3ZyaW5nX2lvY3RsKHN0cnVjdCB2aG9zdF9kZXYKPiA+ID4gPj4+
PiAqZCwgdW5zaWduZWQgaW50IGlvY3RsLCB2b2lkIF9fdXNlciAqYXJnCj4gPiA+ID4+Pj4gICAg
ICAgICAgICAgICAgICAgICAgIHIgPSAtRUZBVUxUOwo+ID4gPiA+Pj4+ICAgICAgICAgICAgICAg
ICAgICAgICBicmVhazsKPiA+ID4gPj4+PiAgICAgICAgICAgICAgIH0KPiA+ID4gPj4+PiAtICAg
ICAgICAgICAgICBpZiAocy5udW0gPiAweGZmZmYpIHsKPiA+ID4gPj4+PiAtICAgICAgICAgICAg
ICAgICAgICAgIHIgPSAtRUlOVkFMOwo+ID4gPiA+Pj4+IC0gICAgICAgICAgICAgICAgICAgICAg
YnJlYWs7Cj4gPiA+ID4+Pj4gKyAgICAgICAgICAgICAgaWYgKHZob3N0X2hhc19mZWF0dXJlKHZx
LCBWSVJUSU9fRl9SSU5HX1BBQ0tFRCkpIHsKPiA+ID4gPj4+PiArICAgICAgICAgICAgICAgICAg
ICAgIHZxLT5sYXN0X2F2YWlsX2lkeCA9IHMubnVtICYgMHhmZmZmOwo+ID4gPiA+Pj4+ICsgICAg
ICAgICAgICAgICAgICAgICAgdnEtPmxhc3RfdXNlZF9pZHggPSAocy5udW0gPj4gMTYpICYgMHhm
ZmZmOwo+ID4gPiA+Pj4+ICsgICAgICAgICAgICAgIH0gZWxzZSB7Cj4gPiA+ID4+Pj4gKyAgICAg
ICAgICAgICAgICAgICAgICBpZiAocy5udW0gPiAweGZmZmYpIHsKPiA+ID4gPj4+PiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgciA9IC1FSU5WQUw7Cj4gPiA+ID4+Pj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIGJyZWFrOwo+ID4gPiA+Pj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgfQo+ID4gPiA+Pj4+ICsgICAgICAgICAgICAgICAgICAgICAgdnEtPmxhc3RfYXZhaWxf
aWR4ID0gcy5udW07Cj4gPiA+ID4+Pj4gICAgICAgICAgICAgICB9Cj4gPiA+ID4+Pj4gLSAgICAg
ICAgICAgICAgdnEtPmxhc3RfYXZhaWxfaWR4ID0gcy5udW07Cj4gPiA+ID4+Pj4gICAgICAgICAg
ICAgICAvKiBGb3JnZXQgdGhlIGNhY2hlZCBpbmRleCB2YWx1ZS4gKi8KPiA+ID4gPj4+PiAgICAg
ICAgICAgICAgIHZxLT5hdmFpbF9pZHggPSB2cS0+bGFzdF9hdmFpbF9pZHg7Cj4gPiA+ID4+Pj4g
ICAgICAgICAgICAgICBicmVhazsKPiA+ID4gPj4+PiAgICAgICBjYXNlIFZIT1NUX0dFVF9WUklO
R19CQVNFOgo+ID4gPiA+Pj4+ICAgICAgICAgICAgICAgcy5pbmRleCA9IGlkeDsKPiA+ID4gPj4+
PiAtICAgICAgICAgICAgICBzLm51bSA9IHZxLT5sYXN0X2F2YWlsX2lkeDsKPiA+ID4gPj4+PiAr
ICAgICAgICAgICAgICBpZiAodmhvc3RfaGFzX2ZlYXR1cmUodnEsIFZJUlRJT19GX1JJTkdfUEFD
S0VEKSkKPiA+ID4gPj4+PiArICAgICAgICAgICAgICAgICAgICAgIHMubnVtID0gKHUzMil2cS0+
bGFzdF9hdmFpbF9pZHggfAo+ID4gPiA+Pj4+ICgodTMyKXZxLT5sYXN0X3VzZWRfaWR4IDw8IDE2
KTsKPiA+ID4gPj4+PiArICAgICAgICAgICAgICBlbHNlCj4gPiA+ID4+Pj4gKyAgICAgICAgICAg
ICAgICAgICAgICBzLm51bSA9IHZxLT5sYXN0X2F2YWlsX2lkeDsKPiA+ID4gPj4+Cj4gPiA+ID4+
PiBUaGUgY2hhbmdlcyBMR1RNLCBidXQgc2luY2Ugd2UgYXJlIGNoYW5naW5nIHRoZSBVQVBJLCBz
aG91bGQgd2UKPiA+ID4gPj4+IHVwZGF0ZSB0aGUgZG9jdW1lbnRhdGlvbiBvZiBWSE9TVF9TRVRf
VlJJTkdfQkFTRSBhbmQKPiA+ID4gPj4+IFZIT1NUX0dFVF9WUklOR19CQVNFIGluIGluY2x1ZGUv
dWFwaS9saW51eC92aG9zdC5oPwo+ID4gPiA+Pgo+ID4gPiA+PiBDb3JyZWN0IG1lIGlmIEknbSB3
cm9uZywgYnV0IEkgZG9uJ3QgdGhpbmsgd2UncmUgY2hhbmdpbmcgYW55dGhpbmcgaW4KPiA+ID4g
Pj4gdGhlIFVBUEkgaGVyZSwganVzdCBmaXhpbmcgY29kZSB0byB3b3JrIGNvcnJlY3RseSB3aXRo
IHdoYXQgaXMgYWxyZWFkeQo+ID4gPiA+PiBoYXBwZW5pbmcuCj4gPiA+ID4KPiA+ID4gPiBJSVVD
IGJlZm9yZSB0aGlzIHBhdGNoIFZIT1NUX0dFVF9WUklOR19CQVNFIGFuZCBWSE9TVF9TRVRfVlJJ
TkdfQkFTRQo+ID4gPiA+IG5ldmVyIHdvcmtlZCB3aXRoIHBhY2tlZCB2aXJ0cXVldWUsIHNpbmNl
IHdlIHdlcmUgb25seSBoYW5kbGluZwo+ID4gPiA+IGxhc3RfYXZhaWxfaWR4LiBOb3cgd2UgYXJl
IHN1cHBvcnRpbmcgcGFja2VkIHZpcnRxdWV1ZSwgaGFuZGxpbmcKPiA+ID4gPiBpbiB2aG9zdF92
cmluZ19zdGF0ZS5udW0gYm90aCBsYXN0X2F2YWlsX2lkeCBhbmQgbGFzdF91c2VkX2lkeCAod2l0
aAo+ID4gPiA+IHdyYXAgY291bnRlcnMpLgo+ID4gPiA+Cj4gPiA+ID4gRm9yIGV4YW1wbGUgZm9y
IFZIT1NUX0dFVF9WUklOR19CQVNFIHdoZXJlIGlzIGRvY3VtZW50ZWQgdGhhdCB0aGUgZmlyc3QK
PiA+ID4gPiAxNSBiaXRzIGFyZSBsYXN0X2F2YWlsX2lkeCwgdGhlIDE2dGggdGhlIGF2YWlsX3dy
YXBfY291bnRlciwgYW5kIHRoZQo+ID4gPiA+IG90aGVycyBhcmUgbGFzdF91c2VkX2lkeCBhbmQg
dXNlZF93cmFwX2NvdW50ZXI/Cj4gPiA+ID4KPiA+ID4gPiBNYXliZSBJIG1pc3NlZCBzb21ldGhp
bmcsIGJ1dCBzaW5jZSB0aGlzIGlzIFVBUEksIElNSE8gd2Ugc2hvdWxkCj4gPiA+ID4gZG9jdW1l
bnQgdGhlIHBhcmFtZXRlcnMgb2YgaW9jdGxzIGF0IGxlYXN0IGluCj4gPiA+ID4gaW5jbHVkZS91
YXBpL2xpbnV4L3Zob3N0LmguCj4gPiA+Cj4gPiA+IFBlcmhhcHMgSmFzb24gYWxyZWFkeSBoYXMg
c29tZXRoaW5nIHdyaXR0ZW4gdXAgdGhhdCBjb3VsZCBiZSBwdXQgaW4gaGVyZQo+ID4gPiBmcm9t
IHdoZW4gaGUgZmlyc3QgYWRkZWQgdGhlIHdyYXBfY291bnRlciBhIGNvdXBsZSBvZiB5ZWFycyBh
Z28/Cj4gPgo+ID4gSWYgeW91IG1lYW50IHRoZSB2aXJ0aW8gZHJpdmVyIHN1cHBvcnQgZm9yIHBh
Y2tlZCwgSSB0aGluayBpdCdzCj4gPiBkaWZmZXJlbnQgZnJvbSB0aGUgY29udGV4dCB3aGljaCBp
cyB2aG9zdCBoZXJlLgo+ID4KPiA+IEkgYWdyZWUgd2l0aCBTdGVmYW5vIHRoYXQgd2UgbmVlZCB0
byB1cGRhdGUgdGhlIGNvbW1lbnRzIGFyb3VuZAo+ID4gR0VUX1ZSSU5HX0JBU0UgYW5kIFNFVF9W
UklOR19CQVNFLCB0aGVuIHdlIGFyZSBmaW5lLgo+Cj4gSSdtIHRoaW5raW5nIGlmIHdlIHNob3Vs
ZCBhbHNvIGFkZCBhIG5ldyBWSE9TVF9CQUNLRU5EX0ZfUklOR19QQUNLRUQKPiBmZWF0dXJlIChv
ciBzb21ldGhpbmcgc2ltaWxhcikgdG8gaW5mb3JtIHRoZSB1c2VyIHNwYWNlIHRoYXQgbm93IHdl
Cj4gYXJlIGFibGUgdG8gaGFuZGxlIHBhY2tlZCB2aXJ0cXVldWUgdGhyb3VnaCB2aG9zdCBJT0NU
THMsIG90aGVyd2lzZQo+IGhvdyBjYW4gdGhlIHVzZXJzcGFjZSBrbm93IGlmIGl0IGlzIHN1cHBv
cnRlZCBvciBub3Q/CgpJIHByb2JhYmx5IHVuZGVyc3RhbmQgdGhpcyBidXQgSSB0aGluayBpdCBz
aG91bGQgYmUgZG9uZSB2aWEKVkhPU1RfR0VUX0ZFQUVUVVJFUy4gSXQgd291bGQgYmUgYSBidXJk
ZW4gaWYgd2UgbWF0aWFuaW5nIGR1cGxpY2F0ZWQKZmVhdHVyZXMuCgpUaGFua3MKCj4KPiBUaGFu
a3MsCj4gU3RlZmFubwo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
