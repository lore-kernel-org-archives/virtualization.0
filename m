Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AD194E7D0C9
	for <virtualization@archiver.kernel.org>; Fri, 22 Sep 2023 04:30:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 42DAC60E76;
	Fri, 22 Sep 2023 04:30:08 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 42DAC60E76
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=eizOZpAI
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id C-GfOWJdNAxm; Fri, 22 Sep 2023 04:30:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id B5CE960BAD;
	Fri, 22 Sep 2023 04:30:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B5CE960BAD
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8FA2FC0071;
	Fri, 22 Sep 2023 04:30:06 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 52714C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 04:30:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 28D5060E76
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 04:30:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 28D5060E76
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZgOSNjsZeBB1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 04:30:04 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3C03860BAD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 22 Sep 2023 04:30:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3C03860BAD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1695357003;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=/PovTQ/TL3i7ChhoR7kfzCjbbZuEsG+sEWglXJvK9wg=;
 b=eizOZpAIRBadLeMLLCFo1RQUYNQeRtrFS1a10jGu6EJe1gsq2W/VVbIXmwqS741voj2iWg
 65RrSaMVZ/CT3iW2IpwW+Rjf5o2GEO/UxgDz1uw52BlGUzdhOeDdZC3bhxcLpshVmaFhnj
 1QkLYLzYGQqJNsUW328Hhg8fDalkfbg=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-180-v3t_FBMuP16TGxwAksTfCw-1; Fri, 22 Sep 2023 00:30:01 -0400
X-MC-Unique: v3t_FBMuP16TGxwAksTfCw-1
Received: by mail-lf1-f70.google.com with SMTP id
 2adb3069b0e04-5043c0cbb62so229435e87.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 21 Sep 2023 21:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1695357000; x=1695961800;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=/PovTQ/TL3i7ChhoR7kfzCjbbZuEsG+sEWglXJvK9wg=;
 b=gI7AvdnWsloeC7o+TjsQPRLP1yaodbVuje9tzzjYnLjOCaCtbf4hGb0hOa++0ZBVjF
 7x7WdmY5U2Wa3D0pjY6CF4bhcS1uO/38fCbWv+p0JucuoTQYa4rojH/Jk4q/K8LkuyW3
 7EhDQmYnQrz/tAlGIdOOrMMtSIyZw75FeRGs/PpVHz4z/8gb/lWTxXTMY7PpoFHCJ8/R
 N2MjEfHpEA2YYFOZyh/6dWbLigEHxM8yLMYf286hvfiq07sRDPuWKrWc6RhxQMeXYkfz
 mKRIHLoXWrv4Xjsu0MRoueCrEAyeDmHIWtKZst7XBG9UX1wbvjha/c9g+5ce6u0ebARw
 9BBg==
X-Gm-Message-State: AOJu0Yy88FdZUEvyXgHk7FQKDGZFV9OGC0TAf2DKUw0vAaJmd+84A5mZ
 goXQG7NuUHL7OfNye+h50BOYTrZd4QbpaLEO8r+BzzZczn5tOy43oIOaH5jlVXEWPlLrSiXqD+T
 hh1uBqyE1Y7IPRSq48gQ6xCJ1wQs4S8svHQ5g0y7zKl48O3SdONG3evx4QQ==
X-Received: by 2002:a19:4f4a:0:b0:4fe:7dcc:3dc1 with SMTP id
 a10-20020a194f4a000000b004fe7dcc3dc1mr5891766lfk.44.1695356999994; 
 Thu, 21 Sep 2023 21:29:59 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGVvXfqPY1fkr32aVf5UzABAZ8T9fCp6I6p9I62s9MuBKjaJsIAKr6jxsKfv0X+Ug0nDHEOxO8gVauzlLE8VSI=
X-Received: by 2002:a19:4f4a:0:b0:4fe:7dcc:3dc1 with SMTP id
 a10-20020a194f4a000000b004fe7dcc3dc1mr5891746lfk.44.1695356999730; Thu, 21
 Sep 2023 21:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230919074915.103110-1-hengqi@linux.alibaba.com>
 <20230919074915.103110-6-hengqi@linux.alibaba.com>
In-Reply-To: <20230919074915.103110-6-hengqi@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 22 Sep 2023 12:29:47 +0800
Message-ID: <CACGkMEuJjxAmr6WC9ETYAw2K9dp0AUoD6LSZCduQyUQ9y7oM3Q@mail.gmail.com>
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

T24gVHVlLCBTZXAgMTksIDIwMjMgYXQgMzo0OeKAr1BNIEhlbmcgUWkgPGhlbmdxaUBsaW51eC5h
bGliYWJhLmNvbT4gd3JvdGU6Cj4KPiBBY2NvcmRpbmcgdG8gdGhlIGRlZmluaXRpb24gb2Ygdmly
dHF1ZXVlIGNvYWxlc2Npbmcgc3BlY1sxXToKPgo+ICAgVXBvbiBkaXNhYmxpbmcgYW5kIHJlLWVu
YWJsaW5nIGEgdHJhbnNtaXQgdmlydHF1ZXVlLCB0aGUgZGV2aWNlIE1VU1Qgc2V0Cj4gICB0aGUg
Y29hbGVzY2luZyBwYXJhbWV0ZXJzIG9mIHRoZSB2aXJ0cXVldWUgdG8gdGhvc2UgY29uZmlndXJl
ZCB0aHJvdWdoIHRoZQo+ICAgVklSVElPX05FVF9DVFJMX05PVEZfQ09BTF9UWF9TRVQgY29tbWFu
ZCwgb3IsIGlmIHRoZSBkcml2ZXIgZGlkIG5vdCBzZXQKPiAgIGFueSBUWCBjb2FsZXNjaW5nIHBh
cmFtZXRlcnMsIHRvIDAuCj4KPiAgIFVwb24gZGlzYWJsaW5nIGFuZCByZS1lbmFibGluZyBhIHJl
Y2VpdmUgdmlydHF1ZXVlLCB0aGUgZGV2aWNlIE1VU1Qgc2V0Cj4gICB0aGUgY29hbGVzY2luZyBw
YXJhbWV0ZXJzIG9mIHRoZSB2aXJ0cXVldWUgdG8gdGhvc2UgY29uZmlndXJlZCB0aHJvdWdoIHRo
ZQo+ICAgVklSVElPX05FVF9DVFJMX05PVEZfQ09BTF9SWF9TRVQgY29tbWFuZCwgb3IsIGlmIHRo
ZSBkcml2ZXIgZGlkIG5vdCBzZXQKPiAgIGFueSBSWCBjb2FsZXNjaW5nIHBhcmFtZXRlcnMsIHRv
IDAuCj4KPiBXZSBuZWVkIHRvIGFkZCB0aGlzIHNldHRpbmcgZm9yIHZxIHJlc2l6ZSAoZXRodG9v
bCAtRykgd2hlcmUgdnFfcmVzZXQgaGFwcGVucy4KPgo+IFsxXSBodHRwczovL2xpc3RzLm9hc2lz
LW9wZW4ub3JnL2FyY2hpdmVzL3ZpcnRpby1kZXYvMjAyMzAzL21zZzAwNDE1Lmh0bWwKPgo+IEZp
eGVzOiAzOTRiZDg3NzY0YjYgKCJ2aXJ0aW9fbmV0OiBzdXBwb3J0IHBlciBxdWV1ZSBpbnRlcnJ1
cHQgY29hbGVzY2UgY29tbWFuZCIpCgpJJ20gbm90IHN1cmUgdGhpcyBpcyBhIHJlYWwgZml4IGFz
IHNwZWMgYWxsb3dzIGl0IHRvIGdvIHplcm8/CgpUaGFua3MKCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
