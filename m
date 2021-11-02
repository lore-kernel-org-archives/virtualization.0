Return-Path: <SRS0=IhT0=PV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DED66C433EF
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 07:39:46 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 8041360EB9
	for <virtualization@archiver.kernel.org>; Tue,  2 Nov 2021 07:39:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 8041360EB9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 33EE640276;
	Tue,  2 Nov 2021 07:39:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id m8wvYGgjCM_N; Tue,  2 Nov 2021 07:39:45 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 9C44A40132;
	Tue,  2 Nov 2021 07:39:44 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6FCD8C0012;
	Tue,  2 Nov 2021 07:39:44 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B3CA3C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 07:39:43 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9ABFC401F6
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 07:39:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id u-ORBeJfXZFz
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 07:39:42 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B184040132
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Nov 2021 07:39:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1635838781;
 h=from:from:reply-to:reply-to:subject:subject:date:date:
 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
 content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=iYJ+rzPHjNuYUW6zXStopClVVMx1ShvzWhMFsee97fE=;
 b=iGEbYaf/cXKiuvYWLuwkJjj1z7/F2+1vhYl3bs1pEkM3eN9yuMj8b7suMMkN5lIwV1ekru
 F2aNiytjO1M8okiQ0hMi//e9oDAqq9FW3l2TUOcgCzjXFpdXIWVIySI0+XQQwnssU9zQ5K
 RxvRwdD7Vk2ayadSJq0cI+SynINKaK8=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-456-dzWo-qkRM7SjhkI9hejj-g-1; Tue, 02 Nov 2021 03:39:40 -0400
X-MC-Unique: dzWo-qkRM7SjhkI9hejj-g-1
Received: by mail-wr1-f69.google.com with SMTP id
 q7-20020adff507000000b0017d160d35a8so4003201wro.4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 02 Nov 2021 00:39:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references
 :user-agent:reply-to:date:message-id:mime-version
 :content-transfer-encoding;
 bh=rvM+Poc8HmK0BbG3MONenb/GbOeLn0E+m/VzqR43GaU=;
 b=23E0oxWaXechlDWWKT5jKt5kqfUHd5AaH5mHNLkOBTyd6kWk0IywlouKnLY8yRo0vj
 wCcHeCABQ2li6fFTpH3vYgTgnhOVvqoVYH31ZzNTpDnHPS0bs82tQbwGdVHgv8GTs69f
 u7/gRb0qa09tXonT8/mW9KrhSYJWATrTvO0T9QeHDU2s0O3ygBa4vzNpXMfDNsgP8ngz
 39l9Usg/haZXloVsGqvHHNx54DJPZqPdO9Th3QCbUI9gm0vNolS2r7FswyykX/SU+hZ8
 M2a2VPCQi0e47svMvQOo7YRm40aFlxxLi1B9td07CtdsqoMAm1N/gNpNPAC4MNvK1TY5
 cGYA==
X-Gm-Message-State: AOAM533XIxiBbOoMd0n+r6CoT5lOgIJDerZrTTPaBlk4UGLxg0r1ce9x
 Ygkzq6oIwkmBRicTK4K1Sw/H6A0JXJCeBTZUFr4VS8s//QmliVgK0fjPXnesl0L9r9qXzi0kQst
 d0e7Kx83qErBFpW1snM2RS/fLhM5FggJjBHSwxMqiHA==
X-Received: by 2002:a5d:5144:: with SMTP id u4mr38439751wrt.91.1635838779288; 
 Tue, 02 Nov 2021 00:39:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxy+z3nFQGpQaDjuMoiWl0dWnpUbkeD+0o1Qxrj5xdUgGO0aNAPyIJ6uswMVBNtDdR+HtpFSg==
X-Received: by 2002:a5d:5144:: with SMTP id u4mr38439734wrt.91.1635838779151; 
 Tue, 02 Nov 2021 00:39:39 -0700 (PDT)
Received: from localhost ([188.26.219.88])
 by smtp.gmail.com with ESMTPSA id e12sm535754wrq.20.2021.11.02.00.39.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Nov 2021 00:39:38 -0700 (PDT)
From: Juan Quintela <quintela@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [RFC PATCH v5 02/26] vhost: Fix last queue index of devices
 with no cvq
In-Reply-To: <20211102033023-mutt-send-email-mst@kernel.org> (Michael
 S. Tsirkin's message of "Tue, 2 Nov 2021 03:32:32 -0400")
References: <20211029183525.1776416-1-eperezma@redhat.com>
 <20211029183525.1776416-3-eperezma@redhat.com>
 <87a6inow7s.fsf@secure.mitica>
 <20211102033023-mutt-send-email-mst@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.2 (gnu/linux)
Date: Tue, 02 Nov 2021 08:39:37 +0100
Message-ID: <87v91bngzq.fsf@secure.mitica>
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=quintela@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Laurent Vivier <lvivier@redhat.com>, Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>, qemu-devel@nongnu.org,
 Markus Armbruster <armbru@redhat.com>,
 Eugenio =?utf-8?Q?P=C3=A9rez?= <eperezma@redhat.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Eli Cohen <eli@mellanox.com>,
 Paolo Bonzini <pbonzini@redhat.com>, Eric Blake <eblake@redhat.com>,
 virtualization@lists.linux-foundation.org, Parav Pandit <parav@mellanox.com>
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
Reply-To: quintela@redhat.com
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

Ik1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPiB3cm90ZToKPiBPbiBUdWUsIE5v
diAwMiwgMjAyMSBhdCAwODoyNToyN0FNICswMTAwLCBKdWFuIFF1aW50ZWxhIHdyb3RlOgo+PiBF
dWdlbmlvIFDDqXJleiA8ZXBlcmV6bWFAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+ID4gVGhlIC0xIGFz
c3VtZXMgdGhhdCBhbGwgZGV2aWNlcyB3aXRoIG5vIGN2cSBoYXZlIGFuIHNwYXJlIHZxIGFsbG9j
YXRlZAo+PiA+IGZvciB0aGVtLCBidXQgd2l0aCBubyBvZmZlciBvZiBWSVJUSU9fTkVUX0ZfQ1RS
TF9WUS4gVGhpcyBtYXkgbm90IGJlIHRoZQo+PiA+IGNhc2UsIGFuZCB0aGUgZGV2aWNlIG1heSBo
YXZlIGEgcGFpciBudW1iZXIgb2YgcXVldWVzLgo+PiAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgXl5eXgo+PiBldmVuCj4+IAo+PiBJIGtub3csIEkga25vdywgSSBhbSBTcGFuaXNo
IG15c2VsZiBPOi0pCj4KPiBOb2JvZHkgZXhwZWN0cyB0aGUgU3BhbmlzaCA7KQoKTzotKQoKPj4g
aW50IG1haW4odm9pZCkKPj4gewo+PiAJaW50IGkgPSA3Owo+PiAJaSAmPSAtMVVMTDsKPgo+IFN0
ZWZhbm8ncyBwYXRjaCBoYXMgfjFVTEwgLCBub3QgLTFVTEwgaGVyZS4KPgoKU3R1cGlkIGV5ZXMu
CgpUaGFua3MsIEp1YW4uCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
