From: Cornelia Huck <cornelia.huck@de.ibm.com>
Subject: Re: virtio balloon: do not call blocking ops when !TASK_RUNNING
Date: Thu, 26 Feb 2015 09:57:44 +0100
Message-ID: <20150226095744.5d5addfa.cornelia.huck@de.ibm.com>
References: <20150225111318.0040536b@oc7435384737.ibm.com>
	<87y4nllb85.fsf@rustcorp.com.au>
	<20150226084529.GB24184@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20150226084529.GB24184@redhat.com>
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

On Thu, 26 Feb 2015 09:45:29 +0100
"Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Thu, Feb 26, 2015 at 11:50:42AM +1030, Rusty Russell wrote:
> > Thomas Huth <thuth@linux.vnet.ibm.com> writes:
> > >  Hi all,
> > >
> > > with the recent kernel 3.19, I get a kernel warning when I start my
> > > KVM guest on s390 with virtio balloon enabled:
> > 
> > The deeper problem is that virtio_ccw_get_config just silently fails on
> > OOM.
> 
> Same problem with virtio_ccw_reset.
> But avoiding kmalloc calls in virtio_ccw_get_config isn't enough I think,
> it might still sleep.

It is probably a problem with all calls into the transport that assume
an implementation that cannot fail: If we have a channel I/O backing,
we need to be able to handle things not working.

The only case we need to care about for virtio is probably a -ENODEV
triggered by a hotunplug, though.
