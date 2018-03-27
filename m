From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net V2] vhost: correctly remove wait queue during poll
	failure
Date: Tue, 27 Mar 2018 13:04:29 -0400 (EDT)
Message-ID: <20180327.130429.1060831999612495885.davem@davemloft.net>
References: <1522155052-13347-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1522155052-13347-1-git-send-email-jasowang@redhat.com>
List-Unsubscribe: <https://lists.linuxfoundation.org/mailman/options/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=unsubscribe>
List-Archive: <http://lists.linuxfoundation.org/pipermail/virtualization/>
List-Post: <mailto:virtualization@lists.linux-foundation.org>
List-Help: <mailto:virtualization-request@lists.linux-foundation.org?subject=help>
List-Subscribe: <https://lists.linuxfoundation.org/mailman/listinfo/virtualization>,
	<mailto:virtualization-request@lists.linux-foundation.org?subject=subscribe>
Sender: virtualization-bounces@lists.linux-foundation.org
Errors-To: virtualization-bounces@lists.linux-foundation.org
To: jasowang@redhat.com
Cc: kvm@vger.kernel.org, mst@redhat.com, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, virtualization@lists.linux-foundation.org, darren.kenny@oracle.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Tue, 27 Mar 2018 20:50:52 +0800

> We tried to remove vq poll from wait queue, but do not check whether
> or not it was in a list before. This will lead double free. Fixing
> this by switching to use vhost_poll_stop() which zeros poll->wqh after
> removing poll from waitqueue to make sure it won't be freed twice.
> 
> Cc: Darren Kenny <darren.kenny@oracle.com>
> Reported-by: syzbot+c0272972b01b872e604a@syzkaller.appspotmail.com
> Fixes: 2b8b328b61c79 ("vhost_net: handle polling errors when setting backend")
> Signed-off-by: Jason Wang <jasowang@redhat.com>
> ---
> Changes from V1:
> - tweak the commit log for to match the code

Applied and queued up for -stable, thank you.
