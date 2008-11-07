From: Peter Zijlstra <peterz@infradead.org>
Subject: Re: [patch 0/4] [RFC] Another proportional weight IO controller
Date: Fri, 07 Nov 2008 11:31:44 +0100
Message-ID: <1226053904.7803.5856.camel__46661.4712997854$1226054012$gmane$org@twins>
References: <20081106153022.215696930@redhat.com>
	<1225986593.7803.4688.camel@twins> <20081106160154.GA7461@redhat.com>
	<1225988173.7803.4723.camel@twins> <20081106163957.GB7461@redhat.com>
	<1225990327.7803.4776.camel@twins> <491321ED.5010103@redhat.com>
	<1225991487.7803.4801.camel@twins>  <20081107004131.GD2373@disturbed>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20081107004131.GD2373@disturbed>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Dave Chinner <david@fromorbit.com>
Cc: menage@google.com, Rik van Riel <riel@redhat.com>, Andrew Morton <akpm@linux-foundation.org>, containers@lists.linux-foundation.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, Hirokazu Takahashi <taka@valinux.co.jp>, Jeff Moyer <jmoyer@redhat.com>, jens.axboe@oracle.com, balbir@linux.vnet.ibm.com, ngupta@google.com, fernando@oss.ntt.co.jp, Vivek Goyal <vgoyal@redhat.com>, Andrea Righi <righi.andrea@gmail.com>
List-Id: virtualization@lists.linuxfoundation.org

On Fri, 2008-11-07 at 11:41 +1100, Dave Chinner wrote:
> On Thu, Nov 06, 2008 at 06:11:27PM +0100, Peter Zijlstra wrote:
> > On Thu, 2008-11-06 at 11:57 -0500, Rik van Riel wrote:
> > > Peter Zijlstra wrote:
> > > 
> > > > The only real issue I can see is with linear volumes, but those are
> > > > stupid anyway - non of the gains but all the risks.
> > > 
> > > Linear volumes may well be the most common ones.
> > > 
> > > People start out with the filesystems at a certain size,
> > > increasing onto a second (new) disk later, when more space
> > > is required.
> > 
> > Are they aware of how risky linear volumes are? I would discourage
> > anyone from using them.
> 
> In what way are they risky?

You loose all your data when one disk dies, so your mtbf decreases with
the number of disks in your linear span.

And you get non of the benefits from having multiple disks, like extra
speed from striping, or redundancy from raid.

Therefore I say that linear volumes are the absolute worst choice.
