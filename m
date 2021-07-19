Return-Path: <SRS0=a9bH=ML=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5265BC636CB
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 03:30:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 08B2261042
	for <virtualization@archiver.kernel.org>; Mon, 19 Jul 2021 03:30:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 08B2261042
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id B8504606BB;
	Mon, 19 Jul 2021 03:30:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7ZQBhphU0h5d; Mon, 19 Jul 2021 03:30:56 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5CAAA60608;
	Mon, 19 Jul 2021 03:30:55 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36C05C0010;
	Mon, 19 Jul 2021 03:30:55 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 24608C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 03:30:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 21C8883661
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 03:30:54 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id tp-EJMxA3Utf
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 03:30:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 139D183658
 for <virtualization@lists.linux-foundation.org>;
 Mon, 19 Jul 2021 03:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1626665451;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=4thYMEzNgF3AoCRQde59dht0ziPpusYLCABZjd2uI4s=;
 b=OgDC5wZQUf56xcRlQs05aR8IDhy8QeXIyCUKqyuaozDl+VP4aH/gQnpa2mIt9Lqb7jsipQ
 YQ/gr/C/uEotdkkT2p4ocT0FwQr75MWFIBE2oy9Y0GnVm3hFdWvvkPNdqkVCWGvGbg+hMI
 DO20cKqkJYg11XUh1VgBHcOLkLSXQbY=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-284-iLKolYpxMXmBzXDrOPI7Ww-1; Sun, 18 Jul 2021 23:30:49 -0400
X-MC-Unique: iLKolYpxMXmBzXDrOPI7Ww-1
Received: by mail-pg1-f199.google.com with SMTP id
 e62-20020a6369410000b02902317a67391fso278063pgc.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 18 Jul 2021 20:30:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=4thYMEzNgF3AoCRQde59dht0ziPpusYLCABZjd2uI4s=;
 b=Z3E5fmAwp9Ag6sHYaaUpiIRtzAaEQcPvGvQTtT32A3yT0lnFltv6zygQOLh2UBbOzY
 jAWFPL6S49puOsjOZNbvltxx5tCWaXdv9c09R7yGPOjIe9MzaS+tjRJCZ+Dv8dEaMtKi
 3G+b6RCNRikCSxpNw6j8o6n83eX9ErPwvCtGyvuNm76nwcdkwIzx3Ot5eTmqWhko3UIG
 zpDjbvAUDoCNTMcfmBzqur4EynUDmY9exWUn9/pEslSAytuK137eD6oGJANkSLeEuKXG
 fB15qDg7t29QoHbLiWf7+uGVK8IHcNcrQixJjTTKEumUTdiH49EPfd3UMAJtP4Wy59Jj
 PWqw==
X-Gm-Message-State: AOAM531VGKmYPmy77zobG7ejKTjlworp7NwWlMMq5Upq2tkYUXgrKSH7
 /zK6shyk5+jlcxNinTvrx89rV93zSIw0Pz/UYnJZK/Q90/GYHGlaMVF03InDkyEy1814aIRGCSk
 jWBzPIF/1bU13ocgy0Aw5YkctzhNlBjcCEUw2WsaLpg==
X-Received: by 2002:a17:90a:fe07:: with SMTP id
 ck7mr11831844pjb.51.1626665448822; 
 Sun, 18 Jul 2021 20:30:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxe6zlZhtmikh9nPja5DIIRB06qSd9L4IveW6TD/qUNVnYqP4YhQrac1LChSjiJDHogpY4xig==
X-Received: by 2002:a17:90a:fe07:: with SMTP id
 ck7mr11831822pjb.51.1626665448660; 
 Sun, 18 Jul 2021 20:30:48 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id i1sm17606689pfo.37.2021.07.18.20.30.46
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 18 Jul 2021 20:30:48 -0700 (PDT)
Subject: Re: [PATCH 2/2] vhost: Fix the calculation in vhost_overflow()
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com,
 dan.carpenter@oracle.com
References: <20210716102239.96-1-xieyongji@bytedance.com>
 <20210716102239.96-2-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <e2d68906-ffa1-4e87-4251-d83ce96a8869@redhat.com>
Date: Mon, 19 Jul 2021 11:30:43 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210716102239.96-2-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
 virtualization@lists.linux-foundation.org
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

CuWcqCAyMDIxLzcvMTYg5LiL5Y2INjoyMiwgWGllIFlvbmdqaSDlhpnpgZM6Cj4gVGhpcyBmaXhl
cyB0aGUgaW5jb3JyZWN0IGNhbGN1bGF0aW9uIGZvciBpbnRlZ2VyIG92ZXJmbG93Cj4gd2hlbiB0
aGUgbGFzdCBhZGRyZXNzIG9mIGlvdmEgcmFuZ2UgaXMgMHhmZmZmZmZmZi4KPgo+IEZpeGVzOiBl
YzMzZDAzMWExNGIgKCJ2aG9zdDogZGV0ZWN0IDMyIGJpdCBpbnRlZ2VyIHdyYXAgYXJvdW5k4oCc
KQo+IFJlcG9ydGVkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgo+IFNpZ25l
ZC1vZmYtYnk6IFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgo+IC0tLQo+ICAg
ZHJpdmVycy92aG9zdC92aG9zdC5jIHwgMyArKy0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAyIGluc2Vy
dGlvbnMoKyksIDEgZGVsZXRpb24oLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3Zo
b3N0LmMgYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiBpbmRleCBiOWU4NTNlNjA5NGQuLmE5ZmQx
YjMxMWQyZiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiArKysgYi9kcml2
ZXJzL3Zob3N0L3Zob3N0LmMKPiBAQCAtNzM4LDcgKzczOCw4IEBAIHN0YXRpYyBib29sIGxvZ19h
Y2Nlc3Nfb2sodm9pZCBfX3VzZXIgKmxvZ19iYXNlLCB1NjQgYWRkciwgdW5zaWduZWQgbG9uZyBz
eikKPiAgIHN0YXRpYyBib29sIHZob3N0X292ZXJmbG93KHU2NCB1YWRkciwgdTY0IHNpemUpCj4g
ICB7Cj4gICAJLyogTWFrZSBzdXJlIDY0IGJpdCBtYXRoIHdpbGwgbm90IG92ZXJmbG93LiAqLwo+
IC0JcmV0dXJuIHVhZGRyID4gVUxPTkdfTUFYIHx8IHNpemUgPiBVTE9OR19NQVggfHwgdWFkZHIg
PiBVTE9OR19NQVggLSBzaXplOwo+ICsJcmV0dXJuIHVhZGRyID4gVUxPTkdfTUFYIHx8IHNpemUg
PiBVTE9OR19NQVggfHwKPiArCSAgICAgICB1YWRkciAtIDEgPiBVTE9OR19NQVggLSBzaXplOwo+
ICAgfQoKCkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gICAK
PiAgIC8qIENhbGxlciBzaG91bGQgaGF2ZSB2cSBtdXRleCBhbmQgZGV2aWNlIG11dGV4LiAqLwoK
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6
YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24u
b3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3Zp
cnR1YWxpemF0aW9u
