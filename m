From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] vhost_net: stop device during reset owner
Date: Mon, 29 Jan 2018 12:35:54 -0500 (EST)
Message-ID: <20180129.123554.366362754710512867.davem__2507.65864407203$1517257181$gmane$org@davemloft.net>
References: <1516889032-23510-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1516889032-23510-1-git-send-email-jasowang@redhat.com>
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
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Thu, 25 Jan 2018 22:03:52 +0800

> We don't stop device before reset owner, this means we could try to
> serve any virtqueue kick before reset dev->worker. This will result a
> warn since the work was pending at llist during owner resetting. Fix
> this by stopping device during owner reset.
> 
> Reported-by: syzbot+eb17c6162478cc50632c@syzkaller.appspotmail.com
> Fixes: 3a4d5c94e9593 ("vhost_net: a kernel-level virtio server")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied and queued up for -stable.
