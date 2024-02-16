Received: from smtp1.osuosl.org (smtp1.osuosl.org [140.211.166.138])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 126A377636
	for <virtualization@lists.linux-foundation.org>; Fri, 16 Feb 2024 11:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.138
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708082881; cv=none; b=UokqWX/LDb4YBGFHNmFVCCe56fKu22cLZnhqE9X0Q/yIhvt+XRIqUcb1Aa+kVyU+sLcHkDd4z+G9n+7kyMX+TBY7xZ+8Wi9JHFHJ7RQexkehvgSv5INr8MQXDaDekLc7Lc1EFj/cSj0fN+hzj3TS00hGHa+OSUd6Gi7mUwmXFeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708082881; c=relaxed/simple;
	bh=6gMcMyPwgLgEbY6ZF1f8Be8kn6MRW7NRH/o8brCnnoE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=M3pp3G6v/IBkl5sEEH1bzIp9BApBUIQNbq78ssR+42Xz9OkTnNI/DHt4e+EuyEU+3M8hjh8qK1Fl3apwqi6InuAf9mC4IXYHR0mIghQdS9HZqsyr5Os1aFKLQl01ffrYDyEdxk0C2VuqwkWBhzbkw5Iwo1TkhVFpFbwYLWEGQgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hKrLIVCo; arc=none smtp.client-ip=140.211.166.138
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hKrLIVCo"
Received: from localhost (localhost [127.0.0.1])
	by smtp1.osuosl.org (Postfix) with ESMTP id 90E2981ECC
	for <virtualization@lists.linux-foundation.org>; Fri, 16 Feb 2024 11:27:59 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.102
X-Spam-Level:
Received: from smtp1.osuosl.org ([127.0.0.1])
	by localhost (smtp1.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id o6MJHAux-gdQ
	for <virtualization@lists.linux-foundation.org>;
	Fri, 16 Feb 2024 11:27:59 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp1.osuosl.org A82E881E61
Authentication-Results: smtp1.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp1.osuosl.org A82E881E61
Authentication-Results: smtp1.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=hKrLIVCo
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp1.osuosl.org (Postfix) with ESMTPS id A82E881E61
	for <virtualization@lists.linux-foundation.org>; Fri, 16 Feb 2024 11:27:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1708082877;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=ldTgol2RjHwGuL7/gP1WBAM77N/i279/pdvnyHeoM1E=;
	b=hKrLIVCog33dc3nDWXhKvVjcpRslB2nD0O3seNgoMNVtjoonte0mjMBLb2pqTlpeR8n3UD
	EfnvKMZO3W7bfnuR6U6qXCiLEgzzSCGJ8p85xyV43zz9VcK08vikOqoLil9WXXqeSXX+6V
	QZ+ZEDG00UPe2lkRtePoEGJxaIYi8lk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-577-ucPkmBg0PAKhqENsY97Muw-1; Fri, 16 Feb 2024 06:27:53 -0500
X-MC-Unique: ucPkmBg0PAKhqENsY97Muw-1
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-33d0047bd95so728031f8f.1
        for <virtualization@lists.linux-foundation.org>; Fri, 16 Feb 2024 03:27:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708082873; x=1708687673;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ldTgol2RjHwGuL7/gP1WBAM77N/i279/pdvnyHeoM1E=;
        b=OtOU+InQ5561pZNhHwEACx0ho1whU7DbaLWCukYEDLg0m4hkOBXIuiGH61/4fMbMBN
         y5xs+SgoiWlvkOWpP1z19sDhcSZ8+4K3lXPyeQi7GZ8X/tiAS6DslMnFMP30AHH80G6o
         6VfMvZkXyqC9nOyVwxU+921iJsd3kp95X4eI4vtxhQmMB013Tct4v/XFaepwkXuHgnx5
         4SIpPJ76qNbuk7hsYl/rMv1zc3FeEmIJyS7mCQKwL1KPZBPM95JySKw1mBrW1cnj38wp
         vfZB+xihM/+lI1g0TPm1Eyy31k9qh/gKdmSxzeHEtKMX5hh1QUxzscb19Xoc9ui5BbbI
         gWXA==
X-Forwarded-Encrypted: i=1; AJvYcCXX5kj82mHDTt137Whozn91E4M455B8eggFFUqFx9GvjoJ5mUwBLdFKmWDGD1zG7l+CnYWXfdn3s8+jfFitbaNgt5qf2ip/FRGB2MQOdi4O4JUPya9r9Iatyw==
X-Gm-Message-State: AOJu0YxEpD25k6tPz705oHSr+gPownBdxKrXgZ14HtvaLzC+tVzN3Swr
	TcEkImcFyeeCRjpLukmr/q6HLgcG+ShBr/ut6cH4GL8q1Cyw8NNaD0+iBzYxNgnu/TG7BoDoMHe
	rPWPFD1Aevi+UYuria5sC5w/Xl7Z/ju4UTwTPEuOq8+Ot/O+f8tK0Dlc+5z1XmyHeTgju8Adk/J
	w6Mdo=
X-Received: by 2002:adf:db4a:0:b0:33b:179d:d9aa with SMTP id f10-20020adfdb4a000000b0033b179dd9aamr3738285wrj.26.1708082872833;
        Fri, 16 Feb 2024 03:27:52 -0800 (PST)
X-Google-Smtp-Source: AGHT+IHgaY3PtAN8z8RgLWyK9s4sch0JhbTy5FoXAS+RRg2r8qkUw3EqgzlI0lsRkHqGluoJTNtjKA==
X-Received: by 2002:adf:db4a:0:b0:33b:179d:d9aa with SMTP id f10-20020adfdb4a000000b0033b179dd9aamr3738275wrj.26.1708082872447;
        Fri, 16 Feb 2024 03:27:52 -0800 (PST)
Received: from redhat.com ([2a02:14f:178:2d32:e5b8:d152:6384:cef9])
        by smtp.gmail.com with ESMTPSA id u4-20020adfcb04000000b0033d24eab9c3sm189079wrh.76.2024.02.16.03.27.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Feb 2024 03:27:51 -0800 (PST)
Date: Fri, 16 Feb 2024 06:27:48 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
Cc: jasowang@redhat.com, perex@perex.cz, tiwai@suse.com,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	virtualization@lists.linux-foundation.org,
	virtio-dev@lists.oasis-open.org,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	coverity-bot <keescook+coverity-bot@chromium.org>
Subject: Re: [v4 PATCH] ALSA: virtio: Fix "Coverity: virtsnd_kctl_tlv_op():
 Uninitialized variables" warning.
Message-ID: <20240216062630-mutt-send-email-mst@kernel.org>
References: <20240216100643.688590-1-aiswarya.cyriac@opensynergy.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240216100643.688590-1-aiswarya.cyriac@opensynergy.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Feb 16, 2024 at 11:06:43AM +0100, Aiswarya Cyriac wrote:
> This commit fixes the following warning when building virtio_snd driver.
> 
> "
> *** CID 1583619:  Uninitialized variables  (UNINIT)
> sound/virtio/virtio_kctl.c:294 in virtsnd_kctl_tlv_op()
> 288
> 289     		break;
> 290     	}
> 291
> 292     	kfree(tlv);
> 293
> vvv     CID 1583619:  Uninitialized variables  (UNINIT)
> vvv     Using uninitialized value "rc".
> 294     	return rc;
> 295     }
> 296
> 297     /**
> 298      * virtsnd_kctl_get_enum_items() - Query items for the ENUMERATED element type.
> 299      * @snd: VirtIO sound device.
> "
> 
> This warning is caused by the absence of the "default" branch in the
> switch-block, and is a false positive because the kernel calls
> virtsnd_kctl_tlv_op() only with values for op_flag processed in
> this block.
> 
> Also, this commit unifies the cleanup path for all possible control
> paths in the callback function.
> 
> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> Signed-off-by: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1583619 ("Uninitialized variables")
> Fixes: d6568e3de42d ("ALSA: virtio: add support for audio controls")



> ---
>  sound/virtio/virtio_kctl.c | 19 +++++++++++++++----
>  1 file changed, 15 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
> index 0c6ac74aca1e..7aa79c05b464 100644
> --- a/sound/virtio/virtio_kctl.c
> +++ b/sound/virtio/virtio_kctl.c
> @@ -253,8 +253,8 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
>  
>  	tlv = kzalloc(size, GFP_KERNEL);
>  	if (!tlv) {
> -		virtsnd_ctl_msg_unref(msg);
> -		return -ENOMEM;
> +		rc = -ENOMEM;
> +		goto on_msg_unref;
>  	}
>  
>  	sg_init_one(&sg, tlv, size);
> @@ -281,14 +281,25 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
>  			hdr->hdr.code =
>  				cpu_to_le32(VIRTIO_SND_R_CTL_TLV_COMMAND);
>  
> -		if (copy_from_user(tlv, utlv, size))
> +		if (copy_from_user(tlv, utlv, size)) {
>  			rc = -EFAULT;
> -		else
> +			goto on_msg_unref;
> +		} else {
>  			rc = virtsnd_ctl_msg_send(snd, msg, &sg, NULL, false);
> +		}
>  
>  		break;
> +	default:
> +		rc = -EINVAL;
> +		/* We never get here - we listed all values for op_flag */
> +		WARN_ON(1);
> +		goto on_msg_unref;
>  	}
> +	kfree(tlv);
> +	return rc;
>  
> +on_msg_unref:
> +	virtsnd_ctl_msg_unref(msg);
>  	kfree(tlv);
>  
>  	return rc;

I don't really like adding code for a false-positive but ALSA
maintainers seem to like this. If yes, this seems like as good
a way as any to do it.

Acked-by: Michael S. Tsirkin <mst@redhat.com>


> -- 
> 2.43.2

