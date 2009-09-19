From: Avi Kivity <avi@redhat.com>
Subject: Re: Paravirtualization on VMware's Platform [VMI].
Date: Sat, 19 Sep 2009 10:43:40 +0300
Message-ID: <4AB48BAC.1000409@redhat.com>
References: <1253233028.19731.63.camel@ank32.eng.vmware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner+glk-linux-kernel-3=40m.gmane.org-S1755530AbZISHrG@vger.kernel.org>
In-Reply-To: <1253233028.19731.63.camel@ank32.eng.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
To: akataria@vmware.com
Cc: Ingo Molnar <mingo@elte.hu>, Thomas Gleixner <tglx@linutronix.de>, "H. Peter Anvin" <hpa@zytor.com>, the arch/x86 maintainers <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org
List-Id: virtualization@lists.linuxfoundation.org

On 09/18/2009 03:17 AM, Alok Kataria wrote:
> Hi,
>
> We ran a few experiments to compare performance of VMware's
> paravirtualization technique (VMI) and hardware MMU technologies (HWMMU)
> on VMware's hypervisor.
>
> To give some background, VMI is VMware's paravirtualization
> specification which tries to optimize CPU and MMU operations of the
> guest operating system. For more information take a look at this
> http://www.vmware.com/interfaces/paravirtualization.html
>
> In most of the benchmarks, EPT/NPT (hwmmu) technologies are at par or
> provide better performance compared to VMI.
> The experiments included comparing performance across various micro and
> real world like benchmarks.
>    

We've reached a similar conclusion for kvm pvmmu vs ept/npt.

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.
