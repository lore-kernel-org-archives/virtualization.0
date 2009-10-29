From: Christoph Hellwig <hch@lst.de>
Subject: Re: [Qemu-devel] [PATCH 0/4] megaraid_sas HBA emulation
Date: Thu, 29 Oct 2009 05:37:08 +0100
Message-ID: <20091029043708.GA3552__44258.470767136$1256791093$gmane$org@lst.de>
References: <4AE71116.6080809@suse.de> <4AE72419.60608@redhat.com>
	<20091028091129.n46xqd1lww8oosc8@imap.suse.de>
	<4AE822E7.2010108@redhat.com> <4AE84E09.7090002@redhat.com>
	<20091028202522.r53660olwsk8cokk@imap.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091028202522.r53660olwsk8cokk@imap.suse.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Hannes Reinecke <hare@suse.de>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Oct 28, 2009 at 08:25:22PM +0100, Hannes Reinecke wrote:
> I don't think we really need two modes.
> My preferred interface here is to pass down scatter-gather lists down
> with every xfer; this way it'll be the responsibility of the driver to
> create the lists in the first place. If it has hardware scatter-gather
> support it can just pass them down, if not it can as easily create a
> scatter-gather list with just one element as a bounce buffer.

Yes.  If this really causes performance problems for esp we can add
bounce buffering in that driver later.

> So something like
> - Get next request
> - Attach iovec/bounc-buffer
> - handle request (command/write/read)
> - complete request (callback)

Btw, from some previuous attempts to sort out this code here are some
thing that I think would be beneficial:

 - try to create generic scsi device/request structures that the hba
   driver can access, and which contain additional private data for
   scsi-disk/generic.  Information in the generic one would include
   the information about the data transfer, the tag and the command
   block.
 - try to get rid of the tag indexing stuff by just using a pointer to
   the generic scsi request in the hba drivers.  That should get rid
   of a lot of useless list searching.
