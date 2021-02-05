Return-Path: <SRS0=ITlz=HH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5F11C433DB
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 14:11:42 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1739465037
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 14:11:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1739465037
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 9B5AD86B23;
	Fri,  5 Feb 2021 14:11:41 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zDIyOxM7IrC0; Fri,  5 Feb 2021 14:11:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id AF9EC845D1;
	Fri,  5 Feb 2021 14:11:39 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8A844C0174;
	Fri,  5 Feb 2021 14:11:39 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0C11BC013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 14:11:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id E46B78727D
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 14:11:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id AU9z6pBhREeu
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 14:11:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 5ABB68727B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 14:11:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612534295;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5zJF7iuXnudexlnvrDsie00riA//JRoTFejPvAO5inY=;
 b=NUscHmKqOMcytcFkNoFh/+J9jHFBaHSxDxX4VBJMbOKyUD932PCmmOw7NP9gAhU5fIURy2
 aQ/oKEqBpX3SMKQPxHc84wRAhQiwbcUXUF6AWmUEbjBpLPoRVCpSHjMfeDDcuEX6rq+4jq
 by6+P4I9nh/LcGC+BQVTBd4PF/YIk1s=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-393-f5qbm9_mPz-MgG7lXEzSYw-1; Fri, 05 Feb 2021 09:11:32 -0500
X-MC-Unique: f5qbm9_mPz-MgG7lXEzSYw-1
Received: by mail-wr1-f70.google.com with SMTP id c1so5496925wrx.2
 for <virtualization@lists.linux-foundation.org>;
 Fri, 05 Feb 2021 06:11:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=5zJF7iuXnudexlnvrDsie00riA//JRoTFejPvAO5inY=;
 b=ZFl59iHPu3iXUj/Pn4XLgpAlPWRe6B0V4gOViSpAj5lQDXWki2fdjt7CfinNOq9TIW
 qcZJZZor6PdrCHbKKiaF5/xA526r1l/ZuQDr29lQDL9w8JoHo2iPfdaudAEFc776gwsq
 MQOF1wHbHpovFoQGnRJ3/KwnLOSULjMdow52PoFvYv6mCcinLKnSvoK3kt9WYANAvKkg
 d94KDiQivkB6RtYY8sDXMhgJTGOu/oWiWcQpqXl7PSO0vaTxQClpGN/Z51zz97+tYCSc
 FplaLjWE7uL5zgBWzAkxdJFpW2NioNEtVkWGxkH8cC8OplxrjiJVv4buwTNQIDIToAPT
 B4hA==
X-Gm-Message-State: AOAM533zkwvp27C59zOYJO9N9HcmKWNZ9lf3VieKLV0IdI7I9Zmu51Kx
 h3bVd/7eK8lowXWdfYIE8oDNldTCAeKAfQu6Bf+4ny/O4CWVLV6XJG/d5NwQfROb1k0g3JpuvzU
 LIaePXgx0IrzSeiiXIOXl0j03Ux7XWeYlmKcLJQOEHQ==
X-Received: by 2002:a1c:2ed4:: with SMTP id u203mr3822677wmu.45.1612534291427; 
 Fri, 05 Feb 2021 06:11:31 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzSg+HHzDXB2BGX+TaLFCEKbGu1PNRXWRqnpd7Z4UyG/TKgPiXwo7pDwidZbOFLUx261YnLyg==
X-Received: by 2002:a1c:2ed4:: with SMTP id u203mr3822642wmu.45.1612534291150; 
 Fri, 05 Feb 2021 06:11:31 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id a16sm12668023wrr.89.2021.02.05.06.11.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Feb 2021 06:11:30 -0800 (PST)
Date: Fri, 5 Feb 2021 09:11:26 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v3 08/13] vdpa: add return value to get_config/set_config
 callbacks
Message-ID: <20210205091123-mutt-send-email-mst@kernel.org>
References: <20210204172230.85853-1-sgarzare@redhat.com>
 <20210204172230.85853-9-sgarzare@redhat.com>
 <fe6d02be-b6f9-b07f-a86b-97912dddffdc@redhat.com>
 <20210205084847.d4pkqq2sbqs3p53r@steredhat>
MIME-Version: 1.0
In-Reply-To: <20210205084847.d4pkqq2sbqs3p53r@steredhat>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eli Cohen <elic@nvidia.com>
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

T24gRnJpLCBGZWIgMDUsIDIwMjEgYXQgMDk6NDg6NDdBTSArMDEwMCwgU3RlZmFubyBHYXJ6YXJl
bGxhIHdyb3RlOgo+IEFkZGluZyBFbGkgaW4gdGhlIGxvb3AuCj4gCj4gT24gRnJpLCBGZWIgMDUs
IDIwMjEgYXQgMTE6MjA6MTFBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+IAo+ID4gT24g
MjAyMS8yLzUg5LiK5Y2IMToyMiwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+ID4gPiBBbGwg
aW1wbGVtZW50YXRpb25zIG9mIHRoZXNlIGNhbGxiYWNrcyBhbHJlYWR5IHZhbGlkYXRlIGlucHV0
cy4KPiA+ID4gCj4gPiA+IExldCdzIHJldHVybiBhbiBlcnJvciBmcm9tIHRoZXNlIGNhbGxiYWNr
cywgc28gdGhlIGNhbGxlciBkb2Vzbid0Cj4gPiA+IG5lZWQgdG8gdmFsaWRhdGUgdGhlIGlucHV0
IGFueW1vcmUuCj4gPiA+IAo+ID4gPiBXZSB1cGRhdGUgYWxsIGltcGxlbWVudGF0aW9ucyB0byBy
ZXR1cm4gLUVJTlZBTCBpbiBjYXNlIG9mIGludmFsaWQKPiA+ID4gaW5wdXQuCj4gPiA+IAo+ID4g
PiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+
Cj4gPiA+IC0tLQo+ID4gPiAgaW5jbHVkZS9saW51eC92ZHBhLmggICAgICAgICAgICAgIHwgMTgg
KysrKysrKysrKy0tLS0tLS0tCj4gPiA+ICBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5j
ICAgfCAyNCArKysrKysrKysrKysrKysrLS0tLS0tLS0KPiA+ID4gIGRyaXZlcnMvdmRwYS9tbHg1
L25ldC9tbHg1X3ZuZXQuYyB8IDE3ICsrKysrKysrKysrLS0tLS0tCj4gPiA+ICBkcml2ZXJzL3Zk
cGEvdmRwYV9zaW0vdmRwYV9zaW0uYyAgfCAxNiArKysrKysrKysrLS0tLS0tCj4gPiA+ICA0IGZp
bGVzIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKyksIDI4IGRlbGV0aW9ucygtKQo+ID4gPiAKPiA+
ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmRwYS5oIGIvaW5jbHVkZS9saW51eC92ZHBh
LmgKPiA+ID4gaW5kZXggNGFiNTQ5NDUwM2E4Li4wZTBjYmQ1ZmI0MWIgMTAwNjQ0Cj4gPiA+IC0t
LSBhL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gPiA+ICsrKyBiL2luY2x1ZGUvbGludXgvdmRwYS5o
Cj4gPiA+IEBAIC0xNTcsNiArMTU3LDcgQEAgc3RydWN0IHZkcGFfaW92YV9yYW5nZSB7Cj4gPiA+
ICAgKgkJCQlAYnVmOiBidWZmZXIgdXNlZCB0byByZWFkIHRvCj4gPiA+ICAgKgkJCQlAbGVuOiB0
aGUgbGVuZ3RoIHRvIHJlYWQgZnJvbQo+ID4gPiAgICoJCQkJY29uZmlndXJhdGlvbiBzcGFjZQo+
ID4gPiArICoJCQkJUmV0dXJucyBpbnRlZ2VyOiBzdWNjZXNzICgwKSBvciBlcnJvciAoPCAwKQo+
ID4gPiAgICogQHNldF9jb25maWc6CQkJV3JpdGUgdG8gZGV2aWNlIHNwZWNpZmljIGNvbmZpZ3Vy
YXRpb24gc3BhY2UKPiA+ID4gICAqCQkJCUB2ZGV2OiB2ZHBhIGRldmljZQo+ID4gPiAgICoJCQkJ
QG9mZnNldDogb2Zmc2V0IGZyb20gdGhlIGJlZ2lubmluZyBvZgo+ID4gPiBAQCAtMTY0LDYgKzE2
NSw3IEBAIHN0cnVjdCB2ZHBhX2lvdmFfcmFuZ2Ugewo+ID4gPiAgICoJCQkJQGJ1ZjogYnVmZmVy
IHVzZWQgdG8gd3JpdGUgZnJvbQo+ID4gPiAgICoJCQkJQGxlbjogdGhlIGxlbmd0aCB0byB3cml0
ZSB0bwo+ID4gPiAgICoJCQkJY29uZmlndXJhdGlvbiBzcGFjZQo+ID4gPiArICoJCQkJUmV0dXJu
cyBpbnRlZ2VyOiBzdWNjZXNzICgwKSBvciBlcnJvciAoPCAwKQo+ID4gPiAgICogQGdldF9nZW5l
cmF0aW9uOgkJR2V0IGRldmljZSBjb25maWcgZ2VuZXJhdGlvbiAob3B0aW9uYWwpCj4gPiA+ICAg
KgkJCQlAdmRldjogdmRwYSBkZXZpY2UKPiA+ID4gICAqCQkJCVJldHVybnMgdTMyOiBkZXZpY2Ug
Z2VuZXJhdGlvbgo+ID4gPiBAQCAtMjMxLDEwICsyMzMsMTAgQEAgc3RydWN0IHZkcGFfY29uZmln
X29wcyB7Cj4gPiA+ICAJdTMyICgqZ2V0X3ZlbmRvcl9pZCkoc3RydWN0IHZkcGFfZGV2aWNlICp2
ZGV2KTsKPiA+ID4gIAl1OCAoKmdldF9zdGF0dXMpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldik7
Cj4gPiA+ICAJdm9pZCAoKnNldF9zdGF0dXMpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTgg
c3RhdHVzKTsKPiA+ID4gLQl2b2lkICgqZ2V0X2NvbmZpZykoc3RydWN0IHZkcGFfZGV2aWNlICp2
ZGV2LCB1bnNpZ25lZCBpbnQgb2Zmc2V0LAo+ID4gPiAtCQkJICAgdm9pZCAqYnVmLCB1bnNpZ25l
ZCBpbnQgbGVuKTsKPiA+ID4gLQl2b2lkICgqc2V0X2NvbmZpZykoc3RydWN0IHZkcGFfZGV2aWNl
ICp2ZGV2LCB1bnNpZ25lZCBpbnQgb2Zmc2V0LAo+ID4gPiAtCQkJICAgY29uc3Qgdm9pZCAqYnVm
LCB1bnNpZ25lZCBpbnQgbGVuKTsKPiA+ID4gKwlpbnQgKCpnZXRfY29uZmlnKShzdHJ1Y3QgdmRw
YV9kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGludCBvZmZzZXQsCj4gPiA+ICsJCQkgIHZvaWQgKmJ1
ZiwgdW5zaWduZWQgaW50IGxlbik7Cj4gPiA+ICsJaW50ICgqc2V0X2NvbmZpZykoc3RydWN0IHZk
cGFfZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBpbnQgb2Zmc2V0LAo+ID4gPiArCQkJICBjb25zdCB2
b2lkICpidWYsIHVuc2lnbmVkIGludCBsZW4pOwo+ID4gPiAgCXUzMiAoKmdldF9nZW5lcmF0aW9u
KShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpOwo+ID4gPiAgCXN0cnVjdCB2ZHBhX2lvdmFfcmFu
Z2UgKCpnZXRfaW92YV9yYW5nZSkoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KTsKPiA+ID4gQEAg
LTMyOSw4ICszMzEsOCBAQCBzdGF0aWMgaW5saW5lIGludCB2ZHBhX3NldF9mZWF0dXJlcyhzdHJ1
Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHU2NCBmZWF0dXJlcykKPiA+ID4gIH0KPiA+ID4gLXN0YXRp
YyBpbmxpbmUgdm9pZCB2ZHBhX2dldF9jb25maWcoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1
bnNpZ25lZCBvZmZzZXQsCj4gPiA+IC0JCQkJICAgdm9pZCAqYnVmLCB1bnNpZ25lZCBpbnQgbGVu
KQo+ID4gPiArc3RhdGljIGlubGluZSBpbnQgdmRwYV9nZXRfY29uZmlnKHN0cnVjdCB2ZHBhX2Rl
dmljZSAqdmRldiwgdW5zaWduZWQgb2Zmc2V0LAo+ID4gPiArCQkJCSAgdm9pZCAqYnVmLCB1bnNp
Z25lZCBpbnQgbGVuKQo+ID4gPiAgewo+ID4gPiAgICAgICAgICBjb25zdCBzdHJ1Y3QgdmRwYV9j
b25maWdfb3BzICpvcHMgPSB2ZGV2LT5jb25maWc7Cj4gPiA+IEBAIC0zMzksOCArMzQxLDggQEAg
c3RhdGljIGlubGluZSB2b2lkIHZkcGFfZ2V0X2NvbmZpZyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZk
ZXYsIHVuc2lnbmVkIG9mZnNldCwKPiA+ID4gIAkgKiBJZiBpdCBkb2VzIGhhcHBlbiB3ZSBhc3N1
bWUgYSBsZWdhY3kgZ3Vlc3QuCj4gPiA+ICAJICovCj4gPiA+ICAJaWYgKCF2ZGV2LT5mZWF0dXJl
c192YWxpZCkKPiA+ID4gLQkJdmRwYV9zZXRfZmVhdHVyZXModmRldiwgMCk7Cj4gPiA+IC0Jb3Bz
LT5nZXRfY29uZmlnKHZkZXYsIG9mZnNldCwgYnVmLCBsZW4pOwo+ID4gPiArCQlyZXR1cm4gdmRw
YV9zZXRfZmVhdHVyZXModmRldiwgMCk7Cj4gPiA+ICsJcmV0dXJuIG9wcy0+Z2V0X2NvbmZpZyh2
ZGV2LCBvZmZzZXQsIGJ1ZiwgbGVuKTsKPiA+ID4gIH0KPiA+ID4gIC8qKgo+ID4gPiBkaWZmIC0t
Z2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyBiL2RyaXZlcnMvdmRwYS9pZmN2
Zi9pZmN2Zl9tYWluLmMKPiA+ID4gaW5kZXggN2M4YmJmY2Y2YzNlLi5mNWU2YTkwZDgxMTQgMTAw
NjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMKPiA+ID4gKysr
IGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+ID4gPiBAQCAtMzMyLDI0ICszMzIs
MzIgQEAgc3RhdGljIHUzMiBpZmN2Zl92ZHBhX2dldF92cV9hbGlnbihzdHJ1Y3QgdmRwYV9kZXZp
Y2UgKnZkcGFfZGV2KQo+ID4gPiAgCXJldHVybiBJRkNWRl9RVUVVRV9BTElHTk1FTlQ7Cj4gPiA+
ICB9Cj4gPiA+IC1zdGF0aWMgdm9pZCBpZmN2Zl92ZHBhX2dldF9jb25maWcoc3RydWN0IHZkcGFf
ZGV2aWNlICp2ZHBhX2RldiwKPiA+ID4gLQkJCQkgIHVuc2lnbmVkIGludCBvZmZzZXQsCj4gPiA+
IC0JCQkJICB2b2lkICpidWYsIHVuc2lnbmVkIGludCBsZW4pCj4gPiA+ICtzdGF0aWMgaW50IGlm
Y3ZmX3ZkcGFfZ2V0X2NvbmZpZyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2LAo+ID4gPiAr
CQkJCSB1bnNpZ25lZCBpbnQgb2Zmc2V0LAo+ID4gPiArCQkJCSB2b2lkICpidWYsIHVuc2lnbmVk
IGludCBsZW4pCj4gPiA+ICB7Cj4gPiA+ICAJc3RydWN0IGlmY3ZmX2h3ICp2ZiA9IHZkcGFfdG9f
dmYodmRwYV9kZXYpOwo+ID4gPiAtCVdBUk5fT04ob2Zmc2V0ICsgbGVuID4gc2l6ZW9mKHN0cnVj
dCB2aXJ0aW9fbmV0X2NvbmZpZykpOwo+ID4gPiArCWlmIChvZmZzZXQgKyBsZW4gPiBzaXplb2Yo
c3RydWN0IHZpcnRpb19uZXRfY29uZmlnKSkKPiA+ID4gKwkJcmV0dXJuIC1FSU5WQUw7Cj4gPiA+
ICsKPiA+ID4gIAlpZmN2Zl9yZWFkX25ldF9jb25maWcodmYsIG9mZnNldCwgYnVmLCBsZW4pOwo+
ID4gPiArCj4gPiA+ICsJcmV0dXJuIDA7Cj4gPiA+ICB9Cj4gPiA+IC1zdGF0aWMgdm9pZCBpZmN2
Zl92ZHBhX3NldF9jb25maWcoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2RldiwKPiA+ID4gLQkJ
CQkgIHVuc2lnbmVkIGludCBvZmZzZXQsIGNvbnN0IHZvaWQgKmJ1ZiwKPiA+ID4gLQkJCQkgIHVu
c2lnbmVkIGludCBsZW4pCj4gPiA+ICtzdGF0aWMgaW50IGlmY3ZmX3ZkcGFfc2V0X2NvbmZpZyhz
dHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2LAo+ID4gPiArCQkJCSB1bnNpZ25lZCBpbnQgb2Zm
c2V0LCBjb25zdCB2b2lkICpidWYsCj4gPiA+ICsJCQkJIHVuc2lnbmVkIGludCBsZW4pCj4gPiA+
ICB7Cj4gPiA+ICAJc3RydWN0IGlmY3ZmX2h3ICp2ZiA9IHZkcGFfdG9fdmYodmRwYV9kZXYpOwo+
ID4gPiAtCVdBUk5fT04ob2Zmc2V0ICsgbGVuID4gc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fbmV0X2Nv
bmZpZykpOwo+ID4gPiArCWlmIChvZmZzZXQgKyBsZW4gPiBzaXplb2Yoc3RydWN0IHZpcnRpb19u
ZXRfY29uZmlnKSkKPiA+ID4gKwkJcmV0dXJuIC1FSU5WQUw7Cj4gPiA+ICsKPiA+ID4gIAlpZmN2
Zl93cml0ZV9uZXRfY29uZmlnKHZmLCBvZmZzZXQsIGJ1ZiwgbGVuKTsKPiA+ID4gKwo+ID4gPiAr
CXJldHVybiAwOwo+ID4gPiAgfQo+ID4gPiAgc3RhdGljIHZvaWQgaWZjdmZfdmRwYV9zZXRfY29u
ZmlnX2NiKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYsCj4gPiA+IGRpZmYgLS1naXQgYS9k
cml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQv
bWx4NV92bmV0LmMKPiA+ID4gaW5kZXggMDI5ODIyMDYwMDE3Li45MzIzYjVmZjc5ODggMTAwNjQ0
Cj4gPiA+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+ID4gPiArKysg
Yi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+ID4gQEAgLTE3OTYsMjAgKzE3
OTYsMjUgQEAgc3RhdGljIHZvaWQgbWx4NV92ZHBhX3NldF9zdGF0dXMoc3RydWN0IHZkcGFfZGV2
aWNlICp2ZGV2LCB1OCBzdGF0dXMpCj4gPiA+ICAJbmRldi0+bXZkZXYuc3RhdHVzIHw9IFZJUlRJ
T19DT05GSUdfU19GQUlMRUQ7Cj4gPiA+ICB9Cj4gPiA+IC1zdGF0aWMgdm9pZCBtbHg1X3ZkcGFf
Z2V0X2NvbmZpZyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHVuc2lnbmVkIGludCBvZmZzZXQs
IHZvaWQgKmJ1ZiwKPiA+ID4gLQkJCQkgdW5zaWduZWQgaW50IGxlbikKPiA+ID4gK3N0YXRpYyBp
bnQgbWx4NV92ZHBhX2dldF9jb25maWcoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1bnNpZ25l
ZCBpbnQgb2Zmc2V0LCB2b2lkICpidWYsCj4gPiA+ICsJCQkJdW5zaWduZWQgaW50IGxlbikKPiA+
ID4gIHsKPiA+ID4gIAlzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYgPSB0b19tdmRldih2ZGV2
KTsKPiA+ID4gIAlzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiA9IHRvX21seDVfdmRwYV9uZGV2
KG12ZGV2KTsKPiA+ID4gLQlpZiAob2Zmc2V0ICsgbGVuIDwgc2l6ZW9mKHN0cnVjdCB2aXJ0aW9f
bmV0X2NvbmZpZykpCj4gPiA+IC0JCW1lbWNweShidWYsICh1OCAqKSZuZGV2LT5jb25maWcgKyBv
ZmZzZXQsIGxlbik7Cj4gPiA+ICsJaWYgKG9mZnNldCArIGxlbiA+IHNpemVvZihzdHJ1Y3Qgdmly
dGlvX25ldF9jb25maWcpKQo+ID4gPiArCQlyZXR1cm4gLUVJTlZBTDsKPiA+IAo+ID4gCj4gPiBJ
dCBsb29rcyB0byBtZSB3ZSBzaG91bGQgdXNlICI+PSIgaGVyZT8KPiAKPiAKPiBFaG1tLCBJIHRo
aW5rIGl0IHdhcyB3cm9uZyBiZWZvcmUgdGhpcyBwYXRjaC4gSWYgJ29mZnNldCArIGxlbicgaXMg
ZXF1YWwgdG8KPiAnc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZpZyknLCBzaG91bGQgYmUg
b2theSB0byBjb3B5LCBubz8KPiAKPiBJIHRoaW5rIGl0J3Mgb25lIG9mIHRoZSByYXJlIGNhc2Vz
IHdoZXJlIHRoZSBjb3B5IGFuZCBwYXN0ZSB3ZW50IHdlbGwgOi0pCj4gCj4gU2hvdWxkIEkgZml4
IHRoaXMgaW4gYSBzZXBhcmF0ZSBwYXRjaD8KPiAKPiBUaGFua3MsCj4gU3RlZmFubwoKU3VyZS4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
