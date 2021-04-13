Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 93E42C43460
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 14:09:20 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 30D646128C
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 14:09:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 30D646128C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E085260709;
	Tue, 13 Apr 2021 14:09:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5iXNo4fClQcw; Tue, 13 Apr 2021 14:09:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id 4A463605FE;
	Tue, 13 Apr 2021 14:09:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2720FC000C;
	Tue, 13 Apr 2021 14:09:18 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3E2B9C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:09:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2C51840300
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:09:17 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=gmail.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Kfga7LPKSv_C
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:09:16 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com
 [IPv6:2a00:1450:4864:20::52f])
 by smtp4.osuosl.org (Postfix) with ESMTPS id C0183402C9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 14:09:15 +0000 (UTC)
Received: by mail-ed1-x52f.google.com with SMTP id h10so19541252edt.13
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 07:09:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=5CizpbO31FtejMNYjXuvc8L275/b2XFa53SLVJcUKq0=;
 b=d7rHSyX5FYqvYlUwaaFx6Cem28DMQMUp8Wv0FRZ9jb0O8CwlLq01rbCgyEQxp7Gs30
 lKPsSc8nvZeDxcR0U+wzjIqCeG2udUGUvSL4Qh/O0Zwq28I1bh2gdzZFrqe9d3072Qdj
 Q3URSx5mp2RCWFS0xm67XKNz8HjPomZ75ooaa9No/dlBf14Q53mxMbQ8Lhdso/91oPqw
 kM21HVpgFwLl7ZiMlaTP7ouOzx49Imb8zIalR/JaD4KAHedjiAI5P9xQp0um2fX8Yq/E
 9ysXejvNssC6iiF5ReY9A/m0mfi3FvuqBM9W4/QtLkVFMwqcwysapMh1n6YotvsA5udo
 PykQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=5CizpbO31FtejMNYjXuvc8L275/b2XFa53SLVJcUKq0=;
 b=XYBwo9IQzgCM5J+zk6JxB5Bdnp9jwtwpgHRKYIYKiTSVZHiBT2dJMz+EIThf5idwcH
 gd+GrCxfHEAy1i1oi6/9hYaioB3oPrH1g/iGJSzjsdveLCsgLt46g1d5gHQyoHHsyS+c
 e1VkpT6GJrjf4pbXqnwQKZ0S/UnrsveLmsGM0O+JgUovHaf/2vs4415OnE7aCBh2bPIv
 KqqlmB5k9Om8A7laAQLw9xn9S5c8kFDJouOY/nMPbokeGnzupvIf3LaWjUpyg+5teEiD
 52FkAafe/Lum6s70zUwp5Dj4OAh0egcRVMCJD8cbDV1bWfLAYPx/0zrd6vyohLoTujm3
 Qarw==
X-Gm-Message-State: AOAM5312J1S8urS2rm96ZPfmcCVHyeqvdODBwQQoDYac0q6EG+xuRFyr
 VnsiQv15voJydwef5yYPshLDsuS5wjleXQ==
X-Google-Smtp-Source: ABdhPJzoWBPWj3xoRGrtT3uHn6BK0/WRDvRQ5BViIA8v6xU49yOZHBJgJfjw1JAPJ6cRv25K+K1e3g==
X-Received: by 2002:aa7:c7c5:: with SMTP id o5mr34672209eds.31.1618322953645; 
 Tue, 13 Apr 2021 07:09:13 -0700 (PDT)
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com.
 [209.85.221.48])
 by smtp.gmail.com with ESMTPSA id t15sm10313958edw.84.2021.04.13.07.09.12
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 13 Apr 2021 07:09:13 -0700 (PDT)
Received: by mail-wr1-f48.google.com with SMTP id m9so3881011wrx.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 07:09:12 -0700 (PDT)
X-Received: by 2002:a5d:510d:: with SMTP id s13mr37397046wrt.12.1618322952421; 
 Tue, 13 Apr 2021 07:09:12 -0700 (PDT)
MIME-Version: 1.0
References: <20210413054733.36363-1-mst@redhat.com>
 <20210413054733.36363-3-mst@redhat.com>
 <43db5c1e-9908-55bb-6d1a-c6c8d71e2315@redhat.com>
In-Reply-To: <43db5c1e-9908-55bb-6d1a-c6c8d71e2315@redhat.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 13 Apr 2021 10:08:34 -0400
X-Gmail-Original-Message-ID: <CA+FuTSdt6udHb7V4Xcj=OQ3M-iRazgOMWJinCbLJyof=ttB=Cw@mail.gmail.com>
Message-ID: <CA+FuTSdt6udHb7V4Xcj=OQ3M-iRazgOMWJinCbLJyof=ttB=Cw@mail.gmail.com>
Subject: Re: [PATCH RFC v2 2/4] virtio_net: disable cb aggressively
To: Jason Wang <jasowang@redhat.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Jakub Kicinski <kuba@kernel.org>,
 Wei Wang <weiwan@google.com>, David Miller <davem@davemloft.net>
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

T24gVHVlLCBBcHIgMTMsIDIwMjEgYXQgNDo1MyBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPgo+Cj4g5ZyoIDIwMjEvNC8xMyDkuIvljYgxOjQ3LCBNaWNoYWVsIFMu
IFRzaXJraW4g5YaZ6YGTOgo+ID4gVGhlcmUgYXJlIGN1cnJlbnRseSB0d28gY2FzZXMgd2hlcmUg
d2UgcG9sbCBUWCB2cSBub3QgaW4gcmVzcG9uc2UgdG8gYQo+ID4gY2FsbGJhY2s6IHN0YXJ0IHht
aXQgYW5kIHJ4IG5hcGkuICBXZSBjdXJyZW50bHkgZG8gdGhpcyB3aXRoIGNhbGxiYWNrcwo+ID4g
ZW5hYmxlZCB3aGljaCBjYW4gY2F1c2UgZXh0cmEgaW50ZXJydXB0cyBmcm9tIHRoZSBjYXJkLiAg
VXNlZCBub3QgdG8gYmUKPiA+IGEgYmlnIGlzc3VlIGFzIHdlIHJ1biB3aXRoIGludGVycnVwdHMg
ZGlzYWJsZWQgYnV0IHRoYXQgaXMgbm8gbG9uZ2VyIHRoZQo+ID4gY2FzZSwgYW5kIGluIHNvbWUg
Y2FzZXMgdGhlIHJhdGUgb2Ygc3B1cmlvdXMgaW50ZXJydXB0cyBpcyBzbyBoaWdoCj4gPiBsaW51
eCBkZXRlY3RzIHRoaXMgYW5kIGFjdHVhbGx5IGtpbGxzIHRoZSBpbnRlcnJ1cHQuCj4gPgo+ID4g
Rml4IHVwIGJ5IGRpc2FibGluZyB0aGUgY2FsbGJhY2tzIGJlZm9yZSBwb2xsaW5nIHRoZSB0eCB2
cS4KPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEByZWRoYXQu
Y29tPgo+ID4gLS0tCj4gPiAgIGRyaXZlcnMvbmV0L3ZpcnRpb19uZXQuYyB8IDIgKysKPiA+ICAg
MSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQo+ID4KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC92aXJ0aW9fbmV0LmMgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+IGluZGV4
IDgyZTUyMGQyY2IxMi4uMTZkNWFiZWQ1ODJjIDEwMDY0NAo+ID4gLS0tIGEvZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jCj4gPiArKysgYi9kcml2ZXJzL25ldC92aXJ0aW9fbmV0LmMKPiA+IEBAIC0x
NDI5LDYgKzE0MjksNyBAQCBzdGF0aWMgdm9pZCB2aXJ0bmV0X3BvbGxfY2xlYW50eChzdHJ1Y3Qg
cmVjZWl2ZV9xdWV1ZSAqcnEpCj4gPiAgICAgICAgICAgICAgIHJldHVybjsKPiA+Cj4gPiAgICAg
ICBpZiAoX19uZXRpZl90eF90cnlsb2NrKHR4cSkpIHsKPiA+ICsgICAgICAgICAgICAgdmlydHF1
ZXVlX2Rpc2FibGVfY2Ioc3EtPnZxKTsKPiA+ICAgICAgICAgICAgICAgZnJlZV9vbGRfeG1pdF9z
a2JzKHNxLCB0cnVlKTsKPiA+ICAgICAgICAgICAgICAgX19uZXRpZl90eF91bmxvY2sodHhxKTsK
Pgo+Cj4gQW55IHJlYXNvbiB0aGF0IHdlIGRvbid0IG5lZWQgdG8gZW5hYmxlIHRoZSBjYiBoZXJl
PwoKVGhpcyBpcyBhbiBvcHBvcnR1bmlzdGljIGNsZWFuIG91dHNpZGUgdGhlIG5vcm1hbCB0eC1u
YXBpIHBhdGgsIHNvIGlmCmRpc2FibGluZyB0aGUgdHggaW50ZXJydXB0IGhlcmUsIGl0IHdvbid0
IGJlIHJlZW5hYmxlZCBiYXNlZCBvbgpuYXBpX2NvbXBsZXRlX2RvbmUuCgpJIHRoaW5rIHRoYXQg
bWVhbnMgdGhhdCBpdCBzdGF5cyBkaXNhYmxlZCB1bnRpbCB0aGUgZm9sbG93aW5nIHN0YXJ0X3ht
aXQ6CgogICAgICAgIGlmICh1c2VfbmFwaSAmJiBraWNrKQogICAgICAgICAgICAgICAgdmlydHF1
ZXVlX2VuYWJsZV9jYl9kZWxheWVkKHNxLT52cSk7CgpCdXQgdGhhdCBzZWVtcyBzdWZmaWNpZW50
LgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
