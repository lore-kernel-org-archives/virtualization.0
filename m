Return-Path: <SRS0=7x/u=EF=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 473BDC2D0A3
	for <virtualization@archiver.kernel.org>; Fri, 30 Oct 2020 01:24:22 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A844F206B5
	for <virtualization@archiver.kernel.org>; Fri, 30 Oct 2020 01:24:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="QYNiiNbU"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org A844F206B5
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 15D5484D49;
	Fri, 30 Oct 2020 01:24:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id mA-2bfdeoSyN; Fri, 30 Oct 2020 01:24:20 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6B80284B8F;
	Fri, 30 Oct 2020 01:24:20 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 544B8C088B;
	Fri, 30 Oct 2020 01:24:20 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 68F0AC0051
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 01:24:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 500FE85AD6
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 01:24:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 0-igIvnu8G-L
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 01:24:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 8DC8F85A6E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 30 Oct 2020 01:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1604021057;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=bQyRgbJ3/l+vJVJDtTjuVGXBelnseiL1niBB0iYvzho=;
 b=QYNiiNbUFovC4UBV6fvCl7Ydw+XPynuOfEWb++AZHVwySsyURfVdDcHXYOj+F9cQBq32+p
 qCcKJn0Hw/Up5PkWjFlgVFu0ypRwTfAV7CC0+R2CftkQDFrPERen+LAH3f3mif1L+SqGUd
 6FyVSMtaOrcjjkv6j9NjmhWVLKuYX/s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-408-nKiaQDVyNZqJuHKC09Ghuw-1; Thu, 29 Oct 2020 21:24:15 -0400
X-MC-Unique: nKiaQDVyNZqJuHKC09Ghuw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 53EBD1868400;
 Fri, 30 Oct 2020 01:24:14 +0000 (UTC)
Received: from [10.72.12.249] (ovpn-12-249.pek2.redhat.com [10.72.12.249])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 1358110027A5;
 Fri, 30 Oct 2020 01:24:09 +0000 (UTC)
Subject: Re: [PATCH 0/2] vdpasim: allow to set MAC address
To: Laurent Vivier <lvivier@redhat.com>, linux-kernel@vger.kernel.org
References: <20201029122050.776445-1-lvivier@redhat.com>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <105012ef-7dd2-728d-0885-521c14ae7a9c@redhat.com>
Date: Fri, 30 Oct 2020 09:24:08 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20201029122050.776445-1-lvivier@redhat.com>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Cc: virtualization@lists.linux-foundation.org,
 "Michael S. Tsirkin" <mst@redhat.com>
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

Ck9uIDIwMjAvMTAvMjkg5LiL5Y2IODoyMCwgTGF1cmVudCBWaXZpZXIgd3JvdGU6Cj4gVGhpcyBz
ZXJpZXMgc3RhcnRzIGJ5IGZpeGluZyBhIGJ1ZzoKPiB2ZHBhX3NpbSBnZW5lcmF0ZXMgYSBNQUMg
YWRkcmVzcyB0aGF0IGlzIG5ldmVyIHNob3cgdG8KPiB1cHBlciBsYXllciwgYW5kIHRodXMgdmly
dGlvLW5ldCBnZW5lcmF0ZXMgYW5vdGhlciByYW5kb20KPiBNQUMgYWRkcmVzcywgdGhhdCBjaGFu
Z2VzIGVhY2ggdGltZSB2aXJ0aW8tbmV0IGlzIGxvYWRlZAo+IChldmVuIGlmIHZkcGFfc2ltIGlz
IG5vdCB1bmxvYWRlZCkuCj4KPiBUaGVuIGl0IGFkZHMgYSBwYXJhbWV0ZXIgdG8gdnBhX3NpbSBt
b2R1bGUgdG8gYWxsb3cgdGhlIHVzZXIgdG8KPiBzZXQgdGhlIE1BQyBhZGRyZXNzLiBXaXRoIHRo
YXQgd2UgdXNlIHZkcGFfc2ltIHdpdGggYSBzdGFibGUKPiBNQUMgYWRkcmVzLCB0aGF0IGRvZXNu
J3QgY2hhbmdlIGJldHdlZW4gcmVib290cy4KPgo+IExhdXJlbnQgVml2aWVyICgyKToKPiAgICB2
ZHBhc2ltOiBmaXggTUFDIGFkZHJlc3MgY29uZmlndXJhdGlvbgo+ICAgIHZkcGFzaW06IGFsbG93
IHRvIGFzc2lnbiBhIE1BQyBhZGRyZXNzCj4KPiAgIGRyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBh
X3NpbS5jIHwgMTcgKysrKysrKysrKysrKysrLS0KPiAgIDEgZmlsZSBjaGFuZ2VkLCAxNSBpbnNl
cnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQo+CgpBY2tlZC1ieTogSmFzb24gV2FuZyA8amFzb3dh
bmdAcmVkaGF0LmNvbT4KCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
