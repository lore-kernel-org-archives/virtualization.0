Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EBDAC00A8F
	for <virtualization@archiver.kernel.org>; Tue, 24 Oct 2023 11:12:54 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 0F995430D4;
	Tue, 24 Oct 2023 11:12:54 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0F995430D4
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=WQ9C+WgE
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id qNSh0mLuuLCc; Tue, 24 Oct 2023 11:12:52 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 4266440144;
	Tue, 24 Oct 2023 11:12:52 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 4266440144
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id E8CBFC0071;
	Tue, 24 Oct 2023 11:12:51 +0000 (UTC)
Received: from smtp2.osuosl.org (smtp2.osuosl.org [IPv6:2605:bc80:3010::133])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 69221C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 11:12:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp2.osuosl.org (Postfix) with ESMTP id 33E9E43059
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 11:12:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 33E9E43059
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id xU4XVD8quvPc
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 11:12:45 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp2.osuosl.org (Postfix) with ESMTPS id BF24A40144
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 11:12:44 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BF24A40144
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1698145963;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=C2lXPU4q4S6eFWPmbdstO3s/7qoi/uNTcNbWNU4XbWU=;
 b=WQ9C+WgE1/xHhP+K7fLUcGyQr3WrAYh7XzQRKf4F4oYimg2T0EOebzMnPaQvbvjUxjBopC
 hQ4hjacuR6qw2UxAzRmsZBa5FBSJFnf49l8g/nGFtX36DG7klr72bTTgFISplXCIsp1ewJ
 Ifc87HKwF9prMS//CIQhafcu43Q8xiA=
Received: from mail-qt1-f198.google.com (mail-qt1-f198.google.com
 [209.85.160.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-114-bMj2EKonMue7ADfv5zvmRQ-1; Tue, 24 Oct 2023 07:12:40 -0400
X-MC-Unique: bMj2EKonMue7ADfv5zvmRQ-1
Received: by mail-qt1-f198.google.com with SMTP id
 d75a77b69052e-41e1d05a5d7so20564091cf.2
 for <virtualization@lists.linux-foundation.org>;
 Tue, 24 Oct 2023 04:12:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1698145960; x=1698750760;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C2lXPU4q4S6eFWPmbdstO3s/7qoi/uNTcNbWNU4XbWU=;
 b=uaDIjHngzsFqPHnQrbFl5qqCMSZWDB8iEt6D7i/rXSiNMH/Z2pXD5h6ukj7OJEStRd
 ZmAFNoyfwtiSXLy68WXBeoRulLzDyQl/rTGlcEheHu7tcaDbC6eVLlFE0ZmEjL521NXV
 pBqrRhWMky6KBNxAzofyYLD6fR3ZZTO9EHB2A4gDzHLfPz+LBj5FHKsZJXfIRcRgIuMF
 9C8xLMrvduRrNGMMXktZwcgALXrhN+3uhs890/1Fz+AaDnUMQ+rrTqyF/1APVJLzWKyE
 tws4yYAwjcDsHLY4JA/IgoPiXZynGCmfjxfcGhzsqNoGr4zu6ee8v6mTvOl0h7sXcrox
 a9Ew==
X-Gm-Message-State: AOJu0Yy6BdUBSkU4pa1zahB/1L3sEulDYJA/EvtAXgEj9S/Ieyv1IkVX
 wmko4dSoPceR/jjs3405zFJhxf5EQ2xLbfkgweFHq7RyJbC9A/jqRVVHRZ91Y6cSqU8GmnTjhgy
 nTAhm6EzopHYJM/aJANOIxLPzp10mnl4WonZmoDto6g==
X-Received: by 2002:a05:622a:348:b0:41e:1d17:4ca1 with SMTP id
 r8-20020a05622a034800b0041e1d174ca1mr5741154qtw.67.1698145959886; 
 Tue, 24 Oct 2023 04:12:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGgH9JWinTw/3VyBxR3NnKUHUrfU7r6j4m3KUt/L2niRCaXzILlLO+k91SaFhh6Nmg6pOHNdg==
X-Received: by 2002:a05:622a:348:b0:41e:1d17:4ca1 with SMTP id
 r8-20020a05622a034800b0041e1d174ca1mr5741142qtw.67.1698145959653; 
 Tue, 24 Oct 2023 04:12:39 -0700 (PDT)
Received: from fedora ([2a01:e0a:257:8c60:80f1:cdf8:48d0:b0a1])
 by smtp.gmail.com with ESMTPSA id
 z5-20020ac87ca5000000b00410ac0068d0sm3380879qtv.91.2023.10.24.04.12.37
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 24 Oct 2023 04:12:39 -0700 (PDT)
Date: Tue, 24 Oct 2023 13:12:35 +0200
From: Matias Ezequiel Vara Larsen <mvaralar@redhat.com>
To: Takashi Iwai <tiwai@suse.de>
Subject: Re: [PATCH v3] ALSA: virtio: use ack callback
Message-ID: <ZTemo0P/kEcceK/O@fedora>
References: <ZTaMEUZUTrRRUD6y@fedora>
 <87edhlwd7b.wl-tiwai@suse.de>
MIME-Version: 1.0
In-Reply-To: <87edhlwd7b.wl-tiwai@suse.de>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: alsa-devel@alsa-project.org, mripard@redhat.com, mst@redhat.com,
 linux-kernel@vger.kernel.org, tiwai@suse.com, perex@perex.cz,
 stefanha@redhat.com, pbonzini@redhat.com,
 virtualization@lists.linux-foundation.org
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

On Mon, Oct 23, 2023 at 05:50:00PM +0200, Takashi Iwai wrote:
> On Mon, 23 Oct 2023 17:06:57 +0200,
> Matias Ezequiel Vara Larsen wrote:
> > 
> > +static int virtsnd_pcm_ack(struct snd_pcm_substream *substream)
> > +{
> > +	struct virtio_pcm_substream *vss = snd_pcm_substream_chip(substream);
> > +	struct virtio_snd_queue *queue = virtsnd_pcm_queue(vss);
> > +	unsigned long flags;
> > +	struct snd_pcm_runtime *runtime = vss->substream->runtime;
> > +	ssize_t appl_pos = frames_to_bytes(runtime, runtime->control->appl_ptr);
> > +	ssize_t buf_size = frames_to_bytes(runtime, runtime->buffer_size);
> > +	int rc;
> > +
> > +	spin_lock_irqsave(&queue->lock, flags);
> > +	spin_lock(&vss->lock);
> > +
> > +	ssize_t bytes = (appl_pos - vss->appl_ptr) % buf_size;
> 
> The variable declaration should be moved to the beginning of the
> function.
> 
> Also, there can be a overlap beyond runtime->boundary (which easily
> happens for 32bit apps), so the calculation can be a bit more complex
> with conditional.
> 

Should I use as an example `cs46xx_playback/capture_transfer()` which relies on
the `snd_pcm_indirect_playback/capture_transfer()`? It looks like it
does already that calculation.

Thanks, Matias.

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
