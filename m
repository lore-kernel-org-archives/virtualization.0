From: Christoph Hellwig <hch@lst.de>
Subject: Re: [Qemu-devel] [PATCH 0/4] megaraid_sas HBA emulation
Date: Wed, 28 Oct 2009 09:40:22 +0100
Message-ID: <20091028084022.GB17601__42145.0357106098$1256768403$gmane$org@lst.de>
References: <4AE71116.6080809@suse.de> <4AE72419.60608@redhat.com>
	<20091028091129.n46xqd1lww8oosc8@imap.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20091028091129.n46xqd1lww8oosc8@imap.suse.de>
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

On Wed, Oct 28, 2009 at 09:11:29AM +0100, Hannes Reinecke wrote:
> The problem is I don't have any documentation for the LSI parallel
> SCSI controller. So I don't know if and in what shape I/O is passed
> down, nor anything else. And as the SCSI disk emulation is really
> tied into the LSI parallel SCSI controller, any change in the former
> is likely to break the latter.

scsi-disk is not tied into the lsi/symbios driver.  It's also used
by the esp driver and usb-mcd.  But it's a complete mess, and all my
attempts to untangle it have so far failed with my brain hurting for
a long time after.
