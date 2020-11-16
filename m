Return-Path: <SRS0=Nqfw=EW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BA6B5C5519F
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 11:49:06 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 265BB2224B
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 11:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="S+F9/FpA"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 265BB2224B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 7AAD0204C4;
	Mon, 16 Nov 2020 11:49:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y0x99o-zGJBt; Mon, 16 Nov 2020 11:49:04 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0C7E920488;
	Mon, 16 Nov 2020 11:49:04 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F28EEC0891;
	Mon, 16 Nov 2020 11:49:03 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id F39A7C07FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 11:49:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id EEE42867E8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 11:49:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id KFbRv372YdJV
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 11:49:02 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 36818863EE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 11:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605527341;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=97VmpTXAdtiBuZSpuvkK0VLB6Qe0uigxKEQsDu39lOA=;
 b=S+F9/FpAFG4ES2GMcjRpxk2YhHErebd0CvRFvSe8wZFjW22SXhB8UssaEJbUgIKWwvvz8L
 qo7l8FmPhx61Ks32WwSttf2fuH7mzjPgWDAS8q870KrhKqGak820TQrYN/wpD0fvAjbUcM
 mhpwUDLNJdJ++eKmGlzbEMn2Xz+hicM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-35_W-5CaPRekg-mw84hV4A-1; Mon, 16 Nov 2020 06:48:59 -0500
X-MC-Unique: 35_W-5CaPRekg-mw84hV4A-1
Received: by mail-wr1-f70.google.com with SMTP id v5so10954577wrr.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 03:48:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=97VmpTXAdtiBuZSpuvkK0VLB6Qe0uigxKEQsDu39lOA=;
 b=BI6p6imvm13ebvwqwy5ww/HnB1i7V+ubsnHcGp6QHlRuB/i/CqnApH6iPgRzR4CLd/
 dGFjmpMmeIGuorhjtUY+ZTFQgZTGx+2IMa+ceO+rncqk3QBr4oobi0c4qAcLqMbcuJnk
 l1J6iy4qhm3uJS58DcfnvAHqoHuIN+aE2Z5IaV5ql22edXeVAzYgyQesNzqhODhvqrWk
 ZlwxpmRPI87uBhL93W/gfnlVlwphiKeuHOetbl9t2HZtcDjjV6Omr4xLo15G9I17huBo
 iiXgHxrBuhsrfzDGUzMVcjtildG7ap2PiWVS6WuflI9E2vrRllopi9YKPtgP/k74lQGz
 zXig==
X-Gm-Message-State: AOAM532Kp4rQYDPPGg4uKJnLP5h8W1+rtqwu5z0e5LB6ysL24xJT0e01
 BcEygH5NUTbg6OEDCA4ryPeynp7PhTla+gxCVgjZ/wUX4+Ekqor+OOUHQZERFKv3+jxo6NNrVkT
 HmfGor7spoLK9X5tw1Jt/IcDzU9ewArL69DSODFpqRg==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr14797818wmc.173.1605527338070; 
 Mon, 16 Nov 2020 03:48:58 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzFOoFiy2XqLI4AaiwNdhMfhYIc4uTJT8KMlhnHiwhF1emha9fkhv6FOEox/VkGQR3P141RhA==
X-Received: by 2002:a1c:7215:: with SMTP id n21mr14797795wmc.173.1605527337866; 
 Mon, 16 Nov 2020 03:48:57 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it.
 [79.17.248.175])
 by smtp.gmail.com with ESMTPSA id g11sm22694417wrq.7.2020.11.16.03.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 03:48:57 -0800 (PST)
Date: Mon, 16 Nov 2020 12:48:54 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC 11/12] vringh: allow vringh_iov_xfer() to skip bytes
 when ptr is NULL
Message-ID: <20201116114854.5vrcjzsvhklpfeud@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-12-sgarzare@redhat.com>
 <a5cfe66f-5ae2-1a73-6010-74123721135b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <a5cfe66f-5ae2-1a73-6010-74123721135b@redhat.com>
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

T24gTW9uLCBOb3YgMTYsIDIwMjAgYXQgMTI6MzI6MDJQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMC8xMS8xMyDkuIvljYg5OjQ3LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6
Cj4+SW4gc29tZSBjYXNlcywgaXQgbWF5IGJlIHVzZWZ1bCB0byBwcm92aWRlIGEgd2F5IHRvIHNr
aXAgYSBudW1iZXIKPj5vZiBieXRlcyBpbiBhIHZyaW5naF9pb3YuCj4+Cj4+SW4gb3JkZXIgdG8g
a2VlcCB2cmluZ2hfaW92IGNvbnNpc3RlbnQsIGxldCdzIHJldXNlIHZyaW5naF9pb3ZfeGZlcigp
Cj4+bG9naWMgYW5kIHNraXAgYnl0ZXMgd2hlbiB0aGUgcHRyIGlzIE5VTEwuCj4+Cj4+U2lnbmVk
LW9mZi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFyZUByZWRoYXQuY29tPgo+Pi0tLQo+
Pgo+PkknbSBub3Qgc3VyZSBpZiB0aGlzIGlzIHRoZSBiZXN0IG9wdGlvbiwgbWF5YmUgd2UgY2Fu
IGFkZCBhIG5ldwo+PmZ1bmN0aW9uIHZyaW5naF9pb3Zfc2tpcCgpLgo+Pgo+PlN1Z2dlc3Rpb25z
Pwo+Cj4KPkkgbWlnaHQgYmUgd29ydGggdG8gY2hlY2sgd2hldGhlciB3ZSBjYW4gY29udmVydCB2
cmluZ2hfaW92IHRvIHVzZSBpb3YgCj5pdGVyYXRvciB0aGVuIHdlIGNhbiB1c2UgaW92X2l0ZXJh
dG9yX2FkdmFuY2UoKSBoZXJlLgoKTWFrZSBzZW5zZSwgSSdsbCB0YWtlIGEgbG9vay4KClRoYW5r
cyBmb3IgdGhlIHN1Z2dlc3Rpb24sClN0ZWZhbm8KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
