From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: [vmw_vmci 11/11] Apply the header code to make VMCI build
Date: Thu, 2 Aug 2012 21:50:02 +0200 (CEST)
Message-ID: <alpine.LNX.2.01.1208022145380.30631__23949.4684305557$1343946124$gmane$org@frira.zrqbmnf.qr>
References: <1343345980-32397-1-git-send-email-astiegmann@vmware.com>
	<1343345980-32397-12-git-send-email-astiegmann@vmware.com>
	<20120727103455.GA4639@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120727103455.GA4639@merkur.ravnborg.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Sam Ravnborg <sam@ravnborg.org>
Cc: pv-drivers@vmware.com, gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, vm-crosstalk@vmware.com, "Andrew Stiegmann (stieg)" <astiegmann@vmware.com>, cschamp@vmware.com
List-Id: virtualization@lists.linuxfoundation.org


On Friday 2012-07-27 12:34, Sam Ravnborg wrote:
>> +#ifndef _VMCI_COMMONINT_H_
>> +#define _VMCI_COMMONINT_H_
>> +
>> +#include <linux/printk.h>
>> +#include <linux/vmw_vmci_defs.h>
>
>Use inverse chrismas tree here.
>Longer include lines first, and soret alphabetically when
>lines are of the same length.

So that's where unreadable include lists come from.
Depth-first lexicographically-sorted is a lot less hassle,
especially when it comes to merging patches that each
add one different include.

>> +/*
>> + * Utilility function that checks whether two entities are allowed
>> + * to interact. If one of them is restricted, the other one must
>> + * be trusted.
>> + */
>> +static inline bool vmci_deny_interaction(uint32_t partOne,
>> +					 uint32_t partTwo)
>
>The kernel types are u32 not uint32_t - these types belongs in user-space.

Not really. uint32_t is the C99 type for a 32-bit quantity, and I see
absolutely zero reason not to use standardized things. The only
exception are header files visible to user space where __u32 should
be used for (obscure) reasons of avoiding naming clashes.

(Obscure because uint32_t is always supposed to be 32 bits.)
