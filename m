From: "Martin K. Petersen" <martin.petersen@oracle.com>
Subject: Re: [PATCH] scsi: virtio_scsi: remove unnecessary condition check
Date: Tue, 14 Jul 2020 00:58:47 -0400
Message-ID: <159470266467.11195.10910825066875185491.b4-ty@oracle.com>
References: <1594307167-8807-1-git-send-email-xianting_tian@126.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-scsi-owner@vger.kernel.org>
In-Reply-To: <1594307167-8807-1-git-send-email-xianting_tian@126.com>
Sender: linux-scsi-owner@vger.kernel.org
To: mst@redhat.com, pbonzini@redhat.com, jasowang@redhat.com, Xianting Tian <xianting_tian@126.com>, jejb@linux.ibm.com, stefanha@redhat.com
Cc: "Martin K . Petersen" <martin.petersen@oracle.com>, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 9 Jul 2020 11:06:07 -0400, Xianting Tian wrote:

> kmem_cache_destroy and mempool_destroy can correctly handle
> null pointer parameter, so there is no need to check if the
> parameter is null before calling kmem_cache_destroy and
> mempool_destroy.

Applied to 5.9/scsi-queue, thanks!

[1/1] scsi: virtio_scsi: Remove unnecessary condition check
      https://git.kernel.org/mkp/scsi/c/92e8d0323a51

-- 
Martin K. Petersen	Oracle Linux Engineering
