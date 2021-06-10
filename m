Return-Path: <SRS0=uiEo=LE=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 886D1C47094
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 05:13:22 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2AA91613CA
	for <virtualization@archiver.kernel.org>; Thu, 10 Jun 2021 05:13:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2AA91613CA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id DA935606E8;
	Thu, 10 Jun 2021 05:13:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id aGuX5pOdEirA; Thu, 10 Jun 2021 05:13:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 44CD7606DA;
	Thu, 10 Jun 2021 05:13:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 18731C000E;
	Thu, 10 Jun 2021 05:13:20 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68201C000B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 05:13:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5EAEA4058B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 05:13:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 63Q0QyP_SKel
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 05:13:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 30B154057E
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Jun 2021 05:13:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1623301996;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ah4b2/uU/apvLOu4oCcBrc27b3olRxMh8fBt7O5N9I8=;
 b=dgmnc1XY2sWw0Gkj+iGrYi3VzEaintAR58zZ9RNcR2AKJ2BAABTgJcg3I7c8qDacGD59Ld
 LIGrBluEm3IxWzPpUlFWCG/3+21MvPyYzLPPXalL/4Uc5Ka45WYyi6fRcI5uD+f4nm8FpX
 GCCd4orpJ/+XwcfDDI+wcOQ/Ha03kxc=
Received: from mail-pj1-f72.google.com (mail-pj1-f72.google.com
 [209.85.216.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25--ftrTpGvMz-f93cOmmIkeQ-1; Thu, 10 Jun 2021 01:13:15 -0400
X-MC-Unique: -ftrTpGvMz-f93cOmmIkeQ-1
Received: by mail-pj1-f72.google.com with SMTP id
 mw15-20020a17090b4d0fb0290157199aadbaso3120799pjb.7
 for <virtualization@lists.linux-foundation.org>;
 Wed, 09 Jun 2021 22:13:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=ah4b2/uU/apvLOu4oCcBrc27b3olRxMh8fBt7O5N9I8=;
 b=QV82tuACy5BD+TjNN05dhnRIF0fVsWISN8ibnH/Skqy6fKtLdURsSTJcuXev+geAs+
 2zr8Oii/IxegU1KqKbqYFJ/mjRV5KiIs+RK21yEoSruCv/9KdjyfKbGoi4eYf0YUa1no
 5oQhS6X3xXvwprCjTP4tVp70m4prZD/DygCTe+S87Z2H9SOSrITyuYwm1MzSQSHJaYjc
 QNt6rR03+xBR0XQmnSMUFT2S0GS6oKsyOnba5kYAVxzEUuD0GSWgOBVfLovks93f+GY9
 xAol88NP5e1nj1yPnhHNKTWdwdeDh7s5I22TFBfnJN1q7OwTx/gG+If9x+wSNSYw5xtu
 0GgQ==
X-Gm-Message-State: AOAM5328VWC9uzV6NU7izMsvXA9Am3korEPisHTVwqgYsQHa+XSSjTy2
 IQdlcmP/5XigKVg1gmsvxp27w+0qZaa3c0wpSWuNeJaPzyRwT4e2L3wcRPQ2WjIJX3wJY0IMNS1
 yuGM/QQHbXxYXirbM6sRasocIopAyoEQfpv+BDlfz6Cx6f7/pvwKX7ZHrsUHcBZyL4CPYuKKw2o
 XnCItZ+bN3L8KXL2bKMA==
X-Received: by 2002:a17:902:7481:b029:114:dd50:4e14 with SMTP id
 h1-20020a1709027481b0290114dd504e14mr3178936pll.32.1623301994224; 
 Wed, 09 Jun 2021 22:13:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyPpS+ErI+gnsHMwVKyaLxXzt47oo98/BSWvSoI1SNyEpJPZkFaCaEW4pW4B+H8g2hfL017MA==
X-Received: by 2002:a17:902:7481:b029:114:dd50:4e14 with SMTP id
 h1-20020a1709027481b0290114dd504e14mr3178907pll.32.1623301993829; 
 Wed, 09 Jun 2021 22:13:13 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id q4sm1096388pfg.3.2021.06.09.22.13.11
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 09 Jun 2021 22:13:13 -0700 (PDT)
Subject: Re: Security hole in vhost-vdpa?
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <BY5PR02MB6980228A5EA2D021A3F9F47BB1399@BY5PR02MB6980.namprd02.prod.outlook.com>
 <20210606173637-mutt-send-email-mst@kernel.org>
 <82e91727-79f4-b6f1-37f1-9fb5bdf67b8d@redhat.com>
 <20210610002358-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <7e11832a-5e15-2c92-d500-1eb0f39e552f@redhat.com>
Date: Thu, 10 Jun 2021 13:13:06 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <20210610002358-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Martin Petrus Hubertus Habets <martinh@xilinx.com>,
 Harpreet Singh Anand <hanand@xilinx.com>, Gautam Dawar <gdawar@xilinx.com>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

CuWcqCAyMDIxLzYvMTAg5LiL5Y2IMTI6MzAsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6Cj4g
T24gTW9uLCBKdW4gMDcsIDIwMjEgYXQgMTA6MTA6MDNBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPj4g5ZyoIDIwMjEvNi83IOS4iuWNiDU6MzgsIE1pY2hhZWwgUy4gVHNpcmtpbiDlhpnpgZM6
Cj4+PiBPbiBTdW4sIEp1biAwNiwgMjAyMSBhdCAwMjozOTo0OFBNICswMDAwLCBHYXV0YW0gRGF3
YXIgd3JvdGU6Cj4+Pj4gSGkgQWxsLAo+Pj4+Cj4+Pj4KPj4+PiBUaGlzIGlzIGluIGNvbnRpbnVh
dGlvbiB0byBteSBmaW5kaW5ncyBub3RlZCBpbiBCdWcgMjEzMTc5IGFuZCBkaXNjdXNzaW9ucyB3
ZQo+Pj4+IGhhdmUgaGFkIGluIHRoZSBsYXN0IGNvdXBsZSBvZiB3ZWVrcyBvdmVyIGVtYWlscy4K
Pj4+Pgo+Pj4+Cj4+Pj4gVG9kYXksIEkgcHVibGlzaGVkIHRoZSBmaXJzdCBwYXRjaCBmb3IgdGhp
cyBpc3N1ZSB3aGljaCBhZGRzIHRpbWVvdXQgYmFzZWQgd2FpdAo+Pj4+IGZvciBjb21wbGV0aW9u
IGV2ZW50IGFuZCBhbHNvIGxvZ3MgYSB3YXJuaW5nIG1lc3NhZ2UgdG8gYWxlcnQgdGhlIHVzZXIv
Cj4+Pj4gYWRtaW5pc3RyYXRvciBvZiB0aGUgcHJvYmxlbS4KPj4+IENhbid0IGNsb3NlIGp1c3Qg
ZmluaXNoIHdpdGhvdXQgd2FpdGluZyBmb3IgdXNlcnNwYWNlPwo+Pgo+PiBJdCB3b3JrcyBhcyBs
b25nIGFzIHdlIGRvbid0IHVzZSBtbWFwKCkuIFdoZW4gd2UgbWFwIGtpY2tzLCBpdCBsb29rcyB0
byBtZQo+PiB0aGVyZSdzIG5vIHdheSB0byAicmV2b2tlIiB0aGUgbWFwcGluZyBmcm9tIHVzZXJz
cGFjZT8KPj4KPj4gVGhhbmtzCj4gQ2FuJ3Qgd2UgdHJhY2sgdGhlc2UgbWFwcGluZ3MgYW5kIG1h
cCBzb21lIG90aGVyIHBhZ2UgdGhlcmU/Cj4gTGlrZWx5IG5vIG1vcmUgdGhhbiBvbmUgaXMgbmVl
ZGVkIC4uLgoKCkkgdGhpbmsgd2UgY2FuIGJ1dCBpZiBJIHVuZGVyc3RhbmQgY29ycmVjdGx5IGFi
b3V0IGhvdyBtbSBndXlzLiBTdWNoIAoicmV2b2tpbmciIGlzIGV4cGVjdGVkIHRvIGJlIGRvbmUg
b25seSB2aWEgbXVubWFwKCkuIERvaW5nIHRoYXQgaXMgCmtlcm5lbCBtaWdodCBiZSB0cmlja3kg
YW5kIGhhcmQgdG8gYmUgY29ycmVjdC4KCklmIEkgd2FzIHdyb25nLCB3ZSBjYW4gdHJ5IHRvIGRv
IHRoYXQgYW5kIHBvc3QgUkZDIHRvIHNlZSBpZiBpdCB3b3Jrcy4KClRoYW5rcwoKKE5vdGUgdGhh
dCB0aGlzICJzZWN1cml0eSBob2xlIiBpcyBub3QgdkRQQSBzcGVjaWZpYywgVkZJTyBhbmQgb3Ro
ZXIgCnVzZXJzcGFjZSBkcml2ZXIgc3Vic3lzdGVtIG1heSBoYXZlIHRoZSBzaW1pbGFyICJpc3N1
ZSIpLgoKVGhhbmtzCgoKPgo+Cj4KPj4+IFRoZW4gbm90aWZ5IHVzZXJzcGFjZSBhYm91dCBhbnkg
YnVmZmVycyB0aGF0IGRpZCBub3QgY29tcGxldGUgLi4uCj4+Pgo+Pj4KPj4+PiBBcyBhIG5leHQg
c3RlcCwgdGhlIGlkZWEgaXMgdG8gaW1wbGVtZW50IGEgbWVjaGFuaXNtIHRvIGFsbG93IHZob3N0
LXZkcGEgbW9kdWxlCj4+Pj4gbm90aWZ5IHVzZXJzcGFjZSBhcHAgKFFFTVUpIHRvIGNsb3NlIHRo
ZSBmZCBjb3JyZXNwb25kaW5nIHRvIHRoZSB2aG9zdC12ZHBhCj4+Pj4gY2hhcmFjdGVyIGRldmlj
ZSB3aGVuIGl0IGlzIHdhaXRpbmcgZm9yIHRoZSBjb21wbGV0aW9uIGV2ZW50IGluCj4+Pj4gdmhv
c3RfdmRwYV9yZW1vdmUoKS4gSmFzb24gY29uZmlybWVkIHRoaXMgYnkgc2F5aW5nIHRoYXQgd2Ug
bmVlZCBhIG5ldyBldmVudGZkLwo+Pj4+IGlvY3RsIHRvIHJlY2VpdmUgaG90IHJlbW92ZSByZXF1
ZXN0IGZyb20ga2VybmVsLgo+Pj4+Cj4+Pj4KPj4+PiBBbHRob3VnaCwgd2UgY2FuIHByb2NlZWQg
dG8gaW1wbGVtZW50IGNoYW5nZXMgZm9yIHRoZSBwYXJ0IGRlc2NyaWJlZCBhYm92ZSBidXQKPj4+
PiBJIGZlZWwgdGhhdCB0aGF0IHRoZSBwcm9ibGVtIGlzIG11Y2ggZGVlcGVyIHRoYW4gdGhhdC4g
VGhpcyBtZWNoYW5pc20gd2lsbCBqdXN0Cj4+Pj4gcmVxdWVzdCB0aGUgdXNlcnNwYWNlIHRvIGNs
b3NlIHRoZSBmZCBhbmQgbGV0IHZob3N0LXZkcGEgcHJvY2VlZCB3aXRoIHRoZQo+Pj4+IGNsZWFu
LXVwLiBIb3dldmVyLCBJTUhPIHRoaW5ncyBzaG91bGQgYmUgdW5kZXIgbW9yZSBjb250cm9sIG9m
IGtlcm5lbCBzcGFjZQo+Pj4+IHRoYW4gdGhlIHVzZXIgc3BhY2UuCj4+Pj4KPj4+Pgo+Pj4+IFRo
ZSBwcm9ibGVtIEkgYW0gdHJ5aW5nIHRvIGhpZ2hsaWdodCBpcyB0aGF0IGEgbWFsaWNpb3VzIHVz
ZXItc3BhY2UgYXBwbGljYXRpb24KPj4+PiBjYW4gcmVuZGVyIGFueSBtb2R1bGUgcmVnaXN0ZXJp
bmcgYSB2RFBBIGRldmljZSB0byBoYW5nIGluIHRoZWlyCj4+Pj4gZGUtaW5pdGlhbGl6YXRpb24g
c2VxdWVuY2UuIFRoaXMgd2lsbCB0eXBpY2FsbHkgc3VyZmFjZSB3aGVuCj4+Pj4gdmRwYV9kZXZp
Y2VfdW5yZWdpc3RlcigpIGlzIGNhbGxlZCBmcm9tIHRoZSBmdW5jdGlvbiByZXNwb25zaWJsZSBm
b3IgbW9kdWxlCj4+Pj4gdW5sb2FkIGxlYWRpbmcgcm1tb2QgY29tbWFuZHMgdG8gbm90IHJldHVy
biwgZm9yZXZlci4KPj4+Pgo+Pj4+Cj4+Pj4gVG8gcHJvdmUgbXkgcG9pbnQsIEkgY3JlYXRlZCBh
IHNpbXBsZSBDIHByb2dyYW0gKHRlc3RfdmRwYS5jKSB0aGF0IG9wZW5zIHRoZQo+Pj4+IHZob3N0
LXZkcGEgY2hhcmFjdGVyIGRldmljZSBhbmQgbmV2ZXIgZXhpdHMuIFRoZSBsb2dzICh0ZXN0X2xv
Z3MudHh0KSBzaG93IHRoYXQKPj4+PiBhZnRlciByZWdpc3RlcmluZyB0aGUgdkRQQSBkZXZpY2Ug
ZnJvbSBzZmMgZHJpdmVyLCB2aG9zdC12ZHBhIG1vZHVsZSBjcmVhdGVzCj4+Pj4gdGhlIGNoYXIg
ZGV2aWNlIC9kZXYvdmhvc3QtdmRwYS0wICBmb3IgaXQuIEFzIHRoaXMgaXMgYXZhaWxhYmxlIHRv
IGFsbCBhcHBzIGluCj4+Pj4gdGhlIHVzZXJzcGFjZSwgdGhlIG1hbGljaW91cyBhcHAgKC4vYmxv
Y2tfdmRwYV91bmxvYWQpIG9wZW5zIHRoaXMgZGV2aWNlIGFuZAo+Pj4+IGdvZXMgdG8gaW5maW5p
dGUgc2xlZXAuIEF0IHRoaXMgdGltZSwgd2hlbiBtb2R1bGUgdW5sb2FkIChybW1vZCBzZmMpIGlz
IGNhbGxlZCwKPj4+PiBpdCBoYW5ncyBhbmQgdGhlIGZvbGxvd2luZyBwcmludCBpbmZvcm1zIHRo
ZSB1c2VyL2FkbWluIG9mIHRoaXMgc3RhdGUgd2l0aAo+Pj4+IGZvbGxvd2luZyBtZXNzYWdlOgo+
Pj4+Cj4+Pj4gWyA4MTgwLjA1MzY0N10gIHZob3N0LXZkcGEtMDogdmhvc3RfdmRwYV9yZW1vdmUg
d2FpdGluZyBmb3IgL2Rldi92aG9zdC12ZHBhLTAKPj4+PiB0byBiZSBjbG9zZWQKPj4+Pgo+Pj4+
Cj4+Pj4gRmluYWxseSwgd2hlbiBibG9ja192ZHBhX3VubG9hZCBpcyBraWxsZWQsIHZob3N0X3Zk
cGFfcmVtb3ZlKCkgdW5ibG9ja3MgYW5kIHNmYwo+Pj4+IG1vZHVsZSBpcyB1bmxvYWRlZC4KPj4+
Pgo+Pj4+Cj4+Pj4gV2l0aCBzdWNoIGFwcGxpY2F0aW9uIHJ1bm5pbmcgaW4gdXNlcnNwYWNlLCBh
IGtlcm5lbCBtb2R1bGUgKHRoYXQgcmVnaXN0ZXJlZAo+Pj4+IGNvcnJlc3BvbmRpbmcgdkRQQSBk
ZXZpY2UpIHdpbGwgaGFuZyBkdXJpbmcgdW5sb2FkIHNlcXVlbmNlLiBTdWNoIGNvbnRyb2wgb2YK
Pj4+PiB0aGUgdXNlcnNwYWNlIGFwcGxpY2F0aW9uIG9uIHRoZSBzeXN0ZW0gcmVzb3VyY2VzIHNo
b3VsZCBjZXJ0YWlubHkgYmUKPj4+PiBwcmV2ZW50ZWQuCj4+Pj4KPj4+PiBUbyBtZSwgdGhpcyBz
ZWVtcyB0byBiZSBhIHNlcmlvdXMgaXNzdWUgYW5kIHJlcXVpcmVzIG1vZGlmaWNhdGlvbnMgaW4g
dGhlIHdheQo+Pj4+IGl0IGlzIGN1cnJlbnRseSBoYW5kbGVkIGluIHZob3N0LXZkcGEgKGFuZCBv
dGhlciBtb2R1bGVzIChWRklPPykgd2l0aCBzaW1pbGFyCj4+Pj4gaW1wbGVtZW50YXRpb24pLgo+
Pj4+Cj4+Pj4gTGV0IG1lIGtub3cgd2hhdCB5b3UgdGhpbmsuCj4+Pj4KPj4+Pgo+Pj4+IFJlZ2Fy
ZHMsCj4+Pj4KPj4+PiBHYXV0YW0gRGF3YXIKPj4+Pgo+Pj4+ICNpbmNsdWRlIDxzeXMvc3RhdC5o
Pgo+Pj4+ICNpbmNsdWRlIDx1bmlzdGQuaD4KPj4+PiAjaW5jbHVkZSA8c3RkbGliLmg+Cj4+Pj4g
I2luY2x1ZGUgPHN0ZGlvLmg+Cj4+Pj4gI2luY2x1ZGUgPGZjbnRsLmg+Cj4+Pj4gI2luY2x1ZGUg
PGVycm5vLmg+Cj4+Pj4KPj4+PiBpbnQgbWFpbihpbnQgYXJnYywgY2hhciAqKmFyZ3YpCj4+Pj4g
ewo+Pj4+ICAgICAgdW5zaWduZWQgaW50IGluZGV4Owo+Pj4+ICAgICAgY2hhciBkZXZfcGF0aFsz
MF07Cj4+Pj4gICAgICBpbnQgZmQ7Cj4+Pj4KPj4+PiAgICAgIGlmIChhcmdjICE9IDIpIHsKPj4+
PiAJICAgcHJpbnRmKCJVc2FnZTogJXMgPHZob3N0LXZkcGEgZGV2aWNlIGluZGV4PlxuIiwgYXJn
dlswXSk7Cj4+Pj4gCSAgIHJldHVybiAtMTsKPj4+PiAgICAgIH0KPj4+Pgo+Pj4+ICAgICAgaW5k
ZXggPSBzdHJ0b3VsKGFyZ3ZbMV0sIE5VTEwsIDEwKTsKPj4+Pgo+Pj4+ICAgICAgc25wcmludGYo
ZGV2X3BhdGgsIHNpemVvZihkZXZfcGF0aCksICIvZGV2L3Zob3N0LXZkcGEtJXUiLCBpbmRleCk7
Cj4+Pj4gICAgICBmZCA9IG9wZW4oZGV2X3BhdGgsIE9fUkRXUik7Cj4+Pj4gICAgICBpZihmZCA8
IDApCj4+Pj4gICAgICB7Cj4+Pj4gICAgICAgICAgcHJpbnRmKCJGYWlsZWQgdG8gb3BlbiAlcywg
ZXJybm86ICVkIVxuIiwgZGV2X3BhdGgsIGVycm5vKTsKPj4+PiAgICAgICAgICByZXR1cm4gMTsK
Pj4+PiAgICAgIH0KPj4+Pgo+Pj4+ICAgICAgcHJpbnRmKCJCbG9ja2luZyB1bmxvYWQgb2YgZHJp
dmVyIHRoYXQgcmVnaXN0ZXJlZCB2RFBBIGRldmljZSIKPj4+PiAJICAiIGNvcnJlc3BvbmRpbmcg
dG8gY2RldiAlcyBjcmVhdGVkIGJ5IHZob3N0LXZkcGFcbiIsIGRldl9wYXRoKTsKPj4+PiAgICAg
IHdoaWxlICgxKQo+Pj4+IAkgICBzbGVlcCgxKTsKPj4+Pgo+Pj4+ICAgICAgY2xvc2UoZmQpOwo+
Pj4+ICAgICAgcmV0dXJuIDA7Cj4+Pj4gfQo+Pj4+IFtyb290QG5kcjczMHAgfl0jIH4vY3JlYXRl
X3ZkcGFfZGV2aWNlLnNoCj4+Pj4KPj4+PiBbcm9vdEBuZHI3MzBwIH5dIyBsbCAvZGV2L3Zob3N0
LXZkcGEtMAo+Pj4+IGNydy0tLS0tLS0gMSByb290IHJvb3QgMjQwLCAwIEp1biAgNiAxOTo1OSAv
ZGV2L3Zob3N0LXZkcGEtMAo+Pj4+Cj4+Pj4gW3Jvb3RAbmRyNzMwcCB+XSMgLi9ibG9ja192ZHBh
X3VubG9hZCAwICYKPj4+PiBbMV0gMTA5MzAKPj4+PiBCbG9ja2luZyB1bmxvYWQgb2YgZHJpdmVy
IHRoYXQgcmVnaXN0ZXJlZCB2RFBBIGRldmljZSBjb3JyZXNwb25kaW5nIHRvIGNkZXYgL2Rldi92
aG9zdC12ZHBhLTAgY3JlYXRlZCBieSB2aG9zdC12ZHBhCj4+Pj4KPj4+PiBbcm9vdEBuZHI3MzBw
IH5dIyBybW1vZCBzZmMKPj4+PiBbIDgxNzkuMDEwNTIwXSBzZmNfZWYxMDAgMDAwMDowNjowMC40
OiBlZjEwMF92ZHBhX2RlbGV0ZTogQ2FsbGluZyB2ZHBhIHVucmVnaXN0ZXIgZGV2aWNlCj4+Pj4g
WyA4MTgwLjA1MzY0N10gIHZob3N0LXZkcGEtMDogdmhvc3RfdmRwYV9yZW1vdmUgd2FpdGluZyBm
b3IgL2Rldi92aG9zdC12ZHBhLTAgdG8gYmUgY2xvc2VkCj4+Pj4KPj4+PiBbcm9vdEBuZHI3MzBw
IH5dIyBraWxsIC05IDEwOTMwCj4+Pj4gWyA4MjE4LjM5Mjg5N10gc2ZjX2VmMTAwIDAwMDA6MDY6
MDAuMDogc2h1dGRvd24gc3VjY2Vzc2Z1bAo+Pj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVh
bGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZv
dW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
