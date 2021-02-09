Return-Path: <SRS0=H/CR=HL=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CAF1C433DB
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 09:31:40 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id D12B964E16
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 09:31:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org D12B964E16
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 8D1696F894
	for <virtualization@archiver.kernel.org>; Tue,  9 Feb 2021 09:31:39 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o1cw6CIP9Tyw for <virtualization@archiver.kernel.org>;
	Tue,  9 Feb 2021 09:31:38 +0000 (UTC)
Received: by smtp3.osuosl.org (Postfix, from userid 1001)
	id 3977B6F6ED; Tue,  9 Feb 2021 09:31:38 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp3.osuosl.org (Postfix) with ESMTP id 51A086F630;
	Tue,  9 Feb 2021 09:31:34 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 2E7D0C0891;
	Tue,  9 Feb 2021 09:31:34 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3DD4BC013A
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 09:31:33 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 25C098628B
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 09:31:33 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id qicJj76+rkTA
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 09:31:32 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 3484785A67
 for <virtualization@lists.linux-foundation.org>;
 Tue,  9 Feb 2021 09:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612863090;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=aTBtQXm9+PZIPejujzW7OPUSsCM+yycqpB+qIdPgqFU=;
 b=IuofEZIVirlueozP8uYQajN9aDq0X4s+LpZ5BtUMoC+1fbXBzkSkX0IhKD568Dd8wJp+2A
 iA2a5/Nq1QqxRoxlOnKJ7/+ValX46CGRraQIEaVjx0TRc2yIX1NqN7yluhezyOZrUye20h
 Qz9WHXxnduIqf87pOd28nI8++QLHRD4=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-501-P9tgLWDjOb-YMaUNBda9wQ-1; Tue, 09 Feb 2021 04:31:28 -0500
X-MC-Unique: P9tgLWDjOb-YMaUNBda9wQ-1
Received: by mail-wm1-f70.google.com with SMTP id n17so2002742wmk.3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 09 Feb 2021 01:31:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=aTBtQXm9+PZIPejujzW7OPUSsCM+yycqpB+qIdPgqFU=;
 b=pG3XujEyqzkYuQM7Zya54VJHY4bsACsR5PO7brO3K1sjHWBbTt2Wlg9MUOvhdtUgyl
 0VcAxd/Il2f+pWDclFb+guMV7O4mFVWz+1TXrNk/2XWhF91s+R/Qjl/EDnG0denMHxYM
 Mm8P14ja1vrn2YEuYsIoZQ8m82nx+aFi1ovXztW6XRCAxe4BbtOEFpMcyY39WPyIg3Y7
 GKpvrcjbBBqlfngWD0puhDeoqrUJhcXlCsKO82YccSekcOaqymB9LUtR90TOGo18NWSD
 TaecRgO3qC94ylo+jFaUBm9awj5z0YBOOpcx/9XvPYDUcw+w/TuO4spjr8DQJ3wmlHIS
 SE/A==
X-Gm-Message-State: AOAM532exATChkIS9ubjUCL2cMqwJWyQ5XMYYn5uHklJo3AF0Zf3VgSd
 SnR2jSd5VcaXcb4g08z3kKTF5dpmdZ6tVx+XG3SnPUdf+DzDzVC3uqElljd2aT8fjVA2oltI6PB
 vsuH7Gr0MND43a3WxHZ8HBnaDWBXzr7ArlNZUIZlxdg==
X-Received: by 2002:adf:a31b:: with SMTP id c27mr411461wrb.188.1612863087245; 
 Tue, 09 Feb 2021 01:31:27 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzvQH6O/1Z4SbjyMQjmV5TIxqaUjNuCuqWmPnqSE9yF9i/anegjLrKjtiIcaYdnbBiGZuGg5g==
X-Received: by 2002:adf:a31b:: with SMTP id c27mr411442wrb.188.1612863087098; 
 Tue, 09 Feb 2021 01:31:27 -0800 (PST)
Received: from redhat.com (bzq-79-180-2-31.red.bezeqint.net. [79.180.2.31])
 by smtp.gmail.com with ESMTPSA id z6sm3318352wmi.39.2021.02.09.01.31.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 09 Feb 2021 01:31:25 -0800 (PST)
Date: Tue, 9 Feb 2021 04:31:23 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH] vdpa/mlx5: fix param validation in mlx5_vdpa_get_config()
Message-ID: <20210209042530-mutt-send-email-mst@kernel.org>
References: <20210208161741.104939-1-sgarzare@redhat.com>
 <20210208133312-mutt-send-email-mst@kernel.org>
 <fc523fbe-b742-0ebe-84d1-2b7e5529f00b@redhat.com>
MIME-Version: 1.0
In-Reply-To: <fc523fbe-b742-0ebe-84d1-2b7e5529f00b@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Eli Cohen <elic@nvidia.com>, virtualization@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org
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

T24gVHVlLCBGZWIgMDksIDIwMjEgYXQgMTE6MjQ6MDNBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIxLzIvOSDkuIrljYgyOjM4LCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6
Cj4gPiBPbiBNb24sIEZlYiAwOCwgMjAyMSBhdCAwNToxNzo0MVBNICswMTAwLCBTdGVmYW5vIEdh
cnphcmVsbGEgd3JvdGU6Cj4gPiA+IEl0J3MgbGVnYWwgdG8gaGF2ZSAnb2Zmc2V0ICsgbGVuJyBl
cXVhbCB0bwo+ID4gPiBzaXplb2Yoc3RydWN0IHZpcnRpb19uZXRfY29uZmlnKSwgc2luY2UgJ25k
ZXYtPmNvbmZpZycgaXMgYQo+ID4gPiAnc3RydWN0IHZpcnRpb19uZXRfY29uZmlnJywgc28gd2Ug
Y2FuIHNhZmVseSBjb3B5IGl0cyBjb250ZW50IHVuZGVyCj4gPiA+IHRoaXMgY29uZGl0aW9uLgo+
ID4gPiAKPiA+ID4gRml4ZXM6IDFhODZiMzc3YWEyMSAoInZkcGEvbWx4NTogQWRkIFZEUEEgZHJp
dmVyIGZvciBzdXBwb3J0ZWQgbWx4NSBkZXZpY2VzIikKPiA+ID4gQ2M6IHN0YWJsZUB2Z2VyLmtl
cm5lbC5vcmcKPiA+ID4gU2lnbmVkLW9mZi1ieTogU3RlZmFubyBHYXJ6YXJlbGxhIDxzZ2FyemFy
ZUByZWRoYXQuY29tPgo+ID4gPiAtLS0KPiA+ID4gICBkcml2ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4
NV92bmV0LmMgfCAyICstCj4gPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pCj4gPiA+IAo+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL21seDUv
bmV0L21seDVfdm5ldC5jIGIvZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5ldC5jCj4gPiA+
IGluZGV4IGRjODg1NTlhOGQ0OS4uMTBlOWIwOTkzMmViIDEwMDY0NAo+ID4gPiAtLS0gYS9kcml2
ZXJzL3ZkcGEvbWx4NS9uZXQvbWx4NV92bmV0LmMKPiA+ID4gKysrIGIvZHJpdmVycy92ZHBhL21s
eDUvbmV0L21seDVfdm5ldC5jCj4gPiA+IEBAIC0xODIwLDcgKzE4MjAsNyBAQCBzdGF0aWMgdm9p
ZCBtbHg1X3ZkcGFfZ2V0X2NvbmZpZyhzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkZXYsIHVuc2lnbmVk
IGludCBvZmZzZXQsCj4gPiA+ICAgCXN0cnVjdCBtbHg1X3ZkcGFfZGV2ICptdmRldiA9IHRvX212
ZGV2KHZkZXYpOwo+ID4gPiAgIAlzdHJ1Y3QgbWx4NV92ZHBhX25ldCAqbmRldiA9IHRvX21seDVf
dmRwYV9uZGV2KG12ZGV2KTsKPiA+ID4gLQlpZiAob2Zmc2V0ICsgbGVuIDwgc2l6ZW9mKHN0cnVj
dCB2aXJ0aW9fbmV0X2NvbmZpZykpCj4gPiA+ICsJaWYgKG9mZnNldCArIGxlbiA8PSBzaXplb2Yo
c3RydWN0IHZpcnRpb19uZXRfY29uZmlnKSkKPiA+ID4gICAJCW1lbWNweShidWYsICh1OCAqKSZu
ZGV2LT5jb25maWcgKyBvZmZzZXQsIGxlbik7Cj4gPiA+ICAgfQo+ID4gQWN0dWFsbHkgZmlyc3Qg
SSBhbSBub3Qgc3VyZSB3ZSBuZWVkIHRoZXNlIGNoZWNrcyBhdCBhbGwuCj4gPiB2aG9zdF92ZHBh
X2NvbmZpZ192YWxpZGF0ZSBhbHJlYWR5IHZhbGlkYXRlcyB0aGUgdmFsdWVzLCByaWdodD8KPiAK
PiAKPiBJIHRoaW5rIHRoZXkncmUgd29ya2luZyBhdCBkaWZmZXJlbnQgbGV2ZWxzLiBUaGVyZSdz
IG5vIGd1YXJhbnRlZSB0aGF0Cj4gdmhvc3QtdmRwYSBpcyB0aGUgZHJpdmVyIGZvciB0aGlzIHZk
cGEgZGV2aWNlLgoKSW4gZmFjdCwgZ2V0X2NvbmZpZyByZXR1cm5zIHZvaWQsIHNvIHVzZXJzcGFj
ZSBjYW4gZWFzaWx5IGdldAp0cmFzaCBpZiBpdCBwYXNzZXMgaW5jb3JyZWN0IHBhcmFtZXRlcnMg
YnkgbWlzdGFrZSwgdGhlcmUgaXMKbm8gd2F5IGZvciB1c2Vyc3BhY2UgdG8gZmluZCBvdXQgd2hl
dGhlciB0aGF0IGlzIHRoZSBjYXNlIDooCgpBbnkgb2JqZWN0aW9ucyB0byByZXR1cm5pbmcgdGhl
ICMgb2YgYnl0ZXMgY29waWVkLCBvciAtMQpvbiBlcnJvcj8KCj4gCj4gPiAKPiA+IFNlY29uZCwg
d2hhdCB3aWxsIGhhcHBlbiB3aGVuIHdlIGV4dGVuZCB0aGUgc3RydWN0IGFuZCB0aGVuCj4gPiBy
dW4gbmV3IHVzZXJzcGFjZSBvbiBhbiBvbGQga2VybmVsPyBMb29rcyBsaWtlIGl0IHdpbGwganVz
dAo+ID4gZmFpbCByaWdodD8gU28gd2hhdCBpcyB0aGUgcGxhbj8KPiAKPiAKPiBJbiB0aGlzIGNh
c2UsIGdldF9jb25maWcoKSBzaG91bGQgbWF0Y2ggdGhlIHNwZWMgYmVoYXZpb3VyLiBUaGF0IGlz
IHRvIHNheQo+IHRoZSBzaXplIG9mIGNvbmZpZyBzcGFjZSBkZXBlbmRzIG9uIHRoZSBmZWF0dXJl
IG5lZ290aWF0ZWQuCj4gCj4gVGhhbmtzCgpZZXMgYnV0IHNwZWMgc2F5cyBjb25maWcgc3BhY2Ug
Y2FuIGJlIGJpZ2dlciB0aGFuIHNwZWNpZmllZCBieSBmZWF0dXJlczoKCglEcml2ZXJzIE1VU1Qg
Tk9UIGxpbWl0IHN0cnVjdHVyZSBzaXplIGFuZCBkZXZpY2UgY29uZmlndXJhdGlvbiBzcGFjZSBz
aXplLiBJbnN0ZWFkLCBkcml2ZXJzIFNIT1VMRCBvbmx5CgljaGVjayB0aGF0IGRldmljZSBjb25m
aWd1cmF0aW9uIHNwYWNlIGlzIGxhcmdlIGVub3VnaCB0byBjb250YWluIHRoZSBmaWVsZHMgbmVj
ZXNzYXJ5IGZvciBkZXZpY2Ugb3BlcmF0aW9uLgoKCgo+IAo+ID4gICBJIHRoaW5rIHdlIHNob3Vs
ZAo+ID4gYWxsb3cgYSBiaWdnZXIgc2l6ZSwgYW5kIHJldHVybiB0aGUgY29waWVkIGNvbmZpZyBz
aXplIHRvIHVzZXJzcGFjZS4KPiA+IAo+ID4gCj4gPiA+IC0tIAo+ID4gPiAyLjI5LjIKCl9fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9u
IG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpo
dHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFs
aXphdGlvbg==
