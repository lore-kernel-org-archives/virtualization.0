From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: 2.6.26-rc8 pv_ops causes Unhandled invalid opcode fault/trap
Date: Thu, 03 Jul 2008 10:34:30 -0700
Message-ID: <486D0DA6.7010901__31400.8505469703$1215106706$gmane$org@goop.org>
References: <486CE463.3070002@theshore.net> <486CF3F7.3030309@goop.org>
	<486CF789.7030700@theshore.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <486CF789.7030700@theshore.net>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Christopher S. Aker" <caker@theshore.net>
Cc: Xen-devel <xen-devel@lists.xensource.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Christopher S. Aker wrote:
> Jeremy Fitzhardinge wrote:
>> Is this consistent or sporadic?  
>
> Consistently fails to boot, across a few test boxes, slightly 
> different Xen versions -- all around Xen 3.2.1, same config.
>
>> Does it depend on how much guest memory you give it?
>
> No.  Tried with 128, 360, 5000.  They all fail in the same way.
>
>> What was the last kernel version which worked?
>
> I built a 2.6.25.10 pv_ops this morning and it boots fine.
>
>> Were there any other errors/warnings printed here?
>
> Nope.  Just some whitespace.

Are you sure?  Could you send a full xm dmesg log output?  The crash is 
from a BUG() caused by a failing hypercall.  Since you have compiled Xen 
with debug enabled, it should have printed something about why it was 
failing the hypercall.

>>> (XEN) traps.c:413:d332 Unhandled invalid opcode fault/trap [#6] on 
>>> VCPU 0 [ec=0000]
>>> (XEN) domain_crash_sync called from entry.S
>>> (XEN) Domain 332 (vcpu#0) crashed on cpu#0:
>>> (XEN) ----[ Xen-3.2.1-rc5  x86_64  debug=y  Not tainted ]----
>>> (XEN) CPU:    0
>>> (XEN) RIP:    e019:[<00000000c0103b55>]
>>
>> Could you decode this to see which function this corresponds to?
>
> I'd love to know how for future reference, but for now I've placed the 
> files here:
>
> http://www.theshore.net/~caker/xen/pvops-bug1/

Thanks, that's very interesting.  I had a very similar crash in a 
current -rc kernel when running it under the Citrix XenServer product 
version of Xen, and I wasn't sure where to point fingers.

For reference:

$ gdb 2.6.26-rc8-linode11 
GNU gdb Fedora (6.8-10.fc9)
Copyright (C) 2008 Free Software Foundation, Inc.
License GPLv3+: GNU GPL version 3 or later <http://gnu.org/licenses/gpl.html>
This is free software: you are free to change and redistribute it.
There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
and "show warranty" for details.
This GDB was configured as "i386-redhat-linux-gnu"...
(no debugging symbols found)
(gdb) x/i 0x00000000c0103b55						<- note: need to add 0x to start
0xc0103b55 <make_lowmem_page_readonly+85>:	ud2a   
(gdb) disassemble make_lowmem_page_readonly
Dump of assembler code for function make_lowmem_page_readonly:
0xc0103b00 <make_lowmem_page_readonly+0>:	push   %ebp
0xc0103b01 <make_lowmem_page_readonly+1>:	mov    %eax,%ebp
0xc0103b03 <make_lowmem_page_readonly+3>:	push   %edi
...

Thanks,
	J
