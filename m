Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D7E4357D08
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 20:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791493200; cv=none; b=mcbVM5ZHBYEUmgIXS5UlTi5l1zTkdnZjdxnJE5qxMEb4HooOV/9HahAqnMURPpNwWxQeU6JAlOjvvOajNsx8edWCd+bkupHJt96uxvdBbCDacsvKTORILhdhiZ9JmKTXSbnWKqxIpJYlxSrFTWHTyqxbo+iaNxoojQVt1esVhxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791493200; c=relaxed/simple;
	bh=ZSqN70r27tz0dBTGFGExJE8gBajqQvCl+6z1RjfY5cg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=jsnIIYGvJiGSw1Eg9bozwsfSUJIhxBTeQ1pg/nV4wgvtHfhX+JhrjQ9169FfdBup0TVrzscTKIErsMPRByvr5epI83EViaGBvFsYXWs4JRtbrnoCnRtI4NqTkKsWco7CfbBFOV/EIaLjyRimKlKeQXZuXPtbhwAT/zNQot05qDE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com; spf=pass smtp.mailfrom=invisiblethingslab.com; dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b=HDkaD2HH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Dtg9fjTA; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=invisiblethingslab.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=invisiblethingslab.com header.i=@invisiblethingslab.com header.b="HDkaD2HH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Dtg9fjTA"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id AB1F8EC0327
	for <virtualization@lists.linux.dev>; Thu,  8 Oct 2026 16:59:57 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Thu, 08 Oct 2026 16:59:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	invisiblethingslab.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791493197; x=1791579597; bh=7+AhoGYgBy
	NcaiYeKP8aO75OvP8u4IEViIBwpAS096A=; b=HDkaD2HHXiKLOIJzRRtBiS/kuu
	ZFuk2VBU7fv0DNoonmmzZYBQbTQXAGayoQSExsTmaetb0ONAfPrzwwb/giz0yV7v
	sxjaeSpWsW/ovDYipFsltIYIFHBHynHI8lkifRyeXm3Jsxsx5DBAWW47ncps8K8I
	7rIMXNbN8VNJ3lMMk8hzJVRJvhtD5BogmM9ML4lMCtkGIru9ZXu2C9xqWUQm5Dgk
	bbVVqqot03yIsU4/OHzryBr2knopUDVRd970BUIH6/iqbpeBmw8//nOvwKIZiPLl
	EW3ELCLEXELQW6LbgV+BKR9/+//rlNSEGN/hB6PV7SmFGU0ywmSM00gkmtoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1791493197; x=
	1791579597; bh=7+AhoGYgByNcaiYeKP8aO75OvP8u4IEViIBwpAS096A=; b=D
	tg9fjTAvPJ9OhvaLC8feeBlklqc1zaObW29YJqw9P+mLBMqldjj4KWlqyvgvdrY7
	MqqBNPouZh+VF5qmCC1SJ9ZmsMrP4bnbOTwLkqAFEZtRdAeaV1eC9LB3nGvpArKP
	WCjD5FrAEQTPX3kffA4qwzz41EsIAU/3CtGpecx68rSTmgp7h5kCNtuv//+N4DUi
	VHoVHZjoB6ntoiTtCFu+n2JKHmLw0h5bqYSaezshrFjIVSxybkIQ/U8YWlkeiCEj
	HPkizOg+wuYC9rvLLxWLOoik5EHCpOhHVl8ZI6cNQP2KO+5ognRsvI/ygJv+oPvZ
	UsVUiPasMhM9ibSHBrmAA==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=invisiblethingslab.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791493197; d=invisiblethingslab.com;
	mf=PHZhbEBpbnZpc2libGV0aGluZ3NsYWIuY29tPg==;
	rt=PHZpcnR1YWxpemF0aW9uQGxpc3RzLmxpbnV4LmRldj4=;
	s=fm1:rsa-sha256:BRwavoDnxWycasaxlA9iJvUTxt8dPF+OAF1MLb/dQgSebq2
	sTqgUCaNbpw/dNRs+dOAt+eo7H2DyoHTZpz2AxlwJDceyZcSc/l+P/mvcdn682YA
	N8kTbov+K+YACXIuiKIyKp4GrNeFG8XBwcbw6RPNQ7t+Whn4GcnUopkPqVXHNlc3
	AMj0N/px6Fx7xqEpcAEqun4CFOD0F60rSgsX/dBXbDbQP7WMQmQ3riwjUSUgM3Yn
	aZLkzs3UHC/Uk40x8q2PmZlFrvGOXXrf8kZ37EgCLYQueSYKay04oSp3eFJ5TtHq
	C5InSKaVTQWqSZV5d8xzhoalTpzpJ8sig5j7UgQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=15;
	hn=autocrypt,cc,content-language,content-transfer-encoding,
	content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:i6JEWJ4IPoj6sTPShGKAeVCIv0NwupZWYTrqHINYiMg=:ZSqN70r27tz0dBTGFGExJE8gBajqQvCl+6z1RjfY5cg=;
X-ME-Sender: <xms:TQTIanUpo6kzgT77SOJl9Q8ZTGfgO6PLri8G5asRgWPcYaTy458elQ>
    <xme:TQTIajS4WR0dLTwqFWxHLB4uSs4DNZ5wstBdWnpnHuHsRhGxS0PQFMi6k6Cgw_eBi
    RsHNftC8YE_ajEMTNnqKLZYAEymvhrz-VU5uV74ZkGVhxI9BjYl>
X-ME-Received: <xmr:TQTIasBzGcqTEiBeq-EsDKVR5QcAE0UQ6xsdQw-1Qrz24BPgPdIYGqdZk2yDkV8R_jFZiwUDsNbWwZMsI27D_BoExDHa6AXGPw>
X-ME-Proxy-Cause: dmFkZTGWHnmgy+7bRoDaOQ8rB99ldtlBzRyzoeZaSC1i9ZR+w9Y50+YZBHoyWGoOSGl/iS
    rrtGM0CUf8X/1jcWn9wdCFp+EmBgTY8pOkA16G/rkskNMOTXsGZ/qqYpyOf7R/tilVFWbg
    Z/Wn75wbEdZkCJF6oQyrPqZSoz6TZHVVJg+Cmwdx6+Cy8GLpHWuOqdSYKVl3DvHv59+1rz
    gWo6xFVkKdeO9I13ZlpJJl6kr7kL6eVRvF9FjBJvTDNYMBGX9zJjWx7tlRZJmWKwqxjkIZ
    DDFh1wWJeyZhotKxBNuXjWOZ14Lp70Rb5JVm6RhIAO7YRlCJl0hCCvBifh7vomSZ7bJZAW
    5c8RHZv5YNqNT1SVJJzPgWX/nIbVY8qqwUU20nW6tdMNdGtKc4FTdXTDIkSkG5VNBVwVC+
    sfCfY3d9mZlGsq1RbBJwzasXhtv1lzhiAk65GqE7hNV2jz4l+xmN6x8W4kxUY1Njx6iJYB
    H8c6kohYtyhLomKz6hTUIgg8rQeGoGdPYDMnZAhktV/9X7gVLONAUSsiMZ5EnmkiMgePyV
    IgMVOO33DqFR+pcyOpjJhX+Uqe4tKNJohTWkilbFkMw48WQWWLGxsTONmV1re8KKgfCr3x
    zn72x4nFrxtjH1ZYJ5U0HmQlTenrDtw0ownjB40VOehOBomg+ZXWZJly8ZVA
X-ME-Proxy: <xmx:TQTIajsQVVDoGvUVokR830jD3vmx82GcVytywP3vjq90ZgVUj54JEw>
    <xmx:TQTIai9zm-AeLomp9CEO6xe7FqpX5HmG-Ma_RIFVA7iYrmI5jbcnkg>
    <xmx:TQTIaiSEHtuCxtHHRvTWaWvk1iLnA9uJIPHhBLmDSyODWdYOBkOQWQ>
    <xmx:TQTIasUuYqIQKZry4Uhs5C9AK3lZbXREZWK4ayd3whuvd2Sz_EprfQ>
    <xmx:TQTIakaIIo1w5HlbJxrr28rqeksuqaLeU7BHfziBwpI_npr9TPi5bJgd>
Feedback-ID: i001e48d0:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 16:59:54 -0400 (EDT)
Message-ID: <4d86ec37-ce27-4556-966e-4b4e80ec0718@invisiblethingslab.com>
Date: Thu, 8 Oct 2026 17:59:51 -0300
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] drm/virtio: do not enforce blob_alignment in
 cross-domain contexts
To: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
 David Airlie <airlied@redhat.com>, Gerd Hoffmann <kraxel@redhat.com>,
 Gurchetan Singh <gurchetansingh@chromium.org>, Chia-I Wu
 <olvaffe@gmail.com>, Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 Simona Vetter <simona@ffwll.ch>, Sergio Lopez <slp@redhat.com>
Cc: dri-devel@lists.freedesktop.org, virtualization@lists.linux.dev,
 linux-kernel@vger.kernel.org
References: <20261006154913.2689067-2-val@invisiblethingslab.com>
 <8b0fbe1a-1410-42d7-8031-611795ae39d9@collabora.com>
Content-Language: en-US
From: Val Packett <val@invisiblethingslab.com>
Autocrypt: addr=val@invisiblethingslab.com; keydata=
 xm8EaFTEiRMFK4EEACIDAwQ+qzawvLuE95iu+QkRqp8P9z6XvFopWtYOaEnYf/nE8KWCnsCD
 jz82tdbKBpmVOdR6ViLD9tzHvaZ1NqZ9mbrszMXq09VfefoCfZp8jnA2yCT8Y4ykmv6902Ne
 NnlkVwrNKFZhbCBQYWNrZXR0IDx2YWxAaW52aXNpYmxldGhpbmdzbGFiLmNvbT7CswQTEwkA
 OxYhBAFMrro+oMGIFPc7Uc87uZxqzalRBQJoVMSJAhsDBQsJCAcCAiICBhUKCQgLAgQWAgMB
 Ah4HAheAAAoJEM87uZxqzalRlIIBf0cujzfSLhvib9iY8LBh8Tirgypm+hJHoY563xhP0YRS
 pmqZ6goIuSGpEKcW5mV3egF/TLLAOjsfroWae4giImTVOJvLOsUycxAP4O5b1Qiy+cCGsHKA
 nCRzrvqnPkyf4OeRznMEaFTEiRIFK4EEACIDAwSffe3tlMmmg3eKVp7SJ+CNZLN0M5qzHSCV
 dBBkIVvEJo+8SDg4jrx/832rxpvMCz2+x7+OHaeBHKafhOWUccYBLKqV/3nBftxCkbzXDbfY
 d02BY9H4wBIn0Y3GnwoIXRgDAQkJwpgEGBMJACAWIQQBTK66PqDBiBT3O1HPO7mcas2pUQUC
 aFTEiQIbDAAKCRDPO7mcas2pUaptAX9f7yUJLGU4C6XjMJvXd8Sz6cGTyxkngPtUyFiNqtad
 /GXBi3vHKYNfSrdqJ8wmZ8MBgOqWaaa1wE4/3qZU8d4RNR8mF7O40WYK/wdf1ycq1uGad8PN
 UDOwAqdfvuF3w8QMPw==
In-Reply-To: <8b0fbe1a-1410-42d7-8031-611795ae39d9@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit


On 10/8/26 4:33 AM, Dmitry Osipenko wrote:
> On 10/6/26 18:42, Val Packett wrote:
>> VIRTIO_GPU_F_BLOB_ALIGNMENT is designed for GPU rendering context types,
>> however VIRTIO_GPU_CAPSET_CROSS_DOMAIN is not one of those. Resources
>> created under cross-domain contexts are arbitrary shared system memory
>> files, which includes unusual things like Wayland keymaps received
>> from the host compositor. Do not enforce alignment requirements there.
>>
>> Fixes: 47248e0d8264 ("drm/virtio: honor blob_alignment requirements")
>> Signed-off-by: Val Packett <val@invisiblethingslab.com>
>> ---
>>
>> v2: also check has_virgl_3d to prevent dereferencing NULL vfpriv
>> v1: https://lore.kernel.org/all/20261006004044.2242154-1-val@invisiblethingslab.com/
>>
>> ~val
>>
>> ---
>>   drivers/gpu/drm/virtio/virtgpu_ioctl.c | 4 +++-
>>   1 file changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>> index 3ddd5481d6bc..4d5ae062834d 100644
>> --- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>> +++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
>> @@ -551,7 +551,9 @@ static int verify_blob(struct virtio_gpu_device *vgdev,
>>   	params->blob_flags = rc_blob->blob_flags;
>>   	params->blob_hints = rc_blob->blob_hints;
>>   
>> -	if (vgdev->has_blob_alignment &&
>> +	if (vgdev->has_blob_alignment && vgdev->has_virgl_3d &&
>> +	    (vfpriv->context_init & VIRTIO_GPU_CONTEXT_INIT_CAPSET_ID_MASK) !=
>> +	    VIRTIO_GPU_CAPSET_CROSS_DOMAIN &&
>>   	    !IS_ALIGNED(params->size, vgdev->blob_alignment))
>>   		return -EINVAL;
>>   
> What userspace has this problem and why it re-purposes virtio-gpu to act
> as udmabuf for arbitrary data that never reaches host?

Sorry, what do you mean by that?

This is not related to data that "never reaches host" at all! The error 
I referred to in the patch message literally says "received *from* the 
host"…??

Guest userspace is any of the cross-domain proxies:

* https://codeberg.org/drakulix/wl-cross-domain-proxy
* https://github.com/talex5/wayland-proxy-virtwl
* https://github.com/google/sommelier-rs (or old C++ version)

VIRTIO_GPU_CAPSET_CROSS_DOMAIN "repurposes virtio-gpu" to act as a 
cross-VM UNIX socket transport that supports fd passing. By referring to 
virtio-gpu resources in the send command the guest can make the device 
send the resources' corresponding host fds to the host Wayland 
compositor. It can refer to resources from other contexts, in order to 
present drm/venus/etc rendered buffers on Wayland surfaces. (i.e. the 
host would send the actual dma-buf from virglrenderer) But the resources 
created on the cross-domain context itself are system memory buffers, 
generally used for software rendering and miscellaneous Wayland "stuff" 
like keymaps which are sent *from* the host, and exposed to Wayland 
clients in the guest. Socket receive handling in rutabaga-gfx stores 
incoming fds and returns their IDs to the guest, then the guest does a 
CREATE_BLOB with matching blob_id, which creates a virtio-gpu resource 
from the incoming buffer, so the guest can just MAP_BLOB it. These are 
the blobs that are not aligned to anything because they're just 
arbitrary memfds on the host.

~val

