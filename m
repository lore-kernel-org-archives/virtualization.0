From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [kvm-devel] [PATCH resent] virtio_net: Fix stalled inbound
	trafficon early packets
Date: Wed, 12 Dec 2007 12:54:13 +1100
Message-ID: <200712121254.13865.rusty__49630.5244196721$1197424578$gmane$org@rustcorp.com.au>
References: <200712111242.28843.borntraeger@de.ibm.com>
	<475E892D.9060400@qumranet.com>
	<200712111416.12655.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200712111416.12655.borntraeger@de.ibm.com>
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
To: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: kvm-devel <kvm-devel@lists.sourceforge.net>, netdev@vger.kernel.org, dor.laor@qumranet.com, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wednesday 12 December 2007 00:16:12 Christian Borntraeger wrote:
> That would also work. We already have VRING_AVAIL_F_NO_INTERRUPT in
> virtio_ring.c - maybe we can use that. Its hidden in callback and
> restart handling, what about adding an explicit startup?

Yes, I debated whether to make this a separate hook or not; the current method 
reduces the number of function calls without having two ways of disabling 
callbacks.

In this case, simply starting devices with callbacks disabled and 
renaming 'restart' to 'enable' (or something) and calling it at the beginning 
is probably sufficient?

Thanks for all this debugging!  Will apply next week when I'm back...

> Ok, didnt know that. At the moment I can live with my private patch
> while we work on a final solution. Meanwhile I will try to debug virtio
> on SMP guests - I still see some strange races on our test system. (But
> block and net is now working on s390 and can cope with medium load. )

Obviously SMP is not something I tested under lguest, so can believe there are 
nasty lurking bugs.  Hope they're not too deep...

Thanks!
Rusty.
