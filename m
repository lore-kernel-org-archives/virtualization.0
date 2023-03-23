Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66205C6FD1C
	for <virtualization@archiver.kernel.org>; Thu, 23 Mar 2023 09:38:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E2B148006F;
	Thu, 23 Mar 2023 09:38:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E2B148006F
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=J/Jwhw6C
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id q7EKGeV7cRtw; Thu, 23 Mar 2023 09:38:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 79C5180E75;
	Thu, 23 Mar 2023 09:38:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 79C5180E75
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 469FDC0071;
	Thu, 23 Mar 2023 09:38:49 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id AF5C1C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 09:38:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7D4EE80E75
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 09:38:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7D4EE80E75
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uFECC_fgVdLj
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 09:38:46 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7FAC78006F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7FAC78006F
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 09:38:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679564325;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Wv8z0Oa+BNXMxQvoR0WkvQh5FJ+53xDgUpA+wdsZMxA=;
 b=J/Jwhw6CiDqSm0hrbSCimBkst8dTClMGBzxT63TJLO+vAQaUzHL2yE14ULkHRMbIQK+ep1
 zeHaXEssyUQJoK3Un0K93YvkeskhMv9hpis9MVy6XATpaP0iDwdIqfz7qL6HVeOAzrJymE
 fIgch21vmnoCUVER4yrOFTfMRkVjsrE=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-_R1pTQ5bMgySLUt9HrqVOQ-1; Thu, 23 Mar 2023 05:38:43 -0400
X-MC-Unique: _R1pTQ5bMgySLUt9HrqVOQ-1
Received: by mail-qv1-f69.google.com with SMTP id
 f8-20020a0cbec8000000b005b14a30945cso10557258qvj.8
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 02:38:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679564323;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Wv8z0Oa+BNXMxQvoR0WkvQh5FJ+53xDgUpA+wdsZMxA=;
 b=iZX8jqjqpNaz/kVXBToOFDmmkP4X0ygTwt5wwJk6M4ptQWzlorCKJHnZ1iNYF9Jlqh
 EBXokNUV/RIJen+LZEm5Mx9Uql+FdDDK72lvDB1A7fFUKlzB1j76x+ECe6i1pu6u/FLp
 b3puSBSDoL8JcUaeu1v1wEPM1MQNdCbT+BX6kUu+sMKicR7trdCFtCk6cxhinsxQf6OZ
 lNl7Spdw++SqG7EKeOVheRPGJh4QU2IgIcOBCE4zIWJGiuWT1IeMRPiyGJMbryzFH3xT
 jSo/qBFYSrVlUm/SDfnFkpWVnnT5LXZkh30Ul9NTYyQ/EoTsL4aXPrQVPv5GFGoFWLkP
 qxLg==
X-Gm-Message-State: AO0yUKVmPAHc0bOYeN31Xk9mai+G1dK9Fn0SWObm2BTqC+ZudMnIXy7c
 gnSo/ku1AXducOh7X3ac2JAlMYHXm3JTCWuZAWn873ZK/oj2vcycwfI5JndVTAtqSkV8umW/nPa
 yuKMr4YkoJ48pN2JGjagR/fU0y7f7aPt7kKODHGg2Gw==
X-Received: by 2002:a05:622a:284:b0:3bf:d238:6ca with SMTP id
 z4-20020a05622a028400b003bfd23806camr8824073qtw.68.1679564323363; 
 Thu, 23 Mar 2023 02:38:43 -0700 (PDT)
X-Google-Smtp-Source: AK7set99g4T9mj3o49CpahBOOAtxidRMSqg1u94nbjZpIXaZjWImk48PhBoKMemZZJq1z4EVJUoSbQ==
X-Received: by 2002:a05:622a:284:b0:3bf:d238:6ca with SMTP id
 z4-20020a05622a028400b003bfd23806camr8824056qtw.68.1679564323068; 
 Thu, 23 Mar 2023 02:38:43 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-98.retail.telecomitalia.it.
 [82.53.134.98]) by smtp.gmail.com with ESMTPSA id
 b21-20020ac85415000000b003995f6513b9sm11310043qtq.95.2023.03.23.02.38.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 23 Mar 2023 02:38:42 -0700 (PDT)
Date: Thu, 23 Mar 2023 10:38:37 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3 2/8] vhost-vdpa: use bind_mm/unbind_mm device callbacks
Message-ID: <20230323093837.xdv7wkhzizgnihcy@sgarzare-redhat>
References: <20230321154228.182769-1-sgarzare@redhat.com>
 <20230321154228.182769-3-sgarzare@redhat.com>
 <CACGkMEtq8PWL01WBL2Ve-Yr=ZO+su73tKuOh1EBLagkrLdiCaQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEtq8PWL01WBL2Ve-Yr=ZO+su73tKuOh1EBLagkrLdiCaQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com
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

T24gVGh1LCBNYXIgMjMsIDIwMjMgYXQgMTE6MDE6MzlBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPk9uIFR1ZSwgTWFyIDIxLCAyMDIzIGF0IDExOjQy4oCvUE0gU3RlZmFubyBHYXJ6YXJlbGxh
IDxzZ2FyemFyZUByZWRoYXQuY29tPiB3cm90ZToKPj4KPj4gV2hlbiB0aGUgdXNlciBjYWxsIFZI
T1NUX1NFVF9PV05FUiBpb2N0bCBhbmQgdGhlIHZEUEEgZGV2aWNlCj4+IGhhcyBgdXNlX3ZhYCBz
ZXQgdG8gdHJ1ZSwgbGV0J3MgY2FsbCB0aGUgYmluZF9tbSBjYWxsYmFjay4KPj4gSW4gdGhpcyB3
YXkgd2UgY2FuIGJpbmQgdGhlIGRldmljZSB0byB0aGUgdXNlciBhZGRyZXNzIHNwYWNlCj4+IGFu
ZCBkaXJlY3RseSB1c2UgdGhlIHVzZXIgVkEuCj4+Cj4+IFRoZSB1bmJpbmRfbW0gY2FsbGJhY2sg
aXMgY2FsbGVkIGR1cmluZyB0aGUgcmVsZWFzZSBhZnRlcgo+PiBzdG9wcGluZyB0aGUgZGV2aWNl
Lgo+Pgo+PiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhh
dC5jb20+Cj4+IC0tLQo+Pgo+PiBOb3RlczoKPj4gICAgIHYzOgo+PiAgICAgLSBhZGRlZCBgY2Fz
ZSBWSE9TVF9TRVRfT1dORVJgIGluIHZob3N0X3ZkcGFfdW5sb2NrZWRfaW9jdGwoKSBbSmFzb25d
Cj4+ICAgICB2MjoKPj4gICAgIC0gY2FsbCB0aGUgbmV3IHVuYmluZF9tbSBjYWxsYmFjayBkdXJp
bmcgdGhlIHJlbGVhc2UgW0phc29uXQo+PiAgICAgLSBhdm9pZCB0byBjYWxsIGJpbmRfbW0gY2Fs
bGJhY2sgYWZ0ZXIgdGhlIHJlc2V0LCBzaW5jZSB0aGUgZGV2aWNlCj4+ICAgICAgIGlzIG5vdCBk
ZXRhY2hpbmcgaXQgbm93IGR1cmluZyB0aGUgcmVzZXQKPj4KPj4gIGRyaXZlcnMvdmhvc3QvdmRw
YS5jIHwgMzEgKysrKysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+PiAgMSBmaWxlIGNoYW5n
ZWQsIDMxIGluc2VydGlvbnMoKykKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRw
YS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPj4gaW5kZXggN2JlOWQ5ZDhmMDFjLi4yMDI1MGMz
NDE4YjIgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+ICsrKyBiL2RyaXZl
cnMvdmhvc3QvdmRwYS5jCj4+IEBAIC0yMTksNiArMjE5LDI4IEBAIHN0YXRpYyBpbnQgdmhvc3Rf
dmRwYV9yZXNldChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdikKPj4gICAgICAgICByZXR1cm4gdmRwYV9y
ZXNldCh2ZHBhKTsKPj4gIH0KPj4KPj4gK3N0YXRpYyBsb25nIHZob3N0X3ZkcGFfYmluZF9tbShz
dHJ1Y3Qgdmhvc3RfdmRwYSAqdikKPj4gK3sKPj4gKyAgICAgICBzdHJ1Y3QgdmRwYV9kZXZpY2Ug
KnZkcGEgPSB2LT52ZHBhOwo+PiArICAgICAgIGNvbnN0IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMg
Km9wcyA9IHZkcGEtPmNvbmZpZzsKPj4gKwo+PiArICAgICAgIGlmICghdmRwYS0+dXNlX3ZhIHx8
ICFvcHMtPmJpbmRfbW0pCj4+ICsgICAgICAgICAgICAgICByZXR1cm4gMDsKPj4gKwo+PiArICAg
ICAgIHJldHVybiBvcHMtPmJpbmRfbW0odmRwYSwgdi0+dmRldi5tbSk7Cj4+ICt9Cj4+ICsKPj4g
K3N0YXRpYyB2b2lkIHZob3N0X3ZkcGFfdW5iaW5kX21tKHN0cnVjdCB2aG9zdF92ZHBhICp2KQo+
PiArewo+PiArICAgICAgIHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4+ICsg
ICAgICAgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRwYS0+Y29uZmlnOwo+
PiArCj4+ICsgICAgICAgaWYgKCF2ZHBhLT51c2VfdmEgfHwgIW9wcy0+dW5iaW5kX21tKQo+PiAr
ICAgICAgICAgICAgICAgcmV0dXJuOwo+PiArCj4+ICsgICAgICAgb3BzLT51bmJpbmRfbW0odmRw
YSk7Cj4+ICt9Cj4+ICsKPj4gIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfZ2V0X2RldmljZV9pZChz
dHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTggX191c2VyICphcmdwKQo+PiAgewo+PiAgICAgICAgIHN0
cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4+IEBAIC03MDksNiArNzMxLDE0IEBA
IHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfdW5sb2NrZWRfaW9jdGwoc3RydWN0IGZpbGUgKmZpbGVw
LAo+PiAgICAgICAgIGNhc2UgVkhPU1RfVkRQQV9SRVNVTUU6Cj4+ICAgICAgICAgICAgICAgICBy
ID0gdmhvc3RfdmRwYV9yZXN1bWUodik7Cj4+ICAgICAgICAgICAgICAgICBicmVhazsKPj4gKyAg
ICAgICBjYXNlIFZIT1NUX1NFVF9PV05FUjoKPj4gKyAgICAgICAgICAgICAgIHIgPSB2aG9zdF9k
ZXZfc2V0X293bmVyKGQpOwo+Cj5OaXQ6Cj4KPkknZCBzdGljayB0byB0aGUgY3VycmVudCB3YXkg
b2YgcGFzc2luZyB0aGUgY21kLCBhcmdwIHRvCj52aG9zdF9kZXZfaW9jdGwoKSBhbmQgaW50cm9k
dWNlIGEgbmV3IHN3aXRjaCBhZnRlciB0aGUKPnZob3N0X2Rldl9pb2N0bCgpLgo+Cj5JbiB0aGlz
IHdheSwgd2UgYXJlIGltbXVuZSB0byBhbnkgcG9zc2libGUgY2hhbmdlcyBvZiBkZWFsaW5nIHdp
dGgKPlZIT1NUX1NFVF9PV05FUiBpbiB2aG9zdCBjb3JlLgoKR29vZCBwb2ludCwgSSdsbCBjaGFu
Z2UgaW4gdjQuCgo+Cj5PdGhlcnMgbG9vayBnb29kLgoKVGhhbmtzLApTdGVmYW5vCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
