Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8E86CCA482
	for <virtualization@archiver.kernel.org>; Tue, 28 Jun 2022 00:41:00 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 44BF26077D;
	Tue, 28 Jun 2022 00:41:00 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 44BF26077D
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca header.a=rsa-sha256 header.s=google header.b=QGfGz2Xe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id WLHM7t7XQgKH; Tue, 28 Jun 2022 00:40:59 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 2254260777;
	Tue, 28 Jun 2022 00:40:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 2254260777
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EA159C0032;
	Tue, 28 Jun 2022 00:40:57 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3A935C002D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 00:40:57 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 1CD2C40144
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 00:40:57 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1CD2C40144
Authentication-Results: smtp2.osuosl.org;
 dkim=pass (2048-bit key) header.d=ziepe.ca header.i=@ziepe.ca
 header.a=rsa-sha256 header.s=google header.b=QGfGz2Xe
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id B5ue9Z221iKy
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 00:40:56 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D615D400D6
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com
 [IPv6:2607:f8b0:4864:20::72a])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D615D400D6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 28 Jun 2022 00:40:55 +0000 (UTC)
Received: by mail-qk1-x72a.google.com with SMTP id f14so8674939qkm.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 27 Jun 2022 17:40:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ziepe.ca; s=google;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:content-transfer-encoding:in-reply-to;
 bh=nrCjPCGAs4MTUiLBt7Ijf/MJPuIyH6lM8yqPhdyhJD8=;
 b=QGfGz2XeyaJLxS6IycR7jteyzbs2f9vu4fQQcftWhoNW5sUtbyuMKwRS5XXshn3Hg2
 yZubOZXW72TGsXoMKBc9lhqncUYMSH0Z6bymz383cNPRRHeF7rKM5RXMNm4Eaw5tsGTg
 BQX0bHWNlf6m2F5J4oWG32dxQT2CTBmnGX6tl+1lipYgts8fc/1uUmHwN5t3zZzoA6Qn
 DTeDwoNVOxWo0hy32OR9hFE/UO0/97qh5eo+5ewqu/iIRVMFQ1AIctopaFBuZOm9BPLs
 HAx/pGMXLvvVO6Cb9sesF2T5smUMb44u7gsx78px69APS8fFzY4PmSgo/WM3D328ZbRr
 X/FA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=nrCjPCGAs4MTUiLBt7Ijf/MJPuIyH6lM8yqPhdyhJD8=;
 b=VSC1rqIHjtMAMyBCmE/BVWNdWEZbmyaJjsY9Nrsmu/y1yVPeHXM6ZyjfbZRb4IR/AW
 eRu79iLk/zTaYjmSemTzflC4hecdwp9Hp+j/HnPd+yoLOV6H5s6JQV2v91YTjQsEv3Y7
 N4U+Swe9j88ZBqybK9tzmaMtn34sHjprPgag3vlRHosZsb/ko00rjzStJaw9oWzgX6Jk
 11yhcwwoUflXSDC6gcQWnLZuvbKqWDfmy1/Ps1B0QbtxYRfRaY93ggAd6txM5ccUnIHA
 W+mXw4Cu17h0OfH5W4qCj07G+jreOho1XB7f/nQUVOTgr9fmFkRpoMO/pRi6GOxXNcab
 qjYw==
X-Gm-Message-State: AJIora90VdUOEzZjAtwNbLGytokCunu00NOFHJImtIqCzjZEN1nsJyLr
 EskWpu+lj5u6FxPY54k3KqOwlg==
X-Google-Smtp-Source: AGRyM1vTCFcIzhygOqc0dfz0XQz9dolsiNFu6n34Zw7Kl9e9LRh00tD6U1uaxZUOgaZBY5Ks0qTgkA==
X-Received: by 2002:a05:620a:1450:b0:6af:1999:5f4c with SMTP id
 i16-20020a05620a145000b006af19995f4cmr7538467qkl.301.1656376854703; 
 Mon, 27 Jun 2022 17:40:54 -0700 (PDT)
Received: from ziepe.ca
 (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net.
 [142.162.113.129]) by smtp.gmail.com with ESMTPSA id
 x11-20020a05620a448b00b006a768c699adsm10335849qkp.125.2022.06.27.17.40.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 27 Jun 2022 17:40:53 -0700 (PDT)
Received: from jgg by mlx with local (Exim 4.94) (envelope-from <jgg@ziepe.ca>)
 id 1o5zHg-002iu4-9Z; Mon, 27 Jun 2022 21:40:52 -0300
Date: Mon, 27 Jun 2022 21:40:52 -0300
From: Jason Gunthorpe <jgg@ziepe.ca>
To: Daniel Borkmann <daniel@iogearbox.net>
Subject: Re: [PATCH][next] treewide: uapi: Replace zero-length arrays with
 flexible-array members
Message-ID: <20220628004052.GM23621@ziepe.ca>
References: <20220627180432.GA136081@embeddedor>
 <6bc1e94c-ce1d-a074-7d0c-8dbe6ce22637@iogearbox.net>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <6bc1e94c-ce1d-a074-7d0c-8dbe6ce22637@iogearbox.net>
Cc: nvdimm@lists.linux.dev, alsa-devel@alsa-project.org, kvm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, "Gustavo A. R. Silva" <gustavoars@kernel.org>,
 dm-devel@redhat.com, target-devel@vger.kernel.org,
 linux-mtd@lists.infradead.org, linux-hardening@vger.kernel.org,
 linux1394-devel@lists.sourceforge.net,
 linux-stm32@st-md-mailman.stormreply.com, linux-s390@vger.kernel.org,
 linux-scsi@vger.kernel.org, linux-rdma@vger.kernel.org, x86@kernel.org,
 kasan-dev@googlegroups.com, lvs-devel@vger.kernel.org, coreteam@netfilter.org,
 v9fs-developer@lists.sourceforge.net, linux-mips@vger.kernel.org,
 Kees Cook <keescook@chromium.org>, intel-gfx@lists.freedesktop.org,
 linux-can@vger.kernel.org, linux-raid@vger.kernel.org,
 linux-m68k@lists.linux-m68k.org, virtualization@lists.linux-foundation.org,
 io-uring@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 netdev@vger.kernel.org, linux-usb@vger.kernel.org, linux-mmc@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-perf-users@vger.kernel.org,
 linux-sctp@vger.kernel.org, netfilter-devel@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, bpf@vger.kernel.org,
 linux-btrfs@vger.kernel.org
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

T24gTW9uLCBKdW4gMjcsIDIwMjIgYXQgMDg6Mjc6MzdQTSArMDIwMCwgRGFuaWVsIEJvcmttYW5u
IHdyb3RlOgo+IE9uIDYvMjcvMjIgODowNCBQTSwgR3VzdGF2byBBLiBSLiBTaWx2YSB3cm90ZToK
PiA+IFRoZXJlIGlzIGEgcmVndWxhciBuZWVkIGluIHRoZSBrZXJuZWwgdG8gcHJvdmlkZSBhIHdh
eSB0byBkZWNsYXJlCj4gPiBoYXZpbmcgYSBkeW5hbWljYWxseSBzaXplZCBzZXQgb2YgdHJhaWxp
bmcgZWxlbWVudHMgaW4gYSBzdHJ1Y3R1cmUuCj4gPiBLZXJuZWwgY29kZSBzaG91bGQgYWx3YXlz
IHVzZSDigJxmbGV4aWJsZSBhcnJheSBtZW1iZXJz4oCdWzFdIGZvciB0aGVzZQo+ID4gY2FzZXMu
IFRoZSBvbGRlciBzdHlsZSBvZiBvbmUtZWxlbWVudCBvciB6ZXJvLWxlbmd0aCBhcnJheXMgc2hv
dWxkCj4gPiBubyBsb25nZXIgYmUgdXNlZFsyXS4KPiA+IAo+ID4gVGhpcyBjb2RlIHdhcyB0cmFu
c2Zvcm1lZCB3aXRoIHRoZSBoZWxwIG9mIENvY2NpbmVsbGU6Cj4gPiAobGludXgtNS4xOS1yYzIk
IHNwYXRjaCAtLWpvYnMgJChnZXRjb25mIF9OUFJPQ0VTU09SU19PTkxOKSAtLXNwLWZpbGUgc2Ny
aXB0LmNvY2NpIC0taW5jbHVkZS1oZWFkZXJzIC0tZGlyIC4gPiBvdXRwdXQucGF0Y2gpCj4gPiAK
PiA+IEBACj4gPiBpZGVudGlmaWVyIFMsIG1lbWJlciwgYXJyYXk7Cj4gPiB0eXBlIFQxLCBUMjsK
PiA+IEBACj4gPiAKPiA+IHN0cnVjdCBTIHsKPiA+ICAgIC4uLgo+ID4gICAgVDEgbWVtYmVyOwo+
ID4gICAgVDIgYXJyYXlbCj4gPiAtIDAKPiA+ICAgIF07Cj4gPiB9Owo+ID4gCj4gPiAtZnN0cmlj
dC1mbGV4LWFycmF5cz0zIGlzIGNvbWluZyBhbmQgd2UgbmVlZCB0byBsYW5kIHRoZXNlIGNoYW5n
ZXMKPiA+IHRvIHByZXZlbnQgaXNzdWVzIGxpa2UgdGhlc2UgaW4gdGhlIHNob3J0IGZ1dHVyZToK
PiA+IAo+ID4gLi4vZnMvbWluaXgvZGlyLmM6MzM3OjM6IHdhcm5pbmc6ICdzdHJjcHknIHdpbGwg
YWx3YXlzIG92ZXJmbG93OyBkZXN0aW5hdGlvbiBidWZmZXIgaGFzIHNpemUgMCwKPiA+IGJ1dCB0
aGUgc291cmNlIHN0cmluZyBoYXMgbGVuZ3RoIDIgKGluY2x1ZGluZyBOVUwgYnl0ZSkgWy1XZm9y
dGlmeS1zb3VyY2VdCj4gPiAJCXN0cmNweShkZTMtPm5hbWUsICIuIik7Cj4gPiAJCV4KPiA+IAo+
ID4gU2luY2UgdGhlc2UgYXJlIGFsbCBbMF0gdG8gW10gY2hhbmdlcywgdGhlIHJpc2sgdG8gVUFQ
SSBpcyBuZWFybHkgemVyby4gSWYKPiA+IHRoaXMgYnJlYWtzIGFueXRoaW5nLCB3ZSBjYW4gdXNl
IGEgdW5pb24gd2l0aCBhIG5ldyBtZW1iZXIgbmFtZS4KPiA+IAo+ID4gWzFdIGh0dHBzOi8vZW4u
d2lraXBlZGlhLm9yZy93aWtpL0ZsZXhpYmxlX2FycmF5X21lbWJlcgo+ID4gWzJdIGh0dHBzOi8v
d3d3Lmtlcm5lbC5vcmcvZG9jL2h0bWwvdjUuMTYvcHJvY2Vzcy9kZXByZWNhdGVkLmh0bWwjemVy
by1sZW5ndGgtYW5kLW9uZS1lbGVtZW50LWFycmF5cwo+ID4gCj4gPiBMaW5rOiBodHRwczovL2dp
dGh1Yi5jb20vS1NQUC9saW51eC9pc3N1ZXMvNzgKPiA+IEJ1aWxkLXRlc3RlZC1ieTogaHR0cHM6
Ly9sb3JlLmtlcm5lbC5vcmcvbGttbC82MmI2NzVlYy53S1g2QU9aNmNiRTcxdnRGJTI1bGtwQGlu
dGVsLmNvbS8KPiA+IFNpZ25lZC1vZmYtYnk6IEd1c3Rhdm8gQS4gUi4gU2lsdmEgPGd1c3Rhdm9h
cnNAa2VybmVsLm9yZz4KPiA+IC0tLQo+ID4gSGkgYWxsIQo+ID4gCj4gPiBKRllJOiBJJ20gYWRk
aW5nIHRoaXMgdG8gbXkgLW5leHQgdHJlZS4gOikKPiAKPiBGeWksIHRoaXMgYnJlYWtzIEJQRiBD
SToKPiAKPiBodHRwczovL2dpdGh1Yi5jb20va2VybmVsLXBhdGNoZXMvYnBmL3J1bnMvNzA3ODcx
OTM3Mj9jaGVja19zdWl0ZV9mb2N1cz10cnVlCj4gCj4gICBbLi4uXQo+ICAgcHJvZ3MvbWFwX3B0
cl9rZXJuLmM6MzE0OjI2OiBlcnJvcjogZmllbGQgJ3RyaWVfa2V5JyB3aXRoIHZhcmlhYmxlIHNp
emVkIHR5cGUgJ3N0cnVjdCBicGZfbHBtX3RyaWVfa2V5JyBub3QgYXQgdGhlIGVuZCBvZiBhIHN0
cnVjdCBvciBjbGFzcyBpcyBhIEdOVSBleHRlbnNpb24gWy1XZXJyb3IsLVdnbnUtdmFyaWFibGUt
c2l6ZWQtdHlwZS1ub3QtYXQtZW5kXQo+ICAgICAgICAgICBzdHJ1Y3QgYnBmX2xwbV90cmllX2tl
eSB0cmllX2tleTsKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgXgoKVGhpcyB3
aWxsIGJyZWFrIHRoZSByZG1hLWNvcmUgdXNlcnNwYWNlIGFzIHdlbGwsIHdpdGggYSBzaW1pbGFy
CmVycm9yOgoKL3Vzci9iaW4vY2xhbmctMTMgLURWRVJCU19ERUJVRyAtRGlidmVyYnNfRVhQT1JU
UyAtSWluY2x1ZGUgLUkvdXNyL2luY2x1ZGUvbGlibmwzIC1JL3Vzci9pbmNsdWRlL2RybSAtZyAt
TzIgLWZkZWJ1Zy1wcmVmaXgtbWFwPS9fX3cvMS9zPS4gLWZzdGFjay1wcm90ZWN0b3Itc3Ryb25n
IC1XZm9ybWF0IC1XZXJyb3I9Zm9ybWF0LXNlY3VyaXR5IC1XZGF0ZS10aW1lIC1EX0ZPUlRJRllf
U09VUkNFPTIgLVdtaXNzaW5nLXByb3RvdHlwZXMgLVdtaXNzaW5nLWRlY2xhcmF0aW9ucyAtV3dy
aXRlLXN0cmluZ3MgLVdmb3JtYXQ9MiAtV2Nhc3QtZnVuY3Rpb24tdHlwZSAtV2Zvcm1hdC1ub25s
aXRlcmFsIC1XZGF0ZS10aW1lIC1XbmVzdGVkLWV4dGVybnMgLVdzaGFkb3cgLVdzdHJpY3QtcHJv
dG90eXBlcyAtV29sZC1zdHlsZS1kZWZpbml0aW9uIC1XZXJyb3IgLVdyZWR1bmRhbnQtZGVjbHMg
LWcgLWZQSUMgICAtc3RkPWdudTExIC1NRCAtTVQgbGliaWJ2ZXJicy9DTWFrZUZpbGVzL2lidmVy
YnMuZGlyL2NtZF9mbG93LmMubyAtTUYgbGliaWJ2ZXJicy9DTWFrZUZpbGVzL2lidmVyYnMuZGly
L2NtZF9mbG93LmMuby5kIC1vIGxpYmlidmVyYnMvQ01ha2VGaWxlcy9pYnZlcmJzLmRpci9jbWRf
Zmxvdy5jLm8gICAtYyAuLi9saWJpYnZlcmJzL2NtZF9mbG93LmMKSW4gZmlsZSBpbmNsdWRlZCBm
cm9tIC4uL2xpYmlidmVyYnMvY21kX2Zsb3cuYzozMzoKSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGlu
Y2x1ZGUvaW5maW5pYmFuZC9jbWRfd3JpdGUuaDozNjoKSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGlu
Y2x1ZGUvaW5maW5pYmFuZC9jbWRfaW9jdGwuaDo0MToKSW4gZmlsZSBpbmNsdWRlZCBmcm9tIGlu
Y2x1ZGUvaW5maW5pYmFuZC92ZXJicy5oOjQ4OgpJbiBmaWxlIGluY2x1ZGVkIGZyb20gaW5jbHVk
ZS9pbmZpbmliYW5kL3ZlcmJzX2FwaS5oOjY2OgpJbiBmaWxlIGluY2x1ZGVkIGZyb20gaW5jbHVk
ZS9pbmZpbmliYW5kL2liX3VzZXJfaW9jdGxfdmVyYnMuaDozODoKaW5jbHVkZS9yZG1hL2liX3Vz
ZXJfdmVyYnMuaDo0MzY6MzQ6IGVycm9yOiBmaWVsZCAnYmFzZScgd2l0aCB2YXJpYWJsZSBzaXpl
ZCB0eXBlICdzdHJ1Y3QgaWJfdXZlcmJzX2NyZWF0ZV9jcV9yZXNwJyBub3QgYXQgdGhlIGVuZCBv
ZiBhIHN0cnVjdCBvciBjbGFzcyBpcyBhIEdOVSBleHRlbnNpb24gWy1XZXJyb3IsLVdnbnUtdmFy
aWFibGUtc2l6ZWQtdHlwZS1ub3QtYXQtZW5kXQogICAgICAgIHN0cnVjdCBpYl91dmVyYnNfY3Jl
YXRlX2NxX3Jlc3AgYmFzZTsKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
IF4KaW5jbHVkZS9yZG1hL2liX3VzZXJfdmVyYnMuaDo2NDQ6MzQ6IGVycm9yOiBmaWVsZCAnYmFz
ZScgd2l0aCB2YXJpYWJsZSBzaXplZCB0eXBlICdzdHJ1Y3QgaWJfdXZlcmJzX2NyZWF0ZV9xcF9y
ZXNwJyBub3QgYXQgdGhlIGVuZCBvZiBhIHN0cnVjdCBvciBjbGFzcyBpcyBhIEdOVSBleHRlbnNp
b24gWy1XZXJyb3IsLVdnbnUtdmFyaWFibGUtc2l6ZWQtdHlwZS1ub3QtYXQtZW5kXQogICAgICAg
IHN0cnVjdCBpYl91dmVyYnNfY3JlYXRlX3FwX3Jlc3AgYmFzZTsKCldoaWNoIGlzIHdoeSBJIGdh
dmUgdXAgdHJ5aW5nIHRvIGNoYW5nZSB0aGVzZS4uCgpUaG91Z2ggbWF5YmUgd2UgY291bGQganVz
dCBzd2l0Y2ggb2ZmIC1XZ251LXZhcmlhYmxlLXNpemVkLXR5cGUtbm90LWF0LWVuZCAgZHVyaW5n
IGNvbmZpZ3VyYXRpb24gPwoKSmFzb24KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9u
QGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9u
Lm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
