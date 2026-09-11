Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8024F3148CF
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 22:51:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789167115; cv=none; b=VuRNNO/vGP5PRMkbYJHUrBXL4PR1bZerpEybG6x/91jpJQ1ZhdYxJckAiR5wiGK8MF8TxKF/3BhIsrhjRwpDneppxRVBn+bWQEUSOXfGXWOePwZsMdVWfFvg+35brBhqJi0A1vP5YEDSD4qgRayT5t1OU5mvHPr5s7/rNJ8a7L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789167115; c=relaxed/simple;
	bh=GfVdI+6U5Ub5l41aZwdFVfxugZPb6OlXikwNEihQr3M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=uSYXL61TOyEGcRGQGU+5kQ9bspXD+qMMOOhZcsty0wCdHQUi4eR5k148m4ldtZ61QxwKefl7C6puBT9nMWXd0HsHz/W48G+3dxPfRVljhH/dJE1TWko56I8F5jwbmW8Pk6fqeqkSbts8gUm6b5IdT/Lb6BNzM4SE/Cl43dOmjr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=R9s3rzwp; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="R9s3rzwp"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1789167113;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=jQ6AshrF5wH31i2uOHPrbuYMla+mjtSA/+BYLCsl1e0=;
	b=R9s3rzwpjE9wopZ2Jmwjp08MGdLYJ1f9IaQwz/o1VMEVHrbNGD7ovd+ISxF5t4mNHPfGIX
	HMqdJBu0uII9iC6gDv335Ix9gjLXLeczztbcCil7aI0/nLDK+8KfWOjeYtCC3xC2bP1Iw/
	xQRcDRuraav23Suq5LiP0lFXOlPDLGY=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-ftVEyNb3OSGPWoGLXbbCxA-1; Fri, 11 Sep 2026 18:51:52 -0400
X-MC-Unique: ftVEyNb3OSGPWoGLXbbCxA-1
X-Mimecast-MFC-AGG-ID: ftVEyNb3OSGPWoGLXbbCxA_1789167111
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-486f768517dso32108f8f.1
        for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 15:51:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789167111; x=1789771911;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=jQ6AshrF5wH31i2uOHPrbuYMla+mjtSA/+BYLCsl1e0=;
        b=EcnMN2UEpK4dkOC6Q6YmbQr8uHLoutH/pezuAYP7ngqsDNLAuXs7PT/D9bgDX2HGY0
         wsIEUjmHsOGBgPJCB0AGEj/wR9jqGBrj9BHc2WjU2CGj8M6Ewc/pOmSCuAwQMKgdgPQB
         T0ComuPEkFA5YEFjrFftayAuvHKTCWVu9oRIsCi+XTfupaEdwNe3lRf8hQnGiH+Fz03C
         bJIdERZhpR0Mq7fMnhUJt3u9i4g7ROer5OJKLS/UFcc+iruls82Er88YFxvNSYyPQnwQ
         4Ke4HBorRJLdsuNxZYZ0FEmYm68njl2zqXISvuNz08Tb8CGQ3Xh1CYGxSVgFHarbQNyJ
         pBqQ==
X-Gm-Message-State: AFuF++lUtk5LjdorFJRSsBDEo1QAe1GvRv/FB6WGTMZ3w7krBTdAea24
	idRBlvyefDpTLKmnAE+YszTk2qg8v5/M1P/qHRTBV7p/UY29EnDKN2GpE9BCiDtGStbABA4wnT9
	pKEh9s0iGSG1rakLFXt97Tqk0kyxvkqUEkNrilDFFO/756DTKj4cq3GH2oSwWynfe1cHl
X-Gm-Gg: AYBFou0IpgrzB5OOkJdsBtEGTiY+nV3aBQ2eiFTnNTj9mFYBDHWMRsjL33YiGUbnqWl
	sTFzaitzXToBce+S2nk3yxiEAvuwVSmN+N8QUtMGzDXjqQXKFq3Vr9DG/2Ah+cNppKMV5JGYFZB
	3at2V2Z9BKK0dcF/U1Jpw9wCpG0kR1p2tEI58Px4EgmkdRSzwCUsvlrtMUlhJLP2zkSb+Q9E36n
	pyfZIhgBKjhc33baH6e2a/oTCebtZkpGk1E3gZAr28ux/DH5d1DR3S0pnsIzadxL4xRcaMk0odq
	KFzhlMtecOG+uzK1HX3SAgeYcjtbOAoz2qVbq2jc81JQ+rRHQN2FYQB/vQz0GXwh/cc=
X-Received: by 2002:a05:6000:5c6:b0:486:f4ba:ce0a with SMTP id ffacd0b85a97d-486f4bace38mr5083501f8f.9.1789167111057;
        Fri, 11 Sep 2026 15:51:51 -0700 (PDT)
X-Received: by 2002:a05:6000:5c6:b0:486:f4ba:ce0a with SMTP id ffacd0b85a97d-486f4bace38mr5083460f8f.9.1789167110617;
        Fri, 11 Sep 2026 15:51:50 -0700 (PDT)
Received: from redhat.com ([147.235.223.59])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-486f301121asm4513415f8f.0.2026.09.11.15.51.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:51:50 -0700 (PDT)
Date: Fri, 11 Sep 2026 18:51:47 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Karl Mehltretter <kmehltretter@gmail.com>
Cc: virtualization@lists.linux.dev, jasowangio@gmail.com,
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, jiri@resnulli.us,
	sashiko-bot@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 3/3] virtio_pci_modern: move avq cleanup from reset to
 del_vqs
Message-ID: <20260911185059-mutt-send-email-mst@kernel.org>
References: <cover.1789160982.git.mst@redhat.com>
 <d0b3de807c800befe9adce1cefb2d064d9fe0bec.1789160982.git.mst@redhat.com>
 <aqSDrWpFy84CxCoP@gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <aqSDrWpFy84CxCoP@gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: C93-gR9skyPggC66rW5Erdx5zBi1rLPrSt1HfNuAvjU_1789167111
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Sep 12, 2026 at 12:48:54AM +0200, Karl Mehltretter wrote:
> On Fri, Sep 11, 2026 at 05:20:15PM +0100, Michael S. Tsirkin wrote:
> > New in v3. v2 dropped sync from modern vp_reset in one combined
> > patch, leaving avq_cleanup in vp_reset. v3 moves avq_cleanup out
> > of vp_reset entirely into vp_del_vqs, fixing the race. Adds NULL
> > check for admin_vq.info for find_vqs error paths.
> > 
> 
> I think patch 3 introduces a use-after-free in the MSI-X setup error
> path.
> 
> With VP_VQ_VECTOR_POLICY_EACH, vp_setup_vq() stores the admin queue's
> info pointer before request_irq(). If request_irq() fails, vp_del_vq()
> frees info but leaves admin_vq.info set.
> 
> vp_find_vqs_msix() then calls vp_del_vqs(). vp_del_vqs() now calls
> vp_modern_avq_cleanup() first and dereferences the freed pointer:
> 
>     vq = vp_dev->admin_vq.info->vq;
> 
> No interrupt needs to fire.
> 
> I reproduced this on v3 with KASAN by returning -ENOMEM only for the
> admin queue's request_irq():
> 
>     BUG: KASAN: slab-use-after-free in vp_modern_avq_cleanup+0xf4/0x110
> 
> KASAN shows the allocation in vp_setup_vq(), the free in
> vp_find_one_vq_msix(), and the access in vp_modern_avq_cleanup(). Adding
> *p_info = NULL after vp_del_vq() made the same test fall back and boot
> without a KASAN report.
> 
> Thanks,
> Karl

Right. Besides, poking at modern from common is ugly. I'll rework this,
thanks a lot for the testing!

-- 
MST

