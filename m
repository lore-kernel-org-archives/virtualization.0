From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv5 3/3] vhost_net: a kernel-level virtio server
Date: Thu, 17 Sep 2009 06:57:17 +0300
Message-ID: <20090917035717.GB3088__10211.9811730974$1253160050$gmane$org@redhat.com>
References: <4AAF8A03.5020806@redhat.com> <4AAF909F.9080306@gmail.com>
	<4AAF95D1.1080600@redhat.com> <4AAF9BAF.3030109@gmail.com>
	<4AAFACB5.9050808@redhat.com> <4AAFF437.7060100@gmail.com>
	<4AB0A070.1050400@redhat.com> <4AB0CFA5.6040104@gmail.com>
	<4AB0E2A2.3080409@redhat.com> <4AB0F1EF.5050102@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4AB0F1EF.5050102@gmail.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Gregory Haskins <gregory.haskins@gmail.com>
Cc: kvm@vger.kernel.org, "Ira W. Snyder" <iws@ovro.caltech.edu>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, Avi Kivity <avi@redhat.com>, hpa@zytor.com, mingo@elte.hu, alacrityvm-devel@lists.sourceforge.net, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Sep 16, 2009 at 10:10:55AM -0400, Gregory Haskins wrote:
> > There is no role reversal.
> 
> So if I have virtio-blk driver running on the x86 and vhost-blk device
> running on the ppc board, I can use the ppc board as a block-device.
> What if I really wanted to go the other way?

It seems ppc is the only one that can initiate DMA to an arbitrary
address, so you can't do this really, or you can by tunneling each
request back to ppc, or doing an extra data copy, but it's unlikely to
work well.

The limitation comes from hardware, not from the API we use.
