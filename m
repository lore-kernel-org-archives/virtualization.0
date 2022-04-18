Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FC1DC433EF
	for <virtualization@archiver.kernel.org>; Mon, 18 Apr 2022 07:58:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 26F1D6120A;
	Mon, 18 Apr 2022 07:58:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QF9IW6Nmaeez; Mon, 18 Apr 2022 07:58:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 6335961180;
	Mon, 18 Apr 2022 07:58:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 340B4C0033;
	Mon, 18 Apr 2022 07:58:02 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6308EC002C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 07:58:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 4126D6120A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 07:58:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9SOm6dpvjwMY
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 07:57:59 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 1B02461180
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 07:57:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650268675;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=QB2hIEaNOaVSvZW6GhB9ZPGkcBR5Y/EmwtAltVQbGz4=;
 b=imteKXaDTCYehlFmmSH7you+HVFzwPk97AvjRGndGMew6m8E/trBjHNj8+pTjRjYOIJc9R
 qmYCv/eW/KzUVzGPrnlNU+zbWt6tjypoV2M5OD4EtNCspey+kjisFerswhCBBOmu2BlCqR
 8kPpzSccQ6qByOgB+EB4EfsI4w1eUuI=
Received: from mail-pl1-f197.google.com (mail-pl1-f197.google.com
 [209.85.214.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-647-zfcFH0stMuS87aU4-m1y4A-1; Mon, 18 Apr 2022 03:57:54 -0400
X-MC-Unique: zfcFH0stMuS87aU4-m1y4A-1
Received: by mail-pl1-f197.google.com with SMTP id
 f11-20020a170902684b00b00158c67ef30cso4723148pln.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 18 Apr 2022 00:57:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=QB2hIEaNOaVSvZW6GhB9ZPGkcBR5Y/EmwtAltVQbGz4=;
 b=VoGXF6Du2iRHHTpMNrTnYc0PPm/3tSexapFguz7aXoX3fdLfJn3tNOWPNP8JRiuJ4F
 exN/GbSGGvzGJPkJQaxzh3DvOm2Zj+EopnKYsnI3OuumLYiO5xQwJS+eYAWM3BF36GkI
 GjW8ce/eEe/9+Pm5yqOIdVG+aj8Pwmpj2U630z4tkvXlaNF4dSMtJBbcjeokvzlRvn/l
 b6XrEVK29RnpKpdfXMRxJqJKPh/fgyv1rqEaWUoECQ6/lw5TTjiJuyXR1qTJqvs3HPao
 CX0NtymgzE8enTeRWHCmzQ9O/ZTGiLL8wwirvl31B75JrSgKTU8TQjA3GntzBpfwqAJW
 H2bg==
X-Gm-Message-State: AOAM533l4vEpPO/W0HpDakvtj6Td7EKVkj5DNiKsCooX8PaiG4q3ldl7
 3uZRgHyJmjQiUM7J/vXG1ARK8iRQVvi4/YgBwo9rxhpHKwY181eCaKD0HnGUTBLkJima8Ghietk
 zMEANV+oGubQPmDcrD2Dh2WG6Ts4USc/QoT9owKcRsA==
X-Received: by 2002:a17:902:b596:b0:158:f23a:c789 with SMTP id
 a22-20020a170902b59600b00158f23ac789mr7372593pls.57.1650268672301; 
 Mon, 18 Apr 2022 00:57:52 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDSBaptpR+stWjiJRuBIZwcdjg4yDbmUSoZFvIAfQXF+o8QMtyy7IztplQWHr8YNawm7+9AQ==
X-Received: by 2002:a17:902:b596:b0:158:f23a:c789 with SMTP id
 a22-20020a170902b59600b00158f23ac789mr7372559pls.57.1650268671926; 
 Mon, 18 Apr 2022 00:57:51 -0700 (PDT)
Received: from [10.72.13.25] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 v13-20020a17090a00cd00b001d297df6725sm2377825pjd.22.2022.04.18.00.57.42
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 18 Apr 2022 00:57:51 -0700 (PDT)
Message-ID: <0ab18346-5245-389d-5996-b805042889da@redhat.com>
Date: Mon, 18 Apr 2022 15:57:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v9 31/32] virtio_net: support rx/tx queue resize
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-32-xuanzhuo@linux.alibaba.com>
 <122008a6-1e79-14d3-1478-59f96464afc9@redhat.com>
 <1649838917.6726515-10-xuanzhuo@linux.alibaba.com>
 <CACGkMEvPH1k76xB_cHq_S9hvMXgGruoXpKLfoMZvJZ-L7wM9iw@mail.gmail.com>
 <1649989126.5433838-1-xuanzhuo@linux.alibaba.com>
 <CACGkMEuju+kdapRbnx6OxsmAbD=JZin67xGBLEqLrMeuPPw0Fg@mail.gmail.com>
 <1650014226.0312726-1-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <1650014226.0312726-1-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 Johannes Berg <johannes.berg@intel.com>,
 Daniel Borkmann <daniel@iogearbox.net>, Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Heiko Carstens <hca@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, Jeff Dike <jdike@addtoit.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, kvm <kvm@vger.kernel.org>,
 platform-driver-x86@vger.kernel.org,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev <netdev@vger.kernel.org>,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 "open list:XDP \(eXpress Data Path\)" <bpf@vger.kernel.org>,
 "David S. Miller" <davem@davemloft.net>
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

CuWcqCAyMDIyLzQvMTUgMTc6MTcsIFh1YW4gWmh1byDlhpnpgZM6Cj4gT24gRnJpLCAxNSBBcHIg
MjAyMiAxMzo1Mzo1NCArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3Jv
dGU6Cj4+IE9uIEZyaSwgQXByIDE1LCAyMDIyIGF0IDEwOjIzIEFNIFh1YW4gWmh1byA8eHVhbnpo
dW9AbGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Pj4gT24gVGh1LCAxNCBBcHIgMjAyMiAxNzoz
MDowMiArMDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4g
T24gV2VkLCBBcHIgMTMsIDIwMjIgYXQgNDo0NyBQTSBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4
LmFsaWJhYmEuY29tPiB3cm90ZToKPj4+Pj4gT24gV2VkLCAxMyBBcHIgMjAyMiAxNjowMDoxOCAr
MDgwMCwgSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4+Pj4+PiDlnKgg
MjAyMi80LzYg5LiK5Y2IMTE6NDMsIFh1YW4gWmh1byDlhpnpgZM6Cj4+Pj4+Pj4gVGhpcyBwYXRj
aCBpbXBsZW1lbnRzIHRoZSByZXNpemUgZnVuY3Rpb24gb2YgdGhlIHJ4LCB0eCBxdWV1ZXMuCj4+
Pj4+Pj4gQmFzZWQgb24gdGhpcyBmdW5jdGlvbiwgaXQgaXMgcG9zc2libGUgdG8gbW9kaWZ5IHRo
ZSByaW5nIG51bSBvZiB0aGUKPj4+Pj4+PiBxdWV1ZS4KPj4+Pj4+Pgo+Pj4+Pj4+IFRoZXJlIG1h
eSBiZSBhbiBleGNlcHRpb24gZHVyaW5nIHRoZSByZXNpemUgcHJvY2VzcywgdGhlIHJlc2l6ZSBt
YXkKPj4+Pj4+PiBmYWlsLCBvciB0aGUgdnEgY2FuIG5vIGxvbmdlciBiZSB1c2VkLiBFaXRoZXIg
d2F5LCB3ZSBtdXN0IGV4ZWN1dGUKPj4+Pj4+PiBuYXBpX2VuYWJsZSgpLiBCZWNhdXNlIG5hcGlf
ZGlzYWJsZSBpcyBzaW1pbGFyIHRvIGEgbG9jaywgbmFwaV9lbmFibGUKPj4+Pj4+PiBtdXN0IGJl
IGNhbGxlZCBhZnRlciBjYWxsaW5nIG5hcGlfZGlzYWJsZS4KPj4+Pj4+Pgo+Pj4+Pj4+IFNpZ25l
ZC1vZmYtYnk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4+Pj4+Pj4g
LS0tCj4+Pj4+Pj4gICAgZHJpdmVycy9uZXQvdmlydGlvX25ldC5jIHwgODEgKysrKysrKysrKysr
KysrKysrKysrKysrKysrKysrKysrKysrKysrKwo+Pj4+Pj4+ICAgIDEgZmlsZSBjaGFuZ2VkLCA4
MSBpbnNlcnRpb25zKCspCj4+Pj4+Pj4KPj4+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+Pj4+Pj4gaW5kZXggYjhi
ZjAwNTI1MTc3Li5iYTY4NTlmMzA1ZjcgMTAwNjQ0Cj4+Pj4+Pj4gLS0tIGEvZHJpdmVycy9uZXQv
dmlydGlvX25ldC5jCj4+Pj4+Pj4gKysrIGIvZHJpdmVycy9uZXQvdmlydGlvX25ldC5jCj4+Pj4+
Pj4gQEAgLTI1MSw2ICsyNTEsOSBAQCBzdHJ1Y3QgcGFkZGVkX3ZuZXRfaGRyIHsKPj4+Pj4+PiAg
ICAgIGNoYXIgcGFkZGluZ1s0XTsKPj4+Pj4+PiAgICB9Owo+Pj4+Pj4+Cj4+Pj4+Pj4gK3N0YXRp
YyB2b2lkIHZpcnRuZXRfc3FfZnJlZV91bnVzZWRfYnVmKHN0cnVjdCB2aXJ0cXVldWUgKnZxLCB2
b2lkICpidWYpOwo+Pj4+Pj4+ICtzdGF0aWMgdm9pZCB2aXJ0bmV0X3JxX2ZyZWVfdW51c2VkX2J1
ZihzdHJ1Y3QgdmlydHF1ZXVlICp2cSwgdm9pZCAqYnVmKTsKPj4+Pj4+PiArCj4+Pj4+Pj4gICAg
c3RhdGljIGJvb2wgaXNfeGRwX2ZyYW1lKHZvaWQgKnB0cikKPj4+Pj4+PiAgICB7Cj4+Pj4+Pj4g
ICAgICByZXR1cm4gKHVuc2lnbmVkIGxvbmcpcHRyICYgVklSVElPX1hEUF9GTEFHOwo+Pj4+Pj4+
IEBAIC0xMzY5LDYgKzEzNzIsMTUgQEAgc3RhdGljIHZvaWQgdmlydG5ldF9uYXBpX2VuYWJsZShz
dHJ1Y3QgdmlydHF1ZXVlICp2cSwgc3RydWN0IG5hcGlfc3RydWN0ICpuYXBpKQo+Pj4+Pj4+ICAg
IHsKPj4+Pj4+PiAgICAgIG5hcGlfZW5hYmxlKG5hcGkpOwo+Pj4+Pj4+Cj4+Pj4+Pj4gKyAgIC8q
IENoZWNrIGlmIHZxIGlzIGluIHJlc2V0IHN0YXRlLiBUaGUgbm9ybWFsIHJlc2V0L3Jlc2l6ZSBw
cm9jZXNzIHdpbGwKPj4+Pj4+PiArICAgICogYmUgcHJvdGVjdGVkIGJ5IG5hcGkuIEhvd2V2ZXIs
IHRoZSBwcm90ZWN0aW9uIG9mIG5hcGkgaXMgb25seSBlbmFibGVkCj4+Pj4+Pj4gKyAgICAqIGR1
cmluZyB0aGUgb3BlcmF0aW9uLCBhbmQgdGhlIHByb3RlY3Rpb24gb2YgbmFwaSB3aWxsIGVuZCBh
ZnRlciB0aGUKPj4+Pj4+PiArICAgICogb3BlcmF0aW9uIGlzIGNvbXBsZXRlZC4gSWYgcmUtZW5h
YmxlIGZhaWxzIGR1cmluZyB0aGUgcHJvY2VzcywgdnEKPj4+Pj4+PiArICAgICogd2lsbCByZW1h
aW4gdW5hdmFpbGFibGUgd2l0aCByZXNldCBzdGF0ZS4KPj4+Pj4+PiArICAgICovCj4+Pj4+Pj4g
KyAgIGlmICh2cS0+cmVzZXQpCj4+Pj4+Pj4gKyAgICAgICAgICAgcmV0dXJuOwo+Pj4+Pj4KPj4+
Pj4+IEkgZG9uJ3QgZ2V0IHdoZW4gY291bGQgd2UgaGl0IHRoaXMgY29uZGl0aW9uLgo+Pj4+Pgo+
Pj4+PiBJbiBwYXRjaCAyMywgdGhlIGNvZGUgdG8gaW1wbGVtZW50IHJlLWVuYWJsZSB2cSBpcyBh
cyBmb2xsb3dzOgo+Pj4+Pgo+Pj4+PiArc3RhdGljIGludCB2cF9tb2Rlcm5fZW5hYmxlX3Jlc2V0
X3ZxKHN0cnVjdCB2aXJ0cXVldWUgKnZxKQo+Pj4+PiArewo+Pj4+PiArICAgICAgIHN0cnVjdCB2
aXJ0aW9fcGNpX2RldmljZSAqdnBfZGV2ID0gdG9fdnBfZGV2aWNlKHZxLT52ZGV2KTsKPj4+Pj4g
KyAgICAgICBzdHJ1Y3QgdmlydGlvX3BjaV9tb2Rlcm5fZGV2aWNlICptZGV2ID0gJnZwX2Rldi0+
bWRldjsKPj4+Pj4gKyAgICAgICBzdHJ1Y3QgdmlydGlvX3BjaV92cV9pbmZvICppbmZvOwo+Pj4+
PiArICAgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3MsIGluZGV4Owo+Pj4+PiArICAgICAgIGludCBl
cnI7Cj4+Pj4+ICsKPj4+Pj4gKyAgICAgICBpZiAoIXZxLT5yZXNldCkKPj4+Pj4gKyAgICAgICAg
ICAgICAgIHJldHVybiAtRUJVU1k7Cj4+Pj4+ICsKPj4+Pj4gKyAgICAgICBpbmRleCA9IHZxLT5p
bmRleDsKPj4+Pj4gKyAgICAgICBpbmZvID0gdnBfZGV2LT52cXNbaW5kZXhdOwo+Pj4+PiArCj4+
Pj4+ICsgICAgICAgLyogY2hlY2sgcXVldWUgcmVzZXQgc3RhdHVzICovCj4+Pj4+ICsgICAgICAg
aWYgKHZwX21vZGVybl9nZXRfcXVldWVfcmVzZXQobWRldiwgaW5kZXgpICE9IDEpCj4+Pj4+ICsg
ICAgICAgICAgICAgICByZXR1cm4gLUVCVVNZOwo+Pj4+PiArCj4+Pj4+ICsgICAgICAgZXJyID0g
dnBfYWN0aXZlX3ZxKHZxLCBpbmZvLT5tc2l4X3ZlY3Rvcik7Cj4+Pj4+ICsgICAgICAgaWYgKGVy
cikKPj4+Pj4gKyAgICAgICAgICAgICAgIHJldHVybiBlcnI7Cj4+Pj4+ICsKPj4+Pj4gKyAgICAg
ICBpZiAodnEtPmNhbGxiYWNrKSB7Cj4+Pj4+ICsgICAgICAgICAgICAgICBzcGluX2xvY2tfaXJx
c2F2ZSgmdnBfZGV2LT5sb2NrLCBmbGFncyk7Cj4+Pj4+ICsgICAgICAgICAgICAgICBsaXN0X2Fk
ZCgmaW5mby0+bm9kZSwgJnZwX2Rldi0+dmlydHF1ZXVlcyk7Cj4+Pj4+ICsgICAgICAgICAgICAg
ICBzcGluX3VubG9ja19pcnFyZXN0b3JlKCZ2cF9kZXYtPmxvY2ssIGZsYWdzKTsKPj4+Pj4gKyAg
ICAgICB9IGVsc2Ugewo+Pj4+PiArICAgICAgICAgICAgICAgSU5JVF9MSVNUX0hFQUQoJmluZm8t
Pm5vZGUpOwo+Pj4+PiArICAgICAgIH0KPj4+Pj4gKwo+Pj4+PiArICAgICAgIHZwX21vZGVybl9z
ZXRfcXVldWVfZW5hYmxlKCZ2cF9kZXYtPm1kZXYsIGluZGV4LCB0cnVlKTsKPj4+Pj4gKwo+Pj4+
PiArICAgICAgIGlmICh2cF9kZXYtPnBlcl92cV92ZWN0b3JzICYmIGluZm8tPm1zaXhfdmVjdG9y
ICE9IFZJUlRJT19NU0lfTk9fVkVDVE9SKQo+Pj4+PiArICAgICAgICAgICAgICAgZW5hYmxlX2ly
cShwY2lfaXJxX3ZlY3Rvcih2cF9kZXYtPnBjaV9kZXYsIGluZm8tPm1zaXhfdmVjdG9yKSk7Cj4+
Pj4+ICsKPj4+Pj4gKyAgICAgICB2cS0+cmVzZXQgPSBmYWxzZTsKPj4+Pj4gKwo+Pj4+PiArICAg
ICAgIHJldHVybiAwOwo+Pj4+PiArfQo+Pj4+Pgo+Pj4+Pgo+Pj4+PiBUaGVyZSBhcmUgdGhyZWUg
c2l0dWF0aW9ucyB3aGVyZSBhbiBlcnJvciB3aWxsIGJlIHJldHVybmVkLiBUaGVzZSBhcmUgdGhl
Cj4+Pj4+IHNpdHVhdGlvbnMgSSB3YW50IHRvIGhhbmRsZS4KPj4+PiBSaWdodCwgYnV0IGl0IGxv
b2tzIGhhcm1sZXNzIGlmIHdlIGp1c3Qgc2NoZWR1bGUgdGhlIE5BUEkgd2l0aG91dCB0aGUgY2hl
Y2suCj4+PiBZZXMuCj4+Pgo+Pj4+PiBCdXQgSSdtIHJldGhpbmtpbmcgdGhlIHF1ZXN0aW9uLCBh
bmQgSSBmZWVsIGxpa2UgeW91J3JlIHJpZ2h0LCBhbHRob3VnaCB0aGUKPj4+Pj4gaGFyZHdhcmUg
c2V0dXAgbWF5IGZhaWwuIFdlIGNhbiBubyBsb25nZXIgc3luYyB3aXRoIHRoZSBoYXJkd2FyZS4g
QnV0IHVzaW5nIGl0Cj4+Pj4+IGFzIGEgbm9ybWFsIHZxIGRvZXNuJ3QgaGF2ZSBhbnkgcHJvYmxl
bXMuCj4+Pj4gTm90ZSB0aGF0IHdlIHNob3VsZCBtYWtlIHN1cmUgdGhlIGJ1Z2d5KG1hbGljb3Vz
KSBkZXZpY2Ugd29uJ3QgY3Jhc2gKPj4+PiB0aGUgY29kZXMgYnkgY2hhbmdpbmcgdGhlIHF1ZXVl
X3Jlc2V0IHZhbHVlIGF0IGl0cyB3aWxsLgo+Pj4gSSB3aWxsIGtlZXAgYW4gZXllIG9uIHRoaXMg
c2l0dWF0aW9uLgo+Pj4KPj4+Pj4+Cj4+Pj4+Pj4gKwo+Pj4+Pj4+ICAgICAgLyogSWYgYWxsIGJ1
ZmZlcnMgd2VyZSBmaWxsZWQgYnkgb3RoZXIgc2lkZSBiZWZvcmUgd2UgbmFwaV9lbmFibGVkLCB3
ZQo+Pj4+Pj4+ICAgICAgICogd29uJ3QgZ2V0IGFub3RoZXIgaW50ZXJydXB0LCBzbyBwcm9jZXNz
IGFueSBvdXRzdGFuZGluZyBwYWNrZXRzIG5vdy4KPj4+Pj4+PiAgICAgICAqIENhbGwgbG9jYWxf
YmhfZW5hYmxlIGFmdGVyIHRvIHRyaWdnZXIgc29mdElSUSBwcm9jZXNzaW5nLgo+Pj4+Pj4+IEBA
IC0xNDEzLDYgKzE0MjUsMTUgQEAgc3RhdGljIHZvaWQgcmVmaWxsX3dvcmsoc3RydWN0IHdvcmtf
c3RydWN0ICp3b3JrKQo+Pj4+Pj4+ICAgICAgICAgICAgICBzdHJ1Y3QgcmVjZWl2ZV9xdWV1ZSAq
cnEgPSAmdmktPnJxW2ldOwo+Pj4+Pj4+Cj4+Pj4+Pj4gICAgICAgICAgICAgIG5hcGlfZGlzYWJs
ZSgmcnEtPm5hcGkpOwo+Pj4+Pj4+ICsKPj4+Pj4+PiArICAgICAgICAgICAvKiBDaGVjayBpZiB2
cSBpcyBpbiByZXNldCBzdGF0ZS4gU2VlIG1vcmUgaW4KPj4+Pj4+PiArICAgICAgICAgICAgKiB2
aXJ0bmV0X25hcGlfZW5hYmxlKCkKPj4+Pj4+PiArICAgICAgICAgICAgKi8KPj4+Pj4+PiArICAg
ICAgICAgICBpZiAocnEtPnZxLT5yZXNldCkgewo+Pj4+Pj4+ICsgICAgICAgICAgICAgICAgICAg
dmlydG5ldF9uYXBpX2VuYWJsZShycS0+dnEsICZycS0+bmFwaSk7Cj4+Pj4+Pj4gKyAgICAgICAg
ICAgICAgICAgICBjb250aW51ZTsKPj4+Pj4+PiArICAgICAgICAgICB9Cj4+Pj4+Pgo+Pj4+Pj4g
Q2FuIHdlIGRvIHNvbWV0aGluZyBzaW1pbGFyIGluIHZpcnRuZXRfY2xvc2UoKSBieSBjYW5jZWxp
bmcgdGhlIHdvcms/Cj4+Pj4+IEkgdGhpbmsgdGhlcmUgaXMgbm8gbmVlZCB0byBjYW5jZWwgdGhl
IHdvcmsgaGVyZSwgYmVjYXVzZSBuYXBpX2Rpc2FibGUgd2lsbCB3YWl0Cj4+Pj4+IGZvciB0aGUg
bmFwaV9lbmFibGUgb2YgdGhlIHJlc2l6ZS4gU28gaWYgdGhlIHJlLWVuYWJsZSBmYWlsZWQgdnEg
aXMgdXNlZCBhcyBhIG5vcm1hbAo+Pj4+PiB2cSwgdGhpcyBsb2dpYyBjYW4gYmUgcmVtb3ZlZC4K
Pj4+PiBBY3R1YWxseSBJIG1lYW50IHRoZSBwYXJ0IG9mIHZpcnRuZXRfcnhfcmVzaXplKCkuCj4+
Pj4KPj4+PiBJZiB3ZSBkb24ndCBzeW5jaHJvbml6ZSB3aXRoIHRoZSByZWZpbGwgd29yaywgaXQg
bWlnaHQgZW5hYmxlIE5BUEkgdW5leHBlY3RlZGx5Pwo+Pj4gSSBkb24ndCB0aGluayB0aGlzIHNp
dHVhdGlvbiB3aWxsIGJlIGVuY291bnRlcmVkLCBiZWNhdXNlIG5hcGlfZGlzYWJsZSBpcwo+Pj4g
bXV0dWFsbHkgZXhjbHVzaXZlLCBzbyB0aGVyZSB3aWxsIGJlIG5vIHVuZXhwZWN0ZWQgbmFwaSBl
bmFibGUuCj4+Pgo+Pj4gSXMgdGhlcmUgc29tZXRoaW5nIEkgbWlzdW5kZXJzdG9vZD8KPj4gU28g
aW4gdmlydG5ldF9yeF9yZXNpemUoKSB3ZSBkbzoKPj4KPj4gbmFwaV9kaXNhYmxlKCkKPj4gLi4u
Cj4+IHJlc2l6ZSgpCj4+IC4uLgo+PiBuYXBpX2VuYWxiZSgpCj4+Cj4+IEhvdyBjYW4gd2UgZ3Vh
cmFudGVlIHRoYXQgdGhlIHdvcmsgaXMgbm90IHJ1biBhZnRlciB0aGUgbmFwaV9kaXNhYmxlKCk/
Cj4KPiBJIHRoaW5rIHlvdSdyZSB0YWxraW5nIGFib3V0IGEgc2l0dWF0aW9uIGxpa2UgdGhpczoK
Pgo+IHZpcnRuZXRfcnhfcmVzaXplICAgICAgICAgIHJlZmlsbCB3b3JrCj4gLS0tLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0KPiAgIG5hcGlf
ZGlzYWJsZSgpCj4gICAuLi4gICAgICAgICAgICAgICAgICAgICAgIG5hcGlfZGlzYWJsZSgpCj4g
ICByZXNpemUoKSAgICAgICAgICAgICAgICAgICAgICAuLi4KPiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgbmFwaV9lbmFibGUoKQo+ICAgLi4uCj4gICBuYXBpX2VuYWxiZSgpCj4KPgo+IEJ1
dCBpbiBmYWN0Ogo+Cj4gdmlydG5ldF9yeF9yZXNpemUgICAgICAgICAgcmVmaWxsIHdvcmsKPiAt
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQo+ICAgbmFwaV9kaXNhYmxlKCkKPiAgIC4uLiAgICAgICAgICAgICAgICAgICAgICAgbmFwaV9k
aXNhYmxlKCkgPC0tLS1bMF0KPiAgIHJlc2l6ZSgpICAgICAgICAgICAgICAgICAgICAgICB8Cj4g
ICAuLi4gICAgICAgICAgICAgICAgICAgICAgICAgICAgfAo+ICAgbmFwaV9lbmFsYmUoKSAgICAg
ICAgICAgICAgICAgIHwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbmFwaV9kaXNhYmxl
KCkgPC0tLS0gWzFdIGhlcmUgc3VjY2Vzcwo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBu
YXBpX2VuYWJsZSgpCj4KPiBCZWNhdXNlIHZpcnRuZXRfcnhfcmVzaXplKCkgaGFzIGFscmVhZHkg
ZXhlY3V0ZWQgbmFwaV9kaXNhYmxlKCksIG5hcGlfZGlzYWxiZSgpCj4gb2YgWzBdIHdpbGwgd2Fp
dCB1bnRpbCBbMV0gdG8gY29tcGxldGUuCj4KPiBJJ20gbm90IHN1cmUgaWYgbXkgdW5kZXJzdGFu
ZGluZyBpcyBjb3JyZWN0LgoKCkkgdGhpbmsgeW91J3JlIHJpZ2h0IGhlcmUuCgpUaGFua3MKCgo+
Cj4gVGhhbmtzLgo+Cj4+IFRoYW5rcwo+Pgo+Pj4gVGhhbmtzLgo+Pj4KPj4+PiBUaGFua3MKPj4+
Pgo+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+PiArCj4+Pj4+Pj4gICAgICAgICAgICAgIHN0aWxsX2VtcHR5
ID0gIXRyeV9maWxsX3JlY3YodmksIHJxLCBHRlBfS0VSTkVMKTsKPj4+Pj4+PiAgICAgICAgICAg
ICAgdmlydG5ldF9uYXBpX2VuYWJsZShycS0+dnEsICZycS0+bmFwaSk7Cj4+Pj4+Pj4KPj4+Pj4+
PiBAQCAtMTUyMyw2ICsxNTQ0LDEwIEBAIHN0YXRpYyB2b2lkIHZpcnRuZXRfcG9sbF9jbGVhbnR4
KHN0cnVjdCByZWNlaXZlX3F1ZXVlICpycSkKPj4+Pj4+PiAgICAgIGlmICghc3EtPm5hcGkud2Vp
Z2h0IHx8IGlzX3hkcF9yYXdfYnVmZmVyX3F1ZXVlKHZpLCBpbmRleCkpCj4+Pj4+Pj4gICAgICAg
ICAgICAgIHJldHVybjsKPj4+Pj4+Pgo+Pj4+Pj4+ICsgICAvKiBDaGVjayBpZiB2cSBpcyBpbiBy
ZXNldCBzdGF0ZS4gU2VlIG1vcmUgaW4gdmlydG5ldF9uYXBpX2VuYWJsZSgpICovCj4+Pj4+Pj4g
KyAgIGlmIChzcS0+dnEtPnJlc2V0KQo+Pj4+Pj4+ICsgICAgICAgICAgIHJldHVybjsKPj4+Pj4+
Cj4+Pj4+PiBXZSd2ZSBkaXNhYmxlZCBUWCBuYXBpLCBhbnkgY2hhbmNlIHdlIGNhbiBzdGlsbCBo
aXQgdGhpcz8KPj4+Pj4gU2FtZSBhcyBhYm92ZS4KPj4+Pj4KPj4+Pj4+Cj4+Pj4+Pj4gKwo+Pj4+
Pj4+ICAgICAgaWYgKF9fbmV0aWZfdHhfdHJ5bG9jayh0eHEpKSB7Cj4+Pj4+Pj4gICAgICAgICAg
ICAgIGRvIHsKPj4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICB2aXJ0cXVldWVfZGlzYWJsZV9j
YihzcS0+dnEpOwo+Pj4+Pj4+IEBAIC0xNzY5LDYgKzE3OTQsNjIgQEAgc3RhdGljIG5ldGRldl90
eF90IHN0YXJ0X3htaXQoc3RydWN0IHNrX2J1ZmYgKnNrYiwgc3RydWN0IG5ldF9kZXZpY2UgKmRl
dikKPj4+Pj4+PiAgICAgIHJldHVybiBORVRERVZfVFhfT0s7Cj4+Pj4+Pj4gICAgfQo+Pj4+Pj4+
Cj4+Pj4+Pj4gK3N0YXRpYyBpbnQgdmlydG5ldF9yeF9yZXNpemUoc3RydWN0IHZpcnRuZXRfaW5m
byAqdmksCj4+Pj4+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCByZWNlaXZlX3F1
ZXVlICpycSwgdTMyIHJpbmdfbnVtKQo+Pj4+Pj4+ICt7Cj4+Pj4+Pj4gKyAgIGludCBlcnI7Cj4+
Pj4+Pj4gKwo+Pj4+Pj4+ICsgICBuYXBpX2Rpc2FibGUoJnJxLT5uYXBpKTsKPj4+Pj4+PiArCj4+
Pj4+Pj4gKyAgIGVyciA9IHZpcnRxdWV1ZV9yZXNpemUocnEtPnZxLCByaW5nX251bSwgdmlydG5l
dF9ycV9mcmVlX3VudXNlZF9idWYpOwo+Pj4+Pj4+ICsgICBpZiAoZXJyKQo+Pj4+Pj4+ICsgICAg
ICAgICAgIGdvdG8gZXJyOwo+Pj4+Pj4+ICsKPj4+Pj4+PiArICAgaWYgKCF0cnlfZmlsbF9yZWN2
KHZpLCBycSwgR0ZQX0tFUk5FTCkpCj4+Pj4+Pj4gKyAgICAgICAgICAgc2NoZWR1bGVfZGVsYXll
ZF93b3JrKCZ2aS0+cmVmaWxsLCAwKTsKPj4+Pj4+PiArCj4+Pj4+Pj4gKyAgIHZpcnRuZXRfbmFw
aV9lbmFibGUocnEtPnZxLCAmcnEtPm5hcGkpOwo+Pj4+Pj4+ICsgICByZXR1cm4gMDsKPj4+Pj4+
PiArCj4+Pj4+Pj4gK2VycjoKPj4+Pj4+PiArICAgbmV0ZGV2X2Vycih2aS0+ZGV2LAo+Pj4+Pj4+
ICsgICAgICAgICAgICAgICJyZXNldCByeCByZXNldCB2cSBmYWlsOiByeCBxdWV1ZSBpbmRleDog
JXRkIGVycjogJWRcbiIsCj4+Pj4+Pj4gKyAgICAgICAgICAgICAgcnEgLSB2aS0+cnEsIGVycik7
Cj4+Pj4+Pj4gKyAgIHZpcnRuZXRfbmFwaV9lbmFibGUocnEtPnZxLCAmcnEtPm5hcGkpOwo+Pj4+
Pj4+ICsgICByZXR1cm4gZXJyOwo+Pj4+Pj4+ICt9Cj4+Pj4+Pj4gKwo+Pj4+Pj4+ICtzdGF0aWMg
aW50IHZpcnRuZXRfdHhfcmVzaXplKHN0cnVjdCB2aXJ0bmV0X2luZm8gKnZpLAo+Pj4+Pj4+ICsg
ICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgc2VuZF9xdWV1ZSAqc3EsIHUzMiByaW5nX251
bSkKPj4+Pj4+PiArewo+Pj4+Pj4+ICsgICBzdHJ1Y3QgbmV0ZGV2X3F1ZXVlICp0eHE7Cj4+Pj4+
Pj4gKyAgIGludCBlcnIsIHFpbmRleDsKPj4+Pj4+PiArCj4+Pj4+Pj4gKyAgIHFpbmRleCA9IHNx
IC0gdmktPnNxOwo+Pj4+Pj4+ICsKPj4+Pj4+PiArICAgdmlydG5ldF9uYXBpX3R4X2Rpc2FibGUo
JnNxLT5uYXBpKTsKPj4+Pj4+PiArCj4+Pj4+Pj4gKyAgIHR4cSA9IG5ldGRldl9nZXRfdHhfcXVl
dWUodmktPmRldiwgcWluZGV4KTsKPj4+Pj4+PiArICAgX19uZXRpZl90eF9sb2NrX2JoKHR4cSk7
Cj4+Pj4+Pj4gKyAgIG5ldGlmX3N0b3Bfc3VicXVldWUodmktPmRldiwgcWluZGV4KTsKPj4+Pj4+
PiArICAgX19uZXRpZl90eF91bmxvY2tfYmgodHhxKTsKPj4+Pj4+PiArCj4+Pj4+Pj4gKyAgIGVy
ciA9IHZpcnRxdWV1ZV9yZXNpemUoc3EtPnZxLCByaW5nX251bSwgdmlydG5ldF9zcV9mcmVlX3Vu
dXNlZF9idWYpOwo+Pj4+Pj4+ICsgICBpZiAoZXJyKQo+Pj4+Pj4+ICsgICAgICAgICAgIGdvdG8g
ZXJyOwo+Pj4+Pj4+ICsKPj4+Pj4+PiArICAgbmV0aWZfc3RhcnRfc3VicXVldWUodmktPmRldiwg
cWluZGV4KTsKPj4+Pj4+PiArICAgdmlydG5ldF9uYXBpX3R4X2VuYWJsZSh2aSwgc3EtPnZxLCAm
c3EtPm5hcGkpOwo+Pj4+Pj4+ICsgICByZXR1cm4gMDsKPj4+Pj4+PiArCj4+Pj4+Pj4gK2VycjoK
Pj4+Pj4+Cj4+Pj4+PiBJIGd1ZXNzIHdlIGNhbiBzdGlsbCBzdGFydCB0aGUgcXVldWUgaW4gdGhp
cyBjYXNlPyAoU2luY2Ugd2UgZG9uJ3QKPj4+Pj4+IGNoYW5nZSB0aGUgcXVldWUgaWYgcmVzaXpl
IGZhaWxzKS4KPj4+Pj4gWWVzLCB5b3UgYXJlIHJpZ2h0Lgo+Pj4+Pgo+Pj4+PiBUaGFua3MuCj4+
Pj4+Cj4+Pj4+Pgo+Pj4+Pj4+ICsgICBuZXRkZXZfZXJyKHZpLT5kZXYsCj4+Pj4+Pj4gKyAgICAg
ICAgICAgICAgInJlc2V0IHR4IHJlc2V0IHZxIGZhaWw6IHR4IHF1ZXVlIGluZGV4OiAldGQgZXJy
OiAlZFxuIiwKPj4+Pj4+PiArICAgICAgICAgICAgICBzcSAtIHZpLT5zcSwgZXJyKTsKPj4+Pj4+
PiArICAgdmlydG5ldF9uYXBpX3R4X2VuYWJsZSh2aSwgc3EtPnZxLCAmc3EtPm5hcGkpOwo+Pj4+
Pj4+ICsgICByZXR1cm4gZXJyOwo+Pj4+Pj4+ICt9Cj4+Pj4+Pj4gKwo+Pj4+Pj4+ICAgIC8qCj4+
Pj4+Pj4gICAgICogU2VuZCBjb21tYW5kIHZpYSB0aGUgY29udHJvbCB2aXJ0cXVldWUgYW5kIGNo
ZWNrIHN0YXR1cy4gIENvbW1hbmRzCj4+Pj4+Pj4gICAgICogc3VwcG9ydGVkIGJ5IHRoZSBoeXBl
cnZpc29yLCBhcyBpbmRpY2F0ZWQgYnkgZmVhdHVyZSBiaXRzLCBzaG91bGQKCl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
