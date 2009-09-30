From: Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 1/4] virtio_blk: deprecate the 1024-byte ID field.
Date: Wed, 30 Sep 2009 09:41:24 +0200
Message-ID: <200909300941.24736.borntraeger@de.ibm.com>
References: <200909300248.09630.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200909300248.09630.rusty@rustcorp.com.au>
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
Cc: john cooper <john.cooper@redhat.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Am Dienstag 29 September 2009 19:18:09 schrieb Rusty Russell:
> PCI, lguest and s390 can all only support 256-byte configuration
> space.  So, this giant field broke just about everyone.
> Unfortunately, removing it is not so simple: we don't want to break
> old userspace, but we're going to want to re-use that part of the
> struct.
> 
> So, modern users can #define VIRTIO_BLK_IDENTIFY_DEPRECATED to indicate
> that they know it's no longer in the config struct, and can use any
> new features (all new features which add a configuration field will
> conflict with this deprecated one).


Since s390 never used the giant id field, it would be ok for us just delete it 
(without the #define). IIRC kvm-userspace also never used that. Since qemu 
upstream seems to use that field your way seems to be the only compatible...

O dear, virtio used to look pretty ;-).
I think somewhen in the future we have to create a virtio2 that gets rid of all 
the stuff that accumulated in the early phase of Linux virtualization.

Anyway, your patch was tested successfully on s390 to survive the current 
userspace.

Tested-by: Christian Borntraeger <borntraeger@de.ibm.com>
