Return-Path: <SRS0=kXQI=NW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F3D0C4320E
	for <virtualization@archiver.kernel.org>; Tue, 31 Aug 2021 14:34:12 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2D8C661041
	for <virtualization@archiver.kernel.org>; Tue, 31 Aug 2021 14:34:12 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 2D8C661041
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id DA997404A8;
	Tue, 31 Aug 2021 14:34:11 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 3EeYCS5PjY01; Tue, 31 Aug 2021 14:34:07 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4DD0540212;
	Tue, 31 Aug 2021 14:34:07 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 19209C001A;
	Tue, 31 Aug 2021 14:34:07 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C5954C000E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 14:34:05 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id A192B4023F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 14:34:05 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Qf2LZ4yg-kaV
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 14:34:04 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BFE3C40212
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 14:34:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1630420443;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=6PmT5XJD+8h8skjkZI3qWWXkCH+r4hgnl/yZSPi7Y2o=;
 b=Z7ltyx6kdtGwyaqrupC8S+naYV7+Gw/5Gwt0eGKngBDLgpQQ2E077a4AeJDgz4djkJl4Dz
 aX/Ey8LdEyibPEK76xn68AgrMeTR+IDe0h6K2f+BcKmpOAHSYN5vWQwFxVnYDS9IRR3iyv
 W8WeAiyEZidNQ/JuRkmci2r1cl42Whs=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-181-ELtrPdk2NvSr9B1_OsJaUA-1; Tue, 31 Aug 2021 10:34:02 -0400
X-MC-Unique: ELtrPdk2NvSr9B1_OsJaUA-1
Received: by mail-ed1-f71.google.com with SMTP id
 b6-20020aa7c6c6000000b003c2b5b2ddf8so1326704eds.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 31 Aug 2021 07:34:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=6PmT5XJD+8h8skjkZI3qWWXkCH+r4hgnl/yZSPi7Y2o=;
 b=cFlC8TnVifIlUuJ9vajvJLAjlv1hmNn01NL1a5sihmEmDG4cg5m9KDskciWpSezg0l
 TdrBJ1V7RRzYlrWG9pf6hmTu1WFUMUsKb0ts3/9Ith6WIe0lnevekXe8T80vjDMDYp7Y
 RhdNBG8jezVF3L2JQZaWlZn8XQlIB0Yq+WNksbFIMI494FA9UkArJFr0rY0YRRPuXWjA
 SYqzQoJhRocEsLAEFy/OPDxVhVV5kiP0JRiIXzY6h0HtOySCuZVHauUusedAB97tiw9I
 +tVOfCbHNf69zMoHm9F2hbyYjEB67dkj2xN3V3eFOQb83lvohNMLj4S9iify0noCVJCD
 K7ag==
X-Gm-Message-State: AOAM533w/mpA0WDn7c2+ArSx22xYjWO2ZXtsOFwubXfsIY8KMck0FImc
 SHNQQ2/dqt3erjcp6bq1QN2XW0X5NBtrXDYS/+/+GW6Gk6sQBVb35RJdmSLB3GoOBOQKnE2adxd
 T9HPhqmBgbMva/Is5MO8H7iIncZ1L6YTH7Vn1DGOu5Q==
X-Received: by 2002:a17:906:1913:: with SMTP id
 a19mr31557123eje.390.1630420441145; 
 Tue, 31 Aug 2021 07:34:01 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzzjjdwiOd8AeTnBC2TXxLH1EhvIr4UtSGSCDv5ZFm6H4uv3KIhAXZlHdfrPICpWzNoiNhPsw==
X-Received: by 2002:a17:906:1913:: with SMTP id
 a19mr31557113eje.390.1630420440965; 
 Tue, 31 Aug 2021 07:34:00 -0700 (PDT)
Received: from redhat.com ([2.55.138.60])
 by smtp.gmail.com with ESMTPSA id q9sm8369501ejf.70.2021.08.31.07.33.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 31 Aug 2021 07:34:00 -0700 (PDT)
Date: Tue, 31 Aug 2021 10:33:56 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: "Li,Rongqing" <lirongqing@baidu.com>
Subject: Re: =?utf-8?B?562U5aSNOiBbUEFUQ0hdIHZpcnRp?= =?utf-8?Q?o=5Fnet?=
 =?utf-8?Q?=3A?= reduce raw_smp_processor_id() calling in virtnet_xdp_get_sq
Message-ID: <20210831103024-mutt-send-email-mst@kernel.org>
References: <1629966095-16341-1-git-send-email-lirongqing@baidu.com>
 <20210830170837-mutt-send-email-mst@kernel.org>
 <bbf978c3252b4f2ea13ab7ca07d53034@baidu.com>
MIME-Version: 1.0
In-Reply-To: <bbf978c3252b4f2ea13ab7ca07d53034@baidu.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
 "bpf@vger.kernel.org" <bpf@vger.kernel.org>,
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

T24gVHVlLCBBdWcgMzEsIDIwMjEgYXQgMDI6MDk6MzZBTSArMDAwMCwgTGksUm9uZ3Fpbmcgd3Jv
dGU6Cj4gPiAtLS0tLemCruS7tuWOn+S7ti0tLS0tCj4gPiDlj5Hku7bkuro6IE1pY2hhZWwgUy4g
VHNpcmtpbiA8bXN0QHJlZGhhdC5jb20+Cj4gPiDlj5HpgIHml7bpl7Q6IDIwMjHlubQ45pyIMzHm
l6UgNToxMAo+ID4g5pS25Lu25Lq6OiBMaSxSb25ncWluZyA8bGlyb25ncWluZ0BiYWlkdS5jb20+
Cj4gPiDmioTpgIE6IG5ldGRldkB2Z2VyLmtlcm5lbC5vcmc7IGJwZkB2Z2VyLmtlcm5lbC5vcmc7
Cj4gPiB2aXJ0dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwo+ID4g5Li76aKY
OiBSZTogW1BBVENIXSB2aXJ0aW9fbmV0OiByZWR1Y2UgcmF3X3NtcF9wcm9jZXNzb3JfaWQoKSBj
YWxsaW5nIGluCj4gPiB2aXJ0bmV0X3hkcF9nZXRfc3EKPiA+IAo+ID4gT24gVGh1LCBBdWcgMjYs
IDIwMjEgYXQgMDQ6MjE6MzVQTSArMDgwMCwgTGkgUm9uZ1Fpbmcgd3JvdGU6Cj4gPiA+IHNtcF9w
cm9jZXNzb3JfaWQoKS9yYXcqIHdpbGwgYmUgY2FsbGVkIG9uY2UgZWFjaCB3aGVuIG5vdCBtb3Jl
IHF1ZXVlcwo+ID4gPiBpbiB2aXJ0bmV0X3hkcF9nZXRfc3EoKSB3aGljaCBpcyBjYWxsZWQgaW4g
bm9uLXByZWVtcHRpYmxlIGNvbnRleHQsIHNvCj4gPiA+IGl0J3Mgc2FmZSB0byBjYWxsIHRoZSBm
dW5jdGlvbgo+ID4gPiBzbXBfcHJvY2Vzc29yX2lkKCkgb25jZS4KPiA+ID4KPiA+ID4gU2lnbmVk
LW9mZi1ieTogTGkgUm9uZ1FpbmcgPGxpcm9uZ3FpbmdAYmFpZHUuY29tPgo+ID4gCj4gPiBjb21t
aXQgbG9nIHNob3VsZCBwcm9iYWJseSBleHBsYWluIHdoeSBpdCdzIGEgZ29vZCBpZGVhIHRvIHJl
cGxhY2UKPiA+IHJhd19zbXBfcHJvY2Vzc29yX2lkIHdpdGggc21wX3Byb2Nlc3Nvcl9pZCBpbiB0
aGUgY2FzZSBvZiBjdXJyX3F1ZXVlX3BhaXJzCj4gPiA8PSBucl9jcHVfaWRzLgo+ID4gCj4gCj4g
Cj4gSSBjaGFuZ2UgaXQgYXMgYmVsb3csIGlzIGl0IG9rPwo+IAo+ICAgICB2aXJ0aW9fbmV0OiBy
ZWR1Y2UgcmF3X3NtcF9wcm9jZXNzb3JfaWQoKSBjYWxsaW5nIGluIHZpcnRuZXRfeGRwX2dldF9z
cQoKc2hvcnRlcjoKCnZpcnRpb19uZXQ6IHMvcmF3X3NtcF9wcm9jZXNzb3JfaWQvc21wX3Byb2Nl
c3Nvcl9pZC8gaW4gdmlydG5ldF94ZHBfZ2V0X3NxCgoKPiAKPiAgICAgc21wX3Byb2Nlc3Nvcl9p
ZCgpIGFuZCByYXdfc21wX3Byb2Nlc3Nvcl9pZCgpIGFyZSBjYWxsZWQgb25jZQo+ICAgICBlYWNo
IGluIHZpcnRuZXRfeGRwX2dldF9zcSgpLCB3aGVuIGN1cnJfcXVldWVfcGFpcnMgPD0gbnJfY3B1
X2lkcywKPiAgICAgc2hvdWxkIGJlIG1lcmdlZAoKSSdkIGp1c3QgZHJvcCB0aGlzIHBhcnQuCgo+
IAo+ICAgICB2aXJ0bmV0X3hkcF9nZXRfc3EoKSBpcyBjYWxsZWQgaW4gbm9uLXByZWVtcHRpYmxl
IGNvbnRleHQsIHNvCj4gICAgIGl0J3Mgc2FmZSB0byBjYWxsIHRoZSBmdW5jdGlvbiBzbXBfcHJv
Y2Vzc29yX2lkKCksIGFuZCBrZWVwCj4gICAgIHNtcF9wcm9jZXNzb3JfaWQoKSwgYW5kIHJlbW92
ZSB0aGUgY2FsbGluZyBvZiByYXdfc21wX3Byb2Nlc3Nvcl9pZCgpLAo+ICAgICBhdm9pZCB0aGUg
d3JvbmcgdXNlIHZpcnRuZXRfeGRwX2dldF9zcSB0byBwcmVlbXB0aWJsZSBjb250ZXh0Cj4gICAg
IGluIHRoZSBmdXR1cmUKCnMvYXZvaWQuKi90aGlzIHdheSB3ZSdsbCBnZXQgYSB3YXJuaW5nIGlm
IHRoaXMgaXMgZXZlciBjYWxsZWQgaW4gYSBwcmVlbXB0aWJsZSBjb250ZXh0LwoKCj4gCj4gLUxp
CgpfX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFs
aXphdGlvbiBtYWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlv
bi5vcmcKaHR0cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8v
dmlydHVhbGl6YXRpb24=
