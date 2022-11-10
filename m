Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8B18C433FE
	for <virtualization@archiver.kernel.org>; Thu, 10 Nov 2022 08:59:01 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 8B818400BF;
	Thu, 10 Nov 2022 08:59:01 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 8B818400BF
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=dW1P0OaA
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id kA89wj2TDeIF; Thu, 10 Nov 2022 08:59:00 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id E4B6E400AF;
	Thu, 10 Nov 2022 08:58:59 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org E4B6E400AF
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B1438C0033;
	Thu, 10 Nov 2022 08:58:59 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C1FA4C002D
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 08:58:58 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 9944F4019B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 08:58:58 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9944F4019B
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ecRfeZ3rTkqV
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 08:58:57 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BA868400AF
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BA868400AF
 for <virtualization@lists.linux-foundation.org>;
 Thu, 10 Nov 2022 08:58:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1668070737; x=1699606737;
 h=message-id:date:mime-version:subject:to:cc:references:
 from:in-reply-to:content-transfer-encoding;
 bh=Taky/eDmY8zE2pNKcx7/mrBZx3iMQ8bamvaFCuUdNdk=;
 b=dW1P0OaA/k6iV8Du2zPEG5enwhAJebIHjhaiI6epknA431eYI3aRGxDf
 HZaQy0kWu8JpoKGaj/SwCVkGuDGqX8kg4nUgtSzR7XAY7/dIB5MKhNUiT
 0SSDYPKcr9uqopi1qYxbkzS6Kpv0m47Z/jLwA/lS1mwwBi+IEg7yEDEOI
 KKiIsT+nWVCH5ExslqJpiY3geDoBmslDdEWk5zomCv29Fi4e+csqfbxWg
 IRcuBewXq8DPVCegmGZ+dMOtyQ4+eNxGebKoob3L3FnU0sYy/0bdBOoRS
 cLYj48lrAfL3LPHxLlKi+Nxj4MVfbUEca6XemaaVO+OCZZ77gX5/1iEzO A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="309973036"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; d="scan'208";a="309973036"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
 by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2022 00:58:57 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10526"; a="811966711"
X-IronPort-AV: E=Sophos;i="5.96,153,1665471600"; d="scan'208";a="811966711"
Received: from lingshan-mobl.ccr.corp.intel.com (HELO [10.249.171.70])
 ([10.249.171.70])
 by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 10 Nov 2022 00:58:54 -0800
Message-ID: <3286ad00-e432-da69-a041-6a3032494470@intel.com>
Date: Thu, 10 Nov 2022 16:58:52 +0800
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
From: "Zhu, Lingshan" <lingshan.zhu@intel.com>
In-Reply-To: <d59c311f-ba9f-4c00-28f8-c50e099adb9f@redhat.com>
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

CgpPbiAxMS8xMC8yMDIyIDI6MjkgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4KPiDlnKggMjAyMi8x
MS8xMCAxNDoyMCwgWmh1LCBMaW5nc2hhbiDlhpnpgZM6Cj4+Cj4+Cj4+IE9uIDExLzEwLzIwMjIg
MTE6NDkgQU0sIEphc29uIFdhbmcgd3JvdGU6Cj4+PiBPbiBXZWQsIE5vdiA5LCAyMDIyIGF0IDU6
MDYgUE0gWmh1LCBMaW5nc2hhbiAKPj4+IDxsaW5nc2hhbi56aHVAaW50ZWwuY29tPiB3cm90ZToK
Pj4+Pgo+Pj4+Cj4+Pj4gT24gMTEvOS8yMDIyIDQ6NTkgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4+
Pj4+IE9uIFdlZCwgTm92IDksIDIwMjIgYXQgNDoxNCBQTSBaaHUsIExpbmdzaGFuIAo+Pj4+PiA8
bGluZ3NoYW4uemh1QGludGVsLmNvbT4gd3JvdGU6Cj4+Pj4+Pgo+Pj4+Pj4gT24gMTEvOS8yMDIy
IDI6NTEgUE0sIEphc29uIFdhbmcgd3JvdGU6Cj4+Pj4+Pj4gT24gTW9uLCBOb3YgNywgMjAyMiBh
dCA1OjQyIFBNIFpodSBMaW5nc2hhbiAKPj4+Pj4+PiA8bGluZ3NoYW4uemh1QGludGVsLmNvbT4g
d3JvdGU6Cj4+Pj4+Pj4+IFRoaXMgc2VyaWVzIGltcGxlbWVudHMgZmVhdHVyZXMgcHJvdmlzaW9u
aW5nIGZvciBpZmN2Zi4KPj4+Pj4+Pj4gQnkgYXBwbHlpbmcgdGhpcyBzZXJpZXMsIHdlIGFsbG93
IHVzZXJzcGFjZSB0byBjcmVhdGUKPj4+Pj4+Pj4gYSB2RFBBIGRldmljZSB3aXRoIHNlbGVjdGVk
IChtYW5hZ2VtZW50IGRldmljZSBzdXBwb3J0ZWQpCj4+Pj4+Pj4+IGZlYXR1cmUgYml0cyBhbmQg
bWFzayBvdXQgb3RoZXJzLgo+Pj4+Pj4+IEkgZG9uJ3Qgc2VlIGEgZGlyZWN0IHJlbGF0aW9uc2hp
cCBiZXR3ZWVuIHRoZSBmaXJzdCAzIGFuZCB0aGUgbGFzdC4KPj4+Pj4+PiBNYXliZSB5b3UgY2Fu
IHN0YXRlIHRoZSByZWFzb24gd2h5IHRoZSByZXN0cnVjdHVyZSBpcyBhIG11c3QgZm9yIAo+Pj4+
Pj4+IHRoZQo+Pj4+Pj4+IGZlYXR1cmUgcHJvdmlzaW9uaW5nLiBPdGhlcndpc2UsIHdlJ2QgYmV0
dGVyIHNwbGl0IHRoZSBzZXJpZXMuCj4+Pj4+PiBXaGVuIGludHJvZHVjaW5nIGZlYXR1cmVzIHBy
b3Zpc2lvbmluZyBhYmlsaXR5IHRvIGlmY3ZmLCB0aGVyZSBpcyAKPj4+Pj4+IGEgbmVlZAo+Pj4+
Pj4gdG8gcmUtY3JlYXRlIHZEUEEgZGV2aWNlcwo+Pj4+Pj4gb24gYSBWRiB3aXRoIGRpZmZlcmVu
dCBmZWF0dXJlIGJpdHMuCj4+Pj4+IFRoaXMgc2VlbXMgYSByZXF1aXJlbWVudCBldmVuIHdpdGhv
dXQgZmVhdHVyZSBwcm92aXNpb25pbmc/IERldmljZQo+Pj4+PiBjb3VsZCBiZSBkZWxldGVkIGZy
b20gdGhlIG1hbmFnZW1lbnQgZGV2aWNlIGFueWhvdy4KPj4+PiBZZXMsIHdlIG5lZWQgdGhpcyB0
byBkZWxldGUgYW5kIHJlLWNyZWF0ZSBhIHZEUEEgZGV2aWNlLgo+Pj4gSSB3b25kZXIgaWYgd2Ug
bmVlZCBzb21ldGhpbmcgdGhhdCB3b3JrcyBmb3IgLXN0YWJsZS4KPj4gSSBjYW4gYWRkIGEgZml4
IHRhZywgc28gdGhlc2UgdGhyZWUgcGF0Y2hlcyBjb3VsZCBhcHBseSB0byBzdGFibGUKPgo+Cj4g
SXQncyB0b28gaHVnZSBmb3IgLXN0YWJsZS4KPgo+Cj4+Pgo+Pj4gQUZBSUssIHdlIGNhbiBtb3Zl
IHRoZSB2ZHBhX2FsbG9jX2RldmljZSgpIGZyb20gcHJvYmUoKSB0byBkZXZfYWRkKCkKPj4+IGFu
ZCBpdCBzZWVtcyB0byB3b3JrPwo+PiBZZXMgYW5kIHRoaXMgaXMgZG9uZSBpbiB0aGlzIHNlcmll
cyBhbmQgdGhhdCdzIHdoeSB3ZSBuZWVkIHRoZXNlCj4+IHJlZmFjdG9yaW5nIGNvZGUuCj4KPgo+
IEkgbWVhbnQgdGhlcmUncyBwcm9iYWJseSBubyBuZWVkIHRvIGNoYW5nZSB0aGUgYXNzb2NpYXRp
b24gb2YgZXhpc3RpbmcgCj4gc3RydWN0dXJlIGJ1dCBqdXN0IGRvIHRoZSBhbGxvY2F0aW9uIGlu
IGRldl9hZGQoKSwgdGhlbiB3ZSB3aWxsIGhhdmUgYSAKPiBwYXRjaCB3aXRoIG11Y2ggbW9yZSBz
bWFsbCBjaGFuZ2VzZXQgdGhhdCBmaXQgZm9yIC1zdGFibGUuClBhdGNoIDEoaWZjdmZfYmFzZSBv
bmx5IHdvcmsgb24gaWZjdmZfaHcpIGFuZCBwYXRjaCAyKGlycSBmdW5jdGlvbnMgb25seSAKd29y
ayBvbiBpZmN2Zl9odykgYXJlIG5vdCBuZWVkZWQgZm9yIHN0YWJsZS4KSSBoYXZlIGFscmVhZHkg
ZG9uZSB0aGlzIGFsbG9jYXRpb24gb2YgaWZjdmZfYWRhcHRlciB3aGljaCBpcyB0aGUgCmNvbnRh
aW5lciBvZiBzdHJ1Y3QgdmRwYV9kZXZpY2UgaW4gZGV2X2FkZCgpIGluIFBhdGNoIDMsIHRoaXMg
c2hvdWxkIGJlIAptZXJnZWQgdG8gc3RhYmxlLgpQYXRjaCAzIGlzIGh1Z2UgYnV0IG5lY2Vzc2Fy
eSwgbm90IG9ubHkgYWxsb2NhdGUgaWZjdmZfYWRhcHRlciBpbiAKZGV2X2FkZCgpLCBpdCBhbHNv
IHJlZmFjdG9ycyB0aGUgc3RydWN0dXJlcyBvZiBpZmN2Zl9tZ210X2RldiBhbmQgCmlmY3ZmX2Fk
YXB0ZXIsCmJlY2F1c2Ugd2UgbmVlZCB0byBpbml0aWFsaXplIHRoZSBWRidzIGh3IHN0cnVjdHVy
ZSBpZmN2Zl9odyh3aGljaCB3YXMgYSAKbWVtYmVyIG9mIGlmY3ZmX2FkYXB0ZXIgYnV0IG5vdyBz
aG91bGQgYmUgYSBtZW1iZXIgb2YgaWZjdmZfbWdtdF9kZXYpIGluIApwcm9iZS4KCklzIGl0IHN0
aWxsIGh1Z2U/CgpUaGFua3MKPgo+IFRoYW5rcwo+Cj4KPj4KPj4gQnkgdGhlIHdheSwgZG8geW91
IGhhdmUgYW55IGNvbW1lbnRzIHRvIHRoZSBwYXRjaGVzPwo+Pgo+PiBUaGFua3MsCj4+IFpodSBM
aW5nc2hhbgo+Pj4KPj4+IFRoYW5rcwo+Pj4KPj4+PiBXZSBjcmVhdGUgdkRQQSBkZXZpY2UgZnJv
bSBhIFZGLCBzbyB3aXRob3V0IGZlYXR1cmVzIHByb3Zpc2lvbmluZwo+Pj4+IHJlcXVpcmVtZW50
cywKPj4+PiB3ZSBkb24ndCBuZWVkIHRvIHJlLWNyZWF0ZSB0aGUgdkRQQSBkZXZpY2UuIEJ1dCB3
aXRoIGZlYXR1cmVzIAo+Pj4+IHByb3Zpc2lvbmluZywKPj4+PiBpdCBpcyBhIG11c3Qgbm93Lgo+
Pj4+Cj4+Pj4gVGhhbmtzCj4+Pj4KPj4+Pgo+Pj4+PiBUaGFrbnMKPj4+Pj4KPj4+Pj4+IFdoZW4g
cmVtb3ZlIGEgdkRQQSBkZXZpY2UsIHRoZSBjb250YWluZXIgb2Ygc3RydWN0IHZkcGFfZGV2aWNl
IAo+Pj4+Pj4gKGhlcmUgaXMKPj4+Pj4+IGlmY3ZmX2FkYXB0ZXIpIGlzIGZyZWUtZWQgaW4KPj4+
Pj4+IGRldl9kZWwoKSBpbnRlcmZhY2UsIHNvIHdlIG5lZWQgdG8gYWxsb2NhdGUgaWZjdmZfYWRh
cHRlciBpbiAKPj4+Pj4+IGRldl9hZGQoKQo+Pj4+Pj4gdGhhbiBpbiBwcm9iZSgpLiBUaGF0J3MK
Pj4+Pj4+IHdoeSBJIGhhdmUgcmUtZmFjdG9yZWQgdGhlIGFkYXB0ZXIvbWdtdF9kZXYgY29kZS4K
Pj4+Pj4+Cj4+Pj4+PiBGb3IgcmUtZmFjdG9yaW5nIHRoZSBpcnEgcmVsYXRlZCBjb2RlIGFuZCBp
ZmN2Zl9iYXNlLCBsZXQgdGhlbSAKPj4+Pj4+IHdvcmsgb24KPj4+Pj4+IHN0cnVjdCBpZmN2Zl9o
dywgdGhlCj4+Pj4+PiByZWFzb24gaXMgdGhhdCB0aGUgYWRhcHRlciBpcyBhbGxvY2F0ZWQgaW4g
ZGV2X2FkZCgpLCBpZiB3ZSB3YW50IAo+Pj4+Pj4gdGhlc2VzCj4+Pj4+PiBmdW5jdGlvbnMgdG8g
d29yawo+Pj4+Pj4gYmVmb3JlIGRldl9hZGQoKSwgbGlrZSBpbiBwcm9iZSwgd2UgbmVlZCB0aGVt
IHdvcmsgb24gaWZjdmZfaHcgCj4+Pj4+PiB0aGFuIHRoZQo+Pj4+Pj4gYWRhcHRlci4KPj4+Pj4+
Cj4+Pj4+PiBUaGFua3MKPj4+Pj4+IFpodSBMaW5nc2hhbgo+Pj4+Pj4+IFRoYW5rcwo+Pj4+Pj4+
Cj4+Pj4+Pj4+IFBsZWFzZSBoZWxwIHJldmlldwo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBUaGFua3MKPj4+
Pj4+Pj4KPj4+Pj4+Pj4gWmh1IExpbmdzaGFuICg0KToKPj4+Pj4+Pj4gwqDCoMKgwqAgdkRQQS9p
ZmN2ZjogaWZjdmYgYmFzZSBsYXllciBpbnRlcmZhY2VzIHdvcmsgb24gc3RydWN0IAo+Pj4+Pj4+
PiBpZmN2Zl9odwo+Pj4+Pj4+PiDCoMKgwqDCoCB2RFBBL2lmY3ZmOiBJUlEgaW50ZXJmYWNlcyB3
b3JrIG9uIGlmY3ZmX2h3Cj4+Pj4+Pj4+IMKgwqDCoMKgIHZEUEEvaWZjdmY6IGFsbG9jYXRlIGlm
Y3ZmX2FkYXB0ZXIgaW4gZGV2X2FkZCgpCj4+Pj4+Pj4+IMKgwqDCoMKgIHZEUEEvaWZjdmY6IGlt
cGxlbWVudCBmZWF0dXJlcyBwcm92aXNpb25pbmcKPj4+Pj4+Pj4KPj4+Pj4+Pj4gwqDCoMKgIGRy
aXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmMgfMKgIDMyICsrLS0tLS0KPj4+Pj4+Pj4gwqDC
oMKgIGRyaXZlcnMvdmRwYS9pZmN2Zi9pZmN2Zl9iYXNlLmggfMKgIDEwICstCj4+Pj4+Pj4+IMKg
wqDCoCBkcml2ZXJzL3ZkcGEvaWZjdmYvaWZjdmZfbWFpbi5jIHwgMTU2IAo+Pj4+Pj4+PiArKysr
KysrKysrKysrKystLS0tLS0tLS0tLS0tLS0tLQo+Pj4+Pj4+PiDCoMKgwqAgMyBmaWxlcyBjaGFu
Z2VkLCA4OSBpbnNlcnRpb25zKCspLCAxMDkgZGVsZXRpb25zKC0pCj4+Pj4+Pj4+Cj4+Pj4+Pj4+
IC0tIAo+Pj4+Pj4+PiAyLjMxLjEKPj4+Pj4+Pj4KPj4KPgoKX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX18KVmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZp
cnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZvdW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGlu
dXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xpc3RpbmZvL3ZpcnR1YWxpemF0aW9u
