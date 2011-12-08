From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [PATCH 0/11] RFC: PCI using capabilitities
Date: Thu, 08 Dec 2011 12:32:39 +0200
Message-ID: <1323340359.3904.20.camel@lappy>
References: <87pqfzgy6p.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87pqfzgy6p.fsf@rustcorp.com.au>
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
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Avi Kivity <avi@redhat.com>, kvm@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

Rusty, I can't find the actual patches, could you verify that they were
indeed sent?

On Thu, 2011-12-08 at 20:52 +1030, Rusty Russell wrote:
> Here's the patch series I ended up with.  I haven't coded up the QEMU
> side yet, so no idea if the new driver works.
> 
> Questions:
> (1) Do we win from separating ISR, NOTIFY and COMMON?

By separating ISR, NOTIFY and COMMON we can place ISR and NOTIFY in PIO
and COMMON in MMIO. This gives us the benefit of having the small data
path use fast PIO, while big config path can use MMIO.

> (2) I used a "u8 bar"; should I use a bir and pack it instead?  BIR
>     seems a little obscure (noone else in the kernel source seems to
>     refer to it).

BIR is a concept from the PCI spec, but it was only used for MSI-X. I
don't expect to see it all around the kernel source.

-- 

Sasha.
