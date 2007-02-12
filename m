From: Andi Kleen <andi@firstfloor.org>
Subject: Re: porting lguest to x86_64
Date: Mon, 12 Feb 2007 19:46:28 +0100
Message-ID: <200702121946.28880.andi@firstfloor.org>
References: <1171301371.4290.48.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1171301371.4290.48.camel@localhost.localdomain>
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
To: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Monday 12 February 2007 18:29, Steven Rostedt wrote:

> Host always mapped:
> =

>         Since the virtual address space is very large, it would be much
>         simpler to just keep the Host always mapped in the Guests
>         address space.  So the Guest will be more like a process here.
>         So instead of just mapping the HV in both the Guest and Host as
>         a hypervisor_blob, the entire Host will continually remain
>         mapped.  This simplifies things tremendously.

How do you protect the host from the guest kernel then?
 =

Segment limits as used by i386 lguest won't work.

[there is one way I know of but it has some drawbacks
and wouldn't work with a fully mapped linux kernel host]

The Xen method is to run guest kernel and guest guest both
at ring 3 with different address spaces. Or you can use VT/SVM.
         =

> The VCPU descriptor:
> =

>         This will hold function pointers for system calls and fault
>         handlers. =


These would be better just mapped to a known address? =


> System Calls:
> =

>         On all system calls (host users or guest users) the VCPU field
>         of the PDA will be checked. If it is NULL, nothing different
>         will happen than what the host already does today (see why it's
>         better to have the field in the PDA). But if it is not NULL it
>         will jump to the system_call function pointer of the VCPU
>         structure to perform the guest operations.

What is the point of this? Just to optimize hypercalls or something else?
Do you expect hypercalls from user space to be common? =

     =

> We really want to get involved, and we want to do it right, right from
> the start.  As mentioned earlier, we are new to the workings of lguest,
> and want to help out on the x86_64 front, even while it's still being
> developed on the i386 front.  We feel that because of the lack of
> limitations that x86_64 gives, the work on the x86_64 will be a large
> fork from what lguest does on i386.

It will be certainly quite different, except for the drivers.

-Andi
