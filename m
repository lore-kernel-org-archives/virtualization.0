Received: from mail-yx1-f52.google.com (mail-yx1-f52.google.com [74.125.224.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E6F2927FB1C
	for <virtualization@lists.linux.dev>; Sun, 30 Nov 2025 18:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764526610; cv=none; b=VJM9kmnbqtm9b/9RGsoFVKQkxyrvHkw4tG3NJPMJlyHNR1O3m0c0IVJ4XniENHjf8en9fSDmpE/B8dD130JxPbMSenZITyXrUfcNHWtLgy5jCaEW/wJOjvILfCApackdCO/EyMZ6O+l4PqEd0FjWWOOcOAZ5F6ThFwZe66zgnus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764526610; c=relaxed/simple;
	bh=KvguCsz4pFutF0DfQ4yn73w4b9PB3j46YC5jFCOIPbI=;
	h=Date:From:To:Message-ID:In-Reply-To:References:Subject:
	 Mime-Version:Content-Type; b=ZV5FTjSma1GFFllob/9p9sLUm10wPXFsBzaH5JLL3/iYFet8TOeOiOzxIgZBhH6jNFLt4VfrOW04fuWxk8p0bSmHKBzHdg3+ebZEPSzAdsS4kCzK/+kggmEJbJPXhrt6bML8J/JRWhFxP0OBWtQIw67vCoMEjWjdOmXJUaT8OEY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FJa3TFfF; arc=none smtp.client-ip=74.125.224.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FJa3TFfF"
Received: by mail-yx1-f52.google.com with SMTP id 956f58d0204a3-640d0895d7cso4299470d50.1
        for <virtualization@lists.linux.dev>; Sun, 30 Nov 2025 10:16:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764526608; x=1765131408; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JyAdI2hiDQd5HiIOsukC026FiEA0dW/JcjYmFaMww+Q=;
        b=FJa3TFfFCRnoEVOhsDDaWqm9Ai1KJnLPl34SDSIckQw5lEuWNxj/6ZCWvD4G2+YT3Y
         M9ovY+qARbPo846rpi3dFQhFcHeXxDH/Dcq+omkYSLNgdcaxxmXNexwDQjkSaN2UO29u
         2PJdep0zhWCg//VkgRbRLXruFDG5BsK1/p/pjk/dEec4XCxaX2nZ+9wdo7qljy17UjiW
         2jWNLyq+RnqmrqwdXHkTb39yQUAnn7uV8mUv+CS6dGK9cKbu/86XyRB4OGysBxk7MFqX
         cdfVL+QRbhCUl06yHgT1O4bFXFj9pXgxE5TimkPjRyDElx8Q+i/hdJpwaV6ntWrYSL8E
         7GQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764526608; x=1765131408;
        h=content-transfer-encoding:mime-version:subject:references
         :in-reply-to:message-id:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=JyAdI2hiDQd5HiIOsukC026FiEA0dW/JcjYmFaMww+Q=;
        b=khiablo5VxwFZXah554umMaA6QbjZ9FZa6j9TUJBQR6iy116D9ZUtWexTdQaPx4Dal
         ZkW7OC2XPCFp9YxNXirNRYMEziFEsf4tKaeW/JsmcfCGnl6muDyew1Ge1qsKB+SRN/Kz
         E3uOJ4ZYr7bIcKPHcp/637iMWW2L9170aZlG+boZBYIZYuBr+g4oJZMLJtTjZQzRXgDI
         34FXyyNXvq8E8xChmYQlZI1HbZwWqy75WxLcaFb0TQwC9maye71zbCGNfhdXnhzXDwkg
         F/eAY0LJaMrtOJysp9E/JopWq48LdtfTiSXjLSNKfudJJ7C+2h85qdyKi1DekXMIeXX/
         svKw==
X-Forwarded-Encrypted: i=1; AJvYcCXMtSBZ3a34NRQebgP1TxvNnvspMLZrPcnd03zp9l0R/WZ4lItmEnWk7y2lps5MOUdBM/93aF1i7iLzGFyeEg==@lists.linux.dev
X-Gm-Message-State: AOJu0YyoSpN21h87NLUitaqsUxsXlZnt5hCAG6877Ojgz0PRFz41MSOX
	vOfxvfn72Y4g+1NtlqsGIQJXg1I51kZ/7SN2AOJKogtusn/WkV39XO+9
X-Gm-Gg: ASbGncuUpLTN6I19MFfxg75fv6SBtIbpY9nK/cFbYZkq0/PIKetWbX3jNr+/vqbQx4B
	ZFc+5wt+AFml4OcbtyZ7pkXWmjRCbvrJ+x4YKdS6yGKOBxPoJm/SP2lQHe+qavaKIWo0fJx/3WA
	7jKNpFuzfX+wEX4ZB8d9Nr5Qx81toVUZCvhEJO1ehG3UCZAwC0OBwjzoPTrtLQxxAypRwg6K7cW
	R7j1JjQOm/Itb74X9y2ZatbIZp8CAwzOLiV+r05JslSd4JGK2KVFi9fGlMK9NIP69P/18Pp7gnV
	Ai3EKQncWDV4AVrcZ/kL+Erh335lWeKbyvo9eOdR1qAOHoc7RNm+rkN5PX2cRBoYotDp2mLirtO
	as7cHpoagVyBQGfIgQCsk3ulqC9Th7rSGlvKZElJ599XScxJ0aqefvPC2jK5APRHWMWFLOkbGYJ
	e/YMkPJ2ImqQedBqCBEpGEqlZu8LfWVJsPuaSzSROs6Ocos+cZLxpEFvX+pBFJblItvoo=
X-Google-Smtp-Source: AGHT+IGjUNSaNMlSY1qlNbQudRZSgfRbmbbf/B0rphetUkGqwnK/CkPwKVh/ASYpHjSaXoMyaE9Zng==
X-Received: by 2002:a05:690e:1489:b0:63f:b1fd:3850 with SMTP id 956f58d0204a3-64302631797mr26472073d50.33.1764526607842;
        Sun, 30 Nov 2025 10:16:47 -0800 (PST)
Received: from gmail.com (116.235.236.35.bc.googleusercontent.com. [35.236.235.116])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-78ad1045723sm39215937b3.55.2025.11.30.10.16.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 30 Nov 2025 10:16:47 -0800 (PST)
Date: Sun, 30 Nov 2025 13:16:46 -0500
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: Simon Schippers <simon.schippers@tu-dortmund.de>, 
 willemdebruijn.kernel@gmail.com, 
 jasowang@redhat.com, 
 andrew+netdev@lunn.ch, 
 davem@davemloft.net, 
 edumazet@google.com, 
 kuba@kernel.org, 
 pabeni@redhat.com, 
 mst@redhat.com, 
 eperezma@redhat.com, 
 jon@nutanix.com, 
 tim.gebauer@tu-dortmund.de, 
 simon.schippers@tu-dortmund.de, 
 netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, 
 kvm@vger.kernel.org, 
 virtualization@lists.linux.dev
Message-ID: <willemdebruijn.kernel.2ef79a77ca3ec@gmail.com>
In-Reply-To: <20251120152914.1127975-3-simon.schippers@tu-dortmund.de>
References: <20251120152914.1127975-1-simon.schippers@tu-dortmund.de>
 <20251120152914.1127975-3-simon.schippers@tu-dortmund.de>
Subject: Re: [PATCH net-next v6 2/8] ptr_ring: add helper to check if consume
 created space
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit

Simon Schippers wrote:
> Add __ptr_ring_consume_created_space() to check whether the previous
> __ptr_ring_consume() call successfully consumed an element and created
> space in the ring buffer. This enables callers to conditionally notify
> producers when space becomes available.
> 
> The function is only valid immediately after a single consume operation
> and should not be used after calling __ptr_ring_consume_batched().

Please explain why it is only valid in that case.
 
> Co-developed-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Signed-off-by: Tim Gebauer <tim.gebauer@tu-dortmund.de>
> Co-developed by: Jon Kohler <jon@nutanix.com>
> Signed-off-by: Jon Kohler <jon@nutanix.com>
> Signed-off-by: Simon Schippers <simon.schippers@tu-dortmund.de>
> ---
>  include/linux/ptr_ring.h | 17 +++++++++++++++++
>  1 file changed, 17 insertions(+)
> 
> diff --git a/include/linux/ptr_ring.h b/include/linux/ptr_ring.h
> index da141cc8b075..76d6840b45a3 100644
> --- a/include/linux/ptr_ring.h
> +++ b/include/linux/ptr_ring.h
> @@ -453,6 +453,23 @@ static inline int ptr_ring_consume_batched_bh(struct ptr_ring *r,
>  	return ret;
>  }
>  
> +/*
> + * Check if the previous consume operation created space
> + *
> + * Returns true if the last call to __ptr_ring_consume() has created
> + * space in the ring buffer (i.e., an element was consumed).
> + *
> + * Note: This function is only valid immediately after a single call to
> + * __ptr_ring_consume(). If multiple calls to ptr_ring_consume*() have
> + * been made, this check must be performed after each call individually.
> + * Likewise, do not use this function after calling
> + * __ptr_ring_consume_batched().
> + */
> +static inline bool __ptr_ring_consume_created_space(struct ptr_ring *r)
> +{
> +	return r->consumer_tail >= r->consumer_head;
> +}
> +
>  /* Cast to structure type and call a function without discarding from FIFO.
>   * Function must return a value.
>   * Callers must take consumer_lock.
> -- 
> 2.43.0
> 


