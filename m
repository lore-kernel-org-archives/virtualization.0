Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23DF3C433F5
	for <virtualization@archiver.kernel.org>; Thu,  3 Mar 2022 07:36:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A5E2684131;
	Thu,  3 Mar 2022 07:36:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7HzOhYLlliQW; Thu,  3 Mar 2022 07:36:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 4F1FD84130;
	Thu,  3 Mar 2022 07:36:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2F476C0012;
	Thu,  3 Mar 2022 07:36:08 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A783AC000B
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 07:36:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 84157400FE
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 07:36:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fKcy5ge1YcZd
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 07:36:05 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9BD5A400D7
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Mar 2022 07:36:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646292964;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U5oNE39EfKlPFujGAkQ8A0HvOKfIDxEkgU1zYUSJ1xg=;
 b=Dupm1J+v7me9R+o6N0DqEBeyb8CZaaO7S9zgMtGAa2GSbqT1Yttj678rXoW0SfVsI0rc0F
 zYZlDB3Y0BtwK3TJOt6vg9F5lyBSAWhUxXruxKClQTxmqrQ60dzjqAcLl7i4oTjRVoRrL2
 i4vknFelMCUqSWki3GViJH1Phos80ms=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-542-xJhIrl7XNtGN1w-jp9ADXg-1; Thu, 03 Mar 2022 02:36:03 -0500
X-MC-Unique: xJhIrl7XNtGN1w-jp9ADXg-1
Received: by mail-pj1-f69.google.com with SMTP id
 ev5-20020a17090aeac500b001bc3cb23d4cso3185465pjb.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Mar 2022 23:36:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=U5oNE39EfKlPFujGAkQ8A0HvOKfIDxEkgU1zYUSJ1xg=;
 b=e8Cp2PqEVl2UhgMzrgMNGS8Ok4Lmxb+g7RFiSJvMS3ptRk0Xgp9sZ0d3Qain7uzzgY
 427W8tnx2H+AdG7yLX3ZSmh1xEVfagClvwqJ9yU9XxOXhgZbQvBihpbU+2bsF6Dkyp2j
 b7dqPs/gRDgA9+MA9GeeAYphmzCquSITniPJN2twaRWzzuQQmjHgIs3ar3ltN1RpvvKe
 PShpSbJAzriaIVxKAa0k8nDuwqNMCfMufviI4bR21dVarCw+OIsszlByNu27ZVZQZ4z2
 pKRcKu3OJZZauHCvBT35hP6nCBWtwGWh2kf9LA/AMUwZhazb8V3WuXXz6FqnH6VzClqZ
 KKOg==
X-Gm-Message-State: AOAM533RWGPkn5ZP0p/kDq83JRA8YIwvibEbli99HPJg1dCav/skpuQr
 p21UG6ok9lf/O1JUUNTvq1FeHFbJr1ZEzlLRVquXG2PI87GubbIb+TpH8rNpqXpxLOY0vTShXPX
 fto9pcRgfCFwepyB+Y4GjRPeo6mbJL6PO4gCgusem+w==
X-Received: by 2002:a17:903:40c7:b0:151:a640:d69e with SMTP id
 t7-20020a17090340c700b00151a640d69emr2804756pld.121.1646292962273; 
 Wed, 02 Mar 2022 23:36:02 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwFjEnQJ6P4o/8Rn33oncXs2PW0aV7Jmi2wGK7zy+OCtFCg6f++gPo/bmlcMYc19x/nUzTsZA==
X-Received: by 2002:a17:903:40c7:b0:151:a640:d69e with SMTP id
 t7-20020a17090340c700b00151a640d69emr2804719pld.121.1646292962003; 
 Wed, 02 Mar 2022 23:36:02 -0800 (PST)
Received: from [10.72.13.250] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 d11-20020a056a0010cb00b004e1b76b09c0sm1421300pfu.74.2022.03.02.23.35.54
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 02 Mar 2022 23:36:01 -0800 (PST)
Message-ID: <cd0f4492-71fc-33d9-ca09-e61df5d2eadf@redhat.com>
Date: Thu, 3 Mar 2022 15:35:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v2 07/14] vhost: Shadow virtqueue buffers forwarding
To: Eugenio Perez Martin <eperezma@redhat.com>
References: <20220227134111.3254066-1-eperezma@redhat.com>
 <20220227134111.3254066-8-eperezma@redhat.com>
 <56fa64c3-416a-c748-4495-744b2f804aeb@redhat.com>
 <CAJaqyWe=hGmAvU_Fr34fecbF_7kUYqcm-EOdHJOo47TtddPwLw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <CAJaqyWe=hGmAvU_Fr34fecbF_7kUYqcm-EOdHJOo47TtddPwLw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>, qemu-level <qemu-devel@nongnu.org>,
 virtualization <virtualization@lists.linux-foundation.org>,
 Eli Cohen <eli@mellanox.com>, Eric Blake <eblake@redhat.com>,
 Parav Pandit <parav@mellanox.com>, Cindy Lu <lulu@redhat.com>,
 "Fangyi \(Eric\)" <eric.fangyi@huawei.com>,
 Markus Armbruster <armbru@redhat.com>, yebiaoxiang@huawei.com,
 Liuxiangdong <liuxiangdong5@huawei.com>, Laurent Vivier <lvivier@redhat.com>,
 Eduardo Habkost <ehabkost@redhat.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 Gautam Dawar <gdawar@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Stefan Hajnoczi <stefanha@redhat.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Paolo Bonzini <pbonzini@redhat.com>,
 Lingshan <lingshan.zhu@intel.com>
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

CuWcqCAyMDIyLzMvMyDkuIrljYgyOjIzLCBFdWdlbmlvIFBlcmV6IE1hcnRpbiDlhpnpgZM6Cj4+
PiArCj4+PiArc3RhdGljIGJvb2wgdmhvc3Rfc3ZxX2FkZF9zcGxpdChWaG9zdFNoYWRvd1ZpcnRx
dWV1ZSAqc3ZxLAo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgVmlydFF1ZXVl
RWxlbWVudCAqZWxlbSwKPj4+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVuc2ln
bmVkICpoZWFkKQo+Pj4gK3sKPj4+ICsgICAgdW5zaWduZWQgYXZhaWxfaWR4Owo+Pj4gKyAgICB2
cmluZ19hdmFpbF90ICphdmFpbCA9IHN2cS0+dnJpbmcuYXZhaWw7Cj4+PiArCj4+PiArICAgICpo
ZWFkID0gc3ZxLT5mcmVlX2hlYWQ7Cj4+PiArCj4+PiArICAgIC8qIFdlIG5lZWQgc29tZSBkZXNj
cmlwdG9ycyBoZXJlICovCj4+PiArICAgIGlmICh1bmxpa2VseSghZWxlbS0+b3V0X251bSAmJiAh
ZWxlbS0+aW5fbnVtKSkgewo+Pj4gKyAgICAgICAgcWVtdV9sb2dfbWFzayhMT0dfR1VFU1RfRVJS
T1IsCj4+PiArICAgICAgICAgICAgIkd1ZXN0IHByb3ZpZGVkIGVsZW1lbnQgd2l0aCBubyBkZXNj
cmlwdG9ycyIpOwo+Pj4gKyAgICAgICAgcmV0dXJuIGZhbHNlOwo+Pj4gKyAgICB9Cj4+PiArCj4+
PiArICAgIHZob3N0X3ZyaW5nX3dyaXRlX2Rlc2NzKHN2cSwgZWxlbS0+b3V0X3NnLCBlbGVtLT5v
dXRfbnVtLAo+Pj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICBlbGVtLT5pbl9udW0gPiAw
LCBmYWxzZSk7Cj4+PiArICAgIHZob3N0X3ZyaW5nX3dyaXRlX2Rlc2NzKHN2cSwgZWxlbS0+aW5f
c2csIGVsZW0tPmluX251bSwgZmFsc2UsIHRydWUpOwo+PiBJIHdvbmRlciBpbnN0ZWFkIG9mIHBh
c3NpbmcgaW4vb3V0IHNlcGFyYXRlbHkgYW5kIHVzaW5nIHRoZSBoaW50IGxpa2UKPj4gbW9yZV9k
ZXNjcywgaXMgaXQgYmV0dGVyIHRvIHNpbXBseSBwYXNzIHRoZSBlbGVtIHRvCj4+IHZob3N0X3Zy
aWduX3dyaXRlX2Rlc2NzKCkgdGhlbiB3ZSBrbm93IHdoaWNoIG9uZSBpcyB0aGUgbGFzdCB0aGF0
Cj4+IGRvZXNuJ3QgZGVwZW5kIG9uIG1vcmVfZGVzY3MuCj4+Cj4gSSdtIG5vdCBzdXJlIEkgZm9s
bG93IHRoaXMuCj4KPiBUaGUgcHVycG9zZSBvZiB2aG9zdF92cmluZ193cml0ZV9kZXNjcyBpcyB0
byBhYnN0cmFjdCB0aGUgd3JpdGluZyBvZiBhCj4gYmF0Y2ggb2YgZGVzY3JpcHRvcnMsIGl0cyBj
aGFpbmluZywgZXRjLiBJdCBhY2NlcHRzIHRoZSB3cml0ZQo+IHBhcmFtZXRlciBqdXN0IGZvciB0
aGUgd3JpdGUgZmxhZy4gSWYgd2UgbWFrZSBlbGVtIGFzIGEgcGFyYW1ldGVyLCB3ZQo+IHdvdWxk
IG5lZWQgdG8gZHVwbGljYXRlIHRoYXQgZm9yIGxvb3AgZm9yIHJlYWQgYW5kIGZvciB3cml0ZQo+
IGRlc2NyaXB0b3JzLCBpc24ndCBpdD8KPgo+IFRvIGR1cGxpY2F0ZSB0aGUgZm9yIGxvb3AgaXMg
dGhlIHdheSBpdCBpcyBkb25lIGluIHRoZSBrZXJuZWwsIGJ1dCBJCj4gYWN0dWFsbHkgdGhpbmsg
dGhlIGtlcm5lbCBjb3VsZCBiZW5lZml0IGZyb20gYWJzdHJhY3RpbmcgYm90aCBpbiB0aGUKPiBz
YW1lIGZ1bmN0aW9uIHRvby4gUGxlYXNlIGxldCBtZSBrbm93IGlmIHlvdSB0aGluayBvdGhlcndp
c2Ugb3IgSSd2ZQo+IG1pc3NlZCB5b3VyIHBvaW50LgoKCk9rLCBzbyBpdCdzIGp1c3QgYSBzdWdn
ZXN0aW9uIGFuZCB3ZSBjYW4gZG8gb3B0aW1pemF0aW9uIG9uIHRvcCBmb3Igc3VyZS4KClRoYW5r
cwoKCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
