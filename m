Return-Path: <SRS0=tbjA=LX=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F392DC11F64
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 03:03:56 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AC64E61D05
	for <virtualization@archiver.kernel.org>; Tue, 29 Jun 2021 03:03:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AC64E61D05
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=intel.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 6C9A26081B;
	Tue, 29 Jun 2021 03:03:56 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id IoqE0zzVEx1A; Tue, 29 Jun 2021 03:03:55 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id E578E60784;
	Tue, 29 Jun 2021 03:03:54 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id BD746C001A;
	Tue, 29 Jun 2021 03:03:54 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 83E17C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 03:03:52 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 5CB0D40221
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 03:03:52 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id OchnSB1v-ZOF
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 03:03:50 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 561FC4020A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 29 Jun 2021 03:03:50 +0000 (UTC)
X-IronPort-AV: E=McAfee;i="6200,9189,10029"; a="208112832"
X-IronPort-AV: E=Sophos;i="5.83,307,1616482800"; d="scan'208";a="208112832"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
 by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 28 Jun 2021 20:03:49 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.83,307,1616482800"; d="scan'208";a="456601083"
Received: from dengjie-mobl1.ccr.corp.intel.com (HELO [10.239.154.58])
 ([10.239.154.58])
 by fmsmga008.fm.intel.com with ESMTP; 28 Jun 2021 20:03:43 -0700
Subject: Re: [PATCH v10] i2c: virtio: add a virtio i2c frontend driver
To: Arnd Bergmann <arnd@arndb.de>, Wolfram Sang <wsa@kernel.org>,
 Linux I2C <linux-i2c@vger.kernel.org>,
 virtualization@lists.linux-foundation.org,
 Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
 Andy Shevchenko <andriy.shevchenko@linux.intel.com>, conghui.chen@intel.com,
 kblaiech@mellanox.com, jarkko.nikula@linux.intel.com,
 Sergey Semin <Sergey.Semin@baikalelectronics.ru>,
 Mike Rapoport <rppt@kernel.org>, loic.poulain@linaro.org,
 Tali Perry <tali.perry1@gmail.com>,
 =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
 Bjorn Andersson <bjorn.andersson@linaro.org>, yu1.wang@intel.com,
 shuo.a.liu@intel.com, Viresh Kumar <viresh.kumar@linaro.org>,
 Stefan Hajnoczi <stefanha@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>
References: <226a8d5663b7bb6f5d06ede7701eedb18d1bafa1.1616493817.git.jie.deng@intel.com>
 <YNmK0MP5ffQpiipt@ninjato>
 <CAK8P3a2qrfhyfZA-8qPVQ252tZXSBKVT==GigJMVvX5_XLPrCQ@mail.gmail.com>
From: Jie Deng <jie.deng@intel.com>
Message-ID: <cdadf700-921b-7c61-210d-7aad355a3871@intel.com>
Date: Tue, 29 Jun 2021 11:03:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Firefox/78.0 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <CAK8P3a2qrfhyfZA-8qPVQ252tZXSBKVT==GigJMVvX5_XLPrCQ@mail.gmail.com>
Content-Language: en-US
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

T24gMjAyMS82LzI4IDE3OjAxLCBBcm5kIEJlcmdtYW5uIHdyb3RlOgoKPiBPbiBNb24sIEp1biAy
OCwgMjAyMSBhdCAxMDozOSBBTSBXb2xmcmFtIFNhbmcgPHdzYUBrZXJuZWwub3JnPiB3cm90ZToK
Pj4gc29ycnkgZm9yIHRoZSBsb25nIGRlbGF5LiBJIGFtIG5vdCBmYW1pbGlhciB3aXRoIFZGSU8s
IHNvIEkgaGFkIHRvIGRpdmUKPj4gaW50byB0aGUgdG9waWMgYSBsaXR0bGUgZmlyc3QuIEkgYW0g
c3RpbGwgbm90IHNlZWluZyB0aHJvdWdoIGl0Cj4+IGNvbXBsZXRlbHksIHNvIEkgaGF2ZSB2ZXJ5
IGhpZ2gtbGV2ZWwgcXVlc3Rpb25zIGZpcnN0Lgo+IFlvdSBwcm9iYWJseSBrbm93IHRoaXMgYWxy
ZWFkeSwgYnV0IGp1c3QgaW4gY2FzZSBmb3IgY2xhcmlmaWNhdGlvbgo+IHRoZXNlIGFyZSB0d28g
ZGlmZmVyZW50IHRoaW5nczoKPgo+IFZGSU86IGtlcm5lbCBmZWF0dXJlIHRvIG1ha2UgcmF3ICh1
c3VhbGx5IFBDSSkgZGV2aWNlcyBhdmFpbGFibGUKPiAgICAgICAgICAgICB0byB1c2VyIHNwYWNl
IGRyaXZlcnMgYW5kIHZpcnR1YWwgbWFjaGluZXMgZnJvbSBhIGtlcm5lbAo+ICAgICAgICAgICAg
IHJ1bm5pbmcgb24gYmFyZSBtZXRhbC4KPgo+IHZpcnRpbzogdHJhbnNwb3J0IHByb3RvY29sIGZv
ciBpbXBsZW1lbnRpbmcgYXJiaXRyYXJ5IHBhcmF2aXJ0dWFsaXplZAo+ICAgICAgICAgICAgZHJp
dmVycyBpbiAodXN1YWxseSkgYSB2aXJ0dWFsIG1hY2hpbmUgZ3Vlc3Qgd2l0aG91dCBnaXZpbmcg
dGhlCj4gICAgICAgICAgICBndWVzdCBhY2Nlc3MgdG8gaGFyZHdhcmUgcmVnaXN0ZXJzLgo+ClRo
YW5rcyBBcm5kIGZvciBjbGFyaWZpY2F0aW9uLgoKTGV0IG1lIGFkZCBzb21lIG1vcmU6CgoKVGhl
IG5hdGl2ZSBtb2RlbCBpcyBhcyBmb2xsb3dzOiBhIHNwZWNpZmljIG5hdGl2ZSBJMkMgZHJpdmVy
IG9wZXJhdGVzIGEgCnNwZWNpZmljIGhhcmR3YXJlLgoKQSBzcGVjaWZpYyBuYXRpdmUgSTJDIGRy
aXZlcsKgIDwtLT4gQSBzcGVjaWZpYyBoYXJkd2FyZQoKClRoZSB2aXJ0aW8gcGFyYXZpcnR1YWxp
emVkIG1vZGVsIGlzIHNvbWV0aGluZyBsaWtlOgoKdmlydGlvLWkyYyA8LS0+IHZpcnRpbyBJMkMg
aW50ZXJmYWNlcyA8LS0+IHZpcnRpby1iYWNrZW5kIDwtLT4gUmVhbCBoYXJkd2FyZQoKdmlydGlv
LWkyYzogaXMgdGhpcyBkcml2ZXIsIHRoZSBmcm9udGVuZCBkcml2ZXIuCgp2aXJ0aW8gSTJDIGlu
dGVyZmFjZXM6IHdoaWNoIGFyZSBkZXNjcmliZWQgaW4gdGhlIHNwZWNpZmljYXRpb24uCgpodHRw
czovL3Jhdy5naXRodWJ1c2VyY29udGVudC5jb20vb2FzaXMtdGNzL3ZpcnRpby1zcGVjL21hc3Rl
ci92aXJ0aW8taTJjLnRleC4KCiDCoMKgwqAgSSBoYWQgdHJpZWQgdG8gbWlycm9yIExpbnV4IEky
QyBpbnRlcmZhY2VzIChsaWtlICJpMmNfbXNnIikgaW50byAKdmlydGlvIEkyQyBpbnRlcmZhY2Ug
ZGlyZWN0bHkuIEJ1dAoKIMKgwqDCoCB3aGVuIEkgd2FzIGRvaW5nIHVwc3RyZWFtIGZvciB0aGlz
IHNwZWNpZmljYXRpb24sIEkgdW5kZXJzdG9vZCB0aGUgCnZpcnRpbyBUQyBoYWQgdGhlIGRlc2ln
biBwaGlsb3NvcGh5CgogwqDCoMKgICJWSVJUSU8gZGV2aWNlcyBhcmUgbm90IHNwZWNpZmljIHRv
IExpbnV4IHNvIHRoZSBzcGVjcyBkZXNpZ24gCnNob3VsZCBhdm9pZCB0aGUgbGltaXRhdGlvbnMg
b2YgdGhlCgogwqDCoMKgIGN1cnJlbnQgTGludXggZHJpdmVyIGJlaGF2aW9yLiIgU28gd2UgcmVk
ZWZpbmVkIGEgbWluaW11bSB2aXJ0aW8gCkkyQyBpbnRlcmZhY2VzIHRvIG1ha2UgYSB3b3JraW5n
IFBPQy4KCiDCoMKgwqAgYW5kIHdlIG1heSBleHRlbmQgaXQgaW4gdGhlIGZ1dHVyZSBhY2NvcmRp
bmcgdG8gdGhlIG5lZWQuCgp2aXJ0aW8tYmFja2VuZDogdGhlIGJhY2tlbmQgZHJpdmVyIGNvbW11
bmljYXRlIHdpdGggdmlydGlvLWkyYyBieSAKZm9sbG93aW5nIHZpcnRpbyBJMkMgaW50ZXJmYWNl
cyBzcGVjcy4KCiDCoMKgwqDCoCBUaGUgYXJlIGFscmVhZHkgdHdvIGJhY2tlbmQgZHJpdmVycyBk
ZXZlbG9wZWQgYnkgVmlyZXNoLCBvbmUgaW4gClFFTVUsIGFub3RoZXIgaW4gcnVzdC12bW0uCgog
wqDCoMKgwqAgMS4gdmhvc3QtdXNlcjogCmh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL3FlbXUtZGV2
ZWwvY292ZXIuMTYxNzI3ODM5NS5naXQudmlyZXNoLmt1bWFyQGxpbmFyby5vcmcvdC8jbTNiNTA0
NGJhZDk3NjliMTcwZjUwNWU2M2JkMDgxZWIyN2NlZjhkYjIKCiDCoMKgwqDCoCAyLiBydXN0LXZt
bSBJMkMgYmFja2VuZDogCmh0dHBzOi8vZ2l0aHViLmNvbS9ydXN0LXZtbS92aG9zdC1kZXZpY2Uv
cHVsbC8xCgoKUmVnYXJkcywKCkppZQoKCgoKCgoKX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxp
emF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3Vu
ZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
