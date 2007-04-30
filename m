From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: huh startup_ipi_hook?
Date: Mon, 30 Apr 2007 14:05:19 -0700
Message-ID: <46365A0F.9040901@goop.org>
References: <m1d51pgeby.fsf@ebiederm.dsl.xmission.com>
	<4632F653.3000102@goop.org> <46363662.40806@vmware.com>
	<46363B5D.7060101@goop.org> <463652FE.9080604@vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <463652FE.9080604@vmware.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Zachary Amsden <zach@vmware.com>
Cc: virtualization@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

Zachary Amsden wrote:
> But the native and vmi versions would be identical.  You would be
> moving the apic_read / apic_write operations from paravirt_ops to
> apic_ops, which doesn't really solve anything, it just moves it around.

Yes, that's fine.  The idea is that paravirt_ops is intended to be a
relatively coherent interface for implementing a paravirtualized guest,
and ideally, shrinking it over time.

Given that the way VMI uses the apic as part of its hypervisor interface
is a VMI implementation detail which doesn't live at the same level of
abstraction as the rest of paravirt_ops.  What's more, the apic
interfaces have no relevance to either lguest or Xen, and there's simply
no meaningful implementation for the operations other than "hope these
don't get called".

I think the more things we can devolve out of paravirt_ops the better,
especially if they make well-defined self-contained interfaces of their
own.  I would be open, for example, to moving all the pagetable and
privileged instruction operations out into their own _ops interfaces
(but not right now).

    J
