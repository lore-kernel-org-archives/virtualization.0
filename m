Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 055D7C77B70
	for <virtualization@archiver.kernel.org>; Mon, 17 Apr 2023 08:06:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 6689C41928;
	Mon, 17 Apr 2023 08:06:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 6689C41928
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GhmD8e7b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id N8_V_cY94-5f; Mon, 17 Apr 2023 08:06:13 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 423C641591;
	Mon, 17 Apr 2023 08:06:12 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 423C641591
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 243B3C0036;
	Mon, 17 Apr 2023 08:06:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 40CE9C002A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 08:06:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 13902408D7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 08:06:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 13902408D7
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GhmD8e7b
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2fLiOVEWx7l2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 08:06:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B1676402CE
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id B1676402CE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 08:06:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681718768;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qYRGijwUbUuPrxX2F6FH2O9hIK+/AiPnJjKAfwN//Kk=;
 b=GhmD8e7bXQFVN+Q7DzIdCzvJdcGWaNCnt69V9uZ87LLTJbkvjC25D6OlnU1Oz9foG7Fqmc
 d0X55eOZFYB1IHjWMZ+7zpfp/NvN1NUunbIY1xrjGIowD1H/9vle1xHYSwtjSnawBdfoAn
 QI2ztxeFW5zbmt1K9be3xliuNvFxiKk=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-330-w3FhyCJzPuKwXwWIt3xfIA-1; Mon, 17 Apr 2023 04:06:06 -0400
X-MC-Unique: w3FhyCJzPuKwXwWIt3xfIA-1
Received: by mail-oo1-f72.google.com with SMTP id
 s40-20020a4a96ab000000b00546e15de377so158554ooi.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Apr 2023 01:06:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1681718766; x=1684310766;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=qYRGijwUbUuPrxX2F6FH2O9hIK+/AiPnJjKAfwN//Kk=;
 b=RJqpQ7mzO+KzCU2MdqO2IcpcxEk7f9K7HtkbBaaWsjoJ8FQOwP6MKGH3o4BMCOQexn
 7DVwPxAAlaLGZBe71BpSfoCC1QdpW2RJA+8Lt8GqsiBWbCK10GE55sWJmhwDbHn+JCHM
 7FyMwQfg9h6UTwNOwcvCe2n7a9KTK1gFFaTBrhxWJt1yA6fVZhLejy+llXcydzZMFEoR
 dpTd2p6PfvC0zmjwwkSGCUZ0I8TMJvrvst19czBoz0hXUvuX6Y2mk3T61V2TDHXmNABj
 8Ftno7QnLkHuw0SSAz1/3s/8wmvrVStRJt8QRqnOasNTiU/CDf+H1NL05eLvRx8rrXVc
 hG+w==
X-Gm-Message-State: AAQBX9dUhcxxhSTBOnvUYPQeoqCBWsjcoVXKfexJZf2je0wLjjAQZVfL
 MIUWF+KA20G8DKKx6tb4pcGCNx4bLWKxi6jxMFYvD7rAENeJZbPpt73feL4VbzOeRfyR27Bz9Rr
 8T+BwuxHiISw62sqI46xc9Y3OqmumCI2JGQjQX5nwvI/ShlEBlqRVVZlzCQ==
X-Received: by 2002:a05:6870:5627:b0:17d:1287:1b5c with SMTP id
 m39-20020a056870562700b0017d12871b5cmr6663642oao.9.1681718765905; 
 Mon, 17 Apr 2023 01:06:05 -0700 (PDT)
X-Google-Smtp-Source: AKy350YjLKQuchwO+hUXUuPxbOO7XX7RZRgN+R5sS6pfxfslGmqlnQwuYF3z03TsVBQdhR5lRHk/kgHDMKGbe2ZMtBc=
X-Received: by 2002:a05:6870:5627:b0:17d:1287:1b5c with SMTP id
 m39-20020a056870562700b0017d12871b5cmr6663636oao.9.1681718765687; Mon, 17 Apr
 2023 01:06:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230413081855.36643-1-alvaro.karsz@solid-run.com>
 <20230413081855.36643-3-alvaro.karsz@solid-run.com>
In-Reply-To: <20230413081855.36643-3-alvaro.karsz@solid-run.com>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 17 Apr 2023 16:05:54 +0800
Message-ID: <CACGkMEvAWs2bvFT=rZBHUeGmP-yELaF_-ynZ6yLT97UuKdQktw@mail.gmail.com>
Subject: Re: [PATCH 2/2] virtio-vdpa: add VIRTIO_F_NOTIFICATION_DATA feature
 support
To: Alvaro Karsz <alvaro.karsz@solid-run.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-s390@vger.kernel.org, farman@linux.ibm.com, kvm@vger.kernel.org,
 mst@redhat.com, cohuck@redhat.com, viktor@daynix.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 pasic@linux.ibm.com, yan@daynix.com
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

T24gVGh1LCBBcHIgMTMsIDIwMjMgYXQgNDoxOeKAr1BNIEFsdmFybyBLYXJzeiA8YWx2YXJvLmth
cnN6QHNvbGlkLXJ1bi5jb20+IHdyb3RlOgo+Cj4gQWRkIFZJUlRJT19GX05PVElGSUNBVElPTl9E
QVRBIHN1cHBvcnQgZm9yIHZEUEEgdHJhbnNwb3J0Lgo+IElmIHRoaXMgZmVhdHVyZSBpcyBuZWdv
dGlhdGVkLCB0aGUgZHJpdmVyIHBhc3NlcyBleHRyYSBkYXRhIHdoZW4ga2lja2luZwo+IGEgdmly
dHF1ZXVlLgo+Cj4gQSBkZXZpY2UgdGhhdCBvZmZlcnMgdGhpcyBmZWF0dXJlIG5lZWRzIHRvIGlt
cGxlbWVudCB0aGUKPiBraWNrX3ZxX3dpdGhfZGF0YSBjYWxsYmFjay4KPgo+IGtpY2tfdnFfd2l0
aF9kYXRhIHJlY2VpdmVzIHRoZSB2RFBBIGRldmljZSBhbmQgZGF0YS4KPiBkYXRhIGluY2x1ZGVz
Ogo+IDE2IGJpdHMgdnFuIGFuZCAxNiBiaXRzIG5leHQgYXZhaWxhYmxlIGluZGV4IGZvciBzcGxp
dCB2aXJ0cXVldWVzLgo+IDE2IGJpdHMgdnFzLCAxNSBsZWFzdCBzaWduaWZpY2FudCBiaXRzIG9m
IG5leHQgYXZhaWxhYmxlIGluZGV4Cj4gYW5kIDEgYml0IG5leHRfd3JhcCBmb3IgcGFja2VkIHZp
cnRxdWV1ZXMuCj4KPiBUaGlzIHBhdGNoIGZvbGxvd3MgYSBwYXRjaCBbMV0gYnkgVmlrdG9yIFBy
dXR5YW5vdiB3aGljaCBhZGRzIHN1cHBvcnQKPiBmb3IgdGhlIE1NSU8sIGNoYW5uZWwgSS9PIGFu
ZCBtb2Rlcm4gUENJIHRyYW5zcG9ydHMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBBbHZhcm8gS2Fyc3og
PGFsdmFyby5rYXJzekBzb2xpZC1ydW4uY29tPgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293
YW5nQHJlZGhhdC5jb20+CgpUaGFua3MKCj4gLS0tCj4gIGRyaXZlcnMvdmlydGlvL3ZpcnRpb192
ZHBhLmMgfCAyMyArKysrKysrKysrKysrKysrKysrKystLQo+ICBpbmNsdWRlL2xpbnV4L3ZkcGEu
aCAgICAgICAgIHwgIDkgKysrKysrKysrCj4gIDIgZmlsZXMgY2hhbmdlZCwgMzAgaW5zZXJ0aW9u
cygrKSwgMiBkZWxldGlvbnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0
aW9fdmRwYS5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYwo+IGluZGV4IGQ3ZjVhZjYy
ZGRhLi43MzdjMWYzNmQzMiAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRw
YS5jCj4gKysrIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYwo+IEBAIC0xMTIsNiArMTEy
LDE3IEBAIHN0YXRpYyBib29sIHZpcnRpb192ZHBhX25vdGlmeShzdHJ1Y3QgdmlydHF1ZXVlICp2
cSkKPiAgICAgICAgIHJldHVybiB0cnVlOwo+ICB9Cj4KPiArc3RhdGljIGJvb2wgdmlydGlvX3Zk
cGFfbm90aWZ5X3dpdGhfZGF0YShzdHJ1Y3QgdmlydHF1ZXVlICp2cSkKPiArewo+ICsgICAgICAg
c3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhID0gdmRfZ2V0X3ZkcGEodnEtPnZkZXYpOwo+ICsgICAg
ICAgY29uc3Qgc3RydWN0IHZkcGFfY29uZmlnX29wcyAqb3BzID0gdmRwYS0+Y29uZmlnOwo+ICsg
ICAgICAgdTMyIGRhdGEgPSB2cmluZ19ub3RpZmljYXRpb25fZGF0YSh2cSk7Cj4gKwo+ICsgICAg
ICAgb3BzLT5raWNrX3ZxX3dpdGhfZGF0YSh2ZHBhLCBkYXRhKTsKPiArCj4gKyAgICAgICByZXR1
cm4gdHJ1ZTsKPiArfQo+ICsKPiAgc3RhdGljIGlycXJldHVybl90IHZpcnRpb192ZHBhX2NvbmZp
Z19jYih2b2lkICpwcml2YXRlKQo+ICB7Cj4gICAgICAgICBzdHJ1Y3QgdmlydGlvX3ZkcGFfZGV2
aWNlICp2ZF9kZXYgPSBwcml2YXRlOwo+IEBAIC0xMzgsNiArMTQ5LDcgQEAgdmlydGlvX3ZkcGFf
c2V0dXBfdnEoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGludCBpbmRleCwK
PiAgICAgICAgIHN0cnVjdCBkZXZpY2UgKmRtYV9kZXY7Cj4gICAgICAgICBjb25zdCBzdHJ1Y3Qg
dmRwYV9jb25maWdfb3BzICpvcHMgPSB2ZHBhLT5jb25maWc7Cj4gICAgICAgICBzdHJ1Y3Qgdmly
dGlvX3ZkcGFfdnFfaW5mbyAqaW5mbzsKPiArICAgICAgIGJvb2wgKCpub3RpZnkpKHN0cnVjdCB2
aXJ0cXVldWUgKnZxKSA9IHZpcnRpb192ZHBhX25vdGlmeTsKPiAgICAgICAgIHN0cnVjdCB2ZHBh
X2NhbGxiYWNrIGNiOwo+ICAgICAgICAgc3RydWN0IHZpcnRxdWV1ZSAqdnE7Cj4gICAgICAgICB1
NjQgZGVzY19hZGRyLCBkcml2ZXJfYWRkciwgZGV2aWNlX2FkZHI7Cj4gQEAgLTE1NCw2ICsxNjYs
MTQgQEAgdmlydGlvX3ZkcGFfc2V0dXBfdnEoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsIHVu
c2lnbmVkIGludCBpbmRleCwKPiAgICAgICAgIGlmIChpbmRleCA+PSB2ZHBhLT5udnFzKQo+ICAg
ICAgICAgICAgICAgICByZXR1cm4gRVJSX1BUUigtRU5PRU5UKTsKPgo+ICsgICAgICAgLyogV2Ug
Y2Fubm90IGFjY2VwdCBWSVJUSU9fRl9OT1RJRklDQVRJT05fREFUQSB3aXRob3V0IGtpY2tfdnFf
d2l0aF9kYXRhICovCj4gKyAgICAgICBpZiAoX192aXJ0aW9fdGVzdF9iaXQodmRldiwgVklSVElP
X0ZfTk9USUZJQ0FUSU9OX0RBVEEpKSB7Cj4gKyAgICAgICAgICAgICAgIGlmIChvcHMtPmtpY2tf
dnFfd2l0aF9kYXRhKQo+ICsgICAgICAgICAgICAgICAgICAgICAgIG5vdGlmeSA9IHZpcnRpb192
ZHBhX25vdGlmeV93aXRoX2RhdGE7Cj4gKyAgICAgICAgICAgICAgIGVsc2UKPiArICAgICAgICAg
ICAgICAgICAgICAgICBfX3ZpcnRpb19jbGVhcl9iaXQodmRldiwgVklSVElPX0ZfTk9USUZJQ0FU
SU9OX0RBVEEpOwo+ICsgICAgICAgfQo+ICsKPiAgICAgICAgIC8qIFF1ZXVlIHNob3VsZG4ndCBh
bHJlYWR5IGJlIHNldCB1cC4gKi8KPiAgICAgICAgIGlmIChvcHMtPmdldF92cV9yZWFkeSh2ZHBh
LCBpbmRleCkpCj4gICAgICAgICAgICAgICAgIHJldHVybiBFUlJfUFRSKC1FTk9FTlQpOwo+IEBA
IC0xODMsOCArMjAzLDcgQEAgdmlydGlvX3ZkcGFfc2V0dXBfdnEoc3RydWN0IHZpcnRpb19kZXZp
Y2UgKnZkZXYsIHVuc2lnbmVkIGludCBpbmRleCwKPiAgICAgICAgICAgICAgICAgZG1hX2RldiA9
IHZkcGFfZ2V0X2RtYV9kZXYodmRwYSk7Cj4gICAgICAgICB2cSA9IHZyaW5nX2NyZWF0ZV92aXJ0
cXVldWVfZG1hKGluZGV4LCBtYXhfbnVtLCBhbGlnbiwgdmRldiwKPiAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgdHJ1ZSwgbWF5X3JlZHVjZV9udW0sIGN0eCwKPiAtICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdmlydGlvX3ZkcGFfbm90aWZ5LCBj
YWxsYmFjaywKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbmFtZSwg
ZG1hX2Rldik7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5vdGlm
eSwgY2FsbGJhY2ssIG5hbWUsIGRtYV9kZXYpOwo+ICAgICAgICAgaWYgKCF2cSkgewo+ICAgICAg
ICAgICAgICAgICBlcnIgPSAtRU5PTUVNOwo+ICAgICAgICAgICAgICAgICBnb3RvIGVycm9yX25l
d192aXJ0cXVldWU7Cj4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmRwYS5oIGIvaW5jbHVk
ZS9saW51eC92ZHBhLmgKPiBpbmRleCA0M2Y1OWVmMTBjYy4uMDRjZGFhZDc3ZGQgMTAwNjQ0Cj4g
LS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+
IEBAIC0xNDMsNiArMTQzLDE0IEBAIHN0cnVjdCB2ZHBhX21hcF9maWxlIHsKPiAgICogQGtpY2tf
dnE6ICAgICAgICAgICAgICAgICAgIEtpY2sgdGhlIHZpcnRxdWV1ZQo+ICAgKiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgQHZkZXY6IHZkcGEgZGV2aWNlCj4gICAqICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBAaWR4OiB2aXJ0cXVldWUgaW5kZXgKPiArICogQGtpY2tfdnFfd2l0aF9k
YXRhOiAgICAgICAgIEtpY2sgdGhlIHZpcnRxdWV1ZSBhbmQgc3VwcGx5IGV4dHJhIGRhdGEKPiAr
ICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIChvbmx5IGlmIFZJUlRJT19GX05PVElGSUNB
VElPTl9EQVRBIGlzIG5lZ290aWF0ZWQpCj4gKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBAdmRldjogdmRwYSBkZXZpY2UKPiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIEBk
YXRhIGZvciBzcGxpdCB2aXJ0cXVldWU6Cj4gKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAxNiBiaXRzIHZxbiBhbmQgMTYgYml0cyBuZXh0IGF2YWlsYWJsZSBpbmRleC4KPiArICogICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIEBkYXRhIGZvciBwYWNrZWQgdmlydHF1ZXVlOgo+ICsg
KiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgMTYgYml0cyB2cW4sIDE1IGxlYXN0IHNpZ25p
ZmljYW50IGJpdHMgb2YKPiArICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIG5leHQgYXZh
aWxhYmxlIGluZGV4IGFuZCAxIGJpdCBuZXh0X3dyYXAuCj4gICAqIEBzZXRfdnFfY2I6ICAgICAg
ICAgICAgICAgICBTZXQgdGhlIGludGVycnVwdCBjYWxsYmFjayBmdW5jdGlvbiBmb3IKPiAgICog
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIGEgdmlydHF1ZXVlCj4gICAqICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBAdmRldjogdmRwYSBkZXZpY2UKPiBAQCAtMzAwLDYgKzMwOCw3IEBA
IHN0cnVjdCB2ZHBhX2NvbmZpZ19vcHMgewo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IHU2NCBkZXZpY2VfYXJlYSk7Cj4gICAgICAgICB2b2lkICgqc2V0X3ZxX251bSkoc3RydWN0IHZk
cGFfZGV2aWNlICp2ZGV2LCB1MTYgaWR4LCB1MzIgbnVtKTsKPiAgICAgICAgIHZvaWQgKCpraWNr
X3ZxKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHUxNiBpZHgpOwo+ICsgICAgICAgdm9pZCAo
KmtpY2tfdnFfd2l0aF9kYXRhKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHUzMiBkYXRhKTsK
PiAgICAgICAgIHZvaWQgKCpzZXRfdnFfY2IpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTE2
IGlkeCwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2ZHBhX2NhbGxiYWNrICpj
Yik7Cj4gICAgICAgICB2b2lkICgqc2V0X3ZxX3JlYWR5KShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZk
ZXYsIHUxNiBpZHgsIGJvb2wgcmVhZHkpOwo+IC0tCj4gMi4zNC4xCj4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
