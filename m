Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3C5E9C433F5
	for <virtualization@archiver.kernel.org>; Tue, 26 Apr 2022 03:53:32 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id EED63828F2;
	Tue, 26 Apr 2022 03:53:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id tS5HluGyHV5K; Tue, 26 Apr 2022 03:53:31 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7C9B582768;
	Tue, 26 Apr 2022 03:53:30 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5AD60C0032;
	Tue, 26 Apr 2022 03:53:30 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E44D7C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 03:53:28 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id C952F4035D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 03:53:28 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Dv9tMYBSWfPw
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 03:53:28 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 03A004013B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 26 Apr 2022 03:53:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1650945206;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=U56zSxUw/A+PjopBzCaVhOCjovFUkZ0LYAX7dUOgfDQ=;
 b=Bye0Ok69xMfAtg1fiuPHrY5uANDsDRKHtt1C1kVezyTWFH7PgqSVl8gyZnKSCzm3HeFPX3
 XgClLcX1JsBzbKi3uhH3dfZJCWWcGI1V2d88bi/GOoaPXtFe7TwZqmsmdUXqFVG0Vhixbl
 l1R/aH6PECmb7vfMLGhPtKWjdVUqHLI=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-215-v2_Mdsp4NbS7LYT5GXQQXg-1; Mon, 25 Apr 2022 23:53:25 -0400
X-MC-Unique: v2_Mdsp4NbS7LYT5GXQQXg-1
Received: by mail-wm1-f70.google.com with SMTP id
 r203-20020a1c44d4000000b00393f52ed5ceso171889wma.7
 for <virtualization@lists.linux-foundation.org>;
 Mon, 25 Apr 2022 20:53:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=U56zSxUw/A+PjopBzCaVhOCjovFUkZ0LYAX7dUOgfDQ=;
 b=CfNrmxExMENYcZhAbl0ILGGrCl4zME0qL4/JmQXcPL78YlY3bmAlo2kkVfmhad1WkN
 020rVkYlaOsHKR6kGG0jiPlLgK5kRgEU2sqpRZXCHd+7p9Jdw3CeKRbdN8kia+Y0pqfi
 d/N0Ni/+k6OylrRzWYLzFOhnGycHHlPShQ8r7rUBr/ojwhzS7dDcxtwPvqHp190yLNgP
 xa5PHICTzpqs6XLq6pGPRpnD1L4nA57vKbyaDr1WfZQ9dwbT52IoFR9r/ykm6eg9f9ov
 5SWur3vGeJFQx4kvnmMc4FkspWNw06HM5yArvxN7OqbWIGHZOSxguMbJsAjtecotixtd
 W8Cw==
X-Gm-Message-State: AOAM532W8uQu9oimP9LQPEiXlc1G/guSdem+XTPz8/KiUbzBtlvzfzv4
 m177SlOIDq4uOBBg3ljjckibBVG+Ed7DExvXjRzm460fiFw3IwM73QnkMH6CAkKEquexzz7uY+p
 0hq5kt3LY6AsZRmVSplAEXCv8e/QwRUg8wuHa10teOg==
X-Received: by 2002:a05:600c:651:b0:381:3d7b:40e0 with SMTP id
 p17-20020a05600c065100b003813d7b40e0mr28427288wmm.17.1650945204341; 
 Mon, 25 Apr 2022 20:53:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxofEkhZ9h2B7Wu29O8xUY779/GKPNSvhJI1vPU3mEtBK3l2xYcVadO+u++va5nxtAPdGEXXQ==
X-Received: by 2002:a05:600c:651:b0:381:3d7b:40e0 with SMTP id
 p17-20020a05600c065100b003813d7b40e0mr28427277wmm.17.1650945204148; 
 Mon, 25 Apr 2022 20:53:24 -0700 (PDT)
Received: from redhat.com ([2.53.22.137]) by smtp.gmail.com with ESMTPSA id
 bg20-20020a05600c3c9400b0037fa5c422c8sm13535917wmb.48.2022.04.25.20.53.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 25 Apr 2022 20:53:23 -0700 (PDT)
Date: Mon, 25 Apr 2022 23:53:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH V3 6/9] virtio-ccw: implement synchronize_cbs()
Message-ID: <20220425235134-mutt-send-email-mst@kernel.org>
References: <20220425024418.8415-1-jasowang@redhat.com>
 <20220425024418.8415-7-jasowang@redhat.com>
 <20220425040512-mutt-send-email-mst@kernel.org>
 <87a6c98rwf.fsf@redhat.com>
 <20220425095742-mutt-send-email-mst@kernel.org>
 <20220426042911.544477f9.pasic@linux.ibm.com>
 <20220425233434-mutt-send-email-mst@kernel.org>
 <20220425233604-mutt-send-email-mst@kernel.org>
 <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
MIME-Version: 1.0
In-Reply-To: <ba0c3977-c471-3275-2327-c5910cdd506a@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: paulmck@kernel.org, lulu@redhat.com, peterz@infradead.org, maz@kernel.org,
 Cornelia Huck <cohuck@redhat.com>, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, Halil Pasic <pasic@linux.ibm.com>,
 eperezma@redhat.com, tglx@linutronix.de
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

T24gVHVlLCBBcHIgMjYsIDIwMjIgYXQgMTE6NDI6NDVBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiDlnKggMjAyMi80LzI2IDExOjM4LCBNaWNoYWVsIFMuIFRzaXJraW4g5YaZ6YGTOgo+
ID4gT24gTW9uLCBBcHIgMjUsIDIwMjIgYXQgMTE6MzU6NDFQTSAtMDQwMCwgTWljaGFlbCBTLiBU
c2lya2luIHdyb3RlOgo+ID4gPiBPbiBUdWUsIEFwciAyNiwgMjAyMiBhdCAwNDoyOToxMUFNICsw
MjAwLCBIYWxpbCBQYXNpYyB3cm90ZToKPiA+ID4gPiBPbiBNb24sIDI1IEFwciAyMDIyIDA5OjU5
OjU1IC0wNDAwCj4gPiA+ID4gIk1pY2hhZWwgUy4gVHNpcmtpbiIgPG1zdEByZWRoYXQuY29tPiB3
cm90ZToKPiA+ID4gPiAKPiA+ID4gPiA+IE9uIE1vbiwgQXByIDI1LCAyMDIyIGF0IDEwOjU0OjI0
QU0gKzAyMDAsIENvcm5lbGlhIEh1Y2sgd3JvdGU6Cj4gPiA+ID4gPiA+IE9uIE1vbiwgQXByIDI1
IDIwMjIsICJNaWNoYWVsIFMuIFRzaXJraW4iIDxtc3RAcmVkaGF0LmNvbT4gd3JvdGU6Cj4gPiA+
ID4gPiA+ID4gT24gTW9uLCBBcHIgMjUsIDIwMjIgYXQgMTA6NDQ6MTVBTSArMDgwMCwgSmFzb24g
V2FuZyB3cm90ZToKPiA+ID4gPiA+ID4gPiA+IFRoaXMgcGF0Y2ggdHJpZXMgdG8gaW1wbGVtZW50
IHRoZSBzeW5jaHJvbml6ZV9jYnMoKSBmb3IgY2N3LiBGb3IgdGhlCj4gPiA+ID4gPiA+ID4gPiB2
cmluZ19pbnRlcnJ1cHQoKSB0aGF0IGlzIGNhbGxlZCB2aWEgdmlydGlvX2FpcnFfaGFuZGxlcigp
LCB0aGUKPiA+ID4gPiA+ID4gPiA+IHN5bmNocm9uaXphdGlvbiBpcyBzaW1wbHkgZG9uZSB2aWEg
dGhlIGFpcnFfaW5mbydzIGxvY2suIEZvciB0aGUKPiA+ID4gPiA+ID4gPiA+IHZyaW5nX2ludGVy
cnVwdCgpIHRoYXQgaXMgY2FsbGVkIHZpYSB2aXJ0aW9fY2N3X2ludF9oYW5kbGVyKCksIGEgcGVy
Cj4gPiA+ID4gPiA+ID4gPiBkZXZpY2Ugc3BpbmxvY2sgZm9yIGlycSBpcyBpbnRyb2R1Y2VkIGFu
cyB1c2VkIGluIHRoZSBzeW5jaHJvbml6YXRpb24KPiA+ID4gPiA+ID4gPiA+IG1ldGhvZC4KPiA+
ID4gPiA+ID4gPiA+IAo+ID4gPiA+ID4gPiA+ID4gQ2M6IFRob21hcyBHbGVpeG5lciA8dGdseEBs
aW51dHJvbml4LmRlPgo+ID4gPiA+ID4gPiA+ID4gQ2M6IFBldGVyIFppamxzdHJhIDxwZXRlcnpA
aW5mcmFkZWFkLm9yZz4KPiA+ID4gPiA+ID4gPiA+IENjOiAiUGF1bCBFLiBNY0tlbm5leSIgPHBh
dWxtY2tAa2VybmVsLm9yZz4KPiA+ID4gPiA+ID4gPiA+IENjOiBNYXJjIFp5bmdpZXIgPG1hekBr
ZXJuZWwub3JnPgo+ID4gPiA+ID4gPiA+ID4gQ2M6IEhhbGlsIFBhc2ljIDxwYXNpY0BsaW51eC5p
Ym0uY29tPgo+ID4gPiA+ID4gPiA+ID4gQ2M6IENvcm5lbGlhIEh1Y2sgPGNvaHVja0ByZWRoYXQu
Y29tPgo+ID4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24gV2FuZyA8amFzb3dhbmdA
cmVkaGF0LmNvbT4KPiA+ID4gPiA+ID4gPiAKPiA+ID4gPiA+ID4gPiBUaGlzIGlzIHRoZSBvbmx5
IG9uZSB0aGF0IGlzIGdpdmluZyBtZSBwYXVzZS4gSGFsaWwsIENvcm5lbGlhLAo+ID4gPiA+ID4g
PiA+IHNob3VsZCB3ZSBiZSBjb25jZXJuZWQgYWJvdXQgdGhlIHBlcmZvcm1hbmNlIGltcGFjdCBo
ZXJlPwo+ID4gPiA+ID4gPiA+IEFueSBjaGFuY2UgaXQgY2FuIGJlIHRlc3RlZD8KPiA+ID4gPiA+
ID4gV2UgY2FuIGhhdmUgYSBidW5jaCBvZiBkZXZpY2VzIHVzaW5nIHRoZSBzYW1lIGFpcnEgc3Ry
dWN0dXJlLCBhbmQgdGhlCj4gPiA+ID4gPiA+IHN5bmMgY2IgY3JlYXRlcyBhIGNob2tlIHBvaW50
LCBzYW1lIGFzIHJlZ2lzdGVyaW5nL3VucmVnaXN0ZXJpbmcuCj4gPiA+ID4gPiBCVFcgY2FuIGNh
bGxiYWNrcyBmb3IgbXVsdGlwbGUgVlFzIHJ1biBvbiBtdWx0aXBsZSBDUFVzIGF0IHRoZSBtb21l
bnQ/Cj4gPiA+ID4gSSdtIG5vdCBzdXJlIEkgdW5kZXJzdGFuZCB0aGUgcXVlc3Rpb24uCj4gPiA+
ID4gCj4gPiA+ID4gSSBkbyB0aGluayB3ZSBjYW4gaGF2ZSBtdWx0aXBsZSBDUFVzIHRoYXQgYXJl
IGV4ZWN1dGluZyBzb21lIHBvcnRpb24gb2YKPiA+ID4gPiB2aXJ0aW9fY2N3X2ludF9oYW5kbGVy
KCkuIFNvIEkgZ3Vlc3MgdGhlIGFuc3dlciBpcyB5ZXMuIENvbm5pZSB3aGF0IGRvIHlvdSB0aGlu
az8KPiA+ID4gPiAKPiA+ID4gPiBPbiB0aGUgb3RoZXIgaGFuZCB3ZSBjb3VsZCBhbHNvIGVuZCB1
cCBzZXJpYWxpemluZyBzeW5jaHJvbml6ZV9jYnMoKQo+ID4gPiA+IGNhbGxzIGZvciBkaWZmZXJl
bnQgZGV2aWNlcyBpZiB0aGV5IGhhcHBlbiB0byB1c2UgdGhlIHNhbWUgYWlycV9pbmZvLiBCdXQK
PiA+ID4gPiB0aGlzIHByb2JhYmx5IHdhcyBub3QgeW91ciBxdWVzdGlvbgo+ID4gPiAKPiA+ID4g
SSBhbSBsZXNzIGNvbmNlcm5lZCBhYm91dCAgc3luY2hyb25pemVfY2JzIGJlaW5nIHNsb3cgYW5k
IG1vcmUgYWJvdXQKPiA+ID4gdGhlIHNsb3dkb3duIGluIGludGVycnVwdCBwcm9jZXNzaW5nIGl0
c2VsZi4KPiA+ID4gCj4gPiA+ID4gPiB0aGlzIHBhdGNoIHNlcmlhbGl6ZXMgdGhlbSBvbiBhIHNw
aW5sb2NrLgo+ID4gPiA+ID4gCj4gPiA+ID4gVGhvc2UgY291bGQgdGhlbiBwaWxlIHVwIG9uIHRo
ZSBuZXdseSBpbnRyb2R1Y2VkIHNwaW5sb2NrLgo+ID4gPiA+IAo+ID4gPiA+IFJlZ2FyZHMsCj4g
PiA+ID4gSGFsaWwKPiA+ID4gSG1tIHllYSAuLi4gbm90IGdvb2QuCj4gPiBJcyB0aGVyZSBhbnkg
b3RoZXIgd2F5IHRvIHN5bmNocm9uaXplIHdpdGggYWxsIGNhbGxiYWNrcz8KPiAKPiAKPiBNYXli
ZSB1c2luZyByd2xvY2sgYXMgYWlycSBoYW5kbGVyPwo+IAo+IFRoYW5rcwo+IAoKcndsb2NrIGlz
IHN0aWxsIGEgc2hhcmVkIGNhY2hlbGluZSBib3VuY2luZyBiZXR3ZWVuIENQVXMgYW5kCmEgYnVu
Y2ggb2Ygb3JkZXJpbmcgaW5zdHJ1Y3Rpb25zLgpNYXliZSBzb21ldGhpbmcgcGVyLWNwdSArIHNv
bWUgSVBJcyB0byBydW4gdGhpbmdzIG9uIGFsbCBDUFVzIGluc3RlYWQ/Cgo+ID4gCj4gPiA+IC0t
IAo+ID4gPiBNU1QKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
