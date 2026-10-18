Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4DF41DE01
	for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 21:43:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792359808; cv=none; b=SyICWWcs4D60vcBIxR1fnEg/oearfOOSWbBzK9K7EbI6OBNphhVLfU8La6UXRq6LEoOvEW1Oz5B7ru8NtZ/QyiU1jR4HbU3AbEvRqPmFJUufs0V8ABXlSwYyzLUuA+bnEDIQ/Vd9whvtg68hGdqdXlsErzx8KU7eXBGtlkFlI+g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792359808; c=relaxed/simple;
	bh=TMzR+utcD6ruredlhYW/mB7GgCGF9DnuMgw/+gVxnvw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=hB9ZE6Sx/Jtoj1X0wU1TlVcOFNqddgqt5OyrBFvCQcyKwZvV3/ZeAN/wlTRc/xZWQz0VVhieeFttBH7sn9TkPLL9HsuWexmBqkdwxMg+oGDt2mYe2CUTjJKWgGwVAiVbbIwIB4B6JU5BXS+VL/ruTiZBO/J8elwrVJR9z9lztWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Bj9d7fSK; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Bj9d7fSK"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792359806;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=JqsDUnOkotcWzQsS6kq2O+WN8oUkk4ukJhj46VjmH2Q=;
	b=Bj9d7fSKdFfVivhGffE9NMoRmGxy2thZ5E91cbComp+ScF6fcnXu6Ah4Jbf4pVB9/BgMI7
	wzOQZo6gguwv1VSs2MuthfdaBFMbmbmSzRZQFKuEkMLEh/fxiFY7UNbXS5Cb5ayHv404V4
	sl/W63I6ROuJXElx0gPC7AcsI+ZSXhE=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-471-uy2vm38hOpedVW9RHF9V1A-1; Sun, 18 Oct 2026 21:43:25 +0000
X-MC-Unique: uy2vm38hOpedVW9RHF9V1A-1
X-Mimecast-MFC-AGG-ID: uy2vm38hOpedVW9RHF9V1A_1792359804
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-48e0fc747a7so599395f8f.1
        for <virtualization@lists.linux.dev>; Sun, 18 Oct 2026 14:43:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792359804; x=1792964604;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=JqsDUnOkotcWzQsS6kq2O+WN8oUkk4ukJhj46VjmH2Q=;
        b=jPwN2VqzsDHCFb25u/iLoIY2PuiCZtDU7dR6YjqVMn2gyD86WHooraxmZ35HK6fsiJ
         IVp+Bff3wNhnP9TBstmKYOjTID7TfkYthH3LZKGAVeYwbxHPav/yMsxDYMXa+CgzuLnh
         pIvOm3kNmhucJtlzLIO3Bhh8vKGXzrX3GSbWyaCOne6zEZ1TTt2ykrEDjAWp/YJ26+MJ
         Y3pHCwd22qEmjaG/ScyLKgug4f+QdVOcWL9kijAP1+iwsWyZ2aRdJ4xCCcu9yoxVjL6a
         EVAgHhLqq+dgp3I0s4zv/u0Y+y7kTvW//Rbb607V94YNMvsuP4PVrG0C8A9sz2HEc388
         kgfg==
X-Forwarded-Encrypted: i=1; AKwUvByRp4mY4UoJSAQi74JfS8Hmmk/71bgky882YHNlWXchxiwqVVhMq5nR7uu6rlmGY1/C029znjQXNPJ0k27jVw==@lists.linux.dev
X-Gm-Message-State: AFq9FYKAO1azZpzXay9sDz5U+v7c84Xx05wPvNN1dLzsHm02aHacSPBO
	2XvvMJdGN2nr/5DiN5On+WGlSlqELrsKPZ/Cnif7cbmfC54PLM0vYI7Ho8rWhacqu9p3hK4vNWh
	jjsgSuvRsIp8qCbkFmD1Z0dEbqUAC0Y4l7WN30rGrONIkJQptlbJmt9srAzTMbK7GpCHH
X-Gm-Gg: AYBFou3liqdz+tToPfbFf1qEAkIC84yjUK6tbXqb3hHcbNTMEgdue5aUJgDTgVqh8y+
	tR9h1ZfK1MkZHRQmodN82GkNAXBp6iCSKiEmUb1GqdGHGIbSEulnadfUWNe4WQm88eCh4mFbJ0d
	j2MvdltBRtdxtpjiADXIZN2l1AgxELstUV6wN2VMd9ZPKW2vAOlMAu013fsQgj+c9y+0wB62WDR
	vw7EEMVDA75wKTP8XaTutvo8aznABGM0mHKyzsPoMqAanuxQCdCIcb9s+SzAm0/6hXhG6T0MEM3
	GDBZ6/p8/7sa2VSgl5ly7BKRHsiEPwLCTGtXfStNcHZbjSM5t4TAuYvqtPYh1k/6qk87kw==
X-Received: by 2002:a05:6000:468d:b0:48d:fd4d:7fbf with SMTP id ffacd0b85a97d-48e07988954mr8057913f8f.4.1792359803741;
        Sun, 18 Oct 2026 14:43:23 -0700 (PDT)
X-Received: by 2002:a05:6000:468d:b0:48d:fd4d:7fbf with SMTP id ffacd0b85a97d-48e07988954mr8057906f8f.4.1792359803264;
        Sun, 18 Oct 2026 14:43:23 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48dfdcc0f20sm18573888f8f.11.2026.10.18.14.43.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 18 Oct 2026 14:43:21 -0700 (PDT)
Date: Sun, 18 Oct 2026 17:43:19 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Haoran Wang <haoranwangsec@gmail.com>, jasowangio@gmail.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, eperezma@redhat.com,
	linux-kernel@vger.kernel.org, security@kernel.org
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261018174250-mutt-send-email-mst@kernel.org>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
 <20261018152358-mutt-send-email-mst@kernel.org>
 <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: mcUzrXgmWwlTsGXYV7PcSTfcC41GXJ69lzgq_G6HbYI_1792359804
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sun, Oct 18, 2026 at 10:34:12AM -1000, Linus Torvalds wrote:
> On Sun, 18 Oct 2026 at 09:26, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > +               __virtio16 __user *uaddr = ivec.iov.iovec[0].iov_base;
> > +
> > +               if (!access_ok(uaddr, sizeof(*p)))
> > +                       return -EFAULT;
> > +               ret = __get_user(tmp, uaddr);
> 
> You should never use __get_user() in the first place. It is almost
> always just a bug.

Right, I was thinking of some other code. This one should just be
get_user.

> And __get_user() together with access_ok() is actively wrong and
> stupid. It's slower, bigger, and more bug-prone than just using
> "get_user()".
> 
> The *only* reason ever to use __get_user() is in very very iffy code
> that might use a kernel pointer and doesn't want the access_ok() code.
> 
> Or old legacy code from the last century when __get_user() was faster
> and was inlined.
> 
>                Linus

