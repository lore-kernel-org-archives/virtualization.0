Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B696C433FE
	for <virtualization@archiver.kernel.org>; Thu, 10 Nov 2022 09:27:20 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id B29AD4019E;
	Thu, 10 Nov 2022 09:27:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B29AD4019E
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=PjyoqZRy
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id AJcYMZM1cGy1; Thu, 10 Nov 2022 09:27:18 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 1872D400BF;
	Thu, 10 Nov 2022 09:27:18 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 1872D400BF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id D9CE4C0032;
	Thu, 10 Nov 2022 09:27:17 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id EEA76C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 09:27:15 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id B38704019B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 09:27:15 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org B38704019B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id dfAz4Sq4dvKd
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 09:27:15 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org D6CE3400BF
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
 by smtp2.osuosl.org (Postfix) with ESMTPS id D6CE3400BF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 09:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1668072434; x=1699608434;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=DjFcL5BKDS3lx6Tya3zdhgH6ECLByTkf5CQ6PVKRDKk=;
 b=PjyoqZRyMKHXRXcFlDBiWh5ofRrL4jf3UGQ4ln2OhQIYoCuu5A41Efj5
 9KkYJAjc3G1guDnCQ5ej/V8VwHr0VQ+Rg6GsuO1VtyCeC0ozTp5QSNXgS
 xb7B71WHKc1KsMbsewR5yO71+6aE7ulplt0EF2kvt6SLb2kreoa4c98WT
 6DG67xsq0UX91RpC7OeeJ+iOE6ck+hid77sHkT+2/2jK+9JVGlD9AcIXp
 Vp4FMJeL4y2nxSQr8I/dzYu2YzvFkoSpJAZWJO6o/kR/Af5xJPEcmnB70
 WMwN5TswSy1s4NiOdyN6rC/IgVWLn8RKm0MsHAecvEJlSXrTIdH59TD/U Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="311264384"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; d="scan'208";a="311264384"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
 by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2022 01:27:14 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="706077499"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; d="scan'208";a="706077499"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.249.171.70])
 ([10.249.171.70])
 by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2022 01:27:12 -0800
Message-ID: <604ae2ce-5e00-3d08-fcfb-0d3fd3c505a3@intel.com>
Date: Thu, 10 Nov 2022 17:27:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Firefox/102.0 Thunderbird/102.4.1
Subject: Re: [PATCH 0/4] ifcvf/vDPA implement features provisioning
Content-Language: en-US
To: Jason Wang <jasowang@redhat.com>
References: <20221107093345.121648-1-lingshan.zhu@intel.com>
 <CACGkMEs9af1E1pLd2t8E71YBPF=rHkhfN8qO9_3=x6HVaCMAxg@mail.gmail.com>
 <0b15591f-9e49-6383-65eb-6673423f81ec@intel.com>
 <CACGkMEujqOFHv7QATWgYo=SdAKef5jQXi2-YksjgT-hxEgKNDQ@mail.gmail.com>
 <80cdd80a-16fa-ac75-0a89-5729b846efed@intel.com>
 <CACGkMEu-5TbA3Ky2qgn-ivfhgfJ2b12mDJgq8iNgHce8qu3ApA@mail.gmail.com>
 <03657084-98ab-93bc-614a-e6cc7297d93e@intel.com>
 <d59c311f-ba9f-4c00-28f8-c50e099adb9f@redhat.com>
 <3286ad00-e432-da69-a041-6a3032494470@intel.com>
 <CACGkMEuca97Cv+XuKxmHHHgAQYsayZvJRtpONCCqcEE8qMu5Kw@mail.gmail.com>
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <CACGkMEuca97Cv+XuKxmHHHgAQYsayZvJRtpONCCqcEE8qMu5Kw@mail.gmail.com>
Cc: piotr.uminski@intel.com, hang.yuan@intel.com,
 virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, mst@redhat.com
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

CgpPbiAxMS8xMC8yMDIyIDU6MTMgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4gT24gVGh1LCBOb3Yg
MTAsIDIwMjIgYXQgNDo1OSBQTSBaaHUsIExpbmdzaGFuIDxsaW5nc2hhbi56aHVAaW50ZWwuY29t
PiB3cm90ZToKPj4KPj4KPj4gT24gMTEvMTAvMjAyMiAyOjI5IFBNLCBKYXNvbiBXYW5nIHdyb3Rl
Ogo+Pj4g5ZyoIDIwMjIvMTEvMTAgMTQ6MjAsIFpodSwgTGluZ3NoYW4g5YaZ6YGTOgo+Pj4+Cj4+
Pj4gT24gMTEvMTAvMjAyMiAxMTo0OSBBTSwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4gT24gV2Vk
LCBOb3YgOSwgMjAyMiBhdCA1OjA2IFBNIFpodSwgTGluZ3NoYW4KPj4+Pj4gPGxpbmdzaGFuLnpo
dUBpbnRlbC5jb20+IHdyb3RlOgo+Pj4+Pj4KPj4+Pj4+IE9uIDExLzkvMjAyMiA0OjU5IFBNLCBK
YXNvbiBXYW5nIHdyb3RlOgo+Pj4+Pj4+IE9uIFdlZCwgTm92IDksIDIwMjIgYXQgNDoxNCBQTSBa
aHUsIExpbmdzaGFuCj4+Pj4+Pj4gPGxpbmdzaGFuLnpodUBpbnRlbC5jb20+IHdyb3RlOgo+Pj4+
Pj4+PiBPbiAxMS85LzIwMjIgMjo1MSBQTSwgSmFzb24gV2FuZyB3cm90ZToKPj4+Pj4+Pj4+IE9u
IE1vbiwgTm92IDcsIDIwMjIgYXQgNTo0MiBQTSBaaHUgTGluZ3NoYW4KPj4+Pj4+Pj4+IDxsaW5n
c2hhbi56aHVAaW50ZWwuY29tPiB3cm90ZToKPj4+Pj4+Pj4+PiBUaGlzIHNlcmllcyBpbXBsZW1l
bnRzIGZlYXR1cmVzIHByb3Zpc2lvbmluZyBmb3IgaWZjdmYuCj4+Pj4+Pj4+Pj4gQnkgYXBwbHlp
bmcgdGhpcyBzZXJpZXMsIHdlIGFsbG93IHVzZXJzcGFjZSB0byBjcmVhdGUKPj4+Pj4+Pj4+PiBh
IHZEUEEgZGV2aWNlIHdpdGggc2VsZWN0ZWQgKG1hbmFnZW1lbnQgZGV2aWNlIHN1cHBvcnRlZCkK
Pj4+Pj4+Pj4+PiBmZWF0dXJlIGJpdHMgYW5kIG1hc2sgb3V0IG90aGVycy4KPj4+Pj4+Pj4+IEkg
ZG9uJ3Qgc2VlIGEgZGlyZWN0IHJlbGF0aW9uc2hpcCBiZXR3ZWVuIHRoZSBmaXJzdCAzIGFuZCB0
aGUgbGFzdC4KPj4+Pj4+Pj4+IE1heWJlIHlvdSBjYW4gc3RhdGUgdGhlIHJlYXNvbiB3aHkgdGhl
IHJlc3RydWN0dXJlIGlzIGEgbXVzdCBmb3IKPj4+Pj4+Pj4+IHRoZQo+Pj4+Pj4+Pj4gZmVhdHVy
ZSBwcm92aXNpb25pbmcuIE90aGVyd2lzZSwgd2UnZCBiZXR0ZXIgc3BsaXQgdGhlIHNlcmllcy4K
Pj4+Pj4+Pj4gV2hlbiBpbnRyb2R1Y2luZyBmZWF0dXJlcyBwcm92aXNpb25pbmcgYWJpbGl0eSB0
byBpZmN2ZiwgdGhlcmUgaXMKPj4+Pj4+Pj4gYSBuZWVkCj4+Pj4+Pj4+IHRvIHJlLWNyZWF0ZSB2
RFBBIGRldmljZXMKPj4+Pj4+Pj4gb24gYSBWRiB3aXRoIGRpZmZlcmVudCBmZWF0dXJlIGJpdHMu
Cj4+Pj4+Pj4gVGhpcyBzZWVtcyBhIHJlcXVpcmVtZW50IGV2ZW4gd2l0aG91dCBmZWF0dXJlIHBy
b3Zpc2lvbmluZz8gRGV2aWNlCj4+Pj4+Pj4gY291bGQgYmUgZGVsZXRlZCBmcm9tIHRoZSBtYW5h
Z2VtZW50IGRldmljZSBhbnlob3cuCj4+Pj4+PiBZZXMsIHdlIG5lZWQgdGhpcyB0byBkZWxldGUg
YW5kIHJlLWNyZWF0ZSBhIHZEUEEgZGV2aWNlLgo+Pj4+PiBJIHdvbmRlciBpZiB3ZSBuZWVkIHNv
bWV0aGluZyB0aGF0IHdvcmtzIGZvciAtc3RhYmxlLgo+Pj4+IEkgY2FuIGFkZCBhIGZpeCB0YWcs
IHNvIHRoZXNlIHRocmVlIHBhdGNoZXMgY291bGQgYXBwbHkgdG8gc3RhYmxlCj4+Pgo+Pj4gSXQn
cyB0b28gaHVnZSBmb3IgLXN0YWJsZS4KPj4+Cj4+Pgo+Pj4+PiBBRkFJSywgd2UgY2FuIG1vdmUg
dGhlIHZkcGFfYWxsb2NfZGV2aWNlKCkgZnJvbSBwcm9iZSgpIHRvIGRldl9hZGQoKQo+Pj4+PiBh
bmQgaXQgc2VlbXMgdG8gd29yaz8KPj4+PiBZZXMgYW5kIHRoaXMgaXMgZG9uZSBpbiB0aGlzIHNl
cmllcyBhbmQgdGhhdCdzIHdoeSB3ZSBuZWVkIHRoZXNlCj4+Pj4gcmVmYWN0b3JpbmcgY29kZS4K
Pj4+Cj4+PiBJIG1lYW50IHRoZXJlJ3MgcHJvYmFibHkgbm8gbmVlZCB0byBjaGFuZ2UgdGhlIGFz
c29jaWF0aW9uIG9mIGV4aXN0aW5nCj4+PiBzdHJ1Y3R1cmUgYnV0IGp1c3QgZG8gdGhlIGFsbG9j
YXRpb24gaW4gZGV2X2FkZCgpLCB0aGVuIHdlIHdpbGwgaGF2ZSBhCj4+PiBwYXRjaCB3aXRoIG11
Y2ggbW9yZSBzbWFsbCBjaGFuZ2VzZXQgdGhhdCBmaXQgZm9yIC1zdGFibGUuCj4+IFBhdGNoIDEo
aWZjdmZfYmFzZSBvbmx5IHdvcmsgb24gaWZjdmZfaHcpIGFuZCBwYXRjaCAyKGlycSBmdW5jdGlv
bnMgb25seQo+PiB3b3JrIG9uIGlmY3ZmX2h3KSBhcmUgbm90IG5lZWRlZCBmb3Igc3RhYmxlLgo+
PiBJIGhhdmUgYWxyZWFkeSBkb25lIHRoaXMgYWxsb2NhdGlvbiBvZiBpZmN2Zl9hZGFwdGVyIHdo
aWNoIGlzIHRoZQo+PiBjb250YWluZXIgb2Ygc3RydWN0IHZkcGFfZGV2aWNlIGluIGRldl9hZGQo
KSBpbiBQYXRjaCAzLCB0aGlzIHNob3VsZCBiZQo+PiBtZXJnZWQgdG8gc3RhYmxlLgo+PiBQYXRj
aCAzIGlzIGh1Z2UgYnV0IG5lY2Vzc2FyeSwgbm90IG9ubHkgYWxsb2NhdGUgaWZjdmZfYWRhcHRl
ciBpbgo+PiBkZXZfYWRkKCksIGl0IGFsc28gcmVmYWN0b3JzIHRoZSBzdHJ1Y3R1cmVzIG9mIGlm
Y3ZmX21nbXRfZGV2IGFuZAo+PiBpZmN2Zl9hZGFwdGVyLAo+PiBiZWNhdXNlIHdlIG5lZWQgdG8g
aW5pdGlhbGl6ZSB0aGUgVkYncyBodyBzdHJ1Y3R1cmUgaWZjdmZfaHcod2hpY2ggd2FzIGEKPj4g
bWVtYmVyIG9mIGlmY3ZmX2FkYXB0ZXIgYnV0IG5vdyBzaG91bGQgYmUgYSBtZW1iZXIgb2YgaWZj
dmZfbWdtdF9kZXYpIGluCj4+IHByb2JlLgo+Pgo+PiBJcyBpdCBzdGlsbCBodWdlPwo+IFRoZW4g
cGxlYXNlIHJlb3JkZXIgdGhlIHBhdGNoZXMsIHN0YWJsZS1rZXJuZWwtcnVsZXMucnN0IHNhaWQ6
Cj4KPiAgIC0gSXQgY2Fubm90IGJlIGJpZ2dlciB0aGFuIDEwMCBsaW5lcywgd2l0aCBjb250ZXh0
Lgo+Cj4gTGV0J3Mgc2VlLgpJdCBpcyBvdmVyIDE4MCBsaW5lcywgc28gbWF5YmUgcmUtb3JkZXJp
bmcgY2FuIG5vdCBoZWxwIGhlcmUsIEkgd2lsbCB0cnkgCnRvIHNwbGl0IHBhdGNoIDMuCgpUaGFu
a3MsClpodSBMaW5nc2hhbgo+Cj4gVGhhbmtzCj4KPj4gVGhhbmtzCj4+PiBUaGFua3MKPj4+Cj4+
Pgo+Pj4+IEJ5IHRoZSB3YXksIGRvIHlvdSBoYXZlIGFueSBjb21tZW50cyB0byB0aGUgcGF0Y2hl
cz8KPj4+Pgo+Pj4+IFRoYW5rcywKPj4+PiBaaHUgTGluZ3NoYW4KPj4+Pj4gVGhhbmtzCj4+Pj4+
Cj4+Pj4+PiBXZSBjcmVhdGUgdkRQQSBkZXZpY2UgZnJvbSBhIFZGLCBzbyB3aXRob3V0IGZlYXR1
cmVzIHByb3Zpc2lvbmluZwo+Pj4+Pj4gcmVxdWlyZW1lbnRzLAo+Pj4+Pj4gd2UgZG9uJ3QgbmVl
ZCB0byByZS1jcmVhdGUgdGhlIHZEUEEgZGV2aWNlLiBCdXQgd2l0aCBmZWF0dXJlcwo+Pj4+Pj4g
cHJvdmlzaW9uaW5nLAo+Pj4+Pj4gaXQgaXMgYSBtdXN0IG5vdy4KPj4+Pj4+Cj4+Pj4+PiBUaGFu
a3MKPj4+Pj4+Cj4+Pj4+Pgo+Pj4+Pj4+IFRoYWtucwo+Pj4+Pj4+Cj4+Pj4+Pj4+IFdoZW4gcmVt
b3ZlIGEgdkRQQSBkZXZpY2UsIHRoZSBjb250YWluZXIgb2Ygc3RydWN0IHZkcGFfZGV2aWNlCj4+
Pj4+Pj4+IChoZXJlIGlzCj4+Pj4+Pj4+IGlmY3ZmX2FkYXB0ZXIpIGlzIGZyZWUtZWQgaW4KPj4+
Pj4+Pj4gZGV2X2RlbCgpIGludGVyZmFjZSwgc28gd2UgbmVlZCB0byBhbGxvY2F0ZSBpZmN2Zl9h
ZGFwdGVyIGluCj4+Pj4+Pj4+IGRldl9hZGQoKQo+Pj4+Pj4+PiB0aGFuIGluIHByb2JlKCkuIFRo
YXQncwo+Pj4+Pj4+PiB3aHkgSSBoYXZlIHJlLWZhY3RvcmVkIHRoZSBhZGFwdGVyL21nbXRfZGV2
IGNvZGUuCj4+Pj4+Pj4+Cj4+Pj4+Pj4+IEZvciByZS1mYWN0b3JpbmcgdGhlIGlycSByZWxhdGVk
IGNvZGUgYW5kIGlmY3ZmX2Jhc2UsIGxldCB0aGVtCj4+Pj4+Pj4+IHdvcmsgb24KPj4+Pj4+Pj4g
c3RydWN0IGlmY3ZmX2h3LCB0aGUKPj4+Pj4+Pj4gcmVhc29uIGlzIHRoYXQgdGhlIGFkYXB0ZXIg
aXMgYWxsb2NhdGVkIGluIGRldl9hZGQoKSwgaWYgd2Ugd2FudAo+Pj4+Pj4+PiB0aGVzZXMKPj4+
Pj4+Pj4gZnVuY3Rpb25zIHRvIHdvcmsKPj4+Pj4+Pj4gYmVmb3JlIGRldl9hZGQoKSwgbGlrZSBp
biBwcm9iZSwgd2UgbmVlZCB0aGVtIHdvcmsgb24gaWZjdmZfaHcKPj4+Pj4+Pj4gdGhhbiB0aGUK
Pj4+Pj4+Pj4gYWRhcHRlci4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gVGhhbmtzCj4+Pj4+Pj4+IFpodSBM
aW5nc2hhbgo+Pj4+Pj4+Pj4gVGhhbmtzCj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IFBsZWFzZSBoZWxw
IHJldmlldwo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gVGhhbmtzCj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+
PiBaaHUgTGluZ3NoYW4gKDQpOgo+Pj4+Pj4+Pj4+ICAgICAgIHZEUEEvaWZjdmY6IGlmY3ZmIGJh
c2UgbGF5ZXIgaW50ZXJmYWNlcyB3b3JrIG9uIHN0cnVjdAo+Pj4+Pj4+Pj4+IGlmY3ZmX2h3Cj4+
Pj4+Pj4+Pj4gICAgICAgdkRQQS9pZmN2ZjogSVJRIGludGVyZmFjZXMgd29yayBvbiBpZmN2Zl9o
dwo+Pj4+Pj4+Pj4+ICAgICAgIHZEUEEvaWZjdmY6IGFsbG9jYXRlIGlmY3ZmX2FkYXB0ZXIgaW4g
ZGV2X2FkZCgpCj4+Pj4+Pj4+Pj4gICAgICAgdkRQQS9pZmN2ZjogaW1wbGVtZW50IGZlYXR1cmVz
IHByb3Zpc2lvbmluZwo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4gICAgICBkcml2ZXJzL3ZkcGEvaWZj
dmYvaWZjdmZfYmFzZS5jIHwgIDMyICsrLS0tLS0KPj4+Pj4+Pj4+PiAgICAgIGRyaXZlcnMvdmRw
YS9pZmN2Zi9pZmN2Zl9iYXNlLmggfCAgMTAgKy0KPj4+Pj4+Pj4+PiAgICAgIGRyaXZlcnMvdmRw
YS9pZmN2Zi9pZmN2Zl9tYWluLmMgfCAxNTYKPj4+Pj4+Pj4+PiArKysrKysrKysrKysrKystLS0t
LS0tLS0tLS0tLS0tLQo+Pj4+Pj4+Pj4+ICAgICAgMyBmaWxlcyBjaGFuZ2VkLCA4OSBpbnNlcnRp
b25zKCspLCAxMDkgZGVsZXRpb25zKC0pCj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+PiAtLQo+Pj4+Pj4+
Pj4+IDIuMzEuMQo+Pj4+Pj4+Pj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
