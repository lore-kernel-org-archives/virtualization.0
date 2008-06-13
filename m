From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: linux-next: Tree for June 13 (XEN)
Date: Fri, 13 Jun 2008 23:16:40 +0100
Message-ID: <4852F1C8.7060904@goop.org>
References: <20080613232214.394fd6fd.sfr@canb.auug.org.au> <20080613101316.1c228fe7.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20080613101316.1c228fe7.randy.dunlap@oracle.com>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, chrisw@sous-sol.org, virtualization@lists.osdl.org, linux-next@vger.kernel.org, LKML <linux-kernel@vger.kernel.org>, Jens Axboe <jens.axboe@oracle.com>
List-Id: virtualization@lists.linuxfoundation.org

Randy Dunlap wrote:
> next-20080613 on x86_32 has lots of xen build errors like this:
>
> linux-next-20080613/arch/x86/xen/mmu.c: In function 'drop_mm_ref':
> linux-next-20080613/arch/x86/xen/mmu.c:759: error: implicit declaration of function 'xen_smp_call_function_mask'
> make[2]: *** [arch/x86/xen/mmu.o] Error 1
>
>   

Ooh, first time I've seen that.  Sounds like Jens' patches are missing 
the appropriate update there (though it's certainly had it in the past).

    J

