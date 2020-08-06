Return-Path: <SRS0=OwTx=BQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4B9F6C433DF
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 11:06:07 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 356CD221E2
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 11:06:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="bE+CXWiq"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 356CD221E2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id ACAA28874E;
	Thu,  6 Aug 2020 07:27:50 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id M2zc3ALypHsE; Thu,  6 Aug 2020 07:27:50 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 20C6288748;
	Thu,  6 Aug 2020 07:27:50 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 0290DC0050;
	Thu,  6 Aug 2020 07:27:50 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CE188C004C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 07:27:48 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id B6FA58874A
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 07:27:48 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 3wVkaLOisPiV
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 07:27:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-1.mimecast.com (us-smtp-1.mimecast.com
 [205.139.110.61])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 2231088748
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 07:27:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596698866;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=cSEgSN8jfUJDf4nQ15dUO0iKrtDrvU+69JPCGlGa9N4=;
 b=bE+CXWiq/VwxRHjFRl5qersoCmrMbrwYYSLnajsE5F1vADViBfeBfU8nRift2W8G34zbbE
 sctk1G9hanhXsCI0tR35J6FJNytoHn2va3bPr5pnCjJBY3fgvIQ0g4LUh5vjS08iQsDyFS
 ff+Xhl/8nYlaYImQOsoVBnBnO3WklZ0=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-24-ZgpqMcwWNTKyEtlSpoDpBg-1; Thu, 06 Aug 2020 03:27:44 -0400
X-MC-Unique: ZgpqMcwWNTKyEtlSpoDpBg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DB0DD8015F3;
 Thu,  6 Aug 2020 07:27:43 +0000 (UTC)
Received: from [10.72.13.107] (ovpn-13-107.pek2.redhat.com [10.72.13.107])
 by smtp.corp.redhat.com (Postfix) with ESMTP id D846D87A58;
 Thu,  6 Aug 2020 07:27:39 +0000 (UTC)
Subject: Re: [PATCH v2 19/24] vdpa: make sure set_features in invoked for
 legacy
To: "Michael S. Tsirkin" <mst@redhat.com>
References: <20200803205814.540410-1-mst@redhat.com>
 <20200803205814.540410-20-mst@redhat.com>
 <9e47d227-f220-4651-dcb9-7a11f059a715@redhat.com>
 <20200805073929-mutt-send-email-mst@kernel.org>
 <bd915b30-0604-da1b-343f-e228bce4d1d8@redhat.com>
 <20200806015112-mutt-send-email-mst@kernel.org>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <cc5cb366-be79-908d-edc6-4aebb488cc59@redhat.com>
Date: Thu, 6 Aug 2020 15:27:38 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200806015112-mutt-send-email-mst@kernel.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
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

Ck9uIDIwMjAvOC82IOS4i+WNiDE6NTMsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToKPiBPbiBU
aHUsIEF1ZyAwNiwgMjAyMCBhdCAxMToyMzowNUFNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+
PiBPbiAyMDIwLzgvNSDkuIvljYg3OjQwLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4+PiBP
biBXZWQsIEF1ZyAwNSwgMjAyMCBhdCAwMjoxNDowN1BNICswODAwLCBKYXNvbiBXYW5nIHdyb3Rl
Ogo+Pj4+IE9uIDIwMjAvOC80IOS4iuWNiDU6MDAsIE1pY2hhZWwgUy4gVHNpcmtpbiB3cm90ZToK
Pj4+Pj4gU29tZSBsZWdhY3kgZ3Vlc3RzIGp1c3QgYXNzdW1lIGZlYXR1cmVzIGFyZSAwIGFmdGVy
IHJlc2V0Lgo+Pj4+PiBXZSBkZXRlY3QgdGhhdCBjb25maWcgc3BhY2UgaXMgYWNjZXNzZWQgYmVm
b3JlIGZlYXR1cmVzIGFyZQo+Pj4+PiBzZXQgYW5kIHNldCBmZWF0dXJlcyB0byAwIGF1dG9tYXRp
Y2FsbHkuCj4+Pj4+IE5vdGU6IHNvbWUgbGVnYWN5IGd1ZXN0cyBtaWdodCBub3QgZXZlbiBhY2Nl
c3MgY29uZmlnIHNwYWNlLCBpZiB0aGlzIGlzCj4+Pj4+IHJlcG9ydGVkIGluIHRoZSBmaWVsZCB3
ZSBtaWdodCBuZWVkIHRvIGNhdGNoIGEga2ljayB0byBoYW5kbGUgdGhlc2UuCj4+Pj4gSSB3b25k
ZXIgd2hldGhlciBpdCdzIGVhc2llciB0byBqdXN0IHN1cHBvcnQgbW9kZXJuIGRldmljZT8KPj4+
Pgo+Pj4+IFRoYW5rcwo+Pj4gV2VsbCBoYXJkd2FyZSB2ZW5kb3JzIGFyZSBJIHRoaW5rIGludGVy
ZXN0ZWQgaW4gc3VwcG9ydGluZyBsZWdhY3kKPj4+IGd1ZXN0cy4gTGltaXRpbmcgdmRwYSB0byBt
b2Rlcm4gb25seSB3b3VsZCBtYWtlIGl0IHVuY29tcGV0aXRpdmUuCj4+Cj4+IE15IHVuZGVyc3Rh
bmRpbmcgaXMgdGhhdCwgSU9NTVVfUExBVEZPUk0gaXMgbWFuZGF0b3J5IGZvciBoYXJkd2FyZSB2
RFBBIHRvCj4+IHdvcmsuCj4gSG1tIEkgZG9uJ3QgcmVhbGx5IHNlZSB3aHkuIEFzc3VtZSBob3N0
IG1hcHMgZ3Vlc3QgbWVtb3J5IHByb3Blcmx5LAo+IFZNIGRvZXMgbm90IGhhdmUgYW4gSU9NTVUs
IGxlZ2FjeSBndWVzdCBjYW4ganVzdCB3b3JrLgoKClllcywgZ3Vlc3QgbWF5IG5vdCBzZXQgSU9N
TVVfUExBVEZPUk0uCgoKPgo+IENhcmUgZXhwbGFpbmluZyB3aGF0J3Mgd3Jvbmcgd2l0aCB0aGlz
IHBpY3R1cmU/CgoKVGhlIHByb2JsZW0gaXMgdmlydGlvX3ZkcGEsIHdpdGhvdXQgSU9NTVVfUExB
VEZPUk0gaXQgdXNlcyBQQSB3aGljaCBjYW4gCm5vdCB3b3JrIGlmIElPTU1VIGlzIGVuYWJsZWQu
CgpUaGFua3MKCgo+Cj4KPj4gU28gaXQgY2FuIG9ubHkgd29yayBmb3IgbW9kZXJuIGRldmljZSAu
Li4KPj4KPj4gVGhhbmtzCj4+Cj4+Cj4+Pgo+Pj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFs
aXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91
bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
