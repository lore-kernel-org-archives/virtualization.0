From: Zachary Amsden <zach@vmware.com>
Subject: Re: proposed interface change for setting the ldt
Date: Sun, 20 Aug 2006 22:01:49 -0700
Message-ID: <44E93E3D.7060203@vmware.com>
References: <44E599A3.6020907@goop.org> <44E621BA.6090001@vmware.com>	
	<44E679ED.6010300@goop.org> <44E681B8.3020804@vmware.com>	
	<20060819032249.GB10348@sequoia.sous-sol.org>
	<44E68857.6040806@vmware.com>
	<1155961927.9203.19.camel@localhost.localdomain>
	<44E701B2.8050005@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <44E701B2.8050005@goop.org>
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
> Rusty Russell wrote:
>> It sounds fine to me, although I'd like to see the patch.  I don't have
>> anything against higher-level abstractions, if it helps any hypervisor,
>> as long as it doesn't warp the kernel code.  And if most hypervisors and
>> native break it down the same way, well, we can always create helpers.
>>   =

>
> Doing it this way does save a lot of complexity in the Xen case, which =

> would otherwise have to:
>
>   1. unpack the descriptor
>   2. if it's an LDT, save it off in a per-cpu structure
>   3. when load_ldt_desc is called, look up the structure, extract the
>      base+size of the ldt, and make a hypercall to set the ldt
>
> vs
>
>   1. set the ldt

This way works for us as well, but my opinion is - Xen deliberately =

broke the x86 interface here, for no strong reason.  In an ideal world, =

we shouldn't have to change Linux to work around that, nor should other =

hypervisors have to live with the consequences of that decision.  So I =

believe the onus is on Xen to fix the problem in their layer, not the =

other way around.  But I have no problem adapting to this way of doing =

things for now, since this is not performance critical, and LDT is =

barely used in Linux anyway, even then, mostly by unsupported =

applications in a paravirtualized world.

Zach
