Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90031B85F8
	for <virtualization@lists.linux.dev>; Fri, 24 Oct 2025 01:53:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761270815; cv=none; b=NgkTowMZlrDVRCY/jDiuyPGTEGFJYfxX+jWZE1HnlB3KF3Y5SmJHHjUBEsiXXGVMGQq2nQu6ospbIPZ7wBB64wsLb4PAIdk1ifvHmBYyBCT9navI8LaJGTXegrbDKnht+aYAO4jaUT6lX2/1FgO7LsY8Ep4GeprhulhMTZQG6G0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761270815; c=relaxed/simple;
	bh=KVqqSGuyj1KKKyKPs9FtZn4kXl29szr/vgb0SjWeAaw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sgCog9z0rMQ0rV8tcifof7nY8myh2A//1BS7vKv78KnXKJ33w4EEBSGM4Mo3mOcrz30Rf+GC3UqEJ5WM8Iot6ngzyc8Czu+wlj16vLWQvFP1QtDEzVwMq+sXbteQ0q8qgEdntBC9f/eIu+D9ncm+tkDqwUO3aVkwCxyjIjp/Enc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=fcPnLrIr; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="fcPnLrIr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761270811;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=KVqqSGuyj1KKKyKPs9FtZn4kXl29szr/vgb0SjWeAaw=;
	b=fcPnLrIrVY01a4R86nTt54vFW4TQqf9j8eOnSnc6fVwkipyCOYxWUVf6R7ImGPhiXKeF99
	QLWJFtr7FhkphrmYvcVQe5uZY4Gikp9HlODhlFzYMcsxy1UIc6cEckx03G/jMwZbZ7ne7W
	wVoVKEvbpmoQwMwDRqU8njaYhg0ubNo=
Received: from mail-pj1-f71.google.com (mail-pj1-f71.google.com
 [209.85.216.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-605-kBdsgNteNp2fUesftACw8A-1; Thu, 23 Oct 2025 21:53:30 -0400
X-MC-Unique: kBdsgNteNp2fUesftACw8A-1
X-Mimecast-MFC-AGG-ID: kBdsgNteNp2fUesftACw8A_1761270809
Received: by mail-pj1-f71.google.com with SMTP id 98e67ed59e1d1-3304def7909so1235804a91.3
        for <virtualization@lists.linux.dev>; Thu, 23 Oct 2025 18:53:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761270809; x=1761875609;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=KVqqSGuyj1KKKyKPs9FtZn4kXl29szr/vgb0SjWeAaw=;
        b=i2Z3pKr02RqagN/4XfnaBLDQEMwDMehYmVL1hPMpMV0KxJuXWZCANYsUwGQO2+lUF+
         DUlotS+9S3Ma/r5NQ8VY3c3faU1MMpL/NcQJhjiK+37XEbYOEIQ7CvwRHkar03PldYDt
         9vD+oTJuudtEi0zOBrsLMpw6cRg/2/28B8ZaGE64HFKKSPI1AzMqN/OTyZLw5YmtnolG
         0ZacjqNe82uoHoQogeHIR7zxul6diKZbLUg9y4R6sLBX0aOJy6fVccHaxsfTKifq+edv
         9HSJbYm/OWIRk3exOiacd6YtmOgp1rApPcZJsj3qZA7w6BJvxrZmb/g5X3MJu8dXgei/
         m3kw==
X-Forwarded-Encrypted: i=1; AJvYcCUDyOTR0X4VlI9ujwtiKi2zaZKSc4EBL2jVir7GTsC3Bs/Hb1LJcHXpHeODdS+PrxHXi9PgN5xf2oAiNlgrfA==@lists.linux.dev
X-Gm-Message-State: AOJu0YzX9177jqm8XQjqaoWiuoU8f3RvmGd45l5fnH9aIKkJ6iHo11vL
	x+lG0kBtzfnYyAAxnpvz8wwGVk9+hMPU2CDjRVuBlQMIdLHfwf3GFBLkSh2QIj56Gan6PoqPBN0
	+eVgt9Q5IvFH63rN+8nMUsFP5yUwbRA2AHQzvh8Q6+x4zS7L9LuCP8ZvE/e4SAo7WRng5HlCv6h
	kO2MyfGbEmGHgGzlSat7D8MD7kfOfYxj/nzP3IOfEoYiPhxgoYNioXJA==
X-Gm-Gg: ASbGnct2KwSeb3WYl2/hyxC1haJvT1CdmSa/GFHkKVXCEtm5NvWb41OuzVzXnIe37el
	LaaCSgOcd1epUtTvNsOb0vX2XmhF15EU/m/urXLw+glX/L4QgkDC7peV1KDlGzk7DlVNJ+DXNeD
	+YJAhVdouP3Py4xAVJ+7P8t6FpgVJCZATPIxeLWcfjYQO7KOY5q1LM
X-Received: by 2002:a17:90b:1d09:b0:32d:fcd8:1a9 with SMTP id 98e67ed59e1d1-33bcf9184fbmr29214816a91.32.1761270809072;
        Thu, 23 Oct 2025 18:53:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHsBeHOplUd/WyM6SWj5DzzqN2gBs6fNtn3+DWYZLJIqGLOCugXBpG31RrXU/xsg19TCcAwlaHbUb+zjFUTsEw=
X-Received: by 2002:a17:90b:1d09:b0:32d:fcd8:1a9 with SMTP id
 98e67ed59e1d1-33bcf9184fbmr29214783a91.32.1761270808623; Thu, 23 Oct 2025
 18:53:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <CAP4dvsfZEo+1+O8tpLFFh=s-fEFaMRu2+mQ3F=LJmjoEHyZXMw@mail.gmail.com>
 <20251022073015-mutt-send-email-mst@kernel.org> <CAP4dvsfXs7Do=9d_05tzU5FUuqfLnsFSpodSMDhv=FR2KYWh=w@mail.gmail.com>
In-Reply-To: <CAP4dvsfXs7Do=9d_05tzU5FUuqfLnsFSpodSMDhv=FR2KYWh=w@mail.gmail.com>
From: Jason Wang <jasowang@redhat.com>
Date: Fri, 24 Oct 2025 09:53:17 +0800
X-Gm-Features: AS18NWDdJuKG6vKK_bzOP0t79oqjXBADCm6utzV0TKdl_JjJDADy7A5BbisRTKY
Message-ID: <CACGkMEugHNb1QfG17sPzDfV8-W1mJQGX_cJQvDCoCVQ7axGRkQ@mail.gmail.com>
Subject: Re: [External] Re: virtio_pci: Question about virtio_pci kernel
 module refcnt
To: Zhang Tianci <zhangtianci.1997@bytedance.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, xuanzhuo@linux.alibaba.com, eperezma@redhat.com, 
	virtualization@lists.linux.dev, xieyongji@bytedance.com
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Uia8VEFXSRa8fBenzoCrVp2RiSdvH9S7oNg7ceNVGRs_1761270809
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Oct 23, 2025 at 10:34=E2=80=AFAM Zhang Tianci
<zhangtianci.1997@bytedance.com> wrote:
>
> Hi, thank you for your reply, but I still have a few questions:
>
> On Wed, Oct 22, 2025 at 7:31=E2=80=AFPM Michael S. Tsirkin <mst@redhat.co=
m> wrote:
> >
> > On Wed, Oct 22, 2025 at 07:21:45PM +0800, Zhang Tianci wrote:
> > > Hi,
> > > I noticed that the reference count of the virtio_pci kernel module
> > > in the VM is always 0, even though there are at least two
> > > virtio block devices and one virtiofs device in the VM.
> > >
> > > Using rmmod virtio_pci can unload the virtio_pci module,
> > > but this renders the virtio block devices unusable.
> >
> > it removes them. you can put it back in and you will
> > get devices again.
>
> But I can't do it anymore because the rootfs is no longer available,
> or rather, the OS is no longer available.
>
> >
> > > I wonder if this result is expected? Why don't the virtio block devic=
es
> > > and virtiofs device hold a reference count to the virtio_pci kernel m=
odule?
> >
> > because they don't have to.
>
> Is it due to design reasons or implementation reasons?
> Is it because the semantics of kernel module refcnt does not include such
> logical dependency?

Note that virito has a bus so it follows the device/driver model so if
I was not wrong the refcnt was handled by the driver core.

Thanks

>
> Thanks,
> Tianci
>

