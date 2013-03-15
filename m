From: Asias He <asias@redhat.com>
Subject: Re: [PATCH V2 WIP 0/2] vhost-scsi: new device supporting the
	tcm_vhost Linux kernel module
Date: Fri, 15 Mar 2013 08:58:03 +0800
Message-ID: <20130315005803.GD13095@hj.localdomain>
References: <1363069782-10735-1-git-send-email-asias@redhat.com>
	<20130314042514.GA28504@hj.localdomain>
	<20130314092542.GB7892@hj.localdomain>
	<20130314094643.GD14977@redhat.com> <51419FB8.6010805@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <51419FB8.6010805@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, target-devel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Mar 14, 2013 at 11:00:24AM +0100, Paolo Bonzini wrote:
> 
> >> --------------- 8 ---------------> seabios patch:
> >> diff --git a/src/virtio-scsi.c b/src/virtio-scsi.c
> >> index 879ddfb..4de1255 100644
> >> --- a/src/virtio-scsi.c
> >> +++ b/src/virtio-scsi.c
> >> @@ -147,6 +147,9 @@ init_virtio_scsi(struct pci_device *pci)
> >>          goto fail;
> >>      }
> >>  
> >> +    vp_set_status(ioaddr, VIRTIO_CONFIG_S_ACKNOWLEDGE |
> >> +                  VIRTIO_CONFIG_S_DRIVER | VIRTIO_CONFIG_S_DRIVER_OK);
> >> +
> >>      int i, tot;
> >>      for (tot = 0, i = 0; i < 256; i++)
> >>          tot += virtio_scsi_scan_target(pci, ioaddr, vq, i);
> >> @@ -154,8 +157,6 @@ init_virtio_scsi(struct pci_device *pci)
> >>      if (!tot)
> >>          goto fail;
> >>  
> >> -    vp_set_status(ioaddr, VIRTIO_CONFIG_S_ACKNOWLEDGE |
> >> -                  VIRTIO_CONFIG_S_DRIVER | VIRTIO_CONFIG_S_DRIVER_OK);
> >>      return;
> >>  
> >>  fail:
> 
> ACK.

I will include your ack.

> >> diff --git a/src/virtio-scsi.h b/src/virtio-scsi.h
> >> index bbfbf30..96c3701 100644
> >> --- a/src/virtio-scsi.h
> >> +++ b/src/virtio-scsi.h
> >> @@ -26,7 +26,7 @@ struct virtio_scsi_req_cmd {
> >>      u8 prio;
> >>      u8 crn;
> >>      char cdb[VIRTIO_SCSI_CDB_SIZE];
> >> -};
> >> +} __attribute__((packed));
> >>  
> >>  /* This is the first element of the "in" scatter-gather list. */
> >>  struct virtio_scsi_resp_cmd {
> >> @@ -36,7 +36,7 @@ struct virtio_scsi_resp_cmd {
> >>      u8 status;
> >>      u8 response;
> >>      u8 sense[VIRTIO_SCSI_SENSE_SIZE];
> >> -};
> >> +} __attribute__((packed));
> >>  
> >>  #define VIRTIO_SCSI_S_OK            0
> > 
> > I see, the padding creates the problem?
> 
> Looks like it does for req_cmd (which has length 51 and is padded to
> 56).  QEMU incorrectly relies on the framing.  Both of these are SeaBIOS
> bugs, please do submit the patch.

Will submit shortly.

-- 
Asias
