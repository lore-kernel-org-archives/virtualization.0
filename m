Return-Path: <SRS0=ITlz=HH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9F165C433E0
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 14:17:20 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E93DE650CE
	for <virtualization@archiver.kernel.org>; Fri,  5 Feb 2021 14:17:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E93DE650CE
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 7DB8D8730F;
	Fri,  5 Feb 2021 14:17:19 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 8z9dsSDL-v+K; Fri,  5 Feb 2021 14:17:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id C40AD87323;
	Fri,  5 Feb 2021 14:17:18 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id AA7B0C0174;
	Fri,  5 Feb 2021 14:17:18 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E1AE1C013A
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 14:17:16 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by silver.osuosl.org (Postfix) with ESMTP id C622620377
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 14:17:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id wxDyORooon-d
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 14:17:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by silver.osuosl.org (Postfix) with ESMTPS id 2931F2034C
 for <virtualization@lists.linux-foundation.org>;
 Fri,  5 Feb 2021 14:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1612534633;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=NnP5XCU4u3GLA5tU6K2RnQ5rd1UvAC9ZZ89SyiHV8bU=;
 b=MndZkyEXYt9TNu5vL00CJm3Z0RaYNFPHw88sk1Ir2rSqZLeRU2s+mKZClkvJMFZ24Enh+m
 E/3m0QxkIugtgOrYEjdk4V34mGM35K69Ta42Z9sK52Uul/13egszvy8CzWyOJAcCRvWsvg
 EtUQNLdUgvLBb9kG3Gs9u71XDNRz4zo=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-409-asQGT-gfMl6mT6dHAF8RTg-1; Fri, 05 Feb 2021 09:17:11 -0500
X-MC-Unique: asQGT-gfMl6mT6dHAF8RTg-1
Received: by mail-wm1-f72.google.com with SMTP id z25so5637933wml.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 05 Feb 2021 06:17:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=NnP5XCU4u3GLA5tU6K2RnQ5rd1UvAC9ZZ89SyiHV8bU=;
 b=aON5DXFUAJWN60x5whmK4Oyxrp3P+DCsqzgR8gHKwRxaC5OSqNdJrmiZCAzzNCxti8
 St3e9edOPPw/8EbKAwKBFIrh3381YIyTTVGb2hqaLPz49u7sgEOiD4imRKYuKA+HWQ8f
 NFfd8OElTppmOc8eV+z0UdGoRpX6VV0nCxpDQ1din97DnTqt5Lxf1JRLac1de4r20bhG
 o14lS07uujJav0oQb0hdSw6pzQSfoB7hDPOcxbcqZ+UzpU4VnSzEghwOp0e2puK17MF0
 +D7/fGGytDntqmKsvg7ZGuooumWGG/ZAqbijX9N8nLyBDa6Jk6kVhuiKmuAZC2XC3Fn0
 mmng==
X-Gm-Message-State: AOAM533t9DlHDHoLw5i6oo7QFLHPdLkJ9nLv9sAs5htZuD/hnio76tWb
 87e01o7SeicmiVq/JL4m4SZs4aOK4zlRD4QZGCm5KY82Kmg3jZgojrLCAksigjlZgi7UOppxtTW
 gzbhxzoEnpGBvsP5+natKjIMFn7AfxjwNf4++vqe1LA==
X-Received: by 2002:a5d:453b:: with SMTP id j27mr5351081wra.92.1612534630614; 
 Fri, 05 Feb 2021 06:17:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxoN6BUEbnc4t31XEyr636+ZdDqrgfqdIVz7cbLxF0zafdGnFimMKQJ7JMi3xLjdYuOKx6feA==
X-Received: by 2002:a5d:453b:: with SMTP id j27mr5351061wra.92.1612534630414; 
 Fri, 05 Feb 2021 06:17:10 -0800 (PST)
Received: from steredhat (host-79-34-249-199.business.telecomitalia.it.
 [79.34.249.199])
 by smtp.gmail.com with ESMTPSA id v6sm12579287wrx.32.2021.02.05.06.17.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Feb 2021 06:17:09 -0800 (PST)
Date: Fri, 5 Feb 2021 15:17:07 +0100
From: Stefano Garzarella <sgarzare@redhat.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCH v3 09/13] vhost/vdpa: remove vhost_vdpa_config_validate()
Message-ID: <20210205141707.clbckauxnrzd7nmv@steredhat>
References: <20210204172230.85853-1-sgarzare@redhat.com>
 <20210204172230.85853-10-sgarzare@redhat.com>
 <6919d2d4-cc8e-2b67-2385-35803de5e38b@redhat.com>
 <20210205091651.xfcdyuvwwzew2ufo@steredhat>
 <20210205083108-mutt-send-email-mst@kernel.org>
MIME-Version: 1.0
In-Reply-To: <20210205083108-mutt-send-email-mst@kernel.org>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=sgarzare@redhat.com
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
Content-Transfer-Encoding: base64
Content-Type: text/plain; charset="utf-8"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

T24gRnJpLCBGZWIgMDUsIDIwMjEgYXQgMDg6MzI6MzdBTSAtMDUwMCwgTWljaGFlbCBTLiBUc2ly
a2luIHdyb3RlOgo+T24gRnJpLCBGZWIgMDUsIDIwMjEgYXQgMTA6MTY6NTFBTSArMDEwMCwgU3Rl
ZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+PiBPbiBGcmksIEZlYiAwNSwgMjAyMSBhdCAxMToyNzoz
MkFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiA+Cj4+ID4gT24gMjAyMS8yLzUg5LiK5Y2I
MToyMiwgU3RlZmFubyBHYXJ6YXJlbGxhIHdyb3RlOgo+PiA+ID4gZ2V0X2NvbmZpZygpIGFuZCBz
ZXRfY29uZmlnKCkgY2FsbGJhY2tzIGluIHRoZSAnc3RydWN0IHZkcGFfY29uZmlnX29wcycKPj4g
PiA+IHVzdWFsbHkgYWxyZWFkeSB2YWxpZGF0ZWQgdGhlIGlucHV0cy4gQWxzbyBub3cgdGhleSBj
YW4gcmV0dXJuIGFuIGVycm9yLAo+PiA+ID4gc28gd2UgZG9uJ3QgbmVlZCB0byB2YWxpZGF0ZSB0
aGVtIGhlcmUgYW55bW9yZS4KPj4gPiA+Cj4+ID4gPiBMZXQncyB1c2UgdGhlIHJldHVybiB2YWx1
ZSBvZiB0aGVzZSBjYWxsYmFja3MgYW5kIHJldHVybiBpdCBpbiBjYXNlIG9mCj4+ID4gPiBlcnJv
ciBpbiB2aG9zdF92ZHBhX2dldF9jb25maWcoKSBhbmQgdmhvc3RfdmRwYV9zZXRfY29uZmlnKCku
Cj4+ID4gPgo+PiA+ID4gT3JpZ2luYWxseS1ieTogWGllIFlvbmdqaSA8eGlleW9uZ2ppQGJ5dGVk
YW5jZS5jb20+Cj4+ID4gPiBTaWduZWQtb2ZmLWJ5OiBTdGVmYW5vIEdhcnphcmVsbGEgPHNnYXJ6
YXJlQHJlZGhhdC5jb20+Cj4+ID4gPiAtLS0KPj4gPiA+ICBkcml2ZXJzL3Zob3N0L3ZkcGEuYyB8
IDQxICsrKysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tCj4+ID4gPiAgMSBm
aWxlIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDI4IGRlbGV0aW9ucygtKQo+PiA+ID4KPj4g
PiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3Zob3N0L3ZkcGEuYyBiL2RyaXZlcnMvdmhvc3QvdmRw
YS5jCj4+ID4gPiBpbmRleCBlZjY4OGM4YzBlMGUuLmQ2MWU3NzkwMDBhOCAxMDA2NDQKPj4gPiA+
IC0tLSBhL2RyaXZlcnMvdmhvc3QvdmRwYS5jCj4+ID4gPiArKysgYi9kcml2ZXJzL3Zob3N0L3Zk
cGEuYwo+PiA+ID4gQEAgLTE4NSw1MSArMTg1LDM1IEBAIHN0YXRpYyBsb25nIHZob3N0X3ZkcGFf
c2V0X3N0YXR1cyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwgdTggX191c2VyICpzdGF0dXNwKQo+PiA+
ID4gIAlyZXR1cm4gMDsKPj4gPiA+ICB9Cj4+ID4gPiAtc3RhdGljIGludCB2aG9zdF92ZHBhX2Nv
bmZpZ192YWxpZGF0ZShzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPj4gPiA+IC0JCQkJICAgICAgc3Ry
dWN0IHZob3N0X3ZkcGFfY29uZmlnICpjKQo+PiA+ID4gLXsKPj4gPiA+IC0JbG9uZyBzaXplID0g
MDsKPj4gPiA+IC0KPj4gPiA+IC0Jc3dpdGNoICh2LT52aXJ0aW9faWQpIHsKPj4gPiA+IC0JY2Fz
ZSBWSVJUSU9fSURfTkVUOgo+PiA+ID4gLQkJc2l6ZSA9IHNpemVvZihzdHJ1Y3QgdmlydGlvX25l
dF9jb25maWcpOwo+PiA+ID4gLQkJYnJlYWs7Cj4+ID4gPiAtCX0KPj4gPiA+IC0KPj4gPiA+IC0J
aWYgKGMtPmxlbiA9PSAwKQo+PiA+ID4gLQkJcmV0dXJuIC1FSU5WQUw7Cj4+ID4gPiAtCj4+ID4g
PiAtCWlmIChjLT5sZW4gPiBzaXplIC0gYy0+b2ZmKQo+PiA+ID4gLQkJcmV0dXJuIC1FMkJJRzsK
Pj4gPiA+IC0KPj4gPiA+IC0JcmV0dXJuIDA7Cj4+ID4gPiAtfQo+PiA+ID4gLQo+PiA+ID4gIHN0
YXRpYyBsb25nIHZob3N0X3ZkcGFfZ2V0X2NvbmZpZyhzdHJ1Y3Qgdmhvc3RfdmRwYSAqdiwKPj4g
PiA+ICAJCQkJICBzdHJ1Y3Qgdmhvc3RfdmRwYV9jb25maWcgX191c2VyICpjKQo+PiA+ID4gIHsK
Pj4gPiA+ICAJc3RydWN0IHZkcGFfZGV2aWNlICp2ZHBhID0gdi0+dmRwYTsKPj4gPiA+ICAJc3Ry
dWN0IHZob3N0X3ZkcGFfY29uZmlnIGNvbmZpZzsKPj4gPiA+ICAJdW5zaWduZWQgbG9uZyBzaXpl
ID0gb2Zmc2V0b2Yoc3RydWN0IHZob3N0X3ZkcGFfY29uZmlnLCBidWYpOwo+PiA+ID4gKwlsb25n
IHJldDsKPj4gPiA+ICAJdTggKmJ1ZjsKPj4gPiA+ICAJaWYgKGNvcHlfZnJvbV91c2VyKCZjb25m
aWcsIGMsIHNpemUpKQo+PiA+ID4gIAkJcmV0dXJuIC1FRkFVTFQ7Cj4+ID4gPiAtCWlmICh2aG9z
dF92ZHBhX2NvbmZpZ192YWxpZGF0ZSh2LCAmY29uZmlnKSkKPj4gPiA+ICsJaWYgKGNvbmZpZy5s
ZW4gPT0gMCkKPj4gPiA+ICAJCXJldHVybiAtRUlOVkFMOwo+PiA+ID4gIAlidWYgPSBrdnphbGxv
Yyhjb25maWcubGVuLCBHRlBfS0VSTkVMKTsKPj4gPgo+PiA+Cj4+ID4gVGhlbiBpdCBtZWFucyB1
c2Vyc2FwY2UgY2FuIGFsbG9jYXRlIGEgdmVyeSBsYXJnZSBtZW1vcnkuCj4+Cj4+IEdvb2QgcG9p
bnQuCj4+Cj4+ID4KPj4gPiBSZXRoaW5rIGFib3V0IHRoaXMsIHdlIHNob3VsZCBsaW1pdCB0aGUg
c2l6ZSBoZXJlIChlLmcgUEFHRV9TSVpFKSBvcgo+PiA+IGZldGNoIHRoZSBjb25maWcgc2l6ZSBm
aXJzdCAoZWl0aGVyIHRocm91Z2ggYSBjb25maWcgb3BzIGFzIHlvdQo+PiA+IHN1Z2dlc3RlZCBv
ciBhIHZhcmlhYmxlIGluIHRoZSB2ZHBhIGRldmljZSB0aGF0IGlzIGluaXRpYWxpemVkIGR1cmlu
Zwo+PiA+IGRldmljZSBjcmVhdGlvbikuCj4+Cj4+IE1heWJlIFBBR0VfU0laRSBpcyBva2F5IGFz
IGEgbGltaXQuCj4+Cj4+IElmIGluc3RlYWQgd2Ugd2FudCB0byBmZXRjaCB0aGUgY29uZmlnIHNp
emUsIHRoZW4gYmV0dGVyIGEgY29uZmlnIG9wcyBpbiBteQo+PiBvcGluaW9uLCB0byBhdm9pZCBh
ZGRpbmcgYSBuZXcgcGFyYW1ldGVyIHRvIF9fdmRwYV9hbGxvY19kZXZpY2UoKS4KPj4KPj4gSSB2
b3RlIGZvciBQQUdFX1NJWkUsIGJ1dCBpdCBpc24ndCBhIHN0cm9uZyBvcGluaW9uLgo+Pgo+PiBX
aGF0IGRvIHlvdSBhbmQgQE1pY2hhZWwgc3VnZ2VzdD8KPj4KPj4gVGhhbmtzLAo+PiBTdGVmYW5v
Cj4KPkRldmljZXMga25vdyB3aGF0IHRoZSBjb25maWcgc2l6ZSBpcy4gSnVzdCBoYXZlIHRoZW0g
cHJvdmlkZSBpdC4KPgoKT2theSwgSSdsbCBhZGQgZ2V0X2NvbmZpZ19zaXplKCkgY2FsbGJhY2sg
aW4gdmRwYV9jb25maWdfb3BzIGFuZCBJJ2xsIApsZWF2ZSB2aG9zdF92ZHBhX2NvbmZpZ192YWxp
ZGF0ZSgpIHRoYXQgd2lsbCB1c2UgdGhhdCBjYWxsYmFjayBpbnN0ZWFkIApvZiAndmlydGlvX2lk
JyB0byBnZXQgdGhlIGNvbmZpZyBzaXplIGZyb20gdGhlIGRldmljZS4KCkF0IHRoaXMgcG9pbnQg
SSB0aGluayBJIGNhbiByZW1vdmUgdGhlICJ2ZHBhOiBhZGQgcmV0dXJuIHZhbHVlIHRvIApnZXRf
Y29uZmlnL3NldF9jb25maWcgY2FsbGJhY2tzIiBwYXRjaCBhbmQgbGVhdmUgdm9pZCByZXR1cm4g
dG8gCmdldF9jb25maWcvc2V0X2NvbmZpZyBjYWxsYmFja3MuCgpEb2VzIHRoaXMgbWFrZSBzZW5z
ZT8KClRoYW5rcywKU3RlZmFubwoKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxp
c3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9y
Zy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
