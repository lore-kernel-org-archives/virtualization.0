Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 638C921ABD5
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Jun 2025 14:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749565098; cv=none; b=nc6o4w75jTuxjd34EOn7Z441/ka1JVytONATX9RfZWfFypcBWNYfaGNIJL+YORpMG496D5kjyeu0DZFgedOH6WEQNf6vt4N2T+F/Pf+SPTp1HiefEbWA9aD5mMsJrEb+iu9VTDmciHjGYDOsEJN1PzPrBbjnjUvRWRBij5r32+0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749565098; c=relaxed/simple;
	bh=jVgRDHdKzEsdiZHSyNutF/aYwtWhtxXmhHnMZHxaDNE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=JeZsIRWi9zUAa8euBP+ayT/mNwmRbbkBr0CIcBaNujCce8rCPZtvP8422py7cJO0hv5heWCFlnNY1udAigTZRAR21a9mYi4XKwGhl77pNbcJMwNDDQ3I9Bhm7YyFMUdnLw5LhtvbcanQmkJvzDEuSpGK52mmHoxNMR2QfMsCW6Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=c/KrS3bo; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="c/KrS3bo"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id F359B40620
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Jun 2025 14:18:15 +0000 (UTC)
X-Virus-Scanned: amavis at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -5.79
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
 by localhost (smtp2.osuosl.org [127.0.0.1]) (amavis, port 10024) with ESMTP
 id 660KvC-asv5M for <virtualization@lists.linux-foundation.org>;
 Tue, 10 Jun 2025 14:18:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=sgarzare@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 520C340053
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 520C340053
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=c/KrS3bo
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 520C340053
	for <virtualization@lists.linux-foundation.org>; Tue, 10 Jun 2025 14:18:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1749565093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=YWdGsTP9UdVNfFRFI1m3+P+PKI5R7Dmno5tLlKSkopc=;
	b=c/KrS3bo+CFsmd8lDBaLr4sCWiPmcOjOVq2H1o8z8pGNwdM8ybSTDSb9/DDyZj64ugQhkv
	dYBIaIkmBiQmJhuAjKB+f5Lu8cjvNAbAc4WA9H+LWy/VKNoIu5Aeph2NgGijrYh8p/rRvj
	/eKI76o9Ip2IO7tnOkzaFisDdD6ogP8=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-119-mO1JUDohOjWMuQFn5msLig-1; Tue, 10 Jun 2025 10:18:10 -0400
X-MC-Unique: mO1JUDohOjWMuQFn5msLig-1
X-Mimecast-MFC-AGG-ID: mO1JUDohOjWMuQFn5msLig_1749565089
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-606b62ce2d4so4736503a12.3
        for <virtualization@lists.linux-foundation.org>; Tue, 10 Jun 2025 07:18:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749565088; x=1750169888;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YWdGsTP9UdVNfFRFI1m3+P+PKI5R7Dmno5tLlKSkopc=;
        b=nvRQgi9I0rt10Cu01G/p6AP8HFkOkJBoZKSgcp2b4NmImSGU6oRbm64fgamN9kQm+L
         R6etKwB3ceX4avpMooiBt3bSSsWoP7xywT9EfG4XgNKe5M2kR25+BlEMvmqNqbOqP2nk
         8FmNj1CnNYUwgy5Cuzk0ONOUfObzYo62Bme3AMPBlyWJvtAlmVm8Bs3mhnyCASrhO35m
         1RGGiGssI4Ln4eyLyq+i+5gCi9ViSPx+1CiB1fjVDr2KYTZKg91UNx3vsJ5Da8ZRMrm7
         jjHanBBejW1TYwTb9u59ZVv8QKcaIWWl2rikYskyvdeq5ymJj6MMRvrLrCdad3zz67Ax
         KsVQ==
X-Forwarded-Encrypted: i=1; AJvYcCUnstKF8lxibF0EG+njm+2NtfUuXi/1TVngJTvoUkrg00NrineTgkyNU123jj65mksARfUUyJpteHEs8ViytA==@lists.linux-foundation.org
X-Gm-Message-State: AOJu0YzlW5+GKwWc/2THAU+oaV/Ng/YNLYJLyt4GJGTPXd5DE/9bvagD
	cLGlV1x9RH7xvDaPQ0f9Sak31+U8Lz/qrRtwNHuVnKxuvREI7xDGH16JstU4RF88ZhVe6zNIkx6
	aY7TAx3Idx4qXORIYKqu4ZMlzm3qKlYaozFT31e3HA+r2tEblbjrlq4l08m9hTuFf6qwPHSd5/Q
	BQrXU57oQ=
X-Gm-Gg: ASbGncuLUrU9CPoBgPPXdgEgxfEInpWMkItGUqWEVk/gUQJHJ750CJNtEmTk1usPRPm
	B0X9iUzL3NmadYsvqSXwUhg+/u+ZR3NIXzi9zfsjfeWJuLE4e+b8+pQis1Ff+X5723f0dZ8oo8+
	02obKg5b+SLNR57/TWzFoSsIy2v9TgHabKnJdKmEhvxMR3BxON3jrNW6mNkcKkpLc53stkHuMjc
	wwK3p/sNGOb6bMTlv93S2ouXgl3oiY38TMZK85U4isQAUjmEvhTN5eUeuxhUfovWXTUS5DDf7qF
	W+qaaZwUMemmHdSdteiACURW/OkN
X-Received: by 2002:a05:6402:2710:b0:602:29e0:5e2f with SMTP id 4fb4d7f45d1cf-60773ec89c5mr16387604a12.10.1749565088416;
        Tue, 10 Jun 2025 07:18:08 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IG6nFffzk4/Z4yX45yLgRLcy81iUKREpGhoM8zZ6oemdeWy7AymyJ/wnCe7rlJJKGZLyAFjxQ==
X-Received: by 2002:a05:6402:2710:b0:602:29e0:5e2f with SMTP id 4fb4d7f45d1cf-60773ec89c5mr16387568a12.10.1749565087853;
        Tue, 10 Jun 2025 07:18:07 -0700 (PDT)
Received: from sgarzare-redhat ([193.207.220.112])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-607f3dbc3b9sm2760118a12.33.2025.06.10.07.18.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jun 2025 07:18:06 -0700 (PDT)
Date: Tue, 10 Jun 2025 16:18:01 +0200
From: Stefano Garzarella <sgarzare@redhat.com>
To: Mike Christie <michael.christie@oracle.com>
Cc: stefanha@redhat.com, jasowang@redhat.com, mst@redhat.com, 
	virtualization@lists.linux-foundation.org
Subject: Re: [PATCH] vhost-scsi: Fix log flooding with target does not exist
 errors
Message-ID: <7hsh4exxtfbeu2h4zvt2bptunezs5ppaeqep6gkn7xkmpu4y7k@rb5wfwqaembu>
References: <20250607171815.111030-1-michael.christie@oracle.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20250607171815.111030-1-michael.christie@oracle.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: uyQyy8Emkac4ohCqc_yJP2st7hF2p_PbaMqZSdfJc_8_1749565089
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Disposition: inline

On Sat, Jun 07, 2025 at 12:18:15PM -0500, Mike Christie wrote:
>As part of the normal initiator side scanning the guest's scsi layer
>will loop over all possible targets and send an inquiry. Since the
>max number of targets for virtio-scsi is 256, this results in 255
>error messages about targets not existing. When there's more than 1
>vhost-scsi device, then you get N * 255 log messages.
>
>It looks like the log message was added by accident in:
>
>commit 09d7583294aa ("vhost/scsi: Use common handling code in request
>queue handler")

IIUC that commit just moved the code, but it looks like it was added by
commit 3f8ca2e115e5 ("vhost/scsi: Extract common handling code from
control queue handler")

The rest LGTM!

Thanks,
Stefano

>
>The patch was just making some coce common but added the vq_err call
>and I'm guessing the patch author forgot to enable the vq_err call
>(vq_err is implemented by pr_debug which defaults to off). So this
>patch removes the call since it's expected to hit this path during
>device discovery.
>
>Fixes: 09d7583294aa ("vhost/scsi: Use common handling code in request queue handler")
>Signed-off-by: Mike Christie <michael.christie@oracle.com>
>---
> drivers/vhost/scsi.c | 4 +---
> 1 file changed, 1 insertion(+), 3 deletions(-)
>
>diff --git a/drivers/vhost/scsi.c b/drivers/vhost/scsi.c
>index c12a0d4e6386..c9f418a4571a 100644
>--- a/drivers/vhost/scsi.c
>+++ b/drivers/vhost/scsi.c
>@@ -1226,10 +1226,8 @@ vhost_scsi_get_req(struct vhost_virtqueue *vq, struct vhost_scsi_ctx *vc,
> 			/* validated at handler entry */
> 			vs_tpg = vhost_vq_get_backend(vq);
> 			tpg = READ_ONCE(vs_tpg[*vc->target]);
>-			if (unlikely(!tpg)) {
>-				vq_err(vq, "Target 0x%x does not exist\n", *vc->target);
>+			if (unlikely(!tpg))
> 				goto out;
>-			}
> 		}
>
> 		if (tpgp)
>-- 
>2.43.0
>

