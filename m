Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE642283682
	for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 16:15:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760976939; cv=none; b=ALaisHWF3wKLLGjf0FAYJhWFm/DBq+VQMKNswbRoeYp79dd1tgAs83AMWSeMjx9yJOblC3/Mo0viNsRX5vJd8k2lvIQWsU6w/s1dOwd8NLdOOVMEwtxsMZMD3SGSyYytSevMapqS14hq9s9zC1SPasvKxq0B0b+vrDmNO9WGIcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760976939; c=relaxed/simple;
	bh=cPmhMPpHMf9OZXvBCKCLmUgibMzQ5xtsqijFgeLuud0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 In-Reply-To:Content-Type:Content-Disposition; b=ohR5RNZGm+M+rUHDQhxOZVyehXL9828iEEJSJItvtpdO9RaXtYiLNbb7tmUiCV4zBEQt28aRYjpuihE8sdoStFJ1gPvv7yWXqq7bSBZixcNl45aT+5Cotn+NmYqUujoyaFNg6K0wCdl2G7UPNMu2jF8F6F4ioi9kVlFjsCjK5pU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ZduYuoqf; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZduYuoqf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1760976936;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=BJxplQWUUgvPACnS8sqBaCwMVjdrCjqo1EJhgx6jkt8=;
	b=ZduYuoqflTNWG2tl0Iz0mBd5O8RuSR+aC3BK0pFDHRKeYkeB6cp3qxzWEJMsRFbhI9lWWS
	rAukJcdmcBIbuXgA7h+ppk19Nj1/VbRK3mVQFUGa7xK9ZlnNNonRBXXFhLHg/M82DyTIAF
	efulfUOOLuaPfklTr2c8sJBzuv6ts3s=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-546-cY663hS2Nsayw1uJVxsYjg-1; Mon, 20 Oct 2025 12:15:35 -0400
X-MC-Unique: cY663hS2Nsayw1uJVxsYjg-1
X-Mimecast-MFC-AGG-ID: cY663hS2Nsayw1uJVxsYjg_1760976934
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46b303f6c9cso52948155e9.2
        for <virtualization@lists.linux.dev>; Mon, 20 Oct 2025 09:15:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760976934; x=1761581734;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BJxplQWUUgvPACnS8sqBaCwMVjdrCjqo1EJhgx6jkt8=;
        b=SAoFxuBQ1ojN9bDzsMG8tMAtYwb8d8TEgPWidk79rBLDKbYbFMng7iJhF22RcSJG24
         iZsxIEK7xSrevDIYuMZswOJnlAvhuWJ1mVgAbyWn1KUt4p4Ipf7DdNGhwoLWKzRUEwNH
         7OPHDUUSr+e3fvmN247Az1Zyx6SizbnemqqfbNPLttXXhyCrCdMZBXfP2K9uSXFFM2Sj
         KNC7NQhtQydNTszgxR4EMR7gk7e4GfTIjc80fSnvgf1NJU85Z3upDk+A9w0SgRRxLe2X
         jFDL5M+UvcgmCTT9avX1XlhiwzX6DtqYY0onYntmquwZ7AZrpjelzYGyCEHs3eylGrU0
         pOPg==
X-Forwarded-Encrypted: i=1; AJvYcCW+ytIJ1bR2aWsDUZbcjzbixCa9fsoc5TXJJuO/vzz6noPnpjGnpPyxYBbsQCh+LIQal9/fVF2dYLzaWMK6ug==@lists.linux.dev
X-Gm-Message-State: AOJu0YwGJ6wnTfy3lRdxgWTC9r+mH29rRmaPTirze1qr35gpPdXcUJgr
	HRM+l2RWbfXrv+GWQbPphI/qO5TMK65vZK7Sc46UBIBb+Xprl8NBM1GXLHU5wkwg/Sftg3T7du4
	AyFh943YLZVkiFg07dGdz/yUWTo0saGBStB/DxTRvK9j0AZrodXpt+13OZ/smeJ4oW7Zc
X-Gm-Gg: ASbGncuoy76nxKujC94zUDQuX4xFnNMRbEJOwSIbD94jaetb7WHeoQ4cwfGqJ23CQLk
	xTa3RFOeBTHrFDn5JPU3/opqBS965Uy8Pwltib/FoJpbGdkKeYdO/Z6DYU+qt6PgsWyRPy7pSjj
	7EK2411zgXskUctVZ8ACQ+LmZFeHQb0aE4LSQBLCVVS5tZ4rAB/V4jLPXlt69/GE21NpxwY3Gkv
	eClcgz0UbMGlKIgj6zSC0IyucA9wLgkFpjaNAOg6VgpfHnU0jVwc9WNWOvtF2idqzXOhxKRkmW5
	tBI3E4vwwjbSL91pREYJfrrX2/D9zw/ssQS8jEvgr0kkAlL9CeT5wJkSqcHVNaZ/Ob6W
X-Received: by 2002:a05:600c:540c:b0:46e:46c8:edac with SMTP id 5b1f17b1804b1-471178a6f9emr90894805e9.11.1760976934208;
        Mon, 20 Oct 2025 09:15:34 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGfD1sVXteUr24GtFdMBM0eLxjgwGriWkSrDglWOuWS3Nl4AUBUsgwyoowFrJaYLNlrtXxv8g==
X-Received: by 2002:a05:600c:540c:b0:46e:46c8:edac with SMTP id 5b1f17b1804b1-471178a6f9emr90893495e9.11.1760976931307;
        Mon, 20 Oct 2025 09:15:31 -0700 (PDT)
Received: from redhat.com ([2a0d:6fc0:152d:b200:2a90:8f13:7c1e:f479])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-427ea5a0e9csm16201513f8f.5.2025.10.20.09.15.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Oct 2025 09:15:30 -0700 (PDT)
Date: Mon, 20 Oct 2025 12:15:28 -0400
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Jason Wang <jasowang@redhat.com>
Cc: xuanzhuo@linux.alibaba.com, eperezma@redhat.com,
	virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH V8 12/19] virtio_ring: switch to use unsigned int for
 virtqueue_poll_packed()
Message-ID: <20251020121235-mutt-send-email-mst@kernel.org>
References: <20251020071003.28834-1-jasowang@redhat.com>
 <20251020071003.28834-13-jasowang@redhat.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
In-Reply-To: <20251020071003.28834-13-jasowang@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: 3-lNqkLr4g3SoRj3wrgBCjm85sQBcc4zBd0dbXJlw4o_1760976934
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Oct 20, 2025 at 03:09:56PM +0800, Jason Wang wrote:
> Switch to use unsigned int for virtqueue_poll_packed() to match
> virtqueue_poll() and virtqueue_poll_split() and ease

and to ease

> the abstraction
> the virtqueue ops.

of the virtqueue ops


> 
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
>  drivers/virtio/virtio_ring.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 58c03a8aab85..73dcc6984e33 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -1699,7 +1699,8 @@ static inline bool is_used_desc_packed(const struct vring_virtqueue *vq,
>  	return avail == used && used == used_wrap_counter;
>  }
>  
> -static bool virtqueue_poll_packed(const struct vring_virtqueue *vq, u16 off_wrap)
> +static bool virtqueue_poll_packed(const struct vring_virtqueue *vq,
> +				  unsigned int off_wrap)
>  {
>  	bool wrap_counter;
>  	u16 used_idx;
> -- 
> 2.31.1

