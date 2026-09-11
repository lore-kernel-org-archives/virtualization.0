Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com [74.125.225.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38CEE4BEE28
	for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 22:51:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.225.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789167077; cv=none; b=KB3iOCMkl/nnYBrV18bMkUPsRI4QXB8IqBJVZ3DN6C56Hey3hBPYNXSX+n1oos/sB3jpTYdRyjnuvI7SE0KlzNFRqkvWN6lXL7hRtNbWtkfQ4HoCFocrqXF3ff0VeVc/Ip/DMVdjiKep9U+wawO+ECxbdYkAfQzw9iu2t6cV3KE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789167077; c=relaxed/simple;
	bh=WuszOSuvbqD8TkSiGDsvjzA7UbjiYA/y76dC6911dVk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=AydLytTZG6kE6D/ZNFDYcTljrxLj1xZ5Er2jJQntH5I4Jitk2CzP27hAPCuT1hoYiGAOeFWAQSOT+UG6yQjTZG8oB2HW3DjLh191atSOzYc7b3Tmw1K5bwQIgCDBaHLSSrB8EzBc5InhHnCYyvJnBYIw8h//jomsVOlneWJhn5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mpNayRaj; arc=none smtp.client-ip=74.125.225.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mpNayRaj"
Received: by mail-wm2-f12.google.com with SMTP id 5b1f17b1804b1-49b912d822dso605485e9.2
        for <virtualization@lists.linux.dev>; Fri, 11 Sep 2026 15:51:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789167074; x=1789771874; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=ZGSo0dQwPRhPDt4biflnyco60O6gQHBMyd0ue8VnOGE=;
        b=mpNayRajkU/21XYPRmVQf/c5N4YNFoZdvAAfaF/U3kNmAd00sRQ9SxTmh4fE/zIc9X
         qTAtEadUXaT02D8gACo1qcJQOzqfv1HIUbBn2bOzvUooztV2QhxOuMMZtGO9PgibGOL5
         3Gpq4LTjrBdWhbMHCwsiFDSmGxvvuZnNXpGPdHL3NxEiAos4PXYLwNSlw6oE5Mzs5Bk2
         qkpP8zuIoBOrViylgHMDoYlC/oHzPSiI8Nb87k0bOd4nxF80ztbxO9XqP25kFWL8Tzg5
         yeC7euJwdBg/l3LnJh3kV+tlY17SOzn9YquugsrtfWbI9J+Lyktg6W50tlIYiXnjeDiK
         BDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789167074; x=1789771874;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=ZGSo0dQwPRhPDt4biflnyco60O6gQHBMyd0ue8VnOGE=;
        b=gExaJYG615oUjro0HI50afujiv1wAYyFIWkWOkARrK/aJPL2meg5f3PyQtjNEguxoO
         m00685aOkEDf3Q0ABaNaqOJITOsg7DUWwbTjY4iiOJcLJjMVEGQUsOtTj6opGpqdWWNQ
         QALTjPaIkB3AHvboJTf2SENZATL01alOPMSzchEl6YayBxebASVWftdW1TKTaQeinWtY
         a7U95oWO5OkwRfjnQUmuGbvohniVT4oOs+dhZSciXT8Ejwb4u0lP3OP/Ma5d8VL/lHVu
         DpyeCPg/JMlZi6m7UeTSz91Q95pCqV4kt8rJ9fnt+aNL/VKu99YmurK+BwWaWhZ+FOXH
         aFKg==
X-Gm-Message-State: AFuF++mpdeslzCBtPsDup5Z1HPRNwi23SvhYjbrM8ATwDcagtnf8hCFV
	qOTgSHKhK8qSIwY4G6DTYrWB38vblBLw/QEQ3mq2XORst8OobVyozeCO
X-Gm-Gg: AYBFou0p4ZZotAjvVVt8f1rFJKnkxiMF7Iu3uM12mlM6aiSiwiTEe5uuwiPpKP80KhT
	paLRbWGVvI8RflZ7z/svgFw2fOlWmHh+WtaKZwZ4GSIjjg2KVYjD2x111sWDA6M0GOdzlu1tyKd
	EUoQEnG0Jc8ltUYDJkGAuJRwb6Or3CNtuZiC+9ffCZidHzpmpIdq/7ra+2zkYVLi5/gNcHXb1iW
	V18EvwLeNdL02sJxU/6JkWwYZZHKYEEwcWWEaZz2ag7UW2dIALLJBu/AtzX1B2DHZ4Buu7eRypG
	OgaBSh+qaxdizYnZWStx39xEBjYBzE2dXb/EcqYoyFdYupwIJJq2vMivKsH7HHo+6DlQxyu0HaD
	kNH9DQO6VAAfeXbunxluY03YDOGl6H9dAJpyeyoPzjeA4DrhQjcwHePXcvjUJsYlzoi+oceOTzL
	zFoOkmz3XaX46uM6Zc/vbHba1ESr1F1lXa3Cyl3EtUJfVau7Dv0TSb0oOXadmRP+4tbNt1pRTIO
	dA72c9l6L804X6HgFhBJ9W3zB85ZIpmvSvV5TUqQKrXTv1EXHQMnUzmnUoBIPc/tFKVZOBwxRTH
	mUfVN5UMJ64uIBR67chUbylhEM68NnJaqwbfGXpDyDEa
X-Received: by 2002:a05:600c:6092:b0:49d:1fa8:b266 with SMTP id 5b1f17b1804b1-49e6cc11776mr1724495e9.26.1789167074426;
        Fri, 11 Sep 2026 15:51:14 -0700 (PDT)
Received: from unknown748F3CBA5068 (dynamic-095-114-033-154.95.114.pool.telefonica.de. [95.114.33.154])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-49e61a33e34sm79323665e9.0.2026.09.11.15.51.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Sep 2026 15:51:13 -0700 (PDT)
Date: Sat, 12 Sep 2026 00:50:42 +0200
From: Karl Mehltretter <kmehltretter@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev, jasowangio@gmail.com, 
	eperezma@redhat.com, xuanzhuo@linux.alibaba.com, jiri@resnulli.us, 
	sashiko-bot@kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/3] virtio: synchronize callbacks after device reset
Message-ID: <aqSFkk9bneL4zeNU@gmail.com>
References: <cover.1789160982.git.mst@redhat.com>
 <01295278b402c2856b83568e07c86853f2d30e2b.1789160982.git.mst@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <01295278b402c2856b83568e07c86853f2d30e2b.1789160982.git.mst@redhat.com>

On Fri, Sep 11, 2026 at 05:20:09PM +0100, Michael S. Tsirkin wrote:
> Add virtio_synchronize_cbs to virtio_reset_device fixing this for all
> transports that correctly implement synchronize_cbs().
> 

I ran 1,200 instrumented virtio-input reset cycles on x86-64 PCI and
arm64 virtio-mmio under KASAN, KCSAN and lockdep. All 173 callback/reset
overlaps completed before reset returned.

Tested-by: Karl Mehltretter <kmehltretter@gmail.com>
Acked-by: Karl Mehltretter <kmehltretter@gmail.com>

Thanks,
Karl
