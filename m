Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8D408C433EF
	for <virtualization@archiver.kernel.org>; Fri, 15 Apr 2022 08:49:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2700960B10;
	Fri, 15 Apr 2022 08:49:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id iORF-os1M-Mw; Fri, 15 Apr 2022 08:49:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id AC0A560597;
	Fri, 15 Apr 2022 08:49:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6D773C002F;
	Fri, 15 Apr 2022 08:49:03 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 55CD4C002C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 08:49:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 3391640A83
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 08:49:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DmJnCnWPr58n
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 08:49:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 84EFD400CE
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 08:49:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650012540;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZL74iZG7RWeRqPE6lEKycuxieaWdZqnT1Xtw1tATKRc=;
 b=LcPQKzD5uC1ZlDHfaQPYKXITguEzMae762YQANW0TZNjJKkrr+r1CoIcQcRH5DJeEcfjVJ
 mkXmukN6KnTFdFW+t+IwbQNaTarEcerHmOObnMbSzj+AqUDp5+nYDKqCwVaA0Ro3yw90+O
 sz981GF6+rSJLjtqL3mrijcv0l6lI4I=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-144-SfevsXfHM6-TLK9CqZAUlg-1; Fri, 15 Apr 2022 04:48:59 -0400
X-MC-Unique: SfevsXfHM6-TLK9CqZAUlg-1
Received: by mail-wm1-f71.google.com with SMTP id
 r204-20020a1c44d5000000b0038eaca2b8c9so2095240wma.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 15 Apr 2022 01:48:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=ZL74iZG7RWeRqPE6lEKycuxieaWdZqnT1Xtw1tATKRc=;
 b=MgAidPUIsCO5aEYC2vKPUBUuPmtoHmf2YLLQv8GaBo6Kz5dimnjzAzDAfJJX3X5eI1
 +K3uRCKrs2+uKXJc6cbIt0Yae2MHDLynvi+rOEEVVtDIJuuqol0NN+pXKVRHipY5sl2E
 H0CEneKv0sUEPLSY4ieGGt8FNFtAJiQ5VolVkMX0jQ1ZNR4UcS5S+wpZbH04kUepEAdd
 OfqrER4Lq+i1TAv6j5e0UM0oWU4SO9sUhGNZF9dFZ+M+RzfR0mMwxsS+hmVlOAZho8xy
 W5F/x0UuwyIO1Dl7w2VRYqcO1T8yxcqx4qVl+e8UJkVp/AA/wL0V85N2Q5BI0iUkX6Vg
 Vnig==
X-Gm-Message-State: AOAM5312pq1cNn8QpUVlZArWOlYhLvcd1PiuMmhMt8g3t0LWyChj0XAF
 5aNEZgBH8DXr8fRCplwln2A7z79uH15a/eLVeR+OCjOlHIPwZYuu/5bHpkWIVd2Co6fko+kpXgr
 70VSV5m6zVlukbLEVODT0R8KjjLcSYv5Kaqls/N5fCQ==
X-Received: by 2002:a5d:5942:0:b0:207:9abd:792a with SMTP id
 e2-20020a5d5942000000b002079abd792amr4772301wri.118.1650012537838; 
 Fri, 15 Apr 2022 01:48:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwPBTR/5B6KGMYNKFUH2+unsto2dPt4f/qCZVO6aw/4RjmYeKlekMGG/1WSqNdH6ecXBzOV0g==
X-Received: by 2002:a5d:5942:0:b0:207:9abd:792a with SMTP id
 e2-20020a5d5942000000b002079abd792amr4772272wri.118.1650012537613; 
 Fri, 15 Apr 2022 01:48:57 -0700 (PDT)
Received: from redhat.com ([2.53.138.98]) by smtp.gmail.com with ESMTPSA id
 r129-20020a1c2b87000000b0038e6a025d05sm4871569wmr.18.2022.04.15.01.48.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 15 Apr 2022 01:48:56 -0700 (PDT)
Date: Fri, 15 Apr 2022 04:48:52 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Christophe de Dinechin <dinechin@redhat.com>
Subject: Re: [PATCH 3/3] virtio-pci: Use cpumask_available to fix compilation
 error
Message-ID: <20220415044657-mutt-send-email-mst@kernel.org>
References: <20220414150855.2407137-1-dinechin@redhat.com>
 <20220414150855.2407137-4-dinechin@redhat.com>
MIME-Version: 1.0
In-Reply-To: <20220414150855.2407137-4-dinechin@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Juri Lelli <juri.lelli@redhat.com>, trivial@kernel.org,
 Peter Zijlstra <peterz@infradead.org>, Zhen Lei <thunder.leizhen@huawei.com>,
 linux-kernel@vger.kernel.org, Steven Rostedt <rostedt@goodmis.org>,
 virtualization@lists.linux-foundation.org, Ben Segall <bsegall@google.com>,
 Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
 Murilo Opsfelder Araujo <muriloo@linux.ibm.com>,
 Paolo Bonzini <pbonzini@redhat.com>,
 Vincent Guittot <vincent.guittot@linaro.org>,
 Andrew Morton <akpm@linux-foundation.org>,
 Daniel Bristot de Oliveira <bristot@redhat.com>,
 Dietmar Eggemann <dietmar.eggemann@arm.com>
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

T24gVGh1LCBBcHIgMTQsIDIwMjIgYXQgMDU6MDg6NTVQTSArMDIwMCwgQ2hyaXN0b3BoZSBkZSBE
aW5lY2hpbiB3cm90ZToKPiBXaXRoIEdDQyAxMiBhbmQgZGVmY29uZmlnLCB3ZSBnZXQgdGhlIGZv
bGxvd2luZyBlcnJvcjoKPiAKPiB8ICAgQ0MgICAgICBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNp
X2NvbW1vbi5vCj4gfCBkcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jOiBJbiBmdW5j
dGlvbiDigJh2cF9kZWxfdnFz4oCZOgo+IHwgZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9jb21t
b24uYzoyNTc6Mjk6IGVycm9yOiB0aGUgY29tcGFyaXNvbiB3aWxsCj4gfCAgYWx3YXlzIGV2YWx1
YXRlIGFzIOKAmHRydWXigJkgZm9yIHRoZSBwb2ludGVyIG9wZXJhbmQgaW4KPiB8ICDigJh2cF9k
ZXYtPm1zaXhfYWZmaW5pdHlfbWFza3MgKyAoc2l6ZXR5cGUpKChsb25nIHVuc2lnbmVkIGludClp
ICogOCnigJkKPiB8ICBtdXN0IG5vdCBiZSBOVUxMIFstV2Vycm9yPWFkZHJlc3NdCj4gfCAgIDI1
NyB8ICAgICAgICAgICAgICAgICAgICAgICAgIGlmICh2cF9kZXYtPm1zaXhfYWZmaW5pdHlfbWFz
a3NbaV0pCj4gfCAgICAgICB8ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBefn5+fn4KPiAK
PiBUaGlzIGhhcHBlbnMgaW4gdGhlIGNhc2Ugd2hlcmUgQ09ORklHX0NQVU1BU0tfT0ZGU1RBQ0sg
aXMgbm90IGRlZmluZWQsCj4gc2luY2Ugd2UgdHlwZWRlZiBjcHVtYXNrX3Zhcl90IGFzIGFuIGFy
cmF5LiBUaGUgY29tcGlsZXIgaXMgZXNzZW50aWFsbHkKPiBjb21wbGFpbmluZyB0aGF0IGFuIGFy
cmF5IHBvaW50ZXIgY2Fubm90IGJlIE5VTEwuIFRoaXMgaXMgbm90IGEgdmVyeQo+IGltcG9ydGFu
dCB3YXJuaW5nLCBidXQgdGhlcmUgaXMgYSBmdW5jdGlvbiBjYWxsZWQgY3B1bWFza19hdmFpbGFi
bGUgdGhhdAo+IHNlZW1zIHRvIGJlIGRlZmluZWQganVzdCBmb3IgdGhhdCBjYXNlLCBzbyB0aGUg
Zml4IGlzIGVhc3kuCj4gCj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoZSBkZSBEaW5lY2hpbiA8
Y2hyaXN0b3BoZUBkaW5lY2hpbi5vcmc+Cj4gU2lnbmVkLW9mZi1ieTogQ2hyaXN0b3BoZSBkZSBE
aW5lY2hpbiA8ZGluZWNoaW5AcmVkaGF0LmNvbT4KClRoZXJlIHdhcyBhbiBhbHRlcm5hdGUgcGF0
Y2ggcHJvcG9zZWQgZm9yIHRoaXMgYnkKTXVyaWxvIE9wc2ZlbGRlciBBcmF1am8uIFdoYXQgZG8g
eW91IHRoaW5rIGFib3V0IHRoYXQgYXBwcm9hY2g/CgoKPiAtLS0KPiAgZHJpdmVycy92aXJ0aW8v
dmlydGlvX3BjaV9jb21tb24uYyB8IDIgKy0KPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
KCspLCAxIGRlbGV0aW9uKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRp
b19wY2lfY29tbW9uLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX2NvbW1vbi5jCj4gaW5k
ZXggZDcyNGY2NzY2MDhiLi41YzQ0YTJmMTNjOTMgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3BjaV9jb21tb24uYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lf
Y29tbW9uLmMKPiBAQCAtMjU0LDcgKzI1NCw3IEBAIHZvaWQgdnBfZGVsX3ZxcyhzdHJ1Y3Qgdmly
dGlvX2RldmljZSAqdmRldikKPiAgCj4gIAlpZiAodnBfZGV2LT5tc2l4X2FmZmluaXR5X21hc2tz
KSB7Cj4gIAkJZm9yIChpID0gMDsgaSA8IHZwX2Rldi0+bXNpeF92ZWN0b3JzOyBpKyspCj4gLQkJ
CWlmICh2cF9kZXYtPm1zaXhfYWZmaW5pdHlfbWFza3NbaV0pCj4gKwkJCWlmIChjcHVtYXNrX2F2
YWlsYWJsZSh2cF9kZXYtPm1zaXhfYWZmaW5pdHlfbWFza3NbaV0pKQo+ICAJCQkJZnJlZV9jcHVt
YXNrX3Zhcih2cF9kZXYtPm1zaXhfYWZmaW5pdHlfbWFza3NbaV0pOwo+ICAJfQo+ICAKPiAtLSAK
PiAyLjM1LjEKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
ClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1m
b3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9s
aXN0aW5mby92aXJ0dWFsaXphdGlvbg==
