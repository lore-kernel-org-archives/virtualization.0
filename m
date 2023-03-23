Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A00B0C6FD1C
	for <virtualization@archiver.kernel.org>; Thu, 23 Mar 2023 05:18:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 29FD46141E;
	Thu, 23 Mar 2023 05:18:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 29FD46141E
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=esTJqiyp
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id LWiWAPSUecdK; Thu, 23 Mar 2023 05:18:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 817AE6143B;
	Thu, 23 Mar 2023 05:18:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 817AE6143B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 49A75C0035;
	Thu, 23 Mar 2023 05:18:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 184B9C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 05:18:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D3B606143B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 05:18:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org D3B606143B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id znBXCJaXGP6N
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 05:18:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 263946141E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 263946141E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 05:18:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679548722;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9pa8I6uMPs5BO05vLsVIFV0T990dC+krQvICt00FYL8=;
 b=esTJqiypmfaQFMgmGfoptkR31p11P5zcBzNPd8afGNIWPU/FhZFrAjni6Q50GYqd9G36hc
 xfn4nFoE8bTtlfhQ5tXM7rogDllPebUmPfQNTtaK13a4cm7yEPWPCpiVTd2Yk57YjlGjgP
 n5UtREFvgAkV/tgsjQvHzUDZ8tBEO9Q=
Received: from mail-oi1-f199.google.com (mail-oi1-f199.google.com
 [209.85.167.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-ckCR2lCBPzKHs3U2UWaexQ-1; Thu, 23 Mar 2023 01:18:31 -0400
X-MC-Unique: ckCR2lCBPzKHs3U2UWaexQ-1
Received: by mail-oi1-f199.google.com with SMTP id
 a2-20020a544e02000000b003873410ce73so1439374oiy.21
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 22:18:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679548710;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=9pa8I6uMPs5BO05vLsVIFV0T990dC+krQvICt00FYL8=;
 b=3dqolvQ4r5ZJf88Y3zgu2rDqBF0CwsxvzA6622Bi1O603yjsbt8YCuvb2WdGOGLEOG
 FXC2L+hCVm6W5Ut5Oh/W+/b6SfPx3jcbWNprsVpPXba7odbEeK6IFOp2LLx90WpfzEeS
 mZB5+3eRbfgqGIvp+g00GO75Ei6mRxo/Mq4+KE4RKBvw79afji07R6L0uwZCu7qIUTAM
 M2yLf3vC37eNNkI5AE8vs9qWeEI6oxX37TEqHN203Hr2YBsMyCYXWYDF856Koe+CmCWI
 Fc36pHq7bsBGwfQq32uh34E4t0RtNLcGeEt6GNOP+orhErSfJI9DajkKOB6gJLf6Rb2u
 vWtQ==
X-Gm-Message-State: AO0yUKVvjZlbVzJ78iaGSCua2GY6/xsOQpzXHxRA+M1hniKkU9WPCuVQ
 Vm01LcmwryOvIsBEYJnRuesRc2JFzd0Cnp5/1km02mBXHuj06RoOE329o0lx/bUIWu5at1RF98l
 kgqMFbfgxQqmR01AWYsS4kkZIJDx2BL8tNbT+monp6NZOFGE1WMn0p2hS8w==
X-Received: by 2002:a54:438b:0:b0:37f:a2ad:6718 with SMTP id
 u11-20020a54438b000000b0037fa2ad6718mr1984894oiv.3.1679548710412; 
 Wed, 22 Mar 2023 22:18:30 -0700 (PDT)
X-Google-Smtp-Source: AK7set95jbJXhhqB31gIQpV+J3ITukaVY6VeIsQ56Mdi1D6yzlxWUbfhwzdbdxSM8UguVGMj3rRBa3SmTOHJdnj2ZgQ=
X-Received: by 2002:a54:438b:0:b0:37f:a2ad:6718 with SMTP id
 u11-20020a54438b000000b0037fa2ad6718mr1984890oiv.3.1679548710160; Wed, 22 Mar
 2023 22:18:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230322191038.44037-1-shannon.nelson@amd.com>
 <20230322191038.44037-7-shannon.nelson@amd.com>
In-Reply-To: <20230322191038.44037-7-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Mar 2023 13:18:18 +0800
Message-ID: <CACGkMEvacgachSZK8J4zpSXAYaCBkyJrqp8_rYV7-k1O7arC7Q@mail.gmail.com>
Subject: Re: [PATCH v3 virtio 6/8] pds_vdpa: add support for vdpa and vdpamgmt
 interfaces
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: brett.creeley@amd.com, mst@redhat.com, netdev@vger.kernel.org,
 virtualization@lists.linux-foundation.org, kuba@kernel.org,
 drivers@pensando.io, davem@davemloft.net
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

T24gVGh1LCBNYXIgMjMsIDIwMjMgYXQgMzoxMeKAr0FNIFNoYW5ub24gTmVsc29uIDxzaGFubm9u
Lm5lbHNvbkBhbWQuY29tPiB3cm90ZToKPgo+IFRoaXMgaXMgdGhlIHZEUEEgZGV2aWNlIHN1cHBv
cnQsIHdoZXJlIHdlIGFkdmVydGlzZSB0aGF0IHdlIGNhbgo+IHN1cHBvcnQgdGhlIHZpcnRpbyBx
dWV1ZXMgYW5kIGRlYWwgd2l0aCB0aGUgY29uZmlndXJhdGlvbiB3b3JrCj4gdGhyb3VnaCB0aGUg
cGRzX2NvcmUncyBhZG1pbnEuCj4KPiBTaWduZWQtb2ZmLWJ5OiBTaGFubm9uIE5lbHNvbiA8c2hh
bm5vbi5uZWxzb25AYW1kLmNvbT4KPiAtLS0KPiAgZHJpdmVycy92ZHBhL3Bkcy9hdXhfZHJ2LmMg
IHwgIDE1ICsKPiAgZHJpdmVycy92ZHBhL3Bkcy9hdXhfZHJ2LmggIHwgICAxICsKPiAgZHJpdmVy
cy92ZHBhL3Bkcy9kZWJ1Z2ZzLmMgIHwgMjYwICsrKysrKysrKysrKysrKysrCj4gIGRyaXZlcnMv
dmRwYS9wZHMvZGVidWdmcy5oICB8ICAxMCArCj4gIGRyaXZlcnMvdmRwYS9wZHMvdmRwYV9kZXYu
YyB8IDU2MCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKy0KPiAgNSBmaWxlcyBj
aGFuZ2VkLCA4NDUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmRwYS9wZHMvYXV4X2Rydi5jIGIvZHJpdmVycy92ZHBhL3Bkcy9hdXhfZHJ2LmMK
PiBpbmRleCA4ZjNhZTMzMjY4ODUuLmU1NGYwMzcxYzYwZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L3ZkcGEvcGRzL2F1eF9kcnYuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9wZHMvYXV4X2Rydi5jCgpb
Li4uXQoKPiArCj4gK3N0YXRpYyBzdHJ1Y3QgdmRwYV9ub3RpZmljYXRpb25fYXJlYQo+ICtwZHNf
dmRwYV9nZXRfdnFfbm90aWZpY2F0aW9uKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYsIHUx
NiBxaWQpCj4gK3sKPiArICAgICAgIHN0cnVjdCBwZHNfdmRwYV9kZXZpY2UgKnBkc3YgPSB2ZHBh
X3RvX3Bkc3YodmRwYV9kZXYpOwo+ICsgICAgICAgc3RydWN0IHZpcnRpb19wY2lfbW9kZXJuX2Rl
dmljZSAqdmRfbWRldjsKPiArICAgICAgIHN0cnVjdCB2ZHBhX25vdGlmaWNhdGlvbl9hcmVhIGFy
ZWE7Cj4gKwo+ICsgICAgICAgYXJlYS5hZGRyID0gcGRzdi0+dnFzW3FpZF0ubm90aWZ5X3BhOwo+
ICsKPiArICAgICAgIHZkX21kZXYgPSAmcGRzdi0+dmRwYV9hdXgtPnZkX21kZXY7Cj4gKyAgICAg
ICBpZiAoIXZkX21kZXYtPm5vdGlmeV9vZmZzZXRfbXVsdGlwbGllcikKPiArICAgICAgICAgICAg
ICAgYXJlYS5zaXplID0gUERTX1BBR0VfU0laRTsKClRoaXMgaGFzbid0IGJlZW4gZGVmaW5lZCBz
byBmYXI/IE90aGVycyBsb29rIGdvb2QuCgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
