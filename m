Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2C502C21DA
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Dec 2025 07:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.136
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765437190; cv=none; b=nINXKic2IUn5NO3gYP+MLIxle1+oPCXWQNM6tZcY6sPB2flCz/2vCga177nwk9mEUcG/PfrbdxZw/rxOgfahMi3DjeZ8dWJq4jEPeXvabFHDbKqpwsAcLknXZpfA/4husG4eylVyAdBzkrb7UI4bRdKh8efu/FUs6wAgDujEcyk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765437190; c=relaxed/simple;
	bh=5O6gfoiqu7zl7MI+AkNAqQRORg55DnnzdXIZ0kgrUhY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=YaSvFagmNQJrV+1C37STnbmNaauHB6xR30X4qmIBHOmAFqCDoEeJe8Z+s+0OcOf5Aa7D2BhWPZ/Qx0AMzn8/8TDmfGVcE+KIBxXurDUlvNDCw54MIFZ7L8hgHjD/R+yRHCC4sXHcESakYFYKmlUwTZMQ1wPcR48do/mxHvNHe20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hvTfYX+y; arc=none smtp.client-ip=140.211.166.136
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hvTfYX+y"
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 7B3B36078F
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Dec 2025 07:13:08 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.795
X-Spam-Level:
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id kkyCEFkkoI_3 for <virtualization@lists.linux-foundation.org>;
 Thu, 11 Dec 2025 07:13:07 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp3.osuosl.org 5A77060737
Authentication-Results: smtp3.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5A77060737
Authentication-Results: smtp3.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hvTfYX+y
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 5A77060737
	for <virtualization@lists.linux-foundation.org>; Thu, 11 Dec 2025 07:13:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1765437184;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=v3cMBVAe34zCfUEjMJd3Yg8WL57AHfV+19MqgBfdOTA=;
	b=hvTfYX+yWa8fOy7oKqm5y4d1jkF4rYzxuE7jv+RJtD7g8xjWWf9+AmpXfUvyxvzCGvxP/Z
	tjB8T76RYLZTF5pBHCEOy/1B0i7mvBs/thyk6mDX7r1OPryPsEPbI258+pOjN7SHJ5Bf3P
	S6dcYUYid2FxKq+aQOOD3aqUTJ0JU7k=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-159-tFUHsX-4NK2E4uN2VMSC_w-1; Thu, 11 Dec 2025 02:12:59 -0500
X-MC-Unique: tFUHsX-4NK2E4uN2VMSC_w-1
X-Mimecast-MFC-AGG-ID: tFUHsX-4NK2E4uN2VMSC_w_1765437178
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-42e29783a15so292437f8f.1
        for <virtualization@lists.linux-foundation.org>; Wed, 10 Dec 2025 23:12:59 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765437178; x=1766041978;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v3cMBVAe34zCfUEjMJd3Yg8WL57AHfV+19MqgBfdOTA=;
        b=ViUAQkUUEKAb2l0LdBizpxZrlrbdtORO6hodTm3HV6dtKevS+jX756eFjDIjkoGHe6
         fPDn1jMJ3HHvgpRQfCRWbrLsjL60idqwIIoN86sU+SmMDGdkE2d6PevTos18S9spqRwx
         QS8nlzz4pSw+rxJG54y5NYr2lMmFvH64/lv6l2VsE/Ri5AJ7IJBOCi2f7A3KJJxOcCVR
         e9G9IDGZVoWthBpH4h/uM4ozeEv+VyqYxy1MfrjJVNw4C1rHeCRnQ4iGXfzyu5JZZzlQ
         VmM8awYBa7yN0AnSiCiIdaumLisF9pdVoa5P/0i6fGnQYt481HIs9KJ926Zz5W67+Fv/
         ladw==
X-Forwarded-Encrypted: i=1; AJvYcCVJ1UrGeN+LaB57S4Eckycr3TEbXI2YvW9CWr2DmsigcSPbHCvaXse1UXUuVv7dCI4a4HnZ44TCxkkb42WLIw==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YwVT2wK9bOjMHnI9kQ7Y721fb+7PEuX0w6Ms+SX+Smx0ybg3+Hj
	cn4KD9WaFuD45jSMeo5DHowkeOgtxlbASVX9SzLM5b8YtGSbBFdLnWcPkcZegt0oCiZL2q0CsvH
	3Gf12B+KEAH97DlZ3dl6b1j3PLUe9RO0jlJkrrggwScM73hHKUgDVslKRVTnFRoqgTp9E9Iqapy
	TdlwDVmBY=
X-Gm-Gg: AY/fxX5WZMvaNhpRlqoWfINO7ExwXe6YuAwK2GVsSEAJ/yTBi4jygksRWGIur3izwrg
	7kEpZrLaQskTSeL7XXvyQoht4Q8YlRJQLio/WJ2u32XxlDrorOGVjIovSwEI7rgCu0LiFkm5QjA
	isBwVkKpPZ4Z82P3v5sTQ0kqqlJmaVSJc2JhlAZcU3TQ5h1jxDsgivqeiU/4mf0cqKpEULSaeX+
	AT5dCKIDtEHyAvUzii8lj+8Qn7SoLmaoACRBOAdI4yDb+KOejzbEZ+1+wF8MHR3CoaDhlI9jkRh
	QahuygCPyfScqD6O6Y8xVT4FuLF5kaYCYFhRU9GvhVe7nW1KeKSzLnkKcqLjRGb78njviGf607M
	Ufktnd4wcJyQxgYKghOz7bvtAaLMSGfY=
X-Received: by 2002:a5d:5f45:0:b0:42c:a420:e755 with SMTP id ffacd0b85a97d-42fab31cb50mr1018981f8f.23.1765437177815;
        Wed, 10 Dec 2025 23:12:57 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGsRQb3dc0zrujevNh5F8A5JyRrJgwU0E9KIhEHs1g4Ij2vfYO5/MNTzGT1VdTYMn9H/dSoqw==
X-Received: by 2002:a5d:5f45:0:b0:42c:a420:e755 with SMTP id ffacd0b85a97d-42fab31cb50mr1018937f8f.23.1765437177238;
        Wed, 10 Dec 2025 23:12:57 -0800 (PST)
Received: from redhat.com (IGLD-80-230-32-59.inter.net.il. [80.230.32.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42fa8a70440sm3800667f8f.16.2025.12.10.23.12.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Dec 2025 23:12:56 -0800 (PST)
Date: Thu, 11 Dec 2025 02:12:54 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH 00/14] tools/virtio: cleanups, fixes
Message-ID: <20251211021233-mutt-send-email-mst@kernel.org>
References: <cover.1764873799.git.mst@redhat.com>
 <20251209080926-mutt-send-email-mst@kernel.org>
 <CACGkMEuFZHgD8Shq6w_QfKYh0p3w8pfhY2mw_+ieQv0U14d8NA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CACGkMEuFZHgD8Shq6w_QfKYh0p3w8pfhY2mw_+ieQv0U14d8NA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 6VIMDJEacL-oHm43I_bJxuMRjvyhV6gsrbVZCo-hvos_1765437178
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Wed, Dec 10, 2025 at 02:24:02PM +0800, Jason Wang wrote:
> On Tue, Dec 9, 2025 at 9:09 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Thu, Dec 04, 2025 at 01:46:01PM -0500, Michael S. Tsirkin wrote:
> > > Recent virtio changes brought about build errors for tools/virtio,
> > > as usual. I did some refactoring to hopefully reduce maintainance
> > > load going forward.
> > >
> > > Adding stubs is tedious and seemed a perfect fit for cursor -
> > > so I used it for that, then rewrote some commits and accepted
> > > others.  commit logs I've rewritten.
> > >
> > > Found and fixed a couple of minor bugs while doing this - that
> > > part's all mine.
> >
> >
> > Jason, any feedback?
> 
> Looks good to me.

Can I get an Ack then?

> But I wonder, it looks like synchronization will
> become more and more a burden in the future, I wonder if it's time to
> switch to using uAPI instead of trying to reuse kernel virtio core to
> test vhost?
> 
> Thanks
> 
> >
> > > Michael S. Tsirkin (14):
> > >   tools/virtio: fix up compiler.h stub
> > >   virtio: make it self-contained
> > >   tools/virtio: use kernel's virtio.h
> > >   tools/virtio: add struct module forward declaration
> > >   tools/virtio: stub DMA mapping functions
> > >   tools/virtio: add dev_WARN_ONCE and is_vmalloc_addr stubs
> > >   tools/virtio: add ucopysize.h stub
> > >   tools/virtio: pass KCFLAGS to module build
> > >   tools/virtio: add struct cpumask to cpumask.h
> > >   tools/virtio: stub might_sleep and synchronize_rcu
> > >   tools/virtio: switch to kernel's virtio_config.h
> > >   virtio_features: make it self-contained
> > >   tools/virtio: fix up oot build
> > >   tools/virtio: add device, device_driver stubs
> > >
> > >  include/linux/virtio.h             |   2 +
> > >  include/linux/virtio_features.h    |   2 +
> > >  tools/virtio/Makefile              |   8 ++-
> > >  tools/virtio/linux/compiler.h      |   6 ++
> > >  tools/virtio/linux/cpumask.h       |   4 ++
> > >  tools/virtio/linux/device.h        |   8 +++
> > >  tools/virtio/linux/dma-mapping.h   |   4 ++
> > >  tools/virtio/linux/kernel.h        |  16 +++++
> > >  tools/virtio/linux/module.h        |   2 +
> > >  tools/virtio/linux/ucopysize.h     |  21 ++++++
> > >  tools/virtio/linux/virtio.h        |  73 +--------------------
> > >  tools/virtio/linux/virtio_config.h | 102 +----------------------------
> > >  tools/virtio/oot-stubs.h           |  10 +++
> > >  13 files changed, 82 insertions(+), 176 deletions(-)
> > >  create mode 100644 tools/virtio/linux/ucopysize.h
> > >  create mode 100644 tools/virtio/oot-stubs.h
> > >
> > > --
> > > MST
> > >
> >

