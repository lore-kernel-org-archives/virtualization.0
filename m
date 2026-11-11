Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794398570;
	b=zi5J5Bu8git/TyQOUcfGEPE+oD7mv7HezSojjYfbOijPxlz53YRooqv719dwy5WUq4WV
	 cse2rDGVquQcY+bXfHbCqjCgung7y9PrpEDp7ob3KSY+jNDO+UsvkV+rybzHVeJwSrhtV
	 SKEGZjdz048kTka2Lav3yT8IozyBr4KqG1AAdzlYMHzDaxF7/OhSkbgmkuI3sp0pjCo/t
	 Hu7QlB8b2DORNntHRtMUOMHNWmFE2he28rbqPnJ8WwuF9J1f08uJFXDOXI1QRV39wORdK
	 SNmnTrUDTWE3+nJEPjAHIc8JgUmO+oGb578VliCh4VnwTo1JZQG3ik4IAcvi3Yx/cnQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794398570;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 Message-ID:Date:MIME-Version:User-Agent:Subject:To:Cc:References:From:
	 Content-Language:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	bh=Mf3ojcAaOl5Wd2bB/OvSpA9q4iDAVUFZx+UCDfwTy74=;
	b=JT5HojCOpNB1+I15VtJc7O1EcgjVUzcOzgVxC316T+YxdeEZebidE99Fd//LQnUAD8GK
	 TPRysehw+6F0ZbyzU83ueooKgvC4MSagb7982tEwXTIYaLtV3iYX+VZ3kQOLCjYy03sEr
	 8Hj41J5NCJN89AEh17xJx29H30Wp2iguBWU2GoOv31R4aOFZP94WIAeKn27z07a96KhE1
	 slOoIyNu3Et3oDTT2/KPedREYN2AZqn1gRuuTibJaXp04oR9NCNYVUWAz2nMd+bkCMHZq
	 cmXsBSrNYg3qcCKYCisD6gk9XvvwW0roqjEToYIbZkPZKYof8V3vQRYf8FoOXcsjmcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linaro.org;
	spf=pass smtp.mailfrom=linaro.org;
	dkim=pass header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sQJ9qyCW;
	arc=none smtp.remote-ip=209.85.221.52
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com [209.85.221.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E4C606A321
	for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 12:02:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C4E4C606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.a=rsa-sha256 header.s=google header.b=sQJ9qyCW
Received: by mail-wr1-f52.google.com with SMTP id ffacd0b85a97d-4922dbcee23so1781709f8f.0
        for <virtualization@lists.linux.dev>; Wed, 11 Nov 2026 04:02:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1794398568; x=1795003368; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mf3ojcAaOl5Wd2bB/OvSpA9q4iDAVUFZx+UCDfwTy74=;
        b=sQJ9qyCWCjiDPKGsUjshl6uKUDnBFfmrw1fZ0bAebnifEUU3RGh7N90jS0xvmqtT98
         6+BvaV06eigvIds8ZC8isnDR+LU+3HvbN8qAA7BfO+pTRmcgNfPlEFs6XH/V+dMFSlsF
         VVZj+G5cKg8dN96e5WhvlRX+HWRVMPR13mM7z2Oney5BCA0ohnQyiC9oEW9XsDHNtyIQ
         bmdW0/m9MlAJPmDEMox1Eir4fOCX/pXhvE4qrMIbAWzcT7TeLCR7R/+qtDtN6VfKJjRp
         ZgUYOt7/syRMN7w1f77BDXh6vco4zb6vMWpPmcDVfY7Rewav4J2rKepksLfzKwySbvRV
         +Bog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794398568; x=1795003368;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mf3ojcAaOl5Wd2bB/OvSpA9q4iDAVUFZx+UCDfwTy74=;
        b=tLQIfRCjoVS0vgkhXEY+rC5l84u9ryvRAJnnP0zH1KVZwsfoiUJSrKKWo7N86DqlC7
         iDdHCBniTusnL7VTtGIeDjDvI0fuvOwAhO3TrDGqjcATCeYYkAPrnc3Yn+MUzWNlz8xQ
         7GcFBipTTj2CyV31uvZkzLdDyy1r6pn2Ud4KPwjARCncV7rFRLUf2Wjmt5oAc2hqZsGD
         3Q8BbDwYDZUaiLS5ikdknSxUVhROMb2qrqeNxuXGblwCherQo1n5KhcPAXtHP2tuGKs3
         bfn/o9jxZd5kMgYHsDBD6nMJ+n5y2lt1s8CW7KoepSQPduLEICeQi6YEXLhoqhOtnYLd
         ky2A==
X-Forwarded-Encrypted: i=1; AL+hErF/j3OgJv9ruZFneGRr8+gnHU9jkrjp5WOy6OnLS8fO3uawso1PicllZqPLKPipdUeLqJZ+BMQ8FbysuKj/Iw==@lists.linux.dev
X-Gm-Message-State: APuU4Z9/SRJUaoLU58MI2xusItfB1eetJfe35pXETDXH5PX3SV6NtstU
	vjvZJTlFVz9n3mikonBauNg91pqJmrSI/Hi2n9KDkO1E71EkGQ6UmcHcUc0jm70rtbs=
X-Gm-Gg: AYBFou120+56qgkBo4v6ALXwU6NRHfdShNw7mza4ZrERiLbsOTCR8lKL4Qfvl9ijr1o
	LcdqZ4TiMTL9xU1i/a/6RJYrfmsA2rVhV15WjZrzNezRM1L8nwHOpi30KolVkPjXwlMO8P1mFwM
	vc30eQzbef4vJoDxTnCIPRboa0NWGMIgRrqzUq9/vAQeaUNFwIp8w5r/bFaFRBvQlC+gmFvX+RM
	nmOhESfFEZygLUiWc2NI/oPY4i/QWCiwQm6Kv01ExQQzrFK9hm9+7vF4EQ2dLZmADYsFCtTOKyI
	S9vH0GLng2p1sKOHi0sxBHxQesLvOWLXK6R699UzGE7NNpLf4FU2jF/pj293AIjNdtTR+UG2vrx
	Em/h5z9f7QZE+gKO8eYA8gdlAT+TE22MXUjUhk9dL3qOiQmCmP88tTs51Baf8e8iPxv75P7AG/e
	O+ue+9C8rcj8xpehpixIPnZHxqh1pyZI87o9W3dxLyr3xu1pzVU5PeVYf/KF0ym8Q1GNjgMPF9+
	qGJB6zfG7WwmK0hSY1E2syPRrCyebI+V85LJHOvR1njZ87OkRR+nSVjBdsqfKYiwabSnS0wi/wn
	/t0cc9rLbCjkXy5erouGPzCnoFOJIG8ohq3yORCx
X-Received: by 2002:a05:6000:420d:b0:48b:1a0:5630 with SMTP id ffacd0b85a97d-499c86a10f6mr3780756f8f.41.1794398567805;
        Wed, 11 Nov 2026 04:02:47 -0800 (PST)
Received: from [192.168.0.167] ([109.76.11.16])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-49835c377fdsm8869991f8f.21.2026.11.11.04.02.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 11 Nov 2026 04:02:47 -0800 (PST)
Message-ID: <3713bf13-cec6-4b02-a29b-8f76070f03b3@linaro.org>
Date: Wed, 11 Nov 2026 12:02:45 +0000
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Post: <mailto:virtualization@lists.linux.dev>
List-Help: <mailto:virtualization+help@lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
List-Owner: <mailto:virtualization+owner@lists.linux.dev>
Precedence: list
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 4/5] iommu/of: Require reg for iommu-addresses
To: Vikash Garodia <vikash.garodia@oss.qualcomm.com>,
 "Joerg Roedel (AMD)" <joro@8bytes.org>, Vasant Hegde <vasant.hegde@amd.com>,
 Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
 Will Deacon <will@kernel.org>, Robin Murphy <robin.murphy@arm.com>,
 David Woodhouse <dwmw2@infradead.org>, Lu Baolu <baolu.lu@linux.intel.com>,
 Jean-Philippe Brucker <jpb@kernel.org>, Rob Herring <robh@kernel.org>,
 Saravana Kannan <saravanak@kernel.org>,
 Tomasz Nowicki <tomasz.nowicki@caviumnetworks.com>,
 Eric Auger <eric.auger@redhat.com>, Joerg Roedel <jroedel@suse.de>,
 Srinath Mannam <srinath.mannam@broadcom.com>,
 Oza Pawandeep <quic_poza@quicinc.com>,
 Lorenzo Pieralisi <lpieralisi@kernel.org>,
 Bjorn Helgaas <bhelgaas@google.com>, Alex Williamson <alex@shazbot.org>
Cc: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 virtualization@lists.linux.dev, devicetree@vger.kernel.org,
 kvm@vger.kernel.org, linux-arm-msm@vger.kernel.org,
 linux-media@vger.kernel.org, Vishnu Reddy <busanna.reddy@oss.qualcomm.com>
References: <20261106-add_iommu_ranges-v7-0-5c0f72083e52@oss.qualcomm.com>
 <20261106-add_iommu_ranges-v7-4-5c0f72083e52@oss.qualcomm.com>
From: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Content-Language: en-GB
In-Reply-To: <20261106-add_iommu_ranges-v7-4-5c0f72083e52@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06/11/2026 17:14, Vikash Garodia wrote:
> @@ -257,6 +252,9 @@ void of_iommu_get_resv_regions(struct device *dev, struct list_head *list)
>   				}
>   				type = iommu_resv_region_get_type(dev, &phys, iova, length);
>   
> +				if (type != IOMMU_RESV_DIRECT)
> +					continue;
> +

This change is not about requiring a reg though, which is why it should 
be a standalone patch with its own justifications.

Basically the patch should state why a mismatch is dropped instead of 
being reserved.

---
bod
