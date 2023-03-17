Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDFBDC74A5B
	for <virtualization@archiver.kernel.org>; Fri, 17 Mar 2023 03:32:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 504D241777;
	Fri, 17 Mar 2023 03:32:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 504D241777
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=TxDTujLf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O6yw2KS4QxIZ; Fri, 17 Mar 2023 03:32:58 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 5569341774;
	Fri, 17 Mar 2023 03:32:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 5569341774
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 31AE1C0035;
	Fri, 17 Mar 2023 03:32:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 01A23C0032
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 03:32:55 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id BC8C94046A
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 03:32:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BC8C94046A
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=TxDTujLf
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id q4SsL8XY0qZv
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 03:32:55 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1826A40129
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 1826A40129
 for <virtualization@lists.linux-foundation.org>;
 Fri, 17 Mar 2023 03:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679023973;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3WJ2om5W1PNT67onAVBDUdkR5iPIMefrKXx/BJfhkpI=;
 b=TxDTujLfHmqYRNZXGQiZbROy7PWpPT0YjJAc+yXg7I6agIllD12h0NTwzR+DF5+h7/+pl8
 9CpmLGo6pZWbN1ZYFL/jFbos+6JJGYYzZrHhzsDxx7AsC/7rVmKGx5kucUfD6c3zyrY+Oy
 s9LFw15EQPNg1zFhTqd58I7iphZlFXU=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-462-YoU3E45ANbqI0paliJq36g-1; Thu, 16 Mar 2023 23:32:52 -0400
X-MC-Unique: YoU3E45ANbqI0paliJq36g-1
Received: by mail-oo1-f70.google.com with SMTP id
 s62-20020a4a5141000000b00537d702c199so899563ooa.15
 for <virtualization@lists.linux-foundation.org>;
 Thu, 16 Mar 2023 20:32:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679023972;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=3WJ2om5W1PNT67onAVBDUdkR5iPIMefrKXx/BJfhkpI=;
 b=4ogYX50rxnjQCJJhHqkJKLtGljZu7+tQetFXoKGyLuhLnjhHQPgY1pW9fzJG8SvqfM
 +Lm288tYS5LBrt5RgTuoyKUw9ofV/wdf7s4ClIW115G/ioFaqs/aCmri42c6gX6ckVM2
 9vl537Z9Yfvk/D0UcHVcT3AmtmGiPvphvcaL03O8LqcnlA0j0UgaNjEyTvzSb8cLlwOt
 26p7RCSWX85xJTPu9CjpgWtowFOszdSvA250/KaxQsrs7umH3jE/Bs/AqyQIrBTLiT1p
 xfpBOxomnKhPnM8W76o7cKWwVYFKm/Emp/EFPcwdSlsJL5P51JLsNbUl+UKJOjbj4/FM
 Xnxg==
X-Gm-Message-State: AO0yUKUc+FJoJgfoo3TdgzuI9gG1W1z9Iq/b19wFiQmXJpx6Wq99UGIa
 boEPGzfJI3VSp3P3vXCyeQO0hiN/+y3eksrwzqxpntH97eu7/pS2tgNJ2LlxKJ4XhaWfiEVRGST
 Bu83lm+CpEQ666uhIm6l5hA0tKDFp0NjpX0fRW3eGuzeU+9C/KsYtP/963g==
X-Received: by 2002:a05:6808:1899:b0:37f:a2ad:6718 with SMTP id
 bi25-20020a056808189900b0037fa2ad6718mr771538oib.3.1679023971942; 
 Thu, 16 Mar 2023 20:32:51 -0700 (PDT)
X-Google-Smtp-Source: AK7set9aq2pNFjJxodpWEaGuKSUpyf+4PDdaj3hI+lPVAMgpOWU/op22REzseaHuu7VkpBxEx2cVVIgSNJfdSfaqIqA=
X-Received: by 2002:a05:6808:1899:b0:37f:a2ad:6718 with SMTP id
 bi25-20020a056808189900b0037fa2ad6718mr771528oib.3.1679023971660; Thu, 16 Mar
 2023 20:32:51 -0700 (PDT)
MIME-Version: 1.0
References: <20230312084137.2300100-1-elic@nvidia.com>
In-Reply-To: <20230312084137.2300100-1-elic@nvidia.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 17 Mar 2023 11:32:40 +0800
Message-ID: <CACGkMEsgyOMmVcj-5eEBtHMKqR5Z03tiuHbUK3opZQ_93tSbBw@mail.gmail.com>
Subject: Re: [PATCH] vdpa/mlx5: Remove debugfs file after device unregister
To: Eli Cohen <elic@nvidia.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: eperezma@redhat.com, virtualization@lists.linux-foundation.org,
 parav@mellanox.com, mst@redhat.com
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

T24gU3VuLCBNYXIgMTIsIDIwMjMgYXQgNDo0MeKAr1BNIEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEu
Y29tPiB3cm90ZToKPgo+IFdoZW4gZGVsZXRpbmcgdGhlIHZkcGEgZGV2aWNlLCB0aGUgZGVidWdm
cyBmaWxlcyBuZWVkIHRvIGJlIHJlbW92ZWQgc28KPiBuZWVkIHRvIHJlbW92ZSBkZWJ1Z2ZzIGFm
dGVyIHRoZSBkZXZpY2UgaGFzIGJlZW4gdW5yZWdpc3RlcmVkLgo+Cj4gVGhpcyBmaXhlcyBudWxs
IHBvaW50ZXIgZGVyZWZlcmVuY2Ugd2hlbiBzb21lb25lIGRlbGV0ZXMgdGhlIGRldmljZQo+IGFm
dGVyIGRlYnVnZnMgaGFzIGJlZW4gcG9wdWxhdGVkLgo+Cj4gRml4ZXM6IDI5NDIyMTAwNDMyMiAo
InZkcGEvbWx4NTogQWRkIGRlYnVnZnMgc3VidHJlZSIpCj4gU2lnbmVkLW9mZi1ieTogRWxpIENv
aGVuIDxlbGljQG52aWRpYS5jb20+Cj4gLS0tCj4gIGRyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1
X3ZuZXQuYyB8IDQgKystLQo+ICAxIGZpbGUgY2hhbmdlZCwgMiBpbnNlcnRpb25zKCspLCAyIGRl
bGV0aW9ucygtKQo+Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3Zu
ZXQuYyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+IGluZGV4IDM4NThiYTFl
ODk3NS4uM2Y2MTQ5ZjJmZmQ0IDEwMDY0NAo+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9t
bHg1X3ZuZXQuYwo+ICsrKyBiL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYwo+IEBA
IC0zMzIyLDggKzMzMjIsNiBAQCBzdGF0aWMgdm9pZCBtbHg1X3ZkcGFfZGV2X2RlbChzdHJ1Y3Qg
dmRwYV9tZ210X2RldiAqdl9tZGV2LCBzdHJ1Y3QgdmRwYV9kZXZpY2UgKgo+ICAgICAgICAgc3Ry
dWN0IG1seDVfdmRwYV9uZXQgKm5kZXYgPSB0b19tbHg1X3ZkcGFfbmRldihtdmRldik7Cj4gICAg
ICAgICBzdHJ1Y3Qgd29ya3F1ZXVlX3N0cnVjdCAqd3E7Cj4KPiAtICAgICAgIG1seDVfdmRwYV9y
ZW1vdmVfZGVidWdmcyhuZGV2LT5kZWJ1Z2ZzKTsKPiAtICAgICAgIG5kZXYtPmRlYnVnZnMgPSBO
VUxMOwo+ICAgICAgICAgaWYgKG5kZXYtPm5iX3JlZ2lzdGVyZWQpIHsKPiAgICAgICAgICAgICAg
ICAgbmRldi0+bmJfcmVnaXN0ZXJlZCA9IGZhbHNlOwo+ICAgICAgICAgICAgICAgICBtbHg1X25v
dGlmaWVyX3VucmVnaXN0ZXIobXZkZXYtPm1kZXYsICZuZGV2LT5uYik7Cj4gQEAgLTMzMzIsNiAr
MzMzMCw4IEBAIHN0YXRpYyB2b2lkIG1seDVfdmRwYV9kZXZfZGVsKHN0cnVjdCB2ZHBhX21nbXRf
ZGV2ICp2X21kZXYsIHN0cnVjdCB2ZHBhX2RldmljZSAqCj4gICAgICAgICBtdmRldi0+d3EgPSBO
VUxMOwo+ICAgICAgICAgZGVzdHJveV93b3JrcXVldWUod3EpOwo+ICAgICAgICAgX3ZkcGFfdW5y
ZWdpc3Rlcl9kZXZpY2UoZGV2KTsKCldoYXQgaWYgdGhlIHVzZXIgdHJpZXMgdG8gYWNjZXNzIGRl
YnVnZnMgYWZ0ZXIgX3ZkcGFfdW5yZWdpc3Rlcl9kZXZpY2UoKT8KClRoYW5rcwoKPiArICAgICAg
IG1seDVfdmRwYV9yZW1vdmVfZGVidWdmcyhuZGV2LT5kZWJ1Z2ZzKTsKPiArICAgICAgIG5kZXYt
PmRlYnVnZnMgPSBOVUxMOwo+ICAgICAgICAgbWd0ZGV2LT5uZGV2ID0gTlVMTDsKPiAgfQo+Cj4g
LS0KPiAyLjM4LjEKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxp
bnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWls
bWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
