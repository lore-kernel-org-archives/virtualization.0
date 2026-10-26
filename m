Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.133.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793030447;
	b=VJZ/1I0akMtbVLiix2Y/bDOWwF7XvBnCXnHLZqT656Pd4R5Y/x8rbGFKDsl2S6+cIftu
	 f8dAOcXq74vC09FhKcDS0Ge7uebAghIOsLh+7HdWpbOzgH9BX4nKgfi1m8gL6CXYAzD+l
	 SjO3YI4Pl3T/YoRaRFTkZ4zS3LJdUSsypdGFD/4MEdkMiX5bLj2KCt+3JPV1IWfHXbBmP
	 Th9ycHCLJrKKZq004yZwQGqaF26cfMPR2O00fAHR/jsBpHUe2UtKcR5eaM8EP6fA1e1z9
	 MqNV20vO6a7C9B03Mnd6/TpmkUwtpP+93fLa40ERiU7gXWPzznowq3yvBFPncqdxWMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793030447;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=gdGEMgfJnyh5c7TJH0CYOcTTMHllOethu7h0lyRTWF4=;
	b=1J5v9SsuZsG02MLxaX4gStLq6A7dM53JiRYaNPwlJBcMWUGqQdQUAyfz1FpJ6fY5anrz
	 SqW000y2hfCtT8rupXknKNp7xP4SjnpajJs+/hTVwlWrH/4QbFFw63yD/MRhCg2hYy1yP
	 /bKB8HdvgJm6a4t3ci5YrYWpo08uEvZmoPbHvEksIcdFO1sTDSwnwzuEQ9pteenfpjnpX
	 CBc3RgTKtY4Lb54OIGDlFJByb1DYAoPYLPqZmttP0r4onAGEOu9ZuLeCZcSsbW6bJaROQ
	 ZU3pESdQO30C7qyHXvlfO94lUPRBl1FiH1eZQ/CiCi3dnBtneRRsyBMM8Zze7G0bUAQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ibk3sMPt;
	arc=none smtp.remote-ip=170.10.133.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97CA1606A31D
	for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 16:00:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 97CA1606A31D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ibk3sMPt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793030445;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=gdGEMgfJnyh5c7TJH0CYOcTTMHllOethu7h0lyRTWF4=;
	b=ibk3sMPt8DljIW5kR0Yiq0+RsEK4aJLxodhN4zDfPkdKO34DSbrAnihBCZ490HNLgPqIaa
	HQ68gv6RcBPsa2Pc0TK7CfWe1GF/9BDy6IlNR3poNXu6F+6c7o9l+wtN3J5r6+BOeUoIER
	6ed/Suqep1rwWvSH7RxyBUqB0Va12Q0=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-82-mQSVOENLMiK35D0I-G__ww-1; Mon, 26 Oct 2026 12:00:44 -0400
X-MC-Unique: mQSVOENLMiK35D0I-G__ww-1
X-Mimecast-MFC-AGG-ID: mQSVOENLMiK35D0I-G__ww_1793030443
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48df5b058ddso2242487f8f.0
        for <virtualization@lists.linux.dev>; Mon, 26 Oct 2026 09:00:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793030443; x=1793635243;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=gdGEMgfJnyh5c7TJH0CYOcTTMHllOethu7h0lyRTWF4=;
        b=mdkcs13BC+qV1voE6ifcUK1tw9eFhW2GgskdKgNEkq7hZGrPdTIRUOaRR+kxsiQw3Y
         xlioUBK9z8z+ztQ1CRJwpvjtuj27A4Vn+GOa2GtGvM0psNbvKxM3z+cniEwY/wlR7YQ8
         lpMoSc2ySvauvR4zDmM1yXEi2CMONnLGhIs3+nKHW3X2PN/fnAp4lLwPc/ffnQNwx+Ig
         JM+xuyIi+cW4ffNQhrWVqn6kSbSLISDLYHQyh81noDQBqzuA+nKy6jW2DlrNrc6VVSqA
         LBeREU66tsscc2XY3Fvy45HDDfIyK8FvzweeTt0NpgfyRoUeDJCiAIiIGv+tkx0cgaae
         5Ypw==
X-Forwarded-Encrypted: i=1; AKwUvBzwiaXcUlMHBfDiB72qqHdm9jhyOH3ByoPeRGUFWRgiafm11QYcb6IgnEQtArDERV+Bav9Jw3GDb1tvQwmXtA==@lists.linux.dev
X-Gm-Message-State: AFq9FYLGdZkOl/P27eOKtp1liCUGJBVUDjmXigWXgDCQ8Dp0HNL2ub7H
	YueSamkggwTKlzC4QdxZRa83S9BDmHijIrrcrOs8+KSYgj0Za/BGek1b3EIcLPOnuz8K268K0a+
	EHnXcxWzSEOc/YDrOhkcyjfb5QAbCDRSnraHl8bBFvV1O7DUEvRGVd2QLj9itxpJYuL7c
X-Gm-Gg: AYBFou2itD82eCDnXEsaSfKg9Guz5kyxhGM7lXrc81RLp2TtSJDRlEeMW+WNm6xcd7q
	hPe2MTSMRE+8CDL/nBekEFwPyfTHgz3+0O/5MPNYN7DjiVjLgPHzE/ugxcHrvIZmOoiSKo64lOc
	0+Ohe4ABV+wbu/fZRWG4XD7IWejfXizWB+78wrMMfVHNKJG279wWbBiYIKBhv8gQGRv6aN4IDII
	4eVCmT7LjEHP/ZUi+HLrdGZnc+4PJeGonryf4q8HI4G0rvL1IsoIeUG6nwZvZCKqwwaM3biPiTm
	xD+JoOByzYije/PS2kFSTw4s1s4HUpJEbilmf0zRNy6pDX6y0Kqq9cp4rF9NGl01UlQ=
X-Received: by 2002:a05:6000:160d:b0:48e:35d4:55b5 with SMTP id ffacd0b85a97d-48e545bcbe7mr1461296f8f.52.1793030442385;
        Mon, 26 Oct 2026 09:00:42 -0700 (PDT)
X-Received: by 2002:a05:6000:160d:b0:48e:35d4:55b5 with SMTP id ffacd0b85a97d-48e545bcbe7mr1461218f8f.52.1793030441486;
        Mon, 26 Oct 2026 09:00:41 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:1536:fc00:b838:383:1c7:6e81])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebcb958sm17511497f8f.21.2026.10.26.09.00.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 09:00:40 -0700 (PDT)
Date: Mon, 26 Oct 2026 12:00:37 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: linux-kernel@vger.kernel.org
Cc: Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	Eugenio =?iso-8859-1?Q?P=E9rez?= <eperezma@redhat.com>,
	virtualization@lists.linux.dev, Ruben Hakobyan <hruben@meta.com>,
	David Hildenbrand <david@kernel.org>,
	Miguel Ojeda <ojeda@kernel.org>, Boqun Feng <boqun@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH 2/2] virtio_balloon: submit reported pages as individual
 buffers
Message-ID: <20261026120022-mutt-send-email-mst@kernel.org>
References: <ad6a530f49c4a0e182112a73789e31b5e91f3bb7.1793026707.git.mst@redhat.com>
 <6668d51dbda117d05d2eddd47db6ad69baab8b0c.1793026707.git.mst@redhat.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <6668d51dbda117d05d2eddd47db6ad69baab8b0c.1793026707.git.mst@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: eqE1QgiD7Tq8Opzs2oEERLYoQ_xOgbhwmstoZv19AEk_1793030443
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 26, 2026 at 11:09:59AM -0400, Michael S. Tsirkin wrote:
> The virtio_balloon driver reports a scatter-gather list of free pages
> to the VMM so it may discard unused pages.
> 
> For an arm64 kernel with 64 KiB pages, the default reporting and
> allocation orders allow entries ranging from 2 MiB to 512 MiB. If the
> report contains a sufficient number of large entries, we will end up
> with a descriptor chain that represents over 4 GiB of memory. This
> violates virtio spec, which says:
> 	Drivers MUST NOT add a descriptor chain longer than $2^{32}$ bytes in total;
> 
> Specifically, submitting $2^{32}$ or more breaks Rust-VMM.
> 
> Submit each reported page as a separate virtqueue buffer instead of one
> buffer with an sg list of all pages.  This also avoids indirect
> descriptor allocation (kmalloc in the reporting path).
> 
> To avoid multiple buffers causing interrupt storms, keep callbacks
> disabled while we wait for an event.
> 
> Note: if the virtqueue is broken, wait_event on
> virtqueue_get_buf hangs.  This is a pre-existing issue:
> the old single-buffer code had the same hang.
> 
> Reported-by: Ruben Hakobyan <hruben@meta.com>
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>

brown paperbag post,forgot to commit.

> ---
> 
> Lightly tested. Ruben, could you pls help test?
> 
>  drivers/virtio/virtio_balloon.c | 48 ++++++++++++++++++++++++---------
>  1 file changed, 35 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/virtio/virtio_balloon.c b/drivers/virtio/virtio_balloon.c
> index f6c2dff33f8a..363519fa890d 100644
> --- a/drivers/virtio/virtio_balloon.c
> +++ b/drivers/virtio/virtio_balloon.c
> @@ -202,25 +202,47 @@ static int virtballoon_free_page_report(struct page_reporting_dev_info *pr_dev_i
>  	struct virtio_balloon *vb =
>  		container_of(pr_dev_info, struct virtio_balloon, pr_dev_info);
>  	struct virtqueue *vq = vb->reporting_vq;
> -	unsigned int unused, err;
> +	unsigned int i, err = 0;
>  
>  	/* We should always be able to add these buffers to an empty queue. */
> -	err = virtqueue_add_inbuf(vq, sg, nents, vb, GFP_NOWAIT);
> +	for (i = 0; i < nents; i++) {
> +		struct scatterlist one;
>  
> -	/*
> -	 * In the extremely unlikely case that something has occurred and we
> -	 * are able to trigger an error we will simply display a warning
> -	 * and exit without actually processing the pages.
> -	 */
> -	if (WARN_ON_ONCE(err))
> -		return err;
> +		sg_init_table(&one, 1);
> +		sg_set_page(&one, sg_page(&sg[i]), sg[i].length,
> +			    sg[i].offset);
> +		err = virtqueue_add_inbuf(vq, &one, 1, &sg[i], GFP_NOWAIT);
>  
> -	virtqueue_kick(vq);
> +		/*
> +		 * In the extremely unlikely case that something has occurred
> +		 * and we are able to trigger an error we will simply display
> +		 * a warning and exit without actually processing the pages.
> +		 */
> +		if (WARN_ON_ONCE(err)) {
> +			nents = i;
> +			break;
> +		}
> +	}
>  
> -	/* When host has read buffer, this completes via balloon_ack */
> -	wait_event(vb->acked, virtqueue_get_buf(vq, &unused));
> +	if (nents) {
> +		virtqueue_kick(vq);
>  
> -	return 0;
> +		/* When host has read buffer, this completes via balloon_ack.
> +		 * We report pages as individual buffers, so arm the callback
> +		 * to only interrupt once all the queued buffers have been
> +		 * used: otherwise we would get one interrupt per page.
> +		 */
> +		for (i = 0; i < nents; i++) {
> +			unsigned int unused;
> +
> +			virtqueue_enable_cb_delayed_max(vq);
> +			wait_event(vb->acked,
> +				   virtqueue_get_buf(vq, &unused));
> +			virtqueue_disable_cb(vq);
> +		}
> +	}
> +
> +	return err;
>  }
>  
>  static void set_page_pfns(struct virtio_balloon *vb,
> -- 
> MST
> 

