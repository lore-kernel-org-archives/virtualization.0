From: Chris Wright <chrisw@sous-sol.org>
Subject: Re: todo
Date: Fri, 16 Mar 2007 20:34:52 -0700
Message-ID: <20070317033452.GU10574@sequoia.sous-sol.org>
References: <20070317020011.GS10574@sequoia.sous-sol.org>
	<45FB5707.3010809@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <45FB5707.3010809@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

* Jeremy Fitzhardinge (jeremy@goop.org) wrote:
> Chris Wright wrote:
> > Consistently wrap paravirt ops callsites
> > 	"ugh" - mingo
> =

> Had a thought.  What if we do a kind of reverse/two-way module linkage? =

> Somehow compile each pv-op implementation like a module, and then link
> the appropriate one in at boot time.

This is very similar to something Steve was chatting with me about
this morning.  The idea he was tossing around was something a bit like
an initrd that a load_module analog could link up.  In a sense, it's
similar to the VMI ROM, with the exceptions that the ABI is just created
by the compiler from a normal mutable kernel API and it's linkage with
symbols available on both sides.

> Tricky parts: it would need two-way unresolved references between kernel
> and module, and it would need to be able to run very early in the
> kernel's life.

This is the tricky part, and where Steve and I left off.

> It would also limit us to plain old calls rather than
> any inlining (though that could be done separately).
> =

> On the upside, it removes pv_ops, and it might simplify the question of
> how normal module exports work, since by that time they would just be
> normal kernel functions.  All the calls would be normal direct calls
> rather than indirect.  And it would allow us to free the memory for the
> unused pv-ops backends.

I suspect we could free the unused backends already.  It also has one
negative side-effect, which is promoting external module code that links
with the kernel.  IOW, there's much less incentive to get code merged
if it's just a matter of linking.

thanks,
-chris
