From: Avi Kivity <avi-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
Subject: Re: [PATCH 4/5] KVM: Add hypercall queue for
	paravirt_ops implementation
Date: Mon, 18 Jun 2007 19:00:16 +0300
Message-ID: <4676AC10.3090007@qumranet.com>
References: <4675F462.1010708@codemonkey.ws> <4675F568.90608@codemonkey.ws>
	<46764B47.5060403@qumranet.com>
	<46767D47.1010104@codemonkey.ws> <46767F98.70109@qumranet.com>
	<46768724.3000509@codemonkey.ws> <46768A3F.2010202@qumranet.com>
	<4676905B.6000805@codemonkey.ws> <46769FFE.6040502@qumranet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <kvm-devel-bounces-5NWGOfrQmneRv+LV9MX5uipxlwaOVQ5f@public.gmane.org>
In-Reply-To: <46769FFE.6040502-atKUWr5tajBWk0Htik3J/w@public.gmane.org>
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

Avi Kivity wrote:
>
>>
>>> For every vmexit, it does the entire thing, including vmload/vmsave
>>
>> I haven't had a lot of luck eliminating vmload/vmsave.
>>
>
> For x86_64, the only issue I see is with TR.  Unfortunately, I don't 
> see a way around it.
>

I think we can avoid vmload (but not vmsave):

1. Allocate a host gdt entry for kvm's exclusive use.

2. The first entry into the guest needs vmload as usual. The second 
entry reuses already-loaded registers, except tr, gs.base, and kernelgsbase.

3. To load tr, copy the descriptor into our gdt entry, and execute ltr.

4. To load gs.base, load the saved value into MSR_KERNELGSBASE, and 
execute swapgs

5. To load kernelgsbase, use wrmsr()

However, I'm not at all sure it's worth it.

-- 
error compiling committee.c: too many arguments to function


-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
