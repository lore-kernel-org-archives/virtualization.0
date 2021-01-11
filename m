Return-Path: <SRS0=uMqA=GO=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7ACD8C433E0
	for <virtualization@archiver.kernel.org>; Mon, 11 Jan 2021 14:15:49 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 22961224D2
	for <virtualization@archiver.kernel.org>; Mon, 11 Jan 2021 14:15:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 22961224D2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linuxfoundation.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 0A54C85C95;
	Mon, 11 Jan 2021 14:15:49 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id igYBY06Egg3a; Mon, 11 Jan 2021 14:15:48 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by fraxinus.osuosl.org (Postfix) with ESMTP id 6BAD285AE9;
	Mon, 11 Jan 2021 14:15:48 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 5590EC088B;
	Mon, 11 Jan 2021 14:15:48 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 188F6C013A
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 14:15:47 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 0803085B3D
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 14:15:47 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id kmbzH76w8mV2
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 14:15:46 +0000 (UTC)
X-Greylist: from auto-whitelisted by SQLgrey-1.7.6
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 6F08385AE9
 for <virtualization@lists.linux-foundation.org>;
 Mon, 11 Jan 2021 14:15:46 +0000 (UTC)
Received: by mail.kernel.org (Postfix) with ESMTPSA id BF863224B1;
 Mon, 11 Jan 2021 14:15:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
 s=korg; t=1610374546;
 bh=3Ov5RV+7mpbSexLhdHd9S7MWOq/xuUQhaxOiewij4YY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=W1oyExNZYO1jczgNzJtB+me9sRmt+UXENWflKrQIgKh9hrlpGNyB/GQUnuk5Gy8r3
 hwNoaGGrLuCLR5Ys2MxE29iQNxUst+vTbbc3cY8DlJ9WlGUB6U/Z1c5bemcwDmpTO/
 GkaXVnfr+spMkM/TZ6a/evSHB1xXd16l0OBPqWRk=
Date: Mon, 11 Jan 2021 15:16:57 +0100
From: Greg KH <gregkh@linuxfoundation.org>
To: Jorgen Hansen <jhansen@vmware.com>
Subject: Re: [PATCH] VMCI: Enforce queuepair max size for
 IOCTL_VMCI_QUEUEPAIR_ALLOC
Message-ID: <X/xd2QQryUdiN9gv@kroah.com>
References: <1610367535-4463-1-git-send-email-jhansen@vmware.com>
 <X/xItnTyAa7OwSEI@kroah.com>
 <4D53036F-FB61-4730-87D9-4EB6B350B17F@vmware.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <4D53036F-FB61-4730-87D9-4EB6B350B17F@vmware.com>
Cc: Pv-drivers <Pv-drivers@vmware.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>
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

T24gTW9uLCBKYW4gMTEsIDIwMjEgYXQgMDI6MDU6NTZQTSArMDAwMCwgSm9yZ2VuIEhhbnNlbiB3
cm90ZToKPiBPbiAxMSBKYW4gMjAyMSwgYXQgMTM6NDYsIEdyZWcgS0ggPGdyZWdraEBsaW51eGZv
dW5kYXRpb24ub3JnPiB3cm90ZToKPiA+IAo+ID4gT24gTW9uLCBKYW4gMTEsIDIwMjEgYXQgMDQ6
MTg6NTNBTSAtMDgwMCwgSm9yZ2VuIEhhbnNlbiB3cm90ZToKPiA+PiBXaGVuIGNyZWF0ZSB0aGUg
Vk1DSSBxdWV1ZSBwYWlyIHRyYWNraW5nIGRhdGEgc3RydWN0dXJlcyBvbiB0aGUgaG9zdAo+ID4+
IHNpZGUsIHRoZSBJT0NUTCBmb3IgY3JlYXRpbmcgdGhlIFZNQ0kgcXVldWUgcGFpciBkaWRuJ3Qg
dmFsaWRhdGUKPiA+PiB0aGUgcXVldWUgcGFpciBzaXplIHBhcmFtZXRlcnMuIFRoaXMgY2hhbmdl
IGFkZHMgY2hlY2tzIGZvciB0aGlzLgo+ID4+IAo+ID4+IFRoaXMgYXZvaWRzIGEgbWVtb3J5IGFs
bG9jYXRpb24gaXNzdWUgaW4gcXBfaG9zdF9hbGxvY19xdWV1ZSwgYXMKPiA+PiByZXBvcnRlZCBi
eSBuc2x1c2FyZWtAZ214Lm5ldC4gVGhlIGNoZWNrIGluIHFwX2hvc3RfYWxsb2NfcXVldWUKPiA+
PiBoYXMgYWxzbyBiZWVuIHVwZGF0ZWQgdG8gZW5mb3JjZSB0aGUgbWF4aW11bSBxdWV1ZSBwYWly
IHNpemUKPiA+PiBhcyBkZWZpbmVkIGJ5IFZNQ0lfTUFYX0dVRVNUX1FQX01FTU9SWS4KPiA+PiAK
PiA+PiBUaGUgZml4IGhhcyBiZWVuIHZlcmlmaWVkIHVzaW5nIHNhbXBsZSBjb2RlIHN1cHBsaWVk
IGJ5Cj4gPj4gbnNsdXNhcmVrQGdteC5uZXQuCj4gPj4gCj4gPj4gUmVwb3J0ZWQtYnk6IG5zbHVz
YXJla0BnbXgubmV0Cj4gPj4gUmV2aWV3ZWQtYnk6IFZpc2hudSBEYXNhIDx2ZGFzYUB2bXdhcmUu
Y29tPgo+ID4+IFNpZ25lZC1vZmYtYnk6IEpvcmdlbiBIYW5zZW4gPGpoYW5zZW5Adm13YXJlLmNv
bT4KPiA+PiAtLS0KPiA+PiBkcml2ZXJzL21pc2Mvdm13X3ZtY2kvdm1jaV9xdWV1ZV9wYWlyLmMg
fCAxMiArKysrKysrKy0tLS0KPiA+PiBpbmNsdWRlL2xpbnV4L3Ztd192bWNpX2RlZnMuaCAgICAg
ICAgICAgfCAgNCArKy0tCj4gPj4gMiBmaWxlcyBjaGFuZ2VkLCAxMCBpbnNlcnRpb25zKCspLCA2
IGRlbGV0aW9ucygtKQo+ID4gCj4gPiBIaSwKPiA+IAo+ID4gVGhpcyBpcyB0aGUgZnJpZW5kbHkg
cGF0Y2gtYm90IG9mIEdyZWcgS3JvYWgtSGFydG1hbi4gIFlvdSBoYXZlIHNlbnQgaGltCj4gPiBh
IHBhdGNoIHRoYXQgaGFzIHRyaWdnZXJlZCB0aGlzIHJlc3BvbnNlLiAgSGUgdXNlZCB0byBtYW51
YWxseSByZXNwb25kCj4gPiB0byB0aGVzZSBjb21tb24gcHJvYmxlbXMsIGJ1dCBpbiBvcmRlciB0
byBzYXZlIGhpcyBzYW5pdHkgKGhlIGtlcHQKPiA+IHdyaXRpbmcgdGhlIHNhbWUgdGhpbmcgb3Zl
ciBhbmQgb3ZlciwgeWV0IHRvIGRpZmZlcmVudCBwZW9wbGUpLCBJIHdhcwo+ID4gY3JlYXRlZC4g
IEhvcGVmdWxseSB5b3Ugd2lsbCBub3QgdGFrZSBvZmZlbmNlIGFuZCB3aWxsIGZpeCB0aGUgcHJv
YmxlbQo+ID4gaW4geW91ciBwYXRjaCBhbmQgcmVzdWJtaXQgaXQgc28gdGhhdCBpdCBjYW4gYmUg
YWNjZXB0ZWQgaW50byB0aGUgTGludXgKPiA+IGtlcm5lbCB0cmVlLgo+ID4gCj4gPiBZb3UgYXJl
IHJlY2VpdmluZyB0aGlzIG1lc3NhZ2UgYmVjYXVzZSBvZiB0aGUgZm9sbG93aW5nIGNvbW1vbiBl
cnJvcihzKQo+ID4gYXMgaW5kaWNhdGVkIGJlbG93Ogo+ID4gCj4gPiAtIFlvdSBzZW50IG11bHRp
cGxlIHBhdGNoZXMsIHlldCBubyBpbmRpY2F0aW9uIG9mIHdoaWNoIG9uZXMgc2hvdWxkIGJlCj4g
PiAgYXBwbGllZCBpbiB3aGljaCBvcmRlci4gIEdyZWcgY291bGQganVzdCBndWVzcywgYnV0IGlm
IHlvdSBhcmUKPiA+ICByZWNlaXZpbmcgdGhpcyBlbWFpbCwgaGUgZ3Vlc3NlZCB3cm9uZyBhbmQg
dGhlIHBhdGNoZXMgZGlkbid0IGFwcGx5Lgo+ID4gIFBsZWFzZSByZWFkIHRoZSBzZWN0aW9uIGVu
dGl0bGVkICJUaGUgY2Fub25pY2FsIHBhdGNoIGZvcm1hdCIgaW4gdGhlCj4gPiAga2VybmVsIGZp
bGUsIERvY3VtZW50YXRpb24vU3VibWl0dGluZ1BhdGNoZXMgZm9yIGEgZGVzY3JpcHRpb24gb2Yg
aG93Cj4gPiAgdG8gZG8gdGhpcyBzbyB0aGF0IEdyZWcgaGFzIGEgY2hhbmNlIHRvIGFwcGx5IHRo
ZXNlIGNvcnJlY3RseS4KPiA+IAo+ID4gCj4gPiBJZiB5b3Ugd2lzaCB0byBkaXNjdXNzIHRoaXMg
cHJvYmxlbSBmdXJ0aGVyLCBvciB5b3UgaGF2ZSBxdWVzdGlvbnMgYWJvdXQKPiA+IGhvdyB0byBy
ZXNvbHZlIHRoaXMgaXNzdWUsIHBsZWFzZSBmZWVsIGZyZWUgdG8gcmVzcG9uZCB0byB0aGlzIGVt
YWlsIGFuZAo+ID4gR3JlZyB3aWxsIHJlcGx5IG9uY2UgaGUgaGFzIGR1ZyBvdXQgZnJvbSB0aGUg
cGVuZGluZyBwYXRjaGVzIHJlY2VpdmVkCj4gPiBmcm9tIG90aGVyIGRldmVsb3BlcnMuCj4gPiAK
PiA+IHRoYW5rcywKPiA+IAo+ID4gZ3JlZyBrLWgncyBwYXRjaCBlbWFpbCBib3QKPiAKPiBIaSwK
PiAKPiBUaGUgcGF0Y2hlcyBhcmUgaW5kZXBlbmRlbnQgYW5kIHNob3VsZCBiZSBhYmxlIHRvIGFw
cGx5IGluIGFueSBvcmRlcjsKPiBJIGRpZG7igJl0IHNlZSBhbnkgcHJvYmxlbXMgd2hlbiBhcHBs
eWluZyB0aGVtIGluIGRpZmZlcmVudCBvcmRlcnMgbG9jYWxseS4KPiAKPiBJ4oCZbSBoZXNpdGFu
dCB0byBwcm92aWRlIHRoZSBwYXRjaGVzIGFzIGEgc2VyaWVzIG9mIHBhdGNoZXMsIHNpbmNlIG9u
ZSBvZgo+IHRoZW06Cj4gIFZNQ0k6IFVzZSBzZXRfcGFnZV9kaXJ0eV9sb2NrKCkgd2hlbiB1bnJl
Z2lzdGVyaW5nIGd1ZXN0IG1lbW9yeQo+IGlzIG1hcmtlZCBhcyBmaXhpbmcgYW4gb3JpZ2luYWwg
Y2hlY2tpbiwgYW5kIHNob3VsZCBiZSBjb25zaWRlcmVkIGZvcgo+IGJhY2twb3J0aW5nLCB3aGVy
ZWFzIHRoZSBvdGhlcnMgYXJlIGVpdGhlciBub3QgaW1wb3J0YW50IHRvIGJhY2twb3J0Cj4gb3Ig
cmVseSBvbiBvdGhlciByZWNlbnQgY2hhbmdlcy4gSG93ZXZlciwgaWYgZm9ybWF0dGluZyB0aGVt
IGFzIGEKPiBzZXJpZXMgb2YgbWlzYyBmaXhlcyBpcyBwcmVmZXJyZWQsIEnigJlsbCBkbyB0aGF0
LgoKSWYgb25lIHBhdGNoIGlzIHdhbnRpbmcgdG8gYmUgbWVyZ2VkIG5vdywgZm9yIDUuMTEtZmlu
YWwsIGdyZWF0LCBkb24ndApzZW5kIGl0IGluIGEgbWlkZGxlIG9mIHNlcmllcyBvZiBvdGhlciBw
YXRjaGVzIHRoYXQgYXJlIG5vdCwgaG93IGFtIEkKc3VwcG9zZWQgdG8ga25vdyBhbnkgb2YgdGhp
cz8KClBsZWFzZSBzZW5kIHRoZW0gaW4gdGhlIHByb3BlciBvcmRlciwgYW5kIGFzIGluZGl2aWR1
YWwgc2VyaWVzIGZvcgpkaWZmZXJlbnQgcmVsZWFzZXMsIGlmIHJlbGV2YW50LCBhZ2Fpbiwgb3Ro
ZXJ3aXNlIGhvdyBhbSBJIHN1cHBvc2VkIHRvCmtub3cgd2hhdCB0byBkbyB3aXRoIHRoZW0/Cgp0
aGFua3MsCgpncmVnIGstaApfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMu
bGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21h
aWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
