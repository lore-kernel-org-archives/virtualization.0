From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv8 0/3] vhost: a kernel-level virtio server
Date: Wed, 4 Nov 2009 21:19:26 +0200
Message-ID: <20091104191926.GC772__38804.1041362614$1257362605$gmane$org@redhat.com>
References: <20091104155234.GA32673@redhat.com> <4AF1A587.8000509@gmail.com>
	<20091104162339.GA311@redhat.com> <4AF1D2DE.10705@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <4AF1D2DE.10705@gmail.com>
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
Cc: Eric Dumazet <eric.dumazet@gmail.com>, kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, s.hetze@linux-ag.com, hpa@zytor.com, Daniel Walker <dwalker@fifo99.com>, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Wed, Nov 04, 2009 at 02:15:42PM -0500, Gregory Haskins wrote:
> Michael S. Tsirkin wrote:
> > On Wed, Nov 04, 2009 at 11:02:15AM -0500, Gregory Haskins wrote:
> >> Michael S. Tsirkin wrote:
> >>> Ok, I think I've addressed all comments so far here.
> >>> Rusty, I'd like this to go into linux-next, through your tree, and
> >>> hopefully 2.6.33.  What do you think?
> >> I think the benchmark data is a prerequisite for merge consideration, IMO.
> > 
> > Shirley Ma was kind enough to send me some measurement results showing
> > how kernel level acceleration helps speed up you can find them here:
> > http://www.linux-kvm.org/page/VhostNet
> 
> Thanks for the pointers.  I will roll your latest v8 code into our test
> matrix.  What kernel/qemu trees do they apply to?
> 
> -Greg
> 


kernel 2.6.32-rc6, qemu-kvm 47e465f031fc43c53ea8f08fa55cc3482c6435c8.
You can also use my development git trees if you like.

kernel:
git://git.kernel.org/pub/scm/linux/kernel/git/mst/vhost.git vhost
userspace:
git://git.kernel.org/pub/scm/linux/kernel/git/mst/qemu-kvm.git vhost

Please note I rebase especially userspace tree now and when.

-- 
MST
