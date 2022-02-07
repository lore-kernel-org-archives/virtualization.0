Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 242D6C433F5
	for <virtualization@archiver.kernel.org>; Mon,  7 Feb 2022 08:06:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id AF747400E5;
	Mon,  7 Feb 2022 08:06:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zeb973ji6jln; Mon,  7 Feb 2022 08:06:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1F23C400D8;
	Mon,  7 Feb 2022 08:06:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E5400C001A;
	Mon,  7 Feb 2022 08:06:35 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DA33CC000B
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 08:06:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id C13C781390
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 08:06:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yNONibg1qmAI
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 08:06:33 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D17718138E
 for <virtualization@lists.linux-foundation.org>;
 Mon,  7 Feb 2022 08:06:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644221191;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hrBG/poLkL/lLZ3kXUYigUvYKKxYkaMg+jNVui/yCn4=;
 b=Xzs8hhaAzUt2ulos3uGtMfvwZz0j6o7DDdFe86h7zwZKZQKYiBy3ei8rFnrKJfnghByeR3
 CUHUtpW3wTF2FAzJbXTE7V5C0/VGGcCTAPsw1+9ScMFF9vQ0PhHBpv16VOOyy24pU+Da9u
 niT9b7N/VkBhhYhxQTyNSSFX3THJLaE=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-22-L1I3mEbmPqiSGq6WaJ3EYQ-1; Mon, 07 Feb 2022 03:06:27 -0500
X-MC-Unique: L1I3mEbmPqiSGq6WaJ3EYQ-1
Received: by mail-lj1-f199.google.com with SMTP id
 a13-20020a2eb54d000000b0023f5f64ae4fso4115094ljn.4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 07 Feb 2022 00:06:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=hrBG/poLkL/lLZ3kXUYigUvYKKxYkaMg+jNVui/yCn4=;
 b=LZbhH6o3Uj48uPW6aHW2GD2oLz39d1dN2UiltaVSf6qgXPo+3TA+VwTqwcEz+7dtcq
 UfCKQEl30ugzWXxQBVkMNAxdGK1hxTiqwRSw/6Isd1SqF1ETrGjq6ZipwrxlRBE4utfi
 vGVBbq9B4d/EJ4PVfijZkQhb5inz+uNrqzpqbgB4MRrDuXqpSAwaapAjQAT7g1DQqxbS
 JciDKh1AAhzt2EFSO1cMp7VirnJw13hH5RHyscPO7FkTHK4WyqMWFJnAa3PntEzfnwqj
 0SpfuYWLLmctk2yLws1sEcP/FGJMM1YreCS95YcY8geikclXvYL3T6l9suyVf+q0Xaky
 ZjPQ==
X-Gm-Message-State: AOAM532TgpET990HOVu2rGKOkIDog2ye+JPjA4FRVzrY7b0fLpuf4ibg
 1TQbo4VaYj2nArE0bwqk1fH3XpnbeTJTLFMD7c+dVb1XONVvPCqNLZG/t8XnE8E2cKi0G8/enci
 kFhuUSVkJUOFHP81e+KvF6xodeIo8BWQjAyjKEluvDZfY71V7M7Ae5Haetw==
X-Received: by 2002:a05:6512:e9c:: with SMTP id
 bi28mr6687391lfb.498.1644221186161; 
 Mon, 07 Feb 2022 00:06:26 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw0DHyEmoITa1BBraG4UZnw98YqyHS8LEhTKBkLYYBW2asYSlz9ovqB44ewRvgt48bhRU26fe8jVPKrnUet8ao=
X-Received: by 2002:a05:6512:e9c:: with SMTP id
 bi28mr6687376lfb.498.1644221185952; 
 Mon, 07 Feb 2022 00:06:25 -0800 (PST)
MIME-Version: 1.0
References: <28013a95-4ce4-7859-9ca1-d836265e8792@redhat.com>
 <1644213876.065673-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1644213876.065673-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 7 Feb 2022 16:06:15 +0800
Message-ID: <CACGkMEuJ_v5g2ypLZ3eNhAcUM9Q3PpWuiaeWVfEC6KACGzWAZw@mail.gmail.com>
Subject: Re: [PATCH v3 01/17] virtio_pci: struct virtio_pci_common_cfg add
 queue_notify_data
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev <netdev@vger.kernel.org>, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Jakub Kicinski <kuba@kernel.org>, bpf@vger.kernel.org,
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

T24gTW9uLCBGZWIgNywgMjAyMiBhdCAyOjA3IFBNIFh1YW4gWmh1byA8eHVhbnpodW9AbGludXgu
YWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gT24gTW9uLCA3IEZlYiAyMDIyIDExOjQxOjA2ICswODAw
LCBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPiB3cm90ZToKPiA+Cj4gPiDlnKggMjAy
Mi8xLzI2IOS4i+WNiDM6MzUsIFh1YW4gWmh1byDlhpnpgZM6Cj4gPiA+IEFkZCBxdWV1ZV9ub3Rp
ZnlfZGF0YSBpbiBzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25fY2ZnLCB3aGljaCBjb21lcyBmcm9t
Cj4gPiA+IGhlcmUgaHR0cHM6Ly9naXRodWIuY29tL29hc2lzLXRjcy92aXJ0aW8tc3BlYy9pc3N1
ZXMvODkKPiA+ID4KPiA+ID4gU2luY2UgSSB3YW50IHRvIGFkZCBxdWV1ZV9yZXNldCBhZnRlciBp
dCwgSSBzdWJtaXR0ZWQgdGhpcyBwYXRjaCBmaXJzdC4KPiA+ID4KPiA+ID4gU2lnbmVkLW9mZi1i
eTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiA+ID4gLS0tCj4gPiA+
ICAgaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19wY2kuaCB8IDEgKwo+ID4gPiAgIDEgZmlsZSBj
aGFuZ2VkLCAxIGluc2VydGlvbigrKQo+ID4gPgo+ID4gPiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS91
YXBpL2xpbnV4L3ZpcnRpb19wY2kuaCBiL2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNpLmgK
PiA+ID4gaW5kZXggM2E4NmYzNmQ3ZTNkLi40OTJjODlmNTZjNmEgMTAwNjQ0Cj4gPiA+IC0tLSBh
L2luY2x1ZGUvdWFwaS9saW51eC92aXJ0aW9fcGNpLmgKPiA+ID4gKysrIGIvaW5jbHVkZS91YXBp
L2xpbnV4L3ZpcnRpb19wY2kuaAo+ID4gPiBAQCAtMTY0LDYgKzE2NCw3IEBAIHN0cnVjdCB2aXJ0
aW9fcGNpX2NvbW1vbl9jZmcgewo+ID4gPiAgICAgX19sZTMyIHF1ZXVlX2F2YWlsX2hpOyAgICAg
ICAgICAvKiByZWFkLXdyaXRlICovCj4gPiA+ICAgICBfX2xlMzIgcXVldWVfdXNlZF9sbzsgICAg
ICAgICAgIC8qIHJlYWQtd3JpdGUgKi8KPiA+ID4gICAgIF9fbGUzMiBxdWV1ZV91c2VkX2hpOyAg
ICAgICAgICAgLyogcmVhZC13cml0ZSAqLwo+ID4gPiArICAgX19sZTE2IHF1ZXVlX25vdGlmeV9k
YXRhOyAgICAgICAvKiByZWFkLXdyaXRlICovCj4gPiA+ICAgfTsKPiA+Cj4gPgo+ID4gU28gSSBo
YWQgdGhlIHNhbWUgY29uY2VybiBhcyBwcmV2aW91cyB2ZXJzaW9uLgo+ID4KPiA+IFRoaXMgYnJl
YWtzIHVBQkkgd2hlcmUgcHJvZ3JhbSBtYXkgdHJ5IHRvIHVzZSBzaXplb2Yoc3RydWN0Cj4gPiB2
aXJ0aW9fcGNpX2NvbW1vbl9jZmcpLgo+ID4KPiA+IFdlIHByb2JhYmx5IG5lZWQgYSBjb250YWlu
ZXIgc3RydWN0dXJlIGhlcmUuCj4KPiBJIHNlZSwgSSBwbGFuIHRvIGFkZCBhIHN0cnVjdCBsaWtl
IHRoaXMsIGRvIHlvdSB0aGluayBpdCdzIGFwcHJvcHJpYXRlPwo+Cj4gc3RydWN0IHZpcnRpb19w
Y2lfY29tbW9uX2NmZ192MSB7Cj4gICAgICAgICBzdHJ1Y3QgdmlydGlvX3BjaV9jb21tb25fY2Zn
IGNmZzsKPiAgICAgICAgIF9fbGUxNiBxdWV1ZV9ub3RpZnlfZGF0YTsgICAgICAgLyogcmVhZC13
cml0ZSAqLwo+IH0KClNvbWV0aGluZyBsaWtlIHRoaXMgYnV0IHdlIHByb2JhYmx5IG5lZWQgYSBi
ZXR0ZXIgbmFtZS4KClRoYW5rcwoKPgo+IFRoYW5rcy4KPgo+ID4KPiA+IFRIYW5rcwo+ID4KPiA+
Cj4gPiA+Cj4gPiA+ICAgLyogRmllbGRzIGluIFZJUlRJT19QQ0lfQ0FQX1BDSV9DRkc6ICovCj4g
Pgo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
