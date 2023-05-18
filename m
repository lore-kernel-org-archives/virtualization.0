Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D23D6C7EE24
	for <virtualization@archiver.kernel.org>; Thu, 18 May 2023 06:52:09 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 60A6C61409;
	Thu, 18 May 2023 06:52:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 60A6C61409
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=YGIPl0bU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Qrg_x4lyQLfk; Thu, 18 May 2023 06:52:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 0748060E79;
	Thu, 18 May 2023 06:52:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0748060E79
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E358BC0036;
	Thu, 18 May 2023 06:52:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 36BF3C002A
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 06:52:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 10D6A40A01
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 06:52:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 10D6A40A01
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=YGIPl0bU
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id zQcUpqKHrKAL
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 06:52:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E7FA641CE7
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id E7FA641CE7
 for <virtualization@lists.linux-foundation.org>;
 Thu, 18 May 2023 06:52:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1684392723;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yrVBjTA+6KSa6zkT4004suXVyMuP8hh/beinixnvT24=;
 b=YGIPl0bUqih2hqcdGZt2iWIV88dx0B7kY7NYprSJldz0fdwC1lAYPz42IiIyD+phfODQfS
 thipe44A3iSkYAvg1KY6ALUR7qNSv9vZeQQsYsRMUTZxR4gzobrrPMEP55Cld9VWhTKQGe
 S76ZiYfyEk8sZPLeBZTIlxdxQt4PLlY=
Received: from mail-lj1-f198.google.com (mail-lj1-f198.google.com
 [209.85.208.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-344-P_EDEcUdMeqQjN9tMvDmhA-1; Thu, 18 May 2023 02:52:02 -0400
X-MC-Unique: P_EDEcUdMeqQjN9tMvDmhA-1
Received: by mail-lj1-f198.google.com with SMTP id
 38308e7fff4ca-2ad94975f9dso8565851fa.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 17 May 2023 23:52:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1684392720; x=1686984720;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yrVBjTA+6KSa6zkT4004suXVyMuP8hh/beinixnvT24=;
 b=iWSWLeCdPLXwpNVSi7krSA1HAPI3VjJFxh1oot9y4eOpXOxFwaYZJW9Nazbd/8sdnU
 mRdRhFX6R+I4gB/DR7GWt28YoX8vn+gDAYr+Oi0q5LwVOrZXL3plybOVzf/tK/RLXaWw
 YrNtHkZSNmO8bU+cqemueUMWtyHhbPO+7BblQDnkFid1+GOPdUGj/2ROwkz+/x1Dh76k
 6TdLmT+Yto7SqQ5q6hT/mG8gvp6iCbBq3WlYMc3Ott6v2DAol0sZAnGhCgAYVS3W4oMR
 7DcbrYReZ4VrCo16r5xdX2H/RJwjz8mY0DkYGc1IAO8VyFj/cfGJ0D8vt6i1Mu3CdAe0
 Mg4Q==
X-Gm-Message-State: AC+VfDwMREqsLS3XM9rolbFQSJljlCzNf+pI8z23k3Bkl9RmVTkSiaIw
 7AtO1V/YCIa07KLtjsPJL5FJ95JilACRR2NalahEItmgn48PRML4AU73coQeCVj2tMTAm6BUCqy
 Q9y/VAFglhTr3IVBNMP0WeoRNlq9fDVGov9XQcyx4T4mLxaxxiG07AeQUT5FapnV7OwKV
X-Received: by 2002:a2e:9053:0:b0:2a8:bf74:61cc with SMTP id
 n19-20020a2e9053000000b002a8bf7461ccmr10770785ljg.26.1684392720319; 
 Wed, 17 May 2023 23:52:00 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ58zr4+OTxZsdxMDKmPbuMPoPVpAQC3aiIomsIVkgsBltPdDp6T5z/SwyIHMT3CfTUxWnxX3q7OSr6MzmE4p7w=
X-Received: by 2002:a2e:9053:0:b0:2a8:bf74:61cc with SMTP id
 n19-20020a2e9053000000b002a8bf7461ccmr10770778ljg.26.1684392720133; Wed, 17
 May 2023 23:52:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230517022249.20790-1-xuanzhuo@linux.alibaba.com>
 <20230517022249.20790-4-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230517022249.20790-4-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 18 May 2023 14:51:48 +0800
Message-ID: <CACGkMEswhDK8sXuhKPZ=Z95_-xbsKOfpe-eWwCgqr9vNvRVpdQ@mail.gmail.com>
Subject: Re: [PATCH vhost v9 03/12] virtio_ring: check use_dma_api before
 unmap desc for indirect
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Christoph Hellwig <hch@infradead.org>,
 "Michael S. Tsirkin" <mst@redhat.com>,
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

T24gV2VkLCBNYXkgMTcsIDIwMjMgYXQgMTA6MjPigK9BTSBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IEluc2lkZSBkZXRhY2hfYnVmX3NwbGl0KCksIGlm
IHVzZV9kbWFfYXBpIGlzIGZhbHNlLAo+IHZyaW5nX3VubWFwX29uZV9zcGxpdF9pbmRpcmVjdCB3
aWxsIGJlIGNhbGxlZCBtYW55IHRpbWVzLCBidXQgYWN0dWFsbHkKPiBub3RoaW5nIGlzIGRvbmUu
IFNvIHRoaXMgcGF0Y2ggY2hlY2sgdXNlX2RtYV9hcGkgZmlyc3RseS4KPgo+IFNpZ25lZC1vZmYt
Ynk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+CgpBY2tlZC1ieTogSmFz
b24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KClRoYW5rcwoKCj4gLS0tCj4gIGRyaXZlcnMv
dmlydGlvL3ZpcnRpb19yaW5nLmMgfCA2ICsrKystLQo+ICAxIGZpbGUgY2hhbmdlZCwgNCBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5kZXggNDc5
MjAzMzQ2YzM2Li4xZmZhYjFlYjQwYzAgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmly
dGlvX3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAtNzgz
LDggKzc4MywxMCBAQCBzdGF0aWMgdm9pZCBkZXRhY2hfYnVmX3NwbGl0KHN0cnVjdCB2cmluZ192
aXJ0cXVldWUgKnZxLCB1bnNpZ25lZCBpbnQgaGVhZCwKPiAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFZSSU5HX0RFU0NfRl9JTkRJUkVDVCkpOwo+ICAgICAgICAgICAgICAgICBCVUdf
T04obGVuID09IDAgfHwgbGVuICUgc2l6ZW9mKHN0cnVjdCB2cmluZ19kZXNjKSk7Cj4KPiAtICAg
ICAgICAgICAgICAgZm9yIChqID0gMDsgaiA8IGxlbiAvIHNpemVvZihzdHJ1Y3QgdnJpbmdfZGVz
Yyk7IGorKykKPiAtICAgICAgICAgICAgICAgICAgICAgICB2cmluZ191bm1hcF9vbmVfc3BsaXRf
aW5kaXJlY3QodnEsICZpbmRpcl9kZXNjW2pdKTsKPiArICAgICAgICAgICAgICAgaWYgKHZxLT51
c2VfZG1hX2FwaSkgewo+ICsgICAgICAgICAgICAgICAgICAgICAgIGZvciAoaiA9IDA7IGogPCBs
ZW4gLyBzaXplb2Yoc3RydWN0IHZyaW5nX2Rlc2MpOyBqKyspCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICB2cmluZ191bm1hcF9vbmVfc3BsaXRfaW5kaXJlY3QodnEsICZpbmRpcl9k
ZXNjW2pdKTsKPiArICAgICAgICAgICAgICAgfQo+Cj4gICAgICAgICAgICAgICAgIGtmcmVlKGlu
ZGlyX2Rlc2MpOwo+ICAgICAgICAgICAgICAgICBzdGF0ZS0+aW5kaXJfZGVzYyA9IE5VTEw7Cj4g
LS0KPiAyLjMyLjAuMy5nMDExOTVjZjlmCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXph
dGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRh
dGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
