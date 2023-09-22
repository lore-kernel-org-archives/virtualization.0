Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E9AC5CD4F2B
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 07:32:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 6888F40445;
	Fri, 22 Sep 2023 07:32:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 6888F40445
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bBD/A3GB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id gLImibwYF3Dc; Fri, 22 Sep 2023 07:32:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E89144051B;
	Fri, 22 Sep 2023 07:32:56 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E89144051B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDADCC0039;
	Fri, 22 Sep 2023 07:32:56 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1F112C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 07:32:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id ED5E34051B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 07:32:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org ED5E34051B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uM5mfyM9SFiT
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 07:32:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1311140445
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 07:32:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1311140445
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695367974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Tzr3g+o0PnLeNXLEdamJy2Bw5jLEtdPdZyLAQvEL1xg=;
 b=bBD/A3GBGSJ/r/oLnZ9NOR+CPbZwmdwcQ4JZzlQYRcmZKfoBjg1RfPhXx/E7oEW6dVKDgD
 i6YRdS7UuZYihwrDwxDtg3Hf89U7PYG7rkFF0ij6BBNtCHWDa0AUgnHUvuFxn3Es5iaKSi
 RSXyGroB4XCtYyytlFaHGsxxa31XXLo=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-292-ORViqJZQNVKO0RiamOvuNw-1; Fri, 22 Sep 2023 03:32:52 -0400
X-MC-Unique: ORViqJZQNVKO0RiamOvuNw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5043353efbdso1330635e87.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 00:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695367971; x=1695972771;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=Tzr3g+o0PnLeNXLEdamJy2Bw5jLEtdPdZyLAQvEL1xg=;
 b=JzwgvL/QJZV1q9mkar5fVVhK7rqzz+R1orGM1BkJPUoV9CSTHfNiMJgSlCXwJleTC+
 N5qGNzCDwfygrhiE6A2G70oS/BhAUFVyhFT673PiH3k1YsjQvYYA4cT74MuF0vymcasI
 er1nI8uXuURL6UcgneZOP/Boopsdp9MWHYB2FJ2MtGlw5ZHbCXJuJFKVMpx66UAXrFLJ
 DLtMzb49uLVcWOPz387sfapzX9v1VxxFWQtvcZps8M8509VPomI735tOQVdDeHNMhPsM
 KV7YK9kvZ4vS3nNzPfM0IY8gYVtsCVJc474gJa6dQTLlj2+Q4rU0yDP0Nj/GPT5N9a/F
 kMWA==
X-Gm-Message-State: AOJu0YzIClHROwG4xRfYepj6L022Qc2Czg9Gza4tICQTjJrtudRK3Dv/
 sG//MKc5rEgKuhS9VLQcsilXhj2af8+iVjib0r7QLFNnEHX7A8XGKemm9dLN6tS7NYOnLJOvHtz
 GQ+1EaUoPAeu+93MqUqInl3EepJbQenm6a+WBpWBVvpVrq2eH27lT6khTvQ==
X-Received: by 2002:a19:2d07:0:b0:500:b287:36df with SMTP id
 k7-20020a192d07000000b00500b28736dfmr5361686lfj.13.1695367970990; 
 Fri, 22 Sep 2023 00:32:50 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFy16pWqgvltN1cDWNjeFFE3BiZ1KvAGSDhVysKhX9y39Onk7+lmcv4zcetBWCyZHAvhyRWEncU3uPULogttdM=
X-Received: by 2002:a19:2d07:0:b0:500:b287:36df with SMTP id
 k7-20020a192d07000000b00500b28736dfmr5361663lfj.13.1695367970673; Fri, 22 Sep
 2023 00:32:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230919074915.103110-1-hengqi@linux.alibaba.com>
 <20230919074915.103110-6-hengqi@linux.alibaba.com>
 <CACGkMEuJjxAmr6WC9ETYAw2K9dp0AUoD6LSZCduQyUQ9y7oM3Q@mail.gmail.com>
 <c95274cd-d119-402b-baf1-0c500472c9fb@linux.alibaba.com>
In-Reply-To: <c95274cd-d119-402b-baf1-0c500472c9fb@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Sep 2023 15:32:39 +0800
Message-ID: <CACGkMEv4me_mjRJ8wEd-w_b9tjo370d6idioCTmFwJo-3TH3-A@mail.gmail.com>
Subject: Re: [PATCH net 5/6] virtio-net: fix the vq coalescing setting for vq
 resize
To: Heng Qi <hengqi@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>,
 Daniel Borkmann <daniel@iogearbox.net>, "Michael S . Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, John Fastabend <john.fastabend@gmail.com>,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, "David S . Miller" <davem@davemloft.net>,
 Gavin Li <gavinl@nvidia.com>
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

T24gRnJpLCBTZXAgMjIsIDIwMjMgYXQgMTowMuKAr1BNIEhlbmcgUWkgPGhlbmdxaUBsaW51eC5h
bGliYWJhLmNvbT4gd3JvdGU6Cj4KPgo+Cj4g5ZyoIDIwMjMvOS8yMiDkuIvljYgxMjoyOSwgSmFz
b24gV2FuZyDlhpnpgZM6Cj4gPiBPbiBUdWUsIFNlcCAxOSwgMjAyMyBhdCAzOjQ54oCvUE0gSGVu
ZyBRaSA8aGVuZ3FpQGxpbnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPiA+PiBBY2NvcmRpbmcgdG8g
dGhlIGRlZmluaXRpb24gb2YgdmlydHF1ZXVlIGNvYWxlc2Npbmcgc3BlY1sxXToKPiA+Pgo+ID4+
ICAgIFVwb24gZGlzYWJsaW5nIGFuZCByZS1lbmFibGluZyBhIHRyYW5zbWl0IHZpcnRxdWV1ZSwg
dGhlIGRldmljZSBNVVNUIHNldAo+ID4+ICAgIHRoZSBjb2FsZXNjaW5nIHBhcmFtZXRlcnMgb2Yg
dGhlIHZpcnRxdWV1ZSB0byB0aG9zZSBjb25maWd1cmVkIHRocm91Z2ggdGhlCj4gPj4gICAgVklS
VElPX05FVF9DVFJMX05PVEZfQ09BTF9UWF9TRVQgY29tbWFuZCwgb3IsIGlmIHRoZSBkcml2ZXIg
ZGlkIG5vdCBzZXQKPiA+PiAgICBhbnkgVFggY29hbGVzY2luZyBwYXJhbWV0ZXJzLCB0byAwLgo+
ID4+Cj4gPj4gICAgVXBvbiBkaXNhYmxpbmcgYW5kIHJlLWVuYWJsaW5nIGEgcmVjZWl2ZSB2aXJ0
cXVldWUsIHRoZSBkZXZpY2UgTVVTVCBzZXQKPiA+PiAgICB0aGUgY29hbGVzY2luZyBwYXJhbWV0
ZXJzIG9mIHRoZSB2aXJ0cXVldWUgdG8gdGhvc2UgY29uZmlndXJlZCB0aHJvdWdoIHRoZQo+ID4+
ICAgIFZJUlRJT19ORVRfQ1RSTF9OT1RGX0NPQUxfUlhfU0VUIGNvbW1hbmQsIG9yLCBpZiB0aGUg
ZHJpdmVyIGRpZCBub3Qgc2V0Cj4gPj4gICAgYW55IFJYIGNvYWxlc2NpbmcgcGFyYW1ldGVycywg
dG8gMC4KPiA+Pgo+ID4+IFdlIG5lZWQgdG8gYWRkIHRoaXMgc2V0dGluZyBmb3IgdnEgcmVzaXpl
IChldGh0b29sIC1HKSB3aGVyZSB2cV9yZXNldCBoYXBwZW5zLgo+ID4+Cj4gPj4gWzFdIGh0dHBz
Oi8vbGlzdHMub2FzaXMtb3Blbi5vcmcvYXJjaGl2ZXMvdmlydGlvLWRldi8yMDIzMDMvbXNnMDA0
MTUuaHRtbAo+ID4+Cj4gPj4gRml4ZXM6IDM5NGJkODc3NjRiNiAoInZpcnRpb19uZXQ6IHN1cHBv
cnQgcGVyIHF1ZXVlIGludGVycnVwdCBjb2FsZXNjZSBjb21tYW5kIikKPiA+IEknbSBub3Qgc3Vy
ZSB0aGlzIGlzIGEgcmVhbCBmaXggYXMgc3BlYyBhbGxvd3MgaXQgdG8gZ28gemVybz8KPgo+IFRo
ZSBzcGVjIHNheXMgdGhhdCBpZiB0aGUgdXNlciBoYXMgY29uZmlndXJlZCBpbnRlcnJ1cHQgY29h
bGVzY2luZwo+IHBhcmFtZXRlcnMsCj4gcGFyYW1ldGVycyBuZWVkIHRvIGJlIHJlc3RvcmVkIGFm
dGVyIHZxX3Jlc2V0LCBvdGhlcndpc2Ugc2V0IHRvIDAuCj4gdmktPmludHJfY29hbF90eCBhbmQg
dmktPmludHJfY29hbF9yeCBhbHdheXMgc2F2ZSB0aGUgbmV3ZXN0IGdsb2JhbAo+IHBhcmFtZXRl
cnMsCj4gcmVnYXJkbGVzcyBvZiB3aGV0aGVyIHRoZSBjb21tYW5kIGlzIHNlbnQgb3Igbm90LiBT
byBJIHRoaW5rIHdlIG5lZWQKPiB0aGlzIHBhdGNoCj4gaXQgY29tcGxpZXMgd2l0aCB0aGUgc3Bl
Y2lmaWNhdGlvbiByZXF1aXJlbWVudHMuCgpIb3cgY2FuIHdlIG1ha2Ugc3VyZSB0aGUgb2xkIGNv
YWxlc2NpbmcgcGFyYW1ldGVycyBzdGlsbCBtYWtlIHNlbnNlCmZvciB0aGUgbmV3IHJpbmcgc2l6
ZT8KClRoYW5rcwoKPgo+IFRoYW5rcyEKPgo+ID4KPiA+IFRoYW5rcwo+CgpfX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5n
IGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9s
aXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
