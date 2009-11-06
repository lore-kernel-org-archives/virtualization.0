From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCHv7 3/3] vhost_net: a kernel-level virtio server
Date: Fri, 6 Nov 2009 15:31:20 +1030
Message-ID: <200911061531.20299.rusty__4851.01192393831$1257483723$gmane$org@rustcorp.com.au>
References: <cover.1257267892.git.mst@redhat.com>
	<20091104115729.GD8398@redhat.com>
	<20091104172542.GC6736@linux.vnet.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20091104172542.GC6736@linux.vnet.ibm.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: paulmck@linux.vnet.ibm.com
Cc: Eric Dumazet <eric.dumazet@gmail.com>, kvm@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 5 Nov 2009 03:55:42 am Paul E. McKenney wrote:
> On Wed, Nov 04, 2009 at 01:57:29PM +0200, Michael S. Tsirkin wrote:
> > Can you ack this usage please?
> 
> I thought I had done so in my paragraph above, but if you would like
> something a bit more formal...

<snip verbose super-ack with qualifications>

That's great guys.  And yes, this is a kind of read-copy-update.  And no,
there's nothing wrong with it.

But it's still nasty to use half an API.  If it were a few places I would
have open-coded it with a comment, or wrapped it.  As it is, I don't think
that would be a win.

Cheers,
Rusty.
