Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A3896EB64DD
	for <virtualization@archiver.kernel.org>; Mon, 31 Jul 2023 01:23:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 113CA40332;
	Mon, 31 Jul 2023 01:23:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 113CA40332
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gLTMFhGy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NHr4Di_nxdpx; Mon, 31 Jul 2023 01:23:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 8EC874049D;
	Mon, 31 Jul 2023 01:23:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8EC874049D
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4F0FAC0072;
	Mon, 31 Jul 2023 01:23:50 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 96A57C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 01:23:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 620D760FB0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 01:23:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 620D760FB0
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=gLTMFhGy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dfSGiv_xkA3f
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 01:23:47 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6831F60FAD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 31 Jul 2023 01:23:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6831F60FAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1690766625;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dUdX1IUA/AAHMSIEitCsUCTcaVwwQpXUAsFez0cmz4o=;
 b=gLTMFhGyPt+HS3iShS4U1D0dAKKC6R76hGzhe9/HdnLb8ThvW3nAewW1A6O7MALOaAYAzM
 nTjU4rx5/LSsj1PDpdCcZ5eYJVNG3/ixvdBGbA4C2ZawZSyO3iOqP9bfJVPiPwYcDGBFwX
 G/CsjH5V7kjQP2GeRMnfyxVllqK7IWk=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-541-uCBhBLmYPo2Dx_Ura0IpCg-1; Sun, 30 Jul 2023 21:23:43 -0400
X-MC-Unique: uCBhBLmYPo2Dx_Ura0IpCg-1
Received: by mail-lj1-f197.google.com with SMTP id
 38308e7fff4ca-2b9ba719605so38041191fa.0
 for <virtualization@lists.linux-foundation.org>;
 Sun, 30 Jul 2023 18:23:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1690766621; x=1691371421;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dUdX1IUA/AAHMSIEitCsUCTcaVwwQpXUAsFez0cmz4o=;
 b=Y4Ugc2pCXXS5Pko/Bf1XbJpuSvGymc6drZrb50plJ9hvFO7lxfTDTwFvjx4OjK+8hH
 kzZwy4ATV4SC/jxROKmVlkliad887WRcn8osGDYvxu1xZFvauwWFrjU5S5Ga1xMF08Sh
 OTAM/EWFTW6OQq9trIp9MLTaY8UvdNcEAKMzdritCU9DIo7i9bHaW/R7I3uvHtUbWgE1
 Gs8ocVQNdsV3GWkto+gxjl2BHnyu83spQ6JRz6xHH68HWgrSdW3zwX0pt9a4m8UnJ8qd
 11exskPd4Z3nvtaSixHK7C2ALnQQbU9i5NoFdHueyBeD/vnoZjsnqxuyb4elXtoeKAxQ
 UIFw==
X-Gm-Message-State: ABy/qLbXC7QkmaaYPyevJg2gNfgIsWJxHFkiDyG8RUCuqc9+hMgW8kyq
 5UKSM/FVZIVR8h0it4jShjRBElgNIYFTzvL+7k/1rAFh7nARyo1eLYCHu6oikOh/v6qveg7D0jj
 epwiIE4YRKeET3XDPsaqAW8eLktyxBWYcjMsj9EQDiEWJLJ2ZheI5Ymz3OQ==
X-Received: by 2002:a2e:7a03:0:b0:2b6:e96c:5414 with SMTP id
 v3-20020a2e7a03000000b002b6e96c5414mr4997707ljc.52.1690766621648; 
 Sun, 30 Jul 2023 18:23:41 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH3mYNG7gP+Xjt7/gXlwoQNDUicpGKnwfgw/1ZkukAGM6542lgUEVkWhMu8+/b3ZIbUEcpDG5CjB8A8VE6rDOM=
X-Received: by 2002:a2e:7a03:0:b0:2b6:e96c:5414 with SMTP id
 v3-20020a2e7a03000000b002b6e96c5414mr4997702ljc.52.1690766621373; Sun, 30 Jul
 2023 18:23:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230710034237.12391-1-xuanzhuo@linux.alibaba.com>
 <20230710034237.12391-6-xuanzhuo@linux.alibaba.com>
 <ZK/cxNHzI23I6efc@infradead.org>
 <20230713104805-mutt-send-email-mst@kernel.org>
 <ZLjSsmTfcpaL6H/I@infradead.org>
 <20230720131928-mutt-send-email-mst@kernel.org>
 <ZL6qPvd6X1CgUD4S@infradead.org>
 <1690251228.3455179-1-xuanzhuo@linux.alibaba.com>
 <20230725033321-mutt-send-email-mst@kernel.org>
 <1690283243.4048996-1-xuanzhuo@linux.alibaba.com>
 <1690524153.3603117-1-xuanzhuo@linux.alibaba.com>
 <20230728080305.5fe3737c@kernel.org>
In-Reply-To: <20230728080305.5fe3737c@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 31 Jul 2023 09:23:29 +0800
Message-ID: <CACGkMEs5uc=ct8BsJzV2SEJzAGXqCP__yxo-MBa6d6JzDG4YOg@mail.gmail.com>
Subject: Re: [PATCH vhost v11 05/10] virtio_ring: introduce virtqueue_dma_dev()
To: Jakub Kicinski <kuba@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Christoph Hellwig <hch@infradead.org>, Eric Dumazet <edumazet@google.com>,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
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

T24gRnJpLCBKdWwgMjgsIDIwMjMgYXQgMTE6MDPigK9QTSBKYWt1YiBLaWNpbnNraSA8a3ViYUBr
ZXJuZWwub3JnPiB3cm90ZToKPgo+IE9uIEZyaSwgMjggSnVsIDIwMjMgMTQ6MDI6MzMgKzA4MDAg
WHVhbiBaaHVvIHdyb3RlOgo+ID4gSGkgZ3V5cywgdGhpcyB0b3BpYyBpcyBzdHVjayBhZ2Fpbi4g
SG93IHNob3VsZCBJIHByb2NlZWQgd2l0aCB0aGlzIHdvcms/Cj4gPgo+ID4gTGV0IG1lIGJyaWVm
bHkgc3VtbWFyaXplOgo+ID4gMS4gVGhlIHByb2JsZW0gd2l0aCBhZGRpbmcgdmlydGlvX2RtYV97
bWFwLCBzeW5jfSBhcGkgaXMgdGhhdCwgZm9yIEFGX1hEUCBhbmQKPiA+IHRoZSBkcml2ZXIgbGF5
ZXIsIHdlIG5lZWQgdG8gc3VwcG9ydCB0aGVzZSBBUElzLiBUaGUgY3VycmVudCBjb25jbHVzaW9u
IG9mCj4gPiBBRl9YRFAgaXMgbm8uCj4gPgo+ID4gMi4gU2V0IGRtYV9zZXRfbWFza19hbmRfY29o
ZXJlbnQsIHRoZW4gd2UgY2FuIHVzZSBETUEgQVBJIHVuaWZvcm1seSBpbnNpZGUKPiA+IGRyaXZl
ci4gVGhpcyBpZGVhIHNlZW1zIHRvIGJlIGluY29uc2lzdGVudCB3aXRoIHRoZSBmcmFtZXdvcmsg
ZGVzaWduIG9mIERNQS4gVGhlCj4gPiBjb25jbHVzaW9uIGlzIG5vLgo+ID4KPiA+IDMuIFdlIG5v
dGljZWQgdGhhdCBpZiB0aGUgdmlydGlvIGRldmljZSBzdXBwb3J0cyBWSVJUSU9fRl9BQ0NFU1Nf
UExBVEZPUk0sIGl0Cj4gPiB1c2VzIERNQSBBUEkuIEFuZCB0aGlzIHR5cGUgb2YgZGV2aWNlIGlz
IHRoZSBmdXR1cmUgZGlyZWN0aW9uLCBzbyB3ZSBvbmx5Cj4gPiBzdXBwb3J0IERNQSBwcmVtYXBw
ZWQgZm9yIHRoaXMgdHlwZSBvZiB2aXJ0aW8gZGV2aWNlLiBUaGUgcHJvYmxlbSB3aXRoIHRoaXMK
PiA+IHNvbHV0aW9uIGlzIHRoYXQgdmlydHF1ZXVlX2RtYV9kZXYoKSBvbmx5IHJldHVybnMgZGV2
IGluIHNvbWUgY2FzZXMsIGJlY2F1c2UKPiA+IFZJUlRJT19GX0FDQ0VTU19QTEFURk9STSBpcyBz
dXBwb3J0ZWQgaW4gc3VjaCBjYXNlcy4gT3RoZXJ3aXNlIE5VTEwgaXMgcmV0dXJuZWQuCj4gPiBU
aGlzIG9wdGlvbiBpcyBjdXJyZW50bHkgTk8uCj4gPgo+ID4gU28gSSdtIHdvbmRlcmluZyB3aGF0
IHNob3VsZCBJIGRvLCBmcm9tIGEgRE1BIHBvaW50IG9mIHZpZXcsIGlzIHRoZXJlIGFueQo+ID4g
c29sdXRpb24gaW4gY2FzZSBvZiB1c2luZyBETUEgQVBJPwo+Cj4gSSdkIHN0ZXAgYmFjayBhbmQg
YXNrIHlvdSB3aHkgZG8geW91IHdhbnQgdG8gdXNlIEFGX1hEUCB3aXRoIHZpcnRpby4KPiBJbnN0
ZWFkIG9mIGJpZnVyY2F0aW5nIG9uZSB2aXJ0aW8gaW5zdGFuY2UgaW50byBkaWZmZXJlbnQgcXVl
dWVzIHdoeQo+IG5vdCBjcmVhdGUgYSBzZXBhcmF0ZSB2aXJ0aW8gaW5zdGFuY2U/Cj4KCkknbSBu
b3Qgc3VyZSBJIGdldCB0aGlzLCBidXQgZG8geW91IG1lYW4gYSBzZXBhcmF0ZSB2aXJ0aW8gZGV2
aWNlIHRoYXQKb3ducyBBRl9YRFAgcXVldWVzIG9ubHk/IElmIEkgdW5kZXJzdGFuZCBpdCBjb3Jy
ZWN0bHksIGJpZnVyY2F0aW5nIGlzCm9uZSBvZiB0aGUga2V5IGFkdmFudGFnZXMgb2YgQUZfWERQ
LiBXaGF0J3MgbW9yZSwgY3VycmVudCB2aXJ0aW8KZG9lc24ndCBzdXBwb3J0IGJlaW5nIHNwbGl0
IGF0IHF1ZXVlIChwYWlyKSBsZXZlbC4gQW5kIGl0IG1heSBzdGlsbApzdWZmZXIgZnJvbSB0aGUg
eWVzL25vIERNQSBBUEkgaXNzdWUuCgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
