Return-Path: <SRS0=pd2K=EP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60806C4741F
	for <virtualization@archiver.kernel.org>; Mon,  9 Nov 2020 22:43:10 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97D8A206B6
	for <virtualization@archiver.kernel.org>; Mon,  9 Nov 2020 22:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Rtey7dYY"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97D8A206B6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 1EAAE86B23;
	Mon,  9 Nov 2020 22:43:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id DrCSyxGAnyqo; Mon,  9 Nov 2020 22:43:08 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 585EF86B18;
	Mon,  9 Nov 2020 22:43:08 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 42EB3C088B;
	Mon,  9 Nov 2020 22:43:08 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F2B81C016F
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 22:43:06 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DD60187428
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 22:43:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QovbFUBqHAqf
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 22:43:06 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id DD59887427
 for <virtualization@lists.linux-foundation.org>;
 Mon,  9 Nov 2020 22:43:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604961784;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fg7zSSuXfHaOdrJzE6K3KV6fZlH5LajqxqmYKp+iv8o=;
 b=Rtey7dYYYt1UaBqbmISTOKLz1jU12t5bmWUHhTP5wYgVqouL8J3W72j9qO2GwdKX8E/5w6
 OmEn13YLsNP23IS86Q2GkKlvKcOzoF9AVtRq4anZJtALGQu3N43rxAYpGyJMINyMi95GUJ
 LMx8Fv3jjqGoa0BtI5mUpuKNBPa8xIo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-258-HYKCIqkeMsiwhIHicqpvNA-1; Mon, 09 Nov 2020 17:43:03 -0500
X-MC-Unique: HYKCIqkeMsiwhIHicqpvNA-1
Received: by mail-wr1-f70.google.com with SMTP id e18so4873675wrs.23
 for <virtualization@lists.linux-foundation.org>;
 Mon, 09 Nov 2020 14:43:02 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=Fg7zSSuXfHaOdrJzE6K3KV6fZlH5LajqxqmYKp+iv8o=;
 b=KxcETfHujN+C/I+doNqm+/ZqIpX6NyFJafRy1DYFEKxm0nQbUni6BFbvcC5mccjto+
 eflVuKE8JhC4Oe35C5m0QfH55Bx+P0IkFbFEHwNkdYJPXT/q0PNLy/Qse1TciQm1JVeR
 gcvqAsJQjL8Inhg6R2Ormw06c/3AbM9qWuTJ24Jv8w2rKCIvM/2FdGpuOix94TIFT2ON
 hTtXDWZeigu9UhKGvn5yV1wxpPi34UyoGW0ciOcJWewyCy3T9PRtpBluJO0iivbhlwxp
 lHx/01kdN2Wxt9CfgGe5WPV5/tD+roNK0qPGteoR6YLumSLuVJSDMmsFn2g/qiAL6Jf6
 c1Hw==
X-Gm-Message-State: AOAM530oB0xn882nB2bHy1QUjVpNZ5JplgUqVja8sM7CD72pTayeFqsh
 AisH8y6oc7PzC/QX87S3h7ITvdHY9BmF2esEPhhw1FKlOwgH6Bq+81Ze0s8KANnG/qh5HPPqXRO
 p3uMsJhk9nn2qZS6icT8yUmxadD6fbPvXmyCBGI2k9Q==
X-Received: by 2002:a1c:2586:: with SMTP id l128mr1301876wml.149.1604961781719; 
 Mon, 09 Nov 2020 14:43:01 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwq4ZSd62uP/XNENstVYdZIcFqG2pf7QHksn08DgXsoon1ffeXEyoptiT/kazbdFNifZSAvow==
X-Received: by 2002:a1c:2586:: with SMTP id l128mr1301856wml.149.1604961781448; 
 Mon, 09 Nov 2020 14:43:01 -0800 (PST)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id f17sm858256wmh.10.2020.11.09.14.42.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 09 Nov 2020 14:43:00 -0800 (PST)
Date: Mon, 9 Nov 2020 17:42:57 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: si-wei liu <si-wei.liu@oracle.com>
Subject: Re: [PATCH v2] vhost-vdpa: fix page pinning leakage in error path
 (rework)
Message-ID: <20201109173236-mutt-send-email-mst@kernel.org>
References: <1604532796-12757-1-git-send-email-si-wei.liu@oracle.com>
 <dcbe4f3e-42f3-d245-9ee4-b17977ad27a5@redhat.com>
 <5FA48342.4060404@oracle.com>
 <64fb6179-c5ff-9552-381f-85b63e704057@redhat.com>
 <5FA9B823.9060609@oracle.com>
MIME-Version: 1.0
In-Reply-To: <5FA9B823.9060609@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: lingshan.zhu@intel.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, boris.ostrovsky@oracle.com
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gTW9uLCBOb3YgMDksIDIwMjAgYXQgMDE6NDQ6MDNQTSAtMDgwMCwgc2ktd2VpIGxpdSB3cm90
ZToKPiAKPiBPbiAxMS84LzIwMjAgNzoyMSBQTSwgSmFzb24gV2FuZyB3cm90ZToKPiA+IAo+ID4g
T24gMjAyMC8xMS82IOS4iuWNiDY6NTcsIHNpLXdlaSBsaXUgd3JvdGU6Cj4gPiA+IAo+ID4gPiBP
biAxMS80LzIwMjAgNzoyNiBQTSwgSmFzb24gV2FuZyB3cm90ZToKPiA+ID4gPiAKPiA+ID4gPiBP
biAyMDIwLzExLzUg5LiK5Y2INzozMywgU2ktV2VpIExpdSB3cm90ZToKPiA+ID4gPiA+IFBpbm5l
ZCBwYWdlcyBhcmUgbm90IHByb3Blcmx5IGFjY291bnRlZCBwYXJ0aWN1bGFybHkgd2hlbgo+ID4g
PiA+ID4gbWFwcGluZyBlcnJvciBvY2N1cnMgb24gSU9UTEIgdXBkYXRlLiBDbGVhbiB1cCBkYW5n
bGluZwo+ID4gPiA+ID4gcGlubmVkIHBhZ2VzIGZvciB0aGUgZXJyb3IgcGF0aC4KPiA+ID4gPiA+
IAo+ID4gPiA+ID4gVGhlIG1lbW9yeSB1c2FnZSBmb3IgYm9va2tlZXBpbmcgcGlubmVkIHBhZ2Vz
IGlzIHJldmVydGVkCj4gPiA+ID4gPiB0byB3aGF0IGl0IHdhcyBiZWZvcmU6IG9ubHkgb25lIHNp
bmdsZSBmcmVlIHBhZ2UgaXMgbmVlZGVkLgo+ID4gPiA+ID4gVGhpcyBoZWxwcyByZWR1Y2UgdGhl
IGhvc3QgbWVtb3J5IGRlbWFuZCBmb3IgVk0gd2l0aCBhIGxhcmdlCj4gPiA+ID4gPiBhbW91bnQg
b2YgbWVtb3J5LCBvciBpbiB0aGUgc2l0dWF0aW9uIHdoZXJlIGhvc3QgaXMgcnVubmluZwo+ID4g
PiA+ID4gc2hvcnQgb2YgZnJlZSBtZW1vcnkuCj4gPiA+ID4gPiAKPiA+ID4gPiA+IEZpeGVzOiA0
YzhjZjMxODg1ZjYgKCJ2aG9zdDogaW50cm9kdWNlIHZEUEEtYmFzZWQgYmFja2VuZCIpCj4gPiA+
ID4gPiBTaWduZWQtb2ZmLWJ5OiBTaS1XZWkgTGl1IDxzaS13ZWkubGl1QG9yYWNsZS5jb20+Cj4g
PiA+ID4gPiAtLS0KPiA+ID4gPiA+IENoYW5nZXMgaW4gdjI6Cj4gPiA+ID4gPiAtIERyb3AgdGhl
IHJldmVyc2lvbiBwYXRjaAo+ID4gPiA+ID4gLSBGaXggdW5oYW5kbGVkIHBhZ2UgbGVhayB0b3dh
cmRzIHRoZSBlbmQgb2YgcGFnZV9saXN0Cj4gPiA+ID4gPiAKPiA+ID4gPiA+ICAgZHJpdmVycy92
aG9zdC92ZHBhLmMgfCA3OQo+ID4gPiA+ID4gKysrKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKysrKy0tLS0tLS0tLS0tLQo+ID4gPiA+ID4gICAxIGZpbGUgY2hhbmdlZCwgNjEgaW5z
ZXJ0aW9ucygrKSwgMTggZGVsZXRpb25zKC0pCj4gPiA+ID4gPiAKPiA+ID4gPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gPiA+ID4g
PiBpbmRleCBiNmQ5MDE2Li5lMTEyODU0IDEwMDY0NAo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy92
aG9zdC92ZHBhLmMKPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gPiA+ID4g
PiBAQCAtNTYwLDYgKzU2MCw4IEBAIHN0YXRpYyBpbnQgdmhvc3RfdmRwYV9tYXAoc3RydWN0IHZo
b3N0X3ZkcGEgKnYsCj4gPiA+ID4gPiAgICAgICAgIGlmIChyKQo+ID4gPiA+ID4gICAgICAgICAg
IHZob3N0X2lvdGxiX2RlbF9yYW5nZShkZXYtPmlvdGxiLCBpb3ZhLCBpb3ZhICsgc2l6ZSAtIDEp
Owo+ID4gPiA+ID4gKyAgICBlbHNlCj4gPiA+ID4gPiArICAgICAgICBhdG9taWM2NF9hZGQoc2l6
ZSA+PiBQQUdFX1NISUZULCAmZGV2LT5tbS0+cGlubmVkX3ZtKTsKPiA+ID4gPiA+ICAgICAgICAg
cmV0dXJuIHI7Cj4gPiA+ID4gPiAgIH0KPiA+ID4gPiA+IEBAIC01OTEsMTQgKzU5MywxNiBAQCBz
dGF0aWMgaW50Cj4gPiA+ID4gPiB2aG9zdF92ZHBhX3Byb2Nlc3NfaW90bGJfdXBkYXRlKHN0cnVj
dCB2aG9zdF92ZHBhICp2LAo+ID4gPiA+ID4gICAgICAgdW5zaWduZWQgbG9uZyBsaXN0X3NpemUg
PSBQQUdFX1NJWkUgLyBzaXplb2Yoc3RydWN0IHBhZ2UgKik7Cj4gPiA+ID4gPiAgICAgICB1bnNp
Z25lZCBpbnQgZ3VwX2ZsYWdzID0gRk9MTF9MT05HVEVSTTsKPiA+ID4gPiA+ICAgICAgIHVuc2ln
bmVkIGxvbmcgbnBhZ2VzLCBjdXJfYmFzZSwgbWFwX3BmbiwgbGFzdF9wZm4gPSAwOwo+ID4gPiA+
ID4gLSAgICB1bnNpZ25lZCBsb25nIGxvY2tlZCwgbG9ja19saW1pdCwgcGlubmVkLCBpOwo+ID4g
PiA+ID4gKyAgICB1bnNpZ25lZCBsb25nIGxvY2tfbGltaXQsIHN6MnBpbiwgbmNodW5rcywgaTsK
PiA+ID4gPiA+ICAgICAgIHU2NCBpb3ZhID0gbXNnLT5pb3ZhOwo+ID4gPiA+ID4gKyAgICBsb25n
IHBpbm5lZDsKPiA+ID4gPiA+ICAgICAgIGludCByZXQgPSAwOwo+ID4gPiA+ID4gICAgICAgICBp
ZiAodmhvc3RfaW90bGJfaXRyZWVfZmlyc3QoaW90bGIsIG1zZy0+aW92YSwKPiA+ID4gPiA+ICAg
ICAgICAgICAgICAgICAgICAgICBtc2ctPmlvdmEgKyBtc2ctPnNpemUgLSAxKSkKPiA+ID4gPiA+
ICAgICAgICAgICByZXR1cm4gLUVFWElTVDsKPiA+ID4gPiA+ICAgKyAgICAvKiBMaW1pdCB0aGUg
dXNlIG9mIG1lbW9yeSBmb3IgYm9va2tlZXBpbmcgKi8KPiA+ID4gPiA+ICAgICAgIHBhZ2VfbGlz
dCA9IChzdHJ1Y3QgcGFnZSAqKikgX19nZXRfZnJlZV9wYWdlKEdGUF9LRVJORUwpOwo+ID4gPiA+
ID4gICAgICAgaWYgKCFwYWdlX2xpc3QpCj4gPiA+ID4gPiAgICAgICAgICAgcmV0dXJuIC1FTk9N
RU07Cj4gPiA+ID4gPiBAQCAtNjA3LDUyICs2MTEsNzUgQEAgc3RhdGljIGludAo+ID4gPiA+ID4g
dmhvc3RfdmRwYV9wcm9jZXNzX2lvdGxiX3VwZGF0ZShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPiA+
ID4gPiA+ICAgICAgICAgICBndXBfZmxhZ3MgfD0gRk9MTF9XUklURTsKPiA+ID4gPiA+ICAgICAg
ICAgbnBhZ2VzID0gUEFHRV9BTElHTihtc2ctPnNpemUgKyAoaW92YSAmIH5QQUdFX01BU0spKQo+
ID4gPiA+ID4gPj4gUEFHRV9TSElGVDsKPiA+ID4gPiA+IC0gICAgaWYgKCFucGFnZXMpCj4gPiA+
ID4gPiAtICAgICAgICByZXR1cm4gLUVJTlZBTDsKPiA+ID4gPiA+ICsgICAgaWYgKCFucGFnZXMp
IHsKPiA+ID4gPiA+ICsgICAgICAgIHJldCA9IC1FSU5WQUw7Cj4gPiA+ID4gPiArICAgICAgICBn
b3RvIGZyZWU7Cj4gPiA+ID4gPiArICAgIH0KPiA+ID4gPiA+ICAgICAgICAgbW1hcF9yZWFkX2xv
Y2soZGV2LT5tbSk7Cj4gPiA+ID4gPiAgIC0gICAgbG9ja2VkID0gYXRvbWljNjRfYWRkX3JldHVy
bihucGFnZXMsICZkZXYtPm1tLT5waW5uZWRfdm0pOwo+ID4gPiA+ID4gICAgICAgbG9ja19saW1p
dCA9IHJsaW1pdChSTElNSVRfTUVNTE9DSykgPj4gUEFHRV9TSElGVDsKPiA+ID4gPiA+IC0KPiA+
ID4gPiA+IC0gICAgaWYgKGxvY2tlZCA+IGxvY2tfbGltaXQpIHsKPiA+ID4gPiA+ICsgICAgaWYg
KG5wYWdlcyArIGF0b21pYzY0X3JlYWQoJmRldi0+bW0tPnBpbm5lZF92bSkgPiBsb2NrX2xpbWl0
KSB7Cj4gPiA+ID4gPiAgICAgICAgICAgcmV0ID0gLUVOT01FTTsKPiA+ID4gPiA+IC0gICAgICAg
IGdvdG8gb3V0Owo+ID4gPiA+ID4gKyAgICAgICAgZ290byB1bmxvY2s7Cj4gPiA+ID4gPiAgICAg
ICB9Cj4gPiA+ID4gPiAgICAgICAgIGN1cl9iYXNlID0gbXNnLT51YWRkciAmIFBBR0VfTUFTSzsK
PiA+ID4gPiA+ICAgICAgIGlvdmEgJj0gUEFHRV9NQVNLOwo+ID4gPiA+ID4gKyAgICBuY2h1bmtz
ID0gMDsKPiA+ID4gPiA+ICAgICAgICAgd2hpbGUgKG5wYWdlcykgewo+ID4gPiA+ID4gLSAgICAg
ICAgcGlubmVkID0gbWluX3QodW5zaWduZWQgbG9uZywgbnBhZ2VzLCBsaXN0X3NpemUpOwo+ID4g
PiA+ID4gLSAgICAgICAgcmV0ID0gcGluX3VzZXJfcGFnZXMoY3VyX2Jhc2UsIHBpbm5lZCwKPiA+
ID4gPiA+IC0gICAgICAgICAgICAgICAgICAgICBndXBfZmxhZ3MsIHBhZ2VfbGlzdCwgTlVMTCk7
Cj4gPiA+ID4gPiAtICAgICAgICBpZiAocmV0ICE9IHBpbm5lZCkKPiA+ID4gPiA+ICsgICAgICAg
IHN6MnBpbiA9IG1pbl90KHVuc2lnbmVkIGxvbmcsIG5wYWdlcywgbGlzdF9zaXplKTsKPiA+ID4g
PiA+ICsgICAgICAgIHBpbm5lZCA9IHBpbl91c2VyX3BhZ2VzKGN1cl9iYXNlLCBzejJwaW4sCj4g
PiA+ID4gPiArICAgICAgICAgICAgICAgICAgICBndXBfZmxhZ3MsIHBhZ2VfbGlzdCwgTlVMTCk7
Cj4gPiA+ID4gPiArICAgICAgICBpZiAoc3oycGluICE9IHBpbm5lZCkgewo+ID4gPiA+ID4gKyAg
ICAgICAgICAgIGlmIChwaW5uZWQgPCAwKSB7Cj4gPiA+ID4gPiArICAgICAgICAgICAgICAgIHJl
dCA9IHBpbm5lZDsKPiA+ID4gPiA+ICsgICAgICAgICAgICB9IGVsc2Ugewo+ID4gPiA+ID4gKyAg
ICAgICAgICAgICAgICB1bnBpbl91c2VyX3BhZ2VzKHBhZ2VfbGlzdCwgcGlubmVkKTsKPiA+ID4g
PiA+ICsgICAgICAgICAgICAgICAgcmV0ID0gLUVOT01FTTsKPiA+ID4gPiA+ICsgICAgICAgICAg
ICB9Cj4gPiA+ID4gPiAgICAgICAgICAgICAgIGdvdG8gb3V0Owo+ID4gPiA+ID4gKyAgICAgICAg
fQo+ID4gPiA+ID4gKyAgICAgICAgbmNodW5rcysrOwo+ID4gPiA+ID4gICAgICAgICAgICAgaWYg
KCFsYXN0X3BmbikKPiA+ID4gPiA+ICAgICAgICAgICAgICAgbWFwX3BmbiA9IHBhZ2VfdG9fcGZu
KHBhZ2VfbGlzdFswXSk7Cj4gPiA+ID4gPiAgIC0gICAgICAgIGZvciAoaSA9IDA7IGkgPCByZXQ7
IGkrKykgewo+ID4gPiA+ID4gKyAgICAgICAgZm9yIChpID0gMDsgaSA8IHBpbm5lZDsgaSsrKSB7
Cj4gPiA+ID4gPiAgICAgICAgICAgICAgIHVuc2lnbmVkIGxvbmcgdGhpc19wZm4gPSBwYWdlX3Rv
X3BmbihwYWdlX2xpc3RbaV0pOwo+ID4gPiA+ID4gICAgICAgICAgICAgICB1NjQgY3NpemU7Cj4g
PiA+ID4gPiAgICAgICAgICAgICAgICAgaWYgKGxhc3RfcGZuICYmICh0aGlzX3BmbiAhPSBsYXN0
X3BmbiArIDEpKSB7Cj4gPiA+ID4gPiAgICAgICAgICAgICAgICAgICAvKiBQaW4gYSBjb250aWd1
b3VzIGNodW5rIG9mIG1lbW9yeSAqLwo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAgY3NpemUg
PSAobGFzdF9wZm4gLSBtYXBfcGZuICsgMSkgPDwgUEFHRV9TSElGVDsKPiA+ID4gPiA+IC0gICAg
ICAgICAgICAgICAgaWYgKHZob3N0X3ZkcGFfbWFwKHYsIGlvdmEsIGNzaXplLAo+ID4gPiA+ID4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgIG1hcF9wZm4gPDwgUEFHRV9TSElGVCwKPiA+ID4g
PiA+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICBtc2ctPnBlcm0pKQo+ID4gPiA+ID4gKyAg
ICAgICAgICAgICAgICByZXQgPSB2aG9zdF92ZHBhX21hcCh2LCBpb3ZhLCBjc2l6ZSwKPiA+ID4g
PiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1hcF9wZm4gPDwgUEFHRV9TSElGVCwK
PiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG1zZy0+cGVybSk7Cj4gPiA+
ID4gPiArICAgICAgICAgICAgICAgIGlmIChyZXQpIHsKPiA+ID4gPiA+ICsgICAgICAgICAgICAg
ICAgICAgIC8qCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgKiBVbnBpbiB0aGUgcGFn
ZXMgdGhhdCBhcmUgbGVmdCB1bm1hcHBlZAo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAg
ICogZnJvbSB0aGlzIHBvaW50IG9uIGluIHRoZSBjdXJyZW50Cj4gPiA+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgKiBwYWdlX2xpc3QuIFRoZSByZW1haW5pbmcgb3V0c3RhbmRpbmcKPiA+ID4g
PiA+ICsgICAgICAgICAgICAgICAgICAgICAqIG9uZXMgd2hpY2ggbWF5IHN0cmlkZSBhY3Jvc3Mg
c2V2ZXJhbAo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICogY2h1bmtzIHdpbGwgYmUg
Y292ZXJlZCBpbiB0aGUgY29tbW9uCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgKiBl
cnJvciBwYXRoIHN1YnNlcXVlbnRseS4KPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAq
Lwo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgdW5waW5fdXNlcl9wYWdlcygmcGFnZV9s
aXN0W2ldLAo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcGlubmVkIC0g
aSk7Cj4gPiA+ID4gCj4gPiA+ID4gCj4gPiA+ID4gQ2FuIHdlIHNpbXBseSBkbyBsYXN0X3BmbiA9
IHRoaXNfcGZuIGhlcmU/Cj4gPiA+IE5vcGUuIFRoZXkgYXJlIG5vdCBjb250aWd1b3VzIHNlZ21l
bnRzIG9mIG1lbW9yeS4gTm90ZWQgdGhlCj4gPiA+IGNvbmRpdGlvbmFsICh0aGlzX3BmbiAhPSBs
YXN0X3BmbiArIDEpIGJlaW5nIGhlbGQgaGVyZS4KPiA+IAo+ID4gCj4gPiBSaWdodC4KPiA+IAo+
ID4gCj4gPiA+IAo+ID4gPiA+IAo+ID4gPiA+IAo+ID4gPiA+ID4gICAgICAgICAgICAgICAgICAg
ICAgIGdvdG8gb3V0Owo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICB9Cj4gPiA+ID4gPiArCj4g
PiA+ID4gPiAgICAgICAgICAgICAgICAgICBtYXBfcGZuID0gdGhpc19wZm47Cj4gPiA+ID4gPiAg
ICAgICAgICAgICAgICAgICBpb3ZhICs9IGNzaXplOwo+ID4gPiA+ID4gKyAgICAgICAgICAgICAg
ICBuY2h1bmtzID0gMDsKPiA+ID4gPiA+ICAgICAgICAgICAgICAgfQo+ID4gPiA+ID4gICAgICAg
ICAgICAgICAgIGxhc3RfcGZuID0gdGhpc19wZm47Cj4gPiA+ID4gPiAgICAgICAgICAgfQo+ID4g
PiA+ID4gICAtICAgICAgICBjdXJfYmFzZSArPSByZXQgPDwgUEFHRV9TSElGVDsKPiA+ID4gPiA+
IC0gICAgICAgIG5wYWdlcyAtPSByZXQ7Cj4gPiA+ID4gPiArICAgICAgICBjdXJfYmFzZSArPSBw
aW5uZWQgPDwgUEFHRV9TSElGVDsKPiA+ID4gPiA+ICsgICAgICAgIG5wYWdlcyAtPSBwaW5uZWQ7
Cj4gPiA+ID4gPiAgICAgICB9Cj4gPiA+ID4gPiAgICAgICAgIC8qIFBpbiB0aGUgcmVzdCBjaHVu
ayAqLwo+ID4gPiA+ID4gQEAgLTY2MCwxMCArNjg3LDI2IEBAIHN0YXRpYyBpbnQKPiA+ID4gPiA+
IHZob3N0X3ZkcGFfcHJvY2Vzc19pb3RsYl91cGRhdGUoc3RydWN0IHZob3N0X3ZkcGEgKnYsCj4g
PiA+ID4gPiAgICAgICAgICAgICAgICAgICAgbWFwX3BmbiA8PCBQQUdFX1NISUZULCBtc2ctPnBl
cm0pOwo+ID4gPiA+ID4gICBvdXQ6Cj4gPiA+ID4gPiAgICAgICBpZiAocmV0KSB7Cj4gPiA+ID4g
PiArICAgICAgICBpZiAobmNodW5rcyAmJiBsYXN0X3Bmbikgewo+ID4gPiA+IAo+ID4gPiA+IAo+
ID4gPiA+IEFueSByZWFzb24gZm9yIGNoZWNraW5nIGxhc3RfcGZuIGhlcmU/Cj4gPiA+ID4gCj4g
PiA+ID4gTm90ZSB0aGF0IHdlIGRpZDoKPiA+ID4gPiAKPiA+ID4gPiArICAgICAgICBuY2h1bmtz
Kys7Cj4gPiA+ID4gCj4gPiA+ID4gICAgICAgICAgaWYgKCFsYXN0X3BmbikKPiA+ID4gPiAgICAg
ICAgICAgICAgbWFwX3BmbiA9IHBhZ2VfdG9fcGZuKHBhZ2VfbGlzdFswXSk7Cj4gPiA+IEl0J3Mg
Zm9yIGV4cGxpY2l0IGNvZGluZyB0byBtYWtlIHN1cmUgdGhpcyBjb21tb24gZXJyb3IgcGF0aCBj
YW4gYmUKPiA+ID4gcmV1c2VkIG5vIG1hdHRlciBpZiBsYXN0X3BmbiBoYXMgYSBzYW5lIHZhbHVl
IGFzc2lnbmVkIG9yIG5vdC4gSSBjYW4KPiA+ID4gY2hhbmdlIGl0IHRvIGFuIGltcGxpY2l0IFdB
Uk5fT04oKSBpZiBuZWVkIGJlLgo+ID4gCj4gPiAKPiA+IEp1c3QgdG8gbWFrZSBzdXJlIEkgdW5k
ZXJzdGFuZC4gQSBxdWVzdGlvbiwgd2hlbiB3aWxsIHdlIGdldCBuY2h1bmtzICE9Cj4gPiAwIGJ1
dCBsYXN0X3BmbiA9PSAwPwo+IFRoZSBjdXJyZW50IGNvZGUgaGFzIGltcGxpY2l0IGFzc3VtcHRp
b24gdGhhdCBuY2h1bmtzICE9IDAgaW5mZXJzIGxhc3RfcGZuCj4gIT0gMC4gSG93ZXZlciwgdGhp
cyBhc3N1bXB0aW9uIGNvdWxkIGJyZWFrIHN1YmplY3QgdG8gY29kZSBzdHJ1Y3R1cmUgY2hhbmdl
cwo+IGZvciBlZy4gZmFpbHVyZSBtYXkgb2NjdXIgYWZ0ZXIgdGhlIGluY3JlbWVudCBvZiBuY2h1
bmtzIGFuZCBiZWZvcmUgdGhlIGZvcgo+IGxvb3AuIEkgZmVlbCBpdCdkIGJlIHRoZSBiZXN0IHRv
IGNhcHR1cmUgdGhpcyBhc3N1bXB0aW9uIHdpdGggc29tZXRoaW5nCj4gZXhwbGljaXQuCj4gCj4g
LVNpd2VpCgppZiBoZXJlIGlzbid0IHJlYWxseSBhbiBleHBsaWNpdCB3YXkgdG8gZG9jdW1lbnQg
YXNzdW1wdGlvbnMsCml0J3MgYSB3YXkgdG8gYXZvaWQgYXNzdW1wdGlvbnMgOikKQSB3YXkgdG8g
ZG9jdW1lbnQgYXNzdW1wdGlvbnMgaXMgcHJvYmFibHkgQlVHX09OLgoKPiA+IAo+ID4gVGhhbmtz
Cj4gPiAKPiA+IAo+ID4gPiBUaGFua3MsCj4gPiA+IC1TaXdlaQo+ID4gPiAKPiA+ID4gPiAKPiA+
ID4gPiAKPiA+ID4gPiBUaGFua3MKPiA+ID4gPiAKPiA+ID4gPiAKPiA+ID4gPiA+ICsgICAgICAg
ICAgICB1bnNpZ25lZCBsb25nIHBmbjsKPiA+ID4gPiA+ICsKPiA+ID4gPiA+ICsgICAgICAgICAg
ICAvKgo+ID4gPiA+ID4gKyAgICAgICAgICAgICAqIFVucGluIHRoZSBvdXRzdGFuZGluZyBwYWdl
cyB3aGljaCBhcmUgeWV0IHRvIGJlCj4gPiA+ID4gPiArICAgICAgICAgICAgICogbWFwcGVkIGJ1
dCBoYXZlbid0IGR1ZSB0byB2ZHBhX21hcCgpIG9yCj4gPiA+ID4gPiArICAgICAgICAgICAgICog
cGluX3VzZXJfcGFnZXMoKSBmYWlsdXJlLgo+ID4gPiA+ID4gKyAgICAgICAgICAgICAqCj4gPiA+
ID4gPiArICAgICAgICAgICAgICogTWFwcGVkIHBhZ2VzIGFyZSBhY2NvdW50ZWQgaW4gdmRwYV9t
YXAoKSwgaGVuY2UKPiA+ID4gPiA+ICsgICAgICAgICAgICAgKiB0aGUgY29ycmVzcG9uZGluZyB1
bnBpbm5pbmcgd2lsbCBiZSBoYW5kbGVkIGJ5Cj4gPiA+ID4gPiArICAgICAgICAgICAgICogdmRw
YV91bm1hcCgpLgo+ID4gPiA+ID4gKyAgICAgICAgICAgICAqLwo+ID4gPiA+ID4gKyAgICAgICAg
ICAgIGZvciAocGZuID0gbWFwX3BmbjsgcGZuIDw9IGxhc3RfcGZuOyBwZm4rKykKPiA+ID4gPiA+
ICsgICAgICAgICAgICAgICAgdW5waW5fdXNlcl9wYWdlKHBmbl90b19wYWdlKHBmbikpOwo+ID4g
PiA+ID4gKyAgICAgICAgfQo+ID4gPiA+ID4gICAgICAgICAgIHZob3N0X3ZkcGFfdW5tYXAodiwg
bXNnLT5pb3ZhLCBtc2ctPnNpemUpOwo+ID4gPiA+ID4gLSAgICAgICAgYXRvbWljNjRfc3ViKG5w
YWdlcywgJmRldi0+bW0tPnBpbm5lZF92bSk7Cj4gPiA+ID4gPiAgICAgICB9Cj4gPiA+ID4gPiAr
dW5sb2NrOgo+ID4gPiA+ID4gICAgICAgbW1hcF9yZWFkX3VubG9jayhkZXYtPm1tKTsKPiA+ID4g
PiA+ICtmcmVlOgo+ID4gPiA+ID4gICAgICAgZnJlZV9wYWdlKCh1bnNpZ25lZCBsb25nKXBhZ2Vf
bGlzdCk7Cj4gPiA+ID4gPiAgICAgICByZXR1cm4gcmV0Owo+ID4gPiA+ID4gICB9Cj4gPiA+ID4g
Cj4gPiA+IAo+ID4gCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGlu
dXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxt
YW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
