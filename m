From: Stefan Hajnoczi <stefanha@gmail.com>
Subject: Re: [PATCH 1/2 v1] blkdrv: Add queue limits parameters for sg block
	drive
Date: Thu, 23 Aug 2012 11:08:22 +0100
Message-ID: <CAJSP0QXG3yzxnwAJd3s0M0eSUM39XRdYEmGtj0h83_de4mxaAA@mail.gmail.com>
References: <1345537427-21601-1-git-send-email-mc@linux.vnet.ibm.com>
	<50334B51.6050900@redhat.com> <503357B2.5040901@linux.vnet.ibm.com>
	<CAJSP0QX8BL9R_M0NxisiP+wejjgh6C6-nz9LPAfgHppPpNpYnA@mail.gmail.com>
	<50335F78.1030005@redhat.com> <5034BCD1.9020603@linux.vnet.ibm.com>
	<5034CBF8.3050602@redhat.com>
	<20120822131348.GA3512@stefanha-thinkpad.localdomain>
	<5034E918.4030305@redhat.com> <5035F873.6090305@linux.vnet.ibm.com>
	<5035FFF4.4040603@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <5035FFF4.4040603@redhat.com>
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
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, zwanp@cn.ibm.com, linuxram@us.ibm.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Cong Meng <mc@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Aug 23, 2012 at 11:03 AM, Paolo Bonzini <pbonzini@redhat.com> wrote:
> Il 23/08/2012 11:31, Cong Meng ha scritto:
>>> For disks, this should be fixed simply by using scsi-block instead of
>>> scsi-generic.
>>>
>>> CD-ROMs are indeed more complicated because burning CDs cannot be done
>>> with syscalls. :/
>>
>> So, as the problem exist to CD-ROM, I will continue to get these patches
>> move on.
>
> I'm still trying to understand the extent of the problem.
>
> The problem occurs for _USB_ CD-ROMs according to Ben.  Passthrough of
> USB storage devices should be done via USB passthrough, not virtio-scsi.
>  If we do USB passthrough via the SCSI layer we miss on all the quirks
> that the OS may do based on the USB product/vendor pairs.  There's no
> end to these, and some of the quirks may cause the device to lock up or
> corruption.
>
> I'd rather see a reproducer using SAS/ATA/ATAPI disks before punting.

This issue affects passthrough: either an entire sg device or at least
a SG_IO ioctl (e.g. a non-READ/WRITE SCSI command).

To reproduce it, check host queue limits and guest virtio-scsi queue
limits.  Then pick a command that can exceed the limits and try it
from inside the guest :).

Stefan
