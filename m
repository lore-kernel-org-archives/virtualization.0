Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1AD8DC74A5B
	for <virtualization@archiver.kernel.org>; Tue, 21 Mar 2023 07:12:56 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id 9712C40AE1;
	Tue, 21 Mar 2023 07:12:55 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 9712C40AE1
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=OYNxgqNV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id law9hRzDV3sc; Tue, 21 Mar 2023 07:12:54 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 0AB92400D3;
	Tue, 21 Mar 2023 07:12:53 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 0AB92400D3
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id C4C93C0071;
	Tue, 21 Mar 2023 07:12:53 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [IPv6:2605:bc80:3010::136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id 91CDEC0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 07:12:51 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 661C260B11
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 07:12:51 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 661C260B11
Authentication-Results: smtp3.osuosl.org;
 dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com
 header.a=rsa-sha256 header.s=mimecast20190719 header.b=OYNxgqNV
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id 127ZSrZyWT3d
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 07:12:48 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 5671860A4F
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.129.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id 5671860A4F
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 07:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1679382766;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=p8ugM/ytesWqF34fV4HlXU0YWGvC9AcHqKjsu6is6SE=;
 b=OYNxgqNVm8Fthd71MLq6Qq0gthP6cL2c8CV0FZNODj2pT2ogtpf0MfQC1FrdMhwfGtbNU0
 Ti+I0sPKlwklogKFxZhl6vnIpk4GO40aPf4es/LV8ujHr5bfy1GjAredzvey3CWzfmGmbT
 6mmpLXfsADt22DSqrK5YyFY6xEZs6mc=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-333-3d4Kf9S-MqeQjeNxbH6NYg-1; Tue, 21 Mar 2023 03:12:45 -0400
X-MC-Unique: 3d4Kf9S-MqeQjeNxbH6NYg-1
Received: by mail-wm1-f69.google.com with SMTP id
 p10-20020a05600c358a00b003edf7d484d4so1982637wmq.0
 for <virtualization@lists.linux-foundation.org>;
 Tue, 21 Mar 2023 00:12:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112; t=1679382764;
 h=in-reply-to:content-disposition:mime-version:references:message-id
 :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=p8ugM/ytesWqF34fV4HlXU0YWGvC9AcHqKjsu6is6SE=;
 b=NyWvswORJ2xF+njXmaHD/ftzizeZT0tjPQNp11VjYJhLItPQtGCLVLfig5OvWFI24J
 h7XQ6QdMIUal0gTQWyqSieDSK4FnMQrNIHhdf39PjD1M93EwqGPWoeg5n9FLADJEoPQt
 EOyI9vKzVlG252YdJet1RM+NBsQPgy5Bov7xpN7DlfCJSgPDE4gKwtVVgVGLByddK2QW
 1FvtatflBeuyz0UxlTnGspbhaowwHACIOv6RuNMI2SiwSi7p9vhyB2FoOkopIDlrByHb
 HujWmI2uaKHmgqQqLKZR+BwEU9TCsa/VhZtitLPeZQ6Y4LlYs/H/ZdXCCj6cFb8k7rPX
 Lt+w==
X-Gm-Message-State: AO0yUKV6ijAgOP/BNL7DJIig7G5Vg6pA3u8D8bJGqOYGmT0DvgBD8+Kf
 wJzoxXjripZTEBFIu0nTPwn7uSizJlBsUsW/Rtnoe96SGB0ztAPwy6UzCNHQ9XzdTS6IN9IGWID
 licBNbUauQRIlLcpzxksKA8S2otOWAUcbgkiFEpkEEQ==
X-Received: by 2002:a5d:5686:0:b0:2cf:ee25:18ce with SMTP id
 f6-20020a5d5686000000b002cfee2518cemr1688023wrv.27.1679382764458; 
 Tue, 21 Mar 2023 00:12:44 -0700 (PDT)
X-Google-Smtp-Source: AK7set/dVewTSOqdyJmq47xput657YXM3zFLzlzIaRrCvNgpUkq9OkJ2e35jg3xMjhBxDWtcYlageg==
X-Received: by 2002:a5d:5686:0:b0:2cf:ee25:18ce with SMTP id
 f6-20020a5d5686000000b002cfee2518cemr1688010wrv.27.1679382764180; 
 Tue, 21 Mar 2023 00:12:44 -0700 (PDT)
Received: from redhat.com ([2.52.1.105]) by smtp.gmail.com with ESMTPSA id
 z6-20020a056000110600b002c557f82e27sm10510774wrw.99.2023.03.21.00.12.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Mar 2023 00:12:43 -0700 (PDT)
Date: Tue, 21 Mar 2023 03:12:40 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: michael.christie@oracle.com
Subject: Re: [PATCH v2 0/7] vhost-scsi: Fix crashes and management op hangs
Message-ID: <20230321031147-mutt-send-email-mst@kernel.org>
References: <20230321020624.13323-1-michael.christie@oracle.com>
 <e1a96cd4-e520-caf5-7d5f-1de270c4fecb@oracle.com>
MIME-Version: 1.0
In-Reply-To: <e1a96cd4-e520-caf5-7d5f-1de270c4fecb@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Disposition: inline
Cc: linux-scsi@vger.kernel.org, virtualization@lists.linux-foundation.org,
 target-devel@vger.kernel.org, stefanha@redhat.com
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

On Mon, Mar 20, 2023 at 09:29:50PM -0500, michael.christie@oracle.com wrote:
> On 3/20/23 9:06 PM, Mike Christie wrote:
> > The following patches were made over Linus tree.
> 
> Hi Michael, I see you merged my first version of the patchset in your
> vhost branch.
> 
> Do you want me to just send a followup patchset?
> 
> The major diff between the 2 versions:
> 
> 1. I added the first 2 patches which fix some bugs in the existing code
> I found while doing some code review and testing another LIO patchset
> plus v1.
> 
> Note: The other day I posted that I thought the 3rd patch in v1 caused
> the bugs but they were already in the code.
> 
> 2. In v2 I made one of the patches not need the vhost device lock when
> unmapping/mapping LUNs, so you can add new LUNs even if one LUN on the same
> vhost_scsi device was hung.
> 
> Since it's not regressions with the existing patches, I can just send those
> as a followup patchset if that's preferred.

It's ok, I will drop v1 and replace it with v2.
Do you feel any of this is needed in this release?

-- 
MST

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
