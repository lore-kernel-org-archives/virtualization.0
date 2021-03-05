Return-Path: <SRS0=gmSK=ID=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88AEFC433E0
	for <virtualization@archiver.kernel.org>; Fri,  5 Mar 2021 08:37:27 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E5B8C65026
	for <virtualization@archiver.kernel.org>; Fri,  5 Mar 2021 08:37:26 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E5B8C65026
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 93F1C6F583;
	Fri,  5 Mar 2021 08:37:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id fet89oM21Wk7; Fri,  5 Mar 2021 08:37:25 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 2C9376F555;
	Fri,  5 Mar 2021 08:37:25 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0354AC000B;
	Fri,  5 Mar 2021 08:37:25 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4D536C0001
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 08:37:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 2C8EB4EC02
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 08:37:23 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 7ikaSmHH__5N
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 08:37:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E59B04631A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Mar 2021 08:37:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614933440;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5IxD+zRq/yhrLjAjbqOqe9sITek/cTcDBZYIQhAd6Ic=;
 b=dhrUG35pRcvD0ZKDCrt+OUn8oDkcIyyhwvtJqOZrLDqOoGcnK59ta9CERrvsK2tEtnzWfL
 9/tWXyUZjs2NQRz3vHWW7k2a1dvskzRGAbUTmBCkmRXe0H01Mw771MV8Rf/29WHTi3iY/E
 3criW4B0zfxQXHtOqNwIcGMrLlY+z80=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-pZLPSXGOMquqF-MT_oDg1Q-1; Fri, 05 Mar 2021 03:37:16 -0500
X-MC-Unique: pZLPSXGOMquqF-MT_oDg1Q-1
Received: by mail-ej1-f71.google.com with SMTP id sa29so549287ejb.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 05 Mar 2021 00:37:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=5IxD+zRq/yhrLjAjbqOqe9sITek/cTcDBZYIQhAd6Ic=;
 b=bTtFNotULrT8/vZc6NgXn7ib2ErDPTx9otZecHydZ5rZoOFB+C0iwLMZqPUuQLqFS5
 Pcr55NyoKeSH+F+prVeCKGf/LpSaJnZ/afCOz72HBsHG0KYrRTat1Kp4ihpYKbcsIx1m
 t9S+gHaXmtKRDlwg81UxKf4XvXRStk6II+SKCNVeIxNLZ2wPidXZxxOELtpEuQsf9Lwf
 ECRWC6SzaW6KJm6W51YcJNlmF9uNiH5tBCM4VVFccSjhwWM/Xtnqg89t3+/Bt6X6pTu8
 XpyHDWRXUUeaQ9AcGrne+wVF4vjIGibn8+XBOPYiRGqscRuEvfMi6WBLozI//UNcZ5if
 OiRg==
X-Gm-Message-State: AOAM530krqOHvwc8DSX/Ge10b7y388y7EQrpSOgwEDxIZLUPG1Rov/uz
 qZJFSdNulKtOqjnfcT9nJgEkauTZSISJwryxM82Qg8A8YpXvmt1pMawM99ZUmeIYxdD70fEpsIH
 s0QM0GpXFki29AdG0RBR97yYKW6lipZGE6FDJLhaUNw==
X-Received: by 2002:aa7:d316:: with SMTP id p22mr7803925edq.107.1614933435326; 
 Fri, 05 Mar 2021 00:37:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyjOmXvN8EMZ0rcYtj7qz24OPE/oP+k8nHqB8bmBISFKPKisJaNW2VnaxRq7If6mLdWgTCHeg==
X-Received: by 2002:aa7:d316:: with SMTP id p22mr7803915edq.107.1614933435181; 
 Fri, 05 Mar 2021 00:37:15 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id si7sm1078074ejb.84.2021.03.05.00.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Mar 2021 00:37:14 -0800 (PST)
Date: Fri, 5 Mar 2021 09:37:12 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [RFC PATCH 10/10] vhost/vdpa: return configuration bytes read
 and written to user space
Message-ID: <20210305083712.atfrlpq6bkjrf6pd@steredhat>
References: <20210216094454.82106-1-sgarzare@redhat.com>
 <20210216094454.82106-11-sgarzare@redhat.com>
 <4d682ff2-9663-d6ac-d5bf-616b2bf96e1a@redhat.com>
 <20210302140654.ybmjqui5snp5wxym@steredhat>
 <5cf852b1-1279-20e9-516d-30f876e0162d@redhat.com>
MIME-Version: 1.0
In-Reply-To: <5cf852b1-1279-20e9-516d-30f876e0162d@redhat.com>
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

T24gVGh1LCBNYXIgMDQsIDIwMjEgYXQgMDQ6MzE6MjJQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMS8zLzIgMTA6MDYg5LiL5Y2ILCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6
Cj4+T24gVHVlLCBNYXIgMDIsIDIwMjEgYXQgMTI6MDU6MzVQTSArMDgwMCwgSmFzb24gV2FuZyB3
cm90ZToKPj4+Cj4+Pk9uIDIwMjEvMi8xNiA1OjQ0IOS4i+WNiCwgU3RlZmFubyBHYXJ6YXJlbGxh
IHdyb3RlOgo+Pj4+dmRwYV9nZXRfY29uZmlnKCkgYW5kIHZkcGFfc2V0X2NvbmZpZygpIG5vdyBy
ZXR1cm4gdGhlIGFtb3VudAo+Pj4+b2YgYnl0ZXMgcmVhZCBhbmQgd3JpdHRlbiwgc28gbGV0J3Mg
cmV0dXJuIHRoZW0gdG8gdGhlIHVzZXIgc3BhY2UuCj4+Pj4KPj4+PldlIGFsc28gbW9kaWZ5IHZo
b3N0X3ZkcGFfY29uZmlnX3ZhbGlkYXRlKCkgdG8gcmV0dXJuIDAgKGJ5dGVzIHJlYWQKPj4+Pm9y
IHdyaXR0ZW4pIGluc3RlYWQgb2YgYW4gZXJyb3IsIHdoZW4gdGhlIGJ1ZmZlciBsZW5ndGggaXMg
MC4KPj4+Pgo+Pj4+U2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUBy
ZWRoYXQuY29tPgo+Pj4+LS0tCj4+Pj7CoGRyaXZlcnMvdmhvc3QvdmRwYS5jIHwgMjYgKysrKysr
KysrKysrKysrLS0tLS0tLS0tLS0KPj4+PsKgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMo
KyksIDExIGRlbGV0aW9ucygtKQo+Pj4+Cj4+Pj5kaWZmIC0tZ2l0IGEvZHJpdmVycy92aG9zdC92
ZHBhLmMgYi9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4+aW5kZXggMjFlZWEyYmU1YWZhLi5iNzU0
YzUzMTcxYTcgMTAwNjQ0Cj4+Pj4tLS0gYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYwo+Pj4+KysrIGIv
ZHJpdmVycy92aG9zdC92ZHBhLmMKPj4+PkBAIC0xOTEsOSArMTkxLDYgQEAgc3RhdGljIHNzaXpl
X3QgCj4+Pj52aG9zdF92ZHBhX2NvbmZpZ192YWxpZGF0ZShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwK
Pj4+PsKgwqDCoMKgIHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYSA9IHYtPnZkcGE7Cj4+Pj7CoMKg
wqDCoCB1MzIgc2l6ZSA9IHZkcGEtPmNvbmZpZy0+Z2V0X2NvbmZpZ19zaXplKHZkcGEpOwo+Pj4+
LcKgwqDCoCBpZiAoYy0+bGVuID09IDApCj4+Pj4twqDCoMKgwqDCoMKgwqAgcmV0dXJuIC1FSU5W
QUw7Cj4+Pj4tCj4+Pj7CoMKgwqDCoCByZXR1cm4gbWluKGMtPmxlbiwgc2l6ZSk7Cj4+Pj7CoH0K
Pj4+PkBAIC0yMDQsNiArMjAxLDcgQEAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV9nZXRfY29uZmln
KHN0cnVjdCAKPj4+PnZob3N0X3ZkcGEgKnYsCj4+Pj7CoMKgwqDCoCBzdHJ1Y3Qgdmhvc3RfdmRw
YV9jb25maWcgY29uZmlnOwo+Pj4+wqDCoMKgwqAgdW5zaWduZWQgbG9uZyBzaXplID0gb2Zmc2V0
b2Yoc3RydWN0IHZob3N0X3ZkcGFfY29uZmlnLCBidWYpOwo+Pj4+wqDCoMKgwqAgc3NpemVfdCBj
b25maWdfc2l6ZTsKPj4+PivCoMKgwqAgbG9uZyByZXQ7Cj4+Pj7CoMKgwqDCoCB1OCAqYnVmOwo+
Pj4+wqDCoMKgwqAgaWYgKGNvcHlfZnJvbV91c2VyKCZjb25maWcsIGMsIHNpemUpKQo+Pj4+QEAg
LTIxNywxNSArMjE1LDE4IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfZ2V0X2NvbmZpZyhzdHJ1
Y3QgCj4+Pj52aG9zdF92ZHBhICp2LAo+Pj4+wqDCoMKgwqAgaWYgKCFidWYpCj4+Pj7CoMKgwqDC
oMKgwqDCoMKgIHJldHVybiAtRU5PTUVNOwo+Pj4+LcKgwqDCoCB2ZHBhX2dldF9jb25maWcodmRw
YSwgY29uZmlnLm9mZiwgYnVmLCBjb25maWdfc2l6ZSk7Cj4+Pj4tCj4+Pj4twqDCoMKgIGlmIChj
b3B5X3RvX3VzZXIoYy0+YnVmLCBidWYsIGNvbmZpZ19zaXplKSkgewo+Pj4+LcKgwqDCoMKgwqDC
oMKgIGt2ZnJlZShidWYpOwo+Pj4+LcKgwqDCoMKgwqDCoMKgIHJldHVybiAtRUZBVUxUOwo+Pj4+
K8KgwqDCoCByZXQgPSB2ZHBhX2dldF9jb25maWcodmRwYSwgY29uZmlnLm9mZiwgYnVmLCBjb25m
aWdfc2l6ZSk7Cj4+Pj4rwqDCoMKgIGlmIChyZXQgPCAwKSB7Cj4+Pj4rwqDCoMKgwqDCoMKgwqAg
cmV0ID0gLUVGQVVMVDsKPj4+PivCoMKgwqDCoMKgwqDCoCBnb3RvIG91dDsKPj4+PsKgwqDCoMKg
IH0KPj4+PivCoMKgwqAgaWYgKGNvcHlfdG9fdXNlcihjLT5idWYsIGJ1ZiwgY29uZmlnX3NpemUp
KQo+Pj4+K8KgwqDCoMKgwqDCoMKgIHJldCA9IC1FRkFVTFQ7Cj4+Pj4rCj4+Pj4rb3V0Ogo+Pj4+
wqDCoMKgwqAga3ZmcmVlKGJ1Zik7Cj4+Pj4twqDCoMKgIHJldHVybiAwOwo+Pj4+K8KgwqDCoCBy
ZXR1cm4gcmV0Owo+Pj4+wqB9Cj4+Pj7CoHN0YXRpYyBsb25nIHZob3N0X3ZkcGFfc2V0X2NvbmZp
ZyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPj4+PkBAIC0yMzUsNiArMjM2LDcgQEAgc3RhdGljIGxv
bmcgdmhvc3RfdmRwYV9zZXRfY29uZmlnKHN0cnVjdCAKPj4+PnZob3N0X3ZkcGEgKnYsCj4+Pj7C
oMKgwqDCoCBzdHJ1Y3Qgdmhvc3RfdmRwYV9jb25maWcgY29uZmlnOwo+Pj4+wqDCoMKgwqAgdW5z
aWduZWQgbG9uZyBzaXplID0gb2Zmc2V0b2Yoc3RydWN0IHZob3N0X3ZkcGFfY29uZmlnLCBidWYp
Owo+Pj4+wqDCoMKgwqAgc3NpemVfdCBjb25maWdfc2l6ZTsKPj4+PivCoMKgwqAgbG9uZyByZXQ7
Cj4+Pj7CoMKgwqDCoCB1OCAqYnVmOwo+Pj4+wqDCoMKgwqAgaWYgKGNvcHlfZnJvbV91c2VyKCZj
b25maWcsIGMsIHNpemUpKQo+Pj4+QEAgLTI0OCwxMCArMjUwLDEyIEBAIHN0YXRpYyBsb25nIHZo
b3N0X3ZkcGFfc2V0X2NvbmZpZyhzdHJ1Y3QgCj4+Pj52aG9zdF92ZHBhICp2LAo+Pj4+wqDCoMKg
wqAgaWYgKElTX0VSUihidWYpKQo+Pj4+wqDCoMKgwqDCoMKgwqDCoCByZXR1cm4gUFRSX0VSUihi
dWYpOwo+Pj4+LcKgwqDCoCB2ZHBhX3NldF9jb25maWcodmRwYSwgY29uZmlnLm9mZiwgYnVmLCBj
b25maWdfc2l6ZSk7Cj4+Pj4rwqDCoMKgIHJldCA9IHZkcGFfc2V0X2NvbmZpZyh2ZHBhLCBjb25m
aWcub2ZmLCBidWYsIGNvbmZpZ19zaXplKTsKPj4+PivCoMKgwqAgaWYgKHJldCA8IDApCj4+Pj4r
wqDCoMKgwqDCoMKgwqAgcmV0ID0gLUVGQVVMVDsKPj4+PsKgwqDCoMKgIGt2ZnJlZShidWYpOwo+
Pj4+LcKgwqDCoCByZXR1cm4gMDsKPj4+PivCoMKgwqAgcmV0dXJuIHJldDsKPj4+PsKgfQo+Pj4K
Pj4+Cj4+PlNvIEkgd29uZGVyIHdoZXRoZXIgaXQncyB3b3J0aCB0byByZXR1cm4gdGhlIG51bWJl
ciBvZiBieXRlcyBzaW5jZSAKPj4+d2UgY2FuJ3QgcHJvcG9nYXRlIHRoZSByZXN1bHQgdG8gZHJp
dmVyIG9yIGRyaXZlciBkb2Vzbid0IGNhcmUgCj4+PmFib3V0IHRoYXQuCj4+Cj4+T2theSwgYnV0
IElJVUMgdXNlciBzcGFjZSBhcHBsaWNhdGlvbiB0aGF0IGlzc3VlIAo+PlZIT1NUX1ZEUEFfR0VU
X0NPTkZJRyBpb2N0bCBjYW4gdXNlIHRoZSByZXR1cm4gdmFsdWUuCj4KPgo+WWVzLCBidXQgaXQg
bG9va3MgdG8gaXQncyB0b28gbGF0ZSB0byBjaGFuZ2Ugc2luY2UgaXQncyBhIHVzZXJzcGFjZSAK
Pm5vdGljYmxlIGJlaGF2aW91ci4KClllYWgsIHRoaXMgaXMgYSBnb29kIHBvaW50LgpJIGxvb2tl
ZCBhdCBRRU1VIGFuZCB3ZSBvbmx5IGNoZWNrIGlmIHRoZSB2YWx1ZSBpcyBub3QgbmVnYXRpdmUs
IHNvIGl0IApzaG91bGQgd29yaywgYnV0IGZvciBvdGhlciBhcHBsaWNhdGlvbnMgaXQgY291bGQg
YmUgYSByZWFsIGNoYW5nZS4KCkRvIHdlIGxlYXZlIGl0IGFzIGlzPwoKPgo+Cj4+Cj4+U2hvdWxk
IHdlIGNoYW5nZSBhbHNvICdzdHJ1Y3QgdmlydGlvX2NvbmZpZ19vcHMnIHRvIHByb3BhZ2F0ZSB0
aGlzIAo+PnZhbHVlIGFsc28gdG8gdmlydGlvIGRyaXZlcnM/Cj4KPgo+SSB0aGluayBub3QsIHRo
ZSByZWFzb24gaXMgdGhlIGRyaXZlciBkb2Vzbid0IGV4cGVjdCB0aGUgZ2V0KCkvc2V0KCkgCj5j
YW4gZmFpbC4uLgoKR290IGl0LgoKVGhhbmtzLApTdGVmYW5vCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
