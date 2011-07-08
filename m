From: Konrad Rzeszutek Wilk <konrad.wilk@oracle.com>
Subject: Re: [Xen-devel] Re: [PATCH] Modpost section mismatch fix (for
	platform-pci-unplug.c)
Date: Fri, 8 Jul 2011 16:26:28 -0400
Message-ID: <20110708202628.GA25998__27569.2486357459$1310156883$gmane$org@dumpdata.com>
References: <20110704221646.GB4490@Xye> <20110705141323.GG2972@dumpdata.com>
	<20110705142731.GA4463@Xye> <20110705144846.GA13548@dumpdata.com>
	<20110705213243.GA3647@dumpdata.com> <20110707154648.GA4394@Xye>
	<20110707162454.GA8164@dumpdata.com> <20110707194851.GB4394@Xye>
	<20110707200949.GA25216@dumpdata.com> <20110707210429.GD4394@Xye>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20110707210429.GD4394@Xye>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Raghavendra D Prabhu <rprabhu@wnohang.net>, Stefano Stabellini <stefano.stabellini@eu.citrix.com>
Cc: xen-devel@lists.xensource.com, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, jeremy.fitzhardinge@citrix.com, Ian Campbell <ijc@hellion.org.uk>
List-Id: virtualization@lists.linuxfoundation.org

> >>Also,
> >>I had sent another change (oneline) for the file
> >>arch/x86/xen/platform-pci-unplug.c for check_platform_magic, looks like that has not gone into
> >>the pull request for Linus.
> >
> >Oh, I didn't see it. Did you CC me on it? Can you bounce it to me please?
> >
> =========================
>  diff --git a/arch/x86/xen/platform-pci-unplug.c b/arch/x86/xen/platform-pci-unplug.c
>  index 25c52f9..ffcf261 100644
>  --- a/arch/x86/xen/platform-pci-unplug.c
>  +++ b/arch/x86/xen/platform-pci-unplug.c
>  @@ -35,7 +35,7 @@ EXPORT_SYMBOL_GPL(xen_platform_pci_unplug);
>   #ifdef CONFIG_XEN_PVHVM
>   static int xen_emul_unplug;
> 
>  -static int __init check_platform_magic(void)
>  +static int check_platform_magic(void)
>   {
>          short magic;
>          char protocol;
>  --
> 

Yeah, that would cause an issue during suspend/resume by PVonHVM. How
we didn't trip over this I've no idea..

Anyhow, can you provide me with your Signed-off-by please and I will queue
it right up.

Stefano, you OK with this patch?
