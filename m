From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [PATCH 0/11] RFC: PCI using capabilitities
Date: Sun, 11 Dec 2011 14:53:12 +0200
Message-ID: <1323607992.4063.9.camel__45443.5486499735$1323608033$gmane$org@lappy>
References: <87pqfzgy6p.fsf@rustcorp.com.au>
	<1323358657.32487.9.camel@lappy> <20111211124703.GE11504@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20111211124703.GE11504@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: "Michael S. Tsirkin" <mst@redhat.com>
Cc: Avi Kivity <avi@redhat.com>, kvm@vger.kernel.org, virtualization <virtualization@lists.linux-foundation.org>
List-Id: virtualization@lists.linuxfoundation.org

On Sun, 2011-12-11 at 14:47 +0200, Michael S. Tsirkin wrote:
> First, I'd like to answer your questions from the PCI side.
> Look for PCI rules in the PCI spec.
> You will notices that a write is required to be able to
> pass a read request. It might also pass read completion.
> A read request will not pass a write request.
> There's more or less no ordering between different types of transactions
> (memory versus io/configuration).
> 
> That's wrt to the question you asked.
> 
> But this is not your setup: you have a single vcpu so
> you will not initiate a write (select vq) until you get
> a read completion.
> 
> So what you are really describing is this setup: guest reads a value,
> gets the response, then writes out another one, and kvm tool reports the
> write before the read. 

No, it's exactly the opposite. Guest writes a value first and then reads
one (writes queue_select and reads queue_address) and kvm tool reporting
the read before the write.

I must add here that the kvm tool doesn't do anything fancy with simple
IO/MMIO. Theres no thread games or anything similar there. The vcpu
thread is doing all the IO/MMIO work.

-- 

Sasha.
