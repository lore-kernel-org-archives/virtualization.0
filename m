From: Oleg Verych <olecom@flower.upol.cz>
Subject: Re: [PATCH 1/7] paravirtualization: header and stubs for paravirtualizing critical operations
Date: Thu, 2 Nov 2006 07:44:03 +0000 (UTC)
Message-ID: <slrnekj8qv.2in.olecom@flower.upol.cz>
References: <20061029024504.760769000@sous-sol.org> <20061029024607.401333000@sous-sol.org> <200610290831.21062.ak@suse.de> <1162178936.9802.34.camel@localhost.localdomain> <20061030231132.GA98768@muc.de> <1162376827.23462.5.camel@localhost.localdomain> <20061101231313.4c91a9a9.akpm@osdl.org>
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752712AbWKBHoY@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On 2006-11-02, Andrew Morton wrote:
> This patch breaks `make headers_check' in mysterious ways:
>
>   CHECK   include/linux/netfilter_ipv4/ip_conntrack_tcp.h
>   CHECK   include/linux/netfilter_ipv4/ip_conntrack_sctp.h
>   CHECK   include/linux/netfilter_ipv4/ip_conntrack_protocol.h
>   CHECK   include/linux/netfilter_ipv4/ip_conntrack_helper_h323_types.h
>   CHECK   include/linux/netfilter_ipv4/ip_conntrack_helper_h323_asn1.h
>   CHECK   include/linux/netfilter_ipv4/ip_conntrack_helper.h
> make[2]: *** [/usr/src/devel/usr/include/asm/.check.setup.h] Error 1
> make[2]: *** Waiting for unfinished jobs....
> make[1]: *** [asm-i386] Error 2
> make[1]: *** Waiting for unfinished jobs....
> make: *** [headers_check] Error 2

It seems like missing
"header-y += paravirt.h" in the "include/asm-i386/Kbuild".
____
