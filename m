Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0A1ABC433EF
	for <virtualization@archiver.kernel.org>; Mon,  4 Jul 2022 03:47:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9DFC940121;
	Mon,  4 Jul 2022 03:47:50 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9DFC940121
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=PBE4QMNN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XipNOrrnYdIo; Mon,  4 Jul 2022 03:47:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0BD3740114;
	Mon,  4 Jul 2022 03:47:48 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0BD3740114
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E540DC0032;
	Mon,  4 Jul 2022 03:47:48 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C8385C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 03:47:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id AFECF60BAB
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 03:47:46 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org AFECF60BAB
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=PBE4QMNN
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OVxrmYRulsKq
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 03:47:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 6361560888
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 6361560888
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jul 2022 03:47:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1656906464;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=L2gDTuBKuZK9BdBvTV1z4CFK8vS6yKvfUsO3/KE/ibo=;
 b=PBE4QMNNI0M/8LlN62bMqbOEl7LajpLJLO5Ur/m6yb1qveGNYnptNc5rTBuAUBQ3q3ILEw
 p0pK7yA797kZ1EpBBjfInICTDMDD1aZvhGvJ0ify/D92YIBbdmUF6v4ap3FgPXVkhlyu+u
 w+6UzeQxE3L8927Dlo2eXXiBbfGH4CU=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-BndEh47iNXyLfKPKPNETAg-1; Sun, 03 Jul 2022 23:47:43 -0400
X-MC-Unique: BndEh47iNXyLfKPKPNETAg-1
Received: by mail-pf1-f197.google.com with SMTP id
 e5-20020a056a00162500b0052842526a4aso1048618pfc.17
 for <virtualization@lists.linux-foundation.org>;
 Sun, 03 Jul 2022 20:47:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:from:to:cc:references:in-reply-to
 :content-transfer-encoding;
 bh=L2gDTuBKuZK9BdBvTV1z4CFK8vS6yKvfUsO3/KE/ibo=;
 b=Ekq8oyGJXR0oOxIHP/x2Lrw8TXV3+NcOeslstxVryGP1UNU4lycr+zm14bEdaJZVaS
 uzFrZ8G9Qf8X1AbpzgTz+MImb/7GtYdnLG/WuRlXx+1FHpCBwMNvbx1e6S5v5Xe+mXjO
 +LMrZeCw3pdqGhqBFFUB4eKcsfmc/28ZUL1adqS8ZQ7ZldD5xKW+qS6WxMTptAd1nPOR
 ENPqnw4YT/n5yjtLFpms5C4CU2b0dcduCE0U0KXtXRMeO69ecJLCdcVNyUWuF+0YD74P
 qRSk73s2Zlf0KCdTaeVkoa+eBY5dbh2SaNJIpq8G7flrg82UW/dPMBQZwYvC+UDoirhu
 QEhw==
X-Gm-Message-State: AJIora/T9hYEw5y05Uv4ZT3SXlWfpiQxWQyU5WYGtI48k1Zg3hF3fvOl
 Sivw/Rq39bduqtB+TrLvzLsD6U+QYLUXk60H/BcQoDcIBxMEf2957XTb65brVaEEfc8KPMnTVAo
 abwf2A89xNjOEkeAAMl5UDGiKX9sOlnM3EAZwRDXZPg==
X-Received: by 2002:a17:902:8b87:b0:169:5e5:43de with SMTP id
 ay7-20020a1709028b8700b0016905e543demr33751366plb.8.1656906461976; 
 Sun, 03 Jul 2022 20:47:41 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1urar+tEFxn2OYR0nSzN1qR/6pFNL30ksJWbHZrPH1ZYknebpnFXj10hmhcTKfVqx002oRx8A==
X-Received: by 2002:a17:902:8b87:b0:169:5e5:43de with SMTP id
 ay7-20020a1709028b8700b0016905e543demr33751314plb.8.1656906461703; 
 Sun, 03 Jul 2022 20:47:41 -0700 (PDT)
Received: from [10.72.13.251] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 e11-20020a17090a7c4b00b001eee8998f2esm8701227pjl.17.2022.07.03.20.47.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 03 Jul 2022 20:47:41 -0700 (PDT)
Message-ID: <2fdff856-cddf-1235-8078-312de94600c7@redhat.com>
Date: Mon, 4 Jul 2022 11:47:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v11 25/40] virtio: allow to unbreak/break virtqueue
 individually
From: Jason Wang <jasowang@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-26-xuanzhuo@linux.alibaba.com>
 <20220701022950-mutt-send-email-mst@kernel.org>
 <79e519ec-0129-6a21-11da-44eaff1429fa@redhat.com>
In-Reply-To: <79e519ec-0129-6a21-11da-44eaff1429fa@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Vadim Pasternak <vadimp@nvidia.com>, linux-remoteproc@vger.kernel.org,
 Alexei Starovoitov <ast@kernel.org>, virtualization@lists.linux-foundation.org,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, platform-driver-x86@vger.kernel.org,
 Eric Farman <farman@linux.ibm.com>, Jesper Dangaard Brouer <hawk@kernel.org>,
 Vasily Gorbik <gor@linux.ibm.com>, kangjie.xu@linux.alibaba.com,
 Heiko Carstens <hca@linux.ibm.com>, linux-um@lists.infradead.org,
 Mark Gross <markgross@kernel.org>, Hans de Goede <hdegoede@redhat.com>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, bpf@vger.kernel.org,
 Paolo Abeni <pabeni@redhat.com>, Mathieu Poirier <mathieu.poirier@linaro.org>,
 netdev@vger.kernel.org, Cornelia Huck <cohuck@redhat.com>,
 Sven Schnelle <svens@linux.ibm.com>, Johannes Berg <johannes@sipsolutions.net>,
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

CuWcqCAyMDIyLzcvMSAxNzozNiwgSmFzb24gV2FuZyDlhpnpgZM6Cj4KPiDlnKggMjAyMi83LzEg
MTQ6MzEsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4+IE9uIFdlZCwgSnVuIDI5LCAyMDIy
IGF0IDAyOjU2OjQxUE0gKzA4MDAsIFh1YW4gWmh1byB3cm90ZToKPj4+IFRoaXMgcGF0Y2ggYWxs
b3dzIHRoZSBuZXcgaW50cm9kdWNlZAo+Pj4gX192aXJ0cXVldWVfYnJlYWsoKS9fX3ZpcnRxdWV1
ZV91bmJyZWFrKCkgdG8gYnJlYWsvdW5icmVhayB0aGUKPj4+IHZpcnRxdWV1ZS4KPj4+Cj4+PiBT
aWduZWQtb2ZmLWJ5OiBYdWFuIFpodW8gPHh1YW56aHVvQGxpbnV4LmFsaWJhYmEuY29tPgo+PiBJ
IHdvbmRlciBob3cgdGhpcyBpbnRlcmFjdHMgd2l0aCB0aGUgaGFyZGVuaW5nIHBhdGNoZXMuCj4+
IEphc29uPwo+Cj4KPiBDb25zaWRlciB3ZSd2ZSBtYXJrZWQgaXQgYXMgYnJva2VuLCBJIHRoaW5r
IHdlIGRvbid0IG5lZWQgdG8gY2FyZSAKPiBhYm91dCB0aGUgaGFyZGVuaW5nIGluIHRoaXMgc2Vy
aWVzLiBKdXN0IG1ha2UgaXQgd29yayB3aXRob3V0IGhhcmRlbmluZy4KPgo+IEFuZCBJIHdpbGwg
aGFuZGxlIHZxIHJlc2V0IHdoZW4gcmV3b3JrIHRoZSBJUlEgaGFyZGVuaW5nLgo+Cj4gVGhhbmtz
CgoKUmV0aGluayBvZiB0aGlzLCBJIHRoaW5rIFh1YW4ncyBjb2RlIHNob3VsZCBiZSBmaW5lLiBX
ZSBrbm93IHdlIHdpbGwgCmhhdmUgYW5vdGhlciByZXdvcmsuCgpUaGFua3MKCgo+Cj4KPj4KPj4+
IC0tLQo+Pj4gwqAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDI0ICsrKysrKysrKysr
KysrKysrKysrKysrKwo+Pj4gwqAgaW5jbHVkZS9saW51eC92aXJ0aW8uaMKgwqDCoMKgwqDCoCB8
wqAgMyArKysKPj4+IMKgIDIgZmlsZXMgY2hhbmdlZCwgMjcgaW5zZXJ0aW9ucygrKQo+Pj4KPj4+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fcmluZy5jIAo+Pj4gYi9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jCj4+PiBpbmRleCA1ZWM0MzYwN2NjMTUuLjdiMDJiZTdmY2U2
NyAxMDA2NDQKPj4+IC0tLSBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPj4+ICsrKyBi
L2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPj4+IEBAIC0yNzQ0LDYgKzI3NDQsMzAgQEAg
dW5zaWduZWQgaW50IHZpcnRxdWV1ZV9nZXRfdnJpbmdfc2l6ZShzdHJ1Y3QgCj4+PiB2aXJ0cXVl
dWUgKl92cSkKPj4+IMKgIH0KPj4+IMKgIEVYUE9SVF9TWU1CT0xfR1BMKHZpcnRxdWV1ZV9nZXRf
dnJpbmdfc2l6ZSk7Cj4+PiDCoCArLyoKPj4+ICsgKiBUaGlzIGZ1bmN0aW9uIHNob3VsZCBvbmx5
IGJlIGNhbGxlZCBieSB0aGUgY29yZSwgbm90IGRpcmVjdGx5IGJ5IAo+Pj4gdGhlIGRyaXZlci4K
Pj4+ICsgKi8KPj4+ICt2b2lkIF9fdmlydHF1ZXVlX2JyZWFrKHN0cnVjdCB2aXJ0cXVldWUgKl92
cSkKPj4+ICt7Cj4+PiArwqDCoMKgIHN0cnVjdCB2cmluZ192aXJ0cXVldWUgKnZxID0gdG9fdnZx
KF92cSk7Cj4+PiArCj4+PiArwqDCoMKgIC8qIFBhaXJzIHdpdGggUkVBRF9PTkNFKCkgaW4gdmly
dHF1ZXVlX2lzX2Jyb2tlbigpLiAqLwo+Pj4gK8KgwqDCoCBXUklURV9PTkNFKHZxLT5icm9rZW4s
IHRydWUpOwo+Pj4gK30KPj4+ICtFWFBPUlRfU1lNQk9MX0dQTChfX3ZpcnRxdWV1ZV9icmVhayk7
Cj4+PiArCj4+PiArLyoKPj4+ICsgKiBUaGlzIGZ1bmN0aW9uIHNob3VsZCBvbmx5IGJlIGNhbGxl
ZCBieSB0aGUgY29yZSwgbm90IGRpcmVjdGx5IGJ5IAo+Pj4gdGhlIGRyaXZlci4KPj4+ICsgKi8K
Pj4+ICt2b2lkIF9fdmlydHF1ZXVlX3VuYnJlYWsoc3RydWN0IHZpcnRxdWV1ZSAqX3ZxKQo+Pj4g
K3sKPj4+ICvCoMKgwqAgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEgPSB0b192dnEoX3ZxKTsK
Pj4+ICsKPj4+ICvCoMKgwqAgLyogUGFpcnMgd2l0aCBSRUFEX09OQ0UoKSBpbiB2aXJ0cXVldWVf
aXNfYnJva2VuKCkuICovCj4+PiArwqDCoMKgIFdSSVRFX09OQ0UodnEtPmJyb2tlbiwgZmFsc2Up
Owo+Pj4gK30KPj4gSSBkb24ndCB0aGluayB0aGVzZSAiUGFpcnMiIGNvbW1lbnRzIGhhdmUgYW55
IHZhbHVlLgo+Pgo+Pgo+Pj4gK0VYUE9SVF9TWU1CT0xfR1BMKF9fdmlydHF1ZXVlX3VuYnJlYWsp
Owo+Pj4gKwo+Pj4gwqAgYm9vbCB2aXJ0cXVldWVfaXNfYnJva2VuKHN0cnVjdCB2aXJ0cXVldWUg
Kl92cSkKPj4+IMKgIHsKPj4+IMKgwqDCoMKgwqAgc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZSAqdnEg
PSB0b192dnEoX3ZxKTsKPj4+IGRpZmYgLS1naXQgYS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oIGIv
aW5jbHVkZS9saW51eC92aXJ0aW8uaAo+Pj4gaW5kZXggMTI3MjU2NmFkZWM2Li5kYzQ3NGEwZDQ4
ZDEgMTAwNjQ0Cj4+PiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZpcnRpby5oCj4+PiArKysgYi9pbmNs
dWRlL2xpbnV4L3ZpcnRpby5oCj4+PiBAQCAtMTM4LDYgKzEzOCw5IEBAIGJvb2wgaXNfdmlydGlv
X2RldmljZShzdHJ1Y3QgZGV2aWNlICpkZXYpOwo+Pj4gwqAgdm9pZCB2aXJ0aW9fYnJlYWtfZGV2
aWNlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICpkZXYpOwo+Pj4gwqAgdm9pZCBfX3ZpcnRpb191bmJy
ZWFrX2RldmljZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqZGV2KTsKPj4+IMKgICt2b2lkIF9fdmly
dHF1ZXVlX2JyZWFrKHN0cnVjdCB2aXJ0cXVldWUgKl92cSk7Cj4+PiArdm9pZCBfX3ZpcnRxdWV1
ZV91bmJyZWFrKHN0cnVjdCB2aXJ0cXVldWUgKl92cSk7Cj4+PiArCj4+PiDCoCB2b2lkIHZpcnRp
b19jb25maWdfY2hhbmdlZChzdHJ1Y3QgdmlydGlvX2RldmljZSAqZGV2KTsKPj4+IMKgICNpZmRl
ZiBDT05GSUdfUE1fU0xFRVAKPj4+IMKgIGludCB2aXJ0aW9fZGV2aWNlX2ZyZWV6ZShzdHJ1Y3Qg
dmlydGlvX2RldmljZSAqZGV2KTsKPj4+IC0tIAo+Pj4gMi4zMS4wCgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
