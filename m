Return-Path: <SRS0=7x/u=EF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8964C388F9
	for <virtualization@archiver.kernel.org>; Fri, 30 Oct 2020 10:54:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 491432224E
	for <virtualization@archiver.kernel.org>; Fri, 30 Oct 2020 10:54:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JcV45RN+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 491432224E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BB83A87390;
	Fri, 30 Oct 2020 10:54:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id R1U6dMlD7oT6; Fri, 30 Oct 2020 10:54:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 381F487388;
	Fri, 30 Oct 2020 10:54:35 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1CBD6C088B;
	Fri, 30 Oct 2020 10:54:35 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8FA5BC0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 10:54:34 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 7EECE8511F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 10:54:34 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ASpMiPV5zBeb
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 10:54:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id DE0C4834B0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 10:54:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604055272;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=eNcsDz2cy5Yr+LEYgMRQaMYGAlPoileX7l+cMy1V2mc=;
 b=JcV45RN+NwNFMLQ2vPQbUP8pMqFMofswjVPBdRz+pllSkLpwIGG9uA6pCQjCbBMZShSQD/
 bu8a/DyXB4gRzkV1TTuVVOdI8PztvU3S6caamFSMtjehTwi3u86wV4XBbx9qMV6QyZ12uN
 2Rw+n9EwJpXm5BWWpZHa1FOd5k2yxMU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-148-84ytAhyTN0-2kUbztCKAXQ-1; Fri, 30 Oct 2020 06:54:31 -0400
X-MC-Unique: 84ytAhyTN0-2kUbztCKAXQ-1
Received: by mail-wr1-f71.google.com with SMTP id n14so2511598wrp.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 03:54:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=eNcsDz2cy5Yr+LEYgMRQaMYGAlPoileX7l+cMy1V2mc=;
 b=azbaQXz4WnJ2iVYlBMjsl365gVnlLuRsJksLkspaBEv1m4neiyhwQ4SRuDn2TsYflM
 tQ1ZdS5KY10JfIxW/OJttv567rYKL4+bD6lqhyh1jO8zUPwbM5qhhPu0kAGnVcptUYoZ
 JusxChz6TKH/dyte9mhzdoyvKP69PwVcVdwhxoSNVoLnltap42ZOtNIGO6r/zd32+k0b
 qarUf9PxkKo7EQ3jjFB1pJy5XXqi0NSrs1JjsBRCrnNiLMmQPM2VDgnnGXnSeQLtKi/S
 4fehh5uPOQwvQG/vS195Jtulct6/fvprPQhXKZYh9fF+lcFnpnVY7Lv0SNZCQ1FIxvqx
 1/FQ==
X-Gm-Message-State: AOAM531dUG4iBiyIZEXvbrJfiUtMkmmoWILOTypqSA3mjJUX0RuvavNF
 ka15X9P727o3zV45h4kccIOZnLx0t7tXQrBbdxfe1SyYLSq/UT7u6ePdH8z02ULllsBlBFYtwgl
 /+HhspfuMOkKM4Qv4PjBOFBrMlPzDTUSiAxD8zXC3RQ==
X-Received: by 2002:a7b:c4d6:: with SMTP id g22mr2069450wmk.106.1604055269706; 
 Fri, 30 Oct 2020 03:54:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzY5s4HQ3sHRjqMi8kZt0VprXDyGubGokKC7oZxhjQ9kRgwiCSE61bhqv62SbSqffXe8fXikA==
X-Received: by 2002:a7b:c4d6:: with SMTP id g22mr2069422wmk.106.1604055269495; 
 Fri, 30 Oct 2020 03:54:29 -0700 (PDT)
Received: from steredhat (host-79-22-200-33.retail.telecomitalia.it.
 [79.22.200.33])
 by smtp.gmail.com with ESMTPSA id x65sm4178936wmg.1.2020.10.30.03.54.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 03:54:28 -0700 (PDT)
Date: Fri, 30 Oct 2020 11:54:22 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost/vsock: add IOTLB API support
Message-ID: <20201030105422.ju2aj2bmwsckdufh@steredhat>
References: <20201029174351.134173-1-sgarzare@redhat.com>
 <751cc074-ae68-72c8-71de-a42458058761@redhat.com>
MIME-Version: 1.0
In-Reply-To: <751cc074-ae68-72c8-71de-a42458058761@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gRnJpLCBPY3QgMzAsIDIwMjAgYXQgMDY6MDI6MThQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMC8xMC8zMCDkuIrljYgxOjQzLCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6
Cj4+VGhpcyBwYXRjaCBlbmFibGVzIHRoZSBJT1RMQiBBUEkgc3VwcG9ydCBmb3Igdmhvc3QtdnNv
Y2sgZGV2aWNlcywKPj5hbGxvd2luZyB0aGUgdXNlcnNwYWNlIHRvIGVtdWxhdGUgYW4gSU9NTVUg
Zm9yIHRoZSBndWVzdC4KPj4KPj5UaGVzZSBjaGFuZ2VzIHdlcmUgbWFkZSBmb2xsb3dpbmcgdmhv
c3QtbmV0LCBpbiBkZXRhaWxzIHRoaXMgcGF0Y2g6Cj4+LSBleHBvc2VzIFZJUlRJT19GX0FDQ0VT
U19QTEFURk9STSBmZWF0dXJlIGFuZCBpbml0cyB0aGUgaW90bGIKPj4gICBkZXZpY2UgaWYgdGhl
IGZlYXR1cmUgaXMgYWNrZWQKPj4tIGltcGxlbWVudHMgVkhPU1RfR0VUX0JBQ0tFTkRfRkVBVFVS
RVMgYW5kCj4+ICAgVkhPU1RfU0VUX0JBQ0tFTkRfRkVBVFVSRVMgaW9jdGxzCj4+LSBjYWxscyB2
cV9tZXRhX3ByZWZldGNoKCkgYmVmb3JlIHZxIHByb2Nlc3NpbmcgdG8gcHJlZmV0Y2ggdnEKPj4g
ICBtZXRhZGF0YSBhZGRyZXNzIGluIElPVExCCj4+LSBwcm92aWRlcyAucmVhZF9pdGVyLCAud3Jp
dGVfaXRlciwgYW5kIC5wb2xsIGNhbGxiYWNrcyBmb3IgdGhlCj4+ICAgY2hhcmRldjsgdGhleSBh
cmUgdXNlZCBieSB0aGUgdXNlcnNwYWNlIHRvIGV4Y2hhbmdlIElPVExCIG1lc3NhZ2VzCj4+Cj4+
VGhpcyBwYXRjaCB3YXMgdGVzdGVkIHdpdGggUUVNVSBhbmQgYSBwYXRjaCBhcHBsaWVkIFsxXSB0
byBmaXggYQo+PnNpbXBsZSBpc3N1ZToKPj4gICAgICQgcWVtdSAtTSBxMzUsYWNjZWw9a3ZtLGtl
cm5lbC1pcnFjaGlwPXNwbGl0IFwKPj4gICAgICAgICAgICAtZHJpdmUgZmlsZT1mZWRvcmEucWNv
dzIsZm9ybWF0PXFjb3cyLGlmPXZpcnRpbyBcCj4+ICAgICAgICAgICAgLWRldmljZSBpbnRlbC1p
b21tdSxpbnRyZW1hcD1vbiBcCj4+ICAgICAgICAgICAgLWRldmljZSB2aG9zdC12c29jay1wY2ks
Z3Vlc3QtY2lkPTMsaW9tbXVfcGxhdGZvcm09b24KPgo+Cj5QYXRjaCBsb29rcyBnb29kLCBidXQg
YSBxdWVzdGlvbjoKPgo+SXQgbG9va3MgdG8gbWUgeW91IGRvbid0IGVuYWJsZSBBVFMgd2hpY2gg
bWVhbnMgdmhvc3Qgd29uJ3QgZ2V0IGFueSAKPmludmFsaWRhdGlvbiByZXF1ZXN0IG9yIGRpZCBJ
IG1pc3MgYW55dGhpbmc/Cj4KCllvdSdyZSByaWdodCwgSSBkaWRuJ3Qgc2VlIGludmFsaWRhdGlv
biByZXF1ZXN0cywgb25seSBtaXNzIGFuZCB1cGRhdGVzLgpOb3cgSSBoYXZlIHRyaWVkIHRvIGVu
YWJsZSAnYXRzJyBhbmQgJ2RldmljZS1pb3RsYicgYnV0IEkgc3RpbGwgZG9uJ3QgCnNlZSBhbnkg
aW52YWxpZGF0aW9uLgoKSG93IGNhbiBJIHRlc3QgaXQ/IChTb3JyeSBidXQgSSBkb24ndCBoYXZl
IG11Y2ggZXhwZXJpZW5jZSB5ZXQgd2l0aCAKdklPTU1VKQoKVGhhbmtzLApTdGVmYW5vCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
