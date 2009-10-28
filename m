From: Christoph Hellwig <hch@lst.de>
Subject: Re: [Qemu-devel] [PATCH 3/4] scsi-disk: Factor out SCSI command
	emulation
Date: Wed, 28 Oct 2009 09:42:47 +0100
Message-ID: <20091028084247.GC17601__29555.3125128665$1256768421$gmane$org@lst.de>
References: <20091027152859.C6CF739742@ochil.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091027152859.C6CF739742@ochil.suse.de>
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
Cc: qemu-devel@nongnu.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Oct 27, 2009 at 04:28:59PM +0100, Hannes Reinecke wrote:
> 
> Other drives might want to use SCSI command emulation without
> going through the SCSI disk abstraction, as this imposes too
> many limits on the emulation.

Might be a good idea to move something like this first into the series
and share the CDB decoder between scsi and ide (atapi) as a start.  A
little bit of refactoring of the CDB decoder, e.g. into one function
per opcode (-family) won't hurt either.
