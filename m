Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E6E13064BB
	for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 08:40:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761122445; cv=none; b=Emn8nd2wvdyt9hkrxLhAUe4ADMqMaMAmiudVJ4BNAg2YZN1nhePZwQvd4taKlhGn9veRUHZch95ekRBS6AOj4uVt1rIjCElPBJb0Uw4CjPPpH3eOeY4CdgvdKslGEg+vR5hEP8qnJ7a7B/WnPrZtYTOAh/lEfqrT1yq1CvZc3Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761122445; c=relaxed/simple;
	bh=HQGNzCX1VNd8J70zySmCJ8ZIBP8bevsIaZ+WmefapxY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VJNfzL2sGPkQ2cM33CqdB31Cl05YRLA+ISqMAj6xNrRJo9Kv/x24dEtb07c3pyhzrrjPcQIsa5YTPN1rmGdZY3Fr6WK3KPVBctiw5+39X6p9StfzaILr/SKrjd3vA/KaYvylCmtZJuNGS5Q5g+tt1WKxjLwrYIt3Cz5FSEBNqD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VviICsL+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VviICsL+"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1761122442;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references:autocrypt:autocrypt;
	bh=IyII8qs2AWA9eUNKWYj/GrkMP/2s9uE4zP2DrnDC69E=;
	b=VviICsL+zJxwvydsvO0bpJP5SoXv8qPBxRNBljBcRS6gl/KMaDHoSOnewk5hlq9zEQlHcG
	pi8TGE1Q/j6Er5xMtkXWJN7Z6oEt+tnpu0yRJ/RIw/BYSBBX3ovjVt8OhgQJ9SOimsp63j
	9sOZYlqNErnI/BViKAxdXBhDSrtowag=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-224-xg-yAs3sOBy0bhTSXE6rhg-1; Wed, 22 Oct 2025 04:40:41 -0400
X-MC-Unique: xg-yAs3sOBy0bhTSXE6rhg-1
X-Mimecast-MFC-AGG-ID: xg-yAs3sOBy0bhTSXE6rhg_1761122440
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-46e47d14dceso39072665e9.2
        for <virtualization@lists.linux.dev>; Wed, 22 Oct 2025 01:40:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761122440; x=1761727240;
        h=content-transfer-encoding:in-reply-to:autocrypt:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IyII8qs2AWA9eUNKWYj/GrkMP/2s9uE4zP2DrnDC69E=;
        b=Y3HqnoN/lDSNyqCihugNv9ARFopdwa17tbMTGMs83TvyL8B8FIW2pqAKIk7ulOlU1x
         Ct/xJkUoG0tCDWNQAHif16PNPApUOdWvRusu4oV3cQUhMINpIRDC02H71rC5KmWc3/Fb
         1FitW7itd7rwtHeqdeC2XLqLZ/Ufs529pNHbxmhrD5bQdnwGJFtytzm9pHvCIvMy5PMu
         hUtitFSR0YYdcoZIAGqodctkxDRJSsY4qxlqYwOCIq1VWUO29s5I0HF2tms0Bhyy8Paz
         OAgle9BlztXCHHdFWzpDapOXxHDZze6vntn0kreMgWyvo8JpyGMsg9/wOgTQTIDWSgh4
         b3DA==
X-Forwarded-Encrypted: i=1; AJvYcCUHd/m4OQ7EC6eSuOmeY/0aVPk0SzmDqCoC+0R2u2m1Rp4RzyFKFeeBOv63GK5+pGnODBapimZyNXwXOgdXPw==@lists.linux.dev
X-Gm-Message-State: AOJu0YwkByHsaxqWOu3Q8q/h+iDLEBVERUKGK6SvQs8BZiASRAjZ3BX1
	z76askDd2csLN8QOM/W4bQZd7KjdTt2nC2rLNXGJrLImKaWisKuw3EvQzziwtp//PZsAPIW4enX
	W3Fgyttlvng5xK7xTZ13WrNz1pQ7OLFzWou/CsbOI4y9Zb61jAXR6/7Hp7JXuFz69KhHL
X-Gm-Gg: ASbGncuPGAL0qMrSa/Vj2nFao24LK4NNJo79XZAhm02YhASN/NYFvNoBIQ4EMO0FdyX
	299fG/nWLH3V3UMeouMLq+NFtlrU+AyXm9YyEHVgFDLjKcsN1tw3rAnKJmVcmpMi/EA4suzAeXi
	BRLJcsDmMWQ5PCBEyzsDebOgu+ojnacUv80JuxNrjFDJAqER9s2F6at+xmS8dIWMD6VOvUQj6Es
	2VeIpUq90xUJNr1K0fICr6+KIlVeGTG1rA4AA5+oRfieS5Y92mh00fqjbCz85XStoNmi/SKTHdF
	WTmhuUvTGvuHLBKWoHzpTVlmgA6PgcBPkN4Ich71+VT0EcZAMWXhe+wDhGAk0yu/Cw/N2PfPZwB
	70uZvbHHd6iuGU/ugkl3p0BTNOFHp/aGylUJMFGDcF7cmElih/IvXs2Hq2ADRySXsXSlGZ5xzSe
	MAg86aEUwY8tFMspyjL99Xa9v4p8k=
X-Received: by 2002:a05:600c:458b:b0:46f:b32e:5094 with SMTP id 5b1f17b1804b1-4711791cb4cmr174181715e9.32.1761122439915;
        Wed, 22 Oct 2025 01:40:39 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFoS2FDFL4u1V3mpEYxjOqKBNemC1wS2eap0hBA+VfSeySp1O0SWfSuGs5C/jtt/9Qw6UCYsw==
X-Received: by 2002:a05:600c:458b:b0:46f:b32e:5094 with SMTP id 5b1f17b1804b1-4711791cb4cmr174181335e9.32.1761122439450;
        Wed, 22 Oct 2025 01:40:39 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3? (p200300d82f4e3200c99da38b3f3ad4b3.dip0.t-ipconnect.de. [2003:d8:2f4e:3200:c99d:a38b:3f3a:d4b3])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-475c4369b3esm31744665e9.13.2025.10.22.01.40.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Oct 2025 01:40:38 -0700 (PDT)
Message-ID: <99ce6f94-9b66-4d16-81de-8dd753a6d606@redhat.com>
Date: Wed, 22 Oct 2025 10:40:36 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 06/23] vmw_balloon: stop using the balloon_dev_info
 lock
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
 linuxppc-dev@lists.ozlabs.org,
 Broadcom internal kernel review list
 <bcm-kernel-feedback-list@broadcom.com>, linux-doc@vger.kernel.org,
 virtualization@lists.linux.dev, Andrew Morton <akpm@linux-foundation.org>,
 Oscar Salvador <osalvador@suse.de>,
 Lorenzo Stoakes <lorenzo.stoakes@oracle.com>,
 "Liam R. Howlett" <Liam.Howlett@oracle.com>, Vlastimil Babka
 <vbabka@suse.cz>, Mike Rapoport <rppt@kernel.org>,
 Suren Baghdasaryan <surenb@google.com>, Michal Hocko <mhocko@suse.com>,
 Jonathan Corbet <corbet@lwn.net>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 Christophe Leroy <christophe.leroy@csgroup.eu>, Arnd Bergmann
 <arnd@arndb.de>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jerrin Shaji George <jerrin.shaji-george@broadcom.com>,
 Jason Wang <jasowang@redhat.com>, Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
 =?UTF-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, Zi Yan <ziy@nvidia.com>
References: <20251021125929.377194-1-david@redhat.com>
 <20251021125929.377194-7-david@redhat.com>
 <20251021165626-mutt-send-email-mst@kernel.org>
From: David Hildenbrand <david@redhat.com>
Autocrypt: addr=david@redhat.com; keydata=
 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
 qIws/H2t
In-Reply-To: <20251021165626-mutt-send-email-mst@kernel.org>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: QhODgMUyRkDauAp8RwJTbZtsPZbnlEG2We4CxCJwNFI_1761122440
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 21.10.25 22:57, Michael S. Tsirkin wrote:
> On Tue, Oct 21, 2025 at 02:59:11PM +0200, David Hildenbrand wrote:
>> Let's not piggy-back on the existing lock and use a separate lock for the
>> huge page list.
> 
> which is fine but it is worth documenting that we are also
> no longer disabling interrupts while taking this lock.

Indeed, I'll add

"Now that we use a separate lock, there is no need to disable 
interrupts, so use the non-irqsave variants."

-- 
Cheers

David / dhildenb

