Return-Path: <SRS0=ow7J=HD=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A87C433DB
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 10:23:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2EB6F64DB2
	for <virtualization@archiver.kernel.org>; Mon,  1 Feb 2021 10:23:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2EB6F64DB2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id C96CE8623E;
	Mon,  1 Feb 2021 10:23:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nN8e-F3BQEX2; Mon,  1 Feb 2021 10:23:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4A8788624A;
	Mon,  1 Feb 2021 10:23:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 30943C0174;
	Mon,  1 Feb 2021 10:23:30 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3CEC8C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 10:23:29 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id 1E12A20406
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 10:23:29 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4b1tasaqSDnv
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 10:23:27 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 83AC020109
 for <virtualization@lists.linux-foundation.org>;
 Mon,  1 Feb 2021 10:23:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612175006;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=P3maFpmEyWTTIxJdB5XqMO6xuqP9Omhc7XlJTDFaYw0=;
 b=ZVm24BRa0jYW6CFsLw9y527DAPr0Dx/YLxBjDeHKw3pJKZjOTQtIMUu7TxeSCrhwWWPIYh
 PrNK7v/zdjS1bf7isjve5M4hAk5lMPvIjRzJQkXO9F3cKyPbwrshK9YzzPT2mbD89KGd4X
 Sl+234IGOMjJnF3Gb2x3M+RPzgsR2WQ=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-593-czcjhYvsOcat254m3oaB-w-1; Mon, 01 Feb 2021 05:23:24 -0500
X-MC-Unique: czcjhYvsOcat254m3oaB-w-1
Received: by mail-wm1-f70.google.com with SMTP id k64so4607796wmb.6
 for <virtualization@lists.linux-foundation.org>;
 Mon, 01 Feb 2021 02:23:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=P3maFpmEyWTTIxJdB5XqMO6xuqP9Omhc7XlJTDFaYw0=;
 b=uQHnFmOnXP0JCvpLZgm3fz1EUU64zIo2m4B1U+mPOS8vkECjGGn2EoUk9SPlbud/aQ
 aG0MAC8shtdlANNOj5PpQrufihqqu0pgZeIAW7UkAjGR/xrtO/OH8TdZn98InmC+1B1L
 KakjsiAr98alfrcWqsmK5W1ddNcOLJLXDL2LD5LkbJyQ+NSBxga764+h+Vk3s1wQyYUD
 F0jWiVyg581wDMGy9zhVR3lUzsVlKTYx/tTFFb8EYLGfpz2rCQMBG6iswaqYEb7L2nRm
 S2UsvJ6UPSOZwDnmjkVrvL3CD3y+X9id9mQFu+gER2EgaFh/qyG31jfKPjmFmnrAMg1v
 mz9g==
X-Gm-Message-State: AOAM533CxLhgBcM6zijC++Nwl+SnWTeLXIV0EuwuxyAEkKRJFq0B9hH4
 pY9HmaTif0Qp561zIe3uOx0kIHBXibLH7am+M9qrnHzM5gHCX2euIK2JM8zfnIr0UiDgynnBV9o
 kDGLN7LSB6ITiv/GgXeCHJWw0PTtyBS+saz4IdpxqcA==
X-Received: by 2002:a05:600c:154c:: with SMTP id
 f12mr14733440wmg.40.1612175003526; 
 Mon, 01 Feb 2021 02:23:23 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwV/0SDXh0y/M5k5EK03Sm9O7AP+3Ymc68INpoLqvlEB+qZ48bkqmuuTgVUacF0hlX4wt0Axw==
X-Received: by 2002:a05:600c:154c:: with SMTP id
 f12mr14733418wmg.40.1612175003301; 
 Mon, 01 Feb 2021 02:23:23 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id a17sm23415082wrx.63.2021.02.01.02.23.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Feb 2021 02:23:22 -0800 (PST)
Date: Mon, 1 Feb 2021 11:23:20 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC v2 04/10] vringh: implement vringh_kiov_advance()
Message-ID: <20210201102320.rk77l2aus3ku4ezz@steredhat>
References: <20210128144127.113245-1-sgarzare@redhat.com>
 <20210128144127.113245-5-sgarzare@redhat.com>
 <78247eb0-8e6e-f2fa-a693-1b0f14db61dd@redhat.com>
MIME-Version: 1.0
In-Reply-To: <78247eb0-8e6e-f2fa-a693-1b0f14db61dd@redhat.com>
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

T24gTW9uLCBGZWIgMDEsIDIwMjEgYXQgMDE6NDM6MjNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMS8xLzI4IOS4i+WNiDEwOjQxLCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6
Cj4+SW4gc29tZSBjYXNlcywgaXQgbWF5IGJlIHVzZWZ1bCB0byBwcm92aWRlIGEgd2F5IHRvIHNr
aXAgYSBudW1iZXIKPj5vZiBieXRlcyBpbiBhIHZyaW5naF9raW92Lgo+Pgo+PkxldCdzIGltcGxl
bWVudCB2cmluZ2hfa2lvdl9hZHZhbmNlKCkgZm9yIHRoaXMgcHVycG9zZSwgcmV1c2luZyB0aGUK
Pj5jb2RlIGZyb20gdnJpbmdoX2lvdl94ZmVyKCkuCj4+V2UgcmVwbGFjZSB0aGF0IGNvZGUgY2Fs
bGluZyB0aGUgbmV3IHZyaW5naF9raW92X2FkdmFuY2UoKS4KPgo+Cj5BY2tlZC1ieTogSmFzb24g
V2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPgo+SW4gdGhlIGxvbmcgcnVuIHdlIG5lZWQgdG8g
c3dpdGNoIHRvIHVzZSBpb3YgaXRlcmF0b3IgbGlicmFyeSBpbnN0ZWFkLgoKWWVzIEkgYWdyZWUu
CkkndmUgdHJpZWQgdG8gZG8gdGhpcywgYnV0IGl0IHJlcXVpcmVzIHF1aXRlIGEgYml0IG9mIHdv
cmsgdG8gY2hhbmdlIAp2cmluZ2gsIEknbGwgcHV0IGl0IG9uIG15IHRvZG8gbGlzdC4KClRoYW5r
cywKU3RlZmFubwoKPgo+VGhhbmtzCj4KPgo+Pgo+PlNpZ25lZC1vZmYtYnk6IFN0ZWZhbm8gR2Fy
emFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4KPj4tLS0KPj4gIGluY2x1ZGUvbGludXgvdnJp
bmdoLmggfCAgMiArKwo+PiAgZHJpdmVycy92aG9zdC92cmluZ2guYyB8IDQxICsrKysrKysrKysr
KysrKysrKysrKysrKysrKysrLS0tLS0tLS0tLS0tCj4+ICAyIGZpbGVzIGNoYW5nZWQsIDMxIGlu
c2VydGlvbnMoKyksIDEyIGRlbGV0aW9ucygtKQo+Pgo+PmRpZmYgLS1naXQgYS9pbmNsdWRlL2xp
bnV4L3ZyaW5naC5oIGIvaW5jbHVkZS9saW51eC92cmluZ2guaAo+PmluZGV4IDljMDc3ODYzYzhm
Ni4uNzU1MjExZWJkMTk1IDEwMDY0NAo+Pi0tLSBhL2luY2x1ZGUvbGludXgvdnJpbmdoLmgKPj4r
KysgYi9pbmNsdWRlL2xpbnV4L3ZyaW5naC5oCj4+QEAgLTE5OSw2ICsxOTksOCBAQCBzdGF0aWMg
aW5saW5lIHZvaWQgdnJpbmdoX2tpb3ZfY2xlYW51cChzdHJ1Y3QgdnJpbmdoX2tpb3YgKmtpb3Yp
Cj4+ICAJa2lvdi0+aW92ID0gTlVMTDsKPj4gIH0KPj4rdm9pZCB2cmluZ2hfa2lvdl9hZHZhbmNl
KHN0cnVjdCB2cmluZ2hfa2lvdiAqa2lvdiwgc2l6ZV90IGxlbik7Cj4+Kwo+PiAgaW50IHZyaW5n
aF9nZXRkZXNjX2tlcm4oc3RydWN0IHZyaW5naCAqdnJoLAo+PiAgCQkJc3RydWN0IHZyaW5naF9r
aW92ICpyaW92LAo+PiAgCQkJc3RydWN0IHZyaW5naF9raW92ICp3aW92LAo+PmRpZmYgLS1naXQg
YS9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jIGIvZHJpdmVycy92aG9zdC92cmluZ2guYwo+PmluZGV4
IGJlZTYzZDY4MjAxYS4uNGQ4MDBlNGYzMWNhIDEwMDY0NAo+Pi0tLSBhL2RyaXZlcnMvdmhvc3Qv
dnJpbmdoLmMKPj4rKysgYi9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jCj4+QEAgLTc1LDYgKzc1LDM0
IEBAIHN0YXRpYyBpbmxpbmUgaW50IF9fdnJpbmdoX2dldF9oZWFkKGNvbnN0IHN0cnVjdCB2cmlu
Z2ggKnZyaCwKPj4gIAlyZXR1cm4gaGVhZDsKPj4gIH0KPj4rLyoqCj4+KyAqIHZyaW5naF9raW92
X2FkdmFuY2UgLSBza2lwIGJ5dGVzIGZyb20gdnJpbmdfa2lvdgo+PisgKiBAaW92OiBhbiBpb3Yg
cGFzc2VkIHRvIHZyaW5naF9nZXRkZXNjXyooKSAodXBkYXRlZCBhcyB3ZSBjb25zdW1lKQo+Pisg
KiBAbGVuOiB0aGUgbWF4aW11bSBsZW5ndGggdG8gYWR2YW5jZQo+PisgKi8KPj4rdm9pZCB2cmlu
Z2hfa2lvdl9hZHZhbmNlKHN0cnVjdCB2cmluZ2hfa2lvdiAqaW92LCBzaXplX3QgbGVuKQo+Pit7
Cj4+Kwl3aGlsZSAobGVuICYmIGlvdi0+aSA8IGlvdi0+dXNlZCkgewo+PisJCXNpemVfdCBwYXJ0
bGVuID0gbWluKGlvdi0+aW92W2lvdi0+aV0uaW92X2xlbiwgbGVuKTsKPj4rCj4+KwkJaW92LT5j
b25zdW1lZCArPSBwYXJ0bGVuOwo+PisJCWlvdi0+aW92W2lvdi0+aV0uaW92X2xlbiAtPSBwYXJ0
bGVuOwo+PisJCWlvdi0+aW92W2lvdi0+aV0uaW92X2Jhc2UgKz0gcGFydGxlbjsKPj4rCj4+KwkJ
aWYgKCFpb3YtPmlvdltpb3YtPmldLmlvdl9sZW4pIHsKPj4rCQkJLyogRml4IHVwIG9sZCBpb3Yg
ZWxlbWVudCB0aGVuIGluY3JlbWVudC4gKi8KPj4rCQkJaW92LT5pb3ZbaW92LT5pXS5pb3ZfbGVu
ID0gaW92LT5jb25zdW1lZDsKPj4rCQkJaW92LT5pb3ZbaW92LT5pXS5pb3ZfYmFzZSAtPSBpb3Yt
PmNvbnN1bWVkOwo+PisKPj4rCQkJaW92LT5jb25zdW1lZCA9IDA7Cj4+KwkJCWlvdi0+aSsrOwo+
PisJCX0KPj4rCj4+KwkJbGVuIC09IHBhcnRsZW47Cj4+Kwl9Cj4+K30KPj4rRVhQT1JUX1NZTUJP
TCh2cmluZ2hfa2lvdl9hZHZhbmNlKTsKPj4rCj4+ICAvKiBDb3B5IHNvbWUgYnl0ZXMgdG8vZnJv
bSB0aGUgaW92ZWMuICBSZXR1cm5zIG51bSBjb3BpZWQuICovCj4+ICBzdGF0aWMgaW5saW5lIHNz
aXplX3QgdnJpbmdoX2lvdl94ZmVyKHN0cnVjdCB2cmluZ2ggKnZyaCwKPj4gIAkJCQkgICAgICBz
dHJ1Y3QgdnJpbmdoX2tpb3YgKmlvdiwKPj5AQCAtOTUsMTkgKzEyMyw4IEBAIHN0YXRpYyBpbmxp
bmUgc3NpemVfdCB2cmluZ2hfaW92X3hmZXIoc3RydWN0IHZyaW5naCAqdnJoLAo+PiAgCQlkb25l
ICs9IHBhcnRsZW47Cj4+ICAJCWxlbiAtPSBwYXJ0bGVuOwo+PiAgCQlwdHIgKz0gcGFydGxlbjsK
Pj4tCQlpb3YtPmNvbnN1bWVkICs9IHBhcnRsZW47Cj4+LQkJaW92LT5pb3ZbaW92LT5pXS5pb3Zf
bGVuIC09IHBhcnRsZW47Cj4+LQkJaW92LT5pb3ZbaW92LT5pXS5pb3ZfYmFzZSArPSBwYXJ0bGVu
Owo+Pi0JCWlmICghaW92LT5pb3ZbaW92LT5pXS5pb3ZfbGVuKSB7Cj4+LQkJCS8qIEZpeCB1cCBv
bGQgaW92IGVsZW1lbnQgdGhlbiBpbmNyZW1lbnQuICovCj4+LQkJCWlvdi0+aW92W2lvdi0+aV0u
aW92X2xlbiA9IGlvdi0+Y29uc3VtZWQ7Cj4+LQkJCWlvdi0+aW92W2lvdi0+aV0uaW92X2Jhc2Ug
LT0gaW92LT5jb25zdW1lZDsKPj4tCj4+LQkJCQo+Pi0JCQlpb3YtPmNvbnN1bWVkID0gMDsKPj4t
CQkJaW92LT5pKys7Cj4+LQkJfQo+PisJCXZyaW5naF9raW92X2FkdmFuY2UoaW92LCBwYXJ0bGVu
KTsKPj4gIAl9Cj4+ICAJcmV0dXJuIGRvbmU7Cj4+ICB9Cj4KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
