Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 818CEC7619A
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 04:55:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0B713405F5;
	Tue, 11 Apr 2023 04:55:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0B713405F5
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=AV4wEfiM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PJAPjKurZoCc; Tue, 11 Apr 2023 04:55:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 73FF2403F9;
	Tue, 11 Apr 2023 04:55:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 73FF2403F9
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 45EB4C0037;
	Tue, 11 Apr 2023 04:55:03 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C7450C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 04:55:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 92C4940AB9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 04:55:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 92C4940AB9
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=AV4wEfiM
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QbVaOH9eOwZo
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 04:55:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 95494409F8
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 95494409F8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 04:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681188899;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=VVKgFauILXojCNyHwbx7DHYoDeMpXPkI61+mfkX4un4=;
 b=AV4wEfiMnq/DeSp76ya1SgZm5jvRQPqAEDQ+wDLROM7A5wPD4J6svq3DpH4/nW9wSc6RPu
 bJxrtQ5VrhXo4G1SXrQKHmF1lVtZ2dviC8xvqZHLwATHdU4n4swGiPeRUHnstamfX0E5p1
 NN0xNPyPa+bwCbD0iXaLjKRju8RBtBk=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-220-hwEG_XG8PVKaohoQwgqmXQ-1; Tue, 11 Apr 2023 00:54:58 -0400
X-MC-Unique: hwEG_XG8PVKaohoQwgqmXQ-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-1842ccf7ae4so4096045fac.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Apr 2023 21:54:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681188897; x=1683780897;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=VVKgFauILXojCNyHwbx7DHYoDeMpXPkI61+mfkX4un4=;
 b=v5T0PmTebYn9kVfXpOkm6m3cY/i7zsEZ+v8R20xzn3blHirW8Qx7o9p1jxUWNfVkXY
 Xvha2kOeqixR4CUfG88k1zgbMNe87uXEp0h+Uk+xtsLwRkTKzjq1nlTbwcW5ZLfu6RVd
 B7ZC9zapijbAkRP47J+lcpuvMKceK6774pv8r06fXLPp9ZdJl58EC8uXNXmM+phNFDk0
 TnhNjmQg2lIsWGN21Kt00KQf5OkUQaqftJQkM5jnE5l5EnVAaYrEYea+MXkpGiy5jwGF
 +UQN8xqlEQWSz/wfm39xulFZ1QEUbjQJdBw1qGxietPnMfjtu8OlOt1Zfc9nknbYFsmt
 a0Sg==
X-Gm-Message-State: AAQBX9dFgcoyO9UIIoBnKLG4CPToV9jr2jyTMOu88FOBcxa8fahpR9um
 5esfEMnrBjVmkdQdpbWqVzHcPDDHb5cigspOdZoZohkuoLdJ2ICgDBBwTbUZFm3GOVp/AvLubMm
 jMNI6D/ey9E5Ks9P1/Ov3DFr+jCa9MQNtlL4kCZVh4xnXS2Rxpc52jTvZTg==
X-Received: by 2002:a05:6808:1245:b0:37f:a2ad:6718 with SMTP id
 o5-20020a056808124500b0037fa2ad6718mr7320428oiv.3.1681188897365; 
 Mon, 10 Apr 2023 21:54:57 -0700 (PDT)
X-Google-Smtp-Source: AKy350bl7bGi1XW6+swPCM3lVI+ZYciWq4Qhct5eCiGtdv+PDa8MkFYxchfCwJKdIkxtDQGG3X8m/WV5RnZvIh2lKk8=
X-Received: by 2002:a05:6808:1245:b0:37f:a2ad:6718 with SMTP id
 o5-20020a056808124500b0037fa2ad6718mr7320426oiv.3.1681188897192; Mon, 10 Apr
 2023 21:54:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230327040536.48338-9-xuanzhuo@linux.alibaba.com>
 <73a24f95-b779-44ac-be28-45b35d1bf540@roeck-us.net>
 <20230407064634-mutt-send-email-mst@kernel.org>
 <1681097397.338332-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEvLLbGTuF1sVSse1RBssvsTR40+P5eBzYkrYnqF7EO3Jw@mail.gmail.com>
 <ZDQq0pDVkr8TvoTM@infradead.org>
 <1681178179.2350223-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEskNEwD0_AZgoDLS2RBv9cpbH5u1q01=cDuawV0NbhK_w@mail.gmail.com>
 <ZDTUn6TUqzrF06mr@infradead.org>
 <CACGkMEtD0BLBXv7S-TLY-Y483_Lx4UskLyPmEC2wyGa8VE_R6w@mail.gmail.com>
 <ZDTdk0K6LO5+0OLA@infradead.org>
In-Reply-To: <ZDTdk0K6LO5+0OLA@infradead.org>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Apr 2023 12:54:46 +0800
Message-ID: <CACGkMEuZss7m+qC2V+QjMJD3W1JdYAoQs6Amn1WXHYZBrJRUjg@mail.gmail.com>
Subject: Re: [PATCH vhost v6 08/11] virtio_ring: introduce virtqueue_dma_dev()
To: Christoph Hellwig <hch@infradead.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org, Guenter Roeck <linux@roeck-us.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

T24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMTI6MTDigK9QTSBDaHJpc3RvcGggSGVsbHdpZyA8aGNo
QGluZnJhZGVhZC5vcmc+IHdyb3RlOgo+Cj4gT24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMTE6NTY6
NDdBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gVGhlIERNQSBkZXZpY2UgZm9yIHZp
cnRpb19wY2kgaXMgdGhlIHVuZGVybHlpbmcgUENJIGRldmljZSwgYWx3YXlzLgo+ID4gPiAhVklS
VElPX0ZfQUNDRVNTX1BMQVRGT1JNIG1lYW5zIHRoZXJlIGlzIG5vIGRtYSBkZXZpY2UgYXQgYWxs
LiAgQmVjYXVzZQo+ID4gPiBvZiBhbGwgdGhlc2UgdGhpbmdzIHlvdSBjYW4ndCBqdXN0IGV4cG9z
ZSBhIHBvaW50ZXIgdG8gdGhlIGRtYV9kZXZpY2UKPiA+ID4gYXMgdGhhdCBpcyBqdXN0IGEgY29t
cGxldGVseSB3cm9uZyB3YXkgb2YgdGhpbmtpbmcgYWJvdXQgdGhlIHByb2JsZW0uCj4gPgo+ID4g
T2ssIHNvIGlmIHRoZXJlJ3Mgbm8gRE1BIGF0IGFsbCB3ZSBzaG91bGQgYXZvaWQgdXNpbmcgdGhl
IERNQSBBUEkKPiA+IGNvbXBsZXRlbHkuIFRoaXMgbWVhbnMgd2Ugc2hvdWxkIGNoZWNrIGRtYV9k
ZXYgYWdhaW5zdCBOVUxMIGluCj4gPiB2aXJ0aW9faGFzX2RtYV9xdWlyaygpLgo+Cj4gTm8gbmVl
IHRvIGFkZCBhIGNoZWNrIHRvIHZpcnRpb19oYXNfZG1hX3F1aXJrLgoKT2ssIGp1c3QgdG8gY2xh
cmlmeSwgSSBtZWFudCB0aGVyZSBjb3VsZCBiZSBhIGNhc2Ugd2hlcmUgdGhlIHZpcnRxdWV1ZQpp
cyBlbXVsYXRlZCBieSBzb2Z0d2FyZSwgaW4gdGhpcyBjYXNlIHdlIG5lZWQgY2hlY2sgd2hldGhl
ciB0aGUKdmlydHF1ZXVlIGhhcyBhIGRtYSBkZXZpY2Ugb3Igbm90IGluIHZyaW5nX3VzZV9kbWFf
YXBpKCkuIElmIG5vdCB3ZQpuZWVkIHJldHVybiBmYWxzZS4KCj4KPiBCdXQgbG9va2luZyBhdCB2
aXJ0aW9faGFzX2RtYV9xdWlyayBzaG93cyB0aGF0IHZpcnRpby1ncHUgaXMKPiBwcmV0dHkgbWVz
c2VkIHVwIGFscmVhZHkgYXMgd2VsbC4KPgo+IEl0IGNhbid0IHJlYWxseSBwb2tlIGludG8gdGhl
IERNQSBkZXRhaWxzLiAgV2UnbGwgbmVlZCBjb3JlIHZpcnRpbwo+IGhlbHBlcnMgZm9yIGFsbG9j
YXRpbmcgYW5kIHN5bmNpbmcgYSBzZ190YWJsZSBpbnN0ZWFkIGFuZCBtYWtlCj4gdmlydGlvX2hh
c19kbWFfcXVpcmsgcHJpdmF0ZSB0byB0aGUgY29yZS4KCkFkZGluZyBHZXJkLgoKVGhhbmtzCgo+
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
