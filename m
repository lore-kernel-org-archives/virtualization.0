From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH v2 1/3] mm: highmem: export kmap_to_page for modules
Date: Tue, 23 Oct 2012 10:25:57 +1030
Message-ID: <87objuhxiq.fsf@rustcorp.com.au>
References: <1350651813-8694-1-git-send-email-will.deacon@arm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1350651813-8694-1-git-send-email-will.deacon@arm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: linux-kernel@vger.kernel.org
Cc: Marc.Zyngier@arm.com, Will Deacon <will.deacon@arm.com>, virtualization@lists.linux-foundation.org, ericvh@gmail.com, levinsasha928@gmail.com, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

Will Deacon <will.deacon@arm.com> writes:

> Some virtio device drivers (9p) need to translate high virtual addresses
> to physical addresses, which are inserted into the virtqueue for
> processing by userspace.
>
> This patch exports the kmap_to_page symbol, so that the affected drivers
> can be compiled as modules.

Thanks Will!

I've applied these, and add cc:stable.  I'll push them to Linus after a
little time in linux-next.

Cheers,
Rusty.
