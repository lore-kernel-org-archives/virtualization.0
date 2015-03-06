From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: virtio balloon: do not call blocking ops when !TASK_RUNNING
Date: Fri, 6 Mar 2015 12:47:32 +0100
Message-ID: <20150306124732.2bfccd32.cornelia.huck__48514.437772292$1425642486$gmane$org@de.ibm.com>
References: <20150225111318.0040536b@oc7435384737.ibm.com>
	<87y4nllb85.fsf@rustcorp.com.au>
	<20150226083625.2520ecb6@oc7435384737.ibm.com>
	<8761akl0sh.fsf@rustcorp.com.au> <20150302111358.GA4954@redhat.com>
	<20150302123106.54a71968.cornelia.huck@de.ibm.com>
	<20150302114657.GB12040@redhat.com>
	<20150302131102.2388a582.cornelia.huck@de.ibm.com>
	<20150302121943.GD12040@redhat.com>
	<20150302133505.78c07e88.cornelia.huck@de.ibm.com>
	<20150302204410.GB4942@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150302204410.GB4942@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Mon, 2 Mar 2015 21:44:10 +0100
"Michael S. Tsirkin" <mst@redhat.com> wrote:


> > > Normally, hotunplug requires guest cooperation.
> > > IOW unplug request should send guest interrupt,
> > > then block until guest confirms it's not using the
> > > device anymore.
> > > virtio pci already handles that fine, can't ccw
> > > do something similar?
> > 
> > Hotunplug for channel devices does not require guest feedback. (In
> > fact, I was surprised to hear that there is somthing like guest
> > cooperation on other platforms.)
> 
> Consider a storage device. If you don't flush out caches
> before removing the disk, you might lose a bunch of data.

Yes, that is a problem. But hotunplug is indistinguishable from a hw
failure on s390, so there's not really much we can do here.

> 
> > Basically, the guest is simply
> > presented with the fact that the device is gone and has to deal with
> > it. It does not matter whether the device was removed by operator
> > request or due to a hardware failure.
> > 
> > (We do have support in the s390 channel device core to be able to deal
> > with devices going away and coming back gracefully. ccw devices can be
> > put into a special state where they retain their configuration so that
> > they can be reactivated if they become available again. For example,
> > dasd (disk) devices survive being detached and reattached just fine,
> > even under I/O load.
> > See the ->notify() callback of the ccw driver for
> > details.)
> 
> How does guest distinguish between this and intentional permanent
> removal?

It can't. It will get the same kind of notifications (and channel I/O
failures) for both. Only the admin has a chance of knowing, and they
may kill off a device in that state permanently (which, of course,
triggers the flush problems etc. which have just been delayed from the
initial detach).

Given that this is what the architecture gives us on all hypervisors
(LPAR and z/VM) and is for all I know decades old, it is what we have
to implement in qemu/kvm as well.
