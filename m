Return-Path: <SRS0=GMN+=KG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6166AC43460
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 08:12:35 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CF5B06192B
	for <virtualization@archiver.kernel.org>; Tue, 11 May 2021 08:12:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CF5B06192B
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=daynix.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 74FAA4059C;
	Tue, 11 May 2021 08:12:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7o_m8jjwXxtZ; Tue, 11 May 2021 08:12:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id F2702405F8;
	Tue, 11 May 2021 08:12:32 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CF721C000D;
	Tue, 11 May 2021 08:12:32 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8D8B1C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 08:12:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6E3EF405F8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 08:12:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id bk5ZLdtYXg_P
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 08:12:30 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ot1-x32f.google.com (mail-ot1-x32f.google.com
 [IPv6:2607:f8b0:4864:20::32f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 5F178405F7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 08:12:30 +0000 (UTC)
Received: by mail-ot1-x32f.google.com with SMTP id
 69-20020a9d0a4b0000b02902ed42f141e1so6634115otg.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 May 2021 01:12:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=daynix-com.20150623.gappssmtp.com; s=20150623;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=V4OvBsGlOboDMJilacIfX93BeArUzpCix7At3EOUarw=;
 b=lmkuZ7aDqLoygz/VlHzMEKZGrl/9XcMQTxU2tuT9mZhq0XTw/tD6YTyLFhazQMDYt9
 8zsBDzeJyVE1UpLyZiCRDTZVlbriSASCZMNryZutMDr0D8mzpX2ADN4ZeBdz4X3bHN0N
 WCNkGFc4CTnoBVv5uGBz3kfd6ybzBH+9lmTS8pokT0di2GHzk6YjGFIJcDXc5CcxCW7T
 nFKPhaBXRKMSlkC2NpFgBMsLmdcDWCyKtqzIWxh5lf2Epzpng2D79dYA/7zAsvWaHbge
 wNiOLhXNwKKOrSBYWgY0RzM/2pjxJqJJDxNHPuCWLsllM2LRf3Fzoi/svD1xstkjNrYg
 Q3Uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=V4OvBsGlOboDMJilacIfX93BeArUzpCix7At3EOUarw=;
 b=Kt0TF4ECkodX3dsWPYFZZqu7LZIwGLIJpdy2eKi0Jmaa5sdzOpPPozBd1QX52y7622
 qtE5dLT9z/e5EtKWD7jBbuJlGRvG6NDJ7JCy1fM2p8cCBXlOg92op/T29yZE2VmkOacS
 ZhxX+0pcCTdYlFTgU9Fo6pR+n7uNJZ8Uj4ngq923UrZXLdV5yuOxy0tOeF2HSs+Eo4sh
 G4tn66y43SPDjVY+VEpkUVWBxDrpb9T0uRg++8ubKF0mzv+4GRwYkj1MvTxbJy7Hmo6R
 DxnYSErm5LapvHtr4mPMPFpg8jjkZkDBDjFfxGh2IcsspZwPmzmZ0+SMS1vI1jRK/W1m
 5uJg==
X-Gm-Message-State: AOAM5305nVlnZfxdCCtEIQpD3S7LrHy3dGRKAeNoqW0ErmVftqqCkRa3
 QHYwPO/cBcDSTi1lTYLZr3G/TMO+y/uetj+I5eI2HQ==
X-Google-Smtp-Source: ABdhPJzjpKpzE2uIaT3SST5gktTqbv6RbiB2hBKWt6nVkBt9S62hZ5H6ZT0FqybWOJb5zIq+d0MrfyMVMdMmpOGfEjI=
X-Received: by 2002:a05:6830:4103:: with SMTP id
 w3mr20651835ott.27.1620720749398; 
 Tue, 11 May 2021 01:12:29 -0700 (PDT)
MIME-Version: 1.0
References: <20210511044253.469034-1-yuri.benditovich@daynix.com>
 <20210511044253.469034-2-yuri.benditovich@daynix.com>
 <40938c20-5851-089b-c3c0-074bbd636970@redhat.com>
In-Reply-To: <40938c20-5851-089b-c3c0-074bbd636970@redhat.com>
From: Yuri Benditovich <yuri.benditovich@daynix.com>
Date: Tue, 11 May 2021 11:12:16 +0300
Message-ID: <CAOEp5OdgYtP+W1thGsTGnvEPWrJ02s1HemskQpnMTUyYbsX4jQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] virtio-net: add definitions for host USO feature
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>, virtualization@lists.linux-foundation.org,
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

T24gVHVlLCBNYXkgMTEsIDIwMjEgYXQgOTo0NyBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPgo+Cj4g5ZyoIDIwMjEvNS8xMSDkuIvljYgxMjo0MiwgWXVyaSBCZW5k
aXRvdmljaCDlhpnpgZM6Cj4gPiBEZWZpbmUgZmVhdHVyZSBiaXQgYW5kIEdTTyB0eXBlIGFjY29y
ZGluZyB0byB0aGUgVklSVElPCj4gPiBzcGVjaWZpY2F0aW9uLgo+ID4KPiA+IFNpZ25lZC1vZmYt
Ynk6IFl1cmkgQmVuZGl0b3ZpY2ggPHl1cmkuYmVuZGl0b3ZpY2hAZGF5bml4LmNvbT4KPiA+IC0t
LQo+ID4gICBpbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX25ldC5oIHwgMiArKwo+ID4gICAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspCj4gPgo+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUv
dWFwaS9saW51eC92aXJ0aW9fbmV0LmggYi9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX25ldC5o
Cj4gPiBpbmRleCAzZjU1YTQyMTVmMTEuLmE1NTZhYzczNWQ3ZiAxMDA2NDQKPiA+IC0tLSBhL2lu
Y2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fbmV0LmgKPiA+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51
eC92aXJ0aW9fbmV0LmgKPiA+IEBAIC01Nyw2ICs1Nyw3IEBACj4gPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAqIFN0ZWVyaW5nICovCj4gPiAgICNkZWZpbmUgVklSVElP
X05FVF9GX0NUUkxfTUFDX0FERFIgMjMgICAgICAgLyogU2V0IE1BQyBhZGRyZXNzICovCj4gPgo+
ID4gKyNkZWZpbmUgVklSVElPX05FVF9GX0hPU1RfVVNPICAgICA1NiAvKiBIb3N0IGNhbiBoYW5k
bGUgVVNPIHBhY2tldHMgKi8KClRoaXMgaXMgdGhlIHZpcnRpby1uZXQgZmVhdHVyZQoKPiA+ICAg
I2RlZmluZSBWSVJUSU9fTkVUX0ZfSEFTSF9SRVBPUlQgIDU3ICAgICAgICAvKiBTdXBwb3J0cyBo
YXNoIHJlcG9ydCAqLwo+ID4gICAjZGVmaW5lIFZJUlRJT19ORVRfRl9SU1MgICAgICA2MCAgICAv
KiBTdXBwb3J0cyBSU1MgUlggc3RlZXJpbmcgKi8KPiA+ICAgI2RlZmluZSBWSVJUSU9fTkVUX0Zf
UlNDX0VYVCAgICAgICAgICA2MSAgICAvKiBleHRlbmRlZCBjb2FsZXNjaW5nIGluZm8gKi8KPiA+
IEBAIC0xMzAsNiArMTMxLDcgQEAgc3RydWN0IHZpcnRpb19uZXRfaGRyX3YxIHsKPiA+ICAgI2Rl
ZmluZSBWSVJUSU9fTkVUX0hEUl9HU09fVENQVjQgICAgMSAgICAgICAvKiBHU08gZnJhbWUsIElQ
djQgVENQIChUU08pICovCj4gPiAgICNkZWZpbmUgVklSVElPX05FVF9IRFJfR1NPX1VEUCAgICAg
ICAgICAgICAgMyAgICAgICAvKiBHU08gZnJhbWUsIElQdjQgVURQIChVRk8pICovCj4gPiAgICNk
ZWZpbmUgVklSVElPX05FVF9IRFJfR1NPX1RDUFY2ICAgIDQgICAgICAgLyogR1NPIGZyYW1lLCBJ
UHY2IFRDUCAqLwo+ID4gKyNkZWZpbmUgVklSVElPX05FVF9IRFJfR1NPX1VEUF9MNCAgICA1ICAg
ICAgIC8qIEdTTyBmcmFtZSwgSVB2NCBVRFAgKFVTTykgKi8KClRoaXMgaXMgcmVzcGVjdGl2ZSBH
U08gdHlwZQoKPgo+Cj4gVGhpcyBpcyB0aGUgZ3NvX3R5cGUgbm90IHRoZSBmZWF0dXJlIGFjdHVh
bGx5Lgo+Cj4gSSB3b25kZXIgd2hhdCdzIHRoZSByZWFzb24gZm9yIG5vdAo+Cj4gMSkgaW50cm9k
dWNpbmcgYSBkZWRpY2F0ZWQgdmlydGlvLW5ldCBmZWF0dXJlIGJpdCBmb3IgdGhpcwo+IChWSVJU
SU9fTkVUX0ZfR1VFU1RfR1NPX1VEUF9MNC4KClRoaXMgc2VyaWVzIGlzIG5vdCBmb3IgR1VFU1Qn
cyBmZWF0dXJlLCBpdCBpcyBvbmx5IGZvciBob3N0IGZlYXR1cmUuCgo+IDIpIHRvZ2dsZSB0aGUg
TkVUSUZfRl9HU09fVURQX0w0ICBmZWF0dXJlIGZvciB0dW50YXAgYmFzZWQgb24gdGhlCj4gbmVn
b3RpYXRlZCBmZWF0dXJlLgoKVGhlIE5FVElGX0ZfR1NPX1VEUF9MNCB3b3VsZCBiZSByZXF1aXJl
ZCBmb3IgdGhlIGd1ZXN0IFJYIHBhdGguClRoZSBndWVzdCBUWCBwYXRoIGRvZXMgbm90IHJlcXVp
cmUgYW55IGZsYWdzIHRvIGJlIHByb3BhZ2F0ZWQsIGl0IG9ubHkKYWxsb3dzIHRoZSBndWVzdCB0
byB0cmFuc21pdCBsYXJnZSBVRFAgcGFja2V0cyBhbmQgaGF2ZSB0aGVtCmF1dG9tYXRpY2FsbHkg
c3BsaXR0ZWQuCihUaGlzIGlzIHNpbWlsYXIgdG8gSE9TVF9VRk8gYnV0IGRvZXMgcGFja2V0IHNl
Z21lbnRhdGlvbiBpbnN0ZWFkIG9mCmZyYWdtZW50YXRpb24uIEdVRVNUX1VGTyBpbmRlZWQgcmVx
dWlyZXMgYSByZXNwZWN0aXZlIE5FVElGIGZsYWcsIGFzCml0IGlzIHVuY2xlYXIgd2hldGhlciB0
aGUgZ3Vlc3QgaXMgY2FwYWJsZSBvZiByZWNlaXZpbmcgc3VjaCBwYWNrZXRzKS4KCj4KPiBUaGFu
a3MKPgo+Cj4gPiAgICNkZWZpbmUgVklSVElPX05FVF9IRFJfR1NPX0VDTiAgICAgICAgICAgICAg
MHg4MCAgICAvKiBUQ1AgaGFzIEVDTiBzZXQgKi8KPiA+ICAgICAgIF9fdTggZ3NvX3R5cGU7Cj4g
PiAgICAgICBfX3ZpcnRpbzE2IGhkcl9sZW47ICAgICAvKiBFdGhlcm5ldCArIElQICsgdGNwL3Vk
cCBoZHJzICovCj4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
