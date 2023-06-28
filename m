Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B58F3EB64D9
	for <virtualization@archiver.kernel.org>; Wed, 28 Jun 2023 02:34:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3460282141;
	Wed, 28 Jun 2023 02:34:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3460282141
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=N/UAHT1E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gYD8IiHMpiQb; Wed, 28 Jun 2023 02:34:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id D09C781AAB;
	Wed, 28 Jun 2023 02:34:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D09C781AAB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2C1BC0072;
	Wed, 28 Jun 2023 02:34:55 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 17C11C0037
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 02:34:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id DFE1F40576
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 02:34:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DFE1F40576
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=N/UAHT1E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rhFRbPNb0kg4
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 02:34:54 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3B418401D2
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 3B418401D2
 for <virtualization@lists.linux-foundation.org>;
 Wed, 28 Jun 2023 02:34:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1687919692;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dCxVeK5h/dORUE2gYkmTMAY5Skn7U71Hm0WtRWaHEYk=;
 b=N/UAHT1ECMlOwQmkBXSClHDI6FGKXJ84swCCnZx0Un3itaAVx/We9I0vYzm3HS7dwpP+Wj
 G3p+s2JLHugCb21PSM7JJu/VvuUxipFbYMH7jsJhI3QcC+CvP5UOA9UeeUkysnkSM99CGz
 rpssG8Eo+kqA18jOaj9SATf0V2adB+g=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-43QIXn4uMQKWvCG3FamXtA-1; Tue, 27 Jun 2023 22:34:51 -0400
X-MC-Unique: 43QIXn4uMQKWvCG3FamXtA-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-4fb76659cacso2774638e87.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 27 Jun 2023 19:34:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1687919690; x=1690511690;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dCxVeK5h/dORUE2gYkmTMAY5Skn7U71Hm0WtRWaHEYk=;
 b=mAd5exbyuV0rOd6+eEaG9P8J7AcHZHvsItZTas4ZruUUfIje8GbRRsyZLk3Gl0mEml
 qIGA1iLU55+SXv4GOK/HKtsBqaTUG8J5AUk0ikOoujkAYhvkGATwhAsJcwPlIWdSzs7a
 hh5rVnnqns1GFA/4hdwFwTkAGmGBi3+P1F+WN3slEkQ0A66L7aNU50bC7HT5SH+xqzRZ
 o3V30AKGvR41R6o5bsSx0IMVmzGGXCE/bBwZWcfnpHRMcAxq8nU7561Ly3X2lbpfeq3m
 KLNwT3fRgPVYRYnWDa8o/GJ4Kp63ehN0MW6fd705wuu4haT8NQ+DtiRW+6S/+rTeT9QA
 nh/A==
X-Gm-Message-State: AC+VfDy9Mh65sTuUQZJVS3A3cdvU1xo6MqKy+vBC/xekj64Vc5RQT9UA
 SytlT5rx/jrJGCP7I5KDkvcMvVZoQrlK6RHDOlj49gzrVr1Hgqqw5LS7t9XSN8LirwNTiu1ROVY
 AoItSsBF8JqPz/kbBVla6SmLsPF2AEpSQfP4ke+gezEA2fHoEJLlcrJWWzQ==
X-Received: by 2002:a19:2d54:0:b0:4f8:5e5f:b368 with SMTP id
 t20-20020a192d54000000b004f85e5fb368mr17437561lft.21.1687919689997; 
 Tue, 27 Jun 2023 19:34:49 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6TOdyFneufgIE6Aita5S8TSfhtJ7h2l/bao4uqZmEfdB72MMgC1AzLUSdBVAFlaWW6dl2nrE5KtoGWh4spOKE=
X-Received: by 2002:a19:2d54:0:b0:4f8:5e5f:b368 with SMTP id
 t20-20020a192d54000000b004f85e5fb368mr17437556lft.21.1687919689714; Tue, 27
 Jun 2023 19:34:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230627113652.65283-1-maxime.coquelin@redhat.com>
 <20230627113652.65283-2-maxime.coquelin@redhat.com>
In-Reply-To: <20230627113652.65283-2-maxime.coquelin@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 28 Jun 2023 10:34:38 +0800
Message-ID: <CACGkMEveEcB5LsQBSc7kf7JEwDfX3-dc38+6sh7tu_wryROpRw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] vduse: validate block features only with block
 devices
To: Maxime Coquelin <maxime.coquelin@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: xuanzhuo@linux.alibaba.com, lulu@redhat.com, mst@redhat.com,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, xieyongji@bytedance.com,
 eperezma@redhat.com, david.marchand@redhat.com
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

T24gVHVlLCBKdW4gMjcsIDIwMjMgYXQgNzozN+KAr1BNIE1heGltZSBDb3F1ZWxpbgo8bWF4aW1l
LmNvcXVlbGluQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gVGhpcyBwYXRjaCBpcyBwcmVsaW1pbmFy
eSB3b3JrIHRvIGVuYWJsZSBuZXR3b3JrIGRldmljZQo+IHR5cGUgc3VwcG9ydCB0byBWRFVTRS4K
Pgo+IEFzIFZJUlRJT19CTEtfRl9DT05GSUdfV0NFIHNoYXJlcyB0aGUgc2FtZSB2YWx1ZSBhcwo+
IFZJUlRJT19ORVRfRl9IT1NUX1RTTzQsIHdlIG5lZWQgdG8gcmVzdHJpY3QgaXRzIGNoZWNrCj4g
dG8gVmlydGlvLWJsayBkZXZpY2UgdHlwZS4KPgo+IFNpZ25lZC1vZmYtYnk6IE1heGltZSBDb3F1
ZWxpbiA8bWF4aW1lLmNvcXVlbGluQHJlZGhhdC5jb20+CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8
amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKPiAtLS0KPiAgZHJpdmVycy92ZHBhL3ZkcGFf
dXNlci92ZHVzZV9kZXYuYyB8IDkgKysrKystLS0tCj4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL3Zk
cGFfdXNlci92ZHVzZV9kZXYuYyBiL2RyaXZlcnMvdmRwYS92ZHBhX3VzZXIvdmR1c2VfZGV2LmMK
PiBpbmRleCA1ZjVjMjE2NzRmZGMuLmMxYzJmNGM3MTFhZSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJz
L3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jCj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfdXNl
ci92ZHVzZV9kZXYuYwo+IEBAIC0xNjU4LDEzICsxNjU4LDE0IEBAIHN0YXRpYyBib29sIGRldmlj
ZV9pc19hbGxvd2VkKHUzMiBkZXZpY2VfaWQpCj4gICAgICAgICByZXR1cm4gZmFsc2U7Cj4gIH0K
Pgo+IC1zdGF0aWMgYm9vbCBmZWF0dXJlc19pc192YWxpZCh1NjQgZmVhdHVyZXMpCj4gK3N0YXRp
YyBib29sIGZlYXR1cmVzX2lzX3ZhbGlkKHN0cnVjdCB2ZHVzZV9kZXZfY29uZmlnICpjb25maWcp
Cj4gIHsKPiAtICAgICAgIGlmICghKGZlYXR1cmVzICYgKDFVTEwgPDwgVklSVElPX0ZfQUNDRVNT
X1BMQVRGT1JNKSkpCj4gKyAgICAgICBpZiAoIShjb25maWctPmZlYXR1cmVzICYgKDFVTEwgPDwg
VklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNKSkpCj4gICAgICAgICAgICAgICAgIHJldHVybiBmYWxz
ZTsKPgo+ICAgICAgICAgLyogTm93IHdlIG9ubHkgc3VwcG9ydCByZWFkLW9ubHkgY29uZmlndXJh
dGlvbiBzcGFjZSAqLwo+IC0gICAgICAgaWYgKGZlYXR1cmVzICYgKDFVTEwgPDwgVklSVElPX0JM
S19GX0NPTkZJR19XQ0UpKQo+ICsgICAgICAgaWYgKChjb25maWctPmRldmljZV9pZCA9PSBWSVJU
SU9fSURfQkxPQ0spICYmCj4gKyAgICAgICAgICAgICAgICAgICAgICAgKGNvbmZpZy0+ZmVhdHVy
ZXMgJiAoMVVMTCA8PCBWSVJUSU9fQkxLX0ZfQ09ORklHX1dDRSkpKQo+ICAgICAgICAgICAgICAg
ICByZXR1cm4gZmFsc2U7Cj4KPiAgICAgICAgIHJldHVybiB0cnVlOwo+IEBAIC0xNjkxLDcgKzE2
OTIsNyBAQCBzdGF0aWMgYm9vbCB2ZHVzZV92YWxpZGF0ZV9jb25maWcoc3RydWN0IHZkdXNlX2Rl
dl9jb25maWcgKmNvbmZpZykKPiAgICAgICAgIGlmICghZGV2aWNlX2lzX2FsbG93ZWQoY29uZmln
LT5kZXZpY2VfaWQpKQo+ICAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7Cj4KPiAtICAgICAg
IGlmICghZmVhdHVyZXNfaXNfdmFsaWQoY29uZmlnLT5mZWF0dXJlcykpCj4gKyAgICAgICBpZiAo
IWZlYXR1cmVzX2lzX3ZhbGlkKGNvbmZpZykpCj4gICAgICAgICAgICAgICAgIHJldHVybiBmYWxz
ZTsKPgo+ICAgICAgICAgcmV0dXJuIHRydWU7Cj4gLS0KPiAyLjQxLjAKPgoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
