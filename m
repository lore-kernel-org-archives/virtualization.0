Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B3E2C433EF
	for <virtualization@archiver.kernel.org>; Mon, 13 Dec 2021 03:03:02 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2FFE982CAC;
	Mon, 13 Dec 2021 03:03:02 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id FYaSg3Bhk5u6; Mon, 13 Dec 2021 03:03:01 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 9F0D285A0E;
	Mon, 13 Dec 2021 03:03:00 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6BBE9C002F;
	Mon, 13 Dec 2021 03:03:00 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 872C5C0012
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 03:02:59 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 6E157400E5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 03:02:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 9Hz4KREgXTYs
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 03:02:58 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 0EA534009F
 for <virtualization@lists.linux-foundation.org>;
 Mon, 13 Dec 2021 03:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1639364576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=nxOabwkEindQZF6MGwQBuVfsE6zoaQZTzHZYhX63BQo=;
 b=JTkZpGsBizPlneVTpg2ImgckKmoF/0oFL4JC1Hyc99B5hUWVdsTMCLNOQoAyuQbyQkzh1l
 88Qw+UjXlXwOiD69nkb18r7f3EXyhuE/Rv7gF2NrIHH8yh7QhWT5WympLG2K/7fFu1k8E6
 vRCo8kCMCFyMfp10aTnz1uQ6yBHOw7A=
Received: from mail-lf1-f69.google.com (mail-lf1-f69.google.com
 [209.85.167.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-298-K1D3389aMO-JHh-dPWUOQQ-1; Sun, 12 Dec 2021 22:02:52 -0500
X-MC-Unique: K1D3389aMO-JHh-dPWUOQQ-1
Received: by mail-lf1-f69.google.com with SMTP id
 bq6-20020a056512150600b0041bf41f5437so6899647lfb.17
 for <virtualization@lists.linux-foundation.org>;
 Sun, 12 Dec 2021 19:02:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:mime-version:references:in-reply-to:from:date
 :message-id:subject:to:cc:content-transfer-encoding;
 bh=nxOabwkEindQZF6MGwQBuVfsE6zoaQZTzHZYhX63BQo=;
 b=34GnzVsUIdOInFIOSO+NvujDm+joVmlFrka1Ms/YVEvwRshQESzhGR4RvnEQIitG0n
 6K+AD8CZ/9dsB61ftwqnY1wUsKqrWSOaPou9SGN6i/7aPnr+SW2jdwaDN5grd1/euTwT
 W97fwK6a1dm8CRR2VnE95uQkKJlOdomLaQoNONzUIC7+dKrjy+VXt4bVJrDa2BhVOBIe
 t/3YlXp0hB2HQsdZyFVOd3xM7MKziWixF99/p1D/9IaDPI6v64daKywNzYFV1d5X0UKZ
 mKfLkDzeCpk+mirgBegIQv2lIi+29JP9V6M+hykX5kzpIYkD1xAS6SZeTePdrfPi9Ye1
 XHkg==
X-Gm-Message-State: AOAM532eKx5FzAn4uvZ2S6CrOZ4Bs50Aq6ttcG2IjA0ZaSsfUTlClegh
 2DO9WoDn6dT8VseDpEns4ntc/niEGA3rXRlsepwEC0QTDUl0/WYNEwiWuOjg44vMrjg7+170u4A
 +Y78l+ZYQlWDf+5LKCOr23eHKU5pPYveAkJXSygwKSNbv/VtOXwuuO9frRw==
X-Received: by 2002:a05:6512:685:: with SMTP id
 t5mr26856502lfe.84.1639364570806; 
 Sun, 12 Dec 2021 19:02:50 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5YjAaU+iCN3crQtYXKFT1QFcD9uiG0DVl+ekuAMuR8f5VXyCMPs5sUjKsAPXinXqyC3IjWG913Ka1GX6K2p4=
X-Received: by 2002:a05:6512:685:: with SMTP id
 t5mr26856481lfe.84.1639364570566; 
 Sun, 12 Dec 2021 19:02:50 -0800 (PST)
MIME-Version: 1.0
References: <fae0bae7-e4cd-a3aa-57fe-d707df99b634@redhat.com>
 <20210223082536-mutt-send-email-mst@kernel.org>
 <3ff5fd23-1db0-2f95-4cf9-711ef403fb62@oracle.com>
 <20210224000057-mutt-send-email-mst@kernel.org>
 <52836a63-4e00-ff58-50fb-9f450ce968d7@oracle.com>
 <20210228163031-mutt-send-email-mst@kernel.org>
 <2cb51a6d-afa0-7cd1-d6f2-6b153186eaca@redhat.com>
 <20210302043419-mutt-send-email-mst@kernel.org>
 <178f8ea7-cebd-0e81-3dc7-10a058d22c07@redhat.com>
 <c9a0932f-a6d7-a9df-38ba-97e50f70c2b2@oracle.com>
 <20211212042311-mutt-send-email-mst@kernel.org>
In-Reply-To: <20211212042311-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Date: Mon, 13 Dec 2021 11:02:39 +0800
Message-ID: <CACGkMEtwWcBNj62Yn_ZSq33N42ZG5yhCcZf=eQZ_AdVgJhEjEA@mail.gmail.com>
Subject: Re: vdpa legacy guest support (was Re: [PATCH] vdpa/mlx5:
 set_features should allow reset to zero)
To: "Michael S. Tsirkin" <mst@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Si-Wei Liu <si-wei.liu@oracle.com>, netdev <netdev@vger.kernel.org>,
 Eli Cohen <elic@nvidia.com>, linux-kernel <linux-kernel@vger.kernel.org>,
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

T24gU3VuLCBEZWMgMTIsIDIwMjEgYXQgNToyNiBQTSBNaWNoYWVsIFMuIFRzaXJraW4gPG1zdEBy
ZWRoYXQuY29tPiB3cm90ZToKPgo+IE9uIEZyaSwgRGVjIDEwLCAyMDIxIGF0IDA1OjQ0OjE1UE0g
LTA4MDAsIFNpLVdlaSBMaXUgd3JvdGU6Cj4gPiBTb3JyeSBmb3IgcmV2aXZpbmcgdGhpcyBhbmNp
ZW50IHRocmVhZC4gSSB3YXMga2luZGEgbG9zdCBmb3IgdGhlIGNvbmNsdXNpb24KPiA+IGl0IGVu
ZGVkIHVwIHdpdGguIEkgaGF2ZSB0aGUgZm9sbG93aW5nIHF1ZXN0aW9ucywKPiA+Cj4gPiAxLiBs
ZWdhY3kgZ3Vlc3Qgc3VwcG9ydDogZnJvbSB0aGUgcGFzdCBjb252ZXJzYXRpb25zIGl0IGRvZXNu
J3Qgc2VlbSB0aGUKPiA+IHN1cHBvcnQgd2lsbCBiZSBjb21wbGV0ZWx5IGRyb3BwZWQgZnJvbSB0
aGUgdGFibGUsIGlzIG15IHVuZGVyc3RhbmRpbmcKPiA+IGNvcnJlY3Q/IEFjdHVhbGx5IHdlJ3Jl
IGludGVyZXN0ZWQgaW4gc3VwcG9ydGluZyB2aXJ0aW8gdjAuOTUgZ3Vlc3QgZm9yIHg4NiwKPiA+
IHdoaWNoIGlzIGJhY2tlZCBieSB0aGUgc3BlYyBhdAo+ID4gaHR0cHM6Ly9vemxhYnMub3JnL35y
dXN0eS92aXJ0aW8tc3BlYy92aXJ0aW8tMC45LjUucGRmLiBUaG91Z2ggSSdtIG5vdCBzdXJlCj4g
PiBpZiB0aGVyZSdzIHJlcXVlc3QvbmVlZCB0byBzdXBwb3J0IHdpbGRlciBsZWdhY3kgdmlydGlv
IHZlcnNpb25zIGVhcmxpZXIKPiA+IGJleW9uZC4KPgo+IEkgcGVyc29uYWxseSBmZWVsIGl0J3Mg
bGVzcyB3b3JrIHRvIGFkZCBpbiBrZXJuZWwgdGhhbiB0cnkgdG8KPiB3b3JrIGFyb3VuZCBpdCBp
biB1c2Vyc3BhY2UuIEphc29uIGZlZWxzIGRpZmZlcmVudGx5Lgo+IE1heWJlIHBvc3QgdGhlIHBh
dGNoZXMgYW5kIHRoaXMgd2lsbCBwcm92ZSB0byBKYXNvbiBpdCdzIG5vdAo+IHRvbyB0ZXJyaWJs
ZT8KClRoYXQncyBvbmUgd2F5LCBvdGhlciB0aGFuIHRoZSBjb25maWcgYWNjZXNzIGJlZm9yZSBz
ZXR0aW5nIGZlYXR1cmVzLAp3ZSBuZWVkIHRvIGRlYWwgd2l0aCBvdGhlciBzdHVmZnM6CgoxKSBW
SVJUSU9fRl9PUkRFUl9QTEFURk9STQoyKSB0aGVyZSBjb3VsZCBiZSBhIHBhcmVudCBkZXZpY2Ug
dGhhdCBvbmx5IHN1cHBvcnQgMS4wIGRldmljZQoKQW5kIGEgbG90IG9mIG90aGVyIHN0dWZmIHN1
bW1hcml6ZWQgaW4gc3BlYyA3LjQgd2hpY2ggc2VlbXMgbm90IGFuCmVhc3kgdGFzay4gVmFyaW91
cyB2RFBBIHBhcmVudCBkcml2ZXJzIHdlcmUgd3JpdHRlbiB1bmRlciB0aGUKYXNzdW1wdGlvbiB0
aGF0IG9ubHkgbW9kZXJuIGRldmljZXMgYXJlIHN1cHBvcnRlZC4KClRoYW5rcwoKPgo+ID4gMi4g
c3VwcG9zZSBzb21lIGZvcm0gb2YgbGVnYWN5IGd1ZXN0IHN1cHBvcnQgbmVlZHMgdG8gYmUgdGhl
cmUsIGhvdyBkbyB3ZQo+ID4gZGVhbCB3aXRoIHRoZSBib2d1cyBhc3N1bXB0aW9uIGJlbG93IGlu
IHZkcGFfZ2V0X2NvbmZpZygpIGluIHRoZSBzaG9ydCB0ZXJtPwo+ID4gSXQgbG9va3Mgb25lIG9m
IHRoZSBpbnR1aXRpdmUgZml4IGlzIHRvIG1vdmUgdGhlIHZkcGFfc2V0X2ZlYXR1cmVzIGNhbGwg
b3V0Cj4gPiBvZiB2ZHBhX2dldF9jb25maWcoKSB0byB2ZHBhX3NldF9jb25maWcoKS4KPiA+Cj4g
PiAgICAgICAgIC8qCj4gPiAgICAgICAgICAqIENvbmZpZyBhY2Nlc3NlcyBhcmVuJ3Qgc3VwcG9z
ZWQgdG8gdHJpZ2dlciBiZWZvcmUgZmVhdHVyZXMgYXJlCj4gPiBzZXQuCj4gPiAgICAgICAgICAq
IElmIGl0IGRvZXMgaGFwcGVuIHdlIGFzc3VtZSBhIGxlZ2FjeSBndWVzdC4KPiA+ICAgICAgICAg
ICovCj4gPiAgICAgICAgIGlmICghdmRldi0+ZmVhdHVyZXNfdmFsaWQpCj4gPiAgICAgICAgICAg
ICAgICAgdmRwYV9zZXRfZmVhdHVyZXModmRldiwgMCk7Cj4gPiAgICAgICAgIG9wcy0+Z2V0X2Nv
bmZpZyh2ZGV2LCBvZmZzZXQsIGJ1ZiwgbGVuKTsKPiA+Cj4gPiBJIGNhbiBwb3N0IGEgcGF0Y2gg
dG8gZml4IDIpIGlmIHRoZXJlJ3MgY29uc2Vuc3VzIGFscmVhZHkgcmVhY2hlZC4KPiA+Cj4gPiBU
aGFua3MsCj4gPiAtU2l3ZWkKPgo+IEknbSBub3Qgc3VyZSBob3cgaW1wb3J0YW50IGl0IGlzIHRv
IGNoYW5nZSB0aGF0Lgo+IEluIGFueSBjYXNlIGl0IG9ubHkgYWZmZWN0cyB0cmFuc2l0aW9uYWwg
ZGV2aWNlcywgcmlnaHQ/Cj4gTGVnYWN5IG9ubHkgc2hvdWxkIG5vdCBjYXJlIC4uLgo+Cj4KPiA+
IE9uIDMvMi8yMDIxIDI6NTMgQU0sIEphc29uIFdhbmcgd3JvdGU6Cj4gPiA+Cj4gPiA+IE9uIDIw
MjEvMy8yIDU6NDcg5LiL5Y2ILCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+ID4gT24g
TW9uLCBNYXIgMDEsIDIwMjEgYXQgMTE6NTY6NTBBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90ZToK
PiA+ID4gPiA+IE9uIDIwMjEvMy8xIDU6MzQg5LiK5Y2ILCBNaWNoYWVsIFMuIFRzaXJraW4gd3Jv
dGU6Cj4gPiA+ID4gPiA+IE9uIFdlZCwgRmViIDI0LCAyMDIxIGF0IDEwOjI0OjQxQU0gLTA4MDAs
IFNpLVdlaSBMaXUgd3JvdGU6Cj4gPiA+ID4gPiA+ID4gPiBEZXRlY3RpbmcgaXQgaXNuJ3QgZW5v
dWdoIHRob3VnaCwgd2Ugd2lsbCBuZWVkIGEgbmV3IGlvY3RsIHRvIG5vdGlmeQo+ID4gPiA+ID4g
PiA+ID4gdGhlIGtlcm5lbCB0aGF0IGl0J3MgYSBsZWdhY3kgZ3Vlc3QuIFVnaCA6KAo+ID4gPiA+
ID4gPiA+IFdlbGwsIGFsdGhvdWdoIEkgdGhpbmsgYWRkaW5nIGFuIGlvY3RsIGlzIGRvYWJsZSwg
bWF5IEkKPiA+ID4gPiA+ID4gPiBrbm93IHdoYXQgdGhlIHVzZQo+ID4gPiA+ID4gPiA+IGNhc2Ug
dGhlcmUgd2lsbCBiZSBmb3Iga2VybmVsIHRvIGxldmVyYWdlIHN1Y2ggaW5mbwo+ID4gPiA+ID4g
PiA+IGRpcmVjdGx5PyBJcyB0aGVyZSBhCj4gPiA+ID4gPiA+ID4gY2FzZSBRRU1VIGNhbid0IGRv
IHdpdGggZGVkaWNhdGUgaW9jdGxzIGxhdGVyIGlmIHRoZXJlJ3MgaW5kZWVkCj4gPiA+ID4gPiA+
ID4gZGlmZmVyZW50aWF0aW9uIChsZWdhY3kgdi5zLiBtb2Rlcm4pIG5lZWRlZD8KPiA+ID4gPiA+
ID4gQlRXIGEgZ29vZCBBUEkgY291bGQgYmUKPiA+ID4gPiA+ID4KPiA+ID4gPiA+ID4gI2RlZmlu
ZSBWSE9TVF9TRVRfRU5ESUFOIF9JT1coVkhPU1RfVklSVElPLCA/LCBpbnQpCj4gPiA+ID4gPiA+
ICNkZWZpbmUgVkhPU1RfR0VUX0VORElBTiBfSU9XKFZIT1NUX1ZJUlRJTywgPywgaW50KQo+ID4g
PiA+ID4gPgo+ID4gPiA+ID4gPiB3ZSBkaWQgaXQgcGVyIHZyaW5nIGJ1dCBtYXliZSB0aGF0IHdh
cyBhIG1pc3Rha2UgLi4uCj4gPiA+ID4gPgo+ID4gPiA+ID4gQWN0dWFsbHksIEkgd29uZGVyIHdo
ZXRoZXIgaXQncyBnb29kIHRpbWUgdG8ganVzdCBub3Qgc3VwcG9ydAo+ID4gPiA+ID4gbGVnYWN5
IGRyaXZlcgo+ID4gPiA+ID4gZm9yIHZEUEEuIENvbnNpZGVyOgo+ID4gPiA+ID4KPiA+ID4gPiA+
IDEpIEl0J3MgZGVmaW5pdGlvbiBpcyBuby1ub3JtYXRpdmUKPiA+ID4gPiA+IDIpIEEgbG90IG9m
IGJ1ZHJlbiBvZiBjb2Rlcwo+ID4gPiA+ID4KPiA+ID4gPiA+IFNvIHFlbXUgY2FuIHN0aWxsIHBy
ZXNlbnQgdGhlIGxlZ2FjeSBkZXZpY2Ugc2luY2UgdGhlIGNvbmZpZwo+ID4gPiA+ID4gc3BhY2Ug
b3Igb3RoZXIKPiA+ID4gPiA+IHN0dWZmcyB0aGF0IGlzIHByZXNlbnRlZCBieSB2aG9zdC12RFBB
IGlzIG5vdCBleHBlY3RlZCB0byBiZQo+ID4gPiA+ID4gYWNjZXNzZWQgYnkKPiA+ID4gPiA+IGd1
ZXN0IGRpcmVjdGx5LiBRZW11IGNhbiBkbyB0aGUgZW5kaWFuIGNvbnZlcnNpb24gd2hlbiBuZWNl
c3NhcnkKPiA+ID4gPiA+IGluIHRoaXMKPiA+ID4gPiA+IGNhc2U/Cj4gPiA+ID4gPgo+ID4gPiA+
ID4gVGhhbmtzCj4gPiA+ID4gPgo+ID4gPiA+IE92ZXJhbGwgSSB3b3VsZCBiZSBmaW5lIHdpdGgg
dGhpcyBhcHByb2FjaCBidXQgd2UgbmVlZCB0byBhdm9pZCBicmVha2luZwo+ID4gPiA+IHdvcmtp
bmcgdXNlcnNwYWNlLCBxZW11IHJlbGVhc2VzIHdpdGggdmRwYSBzdXBwb3J0IGFyZSBvdXQgdGhl
cmUgYW5kCj4gPiA+ID4gc2VlbSB0byB3b3JrIGZvciBwZW9wbGUuIEFueSBjaGFuZ2VzIG5lZWQg
dG8gdGFrZSB0aGF0IGludG8gYWNjb3VudAo+ID4gPiA+IGFuZCBkb2N1bWVudCBjb21wYXRpYmls
aXR5IGNvbmNlcm5zLgo+ID4gPgo+ID4gPgo+ID4gPiBBZ3JlZSwgbGV0IG1lIGNoZWNrLgo+ID4g
Pgo+ID4gPgo+ID4gPiA+ICAgSSBub3RlIHRoYXQgYW55IGhhcmR3YXJlCj4gPiA+ID4gaW1wbGVt
ZW50YXRpb24gaXMgYWxyZWFkeSBicm9rZW4gZm9yIGxlZ2FjeSBleGNlcHQgb24gcGxhdGZvcm1z
IHdpdGgKPiA+ID4gPiBzdHJvbmcgb3JkZXJpbmcgd2hpY2ggbWlnaHQgYmUgaGVscGZ1bCBpbiBy
ZWR1Y2luZyB0aGUgc2NvcGUuCj4gPiA+Cj4gPiA+Cj4gPiA+IFllcy4KPiA+ID4KPiA+ID4gVGhh
bmtzCj4gPiA+Cj4gPiA+Cj4gPiA+ID4KPiA+ID4gPgo+ID4gPgo+CgpfX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxp
c3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0
cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
