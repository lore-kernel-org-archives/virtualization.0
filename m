Received: from mail-yx1-f66.google.com (mail-yx1-f66.google.com [74.125.224.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63F72366DDF
	for <virtualization@lists.linux.dev>; Tue,  3 Feb 2026 18:17:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770142659; cv=none; b=uCIDPOKKd1W4bqwRffyGr+V5lHiCVAyYnKTDvbaq24IScr4TTyR9E3tuFVIWOeTRGEJv2CSAiYUsNkol8FPt5lAEPrv4aBqGVkjHHrzmgHaz3OcncKNYx2GCX+P6MUy8CK9q42DEE7ACyd4vs8UxfS6UGbbj/42GqFUWbP+Qhv8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770142659; c=relaxed/simple;
	bh=cPxuwbokChawhBR2aJF0YsS2ia7mjo7SWH5dY97bhbc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UShOt5N7ThgMMEDsY6F6mrd3ItFnwOjmpxcTZ/rIYJXtb/h0Gt8CJ3Lr02jKeKhO7azEBZh1BkAlBCR42apq+9WzLMDCo9J8JyIS882XxqLEwFesx09SA6XKxcyDxNfkOy+qlKs9tEL6Nz+WPN9siTdua4tSZfAXQclcgSdA0fQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NTlnMJcR; arc=none smtp.client-ip=74.125.224.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NTlnMJcR"
Received: by mail-yx1-f66.google.com with SMTP id 956f58d0204a3-649ba412cd4so2912823d50.0
        for <virtualization@lists.linux.dev>; Tue, 03 Feb 2026 10:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770142656; x=1770747456; darn=lists.linux.dev;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IfQQ/hkIcrRAkW7v/0G9Sw2aYsY9fMOv4jWxru/t/J8=;
        b=NTlnMJcRaVHHXUIkmFGiRjsq6xs6u7/vDl+N8YoEjYcXFhZ9i4uKnh4gbOIQO+8W6f
         yyMnP1IbwVymOk8GVDiL+fWf8TH8B6tdOy9wjXrZ+GTwCgyer5kd7RZmiT6m/qYkplw3
         v6PTiYiPTwg0JsD/VSW6lbPDEyUb2bqTFU9vg7i+1Y4Cpl2eAaDlwkrLudgeGWCBCFSr
         JBexdliJta4nCkBUrpZjZ457U1NmaiIZJ9iBSLVtlYBDr1yMM63Y9VQI1HsSJCO4xygR
         CfIrNwNvmU7N29pCOGtCHXxDA+VmoEkxY1IGJ9WSxxf8VA0eFmXslF4ET1355TWGATfj
         zHgQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770142656; x=1770747456;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IfQQ/hkIcrRAkW7v/0G9Sw2aYsY9fMOv4jWxru/t/J8=;
        b=Fde7VU7MZmKNEzkUER2AwAmlgF5MeOljC2k9qFJnXg24NvTS6BAryK2klZW+WqXAA1
         Hlmuxad1UkaEkm3+b9cOguajC/loOjj17v1nm7+LQ7TBq5lHJli9hLZ9GDRmDj4v4aQ7
         KfCPplXVC7skyAQlB0MfYpcMYJZ+aoWxaKgIILU9EQwdPMBbyD/ArGhn7tZBwVpEuh0l
         9MqWe0fKv09bIMg1C8TXabodlIGXVfpACjNQkkuI1W+2edXlpSNHIODEIBE25tIMuzeJ
         DkY/LdSVN/CZkUNn6BuRo8QVJ1wmfV/gh4SiDurUGXy3b0G+jwTjY41hIQ1O6fJtmX5U
         ovfQ==
X-Forwarded-Encrypted: i=1; AJvYcCUbbsSWYBKj60b3HoPnI1WzmjaXjU0lZQPYlzI82cCQsJ0Y+Bc2j0XZ27p+BbUSocQDhATETFuJDm4NxmmpZA==@lists.linux.dev
X-Gm-Message-State: AOJu0YweFUXguZwJKI/uqtZUwgIPOB8Ykbz4PwcgN1EcyIiadq8H2AHh
	VE7PPpnLfH197p0yIva4DBa/UPVdwuNzmw0EkLo1gCY+CtJerINiMdTn
X-Gm-Gg: AZuq6aLz3F1wvuZ6pj0PjL/EIWi4UhYdS8or8xEXWW75r78Q9eGQjVtFFTTIiSXBW0L
	uEN+hiJ65v9B2T8OBEuYMygzIVsOWL3TfbM3Nmqbbzf6HMXWcxpBpx5v1k3UKgSzIevhi/BfVqH
	kBu3973dUygY9uBjGAyGm41MPpeNIl+mFAvCMLL+c6625F0nZV2EYMJ/wQUIIN4XjAqVkbrMwEk
	pQMrxwCXkLXSrVjdj+aEnssYkNiBsQjTAQycP0Hur9VwKFzTNzyBXN8o4kocir16gxEJaCt9468
	bwMzcFSiIMb4uIAMEizRnG+guQgU9mekjsXVmxP6jYRcdpqcHfvQyyFUCrq6jQJ2WB7aIi1L8B7
	jqm9Ck3/CIJr3W48tmzFHrGIBYtquxDp1arwyIfTIYG/UGjojSZPgyZ3SwIeREUUF3BvV4FCGK5
	IzzwSxfj1qBmeL9LR3LoVMH0SiR/YOIACkNT2+hFKmYkPGCEL21zpi+fN6haPfYaKNAvjzYLqTd
	cngIpA6ZLM/4e9XwmjC
X-Received: by 2002:a53:d249:0:b0:649:c512:1430 with SMTP id 956f58d0204a3-649db3483admr346374d50.26.1770142655428;
        Tue, 03 Feb 2026 10:17:35 -0800 (PST)
Received: from devvm11784.nha0.facebook.com (fwdproxy-nha-036.fbsv.net. [69.63.189.36])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-649dc5aca33sm65624d50.14.2026.02.03.10.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Feb 2026 10:17:34 -0800 (PST)
Date: Tue, 3 Feb 2026 10:17:27 -0800
From: Bobby Eshleman <bobbyeshleman@gmail.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Bryan Tan <bryan-bt.tan@broadcom.com>,
	Vishnu Dasa <vishnu.dasa@broadcom.com>,
	Stefano Garzarella <sgarzare@redhat.com>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
	Arnd Bergmann <arnd@arndb.de>,
	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>,
	Simon Horman <horms@kernel.org>,
	HarshaVardhana S A <harshavardhana.sa@broadcom.com>,
	Bobby Eshleman <bobbyeshleman@meta.com>,
	"Michael S. Tsirkin" <mst@redhat.com>, linux-kernel@vger.kernel.org,
	virtualization@lists.linux.dev, netdev@vger.kernel.org
Subject: Re: [PATCH] vmw_vsock: bypass false-positive Wnonnull warning with
 gcc-16
Message-ID: <aYI7twgCsAQSAiZk@devvm11784.nha0.facebook.com>
References: <20260203163406.2636463-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260203163406.2636463-1-arnd@kernel.org>

On Tue, Feb 03, 2026 at 05:34:00PM +0100, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> The gcc-16.0.1 snapshot produces a false-positive warning that turns
> into a build failure with CONFIG_WERROR:
> 
> In file included from arch/x86/include/asm/string.h:6,
>                  from net/vmw_vsock/vmci_transport.c:10:
> In function 'vmci_transport_packet_init',
>     inlined from '__vmci_transport_send_control_pkt.constprop' at net/vmw_vsock/vmci_transport.c:198:2:
> arch/x86/include/asm/string_32.h:150:25: error: argument 2 null where non-null expected because argument 3 is nonzero [-Werror=nonnull]
>   150 | #define memcpy(t, f, n) __builtin_memcpy(t, f, n)
>       |                         ^~~~~~~~~~~~~~~~~~~~~~~~~
> net/vmw_vsock/vmci_transport.c:164:17: note: in expansion of macro 'memcpy'
>   164 |                 memcpy(&pkt->u.wait, wait, sizeof(pkt->u.wait));
>       |                 ^~~~~~
> arch/x86/include/asm/string_32.h:150:25: note: in a call to built-in function '__builtin_memcpy'
> net/vmw_vsock/vmci_transport.c:164:17: note: in expansion of macro 'memcpy'
>   164 |                 memcpy(&pkt->u.wait, wait, sizeof(pkt->u.wait));
>       |                 ^~~~~~
> 
> This seems relatively harmless, and it so far the only instance of this
> warning I have found. The __vmci_transport_send_control_pkt function
> is called either with wait=NULL or with one of the type values that
> pass 'wait' into memcpy() here, but not from the same caller.
> 
> Replacing the memcpy with a struct assignment is otherwise the same
> but avoids the warning.
> 
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  net/vmw_vsock/vmci_transport.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/vmw_vsock/vmci_transport.c b/net/vmw_vsock/vmci_transport.c
> index 00f6bbdb035a..a64522be1bad 100644
> --- a/net/vmw_vsock/vmci_transport.c
> +++ b/net/vmw_vsock/vmci_transport.c
> @@ -161,7 +161,7 @@ vmci_transport_packet_init(struct vmci_transport_packet *pkt,
>  
>  	case VMCI_TRANSPORT_PACKET_TYPE_WAITING_READ:
>  	case VMCI_TRANSPORT_PACKET_TYPE_WAITING_WRITE:
> -		memcpy(&pkt->u.wait, wait, sizeof(pkt->u.wait));
> +		pkt->u.wait = *wait;
>  		break;
>  
>  	case VMCI_TRANSPORT_PACKET_TYPE_REQUEST2:
> -- 
> 2.39.5
> 

Reviewed-by: Bobby Eshleman <bobbyeshleman@meta.com>
