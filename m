From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH/RFC] virtio_blk: check for hardsector size from host
Date: Thu, 29 May 2008 10:11:32 +0200
Message-ID: <200805291011.32690.borntraeger__38432.0337245756$1212049070$gmane$org@de.ibm.com>
References: <200805271105.00077.borntraeger@de.ibm.com>
	<200805291804.11550.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805291804.11550.rusty@rustcorp.com.au>
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
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: virtualization@lists.linux-foundation.org, kvm@vger.kernel.org, Jens Axboe <jens.axboe@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

Am Donnerstag, 29. Mai 2008 schrieb Rusty Russell:
> On Tuesday 27 May 2008 19:04:59 Christian Borntraeger wrote:
> > Rusty, Jens,
> >
> > I need your opinion on the following patch. It seems to work, but I would
> > like to get some feedback if this patch is the right approach:
> 
> Looks like the right approach to me.  Don't know about the block side of 
it...
> 
> Just that u64 seems like overkill: u32?

I looked at blksize_t, which seems to be long.  So I decided to use u64 which 
should be enough (but still overkill...) on all platforms.

While we are at it. Since we dont convert endianess any longer, should I 
change all the __le{..} definitions to __u{..} in virtio_blk.h ?

Christian
