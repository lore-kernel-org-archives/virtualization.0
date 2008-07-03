From: Jeremy Fitzhardinge <jeremy@goop.org>
Subject: Re: [PATCH] xen: compilation fix for ia64 support.
Date: Thu, 03 Jul 2008 14:51:03 -0700
Message-ID: <486D49C7.5070702__42877.2823572674$1215121999$gmane$org@goop.org>
References: <20080703070952.GB15683%yamahata@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20080703070952.GB15683%yamahata@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Isaku Yamahata <yamahata@valinux.co.jp>
Cc: xen-ia64-devel@lists.xensource.com, xen-devel@lists.xensource.com, linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Isaku Yamahata wrote:
> don't include asm/pvclock-abi.h directly, but asm/xen/pvclock-abi.h
> At this moment linux ia64 won't accept asm/pvclock-abi.h because
> there's no user of it.

Huh?  Is this a ia64 maintainer policy?  Aren't you about to start using it?

>  Instead make it include asm/xen/pvclock-abi.h
> and create asm-x86/xen/pvclock-abi.h which includes asm-x86/pvclock-abi.h.
>   

I'm not very keen on crufting up asm-x86/xen/ for the ia64 code.  
Couldn't you have an asm-ia64/xen/pvclock-abi.h which includes 
<asm-x86/pvclock-abi.h>?

    J
