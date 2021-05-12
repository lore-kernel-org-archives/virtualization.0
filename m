Return-Path: <SRS0=tDXz=KH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D477C43460
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 05:24:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D5EC7615FF
	for <virtualization@archiver.kernel.org>; Wed, 12 May 2021 05:24:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D5EC7615FF
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8135560737;
	Wed, 12 May 2021 05:24:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dAQ2YEx0peC8; Wed, 12 May 2021 05:24:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 18F37605E8;
	Wed, 12 May 2021 05:24:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB318C000D;
	Wed, 12 May 2021 05:24:48 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7B9A5C0001
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 05:24:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 69C3240502
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 05:24:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20150623.gappssmtp.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id l5MMcxVQWlHy
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 05:24:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com
 [IPv6:2607:f8b0:4864:20::232])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4733A40443
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 May 2021 05:24:46 +0000 (UTC)
Received: by mail-oi1-x232.google.com with SMTP id i81so21246922oif.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 22:24:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=ZeJYl1+SkmdxkoBaspquNgXaarFia8TUxupmsd/+gVY=;
 b=vSKokEZ0qBlDZ8rMW/UFs7iLnVRflh5NB5KSfw8/+oz5/uYilhkmom4C8op6R/S4RM
 lwnZILjuXTKGDZo7DRUwEGneUq97o1WR49Z43p/oa9a++jbckLL0v4idWzPmq+V+75Bk
 jjPrdFqAEBzi7QnKjSbfSJZOu53czSSZTsBB7FE7a8aNfxS6ULsyQ00E2wrwewSR2Wke
 Lh5KFpd0Es3mwmYaHvNXWZMfjEOrHHNTrLTVxkqOjsTVRZ/SJbdegn2Xls6mYbF8otDJ
 yv+z35Ly+KybVA9UMM/B+RSk8IzUXoipGLkIH1T+MlZpH6gQAx+qYb8qQA29pk8bJzFZ
 rbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZeJYl1+SkmdxkoBaspquNgXaarFia8TUxupmsd/+gVY=;
 b=WOtvHpojmFsLBySgBYlTygEw4ixt01M5eLfB4HluWrqrxMjK/DxrWGdEWG3RAAz2cv
 w64TjG4HK8a6XZdWtMrjyZnO3ecy5DwG3Y7jtqQAWcuRUXREanEmjdbe8/HNZIQF/tm6
 gPzV29yOLv5UVh+dRoS6sH67qb9BF02OTrooc97zfxT1E6JksoRAlTiMDn5k8NUcyK1G
 Qs11rsIHIzxp4TOskI+vzdsGdHEdP5PdTPSyYniJZMaypi5Oq4bj/+23DQHlIog1zKgo
 qGyo4UVL2axBIGBNb6iAiO+gZcuIPEhI8nWZ6Fzu2nfi7Ub4gyNRWKAmq27Ga7NWvPyD
 mZMA==
X-Gm-Message-State: AOAM530TICLeigH6+Edia+oOGIBhazXzoM32wzV8TDHo7EJDfw4CUFHD
 akKKeHeo9qv3LtN2dXxmCWfqXqiiMasf9U5EEUPiwA==
X-Google-Smtp-Source: ABdhPJw6BZ1VhOhVPS0LkL38VPvvrWeVNG5WgUiq59oyadcpfJGC5zw/TctLV44J44xfy5EW/DD6ucJaGG7+iMGciUA=
X-Received: by 2002:aca:ad06:: with SMTP id w6mr6316750oie.54.1620797085238;
 Tue, 11 May 2021 22:24:45 -0700 (PDT)
MIME-Version: 1.0
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
 <20210511044253.469034-5-yuri.benditovich@daynix.com>
 <eb8c4984-f0cc-74ee-537f-fc60deaaaa73@redhat.com>
 <CAOEp5OdrCDPx4ijLcEOm=Wxma6hc=nyqw4Xm6bggBxvgtR0tbg@mail.gmail.com>
 <89759261-3a72-df6c-7a81-b7a48abfad44@redhat.com>
In-Reply-To: <89759261-3a72-df6c-7a81-b7a48abfad44@redhat.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Wed, 12 May 2021 08:24:33 +0300
Message-ID: <CAOEp5Ocm9Q69Fv=oeyCs01F9J4nCTPiOPpw9_BRZ0WnF+LtEFQ@mail.gmail.com>
Subject: Re: [PATCH 4/4] tun: indicate support for USO feature
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yan Vugenfirer <yan@daynix.com>, Jakub Kicinski <kuba@kernel.org>,
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

T24gV2VkLCBNYXkgMTIsIDIwMjEgYXQgNDozMyBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPgo+Cj4g5ZyoIDIwMjEvNS8xMSDkuIvljYg0OjMzLCBZdXJpIEJlbmRp
dG92aWNoIOWGmemBkzoKPiA+IE9uIFR1ZSwgTWF5IDExLCAyMDIxIGF0IDk6NTAgQU0gSmFzb24g
V2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPj4KPiA+PiDlnKggMjAyMS81LzEx
IOS4i+WNiDEyOjQyLCBZdXJpIEJlbmRpdG92aWNoIOWGmemBkzoKPiA+Pj4gU2lnbmVkLW9mZi1i
eTogWXVyaSBCZW5kaXRvdmljaCA8eXVyaS5iZW5kaXRvdmljaEBkYXluaXguY29tPgo+ID4+PiAt
LS0KPiA+Pj4gICAgZHJpdmVycy9uZXQvdHVuLmMgfCAyICstCj4gPj4+ICAgIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQo+ID4+Pgo+ID4+PiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9uZXQvdHVuLmMgYi9kcml2ZXJzL25ldC90dW4uYwo+ID4+PiBpbmRleCA4NGY4
MzI4MDYzMTMuLmEzNTA1NGY5ZDk0MSAxMDA2NDQKPiA+Pj4gLS0tIGEvZHJpdmVycy9uZXQvdHVu
LmMKPiA+Pj4gKysrIGIvZHJpdmVycy9uZXQvdHVuLmMKPiA+Pj4gQEAgLTI4MTIsNyArMjgxMiw3
IEBAIHN0YXRpYyBpbnQgc2V0X29mZmxvYWQoc3RydWN0IHR1bl9zdHJ1Y3QgKnR1biwgdW5zaWdu
ZWQgbG9uZyBhcmcpCj4gPj4+ICAgICAgICAgICAgICAgICAgICAgICAgYXJnICY9IH4oVFVOX0Zf
VFNPNHxUVU5fRl9UU082KTsKPiA+Pj4gICAgICAgICAgICAgICAgfQo+ID4+Pgo+ID4+PiAtICAg
ICAgICAgICAgIGFyZyAmPSB+VFVOX0ZfVUZPOwo+ID4+PiArICAgICAgICAgICAgIGFyZyAmPSB+
KFRVTl9GX1VGT3xUVU5fRl9VU08pOwo+ID4+Cj4gPj4gSXQgbG9va3MgdG8gbWUga2VybmVsIGRv
ZXNuJ3QgdXNlICJVU08iLCBzbyBUVU5fRl9VRFBfR1NPX0w0IGlzIGEgYmV0dGVyCj4gPj4gbmFt
ZSBmb3IgdGhpcwo+ID4gTm8gcHJvYmxlbSwgSSBjYW4gY2hhbmdlIGl0IGluIHYyCj4gPgo+ID4g
ICBhbmQgSSBndWVzcyB3ZSBzaG91bGQgdG9nZ2xlIE5FVElGX0ZfVURQX0dTT19sNCBoZXJlPwo+
ID4KPiA+IE5vLCB3ZSBkbyBub3QsIGJlY2F1c2UgdGhpcyBpbmRpY2F0ZXMgb25seSB0aGUgZmFj
dCB0aGF0IHRoZSBndWVzdCBjYW4KPiA+IHNlbmQgbGFyZ2UgVURQIHBhY2tldHMgYW5kIGhhdmUg
dGhlbSBzcGxpdHRlZCB0byBVRFAgc2VnbWVudHMuCj4KPgo+IEFjdHVhbGx5IHRoZSByZXZlcnNl
LiBUaGUgc2V0X29mZmxvYWQoKSBjb250cm9scyB0aGUgdHVudGFwIFRYIHBhdGgKPiAoZ3Vlc3Qg
UlggcGF0aCkuCgpUaGUgc2V0X29mZmxvYWRzIGRvZXMgMiB0aGluZ3M6CjEuIEF0IHRoZSBpbml0
aWFsaXphdGlvbiB0aW1lIHFlbXUgcHJvYmVzIHNldF9vZmZsb2FkKHNvbWV0aGluZykgdG8KY2hl
Y2sgd2hpY2ggZmVhdHVyZXMgYXJlIHN1cHBvcnRlZCBieSBUQVAvVFVOLgoyLiBMYXRlciBpdCBj
b25maWd1cmVzIHRoZSBndWVzdCBSWCBwYXRoIGFjY29yZGluZyB0byBndWVzdCdzIG5lZWRzL2Nh
cGFiaWxpdGllcwpUeXBpY2FsIGluaXRpYWxpemF0aW9uIHNlcXVlbmNlIGlzIChpbiBjYXNlIHRo
ZSBRRU1VIHN1cHBvcnRzIFVTTyBmZWF0dXJlKToKVEFQL1RVTiBzZXQgb2ZmbG9hZCAxMSAocHJv
YmUgZm9yIFVGTyBzdXBwb3J0KQpUQVAvVFVOIHNldCBvZmZsb2FkIDIxIChwcm9iZSBmb3IgVVNP
IHN1cHBvcnQpClRBUC9UVU4gc2V0IG9mZmxvYWQgMAouLi4KVEFQL1RVTiBzZXQgb2ZmbG9hZCA3
IChjb25maWd1cmF0aW9uIG9mIG9mZmxvYWRzIGFjY29yZGluZyB0byBHVUVTVCBmZWF0dXJlcykK
ClRoaXMgc2VyaWVzIG9mIHBhdGNoZXMgaXMgZm9yIFZJUlRJT19ORVRfRl9IT1NUX1VTTyBvbmx5
LCB2aXJ0aW8tbmV0CmZlYXR1cmVzIGxpa2UgVklSVElPX05FVF9GX0dVRVNUX1VTT18oNC82L3do
YXRldmVyKSBhcmUgbm90IGRlZmluZWQgaW4KdGhlIHNwZWMgeWV0LgoKPgo+IFdoZW4gVklSVElP
X05FVF9GX0dVRVNUX1hYWCB3YXMgbm90IG5lZ290aWF0ZWQsIHRoZSBjb3JyZXNwb25kaW5nIG5l
dGRldgo+IGZlYXR1cmVzIG5lZWRzIHRvIGJlIGRpc2FibGVkLiBXaGVuIGhvc3QgdHJpZXMgdG8g
c2VuZCB0aG9zZSBwYWNrZXRzIHRvCj4gZ3Vlc3QsIGl0IG5lZWRzIHRvIGRvIHNvZnR3YXJlIHNl
Z21lbnRhdGlvbi4KPgo+IFNlZSB2aXJ0aW9fbmV0X2FwcGx5X2d1ZXN0X29mZmxvYWRzKCkuCj4K
PiBUaGVyZSdzIGN1cnJlbnRseSBubyB3YXkgKG9yIG5vdCBuZWVkKSB0byBwcmV2ZW50IHR1bnRh
cCBmcm9tIHJlY2VpdmluZwo+IEdTTyBwYWNrZXRzLgo+Cj4gVGhhbmtzCj4KPgo+ID4KPiA+PiBB
bmQgaG93IGFib3V0IG1hY3Z0YXA/Cj4gPiBXZSB3aWxsIGNoZWNrIGhvdyB0byBkbyB0aGF0IGZv
ciBtYWN2dGFwLiBXZSB3aWxsIHNlbmQgYSBzZXBhcmF0ZQo+ID4gcGF0Y2ggZm9yIG1hY3Z0YXAg
b3IgYXNrIGZvciBhZHZpY2UuCj4gPgo+ID4+IFRoYW5rcwo+ID4+Cj4gPj4KPiA+Pj4gICAgICAg
IH0KPiA+Pj4KPiA+Pj4gICAgICAgIC8qIFRoaXMgZ2l2ZXMgdGhlIHVzZXIgYSB3YXkgdG8gdGVz
dCBmb3IgbmV3IGZlYXR1cmVzIGluIGZ1dHVyZSBieQo+Cl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
