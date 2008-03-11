From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: 2.6.25-rc5-mm1 (paravirt/vsmp/no PCI)
Date: Tue, 11 Mar 2008 11:18:44 -0700
Message-ID: <47D6CD04.8060303@goop.org>
References: <20080311011434.ad8c8d7d.akpm@linux-foundation.org> <20080311100955.ca113f90.randy.dunlap@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755039AbYCKSUE@vger.kernel.org>
In-Reply-To: <20080311100955.ca113f90.randy.dunlap@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Randy Dunlap <randy.dunlap@oracle.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, virtualization@lists.osdl.org, linux-kernel@vger.kernel.org, Glauber de Oliveira Costa <glommer@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

Randy Dunlap wrote:

Added Cc:

> On Tue, 11 Mar 2008 01:14:34 -0700 Andrew Morton wrote:
>
>   
>> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.25-rc5/2.6.25-rc5-mm1/
>>     
>
> randconfig (x86_64) with
> PCI=n
> PARAVIRT=y
> VSMP=n
>
> ends with
>
> arch/x86/kernel/built-in.o: In function `is_vsmp_box':
> (.text+0x1178d): undefined reference to `early_pci_allowed'
> arch/x86/kernel/built-in.o: In function `is_vsmp_box':
> (.text+0x117a9): undefined reference to `read_pci_config'
> arch/x86/kernel/built-in.o: In function `vsmp_init':
> (.init.text+0x4fcc): undefined reference to `early_pci_allowed'
> arch/x86/kernel/built-in.o: In function `vsmp_init':
> (.init.text+0x501a): undefined reference to `read_pci_config'
> make[1]: *** [.tmp_vmlinux1] Error 1
>
> config attached.

    J
