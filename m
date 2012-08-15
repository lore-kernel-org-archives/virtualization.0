From: Jan Engelhardt <jengelh@inai.de>
Subject: Re: [vmw_vmci 11/11] Apply the header code to make VMCI build
Date: Wed, 15 Aug 2012 22:45:00 +0200 (CEST)
Message-ID: <alpine.LNX.2.01.1208152240550.23372@frira.zrqbmnf.qr>
References: <1343345980-32397-1-git-send-email-astiegmann@vmware.com>
	<1343345980-32397-12-git-send-email-astiegmann@vmware.com>
	<20120727103455.GA4639@merkur.ravnborg.org>
	<alpine.LNX.2.01.1208022145380.30631@frira.zrqbmnf.qr>
	<20120802202205.GA9096@merkur.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20120802202205.GA9096@merkur.ravnborg.org>
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


On Thursday 2012-08-02 22:22, Sam Ravnborg wrote:
>> On Friday 2012-07-27 12:34, Sam Ravnborg wrote:
>> >> +#ifndef _VMCI_COMMONINT_H_
>> >> +#define _VMCI_COMMONINT_H_
>> >> +
>> >> +#include <linux/printk.h>
>> >> +#include <linux/vmw_vmci_defs.h>
>> >
>> >Use inverse chrismas tree here.
>> >Longer include lines first, and soret alphabetically when
>> >lines are of the same length.
>> 
>> So that's where unreadable include lists come from.
>> Depth-first lexicographically-sorted is a lot less hassle,
>> especially when it comes to merging patches that each
>> add one different include.
>This is applied in many parts of the kernels and has some benefits:
>- easy to spot duplicates
>- clash is less likely when two commit adds includes

Sorting already addresses the two, the christmas thing (for
files in a single dir) seems like adding no extra value.


>>>The kernel types are u32 not uint32_t - these types belongs in user-space.
>Found the following somewhere on the net:
>
>|	- the kernel should not depend on, or pollute user-space naming.
>|	  YOU MUST NOT USE "uint32_t" when that may not be defined, and
>|	  user-space rules for when it is defined are arcane and totally
>|	  arbitrary.

I can see the reasoning for header files, but it seems
irrelevant for code, in particular .c files, that never
practically get exposed to userspace.
