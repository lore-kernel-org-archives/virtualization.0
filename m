From: Greg KH <gregkh@linuxfoundation.org>
Subject: Re: [3.16 stable PATCH 0/2] virtio-rng: two backports to fix stuck
Date: Tue, 18 Nov 2014 17:20:22 -0800
Message-ID: <20141119012022.GB22731__6873.19623907587$1416360037$gmane$org@kroah.com>
References: <1412981509-30025-1-git-send-email-akong@redhat.com>
	<20141104043227.GA13409@air.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
Content-Disposition: inline
In-Reply-To: <20141104043227.GA13409@air.redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: Amos Kong <akong@redhat.com>
Cc: amit.shah@redhat.com, linux-kernel@vger.kernel.org, stable@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

On Tue, Nov 04, 2014 at 12:32:27PM +0800, Amos Kong wrote:
> On Sat, Oct 11, 2014 at 06:51:47AM +0800, Amos Kong wrote:
> > I received two mails about faile to apply patches to 3.16-stable tree:
> > 
> > FAILED: patch "[PATCH] virtio-rng: skip reading when we start to remove the device" failed to apply to 3.16-stable tree
> > FAILED: patch "[PATCH] virtio-rng: fix stuck of hot-unplugging busy device" failed to apply to 3.16-stable tree
> > 
> > Amit already backported two patches for 3.16-stable, then cherry-pick
> > of my two patches works.
> > 
> > Thanks.
> 
> Ping Greg, thanks.

Why me?  3.16-stable is end-of-life, I'm no longer maintaining it, so
what can I do here with these patches?

confused,

greg k-h
