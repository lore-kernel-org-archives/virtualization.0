From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [patch 32/43] lguest: Virtio interface
Date: Tue, 02 Oct 2007 22:00:11 +1000
Message-ID: <1191326411.17826.24.camel@localhost.localdomain>
References: <20070926063618.956228976@rustcorp.com.au>
	<20070926063650.895058914@rustcorp.com.au>
	<200710021103.06918.borntraeger@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200710021103.06918.borntraeger@de.ibm.com>
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
Cc: lguest@ozlabs.org, Dor Laor <dor.laor@qumranet.com>, Arnd Bergmann <arnd@arndb.de>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2007-10-02 at 11:03 +0200, Christian Borntraeger wrote:
> Am Mittwoch, 26. September 2007 schrieb rusty@rustcorp.com.au:
> >  include/linux/virtio_config.h   |  111 +++++++++++++++++++++++++
> 
> I get the following warnings on s390:
> /space/linux-2.6/drivers/block/virtio_blk.c: In function 'virtblk_probe':
> /space/linux-2.6/drivers/block/virtio_blk.c:240: warning: passing argument 1 
> of '__swab16s' from incompatible pointer type

Hi Christian,

	Oh!  Took me a while to figure out what the problem was.  I must be
particularly slow this evening.

I've rolled your fix in.

Thanks!
Rusty.
