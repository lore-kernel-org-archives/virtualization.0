From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: proposed interface change for setting the ldt
Date: Sat, 19 Aug 2006 13:18:58 +0100
Message-ID: <44E701B2.8050005@goop.org>
References: <44E599A3.6020907@goop.org> <44E621BA.6090001@vmware.com>	
	<44E679ED.6010300@goop.org> <44E681B8.3020804@vmware.com>	
	<20060819032249.GB10348@sequoia.sous-sol.org>
	<44E68857.6040806@vmware.com>
	<1155961927.9203.19.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <1155961927.9203.19.camel@localhost.localdomain>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty Russell wrote:
> It sounds fine to me, although I'd like to see the patch.  I don't have
> anything against higher-level abstractions, if it helps any hypervisor,
> as long as it doesn't warp the kernel code.  And if most hypervisors and
> native break it down the same way, well, we can always create helpers.
>   =


Doing it this way does save a lot of complexity in the Xen case, which =

would otherwise have to:

   1. unpack the descriptor
   2. if it's an LDT, save it off in a per-cpu structure
   3. when load_ldt_desc is called, look up the structure, extract the
      base+size of the ldt, and make a hypercall to set the ldt

vs

   1. set the ldt


    J
