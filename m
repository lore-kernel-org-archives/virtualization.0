Return-Path: <SRS0=RKVt=P5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B6AFC433EF
	for <virtualization@archiver.kernel.org>; Wed, 10 Nov 2021 10:50:17 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C8CCE611AD
	for <virtualization@archiver.kernel.org>; Wed, 10 Nov 2021 10:50:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org C8CCE611AD
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 95A1A80C42;
	Wed, 10 Nov 2021 10:50:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id ENM5ZhLYrFzS; Wed, 10 Nov 2021 10:50:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 51DAF80C6E;
	Wed, 10 Nov 2021 10:50:15 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0FEEEC0019;
	Wed, 10 Nov 2021 10:50:15 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 418C4C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 10:50:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2393080C6E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 10:50:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id U6uMMgo0HRQg
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 10:50:13 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4FDAC80C4E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 10:50:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1636541412;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=xQFWW+sZksZzHviyH2TW0kFMCVfkj3PR573FB0zLgno=;
 b=OGPHSBN4r1dDEeRGvmP3u2bT4TUPN1L5PAZPaU6BVj1z4CMqmU83JXfJ3TXHX25GtoJ2+p
 e3GrIirazMjAZT82sOb/PZCSE1nBvYF2NmhYW+P5SAqxmfXG4QOW5IlWP6eaShK/APRd8r
 6ARWk7xpsMytE8jlbhhBsPX2NDizIVw=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-279-RDV_Myz0MrWHtY1BilgFww-1; Wed, 10 Nov 2021 05:50:10 -0500
X-MC-Unique: RDV_Myz0MrWHtY1BilgFww-1
Received: by mail-ed1-f69.google.com with SMTP id
 w12-20020a056402268c00b003e2ab5a3370so2031466edd.0
 for <virtualization@lists.linux-foundation.org>;
 Wed, 10 Nov 2021 02:50:09 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=xQFWW+sZksZzHviyH2TW0kFMCVfkj3PR573FB0zLgno=;
 b=qI9TpuCrkYpNpD+ttsBz/ZowOIbGMmMYKxaycrU0VylDyrT4xfUIzTZc7Mw9r8Krc/
 2n+4SWRd9wMLpQ6+qq5P2TfFBGgRuYqeBFydx6UrJeFaC6UJN0Jfnc8g1s8T/DSkt21k
 nGtG6N0RMqN/+YGek6pjsluFE1reo6ewgZwFa5us8RBtIegW5X74XtuXpftwJr8MLPkP
 3O4lQHUSDx0heyObF7TbeSOm9nGQhmAXBrstVhXc6w0duZXYr/jCGRZduh3vrcQrRG7k
 w81BcPmm5bXBIlaJxfziy8o2TznlnJKUM5k1coQwsOnbsMd9dkNC4dikgjYwQVxR4Csx
 3nww==
X-Gm-Message-State: AOAM531sdLGhlWWS/XSK9qY3vEPB4DM+OoPTQhkmt2PIWQnLud3caMYU
 nfDkwc8e7n5tk0g4WUli9AK20zQ0sgsoiDoXJ2ghhdiKCMmvVCDAxFA5O7mR8lhRwydr8b76ZjU
 2ND0i7eRW4UKRuM+a59qioQ/9hiKtO+SHBs5lEnVHLQ==
X-Received: by 2002:a05:6402:50d4:: with SMTP id
 h20mr20019864edb.80.1636541408865; 
 Wed, 10 Nov 2021 02:50:08 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxeT1zDnGo3NXhEoFr9pMWu5dF4RmCmR5eGCjSrmvQE09ovJLCuK0RgjGQCXT9xOJaoYx2OdQ==
X-Received: by 2002:a05:6402:50d4:: with SMTP id
 h20mr20019833edb.80.1636541408669; 
 Wed, 10 Nov 2021 02:50:08 -0800 (PST)
Received: from redhat.com ([2.55.133.41])
 by smtp.gmail.com with ESMTPSA id cw20sm10928049ejc.32.2021.11.10.02.50.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 10 Nov 2021 02:50:07 -0800 (PST)
Date: Wed, 10 Nov 2021 05:50:04 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Wang, Wei W" <wei.w.wang@intel.com>
Subject: Re: [RFC] hypercall-vsock: add a new vsock transport
Message-ID: <20211110054121-mutt-send-email-mst@kernel.org>
References: <71d7b0463629471e9d4887d7fcef1d8d@intel.com>
MIME-Version: 1.0
In-Reply-To: <71d7b0463629471e9d4887d7fcef1d8d@intel.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "Yamahata, Isaku" <isaku.yamahata@intel.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
 "Kleen, Andi" <andi.kleen@intel.com>, "kuba@kernel.org" <kuba@kernel.org>,
 "davem@davemloft.net" <davem@davemloft.net>
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

T24gV2VkLCBOb3YgMTAsIDIwMjEgYXQgMDc6MTI6MzZBTSArMDAwMCwgV2FuZywgV2VpIFcgd3Jv
dGU6Cj4gSGksCj4gCj4gIAo+IAo+IFdlIHBsYW4gdG8gYWRkIGEgbmV3IHZzb2NrIHRyYW5zcG9y
dCBiYXNlZCBvbiBoeXBlcmNhbGwgKGUuZy4gdm1jYWxsIG9uIEludGVsCj4gQ1BVcykuCj4gCj4g
SXQgdHJhbnNwb3J0cyBBRl9WU09DSyBwYWNrZXRzIGJldHdlZW4gdGhlIGd1ZXN0IGFuZCBob3N0
LCB3aGljaCBpcyBzaW1pbGFyIHRvCj4gCj4gdmlydGlvLXZzb2NrLCB2bWNpLXZzb2NrIGFuZCBo
eXBlcnYtdnNvY2suCj4gCj4gIAo+IAo+IENvbXBhcmVkIHRvIHRoZSBhYm92ZSBsaXN0ZWQgdnNv
Y2sgdHJhbnNwb3J0cyB3aGljaCBhcmUgZGVzaWduZWQgZm9yIGhpZ2gKPiBwZXJmb3JtYW5jZSwK
PiAKPiB0aGUgbWFpbiBhZHZhbnRhZ2VzIG9mIGh5cGVyY2FsbC12c29jayBhcmU6Cj4gCj4gMSkg
ICAgICAgSXQgaXMgVk1NIGFnbm9zdGljLiBGb3IgZXhhbXBsZSwgb25lIGd1ZXN0IHdvcmtpbmcg
b24gaHlwZXJjYWxsLXZzb2NrCj4gY2FuIHJ1biBvbgo+IAo+IGVpdGhlciBLVk0sIEh5cGVydiwg
b3IgVk13YXJlLgoKaHlwZXJjYWxscyBhcmUgZnVuZGFtZW50YWxseSBoeXBlcnZpc29yIGRlcGVu
ZGVudCB0aG91Z2guCkFzc3VtaW5nIHlvdSBjYW4gY2FydmUgdXAgYSBoeXBlcnZpc29yIGluZGVw
ZW5kZW50IGh5cGVyY2FsbCwKdXNpbmcgaXQgZm9yIHNvbWV0aGluZyBhcyBtdW5kYW5lIGFuZCBz
cGVjaWZpYyBhcyB2c29jayBmb3IgVERYCnNlZW1zIGxpa2UgYSBodWdlIG92ZXJraWxsLiBGb3Ig
ZXhhbXBsZSwgdmlydGlvIGNvdWxkIGJlbmVmaXQgZnJvbQpmYXN0ZXIgdm1leGl0cyB0aGF0IGh5
cGVyY2FsbHMgZ2l2ZSB5b3UgZm9yIHNpZ25hbGxpbmcuCkhvdyBhYm91dCBhIGNvbWJpbmF0aW9u
IG9mIHZpcnRpby1tbWlvIGFuZCBoeXBlcmNhbGxzIGZvciBmYXN0LXBhdGgKc2lnbmFsbGluZyB0
aGVuPwoKPiAyKSAgICAgICBJdCBpcyBzaW1wbGVyLiBJdCBkb2VzbuKAmXQgcmVseSBvbiBhbnkg
Y29tcGxleCBidXMgZW51bWVyYXRpb24KPiAKPiAoZS5nLiB2aXJ0aW8tcGNpIGJhc2VkIHZzb2Nr
IGRldmljZSBtYXkgbmVlZCB0aGUgd2hvbGUgaW1wbGVtZW50YXRpb24gb2YgUENJKS4KPiAKCk5l
eHQgdGhpbmcgcGVvcGxlIHdpbGwgdHJ5IHRvIGRvIGlzIGltcGxlbWVudCBhIGJ1bmNoIG9mIG90
aGVyIGRldmljZSBvbgp0b3Agb2YgaXQuICB2aXJ0aW8gdXNlZCBwY2kgc2ltcGx5IGJlY2F1c2Ug
ZXZlcnlvbmUgaW1wbGVtZW50cyBwY2kuICBBbmQKdGhlIHJlYXNvbiBmb3IgKnRoYXQqIGlzIGJl
Y2F1c2UgaW1wbGVtZW50aW5nIGEgYmFzaWMgcGNpIGJ1cyBpcyBkZWFkCnNpbXBsZSwgd2hvbGUg
b2YgcGNpLmMgaW4gcWVtdSBpcyA8MzAwMCBMT0MuCgo+IAo+IEFuIGV4YW1wbGUgdXNhZ2UgaXMg
dGhlIGNvbW11bmljYXRpb24gYmV0d2VlbiBNaWdURCBhbmQgaG9zdCAoUGFnZSA4IGF0Cj4gCj4g
aHR0cHM6Ly9zdGF0aWMuc2NoZWQuY29tL2hvc3RlZF9maWxlcy9rdm1mb3J1bTIwMjEvZWYvCj4g
VERYJTIwTGl2ZSUyME1pZ3JhdGlvbl9XZWklMjBXYW5nLnBkZikuCj4gCj4gTWlnVEQgY29tbXVu
aWNhdGVzIHRvIGhvc3QgdG8gYXNzaXN0IHRoZSBtaWdyYXRpb24gb2YgdGhlIHRhcmdldCAodXNl
cikgVEQuCj4gCj4gTWlnVEQgaXMgcGFydCBvZiB0aGUgVENCLCBzbyBpdHMgaW1wbGVtZW50YXRp
b24gaXMgZXhwZWN0ZWQgdG8gYmUgYXMgc2ltcGxlIGFzCj4gcG9zc2libGUKPiAKPiAoZS5nLiBi
YXJlIG1lbnRhbCBpbXBsZW1lbnRhdGlvbiB3aXRob3V0IE9TLCBubyBQQ0kgZHJpdmVyIHN1cHBv
cnQpLgo+IAo+ICAKClRyeSB0byBsaXN0IGRyYXdiYWNrcz8gRm9yIGV4YW1wbGUsIHBhc3N0aHJv
dWdoIGZvciBuZXN0ZWQgdmlydAppc24ndCBwb3NzaWJsZSB1bmxpa2UgcGNpLCBuZWl0aGVyIGFy
ZSBoYXJkd2FyZSBpbXBsZW1lbnRhdGlvbnMuCgoKPiBMb29raW5nIGZvcndhcmQgdG8geW91ciBm
ZWVkYmFja3MuCj4gCj4gIAo+IAo+IFRoYW5rcywKPiAKPiBXZWkKPiAKCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
