From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Xen paravirt_ops tree for testing
Date: Wed, 21 Feb 2007 12:55:07 -0800
Message-ID: <45DCB1AB.5050103@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Xen-devel <xen-devel@lists.xensource.com>, Virtualization Mailing List <virtualization@lists.osdl.org>
List-Id: virtualization@lists.linuxfoundation.org

Hi all,

I'm hoping to get the Xen paravirt_ops implementation into the kernel
very soon.  I've been doing regular post/refine cycles, and I think its
now very close to something that will be accepted.  The principle
concern at this point is that there haven't been very many people
actually running the code.

So this is where you come in.  I'd appreciate it if people could grab
the patch queue from http://ozlabs.org/~rusty/paravirt/ - or from the
posting I'm about to make - and tell me if it works for you.

This is a limited Xen implementation for now, so bear in mind that it's:

    * domU only
    * UP only
    * netfront and blockfront only
    * not particularly performance tuned

But it should support both PAE and non-PAE.   Oh, and the console will
be hvc0, since its using the hvc console infrastructure rather than the
traditional xen-console.

Thanks,
    J
