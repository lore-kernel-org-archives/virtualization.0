From: Pawel Moll <pawel.moll@arm.com>
Subject: Re: [PATCH] virtio-mmio: Devices parameter parsing
Date: Wed, 23 Nov 2011 18:08:52 +0000
Message-ID: <1322071732.3093.491.camel@hornet.cambridge.arm.com>
References: <1321365185-2928-1-git-send-email-pawel.moll@arm.com>
	<87sjlooq3m.fsf@rustcorp.com.au>
	<1321467222.3137.417.camel@hornet.cambridge.arm.com>
	<87vcqe9ml9.fsf@rustcorp.com.au>
	<1321886688.3093.248.camel@hornet.cambridge.arm.com>
	<1321898210.3093.263.camel@hornet.cambridge.arm.com>
	<87fwhhx9is.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87fwhhx9is.fsf@rustcorp.com.au>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>, "virtualization@lists.linux-foundation.org" <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2011-11-22 at 00:53 +0000, Rusty Russell wrote:
> > Any ideas?
> Perhaps not today.  So, we will need a linked list of devices and
> resources.  Yeah, that means allocating, which means YA
> slab_is_available()/alloc_bootmem() hack.

Hm. It doesn't sound like a good deal, really... Loads of tricks to get
data I need quite late in the boot process...

> Think of yourself as a pioneer...

I had a vague idea of "late parameters" last night, which would be
parsed once whole machinery is up and running. Will look around and try
to propose something.

On Tue, 2011-11-22 at 00:44 +0000, Rusty Russell wrote: 
> Or would it be simpler to enhance sscanf() with some weird format option
> for suffixing?  I haven't looked for similar cases, but I'd suspect a
> big win in general.
> 
> This would be neater than anything else we've got:
>         if (sscanf(device, "%llu@%llu[KMG]:%u", ...) != 3
>             && sscanf(device, "%llu@%llu[KMG]:%u:%u", ...) != 4)
>                 return -EINVAL;

sscanf was a good hint! Thanks, why haven't I thought of it myself? ;-)

That's what I came up with:

static int vm_cmdline_set(const char *device,
                const struct kernel_param *kp)
{
        struct resource resources[2] = {};
        char *str;
        long long int base;
        int processed, consumed = 0;
        struct platform_device *pdev;
        
        resources[0].flags = IORESOURCE_MEM;
        resources[1].flags = IORESOURCE_IRQ;
        
        resources[0].end = memparse(device, &str) - 1;
        
        processed = sscanf(str, "@%lli:%u%n:%d%n", 
                        &base, &resources[1].start, &consumed,
                        &vm_cmdline_id, &consumed);
                        
        if (processed < 2 || processed > 3 || str[consumed])
                return -EINVAL;
                
        resources[0].start = base;
        resources[0].end += base;
        resources[1].end = resources[1].start;

The only bit missing from sscanf() would be some sort of "%m" format,
which behaved like memparse and also processed unsigned number with "0
base" (hard to believe but the only "universal" - as in octal, dec and
hex - format is %i, which is signed). But still, looks quite neat
already :-)

I'll try to have a look at the "late parameters" idea tomorrow. Any
early warnings?

Cheers!

Pawel
