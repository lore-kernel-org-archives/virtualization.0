Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99A3AC4332F
	for <virtualization@archiver.kernel.org>; Mon,  5 Dec 2022 20:29:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FFF4410AB;
	Mon,  5 Dec 2022 20:29:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1FFF4410AB
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=V3zPNPiN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4pnxpNfXLjmz; Mon,  5 Dec 2022 20:29:14 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 58270409EB;
	Mon,  5 Dec 2022 20:29:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 58270409EB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1905BC0033;
	Mon,  5 Dec 2022 20:29:13 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7A589C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 20:29:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 3CBC7409EB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 20:29:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3CBC7409EB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yqpfmuOiMDms
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 20:29:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0401140932
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0401140932
 for <virtualization@lists.linux-foundation.org>;
 Mon,  5 Dec 2022 20:29:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670272148;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=i4H5uezEbMG5ZldNo/c3W56d4899NhGUYDjXb8nhkk4=;
 b=V3zPNPiNiEpkYxgHEvurU/ae3ov7dc4uug1YqkT7wgWMEMnqAlXhbstBV2DqU/quePJ4vn
 14DYjYcagbwAmbqLEMfHb8qC01wSuStKmH4ziwIIemTMOZNOzq9kRRMVOd+5Wk+Q3L/J0s
 47o03ZrpWXJYtPZlyHxfRi8WsYnMT8U=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-671-lCFr8Hb9MnemUto0t8fgrQ-1; Mon, 05 Dec 2022 15:29:07 -0500
X-MC-Unique: lCFr8Hb9MnemUto0t8fgrQ-1
Received: by mail-wm1-f69.google.com with SMTP id
 i203-20020a1c3bd4000000b003d0f49bc21bso3330107wma.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 05 Dec 2022 12:29:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=i4H5uezEbMG5ZldNo/c3W56d4899NhGUYDjXb8nhkk4=;
 b=UphdfnAaPw6bLhInlUSMu77yp204LPsvPCBUQaholMDT1WSZUnXTkFB3piILrVF3Q2
 Vg6yBRt5ENanjrge7/2JcuM4YM8Jy96zK180rd+0QQCo5jzLuzwxJCvqZYNZFljOGeAH
 mQYdFl81VagC8YOc7VMc0BiG044Glp3BSZ7BDov4eA6Cyo03Y/TqJf+rtVjbsezJs1H4
 S3iqZd7USbiaKl0yvfnU0nzB2trqB4F0rV6bmQCoQ2fGMxoJB9YS38QgyPu5+Q2CHo/p
 Ml0N14tp6x1yLvRXSWK+9CP2DZkE90giDsjprqP0sE/pL5PmNUH9yu6OwTwi+PB7FTqG
 tY8w==
X-Gm-Message-State: ANoB5pl0ureWmEV5yX9rfP34+LDrw8cxweVSJx0vQSP/L2nCyV14P6aV
 ZcApa0hNE2BSi36gFcdxL3Cx6kFDbnuNhDwQ2kiTZMOw3qAzmuD7joJ8zXao599DqfKn0Y7X3AT
 gsJ29FVsPoOfU3+RLzoEY5ThdMfTaxa7iOBGv1ztmdQ==
X-Received: by 2002:a5d:610d:0:b0:242:4fd1:1f5c with SMTP id
 v13-20020a5d610d000000b002424fd11f5cmr7301055wrt.376.1670272146268; 
 Mon, 05 Dec 2022 12:29:06 -0800 (PST)
X-Google-Smtp-Source: AA0mqf78f2gBMfTc6pHwRJ9zUly9GcCuFO5gZSklgpcj2WDCa2T0RWsRGceUYvYzIHBgrSw3qKds3g==
X-Received: by 2002:a5d:610d:0:b0:242:4fd1:1f5c with SMTP id
 v13-20020a5d610d000000b002424fd11f5cmr7301041wrt.376.1670272146115; 
 Mon, 05 Dec 2022 12:29:06 -0800 (PST)
Received: from redhat.com ([2.55.160.224]) by smtp.gmail.com with ESMTPSA id
 b18-20020a05600010d200b002423a5d7cb1sm12096271wrx.113.2022.12.05.12.29.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 05 Dec 2022 12:29:05 -0800 (PST)
Date: Mon, 5 Dec 2022 15:29:02 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jens Axboe <axboe@kernel.dk>
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <20221205152708-mutt-send-email-mst@kernel.org>
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
 <fe2800f1-aaae-33e8-aaf0-83fd034162d5@kernel.dk>
 <CAJs=3_AKOMWBpvKqvX6_c=zN1cwEM7x9dzGr7na=i-5_16rdEg@mail.gmail.com>
 <23c98c7c-3ed0-0d26-24c0-ed8a63266dcc@kernel.dk>
MIME-Version: 1.0
In-Reply-To: <23c98c7c-3ed0-0d26-24c0-ed8a63266dcc@kernel.dk>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-scsi@vger.kernel.org, linux-nvme@lists.infradead.org,
 virtualization@lists.linux-foundation.org, linux-block@vger.kernel.org,
 dm-devel@redhat.com, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Enrico Granata <egranata@google.com>
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

T24gTW9uLCBEZWMgMDUsIDIwMjIgYXQgMTE6NTM6NTFBTSAtMDcwMCwgSmVucyBBeGJvZSB3cm90
ZToKPiBPbiAxMi81LzIyIDExOjM24oCvQU0sIEFsdmFybyBLYXJzeiB3cm90ZToKPiA+IEhpLAo+
ID4gCj4gPj4gSXMgdGhpcyBiYXNlZCBvbiBzb21lIHNwZWM/IEJlY2F1c2UgaXQgbG9va3MgcHJl
dHR5IG9kZCB0byBtZS4gVGhlcmUKPiA+PiBjYW4gYmUgYSBwcmV0dHkgd2lkZSByYW5nZSBvZiB0
d28vdGhyZWUvZXRjIGxldmVsIGNlbGxzIHdpdGggd2lsZGx5Cj4gPj4gZGlmZmVyZW50IHJhbmdl
cyBvZiBkdXJhYmlsaXR5LiBBbmQgdGhlcmUncyByZWFsbHkgbm90IGEgbG90IG9mIHNsYwo+ID4+
IGZvciBnZW5lcmljIGRldmljZXMgdGhlc2UgZGF5cywgaWYgYW55Lgo+ID4gCj4gPiBZZXMsIHRo
aXMgaXMgYmFzZWQgb24gdGhlIHZpcnRpbyBzcGVjCj4gPiBodHRwczovL2RvY3Mub2FzaXMtb3Bl
bi5vcmcvdmlydGlvL3ZpcnRpby92MS4yL2NzZDAxL3ZpcnRpby12MS4yLWNzZDAxLmh0bWwKPiA+
IHNlY3Rpb24gIDUuMi42Cj4gCj4gQW5kIHdoZXJlIGRpZCB0aGlzIGNvbWUgZnJvbT8KCgpIZXJl
J3MgdGhlIGNvbW1pdCBsb2cgZnJvbSB0aGUgc3BlYzoKCUluIG1hbnkgZW1iZWRkZWQgc3lzdGVt
cywgdmlydGlvLWJsayBpbXBsZW1lbnRhdGlvbnMgYXJlCgliYWNrZWQgYnkgZU1NQyBvciBVRlMg
c3RvcmFnZSBkZXZpY2VzLCB3aGljaCBhcmUgc3ViamVjdCB0bwoJcHJlZGljdGFibGUgYW5kIG1l
YXN1cmFibGUgd2VhciBvdmVyIHRpbWUgZHVlIHRvIHJlcGVhdGVkIHdyaXRlCgljeWNsZXMuCgoJ
Rm9yIHN1Y2ggc3lzdGVtcywgaXQgY2FuIGJlIGltcG9ydGFudCB0byBiZSBhYmxlIHRvIHRyYWNr
CglhY2N1cmF0ZWx5IHRoZSBhbW91bnQgb2Ygd2VhciBpbXBvc2VkIG9uIHRoZSBzdG9yYWdlIG92
ZXIKCXRpbWUgYW5kIHN1cmZhY2UgaXQgdG8gYXBwbGljYXRpb25zLiBJbiBhIG5hdGl2ZSBkZXBs
b3ltZW50cwoJdGhpcyBpcyBnZW5lcmFsbHkgaGFuZGxlZCBieSB0aGUgcGh5c2ljYWwgYmxvY2sg
ZGV2aWNlIGRyaXZlcgoJYnV0IG5vIHN1Y2ggcHJvdmlzaW9uIGlzIG1hZGUgaW4gdmlydGlvLWJs
ayB0byBleHBvc2UgdGhlc2UKCW1ldHJpY3MgZm9yIGRldmljZXMgd2hlcmUgaXQgbWFrZXMgc2Vu
c2UgdG8gZG8gc28uCgoJVGhpcyBwYXRjaCBhZGRzIHN1cHBvcnQgdG8gdmlydGlvLWJsayBmb3Ig
bGlmZXRpbWUgYW5kIHdlYXIKCW1ldHJpY3MgdG8gYmUgZXhwb3NlZCB0byB0aGUgZ3Vlc3Qgd2hl
biBhIGRlcGxveW1lbnQgb2YKCXZpcnRpby1ibGsgaXMgZG9uZSBvdmVyIGNvbXBhdGlibGUgZU1N
QyBvciBVRlMgc3RvcmFnZS4KCglTaWduZWQtb2ZmLWJ5OiBFbnJpY28gR3JhbmF0YSA8ZWdyYW5h
dGFAZ29vZ2xlLmNvbT4KCkNjIEVucmljbyBHcmFuYXRhIGFzIHdlbGwuCgoKPiAtLSAKPiBKZW5z
IEF4Ym9lCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
