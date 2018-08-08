From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] vhost: reset metadata cache when initializing new
	IOTLB
Date: Wed, 08 Aug 2018 09:45:21 -0700 (PDT)
Message-ID: <20180808.094521.741471461713200.davem__42346.5760577985$1533746603$gmane$org@davemloft.net>
References: <1533699784-4950-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1533699784-4950-1-git-send-email-jasowang@redhat.com>
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
Cc: netdev@vger.kernel.org, virtualization@lists.linux-foundation.org, linux-kernel@vger.kernel.org, kvm@vger.kernel.org, mst@redhat.com
List-Id: virtualization@lists.linuxfoundation.org

From: Jason Wang <jasowang@redhat.com>
Date: Wed,  8 Aug 2018 11:43:04 +0800

> We need to reset metadata cache during new IOTLB initialization,
> otherwise the stale pointers to previous IOTLB may be still accessed
> which will lead a use after free.
> 
> Reported-by: syzbot+c51e6736a1bf614b3272@syzkaller.appspotmail.com
> Fixes: f88949138058 ("vhost: introduce O(1) vq metadata cache")
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied and queued up for -stable, thanks Jason.
