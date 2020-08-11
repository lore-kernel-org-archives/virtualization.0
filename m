Return-Path: <SRS0=ofWe=BV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24E20C433E0
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 12:02:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E4CB72075D
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 12:02:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R+ECLTVR"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E4CB72075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id AD49C876A5;
	Tue, 11 Aug 2020 12:02:38 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hn7ulXyLtVxY; Tue, 11 Aug 2020 12:02:37 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id E1F44875B7;
	Tue, 11 Aug 2020 12:02:37 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D07BAC013C;
	Tue, 11 Aug 2020 12:02:37 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2D186C004D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 12:02:37 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 162E92154F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 12:02:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pQ4eExLIoj5f
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 12:02:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by silver.osuosl.org (Postfix) with ESMTPS id D090B204EF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 12:02:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597147341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
 bh=XRE32AsdoxPjsDiqDcFNatTyYtDw1PEuBrES1gt7Vas=;
 b=R+ECLTVRCLK1XtHeTiqh6p8fG+HkHmcggt8Vh5VrN1wsen02JIfJLKx2l/jfAvd2DX7zFr
 xW2+hWcPn/B7XuX/Rv8sfwkAyay1cDHvScsvRIXrrGOdpgW9zwGBS9S88OV+vScluOVugt
 hqXVeHfTUoegprFQEwwgRcZTX5cBEek=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-541-akHCSct9M5ezJP-CgLkTJQ-1; Tue, 11 Aug 2020 08:02:19 -0400
X-MC-Unique: akHCSct9M5ezJP-CgLkTJQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DF0621009443;
 Tue, 11 Aug 2020 12:02:17 +0000 (UTC)
Received: from [10.36.112.235] (ovpn-112-235.ams2.redhat.com [10.36.112.235])
 by smtp.corp.redhat.com (Postfix) with ESMTP id DDDD56F136;
 Tue, 11 Aug 2020 12:02:07 +0000 (UTC)
Subject: Re: [PATCH v2] virtio-rng: return available data with O_NONBLOCK
To: =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@redhat.com>,
 mwilck@suse.com, "Michael S. Tsirkin" <mst@redhat.com>,
 Jason Wang <jasowang@redhat.com>
References: <20200715133255.10526-1-mwilck@suse.com>
 <7cfc4316-922b-8606-72ce-80205ef55572@redhat.com>
From: Laurent Vivier <lvivier@redhat.com>
Autocrypt: addr=lvivier@redhat.com; prefer-encrypt=mutual; keydata=
 mQINBFYFJhkBEAC2me7w2+RizYOKZM+vZCx69GTewOwqzHrrHSG07MUAxJ6AY29/+HYf6EY2
 WoeuLWDmXE7A3oJoIsRecD6BXHTb0OYS20lS608anr3B0xn5g0BX7es9Mw+hV/pL+63EOCVm
 SUVTEQwbGQN62guOKnJJJfphbbv82glIC/Ei4Ky8BwZkUuXd7d5NFJKC9/GDrbWdj75cDNQx
 UZ9XXbXEKY9MHX83Uy7JFoiFDMOVHn55HnncflUncO0zDzY7CxFeQFwYRbsCXOUL9yBtqLer
 Ky8/yjBskIlNrp0uQSt9LMoMsdSjYLYhvk1StsNPg74+s4u0Q6z45+l8RAsgLw5OLtTa+ePM
 JyS7OIGNYxAX6eZk1+91a6tnqfyPcMbduxyBaYXn94HUG162BeuyBkbNoIDkB7pCByed1A7q
 q9/FbuTDwgVGVLYthYSfTtN0Y60OgNkWCMtFwKxRaXt1WFA5ceqinN/XkgA+vf2Ch72zBkJL
 RBIhfOPFv5f2Hkkj0MvsUXpOWaOjatiu0fpPo6Hw14UEpywke1zN4NKubApQOlNKZZC4hu6/
 8pv2t4HRi7s0K88jQYBRPObjrN5+owtI51xMaYzvPitHQ2053LmgsOdN9EKOqZeHAYG2SmRW
 LOxYWKX14YkZI5j/TXfKlTpwSMvXho+efN4kgFvFmP6WT+tPnwARAQABtCNMYXVyZW50IFZp
 dmllciA8bHZpdmllckByZWRoYXQuY29tPokCOAQTAQIAIgUCVgVQgAIbAwYLCQgHAwIGFQgC
 CQoLBBYCAwECHgECF4AACgkQ8ww4vT8vvjwpgg//fSGy0Rs/t8cPFuzoY1cex4limJQfReLr
 SJXCANg9NOWy/bFK5wunj+h/RCFxIFhZcyXveurkBwYikDPUrBoBRoOJY/BHK0iZo7/WQkur
 6H5losVZtrotmKOGnP/lJYZ3H6OWvXzdz8LL5hb3TvGOP68K8Bn8UsIaZJoeiKhaNR0sOJyI
 YYbgFQPWMHfVwHD/U+/gqRhD7apVysxv5by/pKDln1I5v0cRRH6hd8M8oXgKhF2+rAOL7gvh
 jEHSSWKUlMjC7YwwjSZmUkL+TQyE18e2XBk85X8Da3FznrLiHZFHQ/NzETYxRjnOzD7/kOVy
 gKD/o7asyWQVU65mh/ECrtjfhtCBSYmIIVkopoLaVJ/kEbVJQegT2P6NgERC/31kmTF69vn8
 uQyW11Hk8tyubicByL3/XVBrq4jZdJW3cePNJbTNaT0d/bjMg5zCWHbMErUib2Nellnbg6bc
 2HLDe0NLVPuRZhHUHM9hO/JNnHfvgiRQDh6loNOUnm9Iw2YiVgZNnT4soUehMZ7au8PwSl4I
 KYE4ulJ8RRiydN7fES3IZWmOPlyskp1QMQBD/w16o+lEtY6HSFEzsK3o0vuBRBVp2WKnssVH
 qeeV01ZHw0bvWKjxVNOksP98eJfWLfV9l9e7s6TaAeySKRRubtJ+21PRuYAxKsaueBfUE7ZT
 7ze0LUxhdXJlbnQgVml2aWVyIChSZWQgSGF0KSA8bHZpdmllckByZWRoYXQuY29tPokCOAQT
 AQIAIgUCVgUmGQIbAwYLCQgHAwIGFQgCCQoLBBYCAwECHgECF4AACgkQ8ww4vT8vvjxtNBAA
 o2xGmbXl9vJQALkj7MVlsMlgewQ1rdoZl+bZ6ythTSBsqwwtl1BUTQGA1GF2LAchRVYca5bJ
 lw4ai5OdZ/rc5dco2XgrRFtj1np703BzNEhGU1EFxtms/Y9YOobq/GZpck5rK8jV4osEb8oc
 3xEgCm/xFwI/2DOe0/s2cHKzRkvdmKWEDhT1M+7UhtSCnloX776zCsrofYiHP2kasFyMa/5R
 9J1Rt9Ax/jEAX5vFJ8+NPf68497nBfrAtLM3Xp03YJSr/LDxer44Mevhz8dFw7IMRLhnuSfr
 8jP93lr6Wa8zOe3pGmFXZWpNdkV/L0HaeKwTyDKKdUDH4U7SBnE1gcDfe9x08G+oDfVhqED8
 qStKCxPYxRUKIdUjGPF3f5oj7N56Q5zZaZkfxeLNTQ13LDt3wGbVHyZxzFc81B+qT8mkm74y
 RbeVSuviPTYjbBQ66GsUgiZZpDUyJ6s54fWqQdJf4VFwd7M/mS8WEejbSjglGHMxMGiBeRik
 Y0+ur5KAF7z0D1KfW1kHO9ImQ0FbEbMbTMf9u2+QOCrSWOz/rj23EwPrCQ2TSRI2fWakMJZ+
 zQZvy+ei3D7lZ09I9BT/GfFkTIONgtNfDxwyMc4v4XyP0IvvZs/YZqt7j3atyTZM0S2HSaZ9
 rXmQYkBt1/u691cZfvy+Tr2xZaDpFcjPkci5Ag0EVgUmGQEQALxSQRbl/QOnmssVDxWhHM5T
 Gxl7oLNJms2zmBpcmlrIsn8nNz0rRyxT460k2niaTwowSRK8KWVDeAW6ZAaWiYjLlTunoKwv
 F8vP3JyWpBz0diTxL5o+xpvy/Q6YU3BNefdq8Vy3rFsxgW7mMSrI/CxJ667y8ot5DVugeS2N
 yHfmZlPGE0Nsy7hlebS4liisXOrN3jFzasKyUws3VXek4V65lHwB23BVzsnFMn/bw/rPliqX
 Gcwl8CoJu8dSyrCcd1Ibs0/Inq9S9+t0VmWiQWfQkz4rvEeTQkp/VfgZ6z98JRW7S6l6eoph
 oWs0/ZyRfOm+QVSqRfFZdxdP2PlGeIFMC3fXJgygXJkFPyWkVElr76JTbtSHsGWbt6xUlYHK
 XWo+xf9WgtLeby3cfSkEchACrxDrQpj+Jt/JFP+q997dybkyZ5IoHWuPkn7uZGBrKIHmBunT
 co1+cKSuRiSCYpBIXZMHCzPgVDjk4viPbrV9NwRkmaOxVvye0vctJeWvJ6KA7NoAURplIGCq
 kCRwg0MmLrfoZnK/gRqVJ/f6adhU1oo6z4p2/z3PemA0C0ANatgHgBb90cd16AUxpdEQmOCm
 dNnNJF/3Zt3inzF+NFzHoM5Vwq6rc1JPjfC3oqRLJzqAEHBDjQFlqNR3IFCIAo4SYQRBdAHB
 CzkM4rWyRhuVABEBAAGJAh8EGAECAAkFAlYFJhkCGwwACgkQ8ww4vT8vvjwg9w//VQrcnVg3
 TsjEybxDEUBm8dBmnKqcnTBFmxN5FFtIWlEuY8+YMiWRykd8Ln9RJ/98/ghABHz9TN8TRo2b
 6WimV64FmlVn17Ri6FgFU3xNt9TTEChqAcNg88eYryKsYpFwegGpwUlaUaaGh1m9OrTzcQy+
 klVfZWaVJ9Nw0keoGRGb8j4XjVpL8+2xOhXKrM1fzzb8JtAuSbuzZSQPDwQEI5CKKxp7zf76
 J21YeRrEW4WDznPyVcDTa+tz++q2S/BpP4W98bXCBIuQgs2m+OflERv5c3Ojldp04/S4NEjX
 EYRWdiCxN7ca5iPml5gLtuvhJMSy36glU6IW9kn30IWuSoBpTkgV7rLUEhh9Ms82VWW/h2Tx
 L8enfx40PrfbDtWwqRID3WY8jLrjKfTdR3LW8BnUDNkG+c4FzvvGUs8AvuqxxyHbXAfDx9o/
 jXfPHVRmJVhSmd+hC3mcQ+4iX5bBPBPMoDqSoLt5w9GoQQ6gDVP2ZjTWqwSRMLzNr37rJjZ1
 pt0DCMMTbiYIUcrhX8eveCJtY7NGWNyxFCRkhxRuGcpwPmRVDwOl39MB3iTsRighiMnijkbL
 XiKoJ5CDVvX5yicNqYJPKh5MFXN1bvsBkmYiStMRbrD0HoY1kx5/VozBtc70OU0EB8Wrv9hZ
 D+Ofp0T3KOr1RUHvCZoLURfFhSQ=
Message-ID: <7affb721-9686-1262-b7cf-d9681646b602@redhat.com>
Date: Tue, 11 Aug 2020 14:02:06 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <7cfc4316-922b-8606-72ce-80205ef55572@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=lvivier@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Amit Shah <amit@kernel.org>, qemu-devel@nongnu.org,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gMTEvMDgvMjAyMCAxMjozNywgUGhpbGlwcGUgTWF0aGlldS1EYXVkw6kgd3JvdGU6Cj4gWW91
IENjJ2VkIHFlbXUtZGV2ZWwsIHNvIENjJ2luZyB0aGUgdmlydGlvLXJuZyBtYWludGFpbmVycy4K
PiAKPiBPbiA3LzE1LzIwIDM6MzIgUE0sIG13aWxja0BzdXNlLmNvbSB3cm90ZToKPj4gRnJvbTog
TWFydGluIFdpbGNrIDxtd2lsY2tAc3VzZS5jb20+Cj4+Cj4+IElmIGEgcHJvZ3JhbSBvcGVucyAv
ZGV2L2h3cm5nIHdpdGggT19OT05CTE9DSyBhbmQgdXNlcyBwb2xsKCkgYW5kCj4+IG5vbi1ibG9j
a2luZyByZWFkKCkgdG8gcmV0cmlldmUgcmFuZG9tIGRhdGEsIGl0IGVuZHMgdXAgaW4gYSB0aWdo
dAo+PiBsb29wIHdpdGggcG9sbCgpIGFsd2F5cyByZXR1cm5pbmcgUE9MTElOIGFuZCByZWFkKCkg
cmV0dXJuaW5nIEVBR0FJTi4KPj4gVGhpcyByZXBlYXRzIGZvcmV2ZXIgdW50aWwgc29tZSBwcm9j
ZXNzIG1ha2VzIGEgYmxvY2tpbmcgcmVhZCgpIGNhbGwuCj4+IFRoZSByZWFzb24gaXMgdGhhdCB2
aXJ0aW9fcmVhZCgpIGFsd2F5cyByZXR1cm5zIDAgaW4gbm9uLWJsb2NraW5nIG1vZGUsCj4+IGV2
ZW4gaWYgZGF0YSBpcyBhdmFpbGFibGUuIFdvcnNlLCBpdCBmZXRjaGVzIHJhbmRvbSBkYXRhIGZy
b20gdGhlCj4+IGh5cGVydmlzb3IgYWZ0ZXIgZXZlcnkgbm9uLWJsb2NraW5nIGNhbGwsIHdpdGhv
dXQgZXZlciB1c2luZyB0aGlzIGRhdGEuCj4+Cj4+IFRoZSBmb2xsb3dpbmcgdGVzdCBwcm9ncmFt
IGlsbHVzdHJhdGVzIHRoZSBiZWhhdmlvciBhbmQgY2FuIGJlIHVzZWQKPj4gZm9yIHRlc3Rpbmcg
YW5kIGV4cGVyaW1lbnRzLiBUaGUgcHJvYmxlbSB3aWxsIG9ubHkgYmUgc2VlbiBpZiBhbGwKPj4g
dGFza3MgdXNlIG5vbi1ibG9ja2luZyBhY2Nlc3M7IG90aGVyd2lzZSB0aGUgYmxvY2tpbmcgcmVh
ZHMgd2lsbAo+PiAicmVjaGFyZ2UiIHRoZSByYW5kb20gcG9vbCBhbmQgY2F1c2Ugb3RoZXIsIG5v
bi1ibG9ja2luZyByZWFkcyB0bwo+PiBzdWNjZWVkIGF0IGxlYXN0IHNvbWV0aW1lcy4KPj4KPj4g
LyogV2hldGhlciB0byB1c2Ugbm9uLWJsb2NraW5nIG1vZGUgaW4gYSB0YXNrLCBwcm9ibGVtIG9j
Y3VycyBpZiBDT05ESVRJT04gaXMgMSAqLwo+PiAvLyNkZWZpbmUgQ09ORElUSU9OIChnZXRwaWQo
KSAlIDIgIT0gMCkKPj4KPj4gc3RhdGljIHZvbGF0aWxlIHNpZ19hdG9taWNfdCBzdG9wOwo+PiBz
dGF0aWMgdm9pZCBoYW5kbGVyKGludCBzaWcgX19hdHRyaWJ1dGVfXygodW51c2VkKSkpIHsgc3Rv
cCA9IDE7IH0KPj4KPj4gc3RhdGljIHZvaWQgbG9vcChpbnQgZmQsIGludCBzZWMpCj4+IHsKPj4g
CXN0cnVjdCBwb2xsZmQgcGZkID0geyAuZmQgPSBmZCwgLmV2ZW50cyAgPSBQT0xMSU4sIH07Cj4+
IAl1bnNpZ25lZCBsb25nIGVycm9ycyA9IDAsIGVhZ2FpbnMgPSAwLCBieXRlcyA9IDAsIHN1Y2Mg
PSAwOwo+PiAJaW50IHNpemUsIHJjLCByZDsKPj4KPj4gCXNyYW5kb20oZ2V0cGlkKCkpOwo+PiAJ
aWYgKENPTkRJVElPTiAmJiBmY250bChmZCwgRl9TRVRGTCwgZmNudGwoZmQsIEZfR0VURkwpIHwg
T19OT05CTE9DSykgPT0gLTEpCj4+IAkJcGVycm9yKCJmY250bCIpOwo+PiAJc2l6ZSA9IE1JTkJV
RlNJWiArIHJhbmRvbSgpICUgKE1BWEJVRlNJWiAtIE1JTkJVRlNJWiArIDEpOwo+Pgo+PiAJZm9y
KDs7KSB7Cj4+IAkJY2hhciBidWZbc2l6ZV07Cj4+Cj4+IAkJaWYgKHN0b3ApCj4+IAkJCWJyZWFr
Owo+PiAJCXJjID0gcG9sbCgmcGZkLCAxLCBzZWMpOwo+PiAJCWlmIChyYyA+IDApIHsKPj4gCQkJ
cmQgPSByZWFkKGZkLCBidWYsIHNpemVvZihidWYpKTsKPj4gCQkJaWYgKHJkID09IC0xICYmIGVy
cm5vID09IEVBR0FJTikKPj4gCQkJCWVhZ2FpbnMrKzsKPj4gCQkJZWxzZSBpZiAocmQgPT0gLTEp
Cj4+IAkJCQllcnJvcnMrKzsKPj4gCQkJZWxzZSB7Cj4+IAkJCQlzdWNjKys7Cj4+IAkJCQlieXRl
cyArPSByZDsKPj4gCQkJCXdyaXRlKDEsIGJ1Ziwgc2l6ZW9mKGJ1ZikpOwo+PiAJCQl9Cj4+IAkJ
fSBlbHNlIGlmIChyYyA9PSAtMSkgewo+PiAJCQlpZiAoZXJybm8gIT0gRUlOVFIpCj4+IAkJCQlw
ZXJyb3IoInBvbGwiKTsKPj4gCQkJYnJlYWs7Cj4+IAkJfSBlbHNlCj4+IAkJCWZwcmludGYoc3Rk
ZXJyLCAicG9sbDogdGltZW91dFxuIik7Cj4+IAl9Cj4+IAlmcHJpbnRmKHN0ZGVyciwKPj4gCQki
cGlkICVkICVzYmxvY2tpbmcsIGJ1ZnNpemUgJWQsICVkIHNlY29uZHMsICVsdSBieXRlcyByZWFk
LCAlbHUgc3VjY2VzcywgJWx1IGVhZ2FpbiwgJWx1IGVycm9yc1xuIiwKPj4gCQlnZXRwaWQoKSwg
Q09ORElUSU9OID8gIm5vbi0iIDogIiIsIHNpemUsIHNlYywgYnl0ZXMsIHN1Y2MsIGVhZ2FpbnMs
IGVycm9ycyk7Cj4+IH0KPj4KPj4gaW50IG1haW4odm9pZCkKPj4gewo+PiAJaW50IGZkOwo+Pgo+
PiAJZm9yaygpOyBmb3JrKCk7Cj4+IAlmZCA9IG9wZW4oIi9kZXYvaHdybmciLCBPX1JET05MWSk7
Cj4+IAlpZiAoZmQgPT0gLTEpIHsKPj4gCQlwZXJyb3IoIm9wZW4iKTsKPj4gCQlyZXR1cm4gMTsK
Pj4gCX07Cj4+IAlzaWduYWwoU0lHQUxSTSwgaGFuZGxlcik7Cj4+IAlhbGFybShTRUNPTkRTKTsK
Pj4gCWxvb3AoZmQsIFNFQ09ORFMpOwo+PiAJY2xvc2UoZmQpOwo+PiAJd2FpdChOVUxMKTsKPj4g
CXJldHVybiAwOwo+PiB9Cj4+Cj4+IHZvaWQgbG9vcChpbnQgZmQpCj4+IHsKPj4gICAgICAgICBz
dHJ1Y3QgcG9sbGZkIHBmZDAgPSB7IC5mZCA9IGZkLCAuZXZlbnRzICA9IFBPTExJTiwgfTsKPj4g
ICAgICAgICBpbnQgcmM7Cj4+ICAgICAgICAgdW5zaWduZWQgaW50IG47Cj4+Cj4+ICAgICAgICAg
Zm9yIChuID0gTE9PUFM7IG4gPiAwOyBuLS0pIHsKPj4gICAgICAgICAgICAgICAgIHN0cnVjdCBw
b2xsZmQgcGZkID0gcGZkMDsKPj4gICAgICAgICAgICAgICAgIGNoYXIgYnVmW1NJWkVdOwo+Pgo+
PiAgICAgICAgICAgICAgICAgcmMgPSBwb2xsKCZwZmQsIDEsIDEpOwo+PiAgICAgICAgICAgICAg
ICAgaWYgKHJjID4gMCkgewo+PiAgICAgICAgICAgICAgICAgICAgICAgICBpbnQgcmQgPSByZWFk
KGZkLCBidWYsIHNpemVvZihidWYpKTsKPj4KPj4gICAgICAgICAgICAgICAgICAgICAgICAgaWYg
KHJkID09IC0xKQo+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHBlcnJvcigicmVh
ZCIpOwo+PiAgICAgICAgICAgICAgICAgICAgICAgICBlbHNlCj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgcHJpbnRmKCJyZWFkICVkIGJ5dGVzXG4iLCByZCk7Cj4+ICAgICAgICAg
ICAgICAgICB9IGVsc2UgaWYgKHJjID09IC0xKQo+PiAgICAgICAgICAgICAgICAgICAgICAgICBw
ZXJyb3IoInBvbGwiKTsKPj4gICAgICAgICAgICAgICAgIGVsc2UKPj4gICAgICAgICAgICAgICAg
ICAgICAgICAgZnByaW50ZihzdGRlcnIsICJ0aW1lb3V0XG4iKTsKPj4KPj4gICAgICAgICB9Cj4+
IH0KPj4KPj4gaW50IG1haW4odm9pZCkKPj4gewo+PiAgICAgICAgIGludCBmZDsKPj4KPj4gICAg
ICAgICBmZCA9IG9wZW4oIi9kZXYvaHdybmciLCBPX1JET05MWXxPX05PTkJMT0NLKTsKPj4gICAg
ICAgICBpZiAoZmQgPT0gLTEpIHsKPj4gICAgICAgICAgICAgICAgIHBlcnJvcigib3BlbiIpOwo+
PiAgICAgICAgICAgICAgICAgcmV0dXJuIDE7Cj4+ICAgICAgICAgfTsKPj4gICAgICAgICBsb29w
KGZkKTsKPj4gICAgICAgICBjbG9zZShmZCk7Cj4+ICAgICAgICAgcmV0dXJuIDA7Cj4+IH0KPj4K
Pj4gVGhpcyBjYW4gYmUgb2JzZXJ2ZWQgaW4gdGhlIHJlYWwgd29yZCBlLmcuIHdpdGggbmVzdGVk
IHFlbXUvS1ZNIHZpcnR1YWwKPj4gbWFjaGluZXMsIGlmIGJvdGggdGhlICJvdXRlciIgYW5kICJp
bm5lciIgVk1zIGhhdmUgYSB2aXJ0aW8tcm5nIGRldmljZS4KPj4gSWYgdGhlICJpbm5lciIgVk0g
cmVxdWVzdHMgcmFuZG9tIGRhdGEsIHFlbXUgcnVubmluZyBpbiB0aGUgIm91dGVyIiBWTQo+PiB1
c2VzIHRoaXMgZGV2aWNlIGluIGEgbm9uLWJsb2NraW5nIG1hbm5lciBsaWtlIHRoZSB0ZXN0IHBy
b2dyYW0gYWJvdmUuCj4+Cj4+IEZpeCBpdCBieSByZXR1cm5pbmcgYXZhaWxhYmxlIGRhdGEgaWYg
YSBwcmV2aW91cyBoeXBlcnZpc29yIGNhbGwgaGFzCj4+IGNvbXBsZXRlZCBpbiB0aGUgbWVhbnRp
bWUuIEkgdGVzdGVkIHRoZSBwYXRjaCB3aXRoIHRoZSBwcm9ncmFtIGFib3ZlLAo+PiBhbmQgd2l0
aCBybmctdG9vbHMuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IE1hcnRpbiBXaWxjayA8bXdpbGNrQHN1
c2UuY29tPgo+PiAtLS0KPj4gIGRyaXZlcnMvY2hhci9od19yYW5kb20vdmlydGlvLXJuZy5jIHwg
MTQgKysrKysrKysrKysrKysKPj4gIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspCj4+
Cj4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL2NoYXIvaHdfcmFuZG9tL3ZpcnRpby1ybmcuYyBiL2Ry
aXZlcnMvY2hhci9od19yYW5kb20vdmlydGlvLXJuZy5jCj4+IGluZGV4IDc5YTZlNDdiNWZiYy4u
OTg0NzEzYjM1ODkyIDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL2NoYXIvaHdfcmFuZG9tL3ZpcnRp
by1ybmcuYwo+PiArKysgYi9kcml2ZXJzL2NoYXIvaHdfcmFuZG9tL3ZpcnRpby1ybmcuYwo+PiBA
QCAtNTksNiArNTksMjAgQEAgc3RhdGljIGludCB2aXJ0aW9fcmVhZChzdHJ1Y3QgaHdybmcgKnJu
Zywgdm9pZCAqYnVmLCBzaXplX3Qgc2l6ZSwgYm9vbCB3YWl0KQo+PiAgCWlmICh2aS0+aHdybmdf
cmVtb3ZlZCkKPj4gIAkJcmV0dXJuIC1FTk9ERVY7Cj4+ICAKPj4gKwkvKgo+PiArCSAqIElmIHRo
ZSBwcmV2aW91cyBjYWxsIHdhcyBub24tYmxvY2tpbmcsIHdlIG1heSBoYXZlIGdvdCBzb21lCj4+
ICsJICogcmFuZG9tbmVzcyBhbHJlYWR5Lgo+PiArCSAqLwo+PiArCWlmICh2aS0+YnVzeSAmJiBj
b21wbGV0aW9uX2RvbmUoJnZpLT5oYXZlX2RhdGEpKSB7Cj4+ICsJCXVuc2lnbmVkIGludCBsZW47
Cj4+ICsKPj4gKwkJdmktPmJ1c3kgPSBmYWxzZTsKPj4gKwkJbGVuID0gdmktPmRhdGFfYXZhaWwg
PiBzaXplID8gc2l6ZSA6IHZpLT5kYXRhX2F2YWlsOwo+PiArCQl2aS0+ZGF0YV9hdmFpbCAtPSBs
ZW47CgpZb3UgZG9uJ3QgbmVlZCB0byBtb2RpZnkgZGF0YV9hdmFpbC4gQXMgYnVzeSBpcyBzZXQg
dG8gZmFsc2UsIHRoZSBidWZmZXIKd2lsbCBiZSByZXVzZWQuIGFuZCBpdCBpcyBhbHdheXMgb3Zl
cndyaXR0ZW4gYnkgdmlydHF1ZXVlX2dldF9idWYoKS4KQW5kIG1vcmVvdmVyLCBpZiBpdCB3YXMg
cmV1c2VkIGl0IHdvdWxkIGJlIGFsd2F5cyB0aGUgYmVnaW5uaW5nLgoKPj4gKwkJaWYgKGxlbikK
Pj4gKwkJCXJldHVybiBsZW47Cj4+ICsJfQo+PiArCj4+ICAJaWYgKCF2aS0+YnVzeSkgewo+PiAg
CQl2aS0+YnVzeSA9IHRydWU7Cj4+ICAJCXJlaW5pdF9jb21wbGV0aW9uKCZ2aS0+aGF2ZV9kYXRh
KTsKPj4KPiAKCldoeSBkb24ndCB5b3UgbW9kaWZ5IG9ubHkgdGhlIHdhaXQgY2FzZT8KClNvbWV0
aGluZyBsaWtlOgoKCWlmICghd2FpdCAmJiAhY29tcGxldGlvbl9kb25lKCZ2aS0+aGF2ZV9kYXRh
KSkgewoJCXJldHVybiAwOwogICAgICAgIH0KCnRoZW4gYXQgdGhlIGVuZCB5b3UgY2FuIGRvICJy
ZXR1cm4gbWluKHNpemUsIHZpLT5kYXRhX2F2YWlsKTsiLgoKVGhhbmtzLApMYXVyZW50CgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
