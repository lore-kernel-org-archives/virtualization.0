From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH 6/6] virtio-scsi: Enable DIF/DIX modes in SCSI host LLD
Date: Tue, 20 May 2014 11:24:21 -0700
Message-ID: <1400610261.24043.22.camel__28286.7875452668$1400610279$gmane$org@haakon3.risingtidesystems.com>
References: <1396819929-29687-1-git-send-email-nab@daterainc.com>
	<1396819929-29687-7-git-send-email-nab@daterainc.com>
	<20140407084518.GA14091@redhat.com>
	<1396861019.19888.25.camel@haakon3.risingtidesystems.com>
	<20140507091305.GA20044@redhat.com>
	<1400526423.10964.31.camel@haakon3.risingtidesystems.com>
	<537B13D0.3030007@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <537B13D0.3030007@redhat.com>
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
Cc: linux-scsi <linux-scsi@vger.kernel.org>, "Martin K. Petersen" <martin.petersen@oracle.com>, "Michael S. Tsirkin" <mst@redhat.com>, Sagi Grimberg <sagig@dev.mellanox.co.il>, virtualization@lists.linux-foundation.org, Sagi Grimberg <sagig@mellanox.com>, target-devel <target-devel@vger.kernel.org>, "H. Peter
	Anvin" <hpa@zytor.com>, "Nicholas A. Bellinger" <nab@daterainc.com>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2014-05-20 at 10:35 +0200, Paolo Bonzini wrote:
> Il 19/05/2014 21:07, Nicholas A. Bellinger ha scritto:
> > Hi MST,
> >
> > So I've finally got some cycles to get back to this code, and wanted to
> > verify the outstanding items you had previously raised:
> >
> > - Convert vhost-scsi to be independent of IOV layout using
> >   memcpy_fromiovecend. (Does this effect existing non PI virtio-scsi
> >   operation..?)
> > - Report VIRTIO_F_ANY_LAYOUT feature bit to userspace.
> > - Convert virtio_scsi_cmd_req_pi to bytes field instead of number of
> >   iovecs.
> 
> This is the only item really required, since the bytes field is what 
> will be in VIRTIO 1.0.  The other would be nice to have, but not a 
> blocker for PI support.
> 
> > - Ensure virtio_scsi_cmd_req_pi is naturally aligned
> 
> mst already commented on this.
> 
> > - Figure out why QEMU is not acking (any) vhost-scsi feature bits
> 
> This is a separate bug, isn't it?  It need not block PI support.
> 

Thanks for the feedback.  I'll get the series updated to use bytes
instead of number of iovecs in virtio_scsi_cmd_req_pi, along with a
simple memcpy_fromiovecend conversion.

--nab
