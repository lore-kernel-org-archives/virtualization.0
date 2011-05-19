From: Rusty Russell <rusty@rustcorp.com.au>
Subject: Re: [PATCH RFC] virtio_net: fix patch: virtio_net: limit xmit polling
Date: Thu, 19 May 2011 17:00:17 +0930
Message-ID: <8739kb5era.fsf__34921.4409514845$1305867145$gmane$org@rustcorp.com.au>
References: <20110518220125.GA26835@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20110518220125.GA26835@redhat.com>
List-Unsubscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linux-foundation.org/pipermail/virtualization>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linux-foundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: habanero@linux.vnet.ibm.com, Shirley Ma <mashirle@us.ibm.com>, Krishna Kumar2 <krkumar2@in.ibm.com>, kvm@vger.kernel.org, steved@us
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, "Michael S. Tsirkin" <mst@redhat.com>
List-Id: virtualization@lists.linuxfoundation.org

On Thu, 19 May 2011 01:01:25 +0300, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> The patch  virtio_net: limit xmit polling
> got the logic reversed: it polled while we had
> capacity not while ring was empty.
> 
> Fix it up and clean up a bit by using a for loop.
> 
> Signed-off-by: Michael S. Tsirkin <mst@redhat.com>
> ---
> 
> OK, turns out that patch was borken. Here's
> a fix that survived stress test on my box.
> Pushed on my branch, I'll send a rebased series
> with Rusty's comments addressed ASAP.

Normally you would have missed the merge window by now, but I'd really
like this stuff in, so I'm holding it open for this.  I want these patches
in linux-next for at least a few days before I push them.

If you think we're not close enough, please tell me and I'll push
the rest of the virtio patches to Linus now.  

Thanks,
Rusty.
