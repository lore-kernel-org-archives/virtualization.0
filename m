Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C65DDA9
	for <virtualization@lists.linux.dev>; Sat, 18 Apr 2026 00:31:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776472269; cv=none; b=f71TJjERWkIg1x4ls/0SI/REXpY14fixIhR+YnvbMST0+MoyxZrN8FRxptOB6D00Wr/ocT4YD5kqZbphSPqOYuyYoGgkfDlYj7C59gcidQs4f38hIGr6wtH/DnNIPvxQ0z4OfSHtbK8/+BK2wD637qmiu11cqTkBE/4TDdABtlo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776472269; c=relaxed/simple;
	bh=bH3XTTI13kA5J/Ns082dZsYWHK1cNLvuDe4MsdGZb04=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hKv1nytUxFjpFMOEtBpF8PY9af7muD+3Hbfhys7zb9SSgAutTdPpzH51/yCtAiTveyfbzJ9/gWEA+8O+2FXM2Smb1z4QBkpVxxC5eYKgRXFyOoeX13IEAl2CIbr/LWgvap8ohIOi7D+wsy4L3Oobr0KvMVQfJSBJiFbOIgaJq3s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FUPMQ8Pf; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FUPMQ8Pf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1776472267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=gntGGQguH0Am4pdEgFT88PvB7XjJHe+6hBodNgxy/CU=;
	b=FUPMQ8Pfb74k0HSmwE7miAqkUcJN5bnmgZnTDXOEN8E/0eOKh7DUWXvbP+4ZIWDsyYfleG
	3E3tR5VX6/DBW/4pu9f9G3K7CNGlFdr/5eALJ6/ZTD+xy7DCoZbqmjqj7KfPmRdgmABshz
	9E5KhX/5AFUHx7Wfw4ZFSV4/Pt4vMf8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-191-u9ZUl1-hPMisDMfq-GRNNg-1; Fri, 17 Apr 2026 20:31:06 -0400
X-MC-Unique: u9ZUl1-hPMisDMfq-GRNNg-1
X-Mimecast-MFC-AGG-ID: u9ZUl1-hPMisDMfq-GRNNg_1776472265
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43d705eaa64so1293490f8f.0
        for <virtualization@lists.linux.dev>; Fri, 17 Apr 2026 17:31:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776472265; x=1777077065;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gntGGQguH0Am4pdEgFT88PvB7XjJHe+6hBodNgxy/CU=;
        b=MXlH2M5g9xJuK11v0WAxUwrtErSV2S8HmFTnl5Lp7zTB3muHAMQsoPNM8Qplb04odp
         GFNwqBlrwdS1xrugeEDx7G25hoYefCsKMZ/v1wF782dTDRRj91zqWroyjQO9eEa/VMlm
         BRTRsGycVuly0gHwTTZHyRV3q2nlpt/3TtRSquBVjEBeDkmduOcj8SvNIl4RI5ntIc3a
         uGv0/GeMoa/fG3/7k/T9cl/ScbG4gC62fZE1/J1Zg6dyLfFossBD2tOgy02T7Ig0jzQE
         ftzCjMYLxD3y8GdrHHJefyEqRut1zUzQtC7R/n3Lb25CvHyGJB8asGxsIYQ8o11gOl/w
         +cMg==
X-Forwarded-Encrypted: i=1; AFNElJ8Z6uyGsdOFowc44Q5ROwXP5GoX+y/1rHI+9xnORascEnZa00ZWiiLuFQ95KL+FLayQs18nM6q4nmNdSQo01g==@lists.linux.dev
X-Gm-Message-State: AOJu0YxqtFzql54KvrYWE9yvHQRxnDbtMd+R98t/FP1rXGXKXljdA8ZH
	o4aKPhYUru2d+u5vFZDjUY6GwQFbiynivl+3md1FWtHNK3RV+KoMZ+QTkV0BAR7PM2XUzgAqTQ3
	efRGLtWkYnmCDYFxOJFbMLbqLLvShj30DvDIDq0GprnregMiFAk3f8B/MZ2q2z76RMBcd
X-Gm-Gg: AeBDievI7Detvsi8c1ggWQlwJHcfy2Qe+nHHncrbw3V/IEOV1ejRAkQWOU2WYMXugYI
	OJiwbxHBoA1yaRvMeY5xM9wdpurdWQQtsEd/8+0Et3TyzxN7Yicw2P4KZ8/LZj4d9qlXqXyCFN0
	QQ/j8EmKb6ef8m8KXQufhj+scpKacLfYGbN17YjzxhupB9JYoTiy3rVAAwifxKbOsOA9Od0uVgg
	MnsbBG06+sILhEnV7X+dS1UdqxSuJ+gPq5B9yl5RV7N3MDsQc8BlXk0pBQV76f/x7SbkTukNfNA
	53uA5kCupkednILvpFe8383FtBV8BpLKQa2nbVrI2kfnhuMF2vf6x+6ACx39JQ6JKnIj7BaD5cV
	y10sAnymlBnbgTVxV+NqwqIT0XWHNj2F2F6Rw6RErbzkX0UtYj50sKQ==
X-Received: by 2002:a05:600c:c085:b0:488:acbc:b2e with SMTP id 5b1f17b1804b1-488fb765b04mr53093805e9.17.1776472265227;
        Fri, 17 Apr 2026 17:31:05 -0700 (PDT)
X-Received: by 2002:a05:600c:c085:b0:488:acbc:b2e with SMTP id 5b1f17b1804b1-488fb765b04mr53093615e9.17.1776472264708;
        Fri, 17 Apr 2026 17:31:04 -0700 (PDT)
Received: from redhat.com (IGLD-80-230-25-21.inter.net.il. [80.230.25.21])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43fe4e3a79esm10108821f8f.17.2026.04.17.17.31.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 17:31:03 -0700 (PDT)
Date: Fri, 17 Apr 2026 20:31:01 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Michael Bommarito <michael.bommarito@gmail.com>
Cc: Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
	Jason Wang <jasowang@redhat.com>, virtualization@lists.linux.dev
Subject: Re: [PATCH] hwrng: virtio: reject invalid used.len from the device
Message-ID: <20260417202330-mutt-send-email-mst@kernel.org>
References: <20260418000020.1847122-1-michael.bommarito@gmail.com>
 <20260417201129-mutt-send-email-mst@kernel.org>
 <CAJJ9bXzhKTBx4m3-SCM+ccGd6ZhTXTAbRxKekCzidnXY6yXbWg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAJJ9bXzhKTBx4m3-SCM+ccGd6ZhTXTAbRxKekCzidnXY6yXbWg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: WWmmbmjCykPtE65I9zaC-R57mfsa6XmYV7Za4-SWWGM_1776472265
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Fri, Apr 17, 2026 at 08:18:06PM -0400, Michael Bommarito wrote:
> "Actionable" is probably the better word there, sorry.

Actionable meaning what?

>  If it were
> otherwise, I wouldn't have filed publicly
> 
> If you end up ACKing the correctness change, I can send v2 with better log
> 
> Thanks,
> Michael Bommarito
> 
> On Fri, Apr 17, 2026 at 8:13 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Fri, Apr 17, 2026 at 08:00:20PM -0400, Michael Bommarito wrote:
> > > random_recv_done() stored the device-reported used.len directly into
> > > vi->data_avail without validating it against the posted buffer size
> > > sizeof(vi->data) (SMP_CACHE_BYTES bytes, typically 32 or 64).  A
> > > malicious or buggy virtio-rng backend could set used.len beyond
> > > vi->data so that the subsequent copy_data() in virtio_read() issues
> > > memcpy() from vi->data + vi->data_idx past the end of the inline
> > > array, reading adjacent kmalloc-1k slab bytes into the hwrng core's
> > > buffer and from there into /dev/hwrng consumers and the kernel
> > > entropy pool.
> > >
> > > Exploitable most clearly in threat models that do not trust the
> > > hypervisor (confidential-compute guests on SEV-SNP or TDX; vhost-user
> > > split backends).
> >
> > Exploitable? I don't get it. How is reading this data into hwrng
> > a problem?
> >
> >
> > > KASAN confirms the OOB on a guest booted under a QEMU 9.0 whose
> > > virtio-rng backend has been patched to report used.len = 0x10000:
> > >
> > >   BUG: KASAN: slab-out-of-bounds in virtio_read+0x394/0x5d0
> > >   Read of size 64 at addr ffff8880089c2220 by task hwrng/52
> > >   Call Trace:
> > >    __asan_memcpy
> > >    virtio_read+0x394/0x5d0
> > >    hwrng_fillfn+0xb2/0x470
> > >    kthread
> > >   Allocated by task 1:
> > >    probe_common+0xa5/0x660
> > >    virtio_dev_probe+0x549/0xbc0
> > >   The buggy address belongs to the object at ffff8880089c2000
> > >    which belongs to the cache kmalloc-1k of size 1024
> > >   The buggy address is located 0 bytes to the right of
> > >    allocated 544-byte region [ffff8880089c2000, ffff8880089c2220)
> > >
> > > hwrng_fillfn is a kernel thread that runs as soon as the device is
> > > probed; no guest userspace interaction is needed.
> > >
> > > Same class of bug as commit c04db81cd028 ("net/9p: Fix buffer overflow in USB transport layer"),
> > > which hardened usb9pfs_rx_complete against unchecked device-reported
> > > length in the USB 9p transport.
> > >
> > > With the added len-vs-sizeof(vi->data) clamp in place the same
> > > harness boots cleanly: the driver logs "bogus used.len" once and
> > > subsequent reads wait for a honest response.
> > >
> > > Fixes: f7f510ec1957 ("virtio: An entropy device, as suggested by hpa.")
> > > Cc: stable@vger.kernel.org
> > > Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
> > > Assisted-by: Claude:claude-opus-4-7
> > > ---
> > >  drivers/char/hw_random/virtio-rng.c | 12 ++++++++++++
> > >  1 file changed, 12 insertions(+)
> > >
> > > diff --git a/drivers/char/hw_random/virtio-rng.c b/drivers/char/hw_random/virtio-rng.c
> > > index 0ce02d7e5048..6cff480787ca 100644
> > > --- a/drivers/char/hw_random/virtio-rng.c
> > > +++ b/drivers/char/hw_random/virtio-rng.c
> > > @@ -47,6 +47,18 @@ static void random_recv_done(struct virtqueue *vq)
> > >       if (!virtqueue_get_buf(vi->vq, &len))
> > >               return;
> > >
> > > +     /*
> > > +      * The device sets used.len; a malicious or buggy backend can
> > > +      * report more bytes than we posted.  Clamp before it reaches
> > > +      * copy_data() which indexes vi->data[].




> > > +      */
> > > +     if (len > sizeof(vi->data)) {
> > > +             dev_err(&vq->vdev->dev,
> > > +                     "bogus used.len %u > buffer size %zu\n",
> > > +                     len, sizeof(vi->data));
> > > +             len = 0;
> > > +     }


Maybe clamp at sizeof(vi->data) then? 0 might break buggy devices that
were working earlier.  
Or just clamp where it's used, for clarity.
And maybe we need the array_index dance, given
you are worried about malicious.


> > > +
> > >       smp_store_release(&vi->data_avail, len);
> > >       complete(&vi->have_data);
> > >  }
> > > --
> > > 2.53.0
> >

