Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1465C433EF
	for <virtualization@archiver.kernel.org>; Thu,  9 Dec 2021 21:23:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 89A6F42289;
	Thu,  9 Dec 2021 21:23:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id hN9HQRCGpXmL; Thu,  9 Dec 2021 21:23:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F2D7742286;
	Thu,  9 Dec 2021 21:23:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ACDE5C001E;
	Thu,  9 Dec 2021 21:23:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 75F40C0012
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 21:23:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6C5BE860E2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 21:23:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Vetl14uxy1ii
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 21:23:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 41F2C860E1
 for <virtualization@lists.linux-foundation.org>;
 Thu,  9 Dec 2021 21:23:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639084980;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Vgwc1magvMzj/8M1W9pAQzQB7+9j3HSAE2K13KoLOiQ=;
 b=c5HRpZ9WpXnyIi+S8G4za/TvPuxJ03qccnwJZx7ISTmt+DOEDFDe3BdUsd6kftXo7wpf5M
 4hWSbOH7XcWtWww3Nl1XoMXRQLnwfZMPwP45fmuO17icaLKlzq6lLWJliHB5qWghzH9tuG
 w4o+QyViF1aZ1s0uuXZ+ubaKROkALM8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-uyUIkw33Oi6yMHvcLXdtxw-1; Thu, 09 Dec 2021 16:22:59 -0500
X-MC-Unique: uyUIkw33Oi6yMHvcLXdtxw-1
Received: by mail-wm1-f71.google.com with SMTP id
 j25-20020a05600c1c1900b00332372c252dso2889678wms.1
 for <virtualization@lists.linux-foundation.org>;
 Thu, 09 Dec 2021 13:22:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Vgwc1magvMzj/8M1W9pAQzQB7+9j3HSAE2K13KoLOiQ=;
 b=Lrtrudm4xq75J3mwwp71WOZhD8+L5oKt5HaLqcVU+6UawTZBev4T2fWoLTqwJ5NoAF
 gKcXUPuofIzlOB/+mGT6TNGBqi0JhF1/3oViRXpbWFpFedw/z4bkITaQWUIPS+GS4QSj
 Oa2sPKE96rnFHkcG9BeJ/rnpGhNxMiFsoA/hcAFah8BtoKcyKlY9vsyQfezshVgwa0Te
 aDhHdVM6l/Bkf0EM6u7+3EEgmPX/oiVU16ixyGSvy4fAmEwxYohIxD6ssgBCMkfONYf3
 PlmpKanyMhVd4FlFER2p9XhBCQRT8JYE1T6sqchbuCV/3GJ4KwkX7xiQWn0UXtWx+7Z9
 PG1g==
X-Gm-Message-State: AOAM5321t9nHF5eDIAdNGvnAp1z6Oabs4ed8xDzMdJYXA/vJzKnatU+w
 /3crSiLW1UZmH0QHbdAOhS000qPIuPd0yPrtbtR90DuYZW2QMea8xj3wcjRug/BBQXgZD9rD9Ev
 3il0tshVzoLdw96LudLe2gHYRS5bVYswMTPbqF8hqSA==
X-Received: by 2002:a5d:4d8b:: with SMTP id b11mr9190184wru.393.1639084978458; 
 Thu, 09 Dec 2021 13:22:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzEhH9zXTTqyJyrSWANNFF5+2UsCUnbJ3IhG7hh2poI6YaxLYQDArU+ddIxOhcq+6xvoWFlHQ==
X-Received: by 2002:a5d:4d8b:: with SMTP id b11mr9190171wru.393.1639084978284; 
 Thu, 09 Dec 2021 13:22:58 -0800 (PST)
Received: from redhat.com ([2.55.18.120])
 by smtp.gmail.com with ESMTPSA id g13sm1214316wrd.57.2021.12.09.13.22.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 09 Dec 2021 13:22:56 -0800 (PST)
Date: Thu, 9 Dec 2021 16:22:52 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth: virtio_bt: fix device removal
Message-ID: <20211209162149-mutt-send-email-mst@kernel.org>
References: <20211125174200.133230-1-mst@redhat.com>
 <F52F65FE-6A07-486B-8E84-684ED85709E9@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <F52F65FE-6A07-486B-8E84-684ED85709E9@holtmann.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-bluetooth@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
 Johan Hedberg <johan.hedberg@gmail.com>
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

T24gVGh1LCBOb3YgMjUsIDIwMjEgYXQgMDk6MDI6MDFQTSArMDEwMCwgTWFyY2VsIEhvbHRtYW5u
IHdyb3RlOgo+IEhpIE1pY2hhZWwsCj4gCj4gPiBEZXZpY2UgcmVtb3ZhbCBpcyBjbGVhcmx5IG91
dCBvZiB2aXJ0aW8gc3BlYzogaXQgYXR0ZW1wdHMgdG8gcmVtb3ZlCj4gPiB1bnVzZWQgYnVmZmVy
cyBmcm9tIGEgVlEgYmVmb3JlIGludm9raW5nIGRldmljZSByZXNldC4gVG8gZml4LCBtYWtlCj4g
PiBvcGVuL2Nsb3NlIE5PUHMgYW5kIGRvIGFsbCBjbGVhbnVwL3NldHVwIGluIHByb2JlL3JlbW92
ZS4KPiAKPiBzbyB0aGUgdmlydGJ0X3tvcGVuLGNsb3NlfSBhcyBOT1AgaXMgbm90IHJlYWxseSB3
aGF0IGEgZHJpdmVyIGlzIHN1cHBvc2UKPiB0byBiZSBkb2luZy4gVGhlc2UgYXJlIHRyYW5zcG9y
dCBlbmFibGUvZGlzYWJsZSBjYWxsYmFja3MgZnJvbSB0aGUgQlQKPiBDb3JlIHRvd2FyZHMgdGhl
IGRyaXZlci4gSXQgbWFwcyB0byBhIGRldmljZSBiZWluZyBlbmFibGVkL2Rpc2FibGVkIGJ5Cj4g
c29tZXRoaW5nIGxpa2UgYmx1ZXRvb3RoZCBmb3IgZXhhbXBsZS4gU28gaWYgZGlzYWJsZWQsIEkg
ZXhwZWN0IHRoYXQgbm8KPiByZXNvdXJjZXMvcXVldWVzIGFyZSBpbiB1c2UuCj4gCj4gTWF5YmUg
SSBtaXN1bmRlcnN0YW5kIHRoZSB2aXJ0aW8gc3BlYyBpbiB0aGF0IHJlZ2FyZCwgYnV0IEkgd291
bGQgbGlrZQo+IHRvIGtlZXAgdGhpcyBmdW5kYW1lbnRhbCBjb25jZXB0IG9mIGEgQmx1ZXRvb3Ro
IGRyaXZlci4gSXQgZG9lcyB3b3JrCj4gd2l0aCBhbGwgb3RoZXIgdHJhbnNwb3J0cyBsaWtlIFVT
QiwgU0RJTywgVUFSVCBldGMuCj4gCj4gPiBUaGUgY29zdCBoZXJlIGlzIGEgc2luZ2xlIHNrYiB3
YXN0ZWQgb24gYW4gdW51c2VkIGJ0IGRldmljZSAtIHdoaWNoCj4gPiBzZWVtcyBtb2Rlc3QuCj4g
Cj4gVGhlcmUgc2hvdWxkIGJlIG5vIGJ1ZmZlciB1c2VkIGlmIHRoZSBkZXZpY2UgaXMgcG93ZXJl
ZCBvZmYuIFdlIGFsc28gZG9u4oCZdAo+IGhhdmUgYW55IFVTQiBVUkJzIGluLWZsaWdodCBpZiB0
aGUgdHJhbnNwb3J0IGlzIG5vdCBhY3RpdmUuCj4gCj4gPiBOQjogd2l0aCB0aGlzIGZpeCBpbiBw
bGFjZSBkcml2ZXIgc3RpbGwgc3VmZmVycyBmcm9tIGEgcmFjZSBjb25kaXRpb24gaWYKPiA+IGFu
IGludGVycnVwdCB0cmlnZ2VycyB3aGlsZSBkZXZpY2UgaXMgYmVpbmcgcmVzZXQuIFdvcmsgb24g
YSBmaXggZm9yCj4gPiB0aGF0IGlzc3VlIGlzIGluIHByb2dyZXNzLgo+IAo+IEluIHRoZSB2aXJ0
YnRfY2xvc2UoKSBjYWxsYmFjayB3ZSBzaG91bGQgZGVhY3RpdmF0ZSBhbGwgaW50ZXJydXB0cy4K
PiAKPiBSZWdhcmRzCj4gCj4gTWFyY2VsCgpTbyBNYXJjZWwsIGRvIEkgcmVhZCBpdCByaWdodCB0
aGF0IHlvdSBhcmUgd29ya2luZyBvbiBhIGZpeAphbmQgSSBjYW4gZHJvcCB0aGlzIHBhdGNoIGZv
ciBub3c/CgotLSAKTVNUCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
