Return-Path: <SRS0=5J/L=HZ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.5 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52926C433DB
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 14:23:23 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CDCB764E5C
	for <virtualization@archiver.kernel.org>; Tue, 23 Feb 2021 14:23:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CDCB764E5C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 8B0998720B;
	Tue, 23 Feb 2021 14:23:22 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Y2TJkR8Xaga3; Tue, 23 Feb 2021 14:23:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id DF8B78720E;
	Tue, 23 Feb 2021 14:23:21 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id CAF03C000B;
	Tue, 23 Feb 2021 14:23:21 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 27B22C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 14:23:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id 2390887237
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 14:23:20 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id r-HElJvYfx2k
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 14:23:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 6851E8720B
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 14:23:18 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id w1so34682460ejf.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 06:23:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=H8vtkyNEqRRd14jBt5G4psDBq4qKhtCm/tBgnQUuw9g=;
 b=oAm+pHr8pWu0D3JchPjOuzr7uAQ2Bmv+Ra/5Lxx7zHox9Rs9tfInDEkRM6xpTWz+KZ
 yJ/SRL0VKYvCSK2Ng9TAP8PJSiIdrGP0aAZ5YAYA0hproABdyl1MYeD29VFK9syRJ+hI
 hHG/vTLhT5wM/7Dhfq14Ck2y+QlKAquiKnVcPKLkodBi7JCCTZrFhVn/PCh0Cl0SSAid
 0iWe4pTQnVz0poMJGHeVAwOFJQnE98JepJgJlIdDw/4yZI3uG99RHmbHJEbmZzCb5W7I
 AD3gmHHbBDG8vQiMoKCs5+Zy8dOV7AvCI3kolnTbnidkR8CatWvsBzJAc+ai8daJdAGS
 X9XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=H8vtkyNEqRRd14jBt5G4psDBq4qKhtCm/tBgnQUuw9g=;
 b=b4FbLPuImy+p6vTOYHI+Q2BzxMQbNpA2k8NLoWXzR/ELukIVVqDFURbvJ78oWiiW6/
 alH9hB8+SwtsIMTXkfd473LH7hLgoK5qH2agaFtTUM1oJlEqIP5dmJtoK5iOpzFs9sJs
 gtmvsuo056IB/UNt3qX2GCHL42Pdv97W+iF9qkBypdFpxW2HMpwDE4ZJokoMRAKW2pQB
 teG+fnD5TDQoy1d7RAlaEHVIETsKpbGfO7wyAnURhvngB+k9GrGl9W2lPCBj81r3z2Rj
 JOviHkZw44V1CN/QyU94wS68Ex689CfzvJnbHiAXtNagSd6l7LmjJh6NvXPS9GrjmKp3
 SU1w==
X-Gm-Message-State: AOAM533kZW76PpkKWNaIHEffEBLGP3Scvq/WU5kdqASterZDfu9a0UJx
 dIhxUwwpRXj9tsOTAQxcwAIcNiah8so=
X-Google-Smtp-Source: ABdhPJwo9IvTPwPeiCrxiRy9c99xQqfq1j2UJxDF8fnTCLAo0G8/5j9szBh7NFcYoqWNsxAlyCfAWw==
X-Received: by 2002:a17:906:f119:: with SMTP id
 gv25mr11382558ejb.293.1614090196557; 
 Tue, 23 Feb 2021 06:23:16 -0800 (PST)
Received: from mail-wm1-f41.google.com (mail-wm1-f41.google.com.
 [209.85.128.41])
 by smtp.gmail.com with ESMTPSA id e19sm14174615eds.10.2021.02.23.06.23.14
 for <virtualization@lists.linux-foundation.org>
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 23 Feb 2021 06:23:14 -0800 (PST)
Received: by mail-wm1-f41.google.com with SMTP id a132so2599125wmc.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 23 Feb 2021 06:23:14 -0800 (PST)
X-Received: by 2002:a05:600c:2291:: with SMTP id
 17mr17708818wmf.169.1614090193610; 
 Tue, 23 Feb 2021 06:23:13 -0800 (PST)
MIME-Version: 1.0
References: <5e910d11a14da17c41317417fc41d3a9d472c6e7.1613659844.git.bnemeth@redhat.com>
 <CA+FuTSe7srSBnAmFNFBFkDrLmPL5XtxhbXEs1mBytUBuuym2fg@mail.gmail.com>
 <2cc06597-8005-7be8-4094-b20f525afde8@redhat.com>
 <CA+FuTSf2GCi+RzpkFeBgtSOyhjsBFfApjekzupHLfyeYDn-JYQ@mail.gmail.com>
 <8168e98e-d608-750a-9b49-b1e60a23714c@redhat.com>
 <1bcc8d88b4cb7ad5610a045fc013127d3055b0d8.camel@redhat.com>
In-Reply-To: <1bcc8d88b4cb7ad5610a045fc013127d3055b0d8.camel@redhat.com>
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Date: Tue, 23 Feb 2021 09:22:36 -0500
X-Gmail-Original-Message-ID: <CA+FuTSdftho0g7ZmUwf=xH5UY6qYyPrNaV7LGmBTuwt=kZfGug@mail.gmail.com>
Message-ID: <CA+FuTSdftho0g7ZmUwf=xH5UY6qYyPrNaV7LGmBTuwt=kZfGug@mail.gmail.com>
Subject: Re: [PATCH] net: check if protocol extracted by
 virtio_net_hdr_set_proto is correct
To: Balazs Nemeth <bnemeth@redhat.com>
Cc: Willem de Bruijn <willemdebruijn.kernel@gmail.com>,
 "Michael S. Tsirkin" <mst@redhat.com>,
 Network Development <netdev@vger.kernel.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 virtualization@lists.linux-foundation.org, David Miller <davem@davemloft.net>
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

T24gVHVlLCBGZWIgMjMsIDIwMjEgYXQgODo0OCBBTSBCYWxhenMgTmVtZXRoIDxibmVtZXRoQHJl
ZGhhdC5jb20+IHdyb3RlOgo+Cj4gT24gTW9uLCAyMDIxLTAyLTIyIGF0IDExOjM5ICswODAwLCBK
YXNvbiBXYW5nIHdyb3RlOgo+ID4KPiA+IE9uIDIwMjEvMi8xOSAxMDo1NSDkuIvljYgsIFdpbGxl
bSBkZSBCcnVpam4gd3JvdGU6Cj4gPiA+IE9uIEZyaSwgRmViIDE5LCAyMDIxIGF0IDM6NTMgQU0g
SmFzb24gV2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiA+ID4gd3JvdGU6Cj4gPiA+ID4KPiA+
ID4gPiBPbiAyMDIxLzIvMTggMTE6NTAg5LiL5Y2ILCBXaWxsZW0gZGUgQnJ1aWpuIHdyb3RlOgo+
ID4gPiA+ID4gT24gVGh1LCBGZWIgMTgsIDIwMjEgYXQgMTA6MDEgQU0gQmFsYXpzIE5lbWV0aCA8
Cj4gPiA+ID4gPiBibmVtZXRoQHJlZGhhdC5jb20+IHdyb3RlOgo+ID4gPiA+ID4gPiBGb3IgZ3Nv
IHBhY2tldHMsIHZpcnRpb19uZXRfaGRyX3NldF9wcm90byBzZXRzIHRoZSBwcm90b2NvbAo+ID4g
PiA+ID4gPiAoaWYgaXQgaXNuJ3QKPiA+ID4gPiA+ID4gc2V0KSBiYXNlZCBvbiB0aGUgdHlwZSBp
biB0aGUgdmlydGlvIG5ldCBoZHIsIGJ1dCB0aGUgc2tiCj4gPiA+ID4gPiA+IGNvdWxkIGNvbnRh
aW4KPiA+ID4gPiA+ID4gYW55dGhpbmcgc2luY2UgaXQgY291bGQgY29tZSBmcm9tIHBhY2tldF9z
bmQgdGhyb3VnaCBhIHJhdwo+ID4gPiA+ID4gPiBzb2NrZXQuIElmCj4gPiA+ID4gPiA+IHRoZXJl
IGlzIGEgbWlzbWF0Y2ggYmV0d2VlbiB3aGF0IHZpcnRpb19uZXRfaGRyX3NldF9wcm90bwo+ID4g
PiA+ID4gPiBzZXRzIGFuZAo+ID4gPiA+ID4gPiB0aGUgYWN0dWFsIHByb3RvY29sLCB0aGVuIHRo
ZSBza2IgY291bGQgYmUgaGFuZGxlZAo+ID4gPiA+ID4gPiBpbmNvcnJlY3RseSBsYXRlcgo+ID4g
PiA+ID4gPiBvbiBieSBnc28uCj4gPiA+ID4gPiA+Cj4gPiA+ID4gPiA+IFRoZSBuZXR3b3JrIGhl
YWRlciBvZiBnc28gcGFja2V0cyBzdGFydHMgYXQgMTQgYnl0ZXMsIGJ1dCBhCj4gPiA+ID4gPiA+
IHNwZWNpYWxseQo+ID4gPiA+ID4gPiBjcmFmdGVkIHBhY2tldCBjb3VsZCBmb29sIHRoZSBjYWxs
IHRvCj4gPiA+ID4gPiA+IHNrYl9mbG93X2Rpc3NlY3RfZmxvd19rZXlzX2Jhc2ljCj4gPiA+ID4g
PiA+IGFzIHRoZSBuZXR3b3JrIGhlYWRlciBvZmZzZXQgaW4gdGhlIHNrYiBjb3VsZCBiZSBpbmNv
cnJlY3QuCj4gPiA+ID4gPiA+IENvbnNlcXVlbnRseSwgRUlOVkFMIGlzIG5vdCByZXR1cm5lZC4K
PiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gVGhlcmUgYXJlIGV2ZW4gcGFja2V0cyB0aGF0IGNhbiBj
YXVzZSBhbiBpbmZpbml0ZSBsb29wLiBGb3IKPiA+ID4gPiA+ID4gZXhhbXBsZSwgYQo+ID4gPiA+
ID4gPiBwYWNrZXQgd2l0aCBldGhlcm5ldCB0eXBlIEVUSF9QX01QTFNfVUMgKHdoaWNoIGlzIHVu
bm90aWNlZAo+ID4gPiA+ID4gPiBieQo+ID4gPiA+ID4gPiB2aXJ0aW9fbmV0X2hkcl90b19za2Ip
IHRoYXQgaXMgc2VudCB0byBhIGdlbmV2ZSBpbnRlcmZhY2UKPiA+ID4gPiA+ID4gd2lsbCBiZQo+
ID4gPiA+ID4gPiBoYW5kbGVkIGJ5IGdlbmV2ZV9idWlsZF9za2IuIEluIHR1cm4sIGl0IGNhbGxz
Cj4gPiA+ID4gPiA+IHVkcF90dW5uZWxfaGFuZGxlX29mZmxvYWRzIHdoaWNoIHRoZW4gY2FsbHMK
PiA+ID4gPiA+ID4gc2tiX3Jlc2V0X2lubmVyX2hlYWRlcnMuCj4gPiA+ID4gPiA+IEFmdGVyIHRo
YXQsIHRoZSBwYWNrZXQgZ2V0cyBwYXNzZWQgdG8gbXBsc19nc29fc2VnbWVudC4gVGhhdAo+ID4g
PiA+ID4gPiBmdW5jdGlvbgo+ID4gPiA+ID4gPiBjYWxjdWxhdGVzIHRoZSBtcGxzIGhlYWRlciBs
ZW5ndGggYnkgdGFraW5nIHRoZSBkaWZmZXJlbmNlCj4gPiA+ID4gPiA+IGJldHdlZW4KPiA+ID4g
PiA+ID4gbmV0d29ya19oZWFkZXIgYW5kIGlubmVyX25ldHdvcmtfaGVhZGVyLiBTaW5jZSB0aGUg
dHdvIGFyZQo+ID4gPiA+ID4gPiBlcXVhbAo+ID4gPiA+ID4gPiAoZHVlIHRvIHRoZSBlYXJsaWVy
IGNhbGwgdG8gc2tiX3Jlc2V0X2lubmVyX2hlYWRlcnMpLCBpdCB3aWxsCj4gPiA+ID4gPiA+IGNh
bGN1bGF0ZQo+ID4gPiA+ID4gPiBhIGhlYWRlciBvZiBsZW5ndGggMCwgYW5kIGl0IHdpbGwgbm90
IHB1bGwgYW55IGhlYWRlcnMuIFRoZW4sCj4gPiA+ID4gPiA+IGl0IHdpbGwKPiA+ID4gPiA+ID4g
Y2FsbCBza2JfbWFjX2dzb19zZWdtZW50IHdoaWNoIHdpbGwgYWdhaW4gY2FsbAo+ID4gPiA+ID4g
PiBtcGxzX2dzb19zZWdtZW50LCBldGMuLi4KPiA+ID4gPiA+ID4gVGhpcyBsZWFkcyB0byB0aGUg
aW5maW5pdGUgbG9vcC4KPiA+ID4gPgo+ID4gPiA+IEkgcmVtZW1iZXIga2VybmVsIHdpbGwgdmFs
aWRhdGUgZG9kZ3kgZ3NvIHBhY2tldHMgaW4gZ3NvIG9wcy4gSQo+ID4gPiA+IHdvbmRlcgo+ID4g
PiA+IHdoeSBub3QgZG8gdGhlIGNoZWNrIHRoZXJlPyBUaGUgcmVhc29uIGlzIHRoYXQgdmlydGlv
L1RVTiBpcyBub3QKPiA+ID4gPiB0aGUKPiA+ID4gPiBvbmx5IHNvdXJjZSBmb3IgdGhvc2UgcGFj
a2V0cy4KPiA+ID4gSXQgaXM/IEFsbCBvdGhlciBHU08gcGFja2V0cyBhcmUgZ2VuZXJhdGVkIGJ5
IHRoZSBzdGFjayBpdHNlbGYsCj4gPiA+IGVpdGhlcgo+ID4gPiBsb2NhbGx5IG9yIHRocm91Z2gg
R1JPLgo+ID4KPiA+Cj4gPiBTb21ldGhpbmcgbGlrZSB3aGF0IGhhcyBiZWVuIGRvbmUgaW4gdGNw
X3Rzb19zZWdtZW50KCk/Cj4gPgo+ID4gICAgICBpZiAoc2tiX2dzb19vayhza2IsIGZlYXR1cmVz
IHwgTkVUSUZfRl9HU09fUk9CVVNUKSkgewo+ID4gICAgICAgICAgICAgICAgICAvKiBQYWNrZXQg
aXMgZnJvbSBhbiB1bnRydXN0ZWQgc291cmNlLCByZXNldAo+ID4gZ3NvX3NlZ3MuICovCj4gPgo+
ID4gICAgICAgICAgc2tiX3NoaW5mbyhza2IpLT5nc29fc2VncyA9IERJVl9ST1VORF9VUChza2It
PmxlbiwgbXNzKTsKPiA+Cj4gPiAgICAgICAgICBzZWdzID0gTlVMTDsKPiA+ICAgICAgICAgICAg
ICAgICAgZ290byBvdXQ7Cj4gPiAgICAgICAgICB9Cj4gPgo+ID4gTXkgdW5kZXJzdGFuZGluZyBv
ZiB0aGUgaGVhZGVyIGNoZWNrIGxvZ2ljIGlzIHRoYXQgaXQgdHJpZXMgdG8gZGVhbHkKPiA+IHRo
ZQo+ID4gY2hlY2sgYXMgbXVjaCBhcyBwb3NzaWJsZSwgc28gZm9yIGRldmljZSB0aGF0IGhhcyBH
Uk9fUk9CVVNULCB0aGVyZSdzCj4gPiBldmVuIG5vIG5lZWQgdG8gZG8gdGhhdC4KPiA+Cj4gPgo+
ID4gPgo+ID4gPiBCdXQgaW5kZWVkIHNvbWUgY2hlY2tzIGFyZSBiZXR0ZXIgcGVyZm9ybWVkIGlu
IHRoZSBHU08gbGF5ZXIuIFN1Y2gKPiA+ID4gYXMKPiA+ID4gbGlrZWx5IHRoZSAwLWJ5dGUgbXBs
cyBoZWFkZXIgbGVuZ3RoLgo+ID4gPgo+ID4gPiBJZiB3ZSBjYW5ub3QgdHJ1c3QgdmlydGlvX25l
dF9oZHIuZ3NvX3R5cGUgcGFzc2VkIGZyb20gdXNlcnNwYWNlLAo+ID4gPiB0aGVuCj4gPiA+IHdl
IGNhbiBhbHNvIG5vdCB0cnVzdCB0aGUgZXRoLmhfcHJvdG8gY29taW5nIGZyb20gdGhlIHNhbWUg
c291cmNlLgo+ID4KPiA+Cj4gPiBJIGFncmVlLgo+ID4KPiBJJ2xsIGFkZCBhIGNoZWNrIGluIHRo
ZSBHU08gbGF5ZXIgYXMgd2VsbC4KPiA+Cj4gPiA+IEJ1dAo+ID4gPiBpdCBtYWtlcyBzZW5zZSB0
byByZXF1aXJlIHRoZW0gdG8gYmUgY29uc2lzdGVudC4gVGhlcmUgaXMgYQo+ID4gPiBkZXZfcGFy
c2VfaGVhZGVyX3Byb3RvY29sIHRoYXQgbWF5IHJldHVybiB0aGUgbGluayBsYXllciB0eXBlIGlu
IGEKPiA+ID4gbW9yZSBnZW5lcmljIGZhc2hpb24gdGhhbiBjYXN0aW5nIHRvIHNrYl9ldGhfaGRy
Lgo+ID4gPgo+ID4gPiBRdWVzdGlvbiByZW1haW5zIHdoYXQgdG8gZG8gZm9yIHRoZSBsaW5rIGxh
eWVyIHR5cGVzIHRoYXQgZG8gbm90Cj4gPiA+IGltcGxlbWVudAo+ID4gPiBoZWFkZXJfb3BzLT5w
YXJzZV9wcm90b2NvbCwgYW5kIHNvIHdlIGNhbm5vdCB2YWxpZGF0ZSB0aGUgcGFja2V0J3MKPiA+
ID4gbmV0d29yayBwcm90b2NvbC4gRHJvcCB3aWxsIGNhdXNlIGZhbHNlIHBvc2l0aXZlcywgYWNj
ZXB0cyB3aWxsCj4gPiA+IGxlYXZlIGEKPiA+ID4gcG90ZW50aWFsIHBhdGgsIGp1c3QgY2xvc2Vz
IGl0IGZvciBFdGhlcm5ldC4KPiA+ID4KPiA+ID4gVGhpcyBtaWdodCBjYWxsIGZvciBtdWx0aXBs
ZSBmaXhlcywgYm90aCBvbiBmaXJzdCBpbmdlc3QgYW5kIGluc2lkZQo+ID4gPiB0aGUgc3RhY2s/
Cj4gPgo+IEdpdmVuIHRoYXQgdGhpcyBpcyByZWxhdGVkIHRvIGRvZGd5IHBhY2tldHMgYW5kIHRo
YXQgd2UgY2FuJ3QgdHJ1c3QKPiBldGguaF9wcm90bywgd291bGRuJ3QgaXQgbWFrZSBzZW5zZSB0
byBhbHdheXMgZHJvcCBwYWNrZXRzICh3aXRoCj4gcG90ZW50aWFsIGZhbHNlIHBvc2l0aXZlcyks
IGVycmluZyBvbiB0aGUgc2lkZSBvZiBjYXV0aW9uLCBpZgo+IGhlYWRlcl9vcHMtPnBhcnNlX3By
b3RvY29sIGlzbid0IGltcGxlbWVudGVkIGZvciB0aGUgZGV2IGluIHF1ZXN0aW9uPwoKVW5mb3J0
dW5hdGVseSwgdGhhdCBtaWdodCBicmVhayBhcHBsaWNhdGlvbnMgc29tZXdoZXJlIG91dCB0aGVy
ZS4KX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVh
bGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRp
b24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZv
L3ZpcnR1YWxpemF0aW9u
