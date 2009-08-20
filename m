From: Simon Horman <horms@verge.net.au>
Subject: Re: [PATCH] dm-ioband-v1.12.3: I/O bandwidth controller
Date: Thu, 20 Aug 2009 12:37:41 +1000
Message-ID: <20090820023740.GA12528__36476.8534237102$1250735920$gmane$org@verge.net.au>
References: <20090731.130333.104034609.ryov@valinux.co.jp>
	<20090807.103640.104065157.ryov@valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20090807.103640.104065157.ryov@valinux.co.jp>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Ryo Tsuruta <ryov@valinux.co.jp>
Cc: xen-devel@lists.xensource.com, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, dm-devel@redhat.com, agk@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

On Fri, Aug 07, 2009 at 10:36:40AM +0900, Ryo Tsuruta wrote:
> Hi Alasdair,
> 
> Ryo Tsuruta <ryov@valinux.co.jp> wrote:
> > Hi Alasdair,
> > 
> > This is dm-ioband v1.12.3 release that is a minor update to avoid
> > sparse warnings other than related to the event tracing. (I used
> > sparse-2009-07-29.)
> > 
> > This patch can be applied to the current dm-devel tree and 2.6.31-rc4,
> > so could you please replace dm-add-ioband.patch in your tree with this?
> > And I would appreciate it if you would let me know your thoughts about
> > merging dm-ioband to upstream.
> 
> The dm-ioband patch in the dm-devel tree is still older. Could you
> please update it with the new patch? And could you please let me know
> your thoughts about dm-ioband?

Hi Alasdiar,

I'm wondering if you see any problems with merging dm-ioband at this time.
I'm eager to address any such concerns.
