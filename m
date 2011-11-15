From: Sasha Levin <levinsasha928@gmail.com>
Subject: Re: [RFC] kvm tools: Implement multiple VQ for virtio-net
Date: Tue, 15 Nov 2011 17:30:29 +0200
Message-ID: <1321371029.3178.9.camel__17740.890212781$1321371162$gmane$org@lappy>
References: <1321049521-26376-1-git-send-email-levinsasha928@gmail.com>
	<20111113102428.GD15322@redhat.com> <1321196430.2425.2.camel@sasha>
	<4EC07729.3050303@gmail.com> <1321265740.2425.7.camel@sasha>
	<OFDA747DDD.8D1C8FD8-ON65257949.001837DA-65257949.0019D25F@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <OFDA747DDD.8D1C8FD8-ON65257949.001837DA-65257949.0019D25F@in.ibm.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Krishna Kumar2 <krkumar2@in.ibm.com>
Cc: penberg@kernel.org, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, Asias He <asias.hejun@gmail.com>, virtualization@lists.linux-foundation.org, gorcunov@gmail.com, netdev@vger.kernel.org, mingo@elte.hu
List-Id: virtualization@lists.linuxfoundation.org

On Tue, 2011-11-15 at 10:14 +0530, Krishna Kumar2 wrote:
> Sasha Levin <levinsasha928@gmail.com> wrote on 11/14/2011 03:45:40 PM:
> 
> > > Why both the bandwidth and latency performance are dropping so
> > > dramatically with multiple VQ?
> >
> > It looks like theres no hash sync between host and guest, which makes
> > the RX VQ change for every packet. This is my guess.
> 
> Yes, I confirmed this happens for macvtap. I am
> using ixgbe - it calls skb_record_rx_queue when
> a skb is allocated, but sets rxhash when a packet
> arrives. Macvtap is relying on record_rx_queue
> first ahead of rxhash (as part of my patch making
> macvtap multiqueue), hence different skbs result
> in macvtap selecting different vq's.

I'm seeing this behavior in non-macvtep related setup as well (simple
tap <-> virtio-net).

-- 

Sasha.
