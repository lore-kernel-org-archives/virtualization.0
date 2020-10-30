Return-Path: <SRS0=7x/u=EF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 328BEC00A89
	for <virtualization@archiver.kernel.org>; Fri, 30 Oct 2020 16:19:51 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 54AB320719
	for <virtualization@archiver.kernel.org>; Fri, 30 Oct 2020 16:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WFoIKu8b"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 54AB320719
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id DB9AE868DC;
	Fri, 30 Oct 2020 16:19:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YGWo7aczuLcE; Fri, 30 Oct 2020 16:19:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 4626285C1D;
	Fri, 30 Oct 2020 16:19:49 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 15B04C088B;
	Fri, 30 Oct 2020 16:19:49 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id DEF17C0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 16:19:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id DA61F87400
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 16:19:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 2jDUhp2AvVbT
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 16:19:47 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 47886873D4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 16:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604074785;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=OcrYeen7idQg6fj59+qOuiD8Ij+RF++6T9svNJR2I70=;
 b=WFoIKu8bEgawaKpofPfpt75m424pwi8tumYuYah7rS1nkdbDkWlkA8KddGEXr/QQ5Xedum
 n+Ex1/aV7OWMViQvkjss2ByTB13kk49aMObzWY40/3jrF+ZMaBYqbOyrdoyOHbeihTvync
 cYJpC8APtle7r2TmC3DvVR2BlBlUOa8=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-349-DjrHUb2nPTOo_3BY5OtUEw-1; Fri, 30 Oct 2020 12:19:43 -0400
X-MC-Unique: DjrHUb2nPTOo_3BY5OtUEw-1
Received: by mail-wr1-f72.google.com with SMTP id x16so2825581wrg.7
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 09:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=OcrYeen7idQg6fj59+qOuiD8Ij+RF++6T9svNJR2I70=;
 b=TEUOxGesqXfw6uCi0gkWXzt2mcgmDYX2PazRJRJSGu/7yHunR0+jDcnzCca32FxDFp
 sbLyf0iMkGZy/PCm/ED8HLndBwMFcxpkSSI6abED9dT2WrMENvS3twzk271uX+lD6XXI
 ikiwADc0wBwjq+NFQJ9tElhB5nicfFrsh+S5Pt3QVhs3iGUP+aWPQ65IayZl3IkJzMhe
 iMC+H/9IAwM4pgqixJB1s5abCK4snQgjYbrZJQG77gOymBxbozHs9ojIBKWnNqiFe4Ge
 lQu8/PG4CerehtuDvD4v3A3QLsajAXyOWUju386llJ3CkNJkSOQ3GlBcbBd5LjxXoLAs
 s3ZA==
X-Gm-Message-State: AOAM5338WtLUPo56+pPO/mxGBYY0iQuiRnmXISlNCjWi1U9Z0Dqr8yUu
 FkSs4+QUhPXq0XSA6xEOxeTahKT67IQDpR6pXWCriF2CQ0TXxu2Gq7weJVfLh5DIRYC82wm6QYQ
 cnumXL6BtHQnqVhE/UQVbYOhYLfDzneT9Fv6ytDegRg==
X-Received: by 2002:a5d:420d:: with SMTP id n13mr4159701wrq.196.1604074781982; 
 Fri, 30 Oct 2020 09:19:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz+DKWtX/KpuvIKWLXpz4cbRsYAjyJQ2MhSo5RnPibttiUk+A4yTfvDUDF0AaH/EFGWlo/yNg==
X-Received: by 2002:a5d:420d:: with SMTP id n13mr4159679wrq.196.1604074781780; 
 Fri, 30 Oct 2020 09:19:41 -0700 (PDT)
Received: from steredhat (host-79-22-200-33.retail.telecomitalia.it.
 [79.22.200.33])
 by smtp.gmail.com with ESMTPSA id o4sm11021368wrv.8.2020.10.30.09.19.40
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 30 Oct 2020 09:19:41 -0700 (PDT)
Date: Fri, 30 Oct 2020 17:19:38 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vhost/vsock: add IOTLB API support
Message-ID: <20201030161938.n7xqeu557dmsqpzv@steredhat>
References: <20201029174351.134173-1-sgarzare@redhat.com>
 <751cc074-ae68-72c8-71de-a42458058761@redhat.com>
 <20201030105422.ju2aj2bmwsckdufh@steredhat>
 <278f4732-e561-2b4f-03ee-b26455760b01@redhat.com>
MIME-Version: 1.0
In-Reply-To: <278f4732-e561-2b4f-03ee-b26455760b01@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>
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

T24gRnJpLCBPY3QgMzAsIDIwMjAgYXQgMDc6NDQ6NDNQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMC8xMC8zMCDkuIvljYg2OjU0LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6
Cj4+T24gRnJpLCBPY3QgMzAsIDIwMjAgYXQgMDY6MDI6MThQTSArMDgwMCwgSmFzb24gV2FuZyB3
cm90ZToKPj4+Cj4+Pk9uIDIwMjAvMTAvMzAg5LiK5Y2IMTo0MywgU3RlZmFubyBHYXJ6YXJlbGxh
IHdyb3RlOgo+Pj4+VGhpcyBwYXRjaCBlbmFibGVzIHRoZSBJT1RMQiBBUEkgc3VwcG9ydCBmb3Ig
dmhvc3QtdnNvY2sgZGV2aWNlcywKPj4+PmFsbG93aW5nIHRoZSB1c2Vyc3BhY2UgdG8gZW11bGF0
ZSBhbiBJT01NVSBmb3IgdGhlIGd1ZXN0Lgo+Pj4+Cj4+Pj5UaGVzZSBjaGFuZ2VzIHdlcmUgbWFk
ZSBmb2xsb3dpbmcgdmhvc3QtbmV0LCBpbiBkZXRhaWxzIHRoaXMgcGF0Y2g6Cj4+Pj4tIGV4cG9z
ZXMgVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JNIGZlYXR1cmUgYW5kIGluaXRzIHRoZSBpb3RsYgo+
Pj4+wqAgZGV2aWNlIGlmIHRoZSBmZWF0dXJlIGlzIGFja2VkCj4+Pj4tIGltcGxlbWVudHMgVkhP
U1RfR0VUX0JBQ0tFTkRfRkVBVFVSRVMgYW5kCj4+Pj7CoCBWSE9TVF9TRVRfQkFDS0VORF9GRUFU
VVJFUyBpb2N0bHMKPj4+Pi0gY2FsbHMgdnFfbWV0YV9wcmVmZXRjaCgpIGJlZm9yZSB2cSBwcm9j
ZXNzaW5nIHRvIHByZWZldGNoIHZxCj4+Pj7CoCBtZXRhZGF0YSBhZGRyZXNzIGluIElPVExCCj4+
Pj4tIHByb3ZpZGVzIC5yZWFkX2l0ZXIsIC53cml0ZV9pdGVyLCBhbmQgLnBvbGwgY2FsbGJhY2tz
IGZvciB0aGUKPj4+PsKgIGNoYXJkZXY7IHRoZXkgYXJlIHVzZWQgYnkgdGhlIHVzZXJzcGFjZSB0
byBleGNoYW5nZSBJT1RMQiBtZXNzYWdlcwo+Pj4+Cj4+Pj5UaGlzIHBhdGNoIHdhcyB0ZXN0ZWQg
d2l0aCBRRU1VIGFuZCBhIHBhdGNoIGFwcGxpZWQgWzFdIHRvIGZpeCBhCj4+Pj5zaW1wbGUgaXNz
dWU6Cj4+Pj7CoMKgwqAgJCBxZW11IC1NIHEzNSxhY2NlbD1rdm0sa2VybmVsLWlycWNoaXA9c3Bs
aXQgXAo+Pj4+wqDCoMKgwqDCoMKgwqDCoMKgwqAgLWRyaXZlIGZpbGU9ZmVkb3JhLnFjb3cyLGZv
cm1hdD1xY293MixpZj12aXJ0aW8gXAo+Pj4+wqDCoMKgwqDCoMKgwqDCoMKgwqAgLWRldmljZSBp
bnRlbC1pb21tdSxpbnRyZW1hcD1vbiBcCj4+Pj7CoMKgwqDCoMKgwqDCoMKgwqDCoCAtZGV2aWNl
IHZob3N0LXZzb2NrLXBjaSxndWVzdC1jaWQ9Myxpb21tdV9wbGF0Zm9ybT1vbgo+Pj4KPj4+Cj4+
PlBhdGNoIGxvb2tzIGdvb2QsIGJ1dCBhIHF1ZXN0aW9uOgo+Pj4KPj4+SXQgbG9va3MgdG8gbWUg
eW91IGRvbid0IGVuYWJsZSBBVFMgd2hpY2ggbWVhbnMgdmhvc3Qgd29uJ3QgZ2V0IAo+Pj5hbnkg
aW52YWxpZGF0aW9uIHJlcXVlc3Qgb3IgZGlkIEkgbWlzcyBhbnl0aGluZz8KPj4+Cj4+Cj4+WW91
J3JlIHJpZ2h0LCBJIGRpZG4ndCBzZWUgaW52YWxpZGF0aW9uIHJlcXVlc3RzLCBvbmx5IG1pc3Mg
YW5kIHVwZGF0ZXMuCj4+Tm93IEkgaGF2ZSB0cmllZCB0byBlbmFibGUgJ2F0cycgYW5kICdkZXZp
Y2UtaW90bGInIGJ1dCBJIHN0aWxsIAo+PmRvbid0IHNlZSBhbnkgaW52YWxpZGF0aW9uLgo+Pgo+
PkhvdyBjYW4gSSB0ZXN0IGl0PyAoU29ycnkgYnV0IEkgZG9uJ3QgaGF2ZSBtdWNoIGV4cGVyaWVu
Y2UgeWV0IHdpdGggCj4+dklPTU1VKQo+Cj4KPkkgZ3Vlc3MgaXQncyBiZWNhdXNlIHRoZSBiYXRj
aGVkIHVubWFwLiBNYXliZSB5b3UgY2FuIHRyeSB0byB1c2UgCj4iaW50ZWxfaW9tbXU9c3RyaWN0
IiBpbiBndWVzdCBrZXJuZWwgY29tbWFuZCBsaW5lIHRvIHNlZSBpZiBpdCB3b3Jrcy4KPgo+QnR3
LCBtYWtlIHN1cmUgdGhlIHFlbXUgY29udGFpbnMgdGhlIHBhdGNoIFsxXS4gT3RoZXJ3aXNlIEFU
UyB3b24ndCBiZSAKPmVuYWJsZWQgZm9yIHJlY2VudCBMaW51eCBLZXJuZWwgaW4gdGhlIGd1ZXN0
Lgo+CgpJIHRyaWVkIHdpdGggImludGVsX2lvbW11PXN0cmljdCIgaW4gdGhlIGd1ZXN0IGtlcm5l
bCBhbmQgUUVNVSBwYXRjaCAKYXBwbGllZCwgYnV0IEkgZGlkbid0IHNlZSBhbnkgaW52YWxpZGF0
aW9uLgoKTWF5YmUgSSBkaWQgc29tZXRoaW5nIHdyb25nLCB5b3Uga25vdyBpdCBpcyBmcmlkYXks
IEtWTSBGb3J1bSBpcyBlbmRpbmcsIApldGMuLi4gOy0pCgpJJ2xsIGludmVzdGlnYXRlIGJldHRl
ciBuZXh0IHdlZWsuCgpUaGFua3MgZm9yIHRoZSB1c2VmdWwgaW5mbywKU3RlZmFubwoKX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24g
bWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0
dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxp
emF0aW9u
