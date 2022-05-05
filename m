Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B90C9C433EF
	for <virtualization@archiver.kernel.org>; Thu,  5 May 2022 08:16:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 6AB4A83FF1;
	Thu,  5 May 2022 08:16:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1w7bC270uqSg; Thu,  5 May 2022 08:16:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 16F6B83FC8;
	Thu,  5 May 2022 08:16:05 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E1B64C0032;
	Thu,  5 May 2022 08:16:04 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E804BC002D
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 08:16:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id D5D1C60D71
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 08:16:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9IAyJqXHip0K
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 08:16:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-74.mimecast.com
 (us-smtp-delivery-74.mimecast.com [170.10.129.74])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 29EDD60B8E
 for <virtualization@lists.linux-foundation.org>;
 Thu,  5 May 2022 08:16:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651738561;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=do1UvCnuc5di86ZbdYll8zHp7a0uqEH80l8XkiVHqz0=;
 b=clMpJvRZY2WyqEKtLTeaG0lXVMPQ0JmhxQAKmPKmX22c67FNmWtyg/x/3BahJ53FPLw2Ns
 i4AagX+CPWXjswN3CDxSR8EM403woUi4oS/xLZF/GnEVrUJvy1sWChfiVgyJxR7bUeYSDC
 isazcYQbPDfkA7Me8Lb+69XWMKBwRgo=
Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com
 [209.85.216.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-209-WvS3eBTLNtecy4IzfXr9ig-1; Thu, 05 May 2022 04:15:56 -0400
X-MC-Unique: WvS3eBTLNtecy4IzfXr9ig-1
Received: by mail-pj1-f70.google.com with SMTP id
 o8-20020a17090a9f8800b001dc9f554c7fso1639207pjp.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 05 May 2022 01:15:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=do1UvCnuc5di86ZbdYll8zHp7a0uqEH80l8XkiVHqz0=;
 b=lqRmxcPCX1TBPWN79n9FMP8UvXnVxtzM1imNn+Jl/lJS3C1Ua1dW1zTlyXnRhn+ux+
 uecRnSZlU1sFTAk9452WsHfOaV33EHAC+SkWQpF9FPMqmNyfEpAvzikKSk21z8NOF+E4
 /kt1yeQ/ulQZRpHhCp6OKO4LSEv1Au8BiSqg698R+bO7Y7Rzz0UUEWQR4wkR9+8R9ZFu
 Y6EYtzFsFIF9fIitLrGpelVpLDvDyfCg6ObdxDau0S6WPCWGQSnROCEAsbZxEkg4O9aE
 jOjbNuaU5pRp9gaKWSVKnc96F93XrurXLkjfbFDDEfqv43M4ECFp/1z3TNJSYqoUcY8F
 PNGQ==
X-Gm-Message-State: AOAM5331/M9oGR+9G63tk3cXfYDBFGCeDzPHTgN1Oh0LNU4HqNsKBxcu
 MwZJiU9ipRtvc1wlXB7yx3TbLZTGQERc0FAKR+0nZsdvzMPVRwWn0QnGw3GORE7oXeSh4//t0s9
 3HHF7itCaUubWYYOAgBRsCg9k4gHk37tlr7CLWcTFbQ==
X-Received: by 2002:a17:90b:4acb:b0:1dc:32dd:d51e with SMTP id
 mh11-20020a17090b4acb00b001dc32ddd51emr4536840pjb.5.1651738555899; 
 Thu, 05 May 2022 01:15:55 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpduv1Ktx/cekWb28nZP/0aCNFGUL1g8LskDyDIqV4bXgu7v49iSg3ZoEhWf+Kaxx0D13mxg==
X-Received: by 2002:a17:90b:4acb:b0:1dc:32dd:d51e with SMTP id
 mh11-20020a17090b4acb00b001dc32ddd51emr4536817pjb.5.1651738555672; 
 Thu, 05 May 2022 01:15:55 -0700 (PDT)
Received: from [10.72.13.116] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 m3-20020a170902bb8300b0015e8d4eb2c2sm829079pls.268.2022.05.05.01.15.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 05 May 2022 01:15:55 -0700 (PDT)
Message-ID: <fe3c54a2-f6eb-96a8-425e-07df6b7b7f95@redhat.com>
Date: Thu, 5 May 2022 16:15:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH V3 3/9] virtio: introduce config op to synchronize vring
 callbacks
To: Cornelia Huck <cohuck@redhat.com>
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-4-jasowang@redhat.com> <87r15hlgel.fsf@redhat.com>
 <CACGkMEsrSHtD9iO1qHjMGgwG5YwYVpX+7OKZaN9Oq29tPpGZYg@mail.gmail.com>
 <87ilqsl5ba.fsf@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <87ilqsl5ba.fsf@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Paul E. McKenney" <paulmck@kernel.org>, Cindy Lu <lulu@redhat.com>,
 mst <mst@redhat.com>, Peter Zijlstra <peterz@infradead.org>,
 Marc Zyngier <maz@kernel.org>, linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Halil Pasic <pasic@linux.ibm.com>, eperezma <eperezma@redhat.com>,
 Thomas Gleixner <tglx@linutronix.de>
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

CuWcqCAyMDIyLzQvMjkgMTU6MjUsIENvcm5lbGlhIEh1Y2sg5YaZ6YGTOgo+IE9uIEZyaSwgQXBy
IDI5IDIwMjIsIEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+Cj4+IE9u
IFRodSwgQXByIDI4LCAyMDIyIGF0IDU6MTMgUE0gQ29ybmVsaWEgSHVjayA8Y29odWNrQHJlZGhh
dC5jb20+IHdyb3RlOgo+Pj4gT24gTW9uLCBBcHIgMjUgMjAyMiwgSmFzb24gV2FuZyA8amFzb3dh
bmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pgo+Pj4+IFRoaXMgcGF0Y2ggaW50cm9kdWNlcyBuZXcg
dmlydGlvIGNvbmZpZyBvcCB0byB2cmluZwo+Pj4+IGNhbGxiYWNrcy4gVHJhbnNwb3J0IHNwZWNp
ZmljIG1ldGhvZCBpcyByZXF1aXJlZCB0byBtYWtlIHN1cmUgdGhlCj4+Pj4gd3JpdGUgYmVmb3Jl
IHRoaXMgZnVuY3Rpb24gaXMgdmlzaWJsZSB0byB0aGUgdnJpbmdfaW50ZXJydXB0KCkgdGhhdCBp
cwo+Pj4gV2hpY2gga2luZCBvZiB3cml0ZXM/IEkuZS4sIHdoYXQgaXMgdGhlIHNjb3BlPwo+PiBB
bnkgd3JpdGVzIGJlZm9yZSBzeW5jaHJvbml6ZV9jYnMoKS4gSXMgc29tZXRoaW5nIGxpa2UgdGhl
IGZvbGxvd2luZyBiZXR0ZXI/Cj4+Cj4+IFRoZSBmdW5jdGlvbiBndWFyYW50ZWVzIHRoYXQgYWxs
IG1lbW9yeSBvcGVyYXRpb25zIGJlZm9yZSBpdCBhcmUKPj4gdmlzaWJsZSB0byB0aGUgdnJpbmdf
aW50ZXJydXB0KCkgdGhhdCBpcyBjYWxsZWQgYWZ0ZXIgaXQuCj4gTWF5YmUgImFsbCBtZW1vcnkg
b3BlcmF0aW9ucyBvbiB0aGUgcXVldWUiPwoKClRoYXQncyBmaW5lLiBXaWxsIGRvLgoKVGhhbmtz
CgoKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
