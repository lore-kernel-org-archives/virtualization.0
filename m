Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FE32C433F5
	for <virtualization@archiver.kernel.org>; Wed,  2 Mar 2022 08:29:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2813B60BC3;
	Wed,  2 Mar 2022 08:29:51 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id geRBVYDiHSdJ; Wed,  2 Mar 2022 08:29:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 957FE607A4;
	Wed,  2 Mar 2022 08:29:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7936FC0012;
	Wed,  2 Mar 2022 08:29:49 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B65FAC000B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 08:29:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A9993403C4
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 08:29:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id mLP-H2F4pVAR
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 08:29:46 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com
 [IPv6:2a00:1450:4864:20::330])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1669240396
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Mar 2022 08:29:46 +0000 (UTC)
Received: by mail-wm1-x330.google.com with SMTP id
 p184-20020a1c29c1000000b0037f76d8b484so726947wmp.5
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 00:29:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=anfYM1xs0NBMLGEeqezGOYJl+MN+3QcGgOkQ0d7W1KU=;
 b=T250LPSLKUXQUaclMSeK0mZPrWImkaAZdf7+pxpZvYBVIjiMfRgaCAywrd9G1ZgB/0
 RPeRZER9ugo42HQs7vOFLBMSQPAOYqXg/oajPZgQ5ONy0UZDqxelCW0yWfe1ksHhPrcL
 P/a98j6H0buLuTut7KDXTAftRVTqbi5jMarQoWo0xKWi9Z3HP4a7XxZrRZ0rOP/uX4Az
 LLIvmIk/579eXMZTSFWGq2fEQFgW+uDPuDijzIupYzselXw2nRaSOd5AugqhhPqSZ3gc
 FEmfiAKLSrRBVcbA2KYP4MfAaSSA9cu4RGT+7dOnfaFc9d8vJLURer8fML3X+2CR2b/7
 ze5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=anfYM1xs0NBMLGEeqezGOYJl+MN+3QcGgOkQ0d7W1KU=;
 b=uzKHHS4J8RrUIiTphRjBzGDH2hKGAbwrOs7q6sGsM5Z+wkWivwKu0lz85dhkEW4bDS
 EiignvM7hyGKI4lxOeZF6c58k7Rj8/waQ5EgqXR1qb3776cwORxUz/lzvrteWlUjnns5
 rc7odeIURJqrjcrkEYrBQGnfEUOXBDGNQDy5k41aYzwwlcaLFsLpoVtL/XUJZu/brVWL
 2monaVstZsFX2SmWoEphPjeHKwMQtW6QP6zdkpNJgAGo9HOJ1R9Yj94a5bME2GA3t9Z6
 4HhSznjpgb9NQtozWuTz8mjEEKYrbsfV2Olla9ki0wjKuHBIjyAUEw7x3btuj/IKnutp
 SP3g==
X-Gm-Message-State: AOAM5325ATlIF0hSztNC28/Omh0iJ86cM6w8yUZhdXk+IXFAR7mOgsA6
 n0EU5Y17tP/bBRmMrdvAqJUQkw==
X-Google-Smtp-Source: ABdhPJyejoqO4Ua2lw3doPCMFKI7AoknOX/n2Hq9a7QihlNIy2VB0jsIjJbRKAzoK9Beq8n1Bceu5Q==
X-Received: by 2002:a1c:a915:0:b0:380:e3de:b78f with SMTP id
 s21-20020a1ca915000000b00380e3deb78fmr20356178wme.19.1646209784264; 
 Wed, 02 Mar 2022 00:29:44 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net.
 [86.27.177.88]) by smtp.gmail.com with ESMTPSA id
 z16-20020a7bc7d0000000b00381004c643asm4689971wmk.30.2022.03.02.00.29.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Mar 2022 00:29:43 -0800 (PST)
Date: Wed, 2 Mar 2022 08:29:41 +0000
From: Lee Jones <lee.jones@linaro.org>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [syzbot] kernel BUG in vhost_get_vq_desc
Message-ID: <Yh8q9fzCQHW2qtIG@google.com>
References: <00000000000070ac6505d7d9f7a8@google.com>
 <0000000000003b07b305d840b30f@google.com>
 <20220218063352-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20220218063352-mutt-send-email-mst@kernel.org>
Cc: kvm@vger.kernel.org,
 syzbot <syzbot+3140b17cb44a7b174008@syzkaller.appspotmail.com>,
 netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

T24gRnJpLCAxOCBGZWIgMjAyMiwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgoKPiBPbiBUaHUs
IEZlYiAxNywgMjAyMiBhdCAwNToyMToyMFBNIC0wODAwLCBzeXpib3Qgd3JvdGU6Cj4gPiBzeXpi
b3QgaGFzIGZvdW5kIGEgcmVwcm9kdWNlciBmb3IgdGhlIGZvbGxvd2luZyBpc3N1ZSBvbjoKPiA+
IAo+ID4gSEVBRCBjb21taXQ6ICAgIGY3MTA3N2E0ZDg0YiBNZXJnZSB0YWcgJ21tYy12NS4xNy1y
YzEtMicgb2YgZ2l0Oi8vZ2l0Lmtlcm4uLgo+ID4gZ2l0IHRyZWU6ICAgICAgIHVwc3RyZWFtCj4g
PiBjb25zb2xlIG91dHB1dDogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC9sb2cudHh0
P3g9MTA0YzA0Y2E3MDAwMDAKPiA+IGtlcm5lbCBjb25maWc6ICBodHRwczovL3N5emthbGxlci5h
cHBzcG90LmNvbS94Ly5jb25maWc/eD1hNzhiMDY0NTkwYjlmOTEyCj4gPiBkYXNoYm9hcmQgbGlu
azogaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20vYnVnP2V4dGlkPTMxNDBiMTdjYjQ0YTdi
MTc0MDA4Cj4gPiBjb21waWxlcjogICAgICAgZ2NjIChEZWJpYW4gMTAuMi4xLTYpIDEwLjIuMSAy
MDIxMDExMCwgR05VIGxkIChHTlUgQmludXRpbHMgZm9yIERlYmlhbikgMi4zNS4yCj4gPiBzeXog
cmVwcm86ICAgICAgaHR0cHM6Ly9zeXprYWxsZXIuYXBwc3BvdC5jb20veC9yZXByby5zeXo/eD0x
MzYyZTIzMjcwMDAwMAo+ID4gQyByZXByb2R1Y2VyOiAgIGh0dHBzOi8vc3l6a2FsbGVyLmFwcHNw
b3QuY29tL3gvcmVwcm8uYz94PTExMzczYTZjNzAwMDAwCj4gPiAKPiA+IElNUE9SVEFOVDogaWYg
eW91IGZpeCB0aGUgaXNzdWUsIHBsZWFzZSBhZGQgdGhlIGZvbGxvd2luZyB0YWcgdG8gdGhlIGNv
bW1pdDoKPiA+IFJlcG9ydGVkLWJ5OiBzeXpib3QrMzE0MGIxN2NiNDRhN2IxNzQwMDhAc3l6a2Fs
bGVyLmFwcHNwb3RtYWlsLmNvbQo+ID4gCj4gPiAtLS0tLS0tLS0tLS1bIGN1dCBoZXJlIF0tLS0t
LS0tLS0tLS0KPiA+IGtlcm5lbCBCVUcgYXQgZHJpdmVycy92aG9zdC92aG9zdC5jOjIzMzUhCj4g
PiBpbnZhbGlkIG9wY29kZTogMDAwMCBbIzFdIFBSRUVNUFQgU01QIEtBU0FOCj4gPiBDUFU6IDEg
UElEOiAzNTk3IENvbW06IHZob3N0LTM1OTYgTm90IHRhaW50ZWQgNS4xNy4wLXJjNC1zeXprYWxs
ZXItMDAwNTQtZ2Y3MTA3N2E0ZDg0YiAjMAo+ID4gSGFyZHdhcmUgbmFtZTogR29vZ2xlIEdvb2ds
ZSBDb21wdXRlIEVuZ2luZS9Hb29nbGUgQ29tcHV0ZSBFbmdpbmUsIEJJT1MgR29vZ2xlIDAxLzAx
LzIwMTEKPiA+IFJJUDogMDAxMDp2aG9zdF9nZXRfdnFfZGVzYysweDFkNDMvMHgyMmMwIGRyaXZl
cnMvdmhvc3Qvdmhvc3QuYzoyMzM1Cj4gPiBDb2RlOiAwMCAwMCAwMCA0OCBjNyBjNiAyMCAyYyA5
ZCA4YSA0OCBjNyBjNyA5OCBhNiA4ZSA4ZCA0OCA4OSBjYSA0OCBjMSBlMSAwNCA0OCAwMSBkOSBl
OCBiNyA1OSAyOCBmZCBlOSA3NCBmZiBmZiBmZiBlOCA1ZCBjOCBhMSBmYSA8MGY+IDBiIGU4IDU2
IGM4IGExIGZhIDQ4IDhiIDU0IDI0IDE4IDQ4IGI4IDAwIDAwIDAwIDAwIDAwIGZjIGZmIGRmCj4g
PiBSU1A6IDAwMTg6ZmZmZmM5MDAwMWQxZmI4OCBFRkxBR1M6IDAwMDEwMjkzCj4gPiBSQVg6IDAw
MDAwMDAwMDAwMDAwMDAgUkJYOiAwMDAwMDAwMDAwMDAwMDAxIFJDWDogMDAwMDAwMDAwMDAwMDAw
MAo+ID4gUkRYOiBmZmZmODg4MDIzNGIwMDAwIFJTSTogZmZmZmZmZmY4NmQ3MTVjMyBSREk6IDAw
MDAwMDAwMDAwMDAwMDMKPiA+IFJCUDogMDAwMDAwMDAwMDAwMDAwMCBSMDg6IDAwMDAwMDAwMDAw
MDAwMDAgUjA5OiAwMDAwMDAwMDAwMDAwMDAxCj4gPiBSMTA6IGZmZmZmZmZmODZkNzA2YmMgUjEx
OiAwMDAwMDAwMDAwMDAwMDAwIFIxMjogZmZmZjg4ODA3MmMyNGQ2OAo+ID4gUjEzOiAwMDAwMDAw
MDAwMDAwMDAwIFIxNDogZGZmZmZjMDAwMDAwMDAwMCBSMTU6IGZmZmY4ODgwNzJjMjRiYjAKPiA+
IEZTOiAgMDAwMDAwMDAwMDAwMDAwMCgwMDAwKSBHUzpmZmZmODg4MGI5ZDAwMDAwKDAwMDApIGtu
bEdTOjAwMDAwMDAwMDAwMDAwMDAKPiA+IENTOiAgMDAxMCBEUzogMDAwMCBFUzogMDAwMCBDUjA6
IDAwMDAwMDAwODAwNTAwMzMKPiA+IENSMjogMDAwMDAwMDAwMDAwMDAwMiBDUjM6IDAwMDAwMDAw
NzkwMmMwMDAgQ1I0OiAwMDAwMDAwMDAwMzUwNmUwCj4gPiBEUjA6IDAwMDAwMDAwMDAwMDAwMDAg
RFIxOiAwMDAwMDAwMDAwMDAwMDAwIERSMjogMDAwMDAwMDAwMDAwMDAwMAo+ID4gRFIzOiAwMDAw
MDAwMDAwMDAwMDAwIERSNjogMDAwMDAwMDBmZmZlMGZmMCBEUjc6IDAwMDAwMDAwMDAwMDA0MDAK
PiA+IENhbGwgVHJhY2U6Cj4gPiAgPFRBU0s+Cj4gPiAgdmhvc3RfdnNvY2tfaGFuZGxlX3R4X2tp
Y2srMHgyNzcvMHhhMjAgZHJpdmVycy92aG9zdC92c29jay5jOjUyMgo+ID4gIHZob3N0X3dvcmtl
cisweDIzZC8weDNkMCBkcml2ZXJzL3Zob3N0L3Zob3N0LmM6MzcyCj4gPiAga3RocmVhZCsweDJl
OS8weDNhMCBrZXJuZWwva3RocmVhZC5jOjM3Nwo+ID4gIHJldF9mcm9tX2ZvcmsrMHgxZi8weDMw
IGFyY2gveDg2L2VudHJ5L2VudHJ5XzY0LlM6Mjk1Cj4gCj4gSSBkb24ndCBzZWUgaG93IHRoaXMg
Y2FuIHRyaWdnZXIgbm9ybWFsbHkgc28gSSdtIGFzc3VtaW5nCj4gYW5vdGhlciBjYXNlIG9mIHVz
ZSBhZnRlciBmcmVlLgoKWWVzLCBleGFjdGx5LgoKSSBwYXRjaGVkIGl0LiAgUGxlYXNlIHNlZToK
Cmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIyMDMwMjA3NTQyMS4yMTMxMjIxLTEtbGVl
LmpvbmVzQGxpbmFyby5vcmcvVC8jdAoKLS0gCkxlZSBKb25lcyBb5p2O55C85pavXQpQcmluY2lw
YWwgVGVjaG5pY2FsIExlYWQgLSBEZXZlbG9wZXIgU2VydmljZXMKTGluYXJvLm9yZyDilIIgT3Bl
biBzb3VyY2Ugc29mdHdhcmUgZm9yIEFybSBTb0NzCkZvbGxvdyBMaW5hcm86IEZhY2Vib29rIHwg
VHdpdHRlciB8IEJsb2cKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
