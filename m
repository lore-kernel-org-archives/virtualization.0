From: Zachary Amsden <zach@vmware.com>
Subject: Re: [PATCH/RFC] replace get_scheduled_cycles with sched_clock
	paravirt_op
Date: Wed, 14 Mar 2007 12:34:23 -0800
Message-ID: <45F85C4F.10704@vmware.com>
References: <45F847E2.7040102@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45F847E2.7040102@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, john stultz <johnstul@us.ibm.com>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Subject: Add a sched_clock paravirt_op
>
> The tsc-based get_scheduled_cycles interface is not a good match for
> Xen's runstate accounting, which reports everything in nanoseconds.
>
> This patch replaces this interface with a sched_clock interface, which
> matches both Xen and VMI's requirements.
>
> In order to do this, we:
>    1. replace get_scheduled_cycles with sched_clock
>    2. hoist cycles_2_ns into a common header
>    3. update vmi accordingly
>
> One thing to note: because sched_clock is implemented as a weak function =
in
> kernel/sched.c, we must define a real function in order to override this =
weak
> binding.  This means the usual paravirt_ops technique of using an inline
> function won't work in this case.
>   =


Acked-by: Zachary Amsden <zach@vmware.com>
