Return-Path: <SRS0=1MDK=KU=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 13A3AC2B9F7
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 00:10:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AE6C160FE6
	for <virtualization@archiver.kernel.org>; Tue, 25 May 2021 00:10:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AE6C160FE6
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 7041583B44;
	Tue, 25 May 2021 00:10:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id k1Z9nwilaJaH; Tue, 25 May 2021 00:10:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTP id 157A583AE9;
	Tue, 25 May 2021 00:10:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E34E8C000E;
	Tue, 25 May 2021 00:10:17 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 121E6C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 00:10:17 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id E90FE40492
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 00:10:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id jRPqwvMcoaEi
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 00:10:16 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id E9F7E4040A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 25 May 2021 00:10:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621901414;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=e6wqYTslz1Li6XlXEzxiussdXIpHEFaOGVMFWIhbjr0=;
 b=e7/zMNjHd/JPU/vDeS5YjkVWUCbc1BM3CDmrlG01oqtV+2PzMm1M1dvK82V4S88k6ZADTk
 /901nvURlu9bh0uMry9TQd+9bew2Mr4EbWh+cGmROali+UzesEaajkJi2pHg3hWbjgwDhe
 ZL7/Bz+5Wf7LvCmsjpd/scEnNQbbw6s=
Received: from mail-pl1-f198.google.com (mail-pl1-f198.google.com
 [209.85.214.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-488-Nu5Z56AwOIeeHA6tuNhVqA-1; Mon, 24 May 2021 20:10:10 -0400
X-MC-Unique: Nu5Z56AwOIeeHA6tuNhVqA-1
Received: by mail-pl1-f198.google.com with SMTP id
 j20-20020a170902f254b02900f8d1e07b12so2268978plc.12
 for <virtualization@lists.linux-foundation.org>;
 Mon, 24 May 2021 17:10:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=e6wqYTslz1Li6XlXEzxiussdXIpHEFaOGVMFWIhbjr0=;
 b=P3CdsTCGfgBOrRpGA+hmJlL4AAgyeylaXtgt1oXH6GuRfEGlvP4PkbK69U3gjYIfyL
 gtWFjr8cpbY9vlRKadMT8v+mX149WQmcnmT5WJVUkkEvhK9Xtne2WKCPVT+yLpmrwWNe
 rCeiRGOkbbr4BVCK7sMHslq//nL11OGTjtZZBPbYuU01sISadUOmD8u+CdiXxmBpON1J
 TvbLoNRVAOrOZa8mTdI7PeLwlkUb1/Sqeq3wdYqyYAAJrFTe+qGhSWVmoMxMZoHBNC+8
 AXQzWo0rPRPgNXl1EGPT6JXlRp7BTt6hcekiKcIRRrvInqYvBNLUIVV4Cah1zP+UGmD7
 Xgfw==
X-Gm-Message-State: AOAM533KbD1xMiB+BG++hCbLP0cf/CIHV8DJpHA5xoCL+Aw1A9slPB68
 ferG1vUjwVuMZtPu+DlbcnNbMGL+wnx0f4YE0jpUI7sboXUByejKyFRN8XZDi3ghD8OOE1Js063
 yJtwLT0JYIc/MfUOaPFFmFKhRl+61RUbwTNumkYgeVfWZrzZBfiJnl/FGmoamm22rwNouCziCEG
 /Q1aPfLfmJf6jbkM/jdw==
X-Received: by 2002:a63:36ce:: with SMTP id
 d197mr11971614pga.151.1621901409514; 
 Mon, 24 May 2021 17:10:09 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwpLw3LCNM6Z/PYw+mfFsO8opvWSu4kqbw0H23T6aNpUx4nHDHYLq4KLLwuFfi5Ol2t4xQ5XQ==
X-Received: by 2002:a63:36ce:: with SMTP id
 d197mr11971569pga.151.1621901409126; 
 Mon, 24 May 2021 17:10:09 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id s2sm444708pjz.41.2021.05.24.17.10.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 24 May 2021 17:10:08 -0700 (PDT)
Subject: Re: [RFC v3 00/29] vDPA software assisted live migration
To: Eugenio Perez Martin <eperezma@redhat.com>,
 "Michael S. Tsirkin" <mst@redhat.com>
References: <20210519162903.1172366-1-eperezma@redhat.com>
 <20210524053144-mutt-send-email-mst@kernel.org>
 <CAJaqyWcVm55qjaDpQsuLzaY0FCzjW2ARyvOWCdfS9RJNoOM7Aw@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <0f527c93-4683-480e-7c68-755637b56546@redhat.com>
Date: Tue, 25 May 2021 08:09:59 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <CAJaqyWcVm55qjaDpQsuLzaY0FCzjW2ARyvOWCdfS9RJNoOM7Aw@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Parav Pandit <parav@mellanox.com>, Markus Armbruster <armbru@redhat.com>,
 qemu-level <qemu-devel@nongnu.org>, Harpreet Singh Anand <hanand@xilinx.com>,
 Xiao W Wang <xiao.w.wang@intel.com>, Stefan Hajnoczi <stefanha@redhat.com>,
 Eli Cohen <eli@mellanox.com>, virtualization@lists.linux-foundation.org,
 Eric Blake <eblake@redhat.com>, Michael Lilja <ml@napatech.com>
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

CuWcqCAyMDIxLzUvMjQg5LiL5Y2INjozNywgRXVnZW5pbyBQZXJleiBNYXJ0aW4g5YaZ6YGTOgo+
IE9uIE1vbiwgTWF5IDI0LCAyMDIxIGF0IDExOjM4IEFNIE1pY2hhZWwgUy4gVHNpcmtpbiA8bXN0
QHJlZGhhdC5jb20+IHdyb3RlOgo+PiBPbiBXZWQsIE1heSAxOSwgMjAyMSBhdCAwNjoyODozNFBN
ICswMjAwLCBFdWdlbmlvIFDDqXJleiB3cm90ZToKPj4+IENvbW1pdCAxNyBpbnRyb2R1Y2VzIHRo
ZSBidWZmZXIgZm9yd2FyZGluZy4gUHJldmlvdXMgb25lIGFyZSBmb3IKPj4+IHByZXBhcmF0aW9u
cyBhZ2FpbiwgYW5kIGxhdGVycyBhcmUgZm9yIGVuYWJsaW5nIHNvbWUgb2J2aW91cwo+Pj4gb3B0
aW1pemF0aW9ucy4gSG93ZXZlciwgaXQgbmVlZHMgdGhlIHZkcGEgZGV2aWNlIHRvIGJlIGFibGUg
dG8gbWFwCj4+PiBldmVyeSBJT1ZBIHNwYWNlLCBhbmQgc29tZSB2RFBBIGRldmljZXMgYXJlIG5v
dCBhYmxlIHRvIGRvIHNvLiBDaGVja2luZwo+Pj4gb2YgdGhpcyBpcyBhZGRlZCBpbiBwcmV2aW91
cyBjb21taXRzLgo+PiBUaGF0IG1pZ2h0IGJlY29tZSBhIHNpZ25pZmljYW50IGxpbWl0YXRpb24u
IEFuZCBpdCB3b3JyaWVzIG1lIHRoYXQKPj4gdGhpcyBpcyBzdWNoIGEgYmlnIHBhdGNoc2V0IHdo
aWNoIG1pZ2h0IHlldCB0YWtlIGEgd2hpbGUgdG8gZ2V0Cj4+IGZpbmFsaXplZC4KPj4KPiBTb3Jy
eSwgbWF5YmUgSSd2ZSBiZWVuIHVuY2xlYXIgaGVyZTogTGF0dGVyIGNvbW1pdHMgaW4gdGhpcyBz
ZXJpZXMKPiBhZGRyZXNzIHRoaXMgbGltaXRhdGlvbi4gU3RpbGwgbm90IHBlcmZlY3Q6IGZvciBl
eGFtcGxlLCBpdCBkb2VzIG5vdAo+IHN1cHBvcnQgYWRkaW5nIG9yIHJlbW92aW5nIGd1ZXN0J3Mg
bWVtb3J5IGF0IHRoZSBtb21lbnQsIGJ1dCB0aGlzCj4gc2hvdWxkIGJlIGVhc3kgdG8gaW1wbGVt
ZW50IG9uIHRvcC4KPgo+IFRoZSBtYWluIGlzc3VlIEknbSBvYnNlcnZpbmcgaXMgZnJvbSB0aGUg
a2VybmVsIGlmIEknbSBub3Qgd3Jvbmc6IElmIEkKPiB1bm1hcCBldmVyeSBhZGRyZXNzLCBJIGNh
bm5vdCByZS1tYXAgdGhlbSBhZ2Fpbi4KCgpUaGlzIGxvb2tzIGxpa2UgYSBidWcuCgpEb2VzIHRo
aXMgaGFwcGVuIG9ubHkgb24gc29tZSBzcGVjaWZpYyBkZXZpY2UgKGUuZyB2cF92ZHBhKSBvciBp
dCdzIGEgCmdlbmVyYWwgaXNzdWUgb2Ygdmhvc3QtdmRwYT8KCgo+ICAgQnV0IGNvZGUgaW4gdGhp
cwo+IHBhdGNoc2V0IGlzIG1vc3RseSBmaW5hbCwgZXhjZXB0IGZvciB0aGUgY29tbWVudHMgaXQg
bWF5IGFyaXNlIGluIHRoZQo+IG1haWwgbGlzdCBvZiBjb3Vyc2UuCj4KPj4gSSBoYXZlIGFuIGlk
ZWE6IGhvdyBhYm91dCBhcyBhIGZpcnN0IHN0ZXAgd2UgaW1wbGVtZW50IGEgdHJhbnNwYXJlbnQK
Pj4gc3dpdGNoIGZyb20gdmRwYSB0byBhIHNvZnR3YXJlIHZpcnRpbyBpbiBRRU1VIG9yIGEgc29m
dHdhcmUgdmhvc3QgaW4KPj4ga2VybmVsPwo+Pgo+PiBUaGlzIHdpbGwgZ2l2ZSB1cyBsaXZlIG1p
Z3JhdGlvbiBxdWlja2x5IHdpdGggcGVyZm9ybWFuY2UgY29tcGFyYWJsZQo+PiB0byBmYWlsb3Zl
ciBidXQgd2l0aG91dCBkZXBlbmRhbmNlIG9uIGd1ZXN0IGNvb3BlcmF0aW9uLgo+Pgo+IEkgdGhp
bmsgaXQgc2hvdWxkIGJlIGRvYWJsZS4gSSdtIG5vdCBzdXJlIGFib3V0IHRoZSBlZmZvcnQgdGhh
dCBuZWVkcwo+IHRvIGJlIGRvbmUgaW4gcWVtdSB0byBoaWRlIHRoZXNlICJoeXBlcnZpc29yLWZh
aWxvdmVyIGRldmljZXMiIGZyb20KPiBndWVzdCdzIHZpZXcgYnV0IGl0IHNob3VsZCBiZSBjb21w
YXJhYmxlIHRvIGZhaWxvdmVyLCBhcyB5b3Ugc2F5LgoKClllcywgaWYgd2Ugd2FudCB0byBzd2l0
Y2gsIEknZCBnbyB0byBhIGZhbGxiYWNrIHRvIHZob3N0LXZkcGEgbmV0d29yayAKYmFja2VuZCBp
bnN0ZWFkLgoKVGhhbmtzCgoKPgo+IE5ldHdvcmtpbmcgc2hvdWxkIGJlIG9rIGJ5IGl0cyBuYXR1
cmUsIGFsdGhvdWdoIGl0IGNvdWxkIHJlcXVpcmUgY2FyZQo+IG9uIHRoZSBob3N0IGhhcmR3YXJl
IHNldHVwLiBCdXQgSSdtIG5vdCBzdXJlIGhvdyBvdGhlciB0eXBlcyBvZgo+IHZob3N0L3ZkcGEg
ZGV2aWNlcyBtYXkgd29yayB0aGF0IHdheS4gSG93IHdvdWxkIGEgZGlzay9zY3NpIGRldmljZQo+
IHN3aXRjaCBtb2Rlcz8gQ2FuIHRoZSBrZXJuZWwgdGFrZSBjb250cm9sIG9mIHRoZSB2ZHBhIGRl
dmljZSB0aHJvdWdoCj4gdmhvc3QsIGFuZCBqdXN0IHN0YXJ0IHJlcG9ydGluZyB3aXRoIGEgZGly
dHkgYml0bWFwPwo+Cj4gVGhhbmtzIQo+Cj4+IE5leHQgc3RlcCBjb3VsZCBiZSBkcml2aW5nIHZk
cGEgZnJvbSB1c2Vyc3BhY2Ugd2hpbGUgc3RpbGwgY29weWluZwo+PiBwYWNrZXRzIHRvIGEgcHJl
LXJlZ2lzdGVyZWQgYnVmZmVyLgo+Pgo+PiBGaW5hbGx5IHlvdXIgYXBwcm9hY2ggd2lsbCBiZSBh
IHBlcmZvcm1hbmNlIG9wdGltaXphdGlvbiBmb3IgZGV2aWNlcwo+PiB0aGF0IHN1cHBvcnQgYXJi
aXRyYXJ5IElPVkEuCj4+Cj4+IFRob3VnaHRzPwo+Pgo+PiAtLQo+PiBNU1QKPj4KCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
