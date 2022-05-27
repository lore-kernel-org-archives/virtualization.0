Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 49FA5C433F5
	for <virtualization@archiver.kernel.org>; Fri, 27 May 2022 10:57:44 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id C9702428A4;
	Fri, 27 May 2022 10:57:43 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1z7jbfl0vpzF; Fri, 27 May 2022 10:57:42 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 4900042853;
	Fri, 27 May 2022 10:57:42 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 11523C0032;
	Fri, 27 May 2022 10:57:42 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 3F47FC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:57:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 1CC91615F8
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:57:40 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp3.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id QN5j36p9axxh
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:57:39 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 72B0A6106F
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 10:57:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1653649058;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=w/W1rjmpFLa1v2RHMPVw1HSemGhVAnYnW7IDz+nVRvU=;
 b=dOqQytcRWagiQX7alGKqfLg9DGB335er+jyv2wAQTzao8LNvh1VGFrzeLUexm3u5PYZ6H+
 p6TjRMZ4Tip3zkpD0zvoLOhYgv1dYz5hYOdkoqAnEbcGN3lUqt6vRlNaxxzI09xupp4py+
 GrfSeOiS22lGa0YPEnLwySib35s1qE4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-502-LF0Mc8IYOCiMpjoN6zmWqA-1; Fri, 27 May 2022 06:57:37 -0400
X-MC-Unique: LF0Mc8IYOCiMpjoN6zmWqA-1
Received: by mail-ed1-f69.google.com with SMTP id
 s3-20020aa7d783000000b0042d660a4efeso230454edq.20
 for <virtualization@lists.linux-foundation.org>;
 Fri, 27 May 2022 03:57:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:content-transfer-encoding
 :in-reply-to;
 bh=w/W1rjmpFLa1v2RHMPVw1HSemGhVAnYnW7IDz+nVRvU=;
 b=xrc8Vu5oAJF7WAYmbH2TNMGI1/pNj8Y1bgZPJQ/bQLOZJ2F9VKI0zpIj6gRi2saB7m
 WuzvnnfS6xaBpR5m0nreIh/MSFhdk3UYD/UuN3+Wf8WcQ1U04lLycYondxH8DxTRmbph
 Y7koW//BY+3FhQJV2xb+LcVyB0We5qVwCaAN/ee2yFIpE7IgZUYk69M43mmtk7Cp6Iyc
 2pJuIsqEm2rrfPUXeZtyvLjk3EO5Vdn6q4Fr51IouulinC0Dh/sDQmjfgMgziHlE6AtR
 IX/6Ix9Vmt8arfWqFy+quJYNuqCe6dR+sHCaxr8HaSW4t+sBC01h37ycvRHT2Bg0ynO6
 9Q7w==
X-Gm-Message-State: AOAM532QbuAGDIOlHtwiA4oTLyRSN5NsA138zzD+HoOKq4pd9CfMt7jb
 5rzWWvgI6KrhtFD2AwIT0dsHSl2mQu+f8Bp1dG1QdwoIUK/7r4OMKhGmVRbQSrCnCxaniruvswx
 Yg2gwRdFJjzjvuMW9cVwmBbEQCfokwMF7G204OmalxA==
X-Received: by 2002:a17:907:6d85:b0:6fa:80ea:7565 with SMTP id
 sb5-20020a1709076d8500b006fa80ea7565mr38630249ejc.395.1653649055993; 
 Fri, 27 May 2022 03:57:35 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwk6Jj1t6DUqc/RXpwAHg1SYPdtQFfHok9zAcciQ3wqDOE6E1PqZgNrOq+IAz4pxLa39lLnbQ==
X-Received: by 2002:a17:907:6d85:b0:6fa:80ea:7565 with SMTP id
 sb5-20020a1709076d8500b006fa80ea7565mr38630235ejc.395.1653649055743; 
 Fri, 27 May 2022 03:57:35 -0700 (PDT)
Received: from redhat.com ([2.55.130.213]) by smtp.gmail.com with ESMTPSA id
 kx17-20020a170907775100b006feded0fa87sm1330944ejc.218.2022.05.27.03.57.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 27 May 2022 03:57:35 -0700 (PDT)
Date: Fri, 27 May 2022 06:57:32 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Bo Liu =?utf-8?B?KOWImOazoikt5rWq5r2u5L+h5oGv?= <liubo03@inspur.com>
Subject: Re: [PATCH] virtio_balloon: check virtqueue_add_outbuf() return value
Message-ID: <20220527065611-mutt-send-email-mst@kernel.org>
References: <4789cbbb9d59420abc86a9e225ef0bfd@inspur.com>
MIME-Version: 1.0
In-Reply-To: <4789cbbb9d59420abc86a9e225ef0bfd@inspur.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: "virtualization@lists.linux-foundation.org"
 <virtualization@lists.linux-foundation.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

T24gRnJpLCBNYXkgMjcsIDIwMjIgYXQgMTA6NDM6MzBBTSArMDAwMCwgQm8gTGl1ICjliJjms6Ip
Lea1qua9ruS/oeaBryB3cm90ZToKPiBUaGUgcHVycG9zZSBvZiB0aGlzIHBhdGNoIGlzLCB2aXJ0
cXVldWVfYWRkX291dGJ1ZigpIGFkZGluZyBkYXRhIHRvCj4gdmlydHF1ZXVlIG1heSBzdWNjZWVk
IG9yIGZhaWwuIElmIHN1Y2Nlc3NmdWwsIGl0IHdpbGwgY2FsbCB2aXJ0cXVldWVfa2ljaygpCj4g
dG8gbm90aWZpZSB0aGUgaG9zdCBiYWNrZW5kIGRyaXZlciwgYnV0IGlmIHRoZSB2aXJ0cXVldWVf
YWRkX291dGJ1ZigpIGZhaWxzLAo+IHRoZSBkYXRhIGlzIG5vdCBzdWNjZXNzZnVsbHkgYWRkZWQg
dG8gdGhlIHZpcnRxdWV1ZSwgYW5kIHRoZSBob3N0IGJhY2stZW5kCj4gZHJpdmVyIGRvZXMgbm90
IG5lZWQgdG8gYmUgbm90aWZpZWQgZm9yIHByb2Nlc3NpbmcuCj4gCj4gVGhhbmtzLgoKV2h5IGlz
IGl0IGEgcHJvYmxlbSBpZiB3ZSBkbz8KCi0tIApNU1QKCl9fX19fX19fX19fX19fX19fX19fX19f
X19fX19fX19fX19fX19fX19fX19fX19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0
dWFsaXphdGlvbkBsaXN0cy5saW51eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4
Zm91bmRhdGlvbi5vcmcvbWFpbG1hbi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
