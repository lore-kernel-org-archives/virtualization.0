Return-Path: <SRS0=Nqfw=EW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15CE0C5519F
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 10:42:16 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 509F920789
	for <virtualization@archiver.kernel.org>; Mon, 16 Nov 2020 10:42:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TBYfDeiW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 509F920789
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 663EB20457;
	Mon, 16 Nov 2020 10:42:14 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XuevG3lzgtgP; Mon, 16 Nov 2020 10:42:12 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 0ECFD2041E;
	Mon, 16 Nov 2020 10:42:12 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id F0412C0800;
	Mon, 16 Nov 2020 10:42:11 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3FF13C07FF
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 10:42:10 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id EF3AB20457
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 10:42:09 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4exnMhG5oEGD
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 10:42:09 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by silver.osuosl.org (Postfix) with ESMTPS id C8C782041E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 10:42:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1605523327;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=AbJT48MzAcRyOQMKLElNni6bzOKtWGki16HjKF748o0=;
 b=TBYfDeiWEJNxLjoYk+cTwE5RXYtOpaqDacf/T0txz+9X+QqGpzybIq6po9uJW4p9rcwH3w
 NWmxG+WTs6SuUT4lPg8WuP7NYkpAty1uqUdvlXHxAQ73sWb1ppfqLqUJz0bTcy6TqmjhS+
 C65EjZA+RY3vavzBFwJnU/I2dAgxa6c=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-454-mOq6KI6XMkeSV57mvblfPA-1; Mon, 16 Nov 2020 05:42:06 -0500
X-MC-Unique: mOq6KI6XMkeSV57mvblfPA-1
Received: by mail-wm1-f70.google.com with SMTP id h9so8809772wmf.8
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Nov 2020 02:42:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=AbJT48MzAcRyOQMKLElNni6bzOKtWGki16HjKF748o0=;
 b=K7LniGyt3Vc3uBtIUEjghsmXi/W6rxK4M+VeJaCCgC7RNoHYbe7slrfC8BSH2rlhzQ
 JeyhGFL5bP1iiYl/AypdwaI39Ba/RTFKnls88FMwJgbfiPeD77bD1yUYpM5Fn9/qsbBJ
 uCUf6GW5ERb7bTTMYVEah2d7ldeGW5YMOoSnR/34hqcw9OzFAITxTpuh+PhIBmx8Twic
 HpbBNACDXEetlNg+eH0N2qCtTIAWeK53X241j9L++p5PDdI/sUANLZ2+U5ilOrpxJFDP
 aRhJpXQjperQnyW5GrZNdDdfz4Ry9OaXjyWrsOfy/8rBMiA0J92GOKt8ewAZwlSE4Yua
 w2RQ==
X-Gm-Message-State: AOAM531NyrQ3gKAHn1cSt48JkyqhWRqAGqeEnRv2Tir2xcq2MiU0WOs7
 KEIUNhfVbP5CM81NhpxeHuRA3kkDdPmfUhcbHj5/LuqHCeMr/Px0rBQz0u8Q3ZXNK8r9/twFgbc
 js2Q1XCbglUUNtrpSXs8Q8mTeZ7V8te0FaPgGZClSVg==
X-Received: by 2002:a1c:2c2:: with SMTP id 185mr14994219wmc.103.1605523324618; 
 Mon, 16 Nov 2020 02:42:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJyZ+tAGKjI2Y8SDbunQ0GnxRaaDm6BtohQWSlWu94euTDYVt5oYegQKt0OOTTBieWNDm6idXg==
X-Received: by 2002:a1c:2c2:: with SMTP id 185mr14994197wmc.103.1605523324385; 
 Mon, 16 Nov 2020 02:42:04 -0800 (PST)
Received: from steredhat (host-79-17-248-175.retail.telecomitalia.it.
 [79.17.248.175])
 by smtp.gmail.com with ESMTPSA id o184sm19037484wmo.37.2020.11.16.02.42.03
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 Nov 2020 02:42:03 -0800 (PST)
Date: Mon, 16 Nov 2020 11:42:01 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH RFC 07/12] vdpa_sim: move config management outside of
 the core
Message-ID: <20201116104201.futmxydbpq542luk@steredhat>
References: <20201113134712.69744-1-sgarzare@redhat.com>
 <20201113134712.69744-8-sgarzare@redhat.com>
 <6ee3e73b-257a-3c02-db32-e890cfacae64@redhat.com>
MIME-Version: 1.0
In-Reply-To: <6ee3e73b-257a-3c02-db32-e890cfacae64@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Laurent Vivier <lvivier@redhat.com>, Max Gurtovoy <mgurtovoy@nvidia.com>,
 "Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org,
 Stefan Hajnoczi <stefanha@redhat.com>, Eli Cohen <elic@nvidia.com>
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

T24gTW9uLCBOb3YgMTYsIDIwMjAgYXQgMTI6MTg6MTlQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPgo+T24gMjAyMC8xMS8xMyDkuIvljYg5OjQ3LCBTdGVmYW5vIEdhcnphcmVsbGEgd3JvdGU6
Cj4+SW4gb3JkZXIgdG8gc2ltcGxpZnkgdGhlIGNvZGUgb2YgdGhlIHZkcGFfc2ltIGNvcmUsIHdl
IG1vdmUgdGhlCj4+Y29uZmlnIG1hbmFnZW1lbnQgaW4gZWFjaCBkZXZpY2Ugc2ltdWxhdG9yLgo+
Pgo+PlRoZSBkZXZpY2UgbXVzdCBwcm92aWRlIHRoZSBzaXplIG9mIGNvbmZpZyBzdHJ1Y3R1cmUg
YW5kIGEgY2FsbGJhY2sKPj50byB1cGRhdGUgdGhpcyBzdHJ1Y3R1cmUgY2FsbGVkIGR1cmluZyB0
aGUgdmRwYXNpbV9zZXRfZmVhdHVyZXMoKS4KPgo+Cj5TaW1pbGFybHksIEkgc3VnZ2VzdCB0byBk
byB0aGlzIGJlZm9yZSBwYXRjaCAyLCB0aGVuIHRoZXJlJ3Mgbm8gbmVlZCAKPmZvciB0aGUgY29u
dmVyc2lvbiBvZiBibGsgZGV2aWNlLgo+CgpJJ2xsIGRvLgoKPgo+Pgo+PlNpZ25lZC1vZmYtYnk6
IFN0ZWZhbm8gR2FyemFyZWxsYSA8c2dhcnphcmVAcmVkaGF0LmNvbT4KPj4tLS0KPj4gIGRyaXZl
cnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5oICAgICB8ICA1ICsrKy0tCj4+ICBkcml2ZXJzL3Zk
cGEvdmRwYV9zaW0vdmRwYV9zaW0uYyAgICAgfCAyOSArKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tCj4+ICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fYmxrLmMgfCAyNyArKysrKysr
KysrKysrKysrLS0tLS0tLS0tLQo+PiAgZHJpdmVycy92ZHBhL3ZkcGFfc2ltL3ZkcGFfc2ltX25l
dC5jIHwgMTIgKysrKysrKysrKysrCj4+ICA0IGZpbGVzIGNoYW5nZWQsIDM3IGluc2VydGlvbnMo
KyksIDM2IGRlbGV0aW9ucygtKQo+Pgo+PmRpZmYgLS1naXQgYS9kcml2ZXJzL3ZkcGEvdmRwYV9z
aW0vdmRwYV9zaW0uaCBiL2RyaXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbS5oCj4+aW5kZXgg
NzZlNjQyMDQyZWIwLi5mN2UxZmUwYTg4ZDMgMTAwNjQ0Cj4+LS0tIGEvZHJpdmVycy92ZHBhL3Zk
cGFfc2ltL3ZkcGFfc2ltLmgKPj4rKysgYi9kcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW0u
aAo+PkBAIC0xMCw4ICsxMCw2IEBACj4+ICAjaW5jbHVkZSA8bGludXgvdmRwYS5oPgo+PiAgI2lu
Y2x1ZGUgPGxpbnV4L3Zob3N0X2lvdGxiLmg+Cj4+ICAjaW5jbHVkZSA8dWFwaS9saW51eC92aXJ0
aW9fY29uZmlnLmg+Cj4+LSNpbmNsdWRlIDx1YXBpL2xpbnV4L3ZpcnRpb19uZXQuaD4KPj4tI2lu
Y2x1ZGUgPHVhcGkvbGludXgvdmlydGlvX2Jsay5oPgo+PiAgI2RlZmluZSBEUlZfVkVSU0lPTiAg
IjAuMSIKPj4gICNkZWZpbmUgRFJWX0FVVEhPUiAgICJKYXNvbiBXYW5nIDxqYXNvd2FuZ0ByZWRo
YXQuY29tPiIKPj5AQCAtNDIsOCArNDAsMTEgQEAgc3RydWN0IHZkcGFzaW1fdmlydHF1ZXVlIHsK
Pj4gIHN0cnVjdCB2ZHBhc2ltX2RldmljZSB7Cj4+ICAJdTY0IHN1cHBvcnRlZF9mZWF0dXJlczsK
Pj4rCXNpemVfdCBjb25maWdfc2l6ZTsKPj4gIAl1MzIgaWQ7Cj4+ICAJaW50IG52cXM7Cj4+Kwo+
PisJdm9pZCAoKnVwZGF0ZV9jb25maWcpKHN0cnVjdCB2ZHBhc2ltICp2ZHBhc2ltKTsKPgo+Cj5M
ZXQncyB1c2Ugc2V0X2NvbmZpZy9nZXRfY29uZmlnIHRvIGFsaWduIHdpdGggdmlydGlvL3Zob3N0
LgoKWWVzLCBpdCdzIGJldHRlciwKCj4KPk90aGVyIGxvb2tzIGdvb2QuCgpUaGFua3MsClN0ZWZh
bm8KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1
YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0
aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5m
by92aXJ0dWFsaXphdGlvbg==
