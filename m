Return-Path: <SRS0=J2aX=NH=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8C3EFC4338F
	for <virtualization@archiver.kernel.org>; Mon, 16 Aug 2021 04:16:33 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2B57360F21
	for <virtualization@archiver.kernel.org>; Mon, 16 Aug 2021 04:16:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2B57360F21
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id DDCDB40391;
	Mon, 16 Aug 2021 04:16:32 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qsgv4XOm85FU; Mon, 16 Aug 2021 04:16:28 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp4.osuosl.org (Postfix) with ESMTPS id E140E4038D;
	Mon, 16 Aug 2021 04:16:27 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id B6BA5C001A;
	Mon, 16 Aug 2021 04:16:27 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 5C8D0C000E
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 04:16:26 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 305E4401F5
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 04:16:26 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp2.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id UhSAPR_TofZt
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 04:16:23 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id 23F93401AE
 for <virtualization@lists.linux-foundation.org>;
 Mon, 16 Aug 2021 04:16:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1629087381;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3Yapy6JT856xeWfrbb0ynFORLwvvMSnZlRswIeeztzg=;
 b=gEKEXxmqNctOzltozI5csFNpkVfZTj5zu/2m9ppJNCc6dSGbr3EHPiC5VCXlbQqJhMhEra
 BmiqWPDXWYu9r7sMLq1I05SJFbPRibDI4jL96yIx7auIwhHV1k4WdDgcOljFXh4kyBixX8
 E1K7o7JUIlLzXxycmOEPBI2D6Zdd2HY=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-219-aYTrXMA9NyCZj299UI6MkQ-1; Mon, 16 Aug 2021 00:16:19 -0400
X-MC-Unique: aYTrXMA9NyCZj299UI6MkQ-1
Received: by mail-pj1-f69.google.com with SMTP id
 fs12-20020a17090af28c00b001797c5272b7so2333076pjb.9
 for <virtualization@lists.linux-foundation.org>;
 Sun, 15 Aug 2021 21:16:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-transfer-encoding
 :content-language;
 bh=3Yapy6JT856xeWfrbb0ynFORLwvvMSnZlRswIeeztzg=;
 b=jyOs74ad2y7CJBp174Ro9gfADP5Cf/XA3Si/6xbjXMixRrf20ZadQuYbiAatIoAHLR
 Lz0GgY+4jjw3dLNXGELVkguWsXVTgwZO+RcZifSsc+sj9jRd29G+f5PRjKMUoekQk2dZ
 geNi4355wO/uy4+Jt/4WljVNE0jGtz9g8pBBuICmkf6af4JvpZLWggc5eNve/On1u8s+
 /xSX/XrtPc8iyjDxPYSvLcCicwPDN+1GkGcCMt8o6ZauIz+RtBgTZIhu2B4JvU4dr1Zs
 TBg/QRAe9H8v4Z1EoHyh0BfaI5B9KhT77zoU0DW8Nc5rMPDtVUMD5Hh5YlSxZnHNBm9w
 LuBQ==
X-Gm-Message-State: AOAM531S0v2dmCKeUNnLsL/VRD/N99+QwgeXzrlL1p4piZY1TuYixYzp
 2x01/9rIa/dDEBDbsdj8gyEsXLc4mucW3qDRZU49JFfDvDJ73t1MkdAg3vNNDscYgfgeOGNk3CY
 KTaXk+hvoT9yZvbG97ZedcJRPsgQGkR5V6oS446HcWg==
X-Received: by 2002:a17:90a:2c05:: with SMTP id
 m5mr15499326pjd.32.1629087378916; 
 Sun, 15 Aug 2021 21:16:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyShbkFNRF8bl42UsjAv++Jy0jQFce4G0Em9bTVcd7niCyxKMOarxdgtKRjtkQ5Qk83hoPygQ==
X-Received: by 2002:a17:90a:2c05:: with SMTP id
 m5mr15499305pjd.32.1629087378611; 
 Sun, 15 Aug 2021 21:16:18 -0700 (PDT)
Received: from wangxiaodeMacBook-Air.local ([209.132.188.80])
 by smtp.gmail.com with ESMTPSA id h130sm9486466pfe.34.2021.08.15.21.16.15
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 15 Aug 2021 21:16:18 -0700 (PDT)
Subject: Re: [Patch v1 3/3] vdpa/mlx5: Add multiqueue support
To: Eli Cohen <elic@nvidia.com>
References: <20210809140800.97835-4-elic@nvidia.com>
 <07002568-e792-aa35-ec42-5e0f12883a03@redhat.com>
 <20210811075347.GC56418@mtl-vdi-166.wap.labs.mlnx>
 <fccc39c8-f9af-e489-8804-511cb07f1ed2@redhat.com>
 <20210811110401.GB64192@mtl-vdi-166.wap.labs.mlnx>
 <c318303b-3774-909a-a532-2189e9e5a3b9@redhat.com>
 <20210812045535.GA99755@mtl-vdi-166.wap.labs.mlnx>
 <CACGkMEsyHiia5DrRU0nLy_OkUZLcQ1==y4Gxy1sETWpVQpVXvg@mail.gmail.com>
 <20210812070151.GA103566@mtl-vdi-166.wap.labs.mlnx>
 <2cc15e3e-bd5c-8e43-1d2f-b0e03b8690d5@redhat.com>
 <20210812095035.GA105096@mtl-vdi-166.wap.labs.mlnx>
From: Jason Wang <jasowang@redhat.com>
Message-ID: <61b913bb-3f6b-49d4-f5f1-32dce3bd7fae@redhat.com>
Date: Mon, 16 Aug 2021 12:16:14 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.13.0
MIME-Version: 1.0
In-Reply-To: <20210812095035.GA105096@mtl-vdi-166.wap.labs.mlnx>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jasowang@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Cc: eperezma <eperezma@redhat.com>,
 virtualization <virtualization@lists.linux-foundation.org>,
 mst <mst@redhat.com>
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

CuWcqCAyMDIxLzgvMTIg5LiL5Y2INTo1MCwgRWxpIENvaGVuIOWGmemBkzoKPiBPbiBUaHUsIEF1
ZyAxMiwgMjAyMSBhdCAwMzowNDozNVBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+PiDlnKgg
MjAyMS84LzEyIOS4i+WNiDM6MDEsIEVsaSBDb2hlbiDlhpnpgZM6Cj4+PiBPbiBUaHUsIEF1ZyAx
MiwgMjAyMSBhdCAwMjo0NzowNlBNICswODAwLCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+IE9uIFRo
dSwgQXVnIDEyLCAyMDIxIGF0IDEyOjU1IFBNIEVsaSBDb2hlbiA8ZWxpY0BudmlkaWEuY29tPiB3
cm90ZToKPj4+Pj4gT24gVGh1LCBBdWcgMTIsIDIwMjEgYXQgMTE6MTk6MTlBTSArMDgwMCwgSmFz
b24gV2FuZyB3cm90ZToKPj4+Pj4+IOWcqCAyMDIxLzgvMTEg5LiL5Y2INzowNCwgRWxpIENvaGVu
IOWGmemBkzoKPj4+Pj4+PiBPbiBXZWQsIEF1ZyAxMSwgMjAyMSBhdCAwNDozNzo0NFBNICswODAw
LCBKYXNvbiBXYW5nIHdyb3RlOgo+Pj4+Pj4+PiDlnKggMjAyMS84LzExIOS4i+WNiDM6NTMsIEVs
aSBDb2hlbiDlhpnpgZM6Cj4+Pj4+Pj4+Pj4gT25lIHRoaW5nIG5lZWQgdG8gc29sdmUgZm9yIG1x
IGlzIHRoYXQgdGhlOgo+Pj4+Pj4+Pj4+Cj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+Pj4gK3N0YXRpYyB1
MTYgY3RybF92cV9pZHgoc3RydWN0ICBtbHg1X3ZkcGFfZGV2ICptdmRldikKPj4+Pj4+Pj4+Pj4g
K3sKPj4+Pj4+Pj4+Pj4gKyAgICAgcmV0dXJuIDIgKiAgbWx4NV92ZHBhX21heF9xcHMobXZkZXYt
Pm1heF92cXMpOwo+Pj4+Pj4+Pj4+PiArfQo+Pj4+Pj4+Pj4+IFdlIHNob3VsZCBoYW5kbGUgdGhl
IGNhc2Ugd2hlbiBNUSBpcyBzdXBwb3J0ZWQgYnkgdGhlIGRldmljZSBidXQgbm90IHRoZQo+Pj4+
Pj4+Pj4+IGRyaXZlci4KPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IEUuZyBpbiB0aGUgY2FzZSB3aGVu
IHdlIGhhdmUgMiBxdWV1ZSBwYWlyczoKPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IFdoZW4gTVEgaXMg
ZW5hYmxlZCwgY3ZxIGlzIHF1ZXVlIDQKPj4+Pj4+Pj4+Pgo+Pj4+Pj4+Pj4+IFdoZW4gTVEgaXMg
bm90IGVuYWJsZWQsIGN2cSBpcyBxdWV1ZSAyCj4+Pj4+Pj4+Pj4KPj4+Pj4+Pj4+IFRoZXJlJ3Mg
c29tZSBpc3N1ZSB3aXRoIHRoaXMuIEkgZ2V0IGNhbGxiYWNrcyB0YXJnZXRpbmcgc3BlY2lmaWMK
Pj4+Pj4+Pj4+IHZpcnRxdWV1ZXMgYmVmb3JlIGZlYXR1cmVzIG5lZ290aWF0aW9uIGhhcyBiZWVu
IGNvbXBsZXRlZC4KPj4+Pj4+Pj4+Cj4+Pj4+Pj4+PiBTcGVjaWZpY2FsbHksIEkgZ2V0IHNldF92
cV9jYigpIGNhbGxzLiBBdCB0aGlzIHBvaW50IEkgbXVzdCBrbm93IHRoZQo+Pj4+Pj4+Pj4gY29u
dHJvbCB2cSBpbmRleC4KPj4+Pj4+Pj4gU28gSSB0aGluayB3ZSBuZWVkIGRvIGJvdGg6Cj4+Pj4+
Pj4+Cj4+Pj4+Pj4+IDEpIEF0IG9uZSBoYW5kLCBpdCdzIGEgYnVnIGZvciB0aGUgdXNlcnNwYWNl
IHRvIHVzZSB2cV9pbmRleCBiZWZvcmUgZmVhdHVyZQo+Pj4+Pj4+PiBpcyBuZWdvdGlhdGVkCj4+
Pj4+Pj4+Cj4+Pj4+Pj4+IChsb29rcyBsaWtlIGEgYnVnIGluIG15IGN2cSBzZXJpZXMgdGhhdCB3
aWxsIGNhbGwgU0VUX1ZSSU5HX0NBTEwgYmVmb3JlCj4+Pj4+Pj4+IGZlYXR1cmUgaXMgbmVnb3Rp
YXRlLCB3aGljaCBJIHdpbGwgbG9vaykuCj4+Pj4+Pj4+Cj4+Pj4+Pj4+IDIpIEF0IHRoZSBvdGhl
ciBoYW5kLCB0aGUgZHJpdmVyIHNob3VsZCBiZSBhYmxlIHRvIGRlYWwgd2l0aCB0aGF0Cj4+Pj4+
Pj4+Cj4+Pj4+Pj4gQWxsIEkgY2FuIGRvIGlzIGRyb3AgY2FsbGJhY2tzIGZvciBWUXMgYmVmb3Jl
IGZlYXR1cmVzIG5lZ290YXRpb24gaGFzCj4+Pj4+Pj4gYmVlbiBjb21wbGV0ZWQuCj4+Pj4+PiBP
ciBqdXN0IGxlYXZlIHF1ZXVlIGluZGV4IDAsIDEgd29yay4KPj4+Pj4+Cj4+Pj4+PiBTaW5jZSBp
dCBpcyBub3QgZXhwZWN0ZWQgdG8gYmUgY2hhbmdlZC4KPj4+Pj4+Cj4+Pj4+IFJpZ2h0LCB3aWxs
IGRvLgo+Pj4+Pgo+Pj4+Pj4+Pj4gSSB0aGluayB0aGUgQ1ZRIGluZGV4IG11c3Qgbm90IGRlcGVu
ZCBvbiB0aGUgbmVnb3RpYXRlZCBmZWF0dXJlcyBidXQKPj4+Pj4+Pj4+IHJhdGhlciBkZXBlbmQg
b2YgdGhlIHZhbHVlIHRoZSBkZXZpY2UgZHJpdmVyIHByb3ZpZGVzIGluIHRoZSBjYWxsIHRvCj4+
Pj4+Pj4+PiBfdmRwYV9yZWdpc3Rlcl9kZXZpY2UoKS4KPj4+Pj4+Pj4gQXQgdGhlIHZpcnRpbyBs
ZXZlbCwgaXQncyB0b28gbGF0ZSB0byBjaGFuZ2UgdGhhdCBhbmQgaXQgYnJlYWtzIHRoZSBiYWNr
d2FyZAo+Pj4+Pj4+PiBjb21wYXRpYmlsaXR5Lgo+Pj4+Pj4+Pgo+Pj4+Pj4+PiBCdXQgYXQgdGhl
IHZEUEEgbGV2ZWwsIHRoZSB1bmRlciBsYXllciBkZXZpY2UgY2FuIG1hcCB2aXJ0aW8gY3ZxIHRv
IGFueSBvZgo+Pj4+Pj4+PiBpdCdzIHZpcnRxdWV1ZS4KPj4+Pj4+Pj4KPj4+Pj4+Pj4gRS5nIG1h
cCBjdnEgKGluZGV4IDIpIHRvIG1seDUgY3ZxICh0aGUgbGFzdCkuCj4+Pj4+Pj4+Cj4+Pj4+Pj4g
SSBhbSBub3QgZm9sbG93aW5nIHlvdSBoZXJlLiBJIHN0aWxsIGRvbid0IGtub3cgd2hhdCBpbmRl
eCBpcyBjdnEuCj4+Pj4+PiBSaWdodCwgd2Ugc3RpbGwgbmVlZCB0byB3YWl0IGZvciB0aGUgZmVh
dHVyZSBiZWluZyBuZWdvdGlhdGVkIGluIG9yZGVyIHRvCj4+Pj4+PiBwcm9jZWVkLgo+Pj4+Pj4K
Pj4+Pj4gU28gdG8gc3VtbWFyaXNlLCBiZWZvcmUgZmVhdHVyZSBuZWdvdGlhdGlvbiBjb21wbGV0
ZSwgSSBhY2NlcHQgY2FsbHMKPj4+Pj4gcmVmZXJyaW5nIHRvIFZRcyBvbmx5IGZvciBpbmRpY2Vz
IDAgYW5kIDEuCj4+Pj4+IEFmdGVyIGZlYXR1cmUgbmVnb3RpYXRpb24gY29tcGxldGUgSSBrbm93
IENWUSBpbmRleCBhbmQgd2lsbCBhY2NlcHQKPj4+Pj4gaW5kaWNlcyAwIHRvIGN2cSBpbmRleC4K
Pj4+PiBJIGRvbid0IGdldCB0aGlzICJhY2NlcHQgaW5kaWNlcyAwIHRvIGN2cSBpbmRleCIuCj4+
PiBXaGF0IEkgbWVhbnQgdG8gc2F5IGlzIHRoYXQgdGhlcmUgYXJlIHNldmVyYWwgY2FsbGJhY2tz
IHRoYXQgcmVmZXIgdG8KPj4+IHNwZWNpZmljIHZpcnRxdWV1ZXMsIGUuZy4gc2V0X3ZxX2FkZHJl
c3MoKSwgc2V0X3ZxX251bSgpIGV0Yy4gVGhleSBhbGwKPj4+IGFjY2VwdCB2aXJ0cXVldWUgaW5k
ZXggYXMgYW4gYXJndW1lbnQuCj4+Pgo+Pj4gV2hhdCB3ZSB3YW50IHRvIGRvIGlzIHZlcmlmeSB3
aGVhdGhlciB0aGUgaW5kZXggcHJvdmlkZWQgaXMgdmFsaWQgb3IKPj4+IG5vdC4gSWYgaXQgaXMg
bm90IHZhbGlkLCBlaXRoZXIgcmV0dXJuIGVycm9yIChpZiB0aGUgY2FsbGJhY2sgY2FuIHJldHVy
bgo+Pj4gYSB2YWx1ZSkgb3IganVzdCBhdm9pZCBwcm9jZXNzaW5nIGl0LiBJZiB0aGUgaW5kZXgg
aXMgdmFsaWQgdGhlbiB3ZQo+Pj4gcHJvY2VzcyBpdCBub3JtYWxseS4KPj4+Cj4+PiBOb3cgd2Ug
bmVlZCB0byBkZWNpZGUgd2hpY2ggaW5kZXggaXMgdmFsaWQgb3Igbm90LiBXZSBuZWVkIHNvbWV0
aGluZwo+Pj4gbGlrZSB0aGlzIHRvIGlkZW50aWZpeSB2YWxpZCBpbmRleGVzIHJhbmdlOgo+Pj4K
Pj4+IENWUSBjbGVhcjogMCBhbmQgMQo+Pj4gQ1ZRIHNldCwgTVEgY2xlYXI6IDAsIDEgYW5kIDIg
KGZvciBDVlEpLgo+Pj4gQ1ZRIHNldCwgTVEgc2V0OiAwLi5udnEgd2hlcmUgbnZxIGlzIHdoYXRl
dmVyIHByb3ZpZGVkIHRvCj4+PiBfdmRwYV9yZWdpc3Rlcl9kZXZpY2UoKQo+Pgo+PiBZZXMuCj4+
Cj4gVW5mb3J0dW5hdGVseSBpdCBkb2VzIG5vdCB3b3JrLgo+IHNldF92cV9jYigpIGZvciBhbGwg
dGhlIG11bHRpcXVldWVzIGlzIGNhbGxlZCBiZW9mcmUgZmVhdHVyZQo+IG5lZ290aWF0aW9uLiBJ
ZiBJIGFwcGx5IHRoZSBhYm92ZSBsb2dpYywgSSB3aWxsIGxvc2UgdGhlc2Ugc2V0dGluZ3MuCj4K
PiBJIGNhbiBtYWtlIGFuIGV4Y2VwdGlvbiBmb3Igc2V0X3ZxX2NiKCksIHNhdmUgY2FsbGJhY2tz
IGFuZCByZXN0b3JlCj4gdGhlbSBhZnRlcndhcmRzLiBUaGlzIGxvb2tzIHRvbyBjb252b2x1dGVk
IGFuZCBtYXliZSB3ZSBzaG91bGQgc2Vlawo+IGFub3RoZXIgc29sdXRpb24uCgoKSSBhZ3JlZS4K
Cgo+Cj4gTGV0IG1lIGtub3cgd2hhdCB5b3UgdGhpbmsuCgoKUmV0aGluayBhYm91dCB0aGlzIGlz
c3VlLiBJdCBsb29rcyB0byB0aGUgb25seSBpc3N1ZSB3ZSBmYWNlIGlzIHRoZSAKc2V0X3ZxX2Ni
KCkuCgpXaXRoIHRoZSBhc3N1bXB0aW9uIHRoYXQgdGhlIHVzZXJzcGFjZSBjYW4gdXNlIHRoZSBp
bmRleCBjb3JyZWN0bHkgKGV2ZW4gCmJlZm9yZSBzZXRfZmVhdHVyZXMpLiBJIHdvbmRlciB0aGUg
Zm9sbG93aW5nIHdvcmtzLgoKSW5zdGVhZCBvZiBjaGVja2luZyB3aGV0aGVyIHRoZSBpbmRleCBp
cyBjdnEgaW4gc2V0X3ZxX2NiKCkgaG93IGFib3V0OgoKMSkgZGVjb3VwbGUgZXZlbnRfY2Igb3V0
IG9mIG1seDVfdmRwYV92aXJ0cXVldWUgYW5kIG1seDVfY29uZ3JvX3ZxCjIpIGhhdmUgYSBkZWRp
Y2F0ZWQgZXZlbnRfY2IgYXJyYXkgaW4gbWx4NV92ZHBhX25ldAozKSB0aGVuIHdlIGNhbiBkbwoK
bmRldi0+ZXZlbnRfY2JzW2luZGV4XSA9ICpjYjsKCmluIG1seDVfdmRwYV9zZXRfdnFfY2IoKQoK
NCkgaW4gdGhlIG1seDVfY3ZxX2tpY2tfaGFuZGxlcigpLCB3ZSBrbm93IHRoZSBmZWF0dXJlIGlz
IG5lZ290aWF0ZWQgYW5kIAp3ZSBjYW4gdXNlIHRoZSBjb3JyZWN0IGluZGV4IHRoZXJlLgoKSW4g
dGhlIG1lYW4gdGltZSwgSSB3aWxsIGxvb2sgYXQgUWVtdSBjb2RlIHRvIHNlZSBpZiB3ZSBjYW4g
Z3VhcmFudGVlIAp0aGF0IHNldF9mZWF0dXJlcyBpcyBjYWxsZWQgYmVmb3JlIHNldF92cV9jYWxs
YmFjay4gKEF0IGZpcnN0IGdsYW5jZSwgCml0J3Mgbm90IHRyaXZpYWwgYnV0IGxldCdzIHNlZSku
CgpUaGFua3MKCgo+Cj4+PiBBbmQgd2hpbGUgd3JpdGluZyB0aGlzLCBJIHRoaW5rIHRoaXMgbG9n
aWMgZG9lcyBub3QgYmVsb2cgaW4gbWx4NV92ZHBhCj4+PiBidXQgcHJvYmFibHkgaW4gdmRwYS5j
Cj4+Cj4+IFRoZSBwcm9ibGVtIGlzIHRoYXQgdmRwYSBzaG91bGQgYmUgdW5hd2FyZSBvZiBhIHNw
ZWNpZmljIGRldmljZSB0eXBlLiBFLmcKPj4gdGhlIGFib3ZlIGluZGljZXMgbWF5IHdvcmsgb25s
eSBmb3IgdmlydGlvLW5ldCBidXQgbm90IG90aGVyLgo+Pgo+PiBUaGFua3MKPj4KPj4KPj4+IAkK
Pj4+PiBUaGFua3MKPj4+Pgo+Pj4+Pj4gVGhhbmtzCj4+Pj4+Pgo+Pj4+Pj4KPj4+Pj4+Pj4gVGhh
bmtzCj4+Pj4+Pj4+Cj4+Pj4+Pj4+CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25A
bGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24u
b3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6YXRpb24=
