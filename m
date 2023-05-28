Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C8682C77B73
	for <virtualization@archiver.kernel.org>; Sun, 28 May 2023 01:17:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 3E6DC401C9;
	Sun, 28 May 2023 01:17:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3E6DC401C9
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Yx_JZYCRQTRW; Sun, 28 May 2023 01:17:43 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 79EA94013B;
	Sun, 28 May 2023 01:17:42 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 79EA94013B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 446B9C0036;
	Sun, 28 May 2023 01:17:42 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [IPv6:2605:bc80:3010::138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 4FBE5C002A
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 01:17:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 2073383BCD
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 01:17:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2073383BCD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VbdEdjG5Rd2Q
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 01:17:38 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 4F29183BCC
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 4F29183BCC
 for <virtualization@lists.linux-foundation.org>;
 Sun, 28 May 2023 01:17:38 +0000 (UTC)
Received: from in01.mta.xmission.com ([166.70.13.51]:49118)
 by out01.mta.xmission.com with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1q352N-00Bv4L-BZ; Sat, 27 May 2023 19:17:35 -0600
Received: from ip68-110-29-46.om.om.cox.net ([68.110.29.46]:56428
 helo=email.froward.int.ebiederm.org.xmission.com)
 by in01.mta.xmission.com with esmtpsa (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.93)
 (envelope-from <ebiederm@xmission.com>)
 id 1q352M-003tFt-0E; Sat, 27 May 2023 19:17:34 -0600
From: "Eric W. Biederman" <ebiederm@xmission.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
References: <20230522025124.5863-1-michael.christie@oracle.com>
 <20230522025124.5863-4-michael.christie@oracle.com>
 <20230522123029.GA22159@redhat.com>
 <cfca7764-d210-6df9-e182-2c093101c6cf@oracle.com>
 <20230522174757.GC22159@redhat.com> <20230523121506.GA6562@redhat.com>
 <87bkib6nxr.fsf@email.froward.int.ebiederm.org>
 <20230524141022.GA19091@redhat.com>
 <87ttw1zt4i.fsf@email.froward.int.ebiederm.org>
 <20230525115512.GA9229@redhat.com>
 <87y1lcxwcj.fsf@email.froward.int.ebiederm.org>
 <CAHk-=wj4DS=2F5mW+K2P7cVqrsuGd3rKE_2k2BqnnPeeYhUCvg@mail.gmail.com>
 <87cz2mrtnk.fsf@email.froward.int.ebiederm.org>
 <CAHk-=whsi9JFP-okH3jXHrA8rh8bMuuSt6ZgkmPwiDMAn437qA@mail.gmail.com>
Date: Sat, 27 May 2023 20:17:09 -0500
In-Reply-To: <CAHk-=whsi9JFP-okH3jXHrA8rh8bMuuSt6ZgkmPwiDMAn437qA@mail.gmail.com>
 (Linus Torvalds's message of "Sat, 27 May 2023 09:12:27 -0700")
Message-ID: <87mt1pmezu.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
X-XM-SPF: eid=1q352M-003tFt-0E; ; ;
 mid=<87mt1pmezu.fsf@email.froward.int.ebiederm.org>; ; ;
 hst=in01.mta.xmission.com; ; ; ip=68.110.29.46; ; ; frm=ebiederm@xmission.com;
 ; ; spf=pass
X-XM-AID: U2FsdGVkX1+/uLz/5gvsT9Lr5b/sz4lC4Q7fsNO8xzg=
X-SA-Exim-Connect-IP: 68.110.29.46
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH 3/3] fork, vhost: Use CLONE_THREAD to fix freezer/ps
 regression
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Cc: axboe@kernel.dk, brauner@kernel.org, mst@redhat.com,
 linux-kernel@vger.kernel.org, Oleg Nesterov <oleg@redhat.com>,
 stefanha@redhat.com, linux@leemhuis.info, nicolas.dichtel@6wind.com,
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
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

TGludXMgVG9ydmFsZHMgPHRvcnZhbGRzQGxpbnV4LWZvdW5kYXRpb24ub3JnPiB3cml0ZXM6Cgo+
IE9uIFNhdCwgTWF5IDI3LCAyMDIzIGF0IDI6NDnigK9BTSBFcmljIFcuIEJpZWRlcm1hbiA8ZWJp
ZWRlcm1AeG1pc3Npb24uY29tPiB3cm90ZToKPj4KPj4gVGhlIHJlYWwgc3RpY2t5IHdpZGdldCBm
b3IgbWUgaXMgaG93IHRvIGhhbmRsZSBvbmUgb2YgdGhlc2UgcHJvY2Vzc2VzCj4+IGNvcmVkdW1w
aW5nLiAgSXQgcmVhbGx5IGxvb2tzIGxpa2UgaXQgd2lsbCByZXN1bHQgaW4gYSByZWxpYWJsZSBo
YW5nLgo+Cj4gV2VsbCwgaWYgKnRoYXQqIGlzIHRoZSBtYWluIHdvcnJ5LCBJIHRoaW5rIHRoYXQn
cyB0cml2aWFsIGVub3VnaCB0byBkZWFsIHdpdGguCj4KPiBJbiBwYXJ0aWN1bGFyLCB3ZSBjb3Vs
ZCBtYWtlIHRoZSBydWxlIGp1c3QgYmUgdGhhdCB1c2VyIHdvcmtlciB0aHJlYWRzCj4gc2ltcGx5
IGRvIG5vdCBwYXJ0aWNpcGF0ZSBpbiBjb3JlLWR1bXBzLgo+Cj4gVEhBVCBpc24ndCBoYXJkLgo+
Cj4gQWxsIHdlIG5lZWQgdG8gZG8gaXMKPgo+ICAoYSkgbm90IGNvdW50IHRob3NlIHRocmVhZHMg
aW4gemFwX3RocmVhZHMoKQo+Cj4gIChiKSBtYWtlIHN1cmUgdGhhdCB0aGV5IGRvbid0IGFkZCB0
aGVtc2VsdmVzIHRvIHRoZSAiZHVtcGVyIiBsaXN0IGJ5Cj4gbm90IGNhbGxpbmcgImNvcmVkdWpt
cF90YXNrX2V4aXQoKSIKPgo+ICAoYykgbm90IGluaXRpYXRlIGNvcmUtZHVtcGluZyB0aGVtc2Vs
dmVzLgo+Cj4gYW5kIEkgdGhpbmsgdGhhdCdzIHByZXR0eSBtdWNoIGl0Lgo+Cj4gSW4gZmFjdCwg
dGhhdCByZWFsbHkgc2VlbXMgbGlrZSBhIGdvb2QgbW9kZWwgKnJlZ2FyZGxlc3MqLCBiZWNhdXNl
Cj4gaG9uZXN0bHksIGEgUEZfSU9fV09SS0VSIGRvZXNuJ3QgaGF2ZSB2YWxpZCByZWdpc3RlciBz
dGF0ZSBmb3IgdGhlCj4gY29yZSBkdW1wIGFueXdheSwgYW5kIGFueXRoaW5nIHRoYXQgd291bGQg
aGF2ZSBjYXVzZWQgYSBJTyB0aHJlYWQgdG8KPiBnZXQgYSBTSUdTRUdWICpzaG91bGQqIGhhdmUg
Y2F1c2VkIGEga2VybmVsIG9vcHMgYWxyZWFkeS4KPgo+IFNvIHRoZSBvbmx5IHdvcnJ5IGlzIHRo
YXQgdGhlIGNvcmUgZHVtcCB3aWxsIG5vdyBoYXBwZW4gd2hpbGUgYW4gSU8KPiB3b3JrZXIgaXMg
c3RpbGwgYnVzeSBhbmQgc28gaXQncyBub3QgImF0b21pYyIgd3J0IHBvc3NpYmxlIFZNIGNoYW5n
ZXMsCj4gYnV0IHdoaWxlIHRoYXQgdXNlZCB0byBiZSBhIGJpZyBwcm9ibGVtIGJhY2sgaW4gdGhl
IGRhcmsgYWdlcyB3aGVuIHdlCj4gZGlkbid0IGdldCB0aGUgVk0gbG9ja3MgZm9yIGNvcmUgZHVt
cGluZywgdGhhdCBnb3QgZml4ZWQgYSBmZXcgeWVhcnMKPiBhZ28gYmVjYXVzZSBpdCBhbHJlYWR5
IGNhdXNlZCBsb3RzIG9mIHBvdGVudGlhbCBpc3N1ZXMuCgoKPgo+IEVuZCByZXN1bHQ6IEkgdGhp
bmsgdGhlIGF0dGFjaGVkIHBhdGNoIGlzIHByb2JhYmx5IG1pc3Npbmcgc29tZXRoaW5nLAo+IGJ1
dCB0aGUgYXBwcm9hY2ggIkZlZWxzUmlnaHQodG0pIiB0byBtZS4KPgo+IENvbW1lbnRzPwoKSXQg
c2VlbXMgbGlrZSBhIGdvb2QgYXBwcm9hY2ggZm9yIGluY2x1ZGluZyBpbiB0aGUgLXJjIHNlcmll
cy4KSSB0aGluayB0aGUgY2hhbmdlIHNob3VsZCBsb29rIG1vcmUgbGlrZSBteSBjaGFuZ2UgYmVs
b3cuCgpuaXRzOgogIC0gVGhlIHRocmVhZHMgYWxsIG5lZWQgdG8gcGFydGljaXBhdGUgaW4gdGhl
IGdyb3VwIGV4aXQgZXZlbiBpZiB0aGV5CiAgICBhcmVuJ3QgZ29pbmcgdG8gYmUgaW4gdGhlIGNv
cmVkdW1wLgoKICAtIEZvciB2aG9zdF93b3JrZXIgd2UgbmVlZCBzL1BGX0lPX1dPUktFUi9QRl9V
U0VSX1dPUktFUi8uCgogIC0gTW92aW5nIFBGX0lPX1dPUktFUiBhYm92ZSB0aGUgc2lnX2tlcm5l
bF9jb3JlZHVtcChzaWducikgdGVzdCBpcwogICAgdW5uZWNlc3NhcnkuICBUaGUgc2lnX2tlcm5l
bF9jb3JlZHVtcChzaWducikgdGVzdCBjYW4gb25seSBiZWNvbWUKICAgIHRydWUgaWYgYSBwcm9j
ZXNzIGV4aXQgaGFzIG5vdCBiZWVuIGluaXRpYXRlZCB5ZXQuICBNb3JlIGltcG9ydGFudGx5CiAg
ICBtb3ZpbmcgdGhlIHRlc3Qgb2JzY3VyZXMgdGhlIGZhY3QgdGhhdCBvbmx5IGRvX2dyb3VwX2V4
aXQgaXMKICAgIG1vdmVkIG91dCBvZiBnZXRfc2lnbmFsIGZvciB0aGUgUEZfSU9fV09SS0VSIHNw
ZWNpYWwgY2FzZS4KCgpMb25nIHRlcm0gSSB0aGluayB3ZSB3YW50IGFuIGFwcHJvYWNoIHRoYXQg
c3RvcHMgdGhlIHdvcmtlciB0aHJlYWRzCmR1cmluZyB0aGUgY29yZWR1bXBzLiAgSXQgd2lsbCBq
dXN0IHlpZWxkIGEgYmV0dGVyIHF1YWxpdHkgb2YKaW1wbGVtZW50YXRpb24gaWYgd2UgbWluaW1p
emUgdGhlIGFtb3VudCBvZiBjb25jdXJyZW5jeSBkdXJpbmcgdGhlCmNvcmVkdW1wLgoKSSBoYXZl
IGEgcGVuZGluZyBwYXRjaHNldCB0aGF0IG1vdmVzIHRoZSBjb3JlZHVtcCByZW5kZXp2b3VzIGlu
dG8KZ2V0X3NpZ25hbC4gIEF0IHdoaWNoIHBvaW50IHN0b3BwaW5nIGFsbCBvZiB0aGUgdGhyZWFk
cyBpcyBqdXN0IGxpa2UKU0lHU1RPUCBzb21ldGhpbmcgdGhlIHdvcmtlciB0aHJlYWRzIGNhbiB1
c2UgYW5kIGl0IHdvbid0IGludHJvZHVjZSBhbnkKaXNzdWVzLiAgVG9kYXkgdGhlIHByb2JsZW0g
aXMgc29tZSBvZiB0aGUgd29ya2VyIHRocmVhZCBjb2RlIG11c3QgcnVuCmJlZm9yZSB0aGUgY29y
ZWR1bXAgc3RvcC4KCkxvb2tpbmcgZm9yd2FyZCBJIGRvbid0IHNlZSBub3QgYXNraW5nIHRoZSB3
b3JrZXIgdGhyZWFkcyB0byBzdG9wCmZvciB0aGUgY29yZWR1bXAgcmlnaHQgbm93IGNhdXNpbmcg
YW55IHByb2JsZW1zIGluIHRoZSBmdXR1cmUuClNvIEkgdGhpbmsgd2UgY2FuIHVzZSB0aGlzIHRv
IHJlc29sdmUgdGhlIGNvcmVkdW1wIGlzc3VlIEkgc3BvdHRlZC4KCgpkaWZmIC0tZ2l0IGEvZnMv
Y29yZWR1bXAuYyBiL2ZzL2NvcmVkdW1wLmMKaW5kZXggZWNlN2JhZGY3MDFiLi42MjBmN2Y5ZGM4
OTQgMTAwNjQ0Ci0tLSBhL2ZzL2NvcmVkdW1wLmMKKysrIGIvZnMvY29yZWR1bXAuYwpAQCAtMzcx
LDcgKzM3MSw4IEBAIHN0YXRpYyBpbnQgemFwX3Byb2Nlc3Moc3RydWN0IHRhc2tfc3RydWN0ICpz
dGFydCwgaW50IGV4aXRfY29kZSkKIAkJaWYgKHQgIT0gY3VycmVudCAmJiAhKHQtPmZsYWdzICYg
UEZfUE9TVENPUkVEVU1QKSkgewogCQkJc2lnYWRkc2V0KCZ0LT5wZW5kaW5nLnNpZ25hbCwgU0lH
S0lMTCk7CiAJCQlzaWduYWxfd2FrZV91cCh0LCAxKTsKLQkJCW5yKys7CisJCQlpZiAoISh0LT5m
bGFncyAmIFBGX0lPX1dPUktFUikpCisJCQkJbnIrKzsKIAkJfQogCX0KIApkaWZmIC0tZ2l0IGEv
a2VybmVsL2V4aXQuYyBiL2tlcm5lbC9leGl0LmMKaW5kZXggMzRiOTBlMmU3Y2Y3Li42MDgyZGJh
OTEzMWEgMTAwNjQ0Ci0tLSBhL2tlcm5lbC9leGl0LmMKKysrIGIva2VybmVsL2V4aXQuYwpAQCAt
NDExLDcgKzQxMSw5IEBAIHN0YXRpYyB2b2lkIGNvcmVkdW1wX3Rhc2tfZXhpdChzdHJ1Y3QgdGFz
a19zdHJ1Y3QgKnRzaykKIAl0c2stPmZsYWdzIHw9IFBGX1BPU1RDT1JFRFVNUDsKIAljb3JlX3N0
YXRlID0gdHNrLT5zaWduYWwtPmNvcmVfc3RhdGU7CiAJc3Bpbl91bmxvY2tfaXJxKCZ0c2stPnNp
Z2hhbmQtPnNpZ2xvY2spOwotCWlmIChjb3JlX3N0YXRlKSB7CisKKwkvKiBJL08gV29ya2VycyBk
b24ndCBwYXJ0aWNpcGF0ZSBpbiBjb3JlZHVtcHMgKi8KKwlpZiAoY29yZV9zdGF0ZSAmJiAhKHRz
ay0+ZmxhZ3MgJiBQRl9JT19XT1JLRVIpIHsKIAkJc3RydWN0IGNvcmVfdGhyZWFkIHNlbGY7CiAK
IAkJc2VsZi50YXNrID0gY3VycmVudDsKCgo+ICAJCWN1cnJlbnQtPmZsYWdzIHw9IFBGX1NJR05B
TEVEOwo+ICAKPiArCQkvKgo+ICsJCSAqIFBGX0lPX1dPUktFUiB0aHJlYWRzIHdpbGwgY2F0Y2gg
YW5kIGV4aXQgb24gZmF0YWwgc2lnbmFscwo+ICsJCSAqIHRoZW1zZWx2ZXMgYW5kIGRvIG5vdCBw
YXJ0aWNpcGF0ZSBpbiBjb3JlIGR1bXBpbmcuCj4gKwkJICoKPiArCQkgKiBUaGV5IGhhdmUgY2xl
YW51cCB0aGF0IG11c3QgYmUgcGVyZm9ybWVkLCBzbyB3ZSBjYW5ub3QKPiArCQkgKiBjYWxsIGRv
X2V4aXQoKSBvbiB0aGVpciBiZWhhbGYuCj4gKwkJICovCj4gKwkJaWYgKGN1cnJlbnQtPmZsYWdz
ICYgUEZfSU9fV09SS0VSKQo+ICsJCQlnb3RvIG91dDsKPiArCj4gIAkJaWYgKHNpZ19rZXJuZWxf
Y29yZWR1bXAoc2lnbnIpKSB7Cj4gIAkJCWlmIChwcmludF9mYXRhbF9zaWduYWxzKQo+ICAJCQkJ
cHJpbnRfZmF0YWxfc2lnbmFsKGtzaWctPmluZm8uc2lfc2lnbm8pOwo+IEBAIC0yODYwLDE0ICsy
ODcwLDYgQEAgYm9vbCBnZXRfc2lnbmFsKHN0cnVjdCBrc2lnbmFsICprc2lnKQo+ICAJCQlkb19j
b3JlZHVtcCgma3NpZy0+aW5mbyk7Cj4gIAkJfQo+ICAKPiAtCQkvKgo+IC0JCSAqIFBGX0lPX1dP
UktFUiB0aHJlYWRzIHdpbGwgY2F0Y2ggYW5kIGV4aXQgb24gZmF0YWwgc2lnbmFscwo+IC0JCSAq
IHRoZW1zZWx2ZXMuIFRoZXkgaGF2ZSBjbGVhbnVwIHRoYXQgbXVzdCBiZSBwZXJmb3JtZWQsIHNv
Cj4gLQkJICogd2UgY2Fubm90IGNhbGwgZG9fZXhpdCgpIG9uIHRoZWlyIGJlaGFsZi4KPiAtCQkg
Ki8KPiAtCQlpZiAoY3VycmVudC0+ZmxhZ3MgJiBQRl9JT19XT1JLRVIpCj4gLQkJCWdvdG8gb3V0
Owo+IC0KPiAgCQkvKgo+ICAJCSAqIERlYXRoIHNpZ25hbHMsIG5vIGNvcmUgZHVtcC4KPiAgCQkg
Ki8KCkVyaWMKX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18K
VmlydHVhbGl6YXRpb24gbWFpbGluZyBsaXN0ClZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LWZv
dW5kYXRpb24ub3JnCmh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9tYWlsbWFuL2xp
c3RpbmZvL3ZpcnR1YWxpemF0aW9u
