Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA7DE81817
	for <virtualization@archiver.kernel.org>; Tue, 26 Sep 2023 04:37:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0E23441764;
	Tue, 26 Sep 2023 04:37:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0E23441764
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=G82Tof8A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5HVl-7CeGs32; Tue, 26 Sep 2023 04:37:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 82634400E4;
	Tue, 26 Sep 2023 04:37:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 82634400E4
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5246DC0071;
	Tue, 26 Sep 2023 04:37:24 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CBF5EC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 04:37:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F4D761349
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 04:37:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F4D761349
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=G82Tof8A
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id a-7FyLnniLCA
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 04:37:22 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B84F560DFD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Sep 2023 04:37:21 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B84F560DFD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695703040;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OlxCYW4gvs6NcetxUbOuJzhkEzIekaCZ3GVBq7mXcyw=;
 b=G82Tof8ARAMaHS7vMJYpBXoQihjU8F8KCF9J0ku0j16h3gW33aHybaJ04byFn2+dTN54XJ
 dBPW7BTBHiiZWFwE43dQFI+IYZyzHwu8YNExrFfFoEENb9276dnyv/U4BPa14pJTdVoNvq
 vlDnca447rYdhczN/juOH8XKjE39Wmc=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-272-AhtQ8qG7OaOoAFtzAGHsew-1; Tue, 26 Sep 2023 00:37:18 -0400
X-MC-Unique: AhtQ8qG7OaOoAFtzAGHsew-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2bfe60dfbc3so112614591fa.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Sep 2023 21:37:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695703037; x=1696307837;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=OlxCYW4gvs6NcetxUbOuJzhkEzIekaCZ3GVBq7mXcyw=;
 b=S0/pBudqK7bRx/JtxvD03zkGJ42gHZSoDs3s3lxGfLdReMejrKnrOVr99KpxPIjPbu
 b6SWli/Aw/dcT4POW7Vg+SdZZoZNruKPFBTPYOMwAsS99KwgQQSqOQj/ny825XB7OiTg
 QA93IdZv5LrbWh9+sQtIv/hj2KIXzfUvk5WJWcjyHgj5nz9q6Q4Mq89ciIgjdXYQRIt6
 aF06tIcUJiw/1FTqVofw/tG12tpXgNrPCb6O8tGpJi+iExc4/inNPqzgUyOd7ZL8+kwp
 1yFBTuP7XicqwgHCDFTTYnM91xFgqfZ8TQsaBykIyl/8PFO2ImyoccQpE0MKC/6loGnJ
 UcfQ==
X-Gm-Message-State: AOJu0Yy731rHACqHN8tH8uCtb/A3rfSFF8gx3pf34nRCAxIfgcUWBOEf
 5smCftLSpUf8iQjYm9Mnz5gRTYMI0sfacAM0UgHFhEyvMBci2Me+5Convi0zqHmbY3dJdkdqsJ0
 TxFLW5k9iLHJZmpKLJYHUpLTSrm/3jutQA6Mx2xBTYEia94t6BLTvxaTXgg==
X-Received: by 2002:a05:6512:ea0:b0:4fb:740a:81ae with SMTP id
 bi32-20020a0565120ea000b004fb740a81aemr8556503lfb.16.1695703037412; 
 Mon, 25 Sep 2023 21:37:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGNkpmgxSfocjjuW7aLgAyK6C+0u3te928OI7LJMt7eR6OZwrgABZeepiaMfe8FTOCLRsWIJA+ptKT1xgYbLi0=
X-Received: by 2002:a05:6512:ea0:b0:4fb:740a:81ae with SMTP id
 bi32-20020a0565120ea000b004fb740a81aemr8556492lfb.16.1695703037131; Mon, 25
 Sep 2023 21:37:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230921125348-mutt-send-email-mst@kernel.org>
 <20230921170709.GS13733@nvidia.com>
 <20230921131035-mutt-send-email-mst@kernel.org>
 <20230921174450.GT13733@nvidia.com>
 <20230921135426-mutt-send-email-mst@kernel.org>
 <20230921181637.GU13733@nvidia.com>
 <20230921152802-mutt-send-email-mst@kernel.org>
 <20230921195345.GZ13733@nvidia.com>
 <20230921155834-mutt-send-email-mst@kernel.org>
 <CACGkMEvD+cTyRtax7_7TBNECQcGPcsziK+jCBgZcLJuETbyjYw@mail.gmail.com>
 <20230922122246.GN13733@nvidia.com>
 <PH0PR12MB548127753F25C45B7EFF203DDCFFA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEuX5HJVBOw9E+skr=K=QzH3oyHK8gk-r0hAvi6Wm7OA7Q@mail.gmail.com>
 <PH0PR12MB5481ED78F7467EEB0740847EDCFCA@PH0PR12MB5481.namprd12.prod.outlook.com>
 <CACGkMEv9_+6sYp1JZpCZr19csg0jO-jLVhuygWqm+s9mWr3Lew@mail.gmail.com>
 <PH0PR12MB5481304AA75B517A327C5690DCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
In-Reply-To: <PH0PR12MB5481304AA75B517A327C5690DCC3A@PH0PR12MB5481.namprd12.prod.outlook.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 26 Sep 2023 12:37:05 +0800
Message-ID: <CACGkMEtfYu5zO1Dn7ErKid15DaDd3nm3yyt9kWsE-FVv-U8D0w@mail.gmail.com>
Subject: Re: [PATCH vfio 11/11] vfio/virtio: Introduce a vfio driver over
 virtio devices
To: Parav Pandit <parav@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Maor Gottlieb <maorg@nvidia.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>, Jason Gunthorpe <jgg@nvidia.com>,
 Jiri Pirko <jiri@nvidia.com>, Leon Romanovsky <leonro@nvidia.com>
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

T24gVHVlLCBTZXAgMjYsIDIwMjMgYXQgMTI6MDHigK9QTSBQYXJhdiBQYW5kaXQgPHBhcmF2QG52
aWRpYS5jb20+IHdyb3RlOgo+Cj4KPgo+ID4gRnJvbTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4KPiA+IFNlbnQ6IFR1ZXNkYXksIFNlcHRlbWJlciAyNiwgMjAyMyA4OjAzIEFNCj4g
Pgo+ID4gSXQncyB0aGUgaW1wbGVtZW50YXRpb24gZGV0YWlscyBpbiBsZWdhY3kuIFRoZSBkZXZp
Y2UgbmVlZHMgdG8gbWFrZSBzdXJlIChyZXNldCkKPiA+IHRoZSBkcml2ZXIgY2FuIHdvcmsgKGlz
IGRvbmUgYmVmb3JlIGdldF9zdGF0dXMgcmV0dXJuKS4KPiBJdCBpcyBwYXJ0IG9mIHRoZSAwLjku
NSBhbmQgMS54IHNwZWNpZmljYXRpb24gYXMgSSBxdW90ZWQgdGhvc2UgdGV4dCBhYm92ZS4KCldo
YXQgSSBtZWFudCBpczogbGVnYWN5IGRldmljZXMgbmVlZCB0byBmaW5kIHRoZWlyIHdheSB0byBt
YWtlIGxlZ2FjeQpkcml2ZXJzIHdvcmsuIFRoYXQncyBob3cgbGVnYWN5IHdvcmtzLgoKSXQncyB0
b28gbGF0ZSB0byBhZGQgYW55IG5vcm1hdGl2ZSB0byB0aGUgMC45NSBzcGVjLiBTbyB0aGUgZGV2
aWNlCmJlaGF2aW91ciBpcyBhY3R1YWxseSBkZWZpbmVkIGJ5IHRoZSBsZWdhY3kgZHJpdmVycy4g
VGhhdCBpcyB3aHkgaXQgaXMKdHJpY2t5LgoKSWYgeW91IGNhbid0IGZpbmQgYSB3YXkgdG8gbWFr
ZSBsZWdhY3kgZHJpdmVycyB3b3JrLCB1c2UgbW9kZXJuLgoKVGhhdCdzIGl0LgoKVGhhbmtzCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
