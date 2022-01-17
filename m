Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1132CC433F5
	for <virtualization@archiver.kernel.org>; Mon, 17 Jan 2022 23:14:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 992A8402D3;
	Mon, 17 Jan 2022 23:14:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XC4Y5WtQJswi; Mon, 17 Jan 2022 23:14:03 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4A442402CA;
	Mon, 17 Jan 2022 23:14:03 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 10AB0C0039;
	Mon, 17 Jan 2022 23:14:03 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 922E7C002F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 23:14:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 6C54E812CC
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 23:14:01 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id pyL-aFmO2iRz
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 23:14:00 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 690E1812CA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 23:14:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1642461239;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=poL37lSy5yu+pXxIBkPJdf1QhhjhrG0y8WyJPB/Gac4=;
 b=cHoc6UPpucyNFfOPIEB/5koMaKlkBRvD7YHGYaBZ4CGfgaPdpjY6swRUkt0SAIWD+9OUzI
 Yz1vaOPfepoxcWTm1fvUOKdAVZFk4AvBszZ+oqy2LxBJpW8TyEym34r5RgHljcSs0lkPMz
 D821CiSRrU0vGVu4uhzJ6WSqrhxt4GI=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-306-AToF2GnoMb-dCbFwQbAijg-1; Mon, 17 Jan 2022 18:13:58 -0500
X-MC-Unique: AToF2GnoMb-dCbFwQbAijg-1
Received: by mail-ed1-f69.google.com with SMTP id
 cf15-20020a0564020b8f00b0040284b671c6so4184255edb.22
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jan 2022 15:13:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=poL37lSy5yu+pXxIBkPJdf1QhhjhrG0y8WyJPB/Gac4=;
 b=N/32nBqVttwp3L5p3s4Y5CbEosXWEG3d0hGGg9YDXQbakEdPcNAnYthccxKgYMm4Kr
 riAdz5Bi2RWZDfhGNRsEM1/2Ac0FXXNLj805tJceXEntAjVn0g9luLwu0SwhIFtoHg4g
 UW8jUc2QKeTU+M3EHGJZ05VGxa5Vz3lb5rMnnWbbWUD++79CeB+OOjqJilOHmjWcPhJt
 SW9z3vlAEQm6itZxyrCV9KKcxrpdKOJJEXVL/xbhXiREY7illu9shYlzKE8edogNxBRv
 nWHTs7waPGY6lByKybb6f9wPU9dtvn8C+U7zp8pNZ1a5z1h18ytEH2yK111emrOwj2QL
 WZ7w==
X-Gm-Message-State: AOAM531Oq+5BBZIdGD9nqSH2QFAiKjCWUosycJHdqc53NqNp4jvQYtVw
 iTlgzTMlNQH8i/uDXhSlq9Lumc1xhflqomkWsUsw8r8Mrh2hjklK/MpvzH8lbUQuLcrgPsfRCkK
 oD0LvL56xVMOaYkFrLp3j1EgSV8dDHo3Wuhl6+oO9rw==
X-Received: by 2002:a05:6402:154:: with SMTP id
 s20mr23540996edu.148.1642461236858; 
 Mon, 17 Jan 2022 15:13:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzLNJ+H3FJlkh2+Vfrf2XL670LwjFEEh5msW25BJKoOSxrD9zY3tXrjLznoSEqqi27F14Jz0A==
X-Received: by 2002:a05:6402:154:: with SMTP id
 s20mr23540987edu.148.1642461236725; 
 Mon, 17 Jan 2022 15:13:56 -0800 (PST)
Received: from redhat.com ([2.55.154.241])
 by smtp.gmail.com with ESMTPSA id p25sm6417354edw.75.2022.01.17.15.13.52
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jan 2022 15:13:54 -0800 (PST)
Date: Mon, 17 Jan 2022 18:13:49 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Cornelia Huck <cohuck@redhat.com>
Subject: Re: [PATCH] virtio: acknowledge all features before access
Message-ID: <20220117181318-mutt-send-email-mst@kernel.org>
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
dGhlIGNhbGxiYWNrIGEgYmV0dGVyIG5hbWUKPiBjYW4gYmUgYSBmb2xsb3ctdXAgcGF0Y2guCgoK
U291bmRzIGxpa2UgYSBnb29kIGlkZWEuIEkgY2FuIGFsc28gZG9jdW1lbnQgdGhhdCBuZWFyCnZp
cnRpb19maW5hbGl6ZV9mZWF0dXJlcy4KCj4gPgo+ID4+ID4gKwo+ID4+ID4gICAJcmV0ID0gdmly
dGlvX2ZpbmFsaXplX2ZlYXR1cmVzKGRldik7Cj4gPj4gPiAgIAlpZiAocmV0KQo+ID4+ID4gICAJ
CWdvdG8gZXJyOwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4
LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFu
L2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
