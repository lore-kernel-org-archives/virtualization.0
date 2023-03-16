Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 41F3EC6FD1F
	for <virtualization@archiver.kernel.org>; Thu, 16 Mar 2023 09:11:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id A0BEB40BFC;
	Thu, 16 Mar 2023 09:11:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org A0BEB40BFC
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WTapVjnB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MmG0-8wSYl2Q; Thu, 16 Mar 2023 09:11:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 027A040220;
	Thu, 16 Mar 2023 09:11:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 027A040220
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CB98FC0035;
	Thu, 16 Mar 2023 09:11:51 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 464ACC0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 09:11:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 2DDDF60A9D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 09:11:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2DDDF60A9D
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=WTapVjnB
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id f7HhYUyDgAbL
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 09:11:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 47C76607C0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 47C76607C0
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 09:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678957908;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3eMeY9yQN+W3p1vHqt8vyruDxKEouKBf8XoW+xN+7GI=;
 b=WTapVjnBtsf4iDkaOoK6qqtuhXhhxpgvaZXnVs/FKHfqq6gsge4yBK44zDUyr/rh7rOoOX
 TH5oOCQCZlG+cGJf6Rr1n+xiACwcsZuxfNiNq2FQVzyuLBWdGwQXqYNnIlGq9rT5ualJbQ
 EJ9Qs1ChdDUUJuNXZNUF+hFgwxbxeq8=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-365-jqSfnW-ZM7-V0db1q7Sy7w-1; Thu, 16 Mar 2023 05:11:46 -0400
X-MC-Unique: jqSfnW-ZM7-V0db1q7Sy7w-1
Received: by mail-wm1-f69.google.com with SMTP id
 fl22-20020a05600c0b9600b003ed26ca6206so2332892wmb.2
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 02:11:46 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678957906;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=3eMeY9yQN+W3p1vHqt8vyruDxKEouKBf8XoW+xN+7GI=;
 b=gzV7+3g/BzJxyILdKX6G3VHRNUMeuMHaZBBogfi8iVcoj/aq4Ph/6QGyvzyi5KSOxx
 maORfXGahUxy/z9ge6eayNKAy9qVJQ/6uKsIMgcea+8AW+TAQFHkMYUUowVswTMFO6U8
 d2DOrPjnZNG8BjHUK3p/xAkrNL285NM79ikLaXTnRvftOuM2PV7GHA2/2Pgf2hChoVyh
 9sWHuNdfAsSEG3pzfD4Sm23/GGVQttKjuW8o19A/Fa0CXqyPSfr8IhFcwjABV6LRRvIA
 Dl2LknMfDFjVoGbIXYE5rFcrCBo8CrNCN5C2gHOH3jbkwHUvywmMp9pbD7ZwBDAXTrQ5
 taiQ==
X-Gm-Message-State: AO0yUKXjo2xukXToHhKzf8zFF+uqdi/HiTJhxt0+lIMCIvtnDImMFKlC
 vHn5Gd8hjfSMX5zdF72ad9i97Y+cUsPGSLLvFH4pOSrqYwupJzc7Ty/Gj2DRJa8gBVOg5s+E212
 xze2h5/7pM3qFAMwloO+yE7Mn1Q3wQ/pmUXHeauAMWQ==
X-Received: by 2002:adf:ffc4:0:b0:2ce:fd37:9392 with SMTP id
 x4-20020adfffc4000000b002cefd379392mr4100477wrs.45.1678957905879; 
 Thu, 16 Mar 2023 02:11:45 -0700 (PDT)
X-Google-Smtp-Source: AK7set+X9DfQli3Fz2uLdFc+Z4TbWmOca2fwWfEubcClbX5Pl3I1a8rJk+NQbGboz0DJZWf/m4UJLQ==
X-Received: by 2002:adf:ffc4:0:b0:2ce:fd37:9392 with SMTP id
 x4-20020adfffc4000000b002cefd379392mr4100461wrs.45.1678957905562; 
 Thu, 16 Mar 2023 02:11:45 -0700 (PDT)
Received: from sgarzare-redhat (host-82-57-51-170.retail.telecomitalia.it.
 [82.57.51.170]) by smtp.gmail.com with ESMTPSA id
 c10-20020adfed8a000000b002cf8220cc75sm6685830wro.24.2023.03.16.02.11.44
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 16 Mar 2023 02:11:45 -0700 (PDT)
Date: Thu, 16 Mar 2023 10:11:42 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v2 8/8] vdpa_sim: add support for user VA
Message-ID: <20230316091142.p2ogqf3q2fsyha3l@sgarzare-redhat>
References: <20230302113421.174582-1-sgarzare@redhat.com>
 <20230302113421.174582-9-sgarzare@redhat.com>
 <CACGkMEt1hBcRdh0oQYCs4meRs0mvDu9X9o-zK4aS87hrN+QPxA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACGkMEt1hBcRdh0oQYCs4meRs0mvDu9X9o-zK4aS87hrN+QPxA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com
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

T24gVHVlLCBNYXIgMTQsIDIwMjMgYXQgMDE6MzY6MTNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPk9uIFRodSwgTWFyIDIsIDIwMjMgYXQgNzozNeKAr1BNIFN0ZWZhbm8gR2FyemFyZWxsYSA8
c2dhcnphcmVAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Cj4+IFRoZSBuZXcgInVzZV92YSIgbW9kdWxl
IHBhcmFtZXRlciAoZGVmYXVsdDogZmFsc2UpIGlzIHVzZWQgaW4KPj4gdmRwYV9hbGxvY19kZXZp
Y2UoKSB0byBpbmZvcm0gdGhlIHZEUEEgZnJhbWV3b3JrIHRoYXQgdGhlIGRldmljZQo+PiBzdXBw
b3J0cyBWQS4KPj4KPj4gdnJpbmdoIGlzIGluaXRpYWxpemVkIHRvIHVzZSBWQSBvbmx5IHdoZW4g
InVzZV92YSIgaXMgdHJ1ZSBhbmQgdGhlCj4+IHVzZXIncyBtbSBoYXMgYmVlbiBib3VuZC4gU28s
IG9ubHkgd2hlbiB0aGUgYnVzIHN1cHBvcnRzIHVzZXIgVkEKPj4gKGUuZy4gdmhvc3QtdmRwYSku
Cj4+Cj4+IHZkcGFzaW1fbW1fd29ya19mbiB3b3JrIGlzIHVzZWQgdG8gYXR0YWNoIHRoZSBrdGhy
ZWFkIHRvIHRoZSB1c2VyCj4+IGFkZHJlc3Mgc3BhY2Ugd2hlbiB0aGUgLmJpbmRfbW0gY2FsbGJh
Y2sgaXMgaW52b2tlZCwgYW5kIHRvIGRldGFjaAo+PiBpdCB3aGVuIHRoZSAudW5iaW5kX21tIGNh
bGxiYWNrIGlzIGludm9rZWQuCj4+Cj4+IFNpZ25lZC1vZmYtYnk6IFN0ZWZhbm8gR2FyemFyZWxs
YSA8c2dhcnphcmVAcmVkaGF0LmNvbT4KPj4gLS0tCj4+Cj4+IE5vdGVzOgo+PiAgICAgdjI6Cj4+
ICAgICAtIGB1c2VfdmFgIHNldCB0byB0cnVlIGJ5IGRlZmF1bHQgW0V1Z2VuaW9dCj4+ICAgICAt
IHN1cHBvcnRlZCB0aGUgbmV3IHVuYmluZF9tbSBjYWxsYmFjayBbSmFzb25dCj4+ICAgICAtIHJl
bW92ZWQgdGhlIHVuYmluZF9tbSBjYWxsIGluIHZkcGFzaW1fZG9fcmVzZXQoKSBbSmFzb25dCj4+
ICAgICAtIGF2b2lkZWQgdG8gcmVsZWFzZSB0aGUgbG9jayB3aGlsZSBjYWxsIGt0aHJlYWRfZmx1
c2hfd29yaygpIHNpbmNlIHdlCj4+ICAgICAgIGFyZSBub3cgdXNpbmcgYSBtdXRleCB0byBwcm90
ZWN0IHRoZSBkZXZpY2Ugc3RhdGUKPj4KPj4gIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3Np
bS5oIHwgIDEgKwo+PiAgZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmMgfCA5OCArKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrLQo+PiAgMiBmaWxlcyBjaGFuZ2VkLCA5NyBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+Pgo+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBh
L3ZkcGFfc2ltL3ZkcGFfc2ltLmggYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uaAo+
PiBpbmRleCA0Nzc0MjkyZmJhOGMuLjNhNDI4ODdkMDVkOSAxMDA2NDQKPj4gLS0tIGEvZHJpdmVy
cy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltLmgKPj4gKysrIGIvZHJpdmVycy92ZHBhL3ZkcGFfc2lt
L3ZkcGFfc2ltLmgKPj4gQEAgLTU5LDYgKzU5LDcgQEAgc3RydWN0IHZkcGFzaW0gewo+PiAgICAg
ICAgIHN0cnVjdCB2ZHBhc2ltX3ZpcnRxdWV1ZSAqdnFzOwo+PiAgICAgICAgIHN0cnVjdCBrdGhy
ZWFkX3dvcmtlciAqd29ya2VyOwo+PiAgICAgICAgIHN0cnVjdCBrdGhyZWFkX3dvcmsgd29yazsK
Pj4gKyAgICAgICBzdHJ1Y3QgbW1fc3RydWN0ICptbV9ib3VuZDsKPj4gICAgICAgICBzdHJ1Y3Qg
dmRwYXNpbV9kZXZfYXR0ciBkZXZfYXR0cjsKPj4gICAgICAgICAvKiBtdXRleCB0byBzeW5jaHJv
bml6ZSB2aXJ0cXVldWUgc3RhdGUgKi8KPj4gICAgICAgICBzdHJ1Y3QgbXV0ZXggbXV0ZXg7Cj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYyBiL2RyaXZlcnMv
dmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5jCj4+IGluZGV4IGEyODEwM2E2N2FlNy4uZWRhMjZiYzMz
ZGY1IDEwMDY0NAo+PiAtLS0gYS9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+PiAr
KysgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0uYwo+PiBAQCAtMzUsMTAgKzM1LDc3
IEBAIG1vZHVsZV9wYXJhbShtYXhfaW90bGJfZW50cmllcywgaW50LCAwNDQ0KTsKPj4gIE1PRFVM
RV9QQVJNX0RFU0MobWF4X2lvdGxiX2VudHJpZXMsCj4+ICAgICAgICAgICAgICAgICAgIk1heGlt
dW0gbnVtYmVyIG9mIGlvdGxiIGVudHJpZXMgZm9yIGVhY2ggYWRkcmVzcyBzcGFjZS4gMCBtZWFu
cyB1bmxpbWl0ZWQuIChkZWZhdWx0OiAyMDQ4KSIpOwo+Pgo+PiArc3RhdGljIGJvb2wgdXNlX3Zh
ID0gdHJ1ZTsKPj4gK21vZHVsZV9wYXJhbSh1c2VfdmEsIGJvb2wsIDA0NDQpOwo+PiArTU9EVUxF
X1BBUk1fREVTQyh1c2VfdmEsICJFbmFibGUvZGlzYWJsZSB0aGUgZGV2aWNlJ3MgYWJpbGl0eSB0
byB1c2UgVkEiKTsKPj4gKwo+PiAgI2RlZmluZSBWRFBBU0lNX1FVRVVFX0FMSUdOIFBBR0VfU0la
RQo+PiAgI2RlZmluZSBWRFBBU0lNX1FVRVVFX01BWCAyNTYKPj4gICNkZWZpbmUgVkRQQVNJTV9W
RU5ET1JfSUQgMAo+Pgo+PiArc3RydWN0IHZkcGFzaW1fbW1fd29yayB7Cj4+ICsgICAgICAgc3Ry
dWN0IGt0aHJlYWRfd29yayB3b3JrOwo+PiArICAgICAgIHN0cnVjdCBtbV9zdHJ1Y3QgKm1tOwo+
PiArICAgICAgIGJvb2wgYmluZDsKPj4gKyAgICAgICBpbnQgcmV0Owo+PiArfTsKPj4gKwo+PiAr
c3RhdGljIHZvaWQgdmRwYXNpbV9tbV93b3JrX2ZuKHN0cnVjdCBrdGhyZWFkX3dvcmsgKndvcmsp
Cj4+ICt7Cj4+ICsgICAgICAgc3RydWN0IHZkcGFzaW1fbW1fd29yayAqbW1fd29yayA9Cj4+ICsg
ICAgICAgICAgICAgICBjb250YWluZXJfb2Yod29yaywgc3RydWN0IHZkcGFzaW1fbW1fd29yaywg
d29yayk7Cj4+ICsKPj4gKyAgICAgICBtbV93b3JrLT5yZXQgPSAwOwo+PiArCj4+ICsgICAgICAg
aWYgKG1tX3dvcmstPmJpbmQpIHsKPj4gKyAgICAgICAgICAgICAgIGt0aHJlYWRfdXNlX21tKG1t
X3dvcmstPm1tKTsKPj4gKyAgICAgICAgICAgICAgIC8vVE9ETzogc2hvdWxkIHdlIGF0dGFjaCB0
aGUgY2dyb3VwIG9mIHRoZSBtbSBvd25lcj8KPj4gKyAgICAgICB9IGVsc2Ugewo+PiArICAgICAg
ICAgICAgICAga3RocmVhZF91bnVzZV9tbShtbV93b3JrLT5tbSk7Cj4+ICsgICAgICAgfQo+PiAr
fQo+PiArCj4+ICtzdGF0aWMgdm9pZCB2ZHBhc2ltX3dvcmtlcl9xdWV1ZV9tbShzdHJ1Y3QgdmRw
YXNpbSAqdmRwYXNpbSwKPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Ry
dWN0IHZkcGFzaW1fbW1fd29yayAqbW1fd29yaykKPj4gK3sKPgo+Tml0OiB3ZSBuZWVkIHRvIHR3
ZWFrIHRoZSBuYW1lIGFzIGl0IGRvZXMgZmx1c2ggYmVzaWRlcyBxdWV1aW5nIHRoZSB3b3JrLgoK
WWVwLCBvciBzcGxpdCBpbiAyIGZ1bmN0aW9ucy4KCj4KPj4gKyAgICAgICBzdHJ1Y3Qga3RocmVh
ZF93b3JrICp3b3JrID0gJm1tX3dvcmstPndvcms7Cj4+ICsKPj4gKyAgICAgICBrdGhyZWFkX2lu
aXRfd29yayh3b3JrLCB2ZHBhc2ltX21tX3dvcmtfZm4pOwo+PiArICAgICAgIGt0aHJlYWRfcXVl
dWVfd29yayh2ZHBhc2ltLT53b3JrZXIsIHdvcmspOwo+PiArCj4+ICsgICAgICAga3RocmVhZF9m
bHVzaF93b3JrKHdvcmspOwo+PiArfQo+PiArCj4+ICtzdGF0aWMgaW50IHZkcGFzaW1fd29ya2Vy
X2JpbmRfbW0oc3RydWN0IHZkcGFzaW0gKnZkcGFzaW0sCj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBzdHJ1Y3QgbW1fc3RydWN0ICpuZXdfbW0pCj4+ICt7Cj4+ICsgICAgICAg
c3RydWN0IHZkcGFzaW1fbW1fd29yayBtbV93b3JrOwo+PiArCj4+ICsgICAgICAgbW1fd29yay5t
bSA9IG5ld19tbTsKPj4gKyAgICAgICBtbV93b3JrLmJpbmQgPSB0cnVlOwo+PiArCj4+ICsgICAg
ICAgdmRwYXNpbV93b3JrZXJfcXVldWVfbW0odmRwYXNpbSwgJm1tX3dvcmspOwo+PiArCj4+ICsg
ICAgICAgaWYgKCFtbV93b3JrLnJldCkKPj4gKyAgICAgICAgICAgICAgIHZkcGFzaW0tPm1tX2Jv
dW5kID0gbmV3X21tOwo+PiArCj4+ICsgICAgICAgcmV0dXJuIG1tX3dvcmsucmV0Owo+PiArfQo+
PiArCj4+ICtzdGF0aWMgdm9pZCB2ZHBhc2ltX3dvcmtlcl91bmJpbmRfbW0oc3RydWN0IHZkcGFz
aW0gKnZkcGFzaW0pCj4+ICt7Cj4+ICsgICAgICAgc3RydWN0IHZkcGFzaW1fbW1fd29yayBtbV93
b3JrOwo+PiArCj4+ICsgICAgICAgaWYgKCF2ZHBhc2ltLT5tbV9ib3VuZCkKPj4gKyAgICAgICAg
ICAgICAgIHJldHVybjsKPj4gKwo+PiArICAgICAgIG1tX3dvcmsubW0gPSB2ZHBhc2ltLT5tbV9i
b3VuZDsKPj4gKyAgICAgICBtbV93b3JrLmJpbmQgPSBmYWxzZTsKPgo+Q2FuIHdlIHNpbXBseSB1
c2UgbW1fd29yay5tbSA9IE5VTEwgZm9yIHVuYmluZGluZz8KPgo+PiArCj4+ICsgICAgICAgdmRw
YXNpbV93b3JrZXJfcXVldWVfbW0odmRwYXNpbSwgJm1tX3dvcmspOwo+PiArCj4+ICsgICAgICAg
dmRwYXNpbS0+bW1fYm91bmQgPSBOVUxMOwo+Cj5BbmQgY2hhbmdlIHRoZSBtbV9ib3VuZCBpbiB0
aGUgd29ya2VyPwoKWWVwLCBJIG5lZWQgdG8gcHV0IGB2ZHBhc2ltYCBpbiBzdHJ1Y3QgdmRwYXNp
bV9tbV93b3JrLgoKSSdsbCBkbyBpbiB0aGUgbmV4dCB2ZXJzaW9uLgoKVGhhbmtzLApTdGVmYW5v
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
