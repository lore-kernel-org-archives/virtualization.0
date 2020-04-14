From: Krzysztof Kozlowski <krzk@kernel.org>
Subject: Re: Build regressions/improvements in v5.7-rc1
Date: Tue, 14 Apr 2020 13:19:03 +0200
Message-ID: <20200414111903.GA1895@kozik-lap>
References: <20200413093100.24470-1-geert@linux-m68k.org>
 <alpine.DEB.2.21.2004131232220.32713@ramsan.of.borg>
 <877dyijrh7.fsf@mpe.ellerman.id.au>
 <20200414110627.GA1373@kozik-lap>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20200414110627.GA1373@kozik-lap>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
 <mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Errors-To: virtualization-bounces@lists.linux-foundation.org
Sender: "Virtualization" <virtualization-bounces@lists.linux-foundation.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org, Geert Uytterhoeven <geert@linux-m68k.org>, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Apr 14, 2020 at 01:06:27PM +0200, Krzysztof Kozlowski wrote:
> On Tue, Apr 14, 2020 at 08:23:32PM +1000, Michael Ellerman wrote:
 > >>  + /kisskb/src/arch/powerpc/include/asm/nohash/64/pgtable-4k.h: error: expected ')' before '!=' token:  => 58:40
> > >>  + /kisskb/src/arch/powerpc/include/asm/nohash/64/pgtable-4k.h: error: expected ')' before '==' token:  => 57:37
> > >>  + /kisskb/src/arch/powerpc/include/asm/nohash/64/pgtable-4k.h: error: expected identifier or '(' before '!' token:  => 56:25
> > >>  + /kisskb/src/arch/powerpc/include/asm/nohash/64/pgtable.h: error: expected ')' before '!=' token:  => 163:40
> > >>  + /kisskb/src/arch/powerpc/include/asm/nohash/64/pgtable.h: error: expected ')' before '==' token:  => 333:50
> > >>  + /kisskb/src/arch/powerpc/include/asm/nohash/64/pgtable.h: error: expected ')' before '^' token:  => 333:36
> > >>  + /kisskb/src/arch/powerpc/include/asm/nohash/64/pgtable.h: error: expected identifier or '(' before '!' token:  => 146:27, 144:24, 160:25, 161:24, 143:25
> > >>  + /kisskb/src/arch/powerpc/include/asm/nohash/64/pgtable.h: error: expected identifier or '(' before 'struct':  => 77:21
> > >>  + /kisskb/src/arch/powerpc/include/asm/nohash/pgtable.h: error: redefinition of 'pgd_huge':  => 291:19
> > >>  + /kisskb/src/arch/powerpc/include/asm/nohash/pte-book3e.h: error: redefinition of 'pte_mkprivileged':  => 108:26
> > >>  + /kisskb/src/arch/powerpc/include/asm/nohash/pte-book3e.h: error: redefinition of 'pte_mkuser':  => 115:20
> > >>  + /kisskb/src/arch/powerpc/kvm/book3s_64_vio_hv.c: error: 'struct kvm_arch' has no member named 'spapr_tce_tables':  => 68:46, 68:2
> > >
> > > ppc64_book3e_allmodconfig
> > 
> > Caused by:
> > 
> > e93a1695d7fb ("iommu: Enable compile testing for some of drivers")
> > 
> > Which did:
> > 
> >  config SPAPR_TCE_IOMMU
> >  	bool "sPAPR TCE IOMMU Support"
> > -	depends on PPC_POWERNV || PPC_PSERIES
> > +	depends on PPC_POWERNV || PPC_PSERIES || (PPC && COMPILE_TEST)
> > 
> > 
> > Which is just ... not right, the dependencies on the correct platform
> > are important, otherwise the build breaks.
> 
> The SPAPR_TCE_IOMMU should compile fine.  The actual trouble here is
> that KVM_BOOK3S_64 selects SPAPR_TCE_IOMMU which is a user-visible
> symbol.  This is generally discouraged because of exactly this error -
> select ignores any dependencies.
> 
> I can revert the COMPILE_TEST for SPAPR_TCE_IOMMU or change
> select->depends in KVM_BOOK3S_64.  I think the latter is the proper
> change here.

Eh, not really, it looks more complex because there are more
dependencies (the book3s_64_vio_hv is pulled by KVM Makefile if
SPAPR_TCE_IOMMU is set).

I guess the revert of this part makes most sense.

Best regards,
Krzysztof
