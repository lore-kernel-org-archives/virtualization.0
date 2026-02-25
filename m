Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E45C42D2385
	for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 14:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772031032; cv=none; b=M4nfJecL2xFXUlAAo23BQLe83JzuKYLu8XG7PEw/YKCJA+blW248dCPDaIzKDhcIhO2xELvok/RjPFPd3cSvGixJ86j22igQsJWHpJsfrPl5C3NpQe54N3GC9WhhFWT8mg4YXeLBQf9coq/dnaMit5TAUgJo/N6aLr99jjb664w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772031032; c=relaxed/simple;
	bh=9cOn+icfMwJvWMpM83O2pGeAdt2CDV53l+nZGfUDC80=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=tgQjy9DYcYTq/MdjtD6QMPXCZ/pST6X8TgGfoTpDyorObIZO092iKaOX8PUi/RkOnJB1+WRMgc8tqlsCzxYH9cAJFgBijfDeGuq6wSQDgUk6xuqMmuFVjPH0TeBmCk2GXxv+LjdThjNgaicbvxNTY+luKpKnqIq+l/kJC9I13AI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JB9kyssO; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JB9kyssO"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-4377174e1ebso5150487f8f.3
        for <virtualization@lists.linux.dev>; Wed, 25 Feb 2026 06:50:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772031029; x=1772635829; darn=lists.linux.dev;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pReYA+QjnSS0jJEBr+XFghFAyZTC7b05jHSUp2QiLn8=;
        b=JB9kyssOfNO3efmcwbyuLoSc4VCixl0MJNrTqYNTWr2TE1QAxjHayKsC2V1D2uTdYN
         u3aAVRnDUvZWRT8xTUgfJAK0x4PQoJvVa+tTSDOSatlitTuq/ZfG00+ZmblCmWMMOJDO
         orZhDGuB3zYc+QPk6usZg/5aXFX4P9ChualWBjHaVd/DqC/lQAuGsuEOlnjnMmCxVErO
         a1xjx60ze8pcU+QdrS2J+/Xez1vzryUTqOEPd1L6GArkoq8oqh6lAqVMPOd6780Qmip6
         aZqHvVOh9sR+yMTrfHQ410a4/L9KkZWcRuzzlDbPQR+tfbGBI+k+nuVubibYYC7dmURa
         8UvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772031029; x=1772635829;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pReYA+QjnSS0jJEBr+XFghFAyZTC7b05jHSUp2QiLn8=;
        b=D3w3dHAJ62Tl2BylHnM/Zj92nKb891jsTxeNHGdpCsQpVXjxwXsKm4/tZ77G0t9eGn
         z0lrM8ObwhlF4yHoxbKpi7g6H3BmDMLOdX7uiorcntZ0XmBoffUMLMwGwyZG2Mt9oteU
         ewIqCRn/zmnIoKoO73dZgsmK42Wfwc/jMg23yU6E7y7VhkxE0A3ji45uF3mcTK3KCFMX
         8G+785iF97lsO/enWCRC9V7BL35o9OXu8ukSKZt31+8d548r2pduPXg4QeYf8I1jQx7Z
         j1+/Ng6Q7DTvOHTELd2xpnWNvScRTXyMWByKLzj7qoLFs4PHIEBabWBi6xO9k2hlymmQ
         OZlg==
X-Forwarded-Encrypted: i=1; AJvYcCVnPXfU6LGTyE16uCTQeJV1OuFmRbAdFUbyw0ivxLmKN+0nrnUxzXKLaHRQoirZUsl+NJhHzPiCtGR073wZEw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwcquKdX0q4wtqOPap0v6CViBctWnWBd+CoouHNp203PSSCsI9C
	26c1C5KmmwRzZAf6WEsnV/tl8iaA3M3Cb5xCoJUzzHJ9sd7tHUocqjiB
X-Gm-Gg: ATEYQzwALNakxV/YK9Z/iNfoQqgpZDjhwZE/YkXysGUuqhco0Pdn96jzDUo1Mji3WRA
	AtkQXssWZtKfYQuuXTzV41O5IxjYuq26kft7WQx6xa0N0K/v9OHTkkVS7SU/KKVWF2kRyzNaR6+
	YB24oHtZSmI3q16bQGOCnoM65pdRgxYxynr8Z6gxH/cOEeSDqSE6EOSWz+NBc1pg76KEkcswJKb
	GfzOv6gZszISA3ixLJ4rt65loujf023KS0I7/+TwP8M7B1gALO2Xvjwhm77NjnFJq7HyZiieK1g
	Q1GsPlB5EfUJfSYILFbuzInvXbe6QwWURJeCU4T/2XYci22ToXBVIiX7IFzg4ZfpHaiajXEBdUy
	pU8eMU+umTSFkW/eYgs0RSndhjwzSBOy6cSO1AUib0rdijNAEE+lJPZAjOjEc3rR9Kz8cHYeWbH
	WSV/STg+s8gRnDaqrgoUgIJOQ6JhwLPk6Ep4pdtKGH4obrF0RHygzQ3aL+EZi8yWfCAy2EWEReW
	JU=
X-Received: by 2002:a05:6000:3105:b0:439:94ac:9d9b with SMTP id ffacd0b85a97d-43994aca6c4mr945744f8f.55.1772031028962;
        Wed, 25 Feb 2026 06:50:28 -0800 (PST)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43970c00d95sm32981718f8f.13.2026.02.25.06.50.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Feb 2026 06:50:28 -0800 (PST)
Date: Wed, 25 Feb 2026 14:50:27 +0000
From: David Laight <david.laight.linux@gmail.com>
To: Srujana Challa <schalla@marvell.com>
Cc: <netdev@vger.kernel.org>, <virtualization@lists.linux.dev>,
 <pabeni@redhat.com>, <mst@redhat.com>, <jasowang@redhat.com>,
 <xuanzhuo@linux.alibaba.com>, <eperezma@redhat.com>, <davem@davemloft.net>,
 <edumazet@google.com>, <kuba@kernel.org>, <ndabilpuram@marvell.com>,
 <kshankar@marvell.com>
Subject: Re: [PATCH net-next,2/2] virtio_net: replace RSS key size max check
 with BUILD_BUG_ON
Message-ID: <20260225145027.29d666ac@pumpkin>
In-Reply-To: <20260224065850.962826-2-schalla@marvell.com>
References: <20260224065850.962826-1-schalla@marvell.com>
	<20260224065850.962826-2-schalla@marvell.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue, 24 Feb 2026 12:28:50 +0530
Srujana Challa <schalla@marvell.com> wrote:

> Since NETDEV_RSS_KEY_LEN was increased to 256 in net-next, use
> BUILD_BUG_ON to enforce the limit at compile time and remove the
> redundant runtime max check.
> 
> Signed-off-by: Srujana Challa <schalla@marvell.com>
> ---
>  drivers/net/virtio_net.c | 8 +-------
>  1 file changed, 1 insertion(+), 7 deletions(-)
> 
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index eeefe8abc122..768ad5523dfa 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -6639,13 +6639,7 @@ static int virtnet_validate(struct virtio_device *vdev)
>  			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
>  			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
>  		}
> -		if (key_sz > NETDEV_RSS_KEY_LEN) {
> -			dev_warn(&vdev->dev,
> -				 "rss_max_key_size=%u exceeds driver limit %u, disabling RSS\n",
> -				 key_sz, NETDEV_RSS_KEY_LEN);
> -			__virtio_clear_bit(vdev, VIRTIO_NET_F_RSS);
> -			__virtio_clear_bit(vdev, VIRTIO_NET_F_HASH_REPORT);
> -		}
> +		BUILD_BUG_ON(type_max(key_sz) >= NETDEV_RSS_KEY_LEN);

type_max is horrid.
I did read the later discussion (but it has fallen out of my brain)
but isn't that check broken and/or backwards anyway?

I'd also question why you are using u8 for a local (I didn't find this
version of the file), it will generate worse code that [unsigned] int.

	David

>  	}
>  
>  	return 0;

