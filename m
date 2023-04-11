Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAA5C7619A
	for <virtualization@archiver.kernel.org>; Tue, 11 Apr 2023 08:59:41 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 2D9C7820F1;
	Tue, 11 Apr 2023 08:59:41 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 2D9C7820F1
Authentication-Results: smtp1.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=W7QyC4DD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id dwyWEhNZhL4z; Tue, 11 Apr 2023 08:59:40 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A7E7181EBC;
	Tue, 11 Apr 2023 08:59:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A7E7181EBC
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 7AD1FC0037;
	Tue, 11 Apr 2023 08:59:39 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [IPv6:2605:bc80:3010::137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 58CB5C002A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 08:59:38 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 31AC1410E7
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 08:59:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 31AC1410E7
Authentication-Results: smtp4.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=W7QyC4DD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id ZRuRD8fTk18E
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 08:59:37 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 62C74410E3
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 62C74410E3
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 08:59:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1681203576;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=q3n4Dlb1IbZDnnAZPjBpu/L9w7uLuGNR8OPxmyaFX8w=;
 b=W7QyC4DDHINluap6OT3sxaimmqSpGf98s6PSlNY7g2t/ayoTTAHFw8lQQ3bno8SCha+UF1
 7JzR6DpCLlozqyF9oVApObjLihzonQBY2Z6oQo40CRF4Ld0Qys5apK+z7t3pYfkhNkLx36
 OqtFJd4G/rs/EdrOdQ7qYjM83laAiKE=
Received: from mail-oa1-f70.google.com (mail-oa1-f70.google.com
 [209.85.160.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-349-envIHPP1MVWcyrc3dB_5CA-1; Tue, 11 Apr 2023 04:59:33 -0400
X-MC-Unique: envIHPP1MVWcyrc3dB_5CA-1
Received: by mail-oa1-f70.google.com with SMTP id
 586e51a60fabf-17fd0d597dcso19582378fac.6
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Apr 2023 01:59:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1681203572; x=1683795572;
 h=content-transfer-encoding:cc:to:subject:message-id:date:from
 :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to;
 bh=q3n4Dlb1IbZDnnAZPjBpu/L9w7uLuGNR8OPxmyaFX8w=;
 b=2Ndc9P1xsdf9q/F4U0LjRVcujynex8/6AXym09NkDBZwfgrOBqyQCW6pxPgHM/AZw8
 Xyox91QjgFLD00BnOi4ZfdCxW9AzXajPecPloBo2T+PoZMjRAMrow0zN2gOR+EK+qQpy
 xiW+judbI798CLfQzFV4LAZFtPyw7bsmpGlU8iS9yOkw8+W9+jsPrrnjLJ/vNXLXx7AG
 AKlniFqFqxNY7PgjnllZirJjlk9zg2U4HVpG9beYOcqiFuz2chl4jQgBb7L+6dkhCRvj
 2BmLy6P3+CqJHKYjzVj/hiDVdUW2FaEUpBlVgqr77EUGsktKIoS0qtSBRbj/RpI0Pf3Z
 Hjbg==
X-Gm-Message-State: AAQBX9dWl2gE9IGP3Cy5yRuSE+yvBpPikkMkZoaPCqcse3hFfh4eES0T
 AeN4qlanP1EeT+cnOT/5OKi+glQD2hwYBwbLiqEydVLBk9k558uX2m+3uSyXGuZrw9i/Av/Xi5T
 Xaq1osZ4eoVTp/Fe0LzBb+bQZcoOMxBgXcuRaK6Sp3YURxVoEvbTj3wzqgA==
X-Received: by 2002:a9d:7e83:0:b0:6a1:cbc6:f1b3 with SMTP id
 m3-20020a9d7e83000000b006a1cbc6f1b3mr3583833otp.2.1681203572647; 
 Tue, 11 Apr 2023 01:59:32 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZjkehjiUGD8Sa6uDKmhtykA6Yy3BhKof/o86U0f9D8JMc2jis800ARXLdkmo2JWf6Juf3cqEWFVHJSc1wIG2I=
X-Received: by 2002:a9d:7e83:0:b0:6a1:cbc6:f1b3 with SMTP id
 m3-20020a9d7e83000000b006a1cbc6f1b3mr3583829otp.2.1681203572440; Tue, 11 Apr
 2023 01:59:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230327040536.48338-1-xuanzhuo@linux.alibaba.com>
 <20230327040536.48338-9-xuanzhuo@linux.alibaba.com>
 <73a24f95-b779-44ac-be28-45b35d1bf540@roeck-us.net>
 <20230407064634-mutt-send-email-mst@kernel.org>
 <1681097397.338332-4-xuanzhuo@linux.alibaba.com>
 <CACGkMEvLLbGTuF1sVSse1RBssvsTR40+P5eBzYkrYnqF7EO3Jw@mail.gmail.com>
 <1681197133.6736434-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1681197133.6736434-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Tue, 11 Apr 2023 16:59:21 +0800
Message-ID: <CACGkMEtgOxdwT_nNOmYW+w39bcvhj_n5sQu2qN=H2-KgsOuCVQ@mail.gmail.com>
Subject: Re: [PATCH vhost v6 08/11] virtio_ring: introduce virtqueue_dma_dev()
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Cc: Christoph Hellwig <hch@infradead.org>,
 virtualization@lists.linux-foundation.org, Guenter Roeck <linux@roeck-us.net>,
 "Michael S. Tsirkin" <mst@redhat.com>
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

T24gVHVlLCBBcHIgMTEsIDIwMjMgYXQgMzoyMeKAr1BNIFh1YW4gWmh1byA8eHVhbnpodW9AbGlu
dXguYWxpYmFiYS5jb20+IHdyb3RlOgo+Cj4KPiBIaSBKYXNvbgo+Cj4gQ2FuIHdlIGZvcmNlIHZp
cnRpbyBjb3JlIHRvIHVzZSBkbWEgYXBpIHdpdGhvdXQgVklSVElPX0ZfQUNDRVNTX1BMQVRGT1JN
Pwo+Cj4KCkkgZG9uJ3QgdGhpbmsgc28uIFdpdGhvdXQgQUNDRVNTX1BMQVRGT1JNIGl0J3Mgbm90
IERNQSwgc28gRE1BIEFQSQpzaG91bGQgYmUgYXZvaWRlZC4gQW5kIHdlIGhhdmUgc2V2ZXJhbCBz
b2Z0d2FyZSBkZXZpY2VzIGZvciB2aXJ0aW8Kbm93LgoKSSdkIHN1Z2dlc3QgaW52b2x2aW5nIEFG
X1hEUCBtYWludGFpbmVycyB0byBqb2luIHRoZSBkaXNjdXNzaW9uIHRvCnNlZWsgYSBzb2x1dGlv
bi4gSSB0ZW5kIHRvIGFncmVlIHdpdGggQ2hyaXN0b3BoIHRoYXQgZXZlcnl0aGluZyB3aWxsCmJl
IHNpbXBsaWZpZWQgaWYgRE1BIGlzIGRvbmUgYXQgdGhlIGRyaXZlciBsZXZlbC4KClRoYW5rcwoK
PiBUaGFua3MuCj4KCl9fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19f
X19fClZpcnR1YWxpemF0aW9uIG1haWxpbmcgbGlzdApWaXJ0dWFsaXphdGlvbkBsaXN0cy5saW51
eC1mb3VuZGF0aW9uLm9yZwpodHRwczovL2xpc3RzLmxpbnV4Zm91bmRhdGlvbi5vcmcvbWFpbG1h
bi9saXN0aW5mby92aXJ0dWFsaXphdGlvbg==
