Return-Path: <virtualization-bounces@lists.linux-foundation.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ECABFEB64DC
	for <virtualization@archiver.kernel.org>; Tue, 11 Jul 2023 14:22:40 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
	by smtp3.osuosl.org (Postfix) with ESMTP id 661AC610E1;
	Tue, 11 Jul 2023 14:22:40 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 661AC610E1
Authentication-Results: smtp3.osuosl.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=ErqjTvmm
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
	by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id jeNzqRpRtEPf; Tue, 11 Jul 2023 14:22:39 +0000 (UTC)
Received: from lists.linuxfoundation.org (lf-lists.osuosl.org [IPv6:2605:bc80:3010:104::8cd3:938])
	by smtp3.osuosl.org (Postfix) with ESMTPS id 3E8F960B5A;
	Tue, 11 Jul 2023 14:22:38 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 3E8F960B5A
Received: from lf-lists.osuosl.org (localhost [127.0.0.1])
	by lists.linuxfoundation.org (Postfix) with ESMTP id 1A808C0071;
	Tue, 11 Jul 2023 14:22:38 +0000 (UTC)
Received: from smtp3.osuosl.org (smtp3.osuosl.org [140.211.166.136])
 by lists.linuxfoundation.org (Postfix) with ESMTP id BC374C0032
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 14:22:36 +0000 (UTC)
Received: from localhost (localhost [127.0.0.1])
 by smtp3.osuosl.org (Postfix) with ESMTP id 89F56610DD
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 14:22:36 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org 89F56610DD
X-Virus-Scanned: amavisd-new at osuosl.org
Received: from smtp3.osuosl.org ([127.0.0.1])
 by localhost (smtp3.osuosl.org [127.0.0.1]) (amavisd-new, port 10024)
 with ESMTP id muCLfaM9jD3Q
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 14:22:36 +0000 (UTC)
X-Greylist: domain auto-whitelisted by SQLgrey-1.8.0
DKIM-Filter: OpenDKIM Filter v2.11.0 smtp3.osuosl.org C261960B5A
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by smtp3.osuosl.org (Postfix) with ESMTPS id C261960B5A
 for <virtualization@lists.linux-foundation.org>;
 Tue, 11 Jul 2023 14:22:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1689085354;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=S2e0wUM/sdkEvMSMHJiuupQ8qcMYkXyrDarJeT0G2Zc=;
 b=ErqjTvmmO21MGdiI33ya26yDfnzAx+jQXC/mbB8h1+6BErlTTBWZE06C2znq60Y8De+1h+
 giKF+zR8Fu/UDpwmgflvIem5NRBbEgtU23mEP4uPRJpP+u8QSfDA4x3XnPGNFHSnE/fg9l
 VC8RY/ja3ExODi5RXpW8rAxBF66w37Q=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-408-nSLEsZUzOaafrIBJDdnmXQ-1; Tue, 11 Jul 2023 10:22:31 -0400
X-MC-Unique: nSLEsZUzOaafrIBJDdnmXQ-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com
 [10.11.54.10])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 3E8181C3725A;
 Tue, 11 Jul 2023 14:18:47 +0000 (UTC)
Received: from [10.39.208.24] (unknown [10.39.208.24])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 636D44CD0C6;
 Tue, 11 Jul 2023 14:18:45 +0000 (UTC)
Message-ID: <8c1f1d67-4b81-f33d-bbc0-1c84ad05e183@redhat.com>
Date: Tue, 11 Jul 2023 16:18:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Content-Language: en-US
To: Cindy Lu <lulu@redhat.com>, jasowang@redhat.com, mst@redhat.com,
 xieyongji@bytedance.com, kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
 virtualization@lists.linux-foundation.org, netdev@vger.kernel.org
References: <20230628065919.54042-1-lulu@redhat.com>
 <20230628065919.54042-3-lulu@redhat.com>
From: Maxime Coquelin <maxime.coquelin@redhat.com>
Subject: Re: [RFC 2/4] vduse: Add file operation for mmap
In-Reply-To: <20230628065919.54042-3-lulu@redhat.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.10
X-BeenThere: virtualization@lists.linux-foundation.org
X-Mailman-Version: 2.1.15
Precedence: list
List-Id: Linux virtualization <virtualization.lists.linux-foundation.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>, 
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>



On 6/28/23 08:59, Cindy Lu wrote:
> From: Your Name <you@example.com>
> 
> Add the operation for mmap, The user space APP will
> use this function to map the pages to userspace
> 
> Signed-off-by: Cindy Lu <lulu@redhat.com>
> ---
>   drivers/vdpa/vdpa_user/vduse_dev.c | 49 ++++++++++++++++++++++++++++++
>   1 file changed, 49 insertions(+)
> 
> diff --git a/drivers/vdpa/vdpa_user/vduse_dev.c b/drivers/vdpa/vdpa_user/vduse_dev.c
> index f845dc46b1db..1b833bf0ae37 100644
> --- a/drivers/vdpa/vdpa_user/vduse_dev.c
> +++ b/drivers/vdpa/vdpa_user/vduse_dev.c
> @@ -1313,6 +1313,54 @@ static struct vduse_dev *vduse_dev_get_from_minor(int minor)
>   	return dev;
>   }
>   
> +
> +static vm_fault_t vduse_vm_fault(struct vm_fault *vmf)
> +{
> +	struct vduse_dev *dev = vmf->vma->vm_file->private_data;
> +	struct vm_area_struct *vma = vmf->vma;
> +	u16 index = vma->vm_pgoff;
> +
> +	struct vdpa_reconnect_info *info;
> +	info = &dev->reconnect_info[index];
> +
> +	vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);
> +	if (remap_pfn_range(vma, vmf->address & PAGE_MASK, PFN_DOWN(info->addr),
> +			    PAGE_SIZE, vma->vm_page_prot))
> +		return VM_FAULT_SIGBUS;
> +	return VM_FAULT_NOPAGE;
> +}
> +
> +static const struct vm_operations_struct vduse_vm_ops = {
> +	.fault = vduse_vm_fault,
> +};
> +
> +static int vduse_mmap(struct file *file, struct vm_area_struct *vma)
> +{
> +	struct vduse_dev *dev = file->private_data;
> +	struct vdpa_reconnect_info *info;
> +	unsigned long index = vma->vm_pgoff;
> +
> +	if (vma->vm_end - vma->vm_start != PAGE_SIZE)
> +		return -EINVAL;
> +	if ((vma->vm_flags & VM_SHARED) == 0)
> +		return -EINVAL;
> +
> +	if (index > 65535)
> +		return -EINVAL;

You declare an array of 64 entries in patch 1, so it can overflow.

> +
> +	info = &dev->reconnect_info[index];
> +	if (info->addr & (PAGE_SIZE - 1))
> +		return -EINVAL;
> +	if (vma->vm_end - vma->vm_start != info->size) {
> +		return -ENOTSUPP;
> +	}
> +
> +	vm_flags_set(vma, VM_IO | VM_PFNMAP | VM_DONTEXPAND | VM_DONTDUMP);
> +	vma->vm_ops = &vduse_vm_ops;
> +
> +	return 0;
> +}
> +
>   static int vduse_dev_open(struct inode *inode, struct file *file)
>   {
>   	int ret;
> @@ -1345,6 +1393,7 @@ static const struct file_operations vduse_dev_fops = {
>   	.unlocked_ioctl	= vduse_dev_ioctl,
>   	.compat_ioctl	= compat_ptr_ioctl,
>   	.llseek		= noop_llseek,
> +	.mmap		= vduse_mmap,
>   };
>   
>   static struct vduse_dev *vduse_dev_create(void)

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linuxfoundation.org/mailman/listinfo/virtualization
