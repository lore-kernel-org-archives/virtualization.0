Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C03D8C77B76
	for <virtualization@archiver.kernel.org>; Sun, 23 Apr 2023 07:19:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3259882033;
	Sun, 23 Apr 2023 07:19:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3259882033
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=BayY7Jgw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xBw-BC3wDRyQ; Sun, 23 Apr 2023 07:19:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id C68B282036;
	Sun, 23 Apr 2023 07:19:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org C68B282036
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9BB5DC0037;
	Sun, 23 Apr 2023 07:19:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 041DFC002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 07:19:25 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C35E0418AB
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 07:19:24 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org C35E0418AB
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=BayY7Jgw
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id p8mT-YpPFeOd
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 07:19:24 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D052C40277
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D052C40277
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 07:19:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682234362;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nOfk5KVt03Kw/nxPJuFXIUc7M+oFb5UuYNKx4WZp95g=;
 b=BayY7JgwPUKoTnFHruRBrkOD49yx/0BNTo5kuPOwnef+ecOQI7Zs18AxRe4q+X9RCNDWwe
 P1+ObnC6vjR6TW9xRzAVABEoJJzCoE45iIKtSZaxwxBs62LqHQVrMj5kw3KoJ6X1mBU3cF
 2aeQJ0bfBNv/pRyV/gUPR+NtXwoHkFw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-218-fldjShHZNy6SsDj5-CrsQg-1; Sun, 23 Apr 2023 03:19:20 -0400
X-MC-Unique: fldjShHZNy6SsDj5-CrsQg-1
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-3f16f50aeb5so11516615e9.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 00:19:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682234359; x=1684826359;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=nOfk5KVt03Kw/nxPJuFXIUc7M+oFb5UuYNKx4WZp95g=;
 b=FmjlAu1fdFff6AyDx+ec2X8StH7fezKF9Qr29O0EzebYW+lf81n73E619tOOjSvo1Z
 eOeFEwrQ/mxF8aM7OqpOt4vQFcxiAUV8vOmBbLtQuQrJxKnfwbOibts15ZAbqzMqHNqy
 Jw2/tHFKVu6J1Ob9qQAceI9pD8eJ0YqaZV/jusoj7W0HGhq1ObAkWfV8Yicw9CDkh9/k
 z+/3dvu8BL83IAQwt6WLEnt8si5VY9qyj/PjeIEQBZR4FaZTt8CUpLdkLb8BCGr7kTAL
 NHU2FZU9w33GCEOrCP+tZWs/JlDNqRqj9rz6iRKXautZf50vH37SgWU7/6xh+a/uIx4t
 xASA==
X-Gm-Message-State: AAQBX9cy9mj+Gejua13Toy0FFeKT9uRCh604jKUHzlyO4nrxzcfdXrHm
 cxBCrlBJDIvT+A6uPAu76Jl3N5AipXbswuUIK1o+ebRWG8CA0QqUBc8JXigTOpYl5w+rcVY+RUW
 CT82mBdTqUZNxXX9kjdY5gfINSe+zajHWzT3yezCwbg==
X-Received: by 2002:a1c:790e:0:b0:3f1:7288:1912 with SMTP id
 l14-20020a1c790e000000b003f172881912mr5053870wme.33.1682234359573; 
 Sun, 23 Apr 2023 00:19:19 -0700 (PDT)
X-Google-Smtp-Source: AKy350al0K0IJpL8RrXHGcCmLxmGOjejEQPiJFsouPKi82zaCtJVKp95uN3hEitLPfT62TTH3eSRFw==
X-Received: by 2002:a1c:790e:0:b0:3f1:7288:1912 with SMTP id
 l14-20020a1c790e000000b003f172881912mr5053855wme.33.1682234359214; 
 Sun, 23 Apr 2023 00:19:19 -0700 (PDT)
Received: from redhat.com ([2.55.61.39]) by smtp.gmail.com with ESMTPSA id
 z4-20020a05600c0a0400b003ef4cd057f5sm12633650wmp.4.2023.04.23.00.19.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 23 Apr 2023 00:19:18 -0700 (PDT)
Date: Sun, 23 Apr 2023 03:19:15 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
Subject: Re: [PATCH net] virtio-net: reject small vring sizes
Message-ID: <20230423031308-mutt-send-email-mst@kernel.org>
References: <20230417023911-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237BFB8BB3A3606CE6A408D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417030713-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723F3E6AE381AEC36D1AEFED49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417051816-mutt-send-email-mst@kernel.org>
 <AM0PR04MB47237705695AFD873DEE4530D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417073830-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723FA4F0FFEBD25903E3344D49C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
 <20230417075645-mutt-send-email-mst@kernel.org>
 <AM0PR04MB4723FA90465186B5A8A5C001D4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
In-Reply-To: <AM0PR04MB4723FA90465186B5A8A5C001D4669@AM0PR04MB4723.eurprd04.prod.outlook.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "edumazet@google.com" <edumazet@google.com>,
 "kuba@kernel.org" <kuba@kernel.org>, "pabeni@redhat.com" <pabeni@redhat.com>,
 "davem@davemloft.net" <davem@davemloft.net>
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

T24gU3VuLCBBcHIgMjMsIDIwMjMgYXQgMDY6NTE6NDZBTSArMDAwMCwgQWx2YXJvIEthcnN6IHdy
b3RlOgo+ID4gWWVzIHRoYXQgbWFrZXMgc2Vuc2UsIGl0J3MgYXJjaGl0ZXR1cmFsLiBXZSBjYW4g
ZGlzYWJsZSBjdHJsIHZxIHRob3VnaC4KPiAKPiBUaGUgcHJvYmxlbSBoZXJlIGlzIHRoYXQgd2Ug
a25vdyB0aGUgdnJpbmcgc2l6ZSBhZnRlciBjYWxsaW5nIHZpcnRuZXRfZmluZF92cXMsIHNvIHRo
ZSBudW1iZXIgb2YgVlFzIGFscmVhZHkgaW5jbHVkZXMgdGhlIGNvbnRyb2wgVlEuCj4gCj4gQWN0
dWFsbHksIG1hbnkgdmFyaWFibGVzL3NldHRpbmdzIHRoYXQgYXJlIGluaXRpYWxpemVkIGJlZm9y
ZSB3ZSBjYWxsIHZpcnRuZXRfZmluZF92cXMgbWF5IG5lZWQgbW9kaWZpY2F0aW9ucyBpZiB3ZSB1
c2Ugc21hbGwgdnJpbmdzLgo+IEZvciBleGFtcGxlIGhhc19yc3NfaGFzaF9yZXBvcnQsIGhhc19y
c3MsIGhkcl9sZW4gZXRjLi4KPiAKPiBXZSBjb3VsZCBoYXZlIGEgZml4dXAgZnVuY3Rpb24gdG8g
Zml4IGV2ZXJ5dGhpbmcgYWZ0ZXIgd2UgZGlzY292ZXIgdGhhdCB3ZSBhcmUgdXNpbmcgc21hbGwg
dnJpbmdzLCBidXQsIGhvbmVzdGx5LCBJIHRoaW5rIHRoYXQgdGhpcyB3aWxsIGJlIGhhcmQgdG8g
bWFpbnRhaW4gaW4gdGhlIGZ1dHVyZSwgYW5kIEkgZG9uJ3QgbGlrZSB0aGlzIGFwcHJvYWNoIG11
Y2guCj4gCj4gVGhlIGlkZWFsIHRoaW5nIHdpbGwgYmUgdG8gZGlzY292ZXIgaWYgd2UgdXNlIHNt
YWxsIHZyaW5ncyBpbiBwcm9iZSdzIGJlZ2lubmluZy4KPiAKPiBJJ20gbG9va2luZyBmb3IgYSB3
YXkgYXQgdGhlIG1vbWVudC4KCkhtbS4gSSB3YXMgd3JvbmcuIFRoZXJlIGlzIG5vIHdheSB0byBk
aXNhYmxlIENWUSBmZWF0dXJlIGJpdC4KCjEuIFJlc2V0IHRoZSBkZXZpY2UuCjIuIFNldCB0aGUg
QUNLTk9XTEVER0Ugc3RhdHVzIGJpdDogdGhlIGd1ZXN0IE9TIGhhcyBub3RpY2UgdGhlIGRldmlj
ZS4KMy4gU2V0IHRoZSBEUklWRVIgc3RhdHVzIGJpdDogdGhlIGd1ZXN0IE9TIGtub3dzIGhvdyB0
byBkcml2ZSB0aGUgZGV2aWNlLgo0LiBSZWFkIGRldmljZSBmZWF0dXJlIGJpdHMsIGFuZCB3cml0
ZSB0aGUgc3Vic2V0IG9mIGZlYXR1cmUgYml0cyB1bmRlcnN0b29kIGJ5IHRoZSBPUyBhbmQgZHJp
dmVyIHRvIHRoZQpkZXZpY2UuIER1cmluZyB0aGlzIHN0ZXAgdGhlIGRyaXZlciBNQVkgcmVhZCAo
YnV0IE1VU1QgTk9UIHdyaXRlKSB0aGUgZGV2aWNlLXNwZWNpZmljIGNvbmZpZ3VyYXRpb24KZmll
bGRzIHRvIGNoZWNrIHRoYXQgaXQgY2FuIHN1cHBvcnQgdGhlIGRldmljZSBiZWZvcmUgYWNjZXB0
aW5nIGl0Lgo1LiBTZXQgdGhlIEZFQVRVUkVTX09LIHN0YXR1cyBiaXQuIFRoZSBkcml2ZXIgTVVT
VCBOT1QgYWNjZXB0IG5ldyBmZWF0dXJlIGJpdHMgYWZ0ZXIgdGhpcyBzdGVwLgo2LiBSZS1yZWFk
IGRldmljZSBzdGF0dXMgdG8gZW5zdXJlIHRoZSBGRUFUVVJFU19PSyBiaXQgaXMgc3RpbGwgc2V0
OiBvdGhlcndpc2UsIHRoZSBkZXZpY2UgZG9lcyBub3QKc3VwcG9ydCBvdXIgc3Vic2V0IG9mIGZl
YXR1cmVzIGFuZCB0aGUgZGV2aWNlIGlzIHVudXNhYmxlLgo3LiBQZXJmb3JtIGRldmljZS1zcGVj
aWZpYyBzZXR1cCwgaW5jbHVkaW5nIGRpc2NvdmVyeSBvZiB2aXJ0cXVldWVzIGZvciB0aGUgZGV2
aWNlLCBvcHRpb25hbCBwZXItYnVzIHNldHVwLApyZWFkaW5nIGFuZCBwb3NzaWJseSB3cml0aW5n
IHRoZSBkZXZpY2XigJlzIHZpcnRpbyBjb25maWd1cmF0aW9uIHNwYWNlLCBhbmQgcG9wdWxhdGlv
biBvZiB2aXJ0cXVldWVzLgo4LiBTZXQgdGhlIERSSVZFUl9PSyBzdGF0dXMgYml0LiBBdCB0aGlz
IHBvaW50IHRoZSBkZXZpY2UgaXMg4oCcbGl2ZeKAnS4KCgpTbyBmZWF0dXJlcyBhcmUgY29uZmly
bWVkIGJlZm9yZSBmaW5kIHZxcy4KClRoZSByZXN0IG9mIHN0dWZmIGNhbiBwcm9iYWJseSBqdXN0
IGJlIG1vdmVkIHRvIGFmdGVyIGZpbmRfdnFzIHdpdGhvdXQKbXVjaCBwYWluLgoKU28gaWYgY3Zx
IGlzIHRvbyBzbWFsbCB3ZSBjYW4gZWl0aGVyCi0gcHJvYmUgYnV0IGF2b2lkIHVzaW5nIGN2cQpv
cgotIGZhaWwgcHJvYmUKCi0tIApNU1QKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlv
bkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlv
bi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
