From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH v3 2/3] hvc_init(): Enforce one-time initialization.
Date: Tue, 13 Dec 2011 00:55:04 +0530
Message-ID: <20111212192504.GC6316@amit-x200.redhat.com>
References: <CAB8RdapbaueyWLJuJDE_ZdvLkRNM4sQHTxgmgO=jrnXZ6YPSmA@mail.gmail.com>
	<20111123103852.GG16665@amit-x200.redhat.com>
	<CAB8RdaoDxMCgTjuGP70bGrsrtgh=USYtU3Spo5OPtVMYAM5EzQ@mail.gmail.com>
	<20111129142149.GE2822@amit-x200.redhat.com>
	<CAB8RdapuPRym2dH_9mgmGdzpCxnP1KpS+hS8JJ-geVkga5fMcw@mail.gmail.com>
	<CAB8Rdapfuf5XH+X9gsUL+CJ9gTQcSNfq4Dj9DoYWQeFgD04ODQ@mail.gmail.com>
	<20111205105452.GB27683@amit-x200.redhat.com>
	<CAB8Rdar=qOokxZkjQVRmo=zN_f75jPwzU+6=WBRo0g+P7w+pAw@mail.gmail.com>
	<20111208120804.GF23531@amit-x200.redhat.com>
	<CAB8RdapDDV0kYW_uASpBoJ3hbx6zScKnG+LWWcjYtqMnqXN4Xw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAB8RdapDDV0kYW_uASpBoJ3hbx6zScKnG+LWWcjYtqMnqXN4Xw@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Miche Baker-Harvey <miche@google.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Anton Blanchard <anton@samba.org>, Mike Waychison <mikew@google.com>, ppc-dev <linuxppc-dev@lists.ozlabs.org>, Greg Kroah-Hartman <gregkh@suse.de>, Eric Northrup <digitaleric@google.com>
List-Id: virtualization@lists.linuxfoundation.org

On (Mon) 12 Dec 2011 [11:11:55], Miche Baker-Harvey wrote:
> So on a CONSOLE_PORT_ADD message, we would take the
> (existing)ports_device::ports_lock, and for other control messages we
> would justtake the (new) port::port_lock? =A0You are concerned that just
> takingthe ports_lock for all control messages could be too
> restrictive? =A0Iwouldn't have expected these messages to be frequent
> occurrences, butI'll defer to your experience here.

No, I mean we'll have to take the new port_lock() everywhere we
currently take the port lock, plus in a few more places.  I only
suggest using port_lock() helper since we'll need a dependency on the
portdev lock as well.

> The CONSOLE_CONSOLE_PORT message calls hvc_alloc, which also
> needsserialization. =A0That's in another one of these three patches; are
> youthinking we could leave that patch be, or that we would we use
> theport_lock for CONSOLE_CONSOLE_PORT? =A0Using the port_lock
> wouldprovide the HVC serialization "for free" but it would be cleaner
> if weput HVC related synchronization in hvc_console.c.

Yes, definitely, since other users of hvc_console may get bitten in
similar ways.  However, I'm not too familiar with the hvc code, the
people at linux-ppc can be of help.

> On Thu, Dec 8, 2011 at 4:08 AM, Amit Shah <amit.shah@redhat.com> wrote:
> > On (Tue) 06 Dec 2011 [09:05:38], Miche Baker-Harvey wrote:
> >> Amit,
> >>
> >> Ah, indeed. =A0I am not using MSI-X, so virtio_pci::vp_try_to_find_vqs=
()
> >> calls vp_request_intx() and sets up an interrupt callback. =A0From
> >> there, when an interrupt occurs, the stack looks something like this:
> >>
> >> virtio_pci::vp_interrupt()
> >> =A0 virtio_pci::vp_vring_interrupt()
> >> =A0 =A0 virtio_ring::vring_interrupt()
> >> =A0 =A0 =A0 vq->vq.callback() =A0<-- in this case, that's virtio_conso=
le::control_intr()
> >> =A0 =A0 =A0 =A0 workqueue::schedule_work()
> >> =A0 =A0 =A0 =A0 =A0 workqueue::queue_work()
> >> =A0 =A0 =A0 =A0 =A0 =A0 queue_work_on(get_cpu()) =A0<-- queues the wor=
k on the current CPU.
> >>
> >> I'm not doing anything to keep multiple control message from being
> >> sent concurrently to the guest, and we will take those interrupts on
> >> any CPU. I've confirmed that the two instances of
> >> handle_control_message() are occurring on different CPUs.
> >
> > So let's have a new helper, port_lock() that takes the port-specific
> > spinlock. =A0There has to be a new helper, since the port lock should
> > depend on the portdev lock being taken too. =A0For the port addition
> > case, just the portdev lock should be taken. =A0For any other
> > operations, the port lock should be taken.
> >
> > My assumption was that we would be able to serialise the work items,
> > but that will be too restrictive. =A0Taking port locks sounds like a
> > better idea.
> >
> > We'd definitely need the port lock in the control work handler. =A0We
> > might need it in a few more places (like module removal), but we'll
> > worry about that later.
> >
> > Does this sound fine?
> >
> > =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0Amit

		Amit
