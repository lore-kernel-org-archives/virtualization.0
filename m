Return-Path: <SRS0=XT4h=JK=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E9F1C43460
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 11:14:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B5A42613A9
	for <virtualization@archiver.kernel.org>; Tue, 13 Apr 2021 11:13:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B5A42613A9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 57AB2402FC;
	Tue, 13 Apr 2021 11:13:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id olnR9X9nrHTT; Tue, 13 Apr 2021 11:13:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id A6E9E402DB;
	Tue, 13 Apr 2021 11:13:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 8801BC000B;
	Tue, 13 Apr 2021 11:13:57 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A7CEC000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 11:13:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 1B238402DB
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 11:13:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id SDViLEWBUNum
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 11:13:54 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com
 [IPv6:2a00:1450:4864:20::432])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 8F618402B2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 11:13:54 +0000 (UTC)
Received: by mail-wr1-x432.google.com with SMTP id p6so9317317wrn.9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 13 Apr 2021 04:13:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=references:user-agent:from:to:cc:subject:date:in-reply-to
 :message-id:mime-version:content-transfer-encoding;
 bh=Cu3neruluoSCQXicI1kgn+ehmqNJHkuNyetxZuBFmfY=;
 b=hfiiqOLquAbv0Zo8WwVW2P07q1yK3rArOdZiB3bFdqqgKEY4lhM+0k9N7CEc6B7dmD
 //pm3E0tK9HCL2QxUb6/PVLhUGdQc10kea72DZarCyaqCO0WxxJqcCLQmwn7hJEkjfoH
 2Iiqt6IqBtzKI9PfTgrsHx2BGKb2PpShkXb0fjnkpqqjDf78j39yJlk3ZbEDkvgPa93c
 2/cJipB4xQ+mHSaKtRMPfX/Lxs8cPxa8S+O7QT1OJ0UHk1/ZbjFuQ8awzP/0P8bG1Q6w
 hzU5VD/Pn9vta+7UKZmMtV44h1AS9WC2Ii173EYi71sMGuGasWPvDVwjcwUHvycImZde
 gRSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:references:user-agent:from:to:cc:subject:date
 :in-reply-to:message-id:mime-version:content-transfer-encoding;
 bh=Cu3neruluoSCQXicI1kgn+ehmqNJHkuNyetxZuBFmfY=;
 b=ocAGjqla4VCf+RuhXfDtQopRP7+oT4qRdTmwHaveIFTF3FymhozRPTaY2duMaMHVuq
 sgEt7VDLEXJ0RngvmxciA1Qr8DmCb+EBi2j1q6Qeem049QOT60KARmr3Dxeu9i0vDjAe
 cQfyFF864KWAqKTvYvrTAeHLCvaRRwF4smFH2D8rvaYI3maBkFbUjPv1OKJzlW3Zz1oz
 MwE9UscBWNMzupWwxJmc+U/0cLscznwjXmW6hv1WAw98b786Mfi0Vss04TvMGtj8PYNX
 sH7V9VNw2KMgOPBYZKRGNTyM8TuTPM/R+m5DD4rMOB/MquCeMw2tQs7aqeRgMkZrdOHP
 V5Zw==
X-Gm-Message-State: AOAM530E5oDBWfeaecREAJjcxT/ji2LtZjFcbkGk+Ssch0ku0NjmGBkE
 TEGZK+2xbGPqKW+yOoZ1tC6nAA==
X-Google-Smtp-Source: ABdhPJzY9shCczKjSRW6Y2rpwOvSTMSuxueUgRqhkgPrE9aInqm3+aebb0vYVhHDuo9TmXBtfSBYUQ==
X-Received: by 2002:a5d:43c1:: with SMTP id v1mr11267064wrr.419.1618312432810; 
 Tue, 13 Apr 2021 04:13:52 -0700 (PDT)
Received: from zen.linaroharston ([51.148.130.216])
 by smtp.gmail.com with ESMTPSA id j6sm2130276wmq.16.2021.04.13.04.13.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 13 Apr 2021 04:13:51 -0700 (PDT)
Received: from zen (localhost [127.0.0.1])
 by zen.linaroharston (Postfix) with ESMTP id 012321FF7E;
 Tue, 13 Apr 2021 12:13:50 +0100 (BST)
References: <20201203191135.21576-1-info@metux.net>
 <20201203191135.21576-2-info@metux.net>
 <8209ce55-a4aa-f256-b9b9-f7eb3cac877b@redhat.com>
 <43f1ee89-89f3-95a3-58f1-7a0a12c2b92f@metux.net>
User-agent: mu4e 1.5.11; emacs 28.0.50
From: Alex =?utf-8?Q?Benn=C3=A9e?= <alex.bennee@linaro.org>
To: "Enrico Weigelt, metux IT consult" <info@metux.net>
Subject: Re: [PATCH v2 2/2] drivers: gpio: add virtio-gpio guest driver
Date: Tue, 13 Apr 2021 12:07:58 +0100
In-reply-to: <43f1ee89-89f3-95a3-58f1-7a0a12c2b92f@metux.net>
Message-ID: <87lf9mmo7l.fsf@linaro.org>
MIME-Version: 1.0
Cc: Jean-Philippe Brucker <jean-philippe@linaro.org>, mst@redhat.com,
 corbet@lwn.net, linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, bgolaszewski@baylibre.com,
 linux-gpio@vger.kernel.org, linux-riscv@lists.infradead.org,
 linus.walleij@linaro.org
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

CiJFbnJpY28gV2VpZ2VsdCwgbWV0dXggSVQgY29uc3VsdCIgPGluZm9AbWV0dXgubmV0PiB3cml0
ZXM6Cgo+IE9uIDA0LjEyLjIwIDA0OjM1LCBKYXNvbiBXYW5nIHdyb3RlOgo+Cj4gSGksCj4KPj4g
SXMgdGhlIHBsYW4gdG8ga2VlcCB0aGlzIGRvYyBzeW5jZWQgd2l0aCB0aGUgb25lIGluIHRoZSB2
aXJ0aW8KPj4gc3BlY2lmaWNhdGlvbj8KPgo+IFllcywgb2YgY291cnNlLiBJJ20gc3RpbGwgaW4g
cHJvZ3Jlc3Mgb2YgZG9pbmcgdGhlIGJlYXVyb2NyYXRpYyBzdHVmZiB3Lwo+IHZpcnRpby10YyBm
b2xrcyAoSUQgcmVnaXN0cmF0aW9uLCAuLi4pIC0geWV0IGhhdmUgdG8gc2VlIHdoZXRoZXIgdGhl
eQo+IHdhbm5hIGFkZCBpdCB0byB0aGVpciBzcGVjIGRvY3VtZW50cyAuLi4KPgo+IEJUVzogaWYg
eW91IGZlZWwsIHNvbWV0aW5ncyBub3QgZ29vZCB3LyB0aGUgY3VycmVudCBzcGVjLCBwbGVhc2Ug
cmFpc2UKPiB5b3VyIHZvaWNlIG5vdy4KPgo+PiBJIHRoaW5rIGl0J3MgYmV0dGVyIHRvIHVzZSB1
OCBvdCB1aW50OF90IGhlcmUuR2l0IGdyZXAgdG9sZCBtZSB0aGUKPj4gZm9ybWVyIGlzIG1vcmUg
cG9wdWxhciB1bmRlciBEb2N1bWVudGF0aW9uLy4KPgo+IHRoeCwgSSdsbCBmaXggdGhhdAo+Cj4+
PiArLSBmb3IgdmVyc2lvbiBmaWVsZCBjdXJyZW50bHkgb25seSB2YWx1ZSAxIHN1cHBvcnRlZC4K
Pj4+ICstIHRoZSBsaW5lIG5hbWVzIGJsb2NrIGhvbGRzIGEgc3RyZWFtIG9mIHplcm8tdGVybWlu
YXRlZCBzdHJpbmdzLAo+Pj4gK8KgIGhvbGRpbmcgdGhlIGluZGl2aWR1YWwgbGluZSBuYW1lcy4K
Pj4gCj4+IEknbSBub3Qgc3VyZSBidXQgZG9lcyB0aGlzIG1lYW4gd2UgZG9uJ3QgaGF2ZSBhIGZp
eGVkIGxlbmd0aCBvZiBjb25maWcKPj4gc3BhY2U/IE5lZWQgdG8gY2hlY2sgd2hldGhlciBpdCBj
YW4gYnJpbmcgYW55IHRyb3VibGUgdG8KPj4gbWlncmF0aW9uKGNvbXBhdGliaWxpdHkpLgo+Cj4g
WWVzLCBpdCBkZXBlbmRzIG9uIGhvdyBtYW55IGdwaW8gbGluZXMgYXJlIHByZXNlbnQgYW5kIGhv
dyBtdWNoIHNwYWNlCj4gdGhlaXIgbmFtZXMgdGFrZSB1cC4KPgo+IEEgZml4ZWQgc2l6ZSB3b3Vs
ZCBlaXRoZXIgcHV0IHVucGxlYXNlbnQgbGltaXRzIG9uIHRoZSBtYXggbnVtYmVyIG9mCj4gbGlu
ZXMgb3Igd2FzdGUgYSBsb3Qgc3BhY2Ugd2hlbiBvbmx5IGZldyBsaW5lcyBwcmVzZW50Lgo+Cj4g
Tm90IHRoYXQgdmlydGlvLWdwaW8gaXMgYWxzbyBtZWFudCBmb3Igc21hbGwgZW1iZWRkZWQgd29y
a2xvYWRzIHJ1bm5pbmcKPiB1bmRlciBzb21lIGh5cGVydmlzb3IuCj4KPj4+ICstIHVuc3BlY2lm
aWVkIGZpZWxkcyBhcmUgcmVzZXJ2ZWQgZm9yIGZ1dHVyZSB1c2UgYW5kIHNob3VsZCBiZSB6ZXJv
Lgo+Pj4gKwo+Pj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+Pj4gK1ZpcnRxdWV1ZXMgYW5k
IG1lc3NhZ2VzOgo+Pj4gKy0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+Pj4gKwo+Pj4gKy0gUXVl
dWUgIzA6IHRyYW5zbWlzc2lvbiBmcm9tIGhvc3QgdG8gZ3Vlc3QKPj4+ICstIFF1ZXVlICMxOiB0
cmFuc21pc3Npb24gZnJvbSBndWVzdCB0byBob3N0Cj4+IAo+PiAKPj4gVmlydGlvIGJlY2FtZSBt
b3JlIGEgcG9wdWxhciBpbiB0aGUgYXJlYSB3aXRob3V0IHZpcnR1YWxpemF0aW9uLiBTbyBJCj4+
IHRoaW5rIGl0J3MgYmV0dGVyIHRvIHVzZSAiZGV2aWNlL2RyaXZlciIgaW5zdGVhZCBvZiAiaG9z
dC9ndWVzdCIgaGVyZS4KPgo+IEdvb2QgcG9pbnQuIEJ1dCBJJ2QgcHJlZmVyICJjcHUiIGluc3Rl
YWQgb2YgImRyaXZlciIgaW4gdGhhdCBjYXNlLgoKSSB0aGluayB5b3UgYXJlIGdvaW5nIHRvIHRp
ZSB5b3Vyc2VsZiB1cCBpbiBrbm90cyBpZiB5b3UgZG9uJ3QgbW92ZSB0aGlzCnRvIHRoZSBPQVNJ
UyBzcGVjLiBUaGUgcmVhc29uIGJlaW5nIHRoZSBWaXJ0SU8gc3BlYyBoYXMgZGVmaW5pdGlvbnMg
Zm9yCndoYXQgYSAiRGV2aWNlIiBhbmQgYSAiRHJpdmVyIiBpcyB0aGF0IGFyZSBjbGVhciBhbmQg
dW5hbWJpZ3VvdXMuIFRoZQp1cHN0cmVhbSBzcGVjIHNob3VsZCBiZSBjb25zaWRlcmVkIHRoZSBj
YW5vbmljYWwgc291cmNlIG9mIHRydXRoIGZvciBhbnkKaW1wbGVtZW50YXRpb24gKExpbnV4IG9y
IG90aGVyd2lzZSkuCgpCeSBhbGwgbWVhbnMgaGF2ZSB0aGUgZGlzdGlsbGVkIGRvY3VtZW50YXRp
b24gZm9yIHRoZSBkcml2ZXIgaW4gdGhlCmtlcm5lbCBzb3VyY2UgdHJlZSBidXQgdHJ5aW5nIHRv
IHVwc3RyZWFtIGFuIGltcGxlbWVudGF0aW9uIGJlZm9yZQpzdGFydGluZyB0aGUgZGVmaW5pdGlv
biBpbiB0aGUgc3RhbmRhcmQgaXMgYSBsaXR0bGUgYmFjayB0byBmcm9udCBJTUhPKi4KCiogdGhh
dCdzIG5vdCB0byBzYXkgdGhlc2UgdGhpbmdzIGNhbid0IGJlIGRvbmUgaW4gcGFyYWxsZWwgYXMg
dGhlIHNwZWMKICBpcyByZXZpZXdlZCBhbmQgd29ya2VkIG9uIGFuZCB0aGUga2lua3Mgd29ya2Vk
IG91dCBidXQgeW91IHdhbnQgdGhlCiAgZmluYWwgb3JkZXIgb2YgdXBzdHJlYW1pbmcgdG8gc3Rh
cnQgd2l0aCB0aGUgc3BlYy4KCi0tIApBbGV4IEJlbm7DqWUKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
