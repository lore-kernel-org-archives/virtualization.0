Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B70C4CD68ED
	for <virtualization@archiver.kernel.org>; Tue, 10 Oct 2023 06:43:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 5D6DB60F1C;
	Tue, 10 Oct 2023 06:43:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5D6DB60F1C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YBrS/t1A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8A7M5cjS7eyB; Tue, 10 Oct 2023 06:43:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id D9FFF60BD0;
	Tue, 10 Oct 2023 06:43:32 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D9FFF60BD0
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B3934C0039;
	Tue, 10 Oct 2023 06:43:32 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AE90CC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:43:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7C97660BE3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:43:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7C97660BE3
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zEBWhaRopEwk
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:43:30 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3A97F60BD0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Oct 2023 06:43:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3A97F60BD0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1696920209;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=rgqFndmcEt6MzJJYvVrxFvYY6SjDfTGKjVMZDwPlWWQ=;
 b=YBrS/t1AmlaGxi+SFUUXhnxSY4MC0FbPmOHmAE1ecQn9+bG3EozlPEQB+uVX7ZoN6KE1/S
 jS2K5hDjqRmWtvWVMWWXXLplgio5/bEQ25TCv0DZI6sg9yU/iu+KAoWt8oMC6FkYmlw9Mg
 6Vds1oZUb8LftGHNu1uX6A38Q3E/A9E=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-582-tGWj-WUHNo2vXww3JR3n4g-1; Tue, 10 Oct 2023 02:43:27 -0400
X-MC-Unique: tGWj-WUHNo2vXww3JR3n4g-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5043c463bf9so4921821e87.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Oct 2023 23:43:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1696920206; x=1697525006;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=rgqFndmcEt6MzJJYvVrxFvYY6SjDfTGKjVMZDwPlWWQ=;
 b=YXJDwdkhRCB5xECAawH4eQoEFETjsG0xnEv766g34+2Zuc0jVUxGhHro2PVGVB5yKU
 01oXl5rS9X+xbiq8yZQUmaHUzQ4MwEKK5r1Yyzv6RSeKFzijRiAaroxAZQN28Yalr5pV
 BLt2ZeVy6L42ufla5O6UTQ8GuNfwHq4PK45IE0t+dQ4TRzwY9HDFoX/0osCxA/r1WzMm
 K5IzRNP23SUT6QLlr2detKa/aLzDtFFGS53Xey0Sg63S3qk7OhfdmqBzWyDcI/JTle/a
 Xw0Q4NmK5KzVhfSs6HgArYtSKbwReaeYbelGkqxySiuGmUqXK0789FLNd3HjIXCsAaN8
 QrSA==
X-Gm-Message-State: AOJu0YzeVYGi5gA8qRJbLNZPKySosV98C4cRax7EN76yW4TV+CekIuNm
 0HN6QMhDRFIiTzQCG5PCz3eQANg5+TSrJWGR36xcwSNTAsclbXc/sb24tbNQaq2VA/5LQen8/WR
 3Qqw+PvFZIgfyAjMf7ybTbvRfY/p3+fZIaHI2TMhznW2CZkRmdVAyo6RJlg==
X-Received: by 2002:a05:6512:e9a:b0:505:6ede:20a9 with SMTP id
 bi26-20020a0565120e9a00b005056ede20a9mr17120595lfb.65.1696920206288; 
 Mon, 09 Oct 2023 23:43:26 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEI/b1r5F7mWe6LfWM+gxhuQQneYj15oSPNiNgYcotFwF8+SfLUXN8TrhCigG6UD4CTCXYbA+JE24frJ8i4r0U=
X-Received: by 2002:a05:6512:e9a:b0:505:6ede:20a9 with SMTP id
 bi26-20020a0565120e9a00b005056ede20a9mr17120581lfb.65.1696920205963; Mon, 09
 Oct 2023 23:43:25 -0700 (PDT)
MIME-Version: 1.0
References: <20231010031120.81272-1-xuanzhuo@linux.alibaba.com>
 <20231010031120.81272-2-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20231010031120.81272-2-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 10 Oct 2023 14:43:15 +0800
Message-ID: <CACGkMEsdic35HQqfhGWkqMo37JFLv_ZRCFbVZj22_0poGAz2xg@mail.gmail.com>
Subject: Re: [PATCH vhost v3 1/4] virtio: add definition of
 VIRTIO_F_NOTIF_CONFIG_DATA feature bit
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
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

T24gVHVlLCBPY3QgMTAsIDIwMjMgYXQgMTE6MTHigK9BTSBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IFRoaXMgcGF0Y2ggYWRkcyB0aGUgZGVmaW5pdGlv
biBvZiBWSVJUSU9fRl9OT1RJRl9DT05GSUdfREFUQSBmZWF0dXJlIGJpdAo+IGluIHRoZSByZWxl
dmFudCBoZWFkZXIgZmlsZS4KPgo+IFRoaXMgZmVhdHVyZSBpbmRpY2F0ZXMgdGhhdCB0aGUgZHJp
dmVyIHVzZXMgdGhlIGRhdGEgcHJvdmlkZWQgYnkgdGhlCj4gZGV2aWNlIGFzIGEgdmlydHF1ZXVl
IGlkZW50aWZpZXIgaW4gYXZhaWxhYmxlIGJ1ZmZlciBub3RpZmljYXRpb25zLgo+Cj4gSXQgY29t
ZXMgZnJvbSBoZXJlOgo+ICAgICBodHRwczovL2dpdGh1Yi5jb20vb2FzaXMtdGNzL3ZpcnRpby1z
cGVjL2lzc3Vlcy84OQo+Cj4gU2lnbmVkLW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51
eC5hbGliYWJhLmNvbT4KCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29t
PgoKVGhhbmtzCgo+IC0tLQo+ICBpbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX2NvbmZpZy5oIHwg
NSArKysrKwo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspCj4KPiBkaWZmIC0tZ2l0
IGEvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19jb25maWcuaCBiL2luY2x1ZGUvdWFwaS9saW51
eC92aXJ0aW9fY29uZmlnLmgKPiBpbmRleCAyYzcxMmM2NTQxNjUuLjg4ODFhZWE2MGY2ZiAxMDA2
NDQKPiAtLS0gYS9pbmNsdWRlL3VhcGkvbGludXgvdmlydGlvX2NvbmZpZy5oCj4gKysrIGIvaW5j
bHVkZS91YXBpL2xpbnV4L3ZpcnRpb19jb25maWcuaAo+IEBAIC0xMDUsNiArMTA1LDExIEBACj4g
ICAqLwo+ICAjZGVmaW5lIFZJUlRJT19GX05PVElGSUNBVElPTl9EQVRBICAgICAzOAo+Cj4gKy8q
IFRoaXMgZmVhdHVyZSBpbmRpY2F0ZXMgdGhhdCB0aGUgZHJpdmVyIHVzZXMgdGhlIGRhdGEgcHJv
dmlkZWQgYnkgdGhlIGRldmljZQo+ICsgKiBhcyBhIHZpcnRxdWV1ZSBpZGVudGlmaWVyIGluIGF2
YWlsYWJsZSBidWZmZXIgbm90aWZpY2F0aW9ucy4KPiArICovCj4gKyNkZWZpbmUgVklSVElPX0Zf
Tk9USUZfQ09ORklHX0RBVEEgICAgIDM5Cj4gKwo+ICAvKgo+ICAgKiBUaGlzIGZlYXR1cmUgaW5k
aWNhdGVzIHRoYXQgdGhlIGRyaXZlciBjYW4gcmVzZXQgYSBxdWV1ZSBpbmRpdmlkdWFsbHkuCj4g
ICAqLwo+IC0tCj4gMi4zMi4wLjMuZzAxMTk1Y2Y5Zgo+CgpfX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmly
dHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51
eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
