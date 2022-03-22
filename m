Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 451F5C433EF
	for <virtualization@archiver.kernel.org>; Tue, 22 Mar 2022 05:49:31 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id D4ECC41687;
	Tue, 22 Mar 2022 05:49:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id SOVn3D0MERR4; Tue, 22 Mar 2022 05:49:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 6C66A41676;
	Tue, 22 Mar 2022 05:49:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5000EC0012;
	Tue, 22 Mar 2022 05:49:29 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A9DB4C000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 05:49:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 86676611A9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 05:49:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 09d0HgEjvymp
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 05:49:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 3F6D260B18
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 05:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647928166;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=etxApx5R59TQnIun32gQM35mhiP7Tm4INI19Xxd5f3E=;
 b=V6bo5p8VMasWk7B+kaoBIseYf3LcVlbEuJctCVIe+lsxnSUzUvDkHdKNU+mg/SQYtbMG9T
 RJznVooh1zB/rKsglDG8lrSaCbqAslXsvBq0rd0cyOC6txvFEoZjKtyow2Q5vM+6DHbcK/
 F/GdS6w7gSeRX/H3XgPRszefiOnOMfQ=
Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com
 [209.85.210.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-119-6u3tlomQO2uWpvz9s6rbGQ-1; Tue, 22 Mar 2022 01:49:24 -0400
X-MC-Unique: 6u3tlomQO2uWpvz9s6rbGQ-1
Received: by mail-pf1-f198.google.com with SMTP id
 i8-20020a056a00004800b004fa5a5ecc4bso796912pfk.16
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 22:49:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=etxApx5R59TQnIun32gQM35mhiP7Tm4INI19Xxd5f3E=;
 b=lCkJyx2MM9e703PczwfA8JuhZZ7y8pzOYK7zAYr4wjgQBaCR8Lqm/HkZAQ3VAT5Aue
 3ISj656hTSx2FZ+y2IiQVIYqjbCwb68iInK/bAAgPxVy0eLiZAku7aMd0Suh5ID838P1
 UNuPGUv+Xt6Iq5m3Ji2pOMWasd1RmHhJNgDf2CpJcegKGK01M7J93rVyQOPcGgt/ZnTv
 EDsmd0mtkwOvyobWd93ntIJPm5LbsV0EEo120wlNI56GzN54cWecVS4Im6tT47EuCffL
 LR11luG3vSvRFmyPfF+MKPYWWfx9kAqiOJSZ3BqNl82ZSO73zP571PA3kuUWAk9R5sFh
 b2Lw==
X-Gm-Message-State: AOAM531FRyo18zLOOV8HOOOt4XWJsxs0mz21D5RveJ71tOBJ3aOKaMaB
 2GCXP+hgprLK/bjNAXVAtHlQlz+iody7Y9nwVu7nciDRMDzQnNMZ6nh3tuvjzzHNWaWzb2Rrujc
 0f/DSyZ8+3reF1TPBooMTRqwppcxEHjOIQ9eQHhBY8w==
X-Received: by 2002:a17:902:d645:b0:153:abad:be7d with SMTP id
 y5-20020a170902d64500b00153abadbe7dmr16218316plh.118.1647928163635; 
 Mon, 21 Mar 2022 22:49:23 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz77XJYVMXNBjzo9VPu0VI8Dvo5FHK06mVTNrbyQZTURlv6nlG5+YdIQr4BprAQ3pC/DOlS3g==
X-Received: by 2002:a17:902:d645:b0:153:abad:be7d with SMTP id
 y5-20020a170902d64500b00153abadbe7dmr16218299plh.118.1647928163360; 
 Mon, 21 Mar 2022 22:49:23 -0700 (PDT)
Received: from [10.72.13.61] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 f30-20020a63755e000000b00381f6b7ef30sm15269020pgn.54.2022.03.21.22.49.21
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Mar 2022 22:49:22 -0700 (PDT)
Message-ID: <7e42401f-2873-0368-a6d2-365bcd5d0ebe@redhat.com>
Date: Tue, 22 Mar 2022 13:49:15 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v8 04/16] virtio_ring: remove the arg vq of
 vring_alloc_desc_extra()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220314093455.34707-1-xuanzhuo@linux.alibaba.com>
 <20220314093455.34707-5-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220314093455.34707-5-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>
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

CuWcqCAyMDIyLzMvMTQg5LiL5Y2INTozNCwgWHVhbiBaaHVvIOWGmemBkzoKPiBUaGUgcGFyYW1l
dGVyIHZxIG9mIHZyaW5nX2FsbG9jX2Rlc2NfZXh0cmEoKSBpcyB1c2VsZXNzLiBUaGlzIHBhdGNo
Cj4gcmVtb3ZlcyB0aGlzIHBhcmFtZXRlci4KPgo+IFN1YnNlcXVlbnQgcGF0Y2hlcyB3aWxsIGNh
bGwgdGhpcyBmdW5jdGlvbiB0byBhdm9pZCBwYXNzaW5nIHVzZWxlc3MKPiBhcmd1bWVudHMuCj4K
PiBTaWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgoK
CkFja2VkLWJ5OiBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKCj4gLS0tCj4gICBk
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgNyArKystLS0tCj4gICAxIGZpbGUgY2hhbmdl
ZCwgMyBpbnNlcnRpb25zKCspLCA0IGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4g
aW5kZXggZjE4MDdmNmIwNmE1Li5jYjYwMTA3NTBhOTQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMK
PiBAQCAtMTYzNiw4ICsxNjM2LDcgQEAgc3RhdGljIHZvaWQgKnZpcnRxdWV1ZV9kZXRhY2hfdW51
c2VkX2J1Zl9wYWNrZWQoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+ICAgCXJldHVybiBOVUxMOwo+
ICAgfQo+ICAgCj4gLXN0YXRpYyBzdHJ1Y3QgdnJpbmdfZGVzY19leHRyYSAqdnJpbmdfYWxsb2Nf
ZGVzY19leHRyYShzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSwKPiAtCQkJCQkJICAgICAgIHVu
c2lnbmVkIGludCBudW0pCj4gK3N0YXRpYyBzdHJ1Y3QgdnJpbmdfZGVzY19leHRyYSAqdnJpbmdf
YWxsb2NfZGVzY19leHRyYSh1bnNpZ25lZCBpbnQgbnVtKQo+ICAgewo+ICAgCXN0cnVjdCB2cmlu
Z19kZXNjX2V4dHJhICpkZXNjX2V4dHJhOwo+ICAgCXVuc2lnbmVkIGludCBpOwo+IEBAIC0xNzU1
LDcgKzE3NTQsNyBAQCBzdGF0aWMgc3RydWN0IHZpcnRxdWV1ZSAqdnJpbmdfY3JlYXRlX3ZpcnRx
dWV1ZV9wYWNrZWQoCj4gICAJLyogUHV0IGV2ZXJ5dGhpbmcgaW4gZnJlZSBsaXN0cy4gKi8KPiAg
IAl2cS0+ZnJlZV9oZWFkID0gMDsKPiAgIAo+IC0JdnEtPnBhY2tlZC5kZXNjX2V4dHJhID0gdnJp
bmdfYWxsb2NfZGVzY19leHRyYSh2cSwgbnVtKTsKPiArCXZxLT5wYWNrZWQuZGVzY19leHRyYSA9
IHZyaW5nX2FsbG9jX2Rlc2NfZXh0cmEobnVtKTsKPiAgIAlpZiAoIXZxLT5wYWNrZWQuZGVzY19l
eHRyYSkKPiAgIAkJZ290byBlcnJfZGVzY19leHRyYTsKPiAgIAo+IEBAIC0yMjMzLDcgKzIyMzIs
NyBAQCBzdHJ1Y3QgdmlydHF1ZXVlICpfX3ZyaW5nX25ld192aXJ0cXVldWUodW5zaWduZWQgaW50
IGluZGV4LAo+ICAgCWlmICghdnEtPnNwbGl0LmRlc2Nfc3RhdGUpCj4gICAJCWdvdG8gZXJyX3N0
YXRlOwo+ICAgCj4gLQl2cS0+c3BsaXQuZGVzY19leHRyYSA9IHZyaW5nX2FsbG9jX2Rlc2NfZXh0
cmEodnEsIHZyaW5nLm51bSk7Cj4gKwl2cS0+c3BsaXQuZGVzY19leHRyYSA9IHZyaW5nX2FsbG9j
X2Rlc2NfZXh0cmEodnJpbmcubnVtKTsKPiAgIAlpZiAoIXZxLT5zcGxpdC5kZXNjX2V4dHJhKQo+
ICAgCQlnb3RvIGVycl9leHRyYTsKPiAgIAoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0
aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0
aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
