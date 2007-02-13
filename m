From: Zachary Amsden <zach@vmware.com>
Subject: Re: Re: [patch 14/21] Xen-paravirt: Add XEN config options
	and disable unsupported config options.
Date: Tue, 13 Feb 2007 15:58:20 -0800
Message-ID: <45D2509C.4070502@vmware.com>
References: <20070213221729.772002682@goop.org>	<20070213221830.542511707@goop.org>
	<45D24172.9020800@vmware.com> <45D249D9.80407@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <45D249D9.80407@goop.org>
List-Unsubscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/cgi-bin/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Andrew Morton <akpm@osdl.org>, xen-devel@lists.xensource.com, Andi Kleen <ak@muc.de>, Dan Hecht <dhecht@vmware.com>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, Ian Pratt <ian.pratt@xensource.com>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
> Dan Hecht wrote:
>   
>> I assume you plan to eventually get all this stuff working but just
>> want to prevent configurations that the Xen paravirt-ops isn't ready
>> for at the moment?
>>
>> Instead can you do it this way:
>>
>> config XEN
>>     depends on PARAVIRT && !PREEMPT && HZ_100 && !DOUBLEFAULT && !KEXEC
>>     
>
> That's a bit simpler code-wise, but it does make it pretty complex to
> get everything just-so to even see the CONFIG_XEN option.
>   

Yes, but that is what you need to do to compile Xen - logically, to 
build a Xen kernel, you need to have a kernel configuration which can 
enable Xen - not limit the configuration of a kernel because Xen has 
been enabled.  This is because  with paravirt-ops, Xen compiled kernels 
may not actually run on Xen, so you can't arbitrarily drop features 
because you assume Xen is there.

One of these has an easy solution - doublefault.  You don't need to 
install the doublefault gate if you don't want it, and the hypervisor 
doesn't need to freak out if you install it, it can just ignore the gate 
entirely and claim #DF is not supported.

Zach
