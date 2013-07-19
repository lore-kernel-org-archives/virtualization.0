From: Daniel Kiper <daniel.kiper@oracle.com>
Subject: Re: is kexec on Xen domU possible?
Date: Fri, 19 Jul 2013 20:19:46 +0200
Message-ID: <20130719181946.GG11233@debian70-amd64.local.net-space.pl>
References: <20130719020603.GA22932@kroah.com>
	<20130719131819.GC11233@debian70-amd64.local.net-space.pl>
	<CAK7GKxnB933DkO8qM6HxZCbDVNn4ze5Ere7ZWnXxBieYMg88dQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <CAK7GKxnB933DkO8qM6HxZCbDVNn4ze5Ere7ZWnXxBieYMg88dQ@mail.gmail.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Brandon Philips <brandon@ifup.org>
Cc: xen-devel@lists.xensource.com, Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>, Greg KH <gregkh@linuxfoundation.org>, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Eric Biederman <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Jul 19, 2013 at 07:58:40AM -0700, Brandon Philips wrote:
> On Fri, Jul 19, 2013 at 6:18 AM, Daniel Kiper <daniel.kiper@oracle.com> wrote:
> >   - PV guests: there is no support for kexec at this time;
> >     Once I wrote an implementatation for that type of guests
> >     for one company but according to our agreement I could not
> >     publish this code; However, I could use it as a base for
> >     publicly available kexec implementation; Currently, I do
> >     not have any plans to work on this due to some more important
> >     stuff to do; However, question about kexec support for PV
> >     guests is raised from time to time and maybe this issue
> >     will be much more important than others once,
>
> To do kexec on PV guests is there a dependency on support from the dom0?

No.

> e.g. if we recreated your patches and merged them into 3.12 and booted
> on a XenServer from a few years ago would it work?

No.

> What I want to do is use kexec on existing public cloud providers,
> that use Xen, like AWS or Rackspace.

Look for HVM or PVonHVM guests support in this providers.
Sadly, there is no support for kexec on PV guests.

Daniel
