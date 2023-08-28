Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DE417C83F10
	for <virtualization@archiver.kernel.org>; Mon, 28 Aug 2023 04:44:07 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 588C08175C;
	Mon, 28 Aug 2023 04:44:07 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 588C08175C
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=gl6Eoabz
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dUcTTawGnzap; Mon, 28 Aug 2023 04:44:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 173DA81774;
	Mon, 28 Aug 2023 04:44:06 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 173DA81774
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DBB33C0071;
	Mon, 28 Aug 2023 04:44:05 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id A8D21C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Aug 2023 04:44:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 7B56781774
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Aug 2023 04:44:04 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7B56781774
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id yCQ_bn-_zJ4W
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Aug 2023 04:44:03 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id A59AA8175C
 for <virtualization@lists.linux-foundation.org>;
 Mon, 28 Aug 2023 04:44:03 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A59AA8175C
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1693197841;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=Fi86TLb/jHVvg9zjn7XHlWr0cwJimP6upmcGlNZVzgY=;
 b=gl6Eoabzry/KtpaYlImFgtZwpGUGxRjz4ZiClAWuR24BjqhYBDR8/O6jjRYh8q9/jZ+Ca3
 XUM1jvmhVWxOEow9/YbrLxpvInIEZZEKSDiQl3OeBxrYZtfsQE0L/TrjmTc0/y1T4LwuHj
 YsnRuSeUxXkD7LQ7sl33at5O6b6iJ3o=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-693-PHRTpFa0OFyFD2Sd8Q9Rqg-1; Mon, 28 Aug 2023 00:43:59 -0400
X-MC-Unique: PHRTpFa0OFyFD2Sd8Q9Rqg-1
Received: by mail-ej1-f72.google.com with SMTP id
 a640c23a62f3a-94a355c9028so206588366b.3
 for <virtualization@lists.linux-foundation.org>;
 Sun, 27 Aug 2023 21:43:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1693197839; x=1693802639;
 h=in-reply-to:content-transfer-encoding:content-disposition
 :mime-version:references:message-id:subject:cc:to:from:date
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
 bh=Fi86TLb/jHVvg9zjn7XHlWr0cwJimP6upmcGlNZVzgY=;
 b=Xx/b/mKVfK+lygP4XEPV92/RqI80t3ZHZ7srOUF7by4olV+F1aKyE/vsOYgtFaiex9
 6hyBuB9gUmDXKgzP+yB/3MCCx9QBSIIY8zaDdwCxzAuwZJnzzQp6lDlu89azsfiJ7KRy
 umzUCVY41v/R4aPQaWsPuvLDcQEopdPuZdg3zJefa+T0YbAeQa8Q+nNpGVPnj2R+XnzE
 E+fq94o7kTl7l1H6t22rMZhm3YJEIr/pYTwvRoJP+qJLgVbFf2Jq74SL17EVZXvoA1am
 iUGTMjSUa6wdS3byhJfySlF5UaR96nC9F48zkerlMzdVk9wNJHMzSbqqeD+2YidAKqZQ
 Up1g==
X-Gm-Message-State: AOJu0YyFD+4ubH/9QhsPdYLMXMSFkX+QNKGVrrmVtbNR6QhHsx7f2dZD
 Orv7AO67zNBPn6jGK2rlwq13v3C7XxmKKkPAdgsKlRcTVYGayQTziVm/5gAZpWocOXdiCLPaatD
 ptFgRrxXfMxyIFQ//eZYZyTUKZ7KQDy3UO13wrh6deg==
X-Received: by 2002:a17:906:2102:b0:99d:e8da:c20b with SMTP id
 2-20020a170906210200b0099de8dac20bmr17292943ejt.24.1693197838865; 
 Sun, 27 Aug 2023 21:43:58 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGWMCQLqR83SRHv6bXmH/xQXTYbezZysqjUu1htVMzC8mLUN54SpnfBWNxtyVsQbnhcqrpwWg==
X-Received: by 2002:a17:906:2102:b0:99d:e8da:c20b with SMTP id
 2-20020a170906210200b0099de8dac20bmr17292931ejt.24.1693197838501; 
 Sun, 27 Aug 2023 21:43:58 -0700 (PDT)
Received: from redhat.com ([2.52.30.217]) by smtp.gmail.com with ESMTPSA id
 y22-20020a17090614d600b0099cfd0b2437sm4206104ejc.99.2023.08.27.21.43.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 27 Aug 2023 21:43:57 -0700 (PDT)
Date: Mon, 28 Aug 2023 00:43:53 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yuan Yao <yuanyaogoog@chromium.org>
Subject: Re: [PATCH] virtio_ring: fix avail_wrap_counter in
 virtqueue_add_packed
Message-ID: <20230828004323-mutt-send-email-mst@kernel.org>
References: <20230808051110.3492693-1-yuanyaogoog@chromium.org>
 <CACGkMEt53ziY_bmgJHVdJ6pkppTyVqKX3=Czygv+yhJR8_KiFA@mail.gmail.com>
 <CAOJyEHaXqmHStJnHrT0H4QsTJBxjBxVe+33EuWm9H3wApPKtxQ@mail.gmail.com>
 <CACGkMEuiVnLFRRDHaTH3Jnpr+znU9L33gLyRynbBabVqumN2ug@mail.gmail.com>
 <CAOJyEHaR1Y3VsKNpLqxf-ewAEf8JJDChjmnFM_0mv=hOg+X-vA@mail.gmail.com>
 <20230808051304-mutt-send-email-mst@kernel.org>
 <CAOJyEHYgvw7za0ksKNPu9TF1+8MwVFbctMbukgbAoQnf9da+hA@mail.gmail.com>
 <CAOJyEHZs=59nZ=XTYu-mZWTz18OT7f6TknCxWksYeQZbPy2oUQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAOJyEHZs=59nZ=XTYu-mZWTz18OT7f6TknCxWksYeQZbPy2oUQ@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Junichi Uekawa <uekawa@chromium.org>, LKML <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, Takaya Saeki <takayas@chromium.org>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 "David S. Miller" <davem@davemloft.net>
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

Tm9wZSAtIGl0IHdpbGwgYmUgaW4gdGhlIG5leHQgbGludXggcmVsZWFzZS4KCk9uIE1vbiwgQXVn
IDI4LCAyMDIzIGF0IDEyOjMzOjQ2UE0gKzA5MDAsIFl1YW4gWWFvIHdyb3RlOgo+IEknbSB3cml0
aW5nwqB0byBjb25maXJtIHRoZSBwcm9jZXNzIGZvciB0aGUgcGF0Y2gswqBzaW5jZSBJJ20gbm90
IHN1cmUgaWYgdGhpcwo+IHRocmVhZCBpcyBkb25lIGZvciB0aGlzIHBhdGNoLgo+IERvIEkgbmVl
ZCBhbnkgZnVydGhlciBzdGVwcyB0byB0YWtlIHRvIG1ha2UgdGhpcyBwYXRjaCBiZSBsYXVuY2hl
ZD8KPiAKPiBPbiBUdWUsIEF1ZyA4LCAyMDIzIGF0IDc6MDDigK9QTSBZdWFuIFlhbyA8eXVhbnlh
b2dvb2dAY2hyb21pdW0ub3JnPiB3cm90ZToKPiAKPiAgICAgU29ycnkgZm9yIHRoZSBjb25mdXNp
bmcgbWFpbCwgSSBkaWRuJ3QgdW5kZXJzdGFuZMKgaG93IGl0IHdvcmtzLgo+ICAgICBUaGFua3MK
PiAKPiAgICAgT24gVHVlLCBBdWcgOCwgMjAyMyBhdCA2OjEz4oCvUE0gTWljaGFlbCBTLiBUc2ly
a2luIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gCj4gICAgICAgICBPbiBUdWUsIEF1ZyAwOCwg
MjAyMyBhdCAwNTozNzoyOVBNICswOTAwLCBZdWFuIFlhbyB3cm90ZToKPiAgICAgICAgID4gVGhh
bmsgeW91IGZvciByZXZpZXdpbmcsIHNlbnQgYSBwYXRjaCB3aXRoIHlvdXIgYWNrLgo+IAo+ICAg
ICAgICAgRG9uJ3QgZG8gdGhpcyBwbHMuIEFuZCBkb24ndCB0b3AgcG9zdCBwbGVhc2UuCj4gCj4g
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
