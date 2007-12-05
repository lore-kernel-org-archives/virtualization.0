From: Mark Williamson <mark.williamson@cl.cam.ac.uk>
Subject: Re: Re: Next steps with pv_ops for Xen
Date: Wed, 5 Dec 2007 03:42:19 +0000
Message-ID: <200712050342.25373.mark.williamson@cl.cam.ac.uk>
References: <000001c835db$72d9de90$ddf4e880@pwfad.pwf.private.cam.ac.uk>
	<200712031908.11079.mark.williamson@cl.cam.ac.uk>
	<47551F70.7080300@sina.com.cn>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: quoted-printable
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <47551F70.7080300@sina.com.cn>
Content-Disposition: inline
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: tgh <wwwwww4187@sina.com.cn>
Cc: xen-devel@lists.xensource.com, 'Eduardo Habkost' <ehabkost@redhat.com>, 'Juan Quintela' <quintela@redhat.com>, "'Stephen C. Tweedie'" <sct@redhat.com>, 'Jan Beulich' <jbeulich@novell.com>, 'Glauber de Oliveira Costa' <gcosta@redhat.com>, 'Chris Wright' <chrisw@sous-sol.org>, virtualization@lists.osdl.org, dgm36@cam.ac.uk, 'Gerd Hoffmann' <kraxel@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

> I am not quite clear about the purpose of pv-ops , what do we want to
> deal with by developping "pv-ops"? is it used for HVM or for PV or KVM
> or something ? I have seen it for a few months in the list ,and
> "pv-ops"is an active project ,but i am not clear about what is the aim
> of "pv-ops" ,could you give me an explanation about it

PV-ops is an API within Linux which is used to support paravirtualisation.

paravirt-ops makes it possible to compile a Linux kernel which can boot on=
=20
bare hardware, or on Xen, or using VMI (VMware's paravirtualised interface)=
,=20
lguest, or any other VMM that is supported.  The resulting kernel can then=
=20
boot on any of those and make proper use of paravirtualisation.

=46or instance, with 2.6.23 from kernel.org you should be able to compile a=
=20
kernel that will boot both on bare hardware and in a Xen domU in PV mode. =
=20
Various tricks are used to ensure that it will run with good performance on=
=20
both.

pv-ops mostly deals with the paravirtualisation of the CPU.  IO devices suc=
h=20
as block and network are handled using Xen-aware drivers rather similar to=
=20
those in the XenSource Linux kernels, they are not part of pv-ops.

Cheers,
Mark


> Thanks in advance
>
> Mark Williamson =E5=86=99=E9=81=93:
> >> Hi Mark,
> >>
> >>> Maybe a change to the gntdev userspace API to allow batching
> >>> of mapping requests?
> >>
> >> Something along the lines of the following?
> >
> > Just like that :-D
> >
> > When you said "multiple syscalls per mapping" I assumed you meant that
> > we'd lose the batching you get by doing a mulicall.  If it's just a
> > couple of syscalls (plus, presumably a couple of hypercalls) per batch =
of
> > mappings, my gut says it's probably not going to hurt block performance=
=2E=20
> > My guts have been wrong in (many!) ways before of course...
> >
> > I guess the overhead *could* be reduced even more by just having a magic
> > ioctl that did all the mmap-ing stuff in one operation, but that'd
> > probably be really gross if it wasn't necessary!  And I doubt it'd make
> > upstream very happy...
> >
> > We'll also be eliminating the overheads involved in having a blktap ring
> > for talking to userspace and having to move requests between that ring
> > and the real block ring, so there's some definite wins in overheads as
> > well.
> >
> > Cheers,
> > Mark



=2D-=20
Dave: Just a question. What use is a unicyle with no seat?  And no pedals!
Mark: To answer a question with a question: What use is a skateboard?
Dave: Skateboards have wheels.
Mark: My wheel has a wheel!
