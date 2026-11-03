Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=170.10.129.124
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793705615;
	b=HMjyWnqQz/PxfhoUbL09rwTNiUTWqOhWOpx9HIovfNxvaeyUxbZHw9dhQHBWhP/QK8CL
	 UlGgZqS5/+BLMK8RciZjjZZCcIQJ3dIowBt8yAYo9x0Ay/URnkrwWWaQfmArMl9rVnFUL
	 TiCsl24mtW+EuQ9T2PRtEDae/p0i2DWnCcO+zATbzH+rFOw/y5W8s/jsrLw+ARpkgeb4A
	 Vpb8RGU4ik84i5tCha6dOE1s/RXO1UPy16zO/qoLdsrL6AA70AnOJYBsJF7vJSeClV2HO
	 5pwlt17KR3xkwXBvLW1cnSUViTxgDH1pBXk1RDRCyKBNVsc31BM+iIOikWqzCRAqn6w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793705615;
	h=DMARC-Filter:DKIM-Signature:Received:X-MC-Unique:
	 X-Mimecast-MFC-AGG-ID:Received:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:
	 X-Received:Received:Date:From:To:Cc:Subject:Message-ID:References:
	 MIME-Version:In-Reply-To:X-Mimecast-Spam-Score:X-Mimecast-MFC-PROC-ID:
	 X-Mimecast-Originator:Content-Type:Content-Disposition;
	bh=m0qyUESMc56kSUhZkAax4TSYZKgGyd+m6l8qEmY93H0=;
	b=k7deBX0DHxQd01EHXZJLQTbQBGWUnJETQbnPybUm0UkMd8k9CBStSHHwcnmQZLCYNlQD
	 4FCDZNyDsSlqrOVaObA6FCcDM0AGVMtuISwWMGIQpP9vSqUCqksuPwG25Xho2EUavab4w
	 2vEfWXQPfZkR5dcWiBnl8UcH4EupCHeNNjnl0Aly2wgQdN4LJs3/UDSZsZpL/tfju8o9Y
	 eiX6+JiS+DLqzQAjh2aBEs/0DPNjbhC0RWQ0jaSBMkSiPjBJQ0lBRtV89COvl2dpxp3oe
	 ftb7nhoRASw86JMAqz7Wi4FYWzN81Sejw1rvWRqinFXkWLvRdQrMVVYPlAwm5oGZ9ng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=redhat.com;
	spf=pass smtp.mailfrom=redhat.com;
	dkim=pass header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DGX2Qzx8;
	arc=none smtp.remote-ip=170.10.129.124
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21D61606A326
	for <virtualization@lists.linux.dev>; Tue,  3 Nov 2026 11:33:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 21D61606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=DGX2Qzx8
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1793705614;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=m0qyUESMc56kSUhZkAax4TSYZKgGyd+m6l8qEmY93H0=;
	b=DGX2Qzx8TZPQV0DqKuZTKsJ3Wwz039C4uWPBMwRbb3w1A1GnNTq7uOIaWwJ5qyEoeFRkiK
	L0QYZ8raD14EBMi7SD9U1mAAA4vUBhdEgaXWZJhj3Y54lfWb10OBtnyEqtNMmJ6bL60f8/
	nBmdukyvYdGbcAa+dfvOMLUPR9ghtYw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-637-YEVVUJ5EObGY0MqZQznokg-1; Tue, 03 Nov 2026 06:33:32 -0500
X-MC-Unique: YEVVUJ5EObGY0MqZQznokg-1
X-Mimecast-MFC-AGG-ID: YEVVUJ5EObGY0MqZQznokg_1793705612
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-48dff112181so3591562f8f.3
        for <virtualization@lists.linux.dev>; Tue, 03 Nov 2026 03:33:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793705612; x=1794310412;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=m0qyUESMc56kSUhZkAax4TSYZKgGyd+m6l8qEmY93H0=;
        b=Vf2WNT/azroAvgEEdvB/Tlulp9T379WZlsN2wjP95mSFWNR0OfE7Zv1JwVuh3sWaxI
         190LRh/x3uKT5MGvU4By5muCFs0nOlButqxMbjXH+hYg20V5BXOKsA35nnjDq7LIZjzf
         lGmk3kSxYARKC4QrjDEUZ9HEgcK1SSqVS+sSj/ctSqYu4wJxV2oFw61Mo8mdFPg4JDeC
         jp0afjnvHxtYj4ssnHjIXxEXpqds2JApS6LMb+q1pPVI1o3s97M9c2eM9asOG/Vc70n6
         MRw+cTqS+61NjqClVSKKIcdgQpMLd4XHKi9D14j8pZDLsJECHY1Rm45ph3OeBerg9l5q
         Jr8A==
X-Forwarded-Encrypted: i=1; AKwUvBxYakg/xXndx+3LsizBjVmuKm4kUPWVOvb0UWBY+INs68raEj6oCBsNDl+v8N0kLePdJjV7uXk7QGtXcW7AWg==@lists.linux.dev
X-Gm-Message-State: APuU4Z8i1tLJsX3bVLUOYKl9kR+64EHzouikt5ByBWCtGWn9fGm+/6Ua
	PLeM+1wW+121PwonU+ROpnhSzMtnincMlU5j78KXu2liCnFayZzFB1IWpUXZgxDO2hd2b5xQ+7k
	nflgTc59tDrLpD8Rlq/p9hIH/lx55bt9qY0ElSaXGOr709tkHgbp9a8ysBHCsgU6e7gYud7z+9w
	kw
X-Gm-Gg: AYBFou1/wUPpGie9bDhHmXkl6U08NBiOwDGRhDPAMRtDQfm4u6f7RZo7kAj9t8U+Z3g
	mMEYNoCksnCyjxoO5Bk8o27YN11tgg1PqCPAk/NHA5emOPO6IhPH7THykgRlHdRYnULYwdDhk5L
	2Q/CZetF5T0SdH+KLWTNS64yyTuorpiCVmteyAcIbgMekVoEXNHrEmK0O/u8h/D2pjvsgDoP4A1
	mgUn/lHj3iN7G+revKloqRZxDBA++P244PjTS/3P4ZVVemjNP8m7BxqGwtmvNlVWq/9nRdb3c3s
	kuSDQsKhOdtjL7b7f/uLsX/o+6e2bLx3/f8vcoi9upDpSEvpZCD5RnU7s/3L4TPdX7JOscIdK7d
	bJoNQG9rqIQ3j3Moava8TinBBGZwchmsXsaR8WZ63PQ==
X-Received: by 2002:a05:600c:4e12:b0:4a2:a9:ed87 with SMTP id 5b1f17b1804b1-4ac1765cf2cmr304324185e9.19.1793705611600;
        Tue, 03 Nov 2026 03:33:31 -0800 (PST)
X-Received: by 2002:a05:600c:4e12:b0:4a2:a9:ed87 with SMTP id 5b1f17b1804b1-4ac1765cf2cmr304323575e9.19.1793705611091;
        Tue, 03 Nov 2026 03:33:31 -0800 (PST)
Received: from redhat.com ([2a0d:6fc0:1506:fd00:9e19:9994:44b1:e6f2])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4b2a93232f0sm51757025e9.10.2026.11.03.03.33.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Nov 2026 03:33:30 -0800 (PST)
Date: Tue, 3 Nov 2026 06:33:27 -0500
From: "Michael S. Tsirkin" <mst@redhat.com>
To: Guanglei Zhu <zhugl3@xiaopeng.com>
Cc: amit@kernel.org, virtualization@lists.linux.dev,
	linux-kernel@vger.kernel.org, liuc63@xiaopeng.com
Subject: Re: [PATCH] virtio: console: check the control packet size before
 parsing it
Message-ID: <20261103062747-mutt-send-email-mst@kernel.org>
References: <20261103043238-mutt-send-email-mst@kernel.org>
 <20261103111734.472283-1-zhugl3@xiaopeng.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
In-Reply-To: <20261103111734.472283-1-zhugl3@xiaopeng.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: gN3lS5HCOdjC_y7L7DzXl1OAZBVIAgLvhf-HVflAJMU_1793705612
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Nov 03, 2026 at 07:17:34PM +0800, Guanglei Zhu wrote:
> You are right, the impact statement does not hold up: the reused
> buffer still contains a previously valid control message,

Not always, the buffers are allocated with GFP_KERNEL on the
1st pass.

> so a short
> packet makes the driver parse stale - not attacker-controlled - data,

Who is the attacker here the device? it is absolutely
controlling all of virtio_console_control.

> and that is not worth carrying an extra check for.  Please drop this
> patch.
> 
> Sorry for the noise, and thanks for the review.

I ask that you please think critically not just go back and forth on it
like an LLM.

-- 
MST

