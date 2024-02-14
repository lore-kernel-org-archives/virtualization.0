Received: from smtp2.osuosl.org (smtp2.osuosl.org [140.211.166.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A6655B696
	for <virtualization@lists.linux-foundation.org>; Wed, 14 Feb 2024 15:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.133
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707924974; cv=none; b=AsuKxfFcEnrJF3IhJxG1KMG8z9LhmSZMQ151qgUDXwfMwJCYCbCfx9IUMoe2oq64dsK0i4Kvz5cdF59a2jYl3pX2vKCJPyDv1X2cxJi+tKzsUPYJF2kHCak+zj8kQKR9bcNvQOXJoaWsdA2gdFubNNtCG0TN+3U+DO2xeDZzEAE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707924974; c=relaxed/simple;
	bh=manMnYEz4pn6s1Xo/dIku30u35/Fk2loq3Yh54oRS+g=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=Ez4SkkREBs6s/zH7dgkHvZvwgWKdjs78EJJ0pZUV2xJT77zUb/rdhkK6Eul6mcCrKEGIrMJwzt8P+6XB+wvvF1fFzuHJ2t3H9ymvWOudUYF09TrDkf+6vH5bJJ3SLexND1mD0Ihb7IAdLzTloKiTVdBaEhyDNDMyvSvXjM0Fgvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FtKMKUlM; arc=none smtp.client-ip=140.211.166.133
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FtKMKUlM"
Received: from localhost (localhost [127.0.0.1])
	by smtp2.osuosl.org (Postfix) with ESMTP id C218F40644
	for <virtualization@lists.linux-foundation.org>; Wed, 14 Feb 2024 15:36:12 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.102
X-Spam-Level:
Received: from smtp2.osuosl.org ([127.0.0.1])
	by localhost (smtp2.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id w4Rg0fI8hcM0
	for <virtualization@lists.linux-foundation.org>;
	Wed, 14 Feb 2024 15:36:11 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.129.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp2.osuosl.org 3F38A417E1
Authentication-Results: smtp2.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp2.osuosl.org 3F38A417E1
Authentication-Results: smtp2.osuosl.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FtKMKUlM
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	by smtp2.osuosl.org (Postfix) with ESMTPS id 3F38A417E1
	for <virtualization@lists.linux-foundation.org>; Wed, 14 Feb 2024 15:36:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707924968;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=yk+r5+Jl2RkVcClg72bssLx2pLXyZ58wrDSewZoLn+8=;
	b=FtKMKUlMN+OYSXeFxyIqtxU2NNvjigJIM6+Gikme2mEo2Ajkgctfk/Vwv2DN1/HxK0boJA
	ZsxTrdxK3j53SgFZNBJGVOZEMZ8FVNwz11vjqnxbf5oA4vWbrwPvDmzhDtaW4q8Qy9Lf2w
	Tr9d81XJw0BxWQMOVmOxDMJ47ptn1Oc=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-221-ewB1UHllM8mihLPt-Usn9g-1; Wed, 14 Feb 2024 10:36:07 -0500
X-MC-Unique: ewB1UHllM8mihLPt-Usn9g-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-33cf63e72b7so11272f8f.3
        for <virtualization@lists.linux-foundation.org>; Wed, 14 Feb 2024 07:36:07 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707924966; x=1708529766;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=yk+r5+Jl2RkVcClg72bssLx2pLXyZ58wrDSewZoLn+8=;
        b=bZBaM7rR/gpAzegJNc2b2e1lukp4wg20Hyc3RhjJeZZ4/qNhBkxezt9h3//zrn4AOw
         ldZAUDXmC84gPapqvWtLfx1LsW1n2G9f65lrH8AdhAo065KGcY/lDhNhFyYQ3F7yCtOh
         0uV9RtWlBXidu2UvK2RjgDcA9qRQx0YzBJytneOq119hNZwEf+D57y74Bbor9sLKDIlP
         0ycSyy077JpD9EIh8P2rxgoQNsBIM1hOutbWnMAGRGflKMNWckj+4/UtBMcClsBUElok
         OJqLjkU3F6tJDYHykmZh7GyN/j90Rt99Zewu4YyC+9MwzlsmsfapSwbfFRWDMZ69CTj2
         rRPA==
X-Forwarded-Encrypted: i=1; AJvYcCWqmQsTP+ZKsraCTg/TbUbWso3awisYpqjKKAv7grb1WWWFkI44POQ+n3LI0ixwLn5PLD6Fith55DmR3PyhGGVvt0T7UYKlFFV9BdHfmzbxYpPiBeY6C+4YKw==
X-Gm-Message-State: AOJu0Yw4xq0Z+YuYbNtI9OvgIknZNSlgh+LgBAT4RZtXwUNO6bkxn1OG
	OJ5XqUciXmbovMCg26AfxrA1PwSim90BC+r3zM8dahbWGuYJoCnmjG6w35ki5F0RxJ9MXyHXsBU
	Tllyfr3SO4nlstR086s4LUJ4SYRhHoslbzSNPrRX7cNjXHlFP8dV7jWTjkBADUjZNsEyrNza5qx
	YnY7k=
X-Received: by 2002:adf:f588:0:b0:33c:d8ac:c182 with SMTP id f8-20020adff588000000b0033cd8acc182mr2030155wro.41.1707924966168;
        Wed, 14 Feb 2024 07:36:06 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGN4rsvb3h0+DO6dhzov4nViL7vH02SlEqXlo+Dh8Cvpkddkjlq+Lr8v5C5Scgn75uJes+DVg==
X-Received: by 2002:adf:f588:0:b0:33c:d8ac:c182 with SMTP id f8-20020adff588000000b0033cd8acc182mr2030138wro.41.1707924965759;
        Wed, 14 Feb 2024 07:36:05 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCVw1n6ntQ1Pnj6sCIZ79pFaffBrcPDQR2hDKsPPQZ9IaU/EWNYc2o+8XL7GMNl3hIEGE+3WhvWomNOtpns6/JE0L9GvLXFqZ06y4TTX2o5b3SzR33+bwq/J3EzYnJenvTfpD1Rq/3fOERcPkQqoveY0/BZeMuHKmpEkWP0NsVzTgGo9VQt8gH7huNpHKP5p3ninOeLsg0bTAoryzv5Wbn5ah+1BJjpfEm90i3vf/XoSU/0hcVaMjfUcoxRyd4HEzhhXjVirHBBthb5gt1V4nMutvxDgH5T+uj2hllvq2MTuG3YKawnJhDx/5Wi6hsV/Vl6q/1jZtjLwN+SqRG+outmBHFRXluLJu/muoACgCOJwT3Dlwm9vZM8a7Q==
Received: from redhat.com ([2.52.26.67])
        by smtp.gmail.com with ESMTPSA id bn28-20020a056000061c00b0033cf095b9a2sm1612543wrb.78.2024.02.14.07.36.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Feb 2024 07:36:05 -0800 (PST)
Date: Wed, 14 Feb 2024 10:36:01 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
Cc: jasowang@redhat.com, perex@perex.cz, tiwai@suse.com,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	virtualization@lists.linux-foundation.org,
	virtio-dev@lists.oasis-open.org,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	coverity-bot <keescook+coverity-bot@chromium.org>
Subject: Re: [v3 PATCH] ALSA: virtio: Fix "Coverity: virtsnd_kctl_tlv_op():
 Uninitialized variables" warning.
Message-ID: <20240214102727-mutt-send-email-mst@kernel.org>
References: <20240214140110.606171-1-aiswarya.cyriac@opensynergy.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240214140110.606171-1-aiswarya.cyriac@opensynergy.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Wed, Feb 14, 2024 at 03:01:10PM +0100, Aiswarya Cyriac wrote:
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
>  sound/virtio/virtio_kctl.c | 25 +++++++++++++++++++++----
>  1 file changed, 21 insertions(+), 4 deletions(-)
> 
> diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
> index 0c6ac74aca1e..40606eb381af 100644
> --- a/sound/virtio/virtio_kctl.c
> +++ b/sound/virtio/virtio_kctl.c
> @@ -253,8 +253,8 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
>  
>  	tlv = kzalloc(size, GFP_KERNEL);
>  	if (!tlv) {
> -		virtsnd_ctl_msg_unref(msg);
> -		return -ENOMEM;
> +		rc = -ENOMEM;
> +		goto on_cleanup;
>  	}
>  
>  	sg_init_one(&sg, tlv, size);
> @@ -266,6 +266,11 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
>  	case SNDRV_CTL_TLV_OP_READ:
>  		hdr->hdr.code = cpu_to_le32(VIRTIO_SND_R_CTL_TLV_READ);
>  
> +		/* Since virtsnd_ctl_msg_send() drops the reference, we increase
> +		 * the counter to be consistent with the on_cleanup path.
> +		 */


This is not how multi-line comments should look.


Adding overhead here is just a waste of cycles.
Instead, separate error handling and normal exit paths.
Then you will not need to increase the refcount here.

> +		virtsnd_ctl_msg_ref(msg);
> +
>  		rc = virtsnd_ctl_msg_send(snd, msg, NULL, &sg, false);
>  		if (!rc) {
>  			if (copy_to_user(utlv, tlv, size))
> @@ -281,14 +286,26 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
>  			hdr->hdr.code =
>  				cpu_to_le32(VIRTIO_SND_R_CTL_TLV_COMMAND);
>  
> -		if (copy_from_user(tlv, utlv, size))
> +		if (copy_from_user(tlv, utlv, size)) {
>  			rc = -EFAULT;
> -		else
> +		} else {
> +			/* Same as the comment above */

Same thing.
Besides, this kind of cross referencing breaks immediately when
someone adds a comment in the middle.

> +			virtsnd_ctl_msg_ref(msg);
> +
>  			rc = virtsnd_ctl_msg_send(snd, msg, &sg, NULL, false);
> +		}
> +
> +		break;
> +	default:
> +		rc = -EINVAL;


	/* We never get here - we listed all values for op_flag */

> +		WARN_ON(1);
>  
>  		break;
>  	}
>  
> +on_cleanup:
> +	virtsnd_ctl_msg_unref(msg);
> +
>  	kfree(tlv);
>  
>  	return rc;

on_cleanup is not informative, coding style says:
"Choose label names which say what the goto does or why the goto
exists."

And saving on duplication here by paying elsewhere does not make sense.
So you do this instead:


  	kfree(tlv);
  	return rc;

on_error:
	virtsnd_ctl_msg_unref(msg);
 	kfree(tlv);
 	return rc;


This is very ideomatic.

> -- 
> 2.43.0

