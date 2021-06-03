Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55D76C4708F
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 03:14:11 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 0A8F861263
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 03:14:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 0A8F861263
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id B6AA283E0F;
	Thu,  3 Jun 2021 03:14:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id OLyXSmlka9xo; Thu,  3 Jun 2021 03:14:09 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTP id 3B7E783E0B;
	Thu,  3 Jun 2021 03:14:09 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 20BCFC000E;
	Thu,  3 Jun 2021 03:14:09 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5792EC0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 03:14:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3D8DF83E0B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 03:14:08 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id z7MCq4u-W4x2
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 03:14:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 093CA83E0A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 03:14:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622690046;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=EdxrEtb0sFDVJQB6XAX1IEbvLZt1yFIQv0NEiyIEt2A=;
 b=L0yMw8GHoWZ/L0YEtZ60cw7Tj9uNJSJGoFPUv/oqa5v/OZr1TWNcesxHw6Qgmw8vvtQIs+
 Tkw815AacG6twbuAbYrTtgIh65TcSZLLzphEtFkjMO24AvMnoyKTUTqD2aycuH1BKHocpg
 K/YryCxYXmH+HmO6RenTysO3qJsQNRI=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-0bBwUKiHMvaGlWCAWCj4DQ-1; Wed, 02 Jun 2021 23:14:04 -0400
X-MC-Unique: 0bBwUKiHMvaGlWCAWCj4DQ-1
Received: by mail-pl1-f200.google.com with SMTP id
 u14-20020a170903304eb02900ec9757f3dbso2002975pla.17
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Jun 2021 20:14:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=EdxrEtb0sFDVJQB6XAX1IEbvLZt1yFIQv0NEiyIEt2A=;
 b=Mce+/MmfKI0mOZbKBJ1298++VE5bKpxKCR7NNN/Y3Qf9/ydBaeQiMCjLRTwgZjNaz3
 zOeRgpKsyug5O6SUPF3hYBb1eLvWZaHRmumlv+FPTwSEbszlC8PfYUBFn4XUIGuinGnB
 ItfS2QbkIFdkr8Jsq5snOY1mOR5cUSENVgzonWG1B8Kj9MG7Kz7BbmneDOFlzbTFwREJ
 Ibgl3tfiPamkh+MEq4DL0MBiufNQyJHP8Xb79sRhhsRdmGUDU5leLnd3r1cYXKVdwydA
 3DjvQ4WiG+A2LGwBsPr8yUchh3i5VkmNaxx2wta3TG3OEXa32E/Xk3aNiDaAt9DbEyFf
 wrSQ==
X-Gm-Message-State: AOAM533iky0n+WjfXWY+KPy3P4lzig3IoeiIY9J22wFXq/67DbZXElnN
 59c7bVjSPyGRurI55M3D+rxjf9m7O+u8Vo+zIxOamARaAga4h1oIc3pv1VmgIY2FoleQcY1q3wh
 94Xw7ttcUlMYVrJpBmDYw3Wn2vk3+VeOKODPoqcok7FBNbM3P54TY3shhwmP9s8CIsN9tlTDAs1
 olVKgJjrASulGSpSUHQw==
X-Received: by 2002:a17:90a:3c83:: with SMTP id
 g3mr3413987pjc.123.1622690043538; 
 Wed, 02 Jun 2021 20:14:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzSnP7Gue7BFOqyvRj3lFOXLF4HGINngfq0sXShIpRyjFb/Y3dp8DjJaHnp1TJwjNQBll87DA==
X-Received: by 2002:a17:90a:3c83:: with SMTP id
 g3mr3413950pjc.123.1622690043246; 
 Wed, 02 Jun 2021 20:14:03 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id j4sm693066pjv.7.2021.06.02.20.13.58
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Jun 2021 20:14:02 -0700 (PDT)
Subject: Re: [RFC v3 13/29] vhost: Add vhost_get_iova_range operation
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20210519162903.1172366-1-eperezma@redhat.com>
 <20210519162903.1172366-14-eperezma@redhat.com>
 <e0114c64-2620-7a72-6445-3035ceb748ac@redhat.com>
 <CAJaqyWeL-0KjsBcXs1tYdvn9xLAK-x0Sb+RFuzPgngXxYtF9uw@mail.gmail.com>
 <b9dd6708-015e-d451-b368-f9376c00f6ad@redhat.com>
 <CAJaqyWf+=-nwOsS=zZEhmiTA_TotVMQibUgE0grCMZgXVDNpxg@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <90cd3551-f05b-0270-b5ed-890f578c01b9@redhat.com>
Date: Thu, 3 Jun 2021 11:13:56 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAJaqyWf+=-nwOsS=zZEhmiTA_TotVMQibUgE0grCMZgXVDNpxg@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Markus Armbruster <armbru@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <eli@mellanox.com>,
 virtualization@lists.linux-foundation.org, Eric Blake <eblake@redhat.com>,
 Michael Lilja <ml@napatech.com>
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

CuWcqCAyMDIxLzYvMSDkuIvljYgzOjE3LCBFdWdlbmlvIFBlcmV6IE1hcnRpbiDlhpnpgZM6Cj4g
T24gVGh1LCBNYXkgMjcsIDIwMjEgYXQgNjo1MSBBTSBKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiB3cm90ZToKPj4KPj4g5ZyoIDIwMjEvNS8yNyDkuIrljYgxOjQ5LCBFdWdlbmlvIFBl
cmV6IE1hcnRpbiDlhpnpgZM6Cj4+PiBPbiBXZWQsIE1heSAyNiwgMjAyMSBhdCAzOjE0IEFNIEph
c29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+IHdyb3RlOgo+Pj4+IOWcqCAyMDIxLzUvMjAg
5LiK5Y2IMTI6MjgsIEV1Z2VuaW8gUMOpcmV6IOWGmemBkzoKPj4+Pj4gRm9yIHNpbXBsaWNpdHks
IElmIGEgZGV2aWNlIGRvZXMgbm90IHN1cHBvcnQgdGhpcyBvcGVyYXRpb24gaXQgbWVhbnMKPj4+
Pj4gdGhhdCBpdCBjYW4gaGFuZGxlIGZ1bGwgKHVpbnQ2NF90KS0xIGlvdmEgYWRkcmVzcy4KPj4+
PiBOb3RlIHRoYXQsIHdlIHByb2JhYmx5IG5lZWQgYSBzZXBhcmF0ZWQgcGF0Y2ggZm9yIHRoaXMu
Cj4+Pj4KPj4+IEFjdHVhbGx5IHRoZSBjb21tZW50IGlzIG5vdCBpbiB0aGUgcmlnaHQgY29tbWl0
LCB0aGUgbmV4dCBvbmUgaXMgdGhlCj4+PiBvbmUgdGhhdCB1c2VzIGl0LiBJcyB0aGF0IHdoYXQg
eW91IG1lYW4/Cj4+Cj4+IE5vLCBpdCdzIGFib3V0IHRoZSBmb2xsb3dpbmcgc3VnZ2VzdGlvbnMu
Cj4+Cj4+Cj4+Pj4gQW5kIHdlIG5lZWQgdG8gdGhpcyBkdXJpbmcgdmhvc3QtdmRwYSBpbml0aWFs
aXphdGlvbi4gSWYgR1BBIGlzIG91dCBvZgo+Pj4+IHRoZSByYW5nZSwgd2UgbmVlZCB0byBmYWls
IHRoZSBzdGFydCBvZiB2aG9zdC12ZHBhLgo+Pgo+PiBOb3RlIHRoYXQgdGhpcyBpcyBmb3Igbm9u
LUlPTU1VIGNhc2UuIEZvciB0aGUgY2FzZSBvZiB2SU9NTVUgd2UgcHJvYmFibHkKPj4gbmVlZCB0
byB2YWxpZGF0ZSBpdCBhZ2FpbnN0IGFkZHJlc3Mgd2lkdGggb3Igb3RoZXIgc2ltaWxhciBhdHRy
aWJ1dGVzLgo+Pgo+IFJpZ2h0Lgo+Cj4gV2hhdCBzaG91bGQgcWVtdSBkbyBpZiB0aGUgbWVtb3J5
IG9mIHRoZSBndWVzdCBnZXRzIGV4cGFuZGVkIG91dHNpZGUKPiBvZiB0aGUgcmFuZ2U/IEkgdGhp
bmsgdGhlcmUgaXMgbm90IGEgY2xlYXIgd2F5IHRvIGZhaWwgdGhlIG1lbW9yeQo+IGFkZGl0aW9u
LCBpc24ndCBpdD8KCgpJJ20gbm90IHN1cmUsIGJ1dCBJIGd1ZXNzIHRoZXJlIHNob3VsZCBiZSBh
IHdheSB0byBmYWlsIHRoZSBtZW1vcnkgaG90LWFkZC4KCihvdGhlcndpc2Ugd2UgY2FuIGludHJv
ZHVjZSB0aGUgZXJyb3IgcmVwb3J0aW5nIGZvciB0aGVtKQoKVGhhbmtzCgoKPgo+PiBUaGFua3MK
Pj4KPj4KPj4+IFJpZ2h0LCB0aGF0IGlzIHN0aWxsIHRvLWRvLgo+Pj4KPj4+IE1heWJlIGEgc2Vy
aWVzIHdpdGgganVzdCB0aGVzZSB0d28gY29tbWl0cyBhbmQgZmFpbGluZyB0aGUgc3RhcnQgaWYK
Pj4+IEdQQSBpcyBub3QgaW4gdGhlIHJhbmdlLCBhcyB5b3Ugc2F5LCB3b3VsZCBoZWxwIHRvIHNw
bGl0IHRoZSBhbW91bnQgb2YKPj4+IGNoYW5nZXMuCj4+Pgo+Pj4gSSB3aWxsIHNlbmQgaXQgaWYg
bm8gbW9yZSBjb21tZW50cyBhcmlzZSBhYm91dCBpdC4KPj4+Cj4+PiBUaGFua3MhCj4+Pgo+Pj4+
IFRIYW5rcwo+Pj4+Cj4+Pj4KPj4+Pj4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVw
ZXJlem1hQHJlZGhhdC5jb20+Cj4+Pj4+IC0tLQo+Pj4+PiAgICAgaW5jbHVkZS9ody92aXJ0aW8v
dmhvc3QtYmFja2VuZC5oIHwgIDUgKysrKysKPj4+Pj4gICAgIGh3L3ZpcnRpby92aG9zdC12ZHBh
LmMgICAgICAgICAgICB8IDE4ICsrKysrKysrKysrKysrKysrKwo+Pj4+PiAgICAgaHcvdmlydGlv
L3RyYWNlLWV2ZW50cyAgICAgICAgICAgIHwgIDEgKwo+Pj4+PiAgICAgMyBmaWxlcyBjaGFuZ2Vk
LCAyNCBpbnNlcnRpb25zKCspCj4+Pj4+Cj4+Pj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2h3L3Zp
cnRpby92aG9zdC1iYWNrZW5kLmggYi9pbmNsdWRlL2h3L3ZpcnRpby92aG9zdC1iYWNrZW5kLmgK
Pj4+Pj4gaW5kZXggOTRkMzMyMzkwNS4uYmNiMTEyYzE2NiAxMDA2NDQKPj4+Pj4gLS0tIGEvaW5j
bHVkZS9ody92aXJ0aW8vdmhvc3QtYmFja2VuZC5oCj4+Pj4+ICsrKyBiL2luY2x1ZGUvaHcvdmly
dGlvL3Zob3N0LWJhY2tlbmQuaAo+Pj4+PiBAQCAtMzYsNiArMzYsNyBAQCBzdHJ1Y3Qgdmhvc3Rf
dnJpbmdfYWRkcjsKPj4+Pj4gICAgIHN0cnVjdCB2aG9zdF9zY3NpX3RhcmdldDsKPj4+Pj4gICAg
IHN0cnVjdCB2aG9zdF9pb3RsYl9tc2c7Cj4+Pj4+ICAgICBzdHJ1Y3Qgdmhvc3RfdmlydHF1ZXVl
Owo+Pj4+PiArc3RydWN0IHZob3N0X3ZkcGFfaW92YV9yYW5nZTsKPj4+Pj4KPj4+Pj4gICAgIHR5
cGVkZWYgaW50ICgqdmhvc3RfYmFja2VuZF9pbml0KShzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIHZv
aWQgKm9wYXF1ZSk7Cj4+Pj4+ICAgICB0eXBlZGVmIGludCAoKnZob3N0X2JhY2tlbmRfY2xlYW51
cCkoc3RydWN0IHZob3N0X2RldiAqZGV2KTsKPj4+Pj4gQEAgLTEyNyw2ICsxMjgsOSBAQCB0eXBl
ZGVmIGJvb2wgKCp2aG9zdF9mb3JjZV9pb21tdV9vcCkoc3RydWN0IHZob3N0X2RldiAqZGV2KTsK
Pj4+Pj4KPj4+Pj4gICAgIHR5cGVkZWYgaW50ICgqdmhvc3RfdnJpbmdfcGF1c2Vfb3ApKHN0cnVj
dCB2aG9zdF9kZXYgKmRldik7Cj4+Pj4+Cj4+Pj4+ICt0eXBlZGVmIGludCAoKnZob3N0X2dldF9p
b3ZhX3JhbmdlKShzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4+Pj4+ICsgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBod2FkZHIgKmZpcnN0LCBod2FkZHIgKmxhc3QpOwo+Pj4+PiAr
Cj4+Pj4+ICAgICB0eXBlZGVmIHN0cnVjdCBWaG9zdE9wcyB7Cj4+Pj4+ICAgICAgICAgVmhvc3RC
YWNrZW5kVHlwZSBiYWNrZW5kX3R5cGU7Cj4+Pj4+ICAgICAgICAgdmhvc3RfYmFja2VuZF9pbml0
IHZob3N0X2JhY2tlbmRfaW5pdDsKPj4+Pj4gQEAgLTE3Myw2ICsxNzcsNyBAQCB0eXBlZGVmIHN0
cnVjdCBWaG9zdE9wcyB7Cj4+Pj4+ICAgICAgICAgdmhvc3RfZ2V0X2RldmljZV9pZF9vcCB2aG9z
dF9nZXRfZGV2aWNlX2lkOwo+Pj4+PiAgICAgICAgIHZob3N0X3ZyaW5nX3BhdXNlX29wIHZob3N0
X3ZyaW5nX3BhdXNlOwo+Pj4+PiAgICAgICAgIHZob3N0X2ZvcmNlX2lvbW11X29wIHZob3N0X2Zv
cmNlX2lvbW11Owo+Pj4+PiArICAgIHZob3N0X2dldF9pb3ZhX3JhbmdlIHZob3N0X2dldF9pb3Zh
X3JhbmdlOwo+Pj4+PiAgICAgfSBWaG9zdE9wczsKPj4+Pj4KPj4+Pj4gICAgIGV4dGVybiBjb25z
dCBWaG9zdE9wcyB1c2VyX29wczsKPj4+Pj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aG9zdC12
ZHBhLmMgYi9ody92aXJ0aW8vdmhvc3QtdmRwYS5jCj4+Pj4+IGluZGV4IDAxZDIxMDFkMDkuLjc0
ZmU5MjkzNWUgMTAwNjQ0Cj4+Pj4+IC0tLSBhL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMKPj4+Pj4g
KysrIGIvaHcvdmlydGlvL3Zob3N0LXZkcGEuYwo+Pj4+PiBAQCAtNTc5LDYgKzU3OSwyMyBAQCBz
dGF0aWMgYm9vbCAgdmhvc3RfdmRwYV9mb3JjZV9pb21tdShzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYp
Cj4+Pj4+ICAgICAgICAgcmV0dXJuIHRydWU7Cj4+Pj4+ICAgICB9Cj4+Pj4+Cj4+Pj4+ICtzdGF0
aWMgaW50IHZob3N0X3ZkcGFfZ2V0X2lvdmFfcmFuZ2Uoc3RydWN0IHZob3N0X2RldiAqZGV2LAo+
Pj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGh3YWRkciAqZmlyc3Qs
IGh3YWRkciAqbGFzdCkKPj4+Pj4gK3sKPj4+Pj4gKyAgICBpbnQgcmV0Owo+Pj4+PiArICAgIHN0
cnVjdCB2aG9zdF92ZHBhX2lvdmFfcmFuZ2UgcmFuZ2U7Cj4+Pj4+ICsKPj4+Pj4gKyAgICByZXQg
PSB2aG9zdF92ZHBhX2NhbGwoZGV2LCBWSE9TVF9WRFBBX0dFVF9JT1ZBX1JBTkdFLCAmcmFuZ2Up
Owo+Pj4+PiArICAgIGlmIChyZXQgIT0gMCkgewo+Pj4+PiArICAgICAgICByZXR1cm4gcmV0Owo+
Pj4+PiArICAgIH0KPj4+Pj4gKwo+Pj4+PiArICAgICpmaXJzdCA9IHJhbmdlLmZpcnN0Owo+Pj4+
PiArICAgICpsYXN0ID0gcmFuZ2UubGFzdDsKPj4+Pj4gKyAgICB0cmFjZV92aG9zdF92ZHBhX2dl
dF9pb3ZhX3JhbmdlKGRldiwgKmZpcnN0LCAqbGFzdCk7Cj4+Pj4+ICsgICAgcmV0dXJuIHJldDsK
Pj4+Pj4gK30KPj4+Pj4gKwo+Pj4+PiAgICAgY29uc3QgVmhvc3RPcHMgdmRwYV9vcHMgPSB7Cj4+
Pj4+ICAgICAgICAgICAgIC5iYWNrZW5kX3R5cGUgPSBWSE9TVF9CQUNLRU5EX1RZUEVfVkRQQSwK
Pj4+Pj4gICAgICAgICAgICAgLnZob3N0X2JhY2tlbmRfaW5pdCA9IHZob3N0X3ZkcGFfaW5pdCwK
Pj4+Pj4gQEAgLTYxMSw0ICs2MjgsNSBAQCBjb25zdCBWaG9zdE9wcyB2ZHBhX29wcyA9IHsKPj4+
Pj4gICAgICAgICAgICAgLnZob3N0X2dldF9kZXZpY2VfaWQgPSB2aG9zdF92ZHBhX2dldF9kZXZp
Y2VfaWQsCj4+Pj4+ICAgICAgICAgICAgIC52aG9zdF92cV9nZXRfYWRkciA9IHZob3N0X3ZkcGFf
dnFfZ2V0X2FkZHIsCj4+Pj4+ICAgICAgICAgICAgIC52aG9zdF9mb3JjZV9pb21tdSA9IHZob3N0
X3ZkcGFfZm9yY2VfaW9tbXUsCj4+Pj4+ICsgICAgICAgIC52aG9zdF9nZXRfaW92YV9yYW5nZSA9
IHZob3N0X3ZkcGFfZ2V0X2lvdmFfcmFuZ2UsCj4+Pj4+ICAgICB9Owo+Pj4+PiBkaWZmIC0tZ2l0
IGEvaHcvdmlydGlvL3RyYWNlLWV2ZW50cyBiL2h3L3ZpcnRpby90cmFjZS1ldmVudHMKPj4+Pj4g
aW5kZXggYzYyNzI3Zjg3OS4uNWRlYmUzYTY4MSAxMDA2NDQKPj4+Pj4gLS0tIGEvaHcvdmlydGlv
L3RyYWNlLWV2ZW50cwo+Pj4+PiArKysgYi9ody92aXJ0aW8vdHJhY2UtZXZlbnRzCj4+Pj4+IEBA
IC01Miw2ICs1Miw3IEBAIHZob3N0X3ZkcGFfc2V0X3ZyaW5nX2NhbGwodm9pZCAqZGV2LCB1bnNp
Z25lZCBpbnQgaW5kZXgsIGludCBmZCkgImRldjogJXAgaW5kZXg6Cj4+Pj4+ICAgICB2aG9zdF92
ZHBhX2dldF9mZWF0dXJlcyh2b2lkICpkZXYsIHVpbnQ2NF90IGZlYXR1cmVzKSAiZGV2OiAlcCBm
ZWF0dXJlczogMHglIlBSSXg2NAo+Pj4+PiAgICAgdmhvc3RfdmRwYV9zZXRfb3duZXIodm9pZCAq
ZGV2KSAiZGV2OiAlcCIKPj4+Pj4gICAgIHZob3N0X3ZkcGFfdnFfZ2V0X2FkZHIodm9pZCAqZGV2
LCB2b2lkICp2cSwgdWludDY0X3QgZGVzY191c2VyX2FkZHIsIHVpbnQ2NF90IGF2YWlsX3VzZXJf
YWRkciwgdWludDY0X3QgdXNlZF91c2VyX2FkZHIpICJkZXY6ICVwIHZxOiAlcCBkZXNjX3VzZXJf
YWRkcjogMHglIlBSSXg2NCIgYXZhaWxfdXNlcl9hZGRyOiAweCUiUFJJeDY0IiB1c2VkX3VzZXJf
YWRkcjogMHglIlBSSXg2NAo+Pj4+PiArdmhvc3RfdmRwYV9nZXRfaW92YV9yYW5nZSh2b2lkICpk
ZXYsIHVpbnQ2NF90IGZpcnN0LCB1aW50NjRfdCBsYXN0KSAiZGV2OiAlcCBmaXJzdDogMHglIlBS
SXg2NCIgbGFzdDogMHglIlBSSXg2NAo+Pj4+Pgo+Pj4+PiAgICAgIyB2aXJ0aW8uYwo+Pj4+PiAg
ICAgdmlydHF1ZXVlX2FsbG9jX2VsZW1lbnQodm9pZCAqZWxlbSwgc2l6ZV90IHN6LCB1bnNpZ25l
ZCBpbl9udW0sIHVuc2lnbmVkIG91dF9udW0pICJlbGVtICVwIHNpemUgJXpkIGluX251bSAldSBv
dXRfbnVtICV1IgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
