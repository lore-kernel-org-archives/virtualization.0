Return-Path: <SRS0=DI2N=FG=lists.linux-foundation.org=virtualization-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79911C64E7C
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 09:59:16 +0000 (UTC)
Received: from hemlock.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 05E2E20679
	for <virtualization@archiver.kernel.org>; Wed,  2 Dec 2020 09:59:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 05E2E20679
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=virtualization-bounces@lists.linux-foundation.org
Received: from localhost (localhost [127.0.0.1])
	by hemlock.osuosl.org (Postfix) with ESMTP id 6BBD2877E7;
	Wed,  2 Dec 2020 09:59:15 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from hemlock.osuosl.org ([127.0.0.1])
	by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jFiQi-OTKjol; Wed,  2 Dec 2020 09:59:15 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [140.211.9.56])
	by hemlock.osuosl.org (Postfix) with ESMTP id 0034E87797;
	Wed,  2 Dec 2020 09:59:14 +0000 (UTC)
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DEA0CC0859;
	Wed,  2 Dec 2020 09:59:14 +0000 (UTC)
Received: from whitealder.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id C376FC0052
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 09:59:12 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by whitealder.osuosl.org (Postfix) with ESMTP id B2B5787A6B
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 09:59:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from whitealder.osuosl.org ([127.0.0.1])
 by localhost (.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id Aua+xG73N-X0
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 09:59:11 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.7.6
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [63.128.21.124])
 by whitealder.osuosl.org (Postfix) with ESMTPS id 22F4A872EC
 for <virtualization@lists.linux-foundation.org>;
 Wed,  2 Dec 2020 09:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1606903149;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=Z8AQZAgl1UdsrqF/icNEETV75RA2NfX+ehHLJ3NCqqw=;
 b=Kq1r/uonnBSAH1jbjHcbExoxR/xzT6kcikXuBbGStrieklNcW663SwHtu0CbVW+ITr31LW
 5tR4+aebYPshiDLXcRF6vc81cfHHEXCs/JPU+xnF+OLGFFR1MeTbPg0lyHzMB6L+R31AdO
 JDx4EGOEpymUFiZ1GG9WMwWcmQkWbBA=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-6-jDXW42sFN7aLg2-ykBjZnw-1; Wed, 02 Dec 2020 04:59:07 -0500
X-MC-Unique: jDXW42sFN7aLg2-ykBjZnw-1
Received: by mail-wr1-f70.google.com with SMTP id n1so2840897wro.22
 for <virtualization@lists.linux-foundation.org>;
 Wed, 02 Dec 2020 01:59:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to;
 bh=Z8AQZAgl1UdsrqF/icNEETV75RA2NfX+ehHLJ3NCqqw=;
 b=Qf8xgl2/M7b903EBQG9JOjdLqdb6UG89hpWkVo0ACxb/cM08Z1k1MrKXBCMAYwZ9MG
 +bNcwjnX27RaATFzYNtmNMw2mK/D6FANG7Tm4J99ZoCyFAPDYoAVfZJ1cQ/sE4JuR+/c
 UZHm/37FeJFw3NvmP1l+rzVy8dO4c0wAzbsL8Qzf+5rhBCXGnQaArxtIavgoXgdDi32v
 5f/YxjA1KGU14xzp2cRAnRrc3IvQeHpHsEPWstbRiFDTQ8IcwSzizrri5zq8E+8GG1KO
 ohAim2KhnqlHl0stpkg8rfkmcBxlKnB2X7bzJSsE50hGOROLGqpPZypNESouucnjvVI5
 4g2Q==
X-Gm-Message-State: AOAM532VUPYP1b9LcvTJq8qin7SNpfVahO0w6QvveXRYkN1e6hsyzcMu
 AqDLAcmlUU/A1kexAhiHeQPWN+kKvaFNU8z93/Q59WkxfVq02wV2c0PEXCsgpskcpQ0YUYo6TTx
 w9QXRhOgE5WyuY6iXbsOPGgXJ1eupY2Gnmy+0rKgtJQ==
X-Received: by 2002:a7b:cf30:: with SMTP id m16mr2177302wmg.145.1606903146601; 
 Wed, 02 Dec 2020 01:59:06 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxlyOpsA5OFT6XaiG7rTTB0hoZWxmFeJV5oLJmK4wvaw9/zUbY1bAYBODC22GlGVObe124jzQ==
X-Received: by 2002:a7b:cf30:: with SMTP id m16mr2177290wmg.145.1606903146488; 
 Wed, 02 Dec 2020 01:59:06 -0800 (PST)
Received: from redhat.com (bzq-79-176-44-197.red.bezeqint.net. [79.176.44.197])
 by smtp.gmail.com with ESMTPSA id z11sm1418191wmc.39.2020.12.02.01.59.04
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 02 Dec 2020 01:59:05 -0800 (PST)
Date: Wed, 2 Dec 2020 04:59:03 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Subject: Re: [PATCH 1/1] qemu vhost scsi: add VHOST_SET_VRING_ENABLE support
Message-ID: <20201202045807-mutt-send-email-mst@kernel.org>
References: <1605223150-10888-1-git-send-email-michael.christie@oracle.com>
 <1605223150-10888-2-git-send-email-michael.christie@oracle.com>
MIME-Version: 1.0
In-Reply-To: <1605223150-10888-2-git-send-email-michael.christie@oracle.com>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=mst@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: fam@euphon.net, linux-scsi@vger.kernel.org, qemu-devel@nongnu.org,
 virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org,
 stefanha@redhat.com, pbonzini@redhat.com
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

On Thu, Nov 12, 2020 at 05:19:00PM -0600, Mike Christie wrote:
> diff --git a/linux-headers/linux/vhost.h b/linux-headers/linux/vhost.h
> index 7523218..98dd919 100644
> --- a/linux-headers/linux/vhost.h
> +++ b/linux-headers/linux/vhost.h
> @@ -70,6 +70,7 @@
>  #define VHOST_VRING_BIG_ENDIAN 1
>  #define VHOST_SET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x13, struct vhost_vring_state)
>  #define VHOST_GET_VRING_ENDIAN _IOW(VHOST_VIRTIO, 0x14, struct vhost_vring_state)
> +#define VHOST_SET_VRING_ENABLE _IOW(VHOST_VIRTIO, 0x15, struct vhost_vring_state)

OK so first we need the kernel patches, then update the header, then
we can apply the qemu patch.

>  /* The following ioctls use eventfd file descriptors to signal and poll
>   * for events. */
> -- 
> 1.8.3.1

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
