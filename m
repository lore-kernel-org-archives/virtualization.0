Return-Path: <SRS0=l/A6=KW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DADAC4708A
	for <virtualization@archiver.kernel.org>; Thu, 27 May 2021 04:51:53 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C4A1613CC
	for <virtualization@archiver.kernel.org>; Thu, 27 May 2021 04:51:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C4A1613CC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id BA5CE40590;
	Thu, 27 May 2021 04:51:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id G22kyrbcwa57; Thu, 27 May 2021 04:51:51 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id F41B040591;
	Thu, 27 May 2021 04:51:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C3C1CC000E;
	Thu, 27 May 2021 04:51:50 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 37EF4C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 04:51:49 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1035D40590
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 04:51:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kwjg_ZbUDfKO
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 04:51:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id D152640597
 for <virtualization@lists.linux-foundation.org>;
 Thu, 27 May 2021 04:51:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622091106;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qGfRpWt4UBd8NHUUTLbkFQr+E3eMuZ+NXpMQJulWG4o=;
 b=YAP9jYzPkzaG8DMylBS0zfaOpdY9BFtGM5/YkdXbacm2MbQnS3f3cLcBwU7j6iyCWhqe0N
 6LQxb/vy6DNolWndKIiwlUY7K5/Dzt/YCXCtgGSXEv6Yi0nnXFEgSsRlW+KBqjs3V7V4bl
 NxQH9aMQkNP4xbu9ETkunjr7Ni75UnI=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-289-NANURGfIPQWTMMzRbYM3nA-1; Thu, 27 May 2021 00:51:44 -0400
X-MC-Unique: NANURGfIPQWTMMzRbYM3nA-1
Received: by mail-pj1-f69.google.com with SMTP id
 em20-20020a17090b0154b029015d6b612e97so1805299pjb.3
 for <virtualization@lists.linux-foundation.org>;
 Wed, 26 May 2021 21:51:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=qGfRpWt4UBd8NHUUTLbkFQr+E3eMuZ+NXpMQJulWG4o=;
 b=GjcmALNKGT5ABRpvawAFon/yfzQv1Vv8frXtkW7HYXsW2/tDXZZKrdurLOO6RAwUvk
 NjNBWcO+ny87nyD0U7vKjX3/VQ3FXcLtXv6CZ2ed+N8/Qjnb27QTrdMnvlvNUluzeusb
 4NpYHKVqguC867HicKaAZuDWUPZR4T1g0d6YLK8NeY/pn43oErXNfxMl8SSac5hw3Hid
 2d7zvzp8oUKWf0RLTtUDAnklP14gNm1b9jvKCbo6M6HqOuFbwT5nqHGhpyRxNMZQsuYw
 N240A+Hd0OpBFdRqL4VUKfiig+jrTBW0UmnjjNkcqpQGJ98CqlAnOVIAlfdsHXvkdEeY
 c5IA==
X-Gm-Message-State: AOAM532E38Z8aPa2TXhfYAx4s8WSl7ShdB9uTJs1XGwJln/2K+go5iYo
 WZ+acuUsyX0eOif6EP+vTr/LiPX9ql9elMXYjRZfAvgyrNm9NqktZU0Fp7p8edC7ewPdNjzbGPr
 OEwy5ffmP/kU4/Iw0+KBDo/W++Nxn5FiwsUZScpidYXu8NNJjoJmUjTiF0IoCuAcwpI/5PcP2eQ
 jpLE4YEMpwUW72wUcs7A==
X-Received: by 2002:a62:148e:0:b029:2e4:e5a5:7e33 with SMTP id
 136-20020a62148e0000b02902e4e5a57e33mr1956052pfu.9.1622091103215; 
 Wed, 26 May 2021 21:51:43 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJygA4qycSHbsOrqmifVbbchz2+kIQit2xMqxcoErhlGXuvcb6na5ae85EMcxl8L4QsqgfYDTQ==
X-Received: by 2002:a62:148e:0:b029:2e4:e5a5:7e33 with SMTP id
 136-20020a62148e0000b02902e4e5a57e33mr1956021pfu.9.1622091102823; 
 Wed, 26 May 2021 21:51:42 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id x29sm590590pgl.49.2021.05.26.21.51.37
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 26 May 2021 21:51:42 -0700 (PDT)
Subject: Re: [RFC v3 13/29] vhost: Add vhost_get_iova_range operation
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20210519162903.1172366-1-eperezma@redhat.com>
 <20210519162903.1172366-14-eperezma@redhat.com>
 <e0114c64-2620-7a72-6445-3035ceb748ac@redhat.com>
 <CAJaqyWeL-0KjsBcXs1tYdvn9xLAK-x0Sb+RFuzPgngXxYtF9uw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b9dd6708-015e-d451-b368-f9376c00f6ad@redhat.com>
Date: Thu, 27 May 2021 12:51:35 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAJaqyWeL-0KjsBcXs1tYdvn9xLAK-x0Sb+RFuzPgngXxYtF9uw@mail.gmail.com>
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

CuWcqCAyMDIxLzUvMjcg5LiK5Y2IMTo0OSwgRXVnZW5pbyBQZXJleiBNYXJ0aW4g5YaZ6YGTOgo+
IE9uIFdlZCwgTWF5IDI2LCAyMDIxIGF0IDM6MTQgQU0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVk
aGF0LmNvbT4gd3JvdGU6Cj4+Cj4+IOWcqCAyMDIxLzUvMjAg5LiK5Y2IMTI6MjgsIEV1Z2VuaW8g
UMOpcmV6IOWGmemBkzoKPj4+IEZvciBzaW1wbGljaXR5LCBJZiBhIGRldmljZSBkb2VzIG5vdCBz
dXBwb3J0IHRoaXMgb3BlcmF0aW9uIGl0IG1lYW5zCj4+PiB0aGF0IGl0IGNhbiBoYW5kbGUgZnVs
bCAodWludDY0X3QpLTEgaW92YSBhZGRyZXNzLgo+Pgo+PiBOb3RlIHRoYXQsIHdlIHByb2JhYmx5
IG5lZWQgYSBzZXBhcmF0ZWQgcGF0Y2ggZm9yIHRoaXMuCj4+Cj4gQWN0dWFsbHkgdGhlIGNvbW1l
bnQgaXMgbm90IGluIHRoZSByaWdodCBjb21taXQsIHRoZSBuZXh0IG9uZSBpcyB0aGUKPiBvbmUg
dGhhdCB1c2VzIGl0LiBJcyB0aGF0IHdoYXQgeW91IG1lYW4/CgoKTm8sIGl0J3MgYWJvdXQgdGhl
IGZvbGxvd2luZyBzdWdnZXN0aW9ucy4KCgo+Cj4+IEFuZCB3ZSBuZWVkIHRvIHRoaXMgZHVyaW5n
IHZob3N0LXZkcGEgaW5pdGlhbGl6YXRpb24uIElmIEdQQSBpcyBvdXQgb2YKPj4gdGhlIHJhbmdl
LCB3ZSBuZWVkIHRvIGZhaWwgdGhlIHN0YXJ0IG9mIHZob3N0LXZkcGEuCgoKTm90ZSB0aGF0IHRo
aXMgaXMgZm9yIG5vbi1JT01NVSBjYXNlLiBGb3IgdGhlIGNhc2Ugb2YgdklPTU1VIHdlIHByb2Jh
Ymx5IApuZWVkIHRvIHZhbGlkYXRlIGl0IGFnYWluc3QgYWRkcmVzcyB3aWR0aCBvciBvdGhlciBz
aW1pbGFyIGF0dHJpYnV0ZXMuCgpUaGFua3MKCgo+Pgo+IFJpZ2h0LCB0aGF0IGlzIHN0aWxsIHRv
LWRvLgo+Cj4gTWF5YmUgYSBzZXJpZXMgd2l0aCBqdXN0IHRoZXNlIHR3byBjb21taXRzIGFuZCBm
YWlsaW5nIHRoZSBzdGFydCBpZgo+IEdQQSBpcyBub3QgaW4gdGhlIHJhbmdlLCBhcyB5b3Ugc2F5
LCB3b3VsZCBoZWxwIHRvIHNwbGl0IHRoZSBhbW91bnQgb2YKPiBjaGFuZ2VzLgo+Cj4gSSB3aWxs
IHNlbmQgaXQgaWYgbm8gbW9yZSBjb21tZW50cyBhcmlzZSBhYm91dCBpdC4KPgo+IFRoYW5rcyEK
Pgo+PiBUSGFua3MKPj4KPj4KPj4+IFNpZ25lZC1vZmYtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVy
ZXptYUByZWRoYXQuY29tPgo+Pj4gLS0tCj4+PiAgICBpbmNsdWRlL2h3L3ZpcnRpby92aG9zdC1i
YWNrZW5kLmggfCAgNSArKysrKwo+Pj4gICAgaHcvdmlydGlvL3Zob3N0LXZkcGEuYyAgICAgICAg
ICAgIHwgMTggKysrKysrKysrKysrKysrKysrCj4+PiAgICBody92aXJ0aW8vdHJhY2UtZXZlbnRz
ICAgICAgICAgICAgfCAgMSArCj4+PiAgICAzIGZpbGVzIGNoYW5nZWQsIDI0IGluc2VydGlvbnMo
KykKPj4+Cj4+PiBkaWZmIC0tZ2l0IGEvaW5jbHVkZS9ody92aXJ0aW8vdmhvc3QtYmFja2VuZC5o
IGIvaW5jbHVkZS9ody92aXJ0aW8vdmhvc3QtYmFja2VuZC5oCj4+PiBpbmRleCA5NGQzMzIzOTA1
Li5iY2IxMTJjMTY2IDEwMDY0NAo+Pj4gLS0tIGEvaW5jbHVkZS9ody92aXJ0aW8vdmhvc3QtYmFj
a2VuZC5oCj4+PiArKysgYi9pbmNsdWRlL2h3L3ZpcnRpby92aG9zdC1iYWNrZW5kLmgKPj4+IEBA
IC0zNiw2ICszNiw3IEBAIHN0cnVjdCB2aG9zdF92cmluZ19hZGRyOwo+Pj4gICAgc3RydWN0IHZo
b3N0X3Njc2lfdGFyZ2V0Owo+Pj4gICAgc3RydWN0IHZob3N0X2lvdGxiX21zZzsKPj4+ICAgIHN0
cnVjdCB2aG9zdF92aXJ0cXVldWU7Cj4+PiArc3RydWN0IHZob3N0X3ZkcGFfaW92YV9yYW5nZTsK
Pj4+Cj4+PiAgICB0eXBlZGVmIGludCAoKnZob3N0X2JhY2tlbmRfaW5pdCkoc3RydWN0IHZob3N0
X2RldiAqZGV2LCB2b2lkICpvcGFxdWUpOwo+Pj4gICAgdHlwZWRlZiBpbnQgKCp2aG9zdF9iYWNr
ZW5kX2NsZWFudXApKHN0cnVjdCB2aG9zdF9kZXYgKmRldik7Cj4+PiBAQCAtMTI3LDYgKzEyOCw5
IEBAIHR5cGVkZWYgYm9vbCAoKnZob3N0X2ZvcmNlX2lvbW11X29wKShzdHJ1Y3Qgdmhvc3RfZGV2
ICpkZXYpOwo+Pj4KPj4+ICAgIHR5cGVkZWYgaW50ICgqdmhvc3RfdnJpbmdfcGF1c2Vfb3ApKHN0
cnVjdCB2aG9zdF9kZXYgKmRldik7Cj4+Pgo+Pj4gK3R5cGVkZWYgaW50ICgqdmhvc3RfZ2V0X2lv
dmFfcmFuZ2UpKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKPj4+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBod2FkZHIgKmZpcnN0LCBod2FkZHIgKmxhc3QpOwo+Pj4gKwo+Pj4g
ICAgdHlwZWRlZiBzdHJ1Y3QgVmhvc3RPcHMgewo+Pj4gICAgICAgIFZob3N0QmFja2VuZFR5cGUg
YmFja2VuZF90eXBlOwo+Pj4gICAgICAgIHZob3N0X2JhY2tlbmRfaW5pdCB2aG9zdF9iYWNrZW5k
X2luaXQ7Cj4+PiBAQCAtMTczLDYgKzE3Nyw3IEBAIHR5cGVkZWYgc3RydWN0IFZob3N0T3BzIHsK
Pj4+ICAgICAgICB2aG9zdF9nZXRfZGV2aWNlX2lkX29wIHZob3N0X2dldF9kZXZpY2VfaWQ7Cj4+
PiAgICAgICAgdmhvc3RfdnJpbmdfcGF1c2Vfb3Agdmhvc3RfdnJpbmdfcGF1c2U7Cj4+PiAgICAg
ICAgdmhvc3RfZm9yY2VfaW9tbXVfb3Agdmhvc3RfZm9yY2VfaW9tbXU7Cj4+PiArICAgIHZob3N0
X2dldF9pb3ZhX3JhbmdlIHZob3N0X2dldF9pb3ZhX3JhbmdlOwo+Pj4gICAgfSBWaG9zdE9wczsK
Pj4+Cj4+PiAgICBleHRlcm4gY29uc3QgVmhvc3RPcHMgdXNlcl9vcHM7Cj4+PiBkaWZmIC0tZ2l0
IGEvaHcvdmlydGlvL3Zob3N0LXZkcGEuYyBiL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMKPj4+IGlu
ZGV4IDAxZDIxMDFkMDkuLjc0ZmU5MjkzNWUgMTAwNjQ0Cj4+PiAtLS0gYS9ody92aXJ0aW8vdmhv
c3QtdmRwYS5jCj4+PiArKysgYi9ody92aXJ0aW8vdmhvc3QtdmRwYS5jCj4+PiBAQCAtNTc5LDYg
KzU3OSwyMyBAQCBzdGF0aWMgYm9vbCAgdmhvc3RfdmRwYV9mb3JjZV9pb21tdShzdHJ1Y3Qgdmhv
c3RfZGV2ICpkZXYpCj4+PiAgICAgICAgcmV0dXJuIHRydWU7Cj4+PiAgICB9Cj4+Pgo+Pj4gK3N0
YXRpYyBpbnQgdmhvc3RfdmRwYV9nZXRfaW92YV9yYW5nZShzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYs
Cj4+PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGh3YWRkciAqZmlyc3Qs
IGh3YWRkciAqbGFzdCkKPj4+ICt7Cj4+PiArICAgIGludCByZXQ7Cj4+PiArICAgIHN0cnVjdCB2
aG9zdF92ZHBhX2lvdmFfcmFuZ2UgcmFuZ2U7Cj4+PiArCj4+PiArICAgIHJldCA9IHZob3N0X3Zk
cGFfY2FsbChkZXYsIFZIT1NUX1ZEUEFfR0VUX0lPVkFfUkFOR0UsICZyYW5nZSk7Cj4+PiArICAg
IGlmIChyZXQgIT0gMCkgewo+Pj4gKyAgICAgICAgcmV0dXJuIHJldDsKPj4+ICsgICAgfQo+Pj4g
Kwo+Pj4gKyAgICAqZmlyc3QgPSByYW5nZS5maXJzdDsKPj4+ICsgICAgKmxhc3QgPSByYW5nZS5s
YXN0Owo+Pj4gKyAgICB0cmFjZV92aG9zdF92ZHBhX2dldF9pb3ZhX3JhbmdlKGRldiwgKmZpcnN0
LCAqbGFzdCk7Cj4+PiArICAgIHJldHVybiByZXQ7Cj4+PiArfQo+Pj4gKwo+Pj4gICAgY29uc3Qg
Vmhvc3RPcHMgdmRwYV9vcHMgPSB7Cj4+PiAgICAgICAgICAgIC5iYWNrZW5kX3R5cGUgPSBWSE9T
VF9CQUNLRU5EX1RZUEVfVkRQQSwKPj4+ICAgICAgICAgICAgLnZob3N0X2JhY2tlbmRfaW5pdCA9
IHZob3N0X3ZkcGFfaW5pdCwKPj4+IEBAIC02MTEsNCArNjI4LDUgQEAgY29uc3QgVmhvc3RPcHMg
dmRwYV9vcHMgPSB7Cj4+PiAgICAgICAgICAgIC52aG9zdF9nZXRfZGV2aWNlX2lkID0gdmhvc3Rf
dmRwYV9nZXRfZGV2aWNlX2lkLAo+Pj4gICAgICAgICAgICAudmhvc3RfdnFfZ2V0X2FkZHIgPSB2
aG9zdF92ZHBhX3ZxX2dldF9hZGRyLAo+Pj4gICAgICAgICAgICAudmhvc3RfZm9yY2VfaW9tbXUg
PSB2aG9zdF92ZHBhX2ZvcmNlX2lvbW11LAo+Pj4gKyAgICAgICAgLnZob3N0X2dldF9pb3ZhX3Jh
bmdlID0gdmhvc3RfdmRwYV9nZXRfaW92YV9yYW5nZSwKPj4+ICAgIH07Cj4+PiBkaWZmIC0tZ2l0
IGEvaHcvdmlydGlvL3RyYWNlLWV2ZW50cyBiL2h3L3ZpcnRpby90cmFjZS1ldmVudHMKPj4+IGlu
ZGV4IGM2MjcyN2Y4NzkuLjVkZWJlM2E2ODEgMTAwNjQ0Cj4+PiAtLS0gYS9ody92aXJ0aW8vdHJh
Y2UtZXZlbnRzCj4+PiArKysgYi9ody92aXJ0aW8vdHJhY2UtZXZlbnRzCj4+PiBAQCAtNTIsNiAr
NTIsNyBAQCB2aG9zdF92ZHBhX3NldF92cmluZ19jYWxsKHZvaWQgKmRldiwgdW5zaWduZWQgaW50
IGluZGV4LCBpbnQgZmQpICJkZXY6ICVwIGluZGV4Ogo+Pj4gICAgdmhvc3RfdmRwYV9nZXRfZmVh
dHVyZXModm9pZCAqZGV2LCB1aW50NjRfdCBmZWF0dXJlcykgImRldjogJXAgZmVhdHVyZXM6IDB4
JSJQUkl4NjQKPj4+ICAgIHZob3N0X3ZkcGFfc2V0X293bmVyKHZvaWQgKmRldikgImRldjogJXAi
Cj4+PiAgICB2aG9zdF92ZHBhX3ZxX2dldF9hZGRyKHZvaWQgKmRldiwgdm9pZCAqdnEsIHVpbnQ2
NF90IGRlc2NfdXNlcl9hZGRyLCB1aW50NjRfdCBhdmFpbF91c2VyX2FkZHIsIHVpbnQ2NF90IHVz
ZWRfdXNlcl9hZGRyKSAiZGV2OiAlcCB2cTogJXAgZGVzY191c2VyX2FkZHI6IDB4JSJQUkl4NjQi
IGF2YWlsX3VzZXJfYWRkcjogMHglIlBSSXg2NCIgdXNlZF91c2VyX2FkZHI6IDB4JSJQUkl4NjQK
Pj4+ICt2aG9zdF92ZHBhX2dldF9pb3ZhX3JhbmdlKHZvaWQgKmRldiwgdWludDY0X3QgZmlyc3Qs
IHVpbnQ2NF90IGxhc3QpICJkZXY6ICVwIGZpcnN0OiAweCUiUFJJeDY0IiBsYXN0OiAweCUiUFJJ
eDY0Cj4+Pgo+Pj4gICAgIyB2aXJ0aW8uYwo+Pj4gICAgdmlydHF1ZXVlX2FsbG9jX2VsZW1lbnQo
dm9pZCAqZWxlbSwgc2l6ZV90IHN6LCB1bnNpZ25lZCBpbl9udW0sIHVuc2lnbmVkIG91dF9udW0p
ICJlbGVtICVwIHNpemUgJXpkIGluX251bSAldSBvdXRfbnVtICV1IgoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
