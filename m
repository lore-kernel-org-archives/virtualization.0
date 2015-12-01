From: Jason Wang <jasowang@redhat.com>
Subject: Re: [PATCH net-next 3/3] vhost_net: basic polling support
Date: Tue, 1 Dec 2015 13:17:49 +0800
Message-ID: <565D2D7D.4010903__39517.6933300265$1448947113$gmane$org@redhat.com>
References: <1448435489-5949-1-git-send-email-jasowang@redhat.com>
	<1448435489-5949-4-git-send-email-jasowang@redhat.com>
	<20151130124233-mutt-send-email-mst@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20151130124233-mutt-send-email-mst@redhat.com>
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
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org



On 11/30/2015 06:44 PM, Michael S. Tsirkin wrote:
> On Wed, Nov 25, 2015 at 03:11:29PM +0800, Jason Wang wrote:
>> > This patch tries to poll for new added tx buffer or socket receive
>> > queue for a while at the end of tx/rx processing. The maximum time
>> > spent on polling were specified through a new kind of vring ioctl.
>> > 
>> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> One further enhancement would be to actually poll
> the underlying device. This should be reasonably
> straight-forward with macvtap (especially in the
> passthrough mode).
>
>

Yes, it is. I have some patches to do this by replacing
skb_queue_empty() with sk_busy_loop() but for tap. Tests does not show
any improvement but some regression.  Maybe it's better to test macvtap.
