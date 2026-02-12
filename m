Received: from unimail.uni-dortmund.de (mx1.hrz.uni-dortmund.de [129.217.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46D4CFC0A;
	Thu, 12 Feb 2026 08:03:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=129.217.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770883436; cv=none; b=R8uH/PaF1m4D8B/S7fzzQ0jP0e59ijvf+H9RGErZpgxiRPxlmcnh/7LPbdYXvywH45xVnRpqiSdSkbx3A/2GeVVxlgWeAwRkVPwbljcfAdvUrXrx67YVvoNXn1Wlb4Dbh17fa0+xMk1yB8bTdy9B/zrTNok8Ulgc+hO9g7lWmek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770883436; c=relaxed/simple;
	bh=fwOGRSdS4B8fzrETSKqhSqLiygLkiA8fHDRPBpmCVF4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CptgAJsgRoaVsIMBd7or5T6iBo+J/aJ5PQ5LA4wIN6BOvjbQ25WETzi3p58YrD1lLf3CDhmpodsYg+0+2xueQpwuAZtOx69TwOzwH4jfNttxwTSCbGvLTjJPAWFJ55Vw/iGWDJWvajsjauzELgGCvYBQuaOI0Mg4FFKXMxKVSRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de; spf=pass smtp.mailfrom=tu-dortmund.de; dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b=HWNlgIDb; arc=none smtp.client-ip=129.217.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-dortmund.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=tu-dortmund.de header.i=@tu-dortmund.de header.b="HWNlgIDb"
Received: from [192.168.70.77] (pd95c968e.dip0.t-ipconnect.de [217.92.150.142])
	(authenticated bits=0)
	by unimail.uni-dortmund.de (8.18.1.16/8.18.1.16) with ESMTPSA id 61C83gfO000654
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 12 Feb 2026 09:03:42 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-dortmund.de;
	s=unimail; t=1770883424;
	bh=fwOGRSdS4B8fzrETSKqhSqLiygLkiA8fHDRPBpmCVF4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=HWNlgIDbVwEIoJL8uG5O3bo0lH/oPapUHt0mpqg2W36MvhPpULBykvJYO95ejZ4Jc
	 gW+nLwt0KQTbvPomzqGnw0317k332KjG8nb8aQIqmbyz7dxwUZfCP9diZBFaisxqqz
	 o6nD9Uj4gfzp4UDEJWf/GLwZvAJtq52IUNN+54eo=
Message-ID: <fd72fb56-977f-44c5-b98c-bc553d79ad76@tu-dortmund.de>
Date: Thu, 12 Feb 2026 09:03:42 +0100
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next v7 3/9] tun/tap: add ptr_ring consume helper with
 netdev queue wakeup
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Jason Wang <jasowang@redhat.com>, willemdebruijn.kernel@gmail.com,
        andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, eperezma@redhat.com,
        leiyang@redhat.com, stephen@networkplumber.org, jon@nutanix.com,
        tim.gebauer@tu-dortmund.de, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux.dev
References: <ba17ba38-9f61-4a10-b375-d0da805e6b73@tu-dortmund.de>
 <CACGkMEtnLw2b8iDysQzRbXxTj2xbgzKqEZUbhmZz9tXPLTE6Sw@mail.gmail.com>
 <0ebc00ba-35e7-4570-a44f-b0ae634f2316@tu-dortmund.de>
 <CACGkMEsJtE3RehWQ8BaDL2HdFPK=iW+ZaEAN1TekAMWwor5tjQ@mail.gmail.com>
 <197573a1-df52-4928-adb9-55a7a4f78839@tu-dortmund.de>
 <CACGkMEveEXky_rTrvRrfi7qix12GG91GfyqnwB6Tu-dnjqAm9A@mail.gmail.com>
 <0c776172-2f02-47fc-babf-2871adca42cb@tu-dortmund.de>
 <CACGkMEte=LwvkxPh-tesJHLVYQV1YZF4is1Yamokhkzaf5GOWw@mail.gmail.com>
 <205aa139-975d-4092-aa04-a2c570ae43a6@tu-dortmund.de>
 <60157111-219d-4fb3-a01a-6df9a83eae7e@tu-dortmund.de>
 <20260212020317-mutt-send-email-mst@kernel.org>
Content-Language: en-US
From: Simon Schippers <simon.schippers@tu-dortmund.de>
In-Reply-To: <20260212020317-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2/12/26 08:06, Michael S. Tsirkin wrote:
> 
> Simon is there a reason you drop "Re: " subject prefix when
> replying? Each time I am thinking it's a new version
> only to find out it's this endless thread where people quote
>> 1000 lines of context to add 2 lines at the end.
> 

No, there is no reason for that. Sorry, I will keep the
"Re: " from now on.
