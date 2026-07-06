Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84B32373BE9;
	Mon,  6 Jul 2026 13:42:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783345348; cv=none; b=SHwG7B8rQ12YNHiYANr3cBCaXreAfnG6+iT/gYMQlHXoXcQkRoF5kl1HPUW2ThzwisNU88C9hBCXINqatfnZ5rDcMVdtf9M/Wtvc90rmPR2SOwLim/N2CXy5jMjVBguavwNI2ZZzhZbT8c1ApwJboqpcZtLV+WMaBooFctWpUms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783345348; c=relaxed/simple;
	bh=Bf9TEhjnIv7p3uyWiiMpGGXRCFUOSZvCJT6gu98OnTo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=IMC/voqZih5PM4ZbNKZI+H9Z+icf6YwrHO8/oduCr/fjs94XuTOsU3c8bqc9Ns6JQVszvi6Ta9f3KixL1o4mg+A/ErUSTzz607CJQZJ4bLCyPiOfzZCeKAHwnSe92aKDjKADWPuXSEhPlkeYv0og656mS6nz3i+zfLNwxFUYcbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nkgP/n7t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nkgP/n7t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 801241F00A3D;
	Mon,  6 Jul 2026 13:42:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783345347;
	bh=iAlZCQGUqTVxw4RwuBqXjYr6D5K+9yUEa8qoM9jBo3M=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=nkgP/n7twFmqF0clZhGQQG+LGD5VNF6GHhY8VIqGYI76p0Oud8VDaaFu4Ca1g8ygI
	 2gjs+zvDxPxjjUf2vMMVBD735i92FrrTz7k7OgM1YhwpjVCtS/YkOChEOPAapHrn1+
	 4LYVpV4gRdm9Cnw+ibIJX0bq5iO6wHjFWRNAbgMac2w9gOU2NFgRei0vgYWXEgvuDG
	 muSQtgD2wPYMEZFTqM2tZ/U9VWqel/gArnXxN1OF0Gv9IkHkrTmy9XkWUd8uf7zyvw
	 pcEDwzHLdKFLnEx+1VgeTZQQbb5P3pZLJ1X3Copc1oVMuNiLmdGDn5yAamD2OHyera
	 iV/5Gerl+iSZQ==
Message-ID: <23a81009-7ed2-43ec-9f6c-731225ac3667@kernel.org>
Date: Mon, 6 Jul 2026 15:42:22 +0200
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] virtio_balloon: prime stats vq after
 virtio_device_ready()
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: linux-kernel@vger.kernel.org, Jason Wang <jasowang@redhat.com>,
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, =?UTF-8?Q?Eugenio_P=C3=A9rez?=
 <eperezma@redhat.com>, Adam Litke <agl@us.ibm.com>,
 Rusty Russell <rusty@rustcorp.com.au>, virtualization@lists.linux.dev,
 Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org
References: <2f0d0de033f3005d3b985883be3e5cf37b3f6c42.1783278596.git.mst@redhat.com>
 <13794c5e-375a-4fc5-84b4-a637d077f8a0@kernel.org>
 <20260706042207-mutt-send-email-mst@kernel.org>
 <6b8e4ad3-6909-4d0a-89a4-104a5ad9fe79@kernel.org>
 <20260706044122-mutt-send-email-mst@kernel.org>
 <24336f56-1024-4c9b-8653-b1a4658b627c@kernel.org>
 <20260706070936-mutt-send-email-mst@kernel.org>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260706070936-mutt-send-email-mst@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 7/6/26 14:59, Michael S. Tsirkin wrote:
> On Mon, Jul 06, 2026 at 10:57:33AM +0200, David Hildenbrand (Arm) wrote:
>> On 7/6/26 10:43, Michael S. Tsirkin wrote:
>>>
>>> Sorry I do not get the question. Virtio API expects
>>> callers to serialize calls for each VQ. So this just prevents the work
>>> from running and accessing the VQ while probe calls add_buf/kick.
>>> I'll add a comment explaining that.
>>> But it has nothing to do with the spec.
>>
>> The device is clearly not properly initialized yet.
>>
>> Yet, we expect that we get a stats_request() callback that would try to
>> queue_work(). And IIUC, the stats_request() will be directly issued by the device.
> 
> With an in-spec device, it can happen right after virtio_device_ready.
> We could defer it a bit, but I don't see what this gets us, and
> this also protects against any out of spec ones.

Agreed.

> 
> 
>> In QEMU, that would mean that balloon_stats_poll_cb() runs, which would do a
>>
>> if (s->stats_vq_elem == NULL) {
>> 	...
>> 	return
>> }
>>
>> virtqueue_push(s->svq, s->stats_vq_elem, 0);
>> virtio_notify(vdev, s->svq);
>>
>>
>> That's why I'm confused :)
> 
> First the spec says there could be interrupts for no reasons right after
> DRIVER_OK. Second there are situations in which qemu might
> consume a buffer without a kick and then an interrupt
> races with the kick.

Okay, makes sense, thanks.

-- 
Cheers,

David
