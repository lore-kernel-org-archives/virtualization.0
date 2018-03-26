From: David Miller <davem@davemloft.net>
Subject: Re: [PATCH net] vhost_net: add missing lock nesting notation
Date: Mon, 26 Mar 2018 12:59:33 -0400 (EDT)
Message-ID: <20180326.125933.76259382836188471.davem__466.476116753434$1522083479$gmane$org@davemloft.net>
References: <1522051823-5166-1-git-send-email-jasowang@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <virtualization-bounces@lists.linux-foundation.org>
In-Reply-To: <1522051823-5166-1-git-send-email-jasowang@redhat.com>
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
Date: Mon, 26 Mar 2018 16:10:23 +0800

> We try to hold TX virtqueue mutex in vhost_net_rx_peek_head_len()
> after RX virtqueue mutex is held in handle_rx(). This requires an
> appropriate lock nesting notation to calm down deadlock detector.
> 
> Fixes: 0308813724606 ("vhost_net: basic polling support")
> Reported-by: syzbot+7f073540b1384a614e09@syzkaller.appspotmail.com
> Signed-off-by: Jason Wang <jasowang@redhat.com>

Applied and queued up for -stable, thanks Jason.
