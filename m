Return-Path: <SRS0=kU6l=GH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 62250C433DB
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 07:03:38 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E647E2087E
	for <virtualization@archiver.kernel.org>; Mon,  4 Jan 2021 07:03:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E647E2087E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 423EE806ED;
	Mon,  4 Jan 2021 07:03:37 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id nkj3BLNSdocC; Mon,  4 Jan 2021 07:03:36 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 67E4C86854;
	Mon,  4 Jan 2021 07:03:36 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5C374C0893;
	Mon,  4 Jan 2021 07:03:36 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 423A7C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 07:03:35 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 05D33870A2
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 07:03:35 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Bd+PCNEVoEXq
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 07:03:34 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id CC710870A1
 for <virtualization@lists.linux-foundation.org>;
 Mon,  4 Jan 2021 07:03:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1609743812;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=+f9+XPdRZxWwAbMjqhs2a72E1AbDKCUZW2paxgvF++4=;
 b=IQ3jBEpE/LwUJAmRgn++lgdyegeIWud0XJX2G8GHM2nLJGoH8T5VD9u65xUP+ZxpTrLaH7
 d+mJ3A8I/Wp7As/nxEPVAO5TzaV0rFeS5Y+FZcyLIBFNRAqfvoLERUAEu5tE1pKR91CjEj
 axkYozU428pXwpjpzw17xS/grYNmIBc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-280-G0J0Lc5EPiKFogy4VNJQCQ-1; Mon, 04 Jan 2021 02:03:30 -0500
X-MC-Unique: G0J0Lc5EPiKFogy4VNJQCQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A12E1800D55;
 Mon,  4 Jan 2021 07:03:29 +0000 (UTC)
Received: from [10.72.13.91] (ovpn-13-91.pek2.redhat.com [10.72.13.91])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C7C2B100239A;
 Mon,  4 Jan 2021 07:03:24 +0000 (UTC)
Subject: Re: [PATCH linux-next v2 4/7] vdpa: Define vdpa mgmt device, ops and
 a netlink interface
To: Parav Pandit <parav@nvidia.com>, virtualization@lists.linux-foundation.org
References: <20201112064005.349268-1-parav@nvidia.com>
 <20210104033141.105876-1-parav@nvidia.com>
 <20210104033141.105876-5-parav@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <b08ede5d-e393-b4f8-d1d8-2aa29e409872@redhat.com>
Date: Mon, 4 Jan 2021 15:03:23 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20210104033141.105876-5-parav@nvidia.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: netdev@vger.kernel.org, elic@nvidia.com, mst@redhat.com
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

Ck9uIDIwMjEvMS80IOS4iuWNiDExOjMxLCBQYXJhdiBQYW5kaXQgd3JvdGU6Cj4gVG8gYWRkIG9u
ZSBvciBtb3JlIFZEUEEgZGV2aWNlcywgZGVmaW5lIGEgbWFuYWdlbWVudCBkZXZpY2Ugd2hpY2gK
PiBhbGxvd3MgYWRkaW5nIG9yIHJlbW92aW5nIHZkcGEgZGV2aWNlLiBBIG1hbmFnZW1lbnQgZGV2
aWNlIGRlZmluZXMKPiBzZXQgb2YgY2FsbGJhY2tzIHRvIG1hbmFnZSB2ZHBhIGRldmljZXMuCj4K
PiBUbyBiZWdpbiB3aXRoLCBpdCBkZWZpbmVzIGFkZCBhbmQgcmVtb3ZlIGNhbGxiYWNrcyB0aHJv
dWdoIHdoaWNoIGEgdXNlcgo+IGRlZmluZWQgdmRwYSBkZXZpY2UgY2FuIGJlIGFkZGVkIG9yIHJl
bW92ZWQuCj4KPiBBIHVuaXF1ZSBtYW5hZ2VtZW50IGRldmljZSBpcyBpZGVudGlmaWVkIGJ5IGl0
cyB1bmlxdWUgaGFuZGxlIGlkZW50aWZpZWQKPiBieSBtYW5hZ2VtZW50IGRldmljZSBuYW1lIGFu
ZCBvcHRpb25hbGx5IHRoZSBidXMgbmFtZS4KPgo+IEhlbmNlLCBpbnRyb2R1Y2Ugcm91dGluZSB0
aHJvdWdoIHdoaWNoIGRyaXZlciBjYW4gcmVnaXN0ZXIgYQo+IG1hbmFnZW1lbnQgZGV2aWNlIGFu
ZCBpdHMgY2FsbGJhY2sgb3BlcmF0aW9ucyBmb3IgYWRkaW5nIGFuZCByZW1vdmUKPiBhIHZkcGEg
ZGV2aWNlLgo+Cj4gSW50cm9kdWNlIHZkcGEgbmV0bGluayBzb2NrZXQgZmFtaWx5IHNvIHRoYXQg
dXNlciBjYW4gcXVlcnkgbWFuYWdlbWVudAo+IGRldmljZSBhbmQgaXRzIGF0dHJpYnV0ZXMuCj4K
PiBFeGFtcGxlIG9mIHNob3cgdmRwYSBtYW5hZ2VtZW50IGRldmljZSB3aGljaCBhbGxvd3MgY3Jl
YXRpbmcgdmRwYSBkZXZpY2Ugb2YKPiBuZXR3b3JraW5nIGNsYXNzIChkZXZpY2UgaWQgPSAweDEp
IG9mIHZpcnRpbyBzcGVjaWZpY2F0aW9uIDEuMQo+IHNlY3Rpb24gNS4xLjEuCj4KPiAkIHZkcGEg
bWdtdGRldiBzaG93Cj4gdmRwYXNpbV9uZXQ6Cj4gICAgc3VwcG9ydGVkX2NsYXNzZXM6Cj4gICAg
ICBuZXQKPgo+IEV4YW1wbGUgb2Ygc2hvd2luZyB2ZHBhIG1hbmFnZW1lbnQgZGV2aWNlIGluIEpT
T04gZm9ybWF0Lgo+Cj4gJCB2ZHBhIG1nbXRkZXYgc2hvdyAtanAKPiB7Cj4gICAgICAic2hvdyI6
IHsKPiAgICAgICAgICAidmRwYXNpbV9uZXQiOiB7Cj4gICAgICAgICAgICAgICJzdXBwb3J0ZWRf
Y2xhc3NlcyI6IFsgIm5ldCIgXQo+ICAgICAgICAgIH0KPiAgICAgIH0KPiB9Cj4KPiBTaWduZWQt
b2ZmLWJ5OiBQYXJhdiBQYW5kaXQ8cGFyYXZAbnZpZGlhLmNvbT4KPiBSZXZpZXdlZC1ieTogRWxp
IENvaGVuPGVsaWNAbnZpZGlhLmNvbT4KPiBSZXZpZXdlZC1ieTogSmFzb24gV2FuZzxqYXNvd2Fu
Z0ByZWRoYXQuY29tPgo+IC0tLQo+IENoYW5nZWxvZzoKPiB2MS0+djI6Cj4gICAtIHJlYmFzZWQK
PiAgIC0gdXBkYXRlZCBjb21taXQgbG9nIGV4YW1wbGUgZm9yIG1hbmFnZW1lbnQgZGV2aWNlIG5h
bWUgZnJvbQo+ICAgICAidmRwYXNpbSIgdG8gInZkcGFzaW1fbmV0Igo+ICAgLSByZW1vdmVkIGRl
dmljZV9pZCBhcyBuZXQgYW5kIGJsb2NrIG1hbmFnZW1lbnQgZGV2aWNlcyBhcmUgc2VwYXJhdGVk
CgoKU28gSSB3b25kZXIgd2hldGhlciB0aGVyZSBjb3VsZCBiZSBhIHR5cGUgb2YgbWFuYWdlbWVu
dCBkZXZpY2VzIHRoYXQgY2FuIApkZWFsIHdpdGggbXVsdGlwbGUgdHlwZXMgb2YgdmlydGlvIGRl
dmljZXMuIElmIHllcywgd2UgcHJvYmFibHkgbmVlZCB0byAKYWRkIGRldmljZSBpZCBiYWNrLgoK
VGhhbmtzCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
