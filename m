Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2E10C38142
	for <virtualization@archiver.kernel.org>; Thu, 19 Jan 2023 03:16:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6CB6C4192F;
	Thu, 19 Jan 2023 03:16:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6CB6C4192F
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=RLx8+Rlc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 749IMBy90rc0; Thu, 19 Jan 2023 03:16:32 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id A06C041932;
	Thu, 19 Jan 2023 03:16:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A06C041932
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 73CA9C0033;
	Thu, 19 Jan 2023 03:16:31 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCDA1C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 03:16:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B15C2610AB
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 03:16:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B15C2610AB
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=RLx8+Rlc
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 8H3UK8c9SGmE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 03:16:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5B00860B51
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5B00860B51
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 03:16:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674098186;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=UEAyeHzgkAupgJMwknbiDqBEC1GYYBnvH2SxqDruG38=;
 b=RLx8+RlcMFsw9YuOVvjK/Qh4/1tzK+ojs6bkPBqLpw3JwfvXmnTQlvR5CJc2WTWxByORUC
 wFQdeIuoIB+f3tPP2RinadU7HxnRw0jg5C3+5uYE1qHU9SgSlEFN0kO9rOwpUL2ElXSL/0
 8YFUQcDrJ05sT4fI4f38dpHRwLaBEX0=
Received: from mail-oa1-f69.google.com (mail-oa1-f69.google.com
 [209.85.160.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-371-8vDO62HvPU6O0mL8gNvJkQ-1; Wed, 18 Jan 2023 22:16:25 -0500
X-MC-Unique: 8vDO62HvPU6O0mL8gNvJkQ-1
Received: by mail-oa1-f69.google.com with SMTP id
 586e51a60fabf-15f2d95f1easo484078fac.2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Jan 2023 19:16:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=UEAyeHzgkAupgJMwknbiDqBEC1GYYBnvH2SxqDruG38=;
 b=Y64qBU7/7k3zkT4UtGjle7J02/4NxcjWhGek2AtjtrnWLRcvGOR2aUiBXsQtbkK1Ue
 9PGrg1M1i7AjTmqTusTjZdRkleZRiXWQtqVgB+JixTZD1E5hUNZ8KKsnZzYMPyHW0B6X
 N4O0D4QOcngaFbJ76P/O+8ELrAal4PZHLkAVWSK/f768nG2+t0sg/VMmmuZ8TSrbVQC/
 /TSVqoWwkdFB6PSr7QCpgf+fjbL1kTvYYhZ10Dy0b3zWOrUE2A9xyPVK3OmGr7LnCAd1
 qpG1Q88e3p9EmAlEkYCGETaNfX7WxHiO9rQAsvNpABHzL6KYKHiEJge087LH7T4Jd7CQ
 0K2w==
X-Gm-Message-State: AFqh2kq6jbs5W6heUzzNKDg1Ltj87jDNegSyOrg1EAHNdQwj5ls6qY2X
 iQo5P1GfbYkXrxhDXBpL6g9B1VQEeC7mqZl0jYDk7lObs40yzuGwJm5+1nEVbS4zEP0TqoMgREI
 L4zmy+QnomW4w4Ad75H49vAbbPTxNhZoBSydUnulyRyJhNGtAchnGApi5iA==
X-Received: by 2002:a05:6871:10e:b0:15b:96b5:9916 with SMTP id
 y14-20020a056871010e00b0015b96b59916mr809556oab.280.1674098184637; 
 Wed, 18 Jan 2023 19:16:24 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtw1xnPLkvtcoMtHxPiTCTrubYN1NT29GYArw3LFI7S8h3cfpKtpx8ZzRduNDS5CMtlOt33jyUeuiK0rXs9Yww=
X-Received: by 2002:a05:6871:10e:b0:15b:96b5:9916 with SMTP id
 y14-20020a056871010e00b0015b96b59916mr809544oab.280.1674098184424; Wed, 18
 Jan 2023 19:16:24 -0800 (PST)
MIME-Version: 1.0
References: <20230118164359.1523760-1-eperezma@redhat.com>
 <20230118164359.1523760-2-eperezma@redhat.com>
In-Reply-To: <20230118164359.1523760-2-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 19 Jan 2023 11:16:13 +0800
Message-ID: <CACGkMEt=po+FMEikgj3OXC7_QC=yhRP2Sx0NU=2sFPGgQ4bujA@mail.gmail.com>
Subject: Re: [PATCH 1/2] vdpa_sim: not reset state in vdpasim_queue_ready
To: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, lulu@redhat.com, mst@redhat.com,
 linux-kernel@vger.kernel.org, Gautam Dawar <gdawar@xilinx.com>,
 virtualization@lists.linux-foundation.org, leiyang@redhat.com
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

T24gVGh1LCBKYW4gMTksIDIwMjMgYXQgMTI6NDQgQU0gRXVnZW5pbyBQw6lyZXogPGVwZXJlem1h
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gdmRwYXNpbV9xdWV1ZV9yZWFkeSBjYWxscyB2cmluZ2hf
aW5pdF9pb3RsYiwgd2hpY2ggcmVzZXRzIHNwbGl0IGluZGV4ZXMuCj4gQnV0IGl0IGNhbiBiZSBj
YWxsZWQgYWZ0ZXIgc2V0dGluZyBhIHJpbmcgYmFzZSB3aXRoCj4gdmRwYXNpbV9zZXRfdnFfc3Rh
dGUuCj4KPiBGaXggaXQgYnkgc3Rhc2hpbmcgdGhlbS4gVGhleSdyZSBzdGlsbCByZXNldHRlZCBp
biB2ZHBhc2ltX3ZxX3Jlc2V0Lgo+Cj4gVGhpcyB3YXMgZGlzY292ZXJlZCBhbmQgdGVzdGVkIGxp
dmUgbWlncmF0aW5nIHRoZSB2ZHBhX3NpbV9uZXQgZGV2aWNlLgo+Cj4gRml4ZXM6IDJjNTNkMGY2
NGMwNiAoInZkcGFzaW06IHZEUEEgZGV2aWNlIHNpbXVsYXRvciIpCj4gU2lnbmVkLW9mZi1ieTog
RXVnZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvdmRw
YS92ZHBhX3NpbS92ZHBhX3NpbS5jIHwgMiArKwo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRp
b25zKCspCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMg
Yi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+IGluZGV4IGNiODg4OTFiNDRhOC4u
ODgzOTIzMmEzZmNiIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3Np
bS5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMKPiBAQCAtNjYsNiAr
NjYsNyBAQCBzdGF0aWMgdm9pZCB2ZHBhc2ltX3ZxX25vdGlmeShzdHJ1Y3QgdnJpbmdoICp2cmlu
ZykKPiAgc3RhdGljIHZvaWQgdmRwYXNpbV9xdWV1ZV9yZWFkeShzdHJ1Y3QgdmRwYXNpbSAqdmRw
YXNpbSwgdW5zaWduZWQgaW50IGlkeCkKPiAgewo+ICAgICAgICAgc3RydWN0IHZkcGFzaW1fdmly
dHF1ZXVlICp2cSA9ICZ2ZHBhc2ltLT52cXNbaWR4XTsKPiArICAgICAgIHVpbnQxNl90IGxhc3Rf
YXZhaWxfaWR4ID0gdnEtPnZyaW5nLmxhc3RfYXZhaWxfaWR4Owo+Cj4gICAgICAgICB2cmluZ2hf
aW5pdF9pb3RsYigmdnEtPnZyaW5nLCB2ZHBhc2ltLT5mZWF0dXJlcywgdnEtPm51bSwgZmFsc2Us
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAoc3RydWN0IHZyaW5nX2Rlc2MgKikodWludHB0
cl90KXZxLT5kZXNjX2FkZHIsCj4gQEAgLTc0LDYgKzc1LDcgQEAgc3RhdGljIHZvaWQgdmRwYXNp
bV9xdWV1ZV9yZWFkeShzdHJ1Y3QgdmRwYXNpbSAqdmRwYXNpbSwgdW5zaWduZWQgaW50IGlkeCkK
PiAgICAgICAgICAgICAgICAgICAgICAgICAgIChzdHJ1Y3QgdnJpbmdfdXNlZCAqKQo+ICAgICAg
ICAgICAgICAgICAgICAgICAgICAgKHVpbnRwdHJfdCl2cS0+ZGV2aWNlX2FkZHIpOwo+Cj4gKyAg
ICAgICB2cS0+dnJpbmcubGFzdF9hdmFpbF9pZHggPSBsYXN0X2F2YWlsX2lkeDsKCkRvZXMgdGhp
cyBuZWVkIHRvIGJlIHNlcmlhbGl6ZWQgd2l0aCB0aGUgZGF0YXBhdGg/CgpFLmcgaW4gc2V0X3Zx
X3N0YXRlKCkgd2UgZG86CgpzcGluX2xvY2soJnZkcGFzaW0tPmxvY2spOwp2cmgtPmxhc3RfYXZh
aWxfaWR4ID0gc3RhdGUtPnNwbGl0LmF2YWlsX2luZGV4OwpzcGluX3VubG9jaygmdmRwYXNpbS0+
bG9jayk7CgpUaGFua3MKCj4gICAgICAgICB2cS0+dnJpbmcubm90aWZ5ID0gdmRwYXNpbV92cV9u
b3RpZnk7Cj4gIH0KPgo+IC0tCj4gMi4zMS4xCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
