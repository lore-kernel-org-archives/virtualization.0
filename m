Return-Path: <SRS0=ivLu=BN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73195C433E1
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 21:26:55 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 75958207DF
	for <virtualization@archiver.kernel.org>; Mon,  3 Aug 2020 21:26:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fj6yIs//"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 75958207DF
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1DB9D87A80;
	Mon,  3 Aug 2020 21:26:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id S+GCtz0xBcu8; Mon,  3 Aug 2020 21:26:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 306D587A04;
	Mon,  3 Aug 2020 21:26:53 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1B496C0051;
	Mon,  3 Aug 2020 21:26:53 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 03AE6C004C
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:26:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id DE1DE2094D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:26:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id J3QxBBQ7yCu1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:26:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by silver.osuosl.org (Postfix) with ESMTPS id D2F24207A9
 for <virtualization@lists.linux-foundation.org>;
 Mon,  3 Aug 2020 21:26:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596490009;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Ybiw+xvdcRPg6uX9uTEZxWl5ku8VBixKpU2AkK1dKWw=;
 b=fj6yIs//7RfUpvdZSa/BbB30hCMfVab3DN+L8MjU5fJfOyqzAOQZ07zXnZ3FuVxInCFyeX
 RY68mP9X9SaBuuDJzgY6LDEEyIjNS6GS51ZzubRZnwT/jsUbZWIfUvxixt0eoKJ9v8pZS8
 kflRU3h6tjgsAleOx/dnAAQizjD5MCE=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-gjU0E2PRMAG-6PgqYjoGXw-1; Mon, 03 Aug 2020 17:26:48 -0400
X-MC-Unique: gjU0E2PRMAG-6PgqYjoGXw-1
Received: by mail-ej1-f72.google.com with SMTP id z14so13168963eje.19
 for <virtualization@lists.linux-foundation.org>;
 Mon, 03 Aug 2020 14:26:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:content-transfer-encoding:from:mime-version
 :subject:date:message-id:references:cc:in-reply-to:to;
 bh=iRtJQGNbvmgaLcvaxkwOS7vH+SUEibACGG1bnindh24=;
 b=GaLUYVhxk+RGbJYU7VaZBF0P+JGofBt1OpLsAanDGTgT6f/72aJnXdcMLN3xkAFAlY
 GqhdF/OgTxtd9jO4AeQTC91yC2cxHYxxa2B9QmPLMTUuPWrcWI6yr1RZAxD9ctB/E1Os
 TXqn4kyUWAKiNx3GjoWkN4Rb+4XAd/PAFu8cfA15ct1+qfnSzd0jU1x+jcz/587OJFoU
 zcUQIr05Geanl5RVkM4Q38rG2Rzi5sRxzAJ9wDiA1kcXbq3zgx8tnJtA5DW+x6skb4gV
 wBIvKn72eLYdQcCxF2i/UWMiwknGnYRrnrPT3jMDg8JpIUHylrUFXtLzFkk+i85AnlhI
 F+OQ==
X-Gm-Message-State: AOAM532x6Fu+q2iiisKK6A/wX5K07iRq1E1bQMOvmq3AGAKwAbZWJ68d
 vfB6npRpEGuy/Nv2HGRJNwEwsbHB2Z2Rxu/E8+2meYH8O2NJ5dykkqIBMIUNw9Chywjmks14AS+
 xlCntgHgdKL8FiUaXBxzaKWkSqE6XDYwJZNfL6SnCWg==
X-Received: by 2002:a50:9e4c:: with SMTP id z70mr17274777ede.384.1596490007151; 
 Mon, 03 Aug 2020 14:26:47 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwiOz/r6BIu9VkOdQ1URaCztVYMV7EL3eZ1EToZBNUnt7wGWXQQoZarZ0Kjj1o9DJbuN2x5LA==
X-Received: by 2002:a50:9e4c:: with SMTP id z70mr17274769ede.384.1596490006986; 
 Mon, 03 Aug 2020 14:26:46 -0700 (PDT)
Received: from [192.168.3.122] (p5b0c6449.dip0.t-ipconnect.de. [91.12.100.73])
 by smtp.gmail.com with ESMTPSA id
 dm5sm8476175edb.32.2020.08.03.14.26.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 03 Aug 2020 14:26:46 -0700 (PDT)
From: David Hildenbrand <david@redhat.com>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2 05/24] virtio_balloon: correct tags for config space
 fields
Date: Mon, 3 Aug 2020 23:26:46 +0200
Message-Id: <1E428D95-19D2-40BA-9C46-CA7B0D823A7E@redhat.com>
References: <20200803205814.540410-6-mst@redhat.com>
In-Reply-To: <20200803205814.540410-6-mst@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
X-Mailer: iPhone Mail (17F80)
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Cgo+IEFtIDAzLjA4LjIwMjAgdW0gMjI6NTkgc2NocmllYiBNaWNoYWVsIFMuIFRzaXJraW4gPG1z
dEByZWRoYXQuY29tPjoKPiAKPiDvu79UYWcgY29uZmlnIHNwYWNlIGZpZWxkcyBhcyBoYXZpbmcg
bGl0dGxlIGVuZGlhbi1uZXNzLgo+IE5vdGUgdGhhdCBiYWxsb29uIGlzIHNwZWNpYWw6IExFIGV2
ZW4gd2hlbiB1c2luZwo+IHRoZSBsZWdhY3kgaW50ZXJmYWNlLgo+IAo+IFNpZ25lZC1vZmYtYnk6
IE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+CgpBY2tlZC1ieTogRGF2aWQgSGls
ZGVuYnJhbmQgPGRhdmlkQHJlZGhhdC5jb20+Cgo+IC0tLQo+IGluY2x1ZGUvdWFwaS9saW51eC92
aXJ0aW9fYmFsbG9vbi5oIHwgMTAgKysrKystLS0tLQo+IDEgZmlsZSBjaGFuZ2VkLCA1IGluc2Vy
dGlvbnMoKyksIDUgZGVsZXRpb25zKC0pCj4gCj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvdWFwaS9s
aW51eC92aXJ0aW9fYmFsbG9vbi5oIGIvaW5jbHVkZS91YXBpL2xpbnV4L3ZpcnRpb19iYWxsb29u
LmgKPiBpbmRleCBkYzNlNjU2NDcwZGQuLmRkYWE0NWU3MjNjNCAxMDA2NDQKPiAtLS0gYS9pbmNs
dWRlL3VhcGkvbGludXgvdmlydGlvX2JhbGxvb24uaAo+ICsrKyBiL2luY2x1ZGUvdWFwaS9saW51
eC92aXJ0aW9fYmFsbG9vbi5oCj4gQEAgLTQ1LDIwICs0NSwyMCBAQAo+ICNkZWZpbmUgVklSVElP
X0JBTExPT05fQ01EX0lEX0RPTkUgICAgMQo+IHN0cnVjdCB2aXJ0aW9fYmFsbG9vbl9jb25maWcg
ewo+ICAgIC8qIE51bWJlciBvZiBwYWdlcyBob3N0IHdhbnRzIEd1ZXN0IHRvIGdpdmUgdXAuICov
Cj4gLSAgICBfX3UzMiBudW1fcGFnZXM7Cj4gKyAgICBfX2xlMzIgbnVtX3BhZ2VzOwo+ICAgIC8q
IE51bWJlciBvZiBwYWdlcyB3ZSd2ZSBhY3R1YWxseSBnb3QgaW4gYmFsbG9vbi4gKi8KPiAtICAg
IF9fdTMyIGFjdHVhbDsKPiArICAgIF9fbGUzMiBhY3R1YWw7Cj4gICAgLyoKPiAgICAgKiBGcmVl
IHBhZ2UgaGludCBjb21tYW5kIGlkLCByZWFkb25seSBieSBndWVzdC4KPiAgICAgKiBXYXMgcHJl
dmlvdXNseSBuYW1lZCBmcmVlX3BhZ2VfcmVwb3J0X2NtZF9pZCBzbyB3ZQo+ICAgICAqIG5lZWQg
dG8gY2FycnkgdGhhdCBuYW1lIGZvciBsZWdhY3kgc3VwcG9ydC4KPiAgICAgKi8KPiAgICB1bmlv
biB7Cj4gLSAgICAgICAgX191MzIgZnJlZV9wYWdlX2hpbnRfY21kX2lkOwo+IC0gICAgICAgIF9f
dTMyIGZyZWVfcGFnZV9yZXBvcnRfY21kX2lkOyAgICAvKiBkZXByZWNhdGVkICovCj4gKyAgICAg
ICAgX19sZTMyIGZyZWVfcGFnZV9oaW50X2NtZF9pZDsKPiArICAgICAgICBfX2xlMzIgZnJlZV9w
YWdlX3JlcG9ydF9jbWRfaWQ7ICAgIC8qIGRlcHJlY2F0ZWQgKi8KPiAgICB9Owo+ICAgIC8qIFN0
b3JlcyBQQUdFX1BPSVNPTiBpZiBwYWdlIHBvaXNvbmluZyBpcyBpbiB1c2UgKi8KPiAtICAgIF9f
dTMyIHBvaXNvbl92YWw7Cj4gKyAgICBfX2xlMzIgcG9pc29uX3ZhbDsKPiB9Owo+IAo+ICNkZWZp
bmUgVklSVElPX0JBTExPT05fU19TV0FQX0lOICAwICAgLyogQW1vdW50IG9mIG1lbW9yeSBzd2Fw
cGVkIGluICovCj4gLS0gCj4gTVNUCj4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRp
b25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRp
b24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
