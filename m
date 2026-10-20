Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792481257;
	b=29ZR0xwyzvwPi8vj+LbqY5VfyiQffJM7FmwUncBBSuap5YcDnhrukekOt62KNzvV7p7s
	 J/HmUp946s3nW0ow4FHbS2exvYGhYAccRQB5+Xwc77argNJrCIZCbCu/oc4wbYIHPH3G1
	 AWURIC1pfnzj+HQbKjkV6jDtiVnwquRVtEOKCll5WrclwgDeOS83jPDFs0APX9ONjP1FZ
	 b4pZMb/cbOkxUAxkav5h49j911Ntpu07ZNX1eo6cZ0v1LIuNGhXVBSzJskCRS23mLiaVh
	 TLJiwtRZ5/y3OOzpyBh3vMkkgaSa3XzXiIoWQncw4hzTJgVkdlGHtPYrNT6Ibrdy1DA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792481257;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=D7VUKLyWmSTuNvyPZCaInGeXEgxZCqef2mwHv3QbNDQ=;
	b=D1TQMnmjeWpi0KzJa3dTkeBRtMRzNsSLw3goc4P0S2m5jFBkudg/bQDqd5vEyFf7gWoY
	 LS07luhrTHTyN8dCAHPy4cj6nuUf2ba1CQHUGp1e8xRf8URo/I+brrIqnEg7a1z/sZRXv
	 2tckLi5TRDceAbYKe2BlHgTxm82/h95OCriZ9j+Vlm9xyqjUyJ9QYBmLKDW6W4RG0hDQm
	 UK2siGbMqzgXvmTnHrFUyx2hW+RDNkRq7M4vxxlaWkIPOwUJwsSG/OptZPmdcqedt3jy0
	 t8frLXJvmAvVPLWm/+l1JjgXNgFugI0L92Leyax+cOKqbldOrpx++nz88TIZDgagYMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FYD5oAto;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2B28606A33A
	for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 07:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2B28606A33A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=FYD5oAto
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1792481255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=D7VUKLyWmSTuNvyPZCaInGeXEgxZCqef2mwHv3QbNDQ=;
	b=FYD5oAtoFSspugtKabwEumtICqFmOUXlN+BVkrPvkOHtXqIRPFnIMx7tjFweGSmlNyLQYc
	8Wf0+k0r+E42e46gn095oFPMoZ8w/3zRjrxV0jYO3S7e95hge+OD7ufUnMOELy3n57fAZP
	APSLMpFrGqLyrjHdkM9/QtlUsK2RCjA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-618-8PBF8tthP9yCHYmfY8rY1w-1; Tue, 20 Oct 2026 07:27:34 +0000
X-MC-Unique: 8PBF8tthP9yCHYmfY8rY1w-1
X-Mimecast-MFC-AGG-ID: 8PBF8tthP9yCHYmfY8rY1w_1792481253
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-4a1e489f97fso18349655e9.0
        for <virtualization@lists.linux.dev>; Tue, 20 Oct 2026 00:27:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792481253; x=1793086053;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D7VUKLyWmSTuNvyPZCaInGeXEgxZCqef2mwHv3QbNDQ=;
        b=NokcxQJORSumz3aPZeDPSX7i6edSqB1/8tGbIr4Vg59RQkl028LBDaC1d5f9LJpu36
         qb4rfvXwnI/N/SHRZHId6G7Eu30McpjDHgrA4h+3crsYubRjOweGK8jUrTBSAstis8uL
         0/ZY1GBVr4vn3/Is16ykvVVa+By7RPKLJxn8K5D+7lHTm/GVV12zx6h4TTfdS3XdRfMA
         UvC1memjRoC0ffsOJF3U/h36BI6yGAc/h5z60eUZudW3fY21pnuTBiNP0eBNGLGkf8kX
         ocC9FWXDox8RA4fdgBSkkccgCJvdOMAzl5K3HxKp8zjlshjDKHD8ENlIuo3gnfkGsnCG
         g29w==
X-Forwarded-Encrypted: i=1; AKwUvByJ8HkMnunnnwCOGZV9MQZI4ke0EJPy75f2BTSn6+uw+3zOliZYGIK2Yyw//o4bScUI8L3wkSCYDTfLJGx+iQ==@lists.linux.dev
X-Gm-Message-State: AFq9FYKhZHirPZS21T6t/GD7BD5FMn4D7DlgAIy13XiIS5jPEpLJSd1b
	igumt2yln58mlR8g8bNeGdfRoNnzzcMNW/yYdizZ+510mjiOEdzewkuJobs7FnKAgQkhz3NnMAQ
	Y61hNet5gVm/qoBgYidsf4XW0gZkatrjsYLykyLuVRnuLVgQkFqNG75+zkRpOkYWTLR+AY6TBJ4
	4R
X-Gm-Gg: AYBFou3YJxLANhx/6lATtwEP53PwuW3pdzrJd+QkWYtV2EVW1Z/3PfQVE6DeDn0euFH
	OS5Tp4XtNAH3g3JkhTtvlokbDIROkfV/DqwG6Frk2IVFgZo/e6Exr/4h+x3IkaLX1owRL+VM16+
	G5ifdr9/UaBpFh3P/eg+VqtKtPuqRGP3ixssgs3er3Sq1G4NXUzMhxWQddtqnl4kYt0uK5Uobe+
	ceFlTKUBBo9J/FlRSjxwOvTqBNfipyIdwx8bWLS9bj+iJIAJ+8KeFdsgXB7FXvLzveYskGxQbkr
	1ft8fCN/WGzmvUM7jlsXYc7kB5NogdBNeCym9B2EePjDvc9JoKcgcje4wQk70cHycCWDwA==
X-Received: by 2002:a05:600c:3b22:b0:4a1:7690:d878 with SMTP id 5b1f17b1804b1-4a1d7615cb9mr212725735e9.17.1792481252768;
        Tue, 20 Oct 2026 00:27:32 -0700 (PDT)
X-Received: by 2002:a05:600c:3b22:b0:4a1:7690:d878 with SMTP id 5b1f17b1804b1-4a1d7615cb9mr212725125e9.17.1792481252104;
        Tue, 20 Oct 2026 00:27:32 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:3fd7:5300:3d6b:52a4:a23f:9d0b])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1f2cb8d5csm54348855e9.6.2026.10.20.00.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 20 Oct 2026 00:27:31 -0700 (PDT)
Date: Tue, 20 Oct 2026 03:27:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Linus Torvalds <torvalds@linuxfoundation.org>
Cc: Wang Haoran <haoranwangsec@gmail.com>, jasowangio@gmail.com,
	kvm@vger.kernel.org, virtualization@lists.linux.dev,
	netdev@vger.kernel.org, eperezma@redhat.com
Subject: Re: [BUG] vhost/vringh: __get_user without access_ok leaks kernel
 memory via vDPA passthrough
Message-ID: <20261020032524-mutt-send-email-mst@kernel.org>
References: <6ad07f8a.a0c71a5e.2d2efd.977a@mx.google.com>
 <20261018152358-mutt-send-email-mst@kernel.org>
 <CAHk-=wiUn9EbV4TJ4J7OPY0fVc3UC+xb-pp=+rg3hRc4jQqihg@mail.gmail.com>
 <20261018174250-mutt-send-email-mst@kernel.org>
 <376ef9d0-b03f-4f85-aee5-46cf20eb00ae@gmail.com>
 <20261020021924-mutt-send-email-mst@kernel.org>
 <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <CAHk-=wjxtzD1TXZr5iWu0p1+Hu0YZP7jbNSwFkp7AJYmhzhVCA@mail.gmail.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 9NxQIDJ8_dHyN7zy_r4B8AxsgeE-eQ5HDeB28VAsBaw_1792481253
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 19, 2026 at 08:51:43PM -1000, Linus Torvalds wrote:
> On Mon, 19 Oct 2026 at 20:31, Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > The following seems to work for me. Testing would be appreciated.
> 
> I have a whole branch that removes __get_user() and __put_user() entirely.
> 
> Somebody should check that I did it right. But I didn't want to do the
> pagefault_disable() around the vringh_notify() part, so it's not quite
> the same as yours.
> 
> Let me just push it out. I was going to let it simmer, but your email
> made me go "I should just let more people look at it".
> 
> Mind taking a look at the 'uaccess-cleanups' branch?

At the virtio things there? Sure, 'bit later.

> It builds for me. That's all the testing it has gotten so far. Blush.
> 
>                    Linus

I can help with that.

