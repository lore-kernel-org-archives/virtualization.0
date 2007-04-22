From: "Zachary Amsden" <zamsden@gmail.com>
Subject: Re: [RFC, PATCH 5/5] Paravirt_ops export.patch
Date: Sun, 22 Apr 2007 09:59:18 -0700
Message-ID: <8a06f3d10704220959r16a78690ib1c90c56e4d1367@mail.gmail.com>
References: <20070420015304.74394BFC@zach-dev2.vmware.com>
	<46284B40.5010106@goop.org> <m1y7kkzdon.fsf@ebiederm.dsl.xmission.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3142083722439740799=="
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <m1y7kkzdon.fsf@ebiederm.dsl.xmission.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Mime-version: 1.0
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@muc.de>, Petr Vandrovec <petr@vmware.com>, Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

--===============3142083722439740799==
Content-Type: multipart/alternative;
	boundary="----=_Part_202066_29122110.1177261158945"

------=_Part_202066_29122110.1177261158945
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On 4/22/07, Eric W. Biederman <ebiederm@xmission.com> wrote:
>
> Jeremy Fitzhardinge <jeremy@goop.org> writes:
>
> > Hm, OK, I see what you're getting at.
> >
> > I guess the BUG_ON()s need only fire if they're failing to patch over a
> > ud2a instruction.
> >
> >
> > I'm in two minds about this.  On the one hand, it's a clever hack which
> > does achieve the desired outcome.  On the other hand, it turns an
> > optimisation mechanism into a special-purpose ad-hoc linker which
> > doesn't seem like quite the right way to go.  The conversion from "best
> > effort, doing nothing is OK" to "doing nothing is a BUG" behaviour is a
> > good indication of this.



Doing nothing is a BUG, even before this change.  If you can't patch in a
properly virtualizable substitute for a non-virtualizable sequence, the
kernel will not work.  The only way for the patching to fail is for lack of
space or failure to meet clobber constraints, both of which would be fatal
even without the patching.


Yes.  Has anyone thought more about David Miller's suggesting of just
> using the linker and not doing the fancy binary replacement?



I thought a lot about it and ended up concluding it was not tenable.  I
can't recall quite the logic that got me there now, but I do know that two
things immediately spring to mind:

1) Using the linker, all paravirt-ops, even performance critical ones,
become function calls, with 3 clobbered registers.  Thwarting this by using
non-C  function calls brings you directly back to the fancy inline assembly
goo you are trying to avoid.
2) You must support dynamic re-linking - the kernel has to boot and use
builtin native style operations before switching over to the virtualized
operations.  So you have to have some kind of jettisonable early binding
support.

Considering the performance element will be explored fully, I'm not sure
that using the linker results in any reduction in complexity.

Zach

------=_Part_202066_29122110.1177261158945
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<br><br><div><span class="gmail_quote">On 4/22/07, <b class="gmail_sendername">Eric W. Biederman</b> &lt;<a href="mailto:ebiederm@xmission.com">ebiederm@xmission.com</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
Jeremy Fitzhardinge &lt;<a href="mailto:jeremy@goop.org">jeremy@goop.org</a>&gt; writes:<br><br>&gt; Hm, OK, I see what you&#39;re getting at.<br>&gt;<br>&gt; I guess the BUG_ON()s need only fire if they&#39;re failing to patch over a
<br>&gt; ud2a instruction.<br>&gt;<br>&gt;<br>&gt; I&#39;m in two minds about this.&nbsp;&nbsp;On the one hand, it&#39;s a clever hack which<br>&gt; does achieve the desired outcome.&nbsp;&nbsp;On the other hand, it turns an<br>&gt; optimisation mechanism into a special-purpose ad-hoc linker which
<br>&gt; doesn&#39;t seem like quite the right way to go.&nbsp;&nbsp;The conversion from &quot;best<br>&gt; effort, doing nothing is OK&quot; to &quot;doing nothing is a BUG&quot; behaviour is a<br>&gt; good indication of this.</blockquote>
<div><br><br>Doing nothing is a BUG, even before this change.&nbsp; If you can&#39;t patch in a properly virtualizable substitute for a non-virtualizable sequence, the kernel will not work.&nbsp; The only way for the patching to fail is for lack of space or failure to meet clobber constraints, both of which would be fatal even without the patching.
<br><br></div><br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">Yes.&nbsp;&nbsp;Has anyone thought more about David Miller&#39;s suggesting of just<br>
using the linker and not doing the fancy binary replacement?</blockquote><div><br><br>I thought a lot about it and ended up concluding it was not tenable.&nbsp; I can&#39;t recall quite the logic that got me there now, but I do know that two things immediately spring to mind:
<br><br>1) Using the linker, all paravirt-ops, even performance critical ones, become function calls, with 3 clobbered registers.&nbsp; Thwarting this by using non-C&nbsp; function calls brings you directly back to the fancy inline assembly goo you are trying to avoid.
<br>2) You must support dynamic re-linking - the kernel has to boot and use builtin native style operations before switching over to the virtualized operations.&nbsp; So you have to have some kind of jettisonable early binding support.
<br><br></div>Considering the performance element will be explored fully, I&#39;m not sure that using the linker results in any reduction in complexity.<br><br>Zach</div>

------=_Part_202066_29122110.1177261158945--

--===============3142083722439740799==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Virtualization mailing list
Virtualization@lists.linux-foundation.org
https://lists.linux-foundation.org/mailman/listinfo/virtualization
--===============3142083722439740799==--
