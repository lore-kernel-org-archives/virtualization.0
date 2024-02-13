Received: from smtp4.osuosl.org (smtp4.osuosl.org [140.211.166.137])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BDBC1BDC2
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 09:06:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=140.211.166.137
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707815177; cv=none; b=ecdH7MPeidpw3fJF1I8R6X4exPg++CLDOVj/ekK+REponiddJ/+7XFmfdSvPLnxy3DxUWTO+13w3b+gLIm4369qZUOiF7QPiD/zsexKOQ+d5F450orwuB/AfpoZTCEl5m6wngCJm9alv/OsFKvP8yZ7feA+dnNIRclJbqkUGYEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707815177; c=relaxed/simple;
	bh=fbN4ZqMqELs7B2vKodqWXUHobDmfjtCgV62hSufnm9s=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=OFV3IQKNb/0BSQvR0vPWOXuGvyHszhXPvZQ3bjkD1qxcd4JZGqV8mbl4rAzdk3+qdeldgmxJmbQ6b3zvmA6nX1ulbiZhAgyStomwBdBYAB2tuIs81CE/pB2GTnHH69ARYQu78IO4wjXuSrjvKjP5GvOMDk48T0p0JdVEjS3KcdM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=a9wqLetE; arc=none smtp.client-ip=140.211.166.137
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="a9wqLetE"
Received: from localhost (localhost [127.0.0.1])
	by smtp4.osuosl.org (Postfix) with ESMTP id 014E5406A6
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 09:06:16 +0000 (UTC)
X-Virus-Scanned: amavisd-new at osuosl.org
X-Spam-Flag: NO
X-Spam-Score: -2.099
X-Spam-Level:
Received: from smtp4.osuosl.org ([127.0.0.1])
	by localhost (smtp4.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id uwBTW_oao6T1
	for <virtualization@lists.linux-foundation.org>;
	Tue, 13 Feb 2024 09:06:15 +0000 (UTC)
Received-SPF: Pass (mailfrom) identity=mailfrom; client-ip=170.10.133.124; helo=us-smtp-delivery-124.mimecast.com; envelope-from=mst@redhat.com; receiver=<UNKNOWN> 
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp4.osuosl.org 3BC4440695
Authentication-Results: smtp4.osuosl.org; dmarc=pass (p=none dis=none) header.from=redhat.com
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp4.osuosl.org 3BC4440695
Authentication-Results: smtp4.osuosl.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=a9wqLetE
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	by smtp4.osuosl.org (Postfix) with ESMTPS id 3BC4440695
	for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 09:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1707815174;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FCp+U2tcizd8TQvjWI973O/2/xnroOwuTJofpoENFck=;
	b=a9wqLetEp8gh4X9rBC5fIgRH8kFdikA9Q4QpatGYxx/oAKBLIHI8n/8xnCeBdrukRIDOcU
	CUYh/6Rh1M38giMWdg4wYMZvecxBgAnK0Ob0K+h2k5dzDlLpsky0iDmQnOA1MvzRJPTZoQ
	IKkELMFU5Yi6T+WvuyVrcO+hDRwdKVY=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-urtEb-mfOj6LFn816DKr2g-1; Tue, 13 Feb 2024 04:06:13 -0500
X-MC-Unique: urtEb-mfOj6LFn816DKr2g-1
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-5620a2d150fso34473a12.2
        for <virtualization@lists.linux-foundation.org>; Tue, 13 Feb 2024 01:06:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707815172; x=1708419972;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FCp+U2tcizd8TQvjWI973O/2/xnroOwuTJofpoENFck=;
        b=vLW8jj2X+LcBJ73YfCOTdYEk9Zk7aDpvh0xfamyXzCL8Q/bx8OuLYQ04bQP3w9MnQt
         6rWZdgC80w8MaHj8UmrX8XsV7A3kKQ9gKVOLe/4GEWw7yMjYT2GxeszaxQ5f6anVRPsB
         TWzmB2WOVWiXfOlR+mJ+nL2R+yOIdRoQI/yY0hHwXgJR69XKKYjzKeS6v1OoA5GRMCHc
         FxLorQ/AeBdpCtq8T1Zf8bgI9vLYf9oympJStBhT4ZnLANRsX0FkeNlhgveWHK1QgZZk
         W7PcE2Xto4BDCoOLYa7Eu5lM2q7JTCIB4Nb6LQnQycBU6o1mbzSDDTvUglwRdBs7LRt1
         wlMw==
X-Forwarded-Encrypted: i=1; AJvYcCWunMllZHY8lEeHXF0JJqpEgvoFhXeHZGvnPJmVzGoENcEEafqwLb6Vw1BDLg+CPW1dbZo0qeedKZdf3YLPn54MglUC8X3fD8K+ALkqjszDnAMSGyFa4oXsCA==
X-Gm-Message-State: AOJu0YzttjZdB+4eISuxyrvV4/qQSin/Tk33ay8MABkQI12epoMdNxnR
	sKeI9sNd1H4TVt6CIXQhfI3jPKlCkSUpVOotrH619jvKDv0EwGbtc0XI9IBp0IGHJs1BCPviHal
	b8XpCeTOq9nDiDUTW6wT2HpXrudvaiDY5Rxwtg+Flx89A0LLIvRKntMjkdRuAS9j/wuJ7qXD+JU
	onHZw=
X-Received: by 2002:a05:6402:22ec:b0:561:f77b:c0b0 with SMTP id dn12-20020a05640222ec00b00561f77bc0b0mr622575edb.39.1707815171943;
        Tue, 13 Feb 2024 01:06:11 -0800 (PST)
X-Google-Smtp-Source: AGHT+IH1WxLIbkc9509MADVuZj12YdZkQRBE5ZevDuhFcjxgdr1fVp4moBUIGKQf1C7kGw0aY3jCDA==
X-Received: by 2002:a05:6402:22ec:b0:561:f77b:c0b0 with SMTP id dn12-20020a05640222ec00b00561f77bc0b0mr622553edb.39.1707815171594;
        Tue, 13 Feb 2024 01:06:11 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWsT77fnhrOLUZtwRFl10XYMgZvpCowT2ftQ62g+EnJpk2swblqtcfEL6k9x+GqRZCAjwwyLRx7YRIXccqc4d9awtdWl3QMp0jpWut2UdWzxp+RMY813l3jOGxex+j+KSI+IBR4UL2N1MM9barmOwALJI3DV2VJzQdhXEZcmoqETaKg7DdzxZDzWLJcKNwkHjC2K3Rk1L0kA9mQBrkKjAOQb2BlPWN7/67oXqABJW6pUlMcRZbpCwjkay3Jl7+MLJSrn65kRoPxuttBje9z2eEl6TIhmpsWavi932jiB07eRMUe79h16bcZvxNrKwYn0JanD4ZmadQ2cNm2V0GKs5dl2R1tG5Hm7Sr2ZGJIFkLcuVtwxdUPjt5UUQ==
Received: from redhat.com ([2.52.146.238])
        by smtp.gmail.com with ESMTPSA id er13-20020a056402448d00b005607825b11bsm3509207edb.12.2024.02.13.01.06.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Feb 2024 01:06:10 -0800 (PST)
Date: Tue, 13 Feb 2024 04:06:05 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
Cc: jasowang@redhat.com, perex@perex.cz, tiwai@suse.com,
	linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
	virtualization@lists.linux-foundation.org,
	virtio-dev@lists.oasis-open.org,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	coverity-bot <keescook+coverity-bot@chromium.org>
Subject: Re: [PATCH] ALSA: virtio: Fix "Coverity: virtsnd_kctl_tlv_op():
 Uninitialized variables" warning.
Message-ID: <20240213035806-mutt-send-email-mst@kernel.org>
References: <20240213085131.503569-1-aiswarya.cyriac@opensynergy.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20240213085131.503569-1-aiswarya.cyriac@opensynergy.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

On Tue, Feb 13, 2024 at 09:51:30AM +0100, Aiswarya Cyriac wrote:
> Fix the following warning when building virtio_snd driver.
> 
> "
> *** CID 1583619:  Uninitialized variables  (UNINIT)
> sound/virtio/virtio_kctl.c:294 in virtsnd_kctl_tlv_op()
> 288
> 289         break;
> 290       }
> 291
> 292       kfree(tlv);
> 293
> vvv     CID 1583619:  Uninitialized variables  (UNINIT)
> vvv     Using uninitialized value "rc".
> 294       return rc;
> 295     }
> 296
> 297     /**
> 298      * virtsnd_kctl_get_enum_items() - Query items for the ENUMERATED element type.
> 299      * @snd: VirtIO sound device.
> "
> 
> Signed-off-by: Anton Yakovlev <anton.yakovlev@opensynergy.com>
> Signed-off-by: Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>
> Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
> Addresses-Coverity-ID: 1583619 ("Uninitialized variables")
> Fixes: d6568e3de42d ("ALSA: virtio: add support for audio controls")

I don't know enough about ALSA to say whether the patch is correct.  But
the commit log needs work: please, do not "fix warnings" - analyse the
code and explain whether there is a real issue and if yes what is it
and how it can trigger. Is an invalid op_flag ever passed?
If it's just a coverity false positive it might be ok to
work around that but document this.


> ---
>  sound/virtio/virtio_kctl.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/sound/virtio/virtio_kctl.c b/sound/virtio/virtio_kctl.c
> index 0c6ac74aca1e..d7a160c5db03 100644
> --- a/sound/virtio/virtio_kctl.c
> +++ b/sound/virtio/virtio_kctl.c
> @@ -286,6 +286,11 @@ static int virtsnd_kctl_tlv_op(struct snd_kcontrol *kcontrol, int op_flag,
>  		else
>  			rc = virtsnd_ctl_msg_send(snd, msg, &sg, NULL, false);
>  
> +		break;
> +	default:
> +		virtsnd_ctl_msg_unref(msg);
> +		rc = -EINVAL;
> +

There's already virtsnd_ctl_msg_unref call above.
Also don't we need virtsnd_ctl_msg_unref on other error paths
such as EFAULT?
Unify error handling to fix it all then?

>  		break;
>  	}
>  
> -- 
> 2.43.0

