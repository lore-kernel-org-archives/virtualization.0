Return-Path: <SRS0=Nqfw=EW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6EAA3C4742C
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 08:53:23 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D833F22240
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 08:53:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MfkK3ERd"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D833F22240
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 4E558867EC;
	Mon, 16 Nov 2020 08:53:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 6MCGJErFLFpk; Mon, 16 Nov 2020 08:53:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 7D23D86256;
	Mon, 16 Nov 2020 08:53:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5DFADC0800;
	Mon, 16 Nov 2020 08:53:21 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 14D61C07FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 08:53:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 0FDCB8672F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 08:53:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 1vXMeW4+O+YA
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 08:53:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 1E32F86256
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 08:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605516797;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=azmEdku+v957nDfLerEj6eIbgCibvT//LlaEDmIrd4c=;
 b=MfkK3ERdOdFJ2vaWS8btYevViEUV2+TgJYZ0nX35Dnd+pTs2oN5rl94tJWO3GJA3nUnkBT
 y/xgo9BOLkMP5n33YhayX4IqHfCa3kioAVF0IErMhrbHYw6Coov9KIWDgslCLdP9aHGo4F
 ZS62ejaYqk9zPpd9OjFyWnsjPqNrhvA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-417-ANWpSwpVPAqN15YvpkziLw-1; Mon, 16 Nov 2020 03:53:16 -0500
X-MC-Unique: ANWpSwpVPAqN15YvpkziLw-1
Received: by mail-wr1-f72.google.com with SMTP id l5so10762373wrn.18
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 00:53:16 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=azmEdku+v957nDfLerEj6eIbgCibvT//LlaEDmIrd4c=;
 b=tmp9HivIpYfWLsAzAMWK4n5+rciufIwkgW24o5ZJa/8ILJEOddxpr51o3laHjb98DO
 ODFdVRCW2JbMtb+8HYnIzjg8LSRWdVFhqAL0VFoGP/7Vxp9e0H5ZNby48U5t7YTBELTi
 y4i+St/b550dczmJfeFJfCt/ojTg7KpM0DiuVlZ4nHc3jhpr+DFU6g2Yix3HgAEaIjWi
 novXvoA9n+fAilRG/7Nm6q7ZdzQtYapIpyxx0p6A33j+VYTtI4UP402FGqh0MaVox1W9
 6llhbWj0wSuXx/W0Xv6IEsjkWGca2jOrID1j04an1q5LNR7NeCrF36jgOBfd109vAy/Q
 kqDQ==
X-Gm-Message-State: AOAM5315gGgoYCzrh2v2/AKRP1gyMOQsocvKZ3FPHJkIBaYNRqHY3GJb
 7vovI3bM+DHFRdir6vG3Tjp/OP4r1jzA0BfmqFUuTapP7UR3HrcO9hLcg4jl/lRj7pAxOXN/jNn
 nnVpP+InZryivbHg2ojeYMkvIHJ6flJO0DqnX3mjxJg==
X-Received: by 2002:adf:8030:: with SMTP id 45mr18011631wrk.407.1605516795092; 
 Mon, 16 Nov 2020 00:53:15 -0800 (PST)
X-Google-Smtp-Source: ABdhPJz5n/AE2nQyDKnmQoyCVlmIjPAbEsArXe/3Q5hcir6iosfRJevDexRLbmoqU1yU9ow+HAnSAQ==
X-Received: by 2002:adf:8030:: with SMTP id 45mr18011610wrk.407.1605516794887; 
 Mon, 16 Nov 2020 00:53:14 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it.
 [79.17.248.175])
 by smtp.gmail.com with ESMTPSA id u5sm17132310wro.56.2020.11.16.00.53.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 00:53:13 -0800 (PST)
Date: Mon, 16 Nov 2020 09:53:11 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC 00/12] vdpa: generalize vdpa simulator and add block
 device
Message-ID: <20201116085311.erzo2z322qesw5in@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <93f207c0-61e6-3696-f218-e7d7ea9a7c93@redhat.com>
MIME-Version: 1.0
In-Reply-To: <93f207c0-61e6-3696-f218-e7d7ea9a7c93@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>
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

T24gTW9uLCBOb3YgMTYsIDIwMjAgYXQgMTE6Mzc6NDhBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMC8xMS8xMyDkuIvljYg5OjQ3LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6
Cj4+VGhhbmtzIHRvIE1heCB0aGF0IHN0YXJ0ZWQgdGhpcyB3b3JrIQo+PkkgdG9vayBoaXMgcGF0
Y2hlcywgYW5kIGV4dGVuZGVkIHRoZSBibG9jayBzaW11bGF0b3IgYSBiaXQuCj4+Cj4+VGhpcyBz
ZXJpZXMgbW92ZXMgdGhlIG5ldHdvcmsgZGV2aWNlIHNpbXVsYXRvciBpbiBhIG5ldyBtb2R1bGUK
Pj4odmRwYV9zaW1fbmV0KSBhbmQgbGVhdmVzIHRoZSBnZW5lcmljIGZ1bmN0aW9ucyBpbiB0aGUg
dmRwYV9zaW0gY29yZQo+Pm1vZHVsZSwgYWxsb3dpbmcgdGhlIHBvc3NpYmlsaXR5IHRvIGFkZCBu
ZXcgdkRQQSBkZXZpY2Ugc2ltdWxhdG9ycy4KPj5UaGVuIHdlIGFkZGVkIGEgbmV3IHZkcGFfc2lt
X2JsayBtb2R1bGUgdG8gc2ltdWxhdGUgYSBibG9jayBkZXZpY2UuCj4+Cj4+SSdtIG5vdCBzdXJl
IGFib3V0IHBhdGNoIDExICgidnJpbmdoOiBhbGxvdyB2cmluZ2hfaW92X3hmZXIoKSB0byBza2lw
Cj4+Ynl0ZXMgd2hlbiBwdHIgaXMgTlVMTCIpLCBtYXliZSB3ZSBjYW4gYWRkIGEgbmV3IGZ1bmN0
aW9ucyBpbnN0ZWFkIG9mCj4+bW9kaWZ5IHZyaW5naF9pb3ZfeGZlcigpLgo+Pgo+PkFzIE1heCBy
ZXBvcnRlZCwgSSdtIGFsc28gc2VlaW5nIGVycm9ycyB3aXRoIHZkcGFfc2ltX2JsayByZWxhdGVk
IHRvCj4+aW90bGIgYW5kIHZyaW5naCB3aGVuIHRoZXJlIGlzIGhpZ2ggbG9hZCwgdGhlc2UgYXJl
IHNvbWUgb2YgdGhlIGVycm9yCj4+bWVzc2FnZXMgSSBjYW4gc2VlIHJhbmRvbWx5Ogo+Pgo+PiAg
IHZyaW5naDogRmFpbGVkIHRvIGFjY2VzcyBhdmFpbCBpZHggYXQgMDAwMDAwMDBlOGRlYjJjYwo+
PiAgIHZyaW5naDogRmFpbGVkIHRvIHJlYWQgaGVhZDogaWR4IDYyODkgYWRkcmVzcyAwMDAwMDAw
MGUxYWQxZDUwCj4+ICAgdnJpbmdoOiBGYWlsZWQgdG8gZ2V0IGZsYWdzIGF0IDAwMDAwMDAwNjYz
NWQ3YTMKPj4KPj4gICB2aXJ0aW9fdmRwYSB2ZHBhMDogdnJpbmdoX2lvdl9wdXNoX2lvdGxiKCkg
ZXJyb3I6IC0xNCBvZmZzZXQ6IDB4Mjg0MDAwMCBsZW46IDB4MjAwMDAKPj4gICB2aXJ0aW9fdmRw
YSB2ZHBhMDogdnJpbmdoX2lvdl9wdWxsX2lvdGxiKCkgZXJyb3I6IC0xNCBvZmZzZXQ6IDB4NThl
ZTAwMCBsZW46IDB4MzAwMAo+Pgo+PlRoZXNlIGVycm9ycyBzaG91bGQgYWxsIGJlIHJlbGF0ZWQg
dG8gdGhlIGZhY3QgdGhhdCBpb3RsYl90cmFuc2xhdGUoKQo+PmZhaWxzIHdpdGggLUVJTlZBTCwg
c28gaXQgc2VlbXMgdGhhdCB3ZSBtaXNzIHNvbWUgbWFwcGluZy4KPgo+Cj5JcyB0aGlzIG9ubHkg
cmVwcm9kdWNpYmxlIHdoZW4gdGhlcmUncyBtdWx0aXBsZSBjby1jdXJyZW50IGFjY2Vzc2luZyAK
Pm9mIElPVExCPyBJZiB5ZXMsIGl0J3MgcHJvYmFibHkgYSBoaW50IHRoYXQgc29tZSBraW5kIG9m
IAo+c3luY2hyb25pemF0aW9uIGlzIHN0aWxsIG1pc3NlZCBzb21ld2hlcmUuCgpZZWFoLCBtYXli
ZSB0aGlzIGlzIHRoZSBjYXNlIHdoZXJlIHZpcnRpb19yaW5nIGFuZCB2cmluZ2ggdXNlIElPVExC
IApjb25jb3JyZW50ZXRpdmVseS4KCj4KPkl0IG1pZ2h0IGJlIHVzZWZ1bCB0byBsb2cgdGhlIGRt
YV9tYXAvdW5tcCBpbiBib3RoIHZpcnRpb19yaW5nIGFuZCAKPnZyaW5naCB0byBzZWUgd2hvIGlz
IG1pc3NpbmcgdGhlIG1hcC4KCkknbGwgdHJ5LgoKVGhhbmtzIGZvciB0aGUgaGludHMsClN0ZWZh
bm8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
