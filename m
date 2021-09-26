Return-Path: <SRS0=w7gG=OQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EE47C433EF
	for <virtualization@archiver.kernel.org>; Sun, 26 Sep 2021 04:19:50 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D08246108E
	for <virtualization@archiver.kernel.org>; Sun, 26 Sep 2021 04:19:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D08246108E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 997C34039C;
	Sun, 26 Sep 2021 04:19:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id J_at212Tj3N7; Sun, 26 Sep 2021 04:19:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0C7B540218;
	Sun, 26 Sep 2021 04:19:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DD8E1C000F;
	Sun, 26 Sep 2021 04:19:47 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 6BD59C000D
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Sep 2021 04:19:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 5ABDF80F2F
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Sep 2021 04:19:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp1.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0rfy2Ivx0yVv
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Sep 2021 04:19:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A08B280F2A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 26 Sep 2021 04:19:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1632629984;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZEDO7VMzKEtqu4xff18CWZsV8ZjmqSpSP3cUSke6BmQ=;
 b=dhj07IWRSaWTujmRODFrs0Oq0tvouKBErzkuozANOoHWTrFI+Bu5FgeaEhYhcBY0W66W+m
 og365fa573Odn7CpaNa+ZXkzJFtP7hIIzMMqYvrxhc8xEXWJNqPGDCdFnj8P0Eg3vj1LdB
 goLsxFiY7NXpW5f7BMbN3WenmcIgCCY=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-292-lBruOpzVMXCgl9kRy5302g-1; Sun, 26 Sep 2021 00:19:43 -0400
X-MC-Unique: lBruOpzVMXCgl9kRy5302g-1
Received: by mail-lf1-f70.google.com with SMTP id
 x29-20020ac259dd000000b003f950c726e1so12942760lfn.14
 for <virtualization@lists.linux-foundation.org>;
 Sat, 25 Sep 2021 21:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=ZEDO7VMzKEtqu4xff18CWZsV8ZjmqSpSP3cUSke6BmQ=;
 b=pCdhNb9JZduQHJjMS8NC8L8/fqf+FHgkW75GpVSXDMx5fXndyUbyVrW+HXXaqr7GD3
 mStM4nrQiCn/uvTAR1nddXLVMnYkHH2Sid+S2KzUzgm7zsWXy/CZcZO4ak2cTobsAv7p
 z1SE8EkE+PGcsUGz+7nWIWoJLQhgAfmRQVlnNMsySw5lu6BdwiQ8m0ffYMRa5UwN1Usm
 jCTAyeoqxnlFPQemvnvL/PvFy6kBQMIFUUPrSA5MwEqPM1/ojIWQ41YlrzIIBbH3vtl3
 NBiJdbqZQsWYDk0Knhw+xKcwOXCdX2S+iXyZtt/oX82XaGTpaaza6l5nH+BwDEPY3jJQ
 7Zjw==
X-Gm-Message-State: AOAM530O+yrpVcbGGPF5pAhLLxV2XGm6WF3iQQyPCQLG4cYgbDY+mfir
 aJhFtoRJAqEb4+kEZ+kGfTCBLIbrWZ5JboUdWe+3Ab41CHanBpBhE5gzdpSmDbzjOtOQe/Jc09b
 0PkC79t2RSoZaCk7iQUg/MbbXRqP7KBUE8sD8lWet7oF6Zsgp0ShEUTdyoQ==
X-Received: by 2002:a05:6512:118a:: with SMTP id
 g10mr8458822lfr.580.1632629981542; 
 Sat, 25 Sep 2021 21:19:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw/CKbYwbOzo/Ltc9/By093K0TKyiOcdFR8nOgIXFHTdVyaVR6RoQibvfJEuPPMTf+l1XbSCIjN1Q8g6eiam7o=
X-Received: by 2002:a05:6512:118a:: with SMTP id
 g10mr8458810lfr.580.1632629981391; 
 Sat, 25 Sep 2021 21:19:41 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1631621507.git.wuzongyong@linux.alibaba.com>
 <cover.1632313398.git.wuzongyong@linux.alibaba.com>
 <296014fa3b765f2088a3183bf04e09863651a584.1632313398.git.wuzongyong@linux.alibaba.com>
 <8341d7ef-d31d-5536-864b-7d5127b7ec9f@redhat.com>
 <20210926032701.GA32606@L-PF27918B-1352.localdomain>
In-Reply-To: <20210926032701.GA32606@L-PF27918B-1352.localdomain>
From: Jason Wang <jasowang@redhat.com>
Date: Sun, 26 Sep 2021 12:19:30 +0800
Message-ID: <CACGkMEuAfvAY8nc2fjHQ007bRPE=pUgDPPgMjhkeA34JTQKSfw@mail.gmail.com>
Subject: Re: [PATCH v3 7/7] eni_vdpa: add vDPA driver for Alibaba ENI
To: Wu Zongyong <wuzongyong@linux.alibaba.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: wei.yang1@linux.alibaba.com, mst <mst@redhat.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

T24gU3VuLCBTZXAgMjYsIDIwMjEgYXQgMTE6MjcgQU0gV3UgWm9uZ3lvbmcKPHd1em9uZ3lvbmdA
bGludXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4gT24gU3VuLCBTZXAgMjYsIDIwMjEgYXQgMTA6
MjY6NDdBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToKPiA+Cj4gPiDlnKggMjAyMS85LzIyIOS4
i+WNiDg6NDYsIFd1IFpvbmd5b25nIOWGmemBkzoKPiA+ID4gKwo+ID4gPiArI2lmZGVmIF9fTElU
VExFX0VORElBTgo+ID4KPiA+Cj4gPiBJIHRoaW5rIGRpc2FibGUgdGhlIGRldmljZSB2aWEgS2Nv
bmZpZyBpcyBiZXR0ZXIgdGhhbiBsZXR0aW5nIHVzZXIgdG8gbWVldAo+ID4gZXJyb3JzIGxpa2Ug
dGhpcy4KPiA+Cj4gPiAoT3IgaWYgdGhlIGRldmljZSBpcyBhbHdheXMgdXNpbmcgbGl0dGxlIGVu
ZGlhbiwgd2UgZG9uJ3QgZXZlbiBuZWVkIHRvCj4gPiBib3RoZXIgdGhpcykuCj4KPiBJIHByZWZl
ciB0aGUgc2Vjb25kIHN1Z2dlc3Rpb24gc2luY2UgdGhlcmUgYXJlIG5vIHVzZSBjYXNlcyB0aGF0
IHRoZQo+IGRldmljZSB1c2VzIGJpZyBlbmRpYW4KCklmIHRoaXMgbWVhbnMgdGhlIGRldmljZSB3
aWxsIGFsd2F5cyB1c2UgbGl0dGxlIGVuZGlhbi4gSXQncyBmaW5lLgoKVGhhbmtzCgo+ID4KPiA+
IFRoYW5rcwo+ID4KPiA+Cj4gPiA+ICtzdGF0aWMgaW50IGVuaV92ZHBhX3Byb2JlKHN0cnVjdCBw
Y2lfZGV2ICpwZGV2LCBjb25zdCBzdHJ1Y3QgcGNpX2RldmljZV9pZCAqaWQpCj4gPiA+ICt7Cj4g
PiA+ICsgICBzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Owo+ID4gPiArICAgc3RydWN0
IGVuaV92ZHBhICplbmlfdmRwYTsKPiA+ID4gKyAgIHN0cnVjdCB2aXJ0aW9fcGNpX2xlZ2FjeV9k
ZXZpY2UgKmxkZXY7Cj4gPiA+ICsgICBpbnQgcmV0LCBpOwo+ID4gPiArCj4gPiA+ICsgICByZXQg
PSBwY2ltX2VuYWJsZV9kZXZpY2UocGRldik7Cj4gPiA+ICsgICBpZiAocmV0KQo+ID4gPiArICAg
ICAgICAgICByZXR1cm4gcmV0Owo+ID4gPiArCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
