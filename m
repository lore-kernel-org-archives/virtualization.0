Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E35FC76196
	for <virtualization@archiver.kernel.org>; Fri, 24 Mar 2023 14:43:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C6FF884219;
	Fri, 24 Mar 2023 14:43:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C6FF884219
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ze91IsQg
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dw1BVV4m7TC1; Fri, 24 Mar 2023 14:43:11 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 40A0284210;
	Fri, 24 Mar 2023 14:43:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 40A0284210
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 12F24C0077;
	Fri, 24 Mar 2023 14:43:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DDC13C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 14:43:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id ABB1F84219
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 14:43:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ABB1F84219
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id uSHj16jvJGPq
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 14:43:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org F006584218
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id F006584218
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 14:43:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679668987;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=RTM4M2SNjA5FZsosnRIZjHnCRJF879F1P/kiqHZ5HjY=;
 b=Ze91IsQgJKaNp+kL1luaQJqcPGY+/dK0dY6oxqY+WP6o134kalcihoyoBLle5DjU+t6VLQ
 hc+Ii6GvC/Srx4H1iAu67XHQNmXgzXQE/PwRe+/BAwoiXWuVxdOhP7xHJfzF+563wVhIJC
 cpDoPKmcRz8J7LRVfHqk+6Cw+KxzzpQ=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-590--jfJ51rtN_eAIgDCiZIzpQ-1; Fri, 24 Mar 2023 10:43:06 -0400
X-MC-Unique: -jfJ51rtN_eAIgDCiZIzpQ-1
Received: by mail-ed1-f71.google.com with SMTP id
 m18-20020a50d7d2000000b00501dfd867a4so3509862edj.20
 for <virtualization@lists.linux-foundation.org>;
 Fri, 24 Mar 2023 07:43:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679668985;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=RTM4M2SNjA5FZsosnRIZjHnCRJF879F1P/kiqHZ5HjY=;
 b=tSs4QiD8uYvRppqTFrnkBWS0CRyXfDj/fUwTaygQjnzB6yhqSw6F3mMhWjJq3qDyop
 MwgB0IughcARFivkJhrg+BXGk3VgZOn4g3l4uA7229j0Njt4pPb0qMMxAOEaUGIAcgnv
 x0MstnFSAGvNFHHEhuiVFa9oT9A/F5hZusLYIUV7+YtvnjT8/f1TSX1SweZLEhB+LWcb
 aUdgnOyN5KqpuY62Wwa+XE6gIm5HNYVds+JdN7xqNc/VLvFBh7DPUONtVio2g/32LpCx
 brlXwD5Hb/jkAtWRaTGtfedghk0OaAp8YeY52TpkZICtKev2szg0kP73/+SUbNaYsZQn
 KK+g==
X-Gm-Message-State: AAQBX9erJG0Q4MAHf0CAeSF0LdNkqsw+yeu2sn0zaspuckdyIWaxd8k1
 5JRiDGfOnSn8YoLHPCuxv/SboDT9MbloNF13a6H5H/GFvHpa2jxFvPI3wccwT9+TgGtpUJx+kD6
 moa+CCnHvr8+sGPxO2E/cxNECLbqKAZV6gIKu1CMd1w==
X-Received: by 2002:a17:906:74f:b0:933:3b2e:6016 with SMTP id
 z15-20020a170906074f00b009333b2e6016mr2817362ejb.7.1679668985385; 
 Fri, 24 Mar 2023 07:43:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350bH91Eohsmveeezt2qh6UzwwaDwrZKpjhh9RUKdgHpoMPxgzsZ/fiNdaDbea2Uje8vSwhq7VA==
X-Received: by 2002:a17:906:74f:b0:933:3b2e:6016 with SMTP id
 z15-20020a170906074f00b009333b2e6016mr2817346ejb.7.1679668985134; 
 Fri, 24 Mar 2023 07:43:05 -0700 (PDT)
Received: from sgarzare-redhat (host-82-53-134-98.retail.telecomitalia.it.
 [82.53.134.98]) by smtp.gmail.com with ESMTPSA id
 t7-20020a1709064f0700b008cda6560404sm10314573eju.193.2023.03.24.07.43.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Mar 2023 07:43:04 -0700 (PDT)
Date: Fri, 24 Mar 2023 15:43:02 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3 8/8] vdpa_sim: add support for user VA
Message-ID: <j6d2b5zqbb7rlrem76wopsabyy344wwnkbutvacebcig5fupnu@a2xkhywajwta>
References: <20230321154804.184577-1-sgarzare@redhat.com>
 <20230321154804.184577-4-sgarzare@redhat.com>
 <CACGkMEtbrt3zuqy9YdhNyE90HHUT1R=HF-YRAQ6b4KnW_SdZ-w@mail.gmail.com>
 <20230323095006.jvbbdjvkdvhzcehz@sgarzare-redhat>
 <CACGkMEveMGEzX7bCPuQuqm=9q7Ut-k=MLrRYM3Bq6cMpaw9fVQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEveMGEzX7bCPuQuqm=9q7Ut-k=MLrRYM3Bq6cMpaw9fVQ@mail.gmail.com>
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

T24gRnJpLCBNYXIgMjQsIDIwMjMgYXQgMTA6NTQ6MzlBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPk9uIFRodSwgTWFyIDIzLCAyMDIzIGF0IDU6NTDigK9QTSBTdGVmYW5vIEdhcnphcmVsbGEg
PHNnYXJ6YXJlQHJlZGhhdC5jb20+IHdyb3RlOgo+Pgo+PiBPbiBUaHUsIE1hciAyMywgMjAyMyBh
dCAxMTo0MjowN0FNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiA+T24gVHVlLCBNYXIgMjEs
IDIwMjMgYXQgMTE6NDjigK9QTSBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5j
b20+IHdyb3RlOgo+PiA+Pgo+PiA+PiBUaGUgbmV3ICJ1c2VfdmEiIG1vZHVsZSBwYXJhbWV0ZXIg
KGRlZmF1bHQ6IHRydWUpIGlzIHVzZWQgaW4KPj4gPj4gdmRwYV9hbGxvY19kZXZpY2UoKSB0byBp
bmZvcm0gdGhlIHZEUEEgZnJhbWV3b3JrIHRoYXQgdGhlIGRldmljZQo+PiA+PiBzdXBwb3J0cyBW
QS4KPj4gPj4KPj4gPj4gdnJpbmdoIGlzIGluaXRpYWxpemVkIHRvIHVzZSBWQSBvbmx5IHdoZW4g
InVzZV92YSIgaXMgdHJ1ZSBhbmQgdGhlCj4+ID4+IHVzZXIncyBtbSBoYXMgYmVlbiBib3VuZC4g
U28sIG9ubHkgd2hlbiB0aGUgYnVzIHN1cHBvcnRzIHVzZXIgVkEKPj4gPj4gKGUuZy4gdmhvc3Qt
dmRwYSkuCj4+ID4+Cj4+ID4+IHZkcGFzaW1fbW1fd29ya19mbiB3b3JrIGlzIHVzZWQgdG8gc2Vy
aWFsaXplIHRoZSBiaW5kaW5nIHRvIGEgbmV3Cj4+ID4+IGFkZHJlc3Mgc3BhY2Ugd2hlbiB0aGUg
LmJpbmRfbW0gY2FsbGJhY2sgaXMgaW52b2tlZCwgYW5kIHVuYmluZGluZwo+PiA+PiB3aGVuIHRo
ZSAudW5iaW5kX21tIGNhbGxiYWNrIGlzIGludm9rZWQuCj4+ID4+Cj4+ID4+IENhbGwgbW1nZXRf
bm90X3plcm8oKS9rdGhyZWFkX3VzZV9tbSgpIGluc2lkZSB0aGUgd29ya2VyIGZ1bmN0aW9uCj4+
ID4+IHRvIHBpbiB0aGUgYWRkcmVzcyBzcGFjZSBvbmx5IGFzIGxvbmcgYXMgbmVlZGVkLCBmb2xs
b3dpbmcgdGhlCj4+ID4+IGRvY3VtZW50YXRpb24gb2YgbW1nZXQoKSBpbiBpbmNsdWRlL2xpbnV4
L3NjaGVkL21tLmg6Cj4+ID4+Cj4+ID4+ICAgKiBOZXZlciB1c2UgdGhpcyBmdW5jdGlvbiB0byBw
aW4gdGhpcyBhZGRyZXNzIHNwYWNlIGZvciBhbgo+PiA+PiAgICogdW5ib3VuZGVkL2luZGVmaW5p
dGUgYW1vdW50IG9mIHRpbWUuCj4+ID4KPj4gPkkgd29uZGVyIGlmIGV2ZXJ5dGhpbmcgd291bGQg
YmUgc2ltcGxpZmllZCBpZiB3ZSBqdXN0IGFsbG93IHRoZSBwYXJlbnQKPj4gPnRvIGFkdmVydGlz
ZSB3aGV0aGVyIG9yIG5vdCBpdCByZXF1aXJlcyB0aGUgYWRkcmVzcyBzcGFjZS4KPj4gPgo+PiA+
VGhlbiB3aGVuIHZob3N0LXZEUEEgcHJvYmVzIHRoZSBkZXZpY2UgaXQgY2FuIHNpbXBseSBhZHZl
cnRpc2UKPj4gPnVzZV93b3JrIGFzIHRydWUgc28gdmhvc3QgY29yZSBjYW4gdXNlIGdldF90YXNr
X21tKCkgaW4gdGhpcyBjYXNlPwo+Pgo+PiBJSVVDIHNldCB1c2VyX3dvcmtlciB0byB0cnVlLCBp
dCBhbHNvIGNyZWF0ZXMgdGhlIGt0aHJlYWQgaW4gdGhlIHZob3N0Cj4+IGNvcmUgKGJ1dCB3ZSBj
YW4gYWRkIGFub3RoZXIgdmFyaWFibGUgdG8gYXZvaWQgdGhpcykuCj4+Cj4+IE15IGJpZ2dlc3Qg
Y29uY2VybiBpcyB0aGUgY29tbWVudCBpbiBpbmNsdWRlL2xpbnV4L3NjaGVkL21tLmguCj4+IGdl
dF90YXNrX21tKCkgdXNlcyBtbWdldCgpLCBidXQgaW4gdGhlIGRvY3VtZW50YXRpb24gdGhleSBh
ZHZpc2UgYWdhaW5zdAo+PiBwaW5uaW5nIHRoZSBhZGRyZXNzIHNwYWNlIGluZGVmaW5pdGVseSwg
c28gSSBwcmVmZXJyZWQgaW4ga2VlcGluZwo+PiBtbWdyYWIoKSBpbiB0aGUgdmhvc3QgY29yZSwg
dGhlbiBjYWxsIG1tZ2V0X25vdF96ZXJvKCkgaW4gdGhlIHdvcmtlcgo+PiBvbmx5IHdoZW4gaXQg
aXMgcnVubmluZy4KPgo+T2suCj4KPj4KPj4gSW4gdGhlIGZ1dHVyZSBtYXliZSBtbSB3aWxsIGJl
IHVzZWQgZGlmZmVyZW50bHkgZnJvbSBwYXJlbnQgaWYgc29tZWhvdwo+PiBpdCBpcyBzdXBwb3J0
ZWQgYnkgaW9tbXUsIHNvIEkgd291bGQgbGVhdmUgaXQgdG8gdGhlIHBhcmVudCB0byBoYW5kbGUK
Pj4gdGhpcy4KPgo+VGhpcyBzaG91bGQgYmUgcG9zc2libGUsIEkgd2FzIHRvbGQgYnkgSW50ZWwg
dGhhdCB0aGVpciBJT01NVSBjYW4KPmFjY2VzcyB0aGUgcHJvY2VzcyBwYWdlIHRhYmxlIGZvciBz
aGFyZWQgdmlydHVhbCBtZW1vcnkuCgpDb29sLCB3ZSBzaG91bGQgaW52ZXN0aWdhdGUgdGhpcy4g
RG8geW91IGhhdmUgYW55IHBvaW50ZXJzIHRvIHRoZWlyCmRvY3VtZW50YXRpb24/CgpUaGFua3Ms
ClN0ZWZhbm8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
