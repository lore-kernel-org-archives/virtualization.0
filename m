From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2 v1] blkdrv: Add queue limits parameters for sg block
	drive
Date: Fri, 24 Aug 2012 09:56:18 +0200
Message-ID: <503733A2.1050300@redhat.com>
References: <1345537427-21601-1-git-send-email-mc@linux.vnet.ibm.com>
	<50334B51.6050900@redhat.com> <503357B2.5040901@linux.vnet.ibm.com>
	<CAJSP0QX8BL9R_M0NxisiP+wejjgh6C6-nz9LPAfgHppPpNpYnA@mail.gmail.com>
	<50335F78.1030005@redhat.com> <5034BCD1.9020603@linux.vnet.ibm.com>
	<5034CBF8.3050602@redhat.com>
	<20120822131348.GA3512@stefanha-thinkpad.localdomain>
	<5034E918.4030305@redhat.com> <5035F873.6090305@linux.vnet.ibm.com>
	<5035FFF4.4040603@redhat.com>
	<CAJSP0QXG3yzxnwAJd3s0M0eSUM39XRdYEmGtj0h83_de4mxaAA@mail.gmail.com>
	<1345769101.10190.124.camel@haakon2.linux-iscsi.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1345769101.10190.124.camel@haakon2.linux-iscsi.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, zwanp@cn.ibm.com, linuxram@us.ibm.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Cong Meng <mc@linux.vnet.ibm.com>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

Il 24/08/2012 02:45, Nicholas A. Bellinger ha scritto:
> So up until very recently, TCM would accept an I/O request for an DATA
> I/O type CDB with a max_sectors larger than the reported max_sectors for
> it's TCM backend (regardless of backend type), and silently generate N
> backend 'tasks' to complete the single initiator generated command.

This is what QEMU does if you use scsi-block, except for MMC devices
(because of the insanity of the commands used for burning).

> Also FYI for Paolo, for control type CDBs I've never actually seen an
> allocation length exceed max_sectors, so in practice AFAIK this only
> happens for DATA I/O type CDBs.

Yes, that was my impression as well.

> This was historically required by the pSCSI backend driver (using a
> number of old SCSI passthrough interfaces) in order to support this very
> type of case described above, but over the years the logic ended up
> creeping into various other non-passthrough backend drivers like IBLOCK
> +FILEIO.  So for v3.6-rc1 code, hch ended up removing the 'task' logic
> thus allowing backends (and the layers below) to the I/O sectors >
> max_sectors handling work, allowing modern pSCSI using struct request to
> do the same.  (hch assured me this works now for pSCSI)

So now LIO and QEMU work the same.  (Did he test tapes too?)

> Anyways, I think having the guest limit virtio-scsi DATA I/O to
> max_sectors based upon the host accessible block limits is reasonable
> approach to consider.  Reducing this value even further based upon the
> lowest max_sectors available amongst possible migration hosts would be a
> good idea here to avoid having to reject any I/O's exceeding a new
> host's device block queue limits.

Yeah, it's reasonable _assuming it is needed at all_.  For disks, it is
not needed.  For CD-ROMs it is, but right now we have only one report
and it is using USB so we don't know if the problem is in the drive or
rather in the USB bridge (whose quality usually leaves much to be desired).

So in the only observed case, the fix would really be a workaround; the
right thing to do with USB devices is to use USB passthrough.

Paolo
