Return-Path: <SRS0=st/B=FW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D69AC4361B
	for <virtualization@archiver.kernel.org>; Fri, 18 Dec 2020 11:38:31 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AFC9023A51
	for <virtualization@archiver.kernel.org>; Fri, 18 Dec 2020 11:38:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AFC9023A51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 5C0CD878C1;
	Fri, 18 Dec 2020 11:38:30 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id sdbJCM4W7xRM; Fri, 18 Dec 2020 11:38:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id A5D99878BD;
	Fri, 18 Dec 2020 11:38:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 78CE2C1786;
	Fri, 18 Dec 2020 11:38:29 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7C176C0893
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Dec 2020 11:38:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id 62F6B879B3
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Dec 2020 11:38:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id CHZ44KkjupjA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Dec 2020 11:38:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id CC94C8798B
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Dec 2020 11:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1608291504;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=pyrPuPaxt/+ULQwnKy518EjPiNWx6UpiJp5ti3eLczU=;
 b=Rse+xX+L5WOjK8SKtIgpimbn+pKjLF7wTLoJ8hwkRWFq4c7LZ74I3XlZ4n1MJrbsVRsNA6
 xfvBN08yctkeKuMho8hVoddXUVgviMG3jzwFXfP7gcRA7If+f42oHgDJh2+R4f9NnkZp0W
 IdHkYxq8g7aWEuOkVet0tT1NT1JZEjI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-jm2z-dSIOnSG39bMx9UV-w-1; Fri, 18 Dec 2020 06:38:20 -0500
X-MC-Unique: jm2z-dSIOnSG39bMx9UV-w-1
Received: by mail-wr1-f71.google.com with SMTP id g16so1063808wrv.1
 for <virtualization@lists.linux-foundation.org>;
 Fri, 18 Dec 2020 03:38:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=pyrPuPaxt/+ULQwnKy518EjPiNWx6UpiJp5ti3eLczU=;
 b=cFeLyygEP2sz1KuticVYS+MDhCiIzBYZKOkqr7S8cnBdQTPX6GEF9kVmq1BOv5XG1k
 4Y5LmxAOdWrpK6t9CSkb0P4zw3/wzCpqSgxF8QkXhkX7v6vlqG4aYIROMOlnoLAigAbb
 LNKOMdN9DBfhWVQtzNMsUM0a6Pso7ogW2A7pqB6P6NCnOg+FLMp77/9hpkJSqcLJrxwL
 Tqyl3kpuNdbBpX22kmEkaNCiRq56tEbLOFFke5nFnO8M2oEd3D0wlpFOVQdhfqtKMeiV
 gEvQMjUl/0VH0JxnH7Q7gbjwZ/XR3xrLq0BjVDnkRLAOMso2GNt5GBteYrVUkNo4IBVt
 SG1A==
X-Gm-Message-State: AOAM530b4jczEm0yGE2WzKBnXABY1SfxDzyHG4+u3+033YZ+ilCd/luH
 G2sJHimW9F1C09U2dOFawgpO7SAsIKKKGITH03P6jG0L9YM2dgpBSmRsp3zK977BpEqoo5FGvC7
 RzB1lmRKMZwKfsERGPWSJbcz+woVp3mw0D24wwpKwxQ==
X-Received: by 2002:a1c:9c52:: with SMTP id f79mr3844507wme.3.1608291499368;
 Fri, 18 Dec 2020 03:38:19 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzukL6Prl59FigQna6+aohMdU4wEFXfPaVe/UPsJdUR7FnJxLK1fC8EtDnc3DzTPCIG/QswiQ==
X-Received: by 2002:a1c:9c52:: with SMTP id f79mr3844480wme.3.1608291499121;
 Fri, 18 Dec 2020 03:38:19 -0800 (PST)
Received: from steredhat (host-79-13-204-15.retail.telecomitalia.it.
 [79.13.204.15])
 by smtp.gmail.com with ESMTPSA id c4sm12126404wmf.19.2020.12.18.03.38.17
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 18 Dec 2020 03:38:18 -0800 (PST)
Date: Fri, 18 Dec 2020 12:38:16 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC 00/12] vdpa: generalize vdpa simulator and add block
 device
Message-ID: <20201218113816.zcyeyqipux4ao4cp@steredhat>
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
ZXJyb3I6IC0xNCBvZmZzZXQ6IAo+PiAgIDB4Mjg0MDAwMCBsZW46IDB4MjAwMDAKPj4gICB2aXJ0
aW9fdmRwYSB2ZHBhMDogdnJpbmdoX2lvdl9wdWxsX2lvdGxiKCkgZXJyb3I6IC0xNCBvZmZzZXQ6
IAo+PiAgIDB4NThlZTAwMCBsZW46IDB4MzAwMAo+Pgo+PlRoZXNlIGVycm9ycyBzaG91bGQgYWxs
IGJlIHJlbGF0ZWQgdG8gdGhlIGZhY3QgdGhhdCBpb3RsYl90cmFuc2xhdGUoKQo+PmZhaWxzIHdp
dGggLUVJTlZBTCwgc28gaXQgc2VlbXMgdGhhdCB3ZSBtaXNzIHNvbWUgbWFwcGluZy4KPgo+Cj5J
cyB0aGlzIG9ubHkgcmVwcm9kdWNpYmxlIHdoZW4gdGhlcmUncyBtdWx0aXBsZSBjby1jdXJyZW50
IGFjY2Vzc2luZyAKPm9mIElPVExCPyBJZiB5ZXMsIGl0J3MgcHJvYmFibHkgYSBoaW50IHRoYXQg
c29tZSBraW5kIG9mIAo+c3luY2hyb25pemF0aW9uIGlzIHN0aWxsIG1pc3NlZCBzb21ld2hlcmUu
Cj4KPkl0IG1pZ2h0IGJlIHVzZWZ1bCB0byBsb2cgdGhlIGRtYV9tYXAvdW5tcCBpbiBib3RoIHZp
cnRpb19yaW5nIGFuZCAKPnZyaW5naCB0byBzZWUgd2hvIGlzIG1pc3NpbmcgdGhlIG1hcC4KPgoK
SnVzdCBhbiB1cGRhdGUgYWJvdXQgdGhlc2UgaXNzdWVzIHdpdGggdmRwYS1zaW0tYmxrLgpJJ3Zl
IGJlZW4gZm9jdXNpbmcgYSBsaXR0bGUgYml0IG9uIHRoZXNlIGZhaWx1cmVzIG92ZXIgdGhlIGxh
c3QgZmV3IGRheXMgCmFuZCBoYXZlIGZvdW5kIHR3byBpc3N1ZXMgcmVsYXRlZCB0byB0aGUgSU9U
TEIvSU9NTVU6CgoxLiBTb21lIHJlcXVlc3RzIGNvbWluZyBmcm9tIHRoZSBibG9jayBsYXllciBm
aWxscyB0aGUgU0cgbGlzdCB3aXRoIAptdWx0aXBsZSBidWZmZXJzIHRoYXQgaGFkIHRoZSBzYW1l
IHBoeXNpY2FsIGFkZHJlc3MuIFRoaXMgaGFwcGVucyBmb3IgCmV4YW1wbGUgd2hpbGUgdXNpbmcg
J21rZnMnLCBhdCBzb21lIHBvaW50cyBtdWx0aXBsZSBzZWN0b3JzIGFyZSB6ZXJvZWQgCnNvIG11
bHRpcGxlIFNHIGVsZW1lbnRzIHBvaW50IHRvIHRoZSBzYW1lIHBoeXNpY2FsIHBhZ2UgdGhhdCBp
cyB6ZXJvZWQuClNpbmNlIHdlIGFyZSB1c2luZyB2aG9zdF9pb3RsYl9kZWxfcmFuZ2UoKSBpbiB0
aGUgdmRwYXNpbV91bm1hcF9wYWdlKCksIAp0aGlzIHJlbW92ZXMgYWxsIHRoZSBvdmVybGFwcGVk
IHJhbmdlcy4gSSBmaXhlZCByZW1vdmluZyBhIHNpbmdsZSBtYXAgaW4gCnZkcGFzaW1fdW5tYXBf
cGFnZSgpLCBidXQgaGFzIGFuIGFsdGVybmF0aXZlIHdlIGNhbiBpbXBsZW1lbnQgc29tZSBraW5k
IApvZiByZWZlcmVuY2UgY291bnRzLgoKMi4gVGhlcmUgd2FzIGEgcmFjZSBiZXR3ZWVuIGRtYV9t
YXAvdW5tYXAgYW5kIHRoZSB3b3JrZXIgdGhyZWFkLCBzaW5jZSAKYm90aCBhcmUgYWNjZXNzaW5n
IHRoZSBJT01NVS4gVGFraW5nIHRoZSBpb21tdV9sb2NrIHdoaWxlIHVzaW5nIAp2aG9zdF9pb3Rs
Yl8qIEFQSSBpbiB0aGUgd29ya2VyIHRocmVhZCBmaXhlcyB0aGUgInZyaW5naDogRmFpbGVkIHRv
ICoiIAppc3N1ZXMuCgpXaGl0IHRoZXNlIGlzc3VlcyBmaXhlZCB0aGUgdmRwYS1ibGsgc2ltdWxh
dG9yIHNlZW1zIHRvIHdvcmsgd2VsbC4KSSdsbCBzZW5kIHRoZSBwYXRjaGVzIG5leHQgd2VlayBv
ciBhZnRlciB0aGUgYnJlYWsuCgpUaGFua3MsClN0ZWZhbm8KCl9fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApW
aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxp
bnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
