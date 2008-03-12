From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: 2.6.25-rc5-mm1 (paravirt/vsmp/no PCI)
Date: Tue, 11 Mar 2008 18:51:38 -0700
Message-ID: <47D7372A.1010003@goop.org>
References: <20080311011434.ad8c8d7d.akpm@linux-foundation.org> <20080311100955.ca113f90.randy.dunlap@oracle.com> <47D6CD04.8060303@goop.org> <20080312001040.GA6434@localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1752434AbYCLBxE@vger.kernel.org>
In-Reply-To: <20080312001040.GA6434@localdomain>
Sender: linux-kernel-owner@vger.kernel.org
To: Ravikiran G Thirumalai <kiran@scalex86.org>
Cc: Randy Dunlap <randy.dunlap@oracle.com>, Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <glommer@gmail.com>, shai@scalex86.org
List-Id: virtualization@lists.linuxfoundation.org

Ravikiran G Thirumalai wrote:
> Would anyone have objection to have PARAVIRT depend on PCI, since the
> vsmp paravirt bits depend on PCI cfg space to determine if the system is
> vsmp?   If not, this patch would suffice.
>   

NAK.  Xen doesn't depend on PCI at all.   Why not make VSMP depend on 
PCI?  Then you could put something like:

#ifdef CONFIG_X86_VSMP
extern void vsmp_init(void);
extern int is_vsmp_box(void);
#else
static inline void vsmp_init(void)
{
}

static inline int is_vsmp_box(void)
{
	return 0;
}
#endif


in an appropriate header.

Hm, looks like arch/x86/kernel/Makefile should be

obj-$(CONFIG_X86_VSMP)		+= vsmp_64.o


rather than making it depend directly on CONFIG_PARAVIRT.

    J
