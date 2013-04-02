From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH v2 2/2] virtio: console: add locking around c_ovq
	operations
Date: Tue, 2 Apr 2013 10:56:06 +0530
Message-ID: <20130402052606.GA15084@amit.redhat.com>
References: <cover.1364554596.git.amit.shah@redhat.com>
	<06f1e0e5f31d65735dedef2377435259971b4fc9.1364554596.git.amit.shah@redhat.com>
	<87vc8935ej.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87vc8935ej.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Sat) 30 Mar 2013 [14:28:28], Rusty Russell wrote:
> Amit Shah <amit.shah@redhat.com> writes:
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
> 
> Both applied to my fixes branch, with CC: stable added.
> 
> For future reference, I prefer you to put the CC: stable@kernel.org tag
> in if you think it's a stable candidate.

Will do,

Thanks

		Amit
