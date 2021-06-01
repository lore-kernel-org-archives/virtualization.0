Return-Path: <SRS0=ZGfu=K3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC1ECC47080
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 08:53:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4CD43610A0
	for <virtualization@archiver.kernel.org>; Tue,  1 Jun 2021 08:53:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4CD43610A0
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 1AC5F4023C;
	Tue,  1 Jun 2021 08:53:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JAyzljbfwgwy; Tue,  1 Jun 2021 08:53:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTP id B8770400C7;
	Tue,  1 Jun 2021 08:53:23 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8F1A3C000D;
	Tue,  1 Jun 2021 08:53:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 78F5AC0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 08:53:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6C0DD4045A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 08:53:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wv4Om1w5F9Eh
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 08:53:21 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 77C6F4044F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  1 Jun 2021 08:53:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622537599;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=5aOcgj4/7/8wJi908yQhoCZVNaJnSsE8zNAKFi7tF3U=;
 b=iQ1pqNhqYP9esawQPF47WkxU1Bbki/hnZ6kD8A3FrTIiAZVHDZKNqS/nvAxYzu9ovQSlS/
 WEWr9lvChgks1+kCl06f3q8He0s1PamTAT/rPhBzXvyG8vZ+aGz/uYqf6QZvemsTl7t4bZ
 d3jeptc3SBIM3xb486e+1i8EPXdY1Ug=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-IRPAzs4kOMqqkmdIqlim3A-1; Tue, 01 Jun 2021 04:53:18 -0400
X-MC-Unique: IRPAzs4kOMqqkmdIqlim3A-1
Received: by mail-pj1-f72.google.com with SMTP id
 k1-20020a17090a7f01b029015d0d4c2107so6595647pjl.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 01 Jun 2021 01:53:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=5aOcgj4/7/8wJi908yQhoCZVNaJnSsE8zNAKFi7tF3U=;
 b=XVYGj8av2a0kOP8LMwBcUlCozhy0oBDLBPlwlV9cV3riFC53ZhzoBQjXxW9aGwFz7i
 5SvHfEUbYP4nyKUh5VlQUAWaRdm8V7v0YKtsAFJ0JRmd3RXraILDrADXRVXm7W0peo6M
 PfWONy0h6iMNmxN1zRQuOvg4K+yTAMrP+PEbGApYe1OPjByyHhF3xWpZJo78hUY5zSIW
 XYBY6MD09reIemr5t9bqefuAfgnUc9+FUemj0/OnL7hfcS6raZIRNeOV2T9ql4ms7s7J
 AkTBQf1T/omM+cxpi7j0QiVUdj4zswppaCc1XZVMongT0BR9jYKCcGJiwzCu5TMdxEc4
 hxBg==
X-Gm-Message-State: AOAM531Ir9ZtiQm7jbunx7zTwGl/Cjd38lQH42BIiIMYW+6AhL9HT0MU
 JBo/EGeyKI+MMjuJtKq2QCNZkD81bcNAWL5/0U+7/QqL8nN/UbwUKXW5pB7Oe2Ly7IvHpaZUU7R
 w5bWz/Vbbhhlm7pYn/RCru3u2SZ2eigpQBTPFh4HYZQ==
X-Received: by 2002:aa7:801a:0:b029:2e0:c3db:15a2 with SMTP id
 j26-20020aa7801a0000b02902e0c3db15a2mr21386815pfi.42.1622537597099; 
 Tue, 01 Jun 2021 01:53:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxYDHHGpH9/a6mLp3/nIDpF5g4JSP7vmJEL9FSrm7dg3eB9KGd67RXSUkJ2HsSU3cvFP8NNPA==
X-Received: by 2002:aa7:801a:0:b029:2e0:c3db:15a2 with SMTP id
 j26-20020aa7801a0000b02902e0c3db15a2mr21386795pfi.42.1622537596866; 
 Tue, 01 Jun 2021 01:53:16 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id k70sm1625715pgd.41.2021.06.01.01.53.14
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 01 Jun 2021 01:53:16 -0700 (PDT)
Subject: Re: [PATCH V3 1/2] vDPA/ifcvf: record virtio notify base
To: Zhu Lingshan <lingshan.zhu@intel.com>, mst@redhat.com
References: <20210601062850.4547-1-lingshan.zhu@intel.com>
 <20210601062850.4547-2-lingshan.zhu@intel.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <63a73aab-964d-344f-d66b-e8e6224af687@redhat.com>
Date: Tue, 1 Jun 2021 16:53:09 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <20210601062850.4547-2-lingshan.zhu@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: netdev@vger.kernel.org, kvm@vger.kernel.org,
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

CtTaIDIwMjEvNi8xIM/CzucyOjI4LCBaaHUgTGluZ3NoYW4g0LS1wDoKPiBUaGlzIGNvbW1pdCBy
ZWNvcmRzIHZpcnRpbyBub3RpZnkgYmFzZSBwaHlzaWNhbCBhZGRyIGFuZAo+IGNhbGN1bGF0ZSBk
b29yYmVsbCBwaHlzaWNhbCBhZGRyZXNzIGZvciB2cXMuCj4KPiBTaWduZWQtb2ZmLWJ5OiBaaHUg
TGluZ3NoYW4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+CgoKQWNrZWQtYnk6IEphc29uIFdhbmcg
PGphc293YW5nQHJlZGhhdC5jb20+CgoKPiAtLS0KPiAgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2
Zl9iYXNlLmMgfCA0ICsrKysKPiAgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmggfCAy
ICsrCj4gICAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQo+Cj4gZGlmZiAtLWdpdCBh
L2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMgYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZj
dmZfYmFzZS5jCj4gaW5kZXggMWE2NjFhYjQ1YWY1Li42ZTE5N2ZlMGZjZjkgMTAwNjQ0Cj4gLS0t
IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX2Jhc2UuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9p
ZmN2Zi9pZmN2Zl9iYXNlLmMKPiBAQCAtMTMzLDYgKzEzMyw4IEBAIGludCBpZmN2Zl9pbml0X2h3
KHN0cnVjdCBpZmN2Zl9odyAqaHcsIHN0cnVjdCBwY2lfZGV2ICpwZGV2KQo+ICAgCQkJCQkgICAg
ICAmaHctPm5vdGlmeV9vZmZfbXVsdGlwbGllcik7Cj4gICAJCQlody0+bm90aWZ5X2JhciA9IGNh
cC5iYXI7Cj4gICAJCQlody0+bm90aWZ5X2Jhc2UgPSBnZXRfY2FwX2FkZHIoaHcsICZjYXApOwo+
ICsJCQlody0+bm90aWZ5X2Jhc2VfcGEgPSBwY2lfcmVzb3VyY2Vfc3RhcnQocGRldiwgY2FwLmJh
cikgKwo+ICsJCQkJCWxlMzJfdG9fY3B1KGNhcC5vZmZzZXQpOwo+ICAgCQkJSUZDVkZfREJHKHBk
ZXYsICJody0+bm90aWZ5X2Jhc2UgPSAlcFxuIiwKPiAgIAkJCQkgIGh3LT5ub3RpZnlfYmFzZSk7
Cj4gICAJCQlicmVhazsKPiBAQCAtMTYxLDYgKzE2Myw4IEBAIGludCBpZmN2Zl9pbml0X2h3KHN0
cnVjdCBpZmN2Zl9odyAqaHcsIHN0cnVjdCBwY2lfZGV2ICpwZGV2KQo+ICAgCQlub3RpZnlfb2Zm
ID0gaWZjX2lvcmVhZDE2KCZody0+Y29tbW9uX2NmZy0+cXVldWVfbm90aWZ5X29mZik7Cj4gICAJ
CWh3LT52cmluZ1tpXS5ub3RpZnlfYWRkciA9IGh3LT5ub3RpZnlfYmFzZSArCj4gICAJCQlub3Rp
Znlfb2ZmICogaHctPm5vdGlmeV9vZmZfbXVsdGlwbGllcjsKPiArCQlody0+dnJpbmdbaV0ubm90
aWZ5X3BhID0gaHctPm5vdGlmeV9iYXNlX3BhICsKPiArCQkJbm90aWZ5X29mZiAqIGh3LT5ub3Rp
Znlfb2ZmX211bHRpcGxpZXI7Cj4gICAJfQo+ICAgCj4gICAJaHctPmxtX2NmZyA9IGh3LT5iYXNl
W0lGQ1ZGX0xNX0JBUl07Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9i
YXNlLmggYi9kcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfYmFzZS5oCj4gaW5kZXggMDExMWJmZGVi
MzQyLi40NDdmNGFkOWMwYmYgMTAwNjQ0Cj4gLS0tIGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3Zm
X2Jhc2UuaAo+ICsrKyBiL2RyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmgKPiBAQCAtNzMs
NiArNzMsNyBAQCBzdHJ1Y3QgdnJpbmdfaW5mbyB7Cj4gICAJdTE2IGxhc3RfYXZhaWxfaWR4Owo+
ICAgCWJvb2wgcmVhZHk7Cj4gICAJdm9pZCBfX2lvbWVtICpub3RpZnlfYWRkcjsKPiArCXBoeXNf
YWRkcl90IG5vdGlmeV9wYTsKPiAgIAl1MzIgaXJxOwo+ICAgCXN0cnVjdCB2ZHBhX2NhbGxiYWNr
IGNiOwo+ICAgCWNoYXIgbXNpeF9uYW1lWzI1Nl07Cj4gQEAgLTg3LDYgKzg4LDcgQEAgc3RydWN0
IGlmY3ZmX2h3IHsKPiAgIAl1OCBub3RpZnlfYmFyOwo+ICAgCS8qIE5vdGlmaWNhaXRvbiBiYXIg
YWRkcmVzcyAqLwo+ICAgCXZvaWQgX19pb21lbSAqbm90aWZ5X2Jhc2U7Cj4gKwlwaHlzX2FkZHJf
dCBub3RpZnlfYmFzZV9wYTsKPiAgIAl1MzIgbm90aWZ5X29mZl9tdWx0aXBsaWVyOwo+ICAgCXU2
NCByZXFfZmVhdHVyZXM7Cj4gICAJdTY0IGh3X2ZlYXR1cmVzOwoKX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0
ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMu
bGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
