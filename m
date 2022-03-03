Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44516C433F5
	for <virtualization@archiver.kernel.org>; Thu,  3 Mar 2022 19:38:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id D281360B64;
	Thu,  3 Mar 2022 19:38:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id pqgg6dTHB_Ma; Thu,  3 Mar 2022 19:38:35 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 75276605A2;
	Thu,  3 Mar 2022 19:38:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 489C3C0012;
	Thu,  3 Mar 2022 19:38:34 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 2649FC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 19:38:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0E73D40324
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 19:38:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (2048-bit key) header.d=linaro.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qt7ZFziRCyGn
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 19:38:31 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com
 [IPv6:2a00:1450:4864:20::433])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BC44740333
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 19:38:30 +0000 (UTC)
Received: by mail-wr1-x433.google.com with SMTP id bk29so9429758wrb.4
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Mar 2022 11:38:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=K/Uvx4MIMduNNDUv4nDfaCXMVJaGsHQl+DgmzbLveXQ=;
 b=e2UXZ2yMHjPpoZgPSa1aRHFYjLtrivnIS2MfokW9t+URqQaA2lz0Jk892K6CpV4Can
 fI2Dn7TVWCTVCMo/IbIhYVani9D/KsdjabsR13UQNjbxDvfYT8FQqnms61kik5HvSXLT
 8SNiyCOcpYUsDJd96EhjKTrn3qFsYHWOaiFvG0v+Og2ywiklUW45/qieIvuFe1kRN2Wq
 ABfxlSHYHSh1PvX3ydZW9WZP4x+sro+5PnYnjrbSJ035qgD5eiQXMsShISpMlpJsBfwc
 YCl4eCNMO1TVH1gA4Q/kAgG5fFFQ+sSGPMS9WqK3+W5lARa245KVDXUOXwNKDeEdoEMx
 XvAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=K/Uvx4MIMduNNDUv4nDfaCXMVJaGsHQl+DgmzbLveXQ=;
 b=1fkDZIUe3ruNpDg2H5WWd3KznPdYIFo6xA3tDX0cr0oXWyH3odf4q616+QtRLQtLwb
 KhW8XK6y/47/efKpQajH8jkwfR4AN3LukGLajJGPYEz+rMBGnLQaakGeyC34x3d1h0Hw
 iFryiJ/0L6ZNKDgP5JFXSet/gr3fyqHJ3Hk5f44t4g3UczA72S5K0PbqTaT/Lps10d0w
 x7YNEB684w/fD4l+ZzGgrJwYupiIQbDEH3rqvLFFbzD3YbSaAFqyja19VnNBHk6U4bbn
 nxorJW33ThTMOfzV/9qczXx5bz12rCDidLQdAxjPomII6/zmaCEjP7ZEz/Yoz8ALFu4h
 xGTA==
X-Gm-Message-State: AOAM532d5y2V4Ori/DBhQhJKNP8kfXpzOIuA/n2SrQrlvOTXfQE7vVA4
 b2PKk6QJW0i0tTvJ4CYr7qmQVQ==
X-Google-Smtp-Source: ABdhPJxF1hwyx/TulXuxizSn127hf9j+oayH5mwMGUSVqCtOFlbiXVw7t2v5rHwBQTtwhb5/KdQc7A==
X-Received: by 2002:a5d:43c2:0:b0:1ed:c331:9a96 with SMTP id
 v2-20020a5d43c2000000b001edc3319a96mr29299741wrr.389.1646336308813; 
 Thu, 03 Mar 2022 11:38:28 -0800 (PST)
Received: from google.com (cpc155339-bagu17-2-0-cust87.1-3.cable.virginm.net.
 [86.27.177.88]) by smtp.gmail.com with ESMTPSA id
 bi21-20020a05600c3d9500b003814de297fcsm9093215wmb.16.2022.03.03.11.38.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 03 Mar 2022 11:38:28 -0800 (PST)
Date: Thu, 3 Mar 2022 19:38:24 +0000
From: Lee Jones <lee.jones@linaro.org>
To: Leon Romanovsky <leon@kernel.org>
Subject: Re: [PATCH 1/1] vhost: Provide a kernel warning if mutex is held
 whilst clean-up in progress
Message-ID: <YiEZMHJ6urZTffsq@google.com>
References: <20220303151929.2505822-1-lee.jones@linaro.org>
 <YiETnIcfZCLb63oB@unreal>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <YiETnIcfZCLb63oB@unreal>
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
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

T24gVGh1LCAwMyBNYXIgMjAyMiwgTGVvbiBSb21hbm92c2t5IHdyb3RlOgoKPiBPbiBUaHUsIE1h
ciAwMywgMjAyMiBhdCAwMzoxOToyOVBNICswMDAwLCBMZWUgSm9uZXMgd3JvdGU6Cj4gPiBBbGwg
d29ya2Vycy91c2VycyBzaG91bGQgYmUgaGFsdGVkIGJlZm9yZSBhbnkgY2xlYW4tdXAgc2hvdWxk
IHRha2UgcGxhY2UuCj4gPiAKPiA+IFN1Z2dlc3RlZC1ieTogIE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBMZWUgSm9uZXMgPGxlZS5qb25lc0Bs
aW5hcm8ub3JnPgo+ID4gLS0tCj4gPiAgZHJpdmVycy92aG9zdC92aG9zdC5jIHwgMyArKysKPiA+
ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspCj4gPiAKPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3Zob3N0L3Zob3N0LmMgYi9kcml2ZXJzL3Zob3N0L3Zob3N0LmMKPiA+IGluZGV4IGJi
YWZmNmE1ZTIxYjguLmQ5MzVkMjUwNjk2M2YgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3Zob3N0
L3Zob3N0LmMKPiA+ICsrKyBiL2RyaXZlcnMvdmhvc3Qvdmhvc3QuYwo+ID4gQEAgLTY5Myw2ICs2
OTMsOSBAQCB2b2lkIHZob3N0X2Rldl9jbGVhbnVwKHN0cnVjdCB2aG9zdF9kZXYgKmRldikKPiA+
ICAJaW50IGk7Cj4gPiAgCj4gPiAgCWZvciAoaSA9IDA7IGkgPCBkZXYtPm52cXM7ICsraSkgewo+
ID4gKwkJLyogSWRlYWxseSBhbGwgd29ya2VycyBzaG91bGQgYmUgc3RvcHBlZCBwcmlvciB0byBj
bGVhbi11cCAqLwo+ID4gKwkJV0FSTl9PTihtdXRleF9pc19sb2NrZWQoJmRldi0+dnFzW2ldLT5t
dXRleCkpOwo+ID4gKwo+ID4gIAkJbXV0ZXhfbG9jaygmZGV2LT52cXNbaV0tPm11dGV4KTsKPiAK
PiBJIGtub3cgbm90aGluZyBhYm91dCB2aG9zdCwgYnV0IHRoaXMgY29uc3RydWN0aW9uIGFuZCBw
YXRjaCBsb29rcwo+IHN0cmFuZ2UgdG8gbWUuCj4gCj4gSWYgYWxsIHdvcmtlcnMgd2VyZSBzdG9w
cGVkLCB5b3Ugd29uJ3QgbmVlZCBtdXRleF9sb2NrKCkuIFRoZSBtdXRleF9sb2NrCj4gaGVyZSBz
dWdnZXN0cyB0byBtZSB0aGF0IHdvcmtlcnMgY2FuIHN0aWxsIHJ1biBoZXJlLgoKVGhlIHN1Z2dl
c3Rpb24gZm9yIHRoaXMgcGF0Y2ggY2FtZSBmcm9tIHRoZSBtYWludGFpbmVyLgoKUGxlYXNlIHNl
ZSB0aGUgY29udmVyc2F0aW9uIGhlcmU6CgpodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMjAy
MjAzMDIwODIwMjEtbXV0dC1zZW5kLWVtYWlsLW1zdEBrZXJuZWwub3JnLwoKLS0gCkxlZSBKb25l
cyBb5p2O55C85pavXQpQcmluY2lwYWwgVGVjaG5pY2FsIExlYWQgLSBEZXZlbG9wZXIgU2Vydmlj
ZXMKTGluYXJvLm9yZyDilIIgT3BlbiBzb3VyY2Ugc29mdHdhcmUgZm9yIEFybSBTb0NzCkZvbGxv
dyBMaW5hcm86IEZhY2Vib29rIHwgVHdpdHRlciB8IEJsb2cKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
