Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B64E6C6FD1F
	for <virtualization@archiver.kernel.org>; Thu, 16 Mar 2023 08:09:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 0794241705;
	Thu, 16 Mar 2023 08:09:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0794241705
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=KTO7Qv74
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id s-c0_GsqAEtm; Thu, 16 Mar 2023 08:09:49 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 2BBC641678;
	Thu, 16 Mar 2023 08:09:49 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 2BBC641678
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0855CC0071;
	Thu, 16 Mar 2023 08:09:49 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 28173C0032
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 08:09:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 0990041678
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 08:09:47 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0990041678
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0kD20SLnAJNe
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 08:09:44 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 91B1941676
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 91B1941676
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 08:09:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1678954183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ANBi6moGFCcHvuEVtc5exSmPpTznsGEIvNhn1pGPofU=;
 b=KTO7Qv74eS1LkOVnD12sLTSYpc47rWPYrVa4OIi4g2YXTQA0p/qmYdURXJqBQWXwJxBl/+
 7GNH1kjalRBazjAPV+H9hbLx9MdjMTi6wPd06+NBozsTbCeINbvexLAlWXsKKMBD8Z8fjO
 Zd7kSFNIOkKcrAoI1rjNAzfLMWAq014=
Received: from mail-yw1-f197.google.com (mail-yw1-f197.google.com
 [209.85.128.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-625-Tb8LMmvdPZq0gGOIYBRSrw-1; Thu, 16 Mar 2023 04:09:41 -0400
X-MC-Unique: Tb8LMmvdPZq0gGOIYBRSrw-1
Received: by mail-yw1-f197.google.com with SMTP id
 00721157ae682-541888850d4so8189857b3.21
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 01:09:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1678954181;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=ANBi6moGFCcHvuEVtc5exSmPpTznsGEIvNhn1pGPofU=;
 b=Jl6OIzbHDJFdWcMbqyizt/nE26ewYmrEIb6CvW80FNKwoS9pYWTDyqdCrNt30+eval
 SD9ykf0reQ2wqLQutRxNaDK5VEFBIMSU/xNzdOBEMiIX7RXP/PfOcmbS2DQh6J0CGu6M
 HspAjEjQSlxVpTE/ptQirG82kn9V54XN9rdcncmJ5o2xRaPY/A2BILBJskETG//s74WO
 dGbAE1dY/SlgUZSMR6bSbMqbrLLwqAI/Vem/B1ejTsMYqcx+YlZNBYwWXfz+FQ8tnT67
 KoDEJuTq9b7dqR5uWnQZ9HpJfSTcB6UfDqUQ+AD/nNV8SWEm2NxVWkWjLpgPAPa6UYj8
 Yfpw==
X-Gm-Message-State: AO0yUKXlYBrD8ZmFOBYFQTE53/8JVpfqh8ipQe+bwxZ9Cl7AIyDuKCHD
 Fiy/ef4y/e1ELyoKEiOJxxQxe53aIEg+eYNw3FU+JbLpZm4IE8JSyFsnTPzkecMOjsdVx6/bgDN
 ZY+VKXaXPnsxtej1Lks2IGl9xKY49q+a2meBBvivOyo50377gvTiidFoH3w==
X-Received: by 2002:a81:ad26:0:b0:544:a67b:8be0 with SMTP id
 l38-20020a81ad26000000b00544a67b8be0mr481695ywh.3.1678954181316; 
 Thu, 16 Mar 2023 01:09:41 -0700 (PDT)
X-Google-Smtp-Source: AK7set9AvRTqOxXewC6b1IQRkPJ8SS1rw3/pZRF3qWDjUZCuLuTU6cRWfxgoColGfBP0bqfJ0oACLTw3fPECEJ22bt4=
X-Received: by 2002:a81:ad26:0:b0:544:a67b:8be0 with SMTP id
 l38-20020a81ad26000000b00544a67b8be0mr481683ywh.3.1678954181027; Thu, 16 Mar
 2023 01:09:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230302113421.174582-1-sgarzare@redhat.com>
 <20230302113421.174582-4-sgarzare@redhat.com>
 <CACGkMEs6cW7LdpCdWQnX4Pif2gGOu=f3bjNeYQ6MVcdQe=X--Q@mail.gmail.com>
 <1980067.5pFmK94fv0@suse>
In-Reply-To: <1980067.5pFmK94fv0@suse>
From: Stefano Garzarella <sgarzare@redhat.com>
Date: Thu, 16 Mar 2023 09:09:29 +0100
Message-ID: <CAGxU2F4k-UHxHxpLcsvKvJdvcXfb3WpV+wU=8ZpnJwMNkx0rdA@mail.gmail.com>
Subject: Re: [PATCH v2 3/8] vringh: replace kmap_atomic() with
 kmap_local_page()
To: "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Andrey Zhadchenko <andrey.zhadchenko@virtuozzo.com>, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, stefanha@redhat.com
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

T24gV2VkLCBNYXIgMTUsIDIwMjMgYXQgMTA6MTLigK9QTSBGYWJpbyBNLiBEZSBGcmFuY2VzY28K
PGZtZGVmcmFuY2VzY29AZ21haWwuY29tPiB3cm90ZToKPgo+IE9uIG1hcnRlZMOsIDE0IG1hcnpv
IDIwMjMgMDQ6NTY6MDggQ0VUIEphc29uIFdhbmcgd3JvdGU6Cj4gPiBPbiBUaHUsIE1hciAyLCAy
MDIzIGF0IDc6MzTigK9QTSBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+
Cj4gd3JvdGU6Cj4gPiA+IGttYXBfYXRvbWljKCkgaXMgZGVwcmVjYXRlZCBpbiBmYXZvciBvZiBr
bWFwX2xvY2FsX3BhZ2UoKS4KPiA+Cj4gPiBJdCdzIGJldHRlciB0byBtZW50aW9uIHRoZSBjb21t
aXQgb3IgY29kZSB0aGF0IGludHJvZHVjZXMgdGhpcy4KPiA+Cj4gPiA+IFdpdGgga21hcF9sb2Nh
bF9wYWdlKCkgdGhlIG1hcHBpbmdzIGFyZSBwZXIgdGhyZWFkLCBDUFUgbG9jYWwsIGNhbiB0YWtl
Cj4gPiA+IHBhZ2UtZmF1bHRzLCBhbmQgY2FuIGJlIGNhbGxlZCBmcm9tIGFueSBjb250ZXh0IChp
bmNsdWRpbmcgaW50ZXJydXB0cykuCj4gPiA+IEZ1cnRoZXJtb3JlLCB0aGUgdGFza3MgY2FuIGJl
IHByZWVtcHRlZCBhbmQsIHdoZW4gdGhleSBhcmUgc2NoZWR1bGVkIHRvCj4gPiA+IHJ1biBhZ2Fp
biwgdGhlIGtlcm5lbCB2aXJ0dWFsIGFkZHJlc3NlcyBhcmUgcmVzdG9yZWQgYW5kIHN0aWxsIHZh
bGlkLgo+ID4gPgo+ID4gPiBrbWFwX2F0b21pYygpIGlzIGltcGxlbWVudGVkIGxpa2UgYSBrbWFw
X2xvY2FsX3BhZ2UoKSB3aGljaCBhbHNvIGRpc2FibGVzCj4gPiA+IHBhZ2UtZmF1bHRzIGFuZCBw
cmVlbXB0aW9uICh0aGUgbGF0dGVyIG9ubHkgZm9yICFQUkVFTVBUX1JUIGtlcm5lbHMsCj4gPiA+
IG90aGVyd2lzZSBpdCBvbmx5IGRpc2FibGVzIG1pZ3JhdGlvbikuCj4gPiA+Cj4gPiA+IFRoZSBj
b2RlIHdpdGhpbiB0aGUgbWFwcGluZ3MvdW4tbWFwcGluZ3MgaW4gZ2V0dTE2X2lvdGxiKCkgYW5k
Cj4gPiA+IHB1dHUxNl9pb3RsYigpIGRvbid0IGRlcGVuZCBvbiB0aGUgYWJvdmUtbWVudGlvbmVk
IHNpZGUgZWZmZWN0cyBvZgo+ID4gPiBrbWFwX2F0b21pYygpLAo+ID4KPiA+IE5vdGUgd2UgdXNl
ZCB0byB1c2Ugc3BpbmxvY2sgdG8gcHJvdGVjdCBzaW11bGF0b3JzIChhdCBsZWFzdCB1bnRpbAo+
ID4gcGF0Y2ggNywgc28gd2UgcHJvYmFibHkgbmVlZCB0byByZS1vcmRlciB0aGUgcGF0Y2hlcyBh
dCBsZWFzdCkgc28gSQo+ID4gdGhpbmsgdGhpcyBpcyBvbmx5IHZhbGlkIHdoZW46Cj4gPgo+ID4g
VGhlIHZyaW5naCBJT1RMQiBoZWxwZXJzIGFyZSBub3QgdXNlZCBpbiBhdG9taWMgY29udGV4dCAo
ZS5nIHNwaW5sb2NrLAo+ID4gaW50ZXJydXB0cykuCj4KPiBJJ20gcHJvYmFibHkgbWlzc2luZyBz
b21lIGNvbnRleHQgYnV0IGl0IGxvb2tzIHRoYXQgeW91IGFyZSBzYXlpbmcgdGhhdAo+IGttYXBf
bG9jYWxfcGFnZSgpIGlzIG5vdCBzdWl0ZWQgZm9yIGFueSB1c2UgaW4gYXRvbWljIGNvbnRleHQg
KHlvdSBhcmUKPiBtZW50aW9uaW5nIHNwaW5sb2NrcykuCj4KPiBUaGUgY29tbWl0IG1lc3NhZ2Ug
KHRoYXQgSSBrbm93IHByZXR0eSB3ZWxsIHNpbmNlIGl0J3MgdGhlIGV4YWN0IGNvcHksIHdvcmQg
YnkKPiB3b3JkLCBvZiBteSBib2lsZXIgcGxhdGUgY29tbWl0cykKCkkgaG9wZSBpdCdzIG5vdCBh
IHByb2JsZW0gZm9yIHlvdSwgc2hvdWxkIEkgbWVudGlvbiBpdCBzb21laG93PwoKSSBzZWFyY2hl
ZCBmb3IgdGhlIGxhc3QgY29tbWl0cyB0aGF0IG1hZGUgYSBzaW1pbGFyIGNoYW5nZSBhbmQgZm91
bmQKeW91cnMgdGhhdCBleHBsYWluZWQgaXQgcGVyZmVjdGx5IDstKQoKRG8gSSBuZWVkIHRvIHJl
cGhyYXNlPwoKPiBleHBsYWlucyB0aGF0IGttYXBfbG9jYWxfcGFnZSgpIGlzIHBlcmZlY3RseQo+
IHVzYWJsZSBpbiBhdG9taWMgY29udGV4dCAoaW5jbHVkaW5nIGludGVycnVwdHMpLgo+Cj4gSSBk
b24ndCBrbm93IHRoaXMgY29kZSwgaG93ZXZlciBJIGFtIG5vdCBhYmxlIHRvIHNlZSB3aHkgdGhl
c2UgdnJpbmdoIElPVExCCj4gaGVscGVycyBjYW5ub3Qgd29yayBpZiB1c2VkIHVuZGVyIHNwaW5s
b2Nrcy4gQ2FuIHlvdSBwbGVhc2UgZWxhYm9yYXRlIGEgbGl0dGxlCj4gbW9yZT8KPgo+ID4gSWYg
eWVzLCBzaG91bGQgd2UgZG9jdW1lbnQgdGhpcz8gKE9yIHNob3VsZCB3ZSBpbnRyb2R1Y2UgYSBi
b29sZWFuIHRvCj4gPiBzYXkgd2hldGhlciBhbiBJT1RMQiB2YXJpYW50IGNhbiBiZSB1c2VkIGlu
IGFuIGF0b21pYyBjb250ZXh0KT8KPgo+IEFnYWluLCB5b3UnbGwgaGF2ZSBubyBwcm9ibGVtcyBm
cm9tIHRoZSB1c2Ugb2Yga21hcF9sb2NhbF9wYWdlKCkgYW5kIHNvIHlvdQo+IGRvbid0IG5lZWQg
YW55IGJvb2xlYW4gdG8gdGVsbCB3aGV0aGVyIG9yIG5vdCB0aGUgY29kZSBpcyBydW5uaW5nIGlu
IGF0b21pYwo+IGNvbnRleHQuCj4KPiBQbGVhc2UgdGFrZSBhIGxvb2sgYXQgdGhlIEhpZ2htZW0g
ZG9jdW1lbnRhdGlvbiB3aGljaCBoYXMgYmVlbiByZWNlbnRseQo+IHJld29ya2VkIGFuZCBleHRl
bmRlZCBieSBtZTogaHR0cHM6Ly9kb2NzLmtlcm5lbC5vcmcvbW0vaGlnaG1lbS5odG1sCj4KPiBB
bnl3YXksIEkgaGF2ZSBiZWVuIEFUSyAxMiBvciAxMyBob3VycyBpbiBhIHJvdy4gU28gSSdtIHBy
b2JhYmx5IG1pc3NpbmcgdGhlCj4gd2hvbGUgcGljdHVyZS4KClRoYW5rcyBmb3IgeW91ciB1c2Vm
dWwgaW5mbyEKU3RlZmFubwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
