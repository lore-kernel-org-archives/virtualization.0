Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 908A1C6FD1C
	for <virtualization@archiver.kernel.org>; Thu, 23 Mar 2023 02:56:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 35C0541D83;
	Thu, 23 Mar 2023 02:56:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 35C0541D83
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=EY3EL3tF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tODg4pa6QZ8v; Thu, 23 Mar 2023 02:56:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5141E41D6C;
	Thu, 23 Mar 2023 02:56:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5141E41D6C
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 3AD4FC0071;
	Thu, 23 Mar 2023 02:56:17 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B1C21C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 02:56:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 8C8D9613B6
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 02:56:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 8C8D9613B6
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=EY3EL3tF
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id eQBNWVnkDehj
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 02:56:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org B632A60E96
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id B632A60E96
 for <virtualization@lists.linux-foundation.org>;
 Thu, 23 Mar 2023 02:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679540174;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=IEVV6EVqDAIBSLw4K9/mgBMrY117IXHoZwdpbIk2o+4=;
 b=EY3EL3tF5fpU2n/3UA5oTw/3iJM21YpF/ukVuwf8b5eMtTixg3VoZxqppiAr8oNtxSnnDO
 LirWRxlMS0wmbZZHqxiO/EYdTjxAJXC/75FE6MZT9QUA4nTqv69lpVIfSXvhzscScWe+XY
 O7mUtsE5AOylLlc/EdHVP/Wf+5fCmvw=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-670-IpZmD52HOKS_N9M002wAnQ-1; Wed, 22 Mar 2023 22:56:05 -0400
X-MC-Unique: IpZmD52HOKS_N9M002wAnQ-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-176347f3b28so10766380fac.23
 for <virtualization@lists.linux-foundation.org>;
 Wed, 22 Mar 2023 19:56:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679540165;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=IEVV6EVqDAIBSLw4K9/mgBMrY117IXHoZwdpbIk2o+4=;
 b=6PeE3Q6GpWlwailfvXjv+iq8kB2c8QB8I+90kezyhXF+VQGzbQe7A8/bQPY7MZAsFu
 bfSiwgQxQTZVRe917TDgGEe6vX6qU2nNy8TR33w34yysYop+dpHj8SoBuR+mcaYge3Gw
 yHRewl0eQ5LuYxqpC600Epb2fEVQnmyTl91n5HLlfDEbh9greE8RDeyELjmgr9tybuTw
 rlCEJ2smmOGnofdX/bQdhrCGAHGihKRCrP3cTDyguYCF4Jf60RzCngl+fCyEz1iQ8orp
 pg512kLxJm3GvrViZNqGcqL3S+UgJLjaCXGbIVkKT13PrVvIMRlmlPF2g5QaJ8D3+3X9
 T9jA==
X-Gm-Message-State: AO0yUKWJWMLHHtwfn2hxdsdUMM0NpVjNiLMa8m7FOAAKTv1avs+dy4vv
 lcWqHbX2mQM/qRQQwk5Wx/CqNQhd03FP3J1keq37oZbHM1s58qxy7qVUrU2J0fQVIrEkJIAOcq3
 xYpMRdvJIKvFFxfalwqMvakb0XEg35QNj8EwrYplOgvSt1uS8Gopm3PRSjg==
X-Received: by 2002:a9d:61d8:0:b0:69f:a43d:f6c5 with SMTP id
 h24-20020a9d61d8000000b0069fa43df6c5mr987333otk.2.1679540165119; 
 Wed, 22 Mar 2023 19:56:05 -0700 (PDT)
X-Google-Smtp-Source: AK7set/7PKqzwGOVsKSZ+99cPJMPTD0qnz4ulWAl7IGRg0yj8MIT/TlbRL5kVx0Wiiv8zIMuLq61aCW3RhGR+vyu6Lo=
X-Received: by 2002:a9d:61d8:0:b0:69f:a43d:f6c5 with SMTP id
 h24-20020a9d61d8000000b0069fa43df6c5mr987331otk.2.1679540164923; Wed, 22 Mar
 2023 19:56:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230322025701.2955-1-xuanzhuo@linux.alibaba.com>
 <20230322025701.2955-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20230322025701.2955-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 23 Mar 2023 10:55:53 +0800
Message-ID: <CACGkMEt5LFt4GZj1yshF_3U9O_-kRwP7LZ5W6Scp=UcNKaRY8g@mail.gmail.com>
Subject: Re: [PATCH vhost v4 02/11] virtio_ring: packed: separate dma codes
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gV2VkLCBNYXIgMjIsIDIwMjMgYXQgMTA6NTfigK9BTSBYdWFuIFpodW8gPHh1YW56aHVvQGxp
bnV4LmFsaWJhYmEuY29tPiB3cm90ZToKPgo+IERNQS1yZWxhdGVkIGxvZ2ljIGlzIHNlcGFyYXRl
ZCBmcm9tIHRoZSB2aXJ0cXVldWVfYWRkX3BhY2tlZCgpLiBETUEKPiBhZGRyZXNzIHdpbGwgYmUg
c2F2ZWQgYXMgc2ctPmRtYV9hZGRyZXNzLCB0aGVuIHZpcnRxdWV1ZV9hZGRfcGFja2VkKCkKPiB3
aWxsIHVzZSBpdCBkaXJlY3RseS4gVW5tYXAgb3BlcmF0aW9uIHdpbGwgYmUgc2ltcGxlci4KPgo+
IFRoZSBwdXJwb3NlIG9mIHRoaXMgaXMgdG8gZmFjaWxpdGF0ZSBzdWJzZXF1ZW50IHN1cHBvcnQg
dG8gcmVjZWl2ZQo+IGRtYSBhZGRyZXNzIG1hcHBlZCBieSBkcml2ZXJzLgo+Cj4gU2lnbmVkLW9m
Zi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KPiAtLS0KPiAgZHJp
dmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDM3ICsrKysrKystLS0tLS0tLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspLCAzMCBkZWxldGlv
bnMoLSkKPgo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIGIvZHJp
dmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+IGluZGV4IGZlNzA0Y2E2YzgxMy4uNDJlOGM5ZDQ0
MTYxIDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiArKysgYi9k
cml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gQEAgLTE0MzAsOSArMTQzMCw5IEBAIHN0YXRp
YyBpbmxpbmUgaW50IHZpcnRxdWV1ZV9hZGRfcGFja2VkKHN0cnVjdCB2aXJ0cXVldWUgKl92cSwK
PiAgICAgICAgIHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZxKF92cSk7Cj4gICAg
ICAgICBzdHJ1Y3QgdnJpbmdfcGFja2VkX2Rlc2MgKmRlc2M7Cj4gICAgICAgICBzdHJ1Y3Qgc2Nh
dHRlcmxpc3QgKnNnOwo+IC0gICAgICAgdW5zaWduZWQgaW50IGksIG4sIGMsIGRlc2NzX3VzZWQs
IGVycl9pZHg7Cj4gKyAgICAgICB1bnNpZ25lZCBpbnQgaSwgbiwgYywgZGVzY3NfdXNlZDsKPiAg
ICAgICAgIF9fbGUxNiBoZWFkX2ZsYWdzLCBmbGFnczsKPiAtICAgICAgIHUxNiBoZWFkLCBpZCwg
cHJldiwgY3VyciwgYXZhaWxfdXNlZF9mbGFnczsKPiArICAgICAgIHUxNiBoZWFkLCBpZCwgcHJl
diwgY3VycjsKPiAgICAgICAgIGludCBlcnI7Cj4KPiAgICAgICAgIFNUQVJUX1VTRSh2cSk7Cj4g
QEAgLTE0NjEsNyArMTQ2MSw2IEBAIHN0YXRpYyBpbmxpbmUgaW50IHZpcnRxdWV1ZV9hZGRfcGFj
a2VkKHN0cnVjdCB2aXJ0cXVldWUgKl92cSwKPiAgICAgICAgIH0KPgo+ICAgICAgICAgaGVhZCA9
IHZxLT5wYWNrZWQubmV4dF9hdmFpbF9pZHg7Cj4gLSAgICAgICBhdmFpbF91c2VkX2ZsYWdzID0g
dnEtPnBhY2tlZC5hdmFpbF91c2VkX2ZsYWdzOwo+Cj4gICAgICAgICBXQVJOX09OX09OQ0UodG90
YWxfc2cgPiB2cS0+cGFja2VkLnZyaW5nLm51bSAmJiAhdnEtPmluZGlyZWN0KTsKPgo+IEBAIC0x
NDc5LDE1ICsxNDc4LDEzIEBAIHN0YXRpYyBpbmxpbmUgaW50IHZpcnRxdWV1ZV9hZGRfcGFja2Vk
KHN0cnVjdCB2aXJ0cXVldWUgKl92cSwKPiAgICAgICAgIGlkID0gdnEtPmZyZWVfaGVhZDsKPiAg
ICAgICAgIEJVR19PTihpZCA9PSB2cS0+cGFja2VkLnZyaW5nLm51bSk7Cj4KPiArICAgICAgIGlm
ICh2aXJ0cXVldWVfbWFwX3Nncyh2cSwgc2dzLCB0b3RhbF9zZywgb3V0X3NncywgaW5fc2dzKSkK
CkVORF9VU0UodnEpIGlzIG5lZWRlZC4KCj4gKyAgICAgICAgICAgICAgIHJldHVybiAtRU5PTUVN
OwoKSXMgaXQgYmV0dGVyIHRvIHVzZSAtRUlPICh3ZSB1c2UgdGhpcyBiZWZvcmUgdGhpcyBwYXRj
aCkuCgpXaXRoIHRob3NlIGZpeGVkLCB5b3UgY2FuIGFkZCBteToKCkFja2VkLWJ5OiBKYXNvbiBX
YW5nIDxqYXNvd2FuZ0ByZWRoYXQuY29tPgoKVGhhbmtzCgoKCj4gKwo+ICAgICAgICAgY3VyciA9
IGlkOwo+ICAgICAgICAgYyA9IDA7Cj4gICAgICAgICBmb3IgKG4gPSAwOyBuIDwgb3V0X3NncyAr
IGluX3NnczsgbisrKSB7Cj4gICAgICAgICAgICAgICAgIGZvciAoc2cgPSBzZ3Nbbl07IHNnOyBz
ZyA9IHNnX25leHQoc2cpKSB7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgZG1hX2FkZHJfdCBh
ZGRyID0gdnJpbmdfbWFwX29uZV9zZyh2cSwgc2csIG4gPCBvdXRfc2dzID8KPiAtICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRE1BX1RPX0RFVklDRSA6IERNQV9GUk9NX0RF
VklDRSk7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgaWYgKHZyaW5nX21hcHBpbmdfZXJyb3Io
dnEsIGFkZHIpKQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgZ290byB1bm1hcF9y
ZWxlYXNlOwo+IC0KPiAgICAgICAgICAgICAgICAgICAgICAgICBmbGFncyA9IGNwdV90b19sZTE2
KHZxLT5wYWNrZWQuYXZhaWxfdXNlZF9mbGFncyB8Cj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKCsrYyA9PSB0b3RhbF9zZyA/IDAgOiBWUklOR19ERVNDX0ZfTkVYVCkgfAo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIChuIDwgb3V0X3NncyA/IDAgOiBW
UklOR19ERVNDX0ZfV1JJVEUpKTsKPiBAQCAtMTQ5NiwxMiArMTQ5MywxMiBAQCBzdGF0aWMgaW5s
aW5lIGludCB2aXJ0cXVldWVfYWRkX3BhY2tlZChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEsCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgZWxzZQo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgZGVzY1tpXS5mbGFncyA9IGZsYWdzOwo+Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgZGVz
Y1tpXS5hZGRyID0gY3B1X3RvX2xlNjQoYWRkcik7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAg
ZGVzY1tpXS5hZGRyID0gY3B1X3RvX2xlNjQodnJpbmdfc2dfYWRkcmVzcyhzZykpOwo+ICAgICAg
ICAgICAgICAgICAgICAgICAgIGRlc2NbaV0ubGVuID0gY3B1X3RvX2xlMzIoc2ctPmxlbmd0aCk7
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgZGVzY1tpXS5pZCA9IGNwdV90b19sZTE2KGlkKTsK
Pgo+ICAgICAgICAgICAgICAgICAgICAgICAgIGlmICh1bmxpa2VseSh2cS0+dXNlX2RtYV9hcGkp
KSB7Cj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2cS0+cGFja2VkLmRlc2NfZXh0
cmFbY3Vycl0uYWRkciA9IGFkZHI7Cj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2
cS0+cGFja2VkLmRlc2NfZXh0cmFbY3Vycl0uYWRkciA9IHZyaW5nX3NnX2FkZHJlc3Moc2cpOwo+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdnEtPnBhY2tlZC5kZXNjX2V4dHJhW2N1
cnJdLmxlbiA9IHNnLT5sZW5ndGg7Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2
cS0+cGFja2VkLmRlc2NfZXh0cmFbY3Vycl0uZmxhZ3MgPQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBsZTE2X3RvX2NwdShmbGFncyk7Cj4gQEAgLTE1NDcsMjYgKzE1
NDQsNiBAQCBzdGF0aWMgaW5saW5lIGludCB2aXJ0cXVldWVfYWRkX3BhY2tlZChzdHJ1Y3Qgdmly
dHF1ZXVlICpfdnEsCj4gICAgICAgICBFTkRfVVNFKHZxKTsKPgo+ICAgICAgICAgcmV0dXJuIDA7
Cj4gLQo+IC11bm1hcF9yZWxlYXNlOgo+IC0gICAgICAgZXJyX2lkeCA9IGk7Cj4gLSAgICAgICBp
ID0gaGVhZDsKPiAtICAgICAgIGN1cnIgPSB2cS0+ZnJlZV9oZWFkOwo+IC0KPiAtICAgICAgIHZx
LT5wYWNrZWQuYXZhaWxfdXNlZF9mbGFncyA9IGF2YWlsX3VzZWRfZmxhZ3M7Cj4gLQo+IC0gICAg
ICAgZm9yIChuID0gMDsgbiA8IHRvdGFsX3NnOyBuKyspIHsKPiAtICAgICAgICAgICAgICAgaWYg
KGkgPT0gZXJyX2lkeCkKPiAtICAgICAgICAgICAgICAgICAgICAgICBicmVhazsKPiAtICAgICAg
ICAgICAgICAgdnJpbmdfdW5tYXBfZXh0cmFfcGFja2VkKHZxLCAmdnEtPnBhY2tlZC5kZXNjX2V4
dHJhW2N1cnJdKTsKPiAtICAgICAgICAgICAgICAgY3VyciA9IHZxLT5wYWNrZWQuZGVzY19leHRy
YVtjdXJyXS5uZXh0Owo+IC0gICAgICAgICAgICAgICBpKys7Cj4gLSAgICAgICAgICAgICAgIGlm
IChpID49IHZxLT5wYWNrZWQudnJpbmcubnVtKQo+IC0gICAgICAgICAgICAgICAgICAgICAgIGkg
PSAwOwo+IC0gICAgICAgfQo+IC0KPiAtICAgICAgIEVORF9VU0UodnEpOwo+IC0gICAgICAgcmV0
dXJuIC1FSU87Cj4gIH0KPgo+ICBzdGF0aWMgYm9vbCB2aXJ0cXVldWVfa2lja19wcmVwYXJlX3Bh
Y2tlZChzdHJ1Y3QgdmlydHF1ZXVlICpfdnEpCj4gLS0KPiAyLjMyLjAuMy5nMDExOTVjZjlmCj4K
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
