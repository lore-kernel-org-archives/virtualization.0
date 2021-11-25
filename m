Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C708AC433EF
	for <virtualization@archiver.kernel.org>; Thu, 25 Nov 2021 20:45:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 5CE0A81C71;
	Thu, 25 Nov 2021 20:45:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id VveNgzxBy7Sn; Thu, 25 Nov 2021 20:45:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 1854080EDF;
	Thu, 25 Nov 2021 20:45:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D14FFC001C;
	Thu, 25 Nov 2021 20:45:05 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 30A83C000A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 20:45:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 0EB22401D2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 20:45:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id DEev63GWfnL7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 20:45:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BF4684013C
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 20:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1637873101;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=a8msmL+dSCBGccxnAPs58z4VsuX8uw6fgQ0C8pTfMp8=;
 b=WNmVd8s8H0BlN0W9C3x1zBn0q+U3m1o7E+wWJR9OAuiCmBPrFBQvn2lKB7FIwUASGDYIxh
 bk6zsvPAYpmGrl/hGkxoN6Wpwv8uE3SIN28XmPAm3c6mKnmMcbyYpP+VUjDtFWp9Di7ACH
 kypDnMl7r6HlrUVP8lbWBK8FjqrqAW8=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-523-IxetfPXwPv6PEc_uh4SW2w-1; Thu, 25 Nov 2021 15:45:00 -0500
X-MC-Unique: IxetfPXwPv6PEc_uh4SW2w-1
Received: by mail-ed1-f72.google.com with SMTP id
 f4-20020a50e084000000b003db585bc274so6193831edl.17
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Nov 2021 12:45:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=a8msmL+dSCBGccxnAPs58z4VsuX8uw6fgQ0C8pTfMp8=;
 b=j+bacZ5q4rFFfKnGsldsD8qS2OUOhcN1xRJKrLjpOBKIp5TEAkLlElK8E59TU+HTfj
 s5X+JWyZH9eyC++smirKkq0oV4mifwnGVSYUEG6r7MjH2ksCUKFmgLF4CA1cT2LD/WF4
 lFDn468IYIR/CrS3jUQfAbctgQ+oMLA/PXLUKEy2m+ykXrmaPfxzKJxWsjwuWfJHXksd
 FwRfuSxvXxBAK9SdXukQScwyC45tRxNgio+1LIWEWYBpUq0EtzEm9o1XU8Wi59iXoPeY
 Z4KZX8NmpM+thLgM1/UGJabMEur2AUBwaC+QC4+58nbKlXz1ewMB1xgGpFbNWhvixk77
 1uPQ==
X-Gm-Message-State: AOAM533OdJT9ahjIXVGDuTFCMImQSQ2gONpbeImnC5JSEr6RGEJThQ/L
 CowO4U2YbDvXP5VLTZxVwqqv+ZyViDEPKUfACYwP+UPeZoZ0efsUnmag60PIvpPstxPA92TZEMW
 5BDw/fbZeFcOLRpKoQ2PD5+K4f5bHBau2loziOQZNEg==
X-Received: by 2002:aa7:d495:: with SMTP id b21mr42133447edr.363.1637873099230; 
 Thu, 25 Nov 2021 12:44:59 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwTPqNf4VUuW6BEDfui/hzHRpzYVp59pV4nohAawMz1FPQT58MahY5ZHh9BtXtttz+cGKXN+w==
X-Received: by 2002:aa7:d495:: with SMTP id b21mr42133412edr.363.1637873099013; 
 Thu, 25 Nov 2021 12:44:59 -0800 (PST)
Received: from redhat.com ([2a03:c5c0:207e:e87:2d40:4ed4:5676:5c1a])
 by smtp.gmail.com with ESMTPSA id x22sm2015527ejc.97.2021.11.25.12.44.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Nov 2021 12:44:58 -0800 (PST)
Date: Thu, 25 Nov 2021 15:44:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Marcel Holtmann <marcel@holtmann.org>
Subject: Re: [PATCH] Bluetooth: virtio_bt: fix device removal
Message-ID: <20211125154314-mutt-send-email-mst@kernel.org>
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
PiAKPiBSZWdhcmRzCj4gCj4gTWFyY2VsCgpJZiB5b3Ugd2FudCB0byBkbyB0aGF0IHRoZW4gZGV2
aWNlIGhhcyB0byBiZSByZXNldCBvbiBjbG9zZSwKYW5kIGZ1bGx5IHJlaW5pdGlhbGl6ZWQgb24g
b3Blbi4KQ2FuIHlvdSB3b3JrIG9uIGEgcGF0Y2ggbGlrZSB0aGF0PwpHaXZlbiBJIGRvbid0IGhh
dmUgdGhlIGRldmljZSBzdWNoIGEgcmV3b3JrIGlzIHByb2JhYmx5IG1vcmUKdGhhbiBJIGNhbiB1
bmRlcnRha2UuCgotLSAKTVNUCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlz
dHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3Jn
L21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
