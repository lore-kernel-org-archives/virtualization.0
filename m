From: "Christopher S. Aker" <caker@theshore.net>
Subject: Re: 2.6.26-rc8 pv_ops causes Unhandled invalid opcode fault/trap
Date: Thu, 03 Jul 2008 14:24:58 -0400
Message-ID: <486D197A.7040808__31166.8899179951$1215109717$gmane$org@theshore.net>
References: <486CE463.3070002@theshore.net> <486CF3F7.3030309@goop.org>
	<486CF789.7030700@theshore.net> <486D0DA6.7010901@goop.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <486D0DA6.7010901@goop.org>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Jeremy Fitzhardinge <jeremy@goop.org>
Cc: Xen-devel <xen-devel@lists.xensource.com>, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Jeremy Fitzhardinge wrote:
>>> Were there any other errors/warnings printed here?
>>
>> Nope.  Just some whitespace.
> 
> Are you sure?  Could you send a full xm dmesg log output?  The crash is 
> from a BUG() caused by a failing hypercall.  Since you have compiled Xen 
> with debug enabled, it should have printed something about why it was 
> failing the hypercall.

Unfortunately, I included the entire dmesg output from that xm create 
run.  Here's more of the transcript in case it's useful:

http://www.theshore.net/~caker/xen/pvops-bug1/log.txt

Although, looking at it again, I did miss this line:

(XEN) mm.c:645:d341 Non-privileged (341) attempt to map I/O space 000d2e50

> For reference:
> 
> $ gdb 2.6.26-rc8-linode11 GNU gdb Fedora (6.8-10.fc9)
> Copyright (C) 2008 Free Software Foundation, Inc.
> License GPLv3+: GNU GPL version 3 or later 
> <http://gnu.org/licenses/gpl.html>
> This is free software: you are free to change and redistribute it.
> There is NO WARRANTY, to the extent permitted by law.  Type "show copying"
> and "show warranty" for details.
> This GDB was configured as "i386-redhat-linux-gnu"...
> (no debugging symbols found)
> (gdb) x/i 0x00000000c0103b55                        <- note: need to add 
> 0x to start
> 0xc0103b55 <make_lowmem_page_readonly+85>:    ud2a   (gdb) disassemble 
> make_lowmem_page_readonly
> Dump of assembler code for function make_lowmem_page_readonly:
> 0xc0103b00 <make_lowmem_page_readonly+0>:    push   %ebp
> 0xc0103b01 <make_lowmem_page_readonly+1>:    mov    %eax,%ebp
> 0xc0103b03 <make_lowmem_page_readonly+3>:    push   %edi

Cool, thanks :)

-Chris
