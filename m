Return-Path: <SRS0=qiqk=DQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99E74C433DF
	for <virtualization@archiver.kernel.org>; Fri,  9 Oct 2020 07:00:39 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D20EB22248
	for <virtualization@archiver.kernel.org>; Fri,  9 Oct 2020 07:00:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ger9pOhD"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D20EB22248
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id ECC782E278;
	Fri,  9 Oct 2020 07:00:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id P3H3Kak1Fg2g; Fri,  9 Oct 2020 07:00:30 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 716652E279;
	Fri,  9 Oct 2020 07:00:28 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 563B0C07FF;
	Fri,  9 Oct 2020 07:00:28 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EA2D5C07FF
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 07:00:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id D6FC387674
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 07:00:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rB4ap20vfdVJ
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 07:00:25 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id ED1E287672
 for <virtualization@lists.linux-foundation.org>;
 Fri,  9 Oct 2020 07:00:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602226823;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GXty0grP7iFnbUH+QMsyFwyfvHHZk16B0G0LGpkyhew=;
 b=Ger9pOhDnia8s7yfIm+kfxncHLhHreOblue2TMcm6+AclsIK9mySRmYlMCXgGOJtJnPK+H
 kN9CjL5D45Dr+UD3+MeIGGqVI4CljoM1dZg3iCx0rWf3c1PacyKJPCVQSRQqtdXb1HtZ+C
 7l6AcV0lGRUZ/rgNW7YNztGXx48wiB8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-67-yIj0LUZEN7W0sDYbX5MQlg-1; Fri, 09 Oct 2020 03:00:22 -0400
X-MC-Unique: yIj0LUZEN7W0sDYbX5MQlg-1
Received: by mail-wm1-f71.google.com with SMTP id v14so3859170wmj.6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 09 Oct 2020 00:00:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=GXty0grP7iFnbUH+QMsyFwyfvHHZk16B0G0LGpkyhew=;
 b=pgh1e9/mDbnR9TikF62iGfcjV60e2hMgfm6oe+r92tcNSw3gAQQgNZmj9/uVV7w6+I
 NcR9vWzwo4kaIzG7YzGbUWgDPRMJVqaOeoaDNfK556UIgqkUG2prRHEDtXHTJmbK6/Im
 mDOC/o7lbKPqPb4Am5Jx1w/cFGNp0F4H89nHJQsXWVWmVfuzMFNg2tDOTg3SSDwuPaiZ
 nngbkysPqnVDhCkEDkKcVCvBFn1MORnuTVbni3ldDmHbUy0QLds7jdvwPCsDNmDn3qev
 81+njpGzz8NsWqzw6+6e9g6yrxvXFonIaOT3+cmOyUU2xlUarV7tF0Pgt9HSnc4lj3Zz
 Bt8Q==
X-Gm-Message-State: AOAM532Ke5M9pbNzWjEcul/xLMsejWHxiWTuFXY9hMp/QWfJZ9KwIGyv
 5MauapbqCyGoU0zo9EdqFPW4v4sI1OarE4/eI9n3ImR/kdT/+QGrAE3Khc7ID1Ew51e3dRspY3y
 BG6TtLZZ70BnASx91YVoetPIDhcPM2KgEveeiUADzkA==
X-Received: by 2002:a05:600c:21c3:: with SMTP id
 x3mr12206024wmj.81.1602226820728; 
 Fri, 09 Oct 2020 00:00:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxp7Lu/KmOA3fdiMHtLHOVmduGD0Yzn7NZXzdIik47vcv/WVxJcCv5AZmkOtGRqoqzzsmlj5Q==
X-Received: by 2002:a05:600c:21c3:: with SMTP id
 x3mr12205994wmj.81.1602226820381; 
 Fri, 09 Oct 2020 00:00:20 -0700 (PDT)
Received: from steredhat (host-79-27-201-176.retail.telecomitalia.it.
 [79.27.201.176])
 by smtp.gmail.com with ESMTPSA id k8sm10070788wrl.42.2020.10.09.00.00.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 09 Oct 2020 00:00:19 -0700 (PDT)
Date: Fri, 9 Oct 2020 09:00:17 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2] vringh: fix __vringh_iov() when riov and wiov are
 different
Message-ID: <20201009070017.shdcumaifllakfrb@steredhat>
References: <20201008204256.162292-1-sgarzare@redhat.com>
 <8d84abcb-2f2e-8f24-039f-447e8686b878@redhat.com>
MIME-Version: 1.0
In-Reply-To: <8d84abcb-2f2e-8f24-039f-447e8686b878@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org
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

T24gRnJpLCBPY3QgMDksIDIwMjAgYXQgMTI6MDU6MTVQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzEwLzkg5LiK5Y2INDo0MiwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3Rl
Ogo+ID4gSWYgcmlvdiBhbmQgd2lvdiBhcmUgYm90aCBkZWZpbmVkIGFuZCB0aGV5IHBvaW50IHRv
IGRpZmZlcmVudAo+ID4gb2JqZWN0cywgb25seSByaW92IGlzIGluaXRpYWxpemVkLiBJZiB0aGUg
d2lvdiBpcyBub3QgaW5pdGlhbGl6ZWQKPiA+IGJ5IHRoZSBjYWxsZXIsIHRoZSBmdW5jdGlvbiBm
YWlscyByZXR1cm5pbmcgLUVJTlZBTCBhbmQgcHJpbnRpbmcKPiA+ICJSZWFkYWJsZSBkZXNjIDB4
Li4uIGFmdGVyIHdyaXRhYmxlIiBlcnJvciBtZXNzYWdlLgo+ID4gCj4gPiBUaGlzIGlzc3VlIGhh
cHBlbnMgd2hlbiBkZXNjcmlwdG9ycyBoYXZlIGJvdGggcmVhZGFibGUgYW5kIHdyaXRhYmxlCj4g
PiBidWZmZXJzIChlZy4gdmlydGlvLWJsayBkZXZpY2VzIGhhcyB2aXJ0aW9fYmxrX291dGhkciBp
biB0aGUgcmVhZGFibGUKPiA+IGJ1ZmZlciBhbmQgc3RhdHVzIGFzIGxhc3QgYnl0ZSBvZiB3cml0
YWJsZSBidWZmZXIpIGFuZCB3ZSBjYWxsCj4gPiBfX3ZyaW5naF9pb3YoKSB0byBnZXQgYm90aCB0
eXBlIG9mIGJ1ZmZlcnMgaW4gdHdvIGRpZmZlcmVudCBpb3ZlY3MuCj4gPiAKPiA+IExldCdzIHJl
cGxhY2UgdGhlICdlbHNlIGlmJyBjbGF1c2Ugd2l0aCAnaWYnIHRvIGluaXRpYWxpemUgYm90aAo+
ID4gcmlvdiBhbmQgd2lvdiBpZiB0aGV5IGFyZSBub3QgTlVMTC4KPiA+IAo+ID4gQXMgY2hlY2tw
YXRjaCBwb2ludGVkIG91dCwgd2UgYWxzbyBhdm9pZCBjcmFzaGluZyB0aGUga2VybmVsCj4gPiB3
aGVuIHJpb3YgYW5kIHdpb3YgYXJlIGJvdGggTlVMTCwgcmVwbGFjaW5nIEJVRygpIHdpdGggV0FS
Tl9PTigpCj4gPiBhbmQgcmV0dXJuaW5nIC1FSU5WQUwuCj4gCj4gCj4gSXQgbG9va3MgbGlrZSBJ
IG1ldCB0aGUgZXhhY3Qgc2ltaWxhciBpc3N1ZSB3aGVuIGRldmVsb3BpbmcgY3RybCB2cSBzdXBw
b3J0Cj4gKHdoaWNoIHJlcXVpcmVzIGJvdGggUkVBRCBhbmQgV1JJVEUgZGVzY3JpcHRvcikuCj4g
Cj4gV2hpbGUgSSB3YXMgdHJ5aW5nIHRvIGZpeCB0aGUgaXNzdWUgSSBmb3VuZCB0aGUgZm9sbG93
aW5nIGNvbW1lbnQ6Cj4gCj4gwqAqIE5vdGUgdGhhdCB5b3UgbWF5IG5lZWQgdG8gY2xlYW4gdXAg
cmlvdiBhbmQgd2lvdiwgZXZlbiBvbiBlcnJvciEKPiDCoCovCj4gaW50IHZyaW5naF9nZXRkZXNj
X2lvdGxiKHN0cnVjdCB2cmluZ2ggKnZyaCwKClRoYW5rIHlvdSBmb3IgcG9pbnRpbmcgdGhhdCBv
dXQsIEkgZGlkbid0IHNlZSBpdCEKCj4gCj4gSSBzYXcgc29tZSBkcml2ZXIgY2FsbCB2cmluZ2hf
a2lvdl9jbGVhbnVwKCkuCj4gCj4gU28gSSBqdXN0IGZvbGxvdyB0byB1c2UgdGhhdC4KPiAKPiBJ
J20gbm90IHF1aXRlIHN1cmUgd2hpY2ggb25lIGlzIGJldHRlci4KCk1lIHRvbywgYnV0IGluIGJv
dGggY2FzZXMgdGhlICdlbHNlIGlmJyBpcyB3cm9uZy4KCkVpdGhlciB3ZSBjb21wbGV0ZWx5IHJl
bW92ZSB0aGUgcmVzZXQgaW4gdGhlIGZ1bmN0aW9uIG9yIHdlIG1lcmdlIHRoaXMgcGF0Y2guCklu
IHRoZSBmaXJzdCBjYXNlLCB3ZSBzaG91bGQgYWxzbyBmaXggZHJpdmVycyB0aGF0IGRvbid0IGNh
bGwKdnJpbmdoX2tpb3ZfY2xlYW51cCgpIChlLmcuIHZkcGFfc2ltKS4KCkknbSBmaW5lIHdpdGgg
Ym90aC4KClRoYW5rcywKU3RlZmFubwoKPiAKPiBUaGFua3MKPiAKPiAKPiA+IAo+ID4gRml4ZXM6
IGY4N2QwZmJiNTc5OCAoInZyaW5naDogaG9zdC1zaWRlIGltcGxlbWVudGF0aW9uIG9mIHZpcnRp
byByaW5ncy4iKQo+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcKPiA+IFNpZ25lZC1vZmYt
Ynk6IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4KPiA+IC0tLQo+ID4g
ICBkcml2ZXJzL3Zob3N0L3ZyaW5naC5jIHwgOSArKysrKy0tLS0KPiA+ICAgMSBmaWxlIGNoYW5n
ZWQsIDUgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkKPiA+IAo+ID4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmhvc3QvdnJpbmdoLmMgYi9kcml2ZXJzL3Zob3N0L3ZyaW5naC5jCj4gPiBpbmRl
eCBlMDU5YTlhNDdjZGYuLjhiZDhiNDAzZjA4NyAxMDA2NDQKPiA+IC0tLSBhL2RyaXZlcnMvdmhv
c3QvdnJpbmdoLmMKPiA+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdnJpbmdoLmMKPiA+IEBAIC0yODQs
MTMgKzI4NCwxNCBAQCBfX3ZyaW5naF9pb3Yoc3RydWN0IHZyaW5naCAqdnJoLCB1MTYgaSwKPiA+
ICAgCWRlc2NfbWF4ID0gdnJoLT52cmluZy5udW07Cj4gPiAgIAl1cF9uZXh0ID0gLTE7Cj4gPiAr
CS8qIFlvdSBtdXN0IHdhbnQgc29tZXRoaW5nISAqLwo+ID4gKwlpZiAoV0FSTl9PTighcmlvdiAm
JiAhd2lvdikpCj4gPiArCQlyZXR1cm4gLUVJTlZBTDsKPiA+ICsKPiA+ICAgCWlmIChyaW92KQo+
ID4gICAJCXJpb3YtPmkgPSByaW92LT51c2VkID0gMDsKPiA+IC0JZWxzZSBpZiAod2lvdikKPiA+
ICsJaWYgKHdpb3YpCj4gPiAgIAkJd2lvdi0+aSA9IHdpb3YtPnVzZWQgPSAwOwo+ID4gLQllbHNl
Cj4gPiAtCQkvKiBZb3UgbXVzdCB3YW50IHNvbWV0aGluZyEgKi8KPiA+IC0JCUJVRygpOwo+ID4g
ICAJZm9yICg7Oykgewo+ID4gICAJCXZvaWQgKmFkZHI7Cj4gCgpfX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QK
VmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5s
aW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
