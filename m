Received: from mail-pg1-f170.google.com (mail-pg1-f170.google.com [209.85.215.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4B6C41208
	for <virtualization@lists.linux.dev>; Mon, 12 Feb 2024 18:51:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707763913; cv=none; b=BQPI4l4kcf0c1ys2whYwJNU0fZHrvfJnSU1DWp2J4Bt8g+dyszy7DG+YB782E7zCfeIlMNtjnLzKKk8KiQIljMMOwif9h/Di5CyKKuNh7++BRqOp46w42Ixxw4a8mHp38leG5Tl3FRnp/O7WWd5FYdTPMB378r3wYl9jcd/JWRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707763913; c=relaxed/simple;
	bh=GTS3knEn3U37SHf/wqemlrktyAqbrDzvlYNJt5L8bzg=;
	h=From:Date:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=mPrpheDDQJRe/XqILp+tFTb4uNBTPKzcxqpdsurVEC4j2CtlpkLlEcpmAtClREqWDLfspK8fYG5rcfeHok8i524O6k4NH8K4W3SAcfXNGzHhSue9CoWBgCn4EzJismkWPWojkVUhJlH4w0vl7S2Hl7qc7Kxe7gbg19BfjK7f3rA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org; spf=pass smtp.mailfrom=chromium.org; dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b=UBO9Y2BP; arc=none smtp.client-ip=209.85.215.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=chromium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=chromium.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="UBO9Y2BP"
Received: by mail-pg1-f170.google.com with SMTP id 41be03b00d2f7-5c6bd3100fcso2133095a12.3
        for <virtualization@lists.linux.dev>; Mon, 12 Feb 2024 10:51:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1707763911; x=1708368711; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mPGSiRqCPFqmFEWSJFO1d43GTTlaRz0f+e2eVAoQklI=;
        b=UBO9Y2BPCW9TqskzBmM+RScP4eCYiE4fm4fO79IV0ZXhvQZitB/Lbnl9wpOcruLoHe
         87YxjMyk/2qCUUuQHu/vHO/+7NpjxlC5Zjkt9m9lRo7b/1NqOp6JZKS2YSpndL8EW8sd
         eiLTYyU653Y+Mt1ogzqGpuxTK4u9ADNJK7qtM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707763911; x=1708368711;
        h=content-disposition:mime-version:message-id:subject:cc:to:date:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mPGSiRqCPFqmFEWSJFO1d43GTTlaRz0f+e2eVAoQklI=;
        b=Fdfutu7NwvNsSlhAA43aaVCQUv34O8wyv3NuD3SqKY7EZ+JaeRg3t4P/K35C8crUoK
         rD2kJJkjqpWPm/hqvz/3TNLc0GNnuIVLp0fZxRz8ANIcASeJE95w92nYSu8J+Keueran
         0CLqaYQoM/Z6j2+S73vvyWhIQCuRiKoPimuG9uMjA11Ej4Etoe0eWwfeJmVXBBzMHh+h
         G1t2rxz9XzkXKcyIIDE/yNgGEAME5QAdFSmRi8usOFUzoCfkKPccWl0+lxz6sE7fwlmo
         4PsI3ws1svUm+TEf4jj/aPS+yjrs1sWKRY4BMOlJYnnxrgdl6yYOHLpnniZIErZ1ea2T
         JYrw==
X-Forwarded-Encrypted: i=1; AJvYcCVqMY+jmiNjWx0TOfhKrIgZZCxEPkmr9TT7g5Mc5eL8hfdfXh0R1DvGSUu2FYlNSTjSekhVhNVYB4Siu0N7R7p0D6w5XVxStZdLQo0LvfU=
X-Gm-Message-State: AOJu0YyMMQfgg+9RjxvtMg2KsKkBvxl5Ol9qLoxD5kKOqzFf/hyZEXjJ
	O5+7SHwAxo0zrYFOS3vUSf+WGJsca0PQHA4whX0hjXuMU0C2wUfgfu0WezyvIg==
X-Google-Smtp-Source: AGHT+IFiP4XqEVFPUe0AQ5sfHfutAVORBuy6ctbchagD56aaWb7k8kuXps4xMsVwiJ9ZHG46ydaEYA==
X-Received: by 2002:a17:902:e5c7:b0:1d9:a647:5579 with SMTP id u7-20020a170902e5c700b001d9a6475579mr5817557plf.1.1707763911196;
        Mon, 12 Feb 2024 10:51:51 -0800 (PST)
X-Forwarded-Encrypted: i=1; AJvYcCWVMXpMNIhotAYcYiqvNVCkUE02lF5spebU9llp4fc83Uutkz2jejMC03XmEIikgbWSldV5H3FNfAtE/6Jgii8cDrbgJCUgH3FC06zl/KgIj9f0r9uzQf62jhBRN7BKOi1tZOnRyWmjtO7PY6+GSekpCARKo/B9UBpkn+azS/Cmmzi9TXICwENuOXYbDsVLW+aNl5BNyMY3j4f4tfwfGghjhJcNsUZ6UbcCDRZwnBmZD5vN27Xpt2chVq15/1Tj6eg7VCkbJz8orDtPaf0/GidfJtGvk+NZZPo9yUI35lJxR138j6xF646MPyb2DcV92qgf2IShUDlLrbaOWviiuXiOzIENe3ZZ1bXgGWRrVUEl1L12s9CLURo4SeY620eR/lcDl2m//IprO4DY6HkY9R14CW6xhIJkrV47ecHxKR84yndQsDXM3NJqMcpiu4M6Y+P8kbk2+ZWg8t1RBE4uXWXtDWTxFaVA9585IKWuec4srYj5WnES1gkpMYxVgbudrRnPzxYH+H7a4hODicJw9+ImmaeqZYgOPYsAmQk=
Received: from www.outflux.net ([198.0.35.241])
        by smtp.gmail.com with ESMTPSA id u11-20020a170903308b00b001d9fa58f5a4sm675012plc.48.2024.02.12.10.51.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Feb 2024 10:51:50 -0800 (PST)
From: coverity-bot <keescook@chromium.org>
X-Google-Original-From: coverity-bot <keescook+coverity-bot@chromium.org>
Date: Mon, 12 Feb 2024 10:51:50 -0800
To: Anton Yakovlev <anton.yakovlev@opensynergy.com>
Cc: Jason Wang <jasowang@redhat.com>, Takashi Iwai <tiwai@suse.de>,
	Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, Jaroslav Kysela <perex@perex.cz>,
	alsa-devel@alsa-project.org, linux-sound@vger.kernel.org,
	Aiswarya Cyriac <aiswarya.cyriac@opensynergy.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	"Gustavo A. R. Silva" <gustavo@embeddedor.com>,
	linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Subject: Coverity: virtsnd_kctl_tlv_op(): Uninitialized variables
Message-ID: <202402121051.B091CCC4B@keescook>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello!

This is an experimental semi-automated report about issues detected by
Coverity from a scan of next-20240212 as part of the linux-next scan project:
https://scan.coverity.com/projects/linux-next-weekly-scan

You're getting this email because you were associated with the identified
lines of code (noted below) that were touched by commits:

  Fri Feb 9 14:01:15 2024 +0100
    d6568e3de42d ("ALSA: virtio: add support for audio controls")

Coverity reported the following:

*** CID 1583619:  Uninitialized variables  (UNINIT)
sound/virtio/virtio_kctl.c:294 in virtsnd_kctl_tlv_op()
288
289     		break;
290     	}
291
292     	kfree(tlv);
293
vvv     CID 1583619:  Uninitialized variables  (UNINIT)
vvv     Using uninitialized value "rc".
294     	return rc;
295     }
296
297     /**
298      * virtsnd_kctl_get_enum_items() - Query items for the ENUMERATED element type.
299      * @snd: VirtIO sound device.

If this is a false positive, please let us know so we can mark it as
such, or teach the Coverity rules to be smarter. If not, please make
sure fixes get into linux-next. :) For patches fixing this, please
include these lines (but double-check the "Fixes" first):

Reported-by: coverity-bot <keescook+coverity-bot@chromium.org>
Addresses-Coverity-ID: 1583619 ("Uninitialized variables")
Fixes: d6568e3de42d ("ALSA: virtio: add support for audio controls")

Thanks for your attention!

(Human comment: looks like there's no "default" case in the switch
statement.)

-- 
Coverity-bot
