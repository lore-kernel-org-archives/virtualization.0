From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [RFC/PATCH LGUEST X86_64 01/13] HV VM Fix map area for HV.
Date: Fri, 09 Mar 2007 14:52:50 +1100
Message-ID: <1173412371.32234.109.camel@localhost.localdomain>
References: <20070308162348.299676000@redhat.com>
	<1173375511.32170.3.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1173375511.32170.3.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Steven Rostedt <rostedt@goodmis.org>
Cc: Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Ingo Molnar <mingo@elte.hu>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-03-08 at 12:38 -0500, Steven Rostedt wrote:
> One solution is just to do a single area for boot up, and then
> use the vmalloc to map. But this gets quite complex, since we need to
> force the guest to map a given area, after the fact, hoping that
> it didn't map it someplace else before we get to the code to map it.
> This can be done, but doing it this way is (for now) much easier.

Well, this way was more code, but you're right about the theoretical
failure mode of the vmalloc method.

>     Host            Guest1          Guest2
>  +-----------+   +-----------+  +-----------+
>  |           |   |           |  |           |
>  +-----------+   +-----------+  +-----------+
>  | HV FIXMAP |   | HV FIXMAP |  | HV FIXMAP |
>  |   TEXT    |   |   TEXT    |  |   TEXT    |
>  +-----------+   +-----------+  +-----------+
>  | GUEST 1   |   | GUEST 1   |  | UNMAPPED  |
>  |SHARED DATA|   |SHARED DATA|  |           |
>  +-----------+   +-----------+  +-----------+
>  | GUEST 2   |   | UNMAPPED  |  | GUEST 2   |
>  |SHARED DATA|   |           |  |SHARED DATA|
>  +-----------+   |           |  +-----------+
>  |           |   |           |  |           |

I think it's better to do this per-cpu, as in the recently posted 32-but
patches.  You have to copy in when changing guests, but you can support
an infinite number of guests with (HV TEXTSIZE + NR_CPUS*2) pages.

Damn, I forgot to cc you on that patch.  Sorry, I suck 8(

They went to lkml as:
[PATCH 7/9] lguest: use read-only pages rather than segments to protect hig=
h-mapped switcher
[PATCH 8/9] lguest: Optimize away copy in and out of per-cpu guest pages

Cheers!
Rusty.
