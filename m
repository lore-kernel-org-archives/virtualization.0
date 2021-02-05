Return-Path: <SRS0=ITlz=HH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B754BC433E0
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 14:18:04 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3B1A5650CD
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 14:18:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3B1A5650CD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id DCDFB870A4;
	Fri,  5 Feb 2021 14:18:03 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4AACgu9CJaIi; Fri,  5 Feb 2021 14:18:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 268B587276;
	Fri,  5 Feb 2021 14:18:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1089DC0174;
	Fri,  5 Feb 2021 14:18:03 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91E1BC013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 14:18:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 8D84C87365
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 14:18:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Q2jAMxS8lPVM
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 14:18:01 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6A7798735B
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 14:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612534680;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OO/Z9Pbt3ecs88CwJUi87r2qp3LeYfy2PFUUcweybu4=;
 b=SE8kkk9FzLy5t3dfYDpEcEYULPQiF7Ht2rnvYqJHQuF/47LFTn6ah0eI7GZMIEx7rCFjhO
 t/thTwOHJVgj0qXeLkFfu+3V/5zMSiA0w5Tq4nmEKfRCws0Ac8VdXaQmEF4Leq4f3bOESt
 O1lbd6mPwdJ10o+ycksmUxyZRTXv4tQ=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-469-jI2rBP_DOW-TJr_2nQSvqg-1; Fri, 05 Feb 2021 09:17:58 -0500
X-MC-Unique: jI2rBP_DOW-TJr_2nQSvqg-1
Received: by mail-wr1-f69.google.com with SMTP id l13so5408447wrq.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 05 Feb 2021 06:17:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=OO/Z9Pbt3ecs88CwJUi87r2qp3LeYfy2PFUUcweybu4=;
 b=TnqXasWxKxBRBJkXk6wne+ERxd2qGLIpRykw/BNdqRmROlE2jEbDbWJk4QOPhMLEeA
 GvVW0pOM+CNJFOVx3DZZpvyjXPiQ1xYc3YkfcoQDyhxf8eTRV05wKsJOVJ/dviIDWOEi
 BzP1sFLtdkTFFKwmAHxueHYpT4V3xZPvLKQh86wnmfzxU4KzinsFG5BmCVzIj9FFk3YI
 RUXq71hdKIULYy4T9aP3O7kP6rKuBT9Kz/cfvHQQG01SAXvk+nTqEt+0Q3PqnCP9Crpk
 68ZvKmq563YOq1bTLVUDUtAPs2qxXVRR1Sshu32HgDarbgOdhUCDPUymvg7+TKG414yL
 MzyQ==
X-Gm-Message-State: AOAM532ShXF+Go98of6bUy+k3SOZp8tXt3/XAbUtj+xpSRHx8e7wtkDI
 yv+V4tk8AEyw8QuZCXkHPZgNdmSunkfxWpnS/kOMhK+FPsSpVev2EeIBTd+OoVRihORw6licNtt
 d9fNwYxpwBxlFte1JOQYnAdRzn6nHQPATtauYnL7y/w==
X-Received: by 2002:a5d:6b47:: with SMTP id x7mr5469513wrw.170.1612534677385; 
 Fri, 05 Feb 2021 06:17:57 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzhXbMuzW+9lf4mHkd5Twhn2KBAz8ru70DzypAHZB3/V1aKyI0GBYXHQZ9Aqaw239oEpTOgNw==
X-Received: by 2002:a5d:6b47:: with SMTP id x7mr5469488wrw.170.1612534677136; 
 Fri, 05 Feb 2021 06:17:57 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id n9sm12749550wrq.41.2021.02.05.06.17.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Feb 2021 06:17:56 -0800 (PST)
Date: Fri, 5 Feb 2021 15:17:54 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 08/13] vdpa: add return value to get_config/set_config
 callbacks
Message-ID: <20210205141754.cyp4q77cqrj4xx7p@steredhat>
References: <20210204172230.85853-1-sgarzare@redhat.com>
 <20210204172230.85853-9-sgarzare@redhat.com>
 <fe6d02be-b6f9-b07f-a86b-97912dddffdc@redhat.com>
 <20210205084847.d4pkqq2sbqs3p53r@steredhat>
 <20210205091123-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210205091123-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gRnJpLCBGZWIgMDUsIDIwMjEgYXQgMDk6MTE6MjZBTSAtMDUwMCwgTWljaGFlbCBTLiBUc2ly
a2luIHdyb3RlOgo+T24gRnJpLCBGZWIgMDUsIDIwMjEgYXQgMDk6NDg6NDdBTSArMDEwMCwgU3Rl
ZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+PiBBZGRpbmcgRWxpIGluIHRoZSBsb29wLgo+Pgo+PiBP
biBGcmksIEZlYiAwNSwgMjAyMSBhdCAxMToyMDoxMUFNICswODAwLCBKYXNvbiBXYW5nIHdyb3Rl
Ogo+PiA+Cj4+ID4gT24gMjAyMS8yLzUg5LiK5Y2IMToyMiwgU3RlZmFubyBHYXJ6YXJlbGxhIHdy
b3RlOgo+PiA+ID4gQWxsIGltcGxlbWVudGF0aW9ucyBvZiB0aGVzZSBjYWxsYmFja3MgYWxyZWFk
eSB2YWxpZGF0ZSBpbnB1dHMuCj4+ID4gPgo+PiA+ID4gTGV0J3MgcmV0dXJuIGFuIGVycm9yIGZy
b20gdGhlc2UgY2FsbGJhY2tzLCBzbyB0aGUgY2FsbGVyIGRvZXNuJ3QKPj4gPiA+IG5lZWQgdG8g
dmFsaWRhdGUgdGhlIGlucHV0IGFueW1vcmUuCj4+ID4gPgo+PiA+ID4gV2UgdXBkYXRlIGFsbCBp
bXBsZW1lbnRhdGlvbnMgdG8gcmV0dXJuIC1FSU5WQUwgaW4gY2FzZSBvZiBpbnZhbGlkCj4+ID4g
PiBpbnB1dC4KPj4gPiA+Cj4+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEg
PHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4+ID4gPiAtLS0KPj4gPiA+ICBpbmNsdWRlL2xpbnV4L3Zk
cGEuaCAgICAgICAgICAgICAgfCAxOCArKysrKysrKysrLS0tLS0tLS0KPj4gPiA+ICBkcml2ZXJz
L3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jICAgfCAyNCArKysrKysrKysrKysrKysrLS0tLS0tLS0K
Pj4gPiA+ICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgfCAxNyArKysrKysrKysr
Ky0tLS0tLQo+PiA+ID4gIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jICB8IDE2ICsr
KysrKysrKystLS0tLS0KPj4gPiA+ICA0IGZpbGVzIGNoYW5nZWQsIDQ3IGluc2VydGlvbnMoKyks
IDI4IGRlbGV0aW9ucygtKQo+PiA+ID4KPj4gPiA+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4
L3ZkcGEuaCBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4+ID4gPiBpbmRleCA0YWI1NDk0NTAzYTgu
LjBlMGNiZDVmYjQxYiAxMDA2NDQKPj4gPiA+IC0tLSBhL2luY2x1ZGUvbGludXgvdmRwYS5oCj4+
ID4gPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+PiA+ID4gQEAgLTE1Nyw2ICsxNTcsNyBA
QCBzdHJ1Y3QgdmRwYV9pb3ZhX3JhbmdlIHsKPj4gPiA+ICAgKgkJCQlAYnVmOiBidWZmZXIgdXNl
ZCB0byByZWFkIHRvCj4+ID4gPiAgICoJCQkJQGxlbjogdGhlIGxlbmd0aCB0byByZWFkIGZyb20K
Pj4gPiA+ICAgKgkJCQljb25maWd1cmF0aW9uIHNwYWNlCj4+ID4gPiArICoJCQkJUmV0dXJucyBp
bnRlZ2VyOiBzdWNjZXNzICgwKSBvciBlcnJvciAoPCAwKQo+PiA+ID4gICAqIEBzZXRfY29uZmln
OgkJCVdyaXRlIHRvIGRldmljZSBzcGVjaWZpYyBjb25maWd1cmF0aW9uIHNwYWNlCj4+ID4gPiAg
ICoJCQkJQHZkZXY6IHZkcGEgZGV2aWNlCj4+ID4gPiAgICoJCQkJQG9mZnNldDogb2Zmc2V0IGZy
b20gdGhlIGJlZ2lubmluZyBvZgo+PiA+ID4gQEAgLTE2NCw2ICsxNjUsNyBAQCBzdHJ1Y3QgdmRw
YV9pb3ZhX3JhbmdlIHsKPj4gPiA+ICAgKgkJCQlAYnVmOiBidWZmZXIgdXNlZCB0byB3cml0ZSBm
cm9tCj4+ID4gPiAgICoJCQkJQGxlbjogdGhlIGxlbmd0aCB0byB3cml0ZSB0bwo+PiA+ID4gICAq
CQkJCWNvbmZpZ3VyYXRpb24gc3BhY2UKPj4gPiA+ICsgKgkJCQlSZXR1cm5zIGludGVnZXI6IHN1
Y2Nlc3MgKDApIG9yIGVycm9yICg8IDApCj4+ID4gPiAgICogQGdldF9nZW5lcmF0aW9uOgkJR2V0
IGRldmljZSBjb25maWcgZ2VuZXJhdGlvbiAob3B0aW9uYWwpCj4+ID4gPiAgICoJCQkJQHZkZXY6
IHZkcGEgZGV2aWNlCj4+ID4gPiAgICoJCQkJUmV0dXJucyB1MzI6IGRldmljZSBnZW5lcmF0aW9u
Cj4+ID4gPiBAQCAtMjMxLDEwICsyMzMsMTAgQEAgc3RydWN0IHZkcGFfY29uZmlnX29wcyB7Cj4+
ID4gPiAgCXUzMiAoKmdldF92ZW5kb3JfaWQpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldik7Cj4+
ID4gPiAgCXU4ICgqZ2V0X3N0YXR1cykoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2KTsKPj4gPiA+
ICAJdm9pZCAoKnNldF9zdGF0dXMpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTggc3RhdHVz
KTsKPj4gPiA+IC0Jdm9pZCAoKmdldF9jb25maWcpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwg
dW5zaWduZWQgaW50IG9mZnNldCwKPj4gPiA+IC0JCQkgICB2b2lkICpidWYsIHVuc2lnbmVkIGlu
dCBsZW4pOwo+PiA+ID4gLQl2b2lkICgqc2V0X2NvbmZpZykoc3RydWN0IHZkcGFfZGV2aWNlICp2
ZGV2LCB1bnNpZ25lZCBpbnQgb2Zmc2V0LAo+PiA+ID4gLQkJCSAgIGNvbnN0IHZvaWQgKmJ1Ziwg
dW5zaWduZWQgaW50IGxlbik7Cj4+ID4gPiArCWludCAoKmdldF9jb25maWcpKHN0cnVjdCB2ZHBh
X2RldmljZSAqdmRldiwgdW5zaWduZWQgaW50IG9mZnNldCwKPj4gPiA+ICsJCQkgIHZvaWQgKmJ1
ZiwgdW5zaWduZWQgaW50IGxlbik7Cj4+ID4gPiArCWludCAoKnNldF9jb25maWcpKHN0cnVjdCB2
ZHBhX2RldmljZSAqdmRldiwgdW5zaWduZWQgaW50IG9mZnNldCwKPj4gPiA+ICsJCQkgIGNvbnN0
IHZvaWQgKmJ1ZiwgdW5zaWduZWQgaW50IGxlbik7Cj4+ID4gPiAgCXUzMiAoKmdldF9nZW5lcmF0
aW9uKShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYpOwo+PiA+ID4gIAlzdHJ1Y3QgdmRwYV9pb3Zh
X3JhbmdlICgqZ2V0X2lvdmFfcmFuZ2UpKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldik7Cj4+ID4g
PiBAQCAtMzI5LDggKzMzMSw4IEBAIHN0YXRpYyBpbmxpbmUgaW50IHZkcGFfc2V0X2ZlYXR1cmVz
KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTY0IGZlYXR1cmVzKQo+PiA+ID4gIH0KPj4gPiA+
IC1zdGF0aWMgaW5saW5lIHZvaWQgdmRwYV9nZXRfY29uZmlnKHN0cnVjdCB2ZHBhX2RldmljZSAq
dmRldiwgdW5zaWduZWQgb2Zmc2V0LAo+PiA+ID4gLQkJCQkgICB2b2lkICpidWYsIHVuc2lnbmVk
IGludCBsZW4pCj4+ID4gPiArc3RhdGljIGlubGluZSBpbnQgdmRwYV9nZXRfY29uZmlnKHN0cnVj
dCB2ZHBhX2RldmljZSAqdmRldiwgdW5zaWduZWQgb2Zmc2V0LAo+PiA+ID4gKwkJCQkgIHZvaWQg
KmJ1ZiwgdW5zaWduZWQgaW50IGxlbikKPj4gPiA+ICB7Cj4+ID4gPiAgICAgICAgICBjb25zdCBz
dHJ1Y3QgdmRwYV9jb25maWdfb3BzICpvcHMgPSB2ZGV2LT5jb25maWc7Cj4+ID4gPiBAQCAtMzM5
LDggKzM0MSw4IEBAIHN0YXRpYyBpbmxpbmUgdm9pZCB2ZHBhX2dldF9jb25maWcoc3RydWN0IHZk
cGFfZGV2aWNlICp2ZGV2LCB1bnNpZ25lZCBvZmZzZXQsCj4+ID4gPiAgCSAqIElmIGl0IGRvZXMg
aGFwcGVuIHdlIGFzc3VtZSBhIGxlZ2FjeSBndWVzdC4KPj4gPiA+ICAJICovCj4+ID4gPiAgCWlm
ICghdmRldi0+ZmVhdHVyZXNfdmFsaWQpCj4+ID4gPiAtCQl2ZHBhX3NldF9mZWF0dXJlcyh2ZGV2
LCAwKTsKPj4gPiA+IC0Jb3BzLT5nZXRfY29uZmlnKHZkZXYsIG9mZnNldCwgYnVmLCBsZW4pOwo+
PiA+ID4gKwkJcmV0dXJuIHZkcGFfc2V0X2ZlYXR1cmVzKHZkZXYsIDApOwo+PiA+ID4gKwlyZXR1
cm4gb3BzLT5nZXRfY29uZmlnKHZkZXYsIG9mZnNldCwgYnVmLCBsZW4pOwo+PiA+ID4gIH0KPj4g
PiA+ICAvKioKPj4gPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFp
bi5jIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+PiA+ID4gaW5kZXggN2M4YmJm
Y2Y2YzNlLi5mNWU2YTkwZDgxMTQgMTAwNjQ0Cj4+ID4gPiAtLS0gYS9kcml2ZXJzL3ZkcGEvaWZj
dmYvaWZjdmZfbWFpbi5jCj4+ID4gPiArKysgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFp
bi5jCj4+ID4gPiBAQCAtMzMyLDI0ICszMzIsMzIgQEAgc3RhdGljIHUzMiBpZmN2Zl92ZHBhX2dl
dF92cV9hbGlnbihzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2KQo+PiA+ID4gIAlyZXR1cm4g
SUZDVkZfUVVFVUVfQUxJR05NRU5UOwo+PiA+ID4gIH0KPj4gPiA+IC1zdGF0aWMgdm9pZCBpZmN2
Zl92ZHBhX2dldF9jb25maWcoc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2RldiwKPj4gPiA+IC0J
CQkJICB1bnNpZ25lZCBpbnQgb2Zmc2V0LAo+PiA+ID4gLQkJCQkgIHZvaWQgKmJ1ZiwgdW5zaWdu
ZWQgaW50IGxlbikKPj4gPiA+ICtzdGF0aWMgaW50IGlmY3ZmX3ZkcGFfZ2V0X2NvbmZpZyhzdHJ1
Y3QgdmRwYV9kZXZpY2UgKnZkcGFfZGV2LAo+PiA+ID4gKwkJCQkgdW5zaWduZWQgaW50IG9mZnNl
dCwKPj4gPiA+ICsJCQkJIHZvaWQgKmJ1ZiwgdW5zaWduZWQgaW50IGxlbikKPj4gPiA+ICB7Cj4+
ID4gPiAgCXN0cnVjdCBpZmN2Zl9odyAqdmYgPSB2ZHBhX3RvX3ZmKHZkcGFfZGV2KTsKPj4gPiA+
IC0JV0FSTl9PTihvZmZzZXQgKyBsZW4gPiBzaXplb2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmln
KSk7Cj4+ID4gPiArCWlmIChvZmZzZXQgKyBsZW4gPiBzaXplb2Yoc3RydWN0IHZpcnRpb19uZXRf
Y29uZmlnKSkKPj4gPiA+ICsJCXJldHVybiAtRUlOVkFMOwo+PiA+ID4gKwo+PiA+ID4gIAlpZmN2
Zl9yZWFkX25ldF9jb25maWcodmYsIG9mZnNldCwgYnVmLCBsZW4pOwo+PiA+ID4gKwo+PiA+ID4g
KwlyZXR1cm4gMDsKPj4gPiA+ICB9Cj4+ID4gPiAtc3RhdGljIHZvaWQgaWZjdmZfdmRwYV9zZXRf
Y29uZmlnKHN0cnVjdCB2ZHBhX2RldmljZSAqdmRwYV9kZXYsCj4+ID4gPiAtCQkJCSAgdW5zaWdu
ZWQgaW50IG9mZnNldCwgY29uc3Qgdm9pZCAqYnVmLAo+PiA+ID4gLQkJCQkgIHVuc2lnbmVkIGlu
dCBsZW4pCj4+ID4gPiArc3RhdGljIGludCBpZmN2Zl92ZHBhX3NldF9jb25maWcoc3RydWN0IHZk
cGFfZGV2aWNlICp2ZHBhX2RldiwKPj4gPiA+ICsJCQkJIHVuc2lnbmVkIGludCBvZmZzZXQsIGNv
bnN0IHZvaWQgKmJ1ZiwKPj4gPiA+ICsJCQkJIHVuc2lnbmVkIGludCBsZW4pCj4+ID4gPiAgewo+
PiA+ID4gIAlzdHJ1Y3QgaWZjdmZfaHcgKnZmID0gdmRwYV90b192Zih2ZHBhX2Rldik7Cj4+ID4g
PiAtCVdBUk5fT04ob2Zmc2V0ICsgbGVuID4gc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fbmV0X2NvbmZp
ZykpOwo+PiA+ID4gKwlpZiAob2Zmc2V0ICsgbGVuID4gc2l6ZW9mKHN0cnVjdCB2aXJ0aW9fbmV0
X2NvbmZpZykpCj4+ID4gPiArCQlyZXR1cm4gLUVJTlZBTDsKPj4gPiA+ICsKPj4gPiA+ICAJaWZj
dmZfd3JpdGVfbmV0X2NvbmZpZyh2Ziwgb2Zmc2V0LCBidWYsIGxlbik7Cj4+ID4gPiArCj4+ID4g
PiArCXJldHVybiAwOwo+PiA+ID4gIH0KPj4gPiA+ICBzdGF0aWMgdm9pZCBpZmN2Zl92ZHBhX3Nl
dF9jb25maWdfY2Ioc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhX2RldiwKPj4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMgYi9kcml2ZXJzL3ZkcGEvbWx4
NS9uZXQvbWx4NV92bmV0LmMKPj4gPiA+IGluZGV4IDAyOTgyMjA2MDAxNy4uOTMyM2I1ZmY3OTg4
IDEwMDY0NAo+PiA+ID4gLS0tIGEvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4+
ID4gPiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4gPiA+IEBAIC0x
Nzk2LDIwICsxNzk2LDI1IEBAIHN0YXRpYyB2b2lkIG1seDVfdmRwYV9zZXRfc3RhdHVzKHN0cnVj
dCB2ZHBhX2RldmljZSAqdmRldiwgdTggc3RhdHVzKQo+PiA+ID4gIAluZGV2LT5tdmRldi5zdGF0
dXMgfD0gVklSVElPX0NPTkZJR19TX0ZBSUxFRDsKPj4gPiA+ICB9Cj4+ID4gPiAtc3RhdGljIHZv
aWQgbWx4NV92ZHBhX2dldF9jb25maWcoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1bnNpZ25l
ZCBpbnQgb2Zmc2V0LCB2b2lkICpidWYsCj4+ID4gPiAtCQkJCSB1bnNpZ25lZCBpbnQgbGVuKQo+
PiA+ID4gK3N0YXRpYyBpbnQgbWx4NV92ZHBhX2dldF9jb25maWcoc3RydWN0IHZkcGFfZGV2aWNl
ICp2ZGV2LCB1bnNpZ25lZCBpbnQgb2Zmc2V0LCB2b2lkICpidWYsCj4+ID4gPiArCQkJCXVuc2ln
bmVkIGludCBsZW4pCj4+ID4gPiAgewo+PiA+ID4gIAlzdHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZk
ZXYgPSB0b19tdmRldih2ZGV2KTsKPj4gPiA+ICAJc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYg
PSB0b19tbHg1X3ZkcGFfbmRldihtdmRldik7Cj4+ID4gPiAtCWlmIChvZmZzZXQgKyBsZW4gPCBz
aXplb2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnKSkKPj4gPiA+IC0JCW1lbWNweShidWYsICh1
OCAqKSZuZGV2LT5jb25maWcgKyBvZmZzZXQsIGxlbik7Cj4+ID4gPiArCWlmIChvZmZzZXQgKyBs
ZW4gPiBzaXplb2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnKSkKPj4gPiA+ICsJCXJldHVybiAt
RUlOVkFMOwo+PiA+Cj4+ID4KPj4gPiBJdCBsb29rcyB0byBtZSB3ZSBzaG91bGQgdXNlICI+PSIg
aGVyZT8KPj4KPj4KPj4gRWhtbSwgSSB0aGluayBpdCB3YXMgd3JvbmcgYmVmb3JlIHRoaXMgcGF0
Y2guIElmICdvZmZzZXQgKyBsZW4nIGlzIGVxdWFsIHRvCj4+ICdzaXplb2Yoc3RydWN0IHZpcnRp
b19uZXRfY29uZmlnKScsIHNob3VsZCBiZSBva2F5IHRvIGNvcHksIG5vPwo+Pgo+PiBJIHRoaW5r
IGl0J3Mgb25lIG9mIHRoZSByYXJlIGNhc2VzIHdoZXJlIHRoZSBjb3B5IGFuZCBwYXN0ZSB3ZW50
IHdlbGwgOi0pCj4+Cj4+IFNob3VsZCBJIGZpeCB0aGlzIGluIGEgc2VwYXJhdGUgcGF0Y2g/Cj4+
Cj4+IFRoYW5rcywKPj4gU3RlZmFubwo+Cj5TdXJlLgo+CgpJJ2xsIGRvIGl0LgoKVGhhbmtzLApT
dGVmYW5vCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpW
aXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91
bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlz
dGluZm8vdmlydHVhbGl6YXRpb24=
