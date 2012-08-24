From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2 v1] blkdrv: Add queue limits parameters for sg block
	drive
Date: Fri, 24 Aug 2012 10:05:07 +0100
Message-ID: <20120824090507.GA5391@stefanha-thinkpad.localdomain>
References: <5034BCD1.9020603@linux.vnet.ibm.com> <5034CBF8.3050602@redhat.com>
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
Content-Disposition: inline
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
Cc: zwanp@cn.ibm.com, linuxram@us.ibm.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Cong Meng <mc@linux.vnet.ibm.com>, Paolo Bonzini <pbonzini@redhat.com>, Christoph Hellwig <hch@lst.de>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Aug 24, 2012 at 12:43:34PM +0200, Hannes Reinecke wrote:
> On 08/24/2012 09:56 AM, Paolo Bonzini wrote:
> >Il 24/08/2012 02:45, Nicholas A. Bellinger ha scritto:
> >>So up until very recently, TCM would accept an I/O request for an DATA
> >>I/O type CDB with a max_sectors larger than the reported max_sectors for
> >>it's TCM backend (regardless of backend type), and silently generate N
> >>backend 'tasks' to complete the single initiator generated command.
> >
> >This is what QEMU does if you use scsi-block, except for MMC devices
> >(because of the insanity of the commands used for burning).
> >
> >>Also FYI for Paolo, for control type CDBs I've never actually seen an
> >>allocation length exceed max_sectors, so in practice AFAIK this only
> >>happens for DATA I/O type CDBs.
> >
> >Yes, that was my impression as well.
> >
> >>This was historically required by the pSCSI backend driver (using a
> >>number of old SCSI passthrough interfaces) in order to support this very
> >>type of case described above, but over the years the logic ended up
> >>creeping into various other non-passthrough backend drivers like IBLOCK
> >>+FILEIO.  So for v3.6-rc1 code, hch ended up removing the 'task' logic
> >>thus allowing backends (and the layers below) to the I/O sectors >
> >>max_sectors handling work, allowing modern pSCSI using struct request to
> >>do the same.  (hch assured me this works now for pSCSI)
> >
> >So now LIO and QEMU work the same.  (Did he test tapes too?)
> >
> >>Anyways, I think having the guest limit virtio-scsi DATA I/O to
> >>max_sectors based upon the host accessible block limits is reasonable
> >>approach to consider.  Reducing this value even further based upon the
> >>lowest max_sectors available amongst possible migration hosts would be a
> >>good idea here to avoid having to reject any I/O's exceeding a new
> >>host's device block queue limits.
> >
> >Yeah, it's reasonable _assuming it is needed at all_.  For disks, it is
> >not needed.  For CD-ROMs it is, but right now we have only one report
> >and it is using USB so we don't know if the problem is in the drive or
> >rather in the USB bridge (whose quality usually leaves much to be desired).
> >
> >So in the only observed case, the fix would really be a workaround; the
> >right thing to do with USB devices is to use USB passthrough.
> >
> 
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
> c) Fixup the host to differentiate between a malformed SG_IO
>    and a real I/O error.
> 
> c) would only be feasible for Linux et al. _personally_ I would
> prefer that approach, as I fail to see why we cannot return a proper
> error code here.
> But I already can hear the outraged cry 'POSIX! POSIX!', so I guess
> it's not going to happen anytime soon.
> So I would vote for b).
> Yes, it's painful. But in the long run we'll have to do an SG_IO
> inspection anyway, otherwise we'll always be susceptible to
> malicious SG_IO attacks.

Are you suggesting we do not expose host block queue limits to the
guest.  Instead we should inspect and reformat SG_IO requests in QEMU?
Reformatting seems hard because there are many possible SCSI
commands/sub-commands and we would have to whitelist them on a
case-by-case basis.

That sounds like more work than exposing the block queue limits using
Cong Meng's patches.

On a side-note, are you thinking of blacklisting/whitelisting certain
commands that don't make sense or would have an unintended effect if
sent from a guest (e.g. reservations)?  That would be an interesting
topic for another email thread, I'd love to learn what weird things we
need to protect against.

Stefan
