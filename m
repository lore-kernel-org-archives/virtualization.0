Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37E5DC433EF
	for <virtualization@archiver.kernel.org>; Wed, 12 Jan 2022 02:23:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BB36A4093A;
	Wed, 12 Jan 2022 02:23:25 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 7QOmPPSt6VAa; Wed, 12 Jan 2022 02:23:24 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1FB2A40924;
	Wed, 12 Jan 2022 02:23:24 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E732FC002F;
	Wed, 12 Jan 2022 02:23:23 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0E325C001E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 02:23:23 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id F0F524286E
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 02:23:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 60hcesJau-ww
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 02:23:22 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 272AB4286A
 for <virtualization@lists.linux-foundation.org>;
 Wed, 12 Jan 2022 02:23:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1641954200;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=GmRB+aJwaYRiZq2kIb6YVd1ffIqdhpFrgpSgRgcEfjw=;
 b=gprA5jIos8ByN5/hzluAr9xjKKxUo5vPodbuVHcrLLs4SfQstNzu2Mo2/VFAqiQSkVljaX
 Ji9SJ8ji7XLoOtoTOsrxL6PnG5zoPF1aWRjWQFQALw8sZ1iDd7ieVrEO0HEBQq2Q0Kz7eZ
 wdtBsC40toAJOWbxHIx/1awPrFbxWII=
Received: from mail-lf1-f71.google.com (mail-lf1-f71.google.com
 [209.85.167.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-202-hwJeNueNMe-RQg_yMMJoUA-1; Tue, 11 Jan 2022 21:23:19 -0500
X-MC-Unique: hwJeNueNMe-RQg_yMMJoUA-1
Received: by mail-lf1-f71.google.com with SMTP id
 c28-20020a056512239c00b0042da04abc37so641056lfv.7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jan 2022 18:23:19 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=GmRB+aJwaYRiZq2kIb6YVd1ffIqdhpFrgpSgRgcEfjw=;
 b=KRURZLwKcKO5iVIiBpEDWx3Gi4clAocdETPfXFmmUN2tQqciTYo7PoPC9U4NSzP6L+
 4zTVekg6AF5Ss3vJ2Ys5Of8RC04IWT6IWW6t2VAWm925p9U4/UqnuMf761aILE59b/bX
 v0vu9j8EyOtTiY8QpqDIFReEWBdxGdjzig9RmcLhh5uRFbf7hMpE6zvPI9FN3+W1C9Gz
 wa7Focd55J+G2WhlIRfxhqm5580XAcYq7P7q0TOc6FzSuBCz3SZRT3bUwAB9GZp0Y5TL
 urlZd7pwBWemXLDc12BPa8ZxrZDlXe1A64KGEQHOr1Xqt5ngiHOB+3lIus0cYmNLRkNu
 +Ljw==
X-Gm-Message-State: AOAM532YqE+QTWknRUvo23xk0SeB3Ti0L+Egk+iBzmp3Wx4jDxe1W6Fw
 Zzt0z3Qqy+CpYShjugKGZvJ2vd9LvPT9kXSCJh/tkZQjyAt1rqBhaTENK7KHdJwa6IuzJG+Dtj/
 6WyjAO6hP3RXlMflFRVmK+LQnUTo54WK+TSG8txgT0k/ptVbDeiwtsRNjUw==
X-Received: by 2002:a05:6512:68a:: with SMTP id
 t10mr5747185lfe.84.1641954198348; 
 Tue, 11 Jan 2022 18:23:18 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5nx3vv9bUmaKDidSiIX9lkAtla7sB5vyGJsdGfLtYggTML9YCj2yt8pOrRvfdAyvYWnfNOjax5icaWEksrwk=
X-Received: by 2002:a05:6512:68a:: with SMTP id
 t10mr5747178lfe.84.1641954198178; 
 Tue, 11 Jan 2022 18:23:18 -0800 (PST)
MIME-Version: 1.0
References: <tencent_7A45E1E967F13AE14B061269@qq.com>
 <20220111065033-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220111065033-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 12 Jan 2022 10:23:07 +0800
Message-ID: <CACGkMEuAoSwore14qnuMDgdEtWh-UOJf1=oR9vhPMff8hoEZEQ@mail.gmail.com>
Subject: Re: [PATCH] virtio_vdpa: Support surprise removal of virtio vdpa
 device
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: =?UTF-8?B?5p2O5Lic5Y2H?= <lidongsheng@dayudpu.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization <virtualization@lists.linux-foundation.org>
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

T24gVHVlLCBKYW4gMTEsIDIwMjIgYXQgNzo1MiBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIFR1ZSwgSmFuIDExLCAyMDIyIGF0IDExOjM2OjQyQU0g
KzA4MDAsIOadjuS4nOWNhyB3cm90ZToKPiA+IFdoZW4gdmlydGlvIHZkcGEgZGV2aWNlIHJlbW92
ZWQsIHRoZSBhYm5vcm1hbCBkYW1hZ2Ugb2YgdGhlIGRldmljZSBjYW5ub3QgYmUKPiA+IHBlcmNl
aXZlZCBub3JtYWxseSwgd2hpY2ggd2lsbCBjYXVzZSBwcm9ibGVtcyBzaW1pbGFyIHRvOgo+ID4K
PiA+IDQzYmI0MGM1YjkyNgo+Cj4KPiBTaG91bGQgaW5jbHVkZSB0aGUgc3ViamVjdCBvZiB0aGUg
cGF0Y2ggdG9vLgo+Cj4gPiBIZW5jZSwgYWRkIHRoZSBhYmlsaXR5IHRvIGFib3J0IHRoZSBjb21t
YW5kIG9uIHN1cnByaXNlIHJlbW92YWwKPiA+Cj4gPiBTaWduZWQtb2ZmLWJ5OiBkb25nc2hlbmcg
bGkgPGxpZG9uZ3NoZW5nQGRheXVkcHUuY29tPgo+Cj4gV2hlbiByZW1vdmluZyBncmFjZWZ1bGx5
LAo+IEkgYW0gbm90IHN1cmUgd2Ugc2hvdWxkIGJyZWFrIGRldmljZSB1bmNvbmRpdGlvbmFsbHkg
bGlrZSB0aGlzCj4gYmVmb3JlIGdpdmluZyBkcml2ZXJzIGEgY2hhbmNlIHRvIGNsZWFuIHVwLgo+
IFNob3VsZCB3ZSBqdXN0IGRvIGl0IGZvciBzdXJwcmlzZSByZW1vdmFsPwoKVGhhdCByZXF1aXJl
cyBhIG5ldyBtZXRob2QgdG8gcXVlcnkgd2hldGhlciBpdCdzIGEgc3VycHJpc2UgcmVtb3ZhbC4K
ClRoYW5rcwoKPgo+ID4gLS0tCj4gPiAgZHJpdmVycy92aXJ0aW8vdmlydGlvX3ZkcGEuYyB8IDEg
Kwo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2VydGlvbigrKQo+ID4KPiA+IGRpZmYgLS1naXQg
YS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jIGIvZHJpdmVycy92aXJ0aW8vdmlydGlvX3Zk
cGEuYwo+ID4gaW5kZXggNGE5ZGRiNDRiMmE3Li5mZDkzMDQwOWQxOTAgMTAwNjQ0Cj4gPiAtLS0g
YS9kcml2ZXJzL3ZpcnRpby92aXJ0aW9fdmRwYS5jCj4gPiArKysgYi9kcml2ZXJzL3ZpcnRpby92
aXJ0aW9fdmRwYS5jCj4gPiBAQCAtMzc0LDYgKzM3NCw3IEBAIHN0YXRpYyB2b2lkIHZpcnRpb192
ZHBhX3JlbW92ZShzdHJ1Y3QgdmRwYV9kZXZpY2UgKnZkcGEpCj4gPiAgewo+ID4gICBzdHJ1Y3Qg
dmlydGlvX3ZkcGFfZGV2aWNlICp2ZF9kZXYgPSB2ZHBhX2dldF9kcnZkYXRhKHZkcGEpOwo+ID4K
PiA+ICsgdmlydGlvX2JyZWFrX2RldmljZSh2ZF9kZXYtPnZkZXYpOwo+ID4gICB1bnJlZ2lzdGVy
X3ZpcnRpb19kZXZpY2UoJnZkX2Rldi0+dmRldik7Cj4gPiAgfQo+ID4KPiA+IC0tCj4gPiAyLjE3
LjEKPgoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmly
dHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5k
YXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3Rp
bmZvL3ZpcnR1YWxpemF0aW9u
