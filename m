Return-Path: <SRS0=cU2J=K5=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A2304C47082
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 07:06:47 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 544A960FE9
	for <virtualization@archiver.kernel.org>; Thu,  3 Jun 2021 07:06:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 544A960FE9
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id ECB0A405B9;
	Thu,  3 Jun 2021 07:06:46 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id imShJIquEfJl; Thu,  3 Jun 2021 07:06:46 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTP id 60B25405B6;
	Thu,  3 Jun 2021 07:06:45 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 36ABBC000D;
	Thu,  3 Jun 2021 07:06:45 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0EAA8C0001
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 07:06:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 0220960627
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 07:06:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id rR610ogyApZM
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 07:06:43 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 306AE605CF
 for <virtualization@lists.linux-foundation.org>;
 Thu,  3 Jun 2021 07:06:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1622704001;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=SF0GJBKw3q/Jw1E8kxVF3Zvky/XXDj5sAnakkxfvBnI=;
 b=OQ96uDnuDOZJWJ4jaD5WvBL7WVQNMQpC/CgPmf8QIDPaLQiFFNYOzdODh4BxpsePRAkl5m
 CFTQBZmzykjOHvZ9i+dAO4P1ugszYBLgYfma0mOohrQe+jgKzw776Bb5UrB+P2PjkF9Kk6
 rLuthil9x0V112BQkrDIkYTOm77aE1s=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-315-jmwyq6B7M4mg-B1932PTFw-1; Thu, 03 Jun 2021 03:06:40 -0400
X-MC-Unique: jmwyq6B7M4mg-B1932PTFw-1
Received: by mail-pj1-f69.google.com with SMTP id
 b23-20020a17090ae397b0290163949acb4dso4869876pjz.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 03 Jun 2021 00:06:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:from:to:references:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=SF0GJBKw3q/Jw1E8kxVF3Zvky/XXDj5sAnakkxfvBnI=;
 b=eZkDwB3zDHTAs7DTs9vh9pvWYv3MznIsyC2hyh7JVdYtRSGjiBobCJPtYn7W6vLF4/
 XbWBpb0HbHDWb6dqBKj9u93rYfR0RO1kEgdBGukhuDwDZIE8M4ZmTkrBWGdZJnhYWbKE
 +T7Y5i1JUHrgyTYdUoWr27oIcIVIP6MZcdAmubOhtEyJthAUhDnBkD+Tm2Hym049WDWK
 Ren71DNTw7P/d9CbtQga6ERLGuZni8GRYbFeRFODsfo51AQO/y7XMT8nw7leZiRKQt0p
 WVVpLMzMyRw0J2qIt3nfsRuYavF31EnIKiORs/1vL/GIAWAItjw2X/u1qr1m/1HGxw8v
 L6kA==
X-Gm-Message-State: AOAM533N26AQ04eb8qf1aPVlMqMbiX/N4hT2QEkuWip4toVziQZsk7LU
 rRohdaAtSnXRvNUwBPUkrtllrLdOjSO9X6k57UKbFvE2t1HlqpjzgJTkM7auw2LnWsez7FrG3SP
 PdetaEeveaokqk+8wOkD9NW99YneWPx2M+dUntU3p5g==
X-Received: by 2002:a65:42ca:: with SMTP id l10mr19171752pgp.292.1622703999180; 
 Thu, 03 Jun 2021 00:06:39 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyZiFb1hA1pmoeWkKaUGcYoPZ+R5gUyE5hjaV9RB2NucArkemqf0Uhd+HyX3eLWIlcSICxZRQ==
X-Received: by 2002:a65:42ca:: with SMTP id l10mr19171717pgp.292.1622703998703; 
 Thu, 03 Jun 2021 00:06:38 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id h8sm1448553pfn.0.2021.06.03.00.06.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 03 Jun 2021 00:06:38 -0700 (PDT)
Subject: Re: [PATCH] vdpa/mlx5: Clear vq ready indication upon device reset
From: Jason Wang <jasowang@redhat.com>
To: Eli Cohen <elic@nvidia.com>, mst@redhat.com,
 virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org
References: <20210602085924.62777-1-elic@nvidia.com>
 <6e4f9e1b-2c67-fae6-6edd-1982d0f48e22@redhat.com>
Message-ID: <782562f2-6903-68cb-d753-ac90aea854e4@redhat.com>
Date: Thu, 3 Jun 2021 15:06:31 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.2
MIME-Version: 1.0
In-Reply-To: <6e4f9e1b-2c67-fae6-6edd-1982d0f48e22@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
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

CuWcqCAyMDIxLzYvMyDkuIvljYgzOjAwLCBKYXNvbiBXYW5nIOWGmemBkzoKPgo+IOWcqCAyMDIx
LzYvMiDkuIvljYg0OjU5LCBFbGkgQ29oZW4g5YaZ6YGTOgo+PiBBZnRlciBkZXZpY2UgcmVzZXQs
IHRoZSB2aXJ0cXVldWVzIGFyZSBub3QgcmVhZHkgc28gY2xlYXIgdGhlIHJlYWR5Cj4+IGZpZWxk
Lgo+Pgo+PiBGYWlsaW5nIHRvIGRvIHNvIGNhbiByZXN1bHQgaW4gdmlydGlvX3ZkcGEgZmFpbGlu
ZyB0byBsb2FkIGlmIHRoZSBkZXZpY2UKPj4gd2FzIHByZXZpb3VzbHkgdXNlZCBieSB2aG9zdF92
ZHBhIGFuZCB0aGUgb2xkIHZhbHVlcyBhcmUgcmVhZHkuCj4+IHZpcnRpb192ZHBhIGV4cGVjdHMg
dG8gZmluZCBWUXMgaW4gIm5vdCByZWFkeSIgc3RhdGUuCj4+Cj4+IEZpeGVzOiAxYTg2YjM3N2Fh
MjEgKCJ2ZHBhL21seDU6IEFkZCBWRFBBIGRyaXZlciBmb3Igc3VwcG9ydGVkIG1seDUgCj4+IGRl
dmljZXMiKQo+PiBTaWduZWQtb2ZmLWJ5OiBFbGkgQ29oZW4gPGVsaWNAbnZpZGlhLmNvbT4KPgo+
Cj4gQWNrZWQtYnk6IEphc29uIFdhbmcgPGphc293YW5nQHJlZGhhdC5jb20+CgoKQSBzZWNvbmQg
dGhvdWdodC4KCmRlc3Ryb3lfdmlydHF1ZXVlKCkgY291bGQgYmUgY2FsbGVkIG1hbnkgcGxhY2Vz
LgoKT25lIG9mIHRoZW0gaXMgdGhlIG1seDVfdmRwYV9jaGFuZ2VfbWFwKCksIGlmIHRoaXMgaXMg
Y2FzZSwgdGhpcyBsb29rcyAKd3JvbmcuCgpJdCBsb29rcyB0byBtZSBpdCdzIHNpbXBsZXIgdG8g
ZG8gdGhpcyBpbiBjbGVhcl92aXJ0cXVldWVzKCkgd2hpY2ggY2FuIApvbmx5IGJlIGNhbGxlZCBk
dXJpbmcgcmVzZXQuCgpUaGFua3MKCgo+Cj4KPj4gLS0tCj4+IMKgIGRyaXZlcnMvdmRwYS9tbHg1
L25ldC9tbHg1X3ZuZXQuYyB8IDEgKwo+PiDCoCAxIGZpbGUgY2hhbmdlZCwgMSBpbnNlcnRpb24o
KykKPj4KPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9tbHg1X3ZuZXQuYyAK
Pj4gYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4gaW5kZXggMDJhMDU0OTIy
MDRjLi5lOGJjMDg0MmI0NGMgMTAwNjQ0Cj4+IC0tLSBhL2RyaXZlcnMvdmRwYS9tbHg1L25ldC9t
bHg1X3ZuZXQuYwo+PiArKysgYi9kcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPj4g
QEAgLTg2Miw2ICs4NjIsNyBAQCBzdGF0aWMgdm9pZCBkZXN0cm95X3ZpcnRxdWV1ZShzdHJ1Y3Qg
Cj4+IG1seDVfdmRwYV9uZXQgKm5kZXYsIHN0cnVjdCBtbHg1X3ZkcGFfdmlydHEKPj4gwqDCoMKg
wqDCoMKgwqDCoMKgIHJldHVybjsKPj4gwqDCoMKgwqDCoCB9Cj4+IMKgwqDCoMKgwqAgdW1lbXNf
ZGVzdHJveShuZGV2LCBtdnEpOwo+PiArwqDCoMKgIG12cS0+cmVhZHkgPSBmYWxzZTsKPj4gwqAg
fQo+PiDCoCDCoCBzdGF0aWMgdTMyIGdldF9ycXBuKHN0cnVjdCBtbHg1X3ZkcGFfdmlydHF1ZXVl
ICptdnEsIGJvb2wgZncpCgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
