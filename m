From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: lguest over qemu
Date: Fri, 13 Jul 2007 09:44:34 +1000
Message-ID: <1184283874.6005.812.camel@localhost.localdomain>
References: <21a166410707110251x574bbb13h4c8d70a7e39155c7@mail.gmail.com>
	<1184210340.6005.723.camel@localhost.localdomain>
	<21a166410707120802g705b64d4o424e1f74a876ba60@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <21a166410707120802g705b64d4o424e1f74a876ba60@mail.gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Matias Zabaljauregui <matias.zabaljauregui@cern.ch>
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 2007-07-12 at 17:02 +0200, Matias Zabaljauregui wrote:
> Rusty, 
> 
> You were right, it was the kernel configuration. 

Hi Matias,

	Any chance you could tell me what configuration option broke lguest?  I
should either fix it or document it...

> Changing the subject, in the next month I will be studying the
> possibilities of implementing the idea behind xenoprof, for lguest. 
> Do you think this can be useful ?  
> Any advice? 

	One purpose of lguest is to demonstrate how virtualization should work,
so including profiling support is useful.  But the other purpose of
lguest is to be simple, so it depends how simple the patch to lguest
is...

	(Note that lguest doesn't support NMIs, but Steven has code for NMI
support for lguest-x86-64 which could be ported across).

Cheers!
Rusty.
