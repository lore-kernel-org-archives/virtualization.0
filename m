From: Isaku Yamahata <yamahata@valinux.co.jp>
Subject: Re: [kvm-ia64-devel] [PATCH 13/28] ia64/xen: introduce xenhypercall
	routines necessary for domU.
Date: Tue, 26 Feb 2008 10:44:31 +0900
Message-ID: <20080226014431.GE29257%yamahata__25699.1967130036$1203990413$gmane$org@valinux.co.jp>
References: <20080222035457.GB2406%yamahata@valinux.co.jp>
	<10EA09EFD8728347A513008B6B0DA77A02CFD330@pdsmsx411.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <10EA09EFD8728347A513008B6B0DA77A02CFD330@pdsmsx411.ccr.corp.intel.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Dong, Eddie" <eddie.dong@intel.com>
Cc: xen-ia64-devel@lists.xensource.com, linux-ia64@vger.kernel.org, kvm-ia64-devel@lists.sourceforge.net, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Feb 26, 2008 at 02:36:51AM +0800, Dong, Eddie wrote:
> 
> > IA64 pv_ops frame work doesn't exist yet so that xen code does
> > in order to boot on both native and xen for now.
> > I expect those check will be eliminated during developing ia64 pv_ops.
> 
> Qing He & I am working on the pv_ops framework, hopefully we can get
> a draft soon :)

Great!
What I am aware of at this moment is,
(some of the following can be covered by machine vector, though.)

- early setup before start_kernel()
  Currently early_xen_setup() is directly called.
  Eventually extending ia64 boot protocol would be necessary, though.

- Initialization hooks
  struct pv_init_ops?
        void (*arch_setup_early)(void)
        void (*banner);
        void (*pre_pasing_init)(void);
        void (*post_pasing_init)(void);
        void (*post_allocator_init)(void);

- irq hooks
  struct pv_irq_ops
  - init_IRQ(), irq_init()
  - registering chip type
    register_intr()
  - assign_irq_vector()
  - free_irq_vector()
  - register_percpu_irq()  
  - send_ipi()
  - resend_irq()

- IOSAPIC hooks
  struct pv_iosapic_ops
  - iosapic_init()
  - iosapic_read()
  - iosapic_write()

-- 
yamahata
