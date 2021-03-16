Return-Path: <SRS0=cXtE=IO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED2D4C433DB
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 13:37:59 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 7924565053
	for <virtualization@archiver.kernel.org>; Tue, 16 Mar 2021 13:37:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 7924565053
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 28FE16F61F;
	Tue, 16 Mar 2021 13:37:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dC9fdm0TSTOT; Tue, 16 Mar 2021 13:37:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTP id C4ADF6F556;
	Tue, 16 Mar 2021 13:37:57 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id ABEABC000C;
	Tue, 16 Mar 2021 13:37:57 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 87C36C000A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 13:37:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 7306A6F61F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 13:37:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wCOXFMV7UfSW
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 13:37:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 2529F6F556
 for <virtualization@lists.linux-foundation.org>;
 Tue, 16 Mar 2021 13:37:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1615901873;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=32Ozy+oFD/uqS3a2w0ZBo9N3EccYioe/8gLdagjbvFw=;
 b=gp+8E+tmBKj6K5LeAmsJRT8Vndqw7lNeduwnUmik8QD8urENEhMm6V8abJvMhu5oSFJMVP
 FLbpg5mqy/yQOjxWoZ3z5nyIVYCPiY17OR+8Y8FvvfGavYJECJuM8HJj+iUZHgOCxAAy5e
 IxU3Wb9AakaTAlvQbeiUi3k5/F9w9NQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-345-WbdpTnM0M8mbVS2TGK7NQQ-1; Tue, 16 Mar 2021 09:37:52 -0400
X-MC-Unique: WbdpTnM0M8mbVS2TGK7NQQ-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com
 [10.5.11.15])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 719978CE1CE;
 Tue, 16 Mar 2021 13:37:34 +0000 (UTC)
Received: from [10.3.113.66] (ovpn-113-66.phx2.redhat.com [10.3.113.66])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 40ADB62AF8;
 Tue, 16 Mar 2021 13:37:28 +0000 (UTC)
Subject: Re: [RFC v2 04/13] vhost: Add x-vhost-enable-shadow-vq qmp
To: =?UTF-8?Q?Eugenio_P=c3=a9rez?= <eperezma@redhat.com>, qemu-devel@nongnu.org
References: <20210315194842.277740-1-eperezma@redhat.com>
 <20210315194842.277740-5-eperezma@redhat.com>
From: Eric Blake <eblake@redhat.com>
Organization: Red Hat, Inc.
Message-ID: <9040df60-b931-4973-f302-bc5ef9c91152@redhat.com>
Date: Tue, 16 Mar 2021 08:37:27 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210315194842.277740-5-eperezma@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=eblake@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: Parav Pandit <parav@mellanox.com>, "Michael S. Tsirkin" <mst@redhat.com>,
 Guru Prasad <guru.prasad@broadcom.com>,
 virtualization@lists.linux-foundation.org,
 Harpreet Singh Anand <hanand@xilinx.com>, Xiao W Wang <xiao.w.wang@intel.com>,
 Eli Cohen <eli@mellanox.com>, Michael Lilja <ml@napatech.com>,
 Jim Harford <jim.harford@broadcom.com>, Rob Miller <rob.miller@broadcom.com>
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

T24gMy8xNS8yMSAyOjQ4IFBNLCBFdWdlbmlvIFDDqXJleiB3cm90ZToKPiBDb21tYW5kIHRvIGVu
YWJsZSBzaGFkb3cgdmlydHF1ZXVlIGxvb2tzIGxpa2U6Cj4gCj4geyAiZXhlY3V0ZSI6ICJ4LXZo
b3N0LWVuYWJsZS1zaGFkb3ctdnEiLCAiYXJndW1lbnRzIjogeyAibmFtZSI6ICJkZXYwIiwgImVu
YWJsZSI6IHRydWUgfSB9Cj4gCj4gU2lnbmVkLW9mZi1ieTogRXVnZW5pbyBQw6lyZXogPGVwZXJl
em1hQHJlZGhhdC5jb20+Cj4gLS0tCj4gIHFhcGkvbmV0Lmpzb24gICAgIHwgMjIgKysrKysrKysr
KysrKysrKysrKysrKwo+ICBody92aXJ0aW8vdmhvc3QuYyB8ICA2ICsrKysrKwo+ICAyIGZpbGVz
IGNoYW5nZWQsIDI4IGluc2VydGlvbnMoKykKPiAKPiBkaWZmIC0tZ2l0IGEvcWFwaS9uZXQuanNv
biBiL3FhcGkvbmV0Lmpzb24KPiBpbmRleCBjMzE3NDhjODdmLi40YzVmNjVkMDIxIDEwMDY0NAo+
IC0tLSBhL3FhcGkvbmV0Lmpzb24KPiArKysgYi9xYXBpL25ldC5qc29uCj4gQEAgLTc3LDYgKzc3
LDI4IEBACj4gICMjCj4gIHsgJ2NvbW1hbmQnOiAnbmV0ZGV2X2RlbCcsICdkYXRhJzogeydpZCc6
ICdzdHInfSB9Cj4gIAo+ICsjIwo+ICsjIEB4LXZob3N0LWVuYWJsZS1zaGFkb3ctdnE6Cj4gKyMK
PiArIyBVc2Ugdmhvc3Qgc2hhZG93IHZpcnRxdWV1ZS4KPiArIwo+ICsjIEBuYW1lOiB0aGUgZGV2
aWNlIG5hbWUgb2YgdGhlIFZpcnRJTyBkZXZpY2UKPiArIwo+ICsjIEBlbmFibGU6IHRydWUgdG8g
dXNlIGhlIGFsdGVybmF0ZSBzaGFkb3cgVlEgbm90aWZpY2F0aW9uIHBhdGgKPiArIwo+ICsjIFJl
dHVybnM6IEVycm9yIGlmIGZhaWx1cmUsIG9yICdubyBlcnJvcicgZm9yIHN1Y2Nlc3MuIE5vdCBm
b3VuZCBpZiB2aG9zdCBpcyBub3QgZW5hYmxlZC4KPiArIwo+ICsjIFNpbmNlOiA2LjAKPiArIwo+
ICsjIEV4YW1wbGU6Cj4gKyMKPiArIyAtPiB7ICJleGVjdXRlIjogIngtdmhvc3QtZW5hYmxlLXNo
YWRvdy12cSIsICJhcmd1bWVudHMiOiB7ICJuYW1lIjogInZpcnRpby1uZXQiLCAiZW5hYmxlIjog
ZmFsc2UgfSB9CgpMb25nIGxpbmVzOyBwbGVhc2Ugd3JhcCB0byBrZWVwIHVuZGVyIDgwIGNvbHVt
bnMuCgotLSAKRXJpYyBCbGFrZSwgUHJpbmNpcGFsIFNvZnR3YXJlIEVuZ2luZWVyClJlZCBIYXQs
IEluYy4gICAgICAgICAgICsxLTkxOS0zMDEtMzIyNgpWaXJ0dWFsaXphdGlvbjogIHFlbXUub3Jn
IHwgbGlidmlydC5vcmcKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5s
aW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFp
bG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
