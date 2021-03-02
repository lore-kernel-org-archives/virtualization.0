Return-Path: <SRS0=LnXi=IA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5AA4CC433E0
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 14:07:10 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C30C964EF0
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 14:07:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C30C964EF0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 7F6FD4318C;
	Tue,  2 Mar 2021 14:07:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SFnOQoZMixjw; Tue,  2 Mar 2021 14:07:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 2EF8B43166;
	Tue,  2 Mar 2021 14:07:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F2ED8C000B;
	Tue,  2 Mar 2021 14:07:07 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 61229C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 14:07:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 42205605A5
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 14:07:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0Z0F5BW0oXsa
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 14:07:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 075EA605A0
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 14:07:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614694024;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9ZZPA/RjfCV3cwHtIqxM2nNGL0XO9fFuMgdZl9YFKtA=;
 b=fk3rqiNLQSIXq/PWxvVjIpnhdyv1GM3Qe05QhQZTR6YlfxhcH6yRrEbsSkufWdJftTwWQZ
 oXXOHOECsa5z3+r4taxcVJd5Q9/l/lc7ioRuMGWp7nHHxEUYOkDUjF6Bf+A1fyBN3zQtwn
 IDRqwCyt6t9bltozixl81cPJTh5XMFA=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-497-7T9kBXI3M26Sep6pUJ9L9Q-1; Tue, 02 Mar 2021 09:06:59 -0500
X-MC-Unique: 7T9kBXI3M26Sep6pUJ9L9Q-1
Received: by mail-wm1-f71.google.com with SMTP id b62so1232753wmc.5
 for <virtualization@lists.linux-foundation.org>;
 Tue, 02 Mar 2021 06:06:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=9ZZPA/RjfCV3cwHtIqxM2nNGL0XO9fFuMgdZl9YFKtA=;
 b=tvOGifXNvBB8+osbBpMYlv7e8+u7+HNTlEgWBTo+Dil0TPSiJVfhcD2wiBILjHWiiF
 ejdxHZcKI5hL3p6pULMoSVBU2uLVLAE/VhEkyidNZPjWXpLzap9Oe310Y8cxJjcC/CMi
 d1O5opMBJwF/H3BJzRnRixmeRMC7eI7C5xqQdcPpiREToY255giOJuz4Fn2Jn24xpCnk
 B4n/8eHX9cJolcqhYbEOExrwUnzMiXyiFhB8t5vOiimzWtSv0YNJGLR0I3RQttuuWD7J
 aoums6fOvAJaFigdFAmsrorXh1vYji7E7Yt9laRHJYnSfPTvqRKAALafbDt1H9Wt30bz
 Ks/w==
X-Gm-Message-State: AOAM5335kVWVxsRxhOqhtGVJMFUe+GW3nK/rqlScI9L49uUpyBslmCmX
 S9xIKM7jvviUoBoi842aP3hJrhuvz1YUgRbdqyI1xj9zbUbNEF6DTwfX8SPhEYLFoMX9CPDbYTk
 S5Km8Edf4L9Nwo73ufhcEADyVZNbw9kvdMEECxabgTQ==
X-Received: by 2002:adf:e603:: with SMTP id p3mr19332954wrm.360.1614694017990; 
 Tue, 02 Mar 2021 06:06:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxPGvxaY2j2NNhchVLownsWlN5RsZOvtKftuEEVsTkK4Mn+YSpvgBcb/lnrmcwYWFG9dj3inA==
X-Received: by 2002:adf:e603:: with SMTP id p3mr19332896wrm.360.1614694017534; 
 Tue, 02 Mar 2021 06:06:57 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id o20sm745021wmq.5.2021.03.02.06.06.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Mar 2021 06:06:57 -0800 (PST)
Date: Tue, 2 Mar 2021 15:06:54 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH 10/10] vhost/vdpa: return configuration bytes read
 and written to user space
Message-ID: <20210302140654.ybmjqui5snp5wxym@steredhat>
References: <20210216094454.82106-1-sgarzare@redhat.com>
 <20210216094454.82106-11-sgarzare@redhat.com>
 <4d682ff2-9663-d6ac-d5bf-616b2bf96e1a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <4d682ff2-9663-d6ac-d5bf-616b2bf96e1a@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
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

T24gVHVlLCBNYXIgMDIsIDIwMjEgYXQgMTI6MDU6MzVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMS8yLzE2IDU6NDQg5LiL5Y2ILCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6
Cj4+dmRwYV9nZXRfY29uZmlnKCkgYW5kIHZkcGFfc2V0X2NvbmZpZygpIG5vdyByZXR1cm4gdGhl
IGFtb3VudAo+Pm9mIGJ5dGVzIHJlYWQgYW5kIHdyaXR0ZW4sIHNvIGxldCdzIHJldHVybiB0aGVt
IHRvIHRoZSB1c2VyIHNwYWNlLgo+Pgo+PldlIGFsc28gbW9kaWZ5IHZob3N0X3ZkcGFfY29uZmln
X3ZhbGlkYXRlKCkgdG8gcmV0dXJuIDAgKGJ5dGVzIHJlYWQKPj5vciB3cml0dGVuKSBpbnN0ZWFk
IG9mIGFuIGVycm9yLCB3aGVuIHRoZSBidWZmZXIgbGVuZ3RoIGlzIDAuCj4+Cj4+U2lnbmVkLW9m
Zi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgo+Pi0tLQo+PiAg
ZHJpdmVycy92aG9zdC92ZHBhLmMgfCAyNiArKysrKysrKysrKysrKystLS0tLS0tLS0tLQo+PiAg
MSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDExIGRlbGV0aW9ucygtKQo+Pgo+PmRp
ZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+
aW5kZXggMjFlZWEyYmU1YWZhLi5iNzU0YzUzMTcxYTcgMTAwNjQ0Cj4+LS0tIGEvZHJpdmVycy92
aG9zdC92ZHBhLmMKPj4rKysgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+PkBAIC0xOTEsOSArMTkx
LDYgQEAgc3RhdGljIHNzaXplX3Qgdmhvc3RfdmRwYV9jb25maWdfdmFsaWRhdGUoc3RydWN0IHZo
b3N0X3ZkcGEgKnYsCj4+ICAJc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhID0gdi0+dmRwYTsKPj4g
IAl1MzIgc2l6ZSA9IHZkcGEtPmNvbmZpZy0+Z2V0X2NvbmZpZ19zaXplKHZkcGEpOwo+Pi0JaWYg
KGMtPmxlbiA9PSAwKQo+Pi0JCXJldHVybiAtRUlOVkFMOwo+Pi0KPj4gIAlyZXR1cm4gbWluKGMt
Pmxlbiwgc2l6ZSk7Cj4+ICB9Cj4+QEAgLTIwNCw2ICsyMDEsNyBAQCBzdGF0aWMgbG9uZyB2aG9z
dF92ZHBhX2dldF9jb25maWcoc3RydWN0IHZob3N0X3ZkcGEgKnYsCj4+ICAJc3RydWN0IHZob3N0
X3ZkcGFfY29uZmlnIGNvbmZpZzsKPj4gIAl1bnNpZ25lZCBsb25nIHNpemUgPSBvZmZzZXRvZihz
dHJ1Y3Qgdmhvc3RfdmRwYV9jb25maWcsIGJ1Zik7Cj4+ICAJc3NpemVfdCBjb25maWdfc2l6ZTsK
Pj4rCWxvbmcgcmV0Owo+PiAgCXU4ICpidWY7Cj4+ICAJaWYgKGNvcHlfZnJvbV91c2VyKCZjb25m
aWcsIGMsIHNpemUpKQo+PkBAIC0yMTcsMTUgKzIxNSwxOCBAQCBzdGF0aWMgbG9uZyB2aG9zdF92
ZHBhX2dldF9jb25maWcoc3RydWN0IHZob3N0X3ZkcGEgKnYsCj4+ICAJaWYgKCFidWYpCj4+ICAJ
CXJldHVybiAtRU5PTUVNOwo+Pi0JdmRwYV9nZXRfY29uZmlnKHZkcGEsIGNvbmZpZy5vZmYsIGJ1
ZiwgY29uZmlnX3NpemUpOwo+Pi0KPj4tCWlmIChjb3B5X3RvX3VzZXIoYy0+YnVmLCBidWYsIGNv
bmZpZ19zaXplKSkgewo+Pi0JCWt2ZnJlZShidWYpOwo+Pi0JCXJldHVybiAtRUZBVUxUOwo+PisJ
cmV0ID0gdmRwYV9nZXRfY29uZmlnKHZkcGEsIGNvbmZpZy5vZmYsIGJ1ZiwgY29uZmlnX3NpemUp
Owo+PisJaWYgKHJldCA8IDApIHsKPj4rCQlyZXQgPSAtRUZBVUxUOwo+PisJCWdvdG8gb3V0Owo+
PiAgCX0KPj4rCWlmIChjb3B5X3RvX3VzZXIoYy0+YnVmLCBidWYsIGNvbmZpZ19zaXplKSkKPj4r
CQlyZXQgPSAtRUZBVUxUOwo+PisKPj4rb3V0Ogo+PiAgCWt2ZnJlZShidWYpOwo+Pi0JcmV0dXJu
IDA7Cj4+KwlyZXR1cm4gcmV0Owo+PiAgfQo+PiAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV9zZXRf
Y29uZmlnKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+PkBAIC0yMzUsNiArMjM2LDcgQEAgc3RhdGlj
IGxvbmcgdmhvc3RfdmRwYV9zZXRfY29uZmlnKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+PiAgCXN0
cnVjdCB2aG9zdF92ZHBhX2NvbmZpZyBjb25maWc7Cj4+ICAJdW5zaWduZWQgbG9uZyBzaXplID0g
b2Zmc2V0b2Yoc3RydWN0IHZob3N0X3ZkcGFfY29uZmlnLCBidWYpOwo+PiAgCXNzaXplX3QgY29u
ZmlnX3NpemU7Cj4+Kwlsb25nIHJldDsKPj4gIAl1OCAqYnVmOwo+PiAgCWlmIChjb3B5X2Zyb21f
dXNlcigmY29uZmlnLCBjLCBzaXplKSkKPj5AQCAtMjQ4LDEwICsyNTAsMTIgQEAgc3RhdGljIGxv
bmcgdmhvc3RfdmRwYV9zZXRfY29uZmlnKHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+PiAgCWlmIChJ
U19FUlIoYnVmKSkKPj4gIAkJcmV0dXJuIFBUUl9FUlIoYnVmKTsKPj4tCXZkcGFfc2V0X2NvbmZp
Zyh2ZHBhLCBjb25maWcub2ZmLCBidWYsIGNvbmZpZ19zaXplKTsKPj4rCXJldCA9IHZkcGFfc2V0
X2NvbmZpZyh2ZHBhLCBjb25maWcub2ZmLCBidWYsIGNvbmZpZ19zaXplKTsKPj4rCWlmIChyZXQg
PCAwKQo+PisJCXJldCA9IC1FRkFVTFQ7Cj4+ICAJa3ZmcmVlKGJ1Zik7Cj4+LQlyZXR1cm4gMDsK
Pj4rCXJldHVybiByZXQ7Cj4+ICB9Cj4KPgo+U28gSSB3b25kZXIgd2hldGhlciBpdCdzIHdvcnRo
IHRvIHJldHVybiB0aGUgbnVtYmVyIG9mIGJ5dGVzIHNpbmNlIHdlIAo+Y2FuJ3QgcHJvcG9nYXRl
IHRoZSByZXN1bHQgdG8gZHJpdmVyIG9yIGRyaXZlciBkb2Vzbid0IGNhcmUgYWJvdXQgCj50aGF0
LgoKT2theSwgYnV0IElJVUMgdXNlciBzcGFjZSBhcHBsaWNhdGlvbiB0aGF0IGlzc3VlIFZIT1NU
X1ZEUEFfR0VUX0NPTkZJRyAKaW9jdGwgY2FuIHVzZSB0aGUgcmV0dXJuIHZhbHVlLgoKU2hvdWxk
IHdlIGNoYW5nZSBhbHNvICdzdHJ1Y3QgdmlydGlvX2NvbmZpZ19vcHMnIHRvIHByb3BhZ2F0ZSB0
aGlzIHZhbHVlIAphbHNvIHRvIHZpcnRpbyBkcml2ZXJzPwoKVGhhbmtzLApTdGVmYW5vCgpfX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlv
biBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcK
aHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVh
bGl6YXRpb24=
