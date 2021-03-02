Return-Path: <SRS0=LnXi=IA=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E9F5C433DB
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 09:47:20 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C077B64E56
	for <virtualization@archiver.kernel.org>; Tue,  2 Mar 2021 09:47:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C077B64E56
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 4EED643096;
	Tue,  2 Mar 2021 09:47:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id MBfZ_ctD0oXu; Tue,  2 Mar 2021 09:47:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 00B9843069;
	Tue,  2 Mar 2021 09:47:17 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7B24C000B;
	Tue,  2 Mar 2021 09:47:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 88186C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 09:47:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 6A7EE43083
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 09:47:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3mEP63OuNg24
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 09:47:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 36B2E43069
 for <virtualization@lists.linux-foundation.org>;
 Tue,  2 Mar 2021 09:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1614678433;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=lNvLI1zsChJgnJq9MCR6chFkbHYLQrCmCIxk0IHOWi0=;
 b=M+dAKLZjSqu6CP/RlZHBwlHFFF16JWR3ETMKb2ZsYxhieXBUWg8rIDCBEYSJCzUXdMM6hI
 o10FGW6VzC2Le7C8MwuLhHI5I97PuDxRZh51qFLXAEp4/zMlj/C/B7GS235ZbkhawiOx4C
 wcZSA+xLooZOhZuv+IFKZ6p4xoJLtYk=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-363-bBSyF4tfNfmA8IAbwfvekA-1; Tue, 02 Mar 2021 04:47:12 -0500
X-MC-Unique: bBSyF4tfNfmA8IAbwfvekA-1
Received: by mail-ej1-f71.google.com with SMTP id r26so2671488eja.22
 for <virtualization@lists.linux-foundation.org>;
 Tue, 02 Mar 2021 01:47:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=lNvLI1zsChJgnJq9MCR6chFkbHYLQrCmCIxk0IHOWi0=;
 b=TtxR5q2zSw41BWZ8dqDd05V7KpWjpGVo8g6N+fLZc2IHVu1b5vg/FGUlskt0IhzWBE
 4NYSr2yGI2DXK5EM5mjBHVa4bbwq9KwDcSpbKmj2irlOJ5houHXLbfE9lsJAA9DAK93a
 DBcNlpcY2X/RUKpSp+Ux1B4ChGhYY7Xjdd8zZq03ABrxqpNBsDzijqBuu+JatdwjjUUm
 zPmC902ks6panon4PtRybWaFlfZ8WDKkdSDNfhvJ8A7juTpiJSd0ZNgb3EjTeKbxuNLL
 cWy0m03xqAgZzcyJZA6ll1PmhIScEzmLDQ6lsT4/XIi7592KwwXo5Mqz9z4Qjrb0tgs1
 AepA==
X-Gm-Message-State: AOAM530UjhNU5fJIYXc/VSdowDXaLQPSehGdQ1MOxKMkf1lZl3S9xHzd
 OzBUK30qlWy5jLFQ1a82dH7ap1/k56txwU+rNDBitUz2xa82jH4LR7FbyRep32BHmqedWT3bAmU
 sI7USV8lEi2A6B0RJAXa9IeOib/9xelhpdxYtSCuU/A==
X-Received: by 2002:a17:906:fcb2:: with SMTP id
 qw18mr3047201ejb.434.1614678431039; 
 Tue, 02 Mar 2021 01:47:11 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzjMhMEgexNSVGalvHgWj2+Bk230qklneo7u70O2OErqt4IfLk29fQciTb8d95u4L7fIeXDMQ==
X-Received: by 2002:a17:906:fcb2:: with SMTP id
 qw18mr3047184ejb.434.1614678430896; 
 Tue, 02 Mar 2021 01:47:10 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id w8sm17455053edd.39.2021.03.02.01.47.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 02 Mar 2021 01:47:10 -0800 (PST)
Date: Tue, 2 Mar 2021 04:47:07 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: set_features should allow reset to zero
Message-ID: <20210302043419-mutt-send-email-mst@kernel.org>
References: <605e7d2d-4f27-9688-17a8-d57191752ee7@redhat.com>
 <20210222023040-mutt-send-email-mst@kernel.org>
 <22fe5923-635b-59f0-7643-2fd5876937c2@oracle.com>
 <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org>
 <52836a63-4e00-ff58-50fb-9f450ce968d7@oracle.com>
 <20210228163031-mutt-send-email-mst@kernel.org>
 <2cb51a6d-afa0-7cd1-d6f2-6b153186eaca@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2cb51a6d-afa0-7cd1-d6f2-6b153186eaca@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, netdev@vger.kernel.org, elic@nvidia.com,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

T24gTW9uLCBNYXIgMDEsIDIwMjEgYXQgMTE6NTY6NTBBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIxLzMvMSA1OjM0IOS4iuWNiCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+ID4gT24gV2VkLCBGZWIgMjQsIDIwMjEgYXQgMTA6MjQ6NDFBTSAtMDgwMCwgU2ktV2VpIExp
dSB3cm90ZToKPiA+ID4gPiBEZXRlY3RpbmcgaXQgaXNuJ3QgZW5vdWdoIHRob3VnaCwgd2Ugd2ls
bCBuZWVkIGEgbmV3IGlvY3RsIHRvIG5vdGlmeQo+ID4gPiA+IHRoZSBrZXJuZWwgdGhhdCBpdCdz
IGEgbGVnYWN5IGd1ZXN0LiBVZ2ggOigKPiA+ID4gV2VsbCwgYWx0aG91Z2ggSSB0aGluayBhZGRp
bmcgYW4gaW9jdGwgaXMgZG9hYmxlLCBtYXkgSSBrbm93IHdoYXQgdGhlIHVzZQo+ID4gPiBjYXNl
IHRoZXJlIHdpbGwgYmUgZm9yIGtlcm5lbCB0byBsZXZlcmFnZSBzdWNoIGluZm8gZGlyZWN0bHk/
IElzIHRoZXJlIGEKPiA+ID4gY2FzZSBRRU1VIGNhbid0IGRvIHdpdGggZGVkaWNhdGUgaW9jdGxz
IGxhdGVyIGlmIHRoZXJlJ3MgaW5kZWVkCj4gPiA+IGRpZmZlcmVudGlhdGlvbiAobGVnYWN5IHYu
cy4gbW9kZXJuKSBuZWVkZWQ/Cj4gPiBCVFcgYSBnb29kIEFQSSBjb3VsZCBiZQo+ID4gCj4gPiAj
ZGVmaW5lIFZIT1NUX1NFVF9FTkRJQU4gX0lPVyhWSE9TVF9WSVJUSU8sID8sIGludCkKPiA+ICNk
ZWZpbmUgVkhPU1RfR0VUX0VORElBTiBfSU9XKFZIT1NUX1ZJUlRJTywgPywgaW50KQo+ID4gCj4g
PiB3ZSBkaWQgaXQgcGVyIHZyaW5nIGJ1dCBtYXliZSB0aGF0IHdhcyBhIG1pc3Rha2UgLi4uCj4g
Cj4gCj4gQWN0dWFsbHksIEkgd29uZGVyIHdoZXRoZXIgaXQncyBnb29kIHRpbWUgdG8ganVzdCBu
b3Qgc3VwcG9ydCBsZWdhY3kgZHJpdmVyCj4gZm9yIHZEUEEuIENvbnNpZGVyOgo+IAo+IDEpIEl0
J3MgZGVmaW5pdGlvbiBpcyBuby1ub3JtYXRpdmUKPiAyKSBBIGxvdCBvZiBidWRyZW4gb2YgY29k
ZXMKPiAKPiBTbyBxZW11IGNhbiBzdGlsbCBwcmVzZW50IHRoZSBsZWdhY3kgZGV2aWNlIHNpbmNl
IHRoZSBjb25maWcgc3BhY2Ugb3Igb3RoZXIKPiBzdHVmZnMgdGhhdCBpcyBwcmVzZW50ZWQgYnkg
dmhvc3QtdkRQQSBpcyBub3QgZXhwZWN0ZWQgdG8gYmUgYWNjZXNzZWQgYnkKPiBndWVzdCBkaXJl
Y3RseS4gUWVtdSBjYW4gZG8gdGhlIGVuZGlhbiBjb252ZXJzaW9uIHdoZW4gbmVjZXNzYXJ5IGlu
IHRoaXMKPiBjYXNlPwo+IAo+IFRoYW5rcwo+IAoKT3ZlcmFsbCBJIHdvdWxkIGJlIGZpbmUgd2l0
aCB0aGlzIGFwcHJvYWNoIGJ1dCB3ZSBuZWVkIHRvIGF2b2lkIGJyZWFraW5nCndvcmtpbmcgdXNl
cnNwYWNlLCBxZW11IHJlbGVhc2VzIHdpdGggdmRwYSBzdXBwb3J0IGFyZSBvdXQgdGhlcmUgYW5k
CnNlZW0gdG8gd29yayBmb3IgcGVvcGxlLiBBbnkgY2hhbmdlcyBuZWVkIHRvIHRha2UgdGhhdCBp
bnRvIGFjY291bnQKYW5kIGRvY3VtZW50IGNvbXBhdGliaWxpdHkgY29uY2VybnMuIEkgbm90ZSB0
aGF0IGFueSBoYXJkd2FyZQppbXBsZW1lbnRhdGlvbiBpcyBhbHJlYWR5IGJyb2tlbiBmb3IgbGVn
YWN5IGV4Y2VwdCBvbiBwbGF0Zm9ybXMgd2l0aApzdHJvbmcgb3JkZXJpbmcgd2hpY2ggbWlnaHQg
YmUgaGVscGZ1bCBpbiByZWR1Y2luZyB0aGUgc2NvcGUuCgoKLS0gCk1TVAoKX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGlu
ZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8v
bGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
