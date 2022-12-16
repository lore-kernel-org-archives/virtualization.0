Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3E5F8C4332F
	for <virtualization@archiver.kernel.org>; Fri, 16 Dec 2022 23:50:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id BEE11404EB;
	Fri, 16 Dec 2022 23:50:39 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org BEE11404EB
Authentication-Results: smtp2.osuosl.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20210112 header.b=DFWmzXho
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 4tlqVUcFdYlj; Fri, 16 Dec 2022 23:50:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 30DF640131;
	Fri, 16 Dec 2022 23:50:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 30DF640131
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id DE8D8C0032;
	Fri, 16 Dec 2022 23:50:37 +0000 (UTC)
Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
 by lists.linuxfoundation.org (Postfix) with ESMTP id E468FC002D
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 23:50:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp1.osuosl.org (Postfix) with ESMTP id BB69F821E0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 23:50:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org BB69F821E0
Authentication-Results: smtp1.osuosl.org;
 dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com
 header.a=rsa-sha256 header.s=20210112 header.b=DFWmzXho
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp1.osuosl.org ([127.0.0.1])
 by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id HwxYHMxlb6dA
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 23:50:35 +0000 (UTC)
X-Greylist: whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org 58C06821D0
Received: from mail-ej1-x632.google.com (mail-ej1-x632.google.com
 [IPv6:2a00:1450:4864:20::632])
 by smtp1.osuosl.org (Postfix) with ESMTPS id 58C06821D0
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 23:50:35 +0000 (UTC)
Received: by mail-ej1-x632.google.com with SMTP id fc4so9587152ejc.12
 for <virtualization@lists.linux-foundation.org>;
 Fri, 16 Dec 2022 15:50:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:from:to:cc:subject:date:message-id:reply-to;
 bh=TGYD/43itP5jhG3AMBWGsLpG3Fh9gkXSMBOyCxjkuIg=;
 b=DFWmzXhou89wjbd+iGzTLJwfYda3hHS9r24xTVxCKieeD+uu6DdkEXffcEd2ysdH4p
 RpK7h6R1mB8cGGCN1HwXC5CPxrBEnhPYsr06FXPNuYThCqSEPgqVIm6mg0B4k2k6dwtv
 ceqVVN4pcBmmckFqXYpgnIsS34O3w9bS1Lbr6wJLHuNkGfwP0vhKCB0IdgoxuqDerqrL
 KXk3stNKbyLGRtCQq9jtR+PsZxtDn/ONjzQDukYrfHLrxzfDkjHjAmYUZwXUIIlYuves
 Ao7JaoCw8cDZ1d0Qe8iFsKMHYXKZ282+mClr9EB/fCBLg11XL//2GRWtDsS+BdFyEUUR
 4+OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
 :reply-to;
 bh=TGYD/43itP5jhG3AMBWGsLpG3Fh9gkXSMBOyCxjkuIg=;
 b=t6XGydFJ3zJRWTvdHBergEotg4X5TlalK+HdyH1dm3R9VKI9JmzESulg5UKy2d8m/O
 ErYQCkSeQ/Qi7NlcOawqEHmoDViHmdSb9Qy+j2kVBJGW5jQ056CNkQdkdi/QY7gk5T4F
 NQv9WF1e0+O1BpyWuOtz0m9i4etz18SrJ6Adagg0rf7uj+4lLaThhPFG28KOc4WhbJHw
 kHxACH9r07XMvcrnbLTDOgVC5HFk8IlMbsLLWFobBsLM5KJ0rmEcCA2grcVnXYEGeogm
 hmfNnttr9tTXVVXw7kNx1eq/YJyc8zWBZS9Ff34Nf8TJx14c/HPoF/Pdbj7V3MLjL6nb
 FA7g==
X-Gm-Message-State: ANoB5plgH3k+y0fY2aLzkrQPZdPFokst3g80D2bUjuItMSlkCa0Yptm+
 4Y9/q58gJw8cultpUUc1g4xeOU1RFI+2/lhZNbY=
X-Google-Smtp-Source: AA0mqf4iQerKq0SXayxMXO4sNZ6BbliwbFrIcsnISdHyxGatyx5ONcxi5wUKJH+zijrxaeowMgGhBYK9ymjQbiWn35c=
X-Received: by 2002:a17:906:1308:b0:7c1:55aa:2e83 with SMTP id
 w8-20020a170906130800b007c155aa2e83mr2775643ejb.361.1671234633422; Fri, 16
 Dec 2022 15:50:33 -0800 (PST)
MIME-Version: 1.0
References: <20221216233355.542197-1-robdclark@gmail.com>
 <20221216233355.542197-2-robdclark@gmail.com>
In-Reply-To: <20221216233355.542197-2-robdclark@gmail.com>
From: Chia-I Wu <olvaffe@gmail.com>
Date: Fri, 16 Dec 2022 15:50:22 -0800
Message-ID: <CAPaKu7Ti5sEzGVRaE8UFx1RRbBba3=am8rwZf3totX1z8bfJHQ@mail.gmail.com>
Subject: Re: [PATCH] drm/virtio: Fix GEM handle creation UAF
To: Rob Clark <robdclark@gmail.com>
Cc: Rob Clark <robdclark@chromium.org>,
 open list <linux-kernel@vger.kernel.org>, dri-devel@lists.freedesktop.org,
 Gurchetan Singh <gurchetansingh@chromium.org>, Daniel Vetter <daniel@ffwll.ch>,
 David Airlie <airlied@redhat.com>,
 "open list:VIRTIO GPU DRIVER" <virtualization@lists.linux-foundation.org>
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

On Fri, Dec 16, 2022 at 3:33 PM Rob Clark <robdclark@gmail.com> wrote:
>
> From: Rob Clark <robdclark@chromium.org>
>
> Userspace can guess the handle value and try to race GEM object creation
> with handle close, resulting in a use-after-free if we dereference the
> object after dropping the handle's reference.  For that reason, dropping
> the handle's reference must be done *after* we are done dereferencing
> the object.
>
> Signed-off-by: Rob Clark <robdclark@chromium.org>
Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
