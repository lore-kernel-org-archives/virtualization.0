Received: from mail-yb1-f182.google.com (mail-yb1-f182.google.com [209.85.219.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3154137E
	for <virtualization@lists.linux.dev>; Fri, 19 Jul 2024 22:17:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721427479; cv=none; b=lcxIo8LGVpAogX1fa7On0XSlE+vszEiNz+mqytSiVm093MsYnXnLsoRv7HxUftCyqqXA5vMFiwVCUKJ9sA/cgJRJ25PstkKeO6h3Woki2DFOIoG9jxzsjSacit+yDVCQORMASaFE8h5YN71K/WoR05Ul4yeXXLRi5u7dPzVuGlE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721427479; c=relaxed/simple;
	bh=YOATFkfgNS+3rS6QLnE83pbgBotZYqzYcAIJg3mkgOg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=od+8KSiH0TCFV28JVwh5wZMa9dQCiKl5/WdDK/1+63hENZFyQIJfkw+Z8K9eZF55Q+qyUTNqgQlQ2XpZUTtDMw3MUAXsgpzWrNhX3eQrAamQ/JPDh4x91gRE/IHEt/pyDDDcfHQCZjpn0Dpr+dm20KrMRTCTIuSCX7Vokearvsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IAoSoEIQ; arc=none smtp.client-ip=209.85.219.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IAoSoEIQ"
Received: by mail-yb1-f182.google.com with SMTP id 3f1490d57ef6-e0857a11862so1890904276.1
        for <virtualization@lists.linux.dev>; Fri, 19 Jul 2024 15:17:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721427476; x=1722032276; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=1jGXfdWpQJJrTSSla9HtO9pAwH9DpMOp4sTEA70VfYc=;
        b=IAoSoEIQ5CrNS8e2zxAspjPLcDxbexQ8jXjgr3ZGmSN1YH7Pyl/kseKdYnIwaMPq2C
         LQ+k4+Cv2U6ddFHgckI211EPC67ReGuHXJfeR/JT0TDf4eaQQZ/5/sz5qQO5O4du5CSf
         wq02MMDObv/luYl5ovLYn6JtLRi+ksQcp/46wnrV9lahBjF3uvE+hQmpLYBIQQYypo1P
         Lzy3RN8dRDfwPupk5TcuKg8+7dVhjLLnEXW818JerBpj+GqmhzB7WCjLi7xjGeGSEa3D
         EBda/9t72iwPoG8JLDVtMu9dHMBIlSs26mnkpxAPDz3uqLJMN7TpjRDE77oY71YLsR5z
         OO0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721427476; x=1722032276;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1jGXfdWpQJJrTSSla9HtO9pAwH9DpMOp4sTEA70VfYc=;
        b=oCOt/kxP7BWpoSROvYmHf9R5bCOXp8wyMMFC0JZWCL9Y8wA85bOWJceOeKAtxHADje
         zMZ5XZ7/ZbmYoF/Opo43g8/hKMP/b6KVpBxKLlGxg0VM5ILB8wRV99xPg8+YD7ALHlIZ
         Gkn52gi6ft/9/OcT6JE9lc/VQyZZ9K+eB+BgmjVinAv3jYwBrHhx5qcMRGvr7KfO9WOA
         Izml4WWEx5+4CwpnprieKn6Q2fALD89vU+PLX+o4Q4kK15B3MLY/brKkZSf7Cmu4Yh69
         HXW9x/ffpCA0XfkCrAFZmx+BmlLgkq6MNwfpewlnB1hrrBTAlR17CQWWq0uHjM+uvLHV
         s5Ew==
X-Gm-Message-State: AOJu0YyC6WxOLth1oySdc7sm2whbTpWEs/kI0yE3UxSPEc0TjOQwtR3x
	w9QWRJEWcd+D1SoU6XWdVllunGvjavo5NN0dOOo/59rfisxUkJE+TIPKKBQV1vM=
X-Google-Smtp-Source: AGHT+IHhRWHIqrLeN0dMZIGiVUQ12x7cCGbAIK/yxE/fhPtRa9Jeirwo0a7tM6aWk/2XMcYJ+8VQzw==
X-Received: by 2002:a05:6902:1206:b0:e05:7ae1:5386 with SMTP id 3f1490d57ef6-e05ed6ddb3dmr11730016276.13.1721427476470;
        Fri, 19 Jul 2024 15:17:56 -0700 (PDT)
Received: from fedora ([2800:e6:4000:47e:7c52:7bd4:cfe5:9874])
        by smtp.gmail.com with ESMTPSA id 3f1490d57ef6-e0860ae9c1asm692009276.50.2024.07.19.15.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jul 2024 15:17:56 -0700 (PDT)
Date: Fri, 19 Jul 2024 17:17:53 -0500
From: Juan =?iso-8859-1?Q?Jos=E9?= Arboleda <soyjuanarbol@gmail.com>
To: Eugenio Perez Martin <eperezma@redhat.com>
Cc: virtualization@lists.linux.dev
Subject: Re: [PATCH] virtio: Fix various coding style issues
Message-ID: <ZprmEaNIiQk8Mkob@fedora>
References: <Zpn9t5xJCPMhvpZO@fedora>
 <CAJaqyWfU0th74hJ3Vww6QXqewvSyOobgogT=Vt57M+HqaTZ0ig@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJaqyWfU0th74hJ3Vww6QXqewvSyOobgogT=Vt57M+HqaTZ0ig@mail.gmail.com>

> > -device_param_cb(device, &vm_cmdline_param_ops, NULL, S_IRUSR);
> > +device_param_cb(device, &vm_cmdline_param_ops, NULL, 0400);
> 
> What is this warning? It sounds more reasonable to me to go from
> hardcoded value to macro, am I missing something?

Hey! I believe that the hardcoded value seems better as well. I got the
warning from this:

./scripts/checkpatch.pl --file --terse drivers/virtio/virtio_mmio.c
...
drivers/virtio/virtio_mmio.c:802: WARNING: Symbolic permissions 'S_IRUSR' are
not preferred. Consider using octal permissions '0400'.
...

I can bring the 'S_IRUSR' again in a V2 patch if you prefer that.

> 
> The rest looks good to me.
> 
> Thanks!
> 

Thanks for taking the time to review!

Regards,
-Juan
