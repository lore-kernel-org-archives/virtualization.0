From: Zachary Amsden <zach@vmware.com>
Subject: Re: huh startup_ipi_hook?
Date: Mon, 30 Apr 2007 11:33:06 -0700
Message-ID: <46363662.40806@vmware.com>
References: <m1d51pgeby.fsf@ebiederm.dsl.xmission.com>
	<4632F653.3000102@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <4632F653.3000102@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: virtualization@lists.osdl.org, "Eric W. Biederman" <ebiederm@xmission.com>
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> This is a fairly close match to Xen's requirements. Certainly, anything
> APIC-related is useless for us, since there's no APIC emulation going on.
>
> I won't speak for Zach, but his counter-argument is generally along the
> lines of "we can just make use of the existing code with a couple of
> little hooks near the bottom". But I wonder if the existing genapic
> interface can be used (or extended) to cover these cases without having
> needing to have APIC-level interfaces in paravirt_ops.

Because we faithfully emulate the APIC and IO-APIC, that is the 
underlying hardware for us, and we don't have a fancy paravirtualized 
interrupt controller because there is no need for it.  The only 
obstruction to this approach is that trapping and emulating APIC access 
is slow.  And some APIC registers have side effects on read.  So we 
simply replace APIC read / write with faster hypercalls.

Of course we can create a bunch of new code to use the genapic 
interface.  It is just a matter of copying apic.c and io-apic.c verbatim 
and applying the sed command s/apic/vmi_apic/g.  We can easily do this, 
but the only point would be to eliminate the low-level APIC access 
paravirt-op, which is not a maintenance burden, performance problem, or 
encumberance on anyone.  So it would be purely a cleanliness thing.  
Doubling code to make two separate copies when the interface in question 
is already well abstracted and contained in a header file doesn't make 
it cleaner, at least to me.

Zach
