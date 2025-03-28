Received: from sender3-pp-f112.zoho.com (sender3-pp-f112.zoho.com [136.143.184.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170C1224CC
	for <virtualization@lists.linux.dev>; Fri, 28 Mar 2025 01:36:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.184.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743125786; cv=pass; b=kGqQUIVKibCDKlExMTRM0MtLDu3dJpsuQkUIWuviiCSgp+bW8ZOpeaojppYSZycFUyfXceCPlfrfFIsPKd2Q1PrOODhxPy8gB0Td0tHNKaQOl2RGBmc6oqEyTj+13o99ooWNwPZDrGE2tbSKvJ6nhmiRq9LUBPsG7g9EgDn4gsI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743125786; c=relaxed/simple;
	bh=8JArjRxnFIEWAa8Z3EZ6r/0xEXjHpy2xMRzcmhybK8E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=P3VpADcvMh9+5QoafUQyVdvs+kObkAyZpXuyLtdn5a3JC7upNI4ILVFW+zH93Sli3jui3EXGxiiAKU1mXPoAtbDyeRD46Cc/BiqFv53yPm/TegzEgAUPCZXtb9LO+q3euvYwqe2oSYt7xXjTOn26dIj2tCdH8bXarTHGt08ljZc=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b=Mh1OCcnG; arc=pass smtp.client-ip=136.143.184.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=dmitry.osipenko@collabora.com header.b="Mh1OCcnG"
ARC-Seal: i=1; a=rsa-sha256; t=1743125763; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=RQRS6F8pY0ZJ6se+EmJajCBo02km4vAJbM5kE5YWpB6mEu9dP2AFkvHzPsLxuRrVkCon4JJ+RO93K/qCNl9vdJ27SE0fyLYdTyCqcJL7ST9Utn241Fj2F1xV223GNmIjolbJw2LXwVNPUb1xsR3JQeDw2C29dANeJ/SxYxzMB6k=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1743125763; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=v+83m7PeA/Hi77apWlhVpRurgQRvbvqEjxvPe005cPI=; 
	b=B/TYuOLC2uHclrYTLu8tlqPEdkpFZ6lhKw30t1o6MoAznSLgDsIbXKKVAmOdFmUuMLVjsYZ3rkVyFOTRMlV9Z1NLeEOk65yeXuZ/POngx+IvQuWZ/+8kiTXmEZWB8PS4wlSOUJSuFWpqINNSaSd0YLZIg4U6BwfGw8xLFzKqsXk=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=dmitry.osipenko@collabora.com;
	dmarc=pass header.from=<dmitry.osipenko@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1743125763;
	s=zohomail; d=collabora.com; i=dmitry.osipenko@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=v+83m7PeA/Hi77apWlhVpRurgQRvbvqEjxvPe005cPI=;
	b=Mh1OCcnGh9vuwx9w+gZUo9FrVDe0z8qpcBA28Qb3BdVsMNBjaq3kkXVvITmKiMLq
	clbYuOQudpjzyV2Jv+Qf1Yy/FTrzgxkQAqVIBQei5HZnVdSSKpT5EOdP5cw7Mdn3Wtl
	IY1bPuiCIrYKDUvEOjiw09QoMdqU2Jaw/IXE/anI=
Received: by mx.zohomail.com with SMTPS id 1743125760960269.99873457084107;
	Thu, 27 Mar 2025 18:36:00 -0700 (PDT)
Message-ID: <ce386264-db89-4e96-865b-59f1fe39858c@collabora.com>
Date: Fri, 28 Mar 2025 04:35:57 +0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 2/2] drm/virtio: Fix missed dmabuf unpinning in error
 path of prepare_fb()
To: "Kasireddy, Vivek" <vivek.kasireddy@intel.com>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>,
 Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Cc: "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
 "virtualization@lists.linux.dev" <virtualization@lists.linux.dev>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "kernel@collabora.com" <kernel@collabora.com>
References: <20250326014902.379339-1-dmitry.osipenko@collabora.com>
 <20250326014902.379339-2-dmitry.osipenko@collabora.com>
 <IA0PR11MB7185345D3DFA8C7900059144F8A62@IA0PR11MB7185.namprd11.prod.outlook.com>
 <16a30d03-9c98-47a4-959f-8671f7cb7fab@collabora.com>
 <IA0PR11MB71851C0607629875CC458A90F8A12@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Language: en-US
From: Dmitry Osipenko <dmitry.osipenko@collabora.com>
In-Reply-To: <IA0PR11MB71851C0607629875CC458A90F8A12@IA0PR11MB7185.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 3/27/25 10:14, Kasireddy, Vivek wrote:
>> Another question, why do we need this fencing for imported dmabuf?
>> Fencing isn't done host/guest blobs in this code, while dmabuf is
>> essentially a guest blob. Could you please clarify why this fence is
>> needed? Maybe we shouldn't allocate fence in the first place for the dmabuf.
> At-least for the non-virgl use-cases (where the rendering is done in the Guest such
> as in passthrough), this Guest/Host synchronization fence serves two purposes:
> - It prevents the Guest from reusing/destroying the submitted buffer (Guest compositor
>   FB) until the Host is done using it. Otherwise, the Guest compositor might render
>   into this buffer at the same time while the Host is consuming it, leading to issues
>   such as tearing/flickering. This problem is more noticeable in cases where the
>   Guest compositor has only one backbuffer such as Xorg + dirtfyFb.
> 
> - It also prevents the Guest compositor from rendering faster than the Host refresh
>   rate. In other words, it just sets the upper bound in terms of the buffer submission
>   rate as there is no point in going over the Host refresh rate, which would likely
>   lead to wastage of GPU cycles and dropped frames.
> 
> Therefore, this fence is really needed for Guest blobs including imported dmabufs.

Thanks a lot

-- 
Best regards,
Dmitry
