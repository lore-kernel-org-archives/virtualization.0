Return-Path: <SRS0=5nkl=M3=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33E65C432BE
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 15:24:01 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D44EC60C51
	for <virtualization@archiver.kernel.org>; Wed,  4 Aug 2021 15:24:00 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org D44EC60C51
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 897EF40431;
	Wed,  4 Aug 2021 15:24:00 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Q0kwkRw4KJzk; Wed,  4 Aug 2021 15:23:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id D332540169;
	Wed,  4 Aug 2021 15:23:58 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id A3AC4C0010;
	Wed,  4 Aug 2021 15:23:58 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 068F2C000E
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 15:23:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 016414023A
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 15:23:57 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ccClyodu6Jtb
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 15:23:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 9135A40169
 for <virtualization@lists.linux-foundation.org>;
 Wed,  4 Aug 2021 15:23:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1628090634;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=FOnK+veu0wWChnkChEJGDHGZFXwH5RbR5XEsiBmdrMU=;
 b=a+2sCDTbEWPU6D5Ukc1TzLovbElEa39QaZG53MVxV+Hvbb1OiydwMIJYBNYR1rfxHiFqSz
 CXW9Jzli7NWQsg78yHIRlo07IoUxWR+xDxABF1w3tjTl0noREdhQ47eiCwyWouwevkOP6Y
 tg/Ce+oWPy3Z+yh5cHr8dzOd7DxaGzE=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-135-ViQ_hyfDPn61zefuQVX5sQ-1; Wed, 04 Aug 2021 11:23:53 -0400
X-MC-Unique: ViQ_hyfDPn61zefuQVX5sQ-1
Received: by mail-ed1-f72.google.com with SMTP id
 s8-20020a0564025208b02903bd8539e1caso1609493edd.22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 04 Aug 2021 08:23:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=FOnK+veu0wWChnkChEJGDHGZFXwH5RbR5XEsiBmdrMU=;
 b=GrXPlUig4Rl6N3y8r/G+gqgIOdSDqBFkJXI/ainea23heupjJXA2rIHGDzl29P1JOP
 NQRpthaZxi9ZYkeVCbD40tBMLhTVZVEPG/bM1BMFLFiHGNBdSbB4D1etx5/dHmVESOcN
 aoNZAcMhFsYe7nvl5rZR4Va7Ad6V7pZFEDaMmAhH3/4tx9kXQob0ZArEo7m1nx+s8ufc
 GKyIL4XSW5qyFAUmLD93DXY608MhBqa2Ga35HtDFgduKwhKYgCKUPXu1jB6Hg3LkRrlE
 7IwQaG6txXPbgk4n87jTuk7M3iHuh4kVdEta32DomfcSG3HOafVDDh4sszlhe9xdq4XC
 qQMw==
X-Gm-Message-State: AOAM532ziRAvKpzPrvKbfIZVSq0vI6no0ja38xp8ipKnP0HTit2MUJ+W
 qDIPuSZdRHoLjgYPjF7oYLpY4LX7DH1JBIapsRKKepHqt7J7cD5yYoimPP5y7dXue5OEtCwRvTh
 VoSKy5r/dXQTxaMN4EIP9k1i24LgE0YfKCr8YSk/q2w==
X-Received: by 2002:a05:6402:184b:: with SMTP id
 v11mr279745edy.267.1628090631912; 
 Wed, 04 Aug 2021 08:23:51 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz/39HeEjVjl3cpnIoTdSCpE59bH+X7ttEEVWnEzeo9TkvSQoRZJeV8fS+jTMea1+k26xJCDw==
X-Received: by 2002:a05:6402:184b:: with SMTP id
 v11mr279724edy.267.1628090631769; 
 Wed, 04 Aug 2021 08:23:51 -0700 (PDT)
Received: from steredhat (host-79-18-148-79.retail.telecomitalia.it.
 [79.18.148.79])
 by smtp.gmail.com with ESMTPSA id nd14sm736547ejc.113.2021.08.04.08.23.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 04 Aug 2021 08:23:51 -0700 (PDT)
Date: Wed, 4 Aug 2021 17:23:49 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: =?utf-8?B?5YKF5YWz5Lie?= <fuguancheng@bytedance.com>
Subject: Re: [External] Re: [PATCH 0/4] Add multi-cid support for vsock driver
Message-ID: <20210804152349.o4vh233xjdruh4pv@steredhat>
References: <20210802120720.547894-1-fuguancheng@bytedance.com>
 <20210802134251.hgg2wnepia4cjwnv@steredhat>
 <CAKv9dH5KbN25m8_Wmej9WXgJWheRV5S-tyPCdjUHHEFoWk-V1w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAKv9dH5KbN25m8_Wmej9WXgJWheRV5S-tyPCdjUHHEFoWk-V1w@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: andraprs@amazon.com, kvm@vger.kernel.org,
 "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 stefanha@redhat.com, Colin King <colin.king@canonical.com>, kuba@kernel.org,
 arseny.krasnov@kaspersky.com, davem@davemloft.net
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

T24gV2VkLCBBdWcgMDQsIDIwMjEgYXQgMDM6MDk6NDFQTSArMDgwMCwg5YKF5YWz5LieIHdyb3Rl
Ogo+U29ycnkgSSBjYW5ub3QgZmlndXJlIG91dCBhIGdvb2QgdXNlIGNhc2UuCj4KPkl0IGlzIG5v
cm1hbCBmb3IgYSBob3N0IHRvIGhhdmUgbXVsdGlwbGUgaXAgYWRkcmVzc2VzIHVzZWQgZm9yCj5j
b21tdW5pY2F0aW9uLgo+U28gSSB0aG91Z2h0IGl0IG1pZ2h0IGJlIG5pY2UgdG8gaGF2ZSBib3Ro
ICBob3N0IGFuZCBndWVzdCB1c2UgbXVsdGlwbGUKPkNJRHMgZm9yIGNvbW11bmljYXRpb24uCj5J
IGtub3cgdGhpcyBpcyBub3QgYSB2ZXJ5IHN0cm9uZyBhcmd1bWVudC4KCk1heWJlIHRoZXJlIGNv
dWxkIGJlIGEgdXNlIGNhc2UgZm9yIGd1ZXN0cyAod2hpY2ggSSBkb24ndCBzZWUgbm93KSwgYnV0
IApmb3IgdGhlIGhvc3QgaXQgc2VlbXMgcG9pbnRsZXNzLiBUaGUgc3RyZW5ndGggb2YgdnNvY2sg
aXMgdGhhdCB0aGUgZ3Vlc3QgCmtub3dzIHRoYXQgdXNpbmcgQ0lEPTIgYWx3YXlzIHJlYWNoZXMg
dGhlIGhvc3QuCgpNb3Jlb3ZlciB3ZSBoYXZlIHJlY2VudGx5IG1lcmdlZCBWTUFERFJfRkxBR19U
T19IT1NUIHRoYXQgd2hlbiBzZXQgCmFsbG93cyB5b3UgdG8gZm9yd2FyZCBhbnkgcGFja2V0IHRv
IHRoZSBob3N0LCByZWdhcmRsZXNzIG9mIHRoZSBDSUQgKG5vdCAKeWV0IHN1cHBvcnRlZCBieSB2
aG9zdC12c29jaykuCgo+Cj5UaGUgdnNvY2sgZHJpdmVyIGRvZXMgbm90IHdvcmsgaWYgb25lIG9m
IHRoZSB0d28gcGVlcnMgZG9lc24ndCBzdXBwb3J0Cj5tdWx0aXBsZSBDSURzLgoKVGhpcyBpcyBh
YnNvbHV0ZWx5IHRvIGJlIGF2b2lkZWQuCgpJIHRoaW5rIHRoZSB2aXJ0aW8gZGV2aWNlIGZlYXR1
cmUgbmVnb3RpYXRpb24gY2FuIGhlbHAgaGVyZS4KCj4KPkkgaGF2ZSBhIHBvc3NpYmxlIHNvbHV0
aW9uIGhlcmUsIGJ1dCB0aGVyZSBtYXkgYmUgc29tZSBwcm9ibGVtcyB3aXRoIGl0Cj50aGF0IEkg
aGF2ZW4ndCBub3RpY2VkLgo+Cj5IeXBlcnZpc29ycyB3aWxsIHVzZSBkaWZmZXJlbnQgd2F5cyB0
byBzZW5kIENJRHMgc2V0dXAgdG8gdGhlIGtlcm5lbCBiYXNlZAo+b24gdGhlaXIgdnNvY2sgc2V0
dXAuCj4KPi0tLS0tLUZvciBob3N0LS0tLS0tLQo+SWYgaG9zdCB2c29jayBkcml2ZXIgc3VwcG9y
dHMgbXVsdGktY2lkLCB0aGUgaHlwZXJ2aXNvciB3aWxsIHVzZSB0aGUKPm1vZGlmaWVkIFZIT1NU
X1ZTT0NLX1NFVF9HVUVTVF9DSUQgY2FsbCB0byBzZXQgaXRzIENJRHMuCj5PdGhlcndpc2UsIHRo
ZSBvcmlnaW5hbCBjYWxsIGlzIHVzZWQuCj4KPi0tLS0tLUZvciBndWVzdC0tLS0tLS0KPk5vdyB0
aGUgdmlydGlvX3Zzb2NrX2NvbmZpZyBsb29rcyBsaWtlIHRoaXM6Cj51NjQgZ3Vlc3RfY2lkCj51
MzIgbnVtX2d1ZXN0X2NpZDsKPnUzMiBudW1faG9zdF9jaWQ7Cj51MzIgaW5kZXg7Cj51NjQgY2lk
Owo+Cj5JZiB0aGUgZ3Vlc3QgdnNvY2sgZHJpdmVyIHN1cHBvcnRzIG11bHRpLWNpZCwgaXQgd2ls
bCByZWFkIG51bV9ndWVzdF9jaWQKPmFuZCBudW1faG9zdF9jaWQgZnJvbSB0aGUgZGV2aWNlIGNv
bmZpZyBzcGFjZS4KPlRoZW4gaXQgd3JpdGVzIGFuIGluZGV4IHJlZ2lzdGVyLCB3aGljaCBpcyB0
aGUgY2lkIGl0IHdhbnRzIHRvIHJlYWQuICBBZnRlcgo+aHlwZXJ2aXNvcnMgaGFuZGxlIHRoaXMg
aXNzdWUsIGl0IGNhbiByZWFkIHRoZSBjaWQKPmZyb20gdGhlIGNpZCByZWdpc3Rlci4KPgo+SWYg
aXQgZG9lcyBub3Qgc3VwcG9ydCBtdWx0aS1jaWQsIGl0IHdpbGwganVzdCByZWFkIHRoZSBndWVz
dF9jaWQgZnJvbSB0aGUKPmNvbmZpZyBzcGFjZSwgd2hpY2ggc2hvdWxkIHdvcmsganVzdCBmaW5l
Lgo+CgpXaHkgbm90IGFkZCBhIG5ldyBkZXZpY2UgZmVhdHVyZSB0byBlbmFibGUgb3IgZGlzYWJs
ZSBtdWx0aS1jaWQ/CgoKPgo+LS0tLS0tLUNvbW11bmljYXRpb24tLS0tLS0tLQo+Rm9yIGNvbW11
bmljYXRpb24gaXNzdWVzLCB3ZSBtaWdodCBuZWVkIHRvIHVzZSBhIG5ldyBmZWF0dXJlIGJpdC4g
IExldCdzCj5jYWxsIGl0IFZIT1NUX1ZTT0NLX1NVUFBPUlRfTVVMVElfQ0lELgo+VGhlIGJhc2lj
IGlkZWEgaXMgdGhhdCB0aGlzIGZlYXR1cmUgYml0IGlzIHNldCB3aGVuIGJvdGggaG9zdCBhbmQg
Z3Vlc3QKPnN1cHBvcnQgdXNpbmcgbXVsdGlwbGUgQ0lEcy4gIEFmdGVyIG5lZ290aWF0aW9uLCBp
ZiB0aGUgZmVhdHVyZSBiaXQKPmlzIHNldCwgdGhlIGhvc3QgY2FuIHVzZSBhbGwgdGhlIENJRHMg
c3BlY2lmaWVkIHRvIGNvbW11bmljYXRlIHdpdGggdGhlCj5ndWVzdC4gIE90aGVyd2lzZSwgdGhl
IGZpcnN0IGNpZCBwYXNzZWQgaW4gd2lsbAo+YmUgdXNlZCBhcyB0aGUgZ3Vlc3RfY2lkIHRvIGNv
bW11bmljYXRlIHdpdGggZ3Vlc3RzLgoKSSB0aGluayB0aGUgc2FtZSBmZWF0dXJlIGJpdCBjYW4g
YmUgdXNlZCBmb3IgdGhlIHZpcnRpb192c29ja19jb25maWcsIApubz8KCj4KPkFsc28sIGlmIHRo
ZSBiaXQgaXMgc2V0IGZvciBndWVzdHMsIGFsbCB0aGUgQ0lEcyBjYW4gYmUgdXNlZCB0byBjb21t
dW5pY2F0ZQo+d2l0aCB0aGUgaG9zdC4gIE90aGVyd2lzZSwgdGhlIGZpcnN0IGNpZCB3aXRoIGlu
ZGV4IDAgd2lsbCBiZQo+dXNlZCBhcyB0aGUgZ3Vlc3RfY2lkIHdoaWxlIHRoZSBWTUFERFJfSE9T
VF9DSUQgd2lsbCBiZSB1c2VkIGZvciBob3N0IGNpZC4KCldlIGFscmVhZHkgaGF2ZSBWTUFERFJf
RkxBR19UT19IT1NUIHRvIGZvcndhcmQgYWxsIHBhY2tldHMgdG8gdGhlIGhvc3QsIAp3ZSBvbmx5
IG5lZWQgdG8gc3VwcG9ydCBpbiBzb21lIHdheSBpbiB2aG9zdC12c29jay4KClRoYW5rcywKU3Rl
ZmFubwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
