Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 416E7C433F5
	for <virtualization@archiver.kernel.org>; Tue, 18 Jan 2022 15:43:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id CB92F81C2F;
	Tue, 18 Jan 2022 15:43:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ifbBUB-clESo; Tue, 18 Jan 2022 15:43:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 8538F81C11;
	Tue, 18 Jan 2022 15:43:51 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5ACA0C0031;
	Tue, 18 Jan 2022 15:43:51 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id B07D4C002F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 15:43:50 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 8AB2040911
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 15:43:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id L39PBh6XYLuJ
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 15:43:49 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id BE81340902
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 15:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642520628;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=d0YPpE+94B6yWE7TJv4rcwracfeu9W68cFUmQp0rBtk=;
 b=LO9Nj9JEbYMlZTPL0FLBaEnZDu3+oaKMYU/ANGRjyyUn/WZh1vI+2Ac9Ltwe2jTlDGJKfu
 YN/p3M1ahNEdMaEJsbkNI6maygU5B4HtVfAQzf9BqF4iii6EhLIXDjhNa7idR1IAubYAqy
 Yrr2eij5h699AkT/LItEZFcCtDWbHtM=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-554-YTUf0d2-O6C_aRobPrBz7w-1; Tue, 18 Jan 2022 10:43:47 -0500
X-MC-Unique: YTUf0d2-O6C_aRobPrBz7w-1
Received: by mail-ed1-f71.google.com with SMTP id
 ej6-20020a056402368600b00402b6f12c3fso5954959edb.8
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 Jan 2022 07:43:44 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=d0YPpE+94B6yWE7TJv4rcwracfeu9W68cFUmQp0rBtk=;
 b=Ar8puWA+gu1ssdfZhGUEr/jfaGVobbQ6+oqg3NrAliWqBHXK8e0yv/hg609mFCbHBt
 mBmreFhf/IOk415nLTcj4C3AJ1bE/XUCJRvMy+ZgLuOjp1nbBnd/p08dxXm0O3yjEfKD
 Fq73Wpl2eeIWcCdfTOOCWyqcttogAjU9PDeaUUsqcTsrj00wC1kxx+0cWuO4krhi0a+R
 X1Wudd19Usbx+3+PVmJLVlSBxXlADEatxcrLSEJXTLRwqZIqV6MDlPr6+cgH4prlp3R5
 +8OVZFec8ii08ogF+dS6mEIFGFnDweKdaMLoHuWbgakHYN8/14ECcFukUXGLYDVhtPoN
 /UtQ==
X-Gm-Message-State: AOAM533g7atCS9uj4fhxPZCi0qw13IsUzMIweTdhuBvAJDUO5ecZWwgc
 V085rS+zbTqQkgsfzHVZ6svqJ1kYVjw/trmnxenm3mzN0iD/UoN9dEnUWdKNj1H1uBeXFDYeB2d
 j5m+grFPvSne2We4tJu9AYJKYabap+qD1o4LdS/y0ng==
X-Received: by 2002:a05:6402:291b:: with SMTP id
 ee27mr18848544edb.363.1642520623262; 
 Tue, 18 Jan 2022 07:43:43 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwSf30u1Y8twrreQGvhRj70h4otcNrhlmXnPl8LDEz9y+o8KJ76N1+dABMmBkucVx6D4qd3/Q==
X-Received: by 2002:a05:6402:291b:: with SMTP id
 ee27mr18848524edb.363.1642520623022; 
 Tue, 18 Jan 2022 07:43:43 -0800 (PST)
Received: from redhat.com ([2.55.154.241])
 by smtp.gmail.com with ESMTPSA id hs32sm5459700ejc.180.2022.01.18.07.43.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 Jan 2022 07:43:42 -0800 (PST)
Date: Tue, 18 Jan 2022 10:43:38 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] virtio: acknowledge all features before access
Message-ID: <20220118104318-mutt-send-email-mst@kernel.org>
References: <20220114200744.150325-1-mst@redhat.com>
 <d6c4e521-1538-bbbf-30e6-f658a095b3ae@redhat.com>
 <20220117032429-mutt-send-email-mst@kernel.org>
 <87mtjuv8od.fsf@redhat.com>
MIME-Version: 1.0
In-Reply-To: <87mtjuv8od.fsf@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Halil Pasic <pasic@linux.ibm.com>, linux-kernel@vger.kernel.org,
 stable@vger.kernel.org, virtualization@lists.linux-foundation.org
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

T24gTW9uLCBKYW4gMTcsIDIwMjIgYXQgMDE6Mzg6NDJQTSArMDEwMCwgQ29ybmVsaWEgSHVjayB3
cm90ZToKPiBPbiBNb24sIEphbiAxNyAyMDIyLCAiTWljaGFlbCBTLiBUc2lya2luIiA8bXN0QHJl
ZGhhdC5jb20+IHdyb3RlOgo+IAo+ID4gT24gTW9uLCBKYW4gMTcsIDIwMjIgYXQgMDI6MzE6NDlQ
TSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+PiAKPiA+PiDlnKggMjAyMi8xLzE1IOS4iuWN
iDQ6MDksIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4gPj4gPiBAQCAtNDk1LDYgKzQ5NCwx
MCBAQCBpbnQgdmlydGlvX2RldmljZV9yZXN0b3JlKHN0cnVjdCB2aXJ0aW9fZGV2aWNlICpkZXYp
Cj4gPj4gPiAgIAkvKiBXZSBoYXZlIGEgZHJpdmVyISAqLwo+ID4+ID4gICAJdmlydGlvX2FkZF9z
dGF0dXMoZGV2LCBWSVJUSU9fQ09ORklHX1NfRFJJVkVSKTsKPiA+PiA+ICsJcmV0ID0gZGV2LT5j
b25maWctPmZpbmFsaXplX2ZlYXR1cmVzKGRldik7Cj4gPj4gPiArCWlmIChyZXQpCj4gPj4gPiAr
CQlnb3RvIGVycjsKPiA+PiAKPiA+PiAKPiA+PiBJcyB0aGlzIHBhcnQgb2YgY29kZSByZWxhdGVk
Pwo+ID4+IAo+ID4+IFRoYW5rcwo+ID4+IAo+ID4KPiA+IFllcy4gdmlydGlvX2ZpbmFsaXplX2Zl
YXR1cmVzIG5vIGxvbmdlciBjYWxscyBkZXYtPmNvbmZpZy0+ZmluYWxpemVfZmVhdHVyZXMuCj4g
Pgo+ID4gSSB0aGluayB0aGUgZGV2LT5jb25maWctPmZpbmFsaXplX2ZlYXR1cmVzIGNhbGxiYWNr
IGlzIGFjdHVhbGx5Cj4gPiBhIG1pc25vbWVyIG5vdywgaXQganVzdCBzZW5kcyB0aGUgZmVhdHVy
ZXMgdG8gZGV2aWNlLAo+ID4gZmluYWxpemUgaXMgRkVBVFVSRVNfT0suIFJlbmFtaW5nIHRoYXQg
aXMgYSBiaWdnZXIKPiA+IHBhdGNoIHRob3VnaCwgYW5kIEknZCBsaWtlIHRoaXMgb25lIHRvIGJl
IGNoZXJyeS1waWNrYWJsZQo+ID4gdG8gc3RhYmxlLgo+IAo+IERvIHdlIHdhbnQgdG8gYWRkIGEg
Y29tbWVudCBiZWZvcmUgdGhlIGNhbGxzIHRvIC0+ZmluYWxpemVfZmVhdHVyZXMoKQo+ICgvKiB3
cml0ZSBmZWF0dXJlcyB0byBkZXZpY2UgKi8pIGFuZCBhZGFwdCB0aGUgY29tbWVudCBpbiB2aXJ0
aW9fcmluZy5oPwo+IFNob3VsZCBzdGlsbCBiZSBzdGFibGUtZnJpZW5kbHksIGFuZCBnaXZpbmcg
dGhlIGNhbGxiYWNrIGEgYmV0dGVyIG5hbWUKPiBjYW4gYmUgYSBmb2xsb3ctdXAgcGF0Y2guCgpT
b3JyeSB3aGljaCBjb21tZW50IGluIHZpcnRpb19yaW5nLmg/CkNvdWxkIG5vdCBmaW5kIGFueXRo
aW5nLgoKPiA+Cj4gPj4gPiArCj4gPj4gPiAgIAlyZXQgPSB2aXJ0aW9fZmluYWxpemVfZmVhdHVy
ZXMoZGV2KTsKPiA+PiA+ICAgCWlmIChyZXQpCj4gPj4gPiAgIAkJZ290byBlcnI7CgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
