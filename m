From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH 2/5] Paravirt cpu batching.patch
Date: Tue, 12 Dec 2006 18:49:57 -0500
Message-ID: <200612121853_MC3-1-D4D2-191A@compuserve.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Chris Wright <chrisw@sous-sol.org>
Cc: Andrew Morton <akpm@osdl.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Andi Kleen <ak@muc.de>
List-Id: virtualization@lists.linuxfoundation.org

In-Reply-To: <20061212225430.GC10475@sequoia.sous-sol.org>

On Tue, 12 Dec 2006 14:54:30 -0800, Chros Wright wrote:

> > --- a/arch/i386/kernel/process.c    Tue Dec 12 13:50:50 2006 -0800
> > +++ b/arch/i386/kernel/process.c    Tue Dec 12 13:50:53 2006 -0800
> > @@ -665,6 +665,37 @@ struct task_struct fastcall * __switch_t
> >     load_TLS(next, cpu);
> >  =

> >     /*
> > +    * Restore IOPL if needed.
> > +    */
> > +   if (unlikely(prev->iopl !=3D next->iopl))
> > +           set_iopl_mask(next->iopl);
>
> Small sidenote that this bit undoes a recent change from Chuck Ebbert, wh=
ich
> killed iopl_mask update via hypervisor.

This whole thing needs a proper fix IMO.  I posted something a while back
but Andi didn't like it, I guess.

-- =

MBTI: IXTP
