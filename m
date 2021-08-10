Return-Path: <SRS0=EG+p=NB=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27591C4338F
	for <virtualization@archiver.kernel.org>; Tue, 10 Aug 2021 03:05:47 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C34FA60F6F
	for <virtualization@archiver.kernel.org>; Tue, 10 Aug 2021 03:05:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C34FA60F6F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5C25D400F8;
	Tue, 10 Aug 2021 03:05:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id PMZoncUr7wU1; Tue, 10 Aug 2021 03:05:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id F1F414015B;
	Tue, 10 Aug 2021 03:05:41 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CBB66C0010;
	Tue, 10 Aug 2021 03:05:40 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 66EE8C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 03:05:39 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 4E3634015B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 03:05:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id czBWriQ3Ez_T
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 03:05:38 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 507ED400F8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Aug 2021 03:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628564737;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FNAD9HvPLL20RnA7Fm9EynMKwbGxKPvS4YW5JmvO4X8=;
 b=NJwoJuQHXNgyHVTyjFjrh533ryl6GkIXLIONu/IQZAbSvI0HN4AHuVjWunckXr/fe30XRQ
 90AiYfeFrG2YJL2Vu7y5+LGtKTMUC+EAxYaZOPO8k88BQ+h6WUePics6jcAxHWw7dcXj0t
 sqFicMJuzHSykX8og63SwvcqOpDpFu0=
Received: from mail-pl1-f199.google.com (mail-pl1-f199.google.com
 [209.85.214.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-146-PCafwgixMdm0d6HZQD_f2Q-1; Mon, 09 Aug 2021 23:05:35 -0400
X-MC-Unique: PCafwgixMdm0d6HZQD_f2Q-1
Received: by mail-pl1-f199.google.com with SMTP id
 g12-20020a1709026b4cb029012c0d2e483cso1132731plt.5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Aug 2021 20:05:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=FNAD9HvPLL20RnA7Fm9EynMKwbGxKPvS4YW5JmvO4X8=;
 b=EQMNQKuq/dV61DGp7sNLrerjSwWbP6It5WE8wXnRp1lcP3YdeBTKGi6pYgjBuCDj3O
 lKiYlWb3Te1q/EulCKI9KQrDpikxMgoYVPAHq8qfyc2QFwQxzRblueQxAMkQwRpqxjsr
 f5gT7YN8ki70IGASWwXdMSABZNgQ+qzS8RWqDlsQnP1vjDs9+tZz0Ln87XXb8IPR9EwN
 ghJLWgwFu3BbiFwFT8DE+P5c3Z6eHMRXxN5Nn627vpVMfrRrbSxlDS7PLCyjEGyDiLR4
 vScakvSrW9dcPhQzUD9ou6lfb8jwcuEvXUyfaA1KTbBKx3dS9ygVi9YoFRq/r35fg+in
 DSsA==
X-Gm-Message-State: AOAM532QkrFSS9DkWX+v40nzqP4CtI9ondpdcdi8qd3AtKuGO+VhxIrF
 m7QI40aVEvRaTUwQxTom7KUlCWQDS3RozK5OrlasUI3U3C70K+3bENCdULxDR5nZZzCi4G1D6w2
 O/54qIuMtROHDp2bd0V1QVUi7/CytRBSAbrgHwM78bw==
X-Received: by 2002:a63:2585:: with SMTP id l127mr303527pgl.318.1628564734415; 
 Mon, 09 Aug 2021 20:05:34 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyXfNDEqGz8UY7V4AUjb+V6s581Q/QII16jDbubwX4LuBoC0RVi6HBrqCF4aijatpedgi9vtg==
X-Received: by 2002:a63:2585:: with SMTP id l127mr303496pgl.318.1628564734150; 
 Mon, 09 Aug 2021 20:05:34 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id s5sm16264880pji.56.2021.08.09.20.05.31
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 09 Aug 2021 20:05:33 -0700 (PDT)
Subject: Re: [PATCH v5] virtio-blk: Add validation for block size in config
 space
To: Xie Yongji <xieyongji@bytedance.com>, mst@redhat.com, stefanha@redhat.com
References: <20210809101609.148-1-xieyongji@bytedance.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <08366773-76b5-be73-7e32-d9ce6f6799bf@redhat.com>
Date: Tue, 10 Aug 2021 11:05:29 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210809101609.148-1-xieyongji@bytedance.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="gbk"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

CtTaIDIwMjEvOC85IM/Czuc2OjE2LCBYaWUgWW9uZ2ppINC0tcA6Cj4gQW4gdW50cnVzdGVkIGRl
dmljZSBtaWdodCBwcmVzZW50cyBhbiBpbnZhbGlkIGJsb2NrIHNpemUKPiBpbiBjb25maWd1cmF0
aW9uIHNwYWNlLiBUaGlzIHRyaWVzIHRvIGFkZCB2YWxpZGF0aW9uIGZvciBpdAo+IGluIHRoZSB2
YWxpZGF0ZSBjYWxsYmFjayBhbmQgY2xlYXIgdGhlIFZJUlRJT19CTEtfRl9CTEtfU0laRQo+IGZl
YXR1cmUgYml0IGlmIHRoZSB2YWx1ZSBpcyBvdXQgb2YgdGhlIHN1cHBvcnRlZCByYW5nZS4KPgo+
IEFuZCB3ZSBhbHNvIGRvdWJsZSBjaGVjayB0aGUgdmFsdWUgaW4gdmlydGJsa19wcm9iZSgpIGlu
Cj4gY2FzZSB0aGF0IGl0J3MgY2hhbmdlZCBhZnRlciB0aGUgdmFsaWRhdGlvbi4KPgo+IFNpZ25l
ZC1vZmYtYnk6IFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgo+IC0tLQo+ICAg
ZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMgfCAzOSArKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKystLS0tLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAzMyBpbnNlcnRpb25zKCspLCA2IGRl
bGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvYmxvY2svdmlydGlvX2Jsay5jIGIv
ZHJpdmVycy9ibG9jay92aXJ0aW9fYmxrLmMKPiBpbmRleCA0YjQ5ZGYyZGZkMjMuLmFmYjM3YWFj
MDllOCAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2Jsb2NrL3ZpcnRpb19ibGsuYwo+ICsrKyBiL2Ry
aXZlcnMvYmxvY2svdmlydGlvX2Jsay5jCj4gQEAgLTY5Miw2ICs2OTIsMjggQEAgc3RhdGljIGNv
bnN0IHN0cnVjdCBibGtfbXFfb3BzIHZpcnRpb19tcV9vcHMgPSB7Cj4gICBzdGF0aWMgdW5zaWdu
ZWQgaW50IHZpcnRibGtfcXVldWVfZGVwdGg7Cj4gICBtb2R1bGVfcGFyYW1fbmFtZWQocXVldWVf
ZGVwdGgsIHZpcnRibGtfcXVldWVfZGVwdGgsIHVpbnQsIDA0NDQpOwo+ICAgCj4gK3N0YXRpYyBp
bnQgdmlydGJsa192YWxpZGF0ZShzdHJ1Y3QgdmlydGlvX2RldmljZSAqdmRldikKPiArewo+ICsJ
dTMyIGJsa19zaXplOwo+ICsKPiArCWlmICghdmRldi0+Y29uZmlnLT5nZXQpIHsKPiArCQlkZXZf
ZXJyKCZ2ZGV2LT5kZXYsICIlcyBmYWlsdXJlOiBjb25maWcgYWNjZXNzIGRpc2FibGVkXG4iLAo+
ICsJCQlfX2Z1bmNfXyk7Cj4gKwkJcmV0dXJuIC1FSU5WQUw7Cj4gKwl9Cj4gKwo+ICsJaWYgKCF2
aXJ0aW9faGFzX2ZlYXR1cmUodmRldiwgVklSVElPX0JMS19GX0JMS19TSVpFKSkKPiArCQlyZXR1
cm4gMDsKPiArCj4gKwlibGtfc2l6ZSA9IHZpcnRpb19jcmVhZDMyKHZkZXYsCj4gKwkJCW9mZnNl
dG9mKHN0cnVjdCB2aXJ0aW9fYmxrX2NvbmZpZywgYmxrX3NpemUpKTsKPiArCj4gKwlpZiAoYmxr
X3NpemUgPCBTRUNUT1JfU0laRSB8fCBibGtfc2l6ZSA+IFBBR0VfU0laRSkKPiArCQlfX3ZpcnRp
b19jbGVhcl9iaXQodmRldiwgVklSVElPX0JMS19GX0JMS19TSVpFKTsKCgpJIHdvbmRlciBpZiBp
dCdzIGJldHRlciB0byBqdXN0IGZhaWwgaGVyZSBhcyB3aGF0IHdlIGRpZCBmb3IgcHJvYmUoKS4K
ClRoYW5rcwoKCj4gKwo+ICsJcmV0dXJuIDA7Cj4gK30KPiArCj4gICBzdGF0aWMgaW50IHZpcnRi
bGtfcHJvYmUoc3RydWN0IHZpcnRpb19kZXZpY2UgKnZkZXYpCj4gICB7Cj4gICAJc3RydWN0IHZp
cnRpb19ibGsgKnZibGs7Cj4gQEAgLTcwMywxMiArNzI1LDYgQEAgc3RhdGljIGludCB2aXJ0Ymxr
X3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+ICAgCXU4IHBoeXNpY2FsX2Jsb2Nr
X2V4cCwgYWxpZ25tZW50X29mZnNldDsKPiAgIAl1bnNpZ25lZCBpbnQgcXVldWVfZGVwdGg7Cj4g
ICAKPiAtCWlmICghdmRldi0+Y29uZmlnLT5nZXQpIHsKPiAtCQlkZXZfZXJyKCZ2ZGV2LT5kZXYs
ICIlcyBmYWlsdXJlOiBjb25maWcgYWNjZXNzIGRpc2FibGVkXG4iLAo+IC0JCQlfX2Z1bmNfXyk7
Cj4gLQkJcmV0dXJuIC1FSU5WQUw7Cj4gLQl9Cj4gLQo+ICAgCWVyciA9IGlkYV9zaW1wbGVfZ2V0
KCZ2ZF9pbmRleF9pZGEsIDAsIG1pbm9yX3RvX2luZGV4KDEgPDwgTUlOT1JCSVRTKSwKPiAgIAkJ
CSAgICAgR0ZQX0tFUk5FTCk7Cj4gICAJaWYgKGVyciA8IDApCj4gQEAgLTgyMyw2ICs4MzksMTQg
QEAgc3RhdGljIGludCB2aXJ0YmxrX3Byb2JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICp2ZGV2KQo+
ICAgCWVsc2UKPiAgIAkJYmxrX3NpemUgPSBxdWV1ZV9sb2dpY2FsX2Jsb2NrX3NpemUocSk7Cj4g
ICAKPiArCWlmICh1bmxpa2VseShibGtfc2l6ZSA8IFNFQ1RPUl9TSVpFIHx8IGJsa19zaXplID4g
UEFHRV9TSVpFKSkgewo+ICsJCWRldl9lcnIoJnZkZXYtPmRldiwKPiArCQkJImJsb2NrIHNpemUg
aXMgY2hhbmdlZCB1bmV4cGVjdGVkbHksIG5vdyBpcyAldVxuIiwKPiArCQkJYmxrX3NpemUpOwo+
ICsJCWVyciA9IC1FSU5WQUw7Cj4gKwkJZ290byBlcnJfY2xlYW51cF9kaXNrOwo+ICsJfQo+ICsK
PiAgIAkvKiBVc2UgdG9wb2xvZ3kgaW5mb3JtYXRpb24gaWYgYXZhaWxhYmxlICovCj4gICAJZXJy
ID0gdmlydGlvX2NyZWFkX2ZlYXR1cmUodmRldiwgVklSVElPX0JMS19GX1RPUE9MT0dZLAo+ICAg
CQkJCSAgIHN0cnVjdCB2aXJ0aW9fYmxrX2NvbmZpZywgcGh5c2ljYWxfYmxvY2tfZXhwLAo+IEBA
IC04ODEsNiArOTA1LDggQEAgc3RhdGljIGludCB2aXJ0YmxrX3Byb2JlKHN0cnVjdCB2aXJ0aW9f
ZGV2aWNlICp2ZGV2KQo+ICAgCWRldmljZV9hZGRfZGlzaygmdmRldi0+ZGV2LCB2YmxrLT5kaXNr
LCB2aXJ0YmxrX2F0dHJfZ3JvdXBzKTsKPiAgIAlyZXR1cm4gMDsKPiAgIAo+ICtlcnJfY2xlYW51
cF9kaXNrOgo+ICsJYmxrX2NsZWFudXBfZGlzayh2YmxrLT5kaXNrKTsKPiAgIG91dF9mcmVlX3Rh
Z3M6Cj4gICAJYmxrX21xX2ZyZWVfdGFnX3NldCgmdmJsay0+dGFnX3NldCk7Cj4gICBvdXRfZnJl
ZV92cToKPiBAQCAtOTgzLDYgKzEwMDksNyBAQCBzdGF0aWMgc3RydWN0IHZpcnRpb19kcml2ZXIg
dmlydGlvX2JsayA9IHsKPiAgIAkuZHJpdmVyLm5hbWUJCQk9IEtCVUlMRF9NT0ROQU1FLAo+ICAg
CS5kcml2ZXIub3duZXIJCQk9IFRISVNfTU9EVUxFLAo+ICAgCS5pZF90YWJsZQkJCT0gaWRfdGFi
bGUsCj4gKwkudmFsaWRhdGUJCQk9IHZpcnRibGtfdmFsaWRhdGUsCj4gICAJLnByb2JlCQkJCT0g
dmlydGJsa19wcm9iZSwKPiAgIAkucmVtb3ZlCQkJCT0gdmlydGJsa19yZW1vdmUsCj4gICAJLmNv
bmZpZ19jaGFuZ2VkCQkJPSB2aXJ0YmxrX2NvbmZpZ19jaGFuZ2VkLAoKX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBs
aXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlz
dHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
