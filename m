Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 821EBC64EC4
	for <virtualization@archiver.kernel.org>; Wed,  8 Mar 2023 06:57:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1FD6541746;
	Wed,  8 Mar 2023 06:57:30 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1FD6541746
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Eo+Ggz0X
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sUwZiI5PZg8c; Wed,  8 Mar 2023 06:57:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4261A4175A;
	Wed,  8 Mar 2023 06:57:28 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 4261A4175A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0EC47C0071;
	Wed,  8 Mar 2023 06:57:28 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A5E0FC0032
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:57:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 82E0D81E76
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:57:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 82E0D81E76
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Eo+Ggz0X
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2SZXOSNby8tC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:57:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B603781E75
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id B603781E75
 for <virtualization@lists.linux-foundation.org>;
 Wed,  8 Mar 2023 06:57:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678258644;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3eROVbIkJuDlS4TwJViK9oL0UONLoKgXabRRAsVTav8=;
 b=Eo+Ggz0Xkd3u6h99gUaubc/7SZYYI5anRMkrWRD4ZmD+wuHoKQpQFJ+U6mgKW62kEoVK62
 NblWQetcqy+hH9H65uBFAjtL3IvBryI2w4jgZLOrFk6f6R+GtNS/Ggrj4/+vnY+VMMl6rC
 HsLARyixTeqa2kfyhUqXZ4x08zepUsM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-653-zVAYQpZKOo2cHD4gs-VaGQ-1; Wed, 08 Mar 2023 01:57:23 -0500
X-MC-Unique: zVAYQpZKOo2cHD4gs-VaGQ-1
Received: by mail-ed1-f69.google.com with SMTP id
 b7-20020a056402350700b004d2a3d5cd3fso17164262edd.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 07 Mar 2023 22:57:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678258642;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3eROVbIkJuDlS4TwJViK9oL0UONLoKgXabRRAsVTav8=;
 b=RuyETSOfcFWF1l0+BV9pPtQtbMdqQIESwOKZvdpt9NS5PntJer+i6F5XNDFcbIn7B7
 L5uQJW7GLMFGeVcR6iqbjbxHScB1LDJGB9Eytz7EtyT7iGyE4Usd5zQ/q6K7qAhyOe4t
 77ce5AWcvr4DB+PI0IH8MY3YHWbgCdGVnYm7qntC0JTMr42H0jsD2bxug6wWZq1l2hu2
 CUlPnPQD/naGIzr8Co92t4AXGD2ugUZ3Xcgu09JnQBGy0lEpH6Lyfueivvk/W9wYPFkc
 WFb05bnJY07T+q5wuCXioYHMXpRF0YrhSsgmLMF4ncWJbFB7JCN9tIfTCPfhYbC9vLlp
 rH+w==
X-Gm-Message-State: AO0yUKXkuxqBoDbM92Go5kS+LnpGI4q88mMROJKUZRYmpNrc4LTQjycQ
 BqNLbKnFMvcmPCjkHbzZTn/4oYMXeIEIkpfCjpLQLlHolbt5Nau8BfiQjeP+EILH3pEFFVyktFQ
 PL5IiBdB9eMhTeuDnOm33MSa47uJjqjZuj7GlAnPDIA==
X-Received: by 2002:a17:906:498e:b0:909:4a93:d9d2 with SMTP id
 p14-20020a170906498e00b009094a93d9d2mr18441573eju.2.1678258642170; 
 Tue, 07 Mar 2023 22:57:22 -0800 (PST)
X-Google-Smtp-Source: AK7set9CN/UPjKFDpKNGT6+fuEmPKBtZx5+Kl7tcu4wb67TAHZ8Kdf77IjPXO1UcuSZUNGZQ9HFDyw==
X-Received: by 2002:a17:906:498e:b0:909:4a93:d9d2 with SMTP id
 p14-20020a170906498e00b009094a93d9d2mr18441564eju.2.1678258641893; 
 Tue, 07 Mar 2023 22:57:21 -0800 (PST)
Received: from redhat.com ([2.52.138.216]) by smtp.gmail.com with ESMTPSA id
 h7-20020a50cdc7000000b004bc15a440f1sm7761213edj.78.2023.03.07.22.57.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 07 Mar 2023 22:57:21 -0800 (PST)
Date: Wed, 8 Mar 2023 01:57:18 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/3] virtio_pci_modern: Remove unnecessary num zero check
Message-ID: <20230308015542-mutt-send-email-mst@kernel.org>
References: <20230307035705.4479-1-feliu@nvidia.com>
 <20230307035705.4479-2-feliu@nvidia.com>
 <CACGkMEsrnd_iLM97RZrPnjLTeU4WGFDbPF97826Pj7nx7rUj7w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEsrnd_iLM97RZrPnjLTeU4WGFDbPF97826Pj7nx7rUj7w@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: virtualization@lists.linux-foundation.org, Jiri Pirko <jiri@nvidia.com>,
 Bodong Wang <bodong@nvidia.com>, Gavin Li <gavinl@nvidia.com>
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

T24gV2VkLCBNYXIgMDgsIDIwMjMgYXQgMDE6NTI6NDNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiBPbiBUdWUsIE1hciA3LCAyMDIzIGF0IDExOjU34oCvQU0gRmVuZyBMaXUgPGZlbGl1QG52
aWRpYS5jb20+IHdyb3RlOgo+ID4KPiA+IGlzX3Bvd2VyX29mXzIoKSBhbHJlYWR5IHBlcmZvcm1z
IHRoZSB6ZXJvIGNoZWNrLiBIZW5jZSBhdm9pZCBkdXBsaWNhdGUKPiA+IGNoZWNrLiBXaGlsZSBh
dCBpdCwgbW92ZSB0aGUgcXVlcnkgb2Ygc2l6ZSBjaGVjayBhbHNvIGFkamFjZW50IHRvIHdoZXJl
Cj4gPiBpdHMgdXNlZCBmb3IgdGhlIGRpc2FibGVkIHZxLgo+ID4KPiA+IFNpZ25lZC1vZmYtYnk6
IEZlbmcgTGl1IDxmZWxpdUBudmlkaWEuY29tPgo+ID4gUmV2aWV3ZWQtYnk6IEppcmkgUGlya28g
PGppcmlAbnZpZGlhLmNvbT4KPiA+IFJldmlld2VkLWJ5OiBQYXJhdiBQYW5kaXQgPHBhcmF2QG52
aWRpYS5jb20+Cj4gPiBSZXZpZXdlZC1ieTogR2F2aW4gTGkgPGdhdmlubEBudmlkaWEuY29tPgo+
ID4gUmV2aWV3ZWQtYnk6IEJvZG9uZyBXYW5nIDxib2RvbmdAbnZpZGlhLmNvbT4KPiA+IC0tLQo+
ID4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19wY2lfbW9kZXJuLmMgfCA0ICsrLS0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+ID4KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybi5jIGIvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3BjaV9tb2Rlcm4uYwo+ID4gaW5kZXggOWU0OTZlMjg4Y2ZhLi4zZDcxNDRmOGY5
NTkgMTAwNjQ0Cj4gPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybi5jCj4g
PiArKysgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcGNpX21vZGVybi5jCj4gPiBAQCAtMzA2LDEw
ICszMDYsMTAgQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnNldHVwX3ZxKHN0cnVjdCB2aXJ0
aW9fcGNpX2RldmljZSAqdnBfZGV2LAo+ID4gICAgICAgICAgICAgICAgIHJldHVybiBFUlJfUFRS
KC1FSU5WQUwpOwo+ID4KPiA+ICAgICAgICAgLyogQ2hlY2sgaWYgcXVldWUgaXMgZWl0aGVyIG5v
dCBhdmFpbGFibGUgb3IgYWxyZWFkeSBhY3RpdmUuICovCj4gPiAtICAgICAgIG51bSA9IHZwX21v
ZGVybl9nZXRfcXVldWVfc2l6ZShtZGV2LCBpbmRleCk7Cj4gPiAtICAgICAgIGlmICghbnVtIHx8
IHZwX21vZGVybl9nZXRfcXVldWVfZW5hYmxlKG1kZXYsIGluZGV4KSkKPiA+ICsgICAgICAgaWYg
KHZwX21vZGVybl9nZXRfcXVldWVfZW5hYmxlKG1kZXYsIGluZGV4KSkKPiA+ICAgICAgICAgICAg
ICAgICByZXR1cm4gRVJSX1BUUigtRU5PRU5UKTsKPiAKPiBTcGVjIGFsbG93cyBub24gcG93ZXIg
b2YgMiBzaXplIGZvciBwYWNrZWQgdmlydHF1ZXVlLCBzbyBJIHRoaW5rIHdlCj4gc2hvdWxkIGZp
eCBpdCBpbiB0aGlzIHdheS4KPiAKPiAiIiIKPiBRdWV1ZSBTaXplIGNvcnJlc3BvbmRzIHRvIHRo
ZSBtYXhpbXVtIG51bWJlciBvZiBkZXNjcmlwdG9ycyBpbiB0aGUKPiB2aXJ0cXVldWU1LiBUaGUg
UXVldWUgU2l6ZSB2YWx1ZSBkb2VzIG5vdCBoYXZlIHRvIGJlIGEgcG93ZXIgb2YgMi4KPiAiIiIK
PiAKPiBUaGFua3MKCk9oIHlhY2suIEhvdyBjb21lIHdlIG5ldmVyIG5vdGljZWQgOigKCkFuZCBp
dCdzIGJlZW4gbGlrZSB0aGlzIGZyb20gZGF5IDEsIHRvby4KCgpMZXQncyBmaXggdGhpcyBhbmQg
YmFja3BvcnQgZXZlcnl3aGVyZSB3ZSBjYW4uCgo+ID4KPiA+ICsgICAgICAgbnVtID0gdnBfbW9k
ZXJuX2dldF9xdWV1ZV9zaXplKG1kZXYsIGluZGV4KTsKPiA+ICAgICAgICAgaWYgKCFpc19wb3dl
cl9vZl8yKG51bSkpIHsKPiA+ICAgICAgICAgICAgICAgICBkZXZfd2FybigmdnBfZGV2LT5wY2lf
ZGV2LT5kZXYsICJiYWQgcXVldWUgc2l6ZSAldSIsIG51bSk7Cj4gPiAgICAgICAgICAgICAgICAg
cmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7Cj4gPiAtLQo+ID4gMi4zNC4xCj4gPgoKX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFp
bGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBz
Oi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0
aW9u
