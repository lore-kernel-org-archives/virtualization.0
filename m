From: Stefan Hajnoczi <stefanha@linux.vnet.ibm.com>
Subject: Re: [PATCH 1/2 v1] blkdrv: Add queue limits parameters for sg block
	drive
Date: Wed, 22 Aug 2012 14:13:48 +0100
Message-ID: <20120822131348.GA3512@stefanha-thinkpad.localdomain>
References: <1345537427-21601-1-git-send-email-mc@linux.vnet.ibm.com>
	<50334B51.6050900@redhat.com> <503357B2.5040901@linux.vnet.ibm.com>
	<CAJSP0QX8BL9R_M0NxisiP+wejjgh6C6-nz9LPAfgHppPpNpYnA@mail.gmail.com>
	<50335F78.1030005@redhat.com> <5034BCD1.9020603@linux.vnet.ibm.com>
	<5034CBF8.3050602@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <5034CBF8.3050602@redhat.com>
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
Cc: zwanp@cn.ibm.com, linuxram@us.ibm.com, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Cong Meng <mc@linux.vnet.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Aug 22, 2012 at 02:09:28PM +0200, Paolo Bonzini wrote:
> Il 22/08/2012 13:04, Cong Meng ha scritto:
> >>
> >> Cong, what is the limit that the host HBA enforces (and what is the
> >> HBA)?  What commands see a problem?  Is it fixed by using scsi-block
> >> instead of scsi-generic (if you can use scsi-block at all, i.e. it's not
> >> a tape or similar device)?
> >>
> > I don't see real problem caused by the the queue limits actually. It's a
> > bug which Stefan told me.
> 
> I'd rather avoid patching the specification if not to solve real (rather
> than known-but-theoretical) problems.

Benjamin Herrenschmidt reported this in problem in 2010:

http://lists.gnu.org/archive/html/qemu-devel/2010-12/msg01741.html

"This is a real problem in practice. IE. the USB CD-ROM on this POWER7
blade limits transfers to 0x1e000 bytes for example and the Linux "sr"
driver on the guest is going to try to give me bigger requests than that
if I don't start limiting them, which will cause all sort of errors."

It cannot be fixed for emulated SCSI HBAs in general but it can for
virtio-scsi.

I/O requests will be failed with EIO if they exceed block queue limits.
Take a look at block/blk-core.c:generic_make_request_checks() and
blk_rq_check_limits().

Cong: Have you checked the block queue limits on your test machine and
exceeded them to see what happens?

Stefan
