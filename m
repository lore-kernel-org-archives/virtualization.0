Return-Path: <SRS0=e+fm=NP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79A9BC4338F
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 09:10:13 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3127D613AB
	for <virtualization@archiver.kernel.org>; Tue, 24 Aug 2021 09:10:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 3127D613AB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id F28AE60730;
	Tue, 24 Aug 2021 09:10:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BEsW03iMyDF5; Tue, 24 Aug 2021 09:10:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 84EE960679;
	Tue, 24 Aug 2021 09:10:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58B35C0010;
	Tue, 24 Aug 2021 09:10:08 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id ECCAEC000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 09:10:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id DC05040450
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 09:10:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 6ftJnd7ars8P
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 09:10:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 10D2E402F7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 09:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629796201;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uWfeRCdvRJ0kTK/Gz/Tt1B9zy5iA2p1nGEoTlXQHdpw=;
 b=FA5Uc2tMKsiwjqPtWf9Nh/UbuOm8512JPH0E1i29oE9q1Q/30ZS5rA5+jQg07YQS+aNvF2
 rkwttiKc8tNXVCgGkF7TIISttLZ2dyivYhGM50RGMryI2zR5dBulQd2fe2cq5qfSbsvJ2r
 uPq/c0f49rvyiCDX07PZiG77Xon0T4U=
Received: from mail-pg1-f199.google.com (mail-pg1-f199.google.com
 [209.85.215.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-410-AumFZkJpPh2LyySpXuYWTA-1; Tue, 24 Aug 2021 05:09:58 -0400
X-MC-Unique: AumFZkJpPh2LyySpXuYWTA-1
Received: by mail-pg1-f199.google.com with SMTP id
 135-20020a63058d0000b029023cdca61836so11838097pgf.23
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Aug 2021 02:09:58 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=uWfeRCdvRJ0kTK/Gz/Tt1B9zy5iA2p1nGEoTlXQHdpw=;
 b=E220gZd4WQ/MgXBEQSREsk6AYXVZRPTTsCsCkp6a/tXYAtbtpOM38X3A7YAEKCo2Wn
 GVNr1Fpe947S7SvTEMforxv7hAEC9uxCxJnQ166+CGMT7m7LBGNUXoOpfbvVU1K54/mk
 BbInpWKvMUKgVj0y2kDFXKax+rXEOk4nYkqHeBtP5dGTjXX2mRC3vGSO8JkDlhUeKMZU
 sfprHZL38wSoY3tTIN5j+Iwa9VyVMvjnJzHXJNKOwt1jfFNedX7RIfQX/lvLKd/ybr6E
 +ybDI5eX8He+0WsXAT+3cXcUnf1kbXg18LvCUfSwVbay39yQD99ixdiQkBRpSk7Wtusa
 AUhw==
X-Gm-Message-State: AOAM530Ksz0q9vRBG+RGJ0MgKB8YhVlfmSwaXV6Vv80W03VjNAROy/PY
 Yh6cYGhEOypApSzAzo6pRuogTvgSfD5KDxFe03zZCDPkvE32lvSMUSRY5OFfPjI4zsqg6ELInWD
 8QULefQ+ezrIn8bk9Vjr6wHD/sNqVfp/V1la8A4nLmg==
X-Received: by 2002:a63:790b:: with SMTP id u11mr35567096pgc.71.1629796197252; 
 Tue, 24 Aug 2021 02:09:57 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwJWwyp6wfeg0AgfdNUFJpptOBbfmwIHtcJsb+hLjkgMu5FcyRHgqqsf4RNcY8a02+96BuONw==
X-Received: by 2002:a63:790b:: with SMTP id u11mr35567072pgc.71.1629796197038; 
 Tue, 24 Aug 2021 02:09:57 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id d4sm8000754pfo.214.2021.08.24.02.09.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 24 Aug 2021 02:09:56 -0700 (PDT)
Subject: Re: [PATCH v4 4/6] vdpa/mlx5: Ensure valid indices are provided
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org
References: <20210823052123.14909-1-elic@nvidia.com>
 <20210823052123.14909-5-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0761cdb3-f936-53b5-bb03-64bf56a668ba@redhat.com>
Date: Tue, 24 Aug 2021 17:09:52 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210823052123.14909-5-elic@nvidia.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: eperezma@redhat.com
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
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvOC8yMyDPws7nMToyMSwgRWxpIENvaGVuINC0tcA6Cj4gRm9sbG93aW5nIHBhdGNo
ZXMgYWRkIGNvbnRyb2wgdmlydHVxZXVlIGFuZCBtdWx0aXF1ZXVlIHN1cHBvcnQuIFdlIHdhbnQK
PiB0byB2ZXJpZnkgdGhhdCB0aGUgaW5kZXggdmFsdWUgdG8gY2FsbGJhY2tzIHJlZmVyZW5jaW5n
IGEgdmlydHF1ZXVlIGlzCj4gdmFsaWQuCj4KPiBUaGUgbG9naWMgZGVmaW5pbmcgdmFsaWQgaW5k
aWNlcyBpcyBhcyBmb2xsb3dzOgo+IENWUSBjbGVhcjogMCBhbmQgMS4KPiBDVlEgc2V0LCBNUSBj
bGVhcjogMCwgMSBhbmQgMgo+IENWUSBzZXQsIE1RIHNldDogMC4ubnZxIHdoZXJlIG52cSBpcyB3
aGF0ZXZlciBwcm92aWRlZCB0bwo+IF92ZHBhX3JlZ2lzdGVyX2RldmljZSgpCj4KPiBTaWduZWQt
b2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KCgpBY2tlZC1ieTogSmFzb24gV2Fu
ZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy92ZHBhL21seDUvY29y
ZS9tbHg1X3ZkcGEuaCB8ICAxICsKPiAgIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQu
YyAgfCA1NCArKysrKysrKysrKysrKysrKysrKysrKysrKysrKysKPiAgIDIgZmlsZXMgY2hhbmdl
ZCwgNTUgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L2Nv
cmUvbWx4NV92ZHBhLmggYi9kcml2ZXJzL3ZkcGEvbWx4NS9jb3JlL21seDVfdmRwYS5oCj4gaW5k
ZXggOGQwYTZmMmNiM2YwLi40MWIyMDg1NWVkMzEgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBh
L21seDUvY29yZS9tbHg1X3ZkcGEuaAo+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L2NvcmUvbWx4
NV92ZHBhLmgKPiBAQCAtNTYsNiArNTYsNyBAQCBzdHJ1Y3QgbWx4NV92ZHBhX2RldiB7Cj4gICAJ
dTY0IGFjdHVhbF9mZWF0dXJlczsKPiAgIAl1OCBzdGF0dXM7Cj4gICAJdTMyIG1heF92cXM7Cj4g
Kwl1MTYgbWF4X2lkeDsKPiAgIAl1MzIgZ2VuZXJhdGlvbjsKPiAgIAo+ICAgCXN0cnVjdCBtbHg1
X3ZkcGFfbXIgbXI7Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3Zu
ZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+IGluZGV4IDNhZTJlNWFl
MmJlMS4uZWFmYWQyYTE5Mjk5IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9t
bHg1X3ZuZXQuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+IEBA
IC00NSw2ICs0NSw4IEBAIE1PRFVMRV9MSUNFTlNFKCJEdWFsIEJTRC9HUEwiKTsKPiAgIAkoVklS
VElPX0NPTkZJR19TX0FDS05PV0xFREdFIHwgVklSVElPX0NPTkZJR19TX0RSSVZFUiB8IFZJUlRJ
T19DT05GSUdfU19EUklWRVJfT0sgfCAgICAgICAgXAo+ICAgCSBWSVJUSU9fQ09ORklHX1NfRkVB
VFVSRVNfT0sgfCBWSVJUSU9fQ09ORklHX1NfTkVFRFNfUkVTRVQgfCBWSVJUSU9fQ09ORklHX1Nf
RkFJTEVEKQo+ICAgCj4gKyNkZWZpbmUgTUxYNV9GRUFUVVJFKF9tdmRldiwgX2ZlYXR1cmUpICgh
ISgoX212ZGV2KS0+YWN0dWFsX2ZlYXR1cmVzICYgQklUX1VMTChfZmVhdHVyZSkpKQo+ICsKPiAg
IHN0cnVjdCBtbHg1X3ZkcGFfbmV0X3Jlc291cmNlcyB7Cj4gICAJdTMyIHRpc247Cj4gICAJdTMy
IHRkbjsKPiBAQCAtMTMzLDYgKzEzNSwxNCBAQCBzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWV1ZSB7
Cj4gICAgKi8KPiAgICNkZWZpbmUgTUxYNV9NQVhfU1VQUE9SVEVEX1ZRUyAxNgo+ICAgCj4gK3N0
YXRpYyBib29sIGlzX2luZGV4X3ZhbGlkKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiwgdTE2
IGlkeCkKPiArewo+ICsJaWYgKHVubGlrZWx5KGlkeCA+IG12ZGV2LT5tYXhfaWR4KSkKPiArCQly
ZXR1cm4gZmFsc2U7Cj4gKwo+ICsJcmV0dXJuIHRydWU7Cj4gK30KPiArCj4gICBzdHJ1Y3QgbWx4
NV92ZHBhX25ldCB7Cj4gICAJc3RydWN0IG1seDVfdmRwYV9kZXYgbXZkZXY7Cj4gICAJc3RydWN0
IG1seDVfdmRwYV9uZXRfcmVzb3VyY2VzIHJlczsKPiBAQCAtMTM1NCw2ICsxMzY0LDkgQEAgc3Rh
dGljIHZvaWQgbWx4NV92ZHBhX2tpY2tfdnEoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1MTYg
aWR4KQo+ICAgCXN0cnVjdCBtbHg1X3ZkcGFfbmV0ICpuZGV2ID0gdG9fbWx4NV92ZHBhX25kZXYo
bXZkZXYpOwo+ICAgCXN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXVlICptdnEgPSAmbmRldi0+dnFz
W2lkeF07Cj4gICAKPiArCWlmICghaXNfaW5kZXhfdmFsaWQobXZkZXYsIGlkeCkpCj4gKwkJcmV0
dXJuOwo+ICsKPiAgIAlpZiAodW5saWtlbHkoIW12cS0+cmVhZHkpKQo+ICAgCQlyZXR1cm47Cj4g
ICAKPiBAQCAtMTM2Nyw2ICsxMzgwLDkgQEAgc3RhdGljIGludCBtbHg1X3ZkcGFfc2V0X3ZxX2Fk
ZHJlc3Moc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1MTYgaWR4LCB1NjQgZGVzY18KPiAgIAlz
dHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiA9IHRvX21seDVfdmRwYV9uZGV2KG12ZGV2KTsKPiAg
IAlzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWV1ZSAqbXZxID0gJm5kZXYtPnZxc1tpZHhdOwo+ICAg
Cj4gKwlpZiAoIWlzX2luZGV4X3ZhbGlkKG12ZGV2LCBpZHgpKQo+ICsJCXJldHVybiAtRUlOVkFM
Owo+ICsKPiAgIAltdnEtPmRlc2NfYWRkciA9IGRlc2NfYXJlYTsKPiAgIAltdnEtPmRldmljZV9h
ZGRyID0gZGV2aWNlX2FyZWE7Cj4gICAJbXZxLT5kcml2ZXJfYWRkciA9IGRyaXZlcl9hcmVhOwo+
IEBAIC0xMzc5LDYgKzEzOTUsOSBAQCBzdGF0aWMgdm9pZCBtbHg1X3ZkcGFfc2V0X3ZxX251bShz
dHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHUxNiBpZHgsIHUzMiBudW0pCj4gICAJc3RydWN0IG1s
eDVfdmRwYV9uZXQgKm5kZXYgPSB0b19tbHg1X3ZkcGFfbmRldihtdmRldik7Cj4gICAJc3RydWN0
IG1seDVfdmRwYV92aXJ0cXVldWUgKm12cTsKPiAgIAo+ICsJaWYgKCFpc19pbmRleF92YWxpZCht
dmRldiwgaWR4KSkKPiArCQlyZXR1cm47Cj4gKwo+ICAgCW12cSA9ICZuZGV2LT52cXNbaWR4XTsK
PiAgIAltdnEtPm51bV9lbnQgPSBudW07Cj4gICB9Cj4gQEAgLTEzOTcsNiArMTQxNiw5IEBAIHN0
YXRpYyB2b2lkIG1seDVfdmRwYV9zZXRfdnFfcmVhZHkoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2
LCB1MTYgaWR4LCBib29sIHJlYWR5Cj4gICAJc3RydWN0IG1seDVfdmRwYV9uZXQgKm5kZXYgPSB0
b19tbHg1X3ZkcGFfbmRldihtdmRldik7Cj4gICAJc3RydWN0IG1seDVfdmRwYV92aXJ0cXVldWUg
Km12cSA9ICZuZGV2LT52cXNbaWR4XTsKPiAgIAo+ICsJaWYgKCFpc19pbmRleF92YWxpZChtdmRl
diwgaWR4KSkKPiArCQlyZXR1cm47Cj4gKwo+ICAgCWlmICghcmVhZHkpCj4gICAJCXN1c3BlbmRf
dnEobmRldiwgbXZxKTsKPiAgIAo+IEBAIC0xNDA5LDYgKzE0MzEsOSBAQCBzdGF0aWMgYm9vbCBt
bHg1X3ZkcGFfZ2V0X3ZxX3JlYWR5KHN0cnVjdCB2ZHBhX2RldmljZSAqdmRldiwgdTE2IGlkeCkK
PiAgIAlzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiA9IHRvX21seDVfdmRwYV9uZGV2KG12ZGV2
KTsKPiAgIAlzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWV1ZSAqbXZxID0gJm5kZXYtPnZxc1tpZHhd
Owo+ICAgCj4gKwlpZiAoIWlzX2luZGV4X3ZhbGlkKG12ZGV2LCBpZHgpKQo+ICsJCXJldHVybiBm
YWxzZTsKPiArCj4gICAJcmV0dXJuIG12cS0+cmVhZHk7Cj4gICB9Cj4gICAKPiBAQCAtMTQxOSw2
ICsxNDQ0LDkgQEAgc3RhdGljIGludCBtbHg1X3ZkcGFfc2V0X3ZxX3N0YXRlKHN0cnVjdCB2ZHBh
X2RldmljZSAqdmRldiwgdTE2IGlkeCwKPiAgIAlzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiA9
IHRvX21seDVfdmRwYV9uZGV2KG12ZGV2KTsKPiAgIAlzdHJ1Y3QgbWx4NV92ZHBhX3ZpcnRxdWV1
ZSAqbXZxID0gJm5kZXYtPnZxc1tpZHhdOwo+ICAgCj4gKwlpZiAoIWlzX2luZGV4X3ZhbGlkKG12
ZGV2LCBpZHgpKQo+ICsJCXJldHVybiAtRUlOVkFMOwo+ICsKPiAgIAlpZiAobXZxLT5md19zdGF0
ZSA9PSBNTFg1X1ZJUlRJT19ORVRfUV9PQkpFQ1RfU1RBVEVfUkRZKSB7Cj4gICAJCW1seDVfdmRw
YV93YXJuKG12ZGV2LCAiY2FuJ3QgbW9kaWZ5IGF2YWlsYWJsZSBpbmRleFxuIik7Cj4gICAJCXJl
dHVybiAtRUlOVkFMOwo+IEBAIC0xNDM3LDYgKzE0NjUsOSBAQCBzdGF0aWMgaW50IG1seDVfdmRw
YV9nZXRfdnFfc3RhdGUoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1MTYgaWR4LCBzdHJ1Y3Qg
dmRwYQo+ICAgCXN0cnVjdCBtbHg1X3ZpcnRxX2F0dHIgYXR0cjsKPiAgIAlpbnQgZXJyOwo+ICAg
Cj4gKwlpZiAoIWlzX2luZGV4X3ZhbGlkKG12ZGV2LCBpZHgpKQo+ICsJCXJldHVybiAtRUlOVkFM
Owo+ICsKPiAgIAkvKiBJZiB0aGUgdmlydHEgb2JqZWN0IHdhcyBkZXN0cm95ZWQsIHVzZSB0aGUg
dmFsdWUgc2F2ZWQgYXQKPiAgIAkgKiB0aGUgbGFzdCBtaW51dGUgb2Ygc3VzcGVuZF92cS4gVGhp
cyBjYXRlcnMgZm9yIHVzZXJzcGFjZQo+ICAgCSAqIHRoYXQgY2FyZXMgYWJvdXQgZW11bGF0aW5n
IHRoZSBpbmRleCBhZnRlciB2cSBpcyBzdG9wcGVkLgo+IEBAIC0xNTU2LDYgKzE1ODcsMjQgQEAg
c3RhdGljIF9fdmlydGlvMTYgY3B1X3RvX21seDV2ZHBhMTYoc3RydWN0IG1seDVfdmRwYV9kZXYg
Km12ZGV2LCB1MTYgdmFsKQo+ICAgCXJldHVybiBfX2NwdV90b192aXJ0aW8xNihtbHg1X3ZkcGFf
aXNfbGl0dGxlX2VuZGlhbihtdmRldiksIHZhbCk7Cj4gICB9Cj4gICAKPiArc3RhdGljIHZvaWQg
dXBkYXRlX2N2cV9pbmZvKHN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldikKPiArewo+ICsJaWYg
KE1MWDVfRkVBVFVSRShtdmRldiwgVklSVElPX05FVF9GX0NUUkxfVlEpKSB7Cj4gKwkJaWYgKE1M
WDVfRkVBVFVSRShtdmRldiwgVklSVElPX05FVF9GX01RKSkgewo+ICsJCQkvKiBNUSBzdXBwb3J0
ZWQuIENWUSBpbmRleCBpcyByaWdodCBhYm92ZSB0aGUgbGFzdCBkYXRhIHZpcnRxdWV1ZSdzICov
Cj4gKwkJCW12ZGV2LT5tYXhfaWR4ID0gbXZkZXYtPm1heF92cXM7Cj4gKwkJfSBlbHNlIHsKPiAr
CQkJLyogT25seSBDVlEgc3VwcG9ydHRlZC4gZGF0YSB2aXJ0cXVldWVzIG9jY3VweSBpbmRpY2Vz
IDAgYW5kIDEuCj4gKwkJCSAqIENWUSBnZXRzIGluZGV4IDIKPiArCQkJICovCj4gKwkJCW12ZGV2
LT5tYXhfaWR4ID0gMjsKPiArCQl9Cj4gKwl9IGVsc2Ugewo+ICsJCS8qIFR3byBkYXRhIHZpcnRx
dWV1ZXMgb25seTogb25lIGZvciByeCBhbmQgb25lIGZvciB0eCAqLwo+ICsJCW12ZGV2LT5tYXhf
aWR4ID0gMTsKPiArCX0KPiArfQo+ICsKPiAgIHN0YXRpYyBpbnQgbWx4NV92ZHBhX3NldF9mZWF0
dXJlcyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHU2NCBmZWF0dXJlcykKPiAgIHsKPiAgIAlz
dHJ1Y3QgbWx4NV92ZHBhX2RldiAqbXZkZXYgPSB0b19tdmRldih2ZGV2KTsKPiBAQCAtMTU3MSw2
ICsxNjIwLDcgQEAgc3RhdGljIGludCBtbHg1X3ZkcGFfc2V0X2ZlYXR1cmVzKHN0cnVjdCB2ZHBh
X2RldmljZSAqdmRldiwgdTY0IGZlYXR1cmVzKQo+ICAgCW5kZXYtPm12ZGV2LmFjdHVhbF9mZWF0
dXJlcyA9IGZlYXR1cmVzICYgbmRldi0+bXZkZXYubWx4X2ZlYXR1cmVzOwo+ICAgCW5kZXYtPmNv
bmZpZy5tdHUgPSBjcHVfdG9fbWx4NXZkcGExNihtdmRldiwgbmRldi0+bXR1KTsKPiAgIAluZGV2
LT5jb25maWcuc3RhdHVzIHw9IGNwdV90b19tbHg1dmRwYTE2KG12ZGV2LCBWSVJUSU9fTkVUX1Nf
TElOS19VUCk7Cj4gKwl1cGRhdGVfY3ZxX2luZm8obXZkZXYpOwo+ICAgCXJldHVybiBlcnI7Cj4g
ICB9Cj4gICAKPiBAQCAtMTc5Miw2ICsxODQyLDcgQEAgc3RhdGljIHZvaWQgbWx4NV92ZHBhX3Nl
dF9zdGF0dXMoc3RydWN0IHZkcGFfZGV2aWNlICp2ZGV2LCB1OCBzdGF0dXMpCj4gICAJCW5kZXYt
Pm12ZGV2LnN0YXR1cyA9IDA7Cj4gICAJCW5kZXYtPm12ZGV2Lm1seF9mZWF0dXJlcyA9IDA7Cj4g
ICAJCW1lbXNldChuZGV2LT5ldmVudF9jYnMsIDAsIHNpemVvZihuZGV2LT5ldmVudF9jYnMpKTsK
PiArCQluZGV2LT5tdmRldi5hY3R1YWxfZmVhdHVyZXMgPSAwOwo+ICAgCQkrK212ZGV2LT5nZW5l
cmF0aW9uOwo+ICAgCQlpZiAoTUxYNV9DQVBfR0VOKG12ZGV2LT5tZGV2LCB1bWVtX3VpZF8wKSkg
ewo+ICAgCQkJaWYgKG1seDVfdmRwYV9jcmVhdGVfbXIobXZkZXYsIE5VTEwpKQo+IEBAIC0xODky
LDYgKzE5NDMsOSBAQCBzdGF0aWMgc3RydWN0IHZkcGFfbm90aWZpY2F0aW9uX2FyZWEgbWx4NV9n
ZXRfdnFfbm90aWZpY2F0aW9uKHN0cnVjdCB2ZHBhX2RldmljZQo+ICAgCXN0cnVjdCBtbHg1X3Zk
cGFfbmV0ICpuZGV2Owo+ICAgCXBoeXNfYWRkcl90IGFkZHI7Cj4gICAKPiArCWlmICghaXNfaW5k
ZXhfdmFsaWQobXZkZXYsIGlkeCkpCj4gKwkJcmV0dXJuIHJldDsKPiArCj4gICAJLyogSWYgU0Yg
QkFSIHNpemUgaXMgc21hbGxlciB0aGFuIFBBR0VfU0laRSwgZG8gbm90IHVzZSBkaXJlY3QKPiAg
IAkgKiBub3RpZmljYXRpb24gdG8gYXZvaWQgdGhlIHJpc2sgb2YgbWFwcGluZyBwYWdlcyB0aGF0
IGNvbnRhaW4gQkFSIG9mIG1vcmUKPiAgIAkgKiB0aGFuIG9uZSBTRgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
