Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8936C433FE
	for <virtualization@archiver.kernel.org>; Wed,  5 Oct 2022 17:25:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5C19C401CA;
	Wed,  5 Oct 2022 17:25:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 5C19C401CA
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=gIFf01eS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yc3wUG5NF17H; Wed,  5 Oct 2022 17:25:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id BF646400FB;
	Wed,  5 Oct 2022 17:25:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF646400FB
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93966C0032;
	Wed,  5 Oct 2022 17:25:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B7838C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 17:25:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 9F91560FB5
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 17:25:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 9F91560FB5
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=gIFf01eS
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id BScitmKQpgWv
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 17:25:52 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org E9CD560FAC
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com
 [IPv6:2607:f8b0:4864:20::52b])
 by smtp3.osuosl.org (Postfix) with ESMTPS id E9CD560FAC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  5 Oct 2022 17:25:51 +0000 (UTC)
Received: by mail-pg1-x52b.google.com with SMTP id e129so15784282pgc.9
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Oct 2022 10:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:from:to:cc:subject:date;
 bh=hoatWM9ozoryzp81ugwuVdaw9vFYVzmYTBOT17b7aaI=;
 b=gIFf01eSbK2nZVpULQQ42DWnKsnifrnfUC3C+n75VahsZLw6X4vzvAE2VCPE1j48X0
 IaaNKd/qYL8krO6D3d/aoP9gMlWpx+y3lL7NClxUYU53fEDEEhbfVvZ7aE0aqvAmV4IK
 3y2vFjqYCsjN97+iPd/YqH2yMZej0l7hTXKxgH2VLxsIVo9OOIqo5v/PBf19pcnriVOx
 t/1ieEGtExO1t8rBxYT+5frSnex7m46Hec+pQZzYr1Eu3vJbnWH5zukHNd0QoGHb6DNu
 cBOPZ9XSaw1Li4xEvr8wnq6qlZhHieRk/DcIuLbLP5LbN2Sjnc8DBnkr7+yceNvIu8Nw
 zaDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=to:references:message-id:content-transfer-encoding:cc:date
 :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
 :subject:date;
 bh=hoatWM9ozoryzp81ugwuVdaw9vFYVzmYTBOT17b7aaI=;
 b=UojivyXXsBWXrSKdJ6hCKz4fLu1mfB/AbwaQRrozs8J39XRBbojDos9zzP98NZ+Vou
 3FRQLe00aqnYBJsDZjpHX4KI/obCjMuw5bVzUvlTHhEovb21LastyYQMiyA59lGwGTi4
 y8whl1EfVEZK68yqHdYK+xjiOUGbCKVsSzwpDnQ56uzjwp+RqACbGZEBLLsU/LTlXi5r
 Df1EROs9YRLAbexW7ds/XrYwdyTE7anKSmgHeK/4oRf6JyjysAGe/ij3A6KUn1NxwNrH
 puAlDqIFcXw+JwmbkAQuk0mh+BENcHN/+tq1nL1VornfUOgSO+aaln6vFszN78X6xmjx
 r8Mg==
X-Gm-Message-State: ACrzQf00Bg4zM8mJj3oUYjxJikImEYwX+Bto0y1lfSJgsbGoA9v/Sn2r
 KCudz6ty/JU04PlhIQ+ymPo=
X-Google-Smtp-Source: AMsMyM4TyVkvtTWOPo0nT5OoEytcoTQ9Csm4KgzKugBBadka1vCy2hdL+79TtN4k8+wmclpr81Shfg==
X-Received: by 2002:a05:6a02:186:b0:439:49a3:479b with SMTP id
 bj6-20020a056a02018600b0043949a3479bmr733364pgb.171.1664990751147; 
 Wed, 05 Oct 2022 10:25:51 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net.
 [24.6.216.183]) by smtp.gmail.com with ESMTPSA id
 j7-20020a170902690700b00176b84eb29asm1777510plk.301.2022.10.05.10.25.49
 (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
 Wed, 05 Oct 2022 10:25:50 -0700 (PDT)
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH v4 2/7] Enable balloon drivers to report inflated memory
From: Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <20221005090158.2801592-3-alexander.atanasov@virtuozzo.com>
Date: Wed, 5 Oct 2022 10:25:47 -0700
Message-Id: <88EDC41D-408F-4ADF-A933-0A6F36E5F262@gmail.com>
References: <20221005090158.2801592-1-alexander.atanasov@virtuozzo.com>
 <20221005090158.2801592-3-alexander.atanasov@virtuozzo.com>
To: Alexander Atanasov <alexander.atanasov@virtuozzo.com>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
Cc: "Michael S. Tsirkin" <mst@redhat.com>, LKML <linux-kernel@vger.kernel.org>,
 Linux Virtualization <virtualization@lists.linux-foundation.org>,
 linux-mm@kvack.org, kernel@openvz.org,
 Andrew Morton <akpm@linux-foundation.org>
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

T24gT2N0IDUsIDIwMjIsIGF0IDI6MDEgQU0sIEFsZXhhbmRlciBBdGFuYXNvdiA8YWxleGFuZGVy
LmF0YW5hc292QHZpcnR1b3p6by5jb20+IHdyb3RlOgoKPiBBZGQgY291bnRlcnMgdG8gYmUgdXBk
YXRlZCBieSB0aGUgYmFsbG9vbiBkcml2ZXJzLgo+IENyZWF0ZSBiYWxsb29uIG5vdGlmaWVyIHRv
IHByb3BhZ2F0ZSBjaGFuZ2VzLgoKSSBtaXNzZWQgdGhlIG90aGVyIHBhdGNoZXMgYmVmb3JlIChp
bmNsdWRpbmcgdGhpcyBvbmUpLiBTb3JyeSwgYnV0IG5leHQKdGltZSwgcGxlYXNlIGNjIG1lLgoK
SSB3YXMgbG9va2luZyB0aHJvdWdoIHRoZSBzZXJpZXMgYW5kIEkgZGlkIG5vdCBzZWUgYWN0dWFs
IHVzZXJzIG9mIHRoZQpub3RpZmllci4gVXN1YWxseSwgaXQgaXMgbm90IGdyZWF0IHRvIGJ1aWxk
IGFuIEFQSSB3aXRob3V0IHVzZXJzLgoKW3NuaXBdIAoKPiArCj4gK3N0YXRpYyBpbnQgYmFsbG9v
bl9ub3RpZnkodW5zaWduZWQgbG9uZyB2YWwpCj4gK3sKPiArCXJldHVybiBzcmN1X25vdGlmaWVy
X2NhbGxfY2hhaW4oJmJhbGxvb25fY2hhaW4sIHZhbCwgTlVMTCk7CgpTaW5jZSB5b3Uga25vdyB0
aGUgaW5mbGF0ZWRfa2IgdmFsdWUgaGVyZSwgd2h5IG5vdCB0byB1c2UgaXQgYXMgYW4gYXJndW1l
bnQKdG8gdGhlIGNhbGxiYWNrPyBJIHRoaW5rIGNhc3RpbmcgdG8gKHZvaWQgKikgYW5kIGJhY2sg
aXMgYmVzdC4gQnV0IHlvdSBjYW4KYWxzbyBwcm92aWRlIHBvaW50ZXIgdG8gdGhlIHZhbHVlLiBE
b2VzbuKAmXQgaXQgc291bmQgYmV0dGVyIHRoYW4gaGF2aW5nCnBvdGVudGlhbGx5IGRpZmZlcmVu
dCBub3RpZmllcnMgcmVhZGluZyBkaWZmZXJlbnQgdmFsdWVzPwoKQW55aG93LCB3aXRob3V0IHVz
ZXJzIChhY3R1YWwgbm90aWZpZXJzKSBpdOKAmXMga2luZCBvZiBoYXJkIHRvIGtub3cgaG93CnJl
YXNvbmFibGUgaXQgYWxsIGlzLiBGb3IgaW5zdGFuY2UsIGlzIGl0IGJhbGxvb25fbm90aWZ5KCkg
c3VwcG9zZWQgdG8KcHJldmVudCBmdXJ0aGVyIGJhbGxvb24gaW5mbGF0aW5nL2RlZmxhdGluZyB1
bnRpbCB0aGUgbm90aWZpZXIgY29tcGxldGVzPwpBY2NvcmRpbmdseSwgYXJlIGNhbGxlcnMgdG8g
YmFsbG9vbl9ub3RpZnkoKSBleHBlY3RlZCB0byByZWxpbnF1aXNoIGxvY2tzCmJlZm9yZSBjYWxs
aW5nIGJhbGxvb25fbm90aWZ5KCkgdG8gcHJldmVudCBkZWFkbG9ja3MgYW5kIGhpZ2ggbGF0ZW5j
eT8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
