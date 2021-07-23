Return-Path: <SRS0=XE2Y=MP=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1623C4338F
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 16:37:48 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4221560E78
	for <virtualization@archiver.kernel.org>; Fri, 23 Jul 2021 16:37:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 4221560E78
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lists.linux-foundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 0686783B1E;
	Fri, 23 Jul 2021 16:37:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4nGT-1BHBIM0; Fri, 23 Jul 2021 16:37:47 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 7219783B15;
	Fri, 23 Jul 2021 16:37:46 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 4B0B3C001A;
	Fri, 23 Jul 2021 16:37:46 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 1C587C000E
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 16:37:45 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id F206483B1C
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 16:37:44 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id svisauzsUglx
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 16:37:44 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com
 [IPv6:2607:f8b0:4864:20::733])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 0C98683B15
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 16:37:43 +0000 (UTC)
Received: by mail-qk1-x733.google.com with SMTP id o13so1917207qkk.9
 for <virtualization@lists.linux-foundation.org>;
 Fri, 23 Jul 2021 09:37:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=20161025;
 h=mime-version:references:in-reply-to:from:date:message-id:subject:to
 :cc:content-transfer-encoding;
 bh=N1hxecFYV3+JZRr22osFbppGaqsIbCDQHE0NyJLWY58=;
 b=N4hI/7kCZRSCMfYaGdrpGP1bS8kxzoCxMgN3cXxwXGw3iYfYBvxYgxksX8h5Oxkii/
 WejoCOJz2+fZo+UKguBBSr2DiEsmPNoIYWfED53xXfLGmV3bXhWdMGWTNSdU2Yvu1Yg2
 JlSpNOefiCf6ira6HltmaVomcHIFKpQINjDdCxqtzko33ALGlMmkCPzRGDGrgvY4nOYX
 f0VacpxCNEcIe2CCqD2RR6suoclU6tl/4JL5gaXcXQijTvFWVJYt9q9rBVSdZvyQpTmp
 fH5aICsZas/0ukdtq3dPtCQHfj5XVnJDyD4sqTiXhgfFTNbNak9r6oF4UAzUrK+q5JYQ
 B8UQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=N1hxecFYV3+JZRr22osFbppGaqsIbCDQHE0NyJLWY58=;
 b=NrecNl/0FBAVVVm2WtCr94upQysEYvHPq90rG3CEIXJrLSBKIASB6mvIYoGl7A9N61
 BQceY5P+obXS/xQCxihsQykTXFfnqlQp7dioAgLsbvfzE2cG7iFbDVWYF1xq8ciu7d1A
 tWoriee+fHM0s2ImtfAjTj5PQ/pQzo15Vw/Kkk/3JpUOFpfEq1sJ2HaNXf3zaTfMU3L2
 wEk7kw+TubA3B028uAZ5rAI3i4vY07ENhAB/55ByH85oF+A0m60ABrY2SokY13R58O9E
 j/mmjFk4VTHGxmFKcsoItQT0fECg50UF3ebOt0qjlPXQckbRhvNK74j395iyWAA7tLA9
 ioxA==
X-Gm-Message-State: AOAM530xDz3uhLCIYZeA0UG782OCL+pYqOTxCwe1WjFoQrmrvYK5Lyuq
 boibnt+pyIKWs/Ov1+1Fy1n+1G47XmheDvFrgKrkHg==
X-Google-Smtp-Source: ABdhPJwAnaKhosJSYhCY7OtFH9aUgOng37/VwljgedJRo/4vr9FZo7PCD4C7uLgLygm4oiCmSrFED+NioXLFb/0yol8=
X-Received: by 2002:a05:620a:4543:: with SMTP id
 u3mr5486739qkp.326.1627058262618; 
 Fri, 23 Jul 2021 09:37:42 -0700 (PDT)
MIME-Version: 1.0
References: <CAG_fn=WwQ29akxY1Eq=N_=HCF3t7z+T2obh9aRVUDFy1FSA3-Q@mail.gmail.com>
In-Reply-To: <CAG_fn=WwQ29akxY1Eq=N_=HCF3t7z+T2obh9aRVUDFy1FSA3-Q@mail.gmail.com>
Date: Fri, 23 Jul 2021 18:37:06 +0200
Message-ID: <CAG_fn=U+gSJHWPCmsdYi79RRtLHSX4TWwzW087QTVunPMS=+bQ@mail.gmail.com>
Subject: Re: Use of uninitialized memory with CONFIG_HW_RANDOM_VIRTIO
To: akong@redhat.com, rusty@rustcorp.com.au, 
 "Michael S. Tsirkin" <mst@redhat.com>, amit@kernel.org
Cc: syzkaller <syzkaller@googlegroups.com>, Dmitriy Vyukov <dvyukov@google.com>,
 virtualization@lists.linux-foundation.org
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
From: Alexander Potapenko via Virtualization
 <virtualization@lists.linux-foundation.org>
Reply-To: Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

VGhpcyBtaWdodCBoYXZlIGZhbGxlbiB0aHJvdWdoIHRoZSBjcmFja3MuIEFueSBvcGluaW9ucz8K
Ck9uIEZyaSwgTm92IDEzLCAyMDIwIGF0IDY6MjYgUE0gQWxleGFuZGVyIFBvdGFwZW5rbyA8Z2xp
ZGVyQGdvb2dsZS5jb20+IHdyb3RlOgo+Cj4gSGkgQW1vcywgUnVzdHksIEFtaXQsIE1pY2hhZWws
Cj4KPiBJIGFtIGhpdHRpbmcgc29tZXRoaW5nIHRoYXQgSSBiZWxpZXZlIHRvIGJlIGEgbWlub3Ig
cHJvYmxlbSBpbiB0aGUKPiB2aXJ0aW8gUk5HIGRyaXZlci4KPiBXaGVuIHJ1bm5pbmcgdGhlIGtl
cm5lbCB1bmRlciBLTVNBTiB3aXRoICItZGV2aWNlIHZpcnRpby1ybmctcGNpIgo+IHBhc3NlZCB0
byBRRU1VLCBJIGFtIHNlZWluZyByZXBvcnRzIGFib3V0IHJuZ19maWxsYnVmIGluCj4gZHJpdmVy
cy9jaGFyL2h3X3JhbmRvbS9jb3JlLmMgYmVpbmcgdXNlZCBiZWZvcmUgaW5pdGlhbGl6YXRpb24g
KHNlZQo+IHRoZSByZXBvcnQgYmVsb3cpLgo+Cj4gVGhpcyBjYW4gYmUgdmVyaWZpZWQgYnkgaW5p
dGlhbGl6aW5nIHJuZ19maWxsYnVmIHdpdGggJ0EnIGFzIGZvbGxvd3M6Cj4gPT09PT09PT09PT09
PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvY2hh
ci9od19yYW5kb20vY29yZS5jIGIvZHJpdmVycy9jaGFyL2h3X3JhbmRvbS9jb3JlLmMKPiBpbmRl
eCA4YzFjNDdkZDlmNDYuLjQ0ZDYwOWE1Nzk2YSAxMDA2NDQKPiAtLS0gYS9kcml2ZXJzL2NoYXIv
aHdfcmFuZG9tL2NvcmUuYwo+ICsrKyBiL2RyaXZlcnMvY2hhci9od19yYW5kb20vY29yZS5jCj4g
QEAgLTQzOSw4ICs0MzksMTEgQEAgc3RhdGljIGludCBod3JuZ19maWxsZm4odm9pZCAqdW51c2Vk
KQo+ICAgICAgICAgICAgICAgICBpZiAoSVNfRVJSKHJuZykgfHwgIXJuZykKPiAgICAgICAgICAg
ICAgICAgICAgICAgICBicmVhazsKPiAgICAgICAgICAgICAgICAgbXV0ZXhfbG9jaygmcmVhZGlu
Z19tdXRleCk7Cj4gKyAgICAgICAgICAgICAgIG1lbXNldChybmdfZmlsbGJ1ZiwgJ0EnLCBybmdf
YnVmZmVyX3NpemUoKSk7Cj4gKyAgICAgICAgICAgICAgIHJuZ19maWxsYnVmW3JuZ19idWZmZXJf
c2l6ZSgpLTFdID0gMDsKPiAgICAgICAgICAgICAgICAgcmMgPSBybmdfZ2V0X2RhdGEocm5nLCBy
bmdfZmlsbGJ1ZiwKPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcm5nX2J1ZmZl
cl9zaXplKCksIDEpOwo+ICsgICAgICAgICAgICAgICBwcl9lcnIoInJuZ19maWxsYnVmOiAlc1xu
Iiwgcm5nX2ZpbGxidWYpOwo+ICAgICAgICAgICAgICAgICBtdXRleF91bmxvY2soJnJlYWRpbmdf
bXV0ZXgpOwo+ICAgICAgICAgICAgICAgICBwdXRfcm5nKHJuZyk7Cj4gICAgICAgICAgICAgICAg
IGlmIChyYyA8PSAwKSB7Cj4gPT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09Cj4KPiBhbmQgYm9vdGluZyB0aGUga2VybmVsOiB0aGUgZmlyc3QgY2FsbCBvZiBod3JuZ19m
aWxsZm4oKSB3aWxsIHByaW50Cj4gIkFBQUFBQUEuLiIgaW5zdGVhZCBvZiByYW5kb20gZGF0YS4K
Pgo+IEZvciBzb21lIHJlYXNvbiBvbiB0aGF0IGZpcnN0IGl0ZXJhdGlvbiB2aS0+YnVzeSBpcyB0
cnVlIGhlcmU6Cj4gaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20vbGludXgvbGF0ZXN0L3NvdXJj
ZS9kcml2ZXJzL2NoYXIvaHdfcmFuZG9tL3ZpcnRpby1ybmcuYyNMNjIsCj4gdGhlcmVmb3JlIHRo
ZSBidWZmZXIgaXMgbm90IGJlaW5nIHNlbnQgdG8gdmlydGlvIHJpbmcuCj4KPiBXaGlsZSBwcm9i
YWJseSBiZWluZyBiZW5pZ24sIHRoaXMgYnVnIGlzIHByZXZlbnRpbmcgc3l6a2FsbGVyIGZyb20K
PiBmaW5kaW5nIG1vcmUgYnVncywgc28gaXQgd291bGQgYmUgbmljZSB0byBmaXggaXQuCj4gUGVy
aGFwcyB0aGUgZWFzaWVzdCBzb2x1dGlvbiBpcyB0byBremFsbG9jIHJuZ19maWxsYnVmLCBidXQg
aWYgaXQncwo+IGNyaXRpY2FsIGZvciB0aGlzIGRyaXZlciB0byBub3Qgc2tpcCBldmVuIHRoZSBm
aXJzdCByZWFkLCB0aGVuIG1heWJlCj4geW91IGhhdmUgYmV0dGVyIGlkZWFzPwo+Cj4gS01TQU4g
cmVwb3J0IGZvbGxvd3M6Cj4KPiA9PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09PQo+IEJVRzogS01TQU46IHVuaW5pdC12YWx1ZSBpbiBfbWl4X3Bvb2xf
Ynl0ZXMrMHg3ZDIvMHg5NTAKPiBkcml2ZXJzL2NoYXIvcmFuZG9tLmM6NTcwCj4gQ1BVOiAwIFBJ
RDogMjcxMSBDb21tOiBod3JuZyBOb3QgdGFpbnRlZCA1LjkuMC1yYzgtc3l6a2FsbGVyICMwCj4g
SGFyZHdhcmUgbmFtZTogR29vZ2xlIEdvb2dsZSBDb21wdXRlIEVuZ2luZS9Hb29nbGUgQ29tcHV0
ZSBFbmdpbmUsCj4gQklPUyBHb29nbGUgMDEvMDEvMjAxMQo+IENhbGwgVHJhY2U6Cj4gIF9fZHVt
cF9zdGFjayBsaWIvZHVtcF9zdGFjay5jOjc3IFtpbmxpbmVdCj4gIGR1bXBfc3RhY2srMHgyMWMv
MHgyODAgbGliL2R1bXBfc3RhY2suYzoxMTgKPiAga21zYW5fcmVwb3J0KzB4ZjcvMHgxZTAgbW0v
a21zYW4va21zYW5fcmVwb3J0LmM6MTIyCj4gIF9fbXNhbl93YXJuaW5nKzB4NWYvMHhhMCBtbS9r
bXNhbi9rbXNhbl9pbnN0ci5jOjIwMQo+ICBfbWl4X3Bvb2xfYnl0ZXMrMHg3ZDIvMHg5NTAgZHJp
dmVycy9jaGFyL3JhbmRvbS5jOjU3MAo+ICBtaXhfcG9vbF9ieXRlcysweGNhLzB4MmEwIGRyaXZl
cnMvY2hhci9yYW5kb20uYzo1OTkKPiAgYWRkX2h3Z2VuZXJhdG9yX3JhbmRvbW5lc3MrMHg0YWMv
MHg1MDAgZHJpdmVycy9jaGFyL3JhbmRvbS5jOjIzMTkKPiAgaHdybmdfZmlsbGZuKzB4NmFlLzB4
OTQwIGRyaXZlcnMvY2hhci9od19yYW5kb20vY29yZS5jOjQ1Mgo+ICBrdGhyZWFkKzB4NTFjLzB4
NTYwIGtlcm5lbC9rdGhyZWFkLmM6MjkzCj4gIHJldF9mcm9tX2ZvcmsrMHgxZi8weDMwIGFyY2gv
eDg2L2VudHJ5L2VudHJ5XzY0LlM6Mjk0Cj4KPiBVbmluaXQgd2FzIGNyZWF0ZWQgYXQ6Cj4gIGtt
c2FuX3NhdmVfc3RhY2tfd2l0aF9mbGFncyBtbS9rbXNhbi9rbXNhbi5jOjEyOSBbaW5saW5lXQo+
ICBrbXNhbl9pbnRlcm5hbF9wb2lzb25fc2hhZG93KzB4NWMvMHhmMCBtbS9rbXNhbi9rbXNhbi5j
OjExMgo+ICBrbXNhbl9zbGFiX2FsbG9jKzB4OGQvMHhlMCBtbS9rbXNhbi9rbXNhbl9ob29rcy5j
OjgwCj4gIHNsYWJfYWxsb2Nfbm9kZSBtbS9zbHViLmM6MjkwMyBbaW5saW5lXQo+ICBzbGFiX2Fs
bG9jIG1tL3NsdWIuYzoyOTEyIFtpbmxpbmVdCj4gIGttZW1fY2FjaGVfYWxsb2NfdHJhY2UrMHg2
MWUvMHhjOTAgbW0vc2x1Yi5jOjI5MjkKPiAga21hbGxvYyBpbmNsdWRlL2xpbnV4L3NsYWIuaDo1
NTQgW2lubGluZV0KPiAgaHdybmdfbW9kaW5pdCsweDEwMy8weDJlZiBkcml2ZXJzL2NoYXIvaHdf
cmFuZG9tL2NvcmUuYzo2MjEKPiAgZG9fb25lX2luaXRjYWxsKzB4MzcxLzB4OWMwIGluaXQvbWFp
bi5jOjEyMDgKPiAgZG9faW5pdGNhbGxfbGV2ZWwrMHgxZTUvMHgzYzYgaW5pdC9tYWluLmM6MTI4
MQo+ICBkb19pbml0Y2FsbHMrMHgxMjcvMHgxY2IgaW5pdC9tYWluLmM6MTI5Nwo+ICBkb19iYXNp
Y19zZXR1cCsweDMzLzB4MzYgaW5pdC9tYWluLmM6MTMxNwo+ICBrZXJuZWxfaW5pdF9mcmVlYWJs
ZSsweDIzOC8weDM4YiBpbml0L21haW4uYzoxNTE3Cj4gIGtlcm5lbF9pbml0KzB4MWYvMHg4NDAg
aW5pdC9tYWluLmM6MTQwNgo+ICByZXRfZnJvbV9mb3JrKzB4MWYvMHgzMCBhcmNoL3g4Ni9lbnRy
eS9lbnRyeV82NC5TOjI5NAo+ID09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09PT09
PT09PT09PT09PT09PT09Cj4KPiBUaGFua3MsCj4gQWxleAo+Cj4gLS0KPiBBbGV4YW5kZXIgUG90
YXBlbmtvCj4gU29mdHdhcmUgRW5naW5lZXIKPgo+IEdvb2dsZSBHZXJtYW55IEdtYkgKPiBFcmlr
YS1NYW5uLVN0cmHDn2UsIDMzCj4gODA2MzYgTcO8bmNoZW4KPgo+IEdlc2Now6RmdHNmw7xocmVy
OiBQYXVsIE1hbmljbGUsIEhhbGltYWggRGVMYWluZSBQcmFkbwo+IFJlZ2lzdGVyZ2VyaWNodCB1
bmQgLW51bW1lcjogSGFtYnVyZywgSFJCIDg2ODkxCj4gU2l0eiBkZXIgR2VzZWxsc2NoYWZ0OiBI
YW1idXJnCgoKCi0tIApBbGV4YW5kZXIgUG90YXBlbmtvClNvZnR3YXJlIEVuZ2luZWVyCgpHb29n
bGUgR2VybWFueSBHbWJICkVyaWthLU1hbm4tU3RyYcOfZSwgMzMKODA2MzYgTcO8bmNoZW4KCkdl
c2Now6RmdHNmw7xocmVyOiBQYXVsIE1hbmljbGUsIEhhbGltYWggRGVMYWluZSBQcmFkbwpSZWdp
c3RlcmdlcmljaHQgdW5kIC1udW1tZXI6IEhhbWJ1cmcsIEhSQiA4Njg5MQpTaXR6IGRlciBHZXNl
bGxzY2hhZnQ6IEhhbWJ1cmcKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3Rz
LmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9t
YWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
