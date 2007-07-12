From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH 3/3] Virtio draft IV: the net driver
Date: Thu, 12 Jul 2007 12:23:19 +1000
Message-ID: <1184206999.6005.672.camel@localhost.localdomain>
References: <1183522348.6110.37.camel@localhost.localdomain>
	<200707111228.30707.borntraeger@de.ibm.com>
	<1184153201.6005.618.camel@localhost.localdomain>
	<200707111346.07185.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200707111346.07185.borntraeger@de.ibm.com>
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
Cc: Carsten Otte <cotte@de.ibm.com>, "David S. Miller" <davem@davemloft.net>, Herbert Xu <herbert@gondor.apana.org.au>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 2007-07-11 at 13:46 +0200, Christian Borntraeger wrote:
> Am Mittwoch, 11. Juli 2007 schrieb Rusty Russell:
> > There will be some internal limit on how many buffers the virtio
> > implementation supports, but depends on that implementation.  It could
> > be a number of buffers or a total number of descriptors.
> 
> I would suggest to implement a limit in the device driver as well. Otherwise 
> the network driver could allocate a huge amount of guest memory if the virtio
> implementation accepts a large amount of buffers. This memory is not swappable 
> and reclaimable by the memory management, so we should be careful. 

Hi Christian,

	I this this would be premature, but easy enough to do later if we have
such a high-limit virtio implementation.   If we did do it, it would
make sense to have it a variable passed into the net driver.

Thanks,
Rusty.
