Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3EEECDB46E
	for <virtualization@archiver.kernel.org>; Thu, 12 Oct 2023 07:56:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 44BB08213B;
	Thu, 12 Oct 2023 07:56:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 44BB08213B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GFg6lJIV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3ofKyzASt5OH; Thu, 12 Oct 2023 07:56:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8298381E38;
	Thu, 12 Oct 2023 07:56:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 8298381E38
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5331DC0039;
	Thu, 12 Oct 2023 07:56:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5458BC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 07:56:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 296E9405E1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 07:56:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 296E9405E1
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GFg6lJIV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wgZ43WLpO5Dy
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 07:56:01 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id DD33C404FE
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 07:56:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DD33C404FE
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1697097359;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=k1AC1YYN586hSAedr4mvOMYwj7aPk3LZozPWFgfaOJU=;
 b=GFg6lJIVzU0t4QN5hEO7bnkZpPX4p6G/G4qdB+I50eu0YCCe9NnpwRJRg5rYovN4BtD46l
 u432/upVL6+7PLbXqYq/vywh6NYnM01ww7b8muCv94vksY1fgh02tAj3cZfbLXVKqL8ZaW
 GCzaIq2PqbKD6/A6gzri/fwB3xkwuGU=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-354-_W9RTd5FNN6d1QZVvYJyuw-1; Thu, 12 Oct 2023 03:55:57 -0400
X-MC-Unique: _W9RTd5FNN6d1QZVvYJyuw-1
Received: by mail-lj1-f199.google.com with SMTP id
 38308e7fff4ca-2c032e30083so5869271fa.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 12 Oct 2023 00:55:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1697097356; x=1697702156;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=k1AC1YYN586hSAedr4mvOMYwj7aPk3LZozPWFgfaOJU=;
 b=Zi4TszeYJM6dLRWj94TPFztn+YjrX9KwwGVNBjGs0ELgKkqVPhJAz+ICjTMbWf50Iu
 4oRzbP727ATkm1+PORnc1vjbiySPn8wScbqU9Ay1DYop5lOiQe0liE2qZjxsQPZkC/qs
 zTjyN54Aij6c9vWjLgdHrwJOoxVPtfdjKmfRlLzY+GEBPlx1PD497BLMzwywRgPGUxd0
 JpWv2A96YGSaYxW+gEQmMAxHC+9dRyVQSAe2DYRHDUF5Ewu+OvWxnv+JTIbhUAR6CQaL
 UvWhBnyMm+LxBzdj74zzQayrjAbs96vIHycfA2Rj8RYM/lhA30yao0EEXcJTaxeU1Nar
 Wz2A==
X-Gm-Message-State: AOJu0YxcrFqmROqi2puFzxTrlFmRKcjk2r+iqUmT9P0VWWfrYpvOqZLt
 /rUJzDi40KMdl7kPbNCbUTbpfQr8FwrksUaWUz6bHayTE93ShsDX7RyefaLYeUG3/fOc/WVPdpc
 3tZ6TZMXuPCaBKKW5rE/ayVlf9nSRL/Ttqmx0D8EifHX/YHDH1mNOuWwrrg==
X-Received: by 2002:a05:6512:1586:b0:505:6eef:cf2d with SMTP id
 bp6-20020a056512158600b005056eefcf2dmr23246666lfb.17.1697097356494; 
 Thu, 12 Oct 2023 00:55:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IH017PwZBIwf+1vW5mpySdYhUBFOfYhiWoAoVGAwCy4CgFJlJGxEmjr75a61f9CzRbty8MM9QpM/l1xVA9+TBk=
X-Received: by 2002:a05:6512:1586:b0:505:6eef:cf2d with SMTP id
 bp6-20020a056512158600b005056eefcf2dmr23246653lfb.17.1697097356208; Thu, 12
 Oct 2023 00:55:56 -0700 (PDT)
MIME-Version: 1.0
References: <a8dadf64-7723-926d-290f-945df04df194@linux.alibaba.com>
In-Reply-To: <a8dadf64-7723-926d-290f-945df04df194@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 12 Oct 2023 15:55:45 +0800
Message-ID: <CACGkMEswHqyR0F3K9wibgEyKDh=7T6=93ZUKgAnNZsOZnu4KsA@mail.gmail.com>
Subject: Re: Report a possible vhost bug in stable branches
To: Xianting Tian <xianting.tian@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: virtualization@lists.linux-foundation.org,
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

T24gVGh1LCBPY3QgMTIsIDIwMjMgYXQgOTo0M+KAr0FNIFhpYW50aW5nIFRpYW4KPHhpYW50aW5n
LnRpYW5AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gY2dyb3VwIGF0dGFjaCB3b3JrIGFu
ZCBkZXYgZmx1c2ggd29yayB3aWxsIGJvdGggYmUgYWRkZWQgdG8gZGV2IHdvcmsKPiBsaXN0IGlu
IHZob3N0X2F0dGFjaF9jZ3JvdXBzKCkgd2hlbiBzZXQgZGV2IG93bmVyOgo+ICAgICAgICAgICAg
ICBzdGF0aWMgaW50IHZob3N0X2F0dGFjaF9jZ3JvdXBzKHN0cnVjdCB2aG9zdF9kZXYgKmRldikK
PiAgICAgICAgICAgICAgewo+ICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aG9zdF9hdHRh
Y2hfY2dyb3Vwc19zdHJ1Y3QgYXR0YWNoOwo+Cj4gICAgICAgICAgICAgICAgICAgICAgYXR0YWNo
Lm93bmVyID0gY3VycmVudDsKPiAgICAgICAgICAgICAgICAgICAgICB2aG9zdF93b3JrX2luaXQo
JmF0dGFjaC53b3JrLAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZob3N0
X2F0dGFjaF9jZ3JvdXBzX3dvcmspOwo+ICAgICAgICAgICAgICAgICAgICAgIHZob3N0X3dvcmtf
cXVldWUoZGV2LCAmYXR0YWNoLndvcmspOyAvLyBhZGQgY2dyb3VwCj4gYXR0YWNoIHdvcmsKPiAg
ICAgICAgICAgICAgICAgICAgICB2aG9zdF93b3JrX2Rldl9mbHVzaChkZXYpOyAgICAgICAgICAg
Ly8gYWRkIGRldgo+IGZsdXNoIHdvcmsKPiAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gYXR0
YWNoLnJldDsKPiAgICAgICAgICAgICAgfQo+Cj4gICAgQW5kIGRldiBrd29ya2VyIHdpbGwgYmUg
d2FrZW4gdXAgdG8gaGFuZGxlIHRoZSB0d28gd29ya3MgaW4KPiB2aG9zdF93b3JrZXIoKToKPiAg
ICAgICAgICAgICAgbm9kZSA9IGxsaXN0X2RlbF9hbGwoJmRldi0+d29ya19saXN0KTsKPiAgICAg
ICAgICAgICAgbm9kZSA9IGxsaXN0X3JldmVyc2Vfb3JkZXIobm9kZSk7Cj4gICAgICAgICAgICAg
IGxsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmV7Cj4gICAgICAgICAgICAgICAgICAgICAgd29yay0+
Zm4od29yayk7Cj4gICAgICAgICAgICAgIH0KPgo+ICAgIEFzIHRoZSBsaXN0IGlzIHJldmVyc2Vk
IGJlZm9yZSBwcm9jZXNzaW5nIGluIHZob3N0X3dvcmtlcigpLCBzbyBpdCBpcwo+IHBvc3NpYmxl
Cj4gICAgdGhhdCBkZXYgZmx1c2ggd29yayBpcyBwcm9jZXNzZWQgYmVmb3JlIGNncm91cCBhdHRh
Y2ggd29yay4KClRoaXMgc291bmRzIHdlaXJkLiBJdCdzIGxsaXN0IG5vdCBsaXN0IHNvIHdoZW4g
YWRkaW5nIHRoZSBuZXcgZW50cnkKd2FzIGFkZGVkIHRvIHRoZSBoZWFkIHRoYXQgd2h5IHdlIG5l
ZWQgbGxpc3RfcmV2ZXJzZV9vcmRlcigpIHRvCnJlY292ZXIgdGhlIG9yZGVyLgoKIEhhdmUgeW91
IGV2ZXIgcmVwcm9kdWNlZCB0aGVzZSBpc3N1ZXM/CgpUaGFua3MKCj4gSWYgc28sCj4gdmhvc3Rf
YXR0YWNoX2Nncm91cHMKPiAgICBtYXkgcmV0dXJuICJhdHRhY2gucmV0IiBiZWZvcmUgY2dyb3Vw
IGF0dGFjaCB3b3JrIGlzIGhhbmRsZWQsIGJ1dAo+ICJhdHRhY2gucmV0IiBpcyByYW5kb20KPiAg
ICB2YWx1ZSBhcyBpdCBpcyBpbiBzdGFjay4KPgo+IFRoZSBwb3NzaWJsZSBmaXggbWF5YmU6Cj4K
PiBzdGF0aWMgaW50IHZob3N0X2F0dGFjaF9jZ3JvdXBzKHN0cnVjdCB2aG9zdF9kZXYgKmRldikK
PiB7Cj4gICAgICAgICAgc3RydWN0IHZob3N0X2F0dGFjaF9jZ3JvdXBzX3N0cnVjdCBhdHRhY2g7
Cj4KPiAgICAgICAgICBhdHRhY2gucmV0ID0gMDsKPiAgICAgICAgICBhdHRhY2gub3duZXIgPSBj
dXJyZW50Owo+ICAgICAgICAgIHZob3N0X3dvcmtfaW5pdCgmYXR0YWNoLndvcmssIHZob3N0X2F0
dGFjaF9jZ3JvdXBzX3dvcmspOwo+ICAgICAgICAgIHZob3N0X3dvcmtfcXVldWUoZGV2LCAmYXR0
YWNoLndvcmspOwo+ICAgICAgICAgIHZob3N0X3dvcmtfZGV2X2ZsdXNoKGRldik7Cj4gICAgICAg
ICAgcmV0dXJuIGF0dGFjaC5yZXQ7Cj4gfQo+Cj4gICBTbyB0aGlzIGZpeCBpcyBqdXN0IHRvIGlu
aXRpYWxpemUgdGhlIGF0dGFjaC5yZXQgdG8gMCwgdGhpcyBmaXggbWF5Cj4gbm90IHRoZSBmaW5h
bCBmaXgsCj4gICBXZSBqdXN0IHdhbnQgeW91IGV4cGVydHMga25vdyB0aGlzIGlzc3VlIGV4aXN0
cywgYW5kIHdlIG1ldCBpdAo+IHJlY2VudGx5IGluIG91ciB0ZXN0Lgo+Cj4gQW5kIHRoZSBpc3N1
ZSBleGlzdHMgaW4gbWF5IHN0YWJsZSBicmFuY2hlcy4KPgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
