From: "Yinghai Lu" <yinghai@kernel.org>
Subject: Re: [PATCH 1/5] cpumask: update irq_desc to use
	cpumask_var_t
Date: Wed, 7 Jan 2009 12:27:46 -0800
Message-ID: <86802c440901071227n2d110757ye1bd12e689502ebc@mail.gmail.com>
References: <20090107195832.265117000@polaris-admin.engr.sgi.com>
	<20090107195832.465094000@polaris-admin.engr.sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <xen-devel-bounces@lists.xensource.com>
In-Reply-To: <20090107195832.465094000@polaris-admin.engr.sgi.com>
Content-Disposition: inline
List-Unsubscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=unsubscribe>
List-Post: <mailto:xen-devel@lists.xensource.com>
List-Help: <mailto:xen-devel-request@lists.xensource.com?subject=help>
List-Subscribe: <http://lists.xensource.com/mailman/listinfo/xen-devel>,
	<mailto:xen-devel-request@lists.xensource.com?subject=subscribe>
Sender: xen-devel-bounces@lists.xensource.com
Errors-To: xen-devel-bounces@lists.xensource.com
To: Mike Travis <travis@sgi.com>
Cc: Jack Steiner <steiner@sgi.com>, Jeremy Fitzhardinge <jeremy@xensource.com>, Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>, Rusty Russell <rusty@rustcorp.com.au>, linux-kernel@vger.kernel.org, Chris Wright <chrisw@sous-sol.org>, virtualization@lists.osdl.org, Ingo Molnar <mingo@redhat.com>, KOSAKI Motohiro <kosaki.motohiro@jp.fujitsu.com>, "H. Peter Anvin" <hpa@zytor.com>, Thomas Gleixner <tglx@linutronix.de>, xen-devel@lists.xensource.com
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Jan 7, 2009 at 11:58 AM, Mike Travis <travis@sgi.com> wrote:
| --- linux-2.6-for-ingo.orig/kernel/irq/numa_migrate.c
| +++ linux-2.6-for-ingo/kernel/irq/numa_migrate.c
| @@ -46,6 +46,7 @@ static void init_copy_one_irq_desc(int i
| 	desc->cpu = cpu;
| 	lockdep_set_class(&desc->lock, &irq_desc_lock_class);
| 	init_copy_kstat_irqs(old_desc, desc, cpu, nr_cpu_ids);
|+	init_copy_desc_masks(old_desc, desc);
| 	arch_init_copy_chip_data(old_desc, desc, cpu);
| }
|
|@@ -76,11 +77,20 @@ static struct irq_desc *__real_move_irq_
| 	node = cpu_to_node(cpu);
| 	desc = kzalloc_node(sizeof(*desc), GFP_ATOMIC, node);
| 	if (!desc) {
|-		printk(KERN_ERR "irq %d: can not get new irq_desc for migration.\n", irq);
|+		printk(KERN_ERR "irq %d: can not get new irq_desc "
|+				"for migration.\n", irq);
| 		/* still use old one */
| 		desc = old_desc;
| 		goto out_unlock;
| 	}
|+	if (!init_alloc_desc_masks(desc, node, false)) {
|+		printk(KERN_ERR "irq %d: can not get new irq_desc cpumask "
|+				"for migration.\n", irq);
|+		/* still use old one */
|+		kfree(desc);
|+		desc = old_desc;
|+		goto out_unlock;
|+	}
| 	init_copy_one_irq_desc(irq, old_desc, desc, cpu);

desc new mask_var (allocated) aka the pointer is overwritten here...
you may need to calling move init_alloc_desc_masks() into
init_copy_one_irq_desc()

| 	irq_desc_ptrs[irq] = desc;

YH
