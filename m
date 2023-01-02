Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3D6DDC54E76
	for <virtualization@archiver.kernel.org>; Mon,  2 Jan 2023 11:55:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id AEFAC60E26;
	Mon,  2 Jan 2023 11:55:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AEFAC60E26
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=MqPHmPKK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XOQIUYtlni6Q; Mon,  2 Jan 2023 11:55:23 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0981C60A47;
	Mon,  2 Jan 2023 11:55:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0981C60A47
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DAC65C0033;
	Mon,  2 Jan 2023 11:55:22 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DCD52C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Jan 2023 11:55:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BDC9540256
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Jan 2023 11:55:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BDC9540256
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=MqPHmPKK
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U0XOxpGYu0ez
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Jan 2023 11:55:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B614040004
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B614040004
 for <virtualization@lists.linux-foundation.org>;
 Mon,  2 Jan 2023 11:55:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1672660517;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Eaac0zUTFuoCsKmnVZyZkkTalHPLFZnYU3aunXSpmFU=;
 b=MqPHmPKK5BZ0e1pZmUXX4bugeSttZh8WYJIjuVVfJf87CG2usETeKp2qedKFZTG2HqEz6L
 4pGDHLt7vFFQ0jUq/gKGb185RQzVbEMVa+GsjFlZKoTh3vpJS1LgVDdMPS7xbp1DJ3JgoX
 xB5kkQjEuhmrRX/+Z7CwRqtTETdO7hI=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-540-PJQLUKOQPS-5SJh6KIkxJw-1; Mon, 02 Jan 2023 06:55:16 -0500
X-MC-Unique: PJQLUKOQPS-5SJh6KIkxJw-1
Received: by mail-wm1-f71.google.com with SMTP id
 m38-20020a05600c3b2600b003d23f8c6ebdso10336262wms.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 02 Jan 2023 03:55:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:subject:organization:from
 :content-language:references:cc:to:user-agent:mime-version:date
 :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=Eaac0zUTFuoCsKmnVZyZkkTalHPLFZnYU3aunXSpmFU=;
 b=af50gT0ULsoIGAmh/WZO+7mgGmnRdhkfClYVVmX9wmYfR/21SeC/MelqEsEyFbd6ux
 S44tvytzcDQmiqU5itI1us+i63mZ5Y7MjiXTvw/kTyhgl9DYNs5ZwF2MnYjd1RjorIJ4
 ySBqDDzSxlXGWSQzE3s10XWIyJL+76tMbFzyOFfAmUcylkohOSAx9JOR7ZATx5srarun
 KEY2Iu+n/20F/3aRq4c/aDiEcBZTCI4jMDdpiugW61APPRcvJco8bUg+weg6ndQ3jncn
 ySUeYfA2LIFwlgAu7WHGKsYRilIikdlyeN9cnOe7Emo0NYtmiLQySZaUPYHlzoEcsnKe
 tUlw==
X-Gm-Message-State: AFqh2kqiwFZ0eBt7Wg28O43U9bhpzlr7h939Tb1zobl9gJmYaDNJqFjD
 iPnGXvgxqO14d2qCd74Iyq/ZPRtw1ot6Db3HTYdIYWAC97UdzRo6eS5NKWoE+kMYa7YMmYNAgJL
 yO/h1y2QafSqQZf1VGU3g5IZlaQm/R4X/gcOHxGg/IA==
X-Received: by 2002:a05:600c:21c1:b0:3d3:45c6:b641 with SMTP id
 x1-20020a05600c21c100b003d345c6b641mr29176985wmj.22.1672660514913; 
 Mon, 02 Jan 2023 03:55:14 -0800 (PST)
X-Google-Smtp-Source: AMrXdXsDuiuqHRAe9GS9nG47HPQ0j1PQIPn7y+bhjAPJ5nptWGKJbmyvUyS9SjWvkI8qPZ9ZsVyNeg==
X-Received: by 2002:a05:600c:21c1:b0:3d3:45c6:b641 with SMTP id
 x1-20020a05600c21c100b003d345c6b641mr29176970wmj.22.1672660514646; 
 Mon, 02 Jan 2023 03:55:14 -0800 (PST)
Received: from ?IPV6:2003:cb:c703:500:9382:2e5a:fea:8889?
 (p200300cbc703050093822e5a0fea8889.dip0.t-ipconnect.de.
 [2003:cb:c703:500:9382:2e5a:fea:8889])
 by smtp.gmail.com with ESMTPSA id
 z10-20020a05600c0a0a00b003d96efd09b7sm39870584wmp.19.2023.01.02.03.55.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 02 Jan 2023 03:55:14 -0800 (PST)
Message-ID: <874fd614-23da-c9b6-95f5-41b544b8df18@redhat.com>
Date: Mon, 2 Jan 2023 12:55:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
To: Soichiro Ueda <the.latticeheart@gmail.com>, mst@redhat.com,
 jasowang@redhat.com, akpm@linux-foundation.org
References: <20221223093527.12424-1-the.latticeheart@gmail.com>
 <c8ea7076-f107-c340-6b34-6b22a9369da5@redhat.com>
 <444735fd-7076-7bd3-dc5e-7135a7f3a95c@gmail.com>
From: David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] virtio_balloon: high order allocation
In-Reply-To: <444735fd-7076-7bd3-dc5e-7135a7f3a95c@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: cwd@google.com, linux-kernel@vger.kernel.org, kalutes@google.com,
 linux-mm@kvack.org, mhiramat@kernel.org,
 virtualization@lists.linux-foundation.org
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

T24gMjkuMTIuMjIgMDY6MzEsIFNvaWNoaXJvIFVlZGEgd3JvdGU6Cj4gSGkgRGF2aWQuCj4gCj4+
IEhvdyBkb2VzIHRoaXMgYWZmZWN0IHBhZ2UgbWlncmF0aW9uIC8gYmFsbG9vbiBjb21wYWN0aW9u
IGV0Yz8KPiAKPiBJIGd1ZXNzIHRoaXMgcGF0Y2ggZG9lc24ndCBhZmZlY3QgYmFsbG9vbiBjb21w
YWN0aW9uLiBXaGVuIGFsbG9jYXRpbmcKPiBwYWdlcyB1c2luZyBhbGxvY19wYWdlcygpLCBpdCBz
a2lwcyBjb21wYWN0aW9uIGJ5IG1hc2tpbmcgb3V0Cj4gX19HRlBfUkVDTEFJTSBpZiB0aGUgb3Jk
ZXIgaXMgbGFyZ2VyIHRoYW4gMC4KPiAKPiBBcyBmb3IgcGFnZSBtaWdyYXRpb24sIGluIHRoZSBj
dXJyZW50IGltcGxlbWVudGF0aW9uIGl0IG1pZ3JhdGUgYQo+IDAtb3JkZXIgcGFnZSB0byBhbm90
aGVyIDAtb3JkZXIgcGFnZS4gV2l0aCB0aGlzIHBhdGNoLCBpdCBtYXkgbWlncmF0ZSBhCj4gaGln
aC1vcmRlciBwYWdlIHRvIGFub3RoZXIgc2FtZS1vcmRlciBwYWdlLgo+IAo+IEJ1dCBJIG5vdGlj
ZWQgdGhhdCB0aGUgbWlncmF0ZWQgaGlnaC1vcmRlciBwYWdlIGlzIGhhbmRsZWQgYXMgMC1vcmRl
cgo+IHBhZ2UgaW4gdmlydGJhbGxvb25fbWlncmF0ZXBhZ2UoKS4KPiAKPiAgID4gwqDCoMKgIGJh
bGxvb25fcGFnZV9pbnNlcnQodmJfZGV2X2luZm8sIG5ld3BhZ2UpOwo+IAoKWWVzLCBJIHRoaW5r
IHN1c3BlY3RlZCB0aGF0IGl0J3MgYnJva2VuLgoKV2UgYWxzbyBtaWdodCB3YW50IHRvIGhhbmRs
ZSBPT00gYWNjb3JkaW5nbHkgYnkgc3BsaXR0aW5nIHRoZSBwYWdlIGFuZCAKcmV0cnlpbmcgbWln
cmF0aW9uLiBBbG1vc3Qgbm90aGluZyBzaG91bGQgc3RvcCBhIGJhbGxvb24gcGFnZSBmcm9tIApn
ZXR0aW5nIG1pZ3JhdGVkLgoKT25lIHRoaW5nIHRvIHRyeSBpcyBhbGxvY2F0aW5nIGEgaGlnaGVy
LW9yZGVyIHBhZ2UgYW5kIGltbWVkaWF0ZWx5IApzcGxpdHRpbmcgaXQgaW50byBiYXNlIHBhZ2Vz
LCBhbmQgZW5xdWV1aW5nIGJhc2UgcGFnZXMgb25seS4gT25seSAKaW5mbGF0aW9uIHdvdWxkIGJl
IGZhc3RlciwgYmVjYXVzZSB5b3UgY291bGQgb25seSBkZWZsYXRlIGJhc2UgcGFnZXMuCgo+IFdl
IHNob3VsZCBwdXQgdGhlIG5ld3BhZ2UgaW50byBhIHBhZ2UgbGlzdCBvZiB0aGUgY29ycmVzcG9u
ZGluZyBvcmRlciwKPiBsaWtlIHRoaXMuCj4gCj4gICDCoMKgwqAgYmFsbG9vbl9wYWdlX2VucXVl
dWUodmJfZGV2X2luZm8sIG5ld3BhZ2UsIG9yZGVyKTsKPiAKPiBJJ2xsIGZpeCBpdCBpbiB0aGUg
djIgcGF0Y2guCgoKTm90ZSB0aGF0IEkgaGF2ZSBzb21lIG1vcmUgY29uY2VybnM6CiogV2UgbWln
aHQgZW5kIHVwIHN0ZWFsaW5nIGFsbCBoaWdoZXItb3JkZXIgcGFnZXMgZnJvbSB0aGUgZ3Vlc3Qg
aW5zdGVhZAogICBvZiBlYXRpbmcgYWxsIG9mIHRoZSAic21hbGwiIGxlZnRvdmVyIHBpZWNlcyBm
aXJzdC4gVGhpcyBtaWdodCBiZQogICB1bmRlc2lyYWJsZS4gV2UgZGlzY3Vzc2VkIHRoaXMgaW4g
dGhlIHBhc3QgaW4gdGhlIGNvbnRleHQgb2YgaHVnZXBhZ2UKICAgYmFsbG9vbmluZyBbbm90IGFi
bGUgdG8gbG9jYXRlIHRoZSBhYmFuZG9uZWQgcGF0Y2hlcyBxdWlja2x5XS4KKiBQR19vZmZsaW5l
IHdvbid0IHdvcmsgYXMgZXhwZWN0ZWQgYW55bW9yZSBhbmQgcmVzdWx0IGluIGtkdW1wIHJlYWRp
bmcKICAgaW5mbGF0ZWQgbWVtb3J5LCB3aGljaCBpcyB1bmRlc2lyYWJsZS4gT25lIHdvcmthcm91
bmQgd291bGQgYmUgc2V0dGluZwogICBQR19vZmZsaW5lIG9uIGFsbCBiYXNlIHBhZ2VzLCBidXQg
dGhpcyBuZWVkcyBzb21lIG1vcmUgdGhvdWdodC4KKiBIb3cgYXJlIHdlIGhhbmRsaW5nIGEgc2Nl
bmFyaW8gd2hlcmUgd2UgYXJlIHJlcXVlc3RlZCB0byBkZWZsYXRlIGUuZy4sCiAgIGEgc2luZ2xl
IDQwOTYgS2lCIHBhZ2UgYnV0IHdlIG9ubHkgaGF2ZSBoaWdoZXItb3JkZXIgcGFnZXMgYWxsb2Nh
dGVkPwogICBJIHN1c3BlY3QgeW91IHdvdWxkIG92ZXItZGVmbGF0ZSByaWdodCBub3csIHdoaWNo
IGlzIHVuZGVzaXJhYmxlLgoKLS0gClRoYW5rcywKCkRhdmlkIC8gZGhpbGRlbmIKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
