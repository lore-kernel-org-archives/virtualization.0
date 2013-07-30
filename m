From: Amit Shah <amit.shah@redhat.com>
Subject: Re: [PATCH v3 1/9] virtio: console: fix race with port unplug and
	open/close
Date: Tue, 30 Jul 2013 14:58:22 +0530
Message-ID: <20130730092822.GA8459__2714.9258916781$1375176522$gmane$org@amit-x200.redhat.com>
References: <cover.1374759439.git.amit.shah@redhat.com>
	<7ca111ad3bca069f921b4234e5b3ccbbfd7a11d8.1374759439.git.amit.shah@redhat.com>
	<87ob9m6kej.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <87ob9m6kej.fsf@rustcorp.com.au>
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
Cc: stable@vger.kernel.org, Virtualization List <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On (Mon) 29 Jul 2013 [14:18:52], Rusty Russell wrote:
> Amit Shah <amit.shah@redhat.com> writes:
> > There's a window between find_port_by_devt() returning a port and us
> > taking a kref on the port, where the port could get unplugged.  Fix it
> > by taking the reference in find_port_by_devt() itself.
> >
> > Problem reported and analyzed by Mateusz Guzik.
> 
> This fix is clearly correct, but what about the other find_port_by_*
> functions?

They don't need a kref -- the kref is only to be bumped when:

1. Initialising / Plugging in the port (add_port)
2. Opening the port (this fix)

Both these cases are now covered.  As part of the locking rework, the
other find_port_by_* functions may be reworked to set some state, like
port_in_use, instead of abusing guest_connected today.

		Amit
