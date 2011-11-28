From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH] virtio-mmio: Devices parameter parsing
Date: Mon, 28 Nov 2011 11:01:30 +1030
Message-ID: <87zkfht7dp.fsf@rustcorp.com.au>
References: <1321365185-2928-1-git-send-email-pawel.moll@arm.com>
	<87sjlooq3m.fsf@rustcorp.com.au>
	<1321467222.3137.417.camel@hornet.cambridge.arm.com>
	<87vcqe9ml9.fsf@rustcorp.com.au>
	<1321886688.3093.248.camel@hornet.cambridge.arm.com>
	<1321898210.3093.263.camel@hornet.cambridge.arm.com>
	<87fwhhx9is.fsf@rustcorp.com.au>
	<1322071732.3093.491.camel@hornet.cambridge.arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1322071732.3093.491.camel@hornet.cambridge.arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Pawel Moll <pawel.moll@arm.com>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Wed, 23 Nov 2011 18:08:52 +0000, Pawel Moll <pawel.moll@arm.com> wrote:
> On Tue, 2011-11-22 at 00:44 +0000, Rusty Russell wrote: 
> > Or would it be simpler to enhance sscanf() with some weird format option
> > for suffixing?  I haven't looked for similar cases, but I'd suspect a
> > big win in general.
> > 
> > This would be neater than anything else we've got:
> >         if (sscanf(device, "%llu@%llu[KMG]:%u", ...) != 3
> >             && sscanf(device, "%llu@%llu[KMG]:%u:%u", ...) != 4)
> >                 return -EINVAL;
> 
> sscanf was a good hint! Thanks, why haven't I thought of it myself? ;-)
> 
> That's what I came up with:
> 
> static int vm_cmdline_set(const char *device,
>                 const struct kernel_param *kp)
> {
>         struct resource resources[2] = {};
>         char *str;
>         long long int base;
>         int processed, consumed = 0;
>         struct platform_device *pdev;
>         
>         resources[0].flags = IORESOURCE_MEM;
>         resources[1].flags = IORESOURCE_IRQ;
>         
>         resources[0].end = memparse(device, &str) - 1;
>         
>         processed = sscanf(str, "@%lli:%u%n:%d%n", 
>                         &base, &resources[1].start, &consumed,
>                         &vm_cmdline_id, &consumed);
>                         
>         if (processed < 2 || processed > 3 || str[consumed])
>                 return -EINVAL;
>                 
>         resources[0].start = base;
>         resources[0].end += base;
>         resources[1].end = resources[1].start;
> 
> The only bit missing from sscanf() would be some sort of "%m" format,
> which behaved like memparse and also processed unsigned number with "0
> base" (hard to believe but the only "universal" - as in octal, dec and
> hex - format is %i, which is signed). But still, looks quite neat
> already :-)

Yeah, something like %pK for kernel pointers in printk; you need a
suffix so that gcc won't get upset.  The "[KMG]" suffix hack was my
poor suggestion...

> I'll try to have a look at the "late parameters" idea tomorrow. Any
> early warnings?

Off the top of my head, this makes me think of the way initcalls are
ordered.  We could put a parameter parsing initcall at the start of each
initcall level in include/asm-generic/vmlinux.lds.h's INITCALLS macro.

Then we steal four bits from struct kernel_param's flags to indicate the
level of the initcall (-1 == existing ones, otherwise N == before level
N initcalls).

Good luck!
Rusty.
