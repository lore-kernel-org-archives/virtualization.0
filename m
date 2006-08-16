From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Proposed interface change
Date: Wed, 16 Aug 2006 19:16:41 +0100
Message-ID: <44E36109.8030809@goop.org>
References: <44E18986.40900@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <virtualization-bounces@lists.osdl.org>
In-Reply-To: <44E18986.40900@vmware.com>
List-Unsubscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=unsubscribe>
List-Archive: <http://lists.osdl.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.osdl.org>
List-Help: <mailto:virtualization-request@lists.osdl.org?subject=help>
List-Subscribe: <https://lists.osdl.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.osdl.org?subject=subscribe>
Sender: virtualization-bounces@lists.osdl.org
Errors-To: virtualization-bounces@lists.osdl.org
To: Zachary Amsden <zach@vmware.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> So I propose changing the convention here to eliminate the entrynum =

> field, thus allowing all the parameters to fit within the fastcall =

> convention, which affords us three registers.  The primary motivation =

> being, the call to write_gdt_entry is on the fast path in context switch.
>
> Any objections?

Yeah, write_idt_entry can't be done with just a pointer because we need =

to get the index out of it, and we don't necessarily know the base of =

the table being written at that time (since it might not be the main =

idt_table).

So what Christian said, basically.

    J
