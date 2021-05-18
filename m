Return-Path: <SRS0=MByQ=KN=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_RED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60039C43460
	for <virtualization@archiver.kernel.org>; Tue, 18 May 2021 09:52:25 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1192361185
	for <virtualization@archiver.kernel.org>; Tue, 18 May 2021 09:52:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1192361185
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id CA314401F1;
	Tue, 18 May 2021 09:52:24 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jccvqkf04Juf; Tue, 18 May 2021 09:52:22 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTP id 5AEA1400CD;
	Tue, 18 May 2021 09:52:22 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 27E93C000D;
	Tue, 18 May 2021 09:52:22 +0000 (UTC)
Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 62F17C0001
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 May 2021 09:52:21 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp4.osuosl.org (Postfix) with ESMTP id 564F5404F0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 May 2021 09:52:21 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Authentication-Results: smtp4.osuosl.org (amavisd-new);
 dkim=pass (1024-bit key) header.d=redhat.com
Received: from smtp4.osuosl.org ([127.0.0.1])
 by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id YwFQZO0ibO7o
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 May 2021 09:52:19 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [216.205.24.124])
 by smtp4.osuosl.org (Postfix) with ESMTPS id 3916F405A0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 May 2021 09:52:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1621331537;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=wpPMT42uZ3XKwYbpKRRNEkfka2lbaP+NlbXhy36ElV8=;
 b=bYOeAdeKMIRjnxXRt1zcUiwQk8R/pmvCo34b9VpfYoKqKqMXApRUTuz2sS+ybgdfMkcGb+
 xKZlClQ3LSMEbIolmC21SB/0Q8bS4eqSW9NS2IQnv5XJirRkY/Ykta9PrrSY7bjLtSvIWr
 ziZUm37oaDYroj55yTnfHy2WSlinFaU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-549-JRNZWZ68N6CaAmM6qrikNQ-1; Tue, 18 May 2021 05:52:15 -0400
X-MC-Unique: JRNZWZ68N6CaAmM6qrikNQ-1
Received: by mail-wr1-f71.google.com with SMTP id
 i102-20020adf90ef0000b029010dfcfc46c0so5356938wri.1
 for <virtualization@lists.linux-foundation.org>;
 Tue, 18 May 2021 02:52:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=wpPMT42uZ3XKwYbpKRRNEkfka2lbaP+NlbXhy36ElV8=;
 b=BJbXyos7Bv8QzTZbT0CfXkT+zjJ8cjsbKf7slbgpOwi1Sq0FjEH8rJ1ltBAvzKlNU/
 HJj7FkMyUkzTP4kTNzXwZltuUiPwDO+hwCmqPfdlJFMcxf7jQ8FzK4vC1QXEF4Tml29h
 n7nWAkD5Aqfw9DnGzTDXaug9XMETzWbJY6Ba/zBSPZKA9FmQnpknZPTGpB2b/M0o2woF
 j+3ibRJMw8cVn9h0WnZVobkV0bpOyhNVUg2NU565/Vq+k+V6TWvi7S0VGGeTbL33cBzq
 CPw7gwOmPPgBDIuZAddIIlawtTrCoqCvULVkZYGebAJjbO4+csblyAPHWwUm91Xzb7R/
 D79Q==
X-Gm-Message-State: AOAM533rlnNBfiQtb9lIw/1PG3bz7VnnTsYwNErRsTR46Ahz8Oefc7zF
 qoOpdvcZRYRLpHHZpWLOmQXpDk5xewtu8bYg7hxXb5i5x1H1tjzUYkI0ONP+8QWUWidnA7Cnhok
 RwArCmcqo/fIHbVv2tHVWuRH79vsPCJow1QIx6T8caA==
X-Received: by 2002:a7b:c346:: with SMTP id l6mr4432807wmj.109.1621331534866; 
 Tue, 18 May 2021 02:52:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNe6REZyWEUQAC/cEKXhdXB7zAamd7/DPuJpFs/VMosfB95RFwzY1oPYC6rBh2UxA9yWMWXg==
X-Received: by 2002:a7b:c346:: with SMTP id l6mr4432777wmj.109.1621331534660; 
 Tue, 18 May 2021 02:52:14 -0700 (PDT)
Received: from redhat.com ([2a10:800c:1fa6:0:3809:fe0c:bb87:250e])
 by smtp.gmail.com with ESMTPSA id b17sm21100441wrt.71.2021.05.18.02.52.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 18 May 2021 02:52:13 -0700 (PDT)
Date: Tue, 18 May 2021 05:52:10 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Yongji Xie <xieyongji@bytedance.com>
Subject: Re: Re: [RFC PATCH 00/17] Add validation for used length
Message-ID: <20210518055146-mutt-send-email-mst@kernel.org>
References: <20210517090836.533-1-xieyongji@bytedance.com>
 <20210517193912-mutt-send-email-mst@kernel.org>
 <CACycT3uWexPNTiroO5EBT9q8YOorvvVaY_kymapWkLZ078J7aQ@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CACycT3uWexPNTiroO5EBT9q8YOorvvVaY_kymapWkLZ078J7aQ@mail.gmail.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Ohad Ben Cohen <ohad@wizery.com>, amit@kernel.org, airlied@linux.ie,
 linux-kernel <linux-kernel@vger.kernel.org>, bjorn.andersson@linaro.org,
 miklos@szeredi.hu, Stefan Hajnoczi <stefanha@redhat.com>,
 dan.j.williams@intel.com,
 virtualization <virtualization@lists.linux-foundation.org>,
 Johannes Berg <johannes@sipsolutions.net>, vgoyal@redhat.com
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>

On Tue, May 18, 2021 at 04:29:44PM +0800, Yongji Xie wrote:
> On Tue, May 18, 2021 at 7:40 AM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Mon, May 17, 2021 at 05:08:19PM +0800, Xie Yongji wrote:
> > > Current virtio device drivers may trust the used length returned
> > > in virtqueue_get_buf()/virtqueue_get_buf_ctx(). But the used length
> > > might come from an untrusted device when VDUSE[1] is enabled. To
> > > protect this case, this series tries to add validation for the
> > > used length.
> > >
> > > Since many legacy devices will also set the used length incorrectly,
> > > we did not add the validation unconditionally. Instead, we will do
> > > the validation only when the device driver needs the used length.
> > > A NULL len passed to virtqueue_get_buf()/virtqueue_get_buf_ctx()
> > > will mean the used length is not needed by the device driver.
> >
> > Can we be more specific? Which drivers have problems when used len
> > is incorrect? Maybe there's an easier way like validating the length
> > in the driver ...
> >
> 
> It's ok to me. But this means all future new drivers need to remember
> to do the validation.
> 
> Now only virtio-net and virtio-console drivers have this problem. I
> can send some patches to fix it.
> 
> Thanks,
> Yongji

I'd say let's just document the requirement for now.

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
