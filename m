Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6ACE1C00140
	for <virtualization@archiver.kernel.org>; Fri, 12 Aug 2022 14:57:30 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DF543404BF;
	Fri, 12 Aug 2022 14:57:29 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org DF543404BF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=I0hYDAQh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wSPr6lZW-vM0; Fri, 12 Aug 2022 14:57:27 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id CC054404AE;
	Fri, 12 Aug 2022 14:57:26 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org CC054404AE
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 93E83C0033;
	Fri, 12 Aug 2022 14:57:26 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1ED6EC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 14:57:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id CA7DF60ABB
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 14:57:25 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org CA7DF60ABB
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=I0hYDAQh
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id nPLCrm0sCL_M
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 14:57:24 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 7F36E605EA
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com
 [IPv6:2607:f8b0:4864:20::d30])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 7F36E605EA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 14:57:24 +0000 (UTC)
Received: by mail-io1-xd30.google.com with SMTP id g15so1018344iob.0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 12 Aug 2022 07:57:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:from:to:cc;
 bh=zKjSj2wTsw/rznrfDfUfY+1E6AA9/o4ZtfsJOOVevII=;
 b=I0hYDAQhR6fZiGQJpTRTzwuIV7C2zNpXtIo1w4Znh1k2YeTNw1apiK2zkUfv0NrswJ
 ImnfizLL+jBzIUA5S0nSjhWI4mIrInUl1pNo+cjA5XFipGL4B6nuWTz7H1eOrAOmDflJ
 IU93NK5XEK9vuM2SNjqmgQkXjbLECjKFk2d5dUv8YcT53dCZwbxnNG+AOuDJFmfEtOTO
 cXC7PknC37U43S2F1oYjlHyXfVdcTCiZy3guMRpK+lg2maL2K6yeLwmZMgEP1gQiNWDB
 dwS+EnmM0RNc5h4b8vAvGb4l7OXFr3WgZo8Arje190utWbbH4kKqo9XmybzOABmSPH0M
 euwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc;
 bh=zKjSj2wTsw/rznrfDfUfY+1E6AA9/o4ZtfsJOOVevII=;
 b=m1Yha9NWAiVD+wwoHds2gbu0HU77NRaAti7Vj7k9gNl94igjfTpg7t1nqYB00sak6Z
 ujZPjxl/nSpzhEC4QScoBw2uTSZ0cXg3Fy1vEUHLYyv1h9ywFBe7qA+DTWLsCGC7GB0w
 8r1KkrjPyYR4Hd2m9UqV0AGSivUrgvjmIz3qaVEF1PHzfg3cFv51rxo4jQzIsy+cjid1
 aFoqRPcnKY0qdDgAjODYT8e22/1DV9HtE9R0Ed8QWNZ2JeXrM4zmgcyVwXFBgTXeJbRW
 TTk/3YI9KyvolYc8vraF/eProjiDDTt2fODDNEAdyYWVPWMkHuMtunaZEfDE/nLcEOG8
 nvcw==
X-Gm-Message-State: ACgBeo0DGQjV587Vqa61gbHL2vfMU+MAJShlrnHxci79NNUMolPrSuHX
 QXaUnjYHP75jLR4jZPGa63jDL1WAo5B43CfS6ss=
X-Google-Smtp-Source: AA6agR53abgJhbrjrkXXm8aoDOdt5N7ApLUDf8l8gdXWC5K0h+8H6Vmqk/EXucLiIPfbZRv7mEND0MbYtsaU/4RpswI=
X-Received: by 2002:a05:6602:26c7:b0:67b:72ef:b87b with SMTP id
 g7-20020a05660226c700b0067b72efb87bmr1846439ioo.175.1660316243533; Fri, 12
 Aug 2022 07:57:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220701090240.1896131-1-dmitry.osipenko@collabora.com>
 <20220701090240.1896131-3-dmitry.osipenko@collabora.com>
 <2bb95e80-b60a-36c0-76c8-a06833032c77@amd.com>
 <CAF6AEGtqPeF1DjmBKgzWK39Yi81YiNjTjDNn85TKx7uwicFTSA@mail.gmail.com>
 <2a646ce4-c2ec-3b11-77a0-cc720afd6fe1@collabora.com>
 <YvOav/vF2awVWIu0@phenom.ffwll.local>
 <CAF6AEGvfAJgwBe4+sK0gAkZ++MwH9x4=698C8XSnmfYNMFZqfA@mail.gmail.com>
 <9674d00e-c0d6-ceba-feab-5dc475bda694@collabora.com>
 <CAF6AEGv1cVC9ZNMwpwFOki5CrwD3kSAHM9EUFZGWY-y5zcQsCg@mail.gmail.com>
 <fc019528-7ec7-9e5b-1b6d-c44da14346cf@collabora.com>
 <CAF6AEGv8zSd0fEYB9hd2QOyTt53gFSQoL8JdZtCvtCdYfMfB2Q@mail.gmail.com>
 <73b51dde-689f-64ce-a1c8-0d7c84a2ed66@collabora.com>
In-Reply-To: <73b51dde-689f-64ce-a1c8-0d7c84a2ed66@collabora.com>
From: Rob Clark <robdclark@gmail.com>
Date: Fri, 12 Aug 2022 07:57:11 -0700
Message-ID: <CAF6AEGuR1cRQYaQBYGnMBzy=XJUcN2o2gzabZaGO2Dj62Uq1DA@mail.gmail.com>
Subject: Re: [PATCH v8 2/2] drm/gem: Don't map imported GEMs
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc: kernel@collabora.com, dri-devel <dri-devel@lists.freedesktop.org>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 David Airlie <airlied@linux.ie>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <ckoenig.leichtzumerken@gmail.com>,
 =?UTF-8?Q?Thomas_Hellstr=C3=B6m?= <thomas_os@shipmail.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 Maxime Ripard <mripard@kernel.org>,
 Gurchetan Singh <gurchetansingh@chromium.org>,
 Emil Velikov <emil.l.velikov@gmail.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, linux-tegra@vger.kernel.org,
 Daniel Vetter <daniel@ffwll.ch>, Dmitry Osipenko <digetx@gmail.com>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>,
 Chia-I Wu <olvaffe@gmail.com>
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

T24gRnJpLCBBdWcgMTIsIDIwMjIgYXQgNDoyNiBBTSBEbWl0cnkgT3NpcGVua28KPGRtaXRyeS5v
c2lwZW5rb0Bjb2xsYWJvcmEuY29tPiB3cm90ZToKPgo+IE9uIDgvMTEvMjIgMDI6MTksIFJvYiBD
bGFyayB3cm90ZToKPiA+IE9uIFdlZCwgQXVnIDEwLCAyMDIyIGF0IDM6MjMgUE0gRG1pdHJ5IE9z
aXBlbmtvCj4gPiA8ZG1pdHJ5Lm9zaXBlbmtvQGNvbGxhYm9yYS5jb20+IHdyb3RlOgo+ID4+Cj4g
Pj4gT24gOC8xMS8yMiAwMTowMywgUm9iIENsYXJrIHdyb3RlOgo+ID4+PiBPbiBXZWQsIEF1ZyAx
MCwgMjAyMiBhdCAxMjoyNiBQTSBEbWl0cnkgT3NpcGVua28KPiA+Pj4gPGRtaXRyeS5vc2lwZW5r
b0Bjb2xsYWJvcmEuY29tPiB3cm90ZToKPiA+Pj4+Cj4gPj4+PiBPbiA4LzEwLzIyIDE4OjA4LCBS
b2IgQ2xhcmsgd3JvdGU6Cj4gPj4+Pj4gT24gV2VkLCBBdWcgMTAsIDIwMjIgYXQgNDo0NyBBTSBE
YW5pZWwgVmV0dGVyIDxkYW5pZWxAZmZ3bGwuY2g+IHdyb3RlOgo+ID4+Pj4+Pgo+ID4+Pj4+PiBP
biBXZWQsIEp1bCAwNiwgMjAyMiBhdCAxMDowMjowN0FNICswMzAwLCBEbWl0cnkgT3NpcGVua28g
d3JvdGU6Cj4gPj4+Pj4+PiBPbiA3LzYvMjIgMDA6NDgsIFJvYiBDbGFyayB3cm90ZToKPiA+Pj4+
Pj4+PiBPbiBUdWUsIEp1bCA1LCAyMDIyIGF0IDQ6NTEgQU0gQ2hyaXN0aWFuIEvDtm5pZyA8Y2hy
aXN0aWFuLmtvZW5pZ0BhbWQuY29tPiB3cm90ZToKPiA+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4gQW0g
MDEuMDcuMjIgdW0gMTE6MDIgc2NocmllYiBEbWl0cnkgT3NpcGVua286Cj4gPj4+Pj4+Pj4+PiBE
cml2ZXJzIHRoYXQgdXNlIGRybV9nZW1fbW1hcCgpIGFuZCBkcm1fZ2VtX21tYXBfb2JqKCkgaGVs
cGVycyBkb24ndAo+ID4+Pj4+Pj4+Pj4gaGFuZGxlIGltcG9ydGVkIGRtYS1idWZzIHByb3Blcmx5
LCB3aGljaCByZXN1bHRzIGluIG1hcHBpbmcgb2Ygc29tZXRoaW5nCj4gPj4+Pj4+Pj4+PiBlbHNl
IHRoYW4gdGhlIGltcG9ydGVkIGRtYS1idWYuIE9uIE5WSURJQSBUZWdyYSB3ZSBnZXQgYSBoYXJk
IGxvY2t1cCB3aGVuCj4gPj4+Pj4+Pj4+PiB1c2Vyc3BhY2Ugd3JpdGVzIHRvIHRoZSBtZW1vcnkg
bWFwcGluZyBvZiBhIGRtYS1idWYgdGhhdCB3YXMgaW1wb3J0ZWQgaW50bwo+ID4+Pj4+Pj4+Pj4g
VGVncmEncyBEUk0gR0VNLgo+ID4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+IE1ham9yaXR5IG9mIERS
TSBkcml2ZXJzIHByb2hpYml0IG1hcHBpbmcgb2YgdGhlIGltcG9ydGVkIEdFTSBvYmplY3RzLgo+
ID4+Pj4+Pj4+Pj4gTWFwcGluZyBvZiBpbXBvcnRlZCBHRU1zIHJlcXVpcmUgc3BlY2lhbCBjYXJl
IGZyb20gdXNlcnNwYWNlIHNpbmNlIGl0Cj4gPj4+Pj4+Pj4+PiBzaG91bGQgc3luYyBkbWEtYnVm
IGJlY2F1c2UgbWFwcGluZyBjb2hlcmVuY3kgb2YgdGhlIGV4cG9ydGVyIGRldmljZSBtYXkKPiA+
Pj4+Pj4+Pj4+IG5vdCBtYXRjaCB0aGUgRFJNIGRldmljZS4gTGV0J3MgcHJvaGliaXQgdGhlIG1h
cHBpbmcgZm9yIGFsbCBEUk0gZHJpdmVycwo+ID4+Pj4+Pj4+Pj4gZm9yIGNvbnNpc3RlbmN5Lgo+
ID4+Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4+IFN1Z2dlc3RlZC1ieTogVGhvbWFzIEhlbGxzdHLDtm0g
PHRob21hcy5oZWxsc3Ryb21AbGludXguaW50ZWwuY29tPgo+ID4+Pj4+Pj4+Pj4gU2lnbmVkLW9m
Zi1ieTogRG1pdHJ5IE9zaXBlbmtvIDxkbWl0cnkub3NpcGVua29AY29sbGFib3JhLmNvbT4KPiA+
Pj4+Pj4+Pj4KPiA+Pj4+Pj4+Pj4gSSdtIHByZXR0eSBzdXJlIHRoYXQgdGhpcyBpcyB0aGUgcmln
aHQgYXBwcm9hY2gsIGJ1dCBpdCdzIGNlcnRhaW5seSBtb3JlCj4gPj4+Pj4+Pj4+IHRoYW4gcG9z
c2libGUgdGhhdCBzb21lYm9keSBhYnVzZWQgdGhpcyBhbHJlYWR5Lgo+ID4+Pj4+Pj4+Cj4gPj4+
Pj4+Pj4gSSBzdXNwZWN0IHRoYXQgdGhpcyBpcyBhYnVzZWQgaWYgeW91IHJ1biBkZXFwIGN0cyBv
biBhbmRyb2lkLi4gaWUuIGFsbAo+ID4+Pj4+Pj4+IHdpbnN5cyBidWZmZXJzIGFyZSBkbWEtYnVm
IGltcG9ydHMgZnJvbSBncmFsbG9jLiAgQW5kIHRoZW4gd2hlbiB5b3UKPiA+Pj4+Pj4+PiBoaXQg
cmVhZHBpeC4uLgo+ID4+Pj4+Pj4+Cj4gPj4+Pj4+Pj4gWW91IG1pZ2h0IG9ubHkgaGl0IHRoaXMg
aW4gc2NlbmFyaW9zIHdpdGggc2VwYXJhdGUgZ3B1IGFuZCBkaXNwbGF5IChvcgo+ID4+Pj4+Pj4+
IGRHUFUraUdQVSkgYmVjYXVzZSBzZWxmLWltcG9ydHMgYXJlIGhhbmRsZWQgZGlmZmVyZW50bHkg
aW4KPiA+Pj4+Pj4+PiBkcm1fZ2VtX3ByaW1lX2ltcG9ydF9kZXYoKS4uIGFuZCBtYXliZSBub3Qg
aW4gY2FzZXMgd2hlcmUgeW91IGVuZCB1cAo+ID4+Pj4+Pj4+IHdpdGggYSBibGl0IGZyb20gdGls
ZWQvY29tcHJlc3NlZCB0byBsaW5lYXIuLiBtYXliZSB0aGF0IG5hcnJvd3MgdGhlCj4gPj4+Pj4+
Pj4gc2NvcGUgZW5vdWdoIHRvIGp1c3QgZml4IGl0IGluIHVzZXJzcGFjZT8KPiA+Pj4+Pj4+Cj4g
Pj4+Pj4+PiBHaXZlbiB0aGF0IHRoYXQgb25seSBkcml2ZXJzIHdoaWNoIHVzZSBEUk0tU0hNRU0g
cG90ZW50aWFsbHkgY291bGQndmUKPiA+Pj4+Pj4+IG1hcCBpbXBvcnRlZCBkbWEtYnVmcyAoUGFu
ZnJvc3QsIExpbWEpIGFuZCB0aGV5IGFscmVhZHkgZG9uJ3QgYWxsb3cgdG8KPiA+Pj4+Pj4+IGRv
IHRoYXQsIEkgdGhpbmsgd2UncmUgZ29vZC4KPiA+Pj4+Pj4KPiA+Pj4+Pj4gU28gY2FuIEkgaGF2
ZSBhbiBhY2sgZnJvbSBSb2IgaGVyZSBvciBhcmUgdGhlcmUgc3RpbGwgcXVlc3Rpb25zIHRoYXQg
dGhpcwo+ID4+Pj4+PiBtaWdodCBnbyBib29tPwo+ID4+Pj4+Pgo+ID4+Pj4+PiBEbWl0cnksIHNp
bmNlIHlvdSBoYXZlIGEgYnVuY2ggb2YgcGF0Y2hlcyBtZXJnZWQgbm93IEkgdGhpbmsgd291bGQg
YWxzbyBiZQo+ID4+Pj4+PiBnb29kIHRvIGdldCBjb21taXQgcmlnaHRzIHNvIHlvdSBjYW4gZHJp
dmUgdGhpcyBtb3JlIHlvdXJzZWxmLiBJJ3ZlIGFza2VkCj4gPj4+Pj4+IERhbmllbCBTdG9uZSB0
byBoZWxwIHlvdSBvdXQgd2l0aCBnZXR0aW5nIHRoYXQuCj4gPj4+Pj4KPiA+Pj4+PiBJICp0aGlu
ayogd2UnZCBiZSBvayB3aXRoIHRoaXMgb24gbXNtLCBtb3N0bHkganVzdCBieSBkdW1iIGx1Y2su
Cj4gPj4+Pj4gQmVjYXVzZSB0aGUgZG1hLWJ1ZidzIHdlIGltcG9ydCB3aWxsIGJlIHNlbGYtaW1w
b3J0LiAgSSdtIGxlc3Mgc3VyZQo+ID4+Pj4+IGFib3V0IHBhbmZyb3N0IChzcmMvcGFuZnJvc3Qv
bGliL3Bhbl9iby5jIGRvZXNuJ3Qgc2VlbSB0byBoYXZlIGEKPiA+Pj4+PiBzcGVjaWFsIHBhdGgg
Zm9yIGltcG9ydGVkIGRtYS1idWZzIGVpdGhlciwgYW5kIGluIHRoYXQgY2FzZSB0aGV5IHdvbid0
Cj4gPj4+Pj4gYmUgc2VsZi1pbXBvcnRzLi4gYnV0IEkgZ3Vlc3Mgbm8gb25lIGhhcyB0cmllZCB0
byBydW4gYW5kcm9pZCBjdHMgb24KPiA+Pj4+PiBwYW5mcm9zdCkuCj4gPj4+Pgo+ID4+Pj4gVGhl
IGxhc3QgdGltZSBJIHRyaWVkIHRvIG1tYXAgZG1hLWJ1ZiBpbXBvcnRlZCB0byBQYW5mcm9zdCBk
aWRuJ3Qgd29yawo+ID4+Pj4gYmVjYXVzZSBQYW5mcm9zdCBkaWRuJ3QgaW1wbGVtZW50IHNvbWV0
aGluZyBuZWVkZWQgZm9yIHRoYXQuIEknbGwgbmVlZAo+ID4+Pj4gdG8gdGFrZSBhIGxvb2sgYWdh
aW4gYmVjYXVzZSBjYW4ndCByZWNhbGwgd2hhdCBpdCB3YXMuCj4gVXBkOiBJIHJlLWNoZWNrZWQg
UGFuZnJvc3QgdXNpbmcgdG9kYXkncyBsaW51eC1uZXh0IGFuZCBtYXBwaW5nIG9mCj4gaW1wb3J0
ZWQgZG1hLWJ1ZiB3b3JrcywgSSBtYXBwZWQgaW1wb3J0ZWQgYnVmIGZyb20gdmlkZW8gZGVjb2Rl
ci4KPiBBcHBhcmVudGx5IHByZXZpb3VzbHkgSSBoYWQgc29tZSBsb2NhbCBrZXJuZWwgY2hhbmdl
IHRoYXQgYnJva2UgdGhlIG1hcHBpbmcuCj4KPiA+Pj4+PiBXaGF0IGFib3V0IHNvbWV0aGluZyBs
ZXNzIGRyYXN0aWMgdG8gc3RhcnQsIGxpa2UgKGFwb2xvZ2llcyBmb3IKPiA+Pj4+PiBoYW5kLWVk
aXRlZCBwYXRjaCk6Cj4gPj4+Pj4KPiA+Pj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9ncHUvZHJt
L2RybV9nZW0uYyBiL2RyaXZlcnMvZ3B1L2RybS9kcm1fZ2VtLmMKPiA+Pj4+PiBpbmRleCA4NmQ2
NzBjNzEyODYuLmZjOWVjNDJmYTBhYiAxMDA2NDQKPiA+Pj4+PiAtLS0gYS9kcml2ZXJzL2dwdS9k
cm0vZHJtX2dlbS5jCj4gPj4+Pj4gKysrIGIvZHJpdmVycy9ncHUvZHJtL2RybV9nZW0uYwo+ID4+
Pj4+IEBAIC0xMDM0LDYgKzEwMzQsMTAgQEAgaW50IGRybV9nZW1fbW1hcF9vYmooc3RydWN0IGRy
bV9nZW1fb2JqZWN0Cj4gPj4+Pj4gKm9iaiwgdW5zaWduZWQgbG9uZyBvYmpfc2l6ZSwKPiA+Pj4+
PiAgewo+ID4+Pj4+ICAgICAgICAgaW50IHJldDsKPiA+Pj4+Pgo+ID4+Pj4+ICsgICAgICAgV0FS
Tl9PTl9PTkNFKG9iai0+aW1wb3J0X2F0dGFjaCk7Cj4gPj4+Pgo+ID4+Pj4gVGhpcyB3aWxsIGhh
bmcgTlZJRElBIFRlZ3JhLCB3aGljaCBpcyB3aGF0IHRoaXMgcGF0Y2ggZml4ZWQgaW5pdGlhbGx5
Lgo+ID4+Pj4gSWYgbmVpdGhlciBvZiB1cHN0cmVhbSBEUk0gZHJpdmVycyBuZWVkIHRvIG1hcCBp
bXBvcnRlZCBkbWEtYnVmcyBhbmQKPiA+Pj4+IG5ldmVyIG5lZWRlZCwgdGhlbiB3aHkgZG8gd2Ug
bmVlZCB0aGlzPwo+ID4+Pgo+ID4+PiBvaCwgdGVncmEgaXNuJ3QgdXNpbmcgc2htZW0gaGVscGVy
cz8gIEkgYXNzdW1lZCBpdCB3YXMuICBXZWxsIG15IHBvaW50Cj4gPj4+IHdhcyB0byBtYWtlIGEg
bW9yZSB0YXJnZXRlZCBmYWlsIG9uIHRlZ3JhLCBhbmQgYSBXQVJOX09OIGZvciBldmVyeW9uZQo+
ID4+PiBlbHNlIHRvIG1ha2UgaXQgY2xlYXIgdGhhdCB3aGF0IHRoZXkgYXJlIGRvaW5nIGlzIHVu
ZGVmaW5lZCBiZWhhdmlvci4KPiA+Pj4gQmVjYXVzZSBzbyBmYXIgZXhpc3RpbmcgdXNlcnNwYWNl
IChvciB3ZWxsLCBwYW5mcm9zdCBhbmQgZnJlZWRyZW5vIGF0Cj4gPj4+IGxlYXN0LCB0aG9zZSBh
cmUgdGhlIHR3byBJIGtub3cgb3IgY2hlY2tlZCkgZG9uJ3QgbWFrZSBzcGVjaWFsIGNhc2VzCj4g
Pj4+IGZvciBtbWFwJ2luZyBhZ2FpbnN0IHRoZSBkbWFidWYgZmQgYWdhaW5zdCB0aGUgZG1hYnVm
IGZkIGluc3RlYWQgb2YKPiA+Pj4gdGhlIGRybSBkZXZpY2UgZmQuCj4gPj4KPiA+PiBJdCdzIG5v
dCBjbGVhciB0byBtZSB3aGF0IGJhZCBBbmRyb2lkIGRvZXMgZm9ybSB5b3VycyBjb21tZW50cy4g
RG9lcyBpdAo+ID4+IGV4cG9ydCBkbWEtYnVmIGZyb20gR1BVIGFuZCB0aGVuIGltcG9ydCBpdCB0
byBHUFU/IElmIHllcywgdGhlbiBEUk0gY29yZQo+ID4+IGhhcyBhIGNoZWNrIGZvciB0aGUgc2Vs
Zi1pbXBvcnRpbmcgWzFdLgo+ID4+Cj4gPj4gWzFdCj4gPj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxp
bi5jb20vbGludXgvbGF0ZXN0L3NvdXJjZS9kcml2ZXJzL2dwdS9kcm0vZHJtX3ByaW1lLmMjTDkx
OAo+ID4+Cj4gPj4gSWYgeW91J3JlIG1lYW5pbmcgc29tZXRoaW5nIGVsc2UsIHRoZW4gcGxlYXNl
IGV4cGxhaW4gaW4gYSBtb3JlIGRldGFpbHMuCj4gPgo+ID4gU28sIGFuZHJvaWQvZ3JhbGxvYyBh
bGxvY2F0ZXMgYnVmZmVycyBleHRlcm5hbGx5IHRvIHRoZSBkcml2ZXIgYW5kCj4gPiBpbXBvcnRz
IHRoZW0gaW50byBkcml2ZXIuICAoQW5kIHRoYXQgc2VlbXMgdG8gbm90IGp1c3QgYmUgd2luZG93
Cj4gPiBzdXJmYWNlcywgYnV0IGluIGNhc2VzIHJhbmRvbSB0ZXh0dXJlcywgZXRjKQo+ID4KPiA+
IEluIHRoZSBub3JtYWwgY2FzZSB0aGVzZSBzaG91bGQgYmUgYWxsb2NhdGVkIGZyb20gZHJtL21z
bSBzbyBpdCBzaG91bGQKPiA+IGhpdCBbMV0uLiB0aGlzIGlzIHRoZSAiZHVtYiBsdWNrIiBJIG1l
bnRpb25lZCBlYXJsaWVyLiAgQnV0IEknbSBub3QKPiA+IGNvbmZpZGVudCBlbm91Z2ggdG8gc2F5
IHRoYXQgdGhlcmUgaXMgbm8gb3RoZXIgY2FzZS4KPiA+Cj4gPj4KPiA+Pj4gSSAqdGhpbmsqIGl0
IHNob3VsZCB3b3JrIG91dCB0aGF0IHdlIGRvbid0IGhpdCB0aGlzIHBhdGggd2l0aAo+ID4+PiBm
cmVlZHJlbm8gYnV0IG9uIGFuZHJvaWQgSSBjYW4ndCByZWFsbHkgZ3VhcmFudGVlIG9yIHByb3Zl
IGl0LiAgU28KPiA+Pj4geW91ciBwYXRjaCB3b3VsZCBwb3RlbnRpYWxseSBicmVhayBleGlzdGlu
ZyB3b3JraW5nIHVzZXJzcGFjZS4gIE1heWJlCj4gPj4+IGl0IGlzIHVzZXJzcGFjZSB0aGF0IGlz
bid0IHBvcnRhYmxlIChidXQgT1RPSCBpdCBpc24ndCBsaWtlIHlvdSBhcmUKPiA+Pj4gZ29pbmcg
dG8gYmUgdXNpbmcgZnJlZWRyZW5vIG9uIHRlZ3JhKS4gIFNvIHdoeSBkb24ndCB5b3UgZ28gZm9y
IGEgbW9yZQo+ID4+PiB0YXJnZXRlZCBmaXggdGhhdCBvbmx5IHJldHVybnMgYW4gZXJyb3Igb24g
aHcgd2hlcmUgdGhpcyBpcwo+ID4+PiBwcm9ibGVtYXRpYz8KPiA+Pgo+ID4+IFRoYXQncyB3aGF0
IHRoZSBmaXJzdCB2ZXJzaW9ucyBvZiB0aGUgcGF0Y2ggZGlkIGFuZCBDaHJpc3RpYW4gc3VnZ2Vz
dGVkCj4gPj4gdGhhdCBpdCdzIG5vdCBhIGdvb2QgYXBwcm9hY2guIEluIGZhY3QgaXQgc2hvdWxk
IGJlIG5vdCBvbmx5IFRlZ3JhIHRoYXQKPiA+PiBoYXMgYSBicm9rZW4gZG1hLWJ1ZiBtYXBwaW5n
LCBidXQgYXBwYXJlbnRseSBPTUFQIGRyaXZlciB0b28uCj4gPgo+ID4gSG1tLCBJIGd1ZXNzIEkn
bSBhIGJpdCBtb3JlIGNvbnNlcnZhdGl2ZSB3aGVuIGl0IGNvbWVzIHRvIHBvdGVudGlhbGx5Cj4g
PiBicmVha2luZyB1c2Vyc3BhY2UuCj4KPiBJZiBzdWNoIHVzZXJzcGFjZSBleGlzdHMsIHRoZW4g
b2YgY291cnNlIHRoZSBtYXBwaW5nIHNob3VsZCBjb250aW51ZSB0bwo+IHdvcmsuIFN0aWxsIHdp
bGwgYmUgZ3JlYXQgdG8ga25vdyB3aGF0IHRoYXQgdXNlcnBzYWNlIGlzLgoKRGVmaW5pdGVseSBl
eGlzdGluZyBtZXNhIGRvZXMgbm90IGhhdmUgYSBzcGVjaWFsIG1tYXAgcGF0aCBmb3IKaW1wb3J0
ZWQgZG1hLWJ1ZnMgKGJvdGggaW4gdGhlIGNhc2Ugb2YgcGFuZnJvc3QgYW5kIGZyZWVkcmVubywg
SQpkaWRuJ3QgY2hlY2sgYW55IG90aGVycykuICBUaGUgb25seSBxdWVzdGlvbiBpcyB3aGV0aGVy
IHRoZXJlIGlzIGEKY2FzZSB3aGVyZSBzb21lIGFwcC90ZXN0L2V0YyBpbXBvcnRzIGEgZm9yZWln
biBkbWEtYnVmIGZkIGFuZCB0aGVuCmRvZXMgc29tZXRoaW5nIHRoYXQgd291bGQgdHJpZ2dlciBt
bWFwJ2luZywgbGlrZSByZWFkcGl4LgoKQlIsCi1SCgo+IEFscmlnaHQsIGxldCdzIGtlZXAgdGhl
IGRtYS1idWYgbWFwcGluZyBhcy1pcyBmb3Igbm93LiBJJ2xsIGZpeCBqdXN0IHRoZQo+IFRlZ3Jh
IGRyaXZlciB0aGVuLgo+Cj4gLS0KPiBCZXN0IHJlZ2FyZHMsCj4gRG1pdHJ5Cl9fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxp
bmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczov
L2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlv
bg==
