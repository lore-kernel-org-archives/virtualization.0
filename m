Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66D22C38142
	for <virtualization@archiver.kernel.org>; Thu, 19 Jan 2023 03:20:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id E0B0D82236;
	Thu, 19 Jan 2023 03:20:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org E0B0D82236
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=HggAHTYv
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3RK9IKXCxtgc; Thu, 19 Jan 2023 03:20:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 2D424821CA;
	Thu, 19 Jan 2023 03:20:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2D424821CA
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0E5DFC0033;
	Thu, 19 Jan 2023 03:20:52 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEA42C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 03:20:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id CFB0A82213
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 03:20:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org CFB0A82213
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4bLvnb_Ag3ON
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 03:20:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 1C91E821CA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 1C91E821CA
 for <virtualization@lists.linux-foundation.org>;
 Thu, 19 Jan 2023 03:20:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1674098448;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YyFYcgF+DoIeKq7lb/Kzjd5+kevHUn58LqiJELqcxVU=;
 b=HggAHTYvWOjFu96i50z92dzM6Y4piKa50chpjrfDDgT/W3WVgJMqI/f+zrAdRX+kRzMR2Q
 MerllnX1IfvY6hG1dTicoZnod4l2JSGeL24gma2Jgu8JS1R9eG/z7fwlH24NKSdm+in5d1
 qrGgLyqPeL7x8w639dRDuyU1z0q+OIY=
Received: from mail-ot1-f69.google.com (mail-ot1-f69.google.com
 [209.85.210.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-589-5sjzvTS4MEOAYUOXDoggKQ-1; Wed, 18 Jan 2023 22:20:47 -0500
X-MC-Unique: 5sjzvTS4MEOAYUOXDoggKQ-1
Received: by mail-ot1-f69.google.com with SMTP id
 46-20020a9d0331000000b00684ce0aa309so441539otv.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 18 Jan 2023 19:20:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=YyFYcgF+DoIeKq7lb/Kzjd5+kevHUn58LqiJELqcxVU=;
 b=xaZS6s0jFoxyMTeePvA5y5hhAEIOPfeOEraqrnkrtJpeVNwB5XUHD0YceA5iEWvs3q
 Zg6EiobeDDIgMjdG5OQE8gf+yg3a8ruydPcNWbb5qWXsBoomb9IeiUkGfIU8ESdUKZ0A
 MmkqmCeab3N6YbgmbUsyyhXL2KSS+uRjmN9aJ5DKyG4ETWjU3Ul3p4Pp8fff4Vt/FmiS
 QPXx1EYNC/616tXv83kIlKKxsiWUt6xxAB0qn+1djKwc109GV/GWEhgvB9enquO92b78
 Eq6DLBUnr0ZJ4GbF09mJ1sdOETRDXi7ZpLWROcO6dKe6+O6AQXfnh9k7ZmjYZe+LMA7I
 mAlA==
X-Gm-Message-State: AFqh2koE9kCHoCJTCnqz4PvBrs/8G5PEJpqOI2CoYdMP1e5WmBFAV6Ce
 so/fZ+ePCqYU9zqH5jQ3Tacy4++bk/n8X0SMfsFp0BAhVCDfIcJyCRFOoWEYw4GkAvg9YTfO5b6
 3gRwQegdglkDjZS13iwyIdfFTpaOlQ2MWWCT2lk43ZqFiZHYlD4UFGU3+Ew==
X-Received: by 2002:a05:6870:6a91:b0:144:a97b:1ae2 with SMTP id
 mv17-20020a0568706a9100b00144a97b1ae2mr593136oab.35.1674098447067; 
 Wed, 18 Jan 2023 19:20:47 -0800 (PST)
X-Google-Smtp-Source: AMrXdXtfPFuvSb1t3TeMovFK0J7New906+HRjOCUmcjVVqeG2vnLs69/M1W/0HSaALtkgqmNSJQUc+ZcxfnZmvsy7G8=
X-Received: by 2002:a05:6870:6a91:b0:144:a97b:1ae2 with SMTP id
 mv17-20020a0568706a9100b00144a97b1ae2mr593124oab.35.1674098446850; Wed, 18
 Jan 2023 19:20:46 -0800 (PST)
MIME-Version: 1.0
References: <20230118164359.1523760-1-eperezma@redhat.com>
 <20230118164359.1523760-3-eperezma@redhat.com>
In-Reply-To: <20230118164359.1523760-3-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 19 Jan 2023 11:20:35 +0800
Message-ID: <CACGkMEtq_ZOoLaS=vGYPZUc45oP8ENa+5H1KVCF1NS=-SwuPQw@mail.gmail.com>
Subject: Re: [PATCH 2/2] vringh: fetch used_idx from vring at vringh_init_iotlb
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
QHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gU3RhcnRpbmcgZnJvbSBhbiB1c2VkX2lkeCBkaWZmZXJl
bnQgdGhhbiAwIGlzIG5lZWRlZCBpbiB1c2UgY2FzZXMgbGlrZQo+IHZpcnR1YWwgbWFjaGluZSBt
aWdyYXRpb24uICBOb3QgZG9pbmcgc28gYW5kIGxldHRpbmcgdGhlIGNhbGxlciBzZXQgYW4KPiBh
dmFpbCBpZHggZGlmZmVyZW50IHRoYW4gMCBjYXVzZXMgZGVzdGluYXRpb24gZGV2aWNlIHRvIHRy
eSB0byB1c2Ugb2xkCj4gYnVmZmVycyB0aGF0IHNvdXJjZSBkcml2ZXIgYWxyZWFkeSByZWNvdmVy
IGFuZCBhcmUgbm90IGF2YWlsYWJsZQo+IGFueW1vcmUuCj4KPiBXaGlsZSBjYWxsZXJzIGxpa2Ug
dmRwYV9zaW0gc2V0IGF2YWlsX2lkeCBkaXJlY3RseSBpdCBkb2VzIG5vdCBzZXQKPiB1c2VkX2lk
eC4gIEluc3RlYWQgb2YgbGV0IHRoZSBjYWxsZXIgZG8gdGhlIGFzc2lnbm1lbnQsIGZldGNoIGl0
IGZyb20KPiB0aGUgZ3Vlc3QgYXQgaW5pdGlhbGl6YXRpb24gbGlrZSB2aG9zdC1rZXJuZWwgZG8u
Cj4KPiBUbyBwZXJmb3JtIHRoZSBzYW1lIGF0IHZyaW5nX2tlcm5lbF9pbml0IGFuZCB2cmluZ191
c2VyX2luaXQgaXMgbGVmdCBmb3IKPiB0aGUgZnV0dXJlLgo+Cj4gU2lnbmVkLW9mZi1ieTogRXVn
ZW5pbyBQw6lyZXogPGVwZXJlem1hQHJlZGhhdC5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvdmhvc3Qv
dnJpbmdoLmMgfCAyNSArKysrKysrKysrKysrKysrKysrKysrKy0tCj4gIDEgZmlsZSBjaGFuZ2Vk
LCAyMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmhvc3QvdnJpbmdoLmMgYi9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jCj4gaW5kZXggMzNlYjk0
MWZjZjE1Li4wZWVkODI1MTk3ZjIgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aG9zdC92cmluZ2gu
Ywo+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdnJpbmdoLmMKPiBAQCAtMTMwMSw2ICsxMzAxLDE3IEBA
IHN0YXRpYyBpbmxpbmUgaW50IHB1dHVzZWRfaW90bGIoY29uc3Qgc3RydWN0IHZyaW5naCAqdnJo
LAo+ICAgICAgICAgcmV0dXJuIDA7Cj4gIH0KPgo+ICsvKioKPiArICogdnJpbmdoX3VwZGF0ZV91
c2VkX2lkeCAtIGZldGNoIHVzZWQgaWR4IGZyb20gZHJpdmVyJ3MgdXNlZCBzcGxpdCB2cmluZwo+
ICsgKiBAdnJoOiBUaGUgdnJpbmcuCj4gKyAqCj4gKyAqIFJldHVybnMgLWVycm5vIG9yIDAuCj4g
KyAqLwo+ICtzdGF0aWMgaW5saW5lIGludCB2cmluZ2hfdXBkYXRlX3VzZWRfaWR4KHN0cnVjdCB2
cmluZ2ggKnZyaCkKPiArewo+ICsgICAgICAgcmV0dXJuIGdldHUxNl9pb3RsYih2cmgsICZ2cmgt
Pmxhc3RfdXNlZF9pZHgsICZ2cmgtPnZyaW5nLnVzZWQtPmlkeCk7Cj4gK30KPiArCj4gIC8qKgo+
ICAgKiB2cmluZ2hfaW5pdF9pb3RsYiAtIGluaXRpYWxpemUgYSB2cmluZ2ggZm9yIGEgcmluZyB3
aXRoIElPVExCLgo+ICAgKiBAdnJoOiB0aGUgdnJpbmdoIHRvIGluaXRpYWxpemUuCj4gQEAgLTEz
MTksOCArMTMzMCwxOCBAQCBpbnQgdnJpbmdoX2luaXRfaW90bGIoc3RydWN0IHZyaW5naCAqdnJo
LCB1NjQgZmVhdHVyZXMsCj4gICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2cmluZ19hdmFp
bCAqYXZhaWwsCj4gICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2cmluZ191c2VkICp1c2Vk
KQo+ICB7CgpXaGlsZSBhdCB0aGlzLCBJIHdvbmRlciBpZiBpdCdzIGJldHRlciB0byBoYXZlIGEg
ZGVkaWNhdGVkIHBhcmFtZXRlcgpmb3IgbGFzdF9hdmFpbF9pZHg/Cgo+IC0gICAgICAgcmV0dXJu
IHZyaW5naF9pbml0X2tlcm4odnJoLCBmZWF0dXJlcywgbnVtLCB3ZWFrX2JhcnJpZXJzLAo+IC0g
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZGVzYywgYXZhaWwsIHVzZWQpOwo+ICsgICAg
ICAgaW50IHIgPSB2cmluZ2hfaW5pdF9rZXJuKHZyaCwgZmVhdHVyZXMsIG51bSwgd2Vha19iYXJy
aWVycywgZGVzYywKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhdmFpbCwgdXNl
ZCk7Cj4gKwo+ICsgICAgICAgaWYgKHIgIT0gMCkKPiArICAgICAgICAgICAgICAgcmV0dXJuIHI7
Cj4gKwo+ICsgICAgICAgLyogQ29uc2lkZXIgdGhlIHJpbmcgbm90IGluaXRpYWxpemVkICovCj4g
KyAgICAgICBpZiAoKHZvaWQgKilkZXNjID09IHVzZWQpCj4gKyAgICAgICAgICAgICAgIHJldHVy
biAwOwoKSSBkb24ndCB1bmRlcnN0YW5kIHdoZW4gd2UgY2FuIGdldCB0aGlzIChhY3R1YWxseSBp
dCBzaG91bGQgYmUgYSBidWcKb2YgdGhlIGNhbGxlcikuCgpUaGFua3MKCj4gKwo+ICsgICAgICAg
cmV0dXJuIHZyaW5naF91cGRhdGVfdXNlZF9pZHgodnJoKTsKPiArCj4gIH0KPiAgRVhQT1JUX1NZ
TUJPTCh2cmluZ2hfaW5pdF9pb3RsYik7Cj4KPiAtLQo+IDIuMzEuMQo+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
