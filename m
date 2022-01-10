Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2556C433EF
	for <virtualization@archiver.kernel.org>; Mon, 10 Jan 2022 06:43:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 741DB40122;
	Mon, 10 Jan 2022 06:43:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6j3iAeODFh18; Mon, 10 Jan 2022 06:43:53 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E99814031D;
	Mon, 10 Jan 2022 06:43:52 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C1CD8C002F;
	Mon, 10 Jan 2022 06:43:52 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E9E2FC001E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 06:43:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C54AD408C3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 06:43:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id JFWxSpmjcDoh
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 06:43:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id CF0CA408C2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 10 Jan 2022 06:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641797028;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=0UvMVH7WTutQSpoo5QOJ8lH39ONqkVGG5QpK+2wuIr4=;
 b=I6edVCQVYHRVX8ztH6u1m9CajmDcTyE2TN2CQLXqquCwAqxqGC//Zy0y/cIzZOIie/AF3L
 0crnapZPIk8pzNPTC9wYCbB9DpnML6nrW1GbjRC9/bDt7HmSkNty76vtK2vF5A5ru0Y3Cn
 +tc4RLw8nESb6kmMIAR0TXsoYbdX+2c=
Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com
 [209.85.210.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-8-ue_pLY2fNtSCLDeNIPX9XQ-1; Mon, 10 Jan 2022 01:43:47 -0500
X-MC-Unique: ue_pLY2fNtSCLDeNIPX9XQ-1
Received: by mail-pf1-f199.google.com with SMTP id
 w189-20020a6262c6000000b004ba80a30727so7364822pfb.1
 for <virtualization@lists.linux-foundation.org>;
 Sun, 09 Jan 2022 22:43:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=0UvMVH7WTutQSpoo5QOJ8lH39ONqkVGG5QpK+2wuIr4=;
 b=oEZMwW2dxza+hsHSSnRvUjbs7a5xw8JiwUG2PBI6YH+pI0BFqIxBQ6+yfg4DZFsDTq
 blx66qA/4mzEEeOnDdfqYu0CFre6KwZMASexWPurl0OHTPQJvRAit5Bnz1O66XxnwzKh
 ll9RBQ7lqONN9EXWNEPUgFr1Idpcr3PUwn032/VvybC4pdS21mgzQ4Kj12DSykOnsXil
 M+QUs/JdecWrPy6o7Sy49xzLCNQ6h1vKSn1tzFdgZUUPXKq84NaAt3/r9ZTSkovfDxN6
 jpgrZYYXdlXZ5uLOq0qBw7GcedqyZEPKj9a3JghaotjXNCKMH1jmAuwIbKrDcXY94WMG
 1FLw==
X-Gm-Message-State: AOAM533U77D6mlrsNAcDJmgth/WPKZz6eSBeIpQtsGz1CBiDzPBMd7sY
 mkpZHSB0sb32gLl2dkwtje26Qwe3ivyyeQSR4itwiiXOUC/dgBjEvw37lcGKLCHAMfXtkwBkd3D
 3GhCTwks6xqOIms2uZeSqMq8omvUVMTob9+Yo4WzcQg==
X-Received: by 2002:a17:902:b189:b0:149:6c45:24c with SMTP id
 s9-20020a170902b18900b001496c45024cmr67116660plr.21.1641797026403; 
 Sun, 09 Jan 2022 22:43:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJytu8kA6lg5HVTMD0wDgZuhM2g4fc5WJQ29ZdlklKsZU98g5v7kKWhRrj7EVTgYG2OS9qOMeQ==
X-Received: by 2002:a17:902:b189:b0:149:6c45:24c with SMTP id
 s9-20020a170902b18900b001496c45024cmr67116652plr.21.1641797026163; 
 Sun, 09 Jan 2022 22:43:46 -0800 (PST)
Received: from [10.72.13.131] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id lx15sm979190pjb.37.2022.01.09.22.43.44
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 09 Jan 2022 22:43:45 -0800 (PST)
Message-ID: <c649faa9-aa1f-e5ff-a448-0abce38eeff9@redhat.com>
Date: Mon, 10 Jan 2022 14:43:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.4.1
Subject: Re: [PATCH 2/6] virtio: split: alloc indirect desc with extra
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220107063306.23240-1-xuanzhuo@linux.alibaba.com>
 <20220107063306.23240-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220107063306.23240-3-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>
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

CuWcqCAyMDIyLzEvNyDkuIvljYgyOjMzLCBYdWFuIFpodW8g5YaZ6YGTOgo+IEluIHRoZSBzY2Vu
YXJpbyB3aGVyZSBpbmRpcmVjdCBpcyBub3QgdXNlZCwgZWFjaCBkZXNjIGNvcnJlc3BvbmRzIHRv
IGFuCj4gZXh0cmEsIHdoaWNoIGlzIHVzZWQgdG8gcmVjb3JkIGluZm9ybWF0aW9uIHN1Y2ggYXMg
ZG1hLCBmbGFncywgYW5kCj4gbmV4dC4KPgo+IEluIHRoZSBzY2VuYXJpbyBvZiB1c2luZyBpbmRp
cmVjdCwgdGhlIGFzc2lnbmVkIGRlc2MgZG9lcyBub3QgaGF2ZSB0aGUKPiBjb3JyZXNwb25kaW5n
IGV4dHJhIHJlY29yZCBkbWEgaW5mb3JtYXRpb24sIGFuZCB0aGUgZG1hIGluZm9ybWF0aW9uIG11
c3QKPiBiZSBvYnRhaW5lZCBmcm9tIHRoZSBkZXNjIHdoZW4gdW5tYXAuCj4KPiBUaGlzIHBhdGNo
IGFsbG9jYXRlcyB0aGUgY29ycmVzcG9uZGluZyBleHRyYSBhcnJheSB3aGVuIGluZGlyZWN0IGRl
c2MgaXMKPiBhbGxvY2F0ZWQuIFRoaXMgaGFzIHRoZXNlIGFkdmFudGFnZXM6Cj4gMS4gUmVjb3Jk
IHRoZSBkbWEgaW5mb3JtYXRpb24gb2YgZGVzYywgbm8gbmVlZCB0byByZWFkIGRlc2Mgd2hlbiB1
bm1hcAo+IDIuIEl0IHdpbGwgYmUgbW9yZSBjb252ZW5pZW50IGFuZCB1bmlmaWVkIGluIHByb2Nl
c3NpbmcKPiAzLiBTb21lIGFkZGl0aW9uYWwgaW5mb3JtYXRpb24gY2FuIGJlIHJlY29yZGVkIGlu
IGV4dHJhLCB3aGljaCB3aWxsIGJlCj4gICAgIHVzZWQgaW4gc3Vic2VxdWVudCBwYXRjaGVzLgoK
ClR3byBxdWVzdGlvbnM6CgoxKSBJcyB0aGVyZSBhbnkgcGVyZm9ybWFuY2UgbnVtYmVyIGZvciB0
aGlzIGNoYW5nZT8gSSBndWVzcyBpdCBnaXZlcyAKbW9yZSBzdHJlc3Mgb24gdGhlIGNhY2hlLgoy
KSBJcyB0aGVyZSBhIHJlcXVpcmVtZW50IHRvIG1peCB0aGUgcHJlIG1hcHBlZCBzZyB3aXRoIHVu
bWFwcGVkIHNnPyBJZiAKbm90LCBhIHBlciB2aXJ0cXVldWUgZmxhZyBsb29rcyBzdWZmaWNpZW50
CgpUaGFua3MKCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
XwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgt
Zm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4v
bGlzdGluZm8vdmlydHVhbGl6YXRpb24=
