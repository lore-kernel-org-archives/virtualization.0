Received: from mail-il1-f179.google.com (mail-il1-f179.google.com [209.85.166.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A48B224E8
	for <virtualization@lists.linux.dev>; Thu, 25 Jan 2024 15:33:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706196788; cv=none; b=Mq3bSwF9x3Job5TWzOOzr39l0iAXZjNEFdGY6cMd43KryprWhdWT1P47Am9S2SDgVo4w4e3sBvbvOFQtIDYL3V4QMK2sXzLjLXj02uahLp1ic5Wg7UOz5RRrPrW68oFWWxaRI6RCcJ9LiARocypTUTRVQyA0TFApZwRbIhgdP4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706196788; c=relaxed/simple;
	bh=s5NTtDSXR8T9HdgsJfOs23zILbtqhIJcem+N3YvEIWw=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=c8rusqviGZFY+YeqDz+Fzuqn9c1hDkdqqPJCXzNaJey7rW1sNPC7mkTCkSLn8SnbFWO3JHl3M2UUR9nxornSOTwld+bmbqJf8XfgvBq0CgAJT90hQycJoDl9ukwhPT91HXdb7BKAYkXUUkctAwVOJz6Exm+mXDBL87mQNrIHuOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk; spf=pass smtp.mailfrom=kernel.dk; dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b=rzwu8AHB; arc=none smtp.client-ip=209.85.166.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kernel.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kernel.dk
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel-dk.20230601.gappssmtp.com header.i=@kernel-dk.20230601.gappssmtp.com header.b="rzwu8AHB"
Received: by mail-il1-f179.google.com with SMTP id e9e14a558f8ab-35d374bebe3so1106095ab.1
        for <virtualization@lists.linux.dev>; Thu, 25 Jan 2024 07:33:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1706196785; x=1706801585; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fRlgrjNnbSZj8pV0gjcviWY4T1PIUGSkee+euAfm/PQ=;
        b=rzwu8AHB7EnMDNyAGybrVxIr+0ACTWDbJvIgTtwstG3ZzrohildTD+VcpgTV2tBl/l
         G3vTTZ8RhuLXS9Fopi67SFnXfGRlfulym17mv4QG50+2FlAEJU5pFclm6MHCMUThrftt
         w+vPx3nP7/++jyrYpKlE0diAgm9eAQyvO99GXVKUQ5G+m7CsAUNPcBPMd89Q6z5Cbh9T
         3X8ok0RjoNRXjo64/9veyJX33R6S/KYofZVneugleqaEyu07MwiINPPfN4WGcUTUEdvh
         /XyDjvpT8yRUhW+jVgTzpG8J6rclZgDDPP1lGxkRnY+wgVGX+qxKG8bCG1o+ShX+acNc
         fgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706196785; x=1706801585;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fRlgrjNnbSZj8pV0gjcviWY4T1PIUGSkee+euAfm/PQ=;
        b=WVmWVHSzpjYSlrIPayjDxaqlMtc8q9onVPI/cminxuHsrbSCP8gsqI0JXTa8hkMsAr
         QEn7ES9YIg9HPbs1+oqJ1uJNg99Gf9ZyVKIRN5/wSt9Ob/I4+vXXluW+o2zgK30aE7Dt
         I0FDD3mlxMji+BYXNlwP6h9tXcOfIGEgYPTPw3W3tA16dBT6PEcq6UoIvM7KVL8EIfxY
         3ov6bw4bSQUAtxxW0yuM4tzTGRklHUZEc4fWfKdCjAvXs1psOdCtISTiikC4DQewmwre
         gcMNOfcPYCVZW7w0znlYkcdEdlTOWGb3cVhyLGaL00fSKwi+4xRTiKttYFGmAmCKvFRS
         bf+w==
X-Gm-Message-State: AOJu0YxkhDBtTdjBv42RAx0MByRgnvL8k+a+b0hGXihm32ru48Yr8Jnz
	T9b5RgCwJv9ihggHUmYgn9Z/RSl4U2a/bP9lVeWm66KMtU/+hfh9t32xN45BkHM=
X-Google-Smtp-Source: AGHT+IEPDP4wlMUesm3T6swHGmmcjQRDschl7iPCjHlqz6YnohGuMWD6YQvhySNTMCgUMUqtlAouVw==
X-Received: by 2002:a92:cd83:0:b0:361:9667:9390 with SMTP id r3-20020a92cd83000000b0036196679390mr2591825ilb.1.1706196785198;
        Thu, 25 Jan 2024 07:33:05 -0800 (PST)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id y18-20020a056e020f5200b00361a70e112asm4860771ilj.59.2024.01.25.07.33.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jan 2024 07:33:04 -0800 (PST)
Message-ID: <1872ae0a-6ba6-45f5-9f3d-8451ce06eb14@kernel.dk>
Date: Thu, 25 Jan 2024 08:33:03 -0700
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Report] requests are submitted to hardware in reverse order from
 nvme/virtio-blk queue_rqs()
Content-Language: en-US
To: Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org
References: <ZbD7ups50ryrlJ/G@fedora>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <ZbD7ups50ryrlJ/G@fedora>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 1/24/24 4:59 AM, Ming Lei wrote:
> Hello,
> 
> Requests are added to plug list in reverse order, and both virtio-blk
> and nvme retrieves request from plug list in order, so finally requests
> are submitted to hardware in reverse order via nvme_queue_rqs() or
> virtio_queue_rqs, see:
> 
> 	io_uring       submit_bio  vdb      6302096     4096
> 	io_uring       submit_bio  vdb     12235072     4096
> 	io_uring       submit_bio  vdb      7682280     4096
> 	io_uring       submit_bio  vdb     11912464     4096
> 	io_uring virtio_queue_rqs  vdb     11912464     4096
> 	io_uring virtio_queue_rqs  vdb      7682280     4096
> 	io_uring virtio_queue_rqs  vdb     12235072     4096
> 	io_uring virtio_queue_rqs  vdb      6302096     4096
> 
> 
> May this reorder be one problem for virtio-blk and nvme-pci?

This is known and has been the case for a while, that requests inside
the plug list are added to the front and we dispatch in list order
(hence getting them reversed). Not aware of any performance issues
related to that, though I have had someone being surprised by it.

It'd be trivial to just reverse the list before queue_rqs or direct
dispatch, and probably not at a huge cost as the lists will be pretty
short. See below. Or we could change the plug list to be doubly linked,
which would (I'm guessing...) likely be a higher cost. But unless this
is an actual issue, I propose we just leave it alone.


diff --git a/block/blk-mq.c b/block/blk-mq.c
index aa87fcfda1ec..ecfba42157ee 100644
--- a/block/blk-mq.c
+++ b/block/blk-mq.c
@@ -2697,6 +2697,21 @@ static blk_status_t blk_mq_request_issue_directly(struct request *rq, bool last)
 	return __blk_mq_issue_directly(hctx, rq, last);
 }
 
+static struct request *blk_plug_reverse_order(struct blk_plug *plug)
+{
+	struct request *rq = plug->mq_list, *new_head = NULL;
+
+	while (rq) {
+		struct request *tmp = rq;
+
+		rq = rq->rq_next;
+		tmp->rq_next = new_head;
+		new_head = tmp;
+	}
+
+	return new_head;
+}
+
 static void blk_mq_plug_issue_direct(struct blk_plug *plug)
 {
 	struct blk_mq_hw_ctx *hctx = NULL;
@@ -2704,6 +2719,7 @@ static void blk_mq_plug_issue_direct(struct blk_plug *plug)
 	int queued = 0;
 	blk_status_t ret = BLK_STS_OK;
 
+	plug->mq_list = blk_plug_reverse_order(plug);
 	while ((rq = rq_list_pop(&plug->mq_list))) {
 		bool last = rq_list_empty(plug->mq_list);
 
@@ -2741,6 +2757,7 @@ static void __blk_mq_flush_plug_list(struct request_queue *q,
 {
 	if (blk_queue_quiesced(q))
 		return;
+	plug->mq_list = blk_plug_reverse_order(plug);
 	q->mq_ops->queue_rqs(&plug->mq_list);
 }
 

-- 
Jens Axboe

