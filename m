Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A0E22C433F5
	for <virtualization@archiver.kernel.org>; Tue, 22 Mar 2022 06:03:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4942940386;
	Tue, 22 Mar 2022 06:03:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5KGP5jeNzxPH; Tue, 22 Mar 2022 06:03:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 5486D400B8;
	Tue, 22 Mar 2022 06:03:02 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EEE1BC0012;
	Tue, 22 Mar 2022 06:03:01 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EB3AAC000B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 06:03:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id CBEF140102
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 06:03:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id PEHmx13OV_hm
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 06:02:56 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 4B15641723
 for <virtualization@lists.linux-foundation.org>;
 Tue, 22 Mar 2022 06:02:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1647928974;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=YuWLpObXHNXQTvg0Y0uDSsNe598zJtK0Jt8VbZYmE+0=;
 b=hI7cyuZa0U0yJMFDCyfGc3nSnsj9i4Lz2S7D7CAHrg1JPKKMuygHAQqvwy8jpa8N6OEEQz
 UqosQtMNvWcm3LnfbkeeW8xa/Wm71QunO2mbN6SpQYyr/5dPVu0BzDOq6cOr5GynPQTDo3
 m4Gm81kk3LfLnn11jI8jbU8iX+xslvg=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-600-luoFKSYPOQWRoTk51xqNpg-1; Tue, 22 Mar 2022 02:02:52 -0400
X-MC-Unique: luoFKSYPOQWRoTk51xqNpg-1
Received: by mail-pf1-f200.google.com with SMTP id
 s68-20020a625e47000000b004fa6520b540so7555595pfb.17
 for <virtualization@lists.linux-foundation.org>;
 Mon, 21 Mar 2022 23:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=YuWLpObXHNXQTvg0Y0uDSsNe598zJtK0Jt8VbZYmE+0=;
 b=n0ZRKuNXS4DmIAD3CmKANPu6qztCdx21pl7I3G/DTb7yJ46mkZTTsGwn7crrproMhg
 zLJBgWtiXOfKTS6IXqkGpoZMPGeSIZXZAzVZtOHYzJjPYjuciZRpZR9WK/Hf0iz5mRhY
 ufAoZXv/Svf7Hb3dRR0ZeEBeaTEHdcCV00wOu29eu9OBNZCmbnt5tU63JFQYVmcBv3u1
 XAJ05ufnQe3FolibktQkJMTzfJTy/uqQSa5ixCbIfhRoEwd5qJZ3N3QJ0wtDvVy25dzN
 XOBtYreKltlySnMIiHOmmmbnxlI+YruydeNEJh8aesgl3dvB3gXap9qIWrPLlp40c1+s
 DTkg==
X-Gm-Message-State: AOAM532Jjm86Vjg5a230ofeAufZiNLLyo8HYVoQq9SkqB68tVvZXI+Rx
 uRIkqhjBTBZNtM9BANnQHDQB6BuZ3d+OTOShHIP74J6HRewn2WChIApKaBSdRv4PAnioUJfSEHJ
 Z0v/Dsc4rguFNyVaSPTg8fi8as7h4/1SJAQOCB2fhzQ==
X-Received: by 2002:a62:18cf:0:b0:4fa:6d07:8b9b with SMTP id
 198-20020a6218cf000000b004fa6d078b9bmr21242721pfy.61.1647928971715; 
 Mon, 21 Mar 2022 23:02:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz0GJnnqMz90IPVZkn6/TsZYDL59oDk75/y6kWh/OPgwdgrzKx4krgbN/h8m7vMWAv1kpwdfg==
X-Received: by 2002:a62:18cf:0:b0:4fa:6d07:8b9b with SMTP id
 198-20020a6218cf000000b004fa6d078b9bmr21242693pfy.61.1647928971348; 
 Mon, 21 Mar 2022 23:02:51 -0700 (PDT)
Received: from [10.72.13.61] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 om17-20020a17090b3a9100b001bf0fffee9bsm1289751pjb.52.2022.03.21.23.02.49
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 21 Mar 2022 23:02:50 -0700 (PDT)
Message-ID: <e61a9ff4-621b-e7ec-b819-1b4c7e38fa67@redhat.com>
Date: Tue, 22 Mar 2022 14:02:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [PATCH v8 16/16] virtio_ring: introduce virtqueue_resize()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220314093455.34707-1-xuanzhuo@linux.alibaba.com>
 <20220314093455.34707-17-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220314093455.34707-17-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>
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

CuWcqCAyMDIyLzMvMTQg5LiL5Y2INTozNCwgWHVhbiBaaHVvIOWGmemBkzoKPiBJbnRyb2R1Y2Ug
dmlydHF1ZXVlX3Jlc2l6ZSgpIHRvIGltcGxlbWVudCB0aGUgcmVzaXplIG9mIHZyaW5nLgo+IEJh
c2VkIG9uIHRoZXNlLCB0aGUgZHJpdmVyIGNhbiBkeW5hbWljYWxseSBhZGp1c3QgdGhlIHNpemUg
b2YgdGhlIHZyaW5nLgo+IEZvciBleGFtcGxlOiBldGh0b29sIC1HLgo+Cj4gdmlydHF1ZXVlX3Jl
c2l6ZSgpIGltcGxlbWVudHMgcmVzaXplIGJhc2VkIG9uIHRoZSB2cSByZXNldCBmdW5jdGlvbi4g
SW4KPiBjYXNlIG9mIGZhaWx1cmUgdG8gYWxsb2NhdGUgYSBuZXcgdnJpbmcsIGl0IHdpbGwgZ2l2
ZSB1cCByZXNpemUgYW5kIHVzZQo+IHRoZSBvcmlnaW5hbCB2cmluZy4KPgo+IER1cmluZyB0aGlz
IHByb2Nlc3MsIGlmIHRoZSByZS1lbmFibGUgcmVzZXQgdnEgZmFpbHMsIHRoZSB2cSBjYW4gbm8K
PiBsb25nZXIgYmUgdXNlZC4gQWx0aG91Z2ggdGhlIHByb2JhYmlsaXR5IG9mIHRoaXMgc2l0dWF0
aW9uIGlzIG5vdCBoaWdoLgo+Cj4gVGhlIHBhcmFtZXRlciByZWN5Y2xlIGlzIHVzZWQgdG8gcmVj
eWNsZSB0aGUgYnVmZmVyIHRoYXQgaXMgbm8gbG9uZ2VyCj4gdXNlZC4KPgo+IFNpZ25lZC1vZmYt
Ynk6IFh1YW4gWmh1byA8eHVhbnpodW9AbGludXguYWxpYmFiYS5jb20+Cj4gLS0tCj4gICBkcml2
ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIHwgNjcgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrCj4gICBpbmNsdWRlL2xpbnV4L3ZpcnRpby5oICAgICAgIHwgIDMgKysKPiAgIDIg
ZmlsZXMgY2hhbmdlZCwgNzAgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5k
ZXggZmIwYWJmOWEyZjU3Li5iMWRkZTA4NmE4YTQgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0
aW8vdmlydGlvX3JpbmcuYwo+ICsrKyBiL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBA
QCAtMjUyOCw2ICsyNTI4LDczIEBAIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0
cXVldWUoCj4gICB9Cj4gICBFWFBPUlRfU1lNQk9MX0dQTCh2cmluZ19jcmVhdGVfdmlydHF1ZXVl
KTsKPiAgIAo+ICsvKioKPiArICogdmlydHF1ZXVlX3Jlc2l6ZSAtIHJlc2l6ZSB0aGUgdnJpbmcg
b2YgdnEKPiArICogQHZxOiB0aGUgc3RydWN0IHZpcnRxdWV1ZSB3ZSdyZSB0YWxraW5nIGFib3V0
Lgo+ICsgKiBAbnVtOiBuZXcgcmluZyBudW0KPiArICogQHJlY3ljbGU6IGNhbGxiYWNrIGZvciBy
ZWN5Y2xlIHRoZSB1c2VsZXNzIGJ1ZmZlcgo+ICsgKgo+ICsgKiBXaGVuIGl0IGlzIHJlYWxseSBu
ZWNlc3NhcnkgdG8gY3JlYXRlIGEgbmV3IHZyaW5nLCBpdCB3aWxsIHNldCB0aGUgY3VycmVudCB2
cQo+ICsgKiBpbnRvIHRoZSByZXNldCBzdGF0ZS4gVGhlbiBjYWxsIHRoZSBwYXNzZWQgY2IgdG8g
cmVjeWNsZSB0aGUgYnVmZmVyIHRoYXQgaXMKPiArICogbm8gbG9uZ2VyIHVzZWQuIE9ubHkgYWZ0
ZXIgdGhlIG5ldyB2cmluZyBpcyBzdWNjZXNzZnVsbHkgY3JlYXRlZCwgdGhlIG9sZAo+ICsgKiB2
cmluZyB3aWxsIGJlIHJlbGVhc2VkLgo+ICsgKgo+ICsgKiBDYWxsZXIgbXVzdCBlbnN1cmUgd2Ug
ZG9uJ3QgY2FsbCB0aGlzIHdpdGggb3RoZXIgdmlydHF1ZXVlIG9wZXJhdGlvbnMKPiArICogYXQg
dGhlIHNhbWUgdGltZSAoZXhjZXB0IHdoZXJlIG5vdGVkKS4KPiArICoKPiArICogUmV0dXJucyB6
ZXJvIG9yIGEgbmVnYXRpdmUgZXJyb3IuCj4gKyAqIC1FTk9NRU06IGNyZWF0ZSBuZXcgdnJpbmcg
ZmFpbC4gQnV0IHZxIGNhbiBzdGlsbCB3b3JrCj4gKyAqIC1FQlVTWTogIHJlc2V0L3JlLWVuYWJs
ZSB2cSBmYWlsLiB2cSBtYXkgY2Fubm90IHdvcmsKPiArICogLUVOT0VOVDogbm90IHN1cHBvcnQg
cmVzaXplCj4gKyAqIC1FMkJJRy8tRUlOVkFMOiBwYXJhbSBudW0gZXJyb3IKPiArICovCj4gK2lu
dCB2aXJ0cXVldWVfcmVzaXplKHN0cnVjdCB2aXJ0cXVldWUgKnZxLCB1MzIgbnVtLAo+ICsJCSAg
ICAgdm9pZCAoKnJlY3ljbGUpKHN0cnVjdCB2aXJ0cXVldWUgKnZxLCB2b2lkICpidWYpKQo+ICt7
Cj4gKwlzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiA9IHZxLT52ZGV2Owo+ICsJdm9pZCAqYnVm
Owo+ICsJaW50IGVycjsKPiArCj4gKwlpZiAobnVtID4gdnEtPm51bV9tYXgpCj4gKwkJcmV0dXJu
IC1FMkJJRzsKPiArCj4gKwlpZiAoIW51bSkKPiArCQlyZXR1cm4gLUVJTlZBTDsKPiArCj4gKwlp
ZiAodG9fdnZxKHZxKS0+cGFja2VkLnZyaW5nLm51bSA9PSBudW0pCj4gKwkJcmV0dXJuIDA7CgoK
QW55IHJlYXNvbiB3ZSBuZWVkIHRvIGNoZWNrIGEgcGFja2VkIHNwZWNpZmljIGF0dHJpYnV0ZSBo
ZXJlPwoKCj4gKwo+ICsJaWYgKCF2cS0+dmRldi0+Y29uZmlnLT5yZXNldF92cSkKPiArCQlyZXR1
cm4gLUVOT0VOVDsKPiArCj4gKwlpZiAoIXZxLT52ZGV2LT5jb25maWctPmVuYWJsZV9yZXNldF92
cSkKPiArCQlyZXR1cm4gLUVOT0VOVDsKPiArCj4gKwllcnIgPSB2cS0+dmRldi0+Y29uZmlnLT5y
ZXNldF92cSh2cSk7Cj4gKwlpZiAoZXJyKSB7Cj4gKwkJaWYgKGVyciAhPSAtRU5PRU5UKQo+ICsJ
CQllcnIgPSAtRUJVU1k7Cj4gKwkJcmV0dXJuIGVycjsKPiArCX0KPiArCj4gKwl3aGlsZSAoKGJ1
ZiA9IHZpcnRxdWV1ZV9kZXRhY2hfdW51c2VkX2J1Zih2cSkpICE9IE5VTEwpCj4gKwkJcmVjeWNs
ZSh2cSwgYnVmKTsKPiArCj4gKwlpZiAodmlydGlvX2hhc19mZWF0dXJlKHZkZXYsIFZJUlRJT19G
X1JJTkdfUEFDS0VEKSkKPiArCQllcnIgPSB2aXJ0cXVldWVfcmVzaXplX3BhY2tlZCh2cSwgbnVt
KTsKPiArCWVsc2UKPiArCQllcnIgPSB2aXJ0cXVldWVfcmVzaXplX3NwbGl0KHZxLCBudW0pOwo+
ICsKPiArCWlmIChlcnIpCj4gKwkJZXJyID0gLUVOT01FTTsKCgpTbyB0aGlzIGFzc3VtZXMgdGhh
dCB0aGUgLUVOT01FTSBpcyB0aGUgb25seSBwb3NzaWJsZSBlcnJvciB2YWx1ZSBmb3IgCnZpcnRx
dWV1ZV9yZXNpemVfeHh4KCkuIElzIHRoaXMgdHJ1ZT8gKEUuZyB3cm9uZyBzaXplKQoKCj4gKwo+
ICsJaWYgKHZxLT52ZGV2LT5jb25maWctPmVuYWJsZV9yZXNldF92cSh2cSkpCj4gKwkJcmV0dXJu
IC1FQlVTWTsKPiArCj4gKwlyZXR1cm4gZXJyOwo+ICt9Cj4gK0VYUE9SVF9TWU1CT0xfR1BMKHZp
cnRxdWV1ZV9yZXNpemUpOwo+ICsKPiAgIC8qIE9ubHkgYXZhaWxhYmxlIGZvciBzcGxpdCByaW5n
ICovCj4gICBzdHJ1Y3QgdmlydHF1ZXVlICp2cmluZ19uZXdfdmlydHF1ZXVlKHVuc2lnbmVkIGlu
dCBpbmRleCwKPiAgIAkJCQkgICAgICB1bnNpZ25lZCBpbnQgbnVtLAo+IGRpZmYgLS1naXQgYS9p
bmNsdWRlL2xpbnV4L3ZpcnRpby5oIGIvaW5jbHVkZS9saW51eC92aXJ0aW8uaAo+IGluZGV4IGQ1
OWFkYzRiZTA2OC4uYzg2ZmYwMmUwY2EwIDEwMDY0NAo+IC0tLSBhL2luY2x1ZGUvbGludXgvdmly
dGlvLmgKPiArKysgYi9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4gQEAgLTkxLDYgKzkxLDkgQEAg
ZG1hX2FkZHJfdCB2aXJ0cXVldWVfZ2V0X2Rlc2NfYWRkcihzdHJ1Y3QgdmlydHF1ZXVlICp2cSk7
Cj4gICBkbWFfYWRkcl90IHZpcnRxdWV1ZV9nZXRfYXZhaWxfYWRkcihzdHJ1Y3QgdmlydHF1ZXVl
ICp2cSk7Cj4gICBkbWFfYWRkcl90IHZpcnRxdWV1ZV9nZXRfdXNlZF9hZGRyKHN0cnVjdCB2aXJ0
cXVldWUgKnZxKTsKPiAgIAo+ICtpbnQgdmlydHF1ZXVlX3Jlc2l6ZShzdHJ1Y3QgdmlydHF1ZXVl
ICp2cSwgdTMyIG51bSwKPiArCQkgICAgIHZvaWQgKCpyZWN5Y2xlKShzdHJ1Y3QgdmlydHF1ZXVl
ICp2cSwgdm9pZCAqYnVmKSk7CgoKSSB3b25kZXIgd2hhdCdzIHRoZSBhZHZhbnRhZ2VzIG9mIGNv
dXBsaW5nIHZpcnRxdWV1ZV9yZXNldCBpbiAKdmlydHF1ZXVlX3Jlc2l6ZSgpLgoKSXQgbG9va3Mg
dG8gbWUgaXQgd29sZCBiZSBtb3JlIGZsZXhpYmxlIHRvIGxldCB0aGUgZHJpdmVyIGRvOgoKcmVz
dCgpCgpkZXRhY2goKQoKcmVzaXplKCkKCmVuYWJsZV9yZXNldCgpCgpPbmUgcmVhc29uIGlzIHRo
YXQgaW4gdGhlIGZ1dHVyZSB3ZSBtYXkgd2FudCB0byBhZGQgbW9yZSBmdW5jdGlvbmFsaXR5IApl
Lmcgc3dpdGNoaW5nIFBBU0lEIGR1cmluZyB2aXJ0cXVldWUgcmVzZXQuCgpUaGFua3MKCgo+ICsK
PiAgIC8qKgo+ICAgICogdmlydGlvX2RldmljZSAtIHJlcHJlc2VudGF0aW9uIG9mIGEgZGV2aWNl
IHVzaW5nIHZpcnRpbwo+ICAgICogQGluZGV4OiB1bmlxdWUgcG9zaXRpb24gb24gdGhlIHZpcnRp
byBidXMKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
