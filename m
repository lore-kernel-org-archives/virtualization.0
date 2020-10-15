Return-Path: <SRS0=fPht=DW=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A836CC433E7
	for <virtualization@archiver.kernel.org>; Thu, 15 Oct 2020 13:12:07 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 113942225C
	for <virtualization@archiver.kernel.org>; Thu, 15 Oct 2020 13:12:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WPYTxfWp"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 113942225C
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by whitealder.osuosl.org (Postfix) with ESMTP id 6F5568865B;
	Thu, 15 Oct 2020 13:12:06 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id BLMy8BllKjzH; Thu, 15 Oct 2020 13:12:06 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by whitealder.osuosl.org (Postfix) with ESMTP id 06FF7885E6;
	Thu, 15 Oct 2020 13:12:06 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DA624C0052;
	Thu, 15 Oct 2020 13:12:05 +0000 (UTC)
Received: from fraxinus.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3BF19C0051
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 13:12:04 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by fraxinus.osuosl.org (Postfix) with ESMTP id 275258840B
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 13:12:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from fraxinus.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id hKJudftJvs36
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 13:12:03 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by fraxinus.osuosl.org (Postfix) with ESMTPS id 4847A88402
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 13:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1602767522;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uAf/KQ6TAdYo1Wm4S00yfTFLig9CeJngAorlemy7WXc=;
 b=WPYTxfWpenyzRNvqTGJpp4hh3+b76u8dxA9SQy252rdGbZsOolOwDFJvc2OW46xbk7UNXJ
 5QMELvpuAhRPvLRZpOdtuWuYk58Oz3C/6OxPCapuaMGeL1VsU7aWiaaqTcH7sEHKm0TPbW
 F7a3e+j+V/0tGccnKWMQtG5F7TeeYHk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-427-_KKAFYWrNxyPs2T4-CWcPA-1; Thu, 15 Oct 2020 09:12:00 -0400
X-MC-Unique: _KKAFYWrNxyPs2T4-CWcPA-1
Received: by mail-wr1-f70.google.com with SMTP id a15so1875337wrx.9
 for <virtualization@lists.linux-foundation.org>;
 Thu, 15 Oct 2020 06:12:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=uAf/KQ6TAdYo1Wm4S00yfTFLig9CeJngAorlemy7WXc=;
 b=fOzVKXN1O8F2Dgb7Tat+oJHHxooCbeBgnnyPSsTvOf/0TjC7q2MWDjPYkH3qfrbeME
 BtoQzqAy8xw361nj3g8ULPfexYhCk2LjMoIrxrBG1huinADcNOSGziCumUln4NE99UlF
 J4ROnsr5EqTkDxQNTwdOsL5VbAU88T22k0784n5xErnWL7wYJ8cQeayhtrByPtZfYU7Q
 b6YgFJY0AMc4EKZv9JahcGGD0rcTcV56hCbOS4OHcQHfKI0rvebcVT1Vdb83qcPeyoQe
 Hs46mPAKfsP96CsQkq1UhyocoRvHzatBQxDtidnNXzJ6heyl2jCFWimZcDeATyuIAFmu
 WkKA==
X-Gm-Message-State: AOAM531ImBK+SK/4Z2v9grzKfPd++f3lHHn4lIkFht64Rp+MWpniyv1c
 HngGlmRTKz3ddj4gpWRlNZeqN6JHyj9zgAtx5nyo+jNZGajeFMqZQLEOT4nAmCps8pDDogC29L4
 rt7dF6wBZlBRGp0A0Tzf24oGczjGpxkXrIqIEbIq4pg==
X-Received: by 2002:a7b:c148:: with SMTP id z8mr3896322wmi.135.1602767519223; 
 Thu, 15 Oct 2020 06:11:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyLn1GAiAp1rVzj+T97VT2N5UZGZv+k9R+BhLp1TRQ1j526UPewTS8smKxID+OGAzZGSt3Z4g==
X-Received: by 2002:a7b:c148:: with SMTP id z8mr3896295wmi.135.1602767519019; 
 Thu, 15 Oct 2020 06:11:59 -0700 (PDT)
Received: from redhat.com (bzq-79-176-118-93.red.bezeqint.net. [79.176.118.93])
 by smtp.gmail.com with ESMTPSA id y7sm4331656wmg.40.2020.10.15.06.11.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 15 Oct 2020 06:11:58 -0700 (PDT)
Date: Thu, 15 Oct 2020 09:11:55 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH v3 2/2] vhost-vdpa: fix page pinning leakage in error path
Message-ID: <20201015091150-mutt-send-email-mst@kernel.org>
References: <1601701330-16837-1-git-send-email-si-wei.liu@oracle.com>
 <1601701330-16837-3-git-send-email-si-wei.liu@oracle.com>
 <574a64e3-8873-0639-fe32-248cb99204bc@redhat.com>
 <5F863B83.6030204@oracle.com>
 <835e79de-52d9-1d07-71dd-d9bee6b9f62e@redhat.com>
MIME-Version: 1.0
In-Reply-To: <835e79de-52d9-1d07-71dd-d9bee6b9f62e@redhat.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: boris.ostrovsky@oracle.com, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org,
 si-wei liu <si-wei.liu@oracle.com>, lingshan.zhu@intel.com
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

T24gVGh1LCBPY3QgMTUsIDIwMjAgYXQgMDI6MTU6MzJQTSArMDgwMCwgSmFzb24gV2FuZyB3cm90
ZToKPiAKPiBPbiAyMDIwLzEwLzE0IOS4iuWNiDc6NDIsIHNpLXdlaSBsaXUgd3JvdGU6Cj4gPiA+
IAo+ID4gPiAKPiA+ID4gU28gd2hhdCBJIHN1Z2dlc3QgaXMgdG8gZml4IHRoZSBwaW5uaW5nIGxl
YWthZ2UgZmlyc3QgYW5kIGRvIHRoZQo+ID4gPiBwb3NzaWJsZSBvcHRpbWl6YXRpb24gb24gdG9w
ICh3aGljaCBpcyBzdGlsbCBxdWVzdGlvbmFibGUgdG8gbWUpLgo+ID4gT0suIFVuZm9ydHVuYXRl
bHksIHRoaXMgd2FzIHBpY2tlZCBhbmQgZ290IG1lcmdlZCBpbiB1cHN0cmVhbS4gU28gSSB3aWxs
Cj4gPiBwb3N0IGEgZm9sbG93IHVwIHBhdGNoIHNldCB0byAxKSByZXZlcnQgdGhlIGNvbW1pdCB0
byB0aGUgb3JpZ2luYWwKPiA+IF9fZ2V0X2ZyZWVfcGFnZSgpIGltcGxlbWVudGF0aW9uLCBhbmQg
MikgZml4IHRoZSBhY2NvdW50aW5nIGFuZCBsZWFrYWdlCj4gPiBvbiB0b3AuIFdpbGwgaXQgYmUg
ZmluZT8KPiAKPiAKPiBGaW5lLgo+IAo+IFRoYW5rcwoKRmluZSBieSBtZSB0b28uCgpfX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fXwpWaXJ0dWFsaXphdGlvbiBt
YWlsaW5nIGxpc3QKVmlydHVhbGl6YXRpb25AbGlzdHMubGludXgtZm91bmRhdGlvbi5vcmcKaHR0
cHM6Ly9saXN0cy5saW51eGZvdW5kYXRpb24ub3JnL21haWxtYW4vbGlzdGluZm8vdmlydHVhbGl6
YXRpb24=
