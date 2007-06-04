From: Carsten Otte <cotte@de.ibm.com>
Subject: Re: [kvm-devel] [PATCH RFC 3/3] virtio infrastructure: example block
 driver
Date: Mon, 04 Jun 2007 16:12:25 +0200
Message-ID: <46641DC9.5050600__6534.12194592438$1180966444$gmane$org@de.ibm.com>
References: <1180613947.11133.58.camel@localhost.localdomain>
	<1180614044.11133.61.camel@localhost.localdomain>
	<1180614091.11133.63.camel@localhost.localdomain>
	<465EC637.7020504@de.ibm.com>
	<1180654765.10999.6.camel@localhost.localdomain>
	<465FC65C.6020905@de.ibm.com>
	<20070601131315.GW32105@kernel.dk> <4664164A.40604@de.ibm.com>
	<20070604134322.GC32105@kernel.dk>
	<1180965161.25878.47.camel@localhost.localdomain>
	<20070604135433.GG32105@kernel.dk>
Reply-To: carsteno@de.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070604135433.GG32105@kernel.dk>
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
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, Xen Mailing List <xen-devel@lists.xensource.com>, "jmk@plan9.bell-labs.com" <jmk@plan9.bell-labs.com>, Herbert Xu <herbert@gondor.apana.org.au>, carsteno@de.ibm.com, mschwid2@linux.vnet.ibm.com, virtualization <virtualization@lists.linux-foundation.org>, kvm-devel <kvm-devel@lists.sourceforge.net>, Suzanne McIntosh <skranjac@us.ibm.com>, Christian Borntraeger <cborntra@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Jens Axboe wrote:
> Most people should not fiddle with it, the defaults are there for good
> reason. I can provide a blk_queue_unplug_thresholds(q, depth, delay)
> helper that you could use for the virtualized drivers, perhaps that
> would be better for that use?
Yea, we should'nt change the defaults without a good reason. That 
would change things for all device drivers.
This interface provides all functionality we need. I think we need a 
knob in /sys/block/mydevice/queue/ in addition to that.

so long,
Carsten
