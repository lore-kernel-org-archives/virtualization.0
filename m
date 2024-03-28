Received: from mail-oo1-f46.google.com (mail-oo1-f46.google.com [209.85.161.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C8EF4085D
	for <virtualization@lists.linux.dev>; Thu, 28 Mar 2024 05:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711602999; cv=none; b=mbG8N9abfIy8mw0iFET37c+VOtYQfrtZPiKJKdYbbjo9h9Ze0qoTMC3GMX7nBDou8Pd+pM22hwRJk5ZT7G/LciOBYZsEVrx1DQvqgnYuIBkedFQi/RPZhJLj6c2nl1RoahmwtyqCdpg2Liwqo7brOdoLDO21JMxPjLesM0mCrMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711602999; c=relaxed/simple;
	bh=sBPTJcGEYTbv3hcgUwqNauzYtskOKb+GWpnb7br0MOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aJ/ncgFtMEADlDvFMVmd53iz5s244myhr4VSZg7NNoneYGkaLLlW0OqH48lZIysy3nSgsFDDt8+4F4k/blVb0lcKJ4UH6UR/2P6IN5bOL9OlFhsrsod8r3+dBhRCoD7Zu75ep7gdA3/5LSLavQ7q3aacsuWuHVB0jeer8WTSnok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=cHgMJrvU; arc=none smtp.client-ip=209.85.161.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="cHgMJrvU"
Received: by mail-oo1-f46.google.com with SMTP id 006d021491bc7-5a5362ceb7bso270879eaf.1
        for <virtualization@lists.linux.dev>; Wed, 27 Mar 2024 22:16:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711602994; x=1712207794; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=NCBBqATkrmhAqNvcc7V5yUc6Bj0MDD2J9Hd2vuTQUac=;
        b=cHgMJrvUnb2PD1Oof8B3R/yBuTD8xTU/oKbU/K57hm4zxFGGBxCZiKpQd6q6JpR6IK
         QUiUAmAJt1W15jf34xLRAzPr6MpBpu6DtZHEhfOXI+Lk9F5t1egIY9P3fZ5mQf+cFffA
         IcSiYK474na2fIQ/Zu1WTw1ZDiIdASt+umyc9tmGtXIEUlyTPEdLHio+adAu0rUS52n6
         2JaalArhzpecCw7Z5Axnj8ndfh1jA5XS026w21sj7xOFdScEnxQzkW+kWw5mj7aPXArE
         92HelhGwyh3pDaA61QyvcF9/h2qCos9BbMSTs8fqABUsMSoilo4s0cu9men8+VyzOj50
         FwMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711602994; x=1712207794;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NCBBqATkrmhAqNvcc7V5yUc6Bj0MDD2J9Hd2vuTQUac=;
        b=MtwFdttlYNlchXvvOBRVWAO+ZrMjwVqbxlt418P4yrJass2fyvyGDGlb+OGbEDaCqs
         O08ldq4JectAkNzRLlvcp1/AuwDzunr5rOj/ZEvK94sfJxJ5ADPSodvK5s1Ln7NxQ5Iq
         1tfkv/H5JQiTrDb4xSvqcUL6v8haY6oRhErgynfxexfxi6aarGddRrN+fWZmvSoDfXtd
         Q6oxJDxGCn/54kBJnObhosZgzdZ+LlY5OILAQ2Gmh58cBNrWY6qryR4dZNhgYY2mA0fx
         y1D+57XcCLxNAiNUhVxf1LvgRglkRb98m+UmzLeF3cFphrkwCrkYoE/HH+Nuw9FEoAob
         mP+Q==
X-Forwarded-Encrypted: i=1; AJvYcCVmbCrMvZSwp6cOLrohRtwO2pFrPssBK+D278HAz2eWvNHBzFq/KwILqysKqt1YE66+C/NYI8oifA+KjDOcd7NdktyuHu2V5Egzz7kEzAQ=
X-Gm-Message-State: AOJu0Yycjr69iYdvweBzVCjdxQV14yG6JeJ1SWKr/Lkkm/hhBrwKoEBX
	0NlUSNg5HdmgDd9BezYq3LwHPYKXKD61ab6/5+ZSZp5PRiG2rNl7kh9q2PlAncc=
X-Google-Smtp-Source: AGHT+IENjWm30W77Sho1F7STKjVDKRSghd/5qoLRwkalJNx2D7PN+W1+MnXgZZvq+TiwN/1tI/fojA==
X-Received: by 2002:a05:6358:5307:b0:17e:8f90:dd31 with SMTP id n7-20020a056358530700b0017e8f90dd31mr1555244rwf.32.1711602994298;
        Wed, 27 Mar 2024 22:16:34 -0700 (PDT)
Received: from localhost ([122.172.85.206])
        by smtp.gmail.com with ESMTPSA id u23-20020a63df17000000b005e857bba96csm433309pgg.10.2024.03.27.22.16.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Mar 2024 22:16:33 -0700 (PDT)
Date: Thu, 28 Mar 2024 10:46:31 +0530
From: Viresh Kumar <viresh.kumar@linaro.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Paolo Bonzini <pbonzini@redhat.com>,
	Stefan Hajnoczi <stefanha@redhat.com>, Jens Axboe <axboe@kernel.dk>,
	Marcel Holtmann <marcel@holtmann.org>,
	Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
	Olivia Mackall <olivia@selenic.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Amit Shah <amit@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Gonglei <arei.gonglei@huawei.com>,
	"David S. Miller" <davem@davemloft.net>,
	Viresh Kumar <vireshk@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	David Airlie <airlied@redhat.com>,
	Gerd Hoffmann <kraxel@redhat.com>,
	Gurchetan Singh <gurchetansingh@chromium.org>,
	Chia-I Wu <olvaffe@gmail.com>,
	Jean-Philippe Brucker <jean-philippe@linaro.org>,
	Joerg Roedel <joro@8bytes.org>, Alexander Graf <graf@amazon.com>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Eric Van Hensbergen <ericvh@kernel.org>,
	Latchesar Ionkov <lucho@ionkov.net>,
	Dominique Martinet <asmadeus@codewreck.org>,
	Christian Schoenebeck <linux_oss@crudebyte.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	Kalle Valo <kvalo@kernel.org>,
	Dan Williams <dan.j.williams@intel.com>,
	Vishal Verma <vishal.l.verma@intel.com>,
	Dave Jiang <dave.jiang@intel.com>, Ira Weiny <ira.weiny@intel.com>,
	Pankaj Gupta <pankaj.gupta.linux@gmail.com>,
	Bjorn Andersson <andersson@kernel.org>,
	Mathieu Poirier <mathieu.poirier@linaro.org>,
	"Martin K. Petersen" <martin.petersen@oracle.com>,
	Vivek Goyal <vgoyal@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>,
	Anton Yakovlev <anton.yakovlev@opensynergy.com>,
	Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
	virtualization@lists.linux.dev, linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-um@lists.infradead.org,
	linux-block@vger.kernel.org, linux-bluetooth@vger.kernel.org,
	linux-crypto@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-gpio@vger.kernel.org, dri-devel@lists.freedesktop.org,
	iommu@lists.linux.dev, netdev@vger.kernel.org, v9fs@lists.linux.dev,
	kvm@vger.kernel.org, linux-wireless@vger.kernel.org,
	nvdimm@lists.linux.dev, linux-remoteproc@vger.kernel.org,
	linux-scsi@vger.kernel.org, linux-fsdevel@vger.kernel.org,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org
Subject: Re: [PATCH 09/22] gpio: virtio: drop owner assignment
Message-ID: <20240328051631.c5eitp4mzaj4bh6i@vireshk-i7>
References: <20240327-module-owner-virtio-v1-0-0feffab77d99@linaro.org>
 <20240327-module-owner-virtio-v1-9-0feffab77d99@linaro.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240327-module-owner-virtio-v1-9-0feffab77d99@linaro.org>

On 27-03-24, 13:41, Krzysztof Kozlowski wrote:
> virtio core already sets the .owner, so driver does not need to.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> ---
> 
> Depends on the first patch.
> ---
>  drivers/gpio/gpio-virtio.c | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/drivers/gpio/gpio-virtio.c b/drivers/gpio/gpio-virtio.c
> index fcc5e8c08973..9fae8e396c58 100644
> --- a/drivers/gpio/gpio-virtio.c
> +++ b/drivers/gpio/gpio-virtio.c
> @@ -653,7 +653,6 @@ static struct virtio_driver virtio_gpio_driver = {
>  	.remove			= virtio_gpio_remove,
>  	.driver			= {
>  		.name		= KBUILD_MODNAME,
> -		.owner		= THIS_MODULE,
>  	},
>  };
>  module_virtio_driver(virtio_gpio_driver);

Acked-by: Viresh Kumar <viresh.kumar@linaro.org>

-- 
viresh
