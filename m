From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net 1/2] vhost: use mutex_lock_nested() in
	vhost_dev_lock_vqs()
Date: Wed, 24 Jan 2018 16:55:55 -0500 (EST)
Message-ID: <20180124.165555.720252378850390746.davem@davemloft.net>
References: <1516699646-7321-1-git-send-email-jasowang@redhat.com>
	<20180124.163830.2180124252515802160.davem@davemloft.net>
	<20180124234511-mutt-send-email-mst@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <20180124234511-mutt-send-email-mst@kernel.org>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: mst@redhat.com
Cc: netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org
List-Id: virtualization@lists.linuxfoundation.org

From: "Michael S. Tsirkin" <mst@redhat.com>
Date: Wed, 24 Jan 2018 23:46:19 +0200

> On Wed, Jan 24, 2018 at 04:38:30PM -0500, David Miller wrote:
>> From: Jason Wang <jasowang@redhat.com>
>> Date: Tue, 23 Jan 2018 17:27:25 +0800
>> 
>> > We used to call mutex_lock() in vhost_dev_lock_vqs() which tries to
>> > hold mutexes of all virtqueues. This may confuse lockdep to report a
>> > possible deadlock because of trying to hold locks belong to same
>> > class. Switch to use mutex_lock_nested() to avoid false positive.
>> > 
>> > Fixes: 6b1e6cc7855b0 ("vhost: new device IOTLB API")
>> > Reported-by: syzbot+dbb7c1161485e61b0241@syzkaller.appspotmail.com
>> > Signed-off-by: Jason Wang <jasowang@redhat.com>
>> 
>> Michael, I see you ACK'd this, meaning that you're OK with these two
>> fixes going via my net tree?
>> 
>> Thanks.
> 
> Yes - this seems to be what Jason wanted (judging by the net
> tag in the subject) and I'm fine with it.
> Thanks a lot.

Great, not a problem, done.
