From: Glauber Costa <glommer@redhat.com>
Subject: Re: [Qemu-devel] [PATCHv3 07/13] qemu: minimal MSI/MSI-X
	implementation for PC
Date: Tue, 9 Jun 2009 14:33:33 -0300
Message-ID: <20090609173333.GB19375__17033.0997011208$1244586444$gmane$org@poweredge.glommer>
References: <cover.1244192535.git.mst@redhat.com>
	<20090605102347.GH26770@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090605102347.GH26770@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Carsten Otte <cotte@de.ibm.com>, kvm@vger.kernel.org, qemu-devel@nongnu.org, virtualization@lists.linux-foundation.org, Blue Swirl <blauwirbel@gmail.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Paul Brook <paul@codesourcery.com>, Anthony Liguori <anthony@codemonkey.ws>, Avi Kivity <avi@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

>      env = cpu_single_env;
>      if (!env)
> @@ -727,7 +762,6 @@ static void apic_mem_writel(void *opaque, target_phys_addr_t addr, uint32_t val)
>      printf("APIC write: %08x = %08x\n", (uint32_t)addr, val);
>  #endif
>  
> -    index = (addr >> 4) & 0xff;
>      switch(index) {
>      case 0x02:
>          s->id = (val >> 24);
> @@ -911,6 +945,7 @@ int apic_init(CPUState *env)
>      s->cpu_env = env;
>  
>      apic_reset(s);
> +    msix_supported = 1;
>  
>      /* XXX: mapping more APICs at the same memory location */
>      if (apic_io_memory == 0) {
> @@ -918,7 +953,8 @@ int apic_init(CPUState *env)
>             on the global memory bus. */
>          apic_io_memory = cpu_register_io_memory(0, apic_mem_read,
>                                                  apic_mem_write, NULL);
> -        cpu_register_physical_memory(s->apicbase & ~0xfff, 0x1000,
> +        /* XXX: what if the base changes? */
> +        cpu_register_physical_memory(MSI_ADDR_BASE, MSI_ADDR_SIZE,
>                                       apic_io_memory);
+1 

I think you have a point here. Your patch is in no way worse than what we had,
but we're currently not handling correctly the case of base address changing.
Guess it is not common in normal apic usage for OSes...
