Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 98524C433FE
	for <virtualization@archiver.kernel.org>; Fri, 11 Nov 2022 16:36:13 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 1253C4188D;
	Fri, 11 Nov 2022 16:36:13 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 1253C4188D
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fc7ti6iN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6jk9r-NBkGae; Fri, 11 Nov 2022 16:36:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 480C041879;
	Fri, 11 Nov 2022 16:36:11 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 480C041879
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A6FFC0032;
	Fri, 11 Nov 2022 16:36:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEA63C002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 16:36:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id A298181DEF
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 16:36:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A298181DEF
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=Fc7ti6iN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id T7GgssH6T0gD
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 16:36:10 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org D99C481DCA
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id D99C481DCA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 16:36:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1668184568;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6mlEl6qGZPqlKJRRjXwEN5bOOe171F4/1jD4DeUrkco=;
 b=Fc7ti6iN7Wxgkr9XdQX4u4VChvTCZJpfOLSOXb6wTxJD5iWO6mlHHdLy8UGaNVBOSriTZZ
 EA3SZhx3YR6ufi6TLrf26Tlf1e3F4Y7Rs3CDXxbfNHxdPHwiaNh18TQCML7WuvXcDKyUtz
 URlgDRA02PyBqzOhD71jy2WWVnvCo5w=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-170-bAlYLXAHNjS3yCu6DUrb4A-1; Fri, 11 Nov 2022 11:36:05 -0500
X-MC-Unique: bAlYLXAHNjS3yCu6DUrb4A-1
Received: by mail-qk1-f199.google.com with SMTP id
 bj1-20020a05620a190100b006fa12a05188so5115763qkb.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 11 Nov 2022 08:36:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=6mlEl6qGZPqlKJRRjXwEN5bOOe171F4/1jD4DeUrkco=;
 b=5TPmEv13peb9FLvxlU+rE8059L3JREycRxk+imCFCihHNtoes2rIVO1scqecocAMwI
 stMbC6S5B5BMjadNWHgDttPk3q0BrLgx9f4aGKgt/C31uqDYzySHn/7dRaXOnsBmcIfa
 z0lyb17XVGgZv1Ceozh+rctQUAt4fhWYgP3M1B50Z+FnEV0sQAAyTecZLb1+dOx3/yJF
 sRtrsdBJs4EEYnIiBHp13SBEsU7pf6kbTQd6ixNW8yzNJ+IVwXGvP+ZSTp9tOXVVIcnq
 wzyDE+AO4IcyOsQwZbyZVjYlHF9els4DUrpueYxgmF8qHqu+DYiP4ddCrsIPcrEuYzW/
 qBaw==
X-Gm-Message-State: ANoB5pnC0PBrCocltwO8RcVel5PpDGQddEyfYhiHywZBWU2trBBjq0a2
 BuSTaZ4PjD7HHXr4n/3ChQl0yWyNCSZjIqLk5uIoSjLwdrKbqLo3ZSTvjr7A8p26LOJc0Xe7OgM
 UrZQ57gq1LT2OgCorCMFpL5KoiVkIIX8BZRyjIZa9tw==
X-Received: by 2002:a05:620a:c98:b0:6fa:2ffe:aab0 with SMTP id
 q24-20020a05620a0c9800b006fa2ffeaab0mr1764860qki.567.1668184564613; 
 Fri, 11 Nov 2022 08:36:04 -0800 (PST)
X-Google-Smtp-Source: AA0mqf6nWeiKKtbGwQyvMC7EoupUmLz8J7yWqDcAtEA6uRF4m9XzonXF3JCm2XUraHXJpty+FSLTaA==
X-Received: by 2002:a05:620a:c98:b0:6fa:2ffe:aab0 with SMTP id
 q24-20020a05620a0c9800b006fa2ffeaab0mr1764835qki.567.1668184564368; 
 Fri, 11 Nov 2022 08:36:04 -0800 (PST)
Received: from sgarzare-redhat (host-82-53-134-234.retail.telecomitalia.it.
 [82.53.134.234]) by smtp.gmail.com with ESMTPSA id
 ay42-20020a05622a22aa00b0039a08c0a594sm1433589qtb.82.2022.11.11.08.35.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 11 Nov 2022 08:36:03 -0800 (PST)
Date: Fri, 11 Nov 2022 17:35:48 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Longpeng (Mike,
 Cloud Infrastructure Service Product Dept.)" <longpeng2@huawei.com>
Subject: Re: [PATCH] vp_vdpa: harden the logic of set status
Message-ID: <20221111163548.x6yy2w74gk6biykw@sgarzare-redhat>
References: <20221111145505.1232-1-longpeng2@huawei.com>
 <20221111151459.dyz42jclq26ai26q@sgarzare-redhat>
 <0f25506f-b9ca-1578-f944-cfb3936ced50@huawei.com>
MIME-Version: 1.0
In-Reply-To: <0f25506f-b9ca-1578-f944-cfb3936ced50@huawei.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: xiehong@huawei.com, mst@redhat.com, linux-kernel@vger.kernel.org,
 yechuan@huawei.com, huangzhichao@huawei.com, stefanha@redhat.com,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gRnJpLCBOb3YgMTEsIDIwMjIgYXQgMTE6NDk6MTBQTSArMDgwMCwgTG9uZ3BlbmcgKE1pa2Us
IENsb3VkIEluZnJhc3RydWN0dXJlIFNlcnZpY2UgUHJvZHVjdCBEZXB0Likgd3JvdGU6Cj4KPgo+
5ZyoIDIwMjIvMTEvMTEgMjM6MTQsIFN0ZWZhbm8gR2FyemFyZWxsYSDlhpnpgZM6Cj4+T24gRnJp
LCBOb3YgMTEsIDIwMjIgYXQgMTA6NTU6MDVQTSArMDgwMCwgTG9uZ3BlbmcoTWlrZSkgd3JvdGU6
Cj4+PkZyb206IExvbmdwZW5nIDxsb25ncGVuZzJAaHVhd2VpLmNvbT4KPj4+Cj4+PjEuIFdlIHNo
b3VsZCBub3Qgc2V0IHN0YXR1cyB0byAwIHdoZW4gaW52b2tpbmcgdnBfdmRwYV9zZXRfc3RhdHVz
KCkuCj4+Pgo+Pj4yLiBUaGUgZHJpdmVyIE1VU1Qgd2FpdCBmb3IgYSByZWFkIG9mIGRldmljZV9z
dGF0dXMgdG8gcmV0dXJuIDAgYmVmb3JlCj4+PsKgIHJlaW5pdGlhbGl6aW5nIHRoZSBkZXZpY2Uu
Cj4+Pgo+Pj5TaWduZWQtb2ZmLWJ5OiBMb25ncGVuZyA8bG9uZ3BlbmcyQGh1YXdlaS5jb20+Cj4+
Pi0tLQo+Pj5kcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMgfCAxMSArKysrKysrKysr
LQo+Pj4xIGZpbGUgY2hhbmdlZCwgMTAgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQo+Pj4K
Pj4+ZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3ZkcGEuYyAKPj4+Yi9k
cml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMKPj4+aW5kZXggZDQ0OGRiMGM0ZGUzLi5k
MzVmYWM1Y2RlMTEgMTAwNjQ0Cj4+Pi0tLSBhL2RyaXZlcnMvdmRwYS92aXJ0aW9fcGNpL3ZwX3Zk
cGEuYwo+Pj4rKysgYi9kcml2ZXJzL3ZkcGEvdmlydGlvX3BjaS92cF92ZHBhLmMKPj4+QEAgLTIx
Miw4ICsyMTIsMTIgQEAgc3RhdGljIHZvaWQgdnBfdmRwYV9zZXRfc3RhdHVzKHN0cnVjdCAKPj4+
dmRwYV9kZXZpY2UgKnZkcGEsIHU4IHN0YXR1cykKPj4+ewo+Pj7CoMKgwqDCoHN0cnVjdCB2cF92
ZHBhICp2cF92ZHBhID0gdmRwYV90b192cCh2ZHBhKTsKPj4+wqDCoMKgwqBzdHJ1Y3QgdmlydGlv
X3BjaV9tb2Rlcm5fZGV2aWNlICptZGV2ID0gdnBfdmRwYV90b19tZGV2KHZwX3ZkcGEpOwo+Pj4t
wqDCoMKgIHU4IHMgPSB2cF92ZHBhX2dldF9zdGF0dXModmRwYSk7Cj4+Cj4+SXMgdGhpcyBjaGFu
Z2UgcmVhbGx5IG5lZWRlZD8KPj4KPk5vIG5lZWQgdG8gZ2V0IHRoZSBzdGF0dXMgaWYgd2UgdHJ5
IHRvIHNldCBzdGF0dXMgdG8gMCAodHJpZ2dlciBCVUcpLgo+CgpPa2F5LCBidXQgdGhhdCdzIHRo
ZSBjYXNlIHRoYXQgc2hvdWxkIG5ldmVyIGhhcHBlbiwgc28gSU1ITyB3ZSBjYW4gbGVhdmUgCml0
IGFzIGl0IGlzLgoKPj4+K8KgwqDCoCB1OCBzOwo+Pj4rCj4+PivCoMKgwqAgLyogV2Ugc2hvdWxk
IG5ldmVyIGJlIHNldHRpbmcgc3RhdHVzIHRvIDAuICovCj4+PivCoMKgwqAgQlVHX09OKHN0YXR1
cyA9PSAwKTsKPj4KPj5JTUhPIHBhbmlja2luZyB0aGUga2VybmVsIHNlZW1zIGV4Y2Vzc2l2ZSBp
biB0aGlzIGNhc2UsIHBsZWFzZSB1c2UgCj4+V0FSTl9PTiBhbmQgbWF5YmUgcmV0dXJuIGVhcmxp
ZXIuCj4+Cj5VbS4uLkkgcmVmZXJlbmNlZCB0aGUgdnBfcmVzZXQvdnBfc2V0X3N0YXR1cywKCkFo
IEkgc2VlLCBtYXliZSBpdCdzIGFuIG9sZCBjb2RlLCBiZWNhdXNlIHJlY2VudGx5IHdlIGFsd2F5
cyB0cnkgdG8gCmF2b2lkIEJVR19PTigpLgoKPgo+Pj4KPj4+K8KgwqDCoCBzID0gdnBfdmRwYV9n
ZXRfc3RhdHVzKHZkcGEpOwo+Pj7CoMKgwqDCoGlmIChzdGF0dXMgJiBWSVJUSU9fQ09ORklHX1Nf
RFJJVkVSX09LICYmCj4+PsKgwqDCoMKgwqDCoMKgICEocyAmIFZJUlRJT19DT05GSUdfU19EUklW
RVJfT0spKSB7Cj4+PsKgwqDCoMKgwqDCoMKgIHZwX3ZkcGFfcmVxdWVzdF9pcnEodnBfdmRwYSk7
Cj4+PkBAIC0yMjksNiArMjMzLDExIEBAIHN0YXRpYyBpbnQgdnBfdmRwYV9yZXNldChzdHJ1Y3Qg
dmRwYV9kZXZpY2UgKnZkcGEpCj4+PsKgwqDCoMKgdTggcyA9IHZwX3ZkcGFfZ2V0X3N0YXR1cyh2
ZHBhKTsKPj4+Cj4+PsKgwqDCoMKgdnBfbW9kZXJuX3NldF9zdGF0dXMobWRldiwgMCk7Cj4+PivC
oMKgwqAgLyogQWZ0ZXIgd3JpdGluZyAwIHRvIGRldmljZV9zdGF0dXMsIHRoZSBkcml2ZXIgTVVT
VCB3YWl0IGZvciAKPj4+YSByZWFkIG9mCj4+PivCoMKgwqDCoCAqIGRldmljZV9zdGF0dXMgdG8g
cmV0dXJuIDAgYmVmb3JlIHJlaW5pdGlhbGl6aW5nIHRoZSBkZXZpY2UuCj4+PivCoMKgwqDCoCAq
Lwo+Pj4rwqDCoMKgIHdoaWxlICh2cF9tb2Rlcm5fZ2V0X3N0YXR1cyhtZGV2KSkKPj4+K8KgwqDC
oMKgwqDCoMKgIG1zbGVlcCgxKTsKPj4KPj5TaG91bGQgd2Ugc2V0IGEgbGltaXQgYWZ0ZXIgd2hp
Y2ggd2UgZ2l2ZSB1cD8gQSBtYWxmdW5jdGlvbmluZyAKPj5kZXZpY2UgY291bGQga2VlcCB1cyBo
ZXJlIGZvcmV2ZXIuCj4+Cj5ZZXMsIGJ1dCB0aGUgbWFsZnVuY3Rpb25pbmcgZGV2aWNlIG1heWJl
IGNhbiBub3Qgd29yayBhbnltb3JlLCBob3cgdG8gCj5oYW5kbGUgaXQ/CgpNYXliZSB3ZSBzaG91
bGQgc2V0IHRoZSBzdGF0dXMgdG8gYnJva2VuLCBidXQgaW4gdGhpcyBjYXNlIHdlIGNvdWxkIGp1
c3QgCnJldHVybiBhbiBlcnJvciBpZiB3ZSBjb3VsZG4ndCByZXNldCBpdCwgaG93IGFib3V0IHRo
YXQ/CgpUaGFua3MsClN0ZWZhbm8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBs
aXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5v
cmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
