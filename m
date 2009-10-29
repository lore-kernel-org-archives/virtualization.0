From: Gerd Hoffmann <kraxel@redhat.com>
Subject: Re: [Qemu-devel] [PATCH 0/4] megaraid_sas HBA emulation
Date: Thu, 29 Oct 2009 09:47:19 +0100
Message-ID: <4AE95697.6020602__29760.0444326692$1256806279$gmane$org@redhat.com>
References: <4AE71116.6080809@suse.de> <4AE72419.60608@redhat.com>
	<20091028091129.n46xqd1lww8oosc8@imap.suse.de>
	<4AE822E7.2010108@redhat.com> <4AE84E09.7090002@redhat.com>
	<20091028202522.r53660olwsk8cokk@imap.suse.de>
	<20091029043708.GA3552@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091029043708.GA3552@lst.de>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Christoph Hellwig <hch@lst.de>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, qemu-devel@nongnu.org
List-Id: virtualization@lists.linuxfoundation.org

On 10/29/09 05:37, Christoph Hellwig wrote:

>   - try to create generic scsi device/request structures that the hba
>     driver can access, and which contain additional private data for
>     scsi-disk/generic.  Information in the generic one would include
>     the information about the data transfer, the tag and the command
>     block.

Agreed.  For scsi device this did already happen as part of the 
qdev-ification work.  It certainly makes sense to do that for scsi 
requests too.  May also allow to kill some code duplication in 
scsi-disk.c and scsi-generic.c

>   - try to get rid of the tag indexing stuff by just using a pointer to
>     the generic scsi request in the hba drivers.  That should get rid
>     of a lot of useless list searching.

Indeed.

cheers,
   Gerd
