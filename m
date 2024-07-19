Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 210C8137E
	for <virtualization@lists.linux.dev>; Fri, 19 Jul 2024 22:28:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721428126; cv=none; b=dWSlMS0eigdCYeSwvGX4p21i2g8d0OUKnX2nxWwSQXj/62If7m16fLyk9ONgeqlHn2iC0l9pRv8GM4PnYIw35+/EQVW7dJI5WzTVfYrb3Z3fRDxagVR4QIRvar7TJhVoapGEMz0zU8zzlQkCsQq0AJbcnjbSFZpRwHUs/KzOaSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721428126; c=relaxed/simple;
	bh=zRWpcSwaDn/CuQbgZNdxH8M+g77NQNX2WdZwT5Dhiqw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=INzCgdMeBiJxsSrdB2ABD+bZJ17XmkaoILBCiV9XrKkhfVph49VvpyksP4GTRp1rQAA0UI2nXyYaapAFLblla01Nfgk3kHWK/tyX0EajaB9h5dLoiEhKPwN2r9PrcJ+XdQNntvgzzIXCpyjGcZOUcuzwiXZKdZA5VIc5q0RFrdo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddSZoB3d; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddSZoB3d"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-64b417e1511so24333817b3.3
        for <virtualization@lists.linux.dev>; Fri, 19 Jul 2024 15:28:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721428124; x=1722032924; darn=lists.linux.dev;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=zRWpcSwaDn/CuQbgZNdxH8M+g77NQNX2WdZwT5Dhiqw=;
        b=ddSZoB3ddKREDgYT3/hOFOwxFgxgQkIeIzv1/3m/AZ1siYPPcw3Ya5o9sBwiXLsa3p
         ks5QV6DfyxTwrpmxTo9a3M9jmNMCaDKPDiYaHeb/ndrPO0r9QFMwJ/nnB7lOIXFOZXmn
         J2NO2qLlxlJ2as/KqanV+g4KAauLvvzzlj9qDhgVpByuPYN77r28lwK0hirynSfXLvGu
         PHtY66n2BsctTdvpEozTGw61Cllx+Qh4uiDc44OGufrE4CVCAJ02Eb0OT2s71ybppNuE
         uOwO+nnKzsOCzPyNg5ZNx1e2wpm4JQuNANxoD08FCDdDtbKyucLueRCinn8yjkgJJrDE
         X4Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721428124; x=1722032924;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zRWpcSwaDn/CuQbgZNdxH8M+g77NQNX2WdZwT5Dhiqw=;
        b=v93UH1up7mxU8KfsmzJuXiUjIvbQq1n4uJFYNg47D6+tP5p7Bj3zS8k2MgJzLR1u6V
         BIVR0fXX81vshVyzO30BKIEYNLV1W7Bn772fWiU0n6dsCK4PRb7ypO81hiWtPtuwznDz
         3/4d0icc/vcABhOF17hrak/f2w9E0s8xWwFWQqZHoGqEK6Ljwggozc13Tx9BlIoUm3wQ
         P9WZ6Iz2vpY/ffpHlozwDZpmcFyWnleUEyX446gRd34gX8qvRA4nqJBCLMbvqKCTuG83
         dhtKdhs4+QF+pGKm/oYFj1pjWJZt+9T6/D4IIaKjFqNEYHn7O2Ii8422TJiNYG7YOe+v
         bSKw==
X-Gm-Message-State: AOJu0Yz8OuwoOP7pPV+V8wzk2FLwU9j++233k9E7Lk0FwdHDg+zOYJ0Y
	PMARoAsvbX8QAX6e+XdL3dFdvUX43GeA33k3NTB0cGaSwpAZIHiwakgCbeoT1Do=
X-Google-Smtp-Source: AGHT+IEug/roAoubuWd7hALQGO3AtPnAjK2ktXN9pXueu/eOjAIP9Fe3ZF9hrqANbuZ/NpijEMeCSQ==
X-Received: by 2002:a05:690c:2f8a:b0:615:8c1:d7ec with SMTP id 00721157ae682-66a6588e4bemr12461097b3.33.1721428124084;
        Fri, 19 Jul 2024 15:28:44 -0700 (PDT)
Received: from fedora ([2800:e6:4000:47e:7c52:7bd4:cfe5:9874])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-66952459a36sm7203257b3.33.2024.07.19.15.28.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 15:28:43 -0700 (PDT)
Date: Fri, 19 Jul 2024 17:28:41 -0500
From: Juan =?iso-8859-1?Q?Jos=E9?= Arboleda <soyjuanarbol@gmail.com>
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: virtualization@lists.linux.dev
Subject: Re: [PATCH] virtio: Fix various coding style issues
Message-ID: <ZpromZpQ7ajhEJHB@fedora>
References: <Zpn9t5xJCPMhvpZO@fedora>
 <CAJaqyWfU0th74hJ3Vww6QXqewvSyOobgogT=Vt57M+HqaTZ0ig@mail.gmail.com>
 <20240719140906-mutt-send-email-mst@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20240719140906-mutt-send-email-mst@kernel.org>

> warnings from which tool?

Hi! Thanks for taking the time to review this!

From the 'checkpatch.pl' script

Regards,
-Juan José
