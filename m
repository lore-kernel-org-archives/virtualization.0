Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05D412A8E5
	for <virtualization@lists.linux.dev>; Sat, 19 Oct 2024 21:23:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729372995; cv=none; b=DwWihXdiXb9QPNfqtMKKKnbJDDqEE+FPylO+a+iJ2j3hb/Nl9mTWeZz7qttjsLnCvoOVKJMW9vSWXHyN+ZrfDgSRMTbodKO0h+qS6Tl4bToF67nRFlFQGYg+b/KTsMk3YQVyQA3mpMkHOfTP0a/hJHg/SC0rLkdCvxn5wcWXrLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729372995; c=relaxed/simple;
	bh=PXtwVjnVjQKoXbQM4NJN+9cX/Urz9TXJ+s86mTb6bBw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=NfkwN3/VCrLd71h3Ay0fVnqn9VHEs2maibxs+aRuJ0dH2K41eefQcQcy+S0u7I+WkkoLvJUsntBigoo5FRZPywX66R//whfRwITzioXcPNhwn+GB6KAikmoQsgF+rn4XrLfXcqCqaHeEB+hGZCEZ9kIFo4iUk7Bq2PCDcP7r2Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kXefl+bU; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kXefl+bU"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-20cb7139d9dso29891405ad.1
        for <virtualization@lists.linux.dev>; Sat, 19 Oct 2024 14:23:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729372993; x=1729977793; darn=lists.linux.dev;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R3y5VRCiALIgZNUnReYDuyg0/iOLQhzlnG2JHcQbtA0=;
        b=kXefl+bUMJMKQeoQqLcwUtCaJtTKxadwgF7RlJHReMs4NL80fTrrFt4O7kpuW9niGf
         ePWn+OkmBpInJiU3YlzeQc9LoKHi7CBzRxO4CuCUIuAoWrAfOVcfeorHL7l0vGzVpC9F
         aRko7EUiB8DB7DIzLjrmb8BychiqskVoDy0qOi29xpSe9IrSmDgoTKhOJ2aOMsg+jFvl
         W21SMdTd+GnFdZMIf/H9+pcE2uaM226HJmXmjgifQTxodfLD672CtIjzLbH/CGxR2kxo
         XFnfc4wVUUgtSBsFjazTWMrT4gGGg8ELiSWI+7AO/Qw1LbSzXM9Z1qLRIDj8cVEXrBG8
         x3fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729372993; x=1729977793;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R3y5VRCiALIgZNUnReYDuyg0/iOLQhzlnG2JHcQbtA0=;
        b=XLsY+3/GwDmTFHEgGQyVBtSGiKoPO5xSOVKrMzqG+uCsPFw5v6u3pItSn8D5pF29Sq
         WBx82igdXmwiaCI0yOYzKRzmiHyYNM+OWFKVQZ67PwnpfXjAX9rVPB61WI6O4Ww64cYQ
         q1ePTzf9rgsrkoC3aEQE4+uqlCfPTpRPn9suky7oimCGcF0vqRTery/xxRfjWbVB9fZv
         SFW1bP+a3uDLMwpdRa8ffoMYt6Zaq6RBbeOpdsYc9C/2/4FZ8VfMt77+5kxrejBuDhnV
         SVWYJi8nygAGMFYVs5uACDjtlsR8TgDvJBq+RktcuHbOo/6k8PiSeJgNW0D/A09FOVdD
         Xv7w==
X-Gm-Message-State: AOJu0Yz+Tueibhrrt2chlDRLZTkZ5YhnMQULU398SOeVt2kQUuEdJS0y
	5q22S6ZUzfp5vLPz/DYpYxpxJb1wDmHt7thG8Nju2P+zpdBtWxlX
X-Google-Smtp-Source: AGHT+IGfrACc3yzkehCQFBfdzP9s4oLYjJ6s/6yvr94Z/VbhIAJWAjB5R1nJaFNwF99DvpyWCirbGg==
X-Received: by 2002:a17:902:ecc9:b0:20d:27f8:d72a with SMTP id d9443c01a7336-20e5a955803mr87535415ad.61.1729372993161;
        Sat, 19 Oct 2024 14:23:13 -0700 (PDT)
Received: from [192.168.0.108] ([115.96.37.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-20e7f0bd64asm1524575ad.153.2024.10.19.14.23.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Oct 2024 14:23:12 -0700 (PDT)
Message-ID: <6f86e245-f5f4-4e12-9bdd-efb4dac7d805@gmail.com>
Date: Sun, 20 Oct 2024 02:53:08 +0530
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] Fix typo in vringh_test.c
To: mst@redhat.com, jasowang@redhat.com, xuanzhuo@linux.alibaba.com,
 perezma@redhat.com
Cc: virtualization@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20241008145204.478749-1-cvam0000@gmail.com>
Content-Language: en-US
From: Shivam Chaudhary <cvam0000@gmail.com>
In-Reply-To: <20241008145204.478749-1-cvam0000@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit


On 08/10/24 8:22 PM, Shivam Chaudhary wrote:
> Corrected minor typo in tools/virtio/vringh_test.c:
> - Fixed "retreives" to "retrieves"
>
> Signed-off-by: Shivam Chaudhary <cvam0000@gmail.com>
> ---
>   tools/virtio/vringh_test.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/tools/virtio/vringh_test.c b/tools/virtio/vringh_test.c
> index 43d3a6aa1dcf..b9591223437a 100644
> --- a/tools/virtio/vringh_test.c
> +++ b/tools/virtio/vringh_test.c
> @@ -519,7 +519,7 @@ int main(int argc, char *argv[])
>   		errx(1, "virtqueue_add_sgs: %i", err);
>   	__kmalloc_fake = NULL;
>   
> -	/* Host retreives it. */
> +	/* Host retrieves it. */
>   	vringh_iov_init(&riov, host_riov, ARRAY_SIZE(host_riov));
>   	vringh_iov_init(&wiov, host_wiov, ARRAY_SIZE(host_wiov));
>   


Hello greetings,

Any update on the same.

thanks and regards,

Shivam

