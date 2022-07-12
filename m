Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D989C433EF
	for <virtualization@archiver.kernel.org>; Tue, 12 Jul 2022 08:47:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A4BD840BF2;
	Tue, 12 Jul 2022 08:47:34 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A4BD840BF2
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DC4znlOf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 9RdgVxy3ZNpi; Tue, 12 Jul 2022 08:47:33 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 27AFA4013E;
	Tue, 12 Jul 2022 08:47:33 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 27AFA4013E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0BDFEC0033;
	Tue, 12 Jul 2022 08:47:33 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 080A3C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 08:47:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C7C51401AF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 08:47:31 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org C7C51401AF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2OcvxGJrTbUd
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 08:47:31 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 12C914013E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 12C914013E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 08:47:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1657615649;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=BFx5AQzR7h3bQjJMbiVLhXeoM+srJi8z6QukiQafwV0=;
 b=DC4znlOf5YD53a1a3nNUohpa7uXEuPubcSTUur5rNkXo867YPcLHeFG0zwFZbinrtrl87O
 5C/jLkW9rwyPZDBB8x4SEbwVKj6avE5YMc6AF0z4k3Fs4pSEZN8Wvoxpsy/c0jOpBziUFI
 g85vKNncPREKlz6Tdays6ltQ0XixhXA=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-122-DPhbAHhbM0GuRD46s3HgRA-1; Tue, 12 Jul 2022 04:47:22 -0400
X-MC-Unique: DPhbAHhbM0GuRD46s3HgRA-1
Received: by mail-lj1-f199.google.com with SMTP id
 z23-20020a2e9b97000000b0025d7496a2f2so584962lji.15
 for <virtualization@lists.linux-foundation.org>;
 Tue, 12 Jul 2022 01:47:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=BFx5AQzR7h3bQjJMbiVLhXeoM+srJi8z6QukiQafwV0=;
 b=VP7WXdmLbPWZrU8VKVddr0GJERwWN3DbbMXAmzzrJkanZhjXSD2laVdWuUH8BqY6TS
 ROh+M1eEA15eF4t9ijMVge4/dzDXbuaPl1rJ6Ffr6QB0WlI6kCZJuYgToPkyPQ1keGCr
 2EqzcrjgYrWCp4CDDcmHLF7EsRR+u5MotxdztHJsUZU64j7J+daPRUYCM8slMiwqXMKI
 ZGtYtyJZKlBj7ZKJnDfdKcft7ELE3z4mL01Kuq6IMdBOO8B3/tABKScrDoOZuj/ROxq3
 HkvzG0sTEeeNqXNt5ZrhxLlwqGyyr+4Q+ofFqUNUqrtNxaisUNa/4MlONU1ai0aIVhK9
 wX6g==
X-Gm-Message-State: AJIora+fXgwXPI7BLk7+RrZ8FSWP7tuTkkVQSfAMdCjwP/9vpOeRUkAb
 XDAqsx11/G7+AFbMFDGhAz563VxsGW6mvgoMJVulzwM9+DsUcubFRHaXc2Yzemu6PhzzETOLPbF
 plOHHB8YSAzP4HdMV+9VpuCH1ftPu6kZQ9Mwf8hQcUkYdYqZPnXA9D3Kp/A==
X-Received: by 2002:a05:6512:313a:b0:489:caea:7e27 with SMTP id
 p26-20020a056512313a00b00489caea7e27mr11455305lfd.397.1657615641370; 
 Tue, 12 Jul 2022 01:47:21 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1sXhpc5o+rvK1UHCWXYwhf4wkAETF55+sjTRPwgsh/1P4a0/YwnVXRM672RK8JSJyU587qlqVrOXuzz/xxN48g=
X-Received: by 2002:a05:6512:313a:b0:489:caea:7e27 with SMTP id
 p26-20020a056512313a00b00489caea7e27mr11455296lfd.397.1657615641163; Tue, 12
 Jul 2022 01:47:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220704171701.127665-1-sgarzare@redhat.com>
 <a94ec2f5-8728-d62a-072e-407fbe59eb61@redhat.com>
 <20220712084544.lgtggj44ihlkfsb3@sgarzare-redhat>
In-Reply-To: <20220712084544.lgtggj44ihlkfsb3@sgarzare-redhat>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 12 Jul 2022 16:47:10 +0800
Message-ID: <CACGkMEtHg_EVYcS=Qxsmwq3t+96E8LNqa5Ck1Gi4hJs2AJ0F+Q@mail.gmail.com>
Subject: Re: [RFC PATCH 0/6] virtio_test: add support for vhost-vdpa
To: Stefano Garzarella <sgarzare@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

T24gVHVlLCBKdWwgMTIsIDIwMjIgYXQgNDo0NiBQTSBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6
YXJlQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gVHVlLCBKdWwgMTIsIDIwMjIgYXQgMDQ6MzQ6
MTFQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+Cj4gPuWcqCAyMDIyLzcvNSAwMToxNiwg
U3RlZmFubyBHYXJ6YXJlbGxhIOWGmemBkzoKPiA+PlRoZSBmaXJzdCAzIHBhdGNoZXMgZml4IHZh
cmlvdXMgcHJvYmxlbXMgSSBoYXZlIGVuY291bnRlcmVkIHdpdGgKPiA+PnZpcnRpb190ZXN0ICh0
aGV5IG1heSBnbyB3aXRob3V0IHRoaXMgc2VyaWVzLCBidXQgSSBpbmNsdWRlZCB0byBhbGxvdyB5
b3UKPiA+PnRvIHRlc3QgdGhlIHNlcmllcykuCj4gPj4KPiA+PlBhdGNoIDQgaXMgaW4gcHJlcGFy
YXRpb24gb2YgcGF0Y2ggNSwgbW92aW5nIHRoZSBmZWF0dXJlIG5lZ290aWF0aW9uIHdoZW4KPiA+
PndlIGluaXRpYWxpemUgdGhlIGRldmljZS4KPiA+Pgo+ID4+UGF0Y2ggNSBhZGQgdGhlIHN1cHBv
cnQgb2Ygdmhvc3QtdmRwYSBpbiB2aXJ0aW9fdGVzdAo+ID4+Cj4gPj5QYXRjaCA2IGFkZCB2ZHBh
X3Rlc3Qua28gYmFzZWQgb24gdmRwYV9zaW1fdGVzdC5jLCBzbyB3ZSBjYW4gcmV1c2UgbW9zdCBv
Zgo+ID4+dGhlIGNvZGUgY29taW5nIGZyb20gdGhlIHZkcGFfc2ltIGZyYW1ld29yay4KPiA+Pgo+
ID4+SSB0ZXN0ZWQgaW4gdGhpcyB3YXk6Cj4gPj4KPiA+PiAgICQgbW9kcHJvYmUgdmRwYV9zaW0K
PiA+PiAgICQgbW9kcHJvYmUgdmhvc3QtdmRwYQo+ID4+Cj4gPj4gICAjIGxvYWQgdGhlIHZkcGFz
aW1fdGVzdCBkZXZpY2UKPiA+PiAgICQgaW5zbW9kIHZkcGFfdGVzdC5rbwo+ID4+Cj4gPj4gICAj
IGNyZWF0ZSBhIG5ldyB2ZHBhc2ltX3Rlc3QgZGV2aWNlCj4gPj4gICAkIHZkcGEgZGV2IGFkZCBt
Z210ZGV2IHZkcGFzaW1fdGVzdCBuYW1lIGRldjAKPiA+Cj4gPgo+ID5JIHdvbmRlciB3aGF0J3Mg
dGhlIGJlbmVmaXQgb2YgdXNpbmcgYSBkZWRpY2F0ZWQgdGVzdCBkZXZpY2Ugb3RoZXIKPiA+dGhh
biBuZXR3b3JraW5nPyAoYWxyZWFkeSBhIGxvb3BiYWNrIGRldmljZSBhbnlob3cpLgo+ID4KPgo+
IFRoZSBtYWluIGFkdmFudGFnZSBJIHdhcyB0aGlua2luZyBpcyB0aGF0IHdlIGNhbiBleHRlbmQg
aXQgYXQgd2lsbCB0bwo+IHRyeSB0byBjb3ZlciBhcyBtdWNoIGFzIHBvc3NpYmxlIGFsbCB0aGUg
cGF0aHMgdGhhdCBtYXliZSB3aXRoIG5ldCB3ZQo+IGNhbid0IChpbmRpcmVjdCwgcmVzZXQsIGV0
Yy4pLgo+Cj4gUGx1cyBpdCBzaG91bGQgYmUgZWFzaWVyIHRvIHRlc3Qgdmhvc3QtdmRwYSB0aGlz
IHdheSB3aXRob3V0IHVzaW5nIFFFTVUuCj4KPiBEbyB5b3UgdGhpbmsgdGhpcyBpcyByZWR1bmRh
bnQ/CgpJdCdzIHByb2JhYmx5IGZpbmUgYW5kIGl0IG1pZ2h0IGJlIGJldHRlciB0byBkZXNjcmli
ZSB0aGUgcmVhc29uIGluCnRoZSBjaGFuZ2Vsb2cuCgpUSGFua3MKCj4KPiBUaGFua3MsCj4gU3Rl
ZmFubwo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
