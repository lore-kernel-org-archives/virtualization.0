Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 497E4C32774
	for <virtualization@archiver.kernel.org>; Thu, 25 Aug 2022 07:11:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id A4BD241578;
	Thu, 25 Aug 2022 07:11:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org A4BD241578
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=XjLkglLf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id y9urPt2sjDF6; Thu, 25 Aug 2022 07:11:19 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id D550C41809;
	Thu, 25 Aug 2022 07:11:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org D550C41809
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A2960C0033;
	Thu, 25 Aug 2022 07:11:18 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8B6F5C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 07:11:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6CAF28331B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 07:11:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6CAF28331B
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=XjLkglLf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id W8b5n17nT-zx
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 07:11:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org ABA0B83323
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id ABA0B83323
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 07:11:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1661411475;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=8hstYML2crFW9jfle1ivYRn1yE7n1hXLc4hnxMa+ms8=;
 b=XjLkglLfHZ5x8nYFwbWBstCfcMCtaMrjvI1exvLqQW1u8sUTKHnnSsxF88BznNp13mIjHZ
 zS6IgIVrdWx2tyfeQWudmNnrO+uX4Irj40OUM0ZDJJLeS25qNseh+Rfo/8CFGo/SYX/UCe
 Xpa8DzlUd/dxB8xis4qBVITWwOrfbiM=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-202-r28TXgzPN0KQDkGdUP5zEA-1; Thu, 25 Aug 2022 03:11:14 -0400
X-MC-Unique: r28TXgzPN0KQDkGdUP5zEA-1
Received: by mail-pf1-f198.google.com with SMTP id
 y17-20020aa79e11000000b00537a2142a68so99482pfq.13
 for <virtualization@lists.linux-foundation.org>;
 Thu, 25 Aug 2022 00:11:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:in-reply-to:from:references:cc:to
 :content-language:subject:user-agent:mime-version:date:message-id
 :x-gm-message-state:from:to:cc;
 bh=8hstYML2crFW9jfle1ivYRn1yE7n1hXLc4hnxMa+ms8=;
 b=w2tzXEfg1EB/phjO65wjSlFG09x6TI3cuZgnfmodi4FJN3USmfe7jaLgWie68Uc0KI
 0LW4DN60Dn+WDOVPsqS53eYiWBJuFzDZFrhRga2wsROyvc8tl59EPAr2AA9ucaFwP/4c
 0bwR9oBawo2gvSvcd4H2aifzuPtQnTJWDrmK9boxXhnqEX+cwV6GrxymyzA0DBhy50Oh
 xVnaOHkKF2Voi+Y9opKogjX54zOexZsstfqLC1LethfuenSSi6sOA0e+GY7Gnu96kle+
 0ch042zNgUi1qlf/MhOddjlB10wTnYPa2rk+oVPULlxNMxj6sBBVIs9gOHSwvpICa1hq
 cGDg==
X-Gm-Message-State: ACgBeo0JJW0TjqZ1G2rrP5ADenWE8tfWNXvlsGEH99ya4StJLhayaLl1
 pUgEuspClbOKPsrJCPioxGU+jaCB4hP9fmqvC1wSoFtlWDZ2CJAYZxPDs6rapP2tt0VjBtVVhrX
 nzLyjMr4G/DgZHNlmHpetbTBjmLkxayS8xh4CQVgxsA==
X-Received: by 2002:a17:90b:388a:b0:1fb:7dea:c31e with SMTP id
 mu10-20020a17090b388a00b001fb7deac31emr3196539pjb.162.1661411473476; 
 Thu, 25 Aug 2022 00:11:13 -0700 (PDT)
X-Google-Smtp-Source: AA6agR5CeHBniCJJchbK95vuG0eHIrILIUeqOvLvVnn+uoxSbeGyNwzgMkrqzzDmQjcA7tg+85ezFw==
X-Received: by 2002:a17:90b:388a:b0:1fb:7dea:c31e with SMTP id
 mu10-20020a17090b388a00b001fb7deac31emr3196513pjb.162.1661411473242; 
 Thu, 25 Aug 2022 00:11:13 -0700 (PDT)
Received: from [10.72.12.107] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 h20-20020aa796d4000000b0053671a241a5sm9059808pfq.191.2022.08.25.00.11.08
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 25 Aug 2022 00:11:12 -0700 (PDT)
Message-ID: <ac746502-e786-0290-821c-f576c6125efa@redhat.com>
Date: Thu, 25 Aug 2022 15:11:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [RFC v2 5/7] virtio: unmask F_NEXT flag in desc_extra
To: Guo Zhi <qtxuning1999@sjtu.edu.cn>, eperezma@redhat.com,
 sgarzare@redhat.com, mst@redhat.com
References: <20220817135718.2553-1-qtxuning1999@sjtu.edu.cn>
 <20220817135718.2553-6-qtxuning1999@sjtu.edu.cn>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220817135718.2553-6-qtxuning1999@sjtu.edu.cn>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
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

CuWcqCAyMDIyLzgvMTcgMjE6NTcsIEd1byBaaGkg5YaZ6YGTOgo+IFdlIGRpZG4ndCB1bm1hc2sg
Rl9ORVhUIGZsYWcgaW4gZGVzY19leHRyYSBpbiB0aGUgZW5kIG9mIGEgY2hhaW4sCj4gdW5tYXNr
IGl0IHNvIHRoYXQgd2UgY2FuIGFjY2VzcyBkZXNjX2V4dHJhIHRvIGdldCBuZXh0IGluZm9ybWF0
aW9uLgo+Cj4gU2lnbmVkLW9mZi1ieTogR3VvIFpoaSA8cXR4dW5pbmcxOTk5QHNqdHUuZWR1LmNu
PgoKCkkgcG9zdCBhIHNpbWlsYXIgcGF0Y2ggaW4gdGhlIHBhc3QuCgpQbGVhc2Ugc2hhcmUgdGhl
IHBlcmYgbnVtYmVycyAoZS5nIHBwcyB2aWEgcGt0Z2VuKS4KClRoYW5rcwoKCj4gLS0tCj4gICBk
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgNiArKysrLS0KPiAgIDEgZmlsZSBjaGFuZ2Vk
LCA0IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pCj4KPiBkaWZmIC0tZ2l0IGEvZHJpdmVy
cy92aXJ0aW8vdmlydGlvX3JpbmcuYyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBp
bmRleCBhNWVjNzI0YzAxZDguLjFjMWIzZmEzNzZhMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3Zp
cnRpby92aXJ0aW9fcmluZy5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+
IEBAIC01NjcsNyArNTY3LDcgQEAgc3RhdGljIGlubGluZSBpbnQgdmlydHF1ZXVlX2FkZF9zcGxp
dChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gICAJfQo+ICAgCS8qIExhc3Qgb25lIGRvZXNuJ3Qg
Y29udGludWUuICovCj4gICAJZGVzY1twcmV2XS5mbGFncyAmPSBjcHVfdG9fdmlydGlvMTYoX3Zx
LT52ZGV2LCB+VlJJTkdfREVTQ19GX05FWFQpOwo+IC0JaWYgKCFpbmRpcmVjdCAmJiB2cS0+dXNl
X2RtYV9hcGkpCj4gKwlpZiAoIWluZGlyZWN0KQo+ICAgCQl2cS0+c3BsaXQuZGVzY19leHRyYVtw
cmV2ICYgKHZxLT5zcGxpdC52cmluZy5udW0gLSAxKV0uZmxhZ3MgJj0KPiAgIAkJCX5WUklOR19E
RVNDX0ZfTkVYVDsKPiAgIAo+IEBAIC01ODQsNiArNTg0LDggQEAgc3RhdGljIGlubGluZSBpbnQg
dmlydHF1ZXVlX2FkZF9zcGxpdChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gICAJCQkJCSB0b3Rh
bF9zZyAqIHNpemVvZihzdHJ1Y3QgdnJpbmdfZGVzYyksCj4gICAJCQkJCSBWUklOR19ERVNDX0Zf
SU5ESVJFQ1QsCj4gICAJCQkJCSBmYWxzZSk7Cj4gKwkJdnEtPnNwbGl0LmRlc2NfZXh0cmFbaGVh
ZCAmICh2cS0+c3BsaXQudnJpbmcubnVtIC0gMSldLmZsYWdzICY9Cj4gKwkJCX5WUklOR19ERVND
X0ZfTkVYVDsKPiAgIAl9Cj4gICAKPiAgIAkvKiBXZSdyZSB1c2luZyBzb21lIGJ1ZmZlcnMgZnJv
bSB0aGUgZnJlZSBsaXN0LiAqLwo+IEBAIC02OTMsNyArNjk1LDcgQEAgc3RhdGljIHZvaWQgZGV0
YWNoX2J1Zl9zcGxpdChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwgdW5zaWduZWQgaW50IGhl
YWQsCj4gICAJLyogUHV0IGJhY2sgb24gZnJlZSBsaXN0OiB1bm1hcCBmaXJzdC1sZXZlbCBkZXNj
cmlwdG9ycyBhbmQgZmluZCBlbmQgKi8KPiAgIAlpID0gaGVhZDsKPiAgIAo+IC0Jd2hpbGUgKHZx
LT5zcGxpdC52cmluZy5kZXNjW2ldLmZsYWdzICYgbmV4dGZsYWcpIHsKPiArCXdoaWxlICh2cS0+
c3BsaXQuZGVzY19leHRyYVtpXS5mbGFncyAmIG5leHRmbGFnKSB7Cj4gICAJCXZyaW5nX3VubWFw
X29uZV9zcGxpdCh2cSwgaSk7Cj4gICAJCWkgPSB2cS0+c3BsaXQuZGVzY19leHRyYVtpXS5uZXh0
Owo+ICAgCQl2cS0+dnEubnVtX2ZyZWUrKzsKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
