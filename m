From: Christopher Clark <christopher.w.clark@gmail.com>
Subject: Re: Device Drivers in xen, looking also for a white book about how
	xen works exactly
Date: Wed, 18 Mar 2009 11:40:02 -0700
Message-ID: <eab087540903181140r2999c99ci13260782237f2479@mail.gmail.com>
References: <COL103-W59467031B71F1DC083C226ABAB0@phx.gbl>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <COL103-W59467031B71F1DC083C226ABAB0@phx.gbl>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Patrick Archibal <bugpb60@hotmail.com>
Cc: virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Patrick

Consider reading this:

http://www.amazon.com/Definitive-Hypervisor-Prentice-Software-Development/d=
p/013234971X/ref=3Dpd_sim_b_1

To your questions:

1. Real device drivers run in dom0.
Dom0 also runs the backend drivers that support the guest drivers in
paravirtualized domUs, and runs the emulation of virtual devices
presented to HVM domUs.

2. Guest drivers are largely written by the xen community for
paravirtualized ports of guest OSes.

3. Dom0 currently provides real device drivers and infrastucture to
support running both PV and HVM guest domUs.

Again, please consider reading that book.

Christopher

On Sat, Feb 28, 2009 at 12:54 PM, Patrick Archibal <bugpb60@hotmail.com> wr=
ote:
> Hello,
>
> I'm reading an excellent documentation about virtualisation in embedded
> system.
>  (available on open kernel labs site)
>
> I have read these things : (It talks about managing drivers in a
> virtualization system)
>
> "A straight virtualization approach can accomodate this by running the
> device the device driver inside the VMM. This requires porting all drivers
> to the hypervisor environnement , with no reuse of guest os driver"
>
> A much better approach is to share a single driver between multiple vms,
> without including it in the hypervisor. This requires that ecah
> participating subsytem has a device modem for which it has a device drive=
r.
> Typically, the real device driver is contained in one of the participating
> system, but a better  (safer) solution is to separate it out into in own
> subsystem"
>
> I want to know how it works on xen.
> I think that :
>
>  All drivers are in the hypervisor, when a guest requires to use a
> device,  guest uses drivers which has been rewriten for xen in order to
> contact the hypervisor. Then, the hypervisor which has all real drivers (=
not
> modified) call the real device ?
>
> or that :
> The real device driver is contained in the dom0 system, the dom0 manage
> driver for all domU.
>
> I have three questions :
>
> 1 -  Which is the good scenario ? (if one is good ) :o)
> 2 - If drivers for guests are rewritten to call hypervisor or dom0 instead
> of the device directly, who devellops driver ?
> (xen devellopers ? or developper for kernel mainline)
> 3- Which is the real utility of dom0 system ? (just I/O and administration
> of virtual machines)
>
> Last question, is someone have find a good white paper or doc which expla=
ins
> how xen works ?
> (and where i can find probably answers for my questions ??)
>
> Thanks for all this details.
> Best regards
>
> Patrick Archibal
>
>
>
>
> ________________________________
> Souhaitez vous  =AB =EAtre au bureau sans y =EAtre =BB ? Oui je le veux !
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/virtualization
>
