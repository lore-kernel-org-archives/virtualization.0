Return-Path: <SRS0=ITlz=HH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0F5E6C433E0
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 13:32:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5BB8A64FBC
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 13:32:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5BB8A64FBC
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id F1BFB86A95;
	Fri,  5 Feb 2021 13:32:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BvXrq0SIi5-4; Fri,  5 Feb 2021 13:32:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 69BBE86A8D;
	Fri,  5 Feb 2021 13:32:47 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4935CC08A1;
	Fri,  5 Feb 2021 13:32:47 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 57045C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 13:32:46 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 3B65386A95
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 13:32:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id O-ixyI7kVPv5
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 13:32:45 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4D5F286A75
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 13:32:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612531963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cUMsU3NGZgFC5JmllXsuFgXrYMXysZpJsQ4q9x7smF0=;
 b=JP/P++tDZdFAgwhgP9oSNUxxpsOnE9C+UtVBYlXdQSZZjLHkpUluC9LK1eVGiXMQhsE46t
 RlnX4Wya45wu7qkLjmAKVn8Yx+Ns9P8x/uwWS/0y9TzuuN2mT/dStlmOHEwVuys6Sxtc6x
 Lus8BRexh0GeECRHoHXCpTX6S6sMAdM=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-106-vqkeG8ULPhyKnjULenFhwQ-1; Fri, 05 Feb 2021 08:32:42 -0500
X-MC-Unique: vqkeG8ULPhyKnjULenFhwQ-1
Received: by mail-wr1-f70.google.com with SMTP id o17so5373964wrv.4
 for <virtualization@lists.linux-foundation.org>;
 Fri, 05 Feb 2021 05:32:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=cUMsU3NGZgFC5JmllXsuFgXrYMXysZpJsQ4q9x7smF0=;
 b=WswZj/xdg8IeFWr+OOLZO4HxWWOQySZDcsX+5waV+dv/5mm/jO6xyV44oPasHD62or
 I0a2aYsEEGdtRQQM52+0L/C9TNjBTdqIIT9UsDCNi+A/3dSidqk5xHxhusRjqXPiPfSC
 zexTDU7wb57riqGxNf7tOWRvGoGQ4xm/XLUSPcXO+v7pGvW2TO/q8k/YW8jB4CI+1Pus
 GDvJXU+3cPb49ae9tiiKxqnkGu9T4zl5XOBFvXuWHpWClJfdG6J6FrEdAqqc++3FWY8+
 kuSxL3I+Meee+ZRv6IZ4n/IHRaVtQ7FXbJ6r0J7lPFQC5CHdxIAfOx0Xp6Dnotp3r0Rb
 qO7g==
X-Gm-Message-State: AOAM533A8H2T4VrTSkMj59/P18+BAP64nakcu0RPgrUSp6LYnimYfkbt
 LUvL6KKy0hS13WrxYhc6kzkTBKCJFZ4ZSnPyUdZVAU8W3Q1YyZKZYlajOwUEqtujTHd9HpT+7WM
 d/HkEYhtRQR/n/W1v4MPCcnmDpnXeEl7XFkvuh+4Iuw==
X-Received: by 2002:a1c:4e13:: with SMTP id g19mr3652557wmh.55.1612531960865; 
 Fri, 05 Feb 2021 05:32:40 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzrXwq8EuygZ5k8QiHexM1uR2jRBlALztPICjodh6e2JfoV9w4ZW4+vGzj9tQPGab0c1bYgbQ==
X-Received: by 2002:a1c:4e13:: with SMTP id g19mr3652548wmh.55.1612531960678; 
 Fri, 05 Feb 2021 05:32:40 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id t197sm18819401wmt.3.2021.02.05.05.32.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Feb 2021 05:32:40 -0800 (PST)
Date: Fri, 5 Feb 2021 08:32:37 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefano Garzarella <sgarzare@redhat.com>
Subject: Re: [PATCH v3 09/13] vhost/vdpa: remove vhost_vdpa_config_validate()
Message-ID: <20210205083108-mutt-send-email-mst@kernel.org>
References: <20210204172230.85853-1-sgarzare@redhat.com>
 <20210204172230.85853-10-sgarzare@redhat.com>
 <6919d2d4-cc8e-2b67-2385-35803de5e38b@redhat.com>
 <20210205091651.xfcdyuvwwzew2ufo@steredhat>
MIME-Version: 1.0
In-Reply-To: <20210205091651.xfcdyuvwwzew2ufo@steredhat>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Xie Yongji <xieyongji@bytedance.com>, Stefan Hajnoczi <stefanha@redhat.com>
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

T24gRnJpLCBGZWIgMDUsIDIwMjEgYXQgMTA6MTY6NTFBTSArMDEwMCwgU3RlZmFubyBHYXJ6YXJl
bGxhIHdyb3RlOgo+IE9uIEZyaSwgRmViIDA1LCAyMDIxIGF0IDExOjI3OjMyQU0gKzA4MDAsIEph
c29uIFdhbmcgd3JvdGU6Cj4gPiAKPiA+IE9uIDIwMjEvMi81IOS4iuWNiDE6MjIsIFN0ZWZhbm8g
R2FyemFyZWxsYSB3cm90ZToKPiA+ID4gZ2V0X2NvbmZpZygpIGFuZCBzZXRfY29uZmlnKCkgY2Fs
bGJhY2tzIGluIHRoZSAnc3RydWN0IHZkcGFfY29uZmlnX29wcycKPiA+ID4gdXN1YWxseSBhbHJl
YWR5IHZhbGlkYXRlZCB0aGUgaW5wdXRzLiBBbHNvIG5vdyB0aGV5IGNhbiByZXR1cm4gYW4gZXJy
b3IsCj4gPiA+IHNvIHdlIGRvbid0IG5lZWQgdG8gdmFsaWRhdGUgdGhlbSBoZXJlIGFueW1vcmUu
Cj4gPiA+IAo+ID4gPiBMZXQncyB1c2UgdGhlIHJldHVybiB2YWx1ZSBvZiB0aGVzZSBjYWxsYmFj
a3MgYW5kIHJldHVybiBpdCBpbiBjYXNlIG9mCj4gPiA+IGVycm9yIGluIHZob3N0X3ZkcGFfZ2V0
X2NvbmZpZygpIGFuZCB2aG9zdF92ZHBhX3NldF9jb25maWcoKS4KPiA+ID4gCj4gPiA+IE9yaWdp
bmFsbHktYnk6IFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgo+ID4gPiBTaWdu
ZWQtb2ZmLWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6YXJlQHJlZGhhdC5jb20+Cj4gPiA+
IC0tLQo+ID4gPiAgZHJpdmVycy92aG9zdC92ZHBhLmMgfCA0MSArKysrKysrKysrKysrLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLQo+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEzIGluc2VydGlv
bnMoKyksIDI4IGRlbGV0aW9ucygtKQo+ID4gPiAKPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMv
dmhvc3QvdmRwYS5jIGIvZHJpdmVycy92aG9zdC92ZHBhLmMKPiA+ID4gaW5kZXggZWY2ODhjOGMw
ZTBlLi5kNjFlNzc5MDAwYTggMTAwNjQ0Cj4gPiA+IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5j
Cj4gPiA+ICsrKyBiL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4gPiA+IEBAIC0xODUsNTEgKzE4NSwz
NSBAQCBzdGF0aWMgbG9uZyB2aG9zdF92ZHBhX3NldF9zdGF0dXMoc3RydWN0IHZob3N0X3ZkcGEg
KnYsIHU4IF9fdXNlciAqc3RhdHVzcCkKPiA+ID4gIAlyZXR1cm4gMDsKPiA+ID4gIH0KPiA+ID4g
LXN0YXRpYyBpbnQgdmhvc3RfdmRwYV9jb25maWdfdmFsaWRhdGUoc3RydWN0IHZob3N0X3ZkcGEg
KnYsCj4gPiA+IC0JCQkJICAgICAgc3RydWN0IHZob3N0X3ZkcGFfY29uZmlnICpjKQo+ID4gPiAt
ewo+ID4gPiAtCWxvbmcgc2l6ZSA9IDA7Cj4gPiA+IC0KPiA+ID4gLQlzd2l0Y2ggKHYtPnZpcnRp
b19pZCkgewo+ID4gPiAtCWNhc2UgVklSVElPX0lEX05FVDoKPiA+ID4gLQkJc2l6ZSA9IHNpemVv
ZihzdHJ1Y3QgdmlydGlvX25ldF9jb25maWcpOwo+ID4gPiAtCQlicmVhazsKPiA+ID4gLQl9Cj4g
PiA+IC0KPiA+ID4gLQlpZiAoYy0+bGVuID09IDApCj4gPiA+IC0JCXJldHVybiAtRUlOVkFMOwo+
ID4gPiAtCj4gPiA+IC0JaWYgKGMtPmxlbiA+IHNpemUgLSBjLT5vZmYpCj4gPiA+IC0JCXJldHVy
biAtRTJCSUc7Cj4gPiA+IC0KPiA+ID4gLQlyZXR1cm4gMDsKPiA+ID4gLX0KPiA+ID4gLQo+ID4g
PiAgc3RhdGljIGxvbmcgdmhvc3RfdmRwYV9nZXRfY29uZmlnKHN0cnVjdCB2aG9zdF92ZHBhICp2
LAo+ID4gPiAgCQkJCSAgc3RydWN0IHZob3N0X3ZkcGFfY29uZmlnIF9fdXNlciAqYykKPiA+ID4g
IHsKPiA+ID4gIAlzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEgPSB2LT52ZHBhOwo+ID4gPiAgCXN0
cnVjdCB2aG9zdF92ZHBhX2NvbmZpZyBjb25maWc7Cj4gPiA+ICAJdW5zaWduZWQgbG9uZyBzaXpl
ID0gb2Zmc2V0b2Yoc3RydWN0IHZob3N0X3ZkcGFfY29uZmlnLCBidWYpOwo+ID4gPiArCWxvbmcg
cmV0Owo+ID4gPiAgCXU4ICpidWY7Cj4gPiA+ICAJaWYgKGNvcHlfZnJvbV91c2VyKCZjb25maWcs
IGMsIHNpemUpKQo+ID4gPiAgCQlyZXR1cm4gLUVGQVVMVDsKPiA+ID4gLQlpZiAodmhvc3RfdmRw
YV9jb25maWdfdmFsaWRhdGUodiwgJmNvbmZpZykpCj4gPiA+ICsJaWYgKGNvbmZpZy5sZW4gPT0g
MCkKPiA+ID4gIAkJcmV0dXJuIC1FSU5WQUw7Cj4gPiA+ICAJYnVmID0ga3Z6YWxsb2MoY29uZmln
LmxlbiwgR0ZQX0tFUk5FTCk7Cj4gPiAKPiA+IAo+ID4gVGhlbiBpdCBtZWFucyB1c2Vyc2FwY2Ug
Y2FuIGFsbG9jYXRlIGEgdmVyeSBsYXJnZSBtZW1vcnkuCj4gCj4gR29vZCBwb2ludC4KPiAKPiA+
IAo+ID4gUmV0aGluayBhYm91dCB0aGlzLCB3ZSBzaG91bGQgbGltaXQgdGhlIHNpemUgaGVyZSAo
ZS5nIFBBR0VfU0laRSkgb3IKPiA+IGZldGNoIHRoZSBjb25maWcgc2l6ZSBmaXJzdCAoZWl0aGVy
IHRocm91Z2ggYSBjb25maWcgb3BzIGFzIHlvdQo+ID4gc3VnZ2VzdGVkIG9yIGEgdmFyaWFibGUg
aW4gdGhlIHZkcGEgZGV2aWNlIHRoYXQgaXMgaW5pdGlhbGl6ZWQgZHVyaW5nCj4gPiBkZXZpY2Ug
Y3JlYXRpb24pLgo+IAo+IE1heWJlIFBBR0VfU0laRSBpcyBva2F5IGFzIGEgbGltaXQuCj4gCj4g
SWYgaW5zdGVhZCB3ZSB3YW50IHRvIGZldGNoIHRoZSBjb25maWcgc2l6ZSwgdGhlbiBiZXR0ZXIg
YSBjb25maWcgb3BzIGluIG15Cj4gb3BpbmlvbiwgdG8gYXZvaWQgYWRkaW5nIGEgbmV3IHBhcmFt
ZXRlciB0byBfX3ZkcGFfYWxsb2NfZGV2aWNlKCkuCj4gCj4gSSB2b3RlIGZvciBQQUdFX1NJWkUs
IGJ1dCBpdCBpc24ndCBhIHN0cm9uZyBvcGluaW9uLgo+IAo+IFdoYXQgZG8geW91IGFuZCBATWlj
aGFlbCBzdWdnZXN0Pwo+IAo+IFRoYW5rcywKPiBTdGVmYW5vCgpEZXZpY2VzIGtub3cgd2hhdCB0
aGUgY29uZmlnIHNpemUgaXMuIEp1c3QgaGF2ZSB0aGVtIHByb3ZpZGUgaXQuCgotLSAKTVNUCgpf
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXph
dGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5v
cmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmly
dHVhbGl6YXRpb24=
