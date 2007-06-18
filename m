From: Avi Kivity <avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 1/5] KVM paravirt_ops core infrastructure
Date: Mon, 18 Jun 2007 11:03:55 +0300
Message-ID: <46763C6B.9050004@qumranet.com>
References: <4675F462.1010708@codemonkey.ws> <4675F4C3.6050700@codemonkey.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <4675F4C3.6050700-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=kvm-devel>
List-Post: <mailto:kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
List-Help: <mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/kvm-devel>,
	<mailto:kvm-devel-request-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org?subject=subscribe>
Sender: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
Errors-To: kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org
To: Anthony Liguori <anthony-rdkfGonbjUSkNkDKm+mE6A@public.gmane.org>
Cc: kvm-devel <kvm-devel-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>, virtualization <virtualization-qjLDD68F18O7TbgM5vRIOg@public.gmane.org>
List-Id: virtualization@lists.linuxfoundation.org

Anthony Liguori wrote:


> -		nr = vcpu->regs[VCPU_REGS_RBX] & -1u;
> -		a0 = vcpu->regs[VCPU_REGS_RAX] & -1u;
> +		nr = vcpu->regs[VCPU_REGS_RAX] & -1u;
> +		a0 = vcpu->regs[VCPU_REGS_RBX] & -1u;


> - * Each hypercall may have 0-6 parameters.
> - *
> - * 64-bit hypercall index is in RAX, goes from 0 to __NR_hypercalls-1
> - *
> - * 64-bit parameters 1-6 are in the standard gcc x86_64 calling convention
> - * order: RDI, RSI, RDX, RCX, R8, R9.
> + * Each hypercall may have 0-4 parameters.
>   *
> - * 32-bit index is EBX, parameters are: EAX, ECX, EDX, ESI, EDI, EBP.
> - * (the first 3 are according to the gcc regparm calling convention)
> + * 32-bit index is EAX, parameters are: EBX, ECX, EDX, ESI.


What's the motivation for these changes?



-- 
error compiling committee.c: too many arguments to function


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
