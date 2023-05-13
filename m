Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2DFCAC77B7D
	for <virtualization@archiver.kernel.org>; Sat, 13 May 2023 13:15:18 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id A329583B6D;
	Sat, 13 May 2023 13:15:17 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A329583B6D
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jVUJ2dA0tESy; Sat, 13 May 2023 13:15:16 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id 23C3683B8B;
	Sat, 13 May 2023 13:15:16 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 23C3683B8B
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EECACC0036;
	Sat, 13 May 2023 13:15:15 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 71D0BC002A
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 May 2023 13:15:14 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 37AC241C5E
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 May 2023 13:15:14 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 37AC241C5E
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id GkNk-oBiooCv
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 May 2023 13:15:12 +0000 (UTC)
X-Greylist: delayed 00:35:14 by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org B929841BAE
Received: from wp530.webpack.hosteurope.de (wp530.webpack.hosteurope.de
 [80.237.130.52])
 by smtp4.osuosl.org (Postfix) with ESMTPS id B929841BAE
 for <virtualization@lists.linux-foundation.org>;
 Sat, 13 May 2023 13:15:12 +0000 (UTC)
Received: from [2a02:8108:8980:2478:8cde:aa2c:f324:937e]; authenticated
 by wp530.webpack.hosteurope.de running ExIM with esmtpsa
 (TLS1.3:ECDHE_RSA_AES_128_GCM_SHA256:128)
 id 1pxoXG-0000NV-2p; Sat, 13 May 2023 14:39:42 +0200
Message-ID: <48842e92-835e-bc3f-7118-48b8f415f532@leemhuis.info>
Date: Sat, 13 May 2023 14:39:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
To: Mike Christie <michael.christie@oracle.com>,
 Linus Torvalds <torvalds@linux-foundation.org>, nicolas.dichtel@6wind.com,
 Christian Brauner <brauner@kernel.org>,
 Linux kernel regressions list <regressions@lists.linux.dev>
References: <20230202232517.8695-1-michael.christie@oracle.com>
 <20230202232517.8695-9-michael.christie@oracle.com>
 <aba6cca4-e66c-768f-375c-b38c8ba5e8a8@6wind.com>
 <CAHk-=wgadfsCnKHLON7op=Qs5t3w3PVz5ZDbvbKsfb=yBg=yjQ@mail.gmail.com>
 <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
Content-Language: en-US, de-DE
From: Thorsten Leemhuis <linux@leemhuis.info>
Subject: Re: [PATCH v11 8/8] vhost: use vhost_tasks for worker threads
In-Reply-To: <78c5e150-26cf-7724-74ee-4a0b16b944b1@oracle.com>
X-bounce-key: webpack.hosteurope.de;linux@leemhuis.info;1683983712;adf8b3e0;
X-HE-SMSGID: 1pxoXG-0000NV-2p
Cc: mst@redhat.com, konrad.wilk@oracle.com, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, hch@infradead.org,
 ebiederm@xmission.com, stefanha@redhat.com
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

W0NDaW5nIHRoZSByZWdyZXNzaW9uIGxpc3RdCgpPbiAwNi4wNS4yMyAwMDozNywgTWlrZSBDaHJp
c3RpZSB3cm90ZToKPiBPbiA1LzUvMjMgMToyMiBQTSwgTGludXMgVG9ydmFsZHMgd3JvdGU6Cj4+
IE9uIEZyaSwgTWF5IDUsIDIwMjMgYXQgNjo0MOKAr0FNIE5pY29sYXMgRGljaHRlbAo+PiA8bmlj
b2xhcy5kaWNodGVsQDZ3aW5kLmNvbT4gd3JvdGU6Cj4+Pgo+Pj4gSXMgdGhpcyBhbiBpbnRlbmRl
ZCBiZWhhdmlvcj8KPj4+IFRoaXMgYnJlYWtzIHNvbWUgb2Ygb3VyIHNjcmlwdHMuCgpKdW1waW5n
IGluIGhlcmUsIGFzIEkgZm91bmQgYW5vdGhlciBwcm9ibGVtIHdpdGggdGhhdCBwYXRjaDogaXQg
YnJva2UKczJpZGxlIG9uIG15IGxhcHRvcCB3aGVuIGEgcWVtdS1rdm0gVk0gaXMgcnVubmluZywg
YXMgZnJlZXppbmcgdXNlcgpzcGFjZSBwcm9jZXNzZXMgbm93IGZhaWxzIGZvciBtZToKCmBgYAog
WyAgMTk1LjQ0Mjk0OV0gUE06IHN1c3BlbmQgZW50cnkgKHMyaWRsZSkKIFsgIDE5NS42NDEyNzFd
IEZpbGVzeXN0ZW1zIHN5bmM6IDAuMTk4IHNlY29uZHMKIFsgIDE5NS44MzM4MjhdIEZyZWV6aW5n
IHVzZXIgc3BhY2UgcHJvY2Vzc2VzCiBbICAyMTUuODQxMDg0XSBGcmVlemluZyB1c2VyIHNwYWNl
IHByb2Nlc3NlcyBmYWlsZWQgYWZ0ZXIgMjAuMDA3CnNlY29uZHMgKDEgdGFza3MgcmVmdXNpbmcg
dG8gZnJlZXplLCB3cV9idXN5PTApOgogWyAgMjE1Ljg0MTI1NV0gdGFzazp2aG9zdC0zMjIxICAg
ICAgc3RhdGU6UiBzdGFjazowICAgICBwaWQ6MzI1MApwcGlkOjMyMjEgICBmbGFnczoweDAwMDA0
MDA2CiBbICAyMTUuODQxMjY0XSBDYWxsIFRyYWNlOgogWyAgMjE1Ljg0MTI2Nl0gIDxUQVNLPgog
WyAgMjE1Ljg0MTI3MF0gID8gdXBkYXRlX3JxX2Nsb2NrKzB4MzkvMHgyNzAKIFsgIDIxNS44NDEy
ODNdICA/IF9yYXdfc3Bpbl91bmxvY2srMHgxOS8weDQwCiBbICAyMTUuODQxMjkwXSAgPyBfX3Nj
aGVkdWxlKzB4M2YvMHgxNTEwCiBbICAyMTUuODQxMjk2XSAgPyBzeXN2ZWNfYXBpY190aW1lcl9p
bnRlcnJ1cHQrMHhhZi8weGQwCiBbICAyMTUuODQxMzA2XSAgPyBzY2hlZHVsZSsweDYxLzB4ZTAK
IFsgIDIxNS44NDEzMTNdICA/IHZob3N0X3dvcmtlcisweDg3LzB4YjAgW3Zob3N0XQogWyAgMjE1
Ljg0MTMyOV0gID8gdmhvc3RfdGFza19mbisweDFhLzB4MzAKIFsgIDIxNS44NDEzMzZdICA/IF9f
cGZ4X3Zob3N0X3Rhc2tfZm4rMHgxMC8weDEwCiBbICAyMTUuODQxMzQxXSAgPyByZXRfZnJvbV9m
b3JrKzB4MmMvMHg1MAogWyAgMjE1Ljg0MTM1Ml0gIDwvVEFTSz4KIFsgIDIxNS44NDE5MzZdIE9P
TSBraWxsZXIgZW5hYmxlZC4KIFsgIDIxNS44NDE5MzhdIFJlc3RhcnRpbmcgdGFza3MgLi4uIGRv
bmUuCiBbICAyMTUuODQ0MjA0XSByYW5kb206IGNybmcgcmVzZWVkZWQgb24gc3lzdGVtIHJlc3Vt
cHRpb24KIFsgIDIxNS45NTcwOTVdIFBNOiBzdXNwZW5kIGV4aXQKIFsgIDIxNS45NTcxODVdIFBN
OiBzdXNwZW5kIGVudHJ5IChzMmlkbGUpCiBbICAyMTUuOTY3NjQ2XSBGaWxlc3lzdGVtcyBzeW5j
OiAwLjAxMCBzZWNvbmRzCiBbICAyMTUuOTcxMzI2XSBGcmVlemluZyB1c2VyIHNwYWNlIHByb2Nl
c3NlcwogWyAgMjM1Ljk3NDQwMF0gRnJlZXppbmcgdXNlciBzcGFjZSBwcm9jZXNzZXMgZmFpbGVk
IGFmdGVyIDIwLjAwMwpzZWNvbmRzICgxIHRhc2tzIHJlZnVzaW5nIHRvIGZyZWV6ZSwgd3FfYnVz
eT0wKToKIFsgIDIzNS45NzQ1NzRdIHRhc2s6dmhvc3QtMzIyMSAgICAgIHN0YXRlOlIgc3RhY2s6
MCAgICAgcGlkOjMyNTAKcHBpZDozMjIxICAgZmxhZ3M6MHgwMDAwNDgwNgogWyAgMjM1Ljk3NDU4
M10gQ2FsbCBUcmFjZToKIFsgIDIzNS45NzQ1ODZdICA8VEFTSz4KIFsgIDIzNS45NzQ1OTNdICA/
IF9fc2NoZWR1bGUrMHgxODQvMHgxNTEwCiBbICAyMzUuOTc0NjA1XSAgPyBzeXN2ZWNfYXBpY190
aW1lcl9pbnRlcnJ1cHQrMHhhZi8weGQwCiBbICAyMzUuOTc0NjE2XSAgPyBzY2hlZHVsZSsweDYx
LzB4ZTAKIFsgIDIzNS45NzQ2MjRdICA/IHZob3N0X3dvcmtlcisweDg3LzB4YjAgW3Zob3N0XQog
WyAgMjM1Ljk3NDY0OF0gID8gdmhvc3RfdGFza19mbisweDFhLzB4MzAKIFsgIDIzNS45NzQ2NTZd
ICA/IF9fcGZ4X3Zob3N0X3Rhc2tfZm4rMHgxMC8weDEwCiBbICAyMzUuOTc0NjYyXSAgPyByZXRf
ZnJvbV9mb3JrKzB4MmMvMHg1MAogWyAgMjM1Ljk3NDY3M10gIDwvVEFTSz4KIFsgIDIzNS45NzUx
OTBdIE9PTSBraWxsZXIgZW5hYmxlZC4KIFsgIDIzNS45NzUxOTJdIFJlc3RhcnRpbmcgdGFza3Mg
Li4uIGRvbmUuCiBbICAyMzUuOTc4MTMxXSByYW5kb206IGNybmcgcmVzZWVkZWQgb24gc3lzdGVt
IHJlc3VtcHRpb24KIFsgIDIzNi4wOTEyMTldIFBNOiBzdXNwZW5kIGV4aXQKYGBgCgpBZnRlciBy
dW5uaW5nIGludG8gdGhlIHByb2JsZW0gSSBib290ZWQgNi4zLjEtcmMxIGFnYWluIGFuZCB0aGVy
ZSBzMmlkbGUKc3RpbGwgd29ya2VkLiBEaWRuJ3QgZG8gYSBiaXNlY3Rpb24sIGp1c3QgbG9va2Vk
IGF0IHRoZSB2aG9zdCBjb21taXRzCmR1cmluZyB0aGUgbGF0ZXN0IG1lcmdlIHdpbmRvdzsgNmU4
OTBjNWQ1MDIgKCJ2aG9zdDogdXNlIHZob3N0X3Rhc2tzIGZvcgp3b3JrZXIgdGhyZWFkcyIpIGxv
b2tlZCBzdXNwaWNpb3VzLCBzbyBJIHJldmVydGVkIGl0IG9uIHRvcCBvZiBsYXRlc3QKbWFpbmxp
bmUgYW5kIHRoZW4gdGhpbmdzIHdvcmsgYWdhaW4uIFRocm91Z2ggYSBzZWFyY2ggb24gbG9yZSBJ
IGFycml2ZWQKaW4gdGhpcyB0aHJlYWQgYW5kIGZvdW5kIGJlbG93IHBhdGNoIGZyb20gTWlrZS4g
R2F2ZSBpdCBhIHRyeSBvbiB0b3Agb2YKbGF0ZXN0IG1haW5saW5lLCBidXQgaXQgZGlkbid0IGhl
bHAuCgpDaWFvLCBUaG9yc3RlbgoKPiBbLi4uXQo+IElmIGl0J3Mgb2sgdG8gY2hhbmdlIHRoZSBi
ZWhhdmlvciBvZiAicHMgLXUgcm9vdCIsIHRoZW4gd2UgY2FuIGRvIHRoaXMgcGF0Y2g6Cj4gKE5p
Y29sYXMsIEkgY29uZmlybWVkIGl0IGZpeGVzIHRoZSAncHMgYScgY2FzZSwgYnV0IGNvdWxkbid0
IHJlcGxpY2F0ZSB0aGUgJ3BzJwo+IGNhc2UuIElmIHlvdSBjb3VsZCB0ZXN0IHRoZSBwcyBvbmx5
IGNhc2Ugb3IgZ2l2ZSBtZSBpbmZvIG9uIHdoYXQgL3Vzci9iaW4vZXhhbXBsZQo+IHdhcyBkb2lu
ZyBJIGNhbiByZXBsaWNhdGUgYW5kIHRlc3QgaGVyZSk6Cj4gCj4gCj4gZGlmZiAtLWdpdCBhL2tl
cm5lbC9mb3JrLmMgYi9rZXJuZWwvZm9yay5jCj4gaW5kZXggZWQ0ZTAxZGFjY2FhLi5lYjlmZmM1
OGUyMTEgMTAwNjQ0Cj4gLS0tIGEva2VybmVsL2ZvcmsuYwo+ICsrKyBiL2tlcm5lbC9mb3JrLmMK
PiBAQCAtMjI2OSw4ICsyMjY5LDE0IEBAIF9fbGF0ZW50X2VudHJvcHkgc3RydWN0IHRhc2tfc3Ry
dWN0ICpjb3B5X3Byb2Nlc3MoCj4gIAkvKgo+ICAJICogVGhyZWFkIGdyb3VwcyBtdXN0IHNoYXJl
IHNpZ25hbHMgYXMgd2VsbCwgYW5kIGRldGFjaGVkIHRocmVhZHMKPiAgCSAqIGNhbiBvbmx5IGJl
IHN0YXJ0ZWQgdXAgd2l0aGluIHRoZSB0aHJlYWQgZ3JvdXAuCj4gKwkgKgo+ICsJICogQSB1c2Vy
d29ya2VyJ3MgcGFyZW50IHRocmVhZCB3aWxsIG5vcm1hbGx5IGhhdmUgYSBzaWduYWwgaGFuZGxl
cgo+ICsJICogdGhhdCBwZXJmb3JtcyBtYW5hZ2VtZW50IG9wZXJhdGlvbnMsIGJ1dCB0aGUgd29y
a2VyIHdpbGwgbm90Cj4gKwkgKiBiZWNhdXNlIHRoZSBwYXJlbnQgd2lsbCBoYW5kbGUgdGhlIHNp
Z25hbCB0aGVuIHVzZXIgYSB3b3JrZXIKPiArCSAqIHNwZWNpZmljIGludGVyZmFjZSB0byBtYW5h
Z2UgdGhlIHRocmVhZCBhbmQgcmVsYXRlZCByZXNvdXJjZXMuCj4gIAkgKi8KPiAtCWlmICgoY2xv
bmVfZmxhZ3MgJiBDTE9ORV9USFJFQUQpICYmICEoY2xvbmVfZmxhZ3MgJiBDTE9ORV9TSUdIQU5E
KSkKPiArCWlmICgoY2xvbmVfZmxhZ3MgJiBDTE9ORV9USFJFQUQpICYmICEoY2xvbmVfZmxhZ3Mg
JiBDTE9ORV9TSUdIQU5EKSAmJgo+ICsJICAgICFhcmdzLT51c2VyX3dvcmtlciAmJiAhYXJncy0+
aWdub3JlX3NpZ25hbHMpCj4gIAkJcmV0dXJuIEVSUl9QVFIoLUVJTlZBTCk7Cj4gIAo+ICAJLyoK
PiBkaWZmIC0tZ2l0IGEva2VybmVsL3Zob3N0X3Rhc2suYyBiL2tlcm5lbC92aG9zdF90YXNrLmMK
PiBpbmRleCBiN2NiZDY2Zjg4OWUuLjM3MDBjMjFlYTM5ZCAxMDA2NDQKPiAtLS0gYS9rZXJuZWwv
dmhvc3RfdGFzay5jCj4gKysrIGIva2VybmVsL3Zob3N0X3Rhc2suYwo+IEBAIC03NSw3ICs3OCw4
IEBAIHN0cnVjdCB2aG9zdF90YXNrICp2aG9zdF90YXNrX2NyZWF0ZShpbnQgKCpmbikodm9pZCAq
KSwgdm9pZCAqYXJnLAo+ICAJCQkJICAgICBjb25zdCBjaGFyICpuYW1lKQo+ICB7Cj4gIAlzdHJ1
Y3Qga2VybmVsX2Nsb25lX2FyZ3MgYXJncyA9IHsKPiAtCQkuZmxhZ3MJCT0gQ0xPTkVfRlMgfCBD
TE9ORV9VTlRSQUNFRCB8IENMT05FX1ZNLAo+ICsJCS5mbGFncwkJPSBDTE9ORV9GUyB8IENMT05F
X1RIUkVBRCB8IENMT05FX1ZNIHwKPiArCQkJCSAgQ0xPTkVfVU5UUkFDRUQsCj4gIAkJLmV4aXRf
c2lnbmFsCT0gMCwKPiAgCQkuZm4JCT0gdmhvc3RfdGFza19mbiwKPiAgCQkubmFtZQkJPSBuYW1l
Cl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxp
emF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9u
Lm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92
aXJ0dWFsaXphdGlvbg==
