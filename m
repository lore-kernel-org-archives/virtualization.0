From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: lguest virtio_descriptor structure on 64bit
Date: Fri, 17 Aug 2007 21:13:07 +1000
Message-ID: <1187349187.6449.119.camel@localhost.localdomain>
References: <200708171022.18799.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200708171022.18799.borntraeger@de.ibm.com>
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
Cc: virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2007-08-17 at 10:22 +0200, Christian Borntraeger wrote:
> Hello Rusty,
> 
> while playing with your virtio descriptor code, I realized that the desc_pages 
> data structure is not 64 bit safe. struct lguest_desc desc[NUM_DESCS] can be 
> smaller than a page, as struct lguest_desc is 24 bytes on 64bit systems. Lets 
> add a char padding to make the next page really page aligned.

Indeed.  This is something which would need fixing for a non-32 bit
platform.

> Btw. the new_io_desc.patch does not apply on current git. What base should I 
> use?

Unfortunately, the lguest tree is undergoing a significant reshuffle as
files get moved (non-i386 support).  The lguest patch queue as a whole
should apply tho.

Thanks!
Rusty.
