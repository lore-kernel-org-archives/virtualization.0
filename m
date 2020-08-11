Return-Path: <SRS0=ofWe=BV=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 472BEC433E1
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 08:30:11 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 106E9206DA
	for <virtualization@archiver.kernel.org>; Tue, 11 Aug 2020 08:30:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZBztK0BH"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 106E9206DA
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id BF13A87B0F;
	Tue, 11 Aug 2020 08:30:10 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id W3dMr5pjBl67; Tue, 11 Aug 2020 08:30:10 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 1CB8087933;
	Tue, 11 Aug 2020 08:30:10 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id EE796C013C;
	Tue, 11 Aug 2020 08:30:09 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 0A034C004D
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 08:30:08 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id ECCB1854C4
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 08:30:07 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Fmg5qgh327qN
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 08:30:07 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 53A3A854C9
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 08:30:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1597134606;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=kDxbTcL/Td6HbF1c9Y9dgTsZrWCIPjjlXYbn9U5Rp80=;
 b=ZBztK0BH61MCAIthbQWdE1tQ+4m+B/lSdH6gkPzhiMEg1+sqWPsL23jXu0S0H0VyWM3f+V
 CzgecgGi3K0LdKgiGzQQf/25a/3rSEgrAgOY3a1R1Oc+2CIkeLhixPLNelnkaQ/nECJ5ca
 4CvRC9mCuMpUP6B8rHiy8yd6ZR1g8HY=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-551-O5eFcIN_MZyZ6BDqOJ_LtA-1; Tue, 11 Aug 2020 04:30:02 -0400
X-MC-Unique: O5eFcIN_MZyZ6BDqOJ_LtA-1
Received: by mail-wm1-f72.google.com with SMTP id v8so713120wma.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Aug 2020 01:30:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=kDxbTcL/Td6HbF1c9Y9dgTsZrWCIPjjlXYbn9U5Rp80=;
 b=Ff1iIk4d5g0ROD2W0U8EyoMx5MolCYTeaDBIijaFCTr9hBYfmdgEhZE2xbTge+wfrw
 4Yv2jvbRbMobzMIRW1TdeNBUNzvMFxfPZBF/SVumdCKCaRTyp+71N3ow+hgAq9PihNTs
 9Y0/VjcWD4fieSe3XE/YvDrtA9d74fAclXgIPrmD+21JpYvfQl9zK+/b0zQtNMGiwIJ4
 eg97nda4FntND0dfogROPbg4e9zR1HjsSYJjpubZXPZmzBFfkYfLVMi6Ld54aOvnPQcY
 pnXV5/57ip04Wfhqfpr7IDnfR1IRSr5/MTDU0JolswWaRHBU3wEZ+k3fZrWp+AEQAaG3
 moew==
X-Gm-Message-State: AOAM530e+gikE5B63o6rzGIi9f2tAVVqmHkidBZ1xxoYgQse6lCI0Few
 9C2BFLxu+QVi+ikyWRcFPd1E5PR4B7DPhPnaWL4aQLk85RR/iXOPvVujW4ugW9CKZG0QPoI2g+i
 sScEAbN8/75RF8iEFGVViu8Cn+6l4U4SfEj5jploU2A==
X-Received: by 2002:adf:ed0c:: with SMTP id a12mr27814934wro.24.1597134600931; 
 Tue, 11 Aug 2020 01:30:00 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyjtEM1zq0msQDxGpjz9K/i33tZLCi9C7abT7E7t+vxf8KBB5p0LMjNivEK3rGdoE02KY+6Hg==
X-Received: by 2002:adf:ed0c:: with SMTP id a12mr27814913wro.24.1597134600692; 
 Tue, 11 Aug 2020 01:30:00 -0700 (PDT)
Received: from redhat.com ([192.117.173.58])
 by smtp.gmail.com with ESMTPSA id g14sm3815918wmk.37.2020.08.11.01.29.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 11 Aug 2020 01:29:59 -0700 (PDT)
Date: Tue, 11 Aug 2020 04:29:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/4] vdpa: introduce config op to get valid iova range
Message-ID: <20200811042733-mutt-send-email-mst@kernel.org>
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-2-jasowang@redhat.com>
 <20200805085035-mutt-send-email-mst@kernel.org>
 <20200806120354.GA171218@mtl-vdi-166.wap.labs.mlnx>
 <20200806082727-mutt-send-email-mst@kernel.org>
 <20200806124354.GA172661@mtl-vdi-166.wap.labs.mlnx>
 <20200810080410-mutt-send-email-mst@kernel.org>
 <2d1e6278-e57e-c340-399e-40ff102c74a3@redhat.com>
MIME-Version: 1.0
In-Reply-To: <2d1e6278-e57e-c340-399e-40ff102c74a3@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: shahafs@mellanox.com, lulu@redhat.com, saugatm@xilinx.com,
 mhabets@solarflare.com, vmireyno@marvell.com, linux-kernel@vger.kernel.org,
 gdawar@xilinx.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, hanand@xilinx.com, zhangweining@ruijie.com.cn,
 Eli Cohen <eli@mellanox.com>, lingshan.zhu@intel.com, rob.miller@broadcom.com
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

T24gVHVlLCBBdWcgMTEsIDIwMjAgYXQgMTA6NTM6MDlBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzgvMTAg5LiL5Y2IODowNSwgTWljaGFlbCBTLiBUc2lya2luIHdyb3Rl
Ogo+ID4gT24gVGh1LCBBdWcgMDYsIDIwMjAgYXQgMDM6NDM6NTRQTSArMDMwMCwgRWxpIENvaGVu
IHdyb3RlOgo+ID4gPiBPbiBUaHUsIEF1ZyAwNiwgMjAyMCBhdCAwODoyOToyMkFNIC0wNDAwLCBN
aWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6Cj4gPiA+ID4gT24gVGh1LCBBdWcgMDYsIDIwMjAgYXQg
MDM6MDM6NTVQTSArMDMwMCwgRWxpIENvaGVuIHdyb3RlOgo+ID4gPiA+ID4gT24gV2VkLCBBdWcg
MDUsIDIwMjAgYXQgMDg6NTE6NTZBTSAtMDQwMCwgTWljaGFlbCBTLiBUc2lya2luIHdyb3RlOgo+
ID4gPiA+ID4gPiBPbiBXZWQsIEp1biAxNywgMjAyMCBhdCAxMToyOTo0NEFNICswODAwLCBKYXNv
biBXYW5nIHdyb3RlOgo+ID4gPiA+ID4gPiA+IFRoaXMgcGF0Y2ggaW50cm9kdWNlIGEgY29uZmln
IG9wIHRvIGdldCB2YWxpZCBpb3ZhIHJhbmdlIGZyb20gdGhlIHZEUEEKPiA+ID4gPiA+ID4gPiBk
ZXZpY2UuCj4gPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSmFzb24g
V2FuZyA8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiA+ID4gPiA+ID4gPiAtLS0KPiA+ID4gPiA+ID4g
PiAgIGluY2x1ZGUvbGludXgvdmRwYS5oIHwgMTQgKysrKysrKysrKysrKysKPiA+ID4gPiA+ID4g
PiAgIDEgZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspCj4gPiA+ID4gPiA+ID4gCj4gPiA+
ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvdmRwYS5oIGIvaW5jbHVkZS9saW51
eC92ZHBhLmgKPiA+ID4gPiA+ID4gPiBpbmRleCAyMzlkYjc5NDM1N2MuLmI3NjMzZWQyNTAwYyAx
MDA2NDQKPiA+ID4gPiA+ID4gPiAtLS0gYS9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+ID4gPiA+ID4g
PiA+ICsrKyBiL2luY2x1ZGUvbGludXgvdmRwYS5oCj4gPiA+ID4gPiA+ID4gQEAgLTQxLDYgKzQx
LDE2IEBAIHN0cnVjdCB2ZHBhX2RldmljZSB7Cj4gPiA+ID4gPiA+ID4gICAJdW5zaWduZWQgaW50
IGluZGV4Owo+ID4gPiA+ID4gPiA+ICAgfTsKPiA+ID4gPiA+ID4gPiArLyoqCj4gPiA+ID4gPiA+
ID4gKyAqIHZEUEEgSU9WQSByYW5nZSAtIHRoZSBJT1ZBIHJhbmdlIHN1cHBvcnQgYnkgdGhlIGRl
dmljZQo+ID4gPiA+ID4gPiA+ICsgKiBAc3RhcnQ6IHN0YXJ0IG9mIHRoZSBJT1ZBIHJhbmdlCj4g
PiA+ID4gPiA+ID4gKyAqIEBlbmQ6IGVuZCBvZiB0aGUgSU9WQSByYW5nZQo+ID4gPiA+ID4gPiA+
ICsgKi8KPiA+ID4gPiA+ID4gPiArc3RydWN0IHZkcGFfaW92YV9yYW5nZSB7Cj4gPiA+ID4gPiA+
ID4gKwl1NjQgc3RhcnQ7Cj4gPiA+ID4gPiA+ID4gKwl1NjQgZW5kOwo+ID4gPiA+ID4gPiA+ICt9
Owo+ID4gPiA+ID4gPiA+ICsKPiA+ID4gPiA+ID4gCj4gPiA+ID4gPiA+IFRoaXMgaXMgYW1iaWd1
b3VzLiBJcyBlbmQgaW4gdGhlIHJhbmdlIG9yIGp1c3QgYmVoaW5kIGl0Pwo+ID4gPiA+ID4gPiBI
b3cgYWJvdXQgZmlyc3QvbGFzdD8KPiA+ID4gPiA+IEl0IGlzIGN1c3RvbWFyeSBpbiB0aGUga2Vy
bmVsIHRvIHVzZSBzdGFydC1lbmQgd2hlcmUgZW5kIGNvcnJlc3BvbmRzIHRvCj4gPiA+ID4gPiB0
aGUgYnl0ZSBmb2xsb3dpbmcgdGhlIGxhc3QgaW4gdGhlIHJhbmdlLiBTZWUgc3RydWN0IHZtX2Fy
ZWFfc3RydWN0Cj4gPiA+ID4gPiB2bV9zdGFydCBhbmQgdm1fZW5kIGZpZWxkcwo+ID4gPiA+IEV4
YWN0bHkgbXkgcG9pbnQ6Cj4gPiA+ID4gCj4gPiA+ID4gaW5jbHVkZS9saW51eC9tbV90eXBlcy5o
OiAgICAgICB1bnNpZ25lZCBsb25nIHZtX2VuZDsgICAgICAgICAgIC8qIFRoZSBmaXJzdCBieXRl
IGFmdGVyIG91ciBlbmQgYWRkcmVzcwo+ID4gPiA+IAo+ID4gPiA+IGluIHRoaXMgY2FzZSBKYXNv
biB3YW50cyBpdCB0byBiZSB0aGUgbGFzdCBieXRlLCBub3Qgb25lIGJlaGluZC4KPiA+ID4gPiAK
PiA+ID4gPiAKPiA+ID4gTWF5YmUgc3RhcnQsIHNpemU/IE5vdCBhbWJpZ3VvdXMsIGFuZCB5b3Ug
ZG9uJ3QgbmVlZCB0byBkbyBhbm5veWluZwo+ID4gPiBjYWxjdWxhdGlvbnMgbGlrZSBzaXplID0g
bGFzdCAtIHN0YXJ0ICsgMQo+ID4gU2l6ZSBoYXMgYSBidW5jaCBvZiBpc3N1ZXM6IGNhbiBvdmVy
bGFwLCBjYW4gbm90IGNvdmVyIHRoZSBlbnRpcmUgNjQgYml0Cj4gPiByYW5nZS4gVGhlIHJlcXVp
c2l0ZSBjaGVja3MgYXJlIGFyZ3VhYmx5IGVhc2llciB0byBnZXQgd3JvbmcgdGhhbgo+ID4gZ2V0
dGluZyB0aGUgc2l6ZSBpZiB5b3UgbmVlZCBpdC4KPiAKPiAKPiBZZXMsIHNvIGRvIHlvdSBzdGls
bCBwcmVmZXIgZmlyc3QvbGFzdCBvciBqdXN0IGJlZ2luL2VuZCB3aGljaCBpcyBjb25zaXN0ZW50
Cj4gd2l0aCBpb21tdV9kb21haW5fZ2VvbWV0cnk/Cj4gCj4gVGhhbmtzCgpJIHByZWZlciBmaXJz
dC9sYXN0IEkgdGhpbmssIHRoZXNlIGFyZSB1bmFtYmlndW91cy4KRS5nLgoKICAgICAgICBkbWFf
YWRkcl90IGFwZXJ0dXJlX3N0YXJ0OyAvKiBGaXJzdCBhZGRyZXNzIHRoYXQgY2FuIGJlIG1hcHBl
ZCAgICAqLwogICAgICAgIGRtYV9hZGRyX3QgYXBlcnR1cmVfZW5kOyAgIC8qIExhc3QgYWRkcmVz
cyB0aGF0IGNhbiBiZSBtYXBwZWQgICAgICovCgppbnN0ZWFkIG9mIGFkZHJlc3NpbmcgYW1iaWd1
aXR5IHdpdGggYSBjb21tZW50LCBsZXQncyBqdXN0IG5hbWUgdGhlIGZpZWxkIHdlbGwuCgoKCj4g
Cj4gPiAKCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZp
cnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3Vu
ZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0
aW5mby92aXJ0dWFsaXphdGlvbg==
