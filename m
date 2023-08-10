Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 88030C001E0
	for <virtualization@archiver.kernel.org>; Thu, 10 Aug 2023 04:12:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id E25F760ADE;
	Thu, 10 Aug 2023 04:12:45 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E25F760ADE
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TfCC7I9x
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o2sEz3DDIlfK; Thu, 10 Aug 2023 04:12:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 62AE560AE3;
	Thu, 10 Aug 2023 04:12:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 62AE560AE3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 32BFBC0071;
	Thu, 10 Aug 2023 04:12:44 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6F8C5C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 04:12:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 4E09941904
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 04:12:43 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4E09941904
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TfCC7I9x
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ekrlwR0ZJIQm
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 04:12:42 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 501E441900
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Aug 2023 04:12:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 501E441900
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1691640760;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=MpZ1xdG2a7UripeaaXQi64sXQC9E4hMZ1zP5gcfMmYk=;
 b=TfCC7I9x4o/V1obKF9XWI8RnRckaJHfpk+PYsyZ7k6jIUmESYorCw2y0AFq7FCaiAKo6Lx
 pjj2fdIgg3R6gUcQjzAkPWQvoa4HKmIjBazRTPz2/O8CutXssPcfYub1hgGxltLmIxUpoq
 FEU2qyQKQyO9KV7iMm5RxS6MBbt1ROA=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-557-HzK7E0CbMXKgnEEqMdLvZg-1; Thu, 10 Aug 2023 00:12:37 -0400
X-MC-Unique: HzK7E0CbMXKgnEEqMdLvZg-1
Received: by mail-lj1-f200.google.com with SMTP id
 38308e7fff4ca-2b9cd6a555aso4705971fa.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Aug 2023 21:12:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1691640756; x=1692245556;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=MpZ1xdG2a7UripeaaXQi64sXQC9E4hMZ1zP5gcfMmYk=;
 b=YeR4hRIBdB6WEqwrHaX3mTe37QUQJgjLmoLB6UFy/5Q+ntdo7gIyMQ0NAFMgSZ8YVk
 9E2Zslla09hz9clVFjE4Xi54SkGEc5VBD/ihddzcTkUTQpbOfQxkZd+4eSZ9qFnUVG6+
 GlCUhX5BG1TBsgEo3Cn9T+krE4R1G8PRJPzOGAz/H6x9RJ393PftWi4xy8NfLFWgaCVD
 8Exxw3aruy08qAc6G4np6lEPJflXyi9FANEdmVehfvtHK+vY1wlNkqGeoKzfbQqaQ0jV
 YqQSyawMyKUyN2LNOPps4yMCsG1GhM65v6rdQ8pOHwnuI4M3rKu68+iONSg+IW3zavs4
 wrFw==
X-Gm-Message-State: AOJu0YzNMPst14kEQz+19JZDdcUL9+aG/hIamsQ2xmRJuu8O4fPIxuXd
 GQ8Zh+mbR8aEcthm6QBvJK53viIynWa9Up/t7Oy0Lz0wgdkXy7RrvDrciHJ5U4u8ERpTHiLXpJu
 +W5GsYarXzyyTJeCUkjD5lwKthbgQEkpVHObVJcQzxgZXHR4Zq7PsupWOgg==
X-Received: by 2002:a2e:884a:0:b0:2b9:ec57:c331 with SMTP id
 z10-20020a2e884a000000b002b9ec57c331mr940295ljj.6.1691640756074; 
 Wed, 09 Aug 2023 21:12:36 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHaAekTnhnaCJl4cn+CYttu+Q7kBOi1OQnauownq+9tUz7svhr/pDPkmAYG6E44ev8Mnzua0MchL6zCrzalZvI=
X-Received: by 2002:a2e:884a:0:b0:2b9:ec57:c331 with SMTP id
 z10-20020a2e884a000000b002b9ec57c331mr940280ljj.6.1691640755792; Wed, 09 Aug
 2023 21:12:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230810031557.135557-1-yin31149@gmail.com>
In-Reply-To: <20230810031557.135557-1-yin31149@gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 10 Aug 2023 12:12:24 +0800
Message-ID: <CACGkMEu_vzfcD=BzkL=HAkfi+RVq1F2vpDDQBGg54O_PL1fWGQ@mail.gmail.com>
Subject: Re: [PATCH] virtio-net: Zero max_tx_vq field for
 VIRTIO_NET_CTRL_MQ_HASH_CONFIG case
To: Hawkins Jiawei <yin31149@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, Eric Dumazet <edumazet@google.com>, 18801353760@163.com,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
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

T24gVGh1LCBBdWcgMTAsIDIwMjMgYXQgMTE6MTbigK9BTSBIYXdraW5zIEppYXdlaSA8eWluMzEx
NDlAZ21haWwuY29tPiB3cm90ZToKPgo+IEtlcm5lbCB1c2VzIGBzdHJ1Y3QgdmlydGlvX25ldF9j
dHJsX3Jzc2AgdG8gc2F2ZSBjb21tYW5kLXNwZWNpZmljLWRhdGEKPiBmb3IgYm90aCB0aGUgVklS
VElPX05FVF9DVFJMX01RX0hBU0hfQ09ORklHIGFuZAo+IFZJUlRJT19ORVRfQ1RSTF9NUV9SU1Nf
Q09ORklHIGNvbW1hbmRzLgoKVGhpcyBpcyB0cmlja3kuCgo+Cj4gQWNjb3JkaW5nIHRvIHRoZSBW
aXJ0SU8gc3RhbmRhcmQsICJGaWVsZCByZXNlcnZlZCBNVVNUIGNvbnRhaW4gemVyb2VzLgo+IEl0
IGlzIGRlZmluZWQgdG8gbWFrZSB0aGUgc3RydWN0dXJlIHRvIG1hdGNoIHRoZSBsYXlvdXQgb2YK
PiB2aXJ0aW9fbmV0X3Jzc19jb25maWcgc3RydWN0dXJlLCBkZWZpbmVkIGluIDUuMS42LjUuNy4i
Lgo+Cj4gWWV0IGZvciB0aGUgVklSVElPX05FVF9DVFJMX01RX0hBU0hfQ09ORklHIGNvbW1hbmQg
Y2FzZSwgdGhlIGBtYXhfdHhfdnFgCj4gZmllbGQgaW4gc3RydWN0IHZpcnRpb19uZXRfY3RybF9y
c3MsIHdoaWNoIGNvcnJlc3BvbmRzIHRvIHRoZQo+IGByZXNlcnZlZGAgZmllbGQgaW4gc3RydWN0
IHZpcnRpb19uZXRfaGFzaF9jb25maWcsIGlzIG5vdCB6ZXJvZWQsCj4gdGhlcmVieSB2aW9sYXRp
bmcgdGhlIFZpcnRJTyBzdGFuZGFyZC4KPgo+IFRoaXMgcGF0Y2ggc29sdmVzIHRoaXMgcHJvYmxl
bSBieSB6ZXJvaW5nIHRoaXMgZmllbGQgaW4KPiB2aXJ0bmV0X2luaXRfZGVmYXVsdF9yc3MoKS4K
Pgo+IFNpZ25lZC1vZmYtYnk6IEhhd2tpbnMgSmlhd2VpIDx5aW4zMTE0OUBnbWFpbC5jb20+Cj4g
LS0tCgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
