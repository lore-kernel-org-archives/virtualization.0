Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B212C43334
	for <virtualization@archiver.kernel.org>; Mon, 20 Jun 2022 09:38:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BD52241817;
	Mon, 20 Jun 2022 09:38:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org BD52241817
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=VNoHXUA0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id irAjFL5_HTpn; Mon, 20 Jun 2022 09:38:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id EA375417C2;
	Mon, 20 Jun 2022 09:38:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EA375417C2
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C7019C0039;
	Mon, 20 Jun 2022 09:38:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2BF69C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 09:38:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 138EB60F2B
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 09:38:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 138EB60F2B
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=VNoHXUA0
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id IIlGin-pWxax
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 09:38:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5B70560625
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5B70560625
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 09:38:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655717878;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mVJ4Pc7idX3cRmZ7fOi1Ns6MbMDwBjisN2g0tryFY6w=;
 b=VNoHXUA0DL40Zi+bDVAE6jIYIhn4fWCiQZa8Rl/r5v6jmgUdvxMC3lECUl+oA59n31dhK0
 +MHtrEKUpUeb63AII4lkI+q3GCDfIo4QKsWOBTkNPKDXEsby8ZfPF7jjblmBfQLh1QbQd4
 RHEdTtraQCdfxYKt7ITrv16xgtMzTf0=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-99-mGLpOK-wOlGEOcRkFNsqaw-1; Mon, 20 Jun 2022 05:37:56 -0400
X-MC-Unique: mGLpOK-wOlGEOcRkFNsqaw-1
Received: by mail-wm1-f71.google.com with SMTP id
 z13-20020a7bc7cd000000b0039c4a238eadso3157667wmk.9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 20 Jun 2022 02:37:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=mVJ4Pc7idX3cRmZ7fOi1Ns6MbMDwBjisN2g0tryFY6w=;
 b=DRw3MJK6E/0y6cRwl/IBNZb7GH+tUQ4HWFF6OxIniB+0N6EUC+G6SIwZ5xF4OQMGGi
 FKHHAe5JDU/kn9KOMXwmd4sFgkvHjYEPKuQ1iN5nOEEdUvqFN68dXEQYdSAsygDCkdTZ
 IB+4LpKOm2I+BeEs0dMddVkK75ORnFyhbs3aVJ/7bxZKHSCLOn99zZxBqaXld1les2a6
 1xy3yHVQpFmuNFqw2DHVcXeKQGw9/aPSxwhOQN9J6qyk44dhYJsisfzk8yEAWXLzPuYB
 6M68+vSIi7y4OSMjg108ME+mz6k61ZeNBhbNUeoYLpBNrHHzEMPfJUb26qc1hJe0jncH
 a9Zg==
X-Gm-Message-State: AJIora9HVUE7JGvJ6NeY/ee04ASCy7xLHsuK79Kl44FzpKaeCu35UQzW
 pQj5sSEndQo7zg/uCzBMnjIndt6QSNTq9imkZwwoUSZTcip8nDObC1qzA6Qp8x1SzTi99RwgOc4
 ToLLMQS21AJl7X2ZOk6E+5FI2W1BgXDNiNGK7/Har1w==
X-Received: by 2002:a05:6000:2a4:b0:213:bb34:7ff6 with SMTP id
 l4-20020a05600002a400b00213bb347ff6mr22791894wry.292.1655717875391; 
 Mon, 20 Jun 2022 02:37:55 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tkrLOZNzUhdaLZd1T7cZrm18QpT/h/SI9PyK8jG4W9Tt/2oH4zMfDzBTXmcISzHSSxAUXX6A==
X-Received: by 2002:a05:6000:2a4:b0:213:bb34:7ff6 with SMTP id
 l4-20020a05600002a400b00213bb347ff6mr22791874wry.292.1655717875163; 
 Mon, 20 Jun 2022 02:37:55 -0700 (PDT)
Received: from sgarzare-redhat (host-79-46-200-40.retail.telecomitalia.it.
 [79.46.200.40]) by smtp.gmail.com with ESMTPSA id
 h8-20020a05600c350800b0039c50d2d28csm18574590wmq.44.2022.06.20.02.37.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 20 Jun 2022 02:37:54 -0700 (PDT)
Date: Mon, 20 Jun 2022 11:37:50 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Bo Liu =?utf-8?B?KOWImOazoikt5rWq5r2u5L+h5oGv?= <liubo03@inspur.com>
Subject: Re: [PATCH] virtio: Remove unnecessary variable assignments
Message-ID: <20220620093750.ug6g7vzrninakd3x@sgarzare-redhat>
References: <d6527c0690634815820c1c7c04b31551@inspur.com>
MIME-Version: 1.0
In-Reply-To: <d6527c0690634815820c1c7c04b31551@inspur.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "mst@redhat.com" <mst@redhat.com>
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

SGkgQm8sCgpPbiBNb24sIEp1biAyMCwgMjAyMiBhdCAwOTozMjoyOEFNICswMDAwLCBCbyBMaXUg
KOWImOazoikt5rWq5r2u5L+h5oGvIHdyb3RlOgo+SGkKPgo+Pk9uIEZyaSwgSnVuIDE3LCAyMDIy
IGF0IDAxOjU5OjUyQU0gLTA0MDAsIEJvIExpdSB3cm90ZToKPj4+SW4gZnVuY3Rpb24gdnBfbW9k
ZXJuX3Byb2JlKCksICJtZGV2LT5wY2lfZGV2IiBpcyBhc3NpZ25lZCB0byAKPj4+dmFyaWFibGUK
Pj4+InBjaV9kZXYiLCB2YXJpYWJsZSAicGNpX2RldiIgYW5kICJtZGV2LT5wY2lfZGV2IiBoYXZl
IHRoZSBzYW1lIAo+Pj52YWx1ZS4KPj4+VGhlcmUgaXMgbm8gbmVlZCB0byBhc3NpZ24gdmFyaWFi
bGUgInBjaV9kZXYiIHRvICJtZGV2LT5wY2lfZGV2Ii4gU28KPj4+cmVtb3ZlIGl0Lgo+Pj4KPj4K
Pj5JIHN1Z2dlc3QgcmVwaHJhc2luZyB0aGUgZGVzY3JpcHRpb24gYSBiaXQuCj4+TWF5YmUgaW50
byBzb21ldGhpbmcgbGlrZSB0aGlzOgo+Pgo+PiAgICAgSW4gZnVuY3Rpb24gdnBfbW9kZXJuX3By
b2JlKCksICJwY2lfZGV2IiBpcyBpbml0aWFsaXplZCB3aXRoIHRoZQo+PiAgICAgdmFsdWUgb2Yg
Im1kZXYtPnBjaV9kZXYiLCBzbyBhc3NpZ25pbmcgInBjaV9kZXYiIHRvIAo+PiAgICAgIm1kZXYt
PnBjaV9kZXYiCj4+ICAgICBpcyB1bm5lY2Vzc2FyeSBzaW5jZSB0aGV5IHN0b3JlIHRoZSBzYW1l
IHZhbHVlLgo+Pgo+PkFueXdheSwgdGhlIHBhdGNoIExHVE06Cj4+Cj4+UmV2aWV3ZWQtYnk6IFN0
ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4KPj4KPlRoZSBuZXcgcGF0Y2gg
aXM6Cj4KPkluIGZ1bmN0aW9uIHZwX21vZGVybl9wcm9iZSgpLCAicGNpX2RldiIgaXMgaW5pdGlh
bGl6ZWQgd2l0aCB0aGUKPnZhbHVlIG9mICJtZGV2LT5wY2lfZGV2Iiwgc28gYXNzaWduaW5nICJw
Y2lfZGV2IiB0byAibWRldi0+cGNpX2RldiIKPmlzIHVubmVjZXNzYXJ5IHNpbmNlIHRoZXkgc3Rv
cmUgdGhlIHNhbWUgdmFsdWUuCj4KPlNpZ25lZC1vZmYtYnk6IEJvIExpdSA8bGl1Ym8wM0BpbnNw
dXIuY29tPgo+LS0tCj4gZHJpdmVycy92aXJ0aW8vdmlydGlvX3BjaV9tb2Rlcm5fZGV2LmMgfCAy
IC0tCj4gMSBmaWxlIGNoYW5nZWQsIDIgZGVsZXRpb25zKC0pCgpJdCBsb29rcyBnb29kLCBidXQg
SSB0aGluayBpdCBpcyBiZXR0ZXIgdG8gc2VuZCBhIHByb3BlciB2Mi4KCllvdSBjYW4gYWxzbyBh
ZGQgbXkgUi1iIGp1c3QgYmVmb3JlIHlvdXIgUy1vLWIKClRoYW5rcywKU3RlZmFubwoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
