Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55A81C19F21
	for <virtualization@archiver.kernel.org>; Wed, 27 Jul 2022 03:15:11 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id DF4EC8146B;
	Wed, 27 Jul 2022 03:15:10 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org DF4EC8146B
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ErjEfeUQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id xeBUNYaikJGo; Wed, 27 Jul 2022 03:15:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 579618140A;
	Wed, 27 Jul 2022 03:15:09 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 579618140A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 05E76C0033;
	Wed, 27 Jul 2022 03:15:09 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 189E3C002D
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 03:15:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id D3EED4011C
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 03:15:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D3EED4011C
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=ErjEfeUQ
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hvV4_oXUV4ZN
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 03:15:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0B4894016A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 0B4894016A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 27 Jul 2022 03:15:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1658891704;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=yAKBMltJyGT+XDVzCIxs8bNeAmqSdQfBVMzuB9SWIpM=;
 b=ErjEfeUQMRmEG4ACPMAKHo2BtgNMnj2v0aYKjFTkp9uqPKysGFJ8IN5Fu0wqTkyNQwS48d
 75M12NBwMwcZGSroDItIgsLzaR4y4q2Bgq3c6KNUL5W2HnOOzVq1vHpPu5reJCISek1v2k
 5rn/V+JG6DS6DXdEX+Abnf7goJ+iFXA=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-520-tTWG1IxrOp27CGkD6UzQXg-1; Tue, 26 Jul 2022 23:15:03 -0400
X-MC-Unique: tTWG1IxrOp27CGkD6UzQXg-1
Received: by mail-pj1-f72.google.com with SMTP id
 x5-20020a17090a294500b001f2f1cf6874so456425pjf.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Jul 2022 20:15:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=yAKBMltJyGT+XDVzCIxs8bNeAmqSdQfBVMzuB9SWIpM=;
 b=hPATRONko01npHk8wkY6jVB6t8igY51sM7pLfHC9WJzA+ZREWh9/fvVVtV+Oe4XzRA
 WLM1nvMHKWKxSCLn9dOjUgNNBYebYIXeHRDxpFTShNbs8dL31Fyz52X88XllycsjA3Fz
 GfneQwmLX/bzUNKhbw4cKpwaZIwI1FoZOaYB1IXFVCqP0m8HsT1LrAU4sIQQmV+/YEp6
 dBLEs/jgC5JoJqQJO5BOpq4hBW8JM0x9ayUhmdAYji38RBfRnlsrpePdFi1DrdECI2Mc
 KeSx5OdIIkVmRi18Q/Yr32R2Oyjv1l1HrWF01/J36doe/CuOItqm97cHRvdHAb99n8pR
 JxUw==
X-Gm-Message-State: AJIora+U6jUO3noF8VtT5XgOcvFOjk5S6y/ECB+klDYeknLXSx5DEcvb
 2HXnIPrQhOoGRpmwngsxLVtkC727fH7E6LQwlutUYw3aYTPE1a7IBpTTqGOatbOIvrvsFzGjCpe
 ukh3fK+occIhnquDYvvXRDQKJxknNj0MKsISIag4iYA==
X-Received: by 2002:a17:90a:7ac4:b0:1ef:a606:4974 with SMTP id
 b4-20020a17090a7ac400b001efa6064974mr2213610pjl.51.1658891702483; 
 Tue, 26 Jul 2022 20:15:02 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tidh/QksEFcBpkv4BftDUD29CxNpBLdCVexTNH/t5AotOLArf7ctQ7cPh2UR9oOEGuuBXIcw==
X-Received: by 2002:a17:90a:7ac4:b0:1ef:a606:4974 with SMTP id
 b4-20020a17090a7ac400b001efa6064974mr2213573pjl.51.1658891702151; 
 Tue, 26 Jul 2022 20:15:02 -0700 (PDT)
Received: from [10.72.13.38] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 2-20020a621902000000b005251fc16ff8sm12401220pfz.220.2022.07.26.20.14.51
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 26 Jul 2022 20:15:01 -0700 (PDT)
Message-ID: <b4dde067-35b9-d2c2-a344-310020e6ba19@redhat.com>
Date: Wed, 27 Jul 2022 11:14:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v13 10/42] virtio_ring: split: extract the logic of alloc
 queue
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 virtualization@lists.linux-foundation.org
References: <20220726072225.19884-1-xuanzhuo@linux.alibaba.com>
 <20220726072225.19884-11-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220726072225.19884-11-xuanzhuo@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Vadim Pasternak <vadimp@nvidia.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 linux-remoteproc@vger.kernel.org, Alexei Starovoitov <ast@kernel.org>,
 Bjorn Andersson <bjorn.andersson@linaro.org>,
 Eric Dumazet <edumazet@google.com>, Alexander Gordeev <agordeev@linux.ibm.com>,
 Anton Ivanov <anton.ivanov@cambridgegreys.com>, linux-s390@vger.kernel.org,
 kvm@vger.kernel.org, Daniel Borkmann <daniel@iogearbox.net>,
 Richard Weinberger <richard@nod.at>,
 Vincent Whitchurch <vincent.whitchurch@axis.com>,
 John Fastabend <john.fastabend@gmail.com>, Halil Pasic <pasic@linux.ibm.com>,
 Jakub Kicinski <kuba@kernel.org>, Eric Farman <farman@linux.ibm.com>,
 Jesper Dangaard Brouer <hawk@kernel.org>, Vasily Gorbik <gor@linux.ibm.com>,
 kangjie.xu@linux.alibaba.com, Heiko Carstens <hca@linux.ibm.com>,
 linux-um@lists.infradead.org, Mark Gross <markgross@kernel.org>,
 Hans de Goede <hdegoede@redhat.com>, platform-driver-x86@vger.kernel.org,
 bpf@vger.kernel.org, Paolo Abeni <pabeni@redhat.com>,
 Mathieu Poirier <mathieu.poirier@linaro.org>, netdev@vger.kernel.org,
 Cornelia Huck <cohuck@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 Johannes Berg <johannes@sipsolutions.net>,
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

CuWcqCAyMDIyLzcvMjYgMTU6MjEsIFh1YW4gWmh1byDlhpnpgZM6Cj4gU2VwYXJhdGUgdGhlIGxv
Z2ljIG9mIHNwbGl0IHRvIGNyZWF0ZSB2cmluZyBxdWV1ZS4KPgo+IFRoaXMgZmVhdHVyZSBpcyBy
ZXF1aXJlZCBmb3Igc3Vic2VxdWVudCB2aXJ0dXF1ZXVlIHJlc2V0IHZyaW5nLgo+Cj4gU2lnbmVk
LW9mZi1ieTogWHVhbiBaaHVvIDx4dWFuemh1b0BsaW51eC5hbGliYWJhLmNvbT4KCgpBY2tlZC1i
eTogSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KCgo+IC0tLQo+ICAgZHJpdmVycy92
aXJ0aW8vdmlydGlvX3JpbmcuYyB8IDY1ICsrKysrKysrKysrKysrKysrKysrKystLS0tLS0tLS0t
LS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDQwIGluc2VydGlvbnMoKyksIDI1IGRlbGV0aW9ucygt
KQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmlydGlvL3ZpcnRpb19yaW5nLmMgYi9kcml2ZXJz
L3ZpcnRpby92aXJ0aW9fcmluZy5jCj4gaW5kZXggYmE3Y2M1NjBkODIzLi4zODE3NTIwMzcxZWUg
MTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92aXJ0aW8vdmlydGlvX3JpbmcuYwo+ICsrKyBiL2RyaXZl
cnMvdmlydGlvL3ZpcnRpb19yaW5nLmMKPiBAQCAtOTU4LDI5ICs5NTgsMTkgQEAgc3RhdGljIHZv
aWQgdnJpbmdfZnJlZV9zcGxpdChzdHJ1Y3QgdnJpbmdfdmlydHF1ZXVlX3NwbGl0ICp2cmluZ19z
cGxpdCwKPiAgIAlrZnJlZSh2cmluZ19zcGxpdC0+ZGVzY19leHRyYSk7Cj4gICB9Cj4gICAKPiAt
c3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfc3BsaXQoCj4g
LQl1bnNpZ25lZCBpbnQgaW5kZXgsCj4gLQl1bnNpZ25lZCBpbnQgbnVtLAo+IC0JdW5zaWduZWQg
aW50IHZyaW5nX2FsaWduLAo+IC0Jc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsCj4gLQlib29s
IHdlYWtfYmFycmllcnMsCj4gLQlib29sIG1heV9yZWR1Y2VfbnVtLAo+IC0JYm9vbCBjb250ZXh0
LAo+IC0JYm9vbCAoKm5vdGlmeSkoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPiAtCXZvaWQgKCpjYWxs
YmFjaykoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPiAtCWNvbnN0IGNoYXIgKm5hbWUpCj4gK3N0YXRp
YyBpbnQgdnJpbmdfYWxsb2NfcXVldWVfc3BsaXQoc3RydWN0IHZyaW5nX3ZpcnRxdWV1ZV9zcGxp
dCAqdnJpbmdfc3BsaXQsCj4gKwkJCQkgICBzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldiwKPiAr
CQkJCSAgIHUzMiBudW0sCj4gKwkJCQkgICB1bnNpZ25lZCBpbnQgdnJpbmdfYWxpZ24sCj4gKwkJ
CQkgICBib29sIG1heV9yZWR1Y2VfbnVtKQo+ICAgewo+IC0Jc3RydWN0IHZyaW5nX3ZpcnRxdWV1
ZV9zcGxpdCB2cmluZ19zcGxpdCA9IHt9Owo+IC0Jc3RydWN0IHZpcnRxdWV1ZSAqdnE7Cj4gICAJ
dm9pZCAqcXVldWUgPSBOVUxMOwo+ICAgCWRtYV9hZGRyX3QgZG1hX2FkZHI7Cj4gLQlzaXplX3Qg
cXVldWVfc2l6ZV9pbl9ieXRlczsKPiAtCXN0cnVjdCB2cmluZyB2cmluZzsKPiAgIAo+ICAgCS8q
IFdlIGFzc3VtZSBudW0gaXMgYSBwb3dlciBvZiAyLiAqLwo+ICAgCWlmIChudW0gJiAobnVtIC0g
MSkpIHsKPiAgIAkJZGV2X3dhcm4oJnZkZXYtPmRldiwgIkJhZCB2aXJ0cXVldWUgbGVuZ3RoICV1
XG4iLCBudW0pOwo+IC0JCXJldHVybiBOVUxMOwo+ICsJCXJldHVybiAtRUlOVkFMOwo+ICAgCX0K
PiAgIAo+ICAgCS8qIFRPRE86IGFsbG9jYXRlIGVhY2ggcXVldWUgY2h1bmsgaW5kaXZpZHVhbGx5
ICovCj4gQEAgLTk5MSwxMSArOTgxLDExIEBAIHN0YXRpYyBzdHJ1Y3QgdmlydHF1ZXVlICp2cmlu
Z19jcmVhdGVfdmlydHF1ZXVlX3NwbGl0KAo+ICAgCQlpZiAocXVldWUpCj4gICAJCQlicmVhazsK
PiAgIAkJaWYgKCFtYXlfcmVkdWNlX251bSkKPiAtCQkJcmV0dXJuIE5VTEw7Cj4gKwkJCXJldHVy
biAtRU5PTUVNOwo+ICAgCX0KPiAgIAo+ICAgCWlmICghbnVtKQo+IC0JCXJldHVybiBOVUxMOwo+
ICsJCXJldHVybiAtRU5PTUVNOwo+ICAgCj4gICAJaWYgKCFxdWV1ZSkgewo+ICAgCQkvKiBUcnkg
dG8gZ2V0IGEgc2luZ2xlIHBhZ2UuIFlvdSBhcmUgbXkgb25seSBob3BlISAqLwo+IEBAIC0xMDAz
LDIxICs5OTMsNDYgQEAgc3RhdGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0
cXVldWVfc3BsaXQoCj4gICAJCQkJCSAgJmRtYV9hZGRyLCBHRlBfS0VSTkVMfF9fR0ZQX1pFUk8p
Owo+ICAgCX0KPiAgIAlpZiAoIXF1ZXVlKQo+IC0JCXJldHVybiBOVUxMOwo+ICsJCXJldHVybiAt
RU5PTUVNOwo+ICsKPiArCXZyaW5nX2luaXQoJnZyaW5nX3NwbGl0LT52cmluZywgbnVtLCBxdWV1
ZSwgdnJpbmdfYWxpZ24pOwo+ICAgCj4gLQlxdWV1ZV9zaXplX2luX2J5dGVzID0gdnJpbmdfc2l6
ZShudW0sIHZyaW5nX2FsaWduKTsKPiAtCXZyaW5nX2luaXQoJnZyaW5nX3NwbGl0LnZyaW5nLCBu
dW0sIHF1ZXVlLCB2cmluZ19hbGlnbik7Cj4gKwl2cmluZ19zcGxpdC0+cXVldWVfZG1hX2FkZHIg
PSBkbWFfYWRkcjsKPiArCXZyaW5nX3NwbGl0LT5xdWV1ZV9zaXplX2luX2J5dGVzID0gdnJpbmdf
c2l6ZShudW0sIHZyaW5nX2FsaWduKTsKPiArCj4gKwlyZXR1cm4gMDsKPiArfQo+ICsKPiArc3Rh
dGljIHN0cnVjdCB2aXJ0cXVldWUgKnZyaW5nX2NyZWF0ZV92aXJ0cXVldWVfc3BsaXQoCj4gKwl1
bnNpZ25lZCBpbnQgaW5kZXgsCj4gKwl1bnNpZ25lZCBpbnQgbnVtLAo+ICsJdW5zaWduZWQgaW50
IHZyaW5nX2FsaWduLAo+ICsJc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYsCj4gKwlib29sIHdl
YWtfYmFycmllcnMsCj4gKwlib29sIG1heV9yZWR1Y2VfbnVtLAo+ICsJYm9vbCBjb250ZXh0LAo+
ICsJYm9vbCAoKm5vdGlmeSkoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPiArCXZvaWQgKCpjYWxsYmFj
aykoc3RydWN0IHZpcnRxdWV1ZSAqKSwKPiArCWNvbnN0IGNoYXIgKm5hbWUpCj4gK3sKPiArCXN0
cnVjdCB2cmluZ192aXJ0cXVldWVfc3BsaXQgdnJpbmdfc3BsaXQgPSB7fTsKPiArCXN0cnVjdCB2
aXJ0cXVldWUgKnZxOwo+ICsJaW50IGVycjsKPiArCj4gKwllcnIgPSB2cmluZ19hbGxvY19xdWV1
ZV9zcGxpdCgmdnJpbmdfc3BsaXQsIHZkZXYsIG51bSwgdnJpbmdfYWxpZ24sCj4gKwkJCQkgICAg
ICBtYXlfcmVkdWNlX251bSk7Cj4gKwlpZiAoZXJyKQo+ICsJCXJldHVybiBOVUxMOwo+ICAgCj4g
ICAJdnEgPSBfX3ZyaW5nX25ld192aXJ0cXVldWUoaW5kZXgsICZ2cmluZ19zcGxpdCwgdmRldiwg
d2Vha19iYXJyaWVycywKPiAgIAkJCQkgICBjb250ZXh0LCBub3RpZnksIGNhbGxiYWNrLCBuYW1l
KTsKPiAgIAlpZiAoIXZxKSB7Cj4gLQkJdnJpbmdfZnJlZV9xdWV1ZSh2ZGV2LCBxdWV1ZV9zaXpl
X2luX2J5dGVzLCBxdWV1ZSwKPiAtCQkJCSBkbWFfYWRkcik7Cj4gKwkJdnJpbmdfZnJlZV9zcGxp
dCgmdnJpbmdfc3BsaXQsIHZkZXYpOwo+ICAgCQlyZXR1cm4gTlVMTDsKPiAgIAl9Cj4gICAKPiAt
CXRvX3Z2cSh2cSktPnNwbGl0LnF1ZXVlX2RtYV9hZGRyID0gZG1hX2FkZHI7Cj4gLQl0b192dnEo
dnEpLT5zcGxpdC5xdWV1ZV9zaXplX2luX2J5dGVzID0gcXVldWVfc2l6ZV9pbl9ieXRlczsKPiAr
CXRvX3Z2cSh2cSktPnNwbGl0LnF1ZXVlX2RtYV9hZGRyID0gdnJpbmdfc3BsaXQucXVldWVfZG1h
X2FkZHI7Cj4gKwl0b192dnEodnEpLT5zcGxpdC5xdWV1ZV9zaXplX2luX2J5dGVzID0gdnJpbmdf
c3BsaXQucXVldWVfc2l6ZV9pbl9ieXRlczsKPiAgIAl0b192dnEodnEpLT53ZV9vd25fcmluZyA9
IHRydWU7Cj4gICAKPiAgIAlyZXR1cm4gdnE7CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6
YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5k
YXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
