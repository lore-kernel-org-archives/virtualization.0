Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EF5FC05027
	for <virtualization@archiver.kernel.org>; Tue, 14 Feb 2023 06:16:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 04CC681DFA;
	Tue, 14 Feb 2023 06:16:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 04CC681DFA
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZYclGWb5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fQBgyU0OaeF9; Tue, 14 Feb 2023 06:16:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 82D2B81442;
	Tue, 14 Feb 2023 06:16:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 82D2B81442
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 61281C0032;
	Tue, 14 Feb 2023 06:16:14 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DFE8BC002B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 06:16:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id B692C610A5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 06:16:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B692C610A5
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ZYclGWb5
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id MXlpg5VrS8IG
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 06:16:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 4F46B6103E
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 4F46B6103E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 14 Feb 2023 06:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1676355369;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kdiiCGs8jiF79cxtwJhxCLI6Aw09fwGlhkOX3JAkxyg=;
 b=ZYclGWb5e+FtPN8cMDR1y/RzvVVTZvbWxuEfwawDoGj4hInNvi5DPuCGy4KL8uZCXK5jHo
 RopGuERTk1IKxpcdMpPOoR5vsZR8qY/e+s2DLjhVWONI6r2Z2pjBGd6HNPKrCnV3PNrh4m
 OZCfOcDExNIMkiS90/87Yeey2eBLxfs=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-237-APmryWiiPi-Kett13k5yPw-1; Tue, 14 Feb 2023 01:16:08 -0500
X-MC-Unique: APmryWiiPi-Kett13k5yPw-1
Received: by mail-pl1-f198.google.com with SMTP id
 t11-20020a1709028c8b00b00199404808b9so8544200plo.1
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Feb 2023 22:16:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:content-language
 :references:cc:to:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=kdiiCGs8jiF79cxtwJhxCLI6Aw09fwGlhkOX3JAkxyg=;
 b=BbrxhYKgOHXW1EwbvMVwCOzhSHc8/+juzuM+70bnF3nxOQaVaeenFHgHW1O/jojHM7
 2KaBk9v1l3w2DCsd6C5tCDAOdPunPqlh+Jb9Eri6tUW4X2i85Yobfl5SrPTNRc4i1vYH
 aYmOTcjuQZLFveVq/LJ7mLSxzBrDqrDIZl+QyC1a/LrhG8UnMci2upDN9ejvr9J/wVWU
 jkoCMKucrFx16A6u/Mm20F1J3swrvCLBWJJcW2b538Z8RGGpFLv/S4ENo0hyuBwSdizd
 5t1CFp3S7+tWOv6/ELVFf/FS8kN/XCZf9Vv6JOA/bnHK4JIk6DOCMFl3SNAtWt+559gS
 30QA==
X-Gm-Message-State: AO0yUKUILxxT9+WXTs0V9qDOuIfEQxhwwlgcoFM0GAfIl1bBGkTFXECa
 3CuvkkkF7nRP95E3jj9t8Co0l1/QA2u//+NeZXoh/n1U49Vp9pBxeb8RXZ2jh6UL7qEt3OhUVSf
 Fm5reOZ28DxbaaFmW4sN5M88iXgn3WWXTlB/cJ6G3+A==
X-Received: by 2002:a05:6a20:840a:b0:bf:bcfb:1fc6 with SMTP id
 c10-20020a056a20840a00b000bfbcfb1fc6mr1537579pzd.60.1676355367482; 
 Mon, 13 Feb 2023 22:16:07 -0800 (PST)
X-Google-Smtp-Source: AK7set8hzWGwEqgdlvLWXsVMPGUwJMn4RgGjVNPla0dljDV116NxK8RoamZZUke8WlIgbRkDx9qv4Q==
X-Received: by 2002:a05:6a20:840a:b0:bf:bcfb:1fc6 with SMTP id
 c10-20020a056a20840a00b000bfbcfb1fc6mr1537555pzd.60.1676355367211; 
 Mon, 13 Feb 2023 22:16:07 -0800 (PST)
Received: from [10.72.12.89] ([43.228.180.230])
 by smtp.gmail.com with ESMTPSA id
 v15-20020aa7808f000000b00593e84f2d08sm73842pff.52.2023.02.13.22.16.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 13 Feb 2023 22:16:06 -0800 (PST)
Message-ID: <db99245c-606a-2f24-52fe-836a6972437f@redhat.com>
Date: Tue, 14 Feb 2023 14:16:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] vhost-vdpa: cleanup memory maps when closing vdpa fds
To: "Longpeng(Mike)" <longpeng2@huawei.com>, mst@redhat.com
References: <20230131145310.2069-1-longpeng2@huawei.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20230131145310.2069-1-longpeng2@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, huangzhichao@huawei.com,
 yechuan@huawei.com
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

CuWcqCAyMDIzLzEvMzEgMjI6NTMsIExvbmdwZW5nKE1pa2UpIOWGmemBkzoKPiBGcm9tOiBMb25n
cGVuZyA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+Cj4KPiBXZSBtdXN0IGNsZWFudXAgYWxsIG1lbW9y
eSBtYXBzIHdoZW4gY2xvc2luZyB0aGUgdmRwYSBmZHMsIG90aGVyd2lzZQo+IHNvbWUgY3JpdGlj
YWwgcmVzb3VyY2VzIChlLmcuIG1lbW9yeSwgaW9tbXUgbWFwKSB3aWxsIGxlYWtlZCBpZiB0aGUK
PiB1c2Vyc3BhY2UgZXhpdHMgdW5leHBlY3RlZGx5IChlLmcuIGtpbGwgLTkpLgoKClNvdW5kcyBs
aWtlIGEgYnVnIG9mIHRoZSBrZXJuZWwsIHNob3VsZCB3ZSBmaXggdGhlcmU/CgpUaGFua3MKCgo+
Cj4gU2lnbmVkLW9mZi1ieTogTG9uZ3BlbmcgPGxvbmdwZW5nMkBodWF3ZWkuY29tPgo+IC0tLQo+
ICAgZHJpdmVycy92aG9zdC92ZHBhLmMgfCAxMyArKysrKysrKysrKysrCj4gICAxIGZpbGUgY2hh
bmdlZCwgMTMgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmhvc3QvdmRw
YS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiBpbmRleCBhNTI3ZWVlYWM2MzcuLjM3NDc3Y2Zm
YTVhYSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+ICsrKyBiL2RyaXZlcnMv
dmhvc3QvdmRwYS5jCj4gQEAgLTgyMyw2ICs4MjMsMTggQEAgc3RhdGljIHZvaWQgdmhvc3RfdmRw
YV91bm1hcChzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPiAgIAkJdmhvc3RfdmRwYV9yZW1vdmVfYXMo
diwgYXNpZCk7Cj4gICB9Cj4gICAKPiArc3RhdGljIHZvaWQgdmhvc3RfdmRwYV9jbGVhbl9tYXAo
c3RydWN0IHZob3N0X3ZkcGEgKnYpCj4gK3sKPiArCXN0cnVjdCB2aG9zdF92ZHBhX2FzICphczsK
PiArCXUzMiBhc2lkOwo+ICsKPiArCWZvciAoYXNpZCA9IDA7IGFzaWQgPCB2LT52ZHBhLT5uYXM7
IGFzaWQrKykgewo+ICsJCWFzID0gYXNpZF90b19hcyh2LCBhc2lkKTsKPiArCQlpZiAoYXMpCj4g
KwkJCXZob3N0X3ZkcGFfdW5tYXAodiwgJmFzLT5pb3RsYiwgMFVMTCwgMFVMTCAtIDEpOwo+ICsJ
fQo+ICt9Cj4gKwo+ICAgc3RhdGljIGludCB2aG9zdF92ZHBhX3ZhX21hcChzdHJ1Y3Qgdmhvc3Rf
dmRwYSAqdiwKPiAgIAkJCSAgICAgc3RydWN0IHZob3N0X2lvdGxiICppb3RsYiwKPiAgIAkJCSAg
ICAgdTY0IGlvdmEsIHU2NCBzaXplLCB1NjQgdWFkZHIsIHUzMiBwZXJtKQo+IEBAIC0xMjQ3LDYg
KzEyNTksNyBAQCBzdGF0aWMgaW50IHZob3N0X3ZkcGFfcmVsZWFzZShzdHJ1Y3QgaW5vZGUgKmlu
b2RlLCBzdHJ1Y3QgZmlsZSAqZmlsZXApCj4gICAJdmhvc3RfdmRwYV9jbGVhbl9pcnEodik7Cj4g
ICAJdmhvc3RfdmRwYV9yZXNldCh2KTsKPiAgIAl2aG9zdF9kZXZfc3RvcCgmdi0+dmRldik7Cj4g
Kwl2aG9zdF92ZHBhX2NsZWFuX21hcCh2KTsKPiAgIAl2aG9zdF92ZHBhX2ZyZWVfZG9tYWluKHYp
Owo+ICAgCXZob3N0X3ZkcGFfY29uZmlnX3B1dCh2KTsKPiAgIAl2aG9zdF92ZHBhX2NsZWFudXAo
dik7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0
dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRh
dGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGlu
Zm8vdmlydHVhbGl6YXRpb24=
