Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0DE35C6FD18
	for <virtualization@archiver.kernel.org>; Fri, 31 Mar 2023 09:18:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 86A1F84494;
	Fri, 31 Mar 2023 09:18:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 86A1F84494
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Ku4PPTYr
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 0FDQR9CoYvMm; Fri, 31 Mar 2023 09:18:05 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 0E72284463;
	Fri, 31 Mar 2023 09:18:05 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 0E72284463
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BDB47C0036;
	Fri, 31 Mar 2023 09:18:04 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8AEBBC002F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 09:18:03 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6665584463
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 09:18:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 6665584463
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OmlsRAOCGpRx
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 09:18:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 5418584195
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 5418584195
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 09:18:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1680254281;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yF9v5IIOGw5V44anpb+5Mxccda/7bq4u5RLsf+2F9Rw=;
 b=Ku4PPTYrD4OonMC2PT6EI4HI8x+AMLGLG3CxR9ueZ8nBD9OGkmTWn5JemFE8HLtUD4skIO
 70M4Rhz5GtdpcUjIHETV0+7nkIlTBpfDQhaA80Lyry59dlTCJJl4q+DUSbwPglM4qPl21y
 Z2AuO3jg5cPcRQjhDCHSYADP5VPi5oI=
Received: from mail-oa1-f71.google.com (mail-oa1-f71.google.com
 [209.85.160.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-324-q8dC2lO_MsCNJVePZa-ymA-1; Fri, 31 Mar 2023 05:17:59 -0400
X-MC-Unique: q8dC2lO_MsCNJVePZa-ymA-1
Received: by mail-oa1-f71.google.com with SMTP id
 586e51a60fabf-17a03f26ff8so11134518fac.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 31 Mar 2023 02:17:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1680254279; x=1682846279;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=yF9v5IIOGw5V44anpb+5Mxccda/7bq4u5RLsf+2F9Rw=;
 b=11EIxbes4nSENkkKwtGosJeBv9drekfStetMGTs1vK1TVo+H5iA/7cOrVIvDqdI8RV
 BfnDUmWr9+9xJ+E2JOQ4Ap9/Clzdt5kZRyw7wRrA+J7IUIFaepO1f2tQk/qxlSC3cHTl
 gTImeDwS4JV2nlx0L/ME37YxKMj5nC1VSyMv1WKs91ogXUVGajWCMUm6O9achz2tQJIW
 AU+bAZGHna5fLvJqaGqtbTSmD5dFEWQQx5Q/2OxSjLcbyaJBycL+bKVWf6IXA74tWHK1
 mOi6MAs76YnZEbCJHCCdlG7JSza9Tb2xWn3IvmMiEtJVM0XyHaAh8M708FPPMZ8of4qf
 KS2w==
X-Gm-Message-State: AAQBX9ejhvkf41OLkiAeWYcdDXtN/Zs/U1Nv+OLj745IYAL5zxfKIPys
 bnAJozUJQ4ZI4Q/qjrHk20MVwkA+MkeKXzvvU50igEVb34Yg0hlFNst9RB5iJHYVU951aaVG70+
 nletStwgROSPo/3JYK/z1VB/GZptUf9/GYpmZgcgtNfs/CTSaD/NhN/5XXg==
X-Received: by 2002:a05:6870:8310:b0:177:c2fb:8cec with SMTP id
 p16-20020a056870831000b00177c2fb8cecmr10256252oae.9.1680254279145; 
 Fri, 31 Mar 2023 02:17:59 -0700 (PDT)
X-Google-Smtp-Source: AK7set+E2W7ure/YSp1DuLxL/pvVMjd7YOtJGAtSadYaT4ARjDtzxSTPtCoDCPBuSTIJIZfHW6UC773ZQzF41GhWaJ8=
X-Received: by 2002:a05:6870:8310:b0:177:c2fb:8cec with SMTP id
 p16-20020a056870831000b00177c2fb8cecmr10256243oae.9.1680254278939; Fri, 31
 Mar 2023 02:17:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230331-vhost-fixes-v1-0-1f046e735b9e@kernel.org>
 <20230331-vhost-fixes-v1-1-1f046e735b9e@kernel.org>
In-Reply-To: <20230331-vhost-fixes-v1-1-1f046e735b9e@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 31 Mar 2023 17:17:47 +0800
Message-ID: <CACGkMEtObQFH=oQtEmeBdRS504roSTryx9QR5Xww5Lyob6W5Yg@mail.gmail.com>
Subject: Re: [PATCH vhost 1/3] vdpa: address kdoc warnings
To: Simon Horman <horms@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 netdev@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>, Eli Cohen <elic@nvidia.com>
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

T24gRnJpLCBNYXIgMzEsIDIwMjMgYXQgNDo1OOKAr1BNIFNpbW9uIEhvcm1hbiA8aG9ybXNAa2Vy
bmVsLm9yZz4gd3JvdGU6Cj4KPiBUaGlzIHBhdGNoIGFkZHJlc3NlcyB0aGUgZm9sbG93aW5nIG1p
bm9yIGtkb2MgcHJvYmxlbXMuCj4KPiAqIEluY29ycmVjdCBzcGVsbGluZyBvZiAnY2FsbGJhY2sn
IGFuZCAnbm90aWZpY2F0aW9uJwo+ICogVW5yZWNvZ25pc2VkIGtkb2MgZm9ybWF0IGZvciAnc3Ry
dWN0IHZkcGFfbWFwX2ZpbGUnCj4gKiBNaXNzaW5nIGRvY3VtZW50YXRpb24gb2YgJ2dldF92ZW5k
b3JfdnFfc3RhdHMnIG1lbWJlciBvZgo+ICAgJ3N0cnVjdCB2ZHBhX2NvbmZpZ19vcHMnCj4gKiBN
aXNzaW5nIGRvY3VtZW50YXRpb24gb2YgJ21heF9zdXBwb3J0ZWRfdnFzJyBhbmQgJ3N1cHBvcnRl
ZF9mZWF0dXJlcycKPiAgIG1lbWJlcnMgb2YgJ3N0cnVjdCB2ZHBhX21nbXRfZGV2Jwo+Cj4gTW9z
dCBvZiB0aGVzZSBwcm9ibGVtcyB3ZXJlIGZsYWdnZWQgYnk6Cj4KPiAgJCAuL3NjcmlwdHMva2Vy
bmVsLWRvYyAtV2Vycm9yIC1ub25lICBpbmNsdWRlL2xpbnV4L3ZkcGEuaAo+ICBpbmNsdWRlL2xp
bnV4L3ZkcGEuaDoyMDogd2FybmluZzogZXhwZWN0aW5nIHByb3RvdHlwZSBmb3Igc3RydWN0IHZk
cGFfY2FsbGxiYWNrLiBQcm90b3R5cGUgd2FzIGZvciBzdHJ1Y3QgdmRwYV9jYWxsYmFjayBpbnN0
ZWFkCj4gIGluY2x1ZGUvbGludXgvdmRwYS5oOjExNzogd2FybmluZzogVGhpcyBjb21tZW50IHN0
YXJ0cyB3aXRoICcvKionLCBidXQgaXNuJ3QgYSBrZXJuZWwtZG9jIGNvbW1lbnQuIFJlZmVyIERv
Y3VtZW50YXRpb24vZG9jLWd1aWRlL2tlcm5lbC1kb2MucnN0Cj4gICAqIENvcnJlc3BvbmRpbmcg
ZmlsZSBhcmVhIGZvciBkZXZpY2UgbWVtb3J5IG1hcHBpbmcKPiAgaW5jbHVkZS9saW51eC92ZHBh
Lmg6MzU3OiB3YXJuaW5nOiBGdW5jdGlvbiBwYXJhbWV0ZXIgb3IgbWVtYmVyICdnZXRfdmVuZG9y
X3ZxX3N0YXRzJyBub3QgZGVzY3JpYmVkIGluICd2ZHBhX2NvbmZpZ19vcHMnCj4gIGluY2x1ZGUv
bGludXgvdmRwYS5oOjUxODogd2FybmluZzogRnVuY3Rpb24gcGFyYW1ldGVyIG9yIG1lbWJlciAn
c3VwcG9ydGVkX2ZlYXR1cmVzJyBub3QgZGVzY3JpYmVkIGluICd2ZHBhX21nbXRfZGV2Jwo+ICBp
bmNsdWRlL2xpbnV4L3ZkcGEuaDo1MTg6IHdhcm5pbmc6IEZ1bmN0aW9uIHBhcmFtZXRlciBvciBt
ZW1iZXIgJ21heF9zdXBwb3J0ZWRfdnFzJyBub3QgZGVzY3JpYmVkIGluICd2ZHBhX21nbXRfZGV2
Jwo+Cj4gVGhlIG1pc3NwZWxsaW5nIG9mICdub3RpZmljYXRpb24nIHdhcyBmbGFnZ2VkIGJ5Ogo+
ICAkIC4vc2NyaXB0cy9jaGVja3BhdGNoLnBsIC0tY29kZXNwZWxsIC0tc2hvd2ZpbGUgLS1zdHJp
Y3QgLWYgaW5jbHVkZS9saW51eC92ZHBhLmgKPiAgaW5jbHVkZS9saW51eC92ZHBhLmg6MTcxOiBD
SEVDSzogJ25vdGlmY2F0aW9uJyBtYXkgYmUgbWlzc3BlbGxlZCAtIHBlcmhhcHMgJ25vdGlmaWNh
dGlvbic/Cj4gIC4uLgo+Cj4gU2lnbmVkLW9mZi1ieTogU2ltb24gSG9ybWFuIDxob3Jtc0BrZXJu
ZWwub3JnPgoKQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgpUaGFu
a3MKCj4gLS0tCj4gIGluY2x1ZGUvbGludXgvdmRwYS5oIHwgMTQgKysrKysrKysrKystLS0KPiAg
MSBmaWxlIGNoYW5nZWQsIDExIGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pCj4KPiBkaWZm
IC0tZ2l0IGEvaW5jbHVkZS9saW51eC92ZHBhLmggYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+IGlu
ZGV4IDQzZjU5ZWYxMGNjOS4uMDEwMzIxOTQ1OTk3IDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGlu
dXgvdmRwYS5oCj4gKysrIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPiBAQCAtMTAsNyArMTAsNyBA
QAo+ICAjaW5jbHVkZSA8bGludXgvaWZfZXRoZXIuaD4KPgo+ICAvKioKPiAtICogc3RydWN0IHZk
cGFfY2FsbGxiYWNrIC0gdkRQQSBjYWxsYmFjayBkZWZpbml0aW9uLgo+ICsgKiBzdHJ1Y3QgdmRw
YV9jYWxsYmFjayAtIHZEUEEgY2FsbGJhY2sgZGVmaW5pdGlvbi4KPiAgICogQGNhbGxiYWNrOiBp
bnRlcnJ1cHQgY2FsbGJhY2sgZnVuY3Rpb24KPiAgICogQHByaXZhdGU6IHRoZSBkYXRhIHBhc3Nl
ZCB0byB0aGUgY2FsbGJhY2sgZnVuY3Rpb24KPiAgICovCj4gQEAgLTExNCw3ICsxMTQsNyBAQCBz
dHJ1Y3QgdmRwYV9kZXZfc2V0X2NvbmZpZyB7Cj4gIH07Cj4KPiAgLyoqCj4gLSAqIENvcnJlc3Bv
bmRpbmcgZmlsZSBhcmVhIGZvciBkZXZpY2UgbWVtb3J5IG1hcHBpbmcKPiArICogc3RydWN0IHZk
cGFfbWFwX2ZpbGUgLSBmaWxlIGFyZWEgZm9yIGRldmljZSBtZW1vcnkgbWFwcGluZwo+ICAgKiBA
ZmlsZTogdm1hLT52bV9maWxlIGZvciB0aGUgbWFwcGluZwo+ICAgKiBAb2Zmc2V0OiBtYXBwaW5n
IG9mZnNldCBpbiB0aGUgdm1fZmlsZQo+ICAgKi8KPiBAQCAtMTY1LDEwICsxNjUsMTYgQEAgc3Ry
dWN0IHZkcGFfbWFwX2ZpbGUgewo+ICAgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQHZk
ZXY6IHZkcGEgZGV2aWNlCj4gICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBAaWR4OiB2
aXJ0cXVldWUgaW5kZXgKPiAgICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIEBzdGF0ZTog
cG9pbnRlciB0byByZXR1cm5lZCBzdGF0ZSAobGFzdF9hdmFpbF9pZHgpCj4gKyAqIEBnZXRfdmVu
ZG9yX3ZxX3N0YXRzOiAgICAgICBHZXQgdGhlIHZlbmRvciBzdGF0aXN0aWNzIG9mIGEgZGV2aWNl
Lgo+ICsgKiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQHZkZXY6IHZkcGEgZGV2aWNlCj4g
KyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBAaWR4OiB2aXJ0cXVldWUgaW5kZXgKPiAr
ICogICAgICAgICAgICAgICAgICAgICAgICAgICAgIEBtc2c6IHNvY2tldCBidWZmZXIgaG9sZGlu
ZyBzdGF0cyBtZXNzYWdlCj4gKyAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBAZXh0YWNr
OiBleHRhY2sgZm9yIHJlcG9ydGluZyBlcnJvciBtZXNzYWdlcwo+ICsgKiAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgUmV0dXJucyBpbnRlZ2VyOiBzdWNjZXNzICgwKSBvciBlcnJvciAoPCAw
KQo+ICAgKiBAZ2V0X3ZxX25vdGlmaWNhdGlvbjogICAgICAgR2V0IHRoZSBub3RpZmljYXRpb24g
YXJlYSBmb3IgYSB2aXJ0cXVldWUgKG9wdGlvbmFsKQo+ICAgKiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgQHZkZXY6IHZkcGEgZGV2aWNlCj4gICAqICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBAaWR4OiB2aXJ0cXVldWUgaW5kZXgKPiAtICogICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFJldHVybnMgdGhlIG5vdGlmY2F0aW9uIGFyZWEKPiArICogICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFJldHVybnMgdGhlIG5vdGlmaWNhdGlvbiBhcmVhCj4gICAqIEBnZXRfdnFfaXJx
OiAgICAgICAgICAgICAgICAgICAgICAgIEdldCB0aGUgaXJxIG51bWJlciBvZiBhIHZpcnRxdWV1
ZSAob3B0aW9uYWwsCj4gICAqICAgICAgICAgICAgICAgICAgICAgICAgICAgICBidXQgbXVzdCBp
bXBsZW1lbnRlZCBpZiByZXF1aXJlIHZxIGlycSBvZmZsb2FkaW5nKQo+ICAgKiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgQHZkZXY6IHZkcGEgZGV2aWNlCj4gQEAgLTUwNiw2ICs1MTIsOCBA
QCBzdHJ1Y3QgdmRwYV9tZ210ZGV2X29wcyB7Cj4gICAqIEBjb25maWdfYXR0cl9tYXNrOiBiaXQg
bWFzayBvZiBhdHRyaWJ1dGVzIG9mIHR5cGUgZW51bSB2ZHBhX2F0dHIgdGhhdAo+ICAgKiAgICAg
ICAgICAgICAgICAgICBtYW5hZ2VtZW50IGRldmljZSBzdXBwb3J0IGR1cmluZyBkZXZfYWRkIGNh
bGxiYWNrCj4gICAqIEBsaXN0OiBsaXN0IGVudHJ5Cj4gKyAqIEBzdXBwb3J0ZWRfZmVhdHVyZXM6
IGZlYXR1cmVzIHN1cHBvcnRlZCBieSBkZXZpY2UKPiArICogQG1heF9zdXBwb3J0ZWRfdnFzOiBt
YXhpbXVtIG51bWJlciBvZiB2aXJ0cXVldWVzIHN1cHBvcnRlZCBieSBkZXZpY2UKPiAgICovCj4g
IHN0cnVjdCB2ZHBhX21nbXRfZGV2IHsKPiAgICAgICAgIHN0cnVjdCBkZXZpY2UgKmRldmljZTsK
Pgo+IC0tCj4gMi4zMC4yCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0
cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcv
bWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
