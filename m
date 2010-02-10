From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: Paravirt compile failure with gcc33
Date: Wed, 10 Feb 2010 10:38:01 -0800
Message-ID: <4B72FD09.1020202@goop.org>
References: <alpine.LSU.2.01.1002101909560.29808@obet.zrqbmnf.qr>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <alpine.LSU.2.01.1002101909560.29808@obet.zrqbmnf.qr>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jan Engelhardt <jengelh@medozas.de>
Cc: virtualization@lists.osdl.org, "H. Peter Anvin" <hpa@zytor.com>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: virtualization@lists.linuxfoundation.org

On 02/10/2010 10:13 AM, Jan Engelhardt wrote:
> As I was compile-testing 2.6.33-rc with gcc-3.3,
> binutils-2.19.51-10.26.4.x86_64, I observed a failure when
> CONFIG_PARAVIRT is turned on:
>    

Yeah, there's a gcc bug of some kind there, and its very hard to see how 
to work around it.  When we last discussed this, I think we were close 
to deciding to obsolete gcc 3.3.

HPA, do you remember?

     J

>
> [any file]
> /home/jengelh/code/linux/arch/x86/include/asm/paravirt.h: In function
> `rif_seq_stop':
> /home/jengelh/code/linux/arch/x86/include/asm/paravirt.h:763: warning:
> asm operand 5 probably doesn't match constraints
> /home/jengelh/code/linux/arch/x86/include/asm/paravirt.h:858: warning:
> asm operand 2 probably doesn't match constraints
> /home/jengelh/code/linux/arch/x86/include/asm/paravirt.h:763: error:
> impossible constraint in `asm'
> /home/jengelh/code/linux/arch/x86/include/asm/paravirt.h:858: error:
> impossible constraint in `asm'
>
> Disabling either PARAVIRT or using GCC4.x works around this.
> _______________________________________________
> Virtualization mailing list
> Virtualization@lists.linux-foundation.org
> https://lists.linux-foundation.org/mailman/listinfo/virtualization
>
>    
