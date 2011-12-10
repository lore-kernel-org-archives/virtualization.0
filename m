From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [PATCH 0/11] RFC: PCI using capabilitities
Date: Sat, 10 Dec 2011 23:32:53 +0200
Message-ID: <1323552773.32487.37.camel@lappy>
References: <87pqfzgy6p.fsf@rustcorp.com.au>
	<1323358657.32487.9.camel@lappy> <87d3byfev0.fsf@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <87d3byfev0.fsf@rustcorp.com.au>
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

On Fri, 2011-12-09 at 16:47 +1030, Rusty Russell wrote:
> On Thu, 08 Dec 2011 17:37:37 +0200, Sasha Levin <levinsasha928@gmail.com> wrote:
> > Which leads me to the question: Are MMIO vs MMIO reads/writes not
> > ordered?
> 
> That seems really odd, especially being repeatable.

Happens every single time. Can't be a coincidence.

I even went into paranoia mode and made sure that both IO requests come
from the same vcpu.

Another weird thing I've noticed is that mb() doesn't fix it, while if I
replace the mb() with a printk() it works well.

> BTW, that's an address, not a pfn now.

Fixed :)

-- 

Sasha.
