Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF53EC77B73
	for <virtualization@archiver.kernel.org>; Sun, 23 Apr 2023 06:40:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 3CB5560F8C;
	Sun, 23 Apr 2023 06:40:27 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3CB5560F8C
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=bdQuEG0e
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ykf0x7BV3l_2; Sun, 23 Apr 2023 06:40:26 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 91C4760D8E;
	Sun, 23 Apr 2023 06:40:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 91C4760D8E
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 60A7EC0037;
	Sun, 23 Apr 2023 06:40:25 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 378A0C002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 06:40:24 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id F230060D8E
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 06:40:23 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org F230060D8E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kSJqo4QRreSq
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 06:40:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2F3F660BEB
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2F3F660BEB
 for <virtualization@lists.linux-foundation.org>;
 Sun, 23 Apr 2023 06:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1682232022;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=dvXfYmxIcovy78Xr9cmPWmp1gtC+thHA+UwsJy9Qfc0=;
 b=bdQuEG0e/pJljJvWFXe7g2r71oZmtwalx5UYrB/5a9OZkAkh6ZwMJKFcX9kkK3mzSHpoLK
 8eBIjV0+NfccAoBN4zf73P6F5hosneQGjFb+v849BFCBbFbtrJHAbAScO9yQkOwONMikQV
 Qpta1FeTNFH1EOP7UaQ17z+iOQoDqAQ=
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com
 [209.85.167.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-523-6rS-PyU2Njmrg7SPtQd22Q-1; Sun, 23 Apr 2023 02:40:20 -0400
X-MC-Unique: 6rS-PyU2Njmrg7SPtQd22Q-1
Received: by mail-oi1-f200.google.com with SMTP id
 5614622812f47-38be7d8dcf9so2640598b6e.1
 for <virtualization@lists.linux-foundation.org>;
 Sat, 22 Apr 2023 23:40:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1682232020; x=1684824020;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=dvXfYmxIcovy78Xr9cmPWmp1gtC+thHA+UwsJy9Qfc0=;
 b=PlFcBYozYu2z2Jqhud6wtszgSVglsaDN4Ukd1OXBVN4dVqEWtiYNyBbQzLt5zZxfiY
 XQyubxReb7Lggi7OE+vZIXoXm2/NvkoaP5zDY7Ey/RNSTjbvuGHzQUoaDSaviLnycMXp
 anGbvdlZdN9BASB1g8BbRC61npN9OZQlQ5PoYhvMACaZoNK8cnSbgWmvpQ5hryAtTEPj
 L9lhETrqnGTx5Ik1v2vZJ3E7tYnvZuDvmSYdyDO3kZN80KUuXNGBG/fvTSaF1WhcUqXP
 4mZ8lTtogrml2loZOHsfWbEW2NU/P0AI57DJFp9Y3JrLjADtSuDSIPsw8LUnEdUzK6fJ
 1y5g==
X-Gm-Message-State: AAQBX9ensNFMUkoJGk1u8Q9rc1X2j/+oCaDpGBv2YYl3I9Oh1unZSYsh
 PpJlrEYcdxWqjtk+1+yVXRdYX/epEu9tOcwwOGhTaCvYr9zUr9Xxz8Nq1fsmg4oEtHi2A7+yY2T
 ZFHdEyXyqlotZP+x3nBGKtGJ8x2ZWAoV3RYe41q7+O9t14noFXtEgh0WGxQ==
X-Received: by 2002:a05:6808:90:b0:38e:a7c6:7ab8 with SMTP id
 s16-20020a056808009000b0038ea7c67ab8mr1842151oic.56.1682232019825; 
 Sat, 22 Apr 2023 23:40:19 -0700 (PDT)
X-Google-Smtp-Source: AKy350bcwtcI46WjZfNy0+3GgvyyxAWW2u03L4KJ/Nj9JDQPHhaduCbnDkUGL6qfhjMI5GDM8fDX67U7lU9bi9/WH6o=
X-Received: by 2002:a05:6808:90:b0:38e:a7c6:7ab8 with SMTP id
 s16-20020a056808009000b0038ea7c67ab8mr1842144oic.56.1682232019647; Sat, 22
 Apr 2023 23:40:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230421195641.391-1-shannon.nelson@amd.com>
 <20230421195641.391-4-shannon.nelson@amd.com>
In-Reply-To: <20230421195641.391-4-shannon.nelson@amd.com>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 23 Apr 2023 14:40:08 +0800
Message-ID: <CACGkMEt=N=aqKCwh1OjTcv5uUpkhzax4m9qGdD5OcqoBJAM0bg@mail.gmail.com>
Subject: Re: [PATCH 3/3] vhost_vdpa: support PACKED when setting-getting
 vring_base
To: Shannon Nelson <shannon.nelson@amd.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: drivers@pensando.io, virtualization@lists.linux-foundation.org,
 mst@redhat.com
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

T24gU2F0LCBBcHIgMjIsIDIwMjMgYXQgMzo1N+KAr0FNIFNoYW5ub24gTmVsc29uIDxzaGFubm9u
Lm5lbHNvbkBhbWQuY29tPiB3cm90ZToKPgo+IFVzZSB0aGUgcmlnaHQgc3RydWN0cyBmb3IgUEFD
S0VEIG9yIHNwbGl0IHZxcyB3aGVuIHNldHRpbmcgYW5kCj4gZ2V0dGluZyB0aGUgdnJpbmcgYmFz
ZS4KPgo+IFNpZ25lZC1vZmYtYnk6IFNoYW5ub24gTmVsc29uIDxzaGFubm9uLm5lbHNvbkBhbWQu
Y29tPgo+IC0tLQo+ICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyB8IDE5ICsrKysrKysrKysrKysrKy0t
LS0KPiAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDQgZGVsZXRpb25zKC0pCj4K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEu
Ywo+IGluZGV4IDU5OWI4Y2MyMzhjNy4uMjU0M2FlOWQ1OTM5IDEwMDY0NAo+IC0tLSBhL2RyaXZl
cnMvdmhvc3QvdmRwYS5jCj4gKysrIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBAQCAtNTg1LDcg
KzU4NSwxMiBAQCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3ZyaW5nX2lvY3RsKHN0cnVjdCB2aG9z
dF92ZHBhICp2LCB1bnNpZ25lZCBpbnQgY21kLAo+ICAgICAgICAgICAgICAgICBpZiAocikKPiAg
ICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4gcjsKPgo+IC0gICAgICAgICAgICAgICB2cS0+
bGFzdF9hdmFpbF9pZHggPSB2cV9zdGF0ZS5zcGxpdC5hdmFpbF9pbmRleDsKPiArICAgICAgICAg
ICAgICAgaWYgKHZob3N0X2hhc19mZWF0dXJlKHZxLCBWSVJUSU9fRl9SSU5HX1BBQ0tFRCkpIHsK
PiArICAgICAgICAgICAgICAgICAgICAgICB2cS0+bGFzdF9hdmFpbF9pZHggPSB2cV9zdGF0ZS5w
YWNrZWQubGFzdF9hdmFpbF9pZHg7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgdnEtPmxhc3Rf
dXNlZF9pZHggPSB2cV9zdGF0ZS5wYWNrZWQubGFzdF91c2VkX2lkeDsKCkkgd29uZGVyIGlmIHRo
ZSBjb21waWxlciB3aWxsIGd1YXJhbnRlZSBhIHBpZ2d5YmFjayBmb3IgdGhlIHdyYXAKY291bnRl
ciBoZXJlPyBJZiBub3QsIHNob3VsZCB3ZSBleHBsaWNpdGx5IHBhY2tpbmcgd3JhcCBjb3VudGVy
PwoKVGhhbmtzCgo+ICsgICAgICAgICAgICAgICB9IGVsc2Ugewo+ICsgICAgICAgICAgICAgICAg
ICAgICAgIHZxLT5sYXN0X2F2YWlsX2lkeCA9IHZxX3N0YXRlLnNwbGl0LmF2YWlsX2luZGV4Owo+
ICsgICAgICAgICAgICAgICB9Cj4gICAgICAgICAgICAgICAgIGJyZWFrOwo+ICAgICAgICAgfQo+
Cj4gQEAgLTYwMyw5ICs2MDgsMTUgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV92cmluZ19pb2N0
bChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdW5zaWduZWQgaW50IGNtZCwKPiAgICAgICAgICAgICAg
ICAgYnJlYWs7Cj4KPiAgICAgICAgIGNhc2UgVkhPU1RfU0VUX1ZSSU5HX0JBU0U6Cj4gLSAgICAg
ICAgICAgICAgIHZxX3N0YXRlLnNwbGl0LmF2YWlsX2luZGV4ID0gdnEtPmxhc3RfYXZhaWxfaWR4
Owo+IC0gICAgICAgICAgICAgICBpZiAob3BzLT5zZXRfdnFfc3RhdGUodmRwYSwgaWR4LCAmdnFf
c3RhdGUpKQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHIgPSAtRUlOVkFMOwo+ICsgICAgICAg
ICAgICAgICBpZiAodmhvc3RfaGFzX2ZlYXR1cmUodnEsIFZJUlRJT19GX1JJTkdfUEFDS0VEKSkg
ewo+ICsgICAgICAgICAgICAgICAgICAgICAgIHZxX3N0YXRlLnBhY2tlZC5sYXN0X2F2YWlsX2lk
eCA9IHZxLT5sYXN0X2F2YWlsX2lkeCAmIDB4N2ZmZjsKPiArICAgICAgICAgICAgICAgICAgICAg
ICB2cV9zdGF0ZS5wYWNrZWQubGFzdF9hdmFpbF9jb3VudGVyID0gISEodnEtPmxhc3RfYXZhaWxf
aWR4ICYgMHg4MDAwKTsKPiArICAgICAgICAgICAgICAgICAgICAgICB2cV9zdGF0ZS5wYWNrZWQu
bGFzdF91c2VkX2lkeCA9IHZxLT5sYXN0X3VzZWRfaWR4ICYgMHg3ZmZmOwo+ICsgICAgICAgICAg
ICAgICAgICAgICAgIHZxX3N0YXRlLnBhY2tlZC5sYXN0X3VzZWRfY291bnRlciA9ICEhKHZxLT5s
YXN0X3VzZWRfaWR4ICYgMHg4MDAwKTsKPiArICAgICAgICAgICAgICAgfSBlbHNlIHsKPiArICAg
ICAgICAgICAgICAgICAgICAgICB2cV9zdGF0ZS5zcGxpdC5hdmFpbF9pbmRleCA9IHZxLT5sYXN0
X2F2YWlsX2lkeDsKPiArICAgICAgICAgICAgICAgfQo+ICsgICAgICAgICAgICAgICByID0gb3Bz
LT5zZXRfdnFfc3RhdGUodmRwYSwgaWR4LCAmdnFfc3RhdGUpOwo+ICAgICAgICAgICAgICAgICBi
cmVhazsKPgo+ICAgICAgICAgY2FzZSBWSE9TVF9TRVRfVlJJTkdfQ0FMTDoKPiAtLQo+IDIuMTcu
MQo+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
