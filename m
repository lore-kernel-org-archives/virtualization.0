From: Chris Lalancette <clalance@redhat.com>
Subject: Re: [Fwd: [PATCH]: Fix silly output for virtio devices in
	/proc/interrupts]
Date: Thu, 22 May 2008 14:51:17 +0200
Message-ID: <48356C45.2020802__2754.08528182215$1211461460$gmane$org@redhat.com>
References: <48341FE1.4070305@redhat.com>
	<200805222238.58166.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <200805222238.58166.rusty@rustcorp.com.au>
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
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, virtualization@lists.linux-foundation.org, Christian Borntraeger <borntraeger@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> On Wednesday 21 May 2008 23:13:05 Chris Lalancette wrote:
>> Author: Chris Lalancette <clalance@redhat.com>
>> Date:   Thu May 15 09:04:55 2008 -0400
>>
>>     register_virtio_device was doing something silly, in that it was
>> overwriting what the calling driver stuck into .bus_id" for the name.  This
>> caused problems in the output of /proc/interrupts, since when you
>> request_irq(), it doesn't actually copy the devname you pass in but just
>> stores a pointer to the data.  The fix is to just not have
>> register_virtio_device do anything with the bus_id, and assume the higher
>> level driver set it up properly.
> 
> OK, but only one higher-level driver will set it up properly: kvm.  Neither
> lguest nor s/390 do this, and as a result, they fail to register *any*
> devices.

Ah, OK.  Alternatively, we could do:

snprintf(bus_id, BUS_ID_SIZE, "virtio%d", index)

in register_virtio_device(), and just fix the one user who does it themselves
(kvm) to not duplicate the work.

Either way is fine with me.

Chris Lalancette
