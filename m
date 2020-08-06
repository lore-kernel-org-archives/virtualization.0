Return-Path: <SRS0=OwTx=BQ=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D928C433E0
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 11:53:03 +0000 (UTC)
Received: from silver.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 52EBC22CF7
	for <virtualization@archiver.kernel.org>; Thu,  6 Aug 2020 11:53:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M8rojZlM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 52EBC22CF7
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by silver.osuosl.org (Postfix) with ESMTP id 6217323B81;
	Thu,  6 Aug 2020 05:54:31 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from silver.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3YsBbPtjRUWU; Thu,  6 Aug 2020 05:54:29 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by silver.osuosl.org (Postfix) with ESMTP id 7B0E2227FC;
	Thu,  6 Aug 2020 05:54:29 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 6B224C0050;
	Thu,  6 Aug 2020 05:54:29 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id CEB3CC004C
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 05:54:27 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by hemlock.osuosl.org (Postfix) with ESMTP id BD478887D4
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 05:54:27 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id VYO-hUly8ZId
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 05:54:26 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-1.mimecast.com (us-smtp-delivery-1.mimecast.com
 [207.211.31.120])
 by hemlock.osuosl.org (Postfix) with ESMTPS id 26C4D887D3
 for <virtualization@lists.linux-foundation.org>;
 Thu,  6 Aug 2020 05:54:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1596693264;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=mRThbniOH3H+nnbkiN1VpyYC3E+J3eqp2bqKy/0XWfw=;
 b=M8rojZlM7lqA8/xQfmmOUKN/buVBiM0ud8g4uGns9I6CY5F6gJZJFv/GINsZKwx87lCQZj
 mPFgIcFqLPyU3B5u+DbvDEpzQHfd7GN/mWyoWnxZFiwA1SPzz4tW/1JbZg8uta2z6ikI7J
 WS9dVOQsR+/sEUReVQ1J5B3bOjWhk6Y=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-eesWJPVmMOWBCod1Ekg9hg-1; Thu, 06 Aug 2020 01:54:22 -0400
X-MC-Unique: eesWJPVmMOWBCod1Ekg9hg-1
Received: by mail-wm1-f70.google.com with SMTP id s4so3175335wmh.1
 for <virtualization@lists.linux-foundation.org>;
 Wed, 05 Aug 2020 22:54:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=mRThbniOH3H+nnbkiN1VpyYC3E+J3eqp2bqKy/0XWfw=;
 b=hJLhLhwhBC2SmBI1ATnBt9DhbWKCsbaNVpbyD8RctcXj2aerHkqdHFtH2AMv1ZQtps
 qAmjm0y2U8WMot9RvrvPDkImWcDdYdrCnfgmW3KCMYAVp7k8O1JmHYLDvJYoh8vGH0aM
 WyViZY+Wt6K+LSa2A39EIsEdHqUN99E82cPLAz90CfZnZEjzWGiAmp+mfeAALUWPi43D
 +Da4GHEykOI7EGOvavPUEuk/+HY1yeM3Yk56G4Dkzpfv6HAAwwAqqbCD4mtqLO290/30
 sEy0EzNUeN8ZiTTrTA+Z10REWD5woMv8/DzbtaRup1jlg/tGTMaJTjnTC8vd5OVD5wOZ
 qgYA==
X-Gm-Message-State: AOAM531+e0rlcQF8jK6BYmcGx9UwjEcBnEvU2TkfBX01bhXQu8dGj6Jc
 b+LjJOUPKUU95nwcEpcF5Q3I80oqfHO8M/RBsAi8qvcDvls+K/9Z0NQhPGbFUNxzz6mhvvGz0Vn
 gyHAF3gi73EAEB7BOcYIy3anSR2Mn+dv3SsbfnpHTdg==
X-Received: by 2002:adf:8405:: with SMTP id 5mr5649912wrf.393.1596693261196;
 Wed, 05 Aug 2020 22:54:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxMrWFVN7pqHpJZjnHy/aa/ngOxq7QmYPGN0WYucLhG9zbO1xWKLwEAt5Uz4zpDVEHC2CH3WA==
X-Received: by 2002:adf:8405:: with SMTP id 5mr5649901wrf.393.1596693261026;
 Wed, 05 Aug 2020 22:54:21 -0700 (PDT)
Received: from redhat.com (bzq-79-177-102-128.red.bezeqint.net.
 [79.177.102.128])
 by smtp.gmail.com with ESMTPSA id z66sm5047641wme.16.2020.08.05.22.54.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 22:54:20 -0700 (PDT)
Date: Thu, 6 Aug 2020 01:54:17 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH 1/4] vdpa: introduce config op to get valid iova range
Message-ID: <20200806015336-mutt-send-email-mst@kernel.org>
References: <20200617032947.6371-1-jasowang@redhat.com>
 <20200617032947.6371-2-jasowang@redhat.com>
 <20200805085035-mutt-send-email-mst@kernel.org>
 <777d6e78-4271-10e9-4546-329f53962429@redhat.com>
MIME-Version: 1.0
In-Reply-To: <777d6e78-4271-10e9-4546-329f53962429@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: shahafs@mellanox.com, lulu@redhat.com, saugatm@xilinx.com,
 mhabets@solarflare.com, vmireyno@marvell.com, linux-kernel@vger.kernel.org,
 gdawar@xilinx.com, virtualization@lists.linux-foundation.org,
 eperezma@redhat.com, hanand@xilinx.com, zhangweining@ruijie.com.cn,
 eli@mellanox.com, lingshan.zhu@intel.com, rob.miller@broadcom.com
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

T24gVGh1LCBBdWcgMDYsIDIwMjAgYXQgMTE6MjU6MTFBTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzgvNSDkuIvljYg4OjUxLCBNaWNoYWVsIFMuIFRzaXJraW4gd3JvdGU6
Cj4gPiBPbiBXZWQsIEp1biAxNywgMjAyMCBhdCAxMToyOTo0NEFNICswODAwLCBKYXNvbiBXYW5n
IHdyb3RlOgo+ID4gPiBUaGlzIHBhdGNoIGludHJvZHVjZSBhIGNvbmZpZyBvcCB0byBnZXQgdmFs
aWQgaW92YSByYW5nZSBmcm9tIHRoZSB2RFBBCj4gPiA+IGRldmljZS4KPiA+ID4gCj4gPiA+IFNp
Z25lZC1vZmYtYnk6IEphc29uIFdhbmc8amFzb3dhbmdAcmVkaGF0LmNvbT4KPiA+ID4gLS0tCj4g
PiA+ICAgaW5jbHVkZS9saW51eC92ZHBhLmggfCAxNCArKysrKysrKysrKysrKwo+ID4gPiAgIDEg
ZmlsZSBjaGFuZ2VkLCAxNCBpbnNlcnRpb25zKCspCj4gPiA+IAo+ID4gPiBkaWZmIC0tZ2l0IGEv
aW5jbHVkZS9saW51eC92ZHBhLmggYi9pbmNsdWRlL2xpbnV4L3ZkcGEuaAo+ID4gPiBpbmRleCAy
MzlkYjc5NDM1N2MuLmI3NjMzZWQyNTAwYyAxMDA2NDQKPiA+ID4gLS0tIGEvaW5jbHVkZS9saW51
eC92ZHBhLmgKPiA+ID4gKysrIGIvaW5jbHVkZS9saW51eC92ZHBhLmgKPiA+ID4gQEAgLTQxLDYg
KzQxLDE2IEBAIHN0cnVjdCB2ZHBhX2RldmljZSB7Cj4gPiA+ICAgCXVuc2lnbmVkIGludCBpbmRl
eDsKPiA+ID4gICB9Owo+ID4gPiArLyoqCj4gPiA+ICsgKiB2RFBBIElPVkEgcmFuZ2UgLSB0aGUg
SU9WQSByYW5nZSBzdXBwb3J0IGJ5IHRoZSBkZXZpY2UKPiA+ID4gKyAqIEBzdGFydDogc3RhcnQg
b2YgdGhlIElPVkEgcmFuZ2UKPiA+ID4gKyAqIEBlbmQ6IGVuZCBvZiB0aGUgSU9WQSByYW5nZQo+
ID4gPiArICovCj4gPiA+ICtzdHJ1Y3QgdmRwYV9pb3ZhX3JhbmdlIHsKPiA+ID4gKwl1NjQgc3Rh
cnQ7Cj4gPiA+ICsJdTY0IGVuZDsKPiA+ID4gK307Cj4gPiA+ICsKPiA+IFRoaXMgaXMgYW1iaWd1
b3VzLiBJcyBlbmQgaW4gdGhlIHJhbmdlIG9yIGp1c3QgYmVoaW5kIGl0Pwo+IAo+IAo+IEluIHRo
ZSByYW5nZS4KCk9LIEkgZ3Vlc3Mgd2UgY2FuIHRyZWF0IGl0IGFzIGEgYnVnZml4IGFuZCBtZXJn
ZSBhZnRlciByYzEsCmJ1dCBwbHMgYWRkIGEgYml0IG1vcmUgaW4gdGhlIGNvbW1pdCBsb2cgYWJv
dXQgd2hhdCdzCmN1cnJlbnRseSBicm9rZW4uCgo+IAo+ID4gSG93IGFib3V0IGZpcnN0L2xhc3Q/
Cj4gCj4gCj4gU3VyZS4KPiAKPiBUaGFua3MKPiAKPiAKPiA+IAo+ID4gCj4gPiAKCl9fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1h
aWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRw
czovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXph
dGlvbg==
