Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46ADFC433EF
	for <virtualization@archiver.kernel.org>; Mon, 28 Feb 2022 03:59:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id C37A3819D2;
	Mon, 28 Feb 2022 03:59:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MTh0m1Qchvml; Mon, 28 Feb 2022 03:59:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 47FB38198D;
	Mon, 28 Feb 2022 03:59:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 024E5C0033;
	Mon, 28 Feb 2022 03:59:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EF048C001A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 03:59:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id C7FBB40895
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 03:59:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hC-S58EaFacw
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 03:59:51 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B4F4940891
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Feb 2022 03:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1646020790;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=R/jZhvLabLMT1rZ80L7AA+Rt0fod5ZDmGFxBBMRWJZ0=;
 b=Q0OaArmS+Y4JvXJOKlYgL9tPhVVgAjZ6O36/nZg1spMJXvT1BNLit/Kfi9JsGCzKGuf/3w
 3jBCcZiyYtZTjg7M7ir2Uw1fcEAiXYx9QWs/5KZPq2AAiEbDL8u/lZvRJDOeCj97slU+5r
 iZqUwJlUNON4pjKP5+ZcATsMuWO5WUE=
Received: from mail-pf1-f197.google.com (mail-pf1-f197.google.com
 [209.85.210.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-222-MndaWt1IPSuAC6hnDwxTZA-1; Sun, 27 Feb 2022 22:59:49 -0500
X-MC-Unique: MndaWt1IPSuAC6hnDwxTZA-1
Received: by mail-pf1-f197.google.com with SMTP id
 x19-20020aa79573000000b004e193fae5a1so7030020pfq.19
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Feb 2022 19:59:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=R/jZhvLabLMT1rZ80L7AA+Rt0fod5ZDmGFxBBMRWJZ0=;
 b=AdWvTspoP+Rgr1+Ap9NzBIAHUpdMpm0o3s6Q0kixGU3CIzP9hL35/rL/zNMXmf+UCU
 lUbBu54w42KlzyS5bajQLT5inQpbTqO1MiwetR7vbzCQZs8f1W+Kqhvtpma8df89aUet
 bWXxS6WgFgAtFMzwSN/gP6QKVZszz5UXCo2kzW25PLEwsralFsFLY8VDjDsNT0oAPFJi
 zykJN8RFVa/ExEhpqVrdho3QY8VYmc4YR+RGBQcMDYnMGr2D03s5LgmG4lBU3Q1HtFRR
 R9HPzTNh1jbnemAOC+QC0nHA7rXnuIYPhVQRoj/u3KqAhid2f8oYjfaOk5qNlyzUIRnV
 j0Og==
X-Gm-Message-State: AOAM530CMwmRgjBxL8Kc4n2cs95v7hXbNcC9f55OATKEKvBfqZ9c2XF+
 YxYr6q1+bO334P1uhKw0cDatH/vfhSJT6NUbU74QMd8JJoMgwQK4s4vTCs8ddO/3Z5cNZ43Nvuh
 ePx6jh4JKIRLvdGef6nXO9BkRbJDRd6SHHMOZGHLWLg==
X-Received: by 2002:a17:902:cccc:b0:14e:e89c:c669 with SMTP id
 z12-20020a170902cccc00b0014ee89cc669mr18733737ple.58.1646020788258; 
 Sun, 27 Feb 2022 19:59:48 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxq0j23zg7yiWAAMMy1CXQ5lLLH79PSc02YMLOpfWDbUUog7gxdhyGKoRJVWp8QzaFFPWOqfA==
X-Received: by 2002:a17:902:cccc:b0:14e:e89c:c669 with SMTP id
 z12-20020a170902cccc00b0014ee89cc669mr18733698ple.58.1646020787931; 
 Sun, 27 Feb 2022 19:59:47 -0800 (PST)
Received: from [10.72.13.215] ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id
 g1-20020a056a000b8100b004f111c21535sm11625722pfj.80.2022.02.27.19.59.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 27 Feb 2022 19:59:47 -0800 (PST)
Message-ID: <2457e208-0898-0dee-39c5-551fe2acb0fd@redhat.com>
Date: Mon, 28 Feb 2022 11:59:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [PATCH v2 06/14] vdpa: adapt vhost_ops callbacks to svq
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20220227134111.3254066-1-eperezma@redhat.com>
 <20220227134111.3254066-7-eperezma@redhat.com>
From: Jason Wang <jasowang@redhat.com>
In-Reply-To: <20220227134111.3254066-7-eperezma@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: "Michael S. Tsirkin" <mst@redhat.com>,
 virtualization@lists.linux-foundation.org, Eli Cohen <eli@mellanox.com>,
 Eric Blake <eblake@redhat.com>, Parav Pandit <parav@mellanox.com>,
 Cindy Lu <lulu@redhat.com>, "Fangyi \(Eric\)" <eric.fangyi@huawei.com>,
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

CuWcqCAyMDIyLzIvMjcg5LiL5Y2IOTo0MSwgRXVnZW5pbyBQw6lyZXog5YaZ6YGTOgo+IEZpcnN0
IGhhbGYgb2YgdGhlIGJ1ZmZlcnMgZm9yd2FyZGluZyBwYXJ0LCBwcmVwYXJpbmcgdmhvc3QtdmRw
YQo+IGNhbGxiYWNrcyB0byBTVlEgdG8gb2ZmZXIgaXQuIFFFTVUgY2Fubm90IGVuYWJsZSBpdCBh
dCB0aGlzIG1vbWVudCwgc28KPiB0aGlzIGlzIGVmZmVjdGl2ZWx5IGRlYWQgY29kZSBhdCB0aGUg
bW9tZW50LCBidXQgaXQgaGVscHMgdG8gcmVkdWNlCj4gcGF0Y2ggc2l6ZS4KPgo+IFNpZ25lZC1v
ZmYtYnk6IEV1Z2VuaW8gUMOpcmV6IDxlcGVyZXptYUByZWRoYXQuY29tPgo+IC0tLQo+ICAgaHcv
dmlydGlvL3Zob3N0LXZkcGEuYyB8IDg0ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKy0tLS0tLQo+ICAgMSBmaWxlIGNoYW5nZWQsIDczIGluc2VydGlvbnMoKyksIDExIGRlbGV0
aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2h3L3ZpcnRpby92aG9zdC12ZHBhLmMgYi9ody92aXJ0
aW8vdmhvc3QtdmRwYS5jCj4gaW5kZXggZDYxNGM0MzVmMy4uYjJjNGU5MmZjZiAxMDA2NDQKPiAt
LS0gYS9ody92aXJ0aW8vdmhvc3QtdmRwYS5jCj4gKysrIGIvaHcvdmlydGlvL3Zob3N0LXZkcGEu
Ywo+IEBAIC0zNDQsNiArMzQ0LDE2IEBAIHN0YXRpYyBib29sIHZob3N0X3ZkcGFfb25lX3RpbWVf
cmVxdWVzdChzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYpCj4gICAgICAgcmV0dXJuIHYtPmluZGV4ICE9
IDA7Cj4gICB9Cj4gICAKPiArc3RhdGljIGludCB2aG9zdF92ZHBhX2dldF9kZXZfZmVhdHVyZXMo
c3RydWN0IHZob3N0X2RldiAqZGV2LAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICB1aW50NjRfdCAqZmVhdHVyZXMpCj4gK3sKPiArICAgIGludCByZXQ7Cj4gKwo+ICsg
ICAgcmV0ID0gdmhvc3RfdmRwYV9jYWxsKGRldiwgVkhPU1RfR0VUX0ZFQVRVUkVTLCBmZWF0dXJl
cyk7Cj4gKyAgICB0cmFjZV92aG9zdF92ZHBhX2dldF9mZWF0dXJlcyhkZXYsICpmZWF0dXJlcyk7
Cj4gKyAgICByZXR1cm4gcmV0Owo+ICt9Cj4gKwo+ICAgc3RhdGljIGludCB2aG9zdF92ZHBhX2lu
aXRfc3ZxKHN0cnVjdCB2aG9zdF9kZXYgKmhkZXYsIHN0cnVjdCB2aG9zdF92ZHBhICp2LAo+ICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVycm9yICoqZXJycCkKPiAgIHsKPiBAQCAt
MzU2LDcgKzM2Niw3IEBAIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9pbml0X3N2cShzdHJ1Y3Qgdmhv
c3RfZGV2ICpoZGV2LCBzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPiAgICAgICAgICAgcmV0dXJuIDA7
Cj4gICAgICAgfQo+ICAgCj4gLSAgICByID0gaGRldi0+dmhvc3Rfb3BzLT52aG9zdF9nZXRfZmVh
dHVyZXMoaGRldiwgJmRldl9mZWF0dXJlcyk7Cj4gKyAgICByID0gdmhvc3RfdmRwYV9nZXRfZGV2
X2ZlYXR1cmVzKGhkZXYsICZkZXZfZmVhdHVyZXMpOwo+ICAgICAgIGlmIChyICE9IDApIHsKPiAg
ICAgICAgICAgZXJyb3Jfc2V0Z19lcnJubyhlcnJwLCAtciwgIkNhbid0IGdldCB2ZHBhIGRldmlj
ZSBmZWF0dXJlcyIpOwo+ICAgICAgICAgICByZXR1cm4gcjsKPiBAQCAtNTgzLDEyICs1OTMsMjYg
QEAgc3RhdGljIGludCB2aG9zdF92ZHBhX3NldF9tZW1fdGFibGUoc3RydWN0IHZob3N0X2RldiAq
ZGV2LAo+ICAgc3RhdGljIGludCB2aG9zdF92ZHBhX3NldF9mZWF0dXJlcyhzdHJ1Y3Qgdmhvc3Rf
ZGV2ICpkZXYsCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHVpbnQ2NF90
IGZlYXR1cmVzKQo+ICAgewo+ICsgICAgc3RydWN0IHZob3N0X3ZkcGEgKnYgPSBkZXYtPm9wYXF1
ZTsKPiAgICAgICBpbnQgcmV0Owo+ICAgCj4gICAgICAgaWYgKHZob3N0X3ZkcGFfb25lX3RpbWVf
cmVxdWVzdChkZXYpKSB7Cj4gICAgICAgICAgIHJldHVybiAwOwo+ICAgICAgIH0KPiAgIAo+ICsg
ICAgaWYgKHYtPnNoYWRvd192cXNfZW5hYmxlZCkgewo+ICsgICAgICAgIHVpbnQ2NF90IGZlYXR1
cmVzX29rID0gZmVhdHVyZXM7Cj4gKyAgICAgICAgYm9vbCBvazsKPiArCj4gKyAgICAgICAgb2sg
PSB2aG9zdF9zdnFfdmFsaWRfZmVhdHVyZXMoJmZlYXR1cmVzX29rKTsKPiArICAgICAgICBpZiAo
dW5saWtlbHkoIW9rKSkgewo+ICsgICAgICAgICAgICBlcnJvcl9yZXBvcnQoCj4gKyAgICAgICAg
ICAgICAgICAiSW52YWxpZCBndWVzdCBhY2tlZCBmZWF0dXJlIGZsYWcsIGFja2VkOiAweCUiCj4g
KyAgICAgICAgICAgICAgICBQUkl4NjQiLCBvazogMHglIlBSSXg2NCwgZmVhdHVyZXMsIGZlYXR1
cmVzX29rKTsKPiArICAgICAgICAgICAgcmV0dXJuIC1FSU5WQUw7Cj4gKyAgICAgICAgfQo+ICsg
ICAgfQo+ICsKPiAgICAgICB0cmFjZV92aG9zdF92ZHBhX3NldF9mZWF0dXJlcyhkZXYsIGZlYXR1
cmVzKTsKPiAgICAgICByZXQgPSB2aG9zdF92ZHBhX2NhbGwoZGV2LCBWSE9TVF9TRVRfRkVBVFVS
RVMsICZmZWF0dXJlcyk7Cj4gICAgICAgaWYgKHJldCkgewo+IEBAIC03MzUsNiArNzU5LDEzIEBA
IHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9nZXRfY29uZmlnKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwg
dWludDhfdCAqY29uZmlnLAo+ICAgICAgIHJldHVybiByZXQ7Cj4gICAgfQo+ICAgCj4gK3N0YXRp
YyBpbnQgdmhvc3RfdmRwYV9zZXRfZGV2X3ZyaW5nX2Jhc2Uoc3RydWN0IHZob3N0X2RldiAqZGV2
LAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aG9z
dF92cmluZ19zdGF0ZSAqcmluZykKPiArewo+ICsgICAgdHJhY2Vfdmhvc3RfdmRwYV9zZXRfdnJp
bmdfYmFzZShkZXYsIHJpbmctPmluZGV4LCByaW5nLT5udW0pOwo+ICsgICAgcmV0dXJuIHZob3N0
X3ZkcGFfY2FsbChkZXYsIFZIT1NUX1NFVF9WUklOR19CQVNFLCByaW5nKTsKPiArfQo+ICsKPiAg
IHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9zZXRfdnJpbmdfZGV2X2tpY2soc3RydWN0IHZob3N0X2Rl
diAqZGV2LAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1
Y3Qgdmhvc3RfdnJpbmdfZmlsZSAqZmlsZSkKPiAgIHsKPiBAQCAtNzQ5LDYgKzc4MCwxOCBAQCBz
dGF0aWMgaW50IHZob3N0X3ZkcGFfc2V0X3ZyaW5nX2Rldl9jYWxsKHN0cnVjdCB2aG9zdF9kZXYg
KmRldiwKPiAgICAgICByZXR1cm4gdmhvc3RfdmRwYV9jYWxsKGRldiwgVkhPU1RfU0VUX1ZSSU5H
X0NBTEwsIGZpbGUpOwo+ICAgfQo+ICAgCj4gK3N0YXRpYyBpbnQgdmhvc3RfdmRwYV9zZXRfdnJp
bmdfZGV2X2FkZHIoc3RydWN0IHZob3N0X2RldiAqZGV2LAo+ICsgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHN0cnVjdCB2aG9zdF92cmluZ19hZGRyICphZGRyKQo+ICt7
Cj4gKyAgICB0cmFjZV92aG9zdF92ZHBhX3NldF92cmluZ19hZGRyKGRldiwgYWRkci0+aW5kZXgs
IGFkZHItPmZsYWdzLAo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFkZHItPmRl
c2NfdXNlcl9hZGRyLCBhZGRyLT51c2VkX3VzZXJfYWRkciwKPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBhZGRyLT5hdmFpbF91c2VyX2FkZHIsCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgYWRkci0+bG9nX2d1ZXN0X2FkZHIpOwo+ICsKPiArICAgIHJldHVybiB2
aG9zdF92ZHBhX2NhbGwoZGV2LCBWSE9TVF9TRVRfVlJJTkdfQUREUiwgYWRkcik7Cj4gKwo+ICt9
Cj4gKwo+ICAgLyoqCj4gICAgKiBTZXQgdGhlIHNoYWRvdyB2aXJ0cXVldWUgZGVzY3JpcHRvcnMg
dG8gdGhlIGRldmljZQo+ICAgICoKPiBAQCAtODU5LDExICs5MDIsMTcgQEAgc3RhdGljIGludCB2
aG9zdF92ZHBhX3NldF9sb2dfYmFzZShzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsIHVpbnQ2NF90IGJh
c2UsCj4gICBzdGF0aWMgaW50IHZob3N0X3ZkcGFfc2V0X3ZyaW5nX2FkZHIoc3RydWN0IHZob3N0
X2RldiAqZGV2LAo+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc3Ry
dWN0IHZob3N0X3ZyaW5nX2FkZHIgKmFkZHIpCj4gICB7Cj4gLSAgICB0cmFjZV92aG9zdF92ZHBh
X3NldF92cmluZ19hZGRyKGRldiwgYWRkci0+aW5kZXgsIGFkZHItPmZsYWdzLAo+IC0gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICBhZGRyLT5kZXNjX3VzZXJfYWRkciwgYWRkci0+
dXNlZF91c2VyX2FkZHIsCj4gLSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGFk
ZHItPmF2YWlsX3VzZXJfYWRkciwKPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgYWRkci0+bG9nX2d1ZXN0X2FkZHIpOwo+IC0gICAgcmV0dXJuIHZob3N0X3ZkcGFfY2FsbChk
ZXYsIFZIT1NUX1NFVF9WUklOR19BRERSLCBhZGRyKTsKPiArICAgIHN0cnVjdCB2aG9zdF92ZHBh
ICp2ID0gZGV2LT5vcGFxdWU7Cj4gKwo+ICsgICAgaWYgKHYtPnNoYWRvd192cXNfZW5hYmxlZCkg
ewo+ICsgICAgICAgIC8qCj4gKyAgICAgICAgICogRGV2aWNlIHZyaW5nIGFkZHIgd2FzIHNldCBh
dCBkZXZpY2Ugc3RhcnQuIFNWUSBiYXNlIGlzIGhhbmRsZWQgYnkKPiArICAgICAgICAgKiBWaXJ0
UXVldWUgY29kZS4KPiArICAgICAgICAgKi8KPiArICAgICAgICByZXR1cm4gMDsKPiArICAgIH0K
PiArCj4gKyAgICByZXR1cm4gdmhvc3RfdmRwYV9zZXRfdnJpbmdfZGV2X2FkZHIoZGV2LCBhZGRy
KTsKPiAgIH0KPiAgIAo+ICAgc3RhdGljIGludCB2aG9zdF92ZHBhX3NldF92cmluZ19udW0oc3Ry
dWN0IHZob3N0X2RldiAqZGV2LAo+IEBAIC04NzYsOCArOTI1LDE3IEBAIHN0YXRpYyBpbnQgdmhv
c3RfdmRwYV9zZXRfdnJpbmdfbnVtKHN0cnVjdCB2aG9zdF9kZXYgKmRldiwKPiAgIHN0YXRpYyBp
bnQgdmhvc3RfdmRwYV9zZXRfdnJpbmdfYmFzZShzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYsCj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qgdmhvc3RfdnJpbmdf
c3RhdGUgKnJpbmcpCj4gICB7Cj4gLSAgICB0cmFjZV92aG9zdF92ZHBhX3NldF92cmluZ19iYXNl
KGRldiwgcmluZy0+aW5kZXgsIHJpbmctPm51bSk7Cj4gLSAgICByZXR1cm4gdmhvc3RfdmRwYV9j
YWxsKGRldiwgVkhPU1RfU0VUX1ZSSU5HX0JBU0UsIHJpbmcpOwo+ICsgICAgc3RydWN0IHZob3N0
X3ZkcGEgKnYgPSBkZXYtPm9wYXF1ZTsKPiArCj4gKyAgICBpZiAodi0+c2hhZG93X3Zxc19lbmFi
bGVkKSB7Cj4gKyAgICAgICAgLyoKPiArICAgICAgICAgKiBEZXZpY2UgdnJpbmcgYmFzZSB3YXMg
c2V0IGF0IGRldmljZSBzdGFydC4gU1ZRIGJhc2UgaXMgaGFuZGxlZCBieQo+ICsgICAgICAgICAq
IFZpcnRRdWV1ZSBjb2RlLgo+ICsgICAgICAgICAqLwo+ICsgICAgICAgIHJldHVybiAwOwo+ICsg
ICAgfQo+ICsKPiArICAgIHJldHVybiB2aG9zdF92ZHBhX3NldF9kZXZfdnJpbmdfYmFzZShkZXYs
IHJpbmcpOwo+ICAgfQo+ICAgCj4gICBzdGF0aWMgaW50IHZob3N0X3ZkcGFfZ2V0X3ZyaW5nX2Jh
c2Uoc3RydWN0IHZob3N0X2RldiAqZGV2LAo+IEBAIC05MjQsMTAgKzk4MiwxNCBAQCBzdGF0aWMg
aW50IHZob3N0X3ZkcGFfc2V0X3ZyaW5nX2NhbGwoc3RydWN0IHZob3N0X2RldiAqZGV2LAo+ICAg
c3RhdGljIGludCB2aG9zdF92ZHBhX2dldF9mZWF0dXJlcyhzdHJ1Y3Qgdmhvc3RfZGV2ICpkZXYs
Cj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdWludDY0X3QgKmZlYXR1
cmVzKQo+ICAgewo+IC0gICAgaW50IHJldDsKPiArICAgIHN0cnVjdCB2aG9zdF92ZHBhICp2ID0g
ZGV2LT5vcGFxdWU7Cj4gKyAgICBpbnQgcmV0ID0gdmhvc3RfdmRwYV9nZXRfZGV2X2ZlYXR1cmVz
KGRldiwgZmVhdHVyZXMpOwo+ICsKPiArICAgIGlmIChyZXQgPT0gMCAmJiB2LT5zaGFkb3dfdnFz
X2VuYWJsZWQpIHsKPiArICAgICAgICAvKiBGaWx0ZXIgb25seSBmZWF0dXJlcyB0aGF0IFNWUSBj
YW4gb2ZmZXIgdG8gZ3Vlc3QgKi8KPiArICAgICAgICB2aG9zdF9zdnFfdmFsaWRfZmVhdHVyZXMo
ZmVhdHVyZXMpOwoKCkkgdGhpbmsgaXQncyBiZXR0ZXIgbm90IHNpbGVudGx5IGNsZWFyIGZlYXR1
cmVzIGhlcmUgKGUuZyB0aGUgZmVhdHVyZSAKY291bGQgYmUgZXhwbGljaXRseSBlbmFibGVkIHZp
YSBjbGkpLiBUaGlzIG1heSBnaXZlIG1vcmUgdHJvdWJsZXMgaW4gdGhlIApmdXR1cmUgY3Jvc3Mg
dmVuZG9yL2JhY2tlbmQgbGl2ZSBtaWdyYXRpb24uCgpXZSBjYW4gc2ltcGxlIGR1cmluZyB2aG9z
dF92ZHBhIGluaXQuCgpUaGFua3MKCgo+ICsgICAgfQo+ICAgCj4gLSAgICByZXQgPSB2aG9zdF92
ZHBhX2NhbGwoZGV2LCBWSE9TVF9HRVRfRkVBVFVSRVMsIGZlYXR1cmVzKTsKPiAtICAgIHRyYWNl
X3Zob3N0X3ZkcGFfZ2V0X2ZlYXR1cmVzKGRldiwgKmZlYXR1cmVzKTsKPiAgICAgICByZXR1cm4g
cmV0Owo+ICAgfQo+ICAgCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
