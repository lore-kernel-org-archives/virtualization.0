Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F31E938E8AB;
	Thu,  9 Jul 2026 09:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783590901; cv=none; b=Wjy95b5DoKscXZ9ESJrL0IfD57e5PmZyD1VR9lxA/Vwt0/vOWRN70/vzU3sIMVdbqkPU1dhilXQdSPH/HrpLSyEnhvPOtWLbc4efX8UfpPfeLzeKnihcTZmjEbaYsGJ42fxrhGHOpjC1v90htlTpZieu6tpEqoAVO5uQ15Isc6I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783590901; c=relaxed/simple;
	bh=aNqBlYGTGT4KRpHlFwn03oIJtvjL8zDkMngwOkt+79k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JHvXbJShSsyNu61nG4OaEfe2Mnkhr7JPqU5xfjxRkT6pZkTQdRVOI2dbifdoIyHsnqflBJyz5zvypROkTlJroYbimmaE5g0Ux7+vxJTZeYgMVe8C/2uV+R+Y1+N/OjvqBE6wIJPv8vv0mQwIJ0smKjR8J8vlZf5Q5R4k63CZ6gA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KmBS8T50; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KmBS8T50"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 314C31F000E9;
	Thu,  9 Jul 2026 09:54:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783590899;
	bh=NjeUshYgRJMX8YWgraXAQFLYRE/xKsfyWU6Utb3POWI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=KmBS8T50EnDG8x55eIg9uu4OJ9EdgaIjwJfMQ1H4SC8O4bV5U5cVQ4RjaZmIehodT
	 cG1WxDhbFI6JhNzjF6B3LsTRPS1c3O0JEtXljwocV1sbxXAOEBLVwOoUVdfIZyvOII
	 Q8QXkyhX2tBYO1RAnOOj2yFloAoiIgcJ/hIbDqST5LwT4H14eqfqhuvcuVakZcZ4PG
	 2FWVPsg/VXCbYdxmu/At7JJpGSClppNvfjOCvAYYNF5Sg6CwWQjK13s591jyPHXfTh
	 AbcrERm4rX1zV5B+TbUbTekvnOv/A5gmASxa2K1vmtq/2QtMZSOgAhQx1wTwNuxBEW
	 6ylAg5vRsA5Gg==
Date: Thu, 9 Jul 2026 10:55:18 +0100
From: Jean-Philippe Brucker <jpb@kernel.org>
To: raoxu <raoxu@uniontech.com>
Cc: joro@8bytes.org, will@kernel.org, robin.murphy@arm.com,
	virtualization@lists.linux.dev, iommu@lists.linux.dev,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iommu/virtio: reject short event buffers
Message-ID: <20260709095518.GA1752964@myrica>
References: <6800BE0812AF0897+20260706083148.788991-1-raoxu@uniontech.com>
Precedence: bulk
X-Mailing-List: virtualization@lists.linux.dev
List-Id: <virtualization.lists.linux.dev>
List-Subscribe: <mailto:virtualization+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:virtualization+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6800BE0812AF0897+20260706083148.788991-1-raoxu@uniontech.com>

On Mon, Jul 06, 2026 at 04:31:48PM +0800, raoxu wrote:
> From: Xu Rao <raoxu@uniontech.com>
> 
> The event queue uses fixed-size buffers for struct viommu_event. The
> device-reported used length is currently only checked for oversized
> buffers, so a short used buffer can still be passed to the fault
> handler.

Thank you for the patch. The buffer is allowed to be smaller than struct
virtio_iommu_fault, because valid fields depend on flags:

	struct virtio_iommu_fault {
		u8 reason;
		u8 reserved[3];
		le32 flags;
		le32 endpoint;
		le32 reserved1;
		le64 address;
	};
	
	#define VIRTIO_IOMMU_FAULT_F_READ	(1 << 0)
	#define VIRTIO_IOMMU_FAULT_F_WRITE      (1 << 1)
	#define VIRTIO_IOMMU_FAULT_F_ADDRESS    (1 << 8)

If F_ADDRESS isn't set, the address field is invalid. The spec (Virtio v1.3)
says in 5.13.6.9.2 "Device Requirements: Fault reporting"

  "The device MAY omit setting VIRTIO_IOMMU_FAULT_F_ADDRESS and writing
   address in any fault report, regardless of the reason."

I think the current check aims to catch newer implementations that would
use an extended virtio_iommu_fault to report recoverable faults, but I'm
not sure anymore.

Overall the driver assumes that the IOMMU device is well behaved. If we
want to add sanity checks, maybe viommu_fault_handler() should check len
depending on flags. But I suspect more work is needed if we change the
security model to not trust the device.

Thanks,
Jean

> 
> In that case the handler parses fields that were not written by the
> device for this event, potentially using stale data from a previous
> event and reporting a bogus fault.
> 
> Reject any event buffer whose used length is not exactly the expected
> event size. Still recycle the buffer back to the event queue so a bad
> event does not permanently shrink the queue.
> 
> Signed-off-by: Xu Rao <raoxu@uniontech.com>
> ---
>  drivers/iommu/virtio-iommu.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/iommu/virtio-iommu.c b/drivers/iommu/virtio-iommu.c
> index 587fc13197f1..3ace4a6dd02a 100644
> --- a/drivers/iommu/virtio-iommu.c
> +++ b/drivers/iommu/virtio-iommu.c
> @@ -635,7 +635,7 @@ static void viommu_event_handler(struct virtqueue *vq)
>  	struct viommu_dev *viommu = vq->vdev->priv;
> 
>  	while ((evt = virtqueue_get_buf(vq, &len)) != NULL) {
> -		if (len > sizeof(*evt)) {
> +		if (len != sizeof(*evt)) {
>  			dev_err(viommu->dev,
>  				"invalid event buffer (len %u != %zu)\n",
>  				len, sizeof(*evt));
> --
> 2.50.1
> 
