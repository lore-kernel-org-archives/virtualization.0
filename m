Return-Path: <SRS0=ITlz=HH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE401C433E0
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 08:48:59 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EB4E61606
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 08:48:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB4E61606
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id D461386CF4;
	Fri,  5 Feb 2021 08:48:58 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g9+yKda-Rfd6; Fri,  5 Feb 2021 08:48:57 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 9FFB686CEC;
	Fri,  5 Feb 2021 08:48:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 87A23C0174;
	Fri,  5 Feb 2021 08:48:57 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 8C172C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 08:48:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 732888730C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 08:48:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rxfN-MuBWyyB
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 08:48:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 7207F87306
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 08:48:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612514934;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qats9+82wU3qAY98Gc8MG/7rmEQkf2rmw/ej3jR/AJc=;
 b=XypyhtmAmQ4TCemYg+lSNakBi1jEoOVm2z+xyGN9OjIr2+bOlhe+7GcnyDK13daySLtH4J
 41LD7jiEm2Hl8sJNjST7khCIbx5j3yqsENdkH7pcJhp6ectkktzq9SC3zn4Bqbn/xk0PIG
 DDwyocUHXCB1byFZcQ9FEM4scJSPM3w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-rCRz6zcHOkiF_FWJL3c4Aw-1; Fri, 05 Feb 2021 03:48:52 -0500
X-MC-Unique: rCRz6zcHOkiF_FWJL3c4Aw-1
Received: by mail-wm1-f69.google.com with SMTP id s10so2712887wme.8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 05 Feb 2021 00:48:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=qats9+82wU3qAY98Gc8MG/7rmEQkf2rmw/ej3jR/AJc=;
 b=hzTUpty0UdYd99i0guxGLanjYl6b8tvJwq1Fui5RITeHUjuI1R5o739W2feB1BT8I/
 u9PNfHfcE5nP1yUCGWLAd/OIrkugCQzlCRSP5FKjIXRo17g4zm9VO68+giBYayVAdGgY
 Ca1bHiduQZbQf7ItCjRmoBEdqClUXE4eMpmK96Kd5XdNEItCtV2yk6pjPjG3Wz4LZike
 rAcWKx2jg/fQswzDqixh0mEnLzH9baKbWd3IalJgMZfPpAJ+GZTHMHY8NLxcrLDlZ3EP
 /Hjcr8ZRBarMUWUwALYMUWyfidxNr1cRm1IDN8q9H5qEYawwN8yEABKWrZkzG3yE56S8
 sYGQ==
X-Gm-Message-State: AOAM532S+7SCVTqAvJtF1+59HYC0914+nMse3wMI1H/uaJrLgx0oHpvm
 Zm6318BxuxrCSinuHLxhChwvUNsev252B2E7ZeUgYPf8xfa+sE/gfyr6pHyT8qpvwbGd1tsHAx+
 IClcNxS3umibdArzA5vc4sdvOGx3C2ngaMSrrdLVTow==
X-Received: by 2002:a5d:6712:: with SMTP id o18mr3603974wru.375.1612514931189; 
 Fri, 05 Feb 2021 00:48:51 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzCQqPTFZtarTI+RyF/EcK9EX3zDigmzlWkyGFPbLEWf1RVHsZ2nDDpeNiO5e/Z/sg+KIrizQ==
X-Received: by 2002:a5d:6712:: with SMTP id o18mr3603950wru.375.1612514930954; 
 Fri, 05 Feb 2021 00:48:50 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id o9sm11859486wrw.81.2021.02.05.00.48.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Feb 2021 00:48:50 -0800 (PST)
Date: Fri, 5 Feb 2021 09:48:47 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>, Eli Cohen <elic@nvidia.com>
Subject: Re: [PATCH v3 08/13] vdpa: add return value to get_config/set_config
 callbacks
Message-ID: <20210205084847.d4pkqq2sbqs3p53r@steredhat>
References: <20210204172230.85853-1-sgarzare@redhat.com>
 <20210204172230.85853-9-sgarzare@redhat.com>
 <fe6d02be-b6f9-b07f-a86b-97912dddffdc@redhat.com>
MIME-Version: 1.0
In-Reply-To: <fe6d02be-b6f9-b07f-a86b-97912dddffdc@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>
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

QWRkaW5nIEVsaSBpbiB0aGUgbG9vcC4KCk9uIEZyaSwgRmViIDA1LCAyMDIxIGF0IDExOjIwOjEx
QU0gKzA4MDAsIEphc29uIFdhbmcgd3JvdGU6Cj4KPk9uIDIwMjEvMi81IOS4iuWNiDE6MjIsIFN0
ZWZhbm8gR2FyemFyZWxsYSB3cm90ZToKPj5BbGwgaW1wbGVtZW50YXRpb25zIG9mIHRoZXNlIGNh
bGxiYWNrcyBhbHJlYWR5IHZhbGlkYXRlIGlucHV0cy4KPj4KPj5MZXQncyByZXR1cm4gYW4gZXJy
b3IgZnJvbSB0aGVzZSBjYWxsYmFja3MsIHNvIHRoZSBjYWxsZXIgZG9lc24ndAo+Pm5lZWQgdG8g
dmFsaWRhdGUgdGhlIGlucHV0IGFueW1vcmUuCj4+Cj4+V2UgdXBkYXRlIGFsbCBpbXBsZW1lbnRh
dGlvbnMgdG8gcmV0dXJuIC1FSU5WQUwgaW4gY2FzZSBvZiBpbnZhbGlkCj4+aW5wdXQuCj4+Cj4+
U2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgo+
Pi0tLQo+PiAgaW5jbHVkZS9saW51eC92ZHBhLmggICAgICAgICAgICAgIHwgMTggKysrKysrKysr
Ky0tLS0tLS0tCj4+ICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jICAgfCAyNCArKysr
KysrKysrKysrKysrLS0tLS0tLS0KPj4gIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQu
YyB8IDE3ICsrKysrKysrKysrLS0tLS0tCj4+ICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9z
aW0uYyAgfCAxNiArKysrKysrKysrLS0tLS0tCj4+ICA0IGZpbGVzIGNoYW5nZWQsIDQ3IGluc2Vy
dGlvbnMoKyksIDI4IGRlbGV0aW9ucygtKQo+Pgo+PmRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L3ZkcGEuaCBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4+aW5kZXggNGFiNTQ5NDUwM2E4Li4wZTBj
YmQ1ZmI0MWIgMTAwNjQ0Cj4+LS0tIGEvaW5jbHVkZS9saW51eC92ZHBhLmgKPj4rKysgYi9pbmNs
dWRlL2xpbnV4L3ZkcGEuaAo+PkBAIC0xNTcsNiArMTU3LDcgQEAgc3RydWN0IHZkcGFfaW92YV9y
YW5nZSB7Cj4+ICAgKgkJCQlAYnVmOiBidWZmZXIgdXNlZCB0byByZWFkIHRvCj4+ICAgKgkJCQlA
bGVuOiB0aGUgbGVuZ3RoIHRvIHJlYWQgZnJvbQo+PiAgICoJCQkJY29uZmlndXJhdGlvbiBzcGFj
ZQo+PisgKgkJCQlSZXR1cm5zIGludGVnZXI6IHN1Y2Nlc3MgKDApIG9yIGVycm9yICg8IDApCj4+
ICAgKiBAc2V0X2NvbmZpZzoJCQlXcml0ZSB0byBkZXZpY2Ugc3BlY2lmaWMgY29uZmlndXJhdGlv
biBzcGFjZQo+PiAgICoJCQkJQHZkZXY6IHZkcGEgZGV2aWNlCj4+ICAgKgkJCQlAb2Zmc2V0OiBv
ZmZzZXQgZnJvbSB0aGUgYmVnaW5uaW5nIG9mCj4+QEAgLTE2NCw2ICsxNjUsNyBAQCBzdHJ1Y3Qg
dmRwYV9pb3ZhX3JhbmdlIHsKPj4gICAqCQkJCUBidWY6IGJ1ZmZlciB1c2VkIHRvIHdyaXRlIGZy
b20KPj4gICAqCQkJCUBsZW46IHRoZSBsZW5ndGggdG8gd3JpdGUgdG8KPj4gICAqCQkJCWNvbmZp
Z3VyYXRpb24gc3BhY2UKPj4rICoJCQkJUmV0dXJucyBpbnRlZ2VyOiBzdWNjZXNzICgwKSBvciBl
cnJvciAoPCAwKQo+PiAgICogQGdldF9nZW5lcmF0aW9uOgkJR2V0IGRldmljZSBjb25maWcgZ2Vu
ZXJhdGlvbiAob3B0aW9uYWwpCj4+ICAgKgkJCQlAdmRldjogdmRwYSBkZXZpY2UKPj4gICAqCQkJ
CVJldHVybnMgdTMyOiBkZXZpY2UgZ2VuZXJhdGlvbgo+PkBAIC0yMzEsMTAgKzIzMywxMCBAQCBz
dHJ1Y3QgdmRwYV9jb25maWdfb3BzIHsKPj4gIAl1MzIgKCpnZXRfdmVuZG9yX2lkKShzdHJ1Y3Qg
dmRwYV9kZXZpY2UgKnZkZXYpOwo+PiAgCXU4ICgqZ2V0X3N0YXR1cykoc3RydWN0IHZkcGFfZGV2
aWNlICp2ZGV2KTsKPj4gIAl2b2lkICgqc2V0X3N0YXR1cykoc3RydWN0IHZkcGFfZGV2aWNlICp2
ZGV2LCB1OCBzdGF0dXMpOwo+Pi0Jdm9pZCAoKmdldF9jb25maWcpKHN0cnVjdCB2ZHBhX2Rldmlj
ZSAqdmRldiwgdW5zaWduZWQgaW50IG9mZnNldCwKPj4tCQkJICAgdm9pZCAqYnVmLCB1bnNpZ25l
ZCBpbnQgbGVuKTsKPj4tCXZvaWQgKCpzZXRfY29uZmlnKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZk
ZXYsIHVuc2lnbmVkIGludCBvZmZzZXQsCj4+LQkJCSAgIGNvbnN0IHZvaWQgKmJ1ZiwgdW5zaWdu
ZWQgaW50IGxlbik7Cj4+KwlpbnQgKCpnZXRfY29uZmlnKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZk
ZXYsIHVuc2lnbmVkIGludCBvZmZzZXQsCj4+KwkJCSAgdm9pZCAqYnVmLCB1bnNpZ25lZCBpbnQg
bGVuKTsKPj4rCWludCAoKnNldF9jb25maWcpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdW5z
aWduZWQgaW50IG9mZnNldCwKPj4rCQkJICBjb25zdCB2b2lkICpidWYsIHVuc2lnbmVkIGludCBs
ZW4pOwo+PiAgCXUzMiAoKmdldF9nZW5lcmF0aW9uKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYp
Owo+PiAgCXN0cnVjdCB2ZHBhX2lvdmFfcmFuZ2UgKCpnZXRfaW92YV9yYW5nZSkoc3RydWN0IHZk
cGFfZGV2aWNlICp2ZGV2KTsKPj5AQCAtMzI5LDggKzMzMSw4IEBAIHN0YXRpYyBpbmxpbmUgaW50
IHZkcGFfc2V0X2ZlYXR1cmVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTY0IGZlYXR1cmVz
KQo+PiAgfQo+Pi1zdGF0aWMgaW5saW5lIHZvaWQgdmRwYV9nZXRfY29uZmlnKHN0cnVjdCB2ZHBh
X2RldmljZSAqdmRldiwgdW5zaWduZWQgb2Zmc2V0LAo+Pi0JCQkJICAgdm9pZCAqYnVmLCB1bnNp
Z25lZCBpbnQgbGVuKQo+PitzdGF0aWMgaW5saW5lIGludCB2ZHBhX2dldF9jb25maWcoc3RydWN0
IHZkcGFfZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBvZmZzZXQsCj4+KwkJCQkgIHZvaWQgKmJ1Ziwg
dW5zaWduZWQgaW50IGxlbikKPj4gIHsKPj4gICAgICAgICAgY29uc3Qgc3RydWN0IHZkcGFfY29u
ZmlnX29wcyAqb3BzID0gdmRldi0+Y29uZmlnOwo+PkBAIC0zMzksOCArMzQxLDggQEAgc3RhdGlj
IGlubGluZSB2b2lkIHZkcGFfZ2V0X2NvbmZpZyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHVu
c2lnbmVkIG9mZnNldCwKPj4gIAkgKiBJZiBpdCBkb2VzIGhhcHBlbiB3ZSBhc3N1bWUgYSBsZWdh
Y3kgZ3Vlc3QuCj4+ICAJICovCj4+ICAJaWYgKCF2ZGV2LT5mZWF0dXJlc192YWxpZCkKPj4tCQl2
ZHBhX3NldF9mZWF0dXJlcyh2ZGV2LCAwKTsKPj4tCW9wcy0+Z2V0X2NvbmZpZyh2ZGV2LCBvZmZz
ZXQsIGJ1ZiwgbGVuKTsKPj4rCQlyZXR1cm4gdmRwYV9zZXRfZmVhdHVyZXModmRldiwgMCk7Cj4+
KwlyZXR1cm4gb3BzLT5nZXRfY29uZmlnKHZkZXYsIG9mZnNldCwgYnVmLCBsZW4pOwo+PiAgfQo+
PiAgLyoqCj4+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMgYi9k
cml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jCj4+aW5kZXggN2M4YmJmY2Y2YzNlLi5mNWU2
YTkwZDgxMTQgMTAwNjQ0Cj4+LS0tIGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+
PisrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPj5AQCAtMzMyLDI0ICszMzIs
MzIgQEAgc3RhdGljIHUzMiBpZmN2Zl92ZHBhX2dldF92cV9hbGlnbihzdHJ1Y3QgdmRwYV9kZXZp
Y2UgKnZkcGFfZGV2KQo+PiAgCXJldHVybiBJRkNWRl9RVUVVRV9BTElHTk1FTlQ7Cj4+ICB9Cj4+
LXN0YXRpYyB2b2lkIGlmY3ZmX3ZkcGFfZ2V0X2NvbmZpZyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZk
cGFfZGV2LAo+Pi0JCQkJICB1bnNpZ25lZCBpbnQgb2Zmc2V0LAo+Pi0JCQkJICB2b2lkICpidWYs
IHVuc2lnbmVkIGludCBsZW4pCj4+K3N0YXRpYyBpbnQgaWZjdmZfdmRwYV9nZXRfY29uZmlnKHN0
cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYsCj4+KwkJCQkgdW5zaWduZWQgaW50IG9mZnNldCwK
Pj4rCQkJCSB2b2lkICpidWYsIHVuc2lnbmVkIGludCBsZW4pCj4+ICB7Cj4+ICAJc3RydWN0IGlm
Y3ZmX2h3ICp2ZiA9IHZkcGFfdG9fdmYodmRwYV9kZXYpOwo+Pi0JV0FSTl9PTihvZmZzZXQgKyBs
ZW4gPiBzaXplb2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnKSk7Cj4+KwlpZiAob2Zmc2V0ICsg
bGVuID4gc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZykpCj4+KwkJcmV0dXJuIC1FSU5W
QUw7Cj4+Kwo+PiAgCWlmY3ZmX3JlYWRfbmV0X2NvbmZpZyh2Ziwgb2Zmc2V0LCBidWYsIGxlbik7
Cj4+Kwo+PisJcmV0dXJuIDA7Cj4+ICB9Cj4+LXN0YXRpYyB2b2lkIGlmY3ZmX3ZkcGFfc2V0X2Nv
bmZpZyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2LAo+Pi0JCQkJICB1bnNpZ25lZCBpbnQg
b2Zmc2V0LCBjb25zdCB2b2lkICpidWYsCj4+LQkJCQkgIHVuc2lnbmVkIGludCBsZW4pCj4+K3N0
YXRpYyBpbnQgaWZjdmZfdmRwYV9zZXRfY29uZmlnKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9k
ZXYsCj4+KwkJCQkgdW5zaWduZWQgaW50IG9mZnNldCwgY29uc3Qgdm9pZCAqYnVmLAo+PisJCQkJ
IHVuc2lnbmVkIGludCBsZW4pCj4+ICB7Cj4+ICAJc3RydWN0IGlmY3ZmX2h3ICp2ZiA9IHZkcGFf
dG9fdmYodmRwYV9kZXYpOwo+Pi0JV0FSTl9PTihvZmZzZXQgKyBsZW4gPiBzaXplb2Yoc3RydWN0
IHZpcnRpb19uZXRfY29uZmlnKSk7Cj4+KwlpZiAob2Zmc2V0ICsgbGVuID4gc2l6ZW9mKHN0cnVj
dCB2aXJ0aW9fbmV0X2NvbmZpZykpCj4+KwkJcmV0dXJuIC1FSU5WQUw7Cj4+Kwo+PiAgCWlmY3Zm
X3dyaXRlX25ldF9jb25maWcodmYsIG9mZnNldCwgYnVmLCBsZW4pOwo+PisKPj4rCXJldHVybiAw
Owo+PiAgfQo+PiAgc3RhdGljIHZvaWQgaWZjdmZfdmRwYV9zZXRfY29uZmlnX2NiKHN0cnVjdCB2
ZHBhX2RldmljZSAqdmRwYV9kZXYsCj4+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25l
dC9tbHg1X3ZuZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+PmluZGV4
IDAyOTgyMjA2MDAxNy4uOTMyM2I1ZmY3OTg4IDEwMDY0NAo+Pi0tLSBhL2RyaXZlcnMvdmRwYS9t
bHg1L25ldC9tbHg1X3ZuZXQuYwo+PisrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3Zu
ZXQuYwo+PkBAIC0xNzk2LDIwICsxNzk2LDI1IEBAIHN0YXRpYyB2b2lkIG1seDVfdmRwYV9zZXRf
c3RhdHVzKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTggc3RhdHVzKQo+PiAgCW5kZXYtPm12
ZGV2LnN0YXR1cyB8PSBWSVJUSU9fQ09ORklHX1NfRkFJTEVEOwo+PiAgfQo+Pi1zdGF0aWMgdm9p
ZCBtbHg1X3ZkcGFfZ2V0X2NvbmZpZyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHVuc2lnbmVk
IGludCBvZmZzZXQsIHZvaWQgKmJ1ZiwKPj4tCQkJCSB1bnNpZ25lZCBpbnQgbGVuKQo+PitzdGF0
aWMgaW50IG1seDVfdmRwYV9nZXRfY29uZmlnKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdW5z
aWduZWQgaW50IG9mZnNldCwgdm9pZCAqYnVmLAo+PisJCQkJdW5zaWduZWQgaW50IGxlbikKPj4g
IHsKPj4gIAlzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYgPSB0b19tdmRldih2ZGV2KTsKPj4g
IAlzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiA9IHRvX21seDVfdmRwYV9uZGV2KG12ZGV2KTsK
Pj4tCWlmIChvZmZzZXQgKyBsZW4gPCBzaXplb2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnKSkK
Pj4tCQltZW1jcHkoYnVmLCAodTggKikmbmRldi0+Y29uZmlnICsgb2Zmc2V0LCBsZW4pOwo+PisJ
aWYgKG9mZnNldCArIGxlbiA+IHNpemVvZihzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcpKQo+PisJ
CXJldHVybiAtRUlOVkFMOwo+Cj4KPkl0IGxvb2tzIHRvIG1lIHdlIHNob3VsZCB1c2UgIj49IiBo
ZXJlPwoKCkVobW0sIEkgdGhpbmsgaXQgd2FzIHdyb25nIGJlZm9yZSB0aGlzIHBhdGNoLiBJZiAn
b2Zmc2V0ICsgbGVuJyBpcyBlcXVhbCAKdG8gJ3NpemVvZihzdHJ1Y3QgdmlydGlvX25ldF9jb25m
aWcpJywgc2hvdWxkIGJlIG9rYXkgdG8gY29weSwgbm8/CgpJIHRoaW5rIGl0J3Mgb25lIG9mIHRo
ZSByYXJlIGNhc2VzIHdoZXJlIHRoZSBjb3B5IGFuZCBwYXN0ZSB3ZW50IHdlbGwgCjotKQoKU2hv
dWxkIEkgZml4IHRoaXMgaW4gYSBzZXBhcmF0ZSBwYXRjaD8KClRoYW5rcywKU3RlZmFubwoKX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRp
b24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3Jn
Cmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1
YWxpemF0aW9u
