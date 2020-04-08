From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [RFC PATCH 00/26] Runtime paravirt patching
Date: Wed, 8 Apr 2020 16:49:07 +0200
Message-ID: <20200408144907.GL20730@hirez.programming.kicks-ass.net>
References: <20200408050323.4237-1-ankur.a.arora@oracle.com>
 <20200408120856.GY20713@hirez.programming.kicks-ass.net>
 <bcf8206d-5a41-4e6b-1832-75ba1d6367e4@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <bcf8206d-5a41-4e6b-1832-75ba1d6367e4@suse.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: =?iso-8859-1?Q?J=FCrgen_Gro=DF?= <jgross@suse.com>
Cc: hpa@zytor.com, xen-devel@lists.xenproject.org, kvm@vger.kernel.org, x86@kernel.org, linux-kernel@vger.kernel.org, Ankur Arora <ankur.a.arora@oracle.com>, virtualization@lists.linux-foundation.org, pbonzini@redhat.com, namit@vmware.com, mhiramat@kernel.org, jpoimboe@redhat.com, mihai.carabas@oracle.com, bp@alien8.de, boris.ostrovsky@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Apr 08, 2020 at 03:33:52PM +0200, J=FCrgen Gro=DF wrote:
> On 08.04.20 14:08, Peter Zijlstra wrote:
> > On Tue, Apr 07, 2020 at 10:02:57PM -0700, Ankur Arora wrote:
> > > Mechanism: the patching itself is done using stop_machine(). That is
> > > not ideal -- text_poke_stop_machine() was replaced with INT3+emulation
> > > via text_poke_bp(), but I'm using this to address two issues:
> > >   1) emulation in text_poke() can only easily handle a small set
> > >   of instructions and this is problematic for inlined pv-ops (and see
> > >   a possible alternatives use-case below.)
> > >   2) paravirt patching might have inter-dependendent ops (ex.
> > >   lock.queued_lock_slowpath, lock.queued_lock_unlock are paired and
> > >   need to be updated atomically.)
> > =

> > And then you hope that the spinlock state transfers.. That is that both
> > implementations agree what an unlocked spinlock looks like.
> > =

> > Suppose the native one was a ticket spinlock, where unlocked means 'head
> > =3D=3D tail' while the paravirt one is a test-and-set spinlock, where
> > unlocked means 'val =3D=3D 0'.
> > =

> > That just happens to not be the case now, but it was for a fair while.
> =

> Sure? This would mean that before spinlock-pvops are being set no lock
> is allowed to be used in the kernel, because this would block the boot
> time transition of the lock variant to use.

Hurm.. true. I suppose I completely forgot how paravirt spinlocks looked
before it got rewritten.

> Another problem I'm seeing is that runtime pvops patching would rely on
> the fact that stop_machine() isn't guarded by a spinlock.

It can't be, stop_machine() relies on scheduling. But yes, that another
variation of 'stuff uses spinlocks'.
