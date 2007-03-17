From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: todo
Date: Fri, 16 Mar 2007 19:48:39 -0700
Message-ID: <45FB5707.3010809@goop.org>
References: <20070317020011.GS10574@sequoia.sous-sol.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20070317020011.GS10574@sequoia.sous-sol.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Chris Wright wrote:
> this is the only things left on the todo i made today.
>
> Xen config
> 	PREEMPT?
>   =

Remove.  Should work; any problems are bugs.

> Consistently wrap paravirt ops callsites
> 	"ugh" - mingo

Had a thought.  What if we do a kind of reverse/two-way module linkage? =

Somehow compile each pv-op implementation like a module, and then link
the appropriate one in at boot time.

Tricky parts: it would need two-way unresolved references between kernel
and module, and it would need to be able to run very early in the
kernel's life.  It would also limit us to plain old calls rather than
any inlining (though that could be done separately).

On the upside, it removes pv_ops, and it might simplify the question of
how normal module exports work, since by that time they would just be
normal kernel functions.  All the calls would be normal direct calls
rather than indirect.  And it would allow us to free the memory for the
unused pv-ops backends.

Plausible?

    J
