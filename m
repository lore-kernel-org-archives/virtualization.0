From: Lee Jones <lee.jones@linaro.org>
Subject: Re: [PATCH v2 12/24] scsi: virtio_scsi: Demote seemingly
 unintentional kerneldoc header
Date: Mon, 13 Jul 2020 12:53:48 +0100
Message-ID: <20200713115348.GE3500@dell>
References: <20200713080001.128044-1-lee.jones@linaro.org>
 <20200713080001.128044-13-lee.jones@linaro.org>
 <20200713071453-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20200713071453-mutt-send-email-mst@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: jejb@linux.ibm.com, martin.petersen@oracle.com, linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org, Jason Wang <jasowang@redhat.com>, Stefan Hajnoczi <stefanha@redhat.com>, virtualization@lists.linux-foundation.org, Paolo Bonzini <pbonzini@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 13 Jul 2020, Michael S. Tsirkin wrote:

> On Mon, Jul 13, 2020 at 08:59:49AM +0100, Lee Jones wrote:
> > This is the only use of kerneldoc in the sourcefile and no
> > descriptions are provided.
> > 
> > Fixes the following W=1 kernel build warning(s):
> > 
> >  drivers/scsi/virtio_scsi.c:109: warning: Function parameter or member 'vscsi' not described in 'virtscsi_complete_cmd'
> >  drivers/scsi/virtio_scsi.c:109: warning: Function parameter or member 'buf' not described in 'virtscsi_complete_cmd'
> > 
> > Cc: "Michael S. Tsirkin" <mst@redhat.com>
> > Cc: Jason Wang <jasowang@redhat.com>
> > Cc: Stefan Hajnoczi <stefanha@redhat.com>
> > Cc: virtualization@lists.linux-foundation.org
> > Signed-off-by: Lee Jones <lee.jones@linaro.org>
> > Acked-by: Paolo Bonzini <pbonzini@redhat.com>
> 
> Acked-by: Michael S. Tsirkin <mst@redhat.com>

Thank you Michael.

> Pls merge with the rest of the patches (which tree is this for?)

My assumption is that Martin will take all of these (and the other
sets) via the SCSI repo.

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
