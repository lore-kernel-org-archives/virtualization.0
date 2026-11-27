Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795785636;
	b=S3fQfh/mvoau06W7dEnWIiDMag/ZFLLHdYBl7C3lojIiCgtHO51QbLPALZm8V/qMXKLu
	 WMnN8nplRdZmy+Dt23GddCtqHsNY7d2h2EgBjU9Qn2hVr/DotJT4SiBLu9LkTuQzG1DLq
	 PpAV6hYRWzKZu0JejQL3aCcyqYD84l+G/Q9ZsCAEOmHViSTYsDGp7N7KsH2rSkt0+PDv3
	 w0MtAOcdubmkkIP32DtpCiVUuZfn6RrqYyR+nJsw2eDf2kR616ZO2/ZHJdM9eqtwPsmfn
	 b6KSKPoysw8bGPrud1EnGKoetVHJVPaJN7X2yvOKFp2QIBzcPoyZeb+7dTWjfe6KgCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795785636;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To;
	bh=D+C2WErvkSsOZ4sk5Sz5TIE03pd4kWi86iFdjsd0GLA=;
	b=G0uUG6p0W7NHLhzm6SN4qh9nSjkZCUN3+Kw8jYDl3ue7hxsTjm41bMfctmsQ51DtlA3O
	 Or2RVGQhPOR2+rZaxHFvaJvlum2474s/KZBzipYW4mHlD6drmMaratt6g+nxE1RM7hJCH
	 1dUHk0+Wp7c3hVxnGymTX3Zy/63HYj0qPcyJyVp/vz0JtYGPQpCZaT6uF3YX5rJ234h99
	 +q5slWwWsox0A5NlC7FmMrAMeOVFYuuLdrKWFp9OpncOsFtHB3rw4RmK2t2utlcpye+vq
	 H/oxqCRUo4SuS7YlgJ360LGX/CIEHm0iVV5EszvoVQX5n3DKoZ3Mbdem/huGiZapyDw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ho0lHGuU;
	arc=none smtp.remote-ip=209.85.221.47
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 822E9606A683
	for <virtualization@lists.linux.dev>; Fri, 27 Nov 2026 13:20:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 822E9606A683
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=ho0lHGuU
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-490f38e9688so5617003f8f.0
        for <virtualization@lists.linux.dev>; Fri, 27 Nov 2026 05:20:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795785632; x=1796390432; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=D+C2WErvkSsOZ4sk5Sz5TIE03pd4kWi86iFdjsd0GLA=;
        b=ho0lHGuUjvUg5g+X7Hb5nykHJpH+oXD/F4vZOwSnq9TDD+eneLRq0XU/JHoOp9CCql
         zzor760q3jNlSDMKEBFOWXQorA89pMIoB4bo1Y6S7v88zldNt8LQwQEkN/wydE5MA+Ss
         7FIZhb83g/ZXCuEirhA+T6Yq2WrS2XJ8Y2jnHsoAUsuidFIZTwgH6l42DwpX6PV3TfS+
         z3P5IXUN06VazEdpMhsBqV1dW8N5+pDbgHq+h1afTf5jXJih1TDHGd+wqG7niB7yOQXA
         Qozf0D/p01PGOuZJHWTHnNiqbzq/gioQ7Dutz12fN98v+ipWu5VLqC0tQLO2LT/iDBe7
         woag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795785632; x=1796390432;
        h=in-reply-to:content-disposition:content-type:mime-version
         :references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=D+C2WErvkSsOZ4sk5Sz5TIE03pd4kWi86iFdjsd0GLA=;
        b=KACOsf6GlnYdT5sSHjwSGS2wOzyVl726HrPNIxQAQcg/541p7/kkjbNb6EQlQClgFT
         zxk0vl3ystdFJYzVuV1Ty6KrsqHJF8IkQloAcA41WHflaLyPTSd2aNBs5m5WP33Ok0aW
         eyPor9Ff1xfSwWKVW6kQuLE7ODweth87O6W5p/yPP2aWVTuvFXJYAJb9OPFGPPbh1XHT
         RV9GhJQ0vBUBjzQdsWWb/vW9lAukmLTKKttzp3A27XYarHvth1vsfVvXq/UmAOzNgLHU
         4+/o4AhGcMH7Fk0bnbC2p4xn+5c+9NshKHOvpu+zuxL0UpM2o+EfM5RcOCAL6+VVhG3o
         nclA==
X-Forwarded-Encrypted: i=1; AL+hErGKxGfPt75b4PK5LzLIm5JPBuEdLA21wfOB06ItblbH9i8nAAXCjJ7THUJcl/oGJRfe9iapm9APoam2kRgqgA==@lists.linux.dev
X-Gm-Message-State: APuU4Z8k/Vv2yeY7/j1LoQcX/vJo5G8/00JmAQNh/zsgD14SxKQwIqZH
	vffdS2NR8kSlVrM4Ci/cdBDxmiAnrgDTDnLGJ/gPhOBo7E9p5dRab/BT
X-Gm-Gg: AZFdTZerlrYjkpsmTkh3fg929+g73j9upqigmWMPLS/dSWJGyFYsxO7hngPJ8epK+oD
	SYfsYm0v213T1UzDLBiqkxGdyGAado+TnnjfSh+PlC6Z26VTgyZwM1F+AvuM832lWEHRuVKLTCJ
	bYjk8/NHM0UrsO87mqIKP+cRdelSMo54dtfV4pQ80JHG8INHsqWSQfjolM4oLOEG8uY/l2OM2Q9
	XCtKjkp+PjdV5IO8tIA9zBAenikzK75x+tN50saE+YvI7QmOonG8lLHyE/aNaCsi2TMSz9BWXQv
	P4mUeUvQRIJRfGJeESZiz8XeSgKmP4ePS1DN8jhkN7AL8YpUbAF4Rt57XjdP9KO2kM0Hz35Luow
	vS47P0rRh0RJ/Hnf6q77hJAUB5e3HQkPQKWz81OFIJL7otBWMQLBwvmXpGfyuvoZi0MtkXf7BMg
	kur/GMDY4fWBAdIi5W34kQ0i/GynkKncbmu/gyKMlz2AzAnrtupjEKAIPgawnyCi47iru0fA0Jx
	qPS5DFrIpG3Zg5vbnTuO5Cz22rSSr9KbYE6MDOOktTZXYzAuxxXht5WAxPflH3KG0+30RKktvgc
	gN7wGr6cNTeuqvyWnUKUVi4GeLdqpg4c77M=
X-Received: by 2002:a05:6000:250e:b0:48e:d7c:4bc3 with SMTP id ffacd0b85a97d-4aa5805e1e3mr58576532f8f.21.1795785631616;
        Fri, 27 Nov 2026 05:20:31 -0800 (PST)
Received: from gmail.com ([2a00:1bb8:11c:ad4d:e281:a398:d85b:8a2e])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4ab6b10b1ebsm48315205f8f.33.2026.11.27.05.20.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 05:20:31 -0800 (PST)
Date: Fri, 27 Nov 2026 14:20:27 +0100
From: Stjepan Poljak <stjepan.poljak@gmail.com>
To: Jayant Shekhar <jayant.shekhar@oss.qualcomm.com>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, 
	Jason Wang <jasowangio@gmail.com>, Eugenio =?utf-8?B?UMOpcmV6?= <eperezma@redhat.com>, 
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Dmitry Baryshkov <lumag@kernel.org>, Flemin Jose <flemin.jose@oss.qualcomm.com>, 
	linux-arm-msm@vger.kernel.org, virtualization@lists.linux.dev, devicetree@vger.kernel.org, 
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] virtio: Add Qualcomm VirtIO transport wrapper
Message-ID: <awmAScxDZqR8GRy5@gmail.com>
References: <20261126-jshekhar-qcom-virtio-dcp-v1-0-7b49bda74916@oss.qualcomm.com>
 <20261126-jshekhar-qcom-virtio-dcp-v1-3-7b49bda74916@oss.qualcomm.com>
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20261126-jshekhar-qcom-virtio-dcp-v1-3-7b49bda74916@oss.qualcomm.com>

On Thu, Nov 26, 2026 at 11:54:01AM +0530, Jayant Shekhar wrote:
[...]
> +static int dcp_virtio_transport_suspend(struct device *dev)
> +{
[...]
> +	ret = virtio_device_freeze(&transport->mmio.vdev);
[...]
> +	ret = dcp_ipcc_enable_irq_wake(&transport->ipcc);
[...]
> +	ret = dcp_ipcc_send_power_notify(&transport->ipcc);

Hi Jayant,

I've been trying to review this patch and got a bit confused by the
.suspend implementation. Why is the notify needed here?

The rest of the code seems to imply that a power notify means "wake DCP if
needed" (e.g. "It wakes DCP during power transitions" in virtio_qcom_dcp_ipcc.c),
so how does that fit into .suspend? Does firmware treat the power notify here
differently?

[...]
> +	complete(&ipcc->power_notify_done);
> +	if (ipcc->resp_vq)
> +		vring_interrupt(0, ipcc->resp_vq);

As far as I could tell from your comments, rings from IPCC (separate from
power notify) are needed when resp queues are ready. But why if we already
have a virtio interrupt? I kind of assumed that this is what was meant in
.suspend when you enable IRQ wake, that we may need it to wake the host,
but while suspended the queues are already deleted and resp_vq is NULL?
I think this also addresses the race Sashiko reported: this seems redundant
or I don't understand this mechanism fully...

Thanks,
Stjepan
