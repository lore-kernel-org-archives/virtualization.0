Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AE10CCA47F
	for <virtualization@archiver.kernel.org>; Mon, 13 Jun 2022 14:20:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EF342826C1;
	Mon, 13 Jun 2022 14:20:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id v9SRUMwUmiJy; Mon, 13 Jun 2022 14:20:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id ADA4C81CA0;
	Mon, 13 Jun 2022 14:20:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7BA71C0039;
	Mon, 13 Jun 2022 14:20:21 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 213B7C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 14:20:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 09DBD401DD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 14:20:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 35nkDwP2idk4
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 14:20:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id C6371400E9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 14:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1655130017;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=o6iSOIMHySILiBMLfTjQaYst/xxQ7BjEzUEsRQWy3xU=;
 b=AHv68QQD/+HgBgCjsGdoL6QobtHR8WtBRaFRRVZaaBgMaY7hWguxhDDDEZnxe0VNJfzCNv
 Ml9nXUUMeMn0hCPa19sy78OX6M3yZISEpr5kWpWyvJqlVMoszSrZr9kCGwpfQowmHPfStM
 zc07rdDBrw/mDUA8UsgB2E4QeVE9ZA8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-100-U5vexa0dPdaaG_6k0TLlKg-1; Mon, 13 Jun 2022 10:20:16 -0400
X-MC-Unique: U5vexa0dPdaaG_6k0TLlKg-1
Received: by mail-wm1-f72.google.com with SMTP id
 m23-20020a05600c3b1700b0039c6e3c169aso3282185wms.2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Jun 2022 07:20:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=o6iSOIMHySILiBMLfTjQaYst/xxQ7BjEzUEsRQWy3xU=;
 b=V4GhqHa6ApAVG075J4qY93D4kFUkMHku7Y12MCozh3H2F1rr0S3axVUtlK/F+z6XAl
 ROY9Kve1AzMDYaOZbqIQR8nVr0Ug5qwjhj9Hxr/uZjUcZJecaPtWXEMnEL16KFXgEFHG
 6Jf+ZPaAD5Wlb4pD28/Fh9O4n+eZucgNzGkicDRBICeiQBm4doRb1ZAjUjahwD9r5iLS
 J9KWP0zgVYkqG09UBKY8DK6ODA1gZcA/6Rl1dPkiDxZTbrHX7agzi1zomtiwmrzdWQBD
 Lsps5fPvGR//nN0NQOd2WzkzhHYoNgoUqf7laSONbVN3Y/VZZMbUJUoOiRZiPrdmtbLC
 qI+A==
X-Gm-Message-State: AJIora9xnwCKMk14K8JigxeU9UT8eNdjR6b2KT7eq9m2gCSyiG5/9rOE
 fmTvWzNCDKNtf7RMszXPDWIPv4ocTeA2cbSZvRH1oYj8QmLiWgNNri7aQ1w1oHuwJA36adUaW/z
 pUgunGEdQLjX3DeIE2y5LNFkweYnbyiFLw83U+9W5Aw==
X-Received: by 2002:a05:6000:2a8:b0:213:ba0c:fef8 with SMTP id
 l8-20020a05600002a800b00213ba0cfef8mr83813wry.485.1655130011586; 
 Mon, 13 Jun 2022 07:20:11 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vu/VAlyGS+RGmTsQqN6w2+48r85BcRvoKxV0X7BJWmqXfTNaeTpyBDNBfW6JGUgvARN5E5zQ==
X-Received: by 2002:a05:6000:2a8:b0:213:ba0c:fef8 with SMTP id
 l8-20020a05600002a800b00213ba0cfef8mr83797wry.485.1655130011384; 
 Mon, 13 Jun 2022 07:20:11 -0700 (PDT)
Received: from redhat.com ([2.53.9.208]) by smtp.gmail.com with ESMTPSA id
 c17-20020a05600c4a1100b0039c4ec6fdacsm9337720wmp.40.2022.06.13.07.20.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 13 Jun 2022 07:20:10 -0700 (PDT)
Date: Mon, 13 Jun 2022 10:20:07 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: =?utf-8?B?6buE5p2w?= <huangjie.albert@bytedance.com>
Subject: Re: [PATCH] virtio_ring : fix vring_packed_desc memory out of bounds
 bug
Message-ID: <20220613101918-mutt-send-email-mst@kernel.org>
References: <20220610103905-mutt-send-email-mst@kernel.org>
 <CABKxMyPTLJ0bbxb23C_aeucVEP8MYNiFz1y9d8eGA4Bvdyey3g@mail.gmail.com>
 <20220610203449-mutt-send-email-mst@kernel.org>
 <CABKxMyOYrjUDvWggK=rnBZcRuaO9x=wHWq15MgAQz5_Fbtypxg@mail.gmail.com>
 <20220612100945-mutt-send-email-mst@kernel.org>
 <CABKxMyMiOhRSp5_VOZ2Sh8q7Ef3+hnZmALHazwii0hR3SfRZWg@mail.gmail.com>
 <20220613045212-mutt-send-email-mst@kernel.org>
 <CABKxMyM5fvH6pGzPxqz1aRHbv8BX+xFfwyJi4zqqTA89RULs5w@mail.gmail.com>
 <20220613100606-mutt-send-email-mst@kernel.org>
 <CABKxMyOXuqSLZs71UVRK+_=ehpBwpo1Ft_20V_Go8aN8zX+b9Q@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CABKxMyOXuqSLZs71UVRK+_=ehpBwpo1Ft_20V_Go8aN8zX+b9Q@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: yuanzhu@bytedance.com, virtualization@lists.linux-foundation.org
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

T24gTW9uLCBKdW4gMTMsIDIwMjIgYXQgMTA6MTc6NThQTSArMDgwMCwg6buE5p2wIHdyb3RlOgo+
IE9LLCB0aGFuayB5b3UgZm9yIHRoZSBleHBsYW5hdGlvbiwgSSBnZXQgaXQuIEJ5IHRoZSB3YXks
IGlmIHdlIGNvdWxkCj4gZml4IHRoZSAgdGhlIE9PQiBhY2Nlc3MgZmlyc3QsIGl0IHNlZW1zIHRo
YXQgZXZlbiBpZiB3ZSBkbyB0aGlzLCB0aGUKPiBPT0IgYWNjZXNzIGFsc28gZXhpc3RzLgo+ID4g
SSB0aGluayB3ZSBjYW4gZG8gdGhpcyBzaW5jZSAxNmJpdC8zMmJpdCBvcGVyYXRpb25zIGFyZSBn
dWFyYW50ZWVkIHRvIGJlIGF0b21pYy4KPiAKPiBCUgoKUHJlc3VtYWJseSBhcyB3ZSBhcmUgcmV3
b3JraW5nIHRoZSBjb2RlIHdlJ2xsIG1ha2Ugc3VyZSBhbnkgdmFsdWUKd3JpdHRlbiBpbnRvIGxh
c3RfdXNlZF9pZHggaXMgd2l0aGluIGJvdW5kcy4KCi0tIApNU1QKCl9fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlz
dApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3Rz
LmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
