From: Paolo Bonzini <pbonzini@redhat.com>
Subject: Re: [PATCH 1/2 v1] blkdrv: Add queue limits parameters for sg block
	drive
Date: Fri, 24 Aug 2012 11:14:33 +0200
Message-ID: <503745F9.2020709@redhat.com>
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
	<503733A2.1050300@redhat.com> <50375AD6.8060203@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <50375AD6.8060203@suse.de>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Hannes Reinecke <hare@suse.de>
Cc: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>, zwanp@cn.ibm.com, linuxram@us.ibm.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Cong Meng <mc@linux.vnet.ibm.com>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

Il 24/08/2012 12:43, Hannes Reinecke ha scritto:
> Hehe. So finally someone else stumbled across this one.
> 
> All is fine and dandy as long as you're able to use scsi-disk.
> As soon as you're forced to use scsi-generic we're in trouble.
> 
> With scsi-generic we actually have two problems:
> 1) scsi-generic just acts as a pass-through and passes the commands
>    as-is, including the scatter-gather information as formatted by
>    the guest. So the guest could easily format an SG_IO comand
>    which will not be compatible with the host.
> 2) The host is not able to differentiate between a malformed
>    SG_IO command and a real I/O error; in both cases it'll return
>    -EIO.
> 
> So we can fix this by either
> a) ignore (as we do nowadays :-)
> b) Fixup scsi-generic to inspect and modify SG_IO information
>    to ensure the host-limits are respected

That's what scsi-block already does.

Perhaps sooner or later we will need a scsi-tape?  That would be fine.

> Yes, it's painful. But in the long run we'll have to do an SG_IO
> inspection anyway, otherwise we'll always be susceptible to malicious
> SG_IO attacks.

I would like to do this in the kernel using BPF.  I posted a possible
spec at
http://www.redhat.com/archives/libvir-list/2012-June/msg00505.html but
the response was, ehm, underwhelming.

Paolo
