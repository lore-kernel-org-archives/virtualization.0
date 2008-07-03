From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: 2.6.26-rc8 pv_ops causes Unhandled invalid opcode fault/trap
Date: Thu, 03 Jul 2008 08:44:55 -0700
Message-ID: <486CF3F7.3030309__5375.27125929973$1215100036$gmane$org@goop.org>
References: <486CE463.3070002@theshore.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <486CE463.3070002@theshore.net>
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
> Xen: 3.2.1-rc5 64bit
> Dom0: 2.6.18.8 (at cs 524) 32-pae
> DomU: 2.6.26-rc8 32-pae
>
> root@newark13:~# xm create -f /linodes/xencaker/xen.conf -c
> Using config file "/linodes/xencaker/xen.conf".
> Started domain xencaker

Is this consistent or sporadic?  Does it depend on how much guest memory 
you give it?  What was the last kernel version which worked?

>                        root@newark13:~#
>
> root@newark13:~# xm dmesg
> ...

Were there any other errors/warnings printed here?

> (XEN) traps.c:413:d332 Unhandled invalid opcode fault/trap [#6] on 
> VCPU 0 [ec=0000]
> (XEN) domain_crash_sync called from entry.S
> (XEN) Domain 332 (vcpu#0) crashed on cpu#0:
> (XEN) ----[ Xen-3.2.1-rc5  x86_64  debug=y  Not tainted ]----
> (XEN) CPU:    0
> (XEN) RIP:    e019:[<00000000c0103b55>]

Could you decode this to see which function this corresponds to?

> (XEN) RFLAGS: 0000000000000282   CONTEXT: guest
> (XEN) rax: 00000000ffffffea   rbx: 00000000deadbeef   rcx: 
> 00000000deadbeef
> (XEN) rdx: 00000000deadbeef   rsi: 00000000deadbeef   rdi: 
> 00000000c06c1000
> (XEN) rbp: 00000000c06c0000   rsp: 00000000c0667f08   r8:  
> 0000000000000000
> (XEN) r9:  0000000000000000   r10: 0000000000000000   r11: 
> 0000000000000000
> (XEN) r12: 0000000000000000   r13: 0000000000000000   r14: 
> 0000000000000000
> (XEN) r15: 0000000000000000   cr0: 000000008005003b   cr4: 
> 00000000000026b0
> (XEN) cr3: 00000002d351b000   cr2: 0000000000000000
> (XEN) ds: e021   es: e021   fs: e021   gs: e021   ss: e021   cs: e019
> (XEN) Guest stack trace from esp=c0667f08:
> (XEN)   c0103b55 0001e019 00010082 00000001 006c0000 c0756d50 c06c1000 
> c065c580
> (XEN)   c067e4dc c0667f44 c0678ac9 c0667f38 00100000 c0756d50 00000000 
> 00000000
> (XEN)   00040800 00010676 c0667fb8 c06a3b00 c065c680 c065c580 c0676452 
> 00000000
> (XEN)   00000000 00000000 c065c580 00000000 c0667fb0 c0667fa4 c0667fac 
> 1f898975
> (XEN)   40000000 c0667fdc f5800000 00000007 40000000 c0667fdc f5800000 
> 00000007
> (XEN)   c066e771 c0537060 f5800000 00000007 c012500f 40000000 c06753a2 
> 00000000
> (XEN)   c069c5c0 c069c5dc c069c698 c069c6b0 00000000 1f898975 00080201 
> 00040800
> (XEN)   00010676 f5800000 00000000 c0752000 00000000 00000000
>
> -Chris

Thanks,
    J
