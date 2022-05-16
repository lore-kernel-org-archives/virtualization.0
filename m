Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65F3EC433EF
	for <virtualization@archiver.kernel.org>; Mon, 16 May 2022 10:34:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id E75E640B2B;
	Mon, 16 May 2022 10:34:55 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tLDtj4SKbY5N; Mon, 16 May 2022 10:34:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 858B640B29;
	Mon, 16 May 2022 10:34:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58DAEC0032;
	Mon, 16 May 2022 10:34:54 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 08FF8C002D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 10:34:53 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id E801140B29
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 10:34:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id fxaW7UFD8rcI
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 10:34:52 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 20A004011F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 10:34:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1652697290;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=tDp5nF+PnB4eHZV0OMzo5Q8xyxBL+9pjCfV/eT17KTI=;
 b=iy9fCferDei8VDZ131ndqou/fPML7c/BVAFfZojikyHC+N7mWg6HSomUrMs/MJEHvUzW76
 m0n/V0Xwa/ugSLSp8uTmPvFlD6ZbS9bwbjsvnCOyh+qXPTANdqqLFsqiS6Xr05HPygRR8H
 tZzJHdYSyWhhHvHY+eFrtEVAQRzEMoE=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-359-gWYpU4VqMsSFRl7mJdVXEw-1; Mon, 16 May 2022 06:34:42 -0400
X-MC-Unique: gWYpU4VqMsSFRl7mJdVXEw-1
Received: by mail-wm1-f69.google.com with SMTP id
 bg7-20020a05600c3c8700b0039468585269so6558880wmb.3
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 May 2022 03:34:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=tDp5nF+PnB4eHZV0OMzo5Q8xyxBL+9pjCfV/eT17KTI=;
 b=qusfSUj1mK/6slTG1pgux1hHx3mWVkZyvO0bOkquIDV6hsXXpc1XlYtwmwdMtmF/Ie
 eblNuV1HM2qO+KY7i7wySyj5DNO8V6l7PQibKtEzdeq6Bw6BYZWTbPSzs1fNXP3BuSUf
 NkMPUdH7gdj4ghyeQ1jwBBubvwyjzRjkC9Q4ptchl54HQrK7dxoAttmJ//cxSQ2+cVYj
 klNugzf17QEMBqLiMIotFuJpVLt97DFifywCalLhuMCEudWIY1GMiKEghHf2hUxz99s2
 UoaevxX+nhQsFD0zOPjdondncQZrlNZqGJnnvAuZ/TRTHOiR4T0FUsIwt19LcKP8WrT0
 6H7w==
X-Gm-Message-State: AOAM531XtJwZEgF/IUsK3iH4ng6Q0m4r/AxFHbR/qB5v2tWPL/9jU2Mu
 NOXbwv/yxQTR+Nfw1c2Lsp3ucwtHleddL0k2RtGw/LRlrVIWALgNR/kgRBnNnrLpIKlAoyb7StY
 1gvys9DhzoOOsL2Wv2loZSK3JbwPpA98qNx6SAooOEw==
X-Received: by 2002:a1c:35c1:0:b0:38e:c4f6:1931 with SMTP id
 c184-20020a1c35c1000000b0038ec4f61931mr15913734wma.161.1652697281033; 
 Mon, 16 May 2022 03:34:41 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwOnBcfvcjfy9d1GxxfQlPxyh0OAPfxbp+Zt6FP+p01dX/YDgHu2j8hod2GB+FEhMhV58W7cQ==
X-Received: by 2002:a1c:35c1:0:b0:38e:c4f6:1931 with SMTP id
 c184-20020a1c35c1000000b0038ec4f61931mr15913712wma.161.1652697280835; 
 Mon, 16 May 2022 03:34:40 -0700 (PDT)
Received: from redhat.com ([2.55.141.66]) by smtp.gmail.com with ESMTPSA id
 v15-20020adf8b4f000000b0020d0c48d135sm1565236wra.15.2022.05.16.03.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 16 May 2022 03:34:40 -0700 (PDT)
Date: Mon, 16 May 2022 06:34:36 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: [PATCH v2 2/3] vdpa: Add a device object for vdpa management
 device
Message-ID: <20220516063357-mutt-send-email-mst@kernel.org>
References: <20220516060342.106-1-xieyongji@bytedance.com>
 <20220516060342.106-2-xieyongji@bytedance.com>
 <51811045-548c-1241-0a25-d23e8f7c9d1d@redhat.com>
 <CACycT3uoWjYjogi0H4yrA7GuKnY=djt6BmafoRB-rbmz+8Y4BA@mail.gmail.com>
 <20220516055356-mutt-send-email-mst@kernel.org>
 <CACycT3sqEJ7JSYV646m6CLVH5tKpfbTUV4Oz+XcfXTe4ApEE1w@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3sqEJ7JSYV646m6CLVH5tKpfbTUV4Oz+XcfXTe4ApEE1w@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Greg KH <gregkh@linuxfoundation.org>,
 virtualization <virtualization@lists.linux-foundation.org>, "Zhu,
 Lingshan" <lingshan.zhu@intel.com>, Eli Cohen <elic@nvidia.com>
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

T24gTW9uLCBNYXkgMTYsIDIwMjIgYXQgMDY6MzE6MThQTSArMDgwMCwgWW9uZ2ppIFhpZSB3cm90
ZToKPiBPbiBNb24sIE1heSAxNiwgMjAyMiBhdCA1OjU0IFBNIE1pY2hhZWwgUy4gVHNpcmtpbiA8
bXN0QHJlZGhhdC5jb20+IHdyb3RlOgo+ID4KPiA+IE9uIE1vbiwgTWF5IDE2LCAyMDIyIGF0IDA1
OjMxOjI3UE0gKzA4MDAsIFlvbmdqaSBYaWUgd3JvdGU6Cj4gPiA+IE9uIE1vbiwgTWF5IDE2LCAy
MDIyIGF0IDU6MTQgUE0gSmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4gd3JvdGU6Cj4g
PiA+ID4KPiA+ID4gPgo+ID4gPiA+IOWcqCAyMDIyLzUvMTYgMTQ6MDMsIFhpZSBZb25namkg5YaZ
6YGTOgo+ID4gPiA+ID4gSW50cm9kdWNlIGEgZGV2aWNlIG9iamVjdCBmb3IgdmRwYSBtYW5hZ2Vt
ZW50IGRldmljZSB0byBjb250cm9sCj4gPiA+ID4gPiBpdHMgbGlmZWN5Y2xlLiBBbmQgdGhlIGRl
dmljZSBuYW1lIHdpbGwgYmUgdXNlZCB0byBtYXRjaAo+ID4gPiA+ID4gVkRQQV9BVFRSX01HTVRE
RVZfREVWX05BTUUgZmllbGQgb2YgbmV0bGluayBtZXNzYWdlIHJhdGhlciB0aGFuCj4gPiA+ID4g
PiB1c2luZyBwYXJlbnQgZGV2aWNlIG5hbWUuCj4gPiA+ID4gPgo+ID4gPiA+ID4gV2l0aCB0aGlz
IHBhdGNoIGFwcGxpZWQsIGRyaXZlcnMgc2hvdWxkIHVzZSB2ZHBhX21nbXRkZXZfYWxsb2MoKQo+
ID4gPiA+ID4gb3IgX3ZkcGFfbWdtdGRldl9hbGxvYygpIHRvIGFsbG9jYXRlIGEgdkRQQSBtYW5h
Z2VtZW50IGRldmljZQo+ID4gPiA+ID4gYmVmb3JlIGNhbGxpbmcgdmRwYV9tZ210ZGV2X3JlZ2lz
dGVyKCkuIEFuZCBzb21lIGJ1Z2d5IGVtcHR5Cj4gPiA+ID4gPiByZWxlYXNlIGZ1bmN0aW9uIGNh
biBhbHNvIGJlIHJlbW92ZWQgZnJvbSB0aGUgZHJpdmVyIGNvZGVzLgo+ID4gPiA+ID4KPiA+ID4g
PiA+IFNpZ25lZC1vZmYtYnk6IFhpZSBZb25namkgPHhpZXlvbmdqaUBieXRlZGFuY2UuY29tPgo+
ID4gPiA+ID4gLS0tCj4gPiA+ID4gPiAgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9tYWluLmMg
ICAgICB8IDExICsrLS0KPiA+ID4gPiA+ICAgZHJpdmVycy92ZHBhL21seDUvbmV0L21seDVfdm5l
dC5jICAgIHwgMTEgKystLQo+ID4gPiA+ID4gICBkcml2ZXJzL3ZkcGEvdmRwYS5jICAgICAgICAg
ICAgICAgICAgfCA5MiArKysrKysrKysrKysrKysrKysrKysrKystLS0tCj4gPiA+ID4gPiAgIGRy
aXZlcnMvdmRwYS92ZHBhX3NpbS92ZHBhX3NpbV9ibGsuYyB8IDM5ICsrKystLS0tLS0tLQo+ID4g
PiA+ID4gICBkcml2ZXJzL3ZkcGEvdmRwYV9zaW0vdmRwYV9zaW1fbmV0LmMgfCA0NiArKysrKy0t
LS0tLS0tLQo+ID4gPiA+ID4gICBkcml2ZXJzL3ZkcGEvdmRwYV91c2VyL3ZkdXNlX2Rldi5jICAg
fCAzOCArKysrLS0tLS0tLS0KPiA+ID4gPiA+ICAgaW5jbHVkZS9saW51eC92ZHBhLmggICAgICAg
ICAgICAgICAgIHwgMzggKysrKysrKysrKystCj4gPiA+ID4gPiAgIDcgZmlsZXMgY2hhbmdlZCwg
MTY4IGluc2VydGlvbnMoKyksIDEwNyBkZWxldGlvbnMoLSkKPiA+ID4gPiA+Cj4gPiA+ID4gPiBk
aWZmIC0tZ2l0IGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYyBiL2RyaXZlcnMvdmRw
YS9pZmN2Zi9pZmN2Zl9tYWluLmMKPiA+ID4gPiA+IGluZGV4IDQzNjYzMjBmYjY4ZC4uZDQwODdj
MzdjZmRmIDEwMDY0NAo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21h
aW4uYwo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy92ZHBhL2lmY3ZmL2lmY3ZmX21haW4uYwo+ID4g
PiA+ID4gQEAgLTgyMSwxMCArODIxLDExIEBAIHN0YXRpYyBpbnQgaWZjdmZfcHJvYmUoc3RydWN0
IHBjaV9kZXYgKnBkZXYsIGNvbnN0IHN0cnVjdCBwY2lfZGV2aWNlX2lkICppZCkKPiA+ID4gPiA+
ICAgICAgIHUzMiBkZXZfdHlwZTsKPiA+ID4gPiA+ICAgICAgIGludCByZXQ7Cj4gPiA+ID4gPgo+
ID4gPiA+ID4gLSAgICAgaWZjdmZfbWdtdF9kZXYgPSBremFsbG9jKHNpemVvZihzdHJ1Y3QgaWZj
dmZfdmRwYV9tZ210X2RldiksIEdGUF9LRVJORUwpOwo+ID4gPiA+ID4gLSAgICAgaWYgKCFpZmN2
Zl9tZ210X2Rldikgewo+ID4gPiA+ID4gKyAgICAgaWZjdmZfbWdtdF9kZXYgPSB2ZHBhX21nbXRk
ZXZfYWxsb2Moc3RydWN0IGlmY3ZmX3ZkcGFfbWdtdF9kZXYsCj4gPiA+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBtZGV2LCBkZXZfbmFtZShkZXYpLCBkZXYp
Owo+ID4gPiA+Cj4gPiA+ID4KPiA+ID4gPiBKdXN0IHdvbmRlciBpZiBpdCdzIGJldHRlciB0byBt
YWtlIHZEUEEgZGV2aWNlIGEgY2hpbGQgb2YgdGhlIG1nbXQKPiA+ID4gPiBkZXZpY2UgaW5zdGVh
ZCBvZiB0aGUgUENJIGRldmljZT8KPiA+ID4gPgo+ID4gPiA+IChDdXJyZW50bHkgd2UgdXNlIFBD
SSBkZXZpY2UgYXMgdGhlIHBhcmVudCBvZiB0aGUgdkRQQSBkZXZpY2UsIG9yIGF0Cj4gPiA+ID4g
bGVhc3Qgd2UgY2FuIGRvIHRoaXMgZm9yIHRoZSBzaW11bGF0b3Igd2hpY2ggZG9lc24ndCBoYXZl
IGEgcGFyZW50PykKPiA+ID4gPgo+ID4gPgo+ID4gPiBNYWtlIHNlbnNlLiBJIHRoaW5rIHdlIGNh
biBkbyBpdCBmb3IgYWxsIHZEUEEgZHJpdmVycy4gTWFrZSBzdXJlIHRoZQo+ID4gPiBwYXJlbnQg
b2YgdGhlIHZEUEEgZGV2aWNlIGlzIHRoZSB2RFBBIG1hbmFnZW1lbnQgZGV2aWNlLgo+ID4gPgo+
ID4gPiBUaGFua3MsCj4gPiA+IFlvbmdqaQo+ID4KPiA+Cj4gPiB0aGF0J3MgYW4gQUJJIGNoYW5n
ZSB0aG91Z2ggaXNuJ3QgaXQ/IHBhcmVudCBpcyBleHBvc2VkIGluIHN5c2ZzLAo+ID4gcmlnaHQ/
Cj4gPgo+IAo+IEhtbS4uLnllcy4gU28gaXQgbG9va3MgbGlrZSB3ZSBjYW4ndCBjaGFuZ2UgaXQs
IHJpZ2h0Pwo+IAo+IFRoYW5rcywKPiBZb25namkKCkFmcmFpZCBzby4gYSB3YXkgdG8gZmluZCB0
aGUgcGNpIGRldmljZSBhbHJlYWR5IGV4aXN0cyBJIHRoaW5rLCByaWdodD8KCi0tIApNU1QKCl9f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0
aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9y
ZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0
dWFsaXphdGlvbg==
