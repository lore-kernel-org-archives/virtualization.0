Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B68DEC352A1
	for <virtualization@archiver.kernel.org>; Tue,  6 Dec 2022 16:40:22 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 330C9400BB;
	Tue,  6 Dec 2022 16:40:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 330C9400BB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=X7K7Qs4g
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Ru_gDvPRO5PS; Tue,  6 Dec 2022 16:40:21 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 7EC6240272;
	Tue,  6 Dec 2022 16:40:20 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 7EC6240272
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 58905C0033;
	Tue,  6 Dec 2022 16:40:20 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 7FBBEC002D
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 16:40:19 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id 49FF081E43
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 16:40:19 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 49FF081E43
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=X7K7Qs4g
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id g5nbdZcGI2IU
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 16:40:18 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 7E59181E0F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 7E59181E0F
 for <virtualization@lists.linux-foundation.org>;
 Tue,  6 Dec 2022 16:40:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1670344817;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=6ge3pwq/JlMlTkSjEGqqkwIK42+btCPQr7/pr8xaxyc=;
 b=X7K7Qs4g7Kq6Fwrd0CtbSRKC/5WhkiCm9xIOk8/nk7cdWYgWpidKbUA6RX3LDtf4uD/Ds8
 KSbXfosS0R3s1VjhUQNerMR8CbHSLevBTzqNOX2XFozt5HZ74vXYPSYgcwN3dnqQucnp3R
 Lz0P+/M/dX6K3A0KiO2dzJLiPG81CnM=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-362-2zxlddxLO72lMSA4W-QGww-1; Tue, 06 Dec 2022 11:40:14 -0500
X-MC-Unique: 2zxlddxLO72lMSA4W-QGww-1
Received: by mail-wr1-f69.google.com with SMTP id
 o10-20020adfa10a000000b00241f603af8dso3418548wro.11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 06 Dec 2022 08:40:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=6ge3pwq/JlMlTkSjEGqqkwIK42+btCPQr7/pr8xaxyc=;
 b=K7Nz+l/sfFIp+FVIvVRwOAOeFBaoRZi27vQNCTVAeHDVAKin735F36+TkYkQvx7WC8
 0tvyZZnTWUt3LQYvPdr7rM8z/7EHtpFW4m4QlWTrYmCaAJwFj9iPqVvqIn+8wJPaEXuQ
 doJaGKZtt97ByqnwNi/1cAeUjdsDykKW/KI3WW307MdHC0pxi6a/XlmlyRPzxpFPw/oo
 CPXWgAP6qU0OjyD4wgrVxUcLTduH5pst5VPE38yjddWGA3B2icjf9vMbSmcMFaYXNAIL
 QEbdMysBA/hyx126AlzF2Bmr6PdTjb1oi2JS0GbIJxsamfj6JNocSMs1w4ZnjCRri3N8
 COsw==
X-Gm-Message-State: ANoB5pkCsi2odwoRT3Dr1yKql4VvAT2QLxpmO+87rvu55C9J95742fJl
 Ct2F+gctKghu1xBP4LFAtcOvSSKXYhVKujFr1nLRrmMeN39su4kxkPenR3siYyAH4jhKBwrnj9L
 /j8lDfqi+LwxQ/uteOZglEek81UgVwtja+ecH0+a4zA==
X-Received: by 2002:a05:600c:43d6:b0:3cf:a856:ba2f with SMTP id
 f22-20020a05600c43d600b003cfa856ba2fmr54374401wmn.37.1670344813013; 
 Tue, 06 Dec 2022 08:40:13 -0800 (PST)
X-Google-Smtp-Source: AA0mqf4NVS4Nr5mwzewnBswh2mp5LN3uIb1H6IjnbaF2zAiGYSd8n0GAdY9XUcgUa+xExhq9zeGgKw==
X-Received: by 2002:a05:600c:43d6:b0:3cf:a856:ba2f with SMTP id
 f22-20020a05600c43d600b003cfa856ba2fmr54374381wmn.37.1670344812837; 
 Tue, 06 Dec 2022 08:40:12 -0800 (PST)
Received: from redhat.com ([109.253.207.7]) by smtp.gmail.com with ESMTPSA id
 h20-20020a05600c351400b003c6cd82596esm29427965wmq.43.2022.12.06.08.40.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 06 Dec 2022 08:40:12 -0800 (PST)
Date: Tue, 6 Dec 2022 11:40:06 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Stefan Hajnoczi <stefanha@redhat.com>
Subject: Re: [PATCH v3] virtio_blk: add VIRTIO_BLK_F_LIFETIME feature support
Message-ID: <20221206113744-mutt-send-email-mst@kernel.org>
References: <20221205162035.2261037-1-alvaro.karsz@solid-run.com>
 <Y49ucLGtCOtnbM0K@fedora>
MIME-Version: 1.0
In-Reply-To: <Y49ucLGtCOtnbM0K@fedora>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: Jens Axboe <axboe@kernel.dk>, linux-scsi@vger.kernel.org,
 linux-nvme@lists.infradead.org, virtualization@lists.linux-foundation.org,
 linux-block@vger.kernel.org, dm-devel@redhat.com,
 Paolo Bonzini <pbonzini@redhat.com>
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

On Tue, Dec 06, 2022 at 11:31:44AM -0500, Stefan Hajnoczi wrote:
> On Mon, Dec 05, 2022 at 06:20:34PM +0200, Alvaro Karsz wrote:
> 
> I don't like that the ioctl lifetime struct is passed through
> little-endian from the device to userspace. The point of this new ioctl
> is not to be a passthrough interface. The kernel should define a proper
> UABI struct for the ioctl and handle endianness conversion. But I think
> Michael is happy with this approach, so nevermind.
> 
> > @@ -219,4 +247,8 @@ struct virtio_scsi_inhdr {
> >  #define VIRTIO_BLK_S_OK		0
> >  #define VIRTIO_BLK_S_IOERR	1
> >  #define VIRTIO_BLK_S_UNSUPP	2
> > +
> > +/* Virtblk ioctl commands */
> > +#define VBLK_GET_LIFETIME	_IOR('r', 0, struct virtio_blk_lifetime)
> 
> Does something include <linux/ioctl.h> for _IOR()? Failure to include
> the necessary header file could break userspace applications that
> include <linux/virtio_blk.h>.
> 
> Reviewed-by: Stefan Hajnoczi <stefanha@redhat.com>

Good point. I think it's preferable to add a new header
for this stuff. virtio_blk_ioctl.h ? Have that pull in linux/ioctl.h
Also VIRTIO_BLK_IOCTL_GET_LIFETIME
might be a better name to avoid confusion and collisions.
And s/Virtblk/virtio-blk/

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
