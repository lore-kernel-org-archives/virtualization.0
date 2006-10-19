From: Zachary Amsden <zach@vmware.com>
Subject: Re: pv_ops smp support
Date: Thu, 19 Oct 2006 16:34:02 -0700
Message-ID: <45380B6A.3030104@vmware.com>
References: <453805BF.80301@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <453805BF.80301@goop.org>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> I'm looking at adding Xen SMP support, so I'm trying to work out what =

> pv_ops we need, and how to cut into the existing smp stuff.
>
> So at first pass, it looks like we need 6-8 new pv_ops for SMP, which =

> isn't very appealing.
>
> Any thoughts about how to come up with a more elegant interface?  I'm =

> digging through smpboot.c and friends, but there's a lot of goo in =

> there...

Most of the goo is apic related goo, which can be conveniently be tucked =

out of the way by just ignoring or putting in appropriate hooks.  Before =

we try to dissect this into operations, I think there are two bigger =

fundamental questions you need to answer -

1) What do you plan to do to address per-cpu data structures?
2) What is your remote TLB shootdown model?

Both of these could have major impacts on how you want to carve up smp.c =

and smpboot.c.

Zach
