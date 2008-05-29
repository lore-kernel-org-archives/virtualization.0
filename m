From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH/RFC] virtio_blk: check for hardsector size from host
Date: Thu, 29 May 2008 10:27:25 +0200
Message-ID: <200805291027.25369.borntraeger__23317.1274805956$1212049845$gmane$org@de.ibm.com>
References: <200805271105.00077.borntraeger@de.ibm.com>
	<20080529081255.GO25504@kernel.dk>
	<20080529081357.GP25504@kernel.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080529081357.GP25504@kernel.dk>
Content-Disposition: inline
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jens Axboe <jens.axboe@oracle.com>
Cc: kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Donnerstag, 29. Mai 2008 schrieb Jens Axboe:
> > > Just that u64 seems like overkill: u32?
> > 
> > Definitely, u32 would be just fine, u64 is way overkill :-)
> 
> Even u16 would work, the block layer doesn't use more than an unsigned
> short for storing hardware sector size anyway.

Thanks, good to know. Do you think, that could change in the future? The 
virtio definition is going to be a public interface, so if there is a chance 
that u16 is not enough in the future I would respin the patch with u32, 
otherwise u16.

Christian
