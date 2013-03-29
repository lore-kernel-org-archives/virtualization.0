From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH 2/2] virtio: console: add locking around c_ovq operations
Date: Fri, 29 Mar 2013 16:30:39 +0530
Message-ID: <20130329110039.GF14019@amit.redhat.com>
References: <cover.1364469955.git.amit.shah@redhat.com>
	<7020cea46a2e01d7205e6af0faffcebbed032003.1364469955.git.amit.shah@redhat.com>
	<20130329002901.GA22450@hj.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130329002901.GA22450@hj.localdomain>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Asias He <asias@redhat.com>
Cc: Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Fri) 29 Mar 2013 [08:29:01], Asias He wrote:
> On Thu, Mar 28, 2013 at 04:58:33PM +0530, Amit Shah wrote:
> > When multiple ovq operations are being performed (lots of open/close
> > operations on virtio_console fds), the __send_control_msg() function can
> > get confused without locking.
> > 
> > A simple recipe to cause badness is:
> > * create a QEMU VM with two virtio-serial ports
> > * in the guest, do
> >   while true;do echo abc >/dev/vport0p1;done
> >   while true;do echo edf >/dev/vport0p2;done
> > 
> > In one run, this caused a panic in __send_control_msg().  In another, I
> > got
> > 
> >    virtio_console virtio0: control-o:id 0 is not a head!
> > 
> > This also results repeated messages similar to these on the host:
> > 
> >   qemu-kvm: virtio-serial-bus: Unexpected port id 478762112 for device virtio-serial-bus.0
> >   qemu-kvm: virtio-serial-bus: Unexpected port id 478762368 for device virtio-serial-bus.0
> > 
> > Reported-by: FuXiangChun <xfu@redhat.com>
> > Signed-off-by: Amit Shah <amit.shah@redhat.com>
> 
> So, probably this will not apply on virtio-next because of the
> virtqueue_add_outbuf change.

Yes, one-line context change.

> Anyway,  Reviewed-by: Asias He <asias@redhat.com>

Thanks!

		Amit
