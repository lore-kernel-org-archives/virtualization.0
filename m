Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B9884C74A5B
	for <virtualization@archiver.kernel.org>; Fri, 17 Mar 2023 03:17:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 4AA9F82112;
	Fri, 17 Mar 2023 03:17:02 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4AA9F82112
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=O2W/icmi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id huvz5rziYSbU; Fri, 17 Mar 2023 03:17:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id B64EC82103;
	Fri, 17 Mar 2023 03:17:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org B64EC82103
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 9ECC1C0035;
	Fri, 17 Mar 2023 03:17:00 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F2A7C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 03:16:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0917360E5C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 03:16:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 0917360E5C
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=O2W/icmi
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6rs6fERX1MQk
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 03:16:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AAD6460BBD
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id AAD6460BBD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 03:16:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679023016;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=hXVkR863WJDCU7bDckw56H2DefwUV5cKUWiRwRIymHI=;
 b=O2W/icmiu6Q0InoWGZqvqmXqSY567StVpSN5IAuUjGfYfmkuEMqE3zWk4KisjjLetFh+47
 0UEyhzi8Zvl/ReiT0HBoUYcB9V6N87rwIVi2gjtVAG8tHqi8SveE/1Vda93YMrqSFgv9qO
 HWYK6mjGXwCYRnZoC2ym/VIPNGe0JSs=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-343-YYM_gvbwOXKjP-mMu4d4zQ-1; Thu, 16 Mar 2023 23:16:55 -0400
X-MC-Unique: YYM_gvbwOXKjP-mMu4d4zQ-1
Received: by mail-oo1-f70.google.com with SMTP id
 bv19-20020a0568201b1300b0053727cb901bso1099660oob.0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 20:16:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679023014;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=hXVkR863WJDCU7bDckw56H2DefwUV5cKUWiRwRIymHI=;
 b=kAnRX+5bMM3eq1QTFlqQw1fncTLLRDMZINtKEqsw4D1Ot4rgcjfsL+Msl0bKfNXlsV
 kvja5UGIwx6+7laL1ESbas1sC7fkail7JRgaBq/GAi3g7sG1CD8h2ulNk1XgKVvcaZVC
 YSYGXC26xM2oLWeQKGO8L//6hf2RKqmu0j0A/eTEaORWLiSlzkWth5rcO5cA11Tw9urt
 0q2ahx/Q4o9dWjqiEwruJ1UiYM4fEAjzlfH749mnTl6+w+EH7VVks5X6KIvMRQ97rUos
 xVQqTswK4sFJsFpHfVez6m7wZ8WCbLcYicjM8N7RZpIr57HRSVkS0EMOHiHxoD/fFkkq
 t8Bg==
X-Gm-Message-State: AO0yUKVmdFslexvqBsQCwBQExfqDVieeBnXAzGoN5WTHiV/b+Nf9xXEy
 ERPj6NeB8ohdxp2Q8KJfcZvdpjvrYTb0w4CrBy3xrjLCbcxuc5FWF5+B6tKBXjNyJaE4jsDfGIS
 ZGPf6fol5ScL+MXB/fSXFaIIE6qUnYjr+Phly0Nu+nTDNB1PZqify5I0ZnA==
X-Received: by 2002:a05:6830:630a:b0:694:3b4e:d8d7 with SMTP id
 cg10-20020a056830630a00b006943b4ed8d7mr714514otb.0.1679023014559; 
 Thu, 16 Mar 2023 20:16:54 -0700 (PDT)
X-Google-Smtp-Source: AK7set/L8gKQZo7gE3ceO/LGHjt7DT3C7rqhWs8pdB82ho6/wD/db4Y2o4ToNcnyXX4HdWgAe9SJwpqbocFw1TfTjyA=
X-Received: by 2002:a05:6830:630a:b0:694:3b4e:d8d7 with SMTP id
 cg10-20020a056830630a00b006943b4ed8d7mr714506otb.0.1679023014376; Thu, 16 Mar
 2023 20:16:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230315185458.11638-1-feliu@nvidia.com>
 <20230315185458.11638-3-feliu@nvidia.com>
In-Reply-To: <20230315185458.11638-3-feliu@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 17 Mar 2023 11:16:43 +0800
Message-ID: <CACGkMEv6qG-9-A2cmOo00E=pPY2p0dnC3SoM8AVV5xLNMA9YCw@mail.gmail.com>
Subject: Re: [PATCH v2 2/3] virtio_ring: Avoid using inline for small functions
To: Feng Liu <feliu@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S . Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, Jiri Pirko <jiri@nvidia.com>,
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

T24gVGh1LCBNYXIgMTYsIDIwMjMgYXQgMjo1NeKAr0FNIEZlbmcgTGl1IDxmZWxpdUBudmlkaWEu
Y29tPiB3cm90ZToKPgo+IFJlbW92ZSB0aGUgaW5saW5lIGtleXdvcmQsIGFjY29yZGluZyB0byBr
ZXJuZWwgY29kaW5nIHN0eWxlIFsxXSwgZGVmaW5pbmcKPiBpbmxpbmUgZnVuY3Rpb25zIGlzIG5v
dCBuZWNlc3NhcnkgZm9yIHNhbWxsIGZ1bmN0aW9ucy4KPgo+IEl0IGlzIHZlcmlmaWVkIHdpdGgg
R0NDIDEyLjIuMCwgdGhlIGdlbmVyYXRlZCBjb2RlIHdpdGgvd2l0aG91dCBpbmxpbmUKPiBpcyB0
aGUgc2FtZS4gQWRkaXRpb25hbGx5IHRlc3RlZCB3aXRoIGtlcm5lbCBwa3RnZW4gYW5kIGlwZXJm
LCBhbmQKPiB2ZXJpZmllZCB0aGUgcmVzdWx0LCBwcHMgb2YgdGhlIHJlc3VsdHMgYXJlIHRoZSBz
YW1lIGluIHRoZSBjYXNlcyBvZgo+IHdpdGgvd2l0aG91dCBpbmxpbmUuCj4KPiBbMV0KPiBodHRw
czovL3d3dy5rZXJuZWwub3JnL2RvYy9odG1sL3Y2LjItcmMzL3Byb2Nlc3MvY29kaW5nLXN0eWxl
Lmh0bWwjdGhlLWlubGluZS1kaXNlYXNlCj4KPiBTaWduZWQtb2ZmLWJ5OiBGZW5nIExpdSA8ZmVs
aXVAbnZpZGlhLmNvbT4KPiBSZXZpZXdlZC1ieTogSmlyaSBQaXJrbyA8amlyaUBudmlkaWEuY29t
PgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCj4g
LS0tCj4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgfCAxNCArKysrKysrLS0tLS0tLQo+
ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQo+Cj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fcmluZy5jCj4gaW5kZXggNDExNDRiNTI0NmE4Li5hMjZmYWI5MWM1OWYgMTAwNjQ0Cj4g
LS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlv
L3ZpcnRpb19yaW5nLmMKPiBAQCAtMjMzLDggKzIzMyw4IEBAIHN0YXRpYyB2b2lkIHZyaW5nX2Zy
ZWUoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKTsKPgo+ICAjZGVmaW5lIHRvX3Z2cShfdnEpIGNvbnRh
aW5lcl9vZihfdnEsIHN0cnVjdCB2cmluZ192aXJ0cXVldWUsIHZxKQo+Cj4gLXN0YXRpYyBpbmxp
bmUgYm9vbCB2aXJ0cXVldWVfdXNlX2luZGlyZWN0KHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZx
LAo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2lnbmVkIGlu
dCB0b3RhbF9zZykKPiArc3RhdGljIGJvb2wgdmlydHF1ZXVlX3VzZV9pbmRpcmVjdChzdHJ1Y3Qg
dnJpbmdfdmlydHF1ZXVlICp2cSwKPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHVuc2lnbmVkIGludCB0b3RhbF9zZykKPiAgewo+ICAgICAgICAgLyoKPiAgICAgICAgICAqIElm
IHRoZSBob3N0IHN1cHBvcnRzIGluZGlyZWN0IGRlc2NyaXB0b3IgdGFibGVzLCBhbmQgd2UgaGF2
ZSBtdWx0aXBsZQo+IEBAIC0zNDksNyArMzQ5LDcgQEAgc3RhdGljIHZvaWQgdnJpbmdfZnJlZV9x
dWV1ZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwgc2l6ZV90IHNpemUsCj4gICAqIG1ha2lu
ZyBhbGwgb2YgdGhlIGFyY2ggRE1BIG9wcyB3b3JrIG9uIHRoZSB2cmluZyBkZXZpY2UgaXRzZWxm
Cj4gICAqIGlzIGEgbWVzcy4KPiAgICovCj4gLXN0YXRpYyBpbmxpbmUgc3RydWN0IGRldmljZSAq
dnJpbmdfZG1hX2Rldihjb25zdCBzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlICp2cSkKPiArc3RhdGlj
IHN0cnVjdCBkZXZpY2UgKnZyaW5nX2RtYV9kZXYoY29uc3Qgc3RydWN0IHZyaW5nX3ZpcnRxdWV1
ZSAqdnEpCj4gIHsKPiAgICAgICAgIHJldHVybiB2cS0+ZG1hX2RldjsKPiAgfQo+IEBAIC03ODQs
NyArNzg0LDcgQEAgc3RhdGljIHZvaWQgZGV0YWNoX2J1Zl9zcGxpdChzdHJ1Y3QgdnJpbmdfdmly
dHF1ZXVlICp2cSwgdW5zaWduZWQgaW50IGhlYWQsCj4gICAgICAgICB9Cj4gIH0KPgo+IC1zdGF0
aWMgaW5saW5lIGJvb2wgbW9yZV91c2VkX3NwbGl0KGNvbnN0IHN0cnVjdCB2cmluZ192aXJ0cXVl
dWUgKnZxKQo+ICtzdGF0aWMgYm9vbCBtb3JlX3VzZWRfc3BsaXQoY29uc3Qgc3RydWN0IHZyaW5n
X3ZpcnRxdWV1ZSAqdnEpCj4gIHsKPiAgICAgICAgIHJldHVybiB2cS0+bGFzdF91c2VkX2lkeCAh
PSB2aXJ0aW8xNl90b19jcHUodnEtPnZxLnZkZXYsCj4gICAgICAgICAgICAgICAgICAgICAgICAg
dnEtPnNwbGl0LnZyaW5nLnVzZWQtPmlkeCk7Cj4gQEAgLTExNzIsMTIgKzExNzIsMTIgQEAgc3Rh
dGljIGludCB2aXJ0cXVldWVfcmVzaXplX3NwbGl0KHN0cnVjdCB2aXJ0cXVldWUgKl92cSwgdTMy
IG51bSkKPiAgLyoKPiAgICogUGFja2VkIHJpbmcgc3BlY2lmaWMgZnVuY3Rpb25zIC0gKl9wYWNr
ZWQoKS4KPiAgICovCj4gLXN0YXRpYyBpbmxpbmUgYm9vbCBwYWNrZWRfdXNlZF93cmFwX2NvdW50
ZXIodTE2IGxhc3RfdXNlZF9pZHgpCj4gK3N0YXRpYyBib29sIHBhY2tlZF91c2VkX3dyYXBfY291
bnRlcih1MTYgbGFzdF91c2VkX2lkeCkKPiAgewo+ICAgICAgICAgcmV0dXJuICEhKGxhc3RfdXNl
ZF9pZHggJiAoMSA8PCBWUklOR19QQUNLRURfRVZFTlRfRl9XUkFQX0NUUikpOwo+ICB9Cj4KPiAt
c3RhdGljIGlubGluZSB1MTYgcGFja2VkX2xhc3RfdXNlZCh1MTYgbGFzdF91c2VkX2lkeCkKPiAr
c3RhdGljIHUxNiBwYWNrZWRfbGFzdF91c2VkKHUxNiBsYXN0X3VzZWRfaWR4KQo+ICB7Cj4gICAg
ICAgICByZXR1cm4gbGFzdF91c2VkX2lkeCAmIH4oLSgxIDw8IFZSSU5HX1BBQ0tFRF9FVkVOVF9G
X1dSQVBfQ1RSKSk7Cj4gIH0KPiBAQCAtMTYxMiw3ICsxNjEyLDcgQEAgc3RhdGljIGlubGluZSBi
b29sIGlzX3VzZWRfZGVzY19wYWNrZWQoY29uc3Qgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEs
Cj4gICAgICAgICByZXR1cm4gYXZhaWwgPT0gdXNlZCAmJiB1c2VkID09IHVzZWRfd3JhcF9jb3Vu
dGVyOwo+ICB9Cj4KPiAtc3RhdGljIGlubGluZSBib29sIG1vcmVfdXNlZF9wYWNrZWQoY29uc3Qg
c3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEpCj4gK3N0YXRpYyBib29sIG1vcmVfdXNlZF9wYWNr
ZWQoY29uc3Qgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEpCj4gIHsKPiAgICAgICAgIHUxNiBs
YXN0X3VzZWQ7Cj4gICAgICAgICB1MTYgbGFzdF91c2VkX2lkeDsKPiAtLQo+IDIuMzQuMQo+Cgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
