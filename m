From: Christoph Hellwig <hch@lst.de>
Subject: Re: [Qemu-devel] [PATCH 0/4] megaraid_sas HBA emulation
Date: Thu, 29 Oct 2009 15:57:15 +0100
Message-ID: <20091029145715.GA3299__34710.5655041107$1256828298$gmane$org@lst.de>
References: <4AE71116.6080809@suse.de> <4AE72419.60608@redhat.com>
	<20091028091129.n46xqd1lww8oosc8@imap.suse.de>
	<4AE822E7.2010108@redhat.com> <4AE84E09.7090002@redhat.com>
	<20091028202522.r53660olwsk8cokk@imap.suse.de>
	<20091029043708.GA3552@lst.de> <4AE99144.6050904@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4AE99144.6050904@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gerd Hoffmann <kraxel@redhat.com>
Cc: qemu-devel@nongnu.org, Christoph Hellwig <hch@lst.de>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, Oct 29, 2009 at 01:57:40PM +0100, Gerd Hoffmann wrote:
> Trying to go forward in review+bisect friendly baby steps.  Here is what 
> I have now:
> 
> http://repo.or.cz/w/qemu/kraxel.git?a=shortlog;h=refs/heads/scsi.v1
> 
> It is far from being completed, will continue tomorrow.  Should give a 
> idea of the direction I'm heading to though.  Comments welcome.

Nice.

I had patches for the header renames, too - the current naming is
really awkward.  Would be great if Anthony could take those ASAP.

Btw, I also splitted out a cdrom.h from the new scsi.h, not sure if it's
worth it for the two prototypes.

Just wondering, shouldn't scsi-bus.c just become scsi.c now that it's
growing various non-bus glue bits?
