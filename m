Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9DE87158A09
	for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 07:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724053915; cv=none; b=J7+kc+1Xqty0F0vK4PkK2FA53yTvnZY4Akvf0kcxTXhAQbrEXt/TIXGB84XmQb52Z9ihGIwvxnL5uWW8qSOrTjwHbnhkLVMtJzwOtKumDuyGuUhzvvePNbZjwczhIQrOAJoeZc8fAG5DpPQjLdv4m3k4wvBF8NG3foDua/ikVD0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724053915; c=relaxed/simple;
	bh=UGPY+1GjNPazkb7vGKIf/8zxTAAkxIiZ0PWAx6W8Doo=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ilFDCgvb1JNiUcwanu+ztWm5JpZp0sOBRGT1uPmTVVY7H9SD+MBVx3QQQeqIbgFDdMnz3IRTOk3LN4b19/7qXxIDRTpff4mfXVhbK2WqavUfJ1pq9kGyO+HT7szHP204EEPtg4CUhIIoSTfrvR9zh50O0/kFt6sjKLqPYYDtZpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com; spf=pass smtp.mailfrom=suse.com; dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b=Z6Cgnq38; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=suse.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=suse.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=suse.com header.i=@suse.com header.b="Z6Cgnq38"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a7aada2358fso781314966b.0
        for <virtualization@lists.linux.dev>; Mon, 19 Aug 2024 00:51:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1724053912; x=1724658712; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=hfxCbJ0oz0BjnXe6UDD49N8FalEMneDsX4L511QNvzo=;
        b=Z6Cgnq38ITqApeBPn2RQqbNYVYWUbtMzYcc5GcYGgh5DXxeaI+gY6YGpKrR5ID/s/E
         YPV27so68ZK+j3wSjl63yJODG+8FotcJ5GL5K5ko0m2vIcQQrWOwFV8E0nSil5sny5tg
         3E9paM4UMNMEzlLniShC5u7ne5kqM7uzapfnnYgwrLxIz7zlTyUDI36u66dXs7M2q+JS
         aZ7ogLu7flnk0KYs/icUxsbAbMH9D4ZtdBpFJ3UHP0BpNaFSazus9mJSPKq6KU2oNcKh
         4k1uOSTafIMVNlh45N7mcyRW3HwOk0MxGqY53e15ojBPZxPFCX14TA4uW79m1p7VwTxX
         whbg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724053912; x=1724658712;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hfxCbJ0oz0BjnXe6UDD49N8FalEMneDsX4L511QNvzo=;
        b=IJ2lHZkvzLEAKN7WbMbowsIr/P44LlXfzFvqg0ASzHcLiSfOFefMjIyv/GrtZjy6eZ
         m/1WXA8S60J6OHh8lOpmwcOAhzgqDUrtAprHplFmTDZ8rAl9l9/Dmzrv9tvIhEcDZFD6
         YJE8RRTPYHSkN6bhGXjiR9xT+J+MF+xFF6yUBAulU1vlYJY0sYtpCU9G5KZ/qaEq2J57
         zpsm9T81j8FazHJjIwLSsBCrXUzlqG5imtsD61jGfHqplIvoAKTBHU//FmzoA7vs3a2x
         3fEryFmXdPSI7zYFWtEmaPqhMvvK/oq/OQWSgLRnB1vyhsXmzbSLusloM24bMoeXzcFy
         IyQQ==
X-Forwarded-Encrypted: i=1; AJvYcCXoPZjZ8qglJWcmn+3ycYHt0o42uHhl84Yq5qltTftI5Q/+yu3VmvLKePaB0ZsB/8HaGTgrM48o2h68E0jASFhuVf7Qc/xQl7aZZGKm7yA=
X-Gm-Message-State: AOJu0YyaIbd++R7MCd0n0nhAiJlDU7YvOWMI/naHwuLoMMCokgTlasYa
	gT1LuqOCjXn4BydDDk+Pvh7JpMpIQeOxjtaDe+Ocs4uhlLFJvCyi0jhhHW3hZ7c=
X-Google-Smtp-Source: AGHT+IHSUcqLb1+f1zcdTbLwA8OIHGmuo7k2hZNR4LhJgHm31w5qRPe0QyF+uSgNCinoLWosF7erZA==
X-Received: by 2002:a17:907:f765:b0:a73:9037:fdf5 with SMTP id a640c23a62f3a-a8394d6a35fmr1022877966b.6.1724053911765;
        Mon, 19 Aug 2024 00:51:51 -0700 (PDT)
Received: from localhost (109-81-83-72.rct.o2.cz. [109.81.83.72])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838394645dsm606157966b.144.2024.08.19.00.51.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 00:51:51 -0700 (PDT)
Date: Mon, 19 Aug 2024 09:51:50 +0200
From: Michal Hocko <mhocko@suse.com>
To: Yafang Shao <laoar.shao@gmail.com>
Cc: Barry Song <21cnbao@gmail.com>, akpm@linux-foundation.org,
	linux-mm@kvack.org, 42.hyeyoo@gmail.com, cl@linux.com,
	hailong.liu@oppo.com, hch@infradead.org, iamjoonsoo.kim@lge.com,
	penberg@kernel.org, rientjes@google.com, roman.gushchin@linux.dev,
	torvalds@linux-foundation.org, urezki@gmail.com,
	v-songbaohua@oppo.com, vbabka@suse.cz,
	virtualization@lists.linux.dev,
	Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
	Kees Cook <kees@kernel.org>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Maxime Coquelin <maxime.coquelin@redhat.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Subject: Re: [PATCH v3 4/4] mm: prohibit NULL deference exposed for
 unsupported non-blockable __GFP_NOFAIL
Message-ID: <ZsL5li48aKuX-6Nw@tiehlicka>
References: <20240817062449.21164-1-21cnbao@gmail.com>
 <20240817062449.21164-5-21cnbao@gmail.com>
 <CALOAHbD-npQmchiRJpGvOBVOM-Li6oRyMnKAjgiHq3DasiXMUQ@mail.gmail.com>
 <CAGsJ_4yWPw5ihcnxxGDBVR0s69WdqZf_GQdx49u6NXEefd1pQA@mail.gmail.com>
 <CALOAHbBLF-Rt-RML=oOAkwW6PJDoMRTdV_6itw69xJLBrERGmQ@mail.gmail.com>
 <CAGsJ_4zA60pQ8qS4XzoR7ZFeAw=GmA0Xbwx18pLBR-B+nO4Mjw@mail.gmail.com>
 <CAGsJ_4wHCtkVau=gQRowOaJEYQ4dsSFtYx0rk13cZ+A+9gmm2g@mail.gmail.com>
 <CALOAHbCcSqZx99zoAzRFHFKbRBXxLFWg=MCXR2-gL6i2bENuaw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbCcSqZx99zoAzRFHFKbRBXxLFWg=MCXR2-gL6i2bENuaw@mail.gmail.com>

On Sun 18-08-24 15:07:00, Yafang Shao wrote:
> That can be avoided by a simple cond_resched() if the hard lockup or
> softlockup is the main issue ;)

No, it cannot! cond_resched from withing an atomic context is no-no. And NOWAIT
is used from withing atomic contexts.

-- 
Michal Hocko
SUSE Labs
