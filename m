Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2F92C433FE
	for <virtualization@archiver.kernel.org>; Tue, 22 Feb 2022 13:28:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 88BFC60ED5;
	Tue, 22 Feb 2022 13:28:36 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nLo2qoQkuVTm; Tue, 22 Feb 2022 13:28:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 41DAF60BDF;
	Tue, 22 Feb 2022 13:28:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1D598C0021;
	Tue, 22 Feb 2022 13:28:35 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3565BC0011
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 13:28:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 31914401AF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 13:28:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=daynix-com.20210112.gappssmtp.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Y17n1WqHpgTn
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 13:28:33 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com
 [IPv6:2607:f8b0:4864:20::c2e])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 58E3240155
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 13:28:33 +0000 (UTC)
Received: by mail-oo1-xc2e.google.com with SMTP id
 p206-20020a4a2fd7000000b0031bfec11983so17429454oop.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Feb 2022 05:28:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20210112.gappssmtp.com; s=20210112;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=fzMBwP75WQQgoD+zNIkqsOij+cNlqusgTrcCGxZOev8=;
 b=1Zped++JnCEHwnYfX2O6NeRvtPl1uSLkpHL/XdtZ2BtbYPwwJKLZTLbyJROHatwydz
 X8mW2vKD0i+rNC4HrUcTvcYsWWw6efa5jJoeQakp3pssD3FSctKo035W5jiN1G6qy4TM
 khdg5QrtZju4yBQ6bIbP+/WIg5KLXZQNrbGr4pqTtwezw9lo/eWBWlQFblWgkObZ5iTE
 bDe40ygooFQ63R4MdfpeTOXMbNg3vxFFCCfROjlOepX7FuOVVOxE6c+RlLEcqbJ3KfD2
 dJXdAgvdvPM6SASeFThANPgHEhovlCXfhK4Ajh1nebgYhhM/CFwAXem8WB9YK/43yZZT
 8qUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=fzMBwP75WQQgoD+zNIkqsOij+cNlqusgTrcCGxZOev8=;
 b=YItubUlHpQtXUM29nzXAcdVWu7QXWtknOy9j3ylecIPVlIncVdCzljvP+pMvQIzZYl
 vv/z1KS69i1mSlIoiHE2f/is/eXpt5Qgfg/M9kwbEHABTBvx7t85FMJI90yrj2jlktw9
 zcnPfoA04LCod3dj45QiCc7+L0aUuVH+XmmvKOKqVqwaYbifmJCBkNaFVDI9RBUnkNMo
 XjLZM+DZU5aqbqjMfk4e4ITOgWw2bJvygqq0uEhc2gTifVrVgPv/U+1KQa4wU5/P4kb2
 cAYj3fyAQVtoypMZtVqjP2lGzw4QFe7A9Z0yTgvHMYouhT6IIK3/EamVxie+Tpir61so
 tdSw==
X-Gm-Message-State: AOAM531R7vCjX+VUKECqS7JjmsH1kqbwES34g03ZuhbzGzK1H4jwzGlb
 6xFnAaFFPIydTjQmPMLk3mSIOshCj/1bKYM/j9ExnA==
X-Google-Smtp-Source: ABdhPJzpBI0jL+29WueaOH07hF9lKt7ALfVIVHQ0laYJag6jVfXaNSqDIdsneAL5jOnrzJurx1xvKLrTy82D8UIjqTA=
X-Received: by 2002:a05:6870:aa85:b0:d2:e462:7371 with SMTP id
 gr5-20020a056870aa8500b000d2e4627371mr1550136oab.29.1645536512289; Tue, 22
 Feb 2022 05:28:32 -0800 (PST)
MIME-Version: 1.0
References: <20220125084702.3636253-1-andrew@daynix.com>
 <20220125084702.3636253-2-andrew@daynix.com>
 <06a90de0-57ae-9315-dc2c-03cc74b4ae0c@redhat.com>
In-Reply-To: <06a90de0-57ae-9315-dc2c-03cc74b4ae0c@redhat.com>
From: Andrew Melnichenko <andrew@daynix.com>
Date: Tue, 22 Feb 2022 15:28:21 +0200
Message-ID: <CABcq3pH7HnH_-nCHcX7eet_ouqocQEptp6A9GCbs3=9guArhPA@mail.gmail.com>
Subject: Re: [RFC PATCH 1/5] uapi/linux/if_tun.h: Added new ioctl for tun/tap.
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Yuri Benditovich <yuri.benditovich@daynix.com>,
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

SGkgYWxsLAoKT24gV2VkLCBGZWIgOSwgMjAyMiBhdCA2OjI2IEFNIEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4KPiDlnKggMjAyMi8xLzI1IOS4i+WNiDQ6NDYsIEFu
ZHJldyBNZWxueWNoZW5rbyDlhpnpgZM6Cj4gPiBBZGRlZCBUVU5HRVRTVVBQT1JURURPRkZMT0FE
UyB0aGF0IHNob3VsZCBhbGxvdwo+ID4gdG8gZ2V0IGJpdHMgb2Ygc3VwcG9ydGVkIG9mZmxvYWRz
Lgo+Cj4KPiBTbyB3ZSBkb24ndCB1c2UgZGVkaWNhdGVkIGlvY3RscyBpbiB0aGUgcGFzdCwgaW5z
dGVhZCwgd2UganVzdCBwcm9iaW5nCj4gYnkgY2hlY2tpbmcgdGhlIHJldHVybiB2YWx1ZSBvZiBU
VU5TRVRPRkZMT0FEUy4KPgo+IEUuZyBxZW11IGhhcyB0aGUgZm9sbG93aW5nIGNvZGVzOgo+Cj4g
aW50IHRhcF9wcm9iZV9oYXNfdWZvKGludCBmZCkKPiB7Cj4gICAgICB1bnNpZ25lZCBvZmZsb2Fk
Owo+Cj4gICAgICBvZmZsb2FkID0gVFVOX0ZfQ1NVTSB8IFRVTl9GX1VGTzsKPgo+ICAgICAgaWYg
KGlvY3RsKGZkLCBUVU5TRVRPRkZMT0FELCBvZmZsb2FkKSA8IDApCj4gICAgICAgICAgcmV0dXJu
IDA7Cj4KPiAgICAgIHJldHVybiAxOwo+IH0KPgo+IEFueSByZWFzb24gd2UgY2FuJ3Qga2VlcCB1
c2luZyB0aGF0Pwo+Cj4gVGhhbmtzCj4KCldlbGwsIGV2ZW4gaW4gdGhpcyBleGFtcGxlLiBUbyBj
aGVjayB0aGUgdWZvIGZlYXR1cmUsIHdlIHRyeWluZyB0byBzZXQgaXQuCldoYXQgaWYgd2UgZG9u
J3QgbmVlZCB0byAiZW5hYmxlIiBVRk8gYW5kL29yIGRvIG5vdCBjaGFuZ2UgaXRzIHN0YXRlPwpJ
IHRoaW5rIGl0J3MgYSBnb29kIGlkZWEgdG8gaGF2ZSB0aGUgYWJpbGl0eSB0byBnZXQgc3VwcG9y
dGVkIG9mZmxvYWRzCndpdGhvdXQgY2hhbmdpbmcgZGV2aWNlIGJlaGF2aW9yLgoKPgo+ID4gQWRk
ZWQgMiBhZGRpdGlvbmFsIG9mZmxsb2FkcyBmb3IgVVNPKElQdjQgJiBJUHY2KS4KPiA+IFNlcGFy
YXRlIG9mZmxvYWRzIGFyZSByZXF1aXJlZCBmb3IgV2luZG93cyBWTSBndWVzdHMsCj4gPiBnLmUu
IFdpbmRvd3MgbWF5IHNldCBVU08gcnggb25seSBmb3IgSVB2NC4KPiA+Cj4gPiBTaWduZWQtb2Zm
LWJ5OiBBbmRyZXcgTWVsbnljaGVua28gPGFuZHJld0BkYXluaXguY29tPgo+ID4gLS0tCj4gPiAg
IGluY2x1ZGUvdWFwaS9saW51eC9pZl90dW4uaCB8IDMgKysrCj4gPiAgIDEgZmlsZSBjaGFuZ2Vk
LCAzIGluc2VydGlvbnMoKykKPiA+Cj4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91YXBpL2xpbnV4
L2lmX3R1bi5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L2lmX3R1bi5oCj4gPiBpbmRleCA0NTRhZTMx
YjkzYzcuLjA3NjgwZmFlNmUxOCAxMDA2NDQKPiA+IC0tLSBhL2luY2x1ZGUvdWFwaS9saW51eC9p
Zl90dW4uaAo+ID4gKysrIGIvaW5jbHVkZS91YXBpL2xpbnV4L2lmX3R1bi5oCj4gPiBAQCAtNjEs
NiArNjEsNyBAQAo+ID4gICAjZGVmaW5lIFRVTlNFVEZJTFRFUkVCUEYgX0lPUignVCcsIDIyNSwg
aW50KQo+ID4gICAjZGVmaW5lIFRVTlNFVENBUlJJRVIgX0lPVygnVCcsIDIyNiwgaW50KQo+ID4g
ICAjZGVmaW5lIFRVTkdFVERFVk5FVE5TIF9JTygnVCcsIDIyNykKPiA+ICsjZGVmaW5lIFRVTkdF
VFNVUFBPUlRFRE9GRkxPQURTIF9JT1IoJ1QnLCAyMjgsIHVuc2lnbmVkIGludCkKPiA+Cj4gPiAg
IC8qIFRVTlNFVElGRiBpZnIgZmxhZ3MgKi8KPiA+ICAgI2RlZmluZSBJRkZfVFVOICAgICAgICAg
ICAgIDB4MDAwMQo+ID4gQEAgLTg4LDYgKzg5LDggQEAKPiA+ICAgI2RlZmluZSBUVU5fRl9UU082
ICAweDA0ICAgIC8qIEkgY2FuIGhhbmRsZSBUU08gZm9yIElQdjYgcGFja2V0cyAqLwo+ID4gICAj
ZGVmaW5lIFRVTl9GX1RTT19FQ04gICAgICAgMHgwOCAgICAvKiBJIGNhbiBoYW5kbGUgVFNPIHdp
dGggRUNOIGJpdHMuICovCj4gPiAgICNkZWZpbmUgVFVOX0ZfVUZPICAgMHgxMCAgICAvKiBJIGNh
biBoYW5kbGUgVUZPIHBhY2tldHMgKi8KPiA+ICsjZGVmaW5lIFRVTl9GX1VTTzQgICAweDIwICAg
IC8qIEkgY2FuIGhhbmRsZSBVU08gZm9yIElQdjQgcGFja2V0cyAqLwo+ID4gKyNkZWZpbmUgVFVO
X0ZfVVNPNiAgIDB4NDAgICAgLyogSSBjYW4gaGFuZGxlIFVTTyBmb3IgSVB2NiBwYWNrZXRzICov
Cj4gPgo+ID4gICAvKiBQcm90b2NvbCBpbmZvIHByZXBlbmRlZCB0byB0aGUgcGFja2V0cyAod2hl
biBJRkZfTk9fUEkgaXMgbm90IHNldCkgKi8KPiA+ICAgI2RlZmluZSBUVU5fUEtUX1NUUklQICAg
ICAgIDB4MDAwMQo+Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
