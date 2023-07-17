Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6EEE6C001DE
	for <virtualization@archiver.kernel.org>; Mon, 17 Jul 2023 19:08:42 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id EAE29406E0;
	Mon, 17 Jul 2023 19:08:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org EAE29406E0
Authentication-Results: smtp4.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=GzDhDbaq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id O4j-fVkkE1PZ; Mon, 17 Jul 2023 19:08:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 0818D403F5;
	Mon, 17 Jul 2023 19:08:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 0818D403F5
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D7437C0072;
	Mon, 17 Jul 2023 19:08:39 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58776C0032
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jul 2023 19:08:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 3383B80B80
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jul 2023 19:08:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 3383B80B80
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=GzDhDbaq
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 4PQgOfk5zV5L
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jul 2023 19:08:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 233EC80B44
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 233EC80B44
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jul 2023 19:08:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689620916;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=qHz5V5lwxUlduWSVUZLKGbl1lWEkFIrU74CIU+5Jsd8=;
 b=GzDhDbaqmhUIrUx/hs9lggdhALbPT6ujFbRvFnYTPdFWYpprz1v1wZM80teH6EYOGN8s42
 A29slQUAhFX4M6A5BWJl7mV7YKvIV7CVTLx8kw5Hg2BBpj9eTD5bgyTIuatAl959AC1aoa
 UXN0vUn1CV5OvKptQ3AgecLmpYw2L7U=
Received: from mail-il1-f198.google.com (mail-il1-f198.google.com
 [209.85.166.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-581-R-_iUUiPMbO7tJBB5St3Lg-1; Mon, 17 Jul 2023 15:08:35 -0400
X-MC-Unique: R-_iUUiPMbO7tJBB5St3Lg-1
Received: by mail-il1-f198.google.com with SMTP id
 e9e14a558f8ab-34610c52cf8so30600795ab.0
 for <virtualization@lists.linux-foundation.org>;
 Mon, 17 Jul 2023 12:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20221208; t=1689620914; x=1692212914;
 h=content-transfer-encoding:mime-version:organization:references
 :in-reply-to:message-id:subject:cc:to:from:date:x-gm-message-state
 :from:to:cc:subject:date:message-id:reply-to;
 bh=Ir1J/k3wLKNYp7LI2ijvFBF6ZKrDfOA6Drq2a2Jon50=;
 b=Ik7mY9xkjFUIMgv2hAfnsRs76ycdx3wQcQKgE4DBMqqxRx2m7XXqu+ta8jVXrTLOP1
 j0SexnTh7NuUufb7tflascRnNASevuIo3T+xmWSEyMReog7GDpa/NzKgOxm0D9Fxfi/6
 VpEHePK6othj7K7XHuAosFd5Eg/OWtHe73u3X1bzW9gJb1zDcvI1NlGgRWwP6TtxvgSy
 2SNzyyJD5ACHWa5Mc2q5hIH3aMg3uMZGK2p/C42SjoOrgrPYY4LvnGiHXhwWcfLVcq5i
 ++RtlWSBImaAsOGoiv9eASGSoKACse2sDtpzvhMZSZJbJLMX30Znbxefa/A4H0n3q2y5
 F6Yg==
X-Gm-Message-State: ABy/qLbfVc5JYIgvv6gzGLdlFNYquzp0K8R4SJQBXt3x7va82rt5uLn7
 BIRSf6OSFET9R+RkKThRrDUHS/mDo8ftw+oHhvsnR+uz7D51KF+rFF8AKPHvAi1dY7xwoBO3JVf
 VoxwbsM5EZwpzY0rW4ePCbEgIFIy2+BWQK99ZbXAT3A==
X-Received: by 2002:a05:6e02:1a8b:b0:348:8542:a673 with SMTP id
 k11-20020a056e021a8b00b003488542a673mr578113ilv.22.1689620914158; 
 Mon, 17 Jul 2023 12:08:34 -0700 (PDT)
X-Google-Smtp-Source: APBJJlH8IAKDk/Qq0r0DbEq84CfbH5y70uroq/83Nyu0gFtjM6u4GlatJgupAE/Bg/5ujaAlXs4PMg==
X-Received: by 2002:a05:6e02:1a8b:b0:348:8542:a673 with SMTP id
 k11-20020a056e021a8b00b003488542a673mr578040ilv.22.1689620913830; 
 Mon, 17 Jul 2023 12:08:33 -0700 (PDT)
Received: from redhat.com ([38.15.36.239]) by smtp.gmail.com with ESMTPSA id
 o9-20020a92dac9000000b003460b456030sm129837ilq.60.2023.07.17.12.08.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 17 Jul 2023 12:08:33 -0700 (PDT)
Date: Mon, 17 Jul 2023 13:08:31 -0600
From: Alex Williamson <alex.williamson@redhat.com>
To: Grzegorz Jaszczyk <jaz@semihalf.com>
Subject: Re: [PATCH 0/2] eventfd: simplify signal helpers
Message-ID: <20230717130831.0f18381a.alex.williamson@redhat.com>
In-Reply-To: <CAH76GKPF4BjJLrzLBW8k12ATaAGADeMYc2NQ9+j0KgRa0pomUw@mail.gmail.com>
References: <20230630155936.3015595-1-jaz@semihalf.com>
 <20230714-gauner-unsolidarisch-fc51f96c61e8@brauner>
 <CAH76GKPF4BjJLrzLBW8k12ATaAGADeMYc2NQ9+j0KgRa0pomUw@mail.gmail.com>
Organization: Red Hat
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: linux-aio@kvack.org, Muchun Song <muchun.song@linux.dev>,
 Tony Krowiak <akrowiak@linux.ibm.com>, Matthew Rosato <mjrosato@linux.ibm.com>,
 Paul Durrant <paul@xen.org>, Tom Rix <trix@redhat.com>,
 Roman Gushchin <roman.gushchin@linux.dev>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 dri-devel@lists.freedesktop.org, Michal Hocko <mhocko@kernel.org>,
 Heiko Carstens <hca@linux.ibm.com>, linux-mm@kvack.org,
 Kirti Wankhede <kwankhede@nvidia.com>, Vineeth Vijayan <vneethv@linux.ibm.com>,
 Diana Craciun <diana.craciun@oss.nxp.com>, Borislav Petkov <bp@alien8.de>,
 Alexander Gordeev <agordeev@linux.ibm.com>, Fei Li <fei1.li@intel.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Marcin Wojtas <mw@semihalf.com>,
 Arnd Bergmann <arnd@arndb.de>, Leon Romanovsky <leon@kernel.org>,
 linux-rdma@vger.kernel.org, x86@kernel.org, Halil Pasic <pasic@linux.ibm.com>,
 Jason Gunthorpe <jgg@ziepe.ca>, Ingo Molnar <mingo@redhat.com>,
 Moritz Fischer <mdf@kernel.org>, Frederic Barrat <fbarrat@linux.ibm.com>,
 Xu Yilun <yilun.xu@intel.com>, linux-fpga@vger.kernel.org,
 Zhi Wang <zhi.a.wang@intel.com>, Wu Hao <hao.wu@intel.com>,
 Jason Herne <jjherne@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 Andrew Donnellan <ajd@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
 linux-s390@vger.kernel.org, Dominik Behr <dbehr@chromium.org>,
 intel-gfx@lists.freedesktop.org, Sean Christopherson <seanjc@google.com>,
 Eric Auger <eric.auger@redhat.com>, Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Harald Freudenberger <freude@linux.ibm.com>, kvm@vger.kernel.org,
 Paolo Bonzini <pbonzini@redhat.com>, cgroups@vger.kernel.org,
 Thomas Gleixner <tglx@linutronix.de>,
 virtualization@lists.linux-foundation.org, intel-gvt-dev@lists.freedesktop.org,
 io-uring@vger.kernel.org, Jens Axboe <axboe@kernel.dk>,
 Tvrtko Ursulin <tvrtko.ursulin@linux.intel.com>,
 Christian Brauner <brauner@kernel.org>, netdev@vger.kernel.org,
 Oded Gabbay <ogabbay@kernel.org>, linux-usb@vger.kernel.org,
 Peter Oberparleiter <oberpar@linux.ibm.com>, linux-kernel@vger.kernel.org,
 Benjamin LaHaise <bcrl@kvack.org>, "Michael S.
 Tsirkin" <mst@redhat.com>, Sven Schnelle <svens@linux.ibm.com>,
 Johannes Weiner <hannes@cmpxchg.org>, linux-fsdevel@vger.kernel.org,
 Shakeel Butt <shakeelb@google.com>, David Woodhouse <dwmw2@infradead.org>,
 linuxppc-dev@lists.ozlabs.org, Pavel Begunkov <asml.silence@gmail.com>
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

T24gTW9uLCAxNyBKdWwgMjAyMyAxMDoyOTozNCArMDIwMApHcnplZ29yeiBKYXN6Y3p5ayA8amF6
QHNlbWloYWxmLmNvbT4gd3JvdGU6Cgo+IHB0LiwgMTQgbGlwIDIwMjMgbyAwOTowNSBDaHJpc3Rp
YW4gQnJhdW5lciA8YnJhdW5lckBrZXJuZWwub3JnPiBuYXBpc2HFgihhKToKPiA+Cj4gPiBPbiBU
aHUsIEp1bCAxMywgMjAyMyBhdCAxMToxMDo1NEFNIC0wNjAwLCBBbGV4IFdpbGxpYW1zb24gd3Jv
dGU6ICAKPiA+ID4gT24gVGh1LCAxMyBKdWwgMjAyMyAxMjowNTozNiArMDIwMAo+ID4gPiBDaHJp
c3RpYW4gQnJhdW5lciA8YnJhdW5lckBrZXJuZWwub3JnPiB3cm90ZToKPiA+ID4gIAo+ID4gPiA+
IEhleSBldmVyeW9uZSwKPiA+ID4gPgo+ID4gPiA+IFRoaXMgc2ltcGxpZmllcyB0aGUgZXZlbnRm
ZF9zaWduYWwoKSBhbmQgZXZlbnRmZF9zaWduYWxfbWFzaygpIGhlbHBlcnMKPiA+ID4gPiBieSBy
ZW1vdmluZyB0aGUgY291bnQgYXJndW1lbnQgd2hpY2ggaXMgZWZmZWN0aXZlbHkgdW51c2VkLiAg
Cj4gPiA+Cj4gPiA+IFdlIGhhdmUgYSBwYXRjaCB1bmRlciByZXZpZXcgd2hpY2ggZG9lcyBpbiBm
YWN0IG1ha2UgdXNlIG9mIHRoZQo+ID4gPiBzaWduYWxpbmcgdmFsdWU6Cj4gPiA+Cj4gPiA+IGh0
dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDIzMDYzMDE1NTkzNi4zMDE1NTk1LTEtamF6QHNl
bWloYWxmLmNvbS8gIAo+ID4KPiA+IEh1aCwgdGhhbmtzIGZvciB0aGUgbGluay4KPiA+Cj4gPiBR
dW90aW5nIGZyb20KPiA+IGh0dHBzOi8vcGF0Y2h3b3JrLmtlcm5lbC5vcmcvcHJvamVjdC9rdm0v
cGF0Y2gvMjAyMzAzMDcyMjA1NTMuNjMxMDY5LTEtamF6QHNlbWloYWxmLmNvbS8jMjUyNjY4NTYK
PiA+ICAKPiA+ID4gUmVhZGluZyBhbiBldmVudGZkIHJldHVybnMgYW4gOC1ieXRlIHZhbHVlLCB3
ZSBnZW5lcmFsbHkgb25seSB1c2UgaXQKPiA+ID4gYXMgYSBjb3VudGVyLCBidXQgaXQncyBiZWVu
IGRpc2N1c3NlZCBwcmV2aW91c2x5IGFuZCBJSVJDLCBpdCdzIHBvc3NpYmxlCj4gPiA+IHRvIHVz
ZSB0aGF0IHZhbHVlIGFzIGEgbm90aWZpY2F0aW9uIHZhbHVlLiAgCj4gPgo+ID4gU28gdGhlIGdv
YWwgaXMgdG8gcGlwZSBhIHNwZWNpZmljIHZhbHVlIHRocm91Z2ggZXZlbnRmZD8gQnV0IGl0IGlz
Cj4gPiBleHBsaWNpdGx5IGEgY291bnRlci4gVGhlIHdob2xlIHRoaW5nIGlzIHdyaXR0ZW4gYXJv
dW5kIGEgY291bnRlciBhbmQKPiA+IGVhY2ggd3JpdGUgYW5kIHNpZ25hbCBhZGRzIHRvIHRoZSBj
b3VudGVyLgo+ID4KPiA+IFRoZSBjb25zZXF1ZW5jZXMgYXJlIHByZXR0eSB3ZWxsIGRlc2NyaWJl
ZCBpbiB0aGUgY292ZXIgbGV0dGVyIG9mCj4gPiB2NiBodHRwczovL2xvcmUua2VybmVsLm9yZy9h
bGwvMjAyMzA2MzAxNTU5MzYuMzAxNTU5NS0xLWphekBzZW1paGFsZi5jb20vCj4gPiAgCj4gPiA+
IFNpbmNlIHRoZSBldmVudGZkIGNvdW50ZXIgaXMgdXNlZCBhcyBBQ1BJIG5vdGlmaWNhdGlvbiB2
YWx1ZQo+ID4gPiBwbGFjZWhvbGRlciwgdGhlIGV2ZW50ZmQgc2lnbmFsaW5nIG5lZWRzIHRvIGJl
IHNlcmlhbGl6ZWQgaW4gb3JkZXIgdG8KPiA+ID4gbm90IGVuZCB1cCB3aXRoIG5vdGlmaWNhdGlv
biB2YWx1ZXMgYmVpbmcgY29hbGVzY2VkLiBUaGVyZWZvcmUgQUNQSQo+ID4gPiBub3RpZmljYXRp
b24gdmFsdWVzIGFyZSBidWZmZXJlZCBhbmQgc2lnbmFsaXplZCBvbmUgYnkgb25lLCB3aGVuIHRo
ZQo+ID4gPiBwcmV2aW91cyBub3RpZmljYXRpb24gdmFsdWUgaGFzIGJlZW4gY29uc3VtZWQuICAK
PiA+Cj4gPiBCdXQgaXNuJ3QgdGhpcyBhIGdvb2QgaW5kaWNhdGlvbiB0aGF0IHlvdSByZWFsbHkg
ZG9uJ3Qgd2FudCBhbiBldmVudGZkCj4gPiBidXQgc29tZXRoaW5nIHRoYXQncyBleHBsaWNpdGx5
IGRlc2lnbmVkIHRvIGFzc29jaWF0ZSBzcGVjaWZpYyBkYXRhIHdpdGgKPiA+IGEgbm90aWZpY2F0
aW9uPyBVc2luZyBldmVudGZkIGluIHRoYXQgbWFubmVyIHJlcXVpcmVzIHNlcmlhbGl6YXRpb24s
Cj4gPiBidWZmZXJpbmcsIGFuZCBlbmZvcmNlcyBvcmRlcmluZy4KCldoYXQgd291bGQgdGhhdCBt
ZWNoYW5pc20gYmU/ICBXZSd2ZSBiZWVuIGl0ZXJhdGluZyBvbiBnZXR0aW5nIHRoZQpzZXJpYWxp
emF0aW9uIGFuZCBidWZmZXJpbmcgY29ycmVjdCwgYnV0IEkgZG9uJ3Qga25vdyBvZiBhbm90aGVy
IG1lYW5zCnRoYXQgY29tYmluZXMgdGhlIG5vdGlmaWNhdGlvbiB3aXRoIGEgdmFsdWUsIHNvIHdl
J2QgbGlrZWx5IGVuZCB1cCB3aXRoCmFuIGV2ZW50ZmQgb25seSBmb3Igbm90aWZpY2F0aW9uIGFu
ZCBhIHNlcGFyYXRlIHJpbmcgYnVmZmVyIGZvcgpub3RpZmljYXRpb24gdmFsdWVzLgoKQXMgdGhp
cyBzZXJpZXMgZGVtb25zdHJhdGVzLCB0aGUgY3VycmVudCBpbi1rZXJuZWwgdXNlcnMgb25seSBp
bmNyZW1lbnQKdGhlIGNvdW50ZXIgYW5kIG1vc3QgdXNlcnNwYWNlIGxpa2VseSBkaXNjYXJkcyB0
aGUgY291bnRlciB2YWx1ZSwgd2hpY2gKbWFrZXMgdGhlIGNvdW50ZXIgbGFyZ2VseSBhIHdhc3Rl
LiAgV2hpbGUgcGVyaGFwcyB1bmNvbnZlbnRpb25hbCwKdGhlcmUncyBubyByZXF1aXJlbWVudCB0
aGF0IHRoZSBjb3VudGVyIG1heSBvbmx5IGJlIGluY3JlbWVudGVkIGJ5IG9uZSwKbm9yIGFueSBy
ZXN0cmljdGlvbiB0aGF0IEkgc2VlIGluIGhvdyB1c2Vyc3BhY2UgbXVzdCBpbnRlcnByZXQgdGhl
CmNvdW50ZXIgdmFsdWUuCgpBcyBJIHVuZGVyc3RhbmQgdGhlIEFDUEkgbm90aWZpY2F0aW9uIHBy
b3Bvc2FsIHRoYXQgR3J6ZWdvcnogbGlua3MKYmVsb3csIGEgbm90aWZpY2F0aW9uIHdpdGggYW4g
aW50ZXJwcmV0ZWQgdmFsdWUgYWxsb3dzIGZvciBhIG1vcmUKZGlyZWN0IHVzZXJzcGFjZSBpbXBs
ZW1lbnRhdGlvbiB3aGVuIGRlYWxpbmcgd2l0aCBhIHNlcmllcyBvZiBkaXNjcmV0ZQpub3RpZmlj
YXRpb24gd2l0aCB2YWx1ZSBldmVudHMuICBUaGFua3MsCgpBbGV4Cgo+ID4gSSBoYXZlIG5vIHNr
aW4gaW4gdGhlIGdhbWUgYXNpZGUgZnJvbSBoYXZpbmcgdG8gZHJvcCB0aGlzIGNvbnZlcnNpb24K
PiA+IHdoaWNoIEknbSBmaW5lIHRvIGRvIGlmIHRoZXJlIGFyZSBhY3R1YWxseSB1c2VycyBmb3Ig
dGhpcyBidHUgcmVhbGx5LAo+ID4gdGhhdCBsb29rcyBhIGxvdCBsaWtlIGFidXNpbmcgYW4gYXBp
IHRoYXQgcmVhbGx5IHdhc24ndCBkZXNpZ25lZCBmb3IKPiA+IHRoaXMuICAKPiAKPiBodHRwczov
L3BhdGNod29yay5rZXJuZWwub3JnL3Byb2plY3Qva3ZtL3BhdGNoLzIwMjMwMzA3MjIwNTUzLjYz
MTA2OS0xLWphekBzZW1paGFsZi5jb20vCj4gd2FzIHBvc3RlZCBhdCB0aGUgYmVnaW5pZyBvZiBN
YXJjaCBhbmQgb25lIG9mIHRoZSBtYWluIHRoaW5ncyB3ZSd2ZQo+IGRpc2N1c3NlZCB3YXMgdGhl
IG1lY2hhbmlzbSBmb3IgcHJvcGFnYXRpbmcgYWNwaSBub3RpZmljYXRpb24gdmFsdWUuCj4gV2Un
dmUgZW5kdXAgd2l0aCBldmVudGZkIGFzIHRoZSBiZXN0IG1lY2hhbmlzbSBhbmQgaGF2ZSBhY3R1
YWxseSBiZWVuCj4gdXNpbmcgaXQgZnJvbSB2Mi4gSSByZWFsbHkgZG8gbm90IHdhbnQgdG8gd2Fz
dGUgdGhpcyBlZmZvcnQsIEkgdGhpbmsKPiB3ZSBhcmUgcXVpdGUgYWR2YW5jZWQgd2l0aCB2NiBu
b3cuIEFkZGl0aW9uYWxseSB3ZSBkaWRuJ3QgYWN0dWFsbHkKPiBtb2RpZnkgYW55IHBhcnQgb2Yg
ZXZlbnRmZCBzdXBwb3J0IHRoYXQgd2FzIGluIHBsYWNlLCB3ZSBvbmx5IHVzZWQgaXQKPiBpbiBh
IHNwZWNpZmljIChhbmQgZGlzY3Vzc2VkIGJlZm9yZWhhbmQpIHdheS4KCl9fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcg
bGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xp
c3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
