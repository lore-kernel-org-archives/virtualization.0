From: "Nicholas A. Bellinger" <nab@linux-iscsi.org>
Subject: Re: [PATCH 1/2 v1] blkdrv: Add queue limits parameters for sg
	block drive
Date: Thu, 23 Aug 2012 17:45:01 -0700
Message-ID: <1345769101.10190.124.camel__12002.5150165477$1345769118$gmane$org@haakon2.linux-iscsi.org>
References: <1345537427-21601-1-git-send-email-mc@linux.vnet.ibm.com>
	<50334B51.6050900@redhat.com> <503357B2.5040901@linux.vnet.ibm.com>
	<CAJSP0QX8BL9R_M0NxisiP+wejjgh6C6-nz9LPAfgHppPpNpYnA@mail.gmail.com>
	<50335F78.1030005@redhat.com> <5034BCD1.9020603@linux.vnet.ibm.com>
	<5034CBF8.3050602@redhat.com>
	<20120822131348.GA3512@stefanha-thinkpad.localdomain>
	<5034E918.4030305@redhat.com> <5035F873.6090305@linux.vnet.ibm.com>
	<5035FFF4.4040603@redhat.com>
	<CAJSP0QXG3yzxnwAJd3s0M0eSUM39XRdYEmGtj0h83_de4mxaAA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <CAJSP0QXG3yzxnwAJd3s0M0eSUM39XRdYEmGtj0h83_de4mxaAA@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, zwanp@cn.ibm.com, linuxram@us.ibm.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Cong Meng <mc@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2012-08-23 at 11:08 +0100, Stefan Hajnoczi wrote:
> On Thu, Aug 23, 2012 at 11:03 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> > Il 23/08/2012 11:31, Cong Meng ha scritto:
> >>> For disks, this should be fixed simply by using scsi-block instead of
> >>> scsi-generic.
> >>>
> >>> CD-ROMs are indeed more complicated because burning CDs cannot be done
> >>> with syscalls. :/
> >>
> >> So, as the problem exist to CD-ROM, I will continue to get these patches
> >> move on.
> >
> > I'm still trying to understand the extent of the problem.
> >
> > The problem occurs for _USB_ CD-ROMs according to Ben.  Passthrough of
> > USB storage devices should be done via USB passthrough, not virtio-scsi.
> >  If we do USB passthrough via the SCSI layer we miss on all the quirks
> > that the OS may do based on the USB product/vendor pairs.  There's no
> > end to these, and some of the quirks may cause the device to lock up or
> > corruption.
> >
> > I'd rather see a reproducer using SAS/ATA/ATAPI disks before punting.
> 
> This issue affects passthrough: either an entire sg device or at least
> a SG_IO ioctl (e.g. a non-READ/WRITE SCSI command).
> 
> To reproduce it, check host queue limits and guest virtio-scsi queue
> limits.  Then pick a command that can exceed the limits and try it
> from inside the guest :).
> 

Just following along on this thread, and wanted to add a few of my
experiences with this scenario from the kernel target perspective..

So up until very recently, TCM would accept an I/O request for an DATA
I/O type CDB with a max_sectors larger than the reported max_sectors for
it's TCM backend (regardless of backend type), and silently generate N
backend 'tasks' to complete the single initiator generated command.
Also FYI for Paolo, for control type CDBs I've never actually seen an
allocation length exceed max_sectors, so in practice AFAIK this only
happens for DATA I/O type CDBs.

This was historically required by the pSCSI backend driver (using a
number of old SCSI passthrough interfaces) in order to support this very
type of case described above, but over the years the logic ended up
creeping into various other non-passthrough backend drivers like IBLOCK
+FILEIO.  So for v3.6-rc1 code, hch ended up removing the 'task' logic
thus allowing backends (and the layers below) to the I/O sectors >
max_sectors handling work, allowing modern pSCSI using struct request to
do the same.  (hch assured me this works now for pSCSI)

Anyways, I think having the guest limit virtio-scsi DATA I/O to
max_sectors based upon the host accessible block limits is reasonable
approach to consider.  Reducing this value even further based upon the
lowest max_sectors available amongst possible migration hosts would be a
good idea here to avoid having to reject any I/O's exceeding a new
host's device block queue limits.

--nab
