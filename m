From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: is kexec on Xen domU possible?
Date: Fri, 19 Jul 2013 20:32:35 +0200
Message-ID: <20130719183235.GA12267@debian70-amd64.local.net-space.pl>
References: <20130719020603.GA22932@kroah.com>
	<20130719131819.GC11233@debian70-amd64.local.net-space.pl>
	<20130719151243.GA15488@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20130719151243.GA15488@kroah.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Greg KH <gregkh@linuxfoundation.org>
Cc: xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Eric Biederman <ebiederm@xmission.com>, Brandon Philips <brandon@ifup.org>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 19, 2013 at 08:12:43AM -0700, Greg KH wrote:
> On Fri, Jul 19, 2013 at 03:18:19PM +0200, Daniel Kiper wrote:
> > > support is "easy" after your patches go in, is that because Dom0 needs
> > > to support this, or is it something specific to only domU?
> >
> > In case of domU we should consider following cases:
> >   - PV guests: there is no support for kexec at this time;
> >     Once I wrote an implementatation for that type of guests
> >     for one company but according to our agreement I could not
> >     publish this code; However, I could use it as a base for
> >     publicly available kexec implementation; Currently, I do
> >     not have any plans to work on this due to some more important
> >     stuff to do; However, question about kexec support for PV
> >     guests is raised from time to time and maybe this issue
> >     will be much more important than others once,
> >   - HVM guests: kexec should work without any issue,
> >   - PVonHVM guests: IIRC, there were some issues with PV
> >     drivers but they were fixed some time ago by patches
> >     posted by Olaf Hering,
> >   - PVH guests: those type of guests are not available in Xen
> >     current releases yet; However, Konrad Wilk done some preliminary
> >     work on kexec support but there are still some issues to resolve.
> >
> > I do not know what are you trying to do but if you would like
> > to get some crash dumps there is also another solution to that.
> > You could use xm/xl dump-core from Dom0 to get dumps of domU memory.
>
> As Brandon said, we were trying to use kexec in a PV guest in domU to
> run another kernel.  I had assumed this wouldn't need support from dom0.

You are right.

> As you have implemented this in the past, did you need to change dom0 in
> order to achieve this, and if so, why?

It was strong requirement to not change anything in hypervisor or dom0.
I succeeded to do that but it requires changes in kernel and kexec-tools.

> The errors that the kexec tools seem to run into is finding the memory
> to place the new kernel into, is that just an issue that PV guests
> aren't given enough kernel memory in which to replicate themselves from
> dom0?

There are a lot of differences between baremetal machines and PV guests.
For example you are not able to do identity mapping per se in PV guests.
Arguments to new kernel are passed in completely different way. etc.

Daniel
