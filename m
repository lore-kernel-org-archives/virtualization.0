From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Oops
Date: Thu, 11 Jan 2007 11:56:18 -0800
Message-ID: <45A69662.8000008@goop.org>
References: <45A399D7.3090205@suse.de> <45A41B60.3070500@goop.org>
	<45A4A0C7.5050405@suse.de> <45A4C014.9030909@suse.de>
	<45A55E29.2090207@goop.org> <45A645C3.2060802@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <45A645C3.2060802@suse.de>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Gerd Hoffmann <kraxel@suse.de>
Cc: Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Gerd Hoffmann wrote:
> Didn't try (yet), but I don't think so.  It's not the pgd which is
> broken, but the pmd.  And I think this way:
>
>   (1) pmd is created
>   (2) pmd is taken out of the slabcache and used for the kernel/xen
>       address space (i.e. slot-3 in the PAE pgd).
>   (3) xen fills in the page table entries for the hypervisor hole
>   (4) pmd released and put back into the slab cache.
>   (5) pmd gets reused, but for userspace addresses this time (pgd
>       slot 0-2).
>   (6) xen_pin() finds the stale entries for the hypervisor hole
>   =3D=3D> Oops.
Ah, right.

    J
