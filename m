From: "Michael S. Tsirkin" <mst@redhat.com>
Subject: Re: [PATCHv4 2/2] vhost_net: a kernel-level virtio server
Date: Thu, 27 Aug 2009 13:45:18 +0300
Message-ID: <20090827104517.GB8545__19715.3411842466$1251370075$gmane$org@redhat.com>
References: <cover.1250693417.git.mst@redhat.com>
	<20090819150309.GC4236@redhat.com>
	<200908252140.41295.rusty@rustcorp.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <200908252140.41295.rusty@rustcorp.com.au>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Rusty Russell <rusty@rustcorp.com.au>
Cc: kvm@vger.kernel.org, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-mm@kvack.org, hpa@zytor.com, mingo@elte.hu, akpm@linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Aug 25, 2009 at 09:40:40PM +0930, Rusty Russell wrote:
> Also, see other fixes to the lguest launcher since then which might
> be relevant to this code:
> 	lguest: get more serious about wmb() in example Launcher code

Heh, this just gets one step closer to a real wmb.  I just used the
correct code from linux, so I think nothing needs to be done in vhost.
Apropos this change in lguest: why is a compiler barrier sufficient? The
comment says devices are run in separate threads (presumably from
guest?), if so don't you need to tell CPU that there's a barrier as
well?

> 	lguest: clean up length-used value in example launcher

OK, fixing that.

Thanks!

-- 
MST
